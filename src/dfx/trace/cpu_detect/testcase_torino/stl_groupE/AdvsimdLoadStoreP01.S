.global AdvsimdLoadStoreP01

.text
.p2align 4

AdvsimdLoadStoreP01:

AdvsimdLoadStoreP01_TestBegin:
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
    MOVZ  X2, #0x670f, LSL #0
    MOVK  X2, #0x34f8, LSL #16
    MOVK  X2, #0xefc6, LSL #32
    MOVK  X2, #0x1300, LSL #48
    MOVZ  X3, #0x3625, LSL #0
    MOVK  X3, #0x2e9c, LSL #16
    MOVK  X3, #0x1068, LSL #32
    MOVK  X3, #0x26c1, LSL #48
    MOVZ  X4, #0x4b42, LSL #0
    MOVK  X4, #0x47d3, LSL #16
    MOVK  X4, #0x9e45, LSL #32
    MOVK  X4, #0x4f56, LSL #48
    MOVZ  X5, #0x93c9, LSL #0
    MOVK  X5, #0xa588, LSL #16
    MOVK  X5, #0x5145, LSL #32
    MOVK  X5, #0xdc0b, LSL #48
    MOVZ  X6, #0xa242, LSL #0
    MOVK  X6, #0x17d0, LSL #16
    MOVK  X6, #0xd865, LSL #32
    MOVK  X6, #0xdb8, LSL #48
    MOVZ  X7, #0x7214, LSL #0
    MOVK  X7, #0x5219, LSL #16
    MOVK  X7, #0x87b8, LSL #32
    MOVK  X7, #0x63e9, LSL #48
    MOVZ  X8, #0x86ac, LSL #0
    MOVK  X8, #0x2e7c, LSL #16
    MOVK  X8, #0x72f8, LSL #32
    MOVK  X8, #0x3cbb, LSL #48
    MOVZ  X9, #0xa5d7, LSL #0
    MOVK  X9, #0xba40, LSL #16
    MOVK  X9, #0xdccd, LSL #32
    MOVK  X9, #0xb199, LSL #48
    MOVZ  X10, #0x3a43, LSL #0
    MOVK  X10, #0x4c8b, LSL #16
    MOVK  X10, #0x6bcf, LSL #32
    MOVK  X10, #0xec1b, LSL #48
    MOVZ  X11, #0x7f22, LSL #0
    MOVK  X11, #0x2751, LSL #16
    MOVK  X11, #0x62b5, LSL #32
    MOVK  X11, #0x7f63, LSL #48
    MOVZ  X12, #0x8a9, LSL #0
    MOVK  X12, #0x643e, LSL #16
    MOVK  X12, #0x92c9, LSL #32
    MOVK  X12, #0xef57, LSL #48
    MOVZ  X13, #0x1108, LSL #0
    MOVK  X13, #0xca07, LSL #16
    MOVK  X13, #0xe814, LSL #32
    MOVK  X13, #0x1d88, LSL #48
    MOVZ  X14, #0x6133, LSL #0
    MOVK  X14, #0x5c4e, LSL #16
    MOVK  X14, #0xfb20, LSL #32
    MOVK  X14, #0xde88, LSL #48
    MOVZ  X15, #0x9dd3, LSL #0
    MOVK  X15, #0x90e3, LSL #16
    MOVK  X15, #0x897c, LSL #32
    MOVK  X15, #0xb1d2, LSL #48
    MOVZ  X16, #0x276, LSL #0
    MOVK  X16, #0x4f4d, LSL #16
    MOVK  X16, #0x83cb, LSL #32
    MOVK  X16, #0xd2a7, LSL #48
    MOVZ  X17, #0x54c6, LSL #0
    MOVK  X17, #0xa2ef, LSL #16
    MOVK  X17, #0xa952, LSL #32
    MOVK  X17, #0xb3b8, LSL #48
    MOVZ  X18, #0xe378, LSL #0
    MOVK  X18, #0x424d, LSL #16
    MOVK  X18, #0x2f10, LSL #32
    MOVK  X18, #0x9371, LSL #48
    MOVZ  X19, #0xdff6, LSL #0
    MOVK  X19, #0x577, LSL #16
    MOVK  X19, #0x84e2, LSL #32
    MOVK  X19, #0x4b64, LSL #48
    MOVZ  X20, #0x5f6d, LSL #0
    MOVK  X20, #0x7d2e, LSL #16
    MOVK  X20, #0x9dcd, LSL #32
    MOVK  X20, #0x7f77, LSL #48
    MOVZ  X21, #0xb790, LSL #0
    MOVK  X21, #0x3152, LSL #16
    MOVK  X21, #0x2278, LSL #32
    MOVK  X21, #0xd883, LSL #48
    MOVZ  X22, #0x6c63, LSL #0
    MOVK  X22, #0xa15d, LSL #16
    MOVK  X22, #0x38f4, LSL #32
    MOVK  X22, #0x94b, LSL #48
    MOVZ  X23, #0xec3f, LSL #0
    MOVK  X23, #0x41bf, LSL #16
    MOVK  X23, #0xb9f1, LSL #32
    MOVK  X23, #0xea83, LSL #48
    MOVZ  X29, #0xca5f, LSL #0
    MOVK  X29, #0xbb92, LSL #16
    MOVK  X29, #0x9556, LSL #32
    MOVK  X29, #0xcb0c, LSL #48
    MOVZ  X21, #0xb3e5, LSL #0
    MOVK  X21, #0x5141, LSL #16
    MOVK  X21, #0x45ac, LSL #32
    MOVK  X21, #0x3e1b, LSL #48
    MSR  FPCR, X21
    MRS  X5, FPCR
    MOVZ  X22, #0x60ff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    AND  X5, X5, X22
    MOVZ  X22, #0x0, LSL #0
    ORR  X5, X5, X22
    MSR  FPCR, X5
    ISB  SY
    MOVZ  X21, #0x9251, LSL #0
    MOVK  X21, #0xcfbe, LSL #16
    MOVK  X21, #0xf34c, LSL #32
    MOVK  X21, #0x4278, LSL #48
    MSR  FPSR, X21
    MRS  X23, FPSR
    MOVZ  X7, #0xff60, LSL #0
    MOVK  X7, #0x7ff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    AND  X23, X23, X7
    MOVZ  X7, #0x0, LSL #0
    ORR  X23, X23, X7
    MSR  FPSR, X23
    ISB  SY
    ANDS  W11, W22, W15, ASR #5
    MOV  X30, X1
    MOVZ  X1, #0x0, LSL #0
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X2
    FMOV  D1, X14
    FMOV  V1.D[1], X22
    FMOV  D2, X12
    FMOV  V2.D[1], X21
    FMOV  D3, X29
    FMOV  V3.D[1], X12
    FMOV  D4, X17
    FMOV  V4.D[1], X22
    FMOV  D5, X13
    FMOV  V5.D[1], X29
    FMOV  D6, X20
    FMOV  V6.D[1], X13
    FMOV  D7, X20
    FMOV  V7.D[1], X9
    FMOV  D8, X18
    FMOV  V8.D[1], X14
    FMOV  D9, X7
    FMOV  V9.D[1], X14
    FMOV  D10, X17
    FMOV  V10.D[1], X22
    FMOV  D11, X9
    FMOV  V11.D[1], X29
    FMOV  D12, X22
    FMOV  V12.D[1], X8
    FMOV  D13, X11
    FMOV  V13.D[1], X22
    FMOV  D14, X8
    FMOV  V14.D[1], X3
    FMOV  D15, X10
    FMOV  V15.D[1], X4
    FMOV  D16, X10
    FMOV  V16.D[1], X23
    FMOV  D17, X9
    FMOV  V17.D[1], X22
    FMOV  D18, X13
    FMOV  V18.D[1], X21
    FMOV  D19, X4
    FMOV  V19.D[1], X29
    FMOV  D20, X20
    FMOV  V20.D[1], X11
    FMOV  D21, X3
    FMOV  V21.D[1], X23
    FMOV  D22, X20
    FMOV  V22.D[1], X4
    FMOV  D23, X16
    FMOV  V23.D[1], X9
    FMOV  D24, X15
    FMOV  V24.D[1], X17
    FMOV  D25, X2
    FMOV  V25.D[1], X9
    FMOV  D26, X22
    FMOV  V26.D[1], X19
    FMOV  D27, X14
    FMOV  V27.D[1], X19
    FMOV  D28, X29
    FMOV  V28.D[1], X9
    FMOV  D29, X22
    FMOV  V29.D[1], X15
    FMOV  D30, X13
    FMOV  V30.D[1], X6
    FMOV  D31, X13
    FMOV  V31.D[1], X23
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X15, #0x40, LSL #0
    MOVZ  X10, #0x0, LSL #0
    ADD  X20, X30, X10, LSR #0
    ST1 { V25.2D, V26.2D, V27.2D, V28.2D }, [X20]
    LD1 { V5.4S, V6.4S, V7.4S, V8.4S }, [X20]
    ADD  X20, X20, X15, ASR #0
    ST1 { V5.16B, V6.16B, V7.16B, V8.16B }, [X20]
    LD1 { V15.16B, V16.16B, V17.16B, V18.16B }, [X20]
    ADD  X20, X20, X15, ASR #0
    ST1 { V23.2D, V24.2D, V25.2D, V26.2D }, [X20]
    LD1 { V15.2D, V16.2D, V17.2D, V18.2D }, [X20]
    ADD  X20, X20, X15
    ST1 { V2.4S, V3.4S, V4.4S, V5.4S }, [X20]
    LD1 { V21.4S, V22.4S, V23.4S, V24.4S }, [X20]
    ADD  X20, X20, X15
    ST1 { V15.8H, V16.8H, V17.8H, V18.8H }, [X20]
    LD1 { V5.8H, V6.8H, V7.8H, V8.8H }, [X20]
    ADD  X20, X20, X15, LSR #0
    ST1 { V5.2S, V6.2S, V7.2S, V8.2S }, [X20]
    LD1 { V27.8B, V28.8B, V29.8B, V30.8B }, [X20]
    ADD  X20, X20, X15
    ST1 { V27.1D, V28.1D, V29.1D, V30.1D }, [X20]
    LD1 { V2.1D, V3.1D, V4.1D, V5.1D }, [X20]
    ADD  X20, X20, X15, ASR #0
    ST1 { V2.2S, V3.2S, V4.2S, V5.2S }, [X20]
    LD1 { V27.2S, V28.2S, V29.2S, V30.2S }, [X20]
    ADD  X20, X20, X15, LSR #0
    ST1 { V27.4H, V28.4H, V29.4H, V30.4H }, [X20]
    LD1 { V26.4H, V27.4H, V28.4H, V29.4H }, [X20]
    ADD  X20, X20, X15, LSR #0
    ST1 { V26.8B, V27.8B, V28.8B, V29.8B }, [X20]
    LD1 { V3.8B, V4.8B, V5.8B, V6.8B }, [X20]
    ADD  X20, X20, X15, LSR #0
    ST1 { V6.8H }, [X20]
    LD1 { V4.8H }, [X20]
    ADD  X20, X20, X15, ASR #0
    ST1 { V5.16B }, [X20]
    LD1 { V27.16B }, [X20]
    ADD  X20, X20, X15
    ST1 { V27.2D }, [X20]
    LD1 { V17.2D }, [X20]
    ADD  X20, X20, X15
    ST1 { V23.4S }, [X20]
    LD1 { V6.4S }, [X20]
    ADD  X20, X20, X15, ASR #0
    ST1 { V6.8H }, [X20]
    LD1 { V28.8H }, [X20]
    ADD  X20, X20, X15, ASR #0
    ST1 { V4.8B }, [X20]
    LD1 { V16.4H }, [X20]
    ADD  X20, X20, X15
    ST1 { V16.1D }, [X20]
    LD1 { V4.1D }, [X20]
    ADD  X20, X20, X15, LSR #0
    ST1 { V28.2S }, [X20]
    LD1 { V7.2S }, [X20]
    ADD  X20, X20, X15, LSR #0
    ST1 { V4.4H }, [X20]
    LD1 { V26.4H }, [X20]
    ADD  X20, X20, X15, ASR #0
    ST1 { V26.8B }, [X20]
    LD1 { V23.8B }, [X20]
    ADD  X20, X20, X15, ASR #0
    ST1 { V24.8H, V25.8H, V26.8H }, [X20]
    LD1 { V24.2D, V25.2D, V26.2D }, [X20]
    ADD  X20, X20, X15, ASR #0
    ST1 { V23.16B, V24.16B, V25.16B }, [X20]
    LD1 { V23.16B, V24.16B, V25.16B }, [X20]
    ADD  X20, X20, X15
    ST1 { V14.2D, V15.2D, V16.2D }, [X20]
    LD1 { V24.2D, V25.2D, V26.2D }, [X20]
    ADD  X20, X20, X15, LSR #0
    ST1 { V1.4S, V2.4S, V3.4S }, [X20]
    LD1 { V1.4S, V2.4S, V3.4S }, [X20]
    ADD  X20, X20, X15, ASR #0
    ST1 { V1.8H, V2.8H, V3.8H }, [X20]
    LD1 { V23.8H, V24.8H, V25.8H }, [X20]
    ADD  X20, X20, X15
    ST1 { V23.4H, V24.4H, V25.4H }, [X20]
    LD1 { V1.2S, V2.2S, V3.2S }, [X20]
    ADD  X20, X20, X15, LSR #0
    ST1 { V21.1D, V22.1D, V23.1D }, [X20]
    LD1 { V31.1D, V0.1D, V1.1D }, [X20]
    ADD  X20, X20, X15, LSR #0
    ST1 { V26.2S, V27.2S, V28.2S }, [X20]
    LD1 { V14.2S, V15.2S, V16.2S }, [X20]
    ADD  X20, X20, X15, LSR #0
    ST1 { V22.4H, V23.4H, V24.4H }, [X20]
    LD1 { V24.4H, V25.4H, V26.4H }, [X20]
    ADD  X20, X20, X15, ASR #0
    ST1 { V24.8B, V25.8B, V26.8B }, [X20]
    LD1 { V23.8B, V24.8B, V25.8B }, [X20]
    ADD  X20, X20, X15, ASR #0
    ST1 { V2.4S, V3.4S }, [X20]
    LD1 { V27.4S, V28.4S }, [X20]
    ADD  X20, X20, X15, ASR #0
    ST1 { V23.16B, V24.16B }, [X20]
    LD1 { V27.16B, V28.16B }, [X20]
    ADD  X20, X20, X15, LSR #0
    ST1 { V15.2D, V16.2D }, [X20]
    LD1 { V21.2D, V22.2D }, [X20]
    ADD  X20, X20, X15, LSR #0
    ST1 { V4.4S, V5.4S }, [X20]
    LD1 { V23.4S, V24.4S }, [X20]
    ADD  X20, X20, X15
    ST1 { V7.8H, V8.8H }, [X20]
    LD1 { V7.8H, V8.8H }, [X20]
    ADD  X20, X20, X15, ASR #0
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X17, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X17, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X17, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X17, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X17, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X17, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X17, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X17, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X17, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X17, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X17, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X17, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X17, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MRS  X13, FPSR
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V0.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D0
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V1.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D1
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D2
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D3
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V4.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D4
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D5
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D6
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V7.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D7
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V8.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D8
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D9
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D10
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D11
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D12
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V13.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D13
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V14.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D14
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D15
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D16
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D17
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D18
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D19
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D20
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D21
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D22
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V23.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D23
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D24
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D25
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V26.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D26
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D27
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V28.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D28
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V29.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D29
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V30.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D30
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V31.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D31
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X14, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X8
    FMOV  V0.D[1], X11
    FMOV  D1, X20
    FMOV  V1.D[1], X23
    FMOV  D2, X22
    FMOV  V2.D[1], X23
    FMOV  D3, X20
    FMOV  V3.D[1], X5
    FMOV  D4, X29
    FMOV  V4.D[1], X9
    FMOV  D5, X4
    FMOV  V5.D[1], X29
    FMOV  D6, X12
    FMOV  V6.D[1], X10
    FMOV  D7, X2
    FMOV  V7.D[1], X23
    FMOV  D8, X17
    FMOV  V8.D[1], X9
    FMOV  D9, X12
    FMOV  V9.D[1], X8
    FMOV  D10, X13
    FMOV  V10.D[1], X16
    FMOV  D11, X29
    FMOV  V11.D[1], X23
    FMOV  D12, X19
    FMOV  V12.D[1], X4
    FMOV  D13, X4
    FMOV  V13.D[1], X13
    FMOV  D14, X22
    FMOV  V14.D[1], X23
    FMOV  D15, X4
    FMOV  V15.D[1], X3
    FMOV  D16, X5
    FMOV  V16.D[1], X23
    FMOV  D17, X17
    FMOV  V17.D[1], X21
    FMOV  D18, X4
    FMOV  V18.D[1], X20
    FMOV  D19, X17
    FMOV  V19.D[1], X23
    FMOV  D20, X17
    FMOV  V20.D[1], X14
    FMOV  D21, X29
    FMOV  V21.D[1], X22
    FMOV  D22, X2
    FMOV  V22.D[1], X5
    FMOV  D23, X5
    FMOV  V23.D[1], X18
    FMOV  D24, X17
    FMOV  V24.D[1], X16
    FMOV  D25, X8
    FMOV  V25.D[1], X11
    FMOV  D26, X22
    FMOV  V26.D[1], X18
    FMOV  D27, X29
    FMOV  V27.D[1], X17
    FMOV  D28, X22
    FMOV  V28.D[1], X23
    FMOV  D29, X21
    FMOV  V29.D[1], X15
    FMOV  D30, X11
    FMOV  V30.D[1], X17
    FMOV  D31, X29
    FMOV  V31.D[1], X23
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X17, #0x40, LSL #0
    MOVZ  X5, #0x500, LSL #0
    ADD  X19, X30, X5, LSR #0
    ST1 { V27.8H, V28.8H, V29.8H, V30.8H }, [X19]
    LD1 { V29.2D, V30.2D, V31.2D, V0.2D }, [X19]
    ADD  X19, X19, X17
    ST1 { V29.16B, V30.16B, V31.16B, V0.16B }, [X19]
    LD1 { V26.16B, V27.16B, V28.16B, V29.16B }, [X19]
    ADD  X19, X19, X17, ASR #0
    ST1 { V22.2D, V23.2D, V24.2D, V25.2D }, [X19]
    LD1 { V30.2D, V31.2D, V0.2D, V1.2D }, [X19]
    ADD  X19, X19, X17
    ST1 { V30.4S, V31.4S, V0.4S, V1.4S }, [X19]
    LD1 { V25.4S, V26.4S, V27.4S, V28.4S }, [X19]
    ADD  X19, X19, X17, ASR #0
    ST1 { V26.8H, V27.8H, V28.8H, V29.8H }, [X19]
    LD1 { V14.8H, V15.8H, V16.8H, V17.8H }, [X19]
    ADD  X19, X19, X17
    ST1 { V27.8B, V28.8B, V29.8B, V30.8B }, [X19]
    LD1 { V12.4H, V13.4H, V14.4H, V15.4H }, [X19]
    ADD  X19, X19, X17, LSR #0
    ST1 { V9.1D, V10.1D, V11.1D, V12.1D }, [X19]
    LD1 { V26.1D, V27.1D, V28.1D, V29.1D }, [X19]
    ADD  X19, X19, X17, LSR #0
    ST1 { V14.2S, V15.2S, V16.2S, V17.2S }, [X19]
    LD1 { V9.2S, V10.2S, V11.2S, V12.2S }, [X19]
    ADD  X19, X19, X17, LSR #0
    ST1 { V13.4H, V14.4H, V15.4H, V16.4H }, [X19]
    LD1 { V30.4H, V31.4H, V0.4H, V1.4H }, [X19]
    ADD  X19, X19, X17, LSR #0
    ST1 { V26.8B, V27.8B, V28.8B, V29.8B }, [X19]
    LD1 { V26.8B, V27.8B, V28.8B, V29.8B }, [X19]
    ADD  X19, X19, X17, ASR #0
    ST1 { V4.4S }, [X19]
    LD1 { V4.2D }, [X19]
    ADD  X19, X19, X17, ASR #0
    ST1 { V28.16B }, [X19]
    LD1 { V16.16B }, [X19]
    ADD  X19, X19, X17
    ST1 { V16.2D }, [X19]
    LD1 { V13.2D }, [X19]
    ADD  X19, X19, X17, LSR #0
    ST1 { V9.4S }, [X19]
    LD1 { V14.4S }, [X19]
    ADD  X19, X19, X17, LSR #0
    ST1 { V29.8H }, [X19]
    LD1 { V3.8H }, [X19]
    ADD  X19, X19, X17, ASR #0
    ST1 { V31.1D }, [X19]
    LD1 { V31.8B }, [X19]
    ADD  X19, X19, X17, ASR #0
    ST1 { V3.1D }, [X19]
    LD1 { V28.1D }, [X19]
    ADD  X19, X19, X17
    ST1 { V23.2S }, [X19]
    LD1 { V29.2S }, [X19]
    ADD  X19, X19, X17
    ST1 { V2.4H }, [X19]
    LD1 { V16.4H }, [X19]
    ADD  X19, X19, X17
    ST1 { V16.8B }, [X19]
    LD1 { V3.8B }, [X19]
    ADD  X19, X19, X17, ASR #0
    ST1 { V25.4S, V26.4S, V27.4S }, [X19]
    LD1 { V25.8H, V26.8H, V27.8H }, [X19]
    ADD  X19, X19, X17, LSR #0
    ST1 { V26.16B, V27.16B, V28.16B }, [X19]
    LD1 { V11.16B, V12.16B, V13.16B }, [X19]
    ADD  X19, X19, X17, LSR #0
    ST1 { V11.2D, V12.2D, V13.2D }, [X19]
    LD1 { V29.2D, V30.2D, V31.2D }, [X19]
    ADD  X19, X19, X17
    ST1 { V29.4S, V30.4S, V31.4S }, [X19]
    LD1 { V26.4S, V27.4S, V28.4S }, [X19]
    ADD  X19, X19, X17
    ST1 { V26.8H, V27.8H, V28.8H }, [X19]
    LD1 { V14.8H, V15.8H, V16.8H }, [X19]
    ADD  X19, X19, X17, LSR #0
    ST1 { V14.4H, V15.4H, V16.4H }, [X19]
    LD1 { V27.8B, V28.8B, V29.8B }, [X19]
    ADD  X19, X19, X17
    ST1 { V1.1D, V2.1D, V3.1D }, [X19]
    LD1 { V14.1D, V15.1D, V16.1D }, [X19]
    ADD  X19, X19, X17
    ST1 { V11.2S, V12.2S, V13.2S }, [X19]
    LD1 { V13.2S, V14.2S, V15.2S }, [X19]
    ADD  X19, X19, X17, LSR #0
    ST1 { V27.4H, V28.4H, V29.4H }, [X19]
    LD1 { V10.4H, V11.4H, V12.4H }, [X19]
    ADD  X19, X19, X17, LSR #0
    ST1 { V11.8B, V12.8B, V13.8B }, [X19]
    LD1 { V26.8B, V27.8B, V28.8B }, [X19]
    ADD  X19, X19, X17, LSR #0
    ST1 { V30.4S, V31.4S }, [X19]
    LD1 { V12.4S, V13.4S }, [X19]
    ADD  X19, X19, X17, ASR #0
    ST1 { V7.16B, V8.16B }, [X19]
    LD1 { V4.16B, V5.16B }, [X19]
    ADD  X19, X19, X17, ASR #0
    ST1 { V13.2D, V14.2D }, [X19]
    LD1 { V31.2D, V0.2D }, [X19]
    ADD  X19, X19, X17
    ST1 { V25.4S, V26.4S }, [X19]
    LD1 { V13.4S, V14.4S }, [X19]
    ADD  X19, X19, X17, ASR #0
    ST1 { V23.8H, V24.8H }, [X19]
    LD1 { V24.8H, V25.8H }, [X19]
    ADD  X19, X19, X17, ASR #0
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X9, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X9, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X9, X18, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X9, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X9, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X9, X18, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X9, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X9, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X9, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X9, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X9, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X9, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X9, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X9, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X9, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MRS  X18, FPSR
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V0.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D0
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V1.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D1
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D2
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V3.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D3
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D4
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V5.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D5
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V6.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D6
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V7.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D7
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V8.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D8
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V9.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D9
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D10
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V11.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D11
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D12
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V13.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D13
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V14.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D14
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V15.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D15
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D16
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V17.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D17
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V18.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D18
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V19.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D19
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V20.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D20
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V21.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D21
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V22.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D22
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D23
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V24.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D24
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V25.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D25
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D26
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V27.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D27
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D28
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D29
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V30.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D30
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V31.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D31
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X22
    FMOV  V0.D[1], X17
    FMOV  D1, X29
    FMOV  V1.D[1], X4
    FMOV  D2, X7
    FMOV  V2.D[1], X21
    FMOV  D3, X8
    FMOV  V3.D[1], X20
    FMOV  D4, X9
    FMOV  V4.D[1], X6
    FMOV  D5, X5
    FMOV  V5.D[1], X23
    FMOV  D6, X15
    FMOV  V6.D[1], X7
    FMOV  D7, X15
    FMOV  V7.D[1], X19
    FMOV  D8, X21
    FMOV  V8.D[1], X3
    FMOV  D9, X10
    FMOV  V9.D[1], X3
    FMOV  D10, X9
    FMOV  V10.D[1], X14
    FMOV  D11, X8
    FMOV  V11.D[1], X15
    FMOV  D12, X20
    FMOV  V12.D[1], X16
    FMOV  D13, X29
    FMOV  V13.D[1], X2
    FMOV  D14, X17
    FMOV  V14.D[1], X22
    FMOV  D15, X18
    FMOV  V15.D[1], X29
    FMOV  D16, X21
    FMOV  V16.D[1], X15
    FMOV  D17, X22
    FMOV  V17.D[1], X14
    FMOV  D18, X29
    FMOV  V18.D[1], X10
    FMOV  D19, X22
    FMOV  V19.D[1], X6
    FMOV  D20, X14
    FMOV  V20.D[1], X18
    FMOV  D21, X19
    FMOV  V21.D[1], X14
    FMOV  D22, X3
    FMOV  V22.D[1], X4
    FMOV  D23, X4
    FMOV  V23.D[1], X17
    FMOV  D24, X12
    FMOV  V24.D[1], X14
    FMOV  D25, X20
    FMOV  V25.D[1], X15
    FMOV  D26, X12
    FMOV  V26.D[1], X22
    FMOV  D27, X5
    FMOV  V27.D[1], X19
    FMOV  D28, X7
    FMOV  V28.D[1], X3
    FMOV  D29, X18
    FMOV  V29.D[1], X10
    FMOV  D30, X20
    FMOV  V30.D[1], X20
    FMOV  D31, X5
    FMOV  V31.D[1], X17
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X23, #0x40, LSL #0
    MOVZ  X4, #0xa00, LSL #0
    ADD  X10, X30, X4, LSR #0
    ST1 { V27.2D, V28.2D, V29.2D, V30.2D }, [X10]
    LD1 { V30.16B, V31.16B, V0.16B, V1.16B }, [X10]
    ADD  X10, X10, X23, ASR #0
    ST1 { V29.16B, V30.16B, V31.16B, V0.16B }, [X10]
    LD1 { V5.16B, V6.16B, V7.16B, V8.16B }, [X10]
    ADD  X10, X10, X23
    ST1 { V30.2D, V31.2D, V0.2D, V1.2D }, [X10]
    LD1 { V26.2D, V27.2D, V28.2D, V29.2D }, [X10]
    ADD  X10, X10, X23, ASR #0
    ST1 { V24.4S, V25.4S, V26.4S, V27.4S }, [X10]
    LD1 { V12.4S, V13.4S, V14.4S, V15.4S }, [X10]
    ADD  X10, X10, X23, LSR #0
    ST1 { V5.8H, V6.8H, V7.8H, V8.8H }, [X10]
    LD1 { V27.8H, V28.8H, V29.8H, V30.8H }, [X10]
    ADD  X10, X10, X23, LSR #0
    ST1 { V12.4H, V13.4H, V14.4H, V15.4H }, [X10]
    LD1 { V20.4H, V21.4H, V22.4H, V23.4H }, [X10]
    ADD  X10, X10, X23
    ST1 { V20.1D, V21.1D, V22.1D, V23.1D }, [X10]
    LD1 { V5.1D, V6.1D, V7.1D, V8.1D }, [X10]
    ADD  X10, X10, X23
    ST1 { V6.2S, V7.2S, V8.2S, V9.2S }, [X10]
    LD1 { V6.2S, V7.2S, V8.2S, V9.2S }, [X10]
    ADD  X10, X10, X23, ASR #0
    ST1 { V5.4H, V6.4H, V7.4H, V8.4H }, [X10]
    LD1 { V12.4H, V13.4H, V14.4H, V15.4H }, [X10]
    ADD  X10, X10, X23, ASR #0
    ST1 { V12.8B, V13.8B, V14.8B, V15.8B }, [X10]
    LD1 { V5.8B, V6.8B, V7.8B, V8.8B }, [X10]
    ADD  X10, X10, X23, LSR #0
    ST1 { V16.16B }, [X10]
    LD1 { V24.4S }, [X10]
    ADD  X10, X10, X23, LSR #0
    ST1 { V21.16B }, [X10]
    LD1 { V14.16B }, [X10]
    ADD  X10, X10, X23
    ST1 { V0.2D }, [X10]
    LD1 { V10.2D }, [X10]
    ADD  X10, X10, X23, LSR #0
    ST1 { V28.4S }, [X10]
    LD1 { V16.4S }, [X10]
    ADD  X10, X10, X23, LSR #0
    ST1 { V10.8H }, [X10]
    LD1 { V15.8H }, [X10]
    ADD  X10, X10, X23, ASR #0
    ST1 { V12.2S }, [X10]
    LD1 { V10.4H }, [X10]
    ADD  X10, X10, X23
    ST1 { V9.1D }, [X10]
    LD1 { V15.1D }, [X10]
    ADD  X10, X10, X23, LSR #0
    ST1 { V5.2S }, [X10]
    LD1 { V9.2S }, [X10]
    ADD  X10, X10, X23, ASR #0
    ST1 { V16.4H }, [X10]
    LD1 { V12.4H }, [X10]
    ADD  X10, X10, X23
    ST1 { V29.8B }, [X10]
    LD1 { V15.8B }, [X10]
    ADD  X10, X10, X23, ASR #0
    ST1 { V7.8H, V8.8H, V9.8H }, [X10]
    LD1 { V7.4S, V8.4S, V9.4S }, [X10]
    ADD  X10, X10, X23
    ST1 { V19.16B, V20.16B, V21.16B }, [X10]
    LD1 { V25.16B, V26.16B, V27.16B }, [X10]
    ADD  X10, X10, X23, ASR #0
    ST1 { V8.2D, V9.2D, V10.2D }, [X10]
    LD1 { V8.2D, V9.2D, V10.2D }, [X10]
    ADD  X10, X10, X23, LSR #0
    ST1 { V8.4S, V9.4S, V10.4S }, [X10]
    LD1 { V4.4S, V5.4S, V6.4S }, [X10]
    ADD  X10, X10, X23
    ST1 { V15.8H, V16.8H, V17.8H }, [X10]
    LD1 { V2.8H, V3.8H, V4.8H }, [X10]
    ADD  X10, X10, X23, ASR #0
    ST1 { V25.2S, V26.2S, V27.2S }, [X10]
    LD1 { V8.1D, V9.1D, V10.1D }, [X10]
    ADD  X10, X10, X23
    ST1 { V6.1D, V7.1D, V8.1D }, [X10]
    LD1 { V25.1D, V26.1D, V27.1D }, [X10]
    ADD  X10, X10, X23, ASR #0
    ST1 { V2.2S, V3.2S, V4.2S }, [X10]
    LD1 { V15.2S, V16.2S, V17.2S }, [X10]
    ADD  X10, X10, X23, ASR #0
    ST1 { V15.4H, V16.4H, V17.4H }, [X10]
    LD1 { V17.4H, V18.4H, V19.4H }, [X10]
    ADD  X10, X10, X23, LSR #0
    ST1 { V25.8B, V26.8B, V27.8B }, [X10]
    LD1 { V12.8B, V13.8B, V14.8B }, [X10]
    ADD  X10, X10, X23
    ST1 { V13.4S, V14.4S }, [X10]
    LD1 { V13.4S, V14.4S }, [X10]
    ADD  X10, X10, X23, LSR #0
    ST1 { V18.16B, V19.16B }, [X10]
    LD1 { V26.16B, V27.16B }, [X10]
    ADD  X10, X10, X23, LSR #0
    ST1 { V6.2D, V7.2D }, [X10]
    LD1 { V18.2D, V19.2D }, [X10]
    ADD  X10, X10, X23, ASR #0
    ST1 { V12.4S, V13.4S }, [X10]
    LD1 { V15.4S, V16.4S }, [X10]
    ADD  X10, X10, X23, ASR #0
    ST1 { V15.8H, V16.8H }, [X10]
    LD1 { V27.8H, V28.8H }, [X10]
    ADD  X10, X10, X23
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X16, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MRS  X18, FPSR
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V0.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D0
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V1.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D1
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D2
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V3.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D3
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D4
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V5.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D5
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V6.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D6
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D7
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V8.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D8
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V9.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D9
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D10
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V11.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D11
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D12
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V13.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D13
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V14.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D14
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V15.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D15
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D16
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V17.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D17
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V18.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D18
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V19.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D19
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V20.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D20
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V21.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D21
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V22.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D22
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D23
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V24.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D24
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V25.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D25
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D26
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V27.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D27
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D28
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D29
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V30.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D30
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V31.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D31
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X21
    FMOV  V0.D[1], X4
    FMOV  D1, X22
    FMOV  V1.D[1], X7
    FMOV  D2, X23
    FMOV  V2.D[1], X29
    FMOV  D3, X4
    FMOV  V3.D[1], X8
    FMOV  D4, X14
    FMOV  V4.D[1], X22
    FMOV  D5, X13
    FMOV  V5.D[1], X22
    FMOV  D6, X3
    FMOV  V6.D[1], X16
    FMOV  D7, X6
    FMOV  V7.D[1], X11
    FMOV  D8, X12
    FMOV  V8.D[1], X23
    FMOV  D9, X10
    FMOV  V9.D[1], X9
    FMOV  D10, X17
    FMOV  V10.D[1], X9
    FMOV  D11, X18
    FMOV  V11.D[1], X9
    FMOV  D12, X8
    FMOV  V12.D[1], X8
    FMOV  D13, X10
    FMOV  V13.D[1], X3
    FMOV  D14, X10
    FMOV  V14.D[1], X23
    FMOV  D15, X7
    FMOV  V15.D[1], X14
    FMOV  D16, X9
    FMOV  V16.D[1], X3
    FMOV  D17, X21
    FMOV  V17.D[1], X11
    FMOV  D18, X7
    FMOV  V18.D[1], X2
    FMOV  D19, X10
    FMOV  V19.D[1], X18
    FMOV  D20, X12
    FMOV  V20.D[1], X10
    FMOV  D21, X19
    FMOV  V21.D[1], X22
    FMOV  D22, X13
    FMOV  V22.D[1], X20
    FMOV  D23, X12
    FMOV  V23.D[1], X17
    FMOV  D24, X14
    FMOV  V24.D[1], X3
    FMOV  D25, X12
    FMOV  V25.D[1], X19
    FMOV  D26, X3
    FMOV  V26.D[1], X16
    FMOV  D27, X2
    FMOV  V27.D[1], X17
    FMOV  D28, X11
    FMOV  V28.D[1], X2
    FMOV  D29, X20
    FMOV  V29.D[1], X17
    FMOV  D30, X22
    FMOV  V30.D[1], X16
    FMOV  D31, X9
    FMOV  V31.D[1], X22
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X11, #0x40, LSL #0
    MOVZ  X17, #0xf00, LSL #0
    ADD  X23, X30, X17, LSR #0
    ST1 { V2.4S, V3.4S, V4.4S, V5.4S }, [X23]
    LD1 { V21.2D, V22.2D, V23.2D, V24.2D }, [X23]
    ADD  X23, X23, X11, LSR #0
    ST1 { V9.16B, V10.16B, V11.16B, V12.16B }, [X23]
    LD1 { V27.16B, V28.16B, V29.16B, V30.16B }, [X23]
    ADD  X23, X23, X11, ASR #0
    ST1 { V31.2D, V0.2D, V1.2D, V2.2D }, [X23]
    LD1 { V22.2D, V23.2D, V24.2D, V25.2D }, [X23]
    ADD  X23, X23, X11
    ST1 { V4.4S, V5.4S, V6.4S, V7.4S }, [X23]
    LD1 { V15.4S, V16.4S, V17.4S, V18.4S }, [X23]
    ADD  X23, X23, X11, ASR #0
    ST1 { V21.8H, V22.8H, V23.8H, V24.8H }, [X23]
    LD1 { V1.8H, V2.8H, V3.8H, V4.8H }, [X23]
    ADD  X23, X23, X11, ASR #0
    ST1 { V9.1D, V10.1D, V11.1D, V12.1D }, [X23]
    LD1 { V9.4H, V10.4H, V11.4H, V12.4H }, [X23]
    ADD  X23, X23, X11, LSR #0
    ST1 { V27.1D, V28.1D, V29.1D, V30.1D }, [X23]
    LD1 { V29.1D, V30.1D, V31.1D, V0.1D }, [X23]
    ADD  X23, X23, X11, ASR #0
    ST1 { V9.2S, V10.2S, V11.2S, V12.2S }, [X23]
    LD1 { V20.2S, V21.2S, V22.2S, V23.2S }, [X23]
    ADD  X23, X23, X11
    ST1 { V11.4H, V12.4H, V13.4H, V14.4H }, [X23]
    LD1 { V9.4H, V10.4H, V11.4H, V12.4H }, [X23]
    ADD  X23, X23, X11, LSR #0
    ST1 { V29.8B, V30.8B, V31.8B, V0.8B }, [X23]
    LD1 { V28.8B, V29.8B, V30.8B, V31.8B }, [X23]
    ADD  X23, X23, X11
    ST1 { V31.16B }, [X23]
    LD1 { V19.2D }, [X23]
    ADD  X23, X23, X11, LSR #0
    ST1 { V22.16B }, [X23]
    LD1 { V0.16B }, [X23]
    ADD  X23, X23, X11, LSR #0
    ST1 { V0.2D }, [X23]
    LD1 { V13.2D }, [X23]
    ADD  X23, X23, X11, LSR #0
    ST1 { V19.4S }, [X23]
    LD1 { V14.4S }, [X23]
    ADD  X23, X23, X11, ASR #0
    ST1 { V4.8H }, [X23]
    LD1 { V22.8H }, [X23]
    ADD  X23, X23, X11, ASR #0
    ST1 { V28.1D }, [X23]
    LD1 { V19.2S }, [X23]
    ADD  X23, X23, X11
    ST1 { V13.1D }, [X23]
    LD1 { V13.1D }, [X23]
    ADD  X23, X23, X11, ASR #0
    ST1 { V22.2S }, [X23]
    LD1 { V31.2S }, [X23]
    ADD  X23, X23, X11, LSR #0
    ST1 { V31.4H }, [X23]
    LD1 { V23.4H }, [X23]
    ADD  X23, X23, X11, ASR #0
    ST1 { V14.8B }, [X23]
    LD1 { V4.8B }, [X23]
    ADD  X23, X23, X11, LSR #0
    ST1 { V6.4S, V7.4S, V8.4S }, [X23]
    LD1 { V6.16B, V7.16B, V8.16B }, [X23]
    ADD  X23, X23, X11
    ST1 { V6.16B, V7.16B, V8.16B }, [X23]
    LD1 { V1.16B, V2.16B, V3.16B }, [X23]
    ADD  X23, X23, X11, ASR #0
    ST1 { V10.2D, V11.2D, V12.2D }, [X23]
    LD1 { V6.2D, V7.2D, V8.2D }, [X23]
    ADD  X23, X23, X11, ASR #0
    ST1 { V28.4S, V29.4S, V30.4S }, [X23]
    LD1 { V4.4S, V5.4S, V6.4S }, [X23]
    ADD  X23, X23, X11, LSR #0
    ST1 { V4.8H, V5.8H, V6.8H }, [X23]
    LD1 { V12.8H, V13.8H, V14.8H }, [X23]
    ADD  X23, X23, X11, ASR #0
    ST1 { V9.4H, V10.4H, V11.4H }, [X23]
    LD1 { V28.1D, V29.1D, V30.1D }, [X23]
    ADD  X23, X23, X11, ASR #0
    ST1 { V28.1D, V29.1D, V30.1D }, [X23]
    LD1 { V26.1D, V27.1D, V28.1D }, [X23]
    ADD  X23, X23, X11
    ST1 { V26.2S, V27.2S, V28.2S }, [X23]
    LD1 { V27.2S, V28.2S, V29.2S }, [X23]
    ADD  X23, X23, X11, ASR #0
    ST1 { V1.4H, V2.4H, V3.4H }, [X23]
    LD1 { V4.4H, V5.4H, V6.4H }, [X23]
    ADD  X23, X23, X11, ASR #0
    ST1 { V12.8B, V13.8B, V14.8B }, [X23]
    LD1 { V12.8B, V13.8B, V14.8B }, [X23]
    ADD  X23, X23, X11
    ST1 { V7.16B, V8.16B }, [X23]
    LD1 { V2.2D, V3.2D }, [X23]
    ADD  X23, X23, X11, LSR #0
    ST1 { V5.16B, V6.16B }, [X23]
    LD1 { V9.16B, V10.16B }, [X23]
    ADD  X23, X23, X11, ASR #0
    ST1 { V28.2D, V29.2D }, [X23]
    LD1 { V28.2D, V29.2D }, [X23]
    ADD  X23, X23, X11
    ST1 { V9.4S, V10.4S }, [X23]
    LD1 { V5.4S, V6.4S }, [X23]
    ADD  X23, X23, X11, ASR #0
    ST1 { V5.8H, V6.8H }, [X23]
    LD1 { V9.8H, V10.8H }, [X23]
    ADD  X23, X23, X11
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X2, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X2, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X2, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X2, X18, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X2, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X2, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X2, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X2, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X2, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X2, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X2, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X2, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X2, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X2, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    MRS  X18, FPSR
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V0.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D0
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V1.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D1
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D2
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V3.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D3
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D4
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D5
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D6
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V7.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D7
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D8
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D9
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D10
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V11.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D11
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D12
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V13.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D13
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V14.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D14
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V15.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D15
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D16
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V17.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D17
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V18.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D18
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V19.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D19
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D20
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D21
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V22.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D22
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D23
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V24.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D24
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V25.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D25
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V26.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D26
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V27.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D27
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D28
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D29
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V30.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D30
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, V31.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    FMOV  X18, D31
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X19, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X22
    FMOV  D1, X19
    FMOV  V1.D[1], X29
    FMOV  D2, X12
    FMOV  V2.D[1], X21
    FMOV  D3, X5
    FMOV  V3.D[1], X12
    FMOV  D4, X23
    FMOV  V4.D[1], X2
    FMOV  D5, X9
    FMOV  V5.D[1], X22
    FMOV  D6, X8
    FMOV  V6.D[1], X9
    FMOV  D7, X7
    FMOV  V7.D[1], X7
    FMOV  D8, X12
    FMOV  V8.D[1], X10
    FMOV  D9, X3
    FMOV  V9.D[1], X22
    FMOV  D10, X8
    FMOV  V10.D[1], X16
    FMOV  D11, X17
    FMOV  V11.D[1], X6
    FMOV  D12, X19
    FMOV  V12.D[1], X5
    FMOV  D13, X16
    FMOV  V13.D[1], X16
    FMOV  D14, X15
    FMOV  V14.D[1], X3
    FMOV  D15, X14
    FMOV  V15.D[1], X22
    FMOV  D16, X12
    FMOV  V16.D[1], X6
    FMOV  D17, X10
    FMOV  V17.D[1], X16
    FMOV  D18, X11
    FMOV  V18.D[1], X10
    FMOV  D19, X3
    FMOV  V19.D[1], X5
    FMOV  D20, X29
    FMOV  V20.D[1], X17
    FMOV  D21, X13
    FMOV  V21.D[1], X5
    FMOV  D22, X10
    FMOV  V22.D[1], X4
    FMOV  D23, X2
    FMOV  V23.D[1], X12
    FMOV  D24, X20
    FMOV  V24.D[1], X12
    FMOV  D25, X10
    FMOV  V25.D[1], X29
    FMOV  D26, X7
    FMOV  V26.D[1], X19
    FMOV  D27, X2
    FMOV  V27.D[1], X19
    FMOV  D28, X12
    FMOV  V28.D[1], X17
    FMOV  D29, X7
    FMOV  V29.D[1], X7
    FMOV  D30, X6
    FMOV  V30.D[1], X10
    FMOV  D31, X10
    FMOV  V31.D[1], X22
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x40, LSL #0
    MOVZ  X7, #0x1400, LSL #0
    ADD  X2, X30, X7
    ST1 { V15.8H, V16.8H, V17.8H, V18.8H }, [X2]
    LD1 { V22.16B, V23.16B, V24.16B, V25.16B }, [X2]
    ADD  X2, X2, X17, LSR #0
    ST1 { V23.16B, V24.16B, V25.16B, V26.16B }, [X2]
    LD1 { V11.16B, V12.16B, V13.16B, V14.16B }, [X2]
    ADD  X2, X2, X17, LSR #0
    ST1 { V28.2D, V29.2D, V30.2D, V31.2D }, [X2]
    LD1 { V23.2D, V24.2D, V25.2D, V26.2D }, [X2]
    ADD  X2, X2, X17, LSR #0
    ST1 { V11.4S, V12.4S, V13.4S, V14.4S }, [X2]
    LD1 { V8.4S, V9.4S, V10.4S, V11.4S }, [X2]
    ADD  X2, X2, X17, ASR #0
    ST1 { V23.8H, V24.8H, V25.8H, V26.8H }, [X2]
    LD1 { V27.8H, V28.8H, V29.8H, V30.8H }, [X2]
    ADD  X2, X2, X17, ASR #0
    ST1 { V5.8B, V6.8B, V7.8B, V8.8B }, [X2]
    LD1 { V20.4H, V21.4H, V22.4H, V23.4H }, [X2]
    ADD  X2, X2, X17, LSR #0
    ST1 { V2.1D, V3.1D, V4.1D, V5.1D }, [X2]
    LD1 { V15.1D, V16.1D, V17.1D, V18.1D }, [X2]
    ADD  X2, X2, X17, LSR #0
    ST1 { V15.2S, V16.2S, V17.2S, V18.2S }, [X2]
    LD1 { V2.2S, V3.2S, V4.2S, V5.2S }, [X2]
    ADD  X2, X2, X17, ASR #0
    ST1 { V8.4H, V9.4H, V10.4H, V11.4H }, [X2]
    LD1 { V8.4H, V9.4H, V10.4H, V11.4H }, [X2]
    ADD  X2, X2, X17
    ST1 { V10.8B, V11.8B, V12.8B, V13.8B }, [X2]
    LD1 { V16.8B, V17.8B, V18.8B, V19.8B }, [X2]
    ADD  X2, X2, X17
    ST1 { V29.2D }, [X2]
    LD1 { V9.16B }, [X2]
    ADD  X2, X2, X17
    ST1 { V1.16B }, [X2]
    LD1 { V6.16B }, [X2]
    ADD  X2, X2, X17, LSR #0
    ST1 { V17.2D }, [X2]
    LD1 { V22.2D }, [X2]
    ADD  X2, X2, X17, ASR #0
    ST1 { V3.4S }, [X2]
    LD1 { V11.4S }, [X2]
    ADD  X2, X2, X17, ASR #0
    ST1 { V31.8H }, [X2]
    LD1 { V1.8H }, [X2]
    ADD  X2, X2, X17
    ST1 { V22.1D }, [X2]
    LD1 { V6.1D }, [X2]
    ADD  X2, X2, X17
    ST1 { V3.1D }, [X2]
    LD1 { V8.1D }, [X2]
    ADD  X2, X2, X17
    ST1 { V9.2S }, [X2]
    LD1 { V9.2S }, [X2]
    ADD  X2, X2, X17, LSR #0
    ST1 { V6.4H }, [X2]
    LD1 { V13.4H }, [X2]
    ADD  X2, X2, X17, ASR #0
    ST1 { V11.8B }, [X2]
    LD1 { V10.8B }, [X2]
    ADD  X2, X2, X17
    ST1 { V11.8H, V12.8H, V13.8H }, [X2]
    LD1 { V20.16B, V21.16B, V22.16B }, [X2]
    ADD  X2, X2, X17, LSR #0
    ST1 { V8.16B, V9.16B, V10.16B }, [X2]
    LD1 { V29.16B, V30.16B, V31.16B }, [X2]
    ADD  X2, X2, X17
    ST1 { V1.2D, V2.2D, V3.2D }, [X2]
    LD1 { V1.2D, V2.2D, V3.2D }, [X2]
    ADD  X2, X2, X17
    ST1 { V20.4S, V21.4S, V22.4S }, [X2]
    LD1 { V18.4S, V19.4S, V20.4S }, [X2]
    ADD  X2, X2, X17, LSR #0
    ST1 { V18.8H, V19.8H, V20.8H }, [X2]
    LD1 { V11.8H, V12.8H, V13.8H }, [X2]
    ADD  X2, X2, X17, LSR #0
    ST1 { V1.1D, V2.1D, V3.1D }, [X2]
    LD1 { V23.4H, V24.4H, V25.4H }, [X2]
    ADD  X2, X2, X17
    ST1 { V23.1D, V24.1D, V25.1D }, [X2]
    LD1 { V1.1D, V2.1D, V3.1D }, [X2]
    ADD  X2, X2, X17, LSR #0
    ST1 { V26.2S, V27.2S, V28.2S }, [X2]
    LD1 { V22.2S, V23.2S, V24.2S }, [X2]
    ADD  X2, X2, X17
    ST1 { V22.4H, V23.4H, V24.4H }, [X2]
    LD1 { V23.4H, V24.4H, V25.4H }, [X2]
    ADD  X2, X2, X17, ASR #0
    ST1 { V1.8B, V2.8B, V3.8B }, [X2]
    LD1 { V25.8B, V26.8B, V27.8B }, [X2]
    ADD  X2, X2, X17, ASR #0
    ST1 { V24.16B, V25.16B }, [X2]
    LD1 { V1.16B, V2.16B }, [X2]
    ADD  X2, X2, X17, ASR #0
    ST1 { V26.16B, V27.16B }, [X2]
    LD1 { V25.16B, V26.16B }, [X2]
    ADD  X2, X2, X17, LSR #0
    ST1 { V14.2D, V15.2D }, [X2]
    LD1 { V14.2D, V15.2D }, [X2]
    ADD  X2, X2, X17, LSR #0
    ST1 { V1.4S, V2.4S }, [X2]
    LD1 { V6.4S, V7.4S }, [X2]
    ADD  X2, X2, X17, ASR #0
    ST1 { V6.8H, V7.8H }, [X2]
    LD1 { V27.8H, V28.8H }, [X2]
    ADD  X2, X2, X17, LSR #0
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X10, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X10, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X10, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X10, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X10, X19, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X10, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X10, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X10, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X10, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X10, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X10, X19, X18
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X10, X19, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X10, X19, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X10, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X10, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MRS  X19, FPSR
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V0.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D0
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V1.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D1
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V2.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D2
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V3.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D3
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V4.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D4
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V5.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D5
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V6.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D6
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V7.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D7
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V8.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D8
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V9.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D9
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V10.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D10
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V11.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D11
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V12.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D12
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V13.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D13
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V14.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D14
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V15.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D15
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V16.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D16
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V17.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D17
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V18.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D18
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V19.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D19
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V20.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D20
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V21.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D21
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V22.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D22
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V23.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D23
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V24.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D24
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V25.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D25
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V26.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D26
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V27.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D27
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D28
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V29.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D29
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V30.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D30
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V31.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D31
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X15, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X22
    FMOV  V0.D[1], X22
    FMOV  D1, X18
    FMOV  V1.D[1], X20
    FMOV  D2, X14
    FMOV  V2.D[1], X29
    FMOV  D3, X10
    FMOV  V3.D[1], X16
    FMOV  D4, X23
    FMOV  V4.D[1], X13
    FMOV  D5, X9
    FMOV  V5.D[1], X14
    FMOV  D6, X15
    FMOV  V6.D[1], X18
    FMOV  D7, X3
    FMOV  V7.D[1], X29
    FMOV  D8, X19
    FMOV  V8.D[1], X17
    FMOV  D9, X11
    FMOV  V9.D[1], X10
    FMOV  D10, X19
    FMOV  V10.D[1], X21
    FMOV  D11, X18
    FMOV  V11.D[1], X7
    FMOV  D12, X22
    FMOV  V12.D[1], X5
    FMOV  D13, X4
    FMOV  V13.D[1], X21
    FMOV  D14, X19
    FMOV  V14.D[1], X17
    FMOV  D15, X8
    FMOV  V15.D[1], X18
    FMOV  D16, X18
    FMOV  V16.D[1], X3
    FMOV  D17, X2
    FMOV  V17.D[1], X9
    FMOV  D18, X12
    FMOV  V18.D[1], X4
    FMOV  D19, X12
    FMOV  V19.D[1], X17
    FMOV  D20, X21
    FMOV  V20.D[1], X4
    FMOV  D21, X3
    FMOV  V21.D[1], X23
    FMOV  D22, X3
    FMOV  V22.D[1], X10
    FMOV  D23, X21
    FMOV  V23.D[1], X20
    FMOV  D24, X29
    FMOV  V24.D[1], X21
    FMOV  D25, X7
    FMOV  V25.D[1], X9
    FMOV  D26, X15
    FMOV  V26.D[1], X15
    FMOV  D27, X4
    FMOV  V27.D[1], X4
    FMOV  D28, X11
    FMOV  V28.D[1], X16
    FMOV  D29, X20
    FMOV  V29.D[1], X13
    FMOV  D30, X4
    FMOV  V30.D[1], X18
    FMOV  D31, X5
    FMOV  V31.D[1], X3
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X22, #0x40, LSL #0
    MOVZ  X9, #0x1900, LSL #0
    ADD  X14, X30, X9, ASR #0
    ST1 { V27.2D, V28.2D, V29.2D, V30.2D }, [X14]
    LD1 { V29.16B, V30.16B, V31.16B, V0.16B }, [X14]
    ADD  X14, X14, X22, ASR #0
    ST1 { V26.16B, V27.16B, V28.16B, V29.16B }, [X14]
    LD1 { V7.16B, V8.16B, V9.16B, V10.16B }, [X14]
    ADD  X14, X14, X22, LSR #0
    ST1 { V7.2D, V8.2D, V9.2D, V10.2D }, [X14]
    LD1 { V20.2D, V21.2D, V22.2D, V23.2D }, [X14]
    ADD  X14, X14, X22, ASR #0
    ST1 { V20.4S, V21.4S, V22.4S, V23.4S }, [X14]
    LD1 { V25.4S, V26.4S, V27.4S, V28.4S }, [X14]
    ADD  X14, X14, X22, LSR #0
    ST1 { V25.8H, V26.8H, V27.8H, V28.8H }, [X14]
    LD1 { V26.8H, V27.8H, V28.8H, V29.8H }, [X14]
    ADD  X14, X14, X22
    ST1 { V8.2S, V9.2S, V10.2S, V11.2S }, [X14]
    LD1 { V12.8B, V13.8B, V14.8B, V15.8B }, [X14]
    ADD  X14, X14, X22, LSR #0
    ST1 { V20.1D, V21.1D, V22.1D, V23.1D }, [X14]
    LD1 { V11.1D, V12.1D, V13.1D, V14.1D }, [X14]
    ADD  X14, X14, X22
    ST1 { V26.2S, V27.2S, V28.2S, V29.2S }, [X14]
    LD1 { V31.2S, V0.2S, V1.2S, V2.2S }, [X14]
    ADD  X14, X14, X22, LSR #0
    ST1 { V2.4H, V3.4H, V4.4H, V5.4H }, [X14]
    LD1 { V3.4H, V4.4H, V5.4H, V6.4H }, [X14]
    ADD  X14, X14, X22, ASR #0
    ST1 { V12.8B, V13.8B, V14.8B, V15.8B }, [X14]
    LD1 { V20.8B, V21.8B, V22.8B, V23.8B }, [X14]
    ADD  X14, X14, X22, ASR #0
    ST1 { V20.16B }, [X14]
    LD1 { V24.8H }, [X14]
    ADD  X14, X14, X22, LSR #0
    ST1 { V21.16B }, [X14]
    LD1 { V28.16B }, [X14]
    ADD  X14, X14, X22, LSR #0
    ST1 { V17.2D }, [X14]
    LD1 { V19.2D }, [X14]
    ADD  X14, X14, X22, ASR #0
    ST1 { V1.4S }, [X14]
    LD1 { V17.4S }, [X14]
    ADD  X14, X14, X22, LSR #0
    ST1 { V23.8H }, [X14]
    LD1 { V16.8H }, [X14]
    ADD  X14, X14, X22
    ST1 { V17.4H }, [X14]
    LD1 { V1.2S }, [X14]
    ADD  X14, X14, X22, ASR #0
    ST1 { V0.1D }, [X14]
    LD1 { V13.1D }, [X14]
    ADD  X14, X14, X22
    ST1 { V1.2S }, [X14]
    LD1 { V20.2S }, [X14]
    ADD  X14, X14, X22
    ST1 { V15.4H }, [X14]
    LD1 { V23.4H }, [X14]
    ADD  X14, X14, X22
    ST1 { V22.8B }, [X14]
    LD1 { V13.8B }, [X14]
    ADD  X14, X14, X22, ASR #0
    ST1 { V21.16B, V22.16B, V23.16B }, [X14]
    LD1 { V9.2D, V10.2D, V11.2D }, [X14]
    ADD  X14, X14, X22, ASR #0
    ST1 { V9.16B, V10.16B, V11.16B }, [X14]
    LD1 { V4.16B, V5.16B, V6.16B }, [X14]
    ADD  X14, X14, X22
    ST1 { V11.2D, V12.2D, V13.2D }, [X14]
    LD1 { V4.2D, V5.2D, V6.2D }, [X14]
    ADD  X14, X14, X22
    ST1 { V10.4S, V11.4S, V12.4S }, [X14]
    LD1 { V9.4S, V10.4S, V11.4S }, [X14]
    ADD  X14, X14, X22, LSR #0
    ST1 { V4.8H, V5.8H, V6.8H }, [X14]
    LD1 { V7.8H, V8.8H, V9.8H }, [X14]
    ADD  X14, X14, X22, LSR #0
    ST1 { V9.1D, V10.1D, V11.1D }, [X14]
    LD1 { V10.4H, V11.4H, V12.4H }, [X14]
    ADD  X14, X14, X22, LSR #0
    ST1 { V10.1D, V11.1D, V12.1D }, [X14]
    LD1 { V18.1D, V19.1D, V20.1D }, [X14]
    ADD  X14, X14, X22
    ST1 { V18.2S, V19.2S, V20.2S }, [X14]
    LD1 { V4.2S, V5.2S, V6.2S }, [X14]
    ADD  X14, X14, X22, ASR #0
    ST1 { V28.4H, V29.4H, V30.4H }, [X14]
    LD1 { V21.4H, V22.4H, V23.4H }, [X14]
    ADD  X14, X14, X22
    ST1 { V4.8B, V5.8B, V6.8B }, [X14]
    LD1 { V10.8B, V11.8B, V12.8B }, [X14]
    ADD  X14, X14, X22, LSR #0
    ST1 { V10.8H, V11.8H }, [X14]
    LD1 { V27.2D, V28.2D }, [X14]
    ADD  X14, X14, X22, ASR #0
    ST1 { V7.16B, V8.16B }, [X14]
    LD1 { V4.16B, V5.16B }, [X14]
    ADD  X14, X14, X22, ASR #0
    ST1 { V22.2D, V23.2D }, [X14]
    LD1 { V25.2D, V26.2D }, [X14]
    ADD  X14, X14, X22, ASR #0
    ST1 { V27.4S, V28.4S }, [X14]
    LD1 { V29.4S, V30.4S }, [X14]
    ADD  X14, X14, X22, ASR #0
    ST1 { V30.8H, V31.8H }, [X14]
    LD1 { V0.8H, V1.8H }, [X14]
    ADD  X14, X14, X22, LSR #0
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X18, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X18, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X18, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X18, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X18, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X18, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X18, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X18, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X18, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X18, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X18, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X18, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X18, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X18, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MRS  X23, FPSR
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V0.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D0
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V1.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D1
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D2
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D3
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D4
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D5
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D6
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D7
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D8
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D9
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D10
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D11
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D12
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D13
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D14
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D15
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D16
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D17
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D18
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D19
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D20
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D21
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D22
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V23.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D23
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D24
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D25
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D26
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D27
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D28
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D29
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V30.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D30
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V31.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D31
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X10
    FMOV  D1, X22
    FMOV  V1.D[1], X20
    FMOV  D2, X16
    FMOV  V2.D[1], X23
    FMOV  D3, X21
    FMOV  V3.D[1], X11
    FMOV  D4, X18
    FMOV  V4.D[1], X21
    FMOV  D5, X2
    FMOV  V5.D[1], X11
    FMOV  D6, X3
    FMOV  V6.D[1], X29
    FMOV  D7, X4
    FMOV  V7.D[1], X7
    FMOV  D8, X29
    FMOV  V8.D[1], X2
    FMOV  D9, X12
    FMOV  V9.D[1], X15
    FMOV  D10, X4
    FMOV  V10.D[1], X22
    FMOV  D11, X20
    FMOV  V11.D[1], X10
    FMOV  D12, X17
    FMOV  V12.D[1], X5
    FMOV  D13, X19
    FMOV  V13.D[1], X16
    FMOV  D14, X12
    FMOV  V14.D[1], X21
    FMOV  D15, X16
    FMOV  V15.D[1], X29
    FMOV  D16, X2
    FMOV  V16.D[1], X2
    FMOV  D17, X11
    FMOV  V17.D[1], X12
    FMOV  D18, X3
    FMOV  V18.D[1], X16
    FMOV  D19, X6
    FMOV  V19.D[1], X21
    FMOV  D20, X12
    FMOV  V20.D[1], X20
    FMOV  D21, X17
    FMOV  V21.D[1], X20
    FMOV  D22, X21
    FMOV  V22.D[1], X18
    FMOV  D23, X8
    FMOV  V23.D[1], X3
    FMOV  D24, X19
    FMOV  V24.D[1], X11
    FMOV  D25, X14
    FMOV  V25.D[1], X11
    FMOV  D26, X5
    FMOV  V26.D[1], X3
    FMOV  D27, X12
    FMOV  V27.D[1], X16
    FMOV  D28, X22
    FMOV  V28.D[1], X22
    FMOV  D29, X7
    FMOV  V29.D[1], X22
    FMOV  D30, X6
    FMOV  V30.D[1], X7
    FMOV  D31, X9
    FMOV  V31.D[1], X15
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X10, #0x40, LSL #0
    MOVZ  X3, #0x1e00, LSL #0
    ADD  X14, X30, X3, LSR #0
    ST1 { V26.4S, V27.4S, V28.4S, V29.4S }, [X14]
    LD1 { V3.2D, V4.2D, V5.2D, V6.2D }, [X14]
    ADD  X14, X14, X10
    ST1 { V6.16B, V7.16B, V8.16B, V9.16B }, [X14]
    LD1 { V12.16B, V13.16B, V14.16B, V15.16B }, [X14]
    ADD  X14, X14, X10, LSR #0
    ST1 { V21.2D, V22.2D, V23.2D, V24.2D }, [X14]
    LD1 { V9.2D, V10.2D, V11.2D, V12.2D }, [X14]
    ADD  X14, X14, X10, ASR #0
    ST1 { V2.4S, V3.4S, V4.4S, V5.4S }, [X14]
    LD1 { V2.4S, V3.4S, V4.4S, V5.4S }, [X14]
    ADD  X14, X14, X10, LSR #0
    ST1 { V29.8H, V30.8H, V31.8H, V0.8H }, [X14]
    LD1 { V6.8H, V7.8H, V8.8H, V9.8H }, [X14]
    ADD  X14, X14, X10, ASR #0
    ST1 { V10.2S, V11.2S, V12.2S, V13.2S }, [X14]
    LD1 { V20.1D, V21.1D, V22.1D, V23.1D }, [X14]
    ADD  X14, X14, X10
    ST1 { V2.1D, V3.1D, V4.1D, V5.1D }, [X14]
    LD1 { V30.1D, V31.1D, V0.1D, V1.1D }, [X14]
    ADD  X14, X14, X10
    ST1 { V6.2S, V7.2S, V8.2S, V9.2S }, [X14]
    LD1 { V2.2S, V3.2S, V4.2S, V5.2S }, [X14]
    ADD  X14, X14, X10, ASR #0
    ST1 { V12.4H, V13.4H, V14.4H, V15.4H }, [X14]
    LD1 { V29.4H, V30.4H, V31.4H, V0.4H }, [X14]
    ADD  X14, X14, X10, LSR #0
    ST1 { V2.8B, V3.8B, V4.8B, V5.8B }, [X14]
    LD1 { V11.8B, V12.8B, V13.8B, V14.8B }, [X14]
    ADD  X14, X14, X10, LSR #0
    ST1 { V2.16B }, [X14]
    LD1 { V6.4S }, [X14]
    ADD  X14, X14, X10, LSR #0
    ST1 { V1.16B }, [X14]
    LD1 { V12.16B }, [X14]
    ADD  X14, X14, X10, LSR #0
    ST1 { V10.2D }, [X14]
    LD1 { V16.2D }, [X14]
    ADD  X14, X14, X10, LSR #0
    ST1 { V6.4S }, [X14]
    LD1 { V6.4S }, [X14]
    ADD  X14, X14, X10
    ST1 { V24.8H }, [X14]
    LD1 { V3.8H }, [X14]
    ADD  X14, X14, X10, LSR #0
    ST1 { V9.1D }, [X14]
    LD1 { V5.4H }, [X14]
    ADD  X14, X14, X10, ASR #0
    ST1 { V16.1D }, [X14]
    LD1 { V16.1D }, [X14]
    ADD  X14, X14, X10, LSR #0
    ST1 { V5.2S }, [X14]
    LD1 { V15.2S }, [X14]
    ADD  X14, X14, X10, LSR #0
    ST1 { V30.4H }, [X14]
    LD1 { V7.4H }, [X14]
    ADD  X14, X14, X10, ASR #0
    ST1 { V30.8B }, [X14]
    LD1 { V29.8B }, [X14]
    ADD  X14, X14, X10, ASR #0
    ST1 { V2.8H, V3.8H, V4.8H }, [X14]
    LD1 { V2.8H, V3.8H, V4.8H }, [X14]
    ADD  X14, X14, X10, ASR #0
    ST1 { V29.16B, V30.16B, V31.16B }, [X14]
    LD1 { V13.16B, V14.16B, V15.16B }, [X14]
    ADD  X14, X14, X10
    ST1 { V14.2D, V15.2D, V16.2D }, [X14]
    LD1 { V21.2D, V22.2D, V23.2D }, [X14]
    ADD  X14, X14, X10, ASR #0
    ST1 { V27.4S, V28.4S, V29.4S }, [X14]
    LD1 { V3.4S, V4.4S, V5.4S }, [X14]
    ADD  X14, X14, X10, ASR #0
    ST1 { V9.8H, V10.8H, V11.8H }, [X14]
    LD1 { V9.8H, V10.8H, V11.8H }, [X14]
    ADD  X14, X14, X10, ASR #0
    ST1 { V29.1D, V30.1D, V31.1D }, [X14]
    LD1 { V29.2S, V30.2S, V31.2S }, [X14]
    ADD  X14, X14, X10, ASR #0
    ST1 { V3.1D, V4.1D, V5.1D }, [X14]
    LD1 { V3.1D, V4.1D, V5.1D }, [X14]
    ADD  X14, X14, X10
    ST1 { V1.2S, V2.2S, V3.2S }, [X14]
    LD1 { V1.2S, V2.2S, V3.2S }, [X14]
    ADD  X14, X14, X10, ASR #0
    ST1 { V9.4H, V10.4H, V11.4H }, [X14]
    LD1 { V9.4H, V10.4H, V11.4H }, [X14]
    ADD  X14, X14, X10
    ST1 { V2.8B, V3.8B, V4.8B }, [X14]
    LD1 { V14.8B, V15.8B, V16.8B }, [X14]
    ADD  X14, X14, X10
    ST1 { V10.2D, V11.2D }, [X14]
    LD1 { V10.16B, V11.16B }, [X14]
    ADD  X14, X14, X10
    ST1 { V14.16B, V15.16B }, [X14]
    LD1 { V14.16B, V15.16B }, [X14]
    ADD  X14, X14, X10, ASR #0
    ST1 { V23.2D, V24.2D }, [X14]
    LD1 { V23.2D, V24.2D }, [X14]
    ADD  X14, X14, X10, ASR #0
    ST1 { V29.4S, V30.4S }, [X14]
    LD1 { V2.4S, V3.4S }, [X14]
    ADD  X14, X14, X10, ASR #0
    ST1 { V6.8H, V7.8H }, [X14]
    LD1 { V29.8H, V30.8H }, [X14]
    ADD  X14, X14, X10, ASR #0
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X19, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X19, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X19, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X19, X5, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X19, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X19, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X19, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X19, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X19, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X19, X5, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X19, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X19, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X19, X5, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X19, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X19, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MRS  X5, FPSR
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V0.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D0
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V1.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D1
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V2.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D2
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V3.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D3
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D4
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V5.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D5
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V6.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D6
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V7.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D7
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V8.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D8
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V9.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D9
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V10.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D10
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V11.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D11
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V12.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D12
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V13.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D13
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V14.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D14
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V15.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D15
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V16.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D16
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V17.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D17
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V18.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D18
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V19.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D19
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V20.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D20
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V21.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D21
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V22.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D22
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V23.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D23
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V24.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D24
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V25.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D25
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V26.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D26
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V27.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D27
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V28.D[1]
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D28
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V29.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D29
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V30.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D30
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, V31.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    FMOV  X5, D31
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X5
    FMOV  V0.D[1], X10
    FMOV  D1, X17
    FMOV  V1.D[1], X22
    FMOV  D2, X21
    FMOV  V2.D[1], X29
    FMOV  D3, X23
    FMOV  V3.D[1], X21
    FMOV  D4, X20
    FMOV  V4.D[1], X13
    FMOV  D5, X23
    FMOV  V5.D[1], X6
    FMOV  D6, X10
    FMOV  V6.D[1], X4
    FMOV  D7, X5
    FMOV  V7.D[1], X10
    FMOV  D8, X11
    FMOV  V8.D[1], X29
    FMOV  D9, X20
    FMOV  V9.D[1], X15
    FMOV  D10, X6
    FMOV  V10.D[1], X15
    FMOV  D11, X15
    FMOV  V11.D[1], X13
    FMOV  D12, X8
    FMOV  V12.D[1], X20
    FMOV  D13, X2
    FMOV  V13.D[1], X12
    FMOV  D14, X2
    FMOV  V14.D[1], X23
    FMOV  D15, X2
    FMOV  V15.D[1], X5
    FMOV  D16, X23
    FMOV  V16.D[1], X13
    FMOV  D17, X18
    FMOV  V17.D[1], X11
    FMOV  D18, X11
    FMOV  V18.D[1], X16
    FMOV  D19, X4
    FMOV  V19.D[1], X13
    FMOV  D20, X19
    FMOV  V20.D[1], X9
    FMOV  D21, X16
    FMOV  V21.D[1], X3
    FMOV  D22, X23
    FMOV  V22.D[1], X17
    FMOV  D23, X11
    FMOV  V23.D[1], X4
    FMOV  D24, X19
    FMOV  V24.D[1], X22
    FMOV  D25, X8
    FMOV  V25.D[1], X12
    FMOV  D26, X10
    FMOV  V26.D[1], X17
    FMOV  D27, X23
    FMOV  V27.D[1], X7
    FMOV  D28, X10
    FMOV  V28.D[1], X12
    FMOV  D29, X18
    FMOV  V29.D[1], X29
    FMOV  D30, X14
    FMOV  V30.D[1], X22
    FMOV  D31, X15
    FMOV  V31.D[1], X21
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X13, #0x40, LSL #0
    MOVZ  X16, #0x2300, LSL #0
    ADD  X18, X30, X16, LSR #0
    ST1 { V27.16B, V28.16B, V29.16B, V30.16B }, [X18]
    LD1 { V0.4S, V1.4S, V2.4S, V3.4S }, [X18]
    ADD  X18, X18, X13
    ST1 { V19.16B, V20.16B, V21.16B, V22.16B }, [X18]
    LD1 { V10.16B, V11.16B, V12.16B, V13.16B }, [X18]
    ADD  X18, X18, X13, LSR #0
    ST1 { V21.2D, V22.2D, V23.2D, V24.2D }, [X18]
    LD1 { V5.2D, V6.2D, V7.2D, V8.2D }, [X18]
    ADD  X18, X18, X13
    ST1 { V5.4S, V6.4S, V7.4S, V8.4S }, [X18]
    LD1 { V3.4S, V4.4S, V5.4S, V6.4S }, [X18]
    ADD  X18, X18, X13, LSR #0
    ST1 { V31.8H, V0.8H, V1.8H, V2.8H }, [X18]
    LD1 { V1.8H, V2.8H, V3.8H, V4.8H }, [X18]
    ADD  X18, X18, X13
    ST1 { V1.4H, V2.4H, V3.4H, V4.4H }, [X18]
    LD1 { V29.4H, V30.4H, V31.4H, V0.4H }, [X18]
    ADD  X18, X18, X13, LSR #0
    ST1 { V10.1D, V11.1D, V12.1D, V13.1D }, [X18]
    LD1 { V14.1D, V15.1D, V16.1D, V17.1D }, [X18]
    ADD  X18, X18, X13
    ST1 { V14.2S, V15.2S, V16.2S, V17.2S }, [X18]
    LD1 { V19.2S, V20.2S, V21.2S, V22.2S }, [X18]
    ADD  X18, X18, X13, LSR #0
    ST1 { V29.4H, V30.4H, V31.4H, V0.4H }, [X18]
    LD1 { V9.4H, V10.4H, V11.4H, V12.4H }, [X18]
    ADD  X18, X18, X13
    ST1 { V27.8B, V28.8B, V29.8B, V30.8B }, [X18]
    LD1 { V10.8B, V11.8B, V12.8B, V13.8B }, [X18]
    ADD  X18, X18, X13
    ST1 { V20.4S }, [X18]
    LD1 { V16.2D }, [X18]
    ADD  X18, X18, X13, LSR #0
    ST1 { V12.16B }, [X18]
    LD1 { V14.16B }, [X18]
    ADD  X18, X18, X13, LSR #0
    ST1 { V9.2D }, [X18]
    LD1 { V26.2D }, [X18]
    ADD  X18, X18, X13
    ST1 { V16.4S }, [X18]
    LD1 { V16.4S }, [X18]
    ADD  X18, X18, X13, ASR #0
    ST1 { V23.8H }, [X18]
    LD1 { V9.8H }, [X18]
    ADD  X18, X18, X13
    ST1 { V26.8B }, [X18]
    LD1 { V27.2S }, [X18]
    ADD  X18, X18, X13
    ST1 { V11.1D }, [X18]
    LD1 { V23.1D }, [X18]
    ADD  X18, X18, X13, ASR #0
    ST1 { V14.2S }, [X18]
    LD1 { V11.2S }, [X18]
    ADD  X18, X18, X13, LSR #0
    ST1 { V16.4H }, [X18]
    LD1 { V26.4H }, [X18]
    ADD  X18, X18, X13, ASR #0
    ST1 { V9.8B }, [X18]
    LD1 { V16.8B }, [X18]
    ADD  X18, X18, X13, LSR #0
    ST1 { V3.16B, V4.16B, V5.16B }, [X18]
    LD1 { V23.4S, V24.4S, V25.4S }, [X18]
    ADD  X18, X18, X13
    ST1 { V24.16B, V25.16B, V26.16B }, [X18]
    LD1 { V3.16B, V4.16B, V5.16B }, [X18]
    ADD  X18, X18, X13, ASR #0
    ST1 { V20.2D, V21.2D, V22.2D }, [X18]
    LD1 { V24.2D, V25.2D, V26.2D }, [X18]
    ADD  X18, X18, X13, ASR #0
    ST1 { V23.4S, V24.4S, V25.4S }, [X18]
    LD1 { V20.4S, V21.4S, V22.4S }, [X18]
    ADD  X18, X18, X13, ASR #0
    ST1 { V17.8H, V18.8H, V19.8H }, [X18]
    LD1 { V17.8H, V18.8H, V19.8H }, [X18]
    ADD  X18, X18, X13, LSR #0
    ST1 { V16.1D, V17.1D, V18.1D }, [X18]
    LD1 { V16.8B, V17.8B, V18.8B }, [X18]
    ADD  X18, X18, X13, ASR #0
    ST1 { V19.1D, V20.1D, V21.1D }, [X18]
    LD1 { V31.1D, V0.1D, V1.1D }, [X18]
    ADD  X18, X18, X13, LSR #0
    ST1 { V2.2S, V3.2S, V4.2S }, [X18]
    LD1 { V16.2S, V17.2S, V18.2S }, [X18]
    ADD  X18, X18, X13
    ST1 { V26.4H, V27.4H, V28.4H }, [X18]
    LD1 { V23.4H, V24.4H, V25.4H }, [X18]
    ADD  X18, X18, X13, LSR #0
    ST1 { V23.8B, V24.8B, V25.8B }, [X18]
    LD1 { V5.8B, V6.8B, V7.8B }, [X18]
    ADD  X18, X18, X13
    ST1 { V0.2D, V1.2D }, [X18]
    LD1 { V24.16B, V25.16B }, [X18]
    ADD  X18, X18, X13
    ST1 { V17.16B, V18.16B }, [X18]
    LD1 { V25.16B, V26.16B }, [X18]
    ADD  X18, X18, X13, ASR #0
    ST1 { V9.2D, V10.2D }, [X18]
    LD1 { V0.2D, V1.2D }, [X18]
    ADD  X18, X18, X13
    ST1 { V20.4S, V21.4S }, [X18]
    LD1 { V27.4S, V28.4S }, [X18]
    ADD  X18, X18, X13, ASR #0
    ST1 { V3.8H, V4.8H }, [X18]
    LD1 { V3.8H, V4.8H }, [X18]
    ADD  X18, X18, X13, ASR #0
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X6, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X6, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X6, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X6, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X6, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X6, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X6, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X6, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X6, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X6, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X6, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X6, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X6, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X6, X12, X22
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X6, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP01_TestFail
    MRS  X12, FPSR
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V0.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D0
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V1.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D1
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D2
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D3
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D4
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D5
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D6
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D7
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D8
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D9
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D10
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D11
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V12.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D12
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D13
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D14
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D15
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D16
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D17
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D18
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D19
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D20
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D21
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D22
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D23
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D24
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D25
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D26
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D27
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D28
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D29
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V30.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D30
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, V31.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    FMOV  X12, D31
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X10
    FMOV  V0.D[1], X20
    FMOV  D1, X21
    FMOV  V1.D[1], X22
    FMOV  D2, X17
    FMOV  V2.D[1], X23
    FMOV  D3, X29
    FMOV  V3.D[1], X5
    FMOV  D4, X11
    FMOV  V4.D[1], X9
    FMOV  D5, X2
    FMOV  V5.D[1], X15
    FMOV  D6, X11
    FMOV  V6.D[1], X7
    FMOV  D7, X6
    FMOV  V7.D[1], X11
    FMOV  D8, X15
    FMOV  V8.D[1], X17
    FMOV  D9, X18
    FMOV  V9.D[1], X5
    FMOV  D10, X23
    FMOV  V10.D[1], X13
    FMOV  D11, X19
    FMOV  V11.D[1], X15
    FMOV  D12, X18
    FMOV  V12.D[1], X6
    FMOV  D13, X12
    FMOV  V13.D[1], X15
    FMOV  D14, X22
    FMOV  V14.D[1], X22
    FMOV  D15, X17
    FMOV  V15.D[1], X15
    FMOV  D16, X3
    FMOV  V16.D[1], X5
    FMOV  D17, X8
    FMOV  V17.D[1], X14
    FMOV  D18, X15
    FMOV  V18.D[1], X23
    FMOV  D19, X17
    FMOV  V19.D[1], X14
    FMOV  D20, X6
    FMOV  V20.D[1], X17
    FMOV  D21, X13
    FMOV  V21.D[1], X17
    FMOV  D22, X6
    FMOV  V22.D[1], X11
    FMOV  D23, X16
    FMOV  V23.D[1], X4
    FMOV  D24, X13
    FMOV  V24.D[1], X20
    FMOV  D25, X3
    FMOV  V25.D[1], X8
    FMOV  D26, X16
    FMOV  V26.D[1], X18
    FMOV  D27, X12
    FMOV  V27.D[1], X13
    FMOV  D28, X13
    FMOV  V28.D[1], X13
    FMOV  D29, X17
    FMOV  V29.D[1], X22
    FMOV  D30, X15
    FMOV  V30.D[1], X3
    FMOV  D31, X22
    FMOV  V31.D[1], X20
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X6, #0x40, LSL #0
    MOVZ  X29, #0x2800, LSL #0
    ADD  X23, X30, X29, LSR #0
    ST1 { V28.2D, V29.2D, V30.2D, V31.2D }, [X23]
    LD1 { V14.4S, V15.4S, V16.4S, V17.4S }, [X23]
    ADD  X23, X23, X6
    ST1 { V26.16B, V27.16B, V28.16B, V29.16B }, [X23]
    LD1 { V23.16B, V24.16B, V25.16B, V26.16B }, [X23]
    ADD  X23, X23, X6
    ST1 { V11.2D, V12.2D, V13.2D, V14.2D }, [X23]
    LD1 { V13.2D, V14.2D, V15.2D, V16.2D }, [X23]
    ADD  X23, X23, X6, LSR #0
    ST1 { V10.4S, V11.4S, V12.4S, V13.4S }, [X23]
    LD1 { V20.4S, V21.4S, V22.4S, V23.4S }, [X23]
    ADD  X23, X23, X6, ASR #0
    ST1 { V26.8H, V27.8H, V28.8H, V29.8H }, [X23]
    LD1 { V28.8H, V29.8H, V30.8H, V31.8H }, [X23]
    ADD  X23, X23, X6, ASR #0
    ST1 { V4.1D, V5.1D, V6.1D, V7.1D }, [X23]
    LD1 { V31.1D, V0.1D, V1.1D, V2.1D }, [X23]
    ADD  X23, X23, X6
    ST1 { V2.1D, V3.1D, V4.1D, V5.1D }, [X23]
    LD1 { V5.1D, V6.1D, V7.1D, V8.1D }, [X23]
    ADD  X23, X23, X6, LSR #0
    ST1 { V5.2S, V6.2S, V7.2S, V8.2S }, [X23]
    LD1 { V25.2S, V26.2S, V27.2S, V28.2S }, [X23]
    ADD  X23, X23, X6
    ST1 { V23.4H, V24.4H, V25.4H, V26.4H }, [X23]
    LD1 { V6.4H, V7.4H, V8.4H, V9.4H }, [X23]
    ADD  X23, X23, X6, LSR #0
    ST1 { V29.8B, V30.8B, V31.8B, V0.8B }, [X23]
    LD1 { V29.8B, V30.8B, V31.8B, V0.8B }, [X23]
    ADD  X23, X23, X6
    ST1 { V7.4S }, [X23]
    LD1 { V17.2D }, [X23]
    ADD  X23, X23, X6, LSR #0
    ST1 { V0.16B }, [X23]
    LD1 { V4.16B }, [X23]
    ADD  X23, X23, X6
    ST1 { V9.2D }, [X23]
    LD1 { V0.2D }, [X23]
    ADD  X23, X23, X6, ASR #0
    ST1 { V14.4S }, [X23]
    LD1 { V26.4S }, [X23]
    ADD  X23, X23, X6, ASR #0
    ST1 { V4.8H }, [X23]
    LD1 { V22.8H }, [X23]
    ADD  X23, X23, X6, ASR #0
    ST1 { V22.2S }, [X23]
    LD1 { V2.1D }, [X23]
    ADD  X23, X23, X6
    ST1 { V0.1D }, [X23]
    LD1 { V14.1D }, [X23]
    ADD  X23, X23, X6, ASR #0
    ST1 { V17.2S }, [X23]
    LD1 { V16.2S }, [X23]
    ADD  X23, X23, X6
    ST1 { V17.4H }, [X23]
    LD1 { V0.4H }, [X23]
    ADD  X23, X23, X6, ASR #0
    ST1 { V0.8B }, [X23]
    LD1 { V17.8B }, [X23]
    ADD  X23, X23, X6, LSR #0
    ST1 { V4.4S, V5.4S, V6.4S }, [X23]
    LD1 { V4.2D, V5.2D, V6.2D }, [X23]
    ADD  X23, X23, X6, LSR #0
    ST1 { V25.16B, V26.16B, V27.16B }, [X23]
    LD1 { V24.16B, V25.16B, V26.16B }, [X23]
    ADD  X23, X23, X6, ASR #0
    ST1 { V4.2D, V5.2D, V6.2D }, [X23]
    LD1 { V4.2D, V5.2D, V6.2D }, [X23]
    ADD  X23, X23, X6
    ST1 { V4.4S, V5.4S, V6.4S }, [X23]
    LD1 { V20.4S, V21.4S, V22.4S }, [X23]
    ADD  X23, X23, X6, ASR #0
    ST1 { V1.8H, V2.8H, V3.8H }, [X23]
    LD1 { V1.8H, V2.8H, V3.8H }, [X23]
    ADD  X23, X23, X6, ASR #0
    ST1 { V20.4H, V21.4H, V22.4H }, [X23]
    LD1 { V30.1D, V31.1D, V0.1D }, [X23]
    ADD  X23, X23, X6, LSR #0
    ST1 { V30.1D, V31.1D, V0.1D }, [X23]
    LD1 { V4.1D, V5.1D, V6.1D }, [X23]
    ADD  X23, X23, X6, LSR #0
    ST1 { V26.2S, V27.2S, V28.2S }, [X23]
    LD1 { V20.2S, V21.2S, V22.2S }, [X23]
    ADD  X23, X23, X6, LSR #0
    ST1 { V3.4H, V4.4H, V5.4H }, [X23]
    LD1 { V31.4H, V0.4H, V1.4H }, [X23]
    ADD  X23, X23, X6, ASR #0
    ST1 { V20.8B, V21.8B, V22.8B }, [X23]
    LD1 { V26.8B, V27.8B, V28.8B }, [X23]
    ADD  X23, X23, X6, ASR #0
    ST1 { V1.16B, V2.16B }, [X23]
    LD1 { V4.16B, V5.16B }, [X23]
    ADD  X23, X23, X6
    ST1 { V31.16B, V0.16B }, [X23]
    LD1 { V9.16B, V10.16B }, [X23]
    ADD  X23, X23, X6
    ST1 { V27.2D, V28.2D }, [X23]
    LD1 { V1.2D, V2.2D }, [X23]
    ADD  X23, X23, X6, ASR #0
    ST1 { V9.4S, V10.4S }, [X23]
    LD1 { V21.4S, V22.4S }, [X23]
    ADD  X23, X23, X6, ASR #0
    ST1 { V21.8H, V22.8H }, [X23]
    LD1 { V9.8H, V10.8H }, [X23]
    ADD  X23, X23, X6
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X21, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X21, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X21, X19, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X21, X19, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X21, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X21, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X21, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X21, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X21, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X21, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X21, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X21, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X21, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X21, X19, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X21, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MRS  X19, FPSR
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V0.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D0
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V1.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D1
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V2.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D2
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V3.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D3
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V4.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D4
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V5.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D5
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V6.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D6
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V7.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D7
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V8.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D8
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V9.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D9
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V10.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D10
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V11.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D11
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V12.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D12
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V13.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D13
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V14.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D14
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V15.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D15
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V16.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D16
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V17.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D17
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V18.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D18
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V19.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D19
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V20.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D20
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V21.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D21
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V22.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D22
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V23.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D23
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V24.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D24
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V25.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D25
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V26.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D26
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V27.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D27
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V28.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D28
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V29.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D29
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V30.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D30
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V31.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D31
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X23
    FMOV  D1, X21
    FMOV  V1.D[1], X20
    FMOV  D2, X22
    FMOV  V2.D[1], X17
    FMOV  D3, X22
    FMOV  V3.D[1], X29
    FMOV  D4, X14
    FMOV  V4.D[1], X4
    FMOV  D5, X19
    FMOV  V5.D[1], X29
    FMOV  D6, X9
    FMOV  V6.D[1], X6
    FMOV  D7, X4
    FMOV  V7.D[1], X14
    FMOV  D8, X10
    FMOV  V8.D[1], X21
    FMOV  D9, X11
    FMOV  V9.D[1], X2
    FMOV  D10, X21
    FMOV  V10.D[1], X11
    FMOV  D11, X2
    FMOV  V11.D[1], X5
    FMOV  D12, X7
    FMOV  V12.D[1], X11
    FMOV  D13, X11
    FMOV  V13.D[1], X4
    FMOV  D14, X13
    FMOV  V14.D[1], X14
    FMOV  D15, X13
    FMOV  V15.D[1], X18
    FMOV  D16, X10
    FMOV  V16.D[1], X23
    FMOV  D17, X2
    FMOV  V17.D[1], X3
    FMOV  D18, X16
    FMOV  V18.D[1], X17
    FMOV  D19, X6
    FMOV  V19.D[1], X11
    FMOV  D20, X16
    FMOV  V20.D[1], X19
    FMOV  D21, X15
    FMOV  V21.D[1], X2
    FMOV  D22, X11
    FMOV  V22.D[1], X29
    FMOV  D23, X8
    FMOV  V23.D[1], X18
    FMOV  D24, X12
    FMOV  V24.D[1], X21
    FMOV  D25, X23
    FMOV  V25.D[1], X20
    FMOV  D26, X16
    FMOV  V26.D[1], X13
    FMOV  D27, X18
    FMOV  V27.D[1], X4
    FMOV  D28, X21
    FMOV  V28.D[1], X22
    FMOV  D29, X14
    FMOV  V29.D[1], X21
    FMOV  D30, X4
    FMOV  V30.D[1], X15
    FMOV  D31, X12
    FMOV  V31.D[1], X4
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X13, #0x40, LSL #0
    MOVZ  X5, #0x2d00, LSL #0
    ADD  X19, X30, X5, ASR #0
    ST1 { V12.4S, V13.4S, V14.4S, V15.4S }, [X19]
    LD1 { V27.4S, V28.4S, V29.4S, V30.4S }, [X19]
    ADD  X19, X19, X13, LSR #0
    ST1 { V27.16B, V28.16B, V29.16B, V30.16B }, [X19]
    LD1 { V20.16B, V21.16B, V22.16B, V23.16B }, [X19]
    ADD  X19, X19, X13, LSR #0
    ST1 { V3.2D, V4.2D, V5.2D, V6.2D }, [X19]
    LD1 { V16.2D, V17.2D, V18.2D, V19.2D }, [X19]
    ADD  X19, X19, X13, ASR #0
    ST1 { V13.4S, V14.4S, V15.4S, V16.4S }, [X19]
    LD1 { V13.4S, V14.4S, V15.4S, V16.4S }, [X19]
    ADD  X19, X19, X13
    ST1 { V15.8H, V16.8H, V17.8H, V18.8H }, [X19]
    LD1 { V11.8H, V12.8H, V13.8H, V14.8H }, [X19]
    ADD  X19, X19, X13, LSR #0
    ST1 { V17.1D, V18.1D, V19.1D, V20.1D }, [X19]
    LD1 { V15.2S, V16.2S, V17.2S, V18.2S }, [X19]
    ADD  X19, X19, X13
    ST1 { V4.1D, V5.1D, V6.1D, V7.1D }, [X19]
    LD1 { V8.1D, V9.1D, V10.1D, V11.1D }, [X19]
    ADD  X19, X19, X13, LSR #0
    ST1 { V9.2S, V10.2S, V11.2S, V12.2S }, [X19]
    LD1 { V3.2S, V4.2S, V5.2S, V6.2S }, [X19]
    ADD  X19, X19, X13, LSR #0
    ST1 { V25.4H, V26.4H, V27.4H, V28.4H }, [X19]
    LD1 { V26.4H, V27.4H, V28.4H, V29.4H }, [X19]
    ADD  X19, X19, X13, LSR #0
    ST1 { V2.8B, V3.8B, V4.8B, V5.8B }, [X19]
    LD1 { V21.8B, V22.8B, V23.8B, V24.8B }, [X19]
    ADD  X19, X19, X13, ASR #0
    ST1 { V18.8H }, [X19]
    LD1 { V30.8H }, [X19]
    ADD  X19, X19, X13
    ST1 { V21.16B }, [X19]
    LD1 { V18.16B }, [X19]
    ADD  X19, X19, X13, LSR #0
    ST1 { V19.2D }, [X19]
    LD1 { V25.2D }, [X19]
    ADD  X19, X19, X13
    ST1 { V8.4S }, [X19]
    LD1 { V19.4S }, [X19]
    ADD  X19, X19, X13, ASR #0
    ST1 { V6.8H }, [X19]
    LD1 { V21.8H }, [X19]
    ADD  X19, X19, X13, LSR #0
    ST1 { V18.2S }, [X19]
    LD1 { V6.4H }, [X19]
    ADD  X19, X19, X13, ASR #0
    ST1 { V21.1D }, [X19]
    LD1 { V30.1D }, [X19]
    ADD  X19, X19, X13, LSR #0
    ST1 { V28.2S }, [X19]
    LD1 { V15.2S }, [X19]
    ADD  X19, X19, X13, LSR #0
    ST1 { V1.4H }, [X19]
    LD1 { V8.4H }, [X19]
    ADD  X19, X19, X13, ASR #0
    ST1 { V28.8B }, [X19]
    LD1 { V18.8B }, [X19]
    ADD  X19, X19, X13
    ST1 { V12.8H, V13.8H, V14.8H }, [X19]
    LD1 { V0.4S, V1.4S, V2.4S }, [X19]
    ADD  X19, X19, X13, LSR #0
    ST1 { V0.16B, V1.16B, V2.16B }, [X19]
    LD1 { V0.16B, V1.16B, V2.16B }, [X19]
    ADD  X19, X19, X13, ASR #0
    ST1 { V0.2D, V1.2D, V2.2D }, [X19]
    LD1 { V12.2D, V13.2D, V14.2D }, [X19]
    ADD  X19, X19, X13, ASR #0
    ST1 { V13.4S, V14.4S, V15.4S }, [X19]
    LD1 { V0.4S, V1.4S, V2.4S }, [X19]
    ADD  X19, X19, X13, ASR #0
    ST1 { V13.8H, V14.8H, V15.8H }, [X19]
    LD1 { V13.8H, V14.8H, V15.8H }, [X19]
    ADD  X19, X19, X13, ASR #0
    ST1 { V13.8B, V14.8B, V15.8B }, [X19]
    LD1 { V15.1D, V16.1D, V17.1D }, [X19]
    ADD  X19, X19, X13, ASR #0
    ST1 { V15.1D, V16.1D, V17.1D }, [X19]
    LD1 { V15.1D, V16.1D, V17.1D }, [X19]
    ADD  X19, X19, X13, ASR #0
    ST1 { V0.2S, V1.2S, V2.2S }, [X19]
    LD1 { V15.2S, V16.2S, V17.2S }, [X19]
    ADD  X19, X19, X13, ASR #0
    ST1 { V15.4H, V16.4H, V17.4H }, [X19]
    LD1 { V23.4H, V24.4H, V25.4H }, [X19]
    ADD  X19, X19, X13, LSR #0
    ST1 { V21.8B, V22.8B, V23.8B }, [X19]
    LD1 { V30.8B, V31.8B, V0.8B }, [X19]
    ADD  X19, X19, X13, ASR #0
    ST1 { V24.16B, V25.16B }, [X19]
    LD1 { V4.16B, V5.16B }, [X19]
    ADD  X19, X19, X13, ASR #0
    ST1 { V4.16B, V5.16B }, [X19]
    LD1 { V15.16B, V16.16B }, [X19]
    ADD  X19, X19, X13, LSR #0
    ST1 { V30.2D, V31.2D }, [X19]
    LD1 { V2.2D, V3.2D }, [X19]
    ADD  X19, X19, X13, LSR #0
    ST1 { V15.4S, V16.4S }, [X19]
    LD1 { V24.4S, V25.4S }, [X19]
    ADD  X19, X19, X13, LSR #0
    ST1 { V2.8H, V3.8H }, [X19]
    LD1 { V17.8H, V18.8H }, [X19]
    ADD  X19, X19, X13, ASR #0
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X4, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X4, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X4, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X4, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X4, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X4, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X4, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X4, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X4, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X4, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X4, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X4, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X4, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X4, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X4, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    MRS  X16, FPSR
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D0
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D1
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D2
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D3
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D4
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D5
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D6
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D7
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D8
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D9
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D10
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D11
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D12
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D13
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D14
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D15
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D16
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D17
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D18
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D19
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D20
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D21
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D22
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D23
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D24
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D25
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D26
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D27
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D28
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D29
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D30
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D31
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X15, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X4
    FMOV  D1, X23
    FMOV  V1.D[1], X22
    FMOV  D2, X21
    FMOV  V2.D[1], X17
    FMOV  D3, X13
    FMOV  V3.D[1], X14
    FMOV  D4, X18
    FMOV  V4.D[1], X17
    FMOV  D5, X19
    FMOV  V5.D[1], X5
    FMOV  D6, X5
    FMOV  V6.D[1], X2
    FMOV  D7, X20
    FMOV  V7.D[1], X6
    FMOV  D8, X11
    FMOV  V8.D[1], X29
    FMOV  D9, X20
    FMOV  V9.D[1], X6
    FMOV  D10, X7
    FMOV  V10.D[1], X7
    FMOV  D11, X22
    FMOV  V11.D[1], X2
    FMOV  D12, X19
    FMOV  V12.D[1], X21
    FMOV  D13, X16
    FMOV  V13.D[1], X23
    FMOV  D14, X12
    FMOV  V14.D[1], X2
    FMOV  D15, X22
    FMOV  V15.D[1], X22
    FMOV  D16, X7
    FMOV  V16.D[1], X9
    FMOV  D17, X15
    FMOV  V17.D[1], X14
    FMOV  D18, X23
    FMOV  V18.D[1], X19
    FMOV  D19, X20
    FMOV  V19.D[1], X2
    FMOV  D20, X19
    FMOV  V20.D[1], X7
    FMOV  D21, X2
    FMOV  V21.D[1], X10
    FMOV  D22, X13
    FMOV  V22.D[1], X8
    FMOV  D23, X6
    FMOV  V23.D[1], X17
    FMOV  D24, X3
    FMOV  V24.D[1], X22
    FMOV  D25, X9
    FMOV  V25.D[1], X3
    FMOV  D26, X18
    FMOV  V26.D[1], X16
    FMOV  D27, X6
    FMOV  V27.D[1], X11
    FMOV  D28, X16
    FMOV  V28.D[1], X20
    FMOV  D29, X23
    FMOV  V29.D[1], X19
    FMOV  D30, X11
    FMOV  V30.D[1], X21
    FMOV  D31, X17
    FMOV  V31.D[1], X3
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X10, #0x40, LSL #0
    MOVZ  X16, #0x0, LSL #0
    ADD  X18, X30, X16
    ST1 { V12.16B, V13.16B, V14.16B, V15.16B }, [X18]
    LD1 { V15.16B, V16.16B, V17.16B, V18.16B }, [X18]
    ADD  X18, X18, X10, ASR #0
    ST1 { V20.16B, V21.16B, V22.16B, V23.16B }, [X18]
    LD1 { V3.16B, V4.16B, V5.16B, V6.16B }, [X18]
    ADD  X18, X18, X10, LSR #0
    ST1 { V27.2D, V28.2D, V29.2D, V30.2D }, [X18]
    LD1 { V22.2D, V23.2D, V24.2D, V25.2D }, [X18]
    ADD  X18, X18, X10, LSR #0
    ST1 { V15.4S, V16.4S, V17.4S, V18.4S }, [X18]
    LD1 { V7.4S, V8.4S, V9.4S, V10.4S }, [X18]
    ADD  X18, X18, X10, LSR #0
    ST1 { V23.8H, V24.8H, V25.8H, V26.8H }, [X18]
    LD1 { V13.8H, V14.8H, V15.8H, V16.8H }, [X18]
    ADD  X18, X18, X10
    ST1 { V4.1D, V5.1D, V6.1D, V7.1D }, [X18]
    LD1 { V27.4H, V28.4H, V29.4H, V30.4H }, [X18]
    ADD  X18, X18, X10
    ST1 { V1.1D, V2.1D, V3.1D, V4.1D }, [X18]
    LD1 { V4.1D, V5.1D, V6.1D, V7.1D }, [X18]
    ADD  X18, X18, X10, ASR #0
    ST1 { V15.2S, V16.2S, V17.2S, V18.2S }, [X18]
    LD1 { V15.2S, V16.2S, V17.2S, V18.2S }, [X18]
    ADD  X18, X18, X10, LSR #0
    ST1 { V18.4H, V19.4H, V20.4H, V21.4H }, [X18]
    LD1 { V18.4H, V19.4H, V20.4H, V21.4H }, [X18]
    ADD  X18, X18, X10, ASR #0
    ST1 { V13.8B, V14.8B, V15.8B, V16.8B }, [X18]
    LD1 { V13.8B, V14.8B, V15.8B, V16.8B }, [X18]
    ADD  X18, X18, X10, LSR #0
    ST1 { V22.4S }, [X18]
    LD1 { V19.8H }, [X18]
    ADD  X18, X18, X10
    ST1 { V22.16B }, [X18]
    LD1 { V11.16B }, [X18]
    ADD  X18, X18, X10, LSR #0
    ST1 { V11.2D }, [X18]
    LD1 { V11.2D }, [X18]
    ADD  X18, X18, X10, LSR #0
    ST1 { V7.4S }, [X18]
    LD1 { V22.4S }, [X18]
    ADD  X18, X18, X10
    ST1 { V14.8H }, [X18]
    LD1 { V30.8H }, [X18]
    ADD  X18, X18, X10
    ST1 { V30.4H }, [X18]
    LD1 { V30.2S }, [X18]
    ADD  X18, X18, X10
    ST1 { V7.1D }, [X18]
    LD1 { V7.1D }, [X18]
    ADD  X18, X18, X10, LSR #0
    ST1 { V11.2S }, [X18]
    LD1 { V24.2S }, [X18]
    ADD  X18, X18, X10
    ST1 { V24.4H }, [X18]
    LD1 { V0.4H }, [X18]
    ADD  X18, X18, X10
    ST1 { V30.8B }, [X18]
    LD1 { V9.8B }, [X18]
    ADD  X18, X18, X10, LSR #0
    ST1 { V19.4S, V20.4S, V21.4S }, [X18]
    LD1 { V24.8H, V25.8H, V26.8H }, [X18]
    ADD  X18, X18, X10, ASR #0
    ST1 { V7.16B, V8.16B, V9.16B }, [X18]
    LD1 { V13.16B, V14.16B, V15.16B }, [X18]
    ADD  X18, X18, X10, ASR #0
    ST1 { V20.2D, V21.2D, V22.2D }, [X18]
    LD1 { V14.2D, V15.2D, V16.2D }, [X18]
    ADD  X18, X18, X10, LSR #0
    ST1 { V14.4S, V15.4S, V16.4S }, [X18]
    LD1 { V9.4S, V10.4S, V11.4S }, [X18]
    ADD  X18, X18, X10, ASR #0
    ST1 { V14.8H, V15.8H, V16.8H }, [X18]
    LD1 { V24.8H, V25.8H, V26.8H }, [X18]
    ADD  X18, X18, X10, ASR #0
    ST1 { V21.2S, V22.2S, V23.2S }, [X18]
    LD1 { V12.4H, V13.4H, V14.4H }, [X18]
    ADD  X18, X18, X10, LSR #0
    ST1 { V12.1D, V13.1D, V14.1D }, [X18]
    LD1 { V3.1D, V4.1D, V5.1D }, [X18]
    ADD  X18, X18, X10, LSR #0
    ST1 { V8.2S, V9.2S, V10.2S }, [X18]
    LD1 { V21.2S, V22.2S, V23.2S }, [X18]
    ADD  X18, X18, X10
    ST1 { V20.4H, V21.4H, V22.4H }, [X18]
    LD1 { V18.4H, V19.4H, V20.4H }, [X18]
    ADD  X18, X18, X10, LSR #0
    ST1 { V3.8B, V4.8B, V5.8B }, [X18]
    LD1 { V12.8B, V13.8B, V14.8B }, [X18]
    ADD  X18, X18, X10, LSR #0
    ST1 { V12.8H, V13.8H }, [X18]
    LD1 { V19.2D, V20.2D }, [X18]
    ADD  X18, X18, X10
    ST1 { V25.16B, V26.16B }, [X18]
    LD1 { V4.16B, V5.16B }, [X18]
    ADD  X18, X18, X10
    ST1 { V18.2D, V19.2D }, [X18]
    LD1 { V18.2D, V19.2D }, [X18]
    ADD  X18, X18, X10, ASR #0
    ST1 { V18.4S, V19.4S }, [X18]
    LD1 { V8.4S, V9.4S }, [X18]
    ADD  X18, X18, X10, ASR #0
    ST1 { V4.8H, V5.8H }, [X18]
    LD1 { V4.8H, V5.8H }, [X18]
    ADD  X18, X18, X10, LSR #0
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MRS  X29, FPSR
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V0.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D0
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V1.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D1
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D2
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V3.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D3
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V4.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D4
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V5.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D5
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V6.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D6
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D7
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V8.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D8
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V9.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D9
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V10.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D10
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V11.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D11
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V12.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D12
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V13.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D13
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D14
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V15.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D15
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V16.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D16
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D17
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V18.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D18
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V19.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D19
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D20
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D21
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V22.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D22
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D23
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D24
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V25.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D25
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V26.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D26
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D27
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D28
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V29.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D29
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V30.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D30
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, V31.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
    FMOV  X29, D31
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X3, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X5
    FMOV  D1, X11
    FMOV  V1.D[1], X22
    FMOV  D2, X19
    FMOV  V2.D[1], X23
    FMOV  D3, X21
    FMOV  V3.D[1], X29
    FMOV  D4, X15
    FMOV  V4.D[1], X17
    FMOV  D5, X18
    FMOV  V5.D[1], X5
    FMOV  D6, X29
    FMOV  V6.D[1], X23
    FMOV  D7, X21
    FMOV  V7.D[1], X3
    FMOV  D8, X18
    FMOV  V8.D[1], X17
    FMOV  D9, X16
    FMOV  V9.D[1], X9
    FMOV  D10, X4
    FMOV  V10.D[1], X18
    FMOV  D11, X19
    FMOV  V11.D[1], X5
    FMOV  D12, X22
    FMOV  V12.D[1], X10
    FMOV  D13, X3
    FMOV  V13.D[1], X12
    FMOV  D14, X6
    FMOV  V14.D[1], X16
    FMOV  D15, X19
    FMOV  V15.D[1], X7
    FMOV  D16, X17
    FMOV  V16.D[1], X4
    FMOV  D17, X10
    FMOV  V17.D[1], X22
    FMOV  D18, X13
    FMOV  V18.D[1], X8
    FMOV  D19, X13
    FMOV  V19.D[1], X29
    FMOV  D20, X20
    FMOV  V20.D[1], X17
    FMOV  D21, X17
    FMOV  V21.D[1], X21
    FMOV  D22, X21
    FMOV  V22.D[1], X20
    FMOV  D23, X22
    FMOV  V23.D[1], X12
    FMOV  D24, X12
    FMOV  V24.D[1], X18
    FMOV  D25, X2
    FMOV  V25.D[1], X4
    FMOV  D26, X16
    FMOV  V26.D[1], X19
    FMOV  D27, X13
    FMOV  V27.D[1], X4
    FMOV  D28, X18
    FMOV  V28.D[1], X18
    FMOV  D29, X21
    FMOV  V29.D[1], X4
    FMOV  D30, X22
    FMOV  V30.D[1], X7
    FMOV  D31, X8
    FMOV  V31.D[1], X15
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X15, #0x40, LSL #0
    MOVZ  X12, #0x500, LSL #0
    ADD  X19, X30, X12, LSR #0
    ST1 { V26.8H, V27.8H, V28.8H, V29.8H }, [X19]
    LD1 { V28.4S, V29.4S, V30.4S, V31.4S }, [X19]
    ADD  X19, X19, X15, ASR #0
    ST1 { V6.16B, V7.16B, V8.16B, V9.16B }, [X19]
    LD1 { V1.16B, V2.16B, V3.16B, V4.16B }, [X19]
    ADD  X19, X19, X15, LSR #0
    ST1 { V28.2D, V29.2D, V30.2D, V31.2D }, [X19]
    LD1 { V15.2D, V16.2D, V17.2D, V18.2D }, [X19]
    ADD  X19, X19, X15
    ST1 { V14.4S, V15.4S, V16.4S, V17.4S }, [X19]
    LD1 { V6.4S, V7.4S, V8.4S, V9.4S }, [X19]
    ADD  X19, X19, X15, LSR #0
    ST1 { V6.8H, V7.8H, V8.8H, V9.8H }, [X19]
    LD1 { V16.8H, V17.8H, V18.8H, V19.8H }, [X19]
    ADD  X19, X19, X15, ASR #0
    ST1 { V16.8B, V17.8B, V18.8B, V19.8B }, [X19]
    LD1 { V30.2S, V31.2S, V0.2S, V1.2S }, [X19]
    ADD  X19, X19, X15, LSR #0
    ST1 { V10.1D, V11.1D, V12.1D, V13.1D }, [X19]
    LD1 { V13.1D, V14.1D, V15.1D, V16.1D }, [X19]
    ADD  X19, X19, X15
    ST1 { V17.2S, V18.2S, V19.2S, V20.2S }, [X19]
    LD1 { V8.2S, V9.2S, V10.2S, V11.2S }, [X19]
    ADD  X19, X19, X15
    ST1 { V30.4H, V31.4H, V0.4H, V1.4H }, [X19]
    LD1 { V20.4H, V21.4H, V22.4H, V23.4H }, [X19]
    ADD  X19, X19, X15, ASR #0
    ST1 { V22.8B, V23.8B, V24.8B, V25.8B }, [X19]
    LD1 { V22.8B, V23.8B, V24.8B, V25.8B }, [X19]
    ADD  X19, X19, X15, ASR #0
    ST1 { V16.8H }, [X19]
    LD1 { V23.8H }, [X19]
    ADD  X19, X19, X15, LSR #0
    ST1 { V8.16B }, [X19]
    LD1 { V31.16B }, [X19]
    ADD  X19, X19, X15
    ST1 { V15.2D }, [X19]
    LD1 { V12.2D }, [X19]
    ADD  X19, X19, X15, LSR #0
    ST1 { V28.4S }, [X19]
    LD1 { V7.4S }, [X19]
    ADD  X19, X19, X15
    ST1 { V20.8H }, [X19]
    LD1 { V27.8H }, [X19]
    ADD  X19, X19, X15
    ST1 { V14.1D }, [X19]
    LD1 { V20.8B }, [X19]
    ADD  X19, X19, X15
    ST1 { V23.1D }, [X19]
    LD1 { V15.1D }, [X19]
    ADD  X19, X19, X15, LSR #0
    ST1 { V31.2S }, [X19]
    LD1 { V31.2S }, [X19]
    ADD  X19, X19, X15
    ST1 { V15.4H }, [X19]
    LD1 { V28.4H }, [X19]
    ADD  X19, X19, X15
    ST1 { V10.8B }, [X19]
    LD1 { V11.8B }, [X19]
    ADD  X19, X19, X15
    ST1 { V25.4S, V26.4S, V27.4S }, [X19]
    LD1 { V25.4S, V26.4S, V27.4S }, [X19]
    ADD  X19, X19, X15, LSR #0
    ST1 { V29.16B, V30.16B, V31.16B }, [X19]
    LD1 { V29.16B, V30.16B, V31.16B }, [X19]
    ADD  X19, X19, X15, LSR #0
    ST1 { V25.2D, V26.2D, V27.2D }, [X19]
    LD1 { V25.2D, V26.2D, V27.2D }, [X19]
    ADD  X19, X19, X15, ASR #0
    ST1 { V25.4S, V26.4S, V27.4S }, [X19]
    LD1 { V2.4S, V3.4S, V4.4S }, [X19]
    ADD  X19, X19, X15
    ST1 { V13.8H, V14.8H, V15.8H }, [X19]
    LD1 { V5.8H, V6.8H, V7.8H }, [X19]
    ADD  X19, X19, X15, LSR #0
    ST1 { V2.4H, V3.4H, V4.4H }, [X19]
    LD1 { V13.8B, V14.8B, V15.8B }, [X19]
    ADD  X19, X19, X15, LSR #0
    ST1 { V29.1D, V30.1D, V31.1D }, [X19]
    LD1 { V29.1D, V30.1D, V31.1D }, [X19]
    ADD  X19, X19, X15, ASR #0
    ST1 { V5.2S, V6.2S, V7.2S }, [X19]
    LD1 { V5.2S, V6.2S, V7.2S }, [X19]
    ADD  X19, X19, X15
    ST1 { V9.4H, V10.4H, V11.4H }, [X19]
    LD1 { V31.4H, V0.4H, V1.4H }, [X19]
    ADD  X19, X19, X15, LSR #0
    ST1 { V8.8B, V9.8B, V10.8B }, [X19]
    LD1 { V8.8B, V9.8B, V10.8B }, [X19]
    ADD  X19, X19, X15, LSR #0
    ST1 { V14.8H, V15.8H }, [X19]
    LD1 { V28.4S, V29.4S }, [X19]
    ADD  X19, X19, X15
    ST1 { V19.16B, V20.16B }, [X19]
    LD1 { V1.16B, V2.16B }, [X19]
    ADD  X19, X19, X15, ASR #0
    ST1 { V20.2D, V21.2D }, [X19]
    LD1 { V20.2D, V21.2D }, [X19]
    ADD  X19, X19, X15, ASR #0
    ST1 { V29.4S, V30.4S }, [X19]
    LD1 { V14.4S, V15.4S }, [X19]
    ADD  X19, X19, X15, LSR #0
    ST1 { V26.8H, V27.8H }, [X19]
    LD1 { V29.8H, V30.8H }, [X19]
    ADD  X19, X19, X15, LSR #0
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X18, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X18, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X18, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X18, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X18, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X18, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X18, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X18, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X18, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X18, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X18, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X18, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X18, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X18, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MRS  X23, FPSR
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V0.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D0
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V1.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D1
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D2
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D3
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D4
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D5
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D6
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D7
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D8
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D9
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D10
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D11
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D12
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D13
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D14
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D15
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D16
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D17
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D18
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D19
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D20
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D21
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D22
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V23.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D23
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D24
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D25
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D26
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D27
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D28
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D29
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V30.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D30
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, V31.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    FMOV  X23, D31
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X11, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X12
    FMOV  V0.D[1], X20
    FMOV  D1, X23
    FMOV  V1.D[1], X17
    FMOV  D2, X21
    FMOV  V2.D[1], X8
    FMOV  D3, X5
    FMOV  V3.D[1], X22
    FMOV  D4, X6
    FMOV  V4.D[1], X21
    FMOV  D5, X21
    FMOV  V5.D[1], X9
    FMOV  D6, X9
    FMOV  V6.D[1], X3
    FMOV  D7, X12
    FMOV  V7.D[1], X14
    FMOV  D8, X5
    FMOV  V8.D[1], X5
    FMOV  D9, X11
    FMOV  V9.D[1], X16
    FMOV  D10, X6
    FMOV  V10.D[1], X5
    FMOV  D11, X29
    FMOV  V11.D[1], X3
    FMOV  D12, X6
    FMOV  V12.D[1], X2
    FMOV  D13, X5
    FMOV  V13.D[1], X16
    FMOV  D14, X3
    FMOV  V14.D[1], X8
    FMOV  D15, X18
    FMOV  V15.D[1], X5
    FMOV  D16, X14
    FMOV  V16.D[1], X4
    FMOV  D17, X20
    FMOV  V17.D[1], X13
    FMOV  D18, X9
    FMOV  V18.D[1], X2
    FMOV  D19, X4
    FMOV  V19.D[1], X14
    FMOV  D20, X4
    FMOV  V20.D[1], X18
    FMOV  D21, X29
    FMOV  V21.D[1], X19
    FMOV  D22, X14
    FMOV  V22.D[1], X3
    FMOV  D23, X3
    FMOV  V23.D[1], X12
    FMOV  D24, X29
    FMOV  V24.D[1], X19
    FMOV  D25, X23
    FMOV  V25.D[1], X14
    FMOV  D26, X6
    FMOV  V26.D[1], X7
    FMOV  D27, X23
    FMOV  V27.D[1], X20
    FMOV  D28, X20
    FMOV  V28.D[1], X8
    FMOV  D29, X2
    FMOV  V29.D[1], X17
    FMOV  D30, X22
    FMOV  V30.D[1], X20
    FMOV  D31, X14
    FMOV  V31.D[1], X15
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X9, #0x40, LSL #0
    MOVZ  X7, #0xa00, LSL #0
    ADD  X16, X30, X7, LSR #0
    ST1 { V25.4S, V26.4S, V27.4S, V28.4S }, [X16]
    LD1 { V28.16B, V29.16B, V30.16B, V31.16B }, [X16]
    ADD  X16, X16, X9
    ST1 { V28.16B, V29.16B, V30.16B, V31.16B }, [X16]
    LD1 { V22.16B, V23.16B, V24.16B, V25.16B }, [X16]
    ADD  X16, X16, X9, ASR #0
    ST1 { V22.2D, V23.2D, V24.2D, V25.2D }, [X16]
    LD1 { V25.2D, V26.2D, V27.2D, V28.2D }, [X16]
    ADD  X16, X16, X9
    ST1 { V19.4S, V20.4S, V21.4S, V22.4S }, [X16]
    LD1 { V2.4S, V3.4S, V4.4S, V5.4S }, [X16]
    ADD  X16, X16, X9, ASR #0
    ST1 { V26.8H, V27.8H, V28.8H, V29.8H }, [X16]
    LD1 { V22.8H, V23.8H, V24.8H, V25.8H }, [X16]
    ADD  X16, X16, X9
    ST1 { V2.8B, V3.8B, V4.8B, V5.8B }, [X16]
    LD1 { V3.4H, V4.4H, V5.4H, V6.4H }, [X16]
    ADD  X16, X16, X9, LSR #0
    ST1 { V3.1D, V4.1D, V5.1D, V6.1D }, [X16]
    LD1 { V30.1D, V31.1D, V0.1D, V1.1D }, [X16]
    ADD  X16, X16, X9, ASR #0
    ST1 { V22.2S, V23.2S, V24.2S, V25.2S }, [X16]
    LD1 { V2.2S, V3.2S, V4.2S, V5.2S }, [X16]
    ADD  X16, X16, X9, LSR #0
    ST1 { V30.4H, V31.4H, V0.4H, V1.4H }, [X16]
    LD1 { V17.4H, V18.4H, V19.4H, V20.4H }, [X16]
    ADD  X16, X16, X9, ASR #0
    ST1 { V31.8B, V0.8B, V1.8B, V2.8B }, [X16]
    LD1 { V15.8B, V16.8B, V17.8B, V18.8B }, [X16]
    ADD  X16, X16, X9
    ST1 { V16.4S }, [X16]
    LD1 { V31.4S }, [X16]
    ADD  X16, X16, X9
    ST1 { V29.16B }, [X16]
    LD1 { V21.16B }, [X16]
    ADD  X16, X16, X9, LSR #0
    ST1 { V17.2D }, [X16]
    LD1 { V27.2D }, [X16]
    ADD  X16, X16, X9, ASR #0
    ST1 { V24.4S }, [X16]
    LD1 { V17.4S }, [X16]
    ADD  X16, X16, X9
    ST1 { V3.8H }, [X16]
    LD1 { V23.8H }, [X16]
    ADD  X16, X16, X9, LSR #0
    ST1 { V5.2S }, [X16]
    LD1 { V16.1D }, [X16]
    ADD  X16, X16, X9
    ST1 { V17.1D }, [X16]
    LD1 { V27.1D }, [X16]
    ADD  X16, X16, X9, ASR #0
    ST1 { V27.2S }, [X16]
    LD1 { V27.2S }, [X16]
    ADD  X16, X16, X9, LSR #0
    ST1 { V16.4H }, [X16]
    LD1 { V24.4H }, [X16]
    ADD  X16, X16, X9
    ST1 { V27.8B }, [X16]
    LD1 { V17.8B }, [X16]
    ADD  X16, X16, X9
    ST1 { V12.4S, V13.4S, V14.4S }, [X16]
    LD1 { V28.16B, V29.16B, V30.16B }, [X16]
    ADD  X16, X16, X9, ASR #0
    ST1 { V2.16B, V3.16B, V4.16B }, [X16]
    LD1 { V15.16B, V16.16B, V17.16B }, [X16]
    ADD  X16, X16, X9, LSR #0
    ST1 { V15.2D, V16.2D, V17.2D }, [X16]
    LD1 { V2.2D, V3.2D, V4.2D }, [X16]
    ADD  X16, X16, X9
    ST1 { V3.4S, V4.4S, V5.4S }, [X16]
    LD1 { V3.4S, V4.4S, V5.4S }, [X16]
    ADD  X16, X16, X9
    ST1 { V3.8H, V4.8H, V5.8H }, [X16]
    LD1 { V15.8H, V16.8H, V17.8H }, [X16]
    ADD  X16, X16, X9, LSR #0
    ST1 { V28.2S, V29.2S, V30.2S }, [X16]
    LD1 { V31.2S, V0.2S, V1.2S }, [X16]
    ADD  X16, X16, X9
    ST1 { V31.1D, V0.1D, V1.1D }, [X16]
    LD1 { V1.1D, V2.1D, V3.1D }, [X16]
    ADD  X16, X16, X9, LSR #0
    ST1 { V15.2S, V16.2S, V17.2S }, [X16]
    LD1 { V15.2S, V16.2S, V17.2S }, [X16]
    ADD  X16, X16, X9, ASR #0
    ST1 { V1.4H, V2.4H, V3.4H }, [X16]
    LD1 { V1.4H, V2.4H, V3.4H }, [X16]
    ADD  X16, X16, X9
    ST1 { V3.8B, V4.8B, V5.8B }, [X16]
    LD1 { V21.8B, V22.8B, V23.8B }, [X16]
    ADD  X16, X16, X9, ASR #0
    ST1 { V16.16B, V17.16B }, [X16]
    LD1 { V3.16B, V4.16B }, [X16]
    ADD  X16, X16, X9
    ST1 { V24.16B, V25.16B }, [X16]
    LD1 { V9.16B, V10.16B }, [X16]
    ADD  X16, X16, X9
    ST1 { V12.2D, V13.2D }, [X16]
    LD1 { V16.2D, V17.2D }, [X16]
    ADD  X16, X16, X9
    ST1 { V1.4S, V2.4S }, [X16]
    LD1 { V23.4S, V24.4S }, [X16]
    ADD  X16, X16, X9, LSR #0
    ST1 { V18.8H, V19.8H }, [X16]
    LD1 { V7.8H, V8.8H }, [X16]
    ADD  X16, X16, X9, ASR #0
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MRS  X2, FPSR
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V0.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D0
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V1.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D1
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V2.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D2
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D3
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D4
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D5
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V6.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D6
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D7
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D8
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D9
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D10
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D11
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V12.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D12
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D13
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D14
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V15.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D15
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D16
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D17
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D18
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D19
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D20
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D21
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D22
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D23
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D24
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D25
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D26
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D27
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D28
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D29
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V30.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D30
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, V31.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X2, D31
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X5, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X5
    FMOV  D1, X4
    FMOV  V1.D[1], X21
    FMOV  D2, X22
    FMOV  V2.D[1], X29
    FMOV  D3, X12
    FMOV  V3.D[1], X14
    FMOV  D4, X15
    FMOV  V4.D[1], X21
    FMOV  D5, X3
    FMOV  V5.D[1], X16
    FMOV  D6, X8
    FMOV  V6.D[1], X19
    FMOV  D7, X16
    FMOV  V7.D[1], X23
    FMOV  D8, X16
    FMOV  V8.D[1], X8
    FMOV  D9, X9
    FMOV  V9.D[1], X29
    FMOV  D10, X6
    FMOV  V10.D[1], X18
    FMOV  D11, X4
    FMOV  V11.D[1], X20
    FMOV  D12, X11
    FMOV  V12.D[1], X8
    FMOV  D13, X9
    FMOV  V13.D[1], X14
    FMOV  D14, X15
    FMOV  V14.D[1], X22
    FMOV  D15, X7
    FMOV  V15.D[1], X18
    FMOV  D16, X13
    FMOV  V16.D[1], X9
    FMOV  D17, X15
    FMOV  V17.D[1], X20
    FMOV  D18, X7
    FMOV  V18.D[1], X14
    FMOV  D19, X16
    FMOV  V19.D[1], X11
    FMOV  D20, X16
    FMOV  V20.D[1], X18
    FMOV  D21, X22
    FMOV  V21.D[1], X16
    FMOV  D22, X3
    FMOV  V22.D[1], X7
    FMOV  D23, X2
    FMOV  V23.D[1], X5
    FMOV  D24, X11
    FMOV  V24.D[1], X7
    FMOV  D25, X3
    FMOV  V25.D[1], X6
    FMOV  D26, X20
    FMOV  V26.D[1], X7
    FMOV  D27, X17
    FMOV  V27.D[1], X8
    FMOV  D28, X5
    FMOV  V28.D[1], X5
    FMOV  D29, X15
    FMOV  V29.D[1], X3
    FMOV  D30, X7
    FMOV  V30.D[1], X18
    FMOV  D31, X13
    FMOV  V31.D[1], X14
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X5, #0x40, LSL #0
    MOVZ  X4, #0xf00, LSL #0
    ADD  X10, X30, X4
    ST1 { V26.2D, V27.2D, V28.2D, V29.2D }, [X10]
    LD1 { V21.8H, V22.8H, V23.8H, V24.8H }, [X10]
    ADD  X10, X10, X5, LSR #0
    ST1 { V22.16B, V23.16B, V24.16B, V25.16B }, [X10]
    LD1 { V15.16B, V16.16B, V17.16B, V18.16B }, [X10]
    ADD  X10, X10, X5
    ST1 { V15.2D, V16.2D, V17.2D, V18.2D }, [X10]
    LD1 { V23.2D, V24.2D, V25.2D, V26.2D }, [X10]
    ADD  X10, X10, X5
    ST1 { V23.4S, V24.4S, V25.4S, V26.4S }, [X10]
    LD1 { V3.4S, V4.4S, V5.4S, V6.4S }, [X10]
    ADD  X10, X10, X5
    ST1 { V23.8H, V24.8H, V25.8H, V26.8H }, [X10]
    LD1 { V8.8H, V9.8H, V10.8H, V11.8H }, [X10]
    ADD  X10, X10, X5, ASR #0
    ST1 { V3.4H, V4.4H, V5.4H, V6.4H }, [X10]
    LD1 { V23.2S, V24.2S, V25.2S, V26.2S }, [X10]
    ADD  X10, X10, X5
    ST1 { V29.1D, V30.1D, V31.1D, V0.1D }, [X10]
    LD1 { V29.1D, V30.1D, V31.1D, V0.1D }, [X10]
    ADD  X10, X10, X5, ASR #0
    ST1 { V29.2S, V30.2S, V31.2S, V0.2S }, [X10]
    LD1 { V15.2S, V16.2S, V17.2S, V18.2S }, [X10]
    ADD  X10, X10, X5
    ST1 { V8.4H, V9.4H, V10.4H, V11.4H }, [X10]
    LD1 { V8.4H, V9.4H, V10.4H, V11.4H }, [X10]
    ADD  X10, X10, X5, ASR #0
    ST1 { V13.8B, V14.8B, V15.8B, V16.8B }, [X10]
    LD1 { V15.8B, V16.8B, V17.8B, V18.8B }, [X10]
    ADD  X10, X10, X5, ASR #0
    ST1 { V16.4S }, [X10]
    LD1 { V27.2D }, [X10]
    ADD  X10, X10, X5, ASR #0
    ST1 { V8.16B }, [X10]
    LD1 { V27.16B }, [X10]
    ADD  X10, X10, X5
    ST1 { V24.2D }, [X10]
    LD1 { V16.2D }, [X10]
    ADD  X10, X10, X5, LSR #0
    ST1 { V25.4S }, [X10]
    LD1 { V25.4S }, [X10]
    ADD  X10, X10, X5, LSR #0
    ST1 { V10.8H }, [X10]
    LD1 { V11.8H }, [X10]
    ADD  X10, X10, X5, LSR #0
    ST1 { V11.2S }, [X10]
    LD1 { V11.8B }, [X10]
    ADD  X10, X10, X5, LSR #0
    ST1 { V25.1D }, [X10]
    LD1 { V9.1D }, [X10]
    ADD  X10, X10, X5
    ST1 { V8.2S }, [X10]
    LD1 { V13.2S }, [X10]
    ADD  X10, X10, X5, ASR #0
    ST1 { V11.4H }, [X10]
    LD1 { V10.4H }, [X10]
    ADD  X10, X10, X5, LSR #0
    ST1 { V1.8B }, [X10]
    LD1 { V8.8B }, [X10]
    ADD  X10, X10, X5
    ST1 { V17.16B, V18.16B, V19.16B }, [X10]
    LD1 { V17.2D, V18.2D, V19.2D }, [X10]
    ADD  X10, X10, X5, LSR #0
    ST1 { V8.16B, V9.16B, V10.16B }, [X10]
    LD1 { V9.16B, V10.16B, V11.16B }, [X10]
    ADD  X10, X10, X5, ASR #0
    ST1 { V9.2D, V10.2D, V11.2D }, [X10]
    LD1 { V21.2D, V22.2D, V23.2D }, [X10]
    ADD  X10, X10, X5, LSR #0
    ST1 { V21.4S, V22.4S, V23.4S }, [X10]
    LD1 { V9.4S, V10.4S, V11.4S }, [X10]
    ADD  X10, X10, X5
    ST1 { V17.8H, V18.8H, V19.8H }, [X10]
    LD1 { V31.8H, V0.8H, V1.8H }, [X10]
    ADD  X10, X10, X5, LSR #0
    ST1 { V31.2S, V0.2S, V1.2S }, [X10]
    LD1 { V21.2S, V22.2S, V23.2S }, [X10]
    ADD  X10, X10, X5, ASR #0
    ST1 { V9.1D, V10.1D, V11.1D }, [X10]
    LD1 { V20.1D, V21.1D, V22.1D }, [X10]
    ADD  X10, X10, X5
    ST1 { V21.2S, V22.2S, V23.2S }, [X10]
    LD1 { V31.2S, V0.2S, V1.2S }, [X10]
    ADD  X10, X10, X5, ASR #0
    ST1 { V8.4H, V9.4H, V10.4H }, [X10]
    LD1 { V9.4H, V10.4H, V11.4H }, [X10]
    ADD  X10, X10, X5, LSR #0
    ST1 { V16.8B, V17.8B, V18.8B }, [X10]
    LD1 { V17.8B, V18.8B, V19.8B }, [X10]
    ADD  X10, X10, X5
    ST1 { V0.16B, V1.16B }, [X10]
    LD1 { V21.4S, V22.4S }, [X10]
    ADD  X10, X10, X5
    ST1 { V9.16B, V10.16B }, [X10]
    LD1 { V6.16B, V7.16B }, [X10]
    ADD  X10, X10, X5, LSR #0
    ST1 { V9.2D, V10.2D }, [X10]
    LD1 { V29.2D, V30.2D }, [X10]
    ADD  X10, X10, X5, LSR #0
    ST1 { V30.4S, V31.4S }, [X10]
    LD1 { V8.4S, V9.4S }, [X10]
    ADD  X10, X10, X5
    ST1 { V8.8H, V9.8H }, [X10]
    LD1 { V8.8H, V9.8H }, [X10]
    ADD  X10, X10, X5, LSR #0
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MRS  X16, FPSR
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D0
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D1
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D2
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D3
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D4
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D5
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D6
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D7
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D8
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D9
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D10
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D11
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D12
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D13
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D14
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D15
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D16
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D17
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D18
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D19
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D20
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D21
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D22
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D23
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D24
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D25
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D26
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D27
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D28
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D29
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D30
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D31
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X22
    FMOV  D1, X9
    FMOV  V1.D[1], X20
    FMOV  D2, X13
    FMOV  V2.D[1], X9
    FMOV  D3, X17
    FMOV  V3.D[1], X21
    FMOV  D4, X21
    FMOV  V4.D[1], X23
    FMOV  D5, X10
    FMOV  V5.D[1], X17
    FMOV  D6, X19
    FMOV  V6.D[1], X3
    FMOV  D7, X14
    FMOV  V7.D[1], X6
    FMOV  D8, X13
    FMOV  V8.D[1], X3
    FMOV  D9, X17
    FMOV  V9.D[1], X16
    FMOV  D10, X6
    FMOV  V10.D[1], X16
    FMOV  D11, X12
    FMOV  V11.D[1], X6
    FMOV  D12, X9
    FMOV  V12.D[1], X29
    FMOV  D13, X23
    FMOV  V13.D[1], X5
    FMOV  D14, X12
    FMOV  V14.D[1], X18
    FMOV  D15, X4
    FMOV  V15.D[1], X21
    FMOV  D16, X23
    FMOV  V16.D[1], X9
    FMOV  D17, X19
    FMOV  V17.D[1], X18
    FMOV  D18, X23
    FMOV  V18.D[1], X2
    FMOV  D19, X23
    FMOV  V19.D[1], X20
    FMOV  D20, X16
    FMOV  V20.D[1], X4
    FMOV  D21, X7
    FMOV  V21.D[1], X13
    FMOV  D22, X29
    FMOV  V22.D[1], X8
    FMOV  D23, X12
    FMOV  V23.D[1], X29
    FMOV  D24, X17
    FMOV  V24.D[1], X14
    FMOV  D25, X9
    FMOV  V25.D[1], X11
    FMOV  D26, X8
    FMOV  V26.D[1], X17
    FMOV  D27, X23
    FMOV  V27.D[1], X13
    FMOV  D28, X13
    FMOV  V28.D[1], X12
    FMOV  D29, X9
    FMOV  V29.D[1], X15
    FMOV  D30, X21
    FMOV  V30.D[1], X23
    FMOV  D31, X16
    FMOV  V31.D[1], X14
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X10, #0x40, LSL #0
    MOVZ  X12, #0x1400, LSL #0
    ADD  X4, X30, X12, ASR #0
    ST1 { V28.16B, V29.16B, V30.16B, V31.16B }, [X4]
    LD1 { V5.16B, V6.16B, V7.16B, V8.16B }, [X4]
    ADD  X4, X4, X10, LSR #0
    ST1 { V20.16B, V21.16B, V22.16B, V23.16B }, [X4]
    LD1 { V21.16B, V22.16B, V23.16B, V24.16B }, [X4]
    ADD  X4, X4, X10
    ST1 { V11.2D, V12.2D, V13.2D, V14.2D }, [X4]
    LD1 { V8.2D, V9.2D, V10.2D, V11.2D }, [X4]
    ADD  X4, X4, X10
    ST1 { V25.4S, V26.4S, V27.4S, V28.4S }, [X4]
    LD1 { V12.4S, V13.4S, V14.4S, V15.4S }, [X4]
    ADD  X4, X4, X10, LSR #0
    ST1 { V28.8H, V29.8H, V30.8H, V31.8H }, [X4]
    LD1 { V19.8H, V20.8H, V21.8H, V22.8H }, [X4]
    ADD  X4, X4, X10, LSR #0
    ST1 { V20.8B, V21.8B, V22.8B, V23.8B }, [X4]
    LD1 { V9.2S, V10.2S, V11.2S, V12.2S }, [X4]
    ADD  X4, X4, X10, LSR #0
    ST1 { V14.1D, V15.1D, V16.1D, V17.1D }, [X4]
    LD1 { V10.1D, V11.1D, V12.1D, V13.1D }, [X4]
    ADD  X4, X4, X10, ASR #0
    ST1 { V13.2S, V14.2S, V15.2S, V16.2S }, [X4]
    LD1 { V28.2S, V29.2S, V30.2S, V31.2S }, [X4]
    ADD  X4, X4, X10, LSR #0
    ST1 { V9.4H, V10.4H, V11.4H, V12.4H }, [X4]
    LD1 { V20.4H, V21.4H, V22.4H, V23.4H }, [X4]
    ADD  X4, X4, X10
    ST1 { V28.8B, V29.8B, V30.8B, V31.8B }, [X4]
    LD1 { V13.8B, V14.8B, V15.8B, V16.8B }, [X4]
    ADD  X4, X4, X10
    ST1 { V8.2D }, [X4]
    LD1 { V10.8H }, [X4]
    ADD  X4, X4, X10, LSR #0
    ST1 { V24.16B }, [X4]
    LD1 { V29.16B }, [X4]
    ADD  X4, X4, X10, LSR #0
    ST1 { V17.2D }, [X4]
    LD1 { V28.2D }, [X4]
    ADD  X4, X4, X10
    ST1 { V25.4S }, [X4]
    LD1 { V24.4S }, [X4]
    ADD  X4, X4, X10, ASR #0
    ST1 { V8.8H }, [X4]
    LD1 { V30.8H }, [X4]
    ADD  X4, X4, X10, ASR #0
    ST1 { V18.2S }, [X4]
    LD1 { V25.2S }, [X4]
    ADD  X4, X4, X10, LSR #0
    ST1 { V25.1D }, [X4]
    LD1 { V17.1D }, [X4]
    ADD  X4, X4, X10, ASR #0
    ST1 { V6.2S }, [X4]
    LD1 { V6.2S }, [X4]
    ADD  X4, X4, X10, LSR #0
    ST1 { V3.4H }, [X4]
    LD1 { V15.4H }, [X4]
    ADD  X4, X4, X10
    ST1 { V13.8B }, [X4]
    LD1 { V6.8B }, [X4]
    ADD  X4, X4, X10
    ST1 { V0.8H, V1.8H, V2.8H }, [X4]
    LD1 { V1.4S, V2.4S, V3.4S }, [X4]
    ADD  X4, X4, X10
    ST1 { V26.16B, V27.16B, V28.16B }, [X4]
    LD1 { V26.16B, V27.16B, V28.16B }, [X4]
    ADD  X4, X4, X10
    ST1 { V26.2D, V27.2D, V28.2D }, [X4]
    LD1 { V30.2D, V31.2D, V0.2D }, [X4]
    ADD  X4, X4, X10, ASR #0
    ST1 { V1.4S, V2.4S, V3.4S }, [X4]
    LD1 { V1.4S, V2.4S, V3.4S }, [X4]
    ADD  X4, X4, X10, LSR #0
    ST1 { V0.8H, V1.8H, V2.8H }, [X4]
    LD1 { V17.8H, V18.8H, V19.8H }, [X4]
    ADD  X4, X4, X10, ASR #0
    ST1 { V27.2S, V28.2S, V29.2S }, [X4]
    LD1 { V0.2S, V1.2S, V2.2S }, [X4]
    ADD  X4, X4, X10, ASR #0
    ST1 { V24.1D, V25.1D, V26.1D }, [X4]
    LD1 { V10.1D, V11.1D, V12.1D }, [X4]
    ADD  X4, X4, X10, ASR #0
    ST1 { V28.2S, V29.2S, V30.2S }, [X4]
    LD1 { V26.2S, V27.2S, V28.2S }, [X4]
    ADD  X4, X4, X10, LSR #0
    ST1 { V31.4H, V0.4H, V1.4H }, [X4]
    LD1 { V2.4H, V3.4H, V4.4H }, [X4]
    ADD  X4, X4, X10, LSR #0
    ST1 { V10.8B, V11.8B, V12.8B }, [X4]
    LD1 { V30.8B, V31.8B, V0.8B }, [X4]
    ADD  X4, X4, X10
    ST1 { V16.8H, V17.8H }, [X4]
    LD1 { V14.4S, V15.4S }, [X4]
    ADD  X4, X4, X10, ASR #0
    ST1 { V14.16B, V15.16B }, [X4]
    LD1 { V16.16B, V17.16B }, [X4]
    ADD  X4, X4, X10, ASR #0
    ST1 { V27.2D, V28.2D }, [X4]
    LD1 { V17.2D, V18.2D }, [X4]
    ADD  X4, X4, X10, LSR #0
    ST1 { V17.4S, V18.4S }, [X4]
    LD1 { V24.4S, V25.4S }, [X4]
    ADD  X4, X4, X10, ASR #0
    ST1 { V24.8H, V25.8H }, [X4]
    LD1 { V1.8H, V2.8H }, [X4]
    ADD  X4, X4, X10, ASR #0
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X29, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X29, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X29, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X29, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X29, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X29, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X29, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X29, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X29, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X29, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X29, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X29, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X29, X9, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X29, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MRS  X9, FPSR
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V0.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D0
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V1.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D1
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D2
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D3
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D4
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V5.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D5
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D6
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V7.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D7
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D8
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D9
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D10
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D11
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V12.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D12
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V13.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D13
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D14
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D15
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D16
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V17.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D17
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V18.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D18
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V19.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D19
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V20.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D20
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D21
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V22.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D22
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D23
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V24.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D24
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D25
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D26
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V27.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D27
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D28
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D29
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V30.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D30
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, V31.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    FMOV  X9, D31
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X5, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X21
    FMOV  V0.D[1], X22
    FMOV  D1, X29
    FMOV  V1.D[1], X23
    FMOV  D2, X22
    FMOV  V2.D[1], X11
    FMOV  D3, X17
    FMOV  V3.D[1], X15
    FMOV  D4, X2
    FMOV  V4.D[1], X21
    FMOV  D5, X4
    FMOV  V5.D[1], X16
    FMOV  D6, X14
    FMOV  V6.D[1], X4
    FMOV  D7, X19
    FMOV  V7.D[1], X11
    FMOV  D8, X11
    FMOV  V8.D[1], X22
    FMOV  D9, X18
    FMOV  V9.D[1], X4
    FMOV  D10, X2
    FMOV  V10.D[1], X18
    FMOV  D11, X8
    FMOV  V11.D[1], X21
    FMOV  D12, X22
    FMOV  V12.D[1], X14
    FMOV  D13, X5
    FMOV  V13.D[1], X5
    FMOV  D14, X23
    FMOV  V14.D[1], X18
    FMOV  D15, X20
    FMOV  V15.D[1], X17
    FMOV  D16, X17
    FMOV  V16.D[1], X17
    FMOV  D17, X19
    FMOV  V17.D[1], X13
    FMOV  D18, X3
    FMOV  V18.D[1], X29
    FMOV  D19, X22
    FMOV  V19.D[1], X18
    FMOV  D20, X23
    FMOV  V20.D[1], X22
    FMOV  D21, X14
    FMOV  V21.D[1], X15
    FMOV  D22, X29
    FMOV  V22.D[1], X23
    FMOV  D23, X13
    FMOV  V23.D[1], X6
    FMOV  D24, X13
    FMOV  V24.D[1], X17
    FMOV  D25, X19
    FMOV  V25.D[1], X11
    FMOV  D26, X5
    FMOV  V26.D[1], X15
    FMOV  D27, X3
    FMOV  V27.D[1], X10
    FMOV  D28, X20
    FMOV  V28.D[1], X6
    FMOV  D29, X11
    FMOV  V29.D[1], X15
    FMOV  D30, X2
    FMOV  V30.D[1], X5
    FMOV  D31, X10
    FMOV  V31.D[1], X5
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X17, #0x40, LSL #0
    MOVZ  X2, #0x1900, LSL #0
    ADD  X29, X30, X2, LSR #0
    ST1 { V0.2D, V1.2D, V2.2D, V3.2D }, [X29]
    LD1 { V10.2D, V11.2D, V12.2D, V13.2D }, [X29]
    ADD  X29, X29, X17
    ST1 { V10.16B, V11.16B, V12.16B, V13.16B }, [X29]
    LD1 { V9.16B, V10.16B, V11.16B, V12.16B }, [X29]
    ADD  X29, X29, X17, LSR #0
    ST1 { V27.2D, V28.2D, V29.2D, V30.2D }, [X29]
    LD1 { V10.2D, V11.2D, V12.2D, V13.2D }, [X29]
    ADD  X29, X29, X17, ASR #0
    ST1 { V9.4S, V10.4S, V11.4S, V12.4S }, [X29]
    LD1 { V24.4S, V25.4S, V26.4S, V27.4S }, [X29]
    ADD  X29, X29, X17
    ST1 { V28.8H, V29.8H, V30.8H, V31.8H }, [X29]
    LD1 { V15.8H, V16.8H, V17.8H, V18.8H }, [X29]
    ADD  X29, X29, X17
    ST1 { V15.8B, V16.8B, V17.8B, V18.8B }, [X29]
    LD1 { V7.2S, V8.2S, V9.2S, V10.2S }, [X29]
    ADD  X29, X29, X17, ASR #0
    ST1 { V6.1D, V7.1D, V8.1D, V9.1D }, [X29]
    LD1 { V8.1D, V9.1D, V10.1D, V11.1D }, [X29]
    ADD  X29, X29, X17, ASR #0
    ST1 { V7.2S, V8.2S, V9.2S, V10.2S }, [X29]
    LD1 { V7.2S, V8.2S, V9.2S, V10.2S }, [X29]
    ADD  X29, X29, X17
    ST1 { V28.4H, V29.4H, V30.4H, V31.4H }, [X29]
    LD1 { V15.4H, V16.4H, V17.4H, V18.4H }, [X29]
    ADD  X29, X29, X17
    ST1 { V24.8B, V25.8B, V26.8B, V27.8B }, [X29]
    LD1 { V24.8B, V25.8B, V26.8B, V27.8B }, [X29]
    ADD  X29, X29, X17
    ST1 { V6.4S }, [X29]
    LD1 { V30.4S }, [X29]
    ADD  X29, X29, X17, LSR #0
    ST1 { V11.16B }, [X29]
    LD1 { V29.16B }, [X29]
    ADD  X29, X29, X17, LSR #0
    ST1 { V10.2D }, [X29]
    LD1 { V28.2D }, [X29]
    ADD  X29, X29, X17, ASR #0
    ST1 { V28.4S }, [X29]
    LD1 { V31.4S }, [X29]
    ADD  X29, X29, X17, LSR #0
    ST1 { V12.8H }, [X29]
    LD1 { V23.8H }, [X29]
    ADD  X29, X29, X17, ASR #0
    ST1 { V27.8B }, [X29]
    LD1 { V11.8B }, [X29]
    ADD  X29, X29, X17, ASR #0
    ST1 { V30.1D }, [X29]
    LD1 { V10.1D }, [X29]
    ADD  X29, X29, X17, LSR #0
    ST1 { V9.2S }, [X29]
    LD1 { V8.2S }, [X29]
    ADD  X29, X29, X17, ASR #0
    ST1 { V19.4H }, [X29]
    LD1 { V28.4H }, [X29]
    ADD  X29, X29, X17
    ST1 { V23.8B }, [X29]
    LD1 { V4.8B }, [X29]
    ADD  X29, X29, X17, ASR #0
    ST1 { V31.2D, V0.2D, V1.2D }, [X29]
    LD1 { V31.8H, V0.8H, V1.8H }, [X29]
    ADD  X29, X29, X17, LSR #0
    ST1 { V10.16B, V11.16B, V12.16B }, [X29]
    LD1 { V10.16B, V11.16B, V12.16B }, [X29]
    ADD  X29, X29, X17, LSR #0
    ST1 { V10.2D, V11.2D, V12.2D }, [X29]
    LD1 { V0.2D, V1.2D, V2.2D }, [X29]
    ADD  X29, X29, X17, ASR #0
    ST1 { V0.4S, V1.4S, V2.4S }, [X29]
    LD1 { V9.4S, V10.4S, V11.4S }, [X29]
    ADD  X29, X29, X17
    ST1 { V27.8H, V28.8H, V29.8H }, [X29]
    LD1 { V31.8H, V0.8H, V1.8H }, [X29]
    ADD  X29, X29, X17, ASR #0
    ST1 { V9.4H, V10.4H, V11.4H }, [X29]
    LD1 { V22.8B, V23.8B, V24.8B }, [X29]
    ADD  X29, X29, X17, ASR #0
    ST1 { V20.1D, V21.1D, V22.1D }, [X29]
    LD1 { V15.1D, V16.1D, V17.1D }, [X29]
    ADD  X29, X29, X17, LSR #0
    ST1 { V18.2S, V19.2S, V20.2S }, [X29]
    LD1 { V28.2S, V29.2S, V30.2S }, [X29]
    ADD  X29, X29, X17, ASR #0
    ST1 { V15.4H, V16.4H, V17.4H }, [X29]
    LD1 { V30.4H, V31.4H, V0.4H }, [X29]
    ADD  X29, X29, X17, LSR #0
    ST1 { V28.8B, V29.8B, V30.8B }, [X29]
    LD1 { V27.8B, V28.8B, V29.8B }, [X29]
    ADD  X29, X29, X17, ASR #0
    ST1 { V2.4S, V3.4S }, [X29]
    LD1 { V21.2D, V22.2D }, [X29]
    ADD  X29, X29, X17, LSR #0
    ST1 { V31.16B, V0.16B }, [X29]
    LD1 { V19.16B, V20.16B }, [X29]
    ADD  X29, X29, X17, LSR #0
    ST1 { V22.2D, V23.2D }, [X29]
    LD1 { V2.2D, V3.2D }, [X29]
    ADD  X29, X29, X17, LSR #0
    ST1 { V28.4S, V29.4S }, [X29]
    LD1 { V30.4S, V31.4S }, [X29]
    ADD  X29, X29, X17, ASR #0
    ST1 { V2.8H, V3.8H }, [X29]
    LD1 { V21.8H, V22.8H }, [X29]
    ADD  X29, X29, X17
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MRS  X6, FPSR
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V0.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D0
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V1.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D1
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D2
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D3
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V4.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D4
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D5
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V6.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D6
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D7
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D8
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V9.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D9
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D10
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V11.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D11
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V12.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D12
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D13
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V14.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D14
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V15.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D15
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D16
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D17
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V18.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D18
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D19
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V20.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D20
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D21
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V22.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D22
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D23
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D24
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V25.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D25
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D26
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V27.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D27
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D28
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V29.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D29
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V30.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D30
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, V31.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    FMOV  X6, D31
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X12
    FMOV  V0.D[1], X21
    FMOV  D1, X23
    FMOV  V1.D[1], X17
    FMOV  D2, X22
    FMOV  V2.D[1], X29
    FMOV  D3, X23
    FMOV  V3.D[1], X9
    FMOV  D4, X9
    FMOV  V4.D[1], X2
    FMOV  D5, X20
    FMOV  V5.D[1], X23
    FMOV  D6, X8
    FMOV  V6.D[1], X15
    FMOV  D7, X14
    FMOV  V7.D[1], X13
    FMOV  D8, X18
    FMOV  V8.D[1], X21
    FMOV  D9, X18
    FMOV  V9.D[1], X19
    FMOV  D10, X15
    FMOV  V10.D[1], X6
    FMOV  D11, X11
    FMOV  V11.D[1], X23
    FMOV  D12, X3
    FMOV  V12.D[1], X29
    FMOV  D13, X16
    FMOV  V13.D[1], X9
    FMOV  D14, X29
    FMOV  V14.D[1], X11
    FMOV  D15, X9
    FMOV  V15.D[1], X10
    FMOV  D16, X6
    FMOV  V16.D[1], X17
    FMOV  D17, X23
    FMOV  V17.D[1], X17
    FMOV  D18, X16
    FMOV  V18.D[1], X12
    FMOV  D19, X3
    FMOV  V19.D[1], X9
    FMOV  D20, X7
    FMOV  V20.D[1], X16
    FMOV  D21, X14
    FMOV  V21.D[1], X12
    FMOV  D22, X29
    FMOV  V22.D[1], X20
    FMOV  D23, X9
    FMOV  V23.D[1], X29
    FMOV  D24, X6
    FMOV  V24.D[1], X3
    FMOV  D25, X11
    FMOV  V25.D[1], X10
    FMOV  D26, X19
    FMOV  V26.D[1], X20
    FMOV  D27, X5
    FMOV  V27.D[1], X23
    FMOV  D28, X5
    FMOV  V28.D[1], X29
    FMOV  D29, X6
    FMOV  V29.D[1], X18
    FMOV  D30, X7
    FMOV  V30.D[1], X7
    FMOV  D31, X8
    FMOV  V31.D[1], X21
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X6, #0x40, LSL #0
    MOVZ  X11, #0x1e00, LSL #0
    ADD  X18, X30, X11, LSR #0
    ST1 { V0.16B, V1.16B, V2.16B, V3.16B }, [X18]
    LD1 { V9.4S, V10.4S, V11.4S, V12.4S }, [X18]
    ADD  X18, X18, X6
    ST1 { V5.16B, V6.16B, V7.16B, V8.16B }, [X18]
    LD1 { V0.16B, V1.16B, V2.16B, V3.16B }, [X18]
    ADD  X18, X18, X6
    ST1 { V29.2D, V30.2D, V31.2D, V0.2D }, [X18]
    LD1 { V14.2D, V15.2D, V16.2D, V17.2D }, [X18]
    ADD  X18, X18, X6, LSR #0
    ST1 { V14.4S, V15.4S, V16.4S, V17.4S }, [X18]
    LD1 { V8.4S, V9.4S, V10.4S, V11.4S }, [X18]
    ADD  X18, X18, X6, LSR #0
    ST1 { V9.8H, V10.8H, V11.8H, V12.8H }, [X18]
    LD1 { V21.8H, V22.8H, V23.8H, V24.8H }, [X18]
    ADD  X18, X18, X6
    ST1 { V16.8B, V17.8B, V18.8B, V19.8B }, [X18]
    LD1 { V25.1D, V26.1D, V27.1D, V28.1D }, [X18]
    ADD  X18, X18, X6
    ST1 { V21.1D, V22.1D, V23.1D, V24.1D }, [X18]
    LD1 { V1.1D, V2.1D, V3.1D, V4.1D }, [X18]
    ADD  X18, X18, X6, ASR #0
    ST1 { V1.2S, V2.2S, V3.2S, V4.2S }, [X18]
    LD1 { V16.2S, V17.2S, V18.2S, V19.2S }, [X18]
    ADD  X18, X18, X6, LSR #0
    ST1 { V15.4H, V16.4H, V17.4H, V18.4H }, [X18]
    LD1 { V31.4H, V0.4H, V1.4H, V2.4H }, [X18]
    ADD  X18, X18, X6, ASR #0
    ST1 { V31.8B, V0.8B, V1.8B, V2.8B }, [X18]
    LD1 { V21.8B, V22.8B, V23.8B, V24.8B }, [X18]
    ADD  X18, X18, X6
    ST1 { V26.4S }, [X18]
    LD1 { V4.16B }, [X18]
    ADD  X18, X18, X6
    ST1 { V14.16B }, [X18]
    LD1 { V31.16B }, [X18]
    ADD  X18, X18, X6
    ST1 { V22.2D }, [X18]
    LD1 { V18.2D }, [X18]
    ADD  X18, X18, X6
    ST1 { V24.4S }, [X18]
    LD1 { V1.4S }, [X18]
    ADD  X18, X18, X6
    ST1 { V1.8H }, [X18]
    LD1 { V15.8H }, [X18]
    ADD  X18, X18, X6
    ST1 { V15.1D }, [X18]
    LD1 { V29.4H }, [X18]
    ADD  X18, X18, X6, LSR #0
    ST1 { V18.1D }, [X18]
    LD1 { V17.1D }, [X18]
    ADD  X18, X18, X6
    ST1 { V27.2S }, [X18]
    LD1 { V27.2S }, [X18]
    ADD  X18, X18, X6, ASR #0
    ST1 { V27.4H }, [X18]
    LD1 { V15.4H }, [X18]
    ADD  X18, X18, X6
    ST1 { V22.8B }, [X18]
    LD1 { V27.8B }, [X18]
    ADD  X18, X18, X6, LSR #0
    ST1 { V4.16B, V5.16B, V6.16B }, [X18]
    LD1 { V4.8H, V5.8H, V6.8H }, [X18]
    ADD  X18, X18, X6
    ST1 { V4.16B, V5.16B, V6.16B }, [X18]
    LD1 { V20.16B, V21.16B, V22.16B }, [X18]
    ADD  X18, X18, X6, LSR #0
    ST1 { V5.2D, V6.2D, V7.2D }, [X18]
    LD1 { V30.2D, V31.2D, V0.2D }, [X18]
    ADD  X18, X18, X6, ASR #0
    ST1 { V20.4S, V21.4S, V22.4S }, [X18]
    LD1 { V6.4S, V7.4S, V8.4S }, [X18]
    ADD  X18, X18, X6, LSR #0
    ST1 { V27.8H, V28.8H, V29.8H }, [X18]
    LD1 { V24.8H, V25.8H, V26.8H }, [X18]
    ADD  X18, X18, X6, LSR #0
    ST1 { V11.4H, V12.4H, V13.4H }, [X18]
    LD1 { V27.8B, V28.8B, V29.8B }, [X18]
    ADD  X18, X18, X6
    ST1 { V20.1D, V21.1D, V22.1D }, [X18]
    LD1 { V20.1D, V21.1D, V22.1D }, [X18]
    ADD  X18, X18, X6, LSR #0
    ST1 { V24.2S, V25.2S, V26.2S }, [X18]
    LD1 { V6.2S, V7.2S, V8.2S }, [X18]
    ADD  X18, X18, X6, LSR #0
    ST1 { V20.4H, V21.4H, V22.4H }, [X18]
    LD1 { V3.4H, V4.4H, V5.4H }, [X18]
    ADD  X18, X18, X6, LSR #0
    ST1 { V22.8B, V23.8B, V24.8B }, [X18]
    LD1 { V0.8B, V1.8B, V2.8B }, [X18]
    ADD  X18, X18, X6, ASR #0
    ST1 { V2.4S, V3.4S }, [X18]
    LD1 { V17.2D, V18.2D }, [X18]
    ADD  X18, X18, X6, LSR #0
    ST1 { V29.16B, V30.16B }, [X18]
    LD1 { V2.16B, V3.16B }, [X18]
    ADD  X18, X18, X6, LSR #0
    ST1 { V15.2D, V16.2D }, [X18]
    LD1 { V23.2D, V24.2D }, [X18]
    ADD  X18, X18, X6, ASR #0
    ST1 { V14.4S, V15.4S }, [X18]
    LD1 { V20.4S, V21.4S }, [X18]
    ADD  X18, X18, X6
    ST1 { V1.8H, V2.8H }, [X18]
    LD1 { V3.8H, V4.8H }, [X18]
    ADD  X18, X18, X6, ASR #0
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X8, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X8, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X8, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X8, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X8, X10, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X8, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X8, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X8, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X8, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X8, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X8, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X8, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X8, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X8, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X8, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP01_TestFail
    MRS  X10, FPSR
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V0.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D0
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V1.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D1
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V2.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D2
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V3.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D3
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D4
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D5
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V6.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D6
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V7.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D7
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V8.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D8
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D9
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V10.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D10
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D11
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D12
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V13.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D13
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D14
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D15
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D16
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V17.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D17
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D18
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V19.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D19
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D20
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D21
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D22
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V23.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D23
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D24
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V25.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D25
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D26
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D27
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V28.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D28
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V29.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D29
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V30.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D30
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, V31.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    FMOV  X10, D31
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X14, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X20
    FMOV  V0.D[1], X18
    FMOV  D1, X19
    FMOV  V1.D[1], X22
    FMOV  D2, X29
    FMOV  V2.D[1], X29
    FMOV  D3, X19
    FMOV  V3.D[1], X15
    FMOV  D4, X8
    FMOV  V4.D[1], X10
    FMOV  D5, X23
    FMOV  V5.D[1], X8
    FMOV  D6, X2
    FMOV  V6.D[1], X18
    FMOV  D7, X23
    FMOV  V7.D[1], X8
    FMOV  D8, X15
    FMOV  V8.D[1], X15
    FMOV  D9, X3
    FMOV  V9.D[1], X9
    FMOV  D10, X20
    FMOV  V10.D[1], X23
    FMOV  D11, X21
    FMOV  V11.D[1], X14
    FMOV  D12, X10
    FMOV  V12.D[1], X29
    FMOV  D13, X15
    FMOV  V13.D[1], X14
    FMOV  D14, X22
    FMOV  V14.D[1], X10
    FMOV  D15, X6
    FMOV  V15.D[1], X20
    FMOV  D16, X14
    FMOV  V16.D[1], X16
    FMOV  D17, X12
    FMOV  V17.D[1], X2
    FMOV  D18, X2
    FMOV  V18.D[1], X8
    FMOV  D19, X20
    FMOV  V19.D[1], X17
    FMOV  D20, X14
    FMOV  V20.D[1], X21
    FMOV  D21, X29
    FMOV  V21.D[1], X21
    FMOV  D22, X21
    FMOV  V22.D[1], X17
    FMOV  D23, X6
    FMOV  V23.D[1], X23
    FMOV  D24, X16
    FMOV  V24.D[1], X22
    FMOV  D25, X7
    FMOV  V25.D[1], X15
    FMOV  D26, X15
    FMOV  V26.D[1], X8
    FMOV  D27, X16
    FMOV  V27.D[1], X5
    FMOV  D28, X13
    FMOV  V28.D[1], X29
    FMOV  D29, X6
    FMOV  V29.D[1], X17
    FMOV  D30, X13
    FMOV  V30.D[1], X29
    FMOV  D31, X18
    FMOV  V31.D[1], X21
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X29, #0x40, LSL #0
    MOVZ  X4, #0x2300, LSL #0
    ADD  X14, X30, X4, LSR #0
    ST1 { V10.16B, V11.16B, V12.16B, V13.16B }, [X14]
    LD1 { V12.2D, V13.2D, V14.2D, V15.2D }, [X14]
    ADD  X14, X14, X29
    ST1 { V16.16B, V17.16B, V18.16B, V19.16B }, [X14]
    LD1 { V8.16B, V9.16B, V10.16B, V11.16B }, [X14]
    ADD  X14, X14, X29, LSR #0
    ST1 { V16.2D, V17.2D, V18.2D, V19.2D }, [X14]
    LD1 { V25.2D, V26.2D, V27.2D, V28.2D }, [X14]
    ADD  X14, X14, X29, LSR #0
    ST1 { V30.4S, V31.4S, V0.4S, V1.4S }, [X14]
    LD1 { V7.4S, V8.4S, V9.4S, V10.4S }, [X14]
    ADD  X14, X14, X29, LSR #0
    ST1 { V20.8H, V21.8H, V22.8H, V23.8H }, [X14]
    LD1 { V4.8H, V5.8H, V6.8H, V7.8H }, [X14]
    ADD  X14, X14, X29
    ST1 { V12.2S, V13.2S, V14.2S, V15.2S }, [X14]
    LD1 { V5.4H, V6.4H, V7.4H, V8.4H }, [X14]
    ADD  X14, X14, X29, ASR #0
    ST1 { V25.1D, V26.1D, V27.1D, V28.1D }, [X14]
    LD1 { V16.1D, V17.1D, V18.1D, V19.1D }, [X14]
    ADD  X14, X14, X29
    ST1 { V7.2S, V8.2S, V9.2S, V10.2S }, [X14]
    LD1 { V7.2S, V8.2S, V9.2S, V10.2S }, [X14]
    ADD  X14, X14, X29
    ST1 { V28.4H, V29.4H, V30.4H, V31.4H }, [X14]
    LD1 { V12.4H, V13.4H, V14.4H, V15.4H }, [X14]
    ADD  X14, X14, X29, ASR #0
    ST1 { V12.8B, V13.8B, V14.8B, V15.8B }, [X14]
    LD1 { V27.8B, V28.8B, V29.8B, V30.8B }, [X14]
    ADD  X14, X14, X29
    ST1 { V3.16B }, [X14]
    LD1 { V26.8H }, [X14]
    ADD  X14, X14, X29
    ST1 { V11.16B }, [X14]
    LD1 { V25.16B }, [X14]
    ADD  X14, X14, X29, LSR #0
    ST1 { V27.2D }, [X14]
    LD1 { V10.2D }, [X14]
    ADD  X14, X14, X29, ASR #0
    ST1 { V30.4S }, [X14]
    LD1 { V22.4S }, [X14]
    ADD  X14, X14, X29, LSR #0
    ST1 { V9.8H }, [X14]
    LD1 { V31.8H }, [X14]
    ADD  X14, X14, X29, ASR #0
    ST1 { V10.1D }, [X14]
    LD1 { V10.1D }, [X14]
    ADD  X14, X14, X29, ASR #0
    ST1 { V29.1D }, [X14]
    LD1 { V1.1D }, [X14]
    ADD  X14, X14, X29, LSR #0
    ST1 { V24.2S }, [X14]
    LD1 { V27.2S }, [X14]
    ADD  X14, X14, X29, ASR #0
    ST1 { V22.4H }, [X14]
    LD1 { V29.4H }, [X14]
    ADD  X14, X14, X29, ASR #0
    ST1 { V1.8B }, [X14]
    LD1 { V10.8B }, [X14]
    ADD  X14, X14, X29, LSR #0
    ST1 { V2.16B, V3.16B, V4.16B }, [X14]
    LD1 { V2.4S, V3.4S, V4.4S }, [X14]
    ADD  X14, X14, X29, ASR #0
    ST1 { V8.16B, V9.16B, V10.16B }, [X14]
    LD1 { V28.16B, V29.16B, V30.16B }, [X14]
    ADD  X14, X14, X29, ASR #0
    ST1 { V28.2D, V29.2D, V30.2D }, [X14]
    LD1 { V27.2D, V28.2D, V29.2D }, [X14]
    ADD  X14, X14, X29, ASR #0
    ST1 { V2.4S, V3.4S, V4.4S }, [X14]
    LD1 { V15.4S, V16.4S, V17.4S }, [X14]
    ADD  X14, X14, X29
    ST1 { V15.8H, V16.8H, V17.8H }, [X14]
    LD1 { V10.8H, V11.8H, V12.8H }, [X14]
    ADD  X14, X14, X29
    ST1 { V9.1D, V10.1D, V11.1D }, [X14]
    LD1 { V25.4H, V26.4H, V27.4H }, [X14]
    ADD  X14, X14, X29, ASR #0
    ST1 { V25.1D, V26.1D, V27.1D }, [X14]
    LD1 { V31.1D, V0.1D, V1.1D }, [X14]
    ADD  X14, X14, X29
    ST1 { V31.2S, V0.2S, V1.2S }, [X14]
    LD1 { V0.2S, V1.2S, V2.2S }, [X14]
    ADD  X14, X14, X29, LSR #0
    ST1 { V0.4H, V1.4H, V2.4H }, [X14]
    LD1 { V0.4H, V1.4H, V2.4H }, [X14]
    ADD  X14, X14, X29
    ST1 { V0.8B, V1.8B, V2.8B }, [X14]
    LD1 { V0.8B, V1.8B, V2.8B }, [X14]
    ADD  X14, X14, X29
    ST1 { V1.2D, V2.2D }, [X14]
    LD1 { V17.16B, V18.16B }, [X14]
    ADD  X14, X14, X29, ASR #0
    ST1 { V17.16B, V18.16B }, [X14]
    LD1 { V25.16B, V26.16B }, [X14]
    ADD  X14, X14, X29
    ST1 { V25.2D, V26.2D }, [X14]
    LD1 { V25.2D, V26.2D }, [X14]
    ADD  X14, X14, X29, LSR #0
    ST1 { V25.4S, V26.4S }, [X14]
    LD1 { V7.4S, V8.4S }, [X14]
    ADD  X14, X14, X29, LSR #0
    ST1 { V4.8H, V5.8H }, [X14]
    LD1 { V31.8H, V0.8H }, [X14]
    ADD  X14, X14, X29
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X2, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X2, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X2, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X2, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X2, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X2, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X2, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X2, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X2, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X2, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X2, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X2, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X2, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X2, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP01_TestFail
    MRS  X13, FPSR
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V0.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D0
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V1.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D1
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D2
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D3
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V4.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D4
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D5
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D6
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V7.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D7
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D8
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D9
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D10
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D11
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D12
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V13.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D13
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V14.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D14
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D15
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D16
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D17
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D18
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D19
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D20
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D21
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D22
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V23.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D23
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D24
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D25
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V26.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D26
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D27
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D28
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D29
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V30.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D30
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, V31.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    FMOV  X13, D31
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X21, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X6
    FMOV  V0.D[1], X8
    FMOV  D1, X29
    FMOV  V1.D[1], X23
    FMOV  D2, X10
    FMOV  V2.D[1], X2
    FMOV  D3, X17
    FMOV  V3.D[1], X6
    FMOV  D4, X23
    FMOV  V4.D[1], X22
    FMOV  D5, X12
    FMOV  V5.D[1], X5
    FMOV  D6, X20
    FMOV  V6.D[1], X21
    FMOV  D7, X8
    FMOV  V7.D[1], X15
    FMOV  D8, X18
    FMOV  V8.D[1], X11
    FMOV  D9, X12
    FMOV  V9.D[1], X5
    FMOV  D10, X12
    FMOV  V10.D[1], X18
    FMOV  D11, X6
    FMOV  V11.D[1], X13
    FMOV  D12, X3
    FMOV  V12.D[1], X17
    FMOV  D13, X23
    FMOV  V13.D[1], X14
    FMOV  D14, X21
    FMOV  V14.D[1], X10
    FMOV  D15, X15
    FMOV  V15.D[1], X10
    FMOV  D16, X13
    FMOV  V16.D[1], X16
    FMOV  D17, X17
    FMOV  V17.D[1], X19
    FMOV  D18, X21
    FMOV  V18.D[1], X5
    FMOV  D19, X13
    FMOV  V19.D[1], X13
    FMOV  D20, X8
    FMOV  V20.D[1], X9
    FMOV  D21, X22
    FMOV  V21.D[1], X15
    FMOV  D22, X2
    FMOV  V22.D[1], X22
    FMOV  D23, X17
    FMOV  V23.D[1], X8
    FMOV  D24, X21
    FMOV  V24.D[1], X11
    FMOV  D25, X23
    FMOV  V25.D[1], X5
    FMOV  D26, X22
    FMOV  V26.D[1], X3
    FMOV  D27, X16
    FMOV  V27.D[1], X11
    FMOV  D28, X23
    FMOV  V28.D[1], X8
    FMOV  D29, X14
    FMOV  V29.D[1], X9
    FMOV  D30, X3
    FMOV  V30.D[1], X6
    FMOV  D31, X10
    FMOV  V31.D[1], X18
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X19, #0x40, LSL #0
    MOVZ  X8, #0x2800, LSL #0
    ADD  X5, X30, X8, ASR #0
    ST1 { V26.16B, V27.16B, V28.16B, V29.16B }, [X5]
    LD1 { V31.4S, V0.4S, V1.4S, V2.4S }, [X5]
    ADD  X5, X5, X19, ASR #0
    ST1 { V23.16B, V24.16B, V25.16B, V26.16B }, [X5]
    LD1 { V19.16B, V20.16B, V21.16B, V22.16B }, [X5]
    ADD  X5, X5, X19, ASR #0
    ST1 { V30.2D, V31.2D, V0.2D, V1.2D }, [X5]
    LD1 { V24.2D, V25.2D, V26.2D, V27.2D }, [X5]
    ADD  X5, X5, X19, ASR #0
    ST1 { V22.4S, V23.4S, V24.4S, V25.4S }, [X5]
    LD1 { V5.4S, V6.4S, V7.4S, V8.4S }, [X5]
    ADD  X5, X5, X19
    ST1 { V5.8H, V6.8H, V7.8H, V8.8H }, [X5]
    LD1 { V13.8H, V14.8H, V15.8H, V16.8H }, [X5]
    ADD  X5, X5, X19, LSR #0
    ST1 { V13.1D, V14.1D, V15.1D, V16.1D }, [X5]
    LD1 { V5.8B, V6.8B, V7.8B, V8.8B }, [X5]
    ADD  X5, X5, X19, ASR #0
    ST1 { V5.1D, V6.1D, V7.1D, V8.1D }, [X5]
    LD1 { V22.1D, V23.1D, V24.1D, V25.1D }, [X5]
    ADD  X5, X5, X19, LSR #0
    ST1 { V22.2S, V23.2S, V24.2S, V25.2S }, [X5]
    LD1 { V22.2S, V23.2S, V24.2S, V25.2S }, [X5]
    ADD  X5, X5, X19, ASR #0
    ST1 { V24.4H, V25.4H, V26.4H, V27.4H }, [X5]
    LD1 { V9.4H, V10.4H, V11.4H, V12.4H }, [X5]
    ADD  X5, X5, X19, ASR #0
    ST1 { V22.8B, V23.8B, V24.8B, V25.8B }, [X5]
    LD1 { V13.8B, V14.8B, V15.8B, V16.8B }, [X5]
    ADD  X5, X5, X19, ASR #0
    ST1 { V4.2D }, [X5]
    LD1 { V4.8H }, [X5]
    ADD  X5, X5, X19
    ST1 { V10.16B }, [X5]
    LD1 { V5.16B }, [X5]
    ADD  X5, X5, X19, ASR #0
    ST1 { V13.2D }, [X5]
    LD1 { V24.2D }, [X5]
    ADD  X5, X5, X19, ASR #0
    ST1 { V14.4S }, [X5]
    LD1 { V13.4S }, [X5]
    ADD  X5, X5, X19, LSR #0
    ST1 { V8.8H }, [X5]
    LD1 { V26.8H }, [X5]
    ADD  X5, X5, X19, LSR #0
    ST1 { V12.4H }, [X5]
    LD1 { V4.2S }, [X5]
    ADD  X5, X5, X19, LSR #0
    ST1 { V5.1D }, [X5]
    LD1 { V8.1D }, [X5]
    ADD  X5, X5, X19, ASR #0
    ST1 { V8.2S }, [X5]
    LD1 { V5.2S }, [X5]
    ADD  X5, X5, X19, LSR #0
    ST1 { V4.4H }, [X5]
    LD1 { V23.4H }, [X5]
    ADD  X5, X5, X19
    ST1 { V23.8B }, [X5]
    LD1 { V8.8B }, [X5]
    ADD  X5, X5, X19, LSR #0
    ST1 { V25.8H, V26.8H, V27.8H }, [X5]
    LD1 { V2.8H, V3.8H, V4.8H }, [X5]
    ADD  X5, X5, X19
    ST1 { V22.16B, V23.16B, V24.16B }, [X5]
    LD1 { V21.16B, V22.16B, V23.16B }, [X5]
    ADD  X5, X5, X19
    ST1 { V18.2D, V19.2D, V20.2D }, [X5]
    LD1 { V18.2D, V19.2D, V20.2D }, [X5]
    ADD  X5, X5, X19
    ST1 { V8.4S, V9.4S, V10.4S }, [X5]
    LD1 { V25.4S, V26.4S, V27.4S }, [X5]
    ADD  X5, X5, X19
    ST1 { V2.8H, V3.8H, V4.8H }, [X5]
    LD1 { V8.8H, V9.8H, V10.8H }, [X5]
    ADD  X5, X5, X19, ASR #0
    ST1 { V8.8B, V9.8B, V10.8B }, [X5]
    LD1 { V2.4H, V3.4H, V4.4H }, [X5]
    ADD  X5, X5, X19
    ST1 { V21.1D, V22.1D, V23.1D }, [X5]
    LD1 { V3.1D, V4.1D, V5.1D }, [X5]
    ADD  X5, X5, X19, ASR #0
    ST1 { V24.2S, V25.2S, V26.2S }, [X5]
    LD1 { V2.2S, V3.2S, V4.2S }, [X5]
    ADD  X5, X5, X19, ASR #0
    ST1 { V6.4H, V7.4H, V8.4H }, [X5]
    LD1 { V7.4H, V8.4H, V9.4H }, [X5]
    ADD  X5, X5, X19
    ST1 { V1.8B, V2.8B, V3.8B }, [X5]
    LD1 { V16.8B, V17.8B, V18.8B }, [X5]
    ADD  X5, X5, X19, LSR #0
    ST1 { V16.16B, V17.16B }, [X5]
    LD1 { V10.16B, V11.16B }, [X5]
    ADD  X5, X5, X19, LSR #0
    ST1 { V14.16B, V15.16B }, [X5]
    LD1 { V15.16B, V16.16B }, [X5]
    ADD  X5, X5, X19, ASR #0
    ST1 { V5.2D, V6.2D }, [X5]
    LD1 { V25.2D, V26.2D }, [X5]
    ADD  X5, X5, X19
    ST1 { V17.4S, V18.4S }, [X5]
    LD1 { V21.4S, V22.4S }, [X5]
    ADD  X5, X5, X19
    ST1 { V25.8H, V26.8H }, [X5]
    LD1 { V15.8H, V16.8H }, [X5]
    ADD  X5, X5, X19
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X22, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X22, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X22, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X22, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X22, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X22, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X22, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X22, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X22, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X22, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X22, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X22, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X22, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP01_TestFail
    MRS  X16, FPSR
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D0
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D1
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D2
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D3
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D4
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D5
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D6
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D7
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D8
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D9
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D10
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D11
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D12
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D13
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D14
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D15
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D16
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D17
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D18
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D19
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D20
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D21
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D22
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D23
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D24
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D25
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D26
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D27
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D28
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D29
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D30
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
    FMOV  X16, D31
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X15
    FMOV  V0.D[1], X22
    FMOV  D1, X23
    FMOV  V1.D[1], X14
    FMOV  D2, X21
    FMOV  V2.D[1], X29
    FMOV  D3, X21
    FMOV  V3.D[1], X2
    FMOV  D4, X19
    FMOV  V4.D[1], X8
    FMOV  D5, X16
    FMOV  V5.D[1], X22
    FMOV  D6, X9
    FMOV  V6.D[1], X14
    FMOV  D7, X23
    FMOV  V7.D[1], X20
    FMOV  D8, X6
    FMOV  V8.D[1], X15
    FMOV  D9, X21
    FMOV  V9.D[1], X15
    FMOV  D10, X10
    FMOV  V10.D[1], X22
    FMOV  D11, X12
    FMOV  V11.D[1], X29
    FMOV  D12, X4
    FMOV  V12.D[1], X6
    FMOV  D13, X17
    FMOV  V13.D[1], X22
    FMOV  D14, X19
    FMOV  V14.D[1], X16
    FMOV  D15, X6
    FMOV  V15.D[1], X12
    FMOV  D16, X20
    FMOV  V16.D[1], X16
    FMOV  D17, X18
    FMOV  V17.D[1], X4
    FMOV  D18, X8
    FMOV  V18.D[1], X12
    FMOV  D19, X10
    FMOV  V19.D[1], X21
    FMOV  D20, X3
    FMOV  V20.D[1], X21
    FMOV  D21, X18
    FMOV  V21.D[1], X4
    FMOV  D22, X17
    FMOV  V22.D[1], X2
    FMOV  D23, X11
    FMOV  V23.D[1], X20
    FMOV  D24, X16
    FMOV  V24.D[1], X13
    FMOV  D25, X8
    FMOV  V25.D[1], X2
    FMOV  D26, X11
    FMOV  V26.D[1], X10
    FMOV  D27, X18
    FMOV  V27.D[1], X10
    FMOV  D28, X19
    FMOV  V28.D[1], X21
    FMOV  D29, X23
    FMOV  V29.D[1], X13
    FMOV  D30, X5
    FMOV  V30.D[1], X5
    FMOV  D31, X15
    FMOV  V31.D[1], X15
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X10, #0x40, LSL #0
    MOVZ  X22, #0x2d00, LSL #0
    ADD  X8, X30, X22
    ST1 { V13.16B, V14.16B, V15.16B, V16.16B }, [X8]
    LD1 { V30.16B, V31.16B, V0.16B, V1.16B }, [X8]
    ADD  X8, X8, X10
    ST1 { V26.16B, V27.16B, V28.16B, V29.16B }, [X8]
    LD1 { V11.16B, V12.16B, V13.16B, V14.16B }, [X8]
    ADD  X8, X8, X10
    ST1 { V11.2D, V12.2D, V13.2D, V14.2D }, [X8]
    LD1 { V8.2D, V9.2D, V10.2D, V11.2D }, [X8]
    ADD  X8, X8, X10, LSR #0
    ST1 { V8.4S, V9.4S, V10.4S, V11.4S }, [X8]
    LD1 { V5.4S, V6.4S, V7.4S, V8.4S }, [X8]
    ADD  X8, X8, X10, LSR #0
    ST1 { V5.8H, V6.8H, V7.8H, V8.8H }, [X8]
    LD1 { V5.8H, V6.8H, V7.8H, V8.8H }, [X8]
    ADD  X8, X8, X10
    ST1 { V5.8B, V6.8B, V7.8B, V8.8B }, [X8]
    LD1 { V10.4H, V11.4H, V12.4H, V13.4H }, [X8]
    ADD  X8, X8, X10
    ST1 { V30.1D, V31.1D, V0.1D, V1.1D }, [X8]
    LD1 { V22.1D, V23.1D, V24.1D, V25.1D }, [X8]
    ADD  X8, X8, X10, LSR #0
    ST1 { V22.2S, V23.2S, V24.2S, V25.2S }, [X8]
    LD1 { V16.2S, V17.2S, V18.2S, V19.2S }, [X8]
    ADD  X8, X8, X10, LSR #0
    ST1 { V14.4H, V15.4H, V16.4H, V17.4H }, [X8]
    LD1 { V5.4H, V6.4H, V7.4H, V8.4H }, [X8]
    ADD  X8, X8, X10, LSR #0
    ST1 { V20.8B, V21.8B, V22.8B, V23.8B }, [X8]
    LD1 { V21.8B, V22.8B, V23.8B, V24.8B }, [X8]
    ADD  X8, X8, X10, ASR #0
    ST1 { V27.8H }, [X8]
    LD1 { V23.2D }, [X8]
    ADD  X8, X8, X10, LSR #0
    ST1 { V21.16B }, [X8]
    LD1 { V31.16B }, [X8]
    ADD  X8, X8, X10, ASR #0
    ST1 { V13.2D }, [X8]
    LD1 { V30.2D }, [X8]
    ADD  X8, X8, X10, LSR #0
    ST1 { V5.4S }, [X8]
    LD1 { V21.4S }, [X8]
    ADD  X8, X8, X10, ASR #0
    ST1 { V29.8H }, [X8]
    LD1 { V12.8H }, [X8]
    ADD  X8, X8, X10, ASR #0
    ST1 { V30.2S }, [X8]
    LD1 { V13.8B }, [X8]
    ADD  X8, X8, X10, ASR #0
    ST1 { V31.1D }, [X8]
    LD1 { V27.1D }, [X8]
    ADD  X8, X8, X10, LSR #0
    ST1 { V22.2S }, [X8]
    LD1 { V6.2S }, [X8]
    ADD  X8, X8, X10, LSR #0
    ST1 { V15.4H }, [X8]
    LD1 { V4.4H }, [X8]
    ADD  X8, X8, X10
    ST1 { V8.8B }, [X8]
    LD1 { V6.8B }, [X8]
    ADD  X8, X8, X10
    ST1 { V28.4S, V29.4S, V30.4S }, [X8]
    LD1 { V10.16B, V11.16B, V12.16B }, [X8]
    ADD  X8, X8, X10
    ST1 { V11.16B, V12.16B, V13.16B }, [X8]
    LD1 { V27.16B, V28.16B, V29.16B }, [X8]
    ADD  X8, X8, X10
    ST1 { V10.2D, V11.2D, V12.2D }, [X8]
    LD1 { V10.2D, V11.2D, V12.2D }, [X8]
    ADD  X8, X8, X10
    ST1 { V14.4S, V15.4S, V16.4S }, [X8]
    LD1 { V9.4S, V10.4S, V11.4S }, [X8]
    ADD  X8, X8, X10, LSR #0
    ST1 { V22.8H, V23.8H, V24.8H }, [X8]
    LD1 { V13.8H, V14.8H, V15.8H }, [X8]
    ADD  X8, X8, X10, LSR #0
    ST1 { V24.1D, V25.1D, V26.1D }, [X8]
    LD1 { V22.2S, V23.2S, V24.2S }, [X8]
    ADD  X8, X8, X10, ASR #0
    ST1 { V13.1D, V14.1D, V15.1D }, [X8]
    LD1 { V13.1D, V14.1D, V15.1D }, [X8]
    ADD  X8, X8, X10
    ST1 { V17.2S, V18.2S, V19.2S }, [X8]
    LD1 { V17.2S, V18.2S, V19.2S }, [X8]
    ADD  X8, X8, X10, LSR #0
    ST1 { V12.4H, V13.4H, V14.4H }, [X8]
    LD1 { V5.4H, V6.4H, V7.4H }, [X8]
    ADD  X8, X8, X10, LSR #0
    ST1 { V27.8B, V28.8B, V29.8B }, [X8]
    LD1 { V27.8B, V28.8B, V29.8B }, [X8]
    ADD  X8, X8, X10
    ST1 { V18.8H, V19.8H }, [X8]
    LD1 { V12.16B, V13.16B }, [X8]
    ADD  X8, X8, X10, ASR #0
    ST1 { V3.16B, V4.16B }, [X8]
    LD1 { V8.16B, V9.16B }, [X8]
    ADD  X8, X8, X10, LSR #0
    ST1 { V12.2D, V13.2D }, [X8]
    LD1 { V25.2D, V26.2D }, [X8]
    ADD  X8, X8, X10
    ST1 { V27.4S, V28.4S }, [X8]
    LD1 { V18.4S, V19.4S }, [X8]
    ADD  X8, X8, X10, ASR #0
    ST1 { V17.8H, V18.8H }, [X8]
    LD1 { V12.8H, V13.8H }, [X8]
    ADD  X8, X8, X10
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X29, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X29, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X29, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X29, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X29, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X29, X19, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X29, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X29, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X29, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X29, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X29, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X29, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X29, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X29, X19, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X29, X19, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MRS  X19, FPSR
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V0.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D0
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V1.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D1
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V2.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D2
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V3.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D3
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V4.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D4
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V5.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D5
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V6.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D6
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D7
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V8.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D8
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D9
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V10.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D10
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D11
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V12.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D12
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V13.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D13
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D14
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V15.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D15
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V16.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D16
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V17.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D17
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V18.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D18
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V19.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D19
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V20.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D20
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V21.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D21
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V22.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D22
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V23.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D23
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V24.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D24
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D25
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D26
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V27.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D27
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D28
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V29.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D29
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V30.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D30
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, V31.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    FMOV  X19, D31
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail

AdvsimdLoadStoreP01_TestEnd:
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
AdvsimdLoadStoreP01_TestFail:
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
