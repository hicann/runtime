.global AdvsimdLoadDeprecatedP01

.text
.p2align 4

AdvsimdLoadDeprecatedP01:

AdvsimdLoadDeprecatedP01_TestBegin:
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
    MOVZ  X3, #0xd94b, LSL #0
    MOVK  X3, #0xbf21, LSL #16
    MOVK  X3, #0xc46c, LSL #32
    MOVK  X3, #0xd738, LSL #48
    MOVZ  X8, #0x468e, LSL #0
    MOVK  X8, #0x5185, LSL #16
    MOVK  X8, #0x22d2, LSL #32
    MOVK  X8, #0xe31e, LSL #48
    MOVZ  X9, #0xb6a0, LSL #0
    MOVK  X9, #0x2352, LSL #16
    MOVK  X9, #0xfd56, LSL #32
    MOVK  X9, #0xe24e, LSL #48
    MOVZ  X10, #0x9a2e, LSL #0
    MOVK  X10, #0x88ad, LSL #16
    MOVK  X10, #0x71c1, LSL #32
    MOVK  X10, #0xcd53, LSL #48
    MOVZ  X11, #0x445a, LSL #0
    MOVK  X11, #0x1b11, LSL #16
    MOVK  X11, #0xd583, LSL #32
    MOVK  X11, #0xd718, LSL #48
    MOVZ  X12, #0x39d1, LSL #0
    MOVK  X12, #0x5e99, LSL #16
    MOVK  X12, #0x805c, LSL #32
    MOVK  X12, #0x802a, LSL #48
    MOVZ  X13, #0x70e7, LSL #0
    MOVK  X13, #0x10c, LSL #16
    MOVK  X13, #0x8f6c, LSL #32
    MOVK  X13, #0x7aa3, LSL #48
    MOVZ  X14, #0x4d8e, LSL #0
    MOVK  X14, #0xd5d1, LSL #16
    MOVK  X14, #0x462d, LSL #32
    MOVK  X14, #0x5408, LSL #48
    MOVZ  X15, #0x8885, LSL #0
    MOVK  X15, #0xe7a3, LSL #16
    MOVK  X15, #0x42ff, LSL #32
    MOVK  X15, #0xf80a, LSL #48
    MOVZ  X16, #0xcb6c, LSL #0
    MOVK  X16, #0x12d3, LSL #16
    MOVK  X16, #0x7473, LSL #32
    MOVK  X16, #0x5230, LSL #48
    MOVZ  X17, #0x25b, LSL #0
    MOVK  X17, #0xfa8c, LSL #16
    MOVK  X17, #0xb4a4, LSL #32
    MOVK  X17, #0xdd43, LSL #48
    MOVZ  X18, #0x160c, LSL #0
    MOVK  X18, #0x84b1, LSL #16
    MOVK  X18, #0xe5c4, LSL #32
    MOVK  X18, #0x8038, LSL #48
    MOVZ  X19, #0x778d, LSL #0
    MOVK  X19, #0x713d, LSL #16
    MOVK  X19, #0xfcf4, LSL #32
    MOVK  X19, #0x2c51, LSL #48
    MOVZ  X20, #0xa122, LSL #0
    MOVK  X20, #0x59b8, LSL #16
    MOVK  X20, #0xb7d3, LSL #32
    MOVK  X20, #0xe327, LSL #48
    MOVZ  X21, #0xb486, LSL #0
    MOVK  X21, #0x9f0a, LSL #16
    MOVK  X21, #0x933d, LSL #32
    MOVK  X21, #0x3a1d, LSL #48
    MOVZ  X22, #0xe981, LSL #0
    MOVK  X22, #0x8d9e, LSL #16
    MOVK  X22, #0x23a7, LSL #32
    MOVK  X22, #0x293e, LSL #48
    MOVZ  X23, #0xfb76, LSL #0
    MOVK  X23, #0x4883, LSL #16
    MOVK  X23, #0x11d8, LSL #32
    MOVK  X23, #0xaa66, LSL #48
    MOVZ  X24, #0x72f4, LSL #0
    MOVK  X24, #0x4519, LSL #16
    MOVK  X24, #0xcdca, LSL #32
    MOVK  X24, #0x84be, LSL #48
    MOVZ  X25, #0xfcc7, LSL #0
    MOVK  X25, #0xb486, LSL #16
    MOVK  X25, #0xca98, LSL #32
    MOVK  X25, #0x975f, LSL #48
    MOVZ  X26, #0xc23b, LSL #0
    MOVK  X26, #0x65b3, LSL #16
    MOVK  X26, #0x485e, LSL #32
    MOVK  X26, #0xebf1, LSL #48
    MOVZ  X27, #0xd3ad, LSL #0
    MOVK  X27, #0x7518, LSL #16
    MOVK  X27, #0x4b72, LSL #32
    MOVK  X27, #0xba2f, LSL #48
    MOVZ  X28, #0x9c32, LSL #0
    MOVK  X28, #0x6105, LSL #16
    MOVK  X28, #0x5124, LSL #32
    MOVK  X28, #0x2ec1, LSL #48
    MOVZ  X29, #0xa156, LSL #0
    MOVK  X29, #0xccd3, LSL #16
    MOVK  X29, #0x62db, LSL #32
    MOVK  X29, #0x5331, LSL #48
    MOVZ  X23, #0x76f3, LSL #0
    MOVK  X23, #0x21ac, LSL #16
    MOVK  X23, #0xda52, LSL #32
    MOVK  X23, #0x4669, LSL #48
    MSR  FPCR, X23
    MRS  X18, FPCR
    MOVZ  X17, #0x60ff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    AND  X18, X18, X17
    MOVZ  X17, #0x0, LSL #0
    ORR  X18, X18, X17
    MSR  FPCR, X18
    ISB  SY
    MOVZ  X23, #0xd4e8, LSL #0
    MOVK  X23, #0x5b80, LSL #16
    MOVK  X23, #0x257, LSL #32
    MOVK  X23, #0xae86, LSL #48
    MSR  FPSR, X23
    MRS  X23, FPSR
    MOVZ  X3, #0xff60, LSL #0
    MOVK  X3, #0x7ff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    AND  X23, X23, X3
    MOVZ  X3, #0x0, LSL #0
    ORR  X23, X23, X3
    MSR  FPSR, X23
    ISB  SY
    ADDS  X15, X25, X18, SXTX #4
    MOV  X30, X1
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X25
    FMOV  D3, X18
    FMOV  V3.D[1], X29
    FMOV  D4, X27
    FMOV  V4.D[1], X26
    FMOV  D5, X28
    FMOV  V5.D[1], X3
    FMOV  D6, X24
    FMOV  V6.D[1], X17
    FMOV  D7, X27
    FMOV  V7.D[1], X15
    FMOV  D8, X3
    FMOV  V8.D[1], X28
    FMOV  D9, X21
    FMOV  V9.D[1], X23
    FMOV  D10, X21
    FMOV  V10.D[1], X22
    FMOV  D11, X16
    FMOV  V11.D[1], X21
    FMOV  D12, X12
    FMOV  V12.D[1], X25
    FMOV  D13, X16
    FMOV  V13.D[1], X17
    FMOV  D14, X26
    FMOV  V14.D[1], X27
    FMOV  D15, X18
    FMOV  V15.D[1], X24
    FMOV  D16, X19
    FMOV  V16.D[1], X29
    FMOV  D17, X20
    FMOV  V17.D[1], X8
    FMOV  D18, X29
    FMOV  V18.D[1], X20
    FMOV  D19, X3
    FMOV  V19.D[1], X22
    FMOV  D20, X10
    FMOV  V20.D[1], X12
    FMOV  D21, X22
    FMOV  V21.D[1], X26
    FMOV  D22, X11
    FMOV  V22.D[1], X25
    FMOV  D23, X28
    FMOV  V23.D[1], X20
    FMOV  D24, X23
    FMOV  V24.D[1], X28
    FMOV  D25, X12
    FMOV  V25.D[1], X12
    FMOV  D26, X11
    FMOV  V26.D[1], X29
    FMOV  D27, X25
    FMOV  V27.D[1], X18
    FMOV  D28, X20
    FMOV  V28.D[1], X15
    FMOV  D29, X12
    FMOV  V29.D[1], X10
    FMOV  D30, X28
    FMOV  V30.D[1], X12
    FMOV  D31, X14
    FMOV  V31.D[1], X3
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X3, #0x40, LSL #0
    MOVZ  X26, #0x0, LSL #0
    ADD  X18, X30, X26, LSR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X18]
    LD1R { V18.4S }, [X18]
    ADD  X18, X18, X3, ASR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X18]
    LD1R { V31.16B }, [X18]
    ADD  X18, X18, X3, ASR #0
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X18]
    LD1R { V14.2D }, [X18]
    ADD  X18, X18, X3, ASR #0
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X18]
    LD1R { V21.4S }, [X18]
    ADD  X18, X18, X3
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X18]
    LD1R { V24.8H }, [X18]
    ADD  X18, X18, X3
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X18]
    LD1R { V0.4H }, [X18]
    ADD  X18, X18, X3, LSR #0
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X18]
    LD1R { V31.1D }, [X18]
    ADD  X18, X18, X3, ASR #0
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X18]
    LD1R { V27.2S }, [X18]
    ADD  X18, X18, X3, LSR #0
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X18]
    LD1R { V10.4H }, [X18]
    ADD  X18, X18, X3
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X18]
    LD1R { V19.8B }, [X18]
    ADD  X18, X18, X3, LSR #0
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X18]
    MOV  X24, X18
    LD1R { V25.16B }, [X24], #1
    ADD  X18, X18, X3, ASR #0
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X18]
    MOV  X24, X18
    LD1R { V31.16B }, [X24], #1
    ADD  X18, X18, X3
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X18]
    MOV  X24, X18
    LD1R { V21.8B }, [X24], #1
    ADD  X18, X18, X3, ASR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X18]
    MOV  X24, X18
    LD1R { V19.4H }, [X24], #2
    ADD  X18, X18, X3
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X18]
    MOV  X24, X18
    LD1R { V17.8H }, [X24], #2
    ADD  X18, X18, X3
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X18]
    MOV  X24, X18
    LD1R { V5.4S }, [X24], #4
    ADD  X18, X18, X3, ASR #0
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X18]
    MOV  X24, X18
    LD1R { V8.2S }, [X24], #4
    ADD  X18, X18, X3, ASR #0
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X18]
    MOV  X24, X18
    LD1R { V2.4S }, [X24], #4
    ADD  X18, X18, X3
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X18]
    MOV  X24, X18
    LD1R { V8.1D }, [X24], #8
    ADD  X18, X18, X3, LSR #0
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X18]
    MOV  X24, X18
    LD1R { V9.1D }, [X24], #8
    ADD  X18, X18, X3, LSR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X18]
    MOV  X24, X18
    LD1R { V19.2D }, [X24], #8
    ADD  X18, X18, X3
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X18]
    MOV  X24, X18
    LD1R { V21.4H }, [X24], #2
    ADD  X18, X18, X3, LSR #0
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X18]
    LD1R { V25.4S }, [X18], X27
    ADD  X18, X18, X3, LSR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X18]
    LD1R { V5.16B }, [X18], X27
    ADD  X18, X18, X3
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X18]
    LD1R { V30.2D }, [X18], X27
    ADD  X18, X18, X3, ASR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X18]
    LD1R { V3.4S }, [X18], X27
    ADD  X18, X18, X3, ASR #0
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X18]
    LD1R { V13.8H }, [X18], X27
    ADD  X18, X18, X3
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X18]
    LD1R { V12.4H }, [X18], X27
    ADD  X18, X18, X3, LSR #0
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X18]
    LD1R { V6.1D }, [X18], X27
    ADD  X18, X18, X3, LSR #0
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X18]
    LD1R { V19.2S }, [X18], X27
    ADD  X18, X18, X3
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X18]
    LD1R { V20.4H }, [X18], X27
    ADD  X18, X18, X3
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X18]
    LD1R { V20.8B }, [X18], X27
    ADD  X18, X18, X3, LSR #0
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X19, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X19, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X19, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X19, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X19, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X19, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X19, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X19, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X19, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X19, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X19, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X19, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X19, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X19, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X19, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    MRS  X12, FPSR
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V0.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D0
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V1.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D1
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D2
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D3
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D4
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D5
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D6
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D7
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D8
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D9
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D10
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D11
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V12.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D12
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D13
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D14
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D15
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D16
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D17
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D18
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D19
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D20
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D21
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D22
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D23
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D24
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D25
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D26
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D27
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D28
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D29
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V30.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D30
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, V31.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X12, D31
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
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
    FMOV  D0, X14
    FMOV  V0.D[1], X23
    FMOV  D1, X27
    FMOV  V1.D[1], X29
    FMOV  D2, X28
    FMOV  V2.D[1], X13
    FMOV  D3, X26
    FMOV  V3.D[1], X27
    FMOV  D4, X24
    FMOV  V4.D[1], X22
    FMOV  D5, X29
    FMOV  V5.D[1], X19
    FMOV  D6, X17
    FMOV  V6.D[1], X21
    FMOV  D7, X13
    FMOV  V7.D[1], X17
    FMOV  D8, X16
    FMOV  V8.D[1], X11
    FMOV  D9, X15
    FMOV  V9.D[1], X21
    FMOV  D10, X24
    FMOV  V10.D[1], X25
    FMOV  D11, X8
    FMOV  V11.D[1], X17
    FMOV  D12, X23
    FMOV  V12.D[1], X28
    FMOV  D13, X10
    FMOV  V13.D[1], X13
    FMOV  D14, X14
    FMOV  V14.D[1], X27
    FMOV  D15, X17
    FMOV  V15.D[1], X12
    FMOV  D16, X21
    FMOV  V16.D[1], X29
    FMOV  D17, X13
    FMOV  V17.D[1], X9
    FMOV  D18, X26
    FMOV  V18.D[1], X24
    FMOV  D19, X27
    FMOV  V19.D[1], X18
    FMOV  D20, X24
    FMOV  V20.D[1], X28
    FMOV  D21, X28
    FMOV  V21.D[1], X22
    FMOV  D22, X16
    FMOV  V22.D[1], X14
    FMOV  D23, X25
    FMOV  V23.D[1], X19
    FMOV  D24, X15
    FMOV  V24.D[1], X24
    FMOV  D25, X3
    FMOV  V25.D[1], X10
    FMOV  D26, X24
    FMOV  V26.D[1], X17
    FMOV  D27, X10
    FMOV  V27.D[1], X16
    FMOV  D28, X15
    FMOV  V28.D[1], X25
    FMOV  D29, X21
    FMOV  V29.D[1], X26
    FMOV  D30, X16
    FMOV  V30.D[1], X3
    FMOV  D31, X25
    FMOV  V31.D[1], X17
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X9, #0x40, LSL #0
    MOVZ  X10, #0x500, LSL #0
    ADD  X24, X30, X10
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X24]
    LD1R { V27.16B }, [X24]
    ADD  X24, X24, X9, ASR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X24]
    LD1R { V17.16B }, [X24]
    ADD  X24, X24, X9, LSR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X24]
    LD1R { V4.2D }, [X24]
    ADD  X24, X24, X9, ASR #0
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X24]
    LD1R { V25.4S }, [X24]
    ADD  X24, X24, X9, ASR #0
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X24]
    LD1R { V28.8H }, [X24]
    ADD  X24, X24, X9, LSR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X24]
    LD1R { V27.1D }, [X24]
    ADD  X24, X24, X9
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X24]
    LD1R { V0.1D }, [X24]
    ADD  X24, X24, X9, ASR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X24]
    LD1R { V13.2S }, [X24]
    ADD  X24, X24, X9, ASR #0
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X24]
    LD1R { V17.4H }, [X24]
    ADD  X24, X24, X9, LSR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X24]
    LD1R { V16.8B }, [X24]
    ADD  X24, X24, X9, ASR #0
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X24]
    MOV  X8, X24
    LD1R { V14.8B }, [X8], #1
    ADD  X24, X24, X9, LSR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X24]
    MOV  X8, X24
    LD1R { V0.16B }, [X8], #1
    ADD  X24, X24, X9, ASR #0
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X24]
    MOV  X8, X24
    LD1R { V6.8B }, [X8], #1
    ADD  X24, X24, X9, ASR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X24]
    MOV  X8, X24
    LD1R { V22.4H }, [X8], #2
    ADD  X24, X24, X9, LSR #0
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X24]
    MOV  X8, X24
    LD1R { V13.8H }, [X8], #2
    ADD  X24, X24, X9
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X24]
    MOV  X8, X24
    LD1R { V20.2S }, [X8], #4
    ADD  X24, X24, X9, LSR #0
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X24]
    MOV  X8, X24
    LD1R { V25.2S }, [X8], #4
    ADD  X24, X24, X9, ASR #0
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X24]
    MOV  X8, X24
    LD1R { V13.4S }, [X8], #4
    ADD  X24, X24, X9, LSR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X24]
    MOV  X8, X24
    LD1R { V7.1D }, [X8], #8
    ADD  X24, X24, X9, LSR #0
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X24]
    MOV  X8, X24
    LD1R { V5.1D }, [X8], #8
    ADD  X24, X24, X9
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X24]
    MOV  X8, X24
    LD1R { V29.2D }, [X8], #8
    ADD  X24, X24, X9
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X24]
    MOV  X8, X24
    LD1R { V8.8H }, [X8], #2
    ADD  X24, X24, X9
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X24]
    LD1R { V19.2D }, [X24], X25
    ADD  X24, X24, X9, LSR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X24]
    LD1R { V17.16B }, [X24], X25
    ADD  X24, X24, X9, LSR #0
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X24]
    LD1R { V27.2D }, [X24], X25
    ADD  X24, X24, X9, LSR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X24]
    LD1R { V0.4S }, [X24], X25
    ADD  X24, X24, X9, ASR #0
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X24]
    LD1R { V9.8H }, [X24], X25
    ADD  X24, X24, X9
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X24]
    LD1R { V1.4H }, [X24], X25
    ADD  X24, X24, X9, LSR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X24]
    LD1R { V3.1D }, [X24], X25
    ADD  X24, X24, X9
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X24]
    LD1R { V12.2S }, [X24], X25
    ADD  X24, X24, X9
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X24]
    LD1R { V7.4H }, [X24], X25
    ADD  X24, X24, X9, ASR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X24]
    LD1R { V17.8B }, [X24], X25
    ADD  X24, X24, X9
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MRS  X16, FPSR
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D0
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D1
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D2
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D3
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D4
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D5
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D6
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D7
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D8
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D9
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D10
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D11
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D12
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D13
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D14
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D15
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D16
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D17
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D18
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D19
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D20
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D21
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D22
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D23
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D24
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D25
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D26
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D27
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D28
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D29
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D30
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X16, D31
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X13
    FMOV  D1, X3
    FMOV  V1.D[1], X29
    FMOV  D2, X24
    FMOV  V2.D[1], X28
    FMOV  D3, X27
    FMOV  V3.D[1], X29
    FMOV  D4, X20
    FMOV  V4.D[1], X18
    FMOV  D5, X17
    FMOV  V5.D[1], X3
    FMOV  D6, X22
    FMOV  V6.D[1], X19
    FMOV  D7, X16
    FMOV  V7.D[1], X20
    FMOV  D8, X29
    FMOV  V8.D[1], X24
    FMOV  D9, X19
    FMOV  V9.D[1], X14
    FMOV  D10, X9
    FMOV  V10.D[1], X24
    FMOV  D11, X18
    FMOV  V11.D[1], X24
    FMOV  D12, X18
    FMOV  V12.D[1], X25
    FMOV  D13, X9
    FMOV  V13.D[1], X21
    FMOV  D14, X14
    FMOV  V14.D[1], X8
    FMOV  D15, X21
    FMOV  V15.D[1], X21
    FMOV  D16, X27
    FMOV  V16.D[1], X18
    FMOV  D17, X25
    FMOV  V17.D[1], X3
    FMOV  D18, X24
    FMOV  V18.D[1], X17
    FMOV  D19, X25
    FMOV  V19.D[1], X26
    FMOV  D20, X15
    FMOV  V20.D[1], X13
    FMOV  D21, X16
    FMOV  V21.D[1], X24
    FMOV  D22, X12
    FMOV  V22.D[1], X9
    FMOV  D23, X14
    FMOV  V23.D[1], X22
    FMOV  D24, X9
    FMOV  V24.D[1], X11
    FMOV  D25, X8
    FMOV  V25.D[1], X26
    FMOV  D26, X12
    FMOV  V26.D[1], X13
    FMOV  D27, X8
    FMOV  V27.D[1], X27
    FMOV  D28, X11
    FMOV  V28.D[1], X27
    FMOV  D29, X17
    FMOV  V29.D[1], X28
    FMOV  D30, X18
    FMOV  V30.D[1], X8
    FMOV  D31, X24
    FMOV  V31.D[1], X22
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X19, #0x40, LSL #0
    MOVZ  X27, #0xa00, LSL #0
    ADD  X26, X30, X27, ASR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X26]
    LD1R { V16.8H }, [X26]
    ADD  X26, X26, X19
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X26]
    LD1R { V19.16B }, [X26]
    ADD  X26, X26, X19
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X26]
    LD1R { V13.2D }, [X26]
    ADD  X26, X26, X19
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X26]
    LD1R { V6.4S }, [X26]
    ADD  X26, X26, X19
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X26]
    LD1R { V12.8H }, [X26]
    ADD  X26, X26, X19, LSR #0
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X26]
    LD1R { V6.1D }, [X26]
    ADD  X26, X26, X19, LSR #0
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X26]
    LD1R { V4.1D }, [X26]
    ADD  X26, X26, X19, ASR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X26]
    LD1R { V22.2S }, [X26]
    ADD  X26, X26, X19, ASR #0
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X26]
    LD1R { V26.4H }, [X26]
    ADD  X26, X26, X19, LSR #0
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X26]
    LD1R { V10.8B }, [X26]
    ADD  X26, X26, X19
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X26]
    MOV  X8, X26
    LD1R { V7.8B }, [X8], #1
    ADD  X26, X26, X19, ASR #0
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X26]
    MOV  X8, X26
    LD1R { V27.16B }, [X8], #1
    ADD  X26, X26, X19, ASR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X26]
    MOV  X8, X26
    LD1R { V5.8B }, [X8], #1
    ADD  X26, X26, X19
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X26]
    MOV  X8, X26
    LD1R { V3.4H }, [X8], #2
    ADD  X26, X26, X19, ASR #0
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X26]
    MOV  X8, X26
    LD1R { V18.8H }, [X8], #2
    ADD  X26, X26, X19, ASR #0
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X26]
    MOV  X8, X26
    LD1R { V13.4S }, [X8], #4
    ADD  X26, X26, X19, LSR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X26]
    MOV  X8, X26
    LD1R { V0.2S }, [X8], #4
    ADD  X26, X26, X19, ASR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X26]
    MOV  X8, X26
    LD1R { V7.4S }, [X8], #4
    ADD  X26, X26, X19, LSR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X26]
    MOV  X8, X26
    LD1R { V4.2D }, [X8], #8
    ADD  X26, X26, X19
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X26]
    MOV  X8, X26
    LD1R { V29.1D }, [X8], #8
    ADD  X26, X26, X19
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X26]
    MOV  X8, X26
    LD1R { V8.2D }, [X8], #8
    ADD  X26, X26, X19
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X26]
    MOV  X8, X26
    LD1R { V22.8H }, [X8], #2
    ADD  X26, X26, X19
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X26]
    LD1R { V17.4S }, [X26], X9
    ADD  X26, X26, X19, LSR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X26]
    LD1R { V0.16B }, [X26], X9
    ADD  X26, X26, X19
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X26]
    LD1R { V16.2D }, [X26], X9
    ADD  X26, X26, X19, LSR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X26]
    LD1R { V6.4S }, [X26], X9
    ADD  X26, X26, X19
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X26]
    LD1R { V22.8H }, [X26], X9
    ADD  X26, X26, X19
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X26]
    LD1R { V17.2S }, [X26], X9
    ADD  X26, X26, X19, ASR #0
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X26]
    LD1R { V31.1D }, [X26], X9
    ADD  X26, X26, X19
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X26]
    LD1R { V28.2S }, [X26], X9
    ADD  X26, X26, X19, LSR #0
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X26]
    LD1R { V24.4H }, [X26], X9
    ADD  X26, X26, X19, ASR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X26]
    LD1R { V26.8B }, [X26], X9
    ADD  X26, X26, X19, ASR #0
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X15, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X15, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X15, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X15, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X15, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X15, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X15, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X15, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X15, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X15, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X15, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X15, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X15, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X15, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X15, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MRS  X29, FPSR
    MOVZ  X15, #0x0, LSL #0
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V0.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D0
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V1.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D1
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D2
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D3
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V4.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D4
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V5.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D5
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V6.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D6
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D7
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V8.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D8
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V9.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D9
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V10.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D10
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V11.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D11
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V12.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D12
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V13.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D13
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D14
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V15.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D15
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V16.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D16
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D17
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V18.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D18
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V19.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D19
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D20
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D21
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V22.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D22
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D23
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D24
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V25.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D25
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V26.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D26
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D27
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D28
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V29.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D29
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V30.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D30
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V31.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D31
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X3, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
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
    FMOV  V0.D[1], X22
    FMOV  D1, X3
    FMOV  V1.D[1], X25
    FMOV  D2, X26
    FMOV  V2.D[1], X28
    FMOV  D3, X29
    FMOV  V3.D[1], X28
    FMOV  D4, X23
    FMOV  V4.D[1], X16
    FMOV  D5, X20
    FMOV  V5.D[1], X23
    FMOV  D6, X14
    FMOV  V6.D[1], X26
    FMOV  D7, X10
    FMOV  V7.D[1], X25
    FMOV  D8, X28
    FMOV  V8.D[1], X17
    FMOV  D9, X12
    FMOV  V9.D[1], X22
    FMOV  D10, X18
    FMOV  V10.D[1], X14
    FMOV  D11, X27
    FMOV  V11.D[1], X11
    FMOV  D12, X10
    FMOV  V12.D[1], X29
    FMOV  D13, X26
    FMOV  V13.D[1], X23
    FMOV  D14, X29
    FMOV  V14.D[1], X29
    FMOV  D15, X26
    FMOV  V15.D[1], X15
    FMOV  D16, X29
    FMOV  V16.D[1], X27
    FMOV  D17, X23
    FMOV  V17.D[1], X24
    FMOV  D18, X8
    FMOV  V18.D[1], X29
    FMOV  D19, X28
    FMOV  V19.D[1], X20
    FMOV  D20, X28
    FMOV  V20.D[1], X27
    FMOV  D21, X20
    FMOV  V21.D[1], X11
    FMOV  D22, X3
    FMOV  V22.D[1], X19
    FMOV  D23, X26
    FMOV  V23.D[1], X28
    FMOV  D24, X12
    FMOV  V24.D[1], X14
    FMOV  D25, X19
    FMOV  V25.D[1], X18
    FMOV  D26, X21
    FMOV  V26.D[1], X3
    FMOV  D27, X11
    FMOV  V27.D[1], X29
    FMOV  D28, X11
    FMOV  V28.D[1], X28
    FMOV  D29, X8
    FMOV  V29.D[1], X20
    FMOV  D30, X8
    FMOV  V30.D[1], X23
    FMOV  D31, X22
    FMOV  V31.D[1], X17
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x40, LSL #0
    MOVZ  X23, #0xf00, LSL #0
    ADD  X27, X30, X23, ASR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X27]
    LD1R { V22.8H }, [X27]
    ADD  X27, X27, X19, LSR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X27]
    LD1R { V5.16B }, [X27]
    ADD  X27, X27, X19
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X27]
    LD1R { V22.2D }, [X27]
    ADD  X27, X27, X19, ASR #0
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X27]
    LD1R { V4.4S }, [X27]
    ADD  X27, X27, X19, LSR #0
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X27]
    LD1R { V9.8H }, [X27]
    ADD  X27, X27, X19, ASR #0
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X27]
    LD1R { V24.4H }, [X27]
    ADD  X27, X27, X19
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X27]
    LD1R { V7.1D }, [X27]
    ADD  X27, X27, X19, ASR #0
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X27]
    LD1R { V16.2S }, [X27]
    ADD  X27, X27, X19, ASR #0
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X27]
    LD1R { V6.4H }, [X27]
    ADD  X27, X27, X19
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X27]
    LD1R { V10.8B }, [X27]
    ADD  X27, X27, X19, ASR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X27]
    MOV  X8, X27
    LD1R { V25.16B }, [X8], #1
    ADD  X27, X27, X19, ASR #0
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X27]
    MOV  X8, X27
    LD1R { V28.16B }, [X8], #1
    ADD  X27, X27, X19
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X27]
    MOV  X8, X27
    LD1R { V23.8B }, [X8], #1
    ADD  X27, X27, X19
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X27]
    MOV  X8, X27
    LD1R { V17.4H }, [X8], #2
    ADD  X27, X27, X19
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X27]
    MOV  X8, X27
    LD1R { V21.8H }, [X8], #2
    ADD  X27, X27, X19
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X27]
    MOV  X8, X27
    LD1R { V11.4S }, [X8], #4
    ADD  X27, X27, X19, LSR #0
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X27]
    MOV  X8, X27
    LD1R { V29.2S }, [X8], #4
    ADD  X27, X27, X19
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X27]
    MOV  X8, X27
    LD1R { V5.4S }, [X8], #4
    ADD  X27, X27, X19, ASR #0
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X27]
    MOV  X8, X27
    LD1R { V16.2D }, [X8], #8
    ADD  X27, X27, X19, LSR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X27]
    MOV  X8, X27
    LD1R { V23.1D }, [X8], #8
    ADD  X27, X27, X19, LSR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X27]
    MOV  X8, X27
    LD1R { V26.2D }, [X8], #8
    ADD  X27, X27, X19
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X27]
    MOV  X8, X27
    LD1R { V24.4H }, [X8], #2
    ADD  X27, X27, X19
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X27]
    LD1R { V4.2D }, [X27], X18
    ADD  X27, X27, X19, LSR #0
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X27]
    LD1R { V8.16B }, [X27], X18
    ADD  X27, X27, X19, LSR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X27]
    LD1R { V23.2D }, [X27], X18
    ADD  X27, X27, X19, ASR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X27]
    LD1R { V14.4S }, [X27], X18
    ADD  X27, X27, X19, ASR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X27]
    LD1R { V7.8H }, [X27], X18
    ADD  X27, X27, X19
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X27]
    LD1R { V15.2S }, [X27], X18
    ADD  X27, X27, X19, ASR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X27]
    LD1R { V5.1D }, [X27], X18
    ADD  X27, X27, X19, LSR #0
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X27]
    LD1R { V8.2S }, [X27], X18
    ADD  X27, X27, X19, LSR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X27]
    LD1R { V16.4H }, [X27], X18
    ADD  X27, X27, X19
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X27]
    LD1R { V23.8B }, [X27], X18
    ADD  X27, X27, X19, ASR #0
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    MRS  X20, FPSR
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V0.D[1]
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D0
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V1.D[1]
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D1
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D2
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D3
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D4
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D5
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D6
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D7
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D8
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D9
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D10
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D11
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D12
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D13
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D14
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D15
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D16
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D17
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D18
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D19
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V20.D[1]
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D20
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D21
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D22
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D23
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D24
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D25
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D26
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D27
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D28
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D29
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V30.D[1]
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D30
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V31.D[1]
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D31
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X25
    FMOV  D1, X28
    FMOV  V1.D[1], X26
    FMOV  D2, X20
    FMOV  V2.D[1], X29
    FMOV  D3, X29
    FMOV  V3.D[1], X13
    FMOV  D4, X14
    FMOV  V4.D[1], X16
    FMOV  D5, X11
    FMOV  V5.D[1], X26
    FMOV  D6, X17
    FMOV  V6.D[1], X25
    FMOV  D7, X27
    FMOV  V7.D[1], X12
    FMOV  D8, X10
    FMOV  V8.D[1], X8
    FMOV  D9, X11
    FMOV  V9.D[1], X16
    FMOV  D10, X28
    FMOV  V10.D[1], X28
    FMOV  D11, X18
    FMOV  V11.D[1], X16
    FMOV  D12, X14
    FMOV  V12.D[1], X11
    FMOV  D13, X22
    FMOV  V13.D[1], X15
    FMOV  D14, X25
    FMOV  V14.D[1], X10
    FMOV  D15, X26
    FMOV  V15.D[1], X22
    FMOV  D16, X13
    FMOV  V16.D[1], X17
    FMOV  D17, X13
    FMOV  V17.D[1], X20
    FMOV  D18, X18
    FMOV  V18.D[1], X24
    FMOV  D19, X26
    FMOV  V19.D[1], X16
    FMOV  D20, X28
    FMOV  V20.D[1], X26
    FMOV  D21, X16
    FMOV  V21.D[1], X17
    FMOV  D22, X3
    FMOV  V22.D[1], X21
    FMOV  D23, X14
    FMOV  V23.D[1], X23
    FMOV  D24, X19
    FMOV  V24.D[1], X19
    FMOV  D25, X8
    FMOV  V25.D[1], X8
    FMOV  D26, X26
    FMOV  V26.D[1], X16
    FMOV  D27, X26
    FMOV  V27.D[1], X11
    FMOV  D28, X10
    FMOV  V28.D[1], X11
    FMOV  D29, X11
    FMOV  V29.D[1], X27
    FMOV  D30, X24
    FMOV  V30.D[1], X12
    FMOV  D31, X20
    FMOV  V31.D[1], X9
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X9, #0x40, LSL #0
    MOVZ  X21, #0x1400, LSL #0
    ADD  X22, X30, X21, LSR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X22]
    LD1R { V29.2D }, [X22]
    ADD  X22, X22, X9
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X22]
    LD1R { V17.16B }, [X22]
    ADD  X22, X22, X9, ASR #0
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X22]
    LD1R { V1.2D }, [X22]
    ADD  X22, X22, X9, ASR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X22]
    LD1R { V30.4S }, [X22]
    ADD  X22, X22, X9
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X22]
    LD1R { V31.8H }, [X22]
    ADD  X22, X22, X9
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X22]
    LD1R { V6.2S }, [X22]
    ADD  X22, X22, X9, ASR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X22]
    LD1R { V25.1D }, [X22]
    ADD  X22, X22, X9, ASR #0
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X22]
    LD1R { V19.2S }, [X22]
    ADD  X22, X22, X9, LSR #0
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X22]
    LD1R { V30.4H }, [X22]
    ADD  X22, X22, X9
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X22]
    LD1R { V16.8B }, [X22]
    ADD  X22, X22, X9
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X22]
    MOV  X23, X22
    LD1R { V18.16B }, [X23], #1
    ADD  X22, X22, X9, ASR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X22]
    MOV  X23, X22
    LD1R { V22.16B }, [X23], #1
    ADD  X22, X22, X9, ASR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X22]
    MOV  X23, X22
    LD1R { V9.8B }, [X23], #1
    ADD  X22, X22, X9, ASR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X22]
    MOV  X23, X22
    LD1R { V20.4H }, [X23], #2
    ADD  X22, X22, X9, LSR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X22]
    MOV  X23, X22
    LD1R { V0.8H }, [X23], #2
    ADD  X22, X22, X9
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X22]
    MOV  X23, X22
    LD1R { V5.2S }, [X23], #4
    ADD  X22, X22, X9, LSR #0
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X22]
    MOV  X23, X22
    LD1R { V1.2S }, [X23], #4
    ADD  X22, X22, X9, LSR #0
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X22]
    MOV  X23, X22
    LD1R { V6.4S }, [X23], #4
    ADD  X22, X22, X9
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X22]
    MOV  X23, X22
    LD1R { V20.1D }, [X23], #8
    ADD  X22, X22, X9
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X22]
    MOV  X23, X22
    LD1R { V1.1D }, [X23], #8
    ADD  X22, X22, X9
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X22]
    MOV  X23, X22
    LD1R { V25.2D }, [X23], #8
    ADD  X22, X22, X9
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X22]
    MOV  X23, X22
    LD1R { V18.4H }, [X23], #2
    ADD  X22, X22, X9, ASR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X22]
    LD1R { V22.16B }, [X22], X26
    ADD  X22, X22, X9, ASR #0
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X22]
    LD1R { V3.16B }, [X22], X26
    ADD  X22, X22, X9, LSR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X22]
    LD1R { V21.2D }, [X22], X26
    ADD  X22, X22, X9, LSR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X22]
    LD1R { V14.4S }, [X22], X26
    ADD  X22, X22, X9, ASR #0
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X22]
    LD1R { V16.8H }, [X22], X26
    ADD  X22, X22, X9, LSR #0
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X22]
    LD1R { V12.2S }, [X22], X26
    ADD  X22, X22, X9, LSR #0
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X22]
    LD1R { V16.1D }, [X22], X26
    ADD  X22, X22, X9
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X22]
    LD1R { V26.2S }, [X22], X26
    ADD  X22, X22, X9, ASR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X22]
    LD1R { V31.4H }, [X22], X26
    ADD  X22, X22, X9
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X22]
    LD1R { V24.8B }, [X22], X26
    ADD  X22, X22, X9
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X16, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MRS  X20, FPSR
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V0.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D0
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V1.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D1
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D2
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D3
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D4
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D5
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D6
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D7
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D8
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D9
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D10
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D11
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D12
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D13
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D14
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D15
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D16
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D17
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D18
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D19
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V20.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D20
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D21
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D22
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D23
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D24
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D25
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D26
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D27
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D28
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D29
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V30.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D30
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V31.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D31
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X25, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
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
    FMOV  D0, X28
    FMOV  V0.D[1], X13
    FMOV  D1, X15
    FMOV  V1.D[1], X25
    FMOV  D2, X26
    FMOV  V2.D[1], X22
    FMOV  D3, X23
    FMOV  V3.D[1], X20
    FMOV  D4, X29
    FMOV  V4.D[1], X23
    FMOV  D5, X8
    FMOV  V5.D[1], X9
    FMOV  D6, X26
    FMOV  V6.D[1], X13
    FMOV  D7, X22
    FMOV  V7.D[1], X17
    FMOV  D8, X23
    FMOV  V8.D[1], X13
    FMOV  D9, X19
    FMOV  V9.D[1], X11
    FMOV  D10, X25
    FMOV  V10.D[1], X18
    FMOV  D11, X26
    FMOV  V11.D[1], X21
    FMOV  D12, X11
    FMOV  V12.D[1], X9
    FMOV  D13, X11
    FMOV  V13.D[1], X25
    FMOV  D14, X21
    FMOV  V14.D[1], X25
    FMOV  D15, X14
    FMOV  V15.D[1], X3
    FMOV  D16, X3
    FMOV  V16.D[1], X13
    FMOV  D17, X9
    FMOV  V17.D[1], X25
    FMOV  D18, X26
    FMOV  V18.D[1], X9
    FMOV  D19, X15
    FMOV  V19.D[1], X14
    FMOV  D20, X13
    FMOV  V20.D[1], X19
    FMOV  D21, X12
    FMOV  V21.D[1], X27
    FMOV  D22, X14
    FMOV  V22.D[1], X23
    FMOV  D23, X17
    FMOV  V23.D[1], X28
    FMOV  D24, X27
    FMOV  V24.D[1], X17
    FMOV  D25, X9
    FMOV  V25.D[1], X28
    FMOV  D26, X3
    FMOV  V26.D[1], X29
    FMOV  D27, X28
    FMOV  V27.D[1], X21
    FMOV  D28, X25
    FMOV  V28.D[1], X11
    FMOV  D29, X28
    FMOV  V29.D[1], X15
    FMOV  D30, X29
    FMOV  V30.D[1], X29
    FMOV  D31, X16
    FMOV  V31.D[1], X25
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X16, #0x40, LSL #0
    MOVZ  X24, #0x1900, LSL #0
    ADD  X27, X30, X24, ASR #0
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X27]
    LD1R { V24.2D }, [X27]
    ADD  X27, X27, X16, ASR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X27]
    LD1R { V18.16B }, [X27]
    ADD  X27, X27, X16, ASR #0
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X27]
    LD1R { V6.2D }, [X27]
    ADD  X27, X27, X16, ASR #0
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X27]
    LD1R { V5.4S }, [X27]
    ADD  X27, X27, X16
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X27]
    LD1R { V20.8H }, [X27]
    ADD  X27, X27, X16, LSR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X27]
    LD1R { V4.4H }, [X27]
    ADD  X27, X27, X16, LSR #0
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X27]
    LD1R { V6.1D }, [X27]
    ADD  X27, X27, X16, LSR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X27]
    LD1R { V23.2S }, [X27]
    ADD  X27, X27, X16
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X27]
    LD1R { V13.4H }, [X27]
    ADD  X27, X27, X16, LSR #0
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X27]
    LD1R { V2.8B }, [X27]
    ADD  X27, X27, X16
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X27]
    MOV  X23, X27
    LD1R { V13.16B }, [X23], #1
    ADD  X27, X27, X16
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X27]
    MOV  X23, X27
    LD1R { V30.16B }, [X23], #1
    ADD  X27, X27, X16, ASR #0
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X27]
    MOV  X23, X27
    LD1R { V9.8B }, [X23], #1
    ADD  X27, X27, X16, ASR #0
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X27]
    MOV  X23, X27
    LD1R { V25.4H }, [X23], #2
    ADD  X27, X27, X16, ASR #0
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X27]
    MOV  X23, X27
    LD1R { V28.8H }, [X23], #2
    ADD  X27, X27, X16
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X27]
    MOV  X23, X27
    LD1R { V30.4S }, [X23], #4
    ADD  X27, X27, X16, ASR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X27]
    MOV  X23, X27
    LD1R { V18.2S }, [X23], #4
    ADD  X27, X27, X16, ASR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X27]
    MOV  X23, X27
    LD1R { V27.4S }, [X23], #4
    ADD  X27, X27, X16
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X27]
    MOV  X23, X27
    LD1R { V26.1D }, [X23], #8
    ADD  X27, X27, X16
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X27]
    MOV  X23, X27
    LD1R { V7.1D }, [X23], #8
    ADD  X27, X27, X16, ASR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X27]
    MOV  X23, X27
    LD1R { V24.2D }, [X23], #8
    ADD  X27, X27, X16, LSR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X27]
    MOV  X23, X27
    LD1R { V2.8H }, [X23], #2
    ADD  X27, X27, X16, LSR #0
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X27]
    LD1R { V28.2D }, [X27], X14
    ADD  X27, X27, X16
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X27]
    LD1R { V27.16B }, [X27], X14
    ADD  X27, X27, X16, ASR #0
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X27]
    LD1R { V3.2D }, [X27], X14
    ADD  X27, X27, X16
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X27]
    LD1R { V28.4S }, [X27], X14
    ADD  X27, X27, X16, LSR #0
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X27]
    LD1R { V6.8H }, [X27], X14
    ADD  X27, X27, X16
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X27]
    LD1R { V19.2S }, [X27], X14
    ADD  X27, X27, X16, LSR #0
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X27]
    LD1R { V3.1D }, [X27], X14
    ADD  X27, X27, X16, ASR #0
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X27]
    LD1R { V6.2S }, [X27], X14
    ADD  X27, X27, X16, ASR #0
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X27]
    LD1R { V5.4H }, [X27], X14
    ADD  X27, X27, X16, LSR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X27]
    LD1R { V8.8B }, [X27], X14
    ADD  X27, X27, X16, LSR #0
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MRS  X29, FPSR
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V0.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D0
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V1.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D1
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D2
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V3.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D3
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V4.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D4
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V5.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D5
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V6.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D6
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D7
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V8.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D8
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V9.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D9
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V10.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D10
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V11.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D11
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V12.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D12
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V13.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D13
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D14
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V15.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D15
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V16.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D16
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D17
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V18.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D18
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V19.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D19
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D20
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D21
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V22.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D22
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D23
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D24
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V25.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D25
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V26.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D26
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D27
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D28
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V29.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D29
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V30.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D30
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, V31.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X29, D31
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    FMOV  D0, X10
    FMOV  V0.D[1], X28
    FMOV  D1, X27
    FMOV  V1.D[1], X3
    FMOV  D2, X29
    FMOV  V2.D[1], X26
    FMOV  D3, X15
    FMOV  V3.D[1], X10
    FMOV  D4, X3
    FMOV  V4.D[1], X28
    FMOV  D5, X20
    FMOV  V5.D[1], X11
    FMOV  D6, X19
    FMOV  V6.D[1], X10
    FMOV  D7, X13
    FMOV  V7.D[1], X19
    FMOV  D8, X24
    FMOV  V8.D[1], X14
    FMOV  D9, X12
    FMOV  V9.D[1], X26
    FMOV  D10, X24
    FMOV  V10.D[1], X29
    FMOV  D11, X8
    FMOV  V11.D[1], X24
    FMOV  D12, X8
    FMOV  V12.D[1], X29
    FMOV  D13, X20
    FMOV  V13.D[1], X28
    FMOV  D14, X25
    FMOV  V14.D[1], X18
    FMOV  D15, X10
    FMOV  V15.D[1], X21
    FMOV  D16, X22
    FMOV  V16.D[1], X3
    FMOV  D17, X8
    FMOV  V17.D[1], X27
    FMOV  D18, X18
    FMOV  V18.D[1], X28
    FMOV  D19, X9
    FMOV  V19.D[1], X8
    FMOV  D20, X11
    FMOV  V20.D[1], X24
    FMOV  D21, X10
    FMOV  V21.D[1], X29
    FMOV  D22, X17
    FMOV  V22.D[1], X16
    FMOV  D23, X3
    FMOV  V23.D[1], X29
    FMOV  D24, X26
    FMOV  V24.D[1], X12
    FMOV  D25, X27
    FMOV  V25.D[1], X24
    FMOV  D26, X8
    FMOV  V26.D[1], X9
    FMOV  D27, X16
    FMOV  V27.D[1], X16
    FMOV  D28, X17
    FMOV  V28.D[1], X14
    FMOV  D29, X10
    FMOV  V29.D[1], X22
    FMOV  D30, X9
    FMOV  V30.D[1], X12
    FMOV  D31, X10
    FMOV  V31.D[1], X19
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X26, #0x40, LSL #0
    MOVZ  X9, #0x1e00, LSL #0
    ADD  X22, X30, X9, LSR #0
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X22]
    LD1R { V25.16B }, [X22]
    ADD  X22, X22, X26, ASR #0
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X22]
    LD1R { V7.16B }, [X22]
    ADD  X22, X22, X26
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X22]
    LD1R { V13.2D }, [X22]
    ADD  X22, X22, X26, ASR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X22]
    LD1R { V2.4S }, [X22]
    ADD  X22, X22, X26
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X22]
    LD1R { V4.8H }, [X22]
    ADD  X22, X22, X26, LSR #0
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X22]
    LD1R { V24.8B }, [X22]
    ADD  X22, X22, X26, ASR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X22]
    LD1R { V23.1D }, [X22]
    ADD  X22, X22, X26
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X22]
    LD1R { V29.2S }, [X22]
    ADD  X22, X22, X26
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X22]
    LD1R { V28.4H }, [X22]
    ADD  X22, X22, X26, LSR #0
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X22]
    LD1R { V7.8B }, [X22]
    ADD  X22, X22, X26, LSR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X22]
    MOV  X3, X22
    LD1R { V1.16B }, [X3], #1
    ADD  X22, X22, X26, ASR #0
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X22]
    MOV  X3, X22
    LD1R { V0.16B }, [X3], #1
    ADD  X22, X22, X26, ASR #0
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X22]
    MOV  X3, X22
    LD1R { V5.8B }, [X3], #1
    ADD  X22, X22, X26, ASR #0
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X22]
    MOV  X3, X22
    LD1R { V21.4H }, [X3], #2
    ADD  X22, X22, X26
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X22]
    MOV  X3, X22
    LD1R { V27.8H }, [X3], #2
    ADD  X22, X22, X26, ASR #0
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X22]
    MOV  X3, X22
    LD1R { V14.2S }, [X3], #4
    ADD  X22, X22, X26
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X22]
    MOV  X3, X22
    LD1R { V13.2S }, [X3], #4
    ADD  X22, X22, X26
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X22]
    MOV  X3, X22
    LD1R { V6.4S }, [X3], #4
    ADD  X22, X22, X26, LSR #0
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X22]
    MOV  X3, X22
    LD1R { V7.1D }, [X3], #8
    ADD  X22, X22, X26, LSR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X22]
    MOV  X3, X22
    LD1R { V22.1D }, [X3], #8
    ADD  X22, X22, X26, LSR #0
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X22]
    MOV  X3, X22
    LD1R { V20.2D }, [X3], #8
    ADD  X22, X22, X26
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X22]
    MOV  X3, X22
    LD1R { V18.4H }, [X3], #2
    ADD  X22, X22, X26, ASR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X22]
    LD1R { V17.4S }, [X22], X13
    ADD  X22, X22, X26, LSR #0
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X22]
    LD1R { V21.16B }, [X22], X13
    ADD  X22, X22, X26, LSR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X22]
    LD1R { V19.2D }, [X22], X13
    ADD  X22, X22, X26, ASR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X22]
    LD1R { V13.4S }, [X22], X13
    ADD  X22, X22, X26, LSR #0
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X22]
    LD1R { V6.8H }, [X22], X13
    ADD  X22, X22, X26
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X22]
    LD1R { V16.8B }, [X22], X13
    ADD  X22, X22, X26, LSR #0
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X22]
    LD1R { V9.1D }, [X22], X13
    ADD  X22, X22, X26
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X22]
    LD1R { V14.2S }, [X22], X13
    ADD  X22, X22, X26, LSR #0
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X22]
    LD1R { V31.4H }, [X22], X13
    ADD  X22, X22, X26
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X22]
    LD1R { V13.8B }, [X22], X13
    ADD  X22, X22, X26
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MRS  X20, FPSR
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V0.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D0
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V1.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D1
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D2
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D3
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D4
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D5
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D6
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D7
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D8
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D9
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D10
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D11
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D12
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D13
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D14
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D15
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D16
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D17
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D18
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D19
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V20.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D20
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D21
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D22
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D23
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D24
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D25
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D26
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D27
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D28
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D29
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V30.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D30
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, V31.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X20, D31
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
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
    FMOV  D0, X9
    FMOV  V0.D[1], X18
    FMOV  D1, X14
    FMOV  V1.D[1], X25
    FMOV  D2, X29
    FMOV  V2.D[1], X26
    FMOV  D3, X27
    FMOV  V3.D[1], X21
    FMOV  D4, X28
    FMOV  V4.D[1], X15
    FMOV  D5, X17
    FMOV  V5.D[1], X3
    FMOV  D6, X13
    FMOV  V6.D[1], X23
    FMOV  D7, X15
    FMOV  V7.D[1], X17
    FMOV  D8, X22
    FMOV  V8.D[1], X17
    FMOV  D9, X23
    FMOV  V9.D[1], X12
    FMOV  D10, X26
    FMOV  V10.D[1], X24
    FMOV  D11, X10
    FMOV  V11.D[1], X26
    FMOV  D12, X28
    FMOV  V12.D[1], X10
    FMOV  D13, X9
    FMOV  V13.D[1], X9
    FMOV  D14, X19
    FMOV  V14.D[1], X11
    FMOV  D15, X25
    FMOV  V15.D[1], X18
    FMOV  D16, X24
    FMOV  V16.D[1], X27
    FMOV  D17, X23
    FMOV  V17.D[1], X28
    FMOV  D18, X19
    FMOV  V18.D[1], X9
    FMOV  D19, X16
    FMOV  V19.D[1], X10
    FMOV  D20, X14
    FMOV  V20.D[1], X11
    FMOV  D21, X27
    FMOV  V21.D[1], X17
    FMOV  D22, X26
    FMOV  V22.D[1], X18
    FMOV  D23, X11
    FMOV  V23.D[1], X14
    FMOV  D24, X24
    FMOV  V24.D[1], X15
    FMOV  D25, X27
    FMOV  V25.D[1], X14
    FMOV  D26, X8
    FMOV  V26.D[1], X9
    FMOV  D27, X27
    FMOV  V27.D[1], X21
    FMOV  D28, X28
    FMOV  V28.D[1], X19
    FMOV  D29, X25
    FMOV  V29.D[1], X21
    FMOV  D30, X8
    FMOV  V30.D[1], X24
    FMOV  D31, X12
    FMOV  V31.D[1], X21
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X20, #0x40, LSL #0
    MOVZ  X14, #0x2300, LSL #0
    ADD  X11, X30, X14, ASR #0
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X11]
    LD1R { V26.4S }, [X11]
    ADD  X11, X11, X20, LSR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X11]
    LD1R { V15.16B }, [X11]
    ADD  X11, X11, X20
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X11]
    LD1R { V12.2D }, [X11]
    ADD  X11, X11, X20, ASR #0
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X11]
    LD1R { V29.4S }, [X11]
    ADD  X11, X11, X20, LSR #0
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X11]
    LD1R { V4.8H }, [X11]
    ADD  X11, X11, X20, LSR #0
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X11]
    LD1R { V15.4H }, [X11]
    ADD  X11, X11, X20, ASR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X11]
    LD1R { V11.1D }, [X11]
    ADD  X11, X11, X20, LSR #0
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X11]
    LD1R { V1.2S }, [X11]
    ADD  X11, X11, X20, LSR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X11]
    LD1R { V4.4H }, [X11]
    ADD  X11, X11, X20, LSR #0
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X11]
    LD1R { V26.8B }, [X11]
    ADD  X11, X11, X20, LSR #0
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X11]
    MOV  X24, X11
    LD1R { V3.8B }, [X24], #1
    ADD  X11, X11, X20, LSR #0
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X11]
    MOV  X24, X11
    LD1R { V0.16B }, [X24], #1
    ADD  X11, X11, X20, ASR #0
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X11]
    MOV  X24, X11
    LD1R { V13.8B }, [X24], #1
    ADD  X11, X11, X20, ASR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X11]
    MOV  X24, X11
    LD1R { V0.4H }, [X24], #2
    ADD  X11, X11, X20, ASR #0
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X11]
    MOV  X24, X11
    LD1R { V17.8H }, [X24], #2
    ADD  X11, X11, X20, ASR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X11]
    MOV  X24, X11
    LD1R { V11.2S }, [X24], #4
    ADD  X11, X11, X20, LSR #0
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X11]
    MOV  X24, X11
    LD1R { V16.2S }, [X24], #4
    ADD  X11, X11, X20
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X11]
    MOV  X24, X11
    LD1R { V4.4S }, [X24], #4
    ADD  X11, X11, X20
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X11]
    MOV  X24, X11
    LD1R { V2.2D }, [X24], #8
    ADD  X11, X11, X20
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X11]
    MOV  X24, X11
    LD1R { V30.1D }, [X24], #8
    ADD  X11, X11, X20, LSR #0
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X11]
    MOV  X24, X11
    LD1R { V21.2D }, [X24], #8
    ADD  X11, X11, X20
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X11]
    MOV  X24, X11
    LD1R { V30.8H }, [X24], #2
    ADD  X11, X11, X20
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X11]
    LD1R { V5.2D }, [X11], X8
    ADD  X11, X11, X20
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X11]
    LD1R { V23.16B }, [X11], X8
    ADD  X11, X11, X20
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X11]
    LD1R { V31.2D }, [X11], X8
    ADD  X11, X11, X20
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X11]
    LD1R { V15.4S }, [X11], X8
    ADD  X11, X11, X20
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X11]
    LD1R { V25.8H }, [X11], X8
    ADD  X11, X11, X20, LSR #0
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X11]
    LD1R { V31.1D }, [X11], X8
    ADD  X11, X11, X20, LSR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X11]
    LD1R { V4.1D }, [X11], X8
    ADD  X11, X11, X20, ASR #0
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X11]
    LD1R { V16.2S }, [X11], X8
    ADD  X11, X11, X20, ASR #0
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X11]
    LD1R { V9.4H }, [X11], X8
    ADD  X11, X11, X20
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X11]
    LD1R { V1.8B }, [X11], X8
    ADD  X11, X11, X20, ASR #0
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X25, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X25, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X25, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X25, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X25, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X25, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X25, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X25, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X25, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X25, X9, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X25, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X25, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X25, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X25, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP01_TestFail
    MRS  X9, FPSR
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V0.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D0
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V1.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D1
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D2
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D3
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D4
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V5.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D5
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D6
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V7.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D7
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D8
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V9.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D9
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D10
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V11.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D11
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V12.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D12
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V13.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D13
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D14
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D15
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D16
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V17.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D17
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V18.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D18
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V19.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D19
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V20.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D20
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D21
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V22.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D22
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D23
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V24.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D24
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D25
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D26
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V27.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D27
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V28.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D28
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D29
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V30.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D30
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V31.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D31
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X25
    FMOV  D1, X22
    FMOV  V1.D[1], X19
    FMOV  D2, X24
    FMOV  V2.D[1], X29
    FMOV  D3, X24
    FMOV  V3.D[1], X15
    FMOV  D4, X28
    FMOV  V4.D[1], X14
    FMOV  D5, X22
    FMOV  V5.D[1], X13
    FMOV  D6, X28
    FMOV  V6.D[1], X8
    FMOV  D7, X26
    FMOV  V7.D[1], X14
    FMOV  D8, X28
    FMOV  V8.D[1], X24
    FMOV  D9, X25
    FMOV  V9.D[1], X19
    FMOV  D10, X9
    FMOV  V10.D[1], X29
    FMOV  D11, X9
    FMOV  V11.D[1], X15
    FMOV  D12, X15
    FMOV  V12.D[1], X18
    FMOV  D13, X8
    FMOV  V13.D[1], X29
    FMOV  D14, X27
    FMOV  V14.D[1], X10
    FMOV  D15, X8
    FMOV  V15.D[1], X24
    FMOV  D16, X10
    FMOV  V16.D[1], X26
    FMOV  D17, X14
    FMOV  V17.D[1], X11
    FMOV  D18, X11
    FMOV  V18.D[1], X23
    FMOV  D19, X3
    FMOV  V19.D[1], X19
    FMOV  D20, X20
    FMOV  V20.D[1], X28
    FMOV  D21, X13
    FMOV  V21.D[1], X14
    FMOV  D22, X20
    FMOV  V22.D[1], X14
    FMOV  D23, X16
    FMOV  V23.D[1], X25
    FMOV  D24, X10
    FMOV  V24.D[1], X15
    FMOV  D25, X24
    FMOV  V25.D[1], X26
    FMOV  D26, X14
    FMOV  V26.D[1], X20
    FMOV  D27, X26
    FMOV  V27.D[1], X14
    FMOV  D28, X27
    FMOV  V28.D[1], X18
    FMOV  D29, X18
    FMOV  V29.D[1], X21
    FMOV  D30, X24
    FMOV  V30.D[1], X25
    FMOV  D31, X10
    FMOV  V31.D[1], X11
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X29, #0x40, LSL #0
    MOVZ  X12, #0x2800, LSL #0
    ADD  X15, X30, X12, ASR #0
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X15]
    LD1R { V8.2D }, [X15]
    ADD  X15, X15, X29, ASR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X15]
    LD1R { V10.16B }, [X15]
    ADD  X15, X15, X29
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X15]
    LD1R { V11.2D }, [X15]
    ADD  X15, X15, X29, ASR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X15]
    LD1R { V22.4S }, [X15]
    ADD  X15, X15, X29, LSR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X15]
    LD1R { V6.8H }, [X15]
    ADD  X15, X15, X29, LSR #0
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X15]
    LD1R { V2.4H }, [X15]
    ADD  X15, X15, X29
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X15]
    LD1R { V28.1D }, [X15]
    ADD  X15, X15, X29, LSR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X15]
    LD1R { V19.2S }, [X15]
    ADD  X15, X15, X29
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X15]
    LD1R { V12.4H }, [X15]
    ADD  X15, X15, X29, ASR #0
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X15]
    LD1R { V3.8B }, [X15]
    ADD  X15, X15, X29, ASR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X15]
    MOV  X27, X15
    LD1R { V0.8B }, [X27], #1
    ADD  X15, X15, X29, ASR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X15]
    MOV  X27, X15
    LD1R { V18.16B }, [X27], #1
    ADD  X15, X15, X29
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X15]
    MOV  X27, X15
    LD1R { V31.8B }, [X27], #1
    ADD  X15, X15, X29, LSR #0
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X15]
    MOV  X27, X15
    LD1R { V1.4H }, [X27], #2
    ADD  X15, X15, X29, LSR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X15]
    MOV  X27, X15
    LD1R { V12.8H }, [X27], #2
    ADD  X15, X15, X29
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X15]
    MOV  X27, X15
    LD1R { V16.2S }, [X27], #4
    ADD  X15, X15, X29, ASR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X15]
    MOV  X27, X15
    LD1R { V9.2S }, [X27], #4
    ADD  X15, X15, X29
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X15]
    MOV  X27, X15
    LD1R { V14.4S }, [X27], #4
    ADD  X15, X15, X29, LSR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X15]
    MOV  X27, X15
    LD1R { V29.1D }, [X27], #8
    ADD  X15, X15, X29
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X15]
    MOV  X27, X15
    LD1R { V0.1D }, [X27], #8
    ADD  X15, X15, X29, LSR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X15]
    MOV  X27, X15
    LD1R { V5.2D }, [X27], #8
    ADD  X15, X15, X29, ASR #0
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X15]
    MOV  X27, X15
    LD1R { V0.8H }, [X27], #2
    ADD  X15, X15, X29
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X15]
    LD1R { V13.8H }, [X15], X3
    ADD  X15, X15, X29, ASR #0
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X15]
    LD1R { V1.16B }, [X15], X3
    ADD  X15, X15, X29
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X15]
    LD1R { V3.2D }, [X15], X3
    ADD  X15, X15, X29, ASR #0
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X15]
    LD1R { V2.4S }, [X15], X3
    ADD  X15, X15, X29, ASR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X15]
    LD1R { V11.8H }, [X15], X3
    ADD  X15, X15, X29, LSR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X15]
    LD1R { V17.8B }, [X15], X3
    ADD  X15, X15, X29
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X15]
    LD1R { V10.1D }, [X15], X3
    ADD  X15, X15, X29, LSR #0
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X15]
    LD1R { V16.2S }, [X15], X3
    ADD  X15, X15, X29
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X15]
    LD1R { V6.4H }, [X15], X3
    ADD  X15, X15, X29
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X15]
    LD1R { V15.8B }, [X15], X3
    ADD  X15, X15, X29, LSR #0
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X10, X19, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X10, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X10, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X10, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X10, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X10, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X10, X19, X18
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X10, X19, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X10, X19, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X10, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X10, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X10, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X10, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X10, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MRS  X19, FPSR
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V0.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D0
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V1.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D1
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V2.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D2
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V3.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D3
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V4.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D4
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V5.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D5
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V6.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D6
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V7.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D7
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V8.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D8
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V9.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D9
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V10.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D10
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V11.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D11
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V12.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D12
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V13.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D13
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V14.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D14
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V15.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D15
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V16.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D16
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V17.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D17
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V18.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D18
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V19.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D19
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V20.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D20
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V21.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D21
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V22.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D22
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V23.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D23
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V24.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D24
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V25.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D25
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V26.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D26
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V27.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D27
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D28
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V29.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D29
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V30.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D30
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V31.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D31
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X9, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
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
    FMOV  D0, X29
    FMOV  V0.D[1], X26
    FMOV  D1, X23
    FMOV  V1.D[1], X25
    FMOV  D2, X11
    FMOV  V2.D[1], X28
    FMOV  D3, X24
    FMOV  V3.D[1], X22
    FMOV  D4, X11
    FMOV  V4.D[1], X13
    FMOV  D5, X10
    FMOV  V5.D[1], X13
    FMOV  D6, X8
    FMOV  V6.D[1], X12
    FMOV  D7, X29
    FMOV  V7.D[1], X11
    FMOV  D8, X17
    FMOV  V8.D[1], X27
    FMOV  D9, X11
    FMOV  V9.D[1], X21
    FMOV  D10, X26
    FMOV  V10.D[1], X20
    FMOV  D11, X13
    FMOV  V11.D[1], X20
    FMOV  D12, X15
    FMOV  V12.D[1], X22
    FMOV  D13, X25
    FMOV  V13.D[1], X28
    FMOV  D14, X11
    FMOV  V14.D[1], X12
    FMOV  D15, X16
    FMOV  V15.D[1], X8
    FMOV  D16, X16
    FMOV  V16.D[1], X8
    FMOV  D17, X24
    FMOV  V17.D[1], X10
    FMOV  D18, X3
    FMOV  V18.D[1], X29
    FMOV  D19, X8
    FMOV  V19.D[1], X12
    FMOV  D20, X24
    FMOV  V20.D[1], X28
    FMOV  D21, X24
    FMOV  V21.D[1], X12
    FMOV  D22, X13
    FMOV  V22.D[1], X18
    FMOV  D23, X19
    FMOV  V23.D[1], X22
    FMOV  D24, X19
    FMOV  V24.D[1], X29
    FMOV  D25, X19
    FMOV  V25.D[1], X15
    FMOV  D26, X27
    FMOV  V26.D[1], X13
    FMOV  D27, X15
    FMOV  V27.D[1], X23
    FMOV  D28, X13
    FMOV  V28.D[1], X17
    FMOV  D29, X11
    FMOV  V29.D[1], X24
    FMOV  D30, X16
    FMOV  V30.D[1], X11
    FMOV  D31, X27
    FMOV  V31.D[1], X29
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x40, LSL #0
    MOVZ  X12, #0x2d00, LSL #0
    ADD  X25, X30, X12, ASR #0
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X25]
    LD1R { V10.16B }, [X25]
    ADD  X25, X25, X23, LSR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X25]
    LD1R { V15.16B }, [X25]
    ADD  X25, X25, X23, LSR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X25]
    LD1R { V1.2D }, [X25]
    ADD  X25, X25, X23, LSR #0
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X25]
    LD1R { V5.4S }, [X25]
    ADD  X25, X25, X23, ASR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X25]
    LD1R { V28.8H }, [X25]
    ADD  X25, X25, X23, LSR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X25]
    LD1R { V7.8B }, [X25]
    ADD  X25, X25, X23, ASR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X25]
    LD1R { V13.1D }, [X25]
    ADD  X25, X25, X23
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X25]
    LD1R { V1.2S }, [X25]
    ADD  X25, X25, X23, LSR #0
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X25]
    LD1R { V23.4H }, [X25]
    ADD  X25, X25, X23, ASR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X25]
    LD1R { V28.8B }, [X25]
    ADD  X25, X25, X23, LSR #0
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X25]
    MOV  X18, X25
    LD1R { V10.8B }, [X18], #1
    ADD  X25, X25, X23, ASR #0
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X25]
    MOV  X18, X25
    LD1R { V10.16B }, [X18], #1
    ADD  X25, X25, X23, LSR #0
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X25]
    MOV  X18, X25
    LD1R { V26.8B }, [X18], #1
    ADD  X25, X25, X23, LSR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X25]
    MOV  X18, X25
    LD1R { V18.4H }, [X18], #2
    ADD  X25, X25, X23, LSR #0
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X25]
    MOV  X18, X25
    LD1R { V3.8H }, [X18], #2
    ADD  X25, X25, X23, ASR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X25]
    MOV  X18, X25
    LD1R { V12.2S }, [X18], #4
    ADD  X25, X25, X23
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X25]
    MOV  X18, X25
    LD1R { V19.2S }, [X18], #4
    ADD  X25, X25, X23, LSR #0
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X25]
    MOV  X18, X25
    LD1R { V26.4S }, [X18], #4
    ADD  X25, X25, X23
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X25]
    MOV  X18, X25
    LD1R { V26.2D }, [X18], #8
    ADD  X25, X25, X23, ASR #0
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X25]
    MOV  X18, X25
    LD1R { V12.1D }, [X18], #8
    ADD  X25, X25, X23
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X25]
    MOV  X18, X25
    LD1R { V22.2D }, [X18], #8
    ADD  X25, X25, X23, LSR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X25]
    MOV  X18, X25
    LD1R { V16.8H }, [X18], #2
    ADD  X25, X25, X23, LSR #0
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X25]
    LD1R { V28.2D }, [X25], X22
    ADD  X25, X25, X23
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X25]
    LD1R { V12.16B }, [X25], X22
    ADD  X25, X25, X23, ASR #0
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X25]
    LD1R { V20.2D }, [X25], X22
    ADD  X25, X25, X23, ASR #0
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X25]
    LD1R { V8.4S }, [X25], X22
    ADD  X25, X25, X23
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X25]
    LD1R { V7.8H }, [X25], X22
    ADD  X25, X25, X23, ASR #0
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X25]
    LD1R { V27.4H }, [X25], X22
    ADD  X25, X25, X23, ASR #0
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X25]
    LD1R { V15.1D }, [X25], X22
    ADD  X25, X25, X23, ASR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X25]
    LD1R { V16.2S }, [X25], X22
    ADD  X25, X25, X23, LSR #0
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X25]
    LD1R { V10.4H }, [X25], X22
    ADD  X25, X25, X23, ASR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X25]
    LD1R { V25.8B }, [X25], X22
    ADD  X25, X25, X23, ASR #0
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MRS  X14, FPSR
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V0.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D0
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V1.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D1
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D2
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D3
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D4
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D5
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D6
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D7
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D8
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D9
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D10
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D11
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D12
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D13
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V14.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D14
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D15
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D16
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D17
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D18
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D19
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D20
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D21
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D22
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D23
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D24
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D25
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D26
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D27
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D28
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D29
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V30.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D30
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, V31.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X14, D31
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X26, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X24
    FMOV  D1, X23
    FMOV  V1.D[1], X11
    FMOV  D2, X25
    FMOV  V2.D[1], X28
    FMOV  D3, X27
    FMOV  V3.D[1], X26
    FMOV  D4, X19
    FMOV  V4.D[1], X3
    FMOV  D5, X18
    FMOV  V5.D[1], X8
    FMOV  D6, X21
    FMOV  V6.D[1], X19
    FMOV  D7, X13
    FMOV  V7.D[1], X9
    FMOV  D8, X15
    FMOV  V8.D[1], X29
    FMOV  D9, X29
    FMOV  V9.D[1], X29
    FMOV  D10, X25
    FMOV  V10.D[1], X13
    FMOV  D11, X8
    FMOV  V11.D[1], X17
    FMOV  D12, X13
    FMOV  V12.D[1], X25
    FMOV  D13, X22
    FMOV  V13.D[1], X11
    FMOV  D14, X13
    FMOV  V14.D[1], X25
    FMOV  D15, X26
    FMOV  V15.D[1], X15
    FMOV  D16, X25
    FMOV  V16.D[1], X21
    FMOV  D17, X29
    FMOV  V17.D[1], X28
    FMOV  D18, X17
    FMOV  V18.D[1], X25
    FMOV  D19, X22
    FMOV  V19.D[1], X27
    FMOV  D20, X9
    FMOV  V20.D[1], X19
    FMOV  D21, X21
    FMOV  V21.D[1], X3
    FMOV  D22, X17
    FMOV  V22.D[1], X28
    FMOV  D23, X18
    FMOV  V23.D[1], X14
    FMOV  D24, X10
    FMOV  V24.D[1], X3
    FMOV  D25, X16
    FMOV  V25.D[1], X9
    FMOV  D26, X14
    FMOV  V26.D[1], X28
    FMOV  D27, X14
    FMOV  V27.D[1], X9
    FMOV  D28, X23
    FMOV  V28.D[1], X8
    FMOV  D29, X8
    FMOV  V29.D[1], X19
    FMOV  D30, X13
    FMOV  V30.D[1], X13
    FMOV  D31, X28
    FMOV  V31.D[1], X12
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X14, #0x40, LSL #0
    MOVZ  X21, #0x0, LSL #0
    ADD  X10, X30, X21, ASR #0
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X10]
    LD1R { V0.8H }, [X10]
    ADD  X10, X10, X14
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X10]
    LD1R { V1.16B }, [X10]
    ADD  X10, X10, X14, ASR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X10]
    LD1R { V1.2D }, [X10]
    ADD  X10, X10, X14, ASR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X10]
    LD1R { V11.4S }, [X10]
    ADD  X10, X10, X14
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X10]
    LD1R { V16.8H }, [X10]
    ADD  X10, X10, X14
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X10]
    LD1R { V27.1D }, [X10]
    ADD  X10, X10, X14
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X10]
    LD1R { V8.1D }, [X10]
    ADD  X10, X10, X14
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X10]
    LD1R { V23.2S }, [X10]
    ADD  X10, X10, X14, LSR #0
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X10]
    LD1R { V4.4H }, [X10]
    ADD  X10, X10, X14, ASR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X10]
    LD1R { V14.8B }, [X10]
    ADD  X10, X10, X14, ASR #0
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X10]
    MOV  X18, X10
    LD1R { V26.8B }, [X18], #1
    ADD  X10, X10, X14, ASR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X10]
    MOV  X18, X10
    LD1R { V12.16B }, [X18], #1
    ADD  X10, X10, X14, LSR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X10]
    MOV  X18, X10
    LD1R { V16.8B }, [X18], #1
    ADD  X10, X10, X14
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X10]
    MOV  X18, X10
    LD1R { V10.4H }, [X18], #2
    ADD  X10, X10, X14
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X10]
    MOV  X18, X10
    LD1R { V7.8H }, [X18], #2
    ADD  X10, X10, X14, ASR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X10]
    MOV  X18, X10
    LD1R { V14.2S }, [X18], #4
    ADD  X10, X10, X14, LSR #0
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X10]
    MOV  X18, X10
    LD1R { V1.2S }, [X18], #4
    ADD  X10, X10, X14
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X10]
    MOV  X18, X10
    LD1R { V28.4S }, [X18], #4
    ADD  X10, X10, X14, ASR #0
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X10]
    MOV  X18, X10
    LD1R { V0.1D }, [X18], #8
    ADD  X10, X10, X14
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X10]
    MOV  X18, X10
    LD1R { V18.1D }, [X18], #8
    ADD  X10, X10, X14, ASR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X10]
    MOV  X18, X10
    LD1R { V6.2D }, [X18], #8
    ADD  X10, X10, X14, ASR #0
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X10]
    MOV  X18, X10
    LD1R { V15.8H }, [X18], #2
    ADD  X10, X10, X14, ASR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X10]
    LD1R { V25.16B }, [X10], X8
    ADD  X10, X10, X14, LSR #0
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X10]
    LD1R { V13.16B }, [X10], X8
    ADD  X10, X10, X14
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X10]
    LD1R { V4.2D }, [X10], X8
    ADD  X10, X10, X14
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X10]
    LD1R { V30.4S }, [X10], X8
    ADD  X10, X10, X14, ASR #0
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X10]
    LD1R { V31.8H }, [X10], X8
    ADD  X10, X10, X14, ASR #0
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X10]
    LD1R { V0.8B }, [X10], X8
    ADD  X10, X10, X14, ASR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X10]
    LD1R { V10.1D }, [X10], X8
    ADD  X10, X10, X14, LSR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X10]
    LD1R { V11.2S }, [X10], X8
    ADD  X10, X10, X14
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X10]
    LD1R { V4.4H }, [X10], X8
    ADD  X10, X10, X14
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X10]
    LD1R { V28.8B }, [X10], X8
    ADD  X10, X10, X14
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X20, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X20, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X20, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X20, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X20, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X20, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X20, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X20, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X20, X27, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X20, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X20, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X20, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X20, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X20, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MRS  X27, FPSR
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V0.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D0
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V1.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D1
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V2.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D2
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V3.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D3
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V4.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D4
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V5.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D5
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V6.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D6
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V7.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D7
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D8
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V9.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D9
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V10.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D10
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V11.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D11
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V12.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D12
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V13.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D13
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V14.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D14
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V15.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D15
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V16.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D16
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V17.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D17
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D18
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V19.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D19
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V20.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D20
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V21.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D21
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V22.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D22
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D23
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V24.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D24
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V25.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D25
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V26.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D26
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V27.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D27
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D28
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V29.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D29
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V30.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D30
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V31.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D31
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X11, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
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
    FMOV  D0, X16
    FMOV  V0.D[1], X28
    FMOV  D1, X25
    FMOV  V1.D[1], X28
    FMOV  D2, X27
    FMOV  V2.D[1], X20
    FMOV  D3, X26
    FMOV  V3.D[1], X29
    FMOV  D4, X20
    FMOV  V4.D[1], X14
    FMOV  D5, X12
    FMOV  V5.D[1], X11
    FMOV  D6, X27
    FMOV  V6.D[1], X9
    FMOV  D7, X9
    FMOV  V7.D[1], X15
    FMOV  D8, X10
    FMOV  V8.D[1], X12
    FMOV  D9, X16
    FMOV  V9.D[1], X8
    FMOV  D10, X27
    FMOV  V10.D[1], X26
    FMOV  D11, X15
    FMOV  V11.D[1], X29
    FMOV  D12, X16
    FMOV  V12.D[1], X8
    FMOV  D13, X16
    FMOV  V13.D[1], X14
    FMOV  D14, X12
    FMOV  V14.D[1], X8
    FMOV  D15, X16
    FMOV  V15.D[1], X17
    FMOV  D16, X18
    FMOV  V16.D[1], X9
    FMOV  D17, X26
    FMOV  V17.D[1], X13
    FMOV  D18, X29
    FMOV  V18.D[1], X24
    FMOV  D19, X20
    FMOV  V19.D[1], X24
    FMOV  D20, X14
    FMOV  V20.D[1], X28
    FMOV  D21, X16
    FMOV  V21.D[1], X16
    FMOV  D22, X9
    FMOV  V22.D[1], X10
    FMOV  D23, X19
    FMOV  V23.D[1], X19
    FMOV  D24, X25
    FMOV  V24.D[1], X14
    FMOV  D25, X20
    FMOV  V25.D[1], X24
    FMOV  D26, X21
    FMOV  V26.D[1], X20
    FMOV  D27, X23
    FMOV  V27.D[1], X23
    FMOV  D28, X23
    FMOV  V28.D[1], X8
    FMOV  D29, X28
    FMOV  V29.D[1], X28
    FMOV  D30, X8
    FMOV  V30.D[1], X13
    FMOV  D31, X23
    FMOV  V31.D[1], X28
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X26, #0x40, LSL #0
    MOVZ  X13, #0x500, LSL #0
    ADD  X10, X30, X13, LSR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X10]
    LD1R { V14.2D }, [X10]
    ADD  X10, X10, X26, ASR #0
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X10]
    LD1R { V21.16B }, [X10]
    ADD  X10, X10, X26, ASR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X10]
    LD1R { V11.2D }, [X10]
    ADD  X10, X10, X26, LSR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X10]
    LD1R { V3.4S }, [X10]
    ADD  X10, X10, X26
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X10]
    LD1R { V16.8H }, [X10]
    ADD  X10, X10, X26, LSR #0
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X10]
    LD1R { V3.2S }, [X10]
    ADD  X10, X10, X26, ASR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X10]
    LD1R { V13.1D }, [X10]
    ADD  X10, X10, X26, LSR #0
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X10]
    LD1R { V24.2S }, [X10]
    ADD  X10, X10, X26, LSR #0
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X10]
    LD1R { V25.4H }, [X10]
    ADD  X10, X10, X26
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X10]
    LD1R { V25.8B }, [X10]
    ADD  X10, X10, X26, LSR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X10]
    MOV  X18, X10
    LD1R { V23.8B }, [X18], #1
    ADD  X10, X10, X26
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X10]
    MOV  X18, X10
    LD1R { V14.16B }, [X18], #1
    ADD  X10, X10, X26, LSR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X10]
    MOV  X18, X10
    LD1R { V6.8B }, [X18], #1
    ADD  X10, X10, X26
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X10]
    MOV  X18, X10
    LD1R { V5.4H }, [X18], #2
    ADD  X10, X10, X26, ASR #0
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X10]
    MOV  X18, X10
    LD1R { V6.8H }, [X18], #2
    ADD  X10, X10, X26, ASR #0
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X10]
    MOV  X18, X10
    LD1R { V3.2S }, [X18], #4
    ADD  X10, X10, X26, ASR #0
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X10]
    MOV  X18, X10
    LD1R { V4.2S }, [X18], #4
    ADD  X10, X10, X26
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X10]
    MOV  X18, X10
    LD1R { V30.4S }, [X18], #4
    ADD  X10, X10, X26, LSR #0
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X10]
    MOV  X18, X10
    LD1R { V22.1D }, [X18], #8
    ADD  X10, X10, X26, ASR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X10]
    MOV  X18, X10
    LD1R { V28.1D }, [X18], #8
    ADD  X10, X10, X26
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X10]
    MOV  X18, X10
    LD1R { V29.2D }, [X18], #8
    ADD  X10, X10, X26, ASR #0
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X10]
    MOV  X18, X10
    LD1R { V24.4H }, [X18], #2
    ADD  X10, X10, X26
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X10]
    LD1R { V21.4S }, [X10], X19
    ADD  X10, X10, X26
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X10]
    LD1R { V28.16B }, [X10], X19
    ADD  X10, X10, X26
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X10]
    LD1R { V14.2D }, [X10], X19
    ADD  X10, X10, X26
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X10]
    LD1R { V27.4S }, [X10], X19
    ADD  X10, X10, X26, LSR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X10]
    LD1R { V4.8H }, [X10], X19
    ADD  X10, X10, X26, ASR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X10]
    LD1R { V15.4H }, [X10], X19
    ADD  X10, X10, X26, ASR #0
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X10]
    LD1R { V18.1D }, [X10], X19
    ADD  X10, X10, X26, ASR #0
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X10]
    LD1R { V29.2S }, [X10], X19
    ADD  X10, X10, X26, ASR #0
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X10]
    LD1R { V30.4H }, [X10], X19
    ADD  X10, X10, X26, LSR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X10]
    LD1R { V13.8B }, [X10], X19
    ADD  X10, X10, X26, ASR #0
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MRS  X17, FPSR
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V0.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D0
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V1.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D1
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V2.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D2
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V3.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D3
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D4
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V5.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D5
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V6.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D6
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D7
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V8.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D8
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V9.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D9
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V10.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D10
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V11.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D11
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V12.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D12
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V13.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D13
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D14
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V15.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D15
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V16.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D16
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V17.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D17
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D18
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V19.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D19
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D20
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V21.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D21
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D22
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D23
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V24.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D24
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D25
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V26.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D26
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V27.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D27
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V28.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D28
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V29.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D29
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V30.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D30
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, V31.D[1]
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X17, D31
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X8
    FMOV  D1, X17
    FMOV  V1.D[1], X19
    FMOV  D2, X28
    FMOV  V2.D[1], X21
    FMOV  D3, X24
    FMOV  V3.D[1], X25
    FMOV  D4, X29
    FMOV  V4.D[1], X14
    FMOV  D5, X9
    FMOV  V5.D[1], X22
    FMOV  D6, X21
    FMOV  V6.D[1], X8
    FMOV  D7, X17
    FMOV  V7.D[1], X19
    FMOV  D8, X28
    FMOV  V8.D[1], X18
    FMOV  D9, X22
    FMOV  V9.D[1], X9
    FMOV  D10, X13
    FMOV  V10.D[1], X16
    FMOV  D11, X17
    FMOV  V11.D[1], X23
    FMOV  D12, X15
    FMOV  V12.D[1], X26
    FMOV  D13, X12
    FMOV  V13.D[1], X19
    FMOV  D14, X23
    FMOV  V14.D[1], X12
    FMOV  D15, X8
    FMOV  V15.D[1], X16
    FMOV  D16, X9
    FMOV  V16.D[1], X28
    FMOV  D17, X21
    FMOV  V17.D[1], X18
    FMOV  D18, X10
    FMOV  V18.D[1], X17
    FMOV  D19, X25
    FMOV  V19.D[1], X13
    FMOV  D20, X18
    FMOV  V20.D[1], X27
    FMOV  D21, X16
    FMOV  V21.D[1], X17
    FMOV  D22, X14
    FMOV  V22.D[1], X16
    FMOV  D23, X24
    FMOV  V23.D[1], X19
    FMOV  D24, X29
    FMOV  V24.D[1], X14
    FMOV  D25, X25
    FMOV  V25.D[1], X25
    FMOV  D26, X19
    FMOV  V26.D[1], X23
    FMOV  D27, X20
    FMOV  V27.D[1], X27
    FMOV  D28, X10
    FMOV  V28.D[1], X25
    FMOV  D29, X11
    FMOV  V29.D[1], X25
    FMOV  D30, X28
    FMOV  V30.D[1], X28
    FMOV  D31, X26
    FMOV  V31.D[1], X11
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X8, #0x40, LSL #0
    MOVZ  X21, #0xa00, LSL #0
    ADD  X28, X30, X21, ASR #0
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X28]
    LD1R { V0.16B }, [X28]
    ADD  X28, X28, X8, ASR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X28]
    LD1R { V17.16B }, [X28]
    ADD  X28, X28, X8, ASR #0
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X28]
    LD1R { V8.2D }, [X28]
    ADD  X28, X28, X8, LSR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X28]
    LD1R { V27.4S }, [X28]
    ADD  X28, X28, X8, ASR #0
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X28]
    LD1R { V13.8H }, [X28]
    ADD  X28, X28, X8
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X28]
    LD1R { V3.2S }, [X28]
    ADD  X28, X28, X8, LSR #0
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X28]
    LD1R { V23.1D }, [X28]
    ADD  X28, X28, X8, LSR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X28]
    LD1R { V4.2S }, [X28]
    ADD  X28, X28, X8
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X28]
    LD1R { V14.4H }, [X28]
    ADD  X28, X28, X8, LSR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X28]
    LD1R { V31.8B }, [X28]
    ADD  X28, X28, X8, LSR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X28]
    MOV  X3, X28
    LD1R { V15.8B }, [X3], #1
    ADD  X28, X28, X8, LSR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X28]
    MOV  X3, X28
    LD1R { V0.16B }, [X3], #1
    ADD  X28, X28, X8, LSR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X28]
    MOV  X3, X28
    LD1R { V0.8B }, [X3], #1
    ADD  X28, X28, X8
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X28]
    MOV  X3, X28
    LD1R { V3.4H }, [X3], #2
    ADD  X28, X28, X8, LSR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X28]
    MOV  X3, X28
    LD1R { V19.8H }, [X3], #2
    ADD  X28, X28, X8, ASR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X28]
    MOV  X3, X28
    LD1R { V0.2S }, [X3], #4
    ADD  X28, X28, X8, ASR #0
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X28]
    MOV  X3, X28
    LD1R { V29.2S }, [X3], #4
    ADD  X28, X28, X8, ASR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X28]
    MOV  X3, X28
    LD1R { V14.4S }, [X3], #4
    ADD  X28, X28, X8, LSR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X28]
    MOV  X3, X28
    LD1R { V2.1D }, [X3], #8
    ADD  X28, X28, X8
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X28]
    MOV  X3, X28
    LD1R { V7.1D }, [X3], #8
    ADD  X28, X28, X8, ASR #0
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X28]
    MOV  X3, X28
    LD1R { V6.2D }, [X3], #8
    ADD  X28, X28, X8, LSR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X28]
    MOV  X3, X28
    LD1R { V31.4H }, [X3], #2
    ADD  X28, X28, X8
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X28]
    LD1R { V6.2D }, [X28], X19
    ADD  X28, X28, X8, LSR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X28]
    LD1R { V11.16B }, [X28], X19
    ADD  X28, X28, X8, ASR #0
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X28]
    LD1R { V6.2D }, [X28], X19
    ADD  X28, X28, X8, LSR #0
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X28]
    LD1R { V8.4S }, [X28], X19
    ADD  X28, X28, X8, LSR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X28]
    LD1R { V21.8H }, [X28], X19
    ADD  X28, X28, X8
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X28]
    LD1R { V15.8B }, [X28], X19
    ADD  X28, X28, X8
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X28]
    LD1R { V9.1D }, [X28], X19
    ADD  X28, X28, X8, ASR #0
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X28]
    LD1R { V22.2S }, [X28], X19
    ADD  X28, X28, X8, ASR #0
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X28]
    LD1R { V10.4H }, [X28], X19
    ADD  X28, X28, X8, ASR #0
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X28]
    LD1R { V14.8B }, [X28], X19
    ADD  X28, X28, X8, LSR #0
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MRS  X23, FPSR
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V0.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D0
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V1.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D1
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D2
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D3
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D4
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D5
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D6
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D7
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D8
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D9
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D10
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D11
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D12
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D13
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D14
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D15
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D16
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D17
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D18
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D19
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D20
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D21
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D22
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V23.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D23
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D24
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D25
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D26
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D27
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D28
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D29
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V30.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D30
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, V31.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X23, D31
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
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
    FMOV  V0.D[1], X25
    FMOV  D1, X18
    FMOV  V1.D[1], X26
    FMOV  D2, X25
    FMOV  V2.D[1], X29
    FMOV  D3, X22
    FMOV  V3.D[1], X28
    FMOV  D4, X10
    FMOV  V4.D[1], X24
    FMOV  D5, X10
    FMOV  V5.D[1], X9
    FMOV  D6, X3
    FMOV  V6.D[1], X8
    FMOV  D7, X19
    FMOV  V7.D[1], X25
    FMOV  D8, X8
    FMOV  V8.D[1], X3
    FMOV  D9, X20
    FMOV  V9.D[1], X29
    FMOV  D10, X13
    FMOV  V10.D[1], X12
    FMOV  D11, X16
    FMOV  V11.D[1], X8
    FMOV  D12, X27
    FMOV  V12.D[1], X27
    FMOV  D13, X28
    FMOV  V13.D[1], X22
    FMOV  D14, X28
    FMOV  V14.D[1], X28
    FMOV  D15, X25
    FMOV  V15.D[1], X29
    FMOV  D16, X14
    FMOV  V16.D[1], X21
    FMOV  D17, X8
    FMOV  V17.D[1], X12
    FMOV  D18, X16
    FMOV  V18.D[1], X3
    FMOV  D19, X23
    FMOV  V19.D[1], X14
    FMOV  D20, X14
    FMOV  V20.D[1], X23
    FMOV  D21, X19
    FMOV  V21.D[1], X21
    FMOV  D22, X26
    FMOV  V22.D[1], X13
    FMOV  D23, X10
    FMOV  V23.D[1], X15
    FMOV  D24, X14
    FMOV  V24.D[1], X20
    FMOV  D25, X3
    FMOV  V25.D[1], X13
    FMOV  D26, X9
    FMOV  V26.D[1], X29
    FMOV  D27, X20
    FMOV  V27.D[1], X8
    FMOV  D28, X3
    FMOV  V28.D[1], X25
    FMOV  D29, X25
    FMOV  V29.D[1], X12
    FMOV  D30, X20
    FMOV  V30.D[1], X8
    FMOV  D31, X14
    FMOV  V31.D[1], X20
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X12, #0x40, LSL #0
    MOVZ  X3, #0xf00, LSL #0
    ADD  X15, X30, X3, ASR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X15]
    LD1R { V0.4S }, [X15]
    ADD  X15, X15, X12, LSR #0
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X15]
    LD1R { V8.16B }, [X15]
    ADD  X15, X15, X12, LSR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X15]
    LD1R { V28.2D }, [X15]
    ADD  X15, X15, X12, LSR #0
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X15]
    LD1R { V6.4S }, [X15]
    ADD  X15, X15, X12, ASR #0
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X15]
    LD1R { V31.8H }, [X15]
    ADD  X15, X15, X12, LSR #0
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X15]
    LD1R { V28.2S }, [X15]
    ADD  X15, X15, X12, ASR #0
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X15]
    LD1R { V24.1D }, [X15]
    ADD  X15, X15, X12
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X15]
    LD1R { V11.2S }, [X15]
    ADD  X15, X15, X12
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X15]
    LD1R { V17.4H }, [X15]
    ADD  X15, X15, X12, ASR #0
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X15]
    LD1R { V20.8B }, [X15]
    ADD  X15, X15, X12
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X15]
    MOV  X28, X15
    LD1R { V22.8B }, [X28], #1
    ADD  X15, X15, X12
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X15]
    MOV  X28, X15
    LD1R { V23.16B }, [X28], #1
    ADD  X15, X15, X12, LSR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X15]
    MOV  X28, X15
    LD1R { V16.8B }, [X28], #1
    ADD  X15, X15, X12, ASR #0
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X15]
    MOV  X28, X15
    LD1R { V7.4H }, [X28], #2
    ADD  X15, X15, X12
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X15]
    MOV  X28, X15
    LD1R { V18.8H }, [X28], #2
    ADD  X15, X15, X12
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X15]
    MOV  X28, X15
    LD1R { V14.2S }, [X28], #4
    ADD  X15, X15, X12, ASR #0
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X15]
    MOV  X28, X15
    LD1R { V23.2S }, [X28], #4
    ADD  X15, X15, X12
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X15]
    MOV  X28, X15
    LD1R { V19.4S }, [X28], #4
    ADD  X15, X15, X12, LSR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X15]
    MOV  X28, X15
    LD1R { V14.2D }, [X28], #8
    ADD  X15, X15, X12, LSR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X15]
    MOV  X28, X15
    LD1R { V5.1D }, [X28], #8
    ADD  X15, X15, X12, ASR #0
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X15]
    MOV  X28, X15
    LD1R { V30.2D }, [X28], #8
    ADD  X15, X15, X12
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X15]
    MOV  X28, X15
    LD1R { V25.8H }, [X28], #2
    ADD  X15, X15, X12
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X15]
    LD1R { V4.2D }, [X15], X16
    ADD  X15, X15, X12
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X15]
    LD1R { V2.16B }, [X15], X16
    ADD  X15, X15, X12, LSR #0
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X15]
    LD1R { V1.2D }, [X15], X16
    ADD  X15, X15, X12, ASR #0
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X15]
    LD1R { V5.4S }, [X15], X16
    ADD  X15, X15, X12
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X15]
    LD1R { V21.8H }, [X15], X16
    ADD  X15, X15, X12, ASR #0
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X15]
    LD1R { V19.2S }, [X15], X16
    ADD  X15, X15, X12, LSR #0
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X15]
    LD1R { V4.1D }, [X15], X16
    ADD  X15, X15, X12, ASR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X15]
    LD1R { V12.2S }, [X15], X16
    ADD  X15, X15, X12
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X15]
    LD1R { V6.4H }, [X15], X16
    ADD  X15, X15, X12, ASR #0
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X15]
    LD1R { V5.8B }, [X15], X16
    ADD  X15, X15, X12
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X24, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP01_TestFail
    MRS  X27, FPSR
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V0.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D0
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V1.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D1
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V2.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D2
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V3.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D3
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D4
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D5
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D6
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V7.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D7
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D8
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V9.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D9
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V10.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D10
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V11.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D11
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V12.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D12
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V13.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D13
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V14.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D14
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V15.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D15
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V16.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D16
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D17
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D18
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D19
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V20.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D20
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V21.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D21
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V22.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D22
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D23
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V24.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D24
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V25.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D25
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V26.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D26
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V27.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D27
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D28
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V29.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D29
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V30.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D30
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, V31.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X27, D31
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X14, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    FMOV  D0, X25
    FMOV  V0.D[1], X23
    FMOV  D1, X29
    FMOV  V1.D[1], X11
    FMOV  D2, X26
    FMOV  V2.D[1], X28
    FMOV  D3, X27
    FMOV  V3.D[1], X26
    FMOV  D4, X25
    FMOV  V4.D[1], X23
    FMOV  D5, X16
    FMOV  V5.D[1], X22
    FMOV  D6, X27
    FMOV  V6.D[1], X9
    FMOV  D7, X27
    FMOV  V7.D[1], X8
    FMOV  D8, X27
    FMOV  V8.D[1], X12
    FMOV  D9, X12
    FMOV  V9.D[1], X26
    FMOV  D10, X23
    FMOV  V10.D[1], X15
    FMOV  D11, X29
    FMOV  V11.D[1], X9
    FMOV  D12, X11
    FMOV  V12.D[1], X24
    FMOV  D13, X29
    FMOV  V13.D[1], X15
    FMOV  D14, X12
    FMOV  V14.D[1], X11
    FMOV  D15, X3
    FMOV  V15.D[1], X26
    FMOV  D16, X29
    FMOV  V16.D[1], X27
    FMOV  D17, X18
    FMOV  V17.D[1], X8
    FMOV  D18, X25
    FMOV  V18.D[1], X17
    FMOV  D19, X16
    FMOV  V19.D[1], X26
    FMOV  D20, X11
    FMOV  V20.D[1], X11
    FMOV  D21, X15
    FMOV  V21.D[1], X10
    FMOV  D22, X18
    FMOV  V22.D[1], X22
    FMOV  D23, X20
    FMOV  V23.D[1], X12
    FMOV  D24, X20
    FMOV  V24.D[1], X20
    FMOV  D25, X13
    FMOV  V25.D[1], X14
    FMOV  D26, X8
    FMOV  V26.D[1], X18
    FMOV  D27, X8
    FMOV  V27.D[1], X23
    FMOV  D28, X15
    FMOV  V28.D[1], X16
    FMOV  D29, X9
    FMOV  V29.D[1], X20
    FMOV  D30, X19
    FMOV  V30.D[1], X27
    FMOV  D31, X9
    FMOV  V31.D[1], X25
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X20, #0x40, LSL #0
    MOVZ  X10, #0x1400, LSL #0
    ADD  X27, X30, X10, LSR #0
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X27]
    LD1R { V21.8H }, [X27]
    ADD  X27, X27, X20, ASR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X27]
    LD1R { V13.16B }, [X27]
    ADD  X27, X27, X20, ASR #0
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X27]
    LD1R { V20.2D }, [X27]
    ADD  X27, X27, X20, LSR #0
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X27]
    LD1R { V4.4S }, [X27]
    ADD  X27, X27, X20, LSR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X27]
    LD1R { V19.8H }, [X27]
    ADD  X27, X27, X20, ASR #0
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X27]
    LD1R { V25.4H }, [X27]
    ADD  X27, X27, X20, ASR #0
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X27]
    LD1R { V12.1D }, [X27]
    ADD  X27, X27, X20, LSR #0
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X27]
    LD1R { V22.2S }, [X27]
    ADD  X27, X27, X20, LSR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X27]
    LD1R { V10.4H }, [X27]
    ADD  X27, X27, X20, LSR #0
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X27]
    LD1R { V27.8B }, [X27]
    ADD  X27, X27, X20, LSR #0
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X27]
    MOV  X12, X27
    LD1R { V0.8B }, [X12], #1
    ADD  X27, X27, X20, LSR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X27]
    MOV  X12, X27
    LD1R { V4.16B }, [X12], #1
    ADD  X27, X27, X20, ASR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X27]
    MOV  X12, X27
    LD1R { V0.8B }, [X12], #1
    ADD  X27, X27, X20, LSR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X27]
    MOV  X12, X27
    LD1R { V29.4H }, [X12], #2
    ADD  X27, X27, X20
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X27]
    MOV  X12, X27
    LD1R { V28.8H }, [X12], #2
    ADD  X27, X27, X20
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X27]
    MOV  X12, X27
    LD1R { V24.2S }, [X12], #4
    ADD  X27, X27, X20, ASR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X27]
    MOV  X12, X27
    LD1R { V20.2S }, [X12], #4
    ADD  X27, X27, X20
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X27]
    MOV  X12, X27
    LD1R { V8.4S }, [X12], #4
    ADD  X27, X27, X20, LSR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X27]
    MOV  X12, X27
    LD1R { V13.1D }, [X12], #8
    ADD  X27, X27, X20, LSR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X27]
    MOV  X12, X27
    LD1R { V2.1D }, [X12], #8
    ADD  X27, X27, X20, ASR #0
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X27]
    MOV  X12, X27
    LD1R { V29.2D }, [X12], #8
    ADD  X27, X27, X20, ASR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X27]
    MOV  X12, X27
    LD1R { V6.4H }, [X12], #2
    ADD  X27, X27, X20, ASR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X27]
    LD1R { V22.8H }, [X27], X8
    ADD  X27, X27, X20
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X27]
    LD1R { V7.16B }, [X27], X8
    ADD  X27, X27, X20
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X27]
    LD1R { V5.2D }, [X27], X8
    ADD  X27, X27, X20, ASR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X27]
    LD1R { V30.4S }, [X27], X8
    ADD  X27, X27, X20, LSR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X27]
    LD1R { V11.8H }, [X27], X8
    ADD  X27, X27, X20, ASR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X27]
    LD1R { V29.2S }, [X27], X8
    ADD  X27, X27, X20
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X27]
    LD1R { V25.1D }, [X27], X8
    ADD  X27, X27, X20
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X27]
    LD1R { V20.2S }, [X27], X8
    ADD  X27, X27, X20
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X27]
    LD1R { V0.4H }, [X27], X8
    ADD  X27, X27, X20
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X27]
    LD1R { V19.8B }, [X27], X8
    ADD  X27, X27, X20, ASR #0
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X29, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X29, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X29, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X29, X25, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X29, X25, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X29, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X29, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X29, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X29, X25, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X29, X25, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X29, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X29, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X29, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X29, X25, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MRS  X25, FPSR
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V0.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D0
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V1.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D1
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V2.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D2
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V3.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D3
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V4.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D4
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V5.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D5
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V6.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D6
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V7.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D7
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V8.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D8
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V9.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D9
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D10
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V11.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D11
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V12.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D12
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V13.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D13
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V14.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D14
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V15.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D15
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V16.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D16
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V17.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D17
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V18.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D18
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V19.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D19
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V20.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D20
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V21.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D21
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V22.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D22
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V23.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D23
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V24.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D24
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D25
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V26.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D26
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V27.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D27
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V28.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D28
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V29.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D29
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V30.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D30
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V31.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D31
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
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
    FMOV  V0.D[1], X29
    FMOV  D1, X26
    FMOV  V1.D[1], X28
    FMOV  D2, X27
    FMOV  V2.D[1], X26
    FMOV  D3, X8
    FMOV  V3.D[1], X23
    FMOV  D4, X26
    FMOV  V4.D[1], X22
    FMOV  D5, X12
    FMOV  V5.D[1], X19
    FMOV  D6, X23
    FMOV  V6.D[1], X8
    FMOV  D7, X29
    FMOV  V7.D[1], X12
    FMOV  D8, X12
    FMOV  V8.D[1], X20
    FMOV  D9, X24
    FMOV  V9.D[1], X3
    FMOV  D10, X10
    FMOV  V10.D[1], X14
    FMOV  D11, X14
    FMOV  V11.D[1], X28
    FMOV  D12, X11
    FMOV  V12.D[1], X27
    FMOV  D13, X12
    FMOV  V13.D[1], X11
    FMOV  D14, X19
    FMOV  V14.D[1], X12
    FMOV  D15, X27
    FMOV  V15.D[1], X27
    FMOV  D16, X15
    FMOV  V16.D[1], X26
    FMOV  D17, X8
    FMOV  V17.D[1], X8
    FMOV  D18, X3
    FMOV  V18.D[1], X28
    FMOV  D19, X24
    FMOV  V19.D[1], X19
    FMOV  D20, X28
    FMOV  V20.D[1], X26
    FMOV  D21, X28
    FMOV  V21.D[1], X15
    FMOV  D22, X12
    FMOV  V22.D[1], X24
    FMOV  D23, X23
    FMOV  V23.D[1], X8
    FMOV  D24, X13
    FMOV  V24.D[1], X19
    FMOV  D25, X16
    FMOV  V25.D[1], X26
    FMOV  D26, X12
    FMOV  V26.D[1], X12
    FMOV  D27, X23
    FMOV  V27.D[1], X24
    FMOV  D28, X14
    FMOV  V28.D[1], X19
    FMOV  D29, X24
    FMOV  V29.D[1], X26
    FMOV  D30, X17
    FMOV  V30.D[1], X29
    FMOV  D31, X27
    FMOV  V31.D[1], X8
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X17, #0x40, LSL #0
    MOVZ  X23, #0x1900, LSL #0
    ADD  X8, X30, X23, LSR #0
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X8]
    LD1R { V20.8H }, [X8]
    ADD  X8, X8, X17
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X8]
    LD1R { V18.16B }, [X8]
    ADD  X8, X8, X17, ASR #0
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X8]
    LD1R { V29.2D }, [X8]
    ADD  X8, X8, X17
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X8]
    LD1R { V3.4S }, [X8]
    ADD  X8, X8, X17, LSR #0
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X8]
    LD1R { V17.8H }, [X8]
    ADD  X8, X8, X17, ASR #0
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X8]
    LD1R { V16.2S }, [X8]
    ADD  X8, X8, X17, LSR #0
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X8]
    LD1R { V5.1D }, [X8]
    ADD  X8, X8, X17
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X8]
    LD1R { V14.2S }, [X8]
    ADD  X8, X8, X17, ASR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X8]
    LD1R { V30.4H }, [X8]
    ADD  X8, X8, X17, LSR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X8]
    LD1R { V28.8B }, [X8]
    ADD  X8, X8, X17, LSR #0
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X8]
    MOV  X16, X8
    LD1R { V2.8B }, [X16], #1
    ADD  X8, X8, X17
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X8]
    MOV  X16, X8
    LD1R { V30.16B }, [X16], #1
    ADD  X8, X8, X17, ASR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X8]
    MOV  X16, X8
    LD1R { V23.8B }, [X16], #1
    ADD  X8, X8, X17
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X8]
    MOV  X16, X8
    LD1R { V24.4H }, [X16], #2
    ADD  X8, X8, X17, LSR #0
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X8]
    MOV  X16, X8
    LD1R { V4.8H }, [X16], #2
    ADD  X8, X8, X17, ASR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X8]
    MOV  X16, X8
    LD1R { V1.4S }, [X16], #4
    ADD  X8, X8, X17, LSR #0
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X8]
    MOV  X16, X8
    LD1R { V26.2S }, [X16], #4
    ADD  X8, X8, X17, LSR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X8]
    MOV  X16, X8
    LD1R { V20.4S }, [X16], #4
    ADD  X8, X8, X17, ASR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X8]
    MOV  X16, X8
    LD1R { V12.2D }, [X16], #8
    ADD  X8, X8, X17, LSR #0
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X8]
    MOV  X16, X8
    LD1R { V3.1D }, [X16], #8
    ADD  X8, X8, X17, LSR #0
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X8]
    MOV  X16, X8
    LD1R { V18.2D }, [X16], #8
    ADD  X8, X8, X17, ASR #0
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X8]
    MOV  X16, X8
    LD1R { V10.4H }, [X16], #2
    ADD  X8, X8, X17
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X8]
    LD1R { V9.16B }, [X8], X29
    ADD  X8, X8, X17
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X8]
    LD1R { V1.16B }, [X8], X29
    ADD  X8, X8, X17, ASR #0
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X8]
    LD1R { V5.2D }, [X8], X29
    ADD  X8, X8, X17, LSR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X8]
    LD1R { V9.4S }, [X8], X29
    ADD  X8, X8, X17, ASR #0
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X8]
    LD1R { V8.8H }, [X8], X29
    ADD  X8, X8, X17
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X8]
    LD1R { V30.4H }, [X8], X29
    ADD  X8, X8, X17, ASR #0
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X8]
    LD1R { V4.1D }, [X8], X29
    ADD  X8, X8, X17, LSR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X8]
    LD1R { V10.2S }, [X8], X29
    ADD  X8, X8, X17, ASR #0
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X8]
    LD1R { V31.4H }, [X8], X29
    ADD  X8, X8, X17, ASR #0
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X8]
    LD1R { V17.8B }, [X8], X29
    ADD  X8, X8, X17, LSR #0
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X27, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X27, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X27, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X27, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X27, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X27, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X27, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X27, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X27, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X27, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X27, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X27, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X27, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MRS  X13, FPSR
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V0.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D0
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V1.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D1
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D2
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D3
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V4.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D4
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D5
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D6
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V7.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D7
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V8.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D8
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D9
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D10
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D11
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D12
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V13.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D13
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V14.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D14
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D15
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D16
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D17
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D18
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D19
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D20
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D21
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D22
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V23.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D23
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D24
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D25
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V26.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D26
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D27
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V28.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D28
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V29.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D29
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V30.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D30
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, V31.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X13, D31
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X26, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X19
    FMOV  D1, X25
    FMOV  V1.D[1], X26
    FMOV  D2, X13
    FMOV  V2.D[1], X29
    FMOV  D3, X20
    FMOV  V3.D[1], X28
    FMOV  D4, X11
    FMOV  V4.D[1], X25
    FMOV  D5, X29
    FMOV  V5.D[1], X11
    FMOV  D6, X9
    FMOV  V6.D[1], X18
    FMOV  D7, X25
    FMOV  V7.D[1], X22
    FMOV  D8, X14
    FMOV  V8.D[1], X24
    FMOV  D9, X11
    FMOV  V9.D[1], X20
    FMOV  D10, X11
    FMOV  V10.D[1], X8
    FMOV  D11, X21
    FMOV  V11.D[1], X25
    FMOV  D12, X29
    FMOV  V12.D[1], X22
    FMOV  D13, X8
    FMOV  V13.D[1], X26
    FMOV  D14, X29
    FMOV  V14.D[1], X28
    FMOV  D15, X22
    FMOV  V15.D[1], X24
    FMOV  D16, X10
    FMOV  V16.D[1], X18
    FMOV  D17, X3
    FMOV  V17.D[1], X9
    FMOV  D18, X23
    FMOV  V18.D[1], X19
    FMOV  D19, X23
    FMOV  V19.D[1], X17
    FMOV  D20, X10
    FMOV  V20.D[1], X14
    FMOV  D21, X18
    FMOV  V21.D[1], X24
    FMOV  D22, X18
    FMOV  V22.D[1], X26
    FMOV  D23, X27
    FMOV  V23.D[1], X19
    FMOV  D24, X9
    FMOV  V24.D[1], X13
    FMOV  D25, X28
    FMOV  V25.D[1], X8
    FMOV  D26, X8
    FMOV  V26.D[1], X29
    FMOV  D27, X21
    FMOV  V27.D[1], X15
    FMOV  D28, X14
    FMOV  V28.D[1], X27
    FMOV  D29, X15
    FMOV  V29.D[1], X9
    FMOV  D30, X25
    FMOV  V30.D[1], X27
    FMOV  D31, X11
    FMOV  V31.D[1], X24
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x40, LSL #0
    MOVZ  X12, #0x1e00, LSL #0
    ADD  X20, X30, X12, ASR #0
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X20]
    LD1R { V25.16B }, [X20]
    ADD  X20, X20, X28, ASR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X20]
    LD1R { V25.16B }, [X20]
    ADD  X20, X20, X28
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X20]
    LD1R { V19.2D }, [X20]
    ADD  X20, X20, X28, LSR #0
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X20]
    LD1R { V29.4S }, [X20]
    ADD  X20, X20, X28
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X20]
    LD1R { V11.8H }, [X20]
    ADD  X20, X20, X28, ASR #0
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X20]
    LD1R { V16.4H }, [X20]
    ADD  X20, X20, X28, ASR #0
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X20]
    LD1R { V31.1D }, [X20]
    ADD  X20, X20, X28, ASR #0
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X20]
    LD1R { V21.2S }, [X20]
    ADD  X20, X20, X28
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X20]
    LD1R { V3.4H }, [X20]
    ADD  X20, X20, X28, ASR #0
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X20]
    LD1R { V2.8B }, [X20]
    ADD  X20, X20, X28
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X20]
    MOV  X10, X20
    LD1R { V18.16B }, [X10], #1
    ADD  X20, X20, X28, ASR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X20]
    MOV  X10, X20
    LD1R { V9.16B }, [X10], #1
    ADD  X20, X20, X28, ASR #0
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X20]
    MOV  X10, X20
    LD1R { V20.8B }, [X10], #1
    ADD  X20, X20, X28, ASR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X20]
    MOV  X10, X20
    LD1R { V1.4H }, [X10], #2
    ADD  X20, X20, X28
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X20]
    MOV  X10, X20
    LD1R { V27.8H }, [X10], #2
    ADD  X20, X20, X28, LSR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X20]
    MOV  X10, X20
    LD1R { V28.4S }, [X10], #4
    ADD  X20, X20, X28
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X20]
    MOV  X10, X20
    LD1R { V14.2S }, [X10], #4
    ADD  X20, X20, X28, ASR #0
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X20]
    MOV  X10, X20
    LD1R { V26.4S }, [X10], #4
    ADD  X20, X20, X28, ASR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X20]
    MOV  X10, X20
    LD1R { V26.2D }, [X10], #8
    ADD  X20, X20, X28
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X20]
    MOV  X10, X20
    LD1R { V29.1D }, [X10], #8
    ADD  X20, X20, X28
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X20]
    MOV  X10, X20
    LD1R { V7.2D }, [X10], #8
    ADD  X20, X20, X28
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X20]
    MOV  X10, X20
    LD1R { V16.4H }, [X10], #2
    ADD  X20, X20, X28, ASR #0
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X20]
    LD1R { V9.2D }, [X20], X27
    ADD  X20, X20, X28, ASR #0
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X20]
    LD1R { V2.16B }, [X20], X27
    ADD  X20, X20, X28, LSR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X20]
    LD1R { V19.2D }, [X20], X27
    ADD  X20, X20, X28, ASR #0
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X20]
    LD1R { V3.4S }, [X20], X27
    ADD  X20, X20, X28, ASR #0
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X20]
    LD1R { V18.8H }, [X20], X27
    ADD  X20, X20, X28
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X20]
    LD1R { V0.8B }, [X20], X27
    ADD  X20, X20, X28, LSR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X20]
    LD1R { V10.1D }, [X20], X27
    ADD  X20, X20, X28, ASR #0
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X20]
    LD1R { V15.2S }, [X20], X27
    ADD  X20, X20, X28
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X20]
    LD1R { V21.4H }, [X20], X27
    ADD  X20, X20, X28, LSR #0
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X20]
    LD1R { V30.8B }, [X20], X27
    ADD  X20, X20, X28, LSR #0
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X18, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X18, X19, X8
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X18, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X18, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X18, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X18, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X18, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X18, X19, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X18, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X18, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X18, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X18, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X18, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X18, X19, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MRS  X19, FPSR
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V0.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D0
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V1.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D1
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V2.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D2
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V3.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D3
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V4.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D4
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V5.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D5
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V6.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D6
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V7.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D7
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V8.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D8
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V9.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D9
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V10.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D10
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V11.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D11
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V12.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D12
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V13.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D13
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V14.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D14
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V15.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D15
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V16.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D16
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V17.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D17
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V18.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D18
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V19.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D19
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V20.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D20
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V21.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D21
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V22.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D22
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V23.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D23
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V24.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D24
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V25.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D25
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V26.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D26
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V27.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D27
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V28.D[1]
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D28
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V29.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D29
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V30.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D30
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, V31.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X19, D31
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
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
    FMOV  D1, X23
    FMOV  V1.D[1], X17
    FMOV  D2, X27
    FMOV  V2.D[1], X8
    FMOV  D3, X29
    FMOV  V3.D[1], X20
    FMOV  D4, X9
    FMOV  V4.D[1], X28
    FMOV  D5, X14
    FMOV  V5.D[1], X26
    FMOV  D6, X22
    FMOV  V6.D[1], X29
    FMOV  D7, X16
    FMOV  V7.D[1], X14
    FMOV  D8, X22
    FMOV  V8.D[1], X22
    FMOV  D9, X28
    FMOV  V9.D[1], X22
    FMOV  D10, X16
    FMOV  V10.D[1], X8
    FMOV  D11, X17
    FMOV  V11.D[1], X23
    FMOV  D12, X17
    FMOV  V12.D[1], X22
    FMOV  D13, X18
    FMOV  V13.D[1], X26
    FMOV  D14, X29
    FMOV  V14.D[1], X24
    FMOV  D15, X18
    FMOV  V15.D[1], X26
    FMOV  D16, X26
    FMOV  V16.D[1], X20
    FMOV  D17, X16
    FMOV  V17.D[1], X21
    FMOV  D18, X13
    FMOV  V18.D[1], X20
    FMOV  D19, X25
    FMOV  V19.D[1], X17
    FMOV  D20, X29
    FMOV  V20.D[1], X12
    FMOV  D21, X27
    FMOV  V21.D[1], X29
    FMOV  D22, X14
    FMOV  V22.D[1], X28
    FMOV  D23, X10
    FMOV  V23.D[1], X26
    FMOV  D24, X28
    FMOV  V24.D[1], X28
    FMOV  D25, X24
    FMOV  V25.D[1], X29
    FMOV  D26, X18
    FMOV  V26.D[1], X13
    FMOV  D27, X26
    FMOV  V27.D[1], X8
    FMOV  D28, X24
    FMOV  V28.D[1], X10
    FMOV  D29, X3
    FMOV  V29.D[1], X26
    FMOV  D30, X17
    FMOV  V30.D[1], X26
    FMOV  D31, X25
    FMOV  V31.D[1], X13
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X16, #0x40, LSL #0
    MOVZ  X10, #0x2300, LSL #0
    ADD  X24, X30, X10
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X24]
    LD1R { V10.8H }, [X24]
    ADD  X24, X24, X16
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X24]
    LD1R { V26.16B }, [X24]
    ADD  X24, X24, X16, ASR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X24]
    LD1R { V11.2D }, [X24]
    ADD  X24, X24, X16
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X24]
    LD1R { V0.4S }, [X24]
    ADD  X24, X24, X16
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X24]
    LD1R { V1.8H }, [X24]
    ADD  X24, X24, X16
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X24]
    LD1R { V10.8B }, [X24]
    ADD  X24, X24, X16, LSR #0
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X24]
    LD1R { V28.1D }, [X24]
    ADD  X24, X24, X16, LSR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X24]
    LD1R { V31.2S }, [X24]
    ADD  X24, X24, X16, LSR #0
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X24]
    LD1R { V28.4H }, [X24]
    ADD  X24, X24, X16, LSR #0
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X24]
    LD1R { V6.8B }, [X24]
    ADD  X24, X24, X16
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X24]
    MOV  X19, X24
    LD1R { V30.16B }, [X19], #1
    ADD  X24, X24, X16, LSR #0
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X24]
    MOV  X19, X24
    LD1R { V9.16B }, [X19], #1
    ADD  X24, X24, X16, LSR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X24]
    MOV  X19, X24
    LD1R { V15.8B }, [X19], #1
    ADD  X24, X24, X16, ASR #0
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X24]
    MOV  X19, X24
    LD1R { V19.4H }, [X19], #2
    ADD  X24, X24, X16
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X24]
    MOV  X19, X24
    LD1R { V6.8H }, [X19], #2
    ADD  X24, X24, X16, ASR #0
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X24]
    MOV  X19, X24
    LD1R { V10.2S }, [X19], #4
    ADD  X24, X24, X16, LSR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X24]
    MOV  X19, X24
    LD1R { V30.2S }, [X19], #4
    ADD  X24, X24, X16, ASR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X24]
    MOV  X19, X24
    LD1R { V7.4S }, [X19], #4
    ADD  X24, X24, X16
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X24]
    MOV  X19, X24
    LD1R { V26.1D }, [X19], #8
    ADD  X24, X24, X16, ASR #0
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X24]
    MOV  X19, X24
    LD1R { V3.1D }, [X19], #8
    ADD  X24, X24, X16, LSR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X24]
    MOV  X19, X24
    LD1R { V27.2D }, [X19], #8
    ADD  X24, X24, X16
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X24]
    MOV  X19, X24
    LD1R { V27.8H }, [X19], #2
    ADD  X24, X24, X16, LSR #0
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X24]
    LD1R { V3.2D }, [X24], X3
    ADD  X24, X24, X16, LSR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X24]
    LD1R { V31.16B }, [X24], X3
    ADD  X24, X24, X16
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X24]
    LD1R { V2.2D }, [X24], X3
    ADD  X24, X24, X16
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X24]
    LD1R { V24.4S }, [X24], X3
    ADD  X24, X24, X16, ASR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X24]
    LD1R { V8.8H }, [X24], X3
    ADD  X24, X24, X16, ASR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X24]
    LD1R { V28.1D }, [X24], X3
    ADD  X24, X24, X16, LSR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X24]
    LD1R { V26.1D }, [X24], X3
    ADD  X24, X24, X16, ASR #0
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X24]
    LD1R { V29.2S }, [X24], X3
    ADD  X24, X24, X16
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X24]
    LD1R { V30.4H }, [X24], X3
    ADD  X24, X24, X16
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X24]
    LD1R { V5.8B }, [X24], X3
    ADD  X24, X24, X16, LSR #0
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X15, X9, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X15, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X15, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X15, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X15, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X15, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X15, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X15, X9, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X15, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X15, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X15, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X15, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X15, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X15, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MRS  X9, FPSR
    MOVZ  X15, #0x0, LSL #0
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V0.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D0
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V1.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D1
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D2
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D3
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D4
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V5.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D5
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D6
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V7.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D7
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D8
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V9.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D9
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D10
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V11.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D11
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V12.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D12
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V13.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D13
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D14
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D15
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D16
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V17.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D17
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V18.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D18
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V19.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D19
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V20.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D20
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D21
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V22.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D22
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D23
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V24.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D24
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D25
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D26
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V27.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D27
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V28.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D28
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D29
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V30.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D30
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, V31.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X9, D31
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X22
    FMOV  D1, X29
    FMOV  V1.D[1], X27
    FMOV  D2, X12
    FMOV  V2.D[1], X26
    FMOV  D3, X10
    FMOV  V3.D[1], X11
    FMOV  D4, X21
    FMOV  V4.D[1], X21
    FMOV  D5, X27
    FMOV  V5.D[1], X22
    FMOV  D6, X28
    FMOV  V6.D[1], X29
    FMOV  D7, X18
    FMOV  V7.D[1], X20
    FMOV  D8, X25
    FMOV  V8.D[1], X14
    FMOV  D9, X13
    FMOV  V9.D[1], X12
    FMOV  D10, X23
    FMOV  V10.D[1], X15
    FMOV  D11, X18
    FMOV  V11.D[1], X29
    FMOV  D12, X3
    FMOV  V12.D[1], X9
    FMOV  D13, X24
    FMOV  V13.D[1], X27
    FMOV  D14, X29
    FMOV  V14.D[1], X13
    FMOV  D15, X15
    FMOV  V15.D[1], X26
    FMOV  D16, X25
    FMOV  V16.D[1], X17
    FMOV  D17, X27
    FMOV  V17.D[1], X26
    FMOV  D18, X26
    FMOV  V18.D[1], X20
    FMOV  D19, X14
    FMOV  V19.D[1], X12
    FMOV  D20, X17
    FMOV  V20.D[1], X16
    FMOV  D21, X13
    FMOV  V21.D[1], X19
    FMOV  D22, X10
    FMOV  V22.D[1], X14
    FMOV  D23, X28
    FMOV  V23.D[1], X10
    FMOV  D24, X3
    FMOV  V24.D[1], X9
    FMOV  D25, X12
    FMOV  V25.D[1], X22
    FMOV  D26, X13
    FMOV  V26.D[1], X11
    FMOV  D27, X14
    FMOV  V27.D[1], X17
    FMOV  D28, X18
    FMOV  V28.D[1], X23
    FMOV  D29, X29
    FMOV  V29.D[1], X22
    FMOV  D30, X10
    FMOV  V30.D[1], X10
    FMOV  D31, X25
    FMOV  V31.D[1], X27
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X14, #0x40, LSL #0
    MOVZ  X22, #0x2800, LSL #0
    ADD  X26, X30, X22
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X26]
    LD1R { V14.4S }, [X26]
    ADD  X26, X26, X14
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X26]
    LD1R { V14.16B }, [X26]
    ADD  X26, X26, X14, ASR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X26]
    LD1R { V18.2D }, [X26]
    ADD  X26, X26, X14
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X26]
    LD1R { V25.4S }, [X26]
    ADD  X26, X26, X14
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X26]
    LD1R { V17.8H }, [X26]
    ADD  X26, X26, X14, LSR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X26]
    LD1R { V19.1D }, [X26]
    ADD  X26, X26, X14, ASR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X26]
    LD1R { V28.1D }, [X26]
    ADD  X26, X26, X14, LSR #0
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X26]
    LD1R { V1.2S }, [X26]
    ADD  X26, X26, X14
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X26]
    LD1R { V7.4H }, [X26]
    ADD  X26, X26, X14, LSR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X26]
    LD1R { V13.8B }, [X26]
    ADD  X26, X26, X14
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X26]
    MOV  X24, X26
    LD1R { V8.16B }, [X24], #1
    ADD  X26, X26, X14
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X26]
    MOV  X24, X26
    LD1R { V22.16B }, [X24], #1
    ADD  X26, X26, X14, LSR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X26]
    MOV  X24, X26
    LD1R { V12.8B }, [X24], #1
    ADD  X26, X26, X14
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X26]
    MOV  X24, X26
    LD1R { V0.4H }, [X24], #2
    ADD  X26, X26, X14, ASR #0
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X26]
    MOV  X24, X26
    LD1R { V20.8H }, [X24], #2
    ADD  X26, X26, X14, LSR #0
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X26]
    MOV  X24, X26
    LD1R { V22.2S }, [X24], #4
    ADD  X26, X26, X14
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X26]
    MOV  X24, X26
    LD1R { V24.2S }, [X24], #4
    ADD  X26, X26, X14, ASR #0
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X26]
    MOV  X24, X26
    LD1R { V12.4S }, [X24], #4
    ADD  X26, X26, X14, LSR #0
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X26]
    MOV  X24, X26
    LD1R { V26.1D }, [X24], #8
    ADD  X26, X26, X14
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X26]
    MOV  X24, X26
    LD1R { V20.1D }, [X24], #8
    ADD  X26, X26, X14, ASR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X26]
    MOV  X24, X26
    LD1R { V6.2D }, [X24], #8
    ADD  X26, X26, X14, LSR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X26]
    MOV  X24, X26
    LD1R { V10.4H }, [X24], #2
    ADD  X26, X26, X14
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X26]
    LD1R { V13.2D }, [X26], X21
    ADD  X26, X26, X14
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X26]
    LD1R { V31.16B }, [X26], X21
    ADD  X26, X26, X14, LSR #0
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X26]
    LD1R { V24.2D }, [X26], X21
    ADD  X26, X26, X14, ASR #0
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X26]
    LD1R { V16.4S }, [X26], X21
    ADD  X26, X26, X14
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X26]
    LD1R { V17.8H }, [X26], X21
    ADD  X26, X26, X14, ASR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X26]
    LD1R { V28.4H }, [X26], X21
    ADD  X26, X26, X14
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X26]
    LD1R { V10.1D }, [X26], X21
    ADD  X26, X26, X14, LSR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X26]
    LD1R { V3.2S }, [X26], X21
    ADD  X26, X26, X14, LSR #0
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X26]
    LD1R { V21.4H }, [X26], X21
    ADD  X26, X26, X14
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X26]
    LD1R { V28.8B }, [X26], X21
    ADD  X26, X26, X14, LSR #0
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MRS  X28, FPSR
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V0.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D0
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V1.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D1
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D2
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V3.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D3
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V4.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D4
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D5
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D6
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D7
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D8
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V9.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D9
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D10
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D11
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V12.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D12
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V13.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D13
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D14
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V15.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D15
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D16
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D17
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D18
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V19.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D19
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D20
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V21.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D21
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D22
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V23.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D23
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D24
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D25
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D26
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V27.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D27
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D28
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V29.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D29
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V30.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D30
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, V31.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X28, D31
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X8, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
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
    FMOV  V0.D[1], X22
    FMOV  D1, X26
    FMOV  V1.D[1], X25
    FMOV  D2, X24
    FMOV  V2.D[1], X25
    FMOV  D3, X9
    FMOV  V3.D[1], X29
    FMOV  D4, X17
    FMOV  V4.D[1], X12
    FMOV  D5, X19
    FMOV  V5.D[1], X26
    FMOV  D6, X26
    FMOV  V6.D[1], X13
    FMOV  D7, X10
    FMOV  V7.D[1], X15
    FMOV  D8, X29
    FMOV  V8.D[1], X20
    FMOV  D9, X10
    FMOV  V9.D[1], X22
    FMOV  D10, X17
    FMOV  V10.D[1], X11
    FMOV  D11, X13
    FMOV  V11.D[1], X22
    FMOV  D12, X11
    FMOV  V12.D[1], X15
    FMOV  D13, X27
    FMOV  V13.D[1], X20
    FMOV  D14, X12
    FMOV  V14.D[1], X25
    FMOV  D15, X29
    FMOV  V15.D[1], X17
    FMOV  D16, X8
    FMOV  V16.D[1], X28
    FMOV  D17, X22
    FMOV  V17.D[1], X27
    FMOV  D18, X19
    FMOV  V18.D[1], X27
    FMOV  D19, X17
    FMOV  V19.D[1], X24
    FMOV  D20, X27
    FMOV  V20.D[1], X28
    FMOV  D21, X28
    FMOV  V21.D[1], X18
    FMOV  D22, X8
    FMOV  V22.D[1], X19
    FMOV  D23, X18
    FMOV  V23.D[1], X21
    FMOV  D24, X12
    FMOV  V24.D[1], X16
    FMOV  D25, X29
    FMOV  V25.D[1], X29
    FMOV  D26, X24
    FMOV  V26.D[1], X28
    FMOV  D27, X11
    FMOV  V27.D[1], X16
    FMOV  D28, X29
    FMOV  V28.D[1], X12
    FMOV  D29, X10
    FMOV  V29.D[1], X26
    FMOV  D30, X8
    FMOV  V30.D[1], X25
    FMOV  D31, X17
    FMOV  V31.D[1], X20
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X27, #0x40, LSL #0
    MOVZ  X13, #0x2d00, LSL #0
    ADD  X29, X30, X13
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X29]
    LD1R { V25.2D }, [X29]
    ADD  X29, X29, X27, ASR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X29]
    LD1R { V30.16B }, [X29]
    ADD  X29, X29, X27
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X29]
    LD1R { V30.2D }, [X29]
    ADD  X29, X29, X27, LSR #0
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X29]
    LD1R { V12.4S }, [X29]
    ADD  X29, X29, X27, ASR #0
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X29]
    LD1R { V18.8H }, [X29]
    ADD  X29, X29, X27, LSR #0
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X29]
    LD1R { V30.1D }, [X29]
    ADD  X29, X29, X27, ASR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X29]
    LD1R { V18.1D }, [X29]
    ADD  X29, X29, X27
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X29]
    LD1R { V11.2S }, [X29]
    ADD  X29, X29, X27, ASR #0
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X29]
    LD1R { V25.4H }, [X29]
    ADD  X29, X29, X27
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X29]
    LD1R { V21.8B }, [X29]
    ADD  X29, X29, X27
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X29]
    MOV  X8, X29
    LD1R { V13.8B }, [X8], #1
    ADD  X29, X29, X27
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X29]
    MOV  X8, X29
    LD1R { V9.16B }, [X8], #1
    ADD  X29, X29, X27
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X29]
    MOV  X8, X29
    LD1R { V31.8B }, [X8], #1
    ADD  X29, X29, X27, LSR #0
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X29]
    MOV  X8, X29
    LD1R { V24.4H }, [X8], #2
    ADD  X29, X29, X27, LSR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X29]
    MOV  X8, X29
    LD1R { V24.8H }, [X8], #2
    ADD  X29, X29, X27, LSR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X29]
    MOV  X8, X29
    LD1R { V21.4S }, [X8], #4
    ADD  X29, X29, X27, ASR #0
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X29]
    MOV  X8, X29
    LD1R { V23.2S }, [X8], #4
    ADD  X29, X29, X27, LSR #0
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X29]
    MOV  X8, X29
    LD1R { V28.4S }, [X8], #4
    ADD  X29, X29, X27
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X29]
    MOV  X8, X29
    LD1R { V11.2D }, [X8], #8
    ADD  X29, X29, X27, LSR #0
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X29]
    MOV  X8, X29
    LD1R { V30.1D }, [X8], #8
    ADD  X29, X29, X27, ASR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X29]
    MOV  X8, X29
    LD1R { V25.2D }, [X8], #8
    ADD  X29, X29, X27
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X29]
    MOV  X8, X29
    LD1R { V11.4H }, [X8], #2
    ADD  X29, X29, X27
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X29]
    LD1R { V28.4S }, [X29], X21
    ADD  X29, X29, X27, ASR #0
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X29]
    LD1R { V21.16B }, [X29], X21
    ADD  X29, X29, X27
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X29]
    LD1R { V4.2D }, [X29], X21
    ADD  X29, X29, X27, LSR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X29]
    LD1R { V15.4S }, [X29], X21
    ADD  X29, X29, X27, ASR #0
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X29]
    LD1R { V14.8H }, [X29], X21
    ADD  X29, X29, X27, LSR #0
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X29]
    LD1R { V24.4H }, [X29], X21
    ADD  X29, X29, X27, ASR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X29]
    LD1R { V25.1D }, [X29], X21
    ADD  X29, X29, X27
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X29]
    LD1R { V5.2S }, [X29], X21
    ADD  X29, X29, X27, LSR #0
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X29]
    LD1R { V11.4H }, [X29], X21
    ADD  X29, X29, X27, ASR #0
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X29]
    LD1R { V19.8B }, [X29], X21
    ADD  X29, X29, X27, LSR #0
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X3, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X3, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X3, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X3, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X3, X25, X14
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X3, X25, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X3, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X3, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X3, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X3, X25, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X3, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X3, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X3, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X3, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X3, X25, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MRS  X25, FPSR
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V0.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D0
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V1.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D1
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V2.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D2
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V3.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D3
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V4.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D4
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V5.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D5
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V6.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D6
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V7.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D7
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V8.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D8
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V9.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D9
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V10.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D10
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V11.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D11
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V12.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D12
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V13.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D13
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V14.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D14
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V15.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D15
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V16.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D16
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V17.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D17
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V18.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D18
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V19.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D19
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V20.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D20
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V21.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D21
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V22.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D22
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V23.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D23
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V24.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D24
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V25.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D25
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V26.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D26
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V27.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D27
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V28.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D28
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V29.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D29
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V30.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D30
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, V31.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail
    FMOV  X25, D31
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP01_TestFail

AdvsimdLoadDeprecatedP01_TestEnd:
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
AdvsimdLoadDeprecatedP01_TestFail:
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
