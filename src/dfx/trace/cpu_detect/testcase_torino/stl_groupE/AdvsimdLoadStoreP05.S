.global AdvsimdLoadStoreP05

.text
.p2align 4

AdvsimdLoadStoreP05:

AdvsimdLoadStoreP05_TestBegin:
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
    MOVZ  X2, #0xfad6, LSL #0
    MOVK  X2, #0xc967, LSL #16
    MOVK  X2, #0xbc2b, LSL #32
    MOVK  X2, #0xb92d, LSL #48
    MOVZ  X3, #0x2ed9, LSL #0
    MOVK  X3, #0xad4, LSL #16
    MOVK  X3, #0x6e23, LSL #32
    MOVK  X3, #0xeff5, LSL #48
    MOVZ  X4, #0xdeab, LSL #0
    MOVK  X4, #0xbcf3, LSL #16
    MOVK  X4, #0x404d, LSL #32
    MOVK  X4, #0x1751, LSL #48
    MOVZ  X5, #0x75bc, LSL #0
    MOVK  X5, #0x2e7b, LSL #16
    MOVK  X5, #0x777e, LSL #32
    MOVK  X5, #0x3e83, LSL #48
    MOVZ  X6, #0xb85a, LSL #0
    MOVK  X6, #0xbdcf, LSL #16
    MOVK  X6, #0x5bd7, LSL #32
    MOVK  X6, #0xa1ca, LSL #48
    MOVZ  X7, #0xdf97, LSL #0
    MOVK  X7, #0xb9d8, LSL #16
    MOVK  X7, #0xf336, LSL #32
    MOVK  X7, #0x4509, LSL #48
    MOVZ  X8, #0xc6f9, LSL #0
    MOVK  X8, #0x18b4, LSL #16
    MOVK  X8, #0x829, LSL #32
    MOVK  X8, #0x72bb, LSL #48
    MOVZ  X9, #0xb3c9, LSL #0
    MOVK  X9, #0xbbca, LSL #16
    MOVK  X9, #0x7285, LSL #32
    MOVK  X9, #0xde96, LSL #48
    MOVZ  X10, #0x892f, LSL #0
    MOVK  X10, #0xab8c, LSL #16
    MOVK  X10, #0xce2e, LSL #32
    MOVK  X10, #0x8fca, LSL #48
    MOVZ  X11, #0x73af, LSL #0
    MOVK  X11, #0xb599, LSL #16
    MOVK  X11, #0x297, LSL #32
    MOVK  X11, #0x6ae8, LSL #48
    MOVZ  X12, #0xed9f, LSL #0
    MOVK  X12, #0x23c4, LSL #16
    MOVK  X12, #0xe0cf, LSL #32
    MOVK  X12, #0xcfca, LSL #48
    MOVZ  X13, #0xcb29, LSL #0
    MOVK  X13, #0x2589, LSL #16
    MOVK  X13, #0x4c, LSL #32
    MOVK  X13, #0x2cf, LSL #48
    MOVZ  X14, #0xeefb, LSL #0
    MOVK  X14, #0x5447, LSL #16
    MOVK  X14, #0xe6b8, LSL #32
    MOVK  X14, #0xc572, LSL #48
    MOVZ  X15, #0xf5ef, LSL #0
    MOVK  X15, #0xd282, LSL #16
    MOVK  X15, #0x30b, LSL #32
    MOVK  X15, #0xdb9c, LSL #48
    MOVZ  X16, #0x358d, LSL #0
    MOVK  X16, #0x8a06, LSL #16
    MOVK  X16, #0x597d, LSL #32
    MOVK  X16, #0xb1f1, LSL #48
    MOVZ  X17, #0x3fe8, LSL #0
    MOVK  X17, #0xfc8a, LSL #16
    MOVK  X17, #0x450f, LSL #32
    MOVK  X17, #0xee1f, LSL #48
    MOVZ  X23, #0x91df, LSL #0
    MOVK  X23, #0xdce0, LSL #16
    MOVK  X23, #0xd55d, LSL #32
    MOVK  X23, #0x8f14, LSL #48
    MOVZ  X24, #0x78ad, LSL #0
    MOVK  X24, #0xaedd, LSL #16
    MOVK  X24, #0xdd73, LSL #32
    MOVK  X24, #0x32aa, LSL #48
    MOVZ  X25, #0xbb81, LSL #0
    MOVK  X25, #0x5a95, LSL #16
    MOVK  X25, #0x7760, LSL #32
    MOVK  X25, #0xd0a3, LSL #48
    MOVZ  X26, #0xc583, LSL #0
    MOVK  X26, #0xa10c, LSL #16
    MOVK  X26, #0x9c71, LSL #32
    MOVK  X26, #0x82af, LSL #48
    MOVZ  X27, #0x42d2, LSL #0
    MOVK  X27, #0x7ff6, LSL #16
    MOVK  X27, #0x5a11, LSL #32
    MOVK  X27, #0xa82a, LSL #48
    MOVZ  X28, #0x90c8, LSL #0
    MOVK  X28, #0xb8ab, LSL #16
    MOVK  X28, #0xa0da, LSL #32
    MOVK  X28, #0x495c, LSL #48
    MOVZ  X29, #0x5364, LSL #0
    MOVK  X29, #0xc793, LSL #16
    MOVK  X29, #0x9fdc, LSL #32
    MOVK  X29, #0xca2e, LSL #48
    MOVZ  X9, #0xb764, LSL #0
    MOVK  X9, #0x2452, LSL #16
    MOVK  X9, #0x69ea, LSL #32
    MOVK  X9, #0x7e9e, LSL #48
    MSR  FPCR, X9
    MRS  X17, FPCR
    MOVZ  X16, #0x60ff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    AND  X17, X17, X16
    MOVZ  X16, #0x0, LSL #0
    ORR  X17, X17, X16
    MSR  FPCR, X17
    ISB  SY
    MOVZ  X9, #0x58dd, LSL #0
    MOVK  X9, #0x55ca, LSL #16
    MOVK  X9, #0xdf7f, LSL #32
    MOVK  X9, #0xde3, LSL #48
    MSR  FPSR, X9
    MRS  X2, FPSR
    MOVZ  X27, #0xff60, LSL #0
    MOVK  X27, #0x7ff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    AND  X2, X2, X27
    MOVZ  X27, #0x0, LSL #0
    ORR  X2, X2, X27
    MSR  FPSR, X2
    ISB  SY
    SUBS  W15, W17, W29, LSR #23
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
    FMOV  V0.D[1], X15
    FMOV  D1, X26
    FMOV  V1.D[1], X28
    FMOV  D2, X29
    FMOV  V2.D[1], X27
    FMOV  D3, X14
    FMOV  V3.D[1], X24
    FMOV  D4, X26
    FMOV  V4.D[1], X23
    FMOV  D5, X9
    FMOV  V5.D[1], X17
    FMOV  D6, X17
    FMOV  V6.D[1], X26
    FMOV  D7, X29
    FMOV  V7.D[1], X15
    FMOV  D8, X12
    FMOV  V8.D[1], X13
    FMOV  D9, X2
    FMOV  V9.D[1], X9
    FMOV  D10, X26
    FMOV  V10.D[1], X13
    FMOV  D11, X16
    FMOV  V11.D[1], X4
    FMOV  D12, X16
    FMOV  V12.D[1], X29
    FMOV  D13, X2
    FMOV  V13.D[1], X8
    FMOV  D14, X11
    FMOV  V14.D[1], X7
    FMOV  D15, X8
    FMOV  V15.D[1], X16
    FMOV  D16, X14
    FMOV  V16.D[1], X10
    FMOV  D17, X23
    FMOV  V17.D[1], X8
    FMOV  D18, X3
    FMOV  V18.D[1], X3
    FMOV  D19, X23
    FMOV  V19.D[1], X15
    FMOV  D20, X26
    FMOV  V20.D[1], X24
    FMOV  D21, X25
    FMOV  V21.D[1], X26
    FMOV  D22, X26
    FMOV  V22.D[1], X23
    FMOV  D23, X29
    FMOV  V23.D[1], X17
    FMOV  D24, X28
    FMOV  V24.D[1], X25
    FMOV  D25, X11
    FMOV  V25.D[1], X7
    FMOV  D26, X4
    FMOV  V26.D[1], X2
    FMOV  D27, X29
    FMOV  V27.D[1], X28
    FMOV  D28, X26
    FMOV  V28.D[1], X29
    FMOV  D29, X10
    FMOV  V29.D[1], X24
    FMOV  D30, X29
    FMOV  V30.D[1], X27
    FMOV  D31, X2
    FMOV  V31.D[1], X15
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X4, #0x40, LSL #0
    MOVZ  X6, #0x0, LSL #0
    ADD  X2, X30, X6, ASR #0
    ST2 { V19.2D, V20.2D }, [X2]
    LD2 { V4.4S, V5.4S }, [X2]
    ADD  X2, X2, X4, LSR #0
    ST2 { V25.16B, V26.16B }, [X2]
    LD2 { V20.16B, V21.16B }, [X2]
    ADD  X2, X2, X4, ASR #0
    ST2 { V18.2D, V19.2D }, [X2]
    LD2 { V2.2D, V3.2D }, [X2]
    ADD  X2, X2, X4
    ST2 { V21.4S, V22.4S }, [X2]
    LD2 { V28.4S, V29.4S }, [X2]
    ADD  X2, X2, X4, LSR #0
    ST2 { V4.8H, V5.8H }, [X2]
    LD2 { V14.8H, V15.8H }, [X2]
    ADD  X2, X2, X4, ASR #0
    ST2 { V2.2S, V3.2S }, [X2]
    LD2 { V15.2S, V16.2S }, [X2]
    ADD  X2, X2, X4
    ST2 { V28.2S, V29.2S }, [X2]
    LD2 { V4.2S, V5.2S }, [X2]
    ADD  X2, X2, X4, ASR #0
    ST2 { V30.4H, V31.4H }, [X2]
    LD2 { V31.4H, V0.4H }, [X2]
    ADD  X2, X2, X4, LSR #0
    ST2 { V3.8B, V4.8B }, [X2]
    LD2 { V29.8B, V30.8B }, [X2]
    ADD  X2, X2, X4
    MOV  X13, X2
    ST2 { V31.4S, V0.4S }, [X13], #32
    MOV  X13, X2
    LD2 { V12.8H, V13.8H }, [X13], #32
    ADD  X2, X2, X4, ASR #0
    MOV  X13, X2
    ST2 { V14.16B, V15.16B }, [X13], #32
    MOV  X13, X2
    LD2 { V28.16B, V29.16B }, [X13], #32
    ADD  X2, X2, X4, ASR #0
    MOV  X13, X2
    ST2 { V1.2D, V2.2D }, [X13], #32
    MOV  X13, X2
    LD2 { V14.2D, V15.2D }, [X13], #32
    ADD  X2, X2, X4
    MOV  X13, X2
    ST2 { V30.4S, V31.4S }, [X13], #32
    MOV  X13, X2
    LD2 { V12.4S, V13.4S }, [X13], #32
    ADD  X2, X2, X4, LSR #0
    MOV  X13, X2
    ST2 { V25.8H, V26.8H }, [X13], #32
    MOV  X13, X2
    LD2 { V30.8H, V31.8H }, [X13], #32
    ADD  X2, X2, X4
    MOV  X13, X2
    ST2 { V28.2S, V29.2S }, [X13], #16
    MOV  X13, X2
    LD2 { V16.8B, V17.8B }, [X13], #16
    ADD  X2, X2, X4, ASR #0
    MOV  X13, X2
    ST2 { V16.2S, V17.2S }, [X13], #16
    MOV  X13, X2
    LD2 { V4.2S, V5.2S }, [X13], #16
    ADD  X2, X2, X4, LSR #0
    MOV  X13, X2
    ST2 { V19.4H, V20.4H }, [X13], #16
    MOV  X13, X2
    LD2 { V10.4H, V11.4H }, [X13], #16
    ADD  X2, X2, X4, LSR #0
    MOV  X13, X2
    ST2 { V13.8B, V14.8B }, [X13], #16
    MOV  X13, X2
    LD2 { V14.8B, V15.8B }, [X13], #16
    ADD  X2, X2, X4
    ST2 { V29.4S, V30.4S }, [X2], X15
    LD2 { V7.8H, V8.8H }, [X2], X15
    ADD  X2, X2, X4, ASR #0
    ST2 { V22.16B, V23.16B }, [X2], X15
    LD2 { V22.16B, V23.16B }, [X2], X15
    ADD  X2, X2, X4, ASR #0
    ST2 { V10.2D, V11.2D }, [X2], X15
    LD2 { V3.2D, V4.2D }, [X2], X15
    ADD  X2, X2, X4, LSR #0
    ST2 { V14.4S, V15.4S }, [X2], X15
    LD2 { V13.4S, V14.4S }, [X2], X15
    ADD  X2, X2, X4
    ST2 { V3.8H, V4.8H }, [X2], X15
    LD2 { V14.8H, V15.8H }, [X2], X15
    ADD  X2, X2, X4, ASR #0
    ST2 { V30.4H, V31.4H }, [X2], X15
    LD2 { V24.4H, V25.4H }, [X2], X15
    ADD  X2, X2, X4
    ST2 { V22.2S, V23.2S }, [X2], X15
    LD2 { V25.2S, V26.2S }, [X2], X15
    ADD  X2, X2, X4
    ST2 { V30.4H, V31.4H }, [X2], X15
    LD2 { V25.4H, V26.4H }, [X2], X15
    ADD  X2, X2, X4, ASR #0
    ST2 { V14.8B, V15.8B }, [X2], X15
    LD2 { V9.8B, V10.8B }, [X2], X15
    ADD  X2, X2, X4, LSR #0
    ST2 { V5.H, V6.H }[0x0], [X2]
    LD2 { V29.H, V30.H }[0x7], [X2]
    ADD  X2, X2, X4, ASR #0
    ST2 { V10.S, V11.S }[0x0], [X2]
    LD2 { V2.S, V3.S }[0x1], [X2]
    ADD  X2, X2, X4, ASR #0
    ST2 { V25.D, V26.D }[0x1], [X2]
    LD2 { V17.D, V18.D }[0x1], [X2]
    ADD  X2, X2, X4, ASR #0
    ST2 { V15.B, V16.B }[0x9], [X2]
    LD2 { V8.B, V9.B }[0xd], [X2]
    ADD  X2, X2, X4
    MOV  X13, X2
    ST2 { V29.H, V30.H }[0x2], [X13], #4
    MOV  X13, X2
    LD2 { V7.H, V8.H }[0x3], [X13], #4
    ADD  X2, X2, X4
    ST2 { V3.H, V4.H }[0x4], [X2], X15
    LD2 { V17.H, V18.H }[0x7], [X2], X15
    ADD  X2, X2, X4, LSR #0
    MOV  X13, X2
    ST2 { V29.S, V30.S }[0x1], [X13], #8
    MOV  X13, X2
    LD2 { V14.S, V15.S }[0x1], [X13], #8
    ADD  X2, X2, X4, LSR #0
    ST2 { V14.S, V15.S }[0x1], [X2], X15
    LD2 { V15.S, V16.S }[0x0], [X2], X15
    ADD  X2, X2, X4, ASR #0
    MOV  X13, X2
    ST2 { V7.D, V8.D }[0x1], [X13], #16
    MOV  X13, X2
    LD2 { V3.D, V4.D }[0x1], [X13], #16
    ADD  X2, X2, X4, LSR #0
    ST2 { V15.D, V16.D }[0x0], [X2], X15
    LD2 { V14.D, V15.D }[0x0], [X2], X15
    ADD  X2, X2, X4
    MOV  X13, X2
    ST2 { V17.B, V18.B }[0x3], [X13], #2
    MOV  X13, X2
    LD2 { V3.B, V4.B }[0x4], [X13], #2
    ADD  X2, X2, X4
    ST2 { V14.B, V15.B }[0x7], [X2], X15
    LD2 { V25.B, V26.B }[0xe], [X2], X15
    ADD  X2, X2, X4, LSR #0
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MRS  X23, FPSR
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V0.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D0
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V1.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D1
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D2
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D3
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D4
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D5
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D6
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D7
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D8
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D9
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D10
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D11
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D12
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D13
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D14
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D15
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D16
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D17
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D18
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D19
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D20
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D21
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D22
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V23.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D23
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D24
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D25
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D26
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D27
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D28
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D29
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V30.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D30
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V31.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D31
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
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
    FMOV  D0, X29
    FMOV  V0.D[1], X26
    FMOV  D1, X16
    FMOV  V1.D[1], X27
    FMOV  D2, X12
    FMOV  V2.D[1], X28
    FMOV  D3, X17
    FMOV  V3.D[1], X12
    FMOV  D4, X27
    FMOV  V4.D[1], X17
    FMOV  D5, X28
    FMOV  V5.D[1], X11
    FMOV  D6, X5
    FMOV  V6.D[1], X28
    FMOV  D7, X16
    FMOV  V7.D[1], X24
    FMOV  D8, X24
    FMOV  V8.D[1], X11
    FMOV  D9, X27
    FMOV  V9.D[1], X24
    FMOV  D10, X4
    FMOV  V10.D[1], X6
    FMOV  D11, X5
    FMOV  V11.D[1], X9
    FMOV  D12, X25
    FMOV  V12.D[1], X28
    FMOV  D13, X17
    FMOV  V13.D[1], X27
    FMOV  D14, X27
    FMOV  V14.D[1], X10
    FMOV  D15, X3
    FMOV  V15.D[1], X13
    FMOV  D16, X11
    FMOV  V16.D[1], X13
    FMOV  D17, X7
    FMOV  V17.D[1], X16
    FMOV  D18, X4
    FMOV  V18.D[1], X7
    FMOV  D19, X27
    FMOV  V19.D[1], X24
    FMOV  D20, X3
    FMOV  V20.D[1], X29
    FMOV  D21, X3
    FMOV  V21.D[1], X25
    FMOV  D22, X11
    FMOV  V22.D[1], X14
    FMOV  D23, X5
    FMOV  V23.D[1], X16
    FMOV  D24, X6
    FMOV  V24.D[1], X13
    FMOV  D25, X25
    FMOV  V25.D[1], X15
    FMOV  D26, X23
    FMOV  V26.D[1], X17
    FMOV  D27, X5
    FMOV  V27.D[1], X16
    FMOV  D28, X2
    FMOV  V28.D[1], X24
    FMOV  D29, X25
    FMOV  V29.D[1], X29
    FMOV  D30, X8
    FMOV  V30.D[1], X25
    FMOV  D31, X15
    FMOV  V31.D[1], X17
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X3, #0x40, LSL #0
    MOVZ  X16, #0x500, LSL #0
    ADD  X6, X30, X16, LSR #0
    ST2 { V3.2D, V4.2D }, [X6]
    LD2 { V17.16B, V18.16B }, [X6]
    ADD  X6, X6, X3, ASR #0
    ST2 { V25.16B, V26.16B }, [X6]
    LD2 { V12.16B, V13.16B }, [X6]
    ADD  X6, X6, X3
    ST2 { V29.2D, V30.2D }, [X6]
    LD2 { V15.2D, V16.2D }, [X6]
    ADD  X6, X6, X3
    ST2 { V2.4S, V3.4S }, [X6]
    LD2 { V3.4S, V4.4S }, [X6]
    ADD  X6, X6, X3
    ST2 { V4.8H, V5.8H }, [X6]
    LD2 { V9.8H, V10.8H }, [X6]
    ADD  X6, X6, X3
    ST2 { V27.8B, V28.8B }, [X6]
    LD2 { V8.8B, V9.8B }, [X6]
    ADD  X6, X6, X3
    ST2 { V17.2S, V18.2S }, [X6]
    LD2 { V7.2S, V8.2S }, [X6]
    ADD  X6, X6, X3
    ST2 { V15.4H, V16.4H }, [X6]
    LD2 { V7.4H, V8.4H }, [X6]
    ADD  X6, X6, X3
    ST2 { V1.8B, V2.8B }, [X6]
    LD2 { V24.8B, V25.8B }, [X6]
    ADD  X6, X6, X3, LSR #0
    MOV  X15, X6
    ST2 { V24.8H, V25.8H }, [X15], #32
    MOV  X15, X6
    LD2 { V5.4S, V6.4S }, [X15], #32
    ADD  X6, X6, X3, ASR #0
    MOV  X15, X6
    ST2 { V17.16B, V18.16B }, [X15], #32
    MOV  X15, X6
    LD2 { V16.16B, V17.16B }, [X15], #32
    ADD  X6, X6, X3
    MOV  X15, X6
    ST2 { V19.2D, V20.2D }, [X15], #32
    MOV  X15, X6
    LD2 { V19.2D, V20.2D }, [X15], #32
    ADD  X6, X6, X3, ASR #0
    MOV  X15, X6
    ST2 { V7.4S, V8.4S }, [X15], #32
    MOV  X15, X6
    LD2 { V29.4S, V30.4S }, [X15], #32
    ADD  X6, X6, X3, ASR #0
    MOV  X15, X6
    ST2 { V26.8H, V27.8H }, [X15], #32
    MOV  X15, X6
    LD2 { V10.8H, V11.8H }, [X15], #32
    ADD  X6, X6, X3, LSR #0
    MOV  X15, X6
    ST2 { V23.8B, V24.8B }, [X15], #16
    MOV  X15, X6
    LD2 { V7.2S, V8.2S }, [X15], #16
    ADD  X6, X6, X3
    MOV  X15, X6
    ST2 { V29.2S, V30.2S }, [X15], #16
    MOV  X15, X6
    LD2 { V26.2S, V27.2S }, [X15], #16
    ADD  X6, X6, X3, ASR #0
    MOV  X15, X6
    ST2 { V7.4H, V8.4H }, [X15], #16
    MOV  X15, X6
    LD2 { V7.4H, V8.4H }, [X15], #16
    ADD  X6, X6, X3
    MOV  X15, X6
    ST2 { V17.8B, V18.8B }, [X15], #16
    MOV  X15, X6
    LD2 { V23.8B, V24.8B }, [X15], #16
    ADD  X6, X6, X3
    ST2 { V9.2D, V10.2D }, [X6], X23
    LD2 { V17.8H, V18.8H }, [X6], X23
    ADD  X6, X6, X3, ASR #0
    ST2 { V22.16B, V23.16B }, [X6], X23
    LD2 { V29.16B, V30.16B }, [X6], X23
    ADD  X6, X6, X3, ASR #0
    ST2 { V29.2D, V30.2D }, [X6], X23
    LD2 { V15.2D, V16.2D }, [X6], X23
    ADD  X6, X6, X3
    ST2 { V21.4S, V22.4S }, [X6], X23
    LD2 { V29.4S, V30.4S }, [X6], X23
    ADD  X6, X6, X3, LSR #0
    ST2 { V15.8H, V16.8H }, [X6], X23
    LD2 { V15.8H, V16.8H }, [X6], X23
    ADD  X6, X6, X3, ASR #0
    ST2 { V7.4H, V8.4H }, [X6], X23
    LD2 { V9.4H, V10.4H }, [X6], X23
    ADD  X6, X6, X3, ASR #0
    ST2 { V16.2S, V17.2S }, [X6], X23
    LD2 { V14.2S, V15.2S }, [X6], X23
    ADD  X6, X6, X3
    ST2 { V22.4H, V23.4H }, [X6], X23
    LD2 { V17.4H, V18.4H }, [X6], X23
    ADD  X6, X6, X3, ASR #0
    ST2 { V29.8B, V30.8B }, [X6], X23
    LD2 { V7.8B, V8.8B }, [X6], X23
    ADD  X6, X6, X3, LSR #0
    ST2 { V3.H, V4.H }[0x1], [X6]
    LD2 { V20.H, V21.H }[0x4], [X6]
    ADD  X6, X6, X3, ASR #0
    ST2 { V7.S, V8.S }[0x0], [X6]
    LD2 { V31.S, V0.S }[0x2], [X6]
    ADD  X6, X6, X3, ASR #0
    ST2 { V30.D, V31.D }[0x0], [X6]
    LD2 { V25.D, V26.D }[0x0], [X6]
    ADD  X6, X6, X3
    ST2 { V20.B, V21.B }[0xc], [X6]
    LD2 { V15.B, V16.B }[0x5], [X6]
    ADD  X6, X6, X3
    MOV  X15, X6
    ST2 { V15.H, V16.H }[0x2], [X15], #4
    MOV  X15, X6
    LD2 { V7.H, V8.H }[0x2], [X15], #4
    ADD  X6, X6, X3, ASR #0
    ST2 { V25.H, V26.H }[0x0], [X6], X23
    LD2 { V25.H, V26.H }[0x2], [X6], X23
    ADD  X6, X6, X3
    MOV  X15, X6
    ST2 { V25.S, V26.S }[0x1], [X15], #8
    MOV  X15, X6
    LD2 { V7.S, V8.S }[0x1], [X15], #8
    ADD  X6, X6, X3
    ST2 { V31.S, V0.S }[0x2], [X6], X23
    LD2 { V28.S, V29.S }[0x3], [X6], X23
    ADD  X6, X6, X3, ASR #0
    MOV  X15, X6
    ST2 { V28.D, V29.D }[0x1], [X15], #16
    MOV  X15, X6
    LD2 { V14.D, V15.D }[0x0], [X15], #16
    ADD  X6, X6, X3, LSR #0
    ST2 { V30.D, V31.D }[0x0], [X6], X23
    LD2 { V8.D, V9.D }[0x1], [X6], X23
    ADD  X6, X6, X3, LSR #0
    MOV  X15, X6
    ST2 { V14.B, V15.B }[0x1], [X15], #2
    MOV  X15, X6
    LD2 { V13.B, V14.B }[0xf], [X15], #2
    ADD  X6, X6, X3, ASR #0
    ST2 { V7.B, V8.B }[0xb], [X6], X23
    LD2 { V28.B, V29.B }[0x5], [X6], X23
    ADD  X6, X6, X3, ASR #0
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MRS  X28, FPSR
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V0.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D0
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V1.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D1
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D2
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V3.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D3
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V4.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D4
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D5
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D6
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V7.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D7
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D8
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V9.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D9
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D10
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D11
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V12.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D12
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V13.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D13
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xa500, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D14
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V15.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D15
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D16
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D17
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D18
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V19.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D19
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D20
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V21.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D21
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D22
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V23.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D23
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D24
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D25
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D26
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V27.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D27
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V28.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D28
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V29.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D29
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V30.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D30
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, V31.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X28, D31
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X13, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
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
    FMOV  D0, X25
    FMOV  V0.D[1], X27
    FMOV  D1, X27
    FMOV  V1.D[1], X8
    FMOV  D2, X29
    FMOV  V2.D[1], X28
    FMOV  D3, X16
    FMOV  V3.D[1], X26
    FMOV  D4, X14
    FMOV  V4.D[1], X13
    FMOV  D5, X17
    FMOV  V5.D[1], X12
    FMOV  D6, X10
    FMOV  V6.D[1], X13
    FMOV  D7, X26
    FMOV  V7.D[1], X15
    FMOV  D8, X11
    FMOV  V8.D[1], X17
    FMOV  D9, X3
    FMOV  V9.D[1], X8
    FMOV  D10, X2
    FMOV  V10.D[1], X8
    FMOV  D11, X24
    FMOV  V11.D[1], X5
    FMOV  D12, X29
    FMOV  V12.D[1], X25
    FMOV  D13, X29
    FMOV  V13.D[1], X27
    FMOV  D14, X29
    FMOV  V14.D[1], X26
    FMOV  D15, X24
    FMOV  V15.D[1], X6
    FMOV  D16, X27
    FMOV  V16.D[1], X2
    FMOV  D17, X12
    FMOV  V17.D[1], X8
    FMOV  D18, X2
    FMOV  V18.D[1], X4
    FMOV  D19, X17
    FMOV  V19.D[1], X10
    FMOV  D20, X6
    FMOV  V20.D[1], X28
    FMOV  D21, X17
    FMOV  V21.D[1], X27
    FMOV  D22, X12
    FMOV  V22.D[1], X13
    FMOV  D23, X4
    FMOV  V23.D[1], X13
    FMOV  D24, X5
    FMOV  V24.D[1], X16
    FMOV  D25, X23
    FMOV  V25.D[1], X9
    FMOV  D26, X9
    FMOV  V26.D[1], X10
    FMOV  D27, X11
    FMOV  V27.D[1], X28
    FMOV  D28, X15
    FMOV  V28.D[1], X14
    FMOV  D29, X15
    FMOV  V29.D[1], X13
    FMOV  D30, X6
    FMOV  V30.D[1], X4
    FMOV  D31, X10
    FMOV  V31.D[1], X3
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X12, #0x40, LSL #0
    MOVZ  X25, #0xa00, LSL #0
    ADD  X17, X30, X25
    ST2 { V12.4S, V13.4S }, [X17]
    LD2 { V1.8H, V2.8H }, [X17]
    ADD  X17, X17, X12, LSR #0
    ST2 { V29.16B, V30.16B }, [X17]
    LD2 { V12.16B, V13.16B }, [X17]
    ADD  X17, X17, X12, LSR #0
    ST2 { V13.2D, V14.2D }, [X17]
    LD2 { V6.2D, V7.2D }, [X17]
    ADD  X17, X17, X12, LSR #0
    ST2 { V27.4S, V28.4S }, [X17]
    LD2 { V5.4S, V6.4S }, [X17]
    ADD  X17, X17, X12
    ST2 { V5.8H, V6.8H }, [X17]
    LD2 { V14.8H, V15.8H }, [X17]
    ADD  X17, X17, X12, LSR #0
    ST2 { V1.8B, V2.8B }, [X17]
    LD2 { V1.2S, V2.2S }, [X17]
    ADD  X17, X17, X12
    ST2 { V14.2S, V15.2S }, [X17]
    LD2 { V26.2S, V27.2S }, [X17]
    ADD  X17, X17, X12, LSR #0
    ST2 { V9.4H, V10.4H }, [X17]
    LD2 { V1.4H, V2.4H }, [X17]
    ADD  X17, X17, X12
    ST2 { V10.8B, V11.8B }, [X17]
    LD2 { V23.8B, V24.8B }, [X17]
    ADD  X17, X17, X12
    MOV  X3, X17
    ST2 { V26.4S, V27.4S }, [X3], #32
    MOV  X3, X17
    LD2 { V21.4S, V22.4S }, [X3], #32
    ADD  X17, X17, X12
    MOV  X3, X17
    ST2 { V23.16B, V24.16B }, [X3], #32
    MOV  X3, X17
    LD2 { V14.16B, V15.16B }, [X3], #32
    ADD  X17, X17, X12
    MOV  X3, X17
    ST2 { V14.2D, V15.2D }, [X3], #32
    MOV  X3, X17
    LD2 { V26.2D, V27.2D }, [X3], #32
    ADD  X17, X17, X12, LSR #0
    MOV  X3, X17
    ST2 { V21.4S, V22.4S }, [X3], #32
    MOV  X3, X17
    LD2 { V22.4S, V23.4S }, [X3], #32
    ADD  X17, X17, X12, LSR #0
    MOV  X3, X17
    ST2 { V29.8H, V30.8H }, [X3], #32
    MOV  X3, X17
    LD2 { V29.8H, V30.8H }, [X3], #32
    ADD  X17, X17, X12, ASR #0
    MOV  X3, X17
    ST2 { V16.2S, V17.2S }, [X3], #16
    MOV  X3, X17
    LD2 { V19.4H, V20.4H }, [X3], #16
    ADD  X17, X17, X12, ASR #0
    MOV  X3, X17
    ST2 { V19.2S, V20.2S }, [X3], #16
    MOV  X3, X17
    LD2 { V16.2S, V17.2S }, [X3], #16
    ADD  X17, X17, X12, LSR #0
    MOV  X3, X17
    ST2 { V29.4H, V30.4H }, [X3], #16
    MOV  X3, X17
    LD2 { V29.4H, V30.4H }, [X3], #16
    ADD  X17, X17, X12
    MOV  X3, X17
    ST2 { V29.8B, V30.8B }, [X3], #16
    MOV  X3, X17
    LD2 { V29.8B, V30.8B }, [X3], #16
    ADD  X17, X17, X12
    ST2 { V29.16B, V30.16B }, [X17], X4
    LD2 { V29.4S, V30.4S }, [X17], X4
    ADD  X17, X17, X12, ASR #0
    ST2 { V29.16B, V30.16B }, [X17], X4
    LD2 { V3.16B, V4.16B }, [X17], X4
    ADD  X17, X17, X12
    ST2 { V3.2D, V4.2D }, [X17], X4
    LD2 { V26.2D, V27.2D }, [X17], X4
    ADD  X17, X17, X12
    ST2 { V13.4S, V14.4S }, [X17], X4
    LD2 { V20.4S, V21.4S }, [X17], X4
    ADD  X17, X17, X12
    ST2 { V20.8H, V21.8H }, [X17], X4
    LD2 { V31.8H, V0.8H }, [X17], X4
    ADD  X17, X17, X12, LSR #0
    ST2 { V19.2S, V20.2S }, [X17], X4
    LD2 { V17.8B, V18.8B }, [X17], X4
    ADD  X17, X17, X12, ASR #0
    ST2 { V17.2S, V18.2S }, [X17], X4
    LD2 { V0.2S, V1.2S }, [X17], X4
    ADD  X17, X17, X12
    ST2 { V0.4H, V1.4H }, [X17], X4
    LD2 { V15.4H, V16.4H }, [X17], X4
    ADD  X17, X17, X12
    ST2 { V26.8B, V27.8B }, [X17], X4
    LD2 { V28.8B, V29.8B }, [X17], X4
    ADD  X17, X17, X12, LSR #0
    ST2 { V15.H, V16.H }[0x1], [X17]
    LD2 { V22.H, V23.H }[0x5], [X17]
    ADD  X17, X17, X12, LSR #0
    ST2 { V15.S, V16.S }[0x3], [X17]
    LD2 { V20.S, V21.S }[0x1], [X17]
    ADD  X17, X17, X12
    ST2 { V21.D, V22.D }[0x1], [X17]
    LD2 { V26.D, V27.D }[0x0], [X17]
    ADD  X17, X17, X12, ASR #0
    ST2 { V26.B, V27.B }[0xc], [X17]
    LD2 { V7.B, V8.B }[0x6], [X17]
    ADD  X17, X17, X12, LSR #0
    MOV  X3, X17
    ST2 { V29.H, V30.H }[0x2], [X3], #4
    MOV  X3, X17
    LD2 { V21.H, V22.H }[0x1], [X3], #4
    ADD  X17, X17, X12
    ST2 { V20.H, V21.H }[0x3], [X17], X4
    LD2 { V10.H, V11.H }[0x0], [X17], X4
    ADD  X17, X17, X12, LSR #0
    MOV  X3, X17
    ST2 { V22.S, V23.S }[0x0], [X3], #8
    MOV  X3, X17
    LD2 { V15.S, V16.S }[0x3], [X3], #8
    ADD  X17, X17, X12
    ST2 { V0.S, V1.S }[0x1], [X17], X4
    LD2 { V29.S, V30.S }[0x0], [X17], X4
    ADD  X17, X17, X12, ASR #0
    MOV  X3, X17
    ST2 { V27.D, V28.D }[0x0], [X3], #16
    MOV  X3, X17
    LD2 { V22.D, V23.D }[0x1], [X3], #16
    ADD  X17, X17, X12, ASR #0
    ST2 { V27.D, V28.D }[0x1], [X17], X4
    LD2 { V23.D, V24.D }[0x0], [X17], X4
    ADD  X17, X17, X12
    MOV  X3, X17
    ST2 { V15.B, V16.B }[0x0], [X3], #2
    MOV  X3, X17
    LD2 { V0.B, V1.B }[0x0], [X3], #2
    ADD  X17, X17, X12
    ST2 { V0.B, V1.B }[0x9], [X17], X4
    LD2 { V0.B, V1.B }[0x4], [X17], X4
    ADD  X17, X17, X12, LSR #0
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    MRS  X26, FPSR
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V0.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D0
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a00, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V1.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D1
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a00, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D2
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D3
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D4
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D5
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D6
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D7
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a00, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D8
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a00, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D9
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D10
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V11.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D11
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D12
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D13
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D14
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D15
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D16
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D17
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D18
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D19
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D20
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D21
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D22
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D23
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D24
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D25
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D26
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D27
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D28
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D29
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V30.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D30
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V31.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D31
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
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
    FMOV  D0, X14
    FMOV  V0.D[1], X28
    FMOV  D1, X26
    FMOV  V1.D[1], X24
    FMOV  D2, X27
    FMOV  V2.D[1], X29
    FMOV  D3, X27
    FMOV  V3.D[1], X15
    FMOV  D4, X5
    FMOV  V4.D[1], X13
    FMOV  D5, X6
    FMOV  V5.D[1], X28
    FMOV  D6, X9
    FMOV  V6.D[1], X7
    FMOV  D7, X13
    FMOV  V7.D[1], X4
    FMOV  D8, X8
    FMOV  V8.D[1], X13
    FMOV  D9, X25
    FMOV  V9.D[1], X3
    FMOV  D10, X11
    FMOV  V10.D[1], X15
    FMOV  D11, X9
    FMOV  V11.D[1], X9
    FMOV  D12, X25
    FMOV  V12.D[1], X16
    FMOV  D13, X3
    FMOV  V13.D[1], X9
    FMOV  D14, X10
    FMOV  V14.D[1], X2
    FMOV  D15, X23
    FMOV  V15.D[1], X9
    FMOV  D16, X9
    FMOV  V16.D[1], X28
    FMOV  D17, X11
    FMOV  V17.D[1], X25
    FMOV  D18, X25
    FMOV  V18.D[1], X28
    FMOV  D19, X3
    FMOV  V19.D[1], X2
    FMOV  D20, X28
    FMOV  V20.D[1], X27
    FMOV  D21, X13
    FMOV  V21.D[1], X27
    FMOV  D22, X24
    FMOV  V22.D[1], X15
    FMOV  D23, X29
    FMOV  V23.D[1], X7
    FMOV  D24, X26
    FMOV  V24.D[1], X15
    FMOV  D25, X13
    FMOV  V25.D[1], X3
    FMOV  D26, X11
    FMOV  V26.D[1], X12
    FMOV  D27, X4
    FMOV  V27.D[1], X23
    FMOV  D28, X4
    FMOV  V28.D[1], X28
    FMOV  D29, X14
    FMOV  V29.D[1], X25
    FMOV  D30, X2
    FMOV  V30.D[1], X28
    FMOV  D31, X11
    FMOV  V31.D[1], X15
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X11, #0x40, LSL #0
    MOVZ  X13, #0xf00, LSL #0
    ADD  X15, X30, X13, ASR #0
    ST2 { V25.2D, V26.2D }, [X15]
    LD2 { V31.2D, V0.2D }, [X15]
    ADD  X15, X15, X11, ASR #0
    ST2 { V9.16B, V10.16B }, [X15]
    LD2 { V15.16B, V16.16B }, [X15]
    ADD  X15, X15, X11, ASR #0
    ST2 { V27.2D, V28.2D }, [X15]
    LD2 { V24.2D, V25.2D }, [X15]
    ADD  X15, X15, X11
    ST2 { V30.4S, V31.4S }, [X15]
    LD2 { V0.4S, V1.4S }, [X15]
    ADD  X15, X15, X11
    ST2 { V23.8H, V24.8H }, [X15]
    LD2 { V27.8H, V28.8H }, [X15]
    ADD  X15, X15, X11, ASR #0
    ST2 { V23.2S, V24.2S }, [X15]
    LD2 { V15.4H, V16.4H }, [X15]
    ADD  X15, X15, X11, ASR #0
    ST2 { V15.2S, V16.2S }, [X15]
    LD2 { V29.2S, V30.2S }, [X15]
    ADD  X15, X15, X11, LSR #0
    ST2 { V0.4H, V1.4H }, [X15]
    LD2 { V23.4H, V24.4H }, [X15]
    ADD  X15, X15, X11
    ST2 { V23.8B, V24.8B }, [X15]
    LD2 { V7.8B, V8.8B }, [X15]
    ADD  X15, X15, X11, LSR #0
    MOV  X3, X15
    ST2 { V29.2D, V30.2D }, [X3], #32
    MOV  X3, X15
    LD2 { V14.8H, V15.8H }, [X3], #32
    ADD  X15, X15, X11
    MOV  X3, X15
    ST2 { V15.16B, V16.16B }, [X3], #32
    MOV  X3, X15
    LD2 { V24.16B, V25.16B }, [X3], #32
    ADD  X15, X15, X11
    MOV  X3, X15
    ST2 { V24.2D, V25.2D }, [X3], #32
    MOV  X3, X15
    LD2 { V19.2D, V20.2D }, [X3], #32
    ADD  X15, X15, X11, ASR #0
    MOV  X3, X15
    ST2 { V3.4S, V4.4S }, [X3], #32
    MOV  X3, X15
    LD2 { V0.4S, V1.4S }, [X3], #32
    ADD  X15, X15, X11, ASR #0
    MOV  X3, X15
    ST2 { V3.8H, V4.8H }, [X3], #32
    MOV  X3, X15
    LD2 { V10.8H, V11.8H }, [X3], #32
    ADD  X15, X15, X11, ASR #0
    MOV  X3, X15
    ST2 { V28.2S, V29.2S }, [X3], #16
    MOV  X3, X15
    LD2 { V20.2S, V21.2S }, [X3], #16
    ADD  X15, X15, X11, LSR #0
    MOV  X3, X15
    ST2 { V10.2S, V11.2S }, [X3], #16
    MOV  X3, X15
    LD2 { V21.2S, V22.2S }, [X3], #16
    ADD  X15, X15, X11
    MOV  X3, X15
    ST2 { V25.4H, V26.4H }, [X3], #16
    MOV  X3, X15
    LD2 { V24.4H, V25.4H }, [X3], #16
    ADD  X15, X15, X11, LSR #0
    MOV  X3, X15
    ST2 { V8.8B, V9.8B }, [X3], #16
    MOV  X3, X15
    LD2 { V6.8B, V7.8B }, [X3], #16
    ADD  X15, X15, X11, ASR #0
    ST2 { V20.4S, V21.4S }, [X15], X8
    LD2 { V7.16B, V8.16B }, [X15], X8
    ADD  X15, X15, X11
    ST2 { V6.16B, V7.16B }, [X15], X8
    LD2 { V2.16B, V3.16B }, [X15], X8
    ADD  X15, X15, X11, ASR #0
    ST2 { V2.2D, V3.2D }, [X15], X8
    LD2 { V0.2D, V1.2D }, [X15], X8
    ADD  X15, X15, X11, LSR #0
    ST2 { V0.4S, V1.4S }, [X15], X8
    LD2 { V1.4S, V2.4S }, [X15], X8
    ADD  X15, X15, X11
    ST2 { V4.8H, V5.8H }, [X15], X8
    LD2 { V29.8H, V30.8H }, [X15], X8
    ADD  X15, X15, X11
    ST2 { V30.4H, V31.4H }, [X15], X8
    LD2 { V26.4H, V27.4H }, [X15], X8
    ADD  X15, X15, X11, ASR #0
    ST2 { V13.2S, V14.2S }, [X15], X8
    LD2 { V31.2S, V0.2S }, [X15], X8
    ADD  X15, X15, X11, ASR #0
    ST2 { V0.4H, V1.4H }, [X15], X8
    LD2 { V4.4H, V5.4H }, [X15], X8
    ADD  X15, X15, X11, ASR #0
    ST2 { V4.8B, V5.8B }, [X15], X8
    LD2 { V14.8B, V15.8B }, [X15], X8
    ADD  X15, X15, X11, ASR #0
    ST2 { V14.H, V15.H }[0x1], [X15]
    LD2 { V2.H, V3.H }[0x2], [X15]
    ADD  X15, X15, X11, ASR #0
    ST2 { V2.S, V3.S }[0x2], [X15]
    LD2 { V3.S, V4.S }[0x0], [X15]
    ADD  X15, X15, X11, ASR #0
    ST2 { V29.D, V30.D }[0x0], [X15]
    LD2 { V22.D, V23.D }[0x1], [X15]
    ADD  X15, X15, X11
    ST2 { V31.B, V0.B }[0xf], [X15]
    LD2 { V13.B, V14.B }[0xd], [X15]
    ADD  X15, X15, X11, LSR #0
    MOV  X3, X15
    ST2 { V13.H, V14.H }[0x6], [X3], #4
    MOV  X3, X15
    LD2 { V2.H, V3.H }[0x3], [X3], #4
    ADD  X15, X15, X11, LSR #0
    ST2 { V21.H, V22.H }[0x5], [X15], X8
    LD2 { V21.H, V22.H }[0x4], [X15], X8
    ADD  X15, X15, X11
    MOV  X3, X15
    ST2 { V22.S, V23.S }[0x1], [X3], #8
    MOV  X3, X15
    LD2 { V29.S, V30.S }[0x2], [X3], #8
    ADD  X15, X15, X11, LSR #0
    ST2 { V2.S, V3.S }[0x3], [X15], X8
    LD2 { V22.S, V23.S }[0x0], [X15], X8
    ADD  X15, X15, X11
    MOV  X3, X15
    ST2 { V21.D, V22.D }[0x0], [X3], #16
    MOV  X3, X15
    LD2 { V15.D, V16.D }[0x0], [X3], #16
    ADD  X15, X15, X11
    ST2 { V15.D, V16.D }[0x0], [X15], X8
    LD2 { V21.D, V22.D }[0x0], [X15], X8
    ADD  X15, X15, X11, ASR #0
    MOV  X3, X15
    ST2 { V1.B, V2.B }[0xa], [X3], #2
    MOV  X3, X15
    LD2 { V16.B, V17.B }[0x6], [X3], #2
    ADD  X15, X15, X11
    ST2 { V29.B, V30.B }[0x1], [X15], X8
    LD2 { V2.B, V3.B }[0x3], [X15], X8
    ADD  X15, X15, X11, LSR #0
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X2, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MRS  X26, FPSR
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V0.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D0
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V1.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D1
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D2
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D3
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0xa500, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D4
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D5
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D6
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D7
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D8
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D9
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D10
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V11.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D11
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D12
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D13
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D14
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D15
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D16
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa500, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D17
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa500, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D18
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D19
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D20
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D21
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D22
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D23
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D24
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D25
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V26.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D26
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D27
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D28
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D29
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V30.D[1]
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D30
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V31.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D31
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
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
    FMOV  V0.D[1], X13
    FMOV  D1, X29
    FMOV  V1.D[1], X10
    FMOV  D2, X26
    FMOV  V2.D[1], X12
    FMOV  D3, X28
    FMOV  V3.D[1], X23
    FMOV  D4, X23
    FMOV  V4.D[1], X23
    FMOV  D5, X6
    FMOV  V5.D[1], X23
    FMOV  D6, X4
    FMOV  V6.D[1], X8
    FMOV  D7, X17
    FMOV  V7.D[1], X25
    FMOV  D8, X26
    FMOV  V8.D[1], X12
    FMOV  D9, X17
    FMOV  V9.D[1], X29
    FMOV  D10, X28
    FMOV  V10.D[1], X16
    FMOV  D11, X28
    FMOV  V11.D[1], X28
    FMOV  D12, X8
    FMOV  V12.D[1], X9
    FMOV  D13, X9
    FMOV  V13.D[1], X2
    FMOV  D14, X7
    FMOV  V14.D[1], X13
    FMOV  D15, X16
    FMOV  V15.D[1], X24
    FMOV  D16, X2
    FMOV  V16.D[1], X4
    FMOV  D17, X29
    FMOV  V17.D[1], X8
    FMOV  D18, X23
    FMOV  V18.D[1], X23
    FMOV  D19, X3
    FMOV  V19.D[1], X15
    FMOV  D20, X17
    FMOV  V20.D[1], X24
    FMOV  D21, X13
    FMOV  V21.D[1], X27
    FMOV  D22, X5
    FMOV  V22.D[1], X24
    FMOV  D23, X7
    FMOV  V23.D[1], X13
    FMOV  D24, X16
    FMOV  V24.D[1], X2
    FMOV  D25, X8
    FMOV  V25.D[1], X13
    FMOV  D26, X10
    FMOV  V26.D[1], X26
    FMOV  D27, X11
    FMOV  V27.D[1], X28
    FMOV  D28, X6
    FMOV  V28.D[1], X15
    FMOV  D29, X28
    FMOV  V29.D[1], X9
    FMOV  D30, X2
    FMOV  V30.D[1], X13
    FMOV  D31, X13
    FMOV  V31.D[1], X8
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X25, #0x40, LSL #0
    MOVZ  X3, #0x1400, LSL #0
    ADD  X17, X30, X3, LSR #0
    ST2 { V29.16B, V30.16B }, [X17]
    LD2 { V24.4S, V25.4S }, [X17]
    ADD  X17, X17, X25, ASR #0
    ST2 { V10.16B, V11.16B }, [X17]
    LD2 { V30.16B, V31.16B }, [X17]
    ADD  X17, X17, X25, ASR #0
    ST2 { V30.2D, V31.2D }, [X17]
    LD2 { V8.2D, V9.2D }, [X17]
    ADD  X17, X17, X25, ASR #0
    ST2 { V6.4S, V7.4S }, [X17]
    LD2 { V1.4S, V2.4S }, [X17]
    ADD  X17, X17, X25, LSR #0
    ST2 { V3.8H, V4.8H }, [X17]
    LD2 { V23.8H, V24.8H }, [X17]
    ADD  X17, X17, X25, LSR #0
    ST2 { V18.2S, V19.2S }, [X17]
    LD2 { V24.8B, V25.8B }, [X17]
    ADD  X17, X17, X25
    ST2 { V8.2S, V9.2S }, [X17]
    LD2 { V20.2S, V21.2S }, [X17]
    ADD  X17, X17, X25
    ST2 { V31.4H, V0.4H }, [X17]
    LD2 { V7.4H, V8.4H }, [X17]
    ADD  X17, X17, X25, ASR #0
    ST2 { V7.8B, V8.8B }, [X17]
    LD2 { V7.8B, V8.8B }, [X17]
    ADD  X17, X17, X25, ASR #0
    MOV  X14, X17
    ST2 { V1.8H, V2.8H }, [X14], #32
    MOV  X14, X17
    LD2 { V31.16B, V0.16B }, [X14], #32
    ADD  X17, X17, X25, LSR #0
    MOV  X14, X17
    ST2 { V11.16B, V12.16B }, [X14], #32
    MOV  X14, X17
    LD2 { V11.16B, V12.16B }, [X14], #32
    ADD  X17, X17, X25, ASR #0
    MOV  X14, X17
    ST2 { V13.2D, V14.2D }, [X14], #32
    MOV  X14, X17
    LD2 { V13.2D, V14.2D }, [X14], #32
    ADD  X17, X17, X25
    MOV  X14, X17
    ST2 { V7.4S, V8.4S }, [X14], #32
    MOV  X14, X17
    LD2 { V16.4S, V17.4S }, [X14], #32
    ADD  X17, X17, X25
    MOV  X14, X17
    ST2 { V27.8H, V28.8H }, [X14], #32
    MOV  X14, X17
    LD2 { V0.8H, V1.8H }, [X14], #32
    ADD  X17, X17, X25
    MOV  X14, X17
    ST2 { V13.8B, V14.8B }, [X14], #16
    MOV  X14, X17
    LD2 { V27.8B, V28.8B }, [X14], #16
    ADD  X17, X17, X25, ASR #0
    MOV  X14, X17
    ST2 { V6.2S, V7.2S }, [X14], #16
    MOV  X14, X17
    LD2 { V13.2S, V14.2S }, [X14], #16
    ADD  X17, X17, X25, LSR #0
    MOV  X14, X17
    ST2 { V13.4H, V14.4H }, [X14], #16
    MOV  X14, X17
    LD2 { V23.4H, V24.4H }, [X14], #16
    ADD  X17, X17, X25, LSR #0
    MOV  X14, X17
    ST2 { V23.8B, V24.8B }, [X14], #16
    MOV  X14, X17
    LD2 { V1.8B, V2.8B }, [X14], #16
    ADD  X17, X17, X25
    ST2 { V27.16B, V28.16B }, [X17], X10
    LD2 { V6.4S, V7.4S }, [X17], X10
    ADD  X17, X17, X25, ASR #0
    ST2 { V16.16B, V17.16B }, [X17], X10
    LD2 { V23.16B, V24.16B }, [X17], X10
    ADD  X17, X17, X25, LSR #0
    ST2 { V7.2D, V8.2D }, [X17], X10
    LD2 { V7.2D, V8.2D }, [X17], X10
    ADD  X17, X17, X25, LSR #0
    ST2 { V30.4S, V31.4S }, [X17], X10
    LD2 { V15.4S, V16.4S }, [X17], X10
    ADD  X17, X17, X25
    ST2 { V26.8H, V27.8H }, [X17], X10
    LD2 { V26.8H, V27.8H }, [X17], X10
    ADD  X17, X17, X25, LSR #0
    ST2 { V23.4H, V24.4H }, [X17], X10
    LD2 { V6.2S, V7.2S }, [X17], X10
    ADD  X17, X17, X25
    ST2 { V1.2S, V2.2S }, [X17], X10
    LD2 { V23.2S, V24.2S }, [X17], X10
    ADD  X17, X17, X25, LSR #0
    ST2 { V6.4H, V7.4H }, [X17], X10
    LD2 { V24.4H, V25.4H }, [X17], X10
    ADD  X17, X17, X25
    ST2 { V26.8B, V27.8B }, [X17], X10
    LD2 { V2.8B, V3.8B }, [X17], X10
    ADD  X17, X17, X25
    ST2 { V23.H, V24.H }[0x2], [X17]
    LD2 { V7.H, V8.H }[0x0], [X17]
    ADD  X17, X17, X25, ASR #0
    ST2 { V7.S, V8.S }[0x1], [X17]
    LD2 { V7.S, V8.S }[0x2], [X17]
    ADD  X17, X17, X25, ASR #0
    ST2 { V2.D, V3.D }[0x0], [X17]
    LD2 { V1.D, V2.D }[0x0], [X17]
    ADD  X17, X17, X25, ASR #0
    ST2 { V12.B, V13.B }[0x3], [X17]
    LD2 { V12.B, V13.B }[0xb], [X17]
    ADD  X17, X17, X25, LSR #0
    MOV  X14, X17
    ST2 { V7.H, V8.H }[0x3], [X14], #4
    MOV  X14, X17
    LD2 { V7.H, V8.H }[0x0], [X14], #4
    ADD  X17, X17, X25, LSR #0
    ST2 { V7.H, V8.H }[0x2], [X17], X10
    LD2 { V23.H, V24.H }[0x4], [X17], X10
    ADD  X17, X17, X25
    MOV  X14, X17
    ST2 { V1.S, V2.S }[0x2], [X14], #8
    MOV  X14, X17
    LD2 { V26.S, V27.S }[0x2], [X14], #8
    ADD  X17, X17, X25, ASR #0
    ST2 { V7.S, V8.S }[0x2], [X17], X10
    LD2 { V7.S, V8.S }[0x0], [X17], X10
    ADD  X17, X17, X25, ASR #0
    MOV  X14, X17
    ST2 { V26.D, V27.D }[0x1], [X14], #16
    MOV  X14, X17
    LD2 { V26.D, V27.D }[0x0], [X14], #16
    ADD  X17, X17, X25
    ST2 { V23.D, V24.D }[0x1], [X17], X10
    LD2 { V23.D, V24.D }[0x0], [X17], X10
    ADD  X17, X17, X25, ASR #0
    MOV  X14, X17
    ST2 { V21.B, V22.B }[0x7], [X14], #2
    MOV  X14, X17
    LD2 { V21.B, V22.B }[0xe], [X14], #2
    ADD  X17, X17, X25, LSR #0
    ST2 { V4.B, V5.B }[0x6], [X17], X10
    LD2 { V7.B, V8.B }[0x2], [X17], X10
    ADD  X17, X17, X25, LSR #0
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X15, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP05_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X15, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP05_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X15, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP05_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X15, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP05_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X15, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP05_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X15, X9, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP05_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP05_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X15, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP05_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X15, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP05_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X15, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP05_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X15, X9, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP05_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X15, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP05_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X15, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP05_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X15, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP05_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X15, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP05_TestFail
    MRS  X9, FPSR
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V0.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D0
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V1.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D1
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D2
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D3
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D4
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V5.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D5
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D6
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V7.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D7
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D8
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V9.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D9
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D10
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V11.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D11
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V12.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D12
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V13.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x5a00, LSL #16
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D13
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D14
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D15
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D16
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V17.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D17
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V18.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D18
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V19.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D19
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V20.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D20
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D21
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V22.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D22
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D23
    MOVZ  X15, #0x5a5a, LSL #0
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V24.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D24
    MOVZ  X15, #0x5a5a, LSL #0
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D25
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D26
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V27.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D27
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V28.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D28
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D29
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V30.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D30
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, V31.D[1]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X9, D31
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
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
    FMOV  D0, X29
    FMOV  V0.D[1], X25
    FMOV  D1, X28
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X3
    FMOV  D3, X10
    FMOV  V3.D[1], X25
    FMOV  D4, X4
    FMOV  V4.D[1], X17
    FMOV  D5, X27
    FMOV  V5.D[1], X3
    FMOV  D6, X16
    FMOV  V6.D[1], X9
    FMOV  D7, X16
    FMOV  V7.D[1], X25
    FMOV  D8, X8
    FMOV  V8.D[1], X15
    FMOV  D9, X29
    FMOV  V9.D[1], X14
    FMOV  D10, X23
    FMOV  V10.D[1], X28
    FMOV  D11, X12
    FMOV  V11.D[1], X17
    FMOV  D12, X15
    FMOV  V12.D[1], X10
    FMOV  D13, X3
    FMOV  V13.D[1], X12
    FMOV  D14, X12
    FMOV  V14.D[1], X3
    FMOV  D15, X11
    FMOV  V15.D[1], X11
    FMOV  D16, X12
    FMOV  V16.D[1], X7
    FMOV  D17, X6
    FMOV  V17.D[1], X5
    FMOV  D18, X8
    FMOV  V18.D[1], X2
    FMOV  D19, X16
    FMOV  V19.D[1], X27
    FMOV  D20, X5
    FMOV  V20.D[1], X25
    FMOV  D21, X16
    FMOV  V21.D[1], X8
    FMOV  D22, X4
    FMOV  V22.D[1], X9
    FMOV  D23, X11
    FMOV  V23.D[1], X12
    FMOV  D24, X9
    FMOV  V24.D[1], X29
    FMOV  D25, X12
    FMOV  V25.D[1], X10
    FMOV  D26, X12
    FMOV  V26.D[1], X9
    FMOV  D27, X5
    FMOV  V27.D[1], X9
    FMOV  D28, X4
    FMOV  V28.D[1], X28
    FMOV  D29, X11
    FMOV  V29.D[1], X23
    FMOV  D30, X5
    FMOV  V30.D[1], X23
    FMOV  D31, X13
    FMOV  V31.D[1], X8
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X16, #0x40, LSL #0
    MOVZ  X13, #0x1900, LSL #0
    ADD  X2, X30, X13
    ST2 { V30.8H, V31.8H }, [X2]
    LD2 { V8.4S, V9.4S }, [X2]
    ADD  X2, X2, X16, LSR #0
    ST2 { V14.16B, V15.16B }, [X2]
    LD2 { V18.16B, V19.16B }, [X2]
    ADD  X2, X2, X16, LSR #0
    ST2 { V19.2D, V20.2D }, [X2]
    LD2 { V25.2D, V26.2D }, [X2]
    ADD  X2, X2, X16
    ST2 { V8.4S, V9.4S }, [X2]
    LD2 { V29.4S, V30.4S }, [X2]
    ADD  X2, X2, X16, ASR #0
    ST2 { V8.8H, V9.8H }, [X2]
    LD2 { V5.8H, V6.8H }, [X2]
    ADD  X2, X2, X16
    ST2 { V29.8B, V30.8B }, [X2]
    LD2 { V19.4H, V20.4H }, [X2]
    ADD  X2, X2, X16, ASR #0
    ST2 { V18.2S, V19.2S }, [X2]
    LD2 { V21.2S, V22.2S }, [X2]
    ADD  X2, X2, X16
    ST2 { V8.4H, V9.4H }, [X2]
    LD2 { V28.4H, V29.4H }, [X2]
    ADD  X2, X2, X16, ASR #0
    ST2 { V25.8B, V26.8B }, [X2]
    LD2 { V2.8B, V3.8B }, [X2]
    ADD  X2, X2, X16, LSR #0
    MOV  X4, X2
    ST2 { V21.2D, V22.2D }, [X4], #32
    MOV  X4, X2
    LD2 { V1.16B, V2.16B }, [X4], #32
    ADD  X2, X2, X16, LSR #0
    MOV  X4, X2
    ST2 { V30.16B, V31.16B }, [X4], #32
    MOV  X4, X2
    LD2 { V0.16B, V1.16B }, [X4], #32
    ADD  X2, X2, X16, ASR #0
    MOV  X4, X2
    ST2 { V12.2D, V13.2D }, [X4], #32
    MOV  X4, X2
    LD2 { V31.2D, V0.2D }, [X4], #32
    ADD  X2, X2, X16
    MOV  X4, X2
    ST2 { V31.4S, V0.4S }, [X4], #32
    MOV  X4, X2
    LD2 { V23.4S, V24.4S }, [X4], #32
    ADD  X2, X2, X16, ASR #0
    MOV  X4, X2
    ST2 { V1.8H, V2.8H }, [X4], #32
    MOV  X4, X2
    LD2 { V24.8H, V25.8H }, [X4], #32
    ADD  X2, X2, X16, ASR #0
    MOV  X4, X2
    ST2 { V7.4H, V8.4H }, [X4], #16
    MOV  X4, X2
    LD2 { V24.2S, V25.2S }, [X4], #16
    ADD  X2, X2, X16, ASR #0
    MOV  X4, X2
    ST2 { V13.2S, V14.2S }, [X4], #16
    MOV  X4, X2
    LD2 { V28.2S, V29.2S }, [X4], #16
    ADD  X2, X2, X16, LSR #0
    MOV  X4, X2
    ST2 { V28.4H, V29.4H }, [X4], #16
    MOV  X4, X2
    LD2 { V13.4H, V14.4H }, [X4], #16
    ADD  X2, X2, X16, ASR #0
    MOV  X4, X2
    ST2 { V24.8B, V25.8B }, [X4], #16
    MOV  X4, X2
    LD2 { V15.8B, V16.8B }, [X4], #16
    ADD  X2, X2, X16, LSR #0
    ST2 { V3.16B, V4.16B }, [X2], X25
    LD2 { V8.2D, V9.2D }, [X2], X25
    ADD  X2, X2, X16
    ST2 { V4.16B, V5.16B }, [X2], X25
    LD2 { V13.16B, V14.16B }, [X2], X25
    ADD  X2, X2, X16, ASR #0
    ST2 { V29.2D, V30.2D }, [X2], X25
    LD2 { V0.2D, V1.2D }, [X2], X25
    ADD  X2, X2, X16
    ST2 { V15.4S, V16.4S }, [X2], X25
    LD2 { V5.4S, V6.4S }, [X2], X25
    ADD  X2, X2, X16
    ST2 { V8.8H, V9.8H }, [X2], X25
    LD2 { V13.8H, V14.8H }, [X2], X25
    ADD  X2, X2, X16, ASR #0
    ST2 { V5.4H, V6.4H }, [X2], X25
    LD2 { V19.2S, V20.2S }, [X2], X25
    ADD  X2, X2, X16, LSR #0
    ST2 { V19.2S, V20.2S }, [X2], X25
    LD2 { V15.2S, V16.2S }, [X2], X25
    ADD  X2, X2, X16
    ST2 { V0.4H, V1.4H }, [X2], X25
    LD2 { V24.4H, V25.4H }, [X2], X25
    ADD  X2, X2, X16, ASR #0
    ST2 { V14.8B, V15.8B }, [X2], X25
    LD2 { V8.8B, V9.8B }, [X2], X25
    ADD  X2, X2, X16, ASR #0
    ST2 { V20.H, V21.H }[0x5], [X2]
    LD2 { V14.H, V15.H }[0x2], [X2]
    ADD  X2, X2, X16
    ST2 { V6.S, V7.S }[0x0], [X2]
    LD2 { V0.S, V1.S }[0x1], [X2]
    ADD  X2, X2, X16, LSR #0
    ST2 { V8.D, V9.D }[0x1], [X2]
    LD2 { V2.D, V3.D }[0x0], [X2]
    ADD  X2, X2, X16, LSR #0
    ST2 { V2.B, V3.B }[0x5], [X2]
    LD2 { V2.B, V3.B }[0xe], [X2]
    ADD  X2, X2, X16, ASR #0
    MOV  X4, X2
    ST2 { V6.H, V7.H }[0x4], [X4], #4
    MOV  X4, X2
    LD2 { V24.H, V25.H }[0x0], [X4], #4
    ADD  X2, X2, X16, LSR #0
    ST2 { V24.H, V25.H }[0x5], [X2], X25
    LD2 { V8.H, V9.H }[0x4], [X2], X25
    ADD  X2, X2, X16
    MOV  X4, X2
    ST2 { V20.S, V21.S }[0x3], [X4], #8
    MOV  X4, X2
    LD2 { V14.S, V15.S }[0x1], [X4], #8
    ADD  X2, X2, X16, ASR #0
    ST2 { V12.S, V13.S }[0x2], [X2], X25
    LD2 { V6.S, V7.S }[0x0], [X2], X25
    ADD  X2, X2, X16, LSR #0
    MOV  X4, X2
    ST2 { V30.D, V31.D }[0x1], [X4], #16
    MOV  X4, X2
    LD2 { V30.D, V31.D }[0x1], [X4], #16
    ADD  X2, X2, X16, LSR #0
    ST2 { V16.D, V17.D }[0x0], [X2], X25
    LD2 { V24.D, V25.D }[0x1], [X2], X25
    ADD  X2, X2, X16, LSR #0
    MOV  X4, X2
    ST2 { V30.B, V31.B }[0x5], [X4], #2
    MOV  X4, X2
    LD2 { V20.B, V21.B }[0x3], [X4], #2
    ADD  X2, X2, X16, LSR #0
    ST2 { V24.B, V25.B }[0x9], [X2], X25
    LD2 { V5.B, V6.B }[0xb], [X2], X25
    ADD  X2, X2, X16, ASR #0
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X26, X3, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X26, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X26, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X26, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X26, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X26, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X26, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X26, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X26, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X26, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X26, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X26, X3, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X26, X3, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X26, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X26, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MRS  X3, FPSR
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V0.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D0
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V1.D[1]
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D1
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V2.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D2
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V3.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D3
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V4.D[1]
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D4
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0xa500, LSL #16
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D5
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V6.D[1]
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0xa500, LSL #16
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D6
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D7
    MOVZ  X26, #0xa500, LSL #0
    MOVK  X26, #0xa500, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D8
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V9.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D9
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D10
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V11.D[1]
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D11
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V12.D[1]
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D12
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V13.D[1]
    MOVZ  X26, #0xa500, LSL #0
    MOVK  X26, #0xa500, LSL #16
    MOVK  X26, #0xa500, LSL #32
    MOVK  X26, #0xa500, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D13
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V14.D[1]
    MOVZ  X26, #0xa500, LSL #0
    MOVK  X26, #0xa500, LSL #16
    MOVK  X26, #0xa500, LSL #32
    MOVK  X26, #0xa500, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D14
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V15.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D15
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V16.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D16
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V17.D[1]
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D17
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V18.D[1]
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D18
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D19
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V20.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D20
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V21.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D21
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V22.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D22
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V23.D[1]
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D23
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V24.D[1]
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D24
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D25
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V26.D[1]
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D26
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V27.D[1]
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D27
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D28
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V29.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D29
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V30.D[1]
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D30
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, V31.D[1]
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    FMOV  X3, D31
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X12, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
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
    FMOV  D0, X23
    FMOV  V0.D[1], X3
    FMOV  D1, X14
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X26
    FMOV  D3, X29
    FMOV  V3.D[1], X17
    FMOV  D4, X28
    FMOV  V4.D[1], X5
    FMOV  D5, X28
    FMOV  V5.D[1], X23
    FMOV  D6, X6
    FMOV  V6.D[1], X14
    FMOV  D7, X5
    FMOV  V7.D[1], X15
    FMOV  D8, X28
    FMOV  V8.D[1], X5
    FMOV  D9, X7
    FMOV  V9.D[1], X23
    FMOV  D10, X6
    FMOV  V10.D[1], X2
    FMOV  D11, X3
    FMOV  V11.D[1], X27
    FMOV  D12, X28
    FMOV  V12.D[1], X12
    FMOV  D13, X7
    FMOV  V13.D[1], X24
    FMOV  D14, X27
    FMOV  V14.D[1], X6
    FMOV  D15, X3
    FMOV  V15.D[1], X24
    FMOV  D16, X3
    FMOV  V16.D[1], X12
    FMOV  D17, X7
    FMOV  V17.D[1], X11
    FMOV  D18, X26
    FMOV  V18.D[1], X3
    FMOV  D19, X23
    FMOV  V19.D[1], X27
    FMOV  D20, X17
    FMOV  V20.D[1], X25
    FMOV  D21, X8
    FMOV  V21.D[1], X7
    FMOV  D22, X9
    FMOV  V22.D[1], X25
    FMOV  D23, X13
    FMOV  V23.D[1], X5
    FMOV  D24, X2
    FMOV  V24.D[1], X28
    FMOV  D25, X9
    FMOV  V25.D[1], X10
    FMOV  D26, X17
    FMOV  V26.D[1], X27
    FMOV  D27, X13
    FMOV  V27.D[1], X10
    FMOV  D28, X13
    FMOV  V28.D[1], X9
    FMOV  D29, X14
    FMOV  V29.D[1], X7
    FMOV  D30, X23
    FMOV  V30.D[1], X16
    FMOV  D31, X28
    FMOV  V31.D[1], X26
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X28, #0x40, LSL #0
    MOVZ  X8, #0x1e00, LSL #0
    ADD  X29, X30, X8, ASR #0
    ST2 { V3.16B, V4.16B }, [X29]
    LD2 { V5.4S, V6.4S }, [X29]
    ADD  X29, X29, X28, LSR #0
    ST2 { V29.16B, V30.16B }, [X29]
    LD2 { V5.16B, V6.16B }, [X29]
    ADD  X29, X29, X28
    ST2 { V3.2D, V4.2D }, [X29]
    LD2 { V1.2D, V2.2D }, [X29]
    ADD  X29, X29, X28
    ST2 { V5.4S, V6.4S }, [X29]
    LD2 { V5.4S, V6.4S }, [X29]
    ADD  X29, X29, X28, LSR #0
    ST2 { V15.8H, V16.8H }, [X29]
    LD2 { V24.8H, V25.8H }, [X29]
    ADD  X29, X29, X28, LSR #0
    ST2 { V24.2S, V25.2S }, [X29]
    LD2 { V14.4H, V15.4H }, [X29]
    ADD  X29, X29, X28, LSR #0
    ST2 { V14.2S, V15.2S }, [X29]
    LD2 { V1.2S, V2.2S }, [X29]
    ADD  X29, X29, X28, ASR #0
    ST2 { V1.4H, V2.4H }, [X29]
    LD2 { V23.4H, V24.4H }, [X29]
    ADD  X29, X29, X28
    ST2 { V7.8B, V8.8B }, [X29]
    LD2 { V18.8B, V19.8B }, [X29]
    ADD  X29, X29, X28
    MOV  X4, X29
    ST2 { V16.4S, V17.4S }, [X4], #32
    MOV  X4, X29
    LD2 { V18.8H, V19.8H }, [X4], #32
    ADD  X29, X29, X28
    MOV  X4, X29
    ST2 { V23.16B, V24.16B }, [X4], #32
    MOV  X4, X29
    LD2 { V30.16B, V31.16B }, [X4], #32
    ADD  X29, X29, X28, ASR #0
    MOV  X4, X29
    ST2 { V10.2D, V11.2D }, [X4], #32
    MOV  X4, X29
    LD2 { V23.2D, V24.2D }, [X4], #32
    ADD  X29, X29, X28, ASR #0
    MOV  X4, X29
    ST2 { V6.4S, V7.4S }, [X4], #32
    MOV  X4, X29
    LD2 { V2.4S, V3.4S }, [X4], #32
    ADD  X29, X29, X28
    MOV  X4, X29
    ST2 { V23.8H, V24.8H }, [X4], #32
    MOV  X4, X29
    LD2 { V18.8H, V19.8H }, [X4], #32
    ADD  X29, X29, X28, LSR #0
    MOV  X4, X29
    ST2 { V2.2S, V3.2S }, [X4], #16
    MOV  X4, X29
    LD2 { V11.4H, V12.4H }, [X4], #16
    ADD  X29, X29, X28
    MOV  X4, X29
    ST2 { V18.2S, V19.2S }, [X4], #16
    MOV  X4, X29
    LD2 { V18.2S, V19.2S }, [X4], #16
    ADD  X29, X29, X28, LSR #0
    MOV  X4, X29
    ST2 { V18.4H, V19.4H }, [X4], #16
    MOV  X4, X29
    LD2 { V23.4H, V24.4H }, [X4], #16
    ADD  X29, X29, X28
    MOV  X4, X29
    ST2 { V12.8B, V13.8B }, [X4], #16
    MOV  X4, X29
    LD2 { V18.8B, V19.8B }, [X4], #16
    ADD  X29, X29, X28, LSR #0
    ST2 { V28.16B, V29.16B }, [X29], X2
    LD2 { V3.2D, V4.2D }, [X29], X2
    ADD  X29, X29, X28
    ST2 { V23.16B, V24.16B }, [X29], X2
    LD2 { V28.16B, V29.16B }, [X29], X2
    ADD  X29, X29, X28, LSR #0
    ST2 { V1.2D, V2.2D }, [X29], X2
    LD2 { V23.2D, V24.2D }, [X29], X2
    ADD  X29, X29, X28, LSR #0
    ST2 { V23.4S, V24.4S }, [X29], X2
    LD2 { V24.4S, V25.4S }, [X29], X2
    ADD  X29, X29, X28, LSR #0
    ST2 { V24.8H, V25.8H }, [X29], X2
    LD2 { V1.8H, V2.8H }, [X29], X2
    ADD  X29, X29, X28, ASR #0
    ST2 { V3.2S, V4.2S }, [X29], X2
    LD2 { V9.8B, V10.8B }, [X29], X2
    ADD  X29, X29, X28, LSR #0
    ST2 { V3.2S, V4.2S }, [X29], X2
    LD2 { V2.2S, V3.2S }, [X29], X2
    ADD  X29, X29, X28, LSR #0
    ST2 { V2.4H, V3.4H }, [X29], X2
    LD2 { V3.4H, V4.4H }, [X29], X2
    ADD  X29, X29, X28
    ST2 { V9.8B, V10.8B }, [X29], X2
    LD2 { V24.8B, V25.8B }, [X29], X2
    ADD  X29, X29, X28
    ST2 { V2.H, V3.H }[0x4], [X29]
    LD2 { V9.H, V10.H }[0x4], [X29]
    ADD  X29, X29, X28, ASR #0
    ST2 { V9.S, V10.S }[0x2], [X29]
    LD2 { V6.S, V7.S }[0x0], [X29]
    ADD  X29, X29, X28
    ST2 { V24.D, V25.D }[0x0], [X29]
    LD2 { V30.D, V31.D }[0x1], [X29]
    ADD  X29, X29, X28
    ST2 { V6.B, V7.B }[0xd], [X29]
    LD2 { V3.B, V4.B }[0x6], [X29]
    ADD  X29, X29, X28, ASR #0
    MOV  X4, X29
    ST2 { V3.H, V4.H }[0x3], [X4], #4
    MOV  X4, X29
    LD2 { V26.H, V27.H }[0x0], [X4], #4
    ADD  X29, X29, X28, ASR #0
    ST2 { V26.H, V27.H }[0x1], [X29], X2
    LD2 { V7.H, V8.H }[0x6], [X29], X2
    ADD  X29, X29, X28, ASR #0
    MOV  X4, X29
    ST2 { V7.S, V8.S }[0x0], [X4], #8
    MOV  X4, X29
    LD2 { V9.S, V10.S }[0x1], [X4], #8
    ADD  X29, X29, X28
    ST2 { V9.S, V10.S }[0x3], [X29], X2
    LD2 { V26.S, V27.S }[0x0], [X29], X2
    ADD  X29, X29, X28, ASR #0
    MOV  X4, X29
    ST2 { V25.D, V26.D }[0x0], [X4], #16
    MOV  X4, X29
    LD2 { V0.D, V1.D }[0x1], [X4], #16
    ADD  X29, X29, X28, LSR #0
    ST2 { V0.D, V1.D }[0x1], [X29], X2
    LD2 { V4.D, V5.D }[0x1], [X29], X2
    ADD  X29, X29, X28, ASR #0
    MOV  X4, X29
    ST2 { V20.B, V21.B }[0xd], [X4], #2
    MOV  X4, X29
    LD2 { V25.B, V26.B }[0xd], [X4], #2
    ADD  X29, X29, X28
    ST2 { V24.B, V25.B }[0xe], [X29], X2
    LD2 { V0.B, V1.B }[0x4], [X29], X2
    ADD  X29, X29, X28
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X9, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X9, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X9, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X9, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X9, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X9, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X9, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X9, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X9, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X9, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X9, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X9, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X9, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X9, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    MRS  X12, FPSR
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V0.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D0
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a00, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V1.D[1]
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D1
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a00, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D2
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D3
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D4
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D5
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D6
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D7
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D8
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D9
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D10
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D11
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V12.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D12
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D13
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D14
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D15
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D16
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D17
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D18
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D19
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D20
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D21
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D22
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D23
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D24
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x5a00, LSL #32
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D25
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D26
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D27
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D28
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D29
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V30.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D30
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V31.D[1]
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D31
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
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
    FMOV  D0, X28
    FMOV  V0.D[1], X9
    FMOV  D1, X27
    FMOV  V1.D[1], X25
    FMOV  D2, X29
    FMOV  V2.D[1], X8
    FMOV  D3, X26
    FMOV  V3.D[1], X3
    FMOV  D4, X16
    FMOV  V4.D[1], X3
    FMOV  D5, X3
    FMOV  V5.D[1], X28
    FMOV  D6, X25
    FMOV  V6.D[1], X26
    FMOV  D7, X26
    FMOV  V7.D[1], X8
    FMOV  D8, X23
    FMOV  V8.D[1], X29
    FMOV  D9, X8
    FMOV  V9.D[1], X11
    FMOV  D10, X29
    FMOV  V10.D[1], X10
    FMOV  D11, X10
    FMOV  V11.D[1], X27
    FMOV  D12, X4
    FMOV  V12.D[1], X8
    FMOV  D13, X23
    FMOV  V13.D[1], X7
    FMOV  D14, X23
    FMOV  V14.D[1], X5
    FMOV  D15, X2
    FMOV  V15.D[1], X23
    FMOV  D16, X23
    FMOV  V16.D[1], X24
    FMOV  D17, X26
    FMOV  V17.D[1], X17
    FMOV  D18, X6
    FMOV  V18.D[1], X2
    FMOV  D19, X27
    FMOV  V19.D[1], X15
    FMOV  D20, X9
    FMOV  V20.D[1], X12
    FMOV  D21, X5
    FMOV  V21.D[1], X11
    FMOV  D22, X17
    FMOV  V22.D[1], X5
    FMOV  D23, X16
    FMOV  V23.D[1], X13
    FMOV  D24, X4
    FMOV  V24.D[1], X11
    FMOV  D25, X8
    FMOV  V25.D[1], X7
    FMOV  D26, X8
    FMOV  V26.D[1], X29
    FMOV  D27, X24
    FMOV  V27.D[1], X13
    FMOV  D28, X14
    FMOV  V28.D[1], X15
    FMOV  D29, X17
    FMOV  V29.D[1], X3
    FMOV  D30, X13
    FMOV  V30.D[1], X23
    FMOV  D31, X12
    FMOV  V31.D[1], X9
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X4, #0x40, LSL #0
    MOVZ  X9, #0x2300, LSL #0
    ADD  X25, X30, X9, ASR #0
    ST2 { V25.4S, V26.4S }, [X25]
    LD2 { V1.2D, V2.2D }, [X25]
    ADD  X25, X25, X4, LSR #0
    ST2 { V27.16B, V28.16B }, [X25]
    LD2 { V24.16B, V25.16B }, [X25]
    ADD  X25, X25, X4, LSR #0
    ST2 { V24.2D, V25.2D }, [X25]
    LD2 { V29.2D, V30.2D }, [X25]
    ADD  X25, X25, X4, LSR #0
    ST2 { V22.4S, V23.4S }, [X25]
    LD2 { V16.4S, V17.4S }, [X25]
    ADD  X25, X25, X4, LSR #0
    ST2 { V30.8H, V31.8H }, [X25]
    LD2 { V11.8H, V12.8H }, [X25]
    ADD  X25, X25, X4, LSR #0
    ST2 { V17.8B, V18.8B }, [X25]
    LD2 { V18.8B, V19.8B }, [X25]
    ADD  X25, X25, X4
    ST2 { V18.2S, V19.2S }, [X25]
    LD2 { V16.2S, V17.2S }, [X25]
    ADD  X25, X25, X4, ASR #0
    ST2 { V16.4H, V17.4H }, [X25]
    LD2 { V8.4H, V9.4H }, [X25]
    ADD  X25, X25, X4, ASR #0
    ST2 { V18.8B, V19.8B }, [X25]
    LD2 { V28.8B, V29.8B }, [X25]
    ADD  X25, X25, X4, ASR #0
    MOV  X8, X25
    ST2 { V1.2D, V2.2D }, [X8], #32
    MOV  X8, X25
    LD2 { V21.2D, V22.2D }, [X8], #32
    ADD  X25, X25, X4, ASR #0
    MOV  X8, X25
    ST2 { V8.16B, V9.16B }, [X8], #32
    MOV  X8, X25
    LD2 { V8.16B, V9.16B }, [X8], #32
    ADD  X25, X25, X4, ASR #0
    MOV  X8, X25
    ST2 { V18.2D, V19.2D }, [X8], #32
    MOV  X8, X25
    LD2 { V15.2D, V16.2D }, [X8], #32
    ADD  X25, X25, X4, LSR #0
    MOV  X8, X25
    ST2 { V4.4S, V5.4S }, [X8], #32
    MOV  X8, X25
    LD2 { V4.4S, V5.4S }, [X8], #32
    ADD  X25, X25, X4
    MOV  X8, X25
    ST2 { V15.8H, V16.8H }, [X8], #32
    MOV  X8, X25
    LD2 { V17.8H, V18.8H }, [X8], #32
    ADD  X25, X25, X4, LSR #0
    MOV  X8, X25
    ST2 { V15.8B, V16.8B }, [X8], #16
    MOV  X8, X25
    LD2 { V25.4H, V26.4H }, [X8], #16
    ADD  X25, X25, X4
    MOV  X8, X25
    ST2 { V4.2S, V5.2S }, [X8], #16
    MOV  X8, X25
    LD2 { V16.2S, V17.2S }, [X8], #16
    ADD  X25, X25, X4, LSR #0
    MOV  X8, X25
    ST2 { V27.4H, V28.4H }, [X8], #16
    MOV  X8, X25
    LD2 { V22.4H, V23.4H }, [X8], #16
    ADD  X25, X25, X4
    MOV  X8, X25
    ST2 { V15.8B, V16.8B }, [X8], #16
    MOV  X8, X25
    LD2 { V16.8B, V17.8B }, [X8], #16
    ADD  X25, X25, X4, LSR #0
    ST2 { V25.4S, V26.4S }, [X25], X26
    LD2 { V12.16B, V13.16B }, [X25], X26
    ADD  X25, X25, X4, LSR #0
    ST2 { V25.16B, V26.16B }, [X25], X26
    LD2 { V15.16B, V16.16B }, [X25], X26
    ADD  X25, X25, X4, ASR #0
    ST2 { V20.2D, V21.2D }, [X25], X26
    LD2 { V23.2D, V24.2D }, [X25], X26
    ADD  X25, X25, X4, ASR #0
    ST2 { V11.4S, V12.4S }, [X25], X26
    LD2 { V0.4S, V1.4S }, [X25], X26
    ADD  X25, X25, X4
    ST2 { V16.8H, V17.8H }, [X25], X26
    LD2 { V0.8H, V1.8H }, [X25], X26
    ADD  X25, X25, X4, LSR #0
    ST2 { V12.2S, V13.2S }, [X25], X26
    LD2 { V4.4H, V5.4H }, [X25], X26
    ADD  X25, X25, X4
    ST2 { V0.2S, V1.2S }, [X25], X26
    LD2 { V8.2S, V9.2S }, [X25], X26
    ADD  X25, X25, X4, ASR #0
    ST2 { V8.4H, V9.4H }, [X25], X26
    LD2 { V20.4H, V21.4H }, [X25], X26
    ADD  X25, X25, X4
    ST2 { V1.8B, V2.8B }, [X25], X26
    LD2 { V25.8B, V26.8B }, [X25], X26
    ADD  X25, X25, X4, LSR #0
    ST2 { V24.H, V25.H }[0x2], [X25]
    LD2 { V11.H, V12.H }[0x3], [X25]
    ADD  X25, X25, X4, LSR #0
    ST2 { V20.S, V21.S }[0x0], [X25]
    LD2 { V16.S, V17.S }[0x2], [X25]
    ADD  X25, X25, X4, ASR #0
    ST2 { V5.D, V6.D }[0x1], [X25]
    LD2 { V0.D, V1.D }[0x1], [X25]
    ADD  X25, X25, X4, ASR #0
    ST2 { V14.B, V15.B }[0x2], [X25]
    LD2 { V20.B, V21.B }[0x4], [X25]
    ADD  X25, X25, X4, LSR #0
    MOV  X8, X25
    ST2 { V7.H, V8.H }[0x0], [X8], #4
    MOV  X8, X25
    LD2 { V5.H, V6.H }[0x4], [X8], #4
    ADD  X25, X25, X4, LSR #0
    ST2 { V20.H, V21.H }[0x6], [X25], X26
    LD2 { V25.H, V26.H }[0x7], [X25], X26
    ADD  X25, X25, X4, ASR #0
    MOV  X8, X25
    ST2 { V0.S, V1.S }[0x1], [X8], #8
    MOV  X8, X25
    LD2 { V7.S, V8.S }[0x2], [X8], #8
    ADD  X25, X25, X4, ASR #0
    ST2 { V25.S, V26.S }[0x0], [X25], X26
    LD2 { V1.S, V2.S }[0x0], [X25], X26
    ADD  X25, X25, X4, LSR #0
    MOV  X8, X25
    ST2 { V29.D, V30.D }[0x1], [X8], #16
    MOV  X8, X25
    LD2 { V20.D, V21.D }[0x0], [X8], #16
    ADD  X25, X25, X4
    ST2 { V1.D, V2.D }[0x0], [X25], X26
    LD2 { V25.D, V26.D }[0x1], [X25], X26
    ADD  X25, X25, X4, ASR #0
    MOV  X8, X25
    ST2 { V29.B, V30.B }[0xd], [X8], #2
    MOV  X8, X25
    LD2 { V15.B, V16.B }[0xa], [X8], #2
    ADD  X25, X25, X4
    ST2 { V25.B, V26.B }[0xd], [X25], X26
    LD2 { V25.B, V26.B }[0x7], [X25], X26
    ADD  X25, X25, X4, ASR #0
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X12, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X12, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X12, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X12, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X12, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X12, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X12, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X12, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X12, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X12, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X12, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X12, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X12, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X12, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    MRS  X14, FPSR
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V0.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D0
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V1.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D1
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D2
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D3
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D4
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D5
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D6
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D7
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D8
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D9
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D10
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D11
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D12
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D13
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V14.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D14
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D15
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D16
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D17
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D18
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D19
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D20
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D21
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D22
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D23
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D24
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D25
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D26
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D27
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D28
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D29
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V30.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D30
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, V31.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X14, D31
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X23, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
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
    FMOV  V0.D[1], X29
    FMOV  D1, X28
    FMOV  V1.D[1], X26
    FMOV  D2, X11
    FMOV  V2.D[1], X29
    FMOV  D3, X5
    FMOV  V3.D[1], X14
    FMOV  D4, X27
    FMOV  V4.D[1], X2
    FMOV  D5, X10
    FMOV  V5.D[1], X3
    FMOV  D6, X11
    FMOV  V6.D[1], X14
    FMOV  D7, X14
    FMOV  V7.D[1], X15
    FMOV  D8, X13
    FMOV  V8.D[1], X11
    FMOV  D9, X7
    FMOV  V9.D[1], X5
    FMOV  D10, X3
    FMOV  V10.D[1], X27
    FMOV  D11, X12
    FMOV  V11.D[1], X26
    FMOV  D12, X13
    FMOV  V12.D[1], X27
    FMOV  D13, X12
    FMOV  V13.D[1], X13
    FMOV  D14, X27
    FMOV  V14.D[1], X6
    FMOV  D15, X28
    FMOV  V15.D[1], X5
    FMOV  D16, X13
    FMOV  V16.D[1], X27
    FMOV  D17, X23
    FMOV  V17.D[1], X17
    FMOV  D18, X23
    FMOV  V18.D[1], X14
    FMOV  D19, X6
    FMOV  V19.D[1], X25
    FMOV  D20, X29
    FMOV  V20.D[1], X2
    FMOV  D21, X12
    FMOV  V21.D[1], X13
    FMOV  D22, X10
    FMOV  V22.D[1], X7
    FMOV  D23, X3
    FMOV  V23.D[1], X23
    FMOV  D24, X9
    FMOV  V24.D[1], X8
    FMOV  D25, X15
    FMOV  V25.D[1], X12
    FMOV  D26, X9
    FMOV  V26.D[1], X9
    FMOV  D27, X28
    FMOV  V27.D[1], X2
    FMOV  D28, X9
    FMOV  V28.D[1], X29
    FMOV  D29, X14
    FMOV  V29.D[1], X29
    FMOV  D30, X26
    FMOV  V30.D[1], X24
    FMOV  D31, X24
    FMOV  V31.D[1], X9
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X28, #0x40, LSL #0
    MOVZ  X2, #0x2800, LSL #0
    ADD  X9, X30, X2
    ST2 { V4.8H, V5.8H }, [X9]
    LD2 { V11.2D, V12.2D }, [X9]
    ADD  X9, X9, X28
    ST2 { V6.16B, V7.16B }, [X9]
    LD2 { V12.16B, V13.16B }, [X9]
    ADD  X9, X9, X28, LSR #0
    ST2 { V12.2D, V13.2D }, [X9]
    LD2 { V27.2D, V28.2D }, [X9]
    ADD  X9, X9, X28
    ST2 { V27.4S, V28.4S }, [X9]
    LD2 { V28.4S, V29.4S }, [X9]
    ADD  X9, X9, X28, ASR #0
    ST2 { V28.8H, V29.8H }, [X9]
    LD2 { V6.8H, V7.8H }, [X9]
    ADD  X9, X9, X28, LSR #0
    ST2 { V6.2S, V7.2S }, [X9]
    LD2 { V4.4H, V5.4H }, [X9]
    ADD  X9, X9, X28
    ST2 { V4.2S, V5.2S }, [X9]
    LD2 { V7.2S, V8.2S }, [X9]
    ADD  X9, X9, X28, LSR #0
    ST2 { V17.4H, V18.4H }, [X9]
    LD2 { V20.4H, V21.4H }, [X9]
    ADD  X9, X9, X28, ASR #0
    ST2 { V21.8B, V22.8B }, [X9]
    LD2 { V22.8B, V23.8B }, [X9]
    ADD  X9, X9, X28
    MOV  X8, X9
    ST2 { V8.4S, V9.4S }, [X8], #32
    MOV  X8, X9
    LD2 { V5.8H, V6.8H }, [X8], #32
    ADD  X9, X9, X28, ASR #0
    MOV  X8, X9
    ST2 { V11.16B, V12.16B }, [X8], #32
    MOV  X8, X9
    LD2 { V3.16B, V4.16B }, [X8], #32
    ADD  X9, X9, X28
    MOV  X8, X9
    ST2 { V22.2D, V23.2D }, [X8], #32
    MOV  X8, X9
    LD2 { V23.2D, V24.2D }, [X8], #32
    ADD  X9, X9, X28, ASR #0
    MOV  X8, X9
    ST2 { V29.4S, V30.4S }, [X8], #32
    MOV  X8, X9
    LD2 { V24.4S, V25.4S }, [X8], #32
    ADD  X9, X9, X28, LSR #0
    MOV  X8, X9
    ST2 { V5.8H, V6.8H }, [X8], #32
    MOV  X8, X9
    LD2 { V16.8H, V17.8H }, [X8], #32
    ADD  X9, X9, X28
    MOV  X8, X9
    ST2 { V27.8B, V28.8B }, [X8], #16
    MOV  X8, X9
    LD2 { V20.4H, V21.4H }, [X8], #16
    ADD  X9, X9, X28
    MOV  X8, X9
    ST2 { V3.2S, V4.2S }, [X8], #16
    MOV  X8, X9
    LD2 { V4.2S, V5.2S }, [X8], #16
    ADD  X9, X9, X28
    MOV  X8, X9
    ST2 { V31.4H, V0.4H }, [X8], #16
    MOV  X8, X9
    LD2 { V23.4H, V24.4H }, [X8], #16
    ADD  X9, X9, X28
    MOV  X8, X9
    ST2 { V20.8B, V21.8B }, [X8], #16
    MOV  X8, X9
    LD2 { V7.8B, V8.8B }, [X8], #16
    ADD  X9, X9, X28
    ST2 { V29.8H, V30.8H }, [X9], X16
    LD2 { V31.4S, V0.4S }, [X9], X16
    ADD  X9, X9, X28
    ST2 { V31.16B, V0.16B }, [X9], X16
    LD2 { V15.16B, V16.16B }, [X9], X16
    ADD  X9, X9, X28, ASR #0
    ST2 { V30.2D, V31.2D }, [X9], X16
    LD2 { V8.2D, V9.2D }, [X9], X16
    ADD  X9, X9, X28
    ST2 { V23.4S, V24.4S }, [X9], X16
    LD2 { V18.4S, V19.4S }, [X9], X16
    ADD  X9, X9, X28, LSR #0
    ST2 { V19.8H, V20.8H }, [X9], X16
    LD2 { V7.8H, V8.8H }, [X9], X16
    ADD  X9, X9, X28, ASR #0
    ST2 { V7.8B, V8.8B }, [X9], X16
    LD2 { V9.8B, V10.8B }, [X9], X16
    ADD  X9, X9, X28, ASR #0
    ST2 { V5.2S, V6.2S }, [X9], X16
    LD2 { V0.2S, V1.2S }, [X9], X16
    ADD  X9, X9, X28, LSR #0
    ST2 { V11.4H, V12.4H }, [X9], X16
    LD2 { V28.4H, V29.4H }, [X9], X16
    ADD  X9, X9, X28
    ST2 { V2.8B, V3.8B }, [X9], X16
    LD2 { V5.8B, V6.8B }, [X9], X16
    ADD  X9, X9, X28, ASR #0
    ST2 { V9.H, V10.H }[0x5], [X9]
    LD2 { V23.H, V24.H }[0x4], [X9]
    ADD  X9, X9, X28
    ST2 { V0.S, V1.S }[0x2], [X9]
    LD2 { V11.S, V12.S }[0x1], [X9]
    ADD  X9, X9, X28, LSR #0
    ST2 { V25.D, V26.D }[0x0], [X9]
    LD2 { V25.D, V26.D }[0x1], [X9]
    ADD  X9, X9, X28, ASR #0
    ST2 { V25.B, V26.B }[0x4], [X9]
    LD2 { V29.B, V30.B }[0x0], [X9]
    ADD  X9, X9, X28, ASR #0
    MOV  X8, X9
    ST2 { V29.H, V30.H }[0x3], [X8], #4
    MOV  X8, X9
    LD2 { V24.H, V25.H }[0x0], [X8], #4
    ADD  X9, X9, X28, ASR #0
    ST2 { V25.H, V26.H }[0x0], [X9], X16
    LD2 { V22.H, V23.H }[0x0], [X9], X16
    ADD  X9, X9, X28, LSR #0
    MOV  X8, X9
    ST2 { V23.S, V24.S }[0x1], [X8], #8
    MOV  X8, X9
    LD2 { V21.S, V22.S }[0x1], [X8], #8
    ADD  X9, X9, X28, ASR #0
    ST2 { V21.S, V22.S }[0x1], [X9], X16
    LD2 { V23.S, V24.S }[0x2], [X9], X16
    ADD  X9, X9, X28, ASR #0
    MOV  X8, X9
    ST2 { V23.D, V24.D }[0x1], [X8], #16
    MOV  X8, X9
    LD2 { V23.D, V24.D }[0x0], [X8], #16
    ADD  X9, X9, X28
    ST2 { V23.D, V24.D }[0x1], [X9], X16
    LD2 { V29.D, V30.D }[0x1], [X9], X16
    ADD  X9, X9, X28, ASR #0
    MOV  X8, X9
    ST2 { V29.B, V30.B }[0xb], [X8], #2
    MOV  X8, X9
    LD2 { V15.B, V16.B }[0xd], [X8], #2
    ADD  X9, X9, X28, LSR #0
    ST2 { V31.B, V0.B }[0xa], [X9], X16
    LD2 { V14.B, V15.B }[0x8], [X9], X16
    ADD  X9, X9, X28, LSR #0
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X29, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MRS  X10, FPSR
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V0.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D0
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V1.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D1
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V2.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D2
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V3.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D3
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D4
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D5
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V6.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D6
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D7
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D8
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D9
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D10
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D11
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D12
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V13.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D13
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D14
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X29, #0x5a00, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D15
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D16
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V17.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D17
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D18
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V19.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D19
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D20
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D21
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D22
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V23.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D23
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D24
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V25.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D25
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D26
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D27
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D28
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V29.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D29
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V30.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D30
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, V31.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    FMOV  X10, D31
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X7, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
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
    FMOV  D0, X24
    FMOV  V0.D[1], X27
    FMOV  D1, X24
    FMOV  V1.D[1], X9
    FMOV  D2, X26
    FMOV  V2.D[1], X28
    FMOV  D3, X29
    FMOV  V3.D[1], X11
    FMOV  D4, X17
    FMOV  V4.D[1], X9
    FMOV  D5, X12
    FMOV  V5.D[1], X12
    FMOV  D6, X9
    FMOV  V6.D[1], X2
    FMOV  D7, X5
    FMOV  V7.D[1], X25
    FMOV  D8, X12
    FMOV  V8.D[1], X24
    FMOV  D9, X11
    FMOV  V9.D[1], X17
    FMOV  D10, X14
    FMOV  V10.D[1], X3
    FMOV  D11, X16
    FMOV  V11.D[1], X9
    FMOV  D12, X10
    FMOV  V12.D[1], X29
    FMOV  D13, X25
    FMOV  V13.D[1], X17
    FMOV  D14, X4
    FMOV  V14.D[1], X8
    FMOV  D15, X16
    FMOV  V15.D[1], X27
    FMOV  D16, X29
    FMOV  V16.D[1], X17
    FMOV  D17, X4
    FMOV  V17.D[1], X6
    FMOV  D18, X29
    FMOV  V18.D[1], X25
    FMOV  D19, X12
    FMOV  V19.D[1], X26
    FMOV  D20, X13
    FMOV  V20.D[1], X24
    FMOV  D21, X15
    FMOV  V21.D[1], X29
    FMOV  D22, X7
    FMOV  V22.D[1], X16
    FMOV  D23, X17
    FMOV  V23.D[1], X12
    FMOV  D24, X27
    FMOV  V24.D[1], X14
    FMOV  D25, X5
    FMOV  V25.D[1], X25
    FMOV  D26, X26
    FMOV  V26.D[1], X23
    FMOV  D27, X23
    FMOV  V27.D[1], X9
    FMOV  D28, X5
    FMOV  V28.D[1], X14
    FMOV  D29, X10
    FMOV  V29.D[1], X10
    FMOV  D30, X7
    FMOV  V30.D[1], X9
    FMOV  D31, X12
    FMOV  V31.D[1], X23
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X3, #0x40, LSL #0
    MOVZ  X17, #0x2d00, LSL #0
    ADD  X24, X30, X17, ASR #0
    ST2 { V21.8H, V22.8H }, [X24]
    LD2 { V19.8H, V20.8H }, [X24]
    ADD  X24, X24, X3, ASR #0
    ST2 { V23.16B, V24.16B }, [X24]
    LD2 { V31.16B, V0.16B }, [X24]
    ADD  X24, X24, X3, LSR #0
    ST2 { V27.2D, V28.2D }, [X24]
    LD2 { V19.2D, V20.2D }, [X24]
    ADD  X24, X24, X3
    ST2 { V29.4S, V30.4S }, [X24]
    LD2 { V8.4S, V9.4S }, [X24]
    ADD  X24, X24, X3, ASR #0
    ST2 { V9.8H, V10.8H }, [X24]
    LD2 { V21.8H, V22.8H }, [X24]
    ADD  X24, X24, X3
    ST2 { V31.2S, V0.2S }, [X24]
    LD2 { V13.4H, V14.4H }, [X24]
    ADD  X24, X24, X3, LSR #0
    ST2 { V22.2S, V23.2S }, [X24]
    LD2 { V3.2S, V4.2S }, [X24]
    ADD  X24, X24, X3
    ST2 { V19.4H, V20.4H }, [X24]
    LD2 { V14.4H, V15.4H }, [X24]
    ADD  X24, X24, X3, LSR #0
    ST2 { V3.8B, V4.8B }, [X24]
    LD2 { V27.8B, V28.8B }, [X24]
    ADD  X24, X24, X3
    MOV  X2, X24
    ST2 { V14.8H, V15.8H }, [X2], #32
    MOV  X2, X24
    LD2 { V24.2D, V25.2D }, [X2], #32
    ADD  X24, X24, X3
    MOV  X2, X24
    ST2 { V0.16B, V1.16B }, [X2], #32
    MOV  X2, X24
    LD2 { V19.16B, V20.16B }, [X2], #32
    ADD  X24, X24, X3, LSR #0
    MOV  X2, X24
    ST2 { V27.2D, V28.2D }, [X2], #32
    MOV  X2, X24
    LD2 { V0.2D, V1.2D }, [X2], #32
    ADD  X24, X24, X3, ASR #0
    MOV  X2, X24
    ST2 { V24.4S, V25.4S }, [X2], #32
    MOV  X2, X24
    LD2 { V14.4S, V15.4S }, [X2], #32
    ADD  X24, X24, X3, ASR #0
    MOV  X2, X24
    ST2 { V14.8H, V15.8H }, [X2], #32
    MOV  X2, X24
    LD2 { V27.8H, V28.8H }, [X2], #32
    ADD  X24, X24, X3
    MOV  X2, X24
    ST2 { V3.8B, V4.8B }, [X2], #16
    MOV  X2, X24
    LD2 { V19.4H, V20.4H }, [X2], #16
    ADD  X24, X24, X3
    MOV  X2, X24
    ST2 { V15.2S, V16.2S }, [X2], #16
    MOV  X2, X24
    LD2 { V24.2S, V25.2S }, [X2], #16
    ADD  X24, X24, X3, LSR #0
    MOV  X2, X24
    ST2 { V29.4H, V30.4H }, [X2], #16
    MOV  X2, X24
    LD2 { V15.4H, V16.4H }, [X2], #16
    ADD  X24, X24, X3, ASR #0
    MOV  X2, X24
    ST2 { V29.8B, V30.8B }, [X2], #16
    MOV  X2, X24
    LD2 { V12.8B, V13.8B }, [X2], #16
    ADD  X24, X24, X3, ASR #0
    ST2 { V29.2D, V30.2D }, [X24], X23
    LD2 { V3.16B, V4.16B }, [X24], X23
    ADD  X24, X24, X3, LSR #0
    ST2 { V24.16B, V25.16B }, [X24], X23
    LD2 { V24.16B, V25.16B }, [X24], X23
    ADD  X24, X24, X3
    ST2 { V14.2D, V15.2D }, [X24], X23
    LD2 { V14.2D, V15.2D }, [X24], X23
    ADD  X24, X24, X3, LSR #0
    ST2 { V12.4S, V13.4S }, [X24], X23
    LD2 { V27.4S, V28.4S }, [X24], X23
    ADD  X24, X24, X3, ASR #0
    ST2 { V24.8H, V25.8H }, [X24], X23
    LD2 { V13.8H, V14.8H }, [X24], X23
    ADD  X24, X24, X3
    ST2 { V20.4H, V21.4H }, [X24], X23
    LD2 { V25.4H, V26.4H }, [X24], X23
    ADD  X24, X24, X3
    ST2 { V11.2S, V12.2S }, [X24], X23
    LD2 { V5.2S, V6.2S }, [X24], X23
    ADD  X24, X24, X3, ASR #0
    ST2 { V4.4H, V5.4H }, [X24], X23
    LD2 { V15.4H, V16.4H }, [X24], X23
    ADD  X24, X24, X3, LSR #0
    ST2 { V15.8B, V16.8B }, [X24], X23
    LD2 { V7.8B, V8.8B }, [X24], X23
    ADD  X24, X24, X3
    ST2 { V27.H, V28.H }[0x4], [X24]
    LD2 { V14.H, V15.H }[0x5], [X24]
    ADD  X24, X24, X3, LSR #0
    ST2 { V6.S, V7.S }[0x3], [X24]
    LD2 { V30.S, V31.S }[0x2], [X24]
    ADD  X24, X24, X3, LSR #0
    ST2 { V8.D, V9.D }[0x0], [X24]
    LD2 { V28.D, V29.D }[0x0], [X24]
    ADD  X24, X24, X3
    ST2 { V8.B, V9.B }[0xd], [X24]
    LD2 { V6.B, V7.B }[0xd], [X24]
    ADD  X24, X24, X3, ASR #0
    MOV  X2, X24
    ST2 { V6.H, V7.H }[0x2], [X2], #4
    MOV  X2, X24
    LD2 { V6.H, V7.H }[0x1], [X2], #4
    ADD  X24, X24, X3, ASR #0
    ST2 { V14.H, V15.H }[0x6], [X24], X23
    LD2 { V25.H, V26.H }[0x2], [X24], X23
    ADD  X24, X24, X3
    MOV  X2, X24
    ST2 { V28.S, V29.S }[0x1], [X2], #8
    MOV  X2, X24
    LD2 { V28.S, V29.S }[0x0], [X2], #8
    ADD  X24, X24, X3
    ST2 { V14.S, V15.S }[0x3], [X24], X23
    LD2 { V14.S, V15.S }[0x0], [X24], X23
    ADD  X24, X24, X3, ASR #0
    MOV  X2, X24
    ST2 { V28.D, V29.D }[0x0], [X2], #16
    MOV  X2, X24
    LD2 { V26.D, V27.D }[0x1], [X2], #16
    ADD  X24, X24, X3, LSR #0
    ST2 { V14.D, V15.D }[0x1], [X24], X23
    LD2 { V9.D, V10.D }[0x0], [X24], X23
    ADD  X24, X24, X3
    MOV  X2, X24
    ST2 { V25.B, V26.B }[0xd], [X2], #2
    MOV  X2, X24
    LD2 { V25.B, V26.B }[0x3], [X2], #2
    ADD  X24, X24, X3, LSR #0
    ST2 { V25.B, V26.B }[0x6], [X24], X23
    LD2 { V27.B, V28.B }[0x0], [X24], X23
    ADD  X24, X24, X3
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X4, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP05_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X4, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP05_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X4, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP05_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X4, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP05_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X4, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP05_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X4, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP05_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X4, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP05_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X4, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP05_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X4, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP05_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X4, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP05_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X4, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP05_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X4, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP05_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X4, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP05_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X4, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP05_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP05_TestFail
    MRS  X16, FPSR
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D0
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D1
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D2
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D3
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D4
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D5
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D6
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xa500, LSL #32
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D7
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D8
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D9
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D10
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D11
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D12
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D13
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D14
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D15
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D16
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D17
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D18
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D19
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D20
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D21
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D22
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D23
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D24
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D25
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5, LSL #16
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D26
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D27
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D28
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D29
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D30
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X16, D31
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
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
    FMOV  V0.D[1], X25
    FMOV  D1, X8
    FMOV  V1.D[1], X13
    FMOV  D2, X26
    FMOV  V2.D[1], X29
    FMOV  D3, X27
    FMOV  V3.D[1], X6
    FMOV  D4, X9
    FMOV  V4.D[1], X26
    FMOV  D5, X5
    FMOV  V5.D[1], X6
    FMOV  D6, X16
    FMOV  V6.D[1], X15
    FMOV  D7, X16
    FMOV  V7.D[1], X17
    FMOV  D8, X10
    FMOV  V8.D[1], X4
    FMOV  D9, X8
    FMOV  V9.D[1], X9
    FMOV  D10, X2
    FMOV  V10.D[1], X14
    FMOV  D11, X2
    FMOV  V11.D[1], X26
    FMOV  D12, X12
    FMOV  V12.D[1], X25
    FMOV  D13, X6
    FMOV  V13.D[1], X25
    FMOV  D14, X27
    FMOV  V14.D[1], X17
    FMOV  D15, X29
    FMOV  V15.D[1], X3
    FMOV  D16, X17
    FMOV  V16.D[1], X12
    FMOV  D17, X26
    FMOV  V17.D[1], X4
    FMOV  D18, X7
    FMOV  V18.D[1], X6
    FMOV  D19, X27
    FMOV  V19.D[1], X28
    FMOV  D20, X25
    FMOV  V20.D[1], X4
    FMOV  D21, X14
    FMOV  V21.D[1], X17
    FMOV  D22, X2
    FMOV  V22.D[1], X29
    FMOV  D23, X3
    FMOV  V23.D[1], X17
    FMOV  D24, X14
    FMOV  V24.D[1], X26
    FMOV  D25, X6
    FMOV  V25.D[1], X15
    FMOV  D26, X15
    FMOV  V26.D[1], X26
    FMOV  D27, X12
    FMOV  V27.D[1], X28
    FMOV  D28, X28
    FMOV  V28.D[1], X14
    FMOV  D29, X3
    FMOV  V29.D[1], X26
    FMOV  D30, X12
    FMOV  V30.D[1], X13
    FMOV  D31, X4
    FMOV  V31.D[1], X5
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X12, #0x40, LSL #0
    MOVZ  X2, #0x0, LSL #0
    ADD  X23, X30, X2, LSR #0
    ST2 { V6.16B, V7.16B }, [X23]
    LD2 { V14.2D, V15.2D }, [X23]
    ADD  X23, X23, X12
    ST2 { V14.16B, V15.16B }, [X23]
    LD2 { V6.16B, V7.16B }, [X23]
    ADD  X23, X23, X12
    ST2 { V30.2D, V31.2D }, [X23]
    LD2 { V26.2D, V27.2D }, [X23]
    ADD  X23, X23, X12
    ST2 { V0.4S, V1.4S }, [X23]
    LD2 { V1.4S, V2.4S }, [X23]
    ADD  X23, X23, X12
    ST2 { V14.8H, V15.8H }, [X23]
    LD2 { V15.8H, V16.8H }, [X23]
    ADD  X23, X23, X12
    ST2 { V13.2S, V14.2S }, [X23]
    LD2 { V10.2S, V11.2S }, [X23]
    ADD  X23, X23, X12, LSR #0
    ST2 { V10.2S, V11.2S }, [X23]
    LD2 { V8.2S, V9.2S }, [X23]
    ADD  X23, X23, X12, LSR #0
    ST2 { V20.4H, V21.4H }, [X23]
    LD2 { V19.4H, V20.4H }, [X23]
    ADD  X23, X23, X12, LSR #0
    ST2 { V31.8B, V0.8B }, [X23]
    LD2 { V31.8B, V0.8B }, [X23]
    ADD  X23, X23, X12, LSR #0
    MOV  X9, X23
    ST2 { V11.2D, V12.2D }, [X9], #32
    MOV  X9, X23
    LD2 { V19.2D, V20.2D }, [X9], #32
    ADD  X23, X23, X12, LSR #0
    MOV  X9, X23
    ST2 { V12.16B, V13.16B }, [X9], #32
    MOV  X9, X23
    LD2 { V4.16B, V5.16B }, [X9], #32
    ADD  X23, X23, X12, LSR #0
    MOV  X9, X23
    ST2 { V9.2D, V10.2D }, [X9], #32
    MOV  X9, X23
    LD2 { V3.2D, V4.2D }, [X9], #32
    ADD  X23, X23, X12, LSR #0
    MOV  X9, X23
    ST2 { V4.4S, V5.4S }, [X9], #32
    MOV  X9, X23
    LD2 { V27.4S, V28.4S }, [X9], #32
    ADD  X23, X23, X12, LSR #0
    MOV  X9, X23
    ST2 { V19.8H, V20.8H }, [X9], #32
    MOV  X9, X23
    LD2 { V17.8H, V18.8H }, [X9], #32
    ADD  X23, X23, X12
    MOV  X9, X23
    ST2 { V27.8B, V28.8B }, [X9], #16
    MOV  X9, X23
    LD2 { V20.8B, V21.8B }, [X9], #16
    ADD  X23, X23, X12, LSR #0
    MOV  X9, X23
    ST2 { V24.2S, V25.2S }, [X9], #16
    MOV  X9, X23
    LD2 { V5.2S, V6.2S }, [X9], #16
    ADD  X23, X23, X12
    MOV  X9, X23
    ST2 { V12.4H, V13.4H }, [X9], #16
    MOV  X9, X23
    LD2 { V14.4H, V15.4H }, [X9], #16
    ADD  X23, X23, X12, LSR #0
    MOV  X9, X23
    ST2 { V14.8B, V15.8B }, [X9], #16
    MOV  X9, X23
    LD2 { V12.8B, V13.8B }, [X9], #16
    ADD  X23, X23, X12, LSR #0
    ST2 { V20.4S, V21.4S }, [X23], X7
    LD2 { V8.2D, V9.2D }, [X23], X7
    ADD  X23, X23, X12, LSR #0
    ST2 { V13.16B, V14.16B }, [X23], X7
    LD2 { V14.16B, V15.16B }, [X23], X7
    ADD  X23, X23, X12, ASR #0
    ST2 { V5.2D, V6.2D }, [X23], X7
    LD2 { V9.2D, V10.2D }, [X23], X7
    ADD  X23, X23, X12, LSR #0
    ST2 { V5.4S, V6.4S }, [X23], X7
    LD2 { V20.4S, V21.4S }, [X23], X7
    ADD  X23, X23, X12
    ST2 { V19.8H, V20.8H }, [X23], X7
    LD2 { V2.8H, V3.8H }, [X23], X7
    ADD  X23, X23, X12, ASR #0
    ST2 { V8.2S, V9.2S }, [X23], X7
    LD2 { V8.4H, V9.4H }, [X23], X7
    ADD  X23, X23, X12, ASR #0
    ST2 { V9.2S, V10.2S }, [X23], X7
    LD2 { V29.2S, V30.2S }, [X23], X7
    ADD  X23, X23, X12, ASR #0
    ST2 { V3.4H, V4.4H }, [X23], X7
    LD2 { V24.4H, V25.4H }, [X23], X7
    ADD  X23, X23, X12, ASR #0
    ST2 { V19.8B, V20.8B }, [X23], X7
    LD2 { V24.8B, V25.8B }, [X23], X7
    ADD  X23, X23, X12
    ST2 { V29.H, V30.H }[0x0], [X23]
    LD2 { V6.H, V7.H }[0x6], [X23]
    ADD  X23, X23, X12, ASR #0
    ST2 { V10.S, V11.S }[0x1], [X23]
    LD2 { V3.S, V4.S }[0x3], [X23]
    ADD  X23, X23, X12
    ST2 { V7.D, V8.D }[0x0], [X23]
    LD2 { V0.D, V1.D }[0x0], [X23]
    ADD  X23, X23, X12
    ST2 { V3.B, V4.B }[0x6], [X23]
    LD2 { V12.B, V13.B }[0x0], [X23]
    ADD  X23, X23, X12
    MOV  X9, X23
    ST2 { V24.H, V25.H }[0x4], [X9], #4
    MOV  X9, X23
    LD2 { V21.H, V22.H }[0x6], [X9], #4
    ADD  X23, X23, X12, LSR #0
    ST2 { V21.H, V22.H }[0x5], [X23], X7
    LD2 { V7.H, V8.H }[0x2], [X23], X7
    ADD  X23, X23, X12
    MOV  X9, X23
    ST2 { V8.S, V9.S }[0x3], [X9], #8
    MOV  X9, X23
    LD2 { V24.S, V25.S }[0x1], [X9], #8
    ADD  X23, X23, X12, LSR #0
    ST2 { V12.S, V13.S }[0x3], [X23], X7
    LD2 { V3.S, V4.S }[0x1], [X23], X7
    ADD  X23, X23, X12
    MOV  X9, X23
    ST2 { V0.D, V1.D }[0x1], [X9], #16
    MOV  X9, X23
    LD2 { V11.D, V12.D }[0x0], [X9], #16
    ADD  X23, X23, X12, ASR #0
    ST2 { V11.D, V12.D }[0x0], [X23], X7
    LD2 { V26.D, V27.D }[0x0], [X23], X7
    ADD  X23, X23, X12, ASR #0
    MOV  X9, X23
    ST2 { V26.B, V27.B }[0xd], [X9], #2
    MOV  X9, X23
    LD2 { V6.B, V7.B }[0xd], [X9], #2
    ADD  X23, X23, X12
    ST2 { V31.B, V0.B }[0x3], [X23], X7
    LD2 { V31.B, V0.B }[0x3], [X23], X7
    ADD  X23, X23, X12, ASR #0
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X26, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X26, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X26, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X26, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X26, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X26, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X26, X24, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X26, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X26, X24, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X26, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X26, X24, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X26, X24, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X26, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X26, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X26, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MRS  X24, FPSR
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V0.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D0
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V1.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D1
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V2.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D2
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V3.D[1]
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D3
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D4
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D5
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x5a5a, LSL #32
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D6
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D7
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V8.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D8
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D9
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V10.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D10
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V11.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D11
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V12.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D12
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D13
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D14
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D15
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V16.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D16
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D17
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V18.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D18
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D19
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D20
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V21.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D21
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V22.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D22
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V23.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D23
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V24.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D24
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V25.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D25
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V26.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D26
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D27
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V28.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D28
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V29.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D29
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V30.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D30
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, V31.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    FMOV  X24, D31
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
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
    FMOV  D0, X29
    FMOV  V0.D[1], X28
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X15
    FMOV  V2.D[1], X14
    FMOV  D3, X16
    FMOV  V3.D[1], X11
    FMOV  D4, X26
    FMOV  V4.D[1], X10
    FMOV  D5, X27
    FMOV  V5.D[1], X27
    FMOV  D6, X29
    FMOV  V6.D[1], X7
    FMOV  D7, X3
    FMOV  V7.D[1], X28
    FMOV  D8, X8
    FMOV  V8.D[1], X4
    FMOV  D9, X28
    FMOV  V9.D[1], X7
    FMOV  D10, X28
    FMOV  V10.D[1], X25
    FMOV  D11, X3
    FMOV  V11.D[1], X28
    FMOV  D12, X27
    FMOV  V12.D[1], X14
    FMOV  D13, X24
    FMOV  V13.D[1], X11
    FMOV  D14, X4
    FMOV  V14.D[1], X8
    FMOV  D15, X10
    FMOV  V15.D[1], X5
    FMOV  D16, X26
    FMOV  V16.D[1], X26
    FMOV  D17, X12
    FMOV  V17.D[1], X12
    FMOV  D18, X6
    FMOV  V18.D[1], X15
    FMOV  D19, X17
    FMOV  V19.D[1], X9
    FMOV  D20, X14
    FMOV  V20.D[1], X13
    FMOV  D21, X12
    FMOV  V21.D[1], X11
    FMOV  D22, X7
    FMOV  V22.D[1], X4
    FMOV  D23, X27
    FMOV  V23.D[1], X7
    FMOV  D24, X13
    FMOV  V24.D[1], X11
    FMOV  D25, X6
    FMOV  V25.D[1], X2
    FMOV  D26, X26
    FMOV  V26.D[1], X17
    FMOV  D27, X5
    FMOV  V27.D[1], X29
    FMOV  D28, X28
    FMOV  V28.D[1], X7
    FMOV  D29, X10
    FMOV  V29.D[1], X29
    FMOV  D30, X26
    FMOV  V30.D[1], X29
    FMOV  D31, X26
    FMOV  V31.D[1], X13
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X4, #0x40, LSL #0
    MOVZ  X10, #0x500, LSL #0
    ADD  X17, X30, X10
    ST2 { V29.4S, V30.4S }, [X17]
    LD2 { V30.8H, V31.8H }, [X17]
    ADD  X17, X17, X4, LSR #0
    ST2 { V25.16B, V26.16B }, [X17]
    LD2 { V22.16B, V23.16B }, [X17]
    ADD  X17, X17, X4, LSR #0
    ST2 { V12.2D, V13.2D }, [X17]
    LD2 { V10.2D, V11.2D }, [X17]
    ADD  X17, X17, X4, LSR #0
    ST2 { V10.4S, V11.4S }, [X17]
    LD2 { V11.4S, V12.4S }, [X17]
    ADD  X17, X17, X4, LSR #0
    ST2 { V22.8H, V23.8H }, [X17]
    LD2 { V30.8H, V31.8H }, [X17]
    ADD  X17, X17, X4, LSR #0
    ST2 { V11.8B, V12.8B }, [X17]
    LD2 { V5.8B, V6.8B }, [X17]
    ADD  X17, X17, X4, LSR #0
    ST2 { V20.2S, V21.2S }, [X17]
    LD2 { V30.2S, V31.2S }, [X17]
    ADD  X17, X17, X4, LSR #0
    ST2 { V30.4H, V31.4H }, [X17]
    LD2 { V14.4H, V15.4H }, [X17]
    ADD  X17, X17, X4, ASR #0
    ST2 { V13.8B, V14.8B }, [X17]
    LD2 { V10.8B, V11.8B }, [X17]
    ADD  X17, X17, X4, LSR #0
    MOV  X2, X17
    ST2 { V10.8H, V11.8H }, [X2], #32
    MOV  X2, X17
    LD2 { V6.2D, V7.2D }, [X2], #32
    ADD  X17, X17, X4, ASR #0
    MOV  X2, X17
    ST2 { V23.16B, V24.16B }, [X2], #32
    MOV  X2, X17
    LD2 { V24.16B, V25.16B }, [X2], #32
    ADD  X17, X17, X4, LSR #0
    MOV  X2, X17
    ST2 { V15.2D, V16.2D }, [X2], #32
    MOV  X2, X17
    LD2 { V13.2D, V14.2D }, [X2], #32
    ADD  X17, X17, X4, LSR #0
    MOV  X2, X17
    ST2 { V31.4S, V0.4S }, [X2], #32
    MOV  X2, X17
    LD2 { V20.4S, V21.4S }, [X2], #32
    ADD  X17, X17, X4, ASR #0
    MOV  X2, X17
    ST2 { V6.8H, V7.8H }, [X2], #32
    MOV  X2, X17
    LD2 { V17.8H, V18.8H }, [X2], #32
    ADD  X17, X17, X4
    MOV  X2, X17
    ST2 { V24.8B, V25.8B }, [X2], #16
    MOV  X2, X17
    LD2 { V4.2S, V5.2S }, [X2], #16
    ADD  X17, X17, X4
    MOV  X2, X17
    ST2 { V13.2S, V14.2S }, [X2], #16
    MOV  X2, X17
    LD2 { V15.2S, V16.2S }, [X2], #16
    ADD  X17, X17, X4
    MOV  X2, X17
    ST2 { V3.4H, V4.4H }, [X2], #16
    MOV  X2, X17
    LD2 { V31.4H, V0.4H }, [X2], #16
    ADD  X17, X17, X4, ASR #0
    MOV  X2, X17
    ST2 { V21.8B, V22.8B }, [X2], #16
    MOV  X2, X17
    LD2 { V13.8B, V14.8B }, [X2], #16
    ADD  X17, X17, X4
    ST2 { V31.4S, V0.4S }, [X17], X14
    LD2 { V6.4S, V7.4S }, [X17], X14
    ADD  X17, X17, X4, ASR #0
    ST2 { V5.16B, V6.16B }, [X17], X14
    LD2 { V0.16B, V1.16B }, [X17], X14
    ADD  X17, X17, X4
    ST2 { V14.2D, V15.2D }, [X17], X14
    LD2 { V31.2D, V0.2D }, [X17], X14
    ADD  X17, X17, X4, LSR #0
    ST2 { V0.4S, V1.4S }, [X17], X14
    LD2 { V3.4S, V4.4S }, [X17], X14
    ADD  X17, X17, X4, ASR #0
    ST2 { V25.8H, V26.8H }, [X17], X14
    LD2 { V14.8H, V15.8H }, [X17], X14
    ADD  X17, X17, X4, ASR #0
    ST2 { V29.8B, V30.8B }, [X17], X14
    LD2 { V6.2S, V7.2S }, [X17], X14
    ADD  X17, X17, X4, LSR #0
    ST2 { V12.2S, V13.2S }, [X17], X14
    LD2 { V16.2S, V17.2S }, [X17], X14
    ADD  X17, X17, X4, LSR #0
    ST2 { V16.4H, V17.4H }, [X17], X14
    LD2 { V16.4H, V17.4H }, [X17], X14
    ADD  X17, X17, X4, LSR #0
    ST2 { V16.8B, V17.8B }, [X17], X14
    LD2 { V12.8B, V13.8B }, [X17], X14
    ADD  X17, X17, X4, LSR #0
    ST2 { V14.H, V15.H }[0x0], [X17]
    LD2 { V0.H, V1.H }[0x0], [X17]
    ADD  X17, X17, X4, LSR #0
    ST2 { V4.S, V5.S }[0x0], [X17]
    LD2 { V14.S, V15.S }[0x2], [X17]
    ADD  X17, X17, X4
    ST2 { V12.D, V13.D }[0x1], [X17]
    LD2 { V12.D, V13.D }[0x0], [X17]
    ADD  X17, X17, X4
    ST2 { V0.B, V1.B }[0xb], [X17]
    LD2 { V7.B, V8.B }[0x7], [X17]
    ADD  X17, X17, X4, LSR #0
    MOV  X2, X17
    ST2 { V12.H, V13.H }[0x3], [X2], #4
    MOV  X2, X17
    LD2 { V25.H, V26.H }[0x4], [X2], #4
    ADD  X17, X17, X4
    ST2 { V20.H, V21.H }[0x5], [X17], X14
    LD2 { V12.H, V13.H }[0x3], [X17], X14
    ADD  X17, X17, X4, LSR #0
    MOV  X2, X17
    ST2 { V3.S, V4.S }[0x0], [X2], #8
    MOV  X2, X17
    LD2 { V20.S, V21.S }[0x0], [X2], #8
    ADD  X17, X17, X4, LSR #0
    ST2 { V7.S, V8.S }[0x0], [X17], X14
    LD2 { V16.S, V17.S }[0x0], [X17], X14
    ADD  X17, X17, X4, LSR #0
    MOV  X2, X17
    ST2 { V12.D, V13.D }[0x0], [X2], #16
    MOV  X2, X17
    LD2 { V19.D, V20.D }[0x0], [X2], #16
    ADD  X17, X17, X4, ASR #0
    ST2 { V25.D, V26.D }[0x1], [X17], X14
    LD2 { V25.D, V26.D }[0x0], [X17], X14
    ADD  X17, X17, X4
    MOV  X2, X17
    ST2 { V29.B, V30.B }[0xd], [X2], #2
    MOV  X2, X17
    LD2 { V13.B, V14.B }[0xa], [X2], #2
    ADD  X17, X17, X4, LSR #0
    ST2 { V19.B, V20.B }[0x5], [X17], X14
    LD2 { V18.B, V19.B }[0x3], [X17], X14
    ADD  X17, X17, X4, ASR #0
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X5, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X5, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X5, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X5, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X5, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X5, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X5, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X5, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X5, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X5, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X5, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X5, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X5, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X5, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X5, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MRS  X23, FPSR
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V0.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D0
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V1.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D1
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D2
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D3
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D4
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D5
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D6
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D7
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D8
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D9
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D10
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D11
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D12
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xa5, LSL #16
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D13
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa500, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D14
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D15
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D16
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D17
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D18
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D19
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D20
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D21
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D22
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V23.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D23
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D24
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D25
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D26
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D27
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D28
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D29
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V30.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D30
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, V31.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    FMOV  X23, D31
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X8, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
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
    FMOV  V0.D[1], X27
    FMOV  D1, X28
    FMOV  V1.D[1], X23
    FMOV  D2, X24
    FMOV  V2.D[1], X10
    FMOV  D3, X29
    FMOV  V3.D[1], X27
    FMOV  D4, X29
    FMOV  V4.D[1], X6
    FMOV  D5, X25
    FMOV  V5.D[1], X14
    FMOV  D6, X28
    FMOV  V6.D[1], X24
    FMOV  D7, X27
    FMOV  V7.D[1], X24
    FMOV  D8, X26
    FMOV  V8.D[1], X17
    FMOV  D9, X9
    FMOV  V9.D[1], X2
    FMOV  D10, X8
    FMOV  V10.D[1], X6
    FMOV  D11, X2
    FMOV  V11.D[1], X13
    FMOV  D12, X9
    FMOV  V12.D[1], X24
    FMOV  D13, X25
    FMOV  V13.D[1], X7
    FMOV  D14, X17
    FMOV  V14.D[1], X17
    FMOV  D15, X3
    FMOV  V15.D[1], X25
    FMOV  D16, X14
    FMOV  V16.D[1], X8
    FMOV  D17, X8
    FMOV  V17.D[1], X27
    FMOV  D18, X17
    FMOV  V18.D[1], X9
    FMOV  D19, X17
    FMOV  V19.D[1], X11
    FMOV  D20, X7
    FMOV  V20.D[1], X25
    FMOV  D21, X5
    FMOV  V21.D[1], X8
    FMOV  D22, X12
    FMOV  V22.D[1], X5
    FMOV  D23, X28
    FMOV  V23.D[1], X25
    FMOV  D24, X3
    FMOV  V24.D[1], X9
    FMOV  D25, X12
    FMOV  V25.D[1], X2
    FMOV  D26, X16
    FMOV  V26.D[1], X27
    FMOV  D27, X7
    FMOV  V27.D[1], X17
    FMOV  D28, X9
    FMOV  V28.D[1], X23
    FMOV  D29, X10
    FMOV  V29.D[1], X3
    FMOV  D30, X28
    FMOV  V30.D[1], X15
    FMOV  D31, X15
    FMOV  V31.D[1], X24
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X27, #0x40, LSL #0
    MOVZ  X11, #0xa00, LSL #0
    ADD  X17, X30, X11
    ST2 { V0.8H, V1.8H }, [X17]
    LD2 { V25.8H, V26.8H }, [X17]
    ADD  X17, X17, X27
    ST2 { V23.16B, V24.16B }, [X17]
    LD2 { V13.16B, V14.16B }, [X17]
    ADD  X17, X17, X27, LSR #0
    ST2 { V26.2D, V27.2D }, [X17]
    LD2 { V31.2D, V0.2D }, [X17]
    ADD  X17, X17, X27, ASR #0
    ST2 { V17.4S, V18.4S }, [X17]
    LD2 { V22.4S, V23.4S }, [X17]
    ADD  X17, X17, X27
    ST2 { V13.8H, V14.8H }, [X17]
    LD2 { V7.8H, V8.8H }, [X17]
    ADD  X17, X17, X27
    ST2 { V9.8B, V10.8B }, [X17]
    LD2 { V25.4H, V26.4H }, [X17]
    ADD  X17, X17, X27, LSR #0
    ST2 { V9.2S, V10.2S }, [X17]
    LD2 { V17.2S, V18.2S }, [X17]
    ADD  X17, X17, X27
    ST2 { V7.4H, V8.4H }, [X17]
    LD2 { V1.4H, V2.4H }, [X17]
    ADD  X17, X17, X27
    ST2 { V22.8B, V23.8B }, [X17]
    LD2 { V16.8B, V17.8B }, [X17]
    ADD  X17, X17, X27
    MOV  X16, X17
    ST2 { V4.8H, V5.8H }, [X16], #32
    MOV  X16, X17
    LD2 { V31.8H, V0.8H }, [X16], #32
    ADD  X17, X17, X27
    MOV  X16, X17
    ST2 { V13.16B, V14.16B }, [X16], #32
    MOV  X16, X17
    LD2 { V28.16B, V29.16B }, [X16], #32
    ADD  X17, X17, X27, LSR #0
    MOV  X16, X17
    ST2 { V0.2D, V1.2D }, [X16], #32
    MOV  X16, X17
    LD2 { V17.2D, V18.2D }, [X16], #32
    ADD  X17, X17, X27
    MOV  X16, X17
    ST2 { V12.4S, V13.4S }, [X16], #32
    MOV  X16, X17
    LD2 { V11.4S, V12.4S }, [X16], #32
    ADD  X17, X17, X27, ASR #0
    MOV  X16, X17
    ST2 { V11.8H, V12.8H }, [X16], #32
    MOV  X16, X17
    LD2 { V6.8H, V7.8H }, [X16], #32
    ADD  X17, X17, X27, ASR #0
    MOV  X16, X17
    ST2 { V17.2S, V18.2S }, [X16], #16
    MOV  X16, X17
    LD2 { V10.4H, V11.4H }, [X16], #16
    ADD  X17, X17, X27, ASR #0
    MOV  X16, X17
    ST2 { V12.2S, V13.2S }, [X16], #16
    MOV  X16, X17
    LD2 { V5.2S, V6.2S }, [X16], #16
    ADD  X17, X17, X27
    MOV  X16, X17
    ST2 { V10.4H, V11.4H }, [X16], #16
    MOV  X16, X17
    LD2 { V11.4H, V12.4H }, [X16], #16
    ADD  X17, X17, X27, LSR #0
    MOV  X16, X17
    ST2 { V6.8B, V7.8B }, [X16], #16
    MOV  X16, X17
    LD2 { V16.8B, V17.8B }, [X16], #16
    ADD  X17, X17, X27
    ST2 { V11.4S, V12.4S }, [X17], X7
    LD2 { V21.4S, V22.4S }, [X17], X7
    ADD  X17, X17, X27, ASR #0
    ST2 { V20.16B, V21.16B }, [X17], X7
    LD2 { V11.16B, V12.16B }, [X17], X7
    ADD  X17, X17, X27, LSR #0
    ST2 { V16.2D, V17.2D }, [X17], X7
    LD2 { V5.2D, V6.2D }, [X17], X7
    ADD  X17, X17, X27, ASR #0
    ST2 { V8.4S, V9.4S }, [X17], X7
    LD2 { V6.4S, V7.4S }, [X17], X7
    ADD  X17, X17, X27
    ST2 { V11.8H, V12.8H }, [X17], X7
    LD2 { V7.8H, V8.8H }, [X17], X7
    ADD  X17, X17, X27, LSR #0
    ST2 { V7.2S, V8.2S }, [X17], X7
    LD2 { V18.8B, V19.8B }, [X17], X7
    ADD  X17, X17, X27
    ST2 { V5.2S, V6.2S }, [X17], X7
    LD2 { V10.2S, V11.2S }, [X17], X7
    ADD  X17, X17, X27, ASR #0
    ST2 { V18.4H, V19.4H }, [X17], X7
    LD2 { V26.4H, V27.4H }, [X17], X7
    ADD  X17, X17, X27, LSR #0
    ST2 { V28.8B, V29.8B }, [X17], X7
    LD2 { V14.8B, V15.8B }, [X17], X7
    ADD  X17, X17, X27
    ST2 { V14.H, V15.H }[0x0], [X17]
    LD2 { V10.H, V11.H }[0x4], [X17]
    ADD  X17, X17, X27
    ST2 { V6.S, V7.S }[0x0], [X17]
    LD2 { V7.S, V8.S }[0x0], [X17]
    ADD  X17, X17, X27, ASR #0
    ST2 { V10.D, V11.D }[0x0], [X17]
    LD2 { V28.D, V29.D }[0x0], [X17]
    ADD  X17, X17, X27, ASR #0
    ST2 { V8.B, V9.B }[0xa], [X17]
    LD2 { V19.B, V20.B }[0x2], [X17]
    ADD  X17, X17, X27, ASR #0
    MOV  X16, X17
    ST2 { V19.H, V20.H }[0x0], [X16], #4
    MOV  X16, X17
    LD2 { V26.H, V27.H }[0x3], [X16], #4
    ADD  X17, X17, X27
    ST2 { V10.H, V11.H }[0x1], [X17], X7
    LD2 { V19.H, V20.H }[0x5], [X17], X7
    ADD  X17, X17, X27
    MOV  X16, X17
    ST2 { V27.S, V28.S }[0x3], [X16], #8
    MOV  X16, X17
    LD2 { V7.S, V8.S }[0x3], [X16], #8
    ADD  X17, X17, X27
    ST2 { V7.S, V8.S }[0x2], [X17], X7
    LD2 { V21.S, V22.S }[0x0], [X17], X7
    ADD  X17, X17, X27, ASR #0
    MOV  X16, X17
    ST2 { V20.D, V21.D }[0x1], [X16], #16
    MOV  X16, X17
    LD2 { V13.D, V14.D }[0x0], [X16], #16
    ADD  X17, X17, X27, ASR #0
    ST2 { V13.D, V14.D }[0x1], [X17], X7
    LD2 { V20.D, V21.D }[0x0], [X17], X7
    ADD  X17, X17, X27, ASR #0
    MOV  X16, X17
    ST2 { V19.B, V20.B }[0x0], [X16], #2
    MOV  X16, X17
    LD2 { V15.B, V16.B }[0x8], [X16], #2
    ADD  X17, X17, X27
    ST2 { V8.B, V9.B }[0xb], [X17], X7
    LD2 { V13.B, V14.B }[0x2], [X17], X7
    ADD  X17, X17, X27, LSR #0
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X6, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X6, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X6, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X6, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X6, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X6, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X6, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X6, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X6, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X6, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X6, X5, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X6, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X6, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X6, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MRS  X5, FPSR
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V0.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D0
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V1.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D1
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V2.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D2
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V3.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D3
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D4
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V5.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D5
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V6.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D6
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V7.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D7
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V8.D[1]
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D8
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V9.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D9
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V10.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D10
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V11.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D11
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V12.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D12
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V13.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D13
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a00, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V14.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D14
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x5a, LSL #16
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V15.D[1]
    MOVZ  X6, #0x5a, LSL #0
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D15
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V16.D[1]
    MOVZ  X6, #0x5a, LSL #0
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D16
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V17.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D17
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V18.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D18
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V19.D[1]
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D19
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a00, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V20.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D20
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V21.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D21
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V22.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D22
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V23.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D23
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V24.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D24
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V25.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D25
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V26.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D26
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V27.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D27
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V28.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D28
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V29.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D29
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V30.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D30
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, V31.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X5, D31
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
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
    FMOV  D0, X28
    FMOV  V0.D[1], X27
    FMOV  D1, X8
    FMOV  V1.D[1], X23
    FMOV  D2, X9
    FMOV  V2.D[1], X29
    FMOV  D3, X12
    FMOV  V3.D[1], X24
    FMOV  D4, X12
    FMOV  V4.D[1], X6
    FMOV  D5, X4
    FMOV  V5.D[1], X3
    FMOV  D6, X7
    FMOV  V6.D[1], X24
    FMOV  D7, X26
    FMOV  V7.D[1], X26
    FMOV  D8, X27
    FMOV  V8.D[1], X15
    FMOV  D9, X27
    FMOV  V9.D[1], X14
    FMOV  D10, X13
    FMOV  V10.D[1], X5
    FMOV  D11, X11
    FMOV  V11.D[1], X13
    FMOV  D12, X16
    FMOV  V12.D[1], X27
    FMOV  D13, X8
    FMOV  V13.D[1], X3
    FMOV  D14, X7
    FMOV  V14.D[1], X16
    FMOV  D15, X15
    FMOV  V15.D[1], X16
    FMOV  D16, X7
    FMOV  V16.D[1], X6
    FMOV  D17, X8
    FMOV  V17.D[1], X12
    FMOV  D18, X27
    FMOV  V18.D[1], X14
    FMOV  D19, X23
    FMOV  V19.D[1], X14
    FMOV  D20, X13
    FMOV  V20.D[1], X9
    FMOV  D21, X3
    FMOV  V21.D[1], X16
    FMOV  D22, X6
    FMOV  V22.D[1], X15
    FMOV  D23, X6
    FMOV  V23.D[1], X25
    FMOV  D24, X5
    FMOV  V24.D[1], X17
    FMOV  D25, X9
    FMOV  V25.D[1], X9
    FMOV  D26, X23
    FMOV  V26.D[1], X8
    FMOV  D27, X12
    FMOV  V27.D[1], X16
    FMOV  D28, X2
    FMOV  V28.D[1], X25
    FMOV  D29, X16
    FMOV  V29.D[1], X13
    FMOV  D30, X8
    FMOV  V30.D[1], X11
    FMOV  D31, X12
    FMOV  V31.D[1], X6
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x40, LSL #0
    MOVZ  X8, #0xf00, LSL #0
    ADD  X25, X30, X8
    ST2 { V29.16B, V30.16B }, [X25]
    LD2 { V21.16B, V22.16B }, [X25]
    ADD  X25, X25, X27
    ST2 { V26.16B, V27.16B }, [X25]
    LD2 { V29.16B, V30.16B }, [X25]
    ADD  X25, X25, X27
    ST2 { V28.2D, V29.2D }, [X25]
    LD2 { V16.2D, V17.2D }, [X25]
    ADD  X25, X25, X27
    ST2 { V15.4S, V16.4S }, [X25]
    LD2 { V4.4S, V5.4S }, [X25]
    ADD  X25, X25, X27
    ST2 { V29.8H, V30.8H }, [X25]
    LD2 { V13.8H, V14.8H }, [X25]
    ADD  X25, X25, X27, LSR #0
    ST2 { V13.4H, V14.4H }, [X25]
    LD2 { V10.4H, V11.4H }, [X25]
    ADD  X25, X25, X27, LSR #0
    ST2 { V21.2S, V22.2S }, [X25]
    LD2 { V15.2S, V16.2S }, [X25]
    ADD  X25, X25, X27, LSR #0
    ST2 { V14.4H, V15.4H }, [X25]
    LD2 { V20.4H, V21.4H }, [X25]
    ADD  X25, X25, X27
    ST2 { V16.8B, V17.8B }, [X25]
    LD2 { V8.8B, V9.8B }, [X25]
    ADD  X25, X25, X27, ASR #0
    MOV  X16, X25
    ST2 { V0.8H, V1.8H }, [X16], #32
    MOV  X16, X25
    LD2 { V29.4S, V30.4S }, [X16], #32
    ADD  X25, X25, X27
    MOV  X16, X25
    ST2 { V10.16B, V11.16B }, [X16], #32
    MOV  X16, X25
    LD2 { V14.16B, V15.16B }, [X16], #32
    ADD  X25, X25, X27, LSR #0
    MOV  X16, X25
    ST2 { V29.2D, V30.2D }, [X16], #32
    MOV  X16, X25
    LD2 { V7.2D, V8.2D }, [X16], #32
    ADD  X25, X25, X27, LSR #0
    MOV  X16, X25
    ST2 { V14.4S, V15.4S }, [X16], #32
    MOV  X16, X25
    LD2 { V10.4S, V11.4S }, [X16], #32
    ADD  X25, X25, X27
    MOV  X16, X25
    ST2 { V10.8H, V11.8H }, [X16], #32
    MOV  X16, X25
    LD2 { V1.8H, V2.8H }, [X16], #32
    ADD  X25, X25, X27, LSR #0
    MOV  X16, X25
    ST2 { V7.4H, V8.4H }, [X16], #16
    MOV  X16, X25
    LD2 { V17.4H, V18.4H }, [X16], #16
    ADD  X25, X25, X27, ASR #0
    MOV  X16, X25
    ST2 { V31.2S, V0.2S }, [X16], #16
    MOV  X16, X25
    LD2 { V17.2S, V18.2S }, [X16], #16
    ADD  X25, X25, X27, ASR #0
    MOV  X16, X25
    ST2 { V1.4H, V2.4H }, [X16], #16
    MOV  X16, X25
    LD2 { V7.4H, V8.4H }, [X16], #16
    ADD  X25, X25, X27, ASR #0
    MOV  X16, X25
    ST2 { V7.8B, V8.8B }, [X16], #16
    MOV  X16, X25
    LD2 { V19.8B, V20.8B }, [X16], #16
    ADD  X25, X25, X27, ASR #0
    ST2 { V19.4S, V20.4S }, [X25], X26
    LD2 { V18.2D, V19.2D }, [X25], X26
    ADD  X25, X25, X27, ASR #0
    ST2 { V20.16B, V21.16B }, [X25], X26
    LD2 { V18.16B, V19.16B }, [X25], X26
    ADD  X25, X25, X27, ASR #0
    ST2 { V4.2D, V5.2D }, [X25], X26
    LD2 { V14.2D, V15.2D }, [X25], X26
    ADD  X25, X25, X27, ASR #0
    ST2 { V18.4S, V19.4S }, [X25], X26
    LD2 { V18.4S, V19.4S }, [X25], X26
    ADD  X25, X25, X27
    ST2 { V12.8H, V13.8H }, [X25], X26
    LD2 { V8.8H, V9.8H }, [X25], X26
    ADD  X25, X25, X27, ASR #0
    ST2 { V19.4H, V20.4H }, [X25], X26
    LD2 { V6.4H, V7.4H }, [X25], X26
    ADD  X25, X25, X27
    ST2 { V7.2S, V8.2S }, [X25], X26
    LD2 { V10.2S, V11.2S }, [X25], X26
    ADD  X25, X25, X27, LSR #0
    ST2 { V6.4H, V7.4H }, [X25], X26
    LD2 { V15.4H, V16.4H }, [X25], X26
    ADD  X25, X25, X27, ASR #0
    ST2 { V30.8B, V31.8B }, [X25], X26
    LD2 { V25.8B, V26.8B }, [X25], X26
    ADD  X25, X25, X27
    ST2 { V15.H, V16.H }[0x0], [X25]
    LD2 { V3.H, V4.H }[0x5], [X25]
    ADD  X25, X25, X27, ASR #0
    ST2 { V0.S, V1.S }[0x0], [X25]
    LD2 { V7.S, V8.S }[0x1], [X25]
    ADD  X25, X25, X27
    ST2 { V6.D, V7.D }[0x1], [X25]
    LD2 { V30.D, V31.D }[0x1], [X25]
    ADD  X25, X25, X27, ASR #0
    ST2 { V30.B, V31.B }[0x5], [X25]
    LD2 { V12.B, V13.B }[0x9], [X25]
    ADD  X25, X25, X27, LSR #0
    MOV  X16, X25
    ST2 { V3.H, V4.H }[0x0], [X16], #4
    MOV  X16, X25
    LD2 { V3.H, V4.H }[0x0], [X16], #4
    ADD  X25, X25, X27, ASR #0
    ST2 { V22.H, V23.H }[0x7], [X25], X26
    LD2 { V30.H, V31.H }[0x7], [X25], X26
    ADD  X25, X25, X27, LSR #0
    MOV  X16, X25
    ST2 { V26.S, V27.S }[0x1], [X16], #8
    MOV  X16, X25
    LD2 { V6.S, V7.S }[0x2], [X16], #8
    ADD  X25, X25, X27, ASR #0
    ST2 { V3.S, V4.S }[0x0], [X25], X26
    LD2 { V19.S, V20.S }[0x2], [X25], X26
    ADD  X25, X25, X27, LSR #0
    MOV  X16, X25
    ST2 { V19.D, V20.D }[0x1], [X16], #16
    MOV  X16, X25
    LD2 { V22.D, V23.D }[0x0], [X16], #16
    ADD  X25, X25, X27, ASR #0
    ST2 { V30.D, V31.D }[0x1], [X25], X26
    LD2 { V26.D, V27.D }[0x1], [X25], X26
    ADD  X25, X25, X27, ASR #0
    MOV  X16, X25
    ST2 { V31.B, V0.B }[0x6], [X16], #2
    MOV  X16, X25
    LD2 { V2.B, V3.B }[0xa], [X16], #2
    ADD  X25, X25, X27
    ST2 { V26.B, V27.B }[0xd], [X25], X26
    LD2 { V2.B, V3.B }[0x6], [X25], X26
    ADD  X25, X25, X27
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X15, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP05_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X15, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP05_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X15, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP05_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X15, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP05_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X15, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP05_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X15, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP05_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X15, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP05_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X15, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP05_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X15, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP05_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X15, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP05_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X15, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP05_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X15, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP05_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X15, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP05_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X15, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP05_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X15, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP05_TestFail
    MRS  X12, FPSR
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V0.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D0
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V1.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D1
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xa5, LSL #16
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D2
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa500, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D3
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa500, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D4
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D5
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D6
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D7
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D8
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D9
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D10
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D11
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V12.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D12
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D13
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D14
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D15
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D16
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D17
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D18
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D19
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D20
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D21
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D22
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D23
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D24
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D25
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D26
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D27
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D28
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D29
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V30.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D30
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, V31.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
    FMOV  X12, D31
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP05_TestFail
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
    FMOV  V0.D[1], X25
    FMOV  D1, X29
    FMOV  V1.D[1], X26
    FMOV  D2, X23
    FMOV  V2.D[1], X16
    FMOV  D3, X11
    FMOV  V3.D[1], X28
    FMOV  D4, X23
    FMOV  V4.D[1], X16
    FMOV  D5, X13
    FMOV  V5.D[1], X15
    FMOV  D6, X6
    FMOV  V6.D[1], X13
    FMOV  D7, X9
    FMOV  V7.D[1], X17
    FMOV  D8, X14
    FMOV  V8.D[1], X3
    FMOV  D9, X9
    FMOV  V9.D[1], X3
    FMOV  D10, X3
    FMOV  V10.D[1], X25
    FMOV  D11, X2
    FMOV  V11.D[1], X28
    FMOV  D12, X16
    FMOV  V12.D[1], X12
    FMOV  D13, X6
    FMOV  V13.D[1], X16
    FMOV  D14, X11
    FMOV  V14.D[1], X27
    FMOV  D15, X10
    FMOV  V15.D[1], X8
    FMOV  D16, X7
    FMOV  V16.D[1], X17
    FMOV  D17, X9
    FMOV  V17.D[1], X2
    FMOV  D18, X26
    FMOV  V18.D[1], X2
    FMOV  D19, X16
    FMOV  V19.D[1], X6
    FMOV  D20, X29
    FMOV  V20.D[1], X15
    FMOV  D21, X16
    FMOV  V21.D[1], X4
    FMOV  D22, X27
    FMOV  V22.D[1], X12
    FMOV  D23, X9
    FMOV  V23.D[1], X17
    FMOV  D24, X16
    FMOV  V24.D[1], X7
    FMOV  D25, X5
    FMOV  V25.D[1], X29
    FMOV  D26, X6
    FMOV  V26.D[1], X14
    FMOV  D27, X11
    FMOV  V27.D[1], X3
    FMOV  D28, X8
    FMOV  V28.D[1], X11
    FMOV  D29, X8
    FMOV  V29.D[1], X25
    FMOV  D30, X28
    FMOV  V30.D[1], X14
    FMOV  D31, X28
    FMOV  V31.D[1], X11
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x40, LSL #0
    MOVZ  X24, #0x1400, LSL #0
    ADD  X8, X30, X24
    ST2 { V29.8H, V30.8H }, [X8]
    LD2 { V1.16B, V2.16B }, [X8]
    ADD  X8, X8, X16
    ST2 { V27.16B, V28.16B }, [X8]
    LD2 { V13.16B, V14.16B }, [X8]
    ADD  X8, X8, X16, ASR #0
    ST2 { V19.2D, V20.2D }, [X8]
    LD2 { V27.2D, V28.2D }, [X8]
    ADD  X8, X8, X16, ASR #0
    ST2 { V9.4S, V10.4S }, [X8]
    LD2 { V23.4S, V24.4S }, [X8]
    ADD  X8, X8, X16
    ST2 { V1.8H, V2.8H }, [X8]
    LD2 { V23.8H, V24.8H }, [X8]
    ADD  X8, X8, X16, ASR #0
    ST2 { V27.8B, V28.8B }, [X8]
    LD2 { V12.2S, V13.2S }, [X8]
    ADD  X8, X8, X16
    ST2 { V12.2S, V13.2S }, [X8]
    LD2 { V19.2S, V20.2S }, [X8]
    ADD  X8, X8, X16
    ST2 { V1.4H, V2.4H }, [X8]
    LD2 { V9.4H, V10.4H }, [X8]
    ADD  X8, X8, X16, ASR #0
    ST2 { V19.8B, V20.8B }, [X8]
    LD2 { V20.8B, V21.8B }, [X8]
    ADD  X8, X8, X16, ASR #0
    MOV  X9, X8
    ST2 { V23.8H, V24.8H }, [X9], #32
    MOV  X9, X8
    LD2 { V30.4S, V31.4S }, [X9], #32
    ADD  X8, X8, X16, LSR #0
    MOV  X9, X8
    ST2 { V30.16B, V31.16B }, [X9], #32
    MOV  X9, X8
    LD2 { V14.16B, V15.16B }, [X9], #32
    ADD  X8, X8, X16, LSR #0
    MOV  X9, X8
    ST2 { V9.2D, V10.2D }, [X9], #32
    MOV  X9, X8
    LD2 { V5.2D, V6.2D }, [X9], #32
    ADD  X8, X8, X16
    MOV  X9, X8
    ST2 { V23.4S, V24.4S }, [X9], #32
    MOV  X9, X8
    LD2 { V28.4S, V29.4S }, [X9], #32
    ADD  X8, X8, X16, ASR #0
    MOV  X9, X8
    ST2 { V5.8H, V6.8H }, [X9], #32
    MOV  X9, X8
    LD2 { V30.8H, V31.8H }, [X9], #32
    ADD  X8, X8, X16
    MOV  X9, X8
    ST2 { V14.8B, V15.8B }, [X9], #16
    MOV  X9, X8
    LD2 { V2.4H, V3.4H }, [X9], #16
    ADD  X8, X8, X16, LSR #0
    MOV  X9, X8
    ST2 { V2.2S, V3.2S }, [X9], #16
    MOV  X9, X8
    LD2 { V5.2S, V6.2S }, [X9], #16
    ADD  X8, X8, X16, LSR #0
    MOV  X9, X8
    ST2 { V28.4H, V29.4H }, [X9], #16
    MOV  X9, X8
    LD2 { V29.4H, V30.4H }, [X9], #16
    ADD  X8, X8, X16, LSR #0
    MOV  X9, X8
    ST2 { V29.8B, V30.8B }, [X9], #16
    MOV  X9, X8
    LD2 { V22.8B, V23.8B }, [X9], #16
    ADD  X8, X8, X16, LSR #0
    ST2 { V5.8H, V6.8H }, [X8], X15
    LD2 { V19.2D, V20.2D }, [X8], X15
    ADD  X8, X8, X16
    ST2 { V25.16B, V26.16B }, [X8], X15
    LD2 { V30.16B, V31.16B }, [X8], X15
    ADD  X8, X8, X16, LSR #0
    ST2 { V24.2D, V25.2D }, [X8], X15
    LD2 { V15.2D, V16.2D }, [X8], X15
    ADD  X8, X8, X16, LSR #0
    ST2 { V5.4S, V6.4S }, [X8], X15
    LD2 { V29.4S, V30.4S }, [X8], X15
    ADD  X8, X8, X16, ASR #0
    ST2 { V2.8H, V3.8H }, [X8], X15
    LD2 { V22.8H, V23.8H }, [X8], X15
    ADD  X8, X8, X16, ASR #0
    ST2 { V23.4H, V24.4H }, [X8], X15
    LD2 { V15.2S, V16.2S }, [X8], X15
    ADD  X8, X8, X16
    ST2 { V31.2S, V0.2S }, [X8], X15
    LD2 { V10.2S, V11.2S }, [X8], X15
    ADD  X8, X8, X16, ASR #0
    ST2 { V15.4H, V16.4H }, [X8], X15
    LD2 { V26.4H, V27.4H }, [X8], X15
    ADD  X8, X8, X16
    ST2 { V6.8B, V7.8B }, [X8], X15
    LD2 { V24.8B, V25.8B }, [X8], X15
    ADD  X8, X8, X16
    ST2 { V24.H, V25.H }[0x1], [X8]
    LD2 { V20.H, V21.H }[0x1], [X8]
    ADD  X8, X8, X16, ASR #0
    ST2 { V29.S, V30.S }[0x0], [X8]
    LD2 { V6.S, V7.S }[0x3], [X8]
    ADD  X8, X8, X16, ASR #0
    ST2 { V3.D, V4.D }[0x0], [X8]
    LD2 { V31.D, V0.D }[0x1], [X8]
    ADD  X8, X8, X16, LSR #0
    ST2 { V29.B, V30.B }[0xc], [X8]
    LD2 { V24.B, V25.B }[0x9], [X8]
    ADD  X8, X8, X16, ASR #0
    MOV  X9, X8
    ST2 { V9.H, V10.H }[0x4], [X9], #4
    MOV  X9, X8
    LD2 { V16.H, V17.H }[0x7], [X9], #4
    ADD  X8, X8, X16, LSR #0
    ST2 { V31.H, V0.H }[0x3], [X8], X15
    LD2 { V3.H, V4.H }[0x1], [X8], X15
    ADD  X8, X8, X16, LSR #0
    MOV  X9, X8
    ST2 { V24.S, V25.S }[0x2], [X9], #8
    MOV  X9, X8
    LD2 { V1.S, V2.S }[0x0], [X9], #8
    ADD  X8, X8, X16
    ST2 { V3.S, V4.S }[0x3], [X8], X15
    LD2 { V9.S, V10.S }[0x1], [X8], X15
    ADD  X8, X8, X16
    MOV  X9, X8
    ST2 { V16.D, V17.D }[0x1], [X9], #16
    MOV  X9, X8
    LD2 { V31.D, V0.D }[0x0], [X9], #16
    ADD  X8, X8, X16
    ST2 { V31.D, V0.D }[0x1], [X8], X15
    LD2 { V3.D, V4.D }[0x0], [X8], X15
    ADD  X8, X8, X16
    MOV  X9, X8
    ST2 { V20.B, V21.B }[0x5], [X9], #2
    MOV  X9, X8
    LD2 { V29.B, V30.B }[0x0], [X9], #2
    ADD  X8, X8, X16
    ST2 { V0.B, V1.B }[0x0], [X8], X15
    LD2 { V9.B, V10.B }[0x9], [X8], X15
    ADD  X8, X8, X16, LSR #0
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X5, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X5, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X5, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X5, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X5, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X5, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X5, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X5, X26, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X5, X26, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X5, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X5, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X5, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X5, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X5, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X5, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MRS  X26, FPSR
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V0.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D0
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V1.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D1
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D2
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D3
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D4
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D5
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D6
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D7
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D8
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X5, #0x5a00, LSL #0
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D9
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D10
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V11.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D11
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D12
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D13
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D14
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D15
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D16
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D17
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D18
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D19
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D20
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D21
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D22
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D23
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D24
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D25
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V26.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D26
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D27
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D28
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D29
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V30.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D30
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V31.D[1]
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D31
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
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
    FMOV  V0.D[1], X26
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X24
    FMOV  V2.D[1], X4
    FMOV  D3, X11
    FMOV  V3.D[1], X28
    FMOV  D4, X5
    FMOV  V4.D[1], X7
    FMOV  D5, X12
    FMOV  V5.D[1], X16
    FMOV  D6, X27
    FMOV  V6.D[1], X27
    FMOV  D7, X3
    FMOV  V7.D[1], X10
    FMOV  D8, X11
    FMOV  V8.D[1], X11
    FMOV  D9, X27
    FMOV  V9.D[1], X12
    FMOV  D10, X5
    FMOV  V10.D[1], X7
    FMOV  D11, X9
    FMOV  V11.D[1], X10
    FMOV  D12, X8
    FMOV  V12.D[1], X17
    FMOV  D13, X7
    FMOV  V13.D[1], X8
    FMOV  D14, X28
    FMOV  V14.D[1], X12
    FMOV  D15, X5
    FMOV  V15.D[1], X10
    FMOV  D16, X13
    FMOV  V16.D[1], X16
    FMOV  D17, X17
    FMOV  V17.D[1], X10
    FMOV  D18, X27
    FMOV  V18.D[1], X29
    FMOV  D19, X15
    FMOV  V19.D[1], X12
    FMOV  D20, X9
    FMOV  V20.D[1], X8
    FMOV  D21, X6
    FMOV  V21.D[1], X15
    FMOV  D22, X12
    FMOV  V22.D[1], X6
    FMOV  D23, X27
    FMOV  V23.D[1], X14
    FMOV  D24, X26
    FMOV  V24.D[1], X26
    FMOV  D25, X17
    FMOV  V25.D[1], X7
    FMOV  D26, X17
    FMOV  V26.D[1], X24
    FMOV  D27, X25
    FMOV  V27.D[1], X28
    FMOV  D28, X8
    FMOV  V28.D[1], X2
    FMOV  D29, X9
    FMOV  V29.D[1], X28
    FMOV  D30, X8
    FMOV  V30.D[1], X17
    FMOV  D31, X9
    FMOV  V31.D[1], X27
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X27, #0x40, LSL #0
    MOVZ  X6, #0x1900, LSL #0
    ADD  X16, X30, X6, LSR #0
    ST2 { V9.4S, V10.4S }, [X16]
    LD2 { V11.8H, V12.8H }, [X16]
    ADD  X16, X16, X27, ASR #0
    ST2 { V30.16B, V31.16B }, [X16]
    LD2 { V2.16B, V3.16B }, [X16]
    ADD  X16, X16, X27, ASR #0
    ST2 { V28.2D, V29.2D }, [X16]
    LD2 { V4.2D, V5.2D }, [X16]
    ADD  X16, X16, X27
    ST2 { V3.4S, V4.4S }, [X16]
    LD2 { V7.4S, V8.4S }, [X16]
    ADD  X16, X16, X27, ASR #0
    ST2 { V25.8H, V26.8H }, [X16]
    LD2 { V11.8H, V12.8H }, [X16]
    ADD  X16, X16, X27, LSR #0
    ST2 { V31.4H, V0.4H }, [X16]
    LD2 { V0.2S, V1.2S }, [X16]
    ADD  X16, X16, X27
    ST2 { V24.2S, V25.2S }, [X16]
    LD2 { V12.2S, V13.2S }, [X16]
    ADD  X16, X16, X27, ASR #0
    ST2 { V7.4H, V8.4H }, [X16]
    LD2 { V7.4H, V8.4H }, [X16]
    ADD  X16, X16, X27, LSR #0
    ST2 { V28.8B, V29.8B }, [X16]
    LD2 { V13.8B, V14.8B }, [X16]
    ADD  X16, X16, X27, LSR #0
    MOV  X29, X16
    ST2 { V12.4S, V13.4S }, [X29], #32
    MOV  X29, X16
    LD2 { V5.4S, V6.4S }, [X29], #32
    ADD  X16, X16, X27, ASR #0
    MOV  X29, X16
    ST2 { V5.16B, V6.16B }, [X29], #32
    MOV  X29, X16
    LD2 { V25.16B, V26.16B }, [X29], #32
    ADD  X16, X16, X27, ASR #0
    MOV  X29, X16
    ST2 { V7.2D, V8.2D }, [X29], #32
    MOV  X29, X16
    LD2 { V9.2D, V10.2D }, [X29], #32
    ADD  X16, X16, X27, ASR #0
    MOV  X29, X16
    ST2 { V25.4S, V26.4S }, [X29], #32
    MOV  X29, X16
    LD2 { V9.4S, V10.4S }, [X29], #32
    ADD  X16, X16, X27, LSR #0
    MOV  X29, X16
    ST2 { V27.8H, V28.8H }, [X29], #32
    MOV  X29, X16
    LD2 { V28.8H, V29.8H }, [X29], #32
    ADD  X16, X16, X27
    MOV  X29, X16
    ST2 { V26.4H, V27.4H }, [X29], #16
    MOV  X29, X16
    LD2 { V18.8B, V19.8B }, [X29], #16
    ADD  X16, X16, X27, ASR #0
    MOV  X29, X16
    ST2 { V18.2S, V19.2S }, [X29], #16
    MOV  X29, X16
    LD2 { V20.2S, V21.2S }, [X29], #16
    ADD  X16, X16, X27, ASR #0
    MOV  X29, X16
    ST2 { V9.4H, V10.4H }, [X29], #16
    MOV  X29, X16
    LD2 { V15.4H, V16.4H }, [X29], #16
    ADD  X16, X16, X27, LSR #0
    MOV  X29, X16
    ST2 { V20.8B, V21.8B }, [X29], #16
    MOV  X29, X16
    LD2 { V30.8B, V31.8B }, [X29], #16
    ADD  X16, X16, X27, ASR #0
    ST2 { V13.2D, V14.2D }, [X16], X15
    LD2 { V12.8H, V13.8H }, [X16], X15
    ADD  X16, X16, X27, LSR #0
    ST2 { V12.16B, V13.16B }, [X16], X15
    LD2 { V14.16B, V15.16B }, [X16], X15
    ADD  X16, X16, X27, LSR #0
    ST2 { V12.2D, V13.2D }, [X16], X15
    LD2 { V31.2D, V0.2D }, [X16], X15
    ADD  X16, X16, X27, ASR #0
    ST2 { V0.4S, V1.4S }, [X16], X15
    LD2 { V22.4S, V23.4S }, [X16], X15
    ADD  X16, X16, X27, ASR #0
    ST2 { V15.8H, V16.8H }, [X16], X15
    LD2 { V21.8H, V22.8H }, [X16], X15
    ADD  X16, X16, X27, ASR #0
    ST2 { V8.2S, V9.2S }, [X16], X15
    LD2 { V7.8B, V8.8B }, [X16], X15
    ADD  X16, X16, X27, ASR #0
    ST2 { V13.2S, V14.2S }, [X16], X15
    LD2 { V17.2S, V18.2S }, [X16], X15
    ADD  X16, X16, X27, LSR #0
    ST2 { V0.4H, V1.4H }, [X16], X15
    LD2 { V31.4H, V0.4H }, [X16], X15
    ADD  X16, X16, X27, LSR #0
    ST2 { V6.8B, V7.8B }, [X16], X15
    LD2 { V27.8B, V28.8B }, [X16], X15
    ADD  X16, X16, X27, ASR #0
    ST2 { V22.H, V23.H }[0x5], [X16]
    LD2 { V4.H, V5.H }[0x0], [X16]
    ADD  X16, X16, X27, ASR #0
    ST2 { V20.S, V21.S }[0x2], [X16]
    LD2 { V31.S, V0.S }[0x0], [X16]
    ADD  X16, X16, X27, LSR #0
    ST2 { V27.D, V28.D }[0x1], [X16]
    LD2 { V7.D, V8.D }[0x1], [X16]
    ADD  X16, X16, X27, ASR #0
    ST2 { V17.B, V18.B }[0x3], [X16]
    LD2 { V27.B, V28.B }[0x7], [X16]
    ADD  X16, X16, X27, ASR #0
    MOV  X29, X16
    ST2 { V31.H, V0.H }[0x2], [X29], #4
    MOV  X29, X16
    LD2 { V22.H, V23.H }[0x5], [X29], #4
    ADD  X16, X16, X27, ASR #0
    ST2 { V15.H, V16.H }[0x5], [X16], X15
    LD2 { V15.H, V16.H }[0x6], [X16], X15
    ADD  X16, X16, X27
    MOV  X29, X16
    ST2 { V15.S, V16.S }[0x0], [X29], #8
    MOV  X29, X16
    LD2 { V31.S, V0.S }[0x1], [X29], #8
    ADD  X16, X16, X27, LSR #0
    ST2 { V0.S, V1.S }[0x2], [X16], X15
    LD2 { V15.S, V16.S }[0x3], [X16], X15
    ADD  X16, X16, X27, LSR #0
    MOV  X29, X16
    ST2 { V22.D, V23.D }[0x0], [X29], #16
    MOV  X29, X16
    LD2 { V19.D, V20.D }[0x1], [X29], #16
    ADD  X16, X16, X27, ASR #0
    ST2 { V16.D, V17.D }[0x1], [X16], X15
    LD2 { V22.D, V23.D }[0x1], [X16], X15
    ADD  X16, X16, X27, ASR #0
    MOV  X29, X16
    ST2 { V1.B, V2.B }[0xb], [X29], #2
    MOV  X29, X16
    LD2 { V24.B, V25.B }[0x7], [X29], #2
    ADD  X16, X16, X27, ASR #0
    ST2 { V24.B, V25.B }[0xb], [X16], X15
    LD2 { V1.B, V2.B }[0x6], [X16], X15
    ADD  X16, X16, X27, LSR #0
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X4, X7, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP05_TestFail
    MRS  X7, FPSR
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V0.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D0
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V1.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D1
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V2.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D2
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa500, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D3
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D4
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D5
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D6
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V7.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D7
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D8
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V9.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D9
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D10
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D11
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D12
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D13
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D14
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D15
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V16.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D16
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V17.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D17
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V18.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D18
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D19
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D20
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D21
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D22
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V23.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D23
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V24.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D24
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D25
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V26.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D26
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D27
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D28
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D29
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V30.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D30
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, V31.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X7, D31
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
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
    FMOV  D0, X23
    FMOV  V0.D[1], X9
    FMOV  D1, X25
    FMOV  V1.D[1], X29
    FMOV  D2, X27
    FMOV  V2.D[1], X11
    FMOV  D3, X25
    FMOV  V3.D[1], X28
    FMOV  D4, X10
    FMOV  V4.D[1], X5
    FMOV  D5, X10
    FMOV  V5.D[1], X9
    FMOV  D6, X15
    FMOV  V6.D[1], X14
    FMOV  D7, X27
    FMOV  V7.D[1], X12
    FMOV  D8, X26
    FMOV  V8.D[1], X11
    FMOV  D9, X16
    FMOV  V9.D[1], X2
    FMOV  D10, X3
    FMOV  V10.D[1], X4
    FMOV  D11, X29
    FMOV  V11.D[1], X14
    FMOV  D12, X27
    FMOV  V12.D[1], X15
    FMOV  D13, X16
    FMOV  V13.D[1], X24
    FMOV  D14, X15
    FMOV  V14.D[1], X15
    FMOV  D15, X7
    FMOV  V15.D[1], X27
    FMOV  D16, X15
    FMOV  V16.D[1], X2
    FMOV  D17, X17
    FMOV  V17.D[1], X9
    FMOV  D18, X25
    FMOV  V18.D[1], X9
    FMOV  D19, X7
    FMOV  V19.D[1], X8
    FMOV  D20, X7
    FMOV  V20.D[1], X26
    FMOV  D21, X25
    FMOV  V21.D[1], X15
    FMOV  D22, X28
    FMOV  V22.D[1], X28
    FMOV  D23, X27
    FMOV  V23.D[1], X12
    FMOV  D24, X17
    FMOV  V24.D[1], X16
    FMOV  D25, X11
    FMOV  V25.D[1], X14
    FMOV  D26, X29
    FMOV  V26.D[1], X11
    FMOV  D27, X17
    FMOV  V27.D[1], X16
    FMOV  D28, X6
    FMOV  V28.D[1], X5
    FMOV  D29, X13
    FMOV  V29.D[1], X26
    FMOV  D30, X13
    FMOV  V30.D[1], X17
    FMOV  D31, X5
    FMOV  V31.D[1], X16
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x40, LSL #0
    MOVZ  X5, #0x1e00, LSL #0
    ADD  X16, X30, X5, ASR #0
    ST2 { V26.16B, V27.16B }, [X16]
    LD2 { V24.8H, V25.8H }, [X16]
    ADD  X16, X16, X8, ASR #0
    ST2 { V22.16B, V23.16B }, [X16]
    LD2 { V22.16B, V23.16B }, [X16]
    ADD  X16, X16, X8, LSR #0
    ST2 { V13.2D, V14.2D }, [X16]
    LD2 { V19.2D, V20.2D }, [X16]
    ADD  X16, X16, X8, ASR #0
    ST2 { V14.4S, V15.4S }, [X16]
    LD2 { V14.4S, V15.4S }, [X16]
    ADD  X16, X16, X8, ASR #0
    ST2 { V23.8H, V24.8H }, [X16]
    LD2 { V22.8H, V23.8H }, [X16]
    ADD  X16, X16, X8, LSR #0
    ST2 { V2.4H, V3.4H }, [X16]
    LD2 { V2.4H, V3.4H }, [X16]
    ADD  X16, X16, X8, ASR #0
    ST2 { V2.2S, V3.2S }, [X16]
    LD2 { V9.2S, V10.2S }, [X16]
    ADD  X16, X16, X8, ASR #0
    ST2 { V19.4H, V20.4H }, [X16]
    LD2 { V19.4H, V20.4H }, [X16]
    ADD  X16, X16, X8, ASR #0
    ST2 { V14.8B, V15.8B }, [X16]
    LD2 { V14.8B, V15.8B }, [X16]
    ADD  X16, X16, X8, ASR #0
    MOV  X12, X16
    ST2 { V22.8H, V23.8H }, [X12], #32
    MOV  X12, X16
    LD2 { V4.2D, V5.2D }, [X12], #32
    ADD  X16, X16, X8, ASR #0
    MOV  X12, X16
    ST2 { V9.16B, V10.16B }, [X12], #32
    MOV  X12, X16
    LD2 { V22.16B, V23.16B }, [X12], #32
    ADD  X16, X16, X8
    MOV  X12, X16
    ST2 { V14.2D, V15.2D }, [X12], #32
    MOV  X12, X16
    LD2 { V10.2D, V11.2D }, [X12], #32
    ADD  X16, X16, X8, ASR #0
    MOV  X12, X16
    ST2 { V4.4S, V5.4S }, [X12], #32
    MOV  X12, X16
    LD2 { V1.4S, V2.4S }, [X12], #32
    ADD  X16, X16, X8, LSR #0
    MOV  X12, X16
    ST2 { V18.8H, V19.8H }, [X12], #32
    MOV  X12, X16
    LD2 { V4.8H, V5.8H }, [X12], #32
    ADD  X16, X16, X8, LSR #0
    MOV  X12, X16
    ST2 { V28.4H, V29.4H }, [X12], #16
    MOV  X12, X16
    LD2 { V27.8B, V28.8B }, [X12], #16
    ADD  X16, X16, X8
    MOV  X12, X16
    ST2 { V27.2S, V28.2S }, [X12], #16
    MOV  X12, X16
    LD2 { V4.2S, V5.2S }, [X12], #16
    ADD  X16, X16, X8
    MOV  X12, X16
    ST2 { V0.4H, V1.4H }, [X12], #16
    MOV  X12, X16
    LD2 { V8.4H, V9.4H }, [X12], #16
    ADD  X16, X16, X8, LSR #0
    MOV  X12, X16
    ST2 { V12.8B, V13.8B }, [X12], #16
    MOV  X12, X16
    LD2 { V24.8B, V25.8B }, [X12], #16
    ADD  X16, X16, X8, ASR #0
    ST2 { V24.8H, V25.8H }, [X16], X7
    LD2 { V30.16B, V31.16B }, [X16], X7
    ADD  X16, X16, X8
    ST2 { V8.16B, V9.16B }, [X16], X7
    LD2 { V21.16B, V22.16B }, [X16], X7
    ADD  X16, X16, X8
    ST2 { V0.2D, V1.2D }, [X16], X7
    LD2 { V11.2D, V12.2D }, [X16], X7
    ADD  X16, X16, X8, LSR #0
    ST2 { V30.4S, V31.4S }, [X16], X7
    LD2 { V12.4S, V13.4S }, [X16], X7
    ADD  X16, X16, X8, ASR #0
    ST2 { V11.8H, V12.8H }, [X16], X7
    LD2 { V13.8H, V14.8H }, [X16], X7
    ADD  X16, X16, X8, LSR #0
    ST2 { V13.8B, V14.8B }, [X16], X7
    LD2 { V16.8B, V17.8B }, [X16], X7
    ADD  X16, X16, X8
    ST2 { V25.2S, V26.2S }, [X16], X7
    LD2 { V26.2S, V27.2S }, [X16], X7
    ADD  X16, X16, X8
    ST2 { V26.4H, V27.4H }, [X16], X7
    LD2 { V17.4H, V18.4H }, [X16], X7
    ADD  X16, X16, X8
    ST2 { V26.8B, V27.8B }, [X16], X7
    LD2 { V31.8B, V0.8B }, [X16], X7
    ADD  X16, X16, X8, ASR #0
    ST2 { V16.H, V17.H }[0x1], [X16]
    LD2 { V22.H, V23.H }[0x2], [X16]
    ADD  X16, X16, X8
    ST2 { V31.S, V0.S }[0x3], [X16]
    LD2 { V31.S, V0.S }[0x3], [X16]
    ADD  X16, X16, X8
    ST2 { V31.D, V0.D }[0x1], [X16]
    LD2 { V9.D, V10.D }[0x1], [X16]
    ADD  X16, X16, X8, LSR #0
    ST2 { V14.B, V15.B }[0x5], [X16]
    LD2 { V15.B, V16.B }[0x8], [X16]
    ADD  X16, X16, X8
    MOV  X12, X16
    ST2 { V22.H, V23.H }[0x1], [X12], #4
    MOV  X12, X16
    LD2 { V26.H, V27.H }[0x3], [X12], #4
    ADD  X16, X16, X8, LSR #0
    ST2 { V9.H, V10.H }[0x7], [X16], X7
    LD2 { V21.H, V22.H }[0x6], [X16], X7
    ADD  X16, X16, X8
    MOV  X12, X16
    ST2 { V26.S, V27.S }[0x3], [X12], #8
    MOV  X12, X16
    LD2 { V26.S, V27.S }[0x1], [X12], #8
    ADD  X16, X16, X8, LSR #0
    ST2 { V26.S, V27.S }[0x0], [X16], X7
    LD2 { V26.S, V27.S }[0x3], [X16], X7
    ADD  X16, X16, X8, ASR #0
    MOV  X12, X16
    ST2 { V25.D, V26.D }[0x1], [X12], #16
    MOV  X12, X16
    LD2 { V9.D, V10.D }[0x1], [X12], #16
    ADD  X16, X16, X8
    ST2 { V18.D, V19.D }[0x1], [X16], X7
    LD2 { V25.D, V26.D }[0x1], [X16], X7
    ADD  X16, X16, X8, ASR #0
    MOV  X12, X16
    ST2 { V11.B, V12.B }[0x0], [X12], #2
    MOV  X12, X16
    LD2 { V11.B, V12.B }[0x2], [X12], #2
    ADD  X16, X16, X8
    ST2 { V25.B, V26.B }[0x7], [X16], X7
    LD2 { V18.B, V19.B }[0xd], [X16], X7
    ADD  X16, X16, X8
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MRS  X27, FPSR
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V0.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D0
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V1.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D1
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V2.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D2
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V3.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D3
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V4.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D4
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V5.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D5
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V6.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D6
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V7.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D7
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D8
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D9
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D10
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V11.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D11
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V12.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D12
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V13.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D13
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D14
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V15.D[1]
    MOVZ  X29, #0x5a, LSL #0
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D15
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V16.D[1]
    MOVZ  X29, #0x5a, LSL #0
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D16
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V17.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D17
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x5a00, LSL #32
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D18
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V19.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D19
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V20.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D20
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V21.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D21
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V22.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D22
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D23
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V24.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D24
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D25
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D26
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V27.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D27
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D28
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V29.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D29
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V30.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D30
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, V31.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    FMOV  X27, D31
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
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
    FMOV  D0, X13
    FMOV  V0.D[1], X27
    FMOV  D1, X26
    FMOV  V1.D[1], X25
    FMOV  D2, X29
    FMOV  V2.D[1], X28
    FMOV  D3, X16
    FMOV  V3.D[1], X9
    FMOV  D4, X17
    FMOV  V4.D[1], X17
    FMOV  D5, X27
    FMOV  V5.D[1], X10
    FMOV  D6, X12
    FMOV  V6.D[1], X3
    FMOV  D7, X8
    FMOV  V7.D[1], X2
    FMOV  D8, X26
    FMOV  V8.D[1], X9
    FMOV  D9, X12
    FMOV  V9.D[1], X29
    FMOV  D10, X5
    FMOV  V10.D[1], X9
    FMOV  D11, X3
    FMOV  V11.D[1], X27
    FMOV  D12, X17
    FMOV  V12.D[1], X5
    FMOV  D13, X29
    FMOV  V13.D[1], X28
    FMOV  D14, X27
    FMOV  V14.D[1], X16
    FMOV  D15, X11
    FMOV  V15.D[1], X24
    FMOV  D16, X10
    FMOV  V16.D[1], X7
    FMOV  D17, X23
    FMOV  V17.D[1], X27
    FMOV  D18, X16
    FMOV  V18.D[1], X6
    FMOV  D19, X2
    FMOV  V19.D[1], X23
    FMOV  D20, X27
    FMOV  V20.D[1], X4
    FMOV  D21, X3
    FMOV  V21.D[1], X24
    FMOV  D22, X24
    FMOV  V22.D[1], X16
    FMOV  D23, X4
    FMOV  V23.D[1], X23
    FMOV  D24, X12
    FMOV  V24.D[1], X3
    FMOV  D25, X10
    FMOV  V25.D[1], X15
    FMOV  D26, X15
    FMOV  V26.D[1], X4
    FMOV  D27, X24
    FMOV  V27.D[1], X2
    FMOV  D28, X2
    FMOV  V28.D[1], X12
    FMOV  D29, X8
    FMOV  V29.D[1], X28
    FMOV  D30, X14
    FMOV  V30.D[1], X12
    FMOV  D31, X3
    FMOV  V31.D[1], X17
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X28, #0x40, LSL #0
    MOVZ  X10, #0x2300, LSL #0
    ADD  X2, X30, X10
    ST2 { V4.2D, V5.2D }, [X2]
    LD2 { V13.8H, V14.8H }, [X2]
    ADD  X2, X2, X28, LSR #0
    ST2 { V22.16B, V23.16B }, [X2]
    LD2 { V2.16B, V3.16B }, [X2]
    ADD  X2, X2, X28, ASR #0
    ST2 { V30.2D, V31.2D }, [X2]
    LD2 { V13.2D, V14.2D }, [X2]
    ADD  X2, X2, X28
    ST2 { V15.4S, V16.4S }, [X2]
    LD2 { V12.4S, V13.4S }, [X2]
    ADD  X2, X2, X28, ASR #0
    ST2 { V13.8H, V14.8H }, [X2]
    LD2 { V16.8H, V17.8H }, [X2]
    ADD  X2, X2, X28, ASR #0
    ST2 { V17.4H, V18.4H }, [X2]
    LD2 { V26.8B, V27.8B }, [X2]
    ADD  X2, X2, X28
    ST2 { V26.2S, V27.2S }, [X2]
    LD2 { V6.2S, V7.2S }, [X2]
    ADD  X2, X2, X28, LSR #0
    ST2 { V3.4H, V4.4H }, [X2]
    LD2 { V27.4H, V28.4H }, [X2]
    ADD  X2, X2, X28
    ST2 { V6.8B, V7.8B }, [X2]
    LD2 { V6.8B, V7.8B }, [X2]
    ADD  X2, X2, X28, LSR #0
    MOV  X12, X2
    ST2 { V13.4S, V14.4S }, [X12], #32
    MOV  X12, X2
    LD2 { V12.8H, V13.8H }, [X12], #32
    ADD  X2, X2, X28
    MOV  X12, X2
    ST2 { V25.16B, V26.16B }, [X12], #32
    MOV  X12, X2
    LD2 { V5.16B, V6.16B }, [X12], #32
    ADD  X2, X2, X28, ASR #0
    MOV  X12, X2
    ST2 { V14.2D, V15.2D }, [X12], #32
    MOV  X12, X2
    LD2 { V2.2D, V3.2D }, [X12], #32
    ADD  X2, X2, X28
    MOV  X12, X2
    ST2 { V12.4S, V13.4S }, [X12], #32
    MOV  X12, X2
    LD2 { V12.4S, V13.4S }, [X12], #32
    ADD  X2, X2, X28, LSR #0
    MOV  X12, X2
    ST2 { V12.8H, V13.8H }, [X12], #32
    MOV  X12, X2
    LD2 { V5.8H, V6.8H }, [X12], #32
    ADD  X2, X2, X28, LSR #0
    MOV  X12, X2
    ST2 { V2.8B, V3.8B }, [X12], #16
    MOV  X12, X2
    LD2 { V14.2S, V15.2S }, [X12], #16
    ADD  X2, X2, X28, LSR #0
    MOV  X12, X2
    ST2 { V5.2S, V6.2S }, [X12], #16
    MOV  X12, X2
    LD2 { V5.2S, V6.2S }, [X12], #16
    ADD  X2, X2, X28, ASR #0
    MOV  X12, X2
    ST2 { V5.4H, V6.4H }, [X12], #16
    MOV  X12, X2
    LD2 { V5.4H, V6.4H }, [X12], #16
    ADD  X2, X2, X28
    MOV  X12, X2
    ST2 { V5.8B, V6.8B }, [X12], #16
    MOV  X12, X2
    LD2 { V5.8B, V6.8B }, [X12], #16
    ADD  X2, X2, X28, LSR #0
    ST2 { V10.8H, V11.8H }, [X2], X13
    LD2 { V15.2D, V16.2D }, [X2], X13
    ADD  X2, X2, X28, ASR #0
    ST2 { V14.16B, V15.16B }, [X2], X13
    LD2 { V10.16B, V11.16B }, [X2], X13
    ADD  X2, X2, X28, LSR #0
    ST2 { V25.2D, V26.2D }, [X2], X13
    LD2 { V5.2D, V6.2D }, [X2], X13
    ADD  X2, X2, X28, LSR #0
    ST2 { V5.4S, V6.4S }, [X2], X13
    LD2 { V14.4S, V15.4S }, [X2], X13
    ADD  X2, X2, X28, ASR #0
    ST2 { V20.8H, V21.8H }, [X2], X13
    LD2 { V5.8H, V6.8H }, [X2], X13
    ADD  X2, X2, X28, ASR #0
    ST2 { V15.4H, V16.4H }, [X2], X13
    LD2 { V20.4H, V21.4H }, [X2], X13
    ADD  X2, X2, X28, LSR #0
    ST2 { V25.2S, V26.2S }, [X2], X13
    LD2 { V15.2S, V16.2S }, [X2], X13
    ADD  X2, X2, X28
    ST2 { V20.4H, V21.4H }, [X2], X13
    LD2 { V30.4H, V31.4H }, [X2], X13
    ADD  X2, X2, X28, LSR #0
    ST2 { V20.8B, V21.8B }, [X2], X13
    LD2 { V11.8B, V12.8B }, [X2], X13
    ADD  X2, X2, X28
    ST2 { V7.H, V8.H }[0x1], [X2]
    LD2 { V0.H, V1.H }[0x3], [X2]
    ADD  X2, X2, X28, LSR #0
    ST2 { V14.S, V15.S }[0x0], [X2]
    LD2 { V10.S, V11.S }[0x2], [X2]
    ADD  X2, X2, X28
    ST2 { V5.D, V6.D }[0x1], [X2]
    LD2 { V29.D, V30.D }[0x1], [X2]
    ADD  X2, X2, X28, LSR #0
    ST2 { V14.B, V15.B }[0xb], [X2]
    LD2 { V9.B, V10.B }[0x6], [X2]
    ADD  X2, X2, X28, ASR #0
    MOV  X12, X2
    ST2 { V10.H, V11.H }[0x5], [X12], #4
    MOV  X12, X2
    LD2 { V0.H, V1.H }[0x1], [X12], #4
    ADD  X2, X2, X28, LSR #0
    ST2 { V17.H, V18.H }[0x6], [X2], X13
    LD2 { V26.H, V27.H }[0x2], [X2], X13
    ADD  X2, X2, X28, LSR #0
    MOV  X12, X2
    ST2 { V21.S, V22.S }[0x0], [X12], #8
    MOV  X12, X2
    LD2 { V21.S, V22.S }[0x2], [X12], #8
    ADD  X2, X2, X28, ASR #0
    ST2 { V21.S, V22.S }[0x0], [X2], X13
    LD2 { V21.S, V22.S }[0x0], [X2], X13
    ADD  X2, X2, X28
    MOV  X12, X2
    ST2 { V26.D, V27.D }[0x0], [X12], #16
    MOV  X12, X2
    LD2 { V17.D, V18.D }[0x1], [X12], #16
    ADD  X2, X2, X28, LSR #0
    ST2 { V17.D, V18.D }[0x1], [X2], X13
    LD2 { V17.D, V18.D }[0x0], [X2], X13
    ADD  X2, X2, X28, ASR #0
    MOV  X12, X2
    ST2 { V21.B, V22.B }[0xe], [X12], #2
    MOV  X12, X2
    LD2 { V21.B, V22.B }[0x8], [X12], #2
    ADD  X2, X2, X28, LSR #0
    ST2 { V21.B, V22.B }[0xa], [X2], X13
    LD2 { V28.B, V29.B }[0x1], [X2], X13
    ADD  X2, X2, X28, ASR #0
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X7, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X7, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X7, X26, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X7, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X7, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X7, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X7, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X7, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X7, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X7, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X7, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X7, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X7, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X7, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X7, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MRS  X26, FPSR
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V0.D[1]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D0
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V1.D[1]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D1
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D2
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D3
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D4
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D5
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D6
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D7
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D8
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D9
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D10
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa500, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V11.D[1]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D11
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D12
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D13
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D14
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D15
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D16
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D17
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D18
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D19
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D20
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X7, #0xa500, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D21
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D22
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D23
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D24
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D25
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V26.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D26
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D27
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D28
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D29
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V30.D[1]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D30
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, V31.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    FMOV  X26, D31
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
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
    FMOV  V0.D[1], X13
    FMOV  D1, X29
    FMOV  V1.D[1], X26
    FMOV  D2, X28
    FMOV  V2.D[1], X15
    FMOV  D3, X5
    FMOV  V3.D[1], X15
    FMOV  D4, X14
    FMOV  V4.D[1], X13
    FMOV  D5, X25
    FMOV  V5.D[1], X29
    FMOV  D6, X5
    FMOV  V6.D[1], X7
    FMOV  D7, X5
    FMOV  V7.D[1], X25
    FMOV  D8, X28
    FMOV  V8.D[1], X25
    FMOV  D9, X11
    FMOV  V9.D[1], X16
    FMOV  D10, X26
    FMOV  V10.D[1], X14
    FMOV  D11, X28
    FMOV  V11.D[1], X16
    FMOV  D12, X27
    FMOV  V12.D[1], X26
    FMOV  D13, X4
    FMOV  V13.D[1], X2
    FMOV  D14, X28
    FMOV  V14.D[1], X26
    FMOV  D15, X25
    FMOV  V15.D[1], X3
    FMOV  D16, X24
    FMOV  V16.D[1], X7
    FMOV  D17, X12
    FMOV  V17.D[1], X4
    FMOV  D18, X23
    FMOV  V18.D[1], X15
    FMOV  D19, X16
    FMOV  V19.D[1], X8
    FMOV  D20, X6
    FMOV  V20.D[1], X24
    FMOV  D21, X6
    FMOV  V21.D[1], X2
    FMOV  D22, X10
    FMOV  V22.D[1], X23
    FMOV  D23, X14
    FMOV  V23.D[1], X4
    FMOV  D24, X11
    FMOV  V24.D[1], X8
    FMOV  D25, X24
    FMOV  V25.D[1], X5
    FMOV  D26, X3
    FMOV  V26.D[1], X11
    FMOV  D27, X24
    FMOV  V27.D[1], X11
    FMOV  D28, X11
    FMOV  V28.D[1], X2
    FMOV  D29, X24
    FMOV  V29.D[1], X5
    FMOV  D30, X29
    FMOV  V30.D[1], X2
    FMOV  D31, X6
    FMOV  V31.D[1], X16
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X10, #0x40, LSL #0
    MOVZ  X28, #0x2800, LSL #0
    ADD  X16, X30, X28, ASR #0
    ST2 { V13.4S, V14.4S }, [X16]
    LD2 { V27.8H, V28.8H }, [X16]
    ADD  X16, X16, X10, ASR #0
    ST2 { V29.16B, V30.16B }, [X16]
    LD2 { V25.16B, V26.16B }, [X16]
    ADD  X16, X16, X10, ASR #0
    ST2 { V26.2D, V27.2D }, [X16]
    LD2 { V3.2D, V4.2D }, [X16]
    ADD  X16, X16, X10, ASR #0
    ST2 { V3.4S, V4.4S }, [X16]
    LD2 { V3.4S, V4.4S }, [X16]
    ADD  X16, X16, X10, LSR #0
    ST2 { V1.8H, V2.8H }, [X16]
    LD2 { V9.8H, V10.8H }, [X16]
    ADD  X16, X16, X10, LSR #0
    ST2 { V3.8B, V4.8B }, [X16]
    LD2 { V4.4H, V5.4H }, [X16]
    ADD  X16, X16, X10
    ST2 { V27.2S, V28.2S }, [X16]
    LD2 { V19.2S, V20.2S }, [X16]
    ADD  X16, X16, X10
    ST2 { V19.4H, V20.4H }, [X16]
    LD2 { V29.4H, V30.4H }, [X16]
    ADD  X16, X16, X10, LSR #0
    ST2 { V21.8B, V22.8B }, [X16]
    LD2 { V17.8B, V18.8B }, [X16]
    ADD  X16, X16, X10, LSR #0
    MOV  X24, X16
    ST2 { V17.8H, V18.8H }, [X24], #32
    MOV  X24, X16
    LD2 { V14.4S, V15.4S }, [X24], #32
    ADD  X16, X16, X10
    MOV  X24, X16
    ST2 { V18.16B, V19.16B }, [X24], #32
    MOV  X24, X16
    LD2 { V22.16B, V23.16B }, [X24], #32
    ADD  X16, X16, X10, ASR #0
    MOV  X24, X16
    ST2 { V14.2D, V15.2D }, [X24], #32
    MOV  X24, X16
    LD2 { V27.2D, V28.2D }, [X24], #32
    ADD  X16, X16, X10
    MOV  X24, X16
    ST2 { V18.4S, V19.4S }, [X24], #32
    MOV  X24, X16
    LD2 { V20.4S, V21.4S }, [X24], #32
    ADD  X16, X16, X10, LSR #0
    MOV  X24, X16
    ST2 { V21.8H, V22.8H }, [X24], #32
    MOV  X24, X16
    LD2 { V13.8H, V14.8H }, [X24], #32
    ADD  X16, X16, X10, ASR #0
    MOV  X24, X16
    ST2 { V5.2S, V6.2S }, [X24], #16
    MOV  X24, X16
    LD2 { V4.2S, V5.2S }, [X24], #16
    ADD  X16, X16, X10, ASR #0
    MOV  X24, X16
    ST2 { V6.2S, V7.2S }, [X24], #16
    MOV  X24, X16
    LD2 { V15.2S, V16.2S }, [X24], #16
    ADD  X16, X16, X10, LSR #0
    MOV  X24, X16
    ST2 { V13.4H, V14.4H }, [X24], #16
    MOV  X24, X16
    LD2 { V19.4H, V20.4H }, [X24], #16
    ADD  X16, X16, X10
    MOV  X24, X16
    ST2 { V9.8B, V10.8B }, [X24], #16
    MOV  X24, X16
    LD2 { V14.8B, V15.8B }, [X24], #16
    ADD  X16, X16, X10
    ST2 { V8.2D, V9.2D }, [X16], X11
    LD2 { V8.2D, V9.2D }, [X16], X11
    ADD  X16, X16, X10, LSR #0
    ST2 { V19.16B, V20.16B }, [X16], X11
    LD2 { V7.16B, V8.16B }, [X16], X11
    ADD  X16, X16, X10, LSR #0
    ST2 { V14.2D, V15.2D }, [X16], X11
    LD2 { V16.2D, V17.2D }, [X16], X11
    ADD  X16, X16, X10, ASR #0
    ST2 { V8.4S, V9.4S }, [X16], X11
    LD2 { V28.4S, V29.4S }, [X16], X11
    ADD  X16, X16, X10
    ST2 { V16.8H, V17.8H }, [X16], X11
    LD2 { V27.8H, V28.8H }, [X16], X11
    ADD  X16, X16, X10, ASR #0
    ST2 { V27.8B, V28.8B }, [X16], X11
    LD2 { V19.4H, V20.4H }, [X16], X11
    ADD  X16, X16, X10, ASR #0
    ST2 { V26.2S, V27.2S }, [X16], X11
    LD2 { V14.2S, V15.2S }, [X16], X11
    ADD  X16, X16, X10, LSR #0
    ST2 { V14.4H, V15.4H }, [X16], X11
    LD2 { V22.4H, V23.4H }, [X16], X11
    ADD  X16, X16, X10, LSR #0
    ST2 { V22.8B, V23.8B }, [X16], X11
    LD2 { V29.8B, V30.8B }, [X16], X11
    ADD  X16, X16, X10, ASR #0
    ST2 { V11.H, V12.H }[0x2], [X16]
    LD2 { V23.H, V24.H }[0x3], [X16]
    ADD  X16, X16, X10
    ST2 { V23.S, V24.S }[0x2], [X16]
    LD2 { V22.S, V23.S }[0x1], [X16]
    ADD  X16, X16, X10
    ST2 { V25.D, V26.D }[0x0], [X16]
    LD2 { V26.D, V27.D }[0x0], [X16]
    ADD  X16, X16, X10, ASR #0
    ST2 { V9.B, V10.B }[0x5], [X16]
    LD2 { V13.B, V14.B }[0x7], [X16]
    ADD  X16, X16, X10, ASR #0
    MOV  X24, X16
    ST2 { V26.H, V27.H }[0x0], [X24], #4
    MOV  X24, X16
    LD2 { V10.H, V11.H }[0x4], [X24], #4
    ADD  X16, X16, X10, LSR #0
    ST2 { V21.H, V22.H }[0x3], [X16], X11
    LD2 { V16.H, V17.H }[0x5], [X16], X11
    ADD  X16, X16, X10, LSR #0
    MOV  X24, X16
    ST2 { V12.S, V13.S }[0x1], [X24], #8
    MOV  X24, X16
    LD2 { V12.S, V13.S }[0x3], [X24], #8
    ADD  X16, X16, X10, ASR #0
    ST2 { V12.S, V13.S }[0x1], [X16], X11
    LD2 { V26.S, V27.S }[0x1], [X16], X11
    ADD  X16, X16, X10, LSR #0
    MOV  X24, X16
    ST2 { V16.D, V17.D }[0x0], [X24], #16
    MOV  X24, X16
    LD2 { V16.D, V17.D }[0x0], [X24], #16
    ADD  X16, X16, X10, LSR #0
    ST2 { V16.D, V17.D }[0x0], [X16], X11
    LD2 { V12.D, V13.D }[0x1], [X16], X11
    ADD  X16, X16, X10
    MOV  X24, X16
    ST2 { V26.B, V27.B }[0x5], [X24], #2
    MOV  X24, X16
    LD2 { V13.B, V14.B }[0x2], [X24], #2
    ADD  X16, X16, X10, ASR #0
    ST2 { V28.B, V29.B }[0x2], [X16], X11
    LD2 { V26.B, V27.B }[0xd], [X16], X11
    ADD  X16, X16, X10
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X12, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X12, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X12, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X12, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X12, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X12, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X12, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X12, X25, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X12, X25, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X12, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X12, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X12, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X12, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP05_TestFail
    MRS  X25, FPSR
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V0.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D0
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V1.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D1
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V2.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D2
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V3.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D3
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V4.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D4
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V5.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D5
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V6.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D6
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V7.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D7
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V8.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D8
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V9.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D9
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V10.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D10
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V11.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D11
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V12.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D12
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V13.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D13
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V14.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D14
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V15.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D15
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V16.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D16
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V17.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D17
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V18.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D18
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V19.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D19
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V20.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D20
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V21.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D21
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V22.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D22
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V23.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D23
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V24.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D24
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V25.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D25
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V26.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D26
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V27.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x5a00, LSL #32
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D27
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V28.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D28
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V29.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D29
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V30.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D30
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, V31.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    FMOV  X25, D31
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
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
    FMOV  D0, X5
    FMOV  V0.D[1], X26
    FMOV  D1, X28
    FMOV  V1.D[1], X25
    FMOV  D2, X29
    FMOV  V2.D[1], X24
    FMOV  D3, X27
    FMOV  V3.D[1], X7
    FMOV  D4, X6
    FMOV  V4.D[1], X25
    FMOV  D5, X8
    FMOV  V5.D[1], X25
    FMOV  D6, X9
    FMOV  V6.D[1], X14
    FMOV  D7, X27
    FMOV  V7.D[1], X10
    FMOV  D8, X24
    FMOV  V8.D[1], X3
    FMOV  D9, X2
    FMOV  V9.D[1], X9
    FMOV  D10, X16
    FMOV  V10.D[1], X4
    FMOV  D11, X4
    FMOV  V11.D[1], X16
    FMOV  D12, X8
    FMOV  V12.D[1], X24
    FMOV  D13, X25
    FMOV  V13.D[1], X11
    FMOV  D14, X27
    FMOV  V14.D[1], X12
    FMOV  D15, X9
    FMOV  V15.D[1], X2
    FMOV  D16, X29
    FMOV  V16.D[1], X6
    FMOV  D17, X13
    FMOV  V17.D[1], X16
    FMOV  D18, X6
    FMOV  V18.D[1], X13
    FMOV  D19, X6
    FMOV  V19.D[1], X8
    FMOV  D20, X9
    FMOV  V20.D[1], X27
    FMOV  D21, X24
    FMOV  V21.D[1], X12
    FMOV  D22, X5
    FMOV  V22.D[1], X15
    FMOV  D23, X12
    FMOV  V23.D[1], X12
    FMOV  D24, X29
    FMOV  V24.D[1], X8
    FMOV  D25, X6
    FMOV  V25.D[1], X16
    FMOV  D26, X26
    FMOV  V26.D[1], X17
    FMOV  D27, X17
    FMOV  V27.D[1], X7
    FMOV  D28, X27
    FMOV  V28.D[1], X2
    FMOV  D29, X8
    FMOV  V29.D[1], X23
    FMOV  D30, X17
    FMOV  V30.D[1], X3
    FMOV  D31, X15
    FMOV  V31.D[1], X15
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X4, #0x40, LSL #0
    MOVZ  X7, #0x2d00, LSL #0
    ADD  X12, X30, X7
    ST2 { V29.16B, V30.16B }, [X12]
    LD2 { V30.8H, V31.8H }, [X12]
    ADD  X12, X12, X4, ASR #0
    ST2 { V17.16B, V18.16B }, [X12]
    LD2 { V16.16B, V17.16B }, [X12]
    ADD  X12, X12, X4, ASR #0
    ST2 { V16.2D, V17.2D }, [X12]
    LD2 { V25.2D, V26.2D }, [X12]
    ADD  X12, X12, X4, ASR #0
    ST2 { V21.4S, V22.4S }, [X12]
    LD2 { V28.4S, V29.4S }, [X12]
    ADD  X12, X12, X4, LSR #0
    ST2 { V25.8H, V26.8H }, [X12]
    LD2 { V4.8H, V5.8H }, [X12]
    ADD  X12, X12, X4, ASR #0
    ST2 { V29.2S, V30.2S }, [X12]
    LD2 { V12.2S, V13.2S }, [X12]
    ADD  X12, X12, X4, ASR #0
    ST2 { V4.2S, V5.2S }, [X12]
    LD2 { V23.2S, V24.2S }, [X12]
    ADD  X12, X12, X4
    ST2 { V18.4H, V19.4H }, [X12]
    LD2 { V5.4H, V6.4H }, [X12]
    ADD  X12, X12, X4, LSR #0
    ST2 { V12.8B, V13.8B }, [X12]
    LD2 { V29.8B, V30.8B }, [X12]
    ADD  X12, X12, X4, ASR #0
    MOV  X29, X12
    ST2 { V25.4S, V26.4S }, [X29], #32
    MOV  X29, X12
    LD2 { V16.2D, V17.2D }, [X29], #32
    ADD  X12, X12, X4, ASR #0
    MOV  X29, X12
    ST2 { V16.16B, V17.16B }, [X29], #32
    MOV  X29, X12
    LD2 { V31.16B, V0.16B }, [X29], #32
    ADD  X12, X12, X4, ASR #0
    MOV  X29, X12
    ST2 { V23.2D, V24.2D }, [X29], #32
    MOV  X29, X12
    LD2 { V27.2D, V28.2D }, [X29], #32
    ADD  X12, X12, X4, ASR #0
    MOV  X29, X12
    ST2 { V29.4S, V30.4S }, [X29], #32
    MOV  X29, X12
    LD2 { V23.4S, V24.4S }, [X29], #32
    ADD  X12, X12, X4, ASR #0
    MOV  X29, X12
    ST2 { V31.8H, V0.8H }, [X29], #32
    MOV  X29, X12
    LD2 { V11.8H, V12.8H }, [X29], #32
    ADD  X12, X12, X4
    MOV  X29, X12
    ST2 { V19.8B, V20.8B }, [X29], #16
    MOV  X29, X12
    LD2 { V7.4H, V8.4H }, [X29], #16
    ADD  X12, X12, X4, LSR #0
    MOV  X29, X12
    ST2 { V23.2S, V24.2S }, [X29], #16
    MOV  X29, X12
    LD2 { V13.2S, V14.2S }, [X29], #16
    ADD  X12, X12, X4, LSR #0
    MOV  X29, X12
    ST2 { V7.4H, V8.4H }, [X29], #16
    MOV  X29, X12
    LD2 { V23.4H, V24.4H }, [X29], #16
    ADD  X12, X12, X4, ASR #0
    MOV  X29, X12
    ST2 { V23.8B, V24.8B }, [X29], #16
    MOV  X29, X12
    LD2 { V14.8B, V15.8B }, [X29], #16
    ADD  X12, X12, X4, LSR #0
    ST2 { V5.2D, V6.2D }, [X12], X26
    LD2 { V28.2D, V29.2D }, [X12], X26
    ADD  X12, X12, X4, LSR #0
    ST2 { V17.16B, V18.16B }, [X12], X26
    LD2 { V16.16B, V17.16B }, [X12], X26
    ADD  X12, X12, X4, ASR #0
    ST2 { V2.2D, V3.2D }, [X12], X26
    LD2 { V31.2D, V0.2D }, [X12], X26
    ADD  X12, X12, X4, ASR #0
    ST2 { V31.4S, V0.4S }, [X12], X26
    LD2 { V11.4S, V12.4S }, [X12], X26
    ADD  X12, X12, X4, LSR #0
    ST2 { V16.8H, V17.8H }, [X12], X26
    LD2 { V3.8H, V4.8H }, [X12], X26
    ADD  X12, X12, X4, LSR #0
    ST2 { V14.8B, V15.8B }, [X12], X26
    LD2 { V14.2S, V15.2S }, [X12], X26
    ADD  X12, X12, X4, LSR #0
    ST2 { V28.2S, V29.2S }, [X12], X26
    LD2 { V5.2S, V6.2S }, [X12], X26
    ADD  X12, X12, X4, LSR #0
    ST2 { V28.4H, V29.4H }, [X12], X26
    LD2 { V6.4H, V7.4H }, [X12], X26
    ADD  X12, X12, X4, ASR #0
    ST2 { V5.8B, V6.8B }, [X12], X26
    LD2 { V28.8B, V29.8B }, [X12], X26
    ADD  X12, X12, X4
    ST2 { V13.H, V14.H }[0x2], [X12]
    LD2 { V13.H, V14.H }[0x4], [X12]
    ADD  X12, X12, X4, LSR #0
    ST2 { V3.S, V4.S }[0x1], [X12]
    LD2 { V29.S, V30.S }[0x2], [X12]
    ADD  X12, X12, X4
    ST2 { V11.D, V12.D }[0x1], [X12]
    LD2 { V5.D, V6.D }[0x1], [X12]
    ADD  X12, X12, X4
    ST2 { V6.B, V7.B }[0x9], [X12]
    LD2 { V3.B, V4.B }[0xb], [X12]
    ADD  X12, X12, X4
    MOV  X29, X12
    ST2 { V28.H, V29.H }[0x4], [X29], #4
    MOV  X29, X12
    LD2 { V18.H, V19.H }[0x3], [X29], #4
    ADD  X12, X12, X4
    ST2 { V3.H, V4.H }[0x7], [X12], X26
    LD2 { V11.H, V12.H }[0x6], [X12], X26
    ADD  X12, X12, X4
    MOV  X29, X12
    ST2 { V18.S, V19.S }[0x2], [X29], #8
    MOV  X29, X12
    LD2 { V3.S, V4.S }[0x3], [X29], #8
    ADD  X12, X12, X4, ASR #0
    ST2 { V3.S, V4.S }[0x3], [X12], X26
    LD2 { V18.S, V19.S }[0x1], [X12], X26
    ADD  X12, X12, X4
    MOV  X29, X12
    ST2 { V18.D, V19.D }[0x0], [X29], #16
    MOV  X29, X12
    LD2 { V6.D, V7.D }[0x1], [X29], #16
    ADD  X12, X12, X4
    ST2 { V0.D, V1.D }[0x1], [X12], X26
    LD2 { V18.D, V19.D }[0x1], [X12], X26
    ADD  X12, X12, X4, ASR #0
    MOV  X29, X12
    ST2 { V14.B, V15.B }[0xc], [X29], #2
    MOV  X29, X12
    LD2 { V2.B, V3.B }[0x9], [X29], #2
    ADD  X12, X12, X4, ASR #0
    ST2 { V13.B, V14.B }[0x7], [X12], X26
    LD2 { V0.B, V1.B }[0xa], [X12], X26
    ADD  X12, X12, X4
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MRS  X6, FPSR
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V0.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D0
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V1.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D1
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X17, #0xa5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D2
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X17, #0xa5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D3
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V4.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D4
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D5
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V6.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D6
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D7
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D8
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V9.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D9
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D10
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V11.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D11
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V12.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D12
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D13
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V14.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D14
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V15.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D15
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D16
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D17
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V18.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D18
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D19
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V20.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D20
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D21
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V22.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D22
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D23
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D24
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V25.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D25
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D26
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V27.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D27
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D28
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V29.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D29
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V30.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D30
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, V31.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    FMOV  X6, D31
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail

AdvsimdLoadStoreP05_TestEnd:
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
AdvsimdLoadStoreP05_TestFail:
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
