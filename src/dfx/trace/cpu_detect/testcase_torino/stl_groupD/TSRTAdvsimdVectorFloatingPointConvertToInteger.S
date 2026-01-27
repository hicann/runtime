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
    MOVZ  X2, #0xed07, LSL #0
    MOVK  X2, #0x19f7, LSL #16
    MOVK  X2, #0x15ea, LSL #32
    MOVK  X2, #0x54b4, LSL #48
    MOVZ  X3, #0xc575, LSL #0
    MOVK  X3, #0x5164, LSL #16
    MOVK  X3, #0x2b8b, LSL #32
    MOVK  X3, #0x7c81, LSL #48
    MOVZ  X4, #0xa5ec, LSL #0
    MOVK  X4, #0x9369, LSL #16
    MOVK  X4, #0xc578, LSL #32
    MOVK  X4, #0xc9b5, LSL #48
    MOVZ  X5, #0x6d70, LSL #0
    MOVK  X5, #0x85a1, LSL #16
    MOVK  X5, #0x5459, LSL #32
    MOVK  X5, #0x7748, LSL #48
    MOVZ  X6, #0xafe4, LSL #0
    MOVK  X6, #0xd3fd, LSL #16
    MOVK  X6, #0x1d05, LSL #32
    MOVK  X6, #0x9897, LSL #48
    MOVZ  X7, #0xc9b5, LSL #0
    MOVK  X7, #0xf1f, LSL #16
    MOVK  X7, #0xe1ca, LSL #32
    MOVK  X7, #0x96e3, LSL #48
    MOVZ  X11, #0x9b65, LSL #0
    MOVK  X11, #0x34e, LSL #16
    MOVK  X11, #0xf17e, LSL #32
    MOVK  X11, #0xcd75, LSL #48
    MOVZ  X12, #0xaf72, LSL #0
    MOVK  X12, #0x9b3, LSL #16
    MOVK  X12, #0xa4ea, LSL #32
    MOVK  X12, #0xeec1, LSL #48
    MOVZ  X13, #0xe076, LSL #0
    MOVK  X13, #0x2280, LSL #16
    MOVK  X13, #0x1726, LSL #32
    MOVK  X13, #0xd58b, LSL #48
    MOVZ  X16, #0xa2fb, LSL #0
    MOVK  X16, #0x4926, LSL #16
    MOVK  X16, #0x2c5c, LSL #32
    MOVK  X16, #0xb60a, LSL #48
    MOVZ  X17, #0x5dbb, LSL #0
    MOVK  X17, #0x204a, LSL #16
    MOVK  X17, #0x59ad, LSL #32
    MOVK  X17, #0x8dbd, LSL #48
    MOVZ  X18, #0x54b4, LSL #0
    MOVK  X18, #0xda10, LSL #16
    MOVK  X18, #0xd1b8, LSL #32
    MOVK  X18, #0x3b48, LSL #48
    MOVZ  X19, #0x6141, LSL #0
    MOVK  X19, #0xc2dd, LSL #16
    MOVK  X19, #0xf382, LSL #32
    MOVK  X19, #0xcc81, LSL #48
    MOVZ  X20, #0x2851, LSL #0
    MOVK  X20, #0x1d7d, LSL #16
    MOVK  X20, #0x336c, LSL #32
    MOVK  X20, #0x1db3, LSL #48
    MOVZ  X21, #0xee68, LSL #0
    MOVK  X21, #0xe848, LSL #16
    MOVK  X21, #0xe8fe, LSL #32
    MOVK  X21, #0x4c5f, LSL #48
    MOVZ  X22, #0x6c7c, LSL #0
    MOVK  X22, #0xb434, LSL #16
    MOVK  X22, #0x5369, LSL #32
    MOVK  X22, #0x3772, LSL #48
    MOVZ  X23, #0x3f3a, LSL #0
    MOVK  X23, #0xc8ad, LSL #16
    MOVK  X23, #0x8106, LSL #32
    MOVK  X23, #0x233c, LSL #48
    MOVZ  X24, #0x1085, LSL #0
    MOVK  X24, #0x8884, LSL #16
    MOVK  X24, #0x10dc, LSL #32
    MOVK  X24, #0x7f31, LSL #48
    MOVZ  X25, #0x1dc9, LSL #0
    MOVK  X25, #0x43ef, LSL #16
    MOVK  X25, #0xf4fc, LSL #32
    MOVK  X25, #0xc736, LSL #48
    MOVZ  X26, #0x3394, LSL #0
    MOVK  X26, #0xda0c, LSL #16
    MOVK  X26, #0x4e3a, LSL #32
    MOVK  X26, #0x7ced, LSL #48
    MOVZ  X27, #0x6531, LSL #0
    MOVK  X27, #0x13e1, LSL #16
    MOVK  X27, #0x650c, LSL #32
    MOVK  X27, #0x1790, LSL #48
    MOVZ  X28, #0xb84a, LSL #0
    MOVK  X28, #0xe946, LSL #16
    MOVK  X28, #0x2a9a, LSL #32
    MOVK  X28, #0x8044, LSL #48
    MOVZ  X29, #0x921a, LSL #0
    MOVK  X29, #0xe235, LSL #16
    MOVK  X29, #0xda31, LSL #32
    MOVK  X29, #0xc1ba, LSL #48
    MOVZ  X13, #0x9b91, LSL #0
    MOVK  X13, #0x4a4f, LSL #16
    MOVK  X13, #0xd295, LSL #32
    MOVK  X13, #0x3ff1, LSL #48
    MSR  FPCR, X13
    MRS  X2, FPCR
    MOVZ  X18, #0x60ff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    AND  X2, X2, X18
    MOVZ  X18, #0x0, LSL #0
    ORR  X2, X2, X18
    MSR  FPCR, X2
    ISB  SY
    MOVZ  X13, #0x889, LSL #0
    MOVK  X13, #0xcb8d, LSL #16
    MOVK  X13, #0x40d2, LSL #32
    MOVK  X13, #0xfe16, LSL #48
    MSR  FPSR, X13
    MRS  X16, FPSR
    MOVZ  X17, #0xff60, LSL #0
    MOVK  X17, #0x7ff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    AND  X16, X16, X17
    MOVZ  X17, #0x0, LSL #0
    ORR  X16, X16, X17
    MSR  FPSR, X16
    ISB  SY
    ADDS  W21, W4, W5, LSL #14
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x7dd8, LSL #0
    MOVK  X2, #0xcd59, LSL #16
    MOVK  X2, #0x803, LSL #32
    MOVK  X2, #0x9785, LSL #48
    MOVZ  X3, #0xa5df, LSL #0
    MOVK  X3, #0x42e7, LSL #16
    MOVK  X3, #0x9fe1, LSL #32
    MOVK  X3, #0x3df0, LSL #48
    MOVZ  X4, #0xcc6c, LSL #0
    MOVK  X4, #0xd959, LSL #16
    MOVK  X4, #0x1351, LSL #32
    MOVK  X4, #0xf07, LSL #48
    MOVZ  X5, #0xc0fa, LSL #0
    MOVK  X5, #0x29d0, LSL #16
    MOVK  X5, #0x7f89, LSL #32
    MOVK  X5, #0x5715, LSL #48
    MOVZ  X6, #0x59d8, LSL #0
    MOVK  X6, #0x88e0, LSL #16
    MOVK  X6, #0xc7, LSL #32
    MOVK  X6, #0x9bc7, LSL #48
    MOVZ  X7, #0xa468, LSL #0
    MOVK  X7, #0x37a9, LSL #16
    MOVK  X7, #0x73f0, LSL #32
    MOVK  X7, #0x4403, LSL #48
    MOVZ  X11, #0xa6e8, LSL #0
    MOVK  X11, #0x9838, LSL #16
    MOVK  X11, #0xd66e, LSL #32
    MOVK  X11, #0x6b82, LSL #48
    MOVZ  X12, #0xd28c, LSL #0
    MOVK  X12, #0x24d3, LSL #16
    MOVK  X12, #0x6e15, LSL #32
    MOVK  X12, #0xfb3, LSL #48
    MOVZ  X13, #0x245a, LSL #0
    MOVK  X13, #0xc342, LSL #16
    MOVK  X13, #0x5a0b, LSL #32
    MOVK  X13, #0x5aad, LSL #48
    MOVZ  X16, #0xc4d6, LSL #0
    MOVK  X16, #0x35ab, LSL #16
    MOVK  X16, #0xb076, LSL #32
    MOVK  X16, #0x9ce4, LSL #48
    MOVZ  X17, #0x60c3, LSL #0
    MOVK  X17, #0x2fb4, LSL #16
    MOVK  X17, #0x24ed, LSL #32
    MOVK  X17, #0x99de, LSL #48
    MOVZ  X18, #0xede8, LSL #0
    MOVK  X18, #0x31e8, LSL #16
    MOVK  X18, #0x5bfe, LSL #32
    MOVK  X18, #0xd4cd, LSL #48
    MOVZ  X19, #0xcb4b, LSL #0
    MOVK  X19, #0xa963, LSL #16
    MOVK  X19, #0xa081, LSL #32
    MOVK  X19, #0x7653, LSL #48
    MOVZ  X20, #0x2064, LSL #0
    MOVK  X20, #0xf9de, LSL #16
    MOVK  X20, #0x13f, LSL #32
    MOVK  X20, #0x1b23, LSL #48
    MOVZ  X21, #0x9595, LSL #0
    MOVK  X21, #0x3f9e, LSL #16
    MOVK  X21, #0xbe6, LSL #32
    MOVK  X21, #0x1563, LSL #48
    MOVZ  X22, #0x6056, LSL #0
    MOVK  X22, #0x5918, LSL #16
    MOVK  X22, #0x117c, LSL #32
    MOVK  X22, #0x2089, LSL #48
    MOVZ  X23, #0x58a4, LSL #0
    MOVK  X23, #0xbe5d, LSL #16
    MOVK  X23, #0xb0b, LSL #32
    MOVK  X23, #0xb417, LSL #48
    MOVZ  X24, #0x5a7b, LSL #0
    MOVK  X24, #0xb805, LSL #16
    MOVK  X24, #0xde2f, LSL #32
    MOVK  X24, #0x2c81, LSL #48
    MOVZ  X25, #0x4ef2, LSL #0
    MOVK  X25, #0x6fd5, LSL #16
    MOVK  X25, #0xcb3d, LSL #32
    MOVK  X25, #0x6a51, LSL #48
    MOVZ  X26, #0x9a0a, LSL #0
    MOVK  X26, #0x141a, LSL #16
    MOVK  X26, #0x8e8d, LSL #32
    MOVK  X26, #0x3067, LSL #48
    MOVZ  X27, #0xce5c, LSL #0
    MOVK  X27, #0xe1ae, LSL #16
    MOVK  X27, #0xdf17, LSL #32
    MOVK  X27, #0xb29d, LSL #48
    MOVZ  X28, #0x6469, LSL #0
    MOVK  X28, #0x4d1a, LSL #16
    MOVK  X28, #0xb79c, LSL #32
    MOVK  X28, #0xac47, LSL #48
    MOVZ  X29, #0x4fb0, LSL #0
    MOVK  X29, #0x33f1, LSL #16
    MOVK  X29, #0x2635, LSL #32
    MOVK  X29, #0xeb78, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X17
    FMOV  D1, X26
    FMOV  V1.D[1], X25
    FMOV  D2, X11
    FMOV  V2.D[1], X29
    FMOV  D3, X27
    FMOV  V3.D[1], X27
    FMOV  D4, X17
    FMOV  V4.D[1], X20
    FMOV  D5, X11
    FMOV  V5.D[1], X21
    FMOV  D6, X28
    FMOV  V6.D[1], X12
    FMOV  D7, X22
    FMOV  V7.D[1], X12
    FMOV  D8, X29
    FMOV  V8.D[1], X29
    FMOV  D9, X5
    FMOV  V9.D[1], X29
    FMOV  D10, X22
    FMOV  V10.D[1], X23
    FMOV  D11, X24
    FMOV  V11.D[1], X20
    FMOV  D12, X21
    FMOV  V12.D[1], X26
    FMOV  D13, X20
    FMOV  V13.D[1], X6
    FMOV  D14, X4
    FMOV  V14.D[1], X21
    FMOV  D15, X19
    FMOV  V15.D[1], X3
    FMOV  D16, X20
    FMOV  V16.D[1], X28
    FMOV  D17, X18
    FMOV  V17.D[1], X4
    FMOV  D18, X3
    FMOV  V18.D[1], X17
    FMOV  D19, X20
    FMOV  V19.D[1], X4
    FMOV  D20, X12
    FMOV  V20.D[1], X13
    FMOV  D21, X22
    FMOV  V21.D[1], X22
    FMOV  D22, X5
    FMOV  V22.D[1], X27
    FMOV  D23, X20
    FMOV  V23.D[1], X23
    FMOV  D24, X22
    FMOV  V24.D[1], X18
    FMOV  D25, X11
    FMOV  V25.D[1], X5
    FMOV  D26, X26
    FMOV  V26.D[1], X12
    FMOV  D27, X4
    FMOV  V27.D[1], X28
    FMOV  D28, X12
    FMOV  V28.D[1], X5
    FMOV  D29, X26
    FMOV  V29.D[1], X29
    FMOV  D30, X17
    FMOV  V30.D[1], X23
    FMOV  D31, X11
    FMOV  V31.D[1], X29
    FCVTAS  V28.2D, V25.2D
    FCVTAS  V26.2S, V28.2S
    FCVTAS  V26.4S, V26.4S
    FCVTAS  V8.2S, V31.2S
    FCVTAS  V19.4S, V27.4S
    FCVTAS  V21.2S, V19.2S
    FCVTAS  V20.2S, V30.2S
    FCVTAS  V6.2S, V30.2S
    FCVTAS  V23.2S, V0.2S
    FCVTAS  V22.4S, V21.4S
    FCVTAU  V13.4S, V6.4S
    FCVTAU  V18.2S, V24.2S
    FCVTAU  V19.2D, V29.2D
    FCVTAU  V22.2D, V22.2D
    FCVTAU  V13.2D, V18.2D
    FCVTAU  V22.4S, V12.4S
    FCVTAU  V30.4S, V8.4S
    FCVTAU  V4.4S, V19.4S
    FCVTAU  V24.2D, V20.2D
    FCVTAU  V11.4S, V3.4S
    FCVTL  V28.4S, V30.4H
    FCVTL  V20.2D, V24.2S
    FCVTL  V25.2D, V23.2S
    FCVTL  V26.2D, V29.2S
    FCVTL  V29.2D, V18.2S
    FCVTL  V30.2D, V22.2S
    FCVTL  V24.4S, V11.4H
    FCVTL  V28.4S, V22.4H
    FCVTL  V0.2D, V28.2S
    FCVTL  V22.2D, V10.2S
    FCVTL2  V7.4S, V4.8H
    FCVTL2  V3.4S, V0.8H
    FCVTL2  V11.2D, V20.4S
    FCVTL2  V16.2D, V20.4S
    FCVTL2  V10.4S, V25.8H
    FCVTL2  V20.4S, V24.8H
    FCVTL2  V28.4S, V20.8H
    FCVTL2  V24.4S, V10.8H
    FCVTL2  V4.4S, V13.8H
    FCVTL2  V18.2D, V26.4S
    FCVTMS  V13.4S, V19.4S
    FCVTMS  V28.4S, V22.4S
    FCVTMS  V25.4S, V28.4S
    FCVTMS  V21.2D, V24.2D
    FCVTMS  V23.2D, V5.2D
    FCVTMS  V26.2S, V11.2S
    FCVTMS  V5.2D, V3.2D
    FCVTMS  V19.2S, V12.2S
    FCVTMS  V22.4S, V26.4S
    FCVTMS  V0.2S, V25.2S
    FCVTMU  V20.4S, V10.4S
    FCVTMU  V25.2D, V19.2D
    FCVTMU  V11.2D, V22.2D
    FCVTMU  V28.2S, V25.2S
    FCVTMU  V10.2S, V21.2S
    FCVTMU  V19.2D, V10.2D
    FCVTMU  V22.4S, V16.4S
    FCVTMU  V12.4S, V28.4S
    FCVTMU  V18.4S, V4.4S
    FCVTMU  V28.2D, V27.2D
    FCVTN  V10.2S, V20.2D
    FCVTN  V27.2S, V19.2D
    FCVTN  V0.4H, V23.4S
    FCVTN  V22.2S, V10.2D
    FCVTN  V12.4H, V0.4S
    FCVTN  V20.2S, V28.2D
    FCVTN  V24.4H, V18.4S
    FCVTN  V23.2S, V13.2D
    FCVTN  V3.4H, V12.4S
    FCVTN  V10.2S, V24.2D
    FCVTN2  V26.4S, V2.2D
    FCVTN2  V4.4S, V27.2D
    FCVTN2  V0.8H, V8.4S
    FCVTN2  V27.4S, V26.2D
    FCVTN2  V13.4S, V15.2D
    FCVTN2  V16.8H, V9.4S
    FCVTN2  V28.4S, V16.2D
    FCVTN2  V15.8H, V23.4S
    FCVTN2  V24.8H, V3.4S
    FCVTN2  V3.4S, V20.2D
    FCVTNS  V19.2D, V15.2D
    FCVTNS  V12.4S, V27.4S
    FCVTNS  V26.4S, V4.4S
    FCVTNS  V18.2S, V11.2S
    FCVTNS  V4.2D, V13.2D
    FCVTNS  V9.2D, V13.2D
    FCVTNS  V11.4S, V12.4S
    FCVTNS  V15.4S, V24.4S
    FCVTNS  V29.4S, V3.4S
    FCVTNS  V7.4S, V29.4S
    FCVTNU  V0.2S, V19.2S
    FCVTNU  V7.2S, V15.2S
    FCVTNU  V27.4S, V4.4S
    FCVTNU  V23.2D, V26.2D
    FCVTNU  V26.4S, V7.4S
    FCVTNU  V16.4S, V29.4S
    FCVTNU  V19.2D, V26.2D
    FCVTNU  V23.2S, V9.2S
    FCVTNU  V13.4S, V27.4S
    FCVTNU  V2.2D, V16.2D
    FCVTPS  V4.4S, V17.4S
    FCVTPS  V12.4S, V24.4S
    FCVTPS  V7.2D, V25.2D
    FCVTPS  V9.2D, V13.2D
    FCVTPS  V24.4S, V7.4S
    FCVTPS  V17.2D, V11.2D
    FCVTPS  V16.2S, V0.2S
    FCVTPS  V11.2D, V18.2D
    FCVTPS  V25.2D, V9.2D
    FCVTPS  V26.2S, V17.2S
    FCVTPU  V2.2D, V25.2D
    FCVTPU  V17.2D, V2.2D
    FCVTPU  V9.4S, V4.4S
    FCVTPU  V25.4S, V12.4S
    FCVTPU  V31.4S, V0.4S
    FCVTPU  V29.2D, V16.2D
    FCVTPU  V12.4S, V29.4S
    FCVTPU  V23.2S, V30.2S
    FCVTPU  V0.2D, V12.2D
    FCVTPU  V13.2S, V25.2S
    FCVTXN  V7.2S, V26.2D
    FCVTXN  V7.2S, V1.2D
    FCVTXN  V25.2S, V1.2D
    FCVTXN  V12.2S, V23.2D
    FCVTXN  V16.2S, V11.2D
    FCVTXN  V1.2S, V17.2D
    FCVTXN  V29.2S, V7.2D
    FCVTXN  V2.2S, V24.2D
    FCVTXN  V31.2S, V1.2D
    FCVTXN  V26.2S, V24.2D
    FCVTXN2  V23.4S, V23.2D
    FCVTXN2  V17.4S, V0.2D
    FCVTXN2  V15.4S, V25.2D
    FCVTXN2  V0.4S, V12.2D
    FCVTXN2  V27.4S, V15.2D
    FCVTXN2  V31.4S, V27.2D
    FCVTXN2  V24.4S, V18.2D
    FCVTXN2  V18.4S, V17.2D
    FCVTXN2  V13.4S, V30.2D
    FCVTXN2  V27.4S, V0.2D
    FCVTZS V7.2D, V29.2D, #63
    FCVTZS V29.2D, V27.2D, #27
    FCVTZS V11.2D, V7.2D, #48
    FCVTZS V8.2D, V11.2D, #5
    FCVTZS V30.2D, V23.2D, #42
    FCVTZS V23.2D, V13.2D, #51
    FCVTZS V13.2D, V8.2D, #51
    FCVTZS V25.2D, V29.2D, #60
    FCVTZS V17.2D, V26.2D, #14
    FCVTZS V11.2D, V30.2D, #63
    FCVTZS  V8.2S, V4.2S, #10
    FCVTZS  V12.2S, V30.2S, #1
    FCVTZS  V1.4S, V23.4S, #31
    FCVTZS  V29.2S, V24.2S, #24
    FCVTZS  V24.2S, V2.2S, #1
    FCVTZS  V27.4S, V24.4S, #17
    FCVTZS  V7.4S, V8.4S, #18
    FCVTZS  V4.4S, V31.4S, #15
    FCVTZS  V26.4S, V1.4S, #19
    FCVTZS  V3.2S, V12.2S, #29
    FCVTZS  V1.4S, V27.4S
    FCVTZS  V30.2D, V11.2D
    FCVTZS  V15.4S, V3.4S
    FCVTZS  V16.2D, V26.2D
    FCVTZS  V27.2S, V1.2S
    FCVTZS  V1.4S, V25.4S
    FCVTZS  V23.2S, V18.2S
    FCVTZS  V12.2S, V22.2S
    FCVTZS  V25.2D, V16.2D
    FCVTZS  V18.2D, V29.2D
    FCVTZU V31.2D, V15.2D, #53
    FCVTZU V3.2D, V18.2D, #49
    FCVTZU V26.2D, V21.2D, #62
    FCVTZU V15.2D, V30.2D, #55
    FCVTZU V19.2D, V23.2D, #49
    FCVTZU V30.2D, V31.2D, #19
    FCVTZU V8.2D, V15.2D, #21
    FCVTZU V29.2D, V30.2D, #5
    FCVTZU V16.2D, V12.2D, #46
    FCVTZU V23.2D, V27.2D, #56
    FCVTZU  V27.4S, V4.4S, #27
    FCVTZU  V15.2S, V16.2S, #17
    FCVTZU  V4.4S, V29.4S, #14
    FCVTZU  V21.4S, V11.4S, #2
    FCVTZU  V16.2S, V27.2S, #28
    FCVTZU  V17.4S, V7.4S, #30
    FCVTZU  V30.2S, V8.2S, #16
    FCVTZU  V29.4S, V25.4S, #18
    FCVTZU  V12.2S, V1.2S, #19
    FCVTZU  V9.4S, V3.4S, #30
    FCVTZU  V27.2D, V12.2D
    FCVTZU  V3.2S, V16.2S
    FCVTZU  V12.4S, V17.4S
    FCVTZU  V31.4S, V21.4S
    FCVTZU  V21.2D, V9.2D
    FCVTZU  V20.4S, V17.4S
    FCVTZU  V24.2S, V25.2S
    FCVTZU  V7.4S, V27.4S
    FCVTZU  V13.4S, V12.4S
    FCVTZU  V3.2S, V3.2S
    FCVTAS  V18.8H, V16.8H
    FCVTAS  V17.4H, V31.4H
    FCVTAS  V9.8H, V20.8H
    FCVTAS  V25.8H, V23.8H
    FCVTAS  V8.8H, V19.8H
    FCVTAS  V20.4H, V3.4H
    FCVTAS  V15.4H, V30.4H
    FCVTAS  V3.4H, V24.4H
    FCVTAS  V19.8H, V9.8H
    FCVTAS  V6.4H, V17.4H
    FCVTAU  V9.4H, V15.4H
    FCVTAU  V27.4H, V11.4H
    FCVTAU  V16.8H, V21.8H
    FCVTAU  V21.4H, V20.4H
    FCVTAU  V17.4H, V21.4H
    FCVTAU  V25.4H, V0.4H
    FCVTAU  V24.4H, V16.4H
    FCVTAU  V30.4H, V25.4H
    FCVTAU  V12.8H, V8.8H
    FCVTAU  V31.4H, V6.4H
    FCVTMS  V21.4H, V24.4H
    FCVTMS  V23.8H, V15.8H
    FCVTMS  V15.4H, V18.4H
    FCVTMS  V6.4H, V12.4H
    FCVTMS  V26.4H, V17.4H
    FCVTMS  V16.8H, V12.8H
    FCVTMS  V1.4H, V27.4H
    FCVTMS  V11.4H, V31.4H
    FCVTMS  V25.8H, V30.8H
    FCVTMS  V0.4H, V13.4H
    FCVTMU  V8.8H, V1.8H
    FCVTMU  V12.4H, V9.4H
    FCVTMU  V23.4H, V25.4H
    FCVTMU  V4.8H, V0.8H
    FCVTMU  V20.8H, V11.8H
    FCVTMU  V24.8H, V12.8H
    FCVTMU  V30.8H, V13.8H
    FCVTMU  V18.4H, V24.4H
    FCVTMU  V27.4H, V23.4H
    FCVTMU  V31.8H, V28.8H
    FCVTNS  V11.4H, V6.4H
    FCVTNS  V1.8H, V28.8H
    FCVTNS  V18.8H, V4.8H
    FCVTNS  V6.4H, V31.4H
    FCVTNS  V9.8H, V21.8H
    FCVTNS  V24.4H, V0.4H
    FCVTNS  V4.8H, V15.8H
    FCVTNS  V21.8H, V18.8H
    FCVTNS  V0.8H, V19.8H
    FCVTNS  V15.8H, V4.8H
    FCVTNU  V23.8H, V17.8H
    FCVTNU  V25.4H, V26.4H
    FCVTNU  V22.4H, V0.4H
    FCVTNU  V12.8H, V14.8H
    FCVTNU  V28.8H, V14.8H
    FCVTNU  V4.4H, V9.4H
    FCVTNU  V0.8H, V8.8H
    FCVTNU  V9.4H, V21.4H
    FCVTNU  V24.8H, V27.8H
    FCVTNU  V21.4H, V24.4H
    FCVTPS  V24.8H, V28.8H
    FCVTPS  V1.8H, V20.8H
    FCVTPS  V19.4H, V24.4H
    FCVTPS  V8.8H, V12.8H
    FCVTPS  V17.8H, V25.8H
    FCVTPS  V27.4H, V23.4H
    FCVTPS  V25.8H, V0.8H
    FCVTPS  V16.8H, V21.8H
    FCVTPS  V24.4H, V8.4H
    FCVTPS  V8.4H, V17.4H
    FCVTPU  V26.4H, V27.4H
    FCVTPU  V28.4H, V9.4H
    FCVTPU  V21.8H, V1.8H
    FCVTPU  V17.8H, V19.8H
    FCVTPU  V20.4H, V22.4H
    FCVTPU  V10.8H, V15.8H
    FCVTPU  V18.4H, V26.4H
    FCVTPU  V1.4H, V17.4H
    FCVTPU  V23.8H, V16.8H
    FCVTPU  V19.8H, V10.8H
    FCVTZS  V14.8H, V3.8H, #5
    FCVTZS  V0.4H, V8.4H, #12
    FCVTZS  V3.8H, V1.8H, #15
    FCVTZS  V22.4H, V21.4H, #2
    FCVTZS  V1.4H, V14.4H, #1
    FCVTZS  V8.8H, V28.8H, #14
    FCVTZS  V16.4H, V0.4H, #12
    FCVTZS  V16.4H, V3.4H, #6
    FCVTZS  V26.4H, V23.4H, #5
    FCVTZS  V31.8H, V8.8H, #11
    FCVTZS  V21.8H, V19.8H
    FCVTZS  V17.8H, V10.8H
    FCVTZS  V10.8H, V1.8H
    FCVTZS  V8.4H, V16.4H
    FCVTZS  V19.8H, V8.8H
    FCVTZS  V1.8H, V22.8H
    FCVTZS  V8.4H, V10.4H
    FCVTZS  V27.8H, V19.8H
    FCVTZS  V15.8H, V22.8H
    FCVTZS  V28.8H, V31.8H
    MOVZ  X13, #0x7dd8, LSL #0
    MOVK  X13, #0xcd59, LSL #16
    MOVK  X13, #0x803, LSL #32
    MOVK  X13, #0x9785, LSL #48
    SUB  X11, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0xa5df, LSL #0
    MOVK  X13, #0x42e7, LSL #16
    MOVK  X13, #0x9fe1, LSL #32
    MOVK  X13, #0x3df0, LSL #48
    SUB  X11, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0xcc6c, LSL #0
    MOVK  X13, #0xd959, LSL #16
    MOVK  X13, #0x1351, LSL #32
    MOVK  X13, #0xf07, LSL #48
    SUB  X11, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0xc0fa, LSL #0
    MOVK  X13, #0x29d0, LSL #16
    MOVK  X13, #0x7f89, LSL #32
    MOVK  X13, #0x5715, LSL #48
    SUB  X11, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0x59d8, LSL #0
    MOVK  X13, #0x88e0, LSL #16
    MOVK  X13, #0xc7, LSL #32
    MOVK  X13, #0x9bc7, LSL #48
    SUB  X11, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0xa468, LSL #0
    MOVK  X13, #0x37a9, LSL #16
    MOVK  X13, #0x73f0, LSL #32
    MOVK  X13, #0x4403, LSL #48
    SUB  X11, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0xd28c, LSL #0
    MOVK  X13, #0x24d3, LSL #16
    MOVK  X13, #0x6e15, LSL #32
    MOVK  X13, #0xfb3, LSL #48
    SUB  X11, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0xc4d6, LSL #0
    MOVK  X13, #0x35ab, LSL #16
    MOVK  X13, #0xb076, LSL #32
    MOVK  X13, #0x9ce4, LSL #48
    SUB  X11, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0x60c3, LSL #0
    MOVK  X13, #0x2fb4, LSL #16
    MOVK  X13, #0x24ed, LSL #32
    MOVK  X13, #0x99de, LSL #48
    SUB  X11, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0xede8, LSL #0
    MOVK  X13, #0x31e8, LSL #16
    MOVK  X13, #0x5bfe, LSL #32
    MOVK  X13, #0xd4cd, LSL #48
    SUB  X11, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0xcb4b, LSL #0
    MOVK  X13, #0xa963, LSL #16
    MOVK  X13, #0xa081, LSL #32
    MOVK  X13, #0x7653, LSL #48
    SUB  X11, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0x2064, LSL #0
    MOVK  X13, #0xf9de, LSL #16
    MOVK  X13, #0x13f, LSL #32
    MOVK  X13, #0x1b23, LSL #48
    SUB  X11, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0x9595, LSL #0
    MOVK  X13, #0x3f9e, LSL #16
    MOVK  X13, #0xbe6, LSL #32
    MOVK  X13, #0x1563, LSL #48
    SUB  X11, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0x6056, LSL #0
    MOVK  X13, #0x5918, LSL #16
    MOVK  X13, #0x117c, LSL #32
    MOVK  X13, #0x2089, LSL #48
    SUB  X11, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0x58a4, LSL #0
    MOVK  X13, #0xbe5d, LSL #16
    MOVK  X13, #0xb0b, LSL #32
    MOVK  X13, #0xb417, LSL #48
    SUB  X11, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0x5a7b, LSL #0
    MOVK  X13, #0xb805, LSL #16
    MOVK  X13, #0xde2f, LSL #32
    MOVK  X13, #0x2c81, LSL #48
    SUB  X11, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0x4ef2, LSL #0
    MOVK  X13, #0x6fd5, LSL #16
    MOVK  X13, #0xcb3d, LSL #32
    MOVK  X13, #0x6a51, LSL #48
    SUB  X11, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0x9a0a, LSL #0
    MOVK  X13, #0x141a, LSL #16
    MOVK  X13, #0x8e8d, LSL #32
    MOVK  X13, #0x3067, LSL #48
    SUB  X11, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0x6469, LSL #0
    MOVK  X13, #0x4d1a, LSL #16
    MOVK  X13, #0xb79c, LSL #32
    MOVK  X13, #0xac47, LSL #48
    SUB  X11, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0x4fb0, LSL #0
    MOVK  X13, #0x33f1, LSL #16
    MOVK  X13, #0x2635, LSL #32
    MOVK  X13, #0xeb78, LSL #48
    SUB  X11, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MRS  X13, FPSR
    MOVZ  X11, #0x1d, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V0.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D0
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V1.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D1
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D2
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D3
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V4.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D4
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D5
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D6
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V7.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D7
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V8.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D8
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D9
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D10
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D11
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x2, LSL #16
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D12
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V13.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D13
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V14.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D14
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D15
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D16
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D17
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D18
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D19
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D20
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D21
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D22
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V23.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D23
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D24
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D25
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V26.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D26
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D27
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V28.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D28
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V29.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D29
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V30.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D30
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V31.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D31
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X2, #0x31fe, LSL #0
    MOVK  X2, #0xcf84, LSL #16
    MOVK  X2, #0xba29, LSL #32
    MOVK  X2, #0xcaae, LSL #48
    MOVZ  X3, #0xf830, LSL #0
    MOVK  X3, #0x2613, LSL #16
    MOVK  X3, #0x36fd, LSL #32
    MOVK  X3, #0xf308, LSL #48
    MOVZ  X4, #0x93e3, LSL #0
    MOVK  X4, #0x8f57, LSL #16
    MOVK  X4, #0xd350, LSL #32
    MOVK  X4, #0x871d, LSL #48
    MOVZ  X5, #0xd238, LSL #0
    MOVK  X5, #0x26f, LSL #16
    MOVK  X5, #0xe65a, LSL #32
    MOVK  X5, #0xb14, LSL #48
    MOVZ  X6, #0x6bbe, LSL #0
    MOVK  X6, #0xf7f, LSL #16
    MOVK  X6, #0x456, LSL #32
    MOVK  X6, #0x5159, LSL #48
    MOVZ  X7, #0x811a, LSL #0
    MOVK  X7, #0x4ffe, LSL #16
    MOVK  X7, #0xc69a, LSL #32
    MOVK  X7, #0x1bfd, LSL #48
    MOVZ  X11, #0x9983, LSL #0
    MOVK  X11, #0x7e7c, LSL #16
    MOVK  X11, #0xc1a5, LSL #32
    MOVK  X11, #0x5495, LSL #48
    MOVZ  X12, #0x1608, LSL #0
    MOVK  X12, #0xed1b, LSL #16
    MOVK  X12, #0x35fb, LSL #32
    MOVK  X12, #0x8127, LSL #48
    MOVZ  X13, #0x1823, LSL #0
    MOVK  X13, #0x1b83, LSL #16
    MOVK  X13, #0x9c57, LSL #32
    MOVK  X13, #0xfaed, LSL #48
    MOVZ  X16, #0xbb5, LSL #0
    MOVK  X16, #0x37e4, LSL #16
    MOVK  X16, #0x972f, LSL #32
    MOVK  X16, #0xd823, LSL #48
    MOVZ  X17, #0x117a, LSL #0
    MOVK  X17, #0x7606, LSL #16
    MOVK  X17, #0x6801, LSL #32
    MOVK  X17, #0x4e74, LSL #48
    MOVZ  X18, #0x81e0, LSL #0
    MOVK  X18, #0x143a, LSL #16
    MOVK  X18, #0xd14e, LSL #32
    MOVK  X18, #0x5045, LSL #48
    MOVZ  X19, #0x3dde, LSL #0
    MOVK  X19, #0xa0db, LSL #16
    MOVK  X19, #0x8879, LSL #32
    MOVK  X19, #0x3264, LSL #48
    MOVZ  X20, #0x1069, LSL #0
    MOVK  X20, #0x1241, LSL #16
    MOVK  X20, #0x2977, LSL #32
    MOVK  X20, #0xb2af, LSL #48
    MOVZ  X21, #0x43a3, LSL #0
    MOVK  X21, #0x8b32, LSL #16
    MOVK  X21, #0xf5cd, LSL #32
    MOVK  X21, #0x1582, LSL #48
    MOVZ  X22, #0xed91, LSL #0
    MOVK  X22, #0x5c92, LSL #16
    MOVK  X22, #0x2a88, LSL #32
    MOVK  X22, #0xbdef, LSL #48
    MOVZ  X23, #0xa6ca, LSL #0
    MOVK  X23, #0x58b9, LSL #16
    MOVK  X23, #0x4ee7, LSL #32
    MOVK  X23, #0x34b2, LSL #48
    MOVZ  X24, #0xe71a, LSL #0
    MOVK  X24, #0xaca5, LSL #16
    MOVK  X24, #0x4d06, LSL #32
    MOVK  X24, #0x43e2, LSL #48
    MOVZ  X25, #0x1bc, LSL #0
    MOVK  X25, #0xf395, LSL #16
    MOVK  X25, #0xae74, LSL #32
    MOVK  X25, #0xc905, LSL #48
    MOVZ  X26, #0x9ed8, LSL #0
    MOVK  X26, #0x6fdd, LSL #16
    MOVK  X26, #0x702e, LSL #32
    MOVK  X26, #0xbd76, LSL #48
    MOVZ  X27, #0xddb5, LSL #0
    MOVK  X27, #0x3f41, LSL #16
    MOVK  X27, #0x5af4, LSL #32
    MOVK  X27, #0x565b, LSL #48
    MOVZ  X28, #0x4e71, LSL #0
    MOVK  X28, #0xb2ef, LSL #16
    MOVK  X28, #0x13fa, LSL #32
    MOVK  X28, #0xe86, LSL #48
    MOVZ  X29, #0x63a7, LSL #0
    MOVK  X29, #0x83d9, LSL #16
    MOVK  X29, #0x1d54, LSL #32
    MOVK  X29, #0x1992, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X27
    FMOV  D1, X23
    FMOV  V1.D[1], X28
    FMOV  D2, X26
    FMOV  V2.D[1], X25
    FMOV  D3, X3
    FMOV  V3.D[1], X25
    FMOV  D4, X17
    FMOV  V4.D[1], X6
    FMOV  D5, X16
    FMOV  V5.D[1], X25
    FMOV  D6, X18
    FMOV  V6.D[1], X22
    FMOV  D7, X22
    FMOV  V7.D[1], X4
    FMOV  D8, X29
    FMOV  V8.D[1], X29
    FMOV  D9, X29
    FMOV  V9.D[1], X18
    FMOV  D10, X20
    FMOV  V10.D[1], X3
    FMOV  D11, X22
    FMOV  V11.D[1], X26
    FMOV  D12, X26
    FMOV  V12.D[1], X18
    FMOV  D13, X27
    FMOV  V13.D[1], X13
    FMOV  D14, X5
    FMOV  V14.D[1], X28
    FMOV  D15, X2
    FMOV  V15.D[1], X22
    FMOV  D16, X22
    FMOV  V16.D[1], X28
    FMOV  D17, X19
    FMOV  V17.D[1], X27
    FMOV  D18, X20
    FMOV  V18.D[1], X24
    FMOV  D19, X12
    FMOV  V19.D[1], X5
    FMOV  D20, X13
    FMOV  V20.D[1], X6
    FMOV  D21, X26
    FMOV  V21.D[1], X6
    FMOV  D22, X18
    FMOV  V22.D[1], X2
    FMOV  D23, X2
    FMOV  V23.D[1], X12
    FMOV  D24, X17
    FMOV  V24.D[1], X4
    FMOV  D25, X12
    FMOV  V25.D[1], X27
    FMOV  D26, X29
    FMOV  V26.D[1], X24
    FMOV  D27, X4
    FMOV  V27.D[1], X6
    FMOV  D28, X20
    FMOV  V28.D[1], X22
    FMOV  D29, X21
    FMOV  V29.D[1], X28
    FMOV  D30, X28
    FMOV  V30.D[1], X26
    FMOV  D31, X16
    FMOV  V31.D[1], X2
    FCVTZU  V27.4H, V22.4H, #6
    FCVTZU  V15.8H, V9.8H, #13
    FCVTZU  V0.8H, V31.8H, #6
    FCVTZU  V10.8H, V25.8H, #13
    FCVTZU  V18.4H, V15.4H, #15
    FCVTZU  V31.4H, V24.4H, #15
    FCVTZU  V9.4H, V18.4H, #4
    FCVTZU  V24.8H, V3.8H, #2
    FCVTZU  V20.4H, V30.4H, #2
    FCVTZU  V31.4H, V0.4H, #13
    FCVTZU  V16.4H, V20.4H
    FCVTZU  V24.8H, V29.8H
    FCVTZU  V31.4H, V28.4H
    FCVTZU  V7.8H, V29.8H
    FCVTZU  V21.8H, V2.8H
    FCVTZU  V30.8H, V24.8H
    FCVTZU  V15.8H, V10.8H
    FCVTZU  V25.4H, V30.4H
    FCVTZU  V16.4H, V7.4H
    FCVTZU  V0.4H, V29.4H
    FRINTA  V8.2S, V31.2S
    FRINTA  V13.2D, V9.2D
    FRINTA  V24.4S, V15.4S
    FRINTA  V6.4S, V21.4S
    FRINTA  V15.2S, V6.2S
    FRINTA  V20.4S, V13.4S
    FRINTA  V18.2S, V27.2S
    FRINTA  V28.4S, V0.4S
    FRINTA  V10.2S, V18.2S
    FRINTA  V30.2D, V29.2D
    FRINTI  V9.2D, V15.2D
    FRINTI  V0.2D, V8.2D
    FRINTI  V3.2D, V8.2D
    FRINTI  V31.2D, V23.2D
    FRINTI  V10.2S, V10.2S
    FRINTI  V27.4S, V20.4S
    FRINTI  V20.2S, V16.2S
    FRINTI  V8.2D, V31.2D
    FRINTI  V23.2D, V2.2D
    FRINTI  V7.2D, V9.2D
    FRINTM  V29.2S, V30.2S
    FRINTM  V6.2D, V23.2D
    FRINTM  V16.2D, V16.2D
    FRINTM  V31.2S, V27.2S
    FRINTM  V30.2S, V6.2S
    FRINTM  V9.2D, V31.2D
    FRINTM  V23.4S, V23.4S
    FRINTM  V2.2D, V24.2D
    FRINTM  V13.2S, V3.2S
    FRINTM  V31.2D, V16.2D
    FRINTN  V3.4S, V31.4S
    FRINTN  V27.2D, V0.2D
    FRINTN  V30.2D, V27.2D
    FRINTN  V25.2S, V13.2S
    FRINTN  V6.2S, V2.2S
    FRINTN  V13.2S, V28.2S
    FRINTN  V2.4S, V15.4S
    FRINTN  V15.2D, V2.2D
    FRINTN  V9.4S, V3.4S
    FRINTN  V13.2S, V7.2S
    FRINTP  V31.2S, V23.2S
    FRINTP  V4.2D, V25.2D
    FRINTP  V23.4S, V23.4S
    FRINTP  V16.2S, V13.2S
    FRINTP  V3.2D, V31.2D
    FRINTP  V19.2D, V18.2D
    FRINTP  V16.2S, V3.2S
    FRINTP  V3.4S, V15.4S
    FRINTP  V30.2D, V16.2D
    FRINTP  V28.4S, V4.4S
    FRINTX  V24.2S, V14.2S
    FRINTX  V0.4S, V9.4S
    FRINTX  V23.2S, V30.2S
    FRINTX  V15.2D, V23.2D
    FRINTX  V30.2S, V19.2S
    FRINTX  V10.2S, V14.2S
    FRINTX  V9.2D, V28.2D
    FRINTX  V14.4S, V10.4S
    FRINTX  V16.4S, V0.4S
    FRINTX  V15.4S, V8.4S
    FRINTZ  V1.2D, V16.2D
    FRINTZ  V16.4S, V4.4S
    FRINTZ  V19.4S, V13.4S
    FRINTZ  V0.2S, V6.2S
    FRINTZ  V25.2D, V0.2D
    FRINTZ  V23.2D, V19.2D
    FRINTZ  V0.2S, V9.2S
    FRINTZ  V23.2S, V30.2S
    FRINTZ  V19.2S, V6.2S
    FRINTZ  V18.4S, V3.4S
    FRINTA  V31.8H, V9.8H
    FRINTA  V9.4H, V12.4H
    FRINTA  V3.8H, V18.8H
    FRINTA  V25.8H, V23.8H
    FRINTA  V13.4H, V31.4H
    FRINTA  V25.8H, V15.8H
    FRINTA  V8.8H, V19.8H
    FRINTA  V12.8H, V23.8H
    FRINTA  V23.8H, V13.8H
    FRINTA  V2.8H, V16.8H
    FRINTI  V18.4H, V3.4H
    FRINTI  V13.8H, V19.8H
    FRINTI  V30.8H, V8.8H
    FRINTI  V8.4H, V2.4H
    FRINTI  V31.4H, V0.4H
    FRINTI  V2.8H, V8.8H
    FRINTI  V28.8H, V9.8H
    FRINTI  V10.4H, V25.4H
    FRINTI  V8.4H, V28.4H
    FRINTI  V5.8H, V18.8H
    FRINTM  V12.4H, V1.4H
    FRINTM  V0.8H, V13.8H
    FRINTM  V15.4H, V31.4H
    FRINTM  V19.8H, V24.8H
    FRINTM  V21.8H, V29.8H
    FRINTM  V29.4H, V30.4H
    FRINTM  V16.4H, V14.4H
    FRINTM  V29.8H, V0.8H
    FRINTM  V29.8H, V29.8H
    FRINTM  V18.4H, V0.4H
    FRINTN  V11.8H, V18.8H
    FRINTN  V13.8H, V6.8H
    FRINTN  V30.8H, V5.8H
    FRINTN  V5.8H, V20.8H
    FRINTN  V25.4H, V8.4H
    FRINTN  V3.8H, V15.8H
    FRINTN  V18.8H, V14.8H
    FRINTN  V20.4H, V11.4H
    FRINTN  V10.4H, V18.4H
    FRINTN  V21.4H, V30.4H
    FRINTP  V8.8H, V20.8H
    FRINTP  V28.4H, V13.4H
    FRINTP  V13.4H, V25.4H
    FRINTP  V20.4H, V29.4H
    FRINTP  V5.8H, V31.8H
    FRINTP  V11.4H, V27.4H
    FRINTP  V9.8H, V5.8H
    FRINTP  V6.8H, V13.8H
    FRINTP  V0.8H, V3.8H
    FRINTP  V31.8H, V11.8H
    FRINTX  V24.4H, V12.4H
    FRINTX  V18.8H, V9.8H
    FRINTX  V12.8H, V21.8H
    FRINTX  V30.8H, V31.8H
    FRINTX  V31.4H, V18.4H
    FRINTX  V18.4H, V16.4H
    FRINTX  V11.4H, V21.4H
    FRINTX  V24.8H, V30.8H
    FRINTX  V11.4H, V0.4H
    FRINTX  V13.8H, V31.8H
    FRINTZ  V29.4H, V13.4H
    FRINTZ  V16.8H, V6.8H
    FRINTZ  V19.4H, V29.4H
    FRINTZ  V0.8H, V31.8H
    FRINTZ  V6.4H, V19.4H
    FRINTZ  V3.4H, V16.4H
    FRINTZ  V19.4H, V28.4H
    FRINTZ  V31.8H, V24.8H
    FRINTZ  V23.4H, V0.4H
    FRINTZ  V25.4H, V5.4H
    MOVZ  X24, #0x31fe, LSL #0
    MOVK  X24, #0xcf84, LSL #16
    MOVK  X24, #0xba29, LSL #32
    MOVK  X24, #0xcaae, LSL #48
    SUB  X18, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0xf830, LSL #0
    MOVK  X24, #0x2613, LSL #16
    MOVK  X24, #0x36fd, LSL #32
    MOVK  X24, #0xf308, LSL #48
    SUB  X18, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0x93e3, LSL #0
    MOVK  X24, #0x8f57, LSL #16
    MOVK  X24, #0xd350, LSL #32
    MOVK  X24, #0x871d, LSL #48
    SUB  X18, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0xd238, LSL #0
    MOVK  X24, #0x26f, LSL #16
    MOVK  X24, #0xe65a, LSL #32
    MOVK  X24, #0xb14, LSL #48
    SUB  X18, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0x6bbe, LSL #0
    MOVK  X24, #0xf7f, LSL #16
    MOVK  X24, #0x456, LSL #32
    MOVK  X24, #0x5159, LSL #48
    SUB  X18, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0x811a, LSL #0
    MOVK  X24, #0x4ffe, LSL #16
    MOVK  X24, #0xc69a, LSL #32
    MOVK  X24, #0x1bfd, LSL #48
    SUB  X18, X24, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0x9983, LSL #0
    MOVK  X24, #0x7e7c, LSL #16
    MOVK  X24, #0xc1a5, LSL #32
    MOVK  X24, #0x5495, LSL #48
    SUB  X18, X24, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0x1608, LSL #0
    MOVK  X24, #0xed1b, LSL #16
    MOVK  X24, #0x35fb, LSL #32
    MOVK  X24, #0x8127, LSL #48
    SUB  X18, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0x1823, LSL #0
    MOVK  X24, #0x1b83, LSL #16
    MOVK  X24, #0x9c57, LSL #32
    MOVK  X24, #0xfaed, LSL #48
    SUB  X18, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0xbb5, LSL #0
    MOVK  X24, #0x37e4, LSL #16
    MOVK  X24, #0x972f, LSL #32
    MOVK  X24, #0xd823, LSL #48
    SUB  X18, X24, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0x117a, LSL #0
    MOVK  X24, #0x7606, LSL #16
    MOVK  X24, #0x6801, LSL #32
    MOVK  X24, #0x4e74, LSL #48
    SUB  X18, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0x3dde, LSL #0
    MOVK  X24, #0xa0db, LSL #16
    MOVK  X24, #0x8879, LSL #32
    MOVK  X24, #0x3264, LSL #48
    SUB  X18, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0x43a3, LSL #0
    MOVK  X24, #0x8b32, LSL #16
    MOVK  X24, #0xf5cd, LSL #32
    MOVK  X24, #0x1582, LSL #48
    SUB  X18, X24, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0xed91, LSL #0
    MOVK  X24, #0x5c92, LSL #16
    MOVK  X24, #0x2a88, LSL #32
    MOVK  X24, #0xbdef, LSL #48
    SUB  X18, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0xa6ca, LSL #0
    MOVK  X24, #0x58b9, LSL #16
    MOVK  X24, #0x4ee7, LSL #32
    MOVK  X24, #0x34b2, LSL #48
    SUB  X18, X24, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0x1bc, LSL #0
    MOVK  X24, #0xf395, LSL #16
    MOVK  X24, #0xae74, LSL #32
    MOVK  X24, #0xc905, LSL #48
    SUB  X18, X24, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0x9ed8, LSL #0
    MOVK  X24, #0x6fdd, LSL #16
    MOVK  X24, #0x702e, LSL #32
    MOVK  X24, #0xbd76, LSL #48
    SUB  X18, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0xddb5, LSL #0
    MOVK  X24, #0x3f41, LSL #16
    MOVK  X24, #0x5af4, LSL #32
    MOVK  X24, #0x565b, LSL #48
    SUB  X18, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0x4e71, LSL #0
    MOVK  X24, #0xb2ef, LSL #16
    MOVK  X24, #0x13fa, LSL #32
    MOVK  X24, #0xe86, LSL #48
    SUB  X18, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0x63a7, LSL #0
    MOVK  X24, #0x83d9, LSL #16
    MOVK  X24, #0x1d54, LSL #32
    MOVK  X24, #0x1992, LSL #48
    SUB  X18, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MRS  X24, FPSR
    MOVZ  X18, #0x1d, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V0.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D0
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V1.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D1
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V2.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D2
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V3.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D3
    MOVZ  X18, #0x8000, LSL #0
    MOVK  X18, #0x6fdd, LSL #16
    MOVK  X18, #0x702e, LSL #32
    MOVK  X18, #0xbc00, LSL #48
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D4
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D5
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D6
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D7
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V8.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D8
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D9
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V10.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D10
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x4000, LSL #16
    MOVK  X18, #0x4000, LSL #48
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V11.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D11
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V12.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D12
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V13.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D13
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D14
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x3f80, LSL #16
    MOVK  X18, #0x3f80, LSL #48
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D15
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V16.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D16
    MOVZ  X18, #0x8000, LSL #0
    MOVK  X18, #0x6fdd, LSL #16
    MOVK  X18, #0x702e, LSL #32
    MOVK  X18, #0xbc00, LSL #48
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X18, #0xddb5, LSL #0
    MOVK  X18, #0x3f41, LSL #16
    MOVK  X18, #0x5af4, LSL #32
    MOVK  X18, #0x565b, LSL #48
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D17
    MOVZ  X18, #0x3dde, LSL #0
    MOVK  X18, #0xa0db, LSL #16
    MOVK  X18, #0x8879, LSL #32
    MOVK  X18, #0x3264, LSL #48
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V18.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D18
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x3c00, LSL #16
    MOVK  X18, #0x3c00, LSL #48
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D19
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D20
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V21.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D21
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V22.D[1]
    MOVZ  X18, #0x31fe, LSL #0
    MOVK  X18, #0xcf84, LSL #16
    MOVK  X18, #0xba29, LSL #32
    MOVK  X18, #0xcaae, LSL #48
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D22
    MOVZ  X18, #0x81e0, LSL #0
    MOVK  X18, #0x143a, LSL #16
    MOVK  X18, #0xd14e, LSL #32
    MOVK  X18, #0x5045, LSL #48
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V23.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D23
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V24.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D24
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V25.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D25
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V26.D[1]
    MOVZ  X18, #0xe71a, LSL #0
    MOVK  X18, #0xaca5, LSL #16
    MOVK  X18, #0x4d06, LSL #32
    MOVK  X18, #0x43e2, LSL #48
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D26
    MOVZ  X18, #0x63a7, LSL #0
    MOVK  X18, #0x83d9, LSL #16
    MOVK  X18, #0x1d54, LSL #32
    MOVK  X18, #0x1992, LSL #48
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D27
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V28.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D28
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V29.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D29
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V30.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D30
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V31.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D31
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X2, #0x9b3d, LSL #0
    MOVK  X2, #0xd0cb, LSL #16
    MOVK  X2, #0x1eb7, LSL #32
    MOVK  X2, #0xf921, LSL #48
    MOVZ  X3, #0x3329, LSL #0
    MOVK  X3, #0x858c, LSL #16
    MOVK  X3, #0x6263, LSL #32
    MOVK  X3, #0xa057, LSL #48
    MOVZ  X4, #0xd2f5, LSL #0
    MOVK  X4, #0x41c9, LSL #16
    MOVK  X4, #0xa480, LSL #32
    MOVK  X4, #0xb544, LSL #48
    MOVZ  X5, #0xb080, LSL #0
    MOVK  X5, #0x581, LSL #16
    MOVK  X5, #0x445e, LSL #32
    MOVK  X5, #0x77c0, LSL #48
    MOVZ  X6, #0xc42, LSL #0
    MOVK  X6, #0x786a, LSL #16
    MOVK  X6, #0x9aea, LSL #32
    MOVK  X6, #0x23f2, LSL #48
    MOVZ  X7, #0x59d2, LSL #0
    MOVK  X7, #0x6c74, LSL #16
    MOVK  X7, #0x697, LSL #32
    MOVK  X7, #0x155e, LSL #48
    MOVZ  X11, #0x271c, LSL #0
    MOVK  X11, #0xa175, LSL #16
    MOVK  X11, #0xf172, LSL #32
    MOVK  X11, #0xb30d, LSL #48
    MOVZ  X12, #0xf85a, LSL #0
    MOVK  X12, #0x3c4e, LSL #16
    MOVK  X12, #0x2acb, LSL #32
    MOVK  X12, #0xdeb0, LSL #48
    MOVZ  X13, #0xecbc, LSL #0
    MOVK  X13, #0x6d2a, LSL #16
    MOVK  X13, #0x3ec2, LSL #32
    MOVK  X13, #0xf446, LSL #48
    MOVZ  X16, #0x67a6, LSL #0
    MOVK  X16, #0x4cfe, LSL #16
    MOVK  X16, #0x419a, LSL #32
    MOVK  X16, #0xac18, LSL #48
    MOVZ  X17, #0x9b1a, LSL #0
    MOVK  X17, #0x4629, LSL #16
    MOVK  X17, #0x3bd7, LSL #32
    MOVK  X17, #0xb068, LSL #48
    MOVZ  X18, #0xaa69, LSL #0
    MOVK  X18, #0x5206, LSL #16
    MOVK  X18, #0x4084, LSL #32
    MOVK  X18, #0x532a, LSL #48
    MOVZ  X19, #0x6d3e, LSL #0
    MOVK  X19, #0x3e6a, LSL #16
    MOVK  X19, #0x5409, LSL #32
    MOVK  X19, #0x8387, LSL #48
    MOVZ  X20, #0x2a81, LSL #0
    MOVK  X20, #0x53c0, LSL #16
    MOVK  X20, #0xbc55, LSL #32
    MOVK  X20, #0x4030, LSL #48
    MOVZ  X21, #0xc2bc, LSL #0
    MOVK  X21, #0x56c8, LSL #16
    MOVK  X21, #0x104b, LSL #32
    MOVK  X21, #0x2c11, LSL #48
    MOVZ  X22, #0x8741, LSL #0
    MOVK  X22, #0xb3c0, LSL #16
    MOVK  X22, #0x1db0, LSL #32
    MOVK  X22, #0xdc7b, LSL #48
    MOVZ  X23, #0x88e6, LSL #0
    MOVK  X23, #0xd1ab, LSL #16
    MOVK  X23, #0x6470, LSL #32
    MOVK  X23, #0x610d, LSL #48
    MOVZ  X24, #0x82aa, LSL #0
    MOVK  X24, #0xe696, LSL #16
    MOVK  X24, #0xef20, LSL #32
    MOVK  X24, #0xcf72, LSL #48
    MOVZ  X25, #0xe903, LSL #0
    MOVK  X25, #0x2683, LSL #16
    MOVK  X25, #0x8c79, LSL #32
    MOVK  X25, #0x19a8, LSL #48
    MOVZ  X26, #0xddca, LSL #0
    MOVK  X26, #0x7802, LSL #16
    MOVK  X26, #0x3f54, LSL #32
    MOVK  X26, #0xd4d5, LSL #48
    MOVZ  X27, #0x3d80, LSL #0
    MOVK  X27, #0xd799, LSL #16
    MOVK  X27, #0x594b, LSL #32
    MOVK  X27, #0x7877, LSL #48
    MOVZ  X28, #0xe0f6, LSL #0
    MOVK  X28, #0xf6ca, LSL #16
    MOVK  X28, #0x22e8, LSL #32
    MOVK  X28, #0x77de, LSL #48
    MOVZ  X29, #0x2ffc, LSL #0
    MOVK  X29, #0xd0f3, LSL #16
    MOVK  X29, #0x2a6f, LSL #32
    MOVK  X29, #0x365c, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X28
    FMOV  D1, X29
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X19
    FMOV  D3, X24
    FMOV  V3.D[1], X29
    FMOV  D4, X23
    FMOV  V4.D[1], X5
    FMOV  D5, X3
    FMOV  V5.D[1], X25
    FMOV  D6, X6
    FMOV  V6.D[1], X19
    FMOV  D7, X24
    FMOV  V7.D[1], X12
    FMOV  D8, X21
    FMOV  V8.D[1], X26
    FMOV  D9, X29
    FMOV  V9.D[1], X22
    FMOV  D10, X11
    FMOV  V10.D[1], X11
    FMOV  D11, X29
    FMOV  V11.D[1], X12
    FMOV  D12, X11
    FMOV  V12.D[1], X26
    FMOV  D13, X27
    FMOV  V13.D[1], X20
    FMOV  D14, X5
    FMOV  V14.D[1], X20
    FMOV  D15, X3
    FMOV  V15.D[1], X16
    FMOV  D16, X7
    FMOV  V16.D[1], X24
    FMOV  D17, X5
    FMOV  V17.D[1], X20
    FMOV  D18, X19
    FMOV  V18.D[1], X24
    FMOV  D19, X28
    FMOV  V19.D[1], X13
    FMOV  D20, X6
    FMOV  V20.D[1], X18
    FMOV  D21, X19
    FMOV  V21.D[1], X11
    FMOV  D22, X21
    FMOV  V22.D[1], X24
    FMOV  D23, X7
    FMOV  V23.D[1], X19
    FMOV  D24, X27
    FMOV  V24.D[1], X19
    FMOV  D25, X12
    FMOV  V25.D[1], X26
    FMOV  D26, X4
    FMOV  V26.D[1], X17
    FMOV  D27, X28
    FMOV  V27.D[1], X6
    FMOV  D28, X23
    FMOV  V28.D[1], X17
    FMOV  D29, X12
    FMOV  V29.D[1], X6
    FMOV  D30, X12
    FMOV  V30.D[1], X21
    FMOV  D31, X21
    FMOV  V31.D[1], X22
    MOVZ  X26, #0xa, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_0:
    FCVTAU  V0.4H, V14.4H
    FRINTI  V11.2D, V28.2D
    FRINTM  V16.4S, V30.4S
    FCVTZU  V24.8H, V0.8H
    FCVTNU  V6.4S, V26.4S
    FCVTPS  V7.4S, V6.4S
    FCVTNS  V13.4S, V16.4S
    FCVTAU  V14.4S, V24.4S
    FCVTPU  V24.8H, V11.8H
    FCVTPS  V2.8H, V14.8H
    FRINTZ  V23.2S, V7.2S
    FCVTAS  V27.8H, V29.8H
    FRINTI  V23.4H, V3.4H
    FCVTZS  V3.2S, V13.2S, #32
    FCVTPU  V7.4H, V10.4H
    FCVTZS  V0.2S, V14.2S
    FRINTN  V3.4S, V7.4S
    FCVTN2  V5.8H, V5.4S
    FCVTXN  V25.2S, V2.2D
    FRINTP  V9.8H, V0.8H
    FCVTZU V0.2D, V18.2D, #52
    FRINTZ  V31.2S, V25.2S
    FCVTXN2  V16.4S, V23.2D
    FCVTPS  V7.8H, V27.8H
    FCVTNS  V25.4S, V5.4S
    FRINTX  V2.2D, V12.2D
    FCVTZU  V10.2S, V3.2S, #20
    FRINTA  V14.8H, V8.8H
    FCVTN  V5.4H, V31.4S
    FCVTPS  V13.2S, V0.2S
    FCVTL  V28.2D, V10.2S
    FCVTZS  V3.4H, V18.4H
    FRINTZ  V31.8H, V3.8H
    FCVTZS V3.2D, V28.2D, #16
    FRINTA  V27.2D, V2.2D
    FCVTL  V29.4S, V16.4H
    FRINTZ  V1.2S, V29.2S
    FRINTN  V1.4H, V5.4H
    FCVTXN  V29.2S, V27.2D
    FRINTM  V24.4S, V29.4S
    FCVTPU  V13.8H, V13.8H
    FCVTL2  V29.2D, V9.4S
    FCVTNS  V30.4S, V13.4S
    FCVTAU  V8.2S, V3.2S
    FCVTMS  V27.8H, V30.8H
    FCVTMS  V12.8H, V29.8H
    FRINTM  V9.2S, V24.2S
    FRINTZ  V30.4S, V9.4S
    FCVTL  V0.4S, V4.4H
    FCVTAS  V0.4H, V21.4H
    FCVTZS  V28.4S, V8.4S
    FCVTAU  V21.2D, V12.2D
    FCVTMS  V27.4S, V7.4S
    FCVTAS  V12.4S, V1.4S
    FCVTL2  V8.2D, V0.4S
    FRINTP  V9.2D, V22.2D
    FRINTM  V17.2S, V19.2S
    FRINTX  V29.2S, V20.2S
    FRINTP  V7.8H, V29.8H
    FCVTZS V3.2D, V21.2D, #31
    FCVTMU  V22.2D, V7.2D
    FCVTZS V1.2D, V14.2D, #39
    FCVTPS  V4.4H, V8.4H
    FRINTN  V8.2S, V22.2S
    FCVTZU  V7.4H, V27.4H
    FRINTN  V2.8H, V20.8H
    FRINTA  V2.4S, V3.4S
    FRINTZ  V27.8H, V9.8H
    FRINTX  V22.8H, V28.8H
    FCVTXN2  V19.4S, V7.2D
    FCVTZU V3.2D, V4.2D, #29
    FRINTP  V29.8H, V1.8H
    FCVTN2  V20.4S, V27.2D
    FCVTNS  V21.4H, V19.4H
    FCVTL2  V24.4S, V8.8H
    FCVTN  V19.4H, V3.4S
    FCVTMU  V3.4S, V22.4S
    FCVTMU  V19.2S, V13.2S
    FCVTPU  V1.2S, V21.2S
    FRINTN  V11.4H, V20.4H
    FRINTP  V30.2D, V6.2D
    FCVTPU  V0.2S, V9.2S
    FCVTMU  V4.8H, V8.8H
    FCVTL2  V8.4S, V30.8H
    FCVTPU  V2.4S, V8.4S
    FCVTAS  V8.8H, V8.8H
    FRINTM  V28.2D, V0.2D
    FCVTAU  V22.8H, V8.8H
    FCVTZU  V30.8H, V19.8H, #2
    FCVTAS  V0.4H, V12.4H
    FRINTP  V7.8H, V28.8H
    FCVTNU  V8.8H, V29.8H
    FCVTXN2  V6.4S, V4.2D
    FRINTZ  V23.4S, V2.4S
    FRINTA  V0.4H, V11.4H
    FCVTZU  V11.2D, V25.2D
    FCVTZS V25.2D, V30.2D, #26
    FCVTAU  V21.2D, V0.2D
    FCVTPU  V9.2D, V8.2D
    FCVTZS V2.2D, V6.2D, #36
    FCVTZS  V20.4H, V31.4H
    FCVTAS  V19.4H, V11.4H
    FCVTAS  V31.8H, V6.8H
    FCVTAU  V13.4S, V9.4S
    FCVTZU  V0.8H, V20.8H
    FCVTMU  V30.2D, V3.2D
    FCVTXN  V11.2S, V26.2D
    FRINTZ  V8.8H, V25.8H
    FCVTZS V26.2D, V6.2D, #4
    FCVTZS  V20.8H, V30.8H, #4
    FCVTN  V6.2S, V22.2D
    FCVTXN  V9.2S, V31.2D
    FCVTZU  V3.2D, V0.2D
    FRINTM  V0.8H, V13.8H
    FCVTNU  V24.4S, V11.4S
    FCVTZU  V31.2S, V2.2S
    FRINTI  V11.8H, V26.8H
    FCVTZS  V29.8H, V0.8H
    FCVTZS  V13.2S, V6.2S, #8
    FCVTNS  V17.2D, V23.2D
    FCVTL2  V17.4S, V24.8H
    FCVTL2  V25.4S, V19.8H
    FCVTZS V22.2D, V9.2D, #56
    FRINTM  V2.4H, V20.4H
    FRINTA  V6.4S, V2.4S
    FCVTMS  V2.4H, V29.4H
    FCVTNU  V29.4H, V3.4H
    FCVTZU  V29.2S, V13.2S
    FCVTMU  V0.8H, V25.8H
    FRINTZ  V24.4H, V11.4H
    FRINTA  V5.4H, V0.4H
    FCVTZS  V30.2D, V6.2D
    FCVTPS  V9.4H, V22.4H
    FCVTMU  V0.4H, V9.4H
    FCVTMS  V14.2D, V17.2D
    FCVTZU  V20.2S, V21.2S
    FCVTXN  V24.2S, V14.2D
    FCVTMS  V21.4H, V13.4H
    FCVTXN2  V22.4S, V22.2D
    FCVTN2  V23.8H, V21.4S
    FCVTPS  V25.4H, V20.4H
    FCVTNU  V17.4S, V29.4S
    FCVTL  V3.4S, V0.4H
    FRINTN  V21.4S, V17.4S
    FCVTAS  V20.4H, V21.4H
    FRINTA  V13.2D, V5.2D
    FCVTNU  V6.2S, V30.2S
    FCVTNS  V17.8H, V6.8H
    FCVTL2  V29.2D, V22.4S
    FCVTZU  V21.2S, V23.2S
    FCVTZU  V28.2S, V17.2S
    FRINTA  V11.2S, V8.2S
    FRINTI  V22.2S, V13.2S
    FCVTZS V0.2D, V4.2D, #11
    FCVTAS  V6.8H, V25.8H
    FRINTA  V26.4H, V14.4H
    FCVTMS  V23.2S, V20.2S
    FCVTMS  V27.8H, V22.8H
    FCVTPS  V13.4H, V7.4H
    FCVTNS  V30.2D, V2.2D
    FCVTAS  V2.4S, V27.4S
    FCVTAU  V8.2S, V13.2S
    FCVTZS  V9.4S, V2.4S, #19
    FCVTZS  V2.2S, V2.2S, #18
    FRINTP  V27.8H, V9.8H
    FCVTZS  V5.8H, V24.8H
    FCVTN2  V14.4S, V8.2D
    FRINTN  V16.4S, V11.4S
    FCVTMU  V11.8H, V26.8H
    FCVTZS  V13.4S, V11.4S, #11
    FCVTNU  V16.2D, V30.2D
    FCVTZS  V20.2S, V23.2S
    FRINTI  V23.4H, V5.4H
    FCVTMU  V26.2S, V23.2S
    FRINTX  V8.4S, V2.4S
    FRINTM  V11.4H, V16.4H
    FRINTZ  V12.4S, V0.4S
    FCVTAS  V20.2D, V25.2D
    FCVTNS  V0.8H, V13.8H
    FCVTL2  V13.2D, V31.4S
    FCVTNU  V5.2S, V27.2S
    FCVTMU  V2.2D, V11.2D
    FCVTXN  V30.2S, V2.2D
    FRINTX  V24.4H, V8.4H
    FRINTN  V7.4S, V30.4S
    FCVTZS  V15.2S, V7.2S, #21
    FRINTM  V31.4H, V14.4H
    FCVTMS  V7.4H, V0.4H
    FCVTZS  V0.2S, V16.2S
    FCVTL  V19.4S, V12.4H
    FCVTMS  V23.4H, V15.4H
    FCVTMS  V15.8H, V1.8H
    FCVTMS  V9.4H, V24.4H
    FRINTI  V24.2S, V7.2S
    FCVTMU  V1.2D, V9.2D
    FCVTN  V3.2S, V31.2D
    FRINTI  V14.4S, V19.4S
    FCVTAS  V2.8H, V3.8H
    FCVTZS  V25.8H, V17.8H
    FCVTAU  V16.2S, V6.2S
    SUBS  X26, X26, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_0
    MOVZ  X18, #0x9b3d, LSL #0
    MOVK  X18, #0xd0cb, LSL #16
    MOVK  X18, #0x1eb7, LSL #32
    MOVK  X18, #0xf921, LSL #48
    SUB  X3, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X18, #0xd2f5, LSL #0
    MOVK  X18, #0x41c9, LSL #16
    MOVK  X18, #0xa480, LSL #32
    MOVK  X18, #0xb544, LSL #48
    SUB  X3, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X18, #0xb080, LSL #0
    MOVK  X18, #0x581, LSL #16
    MOVK  X18, #0x445e, LSL #32
    MOVK  X18, #0x77c0, LSL #48
    SUB  X3, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X18, #0x59d2, LSL #0
    MOVK  X18, #0x6c74, LSL #16
    MOVK  X18, #0x697, LSL #32
    MOVK  X18, #0x155e, LSL #48
    SUB  X3, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X18, #0x271c, LSL #0
    MOVK  X18, #0xa175, LSL #16
    MOVK  X18, #0xf172, LSL #32
    MOVK  X18, #0xb30d, LSL #48
    SUB  X3, X18, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X18, #0xf85a, LSL #0
    MOVK  X18, #0x3c4e, LSL #16
    MOVK  X18, #0x2acb, LSL #32
    MOVK  X18, #0xdeb0, LSL #48
    SUB  X3, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X18, #0xecbc, LSL #0
    MOVK  X18, #0x6d2a, LSL #16
    MOVK  X18, #0x3ec2, LSL #32
    MOVK  X18, #0xf446, LSL #48
    SUB  X3, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X18, #0x67a6, LSL #0
    MOVK  X18, #0x4cfe, LSL #16
    MOVK  X18, #0x419a, LSL #32
    MOVK  X18, #0xac18, LSL #48
    SUB  X3, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X18, #0x9b1a, LSL #0
    MOVK  X18, #0x4629, LSL #16
    MOVK  X18, #0x3bd7, LSL #32
    MOVK  X18, #0xb068, LSL #48
    SUB  X3, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X18, #0x6d3e, LSL #0
    MOVK  X18, #0x3e6a, LSL #16
    MOVK  X18, #0x5409, LSL #32
    MOVK  X18, #0x8387, LSL #48
    SUB  X3, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X18, #0x2a81, LSL #0
    MOVK  X18, #0x53c0, LSL #16
    MOVK  X18, #0xbc55, LSL #32
    MOVK  X18, #0x4030, LSL #48
    SUB  X3, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X18, #0xc2bc, LSL #0
    MOVK  X18, #0x56c8, LSL #16
    MOVK  X18, #0x104b, LSL #32
    MOVK  X18, #0x2c11, LSL #48
    SUB  X3, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X18, #0x8741, LSL #0
    MOVK  X18, #0xb3c0, LSL #16
    MOVK  X18, #0x1db0, LSL #32
    MOVK  X18, #0xdc7b, LSL #48
    SUB  X3, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X18, #0x88e6, LSL #0
    MOVK  X18, #0xd1ab, LSL #16
    MOVK  X18, #0x6470, LSL #32
    MOVK  X18, #0x610d, LSL #48
    SUB  X3, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X18, #0x82aa, LSL #0
    MOVK  X18, #0xe696, LSL #16
    MOVK  X18, #0xef20, LSL #32
    MOVK  X18, #0xcf72, LSL #48
    SUB  X3, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X18, #0xe903, LSL #0
    MOVK  X18, #0x2683, LSL #16
    MOVK  X18, #0x8c79, LSL #32
    MOVK  X18, #0x19a8, LSL #48
    SUB  X3, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X3, X18, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X18, #0x3d80, LSL #0
    MOVK  X18, #0xd799, LSL #16
    MOVK  X18, #0x594b, LSL #32
    MOVK  X18, #0x7877, LSL #48
    SUB  X3, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X18, #0xe0f6, LSL #0
    MOVK  X18, #0xf6ca, LSL #16
    MOVK  X18, #0x22e8, LSL #32
    MOVK  X18, #0x77de, LSL #48
    SUB  X3, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X18, #0x2ffc, LSL #0
    MOVK  X18, #0xd0f3, LSL #16
    MOVK  X18, #0x2a6f, LSL #32
    MOVK  X18, #0x365c, LSL #48
    SUB  X3, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MRS  X18, FPSR
    MOVZ  X3, #0x1d, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V0.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D0
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V1.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D1
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D2
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V3.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D3
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D4
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V5.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D5
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V6.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D6
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V7.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D7
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V8.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D8
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V9.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D9
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D10
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V11.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D11
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D12
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V13.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D13
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V14.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D14
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V15.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D15
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D16
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V17.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D17
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V18.D[1]
    MOVZ  X3, #0x82aa, LSL #0
    MOVK  X3, #0xe696, LSL #16
    MOVK  X3, #0xef20, LSL #32
    MOVK  X3, #0xcf72, LSL #48
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D18
    MOVZ  X3, #0x6d3e, LSL #0
    MOVK  X3, #0x3e6a, LSL #16
    MOVK  X3, #0x5409, LSL #32
    MOVK  X3, #0x8387, LSL #48
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V19.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D19
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V20.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D20
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V21.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D21
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V22.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D22
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D23
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V24.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D24
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V25.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D25
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V26.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D26
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V27.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D27
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D28
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D29
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V30.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D30
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, V31.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X18, D31
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
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
    FMOV  D0, X11
    FMOV  V0.D[1], X21
    FMOV  D1, X28
    FMOV  V1.D[1], X20
    FMOV  D2, X16
    FMOV  V2.D[1], X17
    FMOV  D3, X27
    FMOV  V3.D[1], X23
    FMOV  D4, X29
    FMOV  V4.D[1], X22
    FMOV  D5, X7
    FMOV  V5.D[1], X26
    FMOV  D6, X24
    FMOV  V6.D[1], X25
    FMOV  D7, X16
    FMOV  V7.D[1], X16
    FMOV  D8, X17
    FMOV  V8.D[1], X4
    FMOV  D9, X29
    FMOV  V9.D[1], X22
    FMOV  D10, X29
    FMOV  V10.D[1], X19
    FMOV  D11, X21
    FMOV  V11.D[1], X19
    FMOV  D12, X17
    FMOV  V12.D[1], X21
    FMOV  D13, X27
    FMOV  V13.D[1], X20
    FMOV  D14, X16
    FMOV  V14.D[1], X22
    FMOV  D15, X2
    FMOV  V15.D[1], X22
    FMOV  D16, X27
    FMOV  V16.D[1], X11
    FMOV  D17, X28
    FMOV  V17.D[1], X18
    FMOV  D18, X4
    FMOV  V18.D[1], X16
    FMOV  D19, X25
    FMOV  V19.D[1], X13
    FMOV  D20, X7
    FMOV  V20.D[1], X21
    FMOV  D21, X17
    FMOV  V21.D[1], X25
    FMOV  D22, X22
    FMOV  V22.D[1], X19
    FMOV  D23, X21
    FMOV  V23.D[1], X26
    FMOV  D24, X20
    FMOV  V24.D[1], X27
    FMOV  D25, X22
    FMOV  V25.D[1], X12
    FMOV  D26, X16
    FMOV  V26.D[1], X2
    FMOV  D27, X3
    FMOV  V27.D[1], X13
    FMOV  D28, X17
    FMOV  V28.D[1], X26
    FMOV  D29, X7
    FMOV  V29.D[1], X11
    FMOV  D30, X24
    FMOV  V30.D[1], X4
    FMOV  D31, X16
    FMOV  V31.D[1], X3
    MOVZ  X29, #0xa, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_1:
    FRINTI  V19.4H, V30.4H
    FCVTPS  V26.2D, V24.2D
    FRINTI  V21.2D, V31.2D
    FCVTL2  V25.2D, V26.4S
    FCVTNU  V20.2S, V19.2S
    FCVTPU  V0.2S, V29.2S
    FCVTAU  V8.4H, V27.4H
    FCVTN2  V22.8H, V25.4S
    FCVTXN  V2.2S, V1.2D
    FCVTNS  V2.2D, V28.2D
    FCVTL2  V7.2D, V18.4S
    FCVTAU  V23.2D, V23.2D
    FCVTZS V23.2D, V1.2D, #56
    FCVTMU  V2.8H, V20.8H
    FCVTZU  V26.8H, V15.8H
    FCVTXN  V28.2S, V3.2D
    FCVTL2  V4.2D, V22.4S
    FCVTNS  V28.8H, V26.8H
    FRINTZ  V22.2D, V8.2D
    FCVTNU  V3.8H, V12.8H
    FRINTA  V19.2S, V0.2S
    FRINTZ  V31.8H, V22.8H
    FCVTPU  V12.8H, V3.8H
    FCVTNU  V22.2D, V31.2D
    FRINTI  V0.4H, V12.4H
    FCVTXN  V12.2S, V22.2D
    FCVTL  V8.4S, V6.4H
    FCVTZU  V3.4S, V4.4S
    FCVTAU  V6.4H, V12.4H
    FCVTZU  V26.2S, V8.2S, #18
    FRINTI  V15.4H, V7.4H
    FCVTPU  V1.2D, V26.2D
    FRINTX  V7.8H, V3.8H
    FCVTNU  V20.4H, V23.4H
    FCVTMS  V3.4H, V19.4H
    FCVTXN  V31.2S, V20.2D
    FCVTN2  V31.4S, V7.2D
    FRINTI  V30.8H, V2.8H
    FCVTAU  V8.4H, V28.4H
    FCVTL  V22.4S, V15.4H
    FCVTMS  V3.2S, V23.2S
    FRINTN  V28.2S, V30.2S
    FCVTMS  V20.4H, V0.4H
    FCVTL  V7.4S, V1.4H
    FRINTN  V22.8H, V20.8H
    FCVTZS  V16.4S, V31.4S, #9
    FRINTZ  V1.4S, V7.4S
    FRINTA  V0.4S, V12.4S
    FRINTZ  V7.8H, V16.8H
    FCVTZU  V7.8H, V18.8H
    FCVTNU  V31.2S, V22.2S
    FCVTZU  V15.8H, V31.8H, #9
    FCVTZU  V28.2S, V7.2S
    FRINTI  V2.8H, V15.8H
    FCVTL  V20.4S, V3.4H
    FCVTAU  V15.4H, V6.4H
    FRINTN  V8.4S, V2.4S
    FCVTZU V30.2D, V16.2D, #51
    FRINTM  V19.8H, V30.8H
    FCVTZS  V22.8H, V15.8H, #7
    FRINTI  V15.4S, V20.4S
    FCVTMU  V12.2D, V28.2D
    FCVTZU  V7.4S, V16.4S, #12
    FCVTN2  V24.8H, V8.4S
    FCVTZU  V30.4H, V7.4H
    FRINTA  V9.8H, V1.8H
    FCVTMU  V2.4H, V3.4H
    FRINTN  V28.4S, V2.4S
    FCVTZS  V1.4H, V30.4H, #1
    FCVTZS  V3.8H, V0.8H, #16
    FCVTAU  V20.4S, V1.4S
    FRINTX  V0.2D, V15.2D
    FCVTPS  V25.2S, V23.2S
    FCVTZS  V6.4S, V0.4S, #6
    FCVTZS  V0.2S, V25.2S, #20
    FCVTZS  V7.2S, V3.2S
    FCVTMS  V23.8H, V22.8H
    FRINTX  V17.4S, V12.4S
    FRINTP  V8.4S, V17.4S
    FCVTZS  V27.4S, V21.4S
    FRINTM  V30.4H, V0.4H
    FCVTPU  V17.4S, V2.4S
    FCVTNS  V25.2D, V30.2D
    FRINTA  V1.4S, V7.4S
    FCVTPS  V22.8H, V12.8H
    FRINTA  V13.2D, V24.2D
    FCVTZS V24.2D, V8.2D, #42
    FRINTN  V30.8H, V17.8H
    FCVTZS V8.2D, V27.2D, #38
    FCVTMU  V6.2S, V17.2S
    FRINTN  V3.4H, V23.4H
    FCVTPS  V24.8H, V22.8H
    FCVTNU  V27.4H, V19.4H
    FCVTAS  V2.8H, V1.8H
    FRINTZ  V29.2D, V30.2D
    FCVTPU  V0.2D, V2.2D
    FCVTN2  V2.8H, V20.4S
    FCVTZS  V19.2D, V3.2D
    FRINTP  V30.8H, V8.8H
    FCVTZU  V18.8H, V6.8H, #4
    FCVTZS V17.2D, V19.2D, #8
    FRINTM  V12.2S, V17.2S
    FCVTPU  V17.4S, V24.4S
    FCVTL  V26.2D, V30.2S
    FRINTI  V30.8H, V17.8H
    FRINTA  V17.2D, V9.2D
    FCVTXN2  V19.4S, V13.2D
    FRINTA  V20.4H, V9.4H
    FCVTL2  V7.4S, V0.8H
    FCVTL  V19.2D, V20.2S
    FCVTNU  V3.2S, V2.2S
    FCVTPU  V23.2D, V28.2D
    FCVTAU  V17.2S, V27.2S
    FCVTPU  V2.8H, V0.8H
    FCVTZS  V19.4H, V17.4H, #12
    FRINTN  V8.8H, V28.8H
    FCVTNS  V17.8H, V22.8H
    FCVTAS  V0.4H, V3.4H
    FRINTX  V6.8H, V30.8H
    FRINTA  V13.4H, V29.4H
    FRINTI  V27.4H, V2.4H
    FCVTZU V20.2D, V19.2D, #58
    FCVTNU  V24.4H, V16.4H
    FCVTAS  V9.4H, V20.4H
    FCVTNU  V20.2D, V6.2D
    FCVTXN  V12.2S, V23.2D
    FCVTPS  V2.8H, V12.8H
    FCVTZS  V12.4S, V24.4S
    FCVTZU  V24.4H, V7.4H, #2
    FCVTMS  V6.4H, V26.4H
    FCVTPU  V8.8H, V10.8H
    FCVTNU  V16.4S, V13.4S
    FCVTXN2  V29.4S, V24.2D
    FCVTN  V28.4H, V6.4S
    FRINTP  V7.4S, V2.4S
    FCVTPU  V3.8H, V7.8H
    FRINTP  V24.2D, V14.2D
    FCVTZU V10.2D, V29.2D, #1
    FCVTAU  V3.4H, V31.4H
    FRINTI  V30.2D, V28.2D
    FCVTXN  V31.2S, V30.2D
    FCVTNU  V2.4S, V10.4S
    FRINTP  V30.4S, V24.4S
    FCVTXN2  V28.4S, V2.2D
    FRINTA  V14.4H, V21.4H
    FCVTZU  V12.8H, V14.8H, #11
    FCVTNU  V29.2S, V30.2S
    FCVTPS  V23.4S, V20.4S
    FRINTI  V16.8H, V28.8H
    FRINTZ  V1.2D, V10.2D
    FCVTXN  V5.2S, V29.2D
    FCVTAS  V10.4H, V20.4H
    FCVTZS  V24.4H, V21.4H, #10
    FRINTP  V20.8H, V2.8H
    FCVTZS  V14.8H, V24.8H
    FCVTMS  V10.4H, V20.4H
    FCVTZS  V24.4H, V14.4H, #4
    FCVTAU  V2.4S, V5.4S
    FCVTXN2  V21.4S, V8.2D
    FCVTZU V10.2D, V1.2D, #5
    FRINTN  V7.4S, V28.4S
    FCVTNS  V8.4S, V2.4S
    FCVTN  V2.4H, V20.4S
    FRINTP  V30.8H, V8.8H
    FCVTZU  V17.2D, V10.2D
    FCVTPS  V20.2S, V31.2S
    FCVTNS  V16.4H, V16.4H
    FRINTZ  V26.8H, V30.8H
    FCVTPS  V29.4H, V26.4H
    FCVTZU V8.2D, V22.2D, #64
    FCVTNS  V25.8H, V29.8H
    FCVTN  V14.4H, V25.4S
    FRINTX  V5.4H, V8.4H
    FCVTL  V20.2D, V21.2S
    FCVTPU  V8.4H, V26.4H
    FCVTXN2  V25.4S, V14.2D
    FCVTMS  V26.2D, V24.2D
    FCVTL  V30.4S, V7.4H
    FCVTNU  V28.8H, V20.8H
    FCVTMS  V20.4H, V6.4H
    FCVTZU  V24.2S, V20.2S
    FCVTMS  V21.4H, V28.4H
    FCVTZU V6.2D, V28.2D, #54
    FRINTP  V11.2D, V30.2D
    FCVTMS  V31.8H, V24.8H
    FCVTMU  V19.2D, V5.2D
    FRINTP  V29.4S, V19.4S
    FRINTX  V28.4S, V31.4S
    FCVTZS V28.2D, V29.2D, #52
    FRINTX  V20.8H, V25.8H
    FCVTN  V21.4H, V8.4S
    FCVTL  V7.4S, V12.4H
    FRINTA  V24.4H, V21.4H
    FCVTL  V8.2D, V27.2S
    FRINTM  V2.8H, V11.8H
    FRINTI  V5.4H, V2.4H
    FCVTZU V11.2D, V7.2D, #57
    FCVTN2  V28.4S, V24.2D
    FRINTX  V27.2D, V6.2D
    FRINTA  V19.8H, V5.8H
    SUBS  X29, X29, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_1
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MRS  X20, FPSR
    MOVZ  X26, #0x1d, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V0.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D0
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V1.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D1
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D2
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D3
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D4
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D5
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D6
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D7
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D8
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D9
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D10
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D11
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D12
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D13
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D14
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D15
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D16
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D17
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D18
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D19
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V20.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D20
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D21
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D22
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D23
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D24
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D25
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D26
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D27
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D28
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D29
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V30.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D30
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, V31.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X20, D31
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
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
    FMOV  V0.D[1], X29
    FMOV  D1, X18
    FMOV  V1.D[1], X5
    FMOV  D2, X28
    FMOV  V2.D[1], X21
    FMOV  D3, X18
    FMOV  V3.D[1], X27
    FMOV  D4, X24
    FMOV  V4.D[1], X21
    FMOV  D5, X24
    FMOV  V5.D[1], X21
    FMOV  D6, X29
    FMOV  V6.D[1], X13
    FMOV  D7, X25
    FMOV  V7.D[1], X11
    FMOV  D8, X28
    FMOV  V8.D[1], X7
    FMOV  D9, X18
    FMOV  V9.D[1], X5
    FMOV  D10, X7
    FMOV  V10.D[1], X2
    FMOV  D11, X29
    FMOV  V11.D[1], X20
    FMOV  D12, X25
    FMOV  V12.D[1], X3
    FMOV  D13, X20
    FMOV  V13.D[1], X22
    FMOV  D14, X26
    FMOV  V14.D[1], X27
    FMOV  D15, X29
    FMOV  V15.D[1], X7
    FMOV  D16, X21
    FMOV  V16.D[1], X23
    FMOV  D17, X16
    FMOV  V17.D[1], X7
    FMOV  D18, X17
    FMOV  V18.D[1], X4
    FMOV  D19, X2
    FMOV  V19.D[1], X29
    FMOV  D20, X16
    FMOV  V20.D[1], X25
    FMOV  D21, X18
    FMOV  V21.D[1], X16
    FMOV  D22, X28
    FMOV  V22.D[1], X6
    FMOV  D23, X11
    FMOV  V23.D[1], X20
    FMOV  D24, X16
    FMOV  V24.D[1], X17
    FMOV  D25, X23
    FMOV  V25.D[1], X25
    FMOV  D26, X5
    FMOV  V26.D[1], X12
    FMOV  D27, X26
    FMOV  V27.D[1], X28
    FMOV  D28, X16
    FMOV  V28.D[1], X29
    FMOV  D29, X23
    FMOV  V29.D[1], X6
    FMOV  D30, X29
    FMOV  V30.D[1], X19
    FMOV  D31, X16
    FMOV  V31.D[1], X22
    MOVZ  X20, #0xa, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_2:
    FCVTL  V0.4S, V26.4H
    FCVTAU  V29.8H, V1.8H
    FCVTZU  V5.8H, V29.8H, #5
    FCVTMS  V21.8H, V8.8H
    FCVTL2  V2.4S, V0.8H
    FRINTZ  V31.8H, V13.8H
    FCVTMU  V0.4H, V11.4H
    FCVTZU  V16.4H, V23.4H, #1
    FRINTP  V15.4H, V24.4H
    FCVTXN  V30.2S, V15.2D
    FCVTPS  V25.4S, V2.4S
    FCVTNU  V20.8H, V21.8H
    FCVTZU V9.2D, V20.2D, #57
    FCVTPS  V7.4H, V5.4H
    FCVTN2  V19.4S, V30.2D
    FRINTP  V1.4H, V10.4H
    FCVTMU  V15.4S, V20.4S
    FRINTX  V10.2S, V21.2S
    FCVTMS  V2.8H, V10.8H
    FCVTZU  V20.4H, V1.4H
    FCVTNS  V26.4H, V3.4H
    FRINTM  V5.4H, V0.4H
    FCVTZS  V31.4H, V20.4H, #14
    FCVTAU  V3.4S, V26.4S
    FRINTX  V13.4S, V31.4S
    FCVTN  V30.4H, V16.4S
    FCVTAS  V23.4S, V3.4S
    FRINTX  V16.4S, V7.4S
    FRINTX  V31.4S, V5.4S
    FCVTZU  V5.4S, V31.4S, #9
    FCVTZU  V0.2S, V12.2S
    FCVTAS  V10.4S, V15.4S
    FCVTXN2  V13.4S, V5.2D
    FCVTZU V5.2D, V0.2D, #11
    FRINTP  V0.4H, V30.4H
    FCVTZS  V31.4H, V0.4H
    FRINTI  V12.2S, V10.2S
    FRINTA  V10.2D, V2.2D
    FCVTMU  V15.4S, V5.4S
    FCVTAU  V2.4H, V15.4H
    FCVTPS  V3.4H, V31.4H
    FCVTN2  V30.8H, V10.4S
    FCVTZU  V15.2S, V23.2S, #12
    FCVTL  V10.4S, V1.4H
    FCVTNS  V31.8H, V30.8H
    FCVTPS  V0.8H, V15.8H
    FRINTP  V26.4H, V13.4H
    FRINTX  V7.8H, V12.8H
    FCVTAS  V20.4S, V26.4S
    FCVTZS  V23.4S, V31.4S, #28
    FCVTPU  V13.8H, V17.8H
    FCVTPU  V1.4H, V7.4H
    FCVTZS  V25.2S, V8.2S, #21
    FCVTN2  V17.8H, V0.4S
    FCVTN  V7.2S, V18.2D
    FCVTZU  V31.4S, V20.4S
    FCVTZS  V13.8H, V17.8H
    FCVTNU  V8.8H, V25.8H
    FCVTAU  V25.2D, V25.2D
    FCVTMU  V3.4S, V31.4S
    FCVTZU V15.2D, V1.2D, #43
    FRINTA  V4.8H, V3.8H
    FCVTMU  V0.8H, V4.8H
    FCVTPU  V4.8H, V8.8H
    FCVTNU  V20.4H, V25.4H
    FCVTAU  V3.2D, V23.2D
    FCVTZS  V12.4H, V13.4H
    FRINTA  V4.2D, V3.2D
    FCVTPU  V31.4H, V28.4H
    FCVTZS  V8.2S, V12.2S
    FCVTZS  V23.8H, V7.8H, #11
    FCVTPU  V28.2S, V31.2S
    FRINTI  V3.4H, V5.4H
    FCVTMU  V13.2D, V3.2D
    FCVTN2  V28.8H, V20.4S
    FCVTZS  V30.2S, V26.2S, #14
    FCVTZS  V7.4S, V7.4S
    FRINTM  V18.4H, V2.4H
    FRINTM  V31.2S, V30.2S
    FCVTPU  V2.8H, V15.8H
    FCVTZU  V31.4S, V4.4S, #14
    FRINTZ  V22.8H, V9.8H
    FCVTN  V30.2S, V23.2D
    FCVTZU  V1.4S, V30.4S, #17
    FRINTX  V17.4H, V14.4H
    FCVTAU  V4.2D, V13.2D
    FCVTZU  V14.4S, V22.4S, #23
    FCVTN  V8.2S, V31.2D
    FCVTXN  V4.2S, V8.2D
    FRINTN  V22.4H, V7.4H
    FRINTA  V23.4H, V22.4H
    FCVTAS  V22.4H, V1.4H
    FCVTAU  V26.2D, V22.2D
    FCVTAS  V15.4S, V18.4S
    FRINTZ  V25.4H, V4.4H
    FCVTNS  V31.4H, V26.4H
    FCVTZU  V8.4H, V25.4H
    FCVTL2  V30.2D, V14.4S
    FCVTXN2  V30.4S, V23.2D
    FCVTPS  V22.4H, V30.4H
    FCVTZS  V13.8H, V28.8H, #5
    FCVTZU  V17.4H, V22.4H, #9
    FRINTN  V1.2D, V8.2D
    FCVTMS  V4.4S, V31.4S
    FRINTN  V11.8H, V8.8H
    FCVTMU  V17.2D, V17.2D
    FCVTZU  V30.2S, V22.2S
    FCVTZS  V8.2S, V13.2S
    FCVTNU  V18.4S, V15.4S
    FRINTP  V23.2S, V18.2S
    FCVTZS  V13.4H, V22.4H
    FCVTPU  V28.8H, V1.8H
    FRINTI  V30.2D, V29.2D
    FCVTAU  V29.4H, V30.4H
    FRINTN  V30.4S, V6.4S
    FCVTPS  V14.2S, V16.2S
    FCVTXN2  V22.4S, V28.2D
    FCVTPU  V18.2S, V30.2S
    FRINTI  V21.8H, V4.8H
    FCVTAS  V2.8H, V23.8H
    FCVTAS  V1.2S, V29.2S
    FRINTN  V28.4H, V22.4H
    FCVTN2  V16.8H, V28.4S
    FCVTZU  V23.8H, V2.8H
    FCVTPS  V26.8H, V17.8H
    FRINTP  V6.4H, V23.4H
    FCVTN  V5.4H, V17.4S
    FRINTA  V22.2S, V26.2S
    FRINTM  V26.8H, V5.8H
    FRINTI  V30.4H, V3.4H
    FCVTZS  V3.8H, V11.8H
    FRINTX  V4.4S, V14.4S
    FRINTZ  V17.4S, V3.4S
    FRINTZ  V2.4H, V1.4H
    FCVTMU  V29.2S, V26.2S
    FCVTZS  V14.4H, V2.4H, #5
    FCVTZS  V7.8H, V8.8H, #13
    FCVTPU  V23.2D, V17.2D
    FCVTNU  V15.2S, V22.2S
    FCVTZS  V11.4H, V6.4H, #6
    FCVTZU V26.2D, V4.2D, #21
    FCVTZS  V16.4S, V7.4S, #7
    FRINTZ  V1.4S, V11.4S
    FCVTN2  V3.4S, V16.2D
    FRINTZ  V11.2D, V15.2D
    FCVTMS  V5.4S, V1.4S
    FCVTZS  V22.4H, V12.4H
    FRINTX  V8.2D, V3.2D
    FCVTZU  V6.8H, V2.8H
    FCVTN  V2.4H, V22.4S
    FCVTAS  V7.8H, V8.8H
    FCVTNS  V28.4H, V19.4H
    FCVTPU  V17.4H, V30.4H
    FCVTAS  V3.2S, V20.2S
    FCVTXN  V19.2S, V24.2D
    FCVTMS  V7.2S, V26.2S
    FCVTMS  V1.2D, V23.2D
    FRINTP  V0.2S, V29.2S
    FCVTZS  V20.2S, V17.2S, #10
    FRINTZ  V8.2D, V19.2D
    FRINTI  V26.2S, V5.2S
    FRINTN  V5.2D, V18.2D
    FCVTZS  V22.8H, V11.8H, #12
    FCVTPS  V11.4S, V5.4S
    FCVTZU  V5.4H, V2.4H
    FCVTAU  V15.2D, V5.2D
    FRINTI  V18.4H, V28.4H
    FCVTZS V28.2D, V17.2D, #59
    FCVTZU  V19.2D, V6.2D
    FCVTZS  V12.4S, V3.4S, #24
    FCVTZU  V14.4H, V30.4H
    FRINTN  V2.4H, V20.4H
    FCVTL2  V30.4S, V2.8H
    FRINTZ  V5.2D, V28.2D
    FCVTPS  V2.4S, V19.4S
    FRINTI  V19.4H, V15.4H
    FCVTAS  V28.2S, V0.2S
    FCVTZS V3.2D, V18.2D, #51
    FRINTN  V29.2S, V8.2S
    FCVTMU  V17.2D, V12.2D
    FCVTXN  V18.2S, V22.2D
    FCVTZU V12.2D, V13.2D, #27
    FCVTL  V15.2D, V11.2S
    FCVTPS  V20.2D, V14.2D
    FCVTAU  V23.2S, V12.2S
    FCVTMU  V25.8H, V14.8H
    FCVTZU  V5.8H, V18.8H, #7
    FRINTX  V28.4S, V25.4S
    FCVTNU  V8.2S, V20.2S
    FCVTAU  V20.2D, V5.2D
    FRINTZ  V0.4H, V17.4H
    FCVTPS  V6.2D, V3.2D
    FCVTZS V23.2D, V30.2D, #27
    FCVTZS  V11.4H, V20.4H
    FCVTPU  V21.4S, V28.4S
    FCVTZU  V22.4S, V15.4S, #17
    FCVTL2  V17.2D, V0.4S
    FRINTI  V25.2S, V19.2S
    FRINTM  V14.4H, V8.4H
    FCVTMU  V8.8H, V8.8H
    SUBS  X20, X20, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_2
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X4, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X4, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X4, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X4, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X4, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X4, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X4, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X4, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X4, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X4, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X4, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X4, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X4, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X4, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X4, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X4, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X4, X13, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X4, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X4, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MRS  X13, FPSR
    MOVZ  X4, #0x1d, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V0.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D0
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V1.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D1
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D2
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D3
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V4.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D4
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D5
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D6
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V7.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D7
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V8.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D8
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D9
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D10
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D11
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D12
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V13.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D13
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V14.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D14
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D15
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D16
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D17
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D18
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D19
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D20
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D21
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D22
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V23.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D23
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D24
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D25
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V26.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D26
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D27
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V28.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D28
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V29.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D29
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x7fc0, LSL #16
    MOVK  X4, #0x7fc0, LSL #48
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V30.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D30
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, V31.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X13, D31
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
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
    FMOV  V0.D[1], X26
    FMOV  D1, X29
    FMOV  V1.D[1], X2
    FMOV  D2, X27
    FMOV  V2.D[1], X25
    FMOV  D3, X13
    FMOV  V3.D[1], X12
    FMOV  D4, X27
    FMOV  V4.D[1], X28
    FMOV  D5, X2
    FMOV  V5.D[1], X17
    FMOV  D6, X3
    FMOV  V6.D[1], X6
    FMOV  D7, X25
    FMOV  V7.D[1], X26
    FMOV  D8, X26
    FMOV  V8.D[1], X24
    FMOV  D9, X11
    FMOV  V9.D[1], X11
    FMOV  D10, X20
    FMOV  V10.D[1], X4
    FMOV  D11, X6
    FMOV  V11.D[1], X7
    FMOV  D12, X6
    FMOV  V12.D[1], X6
    FMOV  D13, X20
    FMOV  V13.D[1], X28
    FMOV  D14, X21
    FMOV  V14.D[1], X4
    FMOV  D15, X23
    FMOV  V15.D[1], X4
    FMOV  D16, X20
    FMOV  V16.D[1], X23
    FMOV  D17, X5
    FMOV  V17.D[1], X17
    FMOV  D18, X3
    FMOV  V18.D[1], X5
    FMOV  D19, X3
    FMOV  V19.D[1], X25
    FMOV  D20, X13
    FMOV  V20.D[1], X25
    FMOV  D21, X23
    FMOV  V21.D[1], X19
    FMOV  D22, X24
    FMOV  V22.D[1], X5
    FMOV  D23, X11
    FMOV  V23.D[1], X5
    FMOV  D24, X27
    FMOV  V24.D[1], X20
    FMOV  D25, X20
    FMOV  V25.D[1], X22
    FMOV  D26, X11
    FMOV  V26.D[1], X2
    FMOV  D27, X22
    FMOV  V27.D[1], X12
    FMOV  D28, X6
    FMOV  V28.D[1], X28
    FMOV  D29, X21
    FMOV  V29.D[1], X28
    FMOV  D30, X12
    FMOV  V30.D[1], X23
    FMOV  D31, X20
    FMOV  V31.D[1], X3
    MOVZ  X4, #0xa, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_3:
    FCVTNU  V21.2D, V26.2D
    FCVTPS  V15.4H, V30.4H
    FCVTZU  V22.4S, V28.4S
    FCVTZU  V1.8H, V10.8H, #4
    FCVTMU  V10.2S, V19.2S
    FCVTN2  V1.4S, V15.2D
    FCVTPS  V1.8H, V0.8H
    FCVTPS  V30.2D, V9.2D
    FRINTA  V5.2D, V10.2D
    FCVTZU  V0.2S, V30.2S, #3
    FCVTZS  V15.2D, V23.2D
    FRINTA  V3.2D, V20.2D
    FCVTMU  V20.2S, V31.2S
    FRINTM  V22.8H, V29.8H
    FCVTMS  V26.2D, V10.2D
    FRINTX  V9.2D, V15.2D
    FRINTZ  V31.2D, V26.2D
    FRINTX  V19.4H, V5.4H
    FCVTAS  V19.8H, V6.8H
    FRINTN  V1.2S, V7.2S
    FCVTZS  V27.2S, V24.2S, #12
    FCVTPS  V16.4H, V4.4H
    FRINTM  V28.4S, V9.4S
    FRINTX  V8.4S, V0.4S
    FRINTX  V26.4S, V7.4S
    FRINTA  V13.8H, V27.8H
    FCVTPS  V8.8H, V20.8H
    FCVTNS  V6.2S, V23.2S
    FCVTN  V7.4H, V8.4S
    FCVTZS V14.2D, V7.2D, #22
    FCVTZS  V27.2S, V22.2S, #10
    FRINTA  V29.8H, V27.8H
    FRINTA  V23.4H, V28.4H
    FCVTN  V9.4H, V6.4S
    FCVTXN  V5.2S, V16.2D
    FRINTZ  V6.2S, V31.2S
    FCVTXN  V4.2S, V29.2D
    FCVTZU V10.2D, V1.2D, #25
    FCVTN  V20.4H, V10.4S
    FCVTAS  V28.4S, V13.4S
    FCVTAS  V0.8H, V5.8H
    FRINTA  V31.4S, V23.4S
    FCVTZU  V16.8H, V20.8H, #3
    FCVTN  V2.4H, V6.4S
    FCVTN  V22.4H, V31.4S
    FCVTNS  V23.8H, V0.8H
    FCVTAS  V27.8H, V31.8H
    FCVTZS  V5.4S, V4.4S
    FCVTAS  V6.8H, V10.8H
    FRINTN  V31.8H, V26.8H
    FCVTAU  V4.4H, V6.4H
    FRINTN  V29.4S, V31.4S
    FCVTNS  V10.4S, V27.4S
    FCVTZU  V20.2D, V29.2D
    FCVTN2  V12.4S, V27.2D
    FRINTA  V0.2S, V16.2S
    FRINTA  V26.4H, V4.4H
    FRINTN  V27.8H, V28.8H
    FCVTZU V6.2D, V16.2D, #50
    FCVTPU  V13.2D, V10.2D
    FRINTM  V28.2D, V23.2D
    FRINTN  V29.2S, V22.2S
    FCVTMS  V31.4S, V0.4S
    FCVTN  V27.2S, V2.2D
    FRINTP  V1.4H, V26.4H
    FRINTA  V2.4S, V12.4S
    FRINTA  V12.2S, V28.2S
    FCVTXN  V0.2S, V31.2D
    FCVTXN  V30.2S, V6.2D
    FCVTZU  V22.8H, V8.8H, #9
    FCVTNS  V4.2D, V27.2D
    FRINTA  V27.8H, V4.8H
    FCVTAS  V20.2S, V22.2S
    FCVTNU  V28.2D, V22.2D
    FCVTPS  V16.8H, V21.8H
    FCVTZU  V22.4S, V27.4S, #9
    FRINTA  V16.2D, V12.2D
    FCVTZS  V27.4S, V29.4S, #30
    FCVTPU  V21.4H, V13.4H
    FCVTXN  V6.2S, V20.2D
    FCVTMU  V31.2D, V30.2D
    FRINTX  V3.8H, V31.8H
    FCVTZU  V4.4H, V6.4H, #9
    FCVTZU  V1.8H, V2.8H, #15
    FCVTXN  V12.2S, V29.2D
    FRINTZ  V30.4H, V28.4H
    FRINTI  V8.4H, V4.4H
    FCVTMS  V13.2D, V14.2D
    FRINTA  V19.8H, V16.8H
    FRINTP  V20.2D, V27.2D
    FCVTZS V23.2D, V15.2D, #33
    FRINTN  V28.8H, V21.8H
    FCVTNS  V6.2D, V30.2D
    FCVTPU  V28.8H, V3.8H
    FCVTMU  V21.2D, V21.2D
    FCVTZU  V28.2S, V20.2S, #28
    FCVTAS  V27.4H, V13.4H
    FRINTX  V2.2D, V8.2D
    FCVTZU V22.2D, V28.2D, #63
    FRINTM  V30.4H, V23.4H
    FCVTZS V18.2D, V1.2D, #34
    FRINTI  V4.2D, V22.2D
    FRINTN  V20.4H, V13.4H
    FRINTI  V13.4H, V19.4H
    FCVTZS V23.2D, V2.2D, #31
    FCVTZU  V25.2S, V21.2S
    FCVTAS  V21.8H, V6.8H
    FRINTA  V16.8H, V23.8H
    FCVTPU  V8.2S, V27.2S
    FCVTPU  V25.2D, V25.2D
    FCVTZS  V21.8H, V8.8H, #16
    FCVTNS  V2.8H, V28.8H
    FCVTAU  V27.2D, V11.2D
    FRINTP  V19.8H, V12.8H
    FCVTPU  V6.2D, V2.2D
    FRINTA  V8.8H, V20.8H
    FCVTNS  V22.4S, V16.4S
    FCVTPU  V2.2S, V8.2S
    FRINTN  V8.8H, V22.8H
    FCVTMU  V20.4S, V19.4S
    FCVTZU  V15.8H, V7.8H
    FCVTZS  V15.8H, V13.8H, #13
    FCVTZU  V7.4S, V15.4S
    FCVTPU  V19.2D, V11.2D
    FRINTN  V1.8H, V27.8H
    FRINTN  V13.4H, V2.4H
    FRINTA  V15.4S, V7.4S
    FRINTA  V2.2D, V15.2D
    FRINTX  V16.4S, V12.4S
    FRINTA  V12.8H, V10.8H
    FRINTM  V7.8H, V21.8H
    FCVTXN  V5.2S, V20.2D
    FRINTA  V19.2S, V7.2S
    FRINTN  V1.2S, V2.2S
    FRINTP  V30.2D, V8.2D
    FCVTZU  V18.4H, V5.4H
    FCVTPS  V21.8H, V4.8H
    FCVTZU V11.2D, V13.2D, #43
    FCVTMS  V2.4H, V12.4H
    FCVTZS  V8.8H, V21.8H
    FRINTN  V22.4H, V1.4H
    FCVTZU  V1.8H, V8.8H
    FCVTMU  V12.4H, V16.4H
    FRINTX  V8.2S, V6.2S
    FCVTNU  V13.4H, V2.4H
    FRINTI  V10.4S, V11.4S
    FCVTMS  V12.4H, V29.4H
    FCVTAU  V7.8H, V26.8H
    FCVTMU  V6.2S, V30.2S
    FCVTAU  V26.4H, V7.4H
    FCVTPU  V2.8H, V24.8H
    FCVTZU  V27.4S, V12.4S, #12
    FCVTAU  V16.2D, V16.2D
    FCVTZU  V30.4S, V10.4S
    FCVTZS  V11.2D, V22.2D
    FRINTP  V29.4H, V1.4H
    FCVTNS  V12.4H, V8.4H
    FCVTL  V1.4S, V2.4H
    FRINTM  V21.4H, V11.4H
    FCVTPS  V10.4H, V12.4H
    FRINTM  V31.8H, V13.8H
    FRINTZ  V7.4S, V29.4S
    FCVTPS  V2.2S, V1.2S
    FRINTP  V29.8H, V21.8H
    FCVTAU  V1.2D, V5.2D
    FRINTI  V5.4S, V6.4S
    FCVTAU  V28.8H, V30.8H
    FRINTN  V6.2D, V12.2D
    FRINTM  V16.4H, V6.4H
    FCVTAS  V30.4H, V10.4H
    FRINTN  V2.8H, V27.8H
    FCVTNU  V10.2S, V29.2S
    FCVTL  V8.4S, V1.4H
    FCVTPS  V24.4H, V14.4H
    FCVTPU  V13.2S, V16.2S
    FCVTPU  V4.4H, V2.4H
    FCVTPU  V11.4H, V8.4H
    FRINTM  V8.2D, V7.2D
    FCVTZS V13.2D, V10.2D, #5
    FRINTZ  V21.2S, V18.2S
    FCVTN2  V18.4S, V21.2D
    FCVTMS  V12.2S, V11.2S
    FRINTN  V10.8H, V13.8H
    FCVTMU  V21.4H, V18.4H
    FCVTXN2  V29.4S, V21.2D
    FCVTZU  V1.4H, V8.4H, #10
    FCVTN  V9.4H, V29.4S
    FRINTP  V18.2S, V4.2S
    FCVTMU  V11.2D, V9.2D
    FRINTN  V6.8H, V24.8H
    FCVTXN  V20.2S, V12.2D
    FCVTXN2  V13.4S, V6.2D
    FCVTZU  V2.2S, V2.2S, #4
    FCVTL2  V21.4S, V20.8H
    FRINTA  V24.4S, V14.4S
    FRINTN  V4.2S, V10.2S
    FCVTZU  V2.4S, V30.4S, #22
    FCVTZU  V8.2S, V13.2S
    FCVTZS  V9.4H, V8.4H
    FCVTZU  V20.2S, V24.2S, #31
    SUBS  X4, X4, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_3
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MRS  X11, FPSR
    MOVZ  X26, #0x1d, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V0.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D0
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V1.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D1
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D2
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D3
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D4
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D5
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V6.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D6
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D7
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D8
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D9
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D10
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V11.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D11
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D12
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D13
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D14
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D15
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D16
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D17
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D18
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D19
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D20
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D21
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D22
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D23
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D24
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D25
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D26
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D27
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D28
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D29
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V30.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D30
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V31.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D31
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
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
    FMOV  V0.D[1], X29
    FMOV  D1, X26
    FMOV  V1.D[1], X25
    FMOV  D2, X28
    FMOV  V2.D[1], X26
    FMOV  D3, X6
    FMOV  V3.D[1], X12
    FMOV  D4, X19
    FMOV  V4.D[1], X28
    FMOV  D5, X4
    FMOV  V5.D[1], X23
    FMOV  D6, X26
    FMOV  V6.D[1], X27
    FMOV  D7, X11
    FMOV  V7.D[1], X23
    FMOV  D8, X27
    FMOV  V8.D[1], X29
    FMOV  D9, X2
    FMOV  V9.D[1], X20
    FMOV  D10, X18
    FMOV  V10.D[1], X3
    FMOV  D11, X12
    FMOV  V11.D[1], X26
    FMOV  D12, X5
    FMOV  V12.D[1], X7
    FMOV  D13, X27
    FMOV  V13.D[1], X2
    FMOV  D14, X21
    FMOV  V14.D[1], X27
    FMOV  D15, X11
    FMOV  V15.D[1], X11
    FMOV  D16, X13
    FMOV  V16.D[1], X20
    FMOV  D17, X11
    FMOV  V17.D[1], X4
    FMOV  D18, X18
    FMOV  V18.D[1], X3
    FMOV  D19, X6
    FMOV  V19.D[1], X22
    FMOV  D20, X13
    FMOV  V20.D[1], X22
    FMOV  D21, X26
    FMOV  V21.D[1], X24
    FMOV  D22, X12
    FMOV  V22.D[1], X17
    FMOV  D23, X4
    FMOV  V23.D[1], X24
    FMOV  D24, X29
    FMOV  V24.D[1], X18
    FMOV  D25, X22
    FMOV  V25.D[1], X16
    FMOV  D26, X6
    FMOV  V26.D[1], X2
    FMOV  D27, X19
    FMOV  V27.D[1], X2
    FMOV  D28, X17
    FMOV  V28.D[1], X28
    FMOV  D29, X11
    FMOV  V29.D[1], X29
    FMOV  D30, X17
    FMOV  V30.D[1], X2
    FMOV  D31, X16
    FMOV  V31.D[1], X7
    MOVZ  X13, #0xa, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_4:
    FCVTNU  V24.4S, V2.4S
    FCVTMU  V11.2D, V25.2D
    FCVTL  V8.4S, V27.4H
    FCVTZS  V25.2D, V11.2D
    FRINTN  V27.8H, V20.8H
    FCVTNU  V29.8H, V31.8H
    FRINTN  V7.4S, V26.4S
    FCVTNS  V15.2S, V7.2S
    FCVTPS  V21.2S, V24.2S
    FCVTAS  V25.2D, V19.2D
    FCVTNU  V12.4S, V30.4S
    FCVTZU V0.2D, V8.2D, #9
    FCVTXN  V7.2S, V28.2D
    FCVTAS  V2.2S, V0.2S
    FCVTNS  V28.2D, V12.2D
    FCVTNS  V3.2D, V25.2D
    FCVTZS  V22.8H, V7.8H
    FRINTZ  V3.8H, V27.8H
    FCVTPS  V1.4S, V3.4S
    FCVTL  V18.2D, V1.2S
    FRINTX  V25.2S, V0.2S
    FRINTZ  V1.2D, V19.2D
    FCVTNS  V11.4S, V22.4S
    FCVTMS  V22.4S, V28.4S
    FCVTNS  V2.2S, V19.2S
    FRINTP  V0.4S, V2.4S
    FRINTP  V27.8H, V21.8H
    FRINTI  V8.8H, V25.8H
    FCVTN  V11.4H, V18.4S
    FRINTM  V20.4H, V0.4H
    FRINTA  V0.2S, V22.2S
    FRINTP  V21.8H, V20.8H
    FCVTL  V0.4S, V21.4H
    FCVTZU V19.2D, V0.2D, #43
    FRINTM  V22.4H, V1.4H
    FCVTMS  V14.4H, V19.4H
    FCVTAS  V1.8H, V8.8H
    FCVTNU  V3.8H, V1.8H
    FCVTPS  V18.4S, V29.4S
    FCVTAU  V8.2S, V26.2S
    FCVTZS  V19.4H, V3.4H, #12
    FCVTZS  V0.2S, V28.2S, #11
    FRINTP  V4.4H, V8.4H
    FRINTA  V6.2S, V26.2S
    FCVTZU V27.2D, V27.2D, #31
    FCVTL  V8.2D, V12.2S
    FCVTAS  V3.4H, V25.4H
    FCVTXN2  V12.4S, V6.2D
    FCVTNS  V25.4S, V22.4S
    FCVTXN  V2.2S, V11.2D
    FCVTZU  V4.4H, V12.4H, #13
    FCVTZU  V12.4H, V17.4H, #2
    FCVTAU  V5.4S, V0.4S
    FCVTPS  V17.2D, V4.2D
    FCVTNU  V12.2S, V18.2S
    FRINTX  V18.4S, V27.4S
    FCVTAU  V11.4H, V18.4H
    FRINTX  V0.4H, V2.4H
    FRINTI  V19.2S, V5.2S
    FCVTZU  V28.2S, V8.2S, #12
    FCVTAU  V27.4H, V11.4H
    FRINTM  V22.4S, V12.4S
    FCVTZU  V5.4H, V14.4H, #3
    FCVTN  V28.2S, V27.2D
    FRINTN  V27.2S, V22.2S
    FRINTI  V13.2D, V0.2D
    FCVTNU  V11.4S, V19.4S
    FCVTNU  V19.4H, V11.4H
    FRINTI  V30.2S, V5.2S
    FCVTAS  V16.4H, V17.4H
    FRINTN  V22.4S, V30.4S
    FRINTI  V26.2D, V16.2D
    FRINTA  V17.4H, V12.4H
    FCVTL  V30.4S, V20.4H
    FRINTZ  V14.4S, V27.4S
    FRINTP  V2.8H, V17.8H
    FRINTI  V8.8H, V27.8H
    FRINTP  V18.2S, V13.2S
    FRINTN  V27.4H, V2.4H
    FCVTMS  V17.2D, V28.2D
    FCVTMU  V2.8H, V20.8H
    FRINTM  V0.2S, V17.2S
    FCVTZS  V20.4H, V8.4H
    FCVTMS  V4.4H, V18.4H
    FCVTN  V28.4H, V19.4S
    FCVTZS V5.2D, V20.2D, #30
    FRINTX  V20.2S, V2.2S
    FCVTZU  V18.4S, V27.4S
    FCVTZU  V27.4S, V26.4S
    FCVTZU  V17.4S, V5.4S, #22
    FCVTNU  V16.8H, V14.8H
    FCVTZS  V26.8H, V12.8H
    FCVTMU  V12.4S, V0.4S
    FRINTZ  V11.2S, V12.2S
    FRINTM  V7.2D, V18.2D
    FRINTA  V18.8H, V7.8H
    FCVTNU  V5.2S, V20.2S
    FCVTMS  V21.2D, V18.2D
    FCVTZU  V12.8H, V22.8H, #16
    FCVTNS  V23.2D, V21.2D
    FRINTN  V18.2D, V26.2D
    FCVTZS  V8.4S, V17.4S
    FRINTP  V25.8H, V27.8H
    FCVTNS  V2.2S, V31.2S
    FCVTNU  V0.4H, V25.4H
    FCVTAS  V18.2D, V18.2D
    FCVTAU  V21.4H, V23.4H
    FRINTZ  V27.2S, V11.2S
    FCVTNS  V16.4H, V11.4H
    FCVTZU  V14.4H, V2.4H
    FRINTA  V7.2S, V5.2S
    FCVTZU  V31.8H, V18.8H
    FRINTM  V11.2D, V21.2D
    FCVTL2  V19.4S, V23.8H
    FRINTN  V8.4S, V0.4S
    FCVTZS  V27.8H, V24.8H
    FRINTZ  V25.4H, V28.4H
    FRINTM  V10.2S, V2.2S
    FRINTP  V2.2D, V7.2D
    FCVTZU  V24.4H, V28.4H
    FCVTMU  V21.4H, V12.4H
    FRINTN  V18.2S, V25.2S
    FCVTNU  V25.4H, V8.4H
    FCVTMU  V7.8H, V31.8H
    FRINTA  V31.2D, V19.2D
    FRINTZ  V8.4S, V11.4S
    FCVTMU  V0.8H, V10.8H
    FCVTMS  V23.4S, V21.4S
    FCVTZS  V22.2D, V7.2D
    FCVTZU  V31.4H, V2.4H, #12
    FCVTPS  V21.8H, V16.8H
    FCVTMU  V20.8H, V12.8H
    FCVTPS  V10.4S, V8.4S
    FRINTZ  V16.8H, V10.8H
    FRINTN  V5.8H, V6.8H
    FRINTA  V23.8H, V10.8H
    FCVTZU  V2.8H, V0.8H, #4
    FCVTAU  V8.8H, V22.8H
    FCVTZU  V9.2S, V2.2S
    FCVTMU  V22.2D, V24.2D
    FRINTN  V5.4S, V19.4S
    FCVTZS V11.2D, V9.2D, #31
    FCVTXN2  V9.4S, V11.2D
    FCVTAU  V11.2S, V23.2S
    FCVTZS  V6.2S, V16.2S, #4
    FCVTAU  V1.4H, V8.4H
    FCVTZU  V8.2D, V25.2D
    FCVTPS  V17.2S, V18.2S
    FRINTZ  V24.2D, V17.2D
    FCVTZU  V25.8H, V22.8H, #5
    FRINTX  V10.8H, V8.8H
    FCVTNS  V7.4H, V29.4H
    FCVTN2  V11.4S, V9.2D
    FRINTM  V8.8H, V1.8H
    FRINTX  V18.2D, V11.2D
    FRINTZ  V13.8H, V3.8H
    FCVTAU  V10.2D, V2.2D
    FCVTZS  V9.2S, V5.2S, #2
    FCVTNS  V3.4H, V8.4H
    FRINTZ  V1.2S, V10.2S
    FCVTMS  V11.8H, V28.8H
    FCVTMS  V17.4S, V24.4S
    FRINTM  V28.4H, V18.4H
    FCVTZU V29.2D, V6.2D, #60
    FCVTN  V19.4H, V18.4S
    FCVTNU  V6.2S, V3.2S
    FCVTAU  V5.8H, V7.8H
    FRINTX  V2.2D, V12.2D
    FRINTZ  V10.2S, V11.2S
    FRINTP  V29.4S, V28.4S
    FCVTN2  V3.8H, V9.4S
    FCVTNS  V16.2S, V17.2S
    FCVTZS  V28.4H, V3.4H
    FCVTMU  V23.4S, V29.4S
    FCVTN2  V22.4S, V16.2D
    FCVTNU  V12.4H, V10.4H
    FCVTPS  V12.4S, V11.4S
    FCVTPS  V9.2S, V19.2S
    FCVTNS  V24.8H, V5.8H
    FRINTZ  V20.2D, V22.2D
    FCVTL  V3.2D, V1.2S
    FCVTZS  V0.4H, V23.4H
    FRINTA  V17.4S, V2.4S
    FCVTN2  V8.4S, V20.2D
    FRINTZ  V10.2S, V14.2S
    FCVTAU  V2.8H, V13.8H
    FCVTAU  V23.8H, V6.8H
    FCVTNU  V6.2S, V24.2S
    FCVTN  V22.4H, V0.4S
    FCVTNS  V1.2S, V10.2S
    FCVTNS  V0.4S, V16.4S
    FCVTZU  V24.8H, V30.8H, #2
    FRINTA  V14.4S, V13.4S
    FCVTPS  V30.4H, V6.4H
    FCVTZS  V16.4S, V12.4S
    FCVTMU  V15.8H, V16.8H
    FCVTPU  V11.2S, V30.2S
    FCVTZS  V13.4S, V23.4S, #10
    FRINTX  V20.2D, V10.2D
    FRINTA  V23.8H, V30.8H
    SUBS  X13, X13, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_4
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MRS  X26, FPSR
    MOVZ  X2, #0x1d, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V0.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D0
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V1.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D1
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D2
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D3
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D4
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D5
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D6
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D7
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D8
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D9
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D10
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V11.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D11
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D12
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D13
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D14
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D15
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D16
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D17
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D18
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D19
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D20
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D21
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D22
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D23
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D24
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D25
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V26.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D26
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D27
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D28
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D29
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V30.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D30
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, V31.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X26, D31
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X2, #0x8d10, LSL #0
    MOVK  X2, #0xf106, LSL #16
    MOVK  X2, #0xbe24, LSL #32
    MOVK  X2, #0xf568, LSL #48
    MOVZ  X3, #0x8fa0, LSL #0
    MOVK  X3, #0xd327, LSL #16
    MOVK  X3, #0xd3c9, LSL #32
    MOVK  X3, #0x40f2, LSL #48
    MOVZ  X4, #0x7022, LSL #0
    MOVK  X4, #0x1387, LSL #16
    MOVK  X4, #0x450b, LSL #32
    MOVK  X4, #0x8f57, LSL #48
    MOVZ  X5, #0x4cad, LSL #0
    MOVK  X5, #0x9e3e, LSL #16
    MOVK  X5, #0x5c1f, LSL #32
    MOVK  X5, #0x45ca, LSL #48
    MOVZ  X6, #0xd1c6, LSL #0
    MOVK  X6, #0x31a9, LSL #16
    MOVK  X6, #0xd837, LSL #32
    MOVK  X6, #0x6fe1, LSL #48
    MOVZ  X7, #0xb207, LSL #0
    MOVK  X7, #0xbcaf, LSL #16
    MOVK  X7, #0x34f5, LSL #32
    MOVK  X7, #0x52e7, LSL #48
    MOVZ  X11, #0xea64, LSL #0
    MOVK  X11, #0x9403, LSL #16
    MOVK  X11, #0x4119, LSL #32
    MOVK  X11, #0x5fab, LSL #48
    MOVZ  X12, #0x838f, LSL #0
    MOVK  X12, #0x904c, LSL #16
    MOVK  X12, #0xd3e1, LSL #32
    MOVK  X12, #0xc0eb, LSL #48
    MOVZ  X13, #0xc0be, LSL #0
    MOVK  X13, #0x9883, LSL #16
    MOVK  X13, #0x31d1, LSL #32
    MOVK  X13, #0xe01d, LSL #48
    MOVZ  X16, #0xfa19, LSL #0
    MOVK  X16, #0xc3d3, LSL #16
    MOVK  X16, #0xec15, LSL #32
    MOVK  X16, #0x892f, LSL #48
    MOVZ  X17, #0x43d9, LSL #0
    MOVK  X17, #0xa170, LSL #16
    MOVK  X17, #0x99b8, LSL #32
    MOVK  X17, #0x8246, LSL #48
    MOVZ  X18, #0xa6cb, LSL #0
    MOVK  X18, #0x58d, LSL #16
    MOVK  X18, #0x59b4, LSL #32
    MOVK  X18, #0x9bc3, LSL #48
    MOVZ  X19, #0x297, LSL #0
    MOVK  X19, #0xd967, LSL #16
    MOVK  X19, #0x2f3b, LSL #32
    MOVK  X19, #0x4000, LSL #48
    MOVZ  X20, #0xaa82, LSL #0
    MOVK  X20, #0xf80c, LSL #16
    MOVK  X20, #0x6a34, LSL #32
    MOVK  X20, #0x11d, LSL #48
    MOVZ  X21, #0xf063, LSL #0
    MOVK  X21, #0xce32, LSL #16
    MOVK  X21, #0x3da, LSL #32
    MOVK  X21, #0xbfbf, LSL #48
    MOVZ  X22, #0xd530, LSL #0
    MOVK  X22, #0x8034, LSL #16
    MOVK  X22, #0x48fb, LSL #32
    MOVK  X22, #0x2fc5, LSL #48
    MOVZ  X23, #0xf35b, LSL #0
    MOVK  X23, #0x55d3, LSL #16
    MOVK  X23, #0x7b18, LSL #32
    MOVK  X23, #0x4e90, LSL #48
    MOVZ  X24, #0xfebe, LSL #0
    MOVK  X24, #0xb1df, LSL #16
    MOVK  X24, #0xdadd, LSL #32
    MOVK  X24, #0xc3de, LSL #48
    MOVZ  X25, #0x9f96, LSL #0
    MOVK  X25, #0x26c9, LSL #16
    MOVK  X25, #0xe92b, LSL #32
    MOVK  X25, #0x43e7, LSL #48
    MOVZ  X26, #0x62e8, LSL #0
    MOVK  X26, #0x53e7, LSL #16
    MOVK  X26, #0xfcb4, LSL #32
    MOVK  X26, #0xf552, LSL #48
    MOVZ  X27, #0x7b13, LSL #0
    MOVK  X27, #0x2bee, LSL #16
    MOVK  X27, #0x97cd, LSL #32
    MOVK  X27, #0xf630, LSL #48
    MOVZ  X28, #0x3179, LSL #0
    MOVK  X28, #0xdef9, LSL #16
    MOVK  X28, #0x4b26, LSL #32
    MOVK  X28, #0xd45f, LSL #48
    MOVZ  X29, #0x36c9, LSL #0
    MOVK  X29, #0xaa98, LSL #16
    MOVK  X29, #0xee6d, LSL #32
    MOVK  X29, #0x2c8d, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X27
    FMOV  D1, X25
    FMOV  V1.D[1], X11
    FMOV  D2, X28
    FMOV  V2.D[1], X26
    FMOV  D3, X23
    FMOV  V3.D[1], X17
    FMOV  D4, X16
    FMOV  V4.D[1], X6
    FMOV  D5, X20
    FMOV  V5.D[1], X22
    FMOV  D6, X23
    FMOV  V6.D[1], X27
    FMOV  D7, X22
    FMOV  V7.D[1], X21
    FMOV  D8, X21
    FMOV  V8.D[1], X11
    FMOV  D9, X28
    FMOV  V9.D[1], X27
    FMOV  D10, X22
    FMOV  V10.D[1], X27
    FMOV  D11, X24
    FMOV  V11.D[1], X19
    FMOV  D12, X28
    FMOV  V12.D[1], X27
    FMOV  D13, X7
    FMOV  V13.D[1], X6
    FMOV  D14, X11
    FMOV  V14.D[1], X23
    FMOV  D15, X26
    FMOV  V15.D[1], X5
    FMOV  D16, X24
    FMOV  V16.D[1], X5
    FMOV  D17, X18
    FMOV  V17.D[1], X24
    FMOV  D18, X29
    FMOV  V18.D[1], X23
    FMOV  D19, X23
    FMOV  V19.D[1], X11
    FMOV  D20, X22
    FMOV  V20.D[1], X11
    FMOV  D21, X5
    FMOV  V21.D[1], X6
    FMOV  D22, X21
    FMOV  V22.D[1], X28
    FMOV  D23, X26
    FMOV  V23.D[1], X21
    FMOV  D24, X16
    FMOV  V24.D[1], X20
    FMOV  D25, X13
    FMOV  V25.D[1], X28
    FMOV  D26, X17
    FMOV  V26.D[1], X27
    FMOV  D27, X23
    FMOV  V27.D[1], X24
    FMOV  D28, X4
    FMOV  V28.D[1], X29
    FMOV  D29, X2
    FMOV  V29.D[1], X16
    FMOV  D30, X17
    FMOV  V30.D[1], X17
    FMOV  D31, X23
    FMOV  V31.D[1], X16
    MOVZ  X13, #0xa, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_5:
    FCVTL2  V18.2D, V28.4S
    FCVTAS  V20.8H, V31.8H
    FRINTA  V7.4S, V25.4S
    FCVTZS V14.2D, V5.2D, #40
    FCVTN2  V20.4S, V23.2D
    FCVTMS  V3.2D, V30.2D
    FCVTMS  V20.4H, V29.4H
    FCVTAU  V8.8H, V7.8H
    FCVTNU  V13.4S, V3.4S
    FCVTN  V8.2S, V20.2D
    FRINTM  V14.8H, V14.8H
    FRINTP  V14.2S, V24.2S
    FRINTX  V28.4S, V13.4S
    FCVTMU  V24.8H, V28.8H
    FRINTX  V9.4S, V14.4S
    FCVTZU  V27.2D, V5.2D
    FRINTZ  V24.4H, V8.4H
    FRINTX  V12.4H, V24.4H
    FCVTZS V4.2D, V27.2D, #25
    FCVTMS  V20.4S, V12.4S
    FCVTN  V8.2S, V18.2D
    FRINTI  V12.4H, V20.4H
    FCVTN2  V31.8H, V8.4S
    FRINTI  V8.4H, V0.4H
    FCVTMS  V23.8H, V28.8H
    FCVTZS  V24.4H, V31.4H, #16
    FCVTZU  V13.4H, V23.4H, #2
    FCVTMS  V17.4H, V4.4H
    FCVTMS  V0.2D, V17.2D
    FCVTZU  V5.4H, V24.4H
    FRINTZ  V27.4H, V12.4H
    FCVTXN  V12.2S, V0.2D
    FCVTPS  V20.2S, V2.2S
    FCVTPS  V3.2S, V5.2S
    FCVTPU  V2.8H, V25.8H
    FCVTZS  V18.8H, V3.8H
    FCVTAS  V5.4H, V22.4H
    FRINTM  V14.8H, V20.8H
    FCVTMS  V31.2S, V5.2S
    FRINTI  V11.4H, V12.4H
    FRINTA  V8.4H, V9.4H
    FRINTI  V17.2S, V14.2S
    FRINTP  V0.2D, V13.2D
    FCVTNS  V9.8H, V18.8H
    FCVTZS V5.2D, V8.2D, #18
    FRINTN  V4.2D, V11.2D
    FCVTZS  V20.2S, V4.2S, #31
    FRINTA  V13.4H, V22.4H
    FCVTPU  V8.4H, V0.4H
    FCVTPS  V25.2D, V5.2D
    FCVTXN  V11.2S, V20.2D
    FCVTZS  V0.8H, V2.8H
    FCVTZU  V4.8H, V13.8H
    FCVTPS  V5.8H, V8.8H
    FCVTXN  V3.2S, V4.2D
    FCVTPS  V14.2S, V22.2S
    FCVTNU  V0.8H, V31.8H
    FRINTA  V12.4H, V25.4H
    FRINTA  V13.4S, V0.4S
    FCVTZU  V5.8H, V31.8H, #11
    FCVTNS  V2.4H, V5.4H
    FCVTNU  V9.2S, V12.2S
    FCVTMU  V18.2S, V4.2S
    FCVTAS  V20.2S, V18.2S
    FRINTN  V12.2D, V3.2D
    FCVTXN  V18.2S, V14.2D
    FCVTZU V8.2D, V11.2D, #52
    FCVTZU  V0.4S, V13.4S, #21
    FRINTA  V5.2D, V5.2D
    FCVTZS  V2.4S, V2.4S, #18
    FCVTMS  V23.8H, V20.8H
    FCVTNS  V20.4S, V0.4S
    FRINTX  V4.2D, V18.2D
    FCVTPU  V10.8H, V5.8H
    FCVTPS  V5.2S, V12.2S
    FCVTNS  V12.8H, V23.8H
    FCVTPU  V18.2D, V5.2D
    FCVTZU  V14.4H, V8.4H, #4
    FRINTA  V11.2D, V21.2D
    FCVTZU  V23.4H, V18.4H, #5
    FCVTZS  V31.4H, V31.4H, #11
    FCVTPU  V5.2D, V2.2D
    FCVTAU  V2.8H, V28.8H
    FCVTZS  V21.2S, V12.2S
    FRINTZ  V9.8H, V13.8H
    FCVTZS  V13.4S, V23.4S, #19
    FCVTNU  V23.2S, V13.2S
    FCVTNS  V12.8H, V21.8H
    FCVTPU  V28.4H, V4.4H
    FCVTZS  V13.4H, V12.4H
    FCVTZS  V12.2D, V28.2D
    FRINTP  V21.4H, V11.4H
    FCVTMU  V29.2S, V5.2S
    FRINTA  V6.8H, V19.8H
    FRINTI  V28.8H, V9.8H
    FCVTXN2  V19.4S, V6.2D
    FRINTP  V11.8H, V29.8H
    FCVTPS  V8.4H, V16.4H
    FCVTNS  V14.4S, V8.4S
    FCVTMS  V5.4H, V23.4H
    FCVTAU  V15.4S, V14.4S
    FRINTN  V23.8H, V21.8H
    FRINTM  V13.8H, V13.8H
    FRINTM  V21.8H, V13.8H
    FCVTL  V4.4S, V23.4H
    FCVTZU V25.2D, V5.2D, #11
    FCVTZU  V25.4S, V31.4S, #5
    FRINTI  V6.2S, V15.2S
    FCVTXN2  V9.4S, V5.2D
    FRINTZ  V15.4H, V6.4H
    FCVTL  V23.2D, V25.2S
    FCVTMS  V7.4H, V12.4H
    FRINTI  V16.8H, V9.8H
    FRINTZ  V29.4H, V19.4H
    FCVTPS  V19.4H, V15.4H
    FCVTN  V25.2S, V12.2D
    FRINTX  V0.4H, V29.4H
    FCVTNS  V5.4H, V0.4H
    FCVTZU V6.2D, V4.2D, #56
    FRINTZ  V29.4S, V5.4S
    FCVTAS  V13.8H, V24.8H
    FRINTP  V31.4H, V19.4H
    FCVTPS  V24.2D, V16.2D
    FCVTZU  V12.8H, V21.8H
    FCVTZU  V16.4H, V7.4H
    FCVTNU  V7.8H, V24.8H
    FCVTPS  V4.2D, V13.2D
    FCVTNS  V20.2D, V23.2D
    FRINTX  V19.4H, V20.4H
    FCVTL  V10.4S, V4.4H
    FCVTL2  V13.2D, V31.4S
    FCVTPS  V12.4S, V25.4S
    FCVTAS  V21.2D, V19.2D
    FCVTMU  V20.4H, V21.4H
    FCVTNU  V4.2D, V16.2D
    FCVTMU  V9.2D, V29.2D
    FRINTP  V19.4H, V12.4H
    FCVTMS  V0.8H, V19.8H
    FCVTXN2  V12.4S, V6.2D
    FCVTZU  V14.4S, V21.4S
    FCVTMU  V21.4H, V9.4H
    FCVTZU  V15.2S, V8.2S, #21
    FCVTMU  V31.4H, V0.4H
    FCVTAU  V8.2S, V3.2S
    FRINTN  V14.2D, V12.2D
    FRINTI  V6.2D, V14.2D
    FCVTPS  V16.4S, V13.4S
    FRINTM  V10.4S, V4.4S
    FRINTI  V4.8H, V10.8H
    FCVTN  V3.2S, V16.2D
    FCVTZU  V23.8H, V4.8H
    FRINTA  V25.2S, V15.2S
    FCVTZS  V9.8H, V8.8H
    FCVTZS  V16.8H, V3.8H, #16
    FCVTN2  V10.8H, V25.4S
    FCVTMS  V26.4H, V21.4H
    FRINTN  V8.4H, V6.4H
    FCVTL  V6.2D, V20.2S
    FCVTN2  V12.4S, V8.2D
    FCVTZU  V14.4S, V23.4S, #3
    FRINTM  V21.4S, V3.4S
    FCVTZU  V4.2S, V31.2S
    FRINTZ  V0.4H, V14.4H
    FRINTI  V25.4H, V16.4H
    FRINTA  V23.2D, V22.2D
    FRINTZ  V16.4H, V9.4H
    FCVTN2  V16.4S, V25.2D
    FRINTI  V25.8H, V23.8H
    FRINTA  V15.4H, V25.4H
    FCVTAS  V31.4H, V26.4H
    FCVTL  V20.4S, V20.4H
    FCVTMS  V24.4H, V12.4H
    FCVTZS  V29.8H, V4.8H
    FCVTAS  V8.2S, V6.2S
    FRINTA  V9.4H, V24.4H
    FRINTZ  V19.4H, V9.4H
    FRINTN  V23.4S, V29.4S
    FCVTPU  V22.8H, V31.8H
    FCVTPS  V9.4H, V20.4H
    FCVTMS  V26.8H, V2.8H
    FRINTP  V20.2D, V10.2D
    FCVTZU  V23.2S, V19.2S
    FCVTZS  V12.2S, V10.2S, #25
    FCVTZU  V25.2S, V26.2S, #13
    FRINTP  V2.8H, V5.8H
    FCVTZS  V21.2D, V2.2D
    FCVTL  V14.2D, V12.2S
    FCVTAS  V5.2S, V15.2S
    FCVTPU  V2.8H, V25.8H
    FRINTI  V1.8H, V22.8H
    FCVTPS  V10.4H, V23.4H
    FCVTNU  V29.4S, V8.4S
    FRINTP  V31.4H, V29.4H
    FRINTI  V26.8H, V2.8H
    FCVTMU  V12.4H, V12.4H
    FCVTZS  V6.2S, V26.2S
    FRINTI  V15.4H, V12.4H
    FRINTM  V19.8H, V20.8H
    FRINTX  V25.2D, V10.2D
    FCVTZU V20.2D, V25.2D, #4
    SUBS  X13, X13, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_5
    MOVZ  X19, #0x8d10, LSL #0
    MOVK  X19, #0xf106, LSL #16
    MOVK  X19, #0xbe24, LSL #32
    MOVK  X19, #0xf568, LSL #48
    SUB  X18, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x8fa0, LSL #0
    MOVK  X19, #0xd327, LSL #16
    MOVK  X19, #0xd3c9, LSL #32
    MOVK  X19, #0x40f2, LSL #48
    SUB  X18, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x7022, LSL #0
    MOVK  X19, #0x1387, LSL #16
    MOVK  X19, #0x450b, LSL #32
    MOVK  X19, #0x8f57, LSL #48
    SUB  X18, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x4cad, LSL #0
    MOVK  X19, #0x9e3e, LSL #16
    MOVK  X19, #0x5c1f, LSL #32
    MOVK  X19, #0x45ca, LSL #48
    SUB  X18, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xd1c6, LSL #0
    MOVK  X19, #0x31a9, LSL #16
    MOVK  X19, #0xd837, LSL #32
    MOVK  X19, #0x6fe1, LSL #48
    SUB  X18, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xb207, LSL #0
    MOVK  X19, #0xbcaf, LSL #16
    MOVK  X19, #0x34f5, LSL #32
    MOVK  X19, #0x52e7, LSL #48
    SUB  X18, X19, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xea64, LSL #0
    MOVK  X19, #0x9403, LSL #16
    MOVK  X19, #0x4119, LSL #32
    MOVK  X19, #0x5fab, LSL #48
    SUB  X18, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x838f, LSL #0
    MOVK  X19, #0x904c, LSL #16
    MOVK  X19, #0xd3e1, LSL #32
    MOVK  X19, #0xc0eb, LSL #48
    SUB  X18, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xfa19, LSL #0
    MOVK  X19, #0xc3d3, LSL #16
    MOVK  X19, #0xec15, LSL #32
    MOVK  X19, #0x892f, LSL #48
    SUB  X18, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x43d9, LSL #0
    MOVK  X19, #0xa170, LSL #16
    MOVK  X19, #0x99b8, LSL #32
    MOVK  X19, #0x8246, LSL #48
    SUB  X18, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xaa82, LSL #0
    MOVK  X19, #0xf80c, LSL #16
    MOVK  X19, #0x6a34, LSL #32
    MOVK  X19, #0x11d, LSL #48
    SUB  X18, X19, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xf063, LSL #0
    MOVK  X19, #0xce32, LSL #16
    MOVK  X19, #0x3da, LSL #32
    MOVK  X19, #0xbfbf, LSL #48
    SUB  X18, X19, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xd530, LSL #0
    MOVK  X19, #0x8034, LSL #16
    MOVK  X19, #0x48fb, LSL #32
    MOVK  X19, #0x2fc5, LSL #48
    SUB  X18, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0xfebe, LSL #0
    MOVK  X19, #0xb1df, LSL #16
    MOVK  X19, #0xdadd, LSL #32
    MOVK  X19, #0xc3de, LSL #48
    SUB  X18, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x9f96, LSL #0
    MOVK  X19, #0x26c9, LSL #16
    MOVK  X19, #0xe92b, LSL #32
    MOVK  X19, #0x43e7, LSL #48
    SUB  X18, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x62e8, LSL #0
    MOVK  X19, #0x53e7, LSL #16
    MOVK  X19, #0xfcb4, LSL #32
    MOVK  X19, #0xf552, LSL #48
    SUB  X18, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x7b13, LSL #0
    MOVK  X19, #0x2bee, LSL #16
    MOVK  X19, #0x97cd, LSL #32
    MOVK  X19, #0xf630, LSL #48
    SUB  X18, X19, X27
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x3179, LSL #0
    MOVK  X19, #0xdef9, LSL #16
    MOVK  X19, #0x4b26, LSL #32
    MOVK  X19, #0xd45f, LSL #48
    SUB  X18, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X19, #0x36c9, LSL #0
    MOVK  X19, #0xaa98, LSL #16
    MOVK  X19, #0xee6d, LSL #32
    MOVK  X19, #0x2c8d, LSL #48
    SUB  X18, X19, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MRS  X19, FPSR
    MOVZ  X18, #0x1d, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V0.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D0
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V1.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D1
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V2.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D2
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V3.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D3
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V4.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D4
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V5.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D5
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V6.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D6
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V7.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D7
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V8.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D8
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V9.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D9
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V10.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D10
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V11.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D11
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V12.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D12
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V13.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D13
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V14.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D14
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V15.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D15
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V16.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D16
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V17.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D17
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V18.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D18
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V19.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D19
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V20.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D20
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V21.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D21
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V22.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D22
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V23.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D23
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V24.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D24
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V25.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D25
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V26.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D26
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V27.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D27
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V28.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D28
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V29.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D29
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V30.D[1]
    MOVZ  X18, #0x43d9, LSL #0
    MOVK  X18, #0xa170, LSL #16
    MOVK  X18, #0x99b8, LSL #32
    MOVK  X18, #0x8246, LSL #48
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D30
    MOVZ  X18, #0x43d9, LSL #0
    MOVK  X18, #0xa170, LSL #16
    MOVK  X18, #0x99b8, LSL #32
    MOVK  X18, #0x8246, LSL #48
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, V31.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X19, D31
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
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
    FMOV  V0.D[1], X23
    FMOV  D1, X21
    FMOV  V1.D[1], X7
    FMOV  D2, X17
    FMOV  V2.D[1], X25
    FMOV  D3, X28
    FMOV  V3.D[1], X20
    FMOV  D4, X5
    FMOV  V4.D[1], X4
    FMOV  D5, X13
    FMOV  V5.D[1], X24
    FMOV  D6, X16
    FMOV  V6.D[1], X27
    FMOV  D7, X18
    FMOV  V7.D[1], X29
    FMOV  D8, X26
    FMOV  V8.D[1], X12
    FMOV  D9, X22
    FMOV  V9.D[1], X4
    FMOV  D10, X13
    FMOV  V10.D[1], X13
    FMOV  D11, X25
    FMOV  V11.D[1], X5
    FMOV  D12, X17
    FMOV  V12.D[1], X17
    FMOV  D13, X2
    FMOV  V13.D[1], X22
    FMOV  D14, X4
    FMOV  V14.D[1], X27
    FMOV  D15, X27
    FMOV  V15.D[1], X7
    FMOV  D16, X23
    FMOV  V16.D[1], X11
    FMOV  D17, X23
    FMOV  V17.D[1], X16
    FMOV  D18, X25
    FMOV  V18.D[1], X24
    FMOV  D19, X7
    FMOV  V19.D[1], X7
    FMOV  D20, X28
    FMOV  V20.D[1], X17
    FMOV  D21, X5
    FMOV  V21.D[1], X5
    FMOV  D22, X3
    FMOV  V22.D[1], X4
    FMOV  D23, X5
    FMOV  V23.D[1], X29
    FMOV  D24, X3
    FMOV  V24.D[1], X5
    FMOV  D25, X19
    FMOV  V25.D[1], X3
    FMOV  D26, X2
    FMOV  V26.D[1], X3
    FMOV  D27, X16
    FMOV  V27.D[1], X29
    FMOV  D28, X26
    FMOV  V28.D[1], X4
    FMOV  D29, X3
    FMOV  V29.D[1], X5
    FMOV  D30, X25
    FMOV  V30.D[1], X29
    FMOV  D31, X19
    FMOV  V31.D[1], X23
    MOVZ  X3, #0xa, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_6:
    FCVTZU  V18.4H, V31.4H, #4
    FCVTMS  V10.2S, V22.2S
    FRINTN  V9.4H, V30.4H
    FCVTZS  V13.4H, V26.4H
    FCVTN  V1.2S, V29.2D
    FCVTAU  V22.4H, V5.4H
    FCVTZU  V30.4H, V10.4H
    FRINTP  V25.2D, V28.2D
    FCVTZS  V1.4S, V22.4S, #28
    FCVTPU  V31.4H, V18.4H
    FCVTPU  V0.4H, V6.4H
    FCVTN2  V27.4S, V0.2D
    FCVTXN  V29.2S, V31.2D
    FRINTP  V29.8H, V29.8H
    FCVTZS V18.2D, V8.2D, #31
    FCVTPS  V18.8H, V9.8H
    FCVTNU  V27.4S, V30.4S
    FCVTNU  V11.4H, V25.4H
    FRINTM  V11.4H, V2.4H
    FRINTA  V7.4S, V18.4S
    FCVTMU  V1.4H, V7.4H
    FCVTZU  V5.2S, V13.2S
    FCVTZU  V9.2S, V13.2S, #31
    FCVTZU  V7.8H, V0.8H
    FCVTZS  V18.8H, V5.8H
    FCVTZS V31.2D, V18.2D, #2
    FCVTMU  V12.2D, V20.2D
    FCVTN  V14.4H, V29.4S
    FCVTNS  V29.2S, V1.2S
    FRINTM  V25.2D, V11.2D
    FRINTX  V27.8H, V25.8H
    FCVTMU  V8.8H, V20.8H
    FCVTL  V25.4S, V7.4H
    FCVTAS  V18.8H, V29.8H
    FCVTMS  V1.8H, V15.8H
    FCVTNU  V9.4H, V9.4H
    FCVTN  V29.2S, V1.2D
    FCVTZU  V2.4S, V12.4S, #23
    FCVTXN  V5.2S, V29.2D
    FRINTN  V5.8H, V13.8H
    FRINTX  V0.2S, V9.2S
    FRINTA  V17.8H, V23.8H
    FCVTNU  V30.4H, V16.4H
    FRINTM  V9.2S, V5.2S
    FRINTM  V15.2D, V30.2D
    FCVTNU  V21.4H, V2.4H
    FRINTM  V23.4H, V21.4H
    FCVTN2  V29.4S, V8.2D
    FRINTZ  V15.2S, V15.2S
    FCVTAS  V8.4S, V25.4S
    FRINTP  V25.2D, V29.2D
    FCVTPU  V1.4H, V20.4H
    FRINTM  V2.4S, V15.4S
    FCVTZS  V0.2D, V8.2D
    FCVTNS  V31.4H, V17.4H
    FCVTMS  V5.4H, V27.4H
    FCVTN2  V16.4S, V18.2D
    FCVTZS  V19.8H, V6.8H
    FCVTZU  V13.2S, V19.2S, #13
    FCVTPU  V20.4H, V16.4H
    FCVTMU  V27.4S, V0.4S
    FCVTPS  V17.4S, V2.4S
    FCVTZS  V30.4H, V1.4H, #8
    FCVTMS  V0.8H, V5.8H
    FRINTA  V21.8H, V29.8H
    FCVTZU V15.2D, V13.2D, #12
    FCVTNU  V8.4H, V7.4H
    FCVTXN2  V7.4S, V31.2D
    FRINTA  V13.4H, V15.4H
    FCVTAS  V5.4H, V23.4H
    FRINTX  V19.8H, V0.8H
    FCVTPS  V5.4S, V2.4S
    FRINTM  V31.4S, V8.4S
    FCVTNS  V11.8H, V30.8H
    FRINTX  V22.2D, V20.2D
    FRINTX  V2.8H, V21.8H
    FCVTPS  V21.2D, V25.2D
    FRINTN  V1.4H, V22.4H
    FCVTZU  V16.2D, V4.2D
    FCVTZS  V4.8H, V2.8H
    FCVTNS  V25.8H, V4.8H
    FRINTI  V6.4S, V25.4S
    FCVTN  V0.4H, V17.4S
    FRINTN  V11.4H, V16.4H
    FCVTNU  V18.8H, V21.8H
    FCVTL  V23.2D, V6.2S
    FCVTPU  V25.2D, V0.2D
    FCVTL2  V22.2D, V2.4S
    FRINTM  V15.2D, V6.2D
    FCVTAU  V27.8H, V5.8H
    FCVTMU  V16.2D, V18.2D
    FRINTP  V2.4S, V7.4S
    FCVTPS  V30.2S, V27.2S
    FRINTZ  V1.8H, V25.8H
    FRINTI  V5.4S, V9.4S
    FRINTX  V1.8H, V5.8H
    FCVTZS  V5.2S, V19.2S, #15
    FRINTP  V7.4H, V23.4H
    FCVTNS  V27.8H, V5.8H
    FRINTI  V17.4H, V10.4H
    FCVTPS  V19.8H, V30.8H
    FRINTX  V0.4S, V2.4S
    FRINTN  V2.4H, V15.4H
    FCVTNS  V30.2S, V13.2S
    FRINTM  V10.4S, V11.4S
    FCVTXN2  V15.4S, V1.2D
    FRINTA  V21.8H, V30.8H
    FCVTAU  V1.4H, V15.4H
    FCVTAU  V13.4S, V7.4S
    FCVTZS  V15.4H, V2.4H, #13
    FRINTI  V7.2S, V17.2S
    FRINTI  V30.2D, V25.2D
    FCVTMS  V23.2S, V8.2S
    FCVTZS  V2.8H, V23.8H
    FCVTMS  V27.4S, V7.4S
    FCVTNU  V12.4H, V2.4H
    FRINTI  V17.2S, V0.2S
    FRINTM  V23.2S, V13.2S
    FCVTMS  V7.2S, V15.2S
    FCVTMU  V25.4S, V21.4S
    FCVTAU  V13.4H, V29.4H
    FCVTNS  V21.2D, V25.2D
    FCVTPU  V26.2D, V12.2D
    FCVTZS  V1.8H, V27.8H, #5
    FRINTZ  V15.4S, V7.4S
    FCVTZS  V27.8H, V4.8H
    FCVTL2  V28.2D, V15.4S
    FCVTNU  V4.4H, V30.4H
    FCVTNS  V30.8H, V17.8H
    FRINTA  V0.4H, V13.4H
    FRINTZ  V12.8H, V28.8H
    FRINTP  V16.8H, V10.8H
    FRINTN  V11.4H, V2.4H
    FCVTPU  V7.8H, V11.8H
    FRINTM  V8.2D, V26.2D
    FRINTM  V11.2S, V30.2S
    FRINTP  V15.2D, V12.2D
    FRINTN  V25.4H, V4.4H
    FCVTZS  V20.4S, V16.4S
    FCVTZU V4.2D, V26.2D, #29
    FCVTN  V12.2S, V27.2D
    FCVTAS  V17.4H, V4.4H
    FCVTNS  V10.8H, V12.8H
    FRINTA  V14.8H, V11.8H
    FRINTP  V29.4S, V10.4S
    FCVTNU  V11.2D, V31.2D
    FCVTZU V4.2D, V2.2D, #20
    FRINTZ  V2.4H, V14.4H
    FCVTPS  V26.4H, V20.4H
    FRINTP  V26.8H, V19.8H
    FRINTM  V10.8H, V25.8H
    FRINTI  V14.8H, V29.8H
    FCVTL2  V19.4S, V1.8H
    FCVTAS  V12.8H, V7.8H
    FRINTA  V29.4H, V12.4H
    FCVTPU  V12.2S, V4.2S
    FCVTZU  V29.2S, V5.2S
    FRINTM  V1.2D, V29.2D
    FRINTX  V31.4H, V19.4H
    FRINTX  V22.2S, V14.2S
    FCVTNU  V20.2D, V10.2D
    FCVTZS V9.2D, V15.2D, #57
    FRINTX  V7.8H, V1.8H
    FCVTNU  V27.8H, V20.8H
    FCVTPS  V1.2D, V2.2D
    FRINTX  V19.4S, V11.4S
    FCVTAS  V20.4H, V23.4H
    FRINTM  V14.8H, V9.8H
    FRINTN  V15.8H, V16.8H
    FCVTNS  V10.2D, V26.2D
    FRINTI  V1.2D, V9.2D
    FCVTPU  V27.2D, V7.2D
    FRINTA  V29.4H, V4.4H
    FCVTN  V7.2S, V10.2D
    FRINTA  V7.4H, V14.4H
    FCVTAU  V14.2D, V1.2D
    FCVTZS  V2.2S, V15.2S
    FCVTL  V1.2D, V20.2S
    FRINTA  V9.4H, V2.4H
    FCVTPU  V2.8H, V1.8H
    FRINTX  V20.2D, V15.2D
    FRINTP  V16.4S, V3.4S
    FRINTZ  V5.4S, V16.4S
    FRINTA  V15.2S, V19.2S
    FCVTAS  V23.4S, V2.4S
    FRINTX  V19.8H, V29.8H
    FCVTL2  V4.2D, V27.4S
    FCVTZU  V2.2S, V7.2S, #9
    FCVTZS  V27.2S, V19.2S
    FCVTPU  V16.2S, V22.2S
    FCVTZU V1.2D, V27.2D, #23
    FCVTMU  V19.8H, V21.8H
    FCVTMU  V27.8H, V5.8H
    FCVTZU  V2.2S, V27.2S, #21
    FCVTZS  V21.4H, V1.4H
    FCVTNU  V26.2S, V21.2S
    FCVTNU  V29.4S, V2.4S
    FCVTNS  V22.8H, V4.8H
    FRINTA  V21.2S, V16.2S
    FCVTMU  V16.4S, V21.4S
    SUBS  X3, X3, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_6
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MRS  X22, FPSR
    MOVZ  X7, #0x1d, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V0.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D0
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V1.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D1
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V2.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D2
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V3.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D3
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V4.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D4
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D5
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V6.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D6
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V7.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D7
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V8.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D8
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V9.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D9
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V10.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D10
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V11.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D11
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V12.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D12
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V13.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D13
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V14.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D14
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V15.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D15
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V16.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D16
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V17.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D17
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V18.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D18
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V19.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D19
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V20.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D20
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D21
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V22.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D22
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V23.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D23
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D24
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V25.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D25
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V26.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D26
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D27
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V28.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D28
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V29.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D29
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V30.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D30
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V31.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D31
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
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
    FMOV  V0.D[1], X28
    FMOV  D1, X7
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X17
    FMOV  D3, X13
    FMOV  V3.D[1], X17
    FMOV  D4, X7
    FMOV  V4.D[1], X2
    FMOV  D5, X4
    FMOV  V5.D[1], X25
    FMOV  D6, X6
    FMOV  V6.D[1], X3
    FMOV  D7, X16
    FMOV  V7.D[1], X18
    FMOV  D8, X18
    FMOV  V8.D[1], X16
    FMOV  D9, X23
    FMOV  V9.D[1], X4
    FMOV  D10, X18
    FMOV  V10.D[1], X25
    FMOV  D11, X21
    FMOV  V11.D[1], X21
    FMOV  D12, X2
    FMOV  V12.D[1], X29
    FMOV  D13, X6
    FMOV  V13.D[1], X12
    FMOV  D14, X7
    FMOV  V14.D[1], X3
    FMOV  D15, X6
    FMOV  V15.D[1], X20
    FMOV  D16, X17
    FMOV  V16.D[1], X6
    FMOV  D17, X16
    FMOV  V17.D[1], X24
    FMOV  D18, X26
    FMOV  V18.D[1], X26
    FMOV  D19, X11
    FMOV  V19.D[1], X6
    FMOV  D20, X4
    FMOV  V20.D[1], X28
    FMOV  D21, X24
    FMOV  V21.D[1], X18
    FMOV  D22, X3
    FMOV  V22.D[1], X11
    FMOV  D23, X5
    FMOV  V23.D[1], X6
    FMOV  D24, X2
    FMOV  V24.D[1], X16
    FMOV  D25, X29
    FMOV  V25.D[1], X5
    FMOV  D26, X17
    FMOV  V26.D[1], X20
    FMOV  D27, X21
    FMOV  V27.D[1], X11
    FMOV  D28, X7
    FMOV  V28.D[1], X7
    FMOV  D29, X2
    FMOV  V29.D[1], X21
    FMOV  D30, X28
    FMOV  V30.D[1], X19
    FMOV  D31, X16
    FMOV  V31.D[1], X28
    MOVZ  X23, #0xa, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_7:
    FCVTMS  V10.2S, V11.2S
    FCVTZS V29.2D, V8.2D, #18
    FCVTPU  V27.2S, V25.2S
    FRINTP  V1.4H, V27.4H
    FRINTI  V2.4S, V10.4S
    FRINTP  V12.2S, V31.2S
    FRINTZ  V11.4H, V29.4H
    FCVTN  V7.2S, V13.2D
    FRINTZ  V29.2D, V9.2D
    FCVTNS  V1.8H, V29.8H
    FCVTL  V0.4S, V7.4H
    FCVTPU  V17.4S, V30.4S
    FCVTZS  V22.4H, V28.4H
    FCVTZS  V2.4S, V5.4S, #10
    FRINTA  V20.2S, V31.2S
    FCVTZU  V23.4H, V22.4H, #3
    FCVTMS  V25.2S, V1.2S
    FCVTAS  V6.2S, V22.2S
    FRINTI  V28.4H, V0.4H
    FCVTZU V8.2D, V18.2D, #1
    FCVTZU  V22.2S, V24.2S, #18
    FCVTL2  V13.4S, V18.8H
    FCVTZS  V10.4H, V22.4H
    FCVTMS  V29.4H, V13.4H
    FCVTZU V31.2D, V26.2D, #45
    FRINTZ  V1.8H, V20.8H
    FCVTZU  V9.2S, V12.2S, #23
    FCVTL  V7.4S, V2.4H
    FCVTZU  V0.8H, V6.8H
    FCVTXN2  V26.4S, V0.2D
    FCVTMU  V0.4H, V26.4H
    FCVTZU  V27.4S, V17.4S
    FRINTM  V6.2S, V8.2S
    FCVTL  V17.4S, V28.4H
    FCVTMS  V2.8H, V11.8H
    FCVTN  V18.2S, V2.2D
    FRINTZ  V22.8H, V3.8H
    FRINTX  V24.4S, V7.4S
    FCVTNS  V13.4S, V31.4S
    FCVTNS  V28.4S, V0.4S
    FRINTN  V3.4H, V3.4H
    FCVTXN  V8.2S, V1.2D
    FCVTMS  V0.4H, V3.4H
    FRINTI  V2.8H, V29.8H
    FRINTM  V3.8H, V25.8H
    FCVTXN  V24.2S, V30.2D
    FCVTAS  V30.4H, V24.4H
    FCVTZS  V25.2S, V29.2S, #6
    FCVTPS  V24.4H, V27.4H
    FRINTI  V28.8H, V0.8H
    FCVTN  V27.4H, V10.4S
    FRINTP  V0.2D, V8.2D
    FRINTX  V8.4H, V17.4H
    FCVTPU  V13.4H, V3.4H
    FCVTZU  V6.8H, V25.8H, #3
    FCVTZU  V3.2S, V22.2S, #7
    FCVTAS  V11.8H, V28.8H
    FCVTZS  V17.2S, V0.2S
    FRINTN  V22.8H, V8.8H
    FRINTX  V25.2D, V11.2D
    FCVTMS  V29.2S, V17.2S
    FRINTZ  V8.8H, V25.8H
    FCVTNU  V28.4S, V22.4S
    FCVTPS  V17.4S, V6.4S
    FCVTAU  V31.4H, V13.4H
    FRINTA  V7.4H, V26.4H
    FRINTM  V11.2D, V27.2D
    FCVTZU  V1.8H, V3.8H, #1
    FCVTPU  V26.4H, V28.4H
    FCVTPS  V16.2D, V14.2D
    FRINTN  V25.4H, V17.4H
    FRINTN  V6.8H, V11.8H
    FCVTZS  V22.4H, V8.4H, #10
    FCVTNU  V27.2S, V31.2S
    FCVTZU  V11.4S, V26.4S, #11
    FRINTM  V0.4S, V9.4S
    FRINTN  V8.8H, V16.8H
    FCVTNU  V9.4S, V29.4S
    FCVTPS  V19.8H, V24.8H
    FRINTI  V0.2D, V16.2D
    FCVTZS V26.2D, V27.2D, #1
    FCVTAS  V0.4S, V22.4S
    FCVTXN2  V3.4S, V1.2D
    FCVTXN2  V10.4S, V26.2D
    FRINTI  V28.4H, V11.4H
    FCVTL  V22.2D, V28.2S
    FRINTX  V16.2S, V31.2S
    FRINTX  V25.8H, V8.8H
    FCVTNU  V24.4H, V15.4H
    FCVTMS  V3.4S, V25.4S
    FRINTZ  V12.2D, V10.2D
    FCVTN2  V5.8H, V24.4S
    FCVTZU  V28.4S, V16.4S, #24
    FRINTN  V14.2S, V30.2S
    FCVTZS  V10.4S, V2.4S, #1
    FCVTZS V11.2D, V22.2D, #22
    FCVTNS  V29.8H, V13.8H
    FCVTZS  V16.8H, V14.8H
    FCVTZU  V31.2S, V28.2S, #7
    FCVTNU  V25.2S, V5.2S
    FRINTX  V22.8H, V11.8H
    FCVTZU V8.2D, V25.2D, #42
    FCVTPU  V15.4S, V8.4S
    FCVTN  V11.2S, V10.2D
    FRINTN  V13.8H, V23.8H
    FRINTN  V6.2S, V16.2S
    FCVTPU  V2.4H, V29.4H
    FRINTI  V23.8H, V21.8H
    FCVTAU  V20.8H, V6.8H
    FRINTX  V5.8H, V2.8H
    FCVTAS  V21.4H, V15.4H
    FCVTZU  V6.8H, V14.8H, #2
    FRINTX  V8.4H, V31.4H
    FRINTZ  V30.8H, V8.8H
    FCVTL  V16.4S, V20.4H
    FCVTPU  V24.2D, V6.2D
    FCVTAU  V26.4H, V5.4H
    FRINTP  V29.4H, V12.4H
    FCVTMU  V31.2S, V25.2S
    FRINTM  V0.8H, V27.8H
    FCVTZS  V25.2S, V1.2S, #24
    FCVTMS  V10.8H, V26.8H
    FCVTL  V1.4S, V22.4H
    FCVTZU  V28.2S, V13.2S, #18
    FCVTXN2  V15.4S, V21.2D
    FRINTP  V27.4H, V30.4H
    FRINTZ  V9.4H, V6.4H
    FCVTAU  V30.4H, V31.4H
    FCVTPU  V20.8H, V28.8H
    FCVTPS  V9.4H, V27.4H
    FCVTL  V8.2D, V9.2S
    FRINTP  V17.8H, V1.8H
    FCVTNS  V8.4S, V20.4S
    FCVTAS  V27.4H, V16.4H
    FRINTA  V31.8H, V10.8H
    FCVTNS  V20.2S, V5.2S
    FRINTN  V5.8H, V27.8H
    FCVTZS  V27.2D, V0.2D
    FRINTM  V16.8H, V19.8H
    FCVTZS  V2.2D, V11.2D
    FCVTZU V10.2D, V23.2D, #28
    FCVTNS  V19.4H, V8.4H
    FCVTMU  V22.4H, V19.4H
    FCVTNU  V19.8H, V18.8H
    FRINTM  V0.8H, V31.8H
    FCVTAU  V8.4H, V22.4H
    FCVTMU  V9.4H, V0.4H
    FRINTZ  V28.2D, V27.2D
    FRINTN  V18.4H, V9.4H
    FCVTPU  V1.2S, V18.2S
    FCVTZU  V16.4H, V19.4H
    FRINTN  V18.4H, V8.4H
    FCVTL2  V0.4S, V16.8H
    FCVTPU  V6.2D, V26.2D
    FCVTPU  V26.2S, V2.2S
    FCVTMU  V19.8H, V28.8H
    FCVTNS  V12.4H, V20.4H
    FCVTAU  V16.4S, V5.4S
    FCVTNS  V5.8H, V10.8H
    FCVTZU  V31.4H, V6.4H
    FCVTPS  V20.4S, V0.4S
    FCVTXN2  V6.4S, V1.2D
    FCVTZU  V2.4H, V0.4H, #12
    FCVTAU  V9.4S, V18.4S
    FCVTMS  V24.4S, V6.4S
    FCVTAS  V8.8H, V31.8H
    FCVTZU  V31.2D, V9.2D
    FCVTL  V10.4S, V9.4H
    FCVTZS  V28.4H, V14.4H, #13
    FRINTA  V18.4H, V31.4H
    FCVTNU  V1.2S, V5.2S
    FCVTAS  V31.2D, V9.2D
    FCVTAS  V5.4H, V26.4H
    FRINTI  V14.4S, V10.4S
    FCVTZU  V26.2S, V27.2S, #11
    FRINTM  V24.4H, V18.4H
    FRINTN  V6.4H, V2.4H
    FCVTAU  V9.4H, V14.4H
    FCVTMS  V21.2S, V25.2S
    FRINTI  V18.4S, V28.4S
    FCVTAS  V7.8H, V1.8H
    FCVTMS  V20.8H, V24.8H
    FRINTM  V28.2S, V20.2S
    FCVTZU  V25.8H, V26.8H
    FRINTA  V10.2S, V7.2S
    FCVTXN2  V24.4S, V28.2D
    FRINTX  V7.2D, V8.2D
    FCVTL2  V27.2D, V18.4S
    FCVTNU  V1.2D, V24.2D
    FCVTMU  V8.4H, V31.4H
    FCVTMU  V20.4S, V21.4S
    FCVTZS  V26.4H, V8.4H, #16
    FRINTI  V6.4H, V6.4H
    FCVTZU  V14.2D, V28.2D
    FCVTMU  V16.4H, V6.4H
    FCVTL  V28.4S, V7.4H
    FCVTN2  V2.8H, V1.4S
    FCVTMU  V2.2D, V9.2D
    FCVTZU  V8.8H, V2.8H, #9
    FCVTL2  V21.4S, V28.8H
    SUBS  X23, X23, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_7
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MRS  X4, FPSR
    MOVZ  X3, #0x1d, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V0.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D0
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V1.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D1
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D2
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D3
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V4.D[1]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D4
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V5.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D5
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D6
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V7.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D7
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V8.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D8
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D9
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D10
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D11
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D12
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V13.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D13
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V14.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D14
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D15
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D16
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V17.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D17
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D18
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V19.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D19
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D20
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D21
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V22.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D22
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D23
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V24.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D24
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V25.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D25
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V26.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D26
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D27
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V28.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D28
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V29.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D29
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V30.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D30
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V31.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D31
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
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
    FMOV  D1, X7
    FMOV  V1.D[1], X26
    FMOV  D2, X29
    FMOV  V2.D[1], X11
    FMOV  D3, X29
    FMOV  V3.D[1], X26
    FMOV  D4, X25
    FMOV  V4.D[1], X2
    FMOV  D5, X27
    FMOV  V5.D[1], X26
    FMOV  D6, X27
    FMOV  V6.D[1], X24
    FMOV  D7, X28
    FMOV  V7.D[1], X11
    FMOV  D8, X13
    FMOV  V8.D[1], X26
    FMOV  D9, X6
    FMOV  V9.D[1], X18
    FMOV  D10, X19
    FMOV  V10.D[1], X6
    FMOV  D11, X11
    FMOV  V11.D[1], X28
    FMOV  D12, X11
    FMOV  V12.D[1], X24
    FMOV  D13, X19
    FMOV  V13.D[1], X3
    FMOV  D14, X23
    FMOV  V14.D[1], X27
    FMOV  D15, X24
    FMOV  V15.D[1], X16
    FMOV  D16, X13
    FMOV  V16.D[1], X7
    FMOV  D17, X11
    FMOV  V17.D[1], X13
    FMOV  D18, X22
    FMOV  V18.D[1], X7
    FMOV  D19, X3
    FMOV  V19.D[1], X20
    FMOV  D20, X29
    FMOV  V20.D[1], X24
    FMOV  D21, X22
    FMOV  V21.D[1], X3
    FMOV  D22, X27
    FMOV  V22.D[1], X16
    FMOV  D23, X20
    FMOV  V23.D[1], X11
    FMOV  D24, X19
    FMOV  V24.D[1], X4
    FMOV  D25, X2
    FMOV  V25.D[1], X7
    FMOV  D26, X11
    FMOV  V26.D[1], X13
    FMOV  D27, X6
    FMOV  V27.D[1], X29
    FMOV  D28, X29
    FMOV  V28.D[1], X18
    FMOV  D29, X4
    FMOV  V29.D[1], X28
    FMOV  D30, X27
    FMOV  V30.D[1], X17
    FMOV  D31, X12
    FMOV  V31.D[1], X19
    MOVZ  X20, #0xa, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_8:
    FCVTMS  V14.2S, V26.2S
    FCVTPU  V3.4S, V29.4S
    FRINTI  V14.4H, V24.4H
    FCVTZU  V10.8H, V27.8H, #4
    FRINTZ  V0.2S, V3.2S
    FRINTZ  V31.4H, V27.4H
    FCVTXN2  V25.4S, V25.2D
    FCVTZU  V6.2S, V28.2S, #15
    FRINTA  V23.4H, V0.4H
    FCVTL  V0.2D, V31.2S
    FCVTAS  V26.4S, V15.4S
    FCVTAS  V17.2S, V14.2S
    FRINTM  V24.4S, V0.4S
    FCVTPS  V8.4S, V10.4S
    FRINTN  V14.4S, V4.4S
    FCVTZS V26.2D, V8.2D, #31
    FCVTZU  V19.8H, V17.8H, #8
    FRINTM  V26.2S, V30.2S
    FCVTMU  V1.4S, V25.4S
    FCVTPU  V12.4H, V0.4H
    FCVTL  V25.4S, V12.4H
    FCVTZS  V12.4H, V10.4H, #5
    FCVTAS  V30.8H, V19.8H
    FCVTZS  V10.2S, V23.2S, #26
    FCVTL  V23.2D, V25.2S
    FRINTN  V27.8H, V1.8H
    FCVTAU  V0.8H, V12.8H
    FCVTZU V1.2D, V8.2D, #31
    FCVTL2  V19.2D, V24.4S
    FCVTAU  V24.4S, V6.4S
    FCVTMS  V17.2D, V3.2D
    FCVTNU  V4.8H, V0.8H
    FCVTAS  V12.8H, V23.8H
    FCVTMU  V9.2S, V12.2S
    FRINTZ  V4.2D, V19.2D
    FCVTMU  V6.2S, V14.2S
    FRINTN  V20.2S, V15.2S
    FCVTPS  V4.2D, V17.2D
    FRINTA  V19.4H, V10.4H
    FCVTNU  V3.4H, V24.4H
    FRINTI  V21.4H, V1.4H
    FCVTN2  V27.8H, V1.4S
    FRINTA  V23.8H, V1.8H
    FCVTZU  V8.8H, V26.8H, #9
    FRINTP  V0.2D, V4.2D
    FRINTI  V12.8H, V6.8H
    FCVTNU  V4.4H, V21.4H
    FCVTN2  V17.4S, V23.2D
    FRINTM  V10.2D, V4.2D
    FCVTAU  V0.4H, V9.4H
    FRINTX  V24.8H, V30.8H
    FCVTZS V6.2D, V3.2D, #48
    FCVTPU  V14.2D, V3.2D
    FCVTL  V15.4S, V12.4H
    FCVTNS  V31.2S, V19.2S
    FRINTZ  V9.4H, V0.4H
    FCVTXN  V8.2S, V24.2D
    FRINTA  V31.8H, V17.8H
    FRINTP  V26.8H, V9.8H
    FCVTMU  V12.2S, V14.2S
    FCVTZU V8.2D, V20.2D, #16
    FRINTX  V21.4S, V19.4S
    FCVTZS  V31.8H, V15.8H
    FCVTZS  V15.2D, V12.2D
    FRINTM  V4.4H, V26.4H
    FCVTZU  V14.4H, V4.4H
    FCVTAU  V19.8H, V18.8H
    FCVTAU  V3.4H, V17.4H
    FRINTX  V26.4H, V15.4H
    FRINTI  V24.4H, V3.4H
    FCVTPU  V30.4S, V21.4S
    FCVTL  V27.2D, V19.2S
    FRINTP  V16.4H, V10.4H
    FCVTNS  V15.2S, V12.2S
    FCVTN  V5.2S, V26.2D
    FRINTX  V12.4S, V30.4S
    FCVTNS  V14.4H, V6.4H
    FRINTN  V9.2D, V12.2D
    FCVTNS  V30.4S, V24.4S
    FRINTP  V17.4S, V5.4S
    FRINTA  V24.8H, V9.8H
    FCVTL  V12.4S, V15.4H
    FCVTZS  V21.8H, V14.8H, #7
    FCVTN2  V5.8H, V6.4S
    FCVTAU  V9.4H, V24.4H
    FCVTAU  V6.8H, V3.8H
    FRINTN  V10.2D, V30.2D
    FRINTX  V20.4S, V5.4S
    FCVTN  V27.4H, V31.4S
    FCVTMS  V26.4S, V7.4S
    FCVTAU  V8.4S, V16.4S
    FCVTNU  V31.8H, V26.8H
    FCVTZS  V27.4S, V1.4S, #21
    FCVTAS  V29.2D, V21.2D
    FCVTZS V7.2D, V9.2D, #63
    FCVTZU  V16.8H, V25.8H, #2
    FCVTZS  V25.4S, V10.4S, #3
    FCVTZS  V19.4S, V27.4S, #11
    FCVTXN2  V2.4S, V29.2D
    FCVTZS  V16.8H, V17.8H
    FCVTZU  V5.4S, V8.4S
    FCVTMU  V1.8H, V19.8H
    FCVTZU  V14.4H, V1.4H, #12
    FCVTMU  V24.4H, V2.4H
    FRINTP  V29.2S, V3.2S
    FCVTXN  V8.2S, V21.2D
    FCVTZU  V19.2D, V14.2D
    FCVTZS  V21.8H, V16.8H, #3
    FCVTZU  V10.4H, V25.4H
    FRINTN  V5.2S, V19.2S
    FCVTNU  V14.8H, V7.8H
    FCVTXN2  V9.4S, V19.2D
    FCVTAS  V19.2S, V27.2S
    FRINTZ  V26.4H, V24.4H
    FCVTXN  V16.2S, V8.2D
    FRINTM  V24.8H, V24.8H
    FCVTAS  V1.4H, V24.4H
    FCVTNS  V7.4S, V16.4S
    FCVTAU  V8.2S, V31.2S
    FCVTZU  V25.8H, V19.8H
    FRINTM  V27.4S, V2.4S
    FCVTZU  V17.8H, V25.8H
    FCVTL  V18.4S, V10.4H
    FCVTL2  V3.4S, V17.8H
    FRINTN  V29.2D, V5.2D
    FRINTN  V24.4H, V27.4H
    FCVTXN  V21.2S, V29.2D
    FCVTNS  V25.2S, V18.2S
    FCVTXN2  V19.4S, V1.2D
    FRINTN  V1.2S, V26.2S
    FCVTN  V18.4H, V19.4S
    FCVTAU  V9.8H, V18.8H
    FRINTP  V16.4S, V9.4S
    FCVTMS  V27.4H, V25.4H
    FCVTZU  V25.4H, V7.4H
    FRINTI  V19.4H, V31.4H
    FCVTZS  V29.4S, V19.4S, #30
    FRINTP  V10.8H, V15.8H
    FCVTZU  V11.8H, V21.8H
    FCVTZU  V17.4S, V27.4S, #8
    FCVTZU V19.2D, V3.2D, #47
    FCVTNU  V26.8H, V10.8H
    FRINTZ  V15.2S, V29.2S
    FCVTZS  V11.8H, V16.8H, #8
    FCVTNS  V10.2D, V24.2D
    FCVTZS  V3.8H, V10.8H, #12
    FCVTZU  V18.8H, V2.8H
    FCVTPS  V2.2D, V8.2D
    FCVTNU  V27.8H, V26.8H
    FCVTZU  V21.2S, V11.2S, #14
    FRINTM  V16.2S, V25.2S
    FCVTAU  V26.2D, V21.2D
    FCVTPS  V7.8H, V29.8H
    FCVTZU V25.2D, V17.2D, #29
    FCVTZS  V19.2S, V2.2S, #24
    FCVTNS  V24.4H, V28.4H
    FRINTN  V17.2S, V15.2S
    FCVTZS  V21.4S, V17.4S
    FCVTZU  V10.8H, V3.8H, #15
    FCVTNS  V29.4S, V10.4S
    FRINTM  V20.2D, V27.2D
    FCVTPU  V3.2S, V26.2S
    FRINTA  V18.8H, V24.8H
    FRINTP  V8.4H, V20.4H
    FRINTX  V31.4H, V16.4H
    FCVTMU  V24.4H, V18.4H
    FRINTP  V17.8H, V24.8H
    FCVTXN2  V16.4S, V19.2D
    FCVTAU  V10.4S, V21.4S
    FRINTA  V21.2S, V8.2S
    FCVTL2  V8.2D, V7.4S
    FRINTA  V19.2D, V17.2D
    FCVTZU  V16.4H, V13.4H
    FCVTPU  V15.4H, V8.4H
    FCVTZU  V11.2D, V16.2D
    FRINTP  V14.8H, V15.8H
    FCVTMS  V0.4H, V3.4H
    FCVTMU  V5.4H, V29.4H
    FCVTXN  V26.2S, V4.2D
    FCVTAS  V7.4H, V21.4H
    FRINTN  V21.4H, V1.4H
    FCVTXN2  V16.4S, V31.2D
    FRINTN  V13.2S, V0.2S
    FCVTMU  V1.4H, V30.4H
    FCVTMS  V29.4S, V14.4S
    FRINTZ  V24.8H, V24.8H
    FRINTP  V3.4H, V1.4H
    FCVTNU  V17.2S, V7.2S
    FCVTMU  V8.4H, V0.4H
    FRINTM  V31.2D, V24.2D
    FCVTAS  V22.4H, V12.4H
    FCVTNU  V0.4S, V5.4S
    FCVTZU V4.2D, V0.2D, #43
    FCVTXN  V7.2S, V10.2D
    FCVTL2  V30.4S, V16.8H
    FRINTX  V15.2S, V8.2S
    FCVTL  V25.4S, V22.4H
    FCVTMS  V0.8H, V13.8H
    FCVTN2  V1.8H, V25.4S
    FCVTNS  V22.8H, V4.8H
    SUBS  X20, X20, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_8
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X24, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X24, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X24, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X24, X22, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X24, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X24, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X24, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X24, X22, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X24, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X24, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X24, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X24, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X24, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X24, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X24, X22, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X24, X22, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X24, X22, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X24, X22, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X24, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X24, X22, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MRS  X22, FPSR
    MOVZ  X24, #0x1d, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V0.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D0
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V1.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D1
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V2.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D2
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V3.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D3
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D4
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D5
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D6
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V7.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D7
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V8.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D8
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V9.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D9
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D10
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V11.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D11
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V12.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D12
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D13
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V14.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D14
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D15
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V16.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D16
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D17
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D18
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D19
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V20.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D20
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V21.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D21
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V22.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D22
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D23
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V24.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D24
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V25.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D25
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V26.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D26
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D27
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V28.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D28
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D29
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V30.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D30
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V31.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D31
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
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
    FMOV  D0, X25
    FMOV  V0.D[1], X28
    FMOV  D1, X26
    FMOV  V1.D[1], X11
    FMOV  D2, X20
    FMOV  V2.D[1], X27
    FMOV  D3, X4
    FMOV  V3.D[1], X29
    FMOV  D4, X18
    FMOV  V4.D[1], X12
    FMOV  D5, X20
    FMOV  V5.D[1], X7
    FMOV  D6, X27
    FMOV  V6.D[1], X21
    FMOV  D7, X6
    FMOV  V7.D[1], X2
    FMOV  D8, X17
    FMOV  V8.D[1], X4
    FMOV  D9, X21
    FMOV  V9.D[1], X28
    FMOV  D10, X3
    FMOV  V10.D[1], X5
    FMOV  D11, X5
    FMOV  V11.D[1], X26
    FMOV  D12, X21
    FMOV  V12.D[1], X23
    FMOV  D13, X2
    FMOV  V13.D[1], X12
    FMOV  D14, X29
    FMOV  V14.D[1], X19
    FMOV  D15, X21
    FMOV  V15.D[1], X24
    FMOV  D16, X17
    FMOV  V16.D[1], X17
    FMOV  D17, X3
    FMOV  V17.D[1], X28
    FMOV  D18, X28
    FMOV  V18.D[1], X6
    FMOV  D19, X24
    FMOV  V19.D[1], X20
    FMOV  D20, X5
    FMOV  V20.D[1], X20
    FMOV  D21, X7
    FMOV  V21.D[1], X16
    FMOV  D22, X12
    FMOV  V22.D[1], X5
    FMOV  D23, X28
    FMOV  V23.D[1], X28
    FMOV  D24, X23
    FMOV  V24.D[1], X20
    FMOV  D25, X21
    FMOV  V25.D[1], X6
    FMOV  D26, X25
    FMOV  V26.D[1], X26
    FMOV  D27, X11
    FMOV  V27.D[1], X7
    FMOV  D28, X24
    FMOV  V28.D[1], X27
    FMOV  D29, X11
    FMOV  V29.D[1], X28
    FMOV  D30, X18
    FMOV  V30.D[1], X16
    FMOV  D31, X26
    FMOV  V31.D[1], X16
    MOVZ  X3, #0xa, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_9:
    FRINTZ  V17.4H, V29.4H
    FCVTXN  V20.2S, V27.2D
    FCVTAU  V22.4S, V23.4S
    FCVTNU  V26.2D, V31.2D
    FCVTMU  V7.2S, V26.2S
    FCVTAU  V18.4S, V7.4S
    FCVTNS  V27.8H, V21.8H
    FCVTZU  V27.4H, V21.4H
    FCVTZU  V22.2D, V28.2D
    FRINTI  V21.4S, V30.4S
    FCVTZU  V2.2S, V18.2S
    FCVTPS  V2.4H, V21.4H
    FCVTZS  V13.4H, V27.4H
    FRINTM  V7.4S, V11.4S
    FCVTAU  V4.2D, V17.2D
    FCVTZU V19.2D, V4.2D, #22
    FCVTZS  V13.4H, V13.4H
    FCVTMU  V3.4S, V13.4S
    FRINTM  V4.4S, V23.4S
    FCVTPS  V4.4H, V3.4H
    FCVTZU  V21.2D, V2.2D
    FRINTX  V31.8H, V7.8H
    FCVTPS  V10.2S, V31.2S
    FCVTZU  V17.2S, V20.2S, #11
    FCVTAU  V21.8H, V21.8H
    FCVTN  V2.2S, V21.2D
    FCVTPS  V27.4H, V2.4H
    FRINTI  V21.4S, V25.4S
    FCVTZU  V3.4S, V13.4S, #16
    FCVTPU  V7.4H, V2.4H
    FCVTZU V11.2D, V29.2D, #64
    FRINTN  V25.4H, V17.4H
    FCVTN2  V28.8H, V21.4S
    FRINTX  V26.2D, V19.2D
    FCVTAS  V23.4S, V7.4S
    FRINTA  V29.2S, V23.2S
    FCVTNS  V26.2S, V8.2S
    FCVTZU  V18.4H, V28.4H
    FRINTA  V28.2S, V0.2S
    FCVTAU  V8.2S, V3.2S
    FRINTN  V13.4H, V28.4H
    FRINTI  V27.8H, V18.8H
    FCVTMS  V3.4H, V29.4H
    FCVTMS  V2.2S, V4.2S
    FRINTA  V18.2D, V27.2D
    FCVTPU  V17.8H, V11.8H
    FCVTNS  V5.2D, V26.2D
    FRINTN  V20.4H, V17.4H
    FCVTAU  V28.4S, V3.4S
    FRINTP  V21.4H, V13.4H
    FCVTZS  V19.8H, V21.8H
    FRINTX  V21.8H, V5.8H
    FRINTM  V27.2S, V20.2S
    FCVTXN  V4.2S, V6.2D
    FCVTPU  V9.8H, V9.8H
    FCVTNU  V20.8H, V28.8H
    FCVTZU  V23.2D, V21.2D
    FRINTM  V28.4H, V9.4H
    FCVTZS V0.2D, V29.2D, #31
    FCVTMU  V17.8H, V0.8H
    FRINTI  V3.2S, V4.2S
    FCVTL  V0.2D, V19.2S
    FRINTZ  V1.8H, V23.8H
    FCVTXN  V19.2S, V20.2D
    FRINTM  V20.2D, V2.2D
    FRINTA  V29.4H, V26.4H
    FCVTMU  V6.2D, V1.2D
    FRINTA  V21.4H, V20.4H
    FCVTMU  V11.4S, V18.4S
    FCVTAU  V26.2S, V29.2S
    FCVTMU  V18.2D, V28.2D
    FCVTXN  V29.2S, V15.2D
    FCVTZS V28.2D, V18.2D, #37
    FRINTX  V20.2S, V17.2S
    FCVTZS  V13.4S, V28.4S, #30
    FCVTMS  V5.2D, V6.2D
    FRINTP  V19.2D, V11.2D
    FCVTNS  V15.4H, V13.4H
    FCVTAU  V23.8H, V0.8H
    FCVTMU  V11.2S, V15.2S
    FCVTL  V17.4S, V3.4H
    FRINTP  V2.2D, V23.2D
    FCVTNS  V4.2S, V26.2S
    FCVTZU  V1.8H, V2.8H
    FRINTM  V18.4S, V13.4S
    FRINTZ  V11.4H, V5.4H
    FCVTPU  V23.4H, V19.4H
    FCVTZS  V13.8H, V20.8H
    FRINTP  V26.4H, V4.4H
    FCVTXN  V19.2S, V18.2D
    FCVTZS V14.2D, V13.2D, #8
    FCVTNU  V30.2S, V14.2S
    FCVTNS  V15.2D, V20.2D
    FCVTXN2  V5.4S, V30.2D
    FCVTAU  V0.8H, V5.8H
    FRINTP  V4.4S, V4.4S
    FRINTI  V3.2D, V17.2D
    FCVTZS V17.2D, V0.2D, #7
    FCVTPS  V22.4H, V1.4H
    FRINTN  V14.4S, V15.4S
    FCVTZU  V21.4H, V14.4H
    FCVTZU  V20.8H, V21.8H, #8
    FCVTPS  V13.4S, V11.4S
    FCVTNU  V2.4S, V3.4S
    FRINTA  V7.4S, V17.4S
    FRINTM  V25.8H, V9.8H
    FCVTZS V15.2D, V7.2D, #56
    FRINTM  V25.4H, V6.4H
    FRINTA  V18.8H, V19.8H
    FRINTM  V9.2S, V17.2S
    FCVTMS  V31.2S, V24.2S
    FCVTPU  V0.2S, V20.2S
    FCVTZU  V19.8H, V31.8H, #5
    FCVTMU  V5.8H, V9.8H
    FCVTZU  V11.4S, V15.4S, #5
    FCVTNS  V14.2D, V22.2D
    FCVTMS  V22.2D, V14.2D
    FCVTZS  V14.4S, V0.4S
    FRINTM  V24.8H, V30.8H
    FCVTZU  V30.8H, V23.8H
    FCVTXN2  V15.4S, V22.2D
    FCVTXN  V7.2S, V11.2D
    FCVTL2  V11.2D, V25.4S
    FCVTAU  V0.2S, V5.2S
    FCVTN  V9.2S, V11.2D
    FRINTX  V23.2S, V7.2S
    FCVTMU  V22.2S, V15.2S
    FRINTA  V17.8H, V30.8H
    FRINTX  V11.2D, V0.2D
    FCVTZU  V31.4S, V30.4S, #2
    FCVTAU  V15.4H, V4.4H
    FCVTAU  V25.2D, V19.2D
    FRINTZ  V19.8H, V25.8H
    FCVTZS  V30.2S, V11.2S, #5
    FCVTMU  V4.8H, V9.8H
    FCVTAS  V6.4H, V30.4H
    FRINTP  V11.8H, V4.8H
    FCVTL  V7.2D, V31.2S
    FCVTZS V9.2D, V15.2D, #39
    FCVTXN  V21.2S, V7.2D
    FRINTX  V3.2S, V23.2S
    FCVTZS V5.2D, V14.2D, #41
    FRINTI  V0.8H, V9.8H
    FCVTAU  V3.2D, V12.2D
    FCVTMS  V12.4H, V5.4H
    FCVTPS  V21.2S, V24.2S
    FRINTI  V24.8H, V11.8H
    FCVTMU  V4.8H, V24.8H
    FCVTAU  V24.4H, V8.4H
    FRINTZ  V1.4H, V21.4H
    FRINTI  V11.2D, V17.2D
    FCVTMS  V31.2S, V13.2S
    FRINTI  V11.4H, V6.4H
    FRINTM  V8.4S, V24.4S
    FCVTXN  V21.2S, V29.2D
    FCVTAS  V24.8H, V5.8H
    FCVTZS  V12.4H, V15.4H
    FCVTZS V13.2D, V21.2D, #44
    FRINTA  V17.8H, V19.8H
    FCVTPU  V23.2D, V4.2D
    FCVTN2  V17.4S, V1.2D
    FRINTI  V9.4S, V2.4S
    FRINTA  V9.4H, V28.4H
    FCVTAU  V15.8H, V11.8H
    FRINTN  V0.4H, V1.4H
    FCVTAU  V28.2S, V13.2S
    FCVTXN  V19.2S, V28.2D
    FCVTPS  V21.4H, V17.4H
    FCVTN  V24.2S, V8.2D
    FCVTAS  V12.2S, V9.2S
    FCVTZU  V1.2D, V15.2D
    FCVTAS  V9.2S, V31.2S
    FCVTZS  V17.4H, V27.4H
    FCVTN2  V29.4S, V12.2D
    FCVTN2  V0.4S, V10.2D
    FCVTN  V15.4H, V21.4S
    FCVTMS  V2.4S, V29.4S
    FCVTNS  V4.2S, V23.2S
    FCVTZU  V21.4S, V15.4S
    FCVTXN  V27.2S, V24.2D
    FCVTAS  V29.8H, V19.8H
    FCVTMU  V11.2S, V17.2S
    FCVTPS  V17.2D, V25.2D
    FRINTP  V28.4S, V11.4S
    FRINTA  V5.8H, V4.8H
    FRINTZ  V23.4S, V2.4S
    FCVTNU  V11.2D, V5.2D
    FRINTA  V19.8H, V1.8H
    FRINTA  V5.4H, V28.4H
    FCVTNU  V8.8H, V9.8H
    FCVTPU  V12.4H, V30.4H
    FCVTNS  V13.8H, V0.8H
    FRINTZ  V3.8H, V23.8H
    FRINTN  V28.4H, V23.4H
    FCVTNU  V5.8H, V20.8H
    FCVTZS  V4.2S, V17.2S, #16
    FCVTPU  V17.8H, V21.8H
    FCVTZU V30.2D, V8.2D, #15
    FCVTXN2  V15.4S, V4.2D
    FRINTI  V2.8H, V19.8H
    SUBS  X3, X3, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_9
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X6, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X6, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X6, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X6, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X6, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X6, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X6, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X6, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X6, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X6, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X6, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X6, X25, X19
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X6, X25, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X6, X25, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X6, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X6, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X6, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X6, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X6, X25, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X6, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MRS  X25, FPSR
    MOVZ  X6, #0x1d, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V0.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D0
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V1.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D1
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V2.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D2
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V3.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D3
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V4.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D4
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V5.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D5
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V6.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D6
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V7.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D7
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V8.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D8
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V9.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D9
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V10.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D10
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V11.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D11
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V12.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D12
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V13.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D13
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V14.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D14
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V15.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D15
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V16.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D16
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V17.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D17
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V18.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D18
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V19.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D19
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V20.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D20
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V21.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D21
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V22.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D22
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V23.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D23
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V24.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D24
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V25.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D25
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V26.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D26
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V27.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D27
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V28.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D28
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V29.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D29
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V30.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D30
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V31.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D31
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X2, #0x30dd, LSL #0
    MOVK  X2, #0x8284, LSL #16
    MOVK  X2, #0x2298, LSL #32
    MOVK  X2, #0x92e6, LSL #48
    MOVZ  X3, #0xca4c, LSL #0
    MOVK  X3, #0x6ef6, LSL #16
    MOVK  X3, #0x9706, LSL #32
    MOVK  X3, #0x7046, LSL #48
    MOVZ  X4, #0xa0b, LSL #0
    MOVK  X4, #0xc4c3, LSL #16
    MOVK  X4, #0x2dcf, LSL #32
    MOVK  X4, #0xeaec, LSL #48
    MOVZ  X5, #0x1f8d, LSL #0
    MOVK  X5, #0x4f46, LSL #16
    MOVK  X5, #0x2f93, LSL #32
    MOVK  X5, #0x1cb6, LSL #48
    MOVZ  X6, #0x8d83, LSL #0
    MOVK  X6, #0xc836, LSL #16
    MOVK  X6, #0x8775, LSL #32
    MOVK  X6, #0xc0ab, LSL #48
    MOVZ  X7, #0xa1b2, LSL #0
    MOVK  X7, #0xf777, LSL #16
    MOVK  X7, #0xa17e, LSL #32
    MOVK  X7, #0xa357, LSL #48
    MOVZ  X11, #0xb790, LSL #0
    MOVK  X11, #0xa308, LSL #16
    MOVK  X11, #0xd6aa, LSL #32
    MOVK  X11, #0xe4f1, LSL #48
    MOVZ  X12, #0x90bc, LSL #0
    MOVK  X12, #0x6f21, LSL #16
    MOVK  X12, #0x4427, LSL #32
    MOVK  X12, #0xcf54, LSL #48
    MOVZ  X13, #0x2053, LSL #0
    MOVK  X13, #0x2f31, LSL #16
    MOVK  X13, #0x60fa, LSL #32
    MOVK  X13, #0xe290, LSL #48
    MOVZ  X16, #0xc715, LSL #0
    MOVK  X16, #0xa7cf, LSL #16
    MOVK  X16, #0xb5b, LSL #32
    MOVK  X16, #0xa2c1, LSL #48
    MOVZ  X17, #0xd767, LSL #0
    MOVK  X17, #0xc780, LSL #16
    MOVK  X17, #0x3ce3, LSL #32
    MOVK  X17, #0x28fa, LSL #48
    MOVZ  X18, #0x7cb6, LSL #0
    MOVK  X18, #0xe78d, LSL #16
    MOVK  X18, #0xd951, LSL #32
    MOVK  X18, #0xcf22, LSL #48
    MOVZ  X19, #0x43c7, LSL #0
    MOVK  X19, #0xbac3, LSL #16
    MOVK  X19, #0x2b56, LSL #32
    MOVK  X19, #0x3206, LSL #48
    MOVZ  X20, #0x7053, LSL #0
    MOVK  X20, #0x61a9, LSL #16
    MOVK  X20, #0x86cf, LSL #32
    MOVK  X20, #0xbb93, LSL #48
    MOVZ  X21, #0x883d, LSL #0
    MOVK  X21, #0xa377, LSL #16
    MOVK  X21, #0xc37, LSL #32
    MOVK  X21, #0x21ea, LSL #48
    MOVZ  X22, #0x54b4, LSL #0
    MOVK  X22, #0xf5b1, LSL #16
    MOVK  X22, #0xfe58, LSL #32
    MOVK  X22, #0x52b0, LSL #48
    MOVZ  X23, #0xac3e, LSL #0
    MOVK  X23, #0x713f, LSL #16
    MOVK  X23, #0x685c, LSL #32
    MOVK  X23, #0x7559, LSL #48
    MOVZ  X24, #0x263c, LSL #0
    MOVK  X24, #0xde97, LSL #16
    MOVK  X24, #0x7137, LSL #32
    MOVK  X24, #0xbb9, LSL #48
    MOVZ  X25, #0x48fd, LSL #0
    MOVK  X25, #0x70d, LSL #16
    MOVK  X25, #0x25ef, LSL #32
    MOVK  X25, #0xdfcd, LSL #48
    MOVZ  X26, #0x24c1, LSL #0
    MOVK  X26, #0xb70f, LSL #16
    MOVK  X26, #0x9b4d, LSL #32
    MOVK  X26, #0x7bb, LSL #48
    MOVZ  X27, #0xb745, LSL #0
    MOVK  X27, #0x20e7, LSL #16
    MOVK  X27, #0x72ed, LSL #32
    MOVK  X27, #0xe74f, LSL #48
    MOVZ  X28, #0x5294, LSL #0
    MOVK  X28, #0x8386, LSL #16
    MOVK  X28, #0x8d13, LSL #32
    MOVK  X28, #0x173e, LSL #48
    MOVZ  X29, #0x6258, LSL #0
    MOVK  X29, #0x2cc1, LSL #16
    MOVK  X29, #0x33be, LSL #32
    MOVK  X29, #0xd393, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X11
    FMOV  D1, X23
    FMOV  V1.D[1], X25
    FMOV  D2, X29
    FMOV  V2.D[1], X28
    FMOV  D3, X26
    FMOV  V3.D[1], X2
    FMOV  D4, X27
    FMOV  V4.D[1], X24
    FMOV  D5, X5
    FMOV  V5.D[1], X19
    FMOV  D6, X20
    FMOV  V6.D[1], X23
    FMOV  D7, X11
    FMOV  V7.D[1], X25
    FMOV  D8, X26
    FMOV  V8.D[1], X26
    FMOV  D9, X21
    FMOV  V9.D[1], X13
    FMOV  D10, X23
    FMOV  V10.D[1], X16
    FMOV  D11, X28
    FMOV  V11.D[1], X12
    FMOV  D12, X7
    FMOV  V12.D[1], X21
    FMOV  D13, X16
    FMOV  V13.D[1], X18
    FMOV  D14, X27
    FMOV  V14.D[1], X25
    FMOV  D15, X18
    FMOV  V15.D[1], X22
    FMOV  D16, X12
    FMOV  V16.D[1], X21
    FMOV  D17, X25
    FMOV  V17.D[1], X4
    FMOV  D18, X22
    FMOV  V18.D[1], X23
    FMOV  D19, X4
    FMOV  V19.D[1], X11
    FMOV  D20, X11
    FMOV  V20.D[1], X12
    FMOV  D21, X3
    FMOV  V21.D[1], X25
    FMOV  D22, X19
    FMOV  V22.D[1], X21
    FMOV  D23, X16
    FMOV  V23.D[1], X11
    FMOV  D24, X19
    FMOV  V24.D[1], X7
    FMOV  D25, X3
    FMOV  V25.D[1], X29
    FMOV  D26, X26
    FMOV  V26.D[1], X19
    FMOV  D27, X12
    FMOV  V27.D[1], X6
    FMOV  D28, X28
    FMOV  V28.D[1], X27
    FMOV  D29, X19
    FMOV  V29.D[1], X4
    FMOV  D30, X24
    FMOV  V30.D[1], X12
    FMOV  D31, X4
    FMOV  V31.D[1], X26
    MOVZ  X25, #0xa, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_10:
    FCVTMU  V31.2S, V27.2S
    FCVTZS  V8.4H, V31.4H
    FRINTI  V11.8H, V26.8H
    FRINTX  V19.2S, V0.2S
    FCVTZU  V14.8H, V7.8H, #15
    FCVTZS V2.2D, V11.2D, #61
    FCVTNS  V23.2D, V26.2D
    FRINTM  V1.2S, V21.2S
    FCVTZU  V2.4H, V1.4H, #5
    FCVTMU  V26.8H, V6.8H
    FRINTZ  V29.4S, V22.4S
    FRINTZ  V23.4S, V25.4S
    FRINTM  V10.4H, V28.4H
    FRINTM  V17.4S, V14.4S
    FRINTA  V10.4S, V10.4S
    FCVTPU  V4.2D, V19.2D
    FCVTZS  V27.2D, V24.2D
    FRINTP  V8.4H, V4.4H
    FCVTZU V26.2D, V2.2D, #38
    FRINTX  V21.8H, V10.8H
    FCVTAS  V2.2D, V30.2D
    FCVTAS  V8.2S, V12.2S
    FCVTAU  V24.8H, V26.8H
    FCVTZS  V1.4S, V2.4S, #11
    FCVTZU  V26.4S, V19.4S, #2
    FCVTAU  V14.2D, V24.2D
    FRINTP  V6.4S, V26.4S
    FRINTP  V24.2S, V17.2S
    FCVTPU  V26.2S, V14.2S
    FRINTN  V14.4S, V1.4S
    FCVTAU  V10.2S, V2.2S
    FCVTZS  V2.4H, V21.4H, #5
    FCVTZS  V30.2D, V0.2D
    FCVTMU  V19.8H, V30.8H
    FCVTL  V21.4S, V7.4H
    FRINTP  V25.4S, V27.4S
    FCVTZS  V30.4H, V21.4H, #3
    FCVTAU  V27.8H, V3.8H
    FCVTL  V7.4S, V10.4H
    FCVTAU  V25.4H, V6.4H
    FRINTZ  V3.2D, V24.2D
    FRINTX  V0.2D, V29.2D
    FRINTA  V20.2D, V27.2D
    FCVTZS  V21.8H, V21.8H
    FCVTXN2  V22.4S, V26.2D
    FRINTP  V29.2D, V22.2D
    FCVTNS  V24.8H, V0.8H
    FRINTX  V6.4H, V24.4H
    FCVTZU  V1.4S, V22.4S, #23
    FCVTN2  V27.4S, V21.2D
    FRINTP  V21.4H, V6.4H
    FCVTPS  V22.4H, V29.4H
    FCVTPU  V6.4H, V27.4H
    FCVTMU  V29.8H, V4.8H
    FCVTPU  V0.4H, V4.4H
    FRINTX  V19.4S, V6.4S
    FCVTZS  V8.4S, V25.4S, #30
    FCVTZS  V21.4H, V1.4H, #1
    FCVTL  V6.2D, V3.2S
    FCVTNU  V17.4H, V0.4H
    FCVTZU  V1.4S, V8.4S, #18
    FCVTZS  V27.4S, V6.4S
    FRINTZ  V0.8H, V19.8H
    FCVTZU  V26.4H, V17.4H
    FCVTAS  V30.2S, V26.2S
    FCVTXN  V10.2S, V29.2D
    FRINTA  V25.2D, V13.2D
    FRINTZ  V3.4S, V0.4S
    FCVTPU  V4.4H, V1.4H
    FCVTZU  V1.4S, V7.4S, #21
    FCVTZS V26.2D, V22.2D, #34
    FCVTZU  V17.4H, V10.4H
    FCVTNS  V22.4S, V3.4S
    FCVTL  V19.2D, V7.2S
    FCVTZU V8.2D, V2.2D, #26
    FCVTZU  V21.2S, V25.2S, #22
    FCVTL  V8.4S, V21.4H
    FCVTNU  V6.8H, V4.8H
    FRINTP  V3.4S, V1.4S
    FCVTZS  V21.4H, V19.4H, #6
    FCVTAS  V1.2S, V26.2S
    FRINTM  V2.2D, V3.2D
    FCVTZS  V18.4H, V2.4H
    FCVTXN2  V0.4S, V21.2D
    FCVTZS  V10.8H, V17.8H, #1
    FRINTM  V6.4S, V6.4S
    FRINTP  V26.8H, V30.8H
    FCVTNU  V4.8H, V18.8H
    FCVTN  V17.2S, V29.2D
    FRINTX  V25.4H, V10.4H
    FCVTNS  V28.2D, V22.2D
    FRINTN  V22.8H, V28.8H
    FCVTPS  V9.8H, V4.8H
    FRINTA  V19.4H, V1.4H
    FCVTN2  V28.8H, V8.4S
    FRINTA  V25.2D, V6.2D
    FCVTPU  V4.4H, V17.4H
    FCVTMU  V3.4S, V22.4S
    FRINTI  V22.4S, V19.4S
    FCVTZS  V17.2S, V4.2S, #25
    FRINTA  V6.2D, V26.2D
    FCVTMS  V10.4H, V17.4H
    FCVTNS  V1.4H, V0.4H
    FCVTMS  V30.8H, V10.8H
    FCVTZU  V29.2S, V27.2S
    FRINTA  V18.4S, V22.4S
    FCVTZU  V26.8H, V3.8H
    FCVTZU  V17.4H, V30.4H, #9
    FCVTL  V27.2D, V29.2S
    FRINTM  V8.2D, V0.2D
    FCVTPS  V29.2S, V26.2S
    FCVTL  V19.4S, V12.4H
    FRINTI  V7.4H, V17.4H
    FRINTA  V21.4S, V28.4S
    FCVTXN2  V12.4S, V1.2D
    FCVTN  V26.4H, V25.4S
    FCVTZS  V1.4S, V21.4S, #20
    FCVTMS  V25.4H, V20.4H
    FRINTM  V27.2S, V19.2S
    FRINTX  V3.4S, V6.4S
    FRINTX  V19.4S, V7.4S
    FCVTZS V17.2D, V9.2D, #19
    FCVTNU  V3.4H, V19.4H
    FRINTA  V20.4S, V26.4S
    FCVTNU  V26.2D, V27.2D
    FRINTX  V21.4H, V21.4H
    FRINTN  V29.4S, V25.4S
    FCVTAU  V9.2S, V4.2S
    FRINTN  V7.2D, V21.2D
    FRINTP  V9.2D, V1.2D
    FCVTL  V1.2D, V20.2S
    FRINTA  V30.8H, V7.8H
    FCVTMS  V22.4S, V26.4S
    FRINTP  V7.2S, V3.2S
    FCVTAS  V3.2S, V22.2S
    FCVTL  V6.2D, V28.2S
    FRINTN  V2.2D, V17.2D
    FCVTMU  V21.8H, V30.8H
    FCVTZS  V20.4H, V6.4H
    FRINTA  V17.8H, V21.8H
    FCVTAU  V19.2S, V9.2S
    FRINTA  V4.2S, V30.2S
    FCVTNS  V28.8H, V20.8H
    FRINTM  V21.8H, V2.8H
    FCVTPU  V2.2D, V26.2D
    FCVTAU  V25.4H, V4.4H
    FCVTN2  V6.4S, V2.2D
    FCVTL  V8.2D, V9.2S
    FCVTAU  V20.2S, V21.2S
    FRINTM  V21.8H, V24.8H
    FCVTMU  V4.4S, V6.4S
    FRINTA  V30.8H, V7.8H
    FCVTZS  V29.8H, V29.8H, #10
    FCVTPU  V7.2S, V13.2S
    FCVTMU  V24.2S, V4.2S
    FCVTNS  V13.8H, V29.8H
    FCVTZU  V25.4H, V3.4H, #13
    FRINTA  V11.2S, V30.2S
    FCVTZU  V21.2S, V24.2S
    FRINTZ  V6.4S, V20.4S
    FCVTZS  V30.8H, V11.8H
    FRINTA  V29.2D, V28.2D
    FCVTZU V2.2D, V30.2D, #59
    FCVTAS  V9.8H, V16.8H
    FCVTNU  V24.4S, V9.4S
    FCVTZU  V30.2D, V25.2D
    FCVTNS  V16.4S, V8.4S
    FRINTI  V20.4H, V16.4H
    FCVTZS  V26.2S, V24.2S
    FCVTPS  V25.8H, V29.8H
    FRINTI  V19.4H, V30.4H
    FCVTMU  V25.4H, V26.4H
    FCVTNU  V13.4H, V20.4H
    FCVTPS  V28.4H, V2.4H
    FRINTI  V16.2D, V25.2D
    FRINTP  V8.4S, V6.4S
    FRINTA  V30.2D, V28.2D
    FCVTNS  V16.2D, V13.2D
    FRINTA  V4.2D, V13.2D
    FRINTN  V2.8H, V9.8H
    FCVTZS  V9.4H, V2.4H, #4
    FCVTZS  V2.2S, V4.2S
    FCVTZS  V25.8H, V19.8H
    FCVTN  V29.2S, V18.2D
    FCVTZS  V24.4H, V29.4H, #11
    FCVTZU  V21.4H, V2.4H, #11
    FRINTM  V13.4H, V19.4H
    FCVTZS V31.2D, V14.2D, #56
    FRINTN  V20.2S, V31.2S
    FCVTZU  V2.4S, V13.4S, #19
    FCVTZU  V18.4H, V21.4H
    FRINTI  V27.4S, V18.4S
    FRINTN  V18.8H, V20.8H
    FCVTAS  V4.2S, V9.2S
    FCVTZU V15.2D, V23.2D, #51
    FCVTXN  V13.2S, V9.2D
    FRINTX  V21.4H, V13.4H
    FCVTZS  V31.4H, V16.4H, #8
    FCVTZU  V6.4H, V4.4H, #16
    FRINTX  V14.4H, V27.4H
    SUBS  X25, X25, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_10
    MOVZ  X22, #0x30dd, LSL #0
    MOVK  X22, #0x8284, LSL #16
    MOVK  X22, #0x2298, LSL #32
    MOVK  X22, #0x92e6, LSL #48
    SUB  X18, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xca4c, LSL #0
    MOVK  X22, #0x6ef6, LSL #16
    MOVK  X22, #0x9706, LSL #32
    MOVK  X22, #0x7046, LSL #48
    SUB  X18, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xa0b, LSL #0
    MOVK  X22, #0xc4c3, LSL #16
    MOVK  X22, #0x2dcf, LSL #32
    MOVK  X22, #0xeaec, LSL #48
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x1f8d, LSL #0
    MOVK  X22, #0x4f46, LSL #16
    MOVK  X22, #0x2f93, LSL #32
    MOVK  X22, #0x1cb6, LSL #48
    SUB  X18, X22, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x8d83, LSL #0
    MOVK  X22, #0xc836, LSL #16
    MOVK  X22, #0x8775, LSL #32
    MOVK  X22, #0xc0ab, LSL #48
    SUB  X18, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xa1b2, LSL #0
    MOVK  X22, #0xf777, LSL #16
    MOVK  X22, #0xa17e, LSL #32
    MOVK  X22, #0xa357, LSL #48
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x90bc, LSL #0
    MOVK  X22, #0x6f21, LSL #16
    MOVK  X22, #0x4427, LSL #32
    MOVK  X22, #0xcf54, LSL #48
    SUB  X18, X22, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x2053, LSL #0
    MOVK  X22, #0x2f31, LSL #16
    MOVK  X22, #0x60fa, LSL #32
    MOVK  X22, #0xe290, LSL #48
    SUB  X18, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xc715, LSL #0
    MOVK  X22, #0xa7cf, LSL #16
    MOVK  X22, #0xb5b, LSL #32
    MOVK  X22, #0xa2c1, LSL #48
    SUB  X18, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xd767, LSL #0
    MOVK  X22, #0xc780, LSL #16
    MOVK  X22, #0x3ce3, LSL #32
    MOVK  X22, #0x28fa, LSL #48
    SUB  X18, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x43c7, LSL #0
    MOVK  X22, #0xbac3, LSL #16
    MOVK  X22, #0x2b56, LSL #32
    MOVK  X22, #0x3206, LSL #48
    SUB  X18, X22, X19
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x7053, LSL #0
    MOVK  X22, #0x61a9, LSL #16
    MOVK  X22, #0x86cf, LSL #32
    MOVK  X22, #0xbb93, LSL #48
    SUB  X18, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x883d, LSL #0
    MOVK  X22, #0xa377, LSL #16
    MOVK  X22, #0xc37, LSL #32
    MOVK  X22, #0x21ea, LSL #48
    SUB  X18, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xac3e, LSL #0
    MOVK  X22, #0x713f, LSL #16
    MOVK  X22, #0x685c, LSL #32
    MOVK  X22, #0x7559, LSL #48
    SUB  X18, X22, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x263c, LSL #0
    MOVK  X22, #0xde97, LSL #16
    MOVK  X22, #0x7137, LSL #32
    MOVK  X22, #0xbb9, LSL #48
    SUB  X18, X22, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x24c1, LSL #0
    MOVK  X22, #0xb70f, LSL #16
    MOVK  X22, #0x9b4d, LSL #32
    MOVK  X22, #0x7bb, LSL #48
    SUB  X18, X22, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0xb745, LSL #0
    MOVK  X22, #0x20e7, LSL #16
    MOVK  X22, #0x72ed, LSL #32
    MOVK  X22, #0xe74f, LSL #48
    SUB  X18, X22, X27
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x5294, LSL #0
    MOVK  X22, #0x8386, LSL #16
    MOVK  X22, #0x8d13, LSL #32
    MOVK  X22, #0x173e, LSL #48
    SUB  X18, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X22, #0x6258, LSL #0
    MOVK  X22, #0x2cc1, LSL #16
    MOVK  X22, #0x33be, LSL #32
    MOVK  X22, #0xd393, LSL #48
    SUB  X18, X22, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MRS  X22, FPSR
    MOVZ  X18, #0x1d, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V0.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D0
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V1.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D1
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V2.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D2
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V3.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D3
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V4.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D4
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V5.D[1]
    MOVZ  X18, #0x43c7, LSL #0
    MOVK  X18, #0xbac3, LSL #16
    MOVK  X18, #0x2b56, LSL #32
    MOVK  X18, #0x3206, LSL #48
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D5
    MOVZ  X18, #0x1f8d, LSL #0
    MOVK  X18, #0x4f46, LSL #16
    MOVK  X18, #0x2f93, LSL #32
    MOVK  X18, #0x1cb6, LSL #48
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V6.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D6
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V7.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D7
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V8.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D8
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V9.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D9
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V10.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D10
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V11.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D11
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V12.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D12
    MOVZ  X18, #0xa1b2, LSL #0
    MOVK  X18, #0xf777, LSL #16
    MOVK  X18, #0xa17e, LSL #32
    MOVK  X18, #0xa357, LSL #48
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V13.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D13
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V14.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D14
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V15.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D15
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V16.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D16
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V17.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D17
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V18.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D18
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V19.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D19
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V20.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D20
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V21.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D21
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V22.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D22
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V23.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D23
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V24.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D24
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V25.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D25
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V26.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D26
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V27.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D27
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V28.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D28
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V29.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D29
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V30.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D30
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, V31.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X22, D31
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
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
    FMOV  D0, X5
    FMOV  V0.D[1], X28
    FMOV  D1, X17
    FMOV  V1.D[1], X16
    FMOV  D2, X19
    FMOV  V2.D[1], X6
    FMOV  D3, X26
    FMOV  V3.D[1], X25
    FMOV  D4, X5
    FMOV  V4.D[1], X22
    FMOV  D5, X24
    FMOV  V5.D[1], X5
    FMOV  D6, X7
    FMOV  V6.D[1], X27
    FMOV  D7, X29
    FMOV  V7.D[1], X20
    FMOV  D8, X2
    FMOV  V8.D[1], X6
    FMOV  D9, X7
    FMOV  V9.D[1], X29
    FMOV  D10, X25
    FMOV  V10.D[1], X17
    FMOV  D11, X6
    FMOV  V11.D[1], X24
    FMOV  D12, X21
    FMOV  V12.D[1], X16
    FMOV  D13, X13
    FMOV  V13.D[1], X3
    FMOV  D14, X27
    FMOV  V14.D[1], X16
    FMOV  D15, X7
    FMOV  V15.D[1], X28
    FMOV  D16, X18
    FMOV  V16.D[1], X16
    FMOV  D17, X26
    FMOV  V17.D[1], X7
    FMOV  D18, X23
    FMOV  V18.D[1], X12
    FMOV  D19, X18
    FMOV  V19.D[1], X19
    FMOV  D20, X18
    FMOV  V20.D[1], X4
    FMOV  D21, X21
    FMOV  V21.D[1], X6
    FMOV  D22, X4
    FMOV  V22.D[1], X19
    FMOV  D23, X27
    FMOV  V23.D[1], X4
    FMOV  D24, X6
    FMOV  V24.D[1], X18
    FMOV  D25, X27
    FMOV  V25.D[1], X28
    FMOV  D26, X16
    FMOV  V26.D[1], X24
    FMOV  D27, X6
    FMOV  V27.D[1], X25
    FMOV  D28, X22
    FMOV  V28.D[1], X22
    FMOV  D29, X27
    FMOV  V29.D[1], X4
    FMOV  D30, X13
    FMOV  V30.D[1], X5
    FMOV  D31, X26
    FMOV  V31.D[1], X11
    MOVZ  X24, #0xa, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_11:
    FCVTPU  V4.2D, V19.2D
    FRINTM  V16.4H, V17.4H
    FCVTZS  V7.4H, V16.4H, #7
    FCVTAU  V29.2D, V25.2D
    FCVTNU  V26.2D, V24.2D
    FCVTNS  V6.2S, V28.2S
    FCVTXN2  V18.4S, V4.2D
    FCVTXN2  V23.4S, V6.2D
    FCVTAS  V1.2D, V29.2D
    FRINTZ  V8.2S, V31.2S
    FRINTA  V4.2D, V8.2D
    FCVTZS  V27.2D, V23.2D
    FCVTNU  V14.8H, V27.8H
    FCVTMS  V18.2S, V4.2S
    FCVTPS  V4.8H, V7.8H
    FRINTA  V27.4H, V14.4H
    FCVTPS  V3.8H, V10.8H
    FCVTZU  V25.8H, V27.8H, #11
    FCVTZS  V22.8H, V26.8H, #2
    FCVTZS  V19.4S, V10.4S
    FCVTNU  V14.4H, V4.4H
    FCVTNS  V4.2S, V3.2S
    FRINTM  V24.2D, V5.2D
    FCVTPU  V4.2S, V25.2S
    FCVTAS  V6.8H, V19.8H
    FRINTI  V7.4H, V30.4H
    FRINTX  V31.8H, V7.8H
    FRINTA  V0.4H, V14.4H
    FCVTZS V8.2D, V18.2D, #63
    FCVTNU  V18.4S, V31.4S
    FCVTZS  V1.2S, V18.2S, #11
    FCVTPU  V26.8H, V1.8H
    FCVTZU  V26.4H, V8.4H
    FCVTZS  V30.8H, V2.8H, #15
    FRINTZ  V8.8H, V4.8H
    FRINTN  V10.2D, V22.2D
    FCVTZS  V23.8H, V0.8H
    FCVTPS  V2.2D, V23.2D
    FCVTZU  V7.4S, V6.4S
    FCVTAS  V14.2D, V10.2D
    FCVTMU  V27.4H, V6.4H
    FRINTP  V13.4S, V8.4S
    FRINTM  V25.2S, V7.2S
    FCVTAS  V16.8H, V27.8H
    FRINTI  V17.2S, V2.2S
    FCVTN2  V10.4S, V0.2D
    FCVTPS  V23.2S, V30.2S
    FCVTMS  V1.2D, V26.2D
    FCVTMU  V7.8H, V23.8H
    FRINTZ  V0.4H, V14.4H
    FCVTL2  V27.2D, V18.4S
    FCVTNS  V14.4H, V27.4H
    FCVTNU  V30.8H, V16.8H
    FCVTAU  V16.2D, V1.2D
    FRINTI  V31.2S, V25.2S
    FCVTMS  V3.2D, V16.2D
    FCVTN  V25.4H, V7.4S
    FCVTZU  V21.8H, V0.8H
    FCVTL2  V26.2D, V31.4S
    FCVTNS  V28.2S, V21.2S
    FCVTZU  V0.4S, V14.4S
    FCVTPU  V16.4S, V17.4S
    FCVTPU  V9.4H, V16.4H
    FCVTMU  V18.2D, V30.2D
    FCVTNS  V21.4H, V13.4H
    FRINTZ  V22.8H, V18.8H
    FCVTNU  V7.8H, V0.8H
    FRINTZ  V9.4H, V10.4H
    FCVTZS  V17.8H, V29.8H, #10
    FCVTMS  V10.8H, V22.8H
    FRINTA  V16.8H, V11.8H
    FCVTPS  V11.4H, V7.4H
    FRINTN  V0.2S, V25.2S
    FRINTP  V13.8H, V16.8H
    FCVTZU  V7.8H, V17.8H, #1
    FCVTXN  V9.2S, V9.2D
    FRINTZ  V30.4S, V7.4S
    FCVTNU  V27.8H, V0.8H
    FRINTM  V0.4H, V10.4H
    FCVTAS  V25.2D, V21.2D
    FCVTZS  V7.4H, V27.4H, #1
    FRINTN  V17.8H, V18.8H
    FCVTMU  V1.2D, V9.2D
    FCVTZU  V16.4H, V28.4H
    FRINTA  V27.8H, V3.8H
    FCVTAS  V28.8H, V30.8H
    FRINTM  V22.4H, V17.4H
    FCVTAU  V3.4S, V7.4S
    FRINTZ  V5.4H, V11.4H
    FCVTAU  V10.2S, V20.2S
    FRINTZ  V1.2S, V13.2S
    FCVTPS  V9.4S, V0.4S
    FCVTMS  V22.2S, V19.2S
    FCVTZU  V23.8H, V27.8H
    FCVTZU  V0.2S, V11.2S
    FCVTN2  V30.8H, V16.4S
    FCVTPS  V21.2D, V0.2D
    FRINTI  V17.2D, V25.2D
    FCVTPU  V11.8H, V12.8H
    FCVTMS  V20.4H, V11.4H
    FCVTZS V13.2D, V23.2D, #15
    FCVTZS  V7.4H, V17.4H
    FCVTNS  V12.2D, V7.2D
    FRINTX  V7.4H, V30.4H
    FCVTXN2  V30.4S, V7.2D
    FCVTN2  V11.4S, V5.2D
    FRINTZ  V12.8H, V3.8H
    FCVTZS V25.2D, V22.2D, #8
    FCVTAS  V0.4S, V12.4S
    FCVTAS  V5.4H, V21.4H
    FRINTM  V16.8H, V20.8H
    FCVTN2  V21.8H, V25.4S
    FCVTXN  V4.2S, V11.2D
    FCVTPS  V20.8H, V12.8H
    FRINTN  V23.4H, V18.4H
    FCVTAU  V5.8H, V16.8H
    FRINTI  V3.2S, V30.2S
    FCVTPU  V1.4S, V27.4S
    FCVTL2  V18.2D, V1.4S
    FCVTL  V12.4S, V5.4H
    FCVTZS  V22.2S, V28.2S
    FCVTAS  V16.2S, V0.2S
    FCVTAU  V17.2D, V2.2D
    FRINTP  V11.2S, V23.2S
    FRINTN  V11.2S, V22.2S
    FCVTAU  V5.8H, V18.8H
    FCVTAU  V25.4S, V20.4S
    FRINTN  V27.4H, V3.4H
    FCVTXN2  V6.4S, V27.2D
    FRINTP  V0.2S, V5.2S
    FCVTAU  V23.4H, V6.4H
    FCVTZU V27.2D, V0.2D, #27
    FCVTMU  V2.4H, V11.4H
    FCVTZU  V1.8H, V25.8H, #4
    FCVTXN  V11.2S, V15.2D
    FCVTZU  V25.8H, V21.8H
    FCVTNS  V19.2D, V23.2D
    FCVTXN  V6.2S, V27.2D
    FCVTAU  V21.4S, V4.4S
    FCVTPU  V5.4S, V11.4S
    FCVTNS  V19.4H, V12.4H
    FCVTPU  V27.4S, V16.4S
    FRINTI  V30.4H, V2.4H
    FRINTM  V21.8H, V5.8H
    FRINTM  V5.4S, V27.4S
    FCVTXN2  V0.4S, V21.2D
    FCVTXN2  V23.4S, V2.2D
    FCVTXN  V12.2S, V30.2D
    FRINTP  V30.4S, V19.4S
    FCVTZU  V11.8H, V23.8H, #7
    FCVTL2  V17.2D, V6.4S
    FRINTI  V6.8H, V5.8H
    FCVTPS  V26.4H, V17.4H
    FRINTN  V31.4S, V6.4S
    FCVTPS  V22.4H, V12.4H
    FCVTPS  V23.8H, V0.8H
    FRINTA  V21.4H, V10.4H
    FRINTI  V19.4H, V1.4H
    FCVTPS  V12.2S, V30.2S
    FCVTNU  V30.4H, V11.4H
    FRINTA  V27.2D, V12.2D
    FCVTPS  V5.8H, V31.8H
    FRINTA  V6.8H, V21.8H
    FCVTPU  V17.2S, V30.2S
    FRINTN  V10.2D, V23.2D
    FCVTNU  V1.4H, V26.4H
    FRINTM  V18.8H, V19.8H
    FRINTN  V11.2S, V8.2S
    FCVTN2  V19.4S, V6.2D
    FRINTX  V30.2S, V19.2S
    FCVTMS  V23.4H, V18.4H
    FCVTZU  V0.2S, V5.2S, #15
    FCVTMS  V6.4H, V30.4H
    FRINTN  V17.4H, V17.4H
    FCVTPS  V5.4S, V10.4S
    FCVTAU  V31.2D, V6.2D
    FCVTXN  V30.2S, V0.2D
    FCVTN2  V8.4S, V22.2D
    FCVTL  V21.4S, V17.4H
    FCVTN2  V26.8H, V5.4S
    FRINTA  V5.4H, V8.4H
    FCVTNU  V18.4H, V27.4H
    FCVTMU  V10.4S, V24.4S
    FCVTZS  V24.8H, V26.8H
    FCVTMU  V17.2D, V18.2D
    FRINTP  V22.4H, V10.4H
    FCVTPU  V24.8H, V21.8H
    FCVTZS  V8.2D, V6.2D
    FCVTMS  V27.2D, V25.2D
    FCVTL  V25.4S, V5.4H
    FRINTP  V18.4H, V13.4H
    FRINTX  V26.4S, V25.4S
    FCVTZU V21.2D, V22.2D, #38
    FCVTZS  V22.4H, V30.4H, #3
    FCVTAS  V14.2D, V21.2D
    FCVTZS  V25.8H, V17.8H
    FCVTMU  V6.4H, V20.4H
    FCVTMU  V17.2D, V9.2D
    FCVTAU  V5.4S, V6.4S
    FCVTN  V6.4H, V24.4S
    SUBS  X24, X24, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_11
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MRS  X25, FPSR
    MOVZ  X21, #0x1d, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V0.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D0
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V1.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D1
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V2.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D2
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V3.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D3
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V4.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D4
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V5.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D5
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V6.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D6
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V7.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D7
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V8.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D8
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V9.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D9
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V10.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D10
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V11.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D11
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V12.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D12
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V13.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D13
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V14.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D14
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V15.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D15
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V16.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D16
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V17.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D17
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V18.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D18
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V19.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D19
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V20.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D20
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V21.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D21
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V22.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D22
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V23.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D23
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V24.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D24
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V25.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D25
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V26.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D26
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V27.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D27
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V28.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D28
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V29.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D29
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V30.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D30
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, V31.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X25, D31
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
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
    FMOV  V0.D[1], X6
    FMOV  D1, X28
    FMOV  V1.D[1], X23
    FMOV  D2, X27
    FMOV  V2.D[1], X29
    FMOV  D3, X19
    FMOV  V3.D[1], X27
    FMOV  D4, X29
    FMOV  V4.D[1], X6
    FMOV  D5, X29
    FMOV  V5.D[1], X13
    FMOV  D6, X4
    FMOV  V6.D[1], X19
    FMOV  D7, X22
    FMOV  V7.D[1], X5
    FMOV  D8, X16
    FMOV  V8.D[1], X5
    FMOV  D9, X16
    FMOV  V9.D[1], X28
    FMOV  D10, X19
    FMOV  V10.D[1], X19
    FMOV  D11, X5
    FMOV  V11.D[1], X16
    FMOV  D12, X13
    FMOV  V12.D[1], X16
    FMOV  D13, X27
    FMOV  V13.D[1], X12
    FMOV  D14, X2
    FMOV  V14.D[1], X27
    FMOV  D15, X28
    FMOV  V15.D[1], X29
    FMOV  D16, X13
    FMOV  V16.D[1], X3
    FMOV  D17, X3
    FMOV  V17.D[1], X17
    FMOV  D18, X23
    FMOV  V18.D[1], X20
    FMOV  D19, X22
    FMOV  V19.D[1], X18
    FMOV  D20, X7
    FMOV  V20.D[1], X23
    FMOV  D21, X25
    FMOV  V21.D[1], X27
    FMOV  D22, X24
    FMOV  V22.D[1], X6
    FMOV  D23, X17
    FMOV  V23.D[1], X27
    FMOV  D24, X28
    FMOV  V24.D[1], X13
    FMOV  D25, X28
    FMOV  V25.D[1], X3
    FMOV  D26, X4
    FMOV  V26.D[1], X24
    FMOV  D27, X12
    FMOV  V27.D[1], X27
    FMOV  D28, X24
    FMOV  V28.D[1], X5
    FMOV  D29, X5
    FMOV  V29.D[1], X19
    FMOV  D30, X18
    FMOV  V30.D[1], X28
    FMOV  D31, X22
    FMOV  V31.D[1], X16
    MOVZ  X25, #0xa, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_12:
    FCVTZU  V13.4S, V29.4S, #15
    FRINTI  V5.4H, V24.4H
    FCVTPS  V17.8H, V5.8H
    FCVTZU  V26.4H, V31.4H
    FCVTAS  V24.4S, V30.4S
    FCVTN2  V11.4S, V28.2D
    FCVTXN  V10.2S, V6.2D
    FCVTZU V14.2D, V10.2D, #24
    FCVTXN2  V7.4S, V1.2D
    FCVTNS  V2.2D, V11.2D
    FCVTZU  V28.8H, V11.8H, #6
    FCVTL  V13.4S, V24.4H
    FCVTAU  V17.8H, V5.8H
    FCVTPU  V28.4H, V30.4H
    FCVTZU  V26.2S, V0.2S, #27
    FRINTP  V13.2D, V14.2D
    FRINTM  V27.4H, V17.4H
    FCVTZU  V14.8H, V19.8H, #13
    FCVTPU  V9.4S, V24.4S
    FRINTI  V13.4S, V14.4S
    FCVTAU  V7.4H, V7.4H
    FCVTXN2  V25.4S, V28.2D
    FCVTZS  V19.8H, V27.8H, #2
    FCVTN  V11.4H, V23.4S
    FCVTNS  V10.2S, V2.2S
    FCVTAS  V23.8H, V9.8H
    FCVTZU  V30.8H, V25.8H, #6
    FRINTI  V27.8H, V26.8H
    FCVTZS  V25.8H, V7.8H, #12
    FCVTZS V29.2D, V9.2D, #53
    FRINTA  V17.2D, V22.2D
    FCVTMS  V1.2S, V25.2S
    FCVTXN2  V7.4S, V27.2D
    FCVTL2  V25.4S, V6.8H
    FCVTZS V16.2D, V30.2D, #52
    FCVTXN  V20.2S, V23.2D
    FCVTZU  V2.2S, V29.2S
    FCVTZS V9.2D, V20.2D, #9
    FRINTM  V28.8H, V21.8H
    FCVTZS  V29.4H, V2.4H, #16
    FCVTNU  V27.4H, V16.4H
    FRINTA  V24.4H, V7.4H
    FCVTNS  V20.2D, V11.2D
    FCVTAS  V26.4H, V1.4H
    FCVTZS  V7.8H, V20.8H
    FCVTZS  V21.4H, V17.4H, #9
    FCVTAS  V23.4S, V27.4S
    FCVTPS  V11.4H, V23.4H
    FCVTPU  V14.8H, V30.8H
    FCVTAU  V1.2S, V26.2S
    FCVTNU  V2.8H, V29.8H
    FCVTPS  V22.4H, V9.4H
    FCVTZS V6.2D, V19.2D, #49
    FCVTAU  V23.4H, V21.4H
    FCVTZU  V2.2S, V2.2S
    FCVTZU  V26.4H, V25.4H
    FRINTA  V16.2S, V7.2S
    FCVTNU  V9.4H, V6.4H
    FRINTI  V7.4H, V9.4H
    FCVTAS  V21.4H, V2.4H
    FRINTZ  V27.2S, V16.2S
    FCVTAS  V25.8H, V26.8H
    FCVTZS V30.2D, V11.2D, #44
    FCVTNS  V17.4H, V28.4H
    FCVTZU  V6.4S, V14.4S
    FRINTM  V29.4S, V24.4S
    FRINTM  V11.2S, V21.2S
    FRINTI  V2.4S, V23.4S
    FCVTZS  V26.4H, V28.4H
    FRINTP  V28.4S, V1.4S
    FCVTPS  V4.2S, V6.2S
    FRINTZ  V24.2D, V21.2D
    FRINTM  V6.4H, V26.4H
    FCVTZS  V14.8H, V6.8H, #10
    FCVTXN  V1.2S, V11.2D
    FRINTM  V16.4H, V2.4H
    FRINTM  V9.4H, V16.4H
    FRINTM  V2.2S, V29.2S
    FRINTM  V6.4H, V28.4H
    FRINTA  V19.2D, V30.2D
    FCVTZU  V25.4H, V14.4H, #2
    FCVTZS  V26.4S, V25.4S
    FRINTI  V16.8H, V24.8H
    FRINTP  V0.4H, V27.4H
    FRINTI  V23.8H, V16.8H
    FRINTI  V16.4S, V16.4S
    FCVTN  V4.2S, V26.2D
    FRINTA  V30.2D, V16.2D
    FCVTNS  V28.2S, V11.2S
    FCVTZS  V29.2S, V22.2S, #22
    FRINTM  V27.4S, V2.4S
    FCVTMS  V25.4H, V29.4H
    FRINTN  V0.4H, V30.4H
    FCVTN  V18.2S, V25.2D
    FCVTZS V21.2D, V1.2D, #12
    FCVTZU  V0.4H, V18.4H, #6
    FCVTL2  V24.4S, V27.8H
    FCVTNS  V22.4S, V21.4S
    FRINTN  V18.8H, V28.8H
    FRINTM  V25.8H, V18.8H
    FCVTL2  V21.2D, V14.4S
    FCVTPS  V27.8H, V10.8H
    FCVTNS  V27.8H, V19.8H
    FRINTM  V19.4H, V4.4H
    FCVTL2  V30.2D, V22.4S
    FRINTX  V29.4H, V9.4H
    FCVTZU  V16.4S, V5.4S, #26
    FCVTPS  V10.8H, V30.8H
    FCVTAU  V30.2D, V30.2D
    FRINTM  V4.4S, V19.4S
    FCVTL  V11.4S, V4.4H
    FCVTMU  V5.4H, V21.4H
    FCVTPU  V14.4S, V10.4S
    FCVTL2  V21.2D, V0.4S
    FCVTMU  V1.4H, V29.4H
    FCVTMS  V9.8H, V5.8H
    FCVTPU  V5.4H, V27.4H
    FRINTX  V10.8H, V19.8H
    FCVTMS  V27.4S, V27.4S
    FCVTZS  V4.4S, V11.4S, #3
    FCVTZU  V0.4H, V17.4H, #7
    FCVTN  V22.4H, V5.4S
    FCVTZS V10.2D, V0.2D, #1
    FRINTI  V1.8H, V29.8H
    FCVTMU  V29.4H, V9.4H
    FCVTPU  V0.4S, V18.4S
    FCVTPU  V28.4H, V25.4H
    FRINTN  V9.8H, V1.8H
    FCVTPU  V5.2S, V10.2S
    FCVTMU  V19.4S, V9.4S
    FCVTAS  V27.4S, V5.4S
    FCVTAS  V16.4H, V0.4H
    FCVTPU  V11.8H, V28.8H
    FRINTI  V28.8H, V11.8H
    FCVTMU  V25.4H, V4.4H
    FCVTAS  V0.2S, V28.2S
    FRINTA  V11.4S, V25.4S
    FCVTMS  V11.4S, V18.4S
    FCVTPU  V1.8H, V26.8H
    FCVTN  V10.4H, V27.4S
    FCVTZU  V5.8H, V16.8H, #5
    FCVTZS  V18.8H, V22.8H, #5
    FCVTN  V16.2S, V0.2D
    FRINTM  V17.4H, V5.4H
    FCVTXN2  V31.4S, V29.2D
    FCVTPU  V22.2S, V16.2S
    FCVTMU  V0.2D, V24.2D
    FCVTZU  V8.8H, V10.8H, #5
    FCVTAU  V26.8H, V22.8H
    FRINTA  V26.8H, V19.8H
    FRINTZ  V5.8H, V27.8H
    FCVTNU  V16.4H, V10.4H
    FRINTM  V19.2D, V31.2D
    FCVTL  V4.2D, V18.2S
    FCVTPU  V19.4S, V19.4S
    FCVTPS  V28.8H, V19.8H
    FCVTZS  V24.2S, V28.2S, #8
    FRINTP  V27.8H, V24.8H
    FRINTX  V24.4H, V8.4H
    FCVTZU V8.2D, V17.2D, #6
    FRINTM  V10.2S, V27.2S
    FCVTZS  V19.8H, V23.8H
    FRINTP  V28.4S, V31.4S
    FCVTN  V17.4H, V16.4S
    FCVTMU  V14.4H, V5.4H
    FCVTNS  V31.8H, V31.8H
    FCVTL2  V22.2D, V28.4S
    FCVTZS  V27.2S, V22.2S, #28
    FCVTMU  V6.2S, V24.2S
    FCVTZU  V24.4H, V0.4H
    FRINTM  V14.2D, V27.2D
    FRINTM  V0.2S, V2.2S
    FCVTL2  V2.4S, V7.8H
    FCVTZS V5.2D, V0.2D, #34
    FCVTZS V7.2D, V24.2D, #48
    FRINTA  V28.4H, V2.4H
    FRINTN  V24.4H, V6.4H
    FRINTI  V2.4H, V19.4H
    FCVTZS  V27.2S, V5.2S
    FRINTP  V28.2S, V26.2S
    FRINTM  V1.2D, V24.2D
    FRINTX  V23.4H, V17.4H
    FRINTA  V18.4H, V27.4H
    FCVTXN  V19.2S, V28.2D
    FCVTPU  V22.4S, V26.4S
    FCVTPS  V14.8H, V18.8H
    FCVTMU  V20.2S, V5.2S
    FCVTXN2  V26.4S, V21.2D
    FCVTNS  V5.2D, V31.2D
    FCVTZS  V27.4H, V7.4H, #16
    FCVTNU  V17.2S, V19.2S
    FCVTZU  V20.4H, V8.4H, #8
    FRINTA  V20.4S, V20.4S
    FCVTAU  V12.2S, V26.2S
    FRINTA  V0.4H, V5.4H
    FCVTZS  V18.4H, V22.4H, #8
    FRINTZ  V12.2D, V14.2D
    FCVTAU  V12.2S, V12.2S
    FCVTZU  V14.4S, V12.4S
    FCVTZU  V22.8H, V20.8H, #14
    SUBS  X25, X25, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_12
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MRS  X24, FPSR
    MOVZ  X28, #0x1d, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V0.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D0
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V1.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D1
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V2.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D2
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V3.D[1]
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D3
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D4
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D5
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D6
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D7
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V8.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D8
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D9
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V10.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D10
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V11.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D11
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V12.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D12
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V13.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D13
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D14
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D15
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V16.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D16
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D17
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V18.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D18
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D19
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D20
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V21.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D21
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V22.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D22
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V23.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D23
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V24.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D24
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V25.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D25
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V26.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D26
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D27
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V28.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D28
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V29.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D29
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V30.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D30
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, V31.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X24, D31
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
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
    FMOV  D0, X29
    FMOV  V0.D[1], X27
    FMOV  D1, X25
    FMOV  V1.D[1], X11
    FMOV  D2, X24
    FMOV  V2.D[1], X28
    FMOV  D3, X26
    FMOV  V3.D[1], X16
    FMOV  D4, X22
    FMOV  V4.D[1], X6
    FMOV  D5, X16
    FMOV  V5.D[1], X2
    FMOV  D6, X13
    FMOV  V6.D[1], X24
    FMOV  D7, X11
    FMOV  V7.D[1], X26
    FMOV  D8, X21
    FMOV  V8.D[1], X27
    FMOV  D9, X21
    FMOV  V9.D[1], X13
    FMOV  D10, X7
    FMOV  V10.D[1], X24
    FMOV  D11, X29
    FMOV  V11.D[1], X11
    FMOV  D12, X27
    FMOV  V12.D[1], X24
    FMOV  D13, X25
    FMOV  V13.D[1], X13
    FMOV  D14, X7
    FMOV  V14.D[1], X3
    FMOV  D15, X18
    FMOV  V15.D[1], X21
    FMOV  D16, X21
    FMOV  V16.D[1], X21
    FMOV  D17, X11
    FMOV  V17.D[1], X12
    FMOV  D18, X24
    FMOV  V18.D[1], X29
    FMOV  D19, X28
    FMOV  V19.D[1], X19
    FMOV  D20, X19
    FMOV  V20.D[1], X23
    FMOV  D21, X21
    FMOV  V21.D[1], X13
    FMOV  D22, X19
    FMOV  V22.D[1], X18
    FMOV  D23, X23
    FMOV  V23.D[1], X3
    FMOV  D24, X6
    FMOV  V24.D[1], X6
    FMOV  D25, X4
    FMOV  V25.D[1], X2
    FMOV  D26, X16
    FMOV  V26.D[1], X20
    FMOV  D27, X28
    FMOV  V27.D[1], X28
    FMOV  D28, X11
    FMOV  V28.D[1], X12
    FMOV  D29, X3
    FMOV  V29.D[1], X26
    FMOV  D30, X26
    FMOV  V30.D[1], X26
    FMOV  D31, X29
    FMOV  V31.D[1], X25
    MOVZ  X24, #0xa, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_13:
    FCVTNS  V3.4H, V24.4H
    FCVTZU  V19.4H, V27.4H, #8
    FCVTZS  V13.4H, V12.4H, #4
    FCVTZS  V7.2D, V28.2D
    FCVTMU  V5.2S, V3.2S
    FRINTP  V27.4H, V5.4H
    FCVTN  V29.4H, V31.4S
    FCVTZS  V18.4H, V21.4H, #13
    FRINTP  V9.8H, V29.8H
    FCVTXN2  V4.4S, V7.2D
    FCVTAS  V4.2S, V19.2S
    FRINTX  V10.2D, V18.2D
    FCVTZS  V31.2S, V27.2S
    FCVTPU  V16.2D, V30.2D
    FRINTZ  V29.4H, V1.4H
    FRINTP  V29.4S, V17.4S
    FCVTAS  V31.2S, V10.2S
    FCVTAS  V24.8H, V22.8H
    FCVTAU  V17.8H, V24.8H
    FCVTXN  V22.2S, V25.2D
    FCVTZU  V25.4S, V13.4S, #31
    FRINTA  V18.8H, V30.8H
    FCVTN2  V19.8H, V30.4S
    FCVTMU  V28.4S, V29.4S
    FRINTZ  V5.2D, V22.2D
    FCVTMS  V22.2D, V18.2D
    FCVTZS  V9.4S, V17.4S, #8
    FRINTN  V10.4S, V28.4S
    FCVTMU  V10.2S, V25.2S
    FRINTX  V7.2S, V9.2S
    FCVTZU V29.2D, V19.2D, #38
    FCVTZU  V28.2S, V5.2S, #26
    FCVTZU  V13.8H, V22.8H, #14
    FCVTZU  V22.8H, V10.8H, #7
    FCVTL  V24.2D, V16.2S
    FCVTMS  V18.2D, V7.2D
    FCVTPS  V27.8H, V31.8H
    FCVTZU V25.2D, V10.2D, #9
    FCVTZS V17.2D, V25.2D, #40
    FRINTN  V20.2S, V17.2S
    FRINTI  V10.2S, V29.2S
    FCVTZU  V29.2D, V9.2D
    FCVTNU  V29.4H, V20.4H
    FCVTPU  V9.4H, V6.4H
    FRINTZ  V7.4H, V29.4H
    FCVTL  V30.2D, V27.2S
    FCVTAU  V26.8H, V30.8H
    FCVTZS  V25.4H, V30.4H
    FCVTNU  V29.2S, V10.2S
    FRINTP  V28.2S, V13.2S
    FCVTAS  V19.2S, V15.2S
    FCVTZS  V13.2S, V2.2S, #13
    FCVTZS  V15.4H, V23.4H
    FCVTPU  V10.8H, V25.8H
    FCVTNS  V17.4S, V29.4S
    FCVTAS  V27.8H, V28.8H
    FCVTL2  V30.2D, V26.4S
    FCVTNS  V14.4H, V31.4H
    FRINTI  V20.8H, V14.8H
    FCVTAU  V25.4S, V17.4S
    FCVTPS  V14.4H, V10.4H
    FCVTZS  V26.2S, V9.2S, #32
    FCVTMS  V6.2D, V22.2D
    FCVTZS  V5.8H, V24.8H, #7
    FCVTL2  V28.2D, V14.4S
    FRINTN  V24.4H, V27.4H
    FCVTAS  V8.4H, V14.4H
    FCVTN2  V22.8H, V30.4S
    FCVTZS  V23.8H, V6.8H
    FCVTMS  V21.2S, V24.2S
    FCVTN  V9.2S, V19.2D
    FCVTZS V2.2D, V4.2D, #1
    FCVTAU  V31.4H, V2.4H
    FRINTZ  V24.4S, V9.4S
    FRINTN  V0.8H, V1.8H
    FCVTAS  V4.4H, V0.4H
    FCVTL2  V6.4S, V23.8H
    FCVTN2  V2.4S, V13.2D
    FCVTPS  V22.8H, V7.8H
    FRINTI  V14.2D, V13.2D
    FRINTP  V31.4S, V28.4S
    FCVTZU  V28.4S, V24.4S
    FCVTL  V23.2D, V4.2S
    FCVTL2  V9.2D, V14.4S
    FCVTPS  V13.4H, V9.4H
    FCVTZS V0.2D, V23.2D, #43
    FCVTMU  V9.8H, V23.8H
    FCVTZU  V24.2D, V9.2D
    FCVTL2  V23.4S, V13.8H
    FCVTNS  V7.8H, V31.8H
    FCVTZS  V10.2S, V6.2S
    FCVTZU V6.2D, V23.2D, #59
    FCVTN  V23.4H, V2.4S
    FCVTMS  V4.8H, V5.8H
    FCVTNS  V14.4H, V22.4H
    FRINTI  V16.2D, V10.2D
    FCVTAU  V20.4S, V4.4S
    FCVTMS  V22.2S, V0.2S
    FCVTPS  V5.2S, V16.2S
    FRINTM  V19.4S, V19.4S
    FRINTA  V1.2D, V28.2D
    FRINTX  V9.4H, V7.4H
    FCVTMU  V7.2D, V15.2D
    FCVTNS  V16.2D, V9.2D
    FRINTA  V15.2S, V1.2S
    FCVTZS  V13.4H, V24.4H
    FCVTN  V30.4H, V20.4S
    FRINTN  V24.8H, V23.8H
    FRINTN  V14.4H, V7.4H
    FCVTMS  V11.8H, V20.8H
    FCVTAU  V2.4H, V30.4H
    FRINTI  V31.4S, V15.4S
    FCVTAU  V15.4H, V19.4H
    FCVTAS  V1.4H, V15.4H
    FCVTPU  V30.4S, V18.4S
    FCVTAU  V8.4S, V1.4S
    FCVTZU V9.2D, V22.2D, #26
    FRINTX  V23.4S, V14.4S
    FRINTM  V18.4S, V16.4S
    FRINTZ  V28.4H, V24.4H
    FCVTZU V15.2D, V8.2D, #17
    FCVTMS  V19.4H, V9.4H
    FRINTM  V9.4H, V15.4H
    FRINTN  V4.2S, V2.2S
    FRINTZ  V15.8H, V11.8H
    FCVTPU  V16.8H, V28.8H
    FRINTX  V28.8H, V26.8H
    FCVTXN  V14.2S, V5.2D
    FCVTZU  V7.4H, V9.4H, #11
    FRINTM  V5.2D, V30.2D
    FRINTZ  V26.2D, V23.2D
    FCVTZS  V9.2D, V7.2D
    FCVTZS V9.2D, V14.2D, #48
    FCVTZS V24.2D, V9.2D, #19
    FCVTNU  V22.2S, V18.2S
    FCVTZU  V21.4H, V31.4H
    FCVTPU  V18.4S, V4.4S
    FCVTAS  V4.4S, V17.4S
    FCVTMS  V30.8H, V0.8H
    FCVTZU  V11.2D, V28.2D
    FRINTI  V17.4H, V16.4H
    FCVTNU  V8.4H, V17.4H
    FCVTZU V14.2D, V18.2D, #3
    FCVTMS  V31.4H, V21.4H
    FCVTMS  V2.4S, V9.4S
    FCVTMS  V7.2S, V30.2S
    FCVTPS  V17.4S, V13.4S
    FCVTPU  V4.2D, V7.2D
    FRINTP  V18.2S, V31.2S
    FCVTPS  V30.4H, V15.4H
    FCVTNU  V0.4S, V14.4S
    FCVTMS  V23.2S, V2.2S
    FCVTL  V9.2D, V5.2S
    FRINTA  V14.2S, V0.2S
    FCVTN  V7.4H, V8.4S
    FRINTX  V7.4H, V9.4H
    FCVTZS V5.2D, V17.2D, #64
    FCVTNS  V31.2D, V8.2D
    FCVTN  V0.2S, V31.2D
    FCVTMU  V31.2S, V30.2S
    FRINTP  V8.2D, V6.2D
    FCVTZU  V17.4H, V7.4H
    FRINTX  V4.2S, V8.2S
    FRINTX  V7.8H, V27.8H
    FCVTNU  V27.4S, V31.4S
    FCVTNS  V15.4S, V0.4S
    FCVTMS  V7.4S, V17.4S
    FCVTMU  V8.4S, V18.4S
    FRINTA  V18.2D, V27.2D
    FCVTAS  V30.8H, V15.8H
    FCVTZU  V25.4H, V5.4H
    FRINTN  V7.4H, V18.4H
    FRINTI  V15.8H, V14.8H
    FRINTP  V6.4S, V8.4S
    FCVTMS  V13.4H, V7.4H
    FRINTN  V0.2D, V26.2D
    FCVTXN2  V18.4S, V11.2D
    FRINTN  V9.4H, V15.4H
    FRINTN  V11.4H, V21.4H
    FRINTZ  V2.2D, V17.2D
    FRINTZ  V17.8H, V4.8H
    FCVTNS  V10.4S, V18.4S
    FRINTN  V10.8H, V10.8H
    FRINTA  V5.2D, V17.2D
    FCVTZU  V18.8H, V13.8H, #4
    FCVTMS  V26.4H, V18.4H
    FCVTZU V18.2D, V8.2D, #37
    FCVTMU  V31.4S, V30.4S
    FRINTA  V21.8H, V0.8H
    FCVTZS  V7.4H, V11.4H
    FCVTNS  V15.2D, V31.2D
    FCVTPU  V22.2S, V10.2S
    FCVTZU  V30.4S, V26.4S, #24
    FCVTZS V17.2D, V18.2D, #9
    FCVTNU  V0.2S, V7.2S
    FRINTP  V31.4S, V30.4S
    FCVTPS  V4.4H, V22.4H
    FCVTZU V27.2D, V8.2D, #54
    FCVTZS  V22.8H, V27.8H
    FRINTI  V28.2S, V15.2S
    SUBS  X24, X24, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_13
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X12, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X12, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X12, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X12, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X12, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X12, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X12, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X12, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X12, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X12, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X12, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X12, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X12, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X12, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X12, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X12, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X12, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X12, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X12, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MRS  X11, FPSR
    MOVZ  X12, #0x1d, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V0.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D0
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V1.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D1
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D2
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D3
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D4
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D5
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V6.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D6
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D7
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D8
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D9
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D10
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V11.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D11
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D12
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D13
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D14
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D15
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D16
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D17
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D18
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D19
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D20
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D21
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D22
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D23
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D24
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D25
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D26
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D27
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D28
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D29
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V30.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D30
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, V31.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X11, D31
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
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
    FMOV  V0.D[1], X29
    FMOV  D1, X26
    FMOV  V1.D[1], X23
    FMOV  D2, X27
    FMOV  V2.D[1], X21
    FMOV  D3, X28
    FMOV  V3.D[1], X28
    FMOV  D4, X7
    FMOV  V4.D[1], X22
    FMOV  D5, X4
    FMOV  V5.D[1], X13
    FMOV  D6, X16
    FMOV  V6.D[1], X29
    FMOV  D7, X24
    FMOV  V7.D[1], X22
    FMOV  D8, X27
    FMOV  V8.D[1], X24
    FMOV  D9, X5
    FMOV  V9.D[1], X25
    FMOV  D10, X24
    FMOV  V10.D[1], X2
    FMOV  D11, X6
    FMOV  V11.D[1], X7
    FMOV  D12, X13
    FMOV  V12.D[1], X27
    FMOV  D13, X19
    FMOV  V13.D[1], X27
    FMOV  D14, X12
    FMOV  V14.D[1], X27
    FMOV  D15, X18
    FMOV  V15.D[1], X24
    FMOV  D16, X11
    FMOV  V16.D[1], X6
    FMOV  D17, X7
    FMOV  V17.D[1], X4
    FMOV  D18, X29
    FMOV  V18.D[1], X3
    FMOV  D19, X5
    FMOV  V19.D[1], X2
    FMOV  D20, X24
    FMOV  V20.D[1], X27
    FMOV  D21, X22
    FMOV  V21.D[1], X5
    FMOV  D22, X27
    FMOV  V22.D[1], X21
    FMOV  D23, X19
    FMOV  V23.D[1], X19
    FMOV  D24, X16
    FMOV  V24.D[1], X26
    FMOV  D25, X12
    FMOV  V25.D[1], X6
    FMOV  D26, X12
    FMOV  V26.D[1], X11
    FMOV  D27, X21
    FMOV  V27.D[1], X5
    FMOV  D28, X19
    FMOV  V28.D[1], X12
    FMOV  D29, X13
    FMOV  V29.D[1], X12
    FMOV  D30, X26
    FMOV  V30.D[1], X5
    FMOV  D31, X21
    FMOV  V31.D[1], X23
    MOVZ  X5, #0xa, LSL #0
TSRTAdvsimdVectorFloatingPointConvertToInteger_label_14:
    FRINTI  V3.8H, V27.8H
    FCVTNS  V0.4H, V30.4H
    FRINTP  V1.2S, V19.2S
    FRINTZ  V22.4H, V29.4H
    FCVTN2  V3.4S, V22.2D
    FCVTZU  V16.4H, V26.4H, #4
    FRINTZ  V2.2D, V1.2D
    FCVTNS  V17.4H, V31.4H
    FRINTX  V15.8H, V0.8H
    FCVTZS  V2.2S, V15.2S, #21
    FCVTZS  V24.2D, V17.2D
    FCVTPS  V21.8H, V17.8H
    FCVTAU  V11.4H, V2.4H
    FRINTP  V26.4H, V21.4H
    FCVTMS  V29.4H, V16.4H
    FCVTZU  V29.8H, V3.8H, #12
    FCVTN  V24.4H, V28.4S
    FCVTXN  V2.2S, V22.2D
    FCVTAU  V19.8H, V28.8H
    FCVTL2  V27.2D, V2.4S
    FCVTZS V28.2D, V2.2D, #47
    FCVTZS  V2.4S, V29.4S, #7
    FCVTPS  V19.4H, V24.4H
    FRINTX  V29.2D, V7.2D
    FRINTN  V3.2S, V4.2S
    FCVTNS  V22.4S, V29.4S
    FCVTNU  V27.8H, V22.8H
    FCVTZS  V22.4S, V28.4S, #4
    FCVTZS  V29.8H, V29.8H, #16
    FRINTP  V15.2S, V19.2S
    FCVTMS  V13.2D, V11.2D
    FCVTZS  V5.2D, V29.2D
    FRINTA  V11.4S, V26.4S
    FCVTPS  V26.4H, V11.4H
    FCVTMS  V29.4H, V13.4H
    FCVTAS  V19.4S, V2.4S
    FRINTI  V24.2S, V29.2S
    FCVTZS  V13.4H, V24.4H, #13
    FCVTZU  V29.2S, V15.2S
    FRINTP  V28.8H, V29.8H
    FRINTA  V17.2D, V19.2D
    FRINTA  V11.2S, V3.2S
    FRINTP  V24.8H, V1.8H
    FCVTAS  V15.4H, V0.4H
    FCVTPS  V2.4H, V15.4H
    FCVTL2  V19.4S, V2.8H
    FCVTPU  V0.4S, V27.4S
    FCVTN  V1.4H, V0.4S
    FCVTZS  V11.8H, V30.8H
    FCVTAU  V29.2D, V5.2D
    FCVTN2  V2.4S, V24.2D
    FCVTZU  V11.8H, V28.8H
    FRINTN  V25.4S, V19.4S
    FCVTZU  V27.8H, V13.8H, #3
    FCVTZU  V19.4S, V27.4S
    FCVTPU  V13.8H, V6.8H
    FCVTMS  V5.4S, V17.4S
    FRINTN  V27.2S, V30.2S
    FCVTL  V0.2D, V19.2S
    FRINTP  V6.4H, V26.4H
    FRINTZ  V28.2D, V5.2D
    FCVTZU  V15.4S, V11.4S, #8
    FCVTMS  V27.8H, V27.8H
    FCVTZS  V26.8H, V0.8H
    FRINTM  V9.4H, V29.4H
    FCVTN2  V19.4S, V22.2D
    FRINTX  V29.2S, V9.2S
    FCVTMU  V21.2S, V28.2S
    FCVTZS  V15.2S, V4.2S, #26
    FCVTAU  V4.4S, V29.4S
    FCVTZU  V11.4S, V15.4S, #28
    FCVTZS  V30.4S, V2.4S, #30
    FRINTI  V0.4H, V30.4H
    FCVTZS  V24.2D, V4.2D
    FCVTPU  V9.2S, V15.2S
    FCVTL2  V2.4S, V9.8H
    FCVTMS  V19.4S, V21.4S
    FRINTM  V17.4H, V19.4H
    FRINTI  V5.2D, V6.2D
    FRINTX  V21.8H, V23.8H
    FCVTL  V30.4S, V30.4H
    FRINTI  V23.2S, V11.2S
    FCVTAU  V28.8H, V30.8H
    FCVTAU  V29.2D, V17.2D
    FCVTPU  V4.8H, V0.8H
    FCVTZU  V23.8H, V29.8H
    FRINTN  V27.8H, V27.8H
    FCVTNS  V6.8H, V24.8H
    FCVTZS  V9.4H, V15.4H
    FCVTMU  V15.4H, V9.4H
    FRINTA  V2.8H, V21.8H
    FRINTN  V4.4H, V23.4H
    FCVTZS  V9.2D, V6.2D
    FRINTZ  V14.2S, V15.2S
    FCVTPS  V29.2D, V4.2D
    FCVTXN  V23.2S, V5.2D
    FCVTPS  V17.4S, V6.4S
    FRINTI  V18.4S, V2.4S
    FCVTNU  V15.2S, V9.2S
    FCVTXN  V27.2S, V12.2D
    FCVTN2  V30.8H, V14.4S
    FCVTPS  V4.4H, V15.4H
    FRINTX  V9.2D, V29.2D
    FCVTN2  V20.4S, V23.2D
    FCVTAS  V21.8H, V28.8H
    FCVTZS V12.2D, V30.2D, #23
    FCVTZU  V24.4H, V20.4H
    FCVTL2  V15.2D, V17.4S
    FCVTMS  V23.2D, V0.2D
    FCVTPU  V5.2S, V21.2S
    FCVTL  V11.2D, V9.2S
    FCVTL  V6.2D, V5.2S
    FCVTZS  V24.4S, V11.4S, #25
    FCVTNU  V28.4S, V5.4S
    FCVTNU  V21.8H, V23.8H
    FRINTP  V2.4H, V17.4H
    FRINTI  V9.8H, V18.8H
    FCVTMS  V5.4H, V11.4H
    FCVTXN2  V10.4S, V28.2D
    FCVTPS  V17.2S, V4.2S
    FRINTI  V3.2S, V22.2S
    FCVTL  V28.2D, V3.2S
    FCVTMU  V4.4H, V21.4H
    FCVTNU  V9.8H, V21.8H
    FCVTZU  V23.8H, V24.8H, #12
    FCVTZU V24.2D, V23.2D, #48
    FRINTM  V21.2D, V20.2D
    FRINTP  V11.4S, V18.4S
    FRINTP  V23.2D, V11.2D
    FCVTMU  V18.2S, V13.2S
    FCVTNS  V11.4H, V6.4H
    FRINTM  V30.2S, V11.2S
    FCVTZS  V6.2S, V26.2S, #29
    FCVTZU  V3.2S, V10.2S, #5
    FCVTMS  V22.4S, V23.4S
    FCVTPU  V24.8H, V6.8H
    FCVTZS  V26.4H, V24.4H, #4
    FCVTAU  V11.4H, V17.4H
    FCVTMS  V10.2S, V22.2S
    FCVTL  V13.4S, V11.4H
    FCVTZU  V13.2S, V2.2S
    FRINTN  V16.2S, V21.2S
    FRINTN  V27.2S, V14.2S
    FCVTN2  V22.8H, V27.4S
    FCVTZS V6.2D, V30.2D, #32
    FRINTI  V12.4S, V6.4S
    FRINTI  V24.4S, V13.4S
    FRINTZ  V23.2S, V3.2S
    FCVTAU  V17.4S, V25.4S
    FCVTMS  V11.4H, V26.4H
    FRINTP  V25.2S, V19.2S
    FCVTAU  V18.4H, V16.4H
    FCVTNS  V20.4S, V24.4S
    FCVTZS  V14.4H, V13.4H
    FCVTXN  V2.2S, V12.2D
    FRINTX  V30.2S, V10.2S
    FCVTZU  V16.2S, V18.2S
    FCVTPU  V28.4S, V14.4S
    FCVTMS  V10.2S, V28.2S
    FCVTPU  V21.4S, V25.4S
    FCVTZS V25.2D, V2.2D, #60
    FCVTMS  V19.2D, V27.2D
    FRINTN  V26.4H, V25.4H
    FRINTA  V6.2D, V23.2D
    FCVTZU  V1.2S, V22.2S
    FCVTPS  V27.2S, V19.2S
    FCVTZU  V25.2S, V16.2S
    FCVTZU V23.2D, V17.2D, #13
    FCVTXN  V17.2S, V11.2D
    FRINTI  V2.4S, V12.4S
    FRINTI  V28.8H, V6.8H
    FCVTPS  V12.4S, V25.4S
    FRINTX  V13.2D, V16.2D
    FRINTM  V11.8H, V0.8H
    FRINTI  V22.2S, V23.2S
    FCVTZS  V16.4H, V24.4H, #2
    FCVTPU  V0.2D, V4.2D
    FCVTZU  V28.2S, V21.2S
    FCVTPU  V4.4S, V28.4S
    FCVTN  V6.4H, V26.4S
    FRINTA  V24.2S, V20.2S
    FCVTAU  V26.2S, V16.2S
    FCVTN  V5.2S, V1.2D
    FCVTMU  V23.4H, V5.4H
    FRINTM  V25.8H, V8.8H
    FRINTI  V4.4S, V4.4S
    FRINTX  V0.4S, V2.4S
    FCVTNS  V16.4S, V12.4S
    FCVTZU  V1.4H, V0.4H
    FCVTAS  V20.4H, V11.4H
    FCVTMU  V19.2D, V6.2D
    FCVTL2  V5.2D, V19.4S
    FCVTXN  V5.2S, V13.2D
    FCVTL2  V12.4S, V25.8H
    FCVTN2  V8.8H, V2.4S
    FRINTP  V6.8H, V8.8H
    FCVTZU  V13.2S, V12.2S
    FCVTZS  V24.2S, V30.2S
    FRINTA  V8.8H, V20.8H
    FCVTMU  V2.2S, V26.2S
    SUBS  X5, X5, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointConvertToInteger_label_14
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X28, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    MRS  X4, FPSR
    MOVZ  X28, #0x1d, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V0.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D0
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V1.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D1
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D2
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D3
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V4.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D4
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V5.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D5
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D6
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V7.D[1]
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D7
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V8.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D8
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D9
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D10
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D11
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D12
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V13.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D13
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V14.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D14
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D15
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D16
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V17.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D17
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D18
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V19.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D19
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D20
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D21
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V22.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D22
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D23
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V24.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D24
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V25.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D25
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V26.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D26
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D27
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V28.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D28
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V29.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D29
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V30.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D30
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, V31.D[1]
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail
    FMOV  X4, D31
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointConvertToInteger_TestFail

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
