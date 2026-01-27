.global TaishanSimdFpIntConversionP01

.text
.p2align 4

TaishanSimdFpIntConversionP01:

TaishanSimdFpIntConversionP01_TestBegin:
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
    MOVK  X2, #0xade, LSL #48
    MOVK  X2, #0x185, LSL #32
    MOVK  X2, #0x8db6, LSL #16
    MOVK  X2, #0xef29, LSL #0
    MOVK  X3, #0x53a9, LSL #48
    MOVK  X3, #0xb74a, LSL #32
    MOVK  X3, #0xf88d, LSL #16
    MOVK  X3, #0x14fb, LSL #0
    MOVK  X4, #0x26d8, LSL #48
    MOVK  X4, #0x3f4d, LSL #32
    MOVK  X4, #0xe8f8, LSL #16
    MOVK  X4, #0xb2bd, LSL #0
    MOVK  X5, #0x2dc3, LSL #48
    MOVK  X5, #0x4aeb, LSL #32
    MOVK  X5, #0xa170, LSL #16
    MOVK  X5, #0xae78, LSL #0
    MOVK  X6, #0xcb12, LSL #48
    MOVK  X6, #0x4958, LSL #32
    MOVK  X6, #0x390e, LSL #16
    MOVK  X6, #0x6b3a, LSL #0
    MOVK  X7, #0x8a18, LSL #48
    MOVK  X7, #0xbd17, LSL #32
    MOVK  X7, #0xd825, LSL #16
    MOVK  X7, #0x910f, LSL #0
    MOVK  X8, #0xd3f, LSL #48
    MOVK  X8, #0xec9a, LSL #32
    MOVK  X8, #0x59d2, LSL #16
    MOVK  X8, #0xa46e, LSL #0
    MOVK  X9, #0x31d9, LSL #48
    MOVK  X9, #0x466a, LSL #32
    MOVK  X9, #0x72ec, LSL #16
    MOVK  X9, #0x4f2f, LSL #0
    MOVK  X10, #0xd1a6, LSL #48
    MOVK  X10, #0x8386, LSL #32
    MOVK  X10, #0xf1cb, LSL #16
    MOVK  X10, #0x895e, LSL #0
    MOVK  X11, #0x93fc, LSL #48
    MOVK  X11, #0xe892, LSL #32
    MOVK  X11, #0x58a4, LSL #16
    MOVK  X11, #0xc721, LSL #0
    MOVK  X12, #0xb7db, LSL #48
    MOVK  X12, #0x3820, LSL #32
    MOVK  X12, #0x383b, LSL #16
    MOVK  X12, #0x67ac, LSL #0
    MOVK  X14, #0x2b0, LSL #48
    MOVK  X14, #0x2fb4, LSL #32
    MOVK  X14, #0x92ff, LSL #16
    MOVK  X14, #0x896f, LSL #0
    MOVK  X15, #0xb0c5, LSL #48
    MOVK  X15, #0x9282, LSL #32
    MOVK  X15, #0x978f, LSL #16
    MOVK  X15, #0xa238, LSL #0
    MOVK  X16, #0xccc8, LSL #48
    MOVK  X16, #0xa2bd, LSL #32
    MOVK  X16, #0xf9a9, LSL #16
    MOVK  X16, #0xa8d, LSL #0
    MOVK  X17, #0x8934, LSL #48
    MOVK  X17, #0x1f37, LSL #32
    MOVK  X17, #0x5627, LSL #16
    MOVK  X17, #0xfee8, LSL #0
    MOVK  X18, #0x4274, LSL #48
    MOVK  X18, #0x96c, LSL #32
    MOVK  X18, #0x3a63, LSL #16
    MOVK  X18, #0x6b8e, LSL #0
    MOVK  X19, #0xb28c, LSL #48
    MOVK  X19, #0x8ad2, LSL #32
    MOVK  X19, #0x4d71, LSL #16
    MOVK  X19, #0x212a, LSL #0
    MOVK  X20, #0x2376, LSL #48
    MOVK  X20, #0x520c, LSL #32
    MOVK  X20, #0x6c98, LSL #16
    MOVK  X20, #0x71d8, LSL #0
    MOVK  X21, #0xf2b1, LSL #48
    MOVK  X21, #0xb8ca, LSL #32
    MOVK  X21, #0xc78b, LSL #16
    MOVK  X21, #0x7c5b, LSL #0
    MOVK  X22, #0x1a62, LSL #48
    MOVK  X22, #0x85e6, LSL #32
    MOVK  X22, #0x32a5, LSL #16
    MOVK  X22, #0x77b7, LSL #0
    MOVK  X23, #0x8584, LSL #48
    MOVK  X23, #0x5ef1, LSL #32
    MOVK  X23, #0x47e9, LSL #16
    MOVK  X23, #0x34a1, LSL #0
    MOVK  X24, #0x537f, LSL #48
    MOVK  X24, #0xb352, LSL #32
    MOVK  X24, #0x917f, LSL #16
    MOVK  X24, #0xe436, LSL #0
    MOVK  X25, #0x2d2, LSL #48
    MOVK  X25, #0x8aee, LSL #32
    MOVK  X25, #0x408f, LSL #16
    MOVK  X25, #0x2a34, LSL #0
    MOVK  X26, #0x591e, LSL #48
    MOVK  X26, #0x45c2, LSL #32
    MOVK  X26, #0x3036, LSL #16
    MOVK  X26, #0xc62f, LSL #0
    MOVK  X27, #0x6753, LSL #48
    MOVK  X27, #0x4d0d, LSL #32
    MOVK  X27, #0xc965, LSL #16
    MOVK  X27, #0x8e6a, LSL #0
    MOVK  X28, #0x5ce0, LSL #48
    MOVK  X28, #0x9c62, LSL #32
    MOVK  X28, #0xed7c, LSL #16
    MOVK  X28, #0x4f85, LSL #0
    MOVK  X29, #0x6bd1, LSL #48
    MOVK  X29, #0xdb3f, LSL #32
    MOVK  X29, #0xd274, LSL #16
    MOVK  X29, #0xa125, LSL #0
    ADDS  W19, W22, W28, UXTX #0
    MOVZ  X27, #0x727d, LSL #0
    MOVK  X27, #0x1c4c, LSL #16
    MSR  FPCR, X27
    MRS  X9, FPSR
    MOVZ  X10, #0xff60, LSL #0
    MOVK  X10, #0x7ff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    AND  X9, X9, X10
    MOVZ  X10, #0x0, LSL #0
    ORR  X9, X9, X10
    MSR  FPSR, X9
    ISB  SY
    MOVZ  X2, #0x7ade, LSL #0
    MOVK  X2, #0xe30d, LSL #16
    MOVK  X2, #0x33d9, LSL #32
    MOVK  X2, #0x2b83, LSL #48
    MOVZ  X3, #0x103c, LSL #0
    MOVK  X3, #0x881b, LSL #16
    MOVK  X3, #0xc655, LSL #32
    MOVK  X3, #0xe3f6, LSL #48
    MOVZ  X4, #0x4f01, LSL #0
    MOVK  X4, #0x237e, LSL #16
    MOVK  X4, #0x4d81, LSL #32
    MOVK  X4, #0xcd35, LSL #48
    MOVZ  X5, #0xeb2b, LSL #0
    MOVK  X5, #0x4cd2, LSL #16
    MOVK  X5, #0x28eb, LSL #32
    MOVK  X5, #0x56a8, LSL #48
    MOVZ  X6, #0x48e4, LSL #0
    MOVK  X6, #0x4739, LSL #16
    MOVK  X6, #0xab3e, LSL #32
    MOVK  X6, #0xb3b8, LSL #48
    MOVZ  X7, #0xec5a, LSL #0
    MOVK  X7, #0xc7ee, LSL #16
    MOVK  X7, #0xfec1, LSL #32
    MOVK  X7, #0x79bb, LSL #48
    MOVZ  X8, #0xabc4, LSL #0
    MOVK  X8, #0xe178, LSL #16
    MOVK  X8, #0x4cd5, LSL #32
    MOVK  X8, #0xa9a3, LSL #48
    MOVZ  X9, #0x921c, LSL #0
    MOVK  X9, #0xf553, LSL #16
    MOVK  X9, #0x6a73, LSL #32
    MOVK  X9, #0xc37a, LSL #48
    MOVZ  X10, #0xdfcd, LSL #0
    MOVK  X10, #0x5d40, LSL #16
    MOVK  X10, #0x3b08, LSL #32
    MOVK  X10, #0xf8b0, LSL #48
    MOVZ  X11, #0x24ae, LSL #0
    MOVK  X11, #0x86f, LSL #16
    MOVK  X11, #0x5d96, LSL #32
    MOVK  X11, #0x6218, LSL #48
    MOVZ  X12, #0x9056, LSL #0
    MOVK  X12, #0x5ca9, LSL #16
    MOVK  X12, #0xbc6a, LSL #32
    MOVK  X12, #0xc156, LSL #48
    MOVZ  X14, #0x25fe, LSL #0
    MOVK  X14, #0x4eb4, LSL #16
    MOVK  X14, #0xaa46, LSL #32
    MOVK  X14, #0x5c76, LSL #48
    MOVZ  X15, #0xaca3, LSL #0
    MOVK  X15, #0x5412, LSL #16
    MOVK  X15, #0x79e3, LSL #32
    MOVK  X15, #0x6a55, LSL #48
    MOVZ  X16, #0xb526, LSL #0
    MOVK  X16, #0xd5f8, LSL #16
    MOVK  X16, #0x90a5, LSL #32
    MOVK  X16, #0x96b4, LSL #48
    MOVZ  X17, #0xf9c, LSL #0
    MOVK  X17, #0xb62d, LSL #16
    MOVK  X17, #0x78b9, LSL #32
    MOVK  X17, #0x56b4, LSL #48
    MOVZ  X18, #0x565f, LSL #0
    MOVK  X18, #0x8d8e, LSL #16
    MOVK  X18, #0x956d, LSL #32
    MOVK  X18, #0x19b1, LSL #48
    MOVZ  X19, #0xda4a, LSL #0
    MOVK  X19, #0xe43e, LSL #16
    MOVK  X19, #0x70e6, LSL #32
    MOVK  X19, #0xdcf8, LSL #48
    MOVZ  X20, #0x3ffd, LSL #0
    MOVK  X20, #0xcf30, LSL #16
    MOVK  X20, #0x396c, LSL #32
    MOVK  X20, #0x5e5e, LSL #48
    MOVZ  X21, #0xc7bd, LSL #0
    MOVK  X21, #0xc492, LSL #16
    MOVK  X21, #0xaf3d, LSL #32
    MOVK  X21, #0xf59b, LSL #48
    MOVZ  X22, #0x1af0, LSL #0
    MOVK  X22, #0xc841, LSL #16
    MOVK  X22, #0x8e33, LSL #32
    MOVK  X22, #0x605c, LSL #48
    MOVZ  X23, #0x5d94, LSL #0
    MOVK  X23, #0xc660, LSL #16
    MOVK  X23, #0x7787, LSL #32
    MOVK  X23, #0x106d, LSL #48
    MOVZ  X24, #0x1cd8, LSL #0
    MOVK  X24, #0xe639, LSL #16
    MOVK  X24, #0xff2c, LSL #32
    MOVK  X24, #0x65cb, LSL #48
    MOVZ  X25, #0x949b, LSL #0
    MOVK  X25, #0x9319, LSL #16
    MOVK  X25, #0x72b4, LSL #32
    MOVK  X25, #0xda03, LSL #48
    MOVZ  X26, #0x88be, LSL #0
    MOVK  X26, #0x2bba, LSL #16
    MOVK  X26, #0xc4f9, LSL #32
    MOVK  X26, #0x4879, LSL #48
    MOVZ  X27, #0xafa8, LSL #0
    MOVK  X27, #0x2779, LSL #16
    MOVK  X27, #0xb62b, LSL #32
    MOVK  X27, #0xf884, LSL #48
    MOVZ  X28, #0xc6f1, LSL #0
    MOVK  X28, #0xed5b, LSL #16
    MOVK  X28, #0x2b08, LSL #32
    MOVK  X28, #0x88f, LSL #48
    MOVZ  X29, #0x35f0, LSL #0
    MOVK  X29, #0xcfd7, LSL #16
    MOVK  X29, #0x18f0, LSL #32
    MOVK  X29, #0x9b30, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X28
    FMOV  D1, X12
    FMOV  V1.D[1], X26
    FMOV  D2, X28
    FMOV  V2.D[1], X28
    FMOV  D3, X11
    FMOV  V3.D[1], X27
    FMOV  D4, X26
    FMOV  V4.D[1], X29
    FMOV  D5, X26
    FMOV  V5.D[1], X20
    FMOV  D6, X26
    FMOV  V6.D[1], X11
    FMOV  D7, X18
    FMOV  V7.D[1], X26
    FMOV  D8, X2
    FMOV  V8.D[1], X7
    FMOV  D9, X9
    FMOV  V9.D[1], X5
    FMOV  D10, X16
    FMOV  V10.D[1], X22
    FMOV  D11, X21
    FMOV  V11.D[1], X20
    FMOV  D12, X20
    FMOV  V12.D[1], X17
    FMOV  D13, X22
    FMOV  V13.D[1], X28
    FMOV  D14, X6
    FMOV  V14.D[1], X2
    FMOV  D15, X20
    FMOV  V15.D[1], X26
    FMOV  D16, X5
    FMOV  V16.D[1], X2
    FMOV  D17, X25
    FMOV  V17.D[1], X8
    FMOV  D18, X18
    FMOV  V18.D[1], X20
    FMOV  D19, X17
    FMOV  V19.D[1], X9
    FMOV  D20, X25
    FMOV  V20.D[1], X24
    FMOV  D21, X7
    FMOV  V21.D[1], X3
    FMOV  D22, X16
    FMOV  V22.D[1], X3
    FMOV  D23, X21
    FMOV  V23.D[1], X25
    FMOV  D24, X17
    FMOV  V24.D[1], X7
    FMOV  D25, X7
    FMOV  V25.D[1], X11
    FMOV  D26, X26
    FMOV  V26.D[1], X23
    FMOV  D27, X25
    FMOV  V27.D[1], X2
    FMOV  D28, X9
    FMOV  V28.D[1], X5
    FMOV  D29, X7
    FMOV  V29.D[1], X9
    FMOV  D30, X24
    FMOV  V30.D[1], X29
    FMOV  D31, X17
    FMOV  V31.D[1], X6
    MOVZ  X22, #0xa, LSL #0
TaishanSimdFpIntConversionP01_label_0:
    SUQADD  S30, S8
    UXTL2 V29.4S, V20.8H
    CNT  V4.16B, V24.16B
    ABS  V31.2D, V28.2D
    SQABS  V25.4H, V10.4H
    CLS  V3.4S, V10.4S
    REV16  V11.8B, V31.8B
    UQXTN  S0, D8
    FNEG  V22.2S, V0.2S
    FSQRT  V28.2D, V24.2D
    SADALP  V21.2S, V26.4H
    SXTL V7.4S, V11.4H
    SXTL V29.8H, V4.8B
    SQXTN2  V8.16B, V31.8H
    SQNEG  B24, B7
    NEG  D14, D6
    URECPE  V31.4S, V8.4S
    FRSQRTE  D29, D9
    CLZ  V31.4S, V8.4S
    SADALP  V18.2S, V22.4H
    ABS  V23.8B, V12.8B
    UQXTN  V25.8B, V4.8H
    UQXTN2  V24.16B, V9.8H
    USQADD  H26, H31
    RBIT  V11.16B, V15.16B
    FRINTZ  V3.2D, V21.2D
    UXTL V2.8H, V18.8B
    SQABS  V13.2D, V10.2D
    SXTL2 V25.2D, V21.4S
    NEG  D5, D28
    SADALP  V24.2D, V19.4S
    FRINTX  V6.2D, V12.2D
    SQNEG  H23, H10
    FRINTZ  V9.2S, V15.2S
    FRECPS  S25, S18, S2
    RBIT  V30.16B, V17.16B
    UXTL2 V14.2D, V31.4S
    SUQADD  V24.2D, V26.2D
    SQABS  D31, D5
    REV16  V5.16B, V13.16B
    SUQADD  V3.16B, V4.16B
    FRINTM  V25.4S, V28.4S
    UXTL2 V29.2D, V22.4S
    SXTL2 V9.2D, V23.4S
    MVN  V31.8B, V2.8B
    UXTL2 V20.2D, V12.4S
    XTN2  V5.4S, V2.2D
    SUQADD  S5, S6
    SQNEG  B13, B5
    SXTL2 V21.2D, V10.4S
    UADALP  V11.2S, V23.4H
    SQABS  S21, S25
    FSQRT  V22.4S, V18.4S
    SUQADD  S17, S15
    SUQADD  H2, H28
    SADALP  V5.4H, V20.8B
    FCVTXN  V18.2S, V3.2D
    FRSQRTE  D6, D5
    SQNEG  V24.4H, V11.4H
    FRINTX  V30.4S, V6.4S
    FCVTXN2  V30.4S, V7.2D
    UADDLP  V20.1D, V30.2S
    FRINTA  V30.2D, V28.2D
    FRSQRTE  S0, S31
    XTN2  V6.8H, V18.4S
    UQXTN  H9, S22
    USQADD  S1, S11
    SUQADD  S21, S14
    FRINTN  V10.2S, V17.2S
    SQNEG  D22, D27
    UXTL2 V3.2D, V5.4S
    FRECPX  S4, S31
    ABS  V23.4H, V28.4H
    MVN  V23.8B, V26.8B
    FSQRT  V24.2S, V30.2S
    FRINTZ  V18.2S, V31.2S
    SQXTN  V23.8B, V3.8H
    SQXTN2  V25.4S, V23.2D
    XTN  V8.2S, V12.2D
    FRECPS  S15, S13, S16
    FRINTZ  V0.4S, V3.4S
    FRINTZ  V27.2S, V27.2S
    UQXTN  H12, S7
    UQXTN  B10, H29
    SQXTUN  B15, H10
    FRINTM  V15.2D, V7.2D
    USQADD  D25, D4
    FRECPS  D1, D3, D18
    SQABS  H20, H1
    RBIT  V28.16B, V18.16B
    UXTL V21.2D, V15.2S
    NOT  V2.16B, V7.16B
    REV64  V15.16B, V7.16B
    SQXTUN  V16.8B, V1.8H
    SUQADD  V14.4H, V29.4H
    FRINTM  V9.2S, V18.2S
    FCVTXN  V18.2S, V23.2D
    SUQADD  S13, S29
    SQXTUN  V12.2S, V10.2D
    SQXTN  B20, H8
    UXTL2 V29.2D, V20.4S
    UXTL V14.4S, V2.4H
    UXTL V13.8H, V1.8B
    XTN2  V9.8H, V10.4S
    USQADD  V28.8H, V17.8H
    SQABS  V28.2S, V20.2S
    USQADD  S31, S14
    FCVTXN  V20.2S, V22.2D
    FRINTN  V14.2S, V22.2S
    UXTL V7.2D, V23.2S
    USQADD  B20, B21
    UXTL V9.2D, V4.2S
    UQXTN  S4, D6
    SQNEG  V20.4H, V6.4H
    NEG  D15, D30
    SQXTUN  V31.4H, V0.4S
    UQXTN  B19, H13
    RBIT  V11.16B, V9.16B
    REV32  V20.16B, V18.16B
    SUQADD  H8, H17
    UXTL2 V6.8H, V26.16B
    FRINTA  V10.4S, V22.4S
    FRINTA  V18.2S, V3.2S
    SUQADD  B21, B31
    UADDLP  V1.4H, V7.8B
    SUQADD  B2, B22
    SQABS  V18.8B, V12.8B
    UXTL2 V17.8H, V1.16B
    SQABS  V31.2S, V11.2S
    USQADD  S21, S13
    FCVTXN  V17.2S, V14.2D
    SQXTN  H5, S21
    USQADD  S23, S24
    FRSQRTE  S17, S28
    FRECPX  S1, S6
    UQXTN  S30, D22
    SXTL2 V2.8H, V20.16B
    CLS  V5.4H, V5.4H
    SXTL2 V11.8H, V5.16B
    USQADD  V30.4H, V2.4H
    URECPE  V1.2S, V2.2S
    SADDLP  V12.1D, V22.2S
    SQNEG  S31, S4
    FNEG  V20.2D, V23.2D
    ABS  V6.8B, V27.8B
    SXTL V1.8H, V30.8B
    MVN  V0.8B, V10.8B
    SQNEG  B17, B10
    FCVTXN  V2.2S, V1.2D
    FCVTXN  S19, D24
    UXTL V18.8H, V18.8B
    UQXTN  V7.2S, V29.2D
    FRSQRTE  D7, D22
    MVN  V27.16B, V12.16B
    SUQADD  H27, H9
    CLS  V10.8B, V24.8B
    SADDLP  V11.1D, V21.2S
    SUQADD  V15.2S, V0.2S
    USQADD  H28, H13
    USQADD  S10, S20
    SUQADD  H13, H8
    UXTL2 V28.4S, V8.8H
    CLS  V6.8H, V11.8H
    SQNEG  D5, D5
    SADDLP  V8.2S, V21.4H
    SUQADD  S2, S1
    SUQADD  H31, H17
    SQXTUN  B28, H2
    FRINTA  V24.4S, V15.4S
    FRECPX  D30, D12
    FRECPS  S7, S2, S20
    REV32  V2.8H, V28.8H
    FRECPS  S21, S10, S25
    SUQADD  S11, S0
    UXTL V0.2D, V7.2S
    SQABS  B20, B3
    FRECPS  S21, S17, S17
    SQXTN2  V22.16B, V3.8H
    NEG  D0, D24
    FNEG  V8.2D, V25.2D
    UXTL2 V25.4S, V29.8H
    FRINTM  V14.2D, V29.2D
    SQXTN2  V29.4S, V21.2D
    SQXTUN  V28.4H, V24.4S
    FRINTA  V7.2S, V30.2S
    NEG  D7, D9
    SXTL V17.2D, V8.2S
    SUQADD  B15, B15
    ABS  D10, D25
    SUQADD  H30, H5
    FRINTN  V5.2D, V15.2D
    SQABS  V3.16B, V4.16B
    ABS  D24, D24
    FCVTXN  S4, D3
    SXTL V27.8H, V17.8B
    SXTL V4.2D, V22.2S
    CLZ  V4.8H, V6.8H
    FRECPS  S12, S27, S19
    CLS  V7.4H, V20.4H
    SQNEG  D24, D4
    SUBS  X22, X22, #0x1
    B.NE  TaishanSimdFpIntConversionP01_label_0
    MOVZ  X18, #0x7ade, LSL #0
    MOVK  X18, #0xe30d, LSL #16
    MOVK  X18, #0x33d9, LSL #32
    MOVK  X18, #0x2b83, LSL #48
    SUB  X12, X18, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X26, #0x103c, LSL #0
    MOVK  X26, #0x881b, LSL #16
    MOVK  X26, #0xc655, LSL #32
    MOVK  X26, #0xe3f6, LSL #48
    SUB  X6, X26, X3
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X29, #0x4f01, LSL #0
    MOVK  X29, #0x237e, LSL #16
    MOVK  X29, #0x4d81, LSL #32
    MOVK  X29, #0xcd35, LSL #48
    SUB  X19, X29, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X7, #0xeb2b, LSL #0
    MOVK  X7, #0x4cd2, LSL #16
    MOVK  X7, #0x28eb, LSL #32
    MOVK  X7, #0x56a8, LSL #48
    SUB  X23, X7, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X5, #0xeb2b, LSL #0
    MOVK  X5, #0x4cd2, LSL #16
    MOVK  X5, #0x28eb, LSL #32
    MOVK  X5, #0x56a8, LSL #48
    SUB  X11, X5, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X7, #0xabc4, LSL #0
    MOVK  X7, #0xe178, LSL #16
    MOVK  X7, #0x4cd5, LSL #32
    MOVK  X7, #0xa9a3, LSL #48
    SUB  X4, X7, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X23, #0xdfcd, LSL #0
    MOVK  X23, #0x5d40, LSL #16
    MOVK  X23, #0x3b08, LSL #32
    MOVK  X23, #0xf8b0, LSL #48
    SUB  X10, X23, X10
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X15, X29, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X17, X28, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X27, #0xb526, LSL #0
    MOVK  X27, #0xd5f8, LSL #16
    MOVK  X27, #0x90a5, LSL #32
    MOVK  X27, #0x96b4, LSL #48
    SUB  X26, X27, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X18
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X19
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X11, #0x3ffd, LSL #0
    MOVK  X11, #0xcf30, LSL #16
    MOVK  X11, #0x396c, LSL #32
    MOVK  X11, #0x5e5e, LSL #48
    SUB  X16, X11, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X8, #0xdfcd, LSL #0
    MOVK  X8, #0x5d40, LSL #16
    MOVK  X8, #0x3b08, LSL #32
    MOVK  X8, #0xf8b0, LSL #48
    SUB  X25, X8, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X20, #0x1cd8, LSL #0
    MOVK  X20, #0xe639, LSL #16
    MOVK  X20, #0xff2c, LSL #32
    MOVK  X20, #0x65cb, LSL #48
    SUB  X5, X20, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X5, X6, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X15, #0xb526, LSL #0
    MOVK  X15, #0xd5f8, LSL #16
    MOVK  X15, #0x90a5, LSL #32
    MOVK  X15, #0x96b4, LSL #48
    SUB  X16, X15, X27
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X20, X21, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, D2
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, V3.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, D3
    MOVZ  X19, #0x101, LSL #0
    MOVK  X19, #0x101, LSL #16
    SUB  X22, X19, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, V4.D[1]
    MOVZ  X14, #0xc, LSL #0
    MOVK  X14, #0xc, LSL #16
    MOVK  X14, #0xc, LSL #32
    MOVK  X14, #0xc, LSL #48
    SUB  X28, X14, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, D4
    MOVZ  X14, #0xd, LSL #0
    MOVK  X14, #0xd, LSL #16
    MOVK  X14, #0xc, LSL #32
    MOVK  X14, #0xc, LSL #48
    SUB  X28, X14, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, V5.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, D5
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X21, #0xf, LSL #0
    MOVK  X21, #0xf, LSL #16
    MOVK  X21, #0xf, LSL #32
    MOVK  X21, #0xf, LSL #48
    SUB  X17, X21, X24
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, D6
    MOVZ  X21, #0x6, LSL #0
    MOVK  X21, #0x7, LSL #16
    MOVK  X21, #0xf, LSL #32
    MOVK  X21, #0xf, LSL #48
    SUB  X17, X21, X24
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X23, X17, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D7
    MOVZ  X17, #0xf, LSL #0
    MOVK  X17, #0xf, LSL #16
    MOVK  X17, #0xf, LSL #32
    MOVK  X17, #0xf, LSL #48
    SUB  X23, X17, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x8000, LSL #48
    SUB  X2, X21, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, D8
    MOVZ  X21, #0xfef4, LSL #0
    MOVK  X21, #0xffb3, LSL #16
    MOVK  X21, #0xfff4, LSL #32
    MOVK  X21, #0x7ffb, LSL #48
    SUB  X2, X21, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, V9.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X3, X25, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, D9
    MOVZ  X25, #0xff01, LSL #0
    MOVK  X25, #0xffc0, LSL #16
    SUB  X3, X25, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, D10
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, D11
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0x7fff, LSL #16
    SUB  X8, X10, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, V12.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, D12
    MOVZ  X3, #0xfff4, LSL #0
    MOVK  X3, #0x7ffe, LSL #16
    SUB  X5, X3, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, D14
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, V15.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X14, X19, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, D15
    MOVZ  X19, #0x7f, LSL #0
    SUB  X14, X19, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X2, X25, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, D16
    MOVZ  X25, #0x0, LSL #0
    SUB  X2, X25, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, V17.D[1]
    MOVZ  X10, #0xfff4, LSL #0
    MOVK  X10, #0x7ffb, LSL #16
    SUB  X14, X10, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, D17
    MOVZ  X10, #0xfef4, LSL #0
    MOVK  X10, #0xffb3, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X14, X10, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, V18.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, D18
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X21, X23, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, D19
    MOVZ  X23, #0xff9f, LSL #0
    MOVK  X23, #0xffdf, LSL #16
    SUB  X21, X23, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, V20.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X23, X10, X6
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, D20
    MOVZ  X10, #0x0, LSL #0
    SUB  X23, X10, X6
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, D21
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x4000, LSL #16
    SUB  X23, X2, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X16, X21, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, D22
    MOVZ  X21, #0xc, LSL #0
    MOVK  X21, #0x1, LSL #16
    MOVK  X21, #0x4c, LSL #32
    SUB  X16, X21, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V23.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D23
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, D24
    MOVZ  X27, #0xfff3, LSL #0
    MOVK  X27, #0xfff2, LSL #16
    MOVK  X27, #0xfff3, LSL #32
    MOVK  X27, #0xfff3, LSL #48
    SUB  X20, X27, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, D25
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, D26
    MOVZ  X29, #0x88bf, LSL #0
    SUB  X8, X29, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, V27.D[1]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X9, X26, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, D27
    MOVZ  X26, #0xfff4, LSL #0
    MOVK  X26, #0xfffe, LSL #16
    MOVK  X26, #0xffb3, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X9, X26, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X9, X20, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, D28
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    SUB  X9, X20, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x4000, LSL #16
    SUB  X14, X17, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, D29
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
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
    FMOV  D0, X20
    FMOV  V0.D[1], X18
    FMOV  D1, X23
    FMOV  V1.D[1], X18
    FMOV  D2, X17
    FMOV  V2.D[1], X15
    FMOV  D3, X17
    FMOV  V3.D[1], X19
    FMOV  D4, X3
    FMOV  V4.D[1], X24
    FMOV  D5, X16
    FMOV  V5.D[1], X4
    FMOV  D6, X8
    FMOV  V6.D[1], X24
    FMOV  D7, X12
    FMOV  V7.D[1], X6
    FMOV  D8, X27
    FMOV  V8.D[1], X7
    FMOV  D9, X3
    FMOV  V9.D[1], X17
    FMOV  D10, X9
    FMOV  V10.D[1], X28
    FMOV  D11, X2
    FMOV  V11.D[1], X17
    FMOV  D12, X9
    FMOV  V12.D[1], X10
    FMOV  D13, X12
    FMOV  V13.D[1], X28
    FMOV  D14, X10
    FMOV  V14.D[1], X16
    FMOV  D15, X4
    FMOV  V15.D[1], X18
    FMOV  D16, X8
    FMOV  V16.D[1], X19
    FMOV  D17, X18
    FMOV  V17.D[1], X7
    FMOV  D18, X9
    FMOV  V18.D[1], X14
    FMOV  D19, X6
    FMOV  V19.D[1], X20
    FMOV  D20, X15
    FMOV  V20.D[1], X9
    FMOV  D21, X28
    FMOV  V21.D[1], X14
    FMOV  D22, X15
    FMOV  V22.D[1], X3
    FMOV  D23, X5
    FMOV  V23.D[1], X19
    FMOV  D24, X6
    FMOV  V24.D[1], X28
    FMOV  D25, X6
    FMOV  V25.D[1], X9
    FMOV  D26, X23
    FMOV  V26.D[1], X18
    FMOV  D27, X6
    FMOV  V27.D[1], X5
    FMOV  D28, X5
    FMOV  V28.D[1], X18
    FMOV  D29, X10
    FMOV  V29.D[1], X9
    FMOV  D30, X6
    FMOV  V30.D[1], X3
    FMOV  D31, X18
    FMOV  V31.D[1], X4
    MOVZ  X7, #0xa, LSL #0
TaishanSimdFpIntConversionP01_label_83:
    XTN2  V22.8H, V30.4S
    UQXTN  V19.2S, V29.2D
    SUQADD  B9, B19
    ABS  V0.8H, V15.8H
    FRINTI  V3.2S, V18.2S
    SUQADD  B30, B23
    USQADD  V28.2S, V23.2S
    NEG  D16, D1
    FSQRT  V4.2D, V28.2D
    ABS  D9, D2
    UQXTN  B19, H1
    SQNEG  V27.2S, V26.2S
    FRSQRTE  S21, S3
    REV16  V25.16B, V20.16B
    UADDLP  V25.4S, V19.8H
    FRSQRTE  D16, D4
    FNEG  V0.4S, V4.4S
    FRINTM  V19.4S, V19.4S
    SQNEG  H16, H29
    URECPE  V17.4S, V17.4S
    UXTL V18.2D, V22.2S
    FRINTI  V17.2D, V30.2D
    SQXTN  B3, H31
    SQNEG  B26, B23
    REV32  V26.8B, V23.8B
    SQXTUN  H25, S31
    FRECPX  D9, D23
    UQXTN  H21, S13
    FRECPS  V6.4S, V21.4S, V3.4S
    NOT  V25.8B, V19.8B
    FRINTI  V6.2S, V3.2S
    FRINTM  V11.2D, V26.2D
    SUQADD  V0.16B, V28.16B
    SQXTN  S28, D10
    RBIT  V20.16B, V13.16B
    CNT  V17.16B, V3.16B
    FRINTI  V0.2S, V22.2S
    SQXTN  S2, D25
    USQADD  D18, D25
    UXTL V29.2D, V8.2S
    SQXTN  B24, H4
    SQXTN  S9, D24
    SQXTN  V18.2S, V7.2D
    SQNEG  S3, S31
    SQXTN  B23, H28
    FRSQRTE  D19, D14
    FRINTZ  V25.4S, V30.4S
    USQADD  H6, H18
    SQXTN2  V30.4S, V13.2D
    SUQADD  S24, S4
    SXTL V18.8H, V24.8B
    NEG  V23.8H, V21.8H
    SUQADD  S4, S7
    UQXTN  H29, S24
    SXTL V13.4S, V12.4H
    SUQADD  H19, H18
    FRINTZ  V16.4S, V12.4S
    UQXTN2  V6.16B, V2.8H
    USQADD  D23, D6
    ABS  D9, D20
    UQXTN  H16, S25
    URSQRTE  V15.4S, V16.4S
    SQABS  B20, B20
    FRINTM  V23.4S, V1.4S
    ABS  V19.4S, V24.4S
    SUQADD  H14, H25
    SQXTN  S13, D10
    MVN  V30.8B, V14.8B
    SQXTN  H20, S30
    SQXTUN  B18, H19
    FRINTN  V23.2S, V2.2S
    FRECPX  D18, D17
    SXTL2 V1.4S, V7.8H
    FRINTN  V12.4S, V15.4S
    UXTL V29.4S, V16.4H
    UXTL V23.4S, V11.4H
    SQXTN  S23, D24
    SQXTUN  H5, S8
    ABS  D13, D7
    SQXTUN2  V28.4S, V7.2D
    UQXTN  B14, H30
    SADDLP  V21.2D, V11.4S
    FRINTA  V11.4S, V6.4S
    SXTL2 V24.4S, V18.8H
    UQXTN  S6, D29
    SUQADD  H1, H24
    FRINTI  V27.2S, V26.2S
    UQXTN2  V28.4S, V2.2D
    UXTL V21.8H, V20.8B
    UQXTN  H9, S23
    UQXTN  S16, D30
    REV16  V3.16B, V10.16B
    FRECPS  D23, D27, D14
    USQADD  B6, B5
    REV32  V7.16B, V18.16B
    CLZ  V13.16B, V2.16B
    UADALP  V28.4H, V19.8B
    SQNEG  D25, D26
    SXTL2 V25.8H, V9.16B
    XTN  V16.8B, V18.8H
    ABS  V7.8H, V2.8H
    XTN2  V16.4S, V3.2D
    RBIT  V2.16B, V8.16B
    UADALP  V13.4H, V31.8B
    SQXTUN  S21, D13
    UQXTN  V20.8B, V12.8H
    SXTL V20.2D, V1.2S
    NOT  V29.8B, V31.8B
    SQXTN  V5.8B, V11.8H
    SQXTN  B19, H24
    SXTL V27.2D, V16.2S
    CLS  V9.16B, V8.16B
    UQXTN  S8, D6
    FNEG  V3.2S, V2.2S
    FRINTI  V27.2S, V28.2S
    SXTL2 V22.4S, V13.8H
    CNT  V29.8B, V24.8B
    URECPE  V6.2S, V29.2S
    SQXTUN  H22, S18
    FRECPX  S16, S24
    SQXTUN  S24, D8
    SQNEG  D16, D13
    RBIT  V7.8B, V26.8B
    CNT  V7.16B, V8.16B
    SQXTUN  B24, H18
    SUQADD  B27, B24
    UXTL2 V11.8H, V2.16B
    FRSQRTE  V18.2D, V29.2D
    SXTL2 V19.4S, V15.8H
    FCVTXN2  V16.4S, V22.2D
    FRECPS  D22, D15, D4
    UADALP  V4.8H, V0.16B
    FRECPS  V28.2D, V28.2D, V16.2D
    SQNEG  V22.2S, V6.2S
    FRINTZ  V7.4S, V11.4S
    XTN2  V13.8H, V2.4S
    SQXTN  B12, H5
    FCVTXN  S12, D31
    CLS  V17.8H, V0.8H
    NEG  V27.8B, V11.8B
    FCVTXN  S7, D26
    SQXTUN  H24, S7
    FRINTZ  V0.2D, V28.2D
    SQNEG  S18, S31
    UXTL2 V30.2D, V2.4S
    USQADD  D12, D30
    FRINTA  V12.2S, V24.2S
    RBIT  V12.8B, V13.8B
    SQXTUN  B31, H27
    CLS  V12.8B, V28.8B
    FRSQRTE  V27.4S, V4.4S
    SQXTN  V28.8B, V12.8H
    SQNEG  V18.2D, V21.2D
    FRSQRTE  S24, S19
    SQXTUN  H25, S18
    REV16  V7.8B, V31.8B
    SUQADD  D19, D10
    FRSQRTE  D31, D12
    UXTL2 V0.8H, V12.16B
    FRINTN  V17.2S, V19.2S
    SUQADD  B27, B26
    USQADD  D2, D28
    FRINTX  V24.2D, V2.2D
    UQXTN  H24, S13
    SXTL2 V31.4S, V3.8H
    SUQADD  D31, D17
    SQNEG  V14.2S, V31.2S
    FCVTXN  S8, D14
    URSQRTE  V7.2S, V8.2S
    SXTL V11.8H, V5.8B
    NOT  V28.8B, V25.8B
    RBIT  V19.8B, V14.8B
    USQADD  V24.2S, V2.2S
    FCVTXN  S19, D10
    XTN2  V19.4S, V25.2D
    SQXTN2  V21.16B, V0.8H
    FRINTM  V18.4S, V7.4S
    FRSQRTE  D24, D18
    SQNEG  V26.2S, V30.2S
    UXTL2 V27.4S, V10.8H
    FRINTM  V23.2S, V19.2S
    UXTL V10.4S, V31.4H
    FRSQRTE  V0.2S, V27.2S
    FRSQRTE  D0, D28
    FRECPS  V21.2S, V21.2S, V5.2S
    SADALP  V14.2S, V17.4H
    FABS  V28.2S, V9.2S
    SADALP  V22.8H, V18.16B
    FCVTXN  S10, D23
    UQXTN  V16.8B, V30.8H
    FRECPX  S23, S19
    USQADD  V27.16B, V26.16B
    SQABS  B4, B11
    UQXTN  H26, S25
    FRECPX  S17, S31
    FRSQRTE  D2, D12
    SQXTUN  S31, D9
    SQXTN  S18, D26
    FRSQRTE  S28, S24
    SQNEG  H29, H20
    SUBS  X7, X7, #0x1
    B.NE  TaishanSimdFpIntConversionP01_label_83
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X2, X22, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X5
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X27, X14, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X20, X4, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X8
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X11, X24, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X19, X20, X11
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X8, X24, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X2, X29, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X17
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X3, X15, X18
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X19
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X20
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X3, X16, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X24
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X26
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X2, X20, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X12, X9, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, V2.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, D2
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x3000, LSL #32
    MOVK  X14, #0x5fe8, LSL #48
    SUB  X18, X14, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, D3
    MOVZ  X16, #0x80, LSL #0
    MOVK  X16, #0x8100, LSL #16
    MOVK  X16, #0x8000, LSL #48
    SUB  X17, X16, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V4.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D4
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, D5
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, V6.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X21
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, D6
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X20, X18, X21
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X9, X17, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, D7
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xb480, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X9, X17, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D8
    MOVZ  X27, #0x1, LSL #0
    MOVK  X27, #0x8000, LSL #16
    SUB  X9, X27, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, V9.D[1]
    MOVZ  X12, #0x707, LSL #0
    MOVK  X12, #0x707, LSL #16
    MOVK  X12, #0x707, LSL #32
    MOVK  X12, #0x707, LSL #48
    SUB  X25, X12, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, D9
    MOVZ  X12, #0x706, LSL #0
    MOVK  X12, #0x7, LSL #16
    MOVK  X12, #0x707, LSL #32
    MOVK  X12, #0x707, LSL #48
    SUB  X25, X12, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, D10
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, D11
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, V12.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X6, X8, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, D12
    MOVZ  X8, #0x706, LSL #0
    MOVK  X8, #0x707, LSL #16
    MOVK  X8, #0x707, LSL #32
    MOVK  X8, #0x7, LSL #48
    SUB  X6, X8, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, D14
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0x7fff, LSL #48
    SUB  X3, X11, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X7, X29, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, D15
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X7, X29, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V16.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X3
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D16
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X3
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, D17
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X4, X26, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, D18
    MOVZ  X17, #0x1, LSL #0
    SUB  X14, X17, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X12, #0x1, LSL #0
    SUB  X21, X12, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, D19
    MOVZ  X12, #0x0, LSL #0
    SUB  X21, X12, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X19, X11, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, D20
    MOVZ  X11, #0x0, LSL #0
    SUB  X19, X11, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, V21.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X24, X14, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, D21
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0x7fff, LSL #16
    MOVK  X14, #0x4000, LSL #48
    SUB  X24, X14, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, D22
    MOVZ  X17, #0x1, LSL #0
    MOVK  X17, #0xff3f, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xfffe, LSL #48
    SUB  X18, X17, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X4, X18, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, D23
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7f00, LSL #16
    SUB  X4, X18, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X16
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, D24
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xbf80, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X3, X11, X16
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X9, X20, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, D25
    MOVZ  X20, #0x1, LSL #0
    SUB  X9, X20, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X25
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, D26
    MOVZ  X16, #0x1, LSL #0
    SUB  X11, X16, X25
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, V27.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X5, X17, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, D27
    MOVZ  X17, #0x0, LSL #0
    SUB  X5, X17, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X23, X27, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, D28
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x7fc0, LSL #16
    SUB  X23, X27, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, V29.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, D29
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
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
    FMOV  V0.D[1], X19
    FMOV  D1, X11
    FMOV  V1.D[1], X22
    FMOV  D2, X26
    FMOV  V2.D[1], X4
    FMOV  D3, X28
    FMOV  V3.D[1], X20
    FMOV  D4, X28
    FMOV  V4.D[1], X26
    FMOV  D5, X27
    FMOV  V5.D[1], X28
    FMOV  D6, X28
    FMOV  V6.D[1], X6
    FMOV  D7, X26
    FMOV  V7.D[1], X24
    FMOV  D8, X19
    FMOV  V8.D[1], X19
    FMOV  D9, X9
    FMOV  V9.D[1], X9
    FMOV  D10, X8
    FMOV  V10.D[1], X6
    FMOV  D11, X25
    FMOV  V11.D[1], X27
    FMOV  D12, X10
    FMOV  V12.D[1], X4
    FMOV  D13, X12
    FMOV  V13.D[1], X11
    FMOV  D14, X18
    FMOV  V14.D[1], X28
    FMOV  D15, X19
    FMOV  V15.D[1], X23
    FMOV  D16, X24
    FMOV  V16.D[1], X9
    FMOV  D17, X26
    FMOV  V17.D[1], X23
    FMOV  D18, X10
    FMOV  V18.D[1], X14
    FMOV  D19, X10
    FMOV  V19.D[1], X18
    FMOV  D20, X26
    FMOV  V20.D[1], X27
    FMOV  D21, X16
    FMOV  V21.D[1], X25
    FMOV  D22, X17
    FMOV  V22.D[1], X29
    FMOV  D23, X26
    FMOV  V23.D[1], X24
    FMOV  D24, X16
    FMOV  V24.D[1], X28
    FMOV  D25, X14
    FMOV  V25.D[1], X3
    FMOV  D26, X15
    FMOV  V26.D[1], X12
    FMOV  D27, X22
    FMOV  V27.D[1], X20
    FMOV  D28, X17
    FMOV  V28.D[1], X10
    FMOV  D29, X5
    FMOV  V29.D[1], X15
    FMOV  D30, X5
    FMOV  V30.D[1], X5
    FMOV  D31, X7
    FMOV  V31.D[1], X28
    MOVZ  X19, #0xf, LSL #0
TaishanSimdFpIntConversionP01_label_164:
    SQABS  D21, D23
    FRECPX  S18, S6
    URSQRTE  V27.4S, V16.4S
    SQXTN  S0, D26
    REV16  V30.16B, V30.16B
    MVN  V23.8B, V7.8B
    UQXTN  S25, D19
    UADDLP  V24.4S, V14.8H
    USQADD  B9, B24
    RBIT  V17.16B, V11.16B
    SXTL2 V24.4S, V0.8H
    FRSQRTE  V9.2S, V25.2S
    SQXTUN2  V13.16B, V16.8H
    XTN  V21.4H, V23.4S
    FRECPX  S10, S20
    FRECPS  S29, S9, S22
    SXTL2 V27.8H, V13.16B
    FRECPS  V7.2S, V27.2S, V8.2S
    FRINTA  V9.2D, V9.2D
    FRINTZ  V6.4S, V8.4S
    URECPE  V16.2S, V18.2S
    UADALP  V25.1D, V14.2S
    FABS  V4.2D, V28.2D
    REV64  V27.8B, V13.8B
    NEG  D21, D30
    SQNEG  H6, H21
    UXTL V16.4S, V0.4H
    FRECPS  D12, D13, D13
    USQADD  D9, D9
    SQABS  H26, H13
    FRECPS  D24, D23, D10
    UXTL V16.4S, V1.4H
    SQXTUN  B16, H1
    RBIT  V3.8B, V7.8B
    SQNEG  D0, D22
    UADDLP  V20.8H, V29.16B
    SQNEG  B29, B16
    SQXTN  B2, H11
    UQXTN  S4, D24
    CLZ  V1.16B, V2.16B
    SXTL V18.8H, V2.8B
    NEG  V27.4S, V19.4S
    XTN2  V18.16B, V6.8H
    SQABS  V26.2S, V10.2S
    RBIT  V24.16B, V3.16B
    REV64  V2.8H, V11.8H
    FRECPS  V11.2S, V10.2S, V8.2S
    FCVTXN  S14, D4
    SXTL V6.4S, V19.4H
    FRECPX  D27, D24
    FRINTA  V19.4S, V24.4S
    FRSQRTE  S1, S11
    SUQADD  B30, B14
    SQXTUN  S30, D17
    SQNEG  S5, S30
    URSQRTE  V1.2S, V26.2S
    SUQADD  H13, H28
    SQXTUN2  V2.16B, V28.8H
    USQADD  V5.8H, V18.8H
    SQABS  S10, S1
    CLS  V15.4S, V29.4S
    SQABS  V22.8H, V11.8H
    USQADD  V5.16B, V29.16B
    SQNEG  S22, S30
    SQNEG  V5.16B, V13.16B
    FRINTA  V19.4S, V3.4S
    FRINTI  V20.4S, V25.4S
    UXTL V26.8H, V11.8B
    FSQRT  V7.4S, V0.4S
    RBIT  V22.16B, V27.16B
    SQXTN  V7.8B, V19.8H
    SQNEG  S0, S29
    FRINTM  V11.2S, V28.2S
    FCVTXN2  V11.4S, V25.2D
    USQADD  V27.2D, V3.2D
    SQABS  S2, S30
    USQADD  V10.16B, V20.16B
    CNT  V15.16B, V13.16B
    XTN2  V10.8H, V0.4S
    FRINTN  V30.2D, V14.2D
    FCVTXN  S1, D0
    SXTL V29.8H, V27.8B
    FCVTXN2  V19.4S, V10.2D
    FSQRT  V25.2S, V0.2S
    URSQRTE  V2.4S, V3.4S
    SQABS  V14.2D, V26.2D
    UXTL V19.2D, V4.2S
    SQABS  V5.2D, V1.2D
    SUQADD  V9.4S, V17.4S
    UQXTN  V28.2S, V2.2D
    FRINTM  V30.4S, V17.4S
    SQABS  H17, H13
    NEG  D9, D16
    SQXTN2  V24.4S, V1.2D
    SXTL2 V3.4S, V28.8H
    UXTL V9.2D, V9.2S
    URSQRTE  V1.2S, V29.2S
    NEG  V26.4S, V20.4S
    UXTL2 V28.4S, V2.8H
    UQXTN  H12, S6
    SXTL2 V4.2D, V7.4S
    FRECPS  S9, S19, S14
    SUQADD  V11.2D, V22.2D
    UXTL V14.4S, V16.4H
    UXTL2 V25.4S, V10.8H
    CNT  V11.16B, V12.16B
    ABS  V21.4H, V31.4H
    UADALP  V11.1D, V20.2S
    UQXTN  S26, D19
    FRINTZ  V24.2S, V3.2S
    CLZ  V13.16B, V29.16B
    SQXTN  B5, H11
    SXTL V17.8H, V4.8B
    SUQADD  H8, H17
    SQABS  V23.4S, V30.4S
    SQXTN  B21, H29
    SQNEG  D14, D0
    UXTL2 V12.8H, V30.16B
    UQXTN  B6, H8
    SUQADD  V4.2S, V0.2S
    UXTL V28.4S, V26.4H
    SQABS  V30.8B, V12.8B
    SQNEG  V12.16B, V19.16B
    SQNEG  H26, H20
    USQADD  D1, D1
    UQXTN  V16.2S, V27.2D
    UXTL2 V6.4S, V6.8H
    UXTL2 V1.4S, V3.8H
    ABS  D27, D27
    FRINTP  V14.2D, V11.2D
    XTN2  V3.16B, V13.8H
    FRINTA  V26.2S, V24.2S
    SQXTUN  H9, S0
    FCVTXN  V4.2S, V17.2D
    SQXTUN  B22, H16
    FCVTXN  V8.2S, V21.2D
    FRSQRTE  D26, D20
    SQXTN  B4, H22
    SQNEG  S3, S16
    FSQRT  V29.2S, V26.2S
    USQADD  D0, D30
    SUQADD  H1, H23
    UXTL V3.4S, V7.4H
    SQXTUN2  V27.8H, V31.4S
    REV64  V0.8B, V18.8B
    UXTL2 V14.8H, V20.16B
    UXTL2 V23.2D, V27.4S
    UXTL2 V18.8H, V21.16B
    SXTL2 V28.4S, V7.8H
    UADALP  V17.1D, V8.2S
    SXTL V20.2D, V16.2S
    UXTL2 V25.8H, V7.16B
    UXTL V30.8H, V14.8B
    UQXTN  S11, D1
    FRINTZ  V17.2S, V19.2S
    UQXTN  V2.8B, V29.8H
    SQXTN2  V15.4S, V31.2D
    FRINTZ  V4.2D, V4.2D
    FRINTA  V3.2D, V0.2D
    SQXTUN  B25, H28
    CLS  V19.4S, V26.4S
    CLS  V18.8B, V31.8B
    SUQADD  V14.16B, V30.16B
    SXTL2 V16.8H, V16.16B
    USQADD  B6, B20
    UQXTN  H0, S11
    FCVTXN2  V8.4S, V22.2D
    FRINTN  V5.2D, V3.2D
    SQXTUN  H15, S18
    UQXTN2  V27.8H, V18.4S
    NOT  V21.8B, V30.8B
    SADDLP  V15.8H, V28.16B
    FRINTX  V18.4S, V30.4S
    FRECPX  D12, D0
    SQXTUN  V28.4H, V17.4S
    REV64  V23.16B, V23.16B
    FRSQRTE  D26, D17
    SXTL2 V8.2D, V24.4S
    SQABS  V24.4H, V20.4H
    USQADD  V31.4S, V19.4S
    CLS  V20.2S, V5.2S
    FRINTP  V12.2D, V3.2D
    USQADD  H12, H11
    NEG  V12.8B, V17.8B
    SQNEG  H22, H22
    SUQADD  B22, B18
    SXTL2 V11.2D, V23.4S
    UADALP  V28.4S, V20.8H
    CNT  V12.8B, V19.8B
    SQABS  H19, H30
    ABS  D24, D2
    FRECPX  D0, D15
    CNT  V31.16B, V8.16B
    FRINTX  V16.2D, V31.2D
    SADDLP  V27.1D, V23.2S
    SQABS  H0, H5
    FRECPS  D16, D12, D26
    REV16  V11.8B, V4.8B
    SQXTN  S24, D11
    NEG  V2.8B, V30.8B
    SUBS  X19, X19, #0x1
    B.NE  TaishanSimdFpIntConversionP01_label_164
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X14, X28, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X29, X11, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X4, X6, X4
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X19, X20, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X24, X5, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X9, X21, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X21, X16, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X14, X26, X11
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X6, X26, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X14
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X16, X14, X16
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X10, X26, X17
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X25, X10, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X14, X24, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X22
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X29, X24, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
TaishanSimdFpIntConversionP01_label_148:
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X27, X10, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X22, X17, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X20, X3, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X27
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X14, X29, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X22, X23, X29
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, D2
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, D3
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, V4.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, D4
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, V5.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, D5
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, D6
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, V7.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X26, X19, X25
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, D7
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x8000, LSL #16
    SUB  X26, X19, X25
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, D8
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, V9.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, D9
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, V10.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X19
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, D10
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x4a80, LSL #16
    SUB  X26, X25, X19
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, D11
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X28, X22, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, D12
    MOVZ  X22, #0x5, LSL #0
    SUB  X28, X22, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, V14.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, D14
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X22, X21, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, D15
    MOVZ  X21, #0x0, LSL #0
    SUB  X22, X21, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, D16
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x4000, LSL #48
    SUB  X15, X21, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, V17.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, D17
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X12, X18, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, D18
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, D19
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, D20
    MOVZ  X25, #0x1f, LSL #0
    MOVK  X25, #0x1f, LSL #32
    SUB  X26, X25, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, D21
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X28, X12, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X19
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, D22
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X19
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, D23
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, D24
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X18, V25.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X18, D25
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X23, X21, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, D26
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x6080, LSL #48
    SUB  X23, X21, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, D27
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, D28
    MOVZ  X3, #0x1f, LSL #0
    MOVK  X3, #0x1f, LSL #32
    SUB  X4, X3, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, V29.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X17, X14, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, D29
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x7ff0, LSL #48
    SUB  X17, X14, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X2, #0xad36, LSL #0
    MOVK  X2, #0x19d9, LSL #16
    MOVK  X2, #0xc349, LSL #32
    MOVK  X2, #0xd3a, LSL #48
    MOVZ  X3, #0x6cf1, LSL #0
    MOVK  X3, #0xdc56, LSL #16
    MOVK  X3, #0x7518, LSL #32
    MOVK  X3, #0xec6b, LSL #48
    MOVZ  X4, #0xe7b9, LSL #0
    MOVK  X4, #0x7ab2, LSL #16
    MOVK  X4, #0xa7f5, LSL #32
    MOVK  X4, #0xe000, LSL #48
    MOVZ  X5, #0xe0a6, LSL #0
    MOVK  X5, #0xc339, LSL #16
    MOVK  X5, #0xdd9b, LSL #32
    MOVK  X5, #0x2a2e, LSL #48
    MOVZ  X6, #0x8650, LSL #0
    MOVK  X6, #0x6c81, LSL #16
    MOVK  X6, #0x582e, LSL #32
    MOVK  X6, #0x195a, LSL #48
    MOVZ  X7, #0x8b96, LSL #0
    MOVK  X7, #0xf937, LSL #16
    MOVK  X7, #0x119, LSL #32
    MOVK  X7, #0x15d2, LSL #48
    MOVZ  X8, #0xd603, LSL #0
    MOVK  X8, #0xf894, LSL #16
    MOVK  X8, #0x7e57, LSL #32
    MOVK  X8, #0x1bd2, LSL #48
    MOVZ  X9, #0x7ee4, LSL #0
    MOVK  X9, #0xa788, LSL #16
    MOVK  X9, #0xc208, LSL #32
    MOVK  X9, #0xaeb2, LSL #48
    MOVZ  X10, #0x232b, LSL #0
    MOVK  X10, #0x7ff4, LSL #16
    MOVK  X10, #0xe0d8, LSL #32
    MOVK  X10, #0x829a, LSL #48
    MOVZ  X11, #0xca9c, LSL #0
    MOVK  X11, #0x327, LSL #16
    MOVK  X11, #0x857c, LSL #32
    MOVK  X11, #0x8683, LSL #48
    MOVZ  X12, #0x3ac6, LSL #0
    MOVK  X12, #0x1980, LSL #16
    MOVK  X12, #0x9bbf, LSL #32
    MOVK  X12, #0xf901, LSL #48
    MOVZ  X14, #0xe2ce, LSL #0
    MOVK  X14, #0x8fb0, LSL #16
    MOVK  X14, #0x219e, LSL #32
    MOVK  X14, #0x12c4, LSL #48
    MOVZ  X15, #0x70bd, LSL #0
    MOVK  X15, #0x96ed, LSL #16
    MOVK  X15, #0x3905, LSL #32
    MOVK  X15, #0x6c7d, LSL #48
    MOVZ  X16, #0x20b3, LSL #0
    MOVK  X16, #0x671d, LSL #16
    MOVK  X16, #0xf5d5, LSL #32
    MOVK  X16, #0xf0bd, LSL #48
    MOVZ  X17, #0x285f, LSL #0
    MOVK  X17, #0xfebe, LSL #16
    MOVK  X17, #0x6df4, LSL #32
    MOVK  X17, #0xe3da, LSL #48
    MOVZ  X18, #0xd97f, LSL #0
    MOVK  X18, #0xe4f3, LSL #16
    MOVK  X18, #0x1c8a, LSL #32
    MOVK  X18, #0xf550, LSL #48
    MOVZ  X19, #0x81f2, LSL #0
    MOVK  X19, #0x784e, LSL #16
    MOVK  X19, #0x8e78, LSL #32
    MOVK  X19, #0x4853, LSL #48
    MOVZ  X20, #0x4fdc, LSL #0
    MOVK  X20, #0xd4a4, LSL #16
    MOVK  X20, #0xa34c, LSL #32
    MOVK  X20, #0xaf1a, LSL #48
    MOVZ  X21, #0xdf96, LSL #0
    MOVK  X21, #0x39e4, LSL #16
    MOVK  X21, #0x20a7, LSL #32
    MOVK  X21, #0xbcc9, LSL #48
    MOVZ  X22, #0x4222, LSL #0
    MOVK  X22, #0xb6ad, LSL #16
    MOVK  X22, #0xaa8d, LSL #32
    MOVK  X22, #0x54bd, LSL #48
    MOVZ  X23, #0xbe73, LSL #0
    MOVK  X23, #0x2c21, LSL #16
    MOVK  X23, #0x1f4c, LSL #32
    MOVK  X23, #0xde4e, LSL #48
    MOVZ  X24, #0xfe1, LSL #0
    MOVK  X24, #0x4239, LSL #16
    MOVK  X24, #0x84af, LSL #32
    MOVK  X24, #0x6ad2, LSL #48
    MOVZ  X25, #0xc66b, LSL #0
    MOVK  X25, #0x4bd5, LSL #16
    MOVK  X25, #0x887b, LSL #32
    MOVK  X25, #0xe353, LSL #48
    MOVZ  X26, #0x76ca, LSL #0
    MOVK  X26, #0x648b, LSL #16
    MOVK  X26, #0xeb10, LSL #32
    MOVK  X26, #0x7a64, LSL #48
    MOVZ  X27, #0xfa99, LSL #0
    MOVK  X27, #0xd28c, LSL #16
    MOVK  X27, #0xef57, LSL #32
    MOVK  X27, #0x1297, LSL #48
    MOVZ  X28, #0xe2d0, LSL #0
    MOVK  X28, #0xab79, LSL #16
    MOVK  X28, #0x16ab, LSL #32
    MOVK  X28, #0xf7ea, LSL #48
    MOVZ  X29, #0xf362, LSL #0
    MOVK  X29, #0x52b1, LSL #16
    MOVK  X29, #0x59c1, LSL #32
    MOVK  X29, #0x4a37, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X20
    FMOV  D1, X23
    FMOV  V1.D[1], X28
    FMOV  D2, X29
    FMOV  V2.D[1], X3
    FMOV  D3, X3
    FMOV  V3.D[1], X4
    FMOV  D4, X8
    FMOV  V4.D[1], X28
    FMOV  D5, X25
    FMOV  V5.D[1], X26
    FMOV  D6, X5
    FMOV  V6.D[1], X15
    FMOV  D7, X15
    FMOV  V7.D[1], X29
    FMOV  D8, X22
    FMOV  V8.D[1], X9
    FMOV  D9, X24
    FMOV  V9.D[1], X8
    FMOV  D10, X20
    FMOV  V10.D[1], X14
    FMOV  D11, X3
    FMOV  V11.D[1], X21
    FMOV  D12, X21
    FMOV  V12.D[1], X25
    FMOV  D13, X12
    FMOV  V13.D[1], X6
    FMOV  D14, X12
    FMOV  V14.D[1], X11
    FMOV  D15, X9
    FMOV  V15.D[1], X8
    FMOV  D16, X7
    FMOV  V16.D[1], X16
    FMOV  D17, X8
    FMOV  V17.D[1], X28
    FMOV  D18, X14
    FMOV  V18.D[1], X29
    FMOV  D19, X22
    FMOV  V19.D[1], X10
    FMOV  D20, X7
    FMOV  V20.D[1], X28
    FMOV  D21, X14
    FMOV  V21.D[1], X9
    FMOV  D22, X22
    FMOV  V22.D[1], X12
    FMOV  D23, X15
    FMOV  V23.D[1], X4
    FMOV  D24, X20
    FMOV  V24.D[1], X27
    FMOV  D25, X12
    FMOV  V25.D[1], X9
    FMOV  D26, X27
    FMOV  V26.D[1], X23
    FMOV  D27, X22
    FMOV  V27.D[1], X3
    FMOV  D28, X28
    FMOV  V28.D[1], X24
    FMOV  D29, X4
    FMOV  V29.D[1], X9
    FMOV  D30, X28
    FMOV  V30.D[1], X27
    FMOV  D31, X18
    FMOV  V31.D[1], X18
    MOVZ  X17, #0xa, LSL #0
TaishanSimdFpIntConversionP01_label_244:
    SQXTN  V18.2S, V30.2D
    SQXTN  V6.2S, V14.2D
    USQADD  D29, D12
    SQABS  H8, H28
    FRSQRTE  V30.4S, V17.4S
    NOT  V0.8B, V1.8B
    SQABS  H18, H6
    SQABS  S7, S31
    SQNEG  V29.2D, V29.2D
    SUQADD  S30, S13
    UXTL2 V8.8H, V8.16B
    REV64  V8.4H, V21.4H
    SQABS  V4.16B, V4.16B
    FCVTXN2  V26.4S, V21.2D
    FRECPS  V4.2D, V24.2D, V18.2D
    CLZ  V6.8B, V13.8B
    SQNEG  D0, D27
    SXTL V0.2D, V17.2S
    UXTL V0.2D, V10.2S
    FRINTP  V29.2D, V8.2D
    FSQRT  V24.2S, V4.2S
    SXTL V7.2D, V1.2S
    FRINTM  V16.4S, V24.4S
    SQABS  D14, D16
    CLZ  V23.8B, V6.8B
    FRSQRTE  S0, S14
    FRECPX  S26, S9
    SQXTUN2  V0.16B, V31.8H
    SXTL2 V8.2D, V5.4S
    SADALP  V27.2S, V12.4H
    FNEG  V27.2D, V8.2D
    XTN  V12.4H, V26.4S
    UADDLP  V10.4S, V21.8H
    UXTL V0.2D, V27.2S
    FRECPS  D1, D21, D10
    SQABS  H8, H29
    XTN  V12.4H, V0.4S
    FCVTXN2  V5.4S, V16.2D
    SQXTN2  V17.16B, V16.8H
    SQABS  S5, S13
    URSQRTE  V7.2S, V23.2S
    SXTL V12.2D, V17.2S
    UADALP  V1.2S, V23.4H
    FRINTZ  V7.2S, V2.2S
    FNEG  V31.2D, V30.2D
    FRECPS  V24.2S, V7.2S, V7.2S
    SQXTN2  V31.8H, V17.4S
    USQADD  S21, S10
    SQXTUN  V25.8B, V25.8H
    FRECPX  D11, D18
    ABS  V28.16B, V19.16B
    UQXTN  H13, S5
    REV32  V29.16B, V30.16B
    MVN  V26.8B, V1.8B
    SQXTN2  V26.8H, V8.4S
    SQABS  V7.16B, V29.16B
    UXTL2 V19.4S, V24.8H
    FCVTXN  S29, D23
    SXTL V12.8H, V18.8B
    ABS  D7, D19
    UXTL V21.8H, V13.8B
    CNT  V11.16B, V20.16B
    FRSQRTE  S18, S5
    SQABS  S30, S17
    MVN  V31.8B, V12.8B
    REV64  V18.8H, V30.8H
    FSQRT  V12.4S, V18.4S
    UXTL2 V20.8H, V23.16B
    SQABS  V24.4S, V30.4S
    FRSQRTE  D5, D9
    UXTL V12.4S, V17.4H
    FRSQRTE  D30, D27
    NOT  V15.16B, V0.16B
    FRECPS  D17, D0, D13
    ABS  D0, D23
    FCVTXN2  V27.4S, V12.2D
    UXTL V24.2D, V8.2S
    REV64  V16.2S, V13.2S
    RBIT  V25.16B, V31.16B
    FABS  V30.2D, V14.2D
    SQNEG  H11, H31
    FRSQRTE  S6, S13
    SQABS  B13, B4
    FRSQRTE  S5, S25
    SQNEG  V26.8H, V20.8H
    UQXTN  B16, H29
    UQXTN  V17.2S, V30.2D
    FRECPS  S10, S26, S25
    SQNEG  B13, B3
    SQXTN2  V14.4S, V31.2D
    XTN2  V4.4S, V24.2D
    SQABS  V27.4S, V13.4S
    UADDLP  V18.2S, V28.4H
    SQNEG  D15, D3
    FRECPS  D0, D21, D24
    NEG  D16, D13
    SQXTN  H20, S18
    UADDLP  V9.4H, V0.8B
    SQABS  S21, S20
    FRINTX  V18.4S, V17.4S
    FRECPS  D15, D10, D0
    SUQADD  B3, B23
    SQXTUN  V16.2S, V31.2D
    SQNEG  B3, B13
    SQXTN  S20, D3
    FCVTXN  S7, D22
    SXTL2 V14.4S, V0.8H
    SADDLP  V26.1D, V13.2S
    SQNEG  S25, S25
    SADDLP  V23.2D, V17.4S
    MVN  V0.16B, V3.16B
    SQXTUN  S14, D6
    SQNEG  H29, H8
    FRECPX  D15, D5
    FRINTM  V30.4S, V7.4S
    SQXTN2  V19.4S, V20.2D
    NEG  V6.2S, V16.2S
    UXTL V19.2D, V10.2S
    FRINTX  V23.4S, V5.4S
    UXTL V19.8H, V24.8B
    NEG  D19, D10
    FRINTM  V14.4S, V28.4S
    FCVTXN2  V6.4S, V4.2D
    UXTL V13.2D, V6.2S
    SXTL V13.4S, V6.4H
    SQXTUN  B20, H14
    XTN  V30.8B, V6.8H
    FRSQRTE  V13.2D, V7.2D
    SQXTN  H3, S5
    UQXTN2  V13.8H, V4.4S
    FRINTN  V4.4S, V30.4S
    CLS  V24.16B, V24.16B
    FRECPS  V23.2D, V9.2D, V16.2D
    SQABS  D6, D11
    SUQADD  H5, H11
    USQADD  D8, D2
    FRINTN  V25.4S, V30.4S
    URSQRTE  V13.2S, V11.2S
    SADDLP  V13.8H, V22.16B
    FRECPX  D5, D7
    SXTL V26.8H, V9.8B
    SQXTUN  B20, H28
    FRECPX  D16, D24
    SXTL2 V26.2D, V23.4S
    CLS  V9.8B, V11.8B
    SQABS  D18, D14
    UXTL V25.8H, V2.8B
    FNEG  V10.2D, V12.2D
    URECPE  V28.2S, V13.2S
    UXTL2 V6.2D, V15.4S
    FRSQRTE  V22.2D, V12.2D
    UADALP  V0.4H, V24.8B
    UADALP  V6.8H, V16.16B
    FNEG  V22.4S, V21.4S
    FRINTN  V25.2S, V23.2S
    SUQADD  S4, S16
    UQXTN  V30.4H, V28.4S
    SXTL2 V12.2D, V0.4S
    SQXTUN  V5.8B, V17.8H
    SXTL2 V14.4S, V14.8H
    UXTL V14.2D, V17.2S
    SQXTN  V11.2S, V25.2D
    UQXTN  H12, S30
    CNT  V9.16B, V17.16B
    FRSQRTE  D0, D18
    UXTL V4.8H, V11.8B
    UQXTN  B2, H22
    ABS  V8.16B, V16.16B
    MVN  V16.16B, V31.16B
    SQXTUN  H30, S28
    UADDLP  V9.1D, V13.2S
    FRSQRTE  V5.2D, V31.2D
    SQNEG  V2.2D, V22.2D
    FCVTXN  V9.2S, V15.2D
    SQXTN  V3.8B, V9.8H
    FRECPS  V4.2S, V8.2S, V4.2S
    SQXTUN  S6, D11
    SQXTUN  S28, D10
    SQXTN2  V13.16B, V1.8H
    FNEG  V8.4S, V21.4S
    SADALP  V27.1D, V16.2S
    UQXTN  V31.4H, V22.4S
    SQNEG  H9, H12
    SQABS  B21, B0
    SQNEG  S1, S5
    FCVTXN  V14.2S, V31.2D
    SADDLP  V30.2S, V27.4H
    SQABS  V18.16B, V28.16B
    SUQADD  D1, D23
    ABS  D8, D24
    XTN  V24.2S, V25.2D
    FRECPS  D1, D1, D3
    CLZ  V3.8H, V4.8H
    SXTL V11.8H, V20.8B
    SXTL2 V31.4S, V31.8H
    NOT  V8.8B, V6.8B
    NOT  V31.8B, V6.8B
    ABS  V21.8H, V11.8H
    SXTL2 V3.4S, V13.8H
    SXTL V14.8H, V28.8B
    SUBS  X17, X17, #0x1
    B.NE  TaishanSimdFpIntConversionP01_label_244
    MOVZ  X26, #0xad36, LSL #0
    MOVK  X26, #0x19d9, LSL #16
    MOVK  X26, #0xc349, LSL #32
    MOVK  X26, #0xd3a, LSL #48
    SUB  X23, X26, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X29, #0x6cf1, LSL #0
    MOVK  X29, #0xdc56, LSL #16
    MOVK  X29, #0x7518, LSL #32
    MOVK  X29, #0xec6b, LSL #48
    SUB  X6, X29, X3
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X14, #0xe7b9, LSL #0
    MOVK  X14, #0x7ab2, LSL #16
    MOVK  X14, #0xa7f5, LSL #32
    MOVK  X14, #0xe000, LSL #48
    SUB  X16, X14, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X24, #0xe0a6, LSL #0
    MOVK  X24, #0xc339, LSL #16
    MOVK  X24, #0xdd9b, LSL #32
    MOVK  X24, #0x2a2e, LSL #48
    SUB  X25, X24, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X10, #0x8b96, LSL #0
    MOVK  X10, #0xf937, LSL #16
    MOVK  X10, #0x119, LSL #32
    MOVK  X10, #0x15d2, LSL #48
    SUB  X17, X10, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0xd603, LSL #0
    MOVK  X4, #0xf894, LSL #16
    MOVK  X4, #0x7e57, LSL #32
    MOVK  X4, #0x1bd2, LSL #48
    SUB  X29, X4, X8
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X29, X11, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X9, #0x8b96, LSL #0
    MOVK  X9, #0xf937, LSL #16
    MOVK  X9, #0x119, LSL #32
    MOVK  X9, #0x15d2, LSL #48
    SUB  X15, X9, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X29, #0x3ac6, LSL #0
    MOVK  X29, #0x1980, LSL #16
    MOVK  X29, #0x9bbf, LSL #32
    MOVK  X29, #0xf901, LSL #48
    SUB  X3, X29, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0xe7b9, LSL #0
    MOVK  X4, #0x7ab2, LSL #16
    MOVK  X4, #0xa7f5, LSL #32
    MOVK  X4, #0xe000, LSL #48
    SUB  X7, X4, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X20, X4, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X17
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X15, #0xd97f, LSL #0
    MOVK  X15, #0xe4f3, LSL #16
    MOVK  X15, #0x1c8a, LSL #32
    MOVK  X15, #0xf550, LSL #48
    SUB  X21, X15, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X21, #0x81f2, LSL #0
    MOVK  X21, #0x784e, LSL #16
    MOVK  X21, #0x8e78, LSL #32
    MOVK  X21, #0x4853, LSL #48
    SUB  X8, X21, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X10, #0x81f2, LSL #0
    MOVK  X10, #0x784e, LSL #16
    MOVK  X10, #0x8e78, LSL #32
    MOVK  X10, #0x4853, LSL #48
    SUB  X4, X10, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X20, #0x4222, LSL #0
    MOVK  X20, #0xb6ad, LSL #16
    MOVK  X20, #0xaa8d, LSL #32
    MOVK  X20, #0x54bd, LSL #48
    SUB  X12, X20, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X3, X20, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X7, #0xe0a6, LSL #0
    MOVK  X7, #0xc339, LSL #16
    MOVK  X7, #0xdd9b, LSL #32
    MOVK  X7, #0x2a2e, LSL #48
    SUB  X16, X7, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X25, #0xad36, LSL #0
    MOVK  X25, #0x19d9, LSL #16
    MOVK  X25, #0xc349, LSL #32
    MOVK  X25, #0xd3a, LSL #48
    SUB  X5, X25, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X22, #0xfa99, LSL #0
    MOVK  X22, #0xd28c, LSL #16
    MOVK  X22, #0xef57, LSL #32
    MOVK  X22, #0x1297, LSL #48
    SUB  X18, X22, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X28
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X12, #0x3ac6, LSL #0
    MOVK  X12, #0x1980, LSL #16
    MOVK  X12, #0x9bbf, LSL #32
    MOVK  X12, #0xf901, LSL #48
    SUB  X7, X12, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V2.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x8000, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    SUB  X16, X29, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D2
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0x7fff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x7fff, LSL #48
    SUB  X16, X29, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, D3
    MOVZ  X2, #0x7f, LSL #0
    MOVK  X2, #0x7f7f, LSL #32
    SUB  X19, X2, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X17
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, D4
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x4000, LSL #16
    MOVK  X12, #0xfb89, LSL #32
    MOVK  X12, #0x3fff, LSL #48
    SUB  X2, X12, X17
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x7ff0, LSL #48
    SUB  X19, X28, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, D5
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X19, X28, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, V6.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, D6
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0x7fff, LSL #16
    SUB  X24, X26, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D7
    MOVZ  X23, #0x1, LSL #0
    MOVK  X23, #0x8000, LSL #16
    SUB  X20, X23, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X23, X22, X12
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, D8
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x8000, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X23, X22, X12
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, V9.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, D9
    MOVZ  X7, #0x1, LSL #0
    SUB  X16, X7, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, V10.D[1]
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x8000, LSL #48
    SUB  X2, X26, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, D10
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0x8000, LSL #48
    SUB  X2, X26, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, D11
    MOVZ  X4, #0x1, LSL #0
    SUB  X9, X4, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, V12.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X19, X7, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, D12
    MOVZ  X7, #0xffff, LSL #0
    SUB  X19, X7, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, V14.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, D14
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, D15
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x7fe0, LSL #48
    SUB  X5, X24, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X8, X5, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, D16
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, D17
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X14, X9, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, V18.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, D18
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, D19
    MOVZ  X25, #0x1, LSL #0
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X21, X25, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, D20
    MOVZ  X16, #0x1, LSL #0
    SUB  X24, X16, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, V21.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X22, X10, X19
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, D21
    MOVZ  X10, #0x1, LSL #0
    SUB  X22, X10, X19
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x8000, LSL #16
    MOVK  X5, #0x8000, LSL #48
    SUB  X4, X5, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, D22
    MOVZ  X5, #0x1, LSL #0
    MOVK  X5, #0x8000, LSL #16
    MOVK  X5, #0x8000, LSL #48
    SUB  X4, X5, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, V23.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x4000, LSL #48
    SUB  X22, X29, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, D23
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x4000, LSL #48
    SUB  X22, X29, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, D24
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, D25
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x4000, LSL #48
    SUB  X29, X3, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x4000, LSL #16
    SUB  X23, X29, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, D26
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, V27.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, D27
    MOVZ  X5, #0x81, LSL #0
    SUB  X14, X5, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, D28
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, V29.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, D29
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
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
    FMOV  D0, X19
    FMOV  V0.D[1], X20
    FMOV  D1, X15
    FMOV  V1.D[1], X11
    FMOV  D2, X15
    FMOV  V2.D[1], X16
    FMOV  D3, X15
    FMOV  V3.D[1], X12
    FMOV  D4, X26
    FMOV  V4.D[1], X6
    FMOV  D5, X25
    FMOV  V5.D[1], X17
    FMOV  D6, X23
    FMOV  V6.D[1], X16
    FMOV  D7, X21
    FMOV  V7.D[1], X17
    FMOV  D8, X10
    FMOV  V8.D[1], X18
    FMOV  D9, X12
    FMOV  V9.D[1], X24
    FMOV  D10, X15
    FMOV  V10.D[1], X15
    FMOV  D11, X18
    FMOV  V11.D[1], X16
    FMOV  D12, X18
    FMOV  V12.D[1], X7
    FMOV  D13, X27
    FMOV  V13.D[1], X17
    FMOV  D14, X19
    FMOV  V14.D[1], X23
    FMOV  D15, X18
    FMOV  V15.D[1], X5
    FMOV  D16, X21
    FMOV  V16.D[1], X5
    FMOV  D17, X15
    FMOV  V17.D[1], X21
    FMOV  D18, X26
    FMOV  V18.D[1], X23
    FMOV  D19, X18
    FMOV  V19.D[1], X19
    FMOV  D20, X24
    FMOV  V20.D[1], X3
    FMOV  D21, X19
    FMOV  V21.D[1], X20
    FMOV  D22, X16
    FMOV  V22.D[1], X14
    FMOV  D23, X14
    FMOV  V23.D[1], X26
    FMOV  D24, X7
    FMOV  V24.D[1], X21
    FMOV  D25, X16
    FMOV  V25.D[1], X22
    FMOV  D26, X20
    FMOV  V26.D[1], X19
    FMOV  D27, X12
    FMOV  V27.D[1], X2
    FMOV  D28, X2
    FMOV  V28.D[1], X7
    FMOV  D29, X28
    FMOV  V29.D[1], X23
    FMOV  D30, X11
    FMOV  V30.D[1], X17
    FMOV  D31, X28
    FMOV  V31.D[1], X27
    MOVZ  X9, #0xa, LSL #0
TaishanSimdFpIntConversionP01_label_322:
    SQNEG  H20, H9
    NOT  V10.16B, V21.16B
    UXTL2 V27.8H, V19.16B
    USQADD  S18, S27
    FRINTX  V22.4S, V31.4S
    FRINTI  V8.4S, V2.4S
    SQNEG  B6, B17
    SQNEG  D29, D29
    UADDLP  V23.1D, V8.2S
    UXTL2 V20.4S, V30.8H
    UQXTN2  V6.16B, V19.8H
    FRINTZ  V5.4S, V1.4S
    FSQRT  V8.2D, V22.2D
    SUQADD  B17, B1
    FRSQRTE  D29, D28
    SQXTUN2  V7.8H, V23.4S
    SUQADD  D17, D25
    FRECPS  V18.4S, V29.4S, V30.4S
    SQXTN2  V20.16B, V11.8H
    SADALP  V6.4H, V3.8B
    SUQADD  B7, B14
    USQADD  V20.4S, V19.4S
    FRECPS  V21.2D, V29.2D, V12.2D
    SQNEG  S22, S18
    FCVTXN  S18, D11
    CLZ  V18.4H, V16.4H
    RBIT  V16.8B, V6.8B
    UXTL V10.2D, V26.2S
    UQXTN  S8, D29
    FRECPS  D10, D14, D10
    URSQRTE  V23.4S, V22.4S
    UADDLP  V20.2D, V3.4S
    SUQADD  B31, B20
    UQXTN2  V15.4S, V7.2D
    SQABS  H31, H8
    SQXTUN  H0, S25
    SADDLP  V6.8H, V29.16B
    SQXTN  S26, D5
    UADDLP  V8.4H, V15.8B
    SQXTN  B25, H21
    FRINTX  V6.2S, V29.2S
    SQABS  V27.8B, V27.8B
    FRINTM  V27.4S, V14.4S
    ABS  D28, D10
    SQABS  H13, H0
    FRECPS  S12, S4, S26
    UADALP  V4.2S, V7.4H
    FRSQRTE  V25.2D, V0.2D
    SQXTUN  H27, S14
    SXTL V18.8H, V25.8B
    SQXTUN2  V27.4S, V1.2D
    SQNEG  H10, H13
    SQXTUN  V17.8B, V13.8H
    XTN  V10.2S, V7.2D
    CLZ  V0.16B, V30.16B
    UXTL V1.2D, V7.2S
    SADDLP  V31.2D, V10.4S
    FRSQRTE  D10, D3
    FRECPS  D6, D29, D27
    FRECPX  S30, S2
    SXTL2 V4.8H, V6.16B
    REV32  V18.4H, V26.4H
    SXTL V1.4S, V25.4H
    MVN  V25.8B, V25.8B
    FRINTX  V30.2D, V4.2D
    RBIT  V0.16B, V7.16B
    SADDLP  V10.1D, V6.2S
    SXTL V26.4S, V26.4H
    SXTL2 V16.4S, V5.8H
    ABS  D4, D16
    SQABS  B9, B26
    FRECPS  V3.4S, V27.4S, V22.4S
    REV32  V18.4H, V2.4H
    USQADD  B7, B3
    FRINTZ  V4.2S, V18.2S
    URSQRTE  V2.4S, V0.4S
    UXTL2 V25.4S, V2.8H
    FRINTN  V30.4S, V9.4S
    SQNEG  V26.4S, V18.4S
    UXTL2 V1.4S, V10.8H
    ABS  V11.8H, V19.8H
    SQABS  V11.8B, V20.8B
    NEG  D31, D30
    SQNEG  S29, S28
    FCVTXN2  V31.4S, V5.2D
    REV16  V7.8B, V9.8B
    UADDLP  V31.1D, V29.2S
    SQNEG  B5, B4
    FRECPS  S16, S5, S13
    FRINTI  V16.2D, V13.2D
    FNEG  V11.2D, V9.2D
    SQXTUN  B29, H20
    USQADD  H3, H0
    SUQADD  S23, S1
    FRECPS  V27.4S, V13.4S, V13.4S
    USQADD  D16, D10
    FRECPS  D2, D20, D25
    XTN2  V20.16B, V25.8H
    FRINTI  V4.4S, V24.4S
    FRSQRTE  S12, S3
    UQXTN  B19, H23
    FRECPS  D4, D22, D4
    SQNEG  H31, H24
    ABS  V30.4S, V3.4S
    FCVTXN2  V3.4S, V8.2D
    FRSQRTE  S7, S27
    XTN  V1.2S, V20.2D
    SADDLP  V10.2D, V10.4S
    REV16  V18.8B, V13.8B
    FRINTI  V24.2S, V25.2S
    SXTL2 V6.4S, V0.8H
    UQXTN  B12, H1
    USQADD  H27, H25
    UXTL2 V10.8H, V3.16B
    FRECPS  D7, D22, D30
    SQNEG  V6.8B, V19.8B
    USQADD  V16.4S, V2.4S
    FRECPS  S12, S13, S28
    SQXTN  S22, D15
    XTN  V11.4H, V23.4S
    USQADD  D7, D28
    FRECPS  S21, S24, S18
    FRECPS  V22.2S, V24.2S, V16.2S
    UXTL V11.4S, V10.4H
    UXTL V22.4S, V8.4H
    FRSQRTE  V10.2D, V26.2D
    FRINTA  V15.2D, V26.2D
    FABS  V8.2D, V27.2D
    SQXTN  B10, H15
    UQXTN  B4, H20
    ABS  D13, D16
    FRECPS  S14, S10, S16
    CNT  V31.16B, V8.16B
    FRSQRTE  D12, D11
    USQADD  B21, B25
    USQADD  S1, S21
    SADALP  V30.1D, V7.2S
    FRINTM  V27.2D, V31.2D
    NEG  V23.2D, V30.2D
    UXTL2 V13.8H, V21.16B
    SQXTN2  V9.4S, V13.2D
    SXTL2 V17.8H, V4.16B
    USQADD  V1.4S, V27.4S
    SQXTN  B17, H24
    SQXTN2  V1.4S, V7.2D
    FRINTP  V23.2D, V10.2D
    SQXTUN  S27, D31
    SQXTUN  V12.2S, V26.2D
    SQXTN  S1, D13
    SXTL V1.4S, V10.4H
    SQABS  S22, S28
    FRECPS  D16, D17, D13
    USQADD  V26.16B, V11.16B
    FRINTX  V7.4S, V27.4S
    USQADD  B11, B11
    SQXTN  B7, H22
    FRINTX  V22.2S, V16.2S
    SUQADD  D5, D1
    USQADD  B4, B22
    UADALP  V12.8H, V4.16B
    REV64  V8.2S, V10.2S
    RBIT  V31.16B, V7.16B
    SQXTUN2  V4.8H, V11.4S
    SQNEG  B23, B13
    SQXTN2  V7.8H, V28.4S
    UXTL2 V15.4S, V31.8H
    SQXTN  V7.2S, V12.2D
    SUQADD  D5, D28
    SQXTN  S2, D11
    FRECPS  V1.4S, V24.4S, V16.4S
    SUQADD  S15, S10
    URSQRTE  V21.2S, V2.2S
    ABS  V12.8B, V5.8B
    SQXTUN  B18, H13
    FRINTN  V5.2D, V28.2D
    FCVTXN  V7.2S, V19.2D
    UXTL V12.2D, V0.2S
    SXTL V1.4S, V7.4H
    SXTL V12.4S, V16.4H
    SQABS  B16, B10
    SUQADD  S23, S27
    UQXTN  V7.8B, V1.8H
    SQXTUN  B12, H16
    USQADD  V12.8B, V8.8B
    FCVTXN  S15, D5
TaishanSimdFpIntConversionP01_label_77:
    FRINTM  V22.4S, V12.4S
    SQXTUN  S27, D19
    SQABS  V31.2D, V7.2D
    FRECPS  S10, S11, S19
    CLS  V22.8H, V10.8H
    FNEG  V1.2D, V1.2D
    MVN  V12.16B, V8.16B
    FRINTA  V22.2S, V23.2S
    USQADD  V24.8H, V18.8H
    UQXTN  H23, S12
    RBIT  V16.8B, V0.8B
    SQXTUN2  V0.16B, V5.8H
    UXTL V11.8H, V21.8B
    SXTL V31.8H, V11.8B
    FRECPX  S2, S1
    SUBS  X9, X9, #0x1
    B.NE  TaishanSimdFpIntConversionP01_label_322
    MOVZ  X9, #0x0, LSL #0
    SUB  X24, X9, X2
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X19, X3, X6
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X7
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X24, X28, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X4, X5, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X3, X16, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X19
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X21
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X22
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X12, X28, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X24
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X14, X28, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X22, X17, X29
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X20
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, D2
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x7f00, LSL #16
    SUB  X29, X24, X20
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, V3.D[1]
    MOVZ  X22, #0x1, LSL #0
    SUB  X4, X22, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, D3
    MOVZ  X22, #0x1, LSL #0
    SUB  X4, X22, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X29, #0x2, LSL #0
    SUB  X17, X29, X24
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, D4
    MOVZ  X29, #0x1, LSL #0
    SUB  X17, X29, X24
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, V5.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, D5
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x4000, LSL #48
    SUB  X6, X11, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, V6.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, D6
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, V7.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, D7
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, D8
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, V9.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X4, X6, X15
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, D9
    MOVZ  X6, #0x0, LSL #0
    SUB  X4, X6, X15
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X4, X24, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, D10
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x4000, LSL #16
    SUB  X4, X24, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, V11.D[1]
    MOVZ  X24, #0xff, LSL #0
    MOVK  X24, #0xff, LSL #16
    MOVK  X24, #0xff, LSL #32
    MOVK  X24, #0xff, LSL #48
    SUB  X10, X24, X29
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, D11
    MOVZ  X24, #0xff, LSL #0
    MOVK  X24, #0xff, LSL #16
    MOVK  X24, #0xff, LSL #32
    MOVK  X24, #0xff, LSL #48
    SUB  X10, X24, X29
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X8, X22, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, D12
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X8, X22, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, V14.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, D14
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x4000, LSL #16
    SUB  X27, X20, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, V15.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, D15
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x4000, LSL #16
    SUB  X6, X5, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, V16.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, D16
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, V17.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X22
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, D17
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X22
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, V18.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X21, X29, X22
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, D18
    MOVZ  X29, #0x0, LSL #0
    SUB  X21, X29, X22
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, V19.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X26, X15, X22
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, D19
    MOVZ  X15, #0x0, LSL #0
    SUB  X26, X15, X22
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X10, #0xff, LSL #0
    MOVK  X10, #0xff, LSL #16
    MOVK  X10, #0xff, LSL #32
    MOVK  X10, #0xff, LSL #48
    SUB  X6, X10, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, D20
    MOVZ  X10, #0x1, LSL #0
    SUB  X6, X10, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, D21
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X2, X6, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, D22
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, V23.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X19
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, D23
    MOVZ  X7, #0xffff, LSL #0
    SUB  X26, X7, X19
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, V24.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, D24
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x3f80, LSL #16
    MOVK  X14, #0x3f80, LSL #48
    SUB  X7, X14, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #32
    SUB  X7, X14, X17
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, D25
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #32
    SUB  X7, X14, X17
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X10, X3, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, D26
    MOVZ  X3, #0x8101, LSL #0
    MOVK  X3, #0xffff, LSL #16
    SUB  X10, X3, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, D27
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, V28.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X12, X22, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, D28
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x4000, LSL #48
    SUB  X12, X22, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X26
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, D29
    MOVZ  X14, #0x1, LSL #0
    SUB  X25, X14, X26
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
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
    FMOV  D0, X6
    FMOV  V0.D[1], X26
    FMOV  D1, X4
    FMOV  V1.D[1], X15
    FMOV  D2, X14
    FMOV  V2.D[1], X29
    FMOV  D3, X26
    FMOV  V3.D[1], X25
    FMOV  D4, X28
    FMOV  V4.D[1], X27
    FMOV  D5, X25
    FMOV  V5.D[1], X6
    FMOV  D6, X9
    FMOV  V6.D[1], X28
    FMOV  D7, X18
    FMOV  V7.D[1], X20
    FMOV  D8, X29
    FMOV  V8.D[1], X20
    FMOV  D9, X7
    FMOV  V9.D[1], X29
    FMOV  D10, X22
    FMOV  V10.D[1], X16
    FMOV  D11, X4
    FMOV  V11.D[1], X9
    FMOV  D12, X23
    FMOV  V12.D[1], X25
    FMOV  D13, X15
    FMOV  V13.D[1], X23
    FMOV  D14, X12
    FMOV  V14.D[1], X23
    FMOV  D15, X16
    FMOV  V15.D[1], X9
    FMOV  D16, X8
    FMOV  V16.D[1], X20
    FMOV  D17, X7
    FMOV  V17.D[1], X26
    FMOV  D18, X15
    FMOV  V18.D[1], X3
    FMOV  D19, X11
    FMOV  V19.D[1], X16
    FMOV  D20, X4
    FMOV  V20.D[1], X18
    FMOV  D21, X3
    FMOV  V21.D[1], X7
    FMOV  D22, X14
    FMOV  V22.D[1], X8
    FMOV  D23, X10
    FMOV  V23.D[1], X3
    FMOV  D24, X26
    FMOV  V24.D[1], X5
    FMOV  D25, X28
    FMOV  V25.D[1], X10
    FMOV  D26, X6
    FMOV  V26.D[1], X25
    FMOV  D27, X29
    FMOV  V27.D[1], X29
    FMOV  D28, X28
    FMOV  V28.D[1], X24
    FMOV  D29, X10
    FMOV  V29.D[1], X4
    FMOV  D30, X27
    FMOV  V30.D[1], X15
    FMOV  D31, X9
    FMOV  V31.D[1], X18
    MOVZ  X26, #0xf, LSL #0
TaishanSimdFpIntConversionP01_label_394:
    SUQADD  B31, B7
    XTN  V14.2S, V29.2D
    REV16  V11.8B, V22.8B
    SQABS  H19, H20
    FCVTXN  V8.2S, V28.2D
    UADALP  V31.1D, V6.2S
    SADALP  V16.4S, V6.8H
    SQXTN  B31, H10
    SQABS  B23, B18
    SUQADD  D10, D9
    SUQADD  D30, D30
    ABS  D10, D21
    CLS  V25.2S, V3.2S
    FCVTXN  S16, D13
    NOT  V16.16B, V16.16B
    SUQADD  V8.2D, V28.2D
    USQADD  V23.2S, V14.2S
    UQXTN  S12, D16
    URSQRTE  V1.2S, V11.2S
    SXTL2 V23.2D, V15.4S
    USQADD  D19, D28
    UXTL2 V27.2D, V1.4S
    UXTL V11.2D, V12.2S
    FNEG  V24.2S, V18.2S
    NEG  V9.16B, V2.16B
    SQXTUN  B31, H9
    SXTL2 V12.4S, V19.8H
    SUQADD  H31, H10
    SUQADD  H2, H12
    MVN  V23.8B, V27.8B
    SQNEG  D18, D13
    SQXTN  S9, D18
    SQXTN  S23, D11
    SQXTN2  V30.16B, V2.8H
    SUQADD  D15, D19
    FCVTXN  V16.2S, V22.2D
    FRINTZ  V15.2S, V25.2S
    SQABS  D19, D13
    SQXTN  H13, S3
    SXTL2 V22.2D, V19.4S
    UQXTN  H11, S18
    FRINTX  V16.2D, V23.2D
    FSQRT  V8.2D, V13.2D
    FCVTXN  S6, D22
    SUQADD  S18, S17
    FABS  V25.2D, V9.2D
    XTN2  V14.8H, V11.4S
    FABS  V8.2D, V12.2D
    RBIT  V16.16B, V23.16B
    SQNEG  V20.4H, V7.4H
    USQADD  H13, H30
    UQXTN  S29, D9
    FRINTX  V6.2S, V26.2S
    SQXTUN2  V15.4S, V10.2D
    SQABS  H11, H3
    SQXTN  S9, D18
    FRINTI  V24.4S, V11.4S
    NEG  V16.8H, V6.8H
    FRSQRTE  D0, D5
    SUQADD  D21, D12
    CNT  V21.16B, V3.16B
    FRECPX  D15, D10
    SQABS  H25, H7
    FRSQRTE  V10.4S, V30.4S
    SXTL V6.2D, V18.2S
    FRINTN  V22.4S, V28.4S
    USQADD  D23, D12
    UADALP  V7.1D, V7.2S
    FRECPX  S30, S20
    UXTL V22.2D, V5.2S
    FRECPX  D30, D11
    FNEG  V8.2D, V20.2D
    SQABS  B7, B29
    SQXTUN  B24, H3
    FCVTXN2  V20.4S, V24.2D
    SQXTN  V4.8B, V14.8H
    SADDLP  V6.1D, V17.2S
    REV16  V5.8B, V3.8B
    USQADD  B24, B23
    SQXTN  B6, H7
    FRINTX  V21.2S, V7.2S
    SQNEG  H24, H12
    FRSQRTE  V25.2D, V25.2D
    NEG  V11.4S, V25.4S
    FRECPS  V23.2D, V29.2D, V6.2D
    UXTL2 V18.4S, V18.8H
    NOT  V21.8B, V15.8B
    SQABS  D4, D19
    USQADD  H19, H3
    SXTL V10.4S, V12.4H
    SQNEG  H15, H5
    FRINTI  V26.2S, V12.2S
    NEG  D6, D17
    SQXTN  B4, H20
    FRECPS  V15.2D, V15.2D, V2.2D
    SQXTN  B29, H6
    URSQRTE  V25.4S, V20.4S
    SADDLP  V0.4H, V11.8B
    FRINTN  V13.2D, V6.2D
    SQABS  D13, D11
    ABS  D25, D29
    FCVTXN  V26.2S, V12.2D
    MVN  V22.16B, V10.16B
    SQXTUN  B6, H5
    SADDLP  V24.2S, V29.4H
    CNT  V17.16B, V2.16B
    CLZ  V0.4H, V15.4H
    FRECPS  S30, S28, S28
    SUQADD  S14, S29
    UADALP  V5.2D, V29.4S
    CLS  V10.4H, V5.4H
    SQXTUN2  V29.4S, V5.2D
    XTN  V11.2S, V10.2D
    XTN  V15.8B, V0.8H
    SQXTN  B0, H20
    SXTL V26.2D, V29.2S
    NEG  V16.8B, V20.8B
    SUQADD  D4, D0
    FRINTP  V17.4S, V29.4S
    FRINTX  V7.2D, V5.2D
    FRINTX  V9.2S, V18.2S
    SUQADD  B8, B2
    FCVTXN2  V24.4S, V14.2D
    UADDLP  V26.2S, V10.4H
    SUQADD  B11, B15
    NOT  V8.16B, V5.16B
    UQXTN  V30.8B, V10.8H
    FRECPX  S5, S14
    SQXTN  V13.8B, V14.8H
    ABS  D16, D3
    SUQADD  D10, D22
    FRINTZ  V14.2D, V11.2D
    REV16  V0.16B, V13.16B
    ABS  V4.2D, V5.2D
    UQXTN2  V6.16B, V20.8H
    FRSQRTE  V0.2S, V31.2S
    UADALP  V29.1D, V22.2S
    UADDLP  V23.1D, V13.2S
    SQABS  D22, D15
    SQABS  S11, S28
    SUQADD  S1, S7
    UXTL V18.4S, V9.4H
    ABS  V2.8H, V29.8H
    SADDLP  V24.4H, V22.8B
    UADDLP  V31.8H, V3.16B
    SXTL V18.8H, V26.8B
    SADALP  V22.4H, V9.8B
    NEG  V9.2D, V3.2D
    FRECPX  D6, D18
    SQXTN2  V20.16B, V22.8H
    SXTL2 V18.2D, V4.4S
    SQXTN  S26, D15
    UQXTN  B26, H18
    USQADD  B31, B6
    SQABS  S15, S19
    SXTL2 V13.4S, V23.8H
    UQXTN  H4, S16
    XTN2  V26.8H, V17.4S
    SQXTUN  B26, H9
    SQNEG  H9, H12
    UQXTN  S3, D24
    UQXTN  S24, D2
    SXTL V5.8H, V23.8B
    FCVTXN2  V23.4S, V26.2D
    SQXTN  B23, H27
    USQADD  B5, B6
    SQXTUN  B12, H6
    FRECPS  D16, D4, D22
    SQXTN  V21.2S, V17.2D
    NOT  V24.16B, V11.16B
    USQADD  V22.2D, V24.2D
    SQNEG  V9.8B, V31.8B
    USQADD  B29, B3
    USQADD  V30.2S, V9.2S
    REV32  V12.4H, V18.4H
    SQXTUN2  V21.4S, V3.2D
    SADALP  V18.2S, V27.4H
    URSQRTE  V23.4S, V4.4S
    FRECPX  D2, D11
    FRECPX  D1, D22
    UQXTN  V24.4H, V15.4S
    FRECPS  S15, S5, S12
    SQABS  S27, S1
    SXTL V27.4S, V9.4H
    SUQADD  V26.2D, V11.2D
    SQXTUN  H18, S26
    FRINTN  V19.2D, V11.2D
    FABS  V2.2S, V23.2S
    NEG  V29.2D, V28.2D
    FRECPX  S2, S24
    CNT  V18.16B, V30.16B
    SXTL2 V15.4S, V1.8H
    SUQADD  S16, S2
    FRINTA  V18.4S, V19.4S
    USQADD  V13.2S, V14.2S
    SQXTN  B26, H27
    REV16  V3.16B, V26.16B
    USQADD  S15, S26
    FRINTI  V12.2D, V22.2D
    FRECPS  S28, S16, S21
    SUBS  X26, X26, #0x1
    B.NE  TaishanSimdFpIntConversionP01_label_394
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X7, X5, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X29, X17, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X20, X17, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X18, X5, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X19, X22, X6
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X16, X21, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X23, X2, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X10, X5, X10
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X16, X17, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X9, X29, X12
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X24, X17, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X22, X6, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X19, X7, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X18
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X18, X7, X20
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X22
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X7, X22, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X27, X29, X27
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X2, X22, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X15, X24, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X3, X18, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, D2
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7f00, LSL #16
    SUB  X3, X18, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, D3
    MOVZ  X15, #0x7f00, LSL #0
    SUB  X4, X15, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
TaishanSimdFpIntConversionP01_label_393:
    SUB  X5, X2, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, D4
    MOVZ  X2, #0x7f00, LSL #0
    SUB  X5, X2, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, D5
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, D6
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x7fe0, LSL #48
    SUB  X3, X27, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, D7
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x3ff0, LSL #48
    SUB  X22, X4, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X29, X6, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, D8
    MOVZ  X6, #0xff80, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X29, X6, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, V9.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, D9
    MOVZ  X22, #0x81, LSL #0
    SUB  X26, X22, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, D10
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0x7fff, LSL #48
    SUB  X15, X21, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X29, X20, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, D11
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x4000, LSL #16
    SUB  X29, X20, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X17, X6, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, D12
    MOVZ  X6, #0x0, LSL #0
    SUB  X17, X6, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, V14.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, D14
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, D15
    MOVZ  X26, #0x7f, LSL #0
    SUB  X16, X26, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, D16
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x7f00, LSL #16
    SUB  X15, X24, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, V17.D[1]
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x3f80, LSL #16
    SUB  X25, X23, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, D17
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X3, X20, X17
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, D18
    MOVZ  X20, #0x0, LSL #0
    SUB  X3, X20, X17
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, D19
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X25, #0x7f7f, LSL #0
    SUB  X9, X25, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, D20
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xc010, LSL #48
    SUB  X9, X25, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X7, #0x20, LSL #0
    MOVK  X7, #0x11, LSL #16
    SUB  X12, X7, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, D21
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x3f80, LSL #48
    SUB  X12, X7, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, V22.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X9
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, D22
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X9
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, V23.D[1]
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, D23
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, V24.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, D24
    MOVZ  X14, #0x7f00, LSL #0
    SUB  X26, X14, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, V25.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X3, X22, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, D25
    MOVZ  X22, #0x0, LSL #0
    SUB  X3, X22, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, D26
    MOVZ  X6, #0x7f, LSL #0
    SUB  X11, X6, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, V27.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X2, X22, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, D27
    MOVZ  X22, #0x81, LSL #0
    SUB  X2, X22, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X29, X4, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X18, D28
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x4000, LSL #16
    SUB  X29, X4, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, V29.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X8, X23, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, D29
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xc000, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X8, X23, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X2, #0x72af, LSL #0
    MOVK  X2, #0xf1c7, LSL #16
    MOVK  X2, #0xe4cb, LSL #32
    MOVK  X2, #0x250d, LSL #48
    MOVZ  X3, #0x8da0, LSL #0
    MOVK  X3, #0xa685, LSL #16
    MOVK  X3, #0x2094, LSL #32
    MOVK  X3, #0xd475, LSL #48
    MOVZ  X4, #0xbf9a, LSL #0
    MOVK  X4, #0x9ce1, LSL #16
    MOVK  X4, #0xd7a5, LSL #32
    MOVK  X4, #0xc51a, LSL #48
    MOVZ  X5, #0x8c0d, LSL #0
    MOVK  X5, #0xcb5c, LSL #16
    MOVK  X5, #0xbf33, LSL #32
    MOVK  X5, #0x2965, LSL #48
    MOVZ  X6, #0x26dd, LSL #0
    MOVK  X6, #0xea3a, LSL #16
    MOVK  X6, #0xb2f2, LSL #32
    MOVK  X6, #0xc6c3, LSL #48
    MOVZ  X7, #0x7225, LSL #0
    MOVK  X7, #0x8d2e, LSL #16
    MOVK  X7, #0xc8ba, LSL #32
    MOVK  X7, #0x61f7, LSL #48
    MOVZ  X8, #0x6cf5, LSL #0
    MOVK  X8, #0xbcb6, LSL #16
    MOVK  X8, #0xe61e, LSL #32
    MOVK  X8, #0xfd5e, LSL #48
    MOVZ  X9, #0x41fe, LSL #0
    MOVK  X9, #0x25ae, LSL #16
    MOVK  X9, #0x9e8f, LSL #32
    MOVK  X9, #0xe3f2, LSL #48
    MOVZ  X10, #0x4107, LSL #0
    MOVK  X10, #0x529b, LSL #16
    MOVK  X10, #0x39ca, LSL #32
    MOVK  X10, #0x613, LSL #48
    MOVZ  X11, #0xa06c, LSL #0
    MOVK  X11, #0x55d4, LSL #16
    MOVK  X11, #0xb743, LSL #32
    MOVK  X11, #0xd71e, LSL #48
    MOVZ  X12, #0xc7f8, LSL #0
    MOVK  X12, #0x348e, LSL #16
    MOVK  X12, #0xde4c, LSL #32
    MOVK  X12, #0xa4c8, LSL #48
    MOVZ  X14, #0xbfe4, LSL #0
    MOVK  X14, #0x5920, LSL #16
    MOVK  X14, #0xfec2, LSL #32
    MOVK  X14, #0x2206, LSL #48
    MOVZ  X15, #0x28dd, LSL #0
    MOVK  X15, #0x92ce, LSL #16
    MOVK  X15, #0x8468, LSL #32
    MOVK  X15, #0x1062, LSL #48
    MOVZ  X16, #0x5fca, LSL #0
    MOVK  X16, #0x4368, LSL #16
    MOVK  X16, #0x94f1, LSL #32
    MOVK  X16, #0xe0a5, LSL #48
    MOVZ  X17, #0x8bbd, LSL #0
    MOVK  X17, #0xc05, LSL #16
    MOVK  X17, #0xff58, LSL #32
    MOVK  X17, #0x6291, LSL #48
    MOVZ  X18, #0xeef9, LSL #0
    MOVK  X18, #0x89a5, LSL #16
    MOVK  X18, #0x4442, LSL #32
    MOVK  X18, #0xf181, LSL #48
    MOVZ  X19, #0x3dc7, LSL #0
    MOVK  X19, #0x4998, LSL #16
    MOVK  X19, #0x7f5d, LSL #32
    MOVK  X19, #0xe0f7, LSL #48
    MOVZ  X20, #0xf8cd, LSL #0
    MOVK  X20, #0x2dfb, LSL #16
    MOVK  X20, #0xb9, LSL #32
    MOVK  X20, #0xb5cc, LSL #48
    MOVZ  X21, #0x532a, LSL #0
    MOVK  X21, #0x7ca9, LSL #16
    MOVK  X21, #0x9f45, LSL #32
    MOVK  X21, #0x33da, LSL #48
    MOVZ  X22, #0x4c53, LSL #0
    MOVK  X22, #0x5e6e, LSL #16
    MOVK  X22, #0x2175, LSL #32
    MOVK  X22, #0x8773, LSL #48
    MOVZ  X23, #0xe4e0, LSL #0
    MOVK  X23, #0x774f, LSL #16
    MOVK  X23, #0x3374, LSL #32
    MOVK  X23, #0xc004, LSL #48
    MOVZ  X24, #0xf25f, LSL #0
    MOVK  X24, #0xd255, LSL #16
    MOVK  X24, #0xb6c5, LSL #32
    MOVK  X24, #0x945b, LSL #48
    MOVZ  X25, #0xf2b8, LSL #0
    MOVK  X25, #0xa26e, LSL #16
    MOVK  X25, #0xb278, LSL #32
    MOVK  X25, #0xc7ff, LSL #48
    MOVZ  X26, #0xf8a4, LSL #0
    MOVK  X26, #0x2868, LSL #16
    MOVK  X26, #0x2514, LSL #32
    MOVK  X26, #0x2cfd, LSL #48
    MOVZ  X27, #0xa04, LSL #0
    MOVK  X27, #0x80fb, LSL #16
    MOVK  X27, #0xee61, LSL #32
    MOVK  X27, #0xc6a0, LSL #48
    MOVZ  X28, #0x4133, LSL #0
    MOVK  X28, #0x7a9d, LSL #16
    MOVK  X28, #0x3948, LSL #32
    MOVK  X28, #0x89da, LSL #48
    MOVZ  X29, #0x6b8f, LSL #0
    MOVK  X29, #0x9fda, LSL #16
    MOVK  X29, #0x14fd, LSL #32
    MOVK  X29, #0x9579, LSL #48
    FMOV  D0, X9
    FMOV  V0.D[1], X9
    FMOV  D1, X23
    FMOV  V1.D[1], X2
    FMOV  D2, X26
    FMOV  V2.D[1], X25
    FMOV  D3, X27
    FMOV  V3.D[1], X29
    FMOV  D4, X18
    FMOV  V4.D[1], X28
    FMOV  D5, X9
    FMOV  V5.D[1], X6
    FMOV  D6, X18
    FMOV  V6.D[1], X18
    FMOV  D7, X23
    FMOV  V7.D[1], X4
    FMOV  D8, X18
    FMOV  V8.D[1], X3
    FMOV  D9, X25
    FMOV  V9.D[1], X28
    FMOV  D10, X10
    FMOV  V10.D[1], X22
    FMOV  D11, X21
    FMOV  V11.D[1], X19
    FMOV  D12, X21
    FMOV  V12.D[1], X18
    FMOV  D13, X14
    FMOV  V13.D[1], X8
    FMOV  D14, X20
    FMOV  V14.D[1], X25
    FMOV  D15, X3
    FMOV  V15.D[1], X10
    FMOV  D16, X5
    FMOV  V16.D[1], X6
    FMOV  D17, X22
    FMOV  V17.D[1], X8
    FMOV  D18, X29
    FMOV  V18.D[1], X17
    FMOV  D19, X9
    FMOV  V19.D[1], X12
    FMOV  D20, X28
    FMOV  V20.D[1], X6
    FMOV  D21, X4
    FMOV  V21.D[1], X9
    FMOV  D22, X3
    FMOV  V22.D[1], X26
    FMOV  D23, X15
    FMOV  V23.D[1], X29
    FMOV  D24, X22
    FMOV  V24.D[1], X10
    FMOV  D25, X11
    FMOV  V25.D[1], X7
    FMOV  D26, X11
    FMOV  V26.D[1], X29
    FMOV  D27, X7
    FMOV  V27.D[1], X18
    FMOV  D28, X15
    FMOV  V28.D[1], X25
    FMOV  D29, X25
    FMOV  V29.D[1], X27
    FMOV  D30, X21
    FMOV  V30.D[1], X5
    FMOV  D31, X5
    FMOV  V31.D[1], X17
    MOVZ  X26, #0xa, LSL #0
TaishanSimdFpIntConversionP01_label_474:
    FRINTP  V12.2S, V0.2S
    USQADD  D13, D4
    FRINTP  V28.2S, V17.2S
    FRINTM  V30.2S, V18.2S
    SADDLP  V19.8H, V26.16B
    REV16  V4.8B, V20.8B
    NEG  V6.16B, V21.16B
    USQADD  B18, B26
    SQNEG  B10, B23
    SQXTN  S21, D10
    SQABS  S19, S18
    USQADD  D8, D8
    XTN  V12.8B, V17.8H
    SQXTUN  V23.2S, V7.2D
    FRINTX  V3.2S, V12.2S
    SQNEG  S5, S18
    FRECPX  S30, S22
    UQXTN  H3, S6
    SXTL2 V27.2D, V1.4S
    URSQRTE  V14.2S, V30.2S
    URECPE  V8.4S, V25.4S
    ABS  V0.8H, V23.8H
    UXTL2 V30.4S, V16.8H
    FRINTP  V18.2D, V28.2D
    SQABS  D20, D6
    FCVTXN2  V21.4S, V30.2D
    SQXTN  S13, D9
    SQXTN  H17, S20
    FRINTX  V14.4S, V5.4S
    SQXTN  S1, D22
    FRECPS  D6, D2, D24
    SQNEG  H12, H6
    SQNEG  D4, D12
    NEG  V3.2S, V23.2S
    SUQADD  S20, S30
    FRINTI  V1.2S, V8.2S
    REV64  V30.4H, V15.4H
    REV64  V30.8B, V21.8B
    NOT  V29.8B, V30.8B
    CLZ  V30.4S, V9.4S
    SQABS  V6.8H, V19.8H
    XTN2  V13.8H, V19.4S
    FRECPS  S8, S1, S5
    NEG  D8, D30
    SQNEG  H6, H15
    FSQRT  V24.2S, V20.2S
    REV32  V15.16B, V6.16B
    NOT  V22.16B, V14.16B
    ABS  D9, D22
    MVN  V26.8B, V1.8B
    USQADD  S16, S26
    UXTL V1.8H, V21.8B
    UADALP  V3.4S, V6.8H
    USQADD  D15, D17
    FRECPX  S1, S16
    FRSQRTE  D9, D9
    UQXTN  H13, S20
    USQADD  B3, B31
    SQXTUN  B20, H17
    MVN  V24.16B, V22.16B
    USQADD  D13, D11
    NEG  D29, D14
    FCVTXN  S23, D31
    UQXTN  S4, D14
    SQXTN  S8, D4
    SXTL2 V6.4S, V8.8H
    SXTL2 V21.8H, V31.16B
    SQABS  H15, H9
    FABS  V10.2S, V8.2S
    SXTL V16.8H, V20.8B
    USQADD  V29.16B, V17.16B
    XTN  V20.4H, V31.4S
    FRSQRTE  S26, S4
    UQXTN2  V11.4S, V26.2D
    FABS  V0.4S, V3.4S
    SADDLP  V4.4H, V20.8B
    SXTL V11.2D, V22.2S
    FRINTZ  V26.2D, V31.2D
    NEG  V12.8B, V0.8B
    SQXTUN  B23, H4
    UXTL V12.2D, V15.2S
    SUQADD  S1, S23
    FRINTA  V20.2S, V27.2S
    SQXTUN2  V26.8H, V10.4S
    USQADD  B21, B20
    FRECPS  V17.2S, V30.2S, V21.2S
    UXTL V17.2D, V14.2S
    UXTL2 V14.2D, V14.4S
    ABS  V6.4S, V22.4S
    XTN  V12.2S, V3.2D
    SQXTUN  V2.8B, V13.8H
    RBIT  V21.16B, V25.16B
    UADALP  V31.8H, V27.16B
    ABS  V8.8B, V31.8B
    FABS  V21.4S, V15.4S
    FRINTP  V2.4S, V26.4S
    NEG  V14.16B, V30.16B
    UQXTN  S0, D12
    SXTL V12.4S, V13.4H
    FRINTN  V21.2S, V23.2S
    FRECPS  S15, S29, S18
    SUQADD  S26, S4
    REV16  V21.8B, V4.8B
    SQABS  V21.8H, V0.8H
    UQXTN  H30, S8
    SQABS  S27, S13
    FRSQRTE  V5.2S, V30.2S
    SUQADD  B10, B25
    SQNEG  D20, D8
    SQABS  B5, B4
    URSQRTE  V11.2S, V20.2S
    UQXTN  S30, D31
    FRINTN  V25.2S, V2.2S
    UQXTN  V13.4H, V25.4S
    FCVTXN2  V5.4S, V13.2D
    SQXTUN  H4, S26
    ABS  D12, D26
    FRECPX  S14, S12
    SXTL2 V11.4S, V10.8H
    REV16  V15.16B, V21.16B
    FRSQRTE  V15.4S, V20.4S
    URSQRTE  V25.4S, V26.4S
    CLZ  V6.8B, V14.8B
    UQXTN  V22.4H, V17.4S
    SXTL2 V29.4S, V10.8H
    UXTL V30.8H, V11.8B
    FRECPS  V20.2D, V18.2D, V15.2D
    FRINTN  V26.4S, V26.4S
    SADDLP  V4.2D, V14.4S
    SQNEG  D0, D8
    FRECPS  D10, D19, D31
    UADDLP  V27.4H, V18.8B
    SQABS  B19, B25
    UXTL V10.8H, V24.8B
    SADDLP  V22.4H, V7.8B
    SQNEG  V6.2S, V28.2S
    UXTL2 V7.4S, V20.8H
    FSQRT  V13.2S, V18.2S
    URECPE  V7.4S, V28.4S
    RBIT  V5.8B, V10.8B
    SQXTN  B1, H13
    FRECPX  S31, S3
    SQXTUN  S30, D1
    FCVTXN  S2, D29
    FRSQRTE  S29, S7
    CLS  V30.2S, V24.2S
    FNEG  V18.4S, V23.4S
    SQNEG  H9, H2
    SXTL2 V10.8H, V15.16B
    SUQADD  S28, S4
    UXTL2 V20.4S, V5.8H
    SQABS  V22.4H, V5.4H
    SQXTN2  V26.16B, V13.8H
    SUQADD  D30, D7
    FRINTP  V27.2D, V4.2D
    SXTL V5.4S, V26.4H
    UXTL V28.8H, V17.8B
    SQNEG  H22, H26
    SQABS  S23, S8
    SUQADD  V17.8B, V14.8B
    NOT  V3.16B, V3.16B
    SUQADD  H19, H26
    SXTL2 V0.2D, V30.4S
    FNEG  V11.2S, V16.2S
    ABS  D5, D19
    FCVTXN  V19.2S, V14.2D
    NEG  D22, D27
    RBIT  V4.16B, V13.16B
    SQXTUN  S5, D22
    SXTL V22.8H, V30.8B
    USQADD  V11.8H, V19.8H
    SXTL2 V21.4S, V24.8H
    SXTL V21.8H, V6.8B
    UADALP  V28.4S, V2.8H
    SQXTN  B16, H28
    ABS  D11, D16
    SQXTUN  S5, D8
    UQXTN  H22, S11
    SQNEG  B10, B13
    FRECPS  V5.2S, V10.2S, V21.2S
    SUQADD  H19, H24
    UXTL V22.8H, V5.8B
    FRINTX  V15.4S, V4.4S
    SQNEG  H16, H27
    UQXTN  V28.4H, V16.4S
    FCVTXN  S28, D14
    SQABS  V30.16B, V6.16B
    SQXTN  B12, H16
    UXTL2 V15.8H, V12.16B
    MVN  V9.8B, V0.8B
    FSQRT  V4.2S, V26.2S
    UXTL2 V21.4S, V8.8H
    SQNEG  V22.4S, V20.4S
    FRECPS  S31, S14, S0
    FABS  V13.4S, V23.4S
    CLS  V12.8H, V24.8H
    UQXTN  V25.2S, V0.2D
    USQADD  H20, H3
    FNEG  V2.2S, V13.2S
    SXTL V28.8H, V11.8B
    SUBS  X26, X26, #0x1
    B.NE  TaishanSimdFpIntConversionP01_label_474
    MOVZ  X21, #0x72af, LSL #0
    MOVK  X21, #0xf1c7, LSL #16
    MOVK  X21, #0xe4cb, LSL #32
    MOVK  X21, #0x250d, LSL #48
    SUB  X25, X21, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X2, #0x8da0, LSL #0
    MOVK  X2, #0xa685, LSL #16
    MOVK  X2, #0x2094, LSL #32
    MOVK  X2, #0xd475, LSL #48
    SUB  X20, X2, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X7, #0xbf9a, LSL #0
    MOVK  X7, #0x9ce1, LSL #16
    MOVK  X7, #0xd7a5, LSL #32
    MOVK  X7, #0xc51a, LSL #48
    SUB  X5, X7, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X17, X18, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X24, #0x26dd, LSL #0
    MOVK  X24, #0xea3a, LSL #16
    MOVK  X24, #0xb2f2, LSL #32
    MOVK  X24, #0xc6c3, LSL #48
    SUB  X8, X24, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X9, #0xbf9a, LSL #0
    MOVK  X9, #0x9ce1, LSL #16
    MOVK  X9, #0xd7a5, LSL #32
    MOVK  X9, #0xc51a, LSL #48
    SUB  X19, X9, X7
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X27, #0xbf9a, LSL #0
    MOVK  X27, #0x9ce1, LSL #16
    MOVK  X27, #0xd7a5, LSL #32
    MOVK  X27, #0xc51a, LSL #48
    SUB  X2, X27, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X22, #0x4107, LSL #0
    MOVK  X22, #0x529b, LSL #16
    MOVK  X22, #0x39ca, LSL #32
    MOVK  X22, #0x613, LSL #48
    SUB  X11, X22, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X23, X24, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X18, #0xc7f8, LSL #0
    MOVK  X18, #0x348e, LSL #16
    MOVK  X18, #0xde4c, LSL #32
    MOVK  X18, #0xa4c8, LSL #48
    SUB  X7, X18, X12
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X25, #0xbfe4, LSL #0
    MOVK  X25, #0x5920, LSL #16
    MOVK  X25, #0xfec2, LSL #32
    MOVK  X25, #0x2206, LSL #48
    SUB  X28, X25, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X25, #0x28dd, LSL #0
    MOVK  X25, #0x92ce, LSL #16
    MOVK  X25, #0x8468, LSL #32
    MOVK  X25, #0x1062, LSL #48
    SUB  X21, X25, X15
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X21, #0x5fca, LSL #0
    MOVK  X21, #0x4368, LSL #16
    MOVK  X21, #0x94f1, LSL #32
    MOVK  X21, #0xe0a5, LSL #48
    SUB  X19, X21, X16
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X5, #0xc7f8, LSL #0
    MOVK  X5, #0x348e, LSL #16
    MOVK  X5, #0xde4c, LSL #32
    MOVK  X5, #0xa4c8, LSL #48
    SUB  X28, X5, X18
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X20
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X25, #0x5fca, LSL #0
    MOVK  X25, #0x4368, LSL #16
    MOVK  X25, #0x94f1, LSL #32
    MOVK  X25, #0xe0a5, LSL #48
    SUB  X11, X25, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X20, #0x4107, LSL #0
    MOVK  X20, #0x529b, LSL #16
    MOVK  X20, #0x39ca, LSL #32
    MOVK  X20, #0x613, LSL #48
    SUB  X22, X20, X22
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X15, #0x5fca, LSL #0
    MOVK  X15, #0x4368, LSL #16
    MOVK  X15, #0x94f1, LSL #32
    MOVK  X15, #0xe0a5, LSL #48
    SUB  X17, X15, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X27
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X27, X14, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X8, X28, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, V2.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, D2
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xc000, LSL #16
    MOVK  X25, #0x8000, LSL #48
    SUB  X21, X25, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, V3.D[1]
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, D3
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, D4
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, D5
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x4000, LSL #16
    MOVK  X7, #0xffc1, LSL #48
    SUB  X26, X7, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, V6.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X23, X27, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, D6
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x8100, LSL #16
    SUB  X23, X27, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X24, X3, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, D7
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X24, X3, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, D8
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x4000, LSL #16
    SUB  X29, X10, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, D9
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X7, X22, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X3, X15, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, D10
    MOVZ  X15, #0x0, LSL #0
    SUB  X3, X15, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, V11.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X7, X26, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, D11
    MOVZ  X26, #0x0, LSL #0
    SUB  X7, X26, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, V12.D[1]
    MOVZ  X8, #0xf, LSL #0
    MOVK  X8, #0xf, LSL #16
    MOVK  X8, #0xf, LSL #32
    MOVK  X8, #0xf, LSL #48
    SUB  X28, X8, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, D12
    MOVZ  X8, #0xf, LSL #0
    MOVK  X8, #0xf, LSL #16
    MOVK  X8, #0xf, LSL #32
    MOVK  X8, #0xf, LSL #48
    SUB  X28, X8, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X9
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, D14
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x7f00, LSL #16
    SUB  X19, X24, X9
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, V15.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, D15
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V16.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D16
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, V17.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, D17
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x7f00, LSL #16
    SUB  X9, X6, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x8000, LSL #16
    MOVK  X19, #0x8000, LSL #48
    SUB  X15, X19, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, D18
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x8000, LSL #16
    MOVK  X19, #0x8000, LSL #48
    SUB  X15, X19, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, V19.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X17, X18, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, D19
    MOVZ  X18, #0x1, LSL #0
    SUB  X17, X18, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, V20.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, D20
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X5, X19, X14
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, D21
    MOVZ  X19, #0x0, LSL #0
    SUB  X5, X19, X14
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, D22
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, D23
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x4000, LSL #16
    SUB  X10, X5, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X20
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, D24
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X20
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, D25
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X18, V26.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7f7f, LSL #16
    SUB  X10, X22, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X18, D26
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X11
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, D27
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x3ff0, LSL #48
    SUB  X25, X23, X11
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, D28
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, D29
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    SUB  X9, X2, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
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
    FMOV  D0, X18
    FMOV  V0.D[1], X12
    FMOV  D1, X25
    FMOV  V1.D[1], X19
    FMOV  D2, X21
    FMOV  V2.D[1], X6
    FMOV  D3, X5
    FMOV  V3.D[1], X18
    FMOV  D4, X24
    FMOV  V4.D[1], X20
    FMOV  D5, X29
    FMOV  V5.D[1], X8
    FMOV  D6, X23
    FMOV  V6.D[1], X28
    FMOV  D7, X7
    FMOV  V7.D[1], X26
    FMOV  D8, X25
    FMOV  V8.D[1], X15
    FMOV  D9, X28
    FMOV  V9.D[1], X29
    FMOV  D10, X14
    FMOV  V10.D[1], X22
    FMOV  D11, X2
    FMOV  V11.D[1], X22
    FMOV  D12, X28
    FMOV  V12.D[1], X2
    FMOV  D13, X20
    FMOV  V13.D[1], X9
    FMOV  D14, X24
    FMOV  V14.D[1], X18
    FMOV  D15, X22
    FMOV  V15.D[1], X3
    FMOV  D16, X28
    FMOV  V16.D[1], X17
    FMOV  D17, X6
    FMOV  V17.D[1], X24
    FMOV  D18, X4
    FMOV  V18.D[1], X28
    FMOV  D19, X20
    FMOV  V19.D[1], X29
    FMOV  D20, X21
    FMOV  V20.D[1], X23
    FMOV  D21, X19
    FMOV  V21.D[1], X22
    FMOV  D22, X9
    FMOV  V22.D[1], X14
    FMOV  D23, X29
    FMOV  V23.D[1], X6
    FMOV  D24, X17
    FMOV  V24.D[1], X14
    FMOV  D25, X2
    FMOV  V25.D[1], X14
    FMOV  D26, X24
    FMOV  V26.D[1], X29
    FMOV  D27, X17
    FMOV  V27.D[1], X17
    FMOV  D28, X23
    FMOV  V28.D[1], X28
    FMOV  D29, X8
    FMOV  V29.D[1], X16
    FMOV  D30, X5
    FMOV  V30.D[1], X18
    FMOV  D31, X8
    FMOV  V31.D[1], X4
    MOVZ  X2, #0xa, LSL #0
TaishanSimdFpIntConversionP01_label_551:
    UADDLP  V6.8H, V8.16B
    SQNEG  S30, S24
    XTN  V25.4H, V22.4S
    SQNEG  D11, D30
    SQXTUN2  V11.8H, V13.4S
    UQXTN  B6, H21
    SUQADD  B0, B18
    SADDLP  V5.2S, V26.4H
    USQADD  H25, H31
    SQXTN  S22, D0
    NEG  D27, D5
    SQXTN  S7, D30
    SQXTUN  H8, S11
    SUQADD  V24.2D, V29.2D
    SQXTN2  V8.16B, V3.8H
    USQADD  S18, S29
    USQADD  D11, D7
    UXTL V18.4S, V24.4H
    UXTL2 V9.2D, V8.4S
    FRINTA  V11.2D, V31.2D
    FRSQRTE  V18.2D, V2.2D
    SUQADD  B22, B11
    SUQADD  V30.4H, V14.4H
    REV32  V12.8B, V28.8B
    SQABS  V12.4H, V4.4H
    FCVTXN  S4, D10
    SQABS  D3, D13
    SUQADD  S12, S5
    SQABS  S13, S0
    UQXTN  V13.8B, V0.8H
    URECPE  V2.4S, V12.4S
    XTN  V13.2S, V22.2D
    FCVTXN  V4.2S, V9.2D
    SQABS  V25.8B, V24.8B
    UQXTN  H15, S3
    SUQADD  V26.4H, V4.4H
    USQADD  V31.2S, V7.2S
    SQXTUN  V2.2S, V20.2D
    SQNEG  S24, S18
    FRINTA  V20.4S, V18.4S
    SQNEG  V22.2D, V20.2D
    FCVTXN2  V5.4S, V15.2D
    FRECPS  S10, S29, S19
    FRECPX  S7, S19
    SXTL2 V16.2D, V18.4S
    FRECPX  D25, D2
    SQXTUN  S15, D13
    FCVTXN  V5.2S, V30.2D
    SQXTN  V29.4H, V14.4S
    RBIT  V11.8B, V4.8B
    UQXTN  S22, D31
    SQXTN  H15, S11
    FRECPX  S8, S10
    SQXTN  H21, S4
    USQADD  V21.4S, V27.4S
    SQABS  B8, B20
    NEG  V5.2D, V4.2D
    UADALP  V26.8H, V13.16B
    FRINTZ  V8.2D, V26.2D
    USQADD  V19.8B, V21.8B
    UXTL2 V14.8H, V4.16B
    SADDLP  V15.2S, V6.4H
    FRECPX  S4, S0
    FRSQRTE  S19, S3
    SQNEG  S16, S27
    SUQADD  H28, H18
    SQXTUN2  V5.4S, V13.2D
    NOT  V5.16B, V28.16B
    SQNEG  B25, B13
    RBIT  V15.8B, V7.8B
    UXTL V14.8H, V5.8B
    USQADD  H2, H12
    SQNEG  V30.4S, V22.4S
    NEG  V20.2S, V19.2S
    REV32  V16.8B, V24.8B
    USQADD  H30, H18
    SXTL2 V28.4S, V2.8H
    FRECPS  S9, S10, S30
    FSQRT  V28.2D, V16.2D
    SQNEG  V18.16B, V6.16B
    MVN  V10.16B, V14.16B
    USQADD  B24, B7
    SQABS  V13.16B, V16.16B
    SXTL V24.2D, V9.2S
    SQXTN  S17, D15
    USQADD  V14.16B, V17.16B
    FCVTXN  S30, D16
    FRECPX  S6, S30
    SQABS  H20, H7
    SUQADD  V7.8H, V10.8H
    FRINTM  V30.4S, V21.4S
    FRECPS  V23.4S, V19.4S, V4.4S
    USQADD  S31, S30
    MVN  V29.16B, V25.16B
    FRINTZ  V13.4S, V1.4S
    UXTL V21.2D, V16.2S
    REV16  V1.8B, V5.8B
    SQXTN  H5, S5
    XTN2  V7.16B, V24.8H
    SADALP  V1.4H, V4.8B
    SADDLP  V5.2S, V11.4H
    SQABS  H21, H5
    SQABS  B7, B11
    SUQADD  S10, S1
    NEG  V19.4H, V21.4H
    SXTL V18.8H, V6.8B
    UXTL V0.2D, V1.2S
    USQADD  B7, B15
    SQXTN  V1.2S, V5.2D
    SQXTN  S2, D7
    SUQADD  B6, B30
    FABS  V13.2S, V2.2S
    SQNEG  B19, B9
    UXTL2 V14.8H, V8.16B
    USQADD  B27, B10
    SXTL2 V3.2D, V7.4S
    SQABS  D13, D14
    SQNEG  H16, H16
    FRECPX  D13, D7
    UQXTN  B18, H21
    SADDLP  V20.4H, V22.8B
    UQXTN  B3, H6
    SQXTUN  B18, H12
    FRINTP  V22.4S, V3.4S
    SQXTN  H3, S14
    CNT  V25.8B, V18.8B
    SQXTN  B3, H18
    FRINTM  V12.4S, V12.4S
    CLZ  V20.8H, V28.8H
    USQADD  B7, B2
    NEG  V10.4S, V23.4S
    SQABS  D23, D0
    SQNEG  H14, H14
    FRECPS  D9, D7, D17
    FRINTN  V25.2S, V22.2S
    UADALP  V0.4H, V18.8B
    FRINTA  V13.2S, V9.2S
    UQXTN  V22.8B, V21.8H
    USQADD  D12, D18
    FRINTM  V17.2D, V25.2D
    UXTL2 V2.8H, V31.16B
    ABS  V21.16B, V21.16B
    SQNEG  S1, S9
    SXTL V25.8H, V27.8B
    FABS  V1.2S, V30.2S
    UXTL2 V20.8H, V3.16B
    UQXTN2  V3.16B, V3.8H
    FRECPS  S27, S14, S5
    FCVTXN2  V2.4S, V12.2D
    SQNEG  H13, H21
    FABS  V20.4S, V23.4S
    FCVTXN  V31.2S, V9.2D
    ABS  V20.4H, V26.4H
    UADDLP  V7.2S, V2.4H
    UQXTN  H14, S24
    SXTL V0.4S, V31.4H
    UADDLP  V10.4S, V5.8H
    SQNEG  H27, H13
    UXTL V20.2D, V31.2S
    FRINTP  V5.2S, V22.2S
    UADALP  V5.4S, V0.8H
    FRINTA  V17.2D, V13.2D
    SQXTUN  B27, H9
    RBIT  V1.16B, V27.16B
    SXTL V25.4S, V23.4H
    FRINTM  V30.2D, V10.2D
    FRINTN  V29.4S, V15.4S
    FCVTXN  S12, D10
    SUQADD  V5.8B, V0.8B
    UXTL V9.4S, V12.4H
    SQXTN2  V8.8H, V6.4S
    SQXTUN  B26, H22
    SQXTUN  B6, H10
    SXTL V13.4S, V12.4H
    USQADD  D9, D20
    SQXTN  B1, H9
    CNT  V8.8B, V22.8B
    FRINTI  V23.2S, V25.2S
    ABS  D28, D18
    FRINTZ  V27.2D, V30.2D
    SQNEG  B14, B4
    CLZ  V1.4S, V26.4S
    URECPE  V0.4S, V28.4S
    FABS  V12.4S, V29.4S
    FRINTN  V3.2S, V30.2S
    UADALP  V30.2S, V31.4H
    SQXTUN  V13.8B, V11.8H
    SADDLP  V7.1D, V26.2S
    ABS  V16.2S, V8.2S
    NEG  D9, D29
    SXTL V27.2D, V0.2S
    REV32  V2.8H, V28.8H
    FRINTZ  V22.4S, V20.4S
    UXTL V5.8H, V22.8B
    USQADD  S12, S6
    SQXTUN  S15, D3
    SQNEG  V6.8H, V26.8H
    SXTL2 V29.8H, V4.16B
    FRSQRTE  S8, S19
    REV32  V13.4H, V3.4H
    SUBS  X2, X2, #0x1
    B.NE  TaishanSimdFpIntConversionP01_label_551
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X6
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X12, X22, X10
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X18, X23, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X12
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X15
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X6, X25, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X18, X7, X18
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X24, X28, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X14, X12, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X8, X23, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X9, X19, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X26
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X27, X5, X29
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, V2.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, D2
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, D3
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, D4
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7f00, LSL #16
    SUB  X29, X16, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, V5.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, D5
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x40, LSL #48
    SUB  X19, X18, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, V6.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, D6
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, D7
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, V8.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, D8
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7f80, LSL #16
    SUB  X20, X10, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, D9
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x200, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, D10
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, V11.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, D11
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, D12
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x7e00, LSL #16
    SUB  X6, X28, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, D14
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, V15.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X21, X9, X2
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, D15
    MOVZ  X9, #0x0, LSL #0
    SUB  X21, X9, X2
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, V16.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X10, X28, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, D16
    MOVZ  X28, #0x0, LSL #0
    SUB  X10, X28, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, V17.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X15
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, D17
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X15
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X17
TaishanSimdFpIntConversionP01_label_286:
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, D18
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D19
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X29
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, D20
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x4000, LSL #16
    SUB  X27, X7, X29
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, D21
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X29, X4, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, D22
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x4000, LSL #16
    SUB  X29, X4, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, D23
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0x3f80, LSL #48
    SUB  X8, X26, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X25, X5, X26
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, D24
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x4000, LSL #16
    SUB  X25, X5, X26
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, V25.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X16, X28, X27
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, D25
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0x7e, LSL #32
    SUB  X16, X28, X27
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, V26.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X23, X10, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, D26
    MOVZ  X10, #0x0, LSL #0
    SUB  X23, X10, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X3, X6, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, D27
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X3, X6, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X18, D28
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D29
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
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
TaishanSimdFpIntConversionP01_label_206:
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
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
    FMOV  D0, X10
    FMOV  V0.D[1], X8
    FMOV  D1, X28
    FMOV  V1.D[1], X11
    FMOV  D2, X24
    FMOV  V2.D[1], X17
    FMOV  D3, X10
    FMOV  V3.D[1], X2
    FMOV  D4, X27
    FMOV  V4.D[1], X7
    FMOV  D5, X25
    FMOV  V5.D[1], X22
    FMOV  D6, X29
    FMOV  V6.D[1], X16
    FMOV  D7, X10
    FMOV  V7.D[1], X19
    FMOV  D8, X23
    FMOV  V8.D[1], X18
    FMOV  D9, X19
    FMOV  V9.D[1], X23
    FMOV  D10, X24
    FMOV  V10.D[1], X5
    FMOV  D11, X9
    FMOV  V11.D[1], X11
    FMOV  D12, X23
    FMOV  V12.D[1], X11
    FMOV  D13, X23
    FMOV  V13.D[1], X12
    FMOV  D14, X26
    FMOV  V14.D[1], X6
    FMOV  D15, X4
    FMOV  V15.D[1], X22
    FMOV  D16, X23
    FMOV  V16.D[1], X8
    FMOV  D17, X24
    FMOV  V17.D[1], X17
    FMOV  D18, X25
    FMOV  V18.D[1], X17
    FMOV  D19, X11
    FMOV  V19.D[1], X7
    FMOV  D20, X9
    FMOV  V20.D[1], X15
    FMOV  D21, X5
    FMOV  V21.D[1], X16
    FMOV  D22, X21
    FMOV  V22.D[1], X6
    FMOV  D23, X27
    FMOV  V23.D[1], X17
    FMOV  D24, X22
    FMOV  V24.D[1], X15
    FMOV  D25, X17
    FMOV  V25.D[1], X28
    FMOV  D26, X26
    FMOV  V26.D[1], X24
    FMOV  D27, X27
    FMOV  V27.D[1], X27
    FMOV  D28, X24
    FMOV  V28.D[1], X29
    FMOV  D29, X21
    FMOV  V29.D[1], X23
    FMOV  D30, X28
    FMOV  V30.D[1], X16
    FMOV  D31, X18
    FMOV  V31.D[1], X18
    MOVZ  X29, #0xf, LSL #0
TaishanSimdFpIntConversionP01_label_626:
    SQNEG  H20, H4
    SQXTUN  B28, H22
    SUQADD  B23, B16
    FRECPX  S29, S29
    SQNEG  S15, S15
    FRINTA  V4.2S, V11.2S
    FRINTM  V11.4S, V5.4S
    UQXTN  S11, D8
    USQADD  V15.2D, V20.2D
    USQADD  S28, S25
    FRINTI  V3.4S, V29.4S
    SXTL V19.2D, V2.2S
    SQABS  D5, D18
    USQADD  S31, S4
    SQNEG  V24.2D, V6.2D
    SQXTN  H5, S3
    SQABS  D6, D24
    SQXTN2  V26.8H, V19.4S
    UADALP  V10.2S, V23.4H
    SQABS  D18, D22
    SXTL V0.2D, V17.2S
    CLZ  V23.8B, V5.8B
    SUQADD  H18, H15
    FRINTX  V22.2D, V23.2D
    FNEG  V18.2S, V5.2S
    SUQADD  H7, H10
    RBIT  V25.16B, V22.16B
    FRINTA  V11.2S, V16.2S
    SQNEG  D29, D8
    SUQADD  D15, D15
    SXTL2 V15.4S, V10.8H
    SQABS  S28, S13
    SXTL2 V7.4S, V13.8H
    FRINTI  V1.2S, V14.2S
    SQXTUN2  V5.4S, V27.2D
    FCVTXN  S28, D23
    USQADD  S3, S18
    FRINTN  V3.2S, V19.2S
    UQXTN  H31, S0
    SQNEG  B17, B25
    UXTL2 V28.2D, V30.4S
TaishanSimdFpIntConversionP01_label_468:
    SQXTUN  H22, S0
    FCVTXN  V13.2S, V3.2D
    SADALP  V12.1D, V10.2S
    FRSQRTE  V24.2S, V31.2S
    FCVTXN  V13.2S, V10.2D
    SUQADD  S24, S31
    UXTL V8.4S, V25.4H
    UADDLP  V31.1D, V24.2S
    UQXTN  S30, D21
    UQXTN2  V24.8H, V28.4S
    SXTL2 V20.2D, V15.4S
    FRINTP  V27.2S, V31.2S
    UXTL V15.4S, V5.4H
    UQXTN  H15, S0
    FRSQRTE  V14.2S, V5.2S
    USQADD  D23, D19
    USQADD  V19.8B, V24.8B
    SQNEG  D7, D8
    SQABS  V18.2S, V12.2S
    SQXTN  V17.4H, V14.4S
    CLS  V15.8H, V5.8H
    SQNEG  S27, S13
    UXTL2 V30.4S, V5.8H
    SQXTN2  V1.8H, V21.4S
    SQNEG  V13.4H, V3.4H
    FRECPX  S2, S24
    REV32  V26.4H, V5.4H
    SUQADD  D14, D5
    REV16  V27.8B, V8.8B
    SQXTUN2  V20.16B, V22.8H
    ABS  D16, D18
    NEG  V16.2S, V11.2S
    SXTL2 V30.2D, V11.4S
    URSQRTE  V6.4S, V7.4S
    FRINTI  V14.4S, V12.4S
    UQXTN  V2.8B, V15.8H
    UQXTN  V5.2S, V14.2D
    USQADD  B31, B25
    SQXTUN  H6, S7
    UXTL2 V28.2D, V6.4S
    UXTL V22.8H, V7.8B
    REV64  V31.4S, V23.4S
    SQXTN2  V2.4S, V23.2D
    FRINTN  V13.4S, V19.4S
    ABS  V21.2D, V18.2D
    FRINTM  V8.2S, V17.2S
    FRINTP  V13.2S, V18.2S
    SQNEG  H0, H24
    SQABS  S11, S8
    SQXTN  B8, H9
    FABS  V11.4S, V14.4S
    FRECPX  S14, S16
    SQABS  H9, H22
    UXTL V15.8H, V30.8B
    SQXTN  S14, D3
    SXTL V3.2D, V18.2S
    FCVTXN  S9, D2
    SADALP  V18.8H, V13.16B
    XTN  V16.4H, V4.4S
    USQADD  H4, H29
    SUQADD  S11, S12
    SXTL V26.2D, V22.2S
    CLS  V22.16B, V0.16B
    FCVTXN  S14, D26
    SQXTN  S15, D24
    SQNEG  V8.8B, V3.8B
    FRSQRTE  S29, S7
    URSQRTE  V20.4S, V22.4S
    ABS  V22.2D, V10.2D
    UXTL2 V27.4S, V12.8H
    UADDLP  V12.4S, V25.8H
    FNEG  V0.2S, V20.2S
    SADALP  V25.2S, V13.4H
    CLZ  V14.4S, V18.4S
    SQXTUN  S2, D10
    REV16  V7.16B, V4.16B
    NEG  D11, D28
    NEG  V7.4H, V20.4H
    SUQADD  H20, H30
    FRINTX  V21.2D, V11.2D
    FCVTXN  V14.2S, V3.2D
    NEG  D13, D12
    RBIT  V9.16B, V8.16B
    USQADD  B20, B17
    FCVTXN2  V16.4S, V9.2D
    SQNEG  S11, S22
    ABS  V18.4S, V1.4S
    USQADD  B24, B25
    UXTL2 V0.4S, V0.8H
    SQNEG  D14, D10
    FRECPX  D19, D25
    SQABS  D20, D27
    SXTL V12.8H, V20.8B
    REV16  V5.16B, V20.16B
    SQNEG  D20, D6
    SQABS  B3, B13
    SXTL V5.4S, V31.4H
    FRECPX  S5, S22
    SADALP  V30.1D, V31.2S
    SQABS  B13, B4
    CNT  V24.16B, V17.16B
    FRINTN  V11.2D, V15.2D
    FRINTM  V17.2S, V18.2S
    XTN  V30.2S, V9.2D
    UQXTN  B16, H9
    UQXTN  B27, H8
    NEG  V22.4S, V15.4S
    SADDLP  V4.1D, V22.2S
    FRECPS  V13.2S, V29.2S, V9.2S
    FABS  V1.2S, V20.2S
    USQADD  D5, D11
    SUQADD  B20, B30
    UXTL V6.4S, V20.4H
    REV32  V31.8H, V29.8H
    UQXTN  H1, S24
    FRINTI  V11.2D, V29.2D
    RBIT  V16.16B, V4.16B
    FRECPS  V25.2S, V16.2S, V8.2S
    NEG  D17, D11
    FRSQRTE  V4.2S, V20.2S
    RBIT  V8.8B, V19.8B
    SQABS  H5, H3
    SUQADD  B16, B22
    UQXTN  B28, H6
    UXTL V27.4S, V18.4H
    UADDLP  V21.1D, V31.2S
    SXTL2 V1.4S, V1.8H
    SUQADD  H15, H25
    USQADD  B31, B25
TaishanSimdFpIntConversionP01_label_166:
    FRECPS  V8.2S, V24.2S, V20.2S
    CLS  V26.4S, V29.4S
    FNEG  V5.4S, V24.4S
    FSQRT  V24.2S, V19.2S
    USQADD  D31, D10
    FRECPS  S25, S6, S5
    SQXTN  S6, D1
    SQNEG  H27, H0
    UADDLP  V12.4H, V19.8B
    SXTL2 V5.4S, V27.8H
    CLS  V8.8B, V21.8B
    FRINTM  V3.2D, V7.2D
    SXTL2 V17.8H, V15.16B
    XTN  V27.8B, V13.8H
    MVN  V7.16B, V16.16B
    USQADD  D17, D25
    UXTL V15.4S, V26.4H
    UQXTN  S29, D12
    UXTL V13.2D, V4.2S
    USQADD  B29, B5
    UQXTN  H10, S22
    SQABS  D15, D22
    SQXTN  H10, S17
    USQADD  D8, D3
    FRECPX  D29, D21
    SQXTUN2  V1.8H, V7.4S
    UQXTN  H21, S16
    FCVTXN  S1, D27
    NOT  V25.16B, V24.16B
    UXTL V2.8H, V23.8B
    SUBS  X29, X29, #0x1
    B.NE  TaishanSimdFpIntConversionP01_label_626
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X10, X12, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X2, X22, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X20, X3, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X14, X2, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X19, X27, X6
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X3, X17, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X11, X26, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X19, X25, X9
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X29, X3, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X29, X9, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X16
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X28, X10, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X24, X26, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X23, X28, X21
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X16, X10, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X23, X3, X23
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X25, X5, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X8, X9, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X14, X24, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X3, X2, X27
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X29, X24, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, V2.D[1]
    MOVZ  X7, #0x8, LSL #0
    MOVK  X7, #0x8, LSL #16
    MOVK  X7, #0x8, LSL #32
    MOVK  X7, #0x8, LSL #48
    SUB  X27, X7, X19
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, D2
    MOVZ  X7, #0xff, LSL #0
    MOVK  X7, #0x1, LSL #16
    MOVK  X7, #0x9, LSL #32
    MOVK  X7, #0x8, LSL #48
    SUB  X27, X7, X19
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, V3.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X10, X28, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, D3
    MOVZ  X28, #0x0, LSL #0
    SUB  X10, X28, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, D4
    MOVZ  X7, #0x8000, LSL #0
    MOVK  X7, #0x6333, LSL #16
    MOVK  X7, #0x7f80, LSL #48
    SUB  X25, X7, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, V5.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, D5
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, D6
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X16, X29, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, D7
    MOVZ  X29, #0xff7e, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X16, X29, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X7, X11, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, D8
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x707, LSL #16
    MOVK  X11, #0x707, LSL #32
    MOVK  X11, #0x707, LSL #48
    SUB  X7, X11, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, V9.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, D9
    MOVZ  X21, #0xfe41, LSL #0
    SUB  X15, X21, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, D10
    MOVZ  X15, #0x7fff, LSL #0
    SUB  X7, X15, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, D11
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x3ff0, LSL #48
    SUB  X29, X5, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, V12.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, D12
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x173, LSL #48
    SUB  X26, X20, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X26
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, D14
    MOVZ  X21, #0x7f82, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X3, X21, X26
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, V15.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, D15
    MOVZ  X2, #0x1, LSL #0
    MOVK  X2, #0x9f4a, LSL #16
    SUB  X11, X2, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, D16
    MOVZ  X21, #0x81, LSL #0
    SUB  X3, X21, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, D17
    MOVZ  X10, #0x1, LSL #0
    MOVK  X10, #0x4000, LSL #16
    SUB  X5, X10, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, V18.D[1]
    MOVZ  X14, #0x81, LSL #0
    SUB  X4, X14, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, D18
    MOVZ  X14, #0x807e, LSL #0
    MOVK  X14, #0x1, LSL #32
    SUB  X4, X14, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X6, X23, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, D19
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x83f0, LSL #48
    SUB  X6, X23, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, D20
    MOVZ  X7, #0x41, LSL #0
    SUB  X10, X7, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, V21.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X12, X24, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, D21
    MOVZ  X24, #0x81, LSL #0
    SUB  X12, X24, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, V22.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X21, X12, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, D22
    MOVZ  X12, #0x1, LSL #0
    MOVK  X12, #0x9f4a, LSL #16
    SUB  X21, X12, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X18, D23
    MOVZ  X24, #0x1ff, LSL #0
    MOVK  X24, #0x809, LSL #16
    MOVK  X24, #0x808, LSL #32
    MOVK  X24, #0x808, LSL #48
    SUB  X29, X24, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X9, X19, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, D24
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7fc0, LSL #48
    SUB  X9, X19, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, V25.D[1]
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X24, X21, X15
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, D25
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0x803f, LSL #48
    SUB  X24, X21, X15
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, V26.D[1]
    MOVZ  X23, #0x1f, LSL #0
    MOVK  X23, #0x1f, LSL #32
    SUB  X15, X23, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, D26
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x1f, LSL #32
    SUB  X15, X23, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, V27.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, D27
    MOVZ  X26, #0x8000, LSL #0
    SUB  X4, X26, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, D28
    MOVZ  X10, #0x41, LSL #0
    SUB  X27, X10, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X8, X9, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, D29
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x7fe0, LSL #48
    SUB  X8, X9, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X2, #0xfc44, LSL #0
    MOVK  X2, #0x7cfa, LSL #16
    MOVK  X2, #0x6b63, LSL #32
    MOVK  X2, #0x2ca2, LSL #48
    MOVZ  X3, #0xea7e, LSL #0
    MOVK  X3, #0xe050, LSL #16
    MOVK  X3, #0x7225, LSL #32
    MOVK  X3, #0x5282, LSL #48
    MOVZ  X4, #0x2c5, LSL #0
    MOVK  X4, #0x326e, LSL #16
    MOVK  X4, #0x29d4, LSL #32
    MOVK  X4, #0x3644, LSL #48
    MOVZ  X5, #0x1734, LSL #0
    MOVK  X5, #0x568c, LSL #16
    MOVK  X5, #0x4d58, LSL #32
    MOVK  X5, #0xca7d, LSL #48
    MOVZ  X6, #0xeb1, LSL #0
    MOVK  X6, #0xb7b, LSL #16
    MOVK  X6, #0x121c, LSL #32
    MOVK  X6, #0x6a68, LSL #48
    MOVZ  X7, #0xe2a2, LSL #0
    MOVK  X7, #0xbb6c, LSL #16
    MOVK  X7, #0x830a, LSL #32
    MOVK  X7, #0x8fb4, LSL #48
    MOVZ  X8, #0xd5f3, LSL #0
    MOVK  X8, #0xf83f, LSL #16
    MOVK  X8, #0xbda5, LSL #32
    MOVK  X8, #0x389c, LSL #48
    MOVZ  X9, #0x8e2, LSL #0
    MOVK  X9, #0xc9bc, LSL #16
    MOVK  X9, #0xc8f3, LSL #32
    MOVK  X9, #0x3772, LSL #48
    MOVZ  X10, #0xe9f4, LSL #0
    MOVK  X10, #0x2195, LSL #16
    MOVK  X10, #0x5e59, LSL #32
    MOVK  X10, #0xf1b1, LSL #48
    MOVZ  X11, #0x57f8, LSL #0
    MOVK  X11, #0x76ad, LSL #16
    MOVK  X11, #0x7ce3, LSL #32
    MOVK  X11, #0x395, LSL #48
    MOVZ  X12, #0x7e38, LSL #0
    MOVK  X12, #0xc557, LSL #16
    MOVK  X12, #0x6a30, LSL #32
    MOVK  X12, #0xc803, LSL #48
    MOVZ  X14, #0xc52c, LSL #0
    MOVK  X14, #0xe7ab, LSL #16
    MOVK  X14, #0x2924, LSL #32
    MOVK  X14, #0x5cd, LSL #48
    MOVZ  X15, #0x5205, LSL #0
    MOVK  X15, #0x43f3, LSL #16
    MOVK  X15, #0x2043, LSL #32
    MOVK  X15, #0x4f7a, LSL #48
    MOVZ  X16, #0xb74b, LSL #0
    MOVK  X16, #0xa8e2, LSL #16
    MOVK  X16, #0x84a9, LSL #32
    MOVK  X16, #0x96be, LSL #48
    MOVZ  X17, #0xd964, LSL #0
    MOVK  X17, #0x71aa, LSL #16
    MOVK  X17, #0xfeec, LSL #32
    MOVK  X17, #0xc6fc, LSL #48
    MOVZ  X18, #0x6cf5, LSL #0
    MOVK  X18, #0xd89, LSL #16
    MOVK  X18, #0x7a30, LSL #32
    MOVK  X18, #0xeace, LSL #48
    MOVZ  X19, #0x2049, LSL #0
    MOVK  X19, #0x13f9, LSL #16
    MOVK  X19, #0xc40e, LSL #32
    MOVK  X19, #0x1de7, LSL #48
    MOVZ  X20, #0x2008, LSL #0
    MOVK  X20, #0x44d8, LSL #16
    MOVK  X20, #0xfd34, LSL #32
    MOVK  X20, #0x1689, LSL #48
    MOVZ  X21, #0xf1ee, LSL #0
    MOVK  X21, #0x8280, LSL #16
    MOVK  X21, #0xaa6c, LSL #32
    MOVK  X21, #0x1d32, LSL #48
    MOVZ  X22, #0xf1c6, LSL #0
    MOVK  X22, #0xcce1, LSL #16
    MOVK  X22, #0x41f2, LSL #32
    MOVK  X22, #0xb1f2, LSL #48
    MOVZ  X23, #0x188b, LSL #0
    MOVK  X23, #0x68d7, LSL #16
    MOVK  X23, #0x1458, LSL #32
    MOVK  X23, #0x8301, LSL #48
    MOVZ  X24, #0x27c4, LSL #0
    MOVK  X24, #0xc0c4, LSL #16
    MOVK  X24, #0x1d52, LSL #32
    MOVK  X24, #0xb493, LSL #48
    MOVZ  X25, #0x3e22, LSL #0
    MOVK  X25, #0x98c8, LSL #16
    MOVK  X25, #0x7381, LSL #32
    MOVK  X25, #0x9a26, LSL #48
    MOVZ  X26, #0xab59, LSL #0
    MOVK  X26, #0xdd22, LSL #16
    MOVK  X26, #0xa01e, LSL #32
    MOVK  X26, #0xb358, LSL #48
    MOVZ  X27, #0x3033, LSL #0
    MOVK  X27, #0xbc9, LSL #16
    MOVK  X27, #0x53e9, LSL #32
    MOVK  X27, #0xb00a, LSL #48
    MOVZ  X28, #0x371a, LSL #0
    MOVK  X28, #0x75cc, LSL #16
    MOVK  X28, #0x700a, LSL #32
    MOVK  X28, #0x856f, LSL #48
    MOVZ  X29, #0x5a60, LSL #0
    MOVK  X29, #0x142c, LSL #16
    MOVK  X29, #0x4af9, LSL #32
    MOVK  X29, #0x69d9, LSL #48
    FMOV  D0, X21
    FMOV  V0.D[1], X24
    FMOV  D1, X15
    FMOV  V1.D[1], X10
    FMOV  D2, X24
    FMOV  V2.D[1], X28
    FMOV  D3, X22
    FMOV  V3.D[1], X17
    FMOV  D4, X7
    FMOV  V4.D[1], X27
    FMOV  D5, X29
    FMOV  V5.D[1], X7
    FMOV  D6, X12
    FMOV  V6.D[1], X11
    FMOV  D7, X3
    FMOV  V7.D[1], X6
    FMOV  D8, X7
    FMOV  V8.D[1], X29
    FMOV  D9, X2
    FMOV  V9.D[1], X6
    FMOV  D10, X14
    FMOV  V10.D[1], X27
    FMOV  D11, X5
    FMOV  V11.D[1], X16
    FMOV  D12, X26
    FMOV  V12.D[1], X16
    FMOV  D13, X25
    FMOV  V13.D[1], X28
    FMOV  D14, X22
    FMOV  V14.D[1], X25
    FMOV  D15, X10
    FMOV  V15.D[1], X18
    FMOV  D16, X7
    FMOV  V16.D[1], X11
    FMOV  D17, X9
    FMOV  V17.D[1], X21
    FMOV  D18, X15
    FMOV  V18.D[1], X22
    FMOV  D19, X17
    FMOV  V19.D[1], X7
    FMOV  D20, X5
    FMOV  V20.D[1], X27
    FMOV  D21, X20
    FMOV  V21.D[1], X24
    FMOV  D22, X9
    FMOV  V22.D[1], X20
    FMOV  D23, X10
    FMOV  V23.D[1], X16
    FMOV  D24, X16
    FMOV  V24.D[1], X16
    FMOV  D25, X2
    FMOV  V25.D[1], X25
    FMOV  D26, X16
    FMOV  V26.D[1], X18
    FMOV  D27, X15
    FMOV  V27.D[1], X29
    FMOV  D28, X28
    FMOV  V28.D[1], X19
    FMOV  D29, X26
    FMOV  V29.D[1], X15
    FMOV  D30, X20
    FMOV  V30.D[1], X15
    FMOV  D31, X16
    FMOV  V31.D[1], X19
    MOVZ  X7, #0xa, LSL #0
TaishanSimdFpIntConversionP01_label_699:
    CNT  V6.16B, V21.16B
    SQABS  V14.16B, V17.16B
    SQXTUN  H26, S17
    ABS  V30.16B, V22.16B
    SQXTN2  V17.4S, V26.2D
    SUQADD  H16, H29
    REV32  V30.16B, V12.16B
    FRECPX  S21, S13
    SQABS  D27, D14
    FNEG  V30.4S, V19.4S
    SXTL2 V10.4S, V5.8H
    USQADD  V20.2S, V31.2S
    FRINTX  V28.2D, V17.2D
    URSQRTE  V29.2S, V10.2S
    SQXTN  H30, S17
    FRSQRTE  V20.2S, V18.2S
    SXTL2 V30.4S, V20.8H
    FCVTXN2  V11.4S, V16.2D
    SQXTUN  V19.2S, V4.2D
    FRINTP  V28.2D, V6.2D
    URECPE  V26.4S, V1.4S
    UXTL V18.8H, V11.8B
    FRSQRTE  S0, S22
    FCVTXN2  V31.4S, V8.2D
    SQXTN2  V20.4S, V20.2D
    NEG  D18, D13
    USQADD  S16, S26
    FRINTI  V20.4S, V9.4S
    SQABS  H31, H16
    SQXTUN2  V7.8H, V28.4S
    FRSQRTE  S10, S30
    SQXTUN  S13, D7
    FNEG  V21.2D, V10.2D
    SQABS  B12, B22
    USQADD  B29, B10
    FRECPX  D11, D16
    ABS  D20, D25
    SXTL V2.4S, V3.4H
    USQADD  B7, B10
    URSQRTE  V12.2S, V4.2S
    FRINTM  V30.4S, V31.4S
    URSQRTE  V8.4S, V12.4S
    UXTL2 V18.2D, V27.4S
    SQNEG  S12, S23
    NEG  V15.16B, V21.16B
    FRINTN  V23.2S, V13.2S
    SQABS  V10.8H, V31.8H
    UADALP  V19.2S, V14.4H
    UXTL V29.8H, V11.8B
    CNT  V29.16B, V28.16B
    FRINTA  V15.4S, V9.4S
    SUQADD  B15, B25
    SQXTUN2  V13.4S, V13.2D
    UXTL V9.4S, V5.4H
    FRINTX  V29.2D, V12.2D
    FCVTXN2  V30.4S, V25.2D
    SQNEG  S8, S5
    FRINTI  V14.4S, V14.4S
    USQADD  V12.16B, V6.16B
    FABS  V6.4S, V27.4S
    FRSQRTE  S28, S15
    USQADD  H17, H26
    SUQADD  S17, S25
    UXTL V10.4S, V1.4H
    SQNEG  V17.2S, V16.2S
    UQXTN  B10, H21
    SQXTN  B17, H9
    SADALP  V13.8H, V12.16B
    SQXTN  S9, D16
    NOT  V13.8B, V15.8B
    UADALP  V6.4H, V1.8B
    SUQADD  D16, D26
    FRINTZ  V4.2S, V16.2S
    UQXTN2  V26.16B, V28.8H
    USQADD  D14, D22
    SQNEG  H8, H1
    SQXTUN  B13, H16
    SQNEG  H24, H13
    UADALP  V16.1D, V28.2S
    CLS  V6.2S, V5.2S
    CNT  V15.16B, V8.16B
    CLZ  V17.16B, V8.16B
    FRSQRTE  D20, D11
    SQABS  S7, S22
    FRINTI  V25.2S, V17.2S
    FRINTP  V26.2S, V6.2S
    URSQRTE  V14.2S, V12.2S
    FRINTM  V12.2D, V23.2D
    SUQADD  D4, D0
    FRINTN  V15.2S, V0.2S
    FRECPX  S14, S14
    USQADD  V3.8B, V22.8B
    SQABS  D25, D26
    SQNEG  H15, H16
    FRINTI  V13.2D, V11.2D
    SQXTN  H1, S31
    REV16  V28.8B, V16.8B
    NEG  V2.8H, V17.8H
    USQADD  S5, S27
    SUQADD  H25, H12
    SXTL2 V24.4S, V19.8H
    UQXTN  S10, D0
    FNEG  V5.2D, V13.2D
    SUQADD  S16, S10
    FRINTA  V26.4S, V21.4S
    SXTL2 V11.2D, V7.4S
    SQXTN  V20.4H, V15.4S
    UXTL V17.2D, V6.2S
    SQABS  B30, B5
    REV32  V13.8B, V15.8B
    FNEG  V3.2S, V22.2S
    FABS  V20.2D, V17.2D
    SQXTN  V28.8B, V29.8H
    SQXTUN  V17.8B, V15.8H
    FRINTP  V24.2S, V6.2S
    SQABS  S31, S0
    SQXTUN2  V21.8H, V13.4S
    FRECPX  S3, S5
    SQABS  H28, H12
    SXTL V17.2D, V26.2S
    USQADD  V19.2S, V27.2S
    REV64  V11.8B, V19.8B
    RBIT  V13.16B, V4.16B
    SQXTN  V10.8B, V20.8H
    FRECPX  D0, D5
    REV64  V5.8H, V10.8H
    FRSQRTE  S20, S9
    SADDLP  V10.4S, V31.8H
    FRINTM  V23.2D, V10.2D
    UQXTN2  V0.4S, V13.2D
    URECPE  V12.2S, V14.2S
    USQADD  H1, H18
    SXTL V12.8H, V8.8B
    CLZ  V27.8B, V24.8B
    REV64  V23.8H, V0.8H
    SXTL V17.8H, V19.8B
    SXTL2 V11.8H, V4.16B
    UQXTN2  V4.8H, V23.4S
    SUQADD  B19, B15
    SQXTN2  V23.8H, V24.4S
    SQXTN  S6, D4
    UXTL V4.4S, V0.4H
    SQXTUN  V25.8B, V18.8H
    SXTL2 V7.8H, V14.16B
    FCVTXN  S16, D25
    UADDLP  V9.4H, V17.8B
    SUQADD  S13, S17
    FCVTXN  S9, D25
    SQNEG  D11, D1
    REV16  V15.16B, V9.16B
    REV32  V23.8B, V17.8B
    SQNEG  D9, D24
    FRINTX  V15.2D, V6.2D
    REV32  V29.8H, V18.8H
    FRECPX  D1, D31
    SQNEG  S16, S15
    SUQADD  S1, S1
    SQXTUN  H19, S6
    SADALP  V22.4H, V7.8B
    FRECPS  V27.4S, V27.4S, V24.4S
    FRECPX  D19, D2
    SADALP  V24.2D, V18.4S
    SQNEG  S23, S14
    MVN  V20.8B, V25.8B
    UXTL2 V30.2D, V29.4S
    UXTL V25.8H, V28.8B
    USQADD  V24.8B, V14.8B
    SUQADD  V30.2S, V19.2S
    SQXTUN2  V17.4S, V28.2D
    SQXTUN  V6.4H, V15.4S
    CNT  V17.16B, V14.16B
    SUQADD  V13.2D, V27.2D
    SUQADD  V0.2D, V28.2D
    FRINTZ  V31.4S, V31.4S
    SUQADD  V27.16B, V27.16B
    RBIT  V4.8B, V31.8B
    FRINTA  V5.4S, V5.4S
    ABS  D10, D8
    FCVTXN  V19.2S, V8.2D
    FCVTXN2  V22.4S, V28.2D
    FCVTXN2  V17.4S, V20.2D
    USQADD  B10, B27
    SQXTUN2  V11.8H, V28.4S
    USQADD  D4, D22
    FRECPX  S29, S2
    SQNEG  H11, H31
    FRSQRTE  V20.2S, V12.2S
    FABS  V21.2S, V11.2S
    USQADD  H28, H10
    FCVTXN  S25, D12
    UQXTN  V27.4H, V17.4S
    UXTL2 V10.2D, V25.4S
    USQADD  H14, H4
    UQXTN  S19, D10
    SQXTUN  B11, H4
    SUQADD  V21.8H, V21.8H
    FRECPX  S15, S2
    UXTL V6.2D, V22.2S
    FRINTX  V3.2S, V14.2S
    FRINTX  V14.4S, V3.4S
    SUBS  X7, X7, #0x1
    B.NE  TaishanSimdFpIntConversionP01_label_699
    MOVZ  X17, #0xfc44, LSL #0
    MOVK  X17, #0x7cfa, LSL #16
    MOVK  X17, #0x6b63, LSL #32
    MOVK  X17, #0x2ca2, LSL #48
    SUB  X27, X17, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X24, #0xea7e, LSL #0
    MOVK  X24, #0xe050, LSL #16
    MOVK  X24, #0x7225, LSL #32
    MOVK  X24, #0x5282, LSL #48
    SUB  X26, X24, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X9, #0x2c5, LSL #0
    MOVK  X9, #0x326e, LSL #16
    MOVK  X9, #0x29d4, LSL #32
    MOVK  X9, #0x3644, LSL #48
    SUB  X16, X9, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X6, #0x1734, LSL #0
    MOVK  X6, #0x568c, LSL #16
    MOVK  X6, #0x4d58, LSL #32
    MOVK  X6, #0xca7d, LSL #48
    SUB  X5, X6, X5
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X19, #0x1734, LSL #0
    MOVK  X19, #0x568c, LSL #16
    MOVK  X19, #0x4d58, LSL #32
    MOVK  X19, #0xca7d, LSL #48
    SUB  X26, X19, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X12, X9, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X28, #0xd5f3, LSL #0
    MOVK  X28, #0xf83f, LSL #16
    MOVK  X28, #0xbda5, LSL #32
    MOVK  X28, #0x389c, LSL #48
    SUB  X18, X28, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X18, #0xe9f4, LSL #0
    MOVK  X18, #0x2195, LSL #16
    MOVK  X18, #0x5e59, LSL #32
    MOVK  X18, #0xf1b1, LSL #48
    SUB  X17, X18, X10
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X5, #0x57f8, LSL #0
    MOVK  X5, #0x76ad, LSL #16
    MOVK  X5, #0x7ce3, LSL #32
    MOVK  X5, #0x395, LSL #48
    SUB  X12, X5, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X14
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X5, #0x5205, LSL #0
    MOVK  X5, #0x43f3, LSL #16
    MOVK  X5, #0x2043, LSL #32
    MOVK  X5, #0x4f7a, LSL #48
    SUB  X17, X5, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X24, X2, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X8, #0xe9f4, LSL #0
    MOVK  X8, #0x2195, LSL #16
    MOVK  X8, #0x5e59, LSL #32
    MOVK  X8, #0xf1b1, LSL #48
    SUB  X10, X8, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X5, #0x1734, LSL #0
    MOVK  X5, #0x568c, LSL #16
    MOVK  X5, #0x4d58, LSL #32
    MOVK  X5, #0xca7d, LSL #48
    SUB  X19, X5, X19
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X22, #0xf1ee, LSL #0
    MOVK  X22, #0x8280, LSL #16
    MOVK  X22, #0xaa6c, LSL #32
    MOVK  X22, #0x1d32, LSL #48
    SUB  X27, X22, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X15, #0xf1ee, LSL #0
    MOVK  X15, #0x8280, LSL #16
    MOVK  X15, #0xaa6c, LSL #32
    MOVK  X15, #0x1d32, LSL #48
    SUB  X7, X15, X22
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X15, #0x188b, LSL #0
    MOVK  X15, #0x68d7, LSL #16
    MOVK  X15, #0x1458, LSL #32
    MOVK  X15, #0x8301, LSL #48
    SUB  X25, X15, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X24
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X21, X26, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X5, #0xd5f3, LSL #0
    MOVK  X5, #0xf83f, LSL #16
    MOVK  X5, #0xbda5, LSL #32
    MOVK  X5, #0x389c, LSL #48
    SUB  X18, X5, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X11, #0x5a60, LSL #0
    MOVK  X11, #0x142c, LSL #16
    MOVK  X11, #0x4af9, LSL #32
    MOVK  X11, #0x69d9, LSL #48
    SUB  X21, X11, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, V2.D[1]
    MOVZ  X9, #0xf7f8, LSL #0
    MOVK  X9, #0xf7f8, LSL #16
    MOVK  X9, #0xf7f8, LSL #32
    MOVK  X9, #0xf7f8, LSL #48
    SUB  X11, X9, X25
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, D2
    MOVZ  X9, #0xf7f8, LSL #0
    MOVK  X9, #0xf7f8, LSL #16
    MOVK  X9, #0xf7f8, LSL #32
    MOVK  X9, #0xf7f8, LSL #48
    SUB  X11, X9, X25
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X26
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, D3
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x3f80, LSL #16
    SUB  X24, X27, X26
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, D4
    MOVZ  X20, #0x8e2, LSL #0
    MOVK  X20, #0xc7bf, LSL #16
    MOVK  X20, #0xc8f4, LSL #32
    MOVK  X20, #0x3772, LSL #48
    SUB  X22, X20, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D5
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, V6.D[1]
    MOVZ  X28, #0xc8f3, LSL #0
    MOVK  X28, #0x3772, LSL #16
    SUB  X11, X28, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, D6
    MOVZ  X28, #0x8e2, LSL #0
    MOVK  X28, #0xc9bc, LSL #16
    SUB  X11, X28, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, D7
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, D8
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, D9
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0xc080, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xc07f, LSL #48
    SUB  X26, X20, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, D10
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X27, X14, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, D11
    MOVZ  X14, #0xff, LSL #0
    SUB  X27, X14, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, D12
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X18, X23, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, D14
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x3f80, LSL #16
    SUB  X18, X23, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, D15
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x8800, LSL #16
    SUB  X4, X3, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, V16.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X6, X29, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, D16
    MOVZ  X29, #0x0, LSL #0
    SUB  X6, X29, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V17.D[1]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X11, X15, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D17
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x800, LSL #16
    SUB  X11, X15, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, D18
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D19
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X26
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, D20
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x7f80, LSL #16
    MOVK  X9, #0x7f80, LSL #48
    SUB  X25, X9, X26
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, V21.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, D21
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, V22.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X25
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, D22
    MOVZ  X16, #0x8e2, LSL #0
    MOVK  X16, #0xc9bc, LSL #16
    MOVK  X16, #0xc8f3, LSL #32
    MOVK  X16, #0x3772, LSL #48
    SUB  X19, X16, X25
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, D23
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x100, LSL #16
    SUB  X7, X28, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, V24.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, D24
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x3e80, LSL #16
    MOVK  X27, #0x3f80, LSL #48
    SUB  X18, X27, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, D25
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x8000, LSL #48
    SUB  X6, X7, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, D26
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7f80, LSL #16
    MOVK  X7, #0x8000, LSL #48
    SUB  X6, X7, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, V27.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, D27
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #32
    SUB  X28, X16, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, V28.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, D28
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, D29
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x8800, LSL #16
    SUB  X11, X28, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
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
    FMOV  D0, X20
    FMOV  V0.D[1], X23
    FMOV  D1, X5
    FMOV  V1.D[1], X9
    FMOV  D2, X12
    FMOV  V2.D[1], X17
    FMOV  D3, X27
    FMOV  V3.D[1], X20
    FMOV  D4, X12
    FMOV  V4.D[1], X19
    FMOV  D5, X9
    FMOV  V5.D[1], X29
    FMOV  D6, X21
    FMOV  V6.D[1], X28
    FMOV  D7, X19
    FMOV  V7.D[1], X26
    FMOV  D8, X17
    FMOV  V8.D[1], X19
    FMOV  D9, X21
    FMOV  V9.D[1], X7
    FMOV  D10, X11
    FMOV  V10.D[1], X10
    FMOV  D11, X23
    FMOV  V11.D[1], X19
    FMOV  D12, X12
    FMOV  V12.D[1], X17
    FMOV  D13, X11
    FMOV  V13.D[1], X11
    FMOV  D14, X29
    FMOV  V14.D[1], X28
    FMOV  D15, X11
    FMOV  V15.D[1], X29
    FMOV  D16, X26
    FMOV  V16.D[1], X20
    FMOV  D17, X28
    FMOV  V17.D[1], X21
    FMOV  D18, X18
    FMOV  V18.D[1], X4
    FMOV  D19, X15
    FMOV  V19.D[1], X18
    FMOV  D20, X21
    FMOV  V20.D[1], X4
    FMOV  D21, X26
    FMOV  V21.D[1], X2
    FMOV  D22, X12
    FMOV  V22.D[1], X27
    FMOV  D23, X23
    FMOV  V23.D[1], X19
    FMOV  D24, X20
    FMOV  V24.D[1], X2
    FMOV  D25, X19
    FMOV  V25.D[1], X2
    FMOV  D26, X6
    FMOV  V26.D[1], X11
    FMOV  D27, X29
    FMOV  V27.D[1], X9
    FMOV  D28, X29
    FMOV  V28.D[1], X21
    FMOV  D29, X7
    FMOV  V29.D[1], X7
    FMOV  D30, X15
    FMOV  V30.D[1], X12
    FMOV  D31, X16
    FMOV  V31.D[1], X23
    MOVZ  X3, #0xa, LSL #0
TaishanSimdFpIntConversionP01_label_769:
    SQABS  V16.8H, V20.8H
    SQABS  B5, B31
    FABS  V31.4S, V26.4S
    FRSQRTE  S15, S28
    NOT  V10.16B, V31.16B
    FRINTA  V24.2S, V5.2S
    FRINTI  V11.4S, V21.4S
    UXTL V13.8H, V19.8B
    SQNEG  S18, S26
    SQXTUN  B30, H30
    SADDLP  V20.2S, V24.4H
    SXTL2 V2.2D, V18.4S
    UQXTN  V15.8B, V11.8H
    SQXTUN  V14.8B, V6.8H
    SQXTUN  B21, H20
    USQADD  V11.2D, V1.2D
    FRINTA  V11.2D, V21.2D
    SQXTN2  V18.8H, V10.4S
    UQXTN2  V19.16B, V4.8H
    SQXTN  S26, D18
    UXTL V12.8H, V12.8B
    SQXTN2  V12.8H, V26.4S
    XTN2  V13.16B, V13.8H
    FNEG  V18.4S, V7.4S
    SADALP  V21.4S, V18.8H
    UXTL V21.8H, V31.8B
    SADDLP  V17.4H, V1.8B
    SXTL2 V25.4S, V11.8H
    UQXTN2  V5.8H, V2.4S
    SADALP  V25.4H, V14.8B
    SUQADD  V13.2D, V19.2D
    FRECPS  D22, D13, D27
    UQXTN  V27.4H, V16.4S
    SQXTN  V31.4H, V21.4S
    USQADD  S27, S12
    FRINTA  V27.2S, V22.2S
    UXTL V2.8H, V15.8B
    SQXTN  V16.4H, V17.4S
    FSQRT  V4.2D, V16.2D
    UQXTN  B20, H31
    SQXTUN2  V27.4S, V26.2D
    UXTL V25.2D, V25.2S
    SXTL V2.8H, V7.8B
    SXTL V14.2D, V1.2S
    SQXTN  V21.4H, V13.4S
    FABS  V18.2D, V7.2D
    FRINTN  V12.4S, V14.4S
    USQADD  B12, B6
    SQXTN  V22.4H, V25.4S
    CNT  V2.16B, V7.16B
    SQNEG  B21, B27
    URSQRTE  V7.4S, V19.4S
    SQNEG  V27.8H, V30.8H
    SQABS  H11, H22
    SQNEG  H16, H15
    XTN  V17.4H, V12.4S
    FRSQRTE  S25, S18
    USQADD  B5, B20
    NEG  V24.4H, V11.4H
    SQNEG  S17, S15
    SUQADD  B27, B27
    SQXTN  H30, S7
    SQNEG  H0, H27
    FNEG  V12.2D, V2.2D
    SQNEG  B17, B21
    SUQADD  V25.8B, V9.8B
    FCVTXN  V14.2S, V10.2D
    SXTL V15.4S, V28.4H
    SUQADD  B11, B28
    FCVTXN2  V6.4S, V8.2D
    UXTL2 V15.2D, V14.4S
    REV16  V19.8B, V21.8B
    UXTL V1.2D, V18.2S
    MVN  V9.8B, V16.8B
    SXTL V6.4S, V9.4H
    SQXTN  V24.4H, V21.4S
    CLS  V7.8B, V31.8B
    SUQADD  S17, S10
    USQADD  B28, B11
    FRINTX  V25.2S, V1.2S
    UADDLP  V10.4H, V15.8B
    FRSQRTE  S25, S15
    SQABS  B9, B12
    USQADD  H19, H10
    FABS  V5.2D, V18.2D
    SQXTN  V17.8B, V7.8H
    SXTL V5.4S, V0.4H
    USQADD  D14, D4
    SQNEG  H3, H15
    SXTL2 V28.2D, V5.4S
    FRECPS  V5.2S, V25.2S, V15.2S
    REV64  V27.16B, V0.16B
    UQXTN  B25, H29
    SQNEG  H19, H21
    FRINTA  V4.2S, V10.2S
    FRSQRTE  V23.4S, V20.4S
    UXTL V13.8H, V9.8B
    FCVTXN2  V19.4S, V18.2D
    UQXTN  V18.4H, V17.4S
    NOT  V21.8B, V31.8B
    FABS  V8.2D, V25.2D
    FRINTZ  V7.4S, V25.4S
    UXTL V10.4S, V21.4H
    ABS  D9, D8
    SQNEG  V27.8H, V7.8H
    SADDLP  V22.8H, V30.16B
    NOT  V5.8B, V7.8B
    XTN  V20.8B, V12.8H
    SXTL2 V31.2D, V5.4S
    SQNEG  H25, H13
    FRINTM  V25.4S, V12.4S
    SUQADD  B15, B15
    USQADD  S4, S29
    XTN2  V18.16B, V0.8H
    USQADD  B6, B19
    FCVTXN  V20.2S, V20.2D
    SXTL V12.8H, V13.8B
    FRINTX  V0.4S, V26.4S
    SXTL2 V9.8H, V27.16B
    SXTL2 V22.8H, V1.16B
    SUQADD  V18.8B, V9.8B
    SQNEG  H26, H12
    FRINTX  V27.2S, V9.2S
    FRSQRTE  S17, S7
    FRSQRTE  D9, D26
    FRECPX  S0, S25
    UXTL2 V22.2D, V31.4S
    FCVTXN2  V6.4S, V5.2D
    SQABS  V7.4H, V0.4H
    SQNEG  D8, D9
    REV32  V7.4H, V18.4H
    SXTL V17.4S, V31.4H
    UADALP  V27.1D, V29.2S
    SQNEG  H18, H22
    FRINTN  V18.2S, V16.2S
    SQNEG  S13, S8
    USQADD  B2, B19
    ABS  D29, D11
    FRINTI  V26.2S, V6.2S
    FRSQRTE  S7, S2
    SQXTN  V26.4H, V7.4S
    SQABS  B4, B13
    SQABS  B21, B16
    USQADD  B7, B22
    UQXTN  H7, S7
    USQADD  V5.4H, V19.4H
    SXTL2 V11.4S, V13.8H
    REV16  V20.16B, V4.16B
    SUQADD  S7, S9
    UQXTN  S8, D27
    FRECPX  S26, S3
    SUQADD  S8, S19
    SQNEG  S0, S0
    SUQADD  H27, H3
    SQXTN  V17.8B, V26.8H
    REV16  V0.16B, V16.16B
    USQADD  D0, D15
    FRECPS  S19, S8, S30
    SQXTUN2  V16.4S, V8.2D
    SQXTUN  S7, D13
    SXTL2 V28.2D, V12.4S
    SUQADD  D4, D23
    UXTL V10.4S, V21.4H
    SUQADD  H17, H5
    USQADD  H27, H16
    XTN  V2.8B, V0.8H
    URECPE  V29.4S, V26.4S
    SUQADD  B3, B22
    XTN2  V26.8H, V6.4S
    FRECPX  S12, S11
    SUQADD  V13.4H, V31.4H
    USQADD  S5, S15
    SQXTN2  V19.8H, V2.4S
    SQXTUN  S29, D18
    SQABS  H20, H26
    USQADD  H17, H8
    RBIT  V28.8B, V8.8B
    URECPE  V11.4S, V17.4S
    SQNEG  V8.2D, V27.2D
    SQNEG  D7, D19
    FCVTXN  V14.2S, V0.2D
    FRINTM  V10.2S, V26.2S
    FRINTX  V13.2D, V4.2D
    SQNEG  H3, H7
    SQXTUN  B14, H29
    SQABS  V7.2S, V10.2S
    SXTL V1.2D, V30.2S
    UXTL V15.8H, V23.8B
    UQXTN2  V19.4S, V9.2D
    FRINTI  V27.2S, V25.2S
    FCVTXN  S17, D23
    MVN  V2.8B, V11.8B
    SQNEG  H30, H7
    SQXTN  B27, H29
    SXTL V25.2D, V31.2S
    FRINTZ  V10.2S, V26.2S
    SQXTN  V9.2S, V26.2D
    SUQADD  D26, D26
    SQABS  V16.2S, V8.2S
    SQABS  B31, B7
    SUBS  X3, X3, #0x1
    B.NE  TaishanSimdFpIntConversionP01_label_769
    MOVZ  X11, #0x0, LSL #0
    SUB  X12, X11, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X5
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X3, X15, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X9
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X28, X4, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X26, X4, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X5, X17, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X19
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X7, X3, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X11, X23, X25
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, D2
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, D3
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X11, X24, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, D4
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x7f80, LSL #16
    MOVK  X24, #0x7f80, LSL #48
    SUB  X11, X24, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, D5
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X26, X17, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, V6.D[1]
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X9, X21, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, D6
    MOVZ  X21, #0xff, LSL #0
    SUB  X9, X21, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, D7
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x7f00, LSL #16
    SUB  X18, X29, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X14, X29, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, D8
    MOVZ  X29, #0x0, LSL #0
    SUB  X14, X29, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X18, V9.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X18, D9
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7f00, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0x7fff, LSL #48
    SUB  X4, X23, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, V10.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, D10
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x7f00, LSL #16
    SUB  X24, X17, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, V11.D[1]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X23, X22, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, D11
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X23, X22, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, D12
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x7f00, LSL #16
    SUB  X21, X2, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, V14.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X4
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, D14
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X4
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x80, LSL #32
    MOVK  X16, #0x7f, LSL #48
    SUB  X18, X16, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, D15
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x80, LSL #32
    MOVK  X16, #0x7f, LSL #48
    SUB  X18, X16, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, V16.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, D16
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, D17
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0x7f7f, LSL #16
    SUB  X28, X12, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, V18.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X3, X28, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, D18
    MOVZ  X28, #0x0, LSL #0
    SUB  X3, X28, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, V19.D[1]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X21, X22, X15
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, D19
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x4000, LSL #16
    SUB  X21, X22, X15
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, D20
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V21.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D21
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X16
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, D22
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X16
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, V23.D[1]
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7f80, LSL #16
    MOVK  X7, #0x7f80, LSL #48
    SUB  X11, X7, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, D23
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7f80, LSL #16
    MOVK  X7, #0x7f80, LSL #48
    SUB  X11, X7, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, V24.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, D24
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D25
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, V26.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, D26
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xfe00, LSL #16
    SUB  X12, X4, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, V27.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X17, X14, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, D27
    MOVZ  X14, #0x0, LSL #0
    SUB  X17, X14, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, V28.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, D28
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, D29
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
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
    FMOV  D0, X19
    FMOV  V0.D[1], X26
    FMOV  D1, X15
    FMOV  V1.D[1], X19
    FMOV  D2, X6
    FMOV  V2.D[1], X23
    FMOV  D3, X17
    FMOV  V3.D[1], X9
    FMOV  D4, X5
    FMOV  V4.D[1], X27
    FMOV  D5, X4
    FMOV  V5.D[1], X21
    FMOV  D6, X28
    FMOV  V6.D[1], X8
    FMOV  D7, X25
    FMOV  V7.D[1], X28
    FMOV  D8, X26
    FMOV  V8.D[1], X7
    FMOV  D9, X24
    FMOV  V9.D[1], X8
    FMOV  D10, X21
    FMOV  V10.D[1], X11
    FMOV  D11, X12
    FMOV  V11.D[1], X23
    FMOV  D12, X14
    FMOV  V12.D[1], X21
    FMOV  D13, X11
    FMOV  V13.D[1], X11
    FMOV  D14, X28
    FMOV  V14.D[1], X7
    FMOV  D15, X23
    FMOV  V15.D[1], X17
    FMOV  D16, X5
    FMOV  V16.D[1], X11
    FMOV  D17, X9
    FMOV  V17.D[1], X28
    FMOV  D18, X11
    FMOV  V18.D[1], X17
    FMOV  D19, X3
    FMOV  V19.D[1], X6
    FMOV  D20, X26
    FMOV  V20.D[1], X17
    FMOV  D21, X8
    FMOV  V21.D[1], X18
    FMOV  D22, X20
    FMOV  V22.D[1], X11
    FMOV  D23, X10
    FMOV  V23.D[1], X26
    FMOV  D24, X16
    FMOV  V24.D[1], X9
    FMOV  D25, X27
    FMOV  V25.D[1], X20
    FMOV  D26, X5
    FMOV  V26.D[1], X2
    FMOV  D27, X2
    FMOV  V27.D[1], X27
    FMOV  D28, X4
    FMOV  V28.D[1], X18
    FMOV  D29, X15
    FMOV  V29.D[1], X3
    FMOV  D30, X29
    FMOV  V30.D[1], X25
    FMOV  D31, X4
    FMOV  V31.D[1], X15
    MOVZ  X16, #0xf, LSL #0
TaishanSimdFpIntConversionP01_label_832:
    CLZ  V6.2S, V15.2S
    UADDLP  V26.4S, V3.8H
    NEG  V24.2D, V21.2D
    FRINTZ  V16.2D, V26.2D
    USQADD  D5, D27
    USQADD  H4, H15
    SXTL V5.4S, V6.4H
    REV64  V2.16B, V0.16B
    SUQADD  S1, S30
    SQXTUN  B6, H5
    RBIT  V2.8B, V10.8B
    USQADD  V14.8H, V29.8H
    SADDLP  V28.2S, V23.4H
    FRSQRTE  S21, S30
    FRECPS  S14, S6, S30
    SXTL2 V7.2D, V31.4S
    UXTL2 V0.8H, V11.16B
    FCVTXN2  V0.4S, V12.2D
    FRECPX  S19, S20
    SQXTUN  B21, H12
    REV64  V1.4S, V5.4S
    USQADD  H24, H16
    UADALP  V4.2D, V2.4S
    FCVTXN2  V22.4S, V5.2D
    SQXTUN  H3, S22
    XTN2  V21.16B, V20.8H
    SADDLP  V28.2D, V21.4S
    FRSQRTE  D0, D7
    NEG  V30.2S, V1.2S
    SUQADD  V4.4S, V4.4S
    SQNEG  D14, D12
    NOT  V12.8B, V14.8B
    NOT  V5.16B, V11.16B
    UQXTN  V16.8B, V27.8H
    FCVTXN  V16.2S, V27.2D
    USQADD  B9, B0
    FABS  V6.2S, V3.2S
    FRINTM  V14.2S, V30.2S
    USQADD  H21, H10
    SQXTUN  B26, H27
    REV16  V28.16B, V21.16B
    UQXTN  H26, S26
    USQADD  D0, D20
    SQXTUN2  V11.4S, V19.2D
    SQXTUN  H10, S20
    UXTL2 V28.8H, V5.16B
    SQNEG  S31, S4
    ABS  D25, D24
    USQADD  V0.4H, V25.4H
    SQXTN  V25.2S, V9.2D
    SUQADD  H3, H0
    NEG  D26, D4
    FSQRT  V10.2D, V6.2D
    UQXTN  H6, S15
    URSQRTE  V6.2S, V23.2S
    UXTL V20.8H, V13.8B
    SQABS  B14, B3
    SUQADD  S9, S7
    UXTL V7.8H, V20.8B
    SQABS  V12.8H, V21.8H
    SUQADD  D8, D18
    URSQRTE  V3.4S, V22.4S
    FRECPX  S21, S4
    UXTL2 V24.4S, V16.8H
    USQADD  H21, H16
    NEG  D12, D4
    USQADD  D6, D5
    SQNEG  B10, B24
    SQABS  V3.16B, V18.16B
    UADALP  V6.4S, V22.8H
    NEG  D10, D31
    SQXTUN  S3, D14
    SXTL V12.8H, V2.8B
    SUQADD  V14.4H, V16.4H
    SQXTUN  S30, D8
    SUQADD  S12, S1
    FRINTM  V1.2D, V25.2D
    FRECPS  S6, S9, S18
    SUQADD  S8, S27
    UXTL2 V31.4S, V12.8H
    FRINTX  V19.4S, V14.4S
    REV64  V18.2S, V26.2S
    SQXTUN  B12, H28
    SXTL V10.2D, V26.2S
    UQXTN  B23, H3
    USQADD  H6, H30
    UXTL V24.8H, V8.8B
    REV32  V13.4H, V18.4H
    XTN  V16.4H, V27.4S
    SQXTN  B13, H19
    SQABS  S13, S26
    NEG  V14.2S, V9.2S
    FCVTXN  S21, D3
    SXTL V5.4S, V31.4H
    XTN  V1.2S, V22.2D
    SUQADD  D4, D15
    SQXTUN  H3, S4
    UQXTN  B3, H29
    USQADD  V16.2S, V3.2S
    FRSQRTE  V18.2D, V5.2D
    SQXTN2  V20.4S, V5.2D
    SQABS  D11, D23
    SQXTN  V11.8B, V17.8H
    FNEG  V9.2S, V29.2S
    UQXTN  V9.2S, V22.2D
    USQADD  B7, B3
    UXTL2 V10.2D, V14.4S
    USQADD  B10, B18
    FCVTXN  V11.2S, V2.2D
    SQXTN  V16.4H, V6.4S
    ABS  V17.16B, V23.16B
    USQADD  H14, H16
    REV32  V14.4H, V26.4H
    UXTL2 V9.2D, V14.4S
    SADALP  V4.4H, V20.8B
    FRINTA  V13.4S, V2.4S
    FRECPS  V12.4S, V14.4S, V2.4S
    XTN  V21.2S, V16.2D
    SQNEG  V24.16B, V28.16B
    UQXTN  H3, S24
    FRINTM  V25.4S, V8.4S
    FRINTA  V10.2S, V6.2S
    REV32  V13.8H, V25.8H
    UQXTN2  V25.8H, V2.4S
    FRSQRTE  S18, S11
    SUQADD  H27, H4
    MVN  V17.16B, V9.16B
    SADDLP  V18.2S, V20.4H
    SQABS  B2, B25
    SXTL V7.8H, V14.8B
    SXTL2 V18.8H, V11.16B
    FABS  V26.2S, V20.2S
    SQNEG  S11, S3
    FRINTX  V9.4S, V5.4S
    SQNEG  B21, B19
    SQABS  D11, D0
    UXTL V21.4S, V25.4H
    UQXTN  H23, S13
    FSQRT  V6.4S, V10.4S
    FABS  V28.2D, V9.2D
    FRSQRTE  V9.2S, V16.2S
    SXTL2 V25.8H, V0.16B
    SQABS  B28, B3
    FRECPS  D3, D9, D27
    CNT  V23.8B, V8.8B
    NEG  V25.16B, V6.16B
    FRECPS  V17.2D, V2.2D, V20.2D
    FRINTZ  V12.2D, V31.2D
    UXTL2 V26.4S, V31.8H
    REV16  V12.8B, V19.8B
    CLZ  V25.8H, V26.8H
    FRINTX  V27.2S, V29.2S
    SUQADD  V9.8B, V4.8B
    FRSQRTE  V11.4S, V29.4S
    FRSQRTE  D18, D25
    UXTL V27.4S, V7.4H
    UQXTN2  V1.16B, V0.8H
    FRINTM  V3.2D, V26.2D
    UQXTN  S2, D5
    SQABS  B20, B0
    SQXTN  H5, S24
    SXTL V0.2D, V5.2S
    FRSQRTE  D14, D7
    FCVTXN  V11.2S, V19.2D
    FRECPX  S25, S10
    SQXTUN  B15, H8
    FRECPX  D28, D10
    CLZ  V11.4S, V13.4S
    SQNEG  H31, H13
    USQADD  B22, B29
    FRSQRTE  D31, D17
    SQNEG  S24, S18
    FNEG  V13.2D, V12.2D
    UXTL V9.2D, V17.2S
    REV32  V13.16B, V7.16B
    REV32  V24.4H, V7.4H
    UXTL V29.8H, V27.8B
    SQXTN  S30, D25
    FRINTN  V13.2S, V22.2S
    SXTL2 V22.8H, V20.16B
    UXTL V9.2D, V22.2S
    SQXTUN  V14.2S, V0.2D
    SQXTN  S9, D29
    UQXTN2  V28.16B, V22.8H
    FRSQRTE  D2, D17
    UQXTN  H1, S6
    SQABS  S26, S12
    SQABS  B26, B25
    SQNEG  V27.8B, V13.8B
    UXTL2 V26.8H, V24.16B
    SQNEG  H0, H4
    CLS  V27.16B, V10.16B
    SXTL V15.4S, V27.4H
    FRSQRTE  D19, D25
    FRINTX  V9.2S, V6.2S
    SQXTUN  B3, H30
    SQXTUN  V22.8B, V4.8H
    SQABS  D1, D30
    MVN  V9.8B, V30.8B
    SQXTN  H10, S13
    SUBS  X16, X16, #0x1
    B.NE  TaishanSimdFpIntConversionP01_label_832
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X27, X6, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X29, X26, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X27, X4, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X20, X3, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X26, X16, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X26, X10, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X8, X3, X8
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X23, X25, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X20, X16, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X23, X27, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X10, X24, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X4, X29, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X2, X3, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X12, X17, X16
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X11, X15, X17
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X29, X23, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X9, X25, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X27, X6, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X21, X10, X22
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X14, X5, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X15, X18, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X26, X28, X25
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X20, X15, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
TaishanSimdFpIntConversionP01_label_192:
    SUB  X14, X18, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, V2.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X15
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, D2
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x9000, LSL #32
    MOVK  X18, #0x3fe6, LSL #48
    SUB  X5, X18, X15
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, D3
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X12
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, D4
    MOVZ  X18, #0x2aeb, LSL #0
    MOVK  X18, #0x1, LSL #16
    MOVK  X18, #0x707, LSL #32
    SUB  X9, X18, X12
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, V5.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X24, X23, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, D5
    MOVZ  X23, #0x7fff, LSL #0
    SUB  X24, X23, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, V6.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X21
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, D6
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X21
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X20, X23, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, D7
    MOVZ  X23, #0xfffe, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0x1c, LSL #32
    MOVK  X23, #0xffdc, LSL #48
    SUB  X20, X23, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, V8.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, D8
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0x7fff, LSL #16
    SUB  X18, X11, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X29, X2, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, D9
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0x80ff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X29, X2, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X16, X28, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, D10
    MOVZ  X28, #0x0, LSL #0
    SUB  X16, X28, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X12, #0x20, LSL #0
    MOVK  X12, #0x20, LSL #32
    SUB  X4, X12, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, D11
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x20, LSL #32
    SUB  X4, X12, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X23, X19, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, D12
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x803f, LSL #16
    MOVK  X19, #0x803f, LSL #48
    SUB  X23, X19, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X2, X25, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, D14
    MOVZ  X25, #0x7fff, LSL #0
    SUB  X2, X25, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, V15.D[1]
    MOVZ  X8, #0x707, LSL #0
    MOVK  X8, #0x707, LSL #32
    SUB  X16, X8, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, D15
    MOVZ  X8, #0x707, LSL #0
    MOVK  X8, #0x707, LSL #32
    SUB  X16, X8, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X23, X3, X12
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, D16
    MOVZ  X3, #0x0, LSL #0
    SUB  X23, X3, X12
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x4000, LSL #48
    SUB  X3, X16, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, D17
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x4000, LSL #48
    SUB  X3, X16, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, D18
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0xf000, LSL #32
    MOVK  X3, #0x5fdf, LSL #48
    SUB  X2, X3, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, D19
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xb000, LSL #32
    MOVK  X28, #0x6086, LSL #48
    SUB  X27, X28, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X29, X11, X8
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, D20
    MOVZ  X11, #0xf, LSL #0
    SUB  X29, X11, X8
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, V21.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, D21
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0x7fff, LSL #32
    SUB  X14, X17, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, V22.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, D22
    MOVZ  X26, #0x1ff, LSL #0
    MOVK  X26, #0xff, LSL #16
    SUB  X10, X26, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V23.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D23
    MOVZ  X29, #0x808, LSL #0
    MOVK  X29, #0x708, LSL #16
    SUB  X8, X29, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, V24.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, D24
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xfffe, LSL #16
    MOVK  X5, #0xffdc, LSL #32
    MOVK  X5, #0x1c, LSL #48
    SUB  X20, X5, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, D25
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x7f00, LSL #16
    SUB  X29, X8, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, V26.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X6, X27, X5
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, D26
    MOVZ  X27, #0x0, LSL #0
    SUB  X6, X27, X5
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V27.D[1]
    MOVZ  X18, #0x707, LSL #0
    MOVK  X18, #0x707, LSL #16
    MOVK  X18, #0x707, LSL #32
    MOVK  X18, #0x707, LSL #48
    SUB  X20, X18, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D27
    MOVZ  X18, #0x707, LSL #0
    MOVK  X18, #0x707, LSL #16
    MOVK  X18, #0x707, LSL #32
    MOVK  X18, #0x707, LSL #48
    SUB  X20, X18, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, V28.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X21
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, D28
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7fe0, LSL #48
    SUB  X14, X16, X21
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X4, #0xff, LSL #0
    MOVK  X4, #0xff, LSL #16
    SUB  X19, X4, X16
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, D29
    MOVZ  X4, #0xfe, LSL #0
    MOVK  X4, #0xff, LSL #16
    SUB  X19, X4, X16
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X2, #0x3351, LSL #0
    MOVK  X2, #0xcb64, LSL #16
    MOVK  X2, #0xf0a8, LSL #32
    MOVK  X2, #0x9c28, LSL #48
    MOVZ  X3, #0x28d5, LSL #0
    MOVK  X3, #0x4837, LSL #16
    MOVK  X3, #0xc4dd, LSL #32
    MOVK  X3, #0x84a7, LSL #48
    MOVZ  X4, #0x449b, LSL #0
    MOVK  X4, #0x4219, LSL #16
    MOVK  X4, #0x879e, LSL #32
    MOVK  X4, #0x4f73, LSL #48
    MOVZ  X5, #0xa57f, LSL #0
    MOVK  X5, #0x201, LSL #16
    MOVK  X5, #0xb11d, LSL #32
    MOVK  X5, #0x62d1, LSL #48
    MOVZ  X6, #0x4c7d, LSL #0
    MOVK  X6, #0x731b, LSL #16
    MOVK  X6, #0xb4c0, LSL #32
    MOVK  X6, #0xe665, LSL #48
    MOVZ  X7, #0x169e, LSL #0
    MOVK  X7, #0xac5c, LSL #16
    MOVK  X7, #0xc7c5, LSL #32
    MOVK  X7, #0x21e1, LSL #48
    MOVZ  X8, #0x703a, LSL #0
    MOVK  X8, #0xd135, LSL #16
    MOVK  X8, #0x4aa3, LSL #32
    MOVK  X8, #0x36c4, LSL #48
    MOVZ  X9, #0x8df1, LSL #0
    MOVK  X9, #0x101c, LSL #16
    MOVK  X9, #0x79a4, LSL #32
    MOVK  X9, #0x9244, LSL #48
    MOVZ  X10, #0x693b, LSL #0
    MOVK  X10, #0x1c4a, LSL #16
    MOVK  X10, #0xd0a8, LSL #32
    MOVK  X10, #0x4def, LSL #48
    MOVZ  X11, #0x798, LSL #0
    MOVK  X11, #0x876f, LSL #16
    MOVK  X11, #0x6c18, LSL #32
    MOVK  X11, #0x904b, LSL #48
    MOVZ  X12, #0xf317, LSL #0
    MOVK  X12, #0x232e, LSL #16
    MOVK  X12, #0x4b99, LSL #32
    MOVK  X12, #0xfeed, LSL #48
    MOVZ  X14, #0xefd4, LSL #0
    MOVK  X14, #0x5efd, LSL #16
    MOVK  X14, #0xd5b2, LSL #32
    MOVK  X14, #0xedd, LSL #48
    MOVZ  X15, #0xc346, LSL #0
    MOVK  X15, #0x7f33, LSL #16
    MOVK  X15, #0x7b6, LSL #32
    MOVK  X15, #0xe008, LSL #48
    MOVZ  X16, #0x3987, LSL #0
    MOVK  X16, #0x31d1, LSL #16
    MOVK  X16, #0xc6c4, LSL #32
    MOVK  X16, #0x19e0, LSL #48
    MOVZ  X17, #0xa146, LSL #0
    MOVK  X17, #0xa0f3, LSL #16
    MOVK  X17, #0x3a7c, LSL #32
    MOVK  X17, #0x2b26, LSL #48
    MOVZ  X18, #0x20a1, LSL #0
    MOVK  X18, #0xdd, LSL #16
    MOVK  X18, #0xe691, LSL #32
    MOVK  X18, #0x2bf5, LSL #48
    MOVZ  X19, #0xd9f7, LSL #0
    MOVK  X19, #0xf58f, LSL #16
    MOVK  X19, #0x8ccd, LSL #32
    MOVK  X19, #0x36c3, LSL #48
    MOVZ  X20, #0x6775, LSL #0
    MOVK  X20, #0xc33c, LSL #16
    MOVK  X20, #0xa47, LSL #32
    MOVK  X20, #0xbed4, LSL #48
    MOVZ  X21, #0x8532, LSL #0
    MOVK  X21, #0x7012, LSL #16
    MOVK  X21, #0xa1bf, LSL #32
    MOVK  X21, #0xbcf2, LSL #48
    MOVZ  X22, #0xc7eb, LSL #0
    MOVK  X22, #0xfdd1, LSL #16
    MOVK  X22, #0x7f03, LSL #32
    MOVK  X22, #0xb0c, LSL #48
    MOVZ  X23, #0x9039, LSL #0
    MOVK  X23, #0x7379, LSL #16
    MOVK  X23, #0xf801, LSL #32
    MOVK  X23, #0xd8fa, LSL #48
    MOVZ  X24, #0x99c5, LSL #0
    MOVK  X24, #0xe1e5, LSL #16
    MOVK  X24, #0x3e2d, LSL #32
    MOVK  X24, #0xb441, LSL #48
    MOVZ  X25, #0xeef3, LSL #0
    MOVK  X25, #0x71ef, LSL #16
    MOVK  X25, #0xbdce, LSL #32
    MOVK  X25, #0x6025, LSL #48
    MOVZ  X26, #0xde02, LSL #0
    MOVK  X26, #0x9080, LSL #16
    MOVK  X26, #0x727c, LSL #32
    MOVK  X26, #0x9bab, LSL #48
    MOVZ  X27, #0x3ede, LSL #0
    MOVK  X27, #0xfd5b, LSL #16
    MOVK  X27, #0x1e83, LSL #32
    MOVK  X27, #0x7ab0, LSL #48
    MOVZ  X28, #0xd9eb, LSL #0
    MOVK  X28, #0xab90, LSL #16
    MOVK  X28, #0xa658, LSL #32
    MOVK  X28, #0xa424, LSL #48
    MOVZ  X29, #0x5946, LSL #0
    MOVK  X29, #0xaff8, LSL #16
    MOVK  X29, #0x46a3, LSL #32
    MOVK  X29, #0x13e9, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X22
    FMOV  D1, X10
    FMOV  V1.D[1], X16
    FMOV  D2, X19
    FMOV  V2.D[1], X8
    FMOV  D3, X18
    FMOV  V3.D[1], X28
    FMOV  D4, X24
    FMOV  V4.D[1], X11
    FMOV  D5, X28
    FMOV  V5.D[1], X26
    FMOV  D6, X18
    FMOV  V6.D[1], X15
    FMOV  D7, X10
    FMOV  V7.D[1], X6
    FMOV  D8, X14
    FMOV  V8.D[1], X29
    FMOV  D9, X17
    FMOV  V9.D[1], X17
    FMOV  D10, X6
    FMOV  V10.D[1], X16
    FMOV  D11, X25
    FMOV  V11.D[1], X23
    FMOV  D12, X20
    FMOV  V12.D[1], X8
    FMOV  D13, X18
    FMOV  V13.D[1], X12
    FMOV  D14, X9
    FMOV  V14.D[1], X6
    FMOV  D15, X15
    FMOV  V15.D[1], X26
    FMOV  D16, X6
    FMOV  V16.D[1], X2
    FMOV  D17, X6
    FMOV  V17.D[1], X25
    FMOV  D18, X21
    FMOV  V18.D[1], X6
    FMOV  D19, X23
    FMOV  V19.D[1], X12
    FMOV  D20, X23
    FMOV  V20.D[1], X14
    FMOV  D21, X18
    FMOV  V21.D[1], X21
    FMOV  D22, X21
    FMOV  V22.D[1], X16
    FMOV  D23, X24
    FMOV  V23.D[1], X14
    FMOV  D24, X12
    FMOV  V24.D[1], X17
    FMOV  D25, X6
    FMOV  V25.D[1], X16
    FMOV  D26, X12
    FMOV  V26.D[1], X7
    FMOV  D27, X28
    FMOV  V27.D[1], X10
    FMOV  D28, X24
    FMOV  V28.D[1], X8
    FMOV  D29, X11
    FMOV  V29.D[1], X8
    FMOV  D30, X6
    FMOV  V30.D[1], X10
    FMOV  D31, X24
    FMOV  V31.D[1], X7
    MOVZ  X18, #0xa, LSL #0
TaishanSimdFpIntConversionP01_label_898:
    SQABS  D28, D11
    SUQADD  V20.2S, V28.2S
    SXTL V28.8H, V20.8B
    FRSQRTE  D21, D18
    FABS  V1.2S, V29.2S
    URSQRTE  V12.4S, V12.4S
    SQXTUN  B15, H13
    ABS  V0.4H, V21.4H
    SUQADD  S22, S28
    SQABS  V24.8H, V10.8H
    FCVTXN  S9, D20
    SXTL V23.8H, V31.8B
    XTN  V9.2S, V25.2D
    UQXTN  H24, S10
    SQNEG  H1, H16
    FRECPX  S2, S28
    SQXTN  S23, D1
    UXTL2 V25.8H, V18.16B
    SQNEG  D16, D22
    SADALP  V19.2D, V16.4S
    UQXTN  B28, H12
    SQABS  S25, S1
    ABS  V9.4S, V30.4S
    ABS  D25, D22
    URSQRTE  V8.4S, V3.4S
    FRSQRTE  V27.2D, V26.2D
    SQABS  B10, B26
    XTN  V21.4H, V19.4S
    SQABS  H13, H9
    SADDLP  V3.4H, V0.8B
    ABS  V28.16B, V13.16B
    SQXTN  S15, D23
    FRINTX  V8.2D, V18.2D
    SQXTN2  V2.4S, V27.2D
    REV16  V0.16B, V20.16B
    SQNEG  H22, H28
    ABS  V16.2S, V0.2S
    SQXTUN2  V3.8H, V2.4S
    SUQADD  S23, S14
    SQXTN  B4, H26
    SXTL2 V30.8H, V8.16B
    FRECPX  D0, D23
    FRSQRTE  V28.4S, V21.4S
    FRINTN  V19.2D, V13.2D
    UQXTN2  V19.8H, V18.4S
    SQXTN  V18.8B, V27.8H
    SUQADD  H3, H15
    MVN  V11.16B, V20.16B
    SQABS  B26, B29
    SXTL V0.8H, V18.8B
    UQXTN  S26, D21
    FRECPS  D10, D7, D23
    SUQADD  V29.4H, V15.4H
    RBIT  V28.8B, V30.8B
    UQXTN  B28, H22
    SXTL2 V13.8H, V24.16B
    XTN  V4.8B, V27.8H
    SXTL2 V11.4S, V0.8H
    USQADD  D11, D7
    REV64  V12.8H, V13.8H
    UQXTN  V1.2S, V20.2D
    SQXTN  B28, H18
    UXTL V7.8H, V18.8B
    UQXTN  S18, D26
    UXTL2 V27.8H, V2.16B
    REV16  V10.8B, V2.8B
    SQNEG  B29, B12
    FRSQRTE  V7.2D, V30.2D
    SQXTUN  B9, H3
    SUQADD  D5, D3
    SQXTN  V30.4H, V7.4S
    SQABS  H14, H8
    URECPE  V14.2S, V16.2S
    SQXTN  H30, S26
    SUQADD  V2.2D, V26.2D
    REV64  V26.8H, V10.8H
    SUQADD  V21.2S, V12.2S
    SXTL2 V5.4S, V13.8H
    SUQADD  S19, S16
    SXTL2 V2.4S, V3.8H
    UXTL V18.2D, V28.2S
    SQXTUN  S30, D30
    FRECPS  V12.2S, V25.2S, V12.2S
    SQXTN  V24.2S, V23.2D
    USQADD  D23, D17
    FNEG  V25.2S, V21.2S
    UXTL V10.2D, V7.2S
    UQXTN  B8, H20
    SUQADD  H11, H21
    FRECPS  D21, D9, D19
    UADDLP  V18.8H, V6.16B
    SQXTN  V4.2S, V21.2D
    SQNEG  H28, H8
    FRINTZ  V28.4S, V9.4S
    UXTL2 V23.8H, V8.16B
    XTN2  V0.8H, V0.4S
    SQXTN  B30, H0
    FRECPX  D13, D23
    SQNEG  B28, B10
    SQXTN  V18.8B, V17.8H
    FRINTZ  V6.2S, V25.2S
    UADDLP  V5.2D, V4.4S
    REV16  V11.8B, V19.8B
    ABS  V4.2D, V15.2D
    NEG  D26, D31
    UQXTN  H25, S8
    SQXTUN  S23, D29
    FRECPS  D9, D7, D0
    FNEG  V11.4S, V10.4S
    SQXTN2  V30.16B, V30.8H
    FRINTM  V19.4S, V23.4S
    FCVTXN2  V17.4S, V15.2D
    NEG  V30.2D, V30.2D
    UQXTN  S3, D10
    FSQRT  V21.4S, V9.4S
    UQXTN2  V14.4S, V0.2D
    SQXTN  V22.8B, V11.8H
    ABS  V20.16B, V0.16B
    SXTL2 V12.4S, V30.8H
    FRECPS  V30.2S, V30.2S, V18.2S
    FSQRT  V26.4S, V11.4S
    SQNEG  S2, S10
    SQABS  V25.4S, V28.4S
    ABS  V28.2D, V4.2D
    SQXTUN2  V0.8H, V3.4S
    REV32  V10.8H, V23.8H
    SQXTN  H18, S24
    UQXTN  V15.8B, V21.8H
    SQNEG  V18.2S, V9.2S
    SQXTN  V17.4H, V14.4S
    SQXTN  B11, H16
    SADALP  V5.2D, V19.4S
    UQXTN  B16, H0
    SQNEG  D30, D30
    USQADD  D28, D27
    SQNEG  S1, S22
    SQXTUN  S0, D12
    ABS  V4.2S, V11.2S
    SQXTN  V0.2S, V19.2D
    SQNEG  S11, S2
    USQADD  V30.4H, V24.4H
    REV64  V25.8H, V10.8H
    SADDLP  V28.4H, V10.8B
    REV32  V5.8B, V21.8B
    FRECPS  V30.2D, V3.2D, V21.2D
    URSQRTE  V19.2S, V16.2S
    SQABS  H2, H18
    SQNEG  H1, H15
    FRSQRTE  V29.2D, V24.2D
    SQABS  B5, B12
    RBIT  V24.16B, V2.16B
    USQADD  S0, S6
    UQXTN  S0, D0
    UXTL V27.4S, V7.4H
    SQXTUN  S2, D27
    ABS  D6, D19
    FNEG  V20.4S, V4.4S
    FRSQRTE  S11, S3
    SADALP  V0.1D, V6.2S
    SQABS  B7, B18
    FABS  V22.4S, V14.4S
    REV64  V19.2S, V27.2S
    SADDLP  V12.8H, V6.16B
    ABS  V7.2S, V7.2S
    SQNEG  H25, H7
    FRINTI  V7.4S, V6.4S
    SQABS  H19, H9
    FRINTI  V3.2D, V21.2D
    SQABS  D6, D6
    CLZ  V24.4S, V21.4S
    SADDLP  V7.4S, V28.8H
    SUQADD  H3, H23
    SQXTUN  S1, D23
    UXTL2 V7.2D, V7.4S
    RBIT  V15.16B, V19.16B
    SUQADD  D13, D1
    FRECPX  S24, S12
    UQXTN  V7.2S, V6.2D
    SQNEG  D22, D19
    SQNEG  H12, H19
    FRINTI  V4.2D, V25.2D
    SUQADD  S14, S29
    NOT  V15.16B, V10.16B
    FRINTZ  V1.2D, V8.2D
    SXTL V6.4S, V13.4H
    NOT  V4.8B, V9.8B
    SQNEG  S19, S13
    UQXTN2  V14.8H, V17.4S
    ABS  D13, D14
    XTN  V24.8B, V22.8H
    ABS  V21.2D, V30.2D
    FRSQRTE  D14, D25
    UXTL V26.8H, V23.8B
    FSQRT  V6.4S, V22.4S
    SQXTUN  H4, S14
    FRECPS  S8, S10, S8
    FCVTXN  V28.2S, V3.2D
    FRSQRTE  D30, D3
    UXTL V14.2D, V1.2S
    FRECPS  D28, D23, D11
    SUBS  X18, X18, #0x1
    B.NE  TaishanSimdFpIntConversionP01_label_898
    MOVZ  X9, #0x3351, LSL #0
    MOVK  X9, #0xcb64, LSL #16
    MOVK  X9, #0xf0a8, LSL #32
    MOVK  X9, #0x9c28, LSL #48
    SUB  X14, X9, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X25, #0x28d5, LSL #0
    MOVK  X25, #0x4837, LSL #16
    MOVK  X25, #0xc4dd, LSL #32
    MOVK  X25, #0x84a7, LSL #48
    SUB  X11, X25, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X29, #0x449b, LSL #0
    MOVK  X29, #0x4219, LSL #16
    MOVK  X29, #0x879e, LSL #32
    MOVK  X29, #0x4f73, LSL #48
    SUB  X16, X29, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X27, #0xa57f, LSL #0
    MOVK  X27, #0x201, LSL #16
    MOVK  X27, #0xb11d, LSL #32
    MOVK  X27, #0x62d1, LSL #48
    SUB  X4, X27, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X20, #0x4c7d, LSL #0
    MOVK  X20, #0x731b, LSL #16
    MOVK  X20, #0xb4c0, LSL #32
    MOVK  X20, #0xe665, LSL #48
    SUB  X11, X20, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0x169e, LSL #0
    MOVK  X4, #0xac5c, LSL #16
    MOVK  X4, #0xc7c5, LSL #32
    MOVK  X4, #0x21e1, LSL #48
    SUB  X11, X4, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X27, #0x703a, LSL #0
    MOVK  X27, #0xd135, LSL #16
    MOVK  X27, #0x4aa3, LSL #32
    MOVK  X27, #0x36c4, LSL #48
    SUB  X14, X27, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X15, #0x3351, LSL #0
    MOVK  X15, #0xcb64, LSL #16
    MOVK  X15, #0xf0a8, LSL #32
    MOVK  X15, #0x9c28, LSL #48
    SUB  X12, X15, X9
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X18, #0x693b, LSL #0
    MOVK  X18, #0x1c4a, LSL #16
    MOVK  X18, #0xd0a8, LSL #32
    MOVK  X18, #0x4def, LSL #48
    SUB  X22, X18, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X9, X12, X12
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X3, #0x3351, LSL #0
    MOVK  X3, #0xcb64, LSL #16
    MOVK  X3, #0xf0a8, LSL #32
    MOVK  X3, #0x9c28, LSL #48
    SUB  X27, X3, X15
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X16, #0xa146, LSL #0
    MOVK  X16, #0xa0f3, LSL #16
    MOVK  X16, #0x3a7c, LSL #32
    MOVK  X16, #0x2b26, LSL #48
    SUB  X19, X16, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X26, #0x693b, LSL #0
    MOVK  X26, #0x1c4a, LSL #16
    MOVK  X26, #0xd0a8, LSL #32
    MOVK  X26, #0x4def, LSL #48
    SUB  X15, X26, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X25, #0x4c7d, LSL #0
    MOVK  X25, #0x731b, LSL #16
    MOVK  X25, #0xb4c0, LSL #32
    MOVK  X25, #0xe665, LSL #48
    SUB  X23, X25, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X5, #0x8532, LSL #0
    MOVK  X5, #0x7012, LSL #16
    MOVK  X5, #0xa1bf, LSL #32
    MOVK  X5, #0xbcf2, LSL #48
    SUB  X26, X5, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X27, #0x99c5, LSL #0
    MOVK  X27, #0xe1e5, LSL #16
    MOVK  X27, #0x3e2d, LSL #32
    MOVK  X27, #0xb441, LSL #48
    SUB  X3, X27, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X28, #0x4c7d, LSL #0
    MOVK  X28, #0x731b, LSL #16
    MOVK  X28, #0xb4c0, LSL #32
    MOVK  X28, #0xe665, LSL #48
    SUB  X24, X28, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X9, #0x99c5, LSL #0
    MOVK  X9, #0xe1e5, LSL #16
    MOVK  X9, #0x3e2d, LSL #32
    MOVK  X9, #0xb441, LSL #48
    SUB  X2, X9, X27
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X26, #0x4c7d, LSL #0
    MOVK  X26, #0x731b, LSL #16
    MOVK  X26, #0xb4c0, LSL #32
    MOVK  X26, #0xe665, LSL #48
    SUB  X2, X26, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X6, #0x449b, LSL #0
    MOVK  X6, #0x4219, LSL #16
    MOVK  X6, #0x879e, LSL #32
    MOVK  X6, #0x4f73, LSL #48
    SUB  X25, X6, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, D2
    MOVZ  X29, #0x0, LSL #0
TaishanSimdFpIntConversionP01_label_317:
    SUB  X23, X29, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, D3
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X24, X14, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, D4
    MOVZ  X14, #0x0, LSL #0
    SUB  X24, X14, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, V5.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X22
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, D5
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X22
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, V6.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X15
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, D6
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X15
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, V7.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, D7
    MOVZ  X20, #0x1, LSL #0
    SUB  X16, X20, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, D8
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x4000, LSL #16
    SUB  X20, X5, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, V9.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, D9
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xfff0, LSL #48
    SUB  X6, X12, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, V10.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, D10
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, D11
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7f80, LSL #16
    SUB  X25, X16, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, V12.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X24, X14, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, D12
    MOVZ  X14, #0x0, LSL #0
    SUB  X24, X14, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, D14
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X4, X6, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, D15
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X4, X6, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X2, X22, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X18, D16
    MOVZ  X22, #0x0, LSL #0
    SUB  X2, X22, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, V17.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, D17
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    SUB  X10, X15, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V18.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X23, X22, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D18
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x10, LSL #48
    SUB  X23, X22, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, V19.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, D19
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #16
    MOVK  X14, #0x8000, LSL #48
    SUB  X17, X14, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, D20
    MOVZ  X14, #0x80, LSL #0
    MOVK  X14, #0x8000, LSL #16
    MOVK  X14, #0x8000, LSL #48
    SUB  X17, X14, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x4000, LSL #48
    SUB  X15, X4, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, D21
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x4000, LSL #48
    SUB  X15, X4, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, V22.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X27
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, D22
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X27
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X26, X6, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, D23
    MOVZ  X6, #0x0, LSL #0
    SUB  X26, X6, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, D24
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, V25.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, D25
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, D26
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, V27.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7ff0, LSL #32
    SUB  X23, X15, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, D27
    MOVZ  X15, #0x0, LSL #0
    SUB  X23, X15, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, D28
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x4000, LSL #48
    SUB  X4, X9, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x7ff0, LSL #48
    SUB  X8, X2, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X18, D29
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x7ff0, LSL #48
    SUB  X8, X2, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
TaishanSimdFpIntConversionP01_label_561:
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
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
    FMOV  D0, X18
    FMOV  V0.D[1], X28
    FMOV  D1, X7
    FMOV  V1.D[1], X3
    FMOV  D2, X20
    FMOV  V2.D[1], X24
    FMOV  D3, X2
    FMOV  V3.D[1], X15
    FMOV  D4, X4
    FMOV  V4.D[1], X18
    FMOV  D5, X19
    FMOV  V5.D[1], X18
    FMOV  D6, X23
    FMOV  V6.D[1], X19
    FMOV  D7, X19
    FMOV  V7.D[1], X17
    FMOV  D8, X29
    FMOV  V8.D[1], X16
    FMOV  D9, X27
    FMOV  V9.D[1], X22
    FMOV  D10, X6
    FMOV  V10.D[1], X3
    FMOV  D11, X25
    FMOV  V11.D[1], X11
    FMOV  D12, X22
    FMOV  V12.D[1], X17
    FMOV  D13, X27
    FMOV  V13.D[1], X5
    FMOV  D14, X22
    FMOV  V14.D[1], X25
    FMOV  D15, X19
    FMOV  V15.D[1], X20
    FMOV  D16, X8
    FMOV  V16.D[1], X11
    FMOV  D17, X22
    FMOV  V17.D[1], X7
    FMOV  D18, X29
    FMOV  V18.D[1], X29
    FMOV  D19, X17
    FMOV  V19.D[1], X11
    FMOV  D20, X21
    FMOV  V20.D[1], X8
    FMOV  D21, X26
    FMOV  V21.D[1], X7
    FMOV  D22, X27
    FMOV  V22.D[1], X23
    FMOV  D23, X25
    FMOV  V23.D[1], X9
    FMOV  D24, X14
    FMOV  V24.D[1], X26
    FMOV  D25, X24
    FMOV  V25.D[1], X17
    FMOV  D26, X24
    FMOV  V26.D[1], X8
    FMOV  D27, X12
    FMOV  V27.D[1], X17
    FMOV  D28, X19
    FMOV  V28.D[1], X4
    FMOV  D29, X17
    FMOV  V29.D[1], X29
    FMOV  D30, X12
    FMOV  V30.D[1], X23
    FMOV  D31, X28
    FMOV  V31.D[1], X29
    MOVZ  X9, #0xa, LSL #0
TaishanSimdFpIntConversionP01_label_968:
    FCVTXN  V21.2S, V17.2D
    RBIT  V28.16B, V28.16B
    SADDLP  V18.4S, V15.8H
    NOT  V18.8B, V19.8B
    USQADD  B23, B13
    ABS  D24, D29
    SQXTN2  V31.16B, V8.8H
    FRINTM  V12.2D, V5.2D
    RBIT  V23.8B, V18.8B
    CLS  V23.4S, V26.4S
    FABS  V31.2S, V5.2S
    SUQADD  H27, H16
    FRINTN  V22.4S, V25.4S
    SXTL V31.8H, V15.8B
    UXTL V28.4S, V28.4H
    FRINTN  V28.2S, V25.2S
    FRINTN  V1.2D, V27.2D
    UQXTN  V11.2S, V18.2D
    RBIT  V28.8B, V31.8B
    URSQRTE  V12.4S, V16.4S
    XTN  V19.2S, V24.2D
    FRECPX  D22, D21
    CLZ  V19.4S, V16.4S
    UXTL2 V15.2D, V6.4S
    FRECPS  D26, D22, D12
    SADALP  V3.8H, V11.16B
    USQADD  D9, D30
    FRINTN  V1.4S, V6.4S
    XTN2  V24.4S, V6.2D
    NEG  V1.2S, V28.2S
    UXTL V16.4S, V19.4H
    UXTL2 V25.4S, V8.8H
    SQXTUN  B25, H18
    UXTL2 V20.4S, V11.8H
    USQADD  H31, H19
    UQXTN  H15, S18
    SXTL V20.8H, V15.8B
    REV16  V18.16B, V16.16B
    CLZ  V20.4H, V3.4H
    SQXTN  H6, S3
    SQABS  B6, B17
    FRINTP  V18.2S, V6.2S
    FSQRT  V8.4S, V15.4S
    USQADD  V0.2D, V20.2D
    ABS  D19, D12
    FRECPS  S31, S31, S11
    UQXTN  S22, D19
    FRSQRTE  D1, D6
    UXTL V5.2D, V13.2S
    FSQRT  V16.2S, V28.2S
    SQABS  D28, D30
    FRECPX  S0, S24
    UQXTN  B29, H6
    FRINTN  V6.4S, V8.4S
    USQADD  B11, B4
    UXTL2 V2.2D, V19.4S
    SQABS  D29, D18
    USQADD  D12, D7
    SQXTN  H30, S17
    UXTL2 V18.2D, V7.4S
    UXTL2 V2.2D, V0.4S
    SADDLP  V20.2S, V17.4H
    SQXTUN2  V6.16B, V28.8H
    FCVTXN  S12, D22
    SUQADD  D13, D24
    FRINTZ  V30.4S, V16.4S
    SQNEG  H8, H3
    UXTL V3.4S, V0.4H
    SQXTUN2  V6.4S, V14.2D
    FRINTZ  V28.2S, V8.2S
    UXTL2 V10.4S, V0.8H
    UQXTN  B7, H4
    SQXTN  B29, H1
    SQNEG  D3, D5
    FRECPX  D31, D28
    FRECPS  S22, S28, S8
    SQXTN  V29.4H, V10.4S
    FRECPS  V4.2D, V8.2D, V31.2D
    UQXTN  H27, S2
    CNT  V10.8B, V22.8B
    FRINTX  V4.2S, V15.2S
    UQXTN  B4, H17
    SQNEG  B10, B17
    SQABS  V8.2S, V12.2S
    CLS  V22.8H, V16.8H
    SQXTUN  H10, S5
    ABS  V24.4S, V26.4S
    SXTL V18.4S, V10.4H
    ABS  V5.2S, V0.2S
    SADALP  V8.8H, V4.16B
    SXTL V19.4S, V23.4H
    UQXTN  H10, S24
    REV32  V15.16B, V20.16B
    SQNEG  D27, D1
    SQXTUN2  V18.16B, V0.8H
    NEG  D12, D15
    FSQRT  V11.2D, V14.2D
    USQADD  H7, H31
    USQADD  V16.2S, V21.2S
    CNT  V30.8B, V30.8B
    FRINTA  V17.4S, V15.4S
    SQNEG  S31, S0
    FRINTZ  V22.4S, V19.4S
    FNEG  V1.2D, V2.2D
    ABS  V10.8B, V24.8B
    SXTL V1.2D, V30.2S
    SQXTN2  V26.16B, V12.8H
    SUQADD  D5, D9
    SQNEG  V0.16B, V23.16B
    SQXTUN  B8, H19
    SQABS  H1, H21
    USQADD  S18, S27
    SADALP  V27.2D, V11.4S
    USQADD  B0, B15
    FRECPS  S14, S28, S13
    XTN  V23.2S, V16.2D
    SQABS  H24, H27
    SXTL2 V19.2D, V6.4S
    SQABS  D2, D14
    FNEG  V8.2D, V13.2D
    SUQADD  V15.4S, V20.4S
    SQXTN  V23.8B, V24.8H
    SQXTUN  V28.2S, V30.2D
    CNT  V20.8B, V19.8B
    URECPE  V21.4S, V30.4S
    SQXTN  B26, H12
    FRINTM  V18.4S, V14.4S
    SADDLP  V20.1D, V26.2S
    NOT  V21.16B, V2.16B
    CNT  V15.16B, V2.16B
    UADALP  V5.4S, V1.8H
    CLS  V24.4S, V28.4S
    UXTL V20.2D, V14.2S
    FRECPS  D16, D22, D23
    FSQRT  V9.4S, V24.4S
    UXTL2 V0.4S, V9.8H
    FRECPX  D27, D16
    SQXTUN  H30, S11
    UQXTN  H4, S15
    SADALP  V12.4H, V31.8B
    SQABS  D20, D12
    UQXTN  B10, H9
    SXTL V9.8H, V31.8B
    NOT  V4.8B, V22.8B
    SUQADD  D12, D23
    SQABS  B7, B8
    UQXTN  S26, D23
    REV64  V11.8B, V3.8B
    SUQADD  B0, B16
    REV64  V31.4H, V1.4H
    UXTL V22.2D, V6.2S
    UXTL V3.2D, V0.2S
    NOT  V7.8B, V27.8B
    SQXTUN  S12, D5
    NOT  V17.16B, V24.16B
    FNEG  V17.2D, V15.2D
    SUQADD  H10, H30
    FRECPX  D26, D28
    USQADD  H20, H23
    XTN  V30.8B, V5.8H
    UXTL V17.2D, V26.2S
    RBIT  V19.16B, V27.16B
    FRINTI  V24.2S, V19.2S
    SQABS  V8.2S, V26.2S
    FRINTN  V26.2S, V14.2S
    FRINTN  V29.2D, V24.2D
    URECPE  V19.4S, V23.4S
    FRINTI  V5.4S, V29.4S
    FRINTN  V1.4S, V6.4S
    REV16  V11.16B, V26.16B
    FRECPX  S8, S7
    SQABS  H24, H16
    SUQADD  D4, D27
    MVN  V5.16B, V17.16B
    FABS  V31.2S, V20.2S
    URECPE  V4.2S, V0.2S
    SQNEG  V11.2D, V19.2D
    FNEG  V31.4S, V10.4S
    SQXTN  B29, H7
    FSQRT  V4.2D, V24.2D
    REV16  V20.16B, V10.16B
    SXTL2 V3.4S, V0.8H
    SXTL2 V20.8H, V17.16B
    SQXTN  V14.4H, V22.4S
    SQXTUN2  V4.16B, V15.8H
    UXTL2 V12.8H, V7.16B
    URSQRTE  V25.2S, V20.2S
    SUQADD  V5.8B, V1.8B
    FCVTXN2  V16.4S, V15.2D
    NEG  D6, D28
    FRINTA  V6.2D, V11.2D
    SQXTN  H29, S10
    SUQADD  H22, H14
    UQXTN  V7.4H, V2.4S
    UXTL V9.8H, V12.8B
    SQABS  S11, S8
    USQADD  S28, S20
    CLZ  V31.4H, V24.4H
    SQNEG  H14, H29
    SXTL V25.4S, V29.4H
    SUBS  X9, X9, #0x1
    B.NE  TaishanSimdFpIntConversionP01_label_968
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X3
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X16, X28, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X11, X24, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X26, X4, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X24, X20, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X24, X23, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X2, X18, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X12, X23, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X16, X21, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X14
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X22, X23, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X27, X3, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X19
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X9, X12, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X22
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X22, X21, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X23, X24, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, V2.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, D2
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x4000, LSL #16
    SUB  X29, X16, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, D3
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X11, #0xff00, LSL #0
    SUB  X18, X11, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, D4
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, D5
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X22, X7, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V6.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X3
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D6
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X3
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X6, X23, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, D7
    MOVZ  X23, #0xffff, LSL #0
    SUB  X6, X23, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, V8.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, D8
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X26, X21, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, V9.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, D9
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X18, D10
    MOVZ  X2, #0x7fff, LSL #0
    SUB  X5, X2, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, V11.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, D11
    MOVZ  X17, #0x1, LSL #0
    SUB  X12, X17, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X14
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, D12
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X14
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X20, X4, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, D14
    MOVZ  X4, #0x8001, LSL #0
    SUB  X20, X4, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X17, X11, X24
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, D15
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x100, LSL #16
    SUB  X17, X11, X24
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X4, #0x1, LSL #0
    SUB  X12, X4, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, D16
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x4000, LSL #48
    SUB  X12, X4, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7fe0, LSL #16
    SUB  X18, X23, X14
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, D17
    MOVZ  X23, #0x0, LSL #0
    SUB  X18, X23, X14
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, V18.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, D18
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x4000, LSL #16
    SUB  X8, X16, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X25, X21, X20
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, D19
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X25, X21, X20
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X14, X12, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, D20
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xffe0, LSL #32
    MOVK  X12, #0x7f, LSL #48
    SUB  X14, X12, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X9, X18, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, D21
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xbfff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X9, X18, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, D22
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X19, X28, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, D23
    MOVZ  X28, #0x7f, LSL #0
    SUB  X19, X28, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, D24
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, D25
    MOVZ  X9, #0x7fff, LSL #0
    SUB  X20, X9, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X6, X29, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, D26
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x4000, LSL #16
    SUB  X6, X29, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, V27.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, D27
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x3ff0, LSL #48
    SUB  X5, X8, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X2
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, D28
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X2
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X24, X2, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D29
    MOVZ  X2, #0x7fff, LSL #0
    SUB  X24, X2, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
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
    FMOV  D0, X28
    FMOV  V0.D[1], X29
    FMOV  D1, X10
    FMOV  V1.D[1], X21
    FMOV  D2, X25
    FMOV  V2.D[1], X7
    FMOV  D3, X12
    FMOV  V3.D[1], X15
    FMOV  D4, X3
    FMOV  V4.D[1], X19
    FMOV  D5, X27
    FMOV  V5.D[1], X3
    FMOV  D6, X5
    FMOV  V6.D[1], X16
    FMOV  D7, X12
    FMOV  V7.D[1], X21
    FMOV  D8, X17
    FMOV  V8.D[1], X9
    FMOV  D9, X24
    FMOV  V9.D[1], X22
    FMOV  D10, X3
    FMOV  V10.D[1], X28
    FMOV  D11, X6
    FMOV  V11.D[1], X12
    FMOV  D12, X24
    FMOV  V12.D[1], X4
    FMOV  D13, X16
    FMOV  V13.D[1], X15
    FMOV  D14, X22
    FMOV  V14.D[1], X5
    FMOV  D15, X26
    FMOV  V15.D[1], X26
    FMOV  D16, X6
    FMOV  V16.D[1], X17
    FMOV  D17, X24
    FMOV  V17.D[1], X28
    FMOV  D18, X24
    FMOV  V18.D[1], X22
    FMOV  D19, X9
    FMOV  V19.D[1], X7
    FMOV  D20, X12
    FMOV  V20.D[1], X15
    FMOV  D21, X7
    FMOV  V21.D[1], X14
    FMOV  D22, X26
    FMOV  V22.D[1], X5
    FMOV  D23, X6
    FMOV  V23.D[1], X26
    FMOV  D24, X20
    FMOV  V24.D[1], X4
    FMOV  D25, X15
    FMOV  V25.D[1], X12
    FMOV  D26, X4
    FMOV  V26.D[1], X4
    FMOV  D27, X3
    FMOV  V27.D[1], X12
    FMOV  D28, X8
    FMOV  V28.D[1], X7
    FMOV  D29, X10
    FMOV  V29.D[1], X25
    FMOV  D30, X15
    FMOV  V30.D[1], X26
    FMOV  D31, X16
    FMOV  V31.D[1], X11
    MOVZ  X3, #0xf, LSL #0
TaishanSimdFpIntConversionP01_label_1039:
    FABS  V21.2D, V16.2D
    SXTL V23.2D, V21.2S
    UXTL2 V17.2D, V26.4S
    USQADD  B3, B4
TaishanSimdFpIntConversionP01_label_280:
    SXTL2 V29.2D, V5.4S
    UXTL2 V29.2D, V6.4S
    REV16  V26.16B, V30.16B
    UXTL V20.8H, V28.8B
    SQABS  H28, H17
    NOT  V14.16B, V1.16B
    SXTL V29.2D, V20.2S
    SXTL V25.4S, V0.4H
    REV64  V14.8B, V29.8B
    USQADD  V17.2S, V25.2S
    NEG  V26.8B, V1.8B
    UQXTN  B26, H12
    SQNEG  D20, D3
    MVN  V30.8B, V5.8B
    SQXTUN  B12, H17
    SQABS  V23.8H, V20.8H
    UQXTN  V16.4H, V31.4S
    SQABS  V23.8B, V16.8B
    SQXTUN  V20.8B, V8.8H
    SQXTN  H14, S4
    FSQRT  V20.2S, V26.2S
    XTN  V17.8B, V24.8H
    SXTL V0.2D, V27.2S
    SQXTN  H4, S0
    FRECPS  S31, S21, S30
    SQNEG  D6, D3
    SQABS  S3, S25
    MVN  V16.8B, V26.8B
    SXTL V4.4S, V28.4H
    UQXTN  S7, D17
    FRSQRTE  V3.2D, V9.2D
    UADALP  V8.1D, V25.2S
    SADDLP  V9.8H, V20.16B
    UXTL V26.8H, V25.8B
    SQNEG  H8, H31
    SQXTN  H16, S8
    SQXTUN  H24, S24
    UXTL V1.4S, V29.4H
    FCVTXN  S12, D10
    UXTL2 V10.4S, V27.8H
    SQXTN  B10, H27
    FCVTXN  V14.2S, V17.2D
    CLZ  V10.4H, V9.4H
    SQXTN  V8.2S, V13.2D
    SUQADD  S30, S3
    NEG  V11.4S, V12.4S
    UADDLP  V10.2S, V27.4H
    FCVTXN  S6, D4
    UXTL V26.8H, V30.8B
    SQXTUN  H31, S19
    URECPE  V19.4S, V16.4S
    SQABS  H9, H30
    UXTL2 V25.4S, V26.8H
    UXTL2 V21.4S, V29.8H
    SQABS  B16, B27
    URSQRTE  V4.4S, V30.4S
    SQXTUN2  V17.4S, V20.2D
    FRINTA  V26.4S, V21.4S
    USQADD  B27, B6
    SQXTUN2  V25.16B, V11.8H
    REV16  V13.8B, V17.8B
    NEG  D14, D22
    FRECPX  D24, D19
    SQNEG  S9, S18
    FRECPS  D29, D14, D29
    FRINTN  V29.2D, V12.2D
    UQXTN  S0, D7
    XTN2  V18.16B, V26.8H
    SQABS  B8, B31
    SQNEG  H11, H22
    CLZ  V28.4H, V21.4H
    SUQADD  H29, H24
    SQXTN  S23, D19
    CNT  V9.16B, V14.16B
    FRINTZ  V18.4S, V8.4S
    CLZ  V13.8B, V22.8B
    USQADD  H30, H10
    REV32  V21.8H, V23.8H
    CNT  V3.16B, V17.16B
    SUQADD  D12, D23
    SQXTUN  S25, D2
    SQXTUN  H27, S3
    SQABS  H14, H18
    FRSQRTE  V29.2S, V30.2S
    SQXTN  B18, H27
    UXTL2 V6.2D, V14.4S
    CLS  V23.4S, V15.4S
    RBIT  V11.8B, V30.8B
    FRINTX  V6.2D, V9.2D
    USQADD  V11.8B, V22.8B
    FRINTP  V1.4S, V4.4S
    SXTL2 V14.8H, V3.16B
    USQADD  H3, H17
    SQXTUN  V21.4H, V25.4S
    XTN  V12.8B, V6.8H
    SXTL2 V15.4S, V11.8H
    SXTL2 V28.4S, V22.8H
    URECPE  V19.2S, V4.2S
    SUQADD  H30, H13
    SUQADD  D4, D20
    SQXTUN2  V29.8H, V3.4S
    SXTL2 V14.2D, V11.4S
    FRINTI  V1.4S, V17.4S
    FRINTA  V26.2D, V28.2D
    FRECPS  S6, S26, S8
    SUQADD  D13, D6
    SQXTUN  H4, S24
    FSQRT  V12.2S, V11.2S
    SQXTN2  V8.8H, V15.4S
    SQXTN  H10, S0
    FRINTI  V27.2S, V28.2S
    USQADD  V11.8H, V0.8H
    SQXTUN  H22, S4
    NEG  V28.16B, V7.16B
    UXTL V23.4S, V8.4H
    SQXTN  B10, H26
    SQXTUN  B6, H10
    MVN  V13.8B, V26.8B
    SQNEG  V13.2D, V15.2D
    USQADD  S17, S6
    FCVTXN2  V7.4S, V3.2D
    UQXTN2  V22.8H, V26.4S
    SQABS  S8, S15
    MVN  V26.16B, V18.16B
    FRECPS  S22, S28, S26
    FRSQRTE  S13, S22
    FRECPS  V25.2D, V18.2D, V26.2D
    SQABS  H23, H17
    SXTL V13.2D, V15.2S
    REV32  V7.8H, V15.8H
    SQXTUN  B11, H25
    FRECPS  D17, D24, D28
    URSQRTE  V25.2S, V2.2S
    UQXTN  B25, H25
    FSQRT  V2.4S, V0.4S
    UXTL V12.8H, V3.8B
    SQXTN  B26, H11
    SQNEG  H8, H28
    RBIT  V1.8B, V25.8B
    SQNEG  B11, B2
    SXTL V9.4S, V12.4H
    SQNEG  H30, H12
    CNT  V25.8B, V15.8B
    SQABS  V24.2D, V30.2D
    FRECPS  V5.2S, V26.2S, V27.2S
    SXTL V8.4S, V31.4H
    FRSQRTE  S3, S26
    SQXTUN2  V21.4S, V3.2D
    UXTL2 V6.8H, V8.16B
    SQXTUN  H11, S29
    SQXTN2  V0.8H, V24.4S
    USQADD  S27, S31
    ABS  D6, D29
    SQXTUN  H12, S24
    RBIT  V6.16B, V21.16B
    SXTL2 V11.8H, V27.16B
    SUQADD  V5.16B, V0.16B
    FRECPS  D28, D1, D6
    SQXTN2  V10.4S, V23.2D
    SADALP  V28.8H, V16.16B
    UXTL V11.8H, V25.8B
    UXTL V12.4S, V11.4H
    FRSQRTE  V10.2S, V1.2S
    SQABS  S4, S12
    USQADD  S3, S10
    FRINTA  V19.2D, V3.2D
    SQXTN2  V5.16B, V3.8H
    UQXTN2  V28.4S, V22.2D
    NOT  V17.8B, V21.8B
    SQXTUN2  V11.4S, V17.2D
    SXTL V25.4S, V26.4H
    FRSQRTE  S14, S1
    USQADD  V3.2D, V27.2D
    SXTL V24.4S, V6.4H
    MVN  V4.16B, V28.16B
    UXTL2 V13.2D, V4.4S
    SQXTUN  B21, H17
    FRECPX  S19, S22
    SQXTN  H15, S6
    USQADD  B11, B5
    UXTL2 V2.8H, V21.16B
TaishanSimdFpIntConversionP01_label_268:
    FRINTZ  V31.2D, V2.2D
    FRINTI  V25.4S, V6.4S
    FCVTXN  V27.2S, V26.2D
    FRECPS  V25.2S, V4.2S, V25.2S
    SQXTUN  H24, S17
    SQXTUN  B19, H1
    FRECPX  S5, S20
    FCVTXN  S2, D30
    SQABS  V17.16B, V0.16B
    UQXTN  S9, D0
    SUQADD  V7.2S, V16.2S
    FRECPX  S25, S10
    URECPE  V27.4S, V16.4S
    RBIT  V16.16B, V7.16B
    SUQADD  S31, S24
    SUBS  X3, X3, #0x1
    B.NE  TaishanSimdFpIntConversionP01_label_1039
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X2, X10, X2
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X2, X15, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X4, X7, X4
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X6, X3, X5
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X15, X9, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X8, X18, X8
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X11, X25, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X14, X21, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X29, X12, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X15
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X16
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X15, X6, X17
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X20, X22, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X6, X26, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X7, X28, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X15, X29, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X14, X21, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X21, X14, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X25
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X20, X14, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X3, X18, X27
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X20, X16, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X18, X14, X29
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, D2
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, D3
    MOVZ  X15, #0xff, LSL #0
    MOVK  X15, #0xe235, LSL #16
    SUB  X22, X15, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V4.D[1]
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X5, X14, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D4
    MOVZ  X14, #0xfffe, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xbfff, LSL #48
    SUB  X5, X14, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, D5
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x7f00, LSL #16
    SUB  X29, X24, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xfe01, LSL #16
    SUB  X14, X24, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D6
TaishanSimdFpIntConversionP01_label_804:
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X3
TaishanSimdFpIntConversionP01_label_87:
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X18, V7.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X18, D7
    MOVZ  X17, #0x1, LSL #0
    SUB  X26, X17, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, D8
    MOVZ  X7, #0xff, LSL #0
    SUB  X23, X7, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, D9
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, D10
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x62b5, LSL #16
    MOVK  X17, #0x7f80, LSL #48
    SUB  X7, X17, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, D11
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X18, D12
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, V14.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X2, X15, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, D14
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x62b5, LSL #16
    SUB  X2, X15, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, V15.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, D15
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V16.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D16
    MOVZ  X25, #0x80, LSL #0
    SUB  X11, X25, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, V17.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, D17
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V18.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D18
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, D19
    MOVZ  X6, #0xff, LSL #0
    SUB  X27, X6, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, D20
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, D21
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, D22
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X11, X9, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X17, X20, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, D23
    MOVZ  X20, #0x0, LSL #0
    SUB  X17, X20, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X26
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, D24
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X26
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, D25
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x1d00, LSL #16
    SUB  X11, X18, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X20, X11, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, D26
    MOVZ  X11, #0x0, LSL #0
    SUB  X20, X11, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X3, X17, X4
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, D27
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X3, X17, X4
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X3, X9, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, D28
    MOVZ  X9, #0x1, LSL #0
    MOVK  X9, #0x4000, LSL #48
    SUB  X3, X9, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, D29
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x60b5, LSL #16
    MOVK  X10, #0x7f80, LSL #48
    SUB  X2, X10, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X2, #0x130e, LSL #0
    MOVK  X2, #0xd5c7, LSL #16
    MOVK  X2, #0x4186, LSL #32
    MOVK  X2, #0x2548, LSL #48
    MOVZ  X3, #0x6484, LSL #0
    MOVK  X3, #0xb595, LSL #16
    MOVK  X3, #0x22, LSL #32
    MOVK  X3, #0x27d5, LSL #48
    MOVZ  X4, #0xed04, LSL #0
    MOVK  X4, #0xe7d0, LSL #16
    MOVK  X4, #0x380a, LSL #32
    MOVK  X4, #0x3b0e, LSL #48
    MOVZ  X5, #0x1f01, LSL #0
    MOVK  X5, #0x7c6a, LSL #16
    MOVK  X5, #0xe2de, LSL #32
    MOVK  X5, #0x9651, LSL #48
    MOVZ  X6, #0xca3a, LSL #0
    MOVK  X6, #0x6c3f, LSL #16
    MOVK  X6, #0x8230, LSL #32
    MOVK  X6, #0xf8f8, LSL #48
    MOVZ  X7, #0xe81d, LSL #0
    MOVK  X7, #0x5b5c, LSL #16
    MOVK  X7, #0xe82, LSL #32
    MOVK  X7, #0x1cad, LSL #48
    MOVZ  X8, #0x79d9, LSL #0
    MOVK  X8, #0x5c43, LSL #16
    MOVK  X8, #0xeec, LSL #32
    MOVK  X8, #0xca92, LSL #48
    MOVZ  X9, #0x950e, LSL #0
    MOVK  X9, #0xa5b7, LSL #16
    MOVK  X9, #0x42bc, LSL #32
    MOVK  X9, #0xe713, LSL #48
    MOVZ  X10, #0x1845, LSL #0
    MOVK  X10, #0x849f, LSL #16
    MOVK  X10, #0x29e3, LSL #32
    MOVK  X10, #0xd67b, LSL #48
    MOVZ  X11, #0xe3b1, LSL #0
    MOVK  X11, #0xf08b, LSL #16
    MOVK  X11, #0x6e5f, LSL #32
    MOVK  X11, #0x55b8, LSL #48
    MOVZ  X12, #0x7004, LSL #0
    MOVK  X12, #0xd82f, LSL #16
    MOVK  X12, #0xb4a3, LSL #32
    MOVK  X12, #0x54d1, LSL #48
    MOVZ  X14, #0xc6c, LSL #0
    MOVK  X14, #0x925b, LSL #16
    MOVK  X14, #0xcfd2, LSL #32
    MOVK  X14, #0x3af1, LSL #48
    MOVZ  X15, #0x1a1b, LSL #0
    MOVK  X15, #0x9af8, LSL #16
    MOVK  X15, #0x6731, LSL #32
    MOVK  X15, #0xc0ed, LSL #48
    MOVZ  X16, #0xb844, LSL #0
    MOVK  X16, #0xc51f, LSL #16
    MOVK  X16, #0xf8d4, LSL #32
    MOVK  X16, #0xb016, LSL #48
    MOVZ  X17, #0xcc68, LSL #0
    MOVK  X17, #0xb657, LSL #16
    MOVK  X17, #0x9bfb, LSL #32
    MOVK  X17, #0xf9ac, LSL #48
    MOVZ  X18, #0x3b6e, LSL #0
    MOVK  X18, #0x8859, LSL #16
    MOVK  X18, #0x3dc8, LSL #32
    MOVK  X18, #0x29f2, LSL #48
    MOVZ  X19, #0xe6c3, LSL #0
    MOVK  X19, #0x29d1, LSL #16
    MOVK  X19, #0x2aa3, LSL #32
    MOVK  X19, #0xfe35, LSL #48
    MOVZ  X20, #0x82f1, LSL #0
    MOVK  X20, #0x249e, LSL #16
    MOVK  X20, #0xa29e, LSL #32
    MOVK  X20, #0xdc86, LSL #48
    MOVZ  X21, #0xd33a, LSL #0
    MOVK  X21, #0x1f2f, LSL #16
    MOVK  X21, #0xd9cb, LSL #32
    MOVK  X21, #0x79ce, LSL #48
    MOVZ  X22, #0x5569, LSL #0
    MOVK  X22, #0xedc9, LSL #16
    MOVK  X22, #0xa91d, LSL #32
    MOVK  X22, #0x49f3, LSL #48
    MOVZ  X23, #0x3f95, LSL #0
    MOVK  X23, #0x4eaa, LSL #16
    MOVK  X23, #0x241e, LSL #32
    MOVK  X23, #0xf6a2, LSL #48
    MOVZ  X24, #0x7d3c, LSL #0
    MOVK  X24, #0xb736, LSL #16
    MOVK  X24, #0x37ca, LSL #32
    MOVK  X24, #0x335a, LSL #48
    MOVZ  X25, #0xfde9, LSL #0
    MOVK  X25, #0x9df4, LSL #16
    MOVK  X25, #0x39c7, LSL #32
    MOVK  X25, #0x64e7, LSL #48
    MOVZ  X26, #0x7b18, LSL #0
    MOVK  X26, #0x2b4c, LSL #16
    MOVK  X26, #0x10ee, LSL #32
    MOVK  X26, #0xdcb1, LSL #48
    MOVZ  X27, #0x3d48, LSL #0
    MOVK  X27, #0x5577, LSL #16
    MOVK  X27, #0xfbd3, LSL #32
    MOVK  X27, #0xaa64, LSL #48
    MOVZ  X28, #0xc0ce, LSL #0
    MOVK  X28, #0x7a97, LSL #16
    MOVK  X28, #0x169f, LSL #32
    MOVK  X28, #0x56, LSL #48
    MOVZ  X29, #0x8be2, LSL #0
    MOVK  X29, #0xb7a9, LSL #16
    MOVK  X29, #0x9eac, LSL #32
    MOVK  X29, #0xbc7c, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X6
    FMOV  D1, X20
    FMOV  V1.D[1], X28
    FMOV  D2, X11
    FMOV  V2.D[1], X17
    FMOV  D3, X21
    FMOV  V3.D[1], X8
    FMOV  D4, X17
    FMOV  V4.D[1], X10
    FMOV  D5, X9
    FMOV  V5.D[1], X8
    FMOV  D6, X24
    FMOV  V6.D[1], X29
    FMOV  D7, X6
    FMOV  V7.D[1], X6
    FMOV  D8, X20
    FMOV  V8.D[1], X9
    FMOV  D9, X28
    FMOV  V9.D[1], X10
    FMOV  D10, X2
    FMOV  V10.D[1], X10
    FMOV  D11, X10
    FMOV  V11.D[1], X6
    FMOV  D12, X14
    FMOV  V12.D[1], X2
    FMOV  D13, X2
    FMOV  V13.D[1], X29
    FMOV  D14, X15
    FMOV  V14.D[1], X25
    FMOV  D15, X11
    FMOV  V15.D[1], X25
    FMOV  D16, X2
    FMOV  V16.D[1], X27
    FMOV  D17, X5
    FMOV  V17.D[1], X7
    FMOV  D18, X24
    FMOV  V18.D[1], X7
    FMOV  D19, X26
    FMOV  V19.D[1], X9
    FMOV  D20, X4
    FMOV  V20.D[1], X3
    FMOV  D21, X3
    FMOV  V21.D[1], X8
    FMOV  D22, X4
    FMOV  V22.D[1], X24
    FMOV  D23, X23
    FMOV  V23.D[1], X29
    FMOV  D24, X2
    FMOV  V24.D[1], X18
    FMOV  D25, X18
    FMOV  V25.D[1], X26
    FMOV  D26, X21
    FMOV  V26.D[1], X3
    FMOV  D27, X9
    FMOV  V27.D[1], X5
    FMOV  D28, X28
    FMOV  V28.D[1], X2
    FMOV  D29, X2
    FMOV  V29.D[1], X23
    FMOV  D30, X18
    FMOV  V30.D[1], X28
    FMOV  D31, X27
    FMOV  V31.D[1], X12
    MOVZ  X3, #0xa, LSL #0
TaishanSimdFpIntConversionP01_label_1103:
    SQXTN2  V23.8H, V2.4S
    URECPE  V16.2S, V15.2S
    URSQRTE  V11.2S, V17.2S
    REV32  V30.8H, V22.8H
    FCVTXN  S11, D14
    FRINTI  V12.4S, V18.4S
    FRECPX  S17, S22
    SQXTUN  S28, D31
    SQXTUN2  V31.16B, V18.8H
    XTN  V3.8B, V2.8H
    SQXTN  H11, S1
    FRECPS  D7, D29, D9
    SQXTN  V11.4H, V31.4S
    XTN2  V25.8H, V4.4S
    SQXTN  B11, H25
    FRINTX  V6.2S, V16.2S
    UXTL V26.2D, V23.2S
    SQXTUN  V11.2S, V7.2D
    SQABS  S25, S13
    UQXTN  S29, D16
    MVN  V11.8B, V12.8B
    UQXTN  S2, D3
    SXTL2 V30.2D, V29.4S
    CLZ  V14.4S, V30.4S
    USQADD  D10, D4
    SXTL2 V29.2D, V25.4S
    SUQADD  B17, B25
    FCVTXN2  V0.4S, V8.2D
    URECPE  V20.4S, V0.4S
    FRECPS  V29.2D, V0.2D, V14.2D
    SXTL V8.2D, V17.2S
    SQNEG  V29.2D, V16.2D
    CNT  V20.16B, V17.16B
    ABS  D11, D15
    FRINTX  V1.2S, V10.2S
    FNEG  V23.4S, V22.4S
    SQXTN  B31, H15
    FRECPX  S23, S1
    FRINTZ  V19.2S, V23.2S
    SQXTUN  B30, H20
    SUQADD  S14, S29
    URECPE  V6.2S, V17.2S
    USQADD  H20, H19
    REV64  V8.2S, V8.2S
    ABS  D7, D23
    FRINTA  V29.2S, V24.2S
    FRECPX  S1, S28
    SUQADD  V31.8H, V10.8H
    RBIT  V8.16B, V10.16B
    SUQADD  S11, S0
    UXTL V30.4S, V11.4H
    FCVTXN  S10, D10
    SXTL V11.2D, V18.2S
    USQADD  B23, B22
    SUQADD  V19.4S, V18.4S
    SXTL2 V13.4S, V11.8H
    USQADD  V10.2S, V11.2S
    SQABS  V18.8H, V18.8H
    SQXTN  V25.8B, V4.8H
    USQADD  S25, S11
    NEG  V20.8H, V3.8H
    FNEG  V25.2S, V11.2S
    SQXTN2  V13.4S, V3.2D
    UQXTN2  V3.16B, V20.8H
    FRSQRTE  S8, S4
    FRSQRTE  D11, D9
    CNT  V8.16B, V10.16B
    UQXTN  S8, D30
    SXTL V11.2D, V2.2S
    UADALP  V22.4H, V23.8B
    REV16  V2.16B, V30.16B
    NEG  V8.16B, V11.16B
    SQNEG  S18, S6
    FSQRT  V23.2S, V6.2S
    UXTL V9.2D, V30.2S
    FRECPS  D18, D13, D23
    UXTL V18.8H, V11.8B
    UXTL V31.2D, V31.2S
    SQXTN2  V31.4S, V31.2D
    UXTL2 V21.2D, V2.4S
    FRINTZ  V8.4S, V4.4S
    SUQADD  H4, H6
    FRINTX  V6.4S, V6.4S
    SQABS  D28, D9
    URSQRTE  V5.4S, V23.4S
    SQNEG  H28, H8
    SQXTN2  V19.4S, V11.2D
    FRINTN  V25.2S, V2.2S
    UADDLP  V25.4S, V13.8H
    SXTL2 V30.2D, V13.4S
    SQXTUN  B9, H28
    FCVTXN  V28.2S, V5.2D
    FABS  V8.4S, V4.4S
    XTN  V10.4H, V17.4S
    NOT  V9.16B, V19.16B
    CLS  V9.2S, V13.2S
    FCVTXN2  V8.4S, V23.2D
    SQABS  V21.8B, V6.8B
    RBIT  V17.8B, V28.8B
    FRINTM  V7.2D, V13.2D
    UXTL2 V25.4S, V1.8H
    SQNEG  B4, B23
    SXTL2 V31.8H, V8.16B
    FRINTP  V22.4S, V2.4S
    URSQRTE  V17.4S, V22.4S
    FRECPX  S11, S25
    UXTL2 V27.2D, V1.4S
    FCVTXN  V14.2S, V30.2D
    FNEG  V22.4S, V15.4S
    UXTL2 V22.4S, V29.8H
    ABS  V5.2S, V26.2S
    SQXTUN2  V22.4S, V6.2D
    FRINTX  V11.4S, V14.4S
    SQNEG  D14, D23
    FRECPS  V26.2D, V26.2D, V11.2D
    FSQRT  V12.2S, V3.2S
    MVN  V13.16B, V18.16B
    SUQADD  S1, S20
    FRECPX  D11, D27
    USQADD  B5, B15
    UQXTN  H18, S15
    SQXTN  H28, S6
    SXTL V12.2D, V15.2S
    MVN  V3.16B, V15.16B
    SXTL V7.4S, V26.4H
    SQABS  H4, H24
    ABS  D1, D24
    UADALP  V12.1D, V21.2S
    CLS  V18.16B, V6.16B
    SQXTN  V10.8B, V27.8H
    REV64  V13.8B, V31.8B
    SXTL2 V18.2D, V1.4S
    SXTL V1.4S, V1.4H
    SXTL V11.8H, V17.8B
    SQNEG  H26, H12
    USQADD  S16, S27
    SQNEG  D28, D20
    USQADD  H18, H1
    SXTL2 V17.4S, V16.8H
    FCVTXN2  V25.4S, V12.2D
    FRINTA  V24.4S, V6.4S
    SQXTN  B23, H25
    SQXTUN  S15, D2
    SQXTUN  V24.4H, V2.4S
    USQADD  S5, S15
    UXTL2 V1.4S, V5.8H
    NOT  V25.16B, V4.16B
    SUQADD  B18, B9
    UADALP  V8.8H, V24.16B
    UQXTN2  V15.8H, V13.4S
    SADALP  V20.8H, V4.16B
    FRINTX  V30.2D, V26.2D
    USQADD  S7, S29
    FCVTXN  V6.2S, V24.2D
    UXTL V26.2D, V1.2S
    FRECPX  S9, S10
    SQABS  V13.8B, V28.8B
    SUQADD  B4, B1
    FRECPS  S13, S5, S9
    FRINTX  V6.4S, V31.4S
    UQXTN2  V12.4S, V4.2D
    FSQRT  V22.4S, V25.4S
    SQXTN  H24, S29
    UQXTN  H25, S22
    UQXTN  B22, H4
    UXTL V10.2D, V10.2S
    FRINTI  V28.2D, V30.2D
    FRECPX  D2, D9
    SXTL2 V7.4S, V8.8H
    CNT  V10.16B, V18.16B
    UQXTN  S8, D4
    UXTL2 V1.2D, V18.4S
    SUQADD  V14.2S, V24.2S
    FRINTA  V22.2S, V23.2S
    SXTL V22.2D, V11.2S
    SXTL2 V0.8H, V13.16B
    USQADD  S5, S3
    SXTL2 V14.4S, V4.8H
    SQXTN  V18.2S, V25.2D
    FRINTN  V9.2D, V4.2D
    SQABS  B18, B14
    UADDLP  V9.4H, V0.8B
    NEG  D20, D14
    SQXTN  V15.8B, V6.8H
    USQADD  V1.16B, V29.16B
    UXTL2 V30.8H, V21.16B
    FRSQRTE  D5, D12
    USQADD  S30, S9
    FRINTZ  V8.2S, V19.2S
    SUQADD  D22, D10
    NOT  V3.8B, V21.8B
    CLS  V4.8B, V13.8B
    URECPE  V9.2S, V0.2S
    SQXTN  B2, H15
    FRINTA  V21.4S, V2.4S
    FRINTP  V4.2D, V7.2D
    SQABS  S4, S23
    SUQADD  H4, H18
    UXTL2 V7.8H, V4.16B
    SQXTN  H16, S21
    SUBS  X3, X3, #0x1
    B.NE  TaishanSimdFpIntConversionP01_label_1103
    MOVZ  X20, #0x130e, LSL #0
    MOVK  X20, #0xd5c7, LSL #16
    MOVK  X20, #0x4186, LSL #32
    MOVK  X20, #0x2548, LSL #48
    SUB  X11, X20, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X24, #0xed04, LSL #0
    MOVK  X24, #0xe7d0, LSL #16
    MOVK  X24, #0x380a, LSL #32
    MOVK  X24, #0x3b0e, LSL #48
    SUB  X2, X24, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X20, #0x1f01, LSL #0
    MOVK  X20, #0x7c6a, LSL #16
    MOVK  X20, #0xe2de, LSL #32
    MOVK  X20, #0x9651, LSL #48
    SUB  X14, X20, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X5, #0xca3a, LSL #0
    MOVK  X5, #0x6c3f, LSL #16
    MOVK  X5, #0x8230, LSL #32
    MOVK  X5, #0xf8f8, LSL #48
    SUB  X9, X5, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X17, X20, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X27, #0x79d9, LSL #0
    MOVK  X27, #0x5c43, LSL #16
    MOVK  X27, #0xeec, LSL #32
    MOVK  X27, #0xca92, LSL #48
    SUB  X19, X27, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X28, X8, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X9, #0x1845, LSL #0
    MOVK  X9, #0x849f, LSL #16
    MOVK  X9, #0x29e3, LSL #32
    MOVK  X9, #0xd67b, LSL #48
    SUB  X8, X9, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X24, #0x7004, LSL #0
    MOVK  X24, #0xd82f, LSL #16
    MOVK  X24, #0xb4a3, LSL #32
    MOVK  X24, #0x54d1, LSL #48
    SUB  X22, X24, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X3, #0x1a1b, LSL #0
    MOVK  X3, #0x9af8, LSL #16
    MOVK  X3, #0x6731, LSL #32
    MOVK  X3, #0xc0ed, LSL #48
    SUB  X11, X3, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X8, #0xb844, LSL #0
    MOVK  X8, #0xc51f, LSL #16
    MOVK  X8, #0xf8d4, LSL #32
    MOVK  X8, #0xb016, LSL #48
    SUB  X6, X8, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X17
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X7, #0x3b6e, LSL #0
    MOVK  X7, #0x8859, LSL #16
    MOVK  X7, #0x3dc8, LSL #32
    MOVK  X7, #0x29f2, LSL #48
    SUB  X24, X7, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X7, X10, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X24, #0xd33a, LSL #0
    MOVK  X24, #0x1f2f, LSL #16
    MOVK  X24, #0xd9cb, LSL #32
    MOVK  X24, #0x79ce, LSL #48
    SUB  X16, X24, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X22
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X7, #0x3f95, LSL #0
    MOVK  X7, #0x4eaa, LSL #16
    MOVK  X7, #0x241e, LSL #32
    MOVK  X7, #0xf6a2, LSL #48
    SUB  X24, X7, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X2, X15, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X12, #0xfde9, LSL #0
    MOVK  X12, #0x9df4, LSL #16
    MOVK  X12, #0x39c7, LSL #32
    MOVK  X12, #0x64e7, LSL #48
    SUB  X20, X12, X25
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X9, #0x7b18, LSL #0
    MOVK  X9, #0x2b4c, LSL #16
    MOVK  X9, #0x10ee, LSL #32
    MOVK  X9, #0xdcb1, LSL #48
    SUB  X7, X9, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X21, X27, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X29
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, V2.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X17, X9, X24
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, D2
    MOVZ  X9, #0xff, LSL #0
    SUB  X17, X9, X24
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, V3.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, D3
    MOVZ  X6, #0xfefe, LSL #0
    MOVK  X6, #0xfefe, LSL #16
    MOVK  X6, #0xfefe, LSL #32
    MOVK  X6, #0xfefe, LSL #48
    SUB  X25, X6, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X3, X18, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, D4
    MOVZ  X18, #0x0, LSL #0
    SUB  X3, X18, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, V5.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, D5
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x9000, LSL #32
    MOVK  X6, #0x60b6, LSL #48
    SUB  X11, X6, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, V6.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, D6
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X7, X20, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X28, X8, X26
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, D7
    MOVZ  X8, #0x0, LSL #0
    SUB  X28, X8, X26
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X2, X29, X27
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, D8
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x4000, LSL #16
    SUB  X2, X29, X27
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V9.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D9
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X7, X19, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X28
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, D10
    MOVZ  X4, #0x5, LSL #0
    SUB  X19, X4, X28
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X25, X6, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, D11
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X25, X6, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X10, X4, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, D12
    MOVZ  X4, #0x201, LSL #0
    MOVK  X4, #0x202, LSL #16
    SUB  X10, X4, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, D14
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, D15
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X7, X6, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X9, X19, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, D16
    MOVZ  X19, #0x0, LSL #0
    SUB  X9, X19, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, V17.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, D17
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, V18.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, D18
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X4, #0xff, LSL #0
    SUB  X21, X4, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, D19
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x4000, LSL #16
    SUB  X21, X4, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X26, X28, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, D20
    MOVZ  X28, #0x0, LSL #0
    SUB  X26, X28, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, V21.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, D21
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V22.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X3
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D22
    MOVZ  X11, #0x4, LSL #0
    SUB  X10, X11, X3
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, D23
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X6, X18, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, D24
    MOVZ  X18, #0x0, LSL #0
    SUB  X6, X18, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X5, X17, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, D25
    MOVZ  X17, #0xffff, LSL #0
    SUB  X5, X17, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, D26
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V27.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D27
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, D28
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x3ff0, LSL #48
    SUB  X26, X18, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, V29.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, D29
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
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
    FMOV  D0, X19
    FMOV  V0.D[1], X29
    FMOV  D1, X27
    FMOV  V1.D[1], X19
    FMOV  D2, X24
    FMOV  V2.D[1], X6
    FMOV  D3, X21
    FMOV  V3.D[1], X16
    FMOV  D4, X21
    FMOV  V4.D[1], X22
    FMOV  D5, X27
    FMOV  V5.D[1], X21
    FMOV  D6, X16
    FMOV  V6.D[1], X9
    FMOV  D7, X4
    FMOV  V7.D[1], X22
    FMOV  D8, X7
    FMOV  V8.D[1], X8
    FMOV  D9, X3
    FMOV  V9.D[1], X8
    FMOV  D10, X7
    FMOV  V10.D[1], X10
    FMOV  D11, X24
    FMOV  V11.D[1], X4
    FMOV  D12, X27
    FMOV  V12.D[1], X2
    FMOV  D13, X11
    FMOV  V13.D[1], X25
    FMOV  D14, X29
    FMOV  V14.D[1], X22
    FMOV  D15, X8
    FMOV  V15.D[1], X29
    FMOV  D16, X29
    FMOV  V16.D[1], X29
    FMOV  D17, X24
    FMOV  V17.D[1], X5
    FMOV  D18, X26
    FMOV  V18.D[1], X23
    FMOV  D19, X12
    FMOV  V19.D[1], X4
    FMOV  D20, X27
    FMOV  V20.D[1], X2
    FMOV  D21, X28
    FMOV  V21.D[1], X8
    FMOV  D22, X22
    FMOV  V22.D[1], X15
    FMOV  D23, X10
    FMOV  V23.D[1], X2
    FMOV  D24, X18
    FMOV  V24.D[1], X25
    FMOV  D25, X14
    FMOV  V25.D[1], X26
    FMOV  D26, X6
    FMOV  V26.D[1], X8
    FMOV  D27, X27
    FMOV  V27.D[1], X22
    FMOV  D28, X16
    FMOV  V28.D[1], X23
    FMOV  D29, X15
    FMOV  V29.D[1], X25
    FMOV  D30, X2
    FMOV  V30.D[1], X20
    FMOV  D31, X19
    FMOV  V31.D[1], X22
    MOVZ  X14, #0xa, LSL #0
TaishanSimdFpIntConversionP01_label_1166:
    SQXTN  V26.2S, V1.2D
    RBIT  V1.8B, V20.8B
    SADDLP  V31.2D, V26.4S
    FRINTM  V24.4S, V16.4S
    SQABS  S3, S23
    USQADD  D15, D29
    NOT  V25.16B, V30.16B
    CNT  V16.8B, V30.8B
    SQXTUN  B14, H1
    SQNEG  V8.16B, V18.16B
    SQXTUN2  V24.16B, V2.8H
    FRINTI  V30.2S, V14.2S
    SQXTUN  B2, H3
    SQNEG  D19, D25
    FABS  V7.2S, V11.2S
    UQXTN  H24, S26
    RBIT  V10.8B, V15.8B
    REV64  V16.16B, V18.16B
    SXTL V3.2D, V9.2S
    FRECPX  S10, S12
    FCVTXN  S2, D14
    FNEG  V11.4S, V4.4S
    URSQRTE  V25.2S, V4.2S
    FRECPS  D17, D17, D8
    URSQRTE  V11.2S, V23.2S
    FRSQRTE  D20, D23
    UQXTN  B4, H27
    SQXTUN  S2, D26
    SQXTN  H16, S16
    RBIT  V4.8B, V9.8B
    USQADD  D26, D15
    SQABS  B3, B5
    REV16  V3.16B, V13.16B
    SUQADD  S10, S7
    FRINTM  V11.4S, V25.4S
    SXTL V9.4S, V11.4H
    FRINTA  V2.2D, V11.2D
    USQADD  V17.16B, V24.16B
    SQNEG  S17, S3
    SQXTN  B7, H24
    UXTL V10.8H, V31.8B
    SQABS  V9.4S, V16.4S
    USQADD  D24, D22
    USQADD  B29, B18
    SQXTUN  B25, H21
    UXTL2 V3.4S, V21.8H
    FRINTZ  V26.4S, V24.4S
    SADDLP  V19.4H, V11.8B
    RBIT  V4.16B, V18.16B
    FRINTZ  V7.2D, V24.2D
    REV64  V15.4H, V14.4H
    FRINTP  V10.4S, V29.4S
    SQNEG  H5, H17
    UADALP  V9.8H, V16.16B
    SUQADD  S1, S25
    ABS  V18.16B, V3.16B
    FABS  V31.2S, V28.2S
    FRSQRTE  V28.4S, V26.4S
    USQADD  B17, B21
    REV64  V12.16B, V10.16B
    SQNEG  H19, H10
    SUQADD  B11, B20
    NEG  V8.4S, V19.4S
    SUQADD  H6, H12
    SXTL V25.2D, V17.2S
    SUQADD  B16, B25
    SQNEG  H6, H11
    UQXTN2  V27.8H, V28.4S
    UADALP  V28.4S, V20.8H
    SXTL V17.2D, V3.2S
    SQNEG  D15, D27
    REV32  V7.8H, V2.8H
    UQXTN2  V20.8H, V31.4S
    NEG  V3.16B, V27.16B
    NEG  D20, D25
    FRECPS  V16.2D, V21.2D, V19.2D
    UXTL V6.8H, V12.8B
    SUQADD  B7, B18
    UADDLP  V2.2D, V20.4S
    SUQADD  B6, B28
    SXTL V20.8H, V12.8B
    FRSQRTE  V16.2S, V0.2S
    SXTL2 V10.4S, V1.8H
    SQXTN2  V13.16B, V19.8H
    SUQADD  D2, D12
    SQABS  S7, S11
    NEG  V27.4H, V7.4H
    FCVTXN  S2, D6
    SQXTUN  H8, S20
    USQADD  H11, H10
    FRSQRTE  S22, S3
    SQXTN  H29, S16
    FABS  V2.2D, V28.2D
    UQXTN  B18, H19
    SQNEG  V19.16B, V29.16B
    SQXTUN  V13.2S, V30.2D
    SQNEG  B30, B0
    SUQADD  V12.8B, V20.8B
    NEG  V4.8B, V19.8B
    FRINTA  V0.4S, V13.4S
    FRINTI  V13.2S, V7.2S
    CNT  V0.16B, V5.16B
    FRSQRTE  D11, D1
    SQABS  B28, B9
    USQADD  H4, H30
    FRECPX  D29, D25
    USQADD  S25, S30
    SQXTN  V24.4H, V3.4S
    FRINTZ  V22.4S, V7.4S
    SQXTUN2  V23.8H, V24.4S
    FRSQRTE  D16, D2
    FCVTXN2  V5.4S, V17.2D
    FRINTP  V12.2S, V3.2S
    SQABS  S24, S20
    SUQADD  B6, B6
    FABS  V19.2S, V4.2S
    FRINTN  V6.2D, V23.2D
    CLZ  V3.8B, V20.8B
    USQADD  B18, B3
    URSQRTE  V6.2S, V21.2S
    SQNEG  V5.4S, V6.4S
    SQXTUN  B17, H5
    SQABS  D18, D24
    NEG  D2, D29
    CNT  V23.8B, V27.8B
    NEG  D21, D24
    SQABS  B1, B19
    CLS  V4.16B, V29.16B
    REV64  V20.8B, V11.8B
    SQXTUN  H25, S10
    USQADD  H3, H10
    FCVTXN  S30, D29
    UQXTN  S7, D11
    UQXTN  H7, S7
    SQXTN2  V4.8H, V19.4S
    URECPE  V18.4S, V26.4S
    USQADD  V6.2S, V9.2S
    SUQADD  B21, B26
    SQXTUN  B11, H14
    REV32  V29.8H, V11.8H
    FRINTX  V4.4S, V10.4S
    UQXTN  S24, D19
    FRECPS  S21, S17, S10
    USQADD  H14, H19
    SQABS  V17.2S, V7.2S
    SQABS  S1, S21
    FNEG  V9.2S, V16.2S
    ABS  D25, D29
    FRINTN  V6.2S, V27.2S
    FRECPS  V26.2D, V30.2D, V29.2D
    UXTL2 V30.2D, V15.4S
    UXTL V28.4S, V31.4H
    FRINTN  V6.2S, V3.2S
    SQABS  H7, H14
    SQXTUN  H18, S2
    URECPE  V13.2S, V0.2S
    REV16  V30.8B, V26.8B
    FCVTXN  V27.2S, V16.2D
    SXTL2 V26.8H, V2.16B
    FABS  V4.4S, V18.4S
    FRSQRTE  S15, S6
    SQXTUN  H18, S9
    UQXTN  V21.4H, V2.4S
    XTN  V16.8B, V4.8H
    FCVTXN2  V9.4S, V26.2D
    UXTL V4.2D, V29.2S
    URSQRTE  V1.4S, V23.4S
    SADDLP  V29.8H, V28.16B
    SQXTUN  V18.8B, V25.8H
    SQNEG  D31, D12
    REV64  V14.8H, V17.8H
    SQXTUN  S10, D26
    SUQADD  B29, B29
    UXTL2 V11.2D, V8.4S
    SQXTUN  S26, D0
    SQXTN  V13.8B, V2.8H
    SADDLP  V28.8H, V27.16B
    UXTL V3.8H, V5.8B
    FABS  V30.2S, V27.2S
    UQXTN  V4.4H, V16.4S
    SXTL V7.4S, V5.4H
    CLS  V14.16B, V1.16B
    SXTL2 V21.4S, V18.8H
    SADDLP  V23.4S, V20.8H
    SXTL2 V9.4S, V1.8H
    FRINTN  V28.2D, V3.2D
    FRINTM  V10.4S, V8.4S
    CNT  V21.8B, V20.8B
    FRINTX  V27.4S, V11.4S
    SQABS  V14.2D, V4.2D
    UQXTN  S21, D9
    UXTL2 V16.8H, V0.16B
    SQNEG  S16, S7
    UXTL2 V19.2D, V12.4S
    FRSQRTE  S0, S9
    UXTL V28.8H, V25.8B
    UXTL V31.4S, V16.4H
    SQXTN2  V24.16B, V5.8H
    URSQRTE  V18.4S, V10.4S
    SQXTUN2  V14.8H, V0.4S
    SUBS  X14, X14, #0x1
    B.NE  TaishanSimdFpIntConversionP01_label_1166
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X12, X2, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X9
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X22, X21, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X26, X15, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X22, X21, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X22, X23, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X24, X28, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X12, X9, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X18, X21, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X5, X26, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X18, X3, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, D2
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x8020, LSL #48
    SUB  X18, X3, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X2, #0x1, LSL #0
    SUB  X11, X2, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, D3
    MOVZ  X2, #0xff, LSL #0
    MOVK  X2, #0xff, LSL #16
    MOVK  X2, #0xff, LSL #32
    MOVK  X2, #0x7f, LSL #48
    SUB  X11, X2, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X26
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, D4
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X26
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X18, V5.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X18, D5
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0x7fff, LSL #16
    MOVK  X25, #0x1, LSL #32
    SUB  X7, X25, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, V6.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, D6
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, V7.D[1]
    MOVZ  X3, #0x1, LSL #0
    SUB  X26, X3, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, D7
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0x7fff, LSL #32
    SUB  X26, X3, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, V8.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, D8
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X20, X25, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, D9
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X20, X25, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X25, X5, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, D10
    MOVZ  X5, #0x0, LSL #0
    SUB  X25, X5, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, D11
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, D12
    MOVZ  X27, #0x0, LSL #0
TaishanSimdFpIntConversionP01_label_1148:
    SUB  X26, X27, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X20
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, D14
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X20
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, V15.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, D15
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7f80, LSL #16
    SUB  X9, X22, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, V16.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, D16
    MOVZ  X10, #0x1, LSL #0
    SUB  X15, X10, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X12, X24, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D17
    MOVZ  X24, #0xffff, LSL #0
    SUB  X12, X24, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X9, X23, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, D18
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X9, X23, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, V19.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X20, X15, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, D19
    MOVZ  X15, #0x0, LSL #0
    SUB  X20, X15, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, D20
    MOVZ  X10, #0xeb60, LSL #0
    MOVK  X10, #0x40, LSL #16
    SUB  X2, X10, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X18, X7, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, D21
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X18, X7, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, V22.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, D22
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, D23
    MOVZ  X26, #0xeba0, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X4, X26, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, V24.D[1]
    MOVZ  X5, #0x7fff, LSL #0
    MOVK  X5, #0x1, LSL #16
    SUB  X9, X5, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, D24
    MOVZ  X5, #0xffff, LSL #0
    SUB  X9, X5, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, D25
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X14
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, D26
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X14
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, V27.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X3, X16, X17
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, D27
    MOVZ  X16, #0x0, LSL #0
    SUB  X3, X16, X17
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, V28.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X25
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, D28
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X25
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, V29.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X23, X15, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, D29
    MOVZ  X15, #0x0, LSL #0
    SUB  X23, X15, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
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
    FMOV  D0, X6
    FMOV  V0.D[1], X27
    FMOV  D1, X28
    FMOV  V1.D[1], X27
    FMOV  D2, X10
    FMOV  V2.D[1], X11
    FMOV  D3, X5
    FMOV  V3.D[1], X6
    FMOV  D4, X26
    FMOV  V4.D[1], X29
    FMOV  D5, X28
    FMOV  V5.D[1], X3
    FMOV  D6, X5
    FMOV  V6.D[1], X28
    FMOV  D7, X3
    FMOV  V7.D[1], X27
    FMOV  D8, X9
    FMOV  V8.D[1], X3
    FMOV  D9, X15
    FMOV  V9.D[1], X10
    FMOV  D10, X21
    FMOV  V10.D[1], X8
    FMOV  D11, X12
    FMOV  V11.D[1], X25
    FMOV  D12, X2
    FMOV  V12.D[1], X6
    FMOV  D13, X8
    FMOV  V13.D[1], X5
    FMOV  D14, X29
    FMOV  V14.D[1], X28
    FMOV  D15, X17
    FMOV  V15.D[1], X24
    FMOV  D16, X11
    FMOV  V16.D[1], X27
    FMOV  D17, X2
    FMOV  V17.D[1], X18
    FMOV  D18, X14
    FMOV  V18.D[1], X9
    FMOV  D19, X12
    FMOV  V19.D[1], X28
    FMOV  D20, X5
    FMOV  V20.D[1], X19
    FMOV  D21, X19
    FMOV  V21.D[1], X6
    FMOV  D22, X18
    FMOV  V22.D[1], X26
    FMOV  D23, X15
    FMOV  V23.D[1], X6
    FMOV  D24, X21
    FMOV  V24.D[1], X5
    FMOV  D25, X27
    FMOV  V25.D[1], X11
    FMOV  D26, X28
    FMOV  V26.D[1], X23
    FMOV  D27, X28
    FMOV  V27.D[1], X26
    FMOV  D28, X8
    FMOV  V28.D[1], X4
    FMOV  D29, X14
    FMOV  V29.D[1], X20
    FMOV  D30, X10
    FMOV  V30.D[1], X21
    FMOV  D31, X18
    FMOV  V31.D[1], X26
    MOVZ  X26, #0xf, LSL #0
TaishanSimdFpIntConversionP01_label_1233:
    UADDLP  V20.8H, V22.16B
    SQXTUN  V26.4H, V20.4S
    SQNEG  H5, H28
    SQABS  S10, S5
    CNT  V12.16B, V19.16B
    SQABS  V17.2D, V11.2D
    RBIT  V12.8B, V31.8B
    UQXTN2  V2.8H, V23.4S
    UXTL2 V21.4S, V10.8H
    SUQADD  H3, H16
    FRSQRTE  S20, S26
    FRSQRTE  S9, S13
    FRINTA  V0.2D, V12.2D
    SUQADD  V18.8B, V8.8B
    SXTL2 V11.2D, V18.4S
    CLZ  V15.2S, V17.2S
    XTN2  V0.16B, V9.8H
    FRINTZ  V0.4S, V7.4S
    REV16  V0.8B, V23.8B
    FRINTN  V28.2S, V31.2S
    SADDLP  V6.4H, V29.8B
    USQADD  V2.8B, V16.8B
    SQXTUN2  V5.8H, V0.4S
    SQNEG  D24, D10
    USQADD  V26.16B, V26.16B
    FRECPX  D10, D22
    SQXTUN  V13.2S, V7.2D
    MVN  V12.16B, V24.16B
    SQNEG  V27.8H, V14.8H
    SUQADD  V0.8H, V0.8H
    CLS  V1.4H, V21.4H
    FRINTM  V27.2D, V14.2D
    SQXTN2  V24.4S, V6.2D
    REV64  V2.8B, V3.8B
    CLS  V31.8B, V4.8B
    SUQADD  H9, H26
    SXTL V5.4S, V26.4H
    SXTL2 V7.4S, V21.8H
    MVN  V14.8B, V11.8B
    NEG  D6, D17
    UQXTN  H17, S31
    REV32  V27.4H, V10.4H
    FRECPS  S27, S15, S23
    UXTL2 V3.4S, V23.8H
    SQABS  V20.2S, V7.2S
    XTN2  V16.8H, V25.4S
    MVN  V28.16B, V6.16B
    UQXTN  V29.2S, V12.2D
    USQADD  V14.8B, V19.8B
    FRINTI  V17.4S, V25.4S
    ABS  D9, D2
    SUQADD  D16, D0
    MVN  V13.8B, V0.8B
    SXTL2 V8.2D, V12.4S
    USQADD  B10, B27
    NEG  V3.8H, V22.8H
    USQADD  H26, H3
    REV32  V0.8B, V21.8B
    FRSQRTE  S13, S20
    USQADD  S20, S20
    URECPE  V16.4S, V2.4S
    SUQADD  V27.16B, V2.16B
    FRINTX  V9.2S, V17.2S
    FABS  V6.2S, V7.2S
    FRECPS  V15.2D, V14.2D, V10.2D
    SQXTUN  H8, S18
    FRSQRTE  S10, S27
    FRINTN  V31.2D, V12.2D
    USQADD  D2, D2
    URSQRTE  V26.4S, V20.4S
    FABS  V23.4S, V8.4S
    SQXTN2  V2.16B, V2.8H
    MVN  V10.8B, V18.8B
    UQXTN  V2.4H, V23.4S
    SQNEG  S17, S17
    SQXTUN  B15, H16
    SQNEG  S30, S9
    ABS  D16, D14
    FABS  V6.4S, V2.4S
    NOT  V20.8B, V17.8B
    UQXTN  S19, D12
    SXTL V18.4S, V5.4H
    SQABS  S4, S5
    CLS  V7.2S, V25.2S
    FCVTXN  V15.2S, V4.2D
    UQXTN  B25, H2
    SQXTN  V12.4H, V18.4S
    ABS  D14, D18
    FRSQRTE  V5.2S, V7.2S
    URECPE  V24.4S, V14.4S
    SQXTN  H12, S7
    SXTL V20.2D, V17.2S
    NEG  V17.8B, V10.8B
    FSQRT  V25.2S, V12.2S
    FRSQRTE  S24, S11
    UXTL V25.8H, V18.8B
    UQXTN  B10, H17
    SXTL2 V8.8H, V25.16B
    SQNEG  S24, S15
    USQADD  H10, H8
    SQXTN  H23, S10
    SXTL V7.8H, V10.8B
    SXTL2 V15.2D, V27.4S
    FABS  V15.2S, V28.2S
    CLZ  V20.4H, V28.4H
    SUQADD  H30, H9
    SQXTN  H27, S24
    FRINTA  V21.2D, V19.2D
    UXTL V21.2D, V7.2S
    UQXTN  S13, D0
    REV16  V18.8B, V5.8B
    FRINTM  V10.4S, V23.4S
    FSQRT  V7.2S, V28.2S
    FCVTXN  V3.2S, V20.2D
    FRECPX  D27, D30
    SQABS  S1, S4
    RBIT  V9.16B, V17.16B
    FRINTX  V8.4S, V24.4S
    MVN  V17.8B, V8.8B
    SUQADD  H27, H15
    SXTL2 V22.4S, V4.8H
    REV16  V23.8B, V10.8B
    UQXTN2  V0.8H, V11.4S
    SQXTN  V20.2S, V12.2D
    FRSQRTE  S13, S28
    SUQADD  B31, B2
    CNT  V2.8B, V17.8B
    SUQADD  S0, S14
    FABS  V29.4S, V17.4S
    SQABS  D8, D29
    FCVTXN  V25.2S, V16.2D
    UXTL2 V2.8H, V29.16B
    USQADD  B21, B27
    FCVTXN  S30, D9
    FRINTX  V19.2D, V22.2D
    SQXTUN  H11, S26
    SXTL2 V17.4S, V13.8H
    NEG  D2, D1
    FNEG  V25.2D, V30.2D
    SADDLP  V18.4S, V11.8H
    UQXTN  H5, S25
    SUQADD  D28, D18
    FRINTX  V8.4S, V6.4S
    SQXTN2  V23.4S, V12.2D
    SADDLP  V10.2D, V25.4S
    SUQADD  S14, S16
    NEG  V31.4S, V2.4S
    USQADD  B28, B28
    SQNEG  B11, B28
    SUQADD  B30, B5
    SQXTN  B21, H28
    FCVTXN  S8, D29
    USQADD  D20, D17
    SXTL2 V14.2D, V19.4S
    XTN  V6.2S, V31.2D
    FRECPX  S14, S2
    FSQRT  V30.2D, V14.2D
    URECPE  V25.2S, V18.2S
    FSQRT  V21.4S, V2.4S
    FRINTZ  V19.2S, V25.2S
    CLS  V17.4S, V30.4S
    FRINTN  V14.4S, V9.4S
    USQADD  S23, S14
    SXTL2 V26.8H, V10.16B
    SQABS  S18, S20
    USQADD  H25, H28
    CLZ  V16.2S, V0.2S
    SXTL2 V17.2D, V29.4S
    SQABS  V9.16B, V2.16B
    NEG  V29.2S, V2.2S
    UXTL2 V6.8H, V9.16B
    SQXTN  S16, D0
    UXTL2 V21.2D, V30.4S
    NEG  V28.2S, V0.2S
    FRINTN  V10.2D, V23.2D
    CLZ  V19.4H, V0.4H
    SXTL2 V9.2D, V30.4S
    SQNEG  D22, D0
    FRINTN  V5.2D, V26.2D
    FCVTXN  V23.2S, V6.2D
    SQXTUN2  V25.8H, V25.4S
    UQXTN  H29, S24
    URECPE  V6.4S, V0.4S
    RBIT  V17.16B, V9.16B
    SQXTN  H29, S26
    SUQADD  V2.8H, V14.8H
    SADDLP  V20.8H, V24.16B
    SQABS  D0, D23
    FCVTXN2  V20.4S, V9.2D
    NEG  D25, D2
    URECPE  V19.4S, V3.4S
    SXTL V31.2D, V2.2S
    SUQADD  D27, D30
    SQXTUN2  V8.8H, V11.4S
    SQXTN  H17, S22
    FRINTM  V8.4S, V5.4S
    CNT  V26.16B, V9.16B
    UQXTN2  V27.4S, V26.2D
    UQXTN  V31.4H, V31.4S
TaishanSimdFpIntConversionP01_label_1170:
    UXTL V20.2D, V17.2S
    SUBS  X26, X26, #0x1
    B.NE  TaishanSimdFpIntConversionP01_label_1233
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X24, X25, X2
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X12, X21, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X8, X24, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X11, X22, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X22, X12, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X8, X7, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X28, X15, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X15, X17, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X15, X10, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X11
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X17, X29, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X4, X5, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X19, X22, X16
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X7, X18, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X21, X22, X20
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X16, X27, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X27
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X9, X5, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, D2
    MOVZ  X26, #0xfefe, LSL #0
    MOVK  X26, #0x7fff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X11, X26, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X7
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, D3
    MOVZ  X20, #0x1, LSL #0
    SUB  X23, X20, X7
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X25, X20, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, D4
    MOVZ  X20, #0x102, LSL #0
    SUB  X25, X20, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X26, X12, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, D5
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xff80, LSL #48
    SUB  X26, X12, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X18, X26, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, D6
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X18, X26, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, V7.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, D7
    MOVZ  X5, #0x9d4f, LSL #0
    MOVK  X5, #0x1bd0, LSL #16
    SUB  X22, X5, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X10, X15, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, D8
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xff80, LSL #48
    SUB  X10, X15, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, D9
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X2, #0x0, LSL #0
TaishanSimdFpIntConversionP01_label_527:
    SUB  X20, X2, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, D10
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, V11.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, D11
    MOVZ  X8, #0x56, LSL #0
    SUB  X7, X8, X9
TaishanSimdFpIntConversionP01_label_1165:
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, V12.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X22, X10, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, D12
    MOVZ  X10, #0x0, LSL #0
    SUB  X22, X10, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, D14
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x8000, LSL #16
    SUB  X19, X23, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X8
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, D15
    MOVZ  X26, #0x55, LSL #0
    SUB  X23, X26, X8
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X18, D16
    MOVZ  X23, #0x102, LSL #0
    SUB  X19, X23, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, V17.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, D17
    MOVZ  X18, #0xfefe, LSL #0
    SUB  X15, X18, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X21, X26, X2
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, D18
    MOVZ  X26, #0x0, LSL #0
    SUB  X21, X26, X2
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X17, X26, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D19
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X17, X26, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X27, X8, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, D20
    MOVZ  X8, #0xfefe, LSL #0
    SUB  X27, X8, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, D21
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X18, V22.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X12, X24, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X18, D22
    MOVZ  X24, #0xfefe, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X12, X24, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, V23.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, D23
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, D24
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X10, X7, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X17, X27, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D25
    MOVZ  X27, #0x102, LSL #0
    MOVK  X27, #0x8000, LSL #16
    SUB  X17, X27, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, V26.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X24, X28, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, D26
    MOVZ  X28, #0x0, LSL #0
    SUB  X24, X28, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, D27
    MOVZ  X3, #0x51, LSL #0
    MOVK  X3, #0xefe0, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0x1f5f, LSL #48
    SUB  X14, X3, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, D28
    MOVZ  X26, #0xfefe, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X4, X26, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, D29
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X2, #0xd46c, LSL #0
    MOVK  X2, #0x1fab, LSL #16
    MOVK  X2, #0x3719, LSL #32
    MOVK  X2, #0xb915, LSL #48
    MOVZ  X3, #0xcc3b, LSL #0
    MOVK  X3, #0xd9c2, LSL #16
    MOVK  X3, #0xe5fb, LSL #32
    MOVK  X3, #0x22df, LSL #48
    MOVZ  X4, #0xd749, LSL #0
    MOVK  X4, #0x69f9, LSL #16
    MOVK  X4, #0x943c, LSL #32
    MOVK  X4, #0x7cb7, LSL #48
    MOVZ  X5, #0xbb1f, LSL #0
    MOVK  X5, #0x2e90, LSL #16
    MOVK  X5, #0x6114, LSL #32
    MOVK  X5, #0xd7b1, LSL #48
    MOVZ  X6, #0x1600, LSL #0
    MOVK  X6, #0xda4a, LSL #16
    MOVK  X6, #0xb113, LSL #32
    MOVK  X6, #0x9b28, LSL #48
    MOVZ  X7, #0xc52d, LSL #0
    MOVK  X7, #0x5fe8, LSL #16
    MOVK  X7, #0x8efd, LSL #32
    MOVK  X7, #0x45b8, LSL #48
    MOVZ  X8, #0xb5c2, LSL #0
    MOVK  X8, #0xdae4, LSL #16
    MOVK  X8, #0xc726, LSL #32
    MOVK  X8, #0x20b0, LSL #48
    MOVZ  X9, #0x9bf2, LSL #0
    MOVK  X9, #0x76e, LSL #16
    MOVK  X9, #0xc7d1, LSL #32
    MOVK  X9, #0x597, LSL #48
    MOVZ  X10, #0xc352, LSL #0
    MOVK  X10, #0x694a, LSL #16
    MOVK  X10, #0xc272, LSL #32
    MOVK  X10, #0x2967, LSL #48
    MOVZ  X11, #0x62b4, LSL #0
    MOVK  X11, #0xf663, LSL #16
    MOVK  X11, #0x13f9, LSL #32
    MOVK  X11, #0x331c, LSL #48
    MOVZ  X12, #0xb3fe, LSL #0
    MOVK  X12, #0x98de, LSL #16
    MOVK  X12, #0xc624, LSL #32
    MOVK  X12, #0xef5f, LSL #48
    MOVZ  X14, #0x8df5, LSL #0
    MOVK  X14, #0xc835, LSL #16
    MOVK  X14, #0x2fab, LSL #32
    MOVK  X14, #0x25cb, LSL #48
    MOVZ  X15, #0xdd02, LSL #0
    MOVK  X15, #0xc486, LSL #16
    MOVK  X15, #0xb362, LSL #32
    MOVK  X15, #0x5e4d, LSL #48
    MOVZ  X16, #0xbfd1, LSL #0
    MOVK  X16, #0x4cf7, LSL #16
    MOVK  X16, #0xbe3d, LSL #32
    MOVK  X16, #0xa08e, LSL #48
    MOVZ  X17, #0x1cfa, LSL #0
    MOVK  X17, #0x7ec0, LSL #16
    MOVK  X17, #0xbbc6, LSL #32
    MOVK  X17, #0xace5, LSL #48
TaishanSimdFpIntConversionP01_label_822:
    MOVZ  X18, #0x3ee6, LSL #0
    MOVK  X18, #0x67e9, LSL #16
    MOVK  X18, #0xb45c, LSL #32
    MOVK  X18, #0x268d, LSL #48
    MOVZ  X19, #0xdfc1, LSL #0
    MOVK  X19, #0xbf9b, LSL #16
    MOVK  X19, #0x7165, LSL #32
    MOVK  X19, #0xf10c, LSL #48
    MOVZ  X20, #0x8537, LSL #0
    MOVK  X20, #0xa3, LSL #16
    MOVK  X20, #0xa6dc, LSL #32
    MOVK  X20, #0xc246, LSL #48
    MOVZ  X21, #0x151b, LSL #0
    MOVK  X21, #0xdc51, LSL #16
    MOVK  X21, #0x8cbe, LSL #32
    MOVK  X21, #0x6a80, LSL #48
    MOVZ  X22, #0x4aef, LSL #0
    MOVK  X22, #0xb4fe, LSL #16
    MOVK  X22, #0xb7a8, LSL #32
    MOVK  X22, #0xe696, LSL #48
    MOVZ  X23, #0x774c, LSL #0
    MOVK  X23, #0xc5e2, LSL #16
    MOVK  X23, #0x366b, LSL #32
    MOVK  X23, #0x7695, LSL #48
    MOVZ  X24, #0xc3ec, LSL #0
    MOVK  X24, #0x93e0, LSL #16
    MOVK  X24, #0x1488, LSL #32
    MOVK  X24, #0xa2b1, LSL #48
    MOVZ  X25, #0x96af, LSL #0
    MOVK  X25, #0x7a0a, LSL #16
    MOVK  X25, #0x5b26, LSL #32
    MOVK  X25, #0x4ea9, LSL #48
    MOVZ  X26, #0x3eec, LSL #0
    MOVK  X26, #0xb2e0, LSL #16
    MOVK  X26, #0xee9, LSL #32
    MOVK  X26, #0x638c, LSL #48
    MOVZ  X27, #0xc22c, LSL #0
    MOVK  X27, #0x6cb4, LSL #16
    MOVK  X27, #0xa9df, LSL #32
    MOVK  X27, #0xd20e, LSL #48
    MOVZ  X28, #0xf34d, LSL #0
    MOVK  X28, #0x3e16, LSL #16
    MOVK  X28, #0x5dcd, LSL #32
    MOVK  X28, #0x15f, LSL #48
    MOVZ  X29, #0xa316, LSL #0
    MOVK  X29, #0x963e, LSL #16
    MOVK  X29, #0x5426, LSL #32
    MOVK  X29, #0x126, LSL #48
    FMOV  D0, X10
    FMOV  V0.D[1], X26
    FMOV  D1, X29
    FMOV  V1.D[1], X12
    FMOV  D2, X25
    FMOV  V2.D[1], X18
    FMOV  D3, X4
    FMOV  V3.D[1], X28
    FMOV  D4, X24
    FMOV  V4.D[1], X19
    FMOV  D5, X5
    FMOV  V5.D[1], X11
    FMOV  D6, X6
    FMOV  V6.D[1], X8
    FMOV  D7, X4
    FMOV  V7.D[1], X22
    FMOV  D8, X4
    FMOV  V8.D[1], X9
    FMOV  D9, X24
    FMOV  V9.D[1], X24
    FMOV  D10, X3
    FMOV  V10.D[1], X20
    FMOV  D11, X20
    FMOV  V11.D[1], X18
    FMOV  D12, X5
    FMOV  V12.D[1], X9
    FMOV  D13, X16
    FMOV  V13.D[1], X27
    FMOV  D14, X3
    FMOV  V14.D[1], X2
    FMOV  D15, X11
    FMOV  V15.D[1], X19
    FMOV  D16, X23
    FMOV  V16.D[1], X16
    FMOV  D17, X14
    FMOV  V17.D[1], X22
    FMOV  D18, X9
    FMOV  V18.D[1], X24
    FMOV  D19, X23
    FMOV  V19.D[1], X19
    FMOV  D20, X16
    FMOV  V20.D[1], X20
    FMOV  D21, X10
    FMOV  V21.D[1], X18
    FMOV  D22, X11
    FMOV  V22.D[1], X22
    FMOV  D23, X8
    FMOV  V23.D[1], X14
    FMOV  D24, X7
    FMOV  V24.D[1], X3
    FMOV  D25, X10
    FMOV  V25.D[1], X2
    FMOV  D26, X6
    FMOV  V26.D[1], X4
    FMOV  D27, X15
    FMOV  V27.D[1], X8
    FMOV  D28, X15
    FMOV  V28.D[1], X6
    FMOV  D29, X3
    FMOV  V29.D[1], X3
    FMOV  D30, X22
    FMOV  V30.D[1], X7
    FMOV  D31, X29
    FMOV  V31.D[1], X20
    MOVZ  X22, #0xa, LSL #0
TaishanSimdFpIntConversionP01_label_1303:
    SQXTUN  V31.8B, V21.8H
    SQABS  V13.8H, V25.8H
    SQXTN2  V25.8H, V29.4S
    SXTL2 V1.2D, V28.4S
    FRSQRTE  S27, S24
    REV16  V22.8B, V2.8B
    FRECPS  D12, D13, D22
    USQADD  D19, D26
    SQABS  H5, H15
    SQNEG  V28.4H, V21.4H
    SQABS  S5, S30
    UXTL2 V25.8H, V7.16B
    FRECPX  S23, S24
    SUQADD  D23, D20
    ABS  D24, D22
    FRINTI  V0.2S, V23.2S
    SQXTN  V10.2S, V20.2D
    USQADD  D18, D26
    FSQRT  V15.2S, V31.2S
    SADDLP  V27.2D, V18.4S
TaishanSimdFpIntConversionP01_label_1238:
    USQADD  B8, B25
    UXTL V10.2D, V1.2S
    FCVTXN  S19, D26
    USQADD  D2, D8
    ABS  D26, D15
    ABS  D17, D21
    USQADD  V17.4H, V22.4H
    UXTL V11.8H, V6.8B
    USQADD  V10.4H, V19.4H
    UXTL V21.4S, V11.4H
    FRINTM  V12.4S, V4.4S
    SQNEG  S21, S16
    FRINTM  V3.4S, V6.4S
    SQXTUN2  V15.4S, V29.2D
    FCVTXN2  V29.4S, V2.2D
    SQXTUN2  V9.8H, V0.4S
    UADDLP  V18.8H, V2.16B
    SADDLP  V19.8H, V6.16B
    SUQADD  S25, S7
    SQXTUN  V6.4H, V5.4S
    SQNEG  B16, B14
    USQADD  V17.16B, V17.16B
    URECPE  V28.4S, V11.4S
    SQXTN  S2, D24
    SQXTN  S10, D16
    UQXTN  V3.4H, V12.4S
    SQNEG  B26, B24
    URSQRTE  V3.2S, V29.2S
    UXTL V4.2D, V1.2S
    SXTL2 V8.4S, V27.8H
    USQADD  B2, B12
    SUQADD  B8, B18
    USQADD  V20.2S, V20.2S
    SXTL2 V10.4S, V9.8H
    SADALP  V0.8H, V11.16B
    UQXTN  S5, D17
    SQABS  D10, D26
    FRINTN  V21.2D, V9.2D
    UQXTN2  V20.8H, V15.4S
    SQABS  B6, B16
    SADDLP  V4.1D, V14.2S
    UQXTN  S0, D4
    FNEG  V5.2D, V12.2D
    UQXTN  H11, S7
    USQADD  D0, D8
    REV16  V25.16B, V22.16B
    ABS  V7.8H, V17.8H
    USQADD  D29, D17
    SXTL V9.4S, V30.4H
    SQXTN2  V5.4S, V2.2D
    UXTL2 V28.4S, V6.8H
    SQXTUN  H12, S4
    FRECPS  D19, D17, D20
    FRECPS  D14, D26, D29
    SXTL2 V15.2D, V25.4S
    SUQADD  H10, H23
    FRINTX  V17.2S, V25.2S
    XTN2  V20.8H, V11.4S
    SUQADD  H28, H2
    SXTL V5.4S, V11.4H
    FRINTX  V24.2S, V11.2S
    SQABS  B10, B24
    SUQADD  D30, D12
    SQNEG  D27, D28
    FABS  V15.2D, V15.2D
    SQXTUN  H4, S27
    UXTL V6.4S, V4.4H
    SQXTUN  S6, D6
    FRINTX  V21.4S, V17.4S
    FRINTI  V27.2S, V3.2S
    FRINTN  V19.2S, V7.2S
    UXTL V19.4S, V25.4H
    SQXTUN2  V21.16B, V4.8H
    USQADD  B2, B9
    FRECPX  D31, D22
    UQXTN  S16, D27
    SADDLP  V17.8H, V8.16B
    SUQADD  B16, B5
    UQXTN  V2.4H, V26.4S
    ABS  D11, D22
    MVN  V25.16B, V11.16B
    FRECPS  V9.2D, V21.2D, V31.2D
    XTN  V0.2S, V9.2D
    XTN2  V15.16B, V17.8H
    FRECPS  D30, D14, D19
    FCVTXN2  V26.4S, V3.2D
    REV16  V30.8B, V31.8B
    SQXTUN  H31, S0
    ABS  V17.8B, V23.8B
    SUQADD  H6, H18
    XTN  V12.4H, V19.4S
    SQXTN  H24, S11
    NEG  V15.2S, V31.2S
    SQNEG  B16, B25
    UQXTN  V11.2S, V14.2D
    SQXTN  S22, D7
    FABS  V26.2S, V27.2S
    REV16  V17.16B, V19.16B
    USQADD  D27, D8
    FRINTA  V31.4S, V18.4S
    SQXTUN  H20, S30
    FRINTN  V17.2D, V2.2D
    FRINTI  V20.2D, V11.2D
    URSQRTE  V16.4S, V2.4S
    FRECPX  S1, S15
    SXTL V14.2D, V30.2S
    USQADD  D5, D24
    REV32  V11.8B, V18.8B
    CNT  V23.16B, V7.16B
    UQXTN  V17.2S, V6.2D
    UXTL V6.4S, V21.4H
    SQABS  D12, D27
    UXTL V28.2D, V1.2S
    XTN2  V10.4S, V26.2D
    USQADD  B26, B5
    USQADD  B18, B6
    FRSQRTE  S5, S11
    SQABS  V10.2D, V31.2D
    UXTL V10.8H, V9.8B
    UQXTN  B13, H8
    FRINTM  V6.2S, V12.2S
    SADALP  V5.4H, V23.8B
    SXTL2 V21.8H, V17.16B
    FRINTX  V28.4S, V1.4S
    FRECPS  V18.2D, V3.2D, V23.2D
    UXTL2 V24.8H, V18.16B
    URSQRTE  V4.4S, V24.4S
    SUQADD  D24, D24
    UQXTN  H20, S26
    FRECPS  S12, S6, S26
    RBIT  V11.8B, V11.8B
    SQNEG  B25, B26
    USQADD  S12, S4
    UXTL2 V10.2D, V20.4S
    UXTL V22.8H, V17.8B
    UADDLP  V13.4S, V13.8H
    SQXTN  B4, H21
    SQNEG  S30, S27
    UQXTN  B23, H29
    NEG  V23.2D, V8.2D
    FRINTZ  V17.4S, V31.4S
    SADALP  V10.4S, V13.8H
    SQABS  V30.4S, V0.4S
    URSQRTE  V27.2S, V12.2S
    FSQRT  V6.2D, V14.2D
    FRECPS  V10.2D, V0.2D, V25.2D
    FCVTXN  V30.2S, V12.2D
    FRECPX  D9, D26
    SXTL2 V15.4S, V12.8H
    SQXTUN  B27, H18
    NOT  V30.8B, V16.8B
    SUQADD  S21, S15
    FCVTXN  S20, D18
    SQNEG  S25, S5
    SXTL V27.8H, V24.8B
    UXTL2 V31.2D, V8.4S
    UADALP  V27.8H, V2.16B
    CLS  V9.8H, V7.8H
    XTN2  V26.8H, V25.4S
    FCVTXN  S18, D21
    SQNEG  H30, H3
    SUQADD  B20, B20
    SQXTN2  V1.4S, V24.2D
    UQXTN  H19, S6
    UQXTN2  V28.16B, V10.8H
    CLZ  V16.4H, V25.4H
    FSQRT  V12.2S, V26.2S
    UXTL V8.2D, V0.2S
    SUQADD  H7, H28
    SXTL V0.2D, V2.2S
    FRINTP  V17.2S, V14.2S
    UADALP  V28.4S, V18.8H
    MVN  V19.8B, V7.8B
    SQXTUN  H1, S21
    REV32  V12.8H, V13.8H
    NOT  V2.16B, V26.16B
    SQXTUN  B2, H30
    SXTL V2.8H, V2.8B
    REV32  V9.4H, V20.4H
    MVN  V17.8B, V0.8B
    SUBS  X22, X22, #0x1
    B.NE  TaishanSimdFpIntConversionP01_label_1303
    MOVZ  X20, #0xd46c, LSL #0
    MOVK  X20, #0x1fab, LSL #16
    MOVK  X20, #0x3719, LSL #32
    MOVK  X20, #0xb915, LSL #48
    SUB  X12, X20, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X16, #0xcc3b, LSL #0
    MOVK  X16, #0xd9c2, LSL #16
    MOVK  X16, #0xe5fb, LSL #32
    MOVK  X16, #0x22df, LSL #48
    SUB  X20, X16, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X15, #0xd749, LSL #0
    MOVK  X15, #0x69f9, LSL #16
    MOVK  X15, #0x943c, LSL #32
    MOVK  X15, #0x7cb7, LSL #48
    SUB  X6, X15, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X28, #0xbb1f, LSL #0
    MOVK  X28, #0x2e90, LSL #16
    MOVK  X28, #0x6114, LSL #32
    MOVK  X28, #0xd7b1, LSL #48
    SUB  X23, X28, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X22, #0xc52d, LSL #0
    MOVK  X22, #0x5fe8, LSL #16
    MOVK  X22, #0x8efd, LSL #32
    MOVK  X22, #0x45b8, LSL #48
    SUB  X16, X22, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X8
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X12, #0x9bf2, LSL #0
    MOVK  X12, #0x76e, LSL #16
    MOVK  X12, #0xc7d1, LSL #32
    MOVK  X12, #0x597, LSL #48
    SUB  X14, X12, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X20, #0xc352, LSL #0
    MOVK  X20, #0x694a, LSL #16
    MOVK  X20, #0xc272, LSL #32
    MOVK  X20, #0x2967, LSL #48
    SUB  X7, X20, X10
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X5, #0x62b4, LSL #0
    MOVK  X5, #0xf663, LSL #16
    MOVK  X5, #0x13f9, LSL #32
    MOVK  X5, #0x331c, LSL #48
    SUB  X7, X5, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0x9bf2, LSL #0
    MOVK  X4, #0x76e, LSL #16
    MOVK  X4, #0xc7d1, LSL #32
    MOVK  X4, #0x597, LSL #48
    SUB  X2, X4, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X16, #0xd749, LSL #0
    MOVK  X16, #0x69f9, LSL #16
    MOVK  X16, #0x943c, LSL #32
    MOVK  X16, #0x7cb7, LSL #48
    SUB  X21, X16, X15
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X22, #0xd749, LSL #0
    MOVK  X22, #0x69f9, LSL #16
    MOVK  X22, #0x943c, LSL #32
    MOVK  X22, #0x7cb7, LSL #48
    SUB  X8, X22, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0x1cfa, LSL #0
    MOVK  X4, #0x7ec0, LSL #16
    MOVK  X4, #0xbbc6, LSL #32
    MOVK  X4, #0xace5, LSL #48
    SUB  X22, X4, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X29, #0xdfc1, LSL #0
    MOVK  X29, #0xbf9b, LSL #16
    MOVK  X29, #0x7165, LSL #32
    MOVK  X29, #0xf10c, LSL #48
    SUB  X17, X29, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X16, #0xc352, LSL #0
    MOVK  X16, #0x694a, LSL #16
    MOVK  X16, #0xc272, LSL #32
    MOVK  X16, #0x2967, LSL #48
    SUB  X14, X16, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X22, X10, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X6, X8, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X3, X16, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X22, #0x96af, LSL #0
    MOVK  X22, #0x7a0a, LSL #16
    MOVK  X22, #0x5b26, LSL #32
    MOVK  X22, #0x4ea9, LSL #48
    SUB  X3, X22, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X23, #0x3eec, LSL #0
    MOVK  X23, #0xb2e0, LSL #16
    MOVK  X23, #0xee9, LSL #32
    MOVK  X23, #0x638c, LSL #48
    SUB  X24, X23, X26
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X18, #0xc22c, LSL #0
    MOVK  X18, #0x6cb4, LSL #16
    MOVK  X18, #0xa9df, LSL #32
    MOVK  X18, #0xd20e, LSL #48
    SUB  X4, X18, X27
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X17, #0xbb1f, LSL #0
    MOVK  X17, #0x2e90, LSL #16
    MOVK  X17, #0x6114, LSL #32
    MOVK  X17, #0xd7b1, LSL #48
    SUB  X11, X17, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X3, #0xdfc1, LSL #0
    MOVK  X3, #0xbf9b, LSL #16
    MOVK  X3, #0x7165, LSL #32
    MOVK  X3, #0xf10c, LSL #48
    SUB  X15, X3, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, V2.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X10, X19, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, D2
    MOVZ  X19, #0x0, LSL #0
    SUB  X10, X19, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X23, X27, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, D3
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x9380, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X23, X27, X11
TaishanSimdFpIntConversionP01_label_864:
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X11, D4
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, V5.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X4
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, D5
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7f80, LSL #16
    SUB  X28, X10, X4
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, V6.D[1]
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xe07f, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X22, X17, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, D6
    MOVZ  X17, #0x0, LSL #0
    SUB  X22, X17, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, V7.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, D7
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, V8.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X28, X7, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, D8
    MOVZ  X7, #0x0, LSL #0
    SUB  X28, X7, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, V9.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X2, X15, X25
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, D9
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7f, LSL #16
    SUB  X2, X15, X25
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x4000, LSL #48
    SUB  X11, X25, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, D10
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x4000, LSL #48
    SUB  X11, X25, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, D11
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, D12
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xe07f, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X27, X29, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, D14
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, V15.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, D15
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, V16.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, D16
    MOVZ  X12, #0x10, LSL #0
    MOVK  X12, #0x10, LSL #32
    MOVK  X12, #0x10, LSL #48
    SUB  X20, X12, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, D17
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X28, X5, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, D18
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, V19.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X14, X28, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, D19
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X14, X28, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, V20.D[1]
TaishanSimdFpIntConversionP01_label_449:
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, D20
    MOVZ  X29, #0x7f, LSL #0
    SUB  X17, X29, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V21.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D21
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, V22.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X24
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, D22
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X24
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, D23
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, D24
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, V25.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, D25
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x8080, LSL #16
    SUB  X28, X2, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, V26.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X17, X20, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, D26
    MOVZ  X20, #0x0, LSL #0
    SUB  X17, X20, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, D27
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xff00, LSL #16
    MOVK  X21, #0xff00, LSL #48
    SUB  X12, X21, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X3, D28
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7f00, LSL #16
    SUB  X12, X21, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, V29.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, D29
    MOVZ  X27, #0xb10b, LSL #0
    MOVK  X27, #0xc04b, LSL #16
    MOVK  X27, #0xb696, LSL #32
    MOVK  X27, #0x22e0, LSL #48
    SUB  X8, X27, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
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
    FMOV  D0, X16
    FMOV  V0.D[1], X24
    FMOV  D1, X25
    FMOV  V1.D[1], X9
    FMOV  D2, X24
    FMOV  V2.D[1], X12
    FMOV  D3, X26
    FMOV  V3.D[1], X11
    FMOV  D4, X2
    FMOV  V4.D[1], X12
    FMOV  D5, X21
    FMOV  V5.D[1], X8
    FMOV  D6, X14
    FMOV  V6.D[1], X12
    FMOV  D7, X25
    FMOV  V7.D[1], X26
    FMOV  D8, X23
    FMOV  V8.D[1], X20
    FMOV  D9, X19
    FMOV  V9.D[1], X28
    FMOV  D10, X17
    FMOV  V10.D[1], X8
    FMOV  D11, X27
    FMOV  V11.D[1], X7
    FMOV  D12, X29
    FMOV  V12.D[1], X27
    FMOV  D13, X22
    FMOV  V13.D[1], X11
    FMOV  D14, X5
    FMOV  V14.D[1], X11
    FMOV  D15, X22
    FMOV  V15.D[1], X20
    FMOV  D16, X27
    FMOV  V16.D[1], X3
    FMOV  D17, X5
    FMOV  V17.D[1], X7
    FMOV  D18, X4
    FMOV  V18.D[1], X18
    FMOV  D19, X7
    FMOV  V19.D[1], X14
    FMOV  D20, X14
    FMOV  V20.D[1], X26
    FMOV  D21, X23
    FMOV  V21.D[1], X21
    FMOV  D22, X16
    FMOV  V22.D[1], X16
    FMOV  D23, X6
    FMOV  V23.D[1], X20
    FMOV  D24, X23
    FMOV  V24.D[1], X21
    FMOV  D25, X5
    FMOV  V25.D[1], X16
    FMOV  D26, X29
    FMOV  V26.D[1], X23
    FMOV  D27, X21
    FMOV  V27.D[1], X15
    FMOV  D28, X24
    FMOV  V28.D[1], X5
    FMOV  D29, X26
    FMOV  V29.D[1], X5
    FMOV  D30, X7
    FMOV  V30.D[1], X8
    FMOV  D31, X23
    FMOV  V31.D[1], X18
    MOVZ  X23, #0xa, LSL #0
TaishanSimdFpIntConversionP01_label_1371:
    SADALP  V19.2D, V18.4S
    SXTL2 V29.8H, V17.16B
    USQADD  H3, H1
    FRINTZ  V3.4S, V19.4S
    SUQADD  D24, D28
    FRINTI  V9.4S, V25.4S
    UQXTN  B13, H30
    UXTL V10.4S, V22.4H
    SXTL V31.8H, V17.8B
    SUQADD  H5, H12
    SQABS  S27, S16
    SQXTN2  V18.16B, V14.8H
    SADDLP  V5.4H, V25.8B
    UXTL2 V10.4S, V22.8H
    FSQRT  V18.2D, V8.2D
    NOT  V10.16B, V31.16B
    SADALP  V1.8H, V30.16B
    NEG  D28, D17
    SXTL V2.8H, V29.8B
    FCVTXN  V15.2S, V2.2D
    SQXTUN  S11, D13
    SXTL2 V29.8H, V21.16B
    UXTL V11.8H, V16.8B
    FNEG  V0.4S, V18.4S
    UQXTN  S0, D9
    FCVTXN  S27, D17
    SQNEG  V13.8H, V24.8H
    SUQADD  V10.2S, V24.2S
    UXTL V28.4S, V2.4H
    SQXTUN  B10, H9
    FRINTZ  V21.2D, V2.2D
    FRINTA  V15.2D, V19.2D
    SADALP  V4.4H, V27.8B
    FRINTX  V29.2S, V5.2S
    SUQADD  H12, H1
    CLS  V29.4S, V11.4S
    FRINTX  V22.4S, V28.4S
    URSQRTE  V0.2S, V25.2S
    ABS  D27, D26
    USQADD  B12, B8
    UXTL V3.8H, V18.8B
    UXTL V13.4S, V17.4H
    UXTL2 V8.8H, V24.16B
    FRECPX  D26, D31
    NOT  V3.8B, V3.8B
    SQABS  B24, B20
    FNEG  V3.4S, V5.4S
    XTN  V0.4H, V8.4S
    FRINTA  V10.2S, V14.2S
    SQABS  S13, S22
    FRINTM  V13.4S, V24.4S
    SUQADD  B12, B0
    REV32  V2.8B, V11.8B
    URECPE  V11.4S, V26.4S
    XTN  V8.4H, V4.4S
    SQXTN  V22.2S, V15.2D
    FRECPS  V3.4S, V2.4S, V20.4S
    SQXTUN  H30, S23
    SQABS  B1, B13
    XTN  V10.8B, V10.8H
    FRSQRTE  D11, D23
    FNEG  V3.4S, V4.4S
    UXTL2 V3.2D, V17.4S
    UXTL V27.4S, V7.4H
    CNT  V28.16B, V26.16B
    SQNEG  V23.4S, V13.4S
    FRECPS  S8, S4, S16
    FABS  V22.2D, V16.2D
    URSQRTE  V25.2S, V1.2S
    SUQADD  D13, D11
    SQXTN  V27.4H, V1.4S
    SQXTUN  V12.2S, V0.2D
    UADALP  V18.2S, V16.4H
    SXTL2 V19.8H, V18.16B
    SXTL V28.4S, V3.4H
    UXTL2 V18.2D, V13.4S
    FRECPS  S4, S22, S27
    USQADD  B4, B23
    SQXTN  S21, D7
    USQADD  H17, H25
    NOT  V17.16B, V24.16B
    REV32  V6.4H, V26.4H
    REV16  V26.8B, V16.8B
    FABS  V10.2D, V20.2D
    SADALP  V4.2D, V31.4S
    XTN2  V12.16B, V31.8H
    SUQADD  V14.16B, V11.16B
    FRSQRTE  S31, S15
    SXTL V27.2D, V19.2S
    UADALP  V7.4S, V19.8H
    FRINTM  V12.4S, V11.4S
    ABS  D16, D15
    SQXTUN2  V20.8H, V28.4S
    FRINTA  V25.4S, V4.4S
    NEG  D25, D15
    UQXTN2  V5.8H, V13.4S
    FRSQRTE  S19, S6
    SQABS  D6, D22
    FRSQRTE  S15, S12
    USQADD  V10.8B, V17.8B
    SXTL2 V8.8H, V14.16B
    XTN2  V8.16B, V16.8H
    SUQADD  S19, S13
    USQADD  B20, B11
    CLZ  V20.2S, V28.2S
    USQADD  V10.4H, V9.4H
    ABS  V8.4H, V6.4H
    FABS  V31.4S, V16.4S
    SQNEG  V14.4S, V10.4S
    FRINTI  V22.2D, V0.2D
    UQXTN2  V20.8H, V13.4S
    UXTL V0.4S, V22.4H
    FABS  V26.2D, V10.2D
    SQXTN  B22, H21
    NEG  D15, D10
    URECPE  V21.4S, V21.4S
    SQXTUN  B27, H21
    SXTL2 V20.2D, V19.4S
    SQXTN  H10, S8
    UQXTN2  V14.4S, V26.2D
    REV64  V24.8B, V5.8B
    FRSQRTE  S30, S13
    FRECPX  D31, D9
    SUQADD  H4, H19
    FRSQRTE  S10, S26
    FRINTZ  V31.2S, V7.2S
    USQADD  H6, H10
    FRINTM  V6.2S, V13.2S
    USQADD  D17, D18
    UXTL2 V8.4S, V11.8H
    FRECPX  D27, D24
    FRINTM  V3.2D, V21.2D
    USQADD  S14, S13
    XTN  V11.2S, V21.2D
    FNEG  V5.2D, V3.2D
    FNEG  V9.4S, V22.4S
    SUQADD  D28, D17
    SQXTUN  H31, S19
    FRSQRTE  D24, D2
    CLZ  V14.4H, V2.4H
    UXTL V14.4S, V4.4H
    FCVTXN  V10.2S, V31.2D
    SQNEG  S2, S10
    SXTL2 V7.2D, V18.4S
    SQXTUN2  V11.16B, V31.8H
    SUQADD  H31, H14
    UADALP  V11.1D, V6.2S
    FRECPX  S27, S13
    MVN  V12.16B, V31.16B
    UXTL2 V8.2D, V9.4S
    FRECPS  V6.2S, V31.2S, V28.2S
    SQXTUN  B5, H10
    FRSQRTE  V16.4S, V13.4S
    UQXTN  H2, S25
    SUQADD  H11, H3
    SQXTN  S17, D15
    USQADD  D29, D13
    UQXTN  V0.4H, V28.4S
    MVN  V17.16B, V18.16B
    FCVTXN  S19, D24
    SQABS  D9, D19
    SQXTN  V24.4H, V3.4S
    UQXTN  H0, S28
    FCVTXN  V0.2S, V10.2D
    USQADD  D31, D15
    SQXTUN2  V7.4S, V25.2D
    SQXTUN2  V19.16B, V31.8H
    NOT  V24.8B, V2.8B
    FRINTA  V13.2S, V15.2S
    SQNEG  V29.4S, V21.4S
    SQXTUN  S25, D16
    SUQADD  V0.8B, V17.8B
    SXTL2 V0.4S, V14.8H
    FRINTP  V29.2S, V11.2S
    SXTL2 V24.8H, V24.16B
    UQXTN  S10, D14
    UXTL V25.2D, V18.2S
    ABS  D3, D15
    NEG  D10, D31
    FRINTI  V10.2S, V13.2S
    SQXTUN2  V25.16B, V17.8H
    FRSQRTE  D27, D12
    NEG  V29.2S, V13.2S
    MVN  V18.16B, V9.16B
    FRINTI  V15.4S, V0.4S
    USQADD  B19, B18
    UQXTN  H13, S14
    USQADD  B16, B19
    USQADD  H10, H10
    SQXTN  S7, D1
    SQNEG  D29, D29
    UXTL2 V17.4S, V9.8H
    FCVTXN  S2, D1
    URECPE  V11.4S, V11.4S
    NEG  V6.8B, V13.8B
    UQXTN2  V9.4S, V13.2D
    ABS  D20, D25
    UXTL V13.8H, V2.8B
    FCVTXN2  V5.4S, V6.2D
    SQNEG  D23, D25
    SUBS  X23, X23, #0x1
    B.NE  TaishanSimdFpIntConversionP01_label_1371
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X4
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X6, X20, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X17, X18, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X10, X19, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X14
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X19, X11, X15
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X20, X4, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X5, X16, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X24, X8, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X26, X16, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, D2
    MOVZ  X16, #0x0, LSL #0
    SUB  X26, X16, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X14
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X14, D3
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X14
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, V4.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, D4
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, D5
    MOVZ  X7, #0x1, LSL #0
    SUB  X17, X7, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X12, X19, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X20, D6
    MOVZ  X19, #0x0, LSL #0
    SUB  X12, X19, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, V7.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, D7
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, V8.D[1]
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x8000, LSL #16
    SUB  X25, X26, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, D8
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x8000, LSL #16
    SUB  X25, X26, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, V9.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X27, X17, X19
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, D9
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x7f80, LSL #16
    SUB  X27, X17, X19
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, D10
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, V11.D[1]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X20, X2, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, D11
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X20, X2, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X20, X27, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, D12
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X20, X27, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, D14
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X14, X11, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, D15
    MOVZ  X11, #0x0, LSL #0
    SUB  X14, X11, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, D16
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X16, D17
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, V18.D[1]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X25, X11, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, D18
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0x807f, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X25, X11, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, V19.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, D19
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, D20
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X10, D21
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X20, X4, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X12, D22
    MOVZ  X4, #0x0, LSL #0
    SUB  X20, X4, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, V23.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X22
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, D23
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X22
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, D24
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, D25
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X9, D26
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, V27.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, D27
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X28, X21, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, D28
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0x7fff, LSL #48
    SUB  X17, X3, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, V29.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X5, X26, X22
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, D29
    MOVZ  X26, #0x0, LSL #0
    SUB  X5, X26, X22
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
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
    FMOV  D0, X6
    FMOV  V0.D[1], X15
    FMOV  D1, X6
    FMOV  V1.D[1], X4
    FMOV  D2, X11
    FMOV  V2.D[1], X2
    FMOV  D3, X29
    FMOV  V3.D[1], X23
    FMOV  D4, X20
    FMOV  V4.D[1], X22
    FMOV  D5, X21
    FMOV  V5.D[1], X21
    FMOV  D6, X29
    FMOV  V6.D[1], X6
    FMOV  D7, X26
    FMOV  V7.D[1], X17
    FMOV  D8, X4
    FMOV  V8.D[1], X5
    FMOV  D9, X24
    FMOV  V9.D[1], X7
    FMOV  D10, X12
    FMOV  V10.D[1], X18
    FMOV  D11, X5
    FMOV  V11.D[1], X18
    FMOV  D12, X27
    FMOV  V12.D[1], X10
    FMOV  D13, X12
    FMOV  V13.D[1], X22
    FMOV  D14, X15
    FMOV  V14.D[1], X10
    FMOV  D15, X3
    FMOV  V15.D[1], X14
    FMOV  D16, X22
    FMOV  V16.D[1], X3
    FMOV  D17, X21
    FMOV  V17.D[1], X7
    FMOV  D18, X21
    FMOV  V18.D[1], X2
    FMOV  D19, X3
    FMOV  V19.D[1], X20
    FMOV  D20, X8
    FMOV  V20.D[1], X17
    FMOV  D21, X18
    FMOV  V21.D[1], X2
    FMOV  D22, X5
    FMOV  V22.D[1], X18
    FMOV  D23, X27
    FMOV  V23.D[1], X11
    FMOV  D24, X2
    FMOV  V24.D[1], X22
    FMOV  D25, X12
    FMOV  V25.D[1], X8
    FMOV  D26, X7
    FMOV  V26.D[1], X24
    FMOV  D27, X14
    FMOV  V27.D[1], X26
    FMOV  D28, X14
    FMOV  V28.D[1], X11
    FMOV  D29, X3
    FMOV  V29.D[1], X14
    FMOV  D30, X11
    FMOV  V30.D[1], X16
    FMOV  D31, X27
    FMOV  V31.D[1], X16
    MOVZ  X8, #0xf, LSL #0
TaishanSimdFpIntConversionP01_label_1439:
    URSQRTE  V23.4S, V24.4S
    FRINTA  V8.2D, V31.2D
    SXTL V26.2D, V16.2S
    UXTL2 V5.2D, V23.4S
    SXTL2 V20.2D, V5.4S
    SUQADD  D15, D2
    FRINTP  V17.2S, V28.2S
    MVN  V31.16B, V10.16B
    FRECPX  D15, D31
    SQNEG  S30, S8
    FCVTXN  S11, D20
    FRECPS  D9, D13, D22
    UXTL2 V18.2D, V27.4S
    SQABS  D17, D16
    UXTL V1.4S, V7.4H
    UXTL2 V13.2D, V3.4S
    SUQADD  S22, S23
    FRINTP  V19.2S, V6.2S
    UQXTN  H13, S10
    FRECPX  S11, S30
    UQXTN2  V30.16B, V24.8H
    NEG  D23, D25
    SQXTN  H11, S19
    UXTL V7.4S, V25.4H
    FRECPS  S4, S19, S27
    FRECPX  D2, D19
    UADDLP  V26.2S, V20.4H
    UQXTN  B4, H18
    FRECPX  D20, D11
    NEG  V17.4H, V3.4H
    FRECPS  D26, D11, D16
    SXTL V16.2D, V26.2S
    SXTL2 V16.8H, V6.16B
    SUQADD  H26, H15
    FRINTM  V22.2S, V22.2S
    FRECPS  D13, D28, D5
    SQXTN  V21.8B, V14.8H
    FRINTM  V15.2S, V21.2S
    NEG  D0, D7
    FRSQRTE  D30, D19
    NOT  V29.16B, V26.16B
    FRECPX  D23, D23
    FRINTI  V1.2D, V13.2D
    SUQADD  S0, S6
    UXTL2 V18.4S, V7.8H
    SQXTN  V25.2S, V11.2D
    FRINTP  V16.2S, V2.2S
    UQXTN  S30, D4
    XTN2  V2.4S, V18.2D
    USQADD  H4, H29
    SQXTN  B14, H14
    UXTL2 V23.4S, V14.8H
    SQXTN  H11, S21
    SQXTN  S1, D17
    SQXTUN  H3, S3
    SXTL2 V3.4S, V20.8H
    USQADD  D30, D8
    UQXTN  H12, S0
    UQXTN  H21, S13
    SQABS  S3, S17
    SXTL V7.8H, V12.8B
    SQABS  S28, S25
    SXTL2 V11.8H, V28.16B
    SQXTN2  V28.4S, V6.2D
    UXTL2 V16.2D, V12.4S
    UQXTN  S17, D2
    SQNEG  D23, D20
    SQXTN2  V16.4S, V27.2D
    CLZ  V15.8B, V7.8B
    FRECPS  D7, D8, D18
    SQABS  S17, S14
    SXTL V20.8H, V23.8B
    FABS  V24.2S, V23.2S
    UXTL V23.4S, V25.4H
    SQXTUN  V11.4H, V25.4S
    SUQADD  B29, B17
    UQXTN  S9, D3
    UXTL2 V3.8H, V9.16B
    SUQADD  V29.16B, V15.16B
    RBIT  V28.8B, V1.8B
    USQADD  B23, B5
    FRINTM  V10.2D, V12.2D
    UXTL2 V0.2D, V2.4S
    UQXTN  S10, D0
    UQXTN  H13, S25
    REV32  V6.8H, V29.8H
    CNT  V0.8B, V8.8B
    SQABS  S28, S14
    FABS  V20.2D, V10.2D
    NEG  V0.16B, V23.16B
    SQXTN  B16, H15
    URECPE  V10.4S, V13.4S
    SXTL2 V9.8H, V28.16B
    FSQRT  V6.2S, V12.2S
    UXTL2 V27.2D, V17.4S
    SXTL2 V0.8H, V15.16B
    REV32  V27.4H, V17.4H
    USQADD  H30, H16
    FRECPX  S5, S3
    USQADD  V28.2D, V27.2D
    UXTL V20.8H, V7.8B
    UQXTN  V27.2S, V10.2D
    FRINTN  V21.2D, V7.2D
    FRECPX  D3, D25
    URECPE  V13.2S, V11.2S
    UQXTN  V25.8B, V24.8H
    USQADD  S21, S5
    SQXTN2  V14.16B, V3.8H
    UXTL V6.4S, V28.4H
    UQXTN2  V1.8H, V1.4S
    MVN  V12.16B, V10.16B
    SXTL V24.8H, V16.8B
    SQXTUN  H10, S3
    FNEG  V3.2D, V15.2D
    SQXTN2  V16.4S, V19.2D
    SQXTUN  B13, H9
    SQABS  V8.8B, V29.8B
    FRSQRTE  S21, S3
    FRINTP  V24.2D, V13.2D
    SUQADD  B1, B15
    UQXTN  H8, S12
    UXTL2 V24.8H, V20.16B
    SADALP  V8.2S, V7.4H
    SUQADD  D21, D1
    USQADD  S15, S15
    FRINTZ  V25.2S, V1.2S
    SQXTUN  B10, H6
    USQADD  D7, D31
    CNT  V19.8B, V7.8B
    SXTL V29.8H, V29.8B
    NEG  V8.4S, V5.4S
    FRECPS  D8, D4, D9
    FRINTN  V19.2S, V3.2S
    SQXTN  H13, S8
    USQADD  H5, H18
    UXTL V29.4S, V8.4H
    RBIT  V29.16B, V23.16B
    SQXTUN2  V30.4S, V24.2D
    FRINTP  V16.2D, V7.2D
    SQXTN2  V17.4S, V0.2D
    SUQADD  D0, D18
    SQABS  H20, H23
    FCVTXN  V15.2S, V30.2D
    FNEG  V17.2S, V20.2S
    SUQADD  D26, D11
    UXTL2 V18.2D, V24.4S
    SUQADD  B25, B30
    SUQADD  S22, S4
    SXTL V17.2D, V13.2S
    SUQADD  H24, H4
    SQABS  V6.4H, V23.4H
    FRINTI  V23.4S, V18.4S
    FCVTXN2  V9.4S, V20.2D
    REV64  V29.8H, V13.8H
    SUQADD  S8, S10
    UADDLP  V29.2D, V8.4S
    SQXTUN  V8.2S, V3.2D
    UXTL2 V30.4S, V26.8H
    USQADD  H11, H12
    CLZ  V10.4S, V3.4S
    SQABS  S12, S5
    MVN  V29.8B, V17.8B
    MVN  V12.16B, V20.16B
    UQXTN2  V0.16B, V28.8H
    SQXTUN  S4, D23
    SQXTUN2  V9.4S, V12.2D
    NOT  V1.16B, V21.16B
    MVN  V29.16B, V8.16B
    USQADD  S3, S8
    UQXTN  V6.8B, V12.8H
    SXTL2 V28.8H, V5.16B
    FRINTA  V21.2S, V15.2S
    USQADD  D0, D10
    NOT  V26.16B, V12.16B
    SXTL V28.2D, V4.2S
    FRINTI  V5.4S, V15.4S
    UQXTN  B21, H22
    SQNEG  B23, B9
    SQXTUN2  V6.16B, V0.8H
    FNEG  V6.2S, V29.2S
    FRINTM  V0.4S, V8.4S
    NOT  V18.8B, V16.8B
    SQNEG  D13, D22
    SQNEG  V28.16B, V22.16B
    FCVTXN  V9.2S, V14.2D
    UADDLP  V10.2S, V4.4H
    SQABS  H17, H17
    SQNEG  S30, S13
    FRSQRTE  D16, D22
    SQABS  H13, H26
    FRINTX  V16.2D, V12.2D
    CLS  V24.8H, V15.8H
    USQADD  D19, D20
    SADDLP  V5.4S, V26.8H
    FRECPS  V19.4S, V30.4S, V8.4S
    URECPE  V15.4S, V18.4S
    SQNEG  S18, S3
    SADDLP  V5.8H, V20.16B
    UADDLP  V26.8H, V0.16B
    URECPE  V12.2S, V0.2S
    SUBS  X8, X8, #0x1
    B.NE  TaishanSimdFpIntConversionP01_label_1439
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
TaishanSimdFpIntConversionP01_label_945:
    MOVK  X18, #0xffff, LSL #48
    SUB  X17, X18, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X2, X24, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X28, X10, X4
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X26, X14, X5
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X12, X14, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X6, X3, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X5, X11, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X4, X28, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X27, X29, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X15, X4, X14
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X15
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X12, X11, X16
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X15, X16, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X26, X17, X19
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X4, X2, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X9, X25, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X11, X27, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X15, X2, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X10, X23, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X26, X18, X25
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X17, X18, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X3, X11, X27
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdFpIntConversionP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, D2
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0x7fff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0x7fff, LSL #48
    SUB  X24, X17, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X26
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X26, D3
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X26
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X5
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X5, D4
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x3f80, LSL #16
    SUB  X2, X26, X5
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X24, D5
    MOVZ  X28, #0xfffe, LSL #0
    SUB  X7, X28, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, V6.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X25, D6
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0x7fff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0x7fff, LSL #48
    SUB  X4, X15, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, D7
    MOVZ  X23, #0x80fe, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0x7fff, LSL #48
    SUB  X15, X23, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, V8.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, D8
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, D9
    MOVZ  X24, #0x1, LSL #0
    MOVK  X24, #0x1, LSL #32
    SUB  X3, X24, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X8, X24, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X17, D10
    MOVZ  X24, #0x3f80, LSL #0
    SUB  X8, X24, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X18, V11.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X18, D11
    MOVZ  X4, #0x7fff, LSL #0
    SUB  X21, X4, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, D12
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X7, X20, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X19, #0x0, LSL #0
TaishanSimdFpIntConversionP01_label_557:
    MOVK  X19, #0x7f00, LSL #16
    SUB  X5, X19, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, D14
    MOVZ  X19, #0x7f, LSL #0
    SUB  X5, X19, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, V15.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X27, X24, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X21, D15
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xff80, LSL #48
    SUB  X27, X24, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X26, X28, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X15, D16
    MOVZ  X28, #0xff01, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X26, X28, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X28, X8, X6
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X6, D17
    MOVZ  X8, #0x0, LSL #0
    SUB  X28, X8, X6
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, D18
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, V19.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x4000, LSL #16
    MOVK  X12, #0x4000, LSL #48
    SUB  X5, X12, X22
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X22, D19
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0x4000, LSL #48
    SUB  X5, X12, X22
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X4, D20
    MOVZ  X23, #0xfe, LSL #0
    SUB  X9, X23, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, V21.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X28, D21
    MOVZ  X5, #0xff, LSL #0
    SUB  X22, X5, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, V22.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X15, X2, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X27, D22
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0x7fff, LSL #16
    SUB  X15, X2, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X2, D23
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, V24.D[1]
    MOVZ  X16, #0xf, LSL #0
    MOVK  X16, #0xf, LSL #16
    MOVK  X16, #0xf, LSL #32
    MOVK  X16, #0xf, LSL #48
    SUB  X2, X16, X19
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, D24
    MOVZ  X16, #0xf, LSL #0
    MOVK  X16, #0xf, LSL #16
    MOVK  X16, #0xf, LSL #32
    MOVK  X16, #0xf, LSL #48
    SUB  X2, X16, X19
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X23, D25
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, V26.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X2, X27, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X29, D26
    MOVZ  X27, #0x0, LSL #0
    SUB  X2, X27, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, V27.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X19, D27
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X7, D28
    MOVZ  X8, #0x101, LSL #0
    MOVK  X8, #0x8101, LSL #16
    SUB  X14, X8, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X6, X10, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail
    FMOV  X8, D29
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X6, X10, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdFpIntConversionP01_TestFail

TaishanSimdFpIntConversionP01_TestEnd:
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
TaishanSimdFpIntConversionP01_TestFail:
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
