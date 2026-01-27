.global TSRTAdvsimdVectorFloatingPointOperation

.text
.p2align 4

TSRTAdvsimdVectorFloatingPointOperation:

TSRTAdvsimdVectorFloatingPointOperation_TestBegin:
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
    MOVZ  X2, #0x563b, LSL #0
    MOVK  X2, #0xf76a, LSL #16
    MOVK  X2, #0x9102, LSL #32
    MOVK  X2, #0x5f8f, LSL #48
    MOVZ  X3, #0xfd6b, LSL #0
    MOVK  X3, #0xe363, LSL #16
    MOVK  X3, #0x1be7, LSL #32
    MOVK  X3, #0xa28f, LSL #48
    MOVZ  X4, #0xc953, LSL #0
    MOVK  X4, #0x68aa, LSL #16
    MOVK  X4, #0x6e2, LSL #32
    MOVK  X4, #0x616e, LSL #48
    MOVZ  X5, #0xfcc6, LSL #0
    MOVK  X5, #0xddf4, LSL #16
    MOVK  X5, #0x2430, LSL #32
    MOVK  X5, #0x8909, LSL #48
    MOVZ  X6, #0x3e3c, LSL #0
    MOVK  X6, #0x6a16, LSL #16
    MOVK  X6, #0x42da, LSL #32
    MOVK  X6, #0x5fff, LSL #48
    MOVZ  X7, #0x1327, LSL #0
    MOVK  X7, #0xe182, LSL #16
    MOVK  X7, #0x8cb2, LSL #32
    MOVK  X7, #0x4e0f, LSL #48
    MOVZ  X8, #0xe205, LSL #0
    MOVK  X8, #0xe575, LSL #16
    MOVK  X8, #0x4565, LSL #32
    MOVK  X8, #0x32b7, LSL #48
    MOVZ  X9, #0xd58, LSL #0
    MOVK  X9, #0xe570, LSL #16
    MOVK  X9, #0x83dc, LSL #32
    MOVK  X9, #0x9a81, LSL #48
    MOVZ  X10, #0xa4d1, LSL #0
    MOVK  X10, #0xcefc, LSL #16
    MOVK  X10, #0x1971, LSL #32
    MOVK  X10, #0xbc6c, LSL #48
    MOVZ  X11, #0x3031, LSL #0
    MOVK  X11, #0xa7b9, LSL #16
    MOVK  X11, #0xdd6b, LSL #32
    MOVK  X11, #0x86d, LSL #48
    MOVZ  X12, #0xe368, LSL #0
    MOVK  X12, #0x1d2, LSL #16
    MOVK  X12, #0xb156, LSL #32
    MOVK  X12, #0x6b30, LSL #48
    MOVZ  X13, #0x654e, LSL #0
    MOVK  X13, #0xf2be, LSL #16
    MOVK  X13, #0x6432, LSL #32
    MOVK  X13, #0xe616, LSL #48
    MOVZ  X14, #0xf71c, LSL #0
    MOVK  X14, #0x596d, LSL #16
    MOVK  X14, #0xab9c, LSL #32
    MOVK  X14, #0x8847, LSL #48
    MOVZ  X15, #0xea78, LSL #0
    MOVK  X15, #0xa9c1, LSL #16
    MOVK  X15, #0xe6d5, LSL #32
    MOVK  X15, #0x1b34, LSL #48
    MOVZ  X16, #0xa247, LSL #0
    MOVK  X16, #0xfaaf, LSL #16
    MOVK  X16, #0x9187, LSL #32
    MOVK  X16, #0xaccb, LSL #48
    MOVZ  X17, #0xfaa8, LSL #0
    MOVK  X17, #0xaf9b, LSL #16
    MOVK  X17, #0x92cd, LSL #32
    MOVK  X17, #0x9ffe, LSL #48
    MOVZ  X23, #0xf41e, LSL #0
    MOVK  X23, #0xd294, LSL #16
    MOVK  X23, #0xb006, LSL #32
    MOVK  X23, #0xcff3, LSL #48
    MOVZ  X24, #0x936a, LSL #0
    MOVK  X24, #0x1164, LSL #16
    MOVK  X24, #0xf32d, LSL #32
    MOVK  X24, #0xa469, LSL #48
    MOVZ  X25, #0x91da, LSL #0
    MOVK  X25, #0x9a9b, LSL #16
    MOVK  X25, #0xc652, LSL #32
    MOVK  X25, #0x5a4f, LSL #48
    MOVZ  X26, #0x6622, LSL #0
    MOVK  X26, #0xa0c4, LSL #16
    MOVK  X26, #0x3b0a, LSL #32
    MOVK  X26, #0xeb9b, LSL #48
    MOVZ  X27, #0xfd2e, LSL #0
    MOVK  X27, #0xa962, LSL #16
    MOVK  X27, #0xe646, LSL #32
    MOVK  X27, #0x819d, LSL #48
    MOVZ  X28, #0x82c6, LSL #0
    MOVK  X28, #0xc65, LSL #16
    MOVK  X28, #0x61c6, LSL #32
    MOVK  X28, #0x7efe, LSL #48
    MOVZ  X29, #0xe9c7, LSL #0
    MOVK  X29, #0x567c, LSL #16
    MOVK  X29, #0xab16, LSL #32
    MOVK  X29, #0xbc81, LSL #48
    MOVZ  X7, #0x8f41, LSL #0
    MOVK  X7, #0xa0cd, LSL #16
    MOVK  X7, #0xc659, LSL #32
    MOVK  X7, #0x9a78, LSL #48
    MSR  FPCR, X7
    MRS  X9, FPCR
    MOVZ  X15, #0x60ff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    AND  X9, X9, X15
    MOVZ  X15, #0x0, LSL #0
    ORR  X9, X9, X15
    MSR  FPCR, X9
    ISB  SY
    MOVZ  X7, #0xcf32, LSL #0
    MOVK  X7, #0xf51e, LSL #16
    MOVK  X7, #0x856b, LSL #32
    MOVK  X7, #0x659a, LSL #48
    MSR  FPSR, X7
    MRS  X28, FPSR
    MOVZ  X3, #0xff60, LSL #0
    MOVK  X3, #0x7ff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    AND  X28, X28, X3
    MOVZ  X3, #0x0, LSL #0
    ORR  X28, X28, X3
    MSR  FPSR, X28
    ISB  SY
    ANDS  X2, X10, X17, ASR #62
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x7b0f, LSL #0
    MOVK  X2, #0x9eb2, LSL #16
    MOVK  X2, #0xd0a1, LSL #32
    MOVK  X2, #0xa047, LSL #48
    MOVZ  X3, #0x1667, LSL #0
    MOVK  X3, #0x800b, LSL #16
    MOVK  X3, #0xb27d, LSL #32
    MOVK  X3, #0xc3e4, LSL #48
    MOVZ  X4, #0x570c, LSL #0
    MOVK  X4, #0x6329, LSL #16
    MOVK  X4, #0x9345, LSL #32
    MOVK  X4, #0xe503, LSL #48
    MOVZ  X5, #0x32d7, LSL #0
    MOVK  X5, #0x7be7, LSL #16
    MOVK  X5, #0xd361, LSL #32
    MOVK  X5, #0x8e7a, LSL #48
    MOVZ  X6, #0x4cbb, LSL #0
    MOVK  X6, #0x64f7, LSL #16
    MOVK  X6, #0x9803, LSL #32
    MOVK  X6, #0xc7b2, LSL #48
    MOVZ  X7, #0x98f5, LSL #0
    MOVK  X7, #0x67b0, LSL #16
    MOVK  X7, #0x1b77, LSL #32
    MOVK  X7, #0x9b23, LSL #48
    MOVZ  X8, #0x6dc9, LSL #0
    MOVK  X8, #0x1a21, LSL #16
    MOVK  X8, #0x6def, LSL #32
    MOVK  X8, #0x5687, LSL #48
    MOVZ  X9, #0x57d2, LSL #0
    MOVK  X9, #0x81b2, LSL #16
    MOVK  X9, #0x3897, LSL #32
    MOVK  X9, #0xbce5, LSL #48
    MOVZ  X10, #0x85d3, LSL #0
    MOVK  X10, #0xd58d, LSL #16
    MOVK  X10, #0xa77d, LSL #32
    MOVK  X10, #0xd4d1, LSL #48
    MOVZ  X11, #0xbd6e, LSL #0
    MOVK  X11, #0xfe80, LSL #16
    MOVK  X11, #0xfc52, LSL #32
    MOVK  X11, #0x6c24, LSL #48
    MOVZ  X12, #0x3561, LSL #0
    MOVK  X12, #0xe8bf, LSL #16
    MOVK  X12, #0x4fc9, LSL #32
    MOVK  X12, #0x6b0a, LSL #48
    MOVZ  X13, #0x459f, LSL #0
    MOVK  X13, #0xa97, LSL #16
    MOVK  X13, #0x9b65, LSL #32
    MOVK  X13, #0xcf6d, LSL #48
    MOVZ  X14, #0xc6d1, LSL #0
    MOVK  X14, #0xbed6, LSL #16
    MOVK  X14, #0x81db, LSL #32
    MOVK  X14, #0x7ef, LSL #48
    MOVZ  X15, #0x8fb9, LSL #0
    MOVK  X15, #0xa64d, LSL #16
    MOVK  X15, #0x2342, LSL #32
    MOVK  X15, #0x3101, LSL #48
    MOVZ  X16, #0xc38d, LSL #0
    MOVK  X16, #0xbe22, LSL #16
    MOVK  X16, #0x43fd, LSL #32
    MOVK  X16, #0xc44c, LSL #48
    MOVZ  X17, #0x6730, LSL #0
    MOVK  X17, #0x2e65, LSL #16
    MOVK  X17, #0x3e21, LSL #32
    MOVK  X17, #0x9217, LSL #48
    MOVZ  X23, #0x6baf, LSL #0
    MOVK  X23, #0x6875, LSL #16
    MOVK  X23, #0x4874, LSL #32
    MOVK  X23, #0xebda, LSL #48
    MOVZ  X24, #0x9131, LSL #0
    MOVK  X24, #0x51c4, LSL #16
    MOVK  X24, #0x370a, LSL #32
    MOVK  X24, #0x938b, LSL #48
    MOVZ  X25, #0x8786, LSL #0
    MOVK  X25, #0x80ed, LSL #16
    MOVK  X25, #0xd8bd, LSL #32
    MOVK  X25, #0x862c, LSL #48
    MOVZ  X26, #0x3fc8, LSL #0
    MOVK  X26, #0xfa64, LSL #16
    MOVK  X26, #0xb4c5, LSL #32
    MOVK  X26, #0xd8a, LSL #48
    MOVZ  X27, #0x4ada, LSL #0
    MOVK  X27, #0xbff3, LSL #16
    MOVK  X27, #0xcdb7, LSL #32
    MOVK  X27, #0x51bf, LSL #48
    MOVZ  X28, #0xd4fa, LSL #0
    MOVK  X28, #0x1a16, LSL #16
    MOVK  X28, #0xec47, LSL #32
    MOVK  X28, #0xd938, LSL #48
    MOVZ  X29, #0xcabe, LSL #0
    MOVK  X29, #0x4b13, LSL #16
    MOVK  X29, #0xceb1, LSL #32
    MOVK  X29, #0x2044, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X25
    FMOV  D1, X2
    FMOV  V1.D[1], X27
    FMOV  D2, X29
    FMOV  V2.D[1], X28
    FMOV  D3, X5
    FMOV  V3.D[1], X7
    FMOV  D4, X13
    FMOV  V4.D[1], X26
    FMOV  D5, X29
    FMOV  V5.D[1], X9
    FMOV  D6, X27
    FMOV  V6.D[1], X16
    FMOV  D7, X15
    FMOV  V7.D[1], X17
    FMOV  D8, X28
    FMOV  V8.D[1], X14
    FMOV  D9, X12
    FMOV  V9.D[1], X28
    FMOV  D10, X14
    FMOV  V10.D[1], X26
    FMOV  D11, X29
    FMOV  V11.D[1], X8
    FMOV  D12, X7
    FMOV  V12.D[1], X14
    FMOV  D13, X13
    FMOV  V13.D[1], X5
    FMOV  D14, X12
    FMOV  V14.D[1], X16
    FMOV  D15, X3
    FMOV  V15.D[1], X9
    FMOV  D16, X23
    FMOV  V16.D[1], X25
    FMOV  D17, X3
    FMOV  V17.D[1], X16
    FMOV  D18, X13
    FMOV  V18.D[1], X26
    FMOV  D19, X11
    FMOV  V19.D[1], X11
    FMOV  D20, X3
    FMOV  V20.D[1], X24
    FMOV  D21, X15
    FMOV  V21.D[1], X3
    FMOV  D22, X10
    FMOV  V22.D[1], X7
    FMOV  D23, X12
    FMOV  V23.D[1], X16
    FMOV  D24, X27
    FMOV  V24.D[1], X8
    FMOV  D25, X15
    FMOV  V25.D[1], X7
    FMOV  D26, X28
    FMOV  V26.D[1], X3
    FMOV  D27, X17
    FMOV  V27.D[1], X6
    FMOV  D28, X13
    FMOV  V28.D[1], X29
    FMOV  D29, X28
    FMOV  V29.D[1], X7
    FMOV  D30, X11
    FMOV  V30.D[1], X12
    FMOV  D31, X7
    FMOV  V31.D[1], X27
    FABD  V22.2S, V28.2S, V22.2S
    FABD  V29.4S, V7.4S, V19.4S
    FABD  V1.2D, V31.2D, V20.2D
    FABD  V14.2D, V13.2D, V22.2D
    FABD  V27.4S, V0.4S, V29.4S
    FABD  V28.2S, V26.2S, V17.2S
    FABD  V5.2D, V4.2D, V25.2D
    FABD  V30.4S, V5.4S, V27.4S
    FABD  V3.2S, V14.2S, V28.2S
    FABD  V31.4S, V1.4S, V3.4S
    FABS  V14.4S, V23.4S
    FABS  V16.4S, V7.4S
    FABS  V23.2S, V6.2S
    FABS  V3.2D, V27.2D
    FABS  V19.4S, V31.4S
    FABS  V28.2S, V16.2S
    FABS  V6.4S, V0.4S
    FABS  V15.2S, V3.2S
    FABS  V5.4S, V30.4S
    FABS  V0.2S, V27.2S
    FACGE  V22.4S, V17.4S, V0.4S
    FACGE  V25.2S, V31.2S, V19.2S
    FACGE  V29.2D, V6.2D, V6.2D
    FACGE  V4.2S, V1.2S, V25.2S
    FACGE  V13.2D, V4.2D, V28.2D
    FACGE  V16.4S, V0.4S, V26.4S
    FACGE  V3.2D, V4.2D, V29.2D
    FACGE  V0.2S, V4.2S, V23.2S
    FACGE  V28.2D, V0.2D, V0.2D
    FACGE  V27.4S, V15.4S, V14.4S
    FACGT  V19.4S, V14.4S, V5.4S
    FACGT  V7.2S, V0.2S, V28.2S
    FACGT  V29.2S, V3.2S, V19.2S
    FACGT  V31.2D, V1.2D, V22.2D
    FACGT  V1.2S, V4.2S, V24.2S
    FACGT  V0.2S, V7.2S, V1.2S
    FACGT  V15.4S, V13.4S, V0.4S
    FACGT  V4.4S, V15.4S, V0.4S
    FACGT  V1.2S, V23.2S, V29.2S
    FACGT  V26.2D, V16.2D, V27.2D
    FADD  V5.2D, V8.2D, V20.2D
    FADD  V19.2D, V2.2D, V4.2D
    FADD  V24.2S, V31.2S, V31.2S
    FADD  V7.4S, V24.4S, V19.4S
    FADD  V25.4S, V5.4S, V12.4S
    FADD  V14.2D, V2.2D, V26.2D
    FADD  V29.2D, V29.2D, V14.2D
    FADD  V2.2S, V14.2S, V15.2S
    FADD  V5.4S, V7.4S, V24.4S
    FADD  V0.2D, V29.2D, V1.2D
    FADDP D13, V29.2D
    FADDP D3, V0.2D
    FADDP D7, V21.2D
    FADDP D9, V5.2D
    FADDP D3, V7.2D
    FADDP D24, V9.2D
    FADDP D29, V7.2D
    FADDP D12, V25.2D
    FADDP D22, V2.2D
    FADDP D4, V22.2D
    FADDP S19, V4.2S
    FADDP S28, V2.2S
    FADDP S5, V19.2S
    FADDP S25, V12.2S
    FADDP S27, V30.2S
    FADDP S12, V5.2S
    FADDP S2, V6.2S
    FADDP S30, V12.2S
    FADDP S1, V16.2S
    FADDP S12, V27.2S
    FADDP  V22.2S, V12.2S, V3.2S
    FADDP  V3.2D, V1.2D, V9.2D
    FADDP  V14.2D, V13.2D, V8.2D
    FADDP  V0.2D, V28.2D, V30.2D
    FADDP  V11.2D, V22.2D, V14.2D
    FADDP  V5.2D, V24.2D, V24.2D
    FADDP  V1.4S, V3.4S, V5.4S
    FADDP  V14.2D, V0.2D, V2.2D
    FADDP  V7.2S, V3.2S, V26.2S
    FADDP  V30.2S, V25.2S, V14.2S
    FDIV  V2.4S, V12.4S, V30.4S
    FDIV  V19.2S, V29.2S, V7.2S
    FDIV  V5.2D, V1.2D, V19.2D
    FDIV  V0.4S, V9.4S, V5.4S
    FDIV  V27.2D, V3.2D, V5.2D
    FDIV  V22.2D, V2.2D, V11.2D
    FDIV  V13.2D, V22.2D, V11.2D
    FDIV  V14.4S, V27.4S, V13.4S
    FDIV  V4.2D, V26.2D, V31.2D
    FDIV  V31.4S, V24.4S, V29.4S
    FMLA D11, D10, V20.D[0x1]
    FMLA D9, D25, V28.D[0x0]
    FMLA D3, D10, V23.D[0x0]
    FMLA D1, D2, V8.D[0x0]
    FMLA D4, D20, V21.D[0x1]
    FMLA D2, D9, V4.D[0x1]
    FMLA D25, D3, V2.D[0x0]
    FMLA D27, D17, V4.D[0x1]
    FMLA D13, D12, V24.D[0x0]
    FMLA D20, D18, V23.D[0x0]
    FMLA S8, S13, V25.S[0x3]
    FMLA S5, S27, V8.S[0x1]
    FMLA S18, S20, V19.S[0x0]
    FMLA S17, S31, V5.S[0x3]
    FMLA S22, S11, V1.S[0x0]
    FMLA S31, S14, V22.S[0x0]
    FMLA S23, S23, V31.S[0x0]
    FMLA S1, S23, V23.S[0x2]
    FMLA S4, S14, V0.S[0x3]
    FMLA S26, S30, V1.S[0x1]
    FMLA V9.2D, V8.2D, V21.D[0x0]
    FMLA V21.2D, V1.2D, V13.D[0x1]
    FMLA V25.2D, V5.2D, V19.D[0x0]
    FMLA V0.2D, V17.2D, V21.D[0x1]
    FMLA V24.2D, V9.2D, V26.D[0x0]
    FMLA V7.2D, V1.2D, V25.D[0x0]
    FMLA V30.2D, V18.2D, V30.D[0x0]
    FMLA V22.2D, V24.2D, V27.D[0x0]
    FMLA V20.2D, V22.2D, V0.D[0x1]
    FMLA V17.2D, V21.2D, V2.D[0x1]
    FMLA V10.4S, V6.4S, V4.S[0x2]
    FMLA V18.2S, V20.2S, V31.S[0x1]
    FMLA V19.4S, V30.4S, V7.S[0x0]
    FMLA V0.2S, V18.2S, V17.S[0x1]
    FMLA V17.2S, V15.2S, V10.S[0x2]
    FMLA V0.2S, V0.2S, V17.S[0x1]
    FMLA V21.4S, V0.4S, V17.S[0x1]
    FMLA V17.2S, V3.2S, V21.S[0x3]
    FMLA V13.2S, V20.2S, V10.S[0x2]
    FMLA V15.2S, V31.2S, V2.S[0x3]
    FMLA  V3.4S, V23.4S, V23.4S
    FMLA  V4.4S, V4.4S, V13.4S
    FMLA  V20.4S, V22.4S, V10.4S
    FMLA  V7.4S, V24.4S, V2.4S
    FMLA  V21.4S, V31.4S, V29.4S
    FMLA  V29.4S, V0.4S, V25.4S
    FMLA  V25.2S, V12.2S, V4.2S
    FMLA  V30.2S, V13.2S, V19.2S
    FMLA  V0.2S, V7.2S, V21.2S
    FMLA  V19.4S, V15.4S, V0.4S
    FMLS D15, D10, V29.D[0x1]
    FMLS D14, D20, V19.D[0x1]
    FMLS D7, D13, V4.D[0x0]
    FMLS D29, D14, V7.D[0x0]
    FMLS D12, D18, V30.D[0x1]
    FMLS D6, D15, V30.D[0x0]
    FMLS D20, D3, V17.D[0x1]
    FMLS D19, D25, V12.D[0x1]
    FMLS D4, D8, V6.D[0x0]
    FMLS D20, D20, V19.D[0x1]
    FMLS S12, S4, V27.S[0x1]
    FMLS S19, S31, V12.S[0x0]
    FMLS S8, S0, V15.S[0x1]
    FMLS S21, S10, V29.S[0x3]
    FMLS S21, S8, V21.S[0x0]
    FMLS S29, S21, V19.S[0x1]
    FMLS S17, S14, V0.S[0x1]
    FMLS S24, S18, V18.S[0x1]
    FMLS S1, S24, V9.S[0x2]
    FMLS S27, S3, V12.S[0x1]
    FMLS V13.2D, V24.2D, V18.D[0x0]
    FMLS V3.2D, V23.2D, V10.D[0x0]
    FMLS V0.2D, V22.2D, V28.D[0x1]
    FMLS V23.2D, V11.2D, V26.D[0x0]
    FMLS V11.2D, V11.2D, V29.D[0x0]
    FMLS V4.2D, V27.2D, V30.D[0x1]
    FMLS V7.2D, V4.2D, V0.D[0x0]
    FMLS V14.2D, V20.2D, V9.D[0x0]
    FMLS V18.2D, V30.2D, V23.D[0x1]
    FMLS V27.2D, V19.2D, V9.D[0x0]
    FMLS V9.4S, V2.4S, V11.S[0x3]
    FMLS V11.2S, V23.2S, V28.S[0x3]
    FMLS V30.2S, V14.2S, V3.S[0x0]
    FMLS V2.2S, V30.2S, V27.S[0x0]
    FMLS V4.4S, V26.4S, V7.S[0x0]
    FMLS V6.4S, V6.4S, V13.S[0x1]
    FMLS V28.2S, V1.2S, V6.S[0x2]
    FMLS V16.2S, V27.2S, V8.S[0x3]
    FMLS V10.4S, V16.4S, V28.S[0x0]
    FMLS V13.2S, V26.2S, V15.S[0x0]
    FMLS  V29.2S, V10.2S, V13.2S
    FMLS  V21.4S, V30.4S, V9.4S
    FMLS  V6.2S, V10.2S, V11.2S
    FMLS  V15.2D, V2.2D, V4.2D
    FMLS  V23.4S, V15.4S, V17.4S
    FMLS  V2.2D, V6.2D, V6.2D
    FMLS  V24.2D, V18.2D, V2.2D
    FMLS  V14.2D, V9.2D, V22.2D
    FMLS  V26.2S, V1.2S, V23.2S
    FMLS  V3.2D, V21.2D, V21.2D
    FMOV  V28.2D, #0.22656250
    FMOV  V1.2D, #-1.81250000
    FMOV  V10.2D, #0.26562500
    FMOV  V0.2D, #-0.48437500
    FMOV  V6.2D, #3.12500000
    FMOV  V7.2D, #1.75000000
    FMOV  V16.2D, #3.25000000
    FMOV  V15.2D, #-27.00000000
    FMOV  V18.2D, #-0.14843750
    FMOV  V22.2D, #-0.29687500
    FMOV  V13.2S, #0.20312500
    FMOV  V4.4S, #0.46875000
    FMOV  V23.2S, #2.87500000
    FMOV  V2.2S, #-3.12500000
    FMOV  V9.2S, #-0.17187500
    FMOV  V21.2S, #0.65625000
    FMOV  V9.4S, #15.50000000
    FMOV  V19.4S, #-1.43750000
    FMOV  V21.4S, #-0.59375000
    FMOV  V9.2S, #-0.28125000
    FMUL D4, D2, V18.D[0x1]
    FMUL D18, D4, V27.D[0x0]
    FMUL D4, D26, V13.D[0x0]
    FMUL D13, D19, V15.D[0x1]
    FMUL D2, D7, V7.D[0x1]
    FMUL D7, D23, V22.D[0x0]
    FMUL D11, D30, V5.D[0x0]
    FMUL D19, D2, V2.D[0x0]
    FMUL D27, D14, V22.D[0x0]
    FMUL D2, D27, V4.D[0x0]
    FMUL S5, S11, V7.S[0x1]
    FMUL S2, S13, V12.S[0x1]
    FMUL S23, S21, V5.S[0x0]
    FMUL S13, S19, V25.S[0x3]
    FMUL S6, S21, V13.S[0x1]
    FMUL S18, S18, V6.S[0x2]
    FMUL S6, S18, V18.S[0x1]
    FMUL S18, S23, V6.S[0x0]
    FMUL S23, S11, V2.S[0x0]
    FMUL S14, S18, V17.S[0x2]
    FMUL V6.2D, V30.2D, V14.D[0x1]
    FMUL V5.2D, V23.2D, V6.D[0x1]
    FMUL V11.2D, V27.2D, V31.D[0x0]
    FMUL V25.2D, V16.2D, V16.D[0x1]
    FMUL V18.2D, V15.2D, V21.D[0x1]
    FMUL V21.2D, V18.2D, V0.D[0x0]
    FMUL V7.2D, V14.2D, V1.D[0x1]
    FMUL V18.2D, V18.2D, V10.D[0x0]
    FMUL V0.2D, V22.2D, V27.D[0x1]
    FMUL V27.2D, V6.2D, V29.D[0x1]
    FMUL V15.2S, V7.2S, V18.S[0x2]
    FMUL V16.4S, V25.4S, V21.S[0x2]
    FMUL V2.4S, V10.4S, V30.S[0x2]
    FMUL V22.4S, V25.4S, V19.S[0x3]
    FMUL V7.2S, V2.2S, V16.S[0x1]
    FMUL V13.2S, V0.2S, V7.S[0x1]
    FMUL V30.4S, V27.4S, V13.S[0x2]
    FMUL V7.2S, V11.2S, V11.S[0x1]
    FMUL V13.2S, V3.2S, V27.S[0x2]
    FMUL V11.2S, V30.2S, V22.S[0x2]
    FMUL  V3.2S, V4.2S, V7.2S
    FMUL  V22.2S, V27.2S, V12.2S
    FMUL  V4.2S, V11.2S, V11.2S
    FMUL  V25.2D, V4.2D, V22.2D
    FMUL  V30.2D, V15.2D, V13.2D
    FMUL  V18.4S, V29.4S, V30.4S
    FMUL  V31.2S, V25.2S, V18.2S
    FMUL  V30.4S, V3.4S, V31.4S
    FMUL  V10.2D, V19.2D, V24.2D
    FMUL  V16.2S, V30.2S, V22.2S
    FMULX D4, D31, V22.D[0x0]
    FMULX D30, D2, V23.D[0x1]
    FMULX D22, D15, V21.D[0x0]
    FMULX D18, D20, V3.D[0x0]
    FMULX D0, D1, V1.D[0x0]
    FMULX D6, D13, V23.D[0x0]
    FMULX D29, D29, V22.D[0x0]
    FMULX D4, D8, V4.D[0x0]
    FMULX D31, D15, V16.D[0x1]
    FMULX D2, D16, V19.D[0x0]
    FMULX S21, S30, V0.S[0x1]
    FMULX S22, S2, V16.S[0x1]
    FMULX S24, S4, V6.S[0x0]
    FMULX S25, S26, V24.S[0x1]
    FMULX S23, S25, V8.S[0x2]
    FMULX S4, S23, V23.S[0x0]
    FMULX S2, S10, V4.S[0x0]
    FMULX S23, S6, V18.S[0x1]
    FMULX S15, S22, V22.S[0x0]
    FMULX S16, S23, V21.S[0x0]
    FMULX V13.2D, V16.2D, V15.D[0x0]
    FMULX V11.2D, V2.2D, V20.D[0x0]
    FMULX V0.2D, V13.2D, V23.D[0x1]
    FMULX V10.2D, V29.2D, V2.D[0x1]
    FMULX V4.2D, V11.2D, V0.D[0x1]
    FMULX V6.2D, V4.2D, V27.D[0x0]
    FMULX V18.2D, V10.2D, V10.D[0x0]
    FMULX V1.2D, V26.2D, V10.D[0x0]
    FMULX V4.2D, V1.2D, V31.D[0x1]
    FMULX V4.2D, V29.2D, V18.D[0x1]
    FMULX V14.2S, V6.2S, V14.S[0x3]
    FMULX V11.2S, V11.2S, V6.S[0x1]
    FMULX V20.4S, V18.4S, V17.S[0x2]
    FMULX V2.2S, V8.2S, V28.S[0x0]
    FMULX V10.2S, V15.2S, V0.S[0x3]
    FMULX V27.2S, V4.2S, V8.S[0x1]
    FMULX V18.4S, V8.4S, V16.S[0x2]
    FMULX V24.2S, V2.2S, V17.S[0x0]
    FMULX V29.2S, V19.2S, V6.S[0x0]
    FMULX V1.4S, V17.4S, V15.S[0x2]
    MOVZ  X29, #0x7b0f, LSL #0
    MOVK  X29, #0x9eb2, LSL #16
    MOVK  X29, #0xd0a1, LSL #32
    MOVK  X29, #0xa047, LSL #48
    SUB  X26, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X29, #0x1667, LSL #0
    MOVK  X29, #0x800b, LSL #16
    MOVK  X29, #0xb27d, LSL #32
    MOVK  X29, #0xc3e4, LSL #48
    SUB  X26, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X29, #0x570c, LSL #0
    MOVK  X29, #0x6329, LSL #16
    MOVK  X29, #0x9345, LSL #32
    MOVK  X29, #0xe503, LSL #48
    SUB  X26, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X29, #0x32d7, LSL #0
    MOVK  X29, #0x7be7, LSL #16
    MOVK  X29, #0xd361, LSL #32
    MOVK  X29, #0x8e7a, LSL #48
    SUB  X26, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X29, #0x4cbb, LSL #0
    MOVK  X29, #0x64f7, LSL #16
    MOVK  X29, #0x9803, LSL #32
    MOVK  X29, #0xc7b2, LSL #48
    SUB  X26, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X29, #0x98f5, LSL #0
    MOVK  X29, #0x67b0, LSL #16
    MOVK  X29, #0x1b77, LSL #32
    MOVK  X29, #0x9b23, LSL #48
    SUB  X26, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X29, #0x6dc9, LSL #0
    MOVK  X29, #0x1a21, LSL #16
    MOVK  X29, #0x6def, LSL #32
    MOVK  X29, #0x5687, LSL #48
    SUB  X26, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X29, #0x57d2, LSL #0
    MOVK  X29, #0x81b2, LSL #16
    MOVK  X29, #0x3897, LSL #32
    MOVK  X29, #0xbce5, LSL #48
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X29, #0x85d3, LSL #0
    MOVK  X29, #0xd58d, LSL #16
    MOVK  X29, #0xa77d, LSL #32
    MOVK  X29, #0xd4d1, LSL #48
    SUB  X26, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X29, #0xbd6e, LSL #0
    MOVK  X29, #0xfe80, LSL #16
    MOVK  X29, #0xfc52, LSL #32
    MOVK  X29, #0x6c24, LSL #48
    SUB  X26, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X29, #0x3561, LSL #0
    MOVK  X29, #0xe8bf, LSL #16
    MOVK  X29, #0x4fc9, LSL #32
    MOVK  X29, #0x6b0a, LSL #48
    SUB  X26, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X29, #0xc6d1, LSL #0
    MOVK  X29, #0xbed6, LSL #16
    MOVK  X29, #0x81db, LSL #32
    MOVK  X29, #0x7ef, LSL #48
    SUB  X26, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X29, #0x8fb9, LSL #0
    MOVK  X29, #0xa64d, LSL #16
    MOVK  X29, #0x2342, LSL #32
    MOVK  X29, #0x3101, LSL #48
    SUB  X26, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X29, #0xc38d, LSL #0
    MOVK  X29, #0xbe22, LSL #16
    MOVK  X29, #0x43fd, LSL #32
    MOVK  X29, #0xc44c, LSL #48
    SUB  X26, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X29, #0x6730, LSL #0
    MOVK  X29, #0x2e65, LSL #16
    MOVK  X29, #0x3e21, LSL #32
    MOVK  X29, #0x9217, LSL #48
    SUB  X26, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X29, #0x6baf, LSL #0
    MOVK  X29, #0x6875, LSL #16
    MOVK  X29, #0x4874, LSL #32
    MOVK  X29, #0xebda, LSL #48
    SUB  X26, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X29, #0x9131, LSL #0
    MOVK  X29, #0x51c4, LSL #16
    MOVK  X29, #0x370a, LSL #32
    MOVK  X29, #0x938b, LSL #48
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X29, #0x8786, LSL #0
    MOVK  X29, #0x80ed, LSL #16
    MOVK  X29, #0xd8bd, LSL #32
    MOVK  X29, #0x862c, LSL #48
    SUB  X26, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X29, #0x4ada, LSL #0
    MOVK  X29, #0xbff3, LSL #16
    MOVK  X29, #0xcdb7, LSL #32
    MOVK  X29, #0x51bf, LSL #48
    SUB  X26, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X29, #0xd4fa, LSL #0
    MOVK  X29, #0x1a16, LSL #16
    MOVK  X29, #0xec47, LSL #32
    MOVK  X29, #0xd938, LSL #48
    SUB  X26, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MRS  X29, FPSR
    MOVZ  X26, #0x1b, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V0.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D0
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V1.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D1
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D2
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V3.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D3
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0x7fff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V4.D[1]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D4
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V5.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D5
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V6.D[1]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D6
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D7
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V8.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D8
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V9.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D9
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0xbe90, LSL #16
    MOVK  X26, #0xbe90, LSL #48
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V10.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D10
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0x7fff, LSL #16
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V11.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D11
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V12.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D12
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D13
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D14
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V15.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D15
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0x7fff, LSL #16
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V16.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D16
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D17
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V18.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D18
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V19.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D19
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0xc200, LSL #32
    MOVK  X26, #0x4022, LSL #48
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D20
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D21
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V22.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D22
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0x7fff, LSL #16
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D23
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D24
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V25.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D25
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0x7fff, LSL #16
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V26.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D26
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0x7fff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D27
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x3fcd, LSL #48
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D28
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x3fcd, LSL #48
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V29.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D29
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V30.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D30
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, V31.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X29, D31
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0xaf94, LSL #0
    MOVK  X2, #0x22c3, LSL #16
    MOVK  X2, #0xf0c, LSL #32
    MOVK  X2, #0x5b2a, LSL #48
    MOVZ  X3, #0x9cb4, LSL #0
    MOVK  X3, #0x2a42, LSL #16
    MOVK  X3, #0x34cd, LSL #32
    MOVK  X3, #0x178a, LSL #48
    MOVZ  X4, #0x3644, LSL #0
    MOVK  X4, #0x766, LSL #16
    MOVK  X4, #0x78e7, LSL #32
    MOVK  X4, #0xa6f9, LSL #48
    MOVZ  X5, #0x24e2, LSL #0
    MOVK  X5, #0x95ba, LSL #16
    MOVK  X5, #0x70ca, LSL #32
    MOVK  X5, #0x7136, LSL #48
    MOVZ  X6, #0xa733, LSL #0
    MOVK  X6, #0xd090, LSL #16
    MOVK  X6, #0x44a0, LSL #32
    MOVK  X6, #0x8690, LSL #48
    MOVZ  X7, #0xfb4e, LSL #0
    MOVK  X7, #0xd274, LSL #16
    MOVK  X7, #0xa71d, LSL #32
    MOVK  X7, #0x67cb, LSL #48
    MOVZ  X8, #0x96f2, LSL #0
    MOVK  X8, #0xefd6, LSL #16
    MOVK  X8, #0xa782, LSL #32
    MOVK  X8, #0x5c61, LSL #48
    MOVZ  X9, #0x3640, LSL #0
    MOVK  X9, #0xaea6, LSL #16
    MOVK  X9, #0x8385, LSL #32
    MOVK  X9, #0x83da, LSL #48
    MOVZ  X10, #0x38ba, LSL #0
    MOVK  X10, #0x6533, LSL #16
    MOVK  X10, #0x46e, LSL #32
    MOVK  X10, #0x5757, LSL #48
    MOVZ  X11, #0xb72e, LSL #0
    MOVK  X11, #0xe89a, LSL #16
    MOVK  X11, #0xdc86, LSL #32
    MOVK  X11, #0x49e6, LSL #48
    MOVZ  X12, #0xce94, LSL #0
    MOVK  X12, #0x66d7, LSL #16
    MOVK  X12, #0x4a14, LSL #32
    MOVK  X12, #0xf05, LSL #48
    MOVZ  X13, #0x3752, LSL #0
    MOVK  X13, #0xf15a, LSL #16
    MOVK  X13, #0xc25c, LSL #32
    MOVK  X13, #0xe717, LSL #48
    MOVZ  X14, #0x9264, LSL #0
    MOVK  X14, #0x9fbb, LSL #16
    MOVK  X14, #0xda9b, LSL #32
    MOVK  X14, #0xd6e, LSL #48
    MOVZ  X15, #0x1739, LSL #0
    MOVK  X15, #0x6ffa, LSL #16
    MOVK  X15, #0xa7b7, LSL #32
    MOVK  X15, #0xbe56, LSL #48
    MOVZ  X16, #0xcd51, LSL #0
    MOVK  X16, #0xa341, LSL #16
    MOVK  X16, #0x6738, LSL #32
    MOVK  X16, #0xc336, LSL #48
    MOVZ  X17, #0xfd96, LSL #0
    MOVK  X17, #0x234, LSL #16
    MOVK  X17, #0x7228, LSL #32
    MOVK  X17, #0xfe6d, LSL #48
    MOVZ  X23, #0x166a, LSL #0
    MOVK  X23, #0x5abf, LSL #16
    MOVK  X23, #0x28cf, LSL #32
    MOVK  X23, #0x33f9, LSL #48
    MOVZ  X24, #0xcb51, LSL #0
    MOVK  X24, #0x5ffe, LSL #16
    MOVK  X24, #0x8567, LSL #32
    MOVK  X24, #0xa02d, LSL #48
    MOVZ  X25, #0x4da1, LSL #0
    MOVK  X25, #0xcc8b, LSL #16
    MOVK  X25, #0xdd35, LSL #32
    MOVK  X25, #0xb800, LSL #48
    MOVZ  X26, #0x1ca1, LSL #0
    MOVK  X26, #0x7890, LSL #16
    MOVK  X26, #0xd5a1, LSL #32
    MOVK  X26, #0xcaf, LSL #48
    MOVZ  X27, #0xe305, LSL #0
    MOVK  X27, #0x4e22, LSL #16
    MOVK  X27, #0xb16, LSL #32
    MOVK  X27, #0xca76, LSL #48
    MOVZ  X28, #0xbd9b, LSL #0
    MOVK  X28, #0x2415, LSL #16
    MOVK  X28, #0x1164, LSL #32
    MOVK  X28, #0xe1de, LSL #48
    MOVZ  X29, #0x1345, LSL #0
    MOVK  X29, #0xa862, LSL #16
    MOVK  X29, #0x2ac9, LSL #32
    MOVK  X29, #0x31ac, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X23
    FMOV  D1, X10
    FMOV  V1.D[1], X26
    FMOV  D2, X5
    FMOV  V2.D[1], X29
    FMOV  D3, X15
    FMOV  V3.D[1], X8
    FMOV  D4, X5
    FMOV  V4.D[1], X6
    FMOV  D5, X28
    FMOV  V5.D[1], X17
    FMOV  D6, X17
    FMOV  V6.D[1], X27
    FMOV  D7, X12
    FMOV  V7.D[1], X2
    FMOV  D8, X17
    FMOV  V8.D[1], X15
    FMOV  D9, X16
    FMOV  V9.D[1], X15
    FMOV  D10, X6
    FMOV  V10.D[1], X29
    FMOV  D11, X27
    FMOV  V11.D[1], X9
    FMOV  D12, X9
    FMOV  V12.D[1], X14
    FMOV  D13, X15
    FMOV  V13.D[1], X27
    FMOV  D14, X25
    FMOV  V14.D[1], X6
    FMOV  D15, X7
    FMOV  V15.D[1], X4
    FMOV  D16, X7
    FMOV  V16.D[1], X7
    FMOV  D17, X23
    FMOV  V17.D[1], X28
    FMOV  D18, X2
    FMOV  V18.D[1], X10
    FMOV  D19, X17
    FMOV  V19.D[1], X6
    FMOV  D20, X7
    FMOV  V20.D[1], X12
    FMOV  D21, X25
    FMOV  V21.D[1], X11
    FMOV  D22, X24
    FMOV  V22.D[1], X6
    FMOV  D23, X12
    FMOV  V23.D[1], X26
    FMOV  D24, X27
    FMOV  V24.D[1], X14
    FMOV  D25, X26
    FMOV  V25.D[1], X2
    FMOV  D26, X7
    FMOV  V26.D[1], X6
    FMOV  D27, X5
    FMOV  V27.D[1], X15
    FMOV  D28, X27
    FMOV  V28.D[1], X25
    FMOV  D29, X29
    FMOV  V29.D[1], X15
    FMOV  D30, X11
    FMOV  V30.D[1], X2
    FMOV  D31, X14
    FMOV  V31.D[1], X8
    FMULX  V22.2S, V15.2S, V22.2S
    FMULX  V1.2S, V24.2S, V4.2S
    FMULX  V6.2S, V25.2S, V10.2S
    FMULX  V28.2S, V28.2S, V21.2S
    FMULX  V19.2S, V31.2S, V1.2S
    FMULX  V28.2D, V30.2D, V22.2D
    FMULX  V28.2D, V20.2D, V23.2D
    FMULX  V20.2D, V26.2D, V21.2D
    FMULX  V24.2S, V28.2S, V27.2S
    FMULX  V13.2S, V6.2S, V24.2S
    FNEG  V6.4S, V13.4S
    FNEG  V27.4S, V29.4S
    FNEG  V1.4S, V19.4S
    FNEG  V15.2D, V1.2D
    FNEG  V22.2D, V16.2D
    FNEG  V2.4S, V15.4S
    FNEG  V15.4S, V14.4S
    FNEG  V13.2D, V17.2D
    FNEG  V24.2D, V2.2D
    FNEG  V0.4S, V20.4S
    FRECPE  V2.2D, V13.2D
    FRECPE  V25.2S, V26.2S
    FRECPE  V17.4S, V11.4S
    FRECPE  V26.4S, V6.4S
    FRECPE  V28.4S, V31.4S
    FRECPE  V23.2S, V26.2S
    FRECPE  V20.4S, V0.4S
    FRECPE  V1.2D, V28.2D
    FRECPE  V6.2D, V4.2D
    FRECPE  V14.2S, V24.2S
    FRECPS  V22.2S, V23.2S, V20.2S
    FRECPS  V29.2D, V1.2D, V27.2D
    FRECPS  V24.2S, V29.2S, V2.2S
    FRECPS  V19.2D, V28.2D, V4.2D
    FRECPS  V29.4S, V18.4S, V14.4S
    FRECPS  V20.2S, V29.2S, V9.2S
    FRECPS  V26.4S, V25.4S, V25.4S
    FRECPS  V9.2S, V12.2S, V24.2S
    FRECPS  V18.2S, V17.2S, V5.2S
    FRECPS  V27.4S, V22.4S, V6.4S
    FRSQRTE  V31.2D, V27.2D
    FRSQRTE  V6.2S, V28.2S
    FRSQRTE  V28.4S, V19.4S
    FRSQRTE  V9.2D, V15.2D
    FRSQRTE  V14.2S, V19.2S
    FRSQRTE  V15.4S, V28.4S
    FRSQRTE  V5.2S, V18.2S
    FRSQRTE  V12.2D, V26.2D
    FRSQRTE  V26.2S, V26.2S
    FRSQRTE  V28.2D, V9.2D
    FRSQRTS  V1.4S, V15.4S, V28.4S
    FRSQRTS  V15.2D, V1.2D, V5.2D
    FRSQRTS  V6.4S, V26.4S, V20.4S
    FRSQRTS  V28.2S, V31.2S, V31.2S
    FRSQRTS  V31.2S, V14.2S, V14.2S
    FRSQRTS  V4.2S, V14.2S, V12.2S
    FRSQRTS  V19.4S, V31.4S, V29.4S
    FRSQRTS  V24.2D, V23.2D, V4.2D
    FRSQRTS  V9.4S, V18.4S, V10.4S
    FRSQRTS  V2.2D, V29.2D, V19.2D
    FSQRT  V18.2D, V8.2D
    FSQRT  V31.4S, V11.4S
    FSQRT  V29.4S, V5.4S
    FSQRT  V23.2S, V28.2S
    FSQRT  V27.2S, V23.2S
    FSQRT  V19.2D, V24.2D
    FSQRT  V8.4S, V6.4S
    FSQRT  V17.2S, V2.2S
    FSQRT  V24.4S, V7.4S
    FSQRT  V14.4S, V24.4S
    FSUB  V26.4S, V29.4S, V19.4S
    FSUB  V10.4S, V14.4S, V17.4S
    FSUB  V28.4S, V27.4S, V31.4S
    FSUB  V19.4S, V26.4S, V9.4S
    FSUB  V20.4S, V10.4S, V19.4S
    FSUB  V18.4S, V8.4S, V11.4S
    FSUB  V31.4S, V28.4S, V5.4S
    FSUB  V9.2D, V5.2D, V31.2D
    FSUB  V7.2S, V18.2S, V20.2S
    FSUB  V26.4S, V29.4S, V14.4S
    FABD  V23.8H, V26.8H, V22.8H
    FABD  V8.4H, V23.4H, V3.4H
    FABD  V4.8H, V9.8H, V9.8H
    FABD  V3.8H, V15.8H, V8.8H
    FABD  V18.4H, V23.4H, V3.4H
    FABD  V2.8H, V18.8H, V18.8H
    FABD  V2.4H, V0.4H, V4.4H
    FABD  V4.8H, V12.8H, V1.8H
    FABD  V11.8H, V2.8H, V5.8H
    FABD  V0.8H, V4.8H, V13.8H
    FABS  V1.4H, V0.4H
    FABS  V10.4H, V21.4H
    FABS  V15.8H, V11.8H
    FABS  V4.4H, V10.4H
    FABS  V18.4H, V4.4H
    FABS  V14.8H, V5.8H
    FABS  V21.8H, V14.8H
    FABS  V8.4H, V27.4H
    FABS  V26.4H, V21.4H
    FABS  V6.4H, V6.4H
    FACGE  V13.8H, V1.8H, V16.8H
    FACGE  V21.8H, V6.8H, V18.8H
    FACGE  V3.4H, V28.4H, V16.4H
    FACGE  V1.8H, V7.8H, V22.8H
    FACGE  V10.4H, V8.4H, V30.4H
    FACGE  V28.8H, V13.8H, V12.8H
    FACGE  V20.8H, V28.8H, V21.8H
    FACGE  V2.4H, V26.4H, V20.4H
    FACGE  V4.4H, V15.4H, V10.4H
    FACGE  V21.8H, V11.8H, V30.8H
    FACGT  V28.4H, V2.4H, V3.4H
    FACGT  V8.4H, V1.4H, V6.4H
    FACGT  V16.8H, V28.8H, V4.8H
    FACGT  V23.8H, V8.8H, V22.8H
    FACGT  V13.8H, V16.8H, V13.8H
    FACGT  V4.8H, V9.8H, V10.8H
    FACGT  V10.4H, V21.4H, V7.4H
    FACGT  V16.8H, V16.8H, V7.8H
    FACGT  V20.8H, V16.8H, V23.8H
    FACGT  V1.8H, V20.8H, V4.8H
    FADD  V5.4H, V12.4H, V10.4H
    FADD  V9.8H, V31.8H, V13.8H
    FADD  V23.4H, V28.4H, V5.4H
    FADD  V30.8H, V7.8H, V23.8H
    FADD  V22.8H, V9.8H, V1.8H
    FADD  V9.4H, V13.4H, V8.4H
    FADD  V11.4H, V31.4H, V14.4H
    FADD  V8.4H, V11.4H, V6.4H
    FADD  V5.8H, V8.8H, V13.8H
    FADD  V11.4H, V28.4H, V24.4H
    FADDP H26, V11.2H
    FADDP H4, V6.2H
    FADDP H13, V26.2H
    FADDP H15, V4.2H
    FADDP H30, V17.2H
    FADDP H24, V16.2H
    FADDP H23, V0.2H
    FADDP H20, V21.2H
    FADDP H8, V20.2H
    FADDP H20, V31.2H
    FADDP  V3.8H, V0.8H, V30.8H
    FADDP  V16.8H, V22.8H, V23.8H
    FADDP  V21.4H, V5.4H, V16.4H
    FADDP  V6.4H, V8.4H, V13.4H
    FADDP  V28.8H, V0.8H, V6.8H
    FADDP  V31.4H, V20.4H, V9.4H
    FADDP  V7.4H, V28.4H, V31.4H
    FADDP  V15.4H, V11.4H, V7.4H
    FADDP  V17.8H, V3.8H, V0.8H
    FADDP  V26.4H, V20.4H, V21.4H
    FDIV  V6.8H, V24.8H, V15.8H
    FDIV  V31.4H, V0.4H, V13.4H
    FDIV  V4.8H, V28.8H, V2.8H
    FDIV  V11.4H, V26.4H, V13.4H
    FDIV  V5.8H, V6.8H, V6.8H
    FDIV  V24.4H, V14.4H, V31.4H
    FDIV  V30.8H, V4.8H, V11.8H
    FDIV  V16.8H, V27.8H, V17.8H
    FDIV  V2.8H, V30.8H, V16.8H
    FDIV  V26.8H, V21.8H, V8.8H
    FMLA H4, H2, V2.H[0x1]
    FMLA H31, H24, V5.H[0x1]
    FMLA H26, H26, V3.H[0x5]
    FMLA H20, H4, V4.H[0x4]
    FMLA H1, H26, V8.H[0x4]
    FMLA H26, H1, V1.H[0x0]
    FMLA H6, H29, V14.H[0x3]
    FMLA H13, H28, V12.H[0x1]
    FMLA H24, H6, V15.H[0x1]
    FMLA H12, H13, V14.H[0x5]
    FMLA V13.8H, V4.8H, V10.H[0x1]
    FMLA V3.8H, V26.8H, V14.H[0x3]
    FMLA V27.4H, V11.4H, V5.H[0x5]
    FMLA V4.4H, V27.4H, V13.H[0x0]
    FMLA V29.8H, V12.8H, V13.H[0x1]
    FMLA V15.4H, V3.4H, V9.H[0x4]
    FMLA V16.8H, V15.8H, V11.H[0x0]
    FMLA V26.4H, V14.4H, V5.H[0x0]
    FMLA V27.4H, V20.4H, V7.H[0x3]
    FMLA V3.4H, V4.4H, V14.H[0x7]
    FMLA  V20.4H, V24.4H, V26.4H
    FMLA  V10.8H, V25.8H, V6.8H
    FMLA  V4.4H, V3.4H, V10.4H
    FMLA  V8.8H, V0.8H, V20.8H
    FMLA  V13.4H, V27.4H, V31.4H
    FMLA  V11.8H, V22.8H, V21.8H
    FMLA  V5.8H, V13.8H, V4.8H
    FMLA  V20.8H, V5.8H, V26.8H
    FMLA  V3.4H, V29.4H, V16.4H
    FMLA  V13.4H, V20.4H, V20.4H
    FMLS H22, H11, V1.H[0x1]
    FMLS H27, H3, V3.H[0x5]
    FMLS H3, H14, V13.H[0x6]
    FMLS H20, H8, V8.H[0x1]
    FMLS H13, H13, V3.H[0x4]
    FMLS H16, H22, V15.H[0x3]
    FMLS H0, H20, V13.H[0x6]
    FMLS H26, H27, V0.H[0x3]
    FMLS H24, H29, V9.H[0x1]
    FMLS H5, H1, V11.H[0x1]
    FMLS V13.8H, V28.8H, V9.H[0x2]
    FMLS V8.4H, V24.4H, V5.H[0x0]
    FMLS V28.8H, V6.8H, V9.H[0x7]
    FMLS V6.8H, V31.8H, V7.H[0x5]
    FMLS V5.4H, V29.4H, V14.H[0x0]
    FMLS V20.8H, V1.8H, V9.H[0x3]
    FMLS V29.8H, V27.8H, V10.H[0x6]
    FMLS V1.8H, V8.8H, V9.H[0x5]
    FMLS V31.8H, V17.8H, V10.H[0x2]
    FMLS V11.4H, V8.4H, V1.H[0x5]
    FMLS  V24.4H, V31.4H, V26.4H
    FMLS  V14.8H, V11.8H, V24.8H
    FMLS  V7.4H, V22.4H, V16.4H
    FMLS  V21.4H, V14.4H, V13.4H
    FMLS  V17.8H, V6.8H, V25.8H
    FMLS  V14.8H, V7.8H, V1.8H
    FMLS  V7.4H, V23.4H, V19.4H
    FMLS  V13.8H, V9.8H, V5.8H
    FMLS  V13.8H, V20.8H, V15.8H
    FMLS  V16.4H, V13.4H, V14.4H
    FMOV  V0.8H, #-17.00000000
    FMOV  V19.8H, #-1.12500000
    FMOV  V5.4H, #-0.17968750
    FMOV  V26.8H, #13.50000000
    FMOV  V9.4H, #7.25000000
    FMOV  V26.8H, #11.00000000
    FMOV  V15.4H, #-0.43750000
    FMOV  V20.4H, #0.34375000
    FMOV  V11.8H, #1.81250000
    FMOV  V1.8H, #0.14062500
    FMUL H31, H16, V11.H[0x6]
    FMUL H27, H29, V7.H[0x1]
    FMUL H8, H1, V5.H[0x1]
    FMUL H29, H9, V13.H[0x3]
    FMUL H25, H0, V4.H[0x6]
    FMUL H5, H19, V3.H[0x4]
    FMUL H23, H29, V4.H[0x5]
    FMUL H24, H5, V9.H[0x7]
    FMUL H11, H27, V10.H[0x3]
    FMUL H23, H15, V15.H[0x5]
    FMUL V10.4H, V28.4H, V8.H[0x1]
    FMUL V3.8H, V26.8H, V10.H[0x6]
    FMUL V6.4H, V31.4H, V3.H[0x3]
    FMUL V26.8H, V6.8H, V14.H[0x4]
    FMUL V16.4H, V11.4H, V9.H[0x2]
    FMUL V0.8H, V9.8H, V11.H[0x7]
    FMUL V1.8H, V16.8H, V0.H[0x0]
    FMUL V26.8H, V25.8H, V1.H[0x1]
    FMUL V26.8H, V23.8H, V2.H[0x1]
    FMUL V19.8H, V23.8H, V2.H[0x2]
    FMUL  V25.4H, V24.4H, V19.4H
    FMUL  V2.8H, V15.8H, V25.8H
    FMUL  V28.8H, V26.8H, V26.8H
    FMUL  V31.4H, V20.4H, V22.4H
    FMUL  V22.4H, V28.4H, V21.4H
    FMUL  V3.4H, V16.4H, V2.4H
    FMUL  V6.4H, V19.4H, V3.4H
    FMUL  V16.8H, V10.8H, V22.8H
    FMUL  V4.8H, V31.8H, V12.8H
    FMUL  V22.4H, V16.4H, V16.4H
    FMULX H21, H22, V13.H[0x3]
    FMULX H20, H4, V12.H[0x6]
    FMULX H1, H20, V10.H[0x3]
    FMULX H20, H0, V6.H[0x7]
    FMULX H13, H19, V1.H[0x0]
    FMULX H3, H21, V2.H[0x2]
    FMULX H26, H9, V13.H[0x3]
    FMULX H9, H2, V7.H[0x0]
    FMULX H27, H3, V2.H[0x5]
    FMULX H11, H4, V9.H[0x1]
    FMULX V15.4H, V14.4H, V11.H[0x3]
    FMULX V21.4H, V17.4H, V13.H[0x0]
    FMULX V1.4H, V21.4H, V15.H[0x1]
    FMULX V24.4H, V27.4H, V1.H[0x7]
    FMULX V28.8H, V16.8H, V12.H[0x2]
    FMULX V22.4H, V28.4H, V6.H[0x6]
    FMULX V30.8H, V0.8H, V0.H[0x0]
    FMULX V9.8H, V5.8H, V15.H[0x3]
    FMULX V12.8H, V24.8H, V7.H[0x5]
    FMULX V21.4H, V26.4H, V9.H[0x1]
    FMULX  V4.4H, V30.4H, V20.4H
    FMULX  V1.4H, V12.4H, V3.4H
    FMULX  V1.4H, V4.4H, V18.4H
    FMULX  V30.8H, V19.8H, V7.8H
    FMULX  V0.8H, V8.8H, V1.8H
    FMULX  V24.4H, V21.4H, V30.4H
    FMULX  V5.4H, V0.4H, V20.4H
    FMULX  V18.4H, V5.4H, V24.4H
    FMULX  V21.4H, V23.4H, V26.4H
    FMULX  V12.4H, V18.4H, V27.4H
    FNEG  V18.8H, V16.8H
    FNEG  V7.8H, V26.8H
    FNEG  V9.4H, V9.4H
    FNEG  V15.8H, V29.8H
    FNEG  V19.8H, V6.8H
    FNEG  V6.4H, V16.4H
    FNEG  V24.8H, V19.8H
    FNEG  V29.8H, V6.8H
    FNEG  V13.8H, V12.8H
    FNEG  V19.4H, V24.4H
    MOVZ  X26, #0xaf94, LSL #0
    MOVK  X26, #0x22c3, LSL #16
    MOVK  X26, #0xf0c, LSL #32
    MOVK  X26, #0x5b2a, LSL #48
    SUB  X27, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0x9cb4, LSL #0
    MOVK  X26, #0x2a42, LSL #16
    MOVK  X26, #0x34cd, LSL #32
    MOVK  X26, #0x178a, LSL #48
    SUB  X27, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0x3644, LSL #0
    MOVK  X26, #0x766, LSL #16
    MOVK  X26, #0x78e7, LSL #32
    MOVK  X26, #0xa6f9, LSL #48
    SUB  X27, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0x24e2, LSL #0
    MOVK  X26, #0x95ba, LSL #16
    MOVK  X26, #0x70ca, LSL #32
    MOVK  X26, #0x7136, LSL #48
    SUB  X27, X26, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xa733, LSL #0
    MOVK  X26, #0xd090, LSL #16
    MOVK  X26, #0x44a0, LSL #32
    MOVK  X26, #0x8690, LSL #48
    SUB  X27, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xfb4e, LSL #0
    MOVK  X26, #0xd274, LSL #16
    MOVK  X26, #0xa71d, LSL #32
    MOVK  X26, #0x67cb, LSL #48
    SUB  X27, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0x96f2, LSL #0
    MOVK  X26, #0xefd6, LSL #16
    MOVK  X26, #0xa782, LSL #32
    MOVK  X26, #0x5c61, LSL #48
    SUB  X27, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0x3640, LSL #0
    MOVK  X26, #0xaea6, LSL #16
    MOVK  X26, #0x8385, LSL #32
    MOVK  X26, #0x83da, LSL #48
    SUB  X27, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0x38ba, LSL #0
    MOVK  X26, #0x6533, LSL #16
    MOVK  X26, #0x46e, LSL #32
    MOVK  X26, #0x5757, LSL #48
    SUB  X27, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xb72e, LSL #0
    MOVK  X26, #0xe89a, LSL #16
    MOVK  X26, #0xdc86, LSL #32
    MOVK  X26, #0x49e6, LSL #48
    SUB  X27, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xce94, LSL #0
    MOVK  X26, #0x66d7, LSL #16
    MOVK  X26, #0x4a14, LSL #32
    MOVK  X26, #0xf05, LSL #48
    SUB  X27, X26, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0x3752, LSL #0
    MOVK  X26, #0xf15a, LSL #16
    MOVK  X26, #0xc25c, LSL #32
    MOVK  X26, #0xe717, LSL #48
    SUB  X27, X26, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0x9264, LSL #0
    MOVK  X26, #0x9fbb, LSL #16
    MOVK  X26, #0xda9b, LSL #32
    MOVK  X26, #0xd6e, LSL #48
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0x1739, LSL #0
    MOVK  X26, #0x6ffa, LSL #16
    MOVK  X26, #0xa7b7, LSL #32
    MOVK  X26, #0xbe56, LSL #48
    SUB  X27, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xcd51, LSL #0
    MOVK  X26, #0xa341, LSL #16
    MOVK  X26, #0x6738, LSL #32
    MOVK  X26, #0xc336, LSL #48
    SUB  X27, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xfd96, LSL #0
    MOVK  X26, #0x234, LSL #16
    MOVK  X26, #0x7228, LSL #32
    MOVK  X26, #0xfe6d, LSL #48
    SUB  X27, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0x166a, LSL #0
    MOVK  X26, #0x5abf, LSL #16
    MOVK  X26, #0x28cf, LSL #32
    MOVK  X26, #0x33f9, LSL #48
    SUB  X27, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xcb51, LSL #0
    MOVK  X26, #0x5ffe, LSL #16
    MOVK  X26, #0x8567, LSL #32
    MOVK  X26, #0xa02d, LSL #48
    SUB  X27, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0x4da1, LSL #0
    MOVK  X26, #0xcc8b, LSL #16
    MOVK  X26, #0xdd35, LSL #32
    MOVK  X26, #0xb800, LSL #48
    SUB  X27, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0x1345, LSL #0
    MOVK  X26, #0xa862, LSL #16
    MOVK  X26, #0x2ac9, LSL #32
    MOVK  X26, #0x31ac, LSL #48
    SUB  X27, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MRS  X26, FPSR
    MOVZ  X27, #0x1f, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V0.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D0
    MOVZ  X27, #0x8000, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V1.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D1
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D2
    MOVZ  X27, #0x7fc0, LSL #0
    MOVK  X27, #0x7fc0, LSL #16
    MOVK  X27, #0x7fc0, LSL #32
    MOVK  X27, #0x7fc0, LSL #48
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D3
    MOVZ  X27, #0x7fff, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D4
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D5
    MOVZ  X27, #0x8000, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D6
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X27, #0x8000, LSL #0
    MOVK  X27, #0x8000, LSL #16
    MOVK  X27, #0x8000, LSL #32
    MOVK  X27, #0x8000, LSL #48
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D7
    MOVZ  X27, #0x8000, LSL #0
    MOVK  X27, #0x8000, LSL #16
    MOVK  X27, #0x8000, LSL #32
    MOVK  X27, #0x8000, LSL #48
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D8
    MOVZ  X27, #0xa678, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D9
    MOVZ  X27, #0xffc0, LSL #0
    MOVK  X27, #0xffc0, LSL #16
    MOVK  X27, #0xffc0, LSL #32
    MOVK  X27, #0xffc0, LSL #48
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D10
    MOVZ  X27, #0x7fff, LSL #0
    MOVK  X27, #0x7fff, LSL #16
    MOVK  X27, #0x7fff, LSL #48
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V11.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D11
    MOVZ  X27, #0x7fff, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D12
    MOVZ  X27, #0x7fc0, LSL #0
    MOVK  X27, #0x7fc0, LSL #16
    MOVK  X27, #0x7fc0, LSL #32
    MOVK  X27, #0x7fc0, LSL #48
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X27, #0x8000, LSL #0
    MOVK  X27, #0x8000, LSL #16
    MOVK  X27, #0x8000, LSL #32
    MOVK  X27, #0x8000, LSL #48
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D13
    MOVZ  X27, #0xffc0, LSL #0
    MOVK  X27, #0xffc0, LSL #16
    MOVK  X27, #0xffc0, LSL #32
    MOVK  X27, #0xffc0, LSL #48
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D14
    MOVZ  X27, #0x7fff, LSL #0
    MOVK  X27, #0xfe00, LSL #16
    MOVK  X27, #0xffc0, LSL #32
    MOVK  X27, #0x7fc0, LSL #48
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X27, #0x8000, LSL #0
    MOVK  X27, #0x8000, LSL #16
    MOVK  X27, #0x8000, LSL #32
    MOVK  X27, #0x8000, LSL #48
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D15
    MOVZ  X27, #0x7fff, LSL #0
    MOVK  X27, #0x8000, LSL #16
    MOVK  X27, #0x8000, LSL #32
    MOVK  X27, #0x8000, LSL #48
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D16
    MOVZ  X27, #0x7fff, LSL #0
    MOVK  X27, #0x7fff, LSL #16
    MOVK  X27, #0x7fff, LSL #32
    MOVK  X27, #0x7fff, LSL #48
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X27, #0x7fff, LSL #0
    MOVK  X27, #0x7fff, LSL #16
    MOVK  X27, #0x42a5, LSL #32
    MOVK  X27, #0x7fff, LSL #48
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D17
    MOVZ  X27, #0x7fff, LSL #0
    MOVK  X27, #0x7fff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X27, #0x8000, LSL #0
    MOVK  X27, #0x8000, LSL #16
    MOVK  X27, #0x8000, LSL #32
    MOVK  X27, #0x8000, LSL #48
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D18
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D19
    MOVZ  X27, #0xffc0, LSL #0
    MOVK  X27, #0xffc0, LSL #16
    MOVK  X27, #0xffc0, LSL #32
    MOVK  X27, #0xffc0, LSL #48
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D20
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D21
    MOVZ  X27, #0x8000, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D22
    MOVZ  X27, #0x7fff, LSL #0
    MOVK  X27, #0x7fff, LSL #16
    MOVK  X27, #0x7fff, LSL #32
    MOVK  X27, #0x7fff, LSL #48
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D23
    MOVZ  X27, #0x8000, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D24
    MOVZ  X27, #0x7fc0, LSL #0
    MOVK  X27, #0x7fc0, LSL #16
    MOVK  X27, #0x7fc0, LSL #32
    MOVK  X27, #0x7fc0, LSL #48
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D25
    MOVZ  X27, #0x7fc0, LSL #0
    MOVK  X27, #0x7fc0, LSL #16
    MOVK  X27, #0x7fc0, LSL #32
    MOVK  X27, #0x7fc0, LSL #48
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V26.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D26
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D27
    MOVZ  X27, #0x7fff, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D28
    MOVZ  X27, #0x7fff, LSL #0
    MOVK  X27, #0x7fff, LSL #16
    MOVK  X27, #0x7fff, LSL #32
    MOVK  X27, #0x7fff, LSL #48
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X27, #0x8000, LSL #0
    MOVK  X27, #0x8000, LSL #16
    MOVK  X27, #0x8000, LSL #32
    MOVK  X27, #0x8000, LSL #48
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D29
    MOVZ  X27, #0x7fff, LSL #0
    MOVK  X27, #0x7fff, LSL #16
    MOVK  X27, #0x7fff, LSL #32
    MOVK  X27, #0x7fff, LSL #48
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V30.D[1]
    MOVZ  X27, #0x7fc0, LSL #0
    MOVK  X27, #0x7fc0, LSL #16
    MOVK  X27, #0x7fc0, LSL #32
    MOVK  X27, #0x7fc0, LSL #48
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D30
    MOVZ  X27, #0x7fc0, LSL #0
    MOVK  X27, #0x7fc0, LSL #16
    MOVK  X27, #0x7fc0, LSL #32
    MOVK  X27, #0x7fc0, LSL #48
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V31.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D31
    MOVZ  X27, #0x2cfe, LSL #0
    SUB  X28, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0xc2a4, LSL #0
    MOVK  X2, #0x1522, LSL #16
    MOVK  X2, #0x80ae, LSL #32
    MOVK  X2, #0xc349, LSL #48
    MOVZ  X3, #0x891a, LSL #0
    MOVK  X3, #0x23bb, LSL #16
    MOVK  X3, #0xc446, LSL #32
    MOVK  X3, #0x1cca, LSL #48
    MOVZ  X4, #0xb1dd, LSL #0
    MOVK  X4, #0xb5f1, LSL #16
    MOVK  X4, #0xa160, LSL #32
    MOVK  X4, #0xfb9e, LSL #48
    MOVZ  X5, #0xe9cb, LSL #0
    MOVK  X5, #0xc973, LSL #16
    MOVK  X5, #0x8200, LSL #32
    MOVK  X5, #0x263f, LSL #48
    MOVZ  X6, #0xc5ba, LSL #0
    MOVK  X6, #0x6b67, LSL #16
    MOVK  X6, #0x1d8e, LSL #32
    MOVK  X6, #0xd090, LSL #48
    MOVZ  X7, #0x778e, LSL #0
    MOVK  X7, #0xcdbc, LSL #16
    MOVK  X7, #0x19d, LSL #32
    MOVK  X7, #0x5efc, LSL #48
    MOVZ  X8, #0x7793, LSL #0
    MOVK  X8, #0x94d0, LSL #16
    MOVK  X8, #0x28c9, LSL #32
    MOVK  X8, #0x6c8f, LSL #48
    MOVZ  X9, #0xd75b, LSL #0
    MOVK  X9, #0x2f05, LSL #16
    MOVK  X9, #0xda1, LSL #32
    MOVK  X9, #0xa018, LSL #48
    MOVZ  X10, #0x7142, LSL #0
    MOVK  X10, #0x3692, LSL #16
    MOVK  X10, #0x866a, LSL #32
    MOVK  X10, #0xe879, LSL #48
    MOVZ  X11, #0x2454, LSL #0
    MOVK  X11, #0x491a, LSL #16
    MOVK  X11, #0x1ad0, LSL #32
    MOVK  X11, #0xa37, LSL #48
    MOVZ  X12, #0x1e83, LSL #0
    MOVK  X12, #0x2b84, LSL #16
    MOVK  X12, #0x429f, LSL #32
    MOVK  X12, #0x72bd, LSL #48
    MOVZ  X13, #0x19e5, LSL #0
    MOVK  X13, #0x9a69, LSL #16
    MOVK  X13, #0x7733, LSL #32
    MOVK  X13, #0x19, LSL #48
    MOVZ  X14, #0xdba0, LSL #0
    MOVK  X14, #0x6167, LSL #16
    MOVK  X14, #0xf2eb, LSL #32
    MOVK  X14, #0x3000, LSL #48
    MOVZ  X15, #0x5dd9, LSL #0
    MOVK  X15, #0x477e, LSL #16
    MOVK  X15, #0x62ad, LSL #32
    MOVK  X15, #0xa7cc, LSL #48
    MOVZ  X16, #0x815f, LSL #0
    MOVK  X16, #0xb844, LSL #16
    MOVK  X16, #0xf7b5, LSL #32
    MOVK  X16, #0xf463, LSL #48
    MOVZ  X17, #0xde54, LSL #0
    MOVK  X17, #0xf817, LSL #16
    MOVK  X17, #0x76a6, LSL #32
    MOVK  X17, #0x996, LSL #48
    MOVZ  X23, #0xbf09, LSL #0
    MOVK  X23, #0x752a, LSL #16
    MOVK  X23, #0xd94b, LSL #32
    MOVK  X23, #0xbd3, LSL #48
    MOVZ  X24, #0xfbdb, LSL #0
    MOVK  X24, #0x697d, LSL #16
    MOVK  X24, #0xdd6c, LSL #32
    MOVK  X24, #0xf90d, LSL #48
    MOVZ  X25, #0xcff3, LSL #0
    MOVK  X25, #0x5fa9, LSL #16
    MOVK  X25, #0xec82, LSL #32
    MOVK  X25, #0xad13, LSL #48
    MOVZ  X26, #0xd660, LSL #0
    MOVK  X26, #0x265e, LSL #16
    MOVK  X26, #0xd6ca, LSL #32
    MOVK  X26, #0xae57, LSL #48
    MOVZ  X27, #0x6260, LSL #0
    MOVK  X27, #0xe3f9, LSL #16
    MOVK  X27, #0x9b20, LSL #32
    MOVK  X27, #0x303e, LSL #48
    MOVZ  X28, #0xdc8d, LSL #0
    MOVK  X28, #0x751d, LSL #16
    MOVK  X28, #0x2fb1, LSL #32
    MOVK  X28, #0x3b6c, LSL #48
    MOVZ  X29, #0xb0b6, LSL #0
    MOVK  X29, #0x43ba, LSL #16
    MOVK  X29, #0x2b30, LSL #32
    MOVK  X29, #0x5ed5, LSL #48
    FMOV  D0, X10
    FMOV  V0.D[1], X26
    FMOV  D1, X15
    FMOV  V1.D[1], X27
    FMOV  D2, X9
    FMOV  V2.D[1], X17
    FMOV  D3, X29
    FMOV  V3.D[1], X26
    FMOV  D4, X15
    FMOV  V4.D[1], X28
    FMOV  D5, X17
    FMOV  V5.D[1], X2
    FMOV  D6, X27
    FMOV  V6.D[1], X4
    FMOV  D7, X5
    FMOV  V7.D[1], X7
    FMOV  D8, X23
    FMOV  V8.D[1], X23
    FMOV  D9, X25
    FMOV  V9.D[1], X14
    FMOV  D10, X14
    FMOV  V10.D[1], X28
    FMOV  D11, X13
    FMOV  V11.D[1], X16
    FMOV  D12, X3
    FMOV  V12.D[1], X2
    FMOV  D13, X2
    FMOV  V13.D[1], X23
    FMOV  D14, X16
    FMOV  V14.D[1], X15
    FMOV  D15, X16
    FMOV  V15.D[1], X10
    FMOV  D16, X24
    FMOV  V16.D[1], X9
    FMOV  D17, X17
    FMOV  V17.D[1], X9
    FMOV  D18, X9
    FMOV  V18.D[1], X9
    FMOV  D19, X12
    FMOV  V19.D[1], X27
    FMOV  D20, X17
    FMOV  V20.D[1], X14
    FMOV  D21, X29
    FMOV  V21.D[1], X2
    FMOV  D22, X29
    FMOV  V22.D[1], X4
    FMOV  D23, X25
    FMOV  V23.D[1], X23
    FMOV  D24, X7
    FMOV  V24.D[1], X7
    FMOV  D25, X13
    FMOV  V25.D[1], X5
    FMOV  D26, X24
    FMOV  V26.D[1], X6
    FMOV  D27, X25
    FMOV  V27.D[1], X26
    FMOV  D28, X9
    FMOV  V28.D[1], X23
    FMOV  D29, X16
    FMOV  V29.D[1], X15
    FMOV  D30, X14
    FMOV  V30.D[1], X28
    FMOV  D31, X16
    FMOV  V31.D[1], X15
    FRECPE  V0.8H, V23.8H
    FRECPE  V13.4H, V0.4H
    FRECPE  V17.4H, V13.4H
    FRECPE  V30.4H, V25.4H
    FRECPE  V8.8H, V20.8H
    FRECPE  V18.4H, V25.4H
    FRECPE  V21.8H, V29.8H
    FRECPE  V28.4H, V18.4H
    FRECPE  V25.8H, V27.8H
    FRECPE  V4.4H, V26.4H
    FRECPS  V30.8H, V24.8H, V28.8H
    FRECPS  V10.8H, V21.8H, V21.8H
    FRECPS  V13.8H, V0.8H, V8.8H
    FRECPS  V18.8H, V31.8H, V19.8H
    FRECPS  V3.8H, V25.8H, V0.8H
    FRECPS  V22.8H, V27.8H, V3.8H
    FRECPS  V31.8H, V10.8H, V13.8H
    FRECPS  V25.8H, V17.8H, V4.8H
    FRECPS  V4.8H, V18.8H, V16.8H
    FRECPS  V16.8H, V4.8H, V18.8H
    FRSQRTE  V21.4H, V31.4H
    FRSQRTE  V13.4H, V28.4H
    FRSQRTE  V17.8H, V22.8H
    FRSQRTE  V1.4H, V25.4H
    FRSQRTE  V20.4H, V1.4H
    FRSQRTE  V28.4H, V21.4H
    FRSQRTE  V0.4H, V24.4H
    FRSQRTE  V31.8H, V4.8H
    FRSQRTE  V10.8H, V30.8H
    FRSQRTE  V15.8H, V0.8H
    FRSQRTS  V8.8H, V13.8H, V13.8H
    FRSQRTS  V16.8H, V10.8H, V10.8H
    FRSQRTS  V24.4H, V8.4H, V17.4H
    FRSQRTS  V25.8H, V28.8H, V15.8H
    FRSQRTS  V29.4H, V31.4H, V24.4H
    FRSQRTS  V26.8H, V20.8H, V28.8H
    FRSQRTS  V1.4H, V15.4H, V14.4H
    FRSQRTS  V13.4H, V16.4H, V1.4H
    FRSQRTS  V30.8H, V13.8H, V31.8H
    FRSQRTS  V8.8H, V2.8H, V25.8H
    FSQRT  V20.8H, V15.8H
    FSQRT  V6.4H, V26.4H
    FSQRT  V13.4H, V30.4H
    FSQRT  V30.4H, V20.4H
    FSQRT  V2.8H, V8.8H
    FSQRT  V16.4H, V19.4H
    FSQRT  V17.8H, V30.8H
    FSQRT  V28.4H, V5.4H
    FSQRT  V24.8H, V17.8H
    FSQRT  V25.8H, V6.8H
    FSUB  V8.4H, V23.4H, V28.4H
    FSUB  V14.4H, V18.4H, V8.4H
    FSUB  V6.8H, V29.8H, V14.8H
    FSUB  V4.4H, V25.4H, V6.4H
    FSUB  V31.8H, V30.8H, V4.8H
    FSUB  V16.8H, V15.8H, V26.8H
    FSUB  V15.8H, V13.8H, V24.8H
    FSUB  V1.8H, V1.8H, V3.8H
    FSUB  V5.4H, V1.4H, V15.4H
    FSUB  V23.4H, V16.4H, V2.4H
    MOVZ  X11, #0xc2a4, LSL #0
    MOVK  X11, #0x1522, LSL #16
    MOVK  X11, #0x80ae, LSL #32
    MOVK  X11, #0xc349, LSL #48
    SUB  X14, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x891a, LSL #0
    MOVK  X11, #0x23bb, LSL #16
    MOVK  X11, #0xc446, LSL #32
    MOVK  X11, #0x1cca, LSL #48
    SUB  X14, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0xb1dd, LSL #0
    MOVK  X11, #0xb5f1, LSL #16
    MOVK  X11, #0xa160, LSL #32
    MOVK  X11, #0xfb9e, LSL #48
    SUB  X14, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0xe9cb, LSL #0
    MOVK  X11, #0xc973, LSL #16
    MOVK  X11, #0x8200, LSL #32
    MOVK  X11, #0x263f, LSL #48
    SUB  X14, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0xc5ba, LSL #0
    MOVK  X11, #0x6b67, LSL #16
    MOVK  X11, #0x1d8e, LSL #32
    MOVK  X11, #0xd090, LSL #48
    SUB  X14, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x778e, LSL #0
    MOVK  X11, #0xcdbc, LSL #16
    MOVK  X11, #0x19d, LSL #32
    MOVK  X11, #0x5efc, LSL #48
    SUB  X14, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x7793, LSL #0
    MOVK  X11, #0x94d0, LSL #16
    MOVK  X11, #0x28c9, LSL #32
    MOVK  X11, #0x6c8f, LSL #48
    SUB  X14, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0xd75b, LSL #0
    MOVK  X11, #0x2f05, LSL #16
    MOVK  X11, #0xda1, LSL #32
    MOVK  X11, #0xa018, LSL #48
    SUB  X14, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x7142, LSL #0
    MOVK  X11, #0x3692, LSL #16
    MOVK  X11, #0x866a, LSL #32
    MOVK  X11, #0xe879, LSL #48
    SUB  X14, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x1e83, LSL #0
    MOVK  X11, #0x2b84, LSL #16
    MOVK  X11, #0x429f, LSL #32
    MOVK  X11, #0x72bd, LSL #48
    SUB  X14, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x19e5, LSL #0
    MOVK  X11, #0x9a69, LSL #16
    MOVK  X11, #0x7733, LSL #32
    MOVK  X11, #0x19, LSL #48
    SUB  X14, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x5dd9, LSL #0
    MOVK  X11, #0x477e, LSL #16
    MOVK  X11, #0x62ad, LSL #32
    MOVK  X11, #0xa7cc, LSL #48
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x815f, LSL #0
    MOVK  X11, #0xb844, LSL #16
    MOVK  X11, #0xf7b5, LSL #32
    MOVK  X11, #0xf463, LSL #48
    SUB  X14, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0xde54, LSL #0
    MOVK  X11, #0xf817, LSL #16
    MOVK  X11, #0x76a6, LSL #32
    MOVK  X11, #0x996, LSL #48
    SUB  X14, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0xbf09, LSL #0
    MOVK  X11, #0x752a, LSL #16
    MOVK  X11, #0xd94b, LSL #32
    MOVK  X11, #0xbd3, LSL #48
    SUB  X14, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0xfbdb, LSL #0
    MOVK  X11, #0x697d, LSL #16
    MOVK  X11, #0xdd6c, LSL #32
    MOVK  X11, #0xf90d, LSL #48
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0xcff3, LSL #0
    MOVK  X11, #0x5fa9, LSL #16
    MOVK  X11, #0xec82, LSL #32
    MOVK  X11, #0xad13, LSL #48
    SUB  X14, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x6260, LSL #0
    MOVK  X11, #0xe3f9, LSL #16
    MOVK  X11, #0x9b20, LSL #32
    MOVK  X11, #0x303e, LSL #48
    SUB  X14, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0xdc8d, LSL #0
    MOVK  X11, #0x751d, LSL #16
    MOVK  X11, #0x2fb1, LSL #32
    MOVK  X11, #0x3b6c, LSL #48
    SUB  X14, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0xb0b6, LSL #0
    MOVK  X11, #0x43ba, LSL #16
    MOVK  X11, #0x2b30, LSL #32
    MOVK  X11, #0x5ed5, LSL #48
    SUB  X14, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MRS  X11, FPSR
    MOVZ  X14, #0x1f, LSL #0
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V0.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D0
    MOVZ  X14, #0x1dd4, LSL #0
    MOVK  X14, #0x7e00, LSL #16
    MOVK  X14, #0x7c00, LSL #32
    MOVK  X14, #0x2a0c, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V1.D[1]
    MOVZ  X14, #0xbffa, LSL #0
    MOVK  X14, #0xc000, LSL #16
    MOVK  X14, #0xbfff, LSL #32
    MOVK  X14, #0xf92a, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D1
    MOVZ  X14, #0xb7f8, LSL #0
    MOVK  X14, #0xfe00, LSL #16
    MOVK  X14, #0xb7fc, LSL #32
    MOVK  X14, #0x790d, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X14, #0x4c5e, LSL #0
    MOVK  X14, #0x58f3, LSL #16
    MOVK  X14, #0x7e00, LSL #32
    MOVK  X14, #0x3ce5, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D2
    MOVZ  X14, #0x7e00, LSL #0
    MOVK  X14, #0x7e00, LSL #16
    MOVK  X14, #0xfe00, LSL #32
    MOVK  X14, #0xfe00, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X14, #0x3ffa, LSL #0
    MOVK  X14, #0x4000, LSL #16
    MOVK  X14, #0x3fff, LSL #32
    MOVK  X14, #0x792a, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D3
    MOVZ  X14, #0x3ffe, LSL #0
    MOVK  X14, #0x3fff, LSL #16
    MOVK  X14, #0x3fff, LSL #32
    MOVK  X14, #0xd8eb, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D4
    MOVZ  X14, #0x7e00, LSL #0
    MOVK  X14, #0xfe00, LSL #16
    MOVK  X14, #0x7e00, LSL #32
    MOVK  X14, #0x7e00, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D5
    MOVZ  X14, #0xfe00, LSL #0
    MOVK  X14, #0xfe00, LSL #16
    MOVK  X14, #0xbee4, LSL #32
    MOVK  X14, #0x790c, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V6.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D6
    MOVZ  X14, #0x7e00, LSL #0
    MOVK  X14, #0xfe00, LSL #16
    MOVK  X14, #0xfbfe, LSL #32
    MOVK  X14, #0x7e00, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X14, #0x778e, LSL #0
    MOVK  X14, #0xcdbc, LSL #16
    MOVK  X14, #0x19d, LSL #32
    MOVK  X14, #0x5efc, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D7
    MOVZ  X14, #0xe9cb, LSL #0
    MOVK  X14, #0xc973, LSL #16
    MOVK  X14, #0x8200, LSL #32
    MOVK  X14, #0x263f, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D8
    MOVZ  X14, #0x7e00, LSL #0
    MOVK  X14, #0x7e00, LSL #16
    MOVK  X14, #0xecab, LSL #32
    MOVK  X14, #0xade8, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X14, #0xdba0, LSL #0
    MOVK  X14, #0x6167, LSL #16
    MOVK  X14, #0xf2eb, LSL #32
    MOVK  X14, #0x3000, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D9
    MOVZ  X14, #0xcff3, LSL #0
    MOVK  X14, #0x5fa9, LSL #16
    MOVK  X14, #0xec82, LSL #32
    MOVK  X14, #0xad13, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X14, #0x39a4, LSL #0
    MOVK  X14, #0x39a4, LSL #16
    MOVK  X14, #0x39a4, LSL #32
    MOVK  X14, #0x39a4, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D10
    MOVZ  X14, #0x7e00, LSL #0
    MOVK  X14, #0x39c4, LSL #16
    MOVK  X14, #0x39a4, LSL #32
    MOVK  X14, #0x39a4, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V11.D[1]
    MOVZ  X14, #0x815f, LSL #0
    MOVK  X14, #0xb844, LSL #16
    MOVK  X14, #0xf7b5, LSL #32
    MOVK  X14, #0xf463, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D11
    MOVZ  X14, #0x19e5, LSL #0
    MOVK  X14, #0x9a69, LSL #16
    MOVK  X14, #0x7733, LSL #32
    MOVK  X14, #0x19, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X14, #0xc2a4, LSL #0
    MOVK  X14, #0x1522, LSL #16
    MOVK  X14, #0x80ae, LSL #32
    MOVK  X14, #0xc349, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D12
    MOVZ  X14, #0x891a, LSL #0
    MOVK  X14, #0x23bb, LSL #16
    MOVK  X14, #0xc446, LSL #32
    MOVK  X14, #0x1cca, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D13
    MOVZ  X14, #0xfe00, LSL #0
    MOVK  X14, #0x7e00, LSL #16
    MOVK  X14, #0x3ce5, LSL #32
    MOVK  X14, #0x4733, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D14
    MOVZ  X14, #0x7e00, LSL #0
    MOVK  X14, #0x7e00, LSL #16
    MOVK  X14, #0x7bff, LSL #32
    MOVK  X14, #0x7bff, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D15
    MOVZ  X14, #0xfe00, LSL #0
    MOVK  X14, #0x7e00, LSL #16
    MOVK  X14, #0x3ce5, LSL #32
    MOVK  X14, #0x4619, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X14, #0x7c00, LSL #0
    MOVK  X14, #0x7c00, LSL #16
    MOVK  X14, #0x7c00, LSL #32
    MOVK  X14, #0x7c00, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D16
    MOVZ  X14, #0x7c00, LSL #0
    MOVK  X14, #0x7e00, LSL #16
    MOVK  X14, #0x7e00, LSL #32
    MOVK  X14, #0x7e00, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D17
    MOVZ  X14, #0x3d86, LSL #0
    MOVK  X14, #0x7e00, LSL #16
    MOVK  X14, #0x3cd6, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X14, #0xfbff, LSL #0
    MOVK  X14, #0x6f77, LSL #16
    MOVK  X14, #0x44f9, LSL #32
    MOVK  X14, #0x4002, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D18
    MOVZ  X14, #0x4000, LSL #0
    MOVK  X14, #0x4010, LSL #16
    MOVK  X14, #0x7bff, LSL #32
    MOVK  X14, #0x7bff, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X14, #0x6260, LSL #0
    MOVK  X14, #0xe3f9, LSL #16
    MOVK  X14, #0x9b20, LSL #32
    MOVK  X14, #0x303e, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D19
    MOVZ  X14, #0x1e83, LSL #0
    MOVK  X14, #0x2b84, LSL #16
    MOVK  X14, #0x429f, LSL #32
    MOVK  X14, #0x72bd, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X14, #0x7c00, LSL #0
    MOVK  X14, #0x7c00, LSL #16
    MOVK  X14, #0x7c00, LSL #32
    MOVK  X14, #0x7c00, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D20
    MOVZ  X14, #0x4347, LSL #0
    MOVK  X14, #0x7e00, LSL #16
    MOVK  X14, #0x4049, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D21
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x3724, LSL #16
    MOVK  X14, #0x7e00, LSL #32
    MOVK  X14, #0x7e00, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X14, #0x5a6b, LSL #0
    MOVK  X14, #0x3fcd, LSL #16
    MOVK  X14, #0x5ad9, LSL #32
    MOVK  X14, #0x6c18, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D22
    MOVZ  X14, #0x5418, LSL #0
    MOVK  X14, #0xe3a4, LSL #16
    MOVK  X14, #0x7081, LSL #32
    MOVK  X14, #0xc93d, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D23
    MOVZ  X14, #0x7e00, LSL #0
    MOVK  X14, #0x7e00, LSL #16
    MOVK  X14, #0x7e00, LSL #32
    MOVK  X14, #0x7e00, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D24
    MOVZ  X14, #0x3cb3, LSL #0
    MOVK  X14, #0x7e00, LSL #16
    MOVK  X14, #0x3c65, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D25
    MOVZ  X14, #0x7e00, LSL #0
    MOVK  X14, #0x3b12, LSL #16
    MOVK  X14, #0x7e00, LSL #32
    MOVK  X14, #0x7e00, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X14, #0x3e00, LSL #0
    MOVK  X14, #0x3e00, LSL #16
    MOVK  X14, #0x3e00, LSL #32
    MOVK  X14, #0x3e00, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D26
    MOVZ  X14, #0xfc00, LSL #0
    MOVK  X14, #0x38e4, LSL #16
    MOVK  X14, #0x7e00, LSL #32
    MOVK  X14, #0x7e00, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X14, #0xd660, LSL #0
    MOVK  X14, #0x265e, LSL #16
    MOVK  X14, #0xd6ca, LSL #32
    MOVK  X14, #0xae57, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D27
    MOVZ  X14, #0xcff3, LSL #0
    MOVK  X14, #0x5fa9, LSL #16
    MOVK  X14, #0xec82, LSL #32
    MOVK  X14, #0xad13, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D28
    MOVZ  X14, #0x7e00, LSL #0
    MOVK  X14, #0x7e00, LSL #16
    MOVK  X14, #0x5928, LSL #32
    MOVK  X14, #0x22af, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D29
    MOVZ  X14, #0x3de7, LSL #0
    MOVK  X14, #0xfe00, LSL #16
    MOVK  X14, #0x3dfd, LSL #32
    MOVK  X14, #0x7e00, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V30.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D30
    MOVZ  X14, #0x3fa1, LSL #0
    MOVK  X14, #0x7e00, LSL #16
    MOVK  X14, #0x3dda, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V31.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D31
    MOVZ  X14, #0x7e00, LSL #0
    MOVK  X14, #0x7e00, LSL #16
    MOVK  X14, #0x7e00, LSL #32
    MOVK  X14, #0x7e00, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0x9f29, LSL #0
    MOVK  X2, #0xe50f, LSL #16
    MOVK  X2, #0x9e42, LSL #32
    MOVK  X2, #0x5ea6, LSL #48
    MOVZ  X3, #0x4bee, LSL #0
    MOVK  X3, #0x3668, LSL #16
    MOVK  X3, #0xeed, LSL #32
    MOVK  X3, #0xaa9b, LSL #48
    MOVZ  X4, #0x70d9, LSL #0
    MOVK  X4, #0xc328, LSL #16
    MOVK  X4, #0x708, LSL #32
    MOVK  X4, #0x40e9, LSL #48
    MOVZ  X5, #0xa115, LSL #0
    MOVK  X5, #0x77c7, LSL #16
    MOVK  X5, #0xcfeb, LSL #32
    MOVK  X5, #0x6813, LSL #48
    MOVZ  X6, #0x3987, LSL #0
    MOVK  X6, #0x71d8, LSL #16
    MOVK  X6, #0xa377, LSL #32
    MOVK  X6, #0x3d9b, LSL #48
    MOVZ  X7, #0x5300, LSL #0
    MOVK  X7, #0xf518, LSL #16
    MOVK  X7, #0xf146, LSL #32
    MOVK  X7, #0x93e3, LSL #48
    MOVZ  X8, #0xf758, LSL #0
    MOVK  X8, #0xb9de, LSL #16
    MOVK  X8, #0xd12f, LSL #32
    MOVK  X8, #0x5fbc, LSL #48
    MOVZ  X9, #0x42a4, LSL #0
    MOVK  X9, #0x8299, LSL #16
    MOVK  X9, #0x668f, LSL #32
    MOVK  X9, #0x9313, LSL #48
    MOVZ  X10, #0xcd2d, LSL #0
    MOVK  X10, #0x9df4, LSL #16
    MOVK  X10, #0xdd15, LSL #32
    MOVK  X10, #0xecb1, LSL #48
    MOVZ  X11, #0xcab9, LSL #0
    MOVK  X11, #0xdeeb, LSL #16
    MOVK  X11, #0x24b1, LSL #32
    MOVK  X11, #0xa127, LSL #48
    MOVZ  X12, #0x636b, LSL #0
    MOVK  X12, #0xb6d7, LSL #16
    MOVK  X12, #0xb3c8, LSL #32
    MOVK  X12, #0x6410, LSL #48
    MOVZ  X13, #0x9fa, LSL #0
    MOVK  X13, #0xeb09, LSL #16
    MOVK  X13, #0xd0e1, LSL #32
    MOVK  X13, #0xd38f, LSL #48
    MOVZ  X14, #0x68ec, LSL #0
    MOVK  X14, #0xcda0, LSL #16
    MOVK  X14, #0x8ee8, LSL #32
    MOVK  X14, #0x49e4, LSL #48
    MOVZ  X15, #0xefdf, LSL #0
    MOVK  X15, #0x9f34, LSL #16
    MOVK  X15, #0x6529, LSL #32
    MOVK  X15, #0x2318, LSL #48
    MOVZ  X16, #0x5279, LSL #0
    MOVK  X16, #0x3467, LSL #16
    MOVK  X16, #0x83b7, LSL #32
    MOVK  X16, #0x332f, LSL #48
    MOVZ  X17, #0xb218, LSL #0
    MOVK  X17, #0xcfd, LSL #16
    MOVK  X17, #0x776b, LSL #32
    MOVK  X17, #0x6031, LSL #48
    MOVZ  X23, #0x5b46, LSL #0
    MOVK  X23, #0x6388, LSL #16
    MOVK  X23, #0x25ff, LSL #32
    MOVK  X23, #0x5050, LSL #48
    MOVZ  X24, #0xe3a3, LSL #0
    MOVK  X24, #0x178e, LSL #16
    MOVK  X24, #0x6218, LSL #32
    MOVK  X24, #0x467a, LSL #48
    MOVZ  X25, #0xd043, LSL #0
    MOVK  X25, #0xe313, LSL #16
    MOVK  X25, #0x83e1, LSL #32
    MOVK  X25, #0xf24b, LSL #48
    MOVZ  X26, #0x8214, LSL #0
    MOVK  X26, #0xfba9, LSL #16
    MOVK  X26, #0x54f5, LSL #32
    MOVK  X26, #0x1488, LSL #48
    MOVZ  X27, #0x50f5, LSL #0
    MOVK  X27, #0x54b0, LSL #16
    MOVK  X27, #0x8835, LSL #32
    MOVK  X27, #0xb40d, LSL #48
    MOVZ  X28, #0xff52, LSL #0
    MOVK  X28, #0x4d8c, LSL #16
    MOVK  X28, #0x8978, LSL #32
    MOVK  X28, #0x353, LSL #48
    MOVZ  X29, #0xc3fd, LSL #0
    MOVK  X29, #0x7992, LSL #16
    MOVK  X29, #0xdb31, LSL #32
    MOVK  X29, #0x111, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X5
    FMOV  D1, X12
    FMOV  V1.D[1], X25
    FMOV  D2, X29
    FMOV  V2.D[1], X27
    FMOV  D3, X17
    FMOV  V3.D[1], X7
    FMOV  D4, X28
    FMOV  V4.D[1], X28
    FMOV  D5, X10
    FMOV  V5.D[1], X9
    FMOV  D6, X2
    FMOV  V6.D[1], X14
    FMOV  D7, X10
    FMOV  V7.D[1], X3
    FMOV  D8, X28
    FMOV  V8.D[1], X4
    FMOV  D9, X15
    FMOV  V9.D[1], X15
    FMOV  D10, X14
    FMOV  V10.D[1], X15
    FMOV  D11, X27
    FMOV  V11.D[1], X26
    FMOV  D12, X16
    FMOV  V12.D[1], X23
    FMOV  D13, X12
    FMOV  V13.D[1], X3
    FMOV  D14, X28
    FMOV  V14.D[1], X26
    FMOV  D15, X7
    FMOV  V15.D[1], X7
    FMOV  D16, X24
    FMOV  V16.D[1], X12
    FMOV  D17, X8
    FMOV  V17.D[1], X6
    FMOV  D18, X15
    FMOV  V18.D[1], X9
    FMOV  D19, X23
    FMOV  V19.D[1], X15
    FMOV  D20, X4
    FMOV  V20.D[1], X15
    FMOV  D21, X9
    FMOV  V21.D[1], X24
    FMOV  D22, X24
    FMOV  V22.D[1], X8
    FMOV  D23, X26
    FMOV  V23.D[1], X24
    FMOV  D24, X10
    FMOV  V24.D[1], X10
    FMOV  D25, X24
    FMOV  V25.D[1], X9
    FMOV  D26, X2
    FMOV  V26.D[1], X26
    FMOV  D27, X6
    FMOV  V27.D[1], X9
    FMOV  D28, X2
    FMOV  V28.D[1], X16
    FMOV  D29, X23
    FMOV  V29.D[1], X23
    FMOV  D30, X7
    FMOV  V30.D[1], X9
    FMOV  D31, X23
    FMOV  V31.D[1], X17
    MOVZ  X27, #0xa, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_0:
    FMUL V23.8H, V25.8H, V1.H[0x4]
    FADDP D19, V27.2D
    FRECPS  V10.2D, V26.2D, V20.2D
    FACGT  V26.8H, V30.8H, V23.8H
    FMUL H20, H31, V4.H[0x2]
    FMLA V16.2D, V20.2D, V19.D[0x1]
    FMULX V26.4H, V29.4H, V15.H[0x6]
    FADD  V2.4H, V16.4H, V24.4H
    FMLA S29, S26, V24.S[0x3]
    FMULX D31, D25, V29.D[0x1]
    FMLS S29, S10, V22.S[0x1]
    FRSQRTE  V19.8H, V28.8H
    FACGE  V5.4S, V19.4S, V25.4S
    FMLA  V9.2S, V12.2S, V29.2S
    FDIV  V1.2S, V5.2S, V5.2S
    FRECPE  V16.2S, V13.2S
    FADD  V5.2S, V16.2S, V2.2S
    FADDP S26, V31.2S
    FABS  V28.4S, V5.4S
    FRSQRTE  V31.2D, V14.2D
    FADD  V15.4S, V18.4S, V1.4S
    FRSQRTS  V23.8H, V15.8H, V31.8H
    FMLA V2.4H, V23.4H, V7.H[0x6]
    FMLS  V30.8H, V2.8H, V30.8H
    FSUB  V7.2S, V26.2S, V18.2S
    FDIV  V22.4S, V28.4S, V30.4S
    FACGT  V13.2S, V1.2S, V9.2S
    FMULX H23, H25, V9.H[0x1]
    FMLS V24.4S, V27.4S, V13.S[0x3]
    FADDP S2, V22.2S
    FMOV  V13.2S, #19.00000000
    FSQRT  V12.8H, V2.8H
    FMLA  V31.2D, V7.2D, V1.2D
    FABS  V27.4S, V12.4S
    FMUL  V14.4H, V25.4H, V5.4H
    FMLA  V19.2S, V23.2S, V14.2S
    FRECPE  V6.8H, V24.8H
    FACGT  V14.4S, V6.4S, V31.4S
    FRSQRTE  V6.4H, V13.4H
    FRSQRTE  V26.4H, V1.4H
    FRSQRTS  V15.2D, V14.2D, V9.2D
    FDIV  V4.4H, V26.4H, V9.4H
    FRECPS  V30.2D, V15.2D, V27.2D
    FMULX H23, H8, V4.H[0x1]
    FRSQRTS  V9.2D, V20.2D, V20.2D
    FMOV  V16.4S, #-3.00000000
    FMLA D25, D19, V23.D[0x0]
    FRSQRTE  V11.2D, V9.2D
    FRECPE  V20.2S, V7.2S
    FADDP  V22.2S, V30.2S, V15.2S
    FMLA V12.2S, V12.2S, V4.S[0x0]
    FACGE  V5.8H, V16.8H, V20.8H
    FMLS D26, D13, V12.D[0x0]
    FRECPE  V19.2D, V5.2D
    FMUL V4.4S, V6.4S, V19.S[0x2]
    FADDP H14, V26.2H
    FACGE  V19.4H, V16.4H, V25.4H
    FMUL  V10.8H, V0.8H, V30.8H
    FADDP H31, V12.2H
    FRSQRTS  V0.4H, V19.4H, V4.4H
    FADDP S16, V0.2S
    FMOV  V12.4S, #11.00000000
    FSQRT  V24.2D, V12.2D
    FACGE  V5.2S, V29.2S, V14.2S
    FRECPE  V12.8H, V24.8H
    FMLA V4.2S, V12.2S, V22.S[0x0]
    FRECPE  V30.2S, V5.2S
    FMUL D6, D10, V10.D[0x1]
    FMLA  V15.8H, V24.8H, V30.8H
    FSQRT  V25.4S, V11.4S
    FSUB  V26.4S, V21.4S, V31.4S
    FSUB  V29.4S, V26.4S, V16.4S
    FMLA  V0.2S, V0.2S, V22.2S
    FACGE  V24.4S, V22.4S, V6.4S
    FMLS V20.4S, V3.4S, V14.S[0x0]
    FACGT  V19.8H, V18.8H, V4.8H
    FMLS D18, D19, V14.D[0x1]
    FABS  V19.4H, V24.4H
    FRECPE  V3.8H, V0.8H
    FMLS H4, H23, V5.H[0x2]
    FMOV  V0.2D, #1.81250000
    FRECPS  V21.8H, V25.8H, V15.8H
    FMLS  V13.2S, V26.2S, V4.2S
    FMLS S22, S2, V20.S[0x3]
    FRECPS  V10.4H, V22.4H, V21.4H
    FMLA  V5.8H, V3.8H, V19.8H
    FMULX V6.2D, V29.2D, V13.D[0x1]
    FADDP H8, V10.2H
    FMULX V3.2S, V5.2S, V14.S[0x1]
    FADDP H11, V7.2H
    FSUB  V2.4S, V0.4S, V18.4S
    FMULX D17, D22, V8.D[0x0]
    FACGE  V14.2D, V3.2D, V21.2D
    FDIV  V26.4S, V11.4S, V17.4S
    FABS  V0.8H, V27.8H
    FADD  V4.8H, V26.8H, V14.8H
    FADD  V0.4S, V14.4S, V2.4S
    FABS  V12.4S, V0.4S
    FRECPS  V18.4H, V27.4H, V11.4H
    FMLS  V7.2D, V10.2D, V6.2D
    FADD  V5.8H, V4.8H, V4.8H
    FMLA S15, S31, V7.S[0x0]
    FSQRT  V14.2S, V22.2S
    FACGT  V31.2D, V18.2D, V18.2D
    FRSQRTS  V17.2D, V15.2D, V18.2D
    FMLA H10, H26, V5.H[0x7]
    FMUL V4.8H, V10.8H, V11.H[0x4]
    FABD  V2.2D, V12.2D, V4.2D
    FMLA D15, D17, V2.D[0x0]
    FSQRT  V0.2D, V14.2D
    FDIV  V8.4S, V20.4S, V1.4S
    FMUL V6.2D, V15.2D, V21.D[0x0]
    FMUL  V8.4S, V15.4S, V8.4S
    FMLA D5, D0, V21.D[0x0]
    FMUL V27.4H, V2.4H, V13.H[0x0]
    FABD  V20.8H, V6.8H, V31.8H
    FABD  V26.8H, V26.8H, V9.8H
    FMOV  V3.2S, #16.00000000
    FMULX S10, S27, V26.S[0x0]
    FMULX  V27.2S, V3.2S, V27.2S
    FACGE  V3.4S, V24.4S, V13.4S
    FMULX  V14.8H, V10.8H, V27.8H
    FNEG  V27.4S, V30.4S
    FRECPE  V7.4H, V10.4H
    FMULX S3, S13, V20.S[0x0]
    FMOV  V1.2D, #-0.35937500
    FMULX V15.2D, V5.2D, V12.D[0x1]
    FDIV  V12.2S, V4.2S, V27.2S
    FMUL  V31.2D, V14.2D, V3.2D
    FSQRT  V27.8H, V29.8H
    FSUB  V9.4H, V7.4H, V12.4H
    FMLS V27.8H, V15.8H, V2.H[0x7]
    FABD  V12.2S, V27.2S, V13.2S
    FMLA V24.8H, V5.8H, V9.H[0x4]
    FRECPE  V29.4H, V20.4H
    FSQRT  V26.4H, V5.4H
    FMULX H9, H29, V7.H[0x0]
    FNEG  V3.4H, V14.4H
    FABD  V7.2D, V10.2D, V9.2D
    FMOV  V27.2D, #-23.00000000
    FSUB  V2.4S, V11.4S, V8.4S
    FMULX V0.2D, V19.2D, V30.D[0x0]
    FADD  V5.2S, V31.2S, V24.2S
    FMULX  V13.8H, V3.8H, V7.8H
    FMLA  V4.4H, V2.4H, V12.4H
    FRECPE  V31.4S, V4.4S
    FMUL H4, H13, V13.H[0x6]
    FADD  V30.4S, V4.4S, V5.4S
    FNEG  V6.2S, V10.2S
    FMOV  V5.2D, #-24.00000000
    FACGE  V7.2D, V0.2D, V27.2D
    FMLA  V11.8H, V31.8H, V5.8H
    FMULX  V20.4S, V20.4S, V19.4S
    FACGT  V27.4S, V20.4S, V14.4S
    FMUL V10.8H, V30.8H, V7.H[0x3]
    FSQRT  V3.4S, V4.4S
    FSQRT  V17.2D, V10.2D
    FMUL V31.4S, V6.4S, V17.S[0x0]
    FABS  V19.4S, V11.4S
    FSUB  V17.2D, V4.2D, V11.2D
    FDIV  V12.8H, V17.8H, V26.8H
    FMLS V7.8H, V18.8H, V12.H[0x5]
    FMLS H24, H13, V8.H[0x4]
    FABD  V13.4H, V3.4H, V24.4H
    FADDP  V10.2D, V13.2D, V22.2D
    FRSQRTE  V6.4S, V7.4S
    FMULX V17.8H, V31.8H, V14.H[0x5]
    FMLS  V23.4H, V27.4H, V24.4H
    FRECPS  V30.2D, V6.2D, V31.2D
    FMLA V8.2S, V29.2S, V23.S[0x1]
    FABD  V3.8H, V19.8H, V19.8H
    FABS  V31.8H, V15.8H
    FRECPS  V12.4H, V10.4H, V21.4H
    FMLS  V14.4H, V17.4H, V31.4H
    FMUL S26, S12, V8.S[0x2]
    FADD  V21.2D, V25.2D, V14.2D
    FRSQRTS  V12.2S, V3.2S, V21.2S
    FMLA  V13.2S, V10.2S, V12.2S
    FADDP H19, V2.2H
    FMLS H30, H13, V9.H[0x2]
    FADDP H15, V15.2H
    FRSQRTS  V2.2D, V15.2D, V26.2D
    FMLA V15.2D, V8.2D, V10.D[0x1]
    FSQRT  V9.4S, V13.4S
    FMOV  V25.4H, #-0.13281250
    FNEG  V27.4H, V19.4H
    FSQRT  V14.8H, V2.8H
    FMUL  V1.8H, V27.8H, V15.8H
    FMLS V2.2S, V28.2S, V9.S[0x0]
    FMLS D28, D31, V2.D[0x0]
    FMLS V21.2S, V1.2S, V1.S[0x1]
    FNEG  V10.2S, V3.2S
    FSQRT  V8.4H, V25.4H
    FRSQRTS  V9.4S, V31.4S, V8.4S
    FMUL  V19.4H, V28.4H, V30.4H
    FMOV  V25.2S, #-0.29687500
    FADDP H31, V19.2H
    FMLS V13.8H, V14.8H, V14.H[0x5]
    FMLA H14, H14, V14.H[0x3]
    FMLS D19, D10, V9.D[0x0]
    SUBS  X27, X27, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_0
    MOVZ  X26, #0x9f29, LSL #0
    MOVK  X26, #0xe50f, LSL #16
    MOVK  X26, #0x9e42, LSL #32
    MOVK  X26, #0x5ea6, LSL #48
    SUB  X15, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0x4bee, LSL #0
    MOVK  X26, #0x3668, LSL #16
    MOVK  X26, #0xeed, LSL #32
    MOVK  X26, #0xaa9b, LSL #48
    SUB  X15, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xa115, LSL #0
    MOVK  X26, #0x77c7, LSL #16
    MOVK  X26, #0xcfeb, LSL #32
    MOVK  X26, #0x6813, LSL #48
    SUB  X15, X26, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0x3987, LSL #0
    MOVK  X26, #0x71d8, LSL #16
    MOVK  X26, #0xa377, LSL #32
    MOVK  X26, #0x3d9b, LSL #48
    SUB  X15, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0x5300, LSL #0
    MOVK  X26, #0xf518, LSL #16
    MOVK  X26, #0xf146, LSL #32
    MOVK  X26, #0x93e3, LSL #48
    SUB  X15, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xf758, LSL #0
    MOVK  X26, #0xb9de, LSL #16
    MOVK  X26, #0xd12f, LSL #32
    MOVK  X26, #0x5fbc, LSL #48
    SUB  X15, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0x42a4, LSL #0
    MOVK  X26, #0x8299, LSL #16
    MOVK  X26, #0x668f, LSL #32
    MOVK  X26, #0x9313, LSL #48
    SUB  X15, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xcd2d, LSL #0
    MOVK  X26, #0x9df4, LSL #16
    MOVK  X26, #0xdd15, LSL #32
    MOVK  X26, #0xecb1, LSL #48
    SUB  X15, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xcab9, LSL #0
    MOVK  X26, #0xdeeb, LSL #16
    MOVK  X26, #0x24b1, LSL #32
    MOVK  X26, #0xa127, LSL #48
    SUB  X15, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0x636b, LSL #0
    MOVK  X26, #0xb6d7, LSL #16
    MOVK  X26, #0xb3c8, LSL #32
    MOVK  X26, #0x6410, LSL #48
    SUB  X15, X26, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0x9fa, LSL #0
    MOVK  X26, #0xeb09, LSL #16
    MOVK  X26, #0xd0e1, LSL #32
    MOVK  X26, #0xd38f, LSL #48
    SUB  X15, X26, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0x68ec, LSL #0
    MOVK  X26, #0xcda0, LSL #16
    MOVK  X26, #0x8ee8, LSL #32
    MOVK  X26, #0x49e4, LSL #48
    SUB  X15, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0x5279, LSL #0
    MOVK  X26, #0x3467, LSL #16
    MOVK  X26, #0x83b7, LSL #32
    MOVK  X26, #0x332f, LSL #48
    SUB  X15, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xb218, LSL #0
    MOVK  X26, #0xcfd, LSL #16
    MOVK  X26, #0x776b, LSL #32
    MOVK  X26, #0x6031, LSL #48
    SUB  X15, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0x5b46, LSL #0
    MOVK  X26, #0x6388, LSL #16
    MOVK  X26, #0x25ff, LSL #32
    MOVK  X26, #0x5050, LSL #48
    SUB  X15, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xe3a3, LSL #0
    MOVK  X26, #0x178e, LSL #16
    MOVK  X26, #0x6218, LSL #32
    MOVK  X26, #0x467a, LSL #48
    SUB  X15, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xd043, LSL #0
    MOVK  X26, #0xe313, LSL #16
    MOVK  X26, #0x83e1, LSL #32
    MOVK  X26, #0xf24b, LSL #48
    SUB  X15, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xff52, LSL #0
    MOVK  X26, #0x4d8c, LSL #16
    MOVK  X26, #0x8978, LSL #32
    MOVK  X26, #0x353, LSL #48
    SUB  X15, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xc3fd, LSL #0
    MOVK  X26, #0x7992, LSL #16
    MOVK  X26, #0xdb31, LSL #32
    MOVK  X26, #0x111, LSL #48
    SUB  X15, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MRS  X26, FPSR
    MOVZ  X15, #0x1f, LSL #0
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V0.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7f80, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D0
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7f80, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V1.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D1
    MOVZ  X15, #0x7fff, LSL #0
    MOVK  X15, #0x7ff6, LSL #32
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D2
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0x7ffe, LSL #32
    MOVK  X15, #0xffc0, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7f80, LSL #16
    MOVK  X15, #0x7f80, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D3
    MOVZ  X15, #0x7fff, LSL #0
    MOVK  X15, #0x7fff, LSL #16
    MOVK  X15, #0x7ffe, LSL #32
    MOVK  X15, #0x7fc0, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D4
    MOVZ  X15, #0xffff, LSL #0
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc038, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D5
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc038, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X15, #0x7f80, LSL #0
    MOVK  X15, #0x7fc0, LSL #16
    MOVK  X15, #0x7f80, LSL #32
    MOVK  X15, #0x7fc0, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D6
    MOVZ  X15, #0x7fff, LSL #0
    MOVK  X15, #0x7fff, LSL #16
    MOVK  X15, #0x7f80, LSL #32
    MOVK  X15, #0x7fc0, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X15, #0x7f80, LSL #0
    MOVK  X15, #0x7f80, LSL #16
    MOVK  X15, #0x7f80, LSL #32
    MOVK  X15, #0x7f80, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D7
    MOVZ  X15, #0x7fff, LSL #0
    MOVK  X15, #0x7fff, LSL #16
    MOVK  X15, #0x7f80, LSL #32
    MOVK  X15, #0x7f80, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D8
    MOVZ  X15, #0x7e00, LSL #0
    MOVK  X15, #0x7e00, LSL #16
    MOVK  X15, #0x7e00, LSL #32
    MOVK  X15, #0x7e00, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x3fc0, LSL #16
    MOVK  X15, #0x3fc0, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D9
    MOVZ  X15, #0x7fff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0x7fff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D10
    MOVZ  X15, #0x7fff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0x7ffe, LSL #32
    MOVK  X15, #0xffc0, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V11.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7f80, LSL #16
    MOVK  X15, #0x7f80, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D11
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0x7ffe, LSL #32
    MOVK  X15, #0xffc0, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D12
    MOVZ  X15, #0x7fff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0x7ffe, LSL #32
    MOVK  X15, #0xffc0, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D13
    MOVZ  X15, #0x7fff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0x7ffe, LSL #32
    MOVK  X15, #0xffc0, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D14
    MOVZ  X15, #0xffff, LSL #0
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D15
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xbff0, LSL #16
    MOVK  X15, #0x7ff6, LSL #32
    MOVK  X15, #0xbea0, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D16
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X15, #0x7fff, LSL #0
    MOVK  X15, #0x7fc0, LSL #16
    MOVK  X15, #0x7fff, LSL #32
    MOVK  X15, #0x7fc0, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D17
    MOVZ  X15, #0x7fff, LSL #0
    MOVK  X15, #0xffc0, LSL #16
    MOVK  X15, #0x7fff, LSL #32
    MOVK  X15, #0x7fc0, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D18
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0x4000, LSL #32
    MOVK  X15, #0x4000, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D19
    MOVZ  X15, #0x7fff, LSL #0
    MOVK  X15, #0x7fff, LSL #16
    MOVK  X15, #0x7fff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X15, #0x7fff, LSL #0
    MOVK  X15, #0x7fff, LSL #16
    MOVK  X15, #0x7fff, LSL #32
    MOVK  X15, #0x7fff, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D20
    MOVZ  X15, #0x7fff, LSL #0
    MOVK  X15, #0x7fff, LSL #16
    MOVK  X15, #0x7fff, LSL #32
    MOVK  X15, #0x7fff, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D21
    MOVZ  X15, #0x7fff, LSL #0
    MOVK  X15, #0x7fc0, LSL #16
    MOVK  X15, #0x7fff, LSL #32
    MOVK  X15, #0x7fff, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D22
    MOVZ  X15, #0x7fff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D23
    MOVZ  X15, #0x7e00, LSL #0
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D24
    MOVZ  X15, #0x7fff, LSL #0
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D25
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xbe98, LSL #16
    MOVK  X15, #0xbe98, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V26.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D26
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D27
    MOVZ  X15, #0x7fff, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0x8000, LSL #32
    MOVK  X15, #0x8000, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D28
    MOVZ  X15, #0x7fff, LSL #0
    MOVK  X15, #0x7fff, LSL #16
    MOVK  X15, #0x7fff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D29
    MOVZ  X15, #0x7fff, LSL #0
    MOVK  X15, #0x7fff, LSL #16
    MOVK  X15, #0x7fff, LSL #32
    MOVK  X15, #0x7fff, LSL #48
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V30.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D30
    MOVZ  X15, #0xffff, LSL #0
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V31.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D31
    MOVZ  X15, #0x7fff, LSL #0
    SUB  X4, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorFloatingPointOperation_TestFail
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
    FMOV  V0.D[1], X27
    FMOV  D1, X15
    FMOV  V1.D[1], X13
    FMOV  D2, X23
    FMOV  V2.D[1], X2
    FMOV  D3, X29
    FMOV  V3.D[1], X16
    FMOV  D4, X17
    FMOV  V4.D[1], X25
    FMOV  D5, X24
    FMOV  V5.D[1], X29
    FMOV  D6, X28
    FMOV  V6.D[1], X14
    FMOV  D7, X26
    FMOV  V7.D[1], X11
    FMOV  D8, X10
    FMOV  V8.D[1], X29
    FMOV  D9, X24
    FMOV  V9.D[1], X25
    FMOV  D10, X4
    FMOV  V10.D[1], X15
    FMOV  D11, X15
    FMOV  V11.D[1], X8
    FMOV  D12, X15
    FMOV  V12.D[1], X15
    FMOV  D13, X2
    FMOV  V13.D[1], X27
    FMOV  D14, X8
    FMOV  V14.D[1], X25
    FMOV  D15, X4
    FMOV  V15.D[1], X2
    FMOV  D16, X12
    FMOV  V16.D[1], X28
    FMOV  D17, X12
    FMOV  V17.D[1], X15
    FMOV  D18, X28
    FMOV  V18.D[1], X10
    FMOV  D19, X28
    FMOV  V19.D[1], X8
    FMOV  D20, X9
    FMOV  V20.D[1], X14
    FMOV  D21, X28
    FMOV  V21.D[1], X6
    FMOV  D22, X9
    FMOV  V22.D[1], X25
    FMOV  D23, X15
    FMOV  V23.D[1], X9
    FMOV  D24, X2
    FMOV  V24.D[1], X16
    FMOV  D25, X8
    FMOV  V25.D[1], X6
    FMOV  D26, X13
    FMOV  V26.D[1], X12
    FMOV  D27, X15
    FMOV  V27.D[1], X28
    FMOV  D28, X29
    FMOV  V28.D[1], X8
    FMOV  D29, X7
    FMOV  V29.D[1], X3
    FMOV  D30, X8
    FMOV  V30.D[1], X14
    FMOV  D31, X5
    FMOV  V31.D[1], X10
    MOVZ  X13, #0xa, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_1:
    FMLA V0.4H, V31.4H, V9.H[0x4]
    FMLA H27, H27, V2.H[0x6]
    FMULX S2, S0, V20.S[0x1]
    FDIV  V6.2D, V7.2D, V29.2D
    FMULX V2.2D, V2.2D, V26.D[0x0]
    FMUL V9.2S, V19.2S, V28.S[0x3]
    FNEG  V24.8H, V22.8H
    FMUL H5, H19, V11.H[0x7]
    FMUL H4, H5, V5.H[0x7]
    FSUB  V8.4H, V4.4H, V24.4H
    FADDP D21, V6.2D
    FMUL  V14.2S, V21.2S, V8.2S
    FMLS D7, D14, V27.D[0x0]
    FRECPE  V4.4S, V25.4S
    FMLS  V25.2D, V2.2D, V28.2D
    FMUL V1.2D, V25.2D, V7.D[0x0]
    FABD  V5.4S, V9.4S, V4.4S
    FMUL V20.2S, V5.2S, V4.S[0x2]
    FABS  V4.8H, V9.8H
    FMUL H29, H4, V11.H[0x4]
    FMLS S0, S4, V20.S[0x3]
    FMLA S11, S7, V29.S[0x1]
    FMLA V8.2D, V1.2D, V6.D[0x0]
    FSQRT  V5.4H, V0.4H
    FDIV  V19.8H, V11.8H, V8.8H
    FNEG  V22.4H, V19.4H
    FRSQRTS  V7.4S, V22.4S, V5.4S
    FMULX V8.2D, V24.2D, V10.D[0x1]
    FADDP S27, V5.2S
    FMLA H13, H24, V7.H[0x6]
    FNEG  V19.4H, V9.4H
    FADDP  V11.2S, V3.2S, V27.2S
    FMLA D6, D18, V5.D[0x1]
    FADD  V7.8H, V27.8H, V5.8H
    FABD  V25.4H, V12.4H, V8.4H
    FMLS V3.4H, V20.4H, V8.H[0x3]
    FMULX  V5.8H, V20.8H, V11.8H
    FNEG  V24.8H, V23.8H
    FMLS D27, D20, V4.D[0x0]
    FACGT  V23.4S, V27.4S, V7.4S
    FMUL V18.4S, V7.4S, V3.S[0x3]
    FMLS  V20.2D, V5.2D, V25.2D
    FRECPE  V0.8H, V24.8H
    FMUL H25, H7, V6.H[0x0]
    FMLS V12.4S, V18.4S, V14.S[0x3]
    FRSQRTS  V28.4H, V19.4H, V6.4H
    FMOV  V11.4H, #-1.56250000
    FMLS H19, H16, V12.H[0x5]
    FMULX  V4.2D, V9.2D, V17.2D
    FNEG  V12.4H, V7.4H
    FMULX V3.4H, V4.4H, V1.H[0x0]
    FMUL  V17.2S, V12.2S, V13.2S
    FMUL V22.4S, V10.4S, V3.S[0x1]
    FRSQRTE  V25.2D, V23.2D
    FMLS V1.4H, V22.4H, V11.H[0x7]
    FRSQRTS  V4.8H, V28.8H, V26.8H
    FACGT  V10.2D, V17.2D, V4.2D
    FMLA  V24.4S, V3.4S, V1.4S
    FABD  V16.4S, V25.4S, V3.4S
    FMLA V13.4S, V20.4S, V20.S[0x1]
    FADDP S5, V25.2S
    FABD  V26.2D, V0.2D, V0.2D
    FMLA  V0.2S, V19.2S, V13.2S
    FMULX  V22.2D, V20.2D, V10.2D
    FMLS H11, H22, V0.H[0x7]
    FMUL V20.2S, V11.2S, V5.S[0x2]
    FACGT  V13.2S, V20.2S, V26.2S
    FACGE  V25.2S, V16.2S, V14.2S
    FRECPE  V17.8H, V24.8H
    FMOV  V3.2S, #-3.87500000
    FMUL  V16.4H, V25.4H, V17.4H
    FSQRT  V22.4H, V12.4H
    FDIV  V28.8H, V13.8H, V25.8H
    FMLA V0.4S, V19.4S, V22.S[0x3]
    FSQRT  V25.4H, V28.4H
    FMLA S19, S3, V0.S[0x0]
    FMLA  V28.2D, V19.2D, V25.2D
    FSQRT  V14.2S, V16.2S
    FMULX V19.2S, V26.2S, V19.S[0x3]
    FMULX V16.8H, V8.8H, V1.H[0x3]
    FMUL  V1.2S, V16.2S, V25.2S
    FMOV  V13.2D, #-2.37500000
    FACGE  V22.2S, V2.2S, V30.2S
    FADDP H30, V13.2H
    FMUL  V2.4H, V19.4H, V25.4H
    FRSQRTE  V17.8H, V29.8H
    FMULX V24.4H, V23.4H, V5.H[0x0]
    FABS  V31.4S, V31.4S
    FMULX S16, S1, V14.S[0x0]
    FMULX H19, H10, V2.H[0x0]
    FADDP  V3.2D, V2.2D, V26.2D
    FMLA H1, H19, V3.H[0x2]
    FACGT  V0.2D, V19.2D, V24.2D
    FABS  V3.8H, V23.8H
    FMLS S20, S12, V18.S[0x0]
    FRECPS  V12.2D, V16.2D, V27.2D
    FMLA V2.4H, V1.4H, V0.H[0x2]
    FMLS D20, D6, V22.D[0x1]
    FACGT  V29.2S, V17.2S, V2.2S
    FRSQRTS  V24.4H, V9.4H, V3.4H
    FMUL V1.4H, V31.4H, V9.H[0x3]
    FACGE  V26.2S, V12.2S, V12.2S
    FMLS V8.2D, V29.2D, V1.D[0x1]
    FMLS H10, H24, V1.H[0x6]
    FMLS  V3.4H, V10.4H, V8.4H
    FNEG  V18.2S, V3.2S
    FMLS  V1.4S, V26.4S, V16.4S
    FMULX H27, H20, V1.H[0x3]
    FMUL D2, D12, V27.D[0x1]
    FMULX V9.8H, V13.8H, V2.H[0x7]
    FMUL V12.4S, V18.4S, V14.S[0x0]
    FADD  V23.4H, V15.4H, V25.4H
    FMULX D26, D9, V25.D[0x1]
    FMULX H19, H12, V12.H[0x1]
    FMLS H27, H23, V0.H[0x7]
    FACGE  V14.8H, V8.8H, V19.8H
    FMLA  V12.8H, V14.8H, V15.8H
    FMUL  V3.4S, V0.4S, V3.4S
    FMUL V31.2S, V31.2S, V27.S[0x0]
    FRECPS  V14.2S, V3.2S, V3.2S
    FADDP  V0.4H, V28.4H, V12.4H
    FMOV  V9.2D, #-31.00000000
    FRSQRTS  V22.8H, V9.8H, V0.8H
    FMUL V18.8H, V14.8H, V14.H[0x7]
    FRECPE  V3.2D, V22.2D
    FABS  V26.4S, V5.4S
    FMLS D13, D30, V6.D[0x1]
    FMLS  V2.2S, V31.2S, V2.2S
    FMULX H23, H26, V3.H[0x7]
    FRSQRTE  V15.4H, V23.4H
    FRECPS  V27.4H, V18.4H, V18.4H
    FADDP  V10.2D, V27.2D, V15.2D
    FABS  V5.4H, V30.4H
    FMLA S27, S29, V6.S[0x0]
    FDIV  V3.2D, V5.2D, V28.2D
    FDIV  V6.2D, V2.2D, V3.2D
    FRSQRTE  V23.8H, V19.8H
    FNEG  V0.2D, V6.2D
    FADDP  V8.2S, V27.2S, V27.2S
    FADDP  V9.4H, V8.4H, V5.4H
    FMLS  V22.4H, V10.4H, V23.4H
    FMOV  V5.2S, #0.32812500
    FMLA  V14.2D, V22.2D, V4.2D
    FMULX  V2.2D, V5.2D, V27.2D
    FMLS  V12.4H, V2.4H, V6.4H
    FMLA S31, S13, V14.S[0x0]
    FDIV  V0.4S, V2.4S, V17.4S
    FMUL V28.4S, V9.4S, V9.S[0x3]
    FADD  V7.2D, V0.2D, V12.2D
    FMLS V30.4H, V7.4H, V0.H[0x1]
    FNEG  V24.8H, V28.8H
    FMULX V19.4H, V28.4H, V14.H[0x1]
    FABS  V8.2S, V21.2S
    FMUL S8, S31, V19.S[0x1]
    FMLA  V0.4S, V14.4S, V24.4S
    FABD  V29.2S, V6.2S, V8.2S
    FRSQRTS  V2.2D, V0.2D, V0.2D
    FMOV  V9.2D, #5.00000000
    FMUL H20, H16, V9.H[0x7]
    FMUL  V5.2S, V20.2S, V2.2S
    FDIV  V19.8H, V30.8H, V30.8H
    FMLA  V15.4S, V3.4S, V5.4S
    FMULX H4, H21, V3.H[0x1]
    FMULX V9.4S, V8.4S, V15.S[0x2]
    FMULX  V19.2D, V4.2D, V29.2D
    FADDP H13, V19.2H
    FMUL D28, D26, V18.D[0x0]
    FMUL  V21.8H, V1.8H, V7.8H
    FACGT  V8.8H, V25.8H, V0.8H
    FSQRT  V3.2S, V0.2S
    FMOV  V0.4S, #-0.15625000
    FMULX D30, D25, V20.D[0x0]
    FACGT  V14.4H, V11.4H, V7.4H
    FMULX H22, H14, V9.H[0x7]
    FADDP  V26.2D, V30.2D, V31.2D
    FADDP D5, V21.2D
    FRECPE  V18.4S, V13.4S
    FMULX S29, S8, V26.S[0x0]
    FMOV  V15.2D, #0.14062500
    FADD  V8.2S, V22.2S, V18.2S
    FSUB  V21.2D, V28.2D, V15.2D
    FADDP S22, V5.2S
    FMUL  V5.2S, V3.2S, V25.2S
    FRSQRTS  V3.4H, V22.4H, V23.4H
    FMUL V26.2D, V0.2D, V5.D[0x1]
    FMOV  V23.2D, #-0.21875000
    FADD  V18.2D, V15.2D, V20.2D
    FADDP  V14.4H, V18.4H, V14.4H
    FADD  V6.4H, V14.4H, V17.4H
    FMLA S9, S19, V8.S[0x2]
    FRSQRTE  V19.4H, V23.4H
    FMLS V14.2S, V13.2S, V6.S[0x2]
    FMOV  V23.2D, #5.00000000
    FMLA D6, D9, V21.D[0x0]
    FMOV  V21.2S, #5.25000000
    FRECPS  V0.2D, V6.2D, V3.2D
    FSUB  V20.8H, V0.8H, V15.8H
    FMLA V25.4S, V21.4S, V20.S[0x2]
    FMUL H1, H27, V8.H[0x1]
    FMOV  V20.4H, #0.19531250
    SUBS  X13, X13, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_1
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MRS  X11, FPSR
    MOVZ  X5, #0x1f, LSL #0
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V0.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x4000, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D0
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V1.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D1
    MOVZ  X5, #0x7fff, LSL #0
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x3ff8, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D2
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D3
    MOVZ  X5, #0x7fff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0x3e00, LSL #32
    MOVK  X5, #0x3e00, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D4
    MOVZ  X5, #0xffff, LSL #0
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D5
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0x7fff, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V6.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D6
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0x7fff, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D7
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D8
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0x7f7f, LSL #16
    MOVK  X5, #0x7f80, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D9
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X5, #0x7c00, LSL #0
    MOVK  X5, #0x7c00, LSL #16
    MOVK  X5, #0x7c00, LSL #32
    MOVK  X5, #0x7c00, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D10
    MOVZ  X5, #0x7fff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0x7fff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V11.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D11
    MOVZ  X5, #0xffff, LSL #0
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D12
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D13
    MOVZ  X5, #0xffff, LSL #0
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D14
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x3fc2, LSL #16
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x3fc2, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D15
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x3fc2, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D16
    MOVZ  X5, #0x7fff, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X5, #0x7c00, LSL #0
    MOVK  X5, #0x7c00, LSL #16
    MOVK  X5, #0x7c00, LSL #32
    MOVK  X5, #0x7c00, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D17
    MOVZ  X5, #0x7c00, LSL #0
    MOVK  X5, #0x7c00, LSL #16
    MOVK  X5, #0x7c00, LSL #32
    MOVK  X5, #0x7c00, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x3fc2, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D18
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x3fc2, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D19
    MOVZ  X5, #0x7c00, LSL #0
    MOVK  X5, #0x7c00, LSL #16
    MOVK  X5, #0x7c00, LSL #32
    MOVK  X5, #0x7e00, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D20
    MOVZ  X5, #0x3240, LSL #0
    MOVK  X5, #0x3240, LSL #16
    MOVK  X5, #0x3240, LSL #32
    MOVK  X5, #0x3240, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D21
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x40a8, LSL #16
    MOVK  X5, #0x40a8, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D22
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x4014, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D23
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x4014, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X5, #0x8000, LSL #0
    MOVK  X5, #0x8000, LSL #16
    MOVK  X5, #0x8000, LSL #32
    MOVK  X5, #0x8000, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D24
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0x8000, LSL #32
    MOVK  X5, #0x8000, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D25
    MOVZ  X5, #0x7e00, LSL #0
    MOVK  X5, #0x7e00, LSL #16
    MOVK  X5, #0x7e00, LSL #32
    MOVK  X5, #0x7e00, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x8000, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D26
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x8000, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D27
    MOVZ  X5, #0x7fff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D28
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0x7fff, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D29
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x8000, LSL #16
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V30.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D30
    MOVZ  X5, #0x81ff, LSL #0
    MOVK  X5, #0x81ff, LSL #16
    MOVK  X5, #0x7ddf, LSL #32
    MOVK  X5, #0x3bd0, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, V31.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X11, D31
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorFloatingPointOperation_TestFail
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
    FMOV  V0.D[1], X9
    FMOV  D1, X29
    FMOV  V1.D[1], X12
    FMOV  D2, X27
    FMOV  V2.D[1], X24
    FMOV  D3, X26
    FMOV  V3.D[1], X4
    FMOV  D4, X9
    FMOV  V4.D[1], X17
    FMOV  D5, X15
    FMOV  V5.D[1], X10
    FMOV  D6, X25
    FMOV  V6.D[1], X16
    FMOV  D7, X7
    FMOV  V7.D[1], X17
    FMOV  D8, X9
    FMOV  V8.D[1], X7
    FMOV  D9, X14
    FMOV  V9.D[1], X16
    FMOV  D10, X15
    FMOV  V10.D[1], X10
    FMOV  D11, X7
    FMOV  V11.D[1], X29
    FMOV  D12, X14
    FMOV  V12.D[1], X6
    FMOV  D13, X13
    FMOV  V13.D[1], X2
    FMOV  D14, X14
    FMOV  V14.D[1], X14
    FMOV  D15, X7
    FMOV  V15.D[1], X2
    FMOV  D16, X24
    FMOV  V16.D[1], X4
    FMOV  D17, X17
    FMOV  V17.D[1], X10
    FMOV  D18, X6
    FMOV  V18.D[1], X9
    FMOV  D19, X28
    FMOV  V19.D[1], X5
    FMOV  D20, X29
    FMOV  V20.D[1], X14
    FMOV  D21, X8
    FMOV  V21.D[1], X29
    FMOV  D22, X12
    FMOV  V22.D[1], X27
    FMOV  D23, X8
    FMOV  V23.D[1], X10
    FMOV  D24, X8
    FMOV  V24.D[1], X11
    FMOV  D25, X16
    FMOV  V25.D[1], X8
    FMOV  D26, X23
    FMOV  V26.D[1], X2
    FMOV  D27, X15
    FMOV  V27.D[1], X3
    FMOV  D28, X29
    FMOV  V28.D[1], X4
    FMOV  D29, X10
    FMOV  V29.D[1], X27
    FMOV  D30, X2
    FMOV  V30.D[1], X28
    FMOV  D31, X11
    FMOV  V31.D[1], X11
    MOVZ  X14, #0xa, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_2:
    FMULX S17, S28, V21.S[0x1]
    FACGT  V14.2D, V26.2D, V23.2D
    FMLA D27, D30, V30.D[0x1]
    FRSQRTS  V16.4H, V27.4H, V3.4H
    FMLA D5, D16, V31.D[0x0]
    FRSQRTE  V8.4H, V30.4H
    FDIV  V2.8H, V14.8H, V17.8H
    FMOV  V22.2S, #0.50000000
    FMUL D17, D5, V8.D[0x0]
    FADDP S12, V22.2S
    FRECPS  V15.4S, V17.4S, V17.4S
    FADDP  V15.4S, V15.4S, V12.4S
    FMLA  V11.8H, V24.8H, V29.8H
    FSUB  V31.2S, V11.2S, V11.2S
    FRECPE  V13.2S, V25.2S
    FACGT  V8.8H, V2.8H, V15.8H
    FMLA H30, H26, V6.H[0x4]
    FMULX V27.4H, V0.4H, V12.H[0x2]
    FACGE  V15.2D, V27.2D, V30.2D
    FMULX H12, H1, V15.H[0x4]
    FMLA V23.2S, V26.2S, V13.S[0x2]
    FSQRT  V27.4H, V23.4H
    FRECPS  V1.2D, V9.2D, V27.2D
    FMUL V26.4S, V1.4S, V1.S[0x2]
    FMUL V17.4S, V26.4S, V5.S[0x0]
    FABS  V14.4H, V8.4H
    FMLS V25.2D, V6.2D, V31.D[0x1]
    FDIV  V13.2S, V12.2S, V16.2S
    FADD  V6.2S, V17.2S, V17.2S
    FMLS S15, S17, V13.S[0x3]
    FRECPS  V31.2D, V15.2D, V15.2D
    FMLA V1.2D, V11.2D, V12.D[0x1]
    FMULX H8, H18, V6.H[0x3]
    FDIV  V16.8H, V9.8H, V15.8H
    FACGT  V24.2S, V14.2S, V8.2S
    FABS  V8.4H, V17.4H
    FDIV  V4.8H, V1.8H, V3.8H
    FMLS V13.4H, V2.4H, V9.H[0x2]
    FADD  V2.8H, V13.8H, V18.8H
    FMLA V5.2S, V25.2S, V31.S[0x2]
    FADDP H18, V10.2H
    FMUL  V26.2S, V16.2S, V14.2S
    FSQRT  V23.2D, V5.2D
    FADD  V17.4S, V24.4S, V26.4S
    FMUL V26.2D, V17.2D, V4.D[0x0]
    FMLS V14.4S, V26.4S, V1.S[0x0]
    FADDP  V26.4S, V18.4S, V21.4S
    FMLS S12, S8, V8.S[0x0]
    FMUL  V15.2S, V2.2S, V23.2S
    FADDP H31, V19.2H
    FMULX V10.4H, V15.4H, V12.H[0x3]
    FADDP H8, V2.2H
    FMLS  V2.4H, V3.4H, V26.4H
    FMULX D17, D14, V8.D[0x1]
    FRECPS  V22.8H, V10.8H, V9.8H
    FMLA V11.4H, V2.4H, V2.H[0x2]
    FMOV  V3.2D, #0.31250000
    FSUB  V25.2D, V3.2D, V29.2D
    FMLA V10.2S, V25.2S, V10.S[0x0]
    FMOV  V1.4S, #7.25000000
    FMLS  V29.2S, V1.2S, V17.2S
    FABD  V1.4H, V18.4H, V31.4H
    FMULX V17.2S, V22.2S, V1.S[0x2]
    FMLS D19, D19, V10.D[0x1]
    FMLS V18.8H, V19.8H, V12.H[0x6]
    FSUB  V8.8H, V2.8H, V11.8H
    FADDP  V4.4S, V26.4S, V4.4S
    FADDP  V3.2S, V17.2S, V6.2S
    FABD  V24.4S, V8.4S, V29.4S
    FMLA D14, D7, V29.D[0x1]
    FADDP S12, V14.2S
    FDIV  V31.2D, V24.2D, V19.2D
    FABS  V24.2D, V8.2D
    FACGT  V2.2D, V12.2D, V12.2D
    FMLA V19.4H, V4.4H, V15.H[0x1]
    FRECPS  V6.8H, V24.8H, V19.8H
    FMUL V25.2D, V2.2D, V2.D[0x0]
    FRECPS  V26.8H, V6.8H, V31.8H
    FRECPE  V12.8H, V25.8H
    FMULX V29.8H, V26.8H, V10.H[0x7]
    FMOV  V10.2S, #7.75000000
    FMLS H7, H3, V3.H[0x7]
    FRSQRTE  V22.8H, V27.8H
    FNEG  V17.8H, V7.8H
    FADDP  V25.4H, V10.4H, V16.4H
    FNEG  V21.2S, V10.2S
    FNEG  V7.4H, V12.4H
    FRECPE  V12.4H, V15.4H
    FMOV  V8.2D, #-0.21875000
    FRECPE  V27.8H, V12.8H
    FRECPE  V6.4S, V17.4S
    FACGT  V2.2S, V29.2S, V25.2S
    FMLS H12, H18, V8.H[0x0]
    FSUB  V4.4H, V7.4H, V22.4H
    FNEG  V23.2S, V6.2S
    FMULX H13, H12, V9.H[0x5]
    FRSQRTS  V3.2D, V16.2D, V21.2D
    FMULX  V14.8H, V2.8H, V30.8H
    FSQRT  V15.2S, V13.2S
    FMULX V17.4H, V19.4H, V15.H[0x3]
    FADD  V17.4S, V2.4S, V20.4S
    FMULX V21.2D, V14.2D, V27.D[0x1]
    FRECPS  V1.4H, V23.4H, V3.4H
    FSQRT  V16.2S, V28.2S
    FADDP H28, V21.2H
    FADDP D29, V1.2D
    FMULX V14.2D, V31.2D, V22.D[0x1]
    FMUL D27, D4, V17.D[0x0]
    FMLS D5, D27, V5.D[0x0]
    FMUL D2, D2, V26.D[0x0]
    FMLS D15, D5, V29.D[0x1]
    FMLS V6.2S, V30.2S, V2.S[0x1]
    FMULX V30.4S, V16.4S, V14.S[0x3]
    FMLA V28.4H, V15.4H, V11.H[0x6]
    FMLS V5.8H, V6.8H, V6.H[0x7]
    FMLS D16, D30, V17.D[0x1]
    FMLS H21, H28, V14.H[0x0]
    FMUL V13.2D, V6.2D, V30.D[0x0]
    FRSQRTE  V1.4H, V21.4H
    FMUL S23, S24, V12.S[0x2]
    FMOV  V6.4H, #-0.21093750
    FABS  V26.2D, V13.2D
    FMUL  V21.2D, V11.2D, V20.2D
    FADDP H22, V16.2H
    FSQRT  V25.8H, V26.8H
    FRECPS  V9.2D, V21.2D, V22.2D
    FACGE  V11.4H, V5.4H, V5.4H
    FMLS H2, H28, V7.H[0x7]
    FABD  V14.8H, V11.8H, V9.8H
    FABS  V30.2S, V23.2S
    FMUL S12, S29, V30.S[0x2]
    FACGE  V7.8H, V27.8H, V14.8H
    FMUL  V22.8H, V1.8H, V7.8H
    FMLA V14.2S, V13.2S, V12.S[0x1]
    FABD  V27.8H, V10.8H, V18.8H
    FABD  V20.2S, V18.2S, V15.2S
    FMULX V12.4H, V27.4H, V2.H[0x5]
    FDIV  V26.8H, V14.8H, V14.8H
    FMOV  V21.8H, #0.46875000
    FRSQRTS  V23.2D, V26.2D, V26.2D
    FADDP D13, V21.2D
    FADD  V2.4S, V22.4S, V6.4S
    FABS  V22.2D, V12.2D
    FDIV  V29.8H, V13.8H, V9.8H
    FACGE  V1.2S, V5.2S, V24.2S
    FADDP  V7.4H, V20.4H, V22.4H
    FMLA V27.8H, V14.8H, V2.H[0x0]
    FMLA V16.2D, V7.2D, V16.D[0x1]
    FMUL V8.8H, V27.8H, V1.H[0x5]
    FRECPS  V1.2S, V23.2S, V23.2S
    FADD  V9.8H, V30.8H, V4.8H
    FRECPS  V12.4H, V9.4H, V1.4H
    FMULX V30.2S, V8.2S, V16.S[0x2]
    FMLA V13.8H, V14.8H, V6.H[0x4]
    FMLA V9.8H, V19.8H, V3.H[0x1]
    FMLA D24, D26, V12.D[0x0]
    FMOV  V26.2D, #0.45312500
    FRECPE  V23.4H, V5.4H
    FMUL H2, H28, V15.H[0x6]
    FADDP S27, V25.2S
    FMUL  V1.8H, V11.8H, V30.8H
    FMUL D22, D12, V1.D[0x0]
    FMOV  V1.4S, #2.75000000
    FABD  V25.8H, V9.8H, V23.8H
    FRECPS  V21.8H, V22.8H, V1.8H
    FNEG  V5.4H, V23.4H
    FMLS V22.8H, V18.8H, V2.H[0x0]
    FNEG  V9.8H, V10.8H
    FRECPE  V1.2D, V5.2D
    FSQRT  V17.4H, V21.4H
    FMLS S10, S10, V9.S[0x0]
    FMULX V9.4S, V22.4S, V17.S[0x0]
    FACGE  V13.2D, V26.2D, V24.2D
    FMOV  V12.4S, #-2.75000000
    FSUB  V18.4H, V31.4H, V25.4H
    FSQRT  V25.4S, V18.4S
    FACGT  V2.4S, V13.4S, V6.4S
    FDIV  V15.4H, V9.4H, V2.4H
    FMLS V17.2S, V12.2S, V27.S[0x2]
    FMUL V23.2S, V24.2S, V27.S[0x0]
    FRECPS  V13.8H, V23.8H, V25.8H
    FADD  V31.4H, V1.4H, V13.4H
    FACGT  V12.4H, V15.4H, V2.4H
    FADDP  V9.2S, V19.2S, V31.2S
    FMULX D16, D10, V16.D[0x0]
    FACGE  V18.4S, V23.4S, V1.4S
    FMULX V5.4H, V18.4H, V0.H[0x5]
    FRECPE  V6.4S, V17.4S
    FMUL H16, H9, V14.H[0x6]
    FRECPE  V1.4H, V12.4H
    FABD  V10.4H, V1.4H, V14.4H
    FMLA S22, S23, V6.S[0x3]
    FSUB  V21.4H, V28.4H, V29.4H
    FMOV  V25.4S, #-0.84375000
    FMLA V0.4S, V5.4S, V25.S[0x1]
    FACGT  V26.4S, V19.4S, V30.4S
    FMUL  V12.8H, V16.8H, V0.8H
    FMUL H1, H22, V1.H[0x6]
    FMUL V22.2D, V25.2D, V16.D[0x1]
    FMLS  V30.4H, V7.4H, V21.4H
    SUBS  X14, X14, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_2
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MRS  X9, FPSR
    MOVZ  X5, #0x1f, LSL #0
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V0.D[1]
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D0
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V1.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D1
    MOVZ  X5, #0x7fff, LSL #0
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D2
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x3ff8, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D3
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0x7fff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D4
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0x7fff, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V5.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D5
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x7f80, LSL #16
    MOVK  X5, #0x7f80, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D6
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0x7fff, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V7.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D7
    MOVZ  X5, #0x7fff, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    MOVK  X5, #0x7fff, LSL #32
    MOVK  X5, #0x7fff, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X5, #0x7ffe, LSL #0
    MOVK  X5, #0x7ffe, LSL #16
    MOVK  X5, #0x7ffe, LSL #32
    MOVK  X5, #0x7ffe, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D8
    MOVZ  X5, #0x7fff, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    MOVK  X5, #0x7fff, LSL #32
    MOVK  X5, #0x7fff, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V9.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D9
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0x7fff, LSL #32
    MOVK  X5, #0x7fff, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D10
    MOVZ  X5, #0x7fff, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    MOVK  X5, #0x7fff, LSL #32
    MOVK  X5, #0x7fff, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V11.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D11
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V12.D[1]
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D12
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V13.D[1]
    MOVZ  X5, #0x4000, LSL #0
    MOVK  X5, #0x4000, LSL #16
    MOVK  X5, #0x4000, LSL #32
    MOVK  X5, #0x4000, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D13
    MOVZ  X5, #0x7fff, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    MOVK  X5, #0x7fff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D14
    MOVZ  X5, #0x7fff, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    MOVK  X5, #0x7fff, LSL #32
    MOVK  X5, #0x7fff, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D15
    MOVZ  X5, #0x7fff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0x7fff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D16
    MOVZ  X5, #0xffff, LSL #0
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V17.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D17
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0x7fff, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V18.D[1]
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D18
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V19.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D19
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V20.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D20
    MOVZ  X5, #0x7fff, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    MOVK  X5, #0x7fff, LSL #32
    MOVK  X5, #0x7fff, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D21
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0x7fff, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V22.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x8000, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D22
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x8000, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D23
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0x7fff, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V24.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D24
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0x7fff, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xbf58, LSL #16
    MOVK  X5, #0xbf58, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D25
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xbf58, LSL #16
    MOVK  X5, #0xbf58, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D26
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V27.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D27
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V28.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D28
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0x7fff, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X5, #0x7e00, LSL #0
    MOVK  X5, #0x7e00, LSL #16
    MOVK  X5, #0x7e00, LSL #32
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D29
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V30.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D30
    MOVZ  X5, #0x7fff, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    MOVK  X5, #0x7fff, LSL #32
    MOVK  X5, #0x7fff, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, V31.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X9, D31
    MOVZ  X5, #0x7fff, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    MOVK  X5, #0x7fff, LSL #32
    MOVK  X5, #0x7fff, LSL #48
    SUB  X26, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
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
    FMOV  V0.D[1], X29
    FMOV  D1, X26
    FMOV  V1.D[1], X25
    FMOV  D2, X25
    FMOV  V2.D[1], X9
    FMOV  D3, X7
    FMOV  V3.D[1], X28
    FMOV  D4, X8
    FMOV  V4.D[1], X23
    FMOV  D5, X23
    FMOV  V5.D[1], X14
    FMOV  D6, X11
    FMOV  V6.D[1], X8
    FMOV  D7, X6
    FMOV  V7.D[1], X11
    FMOV  D8, X16
    FMOV  V8.D[1], X7
    FMOV  D9, X15
    FMOV  V9.D[1], X5
    FMOV  D10, X25
    FMOV  V10.D[1], X2
    FMOV  D11, X28
    FMOV  V11.D[1], X8
    FMOV  D12, X14
    FMOV  V12.D[1], X2
    FMOV  D13, X25
    FMOV  V13.D[1], X27
    FMOV  D14, X25
    FMOV  V14.D[1], X17
    FMOV  D15, X4
    FMOV  V15.D[1], X9
    FMOV  D16, X8
    FMOV  V16.D[1], X3
    FMOV  D17, X7
    FMOV  V17.D[1], X11
    FMOV  D18, X8
    FMOV  V18.D[1], X5
    FMOV  D19, X5
    FMOV  V19.D[1], X16
    FMOV  D20, X11
    FMOV  V20.D[1], X28
    FMOV  D21, X14
    FMOV  V21.D[1], X5
    FMOV  D22, X10
    FMOV  V22.D[1], X14
    FMOV  D23, X13
    FMOV  V23.D[1], X10
    FMOV  D24, X5
    FMOV  V24.D[1], X3
    FMOV  D25, X14
    FMOV  V25.D[1], X2
    FMOV  D26, X7
    FMOV  V26.D[1], X2
    FMOV  D27, X3
    FMOV  V27.D[1], X5
    FMOV  D28, X5
    FMOV  V28.D[1], X26
    FMOV  D29, X26
    FMOV  V29.D[1], X28
    FMOV  D30, X4
    FMOV  V30.D[1], X17
    FMOV  D31, X25
    FMOV  V31.D[1], X15
    MOVZ  X17, #0xa, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_3:
    FMUL H9, H29, V4.H[0x2]
    FMLS V29.2S, V28.2S, V26.S[0x2]
    FMUL V30.8H, V9.8H, V9.H[0x6]
    FRECPE  V21.2D, V31.2D
    FMUL S15, S20, V22.S[0x2]
    FADDP  V28.2S, V29.2S, V24.2S
    FADDP  V12.2S, V7.2S, V15.2S
    FADDP D20, V24.2D
    FMULX  V13.4H, V21.4H, V30.4H
    FABD  V26.4H, V27.4H, V12.4H
    FMLA  V31.4H, V13.4H, V2.4H
    FMULX  V22.8H, V20.8H, V24.8H
    FSUB  V6.8H, V22.8H, V22.8H
    FMULX V28.2S, V6.2S, V2.S[0x2]
    FDIV  V15.4S, V28.4S, V26.4S
    FRSQRTE  V25.2D, V19.2D
    FACGT  V7.4S, V3.4S, V14.4S
    FDIV  V9.2S, V9.2S, V30.2S
    FMULX D20, D15, V16.D[0x0]
    FACGT  V24.2D, V20.2D, V4.2D
    FRECPE  V22.2D, V24.2D
    FABS  V26.2D, V31.2D
    FSQRT  V16.8H, V22.8H
    FADD  V20.2S, V16.2S, V26.2S
    FADDP S5, V20.2S
    FMULX  V13.8H, V25.8H, V5.8H
    FADDP  V28.2S, V9.2S, V13.2S
    FRSQRTS  V2.2S, V8.2S, V28.2S
    FSUB  V15.4H, V12.4H, V9.4H
    FRECPS  V19.4H, V5.4H, V17.4H
    FMLA  V20.4S, V2.4S, V22.4S
    FMULX D24, D24, V29.D[0x1]
    FDIV  V8.2S, V30.2S, V24.2S
    FSUB  V24.2D, V31.2D, V21.2D
    FMUL V31.4S, V1.4S, V7.S[0x3]
    FRSQRTE  V1.2S, V7.2S
    FMLA V10.2D, V4.2D, V14.D[0x1]
    FACGE  V7.8H, V14.8H, V18.8H
    FMOV  V26.2D, #0.43750000
    FMLS V12.2S, V4.2S, V1.S[0x1]
    FMULX D21, D7, V10.D[0x0]
    FMUL V14.8H, V14.8H, V11.H[0x7]
    FMLS  V28.2D, V24.2D, V27.2D
    FADD  V1.2D, V28.2D, V20.2D
    FMOV  V10.2D, #-0.19531250
    FMUL V11.4S, V15.4S, V27.S[0x3]
    FRECPE  V18.2D, V8.2D
    FMULX V17.4H, V26.4H, V15.H[0x3]
    FABS  V2.4H, V12.4H
    FMUL  V8.4S, V14.4S, V19.4S
    FDIV  V20.4S, V17.4S, V4.4S
    FADDP D24, V11.2D
    FMUL S15, S1, V18.S[0x1]
    FADD  V19.8H, V0.8H, V25.8H
    FMLS  V13.4H, V6.4H, V21.4H
    FMULX  V17.2S, V19.2S, V31.2S
    FMOV  V9.2D, #2.25000000
    FMUL H4, H2, V15.H[0x5]
    FMUL V14.4H, V20.4H, V6.H[0x0]
    FDIV  V7.2D, V2.2D, V24.2D
    FMULX V0.4H, V14.4H, V5.H[0x6]
    FACGE  V18.2D, V8.2D, V9.2D
    FMUL  V6.8H, V24.8H, V0.8H
    FADDP  V31.2S, V3.2S, V0.2S
    FMLA  V11.4H, V18.4H, V7.4H
    FABS  V15.4H, V6.4H
    FMOV  V28.2S, #0.87500000
    FMLA V18.2D, V28.2D, V4.D[0x0]
    FMLS V8.2S, V11.2S, V17.S[0x2]
    FMULX  V21.2D, V15.2D, V18.2D
    FMUL V7.4H, V13.4H, V8.H[0x1]
    FMULX V20.4H, V21.4H, V13.H[0x3]
    FMUL  V20.2S, V31.2S, V31.2S
    FRECPE  V27.8H, V7.8H
    FRSQRTE  V15.2S, V27.2S
    FABD  V31.4H, V15.4H, V20.4H
    FADD  V17.2D, V17.2D, V16.2D
    FMOV  V15.8H, #1.00000000
    FMULX V4.2S, V2.2S, V31.S[0x2]
    FACGT  V20.4H, V9.4H, V11.4H
    FNEG  V10.2D, V4.2D
    FADDP S18, V9.2S
    FMLS  V27.2D, V21.2D, V8.2D
    FMULX V8.2S, V13.2S, V29.S[0x0]
    FMLA S2, S13, V20.S[0x2]
    FADDP S6, V23.2S
    FMLS V21.8H, V27.8H, V7.H[0x6]
    FMLA H7, H10, V9.H[0x4]
    FADDP H16, V12.2H
    FABD  V7.4H, V21.4H, V8.4H
    FADDP S21, V9.2S
    FMLA D6, D17, V22.D[0x0]
    FMLA  V22.2S, V25.2S, V15.2S
    FADDP  V9.2S, V21.2S, V5.2S
    FMLA S12, S31, V6.S[0x3]
    FRSQRTS  V27.2D, V11.2D, V9.2D
    FABD  V17.4H, V20.4H, V18.4H
    FMOV  V11.2D, #28.00000000
    FMLS V6.2D, V15.2D, V7.D[0x0]
    FMLS V13.8H, V11.8H, V2.H[0x3]
    FABD  V7.2S, V9.2S, V13.2S
    FMULX V23.2S, V7.2S, V22.S[0x1]
    FMUL  V8.2S, V27.2S, V23.2S
    FMULX D21, D17, V19.D[0x1]
    FADD  V9.2D, V6.2D, V18.2D
    FADD  V22.2D, V8.2D, V9.2D
    FMLA  V7.4S, V15.4S, V29.4S
    FMLS S15, S22, V7.S[0x0]
    FMUL V5.4S, V10.4S, V21.S[0x1]
    FMLA  V28.8H, V16.8H, V1.8H
    FMULX V29.2D, V5.2D, V19.D[0x1]
    FADDP  V15.8H, V3.8H, V24.8H
    FRSQRTE  V25.2D, V28.2D
    FNEG  V19.4H, V11.4H
    FMULX V8.2D, V19.2D, V29.D[0x1]
    FMUL V22.8H, V27.8H, V8.H[0x1]
    FMUL V6.2D, V25.2D, V25.D[0x1]
    FADDP S9, V19.2S
    FMUL  V27.2D, V6.2D, V15.2D
    FMULX D7, D9, V20.D[0x0]
    FMLA S25, S7, V31.S[0x0]
    FMOV  V31.8H, #-3.00000000
    FMLS H29, H20, V8.H[0x0]
    FMLA V28.4S, V25.4S, V29.S[0x2]
    FNEG  V5.2S, V17.2S
    FMULX V19.2D, V11.2D, V22.D[0x1]
    FADDP  V18.8H, V5.8H, V0.8H
    FMUL S13, S1, V19.S[0x1]
    FACGE  V7.4S, V20.4S, V31.4S
    FMLA H24, H28, V12.H[0x4]
    FMLA V3.4H, V4.4H, V7.H[0x3]
    FADDP H11, V31.2H
    FNEG  V8.8H, V3.8H
    FMULX V23.4S, V24.4S, V31.S[0x2]
    FMLS S9, S23, V23.S[0x0]
    FMLS H10, H11, V9.H[0x4]
    FMOV  V31.4H, #7.25000000
    FDIV  V12.4S, V27.4S, V13.4S
    FMULX V7.2D, V0.2D, V28.D[0x0]
    FMLA H5, H24, V7.H[0x0]
    FRSQRTS  V4.2S, V12.2S, V12.2S
    FMLS  V15.2S, V18.2S, V5.2S
    FRECPS  V17.2S, V1.2S, V4.2S
    FMUL S1, S12, V16.S[0x3]
    FMUL S16, S15, V10.S[0x1]
    FMULX S29, S1, V1.S[0x2]
    FMLA V24.4S, V5.4S, V29.S[0x3]
    FMULX V8.2D, V31.2D, V17.D[0x1]
    FMLA H0, H24, V9.H[0x4]
    FMOV  V5.2S, #0.96875000
    FABD  V27.4H, V5.4H, V16.4H
    FSQRT  V15.4S, V10.4S
    FMUL S5, S8, V22.S[0x1]
    FMLS V25.2D, V13.2D, V27.D[0x1]
    FRECPS  V18.8H, V15.8H, V31.8H
    FADD  V8.4H, V18.4H, V0.4H
    FMUL V7.8H, V30.8H, V5.H[0x6]
    FSQRT  V29.4S, V25.4S
    FRSQRTS  V17.8H, V0.8H, V3.8H
    FRECPS  V15.8H, V29.8H, V18.8H
    FMLS D0, D17, V8.D[0x0]
    FMUL V17.4S, V0.4S, V0.S[0x0]
    FADDP H16, V7.2H
    FMLA V27.4H, V15.4H, V15.H[0x5]
    FACGE  V30.4H, V27.4H, V31.4H
    FABD  V8.8H, V30.8H, V17.8H
    FACGT  V24.2D, V0.2D, V10.2D
    FACGT  V3.2S, V8.2S, V11.2S
    FMULX  V14.8H, V13.8H, V15.8H
    FMLS S0, S21, V16.S[0x0]
    FMLS  V25.2D, V26.2D, V22.2D
    FRECPE  V11.4H, V1.4H
    FMUL H16, H13, V7.H[0x2]
    FMUL V31.8H, V0.8H, V3.H[0x3]
    FMOV  V30.4S, #-0.34375000
    FABS  V22.4H, V7.4H
    FMLA  V30.2D, V16.2D, V6.2D
    FMULX  V26.4H, V22.4H, V24.4H
    FMLS  V27.4S, V18.4S, V19.4S
    FMLS V1.4S, V12.4S, V2.S[0x1]
    FMLS S9, S22, V12.S[0x0]
    FSUB  V5.8H, V11.8H, V18.8H
    FNEG  V8.2D, V14.2D
    FMLA H20, H8, V1.H[0x3]
    FADDP  V2.4S, V13.4S, V11.4S
    FNEG  V10.4S, V6.4S
    FMOV  V1.4H, #-0.37500000
    FSUB  V24.2D, V16.2D, V25.2D
    FABS  V19.4H, V26.4H
    FABD  V6.2D, V9.2D, V20.2D
    FMULX D15, D31, V27.D[0x1]
    FMLS  V27.8H, V12.8H, V19.8H
    FMLA  V9.4H, V24.4H, V15.4H
    FMULX  V18.8H, V27.8H, V27.8H
    FMLA D16, D14, V18.D[0x1]
    FADDP H15, V9.2H
    FMUL V11.4H, V16.4H, V1.H[0x1]
    FMLS V18.2D, V6.2D, V24.D[0x1]
    FMLA S13, S11, V2.S[0x0]
    FMULX  V22.8H, V10.8H, V5.8H
    SUBS  X17, X17, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_3
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X15, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MRS  X16, FPSR
    MOVZ  X15, #0x1f, LSL #0
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D0
    MOVZ  X15, #0x7ff0, LSL #0
    MOVK  X15, #0x7fc0, LSL #16
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D1
    MOVZ  X15, #0xb600, LSL #0
    MOVK  X15, #0xb600, LSL #16
    MOVK  X15, #0xb600, LSL #32
    MOVK  X15, #0xb600, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X15, #0xff80, LSL #0
    MOVK  X15, #0x7ff1, LSL #16
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D2
    MOVZ  X15, #0x7ff0, LSL #0
    MOVK  X15, #0x7ff1, LSL #16
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D3
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D4
    MOVZ  X15, #0xff80, LSL #0
    MOVK  X15, #0xfff1, LSL #16
    MOVK  X15, #0xfff8, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X15, #0xc000, LSL #0
    MOVK  X15, #0xc000, LSL #16
    MOVK  X15, #0xc000, LSL #32
    MOVK  X15, #0xc000, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D5
    MOVZ  X15, #0xff80, LSL #0
    MOVK  X15, #0x7ff1, LSL #16
    MOVK  X15, #0x7c00, LSL #32
    MOVK  X15, #0x7c00, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D6
    MOVZ  X15, #0x7f90, LSL #0
    MOVK  X15, #0x7ff1, LSL #16
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D7
    MOVZ  X15, #0xff80, LSL #0
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D8
    MOVZ  X15, #0x7ff0, LSL #0
    MOVK  X15, #0x7ff1, LSL #16
    MOVK  X15, #0x8000, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D9
    MOVZ  X15, #0xff80, LSL #0
    MOVK  X15, #0x7ff1, LSL #16
    MOVK  X15, #0x7ff0, LSL #32
    MOVK  X15, #0x7ff8, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X15, #0x7ff0, LSL #0
    MOVK  X15, #0xfff0, LSL #16
    MOVK  X15, #0x7ff0, LSL #32
    MOVK  X15, #0xfff8, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D10
    MOVZ  X15, #0xff80, LSL #0
    MOVK  X15, #0xfff1, LSL #16
    MOVK  X15, #0xfff8, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D11
    MOVZ  X15, #0x7ff0, LSL #0
    MOVK  X15, #0x7ff0, LSL #16
    MOVK  X15, #0x7ff0, LSL #32
    MOVK  X15, #0x7ff8, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X15, #0x7ff0, LSL #0
    MOVK  X15, #0x7ff0, LSL #16
    MOVK  X15, #0x7ff0, LSL #32
    MOVK  X15, #0x7ff8, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D12
    MOVZ  X15, #0xff80, LSL #0
    MOVK  X15, #0x7ff1, LSL #16
    MOVK  X15, #0x7ff8, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D13
    MOVZ  X15, #0x7ff0, LSL #0
    MOVK  X15, #0x7ff1, LSL #16
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D14
    MOVZ  X15, #0x7ff0, LSL #0
    MOVK  X15, #0x7ff1, LSL #16
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D15
    MOVZ  X15, #0xff80, LSL #0
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D16
    MOVZ  X15, #0x7ff0, LSL #0
    MOVK  X15, #0x7ff0, LSL #16
    MOVK  X15, #0x7ff0, LSL #32
    MOVK  X15, #0x7ff8, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X15, #0x7ff0, LSL #0
    MOVK  X15, #0x7fc0, LSL #16
    MOVK  X15, #0x7ff0, LSL #32
    MOVK  X15, #0x7fc0, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D17
    MOVZ  X15, #0x7ff0, LSL #0
    MOVK  X15, #0x7fc0, LSL #16
    MOVK  X15, #0x7ff0, LSL #32
    MOVK  X15, #0xfff8, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X15, #0x7ff0, LSL #0
    MOVK  X15, #0x7ff0, LSL #16
    MOVK  X15, #0x7ff0, LSL #32
    MOVK  X15, #0x7ff8, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D18
    MOVZ  X15, #0x7f80, LSL #0
    MOVK  X15, #0xfff1, LSL #16
    MOVK  X15, #0x7ff0, LSL #32
    MOVK  X15, #0x7ff8, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D19
    MOVZ  X15, #0x7f80, LSL #0
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D20
    MOVZ  X15, #0x7ff0, LSL #0
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D21
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7ff0, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X15, #0x7ff0, LSL #0
    MOVK  X15, #0xfff0, LSL #16
    MOVK  X15, #0x7ff0, LSL #32
    MOVK  X15, #0xfff8, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D22
    MOVZ  X15, #0xff80, LSL #0
    MOVK  X15, #0xfff1, LSL #16
    MOVK  X15, #0x4000, LSL #32
    MOVK  X15, #0xfff8, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0x8000, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D23
    MOVZ  X15, #0x163c, LSL #0
    MOVK  X15, #0x8010, LSL #16
    MOVK  X15, #0x8000, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X15, #0x7ff0, LSL #0
    MOVK  X15, #0x7ff0, LSL #16
    MOVK  X15, #0x7ff0, LSL #32
    MOVK  X15, #0x7ff8, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D24
    MOVZ  X15, #0x7ff0, LSL #0
    MOVK  X15, #0x7ff8, LSL #16
    MOVK  X15, #0x7ff0, LSL #32
    MOVK  X15, #0x7ff8, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X15, #0x7ff0, LSL #0
    MOVK  X15, #0x7ff0, LSL #16
    MOVK  X15, #0x7ff0, LSL #32
    MOVK  X15, #0x7ff8, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D25
    MOVZ  X15, #0x7ff0, LSL #0
    MOVK  X15, #0x7ff8, LSL #16
    MOVK  X15, #0x7ff0, LSL #32
    MOVK  X15, #0x7ff8, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D26
    MOVZ  X15, #0x7f80, LSL #0
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X15, #0x7ff0, LSL #0
    MOVK  X15, #0x7ff0, LSL #16
    MOVK  X15, #0x7ff0, LSL #32
    MOVK  X15, #0x7ff8, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D27
    MOVZ  X15, #0x7f80, LSL #0
    MOVK  X15, #0xfff1, LSL #16
    MOVK  X15, #0x7ff0, LSL #32
    MOVK  X15, #0x7ff8, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X15, #0x7ff0, LSL #0
    MOVK  X15, #0x7ff0, LSL #16
    MOVK  X15, #0x7ff0, LSL #32
    MOVK  X15, #0x7ff8, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D28
    MOVZ  X15, #0xff80, LSL #0
    MOVK  X15, #0x7ff1, LSL #16
    MOVK  X15, #0x7ff8, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D29
    MOVZ  X15, #0xff80, LSL #0
    MOVK  X15, #0x7ff1, LSL #16
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X15, #0x7ff0, LSL #0
    MOVK  X15, #0x7ff0, LSL #16
    MOVK  X15, #0x7ff0, LSL #32
    MOVK  X15, #0x7ff8, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D30
    MOVZ  X15, #0xff80, LSL #0
    MOVK  X15, #0x7ff1, LSL #16
    MOVK  X15, #0x7ff8, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D31
    MOVZ  X15, #0x7ff0, LSL #0
    MOVK  X15, #0x7fc0, LSL #16
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
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
    FMOV  V0.D[1], X7
    FMOV  D1, X28
    FMOV  V1.D[1], X25
    FMOV  D2, X8
    FMOV  V2.D[1], X26
    FMOV  D3, X14
    FMOV  V3.D[1], X23
    FMOV  D4, X29
    FMOV  V4.D[1], X23
    FMOV  D5, X3
    FMOV  V5.D[1], X24
    FMOV  D6, X4
    FMOV  V6.D[1], X11
    FMOV  D7, X2
    FMOV  V7.D[1], X25
    FMOV  D8, X2
    FMOV  V8.D[1], X23
    FMOV  D9, X6
    FMOV  V9.D[1], X9
    FMOV  D10, X26
    FMOV  V10.D[1], X23
    FMOV  D11, X9
    FMOV  V11.D[1], X29
    FMOV  D12, X24
    FMOV  V12.D[1], X6
    FMOV  D13, X14
    FMOV  V13.D[1], X3
    FMOV  D14, X11
    FMOV  V14.D[1], X3
    FMOV  D15, X12
    FMOV  V15.D[1], X15
    FMOV  D16, X3
    FMOV  V16.D[1], X10
    FMOV  D17, X29
    FMOV  V17.D[1], X3
    FMOV  D18, X26
    FMOV  V18.D[1], X10
    FMOV  D19, X4
    FMOV  V19.D[1], X9
    FMOV  D20, X10
    FMOV  V20.D[1], X4
    FMOV  D21, X12
    FMOV  V21.D[1], X26
    FMOV  D22, X13
    FMOV  V22.D[1], X6
    FMOV  D23, X16
    FMOV  V23.D[1], X17
    FMOV  D24, X8
    FMOV  V24.D[1], X13
    FMOV  D25, X10
    FMOV  V25.D[1], X11
    FMOV  D26, X3
    FMOV  V26.D[1], X26
    FMOV  D27, X11
    FMOV  V27.D[1], X24
    FMOV  D28, X11
    FMOV  V28.D[1], X3
    FMOV  D29, X6
    FMOV  V29.D[1], X10
    FMOV  D30, X12
    FMOV  V30.D[1], X25
    FMOV  D31, X25
    FMOV  V31.D[1], X26
    MOVZ  X4, #0xa, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_4:
    FRECPS  V23.2S, V26.2S, V27.2S
    FMLA H17, H31, V13.H[0x0]
    FMLS H1, H25, V12.H[0x0]
    FRSQRTE  V18.4S, V22.4S
    FACGE  V14.8H, V23.8H, V18.8H
    FADD  V18.2S, V13.2S, V29.2S
    FRECPE  V7.4S, V14.4S
    FMLS D15, D18, V17.D[0x1]
    FMUL S27, S30, V4.S[0x1]
    FMLA V4.8H, V1.8H, V11.H[0x3]
    FDIV  V1.4H, V4.4H, V15.4H
    FRSQRTE  V30.4S, V28.4S
    FMLS V20.8H, V15.8H, V11.H[0x3]
    FRSQRTE  V4.8H, V1.8H
    FRSQRTE  V28.4S, V4.4S
    FMLA D15, D7, V18.D[0x0]
    FDIV  V17.2S, V28.2S, V1.2S
    FMLA D13, D20, V25.D[0x0]
    FADD  V17.2D, V15.2D, V24.2D
    FMLS  V24.8H, V27.8H, V18.8H
    FMULX D27, D18, V26.D[0x0]
    FSQRT  V22.2S, V24.2S
    FADDP D28, V27.2D
    FRECPS  V12.2S, V28.2S, V11.2S
    FMLA V11.4H, V22.4H, V12.H[0x5]
    FMLA V22.2D, V13.2D, V11.D[0x0]
    FMLS D1, D16, V29.D[0x1]
    FMUL S11, S22, V24.S[0x0]
    FRECPS  V7.4H, V17.4H, V11.4H
    FMULX V15.2S, V1.2S, V7.S[0x3]
    FMLA  V20.2S, V22.2S, V6.2S
    FMUL  V24.4H, V10.4H, V24.4H
    FMLA V27.8H, V29.8H, V2.H[0x1]
    FRSQRTS  V11.2D, V10.2D, V2.2D
    FMUL V28.2S, V7.2S, V8.S[0x1]
    FRECPS  V4.4S, V19.4S, V6.4S
    FMULX  V14.2D, V20.2D, V27.2D
    FRECPE  V27.4S, V8.4S
    FACGE  V19.4H, V16.4H, V16.4H
    FADD  V7.2S, V15.2S, V24.2S
    FMLS  V13.8H, V11.8H, V21.8H
    FMLA D6, D30, V14.D[0x0]
    FRECPS  V12.2D, V19.2D, V19.2D
    FRSQRTE  V20.4H, V7.4H
    FMUL  V26.8H, V27.8H, V19.8H
    FMLA  V17.8H, V12.8H, V12.8H
    FACGT  V19.4H, V2.4H, V20.4H
    FMULX  V8.4H, V26.4H, V6.4H
    FMLA V1.4S, V28.4S, V8.S[0x0]
    FMUL V12.4S, V1.4S, V4.S[0x0]
    FMUL S29, S12, V7.S[0x1]
    FADDP  V2.4H, V17.4H, V19.4H
    FRSQRTS  V19.4S, V2.4S, V13.4S
    FMLA  V11.2S, V11.2S, V2.2S
    FABS  V18.4H, V1.4H
    FRECPE  V22.2S, V13.2S
    FMLA V31.4H, V5.4H, V13.H[0x5]
    FMLS V19.4S, V23.4S, V31.S[0x1]
    FMLS  V12.2S, V20.2S, V10.2S
    FADD  V16.2S, V15.2S, V18.2S
    FMULX H28, H6, V1.H[0x5]
    FMLS S8, S17, V13.S[0x2]
    FMLA V13.4S, V30.4S, V9.S[0x3]
    FRECPE  V9.4S, V22.4S
    FRSQRTE  V14.2D, V4.2D
    FRSQRTS  V15.4S, V29.4S, V16.4S
    FMUL D6, D27, V17.D[0x1]
    FABD  V23.2D, V8.2D, V14.2D
    FMLS  V14.4S, V13.4S, V6.4S
    FMLA  V4.2S, V6.2S, V19.2S
    FACGE  V13.2S, V14.2S, V28.2S
    FMULX  V1.8H, V27.8H, V11.8H
    FMULX  V8.8H, V10.8H, V23.8H
    FMLS  V18.2S, V13.2S, V13.2S
    FADD  V20.2D, V12.2D, V9.2D
    FRECPS  V14.2D, V31.2D, V8.2D
    FDIV  V19.4H, V4.4H, V7.4H
    FABS  V4.8H, V1.8H
    FABD  V11.2S, V4.2S, V9.2S
    FADDP  V27.4H, V14.4H, V29.4H
    FMLS V11.2D, V11.2D, V18.D[0x0]
    FMULX V23.2D, V19.2D, V13.D[0x1]
    FRSQRTE  V28.8H, V23.8H
    FMLA D12, D24, V15.D[0x1]
    FMLA S9, S4, V28.S[0x2]
    FACGE  V0.4H, V27.4H, V17.4H
    FMUL S1, S0, V17.S[0x1]
    FMUL  V29.8H, V12.8H, V1.8H
    FACGE  V15.8H, V11.8H, V10.8H
    FMLS H30, H5, V9.H[0x6]
    FMUL  V27.2D, V20.2D, V0.2D
    FMUL V7.2S, V27.2S, V1.S[0x3]
    FMLA V0.2D, V15.2D, V15.D[0x0]
    FMLS V12.4S, V15.4S, V3.S[0x0]
    FMLA V23.4H, V30.4H, V0.H[0x0]
    FACGE  V14.8H, V15.8H, V30.8H
    FMLA V11.4S, V16.4S, V14.S[0x0]
    FMULX V3.4S, V11.4S, V29.S[0x1]
    FMLS V20.2D, V11.2D, V25.D[0x1]
    FMOV  V11.8H, #1.75000000
    FABD  V18.2S, V3.2S, V26.2S
    FMUL V4.4S, V11.4S, V5.S[0x3]
    FRSQRTS  V3.4S, V20.4S, V11.4S
    FMLA V9.2D, V7.2D, V4.D[0x0]
    FACGE  V31.2D, V21.2D, V27.2D
    FRECPS  V24.4H, V9.4H, V21.4H
    FMLA D5, D31, V26.D[0x0]
    FMLA H3, H12, V15.H[0x2]
    FABD  V1.4H, V25.4H, V25.4H
    FMOV  V27.4S, #-3.12500000
    FNEG  V23.8H, V3.8H
    FADDP  V5.4S, V27.4S, V15.4S
    FMLS V20.2D, V21.2D, V1.D[0x1]
    FSQRT  V11.4S, V18.4S
    FSQRT  V26.2D, V11.2D
    FABD  V7.8H, V20.8H, V11.8H
    FMLS S30, S26, V24.S[0x2]
    FMOV  V18.4S, #1.87500000
    FNEG  V3.2D, V30.2D
    FNEG  V9.2S, V15.2S
    FMLA  V12.2S, V3.2S, V14.2S
    FMLA V14.4S, V9.4S, V30.S[0x2]
    FMLS H16, H5, V12.H[0x0]
    FADDP D3, V7.2D
    FMLS  V11.8H, V18.8H, V18.8H
    FABD  V31.2S, V16.2S, V14.2S
    FSQRT  V25.4H, V31.4H
    FMLA V26.2S, V3.2S, V11.S[0x1]
    FRSQRTS  V24.2D, V4.2D, V26.2D
    FMUL S3, S24, V25.S[0x3]
    FADD  V20.8H, V26.8H, V18.8H
    FADDP S7, V15.2S
    FMOV  V15.4S, #10.00000000
    FMULX V24.8H, V17.8H, V13.H[0x6]
    FMLA H25, H23, V8.H[0x1]
    FSQRT  V11.4H, V1.4H
    FMUL H17, H5, V9.H[0x7]
    FMOV  V8.2D, #-0.28125000
    FMOV  V24.8H, #7.50000000
    FADDP D14, V5.2D
    FRECPS  V9.2S, V14.2S, V3.2S
    FNEG  V31.4H, V15.4H
    FADD  V15.2S, V8.2S, V24.2S
    FMLS H7, H1, V9.H[0x6]
    FMLS V24.2S, V10.2S, V26.S[0x3]
    FADD  V31.4S, V23.4S, V20.4S
    FRSQRTS  V16.4S, V17.4S, V25.4S
    FABS  V19.4H, V24.4H
    FMLA D12, D5, V19.D[0x1]
    FMLA H19, H7, V7.H[0x3]
    FMUL V8.2D, V5.2D, V12.D[0x0]
    FMUL V22.8H, V28.8H, V11.H[0x2]
    FMUL D26, D19, V6.D[0x1]
    FABD  V18.8H, V0.8H, V8.8H
    FABS  V8.4S, V15.4S
    FMLA  V23.2S, V8.2S, V22.2S
    FRSQRTE  V3.8H, V26.8H
    FMLA  V10.4H, V18.4H, V3.4H
    FADD  V8.2S, V22.2S, V11.2S
    FMUL H3, H16, V8.H[0x3]
    FMOV  V14.4S, #-1.50000000
    FADD  V20.4H, V14.4H, V31.4H
    FMLS H6, H10, V2.H[0x6]
    FADD  V15.4H, V4.4H, V23.4H
    FACGE  V26.4H, V7.4H, V15.4H
    FMLS V12.8H, V4.8H, V3.H[0x0]
    FMLA H2, H26, V14.H[0x6]
    FMULX V7.2D, V20.2D, V3.D[0x0]
    FADDP D23, V18.2D
    FMLS V18.2S, V14.2S, V23.S[0x1]
    FDIV  V0.2D, V18.2D, V18.2D
    FRSQRTS  V25.4H, V21.4H, V7.4H
    FRECPS  V8.4S, V14.4S, V2.4S
    FMUL  V22.4S, V25.4S, V25.4S
    FABS  V25.4S, V8.4S
    FMUL  V7.8H, V25.8H, V0.8H
    FMLS  V14.2S, V22.2S, V7.2S
    FMLA D11, D10, V14.D[0x0]
    FMULX D4, D11, V6.D[0x1]
    FMOV  V0.4S, #0.13281250
    FABD  V7.2S, V24.2S, V20.2S
    FADDP  V14.8H, V9.8H, V19.8H
    FABS  V9.2D, V4.2D
    FMULX  V16.4H, V7.4H, V3.4H
    FACGT  V19.4H, V6.4H, V20.4H
    FNEG  V26.4H, V15.4H
    FRECPE  V10.4H, V8.4H
    FMULX H8, H20, V9.H[0x1]
    FMLS H23, H0, V7.H[0x5]
    FMLS S2, S15, V18.S[0x1]
    FMLA D21, D16, V19.D[0x0]
    FRSQRTE  V11.2S, V0.2S
    FRSQRTE  V0.4H, V23.4H
    FMLS S25, S21, V4.S[0x2]
    FABD  V10.8H, V8.8H, V14.8H
    FMLS V15.4H, V18.4H, V10.H[0x5]
    FMUL  V8.8H, V0.8H, V7.8H
    FMUL  V22.8H, V8.8H, V8.8H
    FRECPS  V12.4H, V22.4H, V23.4H
    FMLS  V14.4H, V25.4H, V2.4H
    SUBS  X4, X4, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_4
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X7, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X7, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X7, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X7, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X7, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X7, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X7, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X7, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X7, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X7, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X7, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X7, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X7, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X7, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X7, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X7, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X7, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X7, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MRS  X14, FPSR
    MOVZ  X7, #0x1f, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V0.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D0
    MOVZ  X7, #0x7fff, LSL #0
    MOVK  X7, #0x7c00, LSL #16
    MOVK  X7, #0x7c00, LSL #32
    MOVK  X7, #0x7c00, LSL #48
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V1.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D1
    MOVZ  X7, #0x7fff, LSL #0
    MOVK  X7, #0x7fff, LSL #16
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D2
    MOVZ  X7, #0x7fff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D3
    MOVZ  X7, #0x7fff, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D4
    MOVZ  X7, #0x7fff, LSL #0
    MOVK  X7, #0x7fff, LSL #16
    MOVK  X7, #0x7fff, LSL #32
    MOVK  X7, #0x7fff, LSL #48
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D5
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xc0c8, LSL #16
    MOVK  X7, #0xc0c8, LSL #48
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D6
    MOVZ  X7, #0x7fff, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D7
    MOVZ  X7, #0x7fff, LSL #0
    MOVK  X7, #0x7fff, LSL #16
    MOVK  X7, #0x7fff, LSL #32
    MOVK  X7, #0x7fff, LSL #48
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D8
    MOVZ  X7, #0x7fff, LSL #0
    MOVK  X7, #0x7fff, LSL #16
    MOVK  X7, #0x7fff, LSL #32
    MOVK  X7, #0x7fff, LSL #48
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D9
    MOVZ  X7, #0x7fff, LSL #0
    MOVK  X7, #0x7fff, LSL #16
    MOVK  X7, #0x7fff, LSL #32
    MOVK  X7, #0x7fff, LSL #48
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X7, #0x7fff, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D10
    MOVZ  X7, #0x7fff, LSL #0
    MOVK  X7, #0x4000, LSL #16
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D11
    MOVZ  X7, #0x8000, LSL #0
    MOVK  X7, #0x402f, LSL #16
    MOVK  X7, #0x8000, LSL #32
    MOVK  X7, #0x402f, LSL #48
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D12
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D13
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V14.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D14
    MOVZ  X7, #0x7fff, LSL #0
    MOVK  X7, #0x7fff, LSL #16
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D15
    MOVZ  X7, #0x7fff, LSL #0
    MOVK  X7, #0x7fff, LSL #16
    MOVK  X7, #0x7fff, LSL #32
    MOVK  X7, #0x7fff, LSL #48
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D16
    MOVZ  X7, #0x7fff, LSL #0
    MOVK  X7, #0x7fff, LSL #16
    MOVK  X7, #0x7fff, LSL #32
    MOVK  X7, #0x7fff, LSL #48
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D17
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D18
    MOVZ  X7, #0x7fff, LSL #0
    MOVK  X7, #0x7fff, LSL #16
    MOVK  X7, #0x7fff, LSL #32
    MOVK  X7, #0x7fff, LSL #48
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D19
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D20
    MOVZ  X7, #0x7fff, LSL #0
    MOVK  X7, #0x7fff, LSL #16
    MOVK  X7, #0x7fff, LSL #32
    MOVK  X7, #0x7fff, LSL #48
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D21
    MOVZ  X7, #0x7fff, LSL #0
    MOVK  X7, #0x7fff, LSL #16
    MOVK  X7, #0x7fff, LSL #32
    MOVK  X7, #0x7fff, LSL #48
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D22
    MOVZ  X7, #0x7fff, LSL #0
    MOVK  X7, #0x7fff, LSL #16
    MOVK  X7, #0x7fff, LSL #32
    MOVK  X7, #0x7fff, LSL #48
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D23
    MOVZ  X7, #0x7fff, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D24
    MOVZ  X7, #0x4780, LSL #0
    MOVK  X7, #0x4780, LSL #16
    MOVK  X7, #0x4780, LSL #32
    MOVK  X7, #0x4780, LSL #48
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D25
    MOVZ  X7, #0x7fff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D26
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xc048, LSL #16
    MOVK  X7, #0xc048, LSL #48
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D27
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xc048, LSL #16
    MOVK  X7, #0xc048, LSL #48
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X7, #0x7c00, LSL #0
    MOVK  X7, #0x7c00, LSL #16
    MOVK  X7, #0x7c00, LSL #32
    MOVK  X7, #0x7c00, LSL #48
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D28
    MOVZ  X7, #0x7fff, LSL #0
    MOVK  X7, #0x7fff, LSL #16
    MOVK  X7, #0x7fff, LSL #32
    MOVK  X7, #0x7fff, LSL #48
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D29
    MOVZ  X7, #0x7fff, LSL #0
    MOVK  X7, #0x7fff, LSL #16
    MOVK  X7, #0x7fff, LSL #32
    MOVK  X7, #0x7fff, LSL #48
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V30.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D30
    MOVZ  X7, #0x7fff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, V31.D[1]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0x3fef, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0x3fef, LSL #48
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X14, D31
    MOVZ  X7, #0x7fff, LSL #0
    MOVK  X7, #0x7fff, LSL #16
    MOVK  X7, #0x7fff, LSL #32
    MOVK  X7, #0x7fff, LSL #48
    SUB  X8, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0x5f27, LSL #0
    MOVK  X2, #0x177e, LSL #16
    MOVK  X2, #0xf117, LSL #32
    MOVK  X2, #0xe78e, LSL #48
    MOVZ  X3, #0x1970, LSL #0
    MOVK  X3, #0xf41a, LSL #16
    MOVK  X3, #0x902b, LSL #32
    MOVK  X3, #0x2da5, LSL #48
    MOVZ  X4, #0x5778, LSL #0
    MOVK  X4, #0x41ce, LSL #16
    MOVK  X4, #0xa994, LSL #32
    MOVK  X4, #0x100d, LSL #48
    MOVZ  X5, #0xf641, LSL #0
    MOVK  X5, #0x5da6, LSL #16
    MOVK  X5, #0xedc7, LSL #32
    MOVK  X5, #0x73c1, LSL #48
    MOVZ  X6, #0x2500, LSL #0
    MOVK  X6, #0x289a, LSL #16
    MOVK  X6, #0x10a2, LSL #32
    MOVK  X6, #0x3393, LSL #48
    MOVZ  X7, #0x37ad, LSL #0
    MOVK  X7, #0x2cad, LSL #16
    MOVK  X7, #0xc90a, LSL #32
    MOVK  X7, #0x2772, LSL #48
    MOVZ  X8, #0x285b, LSL #0
    MOVK  X8, #0xc04e, LSL #16
    MOVK  X8, #0xd995, LSL #32
    MOVK  X8, #0xf7de, LSL #48
    MOVZ  X9, #0x8d28, LSL #0
    MOVK  X9, #0xc985, LSL #16
    MOVK  X9, #0x43f2, LSL #32
    MOVK  X9, #0x1f55, LSL #48
    MOVZ  X10, #0x9c34, LSL #0
    MOVK  X10, #0xd49a, LSL #16
    MOVK  X10, #0x9d14, LSL #32
    MOVK  X10, #0x75f1, LSL #48
    MOVZ  X11, #0x8b96, LSL #0
    MOVK  X11, #0xd6a8, LSL #16
    MOVK  X11, #0xb2f9, LSL #32
    MOVK  X11, #0x1483, LSL #48
    MOVZ  X12, #0x7c37, LSL #0
    MOVK  X12, #0x28e6, LSL #16
    MOVK  X12, #0xba04, LSL #32
    MOVK  X12, #0x92ac, LSL #48
    MOVZ  X13, #0xfcd1, LSL #0
    MOVK  X13, #0x316f, LSL #16
    MOVK  X13, #0xac09, LSL #32
    MOVK  X13, #0x12ff, LSL #48
    MOVZ  X14, #0xa1e8, LSL #0
    MOVK  X14, #0x5fdc, LSL #16
    MOVK  X14, #0x1e7e, LSL #32
    MOVK  X14, #0x61f1, LSL #48
    MOVZ  X15, #0x28a6, LSL #0
    MOVK  X15, #0x2fc9, LSL #16
    MOVK  X15, #0x4ead, LSL #32
    MOVK  X15, #0x18e3, LSL #48
    MOVZ  X16, #0x7812, LSL #0
    MOVK  X16, #0xf0a7, LSL #16
    MOVK  X16, #0x7467, LSL #32
    MOVK  X16, #0xda51, LSL #48
    MOVZ  X17, #0xe458, LSL #0
    MOVK  X17, #0x58b4, LSL #16
    MOVK  X17, #0xd1ad, LSL #32
    MOVK  X17, #0x71e, LSL #48
    MOVZ  X23, #0x882c, LSL #0
    MOVK  X23, #0xe8c, LSL #16
    MOVK  X23, #0x6e2e, LSL #32
    MOVK  X23, #0xaa84, LSL #48
    MOVZ  X24, #0xb931, LSL #0
    MOVK  X24, #0x33b1, LSL #16
    MOVK  X24, #0xb220, LSL #32
    MOVK  X24, #0x2431, LSL #48
    MOVZ  X25, #0xb227, LSL #0
    MOVK  X25, #0x19db, LSL #16
    MOVK  X25, #0x6bf4, LSL #32
    MOVK  X25, #0x7437, LSL #48
    MOVZ  X26, #0xea8, LSL #0
    MOVK  X26, #0xb8b2, LSL #16
    MOVK  X26, #0xc1dd, LSL #32
    MOVK  X26, #0x3dc2, LSL #48
    MOVZ  X27, #0x4bde, LSL #0
    MOVK  X27, #0xdcbf, LSL #16
    MOVK  X27, #0xeae5, LSL #32
    MOVK  X27, #0x3ffc, LSL #48
    MOVZ  X28, #0x6797, LSL #0
    MOVK  X28, #0x6b0f, LSL #16
    MOVK  X28, #0x88b2, LSL #32
    MOVK  X28, #0x6617, LSL #48
    MOVZ  X29, #0xcdd5, LSL #0
    MOVK  X29, #0x2cd8, LSL #16
    MOVK  X29, #0x9004, LSL #32
    MOVK  X29, #0xfb58, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X28
    FMOV  D1, X26
    FMOV  V1.D[1], X25
    FMOV  D2, X27
    FMOV  V2.D[1], X11
    FMOV  D3, X4
    FMOV  V3.D[1], X25
    FMOV  D4, X15
    FMOV  V4.D[1], X2
    FMOV  D5, X8
    FMOV  V5.D[1], X15
    FMOV  D6, X26
    FMOV  V6.D[1], X25
    FMOV  D7, X26
    FMOV  V7.D[1], X26
    FMOV  D8, X17
    FMOV  V8.D[1], X2
    FMOV  D9, X29
    FMOV  V9.D[1], X28
    FMOV  D10, X24
    FMOV  V10.D[1], X3
    FMOV  D11, X13
    FMOV  V11.D[1], X2
    FMOV  D12, X6
    FMOV  V12.D[1], X9
    FMOV  D13, X17
    FMOV  V13.D[1], X10
    FMOV  D14, X10
    FMOV  V14.D[1], X12
    FMOV  D15, X25
    FMOV  V15.D[1], X7
    FMOV  D16, X13
    FMOV  V16.D[1], X12
    FMOV  D17, X3
    FMOV  V17.D[1], X2
    FMOV  D18, X17
    FMOV  V18.D[1], X14
    FMOV  D19, X24
    FMOV  V19.D[1], X10
    FMOV  D20, X6
    FMOV  V20.D[1], X27
    FMOV  D21, X25
    FMOV  V21.D[1], X6
    FMOV  D22, X8
    FMOV  V22.D[1], X26
    FMOV  D23, X9
    FMOV  V23.D[1], X15
    FMOV  D24, X13
    FMOV  V24.D[1], X10
    FMOV  D25, X8
    FMOV  V25.D[1], X5
    FMOV  D26, X7
    FMOV  V26.D[1], X4
    FMOV  D27, X25
    FMOV  V27.D[1], X8
    FMOV  D28, X7
    FMOV  V28.D[1], X23
    FMOV  D29, X14
    FMOV  V29.D[1], X15
    FMOV  D30, X6
    FMOV  V30.D[1], X16
    FMOV  D31, X29
    FMOV  V31.D[1], X11
    MOVZ  X28, #0xa, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_5:
    FMLA S25, S10, V26.S[0x3]
    FMLS S28, S28, V25.S[0x1]
    FADD  V0.4H, V29.4H, V31.4H
    FABS  V12.2S, V30.2S
    FABS  V3.4H, V27.4H
    FMULX  V0.8H, V3.8H, V15.8H
    FMUL S27, S23, V28.S[0x3]
    FADDP S1, V12.2S
    FDIV  V30.8H, V0.8H, V0.8H
    FADDP  V8.2S, V22.2S, V1.2S
    FRECPS  V22.2D, V25.2D, V26.2D
    FRSQRTE  V21.2D, V11.2D
    FMLA  V18.4H, V31.4H, V6.4H
    FMUL S4, S21, V8.S[0x1]
    FMLA H6, H15, V5.H[0x7]
    FRSQRTE  V30.2S, V4.2S
    FMULX  V29.8H, V6.8H, V27.8H
    FACGT  V27.4S, V21.4S, V20.4S
    FMUL V4.4S, V16.4S, V18.S[0x0]
    FDIV  V11.4S, V29.4S, V22.4S
    FACGE  V25.4H, V4.4H, V12.4H
    FABD  V20.8H, V25.8H, V18.8H
    FSQRT  V15.4S, V27.4S
    FMLS V23.4S, V20.4S, V20.S[0x0]
    FMLS V31.2S, V21.2S, V15.S[0x0]
    FMULX D1, D0, V31.D[0x0]
    FDIV  V16.4H, V23.4H, V22.4H
    FMULX V26.4H, V8.4H, V12.H[0x4]
    FMULX D28, D24, V30.D[0x0]
    FMULX D4, D11, V0.D[0x0]
    FACGT  V12.4H, V1.4H, V16.4H
    FMLA S1, S28, V1.S[0x2]
    FMLS V21.2S, V1.2S, V26.S[0x3]
    FMUL  V11.4S, V31.4S, V21.4S
    FMLA V28.8H, V10.8H, V12.H[0x1]
    FMOV  V27.2D, #0.45312500
    FMUL  V31.4H, V27.4H, V10.4H
    FMOV  V26.8H, #9.50000000
    FADDP D29, V7.2D
    FMOV  V10.4S, #-3.37500000
    FMUL H21, H26, V1.H[0x4]
    FDIV  V20.8H, V21.8H, V29.8H
    FADD  V0.4H, V22.4H, V28.4H
    FADD  V18.4S, V10.4S, V11.4S
    FADDP D23, V7.2D
    FRECPS  V12.2S, V18.2S, V20.2S
    FSUB  V15.4H, V28.4H, V4.4H
    FACGE  V4.4S, V8.4S, V1.4S
    FRECPE  V21.4H, V4.4H
    FNEG  V26.8H, V23.8H
    FNEG  V31.2S, V9.2S
    FMLS V26.2D, V26.2D, V21.D[0x1]
    FDIV  V29.8H, V6.8H, V12.8H
    FMULX H4, H1, V15.H[0x2]
    FMLA H10, H0, V0.H[0x2]
    FADDP S9, V29.2S
    FMLS D27, D19, V9.D[0x1]
    FMLA S9, S4, V4.S[0x2]
    FRECPS  V23.4H, V25.4H, V26.4H
    FABS  V3.4S, V23.4S
    FRSQRTE  V14.2D, V13.2D
    FMULX  V4.8H, V27.8H, V3.8H
    FMULX  V25.2S, V9.2S, V10.2S
    FMUL S10, S21, V20.S[0x3]
    FMLA V29.8H, V25.8H, V1.H[0x1]
    FSQRT  V11.4H, V10.4H
    FMLA V5.2D, V27.2D, V11.D[0x0]
    FMLA V27.4S, V29.4S, V14.S[0x1]
    FMUL D22, D4, V25.D[0x0]
    FMULX  V17.2S, V11.2S, V5.2S
    FMLS V21.4S, V3.4S, V6.S[0x2]
    FRSQRTS  V3.4S, V16.4S, V16.4S
    FMULX S12, S31, V31.S[0x2]
    FMLA  V13.4H, V21.4H, V27.4H
    FRECPE  V0.2D, V26.2D
    FDIV  V14.8H, V23.8H, V3.8H
    FMLS H5, H21, V13.H[0x6]
    FMLA  V25.4H, V27.4H, V14.4H
    FMLA V13.2S, V30.2S, V4.S[0x0]
    FNEG  V6.8H, V17.8H
    FSUB  V26.8H, V5.8H, V17.8H
    FSQRT  V21.2S, V6.2S
    FRSQRTS  V23.8H, V12.8H, V0.8H
    FMLA V2.2D, V23.2D, V24.D[0x0]
    FRSQRTE  V24.8H, V18.8H
    FMLS H27, H26, V13.H[0x4]
    FRECPE  V16.4S, V22.4S
    FMOV  V31.2S, #29.00000000
    FMLS S0, S21, V31.S[0x2]
    FMOV  V14.2D, #-27.00000000
    FDIV  V30.8H, V8.8H, V27.8H
    FMULX H18, H25, V14.H[0x3]
    FMULX D1, D2, V24.D[0x0]
    FABS  V31.4H, V0.4H
    FRSQRTS  V22.2S, V11.2S, V30.2S
    FSQRT  V29.4H, V5.4H
    FMUL V9.2D, V18.2D, V29.D[0x0]
    FSQRT  V23.4H, V31.4H
    FADDP H11, V10.2H
    FMULX V24.8H, V29.8H, V14.H[0x7]
    FRECPE  V17.4H, V12.4H
    FMLA V10.2D, V21.2D, V16.D[0x1]
    FMLA V28.2D, V16.2D, V9.D[0x0]
    FMLS V5.4S, V25.4S, V1.S[0x1]
    FRECPE  V21.4H, V5.4H
    FMULX D0, D11, V10.D[0x1]
    FSQRT  V25.8H, V21.8H
    FMLS V18.4S, V23.4S, V9.S[0x3]
    FMOV  V8.8H, #22.00000000
    FMLS H21, H22, V0.H[0x4]
    FMLA S29, S24, V25.S[0x0]
    FMUL  V16.4S, V8.4S, V17.4S
    FRSQRTE  V0.2D, V18.2D
    FMOV  V25.4H, #0.78125000
    FRECPS  V9.2S, V18.2S, V29.2S
    FMUL D22, D27, V9.D[0x0]
    FMLS H14, H14, V11.H[0x0]
    FRSQRTE  V5.4S, V0.4S
    FRSQRTE  V0.4H, V23.4H
    FMLA  V29.4H, V22.4H, V13.4H
    FADDP D22, V3.2D
    FMLA H23, H4, V0.H[0x3]
    FMLA D0, D5, V22.D[0x0]
    FMLS V18.4H, V21.4H, V2.H[0x0]
    FMOV  V4.4H, #-0.96875000
    FMLS  V11.4H, V0.4H, V26.4H
    FMULX  V9.4H, V2.4H, V25.4H
    FRECPS  V3.4S, V9.4S, V28.4S
    FADDP  V22.4H, V16.4H, V4.4H
    FSUB  V12.2S, V18.2S, V27.2S
    FMLA  V2.2S, V3.2S, V6.2S
    FMLS V27.8H, V20.8H, V14.H[0x4]
    FADD  V28.4S, V12.4S, V12.4S
    FACGT  V0.2D, V22.2D, V29.2D
    FACGT  V3.4H, V11.4H, V11.4H
    FMLA H12, H21, V8.H[0x3]
    FMLA V8.2S, V17.2S, V0.S[0x0]
    FABD  V29.8H, V28.8H, V29.8H
    FADD  V18.4S, V5.4S, V29.4S
    FMLA  V14.2S, V3.2S, V27.2S
    FMLA V29.2S, V12.2S, V12.S[0x3]
    FRECPE  V12.8H, V18.8H
    FRECPS  V3.8H, V10.8H, V29.8H
    FMULX H18, H29, V14.H[0x2]
    FMUL  V28.2S, V26.2S, V5.2S
    FABD  V26.2S, V22.2S, V3.2S
    FRSQRTS  V13.8H, V7.8H, V8.8H
    FMULX V21.8H, V26.8H, V10.H[0x6]
    FMOV  V7.8H, #0.65625000
    FMUL V4.2D, V26.2D, V21.D[0x1]
    FMOV  V31.4H, #-3.25000000
    FACGE  V14.2S, V20.2S, V11.2S
    FADD  V22.2S, V7.2S, V21.2S
    FADDP S17, V22.2S
    FMLS S25, S25, V13.S[0x3]
    FMOV  V5.2S, #-1.18750000
    FABS  V8.4H, V17.4H
    FNEG  V7.2D, V8.2D
    FMLS S23, S12, V12.S[0x1]
    FRSQRTS  V11.2D, V7.2D, V5.2D
    FACGE  V8.8H, V4.8H, V11.8H
    FADDP  V10.2D, V27.2D, V25.2D
    FMUL H26, H24, V2.H[0x3]
    FADDP  V23.4H, V14.4H, V18.4H
    FADDP  V6.2S, V31.2S, V10.2S
    FMOV  V25.4S, #3.00000000
    FMLA  V18.4S, V30.4S, V25.4S
    FMLA V8.8H, V8.8H, V15.H[0x6]
    FMOV  V20.8H, #-0.14843750
    FACGT  V13.4H, V15.4H, V6.4H
    FMLA V22.4S, V20.4S, V20.S[0x0]
    FMLS  V19.2D, V19.2D, V23.2D
    FSQRT  V31.8H, V13.8H
    FABS  V2.8H, V19.8H
    FABD  V4.4H, V22.4H, V31.4H
    FMULX V11.2D, V8.2D, V30.D[0x1]
    FMUL  V23.4S, V2.4S, V2.4S
    FACGE  V25.4S, V26.4S, V18.4S
    FABD  V14.4S, V31.4S, V0.4S
    FSUB  V6.4H, V4.4H, V25.4H
    FSQRT  V31.4S, V22.4S
    FACGE  V18.2D, V5.2D, V23.2D
    FADDP  V5.4H, V6.4H, V18.4H
    FMUL  V6.4H, V9.4H, V17.4H
    FMLA V22.4S, V11.4S, V14.S[0x1]
    FMULX V12.2D, V14.2D, V23.D[0x0]
    FMLA H7, H13, V13.H[0x2]
    FACGT  V4.4S, V6.4S, V31.4S
    FRSQRTS  V18.2S, V5.2S, V7.2S
    FMUL V7.2D, V9.2D, V12.D[0x0]
    FMUL V20.2D, V2.2D, V22.D[0x0]
    FMLS V12.2S, V4.2S, V20.S[0x0]
    FMUL S31, S3, V13.S[0x2]
    FABD  V26.2D, V8.2D, V29.2D
    FADDP  V23.8H, V18.8H, V7.8H
    FACGE  V8.4S, V6.4S, V20.4S
    FADDP H0, V23.2H
    FMLA V9.2D, V31.2D, V13.D[0x1]
    FRECPS  V6.4H, V25.4H, V8.4H
    FMLA D2, D0, V28.D[0x0]
    SUBS  X28, X28, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_5
    MOVZ  X13, #0x5f27, LSL #0
    MOVK  X13, #0x177e, LSL #16
    MOVK  X13, #0xf117, LSL #32
    MOVK  X13, #0xe78e, LSL #48
    SUB  X9, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x1970, LSL #0
    MOVK  X13, #0xf41a, LSL #16
    MOVK  X13, #0x902b, LSL #32
    MOVK  X13, #0x2da5, LSL #48
    SUB  X9, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x5778, LSL #0
    MOVK  X13, #0x41ce, LSL #16
    MOVK  X13, #0xa994, LSL #32
    MOVK  X13, #0x100d, LSL #48
    SUB  X9, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xf641, LSL #0
    MOVK  X13, #0x5da6, LSL #16
    MOVK  X13, #0xedc7, LSL #32
    MOVK  X13, #0x73c1, LSL #48
    SUB  X9, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x2500, LSL #0
    MOVK  X13, #0x289a, LSL #16
    MOVK  X13, #0x10a2, LSL #32
    MOVK  X13, #0x3393, LSL #48
    SUB  X9, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x37ad, LSL #0
    MOVK  X13, #0x2cad, LSL #16
    MOVK  X13, #0xc90a, LSL #32
    MOVK  X13, #0x2772, LSL #48
    SUB  X9, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x285b, LSL #0
    MOVK  X13, #0xc04e, LSL #16
    MOVK  X13, #0xd995, LSL #32
    MOVK  X13, #0xf7de, LSL #48
    SUB  X9, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x8b96, LSL #0
    MOVK  X13, #0xd6a8, LSL #16
    MOVK  X13, #0xb2f9, LSL #32
    MOVK  X13, #0x1483, LSL #48
    SUB  X9, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x7c37, LSL #0
    MOVK  X13, #0x28e6, LSL #16
    MOVK  X13, #0xba04, LSL #32
    MOVK  X13, #0x92ac, LSL #48
    SUB  X9, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xa1e8, LSL #0
    MOVK  X13, #0x5fdc, LSL #16
    MOVK  X13, #0x1e7e, LSL #32
    MOVK  X13, #0x61f1, LSL #48
    SUB  X9, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x28a6, LSL #0
    MOVK  X13, #0x2fc9, LSL #16
    MOVK  X13, #0x4ead, LSL #32
    MOVK  X13, #0x18e3, LSL #48
    SUB  X9, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x7812, LSL #0
    MOVK  X13, #0xf0a7, LSL #16
    MOVK  X13, #0x7467, LSL #32
    MOVK  X13, #0xda51, LSL #48
    SUB  X9, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xe458, LSL #0
    MOVK  X13, #0x58b4, LSL #16
    MOVK  X13, #0xd1ad, LSL #32
    MOVK  X13, #0x71e, LSL #48
    SUB  X9, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x882c, LSL #0
    MOVK  X13, #0xe8c, LSL #16
    MOVK  X13, #0x6e2e, LSL #32
    MOVK  X13, #0xaa84, LSL #48
    SUB  X9, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xb931, LSL #0
    MOVK  X13, #0x33b1, LSL #16
    MOVK  X13, #0xb220, LSL #32
    MOVK  X13, #0x2431, LSL #48
    SUB  X9, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xb227, LSL #0
    MOVK  X13, #0x19db, LSL #16
    MOVK  X13, #0x6bf4, LSL #32
    MOVK  X13, #0x7437, LSL #48
    SUB  X9, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xea8, LSL #0
    MOVK  X13, #0xb8b2, LSL #16
    MOVK  X13, #0xc1dd, LSL #32
    MOVK  X13, #0x3dc2, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x4bde, LSL #0
    MOVK  X13, #0xdcbf, LSL #16
    MOVK  X13, #0xeae5, LSL #32
    MOVK  X13, #0x3ffc, LSL #48
    SUB  X9, X13, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xcdd5, LSL #0
    MOVK  X13, #0x2cd8, LSL #16
    MOVK  X13, #0x9004, LSL #32
    MOVK  X13, #0xfb58, LSL #48
    SUB  X9, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MRS  X13, FPSR
    MOVZ  X9, #0x1f, LSL #0
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V0.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D0
    MOVZ  X9, #0x7e00, LSL #0
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V1.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D1
    MOVZ  X9, #0x7e00, LSL #0
    MOVK  X9, #0x7fff, LSL #16
    MOVK  X9, #0x7c00, LSL #32
    MOVK  X9, #0xfff8, LSL #48
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D2
    MOVZ  X9, #0x7fff, LSL #0
    MOVK  X9, #0x7fff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X9, #0x4000, LSL #0
    MOVK  X9, #0x4000, LSL #16
    MOVK  X9, #0x4000, LSL #32
    MOVK  X9, #0x4000, LSL #48
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D3
    MOVZ  X9, #0x7fff, LSL #0
    MOVK  X9, #0x7fff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V4.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D4
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D5
    MOVZ  X9, #0x7e00, LSL #0
    MOVK  X9, #0x7fff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D6
    MOVZ  X9, #0x4000, LSL #0
    MOVK  X9, #0x4000, LSL #16
    MOVK  X9, #0x4000, LSL #32
    MOVK  X9, #0x4000, LSL #48
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V7.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D7
    MOVZ  X9, #0x7e00, LSL #0
    MOVK  X9, #0x7fff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V8.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D8
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D9
    MOVZ  X9, #0x7e00, LSL #0
    MOVK  X9, #0x7fff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X9, #0x2754, LSL #0
    MOVK  X9, #0x3a28, LSL #16
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D10
    MOVZ  X9, #0x7fdf, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0x7fff, LSL #32
    MOVK  X9, #0x7fff, LSL #48
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X9, #0x7def, LSL #0
    MOVK  X9, #0x7e00, LSL #16
    MOVK  X9, #0x7e00, LSL #32
    MOVK  X9, #0x3de0, LSL #48
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D11
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D12
    MOVZ  X9, #0x7e00, LSL #0
    MOVK  X9, #0x7fff, LSL #16
    MOVK  X9, #0x7e00, LSL #32
    MOVK  X9, #0x7fff, LSL #48
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V13.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D13
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V14.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D14
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D15
    MOVZ  X9, #0xffde, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0x7fff, LSL #32
    MOVK  X9, #0x7fff, LSL #48
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D16
    MOVZ  X9, #0x7e00, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0x7f7f, LSL #48
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D17
    MOVZ  X9, #0x7e00, LSL #0
    MOVK  X9, #0x7fff, LSL #16
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D18
    MOVZ  X9, #0x7e00, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0x7fff, LSL #48
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X9, #0x9c34, LSL #0
    MOVK  X9, #0xd49a, LSL #16
    MOVK  X9, #0x9d14, LSL #32
    MOVK  X9, #0x75f1, LSL #48
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D19
    MOVZ  X9, #0xb927, LSL #0
    MOVK  X9, #0x33b1, LSL #16
    MOVK  X9, #0xb220, LSL #32
    MOVK  X9, #0x2431, LSL #48
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X9, #0x7e00, LSL #0
    MOVK  X9, #0x7fff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0x7fff, LSL #48
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D20
    MOVZ  X9, #0x7e00, LSL #0
    MOVK  X9, #0x7fff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0x7fff, LSL #48
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D21
    MOVZ  X9, #0x7e00, LSL #0
    MOVK  X9, #0x7fff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0x7fff, LSL #48
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X9, #0x99a, LSL #0
    MOVK  X9, #0x2211, LSL #16
    MOVK  X9, #0x99a, LSL #32
    MOVK  X9, #0x2211, LSL #48
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D22
    MOVZ  X9, #0x7e00, LSL #0
    MOVK  X9, #0x7fff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0x7fff, LSL #48
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V23.D[1]
    MOVZ  X9, #0x7e00, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D23
    MOVZ  X9, #0x7e00, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X9, #0x8000, LSL #0
    MOVK  X9, #0x8000, LSL #16
    MOVK  X9, #0x8000, LSL #32
    MOVK  X9, #0x8000, LSL #48
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D24
    MOVZ  X9, #0x7fff, LSL #0
    MOVK  X9, #0x8000, LSL #16
    MOVK  X9, #0x8000, LSL #32
    MOVK  X9, #0x8000, LSL #48
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D25
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V26.D[1]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D26
    MOVZ  X9, #0x7e00, LSL #0
    MOVK  X9, #0x7fff, LSL #16
    MOVK  X9, #0x7e00, LSL #32
    MOVK  X9, #0x7e80, LSL #48
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X9, #0xfe00, LSL #0
    MOVK  X9, #0xfe00, LSL #16
    MOVK  X9, #0xfe00, LSL #32
    MOVK  X9, #0xfe00, LSL #48
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D27
    MOVZ  X9, #0x7fdf, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0x7fff, LSL #32
    MOVK  X9, #0x7fff, LSL #48
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V28.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D28
    MOVZ  X9, #0x7fff, LSL #0
    MOVK  X9, #0x7fff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V29.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D29
    MOVZ  X9, #0x7e00, LSL #0
    MOVK  X9, #0x7fff, LSL #16
    MOVK  X9, #0x7e00, LSL #32
    MOVK  X9, #0x7e80, LSL #48
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V30.D[1]
    MOVZ  X9, #0x7e00, LSL #0
    MOVK  X9, #0x7e00, LSL #16
    MOVK  X9, #0x7e00, LSL #32
    MOVK  X9, #0x7e00, LSL #48
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D30
    MOVZ  X9, #0x7fff, LSL #0
    MOVK  X9, #0x7fff, LSL #16
    MOVK  X9, #0x7e00, LSL #32
    MOVK  X9, #0x7fff, LSL #48
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, V31.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X13, D31
    MOVZ  X9, #0x7fff, LSL #0
    MOVK  X9, #0x7fff, LSL #16
    SUB  X10, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
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
    FMOV  D0, X6
    FMOV  V0.D[1], X16
    FMOV  D1, X11
    FMOV  V1.D[1], X25
    FMOV  D2, X17
    FMOV  V2.D[1], X27
    FMOV  D3, X15
    FMOV  V3.D[1], X24
    FMOV  D4, X4
    FMOV  V4.D[1], X29
    FMOV  D5, X28
    FMOV  V5.D[1], X3
    FMOV  D6, X10
    FMOV  V6.D[1], X14
    FMOV  D7, X26
    FMOV  V7.D[1], X26
    FMOV  D8, X9
    FMOV  V8.D[1], X26
    FMOV  D9, X13
    FMOV  V9.D[1], X26
    FMOV  D10, X8
    FMOV  V10.D[1], X2
    FMOV  D11, X15
    FMOV  V11.D[1], X3
    FMOV  D12, X9
    FMOV  V12.D[1], X17
    FMOV  D13, X3
    FMOV  V13.D[1], X7
    FMOV  D14, X14
    FMOV  V14.D[1], X28
    FMOV  D15, X23
    FMOV  V15.D[1], X15
    FMOV  D16, X5
    FMOV  V16.D[1], X16
    FMOV  D17, X23
    FMOV  V17.D[1], X27
    FMOV  D18, X6
    FMOV  V18.D[1], X3
    FMOV  D19, X14
    FMOV  V19.D[1], X23
    FMOV  D20, X13
    FMOV  V20.D[1], X23
    FMOV  D21, X26
    FMOV  V21.D[1], X9
    FMOV  D22, X10
    FMOV  V22.D[1], X28
    FMOV  D23, X7
    FMOV  V23.D[1], X28
    FMOV  D24, X9
    FMOV  V24.D[1], X8
    FMOV  D25, X24
    FMOV  V25.D[1], X3
    FMOV  D26, X16
    FMOV  V26.D[1], X6
    FMOV  D27, X7
    FMOV  V27.D[1], X10
    FMOV  D28, X26
    FMOV  V28.D[1], X10
    FMOV  D29, X2
    FMOV  V29.D[1], X6
    FMOV  D30, X14
    FMOV  V30.D[1], X24
    FMOV  D31, X8
    FMOV  V31.D[1], X14
    MOVZ  X29, #0xa, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_6:
    FMLS  V21.4H, V10.4H, V17.4H
    FMULX  V12.2D, V29.2D, V31.2D
    FADDP  V4.2D, V24.2D, V19.2D
    FMOV  V29.2D, #1.31250000
    FSQRT  V3.2D, V4.2D
    FRECPS  V23.4S, V3.4S, V11.4S
    FDIV  V30.4H, V20.4H, V21.4H
    FRSQRTS  V29.2D, V28.2D, V26.2D
    FDIV  V8.2S, V23.2S, V12.2S
    FMUL V20.8H, V4.8H, V8.H[0x6]
    FMUL V19.2D, V29.2D, V25.D[0x0]
    FMUL  V31.2D, V26.2D, V1.2D
    FRECPS  V31.8H, V28.8H, V20.8H
    FADD  V21.2S, V30.2S, V18.2S
    FSQRT  V24.2S, V31.2S
    FMLA D23, D24, V19.D[0x1]
    FDIV  V11.2D, V21.2D, V23.2D
    FMUL D15, D0, V3.D[0x1]
    FADDP D30, V13.2D
    FNEG  V3.8H, V2.8H
    FMUL V23.2D, V10.2D, V20.D[0x1]
    FADD  V3.4S, V6.4S, V15.4S
    FMUL S28, S24, V11.S[0x0]
    FMLS H25, H4, V7.H[0x7]
    FRSQRTS  V15.2D, V12.2D, V12.2D
    FMLS V20.2S, V0.2S, V31.S[0x2]
    FMULX H4, H1, V6.H[0x7]
    FDIV  V10.4S, V12.4S, V27.4S
    FACGT  V23.8H, V25.8H, V25.8H
    FMUL V25.4S, V10.4S, V1.S[0x2]
    FMUL V13.2D, V4.2D, V3.D[0x1]
    FADDP  V19.2S, V28.2S, V26.2S
    FACGE  V7.4H, V4.4H, V30.4H
    FMLS  V18.2S, V15.2S, V15.2S
    FMLS S28, S26, V23.S[0x3]
    FRSQRTE  V11.4H, V8.4H
    FADDP  V24.4S, V25.4S, V11.4S
    FMUL V2.8H, V24.8H, V13.H[0x6]
    FRSQRTE  V7.8H, V30.8H
    FMULX V12.4S, V16.4S, V28.S[0x1]
    FABS  V23.4S, V12.4S
    FRECPE  V26.8H, V2.8H
    FADD  V12.4H, V17.4H, V29.4H
    FABS  V17.2S, V25.2S
    FRECPS  V2.8H, V20.8H, V15.8H
    FADDP D6, V29.2D
    FSQRT  V3.4S, V6.4S
    FMUL D20, D12, V18.D[0x1]
    FRECPE  V8.4H, V25.4H
    FMLA  V6.2S, V23.2S, V20.2S
    FRECPE  V24.8H, V3.8H
    FMLS V11.2D, V10.2D, V6.D[0x1]
    FSUB  V31.4H, V29.4H, V11.4H
    FADDP H28, V31.2H
    FADDP  V29.2S, V2.2S, V25.2S
    FMULX D12, D8, V22.D[0x1]
    FMULX H11, H7, V5.H[0x5]
    FMUL D18, D24, V11.D[0x1]
    FNEG  V27.4S, V12.4S
    FMLS S4, S2, V27.S[0x0]
    FMULX V23.2D, V18.2D, V0.D[0x0]
    FADDP S0, V18.2S
    FMULX  V24.2D, V24.2D, V20.2D
    FMUL V6.8H, V17.8H, V0.H[0x6]
    FMULX  V7.4H, V13.4H, V15.4H
    FMUL S27, S6, V8.S[0x2]
    FMUL V20.2S, V27.2S, V23.S[0x2]
    FADD  V28.8H, V1.8H, V29.8H
    FSQRT  V10.8H, V4.8H
    FRSQRTE  V6.8H, V20.8H
    FMLA D29, D23, V24.D[0x0]
    FSQRT  V8.4H, V29.4H
    FMUL  V11.8H, V28.8H, V28.8H
    FRECPS  V28.2D, V11.2D, V11.2D
    FMULX  V8.2S, V9.2S, V28.2S
    FACGE  V28.2S, V7.2S, V12.2S
    FMUL V20.2D, V8.2D, V28.D[0x1]
    FMOV  V18.8H, #0.17187500
    FRSQRTE  V29.2S, V13.2S
    FMLS H4, H21, V2.H[0x3]
    FACGE  V15.2S, V18.2S, V20.2S
    FMUL  V28.4H, V7.4H, V7.4H
    FNEG  V5.4S, V29.4S
    FABS  V7.4H, V7.4H
    FRECPE  V23.8H, V10.8H
    FMLA V20.2D, V28.2D, V11.D[0x1]
    FADD  V2.2S, V12.2S, V4.2S
    FMOV  V3.8H, #29.00000000
    FADDP H4, V7.2H
    FSQRT  V13.2S, V4.2S
    FMULX S5, S13, V21.S[0x0]
    FMLS  V14.2D, V20.2D, V20.2D
    FMLS H13, H5, V14.H[0x6]
    FMLS H1, H3, V3.H[0x2]
    FADDP S11, V2.2S
    FMLA V14.2D, V23.2D, V0.D[0x1]
    FRSQRTS  V23.4H, V1.4H, V5.4H
    FMULX  V2.2S, V20.2S, V12.2S
    FACGT  V10.2D, V5.2D, V11.2D
    FABD  V18.2D, V15.2D, V2.2D
    FACGE  V2.4H, V10.4H, V23.4H
    FRSQRTE  V1.2S, V2.2S
    FDIV  V29.4H, V14.4H, V10.4H
    FMLS V21.2D, V1.2D, V20.D[0x1]
    FSUB  V10.4H, V0.4H, V21.4H
    FRECPE  V23.2S, V25.2S
    FMUL V0.8H, V1.8H, V13.H[0x1]
    FMULX  V11.4H, V0.4H, V14.4H
    FACGE  V13.2D, V7.2D, V18.2D
    FRECPS  V2.4H, V23.4H, V6.4H
    FABS  V0.8H, V13.8H
    FRSQRTS  V21.8H, V29.8H, V0.8H
    FMOV  V6.4S, #26.00000000
    FMLA  V29.8H, V23.8H, V21.8H
    FRECPE  V7.2S, V10.2S
    FMLS  V12.2S, V0.2S, V3.2S
    FMUL  V25.4H, V16.4H, V11.4H
    FMUL H23, H7, V2.H[0x7]
    FABD  V10.4S, V3.4S, V25.4S
    FMLS H9, H6, V12.H[0x6]
    FMULX V3.4S, V17.4S, V23.S[0x1]
    FMULX  V3.4H, V9.4H, V29.4H
    FMLS V15.8H, V29.8H, V0.H[0x6]
    FMUL V18.2D, V10.2D, V10.D[0x1]
    FMLA D23, D13, V5.D[0x0]
    FDIV  V25.4H, V3.4H, V23.4H
    FABS  V3.4H, V7.4H
    FMLS  V16.4S, V26.4S, V3.4S
    FABD  V5.2S, V15.2S, V15.2S
    FMLS H21, H5, V5.H[0x6]
    FMOV  V13.4S, #0.12500000
    FABS  V0.4H, V16.4H
    FACGE  V7.2D, V18.2D, V2.2D
    FMLS S26, S13, V27.S[0x3]
    FMUL  V17.4S, V21.4S, V0.4S
    FMLS  V11.4H, V18.4H, V5.4H
    FMULX H10, H11, V11.H[0x0]
    FABS  V23.4S, V6.4S
    FMUL H6, H18, V10.H[0x6]
    FMLS  V5.4S, V17.4S, V7.4S
    FMUL S16, S23, V6.S[0x0]
    FNEG  V20.4H, V25.4H
    FMLA D18, D26, V26.D[0x1]
    FMOV  V10.2D, #-9.00000000
    FMLS  V20.4H, V5.4H, V16.4H
    FACGE  V8.8H, V17.8H, V10.8H
    FDIV  V6.4S, V8.4S, V18.4S
    FMLA  V13.4H, V28.4H, V22.4H
    FMLS S21, S7, V25.S[0x3]
    FADDP D23, V29.2D
    FMUL S7, S18, V21.S[0x3]
    FRECPE  V27.2S, V25.2S
    FRSQRTS  V26.2S, V2.2S, V10.2S
    FADDP H2, V22.2H
    FMUL V0.8H, V19.8H, V15.H[0x6]
    FADD  V8.8H, V20.8H, V13.8H
    FADDP  V19.8H, V26.8H, V6.8H
    FMLS H17, H8, V5.H[0x4]
    FMUL V11.2D, V23.2D, V24.D[0x0]
    FACGT  V11.2S, V11.2S, V17.2S
    FMUL S10, S16, V7.S[0x2]
    FMLA  V17.4S, V0.4S, V4.4S
    FMOV  V18.2D, #-3.12500000
    FMULX D22, D5, V2.D[0x0]
    FMLS S3, S26, V22.S[0x2]
    FADD  V5.8H, V31.8H, V14.8H
    FMLS V13.4S, V18.4S, V11.S[0x2]
    FMLS  V18.4S, V26.4S, V27.4S
    FRECPE  V24.2D, V3.2D
    FMLS V3.2D, V13.2D, V19.D[0x1]
    FNEG  V27.2S, V24.2S
    FMLA S23, S17, V11.S[0x1]
    FMULX S22, S10, V12.S[0x2]
    FMULX V21.8H, V30.8H, V12.H[0x0]
    FACGT  V13.2D, V24.2D, V4.2D
    FMULX  V22.8H, V18.8H, V18.8H
    FMLS  V18.8H, V14.8H, V15.8H
    FRECPS  V18.2S, V18.2S, V5.2S
    FMLS  V12.4H, V27.4H, V20.4H
    FRECPS  V15.4S, V12.4S, V21.4S
    FNEG  V2.4H, V11.4H
    FMUL V17.2S, V18.2S, V22.S[0x3]
    FMLS V11.2D, V17.2D, V13.D[0x0]
    FMOV  V5.4H, #-30.00000000
    FMLS V31.4H, V15.4H, V2.H[0x6]
    FRECPE  V15.4H, V7.4H
    FMOV  V22.2D, #-1.68750000
    FMULX H20, H22, V15.H[0x5]
    FADDP H21, V11.2H
    FMULX V30.8H, V31.8H, V7.H[0x2]
    FMUL H27, H29, V5.H[0x5]
    FMLS V12.4S, V30.4S, V1.S[0x2]
    FACGE  V31.8H, V23.8H, V23.8H
    FMLA V13.8H, V16.8H, V9.H[0x1]
    FMOV  V17.2D, #-21.00000000
    FRSQRTE  V1.4S, V13.4S
    FMOV  V23.4H, #-0.26562500
    FRSQRTE  V18.8H, V12.8H
    FADD  V6.4H, V1.4H, V23.4H
    FMLS D4, D27, V27.D[0x1]
    SUBS  X29, X29, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_6
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MRS  X2, FPSR
    MOVZ  X16, #0x1f, LSL #0
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V0.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D0
    MOVZ  X16, #0x7fff, LSL #0
    MOVK  X16, #0x7fff, LSL #16
    MOVK  X16, #0x7fff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V1.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D1
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V2.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D2
    MOVZ  X16, #0x8000, LSL #0
    MOVK  X16, #0x8000, LSL #16
    MOVK  X16, #0x8000, LSL #32
    MOVK  X16, #0x8000, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D3
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D4
    MOVZ  X16, #0x7fff, LSL #0
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D5
    MOVZ  X16, #0xcf80, LSL #0
    MOVK  X16, #0xcf80, LSL #16
    MOVK  X16, #0xcf80, LSL #32
    MOVK  X16, #0xcf80, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V6.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D6
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D7
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D8
    MOVZ  X16, #0x7fff, LSL #0
    MOVK  X16, #0x7fff, LSL #16
    MOVK  X16, #0x7fff, LSL #32
    MOVK  X16, #0x7fff, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D9
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D10
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D11
    MOVZ  X16, #0x7fff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0x7fff, LSL #32
    MOVK  X16, #0x7fff, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V12.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D12
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D13
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0x7fff, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D14
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V15.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D15
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0x7c00, LSL #32
    MOVK  X16, #0x7c00, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D16
    MOVZ  X16, #0xffe6, LSL #0
    MOVK  X16, #0x19, LSL #16
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xc035, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D17
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xc035, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X16, #0x7c00, LSL #0
    MOVK  X16, #0x7c00, LSL #16
    MOVK  X16, #0x7c00, LSL #32
    MOVK  X16, #0x7c00, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D18
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0x7f80, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D19
    MOVZ  X16, #0x7fff, LSL #0
    MOVK  X16, #0x7fff, LSL #16
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D20
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D21
    MOVZ  X16, #0x7fff, LSL #0
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xbffb, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D22
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xbffb, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D23
    MOVZ  X16, #0xb440, LSL #0
    MOVK  X16, #0xb440, LSL #16
    MOVK  X16, #0xb440, LSL #32
    MOVK  X16, #0xb440, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7ff0, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D24
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0x7fef, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D25
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D26
    MOVZ  X16, #0x7fff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0x7fff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D27
    MOVZ  X16, #0xffff, LSL #0
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D28
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0x7fff, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X16, #0x7fff, LSL #0
    MOVK  X16, #0x7fff, LSL #16
    MOVK  X16, #0x7fff, LSL #32
    MOVK  X16, #0x7fff, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D29
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V30.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D30
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, V31.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X2, D31
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
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
    FMOV  V0.D[1], X26
    FMOV  D1, X2
    FMOV  V1.D[1], X28
    FMOV  D2, X8
    FMOV  V2.D[1], X15
    FMOV  D3, X29
    FMOV  V3.D[1], X27
    FMOV  D4, X28
    FMOV  V4.D[1], X12
    FMOV  D5, X16
    FMOV  V5.D[1], X29
    FMOV  D6, X3
    FMOV  V6.D[1], X6
    FMOV  D7, X27
    FMOV  V7.D[1], X4
    FMOV  D8, X29
    FMOV  V8.D[1], X24
    FMOV  D9, X15
    FMOV  V9.D[1], X29
    FMOV  D10, X2
    FMOV  V10.D[1], X4
    FMOV  D11, X6
    FMOV  V11.D[1], X17
    FMOV  D12, X6
    FMOV  V12.D[1], X16
    FMOV  D13, X2
    FMOV  V13.D[1], X12
    FMOV  D14, X28
    FMOV  V14.D[1], X7
    FMOV  D15, X17
    FMOV  V15.D[1], X15
    FMOV  D16, X12
    FMOV  V16.D[1], X29
    FMOV  D17, X2
    FMOV  V17.D[1], X16
    FMOV  D18, X27
    FMOV  V18.D[1], X7
    FMOV  D19, X4
    FMOV  V19.D[1], X25
    FMOV  D20, X2
    FMOV  V20.D[1], X2
    FMOV  D21, X9
    FMOV  V21.D[1], X28
    FMOV  D22, X12
    FMOV  V22.D[1], X29
    FMOV  D23, X6
    FMOV  V23.D[1], X29
    FMOV  D24, X25
    FMOV  V24.D[1], X7
    FMOV  D25, X11
    FMOV  V25.D[1], X11
    FMOV  D26, X2
    FMOV  V26.D[1], X16
    FMOV  D27, X26
    FMOV  V27.D[1], X23
    FMOV  D28, X15
    FMOV  V28.D[1], X13
    FMOV  D29, X14
    FMOV  V29.D[1], X4
    FMOV  D30, X16
    FMOV  V30.D[1], X24
    FMOV  D31, X26
    FMOV  V31.D[1], X28
    MOVZ  X15, #0xa, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_7:
    FADD  V3.2D, V23.2D, V30.2D
    FMULX  V24.2S, V19.2S, V31.2S
    FRECPS  V21.2S, V23.2S, V14.2S
    FMLA H13, H28, V8.H[0x6]
    FMUL D23, D19, V29.D[0x1]
    FMOV  V8.2D, #-5.75000000
    FMUL H5, H13, V13.H[0x0]
    FMUL H3, H19, V4.H[0x4]
    FADD  V7.2D, V5.2D, V27.2D
    FMULX H18, H12, V3.H[0x5]
    FMLA D19, D31, V23.D[0x1]
    FMULX H20, H24, V7.H[0x1]
    FRSQRTE  V1.2S, V25.2S
    FMULX V27.4S, V2.4S, V19.S[0x3]
    FMLA H29, H1, V14.H[0x4]
    FMULX  V5.2S, V26.2S, V21.2S
    FRECPE  V24.2D, V23.2D
    FADD  V12.4S, V18.4S, V20.4S
    FMULX V28.2D, V8.2D, V5.D[0x1]
    FMLS H13, H24, V10.H[0x0]
    FADDP H7, V15.2H
    FSUB  V26.2S, V30.2S, V13.2S
    FMLA  V1.2D, V12.2D, V23.2D
    FMULX  V13.2D, V11.2D, V9.2D
    FRECPS  V25.4H, V7.4H, V0.4H
    FSUB  V4.2D, V16.2D, V13.2D
    FSUB  V10.8H, V28.8H, V31.8H
    FADDP  V14.2D, V10.2D, V25.2D
    FACGT  V2.4H, V8.4H, V14.4H
    FADDP  V13.4H, V31.4H, V26.4H
    FSQRT  V10.8H, V29.8H
    FRSQRTS  V11.4S, V19.4S, V2.4S
    FADDP  V16.4S, V3.4S, V10.4S
    FADDP D14, V1.2D
    FRECPS  V30.4S, V28.4S, V11.4S
    FMLA  V2.4S, V19.4S, V30.4S
    FSUB  V20.2S, V4.2S, V27.2S
    FMLA  V3.2S, V13.2S, V16.2S
    FMUL V10.2D, V20.2D, V20.D[0x1]
    FMLS V13.4H, V27.4H, V3.H[0x5]
    FMULX D29, D13, V28.D[0x1]
    FRSQRTS  V30.2S, V28.2S, V14.2S
    FRSQRTS  V11.8H, V13.8H, V3.8H
    FADDP H8, V10.2H
    FMULX H1, H11, V11.H[0x3]
    FMOV  V26.2D, #-29.00000000
    FRSQRTS  V5.8H, V29.8H, V30.8H
    FMOV  V31.2S, #23.00000000
    FMUL  V24.2S, V2.2S, V5.2S
    FMULX V4.4H, V24.4H, V1.H[0x0]
    FSQRT  V1.2D, V4.2D
    FMLA V13.4S, V7.4S, V31.S[0x3]
    FACGT  V3.4S, V1.4S, V8.4S
    FMLS D27, D13, V15.D[0x0]
    FMUL V0.2S, V26.2S, V26.S[0x2]
    FMLA S19, S0, V9.S[0x1]
    FRSQRTS  V14.8H, V22.8H, V19.8H
    FMLS  V29.2D, V27.2D, V8.2D
    FDIV  V19.2S, V31.2S, V28.2S
    FMULX H27, H3, V11.H[0x2]
    FADDP D7, V28.2D
    FMLS V31.2S, V20.2S, V19.S[0x3]
    FACGT  V22.4S, V7.4S, V17.4S
    FMULX  V1.4S, V27.4S, V31.4S
    FMLA V7.8H, V18.8H, V14.H[0x0]
    FSQRT  V18.4S, V14.4S
    FMOV  V11.2D, #-0.56250000
    FMUL V30.8H, V1.8H, V11.H[0x2]
    FRECPE  V13.8H, V18.8H
    FRECPS  V4.8H, V7.8H, V3.8H
    FABD  V15.2S, V5.2S, V30.2S
    FRECPS  V26.2S, V12.2S, V4.2S
    FRSQRTE  V17.4S, V16.4S
    FABS  V9.2D, V22.2D
    FMOV  V14.4S, #1.75000000
    FMLS  V7.2S, V22.2S, V15.2S
    FMULX  V30.4S, V5.4S, V7.4S
    FMULX V28.4H, V21.4H, V13.H[0x2]
    FMUL H3, H28, V10.H[0x6]
    FRECPE  V5.2D, V29.2D
    FABS  V25.2S, V30.2S
    FMLS V30.2S, V10.2S, V21.S[0x1]
    FADDP H22, V3.2H
    FMULX V4.2S, V7.2S, V22.S[0x2]
    FMLS V3.2D, V17.2D, V14.D[0x1]
    FMULX D18, D26, V4.D[0x1]
    FRECPS  V29.4H, V18.4H, V2.4H
    FDIV  V0.8H, V3.8H, V30.8H
    FMLA  V14.2D, V24.2D, V29.2D
    FRSQRTS  V15.4H, V0.4H, V5.4H
    FMLA V1.2D, V12.2D, V25.D[0x0]
    FMLS  V24.2D, V12.2D, V9.2D
    FMLS  V16.4S, V4.4S, V25.4S
    FRECPS  V28.8H, V1.8H, V16.8H
    FMUL V2.4H, V15.4H, V14.H[0x6]
    FMLS V21.8H, V24.8H, V2.H[0x2]
    FMLA  V12.4H, V30.4H, V30.4H
    FMLA  V2.8H, V28.8H, V17.8H
    FSUB  V22.4S, V24.4S, V9.4S
    FACGE  V1.4H, V25.4H, V30.4H
    FMULX H11, H23, V6.H[0x6]
    FADDP D30, V24.2D
    FMLA  V29.2D, V20.2D, V8.2D
    FMOV  V8.2S, #1.00000000
    FSUB  V7.2D, V1.2D, V2.2D
    FMLA V16.2D, V7.2D, V21.D[0x0]
    FMUL S20, S29, V24.S[0x0]
    FMLA  V3.2S, V8.2S, V11.2S
    FMLA V21.2S, V20.2S, V16.S[0x1]
    FADDP  V9.4S, V22.4S, V31.4S
    FACGE  V28.4S, V21.4S, V21.4S
    FABD  V29.2D, V3.2D, V3.2D
    FMUL V22.4H, V30.4H, V9.H[0x4]
    FMUL  V23.4S, V3.4S, V10.4S
    FADDP  V30.2S, V23.2S, V15.2S
    FRECPS  V20.4S, V30.4S, V28.4S
    FMLS  V14.2D, V12.2D, V22.2D
    FNEG  V10.2S, V14.2S
    FMULX  V9.8H, V28.8H, V27.8H
    FMLS H21, H10, V0.H[0x0]
    FMULX  V7.8H, V11.8H, V27.8H
    FMLS  V10.2S, V29.2S, V16.2S
    FRSQRTE  V8.2S, V21.2S
    FMULX  V16.8H, V15.8H, V16.8H
    FMLA  V23.4H, V11.4H, V7.4H
    FRECPE  V22.2S, V8.2S
    FRSQRTE  V30.4S, V16.4S
    FMLA S29, S22, V5.S[0x0]
    FMUL  V29.2S, V15.2S, V9.2S
    FMUL D25, D30, V21.D[0x1]
    FMLA D22, D10, V22.D[0x1]
    FRECPS  V5.2D, V12.2D, V22.2D
    FRSQRTE  V1.2S, V29.2S
    FMULX V21.8H, V10.8H, V5.H[0x4]
    FABD  V15.4H, V0.4H, V21.4H
    FNEG  V5.4S, V15.4S
    FACGT  V12.2S, V0.2S, V20.2S
    FABS  V28.4S, V24.4S
    FRECPE  V19.2D, V8.2D
    FADDP  V27.4H, V25.4H, V1.4H
    FABS  V3.4S, V5.4S
    FMOV  V31.8H, #4.50000000
    FMLS  V16.4H, V19.4H, V28.4H
    FMULX V12.4S, V14.4S, V3.S[0x2]
    FMUL S19, S25, V27.S[0x1]
    FADD  V23.4H, V23.4H, V31.4H
    FMULX V24.8H, V19.8H, V5.H[0x5]
    FMULX V25.8H, V7.8H, V12.H[0x0]
    FACGT  V3.4H, V23.4H, V23.4H
    FDIV  V10.2D, V0.2D, V3.2D
    FMUL  V19.2D, V25.2D, V10.2D
    FMUL V29.8H, V24.8H, V10.H[0x2]
    FMULX  V25.4S, V29.4S, V22.4S
    FADD  V15.2S, V19.2S, V25.2S
    FRECPS  V23.4H, V7.4H, V31.4H
    FSQRT  V24.8H, V25.8H
    FMUL S5, S20, V2.S[0x1]
    FMOV  V0.4S, #-0.37500000
    FMUL  V14.4H, V0.4H, V2.4H
    FMULX  V28.4H, V2.4H, V14.4H
    FACGT  V16.4S, V0.4S, V20.4S
    FMUL V20.2D, V23.2D, V18.D[0x0]
    FMUL S22, S25, V10.S[0x3]
    FMLA V25.4H, V23.4H, V6.H[0x6]
    FADDP D21, V18.2D
    FABD  V0.4H, V5.4H, V23.4H
    FNEG  V18.2S, V22.2S
    FMUL V5.2S, V18.2S, V15.S[0x2]
    FSUB  V6.4S, V31.4S, V5.4S
    FABD  V7.4H, V6.4H, V31.4H
    FMUL D22, D20, V24.D[0x1]
    FRECPE  V10.4H, V13.4H
    FNEG  V29.4S, V7.4S
    FMOV  V7.8H, #-1.37500000
    FRECPE  V23.2S, V29.2S
    FRSQRTE  V24.4S, V11.4S
    FMLS  V14.4H, V1.4H, V26.4H
    FMUL D2, D24, V19.D[0x1]
    FMLS V19.4S, V16.4S, V0.S[0x2]
    FMUL V28.2D, V25.2D, V24.D[0x0]
    FRSQRTE  V0.8H, V23.8H
    FRSQRTE  V11.2S, V22.2S
    FMUL  V31.4S, V7.4S, V11.4S
    FABD  V16.2D, V2.2D, V0.2D
    FMUL  V11.4H, V24.4H, V19.4H
    FMUL V23.2D, V16.2D, V7.D[0x1]
    FACGE  V15.2S, V23.2S, V14.2S
    FMULX V25.2D, V13.2D, V22.D[0x1]
    FRECPS  V18.4S, V11.4S, V21.4S
    FNEG  V0.2S, V10.2S
    FMLA S21, S15, V0.S[0x3]
    FMULX S7, S31, V31.S[0x2]
    FSUB  V2.4H, V21.4H, V18.4H
    FADDP  V11.2S, V2.2S, V7.2S
    FMLA H19, H28, V11.H[0x4]
    FSQRT  V7.2S, V9.2S
    FABD  V0.8H, V15.8H, V27.8H
    FMLA S31, S29, V5.S[0x1]
    FRECPS  V24.2D, V28.2D, V14.2D
    FMLS H11, H19, V3.H[0x0]
    SUBS  X15, X15, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_7
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X16, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X16, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X16, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X16, X26, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X16, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X16, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X16, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X16, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X16, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X16, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X16, X26, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X16, X26, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X16, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X16, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X16, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X16, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X16, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X16, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MRS  X26, FPSR
    MOVZ  X16, #0x1f, LSL #0
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V0.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D0
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7fff, LSL #32
    MOVK  X16, #0x7f80, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V1.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D1
    MOVZ  X16, #0x7fff, LSL #0
    MOVK  X16, #0x7fff, LSL #16
    MOVK  X16, #0x7f80, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D2
    MOVZ  X16, #0x7fff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffc0, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D3
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D4
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0x7fff, LSL #16
    MOVK  X16, #0x7fff, LSL #32
    MOVK  X16, #0x7fff, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D5
    MOVZ  X16, #0x7fff, LSL #0
    MOVK  X16, #0xffc0, LSL #16
    MOVK  X16, #0x8000, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X16, #0x4480, LSL #0
    MOVK  X16, #0x4480, LSL #16
    MOVK  X16, #0x4480, LSL #32
    MOVK  X16, #0x4480, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D6
    MOVZ  X16, #0x7fff, LSL #0
    MOVK  X16, #0xffc0, LSL #16
    MOVK  X16, #0x4480, LSL #32
    MOVK  X16, #0x4480, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D7
    MOVZ  X16, #0x498, LSL #0
    MOVK  X16, #0x1e35, LSL #16
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D8
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x60b5, LSL #16
    MOVK  X16, #0x7f80, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D9
    MOVZ  X16, #0xffff, LSL #0
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D10
    MOVZ  X16, #0x7fff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V11.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D11
    MOVZ  X16, #0x7fff, LSL #0
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D12
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X16, #0x46b4, LSL #0
    MOVK  X16, #0x38c4, LSL #16
    MOVK  X16, #0x46b4, LSL #32
    MOVK  X16, #0x38c4, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D13
    MOVZ  X16, #0x7fff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D14
    MOVZ  X16, #0x7fff, LSL #0
    MOVK  X16, #0x7fff, LSL #16
    MOVK  X16, #0x7fff, LSL #32
    MOVK  X16, #0x7f70, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D15
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X16, #0x7c00, LSL #0
    MOVK  X16, #0x7c00, LSL #16
    MOVK  X16, #0x7c00, LSL #32
    MOVK  X16, #0x7c00, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D16
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0x7fff, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x6100, LSL #16
    MOVK  X16, #0x7f80, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D17
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x6100, LSL #16
    MOVK  X16, #0x7f80, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x4000, LSL #16
    MOVK  X16, #0x4000, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D18
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffc0, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffc0, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D19
    MOVZ  X16, #0xffff, LSL #0
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X16, #0x7fff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D20
    MOVZ  X16, #0x7fff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D21
    MOVZ  X16, #0x7fff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D22
    MOVZ  X16, #0x7fff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X16, #0x8ab5, LSL #0
    MOVK  X16, #0xe4fa, LSL #16
    MOVK  X16, #0x3f3d, LSL #32
    MOVK  X16, #0xf991, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D23
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0x7fff, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x4000, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D24
    MOVZ  X16, #0x7fff, LSL #0
    MOVK  X16, #0x7fc0, LSL #16
    MOVK  X16, #0x4880, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D25
    MOVZ  X16, #0x7fff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D26
    MOVZ  X16, #0x7fff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D27
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7fff, LSL #32
    MOVK  X16, #0x7f80, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D28
    MOVZ  X16, #0x7fff, LSL #0
    MOVK  X16, #0x7fc0, LSL #16
    MOVK  X16, #0x4880, LSL #32
    MOVK  X16, #0x7fff, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #16
    MOVK  X16, #0x8000, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D29
    MOVZ  X16, #0x7fff, LSL #0
    MOVK  X16, #0xffc0, LSL #16
    MOVK  X16, #0x8000, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V30.D[1]
    MOVZ  X16, #0x7fff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0x7fff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D30
    MOVZ  X16, #0x7fff, LSL #0
    MOVK  X16, #0x7fff, LSL #16
    MOVK  X16, #0x1f84, LSL #48
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, V31.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X26, D31
    MOVZ  X16, #0x7fff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X25, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
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
    FMOV  D0, X13
    FMOV  V0.D[1], X28
    FMOV  D1, X26
    FMOV  V1.D[1], X13
    FMOV  D2, X29
    FMOV  V2.D[1], X23
    FMOV  D3, X29
    FMOV  V3.D[1], X27
    FMOV  D4, X10
    FMOV  V4.D[1], X24
    FMOV  D5, X15
    FMOV  V5.D[1], X27
    FMOV  D6, X26
    FMOV  V6.D[1], X4
    FMOV  D7, X5
    FMOV  V7.D[1], X24
    FMOV  D8, X3
    FMOV  V8.D[1], X8
    FMOV  D9, X26
    FMOV  V9.D[1], X25
    FMOV  D10, X2
    FMOV  V10.D[1], X14
    FMOV  D11, X4
    FMOV  V11.D[1], X10
    FMOV  D12, X2
    FMOV  V12.D[1], X10
    FMOV  D13, X8
    FMOV  V13.D[1], X24
    FMOV  D14, X2
    FMOV  V14.D[1], X6
    FMOV  D15, X29
    FMOV  V15.D[1], X23
    FMOV  D16, X14
    FMOV  V16.D[1], X3
    FMOV  D17, X29
    FMOV  V17.D[1], X12
    FMOV  D18, X2
    FMOV  V18.D[1], X24
    FMOV  D19, X6
    FMOV  V19.D[1], X7
    FMOV  D20, X28
    FMOV  V20.D[1], X14
    FMOV  D21, X15
    FMOV  V21.D[1], X17
    FMOV  D22, X23
    FMOV  V22.D[1], X27
    FMOV  D23, X29
    FMOV  V23.D[1], X16
    FMOV  D24, X12
    FMOV  V24.D[1], X25
    FMOV  D25, X11
    FMOV  V25.D[1], X14
    FMOV  D26, X13
    FMOV  V26.D[1], X9
    FMOV  D27, X7
    FMOV  V27.D[1], X6
    FMOV  D28, X5
    FMOV  V28.D[1], X26
    FMOV  D29, X11
    FMOV  V29.D[1], X23
    FMOV  D30, X25
    FMOV  V30.D[1], X8
    FMOV  D31, X6
    FMOV  V31.D[1], X4
    MOVZ  X29, #0xa, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_8:
    FSUB  V11.4H, V29.4H, V21.4H
    FMULX S3, S26, V19.S[0x3]
    FACGE  V5.2D, V5.2D, V3.2D
    FMUL D6, D25, V5.D[0x0]
    FMLS V5.2D, V23.2D, V24.D[0x1]
    FABD  V23.4S, V22.4S, V3.4S
    FMULX D27, D27, V23.D[0x0]
    FMUL  V18.2S, V11.2S, V27.2S
    FRSQRTS  V17.8H, V28.8H, V6.8H
    FACGT  V24.2D, V17.2D, V17.2D
    FRECPS  V31.2S, V31.2S, V24.2S
    FMLS V17.2S, V21.2S, V31.S[0x2]
    FABS  V26.4S, V30.4S
    FMULX  V21.8H, V10.8H, V5.8H
    FMLS S27, S26, V24.S[0x3]
    FDIV  V6.4H, V21.4H, V31.4H
    FMLA D4, D6, V23.D[0x0]
    FABS  V30.2D, V24.2D
    FMOV  V25.4S, #-0.78125000
    FMLA V3.2D, V17.2D, V17.D[0x1]
    FMLS H11, H6, V3.H[0x3]
    FMULX V5.2S, V11.2S, V30.S[0x0]
    FABD  V19.2D, V24.2D, V0.2D
    FADDP  V30.8H, V27.8H, V4.8H
    FSUB  V17.2D, V6.2D, V19.2D
    FABS  V21.4S, V30.4S
    FABS  V31.8H, V5.8H
    FDIV  V5.2D, V31.2D, V25.2D
    FRSQRTS  V4.2D, V22.2D, V27.2D
    FMLS D6, D19, V21.D[0x1]
    FRSQRTE  V30.2D, V4.2D
    FMUL D22, D30, V5.D[0x1]
    FMLA  V3.2S, V6.2S, V18.2S
    FRECPE  V23.8H, V26.8H
    FRECPE  V25.4S, V31.4S
    FADD  V0.8H, V22.8H, V5.8H
    FABD  V27.8H, V3.8H, V25.8H
    FMULX V6.4S, V23.4S, V2.S[0x3]
    FMULX  V2.4S, V21.4S, V0.4S
    FSQRT  V21.4H, V30.4H
    FMLS H11, H27, V6.H[0x1]
    FRSQRTE  V3.4H, V11.4H
    FMLS V19.4H, V17.4H, V2.H[0x1]
    FMULX D4, D11, V4.D[0x1]
    FADDP D6, V12.2D
    FMLS  V22.2D, V21.2D, V19.2D
    FMLS V21.2D, V17.2D, V6.D[0x0]
    FMUL V31.8H, V18.8H, V7.H[0x6]
    FADDP  V7.4H, V4.4H, V16.4H
    FMULX D27, D31, V9.D[0x1]
    FMULX  V23.4H, V3.4H, V25.4H
    FRECPE  V0.4S, V27.4S
    FMULX S26, S13, V22.S[0x3]
    FNEG  V23.2S, V0.2S
    FMUL S2, S8, V23.S[0x2]
    FABD  V11.4H, V2.4H, V17.4H
    FACGT  V12.8H, V26.8H, V0.8H
    FABS  V18.2D, V7.2D
    FMUL V17.4H, V11.4H, V13.H[0x2]
    FACGT  V9.2S, V17.2S, V17.2S
    FADDP S2, V13.2S
    FACGT  V23.2D, V14.2D, V9.2D
    FSUB  V27.4S, V18.4S, V21.4S
    FMLS V19.2D, V27.2D, V23.D[0x1]
    FRECPS  V11.4H, V12.4H, V15.4H
    FRSQRTE  V0.8H, V4.8H
    FRSQRTS  V7.2D, V11.2D, V0.2D
    FMULX V26.2D, V2.2D, V19.D[0x1]
    FACGE  V14.2D, V31.2D, V14.2D
    FMULX  V4.4H, V27.4H, V27.4H
    FMUL D27, D23, V8.D[0x0]
    FADD  V27.8H, V8.8H, V29.8H
    FSUB  V17.8H, V16.8H, V0.8H
    FABD  V31.8H, V13.8H, V7.8H
    FMOV  V15.2D, #0.13281250
    FNEG  V11.8H, V23.8H
    FADDP S1, V15.2S
    FMULX  V0.2S, V27.2S, V21.2S
    FMLS S29, S15, V1.S[0x0]
    FMUL V12.2D, V22.2D, V19.D[0x0]
    FRECPS  V22.2D, V7.2D, V17.2D
    FNEG  V8.4H, V14.4H
    FACGT  V2.8H, V11.8H, V26.8H
    FSQRT  V1.4S, V22.4S
    FMULX V15.2S, V29.2S, V4.S[0x0]
    FACGE  V26.4H, V25.4H, V31.4H
    FMULX V22.4S, V2.4S, V25.S[0x1]
    FMLA D14, D12, V8.D[0x0]
    FABD  V31.8H, V18.8H, V15.8H
    FACGE  V7.8H, V14.8H, V26.8H
    FABD  V11.8H, V7.8H, V31.8H
    FMOV  V2.2S, #0.78125000
    FSQRT  V18.4H, V22.4H
    FMLS S11, S18, V18.S[0x3]
    FMUL V22.4S, V26.4S, V2.S[0x0]
    FMLA V29.8H, V27.8H, V8.H[0x6]
    FNEG  V21.2D, V9.2D
    FABS  V4.4S, V14.4S
    FRECPS  V4.4H, V10.4H, V4.4H
    FMLS V29.2S, V4.2S, V0.S[0x3]
    FMLA V17.4S, V30.4S, V23.S[0x0]
    FMULX  V23.2D, V26.2D, V17.2D
    FMOV  V30.2S, #1.06250000
    FMLS  V7.8H, V27.8H, V16.8H
    FMLS  V28.8H, V30.8H, V30.8H
    FADDP S4, V28.2S
    FMLS D12, D21, V7.D[0x1]
    FSUB  V10.8H, V24.8H, V12.8H
    FMLA V8.2S, V25.2S, V9.S[0x1]
    FRECPS  V0.4S, V8.4S, V10.4S
    FRSQRTS  V13.8H, V9.8H, V1.8H
    FADDP  V15.8H, V19.8H, V21.8H
    FACGT  V14.2S, V23.2S, V13.2S
    FMULX H23, H4, V14.H[0x4]
    FMLA  V2.4H, V8.4H, V24.4H
    FADDP D7, V7.2D
    FADD  V18.4H, V12.4H, V20.4H
    FMLS V30.8H, V0.8H, V15.H[0x0]
    FSUB  V20.4H, V14.4H, V29.4H
    FMOV  V4.4H, #-14.00000000
    FADDP D16, V18.2D
    FMUL V10.2S, V4.2S, V7.S[0x3]
    FMULX  V13.4S, V10.4S, V3.4S
    FADDP  V19.2S, V20.2S, V9.2S
    FMULX V12.4S, V2.4S, V22.S[0x1]
    FABD  V28.2D, V19.2D, V16.2D
    FABS  V24.8H, V4.8H
    FMUL  V7.8H, V23.8H, V28.8H
    FRSQRTS  V22.8H, V12.8H, V30.8H
    FADDP  V1.8H, V3.8H, V16.8H
    FSQRT  V0.2S, V24.2S
    FMLA H6, H7, V15.H[0x3]
    FMUL  V20.8H, V0.8H, V28.8H
    FMULX  V3.4H, V19.4H, V13.4H
    FMUL H30, H19, V0.H[0x2]
    FADDP  V19.4H, V2.4H, V20.4H
    FMLA V30.2D, V1.2D, V22.D[0x1]
    FACGT  V10.8H, V10.8H, V3.8H
    FMLS V1.4H, V6.4H, V3.H[0x6]
    FMULX  V23.8H, V8.8H, V19.8H
    FNEG  V20.4H, V10.4H
    FMOV  V2.8H, #-5.00000000
    FMLS V3.2D, V9.2D, V1.D[0x1]
    FADDP D15, V13.2D
    FDIV  V7.2D, V22.2D, V2.2D
    FMLA V10.4H, V7.4H, V3.H[0x3]
    FMLA V13.2D, V30.2D, V11.D[0x1]
    FRSQRTE  V8.8H, V31.8H
    FRECPS  V1.2S, V26.2S, V1.2S
    FMUL H30, H10, V1.H[0x2]
    FMULX S12, S28, V4.S[0x2]
    FADDP H31, V18.2H
    FMLS  V28.4S, V23.4S, V5.4S
    FSUB  V10.4H, V31.4H, V6.4H
    FMLA V0.2D, V30.2D, V17.D[0x0]
    FACGE  V23.2S, V13.2S, V10.2S
    FADD  V4.4S, V12.4S, V11.4S
    FMULX  V1.4H, V4.4H, V0.4H
    FMLA D5, D20, V28.D[0x1]
    FMLS S6, S11, V6.S[0x0]
    FADDP D30, V1.2D
    FMLS  V26.8H, V6.8H, V25.8H
    FMLA V7.4H, V15.4H, V15.H[0x1]
    FACGE  V22.4H, V3.4H, V7.4H
    FMLA V10.2D, V31.2D, V3.D[0x0]
    FADDP S7, V23.2S
    FRSQRTE  V28.4S, V10.4S
    FMOV  V10.4S, #-1.81250000
    FMLS V17.2S, V30.2S, V22.S[0x1]
    FRSQRTE  V4.4H, V5.4H
    FMOV  V1.4S, #-0.87500000
    FMULX V18.4S, V13.4S, V5.S[0x3]
    FMULX D1, D12, V23.D[0x1]
    FMLS V3.2S, V19.2S, V17.S[0x0]
    FSQRT  V7.4S, V16.4S
    FADDP  V13.4S, V6.4S, V11.4S
    FMUL V30.8H, V4.8H, V10.H[0x4]
    FACGT  V0.4H, V30.4H, V26.4H
    FMOV  V7.2S, #0.68750000
    FMLA  V17.4H, V28.4H, V0.4H
    FMLA S31, S17, V7.S[0x0]
    FMLA H16, H18, V1.H[0x3]
    FADD  V28.4S, V23.4S, V31.4S
    FMLA  V4.4S, V10.4S, V28.4S
    FMLS  V26.8H, V13.8H, V13.8H
    FDIV  V1.4S, V26.4S, V3.4S
    FMUL  V7.2S, V31.2S, V20.2S
    FMULX D20, D11, V16.D[0x0]
    FABD  V9.4H, V20.4H, V20.4H
    FDIV  V17.4H, V30.4H, V9.4H
    FMULX V6.2D, V27.2D, V4.D[0x1]
    FRSQRTS  V16.4S, V16.4S, V6.4S
    FACGE  V11.4H, V7.4H, V1.4H
    FMUL  V19.2S, V16.2S, V11.2S
    FADDP S22, V11.2S
    FRECPE  V5.4H, V27.4H
    FADDP  V9.8H, V24.8H, V11.8H
    FRSQRTS  V11.8H, V2.8H, V21.8H
    FMLS V16.4S, V28.4S, V30.S[0x2]
    FMLA H13, H28, V7.H[0x7]
    SUBS  X29, X29, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_8
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X28, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X28, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X28, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X28, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X28, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X28, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X28, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X28, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X28, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X28, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X28, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X28, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X28, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X28, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X28, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X28, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X28, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X28, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MRS  X16, FPSR
    MOVZ  X28, #0x1f, LSL #0
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D0
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0x7fc0, LSL #16
    MOVK  X28, #0x7f80, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D1
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0x7fff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X28, #0xc500, LSL #0
    MOVK  X28, #0xc500, LSL #16
    MOVK  X28, #0xc500, LSL #32
    MOVK  X28, #0xc500, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D2
    MOVZ  X28, #0xc500, LSL #0
    MOVK  X28, #0xc500, LSL #16
    MOVK  X28, #0xc500, LSL #32
    MOVK  X28, #0xc500, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D3
    MOVZ  X28, #0x7fff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D4
    MOVZ  X28, #0x7fff, LSL #0
    MOVK  X28, #0x7fff, LSL #16
    MOVK  X28, #0x7c00, LSL #32
    MOVK  X28, #0xfc00, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D5
    MOVZ  X28, #0x7fff, LSL #0
    MOVK  X28, #0x7fff, LSL #16
    MOVK  X28, #0x7fff, LSL #32
    MOVK  X28, #0x7fff, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D6
    MOVZ  X28, #0x7fff, LSL #0
    MOVK  X28, #0x7fff, LSL #16
    MOVK  X28, #0x7fff, LSL #32
    MOVK  X28, #0x7fff, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D7
    MOVZ  X28, #0x7fff, LSL #0
    MOVK  X28, #0x7fff, LSL #16
    MOVK  X28, #0x8000, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X28, #0x7c00, LSL #0
    MOVK  X28, #0x7c00, LSL #16
    MOVK  X28, #0x7c00, LSL #32
    MOVK  X28, #0x7c00, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D8
    MOVZ  X28, #0x7fff, LSL #0
    MOVK  X28, #0x7fff, LSL #16
    MOVK  X28, #0x7fff, LSL #32
    MOVK  X28, #0x7fff, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D9
    MOVZ  X28, #0x4f00, LSL #0
    MOVK  X28, #0x4f00, LSL #16
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xbfe8, LSL #16
    MOVK  X28, #0xbfe8, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D10
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xbfe8, LSL #16
    MOVK  X28, #0xbfe8, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X28, #0x3e00, LSL #0
    MOVK  X28, #0x3e00, LSL #16
    MOVK  X28, #0x3e00, LSL #32
    MOVK  X28, #0x3e00, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D11
    MOVZ  X28, #0x3e00, LSL #0
    MOVK  X28, #0x3e00, LSL #16
    MOVK  X28, #0x3e00, LSL #32
    MOVK  X28, #0x3e00, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D12
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0x7fff, LSL #16
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D13
    MOVZ  X28, #0x7fff, LSL #0
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D14
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D15
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x8000, LSL #16
    MOVK  X28, #0x8000, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x3fc0, LSL #16
    MOVK  X28, #0x3fc0, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D16
    MOVZ  X28, #0x7fff, LSL #0
    MOVK  X28, #0x7fff, LSL #16
    MOVK  X28, #0x7fff, LSL #32
    MOVK  X28, #0x7fff, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D17
    MOVZ  X28, #0x7e00, LSL #0
    MOVK  X28, #0x7e00, LSL #16
    MOVK  X28, #0x7e00, LSL #32
    MOVK  X28, #0x7e00, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D18
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D19
    MOVZ  X28, #0x7fff, LSL #0
    MOVK  X28, #0x7fff, LSL #16
    MOVK  X28, #0x7fff, LSL #32
    MOVK  X28, #0x7fff, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D20
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x8000, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D21
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x8000, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D22
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D23
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D24
    MOVZ  X28, #0x4b00, LSL #0
    MOVK  X28, #0x4b00, LSL #16
    MOVK  X28, #0x4b00, LSL #32
    MOVK  X28, #0x4b00, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x7f80, LSL #16
    MOVK  X28, #0x7f80, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D25
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x7f80, LSL #16
    MOVK  X28, #0x7f80, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0x7f80, LSL #16
    MOVK  X28, #0x7f80, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D26
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0x7fff, LSL #16
    MOVK  X28, #0x7f80, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X28, #0x7c00, LSL #0
    MOVK  X28, #0x7c00, LSL #16
    MOVK  X28, #0x7c00, LSL #32
    MOVK  X28, #0x7c00, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D27
    MOVZ  X28, #0x7fff, LSL #0
    MOVK  X28, #0x7fff, LSL #16
    MOVK  X28, #0x7fff, LSL #32
    MOVK  X28, #0x7fff, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D28
    MOVZ  X28, #0x7fff, LSL #0
    MOVK  X28, #0x7fff, LSL #16
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D29
    MOVZ  X28, #0x7fff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0x7fff, LSL #32
    MOVK  X28, #0x7fff, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D30
    MOVZ  X28, #0x7e00, LSL #0
    MOVK  X28, #0x7e00, LSL #16
    MOVK  X28, #0x7e00, LSL #32
    MOVK  X28, #0x7e00, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X16, D31
    MOVZ  X28, #0x7fff, LSL #0
    MOVK  X28, #0x7fff, LSL #16
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
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
    FMOV  D0, X25
    FMOV  V0.D[1], X7
    FMOV  D1, X26
    FMOV  V1.D[1], X27
    FMOV  D2, X6
    FMOV  V2.D[1], X29
    FMOV  D3, X4
    FMOV  V3.D[1], X17
    FMOV  D4, X28
    FMOV  V4.D[1], X28
    FMOV  D5, X23
    FMOV  V5.D[1], X25
    FMOV  D6, X10
    FMOV  V6.D[1], X15
    FMOV  D7, X23
    FMOV  V7.D[1], X6
    FMOV  D8, X4
    FMOV  V8.D[1], X23
    FMOV  D9, X25
    FMOV  V9.D[1], X4
    FMOV  D10, X2
    FMOV  V10.D[1], X7
    FMOV  D11, X8
    FMOV  V11.D[1], X7
    FMOV  D12, X23
    FMOV  V12.D[1], X14
    FMOV  D13, X5
    FMOV  V13.D[1], X16
    FMOV  D14, X8
    FMOV  V14.D[1], X9
    FMOV  D15, X14
    FMOV  V15.D[1], X14
    FMOV  D16, X27
    FMOV  V16.D[1], X27
    FMOV  D17, X3
    FMOV  V17.D[1], X13
    FMOV  D18, X2
    FMOV  V18.D[1], X29
    FMOV  D19, X12
    FMOV  V19.D[1], X7
    FMOV  D20, X12
    FMOV  V20.D[1], X13
    FMOV  D21, X4
    FMOV  V21.D[1], X2
    FMOV  D22, X13
    FMOV  V22.D[1], X6
    FMOV  D23, X26
    FMOV  V23.D[1], X7
    FMOV  D24, X13
    FMOV  V24.D[1], X27
    FMOV  D25, X29
    FMOV  V25.D[1], X11
    FMOV  D26, X25
    FMOV  V26.D[1], X15
    FMOV  D27, X23
    FMOV  V27.D[1], X17
    FMOV  D28, X4
    FMOV  V28.D[1], X23
    FMOV  D29, X26
    FMOV  V29.D[1], X29
    FMOV  D30, X26
    FMOV  V30.D[1], X6
    FMOV  D31, X8
    FMOV  V31.D[1], X11
    MOVZ  X14, #0xa, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_9:
    FMLA  V2.4H, V30.4H, V1.4H
    FMLS V1.8H, V20.8H, V2.H[0x4]
    FMLA  V9.2S, V27.2S, V9.2S
    FMOV  V31.2S, #-0.62500000
    FABS  V7.4H, V9.4H
    FABD  V18.2S, V19.2S, V29.2S
    FMUL V17.8H, V1.8H, V11.H[0x0]
    FMLA S7, S7, V26.S[0x2]
    FABS  V7.2D, V4.2D
    FMLS V21.2D, V18.2D, V5.D[0x1]
    FMUL V16.8H, V17.8H, V3.H[0x7]
    FNEG  V17.4S, V28.4S
    FMULX V18.4S, V7.4S, V21.S[0x0]
    FADDP S2, V16.2S
    FACGE  V22.4H, V18.4H, V16.4H
    FABS  V7.4H, V9.4H
    FMOV  V29.2D, #0.87500000
    FACGT  V18.8H, V2.8H, V21.8H
    FMLA  V7.2D, V22.2D, V7.2D
    FMLS H2, H7, V10.H[0x3]
    FMOV  V19.8H, #-0.93750000
    FSQRT  V9.8H, V31.8H
    FNEG  V30.4S, V29.4S
    FMOV  V19.2D, #0.12500000
    FMULX D4, D19, V30.D[0x0]
    FMULX S0, S9, V19.S[0x1]
    FMUL V7.2S, V18.2S, V24.S[0x0]
    FACGE  V1.2D, V18.2D, V13.2D
    FMLS V28.2D, V18.2D, V17.D[0x0]
    FDIV  V30.4H, V19.4H, V2.4H
    FRECPS  V31.8H, V1.8H, V0.8H
    FMUL H20, H27, V4.H[0x1]
    FMUL  V2.4H, V30.4H, V31.4H
    FMUL H0, H25, V2.H[0x5]
    FMLA  V24.4S, V28.4S, V22.4S
    FDIV  V29.2D, V24.2D, V20.2D
    FACGE  V1.4H, V7.4H, V0.4H
    FMLS V0.2D, V21.2D, V6.D[0x1]
    FMUL V2.4H, V23.4H, V6.H[0x7]
    FMLS S16, S0, V10.S[0x0]
    FRECPS  V21.4S, V4.4S, V22.4S
    FADDP H20, V28.2H
    FMULX H13, H18, V8.H[0x3]
    FMUL V25.2D, V11.2D, V21.D[0x1]
    FMUL V9.2S, V1.2S, V16.S[0x1]
    FNEG  V15.4S, V1.4S
    FMULX V10.2D, V25.2D, V31.D[0x1]
    FRSQRTS  V4.4S, V26.4S, V28.4S
    FABS  V21.4H, V20.4H
    FADDP S30, V17.2S
    FMUL V8.2D, V4.2D, V4.D[0x0]
    FADD  V27.4S, V13.4S, V14.4S
    FACGE  V7.2S, V14.2S, V20.2S
    FMULX V31.8H, V27.8H, V10.H[0x1]
    FMLS  V17.8H, V31.8H, V30.8H
    FSQRT  V28.8H, V17.8H
    FABS  V22.4S, V21.4S
    FNEG  V11.4H, V7.4H
    FRECPS  V13.4H, V2.4H, V6.4H
    FRSQRTE  V10.2S, V9.2S
    FMUL V6.2S, V29.2S, V29.S[0x1]
    FNEG  V24.2S, V6.2S
    FNEG  V4.4H, V24.4H
    FMLS H11, H10, V15.H[0x2]
    FMLA H1, H12, V1.H[0x5]
    FMUL  V15.8H, V8.8H, V28.8H
    FMLA  V25.4S, V11.4S, V13.4S
    FRECPE  V26.4H, V15.4H
    FSUB  V0.4H, V1.4H, V4.4H
    FMOV  V7.8H, #-2.25000000
    FMLS  V20.4S, V26.4S, V24.4S
    FMOV  V1.4S, #28.00000000
    FMUL D14, D20, V1.D[0x0]
    FMLA V29.8H, V22.8H, V12.H[0x0]
    FRECPS  V24.4H, V9.4H, V21.4H
    FADDP  V9.4H, V29.4H, V7.4H
    FACGT  V29.2D, V24.2D, V21.2D
    FRECPS  V15.8H, V25.8H, V1.8H
    FMUL V8.2D, V18.2D, V28.D[0x1]
    FRSQRTE  V7.2D, V0.2D
    FABD  V18.8H, V15.8H, V8.8H
    FABS  V31.4H, V29.4H
    FMULX S20, S12, V31.S[0x3]
    FMLA V12.2D, V18.2D, V14.D[0x1]
    FABS  V11.2S, V29.2S
    FRECPS  V28.2S, V5.2S, V21.2S
    FMLA  V18.2D, V24.2D, V6.2D
    FMOV  V4.4S, #-0.23437500
    FMUL D24, D8, V5.D[0x1]
    FACGT  V31.8H, V12.8H, V8.8H
    FMLA S12, S20, V28.S[0x1]
    FMLS  V20.8H, V4.8H, V31.8H
    FMULX  V0.2D, V24.2D, V9.2D
    FADDP D14, V11.2D
    FMLA V29.2S, V18.2S, V13.S[0x2]
    FRSQRTE  V4.4H, V7.4H
    FMULX  V7.4H, V28.4H, V12.4H
    FSUB  V9.4H, V13.4H, V26.4H
    FABD  V18.2S, V9.2S, V7.2S
    FABS  V5.4H, V18.4H
    FRECPS  V13.4S, V20.4S, V15.4S
    FMUL  V31.4H, V29.4H, V0.4H
    FRSQRTE  V28.8H, V12.8H
    FRECPS  V9.4H, V20.4H, V15.4H
    FMUL V1.8H, V4.8H, V4.H[0x7]
    FMLA D21, D1, V9.D[0x1]
    FADDP S18, V23.2S
    FADDP S7, V18.2S
    FRECPS  V12.4H, V14.4H, V31.4H
    FMLS V11.2D, V13.2D, V21.D[0x1]
    FRECPS  V5.4S, V11.4S, V12.4S
    FMUL  V12.4H, V24.4H, V24.4H
    FRSQRTS  V29.4H, V7.4H, V19.4H
    FRECPS  V24.2S, V29.2S, V28.2S
    FADDP S28, V12.2S
    FDIV  V21.4H, V5.4H, V9.4H
    FDIV  V31.2S, V21.2S, V21.2S
    FADDP  V14.4S, V6.4S, V31.4S
    FMLA H6, H28, V14.H[0x4]
    FMLS V23.2S, V20.2S, V8.S[0x2]
    FNEG  V31.4S, V20.4S
    FMLS V20.4S, V13.4S, V16.S[0x2]
    FMLA V0.2D, V12.2D, V16.D[0x0]
    FRSQRTE  V12.4H, V29.4H
    FMULX V16.8H, V29.8H, V4.H[0x0]
    FACGE  V8.2D, V15.2D, V9.2D
    FSQRT  V5.2D, V0.2D
    FMUL D13, D23, V8.D[0x0]
    FMUL H18, H12, V3.H[0x6]
    FRSQRTS  V9.4H, V16.4H, V5.4H
    FMUL  V19.8H, V18.8H, V9.8H
    FNEG  V0.8H, V24.8H
    FADDP S21, V22.2S
    FMULX  V12.2S, V13.2S, V21.2S
    FMLS H14, H13, V6.H[0x0]
    FADD  V8.8H, V20.8H, V13.8H
    FMUL V20.2D, V11.2D, V0.D[0x1]
    FMOV  V9.8H, #-23.00000000
    FADDP  V5.4S, V3.4S, V12.4S
    FACGE  V18.8H, V5.8H, V8.8H
    FMULX  V5.2S, V31.2S, V31.2S
    FMLA  V15.2S, V18.2S, V8.2S
    FACGE  V29.2D, V22.2D, V15.2D
    FABD  V15.8H, V28.8H, V22.8H
    FDIV  V22.2D, V15.2D, V20.2D
    FMLS D16, D5, V1.D[0x0]
    FMUL  V15.4H, V9.4H, V22.4H
    FMLA V22.2D, V15.2D, V16.D[0x1]
    FRSQRTS  V20.4H, V24.4H, V22.4H
    FMUL  V28.2D, V29.2D, V20.2D
    FMULX D11, D27, V31.D[0x1]
    FMLA  V20.8H, V26.8H, V19.8H
    FRECPE  V1.2D, V14.2D
    FRSQRTS  V8.4S, V15.4S, V14.4S
    FACGT  V13.2S, V8.2S, V8.2S
    FMLS  V5.4H, V1.4H, V28.4H
    FMUL H10, H13, V11.H[0x5]
    FMLS D3, D10, V20.D[0x0]
    FRSQRTE  V28.4S, V18.4S
    FMLA V31.4H, V15.4H, V14.H[0x6]
    FADD  V14.2D, V24.2D, V25.2D
    FSUB  V16.4S, V8.4S, V7.4S
    FSUB  V29.2S, V6.2S, V4.2S
    FMULX V19.2S, V25.2S, V7.S[0x2]
    FMULX H7, H30, V1.H[0x0]
    FACGT  V24.4H, V29.4H, V4.4H
    FRSQRTE  V11.4S, V7.4S
    FADDP  V20.4H, V26.4H, V12.4H
    FMULX H4, H31, V14.H[0x7]
    FMLA V30.2D, V3.2D, V9.D[0x0]
    FRSQRTE  V7.2D, V21.2D
    FACGT  V8.8H, V27.8H, V7.8H
    FMLA H14, H22, V5.H[0x5]
    FADDP  V13.4S, V24.4S, V4.4S
    FMULX  V31.4H, V30.4H, V8.4H
    FMOV  V15.8H, #0.23437500
    FMLS H13, H11, V14.H[0x3]
    FMLS S6, S19, V25.S[0x1]
    FNEG  V4.8H, V6.8H
    FMLA  V25.2D, V20.2D, V31.2D
    FMLA V30.8H, V7.8H, V5.H[0x4]
    FMLA D6, D29, V16.D[0x0]
    FMLS V18.2S, V15.2S, V30.S[0x3]
    FMUL  V8.2D, V4.2D, V14.2D
    FADDP H9, V6.2H
    FRSQRTS  V30.2S, V6.2S, V13.2S
    FRSQRTS  V19.2S, V30.2S, V30.2S
    FMOV  V5.2S, #2.00000000
    FMLA V20.2D, V25.2D, V25.D[0x0]
    FMLA V25.4S, V30.4S, V18.S[0x2]
    FMUL S14, S1, V5.S[0x3]
    FMULX V4.2D, V5.2D, V19.D[0x1]
    FSUB  V10.8H, V16.8H, V9.8H
    FADD  V31.2D, V4.2D, V4.2D
    FMUL V26.4S, V5.4S, V10.S[0x1]
    FADD  V21.4H, V31.4H, V19.4H
    FSUB  V18.8H, V20.8H, V5.8H
    FMLA S20, S6, V18.S[0x2]
    FABS  V4.4H, V21.4H
    FADD  V18.4S, V22.4S, V2.4S
    SUBS  X14, X14, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_9
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X10, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MRS  X23, FPSR
    MOVZ  X10, #0x1f, LSL #0
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V0.D[1]
    MOVZ  X10, #0x8000, LSL #0
    MOVK  X10, #0x8000, LSL #16
    MOVK  X10, #0x8000, LSL #32
    MOVK  X10, #0x8000, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D0
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0x3a3c, LSL #32
    MOVK  X10, #0x7a80, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V1.D[1]
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7ff0, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D1
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0x7fef, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D2
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0x7fff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0x7fff, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D3
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0x7e80, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D4
    MOVZ  X10, #0x7fff, LSL #0
    MOVK  X10, #0x7fff, LSL #16
    MOVK  X10, #0x7ff8, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D5
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x4000, LSL #16
    MOVK  X10, #0x4000, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D6
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0x7fff, LSL #16
    MOVK  X10, #0x8000, LSL #32
    MOVK  X10, #0x7ff8, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7ff0, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D7
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xa000, LSL #32
    MOVK  X10, #0x6106, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x8000, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D8
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x8000, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D9
    MOVZ  X10, #0xffff, LSL #0
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x3fc0, LSL #16
    MOVK  X10, #0x3fc0, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D10
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0x7fff, LSL #16
    MOVK  X10, #0x8000, LSL #32
    MOVK  X10, #0x7ff0, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7f80, LSL #16
    MOVK  X10, #0x7f80, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D11
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x60b5, LSL #16
    MOVK  X10, #0x7f80, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D12
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0x7fff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0x7fff, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D13
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D14
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X10, #0x3380, LSL #0
    MOVK  X10, #0x3380, LSL #16
    MOVK  X10, #0x3380, LSL #32
    MOVK  X10, #0x3380, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D15
    MOVZ  X10, #0x3380, LSL #0
    MOVK  X10, #0x3380, LSL #16
    MOVK  X10, #0x3380, LSL #32
    MOVK  X10, #0x3380, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x3fc0, LSL #16
    MOVK  X10, #0x3fc0, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D16
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0x7fff, LSL #16
    MOVK  X10, #0x8000, LSL #32
    MOVK  X10, #0x7ff0, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xff80, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xff80, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D17
    MOVZ  X10, #0x7fff, LSL #0
    MOVK  X10, #0xff80, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xff80, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7ff8, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D18
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0x7fff, LSL #16
    MOVK  X10, #0x8000, LSL #32
    MOVK  X10, #0xfff8, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D19
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0x7fff, LSL #16
    MOVK  X10, #0x8000, LSL #32
    MOVK  X10, #0x7ff8, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D20
    MOVZ  X10, #0x7fff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D21
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0x7fff, LSL #16
    MOVK  X10, #0x7ff8, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7ff8, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D22
    MOVZ  X10, #0x8000, LSL #0
    MOVK  X10, #0x8000, LSL #16
    MOVK  X10, #0x8000, LSL #32
    MOVK  X10, #0xfff8, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V23.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D23
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0x7fff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0x7fff, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D24
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X10, #0x1fe, LSL #0
    MOVK  X10, #0xbf80, LSL #16
    MOVK  X10, #0x7fd0, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D25
    MOVZ  X10, #0x7fff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X10, #0x8000, LSL #0
    MOVK  X10, #0x7ff0, LSL #16
    MOVK  X10, #0x8000, LSL #32
    MOVK  X10, #0x7ff0, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D26
    MOVZ  X10, #0x8000, LSL #0
    MOVK  X10, #0x7ff0, LSL #16
    MOVK  X10, #0x8000, LSL #32
    MOVK  X10, #0x7ff0, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D27
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7f80, LSL #16
    MOVK  X10, #0x7f80, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D28
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7f80, LSL #16
    MOVK  X10, #0x7f80, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D29
    MOVZ  X10, #0x7bff, LSL #0
    MOVK  X10, #0xfc00, LSL #16
    MOVK  X10, #0x49a4, LSL #32
    MOVK  X10, #0xc9ac, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V30.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D30
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0x8000, LSL #32
    MOVK  X10, #0xfff8, LSL #48
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V31.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D31
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0xa4b0, LSL #0
    MOVK  X2, #0x497c, LSL #16
    MOVK  X2, #0x9dd9, LSL #32
    MOVK  X2, #0xb52e, LSL #48
    MOVZ  X3, #0xaf4c, LSL #0
    MOVK  X3, #0xe6ff, LSL #16
    MOVK  X3, #0x2e9e, LSL #32
    MOVK  X3, #0x1cd8, LSL #48
    MOVZ  X4, #0x5f3b, LSL #0
    MOVK  X4, #0x337e, LSL #16
    MOVK  X4, #0x5983, LSL #32
    MOVK  X4, #0x7c97, LSL #48
    MOVZ  X5, #0xe2aa, LSL #0
    MOVK  X5, #0xa766, LSL #16
    MOVK  X5, #0x8bab, LSL #32
    MOVK  X5, #0xaec9, LSL #48
    MOVZ  X6, #0xc63b, LSL #0
    MOVK  X6, #0x9c8e, LSL #16
    MOVK  X6, #0xfed7, LSL #32
    MOVK  X6, #0xec5, LSL #48
    MOVZ  X7, #0xc279, LSL #0
    MOVK  X7, #0xf957, LSL #16
    MOVK  X7, #0x6779, LSL #32
    MOVK  X7, #0xe001, LSL #48
    MOVZ  X8, #0x4850, LSL #0
    MOVK  X8, #0x4416, LSL #16
    MOVK  X8, #0xe11f, LSL #32
    MOVK  X8, #0x92b1, LSL #48
    MOVZ  X9, #0x2d74, LSL #0
    MOVK  X9, #0xa167, LSL #16
    MOVK  X9, #0x6299, LSL #32
    MOVK  X9, #0x37d8, LSL #48
    MOVZ  X10, #0x5ec3, LSL #0
    MOVK  X10, #0x7c02, LSL #16
    MOVK  X10, #0xf656, LSL #32
    MOVK  X10, #0xad78, LSL #48
    MOVZ  X11, #0xc7c0, LSL #0
    MOVK  X11, #0xb983, LSL #16
    MOVK  X11, #0x7a88, LSL #32
    MOVK  X11, #0xcdc7, LSL #48
    MOVZ  X12, #0xd78f, LSL #0
    MOVK  X12, #0xbb89, LSL #16
    MOVK  X12, #0x53db, LSL #32
    MOVK  X12, #0x2437, LSL #48
    MOVZ  X13, #0x527a, LSL #0
    MOVK  X13, #0x7d, LSL #16
    MOVK  X13, #0x5691, LSL #32
    MOVK  X13, #0x2038, LSL #48
    MOVZ  X14, #0x79ec, LSL #0
    MOVK  X14, #0x2fdb, LSL #16
    MOVK  X14, #0x6b4c, LSL #32
    MOVK  X14, #0xc2d0, LSL #48
    MOVZ  X15, #0x9704, LSL #0
    MOVK  X15, #0x79ec, LSL #16
    MOVK  X15, #0x87fb, LSL #32
    MOVK  X15, #0xcb3, LSL #48
    MOVZ  X16, #0x331c, LSL #0
    MOVK  X16, #0xbdb2, LSL #16
    MOVK  X16, #0xfb57, LSL #32
    MOVK  X16, #0xa308, LSL #48
    MOVZ  X17, #0x8040, LSL #0
    MOVK  X17, #0x48e1, LSL #16
    MOVK  X17, #0x548b, LSL #32
    MOVK  X17, #0x20e1, LSL #48
    MOVZ  X23, #0x1a6d, LSL #0
    MOVK  X23, #0xc7ea, LSL #16
    MOVK  X23, #0x9118, LSL #32
    MOVK  X23, #0xb318, LSL #48
    MOVZ  X24, #0xbe11, LSL #0
    MOVK  X24, #0x17ee, LSL #16
    MOVK  X24, #0x1f62, LSL #32
    MOVK  X24, #0x7fe5, LSL #48
    MOVZ  X25, #0x752f, LSL #0
    MOVK  X25, #0x3158, LSL #16
    MOVK  X25, #0xaa26, LSL #32
    MOVK  X25, #0x4bd5, LSL #48
    MOVZ  X26, #0xdf4d, LSL #0
    MOVK  X26, #0xc2a, LSL #16
    MOVK  X26, #0x6b82, LSL #32
    MOVK  X26, #0x8695, LSL #48
    MOVZ  X27, #0x33ae, LSL #0
    MOVK  X27, #0x8884, LSL #16
    MOVK  X27, #0x9311, LSL #32
    MOVK  X27, #0x549c, LSL #48
    MOVZ  X28, #0xd14f, LSL #0
    MOVK  X28, #0x930d, LSL #16
    MOVK  X28, #0x9839, LSL #32
    MOVK  X28, #0xe6f4, LSL #48
    MOVZ  X29, #0x23f3, LSL #0
    MOVK  X29, #0x2d34, LSL #16
    MOVK  X29, #0xbe8b, LSL #32
    MOVK  X29, #0xc34e, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X26
    FMOV  D1, X28
    FMOV  V1.D[1], X29
    FMOV  D2, X13
    FMOV  V2.D[1], X23
    FMOV  D3, X27
    FMOV  V3.D[1], X7
    FMOV  D4, X17
    FMOV  V4.D[1], X3
    FMOV  D5, X28
    FMOV  V5.D[1], X26
    FMOV  D6, X3
    FMOV  V6.D[1], X10
    FMOV  D7, X4
    FMOV  V7.D[1], X14
    FMOV  D8, X15
    FMOV  V8.D[1], X9
    FMOV  D9, X12
    FMOV  V9.D[1], X5
    FMOV  D10, X10
    FMOV  V10.D[1], X12
    FMOV  D11, X13
    FMOV  V11.D[1], X17
    FMOV  D12, X16
    FMOV  V12.D[1], X29
    FMOV  D13, X15
    FMOV  V13.D[1], X6
    FMOV  D14, X24
    FMOV  V14.D[1], X26
    FMOV  D15, X23
    FMOV  V15.D[1], X9
    FMOV  D16, X2
    FMOV  V16.D[1], X12
    FMOV  D17, X23
    FMOV  V17.D[1], X6
    FMOV  D18, X17
    FMOV  V18.D[1], X15
    FMOV  D19, X29
    FMOV  V19.D[1], X5
    FMOV  D20, X9
    FMOV  V20.D[1], X28
    FMOV  D21, X15
    FMOV  V21.D[1], X24
    FMOV  D22, X4
    FMOV  V22.D[1], X15
    FMOV  D23, X27
    FMOV  V23.D[1], X17
    FMOV  D24, X12
    FMOV  V24.D[1], X17
    FMOV  D25, X6
    FMOV  V25.D[1], X8
    FMOV  D26, X24
    FMOV  V26.D[1], X4
    FMOV  D27, X2
    FMOV  V27.D[1], X24
    FMOV  D28, X28
    FMOV  V28.D[1], X29
    FMOV  D29, X14
    FMOV  V29.D[1], X16
    FMOV  D30, X29
    FMOV  V30.D[1], X29
    FMOV  D31, X14
    FMOV  V31.D[1], X17
    MOVZ  X5, #0xa, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_10:
    FRSQRTS  V26.4H, V23.4H, V27.4H
    FMLS  V31.4S, V31.4S, V29.4S
    FMULX H24, H30, V3.H[0x2]
    FMLS S1, S28, V25.S[0x3]
    FMUL V8.4S, V26.4S, V26.S[0x0]
    FACGT  V25.4H, V24.4H, V31.4H
    FACGT  V24.2S, V18.2S, V25.2S
    FMULX D15, D8, V1.D[0x0]
    FRECPE  V15.2S, V15.2S
    FMOV  V22.2D, #0.32812500
    FMULX D10, D22, V24.D[0x1]
    FMUL H18, H4, V13.H[0x6]
    FMULX V25.4H, V23.4H, V3.H[0x0]
    FRSQRTE  V26.2S, V20.2S
    FACGE  V29.2S, V4.2S, V8.2S
    FABS  V25.2S, V6.2S
    FACGE  V13.2D, V15.2D, V13.2D
    FABS  V15.4S, V26.4S
    FADD  V6.2D, V2.2D, V30.2D
    FMULX S22, S31, V3.S[0x1]
    FADDP D4, V27.2D
    FRECPE  V15.8H, V13.8H
    FMUL V20.2S, V10.2S, V26.S[0x3]
    FSQRT  V23.2S, V25.2S
    FMUL S27, S29, V6.S[0x2]
    FMULX V1.4S, V4.4S, V21.S[0x3]
    FADDP  V10.4S, V18.4S, V22.4S
    FMULX V28.2D, V23.2D, V0.D[0x0]
    FMLA V13.4H, V19.4H, V0.H[0x1]
    FMLA H24, H20, V15.H[0x6]
    FMUL  V25.8H, V24.8H, V19.8H
    FMULX V4.2D, V6.2D, V7.D[0x1]
    FMLS S31, S28, V16.S[0x3]
    FMLA V13.2S, V31.2S, V6.S[0x2]
    FACGT  V15.8H, V24.8H, V24.8H
    FMOV  V6.8H, #-1.56250000
    FNEG  V18.2D, V27.2D
    FMOV  V26.2D, #1.31250000
    FMOV  V20.2D, #13.00000000
    FMLA V3.2D, V7.2D, V24.D[0x0]
    FSQRT  V16.8H, V9.8H
    FSUB  V2.4H, V3.4H, V25.4H
    FNEG  V29.2S, V15.2S
    FMUL D19, D10, V14.D[0x0]
    FADDP S8, V13.2S
    FRSQRTS  V15.4H, V4.4H, V20.4H
    FMLA  V9.8H, V18.8H, V6.8H
    FADDP S28, V2.2S
    FACGE  V14.8H, V15.8H, V15.8H
    FMUL D22, D9, V28.D[0x0]
    FMUL S20, S8, V14.S[0x0]
    FSUB  V27.2D, V5.2D, V26.2D
    FMULX D24, D15, V29.D[0x1]
    FMLS V7.4S, V14.4S, V20.S[0x3]
    FRSQRTS  V24.2S, V21.2S, V24.2S
    FMLA V6.4H, V22.4H, V15.H[0x4]
    FMUL V20.8H, V6.8H, V2.H[0x6]
    FADDP D29, V16.2D
    FMLS V2.2D, V29.2D, V19.D[0x1]
    FMULX  V13.2D, V20.2D, V24.2D
    FADDP S18, V0.2S
    FRSQRTS  V4.2S, V24.2S, V10.2S
    FACGE  V28.2D, V22.2D, V27.2D
    FMLS S12, S4, V21.S[0x2]
    FMULX V22.4S, V13.4S, V30.S[0x3]
    FRSQRTS  V0.2D, V22.2D, V19.2D
    FMLA V13.2D, V28.2D, V12.D[0x1]
    FMUL  V15.2D, V18.2D, V18.2D
    FMUL V30.2D, V15.2D, V18.D[0x1]
    FMLS D8, D0, V27.D[0x0]
    FACGE  V10.8H, V7.8H, V1.8H
    FMULX S21, S8, V1.S[0x3]
    FRSQRTS  V8.4S, V28.4S, V7.4S
    FABS  V9.4S, V13.4S
    FMLS V14.2D, V10.2D, V0.D[0x1]
    FSQRT  V31.2D, V8.2D
    FNEG  V28.2S, V31.2S
    FDIV  V18.2S, V28.2S, V30.2S
    FMLA D13, D9, V15.D[0x0]
    FRSQRTE  V23.4H, V13.4H
    FDIV  V19.2D, V31.2D, V23.2D
    FRECPS  V12.8H, V19.8H, V19.8H
    FMLS D0, D18, V21.D[0x0]
    FACGE  V30.4S, V12.4S, V31.4S
    FMULX S1, S3, V30.S[0x0]
    FSUB  V10.8H, V12.8H, V11.8H
    FSQRT  V8.4H, V6.4H
    FACGE  V9.2S, V3.2S, V27.2S
    FMLS V27.8H, V1.8H, V1.H[0x0]
    FABS  V30.8H, V27.8H
    FRECPS  V23.8H, V0.8H, V30.8H
    FMLA S3, S8, V30.S[0x1]
    FMUL V18.8H, V31.8H, V10.H[0x1]
    FMUL V13.4S, V9.4S, V25.S[0x3]
    FRECPS  V31.4H, V13.4H, V3.4H
    FMUL S17, S18, V17.S[0x0]
    FRSQRTS  V10.8H, V11.8H, V17.8H
    FDIV  V28.4S, V1.4S, V13.4S
    FRECPE  V30.8H, V23.8H
    FMLS  V12.4S, V9.4S, V28.4S
    FMULX D21, D17, V10.D[0x1]
    FMLS S8, S31, V21.S[0x2]
    FMLS V1.2D, V1.2D, V14.D[0x0]
    FMLA V0.2D, V30.2D, V30.D[0x0]
    FDIV  V13.8H, V28.8H, V12.8H
    FMLA V27.2D, V8.2D, V13.D[0x1]
    FMLA D31, D5, V28.D[0x1]
    FMUL V10.2S, V27.2S, V31.S[0x3]
    FABS  V14.4H, V31.4H
    FMOV  V8.8H, #25.00000000
    FMOV  V9.8H, #6.50000000
    FADDP S21, V23.2S
    FACGE  V5.2S, V29.2S, V14.2S
    FSQRT  V28.2D, V9.2D
    FMUL V12.2S, V23.2S, V1.S[0x0]
    FMULX V18.4S, V21.4S, V0.S[0x2]
    FMLA S14, S12, V8.S[0x3]
    FABD  V5.8H, V29.8H, V5.8H
    FMULX V29.2D, V18.2D, V10.D[0x1]
    FMLA S3, S22, V7.S[0x0]
    FACGE  V1.2D, V28.2D, V29.2D
    FMUL V18.4H, V6.4H, V14.H[0x5]
    FADDP  V10.8H, V5.8H, V23.8H
    FADDP  V9.4S, V3.4S, V25.4S
    FNEG  V13.2D, V28.2D
    FABS  V22.4H, V3.4H
    FMUL V30.4S, V18.4S, V11.S[0x2]
    FMLA V31.2S, V30.2S, V10.S[0x0]
    FSUB  V31.4H, V12.4H, V13.4H
    FMUL  V16.2D, V29.2D, V31.2D
    FMULX V24.2S, V27.2S, V9.S[0x2]
    FADDP H27, V19.2H
    FADDP H8, V0.2H
    FMLS  V0.2D, V10.2D, V22.2D
    FSQRT  V3.4H, V6.4H
    FSUB  V21.4H, V7.4H, V8.4H
    FABD  V25.4H, V31.4H, V3.4H
    FABD  V28.8H, V21.8H, V16.8H
    FMULX V13.4S, V27.4S, V9.S[0x3]
    FMLA H31, H9, V13.H[0x4]
    FMULX H30, H31, V4.H[0x4]
    FMUL S29, S0, V4.S[0x0]
    FRECPE  V19.2D, V28.2D
    FADD  V10.8H, V30.8H, V12.8H
    FMULX V28.4H, V25.4H, V10.H[0x1]
    FNEG  V3.4S, V20.4S
    FMOV  V31.2S, #26.00000000
    FRECPS  V25.2D, V1.2D, V29.2D
    FABD  V8.4H, V25.4H, V28.4H
    FSUB  V7.8H, V31.8H, V24.8H
    FSQRT  V28.4S, V7.4S
    FMLA V27.4S, V28.4S, V2.S[0x0]
    FMLA H26, H3, V11.H[0x4]
    FADD  V6.4S, V19.4S, V26.4S
    FMULX  V11.2D, V27.2D, V8.2D
    FADD  V8.8H, V9.8H, V2.8H
    FSQRT  V27.8H, V13.8H
    FADD  V31.4S, V30.4S, V1.4S
    FMUL S12, S24, V24.S[0x0]
    FMUL H28, H27, V2.H[0x5]
    FMLS  V19.8H, V12.8H, V31.8H
    FRSQRTE  V1.8H, V8.8H
    FMLS H25, H14, V3.H[0x6]
    FSUB  V29.4S, V2.4S, V6.4S
    FMLA D9, D4, V26.D[0x0]
    FMLS V15.2D, V3.2D, V22.D[0x0]
    FDIV  V13.2D, V29.2D, V29.2D
    FNEG  V22.8H, V6.8H
    FADD  V0.4H, V15.4H, V17.4H
    FRSQRTS  V26.2D, V15.2D, V19.2D
    FSUB  V29.8H, V22.8H, V20.8H
    FADD  V12.8H, V11.8H, V20.8H
    FMLA S17, S26, V16.S[0x3]
    FABS  V4.2S, V17.2S
    FACGT  V16.2S, V22.2S, V0.2S
    FRECPS  V10.4S, V4.4S, V16.4S
    FABS  V3.4H, V10.4H
    FMLS V7.4S, V12.4S, V25.S[0x0]
    FADDP D26, V29.2D
    FSUB  V6.2D, V13.2D, V8.2D
    FMULX V27.2D, V1.2D, V26.D[0x0]
    FACGT  V17.4H, V25.4H, V4.4H
    FMUL D2, D7, V13.D[0x1]
    FNEG  V12.4H, V22.4H
    FABD  V29.4S, V6.4S, V31.4S
    FMLA D13, D27, V25.D[0x0]
    FMLS S11, S2, V15.S[0x3]
    FMUL  V22.8H, V5.8H, V26.8H
    FMLA  V24.4S, V12.4S, V17.4S
    FRSQRTE  V15.2S, V23.2S
    FMLA V16.8H, V22.8H, V15.H[0x6]
    FMLS V22.4S, V13.4S, V29.S[0x0]
    FMOV  V19.2D, #-5.00000000
    FMOV  V20.4S, #0.81250000
    FMUL V31.2D, V11.2D, V24.D[0x1]
    FMOV  V2.8H, #-3.75000000
    FADD  V6.4H, V31.4H, V3.4H
    FACGE  V17.4H, V19.4H, V16.4H
    FADDP D4, V17.2D
    FACGE  V13.4H, V22.4H, V4.4H
    SUBS  X5, X5, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_10
    MOVZ  X23, #0xaf4c, LSL #0
    MOVK  X23, #0xe6ff, LSL #16
    MOVK  X23, #0x2e9e, LSL #32
    MOVK  X23, #0x1cd8, LSL #48
    SUB  X13, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x5f3b, LSL #0
    MOVK  X23, #0x337e, LSL #16
    MOVK  X23, #0x5983, LSL #32
    MOVK  X23, #0x7c97, LSL #48
    SUB  X13, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xc63b, LSL #0
    MOVK  X23, #0x9c8e, LSL #16
    MOVK  X23, #0xfed7, LSL #32
    MOVK  X23, #0xec5, LSL #48
    SUB  X13, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xc279, LSL #0
    MOVK  X23, #0xf957, LSL #16
    MOVK  X23, #0x6779, LSL #32
    MOVK  X23, #0xe001, LSL #48
    SUB  X13, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x4850, LSL #0
    MOVK  X23, #0x4416, LSL #16
    MOVK  X23, #0xe11f, LSL #32
    MOVK  X23, #0x92b1, LSL #48
    SUB  X13, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x2d74, LSL #0
    MOVK  X23, #0xa167, LSL #16
    MOVK  X23, #0x6299, LSL #32
    MOVK  X23, #0x37d8, LSL #48
    SUB  X13, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x5ec3, LSL #0
    MOVK  X23, #0x7c02, LSL #16
    MOVK  X23, #0xf656, LSL #32
    MOVK  X23, #0xad78, LSL #48
    SUB  X13, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xc7c0, LSL #0
    MOVK  X23, #0xb983, LSL #16
    MOVK  X23, #0x7a88, LSL #32
    MOVK  X23, #0xcdc7, LSL #48
    SUB  X13, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xd78f, LSL #0
    MOVK  X23, #0xbb89, LSL #16
    MOVK  X23, #0x53db, LSL #32
    MOVK  X23, #0x2437, LSL #48
    SUB  X13, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x79ec, LSL #0
    MOVK  X23, #0x2fdb, LSL #16
    MOVK  X23, #0x6b4c, LSL #32
    MOVK  X23, #0xc2d0, LSL #48
    SUB  X13, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x9704, LSL #0
    MOVK  X23, #0x79ec, LSL #16
    MOVK  X23, #0x87fb, LSL #32
    MOVK  X23, #0xcb3, LSL #48
    SUB  X13, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x331c, LSL #0
    MOVK  X23, #0xbdb2, LSL #16
    MOVK  X23, #0xfb57, LSL #32
    MOVK  X23, #0xa308, LSL #48
    SUB  X13, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x8040, LSL #0
    MOVK  X23, #0x48e1, LSL #16
    MOVK  X23, #0x548b, LSL #32
    MOVK  X23, #0x20e1, LSL #48
    SUB  X13, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xbe11, LSL #0
    MOVK  X23, #0x17ee, LSL #16
    MOVK  X23, #0x1f62, LSL #32
    MOVK  X23, #0x7fe5, LSL #48
    SUB  X13, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x752f, LSL #0
    MOVK  X23, #0x3158, LSL #16
    MOVK  X23, #0xaa26, LSL #32
    MOVK  X23, #0x4bd5, LSL #48
    SUB  X13, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xdf4d, LSL #0
    MOVK  X23, #0xc2a, LSL #16
    MOVK  X23, #0x6b82, LSL #32
    MOVK  X23, #0x8695, LSL #48
    SUB  X13, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x33ae, LSL #0
    MOVK  X23, #0x8884, LSL #16
    MOVK  X23, #0x9311, LSL #32
    MOVK  X23, #0x549c, LSL #48
    SUB  X13, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xd14f, LSL #0
    MOVK  X23, #0x930d, LSL #16
    MOVK  X23, #0x9839, LSL #32
    MOVK  X23, #0xe6f4, LSL #48
    SUB  X13, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x23f3, LSL #0
    MOVK  X23, #0x2d34, LSL #16
    MOVK  X23, #0xbe8b, LSL #32
    MOVK  X23, #0xc34e, LSL #48
    SUB  X13, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MRS  X23, FPSR
    MOVZ  X13, #0x1f, LSL #0
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V0.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D0
    MOVZ  X13, #0x7fff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0x7fff, LSL #32
    MOVK  X13, #0x7fff, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V1.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0x7c00, LSL #16
    MOVK  X13, #0x7c00, LSL #32
    MOVK  X13, #0x7c00, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D1
    MOVZ  X13, #0x7fff, LSL #0
    MOVK  X13, #0x7fff, LSL #16
    MOVK  X13, #0x7fff, LSL #32
    MOVK  X13, #0x7fff, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X13, #0xc380, LSL #0
    MOVK  X13, #0xc380, LSL #16
    MOVK  X13, #0xc380, LSL #32
    MOVK  X13, #0xc380, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D2
    MOVZ  X13, #0xc380, LSL #0
    MOVK  X13, #0xc380, LSL #16
    MOVK  X13, #0xc380, LSL #32
    MOVK  X13, #0xc380, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D3
    MOVZ  X13, #0x7fff, LSL #0
    MOVK  X13, #0x7fff, LSL #16
    MOVK  X13, #0x4000, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D4
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D5
    MOVZ  X13, #0x7fff, LSL #0
    MOVK  X13, #0x7fff, LSL #16
    MOVK  X13, #0x7fff, LSL #32
    MOVK  X13, #0x7fff, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D6
    MOVZ  X13, #0x7fff, LSL #0
    MOVK  X13, #0x7fff, LSL #16
    MOVK  X13, #0x4000, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X13, #0x7fff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0x7fff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D7
    MOVZ  X13, #0x7fff, LSL #0
    MOVK  X13, #0x7fff, LSL #16
    MOVK  X13, #0x7fff, LSL #32
    MOVK  X13, #0x7fff, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X13, #0xffff, LSL #0
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D8
    MOVZ  X13, #0x7fff, LSL #0
    MOVK  X13, #0x7fff, LSL #16
    MOVK  X13, #0x7fff, LSL #32
    MOVK  X13, #0x7fff, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D9
    MOVZ  X13, #0x7fff, LSL #0
    MOVK  X13, #0x7fff, LSL #16
    MOVK  X13, #0x7fff, LSL #32
    MOVK  X13, #0x7fff, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x4000, LSL #16
    MOVK  X13, #0x4000, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D10
    MOVZ  X13, #0x7fff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0x4000, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D11
    MOVZ  X13, #0x7fff, LSL #0
    MOVK  X13, #0x7fff, LSL #16
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D12
    MOVZ  X13, #0x7fff, LSL #0
    MOVK  X13, #0x7fff, LSL #16
    MOVK  X13, #0x7fff, LSL #32
    MOVK  X13, #0x7fff, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D13
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D14
    MOVZ  X13, #0x7fff, LSL #0
    MOVK  X13, #0x7fff, LSL #16
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D15
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0x7fff, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D16
    MOVZ  X13, #0x7fff, LSL #0
    MOVK  X13, #0x7fff, LSL #16
    MOVK  X13, #0x7fff, LSL #32
    MOVK  X13, #0x7fff, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D17
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D18
    MOVZ  X13, #0x7fff, LSL #0
    MOVK  X13, #0x7fff, LSL #16
    MOVK  X13, #0x7fff, LSL #32
    MOVK  X13, #0x7fff, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xc014, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D19
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xc014, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x3f50, LSL #16
    MOVK  X13, #0x3f50, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D20
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x3f50, LSL #16
    MOVK  X13, #0x3f50, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D21
    MOVZ  X13, #0x7fff, LSL #0
    MOVK  X13, #0x7fff, LSL #16
    MOVK  X13, #0x7fff, LSL #32
    MOVK  X13, #0x7fff, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X13, #0x7fff, LSL #0
    MOVK  X13, #0x7fff, LSL #16
    MOVK  X13, #0x7fff, LSL #32
    MOVK  X13, #0x7fff, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D22
    MOVZ  X13, #0x7fff, LSL #0
    MOVK  X13, #0x7fff, LSL #16
    MOVK  X13, #0x7fff, LSL #32
    MOVK  X13, #0x7fff, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V23.D[1]
    MOVZ  X13, #0x7fff, LSL #0
    MOVK  X13, #0x7fff, LSL #16
    MOVK  X13, #0x7fff, LSL #32
    MOVK  X13, #0x7fff, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D23
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0x7fff, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D24
    MOVZ  X13, #0x7fff, LSL #0
    MOVK  X13, #0x7fff, LSL #16
    MOVK  X13, #0x7fff, LSL #32
    MOVK  X13, #0x7fff, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D25
    MOVZ  X13, #0xffff, LSL #0
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D26
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D27
    MOVZ  X13, #0x7fff, LSL #0
    MOVK  X13, #0x7fff, LSL #16
    MOVK  X13, #0x7fff, LSL #32
    MOVK  X13, #0x7fff, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D28
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X13, #0x7fff, LSL #0
    MOVK  X13, #0x7fff, LSL #16
    MOVK  X13, #0x7fff, LSL #32
    MOVK  X13, #0x7fff, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D29
    MOVZ  X13, #0x7fff, LSL #0
    MOVK  X13, #0x7fff, LSL #16
    MOVK  X13, #0x7fff, LSL #32
    MOVK  X13, #0x7fff, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V30.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D30
    MOVZ  X13, #0xffff, LSL #0
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, V31.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X23, D31
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
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
    FMOV  V0.D[1], X15
    FMOV  D1, X13
    FMOV  V1.D[1], X24
    FMOV  D2, X26
    FMOV  V2.D[1], X2
    FMOV  D3, X29
    FMOV  V3.D[1], X29
    FMOV  D4, X25
    FMOV  V4.D[1], X4
    FMOV  D5, X16
    FMOV  V5.D[1], X7
    FMOV  D6, X11
    FMOV  V6.D[1], X27
    FMOV  D7, X12
    FMOV  V7.D[1], X11
    FMOV  D8, X28
    FMOV  V8.D[1], X29
    FMOV  D9, X29
    FMOV  V9.D[1], X7
    FMOV  D10, X15
    FMOV  V10.D[1], X10
    FMOV  D11, X4
    FMOV  V11.D[1], X29
    FMOV  D12, X17
    FMOV  V12.D[1], X14
    FMOV  D13, X29
    FMOV  V13.D[1], X29
    FMOV  D14, X6
    FMOV  V14.D[1], X28
    FMOV  D15, X2
    FMOV  V15.D[1], X3
    FMOV  D16, X16
    FMOV  V16.D[1], X26
    FMOV  D17, X2
    FMOV  V17.D[1], X24
    FMOV  D18, X16
    FMOV  V18.D[1], X11
    FMOV  D19, X6
    FMOV  V19.D[1], X10
    FMOV  D20, X2
    FMOV  V20.D[1], X26
    FMOV  D21, X7
    FMOV  V21.D[1], X15
    FMOV  D22, X29
    FMOV  V22.D[1], X12
    FMOV  D23, X8
    FMOV  V23.D[1], X26
    FMOV  D24, X29
    FMOV  V24.D[1], X25
    FMOV  D25, X29
    FMOV  V25.D[1], X16
    FMOV  D26, X29
    FMOV  V26.D[1], X28
    FMOV  D27, X5
    FMOV  V27.D[1], X29
    FMOV  D28, X8
    FMOV  V28.D[1], X23
    FMOV  D29, X12
    FMOV  V29.D[1], X24
    FMOV  D30, X9
    FMOV  V30.D[1], X13
    FMOV  D31, X27
    FMOV  V31.D[1], X23
    MOVZ  X17, #0xa, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_11:
    FDIV  V22.2D, V25.2D, V22.2D
    FABS  V10.8H, V23.8H
    FSUB  V16.2S, V13.2S, V31.2S
    FMOV  V21.4H, #-0.42187500
    FMLS  V18.4H, V20.4H, V22.4H
    FMLA V17.2S, V26.2S, V18.S[0x2]
    FADDP  V12.2D, V16.2D, V27.2D
    FMOV  V5.4H, #-3.50000000
    FMLS  V23.2D, V12.2D, V21.2D
    FNEG  V5.8H, V30.8H
    FRECPS  V25.2S, V16.2S, V29.2S
    FMLS  V14.2S, V24.2S, V28.2S
    FMLS  V24.2D, V25.2D, V17.2D
    FMLS D31, D10, V31.D[0x1]
    FMULX H15, H28, V5.H[0x5]
    FSQRT  V10.4H, V24.4H
    FMLS  V28.8H, V24.8H, V23.8H
    FMUL V15.2S, V14.2S, V12.S[0x3]
    FABS  V18.4S, V7.4S
    FMLA  V16.4S, V10.4S, V30.4S
    FRECPE  V14.8H, V18.8H
    FACGE  V31.2D, V15.2D, V14.2D
    FMULX V10.2D, V19.2D, V27.D[0x0]
    FMLA H21, H28, V10.H[0x7]
    FNEG  V10.2D, V10.2D
    FSUB  V15.8H, V31.8H, V21.8H
    FMULX  V21.8H, V16.8H, V31.8H
    FABS  V12.8H, V10.8H
    FABS  V20.8H, V4.8H
    FMLS  V5.2S, V15.2S, V21.2S
    FSUB  V4.8H, V5.8H, V29.8H
    FMUL H7, H28, V4.H[0x0]
    FMULX  V4.8H, V29.8H, V7.8H
    FADDP S5, V20.2S
    FRECPE  V29.8H, V5.8H
    FACGE  V27.2D, V23.2D, V29.2D
    FMLA  V5.2D, V12.2D, V12.2D
    FSUB  V29.4H, V4.4H, V27.4H
    FMULX V10.8H, V3.8H, V11.H[0x2]
    FADD  V21.4S, V22.4S, V31.4S
    FMLS H18, H29, V14.H[0x3]
    FADDP H16, V16.2H
    FSQRT  V29.4H, V6.4H
    FADDP D28, V25.2D
    FSUB  V20.2D, V3.2D, V1.2D
    FMLA V27.8H, V24.8H, V6.H[0x2]
    FMLA V1.4H, V16.4H, V10.H[0x0]
    FMLA V30.2S, V21.2S, V1.S[0x3]
    FMLA  V3.2D, V27.2D, V18.2D
    FRSQRTS  V15.2D, V31.2D, V20.2D
    FMLS S10, S27, V2.S[0x1]
    FRSQRTE  V13.8H, V3.8H
    FMOV  V22.4H, #0.40625000
    FNEG  V28.4H, V30.4H
    FRECPE  V8.2S, V7.2S
    FMLA V29.4S, V5.4S, V8.S[0x2]
    FMUL  V23.2D, V15.2D, V29.2D
    FMOV  V25.8H, #-26.00000000
    FACGT  V29.2S, V13.2S, V25.2S
    FABS  V31.8H, V28.8H
    FRECPS  V3.4H, V8.4H, V22.4H
    FMULX D13, D23, V10.D[0x0]
    FSUB  V22.4H, V13.4H, V13.4H
    FMULX H11, H22, V6.H[0x7]
    FABD  V27.8H, V11.8H, V29.8H
    FMUL D22, D31, V5.D[0x0]
    FMUL H24, H22, V5.H[0x5]
    FADDP D23, V24.2D
    FACGT  V11.2S, V3.2S, V6.2S
    FMULX H20, H11, V11.H[0x4]
    FMLA H15, H5, V5.H[0x7]
    FMLS  V29.2D, V15.2D, V15.2D
    FMLA V3.2D, V11.2D, V29.D[0x0]
    FABS  V26.8H, V20.8H
    FSUB  V14.4H, V0.4H, V23.4H
    FMLS  V5.8H, V3.8H, V28.8H
    FRECPE  V6.2D, V27.2D
    FACGT  V0.4S, V5.4S, V13.4S
    FSQRT  V8.2S, V6.2S
    FMLS V11.8H, V26.8H, V4.H[0x2]
    FADDP  V15.4H, V14.4H, V12.4H
    FMULX V29.2D, V4.2D, V28.D[0x0]
    FDIV  V26.4H, V15.4H, V1.4H
    FMULX V8.8H, V8.8H, V8.H[0x3]
    FMLS H6, H9, V11.H[0x1]
    FMULX  V3.4H, V30.4H, V12.4H
    FMLS S15, S8, V27.S[0x3]
    FACGT  V18.4S, V29.4S, V13.4S
    FMLS  V28.8H, V28.8H, V26.8H
    FADDP H11, V0.2H
    FMLA S16, S19, V10.S[0x2]
    FMUL  V5.4S, V16.4S, V15.4S
    FABD  V16.8H, V7.8H, V22.8H
    FABD  V22.2S, V11.2S, V5.2S
    FSUB  V11.8H, V18.8H, V9.8H
    FMLS H27, H3, V3.H[0x1]
    FMLS V9.4S, V10.4S, V16.S[0x0]
    FABD  V30.2S, V28.2S, V27.2S
    FMULX S14, S22, V11.S[0x0]
    FMLA  V19.8H, V10.8H, V30.8H
    FMUL D15, D16, V7.D[0x0]
    FMUL D7, D6, V19.D[0x1]
    FMULX  V12.4S, V7.4S, V10.4S
    FMLS S0, S15, V17.S[0x3]
    FMLA V22.8H, V12.8H, V8.H[0x3]
    FMLS V18.2S, V3.2S, V20.S[0x3]
    FMUL D28, D8, V9.D[0x1]
    FMLS V27.2D, V22.2D, V18.D[0x0]
    FMLA V3.2D, V10.2D, V14.D[0x0]
    FACGT  V7.2S, V27.2S, V27.2S
    FADD  V14.4H, V7.4H, V15.4H
    FADD  V27.2S, V28.2S, V0.2S
    FMULX H11, H28, V2.H[0x4]
    FSUB  V15.2D, V11.2D, V3.2D
    FSUB  V30.8H, V14.8H, V25.8H
    FSUB  V5.8H, V15.8H, V10.8H
    FMLS  V7.2S, V23.2S, V30.2S
    FMLS  V3.4S, V7.4S, V18.4S
    FMLS H18, H30, V1.H[0x3]
    FRECPS  V17.2D, V10.2D, V5.2D
    FMLA V16.4H, V23.4H, V3.H[0x2]
    FMUL  V5.4S, V27.4S, V13.4S
    FMUL H10, H5, V0.H[0x3]
    FADDP  V1.4S, V16.4S, V8.4S
    FMUL H20, H13, V4.H[0x4]
    FMLS V31.2D, V20.2D, V20.D[0x0]
    FMULX V28.4S, V1.4S, V31.S[0x1]
    FADDP H2, V10.2H
    FMLA V26.8H, V9.8H, V9.H[0x2]
    FMUL V10.2S, V26.2S, V17.S[0x3]
    FACGE  V11.2S, V2.2S, V17.2S
    FMULX D14, D24, V12.D[0x0]
    FRECPE  V8.8H, V25.8H
    FMUL S30, S9, V8.S[0x1]
    FADDP S23, V11.2S
    FACGT  V31.2S, V14.2S, V10.2S
    FADDP D13, V28.2D
    FMLA  V26.2S, V21.2S, V23.2S
    FMUL  V26.4H, V26.4H, V23.4H
    FMUL H27, H13, V13.H[0x6]
    FMULX V28.2D, V25.2D, V27.D[0x1]
    FMLA V9.4S, V18.4S, V31.S[0x1]
    FRECPS  V20.4H, V28.4H, V9.4H
    FACGT  V25.4H, V20.4H, V26.4H
    FRECPS  V8.8H, V24.8H, V25.8H
    FMLS D11, D28, V4.D[0x0]
    FSQRT  V13.8H, V5.8H
    FRSQRTE  V26.8H, V12.8H
    FMUL  V16.8H, V2.8H, V6.8H
    FMLS V6.4S, V6.4S, V22.S[0x1]
    FADDP D9, V25.2D
    FABS  V2.2D, V31.2D
    FMULX H13, H31, V2.H[0x4]
    FADDP H24, V30.2H
    FMULX V22.2S, V24.2S, V26.S[0x1]
    FMUL V18.8H, V11.8H, V6.H[0x4]
    FMLS S2, S9, V13.S[0x2]
    FSQRT  V28.2S, V2.2S
    FMLA V9.2D, V12.2D, V17.D[0x1]
    FMUL D31, D18, V8.D[0x0]
    FMLA V30.4H, V22.4H, V4.H[0x6]
    FMULX  V6.2D, V25.2D, V16.2D
    FMULX V22.2S, V28.2S, V6.S[0x3]
    FNEG  V16.4S, V31.4S
    FMLS V26.4S, V22.4S, V22.S[0x1]
    FMOV  V11.4H, #-10.50000000
    FMLS H17, H9, V11.H[0x5]
    FMLA D9, D11, V26.D[0x1]
    FRECPE  V1.4S, V23.4S
    FMUL V25.4S, V20.4S, V29.S[0x0]
    FMLS V23.2D, V30.2D, V17.D[0x1]
    FMLA V24.2D, V7.2D, V23.D[0x0]
    FRECPS  V4.2D, V9.2D, V27.2D
    FMOV  V19.4H, #4.00000000
    FNEG  V29.8H, V30.8H
    FMOV  V13.2S, #0.96875000
    FRSQRTS  V6.4H, V24.4H, V1.4H
    FRSQRTE  V31.8H, V20.8H
    FMLS V27.2S, V4.2S, V6.S[0x0]
    FRSQRTS  V7.4H, V29.4H, V29.4H
    FMLA V6.2D, V31.2D, V19.D[0x1]
    FMLA S1, S11, V6.S[0x2]
    FMUL H23, H1, V1.H[0x5]
    FMLS  V1.4S, V28.4S, V13.4S
    FACGT  V14.2S, V4.2S, V29.2S
    FMLS V26.2S, V23.2S, V13.S[0x2]
    FABS  V24.8H, V10.8H
    FMULX V29.2D, V27.2D, V27.D[0x1]
    FMULX  V10.2D, V0.2D, V14.2D
    FRSQRTE  V6.4H, V26.4H
    FMLS  V30.4S, V1.4S, V7.4S
    FADDP H9, V30.2H
    FACGT  V31.4S, V21.4S, V16.4S
    FRECPE  V13.4S, V10.4S
    FRSQRTS  V30.4H, V29.4H, V23.4H
    FACGE  V11.8H, V12.8H, V24.8H
    FRECPS  V0.4S, V25.4S, V11.4S
    FACGE  V14.4S, V13.4S, V10.4S
    FMULX V12.2S, V6.2S, V28.S[0x2]
    FSQRT  V10.8H, V30.8H
    SUBS  X17, X17, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_11
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MRS  X10, FPSR
    MOVZ  X24, #0x1f, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V0.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0x7fff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0x7fff, LSL #48
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D0
    MOVZ  X24, #0x7fff, LSL #0
    MOVK  X24, #0x7fff, LSL #16
    MOVK  X24, #0x7fff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V1.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D1
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x7f80, LSL #16
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V2.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D2
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V3.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D3
    MOVZ  X24, #0x7fff, LSL #0
    MOVK  X24, #0x7fff, LSL #16
    MOVK  X24, #0x7fff, LSL #32
    MOVK  X24, #0x7fff, LSL #48
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x4000, LSL #48
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D4
    MOVZ  X24, #0xfffd, LSL #0
    MOVK  X24, #0x4000, LSL #48
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D5
    MOVZ  X24, #0x7fff, LSL #0
    MOVK  X24, #0x7fff, LSL #16
    MOVK  X24, #0x7fff, LSL #32
    MOVK  X24, #0x7fff, LSL #48
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D6
    MOVZ  X24, #0x7fff, LSL #0
    MOVK  X24, #0x7fff, LSL #16
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V7.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D7
    MOVZ  X24, #0x7fff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0x3e00, LSL #32
    MOVK  X24, #0x3e00, LSL #48
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V8.D[1]
    MOVZ  X24, #0x4000, LSL #0
    MOVK  X24, #0x4000, LSL #16
    MOVK  X24, #0x4000, LSL #32
    MOVK  X24, #0x4000, LSL #48
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D8
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0x4000, LSL #16
    MOVK  X24, #0x4000, LSL #32
    MOVK  X24, #0x4000, LSL #48
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D9
    MOVZ  X24, #0x7fff, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D10
    MOVZ  X24, #0x7fff, LSL #0
    MOVK  X24, #0x7fff, LSL #16
    MOVK  X24, #0x7fff, LSL #32
    MOVK  X24, #0x7fff, LSL #48
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D11
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D12
    MOVZ  X24, #0x7fff, LSL #0
    MOVK  X24, #0x7fff, LSL #16
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x7f80, LSL #16
    MOVK  X24, #0x7f80, LSL #48
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D13
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x7f80, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D14
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D15
    MOVZ  X24, #0x7fff, LSL #0
    MOVK  X24, #0x7fff, LSL #16
    MOVK  X24, #0x7fff, LSL #32
    MOVK  X24, #0x7fff, LSL #48
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x8000, LSL #16
    MOVK  X24, #0x8000, LSL #48
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D16
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0x7fff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0x7fff, LSL #48
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D17
    MOVZ  X24, #0x7fff, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X24, #0x7fef, LSL #0
    MOVK  X24, #0x7fef, LSL #16
    MOVK  X24, #0x7fef, LSL #32
    MOVK  X24, #0x7fef, LSL #48
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D18
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D19
    MOVZ  X24, #0x4400, LSL #0
    MOVK  X24, #0x4400, LSL #16
    MOVK  X24, #0x4400, LSL #32
    MOVK  X24, #0x4400, LSL #48
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D20
    MOVZ  X24, #0x7fff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0x7fff, LSL #32
    MOVK  X24, #0x7fff, LSL #48
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D21
    MOVZ  X24, #0x7fff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0x7fff, LSL #32
    MOVK  X24, #0x7fff, LSL #48
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D22
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D23
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D24
    MOVZ  X24, #0x7fff, LSL #0
    MOVK  X24, #0x7fff, LSL #16
    MOVK  X24, #0x7fff, LSL #32
    MOVK  X24, #0x7fff, LSL #48
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V25.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D25
    MOVZ  X24, #0x7fff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0x7fff, LSL #32
    MOVK  X24, #0x7fff, LSL #48
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D26
    MOVZ  X24, #0x7fff, LSL #0
    MOVK  X24, #0x7fff, LSL #16
    MOVK  X24, #0x7c00, LSL #32
    MOVK  X24, #0x7c00, LSL #48
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D27
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D28
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D29
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V30.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D30
    MOVZ  X24, #0x7fff, LSL #0
    MOVK  X24, #0x7fff, LSL #16
    MOVK  X24, #0x7fff, LSL #32
    MOVK  X24, #0x7fff, LSL #48
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, V31.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X10, D31
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
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
    FMOV  V0.D[1], X26
    FMOV  D1, X16
    FMOV  V1.D[1], X27
    FMOV  D2, X29
    FMOV  V2.D[1], X23
    FMOV  D3, X25
    FMOV  V3.D[1], X6
    FMOV  D4, X7
    FMOV  V4.D[1], X9
    FMOV  D5, X2
    FMOV  V5.D[1], X15
    FMOV  D6, X27
    FMOV  V6.D[1], X9
    FMOV  D7, X9
    FMOV  V7.D[1], X7
    FMOV  D8, X15
    FMOV  V8.D[1], X27
    FMOV  D9, X25
    FMOV  V9.D[1], X6
    FMOV  D10, X29
    FMOV  V10.D[1], X25
    FMOV  D11, X6
    FMOV  V11.D[1], X7
    FMOV  D12, X3
    FMOV  V12.D[1], X23
    FMOV  D13, X13
    FMOV  V13.D[1], X13
    FMOV  D14, X9
    FMOV  V14.D[1], X14
    FMOV  D15, X27
    FMOV  V15.D[1], X14
    FMOV  D16, X29
    FMOV  V16.D[1], X7
    FMOV  D17, X3
    FMOV  V17.D[1], X27
    FMOV  D18, X25
    FMOV  V18.D[1], X6
    FMOV  D19, X29
    FMOV  V19.D[1], X11
    FMOV  D20, X6
    FMOV  V20.D[1], X27
    FMOV  D21, X12
    FMOV  V21.D[1], X15
    FMOV  D22, X15
    FMOV  V22.D[1], X14
    FMOV  D23, X17
    FMOV  V23.D[1], X27
    FMOV  D24, X26
    FMOV  V24.D[1], X9
    FMOV  D25, X13
    FMOV  V25.D[1], X5
    FMOV  D26, X16
    FMOV  V26.D[1], X27
    FMOV  D27, X16
    FMOV  V27.D[1], X6
    FMOV  D28, X29
    FMOV  V28.D[1], X6
    FMOV  D29, X10
    FMOV  V29.D[1], X23
    FMOV  D30, X24
    FMOV  V30.D[1], X27
    FMOV  D31, X17
    FMOV  V31.D[1], X11
    MOVZ  X26, #0xa, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_12:
    FMLA V9.4H, V25.4H, V4.H[0x7]
    FMLA  V26.4H, V18.4H, V31.4H
    FMLS  V11.4H, V23.4H, V26.4H
    FMLA S30, S28, V24.S[0x1]
    FACGT  V18.2S, V18.2S, V5.2S
    FDIV  V6.4H, V11.4H, V15.4H
    FADDP  V9.8H, V18.8H, V30.8H
    FMLA V27.4S, V9.4S, V24.S[0x3]
    FRSQRTE  V27.8H, V6.8H
    FMULX S4, S29, V29.S[0x2]
    FMLA D15, D4, V24.D[0x0]
    FNEG  V23.4H, V18.4H
    FMLS S24, S7, V9.S[0x3]
    FMLS V23.2S, V10.2S, V7.S[0x2]
    FADDP  V3.2S, V26.2S, V27.2S
    FMLS V27.4H, V15.4H, V15.H[0x7]
    FDIV  V25.4H, V7.4H, V8.4H
    FRSQRTE  V11.2S, V9.2S
    FMULX V0.4H, V23.4H, V2.H[0x6]
    FDIV  V6.8H, V13.8H, V23.8H
    FRECPE  V8.2S, V25.2S
    FADDP  V25.8H, V24.8H, V3.8H
    FRSQRTE  V24.2D, V27.2D
    FMUL V15.2D, V8.2D, V8.D[0x1]
    FABD  V29.4H, V20.4H, V24.4H
    FACGE  V26.8H, V25.8H, V27.8H
    FSUB  V18.2D, V11.2D, V6.2D
    FMULX V11.4H, V0.4H, V0.H[0x5]
    FDIV  V24.2D, V26.2D, V11.2D
    FMLA D4, D19, V29.D[0x0]
    FABS  V2.8H, V24.8H
    FMLA V26.2D, V27.2D, V2.D[0x1]
    FMULX V18.4H, V4.4H, V4.H[0x3]
    FRSQRTE  V20.4S, V26.4S
    FMLA V0.2D, V14.2D, V27.D[0x0]
    FMULX S6, S20, V7.S[0x3]
    FNEG  V19.4H, V3.4H
    FNEG  V24.4S, V18.4S
    FMULX S4, S24, V6.S[0x2]
    FMLA  V9.2S, V0.2S, V0.2S
    FMULX H11, H2, V3.H[0x1]
    FMULX V27.2S, V6.2S, V0.S[0x3]
    FMOV  V7.8H, #15.50000000
    FADDP S1, V22.2S
    FABS  V31.8H, V7.8H
    FSUB  V25.4S, V11.4S, V11.4S
    FMUL H0, H15, V1.H[0x5]
    FACGE  V25.4H, V27.4H, V4.4H
    FMULX  V29.4H, V19.4H, V19.4H
    FADDP  V20.8H, V29.8H, V9.8H
    FMLS  V3.4H, V0.4H, V20.4H
    FMULX D19, D11, V31.D[0x1]
    FMUL D17, D3, V25.D[0x1]
    FMLA V8.2S, V4.2S, V12.S[0x0]
    FACGE  V15.8H, V31.8H, V18.8H
    FMLA H16, H29, V14.H[0x6]
    FABS  V3.2D, V25.2D
    FNEG  V25.8H, V23.8H
    FMULX  V10.4H, V21.4H, V27.4H
    FSQRT  V11.2D, V2.2D
    FRSQRTE  V2.4H, V16.4H
    FMULX  V4.8H, V10.8H, V3.8H
    FDIV  V22.8H, V6.8H, V17.8H
    FMLS S12, S22, V25.S[0x2]
    FMLA V16.2S, V4.2S, V12.S[0x1]
    FDIV  V23.8H, V11.8H, V2.8H
    FRSQRTE  V12.4H, V16.4H
    FMUL V22.2D, V1.2D, V10.D[0x1]
    FMULX  V11.2D, V2.2D, V22.2D
    FABS  V2.4S, V11.4S
    FMLS H14, H20, V5.H[0x1]
    FMLA  V4.8H, V11.8H, V23.8H
    FRSQRTE  V29.2S, V4.2S
    FMLA S22, S15, V9.S[0x1]
    FRSQRTS  V17.8H, V29.8H, V29.8H
    FMLA V6.4S, V30.4S, V14.S[0x1]
    FMOV  V15.4H, #-0.84375000
    FADDP  V29.4H, V19.4H, V12.4H
    FDIV  V11.4H, V6.4H, V2.4H
    FDIV  V12.2S, V11.2S, V2.2S
    FMLS  V23.2S, V12.2S, V17.2S
    FMULX V11.2D, V23.2D, V15.D[0x0]
    FSQRT  V23.4H, V26.4H
    FMOV  V15.4S, #0.16406250
    FMOV  V25.4H, #6.75000000
    FACGE  V20.4H, V25.4H, V14.4H
    FADDP  V17.4H, V28.4H, V15.4H
    FMUL D28, D29, V29.D[0x1]
    FRSQRTE  V21.2D, V17.2D
    FMULX V31.2D, V23.2D, V21.D[0x0]
    FSQRT  V26.8H, V15.8H
    FMULX V6.2D, V28.2D, V22.D[0x0]
    FMULX V15.2S, V30.2S, V20.S[0x0]
    FRECPS  V15.8H, V6.8H, V31.8H
    FMUL S31, S31, V0.S[0x1]
    FADD  V20.8H, V11.8H, V11.8H
    FMLS H19, H26, V8.H[0x7]
    FMLS D26, D13, V22.D[0x1]
    FMLA  V29.4S, V28.4S, V3.4S
    FACGE  V17.8H, V1.8H, V4.8H
    FACGT  V30.8H, V29.8H, V15.8H
    FABS  V18.2S, V20.2S
    FMUL V29.4S, V30.4S, V22.S[0x1]
    FRSQRTS  V11.2S, V28.2S, V18.2S
    FMLS S13, S9, V29.S[0x0]
    FACGE  V9.4H, V24.4H, V26.4H
    FADDP  V2.4S, V9.4S, V1.4S
    FMUL H18, H13, V5.H[0x7]
    FMUL  V29.8H, V12.8H, V25.8H
    FACGT  V3.8H, V14.8H, V17.8H
    FMULX S8, S31, V31.S[0x1]
    FADD  V25.2S, V11.2S, V16.2S
    FMULX V31.8H, V6.8H, V11.H[0x3]
    FMULX  V6.8H, V2.8H, V30.8H
    FABD  V26.8H, V8.8H, V19.8H
    FABD  V4.8H, V3.8H, V24.8H
    FMLS S11, S14, V26.S[0x1]
    FMULX  V24.8H, V11.8H, V16.8H
    FRSQRTE  V12.4S, V31.4S
    FMULX H14, H29, V7.H[0x4]
    FRECPE  V20.4H, V5.4H
    FMLA  V5.4H, V25.4H, V18.4H
    FMLS S7, S6, V24.S[0x1]
    FMLS V16.4H, V5.4H, V5.H[0x0]
    FSQRT  V1.8H, V20.8H
    FMLS V5.2D, V18.2D, V7.D[0x0]
    FMOV  V25.4H, #18.00000000
    FMUL V11.2D, V16.2D, V12.D[0x1]
    FABS  V17.4H, V3.4H
    FSUB  V30.4H, V24.4H, V4.4H
    FNEG  V29.2D, V25.2D
    FMULX  V12.4H, V5.4H, V1.4H
    FMLS D16, D15, V29.D[0x1]
    FMUL S29, S21, V10.S[0x1]
    FMUL V26.8H, V20.8H, V8.H[0x7]
    FMUL H9, H24, V11.H[0x4]
    FRSQRTS  V24.4H, V17.4H, V30.4H
    FMULX H24, H13, V12.H[0x2]
    FMOV  V19.8H, #-27.00000000
    FACGE  V13.4H, V26.4H, V9.4H
    FMLA  V18.2D, V16.2D, V29.2D
    FMULX V15.8H, V19.8H, V5.H[0x6]
    FRSQRTE  V30.2D, V13.2D
    FADD  V20.8H, V15.8H, V30.8H
    FRECPE  V8.8H, V25.8H
    FMUL S9, S18, V29.S[0x3]
    FMLS V4.2D, V8.2D, V24.D[0x1]
    FADDP  V30.8H, V9.8H, V18.8H
    FADDP H31, V14.2H
    FMULX H5, H4, V3.H[0x7]
    FRSQRTS  V18.8H, V5.8H, V31.8H
    FSUB  V24.8H, V20.8H, V30.8H
    FABD  V3.8H, V6.8H, V9.8H
    FABD  V12.8H, V27.8H, V28.8H
    FRECPE  V25.4H, V6.4H
    FMLA  V31.8H, V24.8H, V14.8H
    FRSQRTE  V28.2S, V18.2S
    FADD  V26.4S, V11.4S, V0.4S
    FNEG  V16.2D, V21.2D
    FADD  V14.4H, V7.4H, V3.4H
    FMLA H30, H4, V8.H[0x0]
    FMOV  V10.4H, #0.35937500
    FMLA  V3.8H, V25.8H, V14.8H
    FMLA D8, D4, V13.D[0x1]
    FRSQRTS  V9.2D, V29.2D, V26.2D
    FMUL V5.2D, V3.2D, V31.D[0x1]
    FMULX  V3.4S, V28.4S, V16.4S
    FABS  V18.4S, V8.4S
    FMLS V13.4H, V18.4H, V9.H[0x5]
    FMULX D21, D7, V24.D[0x0]
    FNEG  V8.2S, V2.2S
    FSQRT  V18.8H, V5.8H
    FMULX V2.2D, V9.2D, V30.D[0x0]
    FABS  V4.4H, V3.4H
    FSQRT  V14.4H, V12.4H
    FRSQRTS  V28.8H, V30.8H, V14.8H
    FACGE  V31.2S, V8.2S, V21.2S
    FMLA V14.2D, V18.2D, V25.D[0x0]
    FABS  V12.8H, V31.8H
    FMUL S0, S18, V12.S[0x2]
    FRSQRTE  V11.4H, V30.4H
    FADD  V30.4H, V10.4H, V2.4H
    FADD  V28.4H, V14.4H, V18.4H
    FMUL  V26.4H, V13.4H, V30.4H
    FRECPS  V30.8H, V0.8H, V8.8H
    FACGE  V12.8H, V11.8H, V30.8H
    FMUL  V14.8H, V4.8H, V12.8H
    FMULX V21.8H, V25.8H, V14.H[0x7]
    FMUL S11, S7, V3.S[0x3]
    FABS  V9.8H, V11.8H
    FDIV  V16.8H, V9.8H, V21.8H
    FDIV  V30.2S, V28.2S, V16.2S
    FRSQRTS  V16.4S, V20.4S, V30.4S
    FMUL H19, H5, V0.H[0x7]
    FADDP  V21.4H, V3.4H, V4.4H
    FRECPE  V20.2D, V29.2D
    FACGE  V5.8H, V28.8H, V21.8H
    FMLS  V31.8H, V5.8H, V31.8H
    FMLA V28.4H, V19.4H, V6.H[0x2]
    FNEG  V24.4H, V7.4H
    SUBS  X26, X26, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_12
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X6, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X6, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X6, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X6, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X6, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X6, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X6, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X6, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X6, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X6, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X6, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X6, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X6, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X6, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X6, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X6, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X6, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MRS  X15, FPSR
    MOVZ  X6, #0x1f, LSL #0
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V0.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D0
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0x7fff, LSL #16
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V1.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D1
    MOVZ  X6, #0x7c00, LSL #0
    MOVK  X6, #0x7c00, LSL #16
    MOVK  X6, #0x7c00, LSL #32
    MOVK  X6, #0x7c00, LSL #48
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V2.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D2
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0x7fff, LSL #32
    MOVK  X6, #0x7fff, LSL #48
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V3.D[1]
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0xfff0, LSL #48
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D3
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x54b0, LSL #32
    MOVK  X6, #0xc194, LSL #48
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V4.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D4
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x54b0, LSL #32
    MOVK  X6, #0x4194, LSL #48
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V5.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D5
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V6.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D6
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V7.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D7
    MOVZ  X6, #0x7fff, LSL #0
    MOVK  X6, #0x7fff, LSL #16
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V8.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D8
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x8000, LSL #16
    MOVK  X6, #0x8000, LSL #48
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V9.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D9
    MOVZ  X6, #0x7fff, LSL #0
    MOVK  X6, #0x7fff, LSL #16
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V10.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D10
    MOVZ  X6, #0x35c0, LSL #0
    MOVK  X6, #0x35c0, LSL #16
    MOVK  X6, #0x35c0, LSL #32
    MOVK  X6, #0x35c0, LSL #48
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V11.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D11
    MOVZ  X6, #0x7fff, LSL #0
    MOVK  X6, #0x7fff, LSL #16
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V12.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D12
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V13.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D13
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V14.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D14
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V15.D[1]
    MOVZ  X6, #0x8000, LSL #0
    MOVK  X6, #0x8000, LSL #16
    MOVK  X6, #0x8000, LSL #32
    MOVK  X6, #0x8000, LSL #48
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D15
    MOVZ  X6, #0x8000, LSL #0
    MOVK  X6, #0x8000, LSL #16
    MOVK  X6, #0x8000, LSL #32
    MOVK  X6, #0x8000, LSL #48
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x3fc0, LSL #16
    MOVK  X6, #0xfff0, LSL #48
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D16
    MOVZ  X6, #0x7fff, LSL #0
    MOVK  X6, #0x7fff, LSL #16
    MOVK  X6, #0xfff0, LSL #48
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V17.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D17
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V18.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0x7fff, LSL #16
    MOVK  X6, #0x7ff8, LSL #48
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D18
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0x7fff, LSL #16
    MOVK  X6, #0x7ff8, LSL #48
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V19.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D19
    MOVZ  X6, #0xffff, LSL #0
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V20.D[1]
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x7ff0, LSL #48
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D20
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0x7fef, LSL #48
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V21.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D21
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x5483, LSL #16
    MOVK  X6, #0x54dc, LSL #48
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V22.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D22
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V23.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D23
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0x7fff, LSL #32
    MOVK  X6, #0x7fff, LSL #48
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V24.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D24
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0x8000, LSL #32
    MOVK  X6, #0x8000, LSL #48
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V25.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D25
    MOVZ  X6, #0x7c00, LSL #0
    MOVK  X6, #0x7c00, LSL #16
    MOVK  X6, #0x7c00, LSL #32
    MOVK  X6, #0x7c00, LSL #48
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D26
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V27.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D27
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0x7fff, LSL #32
    MOVK  X6, #0x7fff, LSL #48
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V28.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D28
    MOVZ  X6, #0x7fff, LSL #0
    MOVK  X6, #0x7fff, LSL #16
    MOVK  X6, #0x7fff, LSL #32
    MOVK  X6, #0x7fff, LSL #48
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V29.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D29
    MOVZ  X6, #0x7fff, LSL #0
    MOVK  X6, #0x7fff, LSL #16
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V30.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D30
    MOVZ  X6, #0x7fff, LSL #0
    MOVK  X6, #0x7fff, LSL #16
    MOVK  X6, #0x7fff, LSL #32
    MOVK  X6, #0x7fff, LSL #48
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, V31.D[1]
    MOVZ  X6, #0x7fff, LSL #0
    MOVK  X6, #0x7fff, LSL #16
    MOVK  X6, #0x7fff, LSL #32
    MOVK  X6, #0x7fff, LSL #48
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X15, D31
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
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
    FMOV  D0, X29
    FMOV  V0.D[1], X25
    FMOV  D1, X26
    FMOV  V1.D[1], X12
    FMOV  D2, X28
    FMOV  V2.D[1], X25
    FMOV  D3, X27
    FMOV  V3.D[1], X13
    FMOV  D4, X12
    FMOV  V4.D[1], X17
    FMOV  D5, X10
    FMOV  V5.D[1], X26
    FMOV  D6, X29
    FMOV  V6.D[1], X2
    FMOV  D7, X11
    FMOV  V7.D[1], X5
    FMOV  D8, X3
    FMOV  V8.D[1], X11
    FMOV  D9, X10
    FMOV  V9.D[1], X3
    FMOV  D10, X25
    FMOV  V10.D[1], X16
    FMOV  D11, X2
    FMOV  V11.D[1], X4
    FMOV  D12, X15
    FMOV  V12.D[1], X13
    FMOV  D13, X25
    FMOV  V13.D[1], X11
    FMOV  D14, X27
    FMOV  V14.D[1], X7
    FMOV  D15, X24
    FMOV  V15.D[1], X28
    FMOV  D16, X26
    FMOV  V16.D[1], X28
    FMOV  D17, X8
    FMOV  V17.D[1], X4
    FMOV  D18, X23
    FMOV  V18.D[1], X5
    FMOV  D19, X23
    FMOV  V19.D[1], X6
    FMOV  D20, X24
    FMOV  V20.D[1], X2
    FMOV  D21, X7
    FMOV  V21.D[1], X10
    FMOV  D22, X17
    FMOV  V22.D[1], X26
    FMOV  D23, X9
    FMOV  V23.D[1], X2
    FMOV  D24, X23
    FMOV  V24.D[1], X10
    FMOV  D25, X13
    FMOV  V25.D[1], X25
    FMOV  D26, X11
    FMOV  V26.D[1], X7
    FMOV  D27, X25
    FMOV  V27.D[1], X14
    FMOV  D28, X12
    FMOV  V28.D[1], X3
    FMOV  D29, X6
    FMOV  V29.D[1], X3
    FMOV  D30, X6
    FMOV  V30.D[1], X23
    FMOV  D31, X26
    FMOV  V31.D[1], X11
    MOVZ  X25, #0xa, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_13:
    FMUL V10.2D, V15.2D, V5.D[0x0]
    FSQRT  V3.2D, V4.2D
    FMULX  V2.2D, V3.2D, V26.2D
    FMLS D20, D24, V25.D[0x0]
    FRSQRTE  V9.2S, V29.2S
    FMLS D4, D30, V2.D[0x1]
    FMLS  V13.2D, V4.2D, V31.2D
    FMLA S15, S10, V9.S[0x2]
    FMULX V23.8H, V22.8H, V14.H[0x2]
    FRSQRTE  V26.2D, V20.2D
    FMULX H29, H15, V13.H[0x4]
    FMUL D26, D27, V29.D[0x1]
    FADDP  V22.2S, V29.2S, V26.2S
    FABD  V25.4H, V18.4H, V28.4H
    FDIV  V31.4H, V25.4H, V9.4H
    FMLA  V28.4H, V6.4H, V25.4H
    FADD  V29.4H, V28.4H, V22.4H
    FNEG  V3.8H, V2.8H
    FACGE  V27.2D, V23.2D, V31.2D
    FACGT  V30.4S, V27.4S, V3.4S
    FSUB  V12.2D, V17.2D, V8.2D
    FMLA V15.2S, V9.2S, V10.S[0x3]
    FABD  V15.2D, V16.2D, V6.2D
    FSUB  V6.2D, V17.2D, V18.2D
    FACGE  V31.2D, V0.2D, V22.2D
    FNEG  V4.2D, V13.2D
    FACGT  V10.2D, V31.2D, V26.2D
    FDIV  V13.2D, V9.2D, V28.2D
    FMLA V27.4S, V7.4S, V2.S[0x3]
    FMLS  V9.4H, V23.4H, V30.4H
    FMULX V31.8H, V6.8H, V13.H[0x6]
    FADD  V30.8H, V10.8H, V15.8H
    FACGE  V3.4H, V9.4H, V9.4H
    FMUL V28.2D, V29.2D, V29.D[0x0]
    FMLS  V23.2S, V30.2S, V27.2S
    FSQRT  V3.8H, V2.8H
    FNEG  V18.2S, V25.2S
    FRECPS  V26.8H, V24.8H, V18.8H
    FMOV  V9.2S, #0.78125000
    FMOV  V15.4S, #-0.62500000
    FRECPE  V10.4H, V26.4H
    FMLS S25, S12, V3.S[0x0]
    FMLS V2.2D, V7.2D, V3.D[0x0]
    FMLA V13.8H, V31.8H, V4.H[0x6]
    FMLS  V27.8H, V10.8H, V15.8H
    FSUB  V19.2S, V9.2S, V9.2S
    FADDP  V17.4S, V19.4S, V11.4S
    FABS  V24.4S, V25.4S
    FABD  V26.4H, V30.4H, V13.4H
    FSQRT  V6.4H, V29.4H
    FNEG  V30.4H, V17.4H
    FMLA V29.4H, V24.4H, V2.H[0x4]
    FNEG  V7.2S, V0.2S
    FRSQRTE  V25.4S, V26.4S
    FADDP D26, V14.2D
    FMUL  V3.4H, V14.4H, V12.4H
    FMLA V15.4S, V3.4S, V29.S[0x3]
    FRSQRTS  V1.2D, V30.2D, V6.2D
    FADDP D17, V15.2D
    FRSQRTS  V11.8H, V17.8H, V1.8H
    FMOV  V17.4H, #-0.14843750
    FMLA  V24.2D, V26.2D, V11.2D
    FMLS V18.2D, V24.2D, V27.D[0x1]
    FADDP D27, V25.2D
    FRECPE  V2.8H, V19.8H
    FMLA D13, D27, V2.D[0x1]
    FRSQRTE  V26.4H, V0.4H
    FMLS V15.4S, V18.4S, V17.S[0x1]
    FMULX  V0.2D, V13.2D, V26.2D
    FRECPS  V25.8H, V7.8H, V19.8H
    FACGE  V30.4H, V22.4H, V22.4H
    FNEG  V11.8H, V12.8H
    FMOV  V3.8H, #1.93750000
    FMULX V29.4H, V15.4H, V0.H[0x6]
    FMUL V14.2S, V25.2S, V13.S[0x2]
    FMUL H0, H14, V3.H[0x3]
    FMLS V24.4S, V29.4S, V29.S[0x3]
    FMLS  V22.4S, V30.4S, V0.4S
    FMUL V6.4H, V24.4H, V11.H[0x7]
    FMUL  V27.2S, V30.2S, V21.2S
    FMULX V30.2D, V5.2D, V7.D[0x0]
    FNEG  V29.8H, V25.8H
    FMLS D3, D23, V28.D[0x1]
    FMULX V17.2D, V9.2D, V6.D[0x1]
    FADDP D17, V0.2D
    FMLA H14, H9, V15.H[0x6]
    FMUL  V18.4H, V13.4H, V10.4H
    FMLS H9, H4, V11.H[0x2]
    FADDP S15, V3.2S
    FMULX  V2.2D, V14.2D, V14.2D
    FADD  V25.2S, V2.2S, V27.2S
    FMULX V17.4H, V18.4H, V2.H[0x6]
    FRSQRTS  V23.4S, V21.4S, V29.4S
    FABS  V26.8H, V22.8H
    FACGT  V27.2S, V17.2S, V1.2S
    FMLS V2.4S, V23.4S, V27.S[0x3]
    FMULX H11, H25, V0.H[0x7]
    FMLS H28, H30, V14.H[0x6]
    FACGE  V10.2D, V15.2D, V9.2D
    FADD  V5.4S, V26.4S, V11.4S
    FMUL V13.4S, V0.4S, V10.S[0x1]
    FMLA  V4.4S, V5.4S, V2.4S
    FACGT  V11.4S, V29.4S, V29.4S
    FMOV  V15.2D, #-0.22656250
    FADDP D26, V30.2D
    FMLA V31.4H, V16.4H, V13.H[0x3]
    FMULX V1.2S, V31.2S, V15.S[0x1]
    FACGT  V14.4H, V28.4H, V1.4H
    FMLA V5.2D, V11.2D, V22.D[0x0]
    FMLS  V31.8H, V25.8H, V26.8H
    FRECPS  V0.4H, V2.4H, V14.4H
    FMLS V15.4S, V31.4S, V5.S[0x3]
    FSUB  V6.4S, V15.4S, V4.4S
    FACGE  V18.8H, V23.8H, V8.8H
    FMLS H21, H4, V8.H[0x3]
    FADDP  V30.8H, V17.8H, V5.8H
    FRSQRTE  V10.4H, V24.4H
    FRECPS  V13.2D, V13.2D, V30.2D
    FNEG  V17.2S, V4.2S
    FMLA S30, S26, V11.S[0x1]
    FMLA  V28.2D, V11.2D, V9.2D
    FADDP S22, V6.2S
    FMUL H31, H26, V11.H[0x0]
    FADD  V29.2S, V8.2S, V24.2S
    FMUL V9.2S, V29.2S, V31.S[0x3]
    FMUL H31, H23, V9.H[0x6]
    FMLA S24, S28, V22.S[0x3]
    FADD  V28.2S, V19.2S, V30.2S
    FMULX S4, S21, V11.S[0x3]
    FMLS  V20.4H, V5.4H, V4.4H
    FMLS  V9.2D, V6.2D, V10.2D
    FMUL V6.4S, V31.4S, V28.S[0x3]
    FDIV  V19.4S, V13.4S, V20.4S
    FABD  V23.4H, V24.4H, V11.4H
    FMULX V11.4S, V8.4S, V17.S[0x2]
    FMLS  V26.4H, V6.4H, V19.4H
    FMUL  V4.8H, V9.8H, V23.8H
    FSQRT  V30.2D, V26.2D
    FMULX  V23.4H, V30.4H, V0.4H
    FRSQRTS  V21.4S, V12.4S, V23.4S
    FMLS D28, D4, V4.D[0x1]
    FMULX V4.4H, V11.4H, V15.H[0x5]
    FMLS  V11.8H, V21.8H, V21.8H
    FDIV  V8.2S, V4.2S, V25.2S
    FRSQRTS  V10.4S, V6.4S, V8.4S
    FABS  V10.4H, V11.4H
    FMUL H9, H29, V10.H[0x5]
    FMLA V6.8H, V25.8H, V4.H[0x7]
    FRSQRTE  V20.8H, V7.8H
    FADDP S15, V6.2S
    FMULX  V19.4H, V30.4H, V26.4H
    FACGE  V8.8H, V6.8H, V29.8H
    FADD  V10.2S, V0.2S, V16.2S
    FMLS V6.8H, V1.8H, V10.H[0x6]
    FACGE  V21.4H, V7.4H, V4.4H
    FDIV  V26.2S, V30.2S, V1.2S
    FMULX V25.2S, V11.2S, V28.S[0x3]
    FACGE  V30.4S, V4.4S, V9.4S
    FMUL  V11.4H, V30.4H, V12.4H
    FMUL H15, H26, V11.H[0x4]
    FMUL V23.4S, V8.4S, V8.S[0x3]
    FABS  V6.2S, V20.2S
    FABS  V7.4S, V25.4S
    FADDP D10, V23.2D
    FSQRT  V20.2D, V10.2D
    FRSQRTS  V28.2D, V7.2D, V19.2D
    FMLA  V12.4H, V28.4H, V20.4H
    FACGT  V10.2S, V21.2S, V2.2S
    FADDP D4, V10.2D
    FSUB  V21.4H, V15.4H, V4.4H
    FADD  V8.8H, V16.8H, V21.8H
    FABD  V20.8H, V8.8H, V6.8H
    FRECPS  V30.2D, V16.2D, V29.2D
    FMULX  V23.4H, V30.4H, V30.4H
    FMUL V28.4H, V5.4H, V5.H[0x6]
    FMLS V25.2D, V27.2D, V19.D[0x0]
    FRECPS  V7.2S, V0.2S, V4.2S
    FMOV  V8.4S, #1.06250000
    FMULX  V5.2S, V4.2S, V13.2S
    FMLA V11.4H, V13.4H, V9.H[0x1]
    FSUB  V27.4H, V2.4H, V25.4H
    FSQRT  V6.4H, V0.4H
    FDIV  V19.2S, V11.2S, V11.2S
    FABS  V11.8H, V19.8H
    FMLA V9.2D, V20.2D, V23.D[0x0]
    FMUL V4.4H, V8.4H, V11.H[0x6]
    FMULX V20.2D, V28.2D, V9.D[0x0]
    FMULX H11, H12, V7.H[0x4]
    FMULX H7, H3, V1.H[0x0]
    FRSQRTS  V13.4H, V4.4H, V15.4H
    FRECPS  V10.4H, V20.4H, V26.4H
    FABS  V7.4S, V7.4S
    FABD  V27.2S, V13.2S, V6.2S
    FDIV  V12.4H, V11.4H, V19.4H
    FMOV  V6.4S, #-20.00000000
    FSQRT  V13.2D, V12.2D
    FRSQRTS  V2.4H, V29.4H, V6.4H
    FADDP  V0.8H, V5.8H, V10.8H
    FMULX S9, S4, V10.S[0x0]
    FADD  V3.8H, V9.8H, V8.8H
    SUBS  X25, X25, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_13
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X10, X24, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MRS  X24, FPSR
    MOVZ  X10, #0x1f, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V0.D[1]
    MOVZ  X10, #0x7fff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D0
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V1.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D1
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0x7fff, LSL #16
    MOVK  X10, #0x7fff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V2.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D2
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0x7fff, LSL #16
    MOVK  X10, #0x7fff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V3.D[1]
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x3f88, LSL #16
    MOVK  X10, #0x3f88, LSL #48
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D3
    MOVZ  X10, #0x7fff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0x3f88, LSL #48
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D4
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D5
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0x7fff, LSL #48
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xc1a0, LSL #16
    MOVK  X10, #0xc1a0, LSL #48
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D6
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xc1a0, LSL #16
    MOVK  X10, #0xc1a0, LSL #48
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D7
    MOVZ  X10, #0xffff, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V8.D[1]
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x3f88, LSL #16
    MOVK  X10, #0x3f88, LSL #48
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D8
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x3f88, LSL #16
    MOVK  X10, #0x3f88, LSL #48
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D9
    MOVZ  X10, #0x7fff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V10.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D10
    MOVZ  X10, #0x7fff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V11.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D11
    MOVZ  X10, #0xffff, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V12.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D12
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0x7fff, LSL #16
    MOVK  X10, #0x7fff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V13.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D13
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0x7fff, LSL #16
    MOVK  X10, #0x7fff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D14
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D15
    MOVZ  X10, #0xffff, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V16.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D16
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D17
    MOVZ  X10, #0x7fff, LSL #0
    MOVK  X10, #0x7fff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0x7fff, LSL #48
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V18.D[1]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D18
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D19
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0x7fff, LSL #16
    MOVK  X10, #0x7fff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X10, #0x7fff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0x7fff, LSL #48
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D20
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0x7fff, LSL #16
    MOVK  X10, #0x7fff, LSL #32
    MOVK  X10, #0x7fff, LSL #48
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V21.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D21
    MOVZ  X10, #0xffff, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V22.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D22
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V23.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D23
    MOVZ  X10, #0x7fff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0x7fff, LSL #48
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V24.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D24
    MOVZ  X10, #0x7fff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V25.D[1]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0x7fff, LSL #48
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D25
    MOVZ  X10, #0x7fff, LSL #0
    MOVK  X10, #0x7fff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V26.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D26
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0x7fff, LSL #48
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D27
    MOVZ  X10, #0x7fff, LSL #0
    MOVK  X10, #0x7fff, LSL #16
    MOVK  X10, #0x7cb0, LSL #32
    MOVK  X10, #0x3d30, LSL #48
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D28
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0x7fff, LSL #16
    MOVK  X10, #0x7fff, LSL #32
    MOVK  X10, #0x7fff, LSL #48
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V29.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D29
    MOVZ  X10, #0x7fff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0x7fff, LSL #48
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V30.D[1]
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x4000, LSL #48
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D30
    MOVZ  X10, #0x7fff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0x7fff, LSL #48
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, V31.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X24, D31
    MOVZ  X10, #0xffff, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
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
    FMOV  V0.D[1], X29
    FMOV  D1, X12
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X16
    FMOV  D3, X24
    FMOV  V3.D[1], X25
    FMOV  D4, X9
    FMOV  V4.D[1], X12
    FMOV  D5, X13
    FMOV  V5.D[1], X11
    FMOV  D6, X17
    FMOV  V6.D[1], X15
    FMOV  D7, X4
    FMOV  V7.D[1], X8
    FMOV  D8, X23
    FMOV  V8.D[1], X24
    FMOV  D9, X24
    FMOV  V9.D[1], X8
    FMOV  D10, X7
    FMOV  V10.D[1], X2
    FMOV  D11, X25
    FMOV  V11.D[1], X28
    FMOV  D12, X6
    FMOV  V12.D[1], X8
    FMOV  D13, X14
    FMOV  V13.D[1], X3
    FMOV  D14, X12
    FMOV  V14.D[1], X27
    FMOV  D15, X14
    FMOV  V15.D[1], X9
    FMOV  D16, X12
    FMOV  V16.D[1], X8
    FMOV  D17, X3
    FMOV  V17.D[1], X2
    FMOV  D18, X9
    FMOV  V18.D[1], X24
    FMOV  D19, X27
    FMOV  V19.D[1], X10
    FMOV  D20, X11
    FMOV  V20.D[1], X11
    FMOV  D21, X10
    FMOV  V21.D[1], X23
    FMOV  D22, X8
    FMOV  V22.D[1], X14
    FMOV  D23, X7
    FMOV  V23.D[1], X11
    FMOV  D24, X16
    FMOV  V24.D[1], X5
    FMOV  D25, X14
    FMOV  V25.D[1], X14
    FMOV  D26, X5
    FMOV  V26.D[1], X13
    FMOV  D27, X29
    FMOV  V27.D[1], X17
    FMOV  D28, X23
    FMOV  V28.D[1], X7
    FMOV  D29, X23
    FMOV  V29.D[1], X2
    FMOV  D30, X8
    FMOV  V30.D[1], X29
    FMOV  D31, X17
    FMOV  V31.D[1], X28
    MOVZ  X13, #0xa, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_14:
    FMLA S7, S28, V24.S[0x2]
    FNEG  V4.8H, V28.8H
    FRSQRTS  V12.4S, V22.4S, V29.4S
    FSUB  V0.8H, V30.8H, V14.8H
    FSUB  V6.2D, V23.2D, V14.2D
    FMLA D31, D6, V15.D[0x0]
    FMUL  V18.4S, V16.4S, V22.4S
    FABS  V0.2S, V8.2S
    FADDP H4, V3.2H
    FMLA V21.4H, V0.4H, V11.H[0x5]
    FMLS H8, H17, V10.H[0x6]
    FADDP H26, V18.2H
    FMUL  V16.8H, V21.8H, V8.8H
    FMUL  V29.8H, V16.8H, V12.8H
    FMOV  V23.2D, #1.00000000
    FSUB  V0.2D, V4.2D, V0.2D
    FNEG  V26.2D, V9.2D
    FMLS S11, S31, V31.S[0x2]
    FMOV  V15.2D, #0.39062500
    FMULX V22.4H, V11.4H, V6.H[0x1]
    FMUL H31, H29, V7.H[0x7]
    FMULX V27.2S, V31.2S, V15.S[0x3]
    FRSQRTE  V9.4H, V23.4H
    FMULX  V4.8H, V9.8H, V27.8H
    FMLA D11, D15, V21.D[0x1]
    FMUL S14, S29, V11.S[0x2]
    FMLS D9, D0, V5.D[0x1]
    FADDP D16, V9.2D
    FSQRT  V30.8H, V14.8H
    FMLS S23, S30, V4.S[0x2]
    FMLA S3, S17, V10.S[0x2]
    FABS  V9.2S, V16.2S
    FACGE  V29.8H, V28.8H, V22.8H
    FMULX V14.4H, V9.4H, V3.H[0x5]
    FMUL  V25.2D, V6.2D, V29.2D
    FSUB  V1.2D, V25.2D, V26.2D
    FADDP  V21.2D, V1.2D, V5.2D
    FABS  V28.2D, V10.2D
    FDIV  V12.2D, V3.2D, V28.2D
    FMUL H27, H0, V12.H[0x7]
    FADDP S0, V18.2S
    FMUL V22.2S, V21.2S, V11.S[0x1]
    FADD  V26.4H, V0.4H, V21.4H
    FMOV  V18.8H, #0.25000000
    FMLS V14.4S, V17.4S, V22.S[0x3]
    FSUB  V7.8H, V26.8H, V16.8H
    FMLS  V14.8H, V18.8H, V27.8H
    FABD  V13.2S, V14.2S, V31.2S
    FABD  V11.2D, V1.2D, V5.2D
    FACGT  V31.4H, V15.4H, V29.4H
    FRSQRTE  V26.4H, V31.4H
    FDIV  V27.2D, V22.2D, V7.2D
    FSUB  V21.2S, V26.2S, V26.2S
    FMUL S9, S26, V13.S[0x3]
    FRECPS  V15.4H, V16.4H, V11.4H
    FMLA S1, S21, V23.S[0x1]
    FMOV  V30.2D, #-0.28125000
    FADDP D10, V7.2D
    FADD  V26.2D, V9.2D, V27.2D
    FMULX V0.8H, V10.8H, V12.H[0x2]
    FACGT  V1.4S, V1.4S, V27.4S
    FACGE  V18.2D, V1.2D, V0.2D
    FDIV  V16.8H, V15.8H, V12.8H
    FMUL V27.8H, V26.8H, V14.H[0x2]
    FMULX V1.4H, V26.4H, V8.H[0x1]
    FMLS S8, S16, V18.S[0x0]
    FMUL S21, S31, V27.S[0x0]
    FMLA  V27.8H, V4.8H, V12.8H
    FMLA V11.4S, V30.4S, V1.S[0x0]
    FRECPE  V7.8H, V9.8H
    FMULX S30, S7, V27.S[0x3]
    FMLS V14.4H, V5.4H, V6.H[0x5]
    FABD  V4.4S, V30.4S, V29.4S
    FMULX  V0.2S, V14.2S, V8.2S
    FMUL D26, D11, V31.D[0x0]
    FADD  V21.4S, V8.4S, V4.4S
    FMULX  V10.8H, V0.8H, V28.8H
    FNEG  V31.8H, V22.8H
    FMOV  V27.2D, #-1.93750000
    FMLA D19, D10, V21.D[0x1]
    FADDP H7, V23.2H
    FMOV  V25.2S, #0.15625000
    FMLA H29, H27, V7.H[0x6]
    FADDP  V5.2S, V26.2S, V19.2S
    FSQRT  V19.8H, V29.8H
    FRSQRTE  V9.4S, V19.4S
    FMLS V12.8H, V7.8H, V9.H[0x7]
    FACGT  V3.2S, V31.2S, V31.2S
    FMULX S8, S25, V5.S[0x3]
    FMOV  V5.2S, #-0.17968750
    FSQRT  V23.4H, V22.4H
    FMLS  V27.4H, V26.4H, V1.4H
    FABD  V0.4H, V27.4H, V23.4H
    FMUL  V31.4H, V5.4H, V8.4H
    FMOV  V19.4H, #-0.46875000
    FMLA S21, S0, V15.S[0x3]
    FADDP D29, V28.2D
    FMLS V27.8H, V29.8H, V3.H[0x6]
    FMLA  V22.8H, V19.8H, V19.8H
    FACGT  V0.4S, V22.4S, V23.4S
    FACGE  V29.8H, V2.8H, V27.8H
    FMULX V6.2D, V14.2D, V12.D[0x0]
    FRECPE  V3.4S, V1.4S
    FABS  V5.8H, V6.8H
    FRECPS  V14.2D, V3.2D, V11.2D
    FMLA H6, H29, V4.H[0x1]
    FMUL V8.2S, V6.2S, V22.S[0x1]
    FACGE  V12.2D, V8.2D, V12.2D
    FADD  V8.4H, V0.4H, V0.4H
    FRSQRTE  V6.4H, V8.4H
    FMULX D11, D31, V12.D[0x1]
    FMUL V22.2S, V6.2S, V6.S[0x3]
    FADD  V6.8H, V18.8H, V5.8H
    FMULX V28.2D, V28.2D, V14.D[0x1]
    FMLA  V15.4S, V5.4S, V6.4S
    FRECPE  V19.2S, V24.2S
    FMULX V4.8H, V22.8H, V0.H[0x4]
    FADDP  V5.4H, V17.4H, V13.4H
    FMLA  V0.2D, V29.2D, V5.2D
    FRECPS  V8.4H, V22.4H, V11.4H
    FNEG  V11.2S, V0.2S
    FMUL V6.4S, V28.4S, V11.S[0x3]
    FMUL H0, H5, V8.H[0x2]
    FMLA V18.4S, V15.4S, V4.S[0x1]
    FMOV  V27.8H, #14.00000000
    FABS  V1.4H, V19.4H
    FADDP S31, V18.2S
    FMUL  V27.8H, V29.8H, V31.8H
    FSUB  V2.8H, V22.8H, V0.8H
    FMLA  V28.4H, V3.4H, V31.4H
    FMLS  V13.2S, V21.2S, V1.2S
    FMULX V19.4S, V27.4S, V6.S[0x1]
    FMOV  V18.2S, #-5.50000000
    FMUL D31, D2, V13.D[0x1]
    FRECPS  V15.8H, V6.8H, V28.8H
    FADD  V27.4S, V18.4S, V19.4S
    FADDP H0, V19.2H
    FMULX V24.2D, V15.2D, V23.D[0x0]
    FMULX V5.8H, V31.8H, V3.H[0x7]
    FMOV  V15.4S, #-0.75000000
    FACGT  V1.4H, V27.4H, V24.4H
    FMLA D18, D1, V0.D[0x0]
    FMUL  V24.4S, V14.4S, V25.4S
    FMULX S6, S15, V28.S[0x3]
    FMULX D14, D5, V31.D[0x0]
    FMLA S3, S18, V14.S[0x1]
    FDIV  V29.8H, V3.8H, V4.8H
    FMLS H28, H6, V13.H[0x7]
    FRECPS  V15.2S, V28.2S, V24.2S
    FACGT  V3.8H, V9.8H, V2.8H
    FMULX D6, D31, V28.D[0x0]
    FMLS H20, H15, V9.H[0x5]
    FABD  V22.2S, V12.2S, V16.2S
    FMOV  V25.8H, #0.22656250
    FRSQRTS  V27.4S, V27.4S, V12.4S
    FMLA  V21.4H, V11.4H, V19.4H
    FACGE  V4.2D, V9.2D, V5.2D
    FACGE  V23.4S, V22.4S, V21.4S
    FADDP H2, V29.2H
    FRSQRTE  V21.2D, V2.2D
    FMULX  V29.2S, V25.2S, V24.2S
    FMLS V1.4H, V12.4H, V3.H[0x0]
    FMLS V2.4S, V1.4S, V16.S[0x1]
    FABS  V0.4S, V23.4S
    FMUL V13.8H, V4.8H, V6.H[0x5]
    FNEG  V24.4H, V13.4H
    FSQRT  V19.4H, V18.4H
    FMUL V11.4S, V26.4S, V21.S[0x2]
    FMULX  V22.2D, V2.2D, V30.2D
    FABS  V21.4S, V29.4S
    FACGT  V26.8H, V21.8H, V27.8H
    FADDP  V2.2S, V24.2S, V25.2S
    FSUB  V24.2S, V22.2S, V2.2S
    FRECPS  V28.8H, V24.8H, V24.8H
    FABS  V16.8H, V23.8H
    FRSQRTS  V23.8H, V26.8H, V19.8H
    FMLA H13, H11, V3.H[0x7]
    FABD  V30.4H, V5.4H, V0.4H
    FMLS  V12.4S, V9.4S, V13.4S
    FACGE  V3.2D, V28.2D, V30.2D
    FADD  V30.2D, V1.2D, V11.2D
    FMLA V22.4H, V12.4H, V12.H[0x1]
    FMULX V27.4H, V30.4H, V11.H[0x7]
    FMLS D9, D16, V7.D[0x0]
    FMLS  V5.4H, V27.4H, V19.4H
    FMLS H30, H14, V5.H[0x2]
    FMLS  V18.2S, V9.2S, V16.2S
    FMLS V14.2D, V24.2D, V14.D[0x1]
    FMLA D24, D23, V18.D[0x1]
    FADD  V13.2S, V22.2S, V30.2S
    FMULX V26.2D, V13.2D, V8.D[0x0]
    FRSQRTE  V25.4S, V3.4S
    FMULX H29, H26, V14.H[0x6]
    FMLA V9.8H, V16.8H, V10.H[0x6]
    FADDP  V3.2D, V29.2D, V23.2D
    FRSQRTE  V11.2D, V3.2D
    FRSQRTE  V12.2D, V7.2D
    FMLS S28, S17, V13.S[0x0]
    FMULX V5.2D, V22.2D, V24.D[0x1]
    FSQRT  V14.4S, V22.4S
    SUBS  X13, X13, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_14
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X27, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X27, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X27, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X27, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X27, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X27, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X27, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X27, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X27, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X27, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X27, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X27, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X27, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X27, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X27, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X27, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X27, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X27, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MRS  X12, FPSR
    MOVZ  X27, #0x1f, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V0.D[1]
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0x7fff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0x7fff, LSL #48
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D0
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V1.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D1
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D2
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x8001, LSL #16
    MOVK  X27, #0x3340, LSL #32
    MOVK  X27, #0x33c0, LSL #48
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X27, #0x3e00, LSL #0
    MOVK  X27, #0x7e00, LSL #16
    MOVK  X27, #0x3e00, LSL #32
    MOVK  X27, #0x7e00, LSL #48
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D3
    MOVZ  X27, #0xffff, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D4
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D5
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0x7fff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0x7fff, LSL #48
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D6
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D7
    MOVZ  X27, #0xffff, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D8
    MOVZ  X27, #0x4000, LSL #0
    MOVK  X27, #0x4000, LSL #16
    MOVK  X27, #0x4000, LSL #32
    MOVK  X27, #0x4000, LSL #48
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X27, #0x7fff, LSL #0
    MOVK  X27, #0x7fff, LSL #16
    MOVK  X27, #0x7fff, LSL #32
    MOVK  X27, #0x7fff, LSL #48
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D9
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x7f80, LSL #16
    MOVK  X27, #0x7f80, LSL #48
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X27, #0x8000, LSL #0
    MOVK  X27, #0x8000, LSL #16
    MOVK  X27, #0x8000, LSL #32
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D10
    MOVZ  X27, #0x7fff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0x7fff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x8000, LSL #32
    MOVK  X27, #0x20e6, LSL #48
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D11
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x6100, LSL #48
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V12.D[1]
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x7ff0, LSL #48
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D12
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x6100, LSL #48
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D13
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0x7fff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0x7fff, LSL #48
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D14
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0x7fff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0x7fff, LSL #48
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D15
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0x7fff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X27, #0x7fff, LSL #0
    MOVK  X27, #0x7fff, LSL #16
    MOVK  X27, #0x7fff, LSL #32
    MOVK  X27, #0x7fff, LSL #48
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D16
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D17
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D18
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x7fc0, LSL #16
    MOVK  X27, #0x7fc0, LSL #48
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D19
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x7e00, LSL #16
    MOVK  X27, #0x7e00, LSL #48
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D20
    MOVZ  X27, #0x7fff, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D21
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0x7fff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0x7fff, LSL #48
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D22
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0x7fff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0x7fff, LSL #48
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X27, #0x3e00, LSL #0
    MOVK  X27, #0x3e00, LSL #16
    MOVK  X27, #0x3e00, LSL #32
    MOVK  X27, #0x3e00, LSL #48
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D23
    MOVZ  X27, #0x3e00, LSL #0
    MOVK  X27, #0x7e00, LSL #16
    MOVK  X27, #0x3e00, LSL #32
    MOVK  X27, #0x7e00, LSL #48
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D24
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0x7fff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0x7fff, LSL #48
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D25
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x7f80, LSL #16
    MOVK  X27, #0x7f80, LSL #48
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D26
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0x7fff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0x7fff, LSL #48
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D27
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0x7fff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0x7fff, LSL #48
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D28
    MOVZ  X27, #0x7fff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D29
    MOVZ  X27, #0xffff, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V30.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D30
    MOVZ  X27, #0xffff, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, V31.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    FMOV  X12, D31
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail

TSRTAdvsimdVectorFloatingPointOperation_TestEnd:
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
TSRTAdvsimdVectorFloatingPointOperation_TestFail:
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
