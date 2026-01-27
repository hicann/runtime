.global TSRTAdvsimdVectorFloatingPointConvertToInteger

.text
.p2align 4

TSRTAdvsimdVectorFloatingPointConvertToInteger:

TSRTAdvsimdVectorFloatingPointConvertToInteger_TestBegin:
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
    MOVZ  X2, #0xc271, LSL #0
    MOVK  X2, #0xc297, LSL #16
    MOVK  X2, #0xa788, LSL #32
    MOVK  X2, #0x3712, LSL #48
    MOVZ  X3, #0x5043, LSL #0
    MOVK  X3, #0x4d64, LSL #16
    MOVK  X3, #0x2ca3, LSL #32
    MOVK  X3, #0xb804, LSL #48
    MOVZ  X6, #0xe784, LSL #0
    MOVK  X6, #0x5599, LSL #16
    MOVK  X6, #0xc962, LSL #32
    MOVK  X6, #0xa74, LSL #48
    MOVZ  X7, #0x26fd, LSL #0
    MOVK  X7, #0xedab, LSL #16
    MOVK  X7, #0x2ee0, LSL #32
    MOVK  X7, #0x23c1, LSL #48
    MOVZ  X8, #0x5ce3, LSL #0
    MOVK  X8, #0x2dd0, LSL #16
    MOVK  X8, #0x1427, LSL #32
    MOVK  X8, #0x10ee, LSL #48
    MOVZ  X9, #0x754f, LSL #0
    MOVK  X9, #0xbb0b, LSL #16
    MOVK  X9, #0x1738, LSL #32
    MOVK  X9, #0xef4c, LSL #48
    MOVZ  X10, #0x204d, LSL #0
    MOVK  X10, #0x9b8c, LSL #16
    MOVK  X10, #0xd21b, LSL #32
    MOVK  X10, #0xeac2, LSL #48
    MOVZ  X11, #0xa0cc, LSL #0
    MOVK  X11, #0xfc36, LSL #16
    MOVK  X11, #0x407e, LSL #32
    MOVK  X11, #0xc1d9, LSL #48
    MOVZ  X13, #0x8d86, LSL #0
    MOVK  X13, #0x5a0e, LSL #16
    MOVK  X13, #0x7c4c, LSL #32
    MOVK  X13, #0x2819, LSL #48
    MOVZ  X14, #0xa7f2, LSL #0
    MOVK  X14, #0xb57, LSL #16
    MOVK  X14, #0xbdb5, LSL #32
    MOVK  X14, #0x899f, LSL #48
    MOVZ  X15, #0x6159, LSL #0
    MOVK  X15, #0xe3fe, LSL #16
    MOVK  X15, #0xcd50, LSL #32
    MOVK  X15, #0x740d, LSL #48
    MOVZ  X16, #0x5096, LSL #0
    MOVK  X16, #0xf071, LSL #16
    MOVK  X16, #0x6f4f, LSL #32
    MOVK  X16, #0x916a, LSL #48
    MOVZ  X17, #0xb0ff, LSL #0
    MOVK  X17, #0x6eb, LSL #16
    MOVK  X17, #0xb181, LSL #32
    MOVK  X17, #0xbc0a, LSL #48
    MOVZ  X19, #0xc30a, LSL #0
    MOVK  X19, #0xfc96, LSL #16
    MOVK  X19, #0xbc2d, LSL #32
    MOVK  X19, #0x67ba, LSL #48
    MOVZ  X20, #0xd286, LSL #0
    MOVK  X20, #0xf285, LSL #16
    MOVK  X20, #0xbbf, LSL #32
    MOVK  X20, #0xf549, LSL #48
    MOVZ  X21, #0xd6d0, LSL #0
    MOVK  X21, #0xe580, LSL #16
    MOVK  X21, #0x1306, LSL #32
    MOVK  X21, #0xa26e, LSL #48
    MOVZ  X22, #0x7bf4, LSL #0
    MOVK  X22, #0x25f3, LSL #16
    MOVK  X22, #0x4972, LSL #32
    MOVK  X22, #0xee21, LSL #48
    MOVZ  X23, #0xfb5b, LSL #0
    MOVK  X23, #0x8d43, LSL #16
    MOVK  X23, #0x7c28, LSL #32
    MOVK  X23, #0xb112, LSL #48
    MOVZ  X24, #0x6bd9, LSL #0
    MOVK  X24, #0xf11e, LSL #16
    MOVK  X24, #0xf569, LSL #32
    MOVK  X24, #0xb43e, LSL #48
    MOVZ  X25, #0xfe8d, LSL #0
    MOVK  X25, #0x907e, LSL #16
    MOVK  X25, #0x691b, LSL #32
    MOVK  X25, #0xe4e6, LSL #48
    MOVZ  X26, #0xb221, LSL #0
    MOVK  X26, #0xf256, LSL #16
    MOVK  X26, #0xe74a, LSL #32
    MOVK  X26, #0x5d57, LSL #48
    MOVZ  X27, #0x768d, LSL #0
    MOVK  X27, #0x5d05, LSL #16
    MOVK  X27, #0x3925, LSL #32
    MOVK  X27, #0x7f39, LSL #48
    MOVZ  X28, #0x7725, LSL #0
    MOVK  X28, #0x8cc3, LSL #16
    MOVK  X28, #0xa015, LSL #32
    MOVK  X28, #0xfc0c, LSL #48
    MOVZ  X29, #0x13f8, LSL #0
    MOVK  X29, #0x89f9, LSL #16
    MOVK  X29, #0xc0ca, LSL #32
    MOVK  X29, #0xf236, LSL #48
    MOVZ  X21, #0x96ce, LSL #0
    MOVK  X21, #0xf616, LSL #16
    MOVK  X21, #0xdd05, LSL #32
    MOVK  X21, #0x6053, LSL #48
    MSR  FPCR, X21
    MOVZ  X21, #0x8399, LSL #0
    MOVK  X21, #0xa258, LSL #16
    MOVK  X21, #0xb2b6, LSL #32
    MOVK  X21, #0x8ccd, LSL #48
    MSR  FPSR, X21
    MRS  X17, FPSR
    MOVZ  X24, #0xff60, LSL #0
    MOVK  X24, #0x7ff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    AND  X17, X17, X24
    MOVZ  X24, #0x0, LSL #0
    ORR  X17, X17, X24
    MSR  FPSR, X17
    ISB  SY
    SUBS  W27, W7, W6, UXTX #4
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x62db, LSL #0
    MOVK  X2, #0x32b9, LSL #16
    MOVK  X2, #0xf20a, LSL #32
    MOVK  X2, #0xef6, LSL #48
    MOVZ  X3, #0x302d, LSL #0
    MOVK  X3, #0x65eb, LSL #16
    MOVK  X3, #0x4f1e, LSL #32
    MOVK  X3, #0x556a, LSL #48
    MOVZ  X6, #0x82b9, LSL #0
    MOVK  X6, #0x72a2, LSL #16
    MOVK  X6, #0x6424, LSL #32
    MOVK  X6, #0xc966, LSL #48
    MOVZ  X7, #0x6a1b, LSL #0
    MOVK  X7, #0xef59, LSL #16
    MOVK  X7, #0xf714, LSL #32
    MOVK  X7, #0xdcde, LSL #48
    MOVZ  X8, #0x5005, LSL #0
    MOVK  X8, #0x32bd, LSL #16
    MOVK  X8, #0x3c87, LSL #32
    MOVK  X8, #0x6439, LSL #48
    MOVZ  X9, #0x3ea0, LSL #0
    MOVK  X9, #0xd0b5, LSL #16
    MOVK  X9, #0x685, LSL #32
    MOVK  X9, #0x119, LSL #48
    MOVZ  X10, #0x5af6, LSL #0
    MOVK  X10, #0xc6ab, LSL #16
    MOVK  X10, #0x1168, LSL #32
    MOVK  X10, #0xd157, LSL #48
    MOVZ  X11, #0x853f, LSL #0
    MOVK  X11, #0x528c, LSL #16
    MOVK  X11, #0x2519, LSL #32
    MOVK  X11, #0x72a5, LSL #48
    MOVZ  X13, #0xb156, LSL #0
    MOVK  X13, #0x78b1, LSL #16
    MOVK  X13, #0x57a0, LSL #32
    MOVK  X13, #0x47d9, LSL #48
    MOVZ  X14, #0x8c28, LSL #0
    MOVK  X14, #0x9b86, LSL #16
    MOVK  X14, #0x775a, LSL #32
    MOVK  X14, #0x678e, LSL #48
    MOVZ  X15, #0xa43, LSL #0
    MOVK  X15, #0xb6f8, LSL #16
    MOVK  X15, #0x9499, LSL #32
    MOVK  X15, #0x3d21, LSL #48
    MOVZ  X16, #0xf809, LSL #0
    MOVK  X16, #0x261, LSL #16
    MOVK  X16, #0x49cc, LSL #32
    MOVK  X16, #0xb860, LSL #48
    MOVZ  X17, #0xd74f, LSL #0
    MOVK  X17, #0xa5a7, LSL #16
    MOVK  X17, #0x22de, LSL #32
    MOVK  X17, #0x9ee8, LSL #48
    MOVZ  X19, #0xfad9, LSL #0
    MOVK  X19, #0xdf14, LSL #16
    MOVK  X19, #0xf484, LSL #32
    MOVK  X19, #0x9542, LSL #48
    MOVZ  X20, #0xadda, LSL #0
    MOVK  X20, #0xcafa, LSL #16
    MOVK  X20, #0x64fb, LSL #32
    MOVK  X20, #0x93ef, LSL #48
    MOVZ  X21, #0xe425, LSL #0
    MOVK  X21, #0xd8e4, LSL #16
    MOVK  X21, #0x15af, LSL #32
    MOVK  X21, #0x9ae5, LSL #48
    MOVZ  X22, #0x544e, LSL #0
    MOVK  X22, #0xf88c, LSL #16
    MOVK  X22, #0xd107, LSL #32
    MOVK  X22, #0xe467, LSL #48
    MOVZ  X23, #0x4eb, LSL #0
    MOVK  X23, #0xe48a, LSL #16
    MOVK  X23, #0xa596, LSL #32
    MOVK  X23, #0xa613, LSL #48
    MOVZ  X24, #0x9917, LSL #0
    MOVK  X24, #0xcf97, LSL #16
    MOVK  X24, #0x963b, LSL #32
    MOVK  X24, #0xbce4, LSL #48
    MOVZ  X25, #0xda5e, LSL #0
    MOVK  X25, #0x95d0, LSL #16
    MOVK  X25, #0xfde9, LSL #32
    MOVK  X25, #0x4166, LSL #48
    MOVZ  X26, #0xff0f, LSL #0
    MOVK  X26, #0x36da, LSL #16
    MOVK  X26, #0xcdf, LSL #32
    MOVK  X26, #0x36ff, LSL #48
    MOVZ  X27, #0x22dc, LSL #0
    MOVK  X27, #0xfce9, LSL #16
    MOVK  X27, #0xe806, LSL #32
    MOVK  X27, #0xbce6, LSL #48
    MOVZ  X28, #0x4d7f, LSL #0
    MOVK  X28, #0xf0a, LSL #16
    MOVK  X28, #0xa75f, LSL #32
    MOVK  X28, #0x1c6f, LSL #48
    MOVZ  X29, #0xa706, LSL #0
    MOVK  X29, #0xd812, LSL #16
    MOVK  X29, #0x1662, LSL #32
    MOVK  X29, #0xb36b, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X25
    FMOV  D1, X26
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X10
    FMOV  D3, X16
    FMOV  V3.D[1], X25
    FMOV  D4, X27
    FMOV  V4.D[1], X13
    FMOV  D5, X25
    FMOV  V5.D[1], X6
    FMOV  D6, X15
    FMOV  V6.D[1], X27
    FMOV  D7, X28
    FMOV  V7.D[1], X28
    FMOV  D8, X10
    FMOV  V8.D[1], X2
    FMOV  D9, X9
    FMOV  V9.D[1], X10
    FMOV  D10, X17
    FMOV  V10.D[1], X2
    FMOV  D11, X16
    FMOV  V11.D[1], X3
    FMOV  D12, X17
    FMOV  V12.D[1], X7
    FMOV  D13, X14
    FMOV  V13.D[1], X20
    FMOV  D14, X22
    FMOV  V14.D[1], X11
    FMOV  D15, X26
    FMOV  V15.D[1], X26
    FMOV  D16, X2
    FMOV  V16.D[1], X14
    FMOV  D17, X10
    FMOV  V17.D[1], X24
    FMOV  D18, X13
    FMOV  V18.D[1], X2
    FMOV  D19, X14
    FMOV  V19.D[1], X27
    FMOV  D20, X17
    FMOV  V20.D[1], X7
    FMOV  D21, X23
    FMOV  V21.D[1], X9
    FMOV  D22, X9
    FMOV  V22.D[1], X26
    FMOV  D23, X3
    FMOV  V23.D[1], X16
    FMOV  D24, X20
    FMOV  V24.D[1], X17
    FMOV  D25, X6
    FMOV  V25.D[1], X19
    FMOV  D26, X26
    FMOV  V26.D[1], X23
    FMOV  D27, X20
    FMOV  V27.D[1], X20
    FMOV  D28, X7
    FMOV  V28.D[1], X21
    FMOV  D29, X24
    FMOV  V29.D[1], X29
    FMOV  D30, X10
    FMOV  V30.D[1], X24
    FMOV  D31, X17
    FMOV  V31.D[1], X10
    MOVZ  X20, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_0:
    FCVTZS  V30.4S, V28.4S
    FCVTZS  V8.2S, V27.2S, #7
    FRINTZ  V11.2D, V30.2D
    FCVTNU  V27.2S, V11.2S
    FCVTPU  V15.2D, V8.2D
    FCVTMU  V24.8H, V15.8H
    FCVTZS  V12.4S, V27.4S
    FRINTN  V10.8H, V25.8H
    FCVTL  V23.2D, V31.2S
    FRINTN  V26.4S, V23.4S
    FCVTZU  V21.2D, V24.2D
    FRINTX  V26.2S, V12.2S
    FCVTZS  V22.4S, V10.4S
    FCVTZS  V5.2S, V29.2S, #32
    FCVTAS  V30.4H, V23.4H
    FRINTM  V0.4S, V21.4S
    FRINTN  V2.2S, V15.2S
    FCVTNS  V3.2S, V26.2S
    FRINTA  V27.2D, V3.2D
    FCVTAS  V13.4H, V22.4H
    FRINTA  V3.4S, V13.4S
    FCVTAS  V8.8H, V3.8H
    FRINTZ  V26.8H, V8.8H
    FRINTZ  V3.2S, V0.2S
    FCVTAU  V24.2D, V5.2D
    FRINTA  V22.4H, V26.4H
    FCVTMS  V12.8H, V24.8H
    FCVTNU  V8.8H, V3.8H
    FRINTN  V10.4H, V27.4H
    FCVTPS  V5.4H, V10.4H
    FCVTZU  V29.4H, V22.4H
    FCVTXN2  V27.4S, V2.2D
    FRINTZ  V15.8H, V12.8H
    FRINTP  V26.4H, V16.4H
    FRINTM  V10.2D, V8.2D
    FRINTI  V3.4S, V10.4S
    FCVTAS  V0.4H, V30.4H
    FCVTZU V12.2D, V0.2D, #43
    FCVTZU  V2.8H, V12.8H
    FCVTN2  V24.8H, V3.4S
    FCVTNS  V13.2S, V24.2S
    FCVTAU  V12.8H, V5.8H
    FCVTXN2  V23.4S, V2.2D
    FCVTPS  V0.4H, V13.4H
    FCVTZU  V22.4S, V15.4S, #3
    FRINTP  V21.4H, V29.4H
    FRINTP  V29.4H, V21.4H
    FCVTN2  V16.4S, V20.2D
    FCVTPS  V15.8H, V22.8H
    FCVTZS  V10.4H, V12.4H, #15
    FCVTMU  V21.2D, V16.2D
    FCVTZU  V24.8H, V23.8H
    FCVTZS  V13.4H, V26.4H, #2
    FRINTP  V23.4H, V0.4H
    FCVTN2  V20.4S, V15.2D
    FCVTAS  V2.2D, V13.2D
    FCVTXN  V12.2S, V2.2D
    FCVTMS  V22.8H, V21.8H
    FCVTZS  V3.4S, V22.4S
    FRINTZ  V0.8H, V29.8H
    FRINTA  V13.4H, V10.4H
    FCVTZU  V16.4H, V13.4H
    FRINTM  V26.4H, V23.4H
    FCVTN  V10.4H, V3.4S
    FRINTA  V8.8H, V0.8H
    FCVTZU  V29.4S, V24.4S
    FCVTXN2  V2.4S, V29.2D
    FCVTZU  V3.8H, V10.8H
    FCVTZS  V22.4H, V12.4H
    FCVTXN  V15.2S, V0.2D
    FRINTP  V12.2S, V22.2S
    FCVTPU  V22.2S, V12.2S
    FRINTP  V10.8H, V15.8H
    FCVTN  V15.4H, V20.4S
    FCVTZU  V20.2S, V10.2S, #9
    FRINTP  V8.8H, V26.8H
    FCVTAS  V0.4H, V22.4H
    FCVTZU  V24.2S, V20.2S, #6
    FRINTX  V13.8H, V3.8H
    FRINTN  V3.2S, V8.2S
    FCVTAS  V26.2D, V0.2D
    FRINTP  V22.8H, V15.8H
    FCVTNU  V23.4S, V16.4S
    FCVTMU  V0.4H, V13.4H
    FCVTNS  V10.4H, V0.4H
    FRINTM  V16.8H, V10.8H
    FRINTP  V15.8H, V2.8H
    FCVTN  V12.2S, V22.2D
    FCVTAS  V8.8H, V12.8H
    FCVTZU V12.2D, V16.2D, #16
    FCVTNS  V16.2S, V3.2S
    FRINTA  V3.4S, V16.4S
    FCVTNS  V13.2D, V3.2D
    FCVTAU  V10.4S, V12.4S
    FCVTZS  V20.4S, V8.4S, #17
    FRINTM  V0.4H, V20.4H
    FRINTM  V20.2D, V13.2D
    FCVTAS  V12.4H, V20.4H
    FRINTP  V13.2D, V23.2D
    FRINTA  V23.4S, V26.4S
    FRINTX  V16.2D, V0.2D
    FRINTZ  V22.4S, V15.4S
    FCVTL2  V3.2D, V23.4S
    FRINTX  V23.8H, V22.8H
    FCVTMS  V20.4S, V24.4S
    FCVTL  V21.2D, V10.2S
    FCVTZS V8.2D, V12.2D, #2
    FCVTMS  V10.4S, V8.4S
    FCVTNS  V15.4H, V13.4H
    FCVTAU  V2.2S, V20.2S
    FCVTMS  V20.8H, V2.8H
    FCVTZS  V13.4S, V20.4S, #3
    FCVTNU  V8.4H, V15.4H
    FCVTL2  V15.2D, V8.4S
    FCVTZU  V22.8H, V16.8H
    FCVTN2  V26.8H, V22.4S
    FCVTZU  V0.4H, V26.4H, #14
    FCVTZS  V16.8H, V15.8H
    FCVTZS  V12.4H, V0.4H
    FCVTZU  V0.4S, V13.4S, #28
    FCVTMU  V8.8H, V10.8H
    FCVTL  V10.2D, V3.2S
    FCVTAU  V20.2S, V16.2S
    FCVTZU  V24.4H, V0.4H
    FCVTMU  V0.2D, V21.2D
    FCVTZU  V21.4S, V12.4S, #27
    FRINTI  V3.4H, V8.4H
    FCVTPU  V12.4H, V23.4H
    FCVTZS  V22.8H, V10.8H, #13
    FCVTZU  V2.8H, V0.8H
    FCVTZS  V8.4H, V20.4H
    FCVTZU V16.2D, V8.2D, #24
    FRINTM  V13.2S, V24.2S
    FCVTMU  V24.4H, V21.4H
    FCVTNU  V20.2D, V3.2D
    FRINTZ  V14.4H, V24.4H
    FRINTI  V23.4H, V20.4H
    FRINTX  V20.2D, V14.2D
    FCVTAS  V10.8H, V16.8H
    FRINTA  V16.2D, V13.2D
    FCVTN  V13.4H, V22.4S
    FCVTNS  V24.2S, V27.2S
    FCVTAU  V8.8H, V12.8H
    FCVTNU  V22.8H, V23.8H
    FRINTA  V0.4H, V20.4H
    FRINTZ  V12.2D, V24.2D
    FCVTMU  V27.2S, V12.2S
    FCVTN2  V14.8H, V0.4S
    FCVTZS  V12.2S, V2.2S, #20
    FCVTZS  V21.2D, V27.2D
    FCVTZS  V27.4H, V12.4H, #5
    FCVTZU  V2.8H, V27.8H
    FCVTN2  V0.4S, V14.2D
    FCVTZU  V24.4S, V13.4S
    FRINTP  V3.4H, V2.4H
    FCVTNU  V20.8H, V24.8H
    FCVTPU  V24.4H, V21.4H
    FRINTZ  V12.8H, V22.8H
    FCVTL  V22.4S, V8.4H
    FRINTA  V19.2D, V3.2D
    FRINTA  V23.4H, V19.4H
    FCVTMS  V13.4H, V23.4H
    FCVTZS  V23.8H, V22.8H, #13
    FCVTPS  V14.2D, V13.2D
    FRINTZ  V22.2S, V20.2S
    FRINTM  V2.8H, V22.8H
    FCVTMU  V8.2S, V23.2S
    FCVTN  V27.4H, V24.4S
    FCVTZS  V11.4S, V12.4S
    FCVTAS  V20.4H, V14.4H
    FCVTNS  V30.4H, V0.4H
    FCVTZS V0.2D, V8.2D, #24
    FRINTX  V3.8H, V2.8H
    FCVTMS  V24.4H, V20.4H
    FCVTMU  V8.4H, V11.4H
    FCVTAS  V21.4H, V0.4H
    FCVTMU  V19.2D, V27.2D
    FCVTXN  V22.2S, V30.2D
    FRINTI  V12.2D, V19.2D
    FRINTZ  V14.8H, V22.8H
    FCVTZS  V2.8H, V3.8H, #11
    FCVTZS  V13.2S, V8.2S
    FCVTNU  V0.4H, V2.4H
    FCVTN2  V27.8H, V24.4S
    FRINTZ  V16.8H, V14.8H
    FRINTN  V3.4S, V12.4S
    FCVTPS  V11.4H, V30.4H
    FCVTZS  V30.4H, V21.4H
    FCVTN2  V14.4S, V30.2D
    FRINTI  V22.2D, V16.2D
    FCVTNU  V20.4S, V10.4S
    FRINTN  V30.8H, V11.8H
    FCVTNS  V19.4H, V13.4H
    FCVTPS  V13.8H, V22.8H
    FCVTNS  V22.4H, V0.4H
    FCVTAU  V0.2S, V27.2S
    FCVTAS  V27.2S, V20.2S
    FRINTZ  V0.8H, V18.8H
    FCVTNS  V10.4H, V30.4H
    FRINTZ  V2.2D, V13.2D
    SUBS  X20, X20, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_0
    MOVZ  X8, #0x62db, LSL #0
    MOVK  X8, #0x32b9, LSL #16
    MOVK  X8, #0xf20a, LSL #32
    MOVK  X8, #0xef6, LSL #48
    SUB  X21, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x302d, LSL #0
    MOVK  X8, #0x65eb, LSL #16
    MOVK  X8, #0x4f1e, LSL #32
    MOVK  X8, #0x556a, LSL #48
    SUB  X21, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x82b9, LSL #0
    MOVK  X8, #0x72a2, LSL #16
    MOVK  X8, #0x6424, LSL #32
    MOVK  X8, #0xc966, LSL #48
    SUB  X21, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x6a1b, LSL #0
    MOVK  X8, #0xef59, LSL #16
    MOVK  X8, #0xf714, LSL #32
    MOVK  X8, #0xdcde, LSL #48
    SUB  X21, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x3ea0, LSL #0
    MOVK  X8, #0xd0b5, LSL #16
    MOVK  X8, #0x685, LSL #32
    MOVK  X8, #0x119, LSL #48
    SUB  X21, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x5af6, LSL #0
    MOVK  X8, #0xc6ab, LSL #16
    MOVK  X8, #0x1168, LSL #32
    MOVK  X8, #0xd157, LSL #48
    SUB  X21, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x853f, LSL #0
    MOVK  X8, #0x528c, LSL #16
    MOVK  X8, #0x2519, LSL #32
    MOVK  X8, #0x72a5, LSL #48
    SUB  X21, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0xb156, LSL #0
    MOVK  X8, #0x78b1, LSL #16
    MOVK  X8, #0x57a0, LSL #32
    MOVK  X8, #0x47d9, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x8c28, LSL #0
    MOVK  X8, #0x9b86, LSL #16
    MOVK  X8, #0x775a, LSL #32
    MOVK  X8, #0x678e, LSL #48
    SUB  X21, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0xa43, LSL #0
    MOVK  X8, #0xb6f8, LSL #16
    MOVK  X8, #0x9499, LSL #32
    MOVK  X8, #0x3d21, LSL #48
    SUB  X21, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0xf809, LSL #0
    MOVK  X8, #0x261, LSL #16
    MOVK  X8, #0x49cc, LSL #32
    MOVK  X8, #0xb860, LSL #48
    SUB  X21, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0xd74f, LSL #0
    MOVK  X8, #0xa5a7, LSL #16
    MOVK  X8, #0x22de, LSL #32
    MOVK  X8, #0x9ee8, LSL #48
    SUB  X21, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0xfad9, LSL #0
    MOVK  X8, #0xdf14, LSL #16
    MOVK  X8, #0xf484, LSL #32
    MOVK  X8, #0x9542, LSL #48
    SUB  X21, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x544e, LSL #0
    MOVK  X8, #0xf88c, LSL #16
    MOVK  X8, #0xd107, LSL #32
    MOVK  X8, #0xe467, LSL #48
    SUB  X21, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x4eb, LSL #0
    MOVK  X8, #0xe48a, LSL #16
    MOVK  X8, #0xa596, LSL #32
    MOVK  X8, #0xa613, LSL #48
    SUB  X21, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x9917, LSL #0
    MOVK  X8, #0xcf97, LSL #16
    MOVK  X8, #0x963b, LSL #32
    MOVK  X8, #0xbce4, LSL #48
    SUB  X21, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0xda5e, LSL #0
    MOVK  X8, #0x95d0, LSL #16
    MOVK  X8, #0xfde9, LSL #32
    MOVK  X8, #0x4166, LSL #48
    SUB  X21, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0xff0f, LSL #0
    MOVK  X8, #0x36da, LSL #16
    MOVK  X8, #0xcdf, LSL #32
    MOVK  X8, #0x36ff, LSL #48
    SUB  X21, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x4d7f, LSL #0
    MOVK  X8, #0xf0a, LSL #16
    MOVK  X8, #0xa75f, LSL #32
    MOVK  X8, #0x1c6f, LSL #48
    SUB  X21, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0xa706, LSL #0
    MOVK  X8, #0xd812, LSL #16
    MOVK  X8, #0x1662, LSL #32
    MOVK  X8, #0xb36b, LSL #48
    SUB  X21, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x1d, LSL #0
    MRS  X21, FPSR
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x62da, LSL #0
    MOVK  X8, #0xf20a, LSL #32
    FMOV  X21, V0.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x8000, LSL #0
    MOVK  X8, #0x78b1, LSL #16
    MOVK  X8, #0x57a0, LSL #32
    MOVK  X8, #0x4700, LSL #48
    FMOV  X21, D0
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x22dc, LSL #0
    MOVK  X8, #0xfce9, LSL #16
    MOVK  X8, #0xe806, LSL #32
    MOVK  X8, #0xbce6, LSL #48
    FMOV  X21, V1.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0xff0f, LSL #0
    MOVK  X8, #0x36da, LSL #16
    MOVK  X8, #0xcdf, LSL #32
    MOVK  X8, #0x36ff, LSL #48
    FMOV  X21, D1
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V2.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D2
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V3.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D3
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0xb156, LSL #0
    MOVK  X8, #0x78b1, LSL #16
    MOVK  X8, #0x57a0, LSL #32
    MOVK  X8, #0x47d9, LSL #48
    FMOV  X21, V4.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x22dc, LSL #0
    MOVK  X8, #0xfce9, LSL #16
    MOVK  X8, #0xe806, LSL #32
    MOVK  X8, #0xbce6, LSL #48
    FMOV  X21, D4
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V5.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D5
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x22dc, LSL #0
    MOVK  X8, #0xfce9, LSL #16
    MOVK  X8, #0xe806, LSL #32
    MOVK  X8, #0xbce6, LSL #48
    FMOV  X21, V6.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0xa43, LSL #0
    MOVK  X8, #0xb6f8, LSL #16
    MOVK  X8, #0x9499, LSL #32
    MOVK  X8, #0x3d21, LSL #48
    FMOV  X21, D6
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x4d7f, LSL #0
    MOVK  X8, #0xf0a, LSL #16
    MOVK  X8, #0xa75f, LSL #32
    MOVK  X8, #0x1c6f, LSL #48
    FMOV  X21, V7.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x4d7f, LSL #0
    MOVK  X8, #0xf0a, LSL #16
    MOVK  X8, #0xa75f, LSL #32
    MOVK  X8, #0x1c6f, LSL #48
    FMOV  X21, D7
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V8.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D8
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x5af6, LSL #0
    MOVK  X8, #0xc6ab, LSL #16
    MOVK  X8, #0x1168, LSL #32
    MOVK  X8, #0xd157, LSL #48
    FMOV  X21, V9.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x3ea0, LSL #0
    MOVK  X8, #0xd0b5, LSL #16
    MOVK  X8, #0x685, LSL #32
    MOVK  X8, #0x119, LSL #48
    FMOV  X21, D9
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V10.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D10
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V11.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D11
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V12.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D12
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V13.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D13
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V14.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D14
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V15.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D15
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V16.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D16
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x9917, LSL #0
    MOVK  X8, #0xcf97, LSL #16
    MOVK  X8, #0x963b, LSL #32
    MOVK  X8, #0xbce4, LSL #48
    FMOV  X21, V17.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x5af6, LSL #0
    MOVK  X8, #0xc6ab, LSL #16
    MOVK  X8, #0x1168, LSL #32
    MOVK  X8, #0xd157, LSL #48
    FMOV  X21, D17
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x62db, LSL #0
    MOVK  X8, #0x32b9, LSL #16
    MOVK  X8, #0xf20a, LSL #32
    MOVK  X8, #0xef6, LSL #48
    FMOV  X21, V18.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0xb156, LSL #0
    MOVK  X8, #0x78b1, LSL #16
    MOVK  X8, #0x57a0, LSL #32
    MOVK  X8, #0x47d9, LSL #48
    FMOV  X21, D18
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V19.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D19
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V20.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D20
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V21.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D21
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V22.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D22
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V23.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D23
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V24.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D24
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0xfad9, LSL #0
    MOVK  X8, #0xdf14, LSL #16
    MOVK  X8, #0xf484, LSL #32
    MOVK  X8, #0x9542, LSL #48
    FMOV  X21, V25.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x82b9, LSL #0
    MOVK  X8, #0x72a2, LSL #16
    MOVK  X8, #0x6424, LSL #32
    MOVK  X8, #0xc966, LSL #48
    FMOV  X21, D25
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V26.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D26
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V27.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D27
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0xe425, LSL #0
    MOVK  X8, #0xd8e4, LSL #16
    MOVK  X8, #0x15af, LSL #32
    MOVK  X8, #0x9ae5, LSL #48
    FMOV  X21, V28.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x6a1b, LSL #0
    MOVK  X8, #0xef59, LSL #16
    MOVK  X8, #0xf714, LSL #32
    MOVK  X8, #0xdcde, LSL #48
    FMOV  X21, D28
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V29.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D29
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V30.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D30
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x5af6, LSL #0
    MOVK  X8, #0xc6ab, LSL #16
    MOVK  X8, #0x1168, LSL #32
    MOVK  X8, #0xd157, LSL #48
    FMOV  X21, V31.D[1]
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0xd74f, LSL #0
    MOVK  X8, #0xa5a7, LSL #16
    MOVK  X8, #0x22de, LSL #32
    MOVK  X8, #0x9ee8, LSL #48
    FMOV  X21, D31
    SUB  X27, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
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
    FMOV  D0, X26
    FMOV  V0.D[1], X22
    FMOV  D1, X29
    FMOV  V1.D[1], X14
    FMOV  D2, X25
    FMOV  V2.D[1], X28
    FMOV  D3, X23
    FMOV  V3.D[1], X20
    FMOV  D4, X17
    FMOV  V4.D[1], X19
    FMOV  D5, X27
    FMOV  V5.D[1], X24
    FMOV  D6, X14
    FMOV  V6.D[1], X29
    FMOV  D7, X21
    FMOV  V7.D[1], X16
    FMOV  D8, X7
    FMOV  V8.D[1], X2
    FMOV  D9, X16
    FMOV  V9.D[1], X19
    FMOV  D10, X7
    FMOV  V10.D[1], X10
    FMOV  D11, X21
    FMOV  V11.D[1], X24
    FMOV  D12, X2
    FMOV  V12.D[1], X11
    FMOV  D13, X26
    FMOV  V13.D[1], X20
    FMOV  D14, X29
    FMOV  V14.D[1], X29
    FMOV  D15, X23
    FMOV  V15.D[1], X16
    FMOV  D16, X7
    FMOV  V16.D[1], X20
    FMOV  D17, X24
    FMOV  V17.D[1], X7
    FMOV  D18, X9
    FMOV  V18.D[1], X27
    FMOV  D19, X3
    FMOV  V19.D[1], X15
    FMOV  D20, X28
    FMOV  V20.D[1], X24
    FMOV  D21, X14
    FMOV  V21.D[1], X16
    FMOV  D22, X2
    FMOV  V22.D[1], X2
    FMOV  D23, X6
    FMOV  V23.D[1], X20
    FMOV  D24, X22
    FMOV  V24.D[1], X27
    FMOV  D25, X9
    FMOV  V25.D[1], X11
    FMOV  D26, X14
    FMOV  V26.D[1], X20
    FMOV  D27, X9
    FMOV  V27.D[1], X24
    FMOV  D28, X23
    FMOV  V28.D[1], X10
    FMOV  D29, X14
    FMOV  V29.D[1], X21
    FMOV  D30, X2
    FMOV  V30.D[1], X19
    FMOV  D31, X2
    FMOV  V31.D[1], X7
    MOVZ  X29, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_1:
    FRINTP  V0.2D, V30.2D
    FRINTP  V17.4H, V18.4H
    FCVTNU  V3.4H, V25.4H
    FCVTAS  V17.8H, V27.8H
    FCVTAS  V18.2D, V0.2D
    FRINTM  V27.8H, V31.8H
    FCVTL  V27.2D, V28.2S
    FCVTZS  V0.4H, V29.4H, #4
    FRINTA  V28.8H, V3.8H
    FCVTAS  V10.4H, V18.4H
    FRINTN  V29.2S, V0.2S
    FRINTA  V31.4H, V17.4H
    FRINTX  V12.4H, V28.4H
    FRINTM  V10.4S, V29.4S
    FRINTX  V21.8H, V12.8H
    FCVTMU  V15.4H, V27.4H
    FCVTN  V16.2S, V10.2D
    FCVTZU  V21.2S, V31.2S
    FRINTA  V17.4H, V21.4H
    FCVTZU  V8.4S, V16.4S
    FRINTA  V2.8H, V8.8H
    FCVTNS  V22.4H, V8.4H
    FCVTPU  V8.4H, V30.4H
    FRINTA  V20.4H, V15.4H
    FCVTL  V2.2D, V17.2S
    FCVTAU  V18.8H, V22.8H
    FCVTL2  V22.4S, V18.8H
    FCVTZU V0.2D, V22.2D, #63
    FRINTP  V10.4H, V0.4H
    FRINTX  V17.4S, V8.4S
    FCVTZS V8.2D, V17.2D, #54
    FCVTAS  V18.4S, V31.4S
    FCVTZU V21.2D, V8.2D, #26
    FCVTPU  V16.4H, V10.4H
    FCVTZS  V10.8H, V20.8H, #7
    FRINTN  V30.8H, V10.8H
    FCVTAU  V22.4S, V30.4S
    FCVTZU  V15.4H, V2.4H
    FRINTA  V17.4H, V15.4H
    FCVTMS  V30.2D, V17.2D
    FCVTN  V31.2S, V30.2D
    FCVTL  V0.2D, V18.2S
    FCVTZS  V2.2D, V21.2D
    FRINTN  V18.4S, V2.4S
    FCVTMS  V20.4S, V18.4S
    FRINTX  V17.4S, V31.4S
    FCVTZU  V30.4H, V16.4H
    FCVTAS  V10.2D, V30.2D
    FCVTNS  V31.2S, V22.2S
    FCVTNU  V21.8H, V31.8H
    FCVTMU  V31.2S, V17.2S
    FCVTXN  V2.2S, V0.2D
    FCVTZS  V15.8H, V0.8H, #1
    FCVTL2  V18.4S, V15.8H
    FCVTMS  V16.4S, V20.4S
    FCVTMS  V17.8H, V10.8H
    FCVTNU  V10.2D, V17.2D
    FCVTNS  V0.4S, V10.4S
    FRINTX  V17.8H, V21.8H
    FRINTA  V21.2D, V17.2D
    FRINTI  V17.2S, V0.2S
    FRINTX  V20.4H, V31.4H
    FCVTZU  V8.2S, V20.2S, #3
    FCVTNS  V22.4H, V8.4H
    FRINTM  V30.4S, V21.4S
    FRINTX  V10.4H, V16.4H
    FCVTNU  V31.2S, V22.2S
    FCVTZU  V16.4S, V30.4S, #8
    FRINTM  V15.2D, V17.2D
    FCVTMU  V0.2S, V15.2S
    FCVTZS  V17.4S, V9.4S, #17
    FCVTZU V15.2D, V16.2D, #34
    FCVTZU  V21.2S, V18.2S
    FCVTMU  V18.2D, V17.2D
    FCVTN  V8.4H, V18.4S
    FCVTPS  V30.8H, V15.8H
    FRINTI  V28.4S, V0.4S
    FCVTPS  V20.4H, V31.4H
    FCVTZU  V22.4H, V10.4H
    FRINTI  V10.4H, V20.4H
    FCVTMU  V31.4H, V28.4H
    FRINTI  V17.4H, V10.4H
    FCVTNU  V26.4H, V17.4H
    FRINTZ  V17.4S, V26.4S
    FCVTXN2  V9.4S, V17.2D
    FCVTZU  V17.4S, V30.4S
    FRINTI  V26.4H, V22.4H
    FCVTNU  V11.4H, V8.4H
    FCVTZS  V30.8H, V21.8H, #3
    FRINTM  V16.4H, V30.4H
    FCVTZU V6.2D, V24.2D, #57
    FCVTN  V20.4H, V11.4S
    FRINTI  V24.4S, V25.4S
    FRINTI  V10.4H, V20.4H
    FCVTZU  V13.4S, V10.4S
    FCVTPS  V21.8H, V24.8H
    FRINTI  V30.2S, V9.2S
    FCVTAU  V10.4S, V6.4S
    FCVTMU  V20.4H, V13.4H
    FCVTMS  V22.8H, V10.8H
    FCVTPS  V24.8H, V16.8H
    FCVTZS  V8.4H, V20.4H
    FRINTM  V11.8H, V24.8H
    FCVTZU  V24.4S, V26.4S
    FCVTZU  V13.2S, V24.2S, #20
    FCVTAU  V24.2S, V17.2S
    FCVTZS  V17.8H, V31.8H, #15
    FCVTZS V31.2D, V21.2D, #3
    FRINTI  V28.8H, V8.8H
    FCVTAU  V9.8H, V17.8H
    FCVTZU  V31.4H, V11.4H, #2
    FCVTZS  V6.4H, V22.4H
    FCVTNU  V25.4H, V13.4H
    FCVTMS  V22.4S, V28.4S
    FRINTZ  V20.8H, V31.8H
    FCVTNU  V11.8H, V9.8H
    FCVTL  V16.2D, V30.2S
    FRINTX  V10.8H, V22.8H
    FCVTXN  V22.2S, V14.2D
    FCVTN2  V28.8H, V11.4S
    FCVTZS  V11.2D, V28.2D
    FCVTNU  V26.4H, V16.4H
    FCVTZS  V31.2S, V24.2S
    FCVTZS  V21.4H, V23.4H, #9
    FCVTZS V30.2D, V25.2D, #64
    FRINTA  V16.4H, V20.4H
    FRINTI  V28.2S, V6.2S
    FCVTAS  V23.8H, V11.8H
    FCVTPU  V11.4S, V28.4S
    FCVTPU  V17.8H, V22.8H
    FRINTP  V9.2D, V17.2D
    FCVTZU V6.2D, V9.2D, #37
    FRINTP  V9.4H, V10.4H
    FCVTL2  V14.4S, V23.8H
    FRINTX  V23.8H, V11.8H
    FCVTZU V28.2D, V16.2D, #45
    FRINTX  V22.2D, V30.2D
    FRINTA  V13.2S, V28.2S
    FCVTMS  V28.4S, V22.4S
    FCVTZU  V10.4S, V21.4S
    FRINTZ  V20.4H, V9.4H
    FCVTZU  V24.2S, V26.2S
    FRINTX  V21.4H, V20.4H
    FCVTNS  V17.8H, V31.8H
    FCVTNU  V25.8H, V17.8H
    FCVTNS  V26.4H, V13.4H
    FCVTNS  V31.4S, V25.4S
    FRINTI  V11.4H, V24.4H
    FCVTMS  V13.4H, V23.4H
    FCVTPS  V23.4H, V31.4H
    FCVTXN2  V16.4S, V28.2D
    FCVTZS  V30.8H, V10.8H, #2
    FCVTMU  V10.4S, V23.4S
    FRINTA  V31.4H, V21.4H
    FCVTAS  V25.8H, V11.8H
    FRINTP  V23.2D, V10.2D
    FRINTM  V20.8H, V13.8H
    FCVTL  V28.2D, V16.2S
    FCVTN  V22.4H, V26.4S
    FCVTZS  V26.4H, V31.4H
    FCVTAU  V21.4S, V26.4S
    FRINTP  V24.2S, V25.2S
    FRINTP  V9.4H, V14.4H
    FCVTXN  V14.2S, V24.2D
    FRINTZ  V17.2D, V23.2D
    FRINTX  V6.8H, V20.8H
    FRINTX  V11.2D, V30.2D
    FRINTA  V30.4H, V11.4H
    FRINTZ  V31.8H, V28.8H
    FRINTM  V26.4S, V21.4S
    FCVTMU  V28.2D, V22.2D
    FCVTN2  V23.4S, V29.2D
    FRINTM  V29.2S, V26.2S
    FCVTN2  V26.8H, V30.4S
    FCVTAS  V20.2D, V14.2D
    FCVTL2  V24.2D, V31.4S
    FRINTA  V22.8H, V6.8H
    FCVTXN  V31.2S, V9.2D
    FRINTX  V25.2D, V24.2D
    FRINTX  V30.4H, V17.4H
    FCVTAU  V14.2S, V28.2S
    FCVTNU  V16.2S, V14.2S
    FRINTI  V11.2S, V29.2S
    FRINTM  V29.4S, V25.4S
    FCVTAU  V28.2S, V23.2S
    FRINTX  V23.2S, V28.2S
    FCVTNU  V9.2S, V20.2S
    FCVTMU  V25.8H, V3.8H
    FCVTZS  V28.4S, V26.4S
    FRINTA  V21.8H, V25.8H
    FCVTL  V17.2D, V22.2S
    FCVTZU  V20.8H, V21.8H
    FCVTZS  V6.8H, V31.8H
    FRINTA  V24.2S, V29.2S
    FCVTL  V31.4S, V31.4H
    FCVTZS  V26.4H, V16.4H
    FRINTZ  V14.2S, V11.2S
    FCVTZS  V3.4H, V14.4H
    FCVTZS  V25.4S, V28.4S, #18
    FCVTPU  V28.4H, V31.4H
    SUBS  X29, X29, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_1
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x1d, LSL #0
    MRS  X10, FPSR
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V0.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D0
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V1.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D1
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V2.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D2
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V3.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D3
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V4.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D4
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V5.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D5
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V6.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D6
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V7.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D7
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V8.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D8
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V9.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D9
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V10.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D10
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V11.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D11
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V12.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D12
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V13.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D13
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V14.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D14
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V15.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D15
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V16.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D16
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V17.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D17
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V18.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D18
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V19.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D19
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V20.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D20
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V21.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D21
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V22.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D22
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V23.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D23
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V24.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D24
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V25.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D25
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V26.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D26
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V27.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D27
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V28.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D28
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V29.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D29
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V30.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D30
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V31.D[1]
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D31
    SUB  X3, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
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
    FMOV  V0.D[1], X23
    FMOV  D1, X28
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X24
    FMOV  D3, X24
    FMOV  V3.D[1], X20
    FMOV  D4, X19
    FMOV  V4.D[1], X27
    FMOV  D5, X25
    FMOV  V5.D[1], X26
    FMOV  D6, X23
    FMOV  V6.D[1], X13
    FMOV  D7, X7
    FMOV  V7.D[1], X14
    FMOV  D8, X3
    FMOV  V8.D[1], X8
    FMOV  D9, X20
    FMOV  V9.D[1], X15
    FMOV  D10, X24
    FMOV  V10.D[1], X26
    FMOV  D11, X22
    FMOV  V11.D[1], X21
    FMOV  D12, X17
    FMOV  V12.D[1], X14
    FMOV  D13, X15
    FMOV  V13.D[1], X27
    FMOV  D14, X29
    FMOV  V14.D[1], X21
    FMOV  D15, X21
    FMOV  V15.D[1], X11
    FMOV  D16, X21
    FMOV  V16.D[1], X3
    FMOV  D17, X16
    FMOV  V17.D[1], X2
    FMOV  D18, X21
    FMOV  V18.D[1], X21
    FMOV  D19, X9
    FMOV  V19.D[1], X7
    FMOV  D20, X10
    FMOV  V20.D[1], X13
    FMOV  D21, X25
    FMOV  V21.D[1], X22
    FMOV  D22, X13
    FMOV  V22.D[1], X6
    FMOV  D23, X22
    FMOV  V23.D[1], X27
    FMOV  D24, X8
    FMOV  V24.D[1], X24
    FMOV  D25, X27
    FMOV  V25.D[1], X7
    FMOV  D26, X7
    FMOV  V26.D[1], X13
    FMOV  D27, X16
    FMOV  V27.D[1], X28
    FMOV  D28, X20
    FMOV  V28.D[1], X7
    FMOV  D29, X9
    FMOV  V29.D[1], X15
    FMOV  D30, X26
    FMOV  V30.D[1], X8
    FMOV  D31, X16
    FMOV  V31.D[1], X28
    MOVZ  X16, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_2:
    FRINTM  V3.2S, V28.2S
    FCVTPU  V27.2D, V23.2D
    FRINTN  V18.4H, V27.4H
    FCVTZS V29.2D, V31.2D, #20
    FCVTNS  V31.8H, V25.8H
    FCVTAS  V6.2S, V3.2S
    FRINTM  V21.8H, V30.8H
    FCVTZU  V26.4S, V26.4S
    FCVTZU  V21.4S, V21.4S, #5
    FCVTMS  V15.8H, V21.8H
    FCVTAS  V1.4S, V31.4S
    FCVTMU  V7.4H, V1.4H
    FCVTPU  V21.2S, V15.2S
    FCVTZS  V7.2S, V18.2S, #25
    FCVTPU  V1.8H, V24.8H
    FCVTAU  V29.4S, V29.4S
    FCVTNS  V25.4S, V9.4S
    FRINTM  V9.2S, V17.2S
    FRINTI  V16.4H, V26.4H
    FCVTZU V6.2D, V24.2D, #4
    FCVTMU  V31.8H, V21.8H
    FRINTP  V14.4S, V31.4S
    FCVTAS  V8.4H, V7.4H
    FCVTZU  V1.4H, V14.4H
    FCVTZU  V22.4H, V1.4H, #13
    FRINTZ  V7.2S, V22.2S
    FCVTZU  V30.8H, V16.8H, #13
    FCVTPS  V22.2S, V29.2S
    FCVTMU  V18.4H, V8.4H
    FCVTNS  V17.4S, V22.4S
    FCVTL  V15.4S, V17.4H
    FCVTZS  V21.4H, V16.4H
    FCVTN  V3.4H, V0.4S
    FCVTZS  V14.4H, V30.4H
    FRINTX  V30.4S, V18.4S
    FCVTMU  V8.8H, V7.8H
    FRINTZ  V24.2S, V23.2S
    FCVTMS  V1.2S, V15.2S
    FCVTN  V26.2S, V21.2D
    FCVTZS  V21.4H, V14.4H
    FCVTAU  V14.8H, V8.8H
    FCVTAU  V7.4S, V14.4S
    FCVTAU  V29.2S, V3.2S
    FCVTMS  V8.8H, V29.8H
    FCVTPU  V18.2D, V6.2D
    FRINTX  V29.2S, V30.2S
    FCVTNS  V17.8H, V8.8H
    FRINTX  V23.2S, V29.2S
    FCVTL2  V15.4S, V26.8H
    FRINTA  V0.2D, V26.2D
    FRINTZ  V3.2D, V17.2D
    FRINTZ  V16.4H, V1.4H
    FRINTA  V29.4S, V18.4S
    FCVTAU  V1.4H, V7.4H
    FRINTA  V6.8H, V16.8H
    FCVTMS  V7.2S, V21.2S
    FCVTAU  V14.4S, V29.4S
    FRINTA  V29.8H, V6.8H
    FRINTA  V22.2S, V29.2S
    FCVTPU  V18.4H, V7.4H
    FCVTNU  V7.4H, V18.4H
    FRINTN  V26.2S, V3.2S
    FCVTNU  V13.2S, V7.2S
    FRINTZ  V7.4S, V26.4S
    FCVTAU  V18.4H, V14.4H
    FCVTZS  V12.8H, V22.8H, #4
    FRINTP  V17.2S, V1.2S
    FRINTI  V29.4H, V15.4H
    FCVTZS  V15.2D, V29.2D
    FCVTPU  V29.4H, V13.4H
    FCVTZS V16.2D, V29.2D, #58
    FCVTN  V1.2S, V17.2D
    FRINTX  V17.8H, V1.8H
    FCVTZS  V13.2S, V7.2S, #1
    FCVTZS  V6.4H, V13.4H
    FCVTZS  V1.4H, V16.4H
    FRINTX  V22.8H, V1.8H
    FCVTMU  V26.8H, V18.8H
    FCVTZU  V16.2S, V17.2S, #16
    FCVTZU V1.2D, V6.2D, #57
    FRINTN  V13.2D, V15.2D
    FCVTPU  V7.2D, V13.2D
    FCVTZS  V29.4H, V22.4H, #9
    FRINTA  V6.8H, V26.8H
    FRINTN  V14.4H, V1.4H
    FCVTL2  V13.4S, V12.8H
    FCVTZS  V17.4H, V7.4H
    FRINTN  V7.4H, V17.4H
    FCVTZU V1.2D, V16.2D, #2
    FCVTAS  V12.2D, V5.2D
    FCVTL  V5.4S, V7.4H
    FRINTP  V22.4H, V1.4H
    FCVTZS V1.2D, V29.2D, #35
    FCVTN  V26.2S, V1.2D
    FCVTAS  V1.4H, V26.4H
    FCVTL  V18.2D, V12.2S
    FRINTP  V16.4H, V6.4H
    FRINTX  V7.4H, V18.4H
    FCVTPU  V15.4H, V14.4H
    FRINTM  V12.2S, V1.2S
    FRINTX  V29.4S, V13.4S
    FCVTZU  V14.2S, V16.2S, #2
    FCVTL2  V6.4S, V5.8H
    FCVTMS  V19.8H, V22.8H
    FRINTN  V13.2S, V14.2S
    FCVTNS  V1.2S, V13.2S
    FCVTZU  V16.8H, V15.8H
    FCVTZS  V15.8H, V7.8H, #5
    FRINTN  V18.8H, V1.8H
    FCVTL2  V26.4S, V12.8H
    FRINTX  V22.4S, V21.4S
    FRINTP  V5.2D, V15.2D
    FCVTZU  V12.8H, V26.8H
    FCVTZS  V26.2D, V19.2D
    FCVTL2  V15.4S, V29.8H
    FRINTP  V14.2S, V18.2S
    FCVTL  V13.4S, V30.4H
    FRINTN  V30.4H, V5.4H
    FCVTL  V19.2D, V26.2S
    FRINTI  V26.2S, V6.2S
    FCVTAU  V21.2S, V19.2S
    FCVTL  V7.2D, V26.2S
    FCVTPS  V26.8H, V22.8H
    FCVTXN2  V1.4S, V21.2D
    FCVTPS  V18.2D, V12.2D
    FCVTAS  V6.4H, V30.4H
    FCVTMU  V29.2D, V15.2D
    FRINTA  V5.2S, V14.2S
    FCVTMU  V12.4S, V1.4S
    FCVTPS  V19.8H, V12.8H
    FCVTNU  V30.4H, V18.4H
    FCVTZU  V21.4S, V16.4S, #13
    FCVTMS  V1.2D, V21.2D
    FCVTMU  V12.2S, V30.2S
    FRINTN  V30.2S, V5.2S
    FCVTXN  V5.2S, V1.2D
    FCVTMS  V21.4H, V12.4H
    FRINTP  V12.8H, V30.8H
    FRINTN  V1.4S, V19.4S
    FRINTZ  V15.8H, V13.8H
    FRINTZ  V13.4H, V29.4H
    FRINTM  V14.4H, V13.4H
    FCVTZS  V19.8H, V26.8H
    FCVTNU  V18.4S, V21.4S
    FCVTAS  V16.8H, V1.8H
    FCVTZS  V21.2S, V6.2S, #19
    FCVTNU  V29.8H, V16.8H
    FRINTX  V26.2D, V5.2D
    FRINTX  V22.4H, V15.4H
    FRINTX  V1.2S, V14.2S
    FCVTZU  V30.8H, V1.8H
    FRINTX  V6.2D, V12.2D
    FCVTNU  V14.8H, V21.8H
    FCVTAU  V5.2S, V30.2S
    FCVTZS  V12.2D, V5.2D
    FCVTAS  V16.4H, V6.4H
    FRINTI  V15.8H, V29.8H
    FCVTZU  V13.8H, V18.8H, #14
    FCVTPS  V1.2D, V22.2D
    FRINTX  V22.8H, V19.8H
    FCVTAS  V19.4S, V14.4S
    FRINTM  V21.8H, V26.8H
    FCVTPU  V14.2D, V16.2D
    FCVTZS V6.2D, V21.2D, #34
    FRINTA  V29.2D, V15.2D
    FRINTP  V15.8H, V12.8H
    FCVTZU  V18.8H, V22.8H
    FCVTMS  V22.4H, V19.4H
    FCVTMU  V7.4S, V13.4S
    FCVTPU  V16.2D, V22.2D
    FCVTL  V19.4S, V18.4H
    FRINTA  V13.2D, V23.2D
    FRINTN  V26.4H, V14.4H
    FRINTA  V30.2S, V19.2S
    FRINTP  V22.2S, V30.2S
    FRINTM  V30.8H, V15.8H
    FCVTNS  V23.4H, V7.4H
    FRINTP  V15.2S, V29.2S
    FCVTN2  V14.4S, V13.2D
    FRINTM  V29.2D, V1.2D
    FCVTMS  V18.8H, V30.8H
    FCVTAS  V19.4S, V14.4S
    FCVTZU  V14.2S, V16.2S, #28
    FRINTZ  V7.8H, V26.8H
    FCVTNS  V13.8H, V7.8H
    FCVTNS  V1.2D, V19.2D
    FRINTP  V30.4H, V1.4H
    FCVTNS  V16.2S, V13.2S
    FRINTX  V13.8H, V16.8H
    FCVTNS  V26.8H, V22.8H
    FRINTZ  V16.8H, V6.8H
    FRINTP  V7.4H, V23.4H
    FCVTZS  V19.8H, V26.8H, #7
    FRINTN  V1.4S, V15.4S
    FRINTX  V15.2D, V14.2D
    FCVTNU  V14.8H, V16.8H
    FCVTXN  V16.2S, V31.2D
    FRINTI  V6.8H, V1.8H
    FCVTL  V23.4S, V13.4H
    FCVTXN  V26.2S, V30.2D
    SUBS  X16, X16, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_2
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X8, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X8, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X8, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X8, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X8, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X8, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X8, X26, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X8, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X8, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X8, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X8, X26, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X8, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X8, X26, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X8, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X8, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X8, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X8, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X8, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X8, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X8, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x1d, LSL #0
    MRS  X8, FPSR
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, V0.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, D0
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, V1.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, D1
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    FMOV  X8, V2.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    FMOV  X8, D2
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, V3.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, D3
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    FMOV  X8, V4.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    FMOV  X8, D4
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, V5.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, D5
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, V6.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, D6
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, V7.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, D7
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, V8.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, D8
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, V9.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, D9
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    FMOV  X8, V10.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    FMOV  X8, D10
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    FMOV  X8, V11.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    FMOV  X8, D11
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, V12.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, D12
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, V13.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, D13
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, V14.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, D14
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, V15.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, D15
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, V16.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, D16
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, V17.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, D17
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, V18.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, D18
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, V19.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, D19
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    FMOV  X8, V20.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    FMOV  X8, D20
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, V21.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, D21
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, V22.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, D22
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, V23.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, D23
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, V24.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, D24
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, V25.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, D25
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, V26.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, D26
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, V27.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, D27
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    FMOV  X8, V28.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    FMOV  X8, D28
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, V29.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, D29
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, V30.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, D30
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, V31.D[1]
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X8, D31
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X2, #0x986d, LSL #0
    MOVK  X2, #0x90e2, LSL #16
    MOVK  X2, #0x6ca7, LSL #32
    MOVK  X2, #0xb214, LSL #48
    MOVZ  X3, #0x1ad2, LSL #0
    MOVK  X3, #0xa136, LSL #16
    MOVK  X3, #0x6553, LSL #32
    MOVK  X3, #0xe2c4, LSL #48
    MOVZ  X6, #0xa520, LSL #0
    MOVK  X6, #0x248d, LSL #16
    MOVK  X6, #0x4d72, LSL #32
    MOVK  X6, #0x7f8b, LSL #48
    MOVZ  X7, #0x4547, LSL #0
    MOVK  X7, #0xfac4, LSL #16
    MOVK  X7, #0xd172, LSL #32
    MOVK  X7, #0x3221, LSL #48
    MOVZ  X8, #0x7623, LSL #0
    MOVK  X8, #0x1578, LSL #16
    MOVK  X8, #0x1b8d, LSL #32
    MOVK  X8, #0xf7e5, LSL #48
    MOVZ  X9, #0x826, LSL #0
    MOVK  X9, #0x32a1, LSL #16
    MOVK  X9, #0xb5e3, LSL #32
    MOVK  X9, #0x3f03, LSL #48
    MOVZ  X10, #0xdd34, LSL #0
    MOVK  X10, #0x513, LSL #16
    MOVK  X10, #0x7b98, LSL #32
    MOVK  X10, #0xb6f6, LSL #48
    MOVZ  X11, #0x40e0, LSL #0
    MOVK  X11, #0x9af9, LSL #16
    MOVK  X11, #0x558c, LSL #32
    MOVK  X11, #0x64bf, LSL #48
    MOVZ  X13, #0x51d8, LSL #0
    MOVK  X13, #0xd66f, LSL #16
    MOVK  X13, #0x2cc3, LSL #32
    MOVK  X13, #0x4b7, LSL #48
    MOVZ  X14, #0x317, LSL #0
    MOVK  X14, #0xf28c, LSL #16
    MOVK  X14, #0x749e, LSL #32
    MOVK  X14, #0x4693, LSL #48
    MOVZ  X15, #0x32ee, LSL #0
    MOVK  X15, #0xd418, LSL #16
    MOVK  X15, #0x552b, LSL #32
    MOVK  X15, #0x87c, LSL #48
    MOVZ  X16, #0x95d8, LSL #0
    MOVK  X16, #0xacad, LSL #16
    MOVK  X16, #0xa71b, LSL #32
    MOVK  X16, #0xebc, LSL #48
    MOVZ  X17, #0x4955, LSL #0
    MOVK  X17, #0x9c2, LSL #16
    MOVK  X17, #0xfcf8, LSL #32
    MOVK  X17, #0x8dad, LSL #48
    MOVZ  X19, #0x2302, LSL #0
    MOVK  X19, #0x5cf2, LSL #16
    MOVK  X19, #0xad3d, LSL #32
    MOVK  X19, #0xbde1, LSL #48
    MOVZ  X20, #0x4c65, LSL #0
    MOVK  X20, #0xef13, LSL #16
    MOVK  X20, #0x3877, LSL #32
    MOVK  X20, #0xc6fc, LSL #48
    MOVZ  X21, #0x32cb, LSL #0
    MOVK  X21, #0x7af1, LSL #16
    MOVK  X21, #0xd225, LSL #32
    MOVK  X21, #0xb680, LSL #48
    MOVZ  X22, #0xe2d2, LSL #0
    MOVK  X22, #0x76ad, LSL #16
    MOVK  X22, #0x3a7f, LSL #32
    MOVK  X22, #0xad36, LSL #48
    MOVZ  X23, #0xd4f5, LSL #0
    MOVK  X23, #0x2afb, LSL #16
    MOVK  X23, #0xc6e1, LSL #32
    MOVK  X23, #0xbaf, LSL #48
    MOVZ  X24, #0xd45c, LSL #0
    MOVK  X24, #0xb9bf, LSL #16
    MOVK  X24, #0x78ec, LSL #32
    MOVK  X24, #0x6587, LSL #48
    MOVZ  X25, #0xbde4, LSL #0
    MOVK  X25, #0x80d0, LSL #16
    MOVK  X25, #0x491, LSL #32
    MOVK  X25, #0xebaf, LSL #48
    MOVZ  X26, #0x694c, LSL #0
    MOVK  X26, #0x72e2, LSL #16
    MOVK  X26, #0x85b2, LSL #32
    MOVK  X26, #0x94d7, LSL #48
    MOVZ  X27, #0x941f, LSL #0
    MOVK  X27, #0xcd8a, LSL #16
    MOVK  X27, #0x13fe, LSL #32
    MOVK  X27, #0xa06e, LSL #48
    MOVZ  X28, #0xc574, LSL #0
    MOVK  X28, #0x5dae, LSL #16
    MOVK  X28, #0xf5b5, LSL #32
    MOVK  X28, #0xc4d5, LSL #48
    MOVZ  X29, #0x26e, LSL #0
    MOVK  X29, #0x53e2, LSL #16
    MOVK  X29, #0x3b0b, LSL #32
    MOVK  X29, #0x2ff0, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X26
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X29
    FMOV  D3, X13
    FMOV  V3.D[1], X15
    FMOV  D4, X13
    FMOV  V4.D[1], X2
    FMOV  D5, X15
    FMOV  V5.D[1], X2
    FMOV  D6, X27
    FMOV  V6.D[1], X15
    FMOV  D7, X20
    FMOV  V7.D[1], X24
    FMOV  D8, X28
    FMOV  V8.D[1], X2
    FMOV  D9, X8
    FMOV  V9.D[1], X22
    FMOV  D10, X24
    FMOV  V10.D[1], X21
    FMOV  D11, X13
    FMOV  V11.D[1], X8
    FMOV  D12, X21
    FMOV  V12.D[1], X26
    FMOV  D13, X26
    FMOV  V13.D[1], X26
    FMOV  D14, X26
    FMOV  V14.D[1], X6
    FMOV  D15, X14
    FMOV  V15.D[1], X17
    FMOV  D16, X29
    FMOV  V16.D[1], X14
    FMOV  D17, X11
    FMOV  V17.D[1], X2
    FMOV  D18, X24
    FMOV  V18.D[1], X7
    FMOV  D19, X28
    FMOV  V19.D[1], X11
    FMOV  D20, X26
    FMOV  V20.D[1], X14
    FMOV  D21, X21
    FMOV  V21.D[1], X9
    FMOV  D22, X27
    FMOV  V22.D[1], X16
    FMOV  D23, X19
    FMOV  V23.D[1], X7
    FMOV  D24, X27
    FMOV  V24.D[1], X7
    FMOV  D25, X20
    FMOV  V25.D[1], X14
    FMOV  D26, X15
    FMOV  V26.D[1], X17
    FMOV  D27, X19
    FMOV  V27.D[1], X10
    FMOV  D28, X29
    FMOV  V28.D[1], X28
    FMOV  D29, X19
    FMOV  V29.D[1], X25
    FMOV  D30, X9
    FMOV  V30.D[1], X29
    FMOV  D31, X28
    FMOV  V31.D[1], X15
    MOVZ  X21, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_3:
    FCVTZU  V4.8H, V29.8H, #14
    FCVTL2  V17.4S, V4.8H
    FCVTZS V25.2D, V23.2D, #44
    FCVTZS  V31.8H, V17.8H, #13
    FCVTAS  V20.4H, V26.4H
    FCVTAS  V18.4H, V25.4H
    FCVTMU  V20.4S, V30.4S
    FCVTNS  V8.4S, V27.4S
    FCVTZS  V21.2D, V28.2D
    FCVTXN2  V14.4S, V21.2D
    FRINTN  V29.4H, V14.4H
    FRINTM  V15.4S, V24.4S
    FCVTN2  V23.4S, V31.2D
    FCVTAS  V12.2D, V15.2D
    FRINTX  V23.2S, V12.2S
    FCVTNU  V9.2D, V23.2D
    FCVTZU  V9.2S, V9.2S
    FCVTMU  V14.2S, V29.2S
    FRINTN  V6.4H, V14.4H
    FRINTZ  V30.2D, V8.2D
    FRINTZ  V4.4H, V20.4H
    FRINTM  V25.4S, V9.4S
    FCVTNU  V31.4H, V2.4H
    FCVTZS  V29.2D, V6.2D
    FCVTZS V26.2D, V9.2D, #28
    FCVTZS V17.2D, V30.2D, #45
    FCVTXN2  V27.4S, V4.2D
    FCVTN  V6.4H, V25.4S
    FRINTZ  V15.4S, V31.4S
    FCVTAS  V31.2D, V18.2D
    FRINTZ  V18.2S, V29.2S
    FCVTL  V21.2D, V26.2S
    FCVTAU  V24.8H, V17.8H
    FRINTI  V28.8H, V18.8H
    FCVTN2  V14.8H, V28.4S
    FCVTPU  V25.4H, V15.4H
    FCVTZS V4.2D, V27.2D, #52
    FRINTX  V12.4S, V25.4S
    FCVTMS  V29.8H, V4.8H
    FRINTN  V26.2D, V21.2D
    FCVTN  V9.4H, V26.4S
    FCVTAS  V28.4S, V12.4S
    FCVTMS  V2.4H, V28.4H
    FRINTA  V30.8H, V29.8H
    FCVTZU  V29.2S, V6.2S, #16
    FCVTPS  V27.4H, V30.4H
    FCVTMU  V30.4S, V30.4S
    FCVTZS  V18.4H, V31.4H, #9
    FRINTX  V31.2D, V27.2D
    FCVTNU  V4.8H, V14.8H
    FCVTPU  V21.4H, V24.4H
    FCVTAU  V7.4H, V29.4H
    FRINTI  V28.8H, V9.8H
    FRINTA  V25.4H, V31.4H
    FCVTN  V26.2S, V21.2D
    FCVTMS  V31.4H, V4.4H
    FCVTZU  V4.2S, V28.2S, #15
    FRINTI  V12.2S, V2.2S
    FRINTX  V6.2D, V4.2D
    FCVTPS  V4.4S, V30.4S
    FRINTP  V9.2S, V9.2S
    FCVTXN  V24.2S, V18.2D
    FRINTN  V29.4S, V26.4S
    FRINTP  V21.2S, V6.2S
    FRINTP  V14.4H, V4.4H
    FCVTMU  V15.4H, V14.4H
    FCVTMU  V26.2D, V7.2D
    FRINTP  V27.8H, V25.8H
    FRINTN  V20.2D, V29.2D
    FCVTPU  V29.4H, V20.4H
    FCVTZU  V11.2S, V15.2S
    FCVTNU  V28.2D, V9.2D
    FCVTMS  V18.4H, V28.4H
    FRINTN  V15.2S, V24.2S
    FRINTX  V4.2S, V29.2S
    FCVTZU  V2.8H, V2.8H, #16
    FRINTA  V24.4H, V21.4H
    FRINTX  V30.4S, V18.4S
    FCVTPS  V25.4H, V30.4H
    FCVTZU  V30.8H, V25.8H
    FCVTAU  V7.2S, V27.2S
    FCVTN2  V20.4S, V26.2D
    FCVTXN2  V25.4S, V2.2D
    FRINTZ  V26.4H, V11.4H
    FCVTZS  V14.2S, V20.2S, #27
    FCVTMS  V29.2S, V14.2S
    FCVTZU  V14.2D, V4.2D
    FCVTZS V9.2D, V30.2D, #46
    FCVTPU  V27.4S, V15.4S
    FCVTNS  V15.2S, V0.2S
    FCVTZU  V2.2S, V26.2S, #8
    FCVTPU  V18.4S, V2.4S
    FCVTMS  V6.8H, V15.8H
    FRINTP  V2.8H, V27.8H
    FCVTPS  V28.2S, V7.2S
    FRINTZ  V21.8H, V28.8H
    FRINTN  V26.8H, V29.8H
    FRINTX  V29.2S, V26.2S
    FCVTN  V20.2S, V29.2D
    FRINTM  V0.4H, V24.4H
    FCVTXN  V26.2S, V18.2D
    FCVTL  V15.2D, V25.2S
    FCVTAU  V11.2D, V9.2D
    FRINTN  V18.4S, V15.4S
    FCVTAU  V24.2D, V20.2D
    FCVTN  V19.4H, V31.4S
    FRINTA  V20.8H, V0.8H
    FCVTZU  V30.8H, V6.8H
    FRINTX  V29.4H, V26.4H
    FRINTP  V6.4S, V11.4S
    FCVTXN2  V31.4S, V21.2D
    FCVTZU  V25.4H, V14.4H
    FCVTZS  V28.2S, V2.2S, #4
    FRINTP  V9.4H, V29.4H
    FCVTAS  V0.4S, V19.4S
    FCVTMU  V11.2D, V9.2D
    FCVTZU  V26.8H, V18.8H, #14
    FCVTL  V21.2D, V30.2S
    FCVTN  V30.4H, V24.4S
    FCVTZU  V9.4S, V30.4S, #30
    FCVTPU  V15.2D, V25.2D
    FCVTPU  V14.8H, V28.8H
    FCVTAU  V2.4H, V26.4H
    FCVTAU  V30.2S, V2.2S
    FCVTXN2  V2.4S, V0.2D
    FCVTZU  V28.2D, V11.2D
    FCVTPU  V26.8H, V21.8H
    FCVTZU  V25.8H, V9.8H, #3
    FRINTA  V19.4H, V31.4H
    FRINTZ  V31.4H, V28.4H
    FCVTNS  V0.4H, V30.4H
    FCVTNS  V30.8H, V0.8H
    FCVTZU  V29.4H, V30.4H, #7
    FCVTPS  V24.2D, V31.2D
    FCVTMU  V31.2D, V29.2D
    FRINTZ  V29.4H, V15.4H
    FCVTMS  V11.4S, V29.4S
    FRINTN  V28.2D, V19.2D
    FRINTZ  V29.4S, V25.4S
    FCVTZU  V21.4S, V11.4S
    FCVTNU  V15.2S, V31.2S
    FRINTP  V25.8H, V10.8H
    FCVTMS  V11.8H, V28.8H
    FCVTXN2  V10.4S, V26.2D
    FCVTNU  V19.4H, V2.4H
    FCVTL2  V0.4S, V24.8H
    FRINTP  V24.2S, V15.2S
    FCVTAU  V2.4H, V21.4H
    FCVTMS  V28.2D, V10.2D
    FRINTA  V10.8H, V0.8H
    FCVTXN  V31.2S, V29.2D
    FRINTA  V29.2D, V10.2D
    FCVTAU  V30.4S, V29.4S
    FRINTM  V21.2D, V25.2D
    FCVTL  V29.2D, V31.2S
    FRINTZ  V31.8H, V21.8H
    FRINTM  V9.4H, V29.4H
    FCVTZS V0.2D, V2.2D, #53
    FCVTZS  V15.8H, V19.8H
    FRINTX  V22.8H, V15.8H
    FCVTNU  V25.4S, V0.4S
    FCVTMU  V10.2D, V22.2D
    FRINTM  V29.8H, V10.8H
    FCVTPU  V0.2S, V11.2S
    FRINTX  V11.2D, V29.2D
    FRINTN  V19.4S, V25.4S
    FRINTP  V21.2D, V24.2D
    FCVTNU  V22.4H, V30.4H
    FRINTZ  V26.4S, V28.4S
    FRINTI  V10.2S, V31.2S
    FCVTAS  V2.4S, V25.4S
    FCVTL  V14.4S, V0.4H
    FCVTZS  V29.8H, V2.8H, #13
    FCVTNU  V0.2S, V11.2S
    FCVTMU  V24.4H, V19.4H
    FRINTZ  V15.2D, V21.2D
    FCVTMU  V30.4S, V26.4S
    FCVTMU  V26.4S, V30.4S
    FCVTL2  V28.2D, V9.4S
    FCVTL2  V19.4S, V24.8H
    FCVTN2  V11.8H, V26.4S
    FCVTZS  V2.2S, V15.2S, #30
    FCVTZU  V22.8H, V20.8H
    FCVTZS  V31.8H, V19.8H
    FRINTN  V6.4H, V14.4H
    FRINTX  V25.4H, V31.4H
    FCVTMS  V20.2S, V2.2S
    FCVTAS  V14.4H, V28.4H
    FCVTPU  V2.2S, V10.2S
    FCVTZS  V30.4H, V14.4H
    FCVTNU  V31.2S, V29.2S
    FCVTN2  V14.8H, V0.4S
    FRINTP  V29.8H, V6.8H
    FCVTAU  V28.4S, V22.4S
    FCVTAU  V6.8H, V31.8H
    FRINTP  V0.2D, V11.2D
    FCVTMU  V19.4H, V2.4H
    FRINTM  V15.4S, V30.4S
    FCVTMS  V11.4S, V29.4S
    FCVTL  V30.2D, V2.2S
    SUBS  X21, X21, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_3
    MOVZ  X3, #0x986d, LSL #0
    MOVK  X3, #0x90e2, LSL #16
    MOVK  X3, #0x6ca7, LSL #32
    MOVK  X3, #0xb214, LSL #48
    SUB  X6, X3, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x4547, LSL #0
    MOVK  X3, #0xfac4, LSL #16
    MOVK  X3, #0xd172, LSL #32
    MOVK  X3, #0x3221, LSL #48
    SUB  X6, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x7623, LSL #0
    MOVK  X3, #0x1578, LSL #16
    MOVK  X3, #0x1b8d, LSL #32
    MOVK  X3, #0xf7e5, LSL #48
    SUB  X6, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x826, LSL #0
    MOVK  X3, #0x32a1, LSL #16
    MOVK  X3, #0xb5e3, LSL #32
    MOVK  X3, #0x3f03, LSL #48
    SUB  X6, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0xdd34, LSL #0
    MOVK  X3, #0x513, LSL #16
    MOVK  X3, #0x7b98, LSL #32
    MOVK  X3, #0xb6f6, LSL #48
    SUB  X6, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x40e0, LSL #0
    MOVK  X3, #0x9af9, LSL #16
    MOVK  X3, #0x558c, LSL #32
    MOVK  X3, #0x64bf, LSL #48
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x51d8, LSL #0
    MOVK  X3, #0xd66f, LSL #16
    MOVK  X3, #0x2cc3, LSL #32
    MOVK  X3, #0x4b7, LSL #48
    SUB  X6, X3, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x317, LSL #0
    MOVK  X3, #0xf28c, LSL #16
    MOVK  X3, #0x749e, LSL #32
    MOVK  X3, #0x4693, LSL #48
    SUB  X6, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x32ee, LSL #0
    MOVK  X3, #0xd418, LSL #16
    MOVK  X3, #0x552b, LSL #32
    MOVK  X3, #0x87c, LSL #48
    SUB  X6, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x95d8, LSL #0
    MOVK  X3, #0xacad, LSL #16
    MOVK  X3, #0xa71b, LSL #32
    MOVK  X3, #0xebc, LSL #48
    SUB  X6, X3, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x4955, LSL #0
    MOVK  X3, #0x9c2, LSL #16
    MOVK  X3, #0xfcf8, LSL #32
    MOVK  X3, #0x8dad, LSL #48
    SUB  X6, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x2302, LSL #0
    MOVK  X3, #0x5cf2, LSL #16
    MOVK  X3, #0xad3d, LSL #32
    MOVK  X3, #0xbde1, LSL #48
    SUB  X6, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x4c65, LSL #0
    MOVK  X3, #0xef13, LSL #16
    MOVK  X3, #0x3877, LSL #32
    MOVK  X3, #0xc6fc, LSL #48
    SUB  X6, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0xd4f5, LSL #0
    MOVK  X3, #0x2afb, LSL #16
    MOVK  X3, #0xc6e1, LSL #32
    MOVK  X3, #0xbaf, LSL #48
    SUB  X6, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0xd45c, LSL #0
    MOVK  X3, #0xb9bf, LSL #16
    MOVK  X3, #0x78ec, LSL #32
    MOVK  X3, #0x6587, LSL #48
    SUB  X6, X3, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0xbde4, LSL #0
    MOVK  X3, #0x80d0, LSL #16
    MOVK  X3, #0x491, LSL #32
    MOVK  X3, #0xebaf, LSL #48
    SUB  X6, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x694c, LSL #0
    MOVK  X3, #0x72e2, LSL #16
    MOVK  X3, #0x85b2, LSL #32
    MOVK  X3, #0x94d7, LSL #48
    SUB  X6, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x941f, LSL #0
    MOVK  X3, #0xcd8a, LSL #16
    MOVK  X3, #0x13fe, LSL #32
    MOVK  X3, #0xa06e, LSL #48
    SUB  X6, X3, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0xc574, LSL #0
    MOVK  X3, #0x5dae, LSL #16
    MOVK  X3, #0xf5b5, LSL #32
    MOVK  X3, #0xc4d5, LSL #48
    SUB  X6, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x26e, LSL #0
    MOVK  X3, #0x53e2, LSL #16
    MOVK  X3, #0x3b0b, LSL #32
    MOVK  X3, #0x2ff0, LSL #48
    SUB  X6, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x1d, LSL #0
    MRS  X6, FPSR
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V0.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D0
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x941f, LSL #0
    MOVK  X3, #0xcd8a, LSL #16
    MOVK  X3, #0x13fe, LSL #32
    MOVK  X3, #0xa06e, LSL #48
    FMOV  X6, V1.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0xbde4, LSL #0
    MOVK  X3, #0x80d0, LSL #16
    MOVK  X3, #0x491, LSL #32
    MOVK  X3, #0xebaf, LSL #48
    FMOV  X6, D1
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V2.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    FMOV  X6, D2
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x32ee, LSL #0
    MOVK  X3, #0xd418, LSL #16
    MOVK  X3, #0x552b, LSL #32
    MOVK  X3, #0x87c, LSL #48
    FMOV  X6, V3.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x51d8, LSL #0
    MOVK  X3, #0xd66f, LSL #16
    MOVK  X3, #0x2cc3, LSL #32
    MOVK  X3, #0x4b7, LSL #48
    FMOV  X6, D3
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V4.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D4
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x986d, LSL #0
    MOVK  X3, #0x90e2, LSL #16
    MOVK  X3, #0x6ca7, LSL #32
    MOVK  X3, #0xb214, LSL #48
    FMOV  X6, V5.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x32ee, LSL #0
    MOVK  X3, #0xd418, LSL #16
    MOVK  X3, #0x552b, LSL #32
    MOVK  X3, #0x87c, LSL #48
    FMOV  X6, D5
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V6.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D6
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V7.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D7
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V8.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D8
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V9.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D9
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V10.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x8000, LSL #16
    MOVK  X3, #0x78ec, LSL #32
    MOVK  X3, #0x6587, LSL #48
    FMOV  X6, D10
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V11.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D11
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V12.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D12
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x694c, LSL #0
    MOVK  X3, #0x72e2, LSL #16
    MOVK  X3, #0x85b2, LSL #32
    MOVK  X3, #0x94d7, LSL #48
    FMOV  X6, V13.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x694c, LSL #0
    MOVK  X3, #0x72e2, LSL #16
    MOVK  X3, #0x85b2, LSL #32
    MOVK  X3, #0x94d7, LSL #48
    FMOV  X6, D13
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V14.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D14
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V15.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D15
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x317, LSL #0
    MOVK  X3, #0xf28c, LSL #16
    MOVK  X3, #0x749e, LSL #32
    MOVK  X3, #0x4693, LSL #48
    FMOV  X6, V16.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x26e, LSL #0
    MOVK  X3, #0x53e2, LSL #16
    MOVK  X3, #0x3b0b, LSL #32
    MOVK  X3, #0x2ff0, LSL #48
    FMOV  X6, D16
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V17.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D17
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V18.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D18
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V19.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D19
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V20.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D20
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V21.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D21
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V22.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D22
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V23.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D23
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V24.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D24
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V25.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D25
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V26.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D26
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V27.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D27
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V28.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D28
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V29.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D29
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x7ff8, LSL #48
    FMOV  X6, V30.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D30
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V31.D[1]
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D31
    SUB  X22, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
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
    FMOV  D0, X9
    FMOV  V0.D[1], X23
    FMOV  D1, X13
    FMOV  V1.D[1], X11
    FMOV  D2, X29
    FMOV  V2.D[1], X7
    FMOV  D3, X15
    FMOV  V3.D[1], X25
    FMOV  D4, X6
    FMOV  V4.D[1], X27
    FMOV  D5, X24
    FMOV  V5.D[1], X22
    FMOV  D6, X28
    FMOV  V6.D[1], X26
    FMOV  D7, X16
    FMOV  V7.D[1], X23
    FMOV  D8, X29
    FMOV  V8.D[1], X19
    FMOV  D9, X20
    FMOV  V9.D[1], X23
    FMOV  D10, X10
    FMOV  V10.D[1], X16
    FMOV  D11, X29
    FMOV  V11.D[1], X29
    FMOV  D12, X7
    FMOV  V12.D[1], X27
    FMOV  D13, X2
    FMOV  V13.D[1], X7
    FMOV  D14, X7
    FMOV  V14.D[1], X3
    FMOV  D15, X25
    FMOV  V15.D[1], X9
    FMOV  D16, X20
    FMOV  V16.D[1], X21
    FMOV  D17, X6
    FMOV  V17.D[1], X7
    FMOV  D18, X21
    FMOV  V18.D[1], X25
    FMOV  D19, X7
    FMOV  V19.D[1], X26
    FMOV  D20, X13
    FMOV  V20.D[1], X20
    FMOV  D21, X11
    FMOV  V21.D[1], X16
    FMOV  D22, X24
    FMOV  V22.D[1], X17
    FMOV  D23, X23
    FMOV  V23.D[1], X14
    FMOV  D24, X21
    FMOV  V24.D[1], X3
    FMOV  D25, X25
    FMOV  V25.D[1], X14
    FMOV  D26, X7
    FMOV  V26.D[1], X6
    FMOV  D27, X28
    FMOV  V27.D[1], X24
    FMOV  D28, X9
    FMOV  V28.D[1], X23
    FMOV  D29, X22
    FMOV  V29.D[1], X24
    FMOV  D30, X28
    FMOV  V30.D[1], X19
    FMOV  D31, X9
    FMOV  V31.D[1], X11
    MOVZ  X28, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_4:
    FRINTP  V26.4H, V23.4H
    FRINTP  V29.4H, V31.4H
    FRINTP  V4.2D, V27.2D
    FCVTZU  V26.8H, V22.8H, #12
    FCVTNS  V6.4S, V24.4S
    FRINTI  V7.4S, V28.4S
    FRINTP  V9.8H, V29.8H
    FRINTZ  V5.2D, V6.2D
    FCVTXN2  V16.4S, V5.2D
    FRINTN  V1.2S, V16.2S
    FCVTN2  V8.4S, V1.2D
    FRINTX  V12.4H, V9.4H
    FCVTAS  V26.4H, V12.4H
    FCVTL  V15.2D, V4.2S
    FCVTZS  V13.8H, V7.8H, #7
    FCVTMU  V28.4H, V26.4H
    FRINTN  V27.2D, V8.2D
    FCVTNU  V24.4H, V27.4H
    FCVTNU  V4.4H, V15.4H
    FCVTN  V16.4H, V4.4S
    FRINTX  V26.4S, V16.4S
    FCVTNS  V31.4H, V24.4H
    FRINTM  V22.2S, V30.2S
    FCVTNS  V1.4H, V13.4H
    FCVTMS  V24.4H, V31.4H
    FRINTI  V29.2D, V18.2D
    FCVTXN2  V12.4S, V22.2D
    FCVTZS  V4.4S, V12.4S
    FCVTPS  V6.8H, V11.8H
    FRINTM  V16.2S, V28.2S
    FCVTN  V9.2S, V26.2D
    FCVTZU  V30.4S, V9.4S
    FCVTZU V28.2D, V1.2D, #41
    FCVTXN2  V18.4S, V24.2D
    FCVTNU  V22.8H, V28.8H
    FRINTM  V5.4H, V30.4H
    FRINTX  V12.4S, V18.4S
    FCVTXN  V27.2S, V22.2D
    FRINTN  V26.8H, V27.8H
    FCVTNS  V24.4H, V12.4H
    FCVTPU  V30.2S, V24.2S
    FRINTM  V9.4S, V16.4S
    FCVTNU  V16.4S, V26.4S
    FCVTMU  V7.4S, V16.4S
    FRINTX  V26.2D, V29.2D
    FCVTL2  V28.2D, V30.4S
    FCVTMU  V1.4H, V4.4H
    FCVTMU  V15.2D, V7.2D
    FRINTI  V24.8H, V15.8H
    FCVTZU  V16.8H, V5.8H, #6
    FRINTP  V15.8H, V1.8H
    FCVTZS  V12.8H, V26.8H, #13
    FRINTA  V27.4S, V9.4S
    FRINTN  V22.4S, V6.4S
    FRINTM  V6.8H, V12.8H
    FCVTZS V12.2D, V14.2D, #32
    FRINTP  V29.8H, V6.8H
    FRINTM  V30.4H, V15.4H
    FCVTN  V4.2S, V16.2D
    FRINTM  V16.4H, V28.4H
    FCVTXN2  V14.4S, V30.2D
    FCVTXN  V15.2S, V29.2D
    FCVTMU  V9.8H, V14.8H
    FCVTN2  V6.4S, V2.2D
    FCVTZS  V2.8H, V24.8H
    FCVTXN2  V28.4S, V2.2D
    FRINTN  V26.4H, V28.4H
    FCVTZS  V14.4H, V9.4H
    FCVTZS  V30.8H, V22.8H, #14
    FRINTN  V29.8H, V27.8H
    FCVTMU  V27.8H, V6.8H
    FCVTL  V6.2D, V4.2S
    FCVTAU  V22.4S, V27.4S
    FCVTPS  V24.8H, V7.8H
    FCVTZS  V28.8H, V29.8H, #2
    FRINTI  V29.4H, V26.4H
    FCVTL2  V7.2D, V29.4S
    FCVTL2  V26.2D, V6.4S
    FCVTN  V6.2S, V12.2D
    FCVTPU  V12.4H, V11.4H
    FCVTL  V29.2D, V22.2S
    FCVTZU  V4.8H, V30.8H, #13
    FCVTXN2  V27.4S, V29.2D
    FCVTZS  V2.2S, V24.2S, #16
    FRINTA  V2.8H, V7.8H
    FRINTI  V30.4H, V2.4H
    FCVTN2  V9.8H, V26.4S
    FCVTZS  V26.4S, V12.4S, #8
    FCVTAS  V24.2S, V26.2S
    FRINTA  V11.8H, V14.8H
    FCVTMS  V7.8H, V28.8H
    FCVTNU  V14.4S, V6.4S
    FRINTM  V12.2D, V27.2D
    FRINTX  V27.2S, V11.2S
    FCVTNS  V29.4H, V30.4H
    FRINTI  V6.2S, V23.2S
    FCVTZS  V30.4S, V6.4S, #24
    FCVTZS  V9.8H, V30.8H
    FRINTN  V0.2D, V24.2D
    FRINTM  V22.2D, V2.2D
    FCVTMU  V23.8H, V7.8H
    FCVTAS  V28.4S, V11.4S
    FCVTZU  V11.8H, V28.8H
    FCVTMS  V9.2D, V11.2D
    FRINTP  V28.4H, V9.4H
    FRINTZ  V26.8H, V14.8H
    FCVTPU  V30.4S, V26.4S
    FCVTNS  V9.2D, V28.2D
    FCVTAU  V2.2S, V12.2S
    FCVTZU  V14.8H, V9.8H, #10
    FCVTNS  V9.4S, V27.4S
    FCVTMS  V11.4S, V4.4S
    FCVTMS  V12.8H, V20.8H
    FCVTPU  V24.2S, V0.2S
    FCVTMU  V6.2S, V24.2S
    FRINTP  V28.4S, V12.4S
    FCVTMS  V4.4H, V30.4H
    FCVTXN  V7.2S, V23.2D
    FCVTZS  V26.8H, V4.8H
    FCVTMU  V0.8H, V2.8H
    FRINTP  V2.4H, V6.4H
    FRINTP  V23.8H, V7.8H
    FCVTZU  V7.2S, V2.2S
    FCVTN  V24.4H, V26.4S
    FRINTA  V6.8H, V11.8H
    FRINTZ  V10.2D, V28.2D
    FCVTPU  V2.4S, V0.4S
    FCVTMS  V27.8H, V14.8H
    FCVTZU  V4.4S, V7.4S
    FRINTI  V4.4H, V6.4H
    FCVTPS  V7.4H, V23.4H
    FRINTX  V30.4H, V7.4H
    FRINTZ  V12.8H, V30.8H
    FCVTAS  V26.4S, V27.4S
    FCVTL  V27.2D, V4.2S
    FCVTZS  V4.8H, V9.8H, #9
    FCVTL2  V11.4S, V4.8H
    FRINTI  V28.2S, V20.2S
    FRINTA  V15.4H, V26.4H
    FCVTPU  V20.4H, V2.4H
    FRINTA  V0.2S, V11.2S
    FCVTMS  V23.8H, V27.8H
    FCVTXN2  V27.4S, V15.2D
    FCVTAU  V14.8H, V12.8H
    FRINTN  V11.2D, V24.2D
    FRINTM  V2.4S, V10.4S
    FCVTZS  V26.4H, V13.4H, #1
    FCVTZU  V10.8H, V26.8H
    FCVTXN2  V15.4S, V2.2D
    FCVTN  V2.4H, V10.4S
    FRINTZ  V13.2S, V19.2S
    FCVTZS  V12.2S, V17.2S
    FCVTAU  V26.4H, V28.4H
    FRINTM  V4.4S, V11.4S
    FCVTAS  V10.2S, V23.2S
    FRINTX  V19.4H, V15.4H
    FCVTPU  V15.4S, V26.4S
    FCVTAU  V26.2D, V19.2D
    FRINTM  V28.8H, V14.8H
    FCVTZU  V24.4S, V0.4S, #12
    FCVTAS  V23.4H, V15.4H
    FCVTPS  V15.8H, V24.8H
    FRINTN  V24.4S, V13.4S
    FCVTAU  V0.4H, V24.4H
    FCVTZS V24.2D, V23.2D, #41
    FCVTMS  V23.4H, V26.4H
    FRINTX  V14.8H, V24.8H
    FCVTAS  V13.2S, V12.2S
    FCVTN  V17.4H, V14.4S
    FCVTPU  V11.4H, V23.4H
    FCVTMS  V23.2S, V15.2S
    FRINTI  V14.2S, V4.2S
    FCVTZU  V24.2S, V0.2S, #9
    FCVTXN  V12.2S, V11.2D
    FCVTL  V19.4S, V17.4H
    FCVTXN  V11.2S, V13.2D
    FRINTZ  V17.4H, V14.4H
    FCVTXN  V15.2S, V28.2D
    FCVTNU  V13.4S, V24.4S
    FCVTZU  V28.2S, V13.2S, #8
    FCVTZU  V13.2D, V23.2D
    FCVTPU  V24.2S, V28.2S
    FRINTX  V0.2D, V12.2D
    FCVTN2  V23.8H, V0.4S
    FRINTP  V4.2D, V23.2D
    FRINTN  V23.8H, V17.8H
    FRINTX  V17.4H, V15.4H
    FRINTZ  V28.8H, V23.8H
    FRINTM  V14.2S, V19.2S
    FCVTZU  V19.4S, V28.4S
    FCVTPU  V12.2S, V11.2S
    FCVTXN2  V0.4S, V17.2D
    FRINTP  V28.2S, V13.2S
    FRINTM  V13.2D, V19.2D
    FCVTZU V17.2D, V0.2D, #51
    FCVTAU  V11.8H, V24.8H
    FCVTZU  V23.8H, V11.8H
    FCVTN2  V0.4S, V28.2D
    FCVTMU  V15.4S, V4.4S
    FRINTZ  V24.2S, V12.2S
    SUBS  X28, X28, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_4
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X8
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x1d, LSL #0
    MRS  X27, FPSR
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V0.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D0
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V1.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D1
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V2.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D2
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V3.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D3
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V4.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D4
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V5.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D5
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V6.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D6
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V7.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D7
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V8.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D8
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V9.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D9
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V10.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D10
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V11.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D11
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V12.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D12
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V13.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D13
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V14.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D14
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V15.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D15
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V16.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D16
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V17.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D17
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V18.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D18
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V19.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D19
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V20.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D20
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V21.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D21
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V22.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D22
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V23.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D23
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V24.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D24
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V25.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D25
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V26.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D26
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V27.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D27
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V28.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D28
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V29.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D29
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V30.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D30
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, V31.D[1]
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X27, D31
    SUB  X24, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
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
    FMOV  V0.D[1], X28
    FMOV  D1, X24
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X13
    FMOV  D3, X6
    FMOV  V3.D[1], X25
    FMOV  D4, X17
    FMOV  V4.D[1], X8
    FMOV  D5, X26
    FMOV  V5.D[1], X26
    FMOV  D6, X19
    FMOV  V6.D[1], X16
    FMOV  D7, X15
    FMOV  V7.D[1], X2
    FMOV  D8, X9
    FMOV  V8.D[1], X8
    FMOV  D9, X8
    FMOV  V9.D[1], X29
    FMOV  D10, X23
    FMOV  V10.D[1], X2
    FMOV  D11, X2
    FMOV  V11.D[1], X19
    FMOV  D12, X9
    FMOV  V12.D[1], X23
    FMOV  D13, X9
    FMOV  V13.D[1], X14
    FMOV  D14, X27
    FMOV  V14.D[1], X11
    FMOV  D15, X3
    FMOV  V15.D[1], X14
    FMOV  D16, X16
    FMOV  V16.D[1], X16
    FMOV  D17, X7
    FMOV  V17.D[1], X8
    FMOV  D18, X17
    FMOV  V18.D[1], X3
    FMOV  D19, X14
    FMOV  V19.D[1], X13
    FMOV  D20, X26
    FMOV  V20.D[1], X10
    FMOV  D21, X7
    FMOV  V21.D[1], X26
    FMOV  D22, X17
    FMOV  V22.D[1], X28
    FMOV  D23, X17
    FMOV  V23.D[1], X21
    FMOV  D24, X29
    FMOV  V24.D[1], X23
    FMOV  D25, X23
    FMOV  V25.D[1], X13
    FMOV  D26, X15
    FMOV  V26.D[1], X29
    FMOV  D27, X2
    FMOV  V27.D[1], X25
    FMOV  D28, X11
    FMOV  V28.D[1], X25
    FMOV  D29, X20
    FMOV  V29.D[1], X11
    FMOV  D30, X3
    FMOV  V30.D[1], X23
    FMOV  D31, X23
    FMOV  V31.D[1], X17
    MOVZ  X10, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_5:
    FCVTZU  V21.2D, V27.2D
    FCVTPS  V6.8H, V26.8H
    FCVTNU  V28.2D, V25.2D
    FCVTL  V0.4S, V24.4H
    FCVTMU  V0.8H, V29.8H
    FCVTMS  V30.4H, V0.4H
    FCVTZU  V17.4H, V30.4H
    FCVTPU  V9.8H, V6.8H
    FCVTZS  V30.4S, V21.4S, #12
    FCVTXN2  V31.4S, V31.2D
    FRINTZ  V26.4S, V28.4S
    FCVTZS  V8.8H, V26.8H, #9
    FCVTMU  V6.4H, V8.4H
    FRINTN  V3.2D, V30.2D
    FCVTZU V20.2D, V6.2D, #41
    FCVTNS  V27.2S, V31.2S
    FRINTA  V10.2S, V29.2S
    FCVTPS  V18.4H, V17.4H
    FCVTPU  V16.8H, V30.8H
    FCVTMU  V8.4H, V9.4H
    FCVTZU  V29.4H, V10.4H, #15
    FCVTL  V8.4S, V18.4H
    FRINTZ  V6.4S, V27.4S
    FRINTA  V31.4S, V6.4S
    FCVTNS  V11.2S, V8.2S
    FRINTI  V16.4H, V20.4H
    FRINTP  V30.2D, V29.2D
    FCVTPS  V9.2D, V16.2D
    FRINTP  V20.4H, V3.4H
    FRINTX  V27.2D, V13.2D
    FRINTZ  V6.2S, V11.2S
    FRINTX  V10.8H, V6.8H
    FRINTM  V3.4S, V10.4S
    FRINTI  V21.8H, V31.8H
    FCVTMS  V11.4H, V3.4H
    FCVTMU  V31.2D, V21.2D
    FCVTPU  V26.2D, V20.2D
    FRINTZ  V17.8H, V30.8H
    FCVTN2  V20.8H, V10.4S
    FCVTZU  V6.8H, V11.8H
    FCVTN  V10.4H, V26.4S
    FRINTI  V16.4H, V20.4H
    FCVTL  V20.4S, V27.4H
    FCVTL  V18.4S, V6.4H
    FCVTNU  V21.2D, V17.2D
    FRINTP  V29.4H, V18.4H
    FCVTXN2  V3.4S, V21.2D
    FRINTZ  V21.4H, V20.4H
    FCVTMS  V18.2S, V16.2S
    FCVTL2  V11.4S, V10.8H
    FCVTL  V30.4S, V9.4H
    FCVTZU  V20.4H, V21.4H
    FRINTA  V26.4S, V11.4S
    FCVTPU  V11.8H, V31.8H
    FRINTI  V27.2S, V18.2S
    FRINTM  V16.8H, V30.8H
    FCVTNS  V21.4H, V11.4H
    FCVTXN  V9.2S, V27.2D
    FCVTPU  V30.2D, V20.2D
    FCVTPS  V10.8H, V26.8H
    FCVTPU  V18.2S, V30.2S
    FRINTM  V26.2D, V9.2D
    FCVTZU  V9.8H, V8.8H
    FCVTXN2  V26.4S, V10.2D
    FCVTZS  V27.8H, V21.8H
    FRINTP  V30.8H, V8.8H
    FRINTI  V31.8H, V30.8H
    FCVTMS  V10.4H, V31.4H
    FCVTAU  V8.2S, V10.2S
    FRINTM  V20.8H, V27.8H
    FRINTA  V27.4S, V16.4S
    FRINTI  V31.4H, V18.4H
    FRINTP  V11.4S, V20.4S
    FCVTZS  V18.4S, V8.4S
    FCVTZS  V8.2S, V18.2S
    FCVTPU  V30.2S, V27.2S
    FRINTN  V27.2D, V8.2D
    FCVTZU  V10.4S, V11.4S, #27
    FCVTMS  V20.2D, V9.2D
    FCVTXN2  V11.4S, V30.2D
    FCVTNU  V8.4H, V11.4H
    FRINTP  V21.4H, V23.4H
    FCVTNS  V23.2S, V20.2S
    FRINTX  V9.2D, V27.2D
    FCVTZU  V27.4H, V31.4H
    FCVTZU  V18.2S, V10.2S
    FCVTZS  V10.2S, V26.2S, #25
    FRINTZ  V26.4H, V27.4H
    FCVTAU  V20.4H, V26.4H
    FRINTA  V16.4S, V8.4S
    FRINTZ  V27.4S, V21.4S
    FCVTNS  V11.2D, V16.2D
    FCVTZS  V21.8H, V27.8H, #16
    FCVTMS  V8.4H, V23.4H
    FCVTPU  V23.4H, V3.4H
    FCVTN2  V30.4S, V20.2D
    FCVTNU  V20.8H, V11.8H
    FCVTL  V11.2D, V9.2S
    FCVTAU  V31.2S, V30.2S
    FCVTZS  V3.8H, V31.8H
    FCVTAS  V27.8H, V17.8H
    FCVTMU  V17.2S, V23.2S
    FCVTAU  V23.2D, V27.2D
    FRINTA  V26.4H, V21.4H
    FCVTZS V16.2D, V18.2D, #18
    FRINTI  V10.4H, V16.4H
    FCVTPU  V27.8H, V3.8H
    FRINTA  V16.8H, V8.8H
    FCVTNU  V9.4S, V17.4S
    FRINTN  V8.8H, V27.8H
    FRINTP  V24.2D, V16.2D
    FCVTL  V18.4S, V28.4H
    FCVTN  V21.2S, V8.2D
    FCVTZS  V3.4H, V11.4H
    FCVTMU  V8.4H, V24.4H
    FCVTPU  V11.4S, V8.4S
    FCVTZU  V31.4S, V18.4S
    FRINTN  V17.4H, V20.4H
    FRINTM  V27.2D, V9.2D
    FRINTZ  V20.4H, V10.4H
    FCVTPS  V16.4H, V21.4H
    FCVTZU  V21.2D, V11.2D
    FCVTMS  V11.2D, V26.2D
    FCVTNU  V30.8H, V16.8H
    FCVTMU  V8.8H, V20.8H
    FCVTPU  V28.2D, V11.2D
    FRINTN  V26.2D, V3.2D
    FCVTXN2  V11.4S, V26.2D
    FRINTP  V10.4H, V28.4H
    FCVTAS  V28.4S, V31.4S
    FCVTAS  V9.4H, V17.4H
    FCVTZU  V16.4H, V27.4H, #1
    FCVTPU  V19.4H, V11.4H
    FCVTZU V18.2D, V19.2D, #6
    FRINTZ  V20.2D, V10.2D
    FRINTI  V27.8H, V8.8H
    FCVTAS  V19.4S, V20.4S
    FCVTXN2  V3.4S, V21.2D
    FCVTZS V21.2D, V27.2D, #35
    FCVTAS  V27.4S, V4.4S
    FCVTMS  V31.4H, V27.4H
    FCVTZU  V27.4S, V3.4S
    FCVTZU  V20.4S, V30.4S
    FCVTMU  V30.8H, V18.8H
    FCVTPS  V8.8H, V19.8H
    FRINTP  V11.4S, V30.4S
    FCVTZU  V3.4H, V27.4H, #13
    FCVTPS  V21.4H, V9.4H
    FCVTAU  V4.8H, V8.8H
    FCVTZS  V30.8H, V21.8H, #4
    FCVTZU  V8.4H, V20.4H
    FCVTPU  V10.4S, V11.4S
    FCVTZU  V11.2D, V8.2D
    FCVTZS  V20.4S, V11.4S, #2
    FCVTZS  V21.2D, V3.2D
    FCVTN  V19.4H, V30.4S
    FRINTX  V27.4H, V4.4H
    FCVTZU  V8.4H, V27.4H, #15
    FRINTM  V9.8H, V8.8H
    FRINTZ  V18.4S, V31.4S
    FRINTM  V31.4H, V9.4H
    FRINTZ  V9.2D, V19.2D
    FRINTA  V8.4S, V31.4S
    FRINTX  V4.4S, V21.4S
    FCVTZU  V27.2S, V9.2S, #9
    FCVTN2  V9.8H, V20.4S
    FRINTI  V19.4H, V9.4H
    FCVTAS  V31.4H, V18.4H
    FCVTZS  V20.4H, V27.4H
    FCVTPU  V27.8H, V8.8H
    FCVTPS  V14.2D, V20.2D
    FCVTZS  V30.2S, V27.2S
    FCVTN  V20.2S, V19.2D
    FCVTZS  V3.4H, V31.4H, #3
    FCVTMS  V31.2S, V10.2S
    FCVTAS  V27.4S, V31.4S
    FCVTL  V9.2D, V3.2S
    FCVTZS  V8.8H, V30.8H, #6
    FCVTZU  V18.8H, V8.8H
    FCVTZU V10.2D, V17.2D, #31
    FCVTAS  V17.2D, V4.2D
    FCVTZU  V31.2S, V9.2S, #16
    FCVTL  V3.4S, V20.4H
    FRINTX  V19.2S, V21.2S
    FRINTZ  V4.4H, V14.4H
    FCVTZS  V21.4S, V18.4S
    FCVTZS V8.2D, V10.2D, #14
    FCVTPS  V14.4H, V21.4H
    FCVTMU  V10.2D, V27.2D
    FRINTX  V20.2D, V8.2D
    FRINTA  V30.2D, V19.2D
    FCVTL  V12.2D, V17.2S
    FCVTNS  V9.8H, V20.8H
    FCVTMU  V27.4H, V9.4H
    FRINTN  V8.4S, V14.4S
    FCVTMS  V31.8H, V10.8H
    FCVTZU  V21.2S, V30.2S
    FCVTZU V20.2D, V8.2D, #32
    FCVTPS  V14.2S, V20.2S
    FCVTZU  V19.4H, V3.4H, #3
    SUBS  X10, X10, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_5
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X22, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X22, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X22, X19, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X22, X19, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X22, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X22, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X22, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X22, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X22, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X22, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X22, X19, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X22, X19, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X22, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X22, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X22, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X22, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X22, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X22, X19, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x1d, LSL #0
    MRS  X22, FPSR
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V0.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, D0
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X22, V1.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X22, D1
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X22, V2.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X22, D2
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V3.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, D3
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V4.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, D4
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X22, V5.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X22, D5
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V6.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, D6
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X22, V7.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X22, D7
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V8.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, D8
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V9.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, D9
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V10.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, D10
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V11.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, D11
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V12.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, D12
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X22, V13.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X22, D13
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V14.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, D14
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X22, V15.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X22, D15
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V16.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, D16
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V17.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, D17
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V18.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, D18
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V19.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, D19
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V20.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, D20
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V21.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, D21
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X22, V22.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X22, D22
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V23.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, D23
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V24.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, D24
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X22, V25.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X22, D25
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V26.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, D26
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V27.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, D27
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V28.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, D28
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V29.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, D29
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V30.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, D30
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V31.D[1]
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, D31
    SUB  X27, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X2, #0x5c54, LSL #0
    MOVK  X2, #0x53ff, LSL #16
    MOVK  X2, #0x4853, LSL #32
    MOVK  X2, #0x8d26, LSL #48
    MOVZ  X3, #0x289c, LSL #0
    MOVK  X3, #0xfab2, LSL #16
    MOVK  X3, #0xd67, LSL #32
    MOVK  X3, #0xcefe, LSL #48
    MOVZ  X6, #0x1191, LSL #0
    MOVK  X6, #0x936d, LSL #16
    MOVK  X6, #0x6069, LSL #32
    MOVK  X6, #0x95ef, LSL #48
    MOVZ  X7, #0x6145, LSL #0
    MOVK  X7, #0x2a2c, LSL #16
    MOVK  X7, #0xd802, LSL #32
    MOVK  X7, #0x1ffa, LSL #48
    MOVZ  X8, #0xf717, LSL #0
    MOVK  X8, #0x9ff1, LSL #16
    MOVK  X8, #0xab30, LSL #32
    MOVK  X8, #0x61fc, LSL #48
    MOVZ  X9, #0x6c18, LSL #0
    MOVK  X9, #0xe5f6, LSL #16
    MOVK  X9, #0xc2ab, LSL #32
    MOVK  X9, #0x8ced, LSL #48
    MOVZ  X10, #0x7c3a, LSL #0
    MOVK  X10, #0x6051, LSL #16
    MOVK  X10, #0x17aa, LSL #32
    MOVK  X10, #0x3685, LSL #48
    MOVZ  X11, #0xd83a, LSL #0
    MOVK  X11, #0xf94b, LSL #16
    MOVK  X11, #0x4197, LSL #32
    MOVK  X11, #0x780a, LSL #48
    MOVZ  X13, #0xbf27, LSL #0
    MOVK  X13, #0x14cf, LSL #16
    MOVK  X13, #0x3ca4, LSL #32
    MOVK  X13, #0x9a9, LSL #48
    MOVZ  X14, #0xa92b, LSL #0
    MOVK  X14, #0xcb3f, LSL #16
    MOVK  X14, #0x309c, LSL #32
    MOVK  X14, #0x5e2, LSL #48
    MOVZ  X15, #0x20c9, LSL #0
    MOVK  X15, #0xd863, LSL #16
    MOVK  X15, #0xf694, LSL #32
    MOVK  X15, #0xdbdf, LSL #48
    MOVZ  X16, #0x7075, LSL #0
    MOVK  X16, #0x2b80, LSL #16
    MOVK  X16, #0x857d, LSL #32
    MOVK  X16, #0x2230, LSL #48
    MOVZ  X17, #0x5a39, LSL #0
    MOVK  X17, #0x30fb, LSL #16
    MOVK  X17, #0x2e0c, LSL #32
    MOVK  X17, #0x3653, LSL #48
    MOVZ  X19, #0x35e8, LSL #0
    MOVK  X19, #0x9757, LSL #16
    MOVK  X19, #0x49fe, LSL #32
    MOVK  X19, #0xdcea, LSL #48
    MOVZ  X20, #0xca85, LSL #0
    MOVK  X20, #0xcc0, LSL #16
    MOVK  X20, #0xa20b, LSL #32
    MOVK  X20, #0xbc05, LSL #48
    MOVZ  X21, #0x749b, LSL #0
    MOVK  X21, #0x5522, LSL #16
    MOVK  X21, #0xc5d, LSL #32
    MOVK  X21, #0x424f, LSL #48
    MOVZ  X22, #0xbe04, LSL #0
    MOVK  X22, #0x852b, LSL #16
    MOVK  X22, #0xf57f, LSL #32
    MOVK  X22, #0x70bf, LSL #48
    MOVZ  X23, #0xb08b, LSL #0
    MOVK  X23, #0x45f2, LSL #16
    MOVK  X23, #0x5a0d, LSL #32
    MOVK  X23, #0x6a0f, LSL #48
    MOVZ  X24, #0xc24, LSL #0
    MOVK  X24, #0xcbe9, LSL #16
    MOVK  X24, #0x3688, LSL #32
    MOVK  X24, #0xfa61, LSL #48
    MOVZ  X25, #0xe069, LSL #0
    MOVK  X25, #0xaafa, LSL #16
    MOVK  X25, #0x2526, LSL #32
    MOVK  X25, #0xa9bd, LSL #48
    MOVZ  X26, #0x9766, LSL #0
    MOVK  X26, #0xf800, LSL #16
    MOVK  X26, #0x8e67, LSL #32
    MOVK  X26, #0x6d18, LSL #48
    MOVZ  X27, #0x6642, LSL #0
    MOVK  X27, #0x2b27, LSL #16
    MOVK  X27, #0x7402, LSL #32
    MOVK  X27, #0x77cf, LSL #48
    MOVZ  X28, #0xae99, LSL #0
    MOVK  X28, #0xc682, LSL #16
    MOVK  X28, #0xf139, LSL #32
    MOVK  X28, #0xf4ad, LSL #48
    MOVZ  X29, #0x1354, LSL #0
    MOVK  X29, #0xb6c4, LSL #16
    MOVK  X29, #0x5313, LSL #32
    MOVK  X29, #0xae4, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X28
    FMOV  D1, X29
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X3
    FMOV  D3, X8
    FMOV  V3.D[1], X6
    FMOV  D4, X27
    FMOV  V4.D[1], X11
    FMOV  D5, X25
    FMOV  V5.D[1], X22
    FMOV  D6, X28
    FMOV  V6.D[1], X21
    FMOV  D7, X28
    FMOV  V7.D[1], X28
    FMOV  D8, X28
    FMOV  V8.D[1], X2
    FMOV  D9, X11
    FMOV  V9.D[1], X26
    FMOV  D10, X10
    FMOV  V10.D[1], X16
    FMOV  D11, X28
    FMOV  V11.D[1], X11
    FMOV  D12, X20
    FMOV  V12.D[1], X17
    FMOV  D13, X3
    FMOV  V13.D[1], X3
    FMOV  D14, X21
    FMOV  V14.D[1], X16
    FMOV  D15, X25
    FMOV  V15.D[1], X3
    FMOV  D16, X20
    FMOV  V16.D[1], X17
    FMOV  D17, X16
    FMOV  V17.D[1], X3
    FMOV  D18, X25
    FMOV  V18.D[1], X10
    FMOV  D19, X19
    FMOV  V19.D[1], X13
    FMOV  D20, X21
    FMOV  V20.D[1], X22
    FMOV  D21, X3
    FMOV  V21.D[1], X3
    FMOV  D22, X3
    FMOV  V22.D[1], X22
    FMOV  D23, X20
    FMOV  V23.D[1], X3
    FMOV  D24, X28
    FMOV  V24.D[1], X11
    FMOV  D25, X22
    FMOV  V25.D[1], X22
    FMOV  D26, X7
    FMOV  V26.D[1], X10
    FMOV  D27, X7
    FMOV  V27.D[1], X29
    FMOV  D28, X15
    FMOV  V28.D[1], X8
    FMOV  D29, X20
    FMOV  V29.D[1], X14
    FMOV  D30, X29
    FMOV  V30.D[1], X16
    FMOV  D31, X3
    FMOV  V31.D[1], X21
    MOVZ  X6, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_6:
    FCVTPU  V18.8H, V28.8H
    FCVTN  V6.4H, V25.4S
    FCVTNU  V14.2D, V30.2D
    FCVTPU  V24.4S, V6.4S
    FCVTN  V9.2S, V29.2D
    FRINTM  V20.4S, V24.4S
    FCVTXN2  V6.4S, V18.2D
    FCVTL2  V19.4S, V21.8H
    FCVTNU  V11.4S, V14.4S
    FRINTA  V31.4H, V9.4H
    FCVTL  V19.2D, V20.2S
    FRINTX  V10.4S, V11.4S
    FCVTL2  V30.4S, V10.8H
    FCVTZU  V3.2S, V30.2S, #30
    FCVTZS V7.2D, V19.2D, #3
    FRINTZ  V17.4H, V3.4H
    FRINTM  V3.8H, V31.8H
    FRINTN  V9.2S, V27.2S
    FRINTZ  V18.8H, V6.8H
    FCVTAS  V30.4H, V7.4H
    FCVTZU  V13.4H, V17.4H
    FRINTZ  V7.4S, V13.4S
    FCVTZS  V19.2S, V7.2S
    FRINTP  V14.4H, V17.4H
    FCVTXN  V20.2S, V3.2D
    FCVTAU  V21.4S, V9.4S
    FCVTZS  V25.4H, V14.4H, #10
    FCVTAU  V27.2S, V0.2S
    FCVTN2  V13.8H, V18.4S
    FCVTMU  V31.4S, V13.4S
    FCVTMU  V0.4H, V30.4H
    FRINTX  V10.4S, V31.4S
    FCVTN  V6.2S, V10.2D
    FCVTZU V30.2D, V19.2D, #12
    FRINTA  V19.2D, V20.2D
    FCVTMS  V7.4S, V19.4S
    FCVTZS  V11.4S, V0.4S
    FRINTI  V20.8H, V6.8H
    FRINTN  V19.2S, V30.2S
    FCVTN2  V13.4S, V21.2D
    FCVTL2  V9.4S, V7.8H
    FCVTXN  V30.2S, V27.2D
    FRINTA  V21.4H, V25.4H
    FCVTPU  V17.8H, V30.8H
    FCVTZU  V0.2S, V11.2S
    FCVTN2  V3.4S, V0.2D
    FCVTZU V11.2D, V17.2D, #32
    FCVTAU  V7.2D, V13.2D
    FCVTXN  V25.2S, V21.2D
    FCVTPS  V0.8H, V9.8H
    FCVTZS  V9.8H, V19.8H
    FCVTMS  V27.4S, V26.4S
    FCVTNS  V10.8H, V27.8H
    FCVTPU  V27.8H, V3.8H
    FCVTZU  V19.4S, V11.4S, #8
    FCVTZS  V11.4S, V27.4S, #15
    FCVTMS  V31.4H, V10.4H
    FCVTNU  V30.4H, V25.4H
    FCVTN  V27.4H, V30.4S
    FCVTZS  V3.4S, V20.4S, #6
    FRINTA  V10.8H, V19.8H
    FCVTPS  V19.4S, V27.4S
    FCVTZU  V20.8H, V9.8H, #13
    FCVTXN  V21.2S, V3.2D
    FCVTZU V26.2D, V21.2D, #19
    FCVTAU  V25.4H, V19.4H
    FRINTI  V27.2S, V10.2S
    FCVTNU  V30.2D, V0.2D
    FCVTPS  V9.4H, V11.4H
    FRINTP  V3.2D, V31.2D
    FCVTAS  V0.8H, V3.8H
    FRINTN  V10.2S, V20.2S
    FCVTPU  V3.4H, V0.4H
    FCVTZU  V21.2S, V9.2S
    FCVTAU  V19.8H, V25.8H
    FCVTZU  V11.4H, V10.4H, #9
    FCVTZU  V20.4H, V21.4H, #4
    FRINTA  V31.2D, V27.2D
    FCVTZU V27.2D, V19.2D, #31
    FRINTZ  V19.8H, V11.8H
    FCVTN2  V11.4S, V30.2D
    FCVTAS  V27.4S, V19.4S
    FRINTZ  V30.4H, V3.4H
    FCVTMU  V21.2S, V11.2S
    FCVTPU  V29.2S, V30.2S
    FCVTZU  V9.4H, V20.4H, #12
    FCVTMU  V30.4S, V9.4S
    FRINTP  V9.8H, V31.8H
    FCVTAS  V3.4S, V27.4S
    FCVTZU  V10.8H, V30.8H, #9
    FCVTL  V25.2D, V10.2S
    FRINTZ  V0.4S, V21.4S
    FCVTNS  V19.2D, V9.2D
    FCVTXN2  V11.4S, V29.2D
    FCVTZS  V20.8H, V11.8H, #9
    FCVTZU  V30.2S, V0.2S, #18
    FCVTZS V27.2D, V20.2D, #37
    FRINTN  V10.4H, V3.4H
    FRINTZ  V20.4H, V30.4H
    FCVTAS  V31.4H, V19.4H
    FCVTZS V0.2D, V31.2D, #47
    FCVTNU  V31.4H, V10.4H
    FCVTZU  V15.8H, V20.8H, #15
    FCVTAS  V30.2S, V27.2S
    FCVTL2  V10.2D, V30.4S
    FRINTX  V29.8H, V10.8H
    FCVTL  V3.2D, V26.2S
    FRINTA  V19.2S, V3.2S
    FCVTMS  V30.8H, V15.8H
    FCVTAS  V26.8H, V19.8H
    FCVTL2  V11.2D, V0.4S
    FCVTZS  V10.4S, V31.4S
    FCVTZS  V9.2S, V26.2S
    FRINTP  V0.8H, V9.8H
    FCVTPS  V19.4H, V10.4H
    FRINTP  V26.8H, V29.8H
    FCVTXN  V3.2S, V11.2D
    FCVTAS  V10.4S, V0.4S
    FCVTZU  V0.4H, V26.4H, #7
    FRINTA  V15.4S, V0.4S
    FCVTMS  V31.4S, V15.4S
    FRINTM  V20.4H, V30.4H
    FCVTMS  V30.8H, V31.8H
    FCVTPS  V31.2D, V10.2D
    FRINTP  V26.8H, V3.8H
    FRINTA  V3.2S, V19.2S
    FCVTZS  V0.4S, V3.4S, #27
    FCVTNU  V19.4H, V0.4H
    FCVTZS V10.2D, V20.2D, #61
    FCVTNS  V20.2S, V30.2S
    FRINTA  V15.4S, V15.4S
    FRINTP  V29.2S, V19.2S
    FCVTMU  V9.4H, V26.4H
    FRINTZ  V19.4H, V20.4H
    FCVTPS  V12.8H, V2.8H
    FCVTZU  V11.4S, V12.4S
    FCVTNS  V12.2S, V10.2S
    FRINTZ  V3.4S, V10.4S
    FCVTAS  V1.4H, V12.4H
    FRINTZ  V0.4S, V31.4S
    FCVTPU  V24.2S, V15.2S
    FCVTXN  V15.2S, V24.2D
    FRINTX  V30.4H, V3.4H
    FRINTP  V20.2D, V11.2D
    FRINTM  V3.4H, V15.4H
    FCVTNS  V24.2S, V20.2S
    FCVTZU  V2.8H, V19.8H
    FRINTI  V11.8H, V2.8H
    FCVTN2  V19.4S, V1.2D
    FCVTL2  V2.4S, V0.8H
    FCVTZU  V16.8H, V9.8H
    FRINTM  V12.4H, V30.4H
    FCVTN  V31.4H, V19.4S
    FCVTL2  V1.2D, V29.4S
    FCVTMS  V0.2S, V3.2S
    FCVTNU  V3.2S, V1.2S
    FCVTNS  V1.8H, V14.8H
    FRINTX  V15.8H, V31.8H
    FRINTN  V9.2S, V1.2S
    FRINTZ  V30.8H, V12.8H
    FRINTP  V20.8H, V3.8H
    FCVTMU  V1.8H, V2.8H
    FCVTNU  V29.4S, V24.4S
    FCVTZU  V12.8H, V15.8H
    FCVTN2  V14.8H, V20.4S
    FCVTZS  V15.4S, V14.4S, #4
    FRINTA  V19.4H, V1.4H
    FCVTPU  V2.2D, V15.2D
    FCVTPS  V14.4H, V30.4H
    FRINTA  V24.8H, V19.8H
    FCVTMU  V3.4H, V12.4H
    FCVTZS V12.2D, V2.2D, #21
    FRINTZ  V2.4H, V16.4H
    FCVTPS  V20.2D, V29.2D
    FCVTAU  V30.2D, V14.2D
    FCVTZS  V31.2S, V24.2S
    FCVTZU V19.2D, V30.2D, #33
    FCVTMU  V14.2D, V3.2D
    FRINTN  V1.4H, V9.4H
    FRINTX  V15.4H, V1.4H
    FRINTN  V1.8H, V12.8H
    FCVTPU  V16.2D, V14.2D
    FCVTZS  V14.2D, V19.2D
    FCVTAU  V12.2D, V16.2D
    FCVTAS  V19.2D, V12.2D
    FCVTNU  V30.2S, V19.2S
    FCVTZU  V24.4S, V30.4S
    FRINTP  V29.4H, V31.4H
    FCVTN  V30.2S, V14.2D
    FCVTMU  V9.2D, V30.2D
    FCVTZS  V19.2S, V20.2S, #2
    FCVTZS  V16.4H, V1.4H, #4
    FCVTL2  V3.2D, V24.4S
    FCVTNS  V20.2D, V15.2D
    FCVTAS  V15.2D, V16.2D
    FCVTXN2  V14.4S, V2.2D
    FRINTA  V2.8H, V22.8H
    FCVTZU V24.2D, V19.2D, #61
    FCVTZS  V31.2S, V24.2S, #2
    FCVTMS  V30.4H, V14.4H
    SUBS  X6, X6, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_6
    MOVZ  X20, #0x5c54, LSL #0
    MOVK  X20, #0x53ff, LSL #16
    MOVK  X20, #0x4853, LSL #32
    MOVK  X20, #0x8d26, LSL #48
    SUB  X13, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x289c, LSL #0
    MOVK  X20, #0xfab2, LSL #16
    MOVK  X20, #0xd67, LSL #32
    MOVK  X20, #0xcefe, LSL #48
    SUB  X13, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x6145, LSL #0
    MOVK  X20, #0x2a2c, LSL #16
    MOVK  X20, #0xd802, LSL #32
    MOVK  X20, #0x1ffa, LSL #48
    SUB  X13, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0xf717, LSL #0
    MOVK  X20, #0x9ff1, LSL #16
    MOVK  X20, #0xab30, LSL #32
    MOVK  X20, #0x61fc, LSL #48
    SUB  X13, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x6c18, LSL #0
    MOVK  X20, #0xe5f6, LSL #16
    MOVK  X20, #0xc2ab, LSL #32
    MOVK  X20, #0x8ced, LSL #48
    SUB  X13, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x7c3a, LSL #0
    MOVK  X20, #0x6051, LSL #16
    MOVK  X20, #0x17aa, LSL #32
    MOVK  X20, #0x3685, LSL #48
    SUB  X13, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0xd83a, LSL #0
    MOVK  X20, #0xf94b, LSL #16
    MOVK  X20, #0x4197, LSL #32
    MOVK  X20, #0x780a, LSL #48
    SUB  X13, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0xa92b, LSL #0
    MOVK  X20, #0xcb3f, LSL #16
    MOVK  X20, #0x309c, LSL #32
    MOVK  X20, #0x5e2, LSL #48
    SUB  X13, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x20c9, LSL #0
    MOVK  X20, #0xd863, LSL #16
    MOVK  X20, #0xf694, LSL #32
    MOVK  X20, #0xdbdf, LSL #48
    SUB  X13, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x7075, LSL #0
    MOVK  X20, #0x2b80, LSL #16
    MOVK  X20, #0x857d, LSL #32
    MOVK  X20, #0x2230, LSL #48
    SUB  X13, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x5a39, LSL #0
    MOVK  X20, #0x30fb, LSL #16
    MOVK  X20, #0x2e0c, LSL #32
    MOVK  X20, #0x3653, LSL #48
    SUB  X13, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x35e8, LSL #0
    MOVK  X20, #0x9757, LSL #16
    MOVK  X20, #0x49fe, LSL #32
    MOVK  X20, #0xdcea, LSL #48
    SUB  X13, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x749b, LSL #0
    MOVK  X20, #0x5522, LSL #16
    MOVK  X20, #0xc5d, LSL #32
    MOVK  X20, #0x424f, LSL #48
    SUB  X13, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0xbe04, LSL #0
    MOVK  X20, #0x852b, LSL #16
    MOVK  X20, #0xf57f, LSL #32
    MOVK  X20, #0x70bf, LSL #48
    SUB  X13, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0xc24, LSL #0
    MOVK  X20, #0xcbe9, LSL #16
    MOVK  X20, #0x3688, LSL #32
    MOVK  X20, #0xfa61, LSL #48
    SUB  X13, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0xe069, LSL #0
    MOVK  X20, #0xaafa, LSL #16
    MOVK  X20, #0x2526, LSL #32
    MOVK  X20, #0xa9bd, LSL #48
    SUB  X13, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x9766, LSL #0
    MOVK  X20, #0xf800, LSL #16
    MOVK  X20, #0x8e67, LSL #32
    MOVK  X20, #0x6d18, LSL #48
    SUB  X13, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x6642, LSL #0
    MOVK  X20, #0x2b27, LSL #16
    MOVK  X20, #0x7402, LSL #32
    MOVK  X20, #0x77cf, LSL #48
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0xae99, LSL #0
    MOVK  X20, #0xc682, LSL #16
    MOVK  X20, #0xf139, LSL #32
    MOVK  X20, #0xf4ad, LSL #48
    SUB  X13, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x1354, LSL #0
    MOVK  X20, #0xb6c4, LSL #16
    MOVK  X20, #0x5313, LSL #32
    MOVK  X20, #0xae4, LSL #48
    SUB  X13, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x1d, LSL #0
    MRS  X13, FPSR
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V0.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, D0
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V1.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, D1
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0xc000, LSL #0
    MOVK  X20, #0x8000, LSL #16
    MOVK  X20, #0xf57f, LSL #32
    MOVK  X20, #0x70bf, LSL #48
    FMOV  X13, V2.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0xfab2, LSL #16
    MOVK  X20, #0xcf00, LSL #48
    FMOV  X13, D2
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V3.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, D3
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0xd83a, LSL #0
    MOVK  X20, #0xf94b, LSL #16
    MOVK  X20, #0x4197, LSL #32
    MOVK  X20, #0x780a, LSL #48
    FMOV  X13, V4.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x6642, LSL #0
    MOVK  X20, #0x2b27, LSL #16
    MOVK  X20, #0x7402, LSL #32
    MOVK  X20, #0x77cf, LSL #48
    FMOV  X13, D4
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0xbe04, LSL #0
    MOVK  X20, #0x852b, LSL #16
    MOVK  X20, #0xf57f, LSL #32
    MOVK  X20, #0x70bf, LSL #48
    FMOV  X13, V5.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0xe069, LSL #0
    MOVK  X20, #0xaafa, LSL #16
    MOVK  X20, #0x2526, LSL #32
    MOVK  X20, #0xa9bd, LSL #48
    FMOV  X13, D5
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V6.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, D6
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V7.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, D7
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x5c54, LSL #0
    MOVK  X20, #0x53ff, LSL #16
    MOVK  X20, #0x4853, LSL #32
    MOVK  X20, #0x8d26, LSL #48
    FMOV  X13, V8.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0xae99, LSL #0
    MOVK  X20, #0xc682, LSL #16
    MOVK  X20, #0xf139, LSL #32
    MOVK  X20, #0xf4ad, LSL #48
    FMOV  X13, D8
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V9.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, D9
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V10.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, D10
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V11.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, D11
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V12.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, D12
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V13.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, D13
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V14.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, D14
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V15.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, D15
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V16.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, D16
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V17.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, D17
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V18.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, D18
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V19.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, D19
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V20.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, D20
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V21.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, D21
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0xbe04, LSL #0
    MOVK  X20, #0x852b, LSL #16
    MOVK  X20, #0xf57f, LSL #32
    MOVK  X20, #0x70bf, LSL #48
    FMOV  X13, V22.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x289c, LSL #0
    MOVK  X20, #0xfab2, LSL #16
    MOVK  X20, #0xd67, LSL #32
    MOVK  X20, #0xcefe, LSL #48
    FMOV  X13, D22
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x289c, LSL #0
    MOVK  X20, #0xfab2, LSL #16
    MOVK  X20, #0xd67, LSL #32
    MOVK  X20, #0xcefe, LSL #48
    FMOV  X13, V23.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0xca85, LSL #0
    MOVK  X20, #0xcc0, LSL #16
    MOVK  X20, #0xa20b, LSL #32
    MOVK  X20, #0xbc05, LSL #48
    FMOV  X13, D23
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V24.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, D24
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V25.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, D25
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V26.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, D26
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V27.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, D27
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0xf717, LSL #0
    MOVK  X20, #0x9ff1, LSL #16
    MOVK  X20, #0xab30, LSL #32
    MOVK  X20, #0x61fc, LSL #48
    FMOV  X13, V28.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x20c9, LSL #0
    MOVK  X20, #0xd863, LSL #16
    MOVK  X20, #0xf694, LSL #32
    MOVK  X20, #0xdbdf, LSL #48
    FMOV  X13, D28
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V29.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, D29
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V30.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, D30
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V31.D[1]
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, D31
    SUB  X23, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
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
    FMOV  V0.D[1], X10
    FMOV  D1, X29
    FMOV  V1.D[1], X26
    FMOV  D2, X19
    FMOV  V2.D[1], X11
    FMOV  D3, X27
    FMOV  V3.D[1], X23
    FMOV  D4, X25
    FMOV  V4.D[1], X21
    FMOV  D5, X9
    FMOV  V5.D[1], X24
    FMOV  D6, X22
    FMOV  V6.D[1], X28
    FMOV  D7, X21
    FMOV  V7.D[1], X20
    FMOV  D8, X20
    FMOV  V8.D[1], X10
    FMOV  D9, X26
    FMOV  V9.D[1], X20
    FMOV  D10, X10
    FMOV  V10.D[1], X15
    FMOV  D11, X27
    FMOV  V11.D[1], X23
    FMOV  D12, X23
    FMOV  V12.D[1], X19
    FMOV  D13, X2
    FMOV  V13.D[1], X25
    FMOV  D14, X27
    FMOV  V14.D[1], X6
    FMOV  D15, X19
    FMOV  V15.D[1], X29
    FMOV  D16, X26
    FMOV  V16.D[1], X29
    FMOV  D17, X26
    FMOV  V17.D[1], X10
    FMOV  D18, X26
    FMOV  V18.D[1], X23
    FMOV  D19, X14
    FMOV  V19.D[1], X28
    FMOV  D20, X28
    FMOV  V20.D[1], X13
    FMOV  D21, X15
    FMOV  V21.D[1], X20
    FMOV  D22, X21
    FMOV  V22.D[1], X3
    FMOV  D23, X7
    FMOV  V23.D[1], X2
    FMOV  D24, X29
    FMOV  V24.D[1], X3
    FMOV  D25, X9
    FMOV  V25.D[1], X24
    FMOV  D26, X27
    FMOV  V26.D[1], X20
    FMOV  D27, X23
    FMOV  V27.D[1], X3
    FMOV  D28, X19
    FMOV  V28.D[1], X15
    FMOV  D29, X13
    FMOV  V29.D[1], X15
    FMOV  D30, X13
    FMOV  V30.D[1], X20
    FMOV  D31, X29
    FMOV  V31.D[1], X16
    MOVZ  X7, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_7:
    FRINTN  V15.2S, V22.2S
    FRINTA  V17.2S, V29.2S
    FRINTP  V10.4S, V26.4S
    FCVTN  V3.4H, V19.4S
    FCVTXN2  V6.4S, V15.2D
    FCVTNS  V13.8H, V3.8H
    FCVTZU V4.2D, V30.2D, #58
    FCVTZS  V7.4S, V17.4S, #21
    FCVTAS  V26.2S, V27.2S
    FCVTAU  V28.4H, V28.4H
    FCVTN  V7.4H, V7.4S
    FCVTZS  V30.8H, V23.8H, #4
    FCVTNU  V7.4S, V6.4S
    FCVTN2  V24.4S, V13.2D
    FRINTP  V7.8H, V10.8H
    FRINTI  V22.2S, V28.2S
    FRINTP  V31.2D, V31.2D
    FRINTN  V22.4H, V4.4H
    FCVTZU  V23.4S, V26.4S, #8
    FRINTA  V18.4H, V22.4H
    FCVTNS  V19.4S, V18.4S
    FRINTZ  V8.8H, V30.8H
    FCVTZS  V2.2S, V24.2S, #21
    FRINTA  V27.8H, V7.8H
    FRINTZ  V17.2S, V8.2S
    FCVTPS  V29.4H, V27.4H
    FCVTZS  V13.4H, V19.4H
    FCVTZS V19.2D, V20.2D, #13
    FRINTN  V30.4S, V23.4S
    FCVTNS  V27.2D, V31.2D
    FCVTPU  V24.2D, V2.2D
    FCVTN  V10.2S, V23.2D
    FCVTL2  V28.4S, V19.8H
    FCVTAU  V18.2S, V17.2S
    FCVTXN  V4.2S, V29.2D
    FCVTZU  V29.4S, V18.4S
    FCVTXN  V22.2S, V24.2D
    FRINTN  V8.4H, V27.4H
    FCVTPS  V19.4H, V28.4H
    FCVTZU  V18.2D, V19.2D
    FCVTMU  V7.4H, V4.4H
    FCVTAU  V2.4H, V6.4H
    FCVTAU  V28.4H, V2.4H
    FCVTMS  V20.8H, V7.8H
    FRINTP  V17.8H, V18.8H
    FCVTPS  V23.8H, V22.8H
    FRINTZ  V2.2D, V13.2D
    FCVTXN  V19.2S, V8.2D
    FRINTX  V6.8H, V23.8H
    FRINTN  V22.8H, V28.8H
    FRINTI  V24.8H, V20.8H
    FCVTAU  V4.2D, V29.2D
    FCVTMS  V7.4S, V17.4S
    FCVTXN  V8.2S, V7.2D
    FCVTXN  V18.2S, V19.2D
    FCVTNS  V13.2D, V6.2D
    FCVTXN  V27.2S, V13.2D
    FCVTAS  V29.4S, V2.4S
    FCVTAU  V23.4H, V10.4H
    FCVTAU  V17.8H, V27.8H
    FRINTA  V27.4S, V8.4S
    FCVTPU  V19.8H, V17.8H
    FRINTX  V7.4H, V4.4H
    FRINTX  V17.4S, V27.4S
    FCVTZS  V2.4H, V24.4H, #1
    FCVTXN2  V24.4S, V2.2D
    FCVTNU  V4.4H, V18.4H
    FCVTL  V27.4S, V17.4H
    FCVTNU  V20.2S, V22.2S
    FCVTAS  V2.8H, V4.8H
    FCVTPS  V17.8H, V19.8H
    FRINTP  V4.4H, V23.4H
    FRINTP  V22.8H, V27.8H
    FCVTZU  V18.4S, V22.4S
    FCVTAU  V13.4S, V24.4S
    FCVTMU  V23.4H, V13.4H
    FCVTNU  V22.2S, V18.2S
    FRINTI  V27.8H, V7.8H
    FCVTZU  V19.4H, V20.4H, #15
    FCVTZS  V20.8H, V17.8H
    FRINTN  V24.2S, V23.2S
    FCVTMS  V23.2D, V27.2D
    FRINTN  V27.8H, V4.8H
    FCVTZU  V4.4S, V22.4S
    FCVTXN2  V8.4S, V23.2D
    FCVTPS  V6.4H, V8.4H
    FRINTI  V13.8H, V29.8H
    FCVTAU  V17.2S, V19.2S
    FRINTX  V18.8H, V4.8H
    FCVTZU  V4.8H, V20.8H, #1
    FRINTX  V29.2D, V17.2D
    FRINTM  V7.4H, V27.4H
    FCVTNU  V8.4H, V7.4H
    FRINTN  V19.2D, V18.2D
    FCVTXN  V18.2S, V19.2D
    FCVTMS  V23.4H, V2.4H
    FRINTZ  V20.8H, V6.8H
    FCVTMS  V7.8H, V20.8H
    FRINTP  V25.4S, V23.4S
    FCVTZU  V19.2S, V18.2S, #15
    FRINTX  V22.4H, V8.4H
    FCVTZS  V17.2S, V25.2S
    FRINTM  V25.8H, V29.8H
    FCVTAU  V2.4H, V19.4H
    FRINTP  V23.4H, V17.4H
    FCVTZS  V6.4H, V13.4H
    FRINTA  V8.2D, V22.2D
    FCVTZU  V18.8H, V23.8H
    FCVTZS  V22.8H, V25.8H, #9
    FCVTZS  V20.4H, V4.4H
    FRINTM  V27.4S, V24.4S
    FCVTAU  V24.2S, V2.2S
    FCVTNS  V27.4S, V24.4S
    FCVTNS  V13.4H, V26.4H
    FRINTM  V23.8H, V6.8H
    FCVTZS V2.2D, V8.2D, #6
    FCVTXN2  V24.4S, V23.2D
    FCVTZS  V23.8H, V7.8H
    FCVTNU  V0.4H, V24.4H
    FCVTZS V29.2D, V20.2D, #26
    FCVTNU  V7.4S, V27.4S
    FRINTX  V26.4S, V0.4S
    FCVTL  V6.4S, V26.4H
    FCVTNS  V25.8H, V18.8H
    FRINTP  V17.2D, V0.2D
    FCVTN2  V0.4S, V22.2D
    FRINTP  V24.2D, V0.2D
    FCVTN2  V26.4S, V2.2D
    FCVTNU  V4.2S, V13.2S
    FCVTZS  V13.4H, V23.4H, #2
    FCVTL  V22.2D, V25.2S
    FRINTM  V23.2D, V6.2D
    FRINTN  V18.8H, V23.8H
    FCVTZU V20.2D, V17.2D, #26
    FCVTN  V25.4H, V18.4S
    FCVTPU  V8.4S, V24.4S
    FCVTZS V18.2D, V22.2D, #50
    FRINTM  V10.4H, V23.4H
    FRINTN  V27.2D, V4.2D
    FCVTPU  V2.2S, V7.2S
    FCVTMU  V29.8H, V29.8H
    FCVTZU V0.2D, V20.2D, #44
    FCVTMS  V24.8H, V0.8H
    FCVTZS V17.2D, V18.2D, #50
    FCVTZS  V24.4S, V26.4S, #17
    FCVTZS V18.2D, V10.2D, #7
    FCVTZS  V10.4H, V27.4H, #15
    FCVTMU  V26.4S, V24.4S
    FCVTZS  V24.2S, V13.2S
    FCVTXN2  V6.4S, V24.2D
    FRINTA  V24.4H, V10.4H
    FRINTN  V13.4S, V25.4S
    FCVTNU  V23.2D, V2.2D
    FCVTL  V23.4S, V22.4H
    FRINTP  V10.2D, V17.2D
    FCVTZU  V17.4S, V29.4S, #25
    FRINTA  V20.4H, V18.4H
    FCVTPU  V22.2S, V20.2S
    FCVTL  V18.2D, V26.2S
    FCVTMS  V29.4S, V13.4S
    FCVTAU  V27.4S, V6.4S
    FCVTN  V4.2S, V27.2D
    FCVTMS  V0.8H, V4.8H
    FCVTMU  V7.2S, V23.2S
    FCVTZS  V11.4H, V24.4H, #4
    FRINTI  V29.4S, V10.4S
    FCVTMU  V25.2S, V7.2S
    FCVTNU  V7.4H, V29.4H
    FCVTPS  V4.2D, V7.2D
    FRINTX  V6.2D, V11.2D
    FCVTZS V26.2D, V25.2D, #49
    FCVTL2  V27.2D, V0.4S
    FCVTMS  V20.2S, V6.2S
    FRINTX  V23.2S, V17.2S
    FCVTZS V29.2D, V23.2D, #5
    FRINTZ  V23.4S, V27.4S
    FCVTXN2  V24.4S, V4.2D
    FCVTMS  V2.8H, V26.8H
    FCVTNS  V7.4H, V18.4H
    FRINTA  V10.4H, V23.4H
    FCVTN2  V25.4S, V10.2D
    FCVTMU  V11.4S, V7.4S
    FCVTPU  V18.4H, V22.4H
    FCVTPU  V0.8H, V25.8H
    FCVTZU  V27.8H, V20.8H, #10
    FRINTP  V20.8H, V2.8H
    FRINTP  V6.8H, V20.8H
    FRINTN  V2.2D, V27.2D
    FCVTL2  V17.4S, V18.8H
    FCVTN  V13.2S, V0.2D
    FCVTZU  V23.4S, V13.4S, #32
    FCVTPS  V4.4S, V11.4S
    FCVTN2  V22.8H, V6.4S
    FRINTA  V25.4H, V2.4H
    FCVTMU  V11.4S, V17.4S
    FCVTXN2  V27.4S, V11.2D
    FCVTNU  V26.4S, V24.4S
    FCVTZU  V17.8H, V22.8H, #10
    FRINTM  V30.2D, V27.2D
    FCVTL2  V20.2D, V4.4S
    SUBS  X7, X7, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_7
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x1d, LSL #0
    MRS  X3, FPSR
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V0.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D0
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V1.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D1
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V2.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D2
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V3.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D3
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V4.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D4
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V5.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D5
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V6.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D6
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V7.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D7
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V8.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D8
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V9.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D9
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V10.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D10
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V11.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D11
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V12.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D12
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V13.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D13
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V14.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D14
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V15.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D15
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V16.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D16
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V17.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D17
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V18.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D18
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V19.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D19
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V20.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D20
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V21.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D21
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V22.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D22
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V23.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D23
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V24.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D24
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V25.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D25
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V26.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D26
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V27.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D27
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V28.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D28
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V29.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D29
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V30.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D30
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V31.D[1]
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D31
    SUB  X22, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
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
    FMOV  V0.D[1], X29
    FMOV  D1, X23
    FMOV  V1.D[1], X24
    FMOV  D2, X27
    FMOV  V2.D[1], X28
    FMOV  D3, X17
    FMOV  V3.D[1], X21
    FMOV  D4, X9
    FMOV  V4.D[1], X17
    FMOV  D5, X23
    FMOV  V5.D[1], X27
    FMOV  D6, X10
    FMOV  V6.D[1], X23
    FMOV  D7, X27
    FMOV  V7.D[1], X19
    FMOV  D8, X7
    FMOV  V8.D[1], X19
    FMOV  D9, X11
    FMOV  V9.D[1], X6
    FMOV  D10, X27
    FMOV  V10.D[1], X13
    FMOV  D11, X2
    FMOV  V11.D[1], X13
    FMOV  D12, X24
    FMOV  V12.D[1], X26
    FMOV  D13, X14
    FMOV  V13.D[1], X7
    FMOV  D14, X3
    FMOV  V14.D[1], X22
    FMOV  D15, X23
    FMOV  V15.D[1], X20
    FMOV  D16, X10
    FMOV  V16.D[1], X17
    FMOV  D17, X6
    FMOV  V17.D[1], X16
    FMOV  D18, X17
    FMOV  V18.D[1], X9
    FMOV  D19, X16
    FMOV  V19.D[1], X26
    FMOV  D20, X26
    FMOV  V20.D[1], X11
    FMOV  D21, X3
    FMOV  V21.D[1], X29
    FMOV  D22, X16
    FMOV  V22.D[1], X27
    FMOV  D23, X23
    FMOV  V23.D[1], X13
    FMOV  D24, X11
    FMOV  V24.D[1], X3
    FMOV  D25, X29
    FMOV  V25.D[1], X3
    FMOV  D26, X14
    FMOV  V26.D[1], X8
    FMOV  D27, X7
    FMOV  V27.D[1], X8
    FMOV  D28, X13
    FMOV  V28.D[1], X15
    FMOV  D29, X28
    FMOV  V29.D[1], X11
    FMOV  D30, X3
    FMOV  V30.D[1], X6
    FMOV  D31, X14
    FMOV  V31.D[1], X7
    MOVZ  X14, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_8:
    FRINTA  V4.4H, V29.4H
    FRINTN  V7.8H, V26.8H
    FCVTMS  V21.2D, V18.2D
    FCVTAS  V24.8H, V28.8H
    FCVTL  V14.2D, V27.2S
    FRINTN  V1.2S, V30.2S
    FRINTX  V16.4H, V25.4H
    FCVTMS  V11.2D, V16.2D
    FRINTZ  V6.2S, V11.2S
    FCVTZS  V31.8H, V6.8H, #3
    FCVTAS  V28.4S, V1.4S
    FCVTPU  V6.8H, V14.8H
    FCVTNU  V24.8H, V6.8H
    FRINTX  V23.4S, V7.4S
    FCVTZS  V16.8H, V21.8H, #3
    FRINTP  V9.4S, V16.4S
    FCVTPS  V18.4H, V23.4H
    FRINTX  V7.2S, V18.2S
    FCVTZS  V9.8H, V9.8H
    FCVTZS  V24.8H, V9.8H, #9
    FCVTNS  V19.4H, V0.4H
    FRINTP  V21.4H, V31.4H
    FRINTI  V18.4S, V28.4S
    FRINTA  V16.8H, V7.8H
    FRINTA  V28.4S, V19.4S
    FRINTA  V9.2D, V28.2D
    FCVTN  V30.2S, V16.2D
    FRINTI  V0.8H, V9.8H
    FRINTA  V31.2D, V30.2D
    FRINTP  V7.2D, V31.2D
    FRINTI  V19.8H, V18.8H
    FCVTZU  V9.4S, V4.4S, #28
    FCVTL  V31.4S, V7.4H
    FCVTNS  V27.4H, V9.4H
    FCVTZU  V16.4H, V24.4H
    FCVTXN  V18.2S, V16.2D
    FCVTL  V7.4S, V31.4H
    FRINTI  V24.4S, V0.4S
    FCVTNS  V23.4S, V21.4S
    FCVTZU  V16.2D, V7.2D
    FRINTX  V30.2D, V16.2D
    FRINTN  V14.4H, V6.4H
    FRINTZ  V28.8H, V23.8H
    FCVTL  V11.4S, V28.4H
    FRINTN  V9.4S, V30.4S
    FRINTN  V4.4H, V18.4H
    FCVTNU  V30.4S, V25.4S
    FRINTI  V25.4S, V11.4S
    FRINTZ  V31.4S, V31.4S
    FCVTMS  V16.4S, V30.4S
    FCVTN  V11.2S, V4.2D
    FCVTPU  V28.2D, V11.2D
    FRINTZ  V7.2S, V9.2S
    FRINTZ  V9.8H, V25.8H
    FRINTI  V25.2S, V31.2S
    FRINTP  V30.8H, V27.8H
    FRINTA  V27.8H, V14.8H
    FRINTM  V18.4S, V19.4S
    FRINTP  V11.4H, V18.4H
    FCVTMU  V23.4S, V16.4S
    FCVTZS  V6.4H, V23.4H, #10
    FCVTZS  V31.4S, V28.4S
    FCVTPU  V18.2D, V6.2D
    FRINTI  V14.8H, V7.8H
    FCVTMS  V19.4S, V31.4S
    FRINTA  V31.4H, V11.4H
    FRINTA  V28.8H, V31.8H
    FCVTNS  V16.4H, V9.4H
    FRINTI  V21.2S, V25.2S
    FCVTZU  V11.4H, V30.4H
    FRINTM  V23.2D, V27.2D
    FRINTP  V7.4H, V19.4H
    FCVTZU  V6.4H, V28.4H
    FCVTZU  V4.2S, V7.2S
    FCVTPS  V7.4S, V16.4S
    FCVTNU  V31.8H, V14.8H
    FCVTZU  V19.4S, V7.4S, #17
    FCVTN2  V30.4S, V6.2D
    FCVTZU V7.2D, V4.2D, #53
    FCVTZU  V16.8H, V31.8H
    FRINTM  V9.4S, V7.4S
    FRINTN  V14.4H, V18.4H
    FRINTP  V18.4S, V9.4S
    FCVTMS  V27.4H, V30.4H
    FCVTZS V9.2D, V21.2D, #60
    FCVTN2  V7.8H, V19.4S
    FCVTL2  V19.2D, V23.4S
    FRINTZ  V22.4H, V14.4H
    FCVTZU  V25.4H, V7.4H
    FRINTP  V6.8H, V11.8H
    FCVTXN  V3.2S, V25.2D
    FCVTZU V7.2D, V31.2D, #60
    FCVTNS  V25.2D, V7.2D
    FCVTAU  V7.2D, V16.2D
    FCVTAU  V23.2S, V6.2S
    FCVTZS  V31.2S, V27.2S
    FRINTN  V11.4H, V18.4H
    FCVTL2  V27.2D, V9.4S
    FCVTZS  V16.4H, V23.4H
    FCVTZS  V4.4S, V7.4S
    FRINTA  V30.8H, V4.8H
    FCVTXN2  V18.4S, V3.2D
    FCVTAU  V14.8H, V30.8H
    FCVTAU  V9.2S, V31.2S
    FRINTZ  V6.2S, V30.2S
    FCVTZU  V31.4H, V22.4H
    FCVTZU  V23.8H, V27.8H
    FCVTNS  V3.4S, V16.4S
    FRINTX  V30.2S, V3.2S
    FRINTN  V22.8H, V31.8H
    FCVTL2  V4.2D, V9.4S
    FCVTZS  V7.8H, V6.8H
    FCVTZS  V6.4H, V11.4H
    FCVTXN  V11.2S, V30.2D
    FCVTN2  V30.8H, V23.4S
    FCVTNU  V31.2S, V14.2S
    FCVTZS  V9.2S, V6.2S
    FCVTNU  V14.8H, V25.8H
    FRINTP  V6.4S, V12.4S
    FCVTMS  V3.4S, V18.4S
    FRINTM  V17.2S, V11.2S
    FRINTX  V23.8H, V18.8H
    FCVTNS  V27.2D, V6.2D
    FRINTM  V6.2D, V30.2D
    FCVTPS  V25.2S, V6.2S
    FCVTZS  V12.8H, V31.8H, #14
    FRINTA  V30.4H, V4.4H
    FCVTAS  V11.4H, V30.4H
    FCVTZU  V30.2S, V12.2S
    FCVTAS  V4.2S, V23.2S
    FCVTL2  V12.2D, V27.4S
    FCVTAU  V23.2D, V7.2D
    FCVTZU  V31.2S, V23.2S, #11
    FRINTM  V23.2D, V4.2D
    FRINTP  V16.8H, V14.8H
    FCVTZS V1.2D, V12.2D, #26
    FCVTNU  V14.4S, V3.4S
    FRINTZ  V4.8H, V14.8H
    FRINTN  V6.4H, V11.4H
    FRINTA  V14.4S, V25.4S
    FCVTZU  V7.2S, V23.2S
    FRINTZ  V15.4H, V7.4H
    FCVTN  V27.2S, V9.2D
    FCVTAS  V18.8H, V6.8H
    FRINTM  V16.2D, V1.2D
    FCVTZU  V3.8H, V27.8H
    FRINTI  V6.2S, V14.2S
    FCVTMS  V7.2D, V18.2D
    FCVTNU  V18.8H, V3.8H
    FCVTN  V25.2S, V4.2D
    FCVTL2  V18.2D, V18.4S
    FRINTA  V12.4H, V15.4H
    FCVTNS  V15.2S, V18.2S
    FCVTAU  V1.4S, V25.4S
    FRINTP  V23.4H, V7.4H
    FCVTN2  V11.8H, V30.4S
    FCVTZS  V14.8H, V1.8H, #12
    FCVTPU  V30.8H, V31.8H
    FCVTXN2  V1.4S, V30.2D
    FRINTM  V3.4H, V1.4H
    FCVTNU  V4.4S, V6.4S
    FCVTMU  V7.8H, V12.8H
    FCVTPS  V18.8H, V4.8H
    FRINTX  V9.8H, V14.8H
    FRINTX  V1.8H, V3.8H
    FRINTI  V31.4H, V23.4H
    FCVTAU  V12.2S, V15.2S
    FCVTNS  V14.4H, V11.4H
    FRINTM  V3.4H, V1.4H
    FCVTZS  V27.4S, V3.4S, #22
    FRINTN  V6.4S, V7.4S
    FCVTNU  V30.4H, V27.4H
    FCVTXN  V25.2S, V6.2D
    FCVTN2  V15.4S, V18.2D
    FCVTPS  V4.4H, V15.4H
    FRINTN  V3.4S, V12.4S
    FCVTNU  V23.4H, V3.4H
    FRINTZ  V3.4S, V30.4S
    FCVTAU  V15.4H, V23.4H
    FCVTMU  V18.8H, V14.8H
    FCVTPS  V11.4H, V25.4H
    FCVTPU  V23.2S, V4.2S
    FCVTZU  V4.4H, V3.4H
    FCVTPS  V3.4S, V1.4S
    FCVTMS  V1.4S, V9.4S
    FRINTM  V6.4S, V3.4S
    FCVTN  V27.4H, V15.4S
    FCVTZU  V30.2S, V1.2S, #3
    FCVTXN2  V14.4S, V31.2D
    FCVTAU  V7.2S, V18.2S
    FRINTZ  V21.4H, V6.4H
    FCVTAU  V6.8H, V21.8H
    FRINTA  V15.4S, V7.4S
    FCVTMS  V12.8H, V3.8H
    FRINTN  V21.4H, V12.4H
    FCVTZS V1.2D, V6.2D, #59
    FCVTAS  V26.8H, V27.8H
    FCVTPU  V25.2D, V4.2D
    FCVTAS  V9.2D, V25.2D
    FRINTN  V4.4H, V9.4H
    SUBS  X14, X14, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_8
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X15, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X15, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X15, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X15, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X15, X10, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X15, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X15, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X15, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X15, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X15, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X15, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X15, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X15, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X15, X10, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X15, X10, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X15, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X15, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x1d, LSL #0
    MRS  X15, FPSR
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, V0.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, D0
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, V1.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, D1
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X15, V2.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X15, D2
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, V3.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, D3
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, V4.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, D4
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X15, V5.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X15, D5
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, V6.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, D6
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, V7.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, D7
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X15, V8.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X15, D8
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, V9.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, D9
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X15, V10.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X15, D10
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, V11.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, D11
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, V12.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, D12
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X15, V13.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X15, D13
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, V14.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, D14
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, V15.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, D15
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, V16.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, D16
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, V17.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, D17
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, V18.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, D18
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, V19.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, D19
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X15, V20.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X15, D20
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, V21.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, D21
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, V22.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, D22
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, V23.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, D23
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, V24.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, D24
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, V25.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, D25
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, V26.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, D26
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, V27.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, D27
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, V28.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, D28
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X15, V29.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X15, D29
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, V30.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, D30
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, V31.D[1]
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X15, D31
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X2, #0xf0d6, LSL #0
    MOVK  X2, #0xcc82, LSL #16
    MOVK  X2, #0xe79d, LSL #32
    MOVK  X2, #0xa2aa, LSL #48
    MOVZ  X3, #0x4f7a, LSL #0
    MOVK  X3, #0x16d0, LSL #16
    MOVK  X3, #0xc7ef, LSL #32
    MOVK  X3, #0x697a, LSL #48
    MOVZ  X6, #0xdc3e, LSL #0
    MOVK  X6, #0x667f, LSL #16
    MOVK  X6, #0xf626, LSL #32
    MOVK  X6, #0x9886, LSL #48
    MOVZ  X7, #0xcd1f, LSL #0
    MOVK  X7, #0xa7cd, LSL #16
    MOVK  X7, #0xf80b, LSL #32
    MOVK  X7, #0xd287, LSL #48
    MOVZ  X8, #0xcfd4, LSL #0
    MOVK  X8, #0x73f6, LSL #16
    MOVK  X8, #0x4233, LSL #32
    MOVK  X8, #0x75d5, LSL #48
    MOVZ  X9, #0x4349, LSL #0
    MOVK  X9, #0xd9df, LSL #16
    MOVK  X9, #0x2b31, LSL #32
    MOVK  X9, #0x5e70, LSL #48
    MOVZ  X10, #0xecea, LSL #0
    MOVK  X10, #0x4fc3, LSL #16
    MOVK  X10, #0x84d5, LSL #32
    MOVK  X10, #0xf7ba, LSL #48
    MOVZ  X11, #0x9fc6, LSL #0
    MOVK  X11, #0x5073, LSL #16
    MOVK  X11, #0xe8c3, LSL #32
    MOVK  X11, #0xf56b, LSL #48
    MOVZ  X13, #0x8564, LSL #0
    MOVK  X13, #0x2f32, LSL #16
    MOVK  X13, #0x453d, LSL #32
    MOVK  X13, #0x657b, LSL #48
    MOVZ  X14, #0x6fc8, LSL #0
    MOVK  X14, #0x8238, LSL #16
    MOVK  X14, #0x2ee1, LSL #32
    MOVK  X14, #0x8ad1, LSL #48
    MOVZ  X15, #0xc9e8, LSL #0
    MOVK  X15, #0x1a71, LSL #16
    MOVK  X15, #0x66ba, LSL #32
    MOVK  X15, #0x31f8, LSL #48
    MOVZ  X16, #0x44f7, LSL #0
    MOVK  X16, #0x5474, LSL #16
    MOVK  X16, #0x81e6, LSL #32
    MOVK  X16, #0x1d29, LSL #48
    MOVZ  X17, #0x6752, LSL #0
    MOVK  X17, #0x7509, LSL #16
    MOVK  X17, #0x7a8d, LSL #32
    MOVK  X17, #0xe81, LSL #48
    MOVZ  X19, #0x6a71, LSL #0
    MOVK  X19, #0x705e, LSL #16
    MOVK  X19, #0x2721, LSL #32
    MOVK  X19, #0x981f, LSL #48
    MOVZ  X20, #0x2d86, LSL #0
    MOVK  X20, #0x6048, LSL #16
    MOVK  X20, #0xb747, LSL #32
    MOVK  X20, #0x79c9, LSL #48
    MOVZ  X21, #0x683, LSL #0
    MOVK  X21, #0x6fe2, LSL #16
    MOVK  X21, #0x8d07, LSL #32
    MOVK  X21, #0x1cc6, LSL #48
    MOVZ  X22, #0xf6be, LSL #0
    MOVK  X22, #0x2517, LSL #16
    MOVK  X22, #0x18c0, LSL #32
    MOVK  X22, #0x4998, LSL #48
    MOVZ  X23, #0x8e6a, LSL #0
    MOVK  X23, #0xecda, LSL #16
    MOVK  X23, #0x8b95, LSL #32
    MOVK  X23, #0x73ea, LSL #48
    MOVZ  X24, #0xc068, LSL #0
    MOVK  X24, #0x5a96, LSL #16
    MOVK  X24, #0x36bf, LSL #32
    MOVK  X24, #0x94fe, LSL #48
    MOVZ  X25, #0x5825, LSL #0
    MOVK  X25, #0xbff6, LSL #16
    MOVK  X25, #0x5ebc, LSL #32
    MOVK  X25, #0x51a7, LSL #48
    MOVZ  X26, #0xa2bf, LSL #0
    MOVK  X26, #0xff94, LSL #16
    MOVK  X26, #0xe6f0, LSL #32
    MOVK  X26, #0x10db, LSL #48
    MOVZ  X27, #0x62f4, LSL #0
    MOVK  X27, #0xcd2a, LSL #16
    MOVK  X27, #0xabe2, LSL #32
    MOVK  X27, #0x5a4d, LSL #48
    MOVZ  X28, #0x6ba8, LSL #0
    MOVK  X28, #0x637d, LSL #16
    MOVK  X28, #0x5b06, LSL #32
    MOVK  X28, #0xbb1b, LSL #48
    MOVZ  X29, #0x4d53, LSL #0
    MOVK  X29, #0x8ff2, LSL #16
    MOVK  X29, #0xb30c, LSL #32
    MOVK  X29, #0x778b, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X25
    FMOV  D1, X27
    FMOV  V1.D[1], X29
    FMOV  D2, X26
    FMOV  V2.D[1], X23
    FMOV  D3, X7
    FMOV  V3.D[1], X7
    FMOV  D4, X17
    FMOV  V4.D[1], X16
    FMOV  D5, X14
    FMOV  V5.D[1], X14
    FMOV  D6, X28
    FMOV  V6.D[1], X27
    FMOV  D7, X22
    FMOV  V7.D[1], X6
    FMOV  D8, X19
    FMOV  V8.D[1], X2
    FMOV  D9, X21
    FMOV  V9.D[1], X25
    FMOV  D10, X17
    FMOV  V10.D[1], X27
    FMOV  D11, X22
    FMOV  V11.D[1], X7
    FMOV  D12, X2
    FMOV  V12.D[1], X9
    FMOV  D13, X21
    FMOV  V13.D[1], X9
    FMOV  D14, X8
    FMOV  V14.D[1], X29
    FMOV  D15, X11
    FMOV  V15.D[1], X26
    FMOV  D16, X19
    FMOV  V16.D[1], X13
    FMOV  D17, X8
    FMOV  V17.D[1], X24
    FMOV  D18, X6
    FMOV  V18.D[1], X16
    FMOV  D19, X24
    FMOV  V19.D[1], X29
    FMOV  D20, X22
    FMOV  V20.D[1], X7
    FMOV  D21, X24
    FMOV  V21.D[1], X19
    FMOV  D22, X29
    FMOV  V22.D[1], X11
    FMOV  D23, X16
    FMOV  V23.D[1], X15
    FMOV  D24, X21
    FMOV  V24.D[1], X11
    FMOV  D25, X17
    FMOV  V25.D[1], X17
    FMOV  D26, X24
    FMOV  V26.D[1], X22
    FMOV  D27, X9
    FMOV  V27.D[1], X28
    FMOV  D28, X25
    FMOV  V28.D[1], X24
    FMOV  D29, X19
    FMOV  V29.D[1], X21
    FMOV  D30, X29
    FMOV  V30.D[1], X13
    FMOV  D31, X29
    FMOV  V31.D[1], X14
    MOVZ  X8, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_9:
    FCVTL  V12.4S, V26.4H
    FRINTN  V0.8H, V25.8H
    FCVTZU V25.2D, V0.2D, #32
    FCVTAU  V20.4H, V22.4H
    FRINTZ  V17.2D, V27.2D
    FCVTMS  V27.2D, V20.2D
    FCVTZU  V22.2S, V12.2S, #29
    FRINTI  V16.4S, V28.4S
    FRINTM  V16.2D, V31.2D
    FCVTMS  V29.2S, V16.2S
    FCVTNS  V12.2D, V22.2D
    FCVTZS  V13.4S, V24.4S
    FRINTZ  V28.4H, V29.4H
    FCVTXN  V23.2S, V12.2D
    FCVTNU  V15.8H, V28.8H
    FCVTAS  V2.4H, V15.4H
    FCVTNS  V4.2D, V13.2D
    FCVTMU  V18.4H, V4.4H
    FCVTZU  V5.4H, V17.4H
    FCVTPS  V10.2D, V27.2D
    FCVTL  V25.4S, V2.4H
    FCVTZU  V31.4H, V23.4H
    FCVTNU  V28.2S, V18.2S
    FRINTA  V15.8H, V31.8H
    FRINTX  V12.4S, V30.4S
    FRINTN  V13.4S, V10.4S
    FCVTNU  V30.2S, V28.2S
    FCVTNU  V27.2S, V24.2S
    FCVTZU  V4.8H, V15.8H, #5
    FRINTN  V29.2D, V30.2D
    FCVTZU V28.2D, V5.2D, #16
    FRINTN  V5.2S, V28.2S
    FCVTZS  V18.8H, V12.8H
    FRINTM  V22.4S, V25.4S
    FRINTI  V17.4S, V22.4S
    FRINTN  V16.4S, V27.4S
    FCVTZU  V25.2S, V29.2S
    FCVTZU V2.2D, V13.2D, #59
    FCVTPS  V30.2S, V16.2S
    FCVTNU  V16.4S, V18.4S
    FCVTZU V28.2D, V4.2D, #22
    FCVTZS  V24.2S, V16.2S, #5
    FCVTL2  V31.2D, V5.4S
    FCVTZS  V18.8H, V31.8H, #7
    FRINTA  V22.8H, V24.8H
    FRINTN  V13.2D, V15.2D
    FCVTL  V29.4S, V17.4H
    FCVTZS  V17.4H, V25.4H, #3
    FCVTNS  V31.8H, V17.8H
    FCVTPU  V27.4S, V28.4S
    FRINTP  V24.8H, V18.8H
    FCVTZU V12.2D, V22.2D, #4
    FRINTM  V15.4S, V30.4S
    FRINTP  V17.8H, V13.8H
    FRINTP  V25.2S, V24.2S
    FCVTZS  V13.2S, V2.2S, #13
    FCVTZU  V21.2S, V2.2S
    FCVTZS  V28.2S, V21.2S, #2
    FCVTZS  V18.4H, V13.4H, #1
    FRINTX  V20.8H, V13.8H
    FCVTAU  V5.8H, V12.8H
    FCVTNU  V30.8H, V29.8H
    FCVTZS  V22.4S, V30.4S, #30
    FCVTAS  V2.4H, V25.4H
    FRINTP  V29.4H, V2.4H
    FRINTZ  V2.4H, V29.4H
    FRINTA  V24.4H, V28.4H
    FCVTAU  V25.2S, V22.2S
    FCVTAU  V21.8H, V15.8H
    FCVTL  V22.4S, V24.4H
    FCVTAS  V13.4H, V5.4H
    FRINTP  V30.4H, V21.4H
    FCVTAS  V15.2S, V27.2S
    FCVTNS  V5.8H, V31.8H
    FRINTI  V29.2S, V20.2S
    FCVTXN2  V20.4S, V18.2D
    FCVTZU V28.2D, V29.2D, #20
    FCVTAS  V29.4H, V5.4H
    FRINTP  V24.4H, V25.4H
    FCVTMS  V18.4S, V22.4S
    FCVTNS  V21.4H, V13.4H
    FCVTZS  V13.4H, V2.4H
    FCVTZU V2.2D, V21.2D, #34
    FRINTZ  V22.2S, V29.2S
    FRINTN  V12.2D, V22.2D
    FCVTZS V22.2D, V20.2D, #22
    FCVTXN2  V25.4S, V22.2D
    FCVTN  V27.2S, V28.2D
    FCVTZS  V31.4H, V27.4H, #4
    FRINTA  V5.4H, V15.4H
    FCVTN  V27.4H, V30.4S
    FRINTI  V14.2S, V12.2S
    FCVTZU  V28.4H, V18.4H
    FCVTNU  V15.4H, V25.4H
    FCVTPU  V20.2S, V27.2S
    FCVTXN  V29.2S, V15.2D
    FCVTN2  V27.8H, V28.4S
    FRINTP  V15.2S, V31.2S
    FCVTNS  V10.4H, V24.4H
    FCVTMU  V12.2S, V4.2S
    FRINTM  V28.2D, V2.2D
    FCVTNS  V21.4H, V29.4H
    FCVTMU  V18.2S, V21.2S
    FCVTPU  V24.4H, V12.4H
    FCVTZS  V30.2S, V18.2S, #31
    FCVTN2  V25.8H, V24.4S
    FCVTPS  V2.8H, V20.8H
    FCVTXN2  V4.4S, V14.2D
    FCVTXN  V31.2S, V25.2D
    FRINTM  V25.4H, V31.4H
    FCVTZS  V21.4H, V30.4H, #2
    FRINTZ  V30.8H, V2.8H
    FCVTNU  V20.2D, V4.2D
    FRINTN  V14.8H, V25.8H
    FCVTZU  V25.4S, V21.4S, #15
    FCVTAS  V12.8H, V27.8H
    FRINTP  V29.2S, V25.2S
    FRINTX  V25.8H, V30.8H
    FCVTZS V4.2D, V10.2D, #13
    FRINTM  V21.2S, V20.2S
    FCVTMU  V18.8H, V15.8H
    FCVTXN2  V27.4S, V18.2D
    FCVTL  V20.2D, V25.2S
    FCVTN2  V10.4S, V28.2D
    FCVTZU  V15.4H, V12.4H
    FRINTA  V18.4H, V21.4H
    FCVTNU  V21.4H, V18.4H
    FCVTZU  V12.2S, V29.2S
    FCVTZS  V31.4S, V21.4S
    FRINTA  V30.2D, V31.2D
    FCVTPU  V18.4S, V10.4S
    FCVTAU  V10.4H, V4.4H
    FRINTP  V28.4S, V25.4S
    FRINTX  V25.8H, V20.8H
    FCVTPU  V21.4H, V27.4H
    FCVTAS  V27.2D, V18.2D
    FCVTPS  V20.4S, V30.4S
    FCVTN2  V18.4S, V28.2D
    FCVTL  V28.4S, V15.4H
    FRINTA  V4.4H, V12.4H
    FCVTZS  V30.8H, V18.8H, #12
    FCVTNU  V12.8H, V10.8H
    FCVTZU  V18.8H, V25.8H, #12
    FRINTP  V25.4H, V18.4H
    FRINTX  V31.2D, V4.2D
    FCVTZU V15.2D, V27.2D, #20
    FRINTZ  V10.2D, V16.2D
    FRINTP  V18.8H, V16.8H
    FCVTMS  V16.8H, V20.8H
    FCVTNS  V27.2D, V16.2D
    FRINTM  V16.8H, V31.8H
    FRINTA  V31.4S, V15.4S
    FCVTMU  V4.2S, V12.2S
    FCVTAU  V20.8H, V10.8H
    FCVTPS  V10.4H, V4.4H
    FCVTPU  V4.8H, V21.8H
    FCVTZS  V21.4H, V27.4H, #8
    FCVTPU  V15.4H, V16.4H
    FCVTAU  V27.2S, V30.2S
    FRINTA  V16.4H, V25.4H
    FRINTI  V12.2D, V15.2D
    FCVTL  V30.2D, V10.2S
    FCVTL  V25.4S, V18.4H
    FCVTMS  V18.4H, V21.4H
    FCVTPU  V10.8H, V18.8H
    FCVTZS  V18.4S, V27.4S, #23
    FRINTN  V15.8H, V31.8H
    FRINTI  V31.4H, V20.4H
    FCVTZU  V21.4H, V18.4H
    FCVTNS  V18.8H, V15.8H
    FRINTA  V15.2S, V25.2S
    FCVTZU  V27.4S, V4.4S, #6
    FRINTX  V25.8H, V16.8H
    FRINTI  V4.2D, V19.2D
    FCVTXN2  V19.4S, V18.2D
    FCVTAS  V16.8H, V30.8H
    FCVTMU  V18.4H, V16.4H
    FCVTZS  V30.4H, V15.4H
    FCVTMS  V20.8H, V30.8H
    FCVTZU  V16.8H, V4.8H, #8
    FCVTPU  V27.4S, V12.4S
    FCVTAU  V12.4H, V10.4H
    FCVTN  V6.2S, V31.2D
    FCVTAU  V21.8H, V27.8H
    FCVTXN2  V31.4S, V20.2D
    FCVTL  V27.2D, V12.2S
    FCVTAU  V4.4H, V16.4H
    FRINTN  V12.2D, V4.2D
    FCVTL2  V4.4S, V18.8H
    FRINTM  V18.4H, V31.4H
    FCVTZU  V15.8H, V12.8H, #14
    FCVTZS  V10.2S, V15.2S
    FCVTPS  V16.4H, V6.4H
    FCVTPS  V9.4H, V21.4H
    FRINTZ  V15.8H, V4.8H
    FCVTN2  V20.4S, V16.2D
    FRINTN  V4.4H, V18.4H
    FCVTN2  V31.8H, V10.4S
    FRINTN  V12.4H, V20.4H
    FRINTM  V30.4H, V27.4H
    SUBS  X8, X8, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_9
    MOVZ  X11, #0xf0d6, LSL #0
    MOVK  X11, #0xcc82, LSL #16
    MOVK  X11, #0xe79d, LSL #32
    MOVK  X11, #0xa2aa, LSL #48
    SUB  X28, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x4f7a, LSL #0
    MOVK  X11, #0x16d0, LSL #16
    MOVK  X11, #0xc7ef, LSL #32
    MOVK  X11, #0x697a, LSL #48
    SUB  X28, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xdc3e, LSL #0
    MOVK  X11, #0x667f, LSL #16
    MOVK  X11, #0xf626, LSL #32
    MOVK  X11, #0x9886, LSL #48
    SUB  X28, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xcd1f, LSL #0
    MOVK  X11, #0xa7cd, LSL #16
    MOVK  X11, #0xf80b, LSL #32
    MOVK  X11, #0xd287, LSL #48
    SUB  X28, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x4349, LSL #0
    MOVK  X11, #0xd9df, LSL #16
    MOVK  X11, #0x2b31, LSL #32
    MOVK  X11, #0x5e70, LSL #48
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xecea, LSL #0
    MOVK  X11, #0x4fc3, LSL #16
    MOVK  X11, #0x84d5, LSL #32
    MOVK  X11, #0xf7ba, LSL #48
    SUB  X28, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x8564, LSL #0
    MOVK  X11, #0x2f32, LSL #16
    MOVK  X11, #0x453d, LSL #32
    MOVK  X11, #0x657b, LSL #48
    SUB  X28, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x6fc8, LSL #0
    MOVK  X11, #0x8238, LSL #16
    MOVK  X11, #0x2ee1, LSL #32
    MOVK  X11, #0x8ad1, LSL #48
    SUB  X28, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xc9e8, LSL #0
    MOVK  X11, #0x1a71, LSL #16
    MOVK  X11, #0x66ba, LSL #32
    MOVK  X11, #0x31f8, LSL #48
    SUB  X28, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x44f7, LSL #0
    MOVK  X11, #0x5474, LSL #16
    MOVK  X11, #0x81e6, LSL #32
    MOVK  X11, #0x1d29, LSL #48
    SUB  X28, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x6752, LSL #0
    MOVK  X11, #0x7509, LSL #16
    MOVK  X11, #0x7a8d, LSL #32
    MOVK  X11, #0xe81, LSL #48
    SUB  X28, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x6a71, LSL #0
    MOVK  X11, #0x705e, LSL #16
    MOVK  X11, #0x2721, LSL #32
    MOVK  X11, #0x981f, LSL #48
    SUB  X28, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x2d86, LSL #0
    MOVK  X11, #0x6048, LSL #16
    MOVK  X11, #0xb747, LSL #32
    MOVK  X11, #0x79c9, LSL #48
    SUB  X28, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x683, LSL #0
    MOVK  X11, #0x6fe2, LSL #16
    MOVK  X11, #0x8d07, LSL #32
    MOVK  X11, #0x1cc6, LSL #48
    SUB  X28, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xf6be, LSL #0
    MOVK  X11, #0x2517, LSL #16
    MOVK  X11, #0x18c0, LSL #32
    MOVK  X11, #0x4998, LSL #48
    SUB  X28, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x8e6a, LSL #0
    MOVK  X11, #0xecda, LSL #16
    MOVK  X11, #0x8b95, LSL #32
    MOVK  X11, #0x73ea, LSL #48
    SUB  X28, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xc068, LSL #0
    MOVK  X11, #0x5a96, LSL #16
    MOVK  X11, #0x36bf, LSL #32
    MOVK  X11, #0x94fe, LSL #48
    SUB  X28, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5825, LSL #0
    MOVK  X11, #0xbff6, LSL #16
    MOVK  X11, #0x5ebc, LSL #32
    MOVK  X11, #0x51a7, LSL #48
    SUB  X28, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xa2bf, LSL #0
    MOVK  X11, #0xff94, LSL #16
    MOVK  X11, #0xe6f0, LSL #32
    MOVK  X11, #0x10db, LSL #48
    SUB  X28, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x62f4, LSL #0
    MOVK  X11, #0xcd2a, LSL #16
    MOVK  X11, #0xabe2, LSL #32
    MOVK  X11, #0x5a4d, LSL #48
    SUB  X28, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x1d, LSL #0
    MRS  X28, FPSR
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, V0.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, D0
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x4d53, LSL #0
    MOVK  X11, #0x8ff2, LSL #16
    MOVK  X11, #0xb30c, LSL #32
    MOVK  X11, #0x778b, LSL #48
    FMOV  X28, V1.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x62f4, LSL #0
    MOVK  X11, #0xcd2a, LSL #16
    MOVK  X11, #0xabe2, LSL #32
    MOVK  X11, #0x5a4d, LSL #48
    FMOV  X28, D1
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, V2.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, D2
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xcd1f, LSL #0
    MOVK  X11, #0xa7cd, LSL #16
    MOVK  X11, #0xf80b, LSL #32
    MOVK  X11, #0xd287, LSL #48
    FMOV  X28, V3.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xcd1f, LSL #0
    MOVK  X11, #0xa7cd, LSL #16
    MOVK  X11, #0xf80b, LSL #32
    MOVK  X11, #0xd287, LSL #48
    FMOV  X28, D3
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, V4.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, D4
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, V5.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, D5
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, V6.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, D6
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xdc3e, LSL #0
    MOVK  X11, #0x667f, LSL #16
    MOVK  X11, #0xf626, LSL #32
    MOVK  X11, #0x9886, LSL #48
    FMOV  X28, V7.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xf6be, LSL #0
    MOVK  X11, #0x2517, LSL #16
    MOVK  X11, #0x18c0, LSL #32
    MOVK  X11, #0x4998, LSL #48
    FMOV  X28, D7
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xf0d6, LSL #0
    MOVK  X11, #0xcc82, LSL #16
    MOVK  X11, #0xe79d, LSL #32
    MOVK  X11, #0xa2aa, LSL #48
    FMOV  X28, V8.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x6a71, LSL #0
    MOVK  X11, #0x705e, LSL #16
    MOVK  X11, #0x2721, LSL #32
    MOVK  X11, #0x981f, LSL #48
    FMOV  X28, D8
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, V9.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, D9
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, V10.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, D10
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xcd1f, LSL #0
    MOVK  X11, #0xa7cd, LSL #16
    MOVK  X11, #0xf80b, LSL #32
    MOVK  X11, #0xd287, LSL #48
    FMOV  X28, V11.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xf6be, LSL #0
    MOVK  X11, #0x2517, LSL #16
    MOVK  X11, #0x18c0, LSL #32
    MOVK  X11, #0x4998, LSL #48
    FMOV  X28, D11
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, V12.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, D12
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, V13.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, D13
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, V14.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, D14
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, V15.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, D15
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, V16.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, D16
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, V17.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, D17
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, V18.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, D18
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, V19.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xc068, LSL #0
    MOVK  X11, #0x5a96, LSL #16
    MOVK  X11, #0x36bf, LSL #32
    MOVK  X11, #0x94fe, LSL #48
    FMOV  X28, D19
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, V20.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, D20
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, V21.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, D21
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, V22.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, D22
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, V23.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, D23
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, V24.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, D24
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, V25.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, D25
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xf6be, LSL #0
    MOVK  X11, #0x2517, LSL #16
    MOVK  X11, #0x18c0, LSL #32
    MOVK  X11, #0x4998, LSL #48
    FMOV  X28, V26.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xc068, LSL #0
    MOVK  X11, #0x5a96, LSL #16
    MOVK  X11, #0x36bf, LSL #32
    MOVK  X11, #0x94fe, LSL #48
    FMOV  X28, D26
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, V27.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, D27
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, V28.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, D28
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, V29.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, D29
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, V30.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, D30
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, V31.D[1]
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X28, D31
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
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
    FMOV  V0.D[1], X26
    FMOV  D1, X24
    FMOV  V1.D[1], X17
    FMOV  D2, X13
    FMOV  V2.D[1], X25
    FMOV  D3, X21
    FMOV  V3.D[1], X16
    FMOV  D4, X22
    FMOV  V4.D[1], X29
    FMOV  D5, X28
    FMOV  V5.D[1], X23
    FMOV  D6, X20
    FMOV  V6.D[1], X27
    FMOV  D7, X20
    FMOV  V7.D[1], X14
    FMOV  D8, X13
    FMOV  V8.D[1], X23
    FMOV  D9, X11
    FMOV  V9.D[1], X29
    FMOV  D10, X7
    FMOV  V10.D[1], X2
    FMOV  D11, X11
    FMOV  V11.D[1], X20
    FMOV  D12, X23
    FMOV  V12.D[1], X3
    FMOV  D13, X21
    FMOV  V13.D[1], X23
    FMOV  D14, X25
    FMOV  V14.D[1], X15
    FMOV  D15, X28
    FMOV  V15.D[1], X20
    FMOV  D16, X2
    FMOV  V16.D[1], X24
    FMOV  D17, X3
    FMOV  V17.D[1], X16
    FMOV  D18, X27
    FMOV  V18.D[1], X2
    FMOV  D19, X21
    FMOV  V19.D[1], X6
    FMOV  D20, X17
    FMOV  V20.D[1], X17
    FMOV  D21, X16
    FMOV  V21.D[1], X3
    FMOV  D22, X17
    FMOV  V22.D[1], X28
    FMOV  D23, X22
    FMOV  V23.D[1], X21
    FMOV  D24, X24
    FMOV  V24.D[1], X22
    FMOV  D25, X9
    FMOV  V25.D[1], X26
    FMOV  D26, X8
    FMOV  V26.D[1], X21
    FMOV  D27, X7
    FMOV  V27.D[1], X25
    FMOV  D28, X22
    FMOV  V28.D[1], X15
    FMOV  D29, X21
    FMOV  V29.D[1], X15
    FMOV  D30, X29
    FMOV  V30.D[1], X26
    FMOV  D31, X22
    FMOV  V31.D[1], X16
    MOVZ  X3, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_10:
    FRINTX  V22.2D, V28.2D
    FCVTL2  V9.2D, V26.4S
    FCVTMS  V13.2D, V24.2D
    FRINTM  V9.4S, V13.4S
    FCVTZU V31.2D, V23.2D, #44
    FRINTM  V4.8H, V29.8H
    FCVTAS  V29.2D, V27.2D
    FRINTZ  V7.4H, V29.4H
    FRINTP  V4.4S, V9.4S
    FRINTI  V15.4S, V4.4S
    FCVTXN2  V21.4S, V7.2D
    FRINTP  V26.2D, V15.2D
    FCVTL  V15.4S, V31.4H
    FCVTN  V13.4H, V30.4S
    FRINTM  V13.2D, V26.2D
    FCVTZS  V3.8H, V15.8H
    FCVTAU  V9.8H, V13.8H
    FCVTNS  V16.4H, V9.4H
    FRINTM  V12.4S, V22.4S
    FCVTAS  V29.4H, V3.4H
    FRINTZ  V21.4S, V29.4S
    FCVTNS  V4.2D, V16.2D
    FCVTL  V30.2D, V4.2S
    FCVTXN  V23.2S, V10.2D
    FCVTL  V27.4S, V12.4H
    FRINTI  V26.8H, V27.8H
    FRINTI  V31.2D, V21.2D
    FCVTNU  V3.2S, V30.2S
    FCVTNS  V15.4H, V23.4H
    FRINTX  V24.4H, V3.4H
    FRINTX  V9.2S, V26.2S
    FRINTA  V23.4H, V31.4H
    FRINTZ  V22.8H, V15.8H
    FCVTZU  V27.2D, V24.2D
    FCVTMS  V31.4H, V9.4H
    FCVTZS  V16.2S, V23.2S
    FCVTXN2  V7.4S, V16.2D
    FCVTZU V29.2D, V27.2D, #35
    FCVTN2  V30.4S, V0.2D
    FCVTN  V23.4H, V31.4S
    FCVTL2  V15.2D, V6.4S
    FCVTZU  V24.4H, V22.4H
    FCVTZS  V21.2S, V25.2S, #28
    FCVTAS  V27.8H, V29.8H
    FCVTMS  V3.4S, V7.4S
    FCVTMU  V10.2S, V30.2S
    FCVTXN  V0.2S, V21.2D
    FRINTN  V7.8H, V0.8H
    FCVTL  V22.2D, V24.2S
    FCVTAU  V9.4H, V10.4H
    FCVTL2  V0.2D, V22.4S
    FCVTNU  V24.4H, V7.4H
    FRINTP  V10.4H, V23.4H
    FCVTN  V30.2S, V3.2D
    FRINTP  V22.2D, V15.2D
    FCVTPS  V3.2D, V30.2D
    FRINTA  V23.8H, V22.8H
    FCVTNS  V21.4H, V9.4H
    FCVTXN2  V25.4S, V23.2D
    FRINTZ  V30.8H, V27.8H
    FCVTAU  V27.2D, V10.2D
    FCVTAS  V29.4H, V25.4H
    FRINTI  V23.4S, V27.4S
    FCVTAS  V7.4H, V3.4H
    FCVTN  V25.4H, V23.4S
    FCVTZU  V23.8H, V21.8H, #13
    FCVTNU  V27.4H, V29.4H
    FRINTM  V6.4H, V0.4H
    FCVTAS  V10.4S, V27.4S
    FCVTPS  V9.8H, V25.8H
    FCVTXN2  V21.4S, V23.2D
    FRINTA  V15.2S, V10.2S
    FRINTM  V29.4H, V7.4H
    FCVTPS  V3.4S, V29.4S
    FCVTN2  V22.8H, V15.4S
    FCVTN  V15.4H, V30.4S
    FCVTL  V30.4S, V22.4H
    FCVTPS  V0.4H, V6.4H
    FCVTZS  V10.2D, V30.2D
    FCVTXN  V30.2S, V24.2D
    FRINTX  V24.2D, V30.2D
    FCVTNS  V27.2S, V9.2S
    FRINTN  V25.2S, V21.2S
    FCVTAS  V9.8H, V10.8H
    FCVTN2  V23.4S, V15.2D
    FCVTZU  V10.4S, V0.4S
    FRINTM  V15.8H, V3.8H
    FCVTMS  V7.4H, V24.4H
    FRINTA  V24.8H, V7.8H
    FRINTA  V6.4H, V9.4H
    FCVTN  V29.4H, V6.4S
    FCVTMU  V3.4H, V15.4H
    FCVTNU  V21.4H, V25.4H
    FRINTA  V6.4H, V27.4H
    FCVTZS  V0.4S, V3.4S, #17
    FCVTNS  V30.8H, V21.8H
    FCVTZU  V25.4S, V29.4S
    FCVTMS  V29.4H, V6.4H
    FCVTZS  V6.4H, V18.4H
    FCVTXN  V9.2S, V23.2D
    FCVTZS  V15.4H, V9.4H, #1
    FCVTZU  V18.4S, V10.4S
    FRINTA  V23.4H, V15.4H
    FCVTZU  V27.4S, V0.4S
    FCVTNU  V7.4S, V27.4S
    FRINTZ  V10.8H, V27.8H
    FCVTMS  V9.2S, V24.2S
    FCVTAU  V3.8H, V6.8H
    FCVTPS  V0.2S, V30.2S
    FCVTNS  V15.2D, V29.2D
    FCVTXN2  V6.4S, V25.2D
    FCVTZU  V20.8H, V9.8H
    FRINTN  V29.2D, V15.2D
    FCVTMU  V24.4S, V7.4S
    FCVTZU  V27.4H, V23.4H
    FCVTZS  V15.4S, V20.4S, #25
    FRINTP  V20.2D, V6.2D
    FCVTAS  V9.4H, V18.4H
    FCVTZU  V7.2S, V27.2S
    FCVTPU  V6.4S, V20.4S
    FCVTZS  V30.8H, V0.8H
    FCVTNS  V21.4H, V24.4H
    FRINTN  V25.2D, V29.2D
    FCVTNU  V0.4H, V11.4H
    FCVTAU  V20.8H, V6.8H
    FCVTZU  V18.4S, V3.4S, #32
    FCVTNS  V3.4H, V25.4H
    FCVTN2  V27.8H, V3.4S
    FRINTI  V23.2D, V27.2D
    FRINTA  V11.4H, V9.4H
    FCVTZS  V24.2S, V18.2S
    FCVTAS  V18.8H, V15.8H
    FCVTZS  V3.8H, V30.8H, #4
    FRINTM  V6.4H, V7.4H
    FCVTPS  V15.4S, V0.4S
    FRINTP  V0.8H, V18.8H
    FRINTM  V15.4H, V20.4H
    FCVTNS  V25.2S, V26.2S
    FCVTL  V9.4S, V6.4H
    FRINTX  V30.4H, V24.4H
    FCVTN2  V27.4S, V3.2D
    FCVTZU  V29.4S, V11.4S, #29
    FRINTA  V26.2D, V0.2D
    FCVTZS  V18.4S, V21.4S
    FRINTI  V3.4H, V15.4H
    FCVTPS  V15.4H, V30.4H
    FCVTAS  V30.4H, V2.4H
    FCVTPS  V21.8H, V25.8H
    FCVTPU  V20.4S, V27.4S
    FCVTN2  V25.8H, V29.4S
    FCVTPS  V29.4H, V25.4H
    FCVTL2  V2.2D, V9.4S
    FCVTMS  V27.8H, V26.8H
    FCVTXN2  V7.4S, V23.2D
    FCVTL  V25.2D, V21.2S
    FCVTAS  V26.4H, V3.4H
    FRINTZ  V3.4H, V21.4H
    FCVTPU  V11.8H, V3.8H
    FCVTPS  V9.2D, V11.2D
    FCVTMU  V6.2D, V27.2D
    FCVTNU  V3.4S, V26.4S
    FCVTZS  V23.8H, V3.8H, #12
    FRINTA  V0.2S, V30.2S
    FCVTZU  V11.2S, V20.2S
    FCVTN  V27.4H, V25.4S
    FCVTPU  V20.2D, V15.2D
    FCVTMU  V21.8H, V23.8H
    FCVTPS  V15.2D, V27.2D
    FCVTZS  V23.8H, V21.8H, #12
    FRINTZ  V27.4H, V6.4H
    FRINTZ  V25.2D, V20.2D
    FCVTAS  V21.8H, V27.8H
    FRINTX  V30.2S, V0.2S
    FCVTPS  V3.4H, V15.4H
    FCVTNU  V6.4H, V23.4H
    FRINTX  V26.2S, V30.2S
    FCVTMS  V20.8H, V25.8H
    FRINTM  V27.4S, V3.4S
    FCVTXN  V15.2S, V26.2D
    FRINTP  V26.8H, V11.8H
    FCVTZU  V11.8H, V26.8H, #11
    FCVTPS  V0.4H, V7.4H
    FRINTN  V3.4S, V21.4S
    FCVTZS V25.2D, V3.2D, #19
    FCVTPU  V23.2D, V25.2D
    FCVTL  V30.4S, V23.4H
    FRINTX  V5.2S, V20.2S
    FCVTAS  V23.2D, V5.2D
    FCVTXN2  V26.4S, V0.2D
    FRINTZ  V7.2D, V30.2D
    FRINTX  V20.8H, V15.8H
    FCVTMU  V21.4S, V20.4S
    FCVTZS  V20.4H, V21.4H
    FCVTXN2  V21.4S, V23.2D
    FRINTZ  V23.8H, V15.8H
    FRINTM  V15.2D, V11.2D
    FRINTX  V11.4H, V15.4H
    FCVTNU  V15.4S, V27.4S
    FCVTN  V27.2S, V26.2D
    FRINTN  V3.4S, V23.4S
    SUBS  X3, X3, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_10
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x1d, LSL #0
    MRS  X21, FPSR
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V0.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D0
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V1.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D1
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V2.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D2
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V3.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D3
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V4.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D4
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V5.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D5
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V6.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D6
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V7.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D7
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V8.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D8
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V9.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D9
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V10.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D10
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V11.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D11
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V12.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D12
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V13.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D13
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V14.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D14
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V15.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D15
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V16.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D16
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V17.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D17
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V18.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D18
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V19.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D19
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V20.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D20
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V21.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D21
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V22.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D22
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V23.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D23
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V24.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D24
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V25.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D25
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V26.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D26
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V27.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D27
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V28.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D28
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V29.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D29
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V30.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D30
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V31.D[1]
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D31
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
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
    FMOV  V0.D[1], X28
    FMOV  D1, X25
    FMOV  V1.D[1], X29
    FMOV  D2, X24
    FMOV  V2.D[1], X26
    FMOV  D3, X29
    FMOV  V3.D[1], X27
    FMOV  D4, X2
    FMOV  V4.D[1], X22
    FMOV  D5, X28
    FMOV  V5.D[1], X9
    FMOV  D6, X2
    FMOV  V6.D[1], X14
    FMOV  D7, X11
    FMOV  V7.D[1], X11
    FMOV  D8, X26
    FMOV  V8.D[1], X19
    FMOV  D9, X24
    FMOV  V9.D[1], X3
    FMOV  D10, X8
    FMOV  V10.D[1], X27
    FMOV  D11, X16
    FMOV  V11.D[1], X11
    FMOV  D12, X14
    FMOV  V12.D[1], X21
    FMOV  D13, X15
    FMOV  V13.D[1], X19
    FMOV  D14, X24
    FMOV  V14.D[1], X15
    FMOV  D15, X7
    FMOV  V15.D[1], X23
    FMOV  D16, X8
    FMOV  V16.D[1], X29
    FMOV  D17, X2
    FMOV  V17.D[1], X13
    FMOV  D18, X17
    FMOV  V18.D[1], X6
    FMOV  D19, X3
    FMOV  V19.D[1], X13
    FMOV  D20, X26
    FMOV  V20.D[1], X10
    FMOV  D21, X25
    FMOV  V21.D[1], X15
    FMOV  D22, X11
    FMOV  V22.D[1], X2
    FMOV  D23, X21
    FMOV  V23.D[1], X20
    FMOV  D24, X29
    FMOV  V24.D[1], X25
    FMOV  D25, X19
    FMOV  V25.D[1], X3
    FMOV  D26, X14
    FMOV  V26.D[1], X26
    FMOV  D27, X17
    FMOV  V27.D[1], X9
    FMOV  D28, X28
    FMOV  V28.D[1], X15
    FMOV  D29, X10
    FMOV  V29.D[1], X8
    FMOV  D30, X28
    FMOV  V30.D[1], X19
    FMOV  D31, X8
    FMOV  V31.D[1], X28
    MOVZ  X23, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_11:
    FCVTPS  V2.2D, V23.2D
    FRINTP  V4.2S, V25.2S
    FRINTM  V28.4H, V2.4H
    FCVTZS  V6.2D, V24.2D
    FCVTMU  V16.4S, V28.4S
    FCVTL2  V22.2D, V20.4S
    FRINTA  V2.2D, V16.2D
    FRINTN  V7.2D, V26.2D
    FCVTNU  V28.8H, V21.8H
    FCVTZU  V24.8H, V27.8H
    FCVTPS  V18.2D, V30.2D
    FCVTZS  V28.2S, V6.2S
    FCVTZU  V20.8H, V28.8H
    FCVTMS  V19.2D, V31.2D
    FCVTZU  V23.4H, V4.4H
    FCVTNS  V31.8H, V29.8H
    FCVTMU  V19.8H, V22.8H
    FCVTMS  V15.8H, V18.8H
    FCVTZU  V27.2D, V31.2D
    FCVTMS  V8.4H, V15.4H
    FCVTNU  V5.4H, V24.4H
    FCVTPU  V13.4H, V5.4H
    FCVTNU  V24.2D, V18.2D
    FRINTZ  V22.4H, V24.4H
    FCVTXN2  V31.4S, V22.2D
    FRINTP  V18.4H, V31.4H
    FCVTZS  V5.4S, V18.4S
    FCVTZS  V29.2S, V27.2S
    FCVTZS  V4.4S, V13.4S, #18
    FRINTP  V28.4S, V4.4S
    FCVTL2  V24.4S, V8.8H
    FCVTMU  V22.2D, V23.2D
    FCVTZS  V8.2S, V28.2S
    FRINTA  V28.4H, V5.4H
    FCVTMS  V15.4H, V19.4H
    FRINTZ  V30.2S, V29.2S
    FRINTI  V19.4S, V8.4S
    FCVTN2  V31.8H, V28.4S
    FRINTI  V4.2D, V31.2D
    FCVTMU  V27.2S, V24.2S
    FCVTL  V29.4S, V30.4H
    FCVTAU  V24.8H, V27.8H
    FCVTPS  V5.4H, V24.4H
    FRINTN  V27.2D, V19.2D
    FCVTZS  V19.4H, V27.4H
    FRINTA  V13.4S, V22.4S
    FCVTZU  V27.2S, V19.2S, #30
    FCVTAS  V8.4H, V4.4H
    FCVTN  V28.4H, V15.4S
    FRINTA  V23.2D, V8.2D
    FCVTNU  V31.8H, V23.8H
    FRINTZ  V18.4H, V29.4H
    FCVTPS  V4.8H, V17.8H
    FCVTAU  V15.8H, V28.8H
    FCVTAS  V22.4S, V31.4S
    FCVTMS  V19.2S, V31.2S
    FRINTM  V28.2D, V18.2D
    FCVTZU  V18.2D, V5.2D
    FRINTM  V24.2D, V27.2D
    FCVTZS  V27.4S, V22.4S
    FRINTM  V23.2S, V27.2S
    FCVTL2  V8.4S, V24.8H
    FCVTPS  V17.2S, V13.2S
    FCVTZS  V27.4H, V23.4H, #5
    FCVTAS  V22.2S, V27.2S
    FCVTPS  V29.4H, V15.4H
    FCVTXN  V5.2S, V8.2D
    FCVTAU  V8.8H, V25.8H
    FRINTI  V30.4S, V4.4S
    FRINTI  V15.4S, V30.4S
    FCVTZS  V30.8H, V15.8H
    FRINTP  V13.4H, V5.4H
    FRINTP  V31.4H, V17.4H
    FCVTMS  V24.4H, V30.4H
    FCVTPS  V27.8H, V8.8H
    FRINTI  V25.2S, V22.2S
    FCVTN2  V1.8H, V13.4S
    FCVTZS  V13.4H, V29.4H, #14
    FCVTZU  V5.2S, V31.2S, #31
    FCVTZU  V30.2S, V5.2S
    FRINTN  V5.4S, V24.4S
    FCVTNU  V24.2D, V27.2D
    FRINTN  V27.8H, V5.8H
    FCVTN  V5.2S, V25.2D
    FCVTMU  V8.4H, V1.4H
    FRINTX  V31.4H, V8.4H
    FCVTMU  V25.2S, V13.2S
    FCVTPS  V29.4S, V30.4S
    FCVTZU  V17.2D, V25.2D
    FCVTZS  V22.2S, V17.2S
    FRINTP  V15.2S, V27.2S
    FCVTL  V27.2D, V5.2S
    FCVTZU  V1.2D, V27.2D
    FCVTPU  V27.2S, V15.2S
    FCVTXN2  V30.4S, V31.2D
    FCVTAS  V13.8H, V24.8H
    FCVTMU  V8.8H, V1.8H
    FCVTMU  V17.4H, V8.4H
    FCVTMS  V1.8H, V22.8H
    FCVTMS  V22.4S, V1.4S
    FCVTZU  V1.8H, V22.8H
    FCVTAU  V25.4S, V17.4S
    FCVTNS  V22.4H, V13.4H
    FCVTPS  V8.4H, V29.4H
    FRINTI  V29.4S, V1.4S
    FRINTM  V1.2S, V27.2S
    FCVTMU  V17.2D, V25.2D
    FCVTMU  V13.2S, V22.2S
    FCVTL2  V31.2D, V30.4S
    FCVTZS V27.2D, V31.2D, #44
    FCVTZS  V5.2S, V15.2S, #28
    FRINTI  V0.4H, V8.4H
    FCVTZU  V19.4H, V0.4H
    FCVTNS  V24.2D, V5.2D
    FCVTZU V25.2D, V29.2D, #15
    FCVTNU  V29.4H, V27.4H
    FCVTMS  V22.2D, V19.2D
    FCVTZS  V20.2S, V1.2S, #18
    FRINTA  V19.2S, V13.2S
    FCVTN2  V30.8H, V17.4S
    FCVTNS  V5.4S, V20.4S
    FRINTI  V15.4S, V24.4S
    FCVTNS  V27.4H, V29.4H
    FCVTPU  V29.2D, V30.2D
    FCVTNS  V30.2D, V22.2D
    FRINTN  V1.4H, V25.4H
    FCVTL  V24.4S, V1.4H
    FCVTXN2  V6.4S, V27.2D
    FCVTAS  V31.2S, V30.2S
    FRINTI  V20.8H, V6.8H
    FRINTN  V27.4H, V19.4H
    FCVTAU  V19.2S, V10.2S
    FCVTZS  V17.2S, V27.2S, #18
    FCVTNU  V8.8H, V17.8H
    FCVTN  V10.2S, V8.2D
    FCVTXN2  V6.4S, V24.2D
    FCVTMU  V13.2S, V31.2S
    FCVTPS  V30.4S, V20.4S
    FCVTZS  V1.4S, V19.4S, #25
    FCVTXN2  V19.4S, V10.2D
    FCVTZU  V25.2D, V6.2D
    FCVTNS  V22.4H, V30.4H
    FCVTNU  V6.4H, V19.4H
    FCVTNS  V30.8H, V13.8H
    FRINTM  V10.8H, V30.8H
    FRINTI  V30.8H, V10.8H
    FRINTN  V31.2D, V25.2D
    FCVTZU  V10.8H, V22.8H, #8
    FCVTMU  V17.4S, V10.4S
    FCVTNS  V13.8H, V29.8H
    FRINTP  V25.8H, V31.8H
    FCVTPS  V4.8H, V1.8H
    FCVTAU  V26.4H, V13.4H
    FRINTX  V19.4H, V25.4H
    FCVTZS V25.2D, V6.2D, #49
    FRINTN  V22.8H, V26.8H
    FRINTI  V29.4H, V17.4H
    FRINTA  V1.2D, V4.2D
    FCVTN2  V4.4S, V1.2D
    FCVTZU  V1.4S, V30.4S, #18
    FCVTMU  V31.2S, V3.2S
    FCVTNS  V27.8H, V31.8H
    FCVTAS  V13.4H, V27.4H
    FCVTN2  V10.4S, V13.2D
    FCVTNS  V13.4S, V10.4S
    FCVTMU  V3.2S, V20.2S
    FCVTZU  V6.8H, V3.8H, #6
    FCVTPS  V27.8H, V4.8H
    FCVTPS  V31.4S, V19.4S
    FCVTZS V10.2D, V1.2D, #36
    FCVTN2  V17.4S, V25.2D
    FCVTL2  V4.4S, V13.8H
    FCVTXN  V13.2S, V4.2D
    FCVTPS  V4.2D, V17.2D
    FCVTPU  V17.2D, V4.2D
    FCVTZU  V30.4S, V13.4S, #3
    FRINTM  V20.4H, V10.4H
    FCVTMU  V4.2S, V30.2S
    FCVTXN  V3.2S, V20.2D
    FCVTMU  V19.8H, V17.8H
    FCVTZS  V30.2S, V31.2S
    FRINTP  V26.2D, V4.2D
    FCVTMS  V4.2D, V26.2D
    FCVTZU  V31.4S, V4.4S, #1
    FCVTZS  V4.4H, V27.4H, #6
    FCVTMU  V17.8H, V3.8H
    FCVTPS  V13.2D, V6.2D
    FCVTL2  V27.2D, V30.4S
    FRINTN  V9.8H, V19.8H
    FCVTNU  V18.2D, V17.2D
    FRINTN  V30.4H, V4.4H
    FRINTI  V19.2D, V30.2D
    FCVTXN  V30.2S, V13.2D
    FRINTI  V6.4H, V30.4H
    FRINTZ  V4.4S, V9.4S
    FCVTZS V10.2D, V19.2D, #24
    FCVTZS  V3.4S, V10.4S, #2
    FCVTAU  V13.2D, V27.2D
    FCVTZS  V27.2S, V14.2S, #21
    FRINTI  V26.4S, V31.4S
    SUBS  X23, X23, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_11
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X2, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X2, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X2, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X2, X22, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X2, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X2, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X2, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X2, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X2, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X2, X22, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X2, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X2, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X2, X22, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X2, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X2, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X2, X22, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X2, X22, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X2, X22, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X2, X22, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X2, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X2, X22, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x1d, LSL #0
    MRS  X2, FPSR
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, V0.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, D0
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, V1.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, D1
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, V2.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, D2
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, V3.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, D3
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, V4.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, D4
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, V5.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, D5
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, V6.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, D6
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, V7.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, D7
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, V8.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, D8
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, V9.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, D9
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, V10.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, D10
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    FMOV  X2, V11.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    FMOV  X2, D11
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    FMOV  X2, V12.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    FMOV  X2, D12
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, V13.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, D13
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    FMOV  X2, V14.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    FMOV  X2, D14
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, V15.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, D15
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, V16.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, D16
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, V17.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, D17
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, V18.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, D18
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, V19.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, D19
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, V20.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, D20
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    FMOV  X2, V21.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    FMOV  X2, D21
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, V22.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, D22
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, V23.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, D23
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, V24.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, D24
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, V25.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, D25
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, V26.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, D26
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, V27.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, D27
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, V28.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, D28
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, V29.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, D29
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, V30.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, D30
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, V31.D[1]
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X2, D31
    SUB  X27, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X2, #0xb817, LSL #0
    MOVK  X2, #0xd47d, LSL #16
    MOVK  X2, #0xbed4, LSL #32
    MOVK  X2, #0x84fc, LSL #48
    MOVZ  X3, #0x8b15, LSL #0
    MOVK  X3, #0x1deb, LSL #16
    MOVK  X3, #0xc3a6, LSL #32
    MOVK  X3, #0x7468, LSL #48
    MOVZ  X6, #0xa76b, LSL #0
    MOVK  X6, #0xc066, LSL #16
    MOVK  X6, #0xcc73, LSL #32
    MOVK  X6, #0x4bc5, LSL #48
    MOVZ  X7, #0xb959, LSL #0
    MOVK  X7, #0xc0b2, LSL #16
    MOVK  X7, #0x6fde, LSL #32
    MOVK  X7, #0x99f7, LSL #48
    MOVZ  X8, #0x304d, LSL #0
    MOVK  X8, #0xe540, LSL #16
    MOVK  X8, #0x1069, LSL #32
    MOVK  X8, #0x765c, LSL #48
    MOVZ  X9, #0xe1e4, LSL #0
    MOVK  X9, #0xca7a, LSL #16
    MOVK  X9, #0xf643, LSL #32
    MOVK  X9, #0xcaf7, LSL #48
    MOVZ  X10, #0xe10d, LSL #0
    MOVK  X10, #0x44b8, LSL #16
    MOVK  X10, #0xc2e8, LSL #32
    MOVK  X10, #0x87f5, LSL #48
    MOVZ  X11, #0x3fb2, LSL #0
    MOVK  X11, #0x6c36, LSL #16
    MOVK  X11, #0x69ca, LSL #32
    MOVK  X11, #0x6f2f, LSL #48
    MOVZ  X13, #0x5bf7, LSL #0
    MOVK  X13, #0x228c, LSL #16
    MOVK  X13, #0xcf2d, LSL #32
    MOVK  X13, #0xc037, LSL #48
    MOVZ  X14, #0x7a28, LSL #0
    MOVK  X14, #0xe0f9, LSL #16
    MOVK  X14, #0xb45c, LSL #32
    MOVK  X14, #0x911a, LSL #48
    MOVZ  X15, #0x96f1, LSL #0
    MOVK  X15, #0x8839, LSL #16
    MOVK  X15, #0x4c9e, LSL #32
    MOVK  X15, #0x921a, LSL #48
    MOVZ  X16, #0xeddc, LSL #0
    MOVK  X16, #0xff47, LSL #16
    MOVK  X16, #0x28be, LSL #32
    MOVK  X16, #0x1b13, LSL #48
    MOVZ  X17, #0x78d9, LSL #0
    MOVK  X17, #0x9b6f, LSL #16
    MOVK  X17, #0xc096, LSL #32
    MOVK  X17, #0x1b30, LSL #48
    MOVZ  X19, #0xdd72, LSL #0
    MOVK  X19, #0x6580, LSL #16
    MOVK  X19, #0x9c9d, LSL #32
    MOVK  X19, #0x481c, LSL #48
    MOVZ  X20, #0x1c09, LSL #0
    MOVK  X20, #0x4669, LSL #16
    MOVK  X20, #0x4e50, LSL #32
    MOVK  X20, #0x8c7b, LSL #48
    MOVZ  X21, #0xa602, LSL #0
    MOVK  X21, #0x7333, LSL #16
    MOVK  X21, #0x521d, LSL #32
    MOVK  X21, #0x12d3, LSL #48
    MOVZ  X22, #0x4f0a, LSL #0
    MOVK  X22, #0xf923, LSL #16
    MOVK  X22, #0x998d, LSL #32
    MOVK  X22, #0x3848, LSL #48
    MOVZ  X23, #0x16f2, LSL #0
    MOVK  X23, #0xdb39, LSL #16
    MOVK  X23, #0xacc8, LSL #32
    MOVK  X23, #0xde2e, LSL #48
    MOVZ  X24, #0x1e9b, LSL #0
    MOVK  X24, #0x12ae, LSL #16
    MOVK  X24, #0xf85, LSL #32
    MOVK  X24, #0x6778, LSL #48
    MOVZ  X25, #0xef83, LSL #0
    MOVK  X25, #0x9502, LSL #16
    MOVK  X25, #0x9c32, LSL #32
    MOVK  X25, #0xe477, LSL #48
    MOVZ  X26, #0x5a7f, LSL #0
    MOVK  X26, #0x2170, LSL #16
    MOVK  X26, #0x49fe, LSL #32
    MOVK  X26, #0x6ee2, LSL #48
    MOVZ  X27, #0x1cdb, LSL #0
    MOVK  X27, #0x9baf, LSL #16
    MOVK  X27, #0x238, LSL #32
    MOVK  X27, #0x6878, LSL #48
    MOVZ  X28, #0x8df4, LSL #0
    MOVK  X28, #0x4af3, LSL #16
    MOVK  X28, #0x370b, LSL #32
    MOVK  X28, #0xce2b, LSL #48
    MOVZ  X29, #0xce40, LSL #0
    MOVK  X29, #0x2224, LSL #16
    MOVK  X29, #0xcc90, LSL #32
    MOVK  X29, #0x7c2f, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X25
    FMOV  D1, X29
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X10
    FMOV  D3, X6
    FMOV  V3.D[1], X26
    FMOV  D4, X13
    FMOV  V4.D[1], X16
    FMOV  D5, X20
    FMOV  V5.D[1], X8
    FMOV  D6, X13
    FMOV  V6.D[1], X2
    FMOV  D7, X14
    FMOV  V7.D[1], X25
    FMOV  D8, X21
    FMOV  V8.D[1], X13
    FMOV  D9, X3
    FMOV  V9.D[1], X23
    FMOV  D10, X20
    FMOV  V10.D[1], X9
    FMOV  D11, X20
    FMOV  V11.D[1], X16
    FMOV  D12, X8
    FMOV  V12.D[1], X9
    FMOV  D13, X29
    FMOV  V13.D[1], X29
    FMOV  D14, X21
    FMOV  V14.D[1], X11
    FMOV  D15, X25
    FMOV  V15.D[1], X9
    FMOV  D16, X22
    FMOV  V16.D[1], X23
    FMOV  D17, X13
    FMOV  V17.D[1], X27
    FMOV  D18, X3
    FMOV  V18.D[1], X3
    FMOV  D19, X22
    FMOV  V19.D[1], X15
    FMOV  D20, X3
    FMOV  V20.D[1], X13
    FMOV  D21, X27
    FMOV  V21.D[1], X8
    FMOV  D22, X26
    FMOV  V22.D[1], X15
    FMOV  D23, X23
    FMOV  V23.D[1], X27
    FMOV  D24, X28
    FMOV  V24.D[1], X10
    FMOV  D25, X7
    FMOV  V25.D[1], X29
    FMOV  D26, X6
    FMOV  V26.D[1], X17
    FMOV  D27, X20
    FMOV  V27.D[1], X6
    FMOV  D28, X2
    FMOV  V28.D[1], X14
    FMOV  D29, X28
    FMOV  V29.D[1], X7
    FMOV  D30, X23
    FMOV  V30.D[1], X19
    FMOV  D31, X28
    FMOV  V31.D[1], X24
    MOVZ  X10, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_12:
    FRINTP  V25.4H, V24.4H
    FCVTZU  V19.2S, V26.2S, #1
    FCVTAU  V25.4S, V31.4S
    FRINTX  V27.2D, V30.2D
    FRINTZ  V6.8H, V25.8H
    FCVTNS  V11.2D, V6.2D
    FCVTXN  V7.2S, V28.2D
    FRINTI  V14.2S, V19.2S
    FRINTM  V11.8H, V29.8H
    FCVTXN  V24.2S, V7.2D
    FCVTZS  V3.2D, V23.2D
    FCVTMU  V14.2S, V3.2S
    FCVTPU  V19.8H, V14.8H
    FCVTXN  V4.2S, V7.2D
    FCVTZS  V21.4H, V28.4H
    FCVTMU  V4.4S, V24.4S
    FCVTPU  V5.4S, V27.4S
    FRINTZ  V2.8H, V11.8H
    FCVTXN  V13.2S, V2.2D
    FCVTPS  V23.2D, V21.2D
    FCVTAU  V29.4H, V19.4H
    FRINTP  V6.4S, V4.4S
    FCVTZU  V3.4H, V23.4H
    FCVTZU  V7.4H, V3.4H
    FCVTNS  V31.2S, V8.2S
    FRINTN  V24.8H, V13.8H
    FCVTPU  V28.8H, V5.8H
    FCVTMU  V14.4H, V29.4H
    FCVTAS  V29.2D, V24.2D
    FCVTPS  V5.2D, V29.2D
    FCVTZS  V24.8H, V11.8H
    FCVTPS  V19.2S, V12.2S
    FCVTXN2  V27.4S, V31.2D
    FCVTPU  V30.4H, V5.4H
    FCVTMS  V23.8H, V24.8H
    FCVTN  V24.4H, V23.4S
    FCVTMS  V8.2S, V27.2S
    FCVTN  V31.4H, V30.4S
    FCVTNU  V30.2D, V19.2D
    FCVTMU  V4.8H, V7.8H
    FCVTNU  V23.2D, V28.2D
    FCVTPS  V27.8H, V30.8H
    FRINTZ  V11.8H, V4.8H
    FCVTL  V13.4S, V14.4H
    FCVTN2  V12.8H, V13.4S
    FRINTN  V5.8H, V23.8H
    FCVTZS  V30.2S, V24.2S, #25
    FCVTZS  V4.4H, V6.4H
    FRINTI  V28.4H, V12.4H
    FCVTL2  V19.4S, V8.8H
    FCVTZU V24.2D, V4.2D, #17
    FCVTMU  V4.4H, V31.4H
    FCVTPU  V31.2D, V3.2D
    FRINTI  V3.4H, V11.4H
    FCVTMU  V23.2D, V30.2D
    FCVTL2  V14.4S, V23.8H
    FCVTL  V11.4S, V3.4H
    FRINTX  V30.4S, V31.4S
    FRINTN  V23.2S, V30.2S
    FCVTPS  V6.4H, V28.4H
    FCVTNS  V31.4H, V23.4H
    FCVTZU  V3.4H, V27.4H, #7
    FRINTX  V8.4H, V11.4H
    FCVTZU  V12.4H, V6.4H, #10
    FRINTZ  V28.4H, V4.4H
    FCVTZS  V11.8H, V14.8H, #16
    FCVTZU V13.2D, V8.2D, #12
    FRINTP  V8.2D, V3.2D
    FCVTNS  V3.4S, V13.4S
    FCVTXN  V27.2S, V12.2D
    FCVTZS  V13.8H, V3.8H, #14
    FCVTPS  V23.2S, V13.2S
    FCVTAS  V12.2D, V11.2D
    FCVTZU V6.2D, V31.2D, #9
    FCVTZS  V4.8H, V12.8H, #8
    FCVTN2  V12.4S, V6.2D
    FRINTX  V30.8H, V27.8H
    FCVTN2  V27.4S, V28.2D
    FRINTI  V28.4H, V19.4H
    FCVTPU  V3.4H, V8.4H
    FCVTPU  V14.4H, V23.4H
    FCVTZS V13.2D, V12.2D, #11
    FRINTX  V23.4H, V3.4H
    FCVTN  V3.2S, V13.2D
    FCVTL  V12.4S, V4.4H
    FRINTN  V6.2D, V23.2D
    FCVTMU  V31.4S, V14.4S
    FCVTZU  V19.4S, V30.4S, #30
    FCVTZU  V8.4S, V27.4S, #8
    FCVTN  V11.4H, V19.4S
    FRINTI  V30.2D, V5.2D
    FCVTNU  V13.4H, V28.4H
    FCVTXN  V4.2S, V6.2D
    FRINTP  V14.8H, V31.8H
    FCVTZU  V27.4S, V6.4S, #22
    FCVTAU  V6.4H, V27.4H
    FCVTN  V5.4H, V6.4S
    FRINTZ  V10.2D, V8.2D
    FCVTZS  V10.8H, V5.8H, #16
    FRINTA  V28.4H, V12.4H
    FCVTNU  V31.8H, V10.8H
    FCVTPS  V19.4H, V3.4H
    FCVTPU  V8.2D, V11.2D
    FRINTA  V5.2S, V8.2S
    FCVTPS  V27.4H, V13.4H
    FCVTNS  V12.8H, V28.8H
    FRINTN  V28.2S, V12.2S
    FCVTZU  V11.4H, V5.4H, #8
    FCVTPS  V6.4S, V19.4S
    FCVTZU  V10.8H, V6.8H
    FRINTP  V5.2S, V10.2S
    FRINTZ  V12.4H, V11.4H
    FRINTA  V10.2S, V31.2S
    FCVTN2  V19.4S, V28.2D
    FCVTPU  V28.4S, V10.4S
    FRINTM  V13.2S, V5.2S
    FRINTI  V4.4H, V12.4H
    FCVTZU  V10.4S, V27.4S, #10
    FCVTNU  V3.8H, V19.8H
    FCVTZU V5.2D, V14.2D, #12
    FCVTZS  V14.4H, V4.4H
    FRINTN  V31.4S, V28.4S
    FCVTZU V28.2D, V13.2D, #44
    FCVTZU  V4.4H, V3.4H
    FCVTAS  V11.2S, V4.2S
    FRINTN  V3.2D, V5.2D
    FCVTN2  V19.4S, V3.2D
    FRINTZ  V27.4S, V28.4S
    FCVTXN2  V13.4S, V31.2D
    FCVTN2  V28.4S, V11.2D
    FCVTXN  V11.2S, V14.2D
    FCVTN  V14.2S, V3.2D
    FRINTA  V3.8H, V28.8H
    FCVTZS  V8.2S, V10.2S, #31
    FRINTI  V4.4H, V8.4H
    FCVTZS  V31.8H, V4.8H
    FCVTMU  V5.8H, V13.8H
    FCVTZU V8.2D, V31.2D, #39
    FCVTN  V28.4H, V14.4S
    FCVTNS  V6.4H, V27.4H
    FCVTZU  V14.4H, V3.4H, #13
    FCVTAU  V3.8H, V19.8H
    FCVTN  V12.4H, V8.4S
    FCVTZU  V4.4H, V16.4H, #12
    FRINTX  V16.2S, V4.2S
    FRINTZ  V8.2S, V3.2S
    FCVTZU  V27.2S, V11.2S, #2
    FCVTPU  V19.2D, V6.2D
    FCVTMS  V31.4S, V28.4S
    FCVTZU  V4.4S, V31.4S, #9
    FCVTZS  V3.4H, V19.4H
    FCVTMU  V20.4S, V3.4S
    FRINTN  V13.4S, V16.4S
    FCVTL  V6.2D, V8.2S
    FCVTZU  V8.2S, V6.2S
    FCVTZU  V10.2D, V13.2D
    FCVTNU  V3.4S, V27.4S
    FCVTL  V27.2D, V14.2S
    FCVTPS  V28.4S, V27.4S
    FCVTZU  V6.2S, V12.2S, #12
    FCVTPS  V12.8H, V20.8H
    FRINTX  V19.4S, V12.4S
    FCVTZS  V13.2S, V8.2S, #22
    FRINTN  V8.8H, V13.8H
    FRINTP  V25.4S, V28.4S
    FRINTN  V16.8H, V10.8H
    FCVTZS V16.2D, V19.2D, #57
    FCVTZU  V27.8H, V6.8H
    FCVTNS  V28.8H, V4.8H
    FCVTNS  V12.8H, V3.8H
    FCVTAU  V14.4S, V8.4S
    FCVTPU  V20.4H, V27.4H
    FRINTZ  V10.4S, V16.4S
    FCVTL  V31.2D, V28.2S
    FCVTZU  V19.2D, V31.2D
    FRINTM  V31.8H, V25.8H
    FCVTAS  V11.4S, V19.4S
    FCVTZS  V8.2D, V20.2D
    FCVTL  V6.4S, V31.4H
    FCVTZS  V4.2S, V12.2S, #22
    FRINTA  V12.4H, V0.4H
    FCVTZU  V25.2S, V11.2S, #30
    FRINTP  V0.2S, V12.2S
    FCVTAS  V3.8H, V19.8H
    FCVTL2  V11.2D, V8.4S
    FCVTZU  V8.2S, V14.2S, #21
    FCVTZS V12.2D, V3.2D, #16
    FRINTA  V31.2D, V25.2D
    FRINTZ  V20.2D, V10.2D
    FCVTZS  V27.8H, V0.8H
    FRINTA  V14.4H, V6.4H
    FCVTZS  V3.4H, V27.4H
    FCVTZS  V16.8H, V20.8H
    FRINTZ  V19.2S, V31.2S
    FCVTMU  V10.4S, V19.4S
    FRINTA  V19.4H, V12.4H
    FRINTN  V25.4H, V19.4H
    FRINTN  V19.4H, V8.4H
    FCVTN  V8.2S, V3.2D
    FCVTZS  V6.4H, V8.4H, #6
    SUBS  X10, X10, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_12
    MOVZ  X29, #0xb817, LSL #0
    MOVK  X29, #0xd47d, LSL #16
    MOVK  X29, #0xbed4, LSL #32
    MOVK  X29, #0x84fc, LSL #48
    SUB  X20, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x8b15, LSL #0
    MOVK  X29, #0x1deb, LSL #16
    MOVK  X29, #0xc3a6, LSL #32
    MOVK  X29, #0x7468, LSL #48
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0xa76b, LSL #0
    MOVK  X29, #0xc066, LSL #16
    MOVK  X29, #0xcc73, LSL #32
    MOVK  X29, #0x4bc5, LSL #48
    SUB  X20, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0xb959, LSL #0
    MOVK  X29, #0xc0b2, LSL #16
    MOVK  X29, #0x6fde, LSL #32
    MOVK  X29, #0x99f7, LSL #48
    SUB  X20, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x304d, LSL #0
    MOVK  X29, #0xe540, LSL #16
    MOVK  X29, #0x1069, LSL #32
    MOVK  X29, #0x765c, LSL #48
    SUB  X20, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0xe1e4, LSL #0
    MOVK  X29, #0xca7a, LSL #16
    MOVK  X29, #0xf643, LSL #32
    MOVK  X29, #0xcaf7, LSL #48
    SUB  X20, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x3fb2, LSL #0
    MOVK  X29, #0x6c36, LSL #16
    MOVK  X29, #0x69ca, LSL #32
    MOVK  X29, #0x6f2f, LSL #48
    SUB  X20, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x5bf7, LSL #0
    MOVK  X29, #0x228c, LSL #16
    MOVK  X29, #0xcf2d, LSL #32
    MOVK  X29, #0xc037, LSL #48
    SUB  X20, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x7a28, LSL #0
    MOVK  X29, #0xe0f9, LSL #16
    MOVK  X29, #0xb45c, LSL #32
    MOVK  X29, #0x911a, LSL #48
    SUB  X20, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x96f1, LSL #0
    MOVK  X29, #0x8839, LSL #16
    MOVK  X29, #0x4c9e, LSL #32
    MOVK  X29, #0x921a, LSL #48
    SUB  X20, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0xeddc, LSL #0
    MOVK  X29, #0xff47, LSL #16
    MOVK  X29, #0x28be, LSL #32
    MOVK  X29, #0x1b13, LSL #48
    SUB  X20, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x78d9, LSL #0
    MOVK  X29, #0x9b6f, LSL #16
    MOVK  X29, #0xc096, LSL #32
    MOVK  X29, #0x1b30, LSL #48
    SUB  X20, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0xdd72, LSL #0
    MOVK  X29, #0x6580, LSL #16
    MOVK  X29, #0x9c9d, LSL #32
    MOVK  X29, #0x481c, LSL #48
    SUB  X20, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0xa602, LSL #0
    MOVK  X29, #0x7333, LSL #16
    MOVK  X29, #0x521d, LSL #32
    MOVK  X29, #0x12d3, LSL #48
    SUB  X20, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x4f0a, LSL #0
    MOVK  X29, #0xf923, LSL #16
    MOVK  X29, #0x998d, LSL #32
    MOVK  X29, #0x3848, LSL #48
    SUB  X20, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x16f2, LSL #0
    MOVK  X29, #0xdb39, LSL #16
    MOVK  X29, #0xacc8, LSL #32
    MOVK  X29, #0xde2e, LSL #48
    SUB  X20, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x1e9b, LSL #0
    MOVK  X29, #0x12ae, LSL #16
    MOVK  X29, #0xf85, LSL #32
    MOVK  X29, #0x6778, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0xef83, LSL #0
    MOVK  X29, #0x9502, LSL #16
    MOVK  X29, #0x9c32, LSL #32
    MOVK  X29, #0xe477, LSL #48
    SUB  X20, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x5a7f, LSL #0
    MOVK  X29, #0x2170, LSL #16
    MOVK  X29, #0x49fe, LSL #32
    MOVK  X29, #0x6ee2, LSL #48
    SUB  X20, X29, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x1cdb, LSL #0
    MOVK  X29, #0x9baf, LSL #16
    MOVK  X29, #0x238, LSL #32
    MOVK  X29, #0x6878, LSL #48
    SUB  X20, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x1d, LSL #0
    MRS  X20, FPSR
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V0.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x4000, LSL #16
    MOVK  X29, #0x4a00, LSL #32
    MOVK  X29, #0x6ee2, LSL #48
    FMOV  X20, D0
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x1cdb, LSL #0
    MOVK  X29, #0x9baf, LSL #16
    MOVK  X29, #0x238, LSL #32
    MOVK  X29, #0x6878, LSL #48
    FMOV  X20, V1.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0xce40, LSL #0
    MOVK  X29, #0x2224, LSL #16
    MOVK  X29, #0xcc90, LSL #32
    MOVK  X29, #0x7c2f, LSL #48
    FMOV  X20, D1
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V2.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D2
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V3.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D3
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V4.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D4
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V5.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D5
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V6.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D6
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V7.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D7
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V8.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D8
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x16f2, LSL #0
    MOVK  X29, #0xdb39, LSL #16
    MOVK  X29, #0xacc8, LSL #32
    MOVK  X29, #0xde2e, LSL #48
    FMOV  X20, V9.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x8b15, LSL #0
    MOVK  X29, #0x1deb, LSL #16
    MOVK  X29, #0xc3a6, LSL #32
    MOVK  X29, #0x7468, LSL #48
    FMOV  X20, D9
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V10.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D10
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V11.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D11
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V12.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D12
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V13.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D13
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V14.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D14
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0xe1e4, LSL #0
    MOVK  X29, #0xca7a, LSL #16
    MOVK  X29, #0xf643, LSL #32
    MOVK  X29, #0xcaf7, LSL #48
    FMOV  X20, V15.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0xef83, LSL #0
    MOVK  X29, #0x9502, LSL #16
    MOVK  X29, #0x9c32, LSL #32
    MOVK  X29, #0xe477, LSL #48
    FMOV  X20, D15
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V16.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D16
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x1cdb, LSL #0
    MOVK  X29, #0x9baf, LSL #16
    MOVK  X29, #0x238, LSL #32
    MOVK  X29, #0x6878, LSL #48
    FMOV  X20, V17.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x5bf7, LSL #0
    MOVK  X29, #0x228c, LSL #16
    MOVK  X29, #0xcf2d, LSL #32
    MOVK  X29, #0xc037, LSL #48
    FMOV  X20, D17
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x8b15, LSL #0
    MOVK  X29, #0x1deb, LSL #16
    MOVK  X29, #0xc3a6, LSL #32
    MOVK  X29, #0x7468, LSL #48
    FMOV  X20, V18.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x8b15, LSL #0
    MOVK  X29, #0x1deb, LSL #16
    MOVK  X29, #0xc3a6, LSL #32
    MOVK  X29, #0x7468, LSL #48
    FMOV  X20, D18
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V19.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D19
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V20.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D20
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V21.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D21
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x96f1, LSL #0
    MOVK  X29, #0x8839, LSL #16
    MOVK  X29, #0x4c9e, LSL #32
    MOVK  X29, #0x921a, LSL #48
    FMOV  X20, V22.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x5a7f, LSL #0
    MOVK  X29, #0x2170, LSL #16
    MOVK  X29, #0x49fe, LSL #32
    MOVK  X29, #0x6ee2, LSL #48
    FMOV  X20, D22
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V23.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D23
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V24.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D24
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V25.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D25
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x78d9, LSL #0
    MOVK  X29, #0x9b6f, LSL #16
    MOVK  X29, #0xc096, LSL #32
    MOVK  X29, #0x1b30, LSL #48
    FMOV  X20, V26.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0xa76b, LSL #0
    MOVK  X29, #0xc066, LSL #16
    MOVK  X29, #0xcc73, LSL #32
    MOVK  X29, #0x4bc5, LSL #48
    FMOV  X20, D26
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V27.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x2, LSL #16
    MOVK  X29, #0xc, LSL #32
    MOVK  X29, #0x1b88, LSL #48
    FMOV  X20, D27
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V28.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D28
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V29.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D29
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V30.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D30
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V31.D[1]
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D31
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
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
    FMOV  D0, X9
    FMOV  V0.D[1], X17
    FMOV  D1, X15
    FMOV  V1.D[1], X27
    FMOV  D2, X22
    FMOV  V2.D[1], X13
    FMOV  D3, X24
    FMOV  V3.D[1], X19
    FMOV  D4, X23
    FMOV  V4.D[1], X14
    FMOV  D5, X29
    FMOV  V5.D[1], X21
    FMOV  D6, X25
    FMOV  V6.D[1], X28
    FMOV  D7, X26
    FMOV  V7.D[1], X13
    FMOV  D8, X2
    FMOV  V8.D[1], X3
    FMOV  D9, X20
    FMOV  V9.D[1], X22
    FMOV  D10, X25
    FMOV  V10.D[1], X22
    FMOV  D11, X14
    FMOV  V11.D[1], X10
    FMOV  D12, X21
    FMOV  V12.D[1], X28
    FMOV  D13, X20
    FMOV  V13.D[1], X21
    FMOV  D14, X28
    FMOV  V14.D[1], X16
    FMOV  D15, X27
    FMOV  V15.D[1], X15
    FMOV  D16, X19
    FMOV  V16.D[1], X17
    FMOV  D17, X9
    FMOV  V17.D[1], X11
    FMOV  D18, X8
    FMOV  V18.D[1], X8
    FMOV  D19, X9
    FMOV  V19.D[1], X17
    FMOV  D20, X3
    FMOV  V20.D[1], X10
    FMOV  D21, X9
    FMOV  V21.D[1], X29
    FMOV  D22, X29
    FMOV  V22.D[1], X2
    FMOV  D23, X19
    FMOV  V23.D[1], X22
    FMOV  D24, X13
    FMOV  V24.D[1], X25
    FMOV  D25, X3
    FMOV  V25.D[1], X26
    FMOV  D26, X24
    FMOV  V26.D[1], X27
    FMOV  D27, X22
    FMOV  V27.D[1], X25
    FMOV  D28, X11
    FMOV  V28.D[1], X16
    FMOV  D29, X21
    FMOV  V29.D[1], X19
    FMOV  D30, X17
    FMOV  V30.D[1], X3
    FMOV  D31, X20
    FMOV  V31.D[1], X17
    MOVZ  X7, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_13:
    FCVTAU  V14.8H, V28.8H
    FCVTAS  V0.4H, V27.4H
    FCVTPU  V21.2S, V23.2S
    FCVTZS  V7.2S, V14.2S, #27
    FRINTA  V26.8H, V30.8H
    FCVTL  V17.4S, V0.4H
    FCVTPS  V14.8H, V21.8H
    FRINTX  V28.2S, V14.2S
    FCVTMS  V16.4H, V26.4H
    FCVTZU  V18.4S, V31.4S, #3
    FCVTZS V15.2D, V7.2D, #62
    FCVTZS V20.2D, V17.2D, #62
    FCVTZU V13.2D, V25.2D, #58
    FCVTMU  V16.8H, V13.8H
    FCVTN  V27.2S, V20.2D
    FRINTZ  V12.2S, V29.2S
    FCVTAU  V21.4S, V28.4S
    FCVTAU  V22.8H, V18.8H
    FRINTP  V10.2S, V0.2S
    FRINTZ  V11.2S, V22.2S
    FCVTAS  V17.4H, V16.4H
    FRINTI  V25.2D, V15.2D
    FRINTX  V30.2S, V21.2S
    FCVTNS  V13.4S, V26.4S
    FRINTN  V15.4S, V12.4S
    FCVTZU V21.2D, V25.2D, #39
    FCVTAU  V25.8H, V21.8H
    FCVTMS  V20.8H, V25.8H
    FCVTNS  V28.4S, V11.4S
    FCVTPS  V31.4H, V15.4H
    FCVTPU  V26.4H, V28.4H
    FCVTAU  V15.4H, V30.4H
    FCVTAU  V29.8H, V13.8H
    FCVTMS  V28.8H, V26.8H
    FCVTNU  V7.4S, V31.4S
    FRINTP  V18.2D, V29.2D
    FCVTZS  V16.2S, V15.2S
    FCVTNS  V14.2S, V17.2S
    FCVTMS  V29.4S, V20.4S
    FRINTA  V12.8H, V28.8H
    FCVTZU  V30.4H, V12.4H, #4
    FCVTNS  V11.8H, V30.8H
    FRINTZ  V21.4S, V7.4S
    FRINTI  V20.2D, V21.2D
    FCVTNU  V13.4S, V27.4S
    FRINTX  V31.2D, V14.2D
    FCVTNS  V22.8H, V11.8H
    FRINTN  V0.8H, V10.8H
    FCVTAS  V7.4H, V31.4H
    FCVTMU  V28.2D, V12.2D
    FCVTZU V25.2D, V13.2D, #50
    FRINTI  V10.2S, V25.2S
    FCVTAU  V17.4H, V22.4H
    FCVTZU  V21.8H, V29.8H, #2
    FRINTZ  V31.4S, V20.4S
    FCVTNU  V20.8H, V0.8H
    FRINTM  V26.2D, V16.2D
    FRINTN  V14.4S, V26.4S
    FCVTMU  V16.2S, V20.2S
    FRINTI  V27.2D, V14.2D
    FRINTN  V20.8H, V7.8H
    FCVTZS  V30.2S, V28.2S
    FCVTNS  V11.8H, V10.8H
    FCVTPS  V25.2S, V11.2S
    FRINTI  V10.8H, V27.8H
    FCVTL  V14.4S, V18.4H
    FCVTZU  V11.8H, V17.8H, #13
    FRINTP  V17.4H, V30.4H
    FCVTZU  V0.4S, V31.4S
    FCVTZS  V7.8H, V21.8H, #4
    FCVTN2  V22.4S, V10.2D
    FRINTN  V18.4S, V16.4S
    FCVTZS  V28.8H, V18.8H
    FCVTAU  V18.2D, V20.2D
    FRINTZ  V29.4S, V14.4S
    FCVTZS  V21.2S, V0.2S, #30
    FCVTMS  V16.4S, V25.4S
    FRINTX  V26.4S, V21.4S
    FCVTNS  V13.8H, V26.8H
    FCVTAS  V26.4H, V13.4H
    FCVTZS  V13.4S, V22.4S, #6
    FRINTM  V21.4H, V13.4H
    FCVTZS  V22.2D, V17.2D
    FCVTN  V11.4H, V22.4S
    FCVTZS  V30.4H, V26.4H, #16
    FRINTX  V10.4H, V11.4H
    FCVTNU  V0.2S, V18.2S
    FCVTL2  V20.4S, V21.8H
    FCVTNS  V21.4S, V20.4S
    FRINTZ  V14.4H, V29.4H
    FCVTZU  V13.4H, V21.4H
    FCVTAU  V26.4S, V28.4S
    FCVTZU  V28.8H, V16.8H, #16
    FCVTMS  V21.2D, V30.2D
    FCVTXN2  V18.4S, V28.2D
    FCVTXN2  V31.4S, V14.2D
    FCVTNU  V16.2D, V21.2D
    FCVTPU  V17.4S, V26.4S
    FCVTZU  V20.4S, V7.4S, #26
    FCVTL  V7.2D, V17.2S
    FRINTP  V29.2S, V16.2S
    FRINTM  V16.2D, V13.2D
    FCVTZU  V14.4S, V18.4S
    FCVTXN  V13.2S, V0.2D
    FCVTN  V28.2S, V16.2D
    FCVTMU  V17.4H, V10.4H
    FCVTN  V10.2S, V31.2D
    FRINTZ  V26.8H, V10.8H
    FRINTM  V30.2S, V7.2S
    FCVTAS  V18.4S, V26.4S
    FCVTPS  V26.2D, V28.2D
    FCVTPS  V31.2S, V29.2S
    FCVTMU  V0.4S, V31.4S
    FRINTZ  V29.4H, V20.4H
    FRINTN  V7.4S, V26.4S
    FCVTPS  V21.4H, V0.4H
    FRINTI  V4.8H, V29.8H
    FCVTMS  V31.8H, V17.8H
    FRINTP  V10.2S, V18.2S
    FRINTN  V16.4H, V14.4H
    FCVTZS  V26.2S, V21.2S, #29
    FRINTN  V0.4H, V10.4H
    FCVTPU  V16.8H, V30.8H
    FCVTAS  V29.4H, V16.4H
    FCVTZU V18.2D, V7.2D, #38
    FRINTX  V21.2D, V4.2D
    FCVTZU  V20.4H, V21.4H
    FCVTMU  V10.4H, V20.4H
    FCVTZU V30.2D, V26.2D, #1
    FCVTMS  V26.8H, V29.8H
    FCVTMS  V30.8H, V26.8H
    FCVTZU  V17.2D, V18.2D
    FRINTM  V14.4H, V31.4H
    FCVTN2  V18.8H, V10.4S
    FCVTAU  V28.2D, V0.2D
    FRINTI  V10.8H, V28.8H
    FCVTAS  V26.8H, V30.8H
    FCVTXN  V30.2S, V17.2D
    FCVTNS  V4.8H, V14.8H
    FCVTZU V16.2D, V4.2D, #36
    FCVTAS  V7.8H, V16.8H
    FCVTZS  V28.4H, V10.4H
    FRINTA  V31.4S, V30.4S
    FCVTXN  V29.2S, V31.2D
    FCVTAS  V31.2S, V7.2S
    FRINTP  V16.4S, V29.4S
    FRINTA  V17.4H, V17.4H
    FCVTMS  V10.8H, V26.8H
    FRINTI  V0.4H, V31.4H
    FCVTN2  V4.8H, V28.4S
    FRINTA  V7.2D, V18.2D
    FCVTMU  V26.2S, V7.2S
    FRINTP  V29.4H, V26.4H
    FCVTNS  V14.2S, V29.2S
    FCVTMU  V29.8H, V4.8H
    FCVTZU  V26.2D, V0.2D
    FCVTNS  V18.4H, V26.4H
    FCVTZU  V31.2S, V14.2S
    FCVTZS  V28.4H, V27.4H, #6
    FCVTAS  V7.8H, V28.8H
    FRINTI  V30.2D, V17.2D
    FRINTX  V28.8H, V31.8H
    FCVTZS  V4.4H, V30.4H
    FRINTM  V30.2D, V20.2D
    FCVTZS  V0.4H, V28.4H
    FCVTPS  V26.8H, V7.8H
    FCVTZU  V31.4S, V18.4S, #22
    FCVTAS  V20.2S, V4.2S
    FRINTI  V7.2D, V30.2D
    FCVTZU  V29.8H, V29.8H, #12
    FRINTX  V14.2S, V31.2S
    FRINTM  V17.2D, V0.2D
    FRINTI  V0.8H, V17.8H
    FRINTN  V27.4S, V0.4S
    FCVTPS  V30.4H, V10.4H
    FCVTZS  V31.8H, V20.8H
    FRINTA  V8.8H, V29.8H
    FCVTZS  V18.4H, V8.4H
    FRINTZ  V8.4S, V14.4S
    FCVTNU  V20.2D, V17.2D
    FRINTA  V28.8H, V8.8H
    FCVTPS  V4.2S, V18.2S
    FCVTXN  V10.2S, V26.2D
    FCVTZS  V14.4H, V20.4H, #4
    FCVTZU  V29.2S, V14.2S, #31
    FCVTMS  V20.4H, V28.4H
    FRINTP  V28.4S, V4.4S
    FCVTN2  V4.8H, V31.4S
    FCVTL2  V14.4S, V28.8H
    FCVTAS  V31.8H, V29.8H
    FCVTAS  V4.4H, V14.4H
    FCVTZS  V26.4S, V10.4S, #26
    FCVTZU  V8.4S, V30.4S, #30
    FCVTN2  V18.8H, V20.4S
    FCVTNU  V29.2S, V31.2S
    FCVTL  V28.2D, V26.2S
    FCVTN  V17.4H, V28.4S
    FRINTZ  V14.8H, V4.8H
    FCVTZS  V10.8H, V14.8H, #11
    FRINTA  V14.4H, V27.4H
    SUBS  X7, X7, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_13
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X27
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x1d, LSL #0
    MRS  X17, FPSR
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V0.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D0
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V1.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D1
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V2.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D2
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V3.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D3
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V4.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D4
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V5.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D5
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V6.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D6
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V7.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D7
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V8.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D8
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V9.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D9
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V10.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D10
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V11.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D11
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V12.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D12
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V13.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D13
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V14.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D14
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V15.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D15
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V16.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D16
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V17.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D17
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V18.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D18
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V19.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D19
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V20.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D20
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V21.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D21
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V22.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D22
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V23.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D23
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V24.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D24
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V25.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D25
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V26.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D26
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V27.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D27
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V28.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D28
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V29.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D29
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V30.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D30
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V31.D[1]
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, D31
    SUB  X16, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
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
    FMOV  V0.D[1], X29
    FMOV  D1, X26
    FMOV  V1.D[1], X25
    FMOV  D2, X28
    FMOV  V2.D[1], X20
    FMOV  D3, X11
    FMOV  V3.D[1], X23
    FMOV  D4, X2
    FMOV  V4.D[1], X23
    FMOV  D5, X23
    FMOV  V5.D[1], X28
    FMOV  D6, X2
    FMOV  V6.D[1], X28
    FMOV  D7, X15
    FMOV  V7.D[1], X16
    FMOV  D8, X9
    FMOV  V8.D[1], X7
    FMOV  D9, X16
    FMOV  V9.D[1], X20
    FMOV  D10, X26
    FMOV  V10.D[1], X16
    FMOV  D11, X11
    FMOV  V11.D[1], X28
    FMOV  D12, X11
    FMOV  V12.D[1], X21
    FMOV  D13, X17
    FMOV  V13.D[1], X9
    FMOV  D14, X26
    FMOV  V14.D[1], X23
    FMOV  D15, X8
    FMOV  V15.D[1], X20
    FMOV  D16, X27
    FMOV  V16.D[1], X10
    FMOV  D17, X6
    FMOV  V17.D[1], X17
    FMOV  D18, X27
    FMOV  V18.D[1], X29
    FMOV  D19, X20
    FMOV  V19.D[1], X26
    FMOV  D20, X7
    FMOV  V20.D[1], X21
    FMOV  D21, X17
    FMOV  V21.D[1], X27
    FMOV  D22, X28
    FMOV  V22.D[1], X27
    FMOV  D23, X24
    FMOV  V23.D[1], X17
    FMOV  D24, X10
    FMOV  V24.D[1], X20
    FMOV  D25, X20
    FMOV  V25.D[1], X25
    FMOV  D26, X22
    FMOV  V26.D[1], X25
    FMOV  D27, X11
    FMOV  V27.D[1], X17
    FMOV  D28, X10
    FMOV  V28.D[1], X25
    FMOV  D29, X28
    FMOV  V29.D[1], X25
    FMOV  D30, X15
    FMOV  V30.D[1], X6
    FMOV  D31, X10
    FMOV  V31.D[1], X20
    MOVZ  X7, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_14:
    FCVTAU  V22.4H, V30.4H
    FRINTN  V6.8H, V31.8H
    FCVTPS  V23.4H, V26.4H
    FRINTA  V7.8H, V25.8H
    FCVTXN  V4.2S, V29.2D
    FCVTZS  V25.4H, V27.4H, #12
    FCVTXN  V20.2S, V25.2D
    FCVTAU  V7.8H, V4.8H
    FRINTX  V22.4S, V20.4S
    FRINTA  V26.4H, V23.4H
    FCVTAU  V0.8H, V6.8H
    FCVTZS  V6.8H, V0.8H
    FCVTMS  V1.2D, V28.2D
    FRINTP  V27.4S, V1.4S
    FCVTMS  V11.8H, V22.8H
    FRINTA  V20.2D, V7.2D
    FCVTXN  V14.2S, V6.2D
    FCVTZS  V0.8H, V26.8H
    FRINTZ  V19.4H, V27.4H
    FRINTM  V10.4H, V0.4H
    FCVTZS  V9.4H, V10.4H, #14
    FCVTZS  V23.4S, V19.4S, #12
    FRINTM  V19.4H, V14.4H
    FCVTL  V6.2D, V19.2S
    FRINTI  V31.4S, V23.4S
    FCVTZS  V7.4S, V11.4S, #2
    FRINTM  V27.8H, V6.8H
    FCVTAS  V0.2D, V27.2D
    FRINTX  V10.2S, V20.2S
    FCVTZS  V27.8H, V10.8H, #6
    FCVTZS  V11.4S, V0.4S, #8
    FRINTP  V6.4S, V31.4S
    FCVTAU  V31.2S, V6.2S
    FCVTN  V20.2S, V7.2D
    FRINTX  V7.8H, V31.8H
    FCVTAU  V31.8H, V9.8H
    FRINTI  V23.4H, V6.4H
    FCVTMU  V10.4H, V31.4H
    FCVTAS  V14.2D, V7.2D
    FCVTMS  V0.4H, V18.4H
    FCVTPS  V7.8H, V11.8H
    FRINTP  V19.4H, V0.4H
    FCVTXN  V0.2S, V7.2D
    FCVTAU  V18.8H, V27.8H
    FCVTPS  V7.2S, V20.2S
    FRINTM  V31.4S, V7.4S
    FCVTNU  V9.4H, V31.4H
    FCVTZS  V31.2S, V23.2S
    FRINTN  V7.4S, V18.4S
    FRINTX  V18.8H, V0.8H
    FCVTXN2  V27.4S, V19.2D
    FCVTNU  V6.4H, V18.4H
    FCVTAU  V2.8H, V7.8H
    FCVTPS  V0.8H, V9.8H
    FCVTN  V7.4H, V31.4S
    FCVTNS  V23.4H, V2.4H
    FCVTXN  V20.2S, V14.2D
    FCVTZS  V19.8H, V23.8H, #9
    FCVTN2  V18.4S, V6.2D
    FRINTZ  V14.2S, V18.2S
    FRINTI  V9.4S, V27.4S
    FCVTPU  V27.8H, V19.8H
    FRINTA  V31.8H, V0.8H
    FCVTAS  V11.4S, V20.4S
    FCVTAS  V20.4H, V14.4H
    FCVTMS  V2.4H, V9.4H
    FCVTMS  V0.4H, V27.4H
    FCVTPU  V14.8H, V7.8H
    FCVTZS  V19.8H, V11.8H, #5
    FCVTMS  V9.4S, V14.4S
    FCVTZS V23.2D, V0.2D, #27
    FCVTAU  V11.2D, V23.2D
    FCVTAU  V6.4H, V31.4H
    FCVTAU  V14.2D, V20.2D
    FCVTZU V18.2D, V14.2D, #17
    FCVTZU  V20.8H, V2.8H, #12
    FCVTZU  V2.4S, V11.4S, #19
    FCVTL  V14.2D, V2.2S
    FCVTPU  V31.4H, V19.4H
    FCVTAU  V7.2S, V31.2S
    FCVTNS  V27.4S, V26.4S
    FCVTNU  V19.4S, V18.4S
    FCVTPS  V23.8H, V19.8H
    FRINTA  V18.2S, V7.2S
    FCVTXN2  V31.4S, V23.2D
    FCVTL2  V23.4S, V6.8H
    FRINTI  V6.2S, V9.2S
    FRINTN  V2.8H, V11.8H
    FCVTN  V19.2S, V18.2D
    FCVTZS V26.2D, V20.2D, #57
    FRINTN  V0.2D, V31.2D
    FCVTZS  V18.8H, V2.8H, #3
    FCVTN  V2.4H, V0.4S
    FCVTMU  V20.2S, V27.2S
    FCVTNU  V9.4S, V2.4S
    FCVTNU  V0.8H, V18.8H
    FCVTMS  V11.2D, V14.2D
    FCVTXN  V13.2S, V23.2D
    FCVTL  V27.4S, V19.4H
    FCVTZS  V2.4S, V27.4S
    FCVTZU  V18.4H, V26.4H, #1
    FCVTPU  V26.4H, V11.4H
    FCVTAU  V7.4H, V0.4H
    FRINTZ  V27.4S, V26.4S
    FCVTL2  V26.4S, V2.8H
    FRINTP  V11.2S, V6.2S
    FCVTMS  V19.2S, V20.2S
    FRINTZ  V20.2S, V7.2S
    FRINTN  V2.8H, V9.8H
    FCVTMU  V23.4S, V31.4S
    FCVTPU  V14.8H, V11.8H
    FCVTMS  V0.8H, V13.8H
    FCVTPU  V6.2D, V18.2D
    FRINTX  V7.2D, V23.2D
    FCVTNU  V13.4H, V7.4H
    FCVTMU  V11.4H, V14.4H
    FCVTMU  V9.2D, V11.2D
    FRINTN  V11.8H, V27.8H
    FRINTP  V12.2S, V9.2S
    FCVTZU  V23.4S, V20.4S, #21
    FCVTN2  V31.4S, V11.2D
    FCVTZS  V20.4S, V2.4S, #16
    FCVTMS  V11.4H, V13.4H
    FCVTAU  V18.4S, V6.4S
    FCVTL2  V30.2D, V12.4S
    FCVTN  V12.2S, V18.2D
    FRINTI  V25.4H, V11.4H
    FCVTNS  V11.4S, V30.4S
    FRINTM  V9.4S, V0.4S
    FCVTNU  V27.8H, V11.8H
    FCVTXN2  V11.4S, V20.2D
    FCVTZS  V20.4S, V25.4S, #6
    FCVTZU  V7.2S, V23.2S
    FRINTP  V23.2S, V31.2S
    FCVTAS  V25.2S, V27.2S
    FCVTZS  V10.2S, V7.2S
    FRINTX  V13.8H, V11.8H
    FCVTPS  V11.4H, V25.4H
    FRINTN  V7.4H, V10.4H
    FCVTL2  V31.2D, V11.4S
    FCVTAU  V18.8H, V20.8H
    FCVTZS V6.2D, V7.2D, #14
    FCVTZS  V7.4H, V9.4H, #15
    FRINTI  V10.2S, V12.2S
    FCVTMS  V12.8H, V7.8H
    FCVTMS  V11.8H, V10.8H
    FCVTNS  V2.2D, V11.2D
    FCVTZU  V0.4H, V6.4H, #1
    FCVTNU  V20.8H, V13.8H
    FCVTMS  V13.2S, V20.2S
    FCVTZS  V25.8H, V31.8H
    FCVTPU  V31.2S, V23.2S
    FCVTZU  V27.8H, V12.8H, #15
    FCVTXN  V12.2S, V11.2D
    FRINTN  V30.2S, V27.2S
    FCVTZU V23.2D, V2.2D, #27
    FRINTN  V29.2D, V0.2D
    FRINTA  V6.2S, V23.2S
    FCVTPS  V11.2S, V6.2S
    FCVTPU  V10.4H, V17.4H
    FCVTN  V0.4H, V14.4S
    FCVTMU  V6.2S, V11.2S
    FRINTZ  V14.4H, V31.4H
    FCVTPU  V17.2D, V14.2D
    FCVTAU  V27.2S, V0.2S
    FRINTN  V23.8H, V13.8H
    FRINTI  V11.2D, V17.2D
    FCVTMU  V2.2S, V6.2S
    FCVTZU  V6.4S, V11.4S, #20
    FRINTM  V31.4H, V18.4H
    FCVTPU  V14.2S, V6.2S
    FCVTPU  V0.4S, V12.4S
    FCVTZS  V12.4H, V29.4H, #3
    FCVTZS  V13.4S, V25.4S
    FRINTZ  V20.2D, V27.2D
    FCVTMU  V6.8H, V31.8H
    FCVTPS  V11.2D, V30.2D
    FRINTM  V30.8H, V13.8H
    FCVTNS  V1.2D, V10.2D
    FCVTPU  V18.2S, V2.2S
    FCVTAU  V17.4H, V23.4H
    FCVTXN  V2.2S, V14.2D
    FRINTP  V10.4H, V12.4H
    FCVTMS  V13.2D, V20.2D
    FCVTZS  V25.4H, V13.4H
    FCVTNS  V29.4S, V17.4S
    FRINTA  V17.8H, V2.8H
    FCVTMU  V20.2D, V6.2D
    FCVTPU  V13.2S, V20.2S
    FCVTMU  V27.4S, V11.4S
    FRINTX  V2.2D, V17.2D
    FCVTMS  V31.2D, V18.2D
    FRINTX  V21.8H, V10.8H
    FCVTZS  V12.8H, V29.8H
    FCVTMU  V11.2S, V12.2S
    FCVTZS V18.2D, V0.2D, #62
    FCVTN  V29.4H, V1.4S
    FRINTI  V6.2D, V27.2D
    FCVTZU  V1.4H, V2.4H, #10
    FCVTZU  V23.4H, V13.4H
    SUBS  X7, X7, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_14
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X25, X21, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X25, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X25, X21, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X25, X21, X9
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X25, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X25, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X25, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X25, X21, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X25, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X25, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X25, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X25, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X25, X21, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X25, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X25, X21, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X25, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X25, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X25, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X25, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x1d, LSL #0
    MRS  X25, FPSR
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, V0.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, D0
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, V1.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, D1
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, V2.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, D2
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    FMOV  X25, V3.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    FMOV  X25, D3
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, V4.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, D4
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    FMOV  X25, V5.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    FMOV  X25, D5
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, V6.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, D6
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, V7.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, D7
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    FMOV  X25, V8.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    FMOV  X25, D8
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, V9.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, D9
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, V10.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, D10
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, V11.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, D11
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, V12.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, D12
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, V13.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, D13
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, V14.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, D14
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    FMOV  X25, V15.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    FMOV  X25, D15
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    FMOV  X25, V16.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    FMOV  X25, D16
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, V17.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, D17
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, V18.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, D18
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, V19.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, D19
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, V20.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, D20
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, V21.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, D21
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, V22.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, D22
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, V23.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, D23
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    FMOV  X25, V24.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    FMOV  X25, D24
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, V25.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, D25
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, V26.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, D26
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, V27.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, D27
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    FMOV  X25, V28.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    FMOV  X25, D28
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, V29.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, D29
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, V30.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, D30
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, V31.D[1]
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X25, D31
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X2, #0x45c7, LSL #0
    MOVK  X2, #0xbe34, LSL #16
    MOVK  X2, #0x2d8f, LSL #32
    MOVK  X2, #0xff28, LSL #48
    MOVZ  X3, #0xda2d, LSL #0
    MOVK  X3, #0x85a2, LSL #16
    MOVK  X3, #0xc7e4, LSL #32
    MOVK  X3, #0xa9fb, LSL #48
    MOVZ  X6, #0x2bfe, LSL #0
    MOVK  X6, #0xca37, LSL #16
    MOVK  X6, #0x940a, LSL #32
    MOVK  X6, #0x9dba, LSL #48
    MOVZ  X7, #0x1bd7, LSL #0
    MOVK  X7, #0x8da8, LSL #16
    MOVK  X7, #0xad6a, LSL #32
    MOVK  X7, #0x5437, LSL #48
    MOVZ  X8, #0x367d, LSL #0
    MOVK  X8, #0x322a, LSL #16
    MOVK  X8, #0xf90a, LSL #32
    MOVK  X8, #0xe14c, LSL #48
    MOVZ  X9, #0x962a, LSL #0
    MOVK  X9, #0xe702, LSL #16
    MOVK  X9, #0x555e, LSL #32
    MOVK  X9, #0x3ce0, LSL #48
    MOVZ  X10, #0xfc10, LSL #0
    MOVK  X10, #0x2d9b, LSL #16
    MOVK  X10, #0x2987, LSL #32
    MOVK  X10, #0xd95, LSL #48
    MOVZ  X11, #0x8347, LSL #0
    MOVK  X11, #0x7d6b, LSL #16
    MOVK  X11, #0x6e1, LSL #32
    MOVK  X11, #0xcdd5, LSL #48
    MOVZ  X13, #0xb2f7, LSL #0
    MOVK  X13, #0x4ef8, LSL #16
    MOVK  X13, #0x6c31, LSL #32
    MOVK  X13, #0xb1fe, LSL #48
    MOVZ  X14, #0x3f72, LSL #0
    MOVK  X14, #0xaa05, LSL #16
    MOVK  X14, #0x904a, LSL #32
    MOVK  X14, #0xc0e1, LSL #48
    MOVZ  X15, #0xffd2, LSL #0
    MOVK  X15, #0x4255, LSL #16
    MOVK  X15, #0x44c4, LSL #32
    MOVK  X15, #0xe793, LSL #48
    MOVZ  X16, #0x2d19, LSL #0
    MOVK  X16, #0x70df, LSL #16
    MOVK  X16, #0x5dcc, LSL #32
    MOVK  X16, #0xe317, LSL #48
    MOVZ  X17, #0xd0e2, LSL #0
    MOVK  X17, #0x58ca, LSL #16
    MOVK  X17, #0x27e6, LSL #32
    MOVK  X17, #0x4b29, LSL #48
    MOVZ  X19, #0xfa8f, LSL #0
    MOVK  X19, #0x3419, LSL #16
    MOVK  X19, #0x4a1b, LSL #32
    MOVK  X19, #0x3006, LSL #48
    MOVZ  X20, #0x2a6a, LSL #0
    MOVK  X20, #0x2f9e, LSL #16
    MOVK  X20, #0xe6f3, LSL #32
    MOVK  X20, #0x3a68, LSL #48
    MOVZ  X21, #0x9bb2, LSL #0
    MOVK  X21, #0x6265, LSL #16
    MOVK  X21, #0xf9b8, LSL #32
    MOVK  X21, #0x46bf, LSL #48
    MOVZ  X22, #0xc8a7, LSL #0
    MOVK  X22, #0x15aa, LSL #16
    MOVK  X22, #0x3d4, LSL #32
    MOVK  X22, #0xe5f9, LSL #48
    MOVZ  X23, #0xe0fe, LSL #0
    MOVK  X23, #0x380c, LSL #16
    MOVK  X23, #0x930b, LSL #32
    MOVK  X23, #0xccfb, LSL #48
    MOVZ  X24, #0xe3bc, LSL #0
    MOVK  X24, #0x4646, LSL #16
    MOVK  X24, #0xa15c, LSL #32
    MOVK  X24, #0x1409, LSL #48
    MOVZ  X25, #0xd078, LSL #0
    MOVK  X25, #0xc592, LSL #16
    MOVK  X25, #0x7586, LSL #32
    MOVK  X25, #0x6776, LSL #48
    MOVZ  X26, #0xe25a, LSL #0
    MOVK  X26, #0x793c, LSL #16
    MOVK  X26, #0xf631, LSL #32
    MOVK  X26, #0x7501, LSL #48
    MOVZ  X27, #0x2237, LSL #0
    MOVK  X27, #0x998b, LSL #16
    MOVK  X27, #0xd8e9, LSL #32
    MOVK  X27, #0xb609, LSL #48
    MOVZ  X28, #0x7310, LSL #0
    MOVK  X28, #0x92fc, LSL #16
    MOVK  X28, #0xa9d8, LSL #32
    MOVK  X28, #0x775, LSL #48
    MOVZ  X29, #0x6d1c, LSL #0
    MOVK  X29, #0x45ab, LSL #16
    MOVK  X29, #0xdbd6, LSL #32
    MOVK  X29, #0x6d19, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X28
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X25
    FMOV  D3, X24
    FMOV  V3.D[1], X16
    FMOV  D4, X16
    FMOV  V4.D[1], X17
    FMOV  D5, X27
    FMOV  V5.D[1], X26
    FMOV  D6, X16
    FMOV  V6.D[1], X21
    FMOV  D7, X28
    FMOV  V7.D[1], X6
    FMOV  D8, X11
    FMOV  V8.D[1], X13
    FMOV  D9, X14
    FMOV  V9.D[1], X19
    FMOV  D10, X15
    FMOV  V10.D[1], X19
    FMOV  D11, X19
    FMOV  V11.D[1], X22
    FMOV  D12, X7
    FMOV  V12.D[1], X17
    FMOV  D13, X10
    FMOV  V13.D[1], X6
    FMOV  D14, X29
    FMOV  V14.D[1], X20
    FMOV  D15, X24
    FMOV  V15.D[1], X7
    FMOV  D16, X3
    FMOV  V16.D[1], X29
    FMOV  D17, X13
    FMOV  V17.D[1], X11
    FMOV  D18, X6
    FMOV  V18.D[1], X29
    FMOV  D19, X28
    FMOV  V19.D[1], X21
    FMOV  D20, X25
    FMOV  V20.D[1], X15
    FMOV  D21, X15
    FMOV  V21.D[1], X15
    FMOV  D22, X11
    FMOV  V22.D[1], X9
    FMOV  D23, X22
    FMOV  V23.D[1], X21
    FMOV  D24, X11
    FMOV  V24.D[1], X25
    FMOV  D25, X29
    FMOV  V25.D[1], X29
    FMOV  D26, X21
    FMOV  V26.D[1], X26
    FMOV  D27, X10
    FMOV  V27.D[1], X27
    FMOV  D28, X6
    FMOV  V28.D[1], X28
    FMOV  D29, X22
    FMOV  V29.D[1], X9
    FMOV  D30, X23
    FMOV  V30.D[1], X14
    FMOV  D31, X10
    FMOV  V31.D[1], X9
    MOVZ  X6, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_15:
    FCVTN  V10.2S, V26.2D
    FCVTZS  V25.8H, V10.8H, #10
    FCVTPS  V19.4S, V23.4S
    FRINTZ  V3.2S, V28.2S
    FCVTZU  V13.2S, V3.2S, #32
    FRINTI  V7.4H, V27.4H
    FCVTNS  V4.4H, V25.4H
    FCVTXN2  V2.4S, V31.2D
    FCVTZS  V17.2S, V30.2S, #24
    FRINTA  V29.2D, V17.2D
    FRINTP  V20.8H, V24.8H
    FCVTZU  V6.2S, V19.2S, #3
    FRINTI  V28.2D, V4.2D
    FCVTXN  V15.2S, V29.2D
    FCVTAS  V25.4S, V13.4S
    FCVTPU  V12.8H, V2.8H
    FRINTX  V25.4S, V28.4S
    FRINTI  V11.8H, V7.8H
    FCVTNS  V15.4H, V12.4H
    FCVTL  V26.4S, V20.4H
    FCVTMU  V31.4H, V25.4H
    FCVTPS  V23.4H, V11.4H
    FCVTPS  V10.2D, V15.2D
    FCVTZS V12.2D, V31.2D, #13
    FCVTNS  V30.4H, V26.4H
    FRINTP  V3.8H, V23.8H
    FRINTM  V25.2D, V18.2D
    FCVTNS  V23.4H, V10.4H
    FCVTNU  V29.4H, V12.4H
    FCVTAS  V17.2D, V29.2D
    FRINTA  V27.2D, V12.2D
    FCVTXN2  V7.4S, V30.2D
    FCVTPU  V10.4H, V25.4H
    FRINTP  V18.4H, V17.4H
    FCVTZS  V11.2D, V7.2D
    FRINTP  V19.4H, V3.4H
    FRINTI  V26.8H, V19.8H
    FRINTX  V29.2S, V6.2S
    FRINTN  V12.4S, V23.4S
    FCVTZU  V19.2S, V10.2S, #30
    FCVTZS  V10.4S, V19.4S, #26
    FCVTMS  V15.4H, V12.4H
    FCVTL  V23.2D, V18.2S
    FCVTZS  V31.4S, V26.4S, #25
    FCVTZS V25.2D, V27.2D, #35
    FCVTXN  V20.2S, V25.2D
    FRINTZ  V3.4H, V20.4H
    FRINTX  V26.2D, V7.2D
    FRINTZ  V27.8H, V29.8H
    FRINTI  V19.4H, V10.4H
    FCVTL2  V6.2D, V24.4S
    FRINTP  V10.4H, V15.4H
    FCVTNS  V12.4H, V3.4H
    FCVTZU  V20.4H, V19.4H
    FCVTAS  V29.4H, V10.4H
    FCVTMS  V25.4S, V29.4S
    FRINTP  V24.4S, V6.4S
    FCVTXN  V6.2S, V27.2D
    FCVTMU  V18.4S, V11.4S
    FCVTAS  V3.8H, V23.8H
    FRINTA  V19.4S, V26.4S
    FCVTZU  V27.4H, V18.4H, #13
    FCVTAU  V26.4S, V3.4S
    FCVTZU V15.2D, V20.2D, #9
    FCVTNS  V7.8H, V31.8H
    FCVTN2  V10.8H, V7.4S
    FRINTX  V11.2S, V24.2S
    FCVTN  V24.4H, V26.4S
    FCVTMS  V7.4S, V10.4S
    FCVTAS  V23.4H, V25.4H
    FCVTN2  V29.8H, V7.4S
    FCVTMU  V18.4H, V15.4H
    FCVTZU V15.2D, V27.2D, #28
    FRINTX  V10.4H, V19.4H
    FRINTA  V27.2S, V11.2S
    FCVTL2  V25.2D, V10.4S
    FRINTN  V19.4H, V23.4H
    FRINTP  V7.8H, V6.8H
    FCVTZS  V31.2S, V24.2S, #22
    FCVTAU  V24.8H, V31.8H
    FCVTMS  V6.4H, V29.4H
    FCVTZU  V10.8H, V24.8H, #4
    FRINTX  V11.2D, V12.2D
    FCVTPU  V26.4S, V18.4S
    FCVTN  V18.2S, V27.2D
    FCVTAU  V27.2D, V18.2D
    FCVTZS  V18.8H, V27.8H
    FRINTX  V27.8H, V15.8H
    FRINTA  V24.4H, V7.4H
    FCVTMS  V29.2S, V19.2S
    FCVTMS  V31.4S, V11.4S
    FCVTZS V12.2D, V18.2D, #3
    FRINTZ  V11.4H, V12.4H
    FCVTL  V7.4S, V31.4H
    FCVTZS  V23.8H, V10.8H
    FCVTPU  V31.2D, V26.2D
    FCVTZU V26.2D, V31.2D, #63
    FCVTZU  V12.8H, V27.8H
    FCVTMU  V19.8H, V25.8H
    FCVTAU  V18.2D, V29.2D
    FCVTZS  V29.2S, V19.2S, #13
    FCVTZU  V10.2S, V24.2S, #17
    FCVTNU  V15.4S, V11.4S
    FCVTNU  V31.8H, V7.8H
    FRINTM  V24.8H, V31.8H
    FCVTNS  V7.8H, V23.8H
    FCVTPS  V25.8H, V29.8H
    FCVTZS V27.2D, V18.2D, #13
    FRINTN  V11.4S, V7.4S
    FCVTXN  V7.2S, V26.2D
    FRINTM  V26.8H, V27.8H
    FCVTAS  V27.8H, V12.8H
    FCVTNS  V18.2D, V27.2D
    FCVTN2  V28.4S, V10.2D
    FCVTZS  V31.8H, V25.8H, #11
    FCVTMU  V12.2S, V24.2S
    FCVTNU  V20.2D, V28.2D
    FRINTN  V19.2D, V15.2D
    FCVTMU  V10.4H, V20.4H
    FCVTMU  V29.4H, V29.4H
    FRINTA  V24.4S, V18.4S
    FRINTZ  V20.4H, V19.4H
    FCVTN  V19.4H, V24.4S
    FCVTAS  V27.2D, V12.2D
    FRINTM  V28.2D, V29.2D
    FCVTXN2  V12.4S, V26.2D
    FCVTMS  V24.4S, V31.4S
    FCVTMU  V18.4H, V7.4H
    FRINTM  V31.2S, V10.2S
    FCVTNU  V29.2S, V28.2S
    FCVTZS  V10.8H, V11.8H, #5
    FCVTMS  V23.2S, V20.2S
    FCVTAU  V15.4S, V18.4S
    FCVTZU  V25.8H, V10.8H
    FRINTP  V20.2D, V31.2D
    FRINTA  V26.2D, V20.2D
    FCVTNS  V18.2S, V19.2S
    FCVTZU  V10.4H, V24.4H, #5
    FRINTA  V24.4H, V12.4H
    FCVTMU  V23.4H, V7.4H
    FRINTA  V28.4H, V15.4H
    FCVTZU V11.2D, V27.2D, #1
    FRINTM  V31.4S, V23.4S
    FCVTNS  V27.2S, V29.2S
    FCVTN  V29.2S, V25.2D
    FCVTL  V7.2D, V27.2S
    FCVTZU  V15.4S, V18.4S
    FRINTA  V20.4H, V7.4H
    FCVTPS  V7.2S, V29.2S
    FCVTNU  V25.2S, V31.2S
    FRINTA  V18.8H, V24.8H
    FRINTP  V24.8H, V25.8H
    FCVTPU  V12.4H, V11.4H
    FCVTMU  V27.2S, V19.2S
    FCVTXN2  V31.4S, V7.2D
    FCVTMU  V29.4H, V2.4H
    FCVTZS V23.2D, V10.2D, #24
    FCVTAU  V11.2S, V31.2S
    FRINTI  V25.8H, V11.8H
    FCVTNU  V19.2S, V12.2S
    FCVTPS  V12.8H, V18.8H
    FCVTZS  V7.4S, V26.4S
    FCVTMU  V2.8H, V24.8H
    FCVTZS  V24.4H, V15.4H, #4
    FCVTZU  V10.8H, V20.8H, #16
    FCVTZU  V31.4H, V23.4H, #10
    FRINTN  V11.8H, V31.8H
    FRINTZ  V18.4S, V10.4S
    FCVTXN2  V10.4S, V24.2D
    FCVTZU  V20.4H, V19.4H, #2
    FCVTAU  V15.4H, V7.4H
    FRINTA  V26.4H, V4.4H
    FCVTPS  V23.8H, V20.8H
    FRINTP  V6.2S, V10.2S
    FCVTMS  V24.2D, V27.2D
    FCVTPS  V31.8H, V15.8H
    FCVTZS V19.2D, V12.2D, #39
    FCVTZS  V15.2S, V19.2S
    FCVTAS  V10.2S, V15.2S
    FCVTZS  V15.8H, V10.8H
    FRINTP  V19.4S, V31.4S
    FCVTZS  V27.8H, V15.8H, #13
    FCVTMS  V7.4S, V27.4S
    FCVTL2  V15.4S, V7.8H
    FCVTZS  V12.8H, V25.8H
    FRINTX  V7.2S, V26.2S
    FCVTL  V20.4S, V19.4H
    FRINTP  V10.8H, V24.8H
    FRINTI  V19.2S, V18.2S
    FCVTAS  V24.8H, V6.8H
    FCVTZU V27.2D, V24.2D, #11
    FCVTZS  V31.4S, V19.4S, #1
    FRINTX  V4.4H, V15.4H
    FRINTI  V15.4H, V12.4H
    FCVTZS  V25.4S, V11.4S
    FCVTZU V18.2D, V25.2D, #15
    FCVTN2  V21.4S, V31.2D
    FCVTZU  V31.4S, V7.4S, #21
    FCVTPU  V25.2D, V4.2D
    FRINTN  V6.4S, V25.4S
    SUBS  X6, X6, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_15
    MOVZ  X11, #0x45c7, LSL #0
    MOVK  X11, #0xbe34, LSL #16
    MOVK  X11, #0x2d8f, LSL #32
    MOVK  X11, #0xff28, LSL #48
    SUB  X29, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xda2d, LSL #0
    MOVK  X11, #0x85a2, LSL #16
    MOVK  X11, #0xc7e4, LSL #32
    MOVK  X11, #0xa9fb, LSL #48
    SUB  X29, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X29, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x1bd7, LSL #0
    MOVK  X11, #0x8da8, LSL #16
    MOVK  X11, #0xad6a, LSL #32
    MOVK  X11, #0x5437, LSL #48
    SUB  X29, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x367d, LSL #0
    MOVK  X11, #0x322a, LSL #16
    MOVK  X11, #0xf90a, LSL #32
    MOVK  X11, #0xe14c, LSL #48
    SUB  X29, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x962a, LSL #0
    MOVK  X11, #0xe702, LSL #16
    MOVK  X11, #0x555e, LSL #32
    MOVK  X11, #0x3ce0, LSL #48
    SUB  X29, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xfc10, LSL #0
    MOVK  X11, #0x2d9b, LSL #16
    MOVK  X11, #0x2987, LSL #32
    MOVK  X11, #0xd95, LSL #48
    SUB  X29, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xb2f7, LSL #0
    MOVK  X11, #0x4ef8, LSL #16
    MOVK  X11, #0x6c31, LSL #32
    MOVK  X11, #0xb1fe, LSL #48
    SUB  X29, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x3f72, LSL #0
    MOVK  X11, #0xaa05, LSL #16
    MOVK  X11, #0x904a, LSL #32
    MOVK  X11, #0xc0e1, LSL #48
    SUB  X29, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xffd2, LSL #0
    MOVK  X11, #0x4255, LSL #16
    MOVK  X11, #0x44c4, LSL #32
    MOVK  X11, #0xe793, LSL #48
    SUB  X29, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x2d19, LSL #0
    MOVK  X11, #0x70df, LSL #16
    MOVK  X11, #0x5dcc, LSL #32
    MOVK  X11, #0xe317, LSL #48
    SUB  X29, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xd0e2, LSL #0
    MOVK  X11, #0x58ca, LSL #16
    MOVK  X11, #0x27e6, LSL #32
    MOVK  X11, #0x4b29, LSL #48
    SUB  X29, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x2a6a, LSL #0
    MOVK  X11, #0x2f9e, LSL #16
    MOVK  X11, #0xe6f3, LSL #32
    MOVK  X11, #0x3a68, LSL #48
    SUB  X29, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x9bb2, LSL #0
    MOVK  X11, #0x6265, LSL #16
    MOVK  X11, #0xf9b8, LSL #32
    MOVK  X11, #0x46bf, LSL #48
    SUB  X29, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xc8a7, LSL #0
    MOVK  X11, #0x15aa, LSL #16
    MOVK  X11, #0x3d4, LSL #32
    MOVK  X11, #0xe5f9, LSL #48
    SUB  X29, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xe0fe, LSL #0
    MOVK  X11, #0x380c, LSL #16
    MOVK  X11, #0x930b, LSL #32
    MOVK  X11, #0xccfb, LSL #48
    SUB  X29, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xe3bc, LSL #0
    MOVK  X11, #0x4646, LSL #16
    MOVK  X11, #0xa15c, LSL #32
    MOVK  X11, #0x1409, LSL #48
    SUB  X29, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xd078, LSL #0
    MOVK  X11, #0xc592, LSL #16
    MOVK  X11, #0x7586, LSL #32
    MOVK  X11, #0x6776, LSL #48
    SUB  X29, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xe25a, LSL #0
    MOVK  X11, #0x793c, LSL #16
    MOVK  X11, #0xf631, LSL #32
    MOVK  X11, #0x7501, LSL #48
    SUB  X29, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x2237, LSL #0
    MOVK  X11, #0x998b, LSL #16
    MOVK  X11, #0xd8e9, LSL #32
    MOVK  X11, #0xb609, LSL #48
    SUB  X29, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x7310, LSL #0
    MOVK  X11, #0x92fc, LSL #16
    MOVK  X11, #0xa9d8, LSL #32
    MOVK  X11, #0x775, LSL #48
    SUB  X29, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x1d, LSL #0
    MRS  X29, FPSR
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x7310, LSL #0
    MOVK  X11, #0x92fc, LSL #16
    MOVK  X11, #0xa9d8, LSL #32
    MOVK  X11, #0x775, LSL #48
    FMOV  X29, V0.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x6d1c, LSL #0
    MOVK  X11, #0x45ab, LSL #16
    MOVK  X11, #0xdbd6, LSL #32
    MOVK  X11, #0x6d19, LSL #48
    FMOV  X29, D0
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x2237, LSL #0
    MOVK  X11, #0x998b, LSL #16
    MOVK  X11, #0xd8e9, LSL #32
    MOVK  X11, #0xb609, LSL #48
    FMOV  X29, V1.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xd078, LSL #0
    MOVK  X11, #0xc592, LSL #16
    MOVK  X11, #0x7586, LSL #32
    MOVK  X11, #0x6776, LSL #48
    FMOV  X29, D1
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V2.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, D2
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V3.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, D3
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V4.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, D4
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xe25a, LSL #0
    MOVK  X11, #0x793c, LSL #16
    MOVK  X11, #0xf631, LSL #32
    MOVK  X11, #0x7501, LSL #48
    FMOV  X29, V5.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x2237, LSL #0
    MOVK  X11, #0x998b, LSL #16
    MOVK  X11, #0xd8e9, LSL #32
    MOVK  X11, #0xb609, LSL #48
    FMOV  X29, D5
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V6.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, D6
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V7.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, D7
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xb2f7, LSL #0
    MOVK  X11, #0x4ef8, LSL #16
    MOVK  X11, #0x6c31, LSL #32
    MOVK  X11, #0xb1fe, LSL #48
    FMOV  X29, V8.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x8347, LSL #0
    MOVK  X11, #0x7d6b, LSL #16
    MOVK  X11, #0x6e1, LSL #32
    MOVK  X11, #0xcdd5, LSL #48
    FMOV  X29, D8
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xfa8f, LSL #0
    MOVK  X11, #0x3419, LSL #16
    MOVK  X11, #0x4a1b, LSL #32
    MOVK  X11, #0x3006, LSL #48
    FMOV  X29, V9.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x3f72, LSL #0
    MOVK  X11, #0xaa05, LSL #16
    MOVK  X11, #0x904a, LSL #32
    MOVK  X11, #0xc0e1, LSL #48
    FMOV  X29, D9
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V10.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, D10
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V11.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, D11
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V12.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, D12
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V13.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, D13
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x2a6a, LSL #0
    MOVK  X11, #0x2f9e, LSL #16
    MOVK  X11, #0xe6f3, LSL #32
    MOVK  X11, #0x3a68, LSL #48
    FMOV  X29, V14.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x6d1c, LSL #0
    MOVK  X11, #0x45ab, LSL #16
    MOVK  X11, #0xdbd6, LSL #32
    MOVK  X11, #0x6d19, LSL #48
    FMOV  X29, D14
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V15.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, D15
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x6d1c, LSL #0
    MOVK  X11, #0x45ab, LSL #16
    MOVK  X11, #0xdbd6, LSL #32
    MOVK  X11, #0x6d19, LSL #48
    FMOV  X29, V16.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xda2d, LSL #0
    MOVK  X11, #0x85a2, LSL #16
    MOVK  X11, #0xc7e4, LSL #32
    MOVK  X11, #0xa9fb, LSL #48
    FMOV  X29, D16
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V17.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, D17
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V18.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, D18
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V19.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, D19
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V20.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, D20
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V21.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0xffd2, LSL #0
    MOVK  X11, #0x4255, LSL #16
    MOVK  X11, #0x44c4, LSL #32
    MOVK  X11, #0xe793, LSL #48
    FMOV  X29, D21
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x962a, LSL #0
    MOVK  X11, #0xe702, LSL #16
    MOVK  X11, #0x555e, LSL #32
    MOVK  X11, #0x3ce0, LSL #48
    FMOV  X29, V22.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x8347, LSL #0
    MOVK  X11, #0x7d6b, LSL #16
    MOVK  X11, #0x6e1, LSL #32
    MOVK  X11, #0xcdd5, LSL #48
    FMOV  X29, D22
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V23.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, D23
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V24.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, D24
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V25.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, D25
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V26.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, D26
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V27.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, D27
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V28.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, D28
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V29.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, D29
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V30.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, D30
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V31.D[1]
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, D31
    SUB  X19, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
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
    FMOV  V0.D[1], X26
    FMOV  D1, X19
    FMOV  V1.D[1], X14
    FMOV  D2, X24
    FMOV  V2.D[1], X10
    FMOV  D3, X7
    FMOV  V3.D[1], X21
    FMOV  D4, X22
    FMOV  V4.D[1], X20
    FMOV  D5, X27
    FMOV  V5.D[1], X28
    FMOV  D6, X25
    FMOV  V6.D[1], X23
    FMOV  D7, X14
    FMOV  V7.D[1], X2
    FMOV  D8, X14
    FMOV  V8.D[1], X29
    FMOV  D9, X10
    FMOV  V9.D[1], X10
    FMOV  D10, X8
    FMOV  V10.D[1], X25
    FMOV  D11, X28
    FMOV  V11.D[1], X29
    FMOV  D12, X11
    FMOV  V12.D[1], X10
    FMOV  D13, X7
    FMOV  V13.D[1], X2
    FMOV  D14, X19
    FMOV  V14.D[1], X23
    FMOV  D15, X19
    FMOV  V15.D[1], X23
    FMOV  D16, X25
    FMOV  V16.D[1], X13
    FMOV  D17, X7
    FMOV  V17.D[1], X14
    FMOV  D18, X11
    FMOV  V18.D[1], X24
    FMOV  D19, X9
    FMOV  V19.D[1], X25
    FMOV  D20, X20
    FMOV  V20.D[1], X17
    FMOV  D21, X15
    FMOV  V21.D[1], X16
    FMOV  D22, X16
    FMOV  V22.D[1], X23
    FMOV  D23, X19
    FMOV  V23.D[1], X22
    FMOV  D24, X29
    FMOV  V24.D[1], X24
    FMOV  D25, X13
    FMOV  V25.D[1], X23
    FMOV  D26, X25
    FMOV  V26.D[1], X2
    FMOV  D27, X13
    FMOV  V27.D[1], X2
    FMOV  D28, X7
    FMOV  V28.D[1], X11
    FMOV  D29, X17
    FMOV  V29.D[1], X15
    FMOV  D30, X13
    FMOV  V30.D[1], X16
    FMOV  D31, X19
    FMOV  V31.D[1], X9
    MOVZ  X15, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_16:
    FCVTNS  V11.4H, V24.4H
    FCVTMU  V15.2D, V30.2D
    FCVTNS  V5.8H, V23.8H
    FCVTZU V29.2D, V31.2D, #10
    FCVTPS  V25.8H, V26.8H
    FCVTPS  V30.8H, V25.8H
    FRINTZ  V5.4H, V15.4H
    FCVTZU  V2.4H, V11.4H
    FRINTN  V25.4H, V28.4H
    FRINTN  V5.2D, V29.2D
    FRINTM  V26.2D, V27.2D
    FCVTXN  V18.2S, V25.2D
    FCVTZU  V10.8H, V30.8H
    FRINTP  V9.8H, V26.8H
    FCVTAU  V23.8H, V9.8H
    FRINTX  V3.4H, V10.4H
    FRINTN  V6.2S, V2.2S
    FRINTN  V13.2S, V5.2S
    FCVTPU  V1.8H, V24.8H
    FCVTMS  V28.8H, V16.8H
    FRINTZ  V7.4H, V1.4H
    FCVTMS  V15.4H, V18.4H
    FCVTL2  V9.2D, V23.4S
    FCVTZU  V10.2D, V6.2D
    FCVTL  V24.4S, V9.4H
    FCVTZU  V27.4S, V10.4S, #6
    FCVTZU  V11.2S, V15.2S
    FCVTZU  V10.4S, V13.4S, #5
    FRINTI  V15.8H, V7.8H
    FCVTNS  V26.2D, V26.2D
    FCVTNU  V18.4H, V28.4H
    FCVTZS  V9.2S, V24.2S, #9
    FCVTNS  V6.8H, V18.8H
    FRINTX  V24.2S, V2.2S
    FRINTP  V28.2D, V3.2D
    FCVTZS  V1.8H, V28.8H
    FRINTX  V7.2D, V7.2D
    FCVTZS  V16.4S, V7.4S
    FCVTZU  V13.4H, V27.4H
    FCVTMU  V28.4H, V9.4H
    FCVTZS  V2.8H, V26.8H, #5
    FCVTL2  V23.2D, V10.4S
    FCVTZS  V18.8H, V25.8H, #7
    FRINTP  V26.4S, V6.4S
    FCVTZU V10.2D, V28.2D, #61
    FCVTNU  V27.4S, V1.4S
    FCVTNS  V1.2S, V24.2S
    FCVTNS  V9.2D, V15.2D
    FCVTPU  V28.2D, V9.2D
    FRINTM  V3.8H, V26.8H
    FRINTA  V25.2D, V11.2D
    FRINTX  V15.2S, V16.2S
    FRINTN  V7.2D, V2.2D
    FCVTZS V24.2D, V28.2D, #61
    FRINTA  V28.8H, V3.8H
    FRINTX  V3.8H, V15.8H
    FCVTZS  V2.2S, V10.2S, #24
    FCVTAS  V15.8H, V23.8H
    FCVTZU  V11.4S, V2.4S
    FCVTZU  V9.4S, V11.4S
    FRINTI  V23.4H, V27.4H
    FCVTAU  V26.2S, V1.2S
    FCVTXN  V10.2S, V7.2D
    FCVTXN2  V11.4S, V25.2D
    FCVTZU  V16.8H, V23.8H, #15
    FCVTNU  V2.4H, V16.4H
    FRINTP  V6.8H, V2.8H
    FCVTMS  V16.4H, V15.4H
    FCVTZS  V25.8H, V16.8H, #7
    FCVTZS  V15.8H, V10.8H
    FCVTZS  V10.4H, V26.4H, #10
    FCVTZS  V2.4H, V18.4H, #9
    FRINTX  V27.4S, V24.4S
    FRINTI  V16.2S, V6.2S
    FCVTAS  V23.2S, V27.2S
    FCVTNU  V1.2S, V16.2S
    FCVTZU  V26.2S, V9.2S, #15
    FRINTM  V24.4H, V15.4H
    FRINTZ  V15.2D, V26.2D
    FRINTN  V26.8H, V28.8H
    FCVTZS V16.2D, V25.2D, #7
    FRINTI  V25.4S, V11.4S
    FCVTZU  V18.8H, V15.8H, #11
    FCVTMS  V6.2D, V18.2D
    FCVTZS V27.2D, V6.2D, #46
    FCVTPU  V6.8H, V10.8H
    FCVTZU  V18.8H, V23.8H
    FCVTNS  V28.2D, V1.2D
    FRINTP  V23.2S, V2.2S
    FCVTZS  V2.4H, V23.4H, #3
    FCVTZS  V23.8H, V2.8H, #11
    FRINTI  V9.8H, V27.8H
    FCVTPS  V7.8H, V16.8H
    FRINTA  V1.8H, V24.8H
    FCVTNS  V24.4S, V9.4S
    FCVTZU  V9.2S, V24.2S, #16
    FCVTMS  V30.2D, V7.2D
    FRINTP  V16.4S, V26.4S
    FRINTN  V27.4S, V18.4S
    FCVTL  V24.4S, V30.4H
    FCVTNU  V30.8H, V25.8H
    FCVTZU  V25.2S, V1.2S, #27
    FCVTZU  V15.4H, V9.4H, #12
    FRINTX  V1.8H, V4.8H
    FRINTM  V7.2D, V28.2D
    FCVTAS  V2.2D, V25.2D
    FRINTX  V26.4S, V23.4S
    FCVTMU  V9.2S, V7.2S
    FRINTZ  V18.4S, V24.4S
    FCVTZS  V11.4S, V2.4S
    FRINTZ  V4.2D, V6.2D
    FCVTZS  V28.2D, V18.2D
    FRINTM  V23.4H, V11.4H
    FRINTM  V7.4H, V27.4H
    FCVTN2  V24.8H, V26.4S
    FCVTNS  V25.4S, V24.4S
    FRINTA  V6.4S, V16.4S
    FCVTZS  V24.8H, V30.8H
    FCVTAS  V2.2S, V1.2S
    FCVTNU  V1.8H, V15.8H
    FCVTZS V15.2D, V6.2D, #28
    FCVTN  V19.2S, V15.2D
    FCVTN2  V30.8H, V23.4S
    FCVTZU  V26.4H, V19.4H
    FRINTX  V19.8H, V26.8H
    FCVTZU  V6.4H, V25.4H, #15
    FRINTM  V4.8H, V7.8H
    FCVTZS  V9.8H, V4.8H, #7
    FRINTI  V11.8H, V2.8H
    FRINTP  V16.4H, V19.4H
    FCVTXN  V26.2S, V11.2D
    FRINTI  V27.2S, V26.2S
    FCVTMS  V18.2S, V1.2S
    FCVTZU  V1.8H, V30.8H, #2
    FCVTN  V30.4H, V27.4S
    FRINTP  V25.2D, V30.2D
    FCVTN  V11.4H, V28.4S
    FCVTNU  V8.2S, V1.2S
    FRINTI  V12.8H, V11.8H
    FCVTZS  V26.4H, V6.4H, #15
    FCVTMS  V2.8H, V18.8H
    FCVTL2  V23.4S, V2.8H
    FCVTMU  V1.4H, V25.4H
    FCVTAS  V15.4S, V16.4S
    FCVTZS V27.2D, V8.2D, #42
    FCVTMS  V19.2S, V12.2S
    FRINTN  V4.8H, V26.8H
    FCVTMU  V30.4H, V23.4H
    FCVTZU  V18.2S, V15.2S, #12
    FRINTA  V15.4S, V19.4S
    FCVTZS V7.2D, V1.2D, #8
    FCVTZS  V28.4H, V7.4H
    FRINTI  V23.8H, V27.8H
    FCVTAS  V25.2D, V4.2D
    FRINTP  V12.8H, V25.8H
    FCVTNS  V7.8H, V23.8H
    FCVTN2  V26.4S, V9.2D
    FCVTZU V4.2D, V18.2D, #8
    FCVTZS  V2.4H, V28.4H, #7
    FCVTMS  V27.2D, V15.2D
    FRINTI  V25.8H, V12.8H
    FCVTAS  V28.2D, V30.2D
    FRINTI  V15.4S, V19.4S
    FCVTMU  V8.8H, V2.8H
    FCVTXN  V6.2S, V8.2D
    FCVTPU  V8.4S, V4.4S
    FCVTZS  V23.4S, V6.4S, #10
    FCVTZU V6.2D, V19.2D, #25
    FCVTZS  V16.8H, V6.8H
    FCVTAU  V9.8H, V27.8H
    FRINTA  V2.4H, V9.4H
    FCVTPS  V4.2D, V26.2D
    FRINTX  V18.2D, V2.2D
    FCVTAU  V27.8H, V8.8H
    FCVTNS  V8.2D, V28.2D
    FRINTA  V26.4H, V7.4H
    FCVTNU  V19.8H, V8.8H
    FRINTA  V12.2D, V26.2D
    FRINTM  V7.2D, V15.2D
    FCVTMU  V26.2D, V23.2D
    FCVTZU V15.2D, V19.2D, #5
    FCVTNS  V23.4H, V18.4H
    FRINTN  V19.4S, V16.4S
    FCVTAS  V9.4H, V23.4H
    FCVTMU  V6.4H, V27.4H
    FRINTP  V8.2D, V25.2D
    FCVTMU  V2.4S, V26.4S
    FCVTAS  V23.2S, V7.2S
    FRINTI  V18.2D, V6.2D
    FCVTL  V30.2D, V2.2S
    FCVTMS  V28.4S, V23.4S
    FCVTZU  V26.8H, V9.8H
    FCVTAU  V9.8H, V28.8H
    FCVTPU  V16.2D, V12.2D
    FRINTN  V7.8H, V19.8H
    FCVTMS  V19.2S, V18.2S
    FCVTZU V2.2D, V8.2D, #21
    FCVTZS  V18.2S, V15.2S, #8
    FRINTM  V6.4H, V2.4H
    FCVTN2  V28.8H, V9.4S
    SUBS  X15, X15, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_16
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x1d, LSL #0
    MRS  X2, FPSR
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V0.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D0
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V1.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D1
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V2.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D2
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V3.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D3
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V4.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D4
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V5.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D5
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V6.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D6
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V7.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D7
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V8.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D8
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V9.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D9
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V10.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D10
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V11.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D11
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V12.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D12
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V13.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D13
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V14.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D14
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V15.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D15
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V16.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D16
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V17.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D17
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V18.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D18
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V19.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D19
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V20.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D20
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V21.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D21
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V22.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D22
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V23.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D23
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V24.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D24
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V25.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D25
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V26.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D26
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V27.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D27
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V28.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D28
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V29.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D29
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V30.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D30
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, V31.D[1]
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X2, D31
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
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
    FMOV  V0.D[1], X28
    FMOV  D1, X24
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X29
    FMOV  D3, X21
    FMOV  V3.D[1], X20
    FMOV  D4, X29
    FMOV  V4.D[1], X23
    FMOV  D5, X7
    FMOV  V5.D[1], X9
    FMOV  D6, X6
    FMOV  V6.D[1], X6
    FMOV  D7, X27
    FMOV  V7.D[1], X29
    FMOV  D8, X7
    FMOV  V8.D[1], X7
    FMOV  D9, X10
    FMOV  V9.D[1], X27
    FMOV  D10, X27
    FMOV  V10.D[1], X21
    FMOV  D11, X26
    FMOV  V11.D[1], X9
    FMOV  D12, X6
    FMOV  V12.D[1], X20
    FMOV  D13, X16
    FMOV  V13.D[1], X29
    FMOV  D14, X28
    FMOV  V14.D[1], X9
    FMOV  D15, X20
    FMOV  V15.D[1], X29
    FMOV  D16, X19
    FMOV  V16.D[1], X11
    FMOV  D17, X15
    FMOV  V17.D[1], X10
    FMOV  D18, X24
    FMOV  V18.D[1], X6
    FMOV  D19, X13
    FMOV  V19.D[1], X25
    FMOV  D20, X26
    FMOV  V20.D[1], X9
    FMOV  D21, X8
    FMOV  V21.D[1], X25
    FMOV  D22, X8
    FMOV  V22.D[1], X29
    FMOV  D23, X2
    FMOV  V23.D[1], X13
    FMOV  D24, X16
    FMOV  V24.D[1], X22
    FMOV  D25, X23
    FMOV  V25.D[1], X11
    FMOV  D26, X26
    FMOV  V26.D[1], X3
    FMOV  D27, X9
    FMOV  V27.D[1], X11
    FMOV  D28, X13
    FMOV  V28.D[1], X13
    FMOV  D29, X2
    FMOV  V29.D[1], X2
    FMOV  D30, X10
    FMOV  V30.D[1], X3
    FMOV  D31, X17
    FMOV  V31.D[1], X16
    MOVZ  X20, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_17:
    FRINTA  V13.4S, V22.4S
    FCVTNS  V8.2D, V29.2D
    FRINTA  V13.4S, V31.4S
    FCVTAS  V16.2S, V24.2S
    FCVTZS  V7.8H, V30.8H
    FRINTI  V10.2S, V28.2S
    FCVTNU  V9.2S, V20.2S
    FCVTN  V2.2S, V9.2D
    FCVTNS  V28.8H, V7.8H
    FCVTAS  V11.4S, V8.4S
    FRINTA  V15.2D, V2.2D
    FRINTP  V25.4S, V15.4S
    FRINTI  V29.2D, V27.2D
    FCVTNU  V6.8H, V16.8H
    FCVTNS  V25.4H, V25.4H
    FCVTZS  V8.8H, V6.8H
    FCVTNS  V2.8H, V26.8H
    FRINTN  V8.8H, V10.8H
    FCVTXN  V14.2S, V13.2D
    FRINTP  V16.4S, V28.4S
    FRINTN  V13.4H, V14.4H
    FCVTMU  V3.4S, V0.4S
    FCVTAU  V26.4H, V16.4H
    FCVTNS  V9.8H, V8.8H
    FCVTXN2  V28.4S, V29.2D
    FCVTZS  V14.8H, V21.8H, #12
    FRINTA  V0.4H, V11.4H
    FCVTMU  V15.2D, V9.2D
    FCVTAU  V11.8H, V25.8H
    FCVTZS V16.2D, V3.2D, #36
    FCVTZS  V27.8H, V28.8H
    FCVTNS  V21.2S, V26.2S
    FRINTA  V3.8H, V13.8H
    FRINTN  V7.4S, V2.4S
    FCVTNS  V9.4S, V7.4S
    FCVTMU  V25.4S, V3.4S
    FCVTZS V8.2D, V14.2D, #29
    FCVTPU  V2.4H, V27.4H
    FRINTZ  V27.4H, V16.4H
    FCVTN2  V7.8H, V0.4S
    FRINTN  V29.2S, V8.2S
    FRINTX  V3.2S, V25.2S
    FCVTAS  V14.4H, V21.4H
    FCVTNS  V28.4H, V22.4H
    FCVTN2  V13.8H, V9.4S
    FCVTZU  V25.2S, V7.2S
    FCVTZU  V8.4H, V29.4H
    FRINTA  V29.2S, V11.2S
    FCVTZS  V21.4H, V27.4H
    FCVTZU  V27.2S, V21.2S
    FCVTMU  V21.4H, V14.4H
    FCVTMU  V22.8H, V13.8H
    FCVTPU  V7.2S, V29.2S
    FCVTAS  V13.2D, V15.2D
    FCVTZS  V0.8H, V22.8H, #12
    FCVTMS  V22.2D, V21.2D
    FRINTX  V14.8H, V13.8H
    FCVTAU  V16.4H, V28.4H
    FRINTA  V11.2S, V7.2S
    FCVTNU  V28.2S, V11.2S
    FCVTPS  V9.2D, V3.2D
    FCVTNU  V7.4S, V14.4S
    FCVTAS  V29.2D, V0.2D
    FCVTL2  V0.4S, V2.8H
    FCVTMU  V15.2S, V8.2S
    FCVTMS  V21.8H, V15.8H
    FCVTMS  V13.8H, V7.8H
    FCVTZU  V3.2S, V27.2S
    FCVTZS  V11.4S, V13.4S
    FRINTZ  V8.4H, V16.4H
    FCVTNU  V7.4S, V21.4S
    FRINTN  V16.2S, V9.2S
    FCVTL  V2.2D, V3.2S
    FRINTN  V14.4H, V11.4H
    FCVTZU  V31.8H, V22.8H
    FCVTZS V13.2D, V31.2D, #17
    FCVTMU  V3.4H, V13.4H
    FRINTM  V0.4H, V14.4H
    FCVTAS  V9.2D, V7.2D
    FCVTZS V13.2D, V8.2D, #23
    FCVTMU  V21.8H, V3.8H
    FCVTZS  V27.4S, V0.4S, #32
    FRINTN  V1.4H, V9.4H
    FRINTZ  V8.2D, V28.2D
    FCVTXN2  V28.4S, V2.2D
    FCVTL  V11.4S, V13.4H
    FCVTAS  V31.2D, V21.2D
    FCVTZS  V21.4H, V16.4H, #12
    FCVTN  V14.4H, V21.4S
    FCVTMS  V0.2D, V31.2D
    FRINTI  V22.8H, V11.8H
    FRINTP  V21.4H, V22.4H
    FCVTPS  V9.2D, V1.2D
    FCVTAS  V2.4H, V0.4H
    FCVTMU  V3.8H, V21.8H
    FRINTN  V7.4S, V28.4S
    FRINTX  V22.8H, V27.8H
    FCVTXN  V13.2S, V2.2D
    FRINTN  V4.2D, V16.2D
    FCVTXN2  V31.4S, V22.2D
    FCVTAS  V22.8H, V14.8H
    FCVTMS  V14.8H, V8.8H
    FCVTN  V11.4H, V31.4S
    FRINTZ  V1.4S, V14.4S
    FRINTN  V0.2D, V7.2D
    FCVTZS  V27.4H, V0.4H
    FRINTI  V0.4H, V5.4H
    FRINTX  V28.2S, V3.2S
    FRINTN  V2.4H, V9.4H
    FCVTPU  V7.4S, V1.4S
    FRINTA  V16.8H, V2.8H
    FRINTX  V7.8H, V27.8H
    FCVTMU  V31.4S, V11.4S
    FCVTZS V14.2D, V4.2D, #47
    FRINTM  V5.8H, V22.8H
    FCVTXN2  V27.4S, V0.2D
    FCVTPS  V22.2S, V16.2S
    FCVTN2  V16.8H, V27.4S
    FCVTMS  V2.8H, V16.8H
    FCVTZS V0.2D, V31.2D, #61
    FCVTPU  V21.2S, V0.2S
    FRINTZ  V4.4H, V7.4H
    FCVTPU  V16.8H, V4.8H
    FRINTN  V31.2S, V5.2S
    FCVTZU  V5.2S, V28.2S, #15
    FRINTM  V8.4S, V21.4S
    FRINTA  V21.2S, V8.2S
    FRINTX  V3.4H, V14.4H
    FCVTXN  V7.2S, V31.2D
    FCVTPS  V11.2D, V22.2D
    FCVTNU  V22.8H, V7.8H
    FCVTZU  V7.2D, V2.2D
    FCVTNS  V31.4H, V21.4H
    FRINTX  V4.2S, V22.2S
    FCVTN2  V2.4S, V4.2D
    FCVTZS V0.2D, V3.2D, #9
    FCVTNS  V27.2D, V11.2D
    FCVTL  V21.2D, V5.2S
    FCVTMS  V22.2S, V16.2S
    FCVTN2  V14.4S, V27.2D
    FCVTMS  V16.8H, V31.8H
    FRINTM  V19.2D, V21.2D
    FCVTMU  V4.2S, V19.2S
    FCVTMU  V8.2D, V14.2D
    FRINTM  V5.2D, V4.2D
    FCVTAS  V4.4H, V8.4H
    FCVTAS  V3.4S, V23.4S
    FCVTL  V8.4S, V5.4H
    FCVTNS  V11.4S, V7.4S
    FCVTPS  V14.8H, V0.8H
    FCVTPU  V21.4H, V4.4H
    FRINTN  V0.4H, V8.4H
    FCVTPU  V5.8H, V14.8H
    FCVTZU  V14.2D, V16.2D
    FCVTNS  V4.2S, V11.2S
    FRINTA  V11.4H, V22.4H
    FCVTZU  V27.4H, V11.4H, #7
    FCVTNS  V7.8H, V14.8H
    FCVTMS  V16.8H, V0.8H
    FCVTNU  V23.2D, V7.2D
    FCVTXN2  V31.4S, V3.2D
    FCVTZU  V7.8H, V23.8H
    FRINTI  V19.2D, V31.2D
    FCVTMU  V8.2S, V21.2S
    FCVTN  V22.2S, V19.2D
    FCVTZS  V21.4H, V8.4H, #8
    FCVTZS V11.2D, V3.2D, #50
    FCVTZU  V31.4H, V11.4H
    FCVTMU  V8.2S, V27.2S
    FCVTL  V27.4S, V5.4H
    FRINTA  V23.8H, V4.8H
    FCVTNS  V0.4H, V31.4H
    FRINTP  V14.2D, V7.2D
    FCVTZS V19.2D, V14.2D, #15
    FCVTZU  V4.2D, V8.2D
    FCVTMS  V14.4S, V4.4S
    FCVTNS  V29.4H, V22.4H
    FCVTZU  V8.8H, V11.8H, #7
    FRINTA  V3.2D, V21.2D
    FRINTN  V4.2S, V8.2S
    FRINTX  V22.4H, V29.4H
    FCVTNS  V7.8H, V14.8H
    FCVTZS V11.2D, V27.2D, #12
    FRINTI  V31.8H, V16.8H
    FCVTL2  V29.2D, V3.4S
    FRINTA  V16.4H, V4.4H
    FRINTX  V27.2D, V11.2D
    FRINTP  V14.2S, V19.2S
    FRINTX  V19.2S, V23.2S
    FCVTAS  V21.4S, V19.4S
    FCVTPU  V3.2S, V7.2S
    FRINTZ  V4.4H, V21.4H
    FCVTPS  V8.2S, V29.2S
    FCVTZS  V11.4S, V0.4S, #20
    FRINTZ  V23.8H, V7.8H
    FCVTMU  V19.2D, V8.2D
    FCVTAS  V21.2S, V3.2S
    FCVTMU  V8.8H, V14.8H
    FCVTNS  V29.4H, V27.4H
    FRINTA  V0.4S, V29.4S
    SUBS  X20, X20, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_17
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X27, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X27, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x1d, LSL #0
    MRS  X27, FPSR
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, V0.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, D0
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, V1.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, D1
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, V2.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, D2
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, V3.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, D3
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, V4.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, D4
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, V5.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, D5
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, V6.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, D6
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, V7.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, D7
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, V8.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, D8
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, V9.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, D9
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, V10.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, D10
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, V11.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, D11
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X27, V12.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X27, D12
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, V13.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, D13
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, V14.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, D14
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, V15.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, D15
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, V16.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, D16
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X27, V17.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X27, D17
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X27, V18.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X27, D18
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, V19.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, D19
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X27, V20.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X27, D20
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, V21.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, D21
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, V22.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, D22
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, V23.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, D23
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X27, V24.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X27, D24
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, V25.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, D25
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, V26.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, D26
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, V27.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, D27
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, V28.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, D28
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, V29.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, D29
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X27, V30.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X27, D30
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, V31.D[1]
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X27, D31
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X2, #0x11fc, LSL #0
    MOVK  X2, #0xebdd, LSL #16
    MOVK  X2, #0xbc56, LSL #32
    MOVK  X2, #0xeb2f, LSL #48
    MOVZ  X3, #0x2807, LSL #0
    MOVK  X3, #0x3fe3, LSL #16
    MOVK  X3, #0x2e0, LSL #32
    MOVK  X3, #0xf4cd, LSL #48
    MOVZ  X6, #0x40dc, LSL #0
    MOVK  X6, #0x632f, LSL #16
    MOVK  X6, #0x7bc2, LSL #32
    MOVK  X6, #0x814e, LSL #48
    MOVZ  X7, #0x7a2f, LSL #0
    MOVK  X7, #0xe6f0, LSL #16
    MOVK  X7, #0xee71, LSL #32
    MOVK  X7, #0x70e1, LSL #48
    MOVZ  X8, #0x34ca, LSL #0
    MOVK  X8, #0x36c9, LSL #16
    MOVK  X8, #0x7c18, LSL #32
    MOVK  X8, #0x444f, LSL #48
    MOVZ  X9, #0xfbdc, LSL #0
    MOVK  X9, #0x562f, LSL #16
    MOVK  X9, #0x52f, LSL #32
    MOVK  X9, #0xb5b5, LSL #48
    MOVZ  X10, #0xa103, LSL #0
    MOVK  X10, #0x3cf1, LSL #16
    MOVK  X10, #0xb360, LSL #32
    MOVK  X10, #0xa4a5, LSL #48
    MOVZ  X11, #0xa448, LSL #0
    MOVK  X11, #0xcb9, LSL #16
    MOVK  X11, #0x3760, LSL #32
    MOVK  X11, #0x167f, LSL #48
    MOVZ  X13, #0xd1e1, LSL #0
    MOVK  X13, #0x74f4, LSL #16
    MOVK  X13, #0xe947, LSL #32
    MOVK  X13, #0x4d0c, LSL #48
    MOVZ  X14, #0x4f65, LSL #0
    MOVK  X14, #0xb0bd, LSL #16
    MOVK  X14, #0xa292, LSL #32
    MOVK  X14, #0x47aa, LSL #48
    MOVZ  X15, #0xa040, LSL #0
    MOVK  X15, #0x505f, LSL #16
    MOVK  X15, #0x55c2, LSL #32
    MOVK  X15, #0xf02c, LSL #48
    MOVZ  X16, #0x9fa4, LSL #0
    MOVK  X16, #0xd0aa, LSL #16
    MOVK  X16, #0x5a59, LSL #32
    MOVK  X16, #0x77e1, LSL #48
    MOVZ  X17, #0x2b41, LSL #0
    MOVK  X17, #0xd7f7, LSL #16
    MOVK  X17, #0xc2b, LSL #32
    MOVK  X17, #0xfe2e, LSL #48
    MOVZ  X19, #0x69b3, LSL #0
    MOVK  X19, #0x8d0f, LSL #16
    MOVK  X19, #0xb289, LSL #32
    MOVK  X19, #0x12e4, LSL #48
    MOVZ  X20, #0x616, LSL #0
    MOVK  X20, #0xa64, LSL #16
    MOVK  X20, #0x9dc8, LSL #32
    MOVK  X20, #0xefd5, LSL #48
    MOVZ  X21, #0x5aaf, LSL #0
    MOVK  X21, #0xf513, LSL #16
    MOVK  X21, #0x9778, LSL #32
    MOVK  X21, #0xfd3c, LSL #48
    MOVZ  X22, #0x2284, LSL #0
    MOVK  X22, #0xe125, LSL #16
    MOVK  X22, #0xfdcf, LSL #32
    MOVK  X22, #0x139b, LSL #48
    MOVZ  X23, #0x9e09, LSL #0
    MOVK  X23, #0xa7bc, LSL #16
    MOVK  X23, #0x4fc1, LSL #32
    MOVK  X23, #0xa61d, LSL #48
    MOVZ  X24, #0xe73c, LSL #0
    MOVK  X24, #0xed2a, LSL #16
    MOVK  X24, #0xcd6, LSL #32
    MOVK  X24, #0xf2ec, LSL #48
    MOVZ  X25, #0xcea3, LSL #0
    MOVK  X25, #0x6b01, LSL #16
    MOVK  X25, #0x3cad, LSL #32
    MOVK  X25, #0x482b, LSL #48
    MOVZ  X26, #0x8f77, LSL #0
    MOVK  X26, #0x6dda, LSL #16
    MOVK  X26, #0xbe43, LSL #32
    MOVK  X26, #0xa66c, LSL #48
    MOVZ  X27, #0x1b25, LSL #0
    MOVK  X27, #0x88af, LSL #16
    MOVK  X27, #0x7a89, LSL #32
    MOVK  X27, #0xb280, LSL #48
    MOVZ  X28, #0x4e39, LSL #0
    MOVK  X28, #0x89d3, LSL #16
    MOVK  X28, #0x7e7a, LSL #32
    MOVK  X28, #0xf5f4, LSL #48
    MOVZ  X29, #0x6356, LSL #0
    MOVK  X29, #0x9f08, LSL #16
    MOVK  X29, #0x1f7d, LSL #32
    MOVK  X29, #0xaf7e, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X27
    FMOV  D1, X28
    FMOV  V1.D[1], X26
    FMOV  D2, X20
    FMOV  V2.D[1], X15
    FMOV  D3, X26
    FMOV  V3.D[1], X24
    FMOV  D4, X14
    FMOV  V4.D[1], X7
    FMOV  D5, X10
    FMOV  V5.D[1], X27
    FMOV  D6, X28
    FMOV  V6.D[1], X26
    FMOV  D7, X24
    FMOV  V7.D[1], X24
    FMOV  D8, X29
    FMOV  V8.D[1], X22
    FMOV  D9, X8
    FMOV  V9.D[1], X27
    FMOV  D10, X17
    FMOV  V10.D[1], X2
    FMOV  D11, X6
    FMOV  V11.D[1], X25
    FMOV  D12, X17
    FMOV  V12.D[1], X17
    FMOV  D13, X23
    FMOV  V13.D[1], X22
    FMOV  D14, X29
    FMOV  V14.D[1], X15
    FMOV  D15, X23
    FMOV  V15.D[1], X2
    FMOV  D16, X9
    FMOV  V16.D[1], X20
    FMOV  D17, X17
    FMOV  V17.D[1], X3
    FMOV  D18, X16
    FMOV  V18.D[1], X6
    FMOV  D19, X7
    FMOV  V19.D[1], X13
    FMOV  D20, X3
    FMOV  V20.D[1], X26
    FMOV  D21, X16
    FMOV  V21.D[1], X19
    FMOV  D22, X13
    FMOV  V22.D[1], X9
    FMOV  D23, X11
    FMOV  V23.D[1], X11
    FMOV  D24, X17
    FMOV  V24.D[1], X15
    FMOV  D25, X19
    FMOV  V25.D[1], X11
    FMOV  D26, X24
    FMOV  V26.D[1], X19
    FMOV  D27, X28
    FMOV  V27.D[1], X28
    FMOV  D28, X27
    FMOV  V28.D[1], X24
    FMOV  D29, X26
    FMOV  V29.D[1], X6
    FMOV  D30, X16
    FMOV  V30.D[1], X22
    FMOV  D31, X20
    FMOV  V31.D[1], X8
    MOVZ  X26, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_18:
    FRINTN  V29.4S, V24.4S
    FRINTM  V20.4H, V29.4H
    FCVTPS  V22.8H, V25.8H
    FCVTAS  V29.2D, V30.2D
    FCVTZS  V31.8H, V28.8H, #14
    FRINTN  V13.8H, V29.8H
    FRINTA  V11.4H, V27.4H
    FCVTXN  V13.2S, V26.2D
    FCVTNU  V1.8H, V13.8H
    FCVTAS  V28.4S, V11.4S
    FCVTPS  V30.4H, V22.4H
    FCVTAU  V20.8H, V23.8H
    FRINTX  V30.8H, V20.8H
    FRINTP  V8.8H, V28.8H
    FCVTZS  V24.4S, V1.4S, #29
    FCVTAS  V27.4S, V8.4S
    FCVTPS  V20.4H, V24.4H
    FCVTZU  V4.8H, V9.8H, #4
    FRINTN  V15.2S, V27.2S
    FCVTXN2  V7.4S, V31.2D
    FCVTMS  V20.2S, V30.2S
    FCVTZS  V29.4S, V12.4S, #13
    FCVTXN2  V13.4S, V28.2D
    FCVTZU V11.2D, V4.2D, #51
    FCVTZS  V26.8H, V15.8H, #8
    FCVTPS  V15.4H, V7.4H
    FRINTA  V30.8H, V15.8H
    FCVTNU  V7.4S, V13.4S
    FCVTAS  V1.2S, V11.2S
    FCVTL2  V22.4S, V29.8H
    FRINTX  V9.4H, V26.4H
    FRINTI  V8.8H, V20.8H
    FRINTZ  V4.4H, V1.4H
    FRINTM  V29.8H, V4.8H
    FCVTAU  V15.2S, V22.2S
    FCVTZU  V13.4S, V30.4S, #15
    FCVTL2  V23.4S, V7.8H
    FCVTPS  V20.2S, V8.2S
    FCVTNU  V4.2D, V2.2D
    FCVTNU  V8.8H, V9.8H
    FCVTAU  V2.8H, V29.8H
    FRINTI  V28.8H, V15.8H
    FRINTA  V26.4H, V13.4H
    FCVTAS  V29.8H, V23.8H
    FCVTZU  V22.8H, V28.8H, #13
    FRINTA  V15.4S, V20.4S
    FRINTA  V13.4H, V22.4H
    FCVTNS  V12.2D, V26.2D
    FCVTAS  V31.2S, V4.2S
    FCVTNS  V23.8H, V8.8H
    FCVTZS V11.2D, V17.2D, #63
    FCVTZS V17.2D, V15.2D, #16
    FCVTNU  V15.2S, V29.2S
    FCVTNU  V9.8H, V23.8H
    FRINTM  V1.4H, V15.4H
    FRINTN  V4.4S, V13.4S
    FRINTM  V28.2D, V11.2D
    FRINTX  V26.4S, V15.4S
    FCVTZS  V7.4S, V1.4S
    FRINTM  V20.8H, V4.8H
    FCVTAS  V1.4H, V17.4H
    FCVTZU  V30.4S, V9.4S, #3
    FCVTXN2  V29.4S, V12.2D
    FCVTNS  V23.8H, V31.8H
    FCVTAU  V12.4S, V29.4S
    FCVTNU  V4.4H, V30.4H
    FRINTZ  V8.2S, V28.2S
    FCVTZU  V9.2S, V8.2S
    FCVTXN2  V30.4S, V23.2D
    FCVTMU  V29.4H, V30.4H
    FCVTNS  V17.8H, V26.8H
    FRINTX  V23.8H, V12.8H
    FCVTZS  V13.4S, V9.4S
    FCVTZS  V12.4S, V1.4S
    FRINTN  V9.2D, V20.2D
    FCVTZU  V31.8H, V12.8H, #4
    FCVTXN  V22.2S, V9.2D
    FCVTAS  V30.8H, V13.8H
    FRINTN  V9.8H, V15.8H
    FCVTMS  V13.8H, V9.8H
    FCVTAU  V28.4S, V22.4S
    FRINTZ  V12.4H, V17.4H
    FCVTZU  V15.2S, V31.2S
    FCVTZU V17.2D, V23.2D, #36
    FCVTZS  V8.8H, V4.8H, #11
    FCVTAU  V26.4H, V29.4H
    FCVTZS  V9.4H, V12.4H
    FCVTZS V22.2D, V15.2D, #31
    FCVTPU  V4.8H, V28.8H
    FCVTAU  V29.4S, V9.4S
    FCVTAU  V20.2D, V4.2D
    FCVTPU  V9.4H, V13.4H
    FCVTPS  V13.4H, V8.4H
    FCVTMS  V31.2S, V30.2S
    FCVTMS  V28.8H, V9.8H
    FCVTL2  V23.4S, V28.8H
    FRINTZ  V28.8H, V13.8H
    FRINTM  V12.4S, V26.4S
    FRINTA  V1.2S, V28.2S
    FCVTMU  V15.8H, V29.8H
    FCVTPU  V1.8H, V23.8H
    FRINTX  V8.4H, V26.4H
    FCVTN2  V9.4S, V11.2D
    FCVTXN2  V11.4S, V9.2D
    FCVTL2  V26.4S, V12.8H
    FRINTI  V9.8H, V11.8H
    FRINTA  V4.4S, V15.4S
    FRINTI  V15.2S, V26.2S
    FCVTL2  V23.2D, V1.4S
    FRINTX  V13.4H, V20.4H
    FRINTZ  V26.2D, V4.2D
    FRINTM  V20.8H, V15.8H
    FCVTZU V12.2D, V31.2D, #15
    FCVTAS  V31.8H, V26.8H
    FRINTX  V30.8H, V31.8H
    FCVTMU  V4.2D, V30.2D
    FRINTN  V15.2D, V8.2D
    FCVTMU  V1.2S, V22.2S
    FRINTA  V29.2S, V1.2S
    FCVTXN  V11.2S, V4.2D
    FCVTZS V8.2D, V20.2D, #46
    FCVTPS  V31.2S, V8.2S
    FCVTNS  V22.2S, V11.2S
    FCVTZS  V1.8H, V22.8H
    FRINTN  V26.2S, V21.2S
    FRINTI  V4.8H, V26.8H
    FCVTZU V22.2D, V1.2D, #53
    FRINTN  V20.8H, V22.8H
    FCVTPS  V21.4S, V20.4S
    FCVTPS  V26.8H, V21.8H
    FRINTN  V22.4S, V12.4S
    FCVTAS  V8.2S, V23.2S
    FRINTX  V30.2D, V26.2D
    FCVTZU  V12.8H, V29.8H
    FCVTZS  V21.2D, V4.2D
    FCVTN  V23.2S, V21.2D
    FCVTPU  V4.2S, V13.2S
    FRINTA  V21.8H, V22.8H
    FCVTZS  V26.4H, V4.4H, #6
    FCVTZS V24.2D, V8.2D, #37
    FCVTZS V13.2D, V26.2D, #30
    FCVTPU  V26.4H, V30.4H
    FCVTN2  V4.8H, V13.4S
    FCVTZS  V13.4S, V12.4S
    FCVTZS  V12.8H, V13.8H
    FRINTI  V29.4S, V21.4S
    FCVTAS  V20.4H, V29.4H
    FRINTX  V22.8H, V12.8H
    FRINTA  V21.2S, V24.2S
    FCVTMS  V11.2D, V20.2D
    FCVTAS  V13.2S, V23.2S
    FCVTN2  V30.4S, V26.2D
    FCVTZS  V8.4S, V8.4S, #2
    FRINTN  V24.2D, V4.2D
    FRINTM  V29.8H, V30.8H
    FRINTI  V4.2S, V24.2S
    FCVTXN  V24.2S, V22.2D
    FCVTPS  V22.4H, V21.4H
    FCVTZU  V26.4H, V22.4H, #13
    FCVTN  V22.2S, V26.2D
    FCVTPS  V12.2D, V24.2D
    FRINTP  V26.4H, V29.4H
    FCVTAS  V30.2D, V16.2D
    FCVTPU  V9.8H, V22.8H
    FCVTZS  V21.4S, V12.4S, #11
    FRINTA  V12.4H, V26.4H
    FCVTPS  V23.4S, V9.4S
    FCVTPS  V24.2S, V8.2S
    FCVTZS  V8.4H, V21.4H
    FCVTXN2  V29.4S, V2.2D
    FCVTNS  V2.4H, V29.4H
    FCVTNS  V20.4S, V4.4S
    FRINTN  V4.4S, V30.4S
    FCVTAU  V22.2D, V11.2D
    FRINTA  V9.4H, V4.4H
    FCVTMU  V26.8H, V13.8H
    FCVTMS  V16.4S, V26.4S
    FCVTMU  V4.8H, V24.8H
    FRINTX  V21.2S, V8.2S
    FRINTP  V8.2D, V12.2D
    FRINTI  V30.4H, V23.4H
    FCVTMS  V11.4H, V8.4H
    FCVTL  V29.2D, V29.2S
    FCVTL  V8.2D, V21.2S
    FRINTA  V24.8H, V2.8H
    FRINTN  V2.4H, V8.4H
    FRINTP  V8.4H, V16.4H
    FCVTXN  V16.2S, V8.2D
    FCVTAU  V8.2S, V24.2S
    FRINTP  V21.4S, V20.4S
    FCVTAS  V26.2D, V21.2D
    FCVTPS  V12.2S, V8.2S
    FRINTX  V20.8H, V22.8H
    FCVTPS  V23.4H, V26.4H
    FCVTZU  V24.8H, V30.8H
    FCVTZU  V26.2S, V24.2S, #8
    FRINTI  V8.4S, V20.4S
    FCVTAU  V24.2D, V16.2D
    FCVTN2  V20.4S, V23.2D
    FRINTN  V16.8H, V29.8H
    SUBS  X26, X26, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_18
    MOVZ  X6, #0x11fc, LSL #0
    MOVK  X6, #0xebdd, LSL #16
    MOVK  X6, #0xbc56, LSL #32
    MOVK  X6, #0xeb2f, LSL #48
    SUB  X16, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x2807, LSL #0
    MOVK  X6, #0x3fe3, LSL #16
    MOVK  X6, #0x2e0, LSL #32
    MOVK  X6, #0xf4cd, LSL #48
    SUB  X16, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x7a2f, LSL #0
    MOVK  X6, #0xe6f0, LSL #16
    MOVK  X6, #0xee71, LSL #32
    MOVK  X6, #0x70e1, LSL #48
    SUB  X16, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x34ca, LSL #0
    MOVK  X6, #0x36c9, LSL #16
    MOVK  X6, #0x7c18, LSL #32
    MOVK  X6, #0x444f, LSL #48
    SUB  X16, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0xa103, LSL #0
    MOVK  X6, #0x3cf1, LSL #16
    MOVK  X6, #0xb360, LSL #32
    MOVK  X6, #0xa4a5, LSL #48
    SUB  X16, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0xa448, LSL #0
    MOVK  X6, #0xcb9, LSL #16
    MOVK  X6, #0x3760, LSL #32
    MOVK  X6, #0x167f, LSL #48
    SUB  X16, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0xd1e1, LSL #0
    MOVK  X6, #0x74f4, LSL #16
    MOVK  X6, #0xe947, LSL #32
    MOVK  X6, #0x4d0c, LSL #48
    SUB  X16, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x4f65, LSL #0
    MOVK  X6, #0xb0bd, LSL #16
    MOVK  X6, #0xa292, LSL #32
    MOVK  X6, #0x47aa, LSL #48
    SUB  X16, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0xa040, LSL #0
    MOVK  X6, #0x505f, LSL #16
    MOVK  X6, #0x55c2, LSL #32
    MOVK  X6, #0xf02c, LSL #48
    SUB  X16, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x2b41, LSL #0
    MOVK  X6, #0xd7f7, LSL #16
    MOVK  X6, #0xc2b, LSL #32
    MOVK  X6, #0xfe2e, LSL #48
    SUB  X16, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x69b3, LSL #0
    MOVK  X6, #0x8d0f, LSL #16
    MOVK  X6, #0xb289, LSL #32
    MOVK  X6, #0x12e4, LSL #48
    SUB  X16, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x616, LSL #0
    MOVK  X6, #0xa64, LSL #16
    MOVK  X6, #0x9dc8, LSL #32
    MOVK  X6, #0xefd5, LSL #48
    SUB  X16, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x5aaf, LSL #0
    MOVK  X6, #0xf513, LSL #16
    MOVK  X6, #0x9778, LSL #32
    MOVK  X6, #0xfd3c, LSL #48
    SUB  X16, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x2284, LSL #0
    MOVK  X6, #0xe125, LSL #16
    MOVK  X6, #0xfdcf, LSL #32
    MOVK  X6, #0x139b, LSL #48
    SUB  X16, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x9e09, LSL #0
    MOVK  X6, #0xa7bc, LSL #16
    MOVK  X6, #0x4fc1, LSL #32
    MOVK  X6, #0xa61d, LSL #48
    SUB  X16, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0xe73c, LSL #0
    MOVK  X6, #0xed2a, LSL #16
    MOVK  X6, #0xcd6, LSL #32
    MOVK  X6, #0xf2ec, LSL #48
    SUB  X16, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0xcea3, LSL #0
    MOVK  X6, #0x6b01, LSL #16
    MOVK  X6, #0x3cad, LSL #32
    MOVK  X6, #0x482b, LSL #48
    SUB  X16, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x1b25, LSL #0
    MOVK  X6, #0x88af, LSL #16
    MOVK  X6, #0x7a89, LSL #32
    MOVK  X6, #0xb280, LSL #48
    SUB  X16, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x4e39, LSL #0
    MOVK  X6, #0x89d3, LSL #16
    MOVK  X6, #0x7e7a, LSL #32
    MOVK  X6, #0xf5f4, LSL #48
    SUB  X16, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x6356, LSL #0
    MOVK  X6, #0x9f08, LSL #16
    MOVK  X6, #0x1f7d, LSL #32
    MOVK  X6, #0xaf7e, LSL #48
    SUB  X16, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x1d, LSL #0
    MRS  X16, FPSR
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x1b25, LSL #0
    MOVK  X6, #0x88af, LSL #16
    MOVK  X6, #0x7a89, LSL #32
    MOVK  X6, #0xb280, LSL #48
    FMOV  X16, V0.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x6356, LSL #0
    MOVK  X6, #0x9f08, LSL #16
    MOVK  X6, #0x1f7d, LSL #32
    MOVK  X6, #0xaf7e, LSL #48
    FMOV  X16, D0
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V1.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D1
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V2.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D2
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0xe73c, LSL #0
    MOVK  X6, #0xed2a, LSL #16
    MOVK  X6, #0xcd6, LSL #32
    MOVK  X6, #0xf2ec, LSL #48
    FMOV  X16, V3.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x8f77, LSL #0
    MOVK  X6, #0x6dda, LSL #16
    MOVK  X6, #0xbe43, LSL #32
    MOVK  X6, #0xa66c, LSL #48
    FMOV  X16, D3
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V4.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D4
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x1b25, LSL #0
    MOVK  X6, #0x88af, LSL #16
    MOVK  X6, #0x7a89, LSL #32
    MOVK  X6, #0xb280, LSL #48
    FMOV  X16, V5.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0xa103, LSL #0
    MOVK  X6, #0x3cf1, LSL #16
    MOVK  X6, #0xb360, LSL #32
    MOVK  X6, #0xa4a5, LSL #48
    FMOV  X16, D5
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x8f77, LSL #0
    MOVK  X6, #0x6dda, LSL #16
    MOVK  X6, #0xbe43, LSL #32
    MOVK  X6, #0xa66c, LSL #48
    FMOV  X16, V6.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x4e39, LSL #0
    MOVK  X6, #0x89d3, LSL #16
    MOVK  X6, #0x7e7a, LSL #32
    MOVK  X6, #0xf5f4, LSL #48
    FMOV  X16, D6
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V7.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D7
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V8.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D8
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V9.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D9
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x11fc, LSL #0
    MOVK  X6, #0xebdd, LSL #16
    MOVK  X6, #0xbc56, LSL #32
    MOVK  X6, #0xeb2f, LSL #48
    FMOV  X16, V10.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x2b41, LSL #0
    MOVK  X6, #0xd7f7, LSL #16
    MOVK  X6, #0xc2b, LSL #32
    MOVK  X6, #0xfe2e, LSL #48
    FMOV  X16, D10
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V11.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D11
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V12.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D12
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V13.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D13
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0xa040, LSL #0
    MOVK  X6, #0x505f, LSL #16
    MOVK  X6, #0x55c2, LSL #32
    MOVK  X6, #0xf02c, LSL #48
    FMOV  X16, V14.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x6356, LSL #0
    MOVK  X6, #0x9f08, LSL #16
    MOVK  X6, #0x1f7d, LSL #32
    MOVK  X6, #0xaf7e, LSL #48
    FMOV  X16, D14
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V15.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D15
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V16.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D16
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V17.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D17
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x40dc, LSL #0
    MOVK  X6, #0x632f, LSL #16
    MOVK  X6, #0x7bc2, LSL #32
    MOVK  X6, #0x814e, LSL #48
    FMOV  X16, V18.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x9fa4, LSL #0
    MOVK  X6, #0xd0aa, LSL #16
    MOVK  X6, #0x5a59, LSL #32
    MOVK  X6, #0x77e1, LSL #48
    FMOV  X16, D18
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0xd1e1, LSL #0
    MOVK  X6, #0x74f4, LSL #16
    MOVK  X6, #0xe947, LSL #32
    MOVK  X6, #0x4d0c, LSL #48
    FMOV  X16, V19.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x7a2f, LSL #0
    MOVK  X6, #0xe6f0, LSL #16
    MOVK  X6, #0xee71, LSL #32
    MOVK  X6, #0x70e1, LSL #48
    FMOV  X16, D19
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V20.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D20
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V21.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D21
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V22.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D22
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V23.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D23
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V24.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D24
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0xa448, LSL #0
    MOVK  X6, #0xcb9, LSL #16
    MOVK  X6, #0x3760, LSL #32
    MOVK  X6, #0x167f, LSL #48
    FMOV  X16, V25.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x69b3, LSL #0
    MOVK  X6, #0x8d0f, LSL #16
    MOVK  X6, #0xb289, LSL #32
    MOVK  X6, #0x12e4, LSL #48
    FMOV  X16, D25
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V26.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D26
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V27.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D27
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V28.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D28
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V29.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D29
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V30.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D30
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, V31.D[1]
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X16, D31
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
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
    FMOV  D0, X9
    FMOV  V0.D[1], X13
    FMOV  D1, X29
    FMOV  V1.D[1], X25
    FMOV  D2, X14
    FMOV  V2.D[1], X23
    FMOV  D3, X27
    FMOV  V3.D[1], X22
    FMOV  D4, X21
    FMOV  V4.D[1], X26
    FMOV  D5, X20
    FMOV  V5.D[1], X28
    FMOV  D6, X24
    FMOV  V6.D[1], X3
    FMOV  D7, X21
    FMOV  V7.D[1], X26
    FMOV  D8, X27
    FMOV  V8.D[1], X9
    FMOV  D9, X10
    FMOV  V9.D[1], X16
    FMOV  D10, X24
    FMOV  V10.D[1], X20
    FMOV  D11, X23
    FMOV  V11.D[1], X26
    FMOV  D12, X26
    FMOV  V12.D[1], X8
    FMOV  D13, X28
    FMOV  V13.D[1], X21
    FMOV  D14, X23
    FMOV  V14.D[1], X6
    FMOV  D15, X7
    FMOV  V15.D[1], X14
    FMOV  D16, X29
    FMOV  V16.D[1], X23
    FMOV  D17, X29
    FMOV  V17.D[1], X16
    FMOV  D18, X24
    FMOV  V18.D[1], X17
    FMOV  D19, X26
    FMOV  V19.D[1], X27
    FMOV  D20, X23
    FMOV  V20.D[1], X2
    FMOV  D21, X13
    FMOV  V21.D[1], X29
    FMOV  D22, X16
    FMOV  V22.D[1], X13
    FMOV  D23, X22
    FMOV  V23.D[1], X20
    FMOV  D24, X25
    FMOV  V24.D[1], X17
    FMOV  D25, X28
    FMOV  V25.D[1], X29
    FMOV  D26, X19
    FMOV  V26.D[1], X14
    FMOV  D27, X22
    FMOV  V27.D[1], X27
    FMOV  D28, X2
    FMOV  V28.D[1], X15
    FMOV  D29, X28
    FMOV  V29.D[1], X22
    FMOV  D30, X14
    FMOV  V30.D[1], X25
    FMOV  D31, X11
    FMOV  V31.D[1], X6
    MOVZ  X14, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_19:
    FRINTI  V3.8H, V31.8H
    FCVTNU  V11.4S, V25.4S
    FCVTZU  V24.8H, V23.8H
    FCVTMU  V28.2D, V28.2D
    FCVTN2  V8.4S, V30.2D
    FCVTPU  V22.4S, V27.4S
    FRINTI  V4.8H, V20.8H
    FCVTN2  V14.8H, V26.4S
    FCVTPS  V27.4H, V11.4H
    FCVTZS  V29.2S, V26.2S, #9
    FRINTP  V11.4S, V3.4S
    FCVTZS V1.2D, V4.2D, #22
    FRINTM  V13.2D, V27.2D
    FCVTAS  V24.2S, V29.2S
    FCVTMU  V29.4S, V1.4S
    FRINTZ  V23.4H, V11.4H
    FRINTP  V8.8H, V13.8H
    FCVTPS  V14.8H, V14.8H
    FCVTZU  V8.8H, V24.8H
    FCVTPU  V30.2D, V8.2D
    FRINTX  V7.4H, V23.4H
    FCVTNS  V1.2D, V29.2D
    FCVTZU  V30.8H, V28.8H, #6
    FCVTMS  V14.4H, V22.4H
    FCVTAU  V26.2S, V7.2S
    FCVTZU V23.2D, V14.2D, #42
    FRINTN  V20.2D, V23.2D
    FCVTPU  V25.8H, V20.8H
    FCVTZU  V3.8H, V17.8H
    FCVTAS  V17.4H, V3.4H
    FCVTZU V27.2D, V1.2D, #8
    FRINTN  V24.4H, V25.4H
    FCVTNS  V7.8H, V26.8H
    FCVTMS  V3.8H, V24.8H
    FCVTZS  V20.8H, V7.8H, #6
    FRINTP  V14.2S, V20.2S
    FRINTX  V8.2D, V15.2D
    FRINTZ  V23.4H, V17.4H
    FCVTMS  V4.8H, V14.8H
    FCVTZU  V29.8H, V8.8H, #14
    FCVTZU  V8.4H, V23.4H
    FRINTZ  V1.2D, V8.2D
    FCVTZU  V25.4S, V29.4S, #1
    FCVTZU  V17.4H, V27.4H
    FCVTPS  V23.8H, V30.8H
    FCVTZU  V8.2S, V4.2S
    FCVTZU  V14.2S, V3.2S, #6
    FCVTZS  V29.8H, V14.8H, #14
    FCVTMU  V14.2S, V8.2S
    FCVTZS  V27.4H, V23.4H
    FCVTNS  V28.2D, V27.2D
    FRINTX  V7.4H, V17.4H
    FRINTP  V8.2D, V1.2D
    FCVTL2  V24.2D, V28.4S
    FRINTA  V1.4S, V24.4S
    FCVTZS V4.2D, V8.2D, #5
    FRINTP  V24.2S, V7.2S
    FRINTA  V20.2D, V4.2D
    FCVTPS  V30.2S, V29.2S
    FCVTNU  V26.2S, V25.2S
    FCVTAS  V3.2S, V24.2S
    FCVTXN2  V15.4S, V30.2D
    FCVTZU V7.2D, V14.2D, #60
    FRINTP  V17.8H, V15.8H
    FCVTXN2  V30.4S, V1.2D
    FRINTX  V24.2D, V3.2D
    FCVTZS  V29.4S, V21.4S
    FCVTNU  V4.4S, V20.4S
    FRINTM  V25.8H, V24.8H
    FRINTI  V8.4S, V26.4S
    FCVTNS  V28.4H, V7.4H
    FRINTM  V14.2S, V4.2S
    FCVTPU  V26.2S, V28.2S
    FCVTXN  V20.2S, V26.2D
    FRINTX  V1.4H, V17.4H
    FCVTL2  V26.4S, V12.8H
    FRINTI  V12.4S, V25.4S
    FCVTNS  V24.8H, V30.8H
    FCVTMS  V21.8H, V12.8H
    FRINTP  V3.2S, V24.2S
    FCVTMS  V27.4S, V19.4S
    FCVTZS  V7.4S, V14.4S, #24
    FCVTZU  V19.4H, V6.4H, #14
    FRINTA  V15.4S, V26.4S
    FCVTZU V12.2D, V29.2D, #43
    FCVTNS  V25.2D, V21.2D
    FCVTZS  V4.4H, V1.4H
    FCVTZU  V26.4H, V25.4H, #10
    FCVTXN  V6.2S, V4.2D
    FCVTMS  V30.4S, V27.4S
    FRINTA  V29.4H, V20.4H
    FCVTN2  V24.8H, V19.4S
    FCVTPS  V21.4H, V12.4H
    FCVTNS  V14.2S, V30.2S
    FRINTP  V25.8H, V26.8H
    FCVTAU  V20.2D, V3.2D
    FCVTAU  V4.8H, V15.8H
    FCVTAS  V28.4S, V8.4S
    FCVTAU  V3.8H, V6.8H
    FRINTM  V1.4S, V20.4S
    FCVTL2  V27.2D, V29.4S
    FCVTNU  V30.4H, V1.4H
    FRINTI  V6.4S, V24.4S
    FCVTN  V24.4H, V25.4S
    FCVTL2  V20.2D, V21.4S
    FCVTZS  V21.4H, V24.4H, #4
    FCVTAU  V8.4H, V6.4H
    FRINTA  V19.8H, V27.8H
    FRINTI  V6.2D, V21.2D
    FRINTP  V26.8H, V30.8H
    FCVTPU  V25.4H, V26.4H
    FCVTZU  V29.4H, V4.4H
    FCVTZS  V27.2S, V20.2S
    FRINTI  V30.2S, V14.2S
    FCVTAS  V4.4H, V30.4H
    FCVTPU  V1.4H, V25.4H
    FCVTNU  V15.2S, V29.2S
    FCVTMS  V24.2S, V27.2S
    FCVTNU  V14.4H, V8.4H
    FRINTM  V8.4H, V28.4H
    FCVTPU  V27.8H, V14.8H
    FCVTNU  V12.8H, V19.8H
    FRINTI  V29.4H, V1.4H
    FRINTZ  V14.2S, V27.2S
    FRINTI  V21.2D, V12.2D
    FCVTN2  V26.8H, V4.4S
    FCVTL2  V12.2D, V26.4S
    FCVTPS  V8.4S, V15.4S
    FCVTPU  V20.4H, V12.4H
    FCVTPS  V30.4S, V8.4S
    FCVTZU  V19.8H, V24.8H, #7
    FCVTN2  V8.4S, V6.2D
    FCVTAS  V1.2D, V30.2D
    FCVTN2  V28.4S, V8.2D
    FCVTZS V12.2D, V19.2D, #4
    FCVTZU  V27.4S, V14.4S
    FCVTZS  V19.4S, V27.4S, #12
    FCVTNS  V27.4S, V19.4S
    FCVTMU  V30.4S, V27.4S
    FCVTMU  V4.4H, V30.4H
    FRINTZ  V15.4S, V20.4S
    FRINTZ  V19.8H, V15.8H
    FCVTN  V27.4H, V29.4S
    FCVTMU  V8.4H, V19.4H
    FCVTPU  V14.8H, V4.8H
    FRINTA  V19.8H, V14.8H
    FCVTZS  V15.4H, V27.4H, #16
    FRINTA  V30.4H, V15.4H
    FCVTZS  V29.8H, V28.8H
    FCVTMU  V6.2S, V29.2S
    FCVTZS  V28.4S, V8.4S, #29
    FRINTZ  V24.2D, V12.2D
    FCVTNU  V4.4H, V24.4H
    FCVTZS  V24.4H, V19.4H
    FCVTZU  V29.4S, V1.4S
    FRINTP  V20.4S, V24.4S
    FCVTL  V24.2D, V29.2S
    FCVTAU  V24.4H, V28.4H
    FCVTZS V1.2D, V0.2D, #5
    FCVTAS  V14.2D, V6.2D
    FRINTM  V12.4S, V14.4S
    FCVTNU  V0.4H, V1.4H
    FCVTL2  V4.2D, V24.4S
    FRINTI  V7.8H, V30.8H
    FRINTI  V8.4H, V12.4H
    FCVTN2  V14.8H, V0.4S
    FCVTNU  V6.4S, V10.4S
    FCVTN  V19.4H, V20.4S
    FCVTZU  V1.2D, V8.2D
    FCVTPU  V12.2S, V19.2S
    FCVTAS  V28.4H, V14.4H
    FCVTMU  V14.4S, V4.4S
    FCVTNU  V15.8H, V6.8H
    FCVTN  V24.2S, V7.2D
    FCVTPS  V19.4H, V28.4H
    FCVTZU  V27.4H, V12.4H
    FCVTXN2  V17.4S, V14.2D
    FCVTNU  V0.2S, V1.2S
    FCVTAS  V30.2S, V0.2S
    FCVTZS  V29.8H, V11.8H, #4
    FRINTN  V11.8H, V30.8H
    FCVTZU  V10.4H, V19.4H
    FRINTZ  V4.8H, V29.8H
    FRINTP  V12.4H, V11.4H
    FCVTNS  V28.2S, V12.2S
    FCVTAU  V30.4S, V15.4S
    FCVTAU  V14.4H, V27.4H
    FRINTZ  V21.2S, V17.2S
    FCVTAS  V20.8H, V24.8H
    FCVTMS  V6.4S, V10.4S
    FCVTAS  V1.2D, V31.2D
    FCVTL  V8.4S, V20.4H
    FRINTA  V0.4H, V8.4H
    FCVTXN  V31.2S, V1.2D
    FRINTI  V1.4S, V4.4S
    FRINTA  V7.8H, V6.8H
    FCVTAU  V24.8H, V7.8H
    FCVTZS V7.2D, V21.2D, #51
    FCVTPS  V8.8H, V28.8H
    FRINTP  V27.2S, V1.2S
    SUBS  X14, X14, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_19
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x1d, LSL #0
    MRS  X15, FPSR
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V0.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D0
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V1.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D1
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V2.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D2
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V3.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D3
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V4.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D4
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V5.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D5
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V6.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D6
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V7.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D7
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V8.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D8
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V9.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D9
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V10.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D10
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V11.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D11
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V12.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D12
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V13.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D13
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V14.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D14
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V15.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D15
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V16.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D16
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V17.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D17
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V18.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D18
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V19.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D19
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V20.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D20
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V21.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D21
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V22.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D22
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V23.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D23
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V24.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D24
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V25.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D25
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V26.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D26
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V27.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D27
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V28.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D28
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V29.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D29
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V30.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D30
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, V31.D[1]
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X15, D31
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
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
    FMOV  V0.D[1], X26
    FMOV  D1, X28
    FMOV  V1.D[1], X27
    FMOV  D2, X29
    FMOV  V2.D[1], X25
    FMOV  D3, X15
    FMOV  V3.D[1], X10
    FMOV  D4, X19
    FMOV  V4.D[1], X9
    FMOV  D5, X15
    FMOV  V5.D[1], X25
    FMOV  D6, X19
    FMOV  V6.D[1], X27
    FMOV  D7, X22
    FMOV  V7.D[1], X24
    FMOV  D8, X13
    FMOV  V8.D[1], X14
    FMOV  D9, X16
    FMOV  V9.D[1], X14
    FMOV  D10, X14
    FMOV  V10.D[1], X3
    FMOV  D11, X23
    FMOV  V11.D[1], X7
    FMOV  D12, X22
    FMOV  V12.D[1], X10
    FMOV  D13, X20
    FMOV  V13.D[1], X17
    FMOV  D14, X17
    FMOV  V14.D[1], X14
    FMOV  D15, X29
    FMOV  V15.D[1], X16
    FMOV  D16, X9
    FMOV  V16.D[1], X25
    FMOV  D17, X21
    FMOV  V17.D[1], X9
    FMOV  D18, X9
    FMOV  V18.D[1], X17
    FMOV  D19, X7
    FMOV  V19.D[1], X11
    FMOV  D20, X29
    FMOV  V20.D[1], X25
    FMOV  D21, X6
    FMOV  V21.D[1], X6
    FMOV  D22, X7
    FMOV  V22.D[1], X9
    FMOV  D23, X6
    FMOV  V23.D[1], X7
    FMOV  D24, X17
    FMOV  V24.D[1], X15
    FMOV  D25, X22
    FMOV  V25.D[1], X22
    FMOV  D26, X29
    FMOV  V26.D[1], X20
    FMOV  D27, X28
    FMOV  V27.D[1], X6
    FMOV  D28, X7
    FMOV  V28.D[1], X21
    FMOV  D29, X7
    FMOV  V29.D[1], X9
    FMOV  D30, X3
    FMOV  V30.D[1], X8
    FMOV  D31, X10
    FMOV  V31.D[1], X25
    MOVZ  X29, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_20:
    FRINTX  V9.4H, V23.4H
    FCVTPS  V18.2S, V26.2S
    FCVTZU V18.2D, V18.2D, #4
    FCVTZS  V30.2S, V27.2S, #14
    FCVTZU  V25.2S, V31.2S, #22
    FRINTZ  V30.2S, V30.2S
    FRINTX  V22.4H, V30.4H
    FCVTL  V8.4S, V29.4H
    FCVTNU  V14.4H, V25.4H
    FRINTI  V13.2D, V28.2D
    FCVTNS  V21.2S, V22.2S
    FCVTZS  V7.8H, V18.8H
    FCVTNS  V10.8H, V13.8H
    FCVTZS  V1.8H, V7.8H, #3
    FCVTNU  V5.2D, V8.2D
    FCVTNS  V10.2S, V14.2S
    FRINTA  V24.2D, V21.2D
    FCVTL2  V25.2D, V9.4S
    FCVTZU  V22.2S, V24.2S, #2
    FRINTZ  V14.4H, V10.4H
    FCVTZS  V23.4H, V1.4H, #14
    FCVTZU V7.2D, V5.2D, #29
    FRINTI  V29.2D, V7.2D
    FCVTZU  V28.8H, V23.8H, #12
    FCVTMS  V27.2D, V28.2D
    FCVTAS  V7.4S, V25.4S
    FRINTP  V13.2D, V29.2D
    FCVTNU  V26.4S, V8.4S
    FCVTPS  V18.4H, V26.4H
    FCVTAS  V23.8H, V18.8H
    FCVTL  V28.4S, V14.4H
    FRINTM  V9.4H, V28.4H
    FCVTZS  V26.2S, V23.2S, #21
    FCVTXN  V8.2S, V13.2D
    FRINTX  V21.8H, V22.8H
    FCVTMU  V22.2D, V27.2D
    FCVTAU  V29.2S, V22.2S
    FCVTNS  V25.4H, V9.4H
    FCVTZS  V24.4H, V7.4H, #15
    FCVTNS  V18.2D, V26.2D
    FCVTNU  V10.4S, V18.4S
    FCVTL2  V23.2D, V10.4S
    FCVTNU  V5.8H, V8.8H
    FCVTAU  V7.4H, V5.4H
    FCVTN2  V8.8H, V21.4S
    FRINTZ  V13.4H, V29.4H
    FCVTZU  V29.2S, V25.2S
    FCVTNU  V9.4H, V7.4H
    FCVTAU  V27.8H, V24.8H
    FCVTN  V1.4H, V27.4S
    FCVTN2  V22.4S, V13.2D
    FCVTPS  V14.8H, V22.8H
    FCVTL  V13.4S, V1.4H
    FCVTZU  V7.4H, V8.4H, #12
    FCVTN  V1.2S, V13.2D
    FCVTZS  V18.4H, V9.4H, #6
    FCVTZU  V13.4H, V1.4H
    FCVTZU  V1.4S, V13.4S, #4
    FCVTZU  V24.4H, V1.4H, #3
    FRINTI  V27.8H, V29.8H
    FCVTXN2  V21.4S, V23.2D
    FRINTN  V5.2S, V7.2S
    FCVTZS  V13.8H, V18.8H
    FRINTX  V8.4H, V13.4H
    FCVTNU  V25.4S, V14.4S
    FCVTPU  V7.8H, V9.8H
    FCVTXN  V13.2S, V17.2D
    FCVTZS  V23.2S, V24.2S
    FCVTZS V29.2D, V8.2D, #40
    FCVTN2  V24.8H, V23.4S
    FCVTNS  V18.2D, V24.2D
    FRINTX  V1.2D, V7.2D
    FRINTP  V9.8H, V27.8H
    FCVTXN2  V8.4S, V25.2D
    FCVTAU  V7.8H, V1.8H
    FCVTAU  V27.2S, V5.2S
    FCVTMS  V22.2S, V8.2S
    FCVTNS  V8.2S, V13.2S
    FCVTMU  V17.8H, V21.8H
    FCVTAS  V21.2S, V7.2S
    FCVTMU  V24.2S, V22.2S
    FCVTMS  V1.4S, V24.4S
    FCVTPU  V5.8H, V1.8H
    FRINTP  V25.2D, V27.2D
    FCVTZS V23.2D, V9.2D, #63
    FCVTZU  V9.4S, V8.4S
    FCVTZS  V13.4H, V29.4H, #5
    FCVTN  V14.2S, V18.2D
    FCVTZU  V7.8H, V25.8H, #10
    FRINTP  V25.2S, V9.2S
    FCVTXN  V9.2S, V23.2D
    FCVTXN  V1.2S, V5.2D
    FRINTA  V24.2D, V22.2D
    FCVTZU  V23.8H, V13.8H, #6
    FCVTZU  V22.4H, V1.4H
    FRINTM  V5.2S, V14.2S
    FCVTN2  V18.4S, V22.2D
    FCVTZS  V3.8H, V5.8H
    FCVTMS  V13.2D, V18.2D
    FCVTZU  V22.2S, V21.2S, #7
    FRINTA  V1.8H, V22.8H
    FCVTMS  V29.4H, V13.4H
    FRINTN  V13.8H, V7.8H
    FCVTN2  V22.8H, V3.4S
    FRINTX  V5.4S, V1.4S
    FCVTMU  V14.2D, V5.2D
    FCVTZU  V8.8H, V29.8H, #10
    FRINTZ  V5.4H, V8.4H
    FCVTPU  V8.8H, V17.8H
    FCVTNU  V7.4S, V13.4S
    FRINTA  V3.4H, V8.4H
    FCVTPU  V21.4H, V23.4H
    FRINTP  V8.4S, V22.4S
    FCVTPU  V1.2S, V25.2S
    FCVTZS V23.2D, V3.2D, #4
    FRINTZ  V18.8H, V14.8H
    FCVTXN  V14.2S, V18.2D
    FCVTMS  V18.4H, V1.4H
    FCVTAS  V17.2S, V21.2S
    FCVTAU  V29.4H, V5.4H
    FCVTN2  V22.4S, V7.2D
    FCVTN  V1.2S, V22.2D
    FCVTPU  V22.2S, V1.2S
    FCVTPS  V21.4H, V22.4H
    FCVTZS  V25.4H, V18.4H
    FCVTMU  V13.4H, V14.4H
    FCVTAS  V22.2S, V23.2S
    FCVTNU  V7.8H, V21.8H
    FCVTN2  V5.4S, V13.2D
    FCVTN2  V21.4S, V25.2D
    FCVTNS  V25.4H, V8.4H
    FCVTMS  V14.4H, V17.4H
    FCVTNS  V0.8H, V21.8H
    FCVTZS  V13.4H, V25.4H
    FCVTNS  V1.4S, V5.4S
    FRINTP  V8.2S, V22.2S
    FRINTM  V17.4S, V8.4S
    FCVTN2  V18.8H, V14.4S
    FCVTXN  V8.2S, V0.2D
    FCVTZS  V22.8H, V17.8H, #6
    FRINTM  V17.4H, V7.4H
    FRINTX  V0.4H, V18.4H
    FCVTMS  V25.2S, V0.2S
    FCVTN  V21.2S, V17.2D
    FCVTL  V5.2D, V25.2S
    FCVTZS V25.2D, V13.2D, #46
    FCVTMS  V17.4H, V21.4H
    FRINTZ  V23.4H, V1.4H
    FCVTZU V7.2D, V8.2D, #51
    FCVTPU  V8.2D, V7.2D
    FCVTZS  V1.4S, V23.4S, #5
    FCVTZS V12.2D, V1.2D, #61
    FCVTMU  V23.2S, V12.2S
    FCVTZS  V1.2S, V17.2S, #16
    FCVTZS  V17.8H, V23.8H, #11
    FCVTPS  V7.8H, V5.8H
    FCVTAS  V23.4S, V22.4S
    FCVTNU  V18.2S, V25.2S
    FRINTA  V12.2D, V18.2D
    FRINTA  V5.4H, V0.4H
    FCVTNU  V21.2D, V7.2D
    FCVTZU  V14.8H, V12.8H, #14
    FCVTAU  V0.8H, V8.8H
    FCVTL  V25.4S, V23.4H
    FCVTMS  V13.2D, V5.2D
    FRINTI  V23.2D, V1.2D
    FRINTX  V22.4H, V23.4H
    FRINTN  V12.8H, V7.8H
    FCVTZS  V18.8H, V22.8H
    FCVTAU  V22.4H, V13.4H
    FRINTX  V30.2S, V17.2S
    FRINTI  V8.8H, V2.8H
    FCVTXN  V23.2S, V23.2D
    FCVTL  V5.4S, V22.4H
    FCVTPU  V7.8H, V7.8H
    FCVTNS  V13.2S, V5.2S
    FCVTL  V2.2D, V2.2S
    FCVTN  V21.2S, V6.2D
    FCVTAU  V17.4H, V30.4H
    FCVTAU  V30.4S, V25.4S
    FCVTNU  V25.8H, V18.8H
    FCVTXN  V31.2S, V7.2D
    FCVTAS  V25.8H, V2.8H
    FCVTZU  V6.2D, V21.2D
    FRINTZ  V1.8H, V13.8H
    FCVTZS  V18.2S, V17.2S, #3
    FRINTN  V17.8H, V12.8H
    FRINTX  V7.8H, V18.8H
    FCVTAU  V25.4H, V23.4H
    FCVTNS  V18.2D, V8.2D
    FCVTN2  V8.4S, V31.2D
    FCVTMU  V31.2D, V30.2D
    FCVTZU  V12.4S, V31.4S
    FCVTZU  V30.4S, V8.4S
    FRINTA  V22.4S, V6.4S
    FCVTZS  V21.4H, V18.4H, #7
    FCVTNS  V23.4S, V21.4S
    FCVTZS  V18.2S, V1.2S, #21
    FRINTA  V5.4H, V18.4H
    FCVTAS  V20.4H, V5.4H
    SUBS  X29, X29, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_20
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X17, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X17, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X17, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X17, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X17, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X17, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X17, X7, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X17, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X17, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X17, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X17, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X17, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X17, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X17, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X17, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X17, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X17, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X17, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X17, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X17, X7, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x1d, LSL #0
    MRS  X17, FPSR
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, V0.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, D0
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, V1.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, D1
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, V2.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, D2
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, V3.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, D3
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X17, V4.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X17, D4
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, V5.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, D5
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, V6.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, D6
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, V7.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, D7
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, V8.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, D8
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, V9.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, D9
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, V10.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, D10
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X17, V11.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X17, D11
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, V12.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, D12
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, V13.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, D13
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, V14.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, D14
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X17, V15.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X17, D15
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X17, V16.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X17, D16
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, V17.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, D17
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, V18.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, D18
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X17, V19.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X17, D19
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, V20.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, D20
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, V21.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, D21
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, V22.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, D22
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, V23.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, D23
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, V24.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, D24
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, V25.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, D25
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, V26.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, D26
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, V27.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, D27
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, V28.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, D28
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, V29.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, D29
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, V30.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, D30
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, V31.D[1]
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X17, D31
    SUB  X25, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail

TSRTAdvsimdVectorFloatingPointConvertToInteger_TestEnd:
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
TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail:
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
