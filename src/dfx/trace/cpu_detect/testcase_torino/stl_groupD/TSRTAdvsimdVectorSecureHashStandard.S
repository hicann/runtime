.global TSRTAdvsimdVectorSecureHashStandard

.text
.p2align 4

TSRTAdvsimdVectorSecureHashStandard:

TSRTAdvsimdVectorSecureHashStandard_TestBegin:
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
    MOVZ  X2, #0xb84c, LSL #0
    MOVK  X2, #0xa4e, LSL #16
    MOVK  X2, #0x190d, LSL #32
    MOVK  X2, #0xc226, LSL #48
    MOVZ  X3, #0x2f92, LSL #0
    MOVK  X3, #0xc0bd, LSL #16
    MOVK  X3, #0x807d, LSL #32
    MOVK  X3, #0x4ec5, LSL #48
    MOVZ  X4, #0x5b2c, LSL #0
    MOVK  X4, #0xf9b6, LSL #16
    MOVK  X4, #0x4a33, LSL #32
    MOVK  X4, #0x78f1, LSL #48
    MOVZ  X5, #0x6f7d, LSL #0
    MOVK  X5, #0x5369, LSL #16
    MOVK  X5, #0x2f69, LSL #32
    MOVK  X5, #0xd5b6, LSL #48
    MOVZ  X6, #0xc8af, LSL #0
    MOVK  X6, #0x70de, LSL #16
    MOVK  X6, #0x4578, LSL #32
    MOVK  X6, #0x56f0, LSL #48
    MOVZ  X7, #0xaa64, LSL #0
    MOVK  X7, #0x4c43, LSL #16
    MOVK  X7, #0x63cb, LSL #32
    MOVK  X7, #0x2aa, LSL #48
    MOVZ  X8, #0x8c56, LSL #0
    MOVK  X8, #0x5832, LSL #16
    MOVK  X8, #0x635c, LSL #32
    MOVK  X8, #0xac44, LSL #48
    MOVZ  X9, #0xb111, LSL #0
    MOVK  X9, #0xe5a0, LSL #16
    MOVK  X9, #0xa764, LSL #32
    MOVK  X9, #0x76ef, LSL #48
    MOVZ  X10, #0x3d72, LSL #0
    MOVK  X10, #0xfd9b, LSL #16
    MOVK  X10, #0x3b70, LSL #32
    MOVK  X10, #0x5fa2, LSL #48
    MOVZ  X11, #0x4ed4, LSL #0
    MOVK  X11, #0xffa5, LSL #16
    MOVK  X11, #0x4449, LSL #32
    MOVK  X11, #0xe1ae, LSL #48
    MOVZ  X12, #0xdc94, LSL #0
    MOVK  X12, #0xb486, LSL #16
    MOVK  X12, #0x1a97, LSL #32
    MOVK  X12, #0x8f7c, LSL #48
    MOVZ  X13, #0xb260, LSL #0
    MOVK  X13, #0x7467, LSL #16
    MOVK  X13, #0xf935, LSL #32
    MOVK  X13, #0x371a, LSL #48
    MOVZ  X14, #0xdbeb, LSL #0
    MOVK  X14, #0x204d, LSL #16
    MOVK  X14, #0xaff7, LSL #32
    MOVK  X14, #0x230f, LSL #48
    MOVZ  X15, #0x2266, LSL #0
    MOVK  X15, #0x5a9a, LSL #16
    MOVK  X15, #0x517f, LSL #32
    MOVK  X15, #0x6c75, LSL #48
    MOVZ  X16, #0xc92e, LSL #0
    MOVK  X16, #0x8572, LSL #16
    MOVK  X16, #0xa53b, LSL #32
    MOVK  X16, #0xfad6, LSL #48
    MOVZ  X17, #0xed1f, LSL #0
    MOVK  X17, #0x88ec, LSL #16
    MOVK  X17, #0xee4d, LSL #32
    MOVK  X17, #0x7f1f, LSL #48
    MOVZ  X23, #0xea1f, LSL #0
    MOVK  X23, #0x6849, LSL #16
    MOVK  X23, #0xc01b, LSL #32
    MOVK  X23, #0xd109, LSL #48
    MOVZ  X24, #0xca56, LSL #0
    MOVK  X24, #0xd7d4, LSL #16
    MOVK  X24, #0xcdf9, LSL #32
    MOVK  X24, #0x60ec, LSL #48
    MOVZ  X25, #0xeef5, LSL #0
    MOVK  X25, #0x7d, LSL #16
    MOVK  X25, #0xcbfd, LSL #32
    MOVK  X25, #0xd215, LSL #48
    MOVZ  X26, #0x9f8a, LSL #0
    MOVK  X26, #0xc425, LSL #16
    MOVK  X26, #0x3ec, LSL #32
    MOVK  X26, #0xa6b8, LSL #48
    MOVZ  X27, #0x980a, LSL #0
    MOVK  X27, #0xaf91, LSL #16
    MOVK  X27, #0x70fa, LSL #32
    MOVK  X27, #0x32b8, LSL #48
    MOVZ  X28, #0x6180, LSL #0
    MOVK  X28, #0xd6d0, LSL #16
    MOVK  X28, #0x7e65, LSL #32
    MOVK  X28, #0xa6e5, LSL #48
    MOVZ  X29, #0xe0b, LSL #0
    MOVK  X29, #0x4513, LSL #16
    MOVK  X29, #0x884f, LSL #32
    MOVK  X29, #0xf563, LSL #48
    MOVZ  X24, #0x983e, LSL #0
    MOVK  X24, #0xbe7b, LSL #16
    MOVK  X24, #0xd6b7, LSL #32
    MOVK  X24, #0x8a5d, LSL #48
    MSR  FPCR, X24
    MRS  X14, FPCR
    MOVZ  X4, #0x60ff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    AND  X14, X14, X4
    MOVZ  X4, #0x0, LSL #0
    ORR  X14, X14, X4
    MSR  FPCR, X14
    ISB  SY
    MOVZ  X24, #0xb9d0, LSL #0
    MOVK  X24, #0x968c, LSL #16
    MOVK  X24, #0xcabb, LSL #32
    MOVK  X24, #0x5c7d, LSL #48
    MSR  FPSR, X24
    MRS  X6, FPSR
    MOVZ  X14, #0xff60, LSL #0
    MOVK  X14, #0x7ff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    AND  X6, X6, X14
    MOVZ  X14, #0x0, LSL #0
    ORR  X6, X6, X14
    MSR  FPSR, X6
    ISB  SY
    ADDS  X13, X10, #0x247, LSL #12
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x551d, LSL #0
    MOVK  X2, #0xa8b3, LSL #16
    MOVK  X2, #0x634a, LSL #32
    MOVK  X2, #0x8e6c, LSL #48
    MOVZ  X3, #0xcc3b, LSL #0
    MOVK  X3, #0x1d92, LSL #16
    MOVK  X3, #0x4eaa, LSL #32
    MOVK  X3, #0x78ce, LSL #48
    MOVZ  X4, #0x3193, LSL #0
    MOVK  X4, #0x8453, LSL #16
    MOVK  X4, #0x44b1, LSL #32
    MOVK  X4, #0xd0ab, LSL #48
    MOVZ  X5, #0x8f1e, LSL #0
    MOVK  X5, #0xbbd5, LSL #16
    MOVK  X5, #0x7b24, LSL #32
    MOVK  X5, #0xd969, LSL #48
    MOVZ  X6, #0x86c2, LSL #0
    MOVK  X6, #0x6394, LSL #16
    MOVK  X6, #0xa938, LSL #32
    MOVK  X6, #0xe201, LSL #48
    MOVZ  X7, #0xa0e9, LSL #0
    MOVK  X7, #0x677c, LSL #16
    MOVK  X7, #0x436e, LSL #32
    MOVK  X7, #0x66af, LSL #48
    MOVZ  X8, #0xfae3, LSL #0
    MOVK  X8, #0xff10, LSL #16
    MOVK  X8, #0x1941, LSL #32
    MOVK  X8, #0x9fbb, LSL #48
    MOVZ  X9, #0xe94c, LSL #0
    MOVK  X9, #0xd40, LSL #16
    MOVK  X9, #0x45d2, LSL #32
    MOVK  X9, #0x63bd, LSL #48
    MOVZ  X10, #0xc1c7, LSL #0
    MOVK  X10, #0xfcfc, LSL #16
    MOVK  X10, #0xa0e7, LSL #32
    MOVK  X10, #0x9be2, LSL #48
    MOVZ  X11, #0x56a0, LSL #0
    MOVK  X11, #0xfa0, LSL #16
    MOVK  X11, #0x1680, LSL #32
    MOVK  X11, #0xd086, LSL #48
    MOVZ  X12, #0x203b, LSL #0
    MOVK  X12, #0x7deb, LSL #16
    MOVK  X12, #0xa61b, LSL #32
    MOVK  X12, #0x833f, LSL #48
    MOVZ  X13, #0x4ba9, LSL #0
    MOVK  X13, #0x6e25, LSL #16
    MOVK  X13, #0xce42, LSL #32
    MOVK  X13, #0xfc8c, LSL #48
    MOVZ  X14, #0x1092, LSL #0
    MOVK  X14, #0x82e9, LSL #16
    MOVK  X14, #0x70d9, LSL #32
    MOVK  X14, #0xdbc7, LSL #48
    MOVZ  X15, #0xaf95, LSL #0
    MOVK  X15, #0xab5d, LSL #16
    MOVK  X15, #0x4ad0, LSL #32
    MOVK  X15, #0xe8f0, LSL #48
    MOVZ  X16, #0x42fd, LSL #0
    MOVK  X16, #0x9cc1, LSL #16
    MOVK  X16, #0xc6b1, LSL #32
    MOVK  X16, #0x9368, LSL #48
    MOVZ  X17, #0xf47, LSL #0
    MOVK  X17, #0xf802, LSL #16
    MOVK  X17, #0xe7ab, LSL #32
    MOVK  X17, #0x6e83, LSL #48
    MOVZ  X23, #0xe30f, LSL #0
    MOVK  X23, #0x4e1c, LSL #16
    MOVK  X23, #0x83ac, LSL #32
    MOVK  X23, #0x757d, LSL #48
    MOVZ  X24, #0xc0, LSL #0
    MOVK  X24, #0xb43b, LSL #16
    MOVK  X24, #0xf865, LSL #32
    MOVK  X24, #0x888b, LSL #48
    MOVZ  X25, #0xfe06, LSL #0
    MOVK  X25, #0x98d5, LSL #16
    MOVK  X25, #0x2ca3, LSL #32
    MOVK  X25, #0x6f1f, LSL #48
    MOVZ  X26, #0x495f, LSL #0
    MOVK  X26, #0x608, LSL #16
    MOVK  X26, #0x7f4f, LSL #32
    MOVK  X26, #0x8f95, LSL #48
    MOVZ  X27, #0xf0f0, LSL #0
    MOVK  X27, #0xe545, LSL #16
    MOVK  X27, #0x25e2, LSL #32
    MOVK  X27, #0xac33, LSL #48
    MOVZ  X28, #0x7411, LSL #0
    MOVK  X28, #0x26d3, LSL #16
    MOVK  X28, #0x63e2, LSL #32
    MOVK  X28, #0xbad8, LSL #48
    MOVZ  X29, #0x9a4e, LSL #0
    MOVK  X29, #0x2b14, LSL #16
    MOVK  X29, #0x7cc2, LSL #32
    MOVK  X29, #0xa1e4, LSL #48
    FMOV  D0, X14
    FMOV  V0.D[1], X27
    FMOV  D1, X26
    FMOV  V1.D[1], X29
    FMOV  D2, X28
    FMOV  V2.D[1], X13
    FMOV  D3, X28
    FMOV  V3.D[1], X7
    FMOV  D4, X28
    FMOV  V4.D[1], X25
    FMOV  D5, X25
    FMOV  V5.D[1], X25
    FMOV  D6, X28
    FMOV  V6.D[1], X15
    FMOV  D7, X10
    FMOV  V7.D[1], X3
    FMOV  D8, X12
    FMOV  V8.D[1], X4
    FMOV  D9, X24
    FMOV  V9.D[1], X8
    FMOV  D10, X25
    FMOV  V10.D[1], X11
    FMOV  D11, X24
    FMOV  V11.D[1], X6
    FMOV  D12, X5
    FMOV  V12.D[1], X3
    FMOV  D13, X11
    FMOV  V13.D[1], X25
    FMOV  D14, X5
    FMOV  V14.D[1], X28
    FMOV  D15, X11
    FMOV  V15.D[1], X26
    FMOV  D16, X15
    FMOV  V16.D[1], X7
    FMOV  D17, X17
    FMOV  V17.D[1], X29
    FMOV  D18, X23
    FMOV  V18.D[1], X17
    FMOV  D19, X24
    FMOV  V19.D[1], X7
    FMOV  D20, X5
    FMOV  V20.D[1], X8
    FMOV  D21, X23
    FMOV  V21.D[1], X13
    FMOV  D22, X5
    FMOV  V22.D[1], X16
    FMOV  D23, X2
    FMOV  V23.D[1], X2
    FMOV  D24, X26
    FMOV  V24.D[1], X27
    FMOV  D25, X5
    FMOV  V25.D[1], X27
    FMOV  D26, X11
    FMOV  V26.D[1], X8
    FMOV  D27, X3
    FMOV  V27.D[1], X4
    FMOV  D28, X5
    FMOV  V28.D[1], X25
    FMOV  D29, X24
    FMOV  V29.D[1], X17
    FMOV  D30, X7
    FMOV  V30.D[1], X13
    FMOV  D31, X29
    FMOV  V31.D[1], X25
    SHA1C  Q21, S20, V25.4S
    SHA1C  Q11, S18, V27.4S
    SHA1C  Q15, S9, V11.4S
    SHA1C  Q27, S19, V14.4S
    SHA1C  Q18, S27, V26.4S
    SHA1C  Q3, S21, V31.4S
    SHA1C  Q6, S18, V6.4S
    SHA1C  Q6, S30, V30.4S
    SHA1C  Q9, S28, V26.4S
    SHA1C  Q15, S3, V2.4S
    SHA1M  Q0, S10, V24.4S
    SHA1M  Q2, S14, V17.4S
    SHA1M  Q20, S15, V29.4S
    SHA1M  Q25, S6, V5.4S
    SHA1M  Q28, S2, V20.4S
    SHA1M  Q10, S25, V21.4S
    SHA1M  Q21, S9, V14.4S
    SHA1M  Q26, S28, V0.4S
    SHA1M  Q20, S4, V26.4S
    SHA1M  Q24, S30, V21.4S
    SHA1P  Q4, S10, V20.4S
    SHA1P  Q26, S2, V6.4S
    SHA1P  Q14, S18, V7.4S
    SHA1P  Q5, S11, V13.4S
    SHA1P  Q19, S16, V8.4S
    SHA1P  Q9, S27, V16.4S
    SHA1P  Q25, S8, V2.4S
    SHA1P  Q0, S5, V22.4S
    SHA1P  Q2, S26, V16.4S
    SHA1P  Q1, S8, V15.4S
    SHA1SU0  V16.4S, V14.4S, V24.4S
    SHA1SU0  V29.4S, V0.4S, V14.4S
    SHA1SU0  V22.4S, V9.4S, V18.4S
    SHA1SU0  V28.4S, V1.4S, V29.4S
    SHA1SU0  V8.4S, V18.4S, V17.4S
    SHA1SU0  V26.4S, V16.4S, V6.4S
    SHA1SU0  V10.4S, V26.4S, V28.4S
    SHA1SU0  V17.4S, V13.4S, V22.4S
    SHA1SU0  V20.4S, V10.4S, V19.4S
    SHA1SU0  V19.4S, V25.4S, V17.4S
    SHA1SU1  V6.4S, V8.4S
    SHA1SU1  V26.4S, V6.4S
    SHA1SU1  V5.4S, V19.4S
    SHA1SU1  V18.4S, V5.4S
    SHA1SU1  V13.4S, V18.4S
    SHA1SU1  V27.4S, V13.4S
    SHA1SU1  V28.4S, V31.4S
    SHA1SU1  V1.4S, V20.4S
    SHA1SU1  V16.4S, V28.4S
    SHA1SU1  V9.4S, V20.4S
    SHA256H  Q19, Q22, V26.4S
    SHA256H  Q6, Q27, V16.4S
    SHA256H  Q29, Q24, V1.4S
    SHA256H  Q10, Q29, V16.4S
    SHA256H  Q15, Q14, V9.4S
    SHA256H  Q27, Q15, V4.4S
    SHA256H  Q29, Q6, V10.4S
    SHA256H  Q9, Q29, V2.4S
    SHA256H  Q6, Q26, V19.4S
    SHA256H  Q18, Q27, V9.4S
    SHA256H2  Q10, Q21, V7.4S
    SHA256H2  Q28, Q3, V12.4S
    SHA256H2  Q11, Q23, V5.4S
    SHA256H2  Q4, Q16, V28.4S
    SHA256H2  Q15, Q29, V21.4S
    SHA256H2  Q5, Q15, V10.4S
    SHA256H2  Q22, Q10, V16.4S
    SHA256H2  Q6, Q15, V28.4S
    SHA256H2  Q20, Q29, V18.4S
    SHA256H2  Q2, Q11, V8.4S
    SHA256SU0  V27.4S, V31.4S
    SHA256SU0  V26.4S, V15.4S
    SHA256SU0  V14.4S, V5.4S
    SHA256SU0  V12.4S, V6.4S
    SHA256SU0  V18.4S, V0.4S
    SHA256SU0  V21.4S, V4.4S
    SHA256SU0  V5.4S, V27.4S
    SHA256SU0  V3.4S, V14.4S
    SHA256SU0  V16.4S, V18.4S
    SHA256SU0  V10.4S, V2.4S
    SHA256SU1  V6.4S, V16.4S, V5.4S
    SHA256SU1  V31.4S, V22.4S, V3.4S
    SHA256SU1  V4.4S, V12.4S, V26.4S
    SHA256SU1  V27.4S, V21.4S, V31.4S
    SHA256SU1  V15.4S, V27.4S, V10.4S
    SHA256SU1  V26.4S, V6.4S, V20.4S
    SHA256SU1  V2.4S, V28.4S, V18.4S
    SHA256SU1  V28.4S, V4.4S, V8.4S
    SHA256SU1  V23.4S, V13.4S, V28.4S
    SHA256SU1  V13.4S, V17.4S, V7.4S
    MOVZ  X14, #0x551d, LSL #0
    MOVK  X14, #0xa8b3, LSL #16
    MOVK  X14, #0x634a, LSL #32
    MOVK  X14, #0x8e6c, LSL #48
    SUB  X6, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0xcc3b, LSL #0
    MOVK  X14, #0x1d92, LSL #16
    MOVK  X14, #0x4eaa, LSL #32
    MOVK  X14, #0x78ce, LSL #48
    SUB  X6, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0x3193, LSL #0
    MOVK  X14, #0x8453, LSL #16
    MOVK  X14, #0x44b1, LSL #32
    MOVK  X14, #0xd0ab, LSL #48
    SUB  X6, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0x8f1e, LSL #0
    MOVK  X14, #0xbbd5, LSL #16
    MOVK  X14, #0x7b24, LSL #32
    MOVK  X14, #0xd969, LSL #48
    SUB  X6, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0xa0e9, LSL #0
    MOVK  X14, #0x677c, LSL #16
    MOVK  X14, #0x436e, LSL #32
    MOVK  X14, #0x66af, LSL #48
    SUB  X6, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0xfae3, LSL #0
    MOVK  X14, #0xff10, LSL #16
    MOVK  X14, #0x1941, LSL #32
    MOVK  X14, #0x9fbb, LSL #48
    SUB  X6, X14, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0xe94c, LSL #0
    MOVK  X14, #0xd40, LSL #16
    MOVK  X14, #0x45d2, LSL #32
    MOVK  X14, #0x63bd, LSL #48
    SUB  X6, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0x56a0, LSL #0
    MOVK  X14, #0xfa0, LSL #16
    MOVK  X14, #0x1680, LSL #32
    MOVK  X14, #0xd086, LSL #48
    SUB  X6, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0x203b, LSL #0
    MOVK  X14, #0x7deb, LSL #16
    MOVK  X14, #0xa61b, LSL #32
    MOVK  X14, #0x833f, LSL #48
    SUB  X6, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0x4ba9, LSL #0
    MOVK  X14, #0x6e25, LSL #16
    MOVK  X14, #0xce42, LSL #32
    MOVK  X14, #0xfc8c, LSL #48
    SUB  X6, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0xaf95, LSL #0
    MOVK  X14, #0xab5d, LSL #16
    MOVK  X14, #0x4ad0, LSL #32
    MOVK  X14, #0xe8f0, LSL #48
    SUB  X6, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0x42fd, LSL #0
    MOVK  X14, #0x9cc1, LSL #16
    MOVK  X14, #0xc6b1, LSL #32
    MOVK  X14, #0x9368, LSL #48
    SUB  X6, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0xf47, LSL #0
    MOVK  X14, #0xf802, LSL #16
    MOVK  X14, #0xe7ab, LSL #32
    MOVK  X14, #0x6e83, LSL #48
    SUB  X6, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0xe30f, LSL #0
    MOVK  X14, #0x4e1c, LSL #16
    MOVK  X14, #0x83ac, LSL #32
    MOVK  X14, #0x757d, LSL #48
    SUB  X6, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0xc0, LSL #0
    MOVK  X14, #0xb43b, LSL #16
    MOVK  X14, #0xf865, LSL #32
    MOVK  X14, #0x888b, LSL #48
    SUB  X6, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0xfe06, LSL #0
    MOVK  X14, #0x98d5, LSL #16
    MOVK  X14, #0x2ca3, LSL #32
    MOVK  X14, #0x6f1f, LSL #48
    SUB  X6, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0x495f, LSL #0
    MOVK  X14, #0x608, LSL #16
    MOVK  X14, #0x7f4f, LSL #32
    MOVK  X14, #0x8f95, LSL #48
    SUB  X6, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0xf0f0, LSL #0
    MOVK  X14, #0xe545, LSL #16
    MOVK  X14, #0x25e2, LSL #32
    MOVK  X14, #0xac33, LSL #48
    SUB  X6, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0x7411, LSL #0
    MOVK  X14, #0x26d3, LSL #16
    MOVK  X14, #0x63e2, LSL #32
    MOVK  X14, #0xbad8, LSL #48
    SUB  X6, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0x9a4e, LSL #0
    MOVK  X14, #0x2b14, LSL #16
    MOVK  X14, #0x7cc2, LSL #32
    MOVK  X14, #0xa1e4, LSL #48
    SUB  X6, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MRS  X14, FPSR
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V0.D[1]
    MOVZ  X6, #0x417e, LSL #0
    MOVK  X6, #0x68cb, LSL #16
    MOVK  X6, #0x3c7, LSL #32
    MOVK  X6, #0x78eb, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D0
    MOVZ  X6, #0xab07, LSL #0
    MOVK  X6, #0xab3f, LSL #16
    MOVK  X6, #0x2e1, LSL #32
    MOVK  X6, #0x5cb7, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V1.D[1]
    MOVZ  X6, #0xf41e, LSL #0
    MOVK  X6, #0xee67, LSL #16
    MOVK  X6, #0x1a3a, LSL #32
    MOVK  X6, #0xc4d1, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D1
    MOVZ  X6, #0xaa12, LSL #0
    MOVK  X6, #0x8e8b, LSL #16
    MOVK  X6, #0xb82e, LSL #32
    MOVK  X6, #0x2281, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X6, #0x7863, LSL #0
    MOVK  X6, #0x9fe6, LSL #16
    MOVK  X6, #0x6c9e, LSL #32
    MOVK  X6, #0x897e, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D2
    MOVZ  X6, #0x7ccc, LSL #0
    MOVK  X6, #0xb79d, LSL #16
    MOVK  X6, #0xa395, LSL #32
    MOVK  X6, #0x5fb9, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X6, #0x14dc, LSL #0
    MOVK  X6, #0x9d02, LSL #16
    MOVK  X6, #0xa35d, LSL #32
    MOVK  X6, #0xa157, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D3
    MOVZ  X6, #0xe30f, LSL #0
    MOVK  X6, #0xdbdf, LSL #16
    MOVK  X6, #0x7cdd, LSL #32
    MOVK  X6, #0x24ca, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X6, #0x4754, LSL #0
    MOVK  X6, #0xcaa3, LSL #16
    MOVK  X6, #0x8484, LSL #32
    MOVK  X6, #0x636d, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D4
    MOVZ  X6, #0xfc44, LSL #0
    MOVK  X6, #0xb4a8, LSL #16
    MOVK  X6, #0x8174, LSL #32
    MOVK  X6, #0x8c5e, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X6, #0xb692, LSL #0
    MOVK  X6, #0x1689, LSL #16
    MOVK  X6, #0x649d, LSL #32
    MOVK  X6, #0x81e0, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D5
    MOVZ  X6, #0xce05, LSL #0
    MOVK  X6, #0x3f09, LSL #16
    MOVK  X6, #0xa432, LSL #32
    MOVK  X6, #0x5200, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X6, #0x3963, LSL #0
    MOVK  X6, #0x8393, LSL #16
    MOVK  X6, #0x3689, LSL #32
    MOVK  X6, #0x9270, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D6
    MOVZ  X6, #0x815f, LSL #0
    MOVK  X6, #0xf437, LSL #16
    MOVK  X6, #0xf0d2, LSL #32
    MOVK  X6, #0x3e9f, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X6, #0xcc3b, LSL #0
    MOVK  X6, #0x1d92, LSL #16
    MOVK  X6, #0x4eaa, LSL #32
    MOVK  X6, #0x78ce, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D7
    MOVZ  X6, #0xc1c7, LSL #0
    MOVK  X6, #0xfcfc, LSL #16
    MOVK  X6, #0xa0e7, LSL #32
    MOVK  X6, #0x9be2, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X6, #0xb69a, LSL #0
    MOVK  X6, #0x2c34, LSL #16
    MOVK  X6, #0xabe1, LSL #32
    MOVK  X6, #0xa81c, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D8
    MOVZ  X6, #0x1eef, LSL #0
    MOVK  X6, #0x1ba, LSL #16
    MOVK  X6, #0x501, LSL #32
    MOVK  X6, #0x3d17, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X6, #0x2f69, LSL #0
    MOVK  X6, #0x8727, LSL #16
    MOVK  X6, #0x5948, LSL #32
    MOVK  X6, #0x405c, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D9
    MOVZ  X6, #0xb52f, LSL #0
    MOVK  X6, #0xb25b, LSL #16
    MOVK  X6, #0xfa31, LSL #32
    MOVK  X6, #0x8707, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X6, #0x2e93, LSL #0
    MOVK  X6, #0xa87e, LSL #16
    MOVK  X6, #0xdb41, LSL #32
    MOVK  X6, #0xd941, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D10
    MOVZ  X6, #0x9c8f, LSL #0
    MOVK  X6, #0xd96b, LSL #16
    MOVK  X6, #0x673b, LSL #32
    MOVK  X6, #0xeabc, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X6, #0xb74e, LSL #0
    MOVK  X6, #0x3504, LSL #16
    MOVK  X6, #0x8ed7, LSL #32
    MOVK  X6, #0xcf2f, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D11
    MOVZ  X6, #0xdf10, LSL #0
    MOVK  X6, #0xccb8, LSL #16
    MOVK  X6, #0x792d, LSL #32
    MOVK  X6, #0xb37a, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X6, #0x97b6, LSL #0
    MOVK  X6, #0xe5d5, LSL #16
    MOVK  X6, #0x5a39, LSL #32
    MOVK  X6, #0x2ac, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D12
    MOVZ  X6, #0x5ae6, LSL #0
    MOVK  X6, #0xc82c, LSL #16
    MOVK  X6, #0x369f, LSL #32
    MOVK  X6, #0x9ff1, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X6, #0xf7ef, LSL #0
    MOVK  X6, #0xa4b2, LSL #16
    MOVK  X6, #0xc5e1, LSL #32
    MOVK  X6, #0x3d36, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D13
    MOVZ  X6, #0xb60b, LSL #0
    MOVK  X6, #0x8d75, LSL #16
    MOVK  X6, #0xfbf0, LSL #32
    MOVK  X6, #0xe487, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V14.D[1]
    MOVZ  X6, #0xfe7, LSL #0
    MOVK  X6, #0x6387, LSL #16
    MOVK  X6, #0x6e4b, LSL #32
    MOVK  X6, #0x6345, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D14
    MOVZ  X6, #0x5946, LSL #0
    MOVK  X6, #0xfb5, LSL #16
    MOVK  X6, #0x68c8, LSL #32
    MOVK  X6, #0x3982, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X6, #0xa21e, LSL #0
    MOVK  X6, #0x6a3, LSL #16
    MOVK  X6, #0xb0e2, LSL #32
    MOVK  X6, #0xd886, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D15
    MOVZ  X6, #0x1352, LSL #0
    MOVK  X6, #0xdae6, LSL #16
    MOVK  X6, #0xacc0, LSL #32
    MOVK  X6, #0x5700, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X6, #0xeca4, LSL #0
    MOVK  X6, #0x3a53, LSL #16
    MOVK  X6, #0xddf5, LSL #32
    MOVK  X6, #0xd977, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D16
    MOVZ  X6, #0xb2c3, LSL #0
    MOVK  X6, #0x6cec, LSL #16
    MOVK  X6, #0x6e80, LSL #32
    MOVK  X6, #0x921f, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X6, #0xc360, LSL #0
    MOVK  X6, #0x87db, LSL #16
    MOVK  X6, #0xca70, LSL #32
    MOVK  X6, #0x7fa9, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D17
    MOVZ  X6, #0x45ad, LSL #0
    MOVK  X6, #0x7771, LSL #16
    MOVK  X6, #0xb56e, LSL #32
    MOVK  X6, #0x5c35, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X6, #0x461d, LSL #0
    MOVK  X6, #0x81fd, LSL #16
    MOVK  X6, #0x1c4c, LSL #32
    MOVK  X6, #0x773a, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D18
    MOVZ  X6, #0xfaf5, LSL #0
    MOVK  X6, #0xb0e6, LSL #16
    MOVK  X6, #0xb2de, LSL #32
    MOVK  X6, #0xb614, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X6, #0xa961, LSL #0
    MOVK  X6, #0x3343, LSL #16
    MOVK  X6, #0xf996, LSL #32
    MOVK  X6, #0xc9f8, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D19
    MOVZ  X6, #0x295d, LSL #0
    MOVK  X6, #0x7e29, LSL #16
    MOVK  X6, #0xf562, LSL #32
    MOVK  X6, #0x6777, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X6, #0x4714, LSL #0
    MOVK  X6, #0x22c, LSL #16
    MOVK  X6, #0x59a7, LSL #32
    MOVK  X6, #0xbc2e, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D20
    MOVZ  X6, #0x2ae6, LSL #0
    MOVK  X6, #0xd2b7, LSL #16
    MOVK  X6, #0xa0ae, LSL #32
    MOVK  X6, #0xf12f, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X6, #0x29b4, LSL #0
    MOVK  X6, #0xe0b5, LSL #16
    MOVK  X6, #0xc1fd, LSL #32
    MOVK  X6, #0x5840, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D21
    MOVZ  X6, #0xeb6e, LSL #0
    MOVK  X6, #0xbe21, LSL #16
    MOVK  X6, #0x7a60, LSL #32
    MOVK  X6, #0xc97d, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X6, #0xc9cc, LSL #0
    MOVK  X6, #0xf65, LSL #16
    MOVK  X6, #0x4559, LSL #32
    MOVK  X6, #0x63f8, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D22
    MOVZ  X6, #0x7348, LSL #0
    MOVK  X6, #0x7063, LSL #16
    MOVK  X6, #0x29a8, LSL #32
    MOVK  X6, #0xcece, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X6, #0x6d90, LSL #0
    MOVK  X6, #0x5992, LSL #16
    MOVK  X6, #0xd400, LSL #32
    MOVK  X6, #0x263, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D23
    MOVZ  X6, #0x78ed, LSL #0
    MOVK  X6, #0x3d6a, LSL #16
    MOVK  X6, #0xc38e, LSL #32
    MOVK  X6, #0xf469, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X6, #0x151e, LSL #0
    MOVK  X6, #0x324c, LSL #16
    MOVK  X6, #0xc343, LSL #32
    MOVK  X6, #0xdc11, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D24
    MOVZ  X6, #0xb29d, LSL #0
    MOVK  X6, #0xe13d, LSL #16
    MOVK  X6, #0x401d, LSL #32
    MOVK  X6, #0x608f, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X6, #0x6568, LSL #0
    MOVK  X6, #0xadee, LSL #16
    MOVK  X6, #0x81e5, LSL #32
    MOVK  X6, #0xdf7, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D25
    MOVZ  X6, #0x139b, LSL #0
    MOVK  X6, #0x98d5, LSL #16
    MOVK  X6, #0xc383, LSL #32
    MOVK  X6, #0xff30, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X6, #0x3621, LSL #0
    MOVK  X6, #0x6a85, LSL #16
    MOVK  X6, #0xb30e, LSL #32
    MOVK  X6, #0x17c3, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D26
    MOVZ  X6, #0x6ade, LSL #0
    MOVK  X6, #0x2027, LSL #16
    MOVK  X6, #0x2708, LSL #32
    MOVK  X6, #0x74a4, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X6, #0xf4b3, LSL #0
    MOVK  X6, #0xc028, LSL #16
    MOVK  X6, #0xe43b, LSL #32
    MOVK  X6, #0xc391, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D27
    MOVZ  X6, #0x3d64, LSL #0
    MOVK  X6, #0xcd88, LSL #16
    MOVK  X6, #0x7157, LSL #32
    MOVK  X6, #0xdfe, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X6, #0x5bbf, LSL #0
    MOVK  X6, #0x538, LSL #16
    MOVK  X6, #0xb1eb, LSL #32
    MOVK  X6, #0x537b, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D28
    MOVZ  X6, #0xb1ed, LSL #0
    MOVK  X6, #0x9a6b, LSL #16
    MOVK  X6, #0xa18a, LSL #32
    MOVK  X6, #0x7192, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X6, #0x6343, LSL #0
    MOVK  X6, #0xbfd8, LSL #16
    MOVK  X6, #0xccc1, LSL #32
    MOVK  X6, #0xe3cc, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D29
    MOVZ  X6, #0xd62c, LSL #0
    MOVK  X6, #0x2282, LSL #16
    MOVK  X6, #0xde2d, LSL #32
    MOVK  X6, #0x9ef0, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V30.D[1]
    MOVZ  X6, #0x4ba9, LSL #0
    MOVK  X6, #0x6e25, LSL #16
    MOVK  X6, #0xce42, LSL #32
    MOVK  X6, #0xfc8c, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D30
    MOVZ  X6, #0xa0e9, LSL #0
    MOVK  X6, #0x677c, LSL #16
    MOVK  X6, #0x436e, LSL #32
    MOVK  X6, #0x66af, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V31.D[1]
    MOVZ  X6, #0x7b3, LSL #0
    MOVK  X6, #0x19bd, LSL #16
    MOVK  X6, #0xec52, LSL #32
    MOVK  X6, #0xa02f, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D31
    MOVZ  X6, #0x619a, LSL #0
    MOVK  X6, #0x42b5, LSL #16
    MOVK  X6, #0x77f7, LSL #32
    MOVK  X6, #0xd737, LSL #48
    SUB  X10, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X2, #0x46d5, LSL #0
    MOVK  X2, #0x7147, LSL #16
    MOVK  X2, #0xf9cb, LSL #32
    MOVK  X2, #0x7749, LSL #48
    MOVZ  X3, #0x76f5, LSL #0
    MOVK  X3, #0x83a5, LSL #16
    MOVK  X3, #0xf6b2, LSL #32
    MOVK  X3, #0x2c50, LSL #48
    MOVZ  X4, #0x6c89, LSL #0
    MOVK  X4, #0x4e96, LSL #16
    MOVK  X4, #0x30c2, LSL #32
    MOVK  X4, #0x1db1, LSL #48
    MOVZ  X5, #0x941a, LSL #0
    MOVK  X5, #0x74c3, LSL #16
    MOVK  X5, #0x7ee9, LSL #32
    MOVK  X5, #0x7996, LSL #48
    MOVZ  X6, #0xdef6, LSL #0
    MOVK  X6, #0x5de3, LSL #16
    MOVK  X6, #0x32a8, LSL #32
    MOVK  X6, #0xd479, LSL #48
    MOVZ  X7, #0x2b6c, LSL #0
    MOVK  X7, #0xad5a, LSL #16
    MOVK  X7, #0x8b2c, LSL #32
    MOVK  X7, #0x6a17, LSL #48
    MOVZ  X8, #0x721a, LSL #0
    MOVK  X8, #0x54f7, LSL #16
    MOVK  X8, #0x78ef, LSL #32
    MOVK  X8, #0x341b, LSL #48
    MOVZ  X9, #0x9725, LSL #0
    MOVK  X9, #0x6500, LSL #16
    MOVK  X9, #0xa5a9, LSL #32
    MOVK  X9, #0x71c8, LSL #48
    MOVZ  X10, #0x44f5, LSL #0
    MOVK  X10, #0xb226, LSL #16
    MOVK  X10, #0x54e6, LSL #32
    MOVK  X10, #0x7aaa, LSL #48
    MOVZ  X11, #0x3b8f, LSL #0
    MOVK  X11, #0x9507, LSL #16
    MOVK  X11, #0xb5d6, LSL #32
    MOVK  X11, #0x7c51, LSL #48
    MOVZ  X12, #0xb918, LSL #0
    MOVK  X12, #0xb0bf, LSL #16
    MOVK  X12, #0xbee1, LSL #32
    MOVK  X12, #0x7c1a, LSL #48
    MOVZ  X13, #0x2151, LSL #0
    MOVK  X13, #0xb77, LSL #16
    MOVK  X13, #0x2ac, LSL #32
    MOVK  X13, #0xbfb0, LSL #48
    MOVZ  X14, #0x8eb8, LSL #0
    MOVK  X14, #0xcb94, LSL #16
    MOVK  X14, #0x727, LSL #32
    MOVK  X14, #0x5634, LSL #48
    MOVZ  X15, #0x6930, LSL #0
    MOVK  X15, #0xcd41, LSL #16
    MOVK  X15, #0xe588, LSL #32
    MOVK  X15, #0x4aa7, LSL #48
    MOVZ  X16, #0x51dd, LSL #0
    MOVK  X16, #0x2794, LSL #16
    MOVK  X16, #0xf73, LSL #32
    MOVK  X16, #0xd573, LSL #48
    MOVZ  X17, #0x502, LSL #0
    MOVK  X17, #0x5c9b, LSL #16
    MOVK  X17, #0x5c64, LSL #32
    MOVK  X17, #0xb622, LSL #48
    MOVZ  X23, #0xa63d, LSL #0
    MOVK  X23, #0x841c, LSL #16
    MOVK  X23, #0x68a3, LSL #32
    MOVK  X23, #0x2d1e, LSL #48
    MOVZ  X24, #0x2d41, LSL #0
    MOVK  X24, #0x78a1, LSL #16
    MOVK  X24, #0x3c86, LSL #32
    MOVK  X24, #0x9d61, LSL #48
    MOVZ  X25, #0xbf92, LSL #0
    MOVK  X25, #0x7bdf, LSL #16
    MOVK  X25, #0xa5f4, LSL #32
    MOVK  X25, #0x37e3, LSL #48
    MOVZ  X26, #0x6cf, LSL #0
    MOVK  X26, #0x87b8, LSL #16
    MOVK  X26, #0xdf34, LSL #32
    MOVK  X26, #0x7f94, LSL #48
    MOVZ  X27, #0x7811, LSL #0
    MOVK  X27, #0x48d8, LSL #16
    MOVK  X27, #0x3cfc, LSL #32
    MOVK  X27, #0x8825, LSL #48
    MOVZ  X28, #0xcaf0, LSL #0
    MOVK  X28, #0xdeda, LSL #16
    MOVK  X28, #0x1708, LSL #32
    MOVK  X28, #0x3b0f, LSL #48
    MOVZ  X29, #0x2dd1, LSL #0
    MOVK  X29, #0x81b7, LSL #16
    MOVK  X29, #0x2869, LSL #32
    MOVK  X29, #0x5af6, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X26
    FMOV  D1, X23
    FMOV  V1.D[1], X29
    FMOV  D2, X24
    FMOV  V2.D[1], X16
    FMOV  D3, X26
    FMOV  V3.D[1], X28
    FMOV  D4, X16
    FMOV  V4.D[1], X15
    FMOV  D5, X24
    FMOV  V5.D[1], X26
    FMOV  D6, X15
    FMOV  V6.D[1], X29
    FMOV  D7, X5
    FMOV  V7.D[1], X25
    FMOV  D8, X5
    FMOV  V8.D[1], X3
    FMOV  D9, X8
    FMOV  V9.D[1], X3
    FMOV  D10, X25
    FMOV  V10.D[1], X13
    FMOV  D11, X26
    FMOV  V11.D[1], X8
    FMOV  D12, X16
    FMOV  V12.D[1], X4
    FMOV  D13, X11
    FMOV  V13.D[1], X16
    FMOV  D14, X4
    FMOV  V14.D[1], X27
    FMOV  D15, X27
    FMOV  V15.D[1], X2
    FMOV  D16, X23
    FMOV  V16.D[1], X8
    FMOV  D17, X11
    FMOV  V17.D[1], X17
    FMOV  D18, X2
    FMOV  V18.D[1], X8
    FMOV  D19, X9
    FMOV  V19.D[1], X29
    FMOV  D20, X27
    FMOV  V20.D[1], X11
    FMOV  D21, X15
    FMOV  V21.D[1], X24
    FMOV  D22, X8
    FMOV  V22.D[1], X4
    FMOV  D23, X29
    FMOV  V23.D[1], X12
    FMOV  D24, X5
    FMOV  V24.D[1], X23
    FMOV  D25, X16
    FMOV  V25.D[1], X8
    FMOV  D26, X2
    FMOV  V26.D[1], X27
    FMOV  D27, X24
    FMOV  V27.D[1], X8
    FMOV  D28, X17
    FMOV  V28.D[1], X4
    FMOV  D29, X13
    FMOV  V29.D[1], X17
    FMOV  D30, X14
    FMOV  V30.D[1], X8
    FMOV  D31, X5
    FMOV  V31.D[1], X29
    MOVZ  X2, #0xa, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_0:
    SHA1SU0  V18.4S, V31.4S, V30.4S
    SHA256SU1  V27.4S, V27.4S, V25.4S
    SHA256SU0  V9.4S, V15.4S
    SHA1SU0  V11.4S, V8.4S, V9.4S
    SHA1P  Q15, S28, V26.4S
    SHA256H  Q12, Q18, V29.4S
    SHA1C  Q3, S27, V31.4S
    SHA256SU0  V20.4S, V3.4S
    SHA1C  Q4, S11, V20.4S
    SHA1SU0  V28.4S, V5.4S, V24.4S
    SHA256SU1  V31.4S, V15.4S, V0.4S
    SHA1C  Q5, S28, V12.4S
    SHA1P  Q24, S8, V14.4S
    SHA256H2  Q8, Q1, V0.4S
    SHA1SU0  V15.4S, V25.4S, V5.4S
    SHA1C  Q30, S15, V24.4S
    SHA256H  Q30, Q3, V13.4S
    SHA256SU0  V3.4S, V15.4S
    SHA1C  Q15, S8, V30.4S
    SHA256SU1  V5.4S, V3.4S, V15.4S
    SHA256H2  Q11, Q31, V4.4S
    SHA1M  Q15, S18, V19.4S
    SHA1C  Q26, S16, V14.4S
    SHA1M  Q8, S5, V24.4S
    SHA1SU1  V12.4S, V26.4S
    SHA1C  Q17, S2, V3.4S
    SHA1C  Q28, S0, V0.4S
    SHA256SU0  V31.4S, V9.4S
    SHA256SU1  V3.4S, V23.4S, V9.4S
    SHA1SU1  V25.4S, V16.4S
    SHA1SU0  V9.4S, V8.4S, V22.4S
    SHA1C  Q0, S28, V25.4S
    SHA256H  Q23, Q12, V17.4S
    SHA1SU0  V4.4S, V9.4S, V13.4S
    SHA1M  Q19, S28, V3.4S
    SHA1SU1  V19.4S, V23.4S
    SHA1SU0  V5.4S, V23.4S, V0.4S
    SHA256H2  Q2, Q24, V19.4S
    SHA256SU0  V12.4S, V5.4S
    SHA1P  Q17, S9, V25.4S
    SHA1SU1  V30.4S, V2.4S
    SHA1C  Q5, S18, V11.4S
    SHA1C  Q26, S5, V30.4S
    SHA256SU1  V30.4S, V15.4S, V17.4S
    SHA1SU1  V2.4S, V4.4S
    SHA256H  Q4, Q26, V31.4S
    SHA256H  Q24, Q2, V4.4S
    SHA1SU0  V4.4S, V4.4S, V26.4S
    SHA256H2  Q19, Q3, V12.4S
    SHA256SU0  V0.4S, V30.4S
    SHA256H  Q26, Q5, V0.4S
    SHA1SU1  V5.4S, V1.4S
    SHA256SU1  V11.4S, V5.4S, V2.4S
    SHA1SU1  V28.4S, V2.4S
    SHA1P  Q9, S28, V6.4S
    SHA256SU0  V20.4S, V16.4S
    SHA1SU1  V28.4S, V9.4S
    SHA256SU0  V25.4S, V20.4S
    SHA256H  Q17, Q11, V31.4S
    SHA256SU1  V20.4S, V26.4S, V13.4S
    SHA256SU0  V16.4S, V25.4S
    SHA1C  Q31, S4, V19.4S
    SHA256SU0  V26.4S, V14.4S
    SHA256H  Q0, Q28, V17.4S
    SHA256SU0  V1.4S, V26.4S
    SHA256H2  Q8, Q31, V0.4S
    SHA256SU1  V4.4S, V16.4S, V22.4S
    SHA256SU1  V28.4S, V4.4S, V9.4S
    SHA256SU1  V25.4S, V24.4S, V8.4S
    SHA1SU1  V30.4S, V28.4S
    SHA1P  Q5, S10, V21.4S
    SHA256H2  Q8, Q13, V22.4S
    SHA256H2  Q22, Q28, V25.4S
    SHA256H  Q21, Q8, V16.4S
    SHA256SU0  V12.4S, V22.4S
    SHA1C  Q14, S16, V20.4S
    SHA256H  Q10, Q12, V15.4S
    SHA1M  Q15, S10, V15.4S
    SHA256SU0  V10.4S, V18.4S
    SHA256SU1  V18.4S, V21.4S, V9.4S
    SHA1C  Q13, S15, V13.4S
    SHA1SU0  V13.4S, V30.4S, V5.4S
    SHA256H  Q26, Q3, V13.4S
    SHA1SU1  V2.4S, V18.4S
    SHA256SU0  V18.4S, V14.4S
    SHA1SU1  V23.4S, V13.4S
    SHA256SU1  V12.4S, V26.4S, V10.4S
    SHA1C  Q25, S2, V23.4S
    SHA1C  Q4, S25, V28.4S
    SHA1C  Q3, S11, V4.4S
    SHA1C  Q16, S18, V3.4S
    SHA1SU0  V31.4S, V16.4S, V26.4S
    SHA256H2  Q16, Q1, V1.4S
    SHA1M  Q22, S12, V25.4S
    SHA1M  Q25, S25, V4.4S
    SHA256SU0  V3.4S, V5.4S
    SHA1SU0  V13.4S, V22.4S, V15.4S
    SHA1P  Q10, S16, V27.4S
    SHA1P  Q2, S26, V25.4S
    SHA256H2  Q8, Q31, V3.4S
    SHA256H  Q29, Q8, V21.4S
    SHA1M  Q3, S29, V25.4S
    SHA256SU0  V9.4S, V13.4S
    SHA256SU1  V21.4S, V28.4S, V4.4S
    SHA1M  Q26, S16, V25.4S
    SHA256H  Q25, Q10, V26.4S
    SHA1SU0  V22.4S, V2.4S, V4.4S
    SHA256H  Q5, Q3, V22.4S
    SHA1SU1  V27.4S, V5.4S
    SHA1P  Q23, S27, V11.4S
    SHA256H  Q16, Q23, V23.4S
    SHA256H  Q31, Q1, V21.4S
    SHA1SU1  V11.4S, V16.4S
    SHA1M  Q21, S7, V9.4S
    SHA1SU0  V15.4S, V11.4S, V30.4S
    SHA1M  Q9, S15, V31.4S
    SHA1SU0  V2.4S, V25.4S, V10.4S
    SHA1SU0  V10.4S, V9.4S, V21.4S
    SHA1P  Q29, S19, V14.4S
    SHA1P  Q25, S0, V0.4S
    SHA1SU1  V0.4S, V26.4S
    SHA1P  Q8, S28, V19.4S
    SHA256H  Q26, Q12, V30.4S
    SHA256SU1  V31.4S, V12.4S, V16.4S
    SHA1SU0  V7.4S, V20.4S, V30.4S
    SHA256SU1  V5.4S, V26.4S, V2.4S
    SHA1SU1  V27.4S, V29.4S
    SHA1SU0  V12.4S, V0.4S, V5.4S
    SHA256H2  Q28, Q7, V8.4S
    SHA256H2  Q7, Q27, V18.4S
    SHA1SU0  V17.4S, V15.4S, V25.4S
    SHA1P  Q19, S31, V1.4S
    SHA1P  Q14, S10, V23.4S
    SHA1SU1  V16.4S, V12.4S
    SHA256H2  Q2, Q4, V11.4S
    SHA1SU1  V7.4S, V14.4S
    SHA1SU0  V9.4S, V2.4S, V8.4S
    SHA256SU1  V20.4S, V8.4S, V0.4S
    SHA256H2  Q12, Q9, V16.4S
    SHA1C  Q5, S7, V28.4S
    SHA256H  Q6, Q22, V26.4S
    SHA256SU0  V18.4S, V7.4S
    SHA1P  Q30, S18, V12.4S
    SHA256SU0  V26.4S, V5.4S
    SHA256H  Q21, Q22, V8.4S
    SHA1SU1  V9.4S, V29.4S
    SHA1P  Q10, S6, V30.4S
    SHA256H2  Q8, Q19, V7.4S
    SHA1SU0  V31.4S, V14.4S, V27.4S
    SHA1SU1  V6.4S, V8.4S
    SHA1SU1  V19.4S, V30.4S
    SHA1SU0  V13.4S, V19.4S, V26.4S
    SHA256SU0  V27.4S, V21.4S
    SHA1SU1  V29.4S, V21.4S
    SHA1SU1  V12.4S, V29.4S
    SHA256H  Q16, Q31, V17.4S
    SHA256H  Q8, Q13, V11.4S
    SHA256SU0  V13.4S, V10.4S
    SHA256H  Q30, Q6, V6.4S
    SHA1SU1  V19.4S, V25.4S
    SHA1SU1  V22.4S, V16.4S
    SHA1C  Q5, S22, V9.4S
    SHA1P  Q10, S12, V1.4S
    SHA1C  Q16, S8, V13.4S
    SHA256H  Q24, Q16, V19.4S
    SHA256H  Q1, Q24, V16.4S
    SHA256SU1  V29.4S, V1.4S, V5.4S
    SHA1SU1  V2.4S, V28.4S
    SHA256SU1  V5.4S, V30.4S, V2.4S
    SHA256H2  Q9, Q10, V10.4S
    SHA1C  Q13, S9, V9.4S
    SHA256H2  Q1, Q8, V29.4S
    SHA256SU0  V16.4S, V5.4S
    SHA256SU1  V30.4S, V16.4S, V12.4S
    SHA256SU1  V11.4S, V13.4S, V30.4S
    SHA256SU0  V9.4S, V1.4S
    SHA1C  Q10, S14, V1.4S
    SHA256SU0  V27.4S, V11.4S
    SHA256H  Q6, Q9, V27.4S
    SHA256H2  Q7, Q12, V16.4S
    SHA256SU1  V22.4S, V7.4S, V21.4S
    SHA1M  Q5, S5, V30.4S
    SHA1P  Q13, S6, V2.4S
    SHA1SU0  V19.4S, V0.4S, V4.4S
    SHA256H2  Q27, Q3, V25.4S
    SHA256H  Q16, Q29, V21.4S
    SHA1M  Q6, S7, V30.4S
    SHA1M  Q28, S31, V21.4S
    SHA256SU1  V11.4S, V6.4S, V16.4S
    SHA1SU1  V20.4S, V5.4S
    SHA256SU1  V5.4S, V17.4S, V22.4S
    SHA1C  Q6, S6, V14.4S
    SHA256H2  Q0, Q11, V28.4S
    SHA256H2  Q3, Q27, V19.4S
    SHA1C  Q27, S20, V23.4S
    SHA256H2  Q23, Q3, V5.4S
    SHA1SU1  V19.4S, V6.4S
    SHA1M  Q4, S28, V6.4S
    SHA1M  Q6, S0, V27.4S
    SHA256SU1  V29.4S, V23.4S, V10.4S
    SUBS  X2, X2, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_0
    MOVZ  X24, #0x0, LSL #0
    SUB  X13, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0x76f5, LSL #0
    MOVK  X24, #0x83a5, LSL #16
    MOVK  X24, #0xf6b2, LSL #32
    MOVK  X24, #0x2c50, LSL #48
    SUB  X13, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0x6c89, LSL #0
    MOVK  X24, #0x4e96, LSL #16
    MOVK  X24, #0x30c2, LSL #32
    MOVK  X24, #0x1db1, LSL #48
    SUB  X13, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0x941a, LSL #0
    MOVK  X24, #0x74c3, LSL #16
    MOVK  X24, #0x7ee9, LSL #32
    MOVK  X24, #0x7996, LSL #48
    SUB  X13, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0xdef6, LSL #0
    MOVK  X24, #0x5de3, LSL #16
    MOVK  X24, #0x32a8, LSL #32
    MOVK  X24, #0xd479, LSL #48
    SUB  X13, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0x2b6c, LSL #0
    MOVK  X24, #0xad5a, LSL #16
    MOVK  X24, #0x8b2c, LSL #32
    MOVK  X24, #0x6a17, LSL #48
    SUB  X13, X24, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0x721a, LSL #0
    MOVK  X24, #0x54f7, LSL #16
    MOVK  X24, #0x78ef, LSL #32
    MOVK  X24, #0x341b, LSL #48
    SUB  X13, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0x9725, LSL #0
    MOVK  X24, #0x6500, LSL #16
    MOVK  X24, #0xa5a9, LSL #32
    MOVK  X24, #0x71c8, LSL #48
    SUB  X13, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0x44f5, LSL #0
    MOVK  X24, #0xb226, LSL #16
    MOVK  X24, #0x54e6, LSL #32
    MOVK  X24, #0x7aaa, LSL #48
    SUB  X13, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0xb918, LSL #0
    MOVK  X24, #0xb0bf, LSL #16
    MOVK  X24, #0xbee1, LSL #32
    MOVK  X24, #0x7c1a, LSL #48
    SUB  X13, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0x8eb8, LSL #0
    MOVK  X24, #0xcb94, LSL #16
    MOVK  X24, #0x727, LSL #32
    MOVK  X24, #0x5634, LSL #48
    SUB  X13, X24, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0x6930, LSL #0
    MOVK  X24, #0xcd41, LSL #16
    MOVK  X24, #0xe588, LSL #32
    MOVK  X24, #0x4aa7, LSL #48
    SUB  X13, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0x51dd, LSL #0
    MOVK  X24, #0x2794, LSL #16
    MOVK  X24, #0xf73, LSL #32
    MOVK  X24, #0xd573, LSL #48
    SUB  X13, X24, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0x502, LSL #0
    MOVK  X24, #0x5c9b, LSL #16
    MOVK  X24, #0x5c64, LSL #32
    MOVK  X24, #0xb622, LSL #48
    SUB  X13, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0xa63d, LSL #0
    MOVK  X24, #0x841c, LSL #16
    MOVK  X24, #0x68a3, LSL #32
    MOVK  X24, #0x2d1e, LSL #48
    SUB  X13, X24, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0xbf92, LSL #0
    MOVK  X24, #0x7bdf, LSL #16
    MOVK  X24, #0xa5f4, LSL #32
    MOVK  X24, #0x37e3, LSL #48
    SUB  X13, X24, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0x6cf, LSL #0
    MOVK  X24, #0x87b8, LSL #16
    MOVK  X24, #0xdf34, LSL #32
    MOVK  X24, #0x7f94, LSL #48
    SUB  X13, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0x7811, LSL #0
    MOVK  X24, #0x48d8, LSL #16
    MOVK  X24, #0x3cfc, LSL #32
    MOVK  X24, #0x8825, LSL #48
    SUB  X13, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0xcaf0, LSL #0
    MOVK  X24, #0xdeda, LSL #16
    MOVK  X24, #0x1708, LSL #32
    MOVK  X24, #0x3b0f, LSL #48
    SUB  X13, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0x2dd1, LSL #0
    MOVK  X24, #0x81b7, LSL #16
    MOVK  X24, #0x2869, LSL #32
    MOVK  X24, #0x5af6, LSL #48
    SUB  X13, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MRS  X24, FPSR
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V0.D[1]
    MOVZ  X13, #0xfea8, LSL #0
    MOVK  X13, #0x8fd7, LSL #16
    MOVK  X13, #0xabb2, LSL #32
    MOVK  X13, #0x4b75, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D0
    MOVZ  X13, #0xb7ce, LSL #0
    MOVK  X13, #0x84f6, LSL #16
    MOVK  X13, #0x372f, LSL #32
    MOVK  X13, #0xdf8a, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V1.D[1]
    MOVZ  X13, #0x1903, LSL #0
    MOVK  X13, #0xe340, LSL #16
    MOVK  X13, #0x3440, LSL #32
    MOVK  X13, #0xc273, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D1
    MOVZ  X13, #0x6ec9, LSL #0
    MOVK  X13, #0xa717, LSL #16
    MOVK  X13, #0xef21, LSL #32
    MOVK  X13, #0x742f, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V2.D[1]
    MOVZ  X13, #0x529b, LSL #0
    MOVK  X13, #0x36e7, LSL #16
    MOVK  X13, #0x82bf, LSL #32
    MOVK  X13, #0x4388, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D2
    MOVZ  X13, #0x6097, LSL #0
    MOVK  X13, #0x1dc5, LSL #16
    MOVK  X13, #0xa508, LSL #32
    MOVK  X13, #0xc5b8, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V3.D[1]
    MOVZ  X13, #0x3e81, LSL #0
    MOVK  X13, #0xfd1a, LSL #16
    MOVK  X13, #0x56b2, LSL #32
    MOVK  X13, #0x1894, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D3
    MOVZ  X13, #0xb58b, LSL #0
    MOVK  X13, #0x1b90, LSL #16
    MOVK  X13, #0xaaff, LSL #32
    MOVK  X13, #0xc877, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X13, #0x274f, LSL #0
    MOVK  X13, #0xaadd, LSL #16
    MOVK  X13, #0x38a8, LSL #32
    MOVK  X13, #0xc729, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D4
    MOVZ  X13, #0xc84, LSL #0
    MOVK  X13, #0x76d2, LSL #16
    MOVK  X13, #0xda6e, LSL #32
    MOVK  X13, #0x5d3f, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X13, #0xe8ad, LSL #0
    MOVK  X13, #0x359, LSL #16
    MOVK  X13, #0xf00d, LSL #32
    MOVK  X13, #0xcbc5, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D5
    MOVZ  X13, #0xbd64, LSL #0
    MOVK  X13, #0x34fb, LSL #16
    MOVK  X13, #0x51eb, LSL #32
    MOVK  X13, #0x8b02, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X13, #0xe09d, LSL #0
    MOVK  X13, #0xe32a, LSL #16
    MOVK  X13, #0x4d36, LSL #32
    MOVK  X13, #0x701c, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D6
    MOVZ  X13, #0x628c, LSL #0
    MOVK  X13, #0x8b06, LSL #16
    MOVK  X13, #0x93e, LSL #32
    MOVK  X13, #0x55c0, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X13, #0x6190, LSL #0
    MOVK  X13, #0xf4cd, LSL #16
    MOVK  X13, #0xb733, LSL #32
    MOVK  X13, #0xd7c4, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D7
    MOVZ  X13, #0x2330, LSL #0
    MOVK  X13, #0x337c, LSL #16
    MOVK  X13, #0x34b7, LSL #32
    MOVK  X13, #0x31bf, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V8.D[1]
    MOVZ  X13, #0x5d3a, LSL #0
    MOVK  X13, #0xc70c, LSL #16
    MOVK  X13, #0xa653, LSL #32
    MOVK  X13, #0xe19b, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D8
    MOVZ  X13, #0x1e89, LSL #0
    MOVK  X13, #0x9301, LSL #16
    MOVK  X13, #0x4e02, LSL #32
    MOVK  X13, #0xedb0, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X13, #0xa13d, LSL #0
    MOVK  X13, #0xcd0a, LSL #16
    MOVK  X13, #0xaf92, LSL #32
    MOVK  X13, #0x1cfa, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D9
    MOVZ  X13, #0x473f, LSL #0
    MOVK  X13, #0xed85, LSL #16
    MOVK  X13, #0x3014, LSL #32
    MOVK  X13, #0x26d1, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V10.D[1]
    MOVZ  X13, #0x8f8f, LSL #0
    MOVK  X13, #0x13cd, LSL #16
    MOVK  X13, #0xd0c6, LSL #32
    MOVK  X13, #0x107b, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D10
    MOVZ  X13, #0xbd40, LSL #0
    MOVK  X13, #0x9323, LSL #16
    MOVK  X13, #0x1aa9, LSL #32
    MOVK  X13, #0xad1a, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V11.D[1]
    MOVZ  X13, #0xab51, LSL #0
    MOVK  X13, #0x619a, LSL #16
    MOVK  X13, #0xf191, LSL #32
    MOVK  X13, #0x7957, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D11
    MOVZ  X13, #0x6599, LSL #0
    MOVK  X13, #0xa322, LSL #16
    MOVK  X13, #0x3e9, LSL #32
    MOVK  X13, #0xb122, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V12.D[1]
    MOVZ  X13, #0x54fa, LSL #0
    MOVK  X13, #0xe7b1, LSL #16
    MOVK  X13, #0x75cd, LSL #32
    MOVK  X13, #0x32fe, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D12
    MOVZ  X13, #0x9e86, LSL #0
    MOVK  X13, #0x8c2f, LSL #16
    MOVK  X13, #0x918c, LSL #32
    MOVK  X13, #0x96b0, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V13.D[1]
    MOVZ  X13, #0xc716, LSL #0
    MOVK  X13, #0x636c, LSL #16
    MOVK  X13, #0xb173, LSL #32
    MOVK  X13, #0xaa3e, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D13
    MOVZ  X13, #0x5b7b, LSL #0
    MOVK  X13, #0x9fa8, LSL #16
    MOVK  X13, #0x684f, LSL #32
    MOVK  X13, #0x1aaf, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X13, #0xb2d, LSL #0
    MOVK  X13, #0x7b3f, LSL #16
    MOVK  X13, #0x45ae, LSL #32
    MOVK  X13, #0xfaf3, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D14
    MOVZ  X13, #0x560f, LSL #0
    MOVK  X13, #0x8477, LSL #16
    MOVK  X13, #0xd885, LSL #32
    MOVK  X13, #0x6a72, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X13, #0x7bc2, LSL #0
    MOVK  X13, #0x4100, LSL #16
    MOVK  X13, #0xe5e1, LSL #32
    MOVK  X13, #0xb018, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D15
    MOVZ  X13, #0xb718, LSL #0
    MOVK  X13, #0x89, LSL #16
    MOVK  X13, #0xb614, LSL #32
    MOVK  X13, #0xcf29, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V16.D[1]
    MOVZ  X13, #0x2d68, LSL #0
    MOVK  X13, #0xcde2, LSL #16
    MOVK  X13, #0xd01d, LSL #32
    MOVK  X13, #0xa94, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D16
    MOVZ  X13, #0xe18c, LSL #0
    MOVK  X13, #0x390a, LSL #16
    MOVK  X13, #0xb265, LSL #32
    MOVK  X13, #0x8dc, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X13, #0xe079, LSL #0
    MOVK  X13, #0x145, LSL #16
    MOVK  X13, #0xf019, LSL #32
    MOVK  X13, #0x7af9, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D17
    MOVZ  X13, #0x56c0, LSL #0
    MOVK  X13, #0x158, LSL #16
    MOVK  X13, #0xaf5d, LSL #32
    MOVK  X13, #0x4774, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V18.D[1]
    MOVZ  X13, #0xf2bb, LSL #0
    MOVK  X13, #0xa9ba, LSL #16
    MOVK  X13, #0x677c, LSL #32
    MOVK  X13, #0x32b5, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D18
    MOVZ  X13, #0x1fb5, LSL #0
    MOVK  X13, #0x56ac, LSL #16
    MOVK  X13, #0x4fe5, LSL #32
    MOVK  X13, #0x4de3, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X13, #0x7275, LSL #0
    MOVK  X13, #0x2151, LSL #16
    MOVK  X13, #0xf63, LSL #32
    MOVK  X13, #0x4836, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D19
    MOVZ  X13, #0x35c6, LSL #0
    MOVK  X13, #0x2bb2, LSL #16
    MOVK  X13, #0x27ae, LSL #32
    MOVK  X13, #0x9303, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X13, #0xd49a, LSL #0
    MOVK  X13, #0xaad4, LSL #16
    MOVK  X13, #0x4f04, LSL #32
    MOVK  X13, #0x861a, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D20
    MOVZ  X13, #0x1249, LSL #0
    MOVK  X13, #0x7d53, LSL #16
    MOVK  X13, #0x9889, LSL #32
    MOVK  X13, #0xdf07, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V21.D[1]
    MOVZ  X13, #0xa68c, LSL #0
    MOVK  X13, #0x6ac2, LSL #16
    MOVK  X13, #0x2e6b, LSL #32
    MOVK  X13, #0x6624, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D21
    MOVZ  X13, #0x3c85, LSL #0
    MOVK  X13, #0x21f8, LSL #16
    MOVK  X13, #0x4fdb, LSL #32
    MOVK  X13, #0x971c, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V22.D[1]
    MOVZ  X13, #0x35d, LSL #0
    MOVK  X13, #0x3b79, LSL #16
    MOVK  X13, #0xa90d, LSL #32
    MOVK  X13, #0x644b, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D22
    MOVZ  X13, #0x7400, LSL #0
    MOVK  X13, #0x8d8a, LSL #16
    MOVK  X13, #0x43dc, LSL #32
    MOVK  X13, #0x53b6, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V23.D[1]
    MOVZ  X13, #0x70f3, LSL #0
    MOVK  X13, #0x4c37, LSL #16
    MOVK  X13, #0xfaee, LSL #32
    MOVK  X13, #0x511, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D23
    MOVZ  X13, #0x2725, LSL #0
    MOVK  X13, #0x4ead, LSL #16
    MOVK  X13, #0xf7, LSL #32
    MOVK  X13, #0x43f9, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V24.D[1]
    MOVZ  X13, #0xc825, LSL #0
    MOVK  X13, #0xa784, LSL #16
    MOVK  X13, #0x31f8, LSL #32
    MOVK  X13, #0x4df3, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D24
    MOVZ  X13, #0xe359, LSL #0
    MOVK  X13, #0xb9db, LSL #16
    MOVK  X13, #0x5959, LSL #32
    MOVK  X13, #0xeb, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V25.D[1]
    MOVZ  X13, #0x2985, LSL #0
    MOVK  X13, #0xeac2, LSL #16
    MOVK  X13, #0xea79, LSL #32
    MOVK  X13, #0x7bf0, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D25
    MOVZ  X13, #0x3f95, LSL #0
    MOVK  X13, #0x382c, LSL #16
    MOVK  X13, #0xddab, LSL #32
    MOVK  X13, #0x866e, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V26.D[1]
    MOVZ  X13, #0xa645, LSL #0
    MOVK  X13, #0x6c57, LSL #16
    MOVK  X13, #0xb981, LSL #32
    MOVK  X13, #0x4d60, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D26
    MOVZ  X13, #0x7559, LSL #0
    MOVK  X13, #0xc8a3, LSL #16
    MOVK  X13, #0x8db4, LSL #32
    MOVK  X13, #0x9af1, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X13, #0x9c50, LSL #0
    MOVK  X13, #0xf10f, LSL #16
    MOVK  X13, #0x59ca, LSL #32
    MOVK  X13, #0x652c, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D27
    MOVZ  X13, #0x31e6, LSL #0
    MOVK  X13, #0xbc2c, LSL #16
    MOVK  X13, #0xbf72, LSL #32
    MOVK  X13, #0x8c85, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V28.D[1]
    MOVZ  X13, #0xf6e4, LSL #0
    MOVK  X13, #0x692e, LSL #16
    MOVK  X13, #0xc0b8, LSL #32
    MOVK  X13, #0x8a67, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D28
    MOVZ  X13, #0x37bf, LSL #0
    MOVK  X13, #0xdf79, LSL #16
    MOVK  X13, #0xe064, LSL #32
    MOVK  X13, #0x2ec2, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V29.D[1]
    MOVZ  X13, #0x6765, LSL #0
    MOVK  X13, #0x7838, LSL #16
    MOVK  X13, #0x9b7d, LSL #32
    MOVK  X13, #0x8f59, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D29
    MOVZ  X13, #0xf2f0, LSL #0
    MOVK  X13, #0xbe0, LSL #16
    MOVK  X13, #0x4af0, LSL #32
    MOVK  X13, #0xe705, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V30.D[1]
    MOVZ  X13, #0xdcf2, LSL #0
    MOVK  X13, #0x1625, LSL #16
    MOVK  X13, #0x576, LSL #32
    MOVK  X13, #0xca29, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D30
    MOVZ  X13, #0xe31b, LSL #0
    MOVK  X13, #0xb5af, LSL #16
    MOVK  X13, #0x1326, LSL #32
    MOVK  X13, #0x350, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V31.D[1]
    MOVZ  X13, #0x79d4, LSL #0
    MOVK  X13, #0x7868, LSL #16
    MOVK  X13, #0xa551, LSL #32
    MOVK  X13, #0xf425, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D31
    MOVZ  X13, #0xea59, LSL #0
    MOVK  X13, #0x5e43, LSL #16
    MOVK  X13, #0xc7c6, LSL #32
    MOVK  X13, #0xfcf5, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
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
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X25
    FMOV  V0.D[1], X13
    FMOV  D1, X29
    FMOV  V1.D[1], X28
    FMOV  D2, X27
    FMOV  V2.D[1], X7
    FMOV  D3, X17
    FMOV  V3.D[1], X28
    FMOV  D4, X25
    FMOV  V4.D[1], X15
    FMOV  D5, X24
    FMOV  V5.D[1], X23
    FMOV  D6, X9
    FMOV  V6.D[1], X27
    FMOV  D7, X24
    FMOV  V7.D[1], X9
    FMOV  D8, X10
    FMOV  V8.D[1], X12
    FMOV  D9, X17
    FMOV  V9.D[1], X10
    FMOV  D10, X15
    FMOV  V10.D[1], X7
    FMOV  D11, X3
    FMOV  V11.D[1], X6
    FMOV  D12, X28
    FMOV  V12.D[1], X15
    FMOV  D13, X10
    FMOV  V13.D[1], X4
    FMOV  D14, X17
    FMOV  V14.D[1], X4
    FMOV  D15, X8
    FMOV  V15.D[1], X25
    FMOV  D16, X13
    FMOV  V16.D[1], X27
    FMOV  D17, X24
    FMOV  V17.D[1], X7
    FMOV  D18, X12
    FMOV  V18.D[1], X4
    FMOV  D19, X3
    FMOV  V19.D[1], X2
    FMOV  D20, X12
    FMOV  V20.D[1], X6
    FMOV  D21, X14
    FMOV  V21.D[1], X27
    FMOV  D22, X24
    FMOV  V22.D[1], X28
    FMOV  D23, X13
    FMOV  V23.D[1], X27
    FMOV  D24, X16
    FMOV  V24.D[1], X17
    FMOV  D25, X27
    FMOV  V25.D[1], X23
    FMOV  D26, X17
    FMOV  V26.D[1], X27
    FMOV  D27, X13
    FMOV  V27.D[1], X3
    FMOV  D28, X26
    FMOV  V28.D[1], X8
    FMOV  D29, X4
    FMOV  V29.D[1], X2
    FMOV  D30, X6
    FMOV  V30.D[1], X10
    FMOV  D31, X26
    FMOV  V31.D[1], X12
    MOVZ  X9, #0xa, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_1:
    SHA256SU0  V22.4S, V7.4S
    SHA256SU0  V7.4S, V30.4S
    SHA1C  Q14, S22, V25.4S
    SHA1C  Q18, S27, V27.4S
    SHA256SU0  V1.4S, V26.4S
    SHA1C  Q23, S19, V0.4S
    SHA1SU0  V11.4S, V1.4S, V15.4S
    SHA256H2  Q25, Q27, V11.4S
    SHA1C  Q5, S18, V29.4S
    SHA256SU0  V19.4S, V23.4S
    SHA1SU1  V17.4S, V14.4S
    SHA1C  Q25, S28, V17.4S
    SHA256H2  Q1, Q8, V6.4S
    SHA256H2  Q6, Q23, V6.4S
    SHA1SU1  V17.4S, V7.4S
    SHA256H2  Q15, Q6, V1.4S
    SHA256H2  Q11, Q15, V15.4S
    SHA1M  Q1, S19, V5.4S
    SHA1SU1  V18.4S, V28.4S
    SHA1P  Q26, S1, V30.4S
    SHA256H2  Q15, Q11, V26.4S
    SHA256SU0  V26.4S, V17.4S
    SHA256H  Q23, Q24, V26.4S
    SHA256H2  Q28, Q6, V25.4S
    SHA256SU1  V7.4S, V23.4S, V15.4S
    SHA256SU0  V29.4S, V28.4S
    SHA1P  Q23, S7, V7.4S
    SHA256SU0  V6.4S, V21.4S
    SHA1C  Q25, S2, V18.4S
    SHA1SU1  V14.4S, V16.4S
    SHA1C  Q8, S18, V11.4S
    SHA256SU0  V13.4S, V6.4S
    SHA1SU0  V17.4S, V25.4S, V29.4S
    SHA256SU0  V19.4S, V8.4S
    SHA256SU1  V27.4S, V25.4S, V7.4S
    SHA256H  Q22, Q20, V0.4S
    SHA1P  Q15, S17, V17.4S
    SHA1P  Q11, S15, V13.4S
    SHA256H2  Q26, Q5, V23.4S
    SHA1SU1  V17.4S, V14.4S
    SHA256SU0  V0.4S, V20.4S
    SHA256H2  Q1, Q11, V24.4S
    SHA256H2  Q13, Q0, V8.4S
    SHA256SU0  V14.4S, V27.4S
    SHA1SU1  V8.4S, V3.4S
    SHA1SU1  V28.4S, V14.4S
    SHA1C  Q20, S15, V28.4S
    SHA1P  Q27, S19, V29.4S
    SHA256H  Q30, Q7, V20.4S
    SHA1SU1  V23.4S, V8.4S
    SHA1SU0  V18.4S, V23.4S, V27.4S
    SHA1SU0  V25.4S, V6.4S, V22.4S
    SHA1SU1  V7.4S, V1.4S
    SHA1P  Q24, S20, V19.4S
    SHA1P  Q11, S26, V6.4S
    SHA256SU1  V28.4S, V6.4S, V23.4S
    SHA256SU1  V14.4S, V11.4S, V24.4S
    SHA1SU1  V3.4S, V10.4S
    SHA1SU0  V5.4S, V28.4S, V30.4S
    SHA1C  Q15, S14, V13.4S
    SHA256SU1  V24.4S, V25.4S, V18.4S
    SHA1M  Q11, S7, V15.4S
    SHA256SU0  V20.4S, V21.4S
    SHA256H  Q6, Q31, V27.4S
    SHA256H2  Q10, Q5, V24.4S
    SHA256SU1  V9.4S, V5.4S, V27.4S
    SHA1P  Q30, S9, V20.4S
    SHA256H2  Q20, Q3, V14.4S
    SHA1M  Q0, S6, V11.4S
    SHA1P  Q6, S0, V7.4S
    SHA256H2  Q19, Q30, V5.4S
    SHA256H  Q27, Q6, V6.4S
    SHA256SU0  V23.4S, V4.4S
    SHA256H  Q26, Q27, V23.4S
    SHA1C  Q15, S26, V19.4S
    SHA1C  Q15, S28, V15.4S
    SHA1SU0  V21.4S, V17.4S, V10.4S
    SHA256SU0  V0.4S, V15.4S
    SHA1M  Q14, S11, V29.4S
    SHA256H2  Q8, Q14, V30.4S
    SHA256SU0  V0.4S, V23.4S
    SHA1P  Q28, S12, V17.4S
    SHA1SU0  V9.4S, V8.4S, V18.4S
    SHA1C  Q26, S21, V0.4S
    SHA1P  Q14, S2, V31.4S
    SHA1M  Q19, S29, V20.4S
    SHA1SU0  V12.4S, V14.4S, V9.4S
    SHA1M  Q20, S17, V2.4S
    SHA1M  Q21, S6, V12.4S
    SHA256SU1  V24.4S, V26.4S, V20.4S
    SHA1SU0  V12.4S, V21.4S, V25.4S
    SHA256SU0  V17.4S, V0.4S
    SHA1P  Q10, S9, V10.4S
    SHA256SU0  V8.4S, V17.4S
    SHA256H2  Q23, Q10, V12.4S
    SHA1C  Q12, S11, V19.4S
    SHA1SU1  V26.4S, V24.4S
    SHA256H2  Q10, Q26, V28.4S
    SHA1SU1  V19.4S, V12.4S
    SHA1P  Q17, S19, V10.4S
    SHA1C  Q24, S3, V21.4S
    SHA256H2  Q26, Q8, V23.4S
    SHA1C  Q6, S17, V24.4S
    SHA1SU0  V0.4S, V30.4S, V0.4S
    SHA1SU0  V31.4S, V14.4S, V22.4S
    SHA256SU0  V15.4S, V9.4S
    SHA256H2  Q11, Q2, V4.4S
    SHA1SU1  V3.4S, V31.4S
    SHA256H  Q19, Q28, V18.4S
    SHA256H2  Q22, Q24, V9.4S
    SHA1C  Q2, S2, V3.4S
    SHA256SU0  V14.4S, V19.4S
    SHA1P  Q28, S31, V30.4S
    SHA256H  Q10, Q15, V6.4S
    SHA256H2  Q20, Q11, V28.4S
    SHA1M  Q21, S26, V20.4S
    SHA1SU1  V27.4S, V14.4S
    SHA1SU1  V24.4S, V21.4S
    SHA1SU0  V17.4S, V2.4S, V27.4S
    SHA256SU1  V15.4S, V22.4S, V30.4S
    SHA1P  Q20, S17, V31.4S
    SHA256SU0  V12.4S, V21.4S
    SHA1SU0  V19.4S, V15.4S, V8.4S
    SHA256SU0  V21.4S, V24.4S
    SHA256H2  Q27, Q21, V21.4S
    SHA256H  Q9, Q2, V29.4S
    SHA256H2  Q3, Q12, V20.4S
    SHA1P  Q12, S9, V3.4S
    SHA1M  Q21, S10, V29.4S
    SHA256SU0  V13.4S, V21.4S
    SHA256H2  Q28, Q2, V0.4S
    SHA1SU1  V17.4S, V28.4S
    SHA256SU0  V8.4S, V17.4S
    SHA256SU1  V6.4S, V12.4S, V27.4S
    SHA1P  Q10, S19, V27.4S
    SHA1SU0  V31.4S, V6.4S, V5.4S
    SHA1P  Q1, S8, V26.4S
    SHA1SU1  V15.4S, V10.4S
    SHA256H2  Q21, Q18, V1.4S
    SHA1SU1  V24.4S, V31.4S
    SHA256SU0  V29.4S, V24.4S
    SHA1C  Q3, S13, V29.4S
    SHA1SU0  V5.4S, V21.4S, V15.4S
    SHA256H  Q0, Q8, V0.4S
    SHA256H  Q6, Q29, V27.4S
    SHA1M  Q10, S26, V12.4S
    SHA256H2  Q8, Q6, V10.4S
    SHA256SU1  V27.4S, V16.4S, V13.4S
    SHA1C  Q29, S3, V19.4S
    SHA1SU1  V12.4S, V21.4S
    SHA256SU1  V22.4S, V17.4S, V15.4S
    SHA1P  Q26, S6, V12.4S
    SHA1C  Q23, S6, V15.4S
    SHA256SU1  V31.4S, V21.4S, V24.4S
    SHA1SU1  V6.4S, V16.4S
    SHA256H  Q1, Q9, V26.4S
    SHA256SU0  V13.4S, V22.4S
    SHA256H2  Q22, Q5, V8.4S
    SHA1SU1  V7.4S, V27.4S
    SHA1M  Q20, S29, V13.4S
    SHA256H  Q21, Q1, V6.4S
    SHA256H2  Q8, Q20, V9.4S
    SHA1SU0  V26.4S, V0.4S, V7.4S
    SHA1P  Q5, S23, V25.4S
    SHA1SU0  V16.4S, V27.4S, V22.4S
    SHA256H2  Q9, Q16, V5.4S
    SHA256SU0  V15.4S, V21.4S
    SHA256SU1  V14.4S, V25.4S, V22.4S
    SHA1SU0  V5.4S, V31.4S, V14.4S
    SHA256H  Q16, Q5, V8.4S
    SHA256SU1  V14.4S, V9.4S, V16.4S
    SHA1SU0  V3.4S, V20.4S, V15.4S
    SHA1SU1  V20.4S, V3.4S
    SHA256SU1  V24.4S, V12.4S, V14.4S
    SHA1C  Q20, S31, V24.4S
    SHA1M  Q31, S3, V22.4S
    SHA256SU1  V15.4S, V13.4S, V30.4S
    SHA256SU1  V21.4S, V17.4S, V6.4S
    SHA256H2  Q13, Q29, V19.4S
    SHA1P  Q12, S22, V19.4S
    SHA1M  Q29, S15, V1.4S
    SHA1SU0  V0.4S, V27.4S, V12.4S
    SHA256SU1  V24.4S, V6.4S, V27.4S
    SHA1SU1  V8.4S, V9.4S
    SHA256H  Q25, Q29, V20.4S
    SHA256SU1  V17.4S, V8.4S, V25.4S
    SHA256SU0  V3.4S, V26.4S
    SHA1M  Q15, S0, V13.4S
    SHA256H2  Q8, Q21, V21.4S
    SHA1P  Q21, S3, V8.4S
    SHA1C  Q0, S15, V8.4S
    SHA1C  Q27, S24, V17.4S
    SHA1C  Q15, S0, V31.4S
    SHA1SU1  V12.4S, V15.4S
    SHA256SU1  V26.4S, V21.4S, V5.4S
    SHA1P  Q8, S12, V27.4S
    SHA1SU1  V16.4S, V10.4S
    SHA256H  Q22, Q9, V1.4S
    SHA256H2  Q27, Q1, V28.4S
    SHA256SU1  V9.4S, V20.4S, V16.4S
    SUBS  X9, X9, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_1
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MRS  X28, FPSR
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V0.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D0
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V1.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D1
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D2
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V3.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D3
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D4
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D5
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D6
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V7.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D7
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D8
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D9
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D10
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D11
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V12.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D12
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V13.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D13
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D14
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V15.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D15
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D16
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D17
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D18
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V19.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D19
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D20
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D21
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D22
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V23.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D23
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D24
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D25
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D26
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V27.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D27
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D28
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D29
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V30.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D30
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V31.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D31
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
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
    FMOV  V0.D[1], X28
    FMOV  D1, X12
    FMOV  V1.D[1], X27
    FMOV  D2, X14
    FMOV  V2.D[1], X29
    FMOV  D3, X26
    FMOV  V3.D[1], X24
    FMOV  D4, X25
    FMOV  V4.D[1], X26
    FMOV  D5, X25
    FMOV  V5.D[1], X25
    FMOV  D6, X15
    FMOV  V6.D[1], X14
    FMOV  D7, X2
    FMOV  V7.D[1], X28
    FMOV  D8, X17
    FMOV  V8.D[1], X16
    FMOV  D9, X26
    FMOV  V9.D[1], X14
    FMOV  D10, X23
    FMOV  V10.D[1], X9
    FMOV  D11, X7
    FMOV  V11.D[1], X15
    FMOV  D12, X24
    FMOV  V12.D[1], X27
    FMOV  D13, X2
    FMOV  V13.D[1], X15
    FMOV  D14, X16
    FMOV  V14.D[1], X7
    FMOV  D15, X28
    FMOV  V15.D[1], X16
    FMOV  D16, X24
    FMOV  V16.D[1], X6
    FMOV  D17, X16
    FMOV  V17.D[1], X4
    FMOV  D18, X15
    FMOV  V18.D[1], X17
    FMOV  D19, X23
    FMOV  V19.D[1], X28
    FMOV  D20, X26
    FMOV  V20.D[1], X14
    FMOV  D21, X6
    FMOV  V21.D[1], X7
    FMOV  D22, X25
    FMOV  V22.D[1], X5
    FMOV  D23, X11
    FMOV  V23.D[1], X3
    FMOV  D24, X15
    FMOV  V24.D[1], X25
    FMOV  D25, X12
    FMOV  V25.D[1], X7
    FMOV  D26, X10
    FMOV  V26.D[1], X17
    FMOV  D27, X24
    FMOV  V27.D[1], X8
    FMOV  D28, X12
    FMOV  V28.D[1], X11
    FMOV  D29, X3
    FMOV  V29.D[1], X13
    FMOV  D30, X29
    FMOV  V30.D[1], X11
    FMOV  D31, X24
    FMOV  V31.D[1], X12
    MOVZ  X15, #0xa, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_2:
    SHA1C  Q26, S26, V31.4S
    SHA256SU1  V14.4S, V26.4S, V31.4S
    SHA256SU0  V16.4S, V19.4S
    SHA256SU0  V16.4S, V14.4S
    SHA1M  Q21, S25, V3.4S
    SHA256SU0  V0.4S, V28.4S
    SHA1C  Q14, S0, V29.4S
    SHA1SU0  V13.4S, V30.4S, V18.4S
    SHA1C  Q3, S14, V16.4S
    SHA256SU1  V6.4S, V13.4S, V24.4S
    SHA256SU0  V28.4S, V3.4S
    SHA1P  Q12, S4, V14.4S
    SHA256SU0  V6.4S, V21.4S
    SHA1SU0  V0.4S, V11.4S, V28.4S
    SHA1P  Q29, S3, V12.4S
    SHA256H2  Q30, Q19, V29.4S
    SHA1M  Q14, S6, V6.4S
    SHA256H2  Q24, Q25, V3.4S
    SHA1M  Q5, S25, V24.4S
    SHA256SU0  V13.4S, V13.4S
    SHA256SU1  V25.4S, V5.4S, V27.4S
    SHA1SU0  V28.4S, V15.4S, V10.4S
    SHA1P  Q4, S0, V8.4S
    SHA256SU0  V3.4S, V17.4S
    SHA256SU0  V12.4S, V4.4S
    SHA256H2  Q19, Q9, V28.4S
    SHA256H  Q17, Q4, V6.4S
    SHA1SU1  V4.4S, V19.4S
    SHA256H  Q15, Q4, V3.4S
    SHA1SU0  V8.4S, V30.4S, V14.4S
    SHA256H2  Q3, Q6, V17.4S
    SHA256SU1  V0.4S, V2.4S, V29.4S
    SHA256SU1  V5.4S, V3.4S, V15.4S
    SHA1M  Q4, S5, V20.4S
    SHA256H  Q11, Q8, V13.4S
    SHA256H  Q19, Q26, V0.4S
    SHA1M  Q26, S12, V14.4S
    SHA1M  Q8, S19, V19.4S
    SHA256H  Q0, Q25, V0.4S
    SHA256H2  Q24, Q4, V19.4S
    SHA256H2  Q22, Q26, V26.4S
    SHA256SU1  V21.4S, V21.4S, V11.4S
    SHA1M  Q28, S19, V29.4S
    SHA256H  Q29, Q11, V28.4S
    SHA256H  Q19, Q0, V1.4S
    SHA256H2  Q26, Q3, V22.4S
    SHA256SU0  V17.4S, V8.4S
    SHA256SU1  V15.4S, V22.4S, V24.4S
    SHA1C  Q27, S15, V21.4S
    SHA1C  Q1, S29, V14.4S
    SHA256SU0  V28.4S, V4.4S
    SHA1P  Q23, S25, V7.4S
    SHA1P  Q3, S28, V1.4S
    SHA1M  Q31, S29, V23.4S
    SHA1P  Q24, S9, V17.4S
    SHA256H2  Q8, Q24, V9.4S
    SHA1SU0  V13.4S, V8.4S, V9.4S
    SHA256SU1  V0.4S, V13.4S, V3.4S
    SHA1SU0  V24.4S, V0.4S, V26.4S
    SHA256SU1  V13.4S, V3.4S, V28.4S
    SHA1SU0  V19.4S, V13.4S, V17.4S
    SHA256SU1  V4.4S, V22.4S, V27.4S
    SHA256H2  Q14, Q24, V21.4S
    SHA256H  Q1, Q1, V31.4S
    SHA1C  Q28, S8, V5.4S
    SHA1SU0  V0.4S, V5.4S, V14.4S
    SHA256H2  Q31, Q0, V28.4S
    SHA256SU0  V29.4S, V19.4S
    SHA1SU0  V17.4S, V1.4S, V10.4S
    SHA1P  Q0, S10, V31.4S
    SHA256SU0  V5.4S, V8.4S
    SHA256H  Q14, Q17, V5.4S
    SHA1SU0  V26.4S, V23.4S, V22.4S
    SHA1SU1  V23.4S, V5.4S
    SHA256SU0  V30.4S, V26.4S
    SHA256SU1  V17.4S, V29.4S, V9.4S
    SHA1M  Q25, S4, V0.4S
    SHA1SU0  V0.4S, V23.4S, V17.4S
    SHA1C  Q28, S14, V14.4S
    SHA256SU1  V12.4S, V30.4S, V0.4S
    SHA1SU1  V23.4S, V18.4S
    SHA1SU0  V18.4S, V31.4S, V12.4S
    SHA256SU0  V3.4S, V18.4S
    SHA256H2  Q14, Q1, V6.4S
    SHA1SU1  V10.4S, V3.4S
    SHA256H2  Q8, Q6, V23.4S
    SHA256SU0  V30.4S, V8.4S
    SHA1M  Q20, S14, V10.4S
    SHA1SU1  V3.4S, V8.4S
    SHA256SU0  V29.4S, V1.4S
    SHA256SU0  V5.4S, V0.4S
    SHA1P  Q1, S20, V12.4S
    SHA1SU0  V23.4S, V1.4S, V29.4S
    SHA1M  Q31, S19, V28.4S
    SHA256SU1  V9.4S, V17.4S, V29.4S
    SHA1C  Q12, S15, V5.4S
    SHA1P  Q0, S15, V1.4S
    SHA256H  Q1, Q3, V24.4S
    SHA1M  Q24, S25, V22.4S
    SHA256SU1  V7.4S, V31.4S, V1.4S
    SHA1SU0  V14.4S, V20.4S, V11.4S
    SHA1SU0  V10.4S, V12.4S, V3.4S
    SHA256SU1  V4.4S, V19.4S, V3.4S
    SHA256H  Q17, Q4, V4.4S
    SHA1P  Q1, S9, V23.4S
    SHA1SU0  V20.4S, V14.4S, V24.4S
    SHA1P  Q11, S17, V10.4S
    SHA256H  Q4, Q4, V1.4S
    SHA1P  Q14, S12, V4.4S
    SHA1SU0  V31.4S, V11.4S, V10.4S
    SHA256H2  Q24, Q1, V13.4S
    SHA256H2  Q4, Q14, V2.4S
    SHA1SU1  V6.4S, V14.4S
    SHA1C  Q14, S20, V31.4S
    SHA1M  Q15, S30, V11.4S
    SHA256SU0  V17.4S, V0.4S
    SHA256SU1  V27.4S, V14.4S, V2.4S
    SHA1SU1  V0.4S, V27.4S
    SHA1SU1  V2.4S, V24.4S
    SHA256SU1  V29.4S, V15.4S, V17.4S
    SHA256H  Q11, Q0, V4.4S
    SHA256H  Q0, Q9, V11.4S
    SHA256SU1  V30.4S, V0.4S, V2.4S
    SHA256SU1  V4.4S, V30.4S, V27.4S
    SHA256H  Q13, Q4, V15.4S
    SHA256H  Q25, Q9, V1.4S
    SHA1C  Q0, S7, V7.4S
    SHA256SU1  V12.4S, V2.4S, V6.4S
    SHA1P  Q27, S3, V9.4S
    SHA256H2  Q1, Q27, V12.4S
    SHA1M  Q2, S13, V29.4S
    SHA256H  Q6, Q11, V2.4S
    SHA1C  Q23, S1, V10.4S
    SHA1C  Q27, S25, V0.4S
    SHA1P  Q25, S6, V29.4S
    SHA256H2  Q9, Q23, V17.4S
    SHA1P  Q31, S24, V18.4S
    SHA1P  Q13, S27, V31.4S
    SHA1M  Q31, S29, V16.4S
    SHA1P  Q24, S13, V13.4S
    SHA1SU0  V15.4S, V20.4S, V1.4S
    SHA256H2  Q11, Q9, V22.4S
    SHA256SU0  V29.4S, V31.4S
    SHA256H  Q11, Q25, V24.4S
    SHA256SU0  V4.4S, V31.4S
    SHA1C  Q25, S15, V1.4S
    SHA256SU1  V2.4S, V9.4S, V11.4S
    SHA1SU1  V23.4S, V21.4S
    SHA1C  Q21, S6, V21.4S
    SHA1P  Q31, S12, V29.4S
    SHA256SU0  V3.4S, V25.4S
    SHA1SU0  V11.4S, V4.4S, V21.4S
    SHA256H2  Q13, Q28, V29.4S
    SHA1M  Q17, S13, V11.4S
    SHA256SU0  V25.4S, V31.4S
    SHA1SU0  V8.4S, V16.4S, V17.4S
    SHA1P  Q8, S23, V8.4S
    SHA1P  Q15, S23, V30.4S
    SHA1P  Q27, S15, V16.4S
    SHA256SU0  V19.4S, V27.4S
    SHA256H  Q21, Q10, V16.4S
    SHA256H  Q14, Q19, V25.4S
    SHA1M  Q23, S8, V26.4S
    SHA1SU1  V15.4S, V5.4S
    SHA1SU0  V17.4S, V2.4S, V14.4S
    SHA256H2  Q9, Q3, V21.4S
    SHA256H2  Q13, Q9, V11.4S
    SHA1SU0  V1.4S, V18.4S, V12.4S
    SHA1C  Q2, S19, V13.4S
    SHA256SU0  V9.4S, V2.4S
    SHA1SU1  V22.4S, V29.4S
    SHA256SU1  V19.4S, V22.4S, V1.4S
    SHA256H2  Q2, Q15, V8.4S
    SHA1C  Q21, S5, V17.4S
    SHA256SU0  V10.4S, V23.4S
    SHA256SU1  V13.4S, V21.4S, V1.4S
    SHA256SU0  V11.4S, V9.4S
    SHA1M  Q26, S10, V23.4S
    SHA256SU1  V29.4S, V8.4S, V2.4S
    SHA1C  Q21, S0, V7.4S
    SHA256SU0  V22.4S, V13.4S
    SHA256H  Q0, Q29, V10.4S
    SHA1P  Q7, S22, V11.4S
    SHA256SU0  V15.4S, V18.4S
    SHA256H  Q2, Q31, V0.4S
    SHA1P  Q18, S16, V22.4S
    SHA256H2  Q11, Q2, V12.4S
    SHA1SU1  V8.4S, V18.4S
    SHA1SU0  V16.4S, V16.4S, V11.4S
    SHA1SU0  V0.4S, V18.4S, V15.4S
    SHA256H  Q11, Q11, V30.4S
    SHA1P  Q18, S15, V11.4S
    SHA1P  Q22, S26, V15.4S
    SHA1M  Q11, S22, V19.4S
    SHA256H  Q22, Q8, V26.4S
    SHA256H  Q15, Q21, V22.4S
    SHA1C  Q12, S16, V1.4S
    SHA256SU1  V30.4S, V18.4S, V2.4S
    SHA1C  Q0, S11, V0.4S
    SHA1SU0  V26.4S, V28.4S, V0.4S
    SUBS  X15, X15, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_2
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X25, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X25, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X25, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X25, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X25, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X25, X24, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X25, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X25, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X25, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X25, X24, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X25, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X25, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X25, X24, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X25, X24, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X25, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X25, X24, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X25, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X25, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X25, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MRS  X24, FPSR
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V0.D[1]
    MOVZ  X25, #0x25f9, LSL #0
    MOVK  X25, #0xbd9c, LSL #16
    MOVK  X25, #0x4cb9, LSL #32
    MOVK  X25, #0xf07e, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D0
    MOVZ  X25, #0x6e74, LSL #0
    MOVK  X25, #0x8b8c, LSL #16
    MOVK  X25, #0x3f96, LSL #32
    MOVK  X25, #0x33dd, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V1.D[1]
    MOVZ  X25, #0x1b7a, LSL #0
    MOVK  X25, #0x2b66, LSL #16
    MOVK  X25, #0x67ae, LSL #32
    MOVK  X25, #0x2c13, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D1
    MOVZ  X25, #0xdf17, LSL #0
    MOVK  X25, #0xc451, LSL #16
    MOVK  X25, #0x1786, LSL #32
    MOVK  X25, #0xf14b, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V2.D[1]
    MOVZ  X25, #0x2cca, LSL #0
    MOVK  X25, #0xe0b2, LSL #16
    MOVK  X25, #0x3578, LSL #32
    MOVK  X25, #0xd39c, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D2
    MOVZ  X25, #0xf6b5, LSL #0
    MOVK  X25, #0x2e7b, LSL #16
    MOVK  X25, #0xe652, LSL #32
    MOVK  X25, #0x15fc, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V3.D[1]
    MOVZ  X25, #0x35b4, LSL #0
    MOVK  X25, #0x502e, LSL #16
    MOVK  X25, #0xdeda, LSL #32
    MOVK  X25, #0x5197, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D3
    MOVZ  X25, #0xdd1b, LSL #0
    MOVK  X25, #0x5926, LSL #16
    MOVK  X25, #0x6f24, LSL #32
    MOVK  X25, #0xa0, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X25, #0x1c7e, LSL #0
    MOVK  X25, #0x7149, LSL #16
    MOVK  X25, #0x12c8, LSL #32
    MOVK  X25, #0x31fb, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D4
    MOVZ  X25, #0x447e, LSL #0
    MOVK  X25, #0x8f13, LSL #16
    MOVK  X25, #0x215c, LSL #32
    MOVK  X25, #0xcd83, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X25, #0x3647, LSL #0
    MOVK  X25, #0x7253, LSL #16
    MOVK  X25, #0x6de6, LSL #32
    MOVK  X25, #0xe9b4, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D5
    MOVZ  X25, #0x4ecf, LSL #0
    MOVK  X25, #0x3711, LSL #16
    MOVK  X25, #0x3dbb, LSL #32
    MOVK  X25, #0xf0cf, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X25, #0xa9b3, LSL #0
    MOVK  X25, #0x73bb, LSL #16
    MOVK  X25, #0xc16c, LSL #32
    MOVK  X25, #0x38b4, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D6
    MOVZ  X25, #0x892, LSL #0
    MOVK  X25, #0x6256, LSL #16
    MOVK  X25, #0x20c2, LSL #32
    MOVK  X25, #0xf821, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X25, #0x80a8, LSL #0
    MOVK  X25, #0xba4e, LSL #16
    MOVK  X25, #0x3c7c, LSL #32
    MOVK  X25, #0xb471, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D7
    MOVZ  X25, #0x3252, LSL #0
    MOVK  X25, #0xfee4, LSL #16
    MOVK  X25, #0x603, LSL #32
    MOVK  X25, #0x54c, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V8.D[1]
    MOVZ  X25, #0xf0d, LSL #0
    MOVK  X25, #0xa3ae, LSL #16
    MOVK  X25, #0x151d, LSL #32
    MOVK  X25, #0xdb76, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D8
    MOVZ  X25, #0x6d1d, LSL #0
    MOVK  X25, #0xe5ca, LSL #16
    MOVK  X25, #0xb179, LSL #32
    MOVK  X25, #0xc1e4, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X25, #0x6174, LSL #0
    MOVK  X25, #0x3969, LSL #16
    MOVK  X25, #0x5016, LSL #32
    MOVK  X25, #0xac56, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D9
    MOVZ  X25, #0xd1f8, LSL #0
    MOVK  X25, #0xa96a, LSL #16
    MOVK  X25, #0xecd6, LSL #32
    MOVK  X25, #0xfeb0, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V10.D[1]
    MOVZ  X25, #0xe893, LSL #0
    MOVK  X25, #0x10ec, LSL #16
    MOVK  X25, #0x9aab, LSL #32
    MOVK  X25, #0x5270, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D10
    MOVZ  X25, #0xa226, LSL #0
    MOVK  X25, #0x9bb7, LSL #16
    MOVK  X25, #0xf558, LSL #32
    MOVK  X25, #0xb372, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V11.D[1]
    MOVZ  X25, #0xe729, LSL #0
    MOVK  X25, #0x5cf, LSL #16
    MOVK  X25, #0xb4fa, LSL #32
    MOVK  X25, #0x51d2, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D11
    MOVZ  X25, #0x1f4f, LSL #0
    MOVK  X25, #0xc862, LSL #16
    MOVK  X25, #0xbd03, LSL #32
    MOVK  X25, #0x1453, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V12.D[1]
    MOVZ  X25, #0xaaeb, LSL #0
    MOVK  X25, #0x3c87, LSL #16
    MOVK  X25, #0xdbe7, LSL #32
    MOVK  X25, #0x74c4, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D12
    MOVZ  X25, #0x86c8, LSL #0
    MOVK  X25, #0x2d99, LSL #16
    MOVK  X25, #0x730c, LSL #32
    MOVK  X25, #0xac78, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V13.D[1]
    MOVZ  X25, #0xe2f7, LSL #0
    MOVK  X25, #0x9b80, LSL #16
    MOVK  X25, #0x8430, LSL #32
    MOVK  X25, #0x3c76, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D13
    MOVZ  X25, #0x82a9, LSL #0
    MOVK  X25, #0xc270, LSL #16
    MOVK  X25, #0x3ea0, LSL #32
    MOVK  X25, #0xed6c, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X25, #0xa1f9, LSL #0
    MOVK  X25, #0x54d3, LSL #16
    MOVK  X25, #0xabff, LSL #32
    MOVK  X25, #0x8f68, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D14
    MOVZ  X25, #0xd17e, LSL #0
    MOVK  X25, #0xe14c, LSL #16
    MOVK  X25, #0x205a, LSL #32
    MOVK  X25, #0xc35, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X25, #0x14e6, LSL #0
    MOVK  X25, #0x79a3, LSL #16
    MOVK  X25, #0xbd19, LSL #32
    MOVK  X25, #0x47c6, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D15
    MOVZ  X25, #0xa12e, LSL #0
    MOVK  X25, #0x2429, LSL #16
    MOVK  X25, #0x9fe6, LSL #32
    MOVK  X25, #0x28ae, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V16.D[1]
    MOVZ  X25, #0xfda3, LSL #0
    MOVK  X25, #0xb8fd, LSL #16
    MOVK  X25, #0x64f3, LSL #32
    MOVK  X25, #0x74f2, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D16
    MOVZ  X25, #0x19f6, LSL #0
    MOVK  X25, #0xe64, LSL #16
    MOVK  X25, #0xae3b, LSL #32
    MOVK  X25, #0x4d2d, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X25, #0x8fc3, LSL #0
    MOVK  X25, #0xc5bd, LSL #16
    MOVK  X25, #0x69a1, LSL #32
    MOVK  X25, #0x5fce, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D17
    MOVZ  X25, #0x63be, LSL #0
    MOVK  X25, #0xe496, LSL #16
    MOVK  X25, #0x2c0c, LSL #32
    MOVK  X25, #0xcfdf, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V18.D[1]
    MOVZ  X25, #0x159c, LSL #0
    MOVK  X25, #0xef9a, LSL #16
    MOVK  X25, #0xc41, LSL #32
    MOVK  X25, #0xcbbb, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D18
    MOVZ  X25, #0xa956, LSL #0
    MOVK  X25, #0x7196, LSL #16
    MOVK  X25, #0x2a05, LSL #32
    MOVK  X25, #0x2e07, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X25, #0x499e, LSL #0
    MOVK  X25, #0x40ac, LSL #16
    MOVK  X25, #0x5952, LSL #32
    MOVK  X25, #0x9cd0, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D19
    MOVZ  X25, #0xc67b, LSL #0
    MOVK  X25, #0x157, LSL #16
    MOVK  X25, #0x3446, LSL #32
    MOVK  X25, #0x4d49, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X25, #0x4f17, LSL #0
    MOVK  X25, #0xee5f, LSL #16
    MOVK  X25, #0xccc1, LSL #32
    MOVK  X25, #0xba9d, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D20
    MOVZ  X25, #0xdd35, LSL #0
    MOVK  X25, #0xb159, LSL #16
    MOVK  X25, #0x8385, LSL #32
    MOVK  X25, #0x4252, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V21.D[1]
    MOVZ  X25, #0x232a, LSL #0
    MOVK  X25, #0x7e0e, LSL #16
    MOVK  X25, #0x2a22, LSL #32
    MOVK  X25, #0xa760, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D21
    MOVZ  X25, #0x1ce9, LSL #0
    MOVK  X25, #0x15a9, LSL #16
    MOVK  X25, #0xaab0, LSL #32
    MOVK  X25, #0xd9a2, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V22.D[1]
    MOVZ  X25, #0xdde4, LSL #0
    MOVK  X25, #0x9387, LSL #16
    MOVK  X25, #0x23d5, LSL #32
    MOVK  X25, #0x636d, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D22
    MOVZ  X25, #0xbc95, LSL #0
    MOVK  X25, #0x2937, LSL #16
    MOVK  X25, #0x888e, LSL #32
    MOVK  X25, #0xb781, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V23.D[1]
    MOVZ  X25, #0x51e4, LSL #0
    MOVK  X25, #0x60f5, LSL #16
    MOVK  X25, #0x617b, LSL #32
    MOVK  X25, #0xd972, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D23
    MOVZ  X25, #0x5a9e, LSL #0
    MOVK  X25, #0x5c82, LSL #16
    MOVK  X25, #0x833a, LSL #32
    MOVK  X25, #0xd9f, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V24.D[1]
    MOVZ  X25, #0xc2d1, LSL #0
    MOVK  X25, #0x535f, LSL #16
    MOVK  X25, #0xf1f4, LSL #32
    MOVK  X25, #0xfc03, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D24
    MOVZ  X25, #0xc991, LSL #0
    MOVK  X25, #0x8697, LSL #16
    MOVK  X25, #0x9107, LSL #32
    MOVK  X25, #0x124e, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V25.D[1]
    MOVZ  X25, #0x16ce, LSL #0
    MOVK  X25, #0xda74, LSL #16
    MOVK  X25, #0xd905, LSL #32
    MOVK  X25, #0x1b52, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D25
    MOVZ  X25, #0x8010, LSL #0
    MOVK  X25, #0x93da, LSL #16
    MOVK  X25, #0x60f, LSL #32
    MOVK  X25, #0xc94f, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V26.D[1]
    MOVZ  X25, #0x6d58, LSL #0
    MOVK  X25, #0xc68d, LSL #16
    MOVK  X25, #0xcc, LSL #32
    MOVK  X25, #0x632e, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D26
    MOVZ  X25, #0x4080, LSL #0
    MOVK  X25, #0x272, LSL #16
    MOVK  X25, #0x35ed, LSL #32
    MOVK  X25, #0xb33d, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X25, #0x94bf, LSL #0
    MOVK  X25, #0x11b1, LSL #16
    MOVK  X25, #0x9700, LSL #32
    MOVK  X25, #0xc42b, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D27
    MOVZ  X25, #0xc127, LSL #0
    MOVK  X25, #0x6248, LSL #16
    MOVK  X25, #0x1eae, LSL #32
    MOVK  X25, #0xd8b2, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V28.D[1]
    MOVZ  X25, #0xcfab, LSL #0
    MOVK  X25, #0x8a92, LSL #16
    MOVK  X25, #0x16fc, LSL #32
    MOVK  X25, #0x9ebe, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D28
    MOVZ  X25, #0xa04f, LSL #0
    MOVK  X25, #0xdfc9, LSL #16
    MOVK  X25, #0x12c4, LSL #32
    MOVK  X25, #0x74a5, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V29.D[1]
    MOVZ  X25, #0x6f6a, LSL #0
    MOVK  X25, #0x4c28, LSL #16
    MOVK  X25, #0xe031, LSL #32
    MOVK  X25, #0x5719, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D29
    MOVZ  X25, #0x2658, LSL #0
    MOVK  X25, #0x78e, LSL #16
    MOVK  X25, #0xaa0b, LSL #32
    MOVK  X25, #0x4388, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V30.D[1]
    MOVZ  X25, #0x3a3c, LSL #0
    MOVK  X25, #0xa96c, LSL #16
    MOVK  X25, #0x6ddd, LSL #32
    MOVK  X25, #0x42f4, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D30
    MOVZ  X25, #0xb1da, LSL #0
    MOVK  X25, #0x869e, LSL #16
    MOVK  X25, #0x9855, LSL #32
    MOVK  X25, #0x600a, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, V31.D[1]
    MOVZ  X25, #0x2a7a, LSL #0
    MOVK  X25, #0xbdae, LSL #16
    MOVK  X25, #0x9d24, LSL #32
    MOVK  X25, #0xdb15, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X24, D31
    MOVZ  X25, #0xe184, LSL #0
    MOVK  X25, #0x4828, LSL #16
    MOVK  X25, #0x4a75, LSL #32
    MOVK  X25, #0x17a8, LSL #48
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSecureHashStandard_TestFail
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
    FMOV  D0, X24
    FMOV  V0.D[1], X26
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X6
    FMOV  D3, X11
    FMOV  V3.D[1], X29
    FMOV  D4, X8
    FMOV  V4.D[1], X4
    FMOV  D5, X4
    FMOV  V5.D[1], X12
    FMOV  D6, X3
    FMOV  V6.D[1], X13
    FMOV  D7, X12
    FMOV  V7.D[1], X2
    FMOV  D8, X11
    FMOV  V8.D[1], X27
    FMOV  D9, X15
    FMOV  V9.D[1], X6
    FMOV  D10, X10
    FMOV  V10.D[1], X4
    FMOV  D11, X15
    FMOV  V11.D[1], X8
    FMOV  D12, X16
    FMOV  V12.D[1], X10
    FMOV  D13, X3
    FMOV  V13.D[1], X8
    FMOV  D14, X24
    FMOV  V14.D[1], X16
    FMOV  D15, X28
    FMOV  V15.D[1], X24
    FMOV  D16, X10
    FMOV  V16.D[1], X9
    FMOV  D17, X6
    FMOV  V17.D[1], X10
    FMOV  D18, X23
    FMOV  V18.D[1], X27
    FMOV  D19, X27
    FMOV  V19.D[1], X8
    FMOV  D20, X29
    FMOV  V20.D[1], X27
    FMOV  D21, X29
    FMOV  V21.D[1], X15
    FMOV  D22, X7
    FMOV  V22.D[1], X16
    FMOV  D23, X12
    FMOV  V23.D[1], X13
    FMOV  D24, X28
    FMOV  V24.D[1], X9
    FMOV  D25, X24
    FMOV  V25.D[1], X14
    FMOV  D26, X14
    FMOV  V26.D[1], X28
    FMOV  D27, X28
    FMOV  V27.D[1], X28
    FMOV  D28, X3
    FMOV  V28.D[1], X12
    FMOV  D29, X13
    FMOV  V29.D[1], X7
    FMOV  D30, X24
    FMOV  V30.D[1], X15
    FMOV  D31, X10
    FMOV  V31.D[1], X7
    MOVZ  X17, #0xa, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_3:
    SHA1SU1  V20.4S, V2.4S
    SHA1SU1  V14.4S, V27.4S
    SHA1M  Q11, S28, V20.4S
    SHA1M  Q20, S25, V26.4S
    SHA256SU0  V18.4S, V8.4S
    SHA1C  Q17, S30, V18.4S
    SHA256H2  Q15, Q28, V11.4S
    SHA1SU0  V3.4S, V15.4S, V31.4S
    SHA256H2  Q14, Q29, V20.4S
    SHA1SU0  V20.4S, V25.4S, V17.4S
    SHA1SU0  V28.4S, V14.4S, V14.4S
    SHA256SU0  V7.4S, V3.4S
    SHA256H  Q8, Q24, V7.4S
    SHA1M  Q3, S31, V19.4S
    SHA256SU1  V15.4S, V20.4S, V6.4S
    SHA1P  Q6, S28, V8.4S
    SHA256H  Q28, Q15, V9.4S
    SHA256H  Q15, Q3, V28.4S
    SHA1SU1  V8.4S, V2.4S
    SHA1M  Q28, S0, V24.4S
    SHA1SU1  V29.4S, V21.4S
    SHA1SU0  V3.4S, V0.4S, V31.4S
    SHA256H  Q11, Q16, V23.4S
    SHA256SU1  V23.4S, V4.4S, V10.4S
    SHA1M  Q7, S16, V25.4S
    SHA1SU0  V7.4S, V27.4S, V24.4S
    SHA256SU0  V23.4S, V23.4S
    SHA256SU1  V15.4S, V9.4S, V23.4S
    SHA1SU1  V20.4S, V24.4S
    SHA1M  Q2, S1, V4.4S
    SHA256SU1  V23.4S, V11.4S, V29.4S
    SHA256H2  Q6, Q16, V6.4S
    SHA256SU1  V31.4S, V20.4S, V20.4S
    SHA1M  Q17, S2, V15.4S
    SHA256SU0  V1.4S, V31.4S
    SHA1P  Q21, S28, V7.4S
    SHA256SU0  V11.4S, V8.4S
    SHA256SU0  V19.4S, V11.4S
    SHA1M  Q0, S17, V6.4S
    SHA256H2  Q7, Q8, V0.4S
    SHA1SU1  V14.4S, V7.4S
    SHA256SU0  V23.4S, V14.4S
    SHA256SU0  V15.4S, V1.4S
    SHA1SU1  V31.4S, V15.4S
    SHA256SU0  V7.4S, V31.4S
    SHA256H  Q28, Q23, V18.4S
    SHA1SU1  V14.4S, V15.4S
    SHA1SU0  V11.4S, V28.4S, V21.4S
    SHA256H2  Q16, Q16, V7.4S
    SHA256SU1  V0.4S, V14.4S, V11.4S
    SHA256SU0  V25.4S, V19.4S
    SHA256SU0  V31.4S, V13.4S
    SHA256H  Q17, Q20, V16.4S
    SHA1SU0  V7.4S, V14.4S, V31.4S
    SHA1SU1  V31.4S, V16.4S
    SHA256H2  Q2, Q5, V15.4S
    SHA256SU0  V13.4S, V31.4S
    SHA1C  Q9, S0, V17.4S
    SHA1SU1  V10.4S, V9.4S
    SHA256H  Q31, Q13, V25.4S
    SHA1C  Q17, S22, V1.4S
    SHA256H  Q23, Q7, V2.4S
    SHA1SU1  V21.4S, V17.4S
    SHA1SU1  V21.4S, V16.4S
    SHA1M  Q19, S23, V16.4S
    SHA256SU0  V13.4S, V21.4S
    SHA1M  Q7, S16, V23.4S
    SHA256H  Q15, Q16, V13.4S
    SHA256SU1  V21.4S, V1.4S, V31.4S
    SHA1SU0  V9.4S, V10.4S, V19.4S
    SHA1C  Q16, S18, V9.4S
    SHA256SU0  V25.4S, V21.4S
    SHA256SU1  V22.4S, V25.4S, V11.4S
    SHA256SU0  V17.4S, V16.4S
    SHA1SU1  V19.4S, V2.4S
    SHA256H2  Q24, Q5, V19.4S
    SHA1M  Q20, S17, V17.4S
    SHA256SU1  V21.4S, V22.4S, V15.4S
    SHA1C  Q17, S11, V21.4S
    SHA256SU0  V22.4S, V20.4S
    SHA256H  Q1, Q24, V7.4S
    SHA1C  Q20, S1, V22.4S
    SHA1C  Q22, S18, V23.4S
    SHA256SU0  V7.4S, V14.4S
    SHA1M  Q0, S5, V22.4S
    SHA256SU1  V12.4S, V13.4S, V18.4S
    SHA1SU0  V11.4S, V15.4S, V28.4S
    SHA1SU1  V19.4S, V9.4S
    SHA1SU0  V24.4S, V24.4S, V26.4S
    SHA1M  Q23, S0, V1.4S
    SHA1SU1  V18.4S, V26.4S
    SHA256H2  Q20, Q20, V7.4S
    SHA1P  Q21, S11, V12.4S
    SHA1SU0  V26.4S, V20.4S, V17.4S
    SHA256H  Q13, Q21, V23.4S
    SHA1M  Q14, S13, V19.4S
    SHA256H  Q7, Q19, V26.4S
    SHA1SU1  V16.4S, V14.4S
    SHA1M  Q22, S9, V24.4S
    SHA256SU0  V11.4S, V2.4S
    SHA1SU0  V19.4S, V11.4S, V11.4S
    SHA1C  Q21, S27, V26.4S
    SHA1C  Q10, S18, V24.4S
    SHA1M  Q14, S3, V21.4S
    SHA1M  Q5, S22, V13.4S
    SHA1SU0  V27.4S, V21.4S, V10.4S
    SHA256H  Q21, Q7, V8.4S
    SHA256H  Q10, Q15, V22.4S
    SHA1C  Q8, S27, V27.4S
    SHA1SU0  V23.4S, V8.4S, V19.4S
    SHA1P  Q28, S10, V5.4S
    SHA256SU0  V11.4S, V0.4S
    SHA1C  Q2, S11, V8.4S
    SHA1M  Q5, S0, V16.4S
    SHA1SU1  V19.4S, V29.4S
    SHA256H2  Q13, Q31, V23.4S
    SHA256H  Q30, Q20, V8.4S
    SHA256SU1  V16.4S, V30.4S, V19.4S
    SHA256SU1  V26.4S, V13.4S, V2.4S
    SHA256SU1  V0.4S, V4.4S, V28.4S
    SHA256SU0  V18.4S, V7.4S
    SHA1M  Q10, S5, V5.4S
    SHA256SU1  V24.4S, V5.4S, V21.4S
    SHA1SU1  V15.4S, V16.4S
    SHA1M  Q8, S21, V18.4S
    SHA256SU0  V2.4S, V26.4S
    SHA1P  Q22, S0, V16.4S
    SHA256H  Q11, Q22, V15.4S
    SHA1SU1  V29.4S, V14.4S
    SHA1C  Q25, S11, V29.4S
    SHA1SU0  V19.4S, V10.4S, V25.4S
    SHA1P  Q7, S26, V11.4S
    SHA1SU1  V10.4S, V25.4S
    SHA256H2  Q13, Q24, V7.4S
    SHA1SU0  V24.4S, V2.4S, V26.4S
    SHA256H  Q28, Q13, V13.4S
    SHA256H2  Q12, Q24, V13.4S
    SHA256H  Q4, Q19, V9.4S
    SHA256SU0  V27.4S, V12.4S
    SHA1C  Q26, S10, V10.4S
    SHA256SU0  V2.4S, V8.4S
    SHA1C  Q8, S27, V6.4S
    SHA256SU1  V27.4S, V23.4S, V20.4S
    SHA256SU1  V18.4S, V12.4S, V4.4S
    SHA1M  Q5, S26, V27.4S
    SHA1SU1  V13.4S, V2.4S
    SHA1SU0  V6.4S, V13.4S, V5.4S
    SHA256SU1  V23.4S, V8.4S, V6.4S
    SHA1C  Q0, S25, V28.4S
    SHA256H  Q27, Q23, V9.4S
    SHA1M  Q19, S0, V27.4S
    SHA1SU1  V20.4S, V9.4S
    SHA1SU0  V26.4S, V10.4S, V13.4S
    SHA1SU0  V9.4S, V13.4S, V0.4S
    SHA256SU1  V13.4S, V1.4S, V20.4S
    SHA1M  Q2, S1, V0.4S
    SHA256H  Q20, Q24, V3.4S
    SHA256SU1  V22.4S, V17.4S, V8.4S
    SHA1SU1  V8.4S, V7.4S
    SHA1P  Q7, S20, V18.4S
    SHA1M  Q0, S22, V2.4S
    SHA1M  Q28, S9, V13.4S
    SHA1P  Q4, S19, V2.4S
    SHA256SU0  V19.4S, V17.4S
    SHA1SU1  V12.4S, V28.4S
    SHA1P  Q5, S21, V30.4S
    SHA1C  Q22, S12, V0.4S
    SHA1P  Q21, S11, V8.4S
    SHA1P  Q13, S4, V19.4S
    SHA1M  Q1, S17, V13.4S
    SHA1SU0  V18.4S, V23.4S, V7.4S
    SHA256H  Q0, Q22, V23.4S
    SHA1P  Q6, S3, V5.4S
    SHA1M  Q27, S21, V0.4S
    SHA256H2  Q7, Q6, V1.4S
    SHA1SU0  V30.4S, V18.4S, V22.4S
    SHA1SU1  V6.4S, V4.4S
    SHA1SU0  V5.4S, V27.4S, V27.4S
    SHA1M  Q17, S6, V18.4S
    SHA256H2  Q21, Q17, V24.4S
    SHA256H  Q23, Q5, V6.4S
    SHA256H  Q4, Q30, V30.4S
    SHA256SU1  V1.4S, V21.4S, V21.4S
    SHA256SU1  V18.4S, V27.4S, V29.4S
    SHA1SU0  V13.4S, V7.4S, V18.4S
    SHA1SU0  V0.4S, V3.4S, V30.4S
    SHA256H2  Q11, Q4, V4.4S
    SHA256H2  Q30, Q0, V23.4S
    SHA1P  Q9, S1, V11.4S
    SHA256SU0  V29.4S, V30.4S
    SHA1P  Q18, S9, V29.4S
    SHA1C  Q17, S31, V20.4S
    SHA256SU1  V1.4S, V22.4S, V15.4S
    SHA1P  Q6, S22, V27.4S
    SHA256SU0  V22.4S, V17.4S
    SHA256H  Q5, Q8, V2.4S
    SHA256H2  Q9, Q27, V14.4S
    SHA256H  Q30, Q4, V14.4S
    SHA256H  Q27, Q17, V29.4S
    SHA1C  Q31, S5, V18.4S
    SUBS  X17, X17, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_3
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MRS  X8, FPSR
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V0.D[1]
    MOVZ  X7, #0x802e, LSL #0
    MOVK  X7, #0x7d2, LSL #16
    MOVK  X7, #0xf9f6, LSL #32
    MOVK  X7, #0x7c6f, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D0
    MOVZ  X7, #0xa0a, LSL #0
    MOVK  X7, #0x694f, LSL #16
    MOVK  X7, #0x1c17, LSL #32
    MOVK  X7, #0xc401, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V1.D[1]
    MOVZ  X7, #0x2b1b, LSL #0
    MOVK  X7, #0xe37, LSL #16
    MOVK  X7, #0x8adb, LSL #32
    MOVK  X7, #0xe415, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D1
    MOVZ  X7, #0xe2f9, LSL #0
    MOVK  X7, #0xaebc, LSL #16
    MOVK  X7, #0xa687, LSL #32
    MOVK  X7, #0x10f, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X7, #0x1a5c, LSL #0
    MOVK  X7, #0x607d, LSL #16
    MOVK  X7, #0xccd1, LSL #32
    MOVK  X7, #0x6e72, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D2
    MOVZ  X7, #0x4988, LSL #0
    MOVK  X7, #0x3a41, LSL #16
    MOVK  X7, #0xc43e, LSL #32
    MOVK  X7, #0x3204, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X7, #0xa6ca, LSL #0
    MOVK  X7, #0xe320, LSL #16
    MOVK  X7, #0x69d, LSL #32
    MOVK  X7, #0x8728, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D3
    MOVZ  X7, #0xc4ef, LSL #0
    MOVK  X7, #0x18b, LSL #16
    MOVK  X7, #0xb415, LSL #32
    MOVK  X7, #0xb057, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X7, #0xf982, LSL #0
    MOVK  X7, #0xb63a, LSL #16
    MOVK  X7, #0x5fd9, LSL #32
    MOVK  X7, #0x9aac, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D4
    MOVZ  X7, #0x631c, LSL #0
    MOVK  X7, #0xc63b, LSL #16
    MOVK  X7, #0xa633, LSL #32
    MOVK  X7, #0x4a97, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X7, #0x8b90, LSL #0
    MOVK  X7, #0xc5e4, LSL #16
    MOVK  X7, #0x9db4, LSL #32
    MOVK  X7, #0xd7ea, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D5
    MOVZ  X7, #0x6a3, LSL #0
    MOVK  X7, #0x38d9, LSL #16
    MOVK  X7, #0x5897, LSL #32
    MOVK  X7, #0xa001, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X7, #0xed0f, LSL #0
    MOVK  X7, #0xc276, LSL #16
    MOVK  X7, #0xe614, LSL #32
    MOVK  X7, #0x2ad5, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D6
    MOVZ  X7, #0xce5, LSL #0
    MOVK  X7, #0x55d0, LSL #16
    MOVK  X7, #0xab86, LSL #32
    MOVK  X7, #0x9db4, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X7, #0x9ce, LSL #0
    MOVK  X7, #0x7314, LSL #16
    MOVK  X7, #0x598e, LSL #32
    MOVK  X7, #0x37f8, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D7
    MOVZ  X7, #0xd32b, LSL #0
    MOVK  X7, #0xecba, LSL #16
    MOVK  X7, #0xd7d8, LSL #32
    MOVK  X7, #0x1609, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V8.D[1]
    MOVZ  X7, #0x7609, LSL #0
    MOVK  X7, #0x7d, LSL #16
    MOVK  X7, #0x1d56, LSL #32
    MOVK  X7, #0xefa2, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D8
    MOVZ  X7, #0x6de1, LSL #0
    MOVK  X7, #0x58c, LSL #16
    MOVK  X7, #0x4060, LSL #32
    MOVK  X7, #0x1af3, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X7, #0x4e53, LSL #0
    MOVK  X7, #0x3008, LSL #16
    MOVK  X7, #0xf474, LSL #32
    MOVK  X7, #0x396e, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D9
    MOVZ  X7, #0x1088, LSL #0
    MOVK  X7, #0xe6b4, LSL #16
    MOVK  X7, #0x5ea8, LSL #32
    MOVK  X7, #0xc596, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X7, #0x9913, LSL #0
    MOVK  X7, #0x807a, LSL #16
    MOVK  X7, #0x2d4e, LSL #32
    MOVK  X7, #0x5b33, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D10
    MOVZ  X7, #0x298e, LSL #0
    MOVK  X7, #0xd8e7, LSL #16
    MOVK  X7, #0x75ce, LSL #32
    MOVK  X7, #0x4fdb, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X7, #0xbaf5, LSL #0
    MOVK  X7, #0x94, LSL #16
    MOVK  X7, #0x6643, LSL #32
    MOVK  X7, #0x7ee7, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D11
    MOVZ  X7, #0xb938, LSL #0
    MOVK  X7, #0x9617, LSL #16
    MOVK  X7, #0x1a13, LSL #32
    MOVK  X7, #0xf4df, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X7, #0xad6, LSL #0
    MOVK  X7, #0xf55b, LSL #16
    MOVK  X7, #0xc0a5, LSL #32
    MOVK  X7, #0x5bb2, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D12
    MOVZ  X7, #0xf793, LSL #0
    MOVK  X7, #0x9d3d, LSL #16
    MOVK  X7, #0x40b3, LSL #32
    MOVK  X7, #0x8dcd, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X7, #0x3a10, LSL #0
    MOVK  X7, #0x2aed, LSL #16
    MOVK  X7, #0x2290, LSL #32
    MOVK  X7, #0xaf8f, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D13
    MOVZ  X7, #0xabc5, LSL #0
    MOVK  X7, #0xde8c, LSL #16
    MOVK  X7, #0x537f, LSL #32
    MOVK  X7, #0xdfa6, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X7, #0x103, LSL #0
    MOVK  X7, #0x858e, LSL #16
    MOVK  X7, #0x8a5, LSL #32
    MOVK  X7, #0xd44e, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D14
    MOVZ  X7, #0xa4b1, LSL #0
    MOVK  X7, #0x2adc, LSL #16
    MOVK  X7, #0xda59, LSL #32
    MOVK  X7, #0xad5a, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X7, #0x2b05, LSL #0
    MOVK  X7, #0x70ad, LSL #16
    MOVK  X7, #0x60, LSL #32
    MOVK  X7, #0xafa9, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D15
    MOVZ  X7, #0x7181, LSL #0
    MOVK  X7, #0xaf0e, LSL #16
    MOVK  X7, #0xf89c, LSL #32
    MOVK  X7, #0xc3ab, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X7, #0x68eb, LSL #0
    MOVK  X7, #0xb318, LSL #16
    MOVK  X7, #0xfeaa, LSL #32
    MOVK  X7, #0x189c, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D16
    MOVZ  X7, #0x91b6, LSL #0
    MOVK  X7, #0x38a9, LSL #16
    MOVK  X7, #0x4052, LSL #32
    MOVK  X7, #0x4b96, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X7, #0xb67e, LSL #0
    MOVK  X7, #0x907e, LSL #16
    MOVK  X7, #0x4574, LSL #32
    MOVK  X7, #0x5e38, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D17
    MOVZ  X7, #0xa9db, LSL #0
    MOVK  X7, #0xea8c, LSL #16
    MOVK  X7, #0x695d, LSL #32
    MOVK  X7, #0xe339, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X7, #0x1f96, LSL #0
    MOVK  X7, #0x1b85, LSL #16
    MOVK  X7, #0xcb47, LSL #32
    MOVK  X7, #0x46e3, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D18
    MOVZ  X7, #0x51ad, LSL #0
    MOVK  X7, #0x6370, LSL #16
    MOVK  X7, #0xc98b, LSL #32
    MOVK  X7, #0x571b, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X7, #0xb834, LSL #0
    MOVK  X7, #0x645b, LSL #16
    MOVK  X7, #0x73c0, LSL #32
    MOVK  X7, #0x47d4, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D19
    MOVZ  X7, #0x5284, LSL #0
    MOVK  X7, #0x2d4c, LSL #16
    MOVK  X7, #0xcd49, LSL #32
    MOVK  X7, #0x72a1, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X7, #0xd621, LSL #0
    MOVK  X7, #0xc129, LSL #16
    MOVK  X7, #0xebaa, LSL #32
    MOVK  X7, #0xac02, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D20
    MOVZ  X7, #0xc52, LSL #0
    MOVK  X7, #0x2737, LSL #16
    MOVK  X7, #0x2375, LSL #32
    MOVK  X7, #0xedd9, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X7, #0xc222, LSL #0
    MOVK  X7, #0x4b5a, LSL #16
    MOVK  X7, #0xf161, LSL #32
    MOVK  X7, #0xaa3e, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D21
    MOVZ  X7, #0x43f7, LSL #0
    MOVK  X7, #0x4a2b, LSL #16
    MOVK  X7, #0x7d64, LSL #32
    MOVK  X7, #0xebdc, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X7, #0x9a8d, LSL #0
    MOVK  X7, #0x34eb, LSL #16
    MOVK  X7, #0xe771, LSL #32
    MOVK  X7, #0xf6bb, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D22
    MOVZ  X7, #0x34cb, LSL #0
    MOVK  X7, #0xf107, LSL #16
    MOVK  X7, #0xbf94, LSL #32
    MOVK  X7, #0xad61, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X7, #0xcbaf, LSL #0
    MOVK  X7, #0xa4c9, LSL #16
    MOVK  X7, #0xf7a8, LSL #32
    MOVK  X7, #0x32be, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D23
    MOVZ  X7, #0xd74e, LSL #0
    MOVK  X7, #0xcc54, LSL #16
    MOVK  X7, #0xcfe5, LSL #32
    MOVK  X7, #0xc3ac, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X7, #0xefec, LSL #0
    MOVK  X7, #0x5c08, LSL #16
    MOVK  X7, #0x3624, LSL #32
    MOVK  X7, #0x5b67, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D24
    MOVZ  X7, #0xdf47, LSL #0
    MOVK  X7, #0x7092, LSL #16
    MOVK  X7, #0x7d9d, LSL #32
    MOVK  X7, #0xf37e, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X7, #0xd2c3, LSL #0
    MOVK  X7, #0xf401, LSL #16
    MOVK  X7, #0xda04, LSL #32
    MOVK  X7, #0xecb7, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D25
    MOVZ  X7, #0xa1de, LSL #0
    MOVK  X7, #0xc030, LSL #16
    MOVK  X7, #0x9165, LSL #32
    MOVK  X7, #0x99df, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X7, #0x8923, LSL #0
    MOVK  X7, #0x2811, LSL #16
    MOVK  X7, #0x1f45, LSL #32
    MOVK  X7, #0x6c59, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D26
    MOVZ  X7, #0xb9f6, LSL #0
    MOVK  X7, #0x6fe, LSL #16
    MOVK  X7, #0x635c, LSL #32
    MOVK  X7, #0xe6bc, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X7, #0xbabe, LSL #0
    MOVK  X7, #0x477, LSL #16
    MOVK  X7, #0x7960, LSL #32
    MOVK  X7, #0xe0d0, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D27
    MOVZ  X7, #0xa5a4, LSL #0
    MOVK  X7, #0xb70f, LSL #16
    MOVK  X7, #0xb9cf, LSL #32
    MOVK  X7, #0xb88f, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X7, #0x7ee6, LSL #0
    MOVK  X7, #0x9b1e, LSL #16
    MOVK  X7, #0x984, LSL #32
    MOVK  X7, #0xa678, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D28
    MOVZ  X7, #0x6592, LSL #0
    MOVK  X7, #0xdcb8, LSL #16
    MOVK  X7, #0x7390, LSL #32
    MOVK  X7, #0xae61, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X7, #0xa26, LSL #0
    MOVK  X7, #0x24ec, LSL #16
    MOVK  X7, #0xad6d, LSL #32
    MOVK  X7, #0xb19f, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D29
    MOVZ  X7, #0xde1a, LSL #0
    MOVK  X7, #0x81df, LSL #16
    MOVK  X7, #0x7f8, LSL #32
    MOVK  X7, #0x455, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V30.D[1]
    MOVZ  X7, #0x5410, LSL #0
    MOVK  X7, #0x2062, LSL #16
    MOVK  X7, #0x78ae, LSL #32
    MOVK  X7, #0x5ee6, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D30
    MOVZ  X7, #0xb212, LSL #0
    MOVK  X7, #0xa179, LSL #16
    MOVK  X7, #0xb163, LSL #32
    MOVK  X7, #0x7e54, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, V31.D[1]
    MOVZ  X7, #0x9afe, LSL #0
    MOVK  X7, #0x197e, LSL #16
    MOVK  X7, #0xb36e, LSL #32
    MOVK  X7, #0x1a0a, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X8, D31
    MOVZ  X7, #0x586a, LSL #0
    MOVK  X7, #0x6d2, LSL #16
    MOVK  X7, #0x2f17, LSL #32
    MOVK  X7, #0xb20b, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorSecureHashStandard_TestFail
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
    FMOV  D0, X23
    FMOV  V0.D[1], X24
    FMOV  D1, X25
    FMOV  V1.D[1], X29
    FMOV  D2, X9
    FMOV  V2.D[1], X13
    FMOV  D3, X26
    FMOV  V3.D[1], X2
    FMOV  D4, X7
    FMOV  V4.D[1], X28
    FMOV  D5, X25
    FMOV  V5.D[1], X5
    FMOV  D6, X26
    FMOV  V6.D[1], X5
    FMOV  D7, X6
    FMOV  V7.D[1], X14
    FMOV  D8, X10
    FMOV  V8.D[1], X29
    FMOV  D9, X16
    FMOV  V9.D[1], X17
    FMOV  D10, X5
    FMOV  V10.D[1], X26
    FMOV  D11, X15
    FMOV  V11.D[1], X8
    FMOV  D12, X27
    FMOV  V12.D[1], X29
    FMOV  D13, X29
    FMOV  V13.D[1], X16
    FMOV  D14, X10
    FMOV  V14.D[1], X29
    FMOV  D15, X13
    FMOV  V15.D[1], X13
    FMOV  D16, X29
    FMOV  V16.D[1], X25
    FMOV  D17, X14
    FMOV  V17.D[1], X10
    FMOV  D18, X16
    FMOV  V18.D[1], X6
    FMOV  D19, X2
    FMOV  V19.D[1], X24
    FMOV  D20, X9
    FMOV  V20.D[1], X11
    FMOV  D21, X9
    FMOV  V21.D[1], X12
    FMOV  D22, X7
    FMOV  V22.D[1], X16
    FMOV  D23, X5
    FMOV  V23.D[1], X16
    FMOV  D24, X4
    FMOV  V24.D[1], X9
    FMOV  D25, X15
    FMOV  V25.D[1], X4
    FMOV  D26, X4
    FMOV  V26.D[1], X27
    FMOV  D27, X8
    FMOV  V27.D[1], X6
    FMOV  D28, X10
    FMOV  V28.D[1], X17
    FMOV  D29, X4
    FMOV  V29.D[1], X25
    FMOV  D30, X4
    FMOV  V30.D[1], X8
    FMOV  D31, X13
    FMOV  V31.D[1], X28
    MOVZ  X8, #0xa, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_4:
    SHA1SU1  V16.4S, V24.4S
    SHA256H  Q22, Q28, V30.4S
    SHA256SU1  V6.4S, V22.4S, V25.4S
    SHA1P  Q18, S29, V23.4S
    SHA256H  Q13, Q18, V6.4S
    SHA256SU1  V27.4S, V3.4S, V26.4S
    SHA1P  Q0, S13, V0.4S
    SHA1SU1  V12.4S, V5.4S
    SHA256H2  Q9, Q21, V27.4S
    SHA256H2  Q29, Q31, V16.4S
    SHA1SU1  V6.4S, V9.4S
    SHA1M  Q25, S12, V3.4S
    SHA256SU0  V21.4S, V3.4S
    SHA1SU1  V7.4S, V25.4S
    SHA256H  Q28, Q9, V18.4S
    SHA1M  Q23, S0, V7.4S
    SHA1M  Q9, S6, V3.4S
    SHA256H  Q12, Q22, V29.4S
    SHA1P  Q7, S28, V22.4S
    SHA256SU1  V20.4S, V14.4S, V7.4S
    SHA256SU0  V24.4S, V21.4S
    SHA256SU1  V20.4S, V24.4S, V24.4S
    SHA1M  Q0, S17, V9.4S
    SHA256H  Q16, Q6, V0.4S
    SHA1C  Q25, S23, V28.4S
    SHA1C  Q18, S16, V20.4S
    SHA1SU1  V29.4S, V1.4S
    SHA1M  Q12, S2, V26.4S
    SHA256SU0  V3.4S, V25.4S
    SHA1M  Q30, S16, V3.4S
    SHA1SU0  V3.4S, V12.4S, V31.4S
    SHA1SU1  V21.4S, V9.4S
    SHA1P  Q17, S11, V5.4S
    SHA1SU1  V26.4S, V29.4S
    SHA1M  Q24, S10, V4.4S
    SHA256SU0  V23.4S, V3.4S
    SHA1M  Q9, S30, V26.4S
    SHA1C  Q17, S9, V23.4S
    SHA1SU1  V25.4S, V7.4S
    SHA256H  Q26, Q18, V18.4S
    SHA1P  Q1, S14, V7.4S
    SHA1M  Q12, S7, V24.4S
    SHA256H2  Q20, Q26, V6.4S
    SHA1C  Q2, S13, V1.4S
    SHA1SU1  V30.4S, V22.4S
    SHA1SU0  V29.4S, V20.4S, V6.4S
    SHA1M  Q4, S8, V13.4S
    SHA256H  Q10, Q5, V19.4S
    SHA1M  Q9, S17, V25.4S
    SHA256SU0  V26.4S, V12.4S
    SHA256H2  Q7, Q10, V2.4S
    SHA256SU0  V3.4S, V29.4S
    SHA256SU0  V8.4S, V7.4S
    SHA1P  Q4, S9, V30.4S
    SHA256SU0  V2.4S, V26.4S
    SHA1M  Q1, S16, V8.4S
    SHA1P  Q3, S25, V4.4S
    SHA1C  Q23, S8, V21.4S
    SHA1P  Q29, S23, V25.4S
    SHA1M  Q26, S12, V29.4S
    SHA256H2  Q5, Q14, V11.4S
    SHA256SU0  V13.4S, V26.4S
    SHA1C  Q7, S2, V2.4S
    SHA256H2  Q26, Q3, V4.4S
    SHA256H2  Q6, Q26, V1.4S
    SHA256H2  Q24, Q7, V6.4S
    SHA1M  Q21, S13, V29.4S
    SHA256SU1  V14.4S, V5.4S, V30.4S
    SHA1SU0  V17.4S, V21.4S, V4.4S
    SHA256H  Q25, Q8, V24.4S
    SHA1M  Q4, S10, V25.4S
    SHA1P  Q9, S4, V2.4S
    SHA256SU1  V20.4S, V14.4S, V22.4S
    SHA1SU1  V15.4S, V20.4S
    SHA256H  Q21, Q15, V10.4S
    SHA256SU0  V11.4S, V9.4S
    SHA1C  Q25, S31, V4.4S
    SHA1P  Q12, S21, V17.4S
    SHA1M  Q4, S20, V19.4S
    SHA1SU1  V14.4S, V9.4S
    SHA1M  Q9, S4, V18.4S
    SHA1M  Q29, S14, V9.4S
    SHA256H2  Q31, Q12, V17.4S
    SHA256H2  Q24, Q11, V31.4S
    SHA256SU1  V22.4S, V29.4S, V5.4S
    SHA1C  Q13, S2, V5.4S
    SHA1M  Q8, S22, V18.4S
    SHA256H  Q11, Q28, V9.4S
    SHA256SU0  V14.4S, V24.4S
    SHA1M  Q10, S8, V11.4S
    SHA256SU1  V9.4S, V14.4S, V14.4S
    SHA256SU1  V21.4S, V1.4S, V25.4S
    SHA1SU0  V19.4S, V9.4S, V20.4S
    SHA256H  Q28, Q19, V21.4S
    SHA1P  Q16, S12, V28.4S
    SHA256SU1  V24.4S, V20.4S, V13.4S
    SHA1SU0  V29.4S, V11.4S, V20.4S
    SHA1SU0  V11.4S, V24.4S, V29.4S
    SHA1SU1  V14.4S, V10.4S
    SHA1SU0  V4.4S, V11.4S, V28.4S
    SHA256SU0  V19.4S, V5.4S
    SHA256H  Q13, Q7, V4.4S
    SHA256H  Q12, Q16, V13.4S
    SHA256H  Q15, Q20, V15.4S
    SHA256H  Q16, Q14, V15.4S
    SHA256H2  Q25, Q12, V16.4S
    SHA1P  Q10, S30, V16.4S
    SHA256H2  Q30, Q0, V16.4S
    SHA256SU0  V9.4S, V5.4S
    SHA256SU0  V5.4S, V10.4S
    SHA1P  Q7, S20, V31.4S
    SHA1SU0  V1.4S, V31.4S, V21.4S
    SHA1P  Q10, S24, V13.4S
    SHA1SU1  V29.4S, V12.4S
    SHA256SU0  V28.4S, V5.4S
    SHA256SU0  V0.4S, V27.4S
    SHA1SU0  V11.4S, V29.4S, V10.4S
    SHA1C  Q20, S30, V31.4S
    SHA1C  Q24, S25, V30.4S
    SHA1M  Q29, S25, V20.4S
    SHA1C  Q16, S24, V3.4S
    SHA256SU0  V14.4S, V7.4S
    SHA1M  Q12, S0, V14.4S
    SHA1C  Q21, S29, V13.4S
    SHA1M  Q20, S1, V15.4S
    SHA1M  Q24, S11, V19.4S
    SHA1M  Q15, S24, V16.4S
    SHA1M  Q3, S28, V12.4S
    SHA256SU1  V4.4S, V9.4S, V15.4S
    SHA1M  Q15, S26, V4.4S
    SHA256H  Q11, Q27, V3.4S
    SHA256SU1  V25.4S, V20.4S, V22.4S
    SHA1M  Q7, S3, V12.4S
    SHA1SU1  V10.4S, V11.4S
    SHA1SU0  V28.4S, V7.4S, V10.4S
    SHA1SU1  V16.4S, V25.4S
    SHA1SU0  V27.4S, V25.4S, V30.4S
    SHA1M  Q10, S2, V16.4S
    SHA1P  Q21, S28, V17.4S
    SHA256H  Q18, Q10, V5.4S
    SHA256H2  Q25, Q15, V28.4S
    SHA256H  Q11, Q10, V13.4S
    SHA256SU1  V5.4S, V11.4S, V12.4S
    SHA1SU1  V7.4S, V5.4S
    SHA1SU1  V11.4S, V22.4S
    SHA1SU0  V6.4S, V21.4S, V25.4S
    SHA1C  Q13, S9, V8.4S
    SHA256SU1  V9.4S, V13.4S, V11.4S
    SHA256SU1  V16.4S, V7.4S, V16.4S
    SHA1P  Q28, S18, V27.4S
    SHA1M  Q19, S4, V28.4S
    SHA1SU1  V4.4S, V16.4S
    SHA256H  Q20, Q19, V6.4S
    SHA1M  Q6, S6, V4.4S
    SHA256H2  Q22, Q9, V10.4S
    SHA1SU0  V12.4S, V12.4S, V30.4S
    SHA1M  Q13, S22, V22.4S
    SHA256SU1  V19.4S, V6.4S, V20.4S
    SHA1SU0  V21.4S, V4.4S, V7.4S
    SHA1SU1  V16.4S, V21.4S
    SHA1P  Q20, S5, V16.4S
    SHA256H  Q17, Q16, V13.4S
    SHA1M  Q5, S20, V7.4S
    SHA256H  Q22, Q19, V14.4S
    SHA1M  Q0, S5, V22.4S
    SHA1C  Q4, S28, V2.4S
    SHA256SU1  V5.4S, V12.4S, V12.4S
    SHA1C  Q13, S13, V5.4S
    SHA1C  Q27, S11, V25.4S
    SHA256H2  Q18, Q14, V11.4S
    SHA1SU1  V8.4S, V31.4S
    SHA256SU0  V2.4S, V15.4S
    SHA1C  Q6, S0, V2.4S
    SHA1SU1  V22.4S, V6.4S
    SHA256SU1  V20.4S, V4.4S, V29.4S
    SHA1SU0  V15.4S, V20.4S, V26.4S
    SHA256H  Q25, Q23, V13.4S
    SHA1C  Q14, S15, V17.4S
    SHA1C  Q6, S18, V14.4S
    SHA1C  Q20, S22, V8.4S
    SHA1P  Q22, S25, V25.4S
    SHA1SU1  V26.4S, V6.4S
    SHA1SU0  V16.4S, V22.4S, V7.4S
    SHA1SU0  V27.4S, V13.4S, V20.4S
    SHA1P  Q25, S16, V26.4S
    SHA1M  Q22, S29, V5.4S
    SHA1C  Q26, S8, V1.4S
    SHA1SU1  V7.4S, V20.4S
    SHA256H  Q18, Q13, V4.4S
    SHA256SU1  V8.4S, V28.4S, V30.4S
    SHA1SU0  V16.4S, V2.4S, V28.4S
    SHA1C  Q29, S24, V15.4S
    SHA256H  Q23, Q2, V12.4S
    SHA256H2  Q2, Q26, V13.4S
    SHA1M  Q12, S24, V23.4S
    SHA1C  Q27, S25, V27.4S
    SHA256SU0  V23.4S, V10.4S
    SHA256H2  Q23, Q22, V8.4S
    SHA256H2  Q18, Q9, V12.4S
    SHA256H  Q9, Q7, V23.4S
    SUBS  X8, X8, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_4
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MRS  X23, FPSR
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V0.D[1]
    MOVZ  X7, #0xbdcd, LSL #0
    MOVK  X7, #0xb067, LSL #16
    MOVK  X7, #0xc60a, LSL #32
    MOVK  X7, #0x204c, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D0
    MOVZ  X7, #0x8076, LSL #0
    MOVK  X7, #0xfab6, LSL #16
    MOVK  X7, #0x20b6, LSL #32
    MOVK  X7, #0x8865, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V1.D[1]
    MOVZ  X7, #0x8e25, LSL #0
    MOVK  X7, #0xa2e4, LSL #16
    MOVK  X7, #0x2eaa, LSL #32
    MOVK  X7, #0x84dd, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D1
    MOVZ  X7, #0x19f8, LSL #0
    MOVK  X7, #0x9c1c, LSL #16
    MOVK  X7, #0xbc56, LSL #32
    MOVK  X7, #0xc704, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X7, #0x427f, LSL #0
    MOVK  X7, #0xc19f, LSL #16
    MOVK  X7, #0x5826, LSL #32
    MOVK  X7, #0xaec6, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D2
    MOVZ  X7, #0xa13f, LSL #0
    MOVK  X7, #0xa0e5, LSL #16
    MOVK  X7, #0xa624, LSL #32
    MOVK  X7, #0x549f, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X7, #0xc133, LSL #0
    MOVK  X7, #0x3e47, LSL #16
    MOVK  X7, #0x211c, LSL #32
    MOVK  X7, #0xb34d, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D3
    MOVZ  X7, #0xba3d, LSL #0
    MOVK  X7, #0xbb2c, LSL #16
    MOVK  X7, #0x9e7d, LSL #32
    MOVK  X7, #0xe47, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X7, #0xc291, LSL #0
    MOVK  X7, #0xe0cb, LSL #16
    MOVK  X7, #0x7394, LSL #32
    MOVK  X7, #0xf9a2, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D4
    MOVZ  X7, #0x838, LSL #0
    MOVK  X7, #0x1cef, LSL #16
    MOVK  X7, #0xaf21, LSL #32
    MOVK  X7, #0x26b6, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X7, #0x6165, LSL #0
    MOVK  X7, #0xe328, LSL #16
    MOVK  X7, #0x3fa0, LSL #32
    MOVK  X7, #0xa881, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D5
    MOVZ  X7, #0xf857, LSL #0
    MOVK  X7, #0xdb7f, LSL #16
    MOVK  X7, #0x4b93, LSL #32
    MOVK  X7, #0x805b, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X7, #0xe2f1, LSL #0
    MOVK  X7, #0xeb9e, LSL #16
    MOVK  X7, #0xeff4, LSL #32
    MOVK  X7, #0x65f, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D6
    MOVZ  X7, #0xc9b6, LSL #0
    MOVK  X7, #0x82c9, LSL #16
    MOVK  X7, #0x11b9, LSL #32
    MOVK  X7, #0xb7d6, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X7, #0x10b1, LSL #0
    MOVK  X7, #0xfa76, LSL #16
    MOVK  X7, #0xbff0, LSL #32
    MOVK  X7, #0xa77f, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D7
    MOVZ  X7, #0x3c1d, LSL #0
    MOVK  X7, #0x8033, LSL #16
    MOVK  X7, #0xfe7e, LSL #32
    MOVK  X7, #0x50db, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X7, #0xafef, LSL #0
    MOVK  X7, #0x8ce9, LSL #16
    MOVK  X7, #0xc228, LSL #32
    MOVK  X7, #0x7421, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D8
    MOVZ  X7, #0x1ef8, LSL #0
    MOVK  X7, #0x20c2, LSL #16
    MOVK  X7, #0x6fc5, LSL #32
    MOVK  X7, #0xc54e, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X7, #0xeff1, LSL #0
    MOVK  X7, #0x1dc8, LSL #16
    MOVK  X7, #0xaeee, LSL #32
    MOVK  X7, #0xd16c, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D9
    MOVZ  X7, #0x7047, LSL #0
    MOVK  X7, #0x3c69, LSL #16
    MOVK  X7, #0x64c9, LSL #32
    MOVK  X7, #0x2275, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X7, #0xb33c, LSL #0
    MOVK  X7, #0xbb01, LSL #16
    MOVK  X7, #0xd204, LSL #32
    MOVK  X7, #0xbadc, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D10
    MOVZ  X7, #0x7fc, LSL #0
    MOVK  X7, #0x61ad, LSL #16
    MOVK  X7, #0x11f1, LSL #32
    MOVK  X7, #0x203a, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X7, #0xb7e1, LSL #0
    MOVK  X7, #0xbe6e, LSL #16
    MOVK  X7, #0x27b9, LSL #32
    MOVK  X7, #0xf29a, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D11
    MOVZ  X7, #0x475f, LSL #0
    MOVK  X7, #0x4475, LSL #16
    MOVK  X7, #0x2b06, LSL #32
    MOVK  X7, #0xda5c, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X7, #0x831a, LSL #0
    MOVK  X7, #0xed69, LSL #16
    MOVK  X7, #0xf395, LSL #32
    MOVK  X7, #0x951b, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D12
    MOVZ  X7, #0x9327, LSL #0
    MOVK  X7, #0xa45a, LSL #16
    MOVK  X7, #0xfa95, LSL #32
    MOVK  X7, #0xbd50, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X7, #0x5ef5, LSL #0
    MOVK  X7, #0xb7e1, LSL #16
    MOVK  X7, #0x8472, LSL #32
    MOVK  X7, #0xeccd, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D13
    MOVZ  X7, #0x9805, LSL #0
    MOVK  X7, #0xc28c, LSL #16
    MOVK  X7, #0x1f8d, LSL #32
    MOVK  X7, #0xede4, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X7, #0x3ed2, LSL #0
    MOVK  X7, #0x12, LSL #16
    MOVK  X7, #0x2121, LSL #32
    MOVK  X7, #0xb0e0, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D14
    MOVZ  X7, #0xabb5, LSL #0
    MOVK  X7, #0xadb8, LSL #16
    MOVK  X7, #0xa412, LSL #32
    MOVK  X7, #0xd590, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X7, #0x3017, LSL #0
    MOVK  X7, #0x2935, LSL #16
    MOVK  X7, #0x2df, LSL #32
    MOVK  X7, #0x9bef, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D15
    MOVZ  X7, #0xaa3d, LSL #0
    MOVK  X7, #0x49b3, LSL #16
    MOVK  X7, #0x7a10, LSL #32
    MOVK  X7, #0x19d1, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X7, #0xa696, LSL #0
    MOVK  X7, #0x92d1, LSL #16
    MOVK  X7, #0xc9ab, LSL #32
    MOVK  X7, #0x8aec, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D16
    MOVZ  X7, #0xd80c, LSL #0
    MOVK  X7, #0x16b2, LSL #16
    MOVK  X7, #0x89b4, LSL #32
    MOVK  X7, #0x2486, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X7, #0xff05, LSL #0
    MOVK  X7, #0x6884, LSL #16
    MOVK  X7, #0xff07, LSL #32
    MOVK  X7, #0x127, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D17
    MOVZ  X7, #0xadaf, LSL #0
    MOVK  X7, #0xfd82, LSL #16
    MOVK  X7, #0xf1eb, LSL #32
    MOVK  X7, #0xa3b1, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X7, #0x3ea5, LSL #0
    MOVK  X7, #0x5505, LSL #16
    MOVK  X7, #0x6e66, LSL #32
    MOVK  X7, #0xbb75, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D18
    MOVZ  X7, #0xaffb, LSL #0
    MOVK  X7, #0x6137, LSL #16
    MOVK  X7, #0x892c, LSL #32
    MOVK  X7, #0x64a1, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X7, #0xe339, LSL #0
    MOVK  X7, #0xaa87, LSL #16
    MOVK  X7, #0x69fe, LSL #32
    MOVK  X7, #0xc4dd, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D19
    MOVZ  X7, #0x8cd7, LSL #0
    MOVK  X7, #0x2b97, LSL #16
    MOVK  X7, #0xaf04, LSL #32
    MOVK  X7, #0x7b83, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X7, #0x1db8, LSL #0
    MOVK  X7, #0x5c5f, LSL #16
    MOVK  X7, #0xa061, LSL #32
    MOVK  X7, #0x5d25, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D20
    MOVZ  X7, #0x959d, LSL #0
    MOVK  X7, #0x7024, LSL #16
    MOVK  X7, #0x87ee, LSL #32
    MOVK  X7, #0x12c7, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X7, #0x5906, LSL #0
    MOVK  X7, #0x5d78, LSL #16
    MOVK  X7, #0x9652, LSL #32
    MOVK  X7, #0x4c81, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D21
    MOVZ  X7, #0x49fd, LSL #0
    MOVK  X7, #0xa909, LSL #16
    MOVK  X7, #0x71d4, LSL #32
    MOVK  X7, #0xc742, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X7, #0x5223, LSL #0
    MOVK  X7, #0xe125, LSL #16
    MOVK  X7, #0x9d45, LSL #32
    MOVK  X7, #0xb5d4, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D22
    MOVZ  X7, #0xdfab, LSL #0
    MOVK  X7, #0x49ac, LSL #16
    MOVK  X7, #0x648e, LSL #32
    MOVK  X7, #0x2c73, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V23.D[1]
    MOVZ  X7, #0x4c43, LSL #0
    MOVK  X7, #0x95e4, LSL #16
    MOVK  X7, #0xe4f7, LSL #32
    MOVK  X7, #0x1247, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D23
    MOVZ  X7, #0x220a, LSL #0
    MOVK  X7, #0x1956, LSL #16
    MOVK  X7, #0x8bae, LSL #32
    MOVK  X7, #0x706e, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X7, #0x9642, LSL #0
    MOVK  X7, #0x4f37, LSL #16
    MOVK  X7, #0x6fda, LSL #32
    MOVK  X7, #0x846f, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D24
    MOVZ  X7, #0xe247, LSL #0
    MOVK  X7, #0x28e2, LSL #16
    MOVK  X7, #0x670d, LSL #32
    MOVK  X7, #0x2250, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X7, #0x52f7, LSL #0
    MOVK  X7, #0x9f6f, LSL #16
    MOVK  X7, #0x471d, LSL #32
    MOVK  X7, #0xb7dc, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D25
    MOVZ  X7, #0xc9f7, LSL #0
    MOVK  X7, #0x33b8, LSL #16
    MOVK  X7, #0xf138, LSL #32
    MOVK  X7, #0x89d8, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X7, #0xc87, LSL #0
    MOVK  X7, #0x6ab9, LSL #16
    MOVK  X7, #0x1214, LSL #32
    MOVK  X7, #0x2e37, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D26
    MOVZ  X7, #0x31cf, LSL #0
    MOVK  X7, #0x907d, LSL #16
    MOVK  X7, #0x1e8e, LSL #32
    MOVK  X7, #0x6766, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X7, #0x7cde, LSL #0
    MOVK  X7, #0x670f, LSL #16
    MOVK  X7, #0xa239, LSL #32
    MOVK  X7, #0x9bdb, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D27
    MOVZ  X7, #0x49ff, LSL #0
    MOVK  X7, #0x2928, LSL #16
    MOVK  X7, #0x966b, LSL #32
    MOVK  X7, #0x3c77, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X7, #0x1e76, LSL #0
    MOVK  X7, #0x4da3, LSL #16
    MOVK  X7, #0xedc1, LSL #32
    MOVK  X7, #0x3127, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D28
    MOVZ  X7, #0x13fa, LSL #0
    MOVK  X7, #0xa186, LSL #16
    MOVK  X7, #0x37d0, LSL #32
    MOVK  X7, #0xd150, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X7, #0x6d2a, LSL #0
    MOVK  X7, #0xf79e, LSL #16
    MOVK  X7, #0xb46e, LSL #32
    MOVK  X7, #0x85f6, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D29
    MOVZ  X7, #0xbb6d, LSL #0
    MOVK  X7, #0x92c7, LSL #16
    MOVK  X7, #0x3179, LSL #32
    MOVK  X7, #0xc426, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V30.D[1]
    MOVZ  X7, #0xf00a, LSL #0
    MOVK  X7, #0xf27d, LSL #16
    MOVK  X7, #0xa257, LSL #32
    MOVK  X7, #0x59e6, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D30
    MOVZ  X7, #0x97b1, LSL #0
    MOVK  X7, #0x2374, LSL #16
    MOVK  X7, #0x2406, LSL #32
    MOVK  X7, #0xee9e, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V31.D[1]
    MOVZ  X7, #0x87fa, LSL #0
    MOVK  X7, #0xd1c7, LSL #16
    MOVK  X7, #0x3268, LSL #32
    MOVK  X7, #0xb196, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D31
    MOVZ  X7, #0x4a19, LSL #0
    MOVK  X7, #0xb676, LSL #16
    MOVK  X7, #0x2339, LSL #32
    MOVK  X7, #0xe8dd, LSL #48
    SUB  X3, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X2, #0x7f49, LSL #0
    MOVK  X2, #0x12f8, LSL #16
    MOVK  X2, #0x2f68, LSL #32
    MOVK  X2, #0x75cb, LSL #48
    MOVZ  X3, #0xb5d6, LSL #0
    MOVK  X3, #0x6a, LSL #16
    MOVK  X3, #0xaf3b, LSL #32
    MOVK  X3, #0xabcb, LSL #48
    MOVZ  X4, #0x972c, LSL #0
    MOVK  X4, #0xcade, LSL #16
    MOVK  X4, #0xaec2, LSL #32
    MOVK  X4, #0x9916, LSL #48
    MOVZ  X5, #0xe8d9, LSL #0
    MOVK  X5, #0xefa1, LSL #16
    MOVK  X5, #0xb5ba, LSL #32
    MOVK  X5, #0xfff2, LSL #48
    MOVZ  X6, #0xb14d, LSL #0
    MOVK  X6, #0xeb03, LSL #16
    MOVK  X6, #0xc5e6, LSL #32
    MOVK  X6, #0x76f1, LSL #48
    MOVZ  X7, #0x4322, LSL #0
    MOVK  X7, #0xe4a1, LSL #16
    MOVK  X7, #0x4af9, LSL #32
    MOVK  X7, #0x63a6, LSL #48
    MOVZ  X8, #0x687e, LSL #0
    MOVK  X8, #0x3157, LSL #16
    MOVK  X8, #0x8c20, LSL #32
    MOVK  X8, #0xe098, LSL #48
    MOVZ  X9, #0x54a5, LSL #0
    MOVK  X9, #0x1b3f, LSL #16
    MOVK  X9, #0xa0e1, LSL #32
    MOVK  X9, #0x92fc, LSL #48
    MOVZ  X10, #0x17e0, LSL #0
    MOVK  X10, #0x14f, LSL #16
    MOVK  X10, #0x646f, LSL #32
    MOVK  X10, #0xa616, LSL #48
    MOVZ  X11, #0x81f6, LSL #0
    MOVK  X11, #0x6ee4, LSL #16
    MOVK  X11, #0xd467, LSL #32
    MOVK  X11, #0x5ac1, LSL #48
    MOVZ  X12, #0x6d42, LSL #0
    MOVK  X12, #0x7a98, LSL #16
    MOVK  X12, #0xa1b3, LSL #32
    MOVK  X12, #0x49a6, LSL #48
    MOVZ  X13, #0x3e4d, LSL #0
    MOVK  X13, #0x860f, LSL #16
    MOVK  X13, #0x1077, LSL #32
    MOVK  X13, #0xe70d, LSL #48
    MOVZ  X14, #0x26d5, LSL #0
    MOVK  X14, #0x45e4, LSL #16
    MOVK  X14, #0x71ac, LSL #32
    MOVK  X14, #0xb278, LSL #48
    MOVZ  X15, #0x97ad, LSL #0
    MOVK  X15, #0xd884, LSL #16
    MOVK  X15, #0xa9d6, LSL #32
    MOVK  X15, #0xe415, LSL #48
    MOVZ  X16, #0x2990, LSL #0
    MOVK  X16, #0xea26, LSL #16
    MOVK  X16, #0xc515, LSL #32
    MOVK  X16, #0x347a, LSL #48
    MOVZ  X17, #0x4618, LSL #0
    MOVK  X17, #0x5dc8, LSL #16
    MOVK  X17, #0x95f2, LSL #32
    MOVK  X17, #0xe66d, LSL #48
    MOVZ  X23, #0x942d, LSL #0
    MOVK  X23, #0x8afc, LSL #16
    MOVK  X23, #0x3d32, LSL #32
    MOVK  X23, #0x6f41, LSL #48
    MOVZ  X24, #0xba6, LSL #0
    MOVK  X24, #0xb1ae, LSL #16
    MOVK  X24, #0x16fc, LSL #32
    MOVK  X24, #0xd3fc, LSL #48
    MOVZ  X25, #0x591b, LSL #0
    MOVK  X25, #0x1455, LSL #16
    MOVK  X25, #0x2dda, LSL #32
    MOVK  X25, #0xb2fc, LSL #48
    MOVZ  X26, #0x4069, LSL #0
    MOVK  X26, #0xe0c8, LSL #16
    MOVK  X26, #0x4d12, LSL #32
    MOVK  X26, #0x5849, LSL #48
    MOVZ  X27, #0x414b, LSL #0
    MOVK  X27, #0xaf23, LSL #16
    MOVK  X27, #0xb53f, LSL #32
    MOVK  X27, #0xef9, LSL #48
    MOVZ  X28, #0xbf4b, LSL #0
    MOVK  X28, #0x56ee, LSL #16
    MOVK  X28, #0x64a5, LSL #32
    MOVK  X28, #0xa9e8, LSL #48
    MOVZ  X29, #0x7eed, LSL #0
    MOVK  X29, #0xa47f, LSL #16
    MOVK  X29, #0xd77d, LSL #32
    MOVK  X29, #0x89fd, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X25
    FMOV  D1, X9
    FMOV  V1.D[1], X6
    FMOV  D2, X27
    FMOV  V2.D[1], X28
    FMOV  D3, X28
    FMOV  V3.D[1], X24
    FMOV  D4, X26
    FMOV  V4.D[1], X26
    FMOV  D5, X7
    FMOV  V5.D[1], X24
    FMOV  D6, X26
    FMOV  V6.D[1], X7
    FMOV  D7, X16
    FMOV  V7.D[1], X12
    FMOV  D8, X14
    FMOV  V8.D[1], X25
    FMOV  D9, X2
    FMOV  V9.D[1], X5
    FMOV  D10, X28
    FMOV  V10.D[1], X12
    FMOV  D11, X2
    FMOV  V11.D[1], X2
    FMOV  D12, X14
    FMOV  V12.D[1], X29
    FMOV  D13, X15
    FMOV  V13.D[1], X24
    FMOV  D14, X14
    FMOV  V14.D[1], X3
    FMOV  D15, X24
    FMOV  V15.D[1], X15
    FMOV  D16, X16
    FMOV  V16.D[1], X29
    FMOV  D17, X11
    FMOV  V17.D[1], X2
    FMOV  D18, X17
    FMOV  V18.D[1], X28
    FMOV  D19, X28
    FMOV  V19.D[1], X14
    FMOV  D20, X14
    FMOV  V20.D[1], X12
    FMOV  D21, X25
    FMOV  V21.D[1], X24
    FMOV  D22, X17
    FMOV  V22.D[1], X29
    FMOV  D23, X11
    FMOV  V23.D[1], X17
    FMOV  D24, X14
    FMOV  V24.D[1], X25
    FMOV  D25, X14
    FMOV  V25.D[1], X8
    FMOV  D26, X24
    FMOV  V26.D[1], X8
    FMOV  D27, X24
    FMOV  V27.D[1], X10
    FMOV  D28, X29
    FMOV  V28.D[1], X4
    FMOV  D29, X12
    FMOV  V29.D[1], X6
    FMOV  D30, X6
    FMOV  V30.D[1], X14
    FMOV  D31, X6
    FMOV  V31.D[1], X14
    MOVZ  X8, #0xa, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_5:
    SHA256H  Q12, Q25, V22.4S
    SHA1SU0  V5.4S, V8.4S, V23.4S
    SHA256SU1  V15.4S, V12.4S, V12.4S
    SHA1C  Q29, S29, V15.4S
    SHA256H  Q6, Q21, V14.4S
    SHA1SU0  V23.4S, V15.4S, V29.4S
    SHA256H  Q8, Q25, V26.4S
    SHA1P  Q4, S6, V27.4S
    SHA256SU0  V30.4S, V8.4S
    SHA256SU1  V17.4S, V0.4S, V4.4S
    SHA256SU1  V4.4S, V5.4S, V2.4S
    SHA1C  Q29, S8, V24.4S
    SHA1C  Q20, S30, V23.4S
    SHA256SU1  V15.4S, V20.4S, V30.4S
    SHA256SU0  V27.4S, V4.4S
    SHA1C  Q22, S29, V15.4S
    SHA1P  Q12, S28, V27.4S
    SHA256SU0  V6.4S, V15.4S
    SHA1M  Q0, S17, V0.4S
    SHA256SU0  V31.4S, V17.4S
    SHA1SU1  V14.4S, V0.4S
    SHA1P  Q5, S14, V23.4S
    SHA256SU1  V17.4S, V28.4S, V5.4S
    SHA256H2  Q26, Q31, V31.4S
    SHA1SU0  V29.4S, V10.4S, V6.4S
    SHA1C  Q30, S17, V20.4S
    SHA256H  Q15, Q2, V30.4S
    SHA1C  Q30, S30, V12.4S
    SHA1C  Q0, S29, V0.4S
    SHA1SU1  V12.4S, V26.4S
    SHA256SU0  V29.4S, V30.4S
    SHA1P  Q6, S29, V26.4S
    SHA256H2  Q17, Q17, V6.4S
    SHA1C  Q30, S17, V22.4S
    SHA256H2  Q13, Q9, V30.4S
    SHA1P  Q24, S12, V17.4S
    SHA1M  Q7, S15, V0.4S
    SHA1P  Q22, S7, V4.4S
    SHA256H  Q31, Q13, V24.4S
    SHA256H  Q0, Q16, V2.4S
    SHA256SU0  V14.4S, V4.4S
    SHA256SU0  V9.4S, V28.4S
    SHA1SU1  V4.4S, V31.4S
    SHA256SU0  V20.4S, V4.4S
    SHA1C  Q14, S18, V15.4S
    SHA1P  Q29, S29, V29.4S
    SHA256H2  Q26, Q5, V1.4S
    SHA1C  Q1, S5, V12.4S
    SHA1C  Q12, S23, V19.4S
    SHA256H  Q10, Q3, V20.4S
    SHA1M  Q9, S26, V14.4S
    SHA1SU1  V26.4S, V12.4S
    SHA1SU0  V0.4S, V22.4S, V1.4S
    SHA1SU0  V31.4S, V29.4S, V10.4S
    SHA1M  Q12, S31, V26.4S
    SHA1SU1  V5.4S, V9.4S
    SHA256H  Q22, Q12, V0.4S
    SHA1M  Q4, S7, V2.4S
    SHA256SU0  V29.4S, V26.4S
    SHA1M  Q10, S12, V23.4S
    SHA1SU1  V20.4S, V15.4S
    SHA256H  Q0, Q15, V14.4S
    SHA1SU1  V26.4S, V9.4S
    SHA1SU0  V19.4S, V25.4S, V17.4S
    SHA256H2  Q31, Q25, V0.4S
    SHA1M  Q9, S18, V26.4S
    SHA256SU1  V16.4S, V4.4S, V29.4S
    SHA1C  Q15, S22, V20.4S
    SHA1SU0  V26.4S, V10.4S, V31.4S
    SHA1C  Q13, S19, V27.4S
    SHA256SU0  V17.4S, V25.4S
    SHA256SU1  V23.4S, V16.4S, V24.4S
    SHA256SU0  V24.4S, V23.4S
    SHA256H2  Q6, Q5, V5.4S
    SHA256SU0  V19.4S, V9.4S
    SHA1C  Q4, S7, V17.4S
    SHA256SU1  V27.4S, V19.4S, V6.4S
    SHA1P  Q2, S13, V13.4S
    SHA1P  Q16, S4, V15.4S
    SHA256H2  Q7, Q20, V27.4S
    SHA256H2  Q13, Q13, V27.4S
    SHA256SU0  V3.4S, V16.4S
    SHA256SU1  V9.4S, V24.4S, V3.4S
    SHA1SU0  V14.4S, V6.4S, V3.4S
    SHA256SU1  V0.4S, V12.4S, V14.4S
    SHA1P  Q14, S26, V2.4S
    SHA1P  Q29, S0, V28.4S
    SHA1C  Q22, S12, V29.4S
    SHA1SU0  V16.4S, V22.4S, V8.4S
    SHA256SU1  V19.4S, V4.4S, V30.4S
    SHA1P  Q5, S13, V7.4S
    SHA1SU1  V7.4S, V9.4S
    SHA256SU1  V13.4S, V7.4S, V19.4S
    SHA1M  Q15, S13, V11.4S
    SHA256H  Q22, Q15, V14.4S
    SHA1C  Q26, S16, V16.4S
    SHA1C  Q24, S18, V8.4S
    SHA1SU0  V29.4S, V14.4S, V8.4S
    SHA256SU1  V13.4S, V23.4S, V24.4S
    SHA256H2  Q19, Q26, V29.4S
    SHA256H  Q8, Q22, V22.4S
    SHA1SU0  V12.4S, V26.4S, V16.4S
    SHA1SU1  V31.4S, V19.4S
    SHA1SU1  V2.4S, V11.4S
    SHA256SU0  V26.4S, V2.4S
    SHA256H2  Q0, Q26, V13.4S
    SHA1SU0  V2.4S, V31.4S, V28.4S
    SHA1SU1  V7.4S, V5.4S
    SHA1C  Q27, S13, V25.4S
    SHA256H2  Q19, Q0, V0.4S
    SHA1SU1  V28.4S, V14.4S
    SHA256SU1  V9.4S, V8.4S, V2.4S
    SHA1M  Q19, S9, V9.4S
    SHA1SU0  V11.4S, V27.4S, V14.4S
    SHA1SU0  V0.4S, V12.4S, V28.4S
    SHA256SU0  V15.4S, V0.4S
    SHA1SU0  V8.4S, V15.4S, V11.4S
    SHA256SU1  V29.4S, V17.4S, V6.4S
    SHA256SU0  V16.4S, V7.4S
    SHA1SU0  V31.4S, V29.4S, V9.4S
    SHA256SU1  V0.4S, V19.4S, V19.4S
    SHA256SU1  V30.4S, V8.4S, V14.4S
    SHA256H2  Q30, Q31, V30.4S
    SHA256SU0  V9.4S, V27.4S
    SHA256H2  Q5, Q6, V10.4S
    SHA256H  Q15, Q0, V5.4S
    SHA1SU1  V8.4S, V17.4S
    SHA1P  Q12, S15, V29.4S
    SHA1C  Q10, S13, V30.4S
    SHA1P  Q0, S11, V11.4S
    SHA1SU1  V14.4S, V16.4S
    SHA256H  Q17, Q12, V5.4S
    SHA256SU0  V11.4S, V14.4S
    SHA256H  Q28, Q11, V21.4S
    SHA256H  Q14, Q17, V15.4S
    SHA1SU0  V7.4S, V28.4S, V9.4S
    SHA256H  Q2, Q21, V30.4S
    SHA256SU0  V9.4S, V6.4S
    SHA256H  Q31, Q0, V29.4S
    SHA1SU0  V13.4S, V9.4S, V2.4S
    SHA1C  Q5, S23, V5.4S
    SHA1SU0  V30.4S, V13.4S, V10.4S
    SHA1C  Q23, S8, V17.4S
    SHA256H2  Q3, Q7, V31.4S
    SHA256SU0  V8.4S, V30.4S
    SHA1C  Q13, S14, V16.4S
    SHA1SU1  V19.4S, V3.4S
    SHA1SU0  V12.4S, V31.4S, V29.4S
    SHA1C  Q21, S19, V13.4S
    SHA1SU0  V30.4S, V5.4S, V13.4S
    SHA1M  Q13, S4, V9.4S
    SHA256H2  Q0, Q4, V23.4S
    SHA1SU1  V16.4S, V12.4S
    SHA1C  Q21, S0, V12.4S
    SHA256SU0  V17.4S, V21.4S
    SHA1P  Q9, S16, V1.4S
    SHA256H  Q10, Q5, V17.4S
    SHA1M  Q6, S20, V13.4S
    SHA256SU0  V14.4S, V3.4S
    SHA256SU0  V21.4S, V8.4S
    SHA256SU1  V29.4S, V6.4S, V26.4S
    SHA256SU1  V28.4S, V30.4S, V29.4S
    SHA1M  Q19, S28, V12.4S
    SHA1P  Q4, S9, V21.4S
    SHA256H2  Q12, Q16, V4.4S
    SHA1P  Q4, S24, V12.4S
    SHA256SU0  V16.4S, V14.4S
    SHA1SU0  V1.4S, V10.4S, V4.4S
    SHA1SU1  V13.4S, V12.4S
    SHA1SU1  V3.4S, V7.4S
    SHA256H  Q14, Q1, V1.4S
    SHA1C  Q20, S24, V10.4S
    SHA1SU1  V7.4S, V14.4S
    SHA1M  Q24, S12, V23.4S
    SHA256H  Q30, Q25, V3.4S
    SHA256H  Q29, Q20, V19.4S
    SHA1C  Q25, S7, V24.4S
    SHA1M  Q26, S25, V6.4S
    SHA256SU0  V22.4S, V16.4S
    SHA256H2  Q3, Q11, V13.4S
    SHA1SU1  V25.4S, V30.4S
    SHA256H  Q20, Q15, V27.4S
    SHA1M  Q13, S25, V20.4S
    SHA1P  Q23, S5, V26.4S
    SHA256H  Q14, Q29, V22.4S
    SHA1M  Q6, S14, V22.4S
    SHA256H  Q1, Q28, V13.4S
    SHA256SU0  V4.4S, V3.4S
    SHA256SU0  V13.4S, V12.4S
    SHA256H2  Q30, Q14, V4.4S
    SHA256H2  Q22, Q30, V21.4S
    SHA1P  Q4, S0, V8.4S
    SHA256H2  Q11, Q4, V13.4S
    SHA256H2  Q7, Q6, V4.4S
    SHA1SU0  V9.4S, V20.4S, V17.4S
    SHA256SU0  V21.4S, V28.4S
    SHA1M  Q3, S1, V22.4S
    SHA1M  Q6, S21, V11.4S
    SHA1SU1  V19.4S, V3.4S
    SHA1SU0  V30.4S, V28.4S, V19.4S
    SUBS  X8, X8, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_5
    MOVZ  X7, #0x7f49, LSL #0
    MOVK  X7, #0x12f8, LSL #16
    MOVK  X7, #0x2f68, LSL #32
    MOVK  X7, #0x75cb, LSL #48
    SUB  X27, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0xb5d6, LSL #0
    MOVK  X7, #0x6a, LSL #16
    MOVK  X7, #0xaf3b, LSL #32
    MOVK  X7, #0xabcb, LSL #48
    SUB  X27, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x972c, LSL #0
    MOVK  X7, #0xcade, LSL #16
    MOVK  X7, #0xaec2, LSL #32
    MOVK  X7, #0x9916, LSL #48
    SUB  X27, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0xe8d9, LSL #0
    MOVK  X7, #0xefa1, LSL #16
    MOVK  X7, #0xb5ba, LSL #32
    MOVK  X7, #0xfff2, LSL #48
    SUB  X27, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0xb14d, LSL #0
    MOVK  X7, #0xeb03, LSL #16
    MOVK  X7, #0xc5e6, LSL #32
    MOVK  X7, #0x76f1, LSL #48
    SUB  X27, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x54a5, LSL #0
    MOVK  X7, #0x1b3f, LSL #16
    MOVK  X7, #0xa0e1, LSL #32
    MOVK  X7, #0x92fc, LSL #48
    SUB  X27, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x17e0, LSL #0
    MOVK  X7, #0x14f, LSL #16
    MOVK  X7, #0x646f, LSL #32
    MOVK  X7, #0xa616, LSL #48
    SUB  X27, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x6d42, LSL #0
    MOVK  X7, #0x7a98, LSL #16
    MOVK  X7, #0xa1b3, LSL #32
    MOVK  X7, #0x49a6, LSL #48
    SUB  X27, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x3e4d, LSL #0
    MOVK  X7, #0x860f, LSL #16
    MOVK  X7, #0x1077, LSL #32
    MOVK  X7, #0xe70d, LSL #48
    SUB  X27, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x26d5, LSL #0
    MOVK  X7, #0x45e4, LSL #16
    MOVK  X7, #0x71ac, LSL #32
    MOVK  X7, #0xb278, LSL #48
    SUB  X27, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x97ad, LSL #0
    MOVK  X7, #0xd884, LSL #16
    MOVK  X7, #0xa9d6, LSL #32
    MOVK  X7, #0xe415, LSL #48
    SUB  X27, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x2990, LSL #0
    MOVK  X7, #0xea26, LSL #16
    MOVK  X7, #0xc515, LSL #32
    MOVK  X7, #0x347a, LSL #48
    SUB  X27, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x4618, LSL #0
    MOVK  X7, #0x5dc8, LSL #16
    MOVK  X7, #0x95f2, LSL #32
    MOVK  X7, #0xe66d, LSL #48
    SUB  X27, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x942d, LSL #0
    MOVK  X7, #0x8afc, LSL #16
    MOVK  X7, #0x3d32, LSL #32
    MOVK  X7, #0x6f41, LSL #48
    SUB  X27, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0xba6, LSL #0
    MOVK  X7, #0xb1ae, LSL #16
    MOVK  X7, #0x16fc, LSL #32
    MOVK  X7, #0xd3fc, LSL #48
    SUB  X27, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x591b, LSL #0
    MOVK  X7, #0x1455, LSL #16
    MOVK  X7, #0x2dda, LSL #32
    MOVK  X7, #0xb2fc, LSL #48
    SUB  X27, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x4069, LSL #0
    MOVK  X7, #0xe0c8, LSL #16
    MOVK  X7, #0x4d12, LSL #32
    MOVK  X7, #0x5849, LSL #48
    SUB  X27, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0xbf4b, LSL #0
    MOVK  X7, #0x56ee, LSL #16
    MOVK  X7, #0x64a5, LSL #32
    MOVK  X7, #0xa9e8, LSL #48
    SUB  X27, X7, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x7eed, LSL #0
    MOVK  X7, #0xa47f, LSL #16
    MOVK  X7, #0xd77d, LSL #32
    MOVK  X7, #0x89fd, LSL #48
    SUB  X27, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MRS  X7, FPSR
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V0.D[1]
    MOVZ  X27, #0x5b50, LSL #0
    MOVK  X27, #0x743f, LSL #16
    MOVK  X27, #0x1297, LSL #32
    MOVK  X27, #0xb66a, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D0
    MOVZ  X27, #0x1d64, LSL #0
    MOVK  X27, #0xd2e2, LSL #16
    MOVK  X27, #0x578e, LSL #32
    MOVK  X27, #0x1028, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V1.D[1]
    MOVZ  X27, #0x3b48, LSL #0
    MOVK  X27, #0x2117, LSL #16
    MOVK  X27, #0xebc7, LSL #32
    MOVK  X27, #0xaf9f, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D1
    MOVZ  X27, #0x9c3f, LSL #0
    MOVK  X27, #0xd180, LSL #16
    MOVK  X27, #0x1cc0, LSL #32
    MOVK  X27, #0x1fc7, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V2.D[1]
    MOVZ  X27, #0xf115, LSL #0
    MOVK  X27, #0xcf98, LSL #16
    MOVK  X27, #0x847c, LSL #32
    MOVK  X27, #0x98ce, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D2
    MOVZ  X27, #0xc01a, LSL #0
    MOVK  X27, #0x209e, LSL #16
    MOVK  X27, #0x307, LSL #32
    MOVK  X27, #0x2f3f, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X27, #0xbc77, LSL #0
    MOVK  X27, #0x718c, LSL #16
    MOVK  X27, #0x1292, LSL #32
    MOVK  X27, #0x23c9, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D3
    MOVZ  X27, #0x27fb, LSL #0
    MOVK  X27, #0x5df7, LSL #16
    MOVK  X27, #0x187d, LSL #32
    MOVK  X27, #0x2374, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X27, #0x6655, LSL #0
    MOVK  X27, #0x5f5b, LSL #16
    MOVK  X27, #0x1fb, LSL #32
    MOVK  X27, #0x6fb9, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D4
    MOVZ  X27, #0xb41b, LSL #0
    MOVK  X27, #0xc0c9, LSL #16
    MOVK  X27, #0xc131, LSL #32
    MOVK  X27, #0x7356, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X27, #0x3a82, LSL #0
    MOVK  X27, #0x3600, LSL #16
    MOVK  X27, #0x5952, LSL #32
    MOVK  X27, #0x2cf0, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D5
    MOVZ  X27, #0xa0af, LSL #0
    MOVK  X27, #0x6e24, LSL #16
    MOVK  X27, #0xd4bd, LSL #32
    MOVK  X27, #0x8cec, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X27, #0x72ba, LSL #0
    MOVK  X27, #0x713b, LSL #16
    MOVK  X27, #0xd7a1, LSL #32
    MOVK  X27, #0x395e, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D6
    MOVZ  X27, #0x8f52, LSL #0
    MOVK  X27, #0xd3ee, LSL #16
    MOVK  X27, #0xbeb, LSL #32
    MOVK  X27, #0x5f01, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V7.D[1]
    MOVZ  X27, #0x6f70, LSL #0
    MOVK  X27, #0x53eb, LSL #16
    MOVK  X27, #0xed5b, LSL #32
    MOVK  X27, #0xd228, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D7
    MOVZ  X27, #0x1fc2, LSL #0
    MOVK  X27, #0x7b54, LSL #16
    MOVK  X27, #0xdc1c, LSL #32
    MOVK  X27, #0x1d2f, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X27, #0x5f0a, LSL #0
    MOVK  X27, #0x7591, LSL #16
    MOVK  X27, #0x1ff2, LSL #32
    MOVK  X27, #0xd139, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D8
    MOVZ  X27, #0x34e4, LSL #0
    MOVK  X27, #0x828c, LSL #16
    MOVK  X27, #0xe802, LSL #32
    MOVK  X27, #0x1cc3, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V9.D[1]
    MOVZ  X27, #0xf681, LSL #0
    MOVK  X27, #0x8af7, LSL #16
    MOVK  X27, #0xe621, LSL #32
    MOVK  X27, #0xd50f, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D9
    MOVZ  X27, #0xbe1f, LSL #0
    MOVK  X27, #0xb82f, LSL #16
    MOVK  X27, #0xeeb7, LSL #32
    MOVK  X27, #0x434e, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X27, #0x8c61, LSL #0
    MOVK  X27, #0xd429, LSL #16
    MOVK  X27, #0x2643, LSL #32
    MOVK  X27, #0xa45c, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D10
    MOVZ  X27, #0xf35d, LSL #0
    MOVK  X27, #0xdae, LSL #16
    MOVK  X27, #0xfa0d, LSL #32
    MOVK  X27, #0xafe9, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X27, #0x84fc, LSL #0
    MOVK  X27, #0x1e01, LSL #16
    MOVK  X27, #0x483c, LSL #32
    MOVK  X27, #0x26d7, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D11
    MOVZ  X27, #0x62d6, LSL #0
    MOVK  X27, #0x98c5, LSL #16
    MOVK  X27, #0x9d52, LSL #32
    MOVK  X27, #0xd724, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X27, #0xd22a, LSL #0
    MOVK  X27, #0xcbd4, LSL #16
    MOVK  X27, #0x7ae2, LSL #32
    MOVK  X27, #0xd642, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D12
    MOVZ  X27, #0x50f8, LSL #0
    MOVK  X27, #0x76c5, LSL #16
    MOVK  X27, #0xad63, LSL #32
    MOVK  X27, #0xb538, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X27, #0x4b4c, LSL #0
    MOVK  X27, #0x3984, LSL #16
    MOVK  X27, #0xcff8, LSL #32
    MOVK  X27, #0x805b, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D13
    MOVZ  X27, #0xc17d, LSL #0
    MOVK  X27, #0x2453, LSL #16
    MOVK  X27, #0xb532, LSL #32
    MOVK  X27, #0x5e3a, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X27, #0xb57a, LSL #0
    MOVK  X27, #0x4c2d, LSL #16
    MOVK  X27, #0xdb23, LSL #32
    MOVK  X27, #0x1ed8, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D14
    MOVZ  X27, #0xc4c8, LSL #0
    MOVK  X27, #0x6e78, LSL #16
    MOVK  X27, #0x3696, LSL #32
    MOVK  X27, #0x4d7a, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X27, #0xe64a, LSL #0
    MOVK  X27, #0xead, LSL #16
    MOVK  X27, #0x70d5, LSL #32
    MOVK  X27, #0xbfd1, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D15
    MOVZ  X27, #0x5278, LSL #0
    MOVK  X27, #0x5b5, LSL #16
    MOVK  X27, #0xc0ea, LSL #32
    MOVK  X27, #0x3466, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V16.D[1]
    MOVZ  X27, #0xfe77, LSL #0
    MOVK  X27, #0x2431, LSL #16
    MOVK  X27, #0x4b2d, LSL #32
    MOVK  X27, #0x8bf8, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D16
    MOVZ  X27, #0x7841, LSL #0
    MOVK  X27, #0x6013, LSL #16
    MOVK  X27, #0xe843, LSL #32
    MOVK  X27, #0x1c1, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V17.D[1]
    MOVZ  X27, #0xd409, LSL #0
    MOVK  X27, #0xcaf8, LSL #16
    MOVK  X27, #0xa5c6, LSL #32
    MOVK  X27, #0x57cc, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D17
    MOVZ  X27, #0x8255, LSL #0
    MOVK  X27, #0xbafc, LSL #16
    MOVK  X27, #0xd831, LSL #32
    MOVK  X27, #0x4ca1, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V18.D[1]
    MOVZ  X27, #0xbf4b, LSL #0
    MOVK  X27, #0x56ee, LSL #16
    MOVK  X27, #0x64a5, LSL #32
    MOVK  X27, #0xa9e8, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D18
    MOVZ  X27, #0x4618, LSL #0
    MOVK  X27, #0x5dc8, LSL #16
    MOVK  X27, #0x95f2, LSL #32
    MOVK  X27, #0xe66d, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X27, #0x7008, LSL #0
    MOVK  X27, #0xe5fa, LSL #16
    MOVK  X27, #0x3f7e, LSL #32
    MOVK  X27, #0x7944, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D19
    MOVZ  X27, #0xd75, LSL #0
    MOVK  X27, #0xd737, LSL #16
    MOVK  X27, #0xa590, LSL #32
    MOVK  X27, #0xc05c, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X27, #0x636d, LSL #0
    MOVK  X27, #0x8ae9, LSL #16
    MOVK  X27, #0x794c, LSL #32
    MOVK  X27, #0x94c8, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D20
    MOVZ  X27, #0xe63d, LSL #0
    MOVK  X27, #0x37ec, LSL #16
    MOVK  X27, #0x8467, LSL #32
    MOVK  X27, #0xa2ca, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X27, #0x5c41, LSL #0
    MOVK  X27, #0xa956, LSL #16
    MOVK  X27, #0xb8d4, LSL #32
    MOVK  X27, #0xb43, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D21
    MOVZ  X27, #0x295e, LSL #0
    MOVK  X27, #0x719, LSL #16
    MOVK  X27, #0xfd64, LSL #32
    MOVK  X27, #0x5c8a, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V22.D[1]
    MOVZ  X27, #0xb2f2, LSL #0
    MOVK  X27, #0x47dc, LSL #16
    MOVK  X27, #0x273, LSL #32
    MOVK  X27, #0x17a1, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D22
    MOVZ  X27, #0x30f5, LSL #0
    MOVK  X27, #0xb49, LSL #16
    MOVK  X27, #0x5a82, LSL #32
    MOVK  X27, #0x83a9, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V23.D[1]
    MOVZ  X27, #0xb096, LSL #0
    MOVK  X27, #0xb2f2, LSL #16
    MOVK  X27, #0x1b05, LSL #32
    MOVK  X27, #0xc79a, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D23
    MOVZ  X27, #0x1577, LSL #0
    MOVK  X27, #0x8ea6, LSL #16
    MOVK  X27, #0xa5c, LSL #32
    MOVK  X27, #0xfc11, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V24.D[1]
    MOVZ  X27, #0xd42a, LSL #0
    MOVK  X27, #0xc7ff, LSL #16
    MOVK  X27, #0xe3a0, LSL #32
    MOVK  X27, #0x732a, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D24
    MOVZ  X27, #0xa953, LSL #0
    MOVK  X27, #0x3869, LSL #16
    MOVK  X27, #0xb314, LSL #32
    MOVK  X27, #0xf397, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X27, #0x9140, LSL #0
    MOVK  X27, #0x5054, LSL #16
    MOVK  X27, #0xd2bf, LSL #32
    MOVK  X27, #0xd74, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D25
    MOVZ  X27, #0x96b3, LSL #0
    MOVK  X27, #0x51ab, LSL #16
    MOVK  X27, #0xaffb, LSL #32
    MOVK  X27, #0x4cc7, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V26.D[1]
    MOVZ  X27, #0x5045, LSL #0
    MOVK  X27, #0x5ea2, LSL #16
    MOVK  X27, #0x9d77, LSL #32
    MOVK  X27, #0xcbd6, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D26
    MOVZ  X27, #0x8e42, LSL #0
    MOVK  X27, #0xb794, LSL #16
    MOVK  X27, #0x87c1, LSL #32
    MOVK  X27, #0x23f1, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X27, #0x1c03, LSL #0
    MOVK  X27, #0xbaec, LSL #16
    MOVK  X27, #0x6330, LSL #32
    MOVK  X27, #0x71d7, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D27
    MOVZ  X27, #0xbbef, LSL #0
    MOVK  X27, #0x211a, LSL #16
    MOVK  X27, #0xa0be, LSL #32
    MOVK  X27, #0x1cb7, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X27, #0x56c1, LSL #0
    MOVK  X27, #0x155e, LSL #16
    MOVK  X27, #0x2e29, LSL #32
    MOVK  X27, #0x74c7, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D28
    MOVZ  X27, #0x1cf3, LSL #0
    MOVK  X27, #0x378d, LSL #16
    MOVK  X27, #0xf679, LSL #32
    MOVK  X27, #0x7858, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X27, #0x8e6f, LSL #0
    MOVK  X27, #0xc767, LSL #16
    MOVK  X27, #0xbbcf, LSL #32
    MOVK  X27, #0x5a67, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D29
    MOVZ  X27, #0xff8e, LSL #0
    MOVK  X27, #0xc659, LSL #16
    MOVK  X27, #0x5b50, LSL #32
    MOVK  X27, #0xb13b, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V30.D[1]
    MOVZ  X27, #0x47e0, LSL #0
    MOVK  X27, #0x6367, LSL #16
    MOVK  X27, #0x9293, LSL #32
    MOVK  X27, #0x9764, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D30
    MOVZ  X27, #0xdc28, LSL #0
    MOVK  X27, #0x3242, LSL #16
    MOVK  X27, #0x207, LSL #32
    MOVK  X27, #0x38b8, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V31.D[1]
    MOVZ  X27, #0x5e33, LSL #0
    MOVK  X27, #0xdd8d, LSL #16
    MOVK  X27, #0xdfa, LSL #32
    MOVK  X27, #0xa887, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D31
    MOVZ  X27, #0xa87f, LSL #0
    MOVK  X27, #0xe0c3, LSL #16
    MOVK  X27, #0xa4ca, LSL #32
    MOVK  X27, #0xb7da, LSL #48
    SUB  X11, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
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
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X8
    FMOV  V0.D[1], X27
    FMOV  D1, X12
    FMOV  V1.D[1], X13
    FMOV  D2, X25
    FMOV  V2.D[1], X17
    FMOV  D3, X10
    FMOV  V3.D[1], X28
    FMOV  D4, X29
    FMOV  V4.D[1], X26
    FMOV  D5, X23
    FMOV  V5.D[1], X26
    FMOV  D6, X24
    FMOV  V6.D[1], X7
    FMOV  D7, X29
    FMOV  V7.D[1], X26
    FMOV  D8, X26
    FMOV  V8.D[1], X9
    FMOV  D9, X15
    FMOV  V9.D[1], X4
    FMOV  D10, X17
    FMOV  V10.D[1], X15
    FMOV  D11, X12
    FMOV  V11.D[1], X23
    FMOV  D12, X10
    FMOV  V12.D[1], X6
    FMOV  D13, X16
    FMOV  V13.D[1], X8
    FMOV  D14, X25
    FMOV  V14.D[1], X25
    FMOV  D15, X16
    FMOV  V15.D[1], X4
    FMOV  D16, X12
    FMOV  V16.D[1], X2
    FMOV  D17, X15
    FMOV  V17.D[1], X16
    FMOV  D18, X29
    FMOV  V18.D[1], X11
    FMOV  D19, X16
    FMOV  V19.D[1], X29
    FMOV  D20, X17
    FMOV  V20.D[1], X29
    FMOV  D21, X17
    FMOV  V21.D[1], X5
    FMOV  D22, X5
    FMOV  V22.D[1], X7
    FMOV  D23, X11
    FMOV  V23.D[1], X4
    FMOV  D24, X29
    FMOV  V24.D[1], X16
    FMOV  D25, X7
    FMOV  V25.D[1], X8
    FMOV  D26, X5
    FMOV  V26.D[1], X24
    FMOV  D27, X10
    FMOV  V27.D[1], X10
    FMOV  D28, X28
    FMOV  V28.D[1], X29
    FMOV  D29, X3
    FMOV  V29.D[1], X25
    FMOV  D30, X16
    FMOV  V30.D[1], X4
    FMOV  D31, X13
    FMOV  V31.D[1], X8
    MOVZ  X27, #0xa, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_6:
    SHA1SU0  V6.4S, V6.4S, V19.4S
    SHA256SU1  V14.4S, V23.4S, V10.4S
    SHA256H  Q28, Q3, V30.4S
    SHA1SU0  V17.4S, V28.4S, V29.4S
    SHA1M  Q23, S31, V21.4S
    SHA1SU1  V19.4S, V26.4S
    SHA1M  Q26, S19, V27.4S
    SHA256H  Q28, Q3, V23.4S
    SHA1C  Q11, S18, V25.4S
    SHA1C  Q14, S3, V26.4S
    SHA1P  Q13, S6, V11.4S
    SHA1SU0  V18.4S, V17.4S, V17.4S
    SHA1SU1  V27.4S, V24.4S
    SHA1P  Q30, S27, V18.4S
    SHA1M  Q11, S30, V4.4S
    SHA1P  Q25, S28, V13.4S
    SHA1C  Q13, S25, V18.4S
    SHA256H2  Q8, Q17, V11.4S
    SHA1C  Q8, S8, V14.4S
    SHA1P  Q19, S20, V17.4S
    SHA1C  Q20, S31, V27.4S
    SHA256SU1  V24.4S, V7.4S, V29.4S
    SHA1SU1  V30.4S, V20.4S
    SHA1C  Q6, S5, V7.4S
    SHA256H2  Q1, Q8, V8.4S
    SHA1SU1  V3.4S, V19.4S
    SHA1SU1  V24.4S, V13.4S
    SHA1P  Q29, S31, V12.4S
    SHA1C  Q5, S23, V9.4S
    SHA1P  Q28, S18, V6.4S
    SHA1SU1  V8.4S, V5.4S
    SHA1C  Q4, S2, V28.4S
    SHA256SU0  V25.4S, V13.4S
    SHA256SU0  V7.4S, V19.4S
    SHA256SU1  V14.4S, V27.4S, V3.4S
    SHA256SU1  V27.4S, V29.4S, V4.4S
    SHA256SU1  V2.4S, V27.4S, V29.4S
    SHA1SU0  V5.4S, V19.4S, V24.4S
    SHA1P  Q3, S7, V8.4S
    SHA256SU1  V28.4S, V3.4S, V21.4S
    SHA1P  Q9, S7, V28.4S
    SHA256SU0  V4.4S, V1.4S
    SHA1P  Q23, S9, V22.4S
    SHA1SU0  V4.4S, V4.4S, V14.4S
    SHA1C  Q3, S29, V25.4S
    SHA1M  Q28, S8, V12.4S
    SHA256SU1  V21.4S, V9.4S, V30.4S
    SHA1C  Q15, S28, V4.4S
    SHA256SU1  V17.4S, V21.4S, V23.4S
    SHA256H2  Q27, Q17, V22.4S
    SHA1SU1  V9.4S, V3.4S
    SHA256SU0  V22.4S, V30.4S
    SHA1C  Q6, S14, V15.4S
    SHA1C  Q15, S27, V27.4S
    SHA256SU1  V30.4S, V5.4S, V2.4S
    SHA256H2  Q31, Q6, V15.4S
    SHA256H  Q23, Q31, V11.4S
    SHA256SU1  V14.4S, V9.4S, V23.4S
    SHA1P  Q11, S19, V22.4S
    SHA1SU1  V27.4S, V11.4S
    SHA256SU0  V3.4S, V0.4S
    SHA256H  Q11, Q30, V27.4S
    SHA256SU0  V22.4S, V20.4S
    SHA1SU0  V21.4S, V22.4S, V3.4S
    SHA256SU1  V25.4S, V21.4S, V21.4S
    SHA1SU0  V4.4S, V14.4S, V22.4S
    SHA1C  Q15, S17, V23.4S
    SHA1P  Q30, S29, V3.4S
    SHA1SU0  V6.4S, V2.4S, V30.4S
    SHA256SU1  V27.4S, V12.4S, V25.4S
    SHA1SU1  V31.4S, V15.4S
    SHA256H2  Q25, Q5, V10.4S
    SHA256SU1  V23.4S, V4.4S, V21.4S
    SHA1SU0  V17.4S, V25.4S, V15.4S
    SHA256SU1  V12.4S, V11.4S, V17.4S
    SHA256H  Q12, Q21, V9.4S
    SHA1C  Q9, S23, V27.4S
    SHA256SU1  V10.4S, V13.4S, V31.4S
    SHA1P  Q10, S6, V12.4S
    SHA1SU1  V22.4S, V16.4S
    SHA1C  Q27, S0, V2.4S
    SHA1C  Q17, S14, V26.4S
    SHA1SU0  V11.4S, V4.4S, V13.4S
    SHA1SU1  V3.4S, V5.4S
    SHA256SU0  V17.4S, V30.4S
    SHA256H2  Q30, Q21, V1.4S
    SHA256H  Q12, Q9, V28.4S
    SHA1C  Q30, S17, V19.4S
    SHA256SU0  V25.4S, V3.4S
    SHA1M  Q13, S1, V23.4S
    SHA256H  Q16, Q3, V2.4S
    SHA256SU1  V12.4S, V30.4S, V1.4S
    SHA1M  Q14, S7, V18.4S
    SHA1P  Q0, S11, V13.4S
    SHA256SU0  V15.4S, V10.4S
    SHA256H2  Q26, Q25, V16.4S
    SHA256H2  Q21, Q15, V27.4S
    SHA256SU1  V19.4S, V0.4S, V27.4S
    SHA256SU1  V22.4S, V26.4S, V3.4S
    SHA256SU0  V15.4S, V8.4S
    SHA1SU1  V26.4S, V21.4S
    SHA1C  Q16, S22, V22.4S
    SHA1C  Q4, S14, V26.4S
    SHA1C  Q23, S5, V1.4S
    SHA1C  Q27, S4, V4.4S
    SHA1P  Q0, S23, V30.4S
    SHA1P  Q8, S27, V27.4S
    SHA256SU0  V25.4S, V15.4S
    SHA1SU0  V11.4S, V17.4S, V5.4S
    SHA1P  Q4, S11, V25.4S
    SHA1C  Q14, S15, V21.4S
    SHA1SU0  V1.4S, V19.4S, V4.4S
    SHA256SU1  V18.4S, V15.4S, V1.4S
    SHA256H2  Q23, Q0, V31.4S
    SHA1SU1  V30.4S, V23.4S
    SHA1P  Q0, S12, V12.4S
    SHA256SU1  V11.4S, V14.4S, V11.4S
    SHA256SU1  V2.4S, V11.4S, V16.4S
    SHA256SU0  V14.4S, V8.4S
    SHA1C  Q25, S4, V14.4S
    SHA256H  Q8, Q28, V24.4S
    SHA1C  Q17, S16, V30.4S
    SHA1P  Q16, S1, V18.4S
    SHA1C  Q10, S25, V8.4S
    SHA256SU0  V6.4S, V17.4S
    SHA1P  Q31, S2, V26.4S
    SHA1M  Q3, S1, V30.4S
    SHA256SU0  V23.4S, V3.4S
    SHA1SU0  V22.4S, V10.4S, V25.4S
    SHA256SU0  V26.4S, V6.4S
    SHA1SU0  V14.4S, V16.4S, V23.4S
    SHA256SU1  V21.4S, V22.4S, V0.4S
    SHA256H  Q8, Q31, V14.4S
    SHA256H  Q4, Q26, V8.4S
    SHA256H2  Q30, Q16, V26.4S
    SHA1M  Q6, S2, V6.4S
    SHA1C  Q22, S28, V14.4S
    SHA256H  Q17, Q30, V3.4S
    SHA1SU1  V2.4S, V7.4S
    SHA1P  Q30, S30, V24.4S
    SHA1C  Q8, S15, V6.4S
    SHA256SU0  V6.4S, V12.4S
    SHA1SU0  V11.4S, V17.4S, V26.4S
    SHA1SU0  V3.4S, V13.4S, V24.4S
    SHA256H  Q24, Q9, V17.4S
    SHA1SU0  V17.4S, V11.4S, V6.4S
    SHA1SU0  V7.4S, V2.4S, V24.4S
    SHA256SU1  V2.4S, V17.4S, V22.4S
    SHA256H2  Q14, Q4, V16.4S
    SHA1C  Q31, S2, V9.4S
    SHA256SU0  V11.4S, V3.4S
    SHA1M  Q23, S19, V23.4S
    SHA256SU1  V12.4S, V23.4S, V23.4S
    SHA256SU0  V4.4S, V30.4S
    SHA256H  Q23, Q15, V7.4S
    SHA1C  Q5, S1, V31.4S
    SHA256SU1  V3.4S, V29.4S, V31.4S
    SHA1SU1  V10.4S, V4.4S
    SHA1C  Q19, S29, V3.4S
    SHA1SU0  V17.4S, V5.4S, V12.4S
    SHA256SU1  V14.4S, V11.4S, V10.4S
    SHA256H  Q6, Q0, V19.4S
    SHA1M  Q28, S17, V14.4S
    SHA256H  Q11, Q28, V1.4S
    SHA1M  Q5, S23, V21.4S
    SHA256H2  Q8, Q14, V5.4S
    SHA1SU1  V2.4S, V25.4S
    SHA1C  Q12, S6, V14.4S
    SHA256H2  Q24, Q11, V7.4S
    SHA256SU1  V19.4S, V12.4S, V4.4S
    SHA1SU0  V3.4S, V19.4S, V19.4S
    SHA1M  Q12, S15, V27.4S
    SHA1SU1  V10.4S, V3.4S
    SHA1M  Q22, S12, V24.4S
    SHA1P  Q15, S17, V4.4S
    SHA256SU0  V6.4S, V22.4S
    SHA1C  Q11, S8, V15.4S
    SHA1SU0  V13.4S, V18.4S, V11.4S
    SHA256SU1  V4.4S, V6.4S, V6.4S
    SHA1SU1  V18.4S, V13.4S
    SHA1M  Q6, S2, V18.4S
    SHA256SU0  V31.4S, V10.4S
    SHA256SU0  V25.4S, V2.4S
    SHA1M  Q21, S0, V25.4S
    SHA256H2  Q19, Q31, V6.4S
    SHA1SU1  V2.4S, V17.4S
    SHA1P  Q14, S21, V3.4S
    SHA1P  Q22, S16, V24.4S
    SHA256H2  Q0, Q24, V4.4S
    SHA256H  Q22, Q0, V3.4S
    SHA1P  Q3, S14, V2.4S
    SHA1P  Q27, S3, V3.4S
    SHA1P  Q24, S14, V30.4S
    SHA1SU0  V8.4S, V22.4S, V26.4S
    SHA1SU1  V17.4S, V1.4S
    SHA1M  Q3, S8, V8.4S
    SHA1P  Q16, S3, V5.4S
    SHA1P  Q8, S24, V17.4S
    SHA1M  Q1, S5, V19.4S
    SHA1SU1  V17.4S, V26.4S
    SUBS  X27, X27, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_6
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MRS  X12, FPSR
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V0.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D0
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V1.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D1
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D2
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D3
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D4
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D5
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D6
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D7
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D8
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D9
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D10
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D11
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V12.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D12
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D13
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D14
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D15
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D16
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D17
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D18
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D19
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D20
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D21
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D22
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D23
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D24
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D25
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D26
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D27
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D28
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D29
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V30.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D30
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, V31.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X12, D31
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
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
    FMOV  V0.D[1], X23
    FMOV  D1, X28
    FMOV  V1.D[1], X6
    FMOV  D2, X27
    FMOV  V2.D[1], X24
    FMOV  D3, X7
    FMOV  V3.D[1], X26
    FMOV  D4, X10
    FMOV  V4.D[1], X10
    FMOV  D5, X27
    FMOV  V5.D[1], X28
    FMOV  D6, X2
    FMOV  V6.D[1], X28
    FMOV  D7, X28
    FMOV  V7.D[1], X28
    FMOV  D8, X10
    FMOV  V8.D[1], X25
    FMOV  D9, X16
    FMOV  V9.D[1], X14
    FMOV  D10, X17
    FMOV  V10.D[1], X14
    FMOV  D11, X24
    FMOV  V11.D[1], X28
    FMOV  D12, X24
    FMOV  V12.D[1], X26
    FMOV  D13, X15
    FMOV  V13.D[1], X13
    FMOV  D14, X16
    FMOV  V14.D[1], X6
    FMOV  D15, X24
    FMOV  V15.D[1], X23
    FMOV  D16, X4
    FMOV  V16.D[1], X5
    FMOV  D17, X11
    FMOV  V17.D[1], X6
    FMOV  D18, X6
    FMOV  V18.D[1], X29
    FMOV  D19, X13
    FMOV  V19.D[1], X27
    FMOV  D20, X3
    FMOV  V20.D[1], X23
    FMOV  D21, X27
    FMOV  V21.D[1], X15
    FMOV  D22, X25
    FMOV  V22.D[1], X7
    FMOV  D23, X27
    FMOV  V23.D[1], X15
    FMOV  D24, X16
    FMOV  V24.D[1], X8
    FMOV  D25, X10
    FMOV  V25.D[1], X12
    FMOV  D26, X10
    FMOV  V26.D[1], X15
    FMOV  D27, X3
    FMOV  V27.D[1], X26
    FMOV  D28, X12
    FMOV  V28.D[1], X2
    FMOV  D29, X10
    FMOV  V29.D[1], X2
    FMOV  D30, X7
    FMOV  V30.D[1], X10
    FMOV  D31, X10
    FMOV  V31.D[1], X5
    MOVZ  X2, #0xa, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_7:
    SHA256H  Q10, Q25, V14.4S
    SHA256SU0  V29.4S, V26.4S
    SHA1P  Q20, S18, V31.4S
    SHA1SU1  V31.4S, V15.4S
    SHA256H  Q1, Q28, V24.4S
    SHA256SU1  V0.4S, V1.4S, V31.4S
    SHA1C  Q6, S10, V30.4S
    SHA256H  Q14, Q0, V6.4S
    SHA256H2  Q16, Q20, V30.4S
    SHA1C  Q10, S14, V14.4S
    SHA1P  Q25, S27, V29.4S
    SHA256H2  Q1, Q14, V25.4S
    SHA256H2  Q28, Q9, V16.4S
    SHA1M  Q30, S28, V19.4S
    SHA1C  Q7, S19, V26.4S
    SHA1SU1  V25.4S, V20.4S
    SHA1SU1  V24.4S, V12.4S
    SHA1SU1  V14.4S, V10.4S
    SHA1P  Q20, S24, V25.4S
    SHA256SU1  V24.4S, V0.4S, V0.4S
    SHA256H2  Q10, Q14, V22.4S
    SHA1SU1  V25.4S, V1.4S
    SHA1C  Q12, S25, V20.4S
    SHA256H  Q22, Q7, V30.4S
    SHA256SU1  V30.4S, V25.4S, V8.4S
    SHA1M  Q7, S17, V30.4S
    SHA256SU0  V19.4S, V3.4S
    SHA256H  Q17, Q10, V10.4S
    SHA1SU1  V16.4S, V30.4S
    SHA256SU0  V3.4S, V27.4S
    SHA1M  Q28, S12, V6.4S
    SHA1M  Q27, S22, V16.4S
    SHA1M  Q29, S15, V12.4S
    SHA1P  Q0, S31, V27.4S
    SHA1SU0  V26.4S, V23.4S, V29.4S
    SHA256SU0  V16.4S, V1.4S
    SHA1C  Q22, S26, V28.4S
    SHA256SU0  V12.4S, V19.4S
    SHA1M  Q18, S4, V7.4S
    SHA1SU1  V26.4S, V24.4S
    SHA1SU1  V25.4S, V6.4S
    SHA256H2  Q26, Q12, V31.4S
    SHA256SU0  V7.4S, V6.4S
    SHA1SU0  V12.4S, V3.4S, V18.4S
    SHA256H  Q14, Q22, V22.4S
    SHA256H  Q21, Q12, V14.4S
    SHA1P  Q31, S6, V18.4S
    SHA256SU0  V15.4S, V0.4S
    SHA256H2  Q9, Q2, V12.4S
    SHA256SU0  V4.4S, V15.4S
    SHA256SU0  V14.4S, V1.4S
    SHA1SU0  V1.4S, V18.4S, V15.4S
    SHA256SU0  V30.4S, V21.4S
    SHA256SU1  V10.4S, V25.4S, V7.4S
    SHA1SU1  V15.4S, V17.4S
    SHA256SU0  V25.4S, V15.4S
    SHA1SU0  V19.4S, V25.4S, V26.4S
    SHA1SU0  V18.4S, V12.4S, V19.4S
    SHA1C  Q19, S10, V20.4S
    SHA256SU1  V15.4S, V18.4S, V30.4S
    SHA1SU0  V25.4S, V15.4S, V29.4S
    SHA1C  Q28, S31, V4.4S
    SHA1P  Q6, S28, V28.4S
    SHA1M  Q29, S25, V25.4S
    SHA256SU1  V2.4S, V25.4S, V7.4S
    SHA256H2  Q22, Q29, V6.4S
    SHA1SU1  V26.4S, V9.4S
    SHA256SU0  V28.4S, V22.4S
    SHA256H  Q7, Q26, V26.4S
    SHA1SU0  V15.4S, V5.4S, V28.4S
    SHA1C  Q5, S1, V2.4S
    SHA256H  Q6, Q14, V5.4S
    SHA1C  Q29, S26, V13.4S
    SHA256SU0  V5.4S, V17.4S
    SHA1M  Q20, S0, V7.4S
    SHA1SU0  V23.4S, V20.4S, V9.4S
    SHA1P  Q26, S15, V5.4S
    SHA256H  Q1, Q23, V22.4S
    SHA1SU1  V10.4S, V29.4S
    SHA256H2  Q15, Q1, V6.4S
    SHA1SU1  V17.4S, V26.4S
    SHA256H2  Q4, Q3, V10.4S
    SHA1SU0  V29.4S, V15.4S, V17.4S
    SHA256SU0  V10.4S, V4.4S
    SHA256H2  Q28, Q10, V10.4S
    SHA256SU0  V2.4S, V15.4S
    SHA1SU0  V21.4S, V29.4S, V28.4S
    SHA1C  Q15, S2, V21.4S
    SHA1SU1  V6.4S, V29.4S
    SHA256H  Q20, Q14, V8.4S
    SHA1SU0  V1.4S, V2.4S, V8.4S
    SHA256SU1  V17.4S, V18.4S, V17.4S
    SHA256SU0  V25.4S, V3.4S
    SHA1SU1  V18.4S, V16.4S
    SHA1SU1  V21.4S, V7.4S
    SHA256H2  Q17, Q3, V18.4S
    SHA256H2  Q28, Q6, V2.4S
    SHA256SU0  V6.4S, V3.4S
    SHA1C  Q29, S8, V3.4S
    SHA256SU0  V10.4S, V6.4S
    SHA256SU0  V0.4S, V25.4S
    SHA1C  Q2, S21, V0.4S
    SHA256SU1  V23.4S, V29.4S, V29.4S
    SHA1M  Q8, S25, V23.4S
    SHA256H  Q26, Q2, V28.4S
    SHA1P  Q6, S8, V11.4S
    SHA256H2  Q0, Q6, V26.4S
    SHA256H2  Q29, Q5, V1.4S
    SHA256H2  Q2, Q8, V15.4S
    SHA256H  Q29, Q2, V19.4S
    SHA256H2  Q10, Q12, V27.4S
    SHA1M  Q2, S0, V20.4S
    SHA1SU0  V15.4S, V22.4S, V10.4S
    SHA256H2  Q27, Q16, V17.4S
    SHA256H2  Q22, Q16, V27.4S
    SHA256H2  Q3, Q6, V15.4S
    SHA256H2  Q22, Q29, V2.4S
    SHA1SU1  V10.4S, V26.4S
    SHA1P  Q1, S14, V28.4S
    SHA1P  Q20, S0, V3.4S
    SHA1C  Q25, S0, V31.4S
    SHA256SU1  V16.4S, V25.4S, V1.4S
    SHA256H2  Q23, Q15, V25.4S
    SHA1P  Q1, S3, V5.4S
    SHA256SU1  V3.4S, V1.4S, V11.4S
    SHA1M  Q14, S31, V26.4S
    SHA1M  Q0, S24, V8.4S
    SHA1SU0  V26.4S, V19.4S, V7.4S
    SHA256H  Q13, Q26, V25.4S
    SHA256H2  Q11, Q2, V3.4S
    SHA1C  Q8, S14, V14.4S
    SHA256H  Q17, Q23, V11.4S
    SHA256H  Q24, Q16, V30.4S
    SHA1SU0  V3.4S, V0.4S, V13.4S
    SHA1SU0  V21.4S, V17.4S, V25.4S
    SHA1SU0  V6.4S, V12.4S, V3.4S
    SHA1P  Q28, S20, V24.4S
    SHA256SU1  V14.4S, V8.4S, V28.4S
    SHA1M  Q26, S8, V19.4S
    SHA1SU1  V5.4S, V22.4S
    SHA256SU0  V24.4S, V5.4S
    SHA1SU0  V7.4S, V6.4S, V6.4S
    SHA1P  Q19, S24, V14.4S
    SHA1SU1  V30.4S, V19.4S
    SHA256H  Q27, Q13, V21.4S
    SHA1M  Q3, S5, V27.4S
    SHA256SU0  V5.4S, V0.4S
    SHA256SU0  V3.4S, V26.4S
    SHA256H  Q23, Q10, V30.4S
    SHA1SU0  V6.4S, V5.4S, V30.4S
    SHA256H2  Q26, Q4, V12.4S
    SHA256SU1  V15.4S, V23.4S, V7.4S
    SHA1P  Q14, S8, V15.4S
    SHA256H2  Q17, Q26, V3.4S
    SHA1C  Q12, S14, V29.4S
    SHA1SU1  V29.4S, V5.4S
    SHA256SU0  V27.4S, V25.4S
    SHA256SU1  V30.4S, V12.4S, V29.4S
    SHA256SU0  V13.4S, V6.4S
    SHA256H  Q6, Q17, V26.4S
    SHA1SU0  V25.4S, V30.4S, V9.4S
    SHA1SU1  V4.4S, V2.4S
    SHA256SU0  V5.4S, V15.4S
    SHA1P  Q14, S4, V19.4S
    SHA1SU1  V23.4S, V27.4S
    SHA256SU0  V27.4S, V18.4S
    SHA1M  Q0, S27, V23.4S
    SHA256SU0  V15.4S, V5.4S
    SHA256H  Q23, Q15, V6.4S
    SHA1C  Q3, S25, V31.4S
    SHA1M  Q10, S3, V0.4S
    SHA256SU0  V18.4S, V13.4S
    SHA256SU0  V4.4S, V14.4S
    SHA1SU1  V26.4S, V16.4S
    SHA1P  Q20, S6, V25.4S
    SHA1P  Q6, S16, V19.4S
    SHA1P  Q27, S16, V10.4S
    SHA1SU1  V0.4S, V31.4S
    SHA256H2  Q16, Q17, V18.4S
    SHA256SU0  V25.4S, V23.4S
    SHA256SU1  V18.4S, V24.4S, V25.4S
    SHA1M  Q25, S27, V29.4S
    SHA1P  Q3, S13, V5.4S
    SHA1P  Q24, S3, V25.4S
    SHA256H2  Q13, Q26, V20.4S
    SHA1SU1  V11.4S, V4.4S
    SHA256H  Q5, Q16, V11.4S
    SHA256SU0  V3.4S, V18.4S
    SHA1C  Q20, S31, V3.4S
    SHA1SU1  V14.4S, V0.4S
    SHA1SU1  V2.4S, V24.4S
    SHA1P  Q18, S3, V2.4S
    SHA1SU1  V11.4S, V14.4S
    SHA1SU0  V24.4S, V19.4S, V20.4S
    SHA1SU0  V27.4S, V6.4S, V8.4S
    SHA1P  Q14, S13, V27.4S
    SHA256SU1  V26.4S, V14.4S, V4.4S
    SHA1C  Q29, S24, V16.4S
    SHA256SU1  V4.4S, V17.4S, V28.4S
    SHA1SU1  V0.4S, V11.4S
    SUBS  X2, X2, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_7
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MRS  X10, FPSR
    MOVZ  X5, #0x0, LSL #0
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V0.D[1]
    MOVZ  X5, #0x47b7, LSL #0
    MOVK  X5, #0x4328, LSL #16
    MOVK  X5, #0x38e6, LSL #32
    MOVK  X5, #0xae82, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D0
    MOVZ  X5, #0x2a79, LSL #0
    MOVK  X5, #0x29da, LSL #16
    MOVK  X5, #0x7ca, LSL #32
    MOVK  X5, #0x9fb5, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V1.D[1]
    MOVZ  X5, #0xd05d, LSL #0
    MOVK  X5, #0xa40c, LSL #16
    MOVK  X5, #0xee52, LSL #32
    MOVK  X5, #0x9edc, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D1
    MOVZ  X5, #0xcc6, LSL #0
    MOVK  X5, #0xe842, LSL #16
    MOVK  X5, #0x55c6, LSL #32
    MOVK  X5, #0xd940, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V2.D[1]
    MOVZ  X5, #0xa97a, LSL #0
    MOVK  X5, #0xcd86, LSL #16
    MOVK  X5, #0xa634, LSL #32
    MOVK  X5, #0x568e, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D2
    MOVZ  X5, #0x7308, LSL #0
    MOVK  X5, #0x9ec2, LSL #16
    MOVK  X5, #0xa195, LSL #32
    MOVK  X5, #0x50f9, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V3.D[1]
    MOVZ  X5, #0xdaf8, LSL #0
    MOVK  X5, #0x2458, LSL #16
    MOVK  X5, #0x6925, LSL #32
    MOVK  X5, #0x7eeb, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D3
    MOVZ  X5, #0x46a9, LSL #0
    MOVK  X5, #0x785a, LSL #16
    MOVK  X5, #0xd656, LSL #32
    MOVK  X5, #0x557a, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X5, #0x9f2b, LSL #0
    MOVK  X5, #0x89d4, LSL #16
    MOVK  X5, #0xaa20, LSL #32
    MOVK  X5, #0xc286, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D4
    MOVZ  X5, #0x196d, LSL #0
    MOVK  X5, #0xbba0, LSL #16
    MOVK  X5, #0x4287, LSL #32
    MOVK  X5, #0xaae4, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X5, #0xf4ab, LSL #0
    MOVK  X5, #0x7e5d, LSL #16
    MOVK  X5, #0x85b1, LSL #32
    MOVK  X5, #0x718b, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D5
    MOVZ  X5, #0xe8de, LSL #0
    MOVK  X5, #0xd987, LSL #16
    MOVK  X5, #0xd0c9, LSL #32
    MOVK  X5, #0x3403, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V6.D[1]
    MOVZ  X5, #0x5d4b, LSL #0
    MOVK  X5, #0x6e6a, LSL #16
    MOVK  X5, #0xfa73, LSL #32
    MOVK  X5, #0xf359, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D6
    MOVZ  X5, #0x6c08, LSL #0
    MOVK  X5, #0x4d40, LSL #16
    MOVK  X5, #0x1dba, LSL #32
    MOVK  X5, #0xa260, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V7.D[1]
    MOVZ  X5, #0x9a54, LSL #0
    MOVK  X5, #0xf3db, LSL #16
    MOVK  X5, #0x8658, LSL #32
    MOVK  X5, #0xf0, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D7
    MOVZ  X5, #0x980b, LSL #0
    MOVK  X5, #0xa122, LSL #16
    MOVK  X5, #0x6aa, LSL #32
    MOVK  X5, #0xff65, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V8.D[1]
    MOVZ  X5, #0x3c73, LSL #0
    MOVK  X5, #0xd546, LSL #16
    MOVK  X5, #0xdc6a, LSL #32
    MOVK  X5, #0x58b8, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D8
    MOVZ  X5, #0x76ab, LSL #0
    MOVK  X5, #0xdb32, LSL #16
    MOVK  X5, #0x1818, LSL #32
    MOVK  X5, #0x2c55, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X5, #0x2de, LSL #0
    MOVK  X5, #0xdc72, LSL #16
    MOVK  X5, #0x94fb, LSL #32
    MOVK  X5, #0x77de, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D9
    MOVZ  X5, #0xe7f3, LSL #0
    MOVK  X5, #0x2389, LSL #16
    MOVK  X5, #0x7b06, LSL #32
    MOVK  X5, #0xa835, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V10.D[1]
    MOVZ  X5, #0xf0f8, LSL #0
    MOVK  X5, #0x5b3f, LSL #16
    MOVK  X5, #0x2ee5, LSL #32
    MOVK  X5, #0x5716, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D10
    MOVZ  X5, #0xaf81, LSL #0
    MOVK  X5, #0x39b5, LSL #16
    MOVK  X5, #0xbb2a, LSL #32
    MOVK  X5, #0xb7f6, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X5, #0x540b, LSL #0
    MOVK  X5, #0x209f, LSL #16
    MOVK  X5, #0x2e95, LSL #32
    MOVK  X5, #0x4c86, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D11
    MOVZ  X5, #0x7d5f, LSL #0
    MOVK  X5, #0x7ad7, LSL #16
    MOVK  X5, #0xec29, LSL #32
    MOVK  X5, #0x3329, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X5, #0x8787, LSL #0
    MOVK  X5, #0xf4d8, LSL #16
    MOVK  X5, #0x8625, LSL #32
    MOVK  X5, #0xa0b1, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D12
    MOVZ  X5, #0x5c5c, LSL #0
    MOVK  X5, #0x4723, LSL #16
    MOVK  X5, #0x80ea, LSL #32
    MOVK  X5, #0xd8e6, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V13.D[1]
    MOVZ  X5, #0x18b3, LSL #0
    MOVK  X5, #0x5ea9, LSL #16
    MOVK  X5, #0x83c8, LSL #32
    MOVK  X5, #0x3c99, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D13
    MOVZ  X5, #0x2b88, LSL #0
    MOVK  X5, #0x1c68, LSL #16
    MOVK  X5, #0x3299, LSL #32
    MOVK  X5, #0x67c1, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X5, #0x570c, LSL #0
    MOVK  X5, #0x5892, LSL #16
    MOVK  X5, #0x61eb, LSL #32
    MOVK  X5, #0x5f3c, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D14
    MOVZ  X5, #0xf93a, LSL #0
    MOVK  X5, #0x2445, LSL #16
    MOVK  X5, #0xb22, LSL #32
    MOVK  X5, #0xc0e9, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X5, #0xae4d, LSL #0
    MOVK  X5, #0xe8c0, LSL #16
    MOVK  X5, #0x742c, LSL #32
    MOVK  X5, #0xa4e7, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D15
    MOVZ  X5, #0xaecf, LSL #0
    MOVK  X5, #0x6a5, LSL #16
    MOVK  X5, #0xaaa2, LSL #32
    MOVK  X5, #0x573e, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X5, #0x42e7, LSL #0
    MOVK  X5, #0x4b1, LSL #16
    MOVK  X5, #0x7081, LSL #32
    MOVK  X5, #0x7eae, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D16
    MOVZ  X5, #0x358d, LSL #0
    MOVK  X5, #0x21fe, LSL #16
    MOVK  X5, #0x8416, LSL #32
    MOVK  X5, #0x73, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V17.D[1]
    MOVZ  X5, #0x23a0, LSL #0
    MOVK  X5, #0xac5, LSL #16
    MOVK  X5, #0x509e, LSL #32
    MOVK  X5, #0x91d6, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D17
    MOVZ  X5, #0x6189, LSL #0
    MOVK  X5, #0x5794, LSL #16
    MOVK  X5, #0xc8d5, LSL #32
    MOVK  X5, #0xc148, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X5, #0xbaaa, LSL #0
    MOVK  X5, #0xdad, LSL #16
    MOVK  X5, #0x3e97, LSL #32
    MOVK  X5, #0x7d66, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D18
    MOVZ  X5, #0xcc9e, LSL #0
    MOVK  X5, #0xdb7d, LSL #16
    MOVK  X5, #0x4f78, LSL #32
    MOVK  X5, #0xd9d0, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V19.D[1]
    MOVZ  X5, #0x7a40, LSL #0
    MOVK  X5, #0xffc2, LSL #16
    MOVK  X5, #0x3f7d, LSL #32
    MOVK  X5, #0xc871, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D19
    MOVZ  X5, #0x3d23, LSL #0
    MOVK  X5, #0xa86f, LSL #16
    MOVK  X5, #0x409d, LSL #32
    MOVK  X5, #0xf4d0, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X5, #0x411a, LSL #0
    MOVK  X5, #0xa96a, LSL #16
    MOVK  X5, #0x9676, LSL #32
    MOVK  X5, #0x73eb, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D20
    MOVZ  X5, #0xd94, LSL #0
    MOVK  X5, #0xedd3, LSL #16
    MOVK  X5, #0x2de6, LSL #32
    MOVK  X5, #0x743a, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X5, #0xb235, LSL #0
    MOVK  X5, #0xedad, LSL #16
    MOVK  X5, #0xb7f0, LSL #32
    MOVK  X5, #0x7890, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D21
    MOVZ  X5, #0xff24, LSL #0
    MOVK  X5, #0x2448, LSL #16
    MOVK  X5, #0xa42, LSL #32
    MOVK  X5, #0x2c38, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X5, #0x2149, LSL #0
    MOVK  X5, #0xe734, LSL #16
    MOVK  X5, #0xfc59, LSL #32
    MOVK  X5, #0x1a25, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D22
    MOVZ  X5, #0xb310, LSL #0
    MOVK  X5, #0xfb32, LSL #16
    MOVK  X5, #0xafe3, LSL #32
    MOVK  X5, #0xf476, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V23.D[1]
    MOVZ  X5, #0xca20, LSL #0
    MOVK  X5, #0xe50a, LSL #16
    MOVK  X5, #0xafbb, LSL #32
    MOVK  X5, #0xb239, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D23
    MOVZ  X5, #0x3ade, LSL #0
    MOVK  X5, #0xb2d8, LSL #16
    MOVK  X5, #0xd161, LSL #32
    MOVK  X5, #0x8c43, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X5, #0x84b6, LSL #0
    MOVK  X5, #0x2568, LSL #16
    MOVK  X5, #0xea71, LSL #32
    MOVK  X5, #0xdc2d, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D24
    MOVZ  X5, #0x5162, LSL #0
    MOVK  X5, #0x99ab, LSL #16
    MOVK  X5, #0x48ae, LSL #32
    MOVK  X5, #0x6512, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V25.D[1]
    MOVZ  X5, #0xfaf9, LSL #0
    MOVK  X5, #0xa18c, LSL #16
    MOVK  X5, #0x5245, LSL #32
    MOVK  X5, #0x507a, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D25
    MOVZ  X5, #0xc263, LSL #0
    MOVK  X5, #0x8808, LSL #16
    MOVK  X5, #0xc4bd, LSL #32
    MOVK  X5, #0x185f, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X5, #0x2949, LSL #0
    MOVK  X5, #0xa04c, LSL #16
    MOVK  X5, #0x216e, LSL #32
    MOVK  X5, #0x43e4, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D26
    MOVZ  X5, #0x3fb6, LSL #0
    MOVK  X5, #0x325c, LSL #16
    MOVK  X5, #0xf5e6, LSL #32
    MOVK  X5, #0x19fc, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X5, #0xdd04, LSL #0
    MOVK  X5, #0xfca8, LSL #16
    MOVK  X5, #0x11ef, LSL #32
    MOVK  X5, #0x3a43, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D27
    MOVZ  X5, #0xedea, LSL #0
    MOVK  X5, #0xdd09, LSL #16
    MOVK  X5, #0x8283, LSL #32
    MOVK  X5, #0xfc49, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V28.D[1]
    MOVZ  X5, #0x6582, LSL #0
    MOVK  X5, #0xd1c, LSL #16
    MOVK  X5, #0x26d, LSL #32
    MOVK  X5, #0x3874, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D28
    MOVZ  X5, #0x8d8d, LSL #0
    MOVK  X5, #0x8f00, LSL #16
    MOVK  X5, #0xe1c5, LSL #32
    MOVK  X5, #0xc96f, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V29.D[1]
    MOVZ  X5, #0x6e69, LSL #0
    MOVK  X5, #0xcade, LSL #16
    MOVK  X5, #0x3d90, LSL #32
    MOVK  X5, #0xa27d, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D29
    MOVZ  X5, #0xf320, LSL #0
    MOVK  X5, #0x749d, LSL #16
    MOVK  X5, #0xd083, LSL #32
    MOVK  X5, #0xcee0, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V30.D[1]
    MOVZ  X5, #0xb95a, LSL #0
    MOVK  X5, #0x8625, LSL #16
    MOVK  X5, #0xb89, LSL #32
    MOVK  X5, #0x98a8, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D30
    MOVZ  X5, #0x52a3, LSL #0
    MOVK  X5, #0x23f1, LSL #16
    MOVK  X5, #0x159a, LSL #32
    MOVK  X5, #0x4a68, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, V31.D[1]
    MOVZ  X5, #0x5b51, LSL #0
    MOVK  X5, #0x5a3e, LSL #16
    MOVK  X5, #0xe04e, LSL #32
    MOVK  X5, #0x4015, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X10, D31
    MOVZ  X5, #0xa50d, LSL #0
    MOVK  X5, #0x9f84, LSL #16
    MOVK  X5, #0xcbab, LSL #32
    MOVK  X5, #0x58e8, LSL #48
    SUB  X25, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
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
    FMOV  V0.D[1], X29
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X14
    FMOV  D3, X16
    FMOV  V3.D[1], X7
    FMOV  D4, X6
    FMOV  V4.D[1], X23
    FMOV  D5, X6
    FMOV  V5.D[1], X9
    FMOV  D6, X14
    FMOV  V6.D[1], X14
    FMOV  D7, X17
    FMOV  V7.D[1], X3
    FMOV  D8, X2
    FMOV  V8.D[1], X24
    FMOV  D9, X5
    FMOV  V9.D[1], X27
    FMOV  D10, X13
    FMOV  V10.D[1], X8
    FMOV  D11, X24
    FMOV  V11.D[1], X2
    FMOV  D12, X28
    FMOV  V12.D[1], X24
    FMOV  D13, X25
    FMOV  V13.D[1], X7
    FMOV  D14, X13
    FMOV  V14.D[1], X7
    FMOV  D15, X12
    FMOV  V15.D[1], X12
    FMOV  D16, X13
    FMOV  V16.D[1], X14
    FMOV  D17, X23
    FMOV  V17.D[1], X29
    FMOV  D18, X27
    FMOV  V18.D[1], X11
    FMOV  D19, X11
    FMOV  V19.D[1], X11
    FMOV  D20, X2
    FMOV  V20.D[1], X6
    FMOV  D21, X29
    FMOV  V21.D[1], X7
    FMOV  D22, X12
    FMOV  V22.D[1], X15
    FMOV  D23, X5
    FMOV  V23.D[1], X4
    FMOV  D24, X9
    FMOV  V24.D[1], X9
    FMOV  D25, X26
    FMOV  V25.D[1], X14
    FMOV  D26, X29
    FMOV  V26.D[1], X4
    FMOV  D27, X23
    FMOV  V27.D[1], X5
    FMOV  D28, X2
    FMOV  V28.D[1], X26
    FMOV  D29, X29
    FMOV  V29.D[1], X26
    FMOV  D30, X28
    FMOV  V30.D[1], X12
    FMOV  D31, X3
    FMOV  V31.D[1], X9
    MOVZ  X11, #0xa, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_8:
    SHA1C  Q30, S28, V22.4S
    SHA1P  Q10, S31, V26.4S
    SHA1SU1  V9.4S, V29.4S
    SHA1C  Q3, S24, V25.4S
    SHA256SU0  V3.4S, V2.4S
    SHA1M  Q31, S3, V23.4S
    SHA1C  Q1, S6, V9.4S
    SHA1SU1  V3.4S, V1.4S
    SHA256H  Q8, Q15, V31.4S
    SHA256SU1  V6.4S, V27.4S, V0.4S
    SHA1M  Q12, S8, V14.4S
    SHA256SU0  V25.4S, V3.4S
    SHA1SU1  V1.4S, V25.4S
    SHA1C  Q27, S2, V1.4S
    SHA256H  Q14, Q12, V27.4S
    SHA256H  Q29, Q30, V30.4S
    SHA1P  Q14, S15, V11.4S
    SHA1SU1  V0.4S, V29.4S
    SHA1P  Q25, S0, V6.4S
    SHA1M  Q31, S10, V13.4S
    SHA1SU1  V15.4S, V15.4S
    SHA256H  Q1, Q15, V14.4S
    SHA1M  Q3, S31, V31.4S
    SHA1M  Q27, S2, V13.4S
    SHA256SU0  V28.4S, V3.4S
    SHA1M  Q31, S11, V0.4S
    SHA256H2  Q9, Q5, V31.4S
    SHA256H2  Q2, Q9, V21.4S
    SHA1C  Q31, S2, V2.4S
    SHA1SU1  V20.4S, V17.4S
    SHA1SU0  V11.4S, V6.4S, V1.4S
    SHA256SU1  V3.4S, V28.4S, V25.4S
    SHA1M  Q22, S15, V20.4S
    SHA1P  Q30, S31, V5.4S
    SHA1SU0  V9.4S, V3.4S, V22.4S
    SHA1M  Q8, S27, V27.4S
    SHA1SU1  V6.4S, V9.4S
    SHA1P  Q25, S30, V11.4S
    SHA256SU1  V15.4S, V29.4S, V8.4S
    SHA1P  Q31, S22, V29.4S
    SHA256SU0  V9.4S, V6.4S
    SHA256H  Q20, Q25, V10.4S
    SHA1SU0  V8.4S, V3.4S, V9.4S
    SHA1SU0  V12.4S, V4.4S, V28.4S
    SHA1SU0  V1.4S, V31.4S, V14.4S
    SHA256H2  Q5, Q27, V15.4S
    SHA1M  Q16, S5, V14.4S
    SHA256H  Q10, Q1, V27.4S
    SHA1C  Q29, S25, V3.4S
    SHA1SU1  V4.4S, V30.4S
    SHA256SU0  V21.4S, V13.4S
    SHA256SU0  V13.4S, V8.4S
    SHA1P  Q27, S30, V13.4S
    SHA1SU0  V14.4S, V7.4S, V27.4S
    SHA1SU0  V25.4S, V29.4S, V23.4S
    SHA256SU0  V22.4S, V29.4S
    SHA1M  Q31, S10, V20.4S
    SHA1M  Q3, S26, V25.4S
    SHA1SU1  V17.4S, V21.4S
    SHA1C  Q7, S31, V3.4S
    SHA256SU0  V8.4S, V22.4S
    SHA1C  Q25, S16, V16.4S
    SHA1M  Q13, S4, V17.4S
    SHA256SU0  V30.4S, V25.4S
    SHA256SU0  V5.4S, V28.4S
    SHA1M  Q8, S13, V29.4S
    SHA256SU1  V27.4S, V5.4S, V7.4S
    SHA1SU0  V3.4S, V15.4S, V8.4S
    SHA1P  Q5, S3, V30.4S
    SHA1P  Q28, S24, V10.4S
    SHA1M  Q29, S23, V1.4S
    SHA256SU1  V17.4S, V12.4S, V28.4S
    SHA1SU0  V22.4S, V17.4S, V27.4S
    SHA1SU1  V11.4S, V19.4S
    SHA1M  Q15, S11, V25.4S
    SHA1SU0  V12.4S, V5.4S, V15.4S
    SHA256SU1  V11.4S, V26.4S, V13.4S
    SHA256H2  Q13, Q20, V12.4S
    SHA1M  Q16, S3, V11.4S
    SHA1SU1  V5.4S, V16.4S
    SHA1SU1  V26.4S, V8.4S
    SHA1P  Q11, S13, V20.4S
    SHA256SU1  V20.4S, V11.4S, V14.4S
    SHA256SU1  V16.4S, V2.4S, V20.4S
    SHA256SU1  V23.4S, V5.4S, V16.4S
    SHA1P  Q11, S24, V29.4S
    SHA1M  Q15, S25, V16.4S
    SHA256H2  Q29, Q11, V11.4S
    SHA1C  Q20, S22, V23.4S
    SHA256SU1  V8.4S, V27.4S, V20.4S
    SHA1C  Q3, S8, V8.4S
    SHA1C  Q28, S7, V21.4S
    SHA256H2  Q23, Q29, V29.4S
    SHA1SU1  V24.4S, V26.4S
    SHA256H  Q30, Q3, V6.4S
    SHA256H  Q29, Q30, V24.4S
    SHA1C  Q6, S13, V15.4S
    SHA256H  Q0, Q6, V29.4S
    SHA256SU1  V1.4S, V0.4S, V0.4S
    SHA1SU1  V10.4S, V20.4S
    SHA1C  Q24, S23, V23.4S
    SHA1P  Q30, S12, V24.4S
    SHA256SU0  V8.4S, V30.4S
    SHA1SU0  V27.4S, V10.4S, V31.4S
    SHA256H  Q13, Q31, V4.4S
    SHA256H2  Q23, Q15, V8.4S
    SHA1M  Q8, S27, V27.4S
    SHA1P  Q5, S1, V12.4S
    SHA1M  Q0, S13, V8.4S
    SHA256H2  Q24, Q28, V29.4S
    SHA1M  Q10, S23, V24.4S
    SHA1SU0  V12.4S, V9.4S, V10.4S
    SHA1SU0  V6.4S, V20.4S, V12.4S
    SHA256SU1  V12.4S, V22.4S, V6.4S
    SHA1SU0  V24.4S, V0.4S, V5.4S
    SHA256SU1  V29.4S, V12.4S, V28.4S
    SHA256SU0  V27.4S, V7.4S
    SHA256SU0  V6.4S, V0.4S
    SHA1C  Q4, S27, V7.4S
    SHA1SU0  V22.4S, V28.4S, V12.4S
    SHA1SU1  V15.4S, V9.4S
    SHA256H  Q19, Q16, V30.4S
    SHA256H2  Q5, Q27, V26.4S
    SHA1SU0  V30.4S, V27.4S, V1.4S
    SHA1M  Q3, S5, V6.4S
    SHA1SU1  V13.4S, V19.4S
    SHA1SU1  V8.4S, V13.4S
    SHA1M  Q23, S13, V22.4S
    SHA1P  Q19, S19, V29.4S
    SHA1C  Q26, S8, V28.4S
    SHA256H2  Q8, Q26, V24.4S
    SHA1SU0  V7.4S, V4.4S, V19.4S
    SHA256H  Q22, Q7, V30.4S
    SHA1SU1  V20.4S, V8.4S
    SHA1P  Q16, S3, V23.4S
    SHA1SU1  V14.4S, V29.4S
    SHA1P  Q5, S20, V28.4S
    SHA256H  Q20, Q14, V22.4S
    SHA256H  Q4, Q20, V12.4S
    SHA256SU0  V6.4S, V8.4S
    SHA256H2  Q24, Q16, V7.4S
    SHA1SU0  V12.4S, V24.4S, V6.4S
    SHA256SU1  V23.4S, V5.4S, V5.4S
    SHA256SU1  V25.4S, V30.4S, V12.4S
    SHA1SU0  V27.4S, V26.4S, V23.4S
    SHA256SU1  V6.4S, V25.4S, V4.4S
    SHA1M  Q29, S31, V31.4S
    SHA256H  Q29, Q6, V28.4S
    SHA1M  Q22, S26, V29.4S
    SHA1C  Q5, S27, V22.4S
    SHA1M  Q13, S14, V16.4S
    SHA1P  Q26, S25, V3.4S
    SHA1C  Q20, S14, V12.4S
    SHA256H  Q23, Q12, V5.4S
    SHA256H2  Q25, Q12, V12.4S
    SHA1P  Q14, S25, V14.4S
    SHA1P  Q27, S25, V7.4S
    SHA256H2  Q22, Q31, V27.4S
    SHA256SU0  V16.4S, V16.4S
    SHA256H2  Q31, Q27, V7.4S
    SHA256H2  Q3, Q27, V18.4S
    SHA256H2  Q18, Q21, V22.4S
    SHA256SU0  V25.4S, V3.4S
    SHA1SU1  V21.4S, V23.4S
    SHA256SU0  V30.4S, V26.4S
    SHA1C  Q24, S5, V30.4S
    SHA1SU0  V6.4S, V20.4S, V15.4S
    SHA256H2  Q16, Q13, V14.4S
    SHA256SU0  V4.4S, V26.4S
    SHA1M  Q13, S18, V26.4S
    SHA256H2  Q7, Q5, V25.4S
    SHA1M  Q22, S6, V24.4S
    SHA1P  Q3, S20, V16.4S
    SHA1SU1  V30.4S, V26.4S
    SHA1P  Q5, S31, V26.4S
    SHA1C  Q6, S3, V3.4S
    SHA1SU1  V20.4S, V13.4S
    SHA256H  Q20, Q6, V30.4S
    SHA1M  Q24, S4, V21.4S
    SHA1SU1  V14.4S, V20.4S
    SHA1SU1  V23.4S, V1.4S
    SHA256H2  Q1, Q12, V31.4S
    SHA1P  Q4, S14, V14.4S
    SHA1C  Q12, S30, V23.4S
    SHA256SU0  V21.4S, V4.4S
    SHA1M  Q23, S24, V1.4S
    SHA1SU1  V13.4S, V21.4S
    SHA1SU1  V16.4S, V22.4S
    SHA1P  Q14, S16, V13.4S
    SHA256SU0  V3.4S, V23.4S
    SHA256H2  Q30, Q3, V3.4S
    SHA256H  Q31, Q11, V30.4S
    SHA256SU1  V23.4S, V1.4S, V5.4S
    SHA256H2  Q20, Q23, V17.4S
    SHA256H  Q11, Q7, V10.4S
    SHA256SU1  V6.4S, V11.4S, V4.4S
    SHA256SU1  V30.4S, V12.4S, V12.4S
    SHA1M  Q3, S6, V31.4S
    SHA256SU1  V6.4S, V22.4S, V26.4S
    SHA256SU1  V24.4S, V8.4S, V6.4S
    SUBS  X11, X11, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_8
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X3, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X3, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X3, X28, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X3, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X3, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X3, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X3, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X3, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X3, X28, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X3, X28, X14
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X3, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X3, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X3, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X3, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X3, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X3, X28, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X3, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X3, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X3, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MRS  X28, FPSR
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V0.D[1]
    MOVZ  X3, #0x9ecc, LSL #0
    MOVK  X3, #0xa888, LSL #16
    MOVK  X3, #0x2221, LSL #32
    MOVK  X3, #0x1421, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D0
    MOVZ  X3, #0xa66b, LSL #0
    MOVK  X3, #0x2858, LSL #16
    MOVK  X3, #0x5c3b, LSL #32
    MOVK  X3, #0xb21d, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V1.D[1]
    MOVZ  X3, #0xab7c, LSL #0
    MOVK  X3, #0x4adc, LSL #16
    MOVK  X3, #0xf6e2, LSL #32
    MOVK  X3, #0xd58e, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D1
    MOVZ  X3, #0x481f, LSL #0
    MOVK  X3, #0xe184, LSL #16
    MOVK  X3, #0xe31d, LSL #32
    MOVK  X3, #0x51e5, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X3, #0xb6c9, LSL #0
    MOVK  X3, #0x50e0, LSL #16
    MOVK  X3, #0x6bcf, LSL #32
    MOVK  X3, #0xfc23, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D2
    MOVZ  X3, #0x6ecf, LSL #0
    MOVK  X3, #0x4431, LSL #16
    MOVK  X3, #0xa925, LSL #32
    MOVK  X3, #0x172d, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V3.D[1]
    MOVZ  X3, #0x5a18, LSL #0
    MOVK  X3, #0x6689, LSL #16
    MOVK  X3, #0x115c, LSL #32
    MOVK  X3, #0xb1, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D3
    MOVZ  X3, #0x10bb, LSL #0
    MOVK  X3, #0x5da5, LSL #16
    MOVK  X3, #0x1e7, LSL #32
    MOVK  X3, #0xb353, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V4.D[1]
    MOVZ  X3, #0x60c3, LSL #0
    MOVK  X3, #0x115e, LSL #16
    MOVK  X3, #0x4662, LSL #32
    MOVK  X3, #0x4a1d, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D4
    MOVZ  X3, #0xb653, LSL #0
    MOVK  X3, #0x129c, LSL #16
    MOVK  X3, #0x3763, LSL #32
    MOVK  X3, #0x179b, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X3, #0x99da, LSL #0
    MOVK  X3, #0x99e, LSL #16
    MOVK  X3, #0x86f5, LSL #32
    MOVK  X3, #0xac20, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D5
    MOVZ  X3, #0x5e4, LSL #0
    MOVK  X3, #0x7fd, LSL #16
    MOVK  X3, #0x62d3, LSL #32
    MOVK  X3, #0x52c7, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X3, #0x93cc, LSL #0
    MOVK  X3, #0x1b8b, LSL #16
    MOVK  X3, #0xe634, LSL #32
    MOVK  X3, #0xb4c0, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D6
    MOVZ  X3, #0xbcde, LSL #0
    MOVK  X3, #0x5bdb, LSL #16
    MOVK  X3, #0xa207, LSL #32
    MOVK  X3, #0x41d, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V7.D[1]
    MOVZ  X3, #0xb3b8, LSL #0
    MOVK  X3, #0x7454, LSL #16
    MOVK  X3, #0x31c1, LSL #32
    MOVK  X3, #0xcd16, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D7
    MOVZ  X3, #0x1da3, LSL #0
    MOVK  X3, #0xd80, LSL #16
    MOVK  X3, #0xfbcd, LSL #32
    MOVK  X3, #0x3290, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X3, #0x85a0, LSL #0
    MOVK  X3, #0x10cc, LSL #16
    MOVK  X3, #0x3222, LSL #32
    MOVK  X3, #0x5e5c, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D8
    MOVZ  X3, #0x160e, LSL #0
    MOVK  X3, #0x9299, LSL #16
    MOVK  X3, #0xc7f3, LSL #32
    MOVK  X3, #0x4793, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V9.D[1]
    MOVZ  X3, #0xe7d6, LSL #0
    MOVK  X3, #0xa927, LSL #16
    MOVK  X3, #0xf58, LSL #32
    MOVK  X3, #0xf23f, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D9
    MOVZ  X3, #0x6612, LSL #0
    MOVK  X3, #0xd1a7, LSL #16
    MOVK  X3, #0x57df, LSL #32
    MOVK  X3, #0xc36f, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X3, #0xaebb, LSL #0
    MOVK  X3, #0x2c, LSL #16
    MOVK  X3, #0xe96f, LSL #32
    MOVK  X3, #0x742b, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D10
    MOVZ  X3, #0x2dae, LSL #0
    MOVK  X3, #0xd75e, LSL #16
    MOVK  X3, #0xdbcb, LSL #32
    MOVK  X3, #0x47b5, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X3, #0xa4bb, LSL #0
    MOVK  X3, #0x42cf, LSL #16
    MOVK  X3, #0xafda, LSL #32
    MOVK  X3, #0xab2f, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D11
    MOVZ  X3, #0x585f, LSL #0
    MOVK  X3, #0xdeaf, LSL #16
    MOVK  X3, #0xf9c, LSL #32
    MOVK  X3, #0x65cb, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V12.D[1]
    MOVZ  X3, #0xc32, LSL #0
    MOVK  X3, #0xb435, LSL #16
    MOVK  X3, #0x1b9f, LSL #32
    MOVK  X3, #0x5667, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D12
    MOVZ  X3, #0x3454, LSL #0
    MOVK  X3, #0xca67, LSL #16
    MOVK  X3, #0xfeb1, LSL #32
    MOVK  X3, #0x348a, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V13.D[1]
    MOVZ  X3, #0x2f43, LSL #0
    MOVK  X3, #0xa7ae, LSL #16
    MOVK  X3, #0xe470, LSL #32
    MOVK  X3, #0xe75f, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D13
    MOVZ  X3, #0xf2ae, LSL #0
    MOVK  X3, #0x84c9, LSL #16
    MOVK  X3, #0xfc17, LSL #32
    MOVK  X3, #0x98eb, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X3, #0x82a7, LSL #0
    MOVK  X3, #0x1995, LSL #16
    MOVK  X3, #0x44b2, LSL #32
    MOVK  X3, #0x48a, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D14
    MOVZ  X3, #0x896f, LSL #0
    MOVK  X3, #0x2f97, LSL #16
    MOVK  X3, #0xe3b5, LSL #32
    MOVK  X3, #0xde3e, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V15.D[1]
    MOVZ  X3, #0x9eba, LSL #0
    MOVK  X3, #0x3a8c, LSL #16
    MOVK  X3, #0x7193, LSL #32
    MOVK  X3, #0x12f0, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D15
    MOVZ  X3, #0xb633, LSL #0
    MOVK  X3, #0xad87, LSL #16
    MOVK  X3, #0x3575, LSL #32
    MOVK  X3, #0x54f3, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X3, #0x93f5, LSL #0
    MOVK  X3, #0x3ff7, LSL #16
    MOVK  X3, #0xb4b1, LSL #32
    MOVK  X3, #0x9135, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D16
    MOVZ  X3, #0x22f4, LSL #0
    MOVK  X3, #0x698a, LSL #16
    MOVK  X3, #0x8bf8, LSL #32
    MOVK  X3, #0x3664, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X3, #0xffd6, LSL #0
    MOVK  X3, #0xd98b, LSL #16
    MOVK  X3, #0x3048, LSL #32
    MOVK  X3, #0xa3ba, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D17
    MOVZ  X3, #0xc5d9, LSL #0
    MOVK  X3, #0x4584, LSL #16
    MOVK  X3, #0xe143, LSL #32
    MOVK  X3, #0x79a2, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X3, #0xe9df, LSL #0
    MOVK  X3, #0x4369, LSL #16
    MOVK  X3, #0xea5f, LSL #32
    MOVK  X3, #0x4515, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D18
    MOVZ  X3, #0x8533, LSL #0
    MOVK  X3, #0xe664, LSL #16
    MOVK  X3, #0x1e01, LSL #32
    MOVK  X3, #0x94a3, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V19.D[1]
    MOVZ  X3, #0x32ca, LSL #0
    MOVK  X3, #0xba77, LSL #16
    MOVK  X3, #0xcffe, LSL #32
    MOVK  X3, #0xc5a6, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D19
    MOVZ  X3, #0x729a, LSL #0
    MOVK  X3, #0xf093, LSL #16
    MOVK  X3, #0x5564, LSL #32
    MOVK  X3, #0xbd5d, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X3, #0x207, LSL #0
    MOVK  X3, #0xcc5a, LSL #16
    MOVK  X3, #0xeb48, LSL #32
    MOVK  X3, #0xfb4, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D20
    MOVZ  X3, #0x1de9, LSL #0
    MOVK  X3, #0x4e2d, LSL #16
    MOVK  X3, #0x84ce, LSL #32
    MOVK  X3, #0x2d76, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V21.D[1]
    MOVZ  X3, #0x5566, LSL #0
    MOVK  X3, #0xb32e, LSL #16
    MOVK  X3, #0x5d83, LSL #32
    MOVK  X3, #0xaa4b, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D21
    MOVZ  X3, #0x6afd, LSL #0
    MOVK  X3, #0xdd3b, LSL #16
    MOVK  X3, #0xc697, LSL #32
    MOVK  X3, #0xc4cb, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X3, #0x916a, LSL #0
    MOVK  X3, #0xc462, LSL #16
    MOVK  X3, #0xac56, LSL #32
    MOVK  X3, #0x1a87, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D22
    MOVZ  X3, #0x8e79, LSL #0
    MOVK  X3, #0x16de, LSL #16
    MOVK  X3, #0x4b24, LSL #32
    MOVK  X3, #0x975a, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V23.D[1]
    MOVZ  X3, #0x795b, LSL #0
    MOVK  X3, #0x98bd, LSL #16
    MOVK  X3, #0x19e9, LSL #32
    MOVK  X3, #0x61b4, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D23
    MOVZ  X3, #0x765b, LSL #0
    MOVK  X3, #0xd309, LSL #16
    MOVK  X3, #0x964e, LSL #32
    MOVK  X3, #0x54c2, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X3, #0x1995, LSL #0
    MOVK  X3, #0x7bcd, LSL #16
    MOVK  X3, #0x490e, LSL #32
    MOVK  X3, #0xb1f2, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D24
    MOVZ  X3, #0xa234, LSL #0
    MOVK  X3, #0x66a7, LSL #16
    MOVK  X3, #0x5a4a, LSL #32
    MOVK  X3, #0x8d22, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X3, #0x8add, LSL #0
    MOVK  X3, #0x957f, LSL #16
    MOVK  X3, #0x80ad, LSL #32
    MOVK  X3, #0xdb0e, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D25
    MOVZ  X3, #0xcf9a, LSL #0
    MOVK  X3, #0xa9b3, LSL #16
    MOVK  X3, #0xffe9, LSL #32
    MOVK  X3, #0xc550, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X3, #0xf160, LSL #0
    MOVK  X3, #0x22cb, LSL #16
    MOVK  X3, #0x919e, LSL #32
    MOVK  X3, #0x885b, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D26
    MOVZ  X3, #0xf3d1, LSL #0
    MOVK  X3, #0xb765, LSL #16
    MOVK  X3, #0x3919, LSL #32
    MOVK  X3, #0x10c4, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V27.D[1]
    MOVZ  X3, #0x59d1, LSL #0
    MOVK  X3, #0x54de, LSL #16
    MOVK  X3, #0xa09b, LSL #32
    MOVK  X3, #0xc396, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D27
    MOVZ  X3, #0x8469, LSL #0
    MOVK  X3, #0xa0be, LSL #16
    MOVK  X3, #0x909d, LSL #32
    MOVK  X3, #0xb6d6, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V28.D[1]
    MOVZ  X3, #0x7661, LSL #0
    MOVK  X3, #0xc25d, LSL #16
    MOVK  X3, #0xfab9, LSL #32
    MOVK  X3, #0x1f21, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D28
    MOVZ  X3, #0x44bb, LSL #0
    MOVK  X3, #0x3028, LSL #16
    MOVK  X3, #0xecc8, LSL #32
    MOVK  X3, #0x3f9e, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V29.D[1]
    MOVZ  X3, #0x3300, LSL #0
    MOVK  X3, #0xc759, LSL #16
    MOVK  X3, #0x61c8, LSL #32
    MOVK  X3, #0xb927, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D29
    MOVZ  X3, #0x1191, LSL #0
    MOVK  X3, #0x9090, LSL #16
    MOVK  X3, #0x15e3, LSL #32
    MOVK  X3, #0xf0ce, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V30.D[1]
    MOVZ  X3, #0x570b, LSL #0
    MOVK  X3, #0x1a27, LSL #16
    MOVK  X3, #0xb2ff, LSL #32
    MOVK  X3, #0x343e, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D30
    MOVZ  X3, #0xeede, LSL #0
    MOVK  X3, #0x2262, LSL #16
    MOVK  X3, #0xa246, LSL #32
    MOVK  X3, #0x3e00, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, V31.D[1]
    MOVZ  X3, #0xfc00, LSL #0
    MOVK  X3, #0xecbd, LSL #16
    MOVK  X3, #0xce54, LSL #32
    MOVK  X3, #0x2cdf, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X28, D31
    MOVZ  X3, #0x207e, LSL #0
    MOVK  X3, #0xaa32, LSL #16
    MOVK  X3, #0x48b7, LSL #32
    MOVK  X3, #0xe08a, LSL #48
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
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
    FMOV  D0, X12
    FMOV  V0.D[1], X28
    FMOV  D1, X24
    FMOV  V1.D[1], X29
    FMOV  D2, X23
    FMOV  V2.D[1], X27
    FMOV  D3, X13
    FMOV  V3.D[1], X26
    FMOV  D4, X9
    FMOV  V4.D[1], X3
    FMOV  D5, X28
    FMOV  V5.D[1], X13
    FMOV  D6, X2
    FMOV  V6.D[1], X16
    FMOV  D7, X15
    FMOV  V7.D[1], X8
    FMOV  D8, X28
    FMOV  V8.D[1], X16
    FMOV  D9, X25
    FMOV  V9.D[1], X5
    FMOV  D10, X7
    FMOV  V10.D[1], X23
    FMOV  D11, X25
    FMOV  V11.D[1], X27
    FMOV  D12, X25
    FMOV  V12.D[1], X17
    FMOV  D13, X17
    FMOV  V13.D[1], X28
    FMOV  D14, X26
    FMOV  V14.D[1], X17
    FMOV  D15, X28
    FMOV  V15.D[1], X2
    FMOV  D16, X29
    FMOV  V16.D[1], X15
    FMOV  D17, X3
    FMOV  V17.D[1], X17
    FMOV  D18, X17
    FMOV  V18.D[1], X2
    FMOV  D19, X8
    FMOV  V19.D[1], X14
    FMOV  D20, X5
    FMOV  V20.D[1], X15
    FMOV  D21, X14
    FMOV  V21.D[1], X24
    FMOV  D22, X24
    FMOV  V22.D[1], X3
    FMOV  D23, X26
    FMOV  V23.D[1], X9
    FMOV  D24, X28
    FMOV  V24.D[1], X14
    FMOV  D25, X7
    FMOV  V25.D[1], X13
    FMOV  D26, X17
    FMOV  V26.D[1], X3
    FMOV  D27, X9
    FMOV  V27.D[1], X7
    FMOV  D28, X26
    FMOV  V28.D[1], X16
    FMOV  D29, X14
    FMOV  V29.D[1], X10
    FMOV  D30, X29
    FMOV  V30.D[1], X28
    FMOV  D31, X2
    FMOV  V31.D[1], X13
    MOVZ  X7, #0xa, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_9:
    SHA1M  Q29, S23, V31.4S
    SHA256H  Q27, Q26, V24.4S
    SHA256SU0  V16.4S, V25.4S
    SHA256SU0  V8.4S, V16.4S
    SHA1M  Q15, S29, V29.4S
    SHA256H2  Q30, Q8, V28.4S
    SHA1M  Q19, S27, V17.4S
    SHA1P  Q2, S15, V30.4S
    SHA1SU0  V26.4S, V1.4S, V4.4S
    SHA1SU0  V15.4S, V2.4S, V26.4S
    SHA1P  Q16, S24, V15.4S
    SHA1SU1  V27.4S, V13.4S
    SHA256SU0  V1.4S, V27.4S
    SHA1SU1  V15.4S, V16.4S
    SHA1SU0  V17.4S, V1.4S, V28.4S
    SHA1M  Q29, S28, V12.4S
    SHA256SU0  V4.4S, V6.4S
    SHA256SU0  V25.4S, V4.4S
    SHA1SU1  V13.4S, V17.4S
    SHA256H2  Q6, Q19, V13.4S
    SHA1P  Q17, S6, V6.4S
    SHA1SU1  V30.4S, V29.4S
    SHA1C  Q26, S10, V25.4S
    SHA1P  Q14, S17, V26.4S
    SHA256SU1  V16.4S, V30.4S, V15.4S
    SHA256H  Q30, Q27, V29.4S
    SHA1M  Q15, S5, V15.4S
    SHA1M  Q28, S11, V20.4S
    SHA256SU0  V31.4S, V20.4S
    SHA1SU0  V6.4S, V16.4S, V14.4S
    SHA1SU1  V10.4S, V5.4S
    SHA1P  Q12, S30, V9.4S
    SHA256SU0  V17.4S, V26.4S
    SHA256SU1  V25.4S, V13.4S, V19.4S
    SHA256SU0  V20.4S, V12.4S
    SHA256SU1  V21.4S, V21.4S, V28.4S
    SHA256SU0  V30.4S, V28.4S
    SHA256H2  Q4, Q10, V18.4S
    SHA256SU0  V16.4S, V2.4S
    SHA256SU1  V12.4S, V30.4S, V25.4S
    SHA256SU0  V5.4S, V12.4S
    SHA256SU0  V26.4S, V16.4S
    SHA1SU1  V10.4S, V21.4S
    SHA256H2  Q2, Q17, V25.4S
    SHA256SU0  V28.4S, V5.4S
    SHA1M  Q9, S18, V10.4S
    SHA256H  Q14, Q4, V2.4S
    SHA1SU0  V5.4S, V18.4S, V31.4S
    SHA256SU0  V1.4S, V9.4S
    SHA256H2  Q9, Q14, V28.4S
    SHA256H2  Q28, Q9, V26.4S
    SHA256H  Q9, Q5, V1.4S
    SHA1C  Q0, S28, V9.4S
    SHA1C  Q26, S3, V4.4S
    SHA256SU0  V11.4S, V0.4S
    SHA256H  Q18, Q3, V26.4S
    SHA1P  Q17, S18, V28.4S
    SHA256H2  Q21, Q11, V17.4S
    SHA1P  Q30, S21, V21.4S
    SHA256H2  Q7, Q30, V20.4S
    SHA1SU1  V9.4S, V26.4S
    SHA1SU0  V25.4S, V26.4S, V13.4S
    SHA256H2  Q1, Q0, V17.4S
    SHA1SU0  V3.4S, V26.4S, V7.4S
    SHA256SU1  V11.4S, V10.4S, V12.4S
    SHA1C  Q10, S31, V16.4S
    SHA1SU1  V31.4S, V13.4S
    SHA256H  Q30, Q6, V10.4S
    SHA1M  Q0, S0, V26.4S
    SHA1C  Q17, S30, V18.4S
    SHA1M  Q10, S27, V2.4S
    SHA256H  Q27, Q16, V9.4S
    SHA1SU0  V26.4S, V3.4S, V17.4S
    SHA1C  Q17, S19, V27.4S
    SHA256H2  Q7, Q25, V10.4S
    SHA256H  Q20, Q31, V26.4S
    SHA1M  Q30, S20, V7.4S
    SHA256SU1  V26.4S, V1.4S, V28.4S
    SHA1SU1  V14.4S, V12.4S
    SHA256H  Q6, Q2, V29.4S
    SHA256H2  Q12, Q26, V6.4S
    SHA256H2  Q4, Q0, V17.4S
    SHA1C  Q29, S30, V27.4S
    SHA1P  Q2, S1, V21.4S
    SHA1SU0  V27.4S, V2.4S, V8.4S
    SHA256H  Q20, Q4, V12.4S
    SHA256SU1  V3.4S, V20.4S, V14.4S
    SHA1SU1  V1.4S, V3.4S
    SHA256H2  Q18, Q27, V1.4S
    SHA1C  Q31, S18, V11.4S
    SHA256H  Q14, Q16, V9.4S
    SHA1SU0  V22.4S, V0.4S, V15.4S
    SHA1SU1  V10.4S, V6.4S
    SHA256SU0  V20.4S, V27.4S
    SHA256H  Q13, Q21, V17.4S
    SHA1M  Q1, S7, V15.4S
    SHA1M  Q11, S8, V23.4S
    SHA256H  Q25, Q10, V22.4S
    SHA1M  Q21, S25, V1.4S
    SHA256SU0  V3.4S, V13.4S
    SHA1C  Q7, S4, V14.4S
    SHA256H2  Q8, Q7, V7.4S
    SHA256SU0  V13.4S, V17.4S
    SHA1SU0  V0.4S, V8.4S, V3.4S
    SHA256H2  Q7, Q1, V31.4S
    SHA256H2  Q30, Q11, V30.4S
    SHA1M  Q31, S18, V13.4S
    SHA256H2  Q6, Q7, V6.4S
    SHA1P  Q15, S30, V20.4S
    SHA1P  Q17, S21, V15.4S
    SHA1SU1  V17.4S, V17.4S
    SHA256SU0  V18.4S, V31.4S
    SHA256H2  Q21, Q1, V0.4S
    SHA256SU0  V4.4S, V12.4S
    SHA1SU0  V3.4S, V2.4S, V21.4S
    SHA256H2  Q27, Q18, V18.4S
    SHA256SU0  V31.4S, V4.4S
    SHA1C  Q12, S0, V17.4S
    SHA1C  Q30, S5, V6.4S
    SHA1M  Q1, S3, V31.4S
    SHA256SU0  V15.4S, V21.4S
    SHA256SU1  V22.4S, V15.4S, V13.4S
    SHA1C  Q5, S22, V25.4S
    SHA256SU1  V23.4S, V24.4S, V28.4S
    SHA1SU0  V7.4S, V5.4S, V23.4S
    SHA1C  Q3, S27, V27.4S
    SHA256H2  Q13, Q15, V14.4S
    SHA1P  Q10, S17, V13.4S
    SHA256H2  Q11, Q10, V3.4S
    SHA1SU1  V28.4S, V22.4S
    SHA256SU0  V8.4S, V9.4S
    SHA1SU0  V4.4S, V17.4S, V20.4S
    SHA1SU1  V14.4S, V7.4S
    SHA256H  Q3, Q11, V12.4S
    SHA256SU0  V6.4S, V3.4S
    SHA1C  Q15, S14, V13.4S
    SHA1SU1  V2.4S, V1.4S
    SHA256H  Q24, Q22, V28.4S
    SHA256SU0  V27.4S, V8.4S
    SHA256SU0  V9.4S, V21.4S
    SHA1SU0  V0.4S, V25.4S, V9.4S
    SHA1P  Q18, S0, V4.4S
    SHA256SU1  V22.4S, V15.4S, V30.4S
    SHA1SU0  V14.4S, V18.4S, V9.4S
    SHA256SU1  V17.4S, V24.4S, V22.4S
    SHA256SU0  V1.4S, V6.4S
    SHA256H  Q31, Q27, V15.4S
    SHA256H2  Q26, Q22, V17.4S
    SHA256H2  Q30, Q14, V14.4S
    SHA1P  Q28, S12, V30.4S
    SHA1SU1  V25.4S, V9.4S
    SHA256H2  Q17, Q25, V28.4S
    SHA1SU1  V6.4S, V30.4S
    SHA256SU1  V16.4S, V1.4S, V16.4S
    SHA1P  Q21, S31, V2.4S
    SHA1P  Q27, S19, V16.4S
    SHA256SU1  V8.4S, V6.4S, V6.4S
    SHA256SU0  V22.4S, V3.4S
    SHA256SU1  V0.4S, V26.4S, V8.4S
    SHA1C  Q7, S0, V27.4S
    SHA1SU1  V3.4S, V14.4S
    SHA256SU0  V13.4S, V21.4S
    SHA1M  Q4, S30, V13.4S
    SHA1SU1  V15.4S, V22.4S
    SHA1SU0  V31.4S, V6.4S, V15.4S
    SHA1P  Q30, S17, V4.4S
    SHA256SU1  V16.4S, V7.4S, V31.4S
    SHA1P  Q14, S15, V20.4S
    SHA1SU0  V0.4S, V23.4S, V14.4S
    SHA256H  Q9, Q12, V4.4S
    SHA1M  Q15, S3, V3.4S
    SHA256SU1  V31.4S, V0.4S, V19.4S
    SHA256SU1  V3.4S, V27.4S, V7.4S
    SHA256H  Q17, Q0, V9.4S
    SHA256H2  Q6, Q31, V13.4S
    SHA1M  Q14, S6, V30.4S
    SHA256SU1  V19.4S, V30.4S, V2.4S
    SHA256H  Q22, Q3, V17.4S
    SHA256H  Q20, Q14, V16.4S
    SHA256H2  Q3, Q15, V15.4S
    SHA256SU0  V13.4S, V22.4S
    SHA256H2  Q15, Q20, V19.4S
    SHA1SU1  V7.4S, V15.4S
    SHA1SU1  V21.4S, V13.4S
    SHA1SU1  V22.4S, V8.4S
    SHA1SU0  V26.4S, V21.4S, V11.4S
    SHA1C  Q24, S22, V22.4S
    SHA1C  Q8, S16, V8.4S
    SHA1M  Q21, S7, V8.4S
    SHA256SU0  V31.4S, V3.4S
    SHA1SU0  V8.4S, V21.4S, V24.4S
    SHA256SU1  V3.4S, V31.4S, V31.4S
    SHA1P  Q30, S14, V27.4S
    SHA256H2  Q10, Q8, V16.4S
    SHA256H  Q23, Q22, V13.4S
    SHA1P  Q14, S26, V23.4S
    SHA256SU0  V17.4S, V20.4S
    SHA1SU0  V11.4S, V30.4S, V23.4S
    SHA1SU1  V20.4S, V11.4S
    SHA1SU0  V31.4S, V14.4S, V20.4S
    SUBS  X7, X7, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_9
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X25, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X25, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X25, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X25, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X25, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X25, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X25, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X25, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X25, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X25, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X25, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X25, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X25, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X25, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X25, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X25, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X25, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X25, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X25, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MRS  X11, FPSR
    MOVZ  X25, #0x0, LSL #0
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V0.D[1]
    MOVZ  X25, #0xa492, LSL #0
    MOVK  X25, #0x8c2a, LSL #16
    MOVK  X25, #0xdc9a, LSL #32
    MOVK  X25, #0x694e, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D0
    MOVZ  X25, #0x3006, LSL #0
    MOVK  X25, #0xd5fc, LSL #16
    MOVK  X25, #0xf643, LSL #32
    MOVK  X25, #0x2686, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V1.D[1]
    MOVZ  X25, #0x94b4, LSL #0
    MOVK  X25, #0x603e, LSL #16
    MOVK  X25, #0x79a4, LSL #32
    MOVK  X25, #0xb4bf, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D1
    MOVZ  X25, #0x3474, LSL #0
    MOVK  X25, #0xde9, LSL #16
    MOVK  X25, #0x9e18, LSL #32
    MOVK  X25, #0xfd8, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X25, #0x60e1, LSL #0
    MOVK  X25, #0x8e9e, LSL #16
    MOVK  X25, #0xede0, LSL #32
    MOVK  X25, #0xaa75, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D2
    MOVZ  X25, #0x655a, LSL #0
    MOVK  X25, #0x98bc, LSL #16
    MOVK  X25, #0x6a4, LSL #32
    MOVK  X25, #0xa262, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X25, #0x33e7, LSL #0
    MOVK  X25, #0xa59b, LSL #16
    MOVK  X25, #0xde72, LSL #32
    MOVK  X25, #0x41e3, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D3
    MOVZ  X25, #0x1be, LSL #0
    MOVK  X25, #0xeff4, LSL #16
    MOVK  X25, #0x4fb2, LSL #32
    MOVK  X25, #0xbb6d, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X25, #0xc927, LSL #0
    MOVK  X25, #0xec06, LSL #16
    MOVK  X25, #0x35dc, LSL #32
    MOVK  X25, #0xf0ee, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D4
    MOVZ  X25, #0x884c, LSL #0
    MOVK  X25, #0x1fde, LSL #16
    MOVK  X25, #0x11e6, LSL #32
    MOVK  X25, #0x9750, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X25, #0x4465, LSL #0
    MOVK  X25, #0xf71e, LSL #16
    MOVK  X25, #0x38f6, LSL #32
    MOVK  X25, #0x23c4, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D5
    MOVZ  X25, #0x437a, LSL #0
    MOVK  X25, #0xae84, LSL #16
    MOVK  X25, #0x9f47, LSL #32
    MOVK  X25, #0xac63, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V6.D[1]
    MOVZ  X25, #0xdb3a, LSL #0
    MOVK  X25, #0x49cd, LSL #16
    MOVK  X25, #0x5a65, LSL #32
    MOVK  X25, #0x2907, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D6
    MOVZ  X25, #0x5bb4, LSL #0
    MOVK  X25, #0xd7d0, LSL #16
    MOVK  X25, #0xde3c, LSL #32
    MOVK  X25, #0xa323, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X25, #0x3b2, LSL #0
    MOVK  X25, #0xfbba, LSL #16
    MOVK  X25, #0x5e90, LSL #32
    MOVK  X25, #0x933, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D7
    MOVZ  X25, #0x902c, LSL #0
    MOVK  X25, #0xb877, LSL #16
    MOVK  X25, #0x78b, LSL #32
    MOVK  X25, #0x318f, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X25, #0x77bd, LSL #0
    MOVK  X25, #0x1e7a, LSL #16
    MOVK  X25, #0xb73d, LSL #32
    MOVK  X25, #0xcccb, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D8
    MOVZ  X25, #0x9b71, LSL #0
    MOVK  X25, #0x858d, LSL #16
    MOVK  X25, #0x8e1a, LSL #32
    MOVK  X25, #0x2084, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X25, #0x6d8, LSL #0
    MOVK  X25, #0x9b8, LSL #16
    MOVK  X25, #0x42f6, LSL #32
    MOVK  X25, #0x680b, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D9
    MOVZ  X25, #0xaa8c, LSL #0
    MOVK  X25, #0x190f, LSL #16
    MOVK  X25, #0x16ba, LSL #32
    MOVK  X25, #0x5740, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X25, #0x9b93, LSL #0
    MOVK  X25, #0xe98, LSL #16
    MOVK  X25, #0x5853, LSL #32
    MOVK  X25, #0xd3ee, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D10
    MOVZ  X25, #0x5375, LSL #0
    MOVK  X25, #0x911a, LSL #16
    MOVK  X25, #0x55b, LSL #32
    MOVK  X25, #0xa49e, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V11.D[1]
    MOVZ  X25, #0x5e90, LSL #0
    MOVK  X25, #0xdd93, LSL #16
    MOVK  X25, #0xbffc, LSL #32
    MOVK  X25, #0xf9c1, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D11
    MOVZ  X25, #0x114f, LSL #0
    MOVK  X25, #0x3ec1, LSL #16
    MOVK  X25, #0x418c, LSL #32
    MOVK  X25, #0x1117, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X25, #0x3410, LSL #0
    MOVK  X25, #0x9c5f, LSL #16
    MOVK  X25, #0x7f57, LSL #32
    MOVK  X25, #0x6da7, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D12
    MOVZ  X25, #0x723e, LSL #0
    MOVK  X25, #0x2d16, LSL #16
    MOVK  X25, #0x2325, LSL #32
    MOVK  X25, #0x523c, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X25, #0x9b86, LSL #0
    MOVK  X25, #0x545c, LSL #16
    MOVK  X25, #0xdcbf, LSL #32
    MOVK  X25, #0x5a03, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D13
    MOVZ  X25, #0x8372, LSL #0
    MOVK  X25, #0x5ed9, LSL #16
    MOVK  X25, #0x765e, LSL #32
    MOVK  X25, #0x64c9, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X25, #0x5d32, LSL #0
    MOVK  X25, #0x5b11, LSL #16
    MOVK  X25, #0xcf6d, LSL #32
    MOVK  X25, #0x2ee3, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D14
    MOVZ  X25, #0xbfd0, LSL #0
    MOVK  X25, #0xdaa2, LSL #16
    MOVK  X25, #0x8293, LSL #32
    MOVK  X25, #0x2dbb, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X25, #0x8bd9, LSL #0
    MOVK  X25, #0x10f7, LSL #16
    MOVK  X25, #0x5d95, LSL #32
    MOVK  X25, #0x7f97, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D15
    MOVZ  X25, #0xdff2, LSL #0
    MOVK  X25, #0x1562, LSL #16
    MOVK  X25, #0xece8, LSL #32
    MOVK  X25, #0xd27f, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X25, #0x548d, LSL #0
    MOVK  X25, #0xab33, LSL #16
    MOVK  X25, #0x3a5f, LSL #32
    MOVK  X25, #0x2205, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D16
    MOVZ  X25, #0x8c3e, LSL #0
    MOVK  X25, #0x4d04, LSL #16
    MOVK  X25, #0x913f, LSL #32
    MOVK  X25, #0x6b98, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X25, #0xdaeb, LSL #0
    MOVK  X25, #0xec04, LSL #16
    MOVK  X25, #0x88e8, LSL #32
    MOVK  X25, #0x9607, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D17
    MOVZ  X25, #0x97b7, LSL #0
    MOVK  X25, #0x430b, LSL #16
    MOVK  X25, #0xc3d6, LSL #32
    MOVK  X25, #0xee67, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X25, #0x9eaa, LSL #0
    MOVK  X25, #0x6a3c, LSL #16
    MOVK  X25, #0x8118, LSL #32
    MOVK  X25, #0x598a, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D18
    MOVZ  X25, #0x67, LSL #0
    MOVK  X25, #0xa22e, LSL #16
    MOVK  X25, #0x1714, LSL #32
    MOVK  X25, #0x44c2, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X25, #0xfe60, LSL #0
    MOVK  X25, #0x2466, LSL #16
    MOVK  X25, #0x32b1, LSL #32
    MOVK  X25, #0x5d74, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D19
    MOVZ  X25, #0xe775, LSL #0
    MOVK  X25, #0x6ca9, LSL #16
    MOVK  X25, #0x9e47, LSL #32
    MOVK  X25, #0x652a, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X25, #0x1704, LSL #0
    MOVK  X25, #0xa4, LSL #16
    MOVK  X25, #0x2df0, LSL #32
    MOVK  X25, #0xd8af, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D20
    MOVZ  X25, #0x43cf, LSL #0
    MOVK  X25, #0xd917, LSL #16
    MOVK  X25, #0x4e11, LSL #32
    MOVK  X25, #0x1ce6, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X25, #0xcccd, LSL #0
    MOVK  X25, #0xff9a, LSL #16
    MOVK  X25, #0xaf7e, LSL #32
    MOVK  X25, #0x88a8, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D21
    MOVZ  X25, #0x2c27, LSL #0
    MOVK  X25, #0x81b2, LSL #16
    MOVK  X25, #0x997d, LSL #32
    MOVK  X25, #0x365b, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X25, #0xfeec, LSL #0
    MOVK  X25, #0xb650, LSL #16
    MOVK  X25, #0x5754, LSL #32
    MOVK  X25, #0xd81d, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D22
    MOVZ  X25, #0x924d, LSL #0
    MOVK  X25, #0x5df, LSL #16
    MOVK  X25, #0x955d, LSL #32
    MOVK  X25, #0x6f97, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X25, #0x11e2, LSL #0
    MOVK  X25, #0xf5dc, LSL #16
    MOVK  X25, #0x655f, LSL #32
    MOVK  X25, #0xcb38, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D23
    MOVZ  X25, #0x7047, LSL #0
    MOVK  X25, #0x417e, LSL #16
    MOVK  X25, #0xd6fc, LSL #32
    MOVK  X25, #0x5e68, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X25, #0x6e2f, LSL #0
    MOVK  X25, #0xd665, LSL #16
    MOVK  X25, #0x2615, LSL #32
    MOVK  X25, #0x17c4, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D24
    MOVZ  X25, #0x6f7c, LSL #0
    MOVK  X25, #0x6a1, LSL #16
    MOVK  X25, #0x8ee7, LSL #32
    MOVK  X25, #0xcd49, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X25, #0x333d, LSL #0
    MOVK  X25, #0x11cf, LSL #16
    MOVK  X25, #0x2437, LSL #32
    MOVK  X25, #0x3dd2, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D25
    MOVZ  X25, #0x5397, LSL #0
    MOVK  X25, #0x5441, LSL #16
    MOVK  X25, #0x1429, LSL #32
    MOVK  X25, #0x34b7, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X25, #0x26d, LSL #0
    MOVK  X25, #0x485c, LSL #16
    MOVK  X25, #0xfac, LSL #32
    MOVK  X25, #0x9cb1, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D26
    MOVZ  X25, #0x1b1, LSL #0
    MOVK  X25, #0x441e, LSL #16
    MOVK  X25, #0xee52, LSL #32
    MOVK  X25, #0x8102, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X25, #0xfa64, LSL #0
    MOVK  X25, #0x7811, LSL #16
    MOVK  X25, #0x3eb8, LSL #32
    MOVK  X25, #0xbfa, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D27
    MOVZ  X25, #0xe7ea, LSL #0
    MOVK  X25, #0xed51, LSL #16
    MOVK  X25, #0xd3fd, LSL #32
    MOVK  X25, #0xe56c, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X25, #0x5471, LSL #0
    MOVK  X25, #0xc83, LSL #16
    MOVK  X25, #0xf378, LSL #32
    MOVK  X25, #0xbd19, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D28
    MOVZ  X25, #0xd704, LSL #0
    MOVK  X25, #0x6d41, LSL #16
    MOVK  X25, #0xcbda, LSL #32
    MOVK  X25, #0x591e, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X25, #0x3e31, LSL #0
    MOVK  X25, #0x6345, LSL #16
    MOVK  X25, #0x799b, LSL #32
    MOVK  X25, #0x862d, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D29
    MOVZ  X25, #0x2be2, LSL #0
    MOVK  X25, #0x415a, LSL #16
    MOVK  X25, #0xbea8, LSL #32
    MOVK  X25, #0xfff, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V30.D[1]
    MOVZ  X25, #0x311b, LSL #0
    MOVK  X25, #0xcbee, LSL #16
    MOVK  X25, #0xd4cb, LSL #32
    MOVK  X25, #0xbb75, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D30
    MOVZ  X25, #0xca13, LSL #0
    MOVK  X25, #0x73a1, LSL #16
    MOVK  X25, #0x986e, LSL #32
    MOVK  X25, #0x6d02, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, V31.D[1]
    MOVZ  X25, #0x8e58, LSL #0
    MOVK  X25, #0x5e4a, LSL #16
    MOVK  X25, #0x3468, LSL #32
    MOVK  X25, #0x4142, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X11, D31
    MOVZ  X25, #0xaff0, LSL #0
    MOVK  X25, #0x22c8, LSL #16
    MOVK  X25, #0xeca3, LSL #32
    MOVK  X25, #0x188c, LSL #48
    SUB  X27, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X2, #0x3c89, LSL #0
    MOVK  X2, #0xf414, LSL #16
    MOVK  X2, #0x2166, LSL #32
    MOVK  X2, #0x2dea, LSL #48
    MOVZ  X3, #0xf553, LSL #0
    MOVK  X3, #0x31f6, LSL #16
    MOVK  X3, #0xf0e2, LSL #32
    MOVK  X3, #0x65b2, LSL #48
    MOVZ  X4, #0x4a1, LSL #0
    MOVK  X4, #0x99f2, LSL #16
    MOVK  X4, #0x465d, LSL #32
    MOVK  X4, #0x7ec6, LSL #48
    MOVZ  X5, #0x471f, LSL #0
    MOVK  X5, #0x885c, LSL #16
    MOVK  X5, #0xdc5f, LSL #32
    MOVK  X5, #0x18a5, LSL #48
    MOVZ  X6, #0xf242, LSL #0
    MOVK  X6, #0xe9d8, LSL #16
    MOVK  X6, #0x3a13, LSL #32
    MOVK  X6, #0xdc3c, LSL #48
    MOVZ  X7, #0x81f8, LSL #0
    MOVK  X7, #0xe3a7, LSL #16
    MOVK  X7, #0x9632, LSL #32
    MOVK  X7, #0x3a63, LSL #48
    MOVZ  X8, #0x8288, LSL #0
    MOVK  X8, #0x544d, LSL #16
    MOVK  X8, #0x5095, LSL #32
    MOVK  X8, #0xa0bc, LSL #48
    MOVZ  X9, #0x29f3, LSL #0
    MOVK  X9, #0x3b86, LSL #16
    MOVK  X9, #0x8d1, LSL #32
    MOVK  X9, #0x7422, LSL #48
    MOVZ  X10, #0x6af6, LSL #0
    MOVK  X10, #0x6b72, LSL #16
    MOVK  X10, #0xb14c, LSL #32
    MOVK  X10, #0xcf18, LSL #48
    MOVZ  X11, #0x6867, LSL #0
    MOVK  X11, #0x29ad, LSL #16
    MOVK  X11, #0xa5c6, LSL #32
    MOVK  X11, #0xca22, LSL #48
    MOVZ  X12, #0x8ca2, LSL #0
    MOVK  X12, #0x6e1e, LSL #16
    MOVK  X12, #0xfe1, LSL #32
    MOVK  X12, #0xd960, LSL #48
    MOVZ  X13, #0xe4a7, LSL #0
    MOVK  X13, #0xb5d7, LSL #16
    MOVK  X13, #0x20b2, LSL #32
    MOVK  X13, #0x66ba, LSL #48
    MOVZ  X14, #0x1079, LSL #0
    MOVK  X14, #0x4dc9, LSL #16
    MOVK  X14, #0x1d18, LSL #32
    MOVK  X14, #0x1ed1, LSL #48
    MOVZ  X15, #0x8136, LSL #0
    MOVK  X15, #0x604, LSL #16
    MOVK  X15, #0xff99, LSL #32
    MOVK  X15, #0x87c5, LSL #48
    MOVZ  X16, #0x83aa, LSL #0
    MOVK  X16, #0x1023, LSL #16
    MOVK  X16, #0x1d21, LSL #32
    MOVK  X16, #0x3428, LSL #48
    MOVZ  X17, #0x5bf, LSL #0
    MOVK  X17, #0x9934, LSL #16
    MOVK  X17, #0x67a7, LSL #32
    MOVK  X17, #0x80b2, LSL #48
    MOVZ  X23, #0x505f, LSL #0
    MOVK  X23, #0x574c, LSL #16
    MOVK  X23, #0xd84d, LSL #32
    MOVK  X23, #0xd6ca, LSL #48
    MOVZ  X24, #0xff9, LSL #0
    MOVK  X24, #0x254d, LSL #16
    MOVK  X24, #0x46ba, LSL #32
    MOVK  X24, #0xa4bc, LSL #48
    MOVZ  X25, #0xc2a8, LSL #0
    MOVK  X25, #0x2f07, LSL #16
    MOVK  X25, #0x47e9, LSL #32
    MOVK  X25, #0x7014, LSL #48
    MOVZ  X26, #0xcf31, LSL #0
    MOVK  X26, #0xfc61, LSL #16
    MOVK  X26, #0x8a5d, LSL #32
    MOVK  X26, #0x340c, LSL #48
    MOVZ  X27, #0x4ac9, LSL #0
    MOVK  X27, #0xe334, LSL #16
    MOVK  X27, #0x7bcf, LSL #32
    MOVK  X27, #0x47f0, LSL #48
    MOVZ  X28, #0x8ace, LSL #0
    MOVK  X28, #0x42a5, LSL #16
    MOVK  X28, #0x73a, LSL #32
    MOVK  X28, #0xfd6, LSL #48
    MOVZ  X29, #0x8492, LSL #0
    MOVK  X29, #0xafda, LSL #16
    MOVK  X29, #0xf357, LSL #32
    MOVK  X29, #0x3d04, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X25
    FMOV  D1, X13
    FMOV  V1.D[1], X28
    FMOV  D2, X15
    FMOV  V2.D[1], X11
    FMOV  D3, X16
    FMOV  V3.D[1], X11
    FMOV  D4, X27
    FMOV  V4.D[1], X6
    FMOV  D5, X12
    FMOV  V5.D[1], X12
    FMOV  D6, X25
    FMOV  V6.D[1], X27
    FMOV  D7, X16
    FMOV  V7.D[1], X11
    FMOV  D8, X6
    FMOV  V8.D[1], X8
    FMOV  D9, X26
    FMOV  V9.D[1], X29
    FMOV  D10, X24
    FMOV  V10.D[1], X25
    FMOV  D11, X16
    FMOV  V11.D[1], X9
    FMOV  D12, X9
    FMOV  V12.D[1], X16
    FMOV  D13, X24
    FMOV  V13.D[1], X27
    FMOV  D14, X7
    FMOV  V14.D[1], X5
    FMOV  D15, X13
    FMOV  V15.D[1], X2
    FMOV  D16, X4
    FMOV  V16.D[1], X26
    FMOV  D17, X2
    FMOV  V17.D[1], X27
    FMOV  D18, X29
    FMOV  V18.D[1], X12
    FMOV  D19, X5
    FMOV  V19.D[1], X12
    FMOV  D20, X17
    FMOV  V20.D[1], X23
    FMOV  D21, X29
    FMOV  V21.D[1], X16
    FMOV  D22, X12
    FMOV  V22.D[1], X17
    FMOV  D23, X3
    FMOV  V23.D[1], X4
    FMOV  D24, X15
    FMOV  V24.D[1], X29
    FMOV  D25, X29
    FMOV  V25.D[1], X23
    FMOV  D26, X25
    FMOV  V26.D[1], X16
    FMOV  D27, X11
    FMOV  V27.D[1], X29
    FMOV  D28, X15
    FMOV  V28.D[1], X4
    FMOV  D29, X2
    FMOV  V29.D[1], X5
    FMOV  D30, X25
    FMOV  V30.D[1], X25
    FMOV  D31, X28
    FMOV  V31.D[1], X5
    MOVZ  X10, #0xa, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_10:
    SHA1M  Q16, S30, V23.4S
    SHA256H2  Q16, Q26, V22.4S
    SHA256H  Q17, Q23, V8.4S
    SHA1C  Q5, S28, V31.4S
    SHA256H  Q5, Q20, V18.4S
    SHA256SU1  V14.4S, V29.4S, V22.4S
    SHA256H2  Q13, Q4, V14.4S
    SHA1P  Q8, S16, V6.4S
    SHA1C  Q18, S7, V9.4S
    SHA1P  Q1, S16, V8.4S
    SHA256SU0  V3.4S, V5.4S
    SHA1M  Q9, S27, V17.4S
    SHA256SU0  V27.4S, V11.4S
    SHA256H  Q17, Q27, V13.4S
    SHA1P  Q29, S9, V20.4S
    SHA1M  Q26, S1, V16.4S
    SHA1SU1  V11.4S, V26.4S
    SHA1C  Q14, S29, V19.4S
    SHA256SU1  V9.4S, V11.4S, V14.4S
    SHA256SU0  V8.4S, V7.4S
    SHA1P  Q6, S12, V17.4S
    SHA256H2  Q30, Q17, V5.4S
    SHA256H  Q15, Q30, V8.4S
    SHA256SU1  V29.4S, V11.4S, V31.4S
    SHA256H2  Q30, Q21, V29.4S
    SHA1M  Q14, S6, V6.4S
    SHA256H2  Q1, Q18, V16.4S
    SHA256H  Q26, Q30, V1.4S
    SHA1P  Q19, S15, V11.4S
    SHA1M  Q22, S11, V5.4S
    SHA1P  Q21, S1, V26.4S
    SHA256H  Q16, Q14, V9.4S
    SHA1M  Q20, S17, V10.4S
    SHA256H  Q4, Q3, V28.4S
    SHA1SU0  V18.4S, V16.4S, V20.4S
    SHA256SU0  V12.4S, V18.4S
    SHA256H2  Q6, Q12, V18.4S
    SHA1P  Q29, S20, V6.4S
    SHA1C  Q11, S20, V22.4S
    SHA1SU0  V8.4S, V29.4S, V4.4S
    SHA1P  Q9, S19, V7.4S
    SHA256SU0  V1.4S, V21.4S
    SHA1SU1  V9.4S, V11.4S
    SHA256H  Q31, Q18, V18.4S
    SHA256H  Q14, Q4, V9.4S
    SHA256SU0  V26.4S, V6.4S
    SHA256H  Q2, Q26, V11.4S
    SHA256SU0  V10.4S, V1.4S
    SHA1SU0  V17.4S, V14.4S, V24.4S
    SHA256H  Q21, Q27, V2.4S
    SHA1C  Q17, S12, V31.4S
    SHA256SU0  V9.4S, V17.4S
    SHA1SU0  V4.4S, V8.4S, V10.4S
    SHA256H2  Q18, Q16, V9.4S
    SHA1SU0  V24.4S, V7.4S, V21.4S
    SHA1SU1  V6.4S, V4.4S
    SHA1P  Q11, S24, V16.4S
    SHA1C  Q12, S16, V10.4S
    SHA1M  Q10, S11, V17.4S
    SHA1C  Q1, S12, V12.4S
    SHA1P  Q8, S6, V18.4S
    SHA256H  Q16, Q24, V10.4S
    SHA256SU0  V7.4S, V5.4S
    SHA1M  Q31, S8, V8.4S
    SHA256H  Q17, Q7, V16.4S
    SHA1SU0  V9.4S, V13.4S, V31.4S
    SHA1SU1  V8.4S, V1.4S
    SHA256SU0  V7.4S, V9.4S
    SHA256H  Q18, Q7, V2.4S
    SHA1SU1  V28.4S, V16.4S
    SHA256SU0  V21.4S, V26.4S
    SHA256H  Q24, Q22, V18.4S
    SHA256SU0  V13.4S, V24.4S
    SHA256SU1  V10.4S, V17.4S, V21.4S
    SHA256H  Q22, Q8, V10.4S
    SHA1P  Q18, S22, V22.4S
    SHA1SU1  V17.4S, V3.4S
    SHA256H  Q6, Q7, V23.4S
    SHA256SU1  V2.4S, V18.4S, V31.4S
    SHA1P  Q7, S17, V13.4S
    SHA256H2  Q1, Q28, V28.4S
    SHA1SU0  V22.4S, V3.4S, V2.4S
    SHA256SU0  V31.4S, V1.4S
    SHA256H  Q1, Q21, V13.4S
    SHA1SU0  V9.4S, V31.4S, V31.4S
    SHA1M  Q3, S1, V1.4S
    SHA1SU0  V0.4S, V26.4S, V9.4S
    SHA256H2  Q26, Q15, V7.4S
    SHA1SU1  V18.4S, V26.4S
    SHA256H2  Q17, Q31, V3.4S
    SHA256H2  Q25, Q0, V24.4S
    SHA1SU0  V9.4S, V25.4S, V7.4S
    SHA256SU0  V24.4S, V24.4S
    SHA256H  Q30, Q24, V23.4S
    SHA256SU0  V1.4S, V9.4S
    SHA256H2  Q10, Q30, V30.4S
    SHA1M  Q10, S6, V24.4S
    SHA1P  Q21, S17, V18.4S
    SHA1C  Q28, S4, V22.4S
    SHA256SU0  V4.4S, V3.4S
    SHA1M  Q21, S28, V1.4S
    SHA1C  Q10, S21, V24.4S
    SHA1M  Q3, S16, V12.4S
    SHA256H2  Q12, Q0, V25.4S
    SHA256H  Q15, Q16, V24.4S
    SHA1M  Q26, S4, V8.4S
    SHA256SU0  V7.4S, V20.4S
    SHA1SU1  V22.4S, V16.4S
    SHA1C  Q13, S22, V5.4S
    SHA256H  Q20, Q24, V14.4S
    SHA1SU0  V17.4S, V31.4S, V12.4S
    SHA1SU0  V16.4S, V5.4S, V3.4S
    SHA256SU1  V4.4S, V8.4S, V31.4S
    SHA1M  Q31, S15, V7.4S
    SHA256SU0  V6.4S, V26.4S
    SHA256H  Q21, Q6, V16.4S
    SHA1SU0  V26.4S, V13.4S, V31.4S
    SHA256SU1  V16.4S, V8.4S, V18.4S
    SHA1M  Q9, S26, V4.4S
    SHA1SU0  V28.4S, V17.4S, V17.4S
    SHA1C  Q5, S20, V20.4S
    SHA256SU0  V22.4S, V14.4S
    SHA1SU0  V13.4S, V5.4S, V28.4S
    SHA256H  Q25, Q23, V2.4S
    SHA256H  Q6, Q16, V21.4S
    SHA1SU0  V17.4S, V5.4S, V9.4S
    SHA1SU0  V12.4S, V13.4S, V13.4S
    SHA256SU0  V13.4S, V17.4S
    SHA1P  Q8, S10, V22.4S
    SHA1M  Q23, S12, V1.4S
    SHA1M  Q18, S8, V6.4S
    SHA1SU0  V31.4S, V7.4S, V25.4S
    SHA1P  Q10, S26, V27.4S
    SHA1SU0  V17.4S, V10.4S, V10.4S
    SHA1P  Q2, S17, V30.4S
    SHA256SU1  V4.4S, V24.4S, V2.4S
    SHA1SU1  V26.4S, V16.4S
    SHA256SU0  V3.4S, V26.4S
    SHA1P  Q1, S3, V23.4S
    SHA256H2  Q14, Q1, V4.4S
    SHA256H  Q8, Q14, V31.4S
    SHA256H  Q22, Q18, V8.4S
    SHA1M  Q12, S12, V17.4S
    SHA256H  Q24, Q24, V4.4S
    SHA1SU1  V4.4S, V20.4S
    SHA256SU1  V27.4S, V30.4S, V27.4S
    SHA256H2  Q26, Q16, V21.4S
    SHA256H2  Q18, Q15, V23.4S
    SHA1SU0  V13.4S, V12.4S, V21.4S
    SHA1C  Q3, S12, V30.4S
    SHA1SU1  V6.4S, V30.4S
    SHA256H  Q14, Q25, V22.4S
    SHA256SU0  V8.4S, V18.4S
    SHA256SU1  V18.4S, V11.4S, V8.4S
    SHA1SU1  V23.4S, V4.4S
    SHA256SU0  V9.4S, V14.4S
    SHA256SU1  V2.4S, V24.4S, V3.4S
    SHA256H  Q4, Q24, V23.4S
    SHA1SU0  V9.4S, V6.4S, V18.4S
    SHA256H  Q7, Q13, V1.4S
    SHA256SU0  V21.4S, V31.4S
    SHA1SU1  V10.4S, V26.4S
    SHA1P  Q14, S26, V14.4S
    SHA1M  Q22, S10, V11.4S
    SHA1C  Q15, S5, V27.4S
    SHA256H  Q25, Q15, V3.4S
    SHA256SU1  V13.4S, V7.4S, V21.4S
    SHA1SU1  V10.4S, V25.4S
    SHA256H  Q23, Q0, V22.4S
    SHA256H  Q24, Q10, V15.4S
    SHA256H2  Q18, Q18, V23.4S
    SHA256H  Q8, Q13, V13.4S
    SHA1M  Q24, S7, V25.4S
    SHA1M  Q27, S17, V10.4S
    SHA1M  Q22, S31, V19.4S
    SHA256SU0  V23.4S, V8.4S
    SHA1P  Q1, S18, V2.4S
    SHA1P  Q12, S24, V1.4S
    SHA1SU0  V6.4S, V20.4S, V12.4S
    SHA1P  Q26, S22, V13.4S
    SHA1M  Q3, S6, V26.4S
    SHA256H  Q0, Q3, V28.4S
    SHA1C  Q25, S30, V14.4S
    SHA1SU0  V10.4S, V27.4S, V9.4S
    SHA256SU1  V15.4S, V23.4S, V21.4S
    SHA256SU0  V2.4S, V9.4S
    SHA1P  Q14, S0, V20.4S
    SHA256SU0  V19.4S, V10.4S
    SHA256SU1  V30.4S, V15.4S, V15.4S
    SHA1SU0  V12.4S, V14.4S, V4.4S
    SHA1SU0  V13.4S, V12.4S, V12.4S
    SHA1C  Q31, S15, V30.4S
    SHA1M  Q22, S0, V22.4S
    SHA256SU0  V16.4S, V13.4S
    SHA256SU1  V20.4S, V7.4S, V25.4S
    SHA256SU0  V18.4S, V31.4S
    SHA1C  Q7, S18, V24.4S
    SHA1SU1  V13.4S, V7.4S
    SHA256H  Q8, Q16, V13.4S
    SHA1M  Q3, S0, V19.4S
    SUBS  X10, X10, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_10
    MOVZ  X14, #0x3c89, LSL #0
    MOVK  X14, #0xf414, LSL #16
    MOVK  X14, #0x2166, LSL #32
    MOVK  X14, #0x2dea, LSL #48
    SUB  X8, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0xf553, LSL #0
    MOVK  X14, #0x31f6, LSL #16
    MOVK  X14, #0xf0e2, LSL #32
    MOVK  X14, #0x65b2, LSL #48
    SUB  X8, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0x4a1, LSL #0
    MOVK  X14, #0x99f2, LSL #16
    MOVK  X14, #0x465d, LSL #32
    MOVK  X14, #0x7ec6, LSL #48
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0x471f, LSL #0
    MOVK  X14, #0x885c, LSL #16
    MOVK  X14, #0xdc5f, LSL #32
    MOVK  X14, #0x18a5, LSL #48
    SUB  X8, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0xf242, LSL #0
    MOVK  X14, #0xe9d8, LSL #16
    MOVK  X14, #0x3a13, LSL #32
    MOVK  X14, #0xdc3c, LSL #48
    SUB  X8, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0x81f8, LSL #0
    MOVK  X14, #0xe3a7, LSL #16
    MOVK  X14, #0x9632, LSL #32
    MOVK  X14, #0x3a63, LSL #48
    SUB  X8, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0x29f3, LSL #0
    MOVK  X14, #0x3b86, LSL #16
    MOVK  X14, #0x8d1, LSL #32
    MOVK  X14, #0x7422, LSL #48
    SUB  X8, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0x6867, LSL #0
    MOVK  X14, #0x29ad, LSL #16
    MOVK  X14, #0xa5c6, LSL #32
    MOVK  X14, #0xca22, LSL #48
    SUB  X8, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0x8ca2, LSL #0
    MOVK  X14, #0x6e1e, LSL #16
    MOVK  X14, #0xfe1, LSL #32
    MOVK  X14, #0xd960, LSL #48
    SUB  X8, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0xe4a7, LSL #0
    MOVK  X14, #0xb5d7, LSL #16
    MOVK  X14, #0x20b2, LSL #32
    MOVK  X14, #0x66ba, LSL #48
    SUB  X8, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0x8136, LSL #0
    MOVK  X14, #0x604, LSL #16
    MOVK  X14, #0xff99, LSL #32
    MOVK  X14, #0x87c5, LSL #48
    SUB  X8, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0x83aa, LSL #0
    MOVK  X14, #0x1023, LSL #16
    MOVK  X14, #0x1d21, LSL #32
    MOVK  X14, #0x3428, LSL #48
    SUB  X8, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0x5bf, LSL #0
    MOVK  X14, #0x9934, LSL #16
    MOVK  X14, #0x67a7, LSL #32
    MOVK  X14, #0x80b2, LSL #48
    SUB  X8, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0x505f, LSL #0
    MOVK  X14, #0x574c, LSL #16
    MOVK  X14, #0xd84d, LSL #32
    MOVK  X14, #0xd6ca, LSL #48
    SUB  X8, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0xff9, LSL #0
    MOVK  X14, #0x254d, LSL #16
    MOVK  X14, #0x46ba, LSL #32
    MOVK  X14, #0xa4bc, LSL #48
    SUB  X8, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0xc2a8, LSL #0
    MOVK  X14, #0x2f07, LSL #16
    MOVK  X14, #0x47e9, LSL #32
    MOVK  X14, #0x7014, LSL #48
    SUB  X8, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0xcf31, LSL #0
    MOVK  X14, #0xfc61, LSL #16
    MOVK  X14, #0x8a5d, LSL #32
    MOVK  X14, #0x340c, LSL #48
    SUB  X8, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0x4ac9, LSL #0
    MOVK  X14, #0xe334, LSL #16
    MOVK  X14, #0x7bcf, LSL #32
    MOVK  X14, #0x47f0, LSL #48
    SUB  X8, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X14, #0x8ace, LSL #0
    MOVK  X14, #0x42a5, LSL #16
    MOVK  X14, #0x73a, LSL #32
    MOVK  X14, #0xfd6, LSL #48
    SUB  X8, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MRS  X14, FPSR
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V0.D[1]
    MOVZ  X8, #0x93b0, LSL #0
    MOVK  X8, #0x1e1f, LSL #16
    MOVK  X8, #0xe920, LSL #32
    MOVK  X8, #0xccab, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D0
    MOVZ  X8, #0x934d, LSL #0
    MOVK  X8, #0xda5b, LSL #16
    MOVK  X8, #0xdef5, LSL #32
    MOVK  X8, #0x69ed, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V1.D[1]
    MOVZ  X8, #0xf4e9, LSL #0
    MOVK  X8, #0xa738, LSL #16
    MOVK  X8, #0xe23f, LSL #32
    MOVK  X8, #0xae60, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D1
    MOVZ  X8, #0x99e7, LSL #0
    MOVK  X8, #0x281a, LSL #16
    MOVK  X8, #0xc9e4, LSL #32
    MOVK  X8, #0x508a, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X8, #0x2cb1, LSL #0
    MOVK  X8, #0xb15d, LSL #16
    MOVK  X8, #0xa2e0, LSL #32
    MOVK  X8, #0x6bf3, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D2
    MOVZ  X8, #0x394f, LSL #0
    MOVK  X8, #0xce2a, LSL #16
    MOVK  X8, #0xacbe, LSL #32
    MOVK  X8, #0x548c, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X8, #0x844a, LSL #0
    MOVK  X8, #0xbdf1, LSL #16
    MOVK  X8, #0xa668, LSL #32
    MOVK  X8, #0x9a3b, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D3
    MOVZ  X8, #0x30df, LSL #0
    MOVK  X8, #0x7c33, LSL #16
    MOVK  X8, #0xf7c5, LSL #32
    MOVK  X8, #0x38b, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X8, #0x762e, LSL #0
    MOVK  X8, #0x7b32, LSL #16
    MOVK  X8, #0xd432, LSL #32
    MOVK  X8, #0x6ec1, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D4
    MOVZ  X8, #0x983, LSL #0
    MOVK  X8, #0x157f, LSL #16
    MOVK  X8, #0x7c32, LSL #32
    MOVK  X8, #0xa2ed, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X8, #0x3681, LSL #0
    MOVK  X8, #0x4805, LSL #16
    MOVK  X8, #0xdd0a, LSL #32
    MOVK  X8, #0xa61d, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D5
    MOVZ  X8, #0x6705, LSL #0
    MOVK  X8, #0xef5c, LSL #16
    MOVK  X8, #0xa2af, LSL #32
    MOVK  X8, #0xcd35, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X8, #0x2e23, LSL #0
    MOVK  X8, #0x4323, LSL #16
    MOVK  X8, #0x646, LSL #32
    MOVK  X8, #0x3000, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D6
    MOVZ  X8, #0x97b8, LSL #0
    MOVK  X8, #0xff0a, LSL #16
    MOVK  X8, #0x67ac, LSL #32
    MOVK  X8, #0x672, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X8, #0x31c2, LSL #0
    MOVK  X8, #0x76f1, LSL #16
    MOVK  X8, #0xdc56, LSL #32
    MOVK  X8, #0xa852, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D7
    MOVZ  X8, #0x4ce6, LSL #0
    MOVK  X8, #0xe903, LSL #16
    MOVK  X8, #0xefc6, LSL #32
    MOVK  X8, #0xe13a, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X8, #0x1125, LSL #0
    MOVK  X8, #0xa796, LSL #16
    MOVK  X8, #0xf593, LSL #32
    MOVK  X8, #0xfac, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D8
    MOVZ  X8, #0x6337, LSL #0
    MOVK  X8, #0x47b7, LSL #16
    MOVK  X8, #0x7f19, LSL #32
    MOVK  X8, #0xa14c, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X8, #0xef16, LSL #0
    MOVK  X8, #0xcc66, LSL #16
    MOVK  X8, #0x6abe, LSL #32
    MOVK  X8, #0xb8c8, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D9
    MOVZ  X8, #0xcd49, LSL #0
    MOVK  X8, #0x87f2, LSL #16
    MOVK  X8, #0x26d5, LSL #32
    MOVK  X8, #0x64dc, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X8, #0xaf0f, LSL #0
    MOVK  X8, #0x16af, LSL #16
    MOVK  X8, #0xf992, LSL #32
    MOVK  X8, #0x6d7d, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D10
    MOVZ  X8, #0x3a65, LSL #0
    MOVK  X8, #0xa8c7, LSL #16
    MOVK  X8, #0x8804, LSL #32
    MOVK  X8, #0xd8c5, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X8, #0x905c, LSL #0
    MOVK  X8, #0x70ab, LSL #16
    MOVK  X8, #0x5924, LSL #32
    MOVK  X8, #0xb63, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D11
    MOVZ  X8, #0xf9c4, LSL #0
    MOVK  X8, #0x21da, LSL #16
    MOVK  X8, #0x9139, LSL #32
    MOVK  X8, #0xb6db, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X8, #0x2493, LSL #0
    MOVK  X8, #0xd97e, LSL #16
    MOVK  X8, #0xdc70, LSL #32
    MOVK  X8, #0x8dae, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D12
    MOVZ  X8, #0x9346, LSL #0
    MOVK  X8, #0xc086, LSL #16
    MOVK  X8, #0x9cf9, LSL #32
    MOVK  X8, #0x6f0c, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X8, #0xf09b, LSL #0
    MOVK  X8, #0x5c8f, LSL #16
    MOVK  X8, #0x4461, LSL #32
    MOVK  X8, #0x8159, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D13
    MOVZ  X8, #0x7f3, LSL #0
    MOVK  X8, #0x7cc9, LSL #16
    MOVK  X8, #0x8435, LSL #32
    MOVK  X8, #0xb0c8, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V14.D[1]
    MOVZ  X8, #0x821f, LSL #0
    MOVK  X8, #0xbe45, LSL #16
    MOVK  X8, #0xe383, LSL #32
    MOVK  X8, #0x3dd4, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D14
    MOVZ  X8, #0xfa1d, LSL #0
    MOVK  X8, #0xc4ec, LSL #16
    MOVK  X8, #0x79aa, LSL #32
    MOVK  X8, #0x6e53, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X8, #0xe8bc, LSL #0
    MOVK  X8, #0x9d79, LSL #16
    MOVK  X8, #0x505c, LSL #32
    MOVK  X8, #0x740d, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D15
    MOVZ  X8, #0x915b, LSL #0
    MOVK  X8, #0x7e22, LSL #16
    MOVK  X8, #0x3d8, LSL #32
    MOVK  X8, #0x75b8, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X8, #0xcf60, LSL #0
    MOVK  X8, #0xb4c3, LSL #16
    MOVK  X8, #0x6ae7, LSL #32
    MOVK  X8, #0x4030, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D16
    MOVZ  X8, #0x4802, LSL #0
    MOVK  X8, #0x34ca, LSL #16
    MOVK  X8, #0x6ce7, LSL #32
    MOVK  X8, #0xc333, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X8, #0x4dcc, LSL #0
    MOVK  X8, #0x1c87, LSL #16
    MOVK  X8, #0x9e9c, LSL #32
    MOVK  X8, #0x9672, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D17
    MOVZ  X8, #0xc068, LSL #0
    MOVK  X8, #0x22bf, LSL #16
    MOVK  X8, #0x3b02, LSL #32
    MOVK  X8, #0xce5a, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X8, #0xff47, LSL #0
    MOVK  X8, #0x8999, LSL #16
    MOVK  X8, #0x49ff, LSL #32
    MOVK  X8, #0x3703, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D18
    MOVZ  X8, #0xbec2, LSL #0
    MOVK  X8, #0xe119, LSL #16
    MOVK  X8, #0xa8bb, LSL #32
    MOVK  X8, #0x6245, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X8, #0x75c3, LSL #0
    MOVK  X8, #0x2eed, LSL #16
    MOVK  X8, #0xcd16, LSL #32
    MOVK  X8, #0x3f41, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D19
    MOVZ  X8, #0x625e, LSL #0
    MOVK  X8, #0x141b, LSL #16
    MOVK  X8, #0xc7e9, LSL #32
    MOVK  X8, #0x9d25, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X8, #0x1d1c, LSL #0
    MOVK  X8, #0xfc97, LSL #16
    MOVK  X8, #0x70ba, LSL #32
    MOVK  X8, #0xf73f, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D20
    MOVZ  X8, #0x227, LSL #0
    MOVK  X8, #0x1979, LSL #16
    MOVK  X8, #0xe7ac, LSL #32
    MOVK  X8, #0xc1fe, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X8, #0x8af7, LSL #0
    MOVK  X8, #0xa560, LSL #16
    MOVK  X8, #0x7a84, LSL #32
    MOVK  X8, #0x7e97, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D21
    MOVZ  X8, #0x2d14, LSL #0
    MOVK  X8, #0xc38f, LSL #16
    MOVK  X8, #0xb4ed, LSL #32
    MOVK  X8, #0x5459, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X8, #0x85ab, LSL #0
    MOVK  X8, #0xf1d0, LSL #16
    MOVK  X8, #0x57c, LSL #32
    MOVK  X8, #0x5d52, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D22
    MOVZ  X8, #0x2de2, LSL #0
    MOVK  X8, #0x9bca, LSL #16
    MOVK  X8, #0x950f, LSL #32
    MOVK  X8, #0x8809, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X8, #0xa5ed, LSL #0
    MOVK  X8, #0xdfb, LSL #16
    MOVK  X8, #0x4b52, LSL #32
    MOVK  X8, #0xd070, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D23
    MOVZ  X8, #0x6b0c, LSL #0
    MOVK  X8, #0x2647, LSL #16
    MOVK  X8, #0xe219, LSL #32
    MOVK  X8, #0x80db, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X8, #0xc544, LSL #0
    MOVK  X8, #0x9f49, LSL #16
    MOVK  X8, #0x9ff6, LSL #32
    MOVK  X8, #0xc19d, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D24
    MOVZ  X8, #0xe137, LSL #0
    MOVK  X8, #0x46bc, LSL #16
    MOVK  X8, #0xdc5e, LSL #32
    MOVK  X8, #0xd562, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X8, #0x3213, LSL #0
    MOVK  X8, #0x4e9f, LSL #16
    MOVK  X8, #0x64fd, LSL #32
    MOVK  X8, #0xaf9b, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D25
    MOVZ  X8, #0x4b76, LSL #0
    MOVK  X8, #0x4776, LSL #16
    MOVK  X8, #0x8f74, LSL #32
    MOVK  X8, #0x2417, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X8, #0x30d, LSL #0
    MOVK  X8, #0x25be, LSL #16
    MOVK  X8, #0x5f14, LSL #32
    MOVK  X8, #0xf8ed, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D26
    MOVZ  X8, #0x6cfc, LSL #0
    MOVK  X8, #0xbf98, LSL #16
    MOVK  X8, #0x6a7f, LSL #32
    MOVK  X8, #0x8529, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X8, #0x674, LSL #0
    MOVK  X8, #0xfb7b, LSL #16
    MOVK  X8, #0xe189, LSL #32
    MOVK  X8, #0x3bfe, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D27
    MOVZ  X8, #0xf008, LSL #0
    MOVK  X8, #0x6f28, LSL #16
    MOVK  X8, #0x1e2, LSL #32
    MOVK  X8, #0x3b0e, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X8, #0xaaef, LSL #0
    MOVK  X8, #0x11f4, LSL #16
    MOVK  X8, #0x2140, LSL #32
    MOVK  X8, #0xb6d3, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D28
    MOVZ  X8, #0x399f, LSL #0
    MOVK  X8, #0x911, LSL #16
    MOVK  X8, #0x8fb8, LSL #32
    MOVK  X8, #0xe30e, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X8, #0x98e8, LSL #0
    MOVK  X8, #0x63eb, LSL #16
    MOVK  X8, #0xe34c, LSL #32
    MOVK  X8, #0x3693, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D29
    MOVZ  X8, #0xa73d, LSL #0
    MOVK  X8, #0xe0a6, LSL #16
    MOVK  X8, #0xe905, LSL #32
    MOVK  X8, #0x23f, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V30.D[1]
    MOVZ  X8, #0xda91, LSL #0
    MOVK  X8, #0x1a8, LSL #16
    MOVK  X8, #0x24db, LSL #32
    MOVK  X8, #0xf33c, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D30
    MOVZ  X8, #0x52dc, LSL #0
    MOVK  X8, #0x6e06, LSL #16
    MOVK  X8, #0xc100, LSL #32
    MOVK  X8, #0x990a, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, V31.D[1]
    MOVZ  X8, #0x9b6c, LSL #0
    MOVK  X8, #0x6d2a, LSL #16
    MOVK  X8, #0xf7c9, LSL #32
    MOVK  X8, #0xd723, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X14, D31
    MOVZ  X8, #0x27cc, LSL #0
    MOVK  X8, #0x9856, LSL #16
    MOVK  X8, #0x534a, LSL #32
    MOVK  X8, #0xec3b, LSL #48
    SUB  X29, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
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
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X10
    FMOV  V0.D[1], X25
    FMOV  D1, X14
    FMOV  V1.D[1], X17
    FMOV  D2, X11
    FMOV  V2.D[1], X27
    FMOV  D3, X15
    FMOV  V3.D[1], X16
    FMOV  D4, X29
    FMOV  V4.D[1], X16
    FMOV  D5, X23
    FMOV  V5.D[1], X28
    FMOV  D6, X3
    FMOV  V6.D[1], X8
    FMOV  D7, X14
    FMOV  V7.D[1], X26
    FMOV  D8, X16
    FMOV  V8.D[1], X9
    FMOV  D9, X17
    FMOV  V9.D[1], X14
    FMOV  D10, X6
    FMOV  V10.D[1], X4
    FMOV  D11, X17
    FMOV  V11.D[1], X9
    FMOV  D12, X10
    FMOV  V12.D[1], X4
    FMOV  D13, X7
    FMOV  V13.D[1], X13
    FMOV  D14, X23
    FMOV  V14.D[1], X28
    FMOV  D15, X5
    FMOV  V15.D[1], X6
    FMOV  D16, X3
    FMOV  V16.D[1], X17
    FMOV  D17, X24
    FMOV  V17.D[1], X2
    FMOV  D18, X7
    FMOV  V18.D[1], X6
    FMOV  D19, X7
    FMOV  V19.D[1], X4
    FMOV  D20, X12
    FMOV  V20.D[1], X6
    FMOV  D21, X26
    FMOV  V21.D[1], X9
    FMOV  D22, X8
    FMOV  V22.D[1], X23
    FMOV  D23, X8
    FMOV  V23.D[1], X16
    FMOV  D24, X23
    FMOV  V24.D[1], X23
    FMOV  D25, X9
    FMOV  V25.D[1], X8
    FMOV  D26, X17
    FMOV  V26.D[1], X25
    FMOV  D27, X11
    FMOV  V27.D[1], X11
    FMOV  D28, X5
    FMOV  V28.D[1], X5
    FMOV  D29, X4
    FMOV  V29.D[1], X23
    FMOV  D30, X4
    FMOV  V30.D[1], X24
    FMOV  D31, X11
    FMOV  V31.D[1], X25
    MOVZ  X26, #0xa, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_11:
    SHA256H  Q26, Q23, V22.4S
    SHA1P  Q10, S27, V27.4S
    SHA256SU0  V6.4S, V26.4S
    SHA1M  Q0, S29, V25.4S
    SHA256SU0  V5.4S, V24.4S
    SHA256H2  Q14, Q10, V31.4S
    SHA1SU0  V10.4S, V19.4S, V19.4S
    SHA1P  Q0, S21, V30.4S
    SHA1M  Q24, S5, V5.4S
    SHA256SU1  V29.4S, V28.4S, V10.4S
    SHA1M  Q5, S4, V10.4S
    SHA1C  Q16, S21, V14.4S
    SHA1C  Q18, S16, V16.4S
    SHA1SU1  V27.4S, V6.4S
    SHA1SU0  V11.4S, V27.4S, V27.4S
    SHA1SU1  V31.4S, V16.4S
    SHA1SU0  V26.4S, V24.4S, V26.4S
    SHA1SU1  V21.4S, V4.4S
    SHA1M  Q24, S14, V21.4S
    SHA1SU1  V27.4S, V24.4S
    SHA1M  Q23, S11, V1.4S
    SHA1SU1  V24.4S, V16.4S
    SHA256H  Q21, Q2, V18.4S
    SHA256H2  Q4, Q3, V24.4S
    SHA1P  Q22, S0, V23.4S
    SHA256H2  Q14, Q29, V23.4S
    SHA1SU1  V7.4S, V23.4S
    SHA256SU1  V20.4S, V22.4S, V5.4S
    SHA1SU0  V0.4S, V7.4S, V18.4S
    SHA1P  Q24, S0, V30.4S
    SHA256H  Q30, Q6, V21.4S
    SHA256H  Q25, Q31, V14.4S
    SHA256H2  Q18, Q28, V27.4S
    SHA1SU0  V23.4S, V18.4S, V30.4S
    SHA256SU1  V10.4S, V6.4S, V22.4S
    SHA1P  Q27, S14, V14.4S
    SHA256H  Q29, Q4, V4.4S
    SHA1P  Q1, S23, V24.4S
    SHA256H2  Q6, Q1, V25.4S
    SHA256H2  Q26, Q10, V26.4S
    SHA1M  Q24, S20, V25.4S
    SHA1C  Q5, S14, V26.4S
    SHA1SU1  V11.4S, V6.4S
    SHA256H2  Q19, Q24, V6.4S
    SHA1M  Q7, S29, V6.4S
    SHA1SU1  V4.4S, V29.4S
    SHA1M  Q6, S6, V29.4S
    SHA256SU1  V24.4S, V4.4S, V0.4S
    SHA256SU1  V16.4S, V6.4S, V27.4S
    SHA256SU1  V26.4S, V17.4S, V16.4S
    SHA256SU0  V4.4S, V11.4S
    SHA1M  Q17, S19, V0.4S
    SHA1P  Q22, S24, V4.4S
    SHA1SU0  V24.4S, V17.4S, V7.4S
    SHA256H2  Q18, Q24, V23.4S
    SHA256SU1  V19.4S, V26.4S, V28.4S
    SHA1SU1  V24.4S, V18.4S
    SHA1M  Q29, S22, V5.4S
    SHA1C  Q27, S24, V30.4S
    SHA1SU1  V0.4S, V29.4S
    SHA1M  Q16, S27, V16.4S
    SHA1C  Q5, S4, V0.4S
    SHA256SU0  V17.4S, V18.4S
    SHA1SU1  V29.4S, V5.4S
    SHA1SU1  V27.4S, V17.4S
    SHA256SU0  V24.4S, V12.4S
    SHA256H  Q7, Q27, V29.4S
    SHA256H  Q4, Q7, V3.4S
    SHA1P  Q12, S24, V22.4S
    SHA256H2  Q23, Q12, V4.4S
    SHA1C  Q29, S19, V9.4S
    SHA1P  Q5, S15, V23.4S
    SHA256SU0  V3.4S, V11.4S
    SHA256SU0  V24.4S, V16.4S
    SHA1SU0  V27.4S, V29.4S, V3.4S
    SHA256H  Q19, Q21, V13.4S
    SHA1P  Q23, S11, V19.4S
    SHA256H2  Q9, Q25, V27.4S
    SHA1P  Q15, S5, V27.4S
    SHA256H2  Q8, Q24, V14.4S
    SHA256H2  Q26, Q9, V9.4S
    SHA256SU1  V29.4S, V18.4S, V26.4S
    SHA256H  Q7, Q21, V29.4S
    SHA1M  Q9, S24, V7.4S
    SHA256H2  Q4, Q24, V23.4S
    SHA256H  Q9, Q9, V25.4S
    SHA1SU0  V26.4S, V22.4S, V8.4S
    SHA256SU0  V18.4S, V9.4S
    SHA256SU1  V12.4S, V8.4S, V26.4S
    SHA1P  Q14, S16, V18.4S
    SHA256H2  Q16, Q14, V16.4S
    SHA256SU1  V24.4S, V10.4S, V26.4S
    SHA256H  Q3, Q16, V15.4S
    SHA256H  Q7, Q12, V4.4S
    SHA1M  Q18, S21, V30.4S
    SHA1SU0  V10.4S, V24.4S, V3.4S
    SHA1SU0  V5.4S, V7.4S, V14.4S
    SHA1P  Q15, S30, V18.4S
    SHA1SU1  V24.4S, V10.4S
    SHA1P  Q10, S22, V12.4S
    SHA256SU0  V11.4S, V17.4S
    SHA1SU0  V26.4S, V5.4S, V20.4S
    SHA256SU1  V5.4S, V26.4S, V19.4S
    SHA256H2  Q25, Q11, V11.4S
    SHA256H  Q9, Q5, V28.4S
    SHA1P  Q18, S10, V9.4S
    SHA1SU1  V11.4S, V24.4S
    SHA256H2  Q28, Q25, V22.4S
    SHA256SU0  V16.4S, V19.4S
    SHA1SU1  V19.4S, V15.4S
    SHA1M  Q25, S16, V19.4S
    SHA256SU1  V4.4S, V16.4S, V18.4S
    SHA1P  Q20, S11, V25.4S
    SHA256H  Q8, Q28, V4.4S
    SHA1SU0  V16.4S, V5.4S, V2.4S
    SHA1C  Q18, S19, V1.4S
    SHA1SU0  V12.4S, V17.4S, V8.4S
    SHA1C  Q18, S14, V17.4S
    SHA256SU0  V17.4S, V0.4S
    SHA1SU1  V28.4S, V4.4S
    SHA1C  Q22, S4, V5.4S
    SHA256SU1  V22.4S, V24.4S, V21.4S
    SHA256SU0  V2.4S, V6.4S
    SHA1SU1  V10.4S, V3.4S
    SHA1M  Q6, S18, V16.4S
    SHA256SU0  V4.4S, V6.4S
    SHA1SU0  V11.4S, V10.4S, V4.4S
    SHA256SU0  V1.4S, V28.4S
    SHA256SU0  V15.4S, V23.4S
    SHA256H  Q9, Q11, V11.4S
    SHA1SU1  V14.4S, V18.4S
    SHA1P  Q8, S22, V22.4S
    SHA1SU1  V10.4S, V14.4S
    SHA1M  Q24, S17, V2.4S
    SHA256SU1  V9.4S, V15.4S, V15.4S
    SHA1P  Q12, S10, V24.4S
    SHA1P  Q21, S9, V30.4S
    SHA1SU1  V25.4S, V21.4S
    SHA256SU0  V14.4S, V8.4S
    SHA1M  Q2, S29, V25.4S
    SHA1P  Q28, S12, V22.4S
    SHA1C  Q12, S1, V28.4S
    SHA1C  Q18, S20, V2.4S
    SHA256SU1  V30.4S, V14.4S, V14.4S
    SHA256H  Q6, Q6, V27.4S
    SHA1SU0  V3.4S, V4.4S, V3.4S
    SHA256SU0  V23.4S, V3.4S
    SHA256H  Q25, Q20, V25.4S
    SHA1M  Q9, S25, V29.4S
    SHA1SU0  V29.4S, V6.4S, V16.4S
    SHA1C  Q25, S12, V30.4S
    SHA1SU1  V16.4S, V30.4S
    SHA1M  Q14, S23, V1.4S
    SHA256H2  Q21, Q18, V28.4S
    SHA1P  Q2, S28, V21.4S
    SHA256SU1  V23.4S, V25.4S, V14.4S
    SHA256SU0  V1.4S, V17.4S
    SHA1SU1  V12.4S, V2.4S
    SHA1M  Q29, S1, V20.4S
    SHA1M  Q14, S22, V9.4S
    SHA1M  Q25, S23, V14.4S
    SHA1SU1  V27.4S, V12.4S
    SHA1SU0  V15.4S, V1.4S, V16.4S
    SHA1SU1  V9.4S, V29.4S
    SHA256H2  Q2, Q15, V27.4S
    SHA256H2  Q18, Q25, V10.4S
    SHA256SU0  V10.4S, V9.4S
    SHA1SU1  V6.4S, V18.4S
    SHA1C  Q15, S19, V11.4S
    SHA1M  Q20, S30, V16.4S
    SHA256H2  Q30, Q22, V17.4S
    SHA1M  Q4, S20, V15.4S
    SHA1SU0  V18.4S, V4.4S, V4.4S
    SHA1M  Q20, S2, V20.4S
    SHA256H2  Q1, Q30, V20.4S
    SHA1C  Q14, S18, V10.4S
    SHA256H  Q30, Q1, V9.4S
    SHA1SU1  V20.4S, V6.4S
    SHA256H2  Q12, Q5, V2.4S
    SHA1P  Q11, S12, V0.4S
    SHA256SU1  V27.4S, V14.4S, V28.4S
    SHA1SU0  V20.4S, V7.4S, V11.4S
    SHA1M  Q10, S13, V15.4S
    SHA256H2  Q19, Q23, V21.4S
    SHA256H  Q13, Q9, V20.4S
    SHA1SU1  V16.4S, V20.4S
    SHA1P  Q4, S10, V13.4S
    SHA1C  Q9, S30, V31.4S
    SHA256H2  Q23, Q13, V4.4S
    SHA1SU0  V22.4S, V19.4S, V31.4S
    SHA1SU1  V18.4S, V9.4S
    SHA1M  Q11, S22, V18.4S
    SHA256H2  Q21, Q7, V27.4S
    SHA1SU1  V28.4S, V21.4S
    SHA256H2  Q31, Q23, V14.4S
    SHA256SU0  V30.4S, V16.4S
    SHA256SU0  V9.4S, V30.4S
    SHA1SU0  V15.4S, V31.4S, V11.4S
    SHA1P  Q31, S24, V28.4S
    SHA1C  Q2, S26, V15.4S
    SUBS  X26, X26, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_11
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MRS  X7, FPSR
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V0.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D0
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V1.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D1
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V2.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D2
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D3
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D4
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D5
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D6
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V7.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D7
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D8
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D9
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D10
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D11
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D12
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D13
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D14
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D15
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V16.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D16
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V17.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D17
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V18.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D18
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D19
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D20
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D21
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V22.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D22
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V23.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D23
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V24.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D24
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D25
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V26.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D26
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D27
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D28
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D29
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V30.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D30
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, V31.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X7, D31
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
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
    FMOV  V0.D[1], X29
    FMOV  D1, X14
    FMOV  V1.D[1], X2
    FMOV  D2, X27
    FMOV  V2.D[1], X28
    FMOV  D3, X26
    FMOV  V3.D[1], X29
    FMOV  D4, X9
    FMOV  V4.D[1], X27
    FMOV  D5, X27
    FMOV  V5.D[1], X3
    FMOV  D6, X28
    FMOV  V6.D[1], X15
    FMOV  D7, X4
    FMOV  V7.D[1], X10
    FMOV  D8, X10
    FMOV  V8.D[1], X8
    FMOV  D9, X4
    FMOV  V9.D[1], X9
    FMOV  D10, X9
    FMOV  V10.D[1], X5
    FMOV  D11, X29
    FMOV  V11.D[1], X8
    FMOV  D12, X12
    FMOV  V12.D[1], X24
    FMOV  D13, X5
    FMOV  V13.D[1], X9
    FMOV  D14, X26
    FMOV  V14.D[1], X13
    FMOV  D15, X29
    FMOV  V15.D[1], X10
    FMOV  D16, X25
    FMOV  V16.D[1], X7
    FMOV  D17, X11
    FMOV  V17.D[1], X13
    FMOV  D18, X24
    FMOV  V18.D[1], X13
    FMOV  D19, X17
    FMOV  V19.D[1], X16
    FMOV  D20, X7
    FMOV  V20.D[1], X3
    FMOV  D21, X7
    FMOV  V21.D[1], X16
    FMOV  D22, X9
    FMOV  V22.D[1], X24
    FMOV  D23, X27
    FMOV  V23.D[1], X16
    FMOV  D24, X13
    FMOV  V24.D[1], X17
    FMOV  D25, X2
    FMOV  V25.D[1], X24
    FMOV  D26, X5
    FMOV  V26.D[1], X4
    FMOV  D27, X17
    FMOV  V27.D[1], X13
    FMOV  D28, X10
    FMOV  V28.D[1], X28
    FMOV  D29, X11
    FMOV  V29.D[1], X5
    FMOV  D30, X9
    FMOV  V30.D[1], X10
    FMOV  D31, X28
    FMOV  V31.D[1], X16
    MOVZ  X25, #0xa, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_12:
    SHA1M  Q14, S24, V26.4S
    SHA256SU0  V18.4S, V29.4S
    SHA1SU1  V24.4S, V14.4S
    SHA1SU1  V29.4S, V27.4S
    SHA256SU1  V26.4S, V29.4S, V25.4S
    SHA256SU0  V29.4S, V28.4S
    SHA256SU0  V5.4S, V18.4S
    SHA1C  Q28, S2, V21.4S
    SHA1P  Q22, S28, V14.4S
    SHA256SU0  V21.4S, V22.4S
    SHA1M  Q5, S3, V5.4S
    SHA256SU1  V11.4S, V5.4S, V23.4S
    SHA1SU0  V10.4S, V30.4S, V26.4S
    SHA256SU0  V10.4S, V11.4S
    SHA1C  Q18, S28, V21.4S
    SHA1SU1  V2.4S, V30.4S
    SHA256H  Q30, Q24, V23.4S
    SHA256H  Q22, Q18, V29.4S
    SHA256SU1  V21.4S, V12.4S, V2.4S
    SHA256H2  Q5, Q15, V29.4S
    SHA1M  Q15, S10, V26.4S
    SHA1C  Q0, S13, V22.4S
    SHA256H  Q26, Q5, V15.4S
    SHA1M  Q25, S26, V21.4S
    SHA1P  Q23, S25, V30.4S
    SHA256H2  Q21, Q23, V10.4S
    SHA256SU1  V25.4S, V0.4S, V0.4S
    SHA1SU1  V0.4S, V21.4S
    SHA1SU0  V18.4S, V0.4S, V25.4S
    SHA1SU0  V0.4S, V28.4S, V29.4S
    SHA256SU0  V5.4S, V18.4S
    SHA1C  Q18, S28, V29.4S
    SHA256H  Q14, Q2, V19.4S
    SHA256SU0  V15.4S, V11.4S
    SHA256H2  Q23, Q27, V17.4S
    SHA1SU1  V11.4S, V17.4S
    SHA1M  Q12, S26, V29.4S
    SHA256H2  Q21, Q23, V5.4S
    SHA1SU1  V3.4S, V25.4S
    SHA1SU1  V27.4S, V7.4S
    SHA1C  Q17, S11, V8.4S
    SHA1SU0  V9.4S, V10.4S, V27.4S
    SHA1SU0  V10.4S, V12.4S, V0.4S
    SHA256H2  Q29, Q17, V10.4S
    SHA256H2  Q31, Q9, V14.4S
    SHA1M  Q2, S7, V29.4S
    SHA256H2  Q19, Q25, V12.4S
    SHA1SU1  V27.4S, V3.4S
    SHA256SU1  V28.4S, V21.4S, V15.4S
    SHA1M  Q7, S2, V18.4S
    SHA1SU0  V21.4S, V4.4S, V7.4S
    SHA1M  Q30, S22, V10.4S
    SHA1C  Q25, S21, V1.4S
    SHA1C  Q31, S6, V20.4S
    SHA1SU1  V26.4S, V28.4S
    SHA1M  Q21, S26, V30.4S
    SHA1SU1  V20.4S, V25.4S
    SHA1SU1  V9.4S, V22.4S
    SHA256SU0  V1.4S, V19.4S
    SHA1SU0  V8.4S, V9.4S, V20.4S
    SHA1C  Q17, S21, V8.4S
    SHA1SU1  V12.4S, V29.4S
    SHA256SU0  V21.4S, V31.4S
    SHA1M  Q19, S12, V28.4S
    SHA1M  Q13, S26, V27.4S
    SHA256H2  Q18, Q3, V19.4S
    SHA256SU0  V30.4S, V1.4S
    SHA1SU0  V10.4S, V10.4S, V29.4S
    SHA1SU1  V26.4S, V13.4S
    SHA256H  Q10, Q17, V17.4S
    SHA256H  Q0, Q10, V18.4S
    SHA256SU1  V9.4S, V9.4S, V26.4S
    SHA1SU1  V15.4S, V0.4S
    SHA1M  Q13, S30, V16.4S
    SHA1C  Q0, S13, V13.4S
    SHA1M  Q26, S9, V21.4S
    SHA256SU0  V7.4S, V19.4S
    SHA256SU0  V22.4S, V26.4S
    SHA256SU0  V13.4S, V22.4S
    SHA256H  Q16, Q0, V0.4S
    SHA1P  Q26, S13, V9.4S
    SHA256H  Q27, Q7, V31.4S
    SHA1SU0  V26.4S, V16.4S, V26.4S
    SHA1P  Q18, S7, V26.4S
    SHA256SU0  V23.4S, V10.4S
    SHA256H2  Q31, Q15, V3.4S
    SHA256SU0  V30.4S, V27.4S
    SHA256H2  Q13, Q11, V30.4S
    SHA256SU0  V18.4S, V0.4S
    SHA256H2  Q15, Q31, V23.4S
    SHA256SU0  V9.4S, V16.4S
    SHA1SU1  V11.4S, V29.4S
    SHA256SU1  V22.4S, V18.4S, V0.4S
    SHA1M  Q31, S12, V9.4S
    SHA256SU1  V6.4S, V6.4S, V13.4S
    SHA256SU0  V26.4S, V11.4S
    SHA1C  Q23, S8, V6.4S
    SHA1SU0  V19.4S, V25.4S, V31.4S
    SHA256H  Q12, Q19, V25.4S
    SHA1SU1  V7.4S, V15.4S
    SHA256SU1  V13.4S, V23.4S, V7.4S
    SHA256SU1  V3.4S, V13.4S, V12.4S
    SHA1SU1  V11.4S, V15.4S
    SHA256H  Q9, Q10, V1.4S
    SHA1C  Q29, S3, V8.4S
    SHA1SU1  V12.4S, V4.4S
    SHA256H2  Q23, Q19, V9.4S
    SHA1P  Q15, S25, V22.4S
    SHA256H  Q6, Q11, V15.4S
    SHA1M  Q22, S26, V19.4S
    SHA256SU1  V23.4S, V13.4S, V29.4S
    SHA1SU0  V10.4S, V6.4S, V23.4S
    SHA1M  Q21, S10, V22.4S
    SHA1SU1  V4.4S, V20.4S
    SHA256SU1  V31.4S, V13.4S, V6.4S
    SHA256H  Q15, Q13, V4.4S
    SHA256H2  Q13, Q12, V16.4S
    SHA1SU1  V11.4S, V1.4S
    SHA1C  Q26, S9, V24.4S
    SHA1M  Q6, S23, V26.4S
    SHA1C  Q13, S4, V0.4S
    SHA256H  Q29, Q14, V24.4S
    SHA1SU0  V12.4S, V24.4S, V12.4S
    SHA1C  Q23, S24, V20.4S
    SHA1C  Q0, S4, V24.4S
    SHA256SU0  V26.4S, V20.4S
    SHA1M  Q19, S21, V29.4S
    SHA1C  Q27, S18, V10.4S
    SHA256H2  Q16, Q23, V11.4S
    SHA1SU0  V20.4S, V16.4S, V26.4S
    SHA256H2  Q16, Q19, V20.4S
    SHA256H2  Q23, Q31, V31.4S
    SHA1M  Q14, S16, V27.4S
    SHA1SU1  V31.4S, V22.4S
    SHA1P  Q25, S6, V29.4S
    SHA1SU0  V27.4S, V25.4S, V5.4S
    SHA256SU0  V16.4S, V27.4S
    SHA1C  Q18, S23, V17.4S
    SHA1C  Q10, S0, V16.4S
    SHA1M  Q25, S14, V10.4S
    SHA256H2  Q23, Q6, V13.4S
    SHA256SU0  V13.4S, V23.4S
    SHA256SU1  V21.4S, V25.4S, V12.4S
    SHA256H  Q24, Q21, V18.4S
    SHA1C  Q14, S13, V16.4S
    SHA1SU1  V19.4S, V7.4S
    SHA1C  Q7, S19, V26.4S
    SHA1C  Q3, S2, V12.4S
    SHA1C  Q5, S6, V9.4S
    SHA1M  Q10, S31, V14.4S
    SHA1P  Q12, S28, V10.4S
    SHA1SU0  V17.4S, V5.4S, V12.4S
    SHA256SU0  V27.4S, V17.4S
    SHA256SU0  V5.4S, V24.4S
    SHA256SU1  V29.4S, V8.4S, V27.4S
    SHA1C  Q24, S3, V7.4S
    SHA1C  Q7, S24, V11.4S
    SHA1M  Q28, S5, V7.4S
    SHA1SU1  V21.4S, V12.4S
    SHA256H2  Q13, Q31, V22.4S
    SHA256SU0  V20.4S, V20.4S
    SHA256H2  Q8, Q23, V17.4S
    SHA256H2  Q19, Q14, V15.4S
    SHA256H2  Q2, Q3, V0.4S
    SHA256H  Q6, Q24, V20.4S
    SHA1SU1  V23.4S, V19.4S
    SHA256H  Q15, Q23, V19.4S
    SHA1P  Q12, S6, V3.4S
    SHA1M  Q22, S16, V0.4S
    SHA256SU0  V7.4S, V8.4S
    SHA256SU1  V31.4S, V15.4S, V7.4S
    SHA256SU1  V8.4S, V5.4S, V31.4S
    SHA1C  Q31, S22, V29.4S
    SHA1P  Q15, S31, V31.4S
    SHA1P  Q9, S25, V2.4S
    SHA1M  Q25, S10, V12.4S
    SHA256SU1  V16.4S, V12.4S, V15.4S
    SHA256SU0  V29.4S, V12.4S
    SHA256SU0  V24.4S, V21.4S
    SHA256SU0  V22.4S, V8.4S
    SHA1SU1  V15.4S, V9.4S
    SHA1P  Q20, S24, V16.4S
    SHA256SU0  V14.4S, V24.4S
    SHA256SU0  V3.4S, V17.4S
    SHA1C  Q31, S29, V6.4S
    SHA1P  Q17, S31, V26.4S
    SHA1C  Q19, S20, V22.4S
    SHA1P  Q9, S14, V6.4S
    SHA256SU0  V0.4S, V26.4S
    SHA1SU0  V3.4S, V15.4S, V19.4S
    SHA256SU0  V11.4S, V25.4S
    SHA256SU1  V16.4S, V7.4S, V11.4S
    SHA1SU1  V14.4S, V0.4S
    SHA256SU0  V19.4S, V18.4S
    SHA1M  Q18, S14, V3.4S
    SHA256SU0  V5.4S, V16.4S
    SHA256H2  Q25, Q12, V22.4S
    SHA256H  Q7, Q25, V17.4S
    SHA256H2  Q8, Q18, V12.4S
    SHA256H2  Q31, Q19, V1.4S
    SUBS  X25, X25, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_12
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X17, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X17, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X17, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X17, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X17, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X17, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X17, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X17, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X17, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X17, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X17, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X17, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X17, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X17, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X17, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X17, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X17, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X17, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MRS  X23, FPSR
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V0.D[1]
    MOVZ  X17, #0x2fcf, LSL #0
    MOVK  X17, #0xceb7, LSL #16
    MOVK  X17, #0x6ec5, LSL #32
    MOVK  X17, #0x7503, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D0
    MOVZ  X17, #0x8eb8, LSL #0
    MOVK  X17, #0x96f7, LSL #16
    MOVK  X17, #0xc6ae, LSL #32
    MOVK  X17, #0x208e, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V1.D[1]
    MOVZ  X17, #0x35d2, LSL #0
    MOVK  X17, #0x3ec2, LSL #16
    MOVK  X17, #0xc816, LSL #32
    MOVK  X17, #0xb69, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D1
    MOVZ  X17, #0x58cf, LSL #0
    MOVK  X17, #0xcc39, LSL #16
    MOVK  X17, #0x3300, LSL #32
    MOVK  X17, #0x3c23, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X17, #0x1caf, LSL #0
    MOVK  X17, #0x636a, LSL #16
    MOVK  X17, #0xaaaf, LSL #32
    MOVK  X17, #0x13bb, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D2
    MOVZ  X17, #0x9de5, LSL #0
    MOVK  X17, #0xa71f, LSL #16
    MOVK  X17, #0x93b3, LSL #32
    MOVK  X17, #0x1a51, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X17, #0x749d, LSL #0
    MOVK  X17, #0xd823, LSL #16
    MOVK  X17, #0xef5, LSL #32
    MOVK  X17, #0xb229, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D3
    MOVZ  X17, #0x3088, LSL #0
    MOVK  X17, #0x2af7, LSL #16
    MOVK  X17, #0xe321, LSL #32
    MOVK  X17, #0x1be9, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X17, #0x3c4e, LSL #0
    MOVK  X17, #0x797f, LSL #16
    MOVK  X17, #0xaae8, LSL #32
    MOVK  X17, #0x5e29, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D4
    MOVZ  X17, #0xefbb, LSL #0
    MOVK  X17, #0xff5c, LSL #16
    MOVK  X17, #0xfd2d, LSL #32
    MOVK  X17, #0x5a88, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X17, #0x5865, LSL #0
    MOVK  X17, #0xd806, LSL #16
    MOVK  X17, #0x4712, LSL #32
    MOVK  X17, #0xf104, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D5
    MOVZ  X17, #0xfcb3, LSL #0
    MOVK  X17, #0xb047, LSL #16
    MOVK  X17, #0xd8b0, LSL #32
    MOVK  X17, #0x2a7e, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X17, #0x2409, LSL #0
    MOVK  X17, #0x14bc, LSL #16
    MOVK  X17, #0x9b4, LSL #32
    MOVK  X17, #0x39a8, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D6
    MOVZ  X17, #0xc36c, LSL #0
    MOVK  X17, #0x5c64, LSL #16
    MOVK  X17, #0x6389, LSL #32
    MOVK  X17, #0x3194, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X17, #0xc4c1, LSL #0
    MOVK  X17, #0xe326, LSL #16
    MOVK  X17, #0xe7e, LSL #32
    MOVK  X17, #0x93cc, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D7
    MOVZ  X17, #0x9e98, LSL #0
    MOVK  X17, #0x26fc, LSL #16
    MOVK  X17, #0xabad, LSL #32
    MOVK  X17, #0x451c, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X17, #0x82ef, LSL #0
    MOVK  X17, #0x6ef4, LSL #16
    MOVK  X17, #0x2b0a, LSL #32
    MOVK  X17, #0x5bf3, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D8
    MOVZ  X17, #0x99b4, LSL #0
    MOVK  X17, #0x6143, LSL #16
    MOVK  X17, #0xc91, LSL #32
    MOVK  X17, #0xa1dc, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X17, #0x901f, LSL #0
    MOVK  X17, #0x7fd0, LSL #16
    MOVK  X17, #0xc8ce, LSL #32
    MOVK  X17, #0x499c, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D9
    MOVZ  X17, #0x929e, LSL #0
    MOVK  X17, #0x3b9a, LSL #16
    MOVK  X17, #0x6585, LSL #32
    MOVK  X17, #0x5d76, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X17, #0x4bb1, LSL #0
    MOVK  X17, #0x2375, LSL #16
    MOVK  X17, #0x2086, LSL #32
    MOVK  X17, #0xde08, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D10
    MOVZ  X17, #0x10fc, LSL #0
    MOVK  X17, #0xb15a, LSL #16
    MOVK  X17, #0x820a, LSL #32
    MOVK  X17, #0x4b83, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X17, #0x10cc, LSL #0
    MOVK  X17, #0x69be, LSL #16
    MOVK  X17, #0x207b, LSL #32
    MOVK  X17, #0x582d, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D11
    MOVZ  X17, #0xe496, LSL #0
    MOVK  X17, #0x55ed, LSL #16
    MOVK  X17, #0xd05, LSL #32
    MOVK  X17, #0xdb34, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X17, #0x4129, LSL #0
    MOVK  X17, #0x8fbf, LSL #16
    MOVK  X17, #0xc030, LSL #32
    MOVK  X17, #0x6816, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D12
    MOVZ  X17, #0xb0f8, LSL #0
    MOVK  X17, #0xeb04, LSL #16
    MOVK  X17, #0xabce, LSL #32
    MOVK  X17, #0x6532, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X17, #0x8458, LSL #0
    MOVK  X17, #0x7ead, LSL #16
    MOVK  X17, #0xe6f, LSL #32
    MOVK  X17, #0x9b90, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D13
    MOVZ  X17, #0x7dd5, LSL #0
    MOVK  X17, #0x8cc1, LSL #16
    MOVK  X17, #0x534, LSL #32
    MOVK  X17, #0x5c98, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X17, #0xc028, LSL #0
    MOVK  X17, #0x431e, LSL #16
    MOVK  X17, #0x3b4a, LSL #32
    MOVK  X17, #0x7cda, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D14
    MOVZ  X17, #0xb8a1, LSL #0
    MOVK  X17, #0xdf94, LSL #16
    MOVK  X17, #0x139f, LSL #32
    MOVK  X17, #0x23e0, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X17, #0xaaf2, LSL #0
    MOVK  X17, #0x42a8, LSL #16
    MOVK  X17, #0x183c, LSL #32
    MOVK  X17, #0xb14, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D15
    MOVZ  X17, #0xb4e8, LSL #0
    MOVK  X17, #0x3d35, LSL #16
    MOVK  X17, #0x3b76, LSL #32
    MOVK  X17, #0xbf61, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X17, #0xfaf3, LSL #0
    MOVK  X17, #0x4d13, LSL #16
    MOVK  X17, #0x3516, LSL #32
    MOVK  X17, #0x221e, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D16
    MOVZ  X17, #0xbbec, LSL #0
    MOVK  X17, #0x23a6, LSL #16
    MOVK  X17, #0xab03, LSL #32
    MOVK  X17, #0xd171, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X17, #0x5c02, LSL #0
    MOVK  X17, #0xc827, LSL #16
    MOVK  X17, #0x21e1, LSL #32
    MOVK  X17, #0x4265, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D17
    MOVZ  X17, #0x6871, LSL #0
    MOVK  X17, #0x81d6, LSL #16
    MOVK  X17, #0x992b, LSL #32
    MOVK  X17, #0x48aa, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X17, #0xbfcc, LSL #0
    MOVK  X17, #0xfc1b, LSL #16
    MOVK  X17, #0xef6, LSL #32
    MOVK  X17, #0xb122, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D18
    MOVZ  X17, #0x27f4, LSL #0
    MOVK  X17, #0xe3a, LSL #16
    MOVK  X17, #0x2306, LSL #32
    MOVK  X17, #0x3bdd, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X17, #0xf358, LSL #0
    MOVK  X17, #0xc06d, LSL #16
    MOVK  X17, #0x71b8, LSL #32
    MOVK  X17, #0xb633, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D19
    MOVZ  X17, #0x70b5, LSL #0
    MOVK  X17, #0xc3ed, LSL #16
    MOVK  X17, #0x36f1, LSL #32
    MOVK  X17, #0x158, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X17, #0xeca8, LSL #0
    MOVK  X17, #0xfb80, LSL #16
    MOVK  X17, #0xbb06, LSL #32
    MOVK  X17, #0x3c52, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D20
    MOVZ  X17, #0x391c, LSL #0
    MOVK  X17, #0xe3ce, LSL #16
    MOVK  X17, #0xc8b9, LSL #32
    MOVK  X17, #0x642c, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X17, #0x428c, LSL #0
    MOVK  X17, #0xc8ad, LSL #16
    MOVK  X17, #0x768d, LSL #32
    MOVK  X17, #0xf8a9, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D21
    MOVZ  X17, #0xa5cb, LSL #0
    MOVK  X17, #0x86de, LSL #16
    MOVK  X17, #0x2954, LSL #32
    MOVK  X17, #0xb35c, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X17, #0x76f2, LSL #0
    MOVK  X17, #0xa9b2, LSL #16
    MOVK  X17, #0xb8f8, LSL #32
    MOVK  X17, #0xcb83, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D22
    MOVZ  X17, #0x3016, LSL #0
    MOVK  X17, #0x2dd3, LSL #16
    MOVK  X17, #0xd963, LSL #32
    MOVK  X17, #0x6a21, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V23.D[1]
    MOVZ  X17, #0x656a, LSL #0
    MOVK  X17, #0x4634, LSL #16
    MOVK  X17, #0xbe5a, LSL #32
    MOVK  X17, #0xb430, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D23
    MOVZ  X17, #0x4173, LSL #0
    MOVK  X17, #0x6bdc, LSL #16
    MOVK  X17, #0xd63b, LSL #32
    MOVK  X17, #0xa03f, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X17, #0x24b1, LSL #0
    MOVK  X17, #0x61f4, LSL #16
    MOVK  X17, #0xba0b, LSL #32
    MOVK  X17, #0x5af6, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D24
    MOVZ  X17, #0x7ad, LSL #0
    MOVK  X17, #0xdcc7, LSL #16
    MOVK  X17, #0xdc18, LSL #32
    MOVK  X17, #0xbd48, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X17, #0xc78e, LSL #0
    MOVK  X17, #0x3c92, LSL #16
    MOVK  X17, #0xcf46, LSL #32
    MOVK  X17, #0x48bb, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D25
    MOVZ  X17, #0x3541, LSL #0
    MOVK  X17, #0xfec8, LSL #16
    MOVK  X17, #0x61d1, LSL #32
    MOVK  X17, #0x6bb, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X17, #0x4b55, LSL #0
    MOVK  X17, #0xfd5a, LSL #16
    MOVK  X17, #0xe73d, LSL #32
    MOVK  X17, #0xe31c, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D26
    MOVZ  X17, #0xb671, LSL #0
    MOVK  X17, #0xe8cc, LSL #16
    MOVK  X17, #0xcf62, LSL #32
    MOVK  X17, #0x4edd, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X17, #0x7fd6, LSL #0
    MOVK  X17, #0x1f3a, LSL #16
    MOVK  X17, #0xb722, LSL #32
    MOVK  X17, #0xeeff, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D27
    MOVZ  X17, #0xa4f5, LSL #0
    MOVK  X17, #0xdb07, LSL #16
    MOVK  X17, #0x8b00, LSL #32
    MOVK  X17, #0x1c77, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X17, #0xf038, LSL #0
    MOVK  X17, #0x59ff, LSL #16
    MOVK  X17, #0xb33b, LSL #32
    MOVK  X17, #0xce6d, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D28
    MOVZ  X17, #0x85f3, LSL #0
    MOVK  X17, #0xe2f3, LSL #16
    MOVK  X17, #0x5f39, LSL #32
    MOVK  X17, #0x3bf9, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X17, #0xc9f9, LSL #0
    MOVK  X17, #0x5a30, LSL #16
    MOVK  X17, #0x3a52, LSL #32
    MOVK  X17, #0xbef0, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D29
    MOVZ  X17, #0x750f, LSL #0
    MOVK  X17, #0x6f86, LSL #16
    MOVK  X17, #0x4769, LSL #32
    MOVK  X17, #0x7da0, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V30.D[1]
    MOVZ  X17, #0x108, LSL #0
    MOVK  X17, #0xa1e8, LSL #16
    MOVK  X17, #0x73c, LSL #32
    MOVK  X17, #0xc558, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D30
    MOVZ  X17, #0x7d5, LSL #0
    MOVK  X17, #0x2173, LSL #16
    MOVK  X17, #0xf6e7, LSL #32
    MOVK  X17, #0x6fee, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, V31.D[1]
    MOVZ  X17, #0xc17e, LSL #0
    MOVK  X17, #0xf945, LSL #16
    MOVK  X17, #0xd489, LSL #32
    MOVK  X17, #0xa9bd, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X23, D31
    MOVZ  X17, #0x7760, LSL #0
    MOVK  X17, #0x32d6, LSL #16
    MOVK  X17, #0x6d12, LSL #32
    MOVK  X17, #0x4318, LSL #48
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
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
    FMOV  D0, X17
    FMOV  V0.D[1], X25
    FMOV  D1, X17
    FMOV  V1.D[1], X27
    FMOV  D2, X25
    FMOV  V2.D[1], X28
    FMOV  D3, X8
    FMOV  V3.D[1], X26
    FMOV  D4, X29
    FMOV  V4.D[1], X26
    FMOV  D5, X9
    FMOV  V5.D[1], X14
    FMOV  D6, X9
    FMOV  V6.D[1], X7
    FMOV  D7, X4
    FMOV  V7.D[1], X25
    FMOV  D8, X8
    FMOV  V8.D[1], X9
    FMOV  D9, X29
    FMOV  V9.D[1], X12
    FMOV  D10, X9
    FMOV  V10.D[1], X26
    FMOV  D11, X27
    FMOV  V11.D[1], X10
    FMOV  D12, X25
    FMOV  V12.D[1], X25
    FMOV  D13, X11
    FMOV  V13.D[1], X27
    FMOV  D14, X2
    FMOV  V14.D[1], X15
    FMOV  D15, X7
    FMOV  V15.D[1], X12
    FMOV  D16, X14
    FMOV  V16.D[1], X14
    FMOV  D17, X4
    FMOV  V17.D[1], X9
    FMOV  D18, X13
    FMOV  V18.D[1], X26
    FMOV  D19, X3
    FMOV  V19.D[1], X26
    FMOV  D20, X17
    FMOV  V20.D[1], X26
    FMOV  D21, X9
    FMOV  V21.D[1], X26
    FMOV  D22, X29
    FMOV  V22.D[1], X7
    FMOV  D23, X13
    FMOV  V23.D[1], X15
    FMOV  D24, X10
    FMOV  V24.D[1], X29
    FMOV  D25, X6
    FMOV  V25.D[1], X3
    FMOV  D26, X2
    FMOV  V26.D[1], X8
    FMOV  D27, X13
    FMOV  V27.D[1], X14
    FMOV  D28, X11
    FMOV  V28.D[1], X23
    FMOV  D29, X24
    FMOV  V29.D[1], X23
    FMOV  D30, X4
    FMOV  V30.D[1], X26
    FMOV  D31, X7
    FMOV  V31.D[1], X26
    MOVZ  X2, #0xa, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_13:
    SHA1C  Q12, S23, V21.4S
    SHA1M  Q25, S28, V31.4S
    SHA1M  Q16, S5, V29.4S
    SHA256H2  Q13, Q24, V12.4S
    SHA256H  Q3, Q13, V13.4S
    SHA1SU1  V15.4S, V16.4S
    SHA1SU0  V28.4S, V14.4S, V20.4S
    SHA1P  Q9, S26, V28.4S
    SHA1SU0  V10.4S, V9.4S, V3.4S
    SHA1SU1  V7.4S, V28.4S
    SHA1SU0  V5.4S, V15.4S, V16.4S
    SHA1P  Q3, S5, V5.4S
    SHA1P  Q13, S30, V3.4S
    SHA256H2  Q12, Q25, V10.4S
    SHA1P  Q25, S7, V13.4S
    SHA1P  Q23, S25, V25.4S
    SHA1SU0  V13.4S, V6.4S, V12.4S
    SHA256H  Q5, Q25, V8.4S
    SHA1P  Q10, S13, V5.4S
    SHA1C  Q21, S0, V27.4S
    SHA256H  Q1, Q10, V10.4S
    SHA256H2  Q7, Q1, V16.4S
    SHA256H  Q27, Q31, V7.4S
    SHA1P  Q10, S25, V29.4S
    SHA256H2  Q16, Q21, V22.4S
    SHA1C  Q26, S23, V23.4S
    SHA256H2  Q1, Q16, V27.4S
    SHA1SU0  V9.4S, V26.4S, V16.4S
    SHA1M  Q6, S10, V9.4S
    SHA1C  Q29, S1, V18.4S
    SHA1SU1  V11.4S, V18.4S
    SHA256H2  Q20, Q3, V3.4S
    SHA1M  Q1, S21, V1.4S
    SHA256H2  Q18, Q4, V3.4S
    SHA1C  Q16, S25, V16.4S
    SHA1SU1  V9.4S, V21.4S
    SHA1SU0  V26.4S, V20.4S, V22.4S
    SHA1M  Q3, S20, V6.4S
    SHA1SU1  V0.4S, V24.4S
    SHA256H  Q31, Q18, V10.4S
    SHA1C  Q6, S1, V26.4S
    SHA256H  Q30, Q31, V3.4S
    SHA1SU1  V25.4S, V0.4S
    SHA1SU1  V27.4S, V11.4S
    SHA256H  Q21, Q6, V16.4S
    SHA256SU1  V10.4S, V25.4S, V4.4S
    SHA1C  Q16, S21, V27.4S
    SHA1C  Q4, S29, V10.4S
    SHA256H  Q26, Q4, V4.4S
    SHA256SU0  V0.4S, V4.4S
    SHA256SU0  V11.4S, V12.4S
    SHA256SU0  V22.4S, V20.4S
    SHA256H  Q5, Q11, V30.4S
    SHA1SU1  V29.4S, V28.4S
    SHA256SU1  V18.4S, V5.4S, V5.4S
    SHA256H  Q28, Q26, V16.4S
    SHA1C  Q27, S26, V28.4S
    SHA1SU0  V31.4S, V27.4S, V22.4S
    SHA1M  Q24, S31, V0.4S
    SHA256H  Q1, Q29, V29.4S
    SHA1M  Q22, S23, V18.4S
    SHA1P  Q14, S9, V17.4S
    SHA256SU0  V4.4S, V24.4S
    SHA256H  Q21, Q14, V6.4S
    SHA1P  Q31, S21, V1.4S
    SHA1M  Q31, S22, V22.4S
    SHA1P  Q17, S22, V1.4S
    SHA1SU1  V7.4S, V7.4S
    SHA1M  Q10, S29, V2.4S
    SHA256H2  Q27, Q16, V29.4S
    SHA256H2  Q18, Q5, V9.4S
    SHA1M  Q28, S15, V27.4S
    SHA1SU0  V15.4S, V10.4S, V24.4S
    SHA1M  Q21, S5, V18.4S
    SHA256H2  Q2, Q10, V12.4S
    SHA256H  Q27, Q8, V12.4S
    SHA1SU0  V22.4S, V4.4S, V2.4S
    SHA256H  Q2, Q17, V17.4S
    SHA256SU0  V29.4S, V31.4S
    SHA1C  Q23, S15, V27.4S
    SHA1SU0  V1.4S, V16.4S, V18.4S
    SHA1SU0  V24.4S, V29.4S, V21.4S
    SHA256SU1  V12.4S, V7.4S, V22.4S
    SHA1SU1  V29.4S, V28.4S
    SHA256SU0  V15.4S, V12.4S
    SHA1C  Q8, S31, V15.4S
    SHA1M  Q28, S1, V24.4S
    SHA1P  Q18, S2, V6.4S
    SHA1M  Q31, S24, V8.4S
    SHA1P  Q21, S3, V31.4S
    SHA1C  Q6, S3, V28.4S
    SHA1P  Q2, S21, V12.4S
    SHA256H  Q22, Q2, V23.4S
    SHA1SU0  V21.4S, V22.4S, V27.4S
    SHA256H2  Q2, Q18, V1.4S
    SHA1M  Q17, S22, V21.4S
    SHA256H2  Q24, Q16, V20.4S
    SHA256SU1  V18.4S, V6.4S, V2.4S
    SHA1SU1  V16.4S, V17.4S
    SHA1SU1  V27.4S, V25.4S
    SHA1SU1  V20.4S, V24.4S
    SHA1P  Q9, S5, V8.4S
    SHA1M  Q22, S16, V16.4S
    SHA1M  Q24, S14, V9.4S
    SHA1P  Q15, S27, V14.4S
    SHA256H2  Q6, Q9, V20.4S
    SHA256SU0  V12.4S, V18.4S
    SHA256H2  Q17, Q12, V6.4S
    SHA1C  Q21, S17, V17.4S
    SHA256SU1  V3.4S, V25.4S, V29.4S
    SHA1M  Q23, S13, V2.4S
    SHA1SU0  V2.4S, V5.4S, V3.4S
    SHA1P  Q5, S24, V16.4S
    SHA1C  Q31, S15, V22.4S
    SHA256H  Q15, Q23, V24.4S
    SHA256SU1  V29.4S, V15.4S, V7.4S
    SHA256H2  Q3, Q2, V6.4S
    SHA1SU1  V14.4S, V21.4S
    SHA1M  Q16, S29, V5.4S
    SHA1P  Q27, S3, V14.4S
    SHA1SU0  V1.4S, V16.4S, V7.4S
    SHA1C  Q14, S27, V31.4S
    SHA1SU1  V6.4S, V11.4S
    SHA256SU1  V23.4S, V27.4S, V2.4S
    SHA1M  Q29, S23, V2.4S
    SHA256H  Q5, Q26, V4.4S
    SHA1M  Q15, S9, V3.4S
    SHA1C  Q11, S20, V26.4S
    SHA256H  Q7, Q26, V26.4S
    SHA1C  Q26, S12, V5.4S
    SHA256SU1  V2.4S, V2.4S, V16.4S
    SHA256H  Q4, Q31, V1.4S
    SHA1SU0  V12.4S, V7.4S, V4.4S
    SHA1C  Q17, S18, V15.4S
    SHA1C  Q25, S23, V29.4S
    SHA1M  Q13, S3, V31.4S
    SHA1SU0  V25.4S, V26.4S, V23.4S
    SHA1P  Q5, S27, V25.4S
    SHA1M  Q22, S30, V17.4S
    SHA1C  Q7, S6, V2.4S
    SHA256SU0  V29.4S, V14.4S
    SHA1P  Q4, S5, V14.4S
    SHA1M  Q6, S13, V31.4S
    SHA1SU1  V30.4S, V6.4S
    SHA256H2  Q17, Q22, V23.4S
    SHA1SU1  V31.4S, V17.4S
    SHA256H  Q26, Q4, V4.4S
    SHA256SU0  V16.4S, V2.4S
    SHA1C  Q26, S31, V11.4S
    SHA256H  Q10, Q13, V16.4S
    SHA1P  Q18, S30, V30.4S
    SHA256H  Q20, Q31, V10.4S
    SHA1SU0  V2.4S, V22.4S, V1.4S
    SHA1C  Q9, S26, V14.4S
    SHA1M  Q4, S17, V9.4S
    SHA256H2  Q17, Q2, V12.4S
    SHA256H2  Q4, Q29, V4.4S
    SHA1P  Q30, S20, V7.4S
    SHA1C  Q29, S30, V18.4S
    SHA1P  Q20, S17, V17.4S
    SHA1P  Q22, S1, V26.4S
    SHA1SU0  V31.4S, V17.4S, V15.4S
    SHA256SU0  V25.4S, V4.4S
    SHA256H2  Q14, Q22, V20.4S
    SHA1M  Q2, S14, V14.4S
    SHA1M  Q20, S6, V2.4S
    SHA1C  Q27, S20, V25.4S
    SHA1P  Q14, S5, V19.4S
    SHA256SU1  V17.4S, V14.4S, V31.4S
    SHA1C  Q19, S17, V27.4S
    SHA1C  Q29, S31, V18.4S
    SHA1C  Q16, S0, V22.4S
    SHA256SU0  V26.4S, V23.4S
    SHA1M  Q17, S25, V22.4S
    SHA1SU0  V23.4S, V22.4S, V24.4S
    SHA1SU0  V12.4S, V26.4S, V31.4S
    SHA1SU1  V6.4S, V2.4S
    SHA256H  Q31, Q24, V0.4S
    SHA256SU0  V1.4S, V7.4S
    SHA256H  Q4, Q29, V19.4S
    SHA1P  Q13, S23, V6.4S
    SHA256H2  Q12, Q20, V31.4S
    SHA1P  Q8, S12, V1.4S
    SHA1C  Q5, S13, V17.4S
    SHA1P  Q25, S5, V5.4S
    SHA1P  Q24, S25, V23.4S
    SHA1SU0  V19.4S, V24.4S, V16.4S
    SHA256H  Q0, Q15, V19.4S
    SHA256SU1  V7.4S, V8.4S, V8.4S
    SHA1M  Q28, S0, V22.4S
    SHA1SU1  V2.4S, V28.4S
    SHA256SU1  V1.4S, V2.4S, V5.4S
    SHA1M  Q26, S8, V1.4S
    SHA1P  Q23, S4, V4.4S
    SHA256SU1  V27.4S, V1.4S, V21.4S
    SHA1SU0  V13.4S, V7.4S, V27.4S
    SHA256SU0  V28.4S, V26.4S
    SHA1P  Q26, S27, V13.4S
    SHA1P  Q4, S26, V2.4S
    SHA1SU1  V31.4S, V18.4S
    SUBS  X2, X2, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_13
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MRS  X15, FPSR
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V0.D[1]
    MOVZ  X12, #0x800f, LSL #0
    MOVK  X12, #0x938b, LSL #16
    MOVK  X12, #0xdc22, LSL #32
    MOVK  X12, #0x5c05, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D0
    MOVZ  X12, #0x4594, LSL #0
    MOVK  X12, #0x5eea, LSL #16
    MOVK  X12, #0x12b6, LSL #32
    MOVK  X12, #0x3d8c, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V1.D[1]
    MOVZ  X12, #0xe5ab, LSL #0
    MOVK  X12, #0xaa8e, LSL #16
    MOVK  X12, #0x4429, LSL #32
    MOVK  X12, #0xb99b, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D1
    MOVZ  X12, #0x5488, LSL #0
    MOVK  X12, #0x3008, LSL #16
    MOVK  X12, #0x20e, LSL #32
    MOVK  X12, #0x37ec, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V2.D[1]
    MOVZ  X12, #0x7c9d, LSL #0
    MOVK  X12, #0xc107, LSL #16
    MOVK  X12, #0x97ac, LSL #32
    MOVK  X12, #0xd97e, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D2
    MOVZ  X12, #0x4a94, LSL #0
    MOVK  X12, #0x693e, LSL #16
    MOVK  X12, #0xd562, LSL #32
    MOVK  X12, #0x52b0, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V3.D[1]
    MOVZ  X12, #0x7a8f, LSL #0
    MOVK  X12, #0xc2f, LSL #16
    MOVK  X12, #0x645e, LSL #32
    MOVK  X12, #0xe733, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D3
    MOVZ  X12, #0x21a2, LSL #0
    MOVK  X12, #0x5eaf, LSL #16
    MOVK  X12, #0xd2e8, LSL #32
    MOVK  X12, #0x7987, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V4.D[1]
    MOVZ  X12, #0x8e22, LSL #0
    MOVK  X12, #0x8793, LSL #16
    MOVK  X12, #0xce97, LSL #32
    MOVK  X12, #0xea5b, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D4
    MOVZ  X12, #0xdce3, LSL #0
    MOVK  X12, #0xcca8, LSL #16
    MOVK  X12, #0x5af0, LSL #32
    MOVK  X12, #0xe6f, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V5.D[1]
    MOVZ  X12, #0x8723, LSL #0
    MOVK  X12, #0x2f88, LSL #16
    MOVK  X12, #0x99dc, LSL #32
    MOVK  X12, #0x5ecd, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D5
    MOVZ  X12, #0x84f7, LSL #0
    MOVK  X12, #0xd521, LSL #16
    MOVK  X12, #0x4d2f, LSL #32
    MOVK  X12, #0xf193, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V6.D[1]
    MOVZ  X12, #0xcc4, LSL #0
    MOVK  X12, #0x6eeb, LSL #16
    MOVK  X12, #0x77ed, LSL #32
    MOVK  X12, #0xd183, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D6
    MOVZ  X12, #0xaa08, LSL #0
    MOVK  X12, #0xd21f, LSL #16
    MOVK  X12, #0xade5, LSL #32
    MOVK  X12, #0xe87c, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V7.D[1]
    MOVZ  X12, #0xc9c3, LSL #0
    MOVK  X12, #0x1566, LSL #16
    MOVK  X12, #0xf520, LSL #32
    MOVK  X12, #0x5b61, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D7
    MOVZ  X12, #0x9b77, LSL #0
    MOVK  X12, #0x37a8, LSL #16
    MOVK  X12, #0x64de, LSL #32
    MOVK  X12, #0x35b8, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V8.D[1]
    MOVZ  X12, #0x47bd, LSL #0
    MOVK  X12, #0x77b9, LSL #16
    MOVK  X12, #0x46dd, LSL #32
    MOVK  X12, #0xe8c, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D8
    MOVZ  X12, #0xeeb1, LSL #0
    MOVK  X12, #0x139, LSL #16
    MOVK  X12, #0x157c, LSL #32
    MOVK  X12, #0xe103, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V9.D[1]
    MOVZ  X12, #0x31b1, LSL #0
    MOVK  X12, #0x52a9, LSL #16
    MOVK  X12, #0xb0c7, LSL #32
    MOVK  X12, #0x2cb1, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D9
    MOVZ  X12, #0xc33d, LSL #0
    MOVK  X12, #0x92c0, LSL #16
    MOVK  X12, #0x54a0, LSL #32
    MOVK  X12, #0x7f2b, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V10.D[1]
    MOVZ  X12, #0x3186, LSL #0
    MOVK  X12, #0x6c0b, LSL #16
    MOVK  X12, #0x987b, LSL #32
    MOVK  X12, #0x309, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D10
    MOVZ  X12, #0xe1f1, LSL #0
    MOVK  X12, #0xff4d, LSL #16
    MOVK  X12, #0xe87b, LSL #32
    MOVK  X12, #0x3dff, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V11.D[1]
    MOVZ  X12, #0xd307, LSL #0
    MOVK  X12, #0x5495, LSL #16
    MOVK  X12, #0x4e8b, LSL #32
    MOVK  X12, #0xfc1, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D11
    MOVZ  X12, #0xf8cb, LSL #0
    MOVK  X12, #0x272d, LSL #16
    MOVK  X12, #0xba34, LSL #32
    MOVK  X12, #0x44b9, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V12.D[1]
    MOVZ  X12, #0xf9c1, LSL #0
    MOVK  X12, #0x6a34, LSL #16
    MOVK  X12, #0x7739, LSL #32
    MOVK  X12, #0xcc41, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D12
    MOVZ  X12, #0x8687, LSL #0
    MOVK  X12, #0xf9c8, LSL #16
    MOVK  X12, #0x2f4f, LSL #32
    MOVK  X12, #0x3b3f, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V13.D[1]
    MOVZ  X12, #0xf714, LSL #0
    MOVK  X12, #0xcf77, LSL #16
    MOVK  X12, #0x158d, LSL #32
    MOVK  X12, #0xcf01, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D13
    MOVZ  X12, #0xfe37, LSL #0
    MOVK  X12, #0x1c59, LSL #16
    MOVK  X12, #0x50fd, LSL #32
    MOVK  X12, #0x6931, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V14.D[1]
    MOVZ  X12, #0xf278, LSL #0
    MOVK  X12, #0xd66a, LSL #16
    MOVK  X12, #0x1ee3, LSL #32
    MOVK  X12, #0xdb6f, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D14
    MOVZ  X12, #0xaafc, LSL #0
    MOVK  X12, #0xb297, LSL #16
    MOVK  X12, #0x7a8d, LSL #32
    MOVK  X12, #0xfa07, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V15.D[1]
    MOVZ  X12, #0x27e, LSL #0
    MOVK  X12, #0xcc81, LSL #16
    MOVK  X12, #0x166f, LSL #32
    MOVK  X12, #0xeb5a, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D15
    MOVZ  X12, #0xca2e, LSL #0
    MOVK  X12, #0xdb05, LSL #16
    MOVK  X12, #0x7fa7, LSL #32
    MOVK  X12, #0xd6c1, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X12, #0x7456, LSL #0
    MOVK  X12, #0xc5c3, LSL #16
    MOVK  X12, #0x460f, LSL #32
    MOVK  X12, #0xce60, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D16
    MOVZ  X12, #0xc176, LSL #0
    MOVK  X12, #0x14bb, LSL #16
    MOVK  X12, #0x6889, LSL #32
    MOVK  X12, #0x330c, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V17.D[1]
    MOVZ  X12, #0x318c, LSL #0
    MOVK  X12, #0x3cff, LSL #16
    MOVK  X12, #0xca6d, LSL #32
    MOVK  X12, #0xd0c8, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D17
    MOVZ  X12, #0x9550, LSL #0
    MOVK  X12, #0xa44f, LSL #16
    MOVK  X12, #0x1b2, LSL #32
    MOVK  X12, #0x952c, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V18.D[1]
    MOVZ  X12, #0xb26e, LSL #0
    MOVK  X12, #0xecda, LSL #16
    MOVK  X12, #0x3680, LSL #32
    MOVK  X12, #0xec04, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D18
    MOVZ  X12, #0xd722, LSL #0
    MOVK  X12, #0xc25, LSL #16
    MOVK  X12, #0x109e, LSL #32
    MOVK  X12, #0xe634, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V19.D[1]
    MOVZ  X12, #0x9300, LSL #0
    MOVK  X12, #0x8ab7, LSL #16
    MOVK  X12, #0xecf1, LSL #32
    MOVK  X12, #0xde94, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D19
    MOVZ  X12, #0x5fcb, LSL #0
    MOVK  X12, #0xce08, LSL #16
    MOVK  X12, #0x8f1b, LSL #32
    MOVK  X12, #0x59cb, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V20.D[1]
    MOVZ  X12, #0xbfda, LSL #0
    MOVK  X12, #0x4206, LSL #16
    MOVK  X12, #0x9b0b, LSL #32
    MOVK  X12, #0xf7ce, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D20
    MOVZ  X12, #0xada2, LSL #0
    MOVK  X12, #0x50cd, LSL #16
    MOVK  X12, #0xce9a, LSL #32
    MOVK  X12, #0xcb85, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V21.D[1]
    MOVZ  X12, #0xe9e4, LSL #0
    MOVK  X12, #0xca18, LSL #16
    MOVK  X12, #0xf66c, LSL #32
    MOVK  X12, #0x6c18, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D21
    MOVZ  X12, #0xc46c, LSL #0
    MOVK  X12, #0x928d, LSL #16
    MOVK  X12, #0xcb3b, LSL #32
    MOVK  X12, #0xbb0, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V22.D[1]
    MOVZ  X12, #0xe074, LSL #0
    MOVK  X12, #0xf589, LSL #16
    MOVK  X12, #0x73bf, LSL #32
    MOVK  X12, #0xc9b8, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D22
    MOVZ  X12, #0xb7b9, LSL #0
    MOVK  X12, #0xd4c7, LSL #16
    MOVK  X12, #0x39e9, LSL #32
    MOVK  X12, #0x5ad9, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V23.D[1]
    MOVZ  X12, #0x1e2a, LSL #0
    MOVK  X12, #0xd056, LSL #16
    MOVK  X12, #0xbb3f, LSL #32
    MOVK  X12, #0x4c29, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D23
    MOVZ  X12, #0x59dc, LSL #0
    MOVK  X12, #0xbfed, LSL #16
    MOVK  X12, #0xa921, LSL #32
    MOVK  X12, #0xae95, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V24.D[1]
    MOVZ  X12, #0x8fd, LSL #0
    MOVK  X12, #0xdb83, LSL #16
    MOVK  X12, #0x7827, LSL #32
    MOVK  X12, #0x998, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D24
    MOVZ  X12, #0xcdd, LSL #0
    MOVK  X12, #0xea00, LSL #16
    MOVK  X12, #0x676a, LSL #32
    MOVK  X12, #0x14ad, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V25.D[1]
    MOVZ  X12, #0x9859, LSL #0
    MOVK  X12, #0x3735, LSL #16
    MOVK  X12, #0xe06c, LSL #32
    MOVK  X12, #0xe6d4, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D25
    MOVZ  X12, #0x3983, LSL #0
    MOVK  X12, #0x623d, LSL #16
    MOVK  X12, #0xa27f, LSL #32
    MOVK  X12, #0xac05, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X12, #0x93cf, LSL #0
    MOVK  X12, #0x317d, LSL #16
    MOVK  X12, #0xf43a, LSL #32
    MOVK  X12, #0xf0e4, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D26
    MOVZ  X12, #0xc404, LSL #0
    MOVK  X12, #0x2eba, LSL #16
    MOVK  X12, #0xad3f, LSL #32
    MOVK  X12, #0xce46, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V27.D[1]
    MOVZ  X12, #0x8efc, LSL #0
    MOVK  X12, #0x571a, LSL #16
    MOVK  X12, #0xb959, LSL #32
    MOVK  X12, #0xd894, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D27
    MOVZ  X12, #0x6f73, LSL #0
    MOVK  X12, #0xb170, LSL #16
    MOVK  X12, #0x581c, LSL #32
    MOVK  X12, #0xbaa5, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V28.D[1]
    MOVZ  X12, #0xd6a0, LSL #0
    MOVK  X12, #0x8378, LSL #16
    MOVK  X12, #0x40e4, LSL #32
    MOVK  X12, #0xe3db, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D28
    MOVZ  X12, #0x22ac, LSL #0
    MOVK  X12, #0x19b2, LSL #16
    MOVK  X12, #0x6e51, LSL #32
    MOVK  X12, #0xc356, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V29.D[1]
    MOVZ  X12, #0xbdf6, LSL #0
    MOVK  X12, #0x5028, LSL #16
    MOVK  X12, #0xd856, LSL #32
    MOVK  X12, #0x911e, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D29
    MOVZ  X12, #0xe553, LSL #0
    MOVK  X12, #0x6f18, LSL #16
    MOVK  X12, #0x2f10, LSL #32
    MOVK  X12, #0x1bd7, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V30.D[1]
    MOVZ  X12, #0x9133, LSL #0
    MOVK  X12, #0x6785, LSL #16
    MOVK  X12, #0x7464, LSL #32
    MOVK  X12, #0x8251, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D30
    MOVZ  X12, #0xc977, LSL #0
    MOVK  X12, #0xafaa, LSL #16
    MOVK  X12, #0x7982, LSL #32
    MOVK  X12, #0x77a6, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, V31.D[1]
    MOVZ  X12, #0xe66a, LSL #0
    MOVK  X12, #0xe3fb, LSL #16
    MOVK  X12, #0x1099, LSL #32
    MOVK  X12, #0x2fcc, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X15, D31
    MOVZ  X12, #0x7b06, LSL #0
    MOVK  X12, #0xfda8, LSL #16
    MOVK  X12, #0xac74, LSL #32
    MOVK  X12, #0xef69, LSL #48
    SUB  X23, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
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
    FMOV  D0, X27
    FMOV  V0.D[1], X23
    FMOV  D1, X25
    FMOV  V1.D[1], X28
    FMOV  D2, X29
    FMOV  V2.D[1], X26
    FMOV  D3, X16
    FMOV  V3.D[1], X11
    FMOV  D4, X24
    FMOV  V4.D[1], X25
    FMOV  D5, X3
    FMOV  V5.D[1], X25
    FMOV  D6, X5
    FMOV  V6.D[1], X11
    FMOV  D7, X27
    FMOV  V7.D[1], X28
    FMOV  D8, X17
    FMOV  V8.D[1], X14
    FMOV  D9, X23
    FMOV  V9.D[1], X3
    FMOV  D10, X23
    FMOV  V10.D[1], X15
    FMOV  D11, X23
    FMOV  V11.D[1], X4
    FMOV  D12, X25
    FMOV  V12.D[1], X12
    FMOV  D13, X9
    FMOV  V13.D[1], X26
    FMOV  D14, X3
    FMOV  V14.D[1], X28
    FMOV  D15, X17
    FMOV  V15.D[1], X5
    FMOV  D16, X3
    FMOV  V16.D[1], X4
    FMOV  D17, X26
    FMOV  V17.D[1], X28
    FMOV  D18, X5
    FMOV  V18.D[1], X8
    FMOV  D19, X28
    FMOV  V19.D[1], X5
    FMOV  D20, X25
    FMOV  V20.D[1], X11
    FMOV  D21, X16
    FMOV  V21.D[1], X8
    FMOV  D22, X25
    FMOV  V22.D[1], X6
    FMOV  D23, X7
    FMOV  V23.D[1], X5
    FMOV  D24, X27
    FMOV  V24.D[1], X26
    FMOV  D25, X16
    FMOV  V25.D[1], X16
    FMOV  D26, X11
    FMOV  V26.D[1], X25
    FMOV  D27, X10
    FMOV  V27.D[1], X28
    FMOV  D28, X2
    FMOV  V28.D[1], X6
    FMOV  D29, X16
    FMOV  V29.D[1], X2
    FMOV  D30, X8
    FMOV  V30.D[1], X6
    FMOV  D31, X23
    FMOV  V31.D[1], X27
    MOVZ  X26, #0xa, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_14:
    SHA256SU1  V24.4S, V28.4S, V10.4S
    SHA1SU0  V25.4S, V30.4S, V31.4S
    SHA1SU1  V24.4S, V18.4S
    SHA256SU1  V19.4S, V29.4S, V21.4S
    SHA256H  Q4, Q7, V29.4S
    SHA1P  Q20, S10, V28.4S
    SHA256H2  Q31, Q25, V12.4S
    SHA256H  Q24, Q23, V15.4S
    SHA1SU1  V11.4S, V27.4S
    SHA256H  Q29, Q31, V12.4S
    SHA1P  Q22, S11, V5.4S
    SHA256SU1  V31.4S, V20.4S, V4.4S
    SHA1SU0  V12.4S, V31.4S, V19.4S
    SHA1C  Q21, S6, V29.4S
    SHA1P  Q31, S29, V13.4S
    SHA1C  Q6, S31, V22.4S
    SHA256H  Q22, Q14, V26.4S
    SHA1C  Q30, S24, V24.4S
    SHA256SU1  V31.4S, V30.4S, V21.4S
    SHA1M  Q29, S6, V12.4S
    SHA256SU0  V23.4S, V10.4S
    SHA1SU1  V4.4S, V1.4S
    SHA256H  Q14, Q23, V23.4S
    SHA1C  Q30, S9, V14.4S
    SHA256SU1  V26.4S, V31.4S, V22.4S
    SHA1P  Q24, S30, V21.4S
    SHA1SU0  V12.4S, V26.4S, V26.4S
    SHA256SU0  V19.4S, V29.4S
    SHA1SU1  V13.4S, V24.4S
    SHA1SU0  V26.4S, V0.4S, V2.4S
    SHA256SU1  V6.4S, V26.4S, V12.4S
    SHA1M  Q31, S12, V19.4S
    SHA256H  Q14, Q29, V6.4S
    SHA1SU1  V1.4S, V31.4S
    SHA256SU1  V24.4S, V13.4S, V14.4S
    SHA256SU0  V2.4S, V24.4S
    SHA256H  Q25, Q14, V7.4S
    SHA1P  Q9, S1, V2.4S
    SHA256SU1  V17.4S, V9.4S, V25.4S
    SHA256SU0  V2.4S, V21.4S
    SHA1P  Q27, S1, V30.4S
    SHA1SU1  V6.4S, V30.4S
    SHA256SU1  V26.4S, V31.4S, V1.4S
    SHA256SU1  V22.4S, V20.4S, V27.4S
    SHA256SU0  V20.4S, V1.4S
    SHA1M  Q24, S3, V24.4S
    SHA256SU1  V21.4S, V5.4S, V27.4S
    SHA1SU1  V27.4S, V2.4S
    SHA1SU1  V3.4S, V21.4S
    SHA1M  Q19, S28, V6.4S
    SHA1SU1  V13.4S, V2.4S
    SHA1P  Q23, S26, V17.4S
    SHA256H  Q12, Q14, V13.4S
    SHA256H  Q9, Q22, V23.4S
    SHA1SU1  V13.4S, V20.4S
    SHA256H2  Q24, Q7, V17.4S
    SHA1SU1  V30.4S, V28.4S
    SHA1C  Q6, S27, V2.4S
    SHA1P  Q2, S6, V1.4S
    SHA1M  Q14, S13, V20.4S
    SHA256SU1  V22.4S, V30.4S, V2.4S
    SHA1P  Q6, S24, V15.4S
    SHA1SU0  V28.4S, V19.4S, V6.4S
    SHA256H  Q6, Q30, V9.4S
    SHA256SU1  V31.4S, V28.4S, V29.4S
    SHA1C  Q23, S14, V22.4S
    SHA1SU1  V2.4S, V5.4S
    SHA1SU0  V19.4S, V3.4S, V12.4S
    SHA256H2  Q20, Q23, V2.4S
    SHA1P  Q5, S31, V12.4S
    SHA1SU0  V26.4S, V6.4S, V12.4S
    SHA1C  Q13, S20, V12.4S
    SHA256SU1  V7.4S, V24.4S, V26.4S
    SHA1C  Q12, S5, V24.4S
    SHA1SU1  V5.4S, V13.4S
    SHA256H  Q2, Q7, V22.4S
    SHA1P  Q24, S5, V29.4S
    SHA1M  Q6, S19, V12.4S
    SHA256SU0  V19.4S, V3.4S
    SHA256H2  Q9, Q2, V6.4S
    SHA256H  Q22, Q6, V26.4S
    SHA1P  Q14, S22, V12.4S
    SHA256H  Q23, Q22, V25.4S
    SHA1C  Q2, S23, V19.4S
    SHA1C  Q6, S14, V16.4S
    SHA256H2  Q25, Q2, V23.4S
    SHA1P  Q13, S24, V9.4S
    SHA1C  Q19, S25, V13.4S
    SHA1M  Q3, S22, V4.4S
    SHA1SU0  V25.4S, V26.4S, V11.4S
    SHA256H2  Q29, Q6, V22.4S
    SHA256H  Q27, Q9, V5.4S
    SHA1SU0  V7.4S, V20.4S, V22.4S
    SHA1M  Q1, S3, V19.4S
    SHA256SU1  V27.4S, V1.4S, V22.4S
    SHA256SU1  V11.4S, V18.4S, V18.4S
    SHA1SU0  V18.4S, V0.4S, V16.4S
    SHA256SU0  V4.4S, V6.4S
    SHA256SU1  V5.4S, V26.4S, V19.4S
    SHA1M  Q18, S29, V2.4S
    SHA256H2  Q12, Q31, V5.4S
    SHA1SU1  V24.4S, V28.4S
    SHA1SU0  V30.4S, V7.4S, V1.4S
    SHA1P  Q14, S16, V5.4S
    SHA1SU0  V23.4S, V24.4S, V27.4S
    SHA1M  Q31, S12, V14.4S
    SHA1SU1  V31.4S, V23.4S
    SHA1M  Q5, S13, V4.4S
    SHA1C  Q24, S25, V25.4S
    SHA256SU1  V22.4S, V5.4S, V30.4S
    SHA256H2  Q23, Q5, V24.4S
    SHA256H2  Q19, Q23, V28.4S
    SHA1SU0  V28.4S, V24.4S, V31.4S
    SHA256H2  Q23, Q27, V30.4S
    SHA1P  Q29, S18, V22.4S
    SHA1P  Q13, S13, V11.4S
    SHA1C  Q6, S28, V23.4S
    SHA256SU1  V12.4S, V13.4S, V19.4S
    SHA256H  Q0, Q18, V20.4S
    SHA256SU0  V1.4S, V0.4S
    SHA256SU1  V31.4S, V1.4S, V29.4S
    SHA1SU1  V26.4S, V17.4S
    SHA256SU0  V9.4S, V31.4S
    SHA256H2  Q17, Q12, V9.4S
    SHA256SU1  V20.4S, V26.4S, V19.4S
    SHA1C  Q23, S20, V25.4S
    SHA256SU0  V25.4S, V11.4S
    SHA1SU0  V30.4S, V23.4S, V19.4S
    SHA1SU1  V31.4S, V6.4S
    SHA1C  Q19, S19, V1.4S
    SHA1P  Q6, S13, V25.4S
    SHA1M  Q24, S9, V23.4S
    SHA256H2  Q1, Q31, V9.4S
    SHA256H2  Q16, Q24, V1.4S
    SHA256SU0  V0.4S, V23.4S
    SHA256SU0  V24.4S, V16.4S
    SHA256SU1  V16.4S, V6.4S, V30.4S
    SHA1C  Q18, S16, V6.4S
    SHA256SU0  V26.4S, V18.4S
    SHA256H  Q31, Q0, V0.4S
    SHA1SU0  V9.4S, V26.4S, V31.4S
    SHA1SU0  V26.4S, V24.4S, V24.4S
    SHA256H2  Q0, Q26, V9.4S
    SHA256SU1  V8.4S, V16.4S, V17.4S
    SHA256H2  Q3, Q0, V0.4S
    SHA256SU0  V13.4S, V27.4S
    SHA1SU0  V20.4S, V8.4S, V15.4S
    SHA1SU0  V23.4S, V20.4S, V3.4S
    SHA256H2  Q8, Q13, V19.4S
    SHA256H2  Q1, Q23, V24.4S
    SHA256H2  Q0, Q0, V17.4S
    SHA1SU1  V20.4S, V4.4S
    SHA256SU1  V17.4S, V6.4S, V24.4S
    SHA256SU0  V6.4S, V3.4S
    SHA1C  Q30, S19, V11.4S
    SHA1M  Q18, S1, V12.4S
    SHA1M  Q24, S7, V27.4S
    SHA1SU0  V28.4S, V31.4S, V20.4S
    SHA1SU0  V4.4S, V10.4S, V23.4S
    SHA256H2  Q30, Q6, V8.4S
    SHA1C  Q20, S30, V28.4S
    SHA256H2  Q31, Q7, V18.4S
    SHA256SU0  V15.4S, V17.4S
    SHA256SU1  V2.4S, V11.4S, V31.4S
    SHA256H2  Q16, Q15, V24.4S
    SHA256SU1  V23.4S, V4.4S, V16.4S
    SHA1C  Q26, S5, V20.4S
    SHA1M  Q10, S23, V9.4S
    SHA1SU1  V29.4S, V10.4S
    SHA1P  Q12, S8, V0.4S
    SHA1C  Q1, S26, V7.4S
    SHA1P  Q11, S1, V1.4S
    SHA256SU0  V19.4S, V2.4S
    SHA256SU0  V31.4S, V30.4S
    SHA1SU1  V6.4S, V12.4S
    SHA1M  Q5, S12, V11.4S
    SHA256H2  Q26, Q0, V31.4S
    SHA1P  Q15, S5, V9.4S
    SHA1M  Q23, S6, V15.4S
    SHA1SU0  V20.4S, V23.4S, V5.4S
    SHA256SU1  V24.4S, V26.4S, V3.4S
    SHA1SU1  V5.4S, V25.4S
    SHA256SU0  V9.4S, V5.4S
    SHA256H  Q16, Q26, V29.4S
    SHA256H  Q2, Q16, V20.4S
    SHA256H2  Q20, Q2, V2.4S
    SHA1SU1  V25.4S, V1.4S
    SHA1P  Q8, S3, V24.4S
    SHA1SU1  V5.4S, V28.4S
    SHA1P  Q24, S9, V9.4S
    SHA256H  Q16, Q12, V23.4S
    SHA256SU1  V3.4S, V24.4S, V25.4S
    SHA256H2  Q2, Q8, V1.4S
    SHA1SU0  V29.4S, V5.4S, V31.4S
    SHA1P  Q12, S20, V3.4S
    SHA256H2  Q11, Q29, V17.4S
    SHA1M  Q7, S14, V12.4S
    SHA256H  Q28, Q19, V16.4S
    SHA1C  Q19, S2, V25.4S
    SHA256H2  Q24, Q12, V5.4S
    SUBS  X26, X26, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_14
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X3, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X3, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X3, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X3, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X3, X9, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X3, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X3, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X3, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X3, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X3, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X3, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X3, X9, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X3, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X3, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X3, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X3, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MRS  X9, FPSR
    MOVZ  X3, #0x0, LSL #0
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V0.D[1]
    MOVZ  X3, #0x5b5e, LSL #0
    MOVK  X3, #0x13c8, LSL #16
    MOVK  X3, #0xd2cd, LSL #32
    MOVK  X3, #0xc7bf, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D0
    MOVZ  X3, #0x7bbb, LSL #0
    MOVK  X3, #0x7451, LSL #16
    MOVK  X3, #0xd910, LSL #32
    MOVK  X3, #0x9f25, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V1.D[1]
    MOVZ  X3, #0x40c2, LSL #0
    MOVK  X3, #0xa0a6, LSL #16
    MOVK  X3, #0xd1c7, LSL #32
    MOVK  X3, #0x7621, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D1
    MOVZ  X3, #0xe05f, LSL #0
    MOVK  X3, #0x78a1, LSL #16
    MOVK  X3, #0xbdcc, LSL #32
    MOVK  X3, #0xecd7, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X3, #0xc4a7, LSL #0
    MOVK  X3, #0x43f4, LSL #16
    MOVK  X3, #0x9527, LSL #32
    MOVK  X3, #0xc52e, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D2
    MOVZ  X3, #0x8335, LSL #0
    MOVK  X3, #0xf07d, LSL #16
    MOVK  X3, #0xd5c0, LSL #32
    MOVK  X3, #0x6ac6, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X3, #0x6ee6, LSL #0
    MOVK  X3, #0xf0b, LSL #16
    MOVK  X3, #0x5e8a, LSL #32
    MOVK  X3, #0x2b0e, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D3
    MOVZ  X3, #0xe0a, LSL #0
    MOVK  X3, #0x310b, LSL #16
    MOVK  X3, #0x303c, LSL #32
    MOVK  X3, #0xa1cb, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X3, #0xa0a8, LSL #0
    MOVK  X3, #0x29e7, LSL #16
    MOVK  X3, #0x3ee7, LSL #32
    MOVK  X3, #0x2c1f, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D4
    MOVZ  X3, #0xd836, LSL #0
    MOVK  X3, #0x751, LSL #16
    MOVK  X3, #0xa384, LSL #32
    MOVK  X3, #0xf9c5, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V5.D[1]
    MOVZ  X3, #0x937f, LSL #0
    MOVK  X3, #0x1033, LSL #16
    MOVK  X3, #0xc87b, LSL #32
    MOVK  X3, #0xd250, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D5
    MOVZ  X3, #0x6092, LSL #0
    MOVK  X3, #0x5219, LSL #16
    MOVK  X3, #0x2a78, LSL #32
    MOVK  X3, #0x7cad, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X3, #0x57f1, LSL #0
    MOVK  X3, #0x895f, LSL #16
    MOVK  X3, #0x605, LSL #32
    MOVK  X3, #0xd081, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D6
    MOVZ  X3, #0xb065, LSL #0
    MOVK  X3, #0xefd, LSL #16
    MOVK  X3, #0x5cb8, LSL #32
    MOVK  X3, #0x8dcb, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V7.D[1]
    MOVZ  X3, #0xd0e5, LSL #0
    MOVK  X3, #0xb34f, LSL #16
    MOVK  X3, #0x9230, LSL #32
    MOVK  X3, #0x754f, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D7
    MOVZ  X3, #0x8d3b, LSL #0
    MOVK  X3, #0x8f03, LSL #16
    MOVK  X3, #0xd9c8, LSL #32
    MOVK  X3, #0x1aee, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X3, #0x1f65, LSL #0
    MOVK  X3, #0xe23c, LSL #16
    MOVK  X3, #0x42d5, LSL #32
    MOVK  X3, #0x930, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D8
    MOVZ  X3, #0x772f, LSL #0
    MOVK  X3, #0x5226, LSL #16
    MOVK  X3, #0xf1ee, LSL #32
    MOVK  X3, #0x63c4, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V9.D[1]
    MOVZ  X3, #0xab9e, LSL #0
    MOVK  X3, #0x551b, LSL #16
    MOVK  X3, #0xe8e8, LSL #32
    MOVK  X3, #0x6900, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D9
    MOVZ  X3, #0x5151, LSL #0
    MOVK  X3, #0xc12b, LSL #16
    MOVK  X3, #0x5437, LSL #32
    MOVK  X3, #0xeef9, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X3, #0x77b2, LSL #0
    MOVK  X3, #0x6ac3, LSL #16
    MOVK  X3, #0xe160, LSL #32
    MOVK  X3, #0x7817, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D10
    MOVZ  X3, #0x8d3e, LSL #0
    MOVK  X3, #0xf0c7, LSL #16
    MOVK  X3, #0x38e7, LSL #32
    MOVK  X3, #0xe29b, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V11.D[1]
    MOVZ  X3, #0xe47d, LSL #0
    MOVK  X3, #0x271d, LSL #16
    MOVK  X3, #0x1903, LSL #32
    MOVK  X3, #0xcc89, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D11
    MOVZ  X3, #0x33af, LSL #0
    MOVK  X3, #0xed9c, LSL #16
    MOVK  X3, #0x4da9, LSL #32
    MOVK  X3, #0x3c4a, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V12.D[1]
    MOVZ  X3, #0xacb9, LSL #0
    MOVK  X3, #0xe61f, LSL #16
    MOVK  X3, #0x71e2, LSL #32
    MOVK  X3, #0xddf7, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D12
    MOVZ  X3, #0xf24, LSL #0
    MOVK  X3, #0xa222, LSL #16
    MOVK  X3, #0x6b3c, LSL #32
    MOVK  X3, #0x69f9, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V13.D[1]
    MOVZ  X3, #0xf239, LSL #0
    MOVK  X3, #0x2b87, LSL #16
    MOVK  X3, #0x1d4c, LSL #32
    MOVK  X3, #0xdc08, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D13
    MOVZ  X3, #0x3fd0, LSL #0
    MOVK  X3, #0x14cb, LSL #16
    MOVK  X3, #0x208a, LSL #32
    MOVK  X3, #0xf1c6, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X3, #0x6b8a, LSL #0
    MOVK  X3, #0x2309, LSL #16
    MOVK  X3, #0xffd, LSL #32
    MOVK  X3, #0xb7c6, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D14
    MOVZ  X3, #0x7088, LSL #0
    MOVK  X3, #0x62e3, LSL #16
    MOVK  X3, #0xf6cf, LSL #32
    MOVK  X3, #0xbfce, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X3, #0x6023, LSL #0
    MOVK  X3, #0x6be, LSL #16
    MOVK  X3, #0xb114, LSL #32
    MOVK  X3, #0x1ecf, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D15
    MOVZ  X3, #0x5c0a, LSL #0
    MOVK  X3, #0x1118, LSL #16
    MOVK  X3, #0x61c, LSL #32
    MOVK  X3, #0xa7b7, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X3, #0x3a1f, LSL #0
    MOVK  X3, #0xcb17, LSL #16
    MOVK  X3, #0x7be8, LSL #32
    MOVK  X3, #0x3f0c, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D16
    MOVZ  X3, #0x8486, LSL #0
    MOVK  X3, #0xdb12, LSL #16
    MOVK  X3, #0x89e7, LSL #32
    MOVK  X3, #0x2f8f, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V17.D[1]
    MOVZ  X3, #0x1e61, LSL #0
    MOVK  X3, #0xcbfb, LSL #16
    MOVK  X3, #0x6ede, LSL #32
    MOVK  X3, #0x34b0, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D17
    MOVZ  X3, #0xbcc9, LSL #0
    MOVK  X3, #0xafcc, LSL #16
    MOVK  X3, #0x5c, LSL #32
    MOVK  X3, #0x5d30, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V18.D[1]
    MOVZ  X3, #0xdbbf, LSL #0
    MOVK  X3, #0xdc3c, LSL #16
    MOVK  X3, #0x604a, LSL #32
    MOVK  X3, #0x4398, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D18
    MOVZ  X3, #0x53ea, LSL #0
    MOVK  X3, #0x1d0b, LSL #16
    MOVK  X3, #0x1fbb, LSL #32
    MOVK  X3, #0x3297, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V19.D[1]
    MOVZ  X3, #0x4692, LSL #0
    MOVK  X3, #0xe66e, LSL #16
    MOVK  X3, #0xfea, LSL #32
    MOVK  X3, #0x28c, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D19
    MOVZ  X3, #0x40cb, LSL #0
    MOVK  X3, #0xcd8, LSL #16
    MOVK  X3, #0xb951, LSL #32
    MOVK  X3, #0x5625, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V20.D[1]
    MOVZ  X3, #0xd86e, LSL #0
    MOVK  X3, #0x44af, LSL #16
    MOVK  X3, #0xbb77, LSL #32
    MOVK  X3, #0x4e9, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D20
    MOVZ  X3, #0x91, LSL #0
    MOVK  X3, #0x9cac, LSL #16
    MOVK  X3, #0x97b5, LSL #32
    MOVK  X3, #0xed0e, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X3, #0xf1be, LSL #0
    MOVK  X3, #0x48eb, LSL #16
    MOVK  X3, #0xcee, LSL #32
    MOVK  X3, #0x156b, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D21
    MOVZ  X3, #0xf1a7, LSL #0
    MOVK  X3, #0x5f24, LSL #16
    MOVK  X3, #0xe2cf, LSL #32
    MOVK  X3, #0x7e0f, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V22.D[1]
    MOVZ  X3, #0x5d2c, LSL #0
    MOVK  X3, #0x9091, LSL #16
    MOVK  X3, #0x4e55, LSL #32
    MOVK  X3, #0x1060, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D22
    MOVZ  X3, #0x22b4, LSL #0
    MOVK  X3, #0xc915, LSL #16
    MOVK  X3, #0x7400, LSL #32
    MOVK  X3, #0xda97, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X3, #0xaf20, LSL #0
    MOVK  X3, #0xdd29, LSL #16
    MOVK  X3, #0x2802, LSL #32
    MOVK  X3, #0xf157, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D23
    MOVZ  X3, #0x47a2, LSL #0
    MOVK  X3, #0x18ea, LSL #16
    MOVK  X3, #0xf3ee, LSL #32
    MOVK  X3, #0xcd0, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V24.D[1]
    MOVZ  X3, #0x2f51, LSL #0
    MOVK  X3, #0xf13a, LSL #16
    MOVK  X3, #0x41a3, LSL #32
    MOVK  X3, #0x394, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D24
    MOVZ  X3, #0xad1, LSL #0
    MOVK  X3, #0xd3c7, LSL #16
    MOVK  X3, #0x649b, LSL #32
    MOVK  X3, #0x141c, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X3, #0xe440, LSL #0
    MOVK  X3, #0x116b, LSL #16
    MOVK  X3, #0xe16, LSL #32
    MOVK  X3, #0x4fa9, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D25
    MOVZ  X3, #0xb2f, LSL #0
    MOVK  X3, #0x679e, LSL #16
    MOVK  X3, #0xae12, LSL #32
    MOVK  X3, #0x3fae, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X3, #0x3fcb, LSL #0
    MOVK  X3, #0x3f0, LSL #16
    MOVK  X3, #0x563d, LSL #32
    MOVK  X3, #0x9886, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D26
    MOVZ  X3, #0x8440, LSL #0
    MOVK  X3, #0xabee, LSL #16
    MOVK  X3, #0x1594, LSL #32
    MOVK  X3, #0x228a, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V27.D[1]
    MOVZ  X3, #0x950a, LSL #0
    MOVK  X3, #0xa3e0, LSL #16
    MOVK  X3, #0x853d, LSL #32
    MOVK  X3, #0xd550, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D27
    MOVZ  X3, #0x58f9, LSL #0
    MOVK  X3, #0x582f, LSL #16
    MOVK  X3, #0x171e, LSL #32
    MOVK  X3, #0x24c2, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V28.D[1]
    MOVZ  X3, #0x5be3, LSL #0
    MOVK  X3, #0x4d6d, LSL #16
    MOVK  X3, #0x4fef, LSL #32
    MOVK  X3, #0x709b, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D28
    MOVZ  X3, #0x7cf9, LSL #0
    MOVK  X3, #0xf098, LSL #16
    MOVK  X3, #0x8d68, LSL #32
    MOVK  X3, #0x8bda, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X3, #0xa14b, LSL #0
    MOVK  X3, #0x301e, LSL #16
    MOVK  X3, #0x3aef, LSL #32
    MOVK  X3, #0x1856, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D29
    MOVZ  X3, #0x1b34, LSL #0
    MOVK  X3, #0xd8ec, LSL #16
    MOVK  X3, #0x1ce0, LSL #32
    MOVK  X3, #0x437a, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V30.D[1]
    MOVZ  X3, #0x74e4, LSL #0
    MOVK  X3, #0x83d9, LSL #16
    MOVK  X3, #0xe9b5, LSL #32
    MOVK  X3, #0x5654, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D30
    MOVZ  X3, #0xdc73, LSL #0
    MOVK  X3, #0xfddd, LSL #16
    MOVK  X3, #0x2273, LSL #32
    MOVK  X3, #0x8edb, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, V31.D[1]
    MOVZ  X3, #0xcb2d, LSL #0
    MOVK  X3, #0x9377, LSL #16
    MOVK  X3, #0xb089, LSL #32
    MOVK  X3, #0x1440, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail
    FMOV  X9, D31
    MOVZ  X3, #0xe47, LSL #0
    MOVK  X3, #0xf53f, LSL #16
    MOVK  X3, #0x1e05, LSL #32
    MOVK  X3, #0x54c, LSL #48
    SUB  X23, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSecureHashStandard_TestFail

TSRTAdvsimdVectorSecureHashStandard_TestEnd:
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
TSRTAdvsimdVectorSecureHashStandard_TestFail:
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
