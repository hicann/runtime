.global TSRTAdvsimdVectorCompare

.text
.p2align 4

TSRTAdvsimdVectorCompare:

TSRTAdvsimdVectorCompare_TestBegin:
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
    MOVZ  X2, #0xf6cb, LSL #0
    MOVK  X2, #0x1d9c, LSL #16
    MOVK  X2, #0xd37b, LSL #32
    MOVK  X2, #0xe550, LSL #48
    MOVZ  X3, #0xd94d, LSL #0
    MOVK  X3, #0xc4d2, LSL #16
    MOVK  X3, #0x8b94, LSL #32
    MOVK  X3, #0x8c12, LSL #48
    MOVZ  X4, #0x6aae, LSL #0
    MOVK  X4, #0xc9, LSL #16
    MOVK  X4, #0x442b, LSL #32
    MOVK  X4, #0x4c7d, LSL #48
    MOVZ  X5, #0xdf09, LSL #0
    MOVK  X5, #0xffb5, LSL #16
    MOVK  X5, #0x11bf, LSL #32
    MOVK  X5, #0xa94e, LSL #48
    MOVZ  X6, #0x818b, LSL #0
    MOVK  X6, #0xcd55, LSL #16
    MOVK  X6, #0xc6f4, LSL #32
    MOVK  X6, #0x80cf, LSL #48
    MOVZ  X7, #0xa55c, LSL #0
    MOVK  X7, #0x96e3, LSL #16
    MOVK  X7, #0x24e3, LSL #32
    MOVK  X7, #0xfd22, LSL #48
    MOVZ  X8, #0x1c83, LSL #0
    MOVK  X8, #0x459c, LSL #16
    MOVK  X8, #0x32d3, LSL #32
    MOVK  X8, #0x6109, LSL #48
    MOVZ  X9, #0x3f25, LSL #0
    MOVK  X9, #0x6d0, LSL #16
    MOVK  X9, #0x3c7d, LSL #32
    MOVK  X9, #0xcce6, LSL #48
    MOVZ  X10, #0x669, LSL #0
    MOVK  X10, #0x2ecb, LSL #16
    MOVK  X10, #0xb9b7, LSL #32
    MOVK  X10, #0xc71d, LSL #48
    MOVZ  X11, #0xf02e, LSL #0
    MOVK  X11, #0xde11, LSL #16
    MOVK  X11, #0x7a1c, LSL #32
    MOVK  X11, #0x730, LSL #48
    MOVZ  X12, #0xba2, LSL #0
    MOVK  X12, #0x686a, LSL #16
    MOVK  X12, #0x7e7b, LSL #32
    MOVK  X12, #0x400e, LSL #48
    MOVZ  X13, #0x9f20, LSL #0
    MOVK  X13, #0xc31e, LSL #16
    MOVK  X13, #0xbfbc, LSL #32
    MOVK  X13, #0xbca8, LSL #48
    MOVZ  X14, #0xf180, LSL #0
    MOVK  X14, #0xfb55, LSL #16
    MOVK  X14, #0xe589, LSL #32
    MOVK  X14, #0x8bf1, LSL #48
    MOVZ  X15, #0x30e3, LSL #0
    MOVK  X15, #0x292b, LSL #16
    MOVK  X15, #0xb098, LSL #32
    MOVK  X15, #0xe7b6, LSL #48
    MOVZ  X16, #0x6b10, LSL #0
    MOVK  X16, #0xdb7a, LSL #16
    MOVK  X16, #0xe78c, LSL #32
    MOVK  X16, #0x5ee8, LSL #48
    MOVZ  X17, #0xe5d7, LSL #0
    MOVK  X17, #0x1eda, LSL #16
    MOVK  X17, #0x2ad2, LSL #32
    MOVK  X17, #0x4390, LSL #48
    MOVZ  X23, #0x801f, LSL #0
    MOVK  X23, #0x950, LSL #16
    MOVK  X23, #0xfb2d, LSL #32
    MOVK  X23, #0x6895, LSL #48
    MOVZ  X24, #0xa470, LSL #0
    MOVK  X24, #0xbd11, LSL #16
    MOVK  X24, #0x24a, LSL #32
    MOVK  X24, #0xcbe4, LSL #48
    MOVZ  X25, #0x2055, LSL #0
    MOVK  X25, #0x44d8, LSL #16
    MOVK  X25, #0x318a, LSL #32
    MOVK  X25, #0x3233, LSL #48
    MOVZ  X26, #0x1ef7, LSL #0
    MOVK  X26, #0x5253, LSL #16
    MOVK  X26, #0x2891, LSL #32
    MOVK  X26, #0x6306, LSL #48
    MOVZ  X27, #0xc7a0, LSL #0
    MOVK  X27, #0xee2e, LSL #16
    MOVK  X27, #0x907d, LSL #32
    MOVK  X27, #0x1c11, LSL #48
    MOVZ  X28, #0x3807, LSL #0
    MOVK  X28, #0xb010, LSL #16
    MOVK  X28, #0x50c9, LSL #32
    MOVK  X28, #0x901a, LSL #48
    MOVZ  X29, #0x4d76, LSL #0
    MOVK  X29, #0xb3f0, LSL #16
    MOVK  X29, #0xc557, LSL #32
    MOVK  X29, #0x6dca, LSL #48
    MOVZ  X5, #0x863c, LSL #0
    MOVK  X5, #0x197e, LSL #16
    MOVK  X5, #0xafe6, LSL #32
    MOVK  X5, #0xf40e, LSL #48
    MSR  FPCR, X5
    MRS  X4, FPCR
    MOVZ  X14, #0x60ff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    AND  X4, X4, X14
    MOVZ  X14, #0x0, LSL #0
    ORR  X4, X4, X14
    MSR  FPCR, X4
    ISB  SY
    MOVZ  X5, #0x1752, LSL #0
    MOVK  X5, #0xabcd, LSL #16
    MOVK  X5, #0x1a68, LSL #32
    MOVK  X5, #0x8892, LSL #48
    MSR  FPSR, X5
    MRS  X25, FPSR
    MOVZ  X24, #0xff60, LSL #0
    MOVK  X24, #0x7ff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    AND  X25, X25, X24
    MOVZ  X24, #0x0, LSL #0
    ORR  X25, X25, X24
    MSR  FPSR, X25
    ISB  SY
    ANDS  W29, W4, W4, ROR #16
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x3a28, LSL #0
    MOVK  X2, #0x19ef, LSL #16
    MOVK  X2, #0x348b, LSL #32
    MOVK  X2, #0x814c, LSL #48
    MOVZ  X3, #0x85f5, LSL #0
    MOVK  X3, #0x1b82, LSL #16
    MOVK  X3, #0xbd1f, LSL #32
    MOVK  X3, #0x37ae, LSL #48
    MOVZ  X4, #0xfe22, LSL #0
    MOVK  X4, #0xc97e, LSL #16
    MOVK  X4, #0xdd33, LSL #32
    MOVK  X4, #0x2296, LSL #48
    MOVZ  X5, #0x1645, LSL #0
    MOVK  X5, #0x6a9d, LSL #16
    MOVK  X5, #0xddee, LSL #32
    MOVK  X5, #0xf3ab, LSL #48
    MOVZ  X6, #0xf16c, LSL #0
    MOVK  X6, #0xde47, LSL #16
    MOVK  X6, #0xb925, LSL #32
    MOVK  X6, #0xc680, LSL #48
    MOVZ  X7, #0xc714, LSL #0
    MOVK  X7, #0x2ac7, LSL #16
    MOVK  X7, #0xe9b, LSL #32
    MOVK  X7, #0x571f, LSL #48
    MOVZ  X8, #0x5838, LSL #0
    MOVK  X8, #0xcd5, LSL #16
    MOVK  X8, #0xc6fe, LSL #32
    MOVK  X8, #0x817f, LSL #48
    MOVZ  X9, #0x8d84, LSL #0
    MOVK  X9, #0x9044, LSL #16
    MOVK  X9, #0xc6d8, LSL #32
    MOVK  X9, #0xb351, LSL #48
    MOVZ  X10, #0x29de, LSL #0
    MOVK  X10, #0x8947, LSL #16
    MOVK  X10, #0xf990, LSL #32
    MOVK  X10, #0x40c8, LSL #48
    MOVZ  X11, #0xf257, LSL #0
    MOVK  X11, #0x29fb, LSL #16
    MOVK  X11, #0xc7c5, LSL #32
    MOVK  X11, #0xcfff, LSL #48
    MOVZ  X12, #0x258, LSL #0
    MOVK  X12, #0x8193, LSL #16
    MOVK  X12, #0x5b57, LSL #32
    MOVK  X12, #0xcbe, LSL #48
    MOVZ  X13, #0x5a1e, LSL #0
    MOVK  X13, #0x9c0f, LSL #16
    MOVK  X13, #0x615c, LSL #32
    MOVK  X13, #0xb76, LSL #48
    MOVZ  X14, #0xda9, LSL #0
    MOVK  X14, #0x5329, LSL #16
    MOVK  X14, #0x7f0a, LSL #32
    MOVK  X14, #0x5412, LSL #48
    MOVZ  X15, #0xc11a, LSL #0
    MOVK  X15, #0xaaed, LSL #16
    MOVK  X15, #0x56cd, LSL #32
    MOVK  X15, #0xac, LSL #48
    MOVZ  X16, #0x4e4b, LSL #0
    MOVK  X16, #0x50fd, LSL #16
    MOVK  X16, #0xd8ef, LSL #32
    MOVK  X16, #0x86e, LSL #48
    MOVZ  X17, #0xf764, LSL #0
    MOVK  X17, #0x1265, LSL #16
    MOVK  X17, #0xbecc, LSL #32
    MOVK  X17, #0x8764, LSL #48
    MOVZ  X23, #0x7975, LSL #0
    MOVK  X23, #0x2cb, LSL #16
    MOVK  X23, #0xfd10, LSL #32
    MOVK  X23, #0xb0e9, LSL #48
    MOVZ  X24, #0x1f2f, LSL #0
    MOVK  X24, #0x28c5, LSL #16
    MOVK  X24, #0x62af, LSL #32
    MOVK  X24, #0xb30c, LSL #48
    MOVZ  X25, #0xb73, LSL #0
    MOVK  X25, #0xe24b, LSL #16
    MOVK  X25, #0xa93d, LSL #32
    MOVK  X25, #0x3450, LSL #48
    MOVZ  X26, #0x3005, LSL #0
    MOVK  X26, #0x80e1, LSL #16
    MOVK  X26, #0x3f6f, LSL #32
    MOVK  X26, #0x52e6, LSL #48
    MOVZ  X27, #0x6a27, LSL #0
    MOVK  X27, #0x33cd, LSL #16
    MOVK  X27, #0x959f, LSL #32
    MOVK  X27, #0xa2fe, LSL #48
    MOVZ  X28, #0xd885, LSL #0
    MOVK  X28, #0xaf, LSL #16
    MOVK  X28, #0x815a, LSL #32
    MOVK  X28, #0xf1a8, LSL #48
    MOVZ  X29, #0xc15f, LSL #0
    MOVK  X29, #0xa1ca, LSL #16
    MOVK  X29, #0xe05e, LSL #32
    MOVK  X29, #0x479a, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X27
    FMOV  D1, X29
    FMOV  V1.D[1], X26
    FMOV  D2, X5
    FMOV  V2.D[1], X28
    FMOV  D3, X13
    FMOV  V3.D[1], X24
    FMOV  D4, X2
    FMOV  V4.D[1], X3
    FMOV  D5, X3
    FMOV  V5.D[1], X5
    FMOV  D6, X2
    FMOV  V6.D[1], X13
    FMOV  D7, X16
    FMOV  V7.D[1], X9
    FMOV  D8, X24
    FMOV  V8.D[1], X10
    FMOV  D9, X6
    FMOV  V9.D[1], X5
    FMOV  D10, X17
    FMOV  V10.D[1], X6
    FMOV  D11, X9
    FMOV  V11.D[1], X25
    FMOV  D12, X14
    FMOV  V12.D[1], X26
    FMOV  D13, X3
    FMOV  V13.D[1], X23
    FMOV  D14, X23
    FMOV  V14.D[1], X5
    FMOV  D15, X12
    FMOV  V15.D[1], X24
    FMOV  D16, X25
    FMOV  V16.D[1], X15
    FMOV  D17, X9
    FMOV  V17.D[1], X10
    FMOV  D18, X9
    FMOV  V18.D[1], X11
    FMOV  D19, X28
    FMOV  V19.D[1], X6
    FMOV  D20, X3
    FMOV  V20.D[1], X6
    FMOV  D21, X17
    FMOV  V21.D[1], X9
    FMOV  D22, X9
    FMOV  V22.D[1], X27
    FMOV  D23, X17
    FMOV  V23.D[1], X17
    FMOV  D24, X13
    FMOV  V24.D[1], X17
    FMOV  D25, X6
    FMOV  V25.D[1], X10
    FMOV  D26, X12
    FMOV  V26.D[1], X11
    FMOV  D27, X4
    FMOV  V27.D[1], X14
    FMOV  D28, X12
    FMOV  V28.D[1], X3
    FMOV  D29, X27
    FMOV  V29.D[1], X5
    FMOV  D30, X13
    FMOV  V30.D[1], X8
    FMOV  D31, X12
    FMOV  V31.D[1], X26
    CMEQ  V7.16B, V22.16B, V22.16B
    CMEQ  V4.2S, V30.2S, V27.2S
    CMEQ  V7.4S, V24.4S, V31.4S
    CMEQ  V1.16B, V6.16B, V29.16B
    CMEQ  V2.4S, V4.4S, V21.4S
    CMEQ  V26.4H, V28.4H, V28.4H
    CMEQ  V22.8B, V10.8B, V23.8B
    CMEQ  V9.8B, V14.8B, V26.8B
    CMEQ  V30.8H, V18.8H, V25.8H
    CMEQ  V10.4H, V7.4H, V30.4H
    CMEQ  V25.4S, V1.4S, #0
    CMEQ  V4.2S, V9.2S, #0
    CMEQ  V6.2S, V22.2S, #0
    CMEQ  V4.2D, V30.2D, #0
    CMEQ  V27.4H, V24.4H, #0
    CMEQ  V6.4S, V16.4S, #0
    CMEQ  V18.2S, V27.2S, #0
    CMEQ  V22.8B, V25.8B, #0
    CMEQ  V29.8H, V18.8H, #0
    CMEQ  V18.2S, V3.2S, #0
    CMGE  V28.2D, V13.2D, V10.2D
    CMGE  V21.2D, V11.2D, V28.2D
    CMGE  V14.4H, V2.4H, V11.4H
    CMGE  V31.8B, V8.8B, V6.8B
    CMGE  V3.8H, V31.8H, V10.8H
    CMGE  V9.8H, V21.8H, V27.8H
    CMGE  V24.2S, V3.2S, V18.2S
    CMGE  V28.2S, V9.2S, V14.2S
    CMGE  V2.8B, V5.8B, V30.8B
    CMGE  V7.2S, V24.2S, V28.2S
    CMGE  V10.2D, V29.2D, #0
    CMGE  V30.2S, V18.2S, #0
    CMGE  V9.4S, V4.4S, #0
    CMGE  V14.2S, V7.2S, #0
    CMGE  V4.8H, V1.8H, #0
    CMGE  V25.2S, V2.2S, #0
    CMGE  V13.8B, V17.8B, #0
    CMGE  V27.16B, V30.16B, #0
    CMGE  V19.8H, V0.8H, #0
    CMGE  V18.4S, V29.4S, #0
    CMGT  V21.2S, V4.2S, V10.2S
    CMGT  V2.2D, V9.2D, V14.2D
    CMGT  V7.4S, V2.4S, V13.4S
    CMGT  V5.2D, V18.2D, V19.2D
    CMGT  V3.2S, V20.2S, V0.2S
    CMGT  V13.4H, V3.4H, V24.4H
    CMGT  V10.4S, V21.4S, V21.4S
    CMGT  V4.16B, V13.16B, V13.16B
    CMGT  V13.2D, V16.2D, V4.2D
    CMGT  V5.8B, V7.8B, V22.8B
    CMGT  V28.4H, V13.4H, #0
    CMGT  V29.8H, V27.8H, #0
    CMGT  V30.2D, V28.2D, #0
    CMGT  V18.4S, V22.4S, #0
    CMGT  V4.4S, V18.4S, #0
    CMGT  V0.8B, V5.8B, #0
    CMGT  V21.4S, V10.4S, #0
    CMGT  V13.4H, V0.4H, #0
    CMGT  V20.2S, V30.2S, #0
    CMGT  V16.4S, V13.4S, #0
    CMHI  V2.8H, V16.8H, V16.8H
    CMHI  V13.16B, V14.16B, V16.16B
    CMHI  V3.8B, V20.8B, V2.8B
    CMHI  V27.2D, V4.2D, V10.2D
    CMHI  V28.8B, V29.8B, V13.8B
    CMHI  V22.8H, V26.8H, V21.8H
    CMHI  V19.2D, V27.2D, V27.2D
    CMHI  V0.8H, V27.8H, V16.8H
    CMHI  V9.2S, V0.2S, V3.2S
    CMHI  V13.8B, V27.8B, V28.8B
    CMHS  V14.16B, V22.16B, V13.16B
    CMHS  V0.4S, V9.4S, V24.4S
    CMHS  V7.2D, V19.2D, V0.2D
    CMHS  V19.8H, V29.8H, V20.8H
    CMHS  V20.4H, V10.4H, V4.4H
    CMHS  V24.4S, V25.4S, V27.4S
    CMHS  V2.4S, V4.4S, V3.4S
    CMHS  V10.4H, V22.4H, V1.4H
    CMHS  V5.4S, V14.4S, V19.4S
    CMHS  V6.2D, V17.2D, V29.2D
    CMLE  V18.4H, V28.4H, #0
    CMLE  V23.16B, V27.16B, #0
    CMLE  V29.2D, V5.2D, #0
    CMLE  V28.8B, V29.8B, #0
    CMLE  V9.8B, V24.8B, #0
    CMLE  V16.8H, V18.8H, #0
    CMLE  V0.2S, V16.2S, #0
    CMLE  V19.2D, V23.2D, #0
    CMLE  V29.2D, V22.2D, #0
    CMLE  V18.8H, V29.8H, #0
    CMLT  V9.4H, V26.4H, #0
    CMLT  V17.2S, V19.2S, #0
    CMLT  V26.8H, V16.8H, #0
    CMLT  V14.2D, V0.2D, #0
    CMLT  V24.4H, V18.4H, #0
    CMLT  V5.8H, V10.8H, #0
    CMLT  V3.8B, V25.8B, #0
    CMLT  V23.2S, V3.2S, #0
    CMLT  V29.2S, V6.2S, #0
    CMLT  V7.8B, V17.8B, #0
    CMTST  V10.8H, V24.8H, V5.8H
    CMTST  V17.8B, V27.8B, V6.8B
    CMTST  V24.16B, V29.16B, V29.16B
    CMTST  V22.8H, V25.8H, V19.8H
    CMTST  V16.4H, V24.4H, V12.4H
    CMTST  V15.2S, V16.2S, V14.2S
    CMTST  V9.2D, V9.2D, V7.2D
    CMTST  V31.2S, V23.2S, V26.2S
    CMTST  V18.16B, V17.16B, V17.16B
    CMTST  V17.16B, V9.16B, V9.16B
    FCMEQ  V19.4S, V18.4S, V18.4S
    FCMEQ  V25.4S, V31.4S, V5.4S
    FCMEQ  V26.2D, V28.2D, V22.2D
    FCMEQ  V9.4S, V25.4S, V10.4S
    FCMEQ  V6.4S, V26.4S, V9.4S
    FCMEQ  V7.2S, V6.2S, V19.2S
    FCMEQ  V0.2D, V15.2D, V21.2D
    FCMEQ  V8.4S, V10.4S, V7.4S
    FCMEQ  V18.4S, V17.4S, V15.4S
    FCMEQ  V5.4S, V5.4S, V26.4S
    FCMEQ  V13.2D, V18.2D, #0.0
    FCMEQ  V29.2D, V5.2D, #0.0
    FCMEQ  V21.2S, V27.2S, #0.0
    FCMEQ  V24.4S, V12.4S, #0.0
    FCMEQ  V14.4S, V27.4S, #0.0
    FCMEQ  V22.2D, V31.2D, #0.0
    FCMEQ  V19.2S, V8.2S, #0.0
    FCMEQ  V17.2S, V22.2S, #0.0
    FCMEQ  V7.2D, V29.2D, #0.0
    FCMEQ  V28.2D, V24.2D, #0.0
    FCMGE  V26.2S, V14.2S, V14.2S
    FCMGE  V8.2D, V19.2D, V7.2D
    FCMGE  V18.2D, V17.2D, V8.2D
    FCMGE  V19.4S, V14.4S, V0.4S
    FCMGE  V14.2D, V26.2D, V28.2D
    FCMGE  V25.4S, V18.4S, V21.4S
    FCMGE  V18.4S, V14.4S, V12.4S
    FCMGE  V27.2S, V26.2S, V18.2S
    FCMGE  V12.4S, V17.4S, V27.4S
    FCMGE  V25.4S, V14.4S, V25.4S
    FCMGE  V13.2D, V12.2D, #0.0
    FCMGE  V22.2D, V15.2D, #0.0
    FCMGE  V17.2S, V13.2S, #0.0
    FCMGE  V7.2S, V17.2S, #0.0
    FCMGE  V14.4S, V22.4S, #0.0
    FCMGE  V26.2S, V10.2S, #0.0
    FCMGE  V4.4S, V7.4S, #0.0
    FCMGE  V29.4S, V23.4S, #0.0
    FCMGE  V21.2D, V2.2D, #0.0
    FCMGE  V16.2D, V28.2D, #0.0
    FCMGT  V13.2D, V19.2D, V19.2D
    FCMGT  V19.2D, V26.2D, V25.2D
    FCMGT  V17.4S, V5.4S, V13.4S
    FCMGT  V10.2D, V14.2D, V14.2D
    FCMGT  V25.4S, V21.4S, V13.4S
    FCMGT  V21.4S, V16.4S, V21.4S
    FCMGT  V24.4S, V10.4S, V25.4S
    FCMGT  V26.4S, V1.4S, V17.4S
    FCMGT  V7.2D, V31.2D, V11.2D
    FCMGT  V10.2D, V7.2D, V2.2D
    FCMGT  V0.2S, V26.2S, #0.0
    FCMGT  V15.2S, V21.2S, #0.0
    FCMGT  V23.2D, V25.2D, #0.0
    FCMGT  V18.4S, V23.4S, #0.0
    FCMGT  V26.4S, V4.4S, #0.0
    FCMGT  V16.4S, V11.4S, #0.0
    FCMGT  V21.4S, V10.4S, #0.0
    FCMGT  V27.2S, V15.2S, #0.0
    FCMGT  V17.2D, V19.2D, #0.0
    FCMGT  V2.2D, V16.2D, #0.0
    FCMLE  V15.4S, V17.4S, #0.0
    FCMLE  V5.2D, V18.2D, #0.0
    FCMLE  V16.2S, V25.2S, #0.0
    FCMLE  V23.2S, V27.2S, #0.0
    FCMLE  V29.2D, V21.2D, #0.0
    FCMLE  V17.2D, V24.2D, #0.0
    FCMLE  V31.2D, V26.2D, #0.0
    FCMLE  V4.4S, V5.4S, #0.0
    FCMLE  V18.2S, V31.2S, #0.0
    FCMLE  V19.2D, V23.2D, #0.0
    FCMLT  V31.2S, V29.2S, #0.0
    FCMLT  V14.4S, V31.4S, #0.0
    FCMLT  V27.4S, V14.4S, #0.0
    FCMLT  V23.2S, V4.2S, #0.0
    FCMLT  V29.4S, V23.4S, #0.0
    FCMLT  V5.2S, V14.2S, #0.0
    FCMLT  V28.2S, V20.2S, #0.0
    FCMLT  V26.4S, V16.4S, #0.0
    FCMLT  V23.2S, V5.2S, #0.0
    FCMLT  V24.2D, V27.2D, #0.0
    FCMEQ  V4.4H, V25.4H, V26.4H
    FCMEQ  V11.4H, V15.4H, V24.4H
    FCMEQ  V15.8H, V23.8H, V11.8H
    FCMEQ  V10.8H, V26.8H, V15.8H
    FCMEQ  V15.8H, V18.8H, V10.8H
    FCMEQ  V14.4H, V17.4H, V25.4H
    FCMEQ  V20.4H, V19.4H, V15.4H
    FCMEQ  V16.8H, V25.8H, V14.8H
    FCMEQ  V17.8H, V28.8H, V20.8H
    FCMEQ  V18.8H, V16.8H, V4.8H
    FCMEQ  V10.8H, V18.8H, #0.0
    FCMEQ  V15.8H, V17.8H, #0.0
    FCMEQ  V23.4H, V15.4H, #0.0
    FCMEQ  V31.8H, V8.8H, #0.0
    FCMEQ  V11.4H, V7.4H, #0.0
    FCMEQ  V21.8H, V6.8H, #0.0
    FCMEQ  V15.4H, V11.4H, #0.0
    FCMEQ  V6.4H, V10.4H, #0.0
    FCMEQ  V20.8H, V31.8H, #0.0
    FCMEQ  V8.4H, V29.4H, #0.0
    FCMGE  V4.4H, V20.4H, V8.4H
    FCMGE  V14.4H, V21.4H, V6.4H
    FCMGE  V11.8H, V4.8H, V24.8H
    FCMGE  V25.4H, V30.4H, V29.4H
    FCMGE  V10.4H, V23.4H, V24.4H
    FCMGE  V27.8H, V10.8H, V10.8H
    FCMGE  V18.8H, V27.8H, V30.8H
    FCMGE  V17.4H, V15.4H, V28.4H
    FCMGE  V8.8H, V7.8H, V25.8H
    FCMGE  V7.8H, V30.8H, V24.8H
    FCMGE  V20.8H, V13.8H, #0.0
    FCMGE  V15.4H, V6.4H, #0.0
    FCMGE  V10.8H, V20.8H, #0.0
    FCMGE  V13.8H, V14.8H, #0.0
    FCMGE  V27.8H, V0.8H, #0.0
    FCMGE  V19.4H, V11.4H, #0.0
    FCMGE  V14.4H, V19.4H, #0.0
    FCMGE  V29.8H, V6.8H, #0.0
    FCMGE  V28.4H, V22.4H, #0.0
    FCMGE  V30.4H, V17.4H, #0.0
    FCMGT  V7.4H, V7.4H, V8.4H
    FCMGT  V23.8H, V14.8H, V18.8H
    FCMGT  V14.8H, V10.8H, V10.8H
    FCMGT  V11.4H, V1.4H, V13.4H
    FCMGT  V6.8H, V0.8H, V27.8H
    FCMGT  V19.4H, V29.4H, V10.4H
    FCMGT  V10.8H, V19.8H, V15.8H
    FCMGT  V18.4H, V10.4H, V10.4H
    FCMGT  V31.4H, V20.4H, V30.4H
    FCMGT  V20.4H, V1.4H, V15.4H
    FCMGT  V1.8H, V18.8H, #0.0
    FCMGT  V18.8H, V20.8H, #0.0
    FCMGT  V10.8H, V6.8H, #0.0
    FCMGT  V0.8H, V14.8H, #0.0
    FCMGT  V30.4H, V18.4H, #0.0
    FCMGT  V19.4H, V29.4H, #0.0
    FCMGT  V25.8H, V23.8H, #0.0
    FCMGT  V23.4H, V10.4H, #0.0
    FCMGT  V19.4H, V0.4H, #0.0
    FCMGT  V10.8H, V11.8H, #0.0
    FCMLE  V27.8H, V7.8H, #0.0
    FCMLE  V7.8H, V27.8H, #0.0
    FCMLE  V18.4H, V3.4H, #0.0
    FCMLE  V6.8H, V15.8H, #0.0
    FCMLE  V17.4H, V31.4H, #0.0
    FCMLE  V11.8H, V25.8H, #0.0
    FCMLE  V20.8H, V28.8H, #0.0
    FCMLE  V15.4H, V20.4H, #0.0
    FCMLE  V31.8H, V10.8H, #0.0
    FCMLE  V27.8H, V19.8H, #0.0
    FCMLT  V25.8H, V30.8H, #0.0
    FCMLT  V0.4H, V18.4H, #0.0
    FCMLT  V10.4H, V11.4H, #0.0
    FCMLT  V3.8H, V25.8H, #0.0
    FCMLT  V19.8H, V8.8H, #0.0
    FCMLT  V6.8H, V31.8H, #0.0
    FCMLT  V28.8H, V7.8H, #0.0
    FCMLT  V7.4H, V0.4H, #0.0
    FCMLT  V14.8H, V26.8H, #0.0
    FCMLT  V23.4H, V19.4H, #0.0
    MOVZ  X15, #0x3a28, LSL #0
    MOVK  X15, #0x19ef, LSL #16
    MOVK  X15, #0x348b, LSL #32
    MOVK  X15, #0x814c, LSL #48
    SUB  X16, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X15, #0x85f5, LSL #0
    MOVK  X15, #0x1b82, LSL #16
    MOVK  X15, #0xbd1f, LSL #32
    MOVK  X15, #0x37ae, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X15, #0xfe22, LSL #0
    MOVK  X15, #0xc97e, LSL #16
    MOVK  X15, #0xdd33, LSL #32
    MOVK  X15, #0x2296, LSL #48
    SUB  X16, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X15, #0x1645, LSL #0
    MOVK  X15, #0x6a9d, LSL #16
    MOVK  X15, #0xddee, LSL #32
    MOVK  X15, #0xf3ab, LSL #48
    SUB  X16, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X15, #0xf16c, LSL #0
    MOVK  X15, #0xde47, LSL #16
    MOVK  X15, #0xb925, LSL #32
    MOVK  X15, #0xc680, LSL #48
    SUB  X16, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X15, #0xc714, LSL #0
    MOVK  X15, #0x2ac7, LSL #16
    MOVK  X15, #0xe9b, LSL #32
    MOVK  X15, #0x571f, LSL #48
    SUB  X16, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X15, #0x5838, LSL #0
    MOVK  X15, #0xcd5, LSL #16
    MOVK  X15, #0xc6fe, LSL #32
    MOVK  X15, #0x817f, LSL #48
    SUB  X16, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X15, #0x8d84, LSL #0
    MOVK  X15, #0x9044, LSL #16
    MOVK  X15, #0xc6d8, LSL #32
    MOVK  X15, #0xb351, LSL #48
    SUB  X16, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X15, #0x29de, LSL #0
    MOVK  X15, #0x8947, LSL #16
    MOVK  X15, #0xf990, LSL #32
    MOVK  X15, #0x40c8, LSL #48
    SUB  X16, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X15, #0xf257, LSL #0
    MOVK  X15, #0x29fb, LSL #16
    MOVK  X15, #0xc7c5, LSL #32
    MOVK  X15, #0xcfff, LSL #48
    SUB  X16, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X15, #0x258, LSL #0
    MOVK  X15, #0x8193, LSL #16
    MOVK  X15, #0x5b57, LSL #32
    MOVK  X15, #0xcbe, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X15, #0x5a1e, LSL #0
    MOVK  X15, #0x9c0f, LSL #16
    MOVK  X15, #0x615c, LSL #32
    MOVK  X15, #0xb76, LSL #48
    SUB  X16, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X15, #0xda9, LSL #0
    MOVK  X15, #0x5329, LSL #16
    MOVK  X15, #0x7f0a, LSL #32
    MOVK  X15, #0x5412, LSL #48
    SUB  X16, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X15, #0xf764, LSL #0
    MOVK  X15, #0x1265, LSL #16
    MOVK  X15, #0xbecc, LSL #32
    MOVK  X15, #0x8764, LSL #48
    SUB  X16, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X15, #0x7975, LSL #0
    MOVK  X15, #0x2cb, LSL #16
    MOVK  X15, #0xfd10, LSL #32
    MOVK  X15, #0xb0e9, LSL #48
    SUB  X16, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X15, #0xb73, LSL #0
    MOVK  X15, #0xe24b, LSL #16
    MOVK  X15, #0xa93d, LSL #32
    MOVK  X15, #0x3450, LSL #48
    SUB  X16, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X15, #0x3005, LSL #0
    MOVK  X15, #0x80e1, LSL #16
    MOVK  X15, #0x3f6f, LSL #32
    MOVK  X15, #0x52e6, LSL #48
    SUB  X16, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X15, #0x6a27, LSL #0
    MOVK  X15, #0x33cd, LSL #16
    MOVK  X15, #0x959f, LSL #32
    MOVK  X15, #0xa2fe, LSL #48
    SUB  X16, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X15, #0xd885, LSL #0
    MOVK  X15, #0xaf, LSL #16
    MOVK  X15, #0x815a, LSL #32
    MOVK  X15, #0xf1a8, LSL #48
    SUB  X16, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X15, #0xc15f, LSL #0
    MOVK  X15, #0xa1ca, LSL #16
    MOVK  X15, #0xe05e, LSL #32
    MOVK  X15, #0x479a, LSL #48
    SUB  X16, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    MRS  X15, FPSR
    MOVZ  X16, #0x1, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V0.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D0
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V1.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D1
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V2.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D2
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D3
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V4.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D4
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V5.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D5
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V6.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D6
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D7
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V8.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D8
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V9.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D9
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V10.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D10
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V11.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D11
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V12.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D12
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V13.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D13
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V14.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D14
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V15.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D15
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D16
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V17.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D17
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V18.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D18
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V19.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D19
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V20.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D20
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V21.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D21
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V22.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D22
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V23.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D23
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V24.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D24
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V25.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D25
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D26
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V27.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D27
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V28.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D28
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V29.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D29
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V30.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D30
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, V31.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X15, D31
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X2, #0x4c08, LSL #0
    MOVK  X2, #0x81ab, LSL #16
    MOVK  X2, #0x4659, LSL #32
    MOVK  X2, #0x8792, LSL #48
    MOVZ  X3, #0xd2fa, LSL #0
    MOVK  X3, #0x2cf2, LSL #16
    MOVK  X3, #0xb52d, LSL #32
    MOVK  X3, #0xa6e4, LSL #48
    MOVZ  X4, #0x4c98, LSL #0
    MOVK  X4, #0x75e3, LSL #16
    MOVK  X4, #0xdc39, LSL #32
    MOVK  X4, #0x2967, LSL #48
    MOVZ  X5, #0xee60, LSL #0
    MOVK  X5, #0x5d0a, LSL #16
    MOVK  X5, #0x409b, LSL #32
    MOVK  X5, #0xf94, LSL #48
    MOVZ  X6, #0x1287, LSL #0
    MOVK  X6, #0x6e3d, LSL #16
    MOVK  X6, #0x2435, LSL #32
    MOVK  X6, #0xb9fb, LSL #48
    MOVZ  X7, #0x7730, LSL #0
    MOVK  X7, #0x6010, LSL #16
    MOVK  X7, #0x7a79, LSL #32
    MOVK  X7, #0xe807, LSL #48
    MOVZ  X8, #0xdf28, LSL #0
    MOVK  X8, #0x54cd, LSL #16
    MOVK  X8, #0xa9b5, LSL #32
    MOVK  X8, #0x659c, LSL #48
    MOVZ  X9, #0xf4e0, LSL #0
    MOVK  X9, #0xadf9, LSL #16
    MOVK  X9, #0xc201, LSL #32
    MOVK  X9, #0x205a, LSL #48
    MOVZ  X10, #0xdd99, LSL #0
    MOVK  X10, #0x76f5, LSL #16
    MOVK  X10, #0xd41a, LSL #32
    MOVK  X10, #0x8379, LSL #48
    MOVZ  X11, #0x2473, LSL #0
    MOVK  X11, #0x8939, LSL #16
    MOVK  X11, #0x945b, LSL #32
    MOVK  X11, #0xfaa8, LSL #48
    MOVZ  X12, #0xc3af, LSL #0
    MOVK  X12, #0x240, LSL #16
    MOVK  X12, #0xc67, LSL #32
    MOVK  X12, #0x7393, LSL #48
    MOVZ  X13, #0xe28c, LSL #0
    MOVK  X13, #0xbf76, LSL #16
    MOVK  X13, #0xa451, LSL #32
    MOVK  X13, #0xa693, LSL #48
    MOVZ  X14, #0x207, LSL #0
    MOVK  X14, #0x6096, LSL #16
    MOVK  X14, #0xa25b, LSL #32
    MOVK  X14, #0x7bac, LSL #48
    MOVZ  X15, #0x7d40, LSL #0
    MOVK  X15, #0x685d, LSL #16
    MOVK  X15, #0x9d95, LSL #32
    MOVK  X15, #0xfd0d, LSL #48
    MOVZ  X16, #0x4a37, LSL #0
    MOVK  X16, #0x65c8, LSL #16
    MOVK  X16, #0x2a9e, LSL #32
    MOVK  X16, #0xe1e6, LSL #48
    MOVZ  X17, #0xb817, LSL #0
    MOVK  X17, #0x1bcb, LSL #16
    MOVK  X17, #0xad4c, LSL #32
    MOVK  X17, #0xb37f, LSL #48
    MOVZ  X23, #0x8590, LSL #0
    MOVK  X23, #0xbe93, LSL #16
    MOVK  X23, #0xb72c, LSL #32
    MOVK  X23, #0x14ea, LSL #48
    MOVZ  X24, #0x8de, LSL #0
    MOVK  X24, #0x6a53, LSL #16
    MOVK  X24, #0xe74f, LSL #32
    MOVK  X24, #0xe82c, LSL #48
    MOVZ  X25, #0x1174, LSL #0
    MOVK  X25, #0xce7f, LSL #16
    MOVK  X25, #0x73e0, LSL #32
    MOVK  X25, #0x5aeb, LSL #48
    MOVZ  X26, #0xf73c, LSL #0
    MOVK  X26, #0x55e7, LSL #16
    MOVK  X26, #0xcfaa, LSL #32
    MOVK  X26, #0x77ad, LSL #48
    MOVZ  X27, #0xb9b8, LSL #0
    MOVK  X27, #0x8fd9, LSL #16
    MOVK  X27, #0x504, LSL #32
    MOVK  X27, #0x7d3, LSL #48
    MOVZ  X28, #0x8f24, LSL #0
    MOVK  X28, #0x34ce, LSL #16
    MOVK  X28, #0x7576, LSL #32
    MOVK  X28, #0xd7cc, LSL #48
    MOVZ  X29, #0xd325, LSL #0
    MOVK  X29, #0x5d4d, LSL #16
    MOVK  X29, #0xce5f, LSL #32
    MOVK  X29, #0x8041, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X13
    FMOV  D1, X8
    FMOV  V1.D[1], X3
    FMOV  D2, X29
    FMOV  V2.D[1], X28
    FMOV  D3, X26
    FMOV  V3.D[1], X27
    FMOV  D4, X6
    FMOV  V4.D[1], X26
    FMOV  D5, X12
    FMOV  V5.D[1], X11
    FMOV  D6, X25
    FMOV  V6.D[1], X5
    FMOV  D7, X11
    FMOV  V7.D[1], X24
    FMOV  D8, X29
    FMOV  V8.D[1], X25
    FMOV  D9, X4
    FMOV  V9.D[1], X2
    FMOV  D10, X25
    FMOV  V10.D[1], X9
    FMOV  D11, X17
    FMOV  V11.D[1], X16
    FMOV  D12, X29
    FMOV  V12.D[1], X2
    FMOV  D13, X9
    FMOV  V13.D[1], X2
    FMOV  D14, X10
    FMOV  V14.D[1], X28
    FMOV  D15, X28
    FMOV  V15.D[1], X13
    FMOV  D16, X11
    FMOV  V16.D[1], X10
    FMOV  D17, X8
    FMOV  V17.D[1], X2
    FMOV  D18, X23
    FMOV  V18.D[1], X9
    FMOV  D19, X28
    FMOV  V19.D[1], X16
    FMOV  D20, X27
    FMOV  V20.D[1], X16
    FMOV  D21, X8
    FMOV  V21.D[1], X26
    FMOV  D22, X15
    FMOV  V22.D[1], X6
    FMOV  D23, X16
    FMOV  V23.D[1], X16
    FMOV  D24, X7
    FMOV  V24.D[1], X7
    FMOV  D25, X5
    FMOV  V25.D[1], X12
    FMOV  D26, X4
    FMOV  V26.D[1], X13
    FMOV  D27, X5
    FMOV  V27.D[1], X8
    FMOV  D28, X7
    FMOV  V28.D[1], X9
    FMOV  D29, X14
    FMOV  V29.D[1], X13
    FMOV  D30, X25
    FMOV  V30.D[1], X9
    FMOV  D31, X11
    FMOV  V31.D[1], X26
    MOVZ  X29, #0xa, LSL #0
TSRTAdvsimdVectorCompare_label_0:
    FCMGT  V4.8H, V31.8H, #0.0
    FCMGE  V11.4H, V23.4H, V27.4H
    CMLT  V0.4S, V2.4S, #0
    FCMEQ  V3.4S, V26.4S, #0.0
    CMHI  V7.8H, V19.8H, V3.8H
    FCMGT  V21.4S, V25.4S, V30.4S
    FCMGE  V19.4S, V2.4S, #0.0
    FCMGT  V31.2D, V21.2D, V11.2D
    FCMLT  V17.4S, V7.4S, #0.0
    CMGE  V2.16B, V17.16B, #0
    CMEQ  V13.16B, V0.16B, V31.16B
    FCMLT  V30.8H, V17.8H, #0.0
    FCMLT  V5.2S, V30.2S, #0.0
    CMTST  V14.8H, V2.8H, V2.8H
    FCMEQ  V30.2S, V5.2S, V5.2S
    FCMGT  V26.2S, V4.2S, V14.2S
    CMHI  V31.2S, V28.2S, V12.2S
    FCMGE  V7.2S, V29.2S, V13.2S
    FCMEQ  V23.2D, V26.2D, #0.0
    CMHS  V5.2S, V9.2S, V30.2S
    CMGE  V16.8B, V19.8B, #0
    FCMGT  V4.2D, V17.2D, #0.0
    FCMGT  V12.4H, V22.4H, V5.4H
    CMHI  V29.8B, V12.8B, V7.8B
    FCMGE  V17.8H, V16.8H, #0.0
    FCMGE  V16.8H, V6.8H, #0.0
    CMGT  V7.16B, V15.16B, V4.16B
    CMHS  V26.4H, V16.4H, V7.4H
    FCMGT  V7.2D, V23.2D, V23.2D
    FCMEQ  V2.2D, V31.2D, V31.2D
    CMLE  V12.4S, V21.4S, #0
    CMLT  V31.2S, V26.2S, #0
    FCMGT  V21.2S, V12.2S, V31.2S
    CMEQ  V5.4S, V2.4S, #0
    CMLE  V31.8B, V17.8B, #0
    CMTST  V12.8H, V7.8H, V5.8H
    FCMEQ  V28.8H, V12.8H, #0.0
    CMGT  V23.8B, V14.8B, V1.8B
    CMGT  V7.2S, V31.2S, V31.2S
    CMEQ  V31.2D, V23.2D, #0
    FCMGT  V2.4S, V12.4S, #0.0
    CMGE  V23.4S, V31.4S, #0
    FCMLE  V14.2D, V21.2D, #0.0
    FCMGE  V0.4H, V7.4H, V28.4H
    CMTST  V4.4S, V30.4S, V23.4S
    CMEQ  V31.8B, V0.8B, #0
    CMLE  V19.8H, V4.8H, #0
    CMGE  V21.4H, V2.4H, #0
    CMGT  V26.4S, V23.4S, V19.4S
    FCMEQ  V16.8H, V5.8H, V14.8H
    FCMLT  V19.8H, V26.8H, #0.0
    FCMEQ  V5.2D, V31.2D, #0.0
    FCMGE  V30.2S, V19.2S, V3.2S
    CMEQ  V2.8B, V13.8B, V16.8B
    FCMGE  V23.8H, V30.8H, V5.8H
    FCMGT  V16.2D, V2.2D, #0.0
    CMEQ  V7.8B, V11.8B, #0
    FCMEQ  V16.4S, V25.4S, #0.0
    FCMGT  V19.8H, V7.8H, #0.0
    FCMGT  V12.8H, V5.8H, V21.8H
    FCMGT  V26.2D, V19.2D, V12.2D
    FCMGT  V19.8H, V24.8H, #0.0
    CMLE  V13.4S, V1.4S, #0
    FCMGT  V28.2S, V16.2S, V26.2S
    FCMLT  V11.2S, V13.2S, #0.0
    CMEQ  V30.4S, V28.4S, V11.4S
    FCMEQ  V31.2D, V30.2D, V30.2D
    FCMEQ  V24.4S, V31.4S, V31.4S
    FCMLT  V0.8H, V21.8H, #0.0
    CMLT  V28.8B, V0.8B, #0
    FCMGT  V23.4H, V20.4H, #0.0
    CMLE  V0.16B, V7.16B, #0
    FCMGT  V21.4H, V0.4H, #0.0
    FCMGT  V0.4H, V28.4H, #0.0
    FCMGE  V26.8H, V19.8H, V19.8H
    CMGE  V19.8H, V28.8H, #0
    CMGE  V7.16B, V6.16B, V29.16B
    FCMLE  V31.8H, V0.8H, #0.0
    FCMGT  V16.4S, V28.4S, V23.4S
    CMGE  V12.4S, V24.4S, #0
    FCMLE  V24.4H, V7.4H, #0.0
    CMHI  V13.2D, V12.2D, V19.2D
    CMHS  V0.4H, V26.4H, V26.4H
    CMGT  V28.8H, V24.8H, V31.8H
    CMGT  V12.4S, V9.4S, #0
    CMLT  V30.2D, V2.2D, #0
    FCMEQ  V2.8H, V12.8H, V31.8H
    CMGT  V1.16B, V11.16B, V27.16B
    FCMLT  V5.2D, V23.2D, #0.0
    FCMEQ  V9.2D, V2.2D, V13.2D
    CMHI  V31.2D, V5.2D, V25.2D
    CMEQ  V23.2S, V30.2S, #0
    FCMLE  V24.8H, V28.8H, #0.0
    FCMEQ  V25.4S, V31.4S, #0.0
    FCMGE  V12.8H, V30.8H, #0.0
    CMEQ  V19.8B, V23.8B, #0
    CMGT  V26.8H, V12.8H, V25.8H
    FCMEQ  V17.8H, V16.8H, V0.8H
    FCMGE  V0.4H, V16.4H, #0.0
    FCMEQ  V31.8H, V24.8H, V26.8H
    FCMGE  V20.8H, V23.8H, V17.8H
    CMHI  V27.8H, V11.8H, V31.8H
    CMLE  V31.16B, V1.16B, #0
    CMTST  V1.8H, V27.8H, V0.8H
    FCMGE  V5.4S, V3.4S, V31.4S
    CMHS  V6.8H, V10.8H, V19.8H
    FCMGE  V2.2D, V9.2D, #0.0
    CMGT  V13.16B, V4.16B, #0
    FCMEQ  V20.4S, V20.4S, #0.0
    CMGE  V9.4S, V13.4S, #0
    FCMGE  V0.4H, V20.4H, V25.4H
    FCMGT  V0.2S, V2.2S, #0.0
    CMHI  V5.2S, V15.2S, V0.2S
    FCMEQ  V16.8H, V5.8H, #0.0
    CMHI  V28.8B, V18.8B, V23.8B
    FCMGT  V11.8H, V9.8H, #0.0
    FCMLE  V16.2D, V29.2D, #0.0
    FCMGE  V17.4S, V11.4S, V6.4S
    FCMLE  V18.8H, V5.8H, #0.0
    FCMGT  V2.2S, V16.2S, V18.2S
    FCMLT  V3.2D, V2.2D, #0.0
    CMHS  V11.4S, V3.4S, V3.4S
    FCMLT  V13.2D, V13.2D, #0.0
    FCMGT  V9.4S, V28.4S, #0.0
    FCMLT  V4.4S, V17.4S, #0.0
    CMEQ  V16.2S, V1.2S, #0
    FCMEQ  V18.8H, V16.8H, #0.0
    FCMLE  V2.4H, V23.4H, #0.0
    FCMGE  V0.4H, V11.4H, V2.4H
    CMGT  V1.4S, V20.4S, #0
    FCMEQ  V29.2S, V17.2S, #0.0
    CMHI  V5.8H, V29.8H, V18.8H
    FCMGT  V2.4S, V9.4S, V13.4S
    FCMLE  V23.4H, V1.4H, #0.0
    CMHI  V28.4S, V2.4S, V23.4S
    FCMGT  V23.2S, V4.2S, V0.2S
    CMHS  V28.2S, V23.2S, V7.2S
    CMHI  V18.8B, V5.8B, V20.8B
    FCMLT  V29.2D, V30.2D, #0.0
    CMEQ  V2.8H, V27.8H, V30.8H
    CMLE  V26.8B, V21.8B, #0
    FCMLT  V11.2D, V5.2D, #0.0
    FCMGT  V23.2S, V7.2S, #0.0
    CMHI  V24.8B, V26.8B, V29.8B
    FCMGT  V20.2D, V19.2D, #0.0
    FCMGT  V28.4H, V16.4H, V23.4H
    CMGT  V29.8H, V24.8H, #0
    CMGE  V24.4H, V20.4H, #0
    FCMGT  V4.8H, V2.8H, V18.8H
    FCMGE  V25.4H, V19.4H, V13.4H
    CMGT  V27.8B, V25.8B, V6.8B
    CMGE  V17.2S, V0.2S, #0
    CMHS  V1.2S, V15.2S, V28.2S
    CMTST  V13.16B, V8.16B, V24.16B
    CMGE  V8.8H, V20.8H, #0
    FCMGT  V21.8H, V14.8H, V13.8H
    CMLT  V8.8H, V25.8H, #0
    CMHI  V14.8B, V1.8B, V11.8B
    CMLE  V9.2D, V8.2D, #0
    FCMGE  V5.2S, V30.2S, V29.2S
    CMTST  V19.16B, V27.16B, V9.16B
    FCMGE  V26.4S, V14.4S, V7.4S
    CMEQ  V25.2D, V22.2D, V20.2D
    FCMGT  V14.2S, V25.2S, #0.0
    FCMGT  V8.2S, V19.2S, #0.0
    FCMGE  V18.2D, V17.2D, #0.0
    CMLE  V9.2S, V4.2S, #0
    FCMLT  V22.8H, V14.8H, #0.0
    FCMGE  V6.8H, V28.8H, #0.0
    FCMGE  V4.4H, V6.4H, #0.0
    FCMGE  V15.8H, V16.8H, V21.8H
    CMEQ  V13.4S, V5.4S, V18.4S
    FCMLT  V6.2S, V18.2S, #0.0
    FCMGE  V20.4S, V31.4S, V26.4S
    CMGE  V0.8B, V3.8B, #0
    FCMEQ  V25.2D, V0.2D, #0.0
    CMHI  V2.4S, V8.4S, V13.4S
    FCMLE  V18.2S, V11.2S, #0.0
    CMGT  V16.4S, V24.4S, V9.4S
    FCMLE  V28.8H, V19.8H, #0.0
    FCMEQ  V0.2S, V15.2S, #0.0
    FCMGE  V24.2D, V2.2D, V0.2D
    FCMGT  V21.4H, V20.4H, V26.4H
    FCMGE  V3.8H, V8.8H, #0.0
    CMGE  V2.16B, V20.16B, #0
    FCMGT  V11.4H, V26.4H, #0.0
    CMLT  V0.2D, V18.2D, #0
    CMHS  V15.4H, V25.4H, V22.4H
    CMTST  V13.16B, V16.16B, V21.16B
    FCMGT  V5.2D, V24.2D, V6.2D
    FCMGE  V16.2S, V15.2S, #0.0
    FCMGT  V3.2D, V22.2D, #0.0
    FCMGT  V17.4S, V2.4S, V24.4S
    CMGE  V22.2S, V3.2S, V13.2S
    CMGT  V18.8B, V12.8B, V22.8B
    CMGE  V24.2D, V18.2D, V5.2D
    CMLT  V8.8B, V16.8B, #0
    CMGT  V1.2D, V8.2D, #0
    CMEQ  V31.16B, V16.16B, #0
    FCMGT  V26.4H, V28.4H, V1.4H
    SUBS  X29, X29, #0x1
    B.NE  TSRTAdvsimdVectorCompare_label_0
    MOVZ  X11, #0xd2fa, LSL #0
    MOVK  X11, #0x2cf2, LSL #16
    MOVK  X11, #0xb52d, LSL #32
    MOVK  X11, #0xa6e4, LSL #48
    SUB  X2, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X11, #0x4c98, LSL #0
    MOVK  X11, #0x75e3, LSL #16
    MOVK  X11, #0xdc39, LSL #32
    MOVK  X11, #0x2967, LSL #48
    SUB  X2, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X11, #0xee60, LSL #0
    MOVK  X11, #0x5d0a, LSL #16
    MOVK  X11, #0x409b, LSL #32
    MOVK  X11, #0xf94, LSL #48
    SUB  X2, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X11, #0x1287, LSL #0
    MOVK  X11, #0x6e3d, LSL #16
    MOVK  X11, #0x2435, LSL #32
    MOVK  X11, #0xb9fb, LSL #48
    SUB  X2, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X11, #0x7730, LSL #0
    MOVK  X11, #0x6010, LSL #16
    MOVK  X11, #0x7a79, LSL #32
    MOVK  X11, #0xe807, LSL #48
    SUB  X2, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X11, #0xdf28, LSL #0
    MOVK  X11, #0x54cd, LSL #16
    MOVK  X11, #0xa9b5, LSL #32
    MOVK  X11, #0x659c, LSL #48
    SUB  X2, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X11, #0xf4e0, LSL #0
    MOVK  X11, #0xadf9, LSL #16
    MOVK  X11, #0xc201, LSL #32
    MOVK  X11, #0x205a, LSL #48
    SUB  X2, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X11, #0xdd99, LSL #0
    MOVK  X11, #0x76f5, LSL #16
    MOVK  X11, #0xd41a, LSL #32
    MOVK  X11, #0x8379, LSL #48
    SUB  X2, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X11, #0xc3af, LSL #0
    MOVK  X11, #0x240, LSL #16
    MOVK  X11, #0xc67, LSL #32
    MOVK  X11, #0x7393, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X11, #0xe28c, LSL #0
    MOVK  X11, #0xbf76, LSL #16
    MOVK  X11, #0xa451, LSL #32
    MOVK  X11, #0xa693, LSL #48
    SUB  X2, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X11, #0x207, LSL #0
    MOVK  X11, #0x6096, LSL #16
    MOVK  X11, #0xa25b, LSL #32
    MOVK  X11, #0x7bac, LSL #48
    SUB  X2, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X11, #0x7d40, LSL #0
    MOVK  X11, #0x685d, LSL #16
    MOVK  X11, #0x9d95, LSL #32
    MOVK  X11, #0xfd0d, LSL #48
    SUB  X2, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X11, #0x4a37, LSL #0
    MOVK  X11, #0x65c8, LSL #16
    MOVK  X11, #0x2a9e, LSL #32
    MOVK  X11, #0xe1e6, LSL #48
    SUB  X2, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X11, #0xb817, LSL #0
    MOVK  X11, #0x1bcb, LSL #16
    MOVK  X11, #0xad4c, LSL #32
    MOVK  X11, #0xb37f, LSL #48
    SUB  X2, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X11, #0x8de, LSL #0
    MOVK  X11, #0x6a53, LSL #16
    MOVK  X11, #0xe74f, LSL #32
    MOVK  X11, #0xe82c, LSL #48
    SUB  X2, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X11, #0x1174, LSL #0
    MOVK  X11, #0xce7f, LSL #16
    MOVK  X11, #0x73e0, LSL #32
    MOVK  X11, #0x5aeb, LSL #48
    SUB  X2, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X11, #0xf73c, LSL #0
    MOVK  X11, #0x55e7, LSL #16
    MOVK  X11, #0xcfaa, LSL #32
    MOVK  X11, #0x77ad, LSL #48
    SUB  X2, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X11, #0xb9b8, LSL #0
    MOVK  X11, #0x8fd9, LSL #16
    MOVK  X11, #0x504, LSL #32
    MOVK  X11, #0x7d3, LSL #48
    SUB  X2, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X11, #0x8f24, LSL #0
    MOVK  X11, #0x34ce, LSL #16
    MOVK  X11, #0x7576, LSL #32
    MOVK  X11, #0xd7cc, LSL #48
    SUB  X2, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorCompare_TestFail
    MRS  X11, FPSR
    MOVZ  X2, #0x81, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V0.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D0
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V1.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D1
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D2
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D3
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D4
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D5
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D6
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D7
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D8
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D9
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X2, #0xf4e0, LSL #0
    MOVK  X2, #0xadf9, LSL #16
    MOVK  X2, #0xc201, LSL #32
    MOVK  X2, #0x205a, LSL #48
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D10
    MOVZ  X2, #0x1174, LSL #0
    MOVK  X2, #0xce7f, LSL #16
    MOVK  X2, #0x73e0, LSL #32
    MOVK  X2, #0x5aeb, LSL #48
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V11.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D11
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D12
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D13
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D14
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D15
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D16
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D17
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D18
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D19
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D20
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D21
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D22
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D23
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D24
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D25
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D26
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D27
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D28
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D29
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V30.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D30
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, V31.D[1]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X11, D31
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
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
    FMOV  D0, X7
    FMOV  V0.D[1], X16
    FMOV  D1, X26
    FMOV  V1.D[1], X23
    FMOV  D2, X24
    FMOV  V2.D[1], X11
    FMOV  D3, X17
    FMOV  V3.D[1], X12
    FMOV  D4, X13
    FMOV  V4.D[1], X29
    FMOV  D5, X28
    FMOV  V5.D[1], X25
    FMOV  D6, X13
    FMOV  V6.D[1], X11
    FMOV  D7, X6
    FMOV  V7.D[1], X27
    FMOV  D8, X4
    FMOV  V8.D[1], X5
    FMOV  D9, X23
    FMOV  V9.D[1], X17
    FMOV  D10, X9
    FMOV  V10.D[1], X29
    FMOV  D11, X10
    FMOV  V11.D[1], X2
    FMOV  D12, X11
    FMOV  V12.D[1], X12
    FMOV  D13, X5
    FMOV  V13.D[1], X3
    FMOV  D14, X13
    FMOV  V14.D[1], X3
    FMOV  D15, X27
    FMOV  V15.D[1], X27
    FMOV  D16, X3
    FMOV  V16.D[1], X25
    FMOV  D17, X3
    FMOV  V17.D[1], X10
    FMOV  D18, X23
    FMOV  V18.D[1], X29
    FMOV  D19, X28
    FMOV  V19.D[1], X15
    FMOV  D20, X4
    FMOV  V20.D[1], X8
    FMOV  D21, X14
    FMOV  V21.D[1], X28
    FMOV  D22, X10
    FMOV  V22.D[1], X8
    FMOV  D23, X16
    FMOV  V23.D[1], X16
    FMOV  D24, X5
    FMOV  V24.D[1], X12
    FMOV  D25, X29
    FMOV  V25.D[1], X15
    FMOV  D26, X13
    FMOV  V26.D[1], X13
    FMOV  D27, X3
    FMOV  V27.D[1], X14
    FMOV  D28, X10
    FMOV  V28.D[1], X17
    FMOV  D29, X4
    FMOV  V29.D[1], X23
    FMOV  D30, X23
    FMOV  V30.D[1], X23
    FMOV  D31, X3
    FMOV  V31.D[1], X11
    MOVZ  X2, #0xa, LSL #0
TSRTAdvsimdVectorCompare_label_1:
    CMGE  V31.16B, V22.16B, V25.16B
    CMGT  V17.4S, V29.4S, #0
    CMHS  V2.2D, V31.2D, V26.2D
    FCMGT  V25.4S, V2.4S, V20.4S
    FCMGE  V17.2D, V17.2D, V4.2D
    FCMEQ  V0.4S, V14.4S, V3.4S
    CMLE  V30.2S, V28.2S, #0
    FCMGT  V12.4H, V27.4H, #0.0
    FCMGT  V20.2D, V30.2D, #0.0
    FCMEQ  V11.4H, V12.4H, #0.0
    FCMLE  V31.8H, V25.8H, #0.0
    FCMGT  V5.2S, V17.2S, #0.0
    FCMEQ  V28.4H, V20.4H, #0.0
    CMGE  V25.4H, V31.4H, V28.4H
    CMGE  V30.2S, V30.2S, V28.2S
    FCMLT  V14.4H, V11.4H, #0.0
    FCMEQ  V26.2D, V25.2D, V19.2D
    CMHI  V2.8B, V0.8B, V5.8B
    CMEQ  V4.8H, V29.8H, #0
    FCMGE  V7.4S, V26.4S, V27.4S
    FCMEQ  V11.8H, V4.8H, V30.8H
    FCMLT  V30.4S, V11.4S, #0.0
    FCMLT  V12.4H, V14.4H, #0.0
    CMGE  V26.2S, V8.2S, V25.2S
    CMLT  V31.4H, V2.4H, #0
    FCMGT  V14.4H, V31.4H, V26.4H
    FCMGE  V11.2S, V12.2S, #0.0
    CMLE  V29.8B, V0.8B, #0
    FCMGT  V31.2S, V22.2S, V29.2S
    CMHS  V19.2D, V24.2D, V14.2D
    CMTST  V24.8B, V8.8B, V11.8B
    CMEQ  V20.8B, V30.8B, V24.8B
    FCMLT  V0.2D, V0.2D, #0.0
    CMTST  V29.4H, V7.4H, V7.4H
    CMHS  V28.2D, V19.2D, V10.2D
    FCMGT  V5.8H, V22.8H, #0.0
    FCMLT  V14.2S, V28.2S, #0.0
    CMEQ  V2.16B, V11.16B, V30.16B
    FCMGT  V26.2S, V31.2S, #0.0
    CMEQ  V10.2S, V28.2S, V21.2S
    FCMEQ  V28.2D, V2.2D, #0.0
    FCMLE  V11.2S, V0.2S, #0.0
    CMTST  V12.8B, V25.8B, V28.8B
    FCMLT  V21.4H, V22.4H, #0.0
    CMTST  V24.4H, V11.4H, V29.4H
    CMGE  V27.4H, V2.4H, V0.4H
    FCMGE  V7.4S, V0.4S, V27.4S
    CMHI  V25.2D, V21.2D, V26.2D
    CMTST  V7.8H, V25.8H, V5.8H
    FCMGE  V8.2S, V14.2S, V14.2S
    FCMGT  V26.4H, V8.4H, V8.4H
    FCMLE  V22.2D, V20.2D, #0.0
    FCMEQ  V1.2S, V24.2S, V21.2S
    CMHI  V0.16B, V17.16B, V26.16B
    FCMGT  V27.4H, V10.4H, V4.4H
    FCMGT  V4.4H, V12.4H, #0.0
    FCMLT  V17.8H, V22.8H, #0.0
    FCMGT  V21.4H, V20.4H, V0.4H
    CMGT  V0.4S, V4.4S, V17.4S
    CMGT  V12.2D, V1.2D, #0
    FCMEQ  V29.4H, V2.4H, V0.4H
    FCMLE  V6.8H, V6.8H, #0.0
    FCMEQ  V10.4S, V25.4S, V29.4S
    FCMGE  V16.4S, V12.4S, V7.4S
    FCMGT  V1.4H, V23.4H, V8.4H
    FCMLT  V4.8H, V26.8H, #0.0
    FCMGE  V23.4H, V4.4H, #0.0
    CMHS  V24.4S, V24.4S, V10.4S
    CMTST  V22.8B, V6.8B, V7.8B
    FCMGE  V25.4S, V16.4S, #0.0
    CMGT  V31.2S, V7.2S, #0
    FCMLT  V2.4S, V27.4S, #0.0
    CMHI  V4.16B, V31.16B, V11.16B
    FCMLE  V12.2D, V4.2D, #0.0
    FCMGT  V20.8H, V16.8H, #0.0
    FCMEQ  V26.4H, V16.4H, #0.0
    FCMGT  V10.2D, V1.2D, V23.2D
    FCMGT  V7.2D, V10.2D, #0.0
    CMHS  V31.2D, V20.2D, V7.2D
    FCMGT  V19.2S, V22.2S, #0.0
    FCMGT  V29.4H, V26.4H, #0.0
    CMEQ  V20.4S, V29.4S, #0
    FCMLE  V27.4H, V26.4H, #0.0
    CMHS  V6.4H, V2.4H, V24.4H
    FCMEQ  V29.2D, V6.2D, V19.2D
    CMLE  V19.2D, V25.2D, #0
    FCMEQ  V1.8H, V31.8H, #0.0
    CMTST  V7.8H, V1.8H, V28.8H
    CMGE  V22.2S, V20.2S, #0
    CMHS  V8.8B, V10.8B, V25.8B
    FCMGT  V23.4H, V19.4H, #0.0
    CMHS  V25.8B, V23.8B, V8.8B
    CMGE  V4.4H, V1.4H, V12.4H
    CMGT  V26.8H, V13.8H, #0
    FCMGE  V11.2D, V14.2D, V26.2D
    FCMGE  V24.2D, V22.2D, #0.0
    FCMGE  V28.2S, V27.2S, #0.0
    FCMGT  V23.8H, V29.8H, #0.0
    FCMEQ  V19.4S, V11.4S, V11.4S
    FCMGT  V2.4H, V23.4H, V27.4H
    FCMLT  V18.2S, V29.2S, #0.0
    FCMGT  V26.4H, V18.4H, #0.0
    FCMEQ  V11.4H, V0.4H, #0.0
    CMGE  V13.8B, V22.8B, V31.8B
    FCMEQ  V12.4H, V21.4H, V13.4H
    CMHS  V8.4S, V28.4S, V31.4S
    FCMGE  V9.4S, V2.4S, V4.4S
    FCMLT  V0.8H, V4.8H, #0.0
    FCMGE  V31.4H, V28.4H, #0.0
    CMGE  V22.2S, V11.2S, V7.2S
    CMHI  V14.2D, V3.2D, V0.2D
    FCMLE  V7.2S, V19.2S, #0.0
    CMGT  V19.4H, V22.4H, V7.4H
    FCMLE  V28.4H, V15.4H, #0.0
    CMGT  V27.8B, V16.8B, V9.8B
    CMEQ  V0.2S, V4.2S, V19.2S
    CMGE  V2.2S, V23.2S, #0
    FCMGT  V7.2S, V0.2S, V26.2S
    CMTST  V9.16B, V14.16B, V24.16B
    FCMLT  V24.4H, V8.4H, #0.0
    FCMGT  V2.2S, V31.2S, #0.0
    CMLT  V21.8B, V7.8B, #0
    FCMEQ  V31.8H, V21.8H, #0.0
    FCMGE  V25.8H, V26.8H, V28.8H
    FCMGT  V28.4S, V24.4S, #0.0
    FCMGT  V19.4H, V12.4H, V31.4H
    FCMLT  V16.2S, V27.2S, #0.0
    FCMGT  V29.2D, V31.2D, #0.0
    FCMGT  V7.8H, V28.8H, V16.8H
    FCMGE  V18.2S, V29.2S, #0.0
    FCMGT  V3.4H, V19.4H, #0.0
    CMLE  V30.2D, V25.2D, #0
    FCMGE  V12.2S, V2.2S, V20.2S
    FCMLE  V4.8H, V14.8H, #0.0
    FCMLT  V31.4S, V12.4S, #0.0
    FCMGE  V22.2S, V4.2S, V16.2S
    CMLT  V23.8H, V17.8H, #0
    FCMEQ  V15.8H, V22.8H, V2.8H
    FCMGE  V22.2S, V18.2S, V9.2S
    CMEQ  V20.8H, V22.8H, V15.8H
    CMLT  V22.2D, V7.2D, #0
    FCMEQ  V19.2D, V28.2D, #0.0
    CMGT  V9.2S, V19.2S, #0
    FCMLE  V18.4S, V22.4S, #0.0
    CMEQ  V2.8H, V30.8H, V13.8H
    FCMGT  V16.8H, V20.8H, V6.8H
    CMGT  V14.16B, V25.16B, #0
    CMGE  V19.8H, V14.8H, #0
    CMGE  V17.8B, V31.8B, #0
    CMGE  V6.8H, V17.8H, V17.8H
    CMTST  V15.2S, V3.2S, V30.2S
    CMGE  V3.8B, V8.8B, #0
    CMEQ  V7.2S, V18.2S, V16.2S
    CMHS  V26.4H, V21.4H, V23.4H
    CMEQ  V23.4S, V7.4S, V3.4S
    FCMGE  V2.4S, V19.4S, V9.4S
    FCMGT  V28.4H, V21.4H, V6.4H
    FCMEQ  V14.8H, V15.8H, #0.0
    FCMEQ  V30.8H, V26.8H, #0.0
    FCMGT  V17.4H, V18.4H, V23.4H
    FCMLE  V22.4H, V10.4H, #0.0
    CMLE  V3.2S, V21.2S, #0
    FCMGT  V16.4H, V0.4H, V22.4H
    CMHI  V4.4H, V1.4H, V24.4H
    CMGT  V15.16B, V12.16B, #0
    FCMGT  V13.4S, V31.4S, V14.4S
    FCMLT  V20.4H, V21.4H, #0.0
    CMGE  V14.4S, V3.4S, #0
    FCMLE  V10.8H, V2.8H, #0.0
    FCMGE  V1.4H, V13.4H, #0.0
    FCMEQ  V25.8H, V7.8H, V16.8H
    CMEQ  V24.16B, V13.16B, V30.16B
    CMGT  V16.2D, V9.2D, #0
    FCMGT  V12.8H, V25.8H, V4.8H
    FCMGT  V6.4H, V15.4H, #0.0
    FCMGT  V22.4H, V5.4H, #0.0
    FCMEQ  V9.4H, V10.4H, V28.4H
    CMEQ  V7.2D, V16.2D, V30.2D
    CMGE  V30.4H, V6.4H, #0
    FCMGE  V15.4H, V12.4H, V17.4H
    FCMLE  V19.8H, V24.8H, #0.0
    CMTST  V0.2D, V12.2D, V29.2D
    CMEQ  V21.4H, V7.4H, V20.4H
    FCMLT  V12.4H, V1.4H, #0.0
    FCMLE  V17.4H, V24.4H, #0.0
    CMHS  V3.2S, V14.2S, V15.2S
    CMHS  V17.2D, V27.2D, V22.2D
    CMLE  V29.8H, V3.8H, #0
    FCMGE  V27.8H, V30.8H, V30.8H
    CMLT  V6.8B, V29.8B, #0
    FCMLT  V5.2S, V9.2S, #0.0
    CMLT  V8.4H, V26.4H, #0
    FCMGT  V28.8H, V5.8H, #0.0
    FCMGT  V30.4S, V6.4S, #0.0
    FCMLE  V3.8H, V0.8H, #0.0
    FCMGT  V24.4H, V28.4H, V27.4H
    FCMLT  V10.4S, V8.4S, #0.0
    CMLT  V20.16B, V1.16B, #0
    FCMEQ  V26.4H, V30.4H, V30.4H
    FCMLT  V15.2S, V10.2S, #0.0
    SUBS  X2, X2, #0x1
    B.NE  TSRTAdvsimdVectorCompare_label_1
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MRS  X4, FPSR
    MOVZ  X14, #0x81, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V0.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D0
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V1.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D1
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D2
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D3
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V4.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D4
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V5.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D5
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D6
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V7.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D7
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V8.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D8
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D9
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D10
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D11
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D12
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V13.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D13
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V14.D[1]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D14
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D15
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D16
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V17.D[1]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D17
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D18
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V19.D[1]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D19
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D20
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D21
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V22.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D22
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D23
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V24.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D24
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V25.D[1]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D25
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V26.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D26
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D27
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V28.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D28
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V29.D[1]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D29
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V30.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D30
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V31.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D31
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
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
    FMOV  D0, X24
    FMOV  V0.D[1], X26
    FMOV  D1, X2
    FMOV  V1.D[1], X28
    FMOV  D2, X29
    FMOV  V2.D[1], X3
    FMOV  D3, X15
    FMOV  V3.D[1], X7
    FMOV  D4, X14
    FMOV  V4.D[1], X13
    FMOV  D5, X27
    FMOV  V5.D[1], X17
    FMOV  D6, X3
    FMOV  V6.D[1], X15
    FMOV  D7, X9
    FMOV  V7.D[1], X29
    FMOV  D8, X10
    FMOV  V8.D[1], X3
    FMOV  D9, X15
    FMOV  V9.D[1], X17
    FMOV  D10, X12
    FMOV  V10.D[1], X29
    FMOV  D11, X11
    FMOV  V11.D[1], X24
    FMOV  D12, X17
    FMOV  V12.D[1], X5
    FMOV  D13, X8
    FMOV  V13.D[1], X24
    FMOV  D14, X11
    FMOV  V14.D[1], X23
    FMOV  D15, X16
    FMOV  V15.D[1], X12
    FMOV  D16, X24
    FMOV  V16.D[1], X7
    FMOV  D17, X6
    FMOV  V17.D[1], X10
    FMOV  D18, X27
    FMOV  V18.D[1], X17
    FMOV  D19, X4
    FMOV  V19.D[1], X9
    FMOV  D20, X16
    FMOV  V20.D[1], X24
    FMOV  D21, X4
    FMOV  V21.D[1], X17
    FMOV  D22, X17
    FMOV  V22.D[1], X4
    FMOV  D23, X11
    FMOV  V23.D[1], X25
    FMOV  D24, X15
    FMOV  V24.D[1], X25
    FMOV  D25, X7
    FMOV  V25.D[1], X11
    FMOV  D26, X17
    FMOV  V26.D[1], X6
    FMOV  D27, X28
    FMOV  V27.D[1], X26
    FMOV  D28, X17
    FMOV  V28.D[1], X14
    FMOV  D29, X24
    FMOV  V29.D[1], X14
    FMOV  D30, X7
    FMOV  V30.D[1], X6
    FMOV  D31, X7
    FMOV  V31.D[1], X6
    MOVZ  X29, #0xa, LSL #0
TSRTAdvsimdVectorCompare_label_2:
    CMLT  V21.2S, V31.2S, #0
    CMGT  V19.8H, V21.8H, #0
    CMEQ  V2.4S, V24.4S, V18.4S
    FCMLT  V26.2S, V21.2S, #0.0
    CMGE  V14.8H, V28.8H, V29.8H
    FCMGE  V8.4S, V23.4S, #0.0
    FCMEQ  V31.2S, V27.2S, #0.0
    FCMEQ  V1.4S, V19.4S, V8.4S
    FCMLE  V4.2S, V14.2S, #0.0
    CMGE  V0.4S, V22.4S, V2.4S
    FCMGT  V14.2S, V30.2S, V5.2S
    FCMLE  V22.2D, V4.2D, #0.0
    FCMGT  V19.2S, V1.2S, #0.0
    CMEQ  V6.8H, V2.8H, #0
    FCMGT  V11.8H, V14.8H, #0.0
    CMGE  V7.2D, V31.2D, #0
    CMHS  V2.16B, V6.16B, V6.16B
    FCMLT  V4.2D, V12.2D, #0.0
    FCMGT  V12.8H, V15.8H, #0.0
    FCMGE  V6.2S, V0.2S, #0.0
    FCMGE  V3.4H, V26.4H, #0.0
    FCMEQ  V15.4S, V7.4S, V4.4S
    CMHI  V0.16B, V12.16B, V8.16B
    FCMGT  V12.2S, V0.2S, V15.2S
    FCMGE  V5.2S, V2.2S, V29.2S
    FCMLT  V0.2S, V12.2S, #0.0
    CMHS  V7.2D, V5.2D, V11.2D
    FCMLE  V21.4H, V27.4H, #0.0
    FCMLT  V30.2S, V3.2S, #0.0
    CMEQ  V13.2S, V10.2S, V0.2S
    CMTST  V9.2D, V19.2D, V30.2D
    CMGE  V8.4S, V22.4S, #0
    CMHS  V4.4S, V10.4S, V29.4S
    FCMLT  V3.8H, V8.8H, #0.0
    CMGT  V10.16B, V22.16B, V9.16B
    CMGE  V0.16B, V14.16B, #0
    FCMGT  V29.8H, V3.8H, #0.0
    FCMLE  V12.2D, V18.2D, #0.0
    CMEQ  V30.16B, V4.16B, #0
    FCMLT  V26.8H, V30.8H, #0.0
    CMGT  V27.2D, V29.2D, #0
    FCMLE  V14.2S, V26.2S, #0.0
    FCMGE  V31.4H, V13.4H, #0.0
    FCMGT  V3.4S, V0.4S, #0.0
    FCMGE  V2.4H, V14.4H, #0.0
    FCMGE  V18.4H, V23.4H, V10.4H
    CMLT  V13.16B, V27.16B, #0
    FCMLT  V8.4H, V31.4H, #0.0
    FCMGE  V10.4S, V2.4S, V11.4S
    FCMGE  V14.2D, V18.2D, V12.2D
    CMTST  V12.8B, V6.8B, V8.8B
    FCMLE  V23.4S, V3.4S, #0.0
    FCMLT  V29.2D, V14.2D, #0.0
    FCMLT  V18.8H, V22.8H, #0.0
    FCMGT  V14.2S, V12.2S, V13.2S
    CMTST  V30.4H, V23.4H, V27.4H
    CMGT  V5.16B, V30.16B, #0
    CMTST  V16.2S, V10.2S, V12.2S
    CMLE  V30.4S, V7.4S, #0
    FCMEQ  V2.2D, V29.2D, #0.0
    CMTST  V6.4H, V2.4H, V14.4H
    CMHS  V8.4S, V23.4S, V19.4S
    CMGE  V14.2S, V30.2S, V18.2S
    CMLE  V13.8B, V2.8B, #0
    FCMLE  V7.2S, V6.2S, #0.0
    CMHS  V19.16B, V13.16B, V7.16B
    FCMLE  V10.4S, V16.4S, #0.0
    FCMGT  V9.8H, V15.8H, #0.0
    FCMGT  V12.8H, V14.8H, #0.0
    FCMGE  V22.8H, V5.8H, #0.0
    FCMEQ  V7.4S, V9.4S, #0.0
    FCMGE  V4.8H, V7.8H, V29.8H
    FCMEQ  V3.8H, V3.8H, V4.8H
    CMHI  V15.4S, V29.4S, V19.4S
    FCMEQ  V5.8H, V3.8H, V20.8H
    FCMGT  V30.4H, V8.4H, #0.0
    FCMGT  V22.2D, V15.2D, #0.0
    FCMGE  V16.8H, V5.8H, V31.8H
    FCMEQ  V7.2D, V30.2D, V10.2D
    FCMEQ  V31.4H, V31.4H, #0.0
    FCMGE  V6.2S, V7.2S, V19.2S
    CMGE  V9.4S, V12.4S, #0
    FCMEQ  V29.8H, V14.8H, V16.8H
    CMGT  V23.4H, V13.4H, #0
    FCMEQ  V8.4S, V23.4S, #0.0
    CMHI  V20.8H, V31.8H, V22.8H
    CMTST  V28.4H, V8.4H, V30.4H
    FCMGE  V2.2S, V22.2S, #0.0
    CMGE  V5.2S, V20.2S, #0
    FCMLT  V12.4S, V6.4S, #0.0
    FCMGE  V23.8H, V12.8H, #0.0
    FCMGT  V3.2D, V7.2D, #0.0
    FCMGE  V19.8H, V5.8H, V2.8H
    FCMGE  V20.8H, V12.8H, #0.0
    CMEQ  V8.8B, V3.8B, #0
    FCMGE  V7.8H, V8.8H, #0.0
    CMGT  V2.4S, V10.4S, #0
    CMGE  V14.4S, V13.4S, #0
    CMLT  V13.4S, V13.4S, #0
    FCMEQ  V30.4S, V10.4S, #0.0
    FCMLT  V30.4H, V30.4H, #0.0
    CMEQ  V12.4H, V14.4H, V23.4H
    FCMGE  V6.2S, V20.2S, #0.0
    CMGE  V26.2D, V29.2D, V31.2D
    CMLE  V24.4S, V31.4S, #0
    FCMEQ  V23.2S, V19.2S, V30.2S
    CMHI  V5.4H, V6.4H, V4.4H
    CMLT  V30.8H, V23.8H, #0
    FCMGE  V8.2S, V3.2S, V26.2S
    FCMGT  V29.2S, V8.2S, V0.2S
    CMGE  V31.2D, V7.2D, #0
    FCMEQ  V26.8H, V24.8H, #0.0
    CMGT  V10.2S, V17.2S, V4.2S
    FCMEQ  V17.8H, V31.8H, #0.0
    CMGE  V11.8H, V2.8H, #0
    FCMGE  V24.2D, V11.2D, #0.0
    CMEQ  V22.2D, V24.2D, #0
    FCMGT  V20.2S, V26.2S, #0.0
    CMLE  V4.2S, V17.2S, #0
    FCMGE  V24.8H, V10.8H, #0.0
    CMLT  V8.4S, V16.4S, #0
    CMGE  V19.4S, V20.4S, #0
    FCMGT  V23.2S, V14.2S, V19.2S
    CMHS  V0.4H, V24.4H, V22.4H
    FCMGE  V17.4S, V12.4S, V26.4S
    CMEQ  V6.2S, V29.2S, #0
    FCMEQ  V2.2S, V4.2S, V23.2S
    FCMLE  V26.2S, V2.2S, #0.0
    FCMGE  V10.4H, V5.4H, #0.0
    CMGT  V12.16B, V26.16B, #0
    CMGT  V29.2D, V6.2D, #0
    CMHS  V4.2S, V10.2S, V30.2S
    CMGE  V31.4H, V9.4H, #0
    FCMLE  V16.8H, V31.8H, #0.0
    FCMGE  V21.4S, V27.4S, V4.4S
    CMHS  V24.8H, V10.8H, V21.8H
    CMLE  V11.16B, V0.16B, #0
    CMEQ  V30.4S, V20.4S, #0
    CMLT  V15.4S, V1.4S, #0
    FCMLT  V10.8H, V12.8H, #0.0
    FCMGT  V16.4S, V17.4S, V16.4S
    FCMGT  V12.2S, V24.2S, V28.2S
    CMTST  V14.4S, V0.4S, V10.4S
    CMGT  V18.4H, V12.4H, V4.4H
    FCMGE  V0.4S, V18.4S, V8.4S
    CMLE  V19.8H, V1.8H, #0
    CMGT  V8.16B, V18.16B, #0
    FCMGE  V21.2S, V18.2S, #0.0
    CMGE  V17.8B, V21.8B, #0
    CMLE  V5.8B, V4.8B, #0
    FCMLE  V24.4H, V17.4H, #0.0
    CMGT  V23.4S, V19.4S, #0
    FCMGE  V19.4H, V16.4H, #0.0
    FCMEQ  V21.4H, V30.4H, V30.4H
    FCMLT  V4.8H, V8.8H, #0.0
    CMEQ  V30.4H, V29.4H, V4.4H
    CMLE  V19.16B, V23.16B, #0
    FCMGT  V20.2D, V9.2D, #0.0
    CMGE  V2.16B, V0.16B, V0.16B
    CMHI  V16.8B, V21.8B, V20.8B
    FCMLT  V20.4S, V30.4S, #0.0
    FCMEQ  V31.8H, V22.8H, #0.0
    FCMEQ  V10.4S, V2.4S, #0.0
    FCMGT  V18.2D, V11.2D, V24.2D
    CMGE  V24.2D, V12.2D, #0
    FCMGE  V22.2D, V27.2D, #0.0
    CMGT  V30.4H, V16.4H, #0
    CMGE  V2.8H, V10.8H, #0
    FCMGT  V1.4H, V2.4H, V20.4H
    FCMLT  V9.4H, V30.4H, #0.0
    CMTST  V29.8H, V9.8H, V19.8H
    FCMGE  V9.2D, V26.2D, V1.2D
    FCMGE  V16.2D, V9.2D, V11.2D
    FCMGE  V23.2D, V24.2D, #0.0
    CMGE  V27.8H, V18.8H, V9.8H
    FCMLE  V22.8H, V29.8H, #0.0
    FCMGT  V11.8H, V20.8H, V25.8H
    FCMEQ  V26.8H, V22.8H, #0.0
    FCMGE  V13.8H, V16.8H, V16.8H
    FCMLT  V29.4H, V26.4H, #0.0
    CMEQ  V21.2S, V27.2S, V13.2S
    FCMGT  V24.4S, V11.4S, V11.4S
    CMLE  V30.8B, V27.8B, #0
    CMEQ  V2.2S, V11.2S, V23.2S
    CMHS  V27.16B, V20.16B, V14.16B
    FCMGT  V11.2S, V27.2S, V9.2S
    FCMEQ  V20.4S, V2.4S, V13.4S
    FCMLE  V14.2D, V21.2D, #0.0
    CMLE  V19.4H, V30.4H, #0
    FCMLE  V18.2S, V20.2S, #0.0
    FCMLT  V10.4H, V18.4H, #0.0
    FCMLT  V25.4S, V5.4S, #0.0
    CMHS  V27.16B, V29.16B, V10.16B
    CMEQ  V24.4H, V19.4H, V30.4H
    CMLE  V22.16B, V25.16B, #0
    FCMEQ  V1.2D, V14.2D, #0.0
    CMEQ  V5.2S, V4.2S, #0
    FCMEQ  V1.4H, V24.4H, #0.0
    FCMGE  V26.2D, V19.2D, #0.0
    FCMGE  V16.2S, V9.2S, #0.0
    SUBS  X29, X29, #0x1
    B.NE  TSRTAdvsimdVectorCompare_label_2
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    MRS  X23, FPSR
    MOVZ  X3, #0x81, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V0.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D0
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V1.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D1
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D2
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D3
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D4
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D5
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D6
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D7
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D8
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D9
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D10
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D11
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D12
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D13
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D14
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D15
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D16
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D17
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D18
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D19
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D20
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D21
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D22
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V23.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D23
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D24
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D25
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D26
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D27
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D28
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D29
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V30.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D30
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V31.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D31
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
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
    FMOV  D0, X27
    FMOV  V0.D[1], X28
    FMOV  D1, X16
    FMOV  V1.D[1], X9
    FMOV  D2, X29
    FMOV  V2.D[1], X27
    FMOV  D3, X26
    FMOV  V3.D[1], X29
    FMOV  D4, X25
    FMOV  V4.D[1], X25
    FMOV  D5, X23
    FMOV  V5.D[1], X17
    FMOV  D6, X27
    FMOV  V6.D[1], X8
    FMOV  D7, X8
    FMOV  V7.D[1], X2
    FMOV  D8, X14
    FMOV  V8.D[1], X29
    FMOV  D9, X28
    FMOV  V9.D[1], X3
    FMOV  D10, X4
    FMOV  V10.D[1], X5
    FMOV  D11, X25
    FMOV  V11.D[1], X24
    FMOV  D12, X15
    FMOV  V12.D[1], X9
    FMOV  D13, X27
    FMOV  V13.D[1], X5
    FMOV  D14, X4
    FMOV  V14.D[1], X4
    FMOV  D15, X29
    FMOV  V15.D[1], X7
    FMOV  D16, X13
    FMOV  V16.D[1], X28
    FMOV  D17, X17
    FMOV  V17.D[1], X4
    FMOV  D18, X14
    FMOV  V18.D[1], X26
    FMOV  D19, X14
    FMOV  V19.D[1], X17
    FMOV  D20, X15
    FMOV  V20.D[1], X26
    FMOV  D21, X3
    FMOV  V21.D[1], X9
    FMOV  D22, X8
    FMOV  V22.D[1], X23
    FMOV  D23, X5
    FMOV  V23.D[1], X12
    FMOV  D24, X17
    FMOV  V24.D[1], X4
    FMOV  D25, X6
    FMOV  V25.D[1], X3
    FMOV  D26, X27
    FMOV  V26.D[1], X16
    FMOV  D27, X13
    FMOV  V27.D[1], X23
    FMOV  D28, X2
    FMOV  V28.D[1], X27
    FMOV  D29, X2
    FMOV  V29.D[1], X3
    FMOV  D30, X3
    FMOV  V30.D[1], X9
    FMOV  D31, X26
    FMOV  V31.D[1], X2
    MOVZ  X23, #0xa, LSL #0
TSRTAdvsimdVectorCompare_label_3:
    FCMGT  V4.4H, V23.4H, V30.4H
    FCMGT  V21.4H, V26.4H, V24.4H
    FCMGE  V27.4H, V25.4H, V4.4H
    FCMEQ  V25.8H, V16.8H, #0.0
    CMHI  V31.4S, V31.4S, V27.4S
    CMGE  V3.8H, V29.8H, V28.8H
    FCMGE  V1.4S, V3.4S, V21.4S
    CMGT  V17.8H, V17.8H, V31.8H
    CMHI  V7.4S, V17.4S, V29.4S
    FCMEQ  V19.4H, V7.4H, #0.0
    FCMEQ  V31.4H, V3.4H, #0.0
    FCMEQ  V7.8H, V19.8H, V3.8H
    FCMLE  V29.4S, V7.4S, #0.0
    CMGT  V24.2D, V25.2D, #0
    FCMLE  V16.8H, V1.8H, #0.0
    CMGT  V1.2D, V10.2D, V19.2D
    FCMLT  V25.2D, V1.2D, #0.0
    FCMLE  V5.2S, V20.2S, #0.0
    FCMGT  V10.4S, V24.4S, #0.0
    FCMGT  V5.8H, V5.8H, #0.0
    CMTST  V6.8B, V24.8B, V13.8B
    FCMGT  V3.2S, V18.2S, V10.2S
    CMLT  V10.4S, V30.4S, #0
    FCMGT  V19.8H, V30.8H, #0.0
    FCMGE  V7.8H, V17.8H, #0.0
    CMHS  V1.2D, V10.2D, V31.2D
    FCMGT  V28.2S, V1.2S, V3.2S
    FCMGT  V13.4S, V30.4S, #0.0
    CMGE  V20.4S, V25.4S, V13.4S
    FCMGT  V18.4S, V5.4S, #0.0
    FCMGT  V1.8H, V7.8H, V18.8H
    CMEQ  V26.8H, V28.8H, #0
    CMHI  V25.4S, V10.4S, V5.4S
    CMGT  V28.2S, V26.2S, V13.2S
    FCMGT  V3.4H, V8.4H, #0.0
    CMHI  V12.2D, V18.2D, V6.2D
    FCMEQ  V24.4H, V3.4H, #0.0
    CMGT  V5.8B, V28.8B, #0
    FCMGT  V7.4H, V12.4H, #0.0
    CMHS  V18.4H, V5.4H, V19.4H
    FCMEQ  V30.4H, V2.4H, V7.4H
    FCMGT  V0.2S, V8.2S, V2.2S
    FCMGE  V10.4H, V30.4H, #0.0
    CMGT  V25.4H, V1.4H, V30.4H
    FCMEQ  V26.8H, V0.8H, #0.0
    CMGT  V8.8B, V29.8B, V26.8B
    FCMLT  V29.8H, V20.8H, #0.0
    CMTST  V26.4S, V0.4S, V10.4S
    FCMGE  V3.2S, V5.2S, #0.0
    FCMGT  V25.4H, V30.4H, V17.4H
    FCMEQ  V10.2S, V26.2S, #0.0
    CMEQ  V0.4H, V3.4H, #0
    FCMGE  V12.4S, V29.4S, V10.4S
    FCMGT  V31.4H, V8.4H, #0.0
    FCMLE  V20.4H, V12.4H, #0.0
    CMHI  V21.2D, V20.2D, V31.2D
    CMLE  V26.2D, V0.2D, #0
    FCMEQ  V8.2S, V25.2S, #0.0
    FCMGE  V21.8H, V17.8H, V5.8H
    CMHI  V19.2S, V29.2S, V21.2S
    FCMGT  V0.4S, V26.4S, V18.4S
    FCMEQ  V10.2S, V24.2S, #0.0
    FCMGT  V20.2D, V8.2D, V19.2D
    FCMLT  V3.2S, V12.2S, #0.0
    CMLE  V16.8B, V20.8B, #0
    CMGT  V12.16B, V30.16B, V10.16B
    FCMGE  V29.2D, V8.2D, #0.0
    CMGT  V18.4S, V30.4S, #0
    FCMEQ  V21.4H, V0.4H, #0.0
    CMHI  V24.2D, V27.2D, V18.2D
    FCMGE  V26.4S, V21.4S, V10.4S
    CMGT  V13.2S, V3.2S, V9.2S
    FCMGT  V18.8H, V13.8H, #0.0
    FCMEQ  V25.4H, V3.4H, #0.0
    FCMEQ  V12.8H, V24.8H, #0.0
    CMGT  V17.4H, V12.4H, V6.4H
    FCMGE  V31.2S, V16.2S, V26.2S
    FCMGT  V20.2S, V14.2S, V23.2S
    FCMLE  V29.8H, V16.8H, #0.0
    FCMLE  V0.2D, V17.2D, #0.0
    FCMLT  V10.2S, V0.2S, #0.0
    CMTST  V3.8B, V20.8B, V21.8B
    CMGT  V21.2S, V25.2S, #0
    CMGT  V26.8B, V21.8B, V18.8B
    FCMEQ  V17.8H, V15.8H, #0.0
    FCMGT  V8.2S, V1.2S, V3.2S
    CMGT  V14.4S, V26.4S, #0
    FCMEQ  V6.4H, V20.4H, V31.4H
    CMHI  V30.4S, V11.4S, V17.4S
    FCMLT  V23.8H, V8.8H, #0.0
    CMLT  V12.2D, V6.2D, #0
    FCMGT  V26.4H, V15.4H, V17.4H
    FCMGT  V16.4S, V30.4S, V12.4S
    CMGT  V31.4H, V23.4H, #0
    FCMLE  V20.2D, V15.2D, #0.0
    FCMGE  V0.8H, V26.8H, #0.0
    CMEQ  V1.16B, V29.16B, #0
    CMGT  V18.8B, V16.8B, V0.8B
    CMEQ  V25.2D, V13.2D, #0
    FCMGT  V15.4H, V1.4H, #0.0
    CMLE  V0.4S, V16.4S, #0
    CMGE  V6.4S, V20.4S, V10.4S
    FCMLT  V23.8H, V8.8H, #0.0
    CMHS  V13.16B, V18.16B, V0.16B
    FCMLT  V29.4S, V26.4S, #0.0
    FCMGE  V21.8H, V31.8H, #0.0
    CMHS  V11.4S, V27.4S, V21.4S
    FCMLT  V30.4H, V25.4H, #0.0
    FCMGT  V8.8H, V15.8H, #0.0
    FCMGE  V12.4H, V23.4H, V6.4H
    FCMEQ  V6.4H, V13.4H, #0.0
    FCMGE  V1.4H, V1.4H, #0.0
    CMGT  V17.8B, V30.8B, #0
    FCMGT  V3.8H, V16.8H, #0.0
    CMLT  V30.8H, V12.8H, #0
    FCMEQ  V16.8H, V8.8H, V14.8H
    FCMEQ  V15.4H, V30.4H, #0.0
    FCMGE  V16.8H, V18.8H, V30.8H
    FCMGE  V31.2D, V29.2D, V4.2D
    CMGT  V12.2S, V17.2S, #0
    FCMGT  V22.8H, V3.8H, #0.0
    CMHS  V27.2S, V6.2S, V15.2S
    CMGT  V25.2S, V1.2S, V16.2S
    FCMGT  V3.2D, V25.2D, #0.0
    FCMGE  V15.2D, V23.2D, #0.0
    FCMEQ  V6.8H, V27.8H, V14.8H
    FCMEQ  V8.4H, V15.4H, #0.0
    CMGE  V29.4H, V12.4H, V19.4H
    FCMLE  V1.2D, V22.2D, #0.0
    FCMGT  V20.8H, V1.8H, V31.8H
    FCMEQ  V23.4H, V29.4H, #0.0
    FCMGE  V23.8H, V20.8H, V8.8H
    FCMEQ  V27.8H, V8.8H, #0.0
    FCMGT  V20.4S, V27.4S, V3.4S
    FCMEQ  V25.8H, V20.8H, #0.0
    FCMLE  V21.2D, V23.2D, #0.0
    CMHI  V14.4S, V6.4S, V22.4S
    FCMLT  V15.2D, V14.2D, #0.0
    FCMEQ  V29.2S, V21.2S, V25.2S
    CMEQ  V21.16B, V27.16B, V22.16B
    FCMGE  V25.4H, V28.4H, V22.4H
    CMLE  V19.4S, V26.4S, #0
    CMHI  V14.8H, V22.8H, V11.8H
    FCMGT  V31.4S, V16.4S, #0.0
    FCMGT  V16.8H, V20.8H, #0.0
    FCMEQ  V28.4H, V7.4H, #0.0
    FCMGT  V8.8H, V21.8H, V23.8H
    CMLT  V3.2S, V25.2S, #0
    FCMEQ  V16.8H, V8.8H, #0.0
    FCMLT  V29.4H, V25.4H, #0.0
    FCMEQ  V28.4H, V16.4H, #0.0
    FCMLT  V1.8H, V28.8H, #0.0
    FCMEQ  V20.8H, V0.8H, #0.0
    FCMLT  V21.4H, V29.4H, #0.0
    CMLT  V13.2S, V15.2S, #0
    CMGE  V7.16B, V11.16B, V20.16B
    FCMGT  V14.4S, V21.4S, V13.4S
    FCMGE  V8.2S, V1.2S, #0.0
    FCMGE  V23.4S, V8.4S, #0.0
    FCMLE  V21.2D, V19.2D, #0.0
    CMGE  V7.8B, V8.8B, V3.8B
    CMLE  V11.4H, V21.4H, #0
    FCMLE  V27.4S, V23.4S, #0.0
    CMHI  V1.4S, V11.4S, V11.4S
    CMHS  V29.8B, V27.8B, V1.8B
    FCMGT  V16.8H, V14.8H, V4.8H
    FCMEQ  V11.4S, V16.4S, V29.4S
    FCMGT  V28.8H, V31.8H, V26.8H
    CMHS  V0.4H, V11.4H, V11.4H
    CMGE  V19.8H, V28.8H, #0
    FCMLE  V21.8H, V0.8H, #0.0
    FCMGT  V26.4S, V19.4S, V14.4S
    CMGE  V15.16B, V26.16B, V21.16B
    CMLT  V19.8B, V9.8B, #0
    FCMGE  V26.2D, V21.2D, #0.0
    FCMGE  V1.4H, V1.4H, V14.4H
    FCMGT  V16.4H, V3.4H, V26.4H
    FCMEQ  V21.8H, V16.8H, #0.0
    FCMGT  V20.4S, V28.4S, #0.0
    CMGT  V3.2D, V20.2D, V22.2D
    FCMEQ  V0.8H, V8.8H, #0.0
    FCMLT  V28.2S, V22.2S, #0.0
    FCMEQ  V31.2D, V29.2D, #0.0
    CMGT  V20.8B, V28.8B, V16.8B
    CMHI  V8.4S, V0.4S, V15.4S
    FCMGE  V17.4H, V21.4H, #0.0
    FCMGE  V20.4H, V16.4H, #0.0
    FCMGE  V29.2D, V27.2D, V31.2D
    CMGT  V16.8H, V19.8H, V3.8H
    FCMEQ  V5.8H, V27.8H, V29.8H
    FCMEQ  V0.2D, V20.2D, #0.0
    CMHS  V26.2D, V5.2D, V0.2D
    FCMGT  V31.4H, V26.4H, V16.4H
    FCMEQ  V20.8H, V17.8H, #0.0
    FCMLT  V28.8H, V8.8H, #0.0
    FCMEQ  V2.8H, V3.8H, V26.8H
    FCMGE  V0.2D, V2.2D, #0.0
    FCMLT  V9.4H, V8.4H, #0.0
    CMHS  V22.2S, V0.2S, V10.2S
    FCMGE  V2.2S, V9.2S, #0.0
    SUBS  X23, X23, #0x1
    B.NE  TSRTAdvsimdVectorCompare_label_3
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X29, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X29, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X29, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X29, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X29, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X29, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X29, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X29, X7, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X29, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X29, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X29, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X29, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X29, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X29, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X29, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X29, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X29, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X29, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X29, X7, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MRS  X7, FPSR
    MOVZ  X29, #0x81, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V0.D[1]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D0
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V1.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D1
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V2.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D2
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D3
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D4
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D5
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D6
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D7
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D8
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D9
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D10
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D11
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D12
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D13
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D14
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D15
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V16.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D16
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V17.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D17
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V18.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D18
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D19
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D20
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D21
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V22.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D22
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V23.D[1]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D23
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V24.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D24
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D25
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V26.D[1]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D26
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D27
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D28
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D29
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V30.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D30
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, V31.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X7, D31
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorCompare_TestFail
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
    FMOV  D0, X3
    FMOV  V0.D[1], X27
    FMOV  D1, X27
    FMOV  V1.D[1], X5
    FMOV  D2, X26
    FMOV  V2.D[1], X24
    FMOV  D3, X7
    FMOV  V3.D[1], X29
    FMOV  D4, X28
    FMOV  V4.D[1], X7
    FMOV  D5, X27
    FMOV  V5.D[1], X2
    FMOV  D6, X3
    FMOV  V6.D[1], X9
    FMOV  D7, X29
    FMOV  V7.D[1], X8
    FMOV  D8, X27
    FMOV  V8.D[1], X11
    FMOV  D9, X29
    FMOV  V9.D[1], X17
    FMOV  D10, X15
    FMOV  V10.D[1], X3
    FMOV  D11, X6
    FMOV  V11.D[1], X10
    FMOV  D12, X7
    FMOV  V12.D[1], X24
    FMOV  D13, X28
    FMOV  V13.D[1], X16
    FMOV  D14, X10
    FMOV  V14.D[1], X3
    FMOV  D15, X6
    FMOV  V15.D[1], X7
    FMOV  D16, X10
    FMOV  V16.D[1], X9
    FMOV  D17, X9
    FMOV  V17.D[1], X5
    FMOV  D18, X26
    FMOV  V18.D[1], X23
    FMOV  D19, X24
    FMOV  V19.D[1], X13
    FMOV  D20, X11
    FMOV  V20.D[1], X27
    FMOV  D21, X10
    FMOV  V21.D[1], X14
    FMOV  D22, X23
    FMOV  V22.D[1], X25
    FMOV  D23, X9
    FMOV  V23.D[1], X6
    FMOV  D24, X24
    FMOV  V24.D[1], X25
    FMOV  D25, X10
    FMOV  V25.D[1], X23
    FMOV  D26, X12
    FMOV  V26.D[1], X9
    FMOV  D27, X16
    FMOV  V27.D[1], X25
    FMOV  D28, X14
    FMOV  V28.D[1], X8
    FMOV  D29, X16
    FMOV  V29.D[1], X13
    FMOV  D30, X9
    FMOV  V30.D[1], X11
    FMOV  D31, X6
    FMOV  V31.D[1], X23
    MOVZ  X27, #0xa, LSL #0
TSRTAdvsimdVectorCompare_label_4:
    FCMLT  V5.4H, V25.4H, #0.0
    CMLT  V20.8B, V13.8B, #0
    FCMEQ  V13.4S, V5.4S, V23.4S
    CMGT  V5.16B, V21.16B, #0
    CMGT  V3.16B, V5.16B, #0
    FCMLT  V16.2D, V13.2D, #0.0
    CMTST  V13.4S, V27.4S, V30.4S
    FCMGE  V16.8H, V24.8H, V31.8H
    FCMGE  V29.4H, V3.4H, #0.0
    CMLT  V28.2D, V16.2D, #0
    FCMEQ  V5.2S, V20.2S, V13.2S
    FCMEQ  V19.8H, V5.8H, #0.0
    CMEQ  V2.4H, V0.4H, #0
    FCMGT  V26.4H, V28.4H, #0.0
    CMGE  V3.2S, V11.2S, #0
    CMGT  V21.2S, V0.2S, V24.2S
    CMLE  V13.8H, V13.8H, #0
    CMTST  V31.4H, V29.4H, V29.4H
    FCMLE  V5.2D, V21.2D, #0.0
    CMHS  V11.8B, V5.8B, V13.8B
    CMGE  V30.2S, V3.2S, #0
    CMEQ  V15.2D, V11.2D, V26.2D
    CMGT  V28.16B, V15.16B, V15.16B
    FCMGE  V16.4H, V28.4H, V23.4H
    FCMLT  V2.4S, V0.4S, #0.0
    FCMGE  V11.4H, V2.4H, V16.4H
    FCMEQ  V2.4S, V2.4S, #0.0
    FCMEQ  V13.4S, V2.4S, #0.0
    FCMGE  V24.2D, V22.2D, #0.0
    FCMEQ  V23.4S, V17.4S, V19.4S
    FCMGE  V15.4H, V30.4H, V1.4H
    FCMGE  V1.2S, V13.2S, #0.0
    FCMEQ  V16.8H, V24.8H, V5.8H
    CMHS  V22.4S, V16.4S, V31.4S
    CMGE  V30.4S, V9.4S, #0
    FCMLT  V2.2S, V5.2S, #0.0
    CMEQ  V31.8H, V26.8H, #0
    CMLE  V11.2S, V16.2S, #0
    FCMLE  V28.4S, V19.4S, #0.0
    CMGE  V2.8H, V15.8H, V30.8H
    CMGE  V3.8B, V28.8B, #0
    CMLT  V17.4S, V3.4S, #0
    CMTST  V0.8B, V11.8B, V17.8B
    CMHI  V15.16B, V17.16B, V2.16B
    CMLT  V19.4S, V23.4S, #0
    FCMGE  V30.8H, V4.8H, V31.8H
    FCMEQ  V28.4S, V1.4S, #0.0
    CMHI  V1.8B, V19.8B, V0.8B
    FCMEQ  V30.2D, V22.2D, V15.2D
    CMHI  V24.2S, V19.2S, V1.2S
    CMLE  V1.2S, V28.2S, #0
    CMLE  V4.2D, V9.2D, #0
    FCMLT  V31.4H, V30.4H, #0.0
    FCMLT  V10.8H, V24.8H, #0.0
    FCMGE  V11.4H, V4.4H, #0.0
    CMGE  V13.2D, V10.2D, #0
    FCMGT  V10.4H, V11.4H, V11.4H
    FCMEQ  V5.8H, V25.8H, #0.0
    FCMEQ  V2.2D, V10.2D, V2.2D
    FCMGE  V17.2S, V5.2S, #0.0
    CMHS  V4.2D, V31.2D, V1.2D
    CMHS  V0.4S, V13.4S, V2.4S
    FCMLE  V28.2S, V14.2S, #0.0
    FCMGT  V6.8H, V28.8H, #0.0
    CMHI  V9.8B, V24.8B, V6.8B
    FCMGE  V15.2S, V29.2S, V9.2S
    FCMGT  V3.8H, V17.8H, V4.8H
    CMTST  V13.2S, V18.2S, V3.2S
    FCMGT  V28.4S, V0.4S, V20.4S
    CMLT  V14.2D, V15.2D, #0
    CMGE  V29.8B, V1.8B, V11.8B
    FCMGE  V26.8H, V29.8H, V24.8H
    FCMLT  V5.4H, V14.4H, #0.0
    CMLT  V25.8B, V31.8B, #0
    CMTST  V0.4S, V23.4S, V26.4S
    CMEQ  V29.8H, V0.8H, V5.8H
    CMGT  V27.16B, V28.16B, V13.16B
    FCMGE  V20.4H, V13.4H, V1.4H
    FCMGE  V19.4H, V25.4H, #0.0
    CMGT  V2.2S, V20.2S, #0
    FCMGE  V28.4H, V19.4H, #0.0
    CMGT  V5.2S, V29.2S, V27.2S
    CMLT  V13.4H, V28.4H, #0
    FCMEQ  V9.4H, V2.4H, #0.0
    FCMGE  V5.4S, V25.4S, #0.0
    CMGE  V10.16B, V4.16B, V5.16B
    FCMGE  V1.2S, V29.2S, #0.0
    CMEQ  V30.16B, V4.16B, #0
    FCMGE  V4.2S, V17.2S, #0.0
    CMGE  V27.2D, V10.2D, #0
    FCMLE  V25.8H, V1.8H, #0.0
    FCMEQ  V23.2S, V1.2S, V9.2S
    CMGE  V28.8H, V2.8H, V21.8H
    FCMGE  V21.2D, V13.2D, #0.0
    FCMLE  V10.2S, V30.2S, #0.0
    FCMLE  V1.4H, V27.4H, #0.0
    FCMGT  V27.4H, V25.4H, V28.4H
    FCMLE  V11.4H, V30.4H, #0.0
    FCMLT  V19.8H, V3.8H, #0.0
    CMHI  V1.2S, V29.2S, V23.2S
    CMLE  V25.16B, V21.16B, #0
    FCMLT  V21.4S, V27.4S, #0.0
    CMHI  V30.16B, V8.16B, V15.16B
    CMGE  V23.8H, V10.8H, #0
    CMEQ  V10.8B, V11.8B, V11.8B
    FCMGT  V29.2D, V21.2D, V7.2D
    CMHI  V8.4S, V30.4S, V12.4S
    CMGT  V26.2D, V23.2D, V30.2D
    CMGE  V1.2D, V25.2D, V8.2D
    FCMGT  V18.8H, V29.8H, #0.0
    CMGT  V13.4S, V31.4S, #0
    FCMEQ  V28.2D, V26.2D, V28.2D
    FCMLE  V12.8H, V19.8H, #0.0
    CMTST  V31.8H, V29.8H, V6.8H
    FCMLE  V16.4S, V13.4S, #0.0
    FCMEQ  V7.4H, V10.4H, #0.0
    FCMLT  V30.2S, V31.2S, #0.0
    FCMGE  V8.2S, V30.2S, #0.0
    FCMLT  V10.4S, V8.4S, #0.0
    FCMLE  V13.2S, V1.2S, #0.0
    CMTST  V26.2D, V28.2D, V20.2D
    CMGT  V23.4H, V16.4H, V26.4H
    CMEQ  V28.8H, V7.8H, #0
    FCMGT  V31.4S, V13.4S, #0.0
    CMGE  V22.2D, V31.2D, V4.2D
    FCMLT  V4.8H, V12.8H, #0.0
    CMGT  V15.8B, V18.8B, #0
    FCMLT  V30.4H, V13.4H, #0.0
    FCMEQ  V18.8H, V10.8H, #0.0
    FCMGT  V19.2D, V10.2D, #0.0
    CMLE  V12.4H, V30.4H, #0
    CMEQ  V8.4S, V28.4S, #0
    FCMGT  V21.8H, V15.8H, #0.0
    FCMGE  V6.4H, V18.4H, #0.0
    CMGT  V31.8B, V16.8B, V21.8B
    FCMGT  V7.2S, V23.2S, V6.2S
    FCMGE  V26.4H, V3.4H, #0.0
    FCMGT  V15.8H, V25.8H, #0.0
    CMHS  V18.2S, V8.2S, V8.2S
    FCMGE  V19.2D, V6.2D, #0.0
    CMGT  V8.2D, V22.2D, #0
    CMGT  V17.8H, V26.8H, V19.8H
    FCMEQ  V10.2D, V26.2D, V8.2D
    FCMLT  V29.4H, V18.4H, #0.0
    FCMGT  V6.2D, V0.2D, #0.0
    FCMEQ  V19.4H, V10.4H, V12.4H
    FCMGT  V30.8H, V15.8H, V17.8H
    FCMLT  V0.4S, V6.4S, #0.0
    CMGE  V22.8H, V0.8H, V7.8H
    FCMLT  V15.2D, V29.2D, #0.0
    CMEQ  V0.4S, V22.4S, #0
    CMGE  V8.16B, V1.16B, #0
    CMGE  V21.4H, V0.4H, #0
    CMTST  V18.8H, V4.8H, V31.8H
    FCMGE  V0.2S, V19.2S, #0.0
    CMGT  V9.4H, V30.4H, V15.4H
    FCMLT  V15.4S, V21.4S, #0.0
    FCMLT  V21.8H, V8.8H, #0.0
    CMHI  V30.2D, V21.2D, V18.2D
    FCMGE  V8.4S, V30.4S, #0.0
    FCMGT  V18.2D, V9.2D, #0.0
    FCMGE  V26.2S, V10.2S, #0.0
    FCMGE  V29.4S, V26.4S, #0.0
    FCMGT  V21.2D, V27.2D, V0.2D
    FCMGT  V10.8H, V18.8H, V25.8H
    CMEQ  V25.2S, V8.2S, V7.2S
    FCMGE  V0.8H, V28.8H, V3.8H
    FCMEQ  V27.2D, V10.2D, V29.2D
    CMGT  V30.2S, V20.2S, V0.2S
    FCMGE  V20.4H, V11.4H, V27.4H
    FCMLT  V1.4H, V30.4H, #0.0
    FCMLT  V18.4S, V27.4S, #0.0
    FCMGE  V0.2D, V6.2D, V20.2D
    FCMGT  V11.8H, V6.8H, V14.8H
    FCMGE  V31.8H, V11.8H, #0.0
    FCMGT  V17.2S, V18.2S, V15.2S
    FCMLT  V8.2S, V17.2S, #0.0
    FCMGE  V27.4H, V21.4H, #0.0
    CMGT  V9.2S, V0.2S, #0
    FCMLE  V20.4S, V27.4S, #0.0
    FCMGE  V0.8H, V3.8H, #0.0
    FCMGT  V5.4H, V10.4H, #0.0
    CMTST  V10.16B, V0.16B, V31.16B
    FCMGT  V11.8H, V5.8H, #0.0
    CMGT  V30.8B, V1.8B, V8.8B
    FCMEQ  V0.2S, V30.2S, V20.2S
    FCMLT  V12.4H, V10.4H, #0.0
    CMEQ  V7.16B, V12.16B, #0
    FCMLT  V18.4H, V11.4H, #0.0
    FCMEQ  V6.8H, V15.8H, #0.0
    CMLE  V8.8H, V0.8H, #0
    FCMLE  V27.4H, V9.4H, #0.0
    CMHS  V9.2S, V27.2S, V16.2S
    CMLT  V4.8B, V3.8B, #0
    FCMEQ  V10.4S, V9.4S, #0.0
    CMGE  V20.4H, V6.4H, #0
    CMGT  V0.2D, V7.2D, V6.2D
    FCMLE  V15.8H, V20.8H, #0.0
    CMHI  V12.2S, V8.2S, V8.2S
    FCMGE  V28.8H, V4.8H, #0.0
    SUBS  X27, X27, #0x1
    B.NE  TSRTAdvsimdVectorCompare_label_4
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X13, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X13, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X13, X28, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X13, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X13, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X13, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X13, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X13, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X13, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X13, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X13, X28, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X13, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X13, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X13, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X13, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X13, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X13, X28, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X13, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X13, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MRS  X28, FPSR
    MOVZ  X13, #0x81, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V0.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D0
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V1.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D1
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D2
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V3.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D3
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V4.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D4
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D5
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D6
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V7.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D7
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D8
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D9
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D10
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D11
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V12.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D12
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V13.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D13
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D14
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V15.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D15
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D16
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D17
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D18
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V19.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D19
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D20
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V21.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D21
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D22
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V23.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D23
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D24
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D25
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D26
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V27.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D27
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V28.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D28
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V29.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D29
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V30.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D30
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, V31.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X28, D31
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X2, #0x367, LSL #0
    MOVK  X2, #0xb212, LSL #16
    MOVK  X2, #0xbee7, LSL #32
    MOVK  X2, #0x8174, LSL #48
    MOVZ  X3, #0x1c11, LSL #0
    MOVK  X3, #0x9fb7, LSL #16
    MOVK  X3, #0x4bf2, LSL #32
    MOVK  X3, #0xce24, LSL #48
    MOVZ  X4, #0xada9, LSL #0
    MOVK  X4, #0x65, LSL #16
    MOVK  X4, #0x2aac, LSL #32
    MOVK  X4, #0x8b1a, LSL #48
    MOVZ  X5, #0xbfdb, LSL #0
    MOVK  X5, #0x2db8, LSL #16
    MOVK  X5, #0xb16e, LSL #32
    MOVK  X5, #0x6653, LSL #48
    MOVZ  X6, #0xd48f, LSL #0
    MOVK  X6, #0x5a44, LSL #16
    MOVK  X6, #0xdf82, LSL #32
    MOVK  X6, #0xc3c2, LSL #48
    MOVZ  X7, #0x5362, LSL #0
    MOVK  X7, #0x3847, LSL #16
    MOVK  X7, #0x9c5, LSL #32
    MOVK  X7, #0xe693, LSL #48
    MOVZ  X8, #0xa514, LSL #0
    MOVK  X8, #0xad2e, LSL #16
    MOVK  X8, #0xce6f, LSL #32
    MOVK  X8, #0x7e99, LSL #48
    MOVZ  X9, #0xff9d, LSL #0
    MOVK  X9, #0x90c, LSL #16
    MOVK  X9, #0x6f7f, LSL #32
    MOVK  X9, #0x9e73, LSL #48
    MOVZ  X10, #0x315a, LSL #0
    MOVK  X10, #0x6b0e, LSL #16
    MOVK  X10, #0x7f32, LSL #32
    MOVK  X10, #0x4d8f, LSL #48
    MOVZ  X11, #0x5304, LSL #0
    MOVK  X11, #0x3825, LSL #16
    MOVK  X11, #0xee15, LSL #32
    MOVK  X11, #0x3108, LSL #48
    MOVZ  X12, #0x27bf, LSL #0
    MOVK  X12, #0x89cc, LSL #16
    MOVK  X12, #0x290f, LSL #32
    MOVK  X12, #0xe8cc, LSL #48
    MOVZ  X13, #0xaf2e, LSL #0
    MOVK  X13, #0xaf63, LSL #16
    MOVK  X13, #0x930, LSL #32
    MOVK  X13, #0xfe6c, LSL #48
    MOVZ  X14, #0x5063, LSL #0
    MOVK  X14, #0xd254, LSL #16
    MOVK  X14, #0x9d2b, LSL #32
    MOVK  X14, #0x8367, LSL #48
    MOVZ  X15, #0xa569, LSL #0
    MOVK  X15, #0x7d73, LSL #16
    MOVK  X15, #0x25ad, LSL #32
    MOVK  X15, #0x41c1, LSL #48
    MOVZ  X16, #0xd414, LSL #0
    MOVK  X16, #0xe100, LSL #16
    MOVK  X16, #0x4242, LSL #32
    MOVK  X16, #0xe80e, LSL #48
    MOVZ  X17, #0xe14a, LSL #0
    MOVK  X17, #0xb5de, LSL #16
    MOVK  X17, #0x90de, LSL #32
    MOVK  X17, #0x9b34, LSL #48
    MOVZ  X23, #0xfd01, LSL #0
    MOVK  X23, #0x17e7, LSL #16
    MOVK  X23, #0xe983, LSL #32
    MOVK  X23, #0x180b, LSL #48
    MOVZ  X24, #0xaaea, LSL #0
    MOVK  X24, #0xf554, LSL #16
    MOVK  X24, #0x55cb, LSL #32
    MOVK  X24, #0x2d9a, LSL #48
    MOVZ  X25, #0xd4c4, LSL #0
    MOVK  X25, #0x41b9, LSL #16
    MOVK  X25, #0x7a1f, LSL #32
    MOVK  X25, #0x5d23, LSL #48
    MOVZ  X26, #0xc6ae, LSL #0
    MOVK  X26, #0x8b84, LSL #16
    MOVK  X26, #0xfeb8, LSL #32
    MOVK  X26, #0x313b, LSL #48
    MOVZ  X27, #0x90c9, LSL #0
    MOVK  X27, #0x1176, LSL #16
    MOVK  X27, #0x88c6, LSL #32
    MOVK  X27, #0x6e, LSL #48
    MOVZ  X28, #0x4368, LSL #0
    MOVK  X28, #0xaa45, LSL #16
    MOVK  X28, #0xcd18, LSL #32
    MOVK  X28, #0x5dd5, LSL #48
    MOVZ  X29, #0xe0cc, LSL #0
    MOVK  X29, #0xfb3e, LSL #16
    MOVK  X29, #0x8711, LSL #32
    MOVK  X29, #0xcb0f, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X28
    FMOV  D1, X10
    FMOV  V1.D[1], X25
    FMOV  D2, X29
    FMOV  V2.D[1], X26
    FMOV  D3, X6
    FMOV  V3.D[1], X16
    FMOV  D4, X27
    FMOV  V4.D[1], X13
    FMOV  D5, X4
    FMOV  V5.D[1], X29
    FMOV  D6, X26
    FMOV  V6.D[1], X24
    FMOV  D7, X26
    FMOV  V7.D[1], X26
    FMOV  D8, X5
    FMOV  V8.D[1], X26
    FMOV  D9, X9
    FMOV  V9.D[1], X23
    FMOV  D10, X4
    FMOV  V10.D[1], X28
    FMOV  D11, X15
    FMOV  V11.D[1], X12
    FMOV  D12, X2
    FMOV  V12.D[1], X9
    FMOV  D13, X13
    FMOV  V13.D[1], X2
    FMOV  D14, X25
    FMOV  V14.D[1], X14
    FMOV  D15, X16
    FMOV  V15.D[1], X10
    FMOV  D16, X29
    FMOV  V16.D[1], X17
    FMOV  D17, X15
    FMOV  V17.D[1], X16
    FMOV  D18, X24
    FMOV  V18.D[1], X9
    FMOV  D19, X24
    FMOV  V19.D[1], X28
    FMOV  D20, X2
    FMOV  V20.D[1], X24
    FMOV  D21, X4
    FMOV  V21.D[1], X24
    FMOV  D22, X26
    FMOV  V22.D[1], X26
    FMOV  D23, X10
    FMOV  V23.D[1], X13
    FMOV  D24, X6
    FMOV  V24.D[1], X4
    FMOV  D25, X15
    FMOV  V25.D[1], X14
    FMOV  D26, X28
    FMOV  V26.D[1], X3
    FMOV  D27, X14
    FMOV  V27.D[1], X27
    FMOV  D28, X27
    FMOV  V28.D[1], X14
    FMOV  D29, X28
    FMOV  V29.D[1], X2
    FMOV  D30, X7
    FMOV  V30.D[1], X9
    FMOV  D31, X27
    FMOV  V31.D[1], X5
    MOVZ  X24, #0xa, LSL #0
TSRTAdvsimdVectorCompare_label_5:
    CMLE  V31.4H, V31.4H, #0
    FCMLT  V31.2S, V31.2S, #0.0
    CMLE  V2.8H, V25.8H, #0
    FCMLE  V18.4S, V24.4S, #0.0
    FCMLE  V23.4S, V28.4S, #0.0
    CMGE  V16.2S, V18.2S, V3.2S
    CMGT  V28.16B, V30.16B, V4.16B
    FCMGE  V25.4S, V10.4S, V23.4S
    CMGE  V6.8B, V27.8B, #0
    CMHI  V30.8H, V10.8H, V25.8H
    CMGE  V27.4H, V11.4H, V16.4H
    CMHI  V23.4S, V0.4S, V27.4S
    CMTST  V27.8B, V29.8B, V14.8B
    FCMGE  V10.8H, V28.8H, #0.0
    FCMGE  V7.4H, V23.4H, #0.0
    CMLT  V7.4H, V6.4H, #0
    FCMGT  V8.4S, V7.4S, #0.0
    FCMGE  V15.2S, V30.2S, V22.2S
    FCMGT  V4.4S, V23.4S, V28.4S
    FCMGE  V19.4S, V6.4S, #0.0
    FCMGT  V22.4H, V19.4H, #0.0
    CMGE  V6.2S, V1.2S, V22.2S
    CMLE  V19.4H, V14.4H, #0
    FCMGE  V18.8H, V2.8H, #0.0
    CMGT  V30.2S, V27.2S, V1.2S
    FCMGE  V14.4S, V15.4S, V1.4S
    FCMGT  V15.2D, V30.2D, V14.2D
    FCMGE  V16.2D, V16.2D, #0.0
    CMGE  V23.16B, V4.16B, V8.16B
    FCMGE  V28.8H, V24.8H, #0.0
    CMGE  V25.8H, V28.8H, V28.8H
    FCMLT  V8.4H, V10.4H, #0.0
    CMEQ  V24.8H, V8.8H, V25.8H
    CMLT  V11.2S, V10.2S, #0
    FCMEQ  V2.8H, V18.8H, #0.0
    CMEQ  V22.4H, V14.4H, V16.4H
    FCMLT  V16.8H, V5.8H, #0.0
    FCMGT  V10.4H, V28.4H, V24.4H
    FCMGT  V18.4S, V6.4S, V7.4S
    FCMGE  V26.4S, V31.4S, V19.4S
    FCMEQ  V6.8H, V9.8H, #0.0
    CMGT  V28.8B, V6.8B, V23.8B
    CMLE  V1.4S, V31.4S, #0
    FCMGE  V17.8H, V15.8H, V16.8H
    FCMEQ  V3.4H, V3.4H, V16.4H
    FCMGE  V5.2S, V22.2S, #0.0
    FCMGT  V8.4S, V11.4S, V1.4S
    CMEQ  V4.4H, V18.4H, V0.4H
    FCMGE  V9.4S, V3.4S, #0.0
    CMLT  V30.2S, V2.2S, #0
    CMGT  V23.4H, V5.4H, #0
    CMTST  V0.2S, V23.2S, V4.2S
    FCMGT  V27.8H, V11.8H, #0.0
    FCMGE  V14.2D, V10.2D, #0.0
    FCMEQ  V31.2D, V28.2D, #0.0
    FCMEQ  V1.2D, V27.2D, #0.0
    CMLE  V16.2D, V18.2D, #0
    FCMEQ  V27.4H, V0.4H, V1.4H
    CMLE  V10.4H, V16.4H, #0
    CMEQ  V22.2S, V1.2S, #0
    CMTST  V6.8B, V27.8B, V26.8B
    FCMEQ  V16.2S, V8.2S, V14.2S
    FCMGT  V25.2S, V16.2S, #0.0
    CMGT  V7.2D, V22.2D, #0
    FCMGT  V28.8H, V3.8H, V30.8H
    FCMGE  V24.8H, V3.8H, #0.0
    FCMLT  V11.4H, V28.4H, #0.0
    CMLE  V22.16B, V17.16B, #0
    FCMLE  V5.4H, V25.4H, #0.0
    CMGE  V30.8H, V11.8H, #0
    FCMEQ  V23.4H, V24.4H, #0.0
    FCMLT  V4.8H, V16.8H, #0.0
    FCMGT  V15.8H, V30.8H, V31.8H
    FCMGT  V3.2S, V4.2S, V9.2S
    FCMLT  V30.2D, V22.2D, #0.0
    FCMGE  V2.4H, V7.4H, #0.0
    FCMGT  V14.4H, V3.4H, V23.4H
    CMGE  V23.2S, V25.2S, #0
    FCMEQ  V22.8H, V23.8H, V6.8H
    FCMEQ  V27.4H, V14.4H, #0.0
    CMLT  V6.2S, V8.2S, #0
    FCMEQ  V14.2S, V7.2S, #0.0
    CMEQ  V31.4H, V14.4H, #0
    FCMLT  V17.8H, V5.8H, #0.0
    FCMLE  V3.2S, V27.2S, #0.0
    FCMLT  V8.4H, V6.4H, #0.0
    FCMLE  V14.2S, V15.2S, #0.0
    FCMEQ  V0.4S, V10.4S, V14.4S
    CMGE  V25.8B, V31.8B, #0
    CMLE  V10.4S, V22.4S, #0
    CMHI  V9.4H, V3.4H, V10.4H
    FCMGT  V14.4S, V2.4S, V30.4S
    CMGT  V16.8B, V0.8B, #0
    CMEQ  V2.4H, V3.4H, V21.4H
    FCMGE  V22.8H, V17.8H, V14.8H
    FCMGE  V6.4S, V22.4S, V25.4S
    CMEQ  V15.8B, V9.8B, V8.8B
    CMGT  V22.2D, V12.2D, #0
    FCMGT  V8.4H, V28.4H, #0.0
    FCMGE  V27.4H, V20.4H, V6.4H
    FCMEQ  V10.2D, V22.2D, V28.2D
    FCMLT  V6.2D, V10.2D, #0.0
    CMLE  V26.4H, V29.4H, #0
    FCMEQ  V31.4H, V6.4H, #0.0
    FCMEQ  V30.4H, V30.4H, V8.4H
    FCMLE  V29.2D, V31.2D, #0.0
    FCMGT  V22.8H, V3.8H, V27.8H
    FCMGT  V6.8H, V23.8H, #0.0
    FCMEQ  V20.2S, V26.2S, #0.0
    FCMEQ  V23.8H, V15.8H, #0.0
    FCMGE  V3.4S, V14.4S, #0.0
    CMGE  V8.16B, V30.16B, #0
    FCMGE  V15.4H, V22.4H, V20.4H
    CMEQ  V9.2D, V2.2D, V29.2D
    FCMGT  V2.2S, V16.2S, #0.0
    FCMLT  V12.8H, V9.8H, #0.0
    FCMGE  V30.2S, V15.2S, #0.0
    CMLT  V15.16B, V3.16B, #0
    FCMEQ  V27.8H, V12.8H, #0.0
    CMLE  V30.16B, V23.16B, #0
    FCMGT  V10.8H, V22.8H, V23.8H
    FCMEQ  V20.4S, V15.4S, #0.0
    FCMLE  V15.4S, V2.4S, #0.0
    FCMGE  V31.4H, V6.4H, #0.0
    FCMGT  V9.2D, V15.2D, V30.2D
    CMHS  V12.8B, V14.8B, V6.8B
    CMGT  V29.8B, V25.8B, #0
    FCMEQ  V23.8H, V20.8H, V9.8H
    FCMGT  V16.2S, V6.2S, #0.0
    CMHI  V12.4S, V12.4S, V27.4S
    FCMGE  V2.2S, V16.2S, #0.0
    CMLE  V26.4H, V2.4H, #0
    FCMGE  V25.2S, V30.2S, V31.2S
    CMTST  V30.4S, V9.4S, V8.4S
    FCMLE  V2.8H, V30.8H, #0.0
    CMLE  V31.8H, V26.8H, #0
    CMEQ  V23.2S, V31.2S, V29.2S
    CMLE  V9.4H, V12.4H, #0
    FCMLT  V6.4S, V23.4S, #0.0
    FCMGE  V3.4S, V6.4S, #0.0
    CMHI  V31.8H, V18.8H, V8.8H
    FCMLE  V8.2S, V30.2S, #0.0
    FCMEQ  V12.4H, V8.4H, V31.4H
    FCMEQ  V10.2S, V10.2S, #0.0
    FCMEQ  V6.4H, V30.4H, #0.0
    FCMLT  V28.2D, V9.2D, #0.0
    FCMGT  V29.4H, V1.4H, V31.4H
    CMLE  V20.4S, V15.4S, #0
    CMEQ  V20.4H, V25.4H, #0
    CMHI  V30.2S, V2.2S, V26.2S
    FCMLT  V9.8H, V9.8H, #0.0
    FCMEQ  V5.4H, V10.4H, #0.0
    FCMEQ  V23.2D, V30.2D, #0.0
    CMEQ  V14.8H, V1.8H, V23.8H
    FCMGE  V2.2S, V9.2S, V20.2S
    CMGT  V22.4H, V28.4H, V25.4H
    CMEQ  V10.2S, V20.2S, V14.2S
    CMTST  V15.4S, V27.4S, V22.4S
    CMGE  V22.4S, V2.4S, #0
    FCMGT  V31.4S, V20.4S, V29.4S
    CMGT  V16.16B, V15.16B, V15.16B
    FCMEQ  V23.4S, V5.4S, #0.0
    CMHS  V2.8B, V31.8B, V16.8B
    FCMLT  V24.2D, V22.2D, #0.0
    CMEQ  V16.4S, V10.4S, #0
    CMGE  V29.2S, V16.2S, V16.2S
    CMHI  V5.4S, V2.4S, V12.4S
    FCMEQ  V27.2D, V29.2D, V29.2D
    CMTST  V29.8B, V6.8B, V24.8B
    CMHS  V12.8H, V3.8H, V0.8H
    CMGT  V30.16B, V5.16B, V22.16B
    CMEQ  V16.16B, V12.16B, V11.16B
    CMGE  V22.2D, V26.2D, V16.2D
    FCMEQ  V28.2D, V13.2D, V18.2D
    FCMGT  V25.4S, V29.4S, #0.0
    FCMEQ  V11.4S, V20.4S, #0.0
    FCMEQ  V31.4H, V25.4H, V4.4H
    FCMGT  V18.4H, V22.4H, #0.0
    FCMGE  V5.8H, V12.8H, V23.8H
    CMGE  V14.2D, V27.2D, #0
    CMGT  V10.8B, V31.8B, V1.8B
    FCMGE  V29.4H, V28.4H, V24.4H
    CMGT  V22.16B, V1.16B, #0
    FCMGE  V1.2S, V5.2S, #0.0
    CMGE  V3.8H, V1.8H, #0
    FCMLT  V16.2S, V4.2S, #0.0
    FCMGT  V20.8H, V23.8H, #0.0
    FCMEQ  V1.2S, V12.2S, V20.2S
    CMLT  V6.4H, V11.4H, #0
    FCMEQ  V13.2D, V6.2D, #0.0
    FCMGE  V22.4H, V20.4H, V22.4H
    FCMGE  V26.8H, V18.8H, #0.0
    FCMGT  V28.4S, V14.4S, V13.4S
    FCMGT  V27.8H, V17.8H, V11.8H
    FCMGE  V14.8H, V30.8H, #0.0
    FCMGE  V4.2S, V14.2S, #0.0
    CMEQ  V30.8B, V2.8B, V27.8B
    FCMEQ  V6.4S, V3.4S, #0.0
    FCMEQ  V13.8H, V26.8H, V6.8H
    CMGT  V20.2S, V13.2S, #0
    SUBS  X24, X24, #0x1
    B.NE  TSRTAdvsimdVectorCompare_label_5
    MOVZ  X6, #0x367, LSL #0
    MOVK  X6, #0xb212, LSL #16
    MOVK  X6, #0xbee7, LSL #32
    MOVK  X6, #0x8174, LSL #48
    SUB  X29, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X6, #0x1c11, LSL #0
    MOVK  X6, #0x9fb7, LSL #16
    MOVK  X6, #0x4bf2, LSL #32
    MOVK  X6, #0xce24, LSL #48
    SUB  X29, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X6, #0xada9, LSL #0
    MOVK  X6, #0x65, LSL #16
    MOVK  X6, #0x2aac, LSL #32
    MOVK  X6, #0x8b1a, LSL #48
    SUB  X29, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X6, #0xbfdb, LSL #0
    MOVK  X6, #0x2db8, LSL #16
    MOVK  X6, #0xb16e, LSL #32
    MOVK  X6, #0x6653, LSL #48
    SUB  X29, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X6, #0x5362, LSL #0
    MOVK  X6, #0x3847, LSL #16
    MOVK  X6, #0x9c5, LSL #32
    MOVK  X6, #0xe693, LSL #48
    SUB  X29, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X6, #0xa514, LSL #0
    MOVK  X6, #0xad2e, LSL #16
    MOVK  X6, #0xce6f, LSL #32
    MOVK  X6, #0x7e99, LSL #48
    SUB  X29, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X6, #0xff9d, LSL #0
    MOVK  X6, #0x90c, LSL #16
    MOVK  X6, #0x6f7f, LSL #32
    MOVK  X6, #0x9e73, LSL #48
    SUB  X29, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X6, #0x315a, LSL #0
    MOVK  X6, #0x6b0e, LSL #16
    MOVK  X6, #0x7f32, LSL #32
    MOVK  X6, #0x4d8f, LSL #48
    SUB  X29, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X6, #0x5304, LSL #0
    MOVK  X6, #0x3825, LSL #16
    MOVK  X6, #0xee15, LSL #32
    MOVK  X6, #0x3108, LSL #48
    SUB  X29, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X6, #0x27bf, LSL #0
    MOVK  X6, #0x89cc, LSL #16
    MOVK  X6, #0x290f, LSL #32
    MOVK  X6, #0xe8cc, LSL #48
    SUB  X29, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X6, #0xaf2e, LSL #0
    MOVK  X6, #0xaf63, LSL #16
    MOVK  X6, #0x930, LSL #32
    MOVK  X6, #0xfe6c, LSL #48
    SUB  X29, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X6, #0x5063, LSL #0
    MOVK  X6, #0xd254, LSL #16
    MOVK  X6, #0x9d2b, LSL #32
    MOVK  X6, #0x8367, LSL #48
    SUB  X29, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X6, #0xa569, LSL #0
    MOVK  X6, #0x7d73, LSL #16
    MOVK  X6, #0x25ad, LSL #32
    MOVK  X6, #0x41c1, LSL #48
    SUB  X29, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X6, #0xd414, LSL #0
    MOVK  X6, #0xe100, LSL #16
    MOVK  X6, #0x4242, LSL #32
    MOVK  X6, #0xe80e, LSL #48
    SUB  X29, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X6, #0xfd01, LSL #0
    MOVK  X6, #0x17e7, LSL #16
    MOVK  X6, #0xe983, LSL #32
    MOVK  X6, #0x180b, LSL #48
    SUB  X29, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X6, #0xd4c4, LSL #0
    MOVK  X6, #0x41b9, LSL #16
    MOVK  X6, #0x7a1f, LSL #32
    MOVK  X6, #0x5d23, LSL #48
    SUB  X29, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X6, #0xc6ae, LSL #0
    MOVK  X6, #0x8b84, LSL #16
    MOVK  X6, #0xfeb8, LSL #32
    MOVK  X6, #0x313b, LSL #48
    SUB  X29, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X6, #0x90c9, LSL #0
    MOVK  X6, #0x1176, LSL #16
    MOVK  X6, #0x88c6, LSL #32
    MOVK  X6, #0x6e, LSL #48
    SUB  X29, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X6, #0x4368, LSL #0
    MOVK  X6, #0xaa45, LSL #16
    MOVK  X6, #0xcd18, LSL #32
    MOVK  X6, #0x5dd5, LSL #48
    SUB  X29, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorCompare_TestFail
    MRS  X6, FPSR
    MOVZ  X29, #0x81, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V0.D[1]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D0
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V1.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D1
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D2
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D3
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V4.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D4
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D5
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V6.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D6
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D7
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D8
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D9
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D10
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V11.D[1]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D11
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V12.D[1]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D12
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D13
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D14
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V15.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D15
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D16
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D17
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V18.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D18
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D19
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V20.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D20
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X29, #0xaaea, LSL #0
    MOVK  X29, #0xf554, LSL #16
    MOVK  X29, #0x55cb, LSL #32
    MOVK  X29, #0x2d9a, LSL #48
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D21
    MOVZ  X29, #0xada9, LSL #0
    MOVK  X29, #0x65, LSL #16
    MOVK  X29, #0x2aac, LSL #32
    MOVK  X29, #0x8b1a, LSL #48
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V22.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D22
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D23
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D24
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D25
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D26
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V27.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D27
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D28
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V29.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D29
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V30.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D30
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, V31.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X6, D31
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X17, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
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
    FMOV  D0, X5
    FMOV  V0.D[1], X24
    FMOV  D1, X10
    FMOV  V1.D[1], X7
    FMOV  D2, X12
    FMOV  V2.D[1], X23
    FMOV  D3, X28
    FMOV  V3.D[1], X11
    FMOV  D4, X8
    FMOV  V4.D[1], X15
    FMOV  D5, X27
    FMOV  V5.D[1], X17
    FMOV  D6, X26
    FMOV  V6.D[1], X29
    FMOV  D7, X2
    FMOV  V7.D[1], X26
    FMOV  D8, X25
    FMOV  V8.D[1], X26
    FMOV  D9, X24
    FMOV  V9.D[1], X17
    FMOV  D10, X10
    FMOV  V10.D[1], X16
    FMOV  D11, X15
    FMOV  V11.D[1], X4
    FMOV  D12, X15
    FMOV  V12.D[1], X24
    FMOV  D13, X11
    FMOV  V13.D[1], X10
    FMOV  D14, X7
    FMOV  V14.D[1], X14
    FMOV  D15, X23
    FMOV  V15.D[1], X11
    FMOV  D16, X13
    FMOV  V16.D[1], X4
    FMOV  D17, X27
    FMOV  V17.D[1], X9
    FMOV  D18, X8
    FMOV  V18.D[1], X24
    FMOV  D19, X28
    FMOV  V19.D[1], X16
    FMOV  D20, X10
    FMOV  V20.D[1], X17
    FMOV  D21, X26
    FMOV  V21.D[1], X12
    FMOV  D22, X12
    FMOV  V22.D[1], X9
    FMOV  D23, X2
    FMOV  V23.D[1], X7
    FMOV  D24, X12
    FMOV  V24.D[1], X29
    FMOV  D25, X17
    FMOV  V25.D[1], X10
    FMOV  D26, X13
    FMOV  V26.D[1], X7
    FMOV  D27, X6
    FMOV  V27.D[1], X27
    FMOV  D28, X4
    FMOV  V28.D[1], X13
    FMOV  D29, X5
    FMOV  V29.D[1], X14
    FMOV  D30, X7
    FMOV  V30.D[1], X12
    FMOV  D31, X24
    FMOV  V31.D[1], X24
    MOVZ  X6, #0xa, LSL #0
TSRTAdvsimdVectorCompare_label_6:
    FCMGT  V26.8H, V28.8H, #0.0
    FCMEQ  V25.8H, V31.8H, #0.0
    CMHS  V28.16B, V30.16B, V25.16B
    CMGT  V31.2D, V29.2D, V29.2D
    CMLT  V22.4S, V22.4S, #0
    FCMGE  V11.4S, V26.4S, V15.4S
    FCMGT  V23.4S, V0.4S, V27.4S
    CMLT  V2.8H, V28.8H, #0
    FCMLT  V24.2S, V2.2S, #0.0
    FCMLE  V21.2D, V22.2D, #0.0
    FCMGE  V25.4H, V16.4H, V11.4H
    FCMGE  V24.4S, V31.4S, #0.0
    FCMLT  V3.4H, V24.4H, #0.0
    FCMGE  V10.2S, V25.2S, V23.2S
    FCMGT  V26.4H, V10.4H, V21.4H
    FCMLE  V21.2S, V29.2S, #0.0
    FCMGT  V14.8H, V10.8H, V25.8H
    FCMEQ  V30.4S, V1.4S, #0.0
    FCMGT  V22.2S, V25.2S, #0.0
    CMLT  V11.8B, V31.8B, #0
    CMGT  V28.4S, V6.4S, V22.4S
    CMHS  V27.2S, V31.2S, V17.2S
    FCMGT  V6.4H, V28.4H, V27.4H
    CMGT  V22.4S, V19.4S, #0
    FCMEQ  V2.2S, V7.2S, #0.0
    CMEQ  V4.4H, V21.4H, V2.4H
    CMEQ  V28.8B, V1.8B, #0
    CMGT  V1.2S, V30.2S, V12.2S
    FCMGT  V25.8H, V15.8H, #0.0
    FCMGT  V7.4H, V25.4H, #0.0
    FCMGT  V18.2D, V10.2D, V7.2D
    CMGT  V15.16B, V25.16B, #0
    FCMLT  V15.2D, V4.2D, #0.0
    FCMGT  V25.4H, V11.4H, V15.4H
    CMEQ  V8.4S, V22.4S, #0
    FCMLT  V0.4S, V8.4S, #0.0
    FCMLE  V27.8H, V0.8H, #0.0
    FCMEQ  V22.8H, V27.8H, #0.0
    FCMGT  V10.2D, V6.2D, #0.0
    FCMGE  V19.4S, V17.4S, V22.4S
    FCMLT  V2.2S, V28.2S, #0.0
    FCMGE  V29.8H, V25.8H, #0.0
    CMHS  V25.16B, V1.16B, V29.16B
    CMLT  V15.16B, V10.16B, #0
    FCMGT  V6.4S, V17.4S, #0.0
    CMEQ  V4.2S, V14.2S, #0
    CMEQ  V17.8B, V18.8B, V4.8B
    FCMGT  V29.8H, V27.8H, V25.8H
    FCMLE  V10.2D, V10.2D, #0.0
    CMGT  V22.2D, V2.2D, #0
    CMHS  V11.2D, V22.2D, V6.2D
    FCMGT  V4.8H, V15.8H, V5.8H
    FCMEQ  V28.4H, V16.4H, V1.4H
    CMGE  V31.4H, V4.4H, V17.4H
    FCMEQ  V1.2S, V9.2S, V11.2S
    CMGE  V11.2D, V20.2D, V27.2D
    CMGT  V0.8B, V27.8B, V19.8B
    FCMLE  V7.4H, V18.4H, #0.0
    FCMLT  V12.8H, V7.8H, #0.0
    FCMGT  V4.8H, V1.8H, #0.0
    CMEQ  V25.4S, V11.4S, #0
    CMGE  V15.8H, V28.8H, V29.8H
    FCMEQ  V8.4S, V25.4S, #0.0
    CMHI  V19.4H, V10.4H, V10.4H
    FCMGT  V27.2S, V31.2S, V25.2S
    FCMEQ  V2.2D, V8.2D, V27.2D
    FCMGE  V28.4S, V2.4S, V15.4S
    FCMLE  V26.4H, V12.4H, #0.0
    FCMEQ  V20.8H, V19.8H, #0.0
    FCMGT  V25.4H, V20.4H, #0.0
    FCMGE  V12.4H, V4.4H, #0.0
    CMEQ  V20.16B, V24.16B, #0
    FCMLT  V17.8H, V0.8H, #0.0
    FCMEQ  V10.8H, V23.8H, V20.8H
    CMGE  V27.4H, V22.4H, #0
    CMHI  V26.2D, V12.2D, V25.2D
    CMGE  V16.2S, V24.2S, V17.2S
    FCMGE  V25.4S, V28.4S, #0.0
    FCMEQ  V19.4S, V26.4S, V20.4S
    FCMGT  V11.8H, V0.8H, V25.8H
    CMEQ  V12.2D, V4.2D, #0
    CMHS  V22.8H, V8.8H, V11.8H
    FCMLE  V26.2D, V10.2D, #0.0
    FCMLE  V31.4S, V22.4S, #0.0
    FCMGT  V22.8H, V5.8H, #0.0
    FCMGT  V10.8H, V26.8H, V4.8H
    FCMLE  V4.4S, V22.4S, #0.0
    FCMEQ  V8.4H, V22.4H, #0.0
    FCMGT  V26.2D, V4.2D, #0.0
    CMGT  V12.16B, V19.16B, #0
    FCMLT  V15.4H, V16.4H, #0.0
    FCMGT  V18.8H, V8.8H, V0.8H
    FCMGT  V2.8H, V18.8H, #0.0
    FCMEQ  V28.2S, V15.2S, #0.0
    CMLT  V19.2S, V17.2S, #0
    FCMGE  V17.8H, V26.8H, V19.8H
    CMHI  V0.8H, V2.8H, V4.8H
    FCMLE  V9.2S, V7.2S, #0.0
    CMEQ  V25.8H, V9.8H, V31.8H
    FCMLE  V2.2S, V6.2S, #0.0
    FCMGT  V9.4H, V12.4H, V25.4H
    FCMGE  V20.4S, V20.4S, V17.4S
    CMLT  V7.4S, V9.4S, #0
    FCMEQ  V17.4S, V7.4S, V20.4S
    CMGT  V31.2D, V10.2D, #0
    CMGE  V8.8B, V15.8B, V26.8B
    FCMGE  V16.2D, V16.2D, V8.2D
    FCMEQ  V23.4H, V3.4H, V2.4H
    FCMGT  V10.4H, V23.4H, V16.4H
    FCMGT  V25.4H, V6.4H, V14.4H
    CMGT  V12.4H, V12.4H, #0
    FCMEQ  V6.4S, V4.4S, V16.4S
    CMLE  V9.2S, V25.2S, #0
    CMGE  V5.8B, V16.8B, V28.8B
    FCMEQ  V2.2S, V9.2S, V31.2S
    CMGE  V28.16B, V2.16B, V29.16B
    CMEQ  V26.2D, V6.2D, V12.2D
    FCMEQ  V6.4H, V5.4H, #0.0
    CMGT  V12.2D, V28.2D, V10.2D
    CMGE  V9.2D, V25.2D, #0
    CMGT  V8.2D, V2.2D, V6.2D
    CMLE  V3.8H, V20.8H, #0
    CMTST  V31.2S, V0.2S, V23.2S
    FCMGT  V19.2D, V8.2D, #0.0
    FCMEQ  V10.2S, V3.2S, V22.2S
    FCMEQ  V28.4H, V25.4H, V26.4H
    CMGT  V26.8H, V9.8H, #0
    CMHS  V9.8H, V12.8H, V12.8H
    CMLE  V23.2D, V9.2D, #0
    FCMGE  V4.4S, V2.4S, #0.0
    CMLE  V20.4S, V10.4S, #0
    CMLE  V3.2S, V17.2S, #0
    FCMGT  V22.8H, V28.8H, #0.0
    FCMGT  V7.4S, V31.4S, #0.0
    FCMEQ  V9.4S, V27.4S, #0.0
    CMEQ  V29.4H, V3.4H, V20.4H
    FCMGE  V5.4H, V29.4H, #0.0
    FCMGT  V3.4H, V5.4H, #0.0
    FCMEQ  V20.4H, V26.4H, #0.0
    FCMEQ  V13.2S, V23.2S, #0.0
    CMGT  V16.16B, V9.16B, V20.16B
    CMGE  V26.8B, V4.8B, V28.8B
    CMEQ  V23.4H, V11.4H, #0
    CMEQ  V25.8H, V23.8H, V18.8H
    CMEQ  V27.8H, V7.8H, V31.8H
    FCMEQ  V29.8H, V19.8H, #0.0
    CMLE  V12.16B, V25.16B, #0
    CMEQ  V9.4S, V6.4S, #0
    FCMEQ  V31.4H, V27.4H, #0.0
    FCMLE  V27.2S, V16.2S, #0.0
    CMHI  V19.2D, V8.2D, V3.2D
    CMLE  V8.2D, V12.2D, #0
    FCMLE  V7.8H, V4.8H, #0.0
    CMGT  V25.4H, V26.4H, V8.4H
    CMGT  V26.16B, V14.16B, V25.16B
    CMGT  V8.2D, V31.2D, V19.2D
    CMGT  V26.16B, V4.16B, #0
    CMGT  V16.2S, V9.2S, V27.2S
    FCMGE  V20.4H, V8.4H, V16.4H
    CMLT  V11.16B, V26.16B, #0
    FCMEQ  V18.4S, V11.4S, V29.4S
    CMEQ  V3.8H, V20.8H, V0.8H
    CMGE  V9.4H, V3.4H, #0
    FCMLT  V16.2D, V21.2D, #0.0
    CMGE  V20.2D, V31.2D, #0
    CMEQ  V26.2D, V29.2D, V7.2D
    CMEQ  V12.4S, V9.4S, V1.4S
    FCMGE  V21.2D, V12.2D, #0.0
    FCMLT  V3.2D, V1.2D, #0.0
    FCMGT  V14.4H, V20.4H, V11.4H
    FCMGE  V31.4S, V3.4S, #0.0
    FCMEQ  V3.2S, V21.2S, #0.0
    FCMEQ  V11.2D, V30.2D, V16.2D
    FCMGT  V12.8H, V26.8H, #0.0
    CMGT  V19.4S, V11.4S, #0
    FCMLE  V4.4H, V4.4H, #0.0
    CMGE  V21.2S, V3.2S, V18.2S
    CMGT  V18.16B, V19.16B, #0
    FCMGT  V25.2S, V14.2S, V18.2S
    FCMGT  V0.4H, V31.4H, #0.0
    CMGE  V3.2S, V4.2S, #0
    FCMEQ  V25.4H, V3.4H, #0.0
    FCMGE  V14.2D, V25.2D, #0.0
    CMGE  V27.4H, V0.4H, #0
    CMHS  V29.2D, V19.2D, V5.2D
    FCMGT  V4.2S, V14.2S, V20.2S
    CMGT  V30.8B, V9.8B, V29.8B
    CMHI  V26.4H, V4.4H, V4.4H
    FCMGT  V16.2D, V8.2D, #0.0
    FCMLT  V27.4S, V8.4S, #0.0
    CMGE  V20.2S, V31.2S, #0
    FCMGT  V11.4H, V20.4H, V26.4H
    FCMLE  V7.4H, V11.4H, #0.0
    CMGE  V31.4S, V21.4S, V30.4S
    CMEQ  V18.4S, V12.4S, V7.4S
    CMGT  V20.16B, V18.16B, #0
    CMGT  V18.4H, V12.4H, #0
    FCMEQ  V26.2D, V20.2D, #0.0
    FCMGT  V3.2S, V7.2S, #0.0
    CMHS  V5.4H, V18.4H, V6.4H
    SUBS  X6, X6, #0x1
    B.NE  TSRTAdvsimdVectorCompare_label_6
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorCompare_TestFail
    MRS  X9, FPSR
    MOVZ  X15, #0x81, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V0.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D0
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V1.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D1
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D2
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D3
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D4
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V5.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D5
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D6
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V7.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D7
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D8
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V9.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D9
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D10
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V11.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D11
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V12.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D12
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V13.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D13
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D14
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D15
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D16
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V17.D[1]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D17
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V18.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D18
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V19.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D19
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V20.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D20
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D21
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V22.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D22
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D23
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V24.D[1]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D24
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D25
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D26
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V27.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D27
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V28.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D28
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D29
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V30.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D30
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, V31.D[1]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X9, D31
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
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
    FMOV  D0, X23
    FMOV  V0.D[1], X8
    FMOV  D1, X29
    FMOV  V1.D[1], X25
    FMOV  D2, X26
    FMOV  V2.D[1], X27
    FMOV  D3, X28
    FMOV  V3.D[1], X26
    FMOV  D4, X10
    FMOV  V4.D[1], X6
    FMOV  D5, X17
    FMOV  V5.D[1], X26
    FMOV  D6, X10
    FMOV  V6.D[1], X16
    FMOV  D7, X8
    FMOV  V7.D[1], X11
    FMOV  D8, X15
    FMOV  V8.D[1], X23
    FMOV  D9, X6
    FMOV  V9.D[1], X10
    FMOV  D10, X8
    FMOV  V10.D[1], X16
    FMOV  D11, X4
    FMOV  V11.D[1], X11
    FMOV  D12, X11
    FMOV  V12.D[1], X8
    FMOV  D13, X28
    FMOV  V13.D[1], X9
    FMOV  D14, X4
    FMOV  V14.D[1], X2
    FMOV  D15, X16
    FMOV  V15.D[1], X4
    FMOV  D16, X2
    FMOV  V16.D[1], X26
    FMOV  D17, X25
    FMOV  V17.D[1], X3
    FMOV  D18, X12
    FMOV  V18.D[1], X12
    FMOV  D19, X16
    FMOV  V19.D[1], X10
    FMOV  D20, X8
    FMOV  V20.D[1], X4
    FMOV  D21, X28
    FMOV  V21.D[1], X17
    FMOV  D22, X27
    FMOV  V22.D[1], X27
    FMOV  D23, X25
    FMOV  V23.D[1], X24
    FMOV  D24, X5
    FMOV  V24.D[1], X14
    FMOV  D25, X28
    FMOV  V25.D[1], X6
    FMOV  D26, X29
    FMOV  V26.D[1], X25
    FMOV  D27, X27
    FMOV  V27.D[1], X7
    FMOV  D28, X24
    FMOV  V28.D[1], X26
    FMOV  D29, X3
    FMOV  V29.D[1], X8
    FMOV  D30, X8
    FMOV  V30.D[1], X17
    FMOV  D31, X12
    FMOV  V31.D[1], X28
    MOVZ  X8, #0xa, LSL #0
TSRTAdvsimdVectorCompare_label_7:
    CMGT  V31.8B, V23.8B, #0
    FCMGT  V19.4H, V31.4H, V4.4H
    FCMGT  V23.4S, V14.4S, V26.4S
    FCMEQ  V26.8H, V19.8H, #0.0
    CMLT  V20.2S, V30.2S, #0
    CMGE  V23.16B, V29.16B, #0
    CMEQ  V17.16B, V18.16B, V26.16B
    CMLT  V9.4H, V20.4H, #0
    CMLT  V25.4S, V27.4S, #0
    FCMLE  V10.8H, V9.8H, #0.0
    FCMGT  V4.4S, V17.4S, #0.0
    FCMGT  V9.8H, V10.8H, V24.8H
    FCMGT  V30.4S, V23.4S, V3.4S
    FCMEQ  V28.8H, V30.8H, V9.8H
    CMHS  V14.16B, V13.16B, V25.16B
    CMHI  V23.16B, V14.16B, V24.16B
    FCMEQ  V10.2S, V4.2S, #0.0
    CMLT  V5.4H, V9.4H, #0
    FCMLE  V20.4H, V18.4H, #0.0
    FCMGT  V9.2D, V28.2D, #0.0
    FCMLT  V8.4S, V9.4S, #0.0
    FCMGE  V26.8H, V10.8H, #0.0
    FCMEQ  V17.8H, V26.8H, #0.0
    CMGT  V13.2D, V8.2D, V8.2D
    CMTST  V18.8B, V31.8B, V20.8B
    FCMEQ  V20.4H, V13.4H, V15.4H
    FCMGE  V27.2D, V20.2D, #0.0
    CMGE  V27.4H, V18.4H, V12.4H
    FCMEQ  V31.2S, V27.2S, V27.2S
    CMHI  V27.2D, V17.2D, V23.2D
    FCMGT  V14.8H, V2.8H, V23.8H
    FCMGE  V20.2S, V31.2S, V19.2S
    CMHS  V23.8B, V25.8B, V29.8B
    FCMLE  V25.2D, V20.2D, #0.0
    FCMLE  V24.2D, V12.2D, #0.0
    FCMGT  V4.8H, V24.8H, V25.8H
    CMTST  V15.8B, V23.8B, V5.8B
    FCMGT  V30.8H, V14.8H, #0.0
    FCMGT  V9.4H, V4.4H, #0.0
    CMGE  V12.2S, V27.2S, V30.2S
    FCMGT  V14.2D, V12.2D, V9.2D
    FCMGE  V23.2D, V5.2D, #0.0
    CMLT  V17.8B, V30.8B, #0
    FCMLE  V30.2D, V18.2D, #0.0
    FCMEQ  V24.2S, V9.2S, #0.0
    FCMLE  V16.4H, V3.4H, #0.0
    FCMGE  V3.4H, V21.4H, V18.4H
    CMTST  V29.4S, V26.4S, V25.4S
    FCMGE  V2.4S, V20.4S, V3.4S
    CMGT  V31.8B, V16.8B, V29.8B
    FCMEQ  V27.8H, V24.8H, V14.8H
    FCMGE  V3.8H, V22.8H, V15.8H
    CMGT  V20.2S, V27.2S, #0
    FCMLE  V18.2S, V17.2S, #0.0
    CMLE  V25.4S, V20.4S, #0
    CMTST  V16.4H, V13.4H, V0.4H
    FCMGE  V0.2D, V12.2D, #0.0
    FCMEQ  V21.8H, V0.8H, V2.8H
    CMEQ  V12.2D, V31.2D, #0
    FCMGT  V15.2S, V18.2S, V25.2S
    FCMGT  V5.8H, V16.8H, V30.8H
    FCMLE  V4.4H, V21.4H, #0.0
    CMEQ  V3.16B, V23.16B, #0
    CMEQ  V11.8B, V4.8B, V13.8B
    FCMLT  V26.2S, V11.2S, #0.0
    CMHI  V17.2D, V3.2D, V15.2D
    CMHI  V30.4S, V12.4S, V23.4S
    FCMGE  V9.2D, V30.2D, V29.2D
    FCMEQ  V16.8H, V9.8H, #0.0
    CMGE  V9.4S, V5.4S, V16.4S
    FCMGE  V0.4H, V6.4H, #0.0
    FCMEQ  V5.2D, V24.2D, #0.0
    FCMGT  V13.8H, V3.8H, V14.8H
    FCMEQ  V23.4S, V0.4S, #0.0
    FCMGE  V29.8H, V23.8H, V17.8H
    CMEQ  V12.8H, V16.8H, V28.8H
    CMLT  V28.8B, V9.8B, #0
    CMGT  V3.4H, V6.4H, #0
    CMLT  V6.16B, V3.16B, #0
    FCMEQ  V23.2S, V0.2S, #0.0
    FCMGT  V15.8H, V5.8H, V5.8H
    CMEQ  V11.8H, V12.8H, V28.8H
    FCMEQ  V9.4H, V0.4H, V23.4H
    FCMGE  V4.4S, V23.4S, #0.0
    CMEQ  V28.16B, V5.16B, #0
    FCMGT  V16.2S, V28.2S, V14.2S
    CMEQ  V30.8B, V29.8B, #0
    CMGT  V28.8B, V9.8B, V27.8B
    FCMLE  V22.2D, V11.2D, #0.0
    FCMEQ  V5.2S, V30.2S, #0.0
    FCMEQ  V24.4H, V5.4H, V31.4H
    CMGT  V18.16B, V26.16B, V13.16B
    CMGT  V0.8H, V15.8H, #0
    FCMLE  V29.8H, V31.8H, #0.0
    FCMGT  V27.8H, V28.8H, V6.8H
    FCMGE  V16.4S, V29.4S, V22.4S
    CMHI  V22.2S, V27.2S, V4.2S
    FCMLE  V14.4H, V25.4H, #0.0
    FCMEQ  V25.2D, V26.2D, V2.2D
    CMEQ  V2.2S, V11.2S, V13.2S
    CMTST  V28.8B, V26.8B, V5.8B
    FCMGT  V29.2D, V20.2D, #0.0
    CMEQ  V30.8B, V15.8B, #0
    CMEQ  V23.8H, V5.8H, #0
    CMLE  V12.8H, V1.8H, #0
    FCMGE  V3.4S, V28.4S, V16.4S
    CMEQ  V2.4S, V2.4S, V18.4S
    FCMLT  V22.2D, V3.2D, #0.0
    FCMGT  V9.4S, V30.4S, #0.0
    CMEQ  V13.4S, V22.4S, V25.4S
    FCMEQ  V1.2S, V24.2S, #0.0
    CMGE  V15.2S, V9.2S, #0
    FCMLE  V11.2D, V31.2D, #0.0
    FCMLT  V25.4H, V12.4H, #0.0
    CMEQ  V16.4S, V2.4S, #0
    FCMLE  V24.2D, V19.2D, #0.0
    FCMGT  V1.4H, V25.4H, #0.0
    FCMLT  V27.8H, V2.8H, #0.0
    FCMEQ  V26.2D, V15.2D, V23.2D
    FCMEQ  V28.8H, V29.8H, V18.8H
    FCMGT  V31.8H, V29.8H, V24.8H
    FCMLT  V9.4H, V28.4H, #0.0
    FCMGE  V30.2D, V27.2D, V13.2D
    CMEQ  V24.8B, V26.8B, V9.8B
    CMTST  V13.8B, V16.8B, V14.8B
    FCMGT  V22.4S, V24.4S, #0.0
    CMEQ  V19.16B, V28.16B, #0
    CMGT  V3.2D, V31.2D, #0
    CMGT  V2.4S, V19.4S, V16.4S
    FCMGE  V15.4H, V5.4H, #0.0
    FCMEQ  V5.8H, V31.8H, V3.8H
    CMEQ  V23.16B, V2.16B, #0
    FCMEQ  V25.2D, V23.2D, #0.0
    FCMGE  V19.4H, V25.4H, V15.4H
    FCMLE  V2.8H, V11.8H, #0.0
    FCMLE  V15.2S, V22.2S, #0.0
    FCMEQ  V29.4S, V15.4S, V15.4S
    FCMGT  V24.4H, V2.4H, V19.4H
    CMGT  V1.8B, V13.8B, #0
    CMGE  V25.16B, V25.16B, V24.16B
    CMLT  V27.4S, V29.4S, #0
    CMTST  V29.4H, V7.4H, V30.4H
    FCMLE  V28.2D, V5.2D, #0.0
    FCMLE  V2.2S, V27.2S, #0.0
    FCMGT  V27.4S, V2.4S, #0.0
    FCMGE  V15.2S, V26.2S, V20.2S
    FCMEQ  V13.4H, V29.4H, V29.4H
    CMGT  V24.4S, V25.4S, #0
    FCMEQ  V10.2S, V27.2S, V27.2S
    CMHS  V29.8H, V13.8H, V28.8H
    FCMGT  V27.4H, V29.4H, #0.0
    CMHS  V14.2S, V7.2S, V9.2S
    CMEQ  V16.4H, V1.4H, #0
    FCMGT  V1.8H, V16.8H, V27.8H
    CMGT  V20.8B, V18.8B, V21.8B
    FCMGE  V14.4H, V20.4H, #0.0
    FCMLT  V5.2D, V10.2D, #0.0
    FCMLE  V18.2S, V17.2S, #0.0
    FCMGT  V9.4H, V20.4H, #0.0
    FCMGT  V31.4H, V5.4H, V24.4H
    FCMEQ  V4.2S, V31.2S, #0.0
    CMEQ  V2.16B, V1.16B, V9.16B
    CMGT  V25.2S, V27.2S, V4.2S
    FCMGE  V21.2S, V25.2S, #0.0
    FCMLT  V24.8H, V11.8H, #0.0
    FCMEQ  V9.4S, V2.4S, #0.0
    FCMGT  V26.2D, V2.2D, V18.2D
    FCMGE  V7.8H, V13.8H, V14.8H
    FCMLT  V1.2D, V26.2D, #0.0
    FCMGT  V26.8H, V15.8H, #0.0
    FCMGE  V30.2D, V26.2D, V10.2D
    FCMLE  V31.4H, V24.4H, #0.0
    FCMLE  V15.4H, V21.4H, #0.0
    CMLT  V5.16B, V0.16B, #0
    FCMLT  V10.4H, V7.4H, #0.0
    FCMLT  V0.8H, V31.8H, #0.0
    CMGE  V17.2S, V5.2S, #0
    FCMLT  V26.2S, V0.2S, #0.0
    FCMEQ  V14.4H, V30.4H, #0.0
    CMGE  V26.2D, V10.2D, V19.2D
    CMEQ  V18.4S, V29.4S, V1.4S
    FCMEQ  V0.4H, V28.4H, #0.0
    FCMEQ  V28.2S, V7.2S, V18.2S
    FCMGT  V20.4S, V28.4S, V15.4S
    CMLE  V4.2S, V13.2S, #0
    CMGT  V29.8B, V14.8B, V3.8B
    FCMGT  V9.4H, V17.4H, V26.4H
    FCMEQ  V3.2D, V9.2D, #0.0
    FCMGT  V9.4H, V26.4H, V7.4H
    CMEQ  V24.2S, V15.2S, V4.2S
    CMHI  V31.8H, V9.8H, V12.8H
    FCMGE  V14.2S, V25.2S, V21.2S
    CMEQ  V14.4H, V7.4H, V13.4H
    FCMGE  V5.2D, V14.2D, #0.0
    CMHS  V15.2D, V20.2D, V3.2D
    CMHI  V3.2D, V28.2D, V21.2D
    FCMLT  V17.4S, V29.4S, #0.0
    FCMEQ  V19.4S, V24.4S, V19.4S
    FCMGE  V12.2S, V11.2S, V26.2S
    FCMLT  V4.4H, V3.4H, #0.0
    SUBS  X8, X8, #0x1
    B.NE  TSRTAdvsimdVectorCompare_label_7
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X6, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X6, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X6, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X6, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X6, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X6, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X6, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X6, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X6, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X6, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X6, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X6, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X6, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X6, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X6, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X6, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X6, X29, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X6, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X6, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    MRS  X29, FPSR
    MOVZ  X6, #0x81, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V0.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D0
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V1.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D1
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D2
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V3.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D3
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V4.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D4
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V5.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D5
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V6.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D6
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D7
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V8.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D8
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V9.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D9
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V10.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D10
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V11.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D11
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V12.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D12
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V13.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D13
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D14
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V15.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D15
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V16.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D16
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D17
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V18.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D18
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V19.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D19
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D20
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D21
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V22.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D22
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D23
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D24
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V25.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D25
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V26.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D26
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D27
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D28
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V29.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D29
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V30.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D30
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, V31.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X29, D31
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorCompare_TestFail
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
    FMOV  V1.D[1], X25
    FMOV  D2, X26
    FMOV  V2.D[1], X5
    FMOV  D3, X27
    FMOV  V3.D[1], X6
    FMOV  D4, X17
    FMOV  V4.D[1], X4
    FMOV  D5, X4
    FMOV  V5.D[1], X4
    FMOV  D6, X26
    FMOV  V6.D[1], X4
    FMOV  D7, X9
    FMOV  V7.D[1], X7
    FMOV  D8, X17
    FMOV  V8.D[1], X6
    FMOV  D9, X25
    FMOV  V9.D[1], X23
    FMOV  D10, X8
    FMOV  V10.D[1], X9
    FMOV  D11, X16
    FMOV  V11.D[1], X5
    FMOV  D12, X9
    FMOV  V12.D[1], X25
    FMOV  D13, X9
    FMOV  V13.D[1], X2
    FMOV  D14, X13
    FMOV  V14.D[1], X10
    FMOV  D15, X10
    FMOV  V15.D[1], X6
    FMOV  D16, X23
    FMOV  V16.D[1], X24
    FMOV  D17, X11
    FMOV  V17.D[1], X17
    FMOV  D18, X11
    FMOV  V18.D[1], X29
    FMOV  D19, X23
    FMOV  V19.D[1], X6
    FMOV  D20, X4
    FMOV  V20.D[1], X14
    FMOV  D21, X11
    FMOV  V21.D[1], X27
    FMOV  D22, X9
    FMOV  V22.D[1], X4
    FMOV  D23, X26
    FMOV  V23.D[1], X25
    FMOV  D24, X16
    FMOV  V24.D[1], X6
    FMOV  D25, X25
    FMOV  V25.D[1], X8
    FMOV  D26, X23
    FMOV  V26.D[1], X6
    FMOV  D27, X2
    FMOV  V27.D[1], X11
    FMOV  D28, X28
    FMOV  V28.D[1], X11
    FMOV  D29, X15
    FMOV  V29.D[1], X29
    FMOV  D30, X27
    FMOV  V30.D[1], X28
    FMOV  D31, X3
    FMOV  V31.D[1], X9
    MOVZ  X2, #0xa, LSL #0
TSRTAdvsimdVectorCompare_label_8:
    CMGT  V9.2S, V28.2S, V9.2S
    FCMGT  V18.2D, V27.2D, V31.2D
    FCMEQ  V13.4H, V30.4H, V19.4H
    CMGE  V12.16B, V26.16B, V29.16B
    FCMGE  V27.2S, V10.2S, #0.0
    FCMGE  V3.4H, V13.4H, #0.0
    CMHI  V2.8B, V21.8B, V27.8B
    CMLT  V10.2D, V3.2D, #0
    FCMGE  V6.2D, V18.2D, V22.2D
    FCMGT  V19.4S, V23.4S, #0.0
    CMHI  V15.8B, V6.8B, V12.8B
    CMEQ  V13.4S, V15.4S, #0
    FCMEQ  V8.2D, V19.2D, #0.0
    FCMEQ  V3.4H, V9.4H, #0.0
    FCMEQ  V6.8H, V27.8H, V3.8H
    FCMGE  V18.8H, V1.8H, #0.0
    FCMGE  V23.8H, V3.8H, V18.8H
    FCMGE  V21.2D, V4.2D, #0.0
    CMHS  V19.2S, V0.2S, V21.2S
    FCMEQ  V12.4S, V6.4S, V6.4S
    FCMGT  V31.2S, V19.2S, #0.0
    FCMGT  V30.2D, V6.2D, V8.2D
    FCMGT  V8.4H, V30.4H, V12.4H
    FCMLT  V27.2D, V8.2D, #0.0
    CMEQ  V24.2D, V13.2D, #0
    CMHS  V0.2D, V23.2D, V27.2D
    FCMGE  V21.8H, V24.8H, V31.8H
    FCMGT  V9.2S, V2.2S, #0.0
    FCMGE  V1.2D, V0.2D, V10.2D
    CMHI  V29.4S, V12.4S, V1.4S
    FCMEQ  V6.2D, V9.2D, #0.0
    CMGT  V2.8B, V21.8B, #0
    FCMEQ  V19.4S, V29.4S, V11.4S
    FCMGT  V9.4H, V6.4H, #0.0
    FCMEQ  V21.4H, V2.4H, V15.4H
    FCMLT  V15.2S, V9.2S, #0.0
    CMHI  V6.8H, V9.8H, V10.8H
    CMGE  V30.4S, V7.4S, #0
    FCMGE  V10.4S, V11.4S, V15.4S
    FCMEQ  V24.8H, V6.8H, V24.8H
    CMLE  V0.16B, V24.16B, #0
    FCMEQ  V9.4H, V22.4H, V23.4H
    FCMGE  V31.4H, V30.4H, #0.0
    FCMEQ  V22.8H, V3.8H, #0.0
    FCMGT  V30.2S, V19.2S, #0.0
    FCMGT  V19.2D, V23.2D, V21.2D
    CMEQ  V3.4H, V31.4H, #0
    CMGT  V21.4H, V30.4H, V3.4H
    FCMEQ  V6.2D, V22.2D, V19.2D
    FCMLE  V7.8H, V10.8H, #0.0
    FCMGT  V29.4S, V0.4S, V6.4S
    CMEQ  V6.2D, V9.2D, #0
    FCMGE  V31.8H, V29.8H, #0.0
    FCMGE  V1.4H, V29.4H, #0.0
    FCMGT  V19.4H, V10.4H, #0.0
    FCMGT  V12.8H, V19.8H, #0.0
    CMLT  V29.2S, V6.2S, #0
    CMEQ  V11.4H, V7.4H, #0
    FCMGE  V13.8H, V8.8H, #0.0
    FCMEQ  V24.4S, V11.4S, V21.4S
    CMGT  V22.2S, V9.2S, V13.2S
    FCMLT  V19.4S, V26.4S, #0.0
    FCMEQ  V10.2D, V21.2D, V22.2D
    FCMGE  V6.8H, V12.8H, #0.0
    CMGE  V26.4S, V6.4S, V20.4S
    CMGT  V9.16B, V10.16B, #0
    CMLE  V29.2D, V19.2D, #0
    FCMGE  V20.4S, V28.4S, V5.4S
    CMGE  V30.8B, V30.8B, V20.8B
    CMGE  V28.16B, V30.16B, #0
    FCMGT  V7.2D, V28.2D, V1.2D
    FCMEQ  V28.4H, V24.4H, #0.0
    CMGT  V10.16B, V9.16B, #0
    FCMLE  V9.2S, V1.2S, #0.0
    FCMLE  V8.8H, V25.8H, #0.0
    FCMGE  V20.4H, V23.4H, V31.4H
    FCMGT  V0.2S, V21.2S, #0.0
    FCMEQ  V22.2D, V27.2D, V28.2D
    FCMGT  V25.8H, V10.8H, V9.8H
    FCMEQ  V19.2S, V22.2S, V7.2S
    FCMLE  V5.2D, V0.2D, #0.0
    FCMGE  V10.8H, V2.8H, #0.0
    FCMEQ  V12.4S, V11.4S, V19.4S
    FCMGE  V8.2S, V23.2S, V26.2S
    CMGE  V27.8H, V10.8H, #0
    FCMLE  V23.8H, V25.8H, #0.0
    FCMLT  V0.4H, V8.4H, #0.0
    FCMGT  V30.2D, V9.2D, V23.2D
    FCMGE  V26.4S, V0.4S, V13.4S
    CMGT  V28.2S, V27.2S, V20.2S
    FCMEQ  V11.2D, V0.2D, #0.0
    FCMLE  V25.2S, V9.2S, #0.0
    FCMGE  V0.2S, V30.2S, V4.2S
    CMEQ  V30.2D, V11.2D, V5.2D
    FCMGE  V13.4S, V28.4S, #0.0
    FCMGE  V10.2S, V26.2S, #0.0
    FCMGE  V2.8H, V30.8H, #0.0
    FCMGT  V30.8H, V12.8H, V13.8H
    FCMGT  V23.2D, V10.2D, #0.0
    FCMLE  V20.2S, V11.2S, #0.0
    FCMLT  V11.8H, V2.8H, #0.0
    FCMGT  V10.4H, V30.4H, #0.0
    FCMGT  V9.4H, V8.4H, #0.0
    FCMLE  V15.8H, V9.8H, #0.0
    CMEQ  V9.2S, V30.2S, #0
    CMGE  V8.2S, V23.2S, #0
    CMLT  V5.8B, V10.8B, #0
    FCMGE  V12.4S, V20.4S, V0.4S
    CMGE  V28.2D, V5.2D, V1.2D
    FCMGE  V2.2D, V9.2D, #0.0
    FCMLE  V23.4H, V4.4H, #0.0
    FCMLT  V4.8H, V8.8H, #0.0
    FCMEQ  V26.8H, V26.8H, V25.8H
    CMHI  V20.8B, V20.8B, V23.8B
    FCMEQ  V13.2D, V4.2D, #0.0
    CMGT  V5.8H, V12.8H, V13.8H
    CMHI  V9.2D, V5.2D, V20.2D
    CMHI  V12.4H, V28.4H, V11.4H
    CMLE  V28.8H, V3.8H, #0
    CMGT  V26.8B, V2.8B, #0
    FCMGE  V11.2D, V26.2D, V14.2D
    FCMLT  V25.4S, V20.4S, #0.0
    FCMEQ  V13.4H, V25.4H, #0.0
    CMHS  V8.4H, V13.4H, V28.4H
    CMLE  V10.8H, V8.8H, #0
    FCMEQ  V8.4H, V4.4H, #0.0
    FCMLT  V4.8H, V13.8H, #0.0
    FCMGE  V26.8H, V10.8H, #0.0
    CMHI  V0.8H, V3.8H, V20.8H
    FCMEQ  V10.4S, V4.4S, #0.0
    FCMGE  V23.8H, V10.8H, V26.8H
    FCMGT  V19.2D, V6.2D, #0.0
    CMGE  V4.4S, V19.4S, #0
    FCMLT  V26.2S, V26.2S, #0.0
    CMHS  V6.8H, V23.8H, V23.8H
    CMGT  V29.8H, V23.8H, V26.8H
    FCMGE  V13.2D, V0.2D, V31.2D
    FCMGE  V26.4H, V4.4H, V29.4H
    FCMLT  V19.8H, V8.8H, #0.0
    CMGE  V2.4H, V31.4H, #0
    CMTST  V23.8H, V3.8H, V19.8H
    FCMEQ  V4.4S, V26.4S, #0.0
    CMEQ  V5.4H, V4.4H, #0
    FCMGE  V3.2S, V19.2S, #0.0
    CMGE  V26.8B, V25.8B, #0
    FCMLT  V10.2D, V5.2D, #0.0
    CMHS  V8.2S, V13.2S, V13.2S
    CMLE  V15.16B, V10.16B, #0
    FCMGT  V29.2D, V24.2D, #0.0
    CMGT  V4.8B, V23.8B, V30.8B
    FCMEQ  V25.4S, V3.4S, V11.4S
    FCMGT  V11.4S, V6.4S, V2.4S
    FCMGT  V28.4H, V29.4H, #0.0
    CMGT  V3.2D, V4.2D, #0
    CMTST  V8.16B, V11.16B, V1.16B
    CMEQ  V4.8H, V23.8H, #0
    CMGT  V30.8H, V3.8H, V10.8H
    FCMEQ  V24.8H, V15.8H, #0.0
    FCMLT  V13.4H, V7.4H, #0.0
    FCMLE  V11.4S, V4.4S, #0.0
    CMEQ  V1.16B, V13.16B, #0
    FCMLE  V12.4H, V24.4H, #0.0
    FCMLT  V24.8H, V15.8H, #0.0
    CMEQ  V28.2S, V26.2S, #0
    FCMEQ  V26.4H, V1.4H, V30.4H
    FCMEQ  V11.4H, V26.4H, V11.4H
    FCMGE  V31.2S, V25.2S, V30.2S
    FCMGT  V13.2S, V24.2S, #0.0
    CMHS  V26.8H, V8.8H, V11.8H
    CMEQ  V15.8H, V31.8H, V6.8H
    CMGE  V29.8B, V1.8B, #0
    CMGE  V31.2S, V31.2S, #0
    CMHI  V27.2D, V13.2D, V7.2D
    CMGT  V4.8B, V27.8B, V12.8B
    FCMLT  V1.4S, V4.4S, #0.0
    FCMGT  V3.2D, V19.2D, V0.2D
    FCMGE  V27.2S, V3.2S, #0.0
    FCMLT  V6.4S, V1.4S, #0.0
    FCMGE  V12.4H, V28.4H, V15.4H
    CMHS  V0.16B, V31.16B, V31.16B
    CMHS  V31.2D, V18.2D, V6.2D
    FCMGT  V18.4S, V13.4S, #0.0
    CMHI  V7.8B, V27.8B, V31.8B
    FCMLT  V3.4H, V26.4H, #0.0
    CMGT  V30.2S, V17.2S, V12.2S
    FCMGE  V25.2D, V4.2D, V18.2D
    FCMGE  V1.2S, V23.2S, #0.0
    FCMLT  V18.8H, V6.8H, #0.0
    CMGT  V27.8H, V22.8H, #0
    FCMEQ  V17.2D, V6.2D, V1.2D
    FCMGE  V1.8H, V17.8H, V7.8H
    FCMGT  V15.2D, V29.2D, #0.0
    FCMEQ  V6.4H, V11.4H, #0.0
    FCMLE  V6.4S, V12.4S, #0.0
    CMGE  V8.4H, V30.4H, #0
    FCMLT  V25.2D, V1.2D, #0.0
    FCMGT  V12.4H, V2.4H, V6.4H
    CMGE  V13.2D, V15.2D, V27.2D
    FCMLT  V26.8H, V2.8H, #0.0
    FCMLT  V19.8H, V5.8H, #0.0
    SUBS  X2, X2, #0x1
    B.NE  TSRTAdvsimdVectorCompare_label_8
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X27, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X27, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X27, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X27, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X27, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X27, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X27, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X27, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X27, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X27, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X27, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X27, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X27, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X27, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X27, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X27, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X27, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X27, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorCompare_TestFail
    MRS  X23, FPSR
    MOVZ  X27, #0x81, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V0.D[1]
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D0
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V1.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D1
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D2
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D3
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D4
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D5
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D6
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D7
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D8
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D9
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D10
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D11
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D12
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D13
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D14
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D15
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D16
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D17
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D18
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D19
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D20
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D21
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D22
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V23.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D23
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D24
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D25
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D26
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D27
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D28
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D29
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V30.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D30
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, V31.D[1]
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X23, D31
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorCompare_TestFail
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
    FMOV  D0, X11
    FMOV  V0.D[1], X9
    FMOV  D1, X28
    FMOV  V1.D[1], X7
    FMOV  D2, X10
    FMOV  V2.D[1], X6
    FMOV  D3, X6
    FMOV  V3.D[1], X29
    FMOV  D4, X12
    FMOV  V4.D[1], X12
    FMOV  D5, X27
    FMOV  V5.D[1], X11
    FMOV  D6, X8
    FMOV  V6.D[1], X9
    FMOV  D7, X28
    FMOV  V7.D[1], X15
    FMOV  D8, X24
    FMOV  V8.D[1], X14
    FMOV  D9, X14
    FMOV  V9.D[1], X26
    FMOV  D10, X27
    FMOV  V10.D[1], X24
    FMOV  D11, X25
    FMOV  V11.D[1], X6
    FMOV  D12, X28
    FMOV  V12.D[1], X16
    FMOV  D13, X7
    FMOV  V13.D[1], X2
    FMOV  D14, X9
    FMOV  V14.D[1], X12
    FMOV  D15, X24
    FMOV  V15.D[1], X3
    FMOV  D16, X26
    FMOV  V16.D[1], X12
    FMOV  D17, X28
    FMOV  V17.D[1], X2
    FMOV  D18, X2
    FMOV  V18.D[1], X7
    FMOV  D19, X6
    FMOV  V19.D[1], X16
    FMOV  D20, X25
    FMOV  V20.D[1], X10
    FMOV  D21, X14
    FMOV  V21.D[1], X9
    FMOV  D22, X13
    FMOV  V22.D[1], X24
    FMOV  D23, X5
    FMOV  V23.D[1], X10
    FMOV  D24, X25
    FMOV  V24.D[1], X16
    FMOV  D25, X15
    FMOV  V25.D[1], X13
    FMOV  D26, X4
    FMOV  V26.D[1], X6
    FMOV  D27, X16
    FMOV  V27.D[1], X3
    FMOV  D28, X8
    FMOV  V28.D[1], X10
    FMOV  D29, X15
    FMOV  V29.D[1], X7
    FMOV  D30, X3
    FMOV  V30.D[1], X27
    FMOV  D31, X13
    FMOV  V31.D[1], X12
    MOVZ  X23, #0xa, LSL #0
TSRTAdvsimdVectorCompare_label_9:
    FCMGT  V6.4H, V28.4H, #0.0
    CMTST  V24.2S, V25.2S, V24.2S
    CMLT  V19.8H, V26.8H, #0
    FCMGE  V31.4S, V30.4S, #0.0
    FCMGT  V30.2S, V19.2S, V31.2S
    CMGT  V2.16B, V27.16B, V27.16B
    FCMLT  V30.8H, V6.8H, #0.0
    FCMLT  V20.4S, V2.4S, #0.0
    FCMGE  V8.2S, V20.2S, V15.2S
    FCMGE  V17.4H, V29.4H, #0.0
    CMTST  V12.4H, V8.4H, V11.4H
    FCMGE  V28.2D, V24.2D, V30.2D
    FCMLT  V26.2S, V17.2S, #0.0
    FCMGE  V24.8H, V12.8H, V7.8H
    FCMGT  V17.4H, V24.4H, #0.0
    FCMGE  V30.4H, V27.4H, V17.4H
    FCMLT  V9.4H, V28.4H, #0.0
    FCMLT  V15.4S, V18.4S, #0.0
    FCMGT  V19.2S, V9.2S, V9.2S
    FCMEQ  V26.8H, V19.8H, V26.8H
    FCMLT  V1.2D, V27.2D, #0.0
    CMHS  V19.8H, V0.8H, V6.8H
    FCMGT  V12.8H, V26.8H, V29.8H
    CMHI  V11.4H, V30.4H, V30.4H
    CMGE  V24.16B, V6.16B, V10.16B
    FCMEQ  V27.4H, V12.4H, #0.0
    CMLT  V9.8H, V1.8H, #0
    FCMLE  V0.8H, V15.8H, #0.0
    FCMLT  V6.4S, V24.4S, #0.0
    CMHS  V8.4S, V9.4S, V11.4S
    FCMGE  V11.4H, V27.4H, #0.0
    FCMEQ  V1.4S, V6.4S, #0.0
    FCMEQ  V28.4S, V19.4S, #0.0
    CMGT  V15.8H, V0.8H, #0
    FCMEQ  V10.4H, V9.4H, #0.0
    FCMLT  V17.8H, V1.8H, #0.0
    CMEQ  V26.8H, V28.8H, #0
    CMHI  V9.4H, V10.4H, V11.4H
    CMGT  V11.8B, V26.8B, V6.8B
    CMGE  V1.2D, V17.2D, V25.2D
    FCMGE  V3.4S, V1.4S, V15.4S
    CMGT  V4.4S, V15.4S, #0
    CMGE  V30.4H, V4.4H, V11.4H
    FCMEQ  V1.8H, V3.8H, V8.8H
    FCMGT  V0.4S, V21.4S, V9.4S
    CMGE  V19.2S, V0.2S, #0
    CMGT  V0.4H, V19.4H, #0
    FCMEQ  V19.8H, V6.8H, V20.8H
    FCMGT  V24.8H, V0.8H, #0.0
    CMEQ  V17.8H, V24.8H, V24.8H
    FCMLT  V27.4H, V14.4H, #0.0
    FCMLE  V8.2S, V30.2S, #0.0
    CMLT  V28.4S, V19.4S, #0
    FCMLT  V25.4S, V9.4S, #0.0
    FCMGE  V3.8H, V11.8H, V17.8H
    FCMGE  V19.2S, V10.2S, #0.0
    FCMEQ  V1.4H, V3.4H, #0.0
    FCMLE  V21.4S, V8.4S, #0.0
    CMLE  V3.8B, V14.8B, #0
    CMHS  V8.2D, V1.2D, V25.2D
    CMLT  V4.8B, V28.8B, #0
    CMGT  V10.8B, V3.8B, #0
    FCMGT  V6.8H, V18.8H, V25.8H
    CMLE  V14.2S, V4.2S, #0
    CMGT  V1.2D, V27.2D, V0.2D
    CMTST  V0.4S, V19.4S, V14.4S
    FCMGE  V5.8H, V10.8H, V10.8H
    FCMGE  V18.2D, V8.2D, V6.2D
    FCMGE  V17.8H, V0.8H, #0.0
    CMLE  V0.4S, V13.4S, #0
    FCMLT  V6.4H, V26.4H, #0.0
    FCMLT  V4.8H, V21.8H, #0.0
    CMGT  V9.2S, V9.2S, #0
    CMGT  V8.8H, V3.8H, #0
    CMEQ  V19.2D, V1.2D, #0
    FCMGT  V14.8H, V19.8H, V18.8H
    FCMGT  V3.8H, V0.8H, V5.8H
    FCMLE  V18.4H, V14.4H, #0.0
    FCMGT  V28.4S, V18.4S, V6.4S
    FCMEQ  V6.2D, V8.2D, #0.0
    FCMGT  V11.4S, V9.4S, V0.4S
    FCMEQ  V13.2D, V3.2D, V16.2D
    CMTST  V16.16B, V7.16B, V28.16B
    CMGE  V26.4H, V5.4H, V17.4H
    CMEQ  V10.4S, V5.4S, #0
    FCMEQ  V5.8H, V16.8H, V6.8H
    CMHI  V16.8H, V13.8H, V13.8H
    FCMGT  V18.4S, V11.4S, #0.0
    CMGT  V26.8B, V10.8B, #0
    CMLT  V17.4H, V18.4H, #0
    CMLE  V12.8B, V19.8B, #0
    CMHI  V3.16B, V26.16B, V26.16B
    CMGT  V9.4H, V12.4H, V24.4H
    CMHI  V24.4H, V28.4H, V12.4H
    FCMGT  V26.4H, V14.4H, V5.4H
    CMLT  V7.2S, V24.2S, #0
    FCMLE  V12.8H, V8.8H, #0.0
    CMGE  V11.4H, V16.4H, #0
    FCMGT  V13.4H, V6.4H, V11.4H
    FCMGT  V11.4H, V26.4H, V17.4H
    FCMGE  V1.8H, V0.8H, #0.0
    FCMGE  V26.4H, V11.4H, V7.4H
    FCMLT  V8.4S, V9.4S, #0.0
    FCMLT  V17.8H, V1.8H, #0.0
    FCMEQ  V8.2D, V13.2D, V7.2D
    FCMGT  V1.8H, V8.8H, #0.0
    CMGT  V11.16B, V12.16B, V12.16B
    FCMLT  V16.8H, V1.8H, #0.0
    CMGT  V1.2D, V14.2D, V15.2D
    FCMGE  V22.4S, V11.4S, #0.0
    FCMLT  V13.4H, V22.4H, #0.0
    FCMGT  V8.2D, V12.2D, V3.2D
    FCMGE  V12.4H, V11.4H, #0.0
    CMGT  V14.8B, V15.8B, V17.8B
    CMHS  V24.8H, V15.8H, V31.8H
    FCMGE  V17.2S, V1.2S, V24.2S
    FCMEQ  V11.8H, V5.8H, V9.8H
    FCMGT  V3.2S, V8.2S, V25.2S
    FCMLE  V0.4H, V14.4H, #0.0
    FCMGT  V9.8H, V13.8H, V12.8H
    CMGE  V14.8B, V11.8B, V13.8B
    FCMGE  V10.2S, V0.2S, #0.0
    CMGE  V15.8B, V10.8B, #0
    FCMEQ  V22.2S, V9.2S, V6.2S
    FCMLE  V12.2S, V17.2S, #0.0
    FCMGE  V13.4H, V8.4H, #0.0
    FCMLT  V9.2S, V22.2S, #0.0
    FCMGE  V6.4S, V9.4S, V9.4S
    FCMGT  V11.4S, V1.4S, V13.4S
    CMEQ  V20.8B, V6.8B, #0
    CMEQ  V17.8H, V20.8H, #0
    CMEQ  V0.4H, V21.4H, V30.4H
    FCMLT  V22.4H, V15.4H, #0.0
    FCMEQ  V31.2S, V14.2S, #0.0
    FCMGE  V21.4S, V22.4S, V12.4S
    CMEQ  V12.2D, V30.2D, #0
    FCMLT  V1.2S, V0.2S, #0.0
    FCMGE  V0.4S, V21.4S, V12.4S
    CMEQ  V25.16B, V1.16B, V0.16B
    CMLE  V13.8H, V12.8H, #0
    CMHI  V1.2S, V3.2S, V17.2S
    CMLE  V3.2D, V13.2D, #0
    CMLT  V18.2D, V25.2D, #0
    CMHS  V12.2D, V1.2D, V18.2D
    CMGE  V0.4H, V31.4H, V12.4H
    CMGE  V14.8B, V3.8B, #0
    CMEQ  V30.4H, V0.4H, #0
    CMTST  V22.4S, V14.4S, V9.4S
    FCMEQ  V14.4H, V11.4H, #0.0
    FCMEQ  V18.2S, V22.2S, #0.0
    FCMEQ  V4.4H, V30.4H, V4.4H
    CMGT  V1.8B, V14.8B, #0
    CMEQ  V15.4H, V17.4H, V1.4H
    FCMGE  V12.4H, V18.4H, #0.0
    FCMGE  V17.4H, V15.4H, #0.0
    FCMEQ  V13.2S, V4.2S, #0.0
    FCMGE  V25.2S, V13.2S, V23.2S
    FCMLT  V21.8H, V12.8H, #0.0
    FCMGT  V14.4H, V25.4H, #0.0
    FCMLE  V15.8H, V18.8H, #0.0
    FCMGE  V3.2S, V21.2S, #0.0
    CMEQ  V0.8H, V17.8H, #0
    FCMGT  V5.4H, V14.4H, V20.4H
    CMGE  V14.16B, V1.16B, V31.16B
    CMGE  V27.8B, V23.8B, #0
    FCMEQ  V18.4H, V14.4H, V15.4H
    CMHI  V2.4H, V18.4H, V3.4H
    FCMGT  V27.2S, V3.2S, V5.2S
    FCMLT  V21.4H, V2.4H, #0.0
    CMEQ  V12.16B, V13.16B, V25.16B
    CMGE  V17.16B, V12.16B, #0
    CMEQ  V1.4S, V15.4S, #0
    FCMEQ  V23.4S, V17.4S, V27.4S
    CMGT  V24.8H, V18.8H, V21.8H
    FCMLE  V4.2D, V1.2D, #0.0
    FCMEQ  V27.4H, V23.4H, #0.0
    CMTST  V31.8H, V4.8H, V27.8H
    FCMEQ  V17.2D, V0.2D, #0.0
    FCMEQ  V18.4H, V24.4H, #0.0
    CMGE  V0.16B, V6.16B, V31.16B
    FCMLT  V12.2S, V18.2S, #0.0
    CMGT  V7.2S, V12.2S, V15.2S
    FCMGE  V14.8H, V0.8H, #0.0
    FCMGT  V2.2D, V14.2D, #0.0
    FCMGT  V30.8H, V11.8H, #0.0
    FCMGT  V18.2D, V5.2D, #0.0
    CMGE  V23.8H, V2.8H, #0
    FCMEQ  V0.4H, V17.4H, #0.0
    FCMEQ  V31.4H, V28.4H, #0.0
    FCMLE  V4.4S, V0.4S, #0.0
    CMEQ  V5.2D, V7.2D, V7.2D
    CMGT  V7.8H, V18.8H, V31.8H
    FCMEQ  V12.4S, V30.4S, V30.4S
    FCMGE  V21.2S, V23.2S, V16.2S
    CMGE  V31.2D, V9.2D, V22.2D
    FCMEQ  V6.4H, V29.4H, #0.0
    CMLE  V18.2S, V12.2S, #0
    FCMEQ  V9.2D, V4.2D, #0.0
    FCMLT  V11.4H, V17.4H, #0.0
    CMGT  V28.2S, V23.2S, #0
    SUBS  X23, X23, #0x1
    B.NE  TSRTAdvsimdVectorCompare_label_9
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X13, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X13, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X13, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X13, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X13, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X13, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X13, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X13, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X13, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X13, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X13, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X13, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X13, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X13, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X13, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X13, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X13, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X13, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X13, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MRS  X8, FPSR
    MOVZ  X13, #0x81, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V0.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D0
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V1.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D1
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D2
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D3
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D4
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D5
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D6
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D7
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V8.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D8
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D9
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D10
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D11
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D12
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D13
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D14
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D15
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D16
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D17
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D18
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D19
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D20
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D21
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D22
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D23
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D24
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D25
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D26
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D27
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D28
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D29
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V30.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D30
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, V31.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X8, D31
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X2, #0xaead, LSL #0
    MOVK  X2, #0xfe2d, LSL #16
    MOVK  X2, #0x830b, LSL #32
    MOVK  X2, #0x29ec, LSL #48
    MOVZ  X3, #0x9177, LSL #0
    MOVK  X3, #0xf451, LSL #16
    MOVK  X3, #0xd363, LSL #32
    MOVK  X3, #0x9000, LSL #48
    MOVZ  X4, #0x6cff, LSL #0
    MOVK  X4, #0xfe02, LSL #16
    MOVK  X4, #0x4490, LSL #32
    MOVK  X4, #0xd2a4, LSL #48
    MOVZ  X5, #0xb43, LSL #0
    MOVK  X5, #0x2bbc, LSL #16
    MOVK  X5, #0x87c, LSL #32
    MOVK  X5, #0x60de, LSL #48
    MOVZ  X6, #0x87ca, LSL #0
    MOVK  X6, #0x379e, LSL #16
    MOVK  X6, #0x2511, LSL #32
    MOVK  X6, #0x2035, LSL #48
    MOVZ  X7, #0x8024, LSL #0
    MOVK  X7, #0x3f70, LSL #16
    MOVK  X7, #0x2aca, LSL #32
    MOVK  X7, #0x9aec, LSL #48
    MOVZ  X8, #0x958e, LSL #0
    MOVK  X8, #0xfaf4, LSL #16
    MOVK  X8, #0xdff7, LSL #32
    MOVK  X8, #0x9c7c, LSL #48
    MOVZ  X9, #0x1151, LSL #0
    MOVK  X9, #0x72ac, LSL #16
    MOVK  X9, #0x9201, LSL #32
    MOVK  X9, #0x8d4b, LSL #48
    MOVZ  X10, #0x8ab6, LSL #0
    MOVK  X10, #0xe059, LSL #16
    MOVK  X10, #0x2641, LSL #32
    MOVK  X10, #0xb8ff, LSL #48
    MOVZ  X11, #0x2991, LSL #0
    MOVK  X11, #0x311a, LSL #16
    MOVK  X11, #0xd5f7, LSL #32
    MOVK  X11, #0x1b25, LSL #48
    MOVZ  X12, #0x9d7f, LSL #0
    MOVK  X12, #0x3e6c, LSL #16
    MOVK  X12, #0x42b3, LSL #32
    MOVK  X12, #0x8262, LSL #48
    MOVZ  X13, #0x61ee, LSL #0
    MOVK  X13, #0x8a30, LSL #16
    MOVK  X13, #0xe2eb, LSL #32
    MOVK  X13, #0x4591, LSL #48
    MOVZ  X14, #0x7cb0, LSL #0
    MOVK  X14, #0x8bc8, LSL #16
    MOVK  X14, #0x937b, LSL #32
    MOVK  X14, #0xb3b6, LSL #48
    MOVZ  X15, #0xc4af, LSL #0
    MOVK  X15, #0x578d, LSL #16
    MOVK  X15, #0x31f5, LSL #32
    MOVK  X15, #0x7fc0, LSL #48
    MOVZ  X16, #0x8319, LSL #0
    MOVK  X16, #0x7424, LSL #16
    MOVK  X16, #0xe7fa, LSL #32
    MOVK  X16, #0x9eae, LSL #48
    MOVZ  X17, #0x2091, LSL #0
    MOVK  X17, #0x58da, LSL #16
    MOVK  X17, #0x47b0, LSL #32
    MOVK  X17, #0x3b7a, LSL #48
    MOVZ  X23, #0xf267, LSL #0
    MOVK  X23, #0xfef0, LSL #16
    MOVK  X23, #0x52e5, LSL #32
    MOVK  X23, #0xe827, LSL #48
    MOVZ  X24, #0x25e9, LSL #0
    MOVK  X24, #0x5f68, LSL #16
    MOVK  X24, #0x7b61, LSL #32
    MOVK  X24, #0x26f, LSL #48
    MOVZ  X25, #0x6b4f, LSL #0
    MOVK  X25, #0x636, LSL #16
    MOVK  X25, #0xb9e0, LSL #32
    MOVK  X25, #0x7e9c, LSL #48
    MOVZ  X26, #0x8cde, LSL #0
    MOVK  X26, #0xc700, LSL #16
    MOVK  X26, #0x181a, LSL #32
    MOVK  X26, #0x95ad, LSL #48
    MOVZ  X27, #0xc0ac, LSL #0
    MOVK  X27, #0x3e52, LSL #16
    MOVK  X27, #0xf672, LSL #32
    MOVK  X27, #0x969, LSL #48
    MOVZ  X28, #0x207f, LSL #0
    MOVK  X28, #0xfba1, LSL #16
    MOVK  X28, #0x4f29, LSL #32
    MOVK  X28, #0xee2b, LSL #48
    MOVZ  X29, #0x15c6, LSL #0
    MOVK  X29, #0x7dca, LSL #16
    MOVK  X29, #0xaaaf, LSL #32
    MOVK  X29, #0x7e92, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X29
    FMOV  D1, X27
    FMOV  V1.D[1], X5
    FMOV  D2, X28
    FMOV  V2.D[1], X16
    FMOV  D3, X28
    FMOV  V3.D[1], X15
    FMOV  D4, X23
    FMOV  V4.D[1], X11
    FMOV  D5, X27
    FMOV  V5.D[1], X2
    FMOV  D6, X5
    FMOV  V6.D[1], X10
    FMOV  D7, X14
    FMOV  V7.D[1], X8
    FMOV  D8, X16
    FMOV  V8.D[1], X7
    FMOV  D9, X24
    FMOV  V9.D[1], X24
    FMOV  D10, X24
    FMOV  V10.D[1], X5
    FMOV  D11, X26
    FMOV  V11.D[1], X9
    FMOV  D12, X7
    FMOV  V12.D[1], X26
    FMOV  D13, X15
    FMOV  V13.D[1], X15
    FMOV  D14, X29
    FMOV  V14.D[1], X17
    FMOV  D15, X17
    FMOV  V15.D[1], X12
    FMOV  D16, X9
    FMOV  V16.D[1], X28
    FMOV  D17, X9
    FMOV  V17.D[1], X14
    FMOV  D18, X14
    FMOV  V18.D[1], X6
    FMOV  D19, X4
    FMOV  V19.D[1], X10
    FMOV  D20, X11
    FMOV  V20.D[1], X2
    FMOV  D21, X9
    FMOV  V21.D[1], X25
    FMOV  D22, X24
    FMOV  V22.D[1], X10
    FMOV  D23, X23
    FMOV  V23.D[1], X14
    FMOV  D24, X10
    FMOV  V24.D[1], X9
    FMOV  D25, X13
    FMOV  V25.D[1], X15
    FMOV  D26, X10
    FMOV  V26.D[1], X16
    FMOV  D27, X17
    FMOV  V27.D[1], X5
    FMOV  D28, X2
    FMOV  V28.D[1], X6
    FMOV  D29, X29
    FMOV  V29.D[1], X23
    FMOV  D30, X23
    FMOV  V30.D[1], X13
    FMOV  D31, X24
    FMOV  V31.D[1], X25
    MOVZ  X9, #0xa, LSL #0
TSRTAdvsimdVectorCompare_label_10:
    CMHS  V19.4H, V8.4H, V31.4H
    FCMGT  V4.2D, V31.2D, #0.0
    FCMEQ  V9.8H, V19.8H, V23.8H
    CMHS  V17.16B, V26.16B, V9.16B
    FCMGE  V22.4S, V13.4S, V4.4S
    CMHS  V18.4H, V12.4H, V29.4H
    FCMEQ  V27.4H, V25.4H, V4.4H
    CMHS  V26.16B, V28.16B, V28.16B
    FCMLE  V24.8H, V27.8H, #0.0
    CMTST  V5.2S, V22.2S, V26.2S
    CMTST  V10.8H, V17.8H, V24.8H
    CMLE  V8.2D, V10.2D, #0
    CMLE  V28.4H, V29.4H, #0
    CMLE  V12.8H, V28.8H, #0
    FCMLT  V9.2D, V30.2D, #0.0
    CMLE  V22.2S, V9.2S, #0
    FCMLT  V29.4H, V22.4H, #0.0
    FCMGT  V19.2D, V29.2D, #0.0
    FCMGT  V30.4H, V18.4H, V5.4H
    FCMGE  V11.2S, V30.2S, V27.2S
    FCMGE  V25.8H, V8.8H, #0.0
    FCMGE  V28.2D, V15.2D, #0.0
    CMEQ  V23.2S, V18.2S, V21.2S
    FCMGT  V29.8H, V0.8H, #0.0
    FCMGE  V13.4H, V5.4H, V23.4H
    FCMGT  V4.2S, V2.2S, V24.2S
    FCMGE  V14.4S, V13.4S, #0.0
    CMEQ  V31.4S, V14.4S, #0
    CMHS  V9.2S, V31.2S, V28.2S
    FCMGT  V3.4H, V11.4H, #0.0
    FCMGE  V20.4S, V25.4S, V29.4S
    CMGE  V16.8H, V12.8H, #0
    CMTST  V29.16B, V12.16B, V7.16B
    CMGT  V30.2D, V16.2D, V9.2D
    FCMGT  V11.4H, V20.4H, #0.0
    CMEQ  V7.2D, V3.2D, V30.2D
    FCMEQ  V18.2S, V26.2S, #0.0
    CMGT  V2.4H, V13.4H, V7.4H
    FCMGT  V8.8H, V19.8H, V6.8H
    FCMGE  V0.8H, V29.8H, #0.0
    FCMEQ  V25.2S, V18.2S, V5.2S
    FCMGE  V30.2S, V15.2S, #0.0
    FCMGT  V5.8H, V25.8H, V30.8H
    CMHS  V21.2S, V0.2S, V4.2S
    CMTST  V15.2S, V21.2S, V2.2S
    FCMLE  V7.4H, V2.4H, #0.0
    FCMGT  V18.4H, V8.4H, V30.4H
    FCMGE  V20.2S, V18.2S, V18.2S
    FCMEQ  V2.4H, V7.4H, #0.0
    FCMGT  V14.2D, V20.2D, V23.2D
    FCMEQ  V4.4H, V21.4H, V29.4H
    FCMGE  V13.2D, V2.2D, V4.2D
    CMHI  V4.8B, V28.8B, V5.8B
    CMEQ  V0.2D, V27.2D, #0
    CMEQ  V7.4H, V13.4H, #0
    FCMLT  V28.4S, V15.4S, #0.0
    CMHS  V23.4H, V21.4H, V0.4H
    FCMLE  V30.4S, V7.4S, #0.0
    CMTST  V25.4H, V14.4H, V14.4H
    CMLE  V12.8B, V4.8B, #0
    FCMLT  V0.2S, V25.2S, #0.0
    CMTST  V8.4H, V11.4H, V28.4H
    CMEQ  V15.4H, V8.4H, #0
    CMHI  V20.8H, V12.8H, V30.8H
    CMGE  V9.4S, V20.4S, V21.4S
    FCMGE  V8.8H, V15.8H, V21.8H
    CMHS  V14.4H, V19.4H, V0.4H
    CMTST  V7.2D, V15.2D, V17.2D
    CMEQ  V20.4S, V21.4S, V9.4S
    FCMEQ  V0.8H, V7.8H, #0.0
    CMEQ  V27.8H, V27.8H, V29.8H
    CMTST  V2.8H, V24.8H, V0.8H
    CMGE  V19.2S, V27.2S, V23.2S
    CMGE  V4.2D, V29.2D, #0
    FCMEQ  V23.4S, V10.4S, #0.0
    CMLE  V10.2D, V4.2D, #0
    FCMGE  V15.4H, V19.4H, V18.4H
    FCMGE  V11.2S, V10.2S, V14.2S
    CMGE  V9.8B, V11.8B, V19.8B
    CMTST  V14.4S, V25.4S, V29.4S
    FCMEQ  V19.4H, V9.4H, #0.0
    FCMEQ  V0.4S, V19.4S, V23.4S
    CMLT  V4.8H, V2.8H, #0
    FCMEQ  V6.2S, V8.2S, V15.2S
    FCMGE  V18.8H, V0.8H, V8.8H
    FCMGE  V22.2D, V14.2D, V6.2D
    FCMGT  V11.2S, V18.2S, V3.2S
    FCMEQ  V9.2S, V11.2S, #0.0
    CMLT  V17.4H, V30.4H, #0
    FCMEQ  V28.8H, V14.8H, V20.8H
    CMGT  V30.8H, V17.8H, V19.8H
    CMEQ  V6.4S, V9.4S, V10.4S
    FCMLE  V9.4H, V2.4H, #0.0
    FCMGE  V16.8H, V9.8H, V4.8H
    FCMEQ  V25.8H, V22.8H, V6.8H
    CMTST  V19.2S, V7.2S, V28.2S
    FCMEQ  V17.2S, V16.2S, #0.0
    FCMGT  V28.2S, V2.2S, V21.2S
    CMGE  V9.4H, V9.4H, V30.4H
    FCMGT  V0.8H, V28.8H, #0.0
    CMEQ  V15.8H, V17.8H, #0
    FCMGT  V30.8H, V29.8H, V19.8H
    FCMLE  V10.2S, V10.2S, #0.0
    CMGE  V18.4S, V29.4S, V28.4S
    CMHI  V2.8B, V7.8B, V10.8B
    FCMEQ  V20.4H, V19.4H, #0.0
    CMGT  V10.8B, V19.8B, #0
    FCMEQ  V23.4S, V2.4S, V10.4S
    FCMEQ  V28.8H, V23.8H, #0.0
    FCMEQ  V2.4H, V18.4H, V0.4H
    FCMGE  V0.2S, V25.2S, V12.2S
    CMGE  V25.16B, V18.16B, V2.16B
    FCMEQ  V18.2D, V20.2D, #0.0
    FCMGE  V29.4H, V9.4H, V9.4H
    CMGT  V21.8H, V29.8H, V20.8H
    FCMGT  V16.8H, V18.8H, V25.8H
    CMGT  V10.16B, V0.16B, V30.16B
    CMLE  V7.2S, V4.2S, #0
    CMGT  V27.16B, V30.16B, #0
    FCMGE  V1.8H, V4.8H, V21.8H
    CMGT  V23.8B, V1.8B, V15.8B
    CMGE  V30.4S, V10.4S, V27.4S
    FCMLE  V12.2S, V19.2S, #0.0
    FCMEQ  V6.4H, V28.4H, #0.0
    FCMLE  V4.4S, V22.4S, #0.0
    FCMGT  V19.8H, V7.8H, V9.8H
    CMEQ  V13.16B, V23.16B, V6.16B
    FCMLE  V6.8H, V19.8H, #0.0
    FCMLE  V17.2D, V12.2D, #0.0
    CMEQ  V28.2D, V17.2D, #0
    CMEQ  V10.4H, V9.4H, #0
    CMGT  V17.8H, V6.8H, #0
    FCMGE  V6.2D, V3.2D, V11.2D
    FCMGT  V9.8H, V10.8H, #0.0
    FCMLT  V20.2S, V16.2S, #0.0
    CMTST  V2.2S, V30.2S, V30.2S
    FCMEQ  V19.2D, V6.2D, #0.0
    FCMGE  V27.8H, V20.8H, #0.0
    CMEQ  V3.2S, V24.2S, V26.2S
    CMEQ  V11.4S, V17.4S, #0
    CMEQ  V17.4H, V9.4H, #0
    FCMEQ  V12.4H, V5.4H, #0.0
    FCMEQ  V24.8H, V5.8H, V15.8H
    FCMEQ  V10.4S, V12.4S, V2.4S
    CMTST  V6.16B, V27.16B, V24.16B
    FCMEQ  V0.2S, V28.2S, #0.0
    CMGT  V28.16B, V17.16B, #0
    FCMEQ  V9.2S, V4.2S, V4.2S
    CMGE  V30.4H, V28.4H, #0
    FCMEQ  V2.8H, V29.8H, V3.8H
    CMGE  V26.16B, V13.16B, V11.16B
    FCMLE  V9.4H, V26.4H, #0.0
    FCMGT  V2.2D, V10.2D, V9.2D
    FCMEQ  V10.2S, V19.2S, #0.0
    CMTST  V16.2S, V6.2S, V30.2S
    CMHI  V26.2D, V14.2D, V0.2D
    FCMLE  V13.8H, V2.8H, #0.0
    FCMGE  V14.4H, V13.4H, V16.4H
    FCMGT  V2.2S, V26.2S, V10.2S
    FCMGT  V26.4H, V1.4H, #0.0
    FCMGE  V15.4H, V19.4H, #0.0
    FCMGT  V9.4S, V14.4S, #0.0
    FCMLE  V19.2D, V21.2D, #0.0
    FCMGE  V21.4H, V18.4H, #0.0
    FCMLE  V17.2D, V24.2D, #0.0
    FCMLE  V10.2D, V31.2D, #0.0
    CMEQ  V13.2S, V9.2S, #0
    FCMEQ  V1.2S, V16.2S, V12.2S
    FCMGE  V3.2D, V26.2D, V21.2D
    CMEQ  V21.2S, V5.2S, #0
    FCMGT  V24.4S, V17.4S, V12.4S
    FCMLE  V26.4S, V2.4S, #0.0
    CMGE  V12.8H, V15.8H, V1.8H
    FCMLE  V2.4H, V4.4H, #0.0
    FCMGE  V28.4S, V19.4S, #0.0
    FCMGE  V18.4S, V26.4S, V13.4S
    FCMEQ  V13.2S, V24.2S, V28.2S
    CMLE  V10.2S, V5.2S, #0
    CMGE  V28.8B, V10.8B, V2.8B
    FCMGE  V29.8H, V18.8H, #0.0
    FCMGE  V10.4H, V2.4H, #0.0
    CMGE  V0.4H, V11.4H, V2.4H
    FCMGT  V1.4H, V10.4H, #0.0
    FCMLT  V30.2D, V20.2D, #0.0
    CMGE  V9.8H, V15.8H, #0
    FCMGT  V26.8H, V30.8H, V21.8H
    FCMLT  V4.8H, V1.8H, #0.0
    CMEQ  V18.4H, V29.4H, #0
    CMGT  V5.2D, V18.2D, #0
    FCMGT  V19.4H, V3.4H, V28.4H
    FCMGE  V20.4H, V9.4H, V19.4H
    CMGE  V19.4S, V13.4S, V5.4S
    CMEQ  V29.4S, V12.4S, #0
    CMHS  V15.8B, V20.8B, V26.8B
    FCMLT  V28.2D, V19.2D, #0.0
    CMLE  V24.8H, V28.8H, #0
    CMGT  V19.8B, V2.8B, #0
    FCMEQ  V26.4S, V19.4S, V29.4S
    CMGT  V19.4S, V10.4S, V14.4S
    FCMLE  V13.8H, V15.8H, #0.0
    SUBS  X9, X9, #0x1
    B.NE  TSRTAdvsimdVectorCompare_label_10
    MOVZ  X2, #0x9177, LSL #0
    MOVK  X2, #0xf451, LSL #16
    MOVK  X2, #0xd363, LSL #32
    MOVK  X2, #0x9000, LSL #48
    SUB  X24, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X2, #0x6cff, LSL #0
    MOVK  X2, #0xfe02, LSL #16
    MOVK  X2, #0x4490, LSL #32
    MOVK  X2, #0xd2a4, LSL #48
    SUB  X24, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X2, #0x87ca, LSL #0
    MOVK  X2, #0x379e, LSL #16
    MOVK  X2, #0x2511, LSL #32
    MOVK  X2, #0x2035, LSL #48
    SUB  X24, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X2, #0x8024, LSL #0
    MOVK  X2, #0x3f70, LSL #16
    MOVK  X2, #0x2aca, LSL #32
    MOVK  X2, #0x9aec, LSL #48
    SUB  X24, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X2, #0x958e, LSL #0
    MOVK  X2, #0xfaf4, LSL #16
    MOVK  X2, #0xdff7, LSL #32
    MOVK  X2, #0x9c7c, LSL #48
    SUB  X24, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X24, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X2, #0x8ab6, LSL #0
    MOVK  X2, #0xe059, LSL #16
    MOVK  X2, #0x2641, LSL #32
    MOVK  X2, #0xb8ff, LSL #48
    SUB  X24, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X2, #0x2991, LSL #0
    MOVK  X2, #0x311a, LSL #16
    MOVK  X2, #0xd5f7, LSL #32
    MOVK  X2, #0x1b25, LSL #48
    SUB  X24, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X2, #0x9d7f, LSL #0
    MOVK  X2, #0x3e6c, LSL #16
    MOVK  X2, #0x42b3, LSL #32
    MOVK  X2, #0x8262, LSL #48
    SUB  X24, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X2, #0x61ee, LSL #0
    MOVK  X2, #0x8a30, LSL #16
    MOVK  X2, #0xe2eb, LSL #32
    MOVK  X2, #0x4591, LSL #48
    SUB  X24, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X2, #0x7cb0, LSL #0
    MOVK  X2, #0x8bc8, LSL #16
    MOVK  X2, #0x937b, LSL #32
    MOVK  X2, #0xb3b6, LSL #48
    SUB  X24, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X2, #0xc4af, LSL #0
    MOVK  X2, #0x578d, LSL #16
    MOVK  X2, #0x31f5, LSL #32
    MOVK  X2, #0x7fc0, LSL #48
    SUB  X24, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X2, #0x8319, LSL #0
    MOVK  X2, #0x7424, LSL #16
    MOVK  X2, #0xe7fa, LSL #32
    MOVK  X2, #0x9eae, LSL #48
    SUB  X24, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X2, #0x2091, LSL #0
    MOVK  X2, #0x58da, LSL #16
    MOVK  X2, #0x47b0, LSL #32
    MOVK  X2, #0x3b7a, LSL #48
    SUB  X24, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X2, #0xf267, LSL #0
    MOVK  X2, #0xfef0, LSL #16
    MOVK  X2, #0x52e5, LSL #32
    MOVK  X2, #0xe827, LSL #48
    SUB  X24, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X2, #0x6b4f, LSL #0
    MOVK  X2, #0x636, LSL #16
    MOVK  X2, #0xb9e0, LSL #32
    MOVK  X2, #0x7e9c, LSL #48
    SUB  X24, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X2, #0x8cde, LSL #0
    MOVK  X2, #0xc700, LSL #16
    MOVK  X2, #0x181a, LSL #32
    MOVK  X2, #0x95ad, LSL #48
    SUB  X24, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X2, #0xc0ac, LSL #0
    MOVK  X2, #0x3e52, LSL #16
    MOVK  X2, #0xf672, LSL #32
    MOVK  X2, #0x969, LSL #48
    SUB  X24, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X2, #0x207f, LSL #0
    MOVK  X2, #0xfba1, LSL #16
    MOVK  X2, #0x4f29, LSL #32
    MOVK  X2, #0xee2b, LSL #48
    SUB  X24, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X2, #0x15c6, LSL #0
    MOVK  X2, #0x7dca, LSL #16
    MOVK  X2, #0xaaaf, LSL #32
    MOVK  X2, #0x7e92, LSL #48
    SUB  X24, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MRS  X2, FPSR
    MOVZ  X24, #0x81, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V0.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D0
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V1.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D1
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V2.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D2
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D3
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D4
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D5
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D6
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D7
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D8
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D9
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D10
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D11
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V12.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D12
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D13
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D14
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D15
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D16
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D17
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D18
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D19
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D20
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D21
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D22
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D23
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D24
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D25
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D26
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D27
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D28
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D29
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V30.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D30
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, V31.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X2, D31
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorCompare_TestFail
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
    FMOV  D0, X16
    FMOV  V0.D[1], X12
    FMOV  D1, X25
    FMOV  V1.D[1], X24
    FMOV  D2, X2
    FMOV  V2.D[1], X12
    FMOV  D3, X28
    FMOV  V3.D[1], X2
    FMOV  D4, X14
    FMOV  V4.D[1], X15
    FMOV  D5, X26
    FMOV  V5.D[1], X11
    FMOV  D6, X27
    FMOV  V6.D[1], X23
    FMOV  D7, X29
    FMOV  V7.D[1], X5
    FMOV  D8, X6
    FMOV  V8.D[1], X25
    FMOV  D9, X23
    FMOV  V9.D[1], X8
    FMOV  D10, X4
    FMOV  V10.D[1], X15
    FMOV  D11, X3
    FMOV  V11.D[1], X27
    FMOV  D12, X24
    FMOV  V12.D[1], X13
    FMOV  D13, X29
    FMOV  V13.D[1], X25
    FMOV  D14, X11
    FMOV  V14.D[1], X29
    FMOV  D15, X26
    FMOV  V15.D[1], X11
    FMOV  D16, X23
    FMOV  V16.D[1], X15
    FMOV  D17, X24
    FMOV  V17.D[1], X25
    FMOV  D18, X28
    FMOV  V18.D[1], X12
    FMOV  D19, X11
    FMOV  V19.D[1], X4
    FMOV  D20, X27
    FMOV  V20.D[1], X25
    FMOV  D21, X8
    FMOV  V21.D[1], X4
    FMOV  D22, X4
    FMOV  V22.D[1], X17
    FMOV  D23, X2
    FMOV  V23.D[1], X26
    FMOV  D24, X16
    FMOV  V24.D[1], X14
    FMOV  D25, X27
    FMOV  V25.D[1], X13
    FMOV  D26, X6
    FMOV  V26.D[1], X2
    FMOV  D27, X23
    FMOV  V27.D[1], X10
    FMOV  D28, X23
    FMOV  V28.D[1], X17
    FMOV  D29, X14
    FMOV  V29.D[1], X2
    FMOV  D30, X23
    FMOV  V30.D[1], X9
    FMOV  D31, X16
    FMOV  V31.D[1], X3
    MOVZ  X9, #0xa, LSL #0
TSRTAdvsimdVectorCompare_label_11:
    CMGE  V29.8B, V15.8B, #0
    FCMGE  V28.8H, V26.8H, V28.8H
    CMGT  V27.4S, V27.4S, #0
    CMGE  V19.4H, V29.4H, #0
    FCMEQ  V23.4S, V25.4S, V30.4S
    CMTST  V28.2S, V31.2S, V28.2S
    FCMGT  V2.2S, V14.2S, #0.0
    FCMEQ  V9.2D, V27.2D, V8.2D
    FCMEQ  V9.4H, V28.4H, #0.0
    FCMGT  V3.2D, V9.2D, #0.0
    CMGE  V28.4H, V3.4H, V23.4H
    FCMGT  V25.4H, V24.4H, V20.4H
    CMTST  V3.8B, V20.8B, V14.8B
    CMGT  V24.2D, V25.2D, V2.2D
    CMTST  V22.4S, V14.4S, V21.4S
    FCMEQ  V0.8H, V20.8H, #0.0
    FCMGT  V24.4S, V28.4S, #0.0
    FCMLT  V23.4S, V0.4S, #0.0
    FCMGT  V30.2S, V0.2S, V26.2S
    FCMLT  V18.4H, V19.4H, #0.0
    CMLT  V9.8B, V17.8B, #0
    FCMLE  V17.2S, V22.2S, #0.0
    FCMEQ  V28.4H, V3.4H, #0.0
    CMEQ  V21.4H, V6.4H, #0
    FCMEQ  V3.8H, V21.8H, V7.8H
    CMHI  V12.8B, V25.8B, V16.8B
    FCMEQ  V21.8H, V28.8H, V24.8H
    FCMGT  V25.4H, V6.4H, V23.4H
    CMGT  V17.8B, V18.8B, #0
    CMGT  V31.2S, V4.2S, V17.2S
    FCMGE  V14.4S, V19.4S, V4.4S
    CMTST  V17.16B, V3.16B, V30.16B
    FCMEQ  V16.4S, V5.4S, V9.4S
    CMGE  V27.16B, V17.16B, #0
    CMLT  V28.4H, V12.4H, #0
    FCMLE  V18.8H, V31.8H, #0.0
    FCMGE  V17.8H, V18.8H, V28.8H
    CMGE  V26.2D, V17.2D, V17.2D
    FCMGE  V23.2D, V16.2D, V5.2D
    FCMLE  V0.4H, V21.4H, #0.0
    FCMGE  V17.8H, V14.8H, #0.0
    FCMGT  V9.8H, V7.8H, #0.0
    FCMEQ  V24.8H, V17.8H, #0.0
    CMEQ  V28.2S, V1.2S, #0
    CMGT  V30.8H, V27.8H, #0
    FCMGT  V1.4S, V9.4S, V9.4S
    FCMGT  V14.4H, V6.4H, #0.0
    FCMEQ  V2.2D, V2.2D, #0.0
    FCMEQ  V4.4H, V8.4H, #0.0
    CMGT  V9.2S, V30.2S, #0
    FCMLE  V5.4S, V23.4S, #0.0
    FCMLE  V3.8H, V24.8H, #0.0
    CMEQ  V8.16B, V0.16B, V4.16B
    FCMGT  V19.2D, V2.2D, V15.2D
    CMGE  V21.16B, V9.16B, #0
    FCMGE  V4.2S, V28.2S, V1.2S
    FCMEQ  V8.2D, V19.2D, V8.2D
    CMEQ  V7.2D, V14.2D, #0
    FCMLE  V0.8H, V21.8H, #0.0
    CMEQ  V15.2S, V7.2S, #0
    CMGE  V7.2S, V0.2S, V0.2S
    FCMLE  V1.8H, V4.8H, #0.0
    FCMGT  V1.2S, V15.2S, #0.0
    CMTST  V21.2S, V17.2S, V8.2S
    CMGT  V29.2D, V27.2D, V3.2D
    CMLE  V23.4H, V1.4H, #0
    CMGE  V28.2D, V7.2D, #0
    CMGT  V6.2D, V8.2D, #0
    FCMGE  V30.2D, V5.2D, V2.2D
    FCMGE  V9.2D, V12.2D, #0.0
    CMLE  V2.4S, V9.4S, #0
    FCMGT  V15.2S, V25.2S, #0.0
    FCMLT  V27.4S, V12.4S, #0.0
    FCMLT  V8.2D, V12.2D, #0.0
    FCMGE  V1.8H, V26.8H, V2.8H
    CMHI  V17.8B, V1.8B, V8.8B
    CMTST  V14.4S, V30.4S, V23.4S
    CMEQ  V0.4S, V29.4S, #0
    FCMGT  V9.8H, V15.8H, #0.0
    CMLT  V25.4H, V27.4H, #0
    CMGT  V26.8H, V7.8H, #0
    FCMEQ  V14.2S, V17.2S, #0.0
    FCMGT  V9.4S, V25.4S, #0.0
    FCMGT  V15.4H, V26.4H, #0.0
    CMLE  V2.2S, V14.2S, #0
    CMTST  V27.2D, V2.2D, V27.2D
    CMEQ  V12.4H, V10.4H, V24.4H
    FCMGT  V23.4S, V0.4S, #0.0
    FCMGT  V17.4H, V12.4H, V28.4H
    FCMEQ  V5.2D, V23.2D, #0.0
    CMGT  V3.4H, V2.4H, V17.4H
    FCMGE  V30.8H, V3.8H, V23.8H
    FCMLE  V2.4H, V7.4H, #0.0
    CMLT  V20.8B, V12.8B, #0
    FCMLE  V25.4H, V13.4H, #0.0
    CMEQ  V17.16B, V9.16B, V9.16B
    FCMGE  V26.2S, V20.2S, #0.0
    FCMGE  V7.2D, V25.2D, #0.0
    CMGE  V13.4H, V9.4H, V27.4H
    FCMGE  V24.2S, V23.2S, V17.2S
    FCMGT  V12.4H, V5.4H, #0.0
    CMHS  V20.4H, V2.4H, V17.4H
    FCMGT  V3.2S, V18.2S, #0.0
    FCMGT  V1.4S, V15.4S, V28.4S
    CMEQ  V27.2D, V13.2D, #0
    FCMLE  V2.4S, V23.4S, #0.0
    FCMLE  V28.4H, V20.4H, #0.0
    FCMGT  V13.8H, V21.8H, #0.0
    CMGE  V9.2D, V9.2D, #0
    CMGT  V15.2D, V25.2D, #0
    FCMEQ  V0.4S, V30.4S, V26.4S
    CMEQ  V17.4H, V7.4H, #0
    FCMLT  V15.8H, V1.8H, #0.0
    CMGE  V26.2D, V15.2D, #0
    FCMEQ  V23.4S, V0.4S, #0.0
    FCMEQ  V8.4H, V31.4H, V13.4H
    FCMGT  V18.4H, V5.4H, V26.4H
    FCMLE  V10.4H, V2.4H, #0.0
    CMEQ  V0.8B, V28.8B, V20.8B
    CMGT  V2.16B, V28.16B, #0
    FCMGT  V17.2S, V2.2S, V9.2S
    FCMEQ  V9.2S, V3.2S, #0.0
    FCMGE  V20.2S, V0.2S, #0.0
    FCMLT  V2.4S, V18.4S, #0.0
    CMGE  V2.4S, V17.4S, V28.4S
    FCMGT  V25.4S, V6.4S, #0.0
    CMEQ  V26.2D, V9.2D, V20.2D
    FCMGE  V6.2D, V12.2D, V11.2D
    FCMGT  V5.4S, V24.4S, V22.4S
    CMHI  V12.16B, V11.16B, V16.16B
    FCMGT  V1.4S, V12.4S, #0.0
    FCMEQ  V28.4H, V24.4H, V23.4H
    CMEQ  V3.2S, V0.2S, #0
    FCMEQ  V12.2S, V8.2S, V26.2S
    CMGE  V11.4S, V26.4S, V22.4S
    FCMGE  V31.2D, V25.2D, V6.2D
    CMHS  V26.4S, V16.4S, V1.4S
    FCMGT  V14.8H, V20.8H, #0.0
    CMEQ  V0.2D, V31.2D, V18.2D
    CMLT  V18.4S, V10.4S, #0
    FCMGT  V20.2S, V18.2S, V14.2S
    FCMLE  V8.4H, V26.4H, #0.0
    FCMLE  V10.4H, V11.4H, #0.0
    FCMGE  V13.2D, V0.2D, V0.2D
    CMGE  V0.4S, V20.4S, V13.4S
    FCMEQ  V20.4S, V8.4S, V12.4S
    CMGE  V12.2D, V20.2D, V20.2D
    FCMEQ  V16.8H, V3.8H, #0.0
    CMGE  V20.16B, V5.16B, #0
    FCMEQ  V25.2S, V12.2S, #0.0
    FCMGE  V6.2S, V31.2S, V0.2S
    FCMGT  V22.4S, V16.4S, V24.4S
    FCMGE  V16.4H, V22.4H, #0.0
    CMEQ  V12.2D, V10.2D, #0
    FCMGT  V17.4S, V16.4S, V21.4S
    FCMEQ  V4.2D, V6.2D, V12.2D
    FCMGT  V11.2D, V25.2D, V23.2D
    FCMGE  V31.2S, V11.2S, V15.2S
    CMEQ  V18.8H, V31.8H, #0
    FCMGT  V3.2S, V18.2S, #0.0
    CMHI  V8.16B, V24.16B, V3.16B
    CMHI  V5.2S, V4.2S, V20.2S
    FCMEQ  V23.8H, V10.8H, #0.0
    CMHI  V26.2D, V17.2D, V9.2D
    CMLE  V12.8B, V19.8B, #0
    FCMLE  V25.4S, V26.4S, #0.0
    FCMGE  V6.8H, V5.8H, #0.0
    FCMLT  V16.4H, V29.4H, #0.0
    FCMEQ  V21.4H, V12.4H, V21.4H
    FCMEQ  V18.4H, V6.4H, #0.0
    CMEQ  V10.8B, V8.8B, #0
    CMGT  V0.2D, V10.2D, #0
    FCMEQ  V29.4H, V23.4H, #0.0
    FCMGT  V26.4H, V8.4H, #0.0
    CMLT  V9.2S, V29.2S, #0
    FCMGT  V28.2D, V0.2D, #0.0
    CMLE  V5.2D, V9.2D, #0
    CMGE  V24.2D, V18.2D, #0
    FCMGT  V23.2S, V24.2S, #0.0
    FCMEQ  V12.4H, V4.4H, #0.0
    FCMLE  V14.4H, V23.4H, #0.0
    FCMEQ  V20.4S, V26.4S, V5.4S
    CMGT  V29.4H, V27.4H, V20.4H
    FCMEQ  V8.4H, V21.4H, V28.4H
    FCMEQ  V19.8H, V5.8H, V29.8H
    CMGE  V18.8H, V8.8H, V24.8H
    FCMEQ  V5.2D, V0.2D, #0.0
    CMLT  V15.4S, V12.4S, #0
    CMHI  V10.4S, V19.4S, V15.4S
    CMEQ  V28.16B, V10.16B, V10.16B
    FCMGE  V4.2S, V5.2S, #0.0
    CMGT  V20.4H, V28.4H, V25.4H
    FCMGT  V26.8H, V17.8H, V18.8H
    FCMGT  V23.2S, V27.2S, #0.0
    FCMGT  V29.4S, V26.4S, V14.4S
    FCMLE  V21.2D, V9.2D, #0.0
    FCMEQ  V23.2S, V20.2S, V4.2S
    FCMLE  V18.2S, V5.2S, #0.0
    CMEQ  V20.8H, V21.8H, V23.8H
    FCMLT  V4.8H, V31.8H, #0.0
    SUBS  X9, X9, #0x1
    B.NE  TSRTAdvsimdVectorCompare_label_11
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorCompare_TestFail
    MRS  X12, FPSR
    MOVZ  X24, #0x81, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V0.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D0
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V1.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D1
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D2
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D3
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D4
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D5
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D6
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D7
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D8
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D9
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D10
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D11
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V12.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D12
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D13
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D14
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D15
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D16
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D17
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D18
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D19
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D20
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D21
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D22
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D23
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D24
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D25
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D26
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D27
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D28
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D29
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V30.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D30
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, V31.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X12, D31
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorCompare_TestFail
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
    FMOV  D0, X28
    FMOV  V0.D[1], X29
    FMOV  D1, X7
    FMOV  V1.D[1], X27
    FMOV  D2, X25
    FMOV  V2.D[1], X26
    FMOV  D3, X23
    FMOV  V3.D[1], X24
    FMOV  D4, X9
    FMOV  V4.D[1], X10
    FMOV  D5, X2
    FMOV  V5.D[1], X29
    FMOV  D6, X3
    FMOV  V6.D[1], X28
    FMOV  D7, X3
    FMOV  V7.D[1], X28
    FMOV  D8, X25
    FMOV  V8.D[1], X24
    FMOV  D9, X26
    FMOV  V9.D[1], X13
    FMOV  D10, X3
    FMOV  V10.D[1], X8
    FMOV  D11, X10
    FMOV  V11.D[1], X14
    FMOV  D12, X29
    FMOV  V12.D[1], X9
    FMOV  D13, X17
    FMOV  V13.D[1], X25
    FMOV  D14, X15
    FMOV  V14.D[1], X9
    FMOV  D15, X4
    FMOV  V15.D[1], X13
    FMOV  D16, X29
    FMOV  V16.D[1], X16
    FMOV  D17, X10
    FMOV  V17.D[1], X26
    FMOV  D18, X10
    FMOV  V18.D[1], X27
    FMOV  D19, X15
    FMOV  V19.D[1], X28
    FMOV  D20, X23
    FMOV  V20.D[1], X25
    FMOV  D21, X11
    FMOV  V21.D[1], X8
    FMOV  D22, X23
    FMOV  V22.D[1], X17
    FMOV  D23, X9
    FMOV  V23.D[1], X23
    FMOV  D24, X7
    FMOV  V24.D[1], X6
    FMOV  D25, X17
    FMOV  V25.D[1], X8
    FMOV  D26, X25
    FMOV  V26.D[1], X28
    FMOV  D27, X25
    FMOV  V27.D[1], X2
    FMOV  D28, X9
    FMOV  V28.D[1], X12
    FMOV  D29, X15
    FMOV  V29.D[1], X17
    FMOV  D30, X24
    FMOV  V30.D[1], X8
    FMOV  D31, X3
    FMOV  V31.D[1], X14
    MOVZ  X9, #0xa, LSL #0
TSRTAdvsimdVectorCompare_label_12:
    FCMEQ  V29.4H, V28.4H, V29.4H
    FCMGE  V10.2D, V25.2D, V30.2D
    CMEQ  V19.4H, V23.4H, #0
    CMGE  V31.2D, V7.2D, V22.2D
    FCMGE  V12.2D, V29.2D, #0.0
    CMHS  V2.2S, V26.2S, V26.2S
    FCMEQ  V29.8H, V27.8H, #0.0
    FCMLT  V7.4S, V5.4S, #0.0
    CMGT  V18.4S, V2.4S, V19.4S
    FCMLE  V23.8H, V23.8H, #0.0
    CMHS  V31.2S, V10.2S, V23.2S
    CMTST  V24.2S, V27.2S, V12.2S
    FCMLT  V12.4H, V31.4H, #0.0
    FCMLE  V9.8H, V6.8H, #0.0
    FCMLE  V12.8H, V24.8H, #0.0
    FCMGE  V10.2S, V28.2S, V6.2S
    CMTST  V31.4H, V7.4H, V12.4H
    CMGE  V30.8B, V26.8B, V10.8B
    FCMGE  V23.2S, V28.2S, V31.2S
    FCMGE  V14.2S, V18.2S, V23.2S
    CMLE  V19.2S, V19.2S, #0
    CMGE  V24.4S, V13.4S, V29.4S
    FCMGE  V17.8H, V9.8H, #0.0
    FCMGT  V23.2D, V31.2D, V24.2D
    FCMEQ  V2.8H, V7.8H, #0.0
    FCMEQ  V18.4S, V19.4S, #0.0
    CMGE  V5.16B, V22.16B, #0
    FCMGE  V19.2D, V30.2D, V30.2D
    FCMGT  V27.2S, V10.2S, #0.0
    FCMGE  V12.2D, V18.2D, V17.2D
    CMHS  V17.2S, V27.2S, V14.2S
    FCMLE  V19.2D, V5.2D, #0.0
    FCMGT  V24.4H, V0.4H, #0.0
    CMHI  V0.8B, V20.8B, V6.8B
    CMGT  V6.4S, V24.4S, V17.4S
    CMEQ  V31.2S, V6.2S, V2.2S
    FCMLE  V2.4S, V4.4S, #0.0
    CMHI  V26.2D, V23.2D, V22.2D
    FCMGT  V13.4H, V14.4H, #0.0
    FCMEQ  V29.4S, V2.4S, V2.4S
    FCMLE  V28.4H, V30.4H, #0.0
    CMHI  V10.8H, V29.8H, V0.8H
    FCMLT  V4.4S, V12.4S, #0.0
    FCMGE  V31.2S, V4.2S, V19.2S
    FCMEQ  V5.4H, V20.4H, V13.4H
    FCMGE  V4.2S, V26.2S, V3.2S
    FCMGE  V29.8H, V25.8H, V5.8H
    CMLT  V23.4H, V9.4H, #0
    FCMEQ  V25.2S, V9.2S, #0.0
    FCMLE  V2.4S, V20.4S, #0.0
    CMGE  V5.2D, V16.2D, #0
    FCMGT  V17.8H, V29.8H, #0.0
    CMGE  V20.16B, V10.16B, V3.16B
    FCMEQ  V3.8H, V25.8H, V28.8H
    FCMEQ  V30.4S, V19.4S, #0.0
    CMGE  V25.2D, V17.2D, #0
    FCMGE  V31.4H, V6.4H, #0.0
    CMGE  V18.4S, V29.4S, V14.4S
    CMHS  V9.8B, V3.8B, V25.8B
    CMTST  V26.8H, V24.8H, V23.8H
    FCMGT  V10.2D, V26.2D, V20.2D
    CMGE  V25.4H, V2.4H, V16.4H
    FCMEQ  V19.8H, V30.8H, #0.0
    FCMLT  V12.4H, V4.4H, #0.0
    FCMGE  V28.8H, V9.8H, #0.0
    FCMGT  V16.4H, V28.4H, #0.0
    FCMGT  V20.8H, V17.8H, V19.8H
    FCMLE  V4.8H, V10.8H, #0.0
    CMGT  V6.2S, V31.2S, V31.2S
    CMGE  V23.2D, V12.2D, #0
    CMHI  V10.4H, V23.4H, V25.4H
    FCMEQ  V30.4S, V25.4S, #0.0
    FCMGT  V22.2D, V18.2D, #0.0
    FCMLE  V6.8H, V22.8H, #0.0
    CMTST  V19.8B, V20.8B, V16.8B
    FCMGT  V16.2D, V15.2D, V4.2D
    CMGT  V3.2D, V10.2D, #0
    FCMLT  V10.4H, V19.4H, #0.0
    FCMEQ  V28.2D, V16.2D, V5.2D
    FCMEQ  V17.8H, V20.8H, V25.8H
    CMHS  V5.2S, V31.2S, V10.2S
    CMGT  V10.4S, V17.4S, #0
    FCMEQ  V16.2D, V17.2D, V7.2D
    FCMLE  V26.2D, V20.2D, #0.0
    CMLT  V9.2D, V10.2D, #0
    FCMGE  V10.4H, V16.4H, V6.4H
    FCMGT  V24.2D, V22.2D, #0.0
    FCMEQ  V19.2D, V31.2D, V28.2D
    CMLT  V31.2S, V30.2S, #0
    CMLT  V20.8B, V31.8B, #0
    CMTST  V4.8H, V26.8H, V20.8H
    CMEQ  V4.8B, V24.8B, V19.8B
    FCMEQ  V15.2S, V18.2S, V9.2S
    CMGT  V2.16B, V3.16B, V3.16B
    CMEQ  V26.8B, V10.8B, #0
    FCMLT  V22.4H, V4.4H, #0.0
    FCMEQ  V3.8H, V26.8H, V15.8H
    CMHS  V24.2D, V21.2D, V24.2D
    CMGE  V30.4H, V31.4H, #0
    FCMEQ  V20.4S, V30.4S, #0.0
    FCMEQ  V15.4H, V5.4H, V20.4H
    FCMEQ  V9.4H, V18.4H, #0.0
    CMGE  V13.4S, V30.4S, #0
    FCMGE  V6.2S, V2.2S, V13.2S
    CMHS  V5.8H, V22.8H, V12.8H
    FCMEQ  V25.8H, V5.8H, V0.8H
    FCMLT  V2.2D, V15.2D, #0.0
    CMTST  V25.2D, V12.2D, V30.2D
    FCMLT  V1.2D, V1.2D, #0.0
    FCMGT  V31.8H, V6.8H, #0.0
    FCMGE  V0.4H, V2.4H, V25.4H
    FCMLT  V12.4H, V31.4H, #0.0
    FCMGE  V5.4H, V12.4H, #0.0
    FCMGE  V15.4H, V1.4H, #0.0
    FCMEQ  V12.4H, V15.4H, #0.0
    FCMGT  V21.2S, V3.2S, #0.0
    CMGT  V6.8B, V24.8B, #0
    FCMLE  V15.2D, V17.2D, #0.0
    CMEQ  V12.8B, V9.8B, #0
    FCMLT  V18.2S, V5.2S, #0.0
    CMLT  V20.8H, V15.8H, #0
    CMHS  V5.4S, V6.4S, V17.4S
    CMEQ  V13.2S, V16.2S, #0
    FCMGE  V22.4S, V4.4S, #0.0
    CMEQ  V2.2S, V20.2S, #0
    FCMEQ  V25.8H, V21.8H, #0.0
    FCMGT  V16.2S, V4.2S, #0.0
    CMGT  V26.16B, V12.16B, #0
    FCMGE  V4.8H, V25.8H, V26.8H
    FCMGT  V30.4H, V28.4H, #0.0
    FCMGT  V12.4H, V5.4H, V5.4H
    FCMGE  V17.4H, V24.4H, #0.0
    CMEQ  V28.4S, V16.4S, #0
    CMGE  V1.4H, V0.4H, V22.4H
    CMLT  V31.4H, V28.4H, #0
    FCMGT  V16.4S, V27.4S, V18.4S
    FCMLE  V15.4H, V7.4H, #0.0
    CMLT  V27.2S, V31.2S, #0
    FCMGT  V22.4S, V4.4S, V12.4S
    CMGE  V28.4H, V2.4H, #0
    FCMGE  V17.2S, V23.2S, V10.2S
    FCMEQ  V20.2D, V28.2D, V22.2D
    CMEQ  V27.2D, V20.2D, #0
    FCMGT  V23.8H, V16.8H, #0.0
    FCMEQ  V2.4H, V27.4H, #0.0
    FCMGE  V12.4H, V30.4H, #0.0
    CMHI  V30.2S, V17.2S, V23.2S
    FCMLT  V7.4H, V18.4H, #0.0
    CMGE  V5.8B, V13.8B, #0
    CMHS  V1.2D, V5.2D, V15.2D
    FCMGT  V21.4S, V24.4S, #0.0
    FCMGT  V26.8H, V29.8H, V2.8H
    FCMGE  V31.2S, V31.2S, V7.2S
    FCMGT  V29.2D, V1.2D, #0.0
    FCMEQ  V23.8H, V31.8H, V12.8H
    CMEQ  V30.4H, V30.4H, V30.4H
    FCMGT  V17.2S, V30.2S, #0.0
    CMGE  V7.8H, V28.8H, #0
    CMGE  V16.16B, V26.16B, V29.16B
    FCMGE  V2.2S, V15.2S, V16.2S
    FCMGE  V27.8H, V0.8H, V7.8H
    FCMEQ  V15.8H, V23.8H, V24.8H
    FCMGE  V1.4H, V21.4H, V27.4H
    CMEQ  V16.2D, V15.2D, V2.2D
    FCMGE  V0.2S, V28.2S, V16.2S
    CMGT  V13.2D, V1.2D, V1.2D
    FCMEQ  V16.4H, V23.4H, #0.0
    FCMGE  V26.4S, V13.4S, #0.0
    FCMGT  V7.4H, V25.4H, #0.0
    FCMGT  V30.4H, V30.4H, #0.0
    FCMLT  V23.8H, V18.8H, #0.0
    FCMEQ  V31.2D, V8.2D, #0.0
    CMGT  V18.4S, V15.4S, V4.4S
    FCMLT  V15.8H, V0.8H, #0.0
    CMHI  V28.16B, V23.16B, V7.16B
    CMHI  V7.2D, V27.2D, V17.2D
    CMLE  V25.2S, V24.2S, #0
    FCMGE  V4.4H, V18.4H, V25.4H
    FCMEQ  V27.4H, V30.4H, V30.4H
    CMTST  V14.16B, V11.16B, V16.16B
    FCMEQ  V21.2S, V16.2S, V27.2S
    FCMLT  V17.2D, V4.2D, #0.0
    CMEQ  V2.16B, V1.16B, #0
    CMHS  V20.2D, V29.2D, V31.2D
    CMEQ  V11.2D, V21.2D, V28.2D
    CMGE  V16.8H, V20.8H, V2.8H
    FCMGT  V27.2D, V26.2D, V17.2D
    FCMEQ  V30.2S, V15.2S, #0.0
    FCMGT  V31.2S, V30.2S, #0.0
    CMGE  V31.2S, V27.2S, #0
    CMHS  V27.4S, V20.4S, V31.4S
    CMLT  V23.2S, V1.2S, #0
    FCMEQ  V22.8H, V7.8H, #0.0
    CMGE  V17.16B, V22.16B, V14.16B
    FCMEQ  V29.2D, V16.2D, #0.0
    CMEQ  V4.4S, V14.4S, V19.4S
    FCMGT  V1.4S, V11.4S, V17.4S
    FCMGE  V28.4H, V28.4H, #0.0
    CMGT  V14.16B, V7.16B, #0
    CMHS  V17.4S, V28.4S, V15.4S
    SUBS  X9, X9, #0x1
    B.NE  TSRTAdvsimdVectorCompare_label_12
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X14, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X14, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X14, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X14, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X14, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X14, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X14, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X14, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X14, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X14, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X14, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X14, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X14, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X14, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X14, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X14, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorCompare_TestFail
    MRS  X16, FPSR
    MOVZ  X14, #0x81, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D0
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D1
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D2
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D3
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D4
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D5
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D6
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D7
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D8
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D9
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D10
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D11
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D12
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D13
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D14
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D15
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D16
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D17
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D18
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D19
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D20
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D21
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D22
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D23
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D24
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D25
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D26
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D27
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D28
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D29
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D30
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X16, D31
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorCompare_TestFail
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
    FMOV  D0, X26
    FMOV  V0.D[1], X6
    FMOV  D1, X29
    FMOV  V1.D[1], X8
    FMOV  D2, X29
    FMOV  V2.D[1], X13
    FMOV  D3, X12
    FMOV  V3.D[1], X28
    FMOV  D4, X25
    FMOV  V4.D[1], X24
    FMOV  D5, X9
    FMOV  V5.D[1], X14
    FMOV  D6, X13
    FMOV  V6.D[1], X17
    FMOV  D7, X24
    FMOV  V7.D[1], X14
    FMOV  D8, X15
    FMOV  V8.D[1], X29
    FMOV  D9, X7
    FMOV  V9.D[1], X3
    FMOV  D10, X9
    FMOV  V10.D[1], X11
    FMOV  D11, X29
    FMOV  V11.D[1], X24
    FMOV  D12, X15
    FMOV  V12.D[1], X3
    FMOV  D13, X17
    FMOV  V13.D[1], X28
    FMOV  D14, X25
    FMOV  V14.D[1], X14
    FMOV  D15, X11
    FMOV  V15.D[1], X10
    FMOV  D16, X7
    FMOV  V16.D[1], X23
    FMOV  D17, X10
    FMOV  V17.D[1], X6
    FMOV  D18, X16
    FMOV  V18.D[1], X7
    FMOV  D19, X26
    FMOV  V19.D[1], X11
    FMOV  D20, X27
    FMOV  V20.D[1], X8
    FMOV  D21, X26
    FMOV  V21.D[1], X29
    FMOV  D22, X27
    FMOV  V22.D[1], X23
    FMOV  D23, X14
    FMOV  V23.D[1], X26
    FMOV  D24, X17
    FMOV  V24.D[1], X24
    FMOV  D25, X11
    FMOV  V25.D[1], X26
    FMOV  D26, X6
    FMOV  V26.D[1], X9
    FMOV  D27, X24
    FMOV  V27.D[1], X8
    FMOV  D28, X28
    FMOV  V28.D[1], X25
    FMOV  D29, X28
    FMOV  V29.D[1], X6
    FMOV  D30, X12
    FMOV  V30.D[1], X28
    FMOV  D31, X2
    FMOV  V31.D[1], X11
    MOVZ  X12, #0xa, LSL #0
TSRTAdvsimdVectorCompare_label_13:
    FCMGT  V9.4H, V26.4H, V25.4H
    FCMLE  V23.4H, V16.4H, #0.0
    FCMGT  V14.4S, V16.4S, V0.4S
    FCMEQ  V8.4H, V14.4H, V27.4H
    FCMGT  V2.4H, V24.4H, V29.4H
    CMLT  V29.16B, V31.16B, #0
    FCMLT  V4.2S, V8.2S, #0.0
    CMLE  V21.8B, V28.8B, #0
    FCMEQ  V4.4H, V17.4H, V5.4H
    CMLT  V22.8H, V1.8H, #0
    CMHI  V1.8B, V21.8B, V11.8B
    FCMGE  V7.4H, V17.4H, #0.0
    FCMGE  V28.2S, V25.2S, V8.2S
    FCMGT  V12.4H, V4.4H, V29.4H
    FCMLE  V6.4S, V16.4S, #0.0
    FCMEQ  V26.2D, V12.2D, V22.2D
    CMTST  V6.2S, V2.2S, V17.2S
    CMHS  V28.8B, V26.8B, V1.8B
    CMGE  V12.2S, V9.2S, #0
    FCMEQ  V18.4S, V28.4S, #0.0
    CMGE  V14.4H, V21.4H, #0
    FCMEQ  V4.4S, V23.4S, #0.0
    CMEQ  V24.8H, V30.8H, V4.8H
    CMTST  V16.16B, V12.16B, V6.16B
    FCMEQ  V19.4H, V24.4H, V7.4H
    FCMGE  V23.4H, V19.4H, #0.0
    FCMGT  V26.4H, V14.4H, #0.0
    CMLE  V9.16B, V23.16B, #0
    FCMLE  V22.8H, V18.8H, #0.0
    CMEQ  V6.2S, V16.2S, V7.2S
    FCMGE  V8.8H, V26.8H, #0.0
    FCMEQ  V24.4S, V22.4S, #0.0
    FCMGE  V23.2S, V24.2S, #0.0
    CMLT  V1.2D, V28.2D, #0
    CMHI  V30.8B, V23.8B, V9.8B
    FCMEQ  V19.8H, V1.8H, #0.0
    FCMEQ  V24.8H, V8.8H, #0.0
    FCMLT  V8.2D, V14.2D, #0.0
    FCMGT  V29.4S, V24.4S, #0.0
    CMEQ  V1.16B, V6.16B, #0
    FCMEQ  V14.4S, V19.4S, V10.4S
    FCMGT  V26.4H, V7.4H, V1.4H
    FCMLE  V7.2S, V26.2S, #0.0
    FCMGE  V9.8H, V30.8H, #0.0
    FCMGT  V10.8H, V29.8H, V16.8H
    CMEQ  V22.4S, V8.4S, V7.4S
    CMHS  V23.8H, V13.8H, V22.8H
    FCMLE  V1.2S, V10.2S, #0.0
    FCMGT  V22.4H, V9.4H, V1.4H
    FCMEQ  V7.2S, V23.2S, V23.2S
    FCMGE  V26.4S, V11.4S, #0.0
    FCMEQ  V10.4H, V20.4H, #0.0
    FCMLE  V18.2D, V26.2D, #0.0
    FCMEQ  V20.4H, V14.4H, V7.4H
    FCMGT  V29.8H, V10.8H, V20.8H
    FCMEQ  V28.4H, V18.4H, V31.4H
    FCMEQ  V6.2S, V12.2S, V28.2S
    FCMLT  V28.8H, V29.8H, #0.0
    FCMLT  V13.2S, V21.2S, #0.0
    FCMEQ  V7.2D, V13.2D, V22.2D
    CMGE  V11.2D, V28.2D, V1.2D
    CMEQ  V16.16B, V30.16B, V16.16B
    FCMGE  V18.8H, V5.8H, #0.0
    FCMLE  V22.8H, V12.8H, #0.0
    FCMLE  V23.2S, V12.2S, #0.0
    FCMLT  V21.4S, V6.4S, #0.0
    CMEQ  V31.2S, V17.2S, V22.2S
    FCMGE  V22.4H, V25.4H, #0.0
    FCMLE  V16.2S, V31.2S, #0.0
    CMLE  V28.8H, V16.8H, #0
    CMEQ  V30.16B, V21.16B, #0
    FCMGT  V6.2D, V18.2D, V22.2D
    FCMLT  V12.4H, V30.4H, #0.0
    FCMGE  V24.4H, V16.4H, V6.4H
    FCMGT  V28.2D, V13.2D, #0.0
    CMHS  V16.16B, V28.16B, V28.16B
    FCMGE  V9.4H, V9.4H, V24.4H
    FCMGE  V22.2S, V15.2S, V16.2S
    FCMLT  V21.4H, V9.4H, #0.0
    CMHS  V10.2S, V29.2S, V21.2S
    CMLT  V31.16B, V30.16B, #0
    CMEQ  V5.8H, V22.8H, #0
    FCMEQ  V25.4H, V7.4H, #0.0
    CMGE  V28.4S, V11.4S, V12.4S
    CMEQ  V12.2S, V18.2S, V25.2S
    FCMGE  V16.4H, V8.4H, V10.4H
    CMLE  V29.4H, V8.4H, #0
    FCMEQ  V9.8H, V4.8H, V21.8H
    CMGT  V0.2D, V5.2D, #0
    CMGE  V22.4H, V29.4H, V11.4H
    CMTST  V21.16B, V9.16B, V3.16B
    CMHS  V3.2S, V9.2S, V28.2S
    FCMEQ  V25.4H, V16.4H, #0.0
    CMHS  V17.2D, V22.2D, V9.2D
    FCMLT  V28.4H, V10.4H, #0.0
    CMEQ  V16.16B, V0.16B, #0
    FCMGT  V4.8H, V1.8H, #0.0
    CMEQ  V14.4S, V20.4S, V26.4S
    CMGE  V24.2S, V3.2S, V21.2S
    FCMLT  V21.4H, V4.4H, #0.0
    FCMGT  V1.4H, V28.4H, V13.4H
    CMHS  V29.8B, V24.8B, V8.8B
    CMTST  V11.4H, V29.4H, V21.4H
    CMLT  V26.2D, V1.2D, #0
    CMLT  V13.4H, V23.4H, #0
    FCMEQ  V24.4H, V15.4H, #0.0
    CMEQ  V29.16B, V17.16B, #0
    FCMEQ  V17.4H, V26.4H, #0.0
    FCMLE  V1.4S, V17.4S, #0.0
    FCMLE  V3.8H, V9.8H, #0.0
    FCMGE  V22.2D, V25.2D, V14.2D
    FCMEQ  V4.4S, V24.4S, #0.0
    FCMGE  V10.8H, V22.8H, V6.8H
    CMGT  V8.16B, V4.16B, V17.16B
    CMGE  V18.2S, V29.2S, V1.2S
    FCMLE  V29.8H, V30.8H, #0.0
    CMGT  V30.8B, V13.8B, V18.8B
    FCMGT  V20.8H, V10.8H, #0.0
    FCMGT  V14.4S, V11.4S, #0.0
    CMEQ  V9.16B, V31.16B, V3.16B
    CMTST  V6.4H, V16.4H, V9.4H
    CMGE  V20.8B, V6.8B, V20.8B
    CMTST  V13.2D, V20.2D, V20.2D
    FCMLT  V18.4S, V17.4S, #0.0
    FCMLE  V0.8H, V30.8H, #0.0
    CMGE  V14.4S, V13.4S, V8.4S
    FCMEQ  V17.4H, V29.4H, V14.4H
    FCMGE  V11.4H, V17.4H, #0.0
    CMGT  V15.4H, V6.4H, V11.4H
    FCMGE  V16.4H, V22.4H, #0.0
    CMLT  V26.8H, V30.8H, #0
    FCMEQ  V21.8H, V15.8H, #0.0
    FCMEQ  V9.4S, V21.4S, V21.4S
    FCMLE  V6.2D, V2.2D, #0.0
    CMHS  V21.2D, V16.2D, V26.2D
    FCMLT  V11.4H, V5.4H, #0.0
    CMGE  V2.16B, V6.16B, #0
    CMLT  V22.2D, V22.2D, #0
    FCMGE  V30.8H, V11.8H, #0.0
    FCMLE  V5.4H, V22.4H, #0.0
    CMHI  V15.8H, V18.8H, V0.8H
    FCMGT  V22.8H, V11.8H, #0.0
    FCMEQ  V4.8H, V22.8H, V23.8H
    CMEQ  V0.16B, V5.16B, #0
    CMLT  V8.8H, V15.8H, #0
    FCMGE  V29.2S, V9.2S, #0.0
    CMLT  V6.2S, V14.2S, #0
    CMGE  V22.4S, V10.4S, V25.4S
    CMEQ  V20.2D, V6.2D, V21.2D
    FCMGE  V31.8H, V4.8H, V25.8H
    FCMGT  V13.2S, V9.2S, #0.0
    FCMGE  V9.2D, V8.2D, #0.0
    FCMGE  V8.4H, V9.4H, V2.4H
    FCMGT  V8.4H, V30.4H, #0.0
    FCMGE  V26.2D, V20.2D, V8.2D
    CMGT  V6.2S, V7.2S, #0
    FCMLT  V23.4H, V26.4H, #0.0
    CMLE  V26.16B, V6.16B, #0
    FCMLE  V2.4S, V13.4S, #0.0
    FCMGE  V8.2S, V26.2S, #0.0
    FCMGT  V7.4S, V8.4S, #0.0
    FCMGE  V4.2S, V26.2S, #0.0
    CMHS  V14.2S, V7.2S, V22.2S
    CMTST  V31.8B, V25.8B, V19.8B
    CMEQ  V21.8H, V20.8H, #0
    CMTST  V22.16B, V6.16B, V5.16B
    FCMGT  V25.4S, V21.4S, V20.4S
    FCMLT  V30.2D, V0.2D, #0.0
    FCMEQ  V26.2S, V2.2S, #0.0
    FCMLE  V7.4H, V23.4H, #0.0
    CMTST  V9.2S, V22.2S, V31.2S
    FCMGT  V2.4S, V7.4S, #0.0
    CMEQ  V0.2D, V26.2D, V9.2D
    FCMLE  V21.4H, V2.4H, #0.0
    FCMGE  V2.8H, V30.8H, #0.0
    FCMEQ  V14.2D, V14.2D, V30.2D
    FCMGE  V13.8H, V14.8H, #0.0
    FCMLT  V22.4S, V4.4S, #0.0
    CMHS  V4.8B, V14.8B, V22.8B
    FCMGE  V26.8H, V13.8H, V5.8H
    FCMEQ  V16.4H, V4.4H, V26.4H
    CMHS  V30.4S, V21.4S, V21.4S
    FCMEQ  V7.4H, V25.4H, V5.4H
    FCMGE  V31.4S, V16.4S, V27.4S
    CMGT  V21.2S, V7.2S, #0
    FCMGT  V22.2D, V31.2D, V19.2D
    CMGE  V8.2D, V21.2D, V30.2D
    CMEQ  V26.8B, V2.8B, #0
    CMGE  V23.2S, V13.2S, #0
    FCMLT  V6.4H, V8.4H, #0.0
    FCMGT  V31.4H, V22.4H, #0.0
    FCMGT  V2.2D, V23.2D, V28.2D
    CMGT  V9.2D, V0.2D, V6.2D
    FCMLE  V20.2D, V2.2D, #0.0
    FCMLT  V7.2D, V20.2D, #0.0
    FCMGE  V22.8H, V31.8H, V5.8H
    CMGE  V20.8B, V4.8B, #0
    FCMEQ  V14.4H, V19.4H, V7.4H
    FCMGE  V8.2S, V1.2S, #0.0
    CMHI  V4.2D, V14.2D, V31.2D
    SUBS  X12, X12, #0x1
    B.NE  TSRTAdvsimdVectorCompare_label_13
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorCompare_TestFail
    MRS  X17, FPSR
    MOVZ  X13, #0x81, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V0.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D0
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V1.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D1
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V2.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D2
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V3.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D3
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D4
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V5.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D5
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V6.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D6
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D7
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V8.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D8
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D9
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V10.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D10
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D11
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V12.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D12
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V13.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D13
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D14
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V15.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D15
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D16
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V17.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D17
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D18
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V19.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D19
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D20
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V21.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D21
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D22
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D23
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V24.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D24
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D25
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D26
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V27.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D27
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V28.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D28
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V29.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D29
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V30.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D30
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, V31.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X17, D31
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorCompare_TestFail
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
    FMOV  D0, X26
    FMOV  V0.D[1], X25
    FMOV  D1, X11
    FMOV  V1.D[1], X28
    FMOV  D2, X27
    FMOV  V2.D[1], X29
    FMOV  D3, X23
    FMOV  V3.D[1], X15
    FMOV  D4, X5
    FMOV  V4.D[1], X17
    FMOV  D5, X6
    FMOV  V5.D[1], X8
    FMOV  D6, X23
    FMOV  V6.D[1], X17
    FMOV  D7, X4
    FMOV  V7.D[1], X12
    FMOV  D8, X24
    FMOV  V8.D[1], X3
    FMOV  D9, X26
    FMOV  V9.D[1], X25
    FMOV  D10, X26
    FMOV  V10.D[1], X15
    FMOV  D11, X6
    FMOV  V11.D[1], X10
    FMOV  D12, X24
    FMOV  V12.D[1], X3
    FMOV  D13, X4
    FMOV  V13.D[1], X3
    FMOV  D14, X28
    FMOV  V14.D[1], X14
    FMOV  D15, X12
    FMOV  V15.D[1], X27
    FMOV  D16, X16
    FMOV  V16.D[1], X15
    FMOV  D17, X13
    FMOV  V17.D[1], X9
    FMOV  D18, X5
    FMOV  V18.D[1], X15
    FMOV  D19, X9
    FMOV  V19.D[1], X29
    FMOV  D20, X23
    FMOV  V20.D[1], X28
    FMOV  D21, X2
    FMOV  V21.D[1], X28
    FMOV  D22, X14
    FMOV  V22.D[1], X15
    FMOV  D23, X6
    FMOV  V23.D[1], X4
    FMOV  D24, X16
    FMOV  V24.D[1], X10
    FMOV  D25, X23
    FMOV  V25.D[1], X9
    FMOV  D26, X3
    FMOV  V26.D[1], X7
    FMOV  D27, X12
    FMOV  V27.D[1], X29
    FMOV  D28, X6
    FMOV  V28.D[1], X28
    FMOV  D29, X14
    FMOV  V29.D[1], X6
    FMOV  D30, X26
    FMOV  V30.D[1], X3
    FMOV  D31, X4
    FMOV  V31.D[1], X28
    MOVZ  X9, #0xa, LSL #0
TSRTAdvsimdVectorCompare_label_14:
    CMGT  V11.4H, V29.4H, V10.4H
    FCMEQ  V20.4H, V23.4H, #0.0
    FCMEQ  V14.4S, V19.4S, V26.4S
    FCMEQ  V30.4H, V30.4H, V20.4H
    FCMGT  V27.4S, V27.4S, V25.4S
    FCMGE  V0.4H, V14.4H, #0.0
    FCMGT  V17.2S, V11.2S, V0.2S
    FCMGE  V19.4H, V26.4H, #0.0
    CMHS  V11.8H, V28.8H, V27.8H
    FCMGE  V2.2S, V30.2S, #0.0
    CMEQ  V27.8H, V21.8H, V12.8H
    CMGT  V25.4S, V27.4S, V31.4S
    CMGE  V11.8H, V2.8H, #0
    CMHS  V19.8B, V25.8B, V19.8B
    CMGE  V20.8H, V3.8H, #0
    FCMLT  V17.8H, V17.8H, #0.0
    FCMLE  V22.4S, V2.4S, #0.0
    FCMEQ  V2.4S, V17.4S, V17.4S
    CMHI  V29.8H, V19.8H, V19.8H
    CMGE  V6.8B, V11.8B, #0
    FCMEQ  V30.4S, V22.4S, #0.0
    FCMGT  V23.4H, V25.4H, V2.4H
    FCMGE  V30.2D, V6.2D, #0.0
    FCMEQ  V28.2S, V29.2S, V30.2S
    FCMGE  V0.4S, V20.4S, #0.0
    FCMLT  V18.4H, V17.4H, #0.0
    FCMGT  V20.8H, V0.8H, V21.8H
    CMHI  V0.4H, V2.4H, V28.4H
    FCMGE  V19.4H, V18.4H, V31.4H
    FCMGT  V24.4H, V23.4H, V23.4H
    FCMGE  V10.2S, V19.2S, V20.2S
    CMLT  V17.8H, V22.8H, #0
    CMEQ  V25.8B, V0.8B, V8.8B
    FCMEQ  V12.8H, V10.8H, #0.0
    CMGE  V0.8H, V12.8H, #0
    FCMGT  V6.2D, V24.2D, #0.0
    CMGT  V29.2S, V0.2S, V5.2S
    FCMGT  V21.4S, V6.4S, #0.0
    FCMEQ  V31.2D, V29.2D, #0.0
    FCMGE  V14.8H, V28.8H, #0.0
    CMEQ  V0.4S, V18.4S, V14.4S
    CMTST  V28.2D, V25.2D, V17.2D
    CMGT  V24.4H, V0.4H, V7.4H
    FCMGT  V17.4S, V29.4S, V24.4S
    CMGT  V19.2S, V31.2S, #0
    CMEQ  V23.2D, V25.2D, #0
    CMGE  V25.8H, V4.8H, V23.8H
    FCMGE  V5.8H, V25.8H, V25.8H
    CMHI  V31.2S, V21.2S, V16.2S
    FCMLT  V14.4S, V17.4S, #0.0
    CMTST  V23.8H, V31.8H, V14.8H
    CMGT  V6.2S, V23.2S, #0
    CMEQ  V17.2D, V30.2D, V19.2D
    FCMGT  V16.4H, V28.4H, V6.4H
    CMEQ  V21.8H, V6.8H, #0
    CMHI  V6.8B, V16.8B, V31.8B
    CMEQ  V0.2S, V5.2S, V21.2S
    CMEQ  V14.8B, V16.8B, V17.8B
    FCMGT  V27.8H, V6.8H, V6.8H
    FCMEQ  V31.2S, V14.2S, #0.0
    FCMEQ  V12.8H, V25.8H, V31.8H
    CMLT  V14.16B, V27.16B, #0
    FCMGT  V30.4H, V4.4H, V17.4H
    CMGT  V23.16B, V14.16B, V12.16B
    CMHI  V31.8B, V9.8B, V23.8B
    FCMEQ  V24.4S, V25.4S, V25.4S
    FCMGT  V8.8H, V31.8H, V31.8H
    CMTST  V31.4S, V8.4S, V30.4S
    CMHI  V8.8B, V6.8B, V24.8B
    CMLE  V19.16B, V1.16B, #0
    CMTST  V27.2D, V19.2D, V0.2D
    FCMEQ  V4.8H, V12.8H, V27.8H
    FCMGE  V6.8H, V31.8H, V16.8H
    FCMEQ  V9.2S, V12.2S, #0.0
    FCMLE  V27.4H, V4.4H, #0.0
    FCMGE  V23.4S, V27.4S, V0.4S
    FCMLE  V27.8H, V23.8H, #0.0
    CMGE  V30.16B, V27.16B, #0
    CMHS  V23.4S, V30.4S, V9.4S
    FCMEQ  V27.4S, V23.4S, V23.4S
    FCMEQ  V1.4H, V3.4H, #0.0
    CMEQ  V23.2S, V8.2S, V19.2S
    FCMEQ  V3.4S, V27.4S, #0.0
    FCMEQ  V8.4H, V11.4H, V1.4H
    CMGE  V25.8B, V8.8B, V4.8B
    FCMGT  V16.2S, V25.2S, V25.2S
    FCMGT  V0.4S, V16.4S, #0.0
    FCMGT  V27.4S, V23.4S, #0.0
    FCMGT  V23.8H, V6.8H, V0.8H
    CMGT  V30.4H, V31.4H, V10.4H
    FCMLT  V31.4S, V3.4S, #0.0
    CMHI  V10.2D, V27.2D, V2.2D
    FCMLT  V2.2D, V31.2D, #0.0
    CMLT  V3.2S, V30.2S, #0
    CMGT  V9.8B, V10.8B, V2.8B
    CMEQ  V27.4H, V3.4H, V19.4H
    CMGT  V30.16B, V27.16B, #0
    FCMEQ  V19.4H, V31.4H, #0.0
    FCMGE  V3.2S, V19.2S, #0.0
    CMGE  V27.2S, V17.2S, #0
    FCMGE  V14.2D, V19.2D, #0.0
    CMLE  V12.8H, V1.8H, #0
    FCMGE  V16.4H, V27.4H, V14.4H
    FCMGT  V6.4H, V25.4H, #0.0
    FCMGT  V31.8H, V9.8H, V16.8H
    FCMLE  V19.2D, V29.2D, #0.0
    FCMEQ  V30.4H, V30.4H, V31.4H
    FCMGE  V0.2S, V12.2S, V20.2S
    FCMLE  V25.2S, V6.2S, #0.0
    FCMGT  V3.4H, V28.4H, V6.4H
    CMEQ  V29.16B, V25.16B, V25.16B
    CMGE  V11.4S, V19.4S, V0.4S
    FCMGE  V17.2D, V2.2D, #0.0
    CMGT  V19.8B, V19.8B, V3.8B
    FCMEQ  V9.4H, V30.4H, #0.0
    CMGT  V25.2D, V11.2D, V15.2D
    FCMEQ  V23.2D, V25.2D, #0.0
    CMHS  V8.4S, V25.4S, V29.4S
    CMLT  V30.4S, V17.4S, #0
    CMHS  V17.2D, V19.2D, V29.2D
    CMEQ  V15.8B, V8.8B, #0
    CMLE  V0.8B, V5.8B, #0
    FCMGE  V16.2S, V30.2S, #0.0
    CMEQ  V17.4H, V16.4H, #0
    CMGE  V25.8B, V17.8B, #0
    CMTST  V2.2D, V23.2D, V30.2D
    FCMGT  V28.2D, V9.2D, V25.2D
    CMHS  V23.2S, V0.2S, V5.2S
    FCMGE  V3.2D, V15.2D, V3.2D
    CMGE  V0.8B, V4.8B, V3.8B
    FCMGT  V23.2D, V23.2D, V0.2D
    CMEQ  V2.4S, V1.4S, #0
    CMLE  V24.2S, V4.2S, #0
    FCMLE  V11.8H, V28.8H, #0.0
    FCMGT  V8.8H, V24.8H, V22.8H
    FCMGT  V9.4S, V8.4S, V27.4S
    FCMGE  V3.8H, V8.8H, #0.0
    CMLE  V17.2S, V3.2S, #0
    FCMLT  V5.2D, V21.2D, #0.0
    FCMLE  V15.4H, V11.4H, #0.0
    FCMGE  V22.2S, V19.2S, V9.2S
    FCMGE  V25.2D, V15.2D, V2.2D
    CMGT  V8.8H, V6.8H, #0
    CMTST  V2.4S, V19.4S, V5.4S
    FCMLE  V6.4S, V2.4S, #0.0
    FCMGT  V5.2S, V14.2S, #0.0
    CMHI  V11.2D, V5.2D, V8.2D
    FCMEQ  V29.8H, V17.8H, #0.0
    CMHS  V4.4H, V22.4H, V6.4H
    FCMGT  V9.4H, V2.4H, #0.0
    CMEQ  V24.8H, V21.8H, V11.8H
    FCMEQ  V22.4H, V0.4H, #0.0
    FCMGE  V6.2S, V22.2S, V26.2S
    FCMGE  V29.8H, V25.8H, V7.8H
    CMEQ  V3.8H, V9.8H, V22.8H
    FCMLE  V11.4H, V29.4H, #0.0
    FCMGE  V21.4H, V26.4H, #0.0
    FCMLT  V23.2D, V4.2D, #0.0
    FCMLT  V5.8H, V9.8H, #0.0
    FCMGE  V0.2D, V26.2D, #0.0
    FCMEQ  V1.2S, V5.2S, V15.2S
    CMHI  V29.8H, V23.8H, V6.8H
    CMTST  V4.4H, V29.4H, V29.4H
    FCMGE  V22.4H, V3.4H, V0.4H
    FCMEQ  V21.4S, V13.4S, #0.0
    FCMGT  V0.2S, V11.2S, V25.2S
    FCMGT  V23.4H, V1.4H, #0.0
    CMLT  V1.8B, V0.8B, #0
    FCMGT  V9.2S, V24.2S, V6.2S
    FCMEQ  V24.4S, V23.4S, #0.0
    FCMGE  V21.4H, V11.4H, #0.0
    FCMLE  V11.4H, V4.4H, #0.0
    CMLE  V1.8H, V22.8H, #0
    FCMGT  V11.8H, V24.8H, V24.8H
    FCMEQ  V5.4S, V1.4S, #0.0
    FCMGE  V19.4H, V21.4H, V14.4H
    FCMEQ  V4.2D, V3.2D, V21.2D
    FCMGT  V13.2D, V5.2D, #0.0
    FCMGT  V24.4H, V11.4H, #0.0
    FCMLE  V21.8H, V24.8H, #0.0
    CMGE  V14.8H, V30.8H, V22.8H
    FCMGT  V9.2S, V9.2S, #0.0
    FCMLT  V9.2S, V31.2S, #0.0
    FCMEQ  V3.2D, V8.2D, V19.2D
    CMGT  V19.4S, V3.4S, #0
    FCMEQ  V5.2S, V27.2S, V14.2S
    CMLT  V11.16B, V19.16B, #0
    CMTST  V27.16B, V11.16B, V11.16B
    FCMLE  V3.4H, V9.4H, #0.0
    FCMGT  V30.8H, V9.8H, #0.0
    CMGT  V8.8H, V3.8H, #0
    FCMGE  V14.8H, V21.8H, #0.0
    FCMGT  V31.4H, V30.4H, #0.0
    FCMEQ  V11.4H, V8.4H, #0.0
    FCMLE  V17.8H, V11.8H, #0.0
    FCMEQ  V11.4H, V13.4H, V17.4H
    CMGE  V17.8H, V5.8H, #0
    CMGT  V3.2S, V27.2S, #0
    CMGE  V23.2D, V11.2D, #0
    CMTST  V16.4H, V17.4H, V31.4H
    SUBS  X9, X9, #0x1
    B.NE  TSRTAdvsimdVectorCompare_label_14
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X12, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X12, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X12, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X12, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X12, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X12, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X12, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X12, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X12, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X12, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X12, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X12, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X12, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X12, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X12, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X12, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X12, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X12, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorCompare_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X12, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorCompare_TestFail
    MRS  X4, FPSR
    MOVZ  X12, #0x81, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V0.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D0
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V1.D[1]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D1
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D2
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D3
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V4.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D4
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V5.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D5
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D6
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V7.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D7
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V8.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D8
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D9
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D10
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D11
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D12
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V13.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D13
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V14.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D14
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D15
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D16
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V17.D[1]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D17
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D18
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V19.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D19
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D20
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D21
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V22.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D22
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D23
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V24.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D24
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V25.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D25
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V26.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D26
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D27
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V28.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D28
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V29.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D29
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V30.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D30
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, V31.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail
    FMOV  X4, D31
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorCompare_TestFail

TSRTAdvsimdVectorCompare_TestEnd:
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
TSRTAdvsimdVectorCompare_TestFail:
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
