.global GeneralLoadStoreP04

.text
.p2align 4

GeneralLoadStoreP04:

GeneralLoadStoreP04_TestBegin:
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
    MRS  X2, NZCV
    STP  X2, X3, [SP, #-16]!
    MOVZ  X2, #0x1423, LSL #0
    MOVK  X2, #0xf50b, LSL #16
    MOVK  X2, #0x4ade, LSL #32
    MOVK  X2, #0xbd3a, LSL #48
    MOVZ  X4, #0xeba8, LSL #0
    MOVK  X4, #0xe3f8, LSL #16
    MOVK  X4, #0xab1d, LSL #32
    MOVK  X4, #0xedb4, LSL #48
    MOVZ  X5, #0x4fb7, LSL #0
    MOVK  X5, #0x7fc2, LSL #16
    MOVK  X5, #0xe466, LSL #32
    MOVK  X5, #0xc7ed, LSL #48
    MOVZ  X6, #0x7332, LSL #0
    MOVK  X6, #0x7c41, LSL #16
    MOVK  X6, #0x56ad, LSL #32
    MOVK  X6, #0xcc61, LSL #48
    MOVZ  X7, #0x9d97, LSL #0
    MOVK  X7, #0x21f2, LSL #16
    MOVK  X7, #0x7658, LSL #32
    MOVK  X7, #0x123b, LSL #48
    MOVZ  X8, #0xeef, LSL #0
    MOVK  X8, #0xb8f0, LSL #16
    MOVK  X8, #0xd105, LSL #32
    MOVK  X8, #0xc6ea, LSL #48
    MOVZ  X9, #0xe6cc, LSL #0
    MOVK  X9, #0x6ebb, LSL #16
    MOVK  X9, #0x474d, LSL #32
    MOVK  X9, #0x860d, LSL #48
    MOVZ  X10, #0x9a94, LSL #0
    MOVK  X10, #0x35e8, LSL #16
    MOVK  X10, #0x8849, LSL #32
    MOVK  X10, #0x6e43, LSL #48
    MOVZ  X11, #0x81e5, LSL #0
    MOVK  X11, #0xfdd2, LSL #16
    MOVK  X11, #0x959a, LSL #32
    MOVK  X11, #0xaef0, LSL #48
    MOVZ  X13, #0xa104, LSL #0
    MOVK  X13, #0x1709, LSL #16
    MOVK  X13, #0x2eb9, LSL #32
    MOVK  X13, #0x657, LSL #48
    MOVZ  X15, #0xeba0, LSL #0
    MOVK  X15, #0x19d9, LSL #16
    MOVK  X15, #0x962a, LSL #32
    MOVK  X15, #0x3a73, LSL #48
    MOVZ  X16, #0x3f35, LSL #0
    MOVK  X16, #0x35c2, LSL #16
    MOVK  X16, #0xa6b7, LSL #32
    MOVK  X16, #0x48f3, LSL #48
    MOVZ  X17, #0xbeec, LSL #0
    MOVK  X17, #0xe706, LSL #16
    MOVK  X17, #0x4f8c, LSL #32
    MOVK  X17, #0x3b17, LSL #48
    MOVZ  X18, #0x8cf8, LSL #0
    MOVK  X18, #0xa398, LSL #16
    MOVK  X18, #0xd2e9, LSL #32
    MOVK  X18, #0x30e1, LSL #48
    MOVZ  X20, #0x686, LSL #0
    MOVK  X20, #0xd7f2, LSL #16
    MOVK  X20, #0xcbe7, LSL #32
    MOVK  X20, #0xa0f1, LSL #48
    MOVZ  X21, #0x4606, LSL #0
    MOVK  X21, #0x1cf8, LSL #16
    MOVK  X21, #0x217e, LSL #32
    MOVK  X21, #0xa389, LSL #48
    MOVZ  X22, #0x4b1d, LSL #0
    MOVK  X22, #0x4817, LSL #16
    MOVK  X22, #0xe044, LSL #32
    MOVK  X22, #0x1042, LSL #48
    MOVZ  X23, #0x4183, LSL #0
    MOVK  X23, #0x6f81, LSL #16
    MOVK  X23, #0x57bb, LSL #32
    MOVK  X23, #0x763a, LSL #48
    MOVZ  X24, #0xa6c8, LSL #0
    MOVK  X24, #0x305e, LSL #16
    MOVK  X24, #0xe39e, LSL #32
    MOVK  X24, #0xd827, LSL #48
    MOVZ  X25, #0x99c9, LSL #0
    MOVK  X25, #0x1df1, LSL #16
    MOVK  X25, #0x8e49, LSL #32
    MOVK  X25, #0x4b04, LSL #48
    MOVZ  X26, #0x272, LSL #0
    MOVK  X26, #0x557a, LSL #16
    MOVK  X26, #0x482b, LSL #32
    MOVK  X26, #0xfdbb, LSL #48
    MOVZ  X27, #0x843e, LSL #0
    MOVK  X27, #0xe8c, LSL #16
    MOVK  X27, #0x58b3, LSL #32
    MOVK  X27, #0xc4b8, LSL #48
    MOVZ  X28, #0xd214, LSL #0
    MOVK  X28, #0x6f4f, LSL #16
    MOVK  X28, #0x1a3, LSL #32
    MOVK  X28, #0x4388, LSL #48
    MOVZ  X29, #0xa95c, LSL #0
    MOVK  X29, #0x1362, LSL #16
    MOVK  X29, #0xe7b2, LSL #32
    MOVK  X29, #0x7e79, LSL #48
    SUBS  X18, X25, X29, LSR #10
    MOV  X30, X1
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
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
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
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
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X29, #0x10, LSL #0
    MOVZ  X10, #0x0, LSL #0
    ADD  X11, X30, X10
    STP  X28, X9, [X11, #0]
    LDPSW  X22, X7, [X11, #0]
    ADD  X11, X11, X29
    STP  X27, X22, [X11, #0]
    LDRSB  W5, [X11], #0
    ADD  X11, X11, X29
    STP  X7, X7, [X11, #0]
    LDRSB  X25, [X11], #0
    ADD  X11, X11, X29
    STP  X5, X5, [X11, #0]
    LDRSB  W27, [X11, #0]!
    ADD  X11, X11, X29
    STP  X27, X25, [X11, #0]
    LDRSB  X27, [X11, #0]!
    ADD  X11, X11, X29
    STP  X27, X24, [X11, #0]
    LDRSB  W17, [X11, #0]
    ADD  X11, X11, X29, LSR #0
    STP  X24, X27, [X11, #0]
    LDRSB  X8, [X11, #0]
    ADD  X11, X11, X29
    STP  X23, X15, [X11, #0]
    LDRSB W7, [X11, X9, LSL #0]
    ADD  X11, X11, X29
    STP  X27, X23, [X11, #0]
    LDRSB W2, [X11, W9, SXTW #0]
    ADD  X11, X11, X29, LSR #0
    STP  X28, X23, [X11, #0]
    LDRSB W13, [X11, X9, SXTX #0]
    ADD  X11, X11, X29, ASR #0
    STP  X21, X8, [X11, #0]
    LDRSB W27, [X11, W9, UXTW #0]
    ADD  X11, X11, X29, ASR #0
    STP  X25, X2, [X11, #0]
    LDRSB X15, [X11, X9, LSL #0]
    ADD  X11, X11, X29, ASR #0
    STP  X4, X28, [X11, #0]
    LDRSB X8, [X11, W9, SXTW #0]
    ADD  X11, X11, X29
    STP  X24, X24, [X11, #0]
    LDRSB X21, [X11, X9, SXTX #0]
    ADD  X11, X11, X29
    STP  X21, X7, [X11, #0]
    LDRSB X25, [X11, W9, UXTW #0]
    ADD  X11, X11, X29
    STP  X5, X28, [X11, #0]
    LDRSH  W23, [X11], #0
    ADD  X11, X11, X29, LSR #0
    STP  X26, X22, [X11, #0]
    LDRSH  X2, [X11], #0
    ADD  X11, X11, X29, ASR #0
    STP  X16, X21, [X11, #0]
    LDRSH  W24, [X11, #0]!
    ADD  X11, X11, X29, LSR #0
    STP  X15, X25, [X11, #0]
    LDRSH  X5, [X11, #0]!
    ADD  X11, X11, X29, LSR #0
    STP  X24, X24, [X11, #0]
    LDRSH  W21, [X11, #0]
    ADD  X11, X11, X29, ASR #0
    STP  X2, X21, [X11, #0]
    LDRSH  X26, [X11, #0]
    ADD  X11, X11, X29, ASR #0
    STP  X23, X5, [X11, #0]
    LDRSH W2, [X11, X9, LSL #1]
    ADD  X11, X11, X29, LSR #0
    STP  X26, X26, [X11, #0]
    LDRSH W21, [X11, W9, SXTW #0]
    ADD  X11, X11, X29
    STP  X2, X6, [X11, #0]
    LDRSH W25, [X11, X9, SXTX #0]
    ADD  X11, X11, X29, LSR #0
    STP  X2, X27, [X11, #0]
    LDRSH W26, [X11, W9, UXTW #0]
    ADD  X11, X11, X29, LSR #0
    STP  X27, X2, [X11, #0]
    LDRSH X16, [X11, X9, LSL #0]
    ADD  X11, X11, X29, ASR #0
    STP  X8, X27, [X11, #0]
    LDRSH X2, [X11, W9, SXTW #0]
    ADD  X11, X11, X29
    STP  X7, X9, [X11, #0]
    LDRSH X6, [X11, X9, SXTX #0]
    ADD  X11, X11, X29, LSR #0
    STP  X21, X9, [X11, #0]
    LDRSH X7, [X11, W9, UXTW #1]
    ADD  X11, X11, X29
    STP  X9, X25, [X11, #0]
    LDRSW  X8, [X11], #0
    ADD  X11, X11, X29, LSR #0
    STP  X25, X27, [X11, #0]
    LDRSW  X21, [X11, #0]!
    ADD  X11, X11, X29
    STP  X8, X23, [X11, #0]
    LDRSW  X23, [X11, #0]
    ADD  X11, X11, X29, LSR #0
    STP  X17, X13, [X11, #0]
    LDRSW X27, [X11, X23, LSL #2]
    ADD  X11, X11, X29, LSR #0
    STP  X15, X4, [X11, #0]
    LDRSW X25, [X11, W9, SXTW #0]
    ADD  X11, X11, X29
    STP  X2, X21, [X11, #0]
    LDRSW X8, [X11, X23, SXTX #2]
    ADD  X11, X11, X29, ASR #0
    STP  X25, X7, [X11, #0]
    LDRSW X4, [X11, W9, UXTW #2]
    ADD  X11, X11, X29, ASR #0
    STP  X4, X27, [X11, #0]
    LDTRSB  W2, [X11, #0]
    ADD  X11, X11, X29, ASR #0
    STP  X8, X2, [X11, #0]
    LDTRSB  X15, [X11, #0]
    ADD  X11, X11, X29, ASR #0
    STP  X23, X9, [X11, #0]
    LDTRSH  W17, [X11, #0]
    ADD  X11, X11, X29, ASR #0
    STP  X9, X6, [X11, #0]
    LDTRSH  X6, [X11, #0]
    ADD  X11, X11, X29
    STP  X28, X8, [X11, #0]
    LDTRSW  X23, [X11, #0]
    ADD  X11, X11, X29, LSR #0
    STP  X25, X24, [X11, #0]
    LDURSB  W13, [X11, #0]
    ADD  X11, X11, X29, LSR #0
    STP  X6, X4, [X11, #0]
    LDURSB  X24, [X11, #0]
    ADD  X11, X11, X29, LSR #0
    STP  X6, X7, [X11, #0]
    LDURSH  W8, [X11, #0]
    ADD  X11, X11, X29, LSR #0
    STP  X22, X27, [X11, #0]
    LDURSH  X22, [X11, #0]
    ADD  X11, X11, X29, LSR #0
    STP  X25, X21, [X11, #0]
    LDURSW  X21, [X11, #0]
    ADD  X11, X11, X29, ASR #0
    STP  X8, X15, [X11, #0]
    LDXP  W27, W25, [X11,#0]
    ADD  X11, X11, X29
    STP  X23, X25, [X11, #0]
    LDXP  X7, X6, [X11,#0]
    ADD  X11, X11, X29, LSR #0
    STP  X7, X6, [X11, #0]
    LDXR  W15, [X11,#0]
    ADD  X11, X11, X29, ASR #0
    STP  X22, X22, [X11, #0]
    LDXR  X28, [X11,#0]
    ADD  X11, X11, X29, LSR #0
    STP  X24, X21, [X11, #0]
    LDXRB  W22, [X11,#0]
    ADD  X11, X11, X29, LSR #0
    STP  X15, X27, [X11, #0]
    LDXRH  W4, [X11,#0]
    ADD  X11, X11, X29
    STRB  W2, [X11, #0]
    LDRB  W25, [X11, #0]
    ADD  X11, X11, X29
    STRB W28, [X11, X22, LSL #0]
    LDRB W28, [X11, X22, LSL #0]
    ADD  X11, X11, X29
    STRB W28, [X11, W6, SXTW #0]
    LDRB W27, [X11, W24, SXTW #0]
    ADD  X11, X11, X29, ASR #0
    STRB W28, [X11, X8, SXTX #0]
    LDRB W15, [X11, X17, SXTX #0]
    ADD  X11, X11, X29, LSR #0
    STRB W4, [X11, W6, UXTW #0]
    LDRB W4, [X11, W17, UXTW #0]
    ADD  X11, X11, X29, ASR #0
    STRH  W27, [X11, #0]
    LDRH  W2, [X11, #0]
    ADD  X11, X11, X29, LSR #0
    STRH W25, [X11, X8, LSL #0]
    LDRH W27, [X11, X8, LSL #1]
    ADD  X11, X11, X29, LSR #0
    STRH W15, [X11, W9, SXTW #1]
    LDRH W21, [X11, W6, SXTW #0]
    ADD  X11, X11, X29, LSR #0
    STRH W21, [X11, X6, SXTX #1]
    LDRH W24, [X11, X17, SXTX #0]
    ADD  X11, X11, X29, ASR #0
    STRH W2, [X11, W22, UXTW #1]
    LDRH W2, [X11, W9, UXTW #1]
    ADD  X11, X11, X29, ASR #0
    STR  W27, [X11, #0]
    LDR  W17, [X11, #0]
    ADD  X11, X11, X29, LSR #0
    STR  X2, [X11, #0]
    LDR  X28, [X11, #0]
    ADD  X11, X11, X29, LSR #0
    STR W4, [X11, X8, LSL #2]
    LDR W26, [X11, X6, LSL #0]
    ADD  X11, X11, X29, ASR #0
    STR W17, [X11, W22, SXTW #0]
    LDR W2, [X11, W6, SXTW #2]
    ADD  X11, X11, X29
    STR W2, [X11, X22, SXTX #2]
    LDR W27, [X11, X9, SXTX #0]
    ADD  X11, X11, X29, ASR #0
    STR W24, [X11, W9, UXTW #0]
    LDR W2, [X11, W22, UXTW #2]
    ADD  X11, X11, X29, ASR #0
    STR X25, [X11, X6, LSL #3]
    LDR X6, [X11, X6, LSL #3]
    ADD  X11, X11, X29
    STR X28, [X11, W8, SXTW #3]
    LDR X24, [X11, W22, SXTW #3]
    ADD  X11, X11, X29
    STR X27, [X11, X8, SXTX #3]
    LDR X15, [X11, X9, SXTX #0]
    ADD  X11, X11, X29
    STR X24, [X11, W22, UXTW #0]
    LDR X27, [X11, W9, UXTW #0]
    ADD  X11, X11, X29, ASR #0
    STP  W6, W6, [X11, #0]
    LDP  W8, W25, [X11, #0]
    ADD  X11, X11, X29, ASR #0
    STP  X15, X8, [X11, #0]
    LDP  X28, X25, [X11, #0]
    ADD  X11, X11, X29, LSR #0
    STTR  W28, [X11, #0]
    LDTR  W15, [X11, #0]
    ADD  X11, X11, X29, LSR #0
    STTR  X27, [X11, #0]
    LDTR  X22, [X11, #0]
    ADD  X11, X11, X29, ASR #0
    STTRB  W22, [X11, #0]
    LDTRB  W22, [X11, #0]
    ADD  X11, X11, X29, ASR #0
    STTRH  W25, [X11, #0]
    LDTRH  W8, [X11, #0]
    ADD  X11, X11, X29
    STUR  W15, [X11, #0]
    LDUR  W25, [X11, #0]
    ADD  X11, X11, X29
    STUR  X16, [X11, #0]
    LDUR  X15, [X11, #0]
    ADD  X11, X11, X29, LSR #0
    STURB  W24, [X11, #0]
    LDURB  W27, [X11, #0]
    ADD  X11, X11, X29
    STURH  W22, [X11, #0]
    LDURH  W16, [X11, #0]
    ADD  X11, X11, X29, LSR #0
    STLR  W27, [X11,#0]
    LDAR  W22, [X11,#0]
    ADD  X11, X11, X29, LSR #0
    STLR  X15, [X11,#0]
    LDAR  X27, [X11,#0]
    ADD  X11, X11, X29
    STLRB  W25, [X11,#0]
    LDARB  W24, [X11,#0]
    ADD  X11, X11, X29, ASR #0
    STLRH  W16, [X11,#0]
    LDARH  W15, [X11,#0]
    ADD  X11, X11, X29, LSR #0
    STNP  W2, W15, [X11, #0]
    LDNP  W17, W16, [X11, #0]
    ADD  X11, X11, X29, ASR #0
    STNP  X22, X22, [X11, #0]
    LDNP  X2, X25, [X11, #0]
    ADD  X11, X11, X29, ASR #0
    STP  W16, W17, [X11], #0
    LDP  W15, W8, [X11], #0
    ADD  X11, X11, X29, LSR #0
    STP  X24, X2, [X11], #0
    LDP  X2, X16, [X11], #0
    ADD  X11, X11, X29
    STP  W16, W2, [X11, #0]!
    LDP  W25, W22, [X11, #0]!
    ADD  X11, X11, X29, LSR #0
    STP  X15, X15, [X11, #0]!
    LDP  X2, X16, [X11, #0]!
    ADD  X11, X11, X29, ASR #0
    STR  W2, [X11], #0
    LDR  W2, [X11], #0
    ADD  X11, X11, X29, ASR #0
    STR  X8, [X11], #0
    LDR  X24, [X11], #0
    ADD  X11, X11, X29, LSR #0
    STR  W22, [X11, #0]!
    LDR  W17, [X11, #0]!
    ADD  X11, X11, X29, ASR #0
    STR  X25, [X11, #0]!
    LDR  X25, [X11, #0]!
    ADD  X11, X11, X29, ASR #0
    STRB  W24, [X11], #0
    LDRB  W22, [X11], #0
    ADD  X11, X11, X29, ASR #0
    STRB  W25, [X11, #0]!
    LDRB  W15, [X11, #0]!
    ADD  X11, X11, X29, LSR #0
    STRH  W9, [X11], #0
    LDRH  W25, [X11], #0
    ADD  X11, X11, X29
    STRH  W17, [X11, #0]!
    LDRH  W8, [X11, #0]!
    ADD  X11, X11, X29
    STP  X5, X22, [X11, #0]
    LDAXP  W24, W17, [X11,#0]
    ADD  X11, X11, X29, ASR #0
    STP  X15, X8, [X11, #0]
    LDAXP  X6, X27, [X11,#0]
    ADD  X11, X11, X29, ASR #0
    STP  X24, X2, [X11, #0]
    LDPSW  X22, X13, [X11], #0
    ADD  X11, X11, X29
    STP  X13, X16, [X11, #0]
    LDPSW  X2, X15, [X11, #0]!
    ADD  X11, X11, X29
    STP  X25, X2, [X11, #0]
    LDAXR  W28, [X11,#0]
    ADD  X11, X11, X29, LSR #0
    STP  X17, X27, [X11, #0]
    LDAXR  X13, [X11,#0]
    ADD  X11, X11, X29
    STP  X28, X28, [X11, #0]
    LDAXRB  W27, [X11,#0]
    ADD  X11, X11, X29, ASR #0
    STP  X27, X27, [X11, #0]
    LDAXRH  W16, [X11,#0]
    ADD  X11, X11, X29, ASR #0
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X18, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X18, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X18, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    SUB  X18, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X18, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X18, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X18, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X18, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    SUB  X18, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X18, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X18, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X18, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
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
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
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
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X5, #0x10, LSL #0
    MOVZ  X10, #0x500, LSL #0
    ADD  X13, X30, X10
    STP  X6, X26, [X13, #0]
    LDPSW  X8, X16, [X13, #0]
    ADD  X13, X13, X5, ASR #0
    STP  X8, X8, [X13, #0]
    LDRSB  W20, [X13], #0
    ADD  X13, X13, X5, ASR #0
    STP  X17, X18, [X13, #0]
    LDRSB  X15, [X13], #0
    ADD  X13, X13, X5, LSR #0
    STP  X29, X20, [X13, #0]
    LDRSB  W16, [X13, #0]!
    ADD  X13, X13, X5, LSR #0
    STP  X16, X16, [X13, #0]
    LDRSB  X29, [X13, #0]!
    ADD  X13, X13, X5, LSR #0
    STP  X15, X29, [X13, #0]
    LDRSB  W16, [X13, #0]
    ADD  X13, X13, X5
    STP  X16, X16, [X13, #0]
    LDRSB  X28, [X13, #0]
    ADD  X13, X13, X5
    STP  X8, X16, [X13, #0]
    LDRSB W20, [X13, X28, LSL #0]
    ADD  X13, X13, X5
    STP  X7, X24, [X13, #0]
    LDRSB W16, [X13, W28, SXTW #0]
    ADD  X13, X13, X5
    STP  X7, X28, [X13, #0]
    LDRSB W15, [X13, X28, SXTX #0]
    ADD  X13, X13, X5, LSR #0
    STP  X18, X21, [X13, #0]
    LDRSB W29, [X13, W17, UXTW #0]
    ADD  X13, X13, X5, LSR #0
    STP  X17, X21, [X13, #0]
    LDRSB X8, [X13, X28, LSL #0]
    ADD  X13, X13, X5, LSR #0
    STP  X25, X25, [X13, #0]
    LDRSB X25, [X13, W17, SXTW #0]
    ADD  X13, X13, X5, ASR #0
    STP  X24, X22, [X13, #0]
    LDRSB X21, [X13, X8, SXTX #0]
    ADD  X13, X13, X5, ASR #0
    STP  X28, X8, [X13, #0]
    LDRSB X7, [X13, W28, UXTW #0]
    ADD  X13, X13, X5, ASR #0
    STP  X7, X27, [X13, #0]
    LDRSH  W6, [X13], #0
    ADD  X13, X13, X5
    STP  X21, X26, [X13, #0]
    LDRSH  X22, [X13], #0
    ADD  X13, X13, X5
    STP  X18, X16, [X13, #0]
    LDRSH  W7, [X13, #0]!
    ADD  X13, X13, X5, ASR #0
    STP  X8, X21, [X13, #0]
    LDRSH  X8, [X13, #0]!
    ADD  X13, X13, X5, ASR #0
    STP  X6, X26, [X13, #0]
    LDRSH  W16, [X13, #0]
    ADD  X13, X13, X5
    STP  X18, X18, [X13, #0]
    LDRSH  X18, [X13, #0]
    ADD  X13, X13, X5, LSR #0
    STP  X24, X27, [X13, #0]
    LDRSH W21, [X13, X17, LSL #1]
    ADD  X13, X13, X5, LSR #0
    STP  X15, X22, [X13, #0]
    LDRSH W26, [X13, W8, SXTW #1]
    ADD  X13, X13, X5, ASR #0
    STP  X21, X26, [X13, #0]
    LDRSH W15, [X13, X8, SXTX #1]
    ADD  X13, X13, X5, ASR #0
    STP  X26, X27, [X13, #0]
    LDRSH W27, [X13, W16, UXTW #1]
    ADD  X13, X13, X5
    STP  X21, X17, [X13, #0]
    LDRSH X26, [X13, X6, LSL #1]
    ADD  X13, X13, X5, LSR #0
    STP  X27, X25, [X13, #0]
    LDRSH X6, [X13, W28, SXTW #1]
    ADD  X13, X13, X5, LSR #0
    STP  X9, X17, [X13, #0]
    LDRSH X22, [X13, X28, SXTX #0]
    ADD  X13, X13, X5
    STP  X26, X15, [X13, #0]
    LDRSH X27, [X13, W17, UXTW #1]
    ADD  X13, X13, X5
    STP  X18, X26, [X13, #0]
    LDRSW  X16, [X13], #0
    ADD  X13, X13, X5, LSR #0
    STP  X8, X20, [X13, #0]
    LDRSW  X24, [X13, #0]!
    ADD  X13, X13, X5
    STP  X9, X9, [X13, #0]
    LDRSW  X9, [X13, #0]
    ADD  X13, X13, X5, LSR #0
    STP  X20, X7, [X13, #0]
    LDRSW X15, [X13, X8, LSL #0]
    ADD  X13, X13, X5, LSR #0
    STP  X16, X26, [X13, #0]
    LDRSW X21, [X13, W24, SXTW #2]
    ADD  X13, X13, X5, ASR #0
    STP  X25, X20, [X13, #0]
    LDRSW X28, [X13, X28, SXTX #0]
    ADD  X13, X13, X5, ASR #0
    STP  X11, X11, [X13, #0]
    LDRSW X26, [X13, W24, UXTW #2]
    ADD  X13, X13, X5
    STP  X9, X28, [X13, #0]
    LDTRSB  W11, [X13, #0]
    ADD  X13, X13, X5, ASR #0
    STP  X11, X15, [X13, #0]
    LDTRSB  X24, [X13, #0]
    ADD  X13, X13, X5, LSR #0
    STP  X24, X21, [X13, #0]
    LDTRSH  W25, [X13, #0]
    ADD  X13, X13, X5, ASR #0
    STP  X25, X7, [X13, #0]
    LDTRSH  X11, [X13, #0]
    ADD  X13, X13, X5, LSR #0
    STP  X9, X2, [X13, #0]
    LDTRSW  X20, [X13, #0]
    ADD  X13, X13, X5, ASR #0
    STP  X11, X18, [X13, #0]
    LDURSB  W29, [X13, #0]
    ADD  X13, X13, X5, ASR #0
    STP  X25, X16, [X13, #0]
    LDURSB  X24, [X13, #0]
    ADD  X13, X13, X5
    STP  X26, X9, [X13, #0]
    LDURSH  W11, [X13, #0]
    ADD  X13, X13, X5, ASR #0
    STP  X28, X28, [X13, #0]
    LDURSH  X7, [X13, #0]
    ADD  X13, X13, X5, ASR #0
    STP  X17, X24, [X13, #0]
    LDURSW  X16, [X13, #0]
    ADD  X13, X13, X5, ASR #0
    STP  X2, X24, [X13, #0]
    LDXP  W18, W26, [X13,#0]
    ADD  X13, X13, X5, ASR #0
    STP  X28, X25, [X13, #0]
    LDXP  X2, X25, [X13,#0]
    ADD  X13, X13, X5, LSR #0
    STP  X7, X29, [X13, #0]
    LDXR  W28, [X13,#0]
    ADD  X13, X13, X5, ASR #0
    STP  X20, X18, [X13, #0]
    LDXR  X24, [X13,#0]
    ADD  X13, X13, X5, LSR #0
    STP  X16, X16, [X13, #0]
    LDXRB  W18, [X13,#0]
    ADD  X13, X13, X5
    STP  X25, X26, [X13, #0]
    LDXRH  W25, [X13,#0]
    ADD  X13, X13, X5, ASR #0
    STRB  W28, [X13, #0]
    LDRB  W29, [X13, #0]
    ADD  X13, X13, X5
    STRB W25, [X13, X18, LSL #0]
    LDRB W16, [X13, X18, LSL #0]
    ADD  X13, X13, X5, ASR #0
    STRB W29, [X13, W18, SXTW #0]
    LDRB W7, [X13, W17, SXTW #0]
    ADD  X13, X13, X5, ASR #0
    STRB W24, [X13, X18, SXTX #0]
    LDRB W24, [X13, X17, SXTX #0]
    ADD  X13, X13, X5, LSR #0
    STRB W7, [X13, W17, UXTW #0]
    LDRB W28, [X13, W18, UXTW #0]
    ADD  X13, X13, X5, ASR #0
    STRH  W16, [X13, #0]
    LDRH  W25, [X13, #0]
    ADD  X13, X13, X5, LSR #0
    STRH W24, [X13, X18, LSL #1]
    LDRH W20, [X13, X17, LSL #0]
    ADD  X13, X13, X5, ASR #0
    STRH W28, [X13, W17, SXTW #1]
    LDRH W16, [X13, W8, SXTW #1]
    ADD  X13, X13, X5
    STRH W16, [X13, X18, SXTX #1]
    LDRH W24, [X13, X8, SXTX #0]
    ADD  X13, X13, X5, LSR #0
    STRH W24, [X13, W18, UXTW #1]
    LDRH W24, [X13, W17, UXTW #1]
    ADD  X13, X13, X5, ASR #0
    STR  W20, [X13, #0]
    LDR  W7, [X13, #0]
    ADD  X13, X13, X5, LSR #0
    STR  X7, [X13, #0]
    LDR  X18, [X13, #0]
    ADD  X13, X13, X5
    STR W25, [X13, X17, LSL #2]
    LDR W27, [X13, X17, LSL #0]
    ADD  X13, X13, X5, LSR #0
    STR W18, [X13, W17, SXTW #0]
    LDR W8, [X13, W8, SXTW #0]
    ADD  X13, X13, X5, LSR #0
    STR W24, [X13, X17, SXTX #2]
    LDR W20, [X13, X17, SXTX #0]
    ADD  X13, X13, X5
    STR W8, [X13, W17, UXTW #2]
    LDR W7, [X13, W17, UXTW #0]
    ADD  X13, X13, X5
    STR X27, [X13, X17, LSL #0]
    LDR X24, [X13, X17, LSL #0]
    ADD  X13, X13, X5
    STR X20, [X13, W17, SXTW #3]
    LDR X20, [X13, W17, SXTW #0]
    ADD  X13, X13, X5, LSR #0
    STR X20, [X13, X17, SXTX #3]
    LDR X25, [X13, X17, SXTX #3]
    ADD  X13, X13, X5
    STR X7, [X13, W17, UXTW #3]
    LDR X22, [X13, W17, UXTW #0]
    ADD  X13, X13, X5, ASR #0
    STP  W24, W22, [X13, #0]
    LDP  W22, W20, [X13, #0]
    ADD  X13, X13, X5, ASR #0
    STP  X24, X21, [X13, #0]
    LDP  X27, X7, [X13, #0]
    ADD  X13, X13, X5
    STTR  W27, [X13, #0]
    LDTR  W27, [X13, #0]
    ADD  X13, X13, X5
    STTR  X2, [X13, #0]
    LDTR  X2, [X13, #0]
    ADD  X13, X13, X5
    STTRB  W20, [X13, #0]
    LDTRB  W24, [X13, #0]
    ADD  X13, X13, X5, ASR #0
    STTRH  W15, [X13, #0]
    LDTRH  W20, [X13, #0]
    ADD  X13, X13, X5, LSR #0
    STUR  W6, [X13, #0]
    LDUR  W21, [X13, #0]
    ADD  X13, X13, X5, ASR #0
    STUR  X27, [X13, #0]
    LDUR  X15, [X13, #0]
    ADD  X13, X13, X5, LSR #0
    STURB  W2, [X13, #0]
    LDURB  W2, [X13, #0]
    ADD  X13, X13, X5, ASR #0
    STURH  W7, [X13, #0]
    LDURH  W7, [X13, #0]
    ADD  X13, X13, X5
    STLR  W29, [X13,#0]
    LDAR  W6, [X13,#0]
    ADD  X13, X13, X5, ASR #0
    STLR  X20, [X13,#0]
    LDAR  X6, [X13,#0]
    ADD  X13, X13, X5
    STLRB  W6, [X13,#0]
    LDARB  W29, [X13,#0]
    ADD  X13, X13, X5
    STLRH  W21, [X13,#0]
    LDARH  W6, [X13,#0]
    ADD  X13, X13, X5, LSR #0
    STNP  W15, W15, [X13, #0]
    LDNP  W20, W26, [X13, #0]
    ADD  X13, X13, X5
    STNP  X22, X29, [X13, #0]
    LDNP  X21, X27, [X13, #0]
    ADD  X13, X13, X5
    STP  W7, W2, [X13], #0
    LDP  W7, W15, [X13], #0
    ADD  X13, X13, X5, ASR #0
    STP  X6, X26, [X13], #0
    LDP  X29, X6, [X13], #0
    ADD  X13, X13, X5, LSR #0
    STP  W20, W27, [X13, #0]!
    LDP  W27, W22, [X13, #0]!
    ADD  X13, X13, X5, ASR #0
    STP  X6, X21, [X13, #0]!
    LDP  X20, X26, [X13, #0]!
    ADD  X13, X13, X5, LSR #0
    STR  W27, [X13], #0
    LDR  W21, [X13], #0
    ADD  X13, X13, X5, ASR #0
    STR  X15, [X13], #0
    LDR  X6, [X13], #0
    ADD  X13, X13, X5, ASR #0
    STR  W16, [X13, #0]!
    LDR  W16, [X13, #0]!
    ADD  X13, X13, X5
    STR  X20, [X13, #0]!
    LDR  X27, [X13, #0]!
    ADD  X13, X13, X5, LSR #0
    STRB  W22, [X13], #0
    LDRB  W22, [X13], #0
    ADD  X13, X13, X5, LSR #0
    STRB  W26, [X13, #0]!
    LDRB  W2, [X13, #0]!
    ADD  X13, X13, X5
    STRH  W2, [X13], #0
    LDRH  W20, [X13], #0
    ADD  X13, X13, X5, LSR #0
    STRH  W6, [X13, #0]!
    LDRH  W15, [X13, #0]!
    ADD  X13, X13, X5
    STP  X15, X21, [X13, #0]
    LDAXP  W2, W6, [X13,#0]
    ADD  X13, X13, X5, LSR #0
    STP  X22, X22, [X13, #0]
    LDAXP  X22, X15, [X13,#0]
    ADD  X13, X13, X5
    STP  X2, X20, [X13, #0]
    LDPSW  X21, X20, [X13], #0
    ADD  X13, X13, X5, ASR #0
    STP  X6, X24, [X13, #0]
    LDPSW  X6, X2, [X13, #0]!
    ADD  X13, X13, X5, LSR #0
    STP  X6, X27, [X13, #0]
    LDAXR  W6, [X13,#0]
    ADD  X13, X13, X5, ASR #0
    STP  X2, X26, [X13, #0]
    LDAXR  X24, [X13,#0]
    ADD  X13, X13, X5
    STP  X22, X15, [X13, #0]
    LDAXRB  W22, [X13,#0]
    ADD  X13, X13, X5
    STP  X24, X20, [X13, #0]
    LDAXRH  W15, [X13,#0]
    ADD  X13, X13, X5, ASR #0
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    SUB  X4, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X23, #0xa5, LSL #0
    SUB  X4, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X4, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X4, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X23, #0xa5, LSL #0
    SUB  X4, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X23, #0xa5, LSL #0
    SUB  X4, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X23, #0xa5, LSL #0
    SUB  X4, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X23, #0xa5, LSL #0
    SUB  X4, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X23, #0xa5, LSL #0
    SUB  X4, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X23, #0xa5, LSL #0
    SUB  X4, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X23, #0xa5, LSL #0
    SUB  X4, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X23, #0xa5, LSL #0
    SUB  X4, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X23, #0xffa5, LSL #0
    SUB  X4, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
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
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
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
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X21, #0x10, LSL #0
    MOVZ  X2, #0xa00, LSL #0
    ADD  X16, X30, X2, ASR #0
    STP  X25, X27, [X16, #0]
    LDPSW  X9, X29, [X16, #0]
    ADD  X16, X16, X21, LSR #0
    STP  X28, X8, [X16, #0]
    LDRSB  W9, [X16], #0
    ADD  X16, X16, X21
    STP  X29, X9, [X16, #0]
    LDRSB  X22, [X16], #0
    ADD  X16, X16, X21, ASR #0
    STP  X9, X26, [X16, #0]
    LDRSB  W13, [X16, #0]!
    ADD  X16, X16, X21, ASR #0
    STP  X11, X11, [X16, #0]
    LDRSB  X9, [X16, #0]!
    ADD  X16, X16, X21
    STP  X10, X22, [X16, #0]
    LDRSB  W13, [X16, #0]
    ADD  X16, X16, X21, LSR #0
    STP  X22, X26, [X16, #0]
    LDRSB  X23, [X16, #0]
    ADD  X16, X16, X21
    STP  X10, X28, [X16, #0]
    LDRSB W22, [X16, X8, LSL #0]
    ADD  X16, X16, X21, LSR #0
    STP  X28, X15, [X16, #0]
    LDRSB W28, [X16, W8, SXTW #0]
    ADD  X16, X16, X21
    STP  X25, X15, [X16, #0]
    LDRSB W25, [X16, X8, SXTX #0]
    ADD  X16, X16, X21, ASR #0
    STP  X5, X7, [X16, #0]
    LDRSB W29, [X16, W8, UXTW #0]
    ADD  X16, X16, X21, LSR #0
    STP  X17, X11, [X16, #0]
    LDRSB X5, [X16, X8, LSL #0]
    ADD  X16, X16, X21
    STP  X5, X23, [X16, #0]
    LDRSB X6, [X16, W8, SXTW #0]
    ADD  X16, X16, X21
    STP  X28, X29, [X16, #0]
    LDRSB X27, [X16, X8, SXTX #0]
    ADD  X16, X16, X21, ASR #0
    STP  X7, X27, [X16, #0]
    LDRSB X15, [X16, W8, UXTW #0]
    ADD  X16, X16, X21, ASR #0
    STP  X25, X15, [X16, #0]
    LDRSH  W25, [X16], #0
    ADD  X16, X16, X21, LSR #0
    STP  X6, X25, [X16, #0]
    LDRSH  X23, [X16], #0
    ADD  X16, X16, X21, ASR #0
    STP  X10, X28, [X16, #0]
    LDRSH  W22, [X16, #0]!
    ADD  X16, X16, X21
    STP  X26, X27, [X16, #0]
    LDRSH  X9, [X16, #0]!
    ADD  X16, X16, X21, LSR #0
    STP  X7, X28, [X16, #0]
    LDRSH  W6, [X16, #0]
    ADD  X16, X16, X21
    STP  X22, X9, [X16, #0]
    LDRSH  X22, [X16, #0]
    ADD  X16, X16, X21
    STP  X15, X7, [X16, #0]
    LDRSH W28, [X16, X8, LSL #0]
    ADD  X16, X16, X21
    STP  X27, X13, [X16, #0]
    LDRSH W25, [X16, W8, SXTW #0]
    ADD  X16, X16, X21, ASR #0
    STP  X8, X26, [X16, #0]
    LDRSH W27, [X16, X8, SXTX #0]
    ADD  X16, X16, X21, ASR #0
    STP  X27, X15, [X16, #0]
    LDRSH W27, [X16, W27, UXTW #1]
    ADD  X16, X16, X21
    STP  X5, X20, [X16, #0]
    LDRSH X26, [X16, X8, LSL #1]
    ADD  X16, X16, X21, LSR #0
    STP  X15, X15, [X16, #0]
    LDRSH X13, [X16, W27, SXTW #0]
    ADD  X16, X16, X21, LSR #0
    STP  X5, X20, [X16, #0]
    LDRSH X7, [X16, X8, SXTX #0]
    ADD  X16, X16, X21, LSR #0
    STP  X8, X26, [X16, #0]
    LDRSH X20, [X16, W27, UXTW #1]
    ADD  X16, X16, X21, LSR #0
    STP  X6, X20, [X16, #0]
    LDRSW  X6, [X16], #0
    ADD  X16, X16, X21, ASR #0
    STP  X18, X25, [X16, #0]
    LDRSW  X18, [X16, #0]!
    ADD  X16, X16, X21, ASR #0
    STP  X11, X23, [X16, #0]
    LDRSW  X20, [X16, #0]
    ADD  X16, X16, X21, ASR #0
    STP  X5, X13, [X16, #0]
    LDRSW X11, [X16, X8, LSL #0]
    ADD  X16, X16, X21
    STP  X20, X23, [X16, #0]
    LDRSW X27, [X16, W8, SXTW #2]
    ADD  X16, X16, X21, ASR #0
    STP  X13, X11, [X16, #0]
    LDRSW X26, [X16, X8, SXTX #0]
    ADD  X16, X16, X21, ASR #0
    STP  X25, X10, [X16, #0]
    LDRSW X23, [X16, W8, UXTW #2]
    ADD  X16, X16, X21
    STP  X7, X13, [X16, #0]
    LDTRSB  W5, [X16, #0]
    ADD  X16, X16, X21, ASR #0
    STP  X29, X8, [X16, #0]
    LDTRSB  X25, [X16, #0]
    ADD  X16, X16, X21
    STP  X5, X20, [X16, #0]
    LDTRSH  W11, [X16, #0]
    ADD  X16, X16, X21
    STP  X7, X13, [X16, #0]
    LDTRSH  X29, [X16, #0]
    ADD  X16, X16, X21
    STP  X25, X23, [X16, #0]
    LDTRSW  X25, [X16, #0]
    ADD  X16, X16, X21
    STP  X25, X11, [X16, #0]
    LDURSB  W25, [X16, #0]
    ADD  X16, X16, X21, LSR #0
    STP  X25, X25, [X16, #0]
    LDURSB  X11, [X16, #0]
    ADD  X16, X16, X21
    STP  X11, X29, [X16, #0]
    LDURSH  W20, [X16, #0]
    ADD  X16, X16, X21, LSR #0
    STP  X20, X7, [X16, #0]
    LDURSH  X5, [X16, #0]
    ADD  X16, X16, X21, ASR #0
    STP  X10, X26, [X16, #0]
    LDURSW  X11, [X16, #0]
    ADD  X16, X16, X21, ASR #0
    STP  X7, X15, [X16, #0]
    LDXP  W15, W20, [X16,#0]
    ADD  X16, X16, X21
    STP  X7, X26, [X16, #0]
    LDXP  X26, X13, [X16,#0]
    ADD  X16, X16, X21
    STP  X5, X29, [X16, #0]
    LDXR  W7, [X16,#0]
    ADD  X16, X16, X21, ASR #0
    STP  X18, X29, [X16, #0]
    LDXR  X5, [X16,#0]
    ADD  X16, X16, X21, LSR #0
    STP  X25, X8, [X16, #0]
    LDXRB  W10, [X16,#0]
    ADD  X16, X16, X21
    STP  X26, X11, [X16, #0]
    LDXRH  W29, [X16,#0]
    ADD  X16, X16, X21
    STRB  W10, [X16, #0]
    LDRB  W25, [X16, #0]
    ADD  X16, X16, X21, LSR #0
    STRB W15, [X16, X8, LSL #0]
    LDRB W26, [X16, X20, LSL #0]
    ADD  X16, X16, X21
    STRB W25, [X16, W8, SXTW #0]
    LDRB W15, [X16, W20, SXTW #0]
    ADD  X16, X16, X21, LSR #0
    STRB W7, [X16, X8, SXTX #0]
    LDRB W11, [X16, X20, SXTX #0]
    ADD  X16, X16, X21, LSR #0
    STRB W29, [X16, W20, UXTW #0]
    LDRB W18, [X16, W8, UXTW #0]
    ADD  X16, X16, X21, LSR #0
    STRH  W26, [X16, #0]
    LDRH  W7, [X16, #0]
    ADD  X16, X16, X21, LSR #0
    STRH W5, [X16, X20, LSL #0]
    LDRH W25, [X16, X8, LSL #1]
    ADD  X16, X16, X21, LSR #0
    STRH W18, [X16, W8, SXTW #1]
    LDRH W20, [X16, W8, SXTW #0]
    ADD  X16, X16, X21, LSR #0
    STRH W15, [X16, X8, SXTX #0]
    LDRH W5, [X16, X8, SXTX #1]
    ADD  X16, X16, X21
    STRH W11, [X16, W8, UXTW #0]
    LDRH W26, [X16, W8, UXTW #0]
    ADD  X16, X16, X21, LSR #0
    STR  W25, [X16, #0]
    LDR  W29, [X16, #0]
    ADD  X16, X16, X21, ASR #0
    STR  X28, [X16, #0]
    LDR  X18, [X16, #0]
    ADD  X16, X16, X21
    STR W18, [X16, X8, LSL #0]
    LDR W11, [X16, X8, LSL #2]
    ADD  X16, X16, X21
    STR W29, [X16, W8, SXTW #2]
    LDR W29, [X16, W8, SXTW #0]
    ADD  X16, X16, X21, ASR #0
    STR W26, [X16, X8, SXTX #2]
    LDR W18, [X16, X8, SXTX #2]
    ADD  X16, X16, X21, LSR #0
    STR W11, [X16, W8, UXTW #2]
    LDR W28, [X16, W8, UXTW #2]
    ADD  X16, X16, X21
    STR X18, [X16, X8, LSL #0]
    LDR X25, [X16, X8, LSL #3]
    ADD  X16, X16, X21, LSR #0
    STR X25, [X16, W8, SXTW #0]
    LDR X26, [X16, W8, SXTW #3]
    ADD  X16, X16, X21, LSR #0
    STR X26, [X16, X8, SXTX #3]
    LDR X11, [X16, X8, SXTX #0]
    ADD  X16, X16, X21
    STR X29, [X16, W8, UXTW #0]
    LDR X18, [X16, W8, UXTW #3]
    ADD  X16, X16, X21, ASR #0
    STP  W18, W11, [X16, #0]
    LDP  W26, W11, [X16, #0]
    ADD  X16, X16, X21, LSR #0
    STP  X6, X20, [X16, #0]
    LDP  X29, X6, [X16, #0]
    ADD  X16, X16, X21, ASR #0
    STTR  W26, [X16, #0]
    LDTR  W6, [X16, #0]
    ADD  X16, X16, X21
    STTR  X25, [X16, #0]
    LDTR  X26, [X16, #0]
    ADD  X16, X16, X21
    STTRB  W27, [X16, #0]
    LDTRB  W20, [X16, #0]
    ADD  X16, X16, X21, LSR #0
    STTRH  W11, [X16, #0]
    LDTRH  W18, [X16, #0]
    ADD  X16, X16, X21, ASR #0
    STUR  W27, [X16, #0]
    LDUR  W27, [X16, #0]
    ADD  X16, X16, X21
    STUR  X22, [X16, #0]
    LDUR  X11, [X16, #0]
    ADD  X16, X16, X21, LSR #0
    STURB  W13, [X16, #0]
    LDURB  W15, [X16, #0]
    ADD  X16, X16, X21, ASR #0
    STURH  W20, [X16, #0]
    LDURH  W13, [X16, #0]
    ADD  X16, X16, X21
    STLR  W26, [X16,#0]
    LDAR  W20, [X16,#0]
    ADD  X16, X16, X21, ASR #0
    STLR  X20, [X16,#0]
    LDAR  X17, [X16,#0]
    ADD  X16, X16, X21, LSR #0
    STLRB  W6, [X16,#0]
    LDARB  W25, [X16,#0]
    ADD  X16, X16, X21
    STLRH  W25, [X16,#0]
    LDARH  W25, [X16,#0]
    ADD  X16, X16, X21, ASR #0
    STNP  W17, W17, [X16, #0]
    LDNP  W20, W17, [X16, #0]
    ADD  X16, X16, X21, ASR #0
    STNP  X27, X25, [X16, #0]
    LDNP  X6, X27, [X16, #0]
    ADD  X16, X16, X21
    STP  W11, W11, [X16], #0
    LDP  W25, W26, [X16], #0
    ADD  X16, X16, X21, LSR #0
    STP  X27, X17, [X16], #0
    LDP  X17, X11, [X16], #0
    ADD  X16, X16, X21, LSR #0
    STP  W20, W25, [X16, #0]!
    LDP  W23, W22, [X16, #0]!
    ADD  X16, X16, X21, ASR #0
    STP  X26, X22, [X16, #0]!
    LDP  X11, X26, [X16, #0]!
    ADD  X16, X16, X21
    STR  W6, [X16], #0
    LDR  W13, [X16], #0
    ADD  X16, X16, X21, LSR #0
    STR  X11, [X16], #0
    LDR  X7, [X16], #0
    ADD  X16, X16, X21
    STR  W7, [X16, #0]!
    LDR  W20, [X16, #0]!
    ADD  X16, X16, X21, ASR #0
    STR  X13, [X16, #0]!
    LDR  X7, [X16, #0]!
    ADD  X16, X16, X21, ASR #0
    STRB  W28, [X16], #0
    LDRB  W27, [X16], #0
    ADD  X16, X16, X21, ASR #0
    STRB  W20, [X16, #0]!
    LDRB  W27, [X16, #0]!
    ADD  X16, X16, X21, ASR #0
    STRH  W7, [X16], #0
    LDRH  W7, [X16], #0
    ADD  X16, X16, X21, LSR #0
    STRH  W22, [X16, #0]!
    LDRH  W20, [X16, #0]!
    ADD  X16, X16, X21, LSR #0
    STP  X7, X20, [X16, #0]
    LDAXP  W27, W17, [X16,#0]
    ADD  X16, X16, X21, ASR #0
    STP  X17, X27, [X16, #0]
    LDAXP  X27, X25, [X16,#0]
    ADD  X16, X16, X21
    STP  X20, X25, [X16, #0]
    LDPSW  X7, X5, [X16], #0
    ADD  X16, X16, X21, ASR #0
    STP  X13, X13, [X16, #0]
    LDPSW  X15, X20, [X16, #0]!
    ADD  X16, X16, X21, ASR #0
    STP  X23, X17, [X16, #0]
    LDAXR  W23, [X16,#0]
    ADD  X16, X16, X21
    STP  X26, X29, [X16, #0]
    LDAXR  X13, [X16,#0]
    ADD  X16, X16, X21, ASR #0
    STP  X22, X10, [X16, #0]
    LDAXRB  W18, [X16,#0]
    ADD  X16, X16, X21, ASR #0
    STP  X15, X18, [X16, #0]
    LDAXRH  W22, [X16,#0]
    ADD  X16, X16, X21
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    SUB  X24, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    SUB  X24, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    SUB  X24, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0x5a, LSL #0
    SUB  X24, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    SUB  X24, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    SUB  X24, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    SUB  X24, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0x5a, LSL #0
    SUB  X24, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    SUB  X24, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0x5a, LSL #0
    SUB  X24, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    SUB  X24, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    SUB  X24, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0x5a, LSL #0
    SUB  X24, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    SUB  X24, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
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
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
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
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X13, #0x10, LSL #0
    MOVZ  X7, #0xf00, LSL #0
    ADD  X23, X30, X7, ASR #0
    STP  X25, X17, [X23, #0]
    LDPSW  X28, X24, [X23, #0]
    ADD  X23, X23, X13, LSR #0
    STP  X24, X29, [X23, #0]
    LDRSB  W21, [X23], #0
    ADD  X23, X23, X13
    STP  X27, X27, [X23, #0]
    LDRSB  X8, [X23], #0
    ADD  X23, X23, X13, ASR #0
    STP  X6, X8, [X23, #0]
    LDRSB  W15, [X23, #0]!
    ADD  X23, X23, X13, LSR #0
    STP  X15, X21, [X23, #0]
    LDRSB  X28, [X23, #0]!
    ADD  X23, X23, X13, LSR #0
    STP  X28, X28, [X23, #0]
    LDRSB  W5, [X23, #0]
    ADD  X23, X23, X13, ASR #0
    STP  X24, X21, [X23, #0]
    LDRSB  X20, [X23, #0]
    ADD  X23, X23, X13, ASR #0
    STP  X29, X26, [X23, #0]
    LDRSB W25, [X23, X17, LSL #0]
    ADD  X23, X23, X13, LSR #0
    STP  X28, X18, [X23, #0]
    LDRSB W8, [X23, W17, SXTW #0]
    ADD  X23, X23, X13
    STP  X21, X24, [X23, #0]
    LDRSB W26, [X23, X17, SXTX #0]
    ADD  X23, X23, X13
    STP  X26, X21, [X23, #0]
    LDRSB W29, [X23, W17, UXTW #0]
    ADD  X23, X23, X13, LSR #0
    STP  X24, X27, [X23, #0]
    LDRSB X5, [X23, X17, LSL #0]
    ADD  X23, X23, X13, ASR #0
    STP  X6, X26, [X23, #0]
    LDRSB X18, [X23, W17, SXTW #0]
    ADD  X23, X23, X13, LSR #0
    STP  X2, X4, [X23, #0]
    LDRSB X27, [X23, X17, SXTX #0]
    ADD  X23, X23, X13, LSR #0
    STP  X15, X21, [X23, #0]
    LDRSB X24, [X23, W17, UXTW #0]
    ADD  X23, X23, X13, ASR #0
    STP  X24, X27, [X23, #0]
    LDRSH  W6, [X23], #0
    ADD  X23, X23, X13, ASR #0
    STP  X29, X18, [X23, #0]
    LDRSH  X18, [X23], #0
    ADD  X23, X23, X13, ASR #0
    STP  X18, X5, [X23, #0]
    LDRSH  W21, [X23, #0]!
    ADD  X23, X23, X13, ASR #0
    STP  X6, X6, [X23, #0]
    LDRSH  X15, [X23, #0]!
    ADD  X23, X23, X13
    STP  X15, X21, [X23, #0]
    LDRSH  W27, [X23, #0]
    ADD  X23, X23, X13, LSR #0
    STP  X25, X4, [X23, #0]
    LDRSH  X20, [X23, #0]
    ADD  X23, X23, X13
    STP  X2, X22, [X23, #0]
    LDRSH W24, [X23, X17, LSL #1]
    ADD  X23, X23, X13, ASR #0
    STP  X17, X20, [X23, #0]
    LDRSH W6, [X23, W17, SXTW #0]
    ADD  X23, X23, X13, ASR #0
    STP  X4, X17, [X23, #0]
    LDRSH W18, [X23, X6, SXTX #0]
    ADD  X23, X23, X13
    STP  X27, X21, [X23, #0]
    LDRSH W20, [X23, W17, UXTW #0]
    ADD  X23, X23, X13, LSR #0
    STP  X21, X25, [X23, #0]
    LDRSH X2, [X23, X6, LSL #1]
    ADD  X23, X23, X13
    STP  X6, X20, [X23, #0]
    LDRSH X21, [X23, W6, SXTW #1]
    ADD  X23, X23, X13, ASR #0
    STP  X18, X25, [X23, #0]
    LDRSH X20, [X23, X21, SXTX #0]
    ADD  X23, X23, X13, ASR #0
    STP  X27, X21, [X23, #0]
    LDRSH X22, [X23, W6, UXTW #1]
    ADD  X23, X23, X13, LSR #0
    STP  X21, X28, [X23, #0]
    LDRSW  X27, [X23], #0
    ADD  X23, X23, X13, ASR #0
    STP  X21, X28, [X23, #0]
    LDRSW  X18, [X23, #0]!
    ADD  X23, X23, X13, ASR #0
    STP  X9, X21, [X23, #0]
    LDRSW  X28, [X23, #0]
    ADD  X23, X23, X13, ASR #0
    STP  X22, X29, [X23, #0]
    LDRSW X5, [X23, X27, LSL #0]
    ADD  X23, X23, X13, ASR #0
    STP  X18, X21, [X23, #0]
    LDRSW X21, [X23, W27, SXTW #0]
    ADD  X23, X23, X13, LSR #0
    STP  X5, X26, [X23, #0]
    LDRSW X18, [X23, X17, SXTX #0]
    ADD  X23, X23, X13, LSR #0
    STP  X4, X22, [X23, #0]
    LDRSW X22, [X23, W27, UXTW #0]
    ADD  X23, X23, X13, LSR #0
    STP  X26, X22, [X23, #0]
    LDTRSB  W29, [X23, #0]
    ADD  X23, X23, X13, LSR #0
    STP  X8, X2, [X23, #0]
    LDTRSB  X6, [X23, #0]
    ADD  X23, X23, X13, LSR #0
    STP  X17, X29, [X23, #0]
    LDTRSH  W29, [X23, #0]
    ADD  X23, X23, X13
    STP  X9, X5, [X23, #0]
    LDTRSH  X5, [X23, #0]
    ADD  X23, X23, X13, LSR #0
    STP  X15, X25, [X23, #0]
    LDTRSW  X25, [X23, #0]
    ADD  X23, X23, X13, LSR #0
    STP  X4, X5, [X23, #0]
    LDURSB  W26, [X23, #0]
    ADD  X23, X23, X13, ASR #0
    STP  X10, X24, [X23, #0]
    LDURSB  X27, [X23, #0]
    ADD  X23, X23, X13
    STP  X17, X8, [X23, #0]
    LDURSH  W5, [X23, #0]
    ADD  X23, X23, X13, LSR #0
    STP  X6, X25, [X23, #0]
    LDURSH  X4, [X23, #0]
    ADD  X23, X23, X13, ASR #0
    STP  X26, X26, [X23, #0]
    LDURSW  X15, [X23, #0]
    ADD  X23, X23, X13
    STP  X15, X15, [X23, #0]
    LDXP  W25, W6, [X23,#0]
    ADD  X23, X23, X13, LSR #0
    STP  X29, X6, [X23, #0]
    LDXP  X10, X4, [X23,#0]
    ADD  X23, X23, X13, LSR #0
    STP  X15, X27, [X23, #0]
    LDXR  W6, [X23,#0]
    ADD  X23, X23, X13, ASR #0
    STP  X10, X5, [X23, #0]
    LDXR  X8, [X23,#0]
    ADD  X23, X23, X13, LSR #0
    STP  X25, X25, [X23, #0]
    LDXRB  W29, [X23,#0]
    ADD  X23, X23, X13, ASR #0
    STP  X4, X4, [X23, #0]
    LDXRH  W5, [X23,#0]
    ADD  X23, X23, X13, ASR #0
    STRB  W26, [X23, #0]
    LDRB  W15, [X23, #0]
    ADD  X23, X23, X13
    STRB W8, [X23, X8, LSL #0]
    LDRB W22, [X23, X17, LSL #0]
    ADD  X23, X23, X13
    STRB W29, [X23, W22, SXTW #0]
    LDRB W10, [X23, W8, SXTW #0]
    ADD  X23, X23, X13, LSR #0
    STRB W5, [X23, X22, SXTX #0]
    LDRB W29, [X23, X8, SXTX #0]
    ADD  X23, X23, X13, LSR #0
    STRB W29, [X23, W8, UXTW #0]
    LDRB W22, [X23, W17, UXTW #0]
    ADD  X23, X23, X13, LSR #0
    STRH  W22, [X23, #0]
    LDRH  W5, [X23, #0]
    ADD  X23, X23, X13, LSR #0
    STRH W15, [X23, X17, LSL #0]
    LDRH W26, [X23, X21, LSL #0]
    ADD  X23, X23, X13, ASR #0
    STRH W10, [X23, W21, SXTW #1]
    LDRH W21, [X23, W8, SXTW #1]
    ADD  X23, X23, X13
    STRH W17, [X23, X8, SXTX #1]
    LDRH W15, [X23, X17, SXTX #0]
    ADD  X23, X23, X13
    STRH W21, [X23, W8, UXTW #1]
    LDRH W29, [X23, W8, UXTW #1]
    ADD  X23, X23, X13, ASR #0
    STR  W5, [X23, #0]
    LDR  W20, [X23, #0]
    ADD  X23, X23, X13
    STR  X26, [X23, #0]
    LDR  X22, [X23, #0]
    ADD  X23, X23, X13
    STR W20, [X23, X15, LSL #0]
    LDR W8, [X23, X15, LSL #2]
    ADD  X23, X23, X13, ASR #0
    STR W27, [X23, W17, SXTW #2]
    LDR W5, [X23, W17, SXTW #0]
    ADD  X23, X23, X13, ASR #0
    STR W29, [X23, X17, SXTX #2]
    LDR W21, [X23, X17, SXTX #2]
    ADD  X23, X23, X13, LSR #0
    STR W22, [X23, W15, UXTW #2]
    LDR W20, [X23, W15, UXTW #2]
    ADD  X23, X23, X13, LSR #0
    STR X2, [X23, X15, LSL #0]
    LDR X25, [X23, X17, LSL #0]
    ADD  X23, X23, X13
    STR X25, [X23, W15, SXTW #3]
    LDR X29, [X23, W15, SXTW #3]
    ADD  X23, X23, X13, LSR #0
    STR X29, [X23, X15, SXTX #3]
    LDR X29, [X23, X15, SXTX #3]
    ADD  X23, X23, X13, LSR #0
    STR X17, [X23, W15, UXTW #3]
    LDR X2, [X23, W15, UXTW #0]
    ADD  X23, X23, X13
    STP  W21, W20, [X23, #0]
    LDP  W25, W22, [X23, #0]
    ADD  X23, X23, X13, ASR #0
    STP  X2, X5, [X23, #0]
    LDP  X18, X26, [X23, #0]
    ADD  X23, X23, X13, LSR #0
    STTR  W25, [X23, #0]
    LDTR  W25, [X23, #0]
    ADD  X23, X23, X13, ASR #0
    STTR  X18, [X23, #0]
    LDTR  X15, [X23, #0]
    ADD  X23, X23, X13, LSR #0
    STTRB  W29, [X23, #0]
    LDTRB  W29, [X23, #0]
    ADD  X23, X23, X13, LSR #0
    STTRH  W29, [X23, #0]
    LDTRH  W20, [X23, #0]
    ADD  X23, X23, X13, ASR #0
    STUR  W25, [X23, #0]
    LDUR  W5, [X23, #0]
    ADD  X23, X23, X13, ASR #0
    STUR  X22, [X23, #0]
    LDUR  X18, [X23, #0]
    ADD  X23, X23, X13, LSR #0
    STURB  W9, [X23, #0]
    LDURB  W21, [X23, #0]
    ADD  X23, X23, X13, ASR #0
    STURH  W21, [X23, #0]
    LDURH  W21, [X23, #0]
    ADD  X23, X23, X13
    STLR  W15, [X23,#0]
    LDAR  W15, [X23,#0]
    ADD  X23, X23, X13
    STLR  X21, [X23,#0]
    LDAR  X21, [X23,#0]
    ADD  X23, X23, X13
    STLRB  W21, [X23,#0]
    LDARB  W25, [X23,#0]
    ADD  X23, X23, X13, ASR #0
    STLRH  W18, [X23,#0]
    LDARH  W21, [X23,#0]
    ADD  X23, X23, X13
    STNP  W20, W25, [X23, #0]
    LDNP  W25, W20, [X23, #0]
    ADD  X23, X23, X13
    STNP  X15, X5, [X23, #0]
    LDNP  X9, X22, [X23, #0]
    ADD  X23, X23, X13, LSR #0
    STP  W25, W21, [X23], #0
    LDP  W15, W5, [X23], #0
    ADD  X23, X23, X13
    STP  X20, X22, [X23], #0
    LDP  X22, X25, [X23], #0
    ADD  X23, X23, X13, LSR #0
    STP  W15, W15, [X23, #0]!
    LDP  W15, W20, [X23, #0]!
    ADD  X23, X23, X13, ASR #0
    STP  X9, X5, [X23, #0]!
    LDP  X22, X21, [X23, #0]!
    ADD  X23, X23, X13
    STR  W21, [X23], #0
    LDR  W21, [X23], #0
    ADD  X23, X23, X13, LSR #0
    STR  X17, [X23], #0
    LDR  X5, [X23], #0
    ADD  X23, X23, X13
    STR  W5, [X23, #0]!
    LDR  W5, [X23, #0]!
    ADD  X23, X23, X13, LSR #0
    STR  X25, [X23, #0]!
    LDR  X9, [X23, #0]!
    ADD  X23, X23, X13, ASR #0
    STRB  W22, [X23], #0
    LDRB  W15, [X23], #0
    ADD  X23, X23, X13, LSR #0
    STRB  W20, [X23, #0]!
    LDRB  W20, [X23, #0]!
    ADD  X23, X23, X13, LSR #0
    STRH  W21, [X23], #0
    LDRH  W15, [X23], #0
    ADD  X23, X23, X13, ASR #0
    STRH  W20, [X23, #0]!
    LDRH  W20, [X23, #0]!
    ADD  X23, X23, X13, LSR #0
    STP  X9, X15, [X23, #0]
    LDAXP  W22, W28, [X23,#0]
    ADD  X23, X23, X13, LSR #0
    STP  X5, X22, [X23, #0]
    LDAXP  X9, X21, [X23,#0]
    ADD  X23, X23, X13
    STP  X21, X4, [X23, #0]
    LDPSW  X5, X22, [X23], #0
    ADD  X23, X23, X13, LSR #0
    STP  X28, X20, [X23, #0]
    LDPSW  X20, X15, [X23, #0]!
    ADD  X23, X23, X13
    STP  X9, X9, [X23, #0]
    LDAXR  W4, [X23,#0]
    ADD  X23, X23, X13, LSR #0
    STP  X5, X20, [X23, #0]
    LDAXR  X20, [X23,#0]
    ADD  X23, X23, X13, LSR #0
    STP  X22, X4, [X23, #0]
    LDAXRB  W5, [X23,#0]
    ADD  X23, X23, X13, LSR #0
    STP  X15, X20, [X23, #0]
    LDAXRH  W22, [X23,#0]
    ADD  X23, X23, X13, LSR #0
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, GeneralLoadStoreP04_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, GeneralLoadStoreP04_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, GeneralLoadStoreP04_TestFail
    MOVZ  X11, #0xffa5, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X16, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, GeneralLoadStoreP04_TestFail
    MOVZ  X11, #0xff, LSL #0
    SUB  X16, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, GeneralLoadStoreP04_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, GeneralLoadStoreP04_TestFail
    MOVZ  X11, #0xa5, LSL #0
    SUB  X16, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, GeneralLoadStoreP04_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, GeneralLoadStoreP04_TestFail
    MOVZ  X11, #0xa5, LSL #0
    SUB  X16, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, GeneralLoadStoreP04_TestFail
    MOVZ  X11, #0xa5, LSL #0
    SUB  X16, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, GeneralLoadStoreP04_TestFail
    MOVZ  X11, #0xa5, LSL #0
    SUB  X16, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, GeneralLoadStoreP04_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, GeneralLoadStoreP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X16, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, GeneralLoadStoreP04_TestFail
    MOVZ  X11, #0xa5, LSL #0
    SUB  X16, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, GeneralLoadStoreP04_TestFail
    MOVZ  X11, #0xffa5, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X16, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, GeneralLoadStoreP04_TestFail
    MOVZ  X11, #0xffa5, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X16, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, GeneralLoadStoreP04_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, GeneralLoadStoreP04_TestFail
    MOVZ  X11, #0xa5, LSL #0
    SUB  X16, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
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
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
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
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X24, #0x10, LSL #0
    MOVZ  X27, #0x1400, LSL #0
    ADD  X8, X30, X27, ASR #0
    STP  X28, X29, [X8, #0]
    LDPSW  X29, X23, [X8, #0]
    ADD  X8, X8, X24
    STP  X29, X15, [X8, #0]
    LDRSB  W13, [X8], #0
    ADD  X8, X8, X24, LSR #0
    STP  X21, X13, [X8, #0]
    LDRSB  X23, [X8], #0
    ADD  X8, X8, X24
    STP  X15, X26, [X8, #0]
    LDRSB  W6, [X8, #0]!
    ADD  X8, X8, X24, LSR #0
    STP  X23, X23, [X8, #0]
    LDRSB  X15, [X8, #0]!
    ADD  X8, X8, X24, ASR #0
    STP  X18, X16, [X8, #0]
    LDRSB  W26, [X8, #0]
    ADD  X8, X8, X24, LSR #0
    STP  X7, X23, [X8, #0]
    LDRSB  X11, [X8, #0]
    ADD  X8, X8, X24, ASR #0
    STP  X18, X15, [X8, #0]
    LDRSB W20, [X8, X15, LSL #0]
    ADD  X8, X8, X24
    STP  X9, X23, [X8, #0]
    LDRSB W15, [X8, W21, SXTW #0]
    ADD  X8, X8, X24, LSR #0
    STP  X28, X17, [X8, #0]
    LDRSB W5, [X8, X23, SXTX #0]
    ADD  X8, X8, X24, LSR #0
    STP  X28, X6, [X8, #0]
    LDRSB W28, [X8, W21, UXTW #0]
    ADD  X8, X8, X24, LSR #0
    STP  X23, X7, [X8, #0]
    LDRSB X28, [X8, X21, LSL #0]
    ADD  X8, X8, X24, LSR #0
    STP  X4, X21, [X8, #0]
    LDRSB X7, [X8, W23, SXTW #0]
    ADD  X8, X8, X24, LSR #0
    STP  X28, X17, [X8, #0]
    LDRSB X16, [X8, X21, SXTX #0]
    ADD  X8, X8, X24, LSR #0
    STP  X17, X23, [X8, #0]
    LDRSB X9, [X8, W21, UXTW #0]
    ADD  X8, X8, X24, ASR #0
    STP  X9, X7, [X8, #0]
    LDRSH  W6, [X8], #0
    ADD  X8, X8, X24
    STP  X5, X6, [X8, #0]
    LDRSH  X6, [X8], #0
    ADD  X8, X8, X24, LSR #0
    STP  X6, X15, [X8, #0]
    LDRSH  W15, [X8, #0]!
    ADD  X8, X8, X24, LSR #0
    STP  X16, X16, [X8, #0]
    LDRSH  X13, [X8, #0]!
    ADD  X8, X8, X24
    STP  X26, X10, [X8, #0]
    LDRSH  W10, [X8, #0]
    ADD  X8, X8, X24, ASR #0
    STP  X4, X22, [X8, #0]
    LDRSH  X22, [X8, #0]
    ADD  X8, X8, X24, LSR #0
    STP  X4, X10, [X8, #0]
    LDRSH W16, [X8, X28, LSL #0]
    ADD  X8, X8, X24
    STP  X28, X10, [X8, #0]
    LDRSH W10, [X8, W13, SXTW #0]
    ADD  X8, X8, X24, LSR #0
    STP  X18, X20, [X8, #0]
    LDRSH W4, [X8, X13, SXTX #0]
    ADD  X8, X8, X24, LSR #0
    STP  X28, X5, [X8, #0]
    LDRSH W18, [X8, W13, UXTW #1]
    ADD  X8, X8, X24, LSR #0
    STP  X28, X29, [X8, #0]
    LDRSH X26, [X8, X28, LSL #0]
    ADD  X8, X8, X24, LSR #0
    STP  X17, X28, [X8, #0]
    LDRSH X28, [X8, W13, SXTW #1]
    ADD  X8, X8, X24, LSR #0
    STP  X28, X15, [X8, #0]
    LDRSH X20, [X8, X21, SXTX #1]
    ADD  X8, X8, X24, LSR #0
    STP  X10, X18, [X8, #0]
    LDRSH X10, [X8, W23, UXTW #1]
    ADD  X8, X8, X24, ASR #0
    STP  X4, X20, [X8, #0]
    LDRSW  X29, [X8], #0
    ADD  X8, X8, X24, LSR #0
    STP  X16, X13, [X8, #0]
    LDRSW  X28, [X8, #0]!
    ADD  X8, X8, X24
    STP  X10, X28, [X8, #0]
    LDRSW  X13, [X8, #0]
    ADD  X8, X8, X24, ASR #0
    STP  X29, X23, [X8, #0]
    LDRSW X29, [X8, X26, LSL #2]
    ADD  X8, X8, X24, LSR #0
    STP  X26, X17, [X8, #0]
    LDRSW X5, [X8, W26, SXTW #2]
    ADD  X8, X8, X24, ASR #0
    STP  X13, X13, [X8, #0]
    LDRSW X18, [X8, X5, SXTX #2]
    ADD  X8, X8, X24
    STP  X18, X11, [X8, #0]
    LDRSW X17, [X8, W18, UXTW #2]
    ADD  X8, X8, X24, LSR #0
    STP  X28, X26, [X8, #0]
    LDTRSB  W26, [X8, #0]
    ADD  X8, X8, X24, ASR #0
    STP  X11, X23, [X8, #0]
    LDTRSB  X18, [X8, #0]
    ADD  X8, X8, X24, ASR #0
    STP  X10, X6, [X8, #0]
    LDTRSH  W28, [X8, #0]
    ADD  X8, X8, X24, ASR #0
    STP  X16, X16, [X8, #0]
    LDTRSH  X5, [X8, #0]
    ADD  X8, X8, X24, ASR #0
    STP  X4, X15, [X8, #0]
    LDTRSW  X10, [X8, #0]
    ADD  X8, X8, X24, ASR #0
    STP  X15, X10, [X8, #0]
    LDURSB  W4, [X8, #0]
    ADD  X8, X8, X24
    STP  X29, X13, [X8, #0]
    LDURSB  X17, [X8, #0]
    ADD  X8, X8, X24
    STP  X16, X23, [X8, #0]
    LDURSH  W23, [X8, #0]
    ADD  X8, X8, X24, ASR #0
    STP  X22, X18, [X8, #0]
    LDURSH  X22, [X8, #0]
    ADD  X8, X8, X24
    STP  X18, X22, [X8, #0]
    LDURSW  X15, [X8, #0]
    ADD  X8, X8, X24, LSR #0
    STP  X9, X20, [X8, #0]
    LDXP  W22, W16, [X8,#0]
    ADD  X8, X8, X24
    STP  X16, X15, [X8, #0]
    LDXP  X6, X16, [X8,#0]
    ADD  X8, X8, X24
    STP  X17, X17, [X8, #0]
    LDXR  W13, [X8,#0]
    ADD  X8, X8, X24, LSR #0
    STP  X23, X6, [X8, #0]
    LDXR  X29, [X8,#0]
    ADD  X8, X8, X24
    STP  X29, X29, [X8, #0]
    LDXRB  W20, [X8,#0]
    ADD  X8, X8, X24
    STP  X22, X20, [X8, #0]
    LDXRH  W23, [X8,#0]
    ADD  X8, X8, X24
    STRB  W16, [X8, #0]
    LDRB  W18, [X8, #0]
    ADD  X8, X8, X24, ASR #0
    STRB W13, [X8, X28, LSL #0]
    LDRB W15, [X8, X21, LSL #0]
    ADD  X8, X8, X24, ASR #0
    STRB W18, [X8, W28, SXTW #0]
    LDRB W9, [X8, W28, SXTW #0]
    ADD  X8, X8, X24, LSR #0
    STRB W23, [X8, X6, SXTX #0]
    LDRB W29, [X8, X21, SXTX #0]
    ADD  X8, X8, X24, ASR #0
    STRB W15, [X8, W28, UXTW #0]
    LDRB W6, [X8, W28, UXTW #0]
    ADD  X8, X8, X24
    STRH  W29, [X8, #0]
    LDRH  W28, [X8, #0]
    ADD  X8, X8, X24
    STRH W28, [X8, X21, LSL #0]
    LDRH W15, [X8, X21, LSL #0]
    ADD  X8, X8, X24
    STRH W9, [X8, W21, SXTW #0]
    LDRH W28, [X8, W21, SXTW #0]
    ADD  X8, X8, X24, ASR #0
    STRH W28, [X8, X21, SXTX #1]
    LDRH W29, [X8, X21, SXTX #1]
    ADD  X8, X8, X24
    STRH W6, [X8, W21, UXTW #1]
    LDRH W23, [X8, W21, UXTW #1]
    ADD  X8, X8, X24, LSR #0
    STR  W23, [X8, #0]
    LDR  W23, [X8, #0]
    ADD  X8, X8, X24, LSR #0
    STR  X15, [X8, #0]
    LDR  X7, [X8, #0]
    ADD  X8, X8, X24, LSR #0
    STR W7, [X8, X21, LSL #2]
    LDR W7, [X8, X21, LSL #0]
    ADD  X8, X8, X24, LSR #0
    STR W23, [X8, W21, SXTW #0]
    LDR W15, [X8, W21, SXTW #0]
    ADD  X8, X8, X24, ASR #0
    STR W15, [X8, X21, SXTX #0]
    LDR W6, [X8, X21, SXTX #2]
    ADD  X8, X8, X24, ASR #0
    STR W29, [X8, W21, UXTW #2]
    LDR W15, [X8, W21, UXTW #2]
    ADD  X8, X8, X24, ASR #0
    STR X29, [X8, X21, LSL #3]
    LDR X29, [X8, X21, LSL #0]
    ADD  X8, X8, X24, ASR #0
    STR X6, [X8, W21, SXTW #0]
    LDR X6, [X8, W21, SXTW #0]
    ADD  X8, X8, X24, ASR #0
    STR X6, [X8, X21, SXTX #0]
    LDR X23, [X8, X21, SXTX #3]
    ADD  X8, X8, X24, LSR #0
    STR X15, [X8, W21, UXTW #3]
    LDR X15, [X8, W21, UXTW #3]
    ADD  X8, X8, X24
    STP  W29, W23, [X8, #0]
    LDP  W6, W18, [X8, #0]
    ADD  X8, X8, X24
    STP  X29, X15, [X8, #0]
    LDP  X15, X23, [X8, #0]
    ADD  X8, X8, X24, ASR #0
    STTR  W18, [X8, #0]
    LDTR  W18, [X8, #0]
    ADD  X8, X8, X24, LSR #0
    STTR  X23, [X8, #0]
    LDTR  X29, [X8, #0]
    ADD  X8, X8, X24, ASR #0
    STTRB  W18, [X8, #0]
    LDTRB  W18, [X8, #0]
    ADD  X8, X8, X24, ASR #0
    STTRH  W6, [X8, #0]
    LDTRH  W23, [X8, #0]
    ADD  X8, X8, X24
    STUR  W6, [X8, #0]
    LDUR  W6, [X8, #0]
    ADD  X8, X8, X24
    STUR  X13, [X8, #0]
    LDUR  X16, [X8, #0]
    ADD  X8, X8, X24, ASR #0
    STURB  W13, [X8, #0]
    LDURB  W11, [X8, #0]
    ADD  X8, X8, X24, ASR #0
    STURH  W11, [X8, #0]
    LDURH  W5, [X8, #0]
    ADD  X8, X8, X24
    STLR  W18, [X8,#0]
    LDAR  W20, [X8,#0]
    ADD  X8, X8, X24, ASR #0
    STLR  X5, [X8,#0]
    LDAR  X5, [X8,#0]
    ADD  X8, X8, X24, ASR #0
    STLRB  W6, [X8,#0]
    LDARB  W4, [X8,#0]
    ADD  X8, X8, X24, LSR #0
    STLRH  W5, [X8,#0]
    LDARH  W23, [X8,#0]
    ADD  X8, X8, X24, LSR #0
    STNP  W16, W16, [X8, #0]
    LDNP  W13, W17, [X8, #0]
    ADD  X8, X8, X24, ASR #0
    STNP  X20, X20, [X8, #0]
    LDNP  X13, X17, [X8, #0]
    ADD  X8, X8, X24, ASR #0
    STP  W4, W17, [X8], #0
    LDP  W16, W17, [X8], #0
    ADD  X8, X8, X24
    STP  X9, X23, [X8], #0
    LDP  X18, X16, [X8], #0
    ADD  X8, X8, X24
    STP  W13, W13, [X8, #0]!
    LDP  W29, W28, [X8, #0]!
    ADD  X8, X8, X24
    STP  X16, X16, [X8, #0]!
    LDP  X20, X22, [X8, #0]!
    ADD  X8, X8, X24, LSR #0
    STR  W29, [X8], #0
    LDR  W7, [X8], #0
    ADD  X8, X8, X24
    STR  X17, [X8], #0
    LDR  X22, [X8], #0
    ADD  X8, X8, X24, LSR #0
    STR  W18, [X8, #0]!
    LDR  W10, [X8, #0]!
    ADD  X8, X8, X24, ASR #0
    STR  X10, [X8, #0]!
    LDR  X17, [X8, #0]!
    ADD  X8, X8, X24, ASR #0
    STRB  W22, [X8], #0
    LDRB  W15, [X8], #0
    ADD  X8, X8, X24
    STRB  W15, [X8, #0]!
    LDRB  W13, [X8, #0]!
    ADD  X8, X8, X24
    STRH  W20, [X8], #0
    LDRH  W11, [X8], #0
    ADD  X8, X8, X24, ASR #0
    STRH  W28, [X8, #0]!
    LDRH  W13, [X8, #0]!
    ADD  X8, X8, X24
    STP  X11, X13, [X8, #0]
    LDAXP  W6, W26, [X8,#0]
    ADD  X8, X8, X24, LSR #0
    STP  X17, X17, [X8, #0]
    LDAXP  X20, X11, [X8,#0]
    ADD  X8, X8, X24, LSR #0
    STP  X6, X20, [X8, #0]
    LDPSW  X26, X17, [X8], #0
    ADD  X8, X8, X24, LSR #0
    STP  X26, X11, [X8, #0]
    LDPSW  X26, X7, [X8, #0]!
    ADD  X8, X8, X24, LSR #0
    STP  X22, X22, [X8, #0]
    LDAXR  W5, [X8,#0]
    ADD  X8, X8, X24
    STP  X29, X10, [X8, #0]
    LDAXR  X20, [X8,#0]
    ADD  X8, X8, X24
    STP  X10, X6, [X8, #0]
    LDAXRB  W23, [X8,#0]
    ADD  X8, X8, X24, ASR #0
    STP  X26, X9, [X8, #0]
    LDAXRH  W18, [X8,#0]
    ADD  X8, X8, X24, LSR #0
    MOVZ  X2, #0x5a, LSL #0
    SUB  X25, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X25, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X25, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X25, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X25, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X25, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X25, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X25, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X25, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X25, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X25, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X25, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X25, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X25, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X25, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X25, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
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
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
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
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X16, #0x10, LSL #0
    MOVZ  X10, #0x1900, LSL #0
    ADD  X28, X30, X10, LSR #0
    STP  X29, X29, [X28, #0]
    LDPSW  X17, X4, [X28, #0]
    ADD  X28, X28, X16, LSR #0
    STP  X22, X4, [X28, #0]
    LDRSB  W24, [X28], #0
    ADD  X28, X28, X16, LSR #0
    STP  X17, X26, [X28, #0]
    LDRSB  X17, [X28], #0
    ADD  X28, X28, X16, ASR #0
    STP  X24, X20, [X28, #0]
    LDRSB  W11, [X28, #0]!
    ADD  X28, X28, X16, LSR #0
    STP  X11, X11, [X28, #0]
    LDRSB  X7, [X28, #0]!
    ADD  X28, X28, X16, LSR #0
    STP  X7, X17, [X28, #0]
    LDRSB  W29, [X28, #0]
    ADD  X28, X28, X16, ASR #0
    STP  X7, X9, [X28, #0]
    LDRSB  X23, [X28, #0]
    ADD  X28, X28, X16, LSR #0
    STP  X20, X24, [X28, #0]
    LDRSB W17, [X28, X11, LSL #0]
    ADD  X28, X28, X16, ASR #0
    STP  X23, X11, [X28, #0]
    LDRSB W23, [X28, W22, SXTW #0]
    ADD  X28, X28, X16, LSR #0
    STP  X6, X4, [X28, #0]
    LDRSB W11, [X28, X22, SXTX #0]
    ADD  X28, X28, X16
    STP  X11, X18, [X28, #0]
    LDRSB W6, [X28, W22, UXTW #0]
    ADD  X28, X28, X16, ASR #0
    STP  X29, X9, [X28, #0]
    LDRSB X11, [X28, X29, LSL #0]
    ADD  X28, X28, X16, LSR #0
    STP  X25, X24, [X28, #0]
    LDRSB X25, [X28, W29, SXTW #0]
    ADD  X28, X28, X16, ASR #0
    STP  X5, X6, [X28, #0]
    LDRSB X5, [X28, X24, SXTX #0]
    ADD  X28, X28, X16
    STP  X18, X7, [X28, #0]
    LDRSB X2, [X28, W23, UXTW #0]
    ADD  X28, X28, X16, LSR #0
    STP  X18, X4, [X28, #0]
    LDRSH  W5, [X28], #0
    ADD  X28, X28, X16
    STP  X26, X4, [X28, #0]
    LDRSH  X25, [X28], #0
    ADD  X28, X28, X16, LSR #0
    STP  X23, X7, [X28, #0]
    LDRSH  W5, [X28, #0]!
    ADD  X28, X28, X16, LSR #0
    STP  X26, X9, [X28, #0]
    LDRSH  X6, [X28, #0]!
    ADD  X28, X28, X16, ASR #0
    STP  X18, X11, [X28, #0]
    LDRSH  W26, [X28, #0]
    ADD  X28, X28, X16, ASR #0
    STP  X21, X27, [X28, #0]
    LDRSH  X25, [X28, #0]
    ADD  X28, X28, X16, LSR #0
    STP  X26, X23, [X28, #0]
    LDRSH W5, [X28, X11, LSL #1]
    ADD  X28, X28, X16
    STP  X24, X6, [X28, #0]
    LDRSH W21, [X28, W11, SXTW #1]
    ADD  X28, X28, X16, ASR #0
    STP  X20, X27, [X28, #0]
    LDRSH W29, [X28, X24, SXTX #1]
    ADD  X28, X28, X16, LSR #0
    STP  X6, X29, [X28, #0]
    LDRSH W29, [X28, W24, UXTW #1]
    ADD  X28, X28, X16, ASR #0
    STP  X18, X5, [X28, #0]
    LDRSH X9, [X28, X24, LSL #0]
    ADD  X28, X28, X16, LSR #0
    STP  X7, X7, [X28, #0]
    LDRSH X20, [X28, W7, SXTW #1]
    ADD  X28, X28, X16, ASR #0
    STP  X25, X4, [X28, #0]
    LDRSH X26, [X28, X7, SXTX #0]
    ADD  X28, X28, X16
    STP  X6, X25, [X28, #0]
    LDRSH X25, [X28, W23, UXTW #0]
    ADD  X28, X28, X16
    STP  X27, X13, [X28, #0]
    LDRSW  X27, [X28], #0
    ADD  X28, X28, X16, ASR #0
    STP  X9, X24, [X28, #0]
    LDRSW  X29, [X28, #0]!
    ADD  X28, X28, X16, ASR #0
    STP  X29, X23, [X28, #0]
    LDRSW  X9, [X28, #0]
    ADD  X28, X28, X16, ASR #0
    STP  X7, X25, [X28, #0]
    LDRSW X18, [X28, X7, LSL #2]
    ADD  X28, X28, X16, LSR #0
    STP  X21, X6, [X28, #0]
    LDRSW X29, [X28, W20, SXTW #2]
    ADD  X28, X28, X16, ASR #0
    STP  X2, X9, [X28, #0]
    LDRSW X6, [X28, X22, SXTX #0]
    ADD  X28, X28, X16
    STP  X23, X2, [X28, #0]
    LDRSW X24, [X28, W24, UXTW #0]
    ADD  X28, X28, X16, LSR #0
    STP  X9, X2, [X28, #0]
    LDTRSB  W5, [X28, #0]
    ADD  X28, X28, X16, LSR #0
    STP  X5, X21, [X28, #0]
    LDTRSB  X25, [X28, #0]
    ADD  X28, X28, X16, ASR #0
    STP  X22, X7, [X28, #0]
    LDTRSH  W11, [X28, #0]
    ADD  X28, X28, X16, LSR #0
    STP  X5, X4, [X28, #0]
    LDTRSH  X18, [X28, #0]
    ADD  X28, X28, X16
    STP  X22, X22, [X28, #0]
    LDTRSW  X9, [X28, #0]
    ADD  X28, X28, X16, ASR #0
    STP  X7, X22, [X28, #0]
    LDURSB  W27, [X28, #0]
    ADD  X28, X28, X16
    STP  X29, X25, [X28, #0]
    LDURSB  X20, [X28, #0]
    ADD  X28, X28, X16
    STP  X24, X6, [X28, #0]
    LDURSH  W26, [X28, #0]
    ADD  X28, X28, X16, ASR #0
    STP  X23, X9, [X28, #0]
    LDURSH  X27, [X28, #0]
    ADD  X28, X28, X16, LSR #0
    STP  X11, X18, [X28, #0]
    LDURSW  X27, [X28, #0]
    ADD  X28, X28, X16
    STP  X26, X27, [X28, #0]
    LDXP  W26, W29, [X28,#0]
    ADD  X28, X28, X16
    STP  X22, X21, [X28, #0]
    LDXP  X6, X27, [X28,#0]
    ADD  X28, X28, X16, ASR #0
    STP  X7, X17, [X28, #0]
    LDXR  W7, [X28,#0]
    ADD  X28, X28, X16, LSR #0
    STP  X4, X23, [X28, #0]
    LDXR  X25, [X28,#0]
    ADD  X28, X28, X16, ASR #0
    STP  X4, X23, [X28, #0]
    LDXRB  W2, [X28,#0]
    ADD  X28, X28, X16, LSR #0
    STP  X25, X20, [X28, #0]
    LDXRH  W17, [X28,#0]
    ADD  X28, X28, X16
    STRB  W17, [X28, #0]
    LDRB  W4, [X28, #0]
    ADD  X28, X28, X16
    STRB W29, [X28, X27, LSL #0]
    LDRB W21, [X28, X7, LSL #0]
    ADD  X28, X28, X16
    STRB W26, [X28, W22, SXTW #0]
    LDRB W18, [X28, W27, SXTW #0]
    ADD  X28, X28, X16
    STRB W4, [X28, X20, SXTX #0]
    LDRB W17, [X28, X18, SXTX #0]
    ADD  X28, X28, X16, LSR #0
    STRB W2, [X28, W21, UXTW #0]
    LDRB W7, [X28, W26, UXTW #0]
    ADD  X28, X28, X16, LSR #0
    STRH  W22, [X28, #0]
    LDRH  W18, [X28, #0]
    ADD  X28, X28, X16, ASR #0
    STRH W18, [X28, X6, LSL #0]
    LDRH W27, [X28, X21, LSL #0]
    ADD  X28, X28, X16
    STRH W17, [X28, W27, SXTW #0]
    LDRH W17, [X28, W23, SXTW #0]
    ADD  X28, X28, X16, LSR #0
    STRH W2, [X28, X11, SXTX #1]
    LDRH W4, [X28, X18, SXTX #0]
    ADD  X28, X28, X16, LSR #0
    STRH W21, [X28, W21, UXTW #1]
    LDRH W20, [X28, W27, UXTW #0]
    ADD  X28, X28, X16, ASR #0
    STR  W4, [X28, #0]
    LDR  W18, [X28, #0]
    ADD  X28, X28, X16, ASR #0
    STR  X27, [X28, #0]
    LDR  X26, [X28, #0]
    ADD  X28, X28, X16
    STR W9, [X28, X24, LSL #2]
    LDR W11, [X28, X20, LSL #0]
    ADD  X28, X28, X16, LSR #0
    STR W2, [X28, W9, SXTW #0]
    LDR W2, [X28, W11, SXTW #2]
    ADD  X28, X28, X16, ASR #0
    STR W2, [X28, X9, SXTX #2]
    LDR W20, [X28, X24, SXTX #2]
    ADD  X28, X28, X16, ASR #0
    STR W29, [X28, W27, UXTW #0]
    LDR W9, [X28, W26, UXTW #0]
    ADD  X28, X28, X16
    STR X20, [X28, X24, LSL #3]
    LDR X11, [X28, X26, LSL #0]
    ADD  X28, X28, X16, LSR #0
    STR X4, [X28, W23, SXTW #3]
    LDR X27, [X28, W21, SXTW #0]
    ADD  X28, X28, X16
    STR X29, [X28, X26, SXTX #3]
    LDR X5, [X28, X22, SXTX #0]
    ADD  X28, X28, X16, ASR #0
    STR X9, [X28, W22, UXTW #0]
    LDR X24, [X28, W22, UXTW #3]
    ADD  X28, X28, X16
    STP  W24, W5, [X28, #0]
    LDP  W29, W21, [X28, #0]
    ADD  X28, X28, X16, ASR #0
    STP  X6, X11, [X28, #0]
    LDP  X20, X9, [X28, #0]
    ADD  X28, X28, X16, LSR #0
    STTR  W5, [X28, #0]
    LDTR  W5, [X28, #0]
    ADD  X28, X28, X16, LSR #0
    STTR  X22, [X28, #0]
    LDTR  X11, [X28, #0]
    ADD  X28, X28, X16
    STTRB  W4, [X28, #0]
    LDTRB  W26, [X28, #0]
    ADD  X28, X28, X16, ASR #0
    STTRH  W21, [X28, #0]
    LDTRH  W17, [X28, #0]
    ADD  X28, X28, X16, ASR #0
    STUR  W29, [X28, #0]
    LDUR  W4, [X28, #0]
    ADD  X28, X28, X16, ASR #0
    STUR  X11, [X28, #0]
    LDUR  X29, [X28, #0]
    ADD  X28, X28, X16, ASR #0
    STURB  W17, [X28, #0]
    LDURB  W21, [X28, #0]
    ADD  X28, X28, X16, ASR #0
    STURH  W4, [X28, #0]
    LDURH  W6, [X28, #0]
    ADD  X28, X28, X16, ASR #0
    STLR  W29, [X28,#0]
    LDAR  W11, [X28,#0]
    ADD  X28, X28, X16, ASR #0
    STLR  X26, [X28,#0]
    LDAR  X4, [X28,#0]
    ADD  X28, X28, X16, ASR #0
    STLRB  W20, [X28,#0]
    LDARB  W17, [X28,#0]
    ADD  X28, X28, X16
    STLRH  W17, [X28,#0]
    LDARH  W29, [X28,#0]
    ADD  X28, X28, X16, ASR #0
    STNP  W11, W17, [X28, #0]
    LDNP  W26, W11, [X28, #0]
    ADD  X28, X28, X16, LSR #0
    STNP  X4, X4, [X28, #0]
    LDNP  X20, X17, [X28, #0]
    ADD  X28, X28, X16, LSR #0
    STP  W26, W6, [X28], #0
    LDP  W5, W2, [X28], #0
    ADD  X28, X28, X16, ASR #0
    STP  X11, X29, [X28], #0
    LDP  X20, X4, [X28], #0
    ADD  X28, X28, X16, LSR #0
    STP  W21, W20, [X28, #0]!
    LDP  W11, W17, [X28, #0]!
    ADD  X28, X28, X16, ASR #0
    STP  X2, X2, [X28, #0]!
    LDP  X24, X20, [X28, #0]!
    ADD  X28, X28, X16, LSR #0
    STR  W4, [X28], #0
    LDR  W29, [X28], #0
    ADD  X28, X28, X16
    STR  X18, [X28], #0
    LDR  X4, [X28], #0
    ADD  X28, X28, X16, ASR #0
    STR  W29, [X28, #0]!
    LDR  W7, [X28, #0]!
    ADD  X28, X28, X16, LSR #0
    STR  X22, [X28, #0]!
    LDR  X5, [X28, #0]!
    ADD  X28, X28, X16
    STRB  W4, [X28], #0
    LDRB  W20, [X28], #0
    ADD  X28, X28, X16, LSR #0
    STRB  W17, [X28, #0]!
    LDRB  W4, [X28, #0]!
    ADD  X28, X28, X16, LSR #0
    STRH  W5, [X28], #0
    LDRH  W7, [X28], #0
    ADD  X28, X28, X16, LSR #0
    STRH  W4, [X28, #0]!
    LDRH  W4, [X28, #0]!
    ADD  X28, X28, X16, LSR #0
    STP  X4, X7, [X28, #0]
    LDAXP  W5, W23, [X28,#0]
    ADD  X28, X28, X16, LSR #0
    STP  X24, X20, [X28, #0]
    LDAXP  X26, X24, [X28,#0]
    ADD  X28, X28, X16, ASR #0
    STP  X20, X23, [X28, #0]
    LDPSW  X11, X2, [X28], #0
    ADD  X28, X28, X16
    STP  X24, X5, [X28, #0]
    LDPSW  X23, X6, [X28, #0]!
    ADD  X28, X28, X16
    STP  X24, X23, [X28, #0]
    LDAXR  W17, [X28,#0]
    ADD  X28, X28, X16, LSR #0
    STP  X6, X6, [X28, #0]
    LDAXR  X29, [X28,#0]
    ADD  X28, X28, X16, ASR #0
    STP  X26, X24, [X28, #0]
    LDAXRB  W27, [X28,#0]
    ADD  X28, X28, X16, LSR #0
    STP  X17, X17, [X28, #0]
    LDAXRH  W2, [X28,#0]
    ADD  X28, X28, X16, LSR #0
    MOVZ  X15, #0xa5, LSL #0
    SUB  X8, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X15, #0xa5, LSL #0
    SUB  X8, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X15, #0xa5, LSL #0
    SUB  X8, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X8, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X15, #0xa5, LSL #0
    SUB  X8, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X15, #0xa5, LSL #0
    SUB  X8, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X15, #0xa5, LSL #0
    SUB  X8, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X15, #0xa5, LSL #0
    SUB  X8, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X15, #0xa5, LSL #0
    SUB  X8, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X8, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
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
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
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
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X27, #0x10, LSL #0
    MOVZ  X18, #0x1e00, LSL #0
    ADD  X6, X30, X18, ASR #0
    STP  X28, X26, [X6, #0]
    LDPSW  X23, X13, [X6, #0]
    ADD  X6, X6, X27
    STP  X23, X23, [X6, #0]
    LDRSB  W16, [X6], #0
    ADD  X6, X6, X27
    STP  X8, X26, [X6, #0]
    LDRSB  X29, [X6], #0
    ADD  X6, X6, X27
    STP  X13, X13, [X6, #0]
    LDRSB  W22, [X6, #0]!
    ADD  X6, X6, X27
    STP  X22, X16, [X6, #0]
    LDRSB  X22, [X6, #0]!
    ADD  X6, X6, X27, LSR #0
    STP  X7, X20, [X6, #0]
    LDRSB  W24, [X6, #0]
    ADD  X6, X6, X27
    STP  X5, X26, [X6, #0]
    LDRSB  X25, [X6, #0]
    ADD  X6, X6, X27, LSR #0
    STP  X26, X13, [X6, #0]
    LDRSB W10, [X6, X8, LSL #0]
    ADD  X6, X6, X27, ASR #0
    STP  X2, X21, [X6, #0]
    LDRSB W28, [X6, W8, SXTW #0]
    ADD  X6, X6, X27, ASR #0
    STP  X28, X26, [X6, #0]
    LDRSB W5, [X6, X29, SXTX #0]
    ADD  X6, X6, X27
    STP  X10, X15, [X6, #0]
    LDRSB W10, [X6, W29, UXTW #0]
    ADD  X6, X6, X27, LSR #0
    STP  X7, X8, [X6, #0]
    LDRSB X13, [X6, X29, LSL #0]
    ADD  X6, X6, X27, LSR #0
    STP  X15, X25, [X6, #0]
    LDRSB X25, [X6, W29, SXTW #0]
    ADD  X6, X6, X27, LSR #0
    STP  X20, X8, [X6, #0]
    LDRSB X21, [X6, X8, SXTX #0]
    ADD  X6, X6, X27, LSR #0
    STP  X22, X28, [X6, #0]
    LDRSB X28, [X6, W29, UXTW #0]
    ADD  X6, X6, X27, ASR #0
    STP  X2, X25, [X6, #0]
    LDRSH  W15, [X6], #0
    ADD  X6, X6, X27
    STP  X22, X17, [X6, #0]
    LDRSH  X26, [X6], #0
    ADD  X6, X6, X27, LSR #0
    STP  X4, X16, [X6, #0]
    LDRSH  W22, [X6, #0]!
    ADD  X6, X6, X27
    STP  X15, X15, [X6, #0]
    LDRSH  X2, [X6, #0]!
    ADD  X6, X6, X27, ASR #0
    STP  X26, X22, [X6, #0]
    LDRSH  W29, [X6, #0]
    ADD  X6, X6, X27
    STP  X28, X28, [X6, #0]
    LDRSH  X26, [X6, #0]
    ADD  X6, X6, X27, LSR #0
    STP  X29, X2, [X6, #0]
    LDRSH W20, [X6, X8, LSL #1]
    ADD  X6, X6, X27
    STP  X26, X26, [X6, #0]
    LDRSH W17, [X6, W8, SXTW #1]
    ADD  X6, X6, X27, ASR #0
    STP  X17, X20, [X6, #0]
    LDRSH W25, [X6, X8, SXTX #1]
    ADD  X6, X6, X27
    STP  X2, X2, [X6, #0]
    LDRSH W15, [X6, W8, UXTW #1]
    ADD  X6, X6, X27, ASR #0
    STP  X4, X28, [X6, #0]
    LDRSH X17, [X6, X8, LSL #1]
    ADD  X6, X6, X27, ASR #0
    STP  X17, X24, [X6, #0]
    LDRSH X20, [X6, W8, SXTW #1]
    ADD  X6, X6, X27, LSR #0
    STP  X15, X26, [X6, #0]
    LDRSH X29, [X6, X8, SXTX #1]
    ADD  X6, X6, X27
    STP  X15, X7, [X6, #0]
    LDRSH X28, [X6, W8, UXTW #1]
    ADD  X6, X6, X27, ASR #0
    STP  X25, X16, [X6, #0]
    LDRSW  X2, [X6], #0
    ADD  X6, X6, X27
    STP  X17, X22, [X6, #0]
    LDRSW  X7, [X6, #0]!
    ADD  X6, X6, X27
    STP  X17, X8, [X6, #0]
    LDRSW  X4, [X6, #0]
    ADD  X6, X6, X27
    STP  X22, X23, [X6, #0]
    LDRSW X24, [X6, X8, LSL #0]
    ADD  X6, X6, X27
    STP  X25, X24, [X6, #0]
    LDRSW X23, [X6, W8, SXTW #2]
    ADD  X6, X6, X27, LSR #0
    STP  X28, X17, [X6, #0]
    LDRSW X15, [X6, X8, SXTX #2]
    ADD  X6, X6, X27
    STP  X29, X4, [X6, #0]
    LDRSW X24, [X6, W8, UXTW #0]
    ADD  X6, X6, X27, LSR #0
    STP  X7, X29, [X6, #0]
    LDTRSB  W22, [X6, #0]
    ADD  X6, X6, X27
    STP  X29, X5, [X6, #0]
    LDTRSB  X25, [X6, #0]
    ADD  X6, X6, X27, ASR #0
    STP  X23, X25, [X6, #0]
    LDTRSH  W16, [X6, #0]
    ADD  X6, X6, X27, LSR #0
    STP  X16, X15, [X6, #0]
    LDTRSH  X28, [X6, #0]
    ADD  X6, X6, X27, ASR #0
    STP  X26, X8, [X6, #0]
    LDTRSW  X17, [X6, #0]
    ADD  X6, X6, X27
    STP  X22, X29, [X6, #0]
    LDURSB  W7, [X6, #0]
    ADD  X6, X6, X27
    STP  X21, X5, [X6, #0]
    LDURSB  X23, [X6, #0]
    ADD  X6, X6, X27
    STP  X24, X5, [X6, #0]
    LDURSH  W22, [X6, #0]
    ADD  X6, X6, X27, ASR #0
    STP  X16, X17, [X6, #0]
    LDURSH  X20, [X6, #0]
    ADD  X6, X6, X27
    STP  X22, X25, [X6, #0]
    LDURSW  X21, [X6, #0]
    ADD  X6, X6, X27
    STP  X20, X26, [X6, #0]
    LDXP  W16, W29, [X6,#0]
    ADD  X6, X6, X27
    STP  X2, X4, [X6, #0]
    LDXP  X17, X5, [X6,#0]
    ADD  X6, X6, X27, LSR #0
    STP  X29, X17, [X6, #0]
    LDXR  W26, [X6,#0]
    ADD  X6, X6, X27
    STP  X21, X26, [X6, #0]
    LDXR  X13, [X6,#0]
    ADD  X6, X6, X27
    STP  X16, X5, [X6, #0]
    LDXRB  W29, [X6,#0]
    ADD  X6, X6, X27, LSR #0
    STP  X29, X29, [X6, #0]
    LDXRH  W20, [X6,#0]
    ADD  X6, X6, X27, LSR #0
    STRB  W23, [X6, #0]
    LDRB  W23, [X6, #0]
    ADD  X6, X6, X27, LSR #0
    STRB W23, [X6, X8, LSL #0]
    LDRB W23, [X6, X26, LSL #0]
    ADD  X6, X6, X27
    STRB W23, [X6, W8, SXTW #0]
    LDRB W26, [X6, W26, SXTW #0]
    ADD  X6, X6, X27, ASR #0
    STRB W13, [X6, X8, SXTX #0]
    LDRB W21, [X6, X8, SXTX #0]
    ADD  X6, X6, X27, LSR #0
    STRB W20, [X6, W8, UXTW #0]
    LDRB W20, [X6, W8, UXTW #0]
    ADD  X6, X6, X27, LSR #0
    STRH  W20, [X6, #0]
    LDRH  W20, [X6, #0]
    ADD  X6, X6, X27, ASR #0
    STRH W21, [X6, X8, LSL #1]
    LDRH W23, [X6, X8, LSL #0]
    ADD  X6, X6, X27
    STRH W13, [X6, W8, SXTW #0]
    LDRH W21, [X6, W8, SXTW #1]
    ADD  X6, X6, X27
    STRH W23, [X6, X8, SXTX #0]
    LDRH W23, [X6, X8, SXTX #1]
    ADD  X6, X6, X27
    STRH W26, [X6, W8, UXTW #1]
    LDRH W13, [X6, W8, UXTW #0]
    ADD  X6, X6, X27, ASR #0
    STR  W20, [X6, #0]
    LDR  W20, [X6, #0]
    ADD  X6, X6, X27, ASR #0
    STR  X21, [X6, #0]
    LDR  X22, [X6, #0]
    ADD  X6, X6, X27, ASR #0
    STR W23, [X6, X8, LSL #0]
    LDR W23, [X6, X8, LSL #2]
    ADD  X6, X6, X27, LSR #0
    STR W22, [X6, W8, SXTW #0]
    LDR W13, [X6, W8, SXTW #0]
    ADD  X6, X6, X27
    STR W17, [X6, X8, SXTX #0]
    LDR W17, [X6, X8, SXTX #0]
    ADD  X6, X6, X27, LSR #0
    STR W13, [X6, W8, UXTW #2]
    LDR W13, [X6, W8, UXTW #0]
    ADD  X6, X6, X27, LSR #0
    STR X17, [X6, X8, LSL #3]
    LDR X17, [X6, X8, LSL #0]
    ADD  X6, X6, X27, ASR #0
    STR X17, [X6, W8, SXTW #0]
    LDR X17, [X6, W8, SXTW #3]
    ADD  X6, X6, X27
    STR X13, [X6, X8, SXTX #0]
    LDR X22, [X6, X8, SXTX #3]
    ADD  X6, X6, X27
    STR X17, [X6, W8, UXTW #0]
    LDR X21, [X6, W8, UXTW #0]
    ADD  X6, X6, X27, LSR #0
    STP  W22, W21, [X6, #0]
    LDP  W21, W16, [X6, #0]
    ADD  X6, X6, X27, ASR #0
    STP  X2, X21, [X6, #0]
    LDP  X17, X15, [X6, #0]
    ADD  X6, X6, X27
    STTR  W16, [X6, #0]
    LDTR  W2, [X6, #0]
    ADD  X6, X6, X27, LSR #0
    STTR  X15, [X6, #0]
    LDTR  X21, [X6, #0]
    ADD  X6, X6, X27
    STTRB  W21, [X6, #0]
    LDTRB  W2, [X6, #0]
    ADD  X6, X6, X27
    STTRH  W25, [X6, #0]
    LDTRH  W13, [X6, #0]
    ADD  X6, X6, X27, ASR #0
    STUR  W2, [X6, #0]
    LDUR  W21, [X6, #0]
    ADD  X6, X6, X27, ASR #0
    STUR  X17, [X6, #0]
    LDUR  X15, [X6, #0]
    ADD  X6, X6, X27, LSR #0
    STURB  W13, [X6, #0]
    LDURB  W16, [X6, #0]
    ADD  X6, X6, X27
    STURH  W16, [X6, #0]
    LDURH  W16, [X6, #0]
    ADD  X6, X6, X27, ASR #0
    STLR  W15, [X6,#0]
    LDAR  W25, [X6,#0]
    ADD  X6, X6, X27
    STLR  X5, [X6,#0]
    LDAR  X2, [X6,#0]
    ADD  X6, X6, X27, ASR #0
    STLRB  W21, [X6,#0]
    LDARB  W15, [X6,#0]
    ADD  X6, X6, X27, ASR #0
    STLRH  W25, [X6,#0]
    LDARH  W13, [X6,#0]
    ADD  X6, X6, X27, LSR #0
    STNP  W15, W2, [X6, #0]
    LDNP  W5, W25, [X6, #0]
    ADD  X6, X6, X27, ASR #0
    STNP  X13, X13, [X6, #0]
    LDNP  X2, X13, [X6, #0]
    ADD  X6, X6, X27, LSR #0
    STP  W5, W5, [X6], #0
    LDP  W21, W5, [X6], #0
    ADD  X6, X6, X27, ASR #0
    STP  X21, X25, [X6], #0
    LDP  X15, X21, [X6], #0
    ADD  X6, X6, X27, LSR #0
    STP  W26, W5, [X6, #0]!
    LDP  W24, W7, [X6, #0]!
    ADD  X6, X6, X27
    STP  X7, X13, [X6, #0]!
    LDP  X2, X25, [X6, #0]!
    ADD  X6, X6, X27, ASR #0
    STR  W15, [X6], #0
    LDR  W25, [X6], #0
    ADD  X6, X6, X27, ASR #0
    STR  X2, [X6], #0
    LDR  X4, [X6], #0
    ADD  X6, X6, X27, ASR #0
    STR  W24, [X6, #0]!
    LDR  W13, [X6, #0]!
    ADD  X6, X6, X27
    STR  X4, [X6, #0]!
    LDR  X4, [X6, #0]!
    ADD  X6, X6, X27
    STRB  W13, [X6], #0
    LDRB  W4, [X6], #0
    ADD  X6, X6, X27, LSR #0
    STRB  W25, [X6, #0]!
    LDRB  W7, [X6, #0]!
    ADD  X6, X6, X27
    STRH  W7, [X6], #0
    LDRH  W16, [X6], #0
    ADD  X6, X6, X27, ASR #0
    STRH  W4, [X6, #0]!
    LDRH  W7, [X6, #0]!
    ADD  X6, X6, X27, ASR #0
    STP  X16, X16, [X6, #0]
    LDAXP  W16, W4, [X6,#0]
    ADD  X6, X6, X27, ASR #0
    STP  X25, X17, [X6, #0]
    LDAXP  X5, X7, [X6,#0]
    ADD  X6, X6, X27
    STP  X26, X29, [X6, #0]
    LDPSW  X25, X20, [X6], #0
    ADD  X6, X6, X27
    STP  X20, X7, [X6, #0]
    LDPSW  X7, X25, [X6, #0]!
    ADD  X6, X6, X27, ASR #0
    STP  X13, X7, [X6, #0]
    LDAXR  W24, [X6,#0]
    ADD  X6, X6, X27, ASR #0
    STP  X5, X2, [X6, #0]
    LDAXR  X28, [X6,#0]
    ADD  X6, X6, X27, LSR #0
    STP  X21, X10, [X6, #0]
    LDAXRB  W7, [X6,#0]
    ADD  X6, X6, X27, ASR #0
    STP  X24, X7, [X6, #0]
    LDAXRH  W17, [X6,#0]
    ADD  X6, X6, X27, LSR #0
    MOVZ  X9, #0x5a, LSL #0
    SUB  X11, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x5a, LSL #0
    SUB  X11, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x5a, LSL #0
    SUB  X11, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x5a, LSL #0
    SUB  X11, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x5a, LSL #0
    SUB  X11, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x5a, LSL #0
    SUB  X11, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x5a, LSL #0
    SUB  X11, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x5a, LSL #0
    SUB  X11, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    SUB  X11, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    SUB  X11, X9, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x5a, LSL #0
    SUB  X11, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x5a, LSL #0
    SUB  X11, X9, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x5a, LSL #0
    SUB  X11, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x5a, LSL #0
    SUB  X11, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x5a, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
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
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
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
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x10, LSL #0
    MOVZ  X13, #0x2300, LSL #0
    ADD  X20, X30, X13, ASR #0
    STP  X8, X26, [X20, #0]
    LDPSW  X21, X27, [X20, #0]
    ADD  X20, X20, X7
    STP  X29, X6, [X20, #0]
    LDRSB  W17, [X20], #0
    ADD  X20, X20, X7, ASR #0
    STP  X28, X21, [X20, #0]
    LDRSB  X11, [X20], #0
    ADD  X20, X20, X7, LSR #0
    STP  X27, X10, [X20, #0]
    LDRSB  W29, [X20, #0]!
    ADD  X20, X20, X7, LSR #0
    STP  X18, X4, [X20, #0]
    LDRSB  X25, [X20, #0]!
    ADD  X20, X20, X7, ASR #0
    STP  X25, X17, [X20, #0]
    LDRSB  W21, [X20, #0]
    ADD  X20, X20, X7
    STP  X29, X28, [X20, #0]
    LDRSB  X4, [X20, #0]
    ADD  X20, X20, X7, ASR #0
    STP  X21, X21, [X20, #0]
    LDRSB W17, [X20, X6, LSL #0]
    ADD  X20, X20, X7
    STP  X17, X4, [X20, #0]
    LDRSB W25, [X20, W6, SXTW #0]
    ADD  X20, X20, X7, LSR #0
    STP  X22, X6, [X20, #0]
    LDRSB W18, [X20, X6, SXTX #0]
    ADD  X20, X20, X7, LSR #0
    STP  X29, X6, [X20, #0]
    LDRSB W21, [X20, W6, UXTW #0]
    ADD  X20, X20, X7, ASR #0
    STP  X15, X17, [X20, #0]
    LDRSB X22, [X20, X6, LSL #0]
    ADD  X20, X20, X7, LSR #0
    STP  X17, X16, [X20, #0]
    LDRSB X17, [X20, W6, SXTW #0]
    ADD  X20, X20, X7, ASR #0
    STP  X28, X29, [X20, #0]
    LDRSB X15, [X20, X6, SXTX #0]
    ADD  X20, X20, X7
    STP  X8, X4, [X20, #0]
    LDRSB X8, [X20, W6, UXTW #0]
    ADD  X20, X20, X7, ASR #0
    STP  X23, X4, [X20, #0]
    LDRSH  W23, [X20], #0
    ADD  X20, X20, X7, LSR #0
    STP  X18, X25, [X20, #0]
    LDRSH  X29, [X20], #0
    ADD  X20, X20, X7
    STP  X15, X6, [X20, #0]
    LDRSH  W25, [X20, #0]!
    ADD  X20, X20, X7, ASR #0
    STP  X25, X23, [X20, #0]
    LDRSH  X28, [X20, #0]!
    ADD  X20, X20, X7
    STP  X29, X8, [X20, #0]
    LDRSH  W15, [X20, #0]
    ADD  X20, X20, X7, LSR #0
    STP  X21, X28, [X20, #0]
    LDRSH  X18, [X20, #0]
    ADD  X20, X20, X7
    STP  X15, X15, [X20, #0]
    LDRSH W25, [X20, X6, LSL #0]
    ADD  X20, X20, X7, LSR #0
    STP  X18, X18, [X20, #0]
    LDRSH W4, [X20, W6, SXTW #1]
    ADD  X20, X20, X7
    STP  X25, X4, [X20, #0]
    LDRSH W8, [X20, X6, SXTX #1]
    ADD  X20, X20, X7, LSR #0
    STP  X10, X18, [X20, #0]
    LDRSH W29, [X20, W6, UXTW #1]
    ADD  X20, X20, X7
    STP  X11, X29, [X20, #0]
    LDRSH X29, [X20, X6, LSL #0]
    ADD  X20, X20, X7, ASR #0
    STP  X29, X26, [X20, #0]
    LDRSH X28, [X20, W6, SXTW #0]
    ADD  X20, X20, X7, LSR #0
    STP  X8, X9, [X20, #0]
    LDRSH X18, [X20, X6, SXTX #1]
    ADD  X20, X20, X7, LSR #0
    STP  X6, X16, [X20, #0]
    LDRSH X4, [X20, W6, UXTW #0]
    ADD  X20, X20, X7, LSR #0
    STP  X21, X15, [X20, #0]
    LDRSW  X15, [X20], #0
    ADD  X20, X20, X7
    STP  X25, X10, [X20, #0]
    LDRSW  X9, [X20, #0]!
    ADD  X20, X20, X7, ASR #0
    STP  X17, X21, [X20, #0]
    LDRSW  X29, [X20, #0]
    ADD  X20, X20, X7, LSR #0
    STP  X10, X26, [X20, #0]
    LDRSW X16, [X20, X4, LSL #2]
    ADD  X20, X20, X7
    STP  X28, X29, [X20, #0]
    LDRSW X29, [X20, W4, SXTW #2]
    ADD  X20, X20, X7, LSR #0
    STP  X25, X15, [X20, #0]
    LDRSW X26, [X20, X4, SXTX #0]
    ADD  X20, X20, X7, ASR #0
    STP  X10, X28, [X20, #0]
    LDRSW X4, [X20, W6, UXTW #0]
    ADD  X20, X20, X7, LSR #0
    STP  X23, X15, [X20, #0]
    LDTRSB  W10, [X20, #0]
    ADD  X20, X20, X7
    STP  X21, X29, [X20, #0]
    LDTRSB  X28, [X20, #0]
    ADD  X20, X20, X7, LSR #0
    STP  X17, X15, [X20, #0]
    LDTRSH  W23, [X20, #0]
    ADD  X20, X20, X7
    STP  X15, X25, [X20, #0]
    LDTRSH  X2, [X20, #0]
    ADD  X20, X20, X7, LSR #0
    STP  X4, X2, [X20, #0]
    LDTRSW  X4, [X20, #0]
    ADD  X20, X20, X7, LSR #0
    STP  X4, X16, [X20, #0]
    LDURSB  W16, [X20, #0]
    ADD  X20, X20, X7, LSR #0
    STP  X16, X23, [X20, #0]
    LDURSB  X29, [X20, #0]
    ADD  X20, X20, X7, ASR #0
    STP  X10, X10, [X20, #0]
    LDURSH  W15, [X20, #0]
    ADD  X20, X20, X7, ASR #0
    STP  X29, X29, [X20, #0]
    LDURSH  X2, [X20, #0]
    ADD  X20, X20, X7, LSR #0
    STP  X15, X15, [X20, #0]
    LDURSW  X17, [X20, #0]
    ADD  X20, X20, X7, ASR #0
    STP  X2, X17, [X20, #0]
    LDXP  W29, W2, [X20,#0]
    ADD  X20, X20, X7, ASR #0
    STP  X23, X15, [X20, #0]
    LDXP  X16, X25, [X20,#0]
    ADD  X20, X20, X7, LSR #0
    STP  X21, X28, [X20, #0]
    LDXR  W17, [X20,#0]
    ADD  X20, X20, X7
    STP  X10, X22, [X20, #0]
    LDXR  X15, [X20,#0]
    ADD  X20, X20, X7
    STP  X21, X26, [X20, #0]
    LDXRB  W28, [X20,#0]
    ADD  X20, X20, X7
    STP  X6, X23, [X20, #0]
    LDXRH  W10, [X20,#0]
    ADD  X20, X20, X7
    STRB  W29, [X20, #0]
    LDRB  W11, [X20, #0]
    ADD  X20, X20, X7, LSR #0
    STRB W2, [X20, X6, LSL #0]
    LDRB W9, [X20, X10, LSL #0]
    ADD  X20, X20, X7
    STRB W15, [X20, W6, SXTW #0]
    LDRB W26, [X20, W6, SXTW #0]
    ADD  X20, X20, X7, ASR #0
    STRB W9, [X20, X10, SXTX #0]
    LDRB W18, [X20, X10, SXTX #0]
    ADD  X20, X20, X7, ASR #0
    STRB W18, [X20, W6, UXTW #0]
    LDRB W9, [X20, W6, UXTW #0]
    ADD  X20, X20, X7, LSR #0
    STRH  W28, [X20, #0]
    LDRH  W28, [X20, #0]
    ADD  X20, X20, X7, LSR #0
    STRH W9, [X20, X6, LSL #1]
    LDRH W15, [X20, X10, LSL #1]
    ADD  X20, X20, X7, LSR #0
    STRH W26, [X20, W6, SXTW #1]
    LDRH W18, [X20, W6, SXTW #1]
    ADD  X20, X20, X7
    STRH W9, [X20, X6, SXTX #1]
    LDRH W26, [X20, X6, SXTX #1]
    ADD  X20, X20, X7, LSR #0
    STRH W18, [X20, W6, UXTW #1]
    LDRH W29, [X20, W10, UXTW #1]
    ADD  X20, X20, X7, LSR #0
    STR  W15, [X20, #0]
    LDR  W10, [X20, #0]
    ADD  X20, X20, X7, LSR #0
    STR  X28, [X20, #0]
    LDR  X15, [X20, #0]
    ADD  X20, X20, X7, LSR #0
    STR W26, [X20, X6, LSL #0]
    LDR W18, [X20, X6, LSL #2]
    ADD  X20, X20, X7, ASR #0
    STR W10, [X20, W6, SXTW #0]
    LDR W26, [X20, W6, SXTW #2]
    ADD  X20, X20, X7, LSR #0
    STR W18, [X20, X6, SXTX #2]
    LDR W28, [X20, X6, SXTX #0]
    ADD  X20, X20, X7, LSR #0
    STR W26, [X20, W6, UXTW #0]
    LDR W10, [X20, W6, UXTW #2]
    ADD  X20, X20, X7, LSR #0
    STR X17, [X20, X6, LSL #0]
    LDR X17, [X20, X6, LSL #0]
    ADD  X20, X20, X7
    STR X28, [X20, W6, SXTW #3]
    LDR X28, [X20, W6, SXTW #3]
    ADD  X20, X20, X7
    STR X29, [X20, X6, SXTX #3]
    LDR X18, [X20, X6, SXTX #0]
    ADD  X20, X20, X7, ASR #0
    STR X28, [X20, W6, UXTW #0]
    LDR X26, [X20, W6, UXTW #3]
    ADD  X20, X20, X7
    STP  W15, W10, [X20, #0]
    LDP  W29, W15, [X20, #0]
    ADD  X20, X20, X7
    STP  X18, X2, [X20, #0]
    LDP  X18, X28, [X20, #0]
    ADD  X20, X20, X7, ASR #0
    STTR  W17, [X20, #0]
    LDTR  W22, [X20, #0]
    ADD  X20, X20, X7
    STTR  X26, [X20, #0]
    LDTR  X26, [X20, #0]
    ADD  X20, X20, X7, ASR #0
    STTRB  W26, [X20, #0]
    LDTRB  W2, [X20, #0]
    ADD  X20, X20, X7
    STTRH  W28, [X20, #0]
    LDTRH  W17, [X20, #0]
    ADD  X20, X20, X7, ASR #0
    STUR  W2, [X20, #0]
    LDUR  W2, [X20, #0]
    ADD  X20, X20, X7, ASR #0
    STUR  X29, [X20, #0]
    LDUR  X26, [X20, #0]
    ADD  X20, X20, X7, ASR #0
    STURB  W26, [X20, #0]
    LDURB  W9, [X20, #0]
    ADD  X20, X20, X7, ASR #0
    STURH  W2, [X20, #0]
    LDURH  W26, [X20, #0]
    ADD  X20, X20, X7, LSR #0
    STLR  W17, [X20,#0]
    LDAR  W17, [X20,#0]
    ADD  X20, X20, X7
    STLR  X26, [X20,#0]
    LDAR  X28, [X20,#0]
    ADD  X20, X20, X7
    STLRB  W9, [X20,#0]
    LDARB  W28, [X20,#0]
    ADD  X20, X20, X7
    STLRH  W17, [X20,#0]
    LDARH  W2, [X20,#0]
    ADD  X20, X20, X7, ASR #0
    STNP  W15, W27, [X20, #0]
    LDNP  W9, W15, [X20, #0]
    ADD  X20, X20, X7, ASR #0
    STNP  X10, X15, [X20, #0]
    LDNP  X26, X27, [X20, #0]
    ADD  X20, X20, X7, LSR #0
    STP  W25, W11, [X20], #0
    LDP  W17, W9, [X20], #0
    ADD  X20, X20, X7, ASR #0
    STP  X26, X17, [X20], #0
    LDP  X10, X15, [X20], #0
    ADD  X20, X20, X7, ASR #0
    STP  W29, W9, [X20, #0]!
    LDP  W25, W17, [X20, #0]!
    ADD  X20, X20, X7, ASR #0
    STP  X2, X10, [X20, #0]!
    LDP  X11, X26, [X20, #0]!
    ADD  X20, X20, X7
    STR  W8, [X20], #0
    LDR  W2, [X20], #0
    ADD  X20, X20, X7, ASR #0
    STR  X26, [X20], #0
    LDR  X8, [X20], #0
    ADD  X20, X20, X7, LSR #0
    STR  W28, [X20, #0]!
    LDR  W9, [X20, #0]!
    ADD  X20, X20, X7
    STR  X15, [X20, #0]!
    LDR  X15, [X20, #0]!
    ADD  X20, X20, X7
    STRB  W17, [X20], #0
    LDRB  W23, [X20], #0
    ADD  X20, X20, X7
    STRB  W25, [X20, #0]!
    LDRB  W29, [X20, #0]!
    ADD  X20, X20, X7, ASR #0
    STRH  W11, [X20], #0
    LDRH  W10, [X20], #0
    ADD  X20, X20, X7, LSR #0
    STRH  W29, [X20, #0]!
    LDRH  W28, [X20, #0]!
    ADD  X20, X20, X7
    STP  X9, X28, [X20, #0]
    LDAXP  W11, W25, [X20,#0]
    ADD  X20, X20, X7, ASR #0
    STP  X25, X22, [X20, #0]
    LDAXP  X22, X17, [X20,#0]
    ADD  X20, X20, X7, ASR #0
    STP  X15, X11, [X20, #0]
    LDPSW  X25, X15, [X20], #0
    ADD  X20, X20, X7, LSR #0
    STP  X17, X15, [X20, #0]
    LDPSW  X28, X29, [X20, #0]!
    ADD  X20, X20, X7, LSR #0
    STP  X22, X22, [X20, #0]
    LDAXR  W9, [X20,#0]
    ADD  X20, X20, X7
    STP  X28, X25, [X20, #0]
    LDAXR  X27, [X20,#0]
    ADD  X20, X20, X7, LSR #0
    STP  X23, X9, [X20, #0]
    LDAXRB  W25, [X20,#0]
    ADD  X20, X20, X7, LSR #0
    STP  X29, X25, [X20, #0]
    LDAXRH  W28, [X20,#0]
    ADD  X20, X20, X7, ASR #0
    MOVZ  X5, #0xffa5, LSL #0
    MOVK  X5, #0xffff, LSL #16
    SUB  X24, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X24, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xff, LSL #0
    SUB  X24, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xffff, LSL #0
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5, LSL #0
    SUB  X24, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xffa5, LSL #0
    MOVK  X5, #0xffff, LSL #16
    SUB  X24, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xffa5, LSL #0
    MOVK  X5, #0xffff, LSL #16
    SUB  X24, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5, LSL #0
    SUB  X24, X5, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xffa5, LSL #0
    MOVK  X5, #0xffff, LSL #16
    SUB  X24, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5, LSL #0
    SUB  X24, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5, LSL #0
    SUB  X24, X5, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xff, LSL #0
    SUB  X24, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xffa5, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X24, X5, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
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
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
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
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X4, #0x10, LSL #0
    MOVZ  X27, #0x2800, LSL #0
    ADD  X20, X30, X27, ASR #0
    STP  X28, X26, [X20, #0]
    LDPSW  X16, X25, [X20, #0]
    ADD  X20, X20, X4, LSR #0
    STP  X18, X2, [X20, #0]
    LDRSB  W13, [X20], #0
    ADD  X20, X20, X4, ASR #0
    STP  X29, X13, [X20, #0]
    LDRSB  X5, [X20], #0
    ADD  X20, X20, X4
    STP  X16, X16, [X20, #0]
    LDRSB  W28, [X20, #0]!
    ADD  X20, X20, X4, ASR #0
    STP  X28, X5, [X20, #0]
    LDRSB  X29, [X20, #0]!
    ADD  X20, X20, X4
    STP  X29, X23, [X20, #0]
    LDRSB  W7, [X20, #0]
    ADD  X20, X20, X4, ASR #0
    STP  X28, X26, [X20, #0]
    LDRSB  X26, [X20, #0]
    ADD  X20, X20, X4, ASR #0
    STP  X9, X2, [X20, #0]
    LDRSB W22, [X20, X2, LSL #0]
    ADD  X20, X20, X4
    STP  X28, X22, [X20, #0]
    LDRSB W28, [X20, W2, SXTW #0]
    ADD  X20, X20, X4
    STP  X7, X6, [X20, #0]
    LDRSB W16, [X20, X2, SXTX #0]
    ADD  X20, X20, X4
    STP  X29, X7, [X20, #0]
    LDRSB W22, [X20, W2, UXTW #0]
    ADD  X20, X20, X4
    STP  X17, X28, [X20, #0]
    LDRSB X6, [X20, X2, LSL #0]
    ADD  X20, X20, X4
    STP  X28, X7, [X20, #0]
    LDRSB X9, [X20, W2, SXTW #0]
    ADD  X20, X20, X4
    STP  X13, X2, [X20, #0]
    LDRSB X18, [X20, X2, SXTX #0]
    ADD  X20, X20, X4, LSR #0
    STP  X25, X26, [X20, #0]
    LDRSB X7, [X20, W2, UXTW #0]
    ADD  X20, X20, X4, LSR #0
    STP  X28, X23, [X20, #0]
    LDRSH  W13, [X20], #0
    ADD  X20, X20, X4, LSR #0
    STP  X8, X5, [X20, #0]
    LDRSH  X25, [X20], #0
    ADD  X20, X20, X4, LSR #0
    STP  X13, X7, [X20, #0]
    LDRSH  W26, [X20, #0]!
    ADD  X20, X20, X4, LSR #0
    STP  X25, X18, [X20, #0]
    LDRSH  X8, [X20, #0]!
    ADD  X20, X20, X4, LSR #0
    STP  X26, X26, [X20, #0]
    LDRSH  W16, [X20, #0]
    ADD  X20, X20, X4, ASR #0
    STP  X16, X6, [X20, #0]
    LDRSH  X23, [X20, #0]
    ADD  X20, X20, X4, LSR #0
    STP  X8, X28, [X20, #0]
    LDRSH W8, [X20, X2, LSL #1]
    ADD  X20, X20, X4, ASR #0
    STP  X8, X16, [X20, #0]
    LDRSH W18, [X20, W2, SXTW #1]
    ADD  X20, X20, X4
    STP  X23, X23, [X20, #0]
    LDRSH W8, [X20, X2, SXTX #1]
    ADD  X20, X20, X4, LSR #0
    STP  X23, X16, [X20, #0]
    LDRSH W23, [X20, W2, UXTW #0]
    ADD  X20, X20, X4, ASR #0
    STP  X26, X24, [X20, #0]
    LDRSH X28, [X20, X2, LSL #0]
    ADD  X20, X20, X4
    STP  X6, X25, [X20, #0]
    LDRSH X25, [X20, W2, SXTW #0]
    ADD  X20, X20, X4, ASR #0
    STP  X10, X7, [X20, #0]
    LDRSH X16, [X20, X2, SXTX #0]
    ADD  X20, X20, X4, ASR #0
    STP  X23, X22, [X20, #0]
    LDRSH X26, [X20, W2, UXTW #0]
    ADD  X20, X20, X4, ASR #0
    STP  X25, X6, [X20, #0]
    LDRSW  X25, [X20], #0
    ADD  X20, X20, X4, LSR #0
    STP  X28, X8, [X20, #0]
    LDRSW  X6, [X20, #0]!
    ADD  X20, X20, X4, ASR #0
    STP  X7, X28, [X20, #0]
    LDRSW  X23, [X20, #0]
    ADD  X20, X20, X4, ASR #0
    STP  X16, X18, [X20, #0]
    LDRSW X10, [X20, X2, LSL #2]
    ADD  X20, X20, X4, LSR #0
    STP  X10, X29, [X20, #0]
    LDRSW X10, [X20, W2, SXTW #2]
    ADD  X20, X20, X4, LSR #0
    STP  X16, X29, [X20, #0]
    LDRSW X18, [X20, X2, SXTX #0]
    ADD  X20, X20, X4, ASR #0
    STP  X17, X9, [X20, #0]
    LDRSW X8, [X20, W2, UXTW #2]
    ADD  X20, X20, X4, LSR #0
    STP  X25, X8, [X20, #0]
    LDTRSB  W16, [X20, #0]
    ADD  X20, X20, X4, ASR #0
    STP  X13, X18, [X20, #0]
    LDTRSB  X17, [X20, #0]
    ADD  X20, X20, X4
    STP  X9, X15, [X20, #0]
    LDTRSH  W13, [X20, #0]
    ADD  X20, X20, X4, LSR #0
    STP  X17, X18, [X20, #0]
    LDTRSH  X17, [X20, #0]
    ADD  X20, X20, X4
    STP  X22, X8, [X20, #0]
    LDTRSW  X8, [X20, #0]
    ADD  X20, X20, X4
    STP  X18, X2, [X20, #0]
    LDURSB  W15, [X20, #0]
    ADD  X20, X20, X4, LSR #0
    STP  X23, X28, [X20, #0]
    LDURSB  X18, [X20, #0]
    ADD  X20, X20, X4
    STP  X13, X24, [X20, #0]
    LDURSH  W23, [X20, #0]
    ADD  X20, X20, X4
    STP  X26, X2, [X20, #0]
    LDURSH  X22, [X20, #0]
    ADD  X20, X20, X4, LSR #0
    STP  X10, X6, [X20, #0]
    LDURSW  X28, [X20, #0]
    ADD  X20, X20, X4
    STP  X8, X22, [X20, #0]
    LDXP  W10, W9, [X20,#0]
    ADD  X20, X20, X4, LSR #0
    STP  X18, X23, [X20, #0]
    LDXP  X13, X6, [X20,#0]
    ADD  X20, X20, X4, LSR #0
    STP  X17, X9, [X20, #0]
    LDXR  W8, [X20,#0]
    ADD  X20, X20, X4, ASR #0
    STP  X6, X10, [X20, #0]
    LDXR  X23, [X20,#0]
    ADD  X20, X20, X4, LSR #0
    STP  X28, X28, [X20, #0]
    LDXRB  W26, [X20,#0]
    ADD  X20, X20, X4, ASR #0
    STP  X23, X15, [X20, #0]
    LDXRH  W22, [X20,#0]
    ADD  X20, X20, X4, ASR #0
    STRB  W26, [X20, #0]
    LDRB  W28, [X20, #0]
    ADD  X20, X20, X4
    STRB W22, [X20, X2, LSL #0]
    LDRB W6, [X20, X9, LSL #0]
    ADD  X20, X20, X4, LSR #0
    STRB W8, [X20, W2, SXTW #0]
    LDRB W18, [X20, W9, SXTW #0]
    ADD  X20, X20, X4, LSR #0
    STRB W28, [X20, X2, SXTX #0]
    LDRB W28, [X20, X2, SXTX #0]
    ADD  X20, X20, X4
    STRB W13, [X20, W2, UXTW #0]
    LDRB W26, [X20, W2, UXTW #0]
    ADD  X20, X20, X4, ASR #0
    STRH  W18, [X20, #0]
    LDRH  W13, [X20, #0]
    ADD  X20, X20, X4
    STRH W28, [X20, X9, LSL #1]
    LDRH W8, [X20, X9, LSL #1]
    ADD  X20, X20, X4, LSR #0
    STRH W6, [X20, W2, SXTW #1]
    LDRH W6, [X20, W9, SXTW #0]
    ADD  X20, X20, X4, ASR #0
    STRH W26, [X20, X2, SXTX #0]
    LDRH W9, [X20, X2, SXTX #0]
    ADD  X20, X20, X4
    STRH W8, [X20, W2, UXTW #0]
    LDRH W8, [X20, W2, UXTW #1]
    ADD  X20, X20, X4, ASR #0
    STR  W6, [X20, #0]
    LDR  W28, [X20, #0]
    ADD  X20, X20, X4
    STR  X9, [X20, #0]
    LDR  X6, [X20, #0]
    ADD  X20, X20, X4, LSR #0
    STR W13, [X20, X2, LSL #2]
    LDR W9, [X20, X2, LSL #2]
    ADD  X20, X20, X4, ASR #0
    STR W28, [X20, W2, SXTW #0]
    LDR W13, [X20, W2, SXTW #0]
    ADD  X20, X20, X4
    STR W6, [X20, X2, SXTX #2]
    LDR W6, [X20, X2, SXTX #2]
    ADD  X20, X20, X4
    STR W7, [X20, W2, UXTW #0]
    LDR W7, [X20, W2, UXTW #2]
    ADD  X20, X20, X4, ASR #0
    STR X23, [X20, X2, LSL #3]
    LDR X26, [X20, X2, LSL #3]
    ADD  X20, X20, X4
    STR X13, [X20, W2, SXTW #3]
    LDR X28, [X20, W2, SXTW #0]
    ADD  X20, X20, X4, LSR #0
    STR X6, [X20, X2, SXTX #0]
    LDR X23, [X20, X2, SXTX #3]
    ADD  X20, X20, X4, LSR #0
    STR X8, [X20, W2, UXTW #3]
    LDR X13, [X20, W2, UXTW #3]
    ADD  X20, X20, X4, LSR #0
    STP  W7, W28, [X20, #0]
    LDP  W8, W28, [X20, #0]
    ADD  X20, X20, X4, LSR #0
    STP  X6, X8, [X20, #0]
    LDP  X6, X7, [X20, #0]
    ADD  X20, X20, X4
    STTR  W13, [X20, #0]
    LDTR  W26, [X20, #0]
    ADD  X20, X20, X4
    STTR  X22, [X20, #0]
    LDTR  X22, [X20, #0]
    ADD  X20, X20, X4, ASR #0
    STTRB  W28, [X20, #0]
    LDTRB  W13, [X20, #0]
    ADD  X20, X20, X4, ASR #0
    STTRH  W13, [X20, #0]
    LDTRH  W8, [X20, #0]
    ADD  X20, X20, X4, LSR #0
    STUR  W8, [X20, #0]
    LDUR  W8, [X20, #0]
    ADD  X20, X20, X4, LSR #0
    STUR  X6, [X20, #0]
    LDUR  X10, [X20, #0]
    ADD  X20, X20, X4
    STURB  W10, [X20, #0]
    LDURB  W9, [X20, #0]
    ADD  X20, X20, X4, ASR #0
    STURH  W22, [X20, #0]
    LDURH  W28, [X20, #0]
    ADD  X20, X20, X4, LSR #0
    STLR  W9, [X20,#0]
    LDAR  W13, [X20,#0]
    ADD  X20, X20, X4, LSR #0
    STLR  X26, [X20,#0]
    LDAR  X26, [X20,#0]
    ADD  X20, X20, X4, ASR #0
    STLRB  W13, [X20,#0]
    LDARB  W9, [X20,#0]
    ADD  X20, X20, X4, ASR #0
    STLRH  W28, [X20,#0]
    LDARH  W29, [X20,#0]
    ADD  X20, X20, X4
    STNP  W8, W26, [X20, #0]
    LDNP  W22, W28, [X20, #0]
    ADD  X20, X20, X4
    STNP  X9, X29, [X20, #0]
    LDNP  X26, X13, [X20, #0]
    ADD  X20, X20, X4, LSR #0
    STP  W28, W22, [X20], #0
    LDP  W8, W6, [X20], #0
    ADD  X20, X20, X4
    STP  X26, X10, [X20], #0
    LDP  X10, X22, [X20], #0
    ADD  X20, X20, X4, ASR #0
    STP  W22, W13, [X20, #0]!
    LDP  W18, W29, [X20, #0]!
    ADD  X20, X20, X4, LSR #0
    STP  X29, X10, [X20, #0]!
    LDP  X22, X10, [X20, #0]!
    ADD  X20, X20, X4, LSR #0
    STR  W25, [X20], #0
    LDR  W26, [X20], #0
    ADD  X20, X20, X4, LSR #0
    STR  X10, [X20], #0
    LDR  X9, [X20], #0
    ADD  X20, X20, X4
    STR  W18, [X20, #0]!
    LDR  W29, [X20, #0]!
    ADD  X20, X20, X4, ASR #0
    STR  X9, [X20, #0]!
    LDR  X25, [X20, #0]!
    ADD  X20, X20, X4
    STRB  W22, [X20], #0
    LDRB  W28, [X20], #0
    ADD  X20, X20, X4, LSR #0
    STRB  W26, [X20, #0]!
    LDRB  W10, [X20, #0]!
    ADD  X20, X20, X4
    STRH  W29, [X20], #0
    LDRH  W22, [X20], #0
    ADD  X20, X20, X4
    STRH  W17, [X20, #0]!
    LDRH  W18, [X20, #0]!
    ADD  X20, X20, X4, ASR #0
    STP  X10, X18, [X20, #0]
    LDAXP  W18, W29, [X20,#0]
    ADD  X20, X20, X4, LSR #0
    STP  X29, X25, [X20, #0]
    LDAXP  X10, X17, [X20,#0]
    ADD  X20, X20, X4, ASR #0
    STP  X28, X25, [X20, #0]
    LDPSW  X26, X25, [X20], #0
    ADD  X20, X20, X4, ASR #0
    STP  X26, X22, [X20, #0]
    LDPSW  X22, X26, [X20, #0]!
    ADD  X20, X20, X4, ASR #0
    STP  X23, X25, [X20, #0]
    LDAXR  W29, [X20,#0]
    ADD  X20, X20, X4
    STP  X17, X29, [X20, #0]
    LDAXR  X23, [X20,#0]
    ADD  X20, X20, X4, LSR #0
    STP  X18, X7, [X20, #0]
    LDAXRB  W28, [X20,#0]
    ADD  X20, X20, X4, ASR #0
    STP  X10, X23, [X20, #0]
    LDAXRH  W25, [X20,#0]
    ADD  X20, X20, X4, ASR #0
    MOVZ  X21, #0x5a, LSL #0
    SUB  X11, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X11, X21, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X11, X21, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X11, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X11, X21, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X11, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X11, X21, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X11, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X11, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X11, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X11, X21, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X11, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X11, X21, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X11, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X11, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
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
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
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
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X23, #0x10, LSL #0
    MOVZ  X2, #0x2d00, LSL #0
    ADD  X8, X30, X2, LSR #0
    STP  X24, X28, [X8, #0]
    LDPSW  X26, X21, [X8, #0]
    ADD  X8, X8, X23, ASR #0
    STP  X21, X21, [X8, #0]
    LDRSB  W25, [X8], #0
    ADD  X8, X8, X23, LSR #0
    STP  X11, X11, [X8, #0]
    LDRSB  X18, [X8], #0
    ADD  X8, X8, X23, LSR #0
    STP  X25, X26, [X8, #0]
    LDRSB  W16, [X8, #0]!
    ADD  X8, X8, X23, ASR #0
    STP  X27, X18, [X8, #0]
    LDRSB  X25, [X8, #0]!
    ADD  X8, X8, X23
    STP  X16, X6, [X8, #0]
    LDRSB  W7, [X8, #0]
    ADD  X8, X8, X23
    STP  X7, X25, [X8, #0]
    LDRSB  X21, [X8, #0]
    ADD  X8, X8, X23
    STP  X27, X9, [X8, #0]
    LDRSB W25, [X8, X11, LSL #0]
    ADD  X8, X8, X23
    STP  X26, X5, [X8, #0]
    LDRSB W26, [X8, W18, SXTW #0]
    ADD  X8, X8, X23, ASR #0
    STP  X4, X22, [X8, #0]
    LDRSB W7, [X8, X18, SXTX #0]
    ADD  X8, X8, X23, ASR #0
    STP  X26, X24, [X8, #0]
    LDRSB W6, [X8, W18, UXTW #0]
    ADD  X8, X8, X23
    STP  X26, X27, [X8, #0]
    LDRSB X5, [X8, X11, LSL #0]
    ADD  X8, X8, X23, LSR #0
    STP  X16, X7, [X8, #0]
    LDRSB X25, [X8, W18, SXTW #0]
    ADD  X8, X8, X23, LSR #0
    STP  X13, X26, [X8, #0]
    LDRSB X27, [X8, X11, SXTX #0]
    ADD  X8, X8, X23, ASR #0
    STP  X16, X7, [X8, #0]
    LDRSB X7, [X8, W18, UXTW #0]
    ADD  X8, X8, X23, LSR #0
    STP  X26, X18, [X8, #0]
    LDRSH  W24, [X8], #0
    ADD  X8, X8, X23
    STP  X4, X27, [X8, #0]
    LDRSH  X18, [X8], #0
    ADD  X8, X8, X23, LSR #0
    STP  X24, X6, [X8, #0]
    LDRSH  W27, [X8, #0]!
    ADD  X8, X8, X23, LSR #0
    STP  X16, X28, [X8, #0]
    LDRSH  X28, [X8, #0]!
    ADD  X8, X8, X23, LSR #0
    STP  X11, X20, [X8, #0]
    LDRSH  W26, [X8, #0]
    ADD  X8, X8, X23
    STP  X13, X9, [X8, #0]
    LDRSH  X9, [X8, #0]
    ADD  X8, X8, X23
    STP  X26, X26, [X8, #0]
    LDRSH W13, [X8, X26, LSL #0]
    ADD  X8, X8, X23
    STP  X28, X13, [X8, #0]
    LDRSH W4, [X8, W13, SXTW #1]
    ADD  X8, X8, X23, LSR #0
    STP  X27, X4, [X8, #0]
    LDRSH W16, [X8, X26, SXTX #0]
    ADD  X8, X8, X23, ASR #0
    STP  X9, X9, [X8, #0]
    LDRSH W26, [X8, W13, UXTW #1]
    ADD  X8, X8, X23, ASR #0
    STP  X16, X18, [X8, #0]
    LDRSH X28, [X8, X13, LSL #0]
    ADD  X8, X8, X23, ASR #0
    STP  X25, X18, [X8, #0]
    LDRSH X4, [X8, W11, SXTW #1]
    ADD  X8, X8, X23
    STP  X7, X24, [X8, #0]
    LDRSH X27, [X8, X11, SXTX #0]
    ADD  X8, X8, X23, LSR #0
    STP  X28, X26, [X8, #0]
    LDRSH X20, [X8, W13, UXTW #0]
    ADD  X8, X8, X23, LSR #0
    STP  X24, X13, [X8, #0]
    LDRSW  X16, [X8], #0
    ADD  X8, X8, X23, LSR #0
    STP  X16, X13, [X8, #0]
    LDRSW  X13, [X8, #0]!
    ADD  X8, X8, X23, LSR #0
    STP  X5, X4, [X8, #0]
    LDRSW  X9, [X8, #0]
    ADD  X8, X8, X23
    STP  X11, X6, [X8, #0]
    LDRSW X25, [X8, X11, LSL #0]
    ADD  X8, X8, X23, ASR #0
    STP  X7, X4, [X8, #0]
    LDRSW X26, [X8, W11, SXTW #0]
    ADD  X8, X8, X23, ASR #0
    STP  X25, X5, [X8, #0]
    LDRSW X24, [X8, X11, SXTX #0]
    ADD  X8, X8, X23
    STP  X10, X13, [X8, #0]
    LDRSW X7, [X8, W24, UXTW #0]
    ADD  X8, X8, X23, ASR #0
    STP  X16, X15, [X8, #0]
    LDTRSB  W28, [X8, #0]
    ADD  X8, X8, X23, LSR #0
    STP  X7, X25, [X8, #0]
    LDTRSB  X13, [X8, #0]
    ADD  X8, X8, X23
    STP  X5, X22, [X8, #0]
    LDTRSH  W24, [X8, #0]
    ADD  X8, X8, X23
    STP  X28, X27, [X8, #0]
    LDTRSH  X6, [X8, #0]
    ADD  X8, X8, X23, LSR #0
    STP  X25, X18, [X8, #0]
    LDTRSW  X22, [X8, #0]
    ADD  X8, X8, X23
    STP  X9, X9, [X8, #0]
    LDURSB  W18, [X8, #0]
    ADD  X8, X8, X23, LSR #0
    STP  X25, X28, [X8, #0]
    LDURSB  X15, [X8, #0]
    ADD  X8, X8, X23, ASR #0
    STP  X16, X11, [X8, #0]
    LDURSH  W10, [X8, #0]
    ADD  X8, X8, X23, ASR #0
    STP  X13, X15, [X8, #0]
    LDURSH  X25, [X8, #0]
    ADD  X8, X8, X23, LSR #0
    STP  X10, X24, [X8, #0]
    LDURSW  X9, [X8, #0]
    ADD  X8, X8, X23, LSR #0
    STP  X25, X25, [X8, #0]
    LDXP  W28, W7, [X8,#0]
    ADD  X8, X8, X23
    STP  X28, X18, [X8, #0]
    LDXP  X16, X15, [X8,#0]
    ADD  X8, X8, X23
    STP  X7, X9, [X8, #0]
    LDXR  W18, [X8,#0]
    ADD  X8, X8, X23, LSR #0
    STP  X16, X16, [X8, #0]
    LDXR  X28, [X8,#0]
    ADD  X8, X8, X23, LSR #0
    STP  X18, X15, [X8, #0]
    LDXRB  W16, [X8,#0]
    ADD  X8, X8, X23, LSR #0
    STP  X28, X28, [X8, #0]
    LDXRH  W18, [X8,#0]
    ADD  X8, X8, X23
    STRB  W9, [X8, #0]
    LDRB  W7, [X8, #0]
    ADD  X8, X8, X23, LSR #0
    STRB W5, [X8, X11, LSL #0]
    LDRB W5, [X8, X11, LSL #0]
    ADD  X8, X8, X23, ASR #0
    STRB W21, [X8, W11, SXTW #0]
    LDRB W21, [X8, W11, SXTW #0]
    ADD  X8, X8, X23, ASR #0
    STRB W11, [X8, X22, SXTX #0]
    LDRB W22, [X8, X11, SXTX #0]
    ADD  X8, X8, X23, ASR #0
    STRB W28, [X8, W11, UXTW #0]
    LDRB W9, [X8, W22, UXTW #0]
    ADD  X8, X8, X23
    STRH  W20, [X8, #0]
    LDRH  W20, [X8, #0]
    ADD  X8, X8, X23, LSR #0
    STRH W28, [X8, X11, LSL #1]
    LDRH W22, [X8, X22, LSL #0]
    ADD  X8, X8, X23
    STRH W20, [X8, W11, SXTW #1]
    LDRH W20, [X8, W11, SXTW #1]
    ADD  X8, X8, X23
    STRH W21, [X8, X11, SXTX #0]
    LDRH W28, [X8, X11, SXTX #1]
    ADD  X8, X8, X23, LSR #0
    STRH W18, [X8, W11, UXTW #0]
    LDRH W18, [X8, W11, UXTW #1]
    ADD  X8, X8, X23, LSR #0
    STR  W22, [X8, #0]
    LDR  W22, [X8, #0]
    ADD  X8, X8, X23, LSR #0
    STR  X18, [X8, #0]
    LDR  X18, [X8, #0]
    ADD  X8, X8, X23, ASR #0
    STR W28, [X8, X11, LSL #2]
    LDR W28, [X8, X11, LSL #0]
    ADD  X8, X8, X23
    STR W20, [X8, W11, SXTW #2]
    LDR W20, [X8, W11, SXTW #2]
    ADD  X8, X8, X23, ASR #0
    STR W22, [X8, X11, SXTX #2]
    LDR W25, [X8, X11, SXTX #2]
    ADD  X8, X8, X23
    STR W16, [X8, W11, UXTW #0]
    LDR W22, [X8, W11, UXTW #0]
    ADD  X8, X8, X23, LSR #0
    STR X18, [X8, X11, LSL #3]
    LDR X16, [X8, X11, LSL #0]
    ADD  X8, X8, X23, LSR #0
    STR X28, [X8, W11, SXTW #3]
    LDR X18, [X8, W11, SXTW #0]
    ADD  X8, X8, X23, LSR #0
    STR X16, [X8, X11, SXTX #3]
    LDR X28, [X8, X11, SXTX #3]
    ADD  X8, X8, X23
    STR X5, [X8, W11, UXTW #3]
    LDR X16, [X8, W11, UXTW #3]
    ADD  X8, X8, X23
    STP  W22, W20, [X8, #0]
    LDP  W20, W6, [X8, #0]
    ADD  X8, X8, X23, LSR #0
    STP  X20, X28, [X8, #0]
    LDP  X5, X28, [X8, #0]
    ADD  X8, X8, X23, ASR #0
    STTR  W18, [X8, #0]
    LDTR  W22, [X8, #0]
    ADD  X8, X8, X23, LSR #0
    STTR  X10, [X8, #0]
    LDTR  X18, [X8, #0]
    ADD  X8, X8, X23
    STTRB  W25, [X8, #0]
    LDTRB  W20, [X8, #0]
    ADD  X8, X8, X23
    STTRH  W28, [X8, #0]
    LDTRH  W10, [X8, #0]
    ADD  X8, X8, X23, ASR #0
    STUR  W18, [X8, #0]
    LDUR  W25, [X8, #0]
    ADD  X8, X8, X23
    STUR  X20, [X8, #0]
    LDUR  X18, [X8, #0]
    ADD  X8, X8, X23, ASR #0
    STURB  W22, [X8, #0]
    LDURB  W22, [X8, #0]
    ADD  X8, X8, X23, ASR #0
    STURH  W6, [X8, #0]
    LDURH  W28, [X8, #0]
    ADD  X8, X8, X23, LSR #0
    STLR  W10, [X8,#0]
    LDAR  W10, [X8,#0]
    ADD  X8, X8, X23, LSR #0
    STLR  X22, [X8,#0]
    LDAR  X22, [X8,#0]
    ADD  X8, X8, X23, ASR #0
    STLRB  W28, [X8,#0]
    LDARB  W6, [X8,#0]
    ADD  X8, X8, X23, LSR #0
    STLRH  W6, [X8,#0]
    LDARH  W20, [X8,#0]
    ADD  X8, X8, X23
    STNP  W22, W22, [X8, #0]
    LDNP  W28, W22, [X8, #0]
    ADD  X8, X8, X23
    STNP  X10, X25, [X8, #0]
    LDNP  X25, X10, [X8, #0]
    ADD  X8, X8, X23, LSR #0
    STP  W20, W25, [X8], #0
    LDP  W18, W24, [X8], #0
    ADD  X8, X8, X23, LSR #0
    STP  X28, X28, [X8], #0
    LDP  X5, X26, [X8], #0
    ADD  X8, X8, X23, LSR #0
    STP  W22, W18, [X8, #0]!
    LDP  W21, W16, [X8, #0]!
    ADD  X8, X8, X23, LSR #0
    STP  X16, X10, [X8, #0]!
    LDP  X6, X10, [X8, #0]!
    ADD  X8, X8, X23, ASR #0
    STR  W26, [X8], #0
    LDR  W21, [X8], #0
    ADD  X8, X8, X23, LSR #0
    STR  X27, [X8], #0
    LDR  X4, [X8], #0
    ADD  X8, X8, X23
    STR  W4, [X8, #0]!
    LDR  W24, [X8, #0]!
    ADD  X8, X8, X23, ASR #0
    STR  X21, [X8, #0]!
    LDR  X16, [X8, #0]!
    ADD  X8, X8, X23, ASR #0
    STRB  W24, [X8], #0
    LDRB  W18, [X8], #0
    ADD  X8, X8, X23, LSR #0
    STRB  W6, [X8, #0]!
    LDRB  W20, [X8, #0]!
    ADD  X8, X8, X23, LSR #0
    STRH  W10, [X8], #0
    LDRH  W6, [X8], #0
    ADD  X8, X8, X23, ASR #0
    STRH  W18, [X8, #0]!
    LDRH  W7, [X8, #0]!
    ADD  X8, X8, X23, ASR #0
    STP  X11, X7, [X8, #0]
    LDAXP  W4, W7, [X8,#0]
    ADD  X8, X8, X23, LSR #0
    STP  X4, X4, [X8, #0]
    LDAXP  X10, X24, [X8,#0]
    ADD  X8, X8, X23
    STP  X27, X6, [X8, #0]
    LDPSW  X7, X26, [X8], #0
    ADD  X8, X8, X23, LSR #0
    STP  X26, X26, [X8, #0]
    LDPSW  X22, X21, [X8, #0]!
    ADD  X8, X8, X23, LSR #0
    STP  X7, X22, [X8, #0]
    LDAXR  W4, [X8,#0]
    ADD  X8, X8, X23, LSR #0
    STP  X4, X24, [X8, #0]
    LDAXR  X16, [X8,#0]
    ADD  X8, X8, X23, ASR #0
    STP  X10, X21, [X8, #0]
    LDAXRB  W22, [X8,#0]
    ADD  X8, X8, X23
    STP  X16, X22, [X8, #0]
    LDAXRH  W18, [X8,#0]
    ADD  X8, X8, X23, ASR #0
    MOVZ  X17, #0xffa5, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X29, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X17, #0xa5, LSL #0
    SUB  X29, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X17, #0xffa5, LSL #0
    SUB  X29, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X17, #0xffa5, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X29, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X17, #0xa5, LSL #0
    SUB  X29, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X17, #0xffa5, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X29, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X17, #0xffa5, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X29, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X17, #0xffa5, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X29, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X17, #0xffa5, LSL #0
    SUB  X29, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X17, #0xa5, LSL #0
    SUB  X29, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X29, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X17, #0xffa5, LSL #0
    SUB  X29, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X29, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X17, #0xffa5, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X29, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X17, #0xa5, LSL #0
    SUB  X29, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
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
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
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
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X18, #0x10, LSL #0
    MOVZ  X17, #0x0, LSL #0
    ADD  X24, X30, X17, LSR #0
    STP  X29, X29, [X24, #0]
    LDPSW  X22, X16, [X24, #0]
    ADD  X24, X24, X18, LSR #0
    STP  X16, X28, [X24, #0]
    LDRSB  W4, [X24], #0
    ADD  X24, X24, X18, LSR #0
    STP  X11, X25, [X24, #0]
    LDRSB  X20, [X24], #0
    ADD  X24, X24, X18, LSR #0
    STP  X4, X20, [X24, #0]
    LDRSB  W6, [X24, #0]!
    ADD  X24, X24, X18
    STP  X22, X22, [X24, #0]
    LDRSB  X4, [X24, #0]!
    ADD  X24, X24, X18, LSR #0
    STP  X20, X26, [X24, #0]
    LDRSB  W11, [X24, #0]
    ADD  X24, X24, X18
    STP  X13, X4, [X24, #0]
    LDRSB  X6, [X24, #0]
    ADD  X24, X24, X18
    STP  X13, X11, [X24, #0]
    LDRSB W13, [X24, X26, LSL #0]
    ADD  X24, X24, X18, LSR #0
    STP  X25, X28, [X24, #0]
    LDRSB W6, [X24, W26, SXTW #0]
    ADD  X24, X24, X18
    STP  X16, X20, [X24, #0]
    LDRSB W29, [X24, X26, SXTX #0]
    ADD  X24, X24, X18, LSR #0
    STP  X25, X23, [X24, #0]
    LDRSB W16, [X24, W26, UXTW #0]
    ADD  X24, X24, X18, ASR #0
    STP  X23, X20, [X24, #0]
    LDRSB X5, [X24, X26, LSL #0]
    ADD  X24, X24, X18, LSR #0
    STP  X5, X29, [X24, #0]
    LDRSB X16, [X24, W26, SXTW #0]
    ADD  X24, X24, X18, LSR #0
    STP  X7, X23, [X24, #0]
    LDRSB X15, [X24, X26, SXTX #0]
    ADD  X24, X24, X18
    STP  X15, X23, [X24, #0]
    LDRSB X4, [X24, W26, UXTW #0]
    ADD  X24, X24, X18, ASR #0
    STP  X5, X2, [X24, #0]
    LDRSH  W28, [X24], #0
    ADD  X24, X24, X18, LSR #0
    STP  X4, X4, [X24, #0]
    LDRSH  X2, [X24], #0
    ADD  X24, X24, X18
    STP  X4, X23, [X24, #0]
    LDRSH  W29, [X24, #0]!
    ADD  X24, X24, X18, LSR #0
    STP  X26, X16, [X24, #0]
    LDRSH  X20, [X24, #0]!
    ADD  X24, X24, X18
    STP  X26, X2, [X24, #0]
    LDRSH  W5, [X24, #0]
    ADD  X24, X24, X18, LSR #0
    STP  X11, X26, [X24, #0]
    LDRSH  X4, [X24, #0]
    ADD  X24, X24, X18
    STP  X13, X28, [X24, #0]
    LDRSH W29, [X24, X20, LSL #1]
    ADD  X24, X24, X18, LSR #0
    STP  X11, X22, [X24, #0]
    LDRSH W9, [X24, W26, SXTW #1]
    ADD  X24, X24, X18, LSR #0
    STP  X25, X15, [X24, #0]
    LDRSH W28, [X24, X5, SXTX #0]
    ADD  X24, X24, X18, LSR #0
    STP  X11, X2, [X24, #0]
    LDRSH W15, [X24, W26, UXTW #0]
    ADD  X24, X24, X18, ASR #0
    STP  X5, X16, [X24, #0]
    LDRSH X4, [X24, X5, LSL #0]
    ADD  X24, X24, X18, ASR #0
    STP  X25, X16, [X24, #0]
    LDRSH X16, [X24, W20, SXTW #1]
    ADD  X24, X24, X18
    STP  X25, X7, [X24, #0]
    LDRSH X16, [X24, X20, SXTX #1]
    ADD  X24, X24, X18, LSR #0
    STP  X16, X22, [X24, #0]
    LDRSH X9, [X24, W4, UXTW #1]
    ADD  X24, X24, X18, LSR #0
    STP  X29, X11, [X24, #0]
    LDRSW  X28, [X24], #0
    ADD  X24, X24, X18
    STP  X25, X21, [X24, #0]
    LDRSW  X4, [X24, #0]!
    ADD  X24, X24, X18, ASR #0
    STP  X7, X20, [X24, #0]
    LDRSW  X25, [X24, #0]
    ADD  X24, X24, X18, LSR #0
    STP  X4, X16, [X24, #0]
    LDRSW X21, [X24, X20, LSL #2]
    ADD  X24, X24, X18
    STP  X2, X11, [X24, #0]
    LDRSW X29, [X24, W5, SXTW #2]
    ADD  X24, X24, X18, LSR #0
    STP  X28, X26, [X24, #0]
    LDRSW X5, [X24, X20, SXTX #2]
    ADD  X24, X24, X18, ASR #0
    STP  X11, X4, [X24, #0]
    LDRSW X28, [X24, W20, UXTW #0]
    ADD  X24, X24, X18, LSR #0
    STP  X20, X28, [X24, #0]
    LDTRSB  W2, [X24, #0]
    ADD  X24, X24, X18, LSR #0
    STP  X4, X25, [X24, #0]
    LDTRSB  X16, [X24, #0]
    ADD  X24, X24, X18, ASR #0
    STP  X22, X22, [X24, #0]
    LDTRSH  W4, [X24, #0]
    ADD  X24, X24, X18, LSR #0
    STP  X23, X25, [X24, #0]
    LDTRSH  X13, [X24, #0]
    ADD  X24, X24, X18, ASR #0
    STP  X20, X13, [X24, #0]
    LDTRSW  X28, [X24, #0]
    ADD  X24, X24, X18, LSR #0
    STP  X13, X4, [X24, #0]
    LDURSB  W11, [X24, #0]
    ADD  X24, X24, X18, LSR #0
    STP  X7, X11, [X24, #0]
    LDURSB  X11, [X24, #0]
    ADD  X24, X24, X18, ASR #0
    STP  X4, X7, [X24, #0]
    LDURSH  W4, [X24, #0]
    ADD  X24, X24, X18
    STP  X13, X11, [X24, #0]
    LDURSH  X23, [X24, #0]
    ADD  X24, X24, X18, LSR #0
    STP  X22, X16, [X24, #0]
    LDURSW  X20, [X24, #0]
    ADD  X24, X24, X18, LSR #0
    STP  X26, X10, [X24, #0]
    LDXP  W22, W13, [X24,#0]
    ADD  X24, X24, X18, LSR #0
    STP  X10, X11, [X24, #0]
    LDXP  X11, X7, [X24,#0]
    ADD  X24, X24, X18
    STP  X22, X11, [X24, #0]
    LDXR  W11, [X24,#0]
    ADD  X24, X24, X18
    STP  X13, X23, [X24, #0]
    LDXR  X23, [X24,#0]
    ADD  X24, X24, X18
    STP  X11, X7, [X24, #0]
    LDXRB  W13, [X24,#0]
    ADD  X24, X24, X18, ASR #0
    STP  X20, X23, [X24, #0]
    LDXRH  W7, [X24,#0]
    ADD  X24, X24, X18, ASR #0
    STRB  W13, [X24, #0]
    LDRB  W11, [X24, #0]
    ADD  X24, X24, X18
    STRB W11, [X24, X23, LSL #0]
    LDRB W16, [X24, X26, LSL #0]
    ADD  X24, X24, X18, ASR #0
    STRB W7, [X24, W16, SXTW #0]
    LDRB W13, [X24, W2, SXTW #0]
    ADD  X24, X24, X18, LSR #0
    STRB W21, [X24, X26, SXTX #0]
    LDRB W7, [X24, X11, SXTX #0]
    ADD  X24, X24, X18, LSR #0
    STRB W11, [X24, W16, UXTW #0]
    LDRB W10, [X24, W22, UXTW #0]
    ADD  X24, X24, X18, ASR #0
    STRH  W16, [X24, #0]
    LDRH  W2, [X24, #0]
    ADD  X24, X24, X18, ASR #0
    STRH W9, [X24, X16, LSL #1]
    LDRH W20, [X24, X28, LSL #1]
    ADD  X24, X24, X18, LSR #0
    STRH W25, [X24, W22, SXTW #1]
    LDRH W16, [X24, W10, SXTW #0]
    ADD  X24, X24, X18
    STRH W10, [X24, X22, SXTX #1]
    LDRH W21, [X24, X2, SXTX #0]
    ADD  X24, X24, X18, LSR #0
    STRH W9, [X24, W11, UXTW #1]
    LDRH W2, [X24, W23, UXTW #1]
    ADD  X24, X24, X18
    STR  W2, [X24, #0]
    LDR  W2, [X24, #0]
    ADD  X24, X24, X18, LSR #0
    STR  X21, [X24, #0]
    LDR  X28, [X24, #0]
    ADD  X24, X24, X18, LSR #0
    STR W13, [X24, X26, LSL #2]
    LDR W21, [X24, X22, LSL #0]
    ADD  X24, X24, X18, LSR #0
    STR W9, [X24, W23, SXTW #0]
    LDR W13, [X24, W28, SXTW #0]
    ADD  X24, X24, X18
    STR W23, [X24, X23, SXTX #0]
    LDR W25, [X24, X26, SXTX #0]
    ADD  X24, X24, X18
    STR W21, [X24, W10, UXTW #2]
    LDR W11, [X24, W11, UXTW #0]
    ADD  X24, X24, X18
    STR X26, [X24, X23, LSL #3]
    LDR X10, [X24, X22, LSL #0]
    ADD  X24, X24, X18
    STR X13, [X24, W25, SXTW #0]
    LDR X21, [X24, W26, SXTW #0]
    ADD  X24, X24, X18, LSR #0
    STR X21, [X24, X26, SXTX #0]
    LDR X25, [X24, X10, SXTX #0]
    ADD  X24, X24, X18, LSR #0
    STR X2, [X24, W26, UXTW #3]
    LDR X2, [X24, W28, UXTW #0]
    ADD  X24, X24, X18, ASR #0
    STP  W29, W25, [X24, #0]
    LDP  W22, W29, [X24, #0]
    ADD  X24, X24, X18, ASR #0
    STP  X10, X9, [X24, #0]
    LDP  X21, X25, [X24, #0]
    ADD  X24, X24, X18, LSR #0
    STTR  W29, [X24, #0]
    LDTR  W22, [X24, #0]
    ADD  X24, X24, X18, ASR #0
    STTR  X15, [X24, #0]
    LDTR  X28, [X24, #0]
    ADD  X24, X24, X18
    STTRB  W20, [X24, #0]
    LDTRB  W13, [X24, #0]
    ADD  X24, X24, X18, ASR #0
    STTRH  W21, [X24, #0]
    LDTRH  W20, [X24, #0]
    ADD  X24, X24, X18, LSR #0
    STUR  W6, [X24, #0]
    LDUR  W6, [X24, #0]
    ADD  X24, X24, X18
    STUR  X2, [X24, #0]
    LDUR  X15, [X24, #0]
    ADD  X24, X24, X18
    STURB  W13, [X24, #0]
    LDURB  W29, [X24, #0]
    ADD  X24, X24, X18, LSR #0
    STURH  W20, [X24, #0]
    LDURH  W21, [X24, #0]
    ADD  X24, X24, X18, ASR #0
    STLR  W23, [X24,#0]
    LDAR  W23, [X24,#0]
    ADD  X24, X24, X18, ASR #0
    STLR  X25, [X24,#0]
    LDAR  X20, [X24,#0]
    ADD  X24, X24, X18
    STLRB  W29, [X24,#0]
    LDARB  W2, [X24,#0]
    ADD  X24, X24, X18, ASR #0
    STLRH  W23, [X24,#0]
    LDARH  W25, [X24,#0]
    ADD  X24, X24, X18, ASR #0
    STNP  W6, W20, [X24, #0]
    LDNP  W13, W20, [X24, #0]
    ADD  X24, X24, X18, LSR #0
    STNP  X15, X2, [X24, #0]
    LDNP  X23, X2, [X24, #0]
    ADD  X24, X24, X18
    STP  W13, W21, [X24], #0
    LDP  W29, W15, [X24], #0
    ADD  X24, X24, X18, ASR #0
    STP  X23, X20, [X24], #0
    LDP  X13, X23, [X24], #0
    ADD  X24, X24, X18
    STP  W2, W13, [X24, #0]!
    LDP  W21, W6, [X24, #0]!
    ADD  X24, X24, X18
    STP  X15, X21, [X24, #0]!
    LDP  X13, X20, [X24, #0]!
    ADD  X24, X24, X18, ASR #0
    STR  W29, [X24], #0
    LDR  W13, [X24], #0
    ADD  X24, X24, X18, LSR #0
    STR  X23, [X24], #0
    LDR  X21, [X24], #0
    ADD  X24, X24, X18, ASR #0
    STR  W20, [X24, #0]!
    LDR  W20, [X24, #0]!
    ADD  X24, X24, X18, LSR #0
    STR  X13, [X24, #0]!
    LDR  X15, [X24, #0]!
    ADD  X24, X24, X18, ASR #0
    STRB  W15, [X24], #0
    LDRB  W15, [X24], #0
    ADD  X24, X24, X18, ASR #0
    STRB  W25, [X24, #0]!
    LDRB  W23, [X24, #0]!
    ADD  X24, X24, X18, LSR #0
    STRH  W23, [X24], #0
    LDRH  W13, [X24], #0
    ADD  X24, X24, X18
    STRH  W15, [X24, #0]!
    LDRH  W25, [X24, #0]!
    ADD  X24, X24, X18
    STP  X20, X21, [X24, #0]
    LDAXP  W15, W23, [X24,#0]
    ADD  X24, X24, X18, LSR #0
    STP  X15, X25, [X24, #0]
    LDAXP  X20, X25, [X24,#0]
    ADD  X24, X24, X18
    STP  X25, X25, [X24, #0]
    LDPSW  X21, X15, [X24], #0
    ADD  X24, X24, X18, LSR #0
    STP  X15, X20, [X24, #0]
    LDPSW  X13, X25, [X24, #0]!
    ADD  X24, X24, X18, ASR #0
    STP  X21, X25, [X24, #0]
    LDAXR  W11, [X24,#0]
    ADD  X24, X24, X18
    STP  X11, X20, [X24, #0]
    LDAXR  X21, [X24,#0]
    ADD  X24, X24, X18
    STP  X21, X21, [X24, #0]
    LDAXRB  W4, [X24,#0]
    ADD  X24, X24, X18
    STP  X4, X4, [X24, #0]
    LDAXRH  W20, [X24,#0]
    ADD  X24, X24, X18, LSR #0
    MOVZ  X27, #0x5a, LSL #0
    SUB  X8, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X27, #0x5a, LSL #0
    SUB  X8, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X27, #0x5a, LSL #0
    SUB  X8, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    SUB  X8, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X27, #0x5a, LSL #0
    SUB  X8, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    SUB  X8, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X27, #0x5a, LSL #0
    SUB  X8, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    SUB  X8, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X27, #0x5a, LSL #0
    SUB  X8, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X27, #0x5a, LSL #0
    SUB  X8, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    SUB  X8, X27, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X27, #0x5a, LSL #0
    SUB  X8, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X27, #0x5a, LSL #0
    SUB  X8, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
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
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
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
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X22, #0x10, LSL #0
    MOVZ  X8, #0x500, LSL #0
    ADD  X23, X30, X8, ASR #0
    STP  X27, X15, [X23, #0]
    LDPSW  X2, X4, [X23, #0]
    ADD  X23, X23, X22, ASR #0
    STP  X24, X4, [X23, #0]
    LDRSB  W10, [X23], #0
    ADD  X23, X23, X22, ASR #0
    STP  X2, X28, [X23, #0]
    LDRSB  X28, [X23], #0
    ADD  X23, X23, X22, LSR #0
    STP  X29, X29, [X23, #0]
    LDRSB  W11, [X23, #0]!
    ADD  X23, X23, X22, ASR #0
    STP  X28, X28, [X23, #0]
    LDRSB  X2, [X23, #0]!
    ADD  X23, X23, X22, ASR #0
    STP  X28, X10, [X23, #0]
    LDRSB  W11, [X23, #0]
    ADD  X23, X23, X22
    STP  X11, X2, [X23, #0]
    LDRSB  X16, [X23, #0]
    ADD  X23, X23, X22, LSR #0
    STP  X2, X11, [X23, #0]
    LDRSB W2, [X23, X15, LSL #0]
    ADD  X23, X23, X22, ASR #0
    STP  X16, X25, [X23, #0]
    LDRSB W26, [X23, W15, SXTW #0]
    ADD  X23, X23, X22
    STP  X15, X21, [X23, #0]
    LDRSB W16, [X23, X15, SXTX #0]
    ADD  X23, X23, X22, LSR #0
    STP  X28, X25, [X23, #0]
    LDRSB W10, [X23, W15, UXTW #0]
    ADD  X23, X23, X22, LSR #0
    STP  X25, X24, [X23, #0]
    LDRSB X25, [X23, X15, LSL #0]
    ADD  X23, X23, X22
    STP  X16, X21, [X23, #0]
    LDRSB X29, [X23, W15, SXTW #0]
    ADD  X23, X23, X22, ASR #0
    STP  X18, X21, [X23, #0]
    LDRSB X21, [X23, X15, SXTX #0]
    ADD  X23, X23, X22, LSR #0
    STP  X25, X17, [X23, #0]
    LDRSB X16, [X23, W16, UXTW #0]
    ADD  X23, X23, X22, LSR #0
    STP  X27, X2, [X23, #0]
    LDRSH  W25, [X23], #0
    ADD  X23, X23, X22
    STP  X18, X17, [X23, #0]
    LDRSH  X27, [X23], #0
    ADD  X23, X23, X22, LSR #0
    STP  X28, X16, [X23, #0]
    LDRSH  W17, [X23, #0]!
    ADD  X23, X23, X22, ASR #0
    STP  X5, X13, [X23, #0]
    LDRSH  X18, [X23, #0]!
    ADD  X23, X23, X22
    STP  X18, X17, [X23, #0]
    LDRSH  W2, [X23, #0]
    ADD  X23, X23, X22
    STP  X27, X21, [X23, #0]
    LDRSH  X21, [X23, #0]
    ADD  X23, X23, X22, ASR #0
    STP  X25, X2, [X23, #0]
    LDRSH W18, [X23, X15, LSL #0]
    ADD  X23, X23, X22, ASR #0
    STP  X21, X21, [X23, #0]
    LDRSH W13, [X23, W29, SXTW #0]
    ADD  X23, X23, X22, ASR #0
    STP  X4, X11, [X23, #0]
    LDRSH W16, [X23, X15, SXTX #0]
    ADD  X23, X23, X22, ASR #0
    STP  X16, X18, [X23, #0]
    LDRSH W21, [X23, W15, UXTW #1]
    ADD  X23, X23, X22, LSR #0
    STP  X5, X5, [X23, #0]
    LDRSH X16, [X23, X29, LSL #0]
    ADD  X23, X23, X22
    STP  X10, X18, [X23, #0]
    LDRSH X25, [X23, W29, SXTW #1]
    ADD  X23, X23, X22, ASR #0
    STP  X2, X17, [X23, #0]
    LDRSH X5, [X23, X29, SXTX #1]
    ADD  X23, X23, X22
    STP  X5, X26, [X23, #0]
    LDRSH X17, [X23, W15, UXTW #1]
    ADD  X23, X23, X22
    STP  X24, X10, [X23, #0]
    LDRSW  X27, [X23], #0
    ADD  X23, X23, X22, LSR #0
    STP  X10, X27, [X23, #0]
    LDRSW  X18, [X23, #0]!
    ADD  X23, X23, X22, ASR #0
    STP  X2, X17, [X23, #0]
    LDRSW  X17, [X23, #0]
    ADD  X23, X23, X22, ASR #0
    STP  X2, X29, [X23, #0]
    LDRSW X26, [X23, X15, LSL #0]
    ADD  X23, X23, X22, ASR #0
    STP  X16, X21, [X23, #0]
    LDRSW X27, [X23, W15, SXTW #2]
    ADD  X23, X23, X22, LSR #0
    STP  X4, X26, [X23, #0]
    LDRSW X24, [X23, X15, SXTX #0]
    ADD  X23, X23, X22, LSR #0
    STP  X2, X10, [X23, #0]
    LDRSW X2, [X23, W29, UXTW #2]
    ADD  X23, X23, X22, ASR #0
    STP  X9, X16, [X23, #0]
    LDTRSB  W9, [X23, #0]
    ADD  X23, X23, X22, ASR #0
    STP  X9, X21, [X23, #0]
    LDTRSB  X10, [X23, #0]
    ADD  X23, X23, X22
    STP  X9, X21, [X23, #0]
    LDTRSH  W21, [X23, #0]
    ADD  X23, X23, X22, LSR #0
    STP  X11, X2, [X23, #0]
    LDTRSH  X9, [X23, #0]
    ADD  X23, X23, X22, ASR #0
    STP  X26, X15, [X23, #0]
    LDTRSW  X2, [X23, #0]
    ADD  X23, X23, X22, ASR #0
    STP  X10, X24, [X23, #0]
    LDURSB  W26, [X23, #0]
    ADD  X23, X23, X22
    STP  X2, X2, [X23, #0]
    LDURSB  X2, [X23, #0]
    ADD  X23, X23, X22
    STP  X26, X9, [X23, #0]
    LDURSH  W24, [X23, #0]
    ADD  X23, X23, X22
    STP  X9, X21, [X23, #0]
    LDURSH  X29, [X23, #0]
    ADD  X23, X23, X22, ASR #0
    STP  X24, X29, [X23, #0]
    LDURSW  X11, [X23, #0]
    ADD  X23, X23, X22, ASR #0
    STP  X15, X27, [X23, #0]
    LDXP  W10, W21, [X23,#0]
    ADD  X23, X23, X22, ASR #0
    STP  X10, X25, [X23, #0]
    LDXP  X9, X24, [X23,#0]
    ADD  X23, X23, X22
    STP  X11, X27, [X23, #0]
    LDXR  W25, [X23,#0]
    ADD  X23, X23, X22
    STP  X11, X15, [X23, #0]
    LDXR  X27, [X23,#0]
    ADD  X23, X23, X22, LSR #0
    STP  X18, X29, [X23, #0]
    LDXRB  W18, [X23,#0]
    ADD  X23, X23, X22
    STP  X11, X26, [X23, #0]
    LDXRH  W26, [X23,#0]
    ADD  X23, X23, X22, ASR #0
    STRB  W21, [X23, #0]
    LDRB  W21, [X23, #0]
    ADD  X23, X23, X22
    STRB W25, [X23, X21, LSL #0]
    LDRB W25, [X23, X15, LSL #0]
    ADD  X23, X23, X22, LSR #0
    STRB W27, [X23, W9, SXTW #0]
    LDRB W26, [X23, W10, SXTW #0]
    ADD  X23, X23, X22, ASR #0
    STRB W18, [X23, X10, SXTX #0]
    LDRB W21, [X23, X9, SXTX #0]
    ADD  X23, X23, X22
    STRB W21, [X23, W9, UXTW #0]
    LDRB W29, [X23, W15, UXTW #0]
    ADD  X23, X23, X22
    STRH  W25, [X23, #0]
    LDRH  W9, [X23, #0]
    ADD  X23, X23, X22, LSR #0
    STRH W26, [X23, X10, LSL #0]
    LDRH W18, [X23, X15, LSL #1]
    ADD  X23, X23, X22
    STRH W29, [X23, W15, SXTW #1]
    LDRH W27, [X23, W10, SXTW #0]
    ADD  X23, X23, X22
    STRH W9, [X23, X10, SXTX #1]
    LDRH W26, [X23, X10, SXTX #0]
    ADD  X23, X23, X22, LSR #0
    STRH W18, [X23, W15, UXTW #0]
    LDRH W9, [X23, W15, UXTW #1]
    ADD  X23, X23, X22, ASR #0
    STR  W27, [X23, #0]
    LDR  W10, [X23, #0]
    ADD  X23, X23, X22
    STR  X10, [X23, #0]
    LDR  X18, [X23, #0]
    ADD  X23, X23, X22, ASR #0
    STR W26, [X23, X15, LSL #2]
    LDR W27, [X23, X15, LSL #2]
    ADD  X23, X23, X22, LSR #0
    STR W9, [X23, W15, SXTW #0]
    LDR W9, [X23, W15, SXTW #2]
    ADD  X23, X23, X22
    STR W9, [X23, X15, SXTX #0]
    LDR W26, [X23, X15, SXTX #0]
    ADD  X23, X23, X22, LSR #0
    STR W27, [X23, W15, UXTW #2]
    LDR W27, [X23, W15, UXTW #2]
    ADD  X23, X23, X22, LSR #0
    STR X18, [X23, X15, LSL #3]
    LDR X9, [X23, X15, LSL #3]
    ADD  X23, X23, X22, LSR #0
    STR X26, [X23, W15, SXTW #0]
    LDR X18, [X23, W15, SXTW #0]
    ADD  X23, X23, X22, ASR #0
    STR X18, [X23, X15, SXTX #3]
    LDR X26, [X23, X15, SXTX #3]
    ADD  X23, X23, X22
    STR X26, [X23, W15, UXTW #0]
    LDR X18, [X23, W15, UXTW #3]
    ADD  X23, X23, X22, LSR #0
    STP  W27, W27, [X23, #0]
    LDP  W26, W4, [X23, #0]
    ADD  X23, X23, X22, ASR #0
    STP  X9, X24, [X23, #0]
    LDP  X24, X9, [X23, #0]
    ADD  X23, X23, X22
    STTR  W9, [X23, #0]
    LDTR  W27, [X23, #0]
    ADD  X23, X23, X22, ASR #0
    STTR  X24, [X23, #0]
    LDTR  X5, [X23, #0]
    ADD  X23, X23, X22, LSR #0
    STTRB  W27, [X23, #0]
    LDTRB  W24, [X23, #0]
    ADD  X23, X23, X22, LSR #0
    STTRH  W5, [X23, #0]
    LDTRH  W27, [X23, #0]
    ADD  X23, X23, X22, LSR #0
    STUR  W26, [X23, #0]
    LDUR  W5, [X23, #0]
    ADD  X23, X23, X22, ASR #0
    STUR  X4, [X23, #0]
    LDUR  X4, [X23, #0]
    ADD  X23, X23, X22, LSR #0
    STURB  W27, [X23, #0]
    LDURB  W10, [X23, #0]
    ADD  X23, X23, X22, ASR #0
    STURH  W5, [X23, #0]
    LDURH  W5, [X23, #0]
    ADD  X23, X23, X22, ASR #0
    STLR  W28, [X23,#0]
    LDAR  W26, [X23,#0]
    ADD  X23, X23, X22, LSR #0
    STLR  X24, [X23,#0]
    LDAR  X24, [X23,#0]
    ADD  X23, X23, X22, LSR #0
    STLRB  W26, [X23,#0]
    LDARB  W26, [X23,#0]
    ADD  X23, X23, X22, LSR #0
    STLRH  W24, [X23,#0]
    LDARH  W27, [X23,#0]
    ADD  X23, X23, X22, ASR #0
    STNP  W26, W5, [X23, #0]
    LDNP  W28, W25, [X23, #0]
    ADD  X23, X23, X22, ASR #0
    STNP  X10, X27, [X23, #0]
    LDNP  X24, X25, [X23, #0]
    ADD  X23, X23, X22
    STP  W28, W25, [X23], #0
    LDP  W10, W26, [X23], #0
    ADD  X23, X23, X22
    STP  X4, X24, [X23], #0
    LDP  X29, X27, [X23], #0
    ADD  X23, X23, X22
    STP  W24, W10, [X23, #0]!
    LDP  W24, W25, [X23, #0]!
    ADD  X23, X23, X22
    STP  X27, X26, [X23, #0]!
    LDP  X10, X4, [X23, #0]!
    ADD  X23, X23, X22, LSR #0
    STR  W15, [X23], #0
    LDR  W28, [X23], #0
    ADD  X23, X23, X22, ASR #0
    STR  X28, [X23], #0
    LDR  X18, [X23], #0
    ADD  X23, X23, X22, LSR #0
    STR  W28, [X23, #0]!
    LDR  W5, [X23, #0]!
    ADD  X23, X23, X22, ASR #0
    STR  X4, [X23, #0]!
    LDR  X28, [X23, #0]!
    ADD  X23, X23, X22, ASR #0
    STRB  W25, [X23], #0
    LDRB  W24, [X23], #0
    ADD  X23, X23, X22
    STRB  W29, [X23, #0]!
    LDRB  W29, [X23, #0]!
    ADD  X23, X23, X22, LSR #0
    STRH  W28, [X23], #0
    LDRH  W26, [X23], #0
    ADD  X23, X23, X22, LSR #0
    STRH  W18, [X23, #0]!
    LDRH  W28, [X23, #0]!
    ADD  X23, X23, X22, LSR #0
    STP  X5, X27, [X23, #0]
    LDAXP  W18, W5, [X23,#0]
    ADD  X23, X23, X22, ASR #0
    STP  X26, X26, [X23, #0]
    LDAXP  X4, X26, [X23,#0]
    ADD  X23, X23, X22, LSR #0
    STP  X28, X28, [X23, #0]
    LDPSW  X27, X29, [X23], #0
    ADD  X23, X23, X22, LSR #0
    STP  X9, X5, [X23, #0]
    LDPSW  X28, X9, [X23, #0]!
    ADD  X23, X23, X22
    STP  X18, X27, [X23, #0]
    LDAXR  W25, [X23,#0]
    ADD  X23, X23, X22
    STP  X29, X26, [X23, #0]
    LDAXR  X18, [X23,#0]
    ADD  X23, X23, X22, LSR #0
    STP  X4, X28, [X23, #0]
    LDAXRB  W29, [X23,#0]
    ADD  X23, X23, X22
    STP  X9, X25, [X23, #0]
    LDAXRH  W7, [X23,#0]
    ADD  X23, X23, X22, LSR #0
    MOVZ  X20, #0xffa5, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X6, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0xa5, LSL #0
    SUB  X6, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X6, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0xffff, LSL #0
    SUB  X6, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X6, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0xa5, LSL #0
    SUB  X6, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0xffa5, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X6, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xffff, LSL #16
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X6, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X6, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X6, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0xa5, LSL #0
    SUB  X6, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0xa5, LSL #0
    SUB  X6, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X6, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0xa5, LSL #0
    SUB  X6, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X6, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0xffa5, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X6, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0xa5, LSL #0
    SUB  X6, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
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
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
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
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X22, #0x10, LSL #0
    MOVZ  X26, #0xa00, LSL #0
    ADD  X16, X30, X26, ASR #0
    STP  X29, X18, [X16, #0]
    LDPSW  X15, X10, [X16, #0]
    ADD  X16, X16, X22, LSR #0
    STP  X10, X27, [X16, #0]
    LDRSB  W7, [X16], #0
    ADD  X16, X16, X22, LSR #0
    STP  X15, X7, [X16, #0]
    LDRSB  X8, [X16], #0
    ADD  X16, X16, X22
    STP  X8, X17, [X16, #0]
    LDRSB  W4, [X16, #0]!
    ADD  X16, X16, X22, LSR #0
    STP  X4, X4, [X16, #0]
    LDRSB  X9, [X16, #0]!
    ADD  X16, X16, X22
    STP  X21, X15, [X16, #0]
    LDRSB  W29, [X16, #0]
    ADD  X16, X16, X22, ASR #0
    STP  X6, X2, [X16, #0]
    LDRSB  X15, [X16, #0]
    ADD  X16, X16, X22
    STP  X10, X24, [X16, #0]
    LDRSB W4, [X16, X18, LSL #0]
    ADD  X16, X16, X22
    STP  X29, X24, [X16, #0]
    LDRSB W17, [X16, W18, SXTW #0]
    ADD  X16, X16, X22, ASR #0
    STP  X9, X7, [X16, #0]
    LDRSB W29, [X16, X18, SXTX #0]
    ADD  X16, X16, X22, LSR #0
    STP  X29, X29, [X16, #0]
    LDRSB W10, [X16, W18, UXTW #0]
    ADD  X16, X16, X22
    STP  X11, X6, [X16, #0]
    LDRSB X24, [X16, X18, LSL #0]
    ADD  X16, X16, X22, LSR #0
    STP  X15, X7, [X16, #0]
    LDRSB X9, [X16, W18, SXTW #0]
    ADD  X16, X16, X22
    STP  X5, X21, [X16, #0]
    LDRSB X29, [X16, X18, SXTX #0]
    ADD  X16, X16, X22, LSR #0
    STP  X23, X7, [X16, #0]
    LDRSB X23, [X16, W18, UXTW #0]
    ADD  X16, X16, X22
    STP  X2, X9, [X16, #0]
    LDRSH  W2, [X16], #0
    ADD  X16, X16, X22, ASR #0
    STP  X9, X24, [X16, #0]
    LDRSH  X15, [X16], #0
    ADD  X16, X16, X22, LSR #0
    STP  X5, X27, [X16, #0]
    LDRSH  W6, [X16, #0]!
    ADD  X16, X16, X22, LSR #0
    STP  X29, X6, [X16, #0]
    LDRSH  X6, [X16, #0]!
    ADD  X16, X16, X22, LSR #0
    STP  X6, X6, [X16, #0]
    LDRSH  W9, [X16, #0]
    ADD  X16, X16, X22, LSR #0
    STP  X15, X18, [X16, #0]
    LDRSH  X15, [X16, #0]
    ADD  X16, X16, X22, LSR #0
    STP  X2, X15, [X16, #0]
    LDRSH W5, [X16, X18, LSL #1]
    ADD  X16, X16, X22, ASR #0
    STP  X10, X23, [X16, #0]
    LDRSH W27, [X16, W18, SXTW #1]
    ADD  X16, X16, X22, LSR #0
    STP  X5, X27, [X16, #0]
    LDRSH W5, [X16, X18, SXTX #0]
    ADD  X16, X16, X22
    STP  X25, X24, [X16, #0]
    LDRSH W23, [X16, W18, UXTW #0]
    ADD  X16, X16, X22
    STP  X7, X27, [X16, #0]
    LDRSH X25, [X16, X18, LSL #0]
    ADD  X16, X16, X22
    STP  X29, X11, [X16, #0]
    LDRSH X6, [X16, W18, SXTW #0]
    ADD  X16, X16, X22, ASR #0
    STP  X21, X11, [X16, #0]
    LDRSH X7, [X16, X18, SXTX #0]
    ADD  X16, X16, X22
    STP  X4, X4, [X16, #0]
    LDRSH X11, [X16, W18, UXTW #0]
    ADD  X16, X16, X22
    STP  X21, X10, [X16, #0]
    LDRSW  X27, [X16], #0
    ADD  X16, X16, X22
    STP  X11, X7, [X16, #0]
    LDRSW  X29, [X16, #0]!
    ADD  X16, X16, X22, ASR #0
    STP  X27, X29, [X16, #0]
    LDRSW  X10, [X16, #0]
    ADD  X16, X16, X22
    STP  X25, X10, [X16, #0]
    LDRSW X10, [X16, X18, LSL #2]
    ADD  X16, X16, X22, ASR #0
    STP  X6, X10, [X16, #0]
    LDRSW X7, [X16, W18, SXTW #2]
    ADD  X16, X16, X22, ASR #0
    STP  X7, X7, [X16, #0]
    LDRSW X29, [X16, X18, SXTX #0]
    ADD  X16, X16, X22, LSR #0
    STP  X17, X5, [X16, #0]
    LDRSW X5, [X16, W18, UXTW #0]
    ADD  X16, X16, X22, ASR #0
    STP  X25, X21, [X16, #0]
    LDTRSB  W7, [X16, #0]
    ADD  X16, X16, X22, ASR #0
    STP  X15, X29, [X16, #0]
    LDTRSB  X6, [X16, #0]
    ADD  X16, X16, X22
    STP  X10, X21, [X16, #0]
    LDTRSH  W10, [X16, #0]
    ADD  X16, X16, X22, ASR #0
    STP  X25, X2, [X16, #0]
    LDTRSH  X29, [X16, #0]
    ADD  X16, X16, X22, LSR #0
    STP  X2, X5, [X16, #0]
    LDTRSW  X15, [X16, #0]
    ADD  X16, X16, X22, LSR #0
    STP  X11, X9, [X16, #0]
    LDURSB  W21, [X16, #0]
    ADD  X16, X16, X22
    STP  X29, X13, [X16, #0]
    LDURSB  X25, [X16, #0]
    ADD  X16, X16, X22, ASR #0
    STP  X27, X2, [X16, #0]
    LDURSH  W5, [X16, #0]
    ADD  X16, X16, X22, LSR #0
    STP  X21, X29, [X16, #0]
    LDURSH  X9, [X16, #0]
    ADD  X16, X16, X22, LSR #0
    STP  X9, X23, [X16, #0]
    LDURSW  X13, [X16, #0]
    ADD  X16, X16, X22
    STP  X18, X11, [X16, #0]
    LDXP  W27, W17, [X16,#0]
    ADD  X16, X16, X22, LSR #0
    STP  X25, X15, [X16, #0]
    LDXP  X11, X23, [X16,#0]
    ADD  X16, X16, X22, ASR #0
    STP  X5, X5, [X16, #0]
    LDXR  W15, [X16,#0]
    ADD  X16, X16, X22, LSR #0
    STP  X29, X21, [X16, #0]
    LDXR  X25, [X16,#0]
    ADD  X16, X16, X22
    STP  X23, X9, [X16, #0]
    LDXRB  W9, [X16,#0]
    ADD  X16, X16, X22, ASR #0
    STP  X4, X25, [X16, #0]
    LDXRH  W29, [X16,#0]
    ADD  X16, X16, X22, ASR #0
    STRB  W2, [X16, #0]
    LDRB  W25, [X16, #0]
    ADD  X16, X16, X22, LSR #0
    STRB W9, [X16, X17, LSL #0]
    LDRB W23, [X16, X27, LSL #0]
    ADD  X16, X16, X22, ASR #0
    STRB W15, [X16, W27, SXTW #0]
    LDRB W5, [X16, W18, SXTW #0]
    ADD  X16, X16, X22
    STRB W5, [X16, X18, SXTX #0]
    LDRB W21, [X16, X27, SXTX #0]
    ADD  X16, X16, X22, ASR #0
    STRB W23, [X16, W18, UXTW #0]
    LDRB W23, [X16, W27, UXTW #0]
    ADD  X16, X16, X22, LSR #0
    STRH  W25, [X16, #0]
    LDRH  W15, [X16, #0]
    ADD  X16, X16, X22
    STRH W29, [X16, X27, LSL #0]
    LDRH W27, [X16, X18, LSL #0]
    ADD  X16, X16, X22
    STRH W21, [X16, W18, SXTW #1]
    LDRH W17, [X16, W17, SXTW #0]
    ADD  X16, X16, X22, LSR #0
    STRH W17, [X16, X18, SXTX #1]
    LDRH W17, [X16, X18, SXTX #0]
    ADD  X16, X16, X22, ASR #0
    STRH W17, [X16, W18, UXTW #1]
    LDRH W2, [X16, W18, UXTW #1]
    ADD  X16, X16, X22
    STR  W2, [X16, #0]
    LDR  W17, [X16, #0]
    ADD  X16, X16, X22, ASR #0
    STR  X27, [X16, #0]
    LDR  X25, [X16, #0]
    ADD  X16, X16, X22, ASR #0
    STR W25, [X16, X18, LSL #2]
    LDR W27, [X16, X18, LSL #0]
    ADD  X16, X16, X22, LSR #0
    STR W13, [X16, W18, SXTW #2]
    LDR W25, [X16, W18, SXTW #0]
    ADD  X16, X16, X22, ASR #0
    STR W25, [X16, X18, SXTX #2]
    LDR W2, [X16, X18, SXTX #2]
    ADD  X16, X16, X22
    STR W18, [X16, W18, UXTW #2]
    LDR W13, [X16, W18, UXTW #0]
    ADD  X16, X16, X22, LSR #0
    STR X27, [X16, X13, LSL #3]
    LDR X25, [X16, X18, LSL #0]
    ADD  X16, X16, X22, ASR #0
    STR X25, [X16, W18, SXTW #0]
    LDR X27, [X16, W18, SXTW #0]
    ADD  X16, X16, X22, ASR #0
    STR X27, [X16, X13, SXTX #0]
    LDR X27, [X16, X18, SXTX #3]
    ADD  X16, X16, X22
    STR X2, [X16, W13, UXTW #0]
    LDR X25, [X16, W18, UXTW #3]
    ADD  X16, X16, X22
    STP  W27, W25, [X16, #0]
    LDP  W2, W13, [X16, #0]
    ADD  X16, X16, X22, LSR #0
    STP  X8, X21, [X16, #0]
    LDP  X10, X27, [X16, #0]
    ADD  X16, X16, X22, ASR #0
    STTR  W8, [X16, #0]
    LDTR  W8, [X16, #0]
    ADD  X16, X16, X22, LSR #0
    STTR  X24, [X16, #0]
    LDTR  X2, [X16, #0]
    ADD  X16, X16, X22, ASR #0
    STTRB  W17, [X16, #0]
    LDTRB  W7, [X16, #0]
    ADD  X16, X16, X22, LSR #0
    STTRH  W25, [X16, #0]
    LDTRH  W21, [X16, #0]
    ADD  X16, X16, X22, LSR #0
    STUR  W15, [X16, #0]
    LDUR  W15, [X16, #0]
    ADD  X16, X16, X22, LSR #0
    STUR  X11, [X16, #0]
    LDUR  X17, [X16, #0]
    ADD  X16, X16, X22, LSR #0
    STURB  W21, [X16, #0]
    LDURB  W25, [X16, #0]
    ADD  X16, X16, X22, ASR #0
    STURH  W17, [X16, #0]
    LDURH  W24, [X16, #0]
    ADD  X16, X16, X22, LSR #0
    STLR  W10, [X16,#0]
    LDAR  W10, [X16,#0]
    ADD  X16, X16, X22
    STLR  X7, [X16,#0]
    LDAR  X11, [X16,#0]
    ADD  X16, X16, X22, LSR #0
    STLRB  W25, [X16,#0]
    LDARB  W25, [X16,#0]
    ADD  X16, X16, X22, LSR #0
    STLRH  W15, [X16,#0]
    LDARH  W5, [X16,#0]
    ADD  X16, X16, X22, ASR #0
    STNP  W11, W11, [X16, #0]
    LDNP  W21, W11, [X16, #0]
    ADD  X16, X16, X22, ASR #0
    STNP  X21, X5, [X16, #0]
    LDNP  X15, X21, [X16, #0]
    ADD  X16, X16, X22
    STP  W10, W15, [X16], #0
    LDP  W10, W7, [X16], #0
    ADD  X16, X16, X22, LSR #0
    STP  X25, X7, [X16], #0
    LDP  X25, X5, [X16], #0
    ADD  X16, X16, X22, LSR #0
    STP  W10, W5, [X16, #0]!
    LDP  W10, W15, [X16, #0]!
    ADD  X16, X16, X22, ASR #0
    STP  X11, X10, [X16, #0]!
    LDP  X7, X10, [X16, #0]!
    ADD  X16, X16, X22
    STR  W21, [X16], #0
    LDR  W11, [X16], #0
    ADD  X16, X16, X22
    STR  X15, [X16], #0
    LDR  X25, [X16], #0
    ADD  X16, X16, X22, LSR #0
    STR  W25, [X16, #0]!
    LDR  W21, [X16, #0]!
    ADD  X16, X16, X22
    STR  X7, [X16, #0]!
    LDR  X5, [X16, #0]!
    ADD  X16, X16, X22, LSR #0
    STRB  W11, [X16], #0
    LDRB  W11, [X16], #0
    ADD  X16, X16, X22, ASR #0
    STRB  W21, [X16, #0]!
    LDRB  W21, [X16, #0]!
    ADD  X16, X16, X22
    STRH  W21, [X16], #0
    LDRH  W8, [X16], #0
    ADD  X16, X16, X22, LSR #0
    STRH  W11, [X16, #0]!
    LDRH  W15, [X16, #0]!
    ADD  X16, X16, X22
    STP  X8, X15, [X16, #0]
    LDAXP  W15, W7, [X16,#0]
    ADD  X16, X16, X22, ASR #0
    STP  X15, X15, [X16, #0]
    LDAXP  X8, X15, [X16,#0]
    ADD  X16, X16, X22, LSR #0
    STP  X5, X8, [X16, #0]
    LDPSW  X5, X11, [X16], #0
    ADD  X16, X16, X22, ASR #0
    STP  X15, X11, [X16, #0]
    LDPSW  X25, X6, [X16, #0]!
    ADD  X16, X16, X22
    STP  X25, X7, [X16, #0]
    LDAXR  W7, [X16,#0]
    ADD  X16, X16, X22, ASR #0
    STP  X5, X11, [X16, #0]
    LDAXR  X8, [X16,#0]
    ADD  X16, X16, X22, LSR #0
    STP  X6, X7, [X16, #0]
    LDAXRB  W6, [X16,#0]
    ADD  X16, X16, X22, LSR #0
    STP  X27, X6, [X16, #0]
    LDAXRH  W15, [X16,#0]
    ADD  X16, X16, X22
    MOVZ  X20, #0x5a, LSL #0
    SUB  X28, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X28, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X28, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X28, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X28, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X28, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X28, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X28, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X28, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X28, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X28, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X28, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X28, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X28, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X28, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X28, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
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
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
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
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X29, #0x10, LSL #0
    MOVZ  X23, #0xf00, LSL #0
    ADD  X20, X30, X23, ASR #0
    STP  X27, X26, [X20, #0]
    LDPSW  X7, X6, [X20, #0]
    ADD  X20, X20, X29
    STP  X28, X7, [X20, #0]
    LDRSB  W13, [X20], #0
    ADD  X20, X20, X29, LSR #0
    STP  X13, X6, [X20, #0]
    LDRSB  X15, [X20], #0
    ADD  X20, X20, X29, LSR #0
    STP  X15, X15, [X20, #0]
    LDRSB  W5, [X20, #0]!
    ADD  X20, X20, X29, ASR #0
    STP  X16, X22, [X20, #0]
    LDRSB  X22, [X20, #0]!
    ADD  X20, X20, X29, LSR #0
    STP  X25, X15, [X20, #0]
    LDRSB  W22, [X20, #0]
    ADD  X20, X20, X29, ASR #0
    STP  X9, X21, [X20, #0]
    LDRSB  X15, [X20, #0]
    ADD  X20, X20, X29, LSR #0
    STP  X10, X13, [X20, #0]
    LDRSB W26, [X20, X27, LSL #0]
    ADD  X20, X20, X29, ASR #0
    STP  X6, X10, [X20, #0]
    LDRSB W25, [X20, W7, SXTW #0]
    ADD  X20, X20, X29, ASR #0
    STP  X18, X28, [X20, #0]
    LDRSB W16, [X20, X25, SXTX #0]
    ADD  X20, X20, X29, LSR #0
    STP  X5, X10, [X20, #0]
    LDRSB W7, [X20, W25, UXTW #0]
    ADD  X20, X20, X29
    STP  X15, X24, [X20, #0]
    LDRSB X25, [X20, X25, LSL #0]
    ADD  X20, X20, X29
    STP  X18, X8, [X20, #0]
    LDRSB X5, [X20, W27, SXTW #0]
    ADD  X20, X20, X29, ASR #0
    STP  X9, X9, [X20, #0]
    LDRSB X6, [X20, X6, SXTX #0]
    ADD  X20, X20, X29
    STP  X18, X17, [X20, #0]
    LDRSB X24, [X20, W27, UXTW #0]
    ADD  X20, X20, X29, LSR #0
    STP  X5, X5, [X20, #0]
    LDRSH  W9, [X20], #0
    ADD  X20, X20, X29
    STP  X7, X24, [X20, #0]
    LDRSH  X8, [X20], #0
    ADD  X20, X20, X29, LSR #0
    STP  X9, X9, [X20, #0]
    LDRSH  W17, [X20, #0]!
    ADD  X20, X20, X29, ASR #0
    STP  X6, X8, [X20, #0]
    LDRSH  X18, [X20, #0]!
    ADD  X20, X20, X29, ASR #0
    STP  X18, X25, [X20, #0]
    LDRSH  W8, [X20, #0]
    ADD  X20, X20, X29
    STP  X17, X8, [X20, #0]
    LDRSH  X24, [X20, #0]
    ADD  X20, X20, X29, LSR #0
    STP  X21, X25, [X20, #0]
    LDRSH W6, [X20, X27, LSL #1]
    ADD  X20, X20, X29
    STP  X9, X21, [X20, #0]
    LDRSH W8, [X20, W27, SXTW #0]
    ADD  X20, X20, X29, ASR #0
    STP  X27, X28, [X20, #0]
    LDRSH W5, [X20, X27, SXTX #1]
    ADD  X20, X20, X29, LSR #0
    STP  X6, X28, [X20, #0]
    LDRSH W7, [X20, W5, UXTW #0]
    ADD  X20, X20, X29, LSR #0
    STP  X7, X22, [X20, #0]
    LDRSH X18, [X20, X5, LSL #0]
    ADD  X20, X20, X29, LSR #0
    STP  X8, X8, [X20, #0]
    LDRSH X25, [X20, W27, SXTW #0]
    ADD  X20, X20, X29
    STP  X6, X17, [X20, #0]
    LDRSH X28, [X20, X5, SXTX #1]
    ADD  X20, X20, X29, ASR #0
    STP  X2, X15, [X20, #0]
    LDRSH X6, [X20, W5, UXTW #0]
    ADD  X20, X20, X29
    STP  X8, X16, [X20, #0]
    LDRSW  X22, [X20], #0
    ADD  X20, X20, X29, LSR #0
    STP  X25, X2, [X20, #0]
    LDRSW  X16, [X20, #0]!
    ADD  X20, X20, X29, ASR #0
    STP  X16, X6, [X20, #0]
    LDRSW  X21, [X20, #0]
    ADD  X20, X20, X29
    STP  X5, X18, [X20, #0]
    LDRSW X6, [X20, X5, LSL #2]
    ADD  X20, X20, X29, LSR #0
    STP  X2, X16, [X20, #0]
    LDRSW X8, [X20, W27, SXTW #2]
    ADD  X20, X20, X29, ASR #0
    STP  X17, X27, [X20, #0]
    LDRSW X18, [X20, X6, SXTX #2]
    ADD  X20, X20, X29, ASR #0
    STP  X27, X2, [X20, #0]
    LDRSW X5, [X20, W5, UXTW #0]
    ADD  X20, X20, X29
    STP  X17, X22, [X20, #0]
    LDTRSB  W17, [X20, #0]
    ADD  X20, X20, X29, LSR #0
    STP  X16, X24, [X20, #0]
    LDTRSB  X16, [X20, #0]
    ADD  X20, X20, X29, ASR #0
    STP  X9, X15, [X20, #0]
    LDTRSH  W9, [X20, #0]
    ADD  X20, X20, X29, ASR #0
    STP  X26, X8, [X20, #0]
    LDTRSH  X2, [X20, #0]
    ADD  X20, X20, X29, LSR #0
    STP  X28, X28, [X20, #0]
    LDTRSW  X8, [X20, #0]
    ADD  X20, X20, X29, ASR #0
    STP  X16, X9, [X20, #0]
    LDURSB  W15, [X20, #0]
    ADD  X20, X20, X29, ASR #0
    STP  X15, X2, [X20, #0]
    LDURSB  X9, [X20, #0]
    ADD  X20, X20, X29, ASR #0
    STP  X25, X9, [X20, #0]
    LDURSH  W16, [X20, #0]
    ADD  X20, X20, X29, ASR #0
    STP  X8, X8, [X20, #0]
    LDURSH  X26, [X20, #0]
    ADD  X20, X20, X29
    STP  X16, X5, [X20, #0]
    LDURSW  X24, [X20, #0]
    ADD  X20, X20, X29, LSR #0
    STP  X24, X17, [X20, #0]
    LDXP  W5, W25, [X20,#0]
    ADD  X20, X20, X29, ASR #0
    STP  X15, X24, [X20, #0]
    LDXP  X2, X9, [X20,#0]
    ADD  X20, X20, X29, ASR #0
    STP  X28, X24, [X20, #0]
    LDXR  W28, [X20,#0]
    ADD  X20, X20, X29, LSR #0
    STP  X13, X10, [X20, #0]
    LDXR  X16, [X20,#0]
    ADD  X20, X20, X29
    STP  X16, X13, [X20, #0]
    LDXRB  W10, [X20,#0]
    ADD  X20, X20, X29, ASR #0
    STP  X8, X7, [X20, #0]
    LDXRH  W16, [X20,#0]
    ADD  X20, X20, X29, LSR #0
    STRB  W10, [X20, #0]
    LDRB  W17, [X20, #0]
    ADD  X20, X20, X29, LSR #0
    STRB W9, [X20, X6, LSL #0]
    LDRB W7, [X20, X6, LSL #0]
    ADD  X20, X20, X29
    STRB W28, [X20, W6, SXTW #0]
    LDRB W10, [X20, W27, SXTW #0]
    ADD  X20, X20, X29, ASR #0
    STRB W10, [X20, X27, SXTX #0]
    LDRB W9, [X20, X27, SXTX #0]
    ADD  X20, X20, X29, ASR #0
    STRB W10, [X20, W6, UXTW #0]
    LDRB W8, [X20, W27, UXTW #0]
    ADD  X20, X20, X29
    STRH  W17, [X20, #0]
    LDRH  W17, [X20, #0]
    ADD  X20, X20, X29
    STRH W17, [X20, X27, LSL #1]
    LDRH W6, [X20, X6, LSL #0]
    ADD  X20, X20, X29
    STRH W26, [X20, W27, SXTW #0]
    LDRH W17, [X20, W27, SXTW #0]
    ADD  X20, X20, X29, LSR #0
    STRH W17, [X20, X27, SXTX #0]
    LDRH W17, [X20, X27, SXTX #1]
    ADD  X20, X20, X29, ASR #0
    STRH W7, [X20, W27, UXTW #1]
    LDRH W7, [X20, W27, UXTW #0]
    ADD  X20, X20, X29
    STR  W8, [X20, #0]
    LDR  W8, [X20, #0]
    ADD  X20, X20, X29, ASR #0
    STR  X6, [X20, #0]
    LDR  X26, [X20, #0]
    ADD  X20, X20, X29, ASR #0
    STR W17, [X20, X27, LSL #0]
    LDR W6, [X20, X27, LSL #2]
    ADD  X20, X20, X29
    STR W26, [X20, W27, SXTW #2]
    LDR W17, [X20, W27, SXTW #2]
    ADD  X20, X20, X29
    STR W6, [X20, X27, SXTX #2]
    LDR W26, [X20, X27, SXTX #0]
    ADD  X20, X20, X29, LSR #0
    STR W7, [X20, W27, UXTW #2]
    LDR W6, [X20, W27, UXTW #2]
    ADD  X20, X20, X29, LSR #0
    STR X6, [X20, X27, LSL #3]
    LDR X7, [X20, X27, LSL #3]
    ADD  X20, X20, X29
    STR X7, [X20, W27, SXTW #0]
    LDR X7, [X20, W27, SXTW #3]
    ADD  X20, X20, X29, ASR #0
    STR X7, [X20, X27, SXTX #0]
    LDR X6, [X20, X27, SXTX #0]
    ADD  X20, X20, X29, LSR #0
    STR X26, [X20, W27, UXTW #0]
    LDR X7, [X20, W27, UXTW #0]
    ADD  X20, X20, X29, ASR #0
    STP  W17, W6, [X20, #0]
    LDP  W6, W26, [X20, #0]
    ADD  X20, X20, X29, ASR #0
    STP  X7, X6, [X20, #0]
    LDP  X17, X6, [X20, #0]
    ADD  X20, X20, X29, ASR #0
    STTR  W6, [X20, #0]
    LDTR  W6, [X20, #0]
    ADD  X20, X20, X29
    STTR  X10, [X20, #0]
    LDTR  X10, [X20, #0]
    ADD  X20, X20, X29, ASR #0
    STTRB  W25, [X20, #0]
    LDTRB  W7, [X20, #0]
    ADD  X20, X20, X29, LSR #0
    STTRH  W25, [X20, #0]
    LDTRH  W25, [X20, #0]
    ADD  X20, X20, X29
    STUR  W18, [X20, #0]
    LDUR  W8, [X20, #0]
    ADD  X20, X20, X29, ASR #0
    STUR  X26, [X20, #0]
    LDUR  X25, [X20, #0]
    ADD  X20, X20, X29, ASR #0
    STURB  W7, [X20, #0]
    LDURB  W7, [X20, #0]
    ADD  X20, X20, X29
    STURH  W21, [X20, #0]
    LDURH  W2, [X20, #0]
    ADD  X20, X20, X29, ASR #0
    STLR  W15, [X20,#0]
    LDAR  W24, [X20,#0]
    ADD  X20, X20, X29
    STLR  X15, [X20,#0]
    LDAR  X9, [X20,#0]
    ADD  X20, X20, X29, ASR #0
    STLRB  W10, [X20,#0]
    LDARB  W13, [X20,#0]
    ADD  X20, X20, X29, LSR #0
    STLRH  W24, [X20,#0]
    LDARH  W6, [X20,#0]
    ADD  X20, X20, X29, LSR #0
    STNP  W9, W7, [X20, #0]
    LDNP  W9, W18, [X20, #0]
    ADD  X20, X20, X29
    STNP  X6, X6, [X20, #0]
    LDNP  X16, X22, [X20, #0]
    ADD  X20, X20, X29
    STP  W16, W16, [X20], #0
    LDP  W28, W8, [X20], #0
    ADD  X20, X20, X29, LSR #0
    STP  X13, X13, [X20], #0
    LDP  X6, X18, [X20], #0
    ADD  X20, X20, X29
    STP  W9, W28, [X20, #0]!
    LDP  W2, W26, [X20, #0]!
    ADD  X20, X20, X29, ASR #0
    STP  X6, X2, [X20, #0]!
    LDP  X21, X18, [X20, #0]!
    ADD  X20, X20, X29, ASR #0
    STR  W22, [X20], #0
    LDR  W25, [X20], #0
    ADD  X20, X20, X29
    STR  X18, [X20], #0
    LDR  X7, [X20], #0
    ADD  X20, X20, X29, LSR #0
    STR  W9, [X20, #0]!
    LDR  W28, [X20, #0]!
    ADD  X20, X20, X29, ASR #0
    STR  X21, [X20, #0]!
    LDR  X18, [X20, #0]!
    ADD  X20, X20, X29, LSR #0
    STRB  W25, [X20], #0
    LDRB  W15, [X20], #0
    ADD  X20, X20, X29
    STRB  W15, [X20, #0]!
    LDRB  W18, [X20, #0]!
    ADD  X20, X20, X29, LSR #0
    STRH  W18, [X20], #0
    LDRH  W7, [X20], #0
    ADD  X20, X20, X29, LSR #0
    STRH  W7, [X20, #0]!
    LDRH  W15, [X20, #0]!
    ADD  X20, X20, X29, ASR #0
    STP  X15, X15, [X20, #0]
    LDAXP  W24, W7, [X20,#0]
    ADD  X20, X20, X29, ASR #0
    STP  X5, X24, [X20, #0]
    LDAXP  X18, X7, [X20,#0]
    ADD  X20, X20, X29, LSR #0
    STP  X7, X25, [X20, #0]
    LDPSW  X7, X10, [X20], #0
    ADD  X20, X20, X29, ASR #0
    STP  X18, X10, [X20, #0]
    LDPSW  X24, X7, [X20, #0]!
    ADD  X20, X20, X29
    STP  X7, X17, [X20, #0]
    LDAXR  W6, [X20,#0]
    ADD  X20, X20, X29, LSR #0
    STP  X9, X24, [X20, #0]
    LDAXR  X16, [X20,#0]
    ADD  X20, X20, X29, ASR #0
    STP  X27, X28, [X20, #0]
    LDAXRB  W13, [X20,#0]
    ADD  X20, X20, X29, ASR #0
    STP  X7, X25, [X20, #0]
    LDAXRH  W9, [X20,#0]
    ADD  X20, X20, X29, ASR #0
    MOVZ  X4, #0xffa5, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X11, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0xffa5, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X11, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0xffa5, LSL #0
    SUB  X11, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0xa5, LSL #0
    SUB  X11, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0xffa5, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X11, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    SUB  X11, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0xffa5, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X11, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0xa5, LSL #0
    SUB  X11, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0xffa5, LSL #0
    SUB  X11, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0xffa5, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X11, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0xffa5, LSL #0
    SUB  X11, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0xffa5, LSL #0
    SUB  X11, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X4, #0xffa5, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X11, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X11, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
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
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
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
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X8, #0x10, LSL #0
    MOVZ  X28, #0x1400, LSL #0
    ADD  X9, X30, X28, ASR #0
    STP  X23, X26, [X9, #0]
    LDPSW  X5, X2, [X9, #0]
    ADD  X9, X9, X8, LSR #0
    STP  X2, X20, [X9, #0]
    LDRSB  W26, [X9], #0
    ADD  X9, X9, X8
    STP  X29, X5, [X9, #0]
    LDRSB  X7, [X9], #0
    ADD  X9, X9, X8
    STP  X4, X4, [X9, #0]
    LDRSB  W29, [X9, #0]!
    ADD  X9, X9, X8, ASR #0
    STP  X13, X27, [X9, #0]
    LDRSB  X10, [X9, #0]!
    ADD  X9, X9, X8, LSR #0
    STP  X22, X7, [X9, #0]
    LDRSB  W23, [X9, #0]
    ADD  X9, X9, X8, ASR #0
    STP  X29, X2, [X9, #0]
    LDRSB  X10, [X9, #0]
    ADD  X9, X9, X8
    STP  X4, X10, [X9, #0]
    LDRSB W6, [X9, X20, LSL #0]
    ADD  X9, X9, X8, ASR #0
    STP  X23, X23, [X9, #0]
    LDRSB W4, [X9, W20, SXTW #0]
    ADD  X9, X9, X8, LSR #0
    STP  X6, X26, [X9, #0]
    LDRSB W6, [X9, X20, SXTX #0]
    ADD  X9, X9, X8, LSR #0
    STP  X16, X6, [X9, #0]
    LDRSB W27, [X9, W20, UXTW #0]
    ADD  X9, X9, X8, ASR #0
    STP  X17, X11, [X9, #0]
    LDRSB X26, [X9, X20, LSL #0]
    ADD  X9, X9, X8
    STP  X6, X29, [X9, #0]
    LDRSB X6, [X9, W20, SXTW #0]
    ADD  X9, X9, X8, LSR #0
    STP  X13, X2, [X9, #0]
    LDRSB X10, [X9, X20, SXTX #0]
    ADD  X9, X9, X8
    STP  X16, X25, [X9, #0]
    LDRSB X2, [X9, W20, UXTW #0]
    ADD  X9, X9, X8
    STP  X29, X25, [X9, #0]
    LDRSH  W11, [X9], #0
    ADD  X9, X9, X8, ASR #0
    STP  X11, X22, [X9, #0]
    LDRSH  X22, [X9], #0
    ADD  X9, X9, X8
    STP  X17, X20, [X9, #0]
    LDRSH  W16, [X9, #0]!
    ADD  X9, X9, X8, ASR #0
    STP  X10, X22, [X9, #0]
    LDRSH  X11, [X9, #0]!
    ADD  X9, X9, X8, LSR #0
    STP  X16, X2, [X9, #0]
    LDRSH  W17, [X9, #0]
    ADD  X9, X9, X8, LSR #0
    STP  X17, X25, [X9, #0]
    LDRSH  X16, [X9, #0]
    ADD  X9, X9, X8
    STP  X25, X11, [X9, #0]
    LDRSH W25, [X9, X20, LSL #0]
    ADD  X9, X9, X8, ASR #0
    STP  X4, X5, [X9, #0]
    LDRSH W11, [X9, W20, SXTW #0]
    ADD  X9, X9, X8, LSR #0
    STP  X25, X16, [X9, #0]
    LDRSH W25, [X9, X20, SXTX #1]
    ADD  X9, X9, X8, ASR #0
    STP  X6, X16, [X9, #0]
    LDRSH W11, [X9, W20, UXTW #0]
    ADD  X9, X9, X8, LSR #0
    STP  X20, X15, [X9, #0]
    LDRSH X6, [X9, X20, LSL #0]
    ADD  X9, X9, X8, ASR #0
    STP  X13, X13, [X9, #0]
    LDRSH X15, [X9, W20, SXTW #0]
    ADD  X9, X9, X8, ASR #0
    STP  X5, X25, [X9, #0]
    LDRSH X5, [X9, X6, SXTX #0]
    ADD  X9, X9, X8
    STP  X13, X18, [X9, #0]
    LDRSH X25, [X9, W20, UXTW #1]
    ADD  X9, X9, X8
    STP  X29, X26, [X9, #0]
    LDRSW  X29, [X9], #0
    ADD  X9, X9, X8
    STP  X6, X22, [X9, #0]
    LDRSW  X4, [X9, #0]!
    ADD  X9, X9, X8
    STP  X6, X18, [X9, #0]
    LDRSW  X22, [X9, #0]
    ADD  X9, X9, X8, ASR #0
    STP  X16, X11, [X9, #0]
    LDRSW X18, [X9, X6, LSL #2]
    ADD  X9, X9, X8, LSR #0
    STP  X17, X25, [X9, #0]
    LDRSW X11, [X9, W22, SXTW #2]
    ADD  X9, X9, X8, ASR #0
    STP  X13, X11, [X9, #0]
    LDRSW X16, [X9, X6, SXTX #0]
    ADD  X9, X9, X8, ASR #0
    STP  X27, X20, [X9, #0]
    LDRSW X6, [X9, W20, UXTW #0]
    ADD  X9, X9, X8, LSR #0
    STP  X6, X29, [X9, #0]
    LDTRSB  W29, [X9, #0]
    ADD  X9, X9, X8
    STP  X15, X15, [X9, #0]
    LDTRSB  X26, [X9, #0]
    ADD  X9, X9, X8, LSR #0
    STP  X16, X29, [X9, #0]
    LDTRSH  W29, [X9, #0]
    ADD  X9, X9, X8, LSR #0
    STP  X2, X18, [X9, #0]
    LDTRSH  X6, [X9, #0]
    ADD  X9, X9, X8, LSR #0
    STP  X29, X26, [X9, #0]
    LDTRSW  X27, [X9, #0]
    ADD  X9, X9, X8, ASR #0
    STP  X4, X10, [X9, #0]
    LDURSB  W17, [X9, #0]
    ADD  X9, X9, X8
    STP  X18, X26, [X9, #0]
    LDURSB  X18, [X9, #0]
    ADD  X9, X9, X8
    STP  X4, X26, [X9, #0]
    LDURSH  W2, [X9, #0]
    ADD  X9, X9, X8
    STP  X15, X22, [X9, #0]
    LDURSH  X10, [X9, #0]
    ADD  X9, X9, X8, LSR #0
    STP  X23, X11, [X9, #0]
    LDURSW  X26, [X9, #0]
    ADD  X9, X9, X8, ASR #0
    STP  X10, X2, [X9, #0]
    LDXP  W2, W4, [X9,#0]
    ADD  X9, X9, X8, LSR #0
    STP  X7, X4, [X9, #0]
    LDXP  X10, X11, [X9,#0]
    ADD  X9, X9, X8, ASR #0
    STP  X18, X18, [X9, #0]
    LDXR  W7, [X9,#0]
    ADD  X9, X9, X8, ASR #0
    STP  X7, X2, [X9, #0]
    LDXR  X7, [X9,#0]
    ADD  X9, X9, X8, LSR #0
    STP  X7, X26, [X9, #0]
    LDXRB  W4, [X9,#0]
    ADD  X9, X9, X8, ASR #0
    STP  X4, X11, [X9, #0]
    LDXRH  W2, [X9,#0]
    ADD  X9, X9, X8, LSR #0
    STRB  W20, [X9, #0]
    LDRB  W18, [X9, #0]
    ADD  X9, X9, X8, LSR #0
    STRB W10, [X9, X18, LSL #0]
    LDRB W15, [X9, X20, LSL #0]
    ADD  X9, X9, X8, ASR #0
    STRB W25, [X9, W22, SXTW #0]
    LDRB W11, [X9, W11, SXTW #0]
    ADD  X9, X9, X8, LSR #0
    STRB W26, [X9, X22, SXTX #0]
    LDRB W18, [X9, X18, SXTX #0]
    ADD  X9, X9, X8
    STRB W25, [X9, W22, UXTW #0]
    LDRB W27, [X9, W17, UXTW #0]
    ADD  X9, X9, X8
    STRH  W26, [X9, #0]
    LDRH  W25, [X9, #0]
    ADD  X9, X9, X8, ASR #0
    STRH W15, [X9, X17, LSL #1]
    LDRH W17, [X9, X17, LSL #1]
    ADD  X9, X9, X8, LSR #0
    STRH W18, [X9, W22, SXTW #0]
    LDRH W26, [X9, W20, SXTW #0]
    ADD  X9, X9, X8, ASR #0
    STRH W2, [X9, X22, SXTX #1]
    LDRH W15, [X9, X22, SXTX #0]
    ADD  X9, X9, X8, ASR #0
    STRH W4, [X9, W20, UXTW #0]
    LDRH W2, [X9, W22, UXTW #1]
    ADD  X9, X9, X8, ASR #0
    STR  W29, [X9, #0]
    LDR  W4, [X9, #0]
    ADD  X9, X9, X8, ASR #0
    STR  X25, [X9, #0]
    LDR  X29, [X9, #0]
    ADD  X9, X9, X8, ASR #0
    STR W2, [X9, X20, LSL #2]
    LDR W2, [X9, X22, LSL #0]
    ADD  X9, X9, X8, ASR #0
    STR W4, [X9, W22, SXTW #2]
    LDR W18, [X9, W20, SXTW #2]
    ADD  X9, X9, X8, LSR #0
    STR W15, [X9, X20, SXTX #2]
    LDR W25, [X9, X20, SXTX #0]
    ADD  X9, X9, X8, LSR #0
    STR W29, [X9, W20, UXTW #2]
    LDR W22, [X9, W20, UXTW #2]
    ADD  X9, X9, X8, LSR #0
    STR X17, [X9, X20, LSL #3]
    LDR X4, [X9, X20, LSL #3]
    ADD  X9, X9, X8, LSR #0
    STR X25, [X9, W20, SXTW #0]
    LDR X15, [X9, W20, SXTW #0]
    ADD  X9, X9, X8, ASR #0
    STR X22, [X9, X20, SXTX #3]
    LDR X22, [X9, X20, SXTX #0]
    ADD  X9, X9, X8
    STR X4, [X9, W20, UXTW #0]
    LDR X29, [X9, W20, UXTW #0]
    ADD  X9, X9, X8
    STP  W29, W15, [X9, #0]
    LDP  W25, W17, [X9, #0]
    ADD  X9, X9, X8, LSR #0
    STP  X22, X17, [X9, #0]
    LDP  X17, X4, [X9, #0]
    ADD  X9, X9, X8, ASR #0
    STTR  W6, [X9, #0]
    LDTR  W6, [X9, #0]
    ADD  X9, X9, X8, ASR #0
    STTR  X4, [X9, #0]
    LDTR  X22, [X9, #0]
    ADD  X9, X9, X8, ASR #0
    STTRB  W25, [X9, #0]
    LDTRB  W23, [X9, #0]
    ADD  X9, X9, X8, ASR #0
    STTRH  W17, [X9, #0]
    LDTRH  W25, [X9, #0]
    ADD  X9, X9, X8, ASR #0
    STUR  W23, [X9, #0]
    LDUR  W4, [X9, #0]
    ADD  X9, X9, X8, ASR #0
    STUR  X20, [X9, #0]
    LDUR  X27, [X9, #0]
    ADD  X9, X9, X8, LSR #0
    STURB  W27, [X9, #0]
    LDURB  W23, [X9, #0]
    ADD  X9, X9, X8
    STURH  W6, [X9, #0]
    LDURH  W29, [X9, #0]
    ADD  X9, X9, X8, ASR #0
    STLR  W4, [X9,#0]
    LDAR  W27, [X9,#0]
    ADD  X9, X9, X8, LSR #0
    STLR  X29, [X9,#0]
    LDAR  X18, [X9,#0]
    ADD  X9, X9, X8, LSR #0
    STLRB  W18, [X9,#0]
    LDARB  W18, [X9,#0]
    ADD  X9, X9, X8
    STLRH  W18, [X9,#0]
    LDARH  W17, [X9,#0]
    ADD  X9, X9, X8, ASR #0
    STNP  W26, W25, [X9, #0]
    LDNP  W26, W18, [X9, #0]
    ADD  X9, X9, X8, LSR #0
    STNP  X17, X26, [X9, #0]
    LDNP  X17, X2, [X9, #0]
    ADD  X9, X9, X8, LSR #0
    STP  W2, W27, [X9], #0
    LDP  W25, W4, [X9], #0
    ADD  X9, X9, X8
    STP  X23, X18, [X9], #0
    LDP  X18, X26, [X9], #0
    ADD  X9, X9, X8
    STP  W25, W17, [X9, #0]!
    LDP  W6, W17, [X9, #0]!
    ADD  X9, X9, X8, ASR #0
    STP  X6, X26, [X9, #0]!
    LDP  X6, X29, [X9, #0]!
    ADD  X9, X9, X8
    STR  W23, [X9], #0
    LDR  W23, [X9], #0
    ADD  X9, X9, X8
    STR  X4, [X9], #0
    LDR  X25, [X9], #0
    ADD  X9, X9, X8, LSR #0
    STR  W23, [X9, #0]!
    LDR  W26, [X9, #0]!
    ADD  X9, X9, X8, ASR #0
    STR  X5, [X9, #0]!
    LDR  X4, [X9, #0]!
    ADD  X9, X9, X8, LSR #0
    STRB  W4, [X9], #0
    LDRB  W4, [X9], #0
    ADD  X9, X9, X8, LSR #0
    STRB  W17, [X9, #0]!
    LDRB  W2, [X9, #0]!
    ADD  X9, X9, X8, ASR #0
    STRH  W18, [X9], #0
    LDRH  W27, [X9], #0
    ADD  X9, X9, X8, LSR #0
    STRH  W25, [X9, #0]!
    LDRH  W5, [X9, #0]!
    ADD  X9, X9, X8, ASR #0
    STP  X2, X2, [X9, #0]
    LDAXP  W18, W2, [X9,#0]
    ADD  X9, X9, X8, ASR #0
    STP  X4, X27, [X9, #0]
    LDAXP  X25, X17, [X9,#0]
    ADD  X9, X9, X8, ASR #0
    STP  X18, X20, [X9, #0]
    LDPSW  X4, X23, [X9], #0
    ADD  X9, X9, X8
    STP  X4, X2, [X9, #0]
    LDPSW  X2, X27, [X9, #0]!
    ADD  X9, X9, X8, ASR #0
    STP  X5, X23, [X9, #0]
    LDAXR  W4, [X9,#0]
    ADD  X9, X9, X8, LSR #0
    STP  X27, X17, [X9, #0]
    LDAXR  X15, [X9,#0]
    ADD  X9, X9, X8
    STP  X15, X2, [X9, #0]
    LDAXRB  W6, [X9,#0]
    ADD  X9, X9, X8, ASR #0
    STP  X25, X25, [X9, #0]
    LDAXRH  W2, [X9,#0]
    ADD  X9, X9, X8
    MOVZ  X24, #0x5a, LSL #0
    SUB  X21, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0x5a, LSL #0
    SUB  X21, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0x5a, LSL #0
    SUB  X21, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0x5a, LSL #0
    SUB  X21, X24, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0x5a, LSL #0
    SUB  X21, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0x5a, LSL #0
    SUB  X21, X24, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X21, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    SUB  X21, X24, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0x5a, LSL #0
    SUB  X21, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0x5a, LSL #0
    SUB  X21, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0x5a, LSL #0
    SUB  X21, X24, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0x5a, LSL #0
    SUB  X21, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
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
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
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
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X15, #0x10, LSL #0
    MOVZ  X7, #0x1900, LSL #0
    ADD  X22, X30, X7, LSR #0
    STP  X24, X27, [X22, #0]
    LDPSW  X29, X5, [X22, #0]
    ADD  X22, X22, X15, LSR #0
    STP  X25, X26, [X22, #0]
    LDRSB  W28, [X22], #0
    ADD  X22, X22, X15, ASR #0
    STP  X29, X29, [X22, #0]
    LDRSB  X25, [X22], #0
    ADD  X22, X22, X15
    STP  X2, X28, [X22, #0]
    LDRSB  W13, [X22, #0]!
    ADD  X22, X22, X15
    STP  X13, X5, [X22, #0]
    LDRSB  X23, [X22, #0]!
    ADD  X22, X22, X15, ASR #0
    STP  X29, X13, [X22, #0]
    LDRSB  W9, [X22, #0]
    ADD  X22, X22, X15, ASR #0
    STP  X13, X5, [X22, #0]
    LDRSB  X27, [X22, #0]
    ADD  X22, X22, X15, LSR #0
    STP  X9, X28, [X22, #0]
    LDRSB W6, [X22, X23, LSL #0]
    ADD  X22, X22, X15
    STP  X4, X26, [X22, #0]
    LDRSB W24, [X22, W23, SXTW #0]
    ADD  X22, X22, X15, ASR #0
    STP  X27, X26, [X22, #0]
    LDRSB W20, [X22, X27, SXTX #0]
    ADD  X22, X22, X15
    STP  X17, X23, [X22, #0]
    LDRSB W29, [X22, W13, UXTW #0]
    ADD  X22, X22, X15
    STP  X5, X5, [X22, #0]
    LDRSB X5, [X22, X27, LSL #0]
    ADD  X22, X22, X15, LSR #0
    STP  X23, X11, [X22, #0]
    LDRSB X11, [X22, W20, SXTW #0]
    ADD  X22, X22, X15, LSR #0
    STP  X6, X16, [X22, #0]
    LDRSB X4, [X22, X20, SXTX #0]
    ADD  X22, X22, X15, ASR #0
    STP  X25, X20, [X22, #0]
    LDRSB X25, [X22, W13, UXTW #0]
    ADD  X22, X22, X15
    STP  X4, X23, [X22, #0]
    LDRSH  W6, [X22], #0
    ADD  X22, X22, X15
    STP  X20, X8, [X22, #0]
    LDRSH  X27, [X22], #0
    ADD  X22, X22, X15
    STP  X16, X29, [X22, #0]
    LDRSH  W13, [X22, #0]!
    ADD  X22, X22, X15, ASR #0
    STP  X11, X2, [X22, #0]
    LDRSH  X11, [X22, #0]!
    ADD  X22, X22, X15
    STP  X28, X23, [X22, #0]
    LDRSH  W4, [X22, #0]
    ADD  X22, X22, X15
    STP  X20, X8, [X22, #0]
    LDRSH  X16, [X22, #0]
    ADD  X22, X22, X15, ASR #0
    STP  X6, X4, [X22, #0]
    LDRSH W8, [X22, X20, LSL #0]
    ADD  X22, X22, X15, ASR #0
    STP  X16, X11, [X22, #0]
    LDRSH W6, [X22, W11, SXTW #1]
    ADD  X22, X22, X15, LSR #0
    STP  X25, X25, [X22, #0]
    LDRSH W16, [X22, X11, SXTX #0]
    ADD  X22, X22, X15, LSR #0
    STP  X13, X8, [X22, #0]
    LDRSH W20, [X22, W27, UXTW #0]
    ADD  X22, X22, X15, LSR #0
    STP  X6, X20, [X22, #0]
    LDRSH X11, [X22, X11, LSL #1]
    ADD  X22, X22, X15, LSR #0
    STP  X18, X24, [X22, #0]
    LDRSH X18, [X22, W23, SXTW #0]
    ADD  X22, X22, X15
    STP  X23, X6, [X22, #0]
    LDRSH X8, [X22, X11, SXTX #1]
    ADD  X22, X22, X15, ASR #0
    STP  X16, X23, [X22, #0]
    LDRSH X23, [X22, W6, UXTW #0]
    ADD  X22, X22, X15, LSR #0
    STP  X9, X25, [X22, #0]
    LDRSW  X24, [X22], #0
    ADD  X22, X22, X15, LSR #0
    STP  X29, X8, [X22, #0]
    LDRSW  X9, [X22, #0]!
    ADD  X22, X22, X15, ASR #0
    STP  X11, X5, [X22, #0]
    LDRSW  X25, [X22, #0]
    ADD  X22, X22, X15, LSR #0
    STP  X20, X20, [X22, #0]
    LDRSW X6, [X22, X2, LSL #0]
    ADD  X22, X22, X15, ASR #0
    STP  X26, X28, [X22, #0]
    LDRSW X28, [X22, W27, SXTW #0]
    ADD  X22, X22, X15, LSR #0
    STP  X25, X6, [X22, #0]
    LDRSW X27, [X22, X11, SXTX #0]
    ADD  X22, X22, X15, ASR #0
    STP  X6, X9, [X22, #0]
    LDRSW X26, [X22, W8, UXTW #2]
    ADD  X22, X22, X15, ASR #0
    STP  X2, X24, [X22, #0]
    LDTRSB  W5, [X22, #0]
    ADD  X22, X22, X15
    STP  X8, X16, [X22, #0]
    LDTRSB  X16, [X22, #0]
    ADD  X22, X22, X15, LSR #0
    STP  X29, X29, [X22, #0]
    LDTRSH  W8, [X22, #0]
    ADD  X22, X22, X15, ASR #0
    STP  X26, X17, [X22, #0]
    LDTRSH  X25, [X22, #0]
    ADD  X22, X22, X15
    STP  X23, X26, [X22, #0]
    LDTRSW  X11, [X22, #0]
    ADD  X22, X22, X15, LSR #0
    STP  X26, X13, [X22, #0]
    LDURSB  W23, [X22, #0]
    ADD  X22, X22, X15, ASR #0
    STP  X11, X11, [X22, #0]
    LDURSB  X17, [X22, #0]
    ADD  X22, X22, X15, LSR #0
    STP  X17, X5, [X22, #0]
    LDURSH  W17, [X22, #0]
    ADD  X22, X22, X15, LSR #0
    STP  X25, X23, [X22, #0]
    LDURSH  X25, [X22, #0]
    ADD  X22, X22, X15, LSR #0
    STP  X5, X8, [X22, #0]
    LDURSW  X23, [X22, #0]
    ADD  X22, X22, X15, ASR #0
    STP  X17, X23, [X22, #0]
    LDXP  W8, W13, [X22,#0]
    ADD  X22, X22, X15, ASR #0
    STP  X13, X9, [X22, #0]
    LDXP  X26, X9, [X22,#0]
    ADD  X22, X22, X15, LSR #0
    STP  X25, X26, [X22, #0]
    LDXR  W5, [X22,#0]
    ADD  X22, X22, X15
    STP  X24, X8, [X22, #0]
    LDXR  X8, [X22,#0]
    ADD  X22, X22, X15, LSR #0
    STP  X4, X9, [X22, #0]
    LDXRB  W17, [X22,#0]
    ADD  X22, X22, X15
    STP  X20, X17, [X22, #0]
    LDXRH  W4, [X22,#0]
    ADD  X22, X22, X15, ASR #0
    STRB  W4, [X22, #0]
    LDRB  W4, [X22, #0]
    ADD  X22, X22, X15
    STRB W4, [X22, X2, LSL #0]
    LDRB W26, [X22, X13, LSL #0]
    ADD  X22, X22, X15, ASR #0
    STRB W26, [X22, W16, SXTW #0]
    LDRB W13, [X22, W23, SXTW #0]
    ADD  X22, X22, X15
    STRB W8, [X22, X2, SXTX #0]
    LDRB W16, [X22, X27, SXTX #0]
    ADD  X22, X22, X15, LSR #0
    STRB W13, [X22, W23, UXTW #0]
    LDRB W9, [X22, W23, UXTW #0]
    ADD  X22, X22, X15
    STRH  W9, [X22, #0]
    LDRH  W4, [X22, #0]
    ADD  X22, X22, X15, LSR #0
    STRH W4, [X22, X23, LSL #0]
    LDRH W13, [X22, X27, LSL #0]
    ADD  X22, X22, X15, ASR #0
    STRH W16, [X22, W27, SXTW #0]
    LDRH W26, [X22, W27, SXTW #1]
    ADD  X22, X22, X15, ASR #0
    STRH W17, [X22, X27, SXTX #0]
    LDRH W16, [X22, X2, SXTX #1]
    ADD  X22, X22, X15, LSR #0
    STRH W26, [X22, W23, UXTW #0]
    LDRH W8, [X22, W23, UXTW #0]
    ADD  X22, X22, X15
    STR  W23, [X22, #0]
    LDR  W17, [X22, #0]
    ADD  X22, X22, X15
    STR  X27, [X22, #0]
    LDR  X26, [X22, #0]
    ADD  X22, X22, X15
    STR W9, [X22, X26, LSL #0]
    LDR W13, [X22, X2, LSL #0]
    ADD  X22, X22, X15
    STR W26, [X22, W27, SXTW #2]
    LDR W9, [X22, W26, SXTW #0]
    ADD  X22, X22, X15
    STR W5, [X22, X27, SXTX #2]
    LDR W26, [X22, X2, SXTX #0]
    ADD  X22, X22, X15
    STR W13, [X22, W17, UXTW #2]
    LDR W23, [X22, W2, UXTW #2]
    ADD  X22, X22, X15, ASR #0
    STR X29, [X22, X27, LSL #0]
    LDR X8, [X22, X27, LSL #3]
    ADD  X22, X22, X15, ASR #0
    STR X28, [X22, W2, SXTW #3]
    LDR X20, [X22, W9, SXTW #0]
    ADD  X22, X22, X15
    STR X24, [X22, X27, SXTX #0]
    LDR X5, [X22, X17, SXTX #3]
    ADD  X22, X22, X15, ASR #0
    STR X5, [X22, W2, UXTW #0]
    LDR X13, [X22, W17, UXTW #3]
    ADD  X22, X22, X15, LSR #0
    STP  W25, W20, [X22, #0]
    LDP  W24, W9, [X22, #0]
    ADD  X22, X22, X15, LSR #0
    STP  X23, X4, [X22, #0]
    LDP  X29, X5, [X22, #0]
    ADD  X22, X22, X15, ASR #0
    STTR  W17, [X22, #0]
    LDTR  W4, [X22, #0]
    ADD  X22, X22, X15
    STTR  X13, [X22, #0]
    LDTR  X27, [X22, #0]
    ADD  X22, X22, X15, ASR #0
    STTRB  W29, [X22, #0]
    LDTRB  W28, [X22, #0]
    ADD  X22, X22, X15, ASR #0
    STTRH  W4, [X22, #0]
    LDTRH  W29, [X22, #0]
    ADD  X22, X22, X15, LSR #0
    STUR  W5, [X22, #0]
    LDUR  W20, [X22, #0]
    ADD  X22, X22, X15
    STUR  X9, [X22, #0]
    LDUR  X13, [X22, #0]
    ADD  X22, X22, X15, LSR #0
    STURB  W24, [X22, #0]
    LDURB  W4, [X22, #0]
    ADD  X22, X22, X15
    STURH  W13, [X22, #0]
    LDURH  W24, [X22, #0]
    ADD  X22, X22, X15, ASR #0
    STLR  W4, [X22,#0]
    LDAR  W5, [X22,#0]
    ADD  X22, X22, X15
    STLR  X28, [X22,#0]
    LDAR  X13, [X22,#0]
    ADD  X22, X22, X15
    STLRB  W13, [X22,#0]
    LDARB  W4, [X22,#0]
    ADD  X22, X22, X15, LSR #0
    STLRH  W5, [X22,#0]
    LDARH  W28, [X22,#0]
    ADD  X22, X22, X15, ASR #0
    STNP  W24, W4, [X22, #0]
    LDNP  W4, W13, [X22, #0]
    ADD  X22, X22, X15, ASR #0
    STNP  X28, X28, [X22, #0]
    LDNP  X9, X28, [X22, #0]
    ADD  X22, X22, X15
    STP  W11, W13, [X22], #0
    LDP  W13, W24, [X22], #0
    ADD  X22, X22, X15, LSR #0
    STP  X28, X5, [X22], #0
    LDP  X27, X11, [X22], #0
    ADD  X22, X22, X15
    STP  W4, W4, [X22, #0]!
    LDP  W17, W4, [X22, #0]!
    ADD  X22, X22, X15, LSR #0
    STP  X17, X9, [X22, #0]!
    LDP  X17, X28, [X22, #0]!
    ADD  X22, X22, X15, LSR #0
    STR  W4, [X22], #0
    LDR  W5, [X22], #0
    ADD  X22, X22, X15, ASR #0
    STR  X27, [X22], #0
    LDR  X4, [X22], #0
    ADD  X22, X22, X15, LSR #0
    STR  W11, [X22, #0]!
    LDR  W27, [X22, #0]!
    ADD  X22, X22, X15, LSR #0
    STR  X17, [X22, #0]!
    LDR  X9, [X22, #0]!
    ADD  X22, X22, X15
    STRB  W4, [X22], #0
    LDRB  W4, [X22], #0
    ADD  X22, X22, X15, ASR #0
    STRB  W27, [X22, #0]!
    LDRB  W17, [X22, #0]!
    ADD  X22, X22, X15
    STRH  W9, [X22], #0
    LDRH  W9, [X22], #0
    ADD  X22, X22, X15, LSR #0
    STRH  W4, [X22, #0]!
    LDRH  W27, [X22, #0]!
    ADD  X22, X22, X15
    STP  X17, X9, [X22, #0]
    LDAXP  W9, W11, [X22,#0]
    ADD  X22, X22, X15, ASR #0
    STP  X9, X5, [X22, #0]
    LDAXP  X4, X5, [X22,#0]
    ADD  X22, X22, X15
    STP  X13, X16, [X22, #0]
    LDPSW  X9, X13, [X22], #0
    ADD  X22, X22, X15
    STP  X5, X23, [X22, #0]
    LDPSW  X17, X23, [X22, #0]!
    ADD  X22, X22, X15, LSR #0
    STP  X4, X11, [X22, #0]
    LDAXR  W5, [X22,#0]
    ADD  X22, X22, X15, ASR #0
    STP  X27, X27, [X22, #0]
    LDAXR  X27, [X22,#0]
    ADD  X22, X22, X15
    STP  X17, X13, [X22, #0]
    LDAXRB  W16, [X22,#0]
    ADD  X22, X22, X15
    STP  X5, X27, [X22, #0]
    LDAXRH  W18, [X22,#0]
    ADD  X22, X22, X15, LSR #0
    MOVZ  X21, #0xa5, LSL #0
    SUB  X10, X21, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0xa5, LSL #0
    SUB  X10, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X10, X21, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0xffa5, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0xffa5, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X10, X21, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0xa5, LSL #0
    SUB  X10, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    SUB  X10, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0xa5, LSL #0
    SUB  X10, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X10, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0xa5, LSL #0
    SUB  X10, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0xa5, LSL #0
    SUB  X10, X21, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X10, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X10, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0xa5, LSL #0
    SUB  X10, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X10, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0xa5, LSL #0
    SUB  X10, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X10, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
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
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
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
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X4, #0x10, LSL #0
    MOVZ  X26, #0x1e00, LSL #0
    ADD  X11, X30, X26, LSR #0
    STP  X25, X27, [X11, #0]
    LDPSW  X18, X24, [X11, #0]
    ADD  X11, X11, X4, ASR #0
    STP  X28, X7, [X11, #0]
    LDRSB  W15, [X11], #0
    ADD  X11, X11, X4, LSR #0
    STP  X18, X15, [X11, #0]
    LDRSB  X21, [X11], #0
    ADD  X11, X11, X4, LSR #0
    STP  X13, X21, [X11, #0]
    LDRSB  W23, [X11, #0]!
    ADD  X11, X11, X4, ASR #0
    STP  X23, X24, [X11, #0]
    LDRSB  X23, [X11, #0]!
    ADD  X11, X11, X4, LSR #0
    STP  X5, X5, [X11, #0]
    LDRSB  W9, [X11, #0]
    ADD  X11, X11, X4, ASR #0
    STP  X16, X5, [X11, #0]
    LDRSB  X18, [X11, #0]
    ADD  X11, X11, X4, LSR #0
    STP  X27, X20, [X11, #0]
    LDRSB W7, [X11, X13, LSL #0]
    ADD  X11, X11, X4
    STP  X25, X24, [X11, #0]
    LDRSB W25, [X11, W23, SXTW #0]
    ADD  X11, X11, X4, LSR #0
    STP  X28, X9, [X11, #0]
    LDRSB W21, [X11, X13, SXTX #0]
    ADD  X11, X11, X4, ASR #0
    STP  X21, X7, [X11, #0]
    LDRSB W16, [X11, W13, UXTW #0]
    ADD  X11, X11, X4, LSR #0
    STP  X5, X5, [X11, #0]
    LDRSB X24, [X11, X13, LSL #0]
    ADD  X11, X11, X4, LSR #0
    STP  X17, X25, [X11, #0]
    LDRSB X23, [X11, W13, SXTW #0]
    ADD  X11, X11, X4, ASR #0
    STP  X7, X7, [X11, #0]
    LDRSB X21, [X11, X13, SXTX #0]
    ADD  X11, X11, X4, ASR #0
    STP  X16, X27, [X11, #0]
    LDRSB X5, [X11, W13, UXTW #0]
    ADD  X11, X11, X4, ASR #0
    STP  X17, X6, [X11, #0]
    LDRSH  W20, [X11], #0
    ADD  X11, X11, X4, ASR #0
    STP  X10, X16, [X11, #0]
    LDRSH  X7, [X11], #0
    ADD  X11, X11, X4, ASR #0
    STP  X21, X13, [X11, #0]
    LDRSH  W9, [X11, #0]!
    ADD  X11, X11, X4, LSR #0
    STP  X28, X16, [X11, #0]
    LDRSH  X9, [X11, #0]!
    ADD  X11, X11, X4, LSR #0
    STP  X6, X22, [X11, #0]
    LDRSH  W25, [X11, #0]
    ADD  X11, X11, X4, LSR #0
    STP  X23, X27, [X11, #0]
    LDRSH  X6, [X11, #0]
    ADD  X11, X11, X4, LSR #0
    STP  X15, X21, [X11, #0]
    LDRSH W8, [X11, X13, LSL #0]
    ADD  X11, X11, X4, LSR #0
    STP  X5, X20, [X11, #0]
    LDRSH W23, [X11, W13, SXTW #0]
    ADD  X11, X11, X4
    STP  X18, X6, [X11, #0]
    LDRSH W27, [X11, X13, SXTX #0]
    ADD  X11, X11, X4, ASR #0
    STP  X7, X9, [X11, #0]
    LDRSH W21, [X11, W13, UXTW #0]
    ADD  X11, X11, X4
    STP  X8, X8, [X11, #0]
    LDRSH X20, [X11, X13, LSL #1]
    ADD  X11, X11, X4, LSR #0
    STP  X25, X25, [X11, #0]
    LDRSH X22, [X11, W13, SXTW #1]
    ADD  X11, X11, X4
    STP  X20, X23, [X11, #0]
    LDRSH X7, [X11, X13, SXTX #0]
    ADD  X11, X11, X4
    STP  X22, X7, [X11, #0]
    LDRSH X9, [X11, W13, UXTW #1]
    ADD  X11, X11, X4, LSR #0
    STP  X24, X8, [X11, #0]
    LDRSW  X15, [X11], #0
    ADD  X11, X11, X4, ASR #0
    STP  X21, X21, [X11, #0]
    LDRSW  X8, [X11, #0]!
    ADD  X11, X11, X4
    STP  X9, X9, [X11, #0]
    LDRSW  X23, [X11, #0]
    ADD  X11, X11, X4, LSR #0
    STP  X8, X15, [X11, #0]
    LDRSW X20, [X11, X13, LSL #2]
    ADD  X11, X11, X4, LSR #0
    STP  X23, X23, [X11, #0]
    LDRSW X25, [X11, W13, SXTW #0]
    ADD  X11, X11, X4, ASR #0
    STP  X20, X20, [X11, #0]
    LDRSW X21, [X11, X13, SXTX #2]
    ADD  X11, X11, X4, ASR #0
    STP  X27, X24, [X11, #0]
    LDRSW X23, [X11, W13, UXTW #2]
    ADD  X11, X11, X4, ASR #0
    STP  X22, X24, [X11, #0]
    LDTRSB  W22, [X11, #0]
    ADD  X11, X11, X4, LSR #0
    STP  X13, X24, [X11, #0]
    LDTRSB  X8, [X11, #0]
    ADD  X11, X11, X4, ASR #0
    STP  X20, X23, [X11, #0]
    LDTRSH  W27, [X11, #0]
    ADD  X11, X11, X4, LSR #0
    STP  X7, X23, [X11, #0]
    LDTRSH  X7, [X11, #0]
    ADD  X11, X11, X4, LSR #0
    STP  X6, X15, [X11, #0]
    LDTRSW  X24, [X11, #0]
    ADD  X11, X11, X4
    STP  X9, X7, [X11, #0]
    LDURSB  W8, [X11, #0]
    ADD  X11, X11, X4, ASR #0
    STP  X8, X16, [X11, #0]
    LDURSB  X15, [X11, #0]
    ADD  X11, X11, X4, LSR #0
    STP  X24, X21, [X11, #0]
    LDURSH  W24, [X11, #0]
    ADD  X11, X11, X4, ASR #0
    STP  X25, X13, [X11, #0]
    LDURSH  X23, [X11, #0]
    ADD  X11, X11, X4
    STP  X5, X20, [X11, #0]
    LDURSW  X7, [X11, #0]
    ADD  X11, X11, X4, ASR #0
    STP  X6, X15, [X11, #0]
    LDXP  W15, W20, [X11,#0]
    ADD  X11, X11, X4
    STP  X10, X13, [X11, #0]
    LDXP  X21, X25, [X11,#0]
    ADD  X11, X11, X4, ASR #0
    STP  X20, X23, [X11, #0]
    LDXR  W6, [X11,#0]
    ADD  X11, X11, X4
    STP  X27, X6, [X11, #0]
    LDXR  X6, [X11,#0]
    ADD  X11, X11, X4, ASR #0
    STP  X7, X21, [X11, #0]
    LDXRB  W10, [X11,#0]
    ADD  X11, X11, X4
    STP  X24, X6, [X11, #0]
    LDXRH  W7, [X11,#0]
    ADD  X11, X11, X4
    STRB  W10, [X11, #0]
    LDRB  W10, [X11, #0]
    ADD  X11, X11, X4, ASR #0
    STRB W25, [X11, X25, LSL #0]
    LDRB W20, [X11, X13, LSL #0]
    ADD  X11, X11, X4
    STRB W7, [X11, W25, SXTW #0]
    LDRB W25, [X11, W20, SXTW #0]
    ADD  X11, X11, X4
    STRB W10, [X11, X20, SXTX #0]
    LDRB W7, [X11, X20, SXTX #0]
    ADD  X11, X11, X4
    STRB W25, [X11, W20, UXTW #0]
    LDRB W23, [X11, W20, UXTW #0]
    ADD  X11, X11, X4, LSR #0
    STRH  W27, [X11, #0]
    LDRH  W21, [X11, #0]
    ADD  X11, X11, X4
    STRH W7, [X11, X20, LSL #0]
    LDRH W9, [X11, X13, LSL #0]
    ADD  X11, X11, X4, ASR #0
    STRH W9, [X11, W20, SXTW #1]
    LDRH W10, [X11, W13, SXTW #0]
    ADD  X11, X11, X4, ASR #0
    STRH W21, [X11, X13, SXTX #1]
    LDRH W6, [X11, X20, SXTX #1]
    ADD  X11, X11, X4, LSR #0
    STRH W23, [X11, W13, UXTW #1]
    LDRH W25, [X11, W13, UXTW #0]
    ADD  X11, X11, X4, ASR #0
    STR  W10, [X11, #0]
    LDR  W20, [X11, #0]
    ADD  X11, X11, X4
    STR  X20, [X11, #0]
    LDR  X20, [X11, #0]
    ADD  X11, X11, X4
    STR W17, [X11, X13, LSL #0]
    LDR W10, [X11, X13, LSL #2]
    ADD  X11, X11, X4, ASR #0
    STR W6, [X11, W13, SXTW #0]
    LDR W23, [X11, W13, SXTW #0]
    ADD  X11, X11, X4
    STR W10, [X11, X13, SXTX #0]
    LDR W10, [X11, X13, SXTX #2]
    ADD  X11, X11, X4, ASR #0
    STR W25, [X11, W13, UXTW #2]
    LDR W17, [X11, W13, UXTW #0]
    ADD  X11, X11, X4
    STR X23, [X11, X13, LSL #0]
    LDR X6, [X11, X13, LSL #0]
    ADD  X11, X11, X4, LSR #0
    STR X20, [X11, W13, SXTW #3]
    LDR X20, [X11, W13, SXTW #3]
    ADD  X11, X11, X4, ASR #0
    STR X6, [X11, X13, SXTX #3]
    LDR X15, [X11, X13, SXTX #3]
    ADD  X11, X11, X4, ASR #0
    STR X10, [X11, W13, UXTW #0]
    LDR X25, [X11, W13, UXTW #0]
    ADD  X11, X11, X4, ASR #0
    STP  W20, W25, [X11, #0]
    LDP  W23, W16, [X11, #0]
    ADD  X11, X11, X4, LSR #0
    STP  X17, X15, [X11, #0]
    LDP  X6, X15, [X11, #0]
    ADD  X11, X11, X4
    STTR  W23, [X11, #0]
    LDTR  W20, [X11, #0]
    ADD  X11, X11, X4
    STTR  X16, [X11, #0]
    LDTR  X16, [X11, #0]
    ADD  X11, X11, X4
    STTRB  W16, [X11, #0]
    LDTRB  W16, [X11, #0]
    ADD  X11, X11, X4, ASR #0
    STTRH  W16, [X11, #0]
    LDTRH  W17, [X11, #0]
    ADD  X11, X11, X4, LSR #0
    STUR  W24, [X11, #0]
    LDUR  W16, [X11, #0]
    ADD  X11, X11, X4, LSR #0
    STUR  X15, [X11, #0]
    LDUR  X24, [X11, #0]
    ADD  X11, X11, X4
    STURB  W16, [X11, #0]
    LDURB  W21, [X11, #0]
    ADD  X11, X11, X4
    STURH  W20, [X11, #0]
    LDURH  W15, [X11, #0]
    ADD  X11, X11, X4, LSR #0
    STLR  W21, [X11,#0]
    LDAR  W20, [X11,#0]
    ADD  X11, X11, X4, ASR #0
    STLR  X15, [X11,#0]
    LDAR  X15, [X11,#0]
    ADD  X11, X11, X4, ASR #0
    STLRB  W24, [X11,#0]
    LDARB  W16, [X11,#0]
    ADD  X11, X11, X4, LSR #0
    STLRH  W15, [X11,#0]
    LDARH  W24, [X11,#0]
    ADD  X11, X11, X4
    STNP  W24, W20, [X11, #0]
    LDNP  W20, W15, [X11, #0]
    ADD  X11, X11, X4
    STNP  X18, X15, [X11, #0]
    LDNP  X24, X21, [X11, #0]
    ADD  X11, X11, X4
    STP  W24, W16, [X11], #0
    LDP  W24, W18, [X11], #0
    ADD  X11, X11, X4
    STP  X21, X20, [X11], #0
    LDP  X20, X16, [X11], #0
    ADD  X11, X11, X4
    STP  W24, W24, [X11, #0]!
    LDP  W15, W22, [X11, #0]!
    ADD  X11, X11, X4
    STP  X24, X28, [X11, #0]!
    LDP  X21, X27, [X11, #0]!
    ADD  X11, X11, X4
    STR  W20, [X11], #0
    LDR  W28, [X11], #0
    ADD  X11, X11, X4, ASR #0
    STR  X25, [X11], #0
    LDR  X24, [X11], #0
    ADD  X11, X11, X4
    STR  W24, [X11, #0]!
    LDR  W24, [X11, #0]!
    ADD  X11, X11, X4
    STR  X15, [X11, #0]!
    LDR  X9, [X11, #0]!
    ADD  X11, X11, X4
    STRB  W22, [X11], #0
    LDRB  W22, [X11], #0
    ADD  X11, X11, X4, ASR #0
    STRB  W24, [X11, #0]!
    LDRB  W25, [X11, #0]!
    ADD  X11, X11, X4
    STRH  W22, [X11], #0
    LDRH  W22, [X11], #0
    ADD  X11, X11, X4
    STRH  W28, [X11, #0]!
    LDRH  W28, [X11, #0]!
    ADD  X11, X11, X4, ASR #0
    STP  X9, X25, [X11, #0]
    LDAXP  W20, W9, [X11,#0]
    ADD  X11, X11, X4, ASR #0
    STP  X9, X27, [X11, #0]
    LDAXP  X15, X24, [X11,#0]
    ADD  X11, X11, X4, LSR #0
    STP  X22, X24, [X11, #0]
    LDPSW  X9, X22, [X11], #0
    ADD  X11, X11, X4
    STP  X20, X15, [X11, #0]
    LDPSW  X6, X25, [X11, #0]!
    ADD  X11, X11, X4, ASR #0
    STP  X28, X20, [X11, #0]
    LDAXR  W28, [X11,#0]
    ADD  X11, X11, X4
    STP  X25, X5, [X11, #0]
    LDAXR  X20, [X11,#0]
    ADD  X11, X11, X4, LSR #0
    STP  X6, X28, [X11, #0]
    LDAXRB  W25, [X11,#0]
    ADD  X11, X11, X4, LSR #0
    STP  X25, X25, [X11, #0]
    LDAXRH  W5, [X11,#0]
    ADD  X11, X11, X4, ASR #0
    MOVZ  X2, #0x5a, LSL #0
    SUB  X29, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X29, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X29, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X29, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X29, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    SUB  X29, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X29, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X29, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X29, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X29, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X29, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X29, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X29, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X29, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X29, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X29, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X29, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X29, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
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
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
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
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X13, #0x10, LSL #0
    MOVZ  X21, #0x2300, LSL #0
    ADD  X7, X30, X21, ASR #0
    STP  X27, X27, [X7, #0]
    LDPSW  X6, X22, [X7, #0]
    ADD  X7, X7, X13, ASR #0
    STP  X22, X25, [X7, #0]
    LDRSB  W5, [X7], #0
    ADD  X7, X7, X13
    STP  X26, X6, [X7, #0]
    LDRSB  X25, [X7], #0
    ADD  X7, X7, X13
    STP  X9, X5, [X7, #0]
    LDRSB  W5, [X7, #0]!
    ADD  X7, X7, X13, ASR #0
    STP  X5, X5, [X7, #0]
    LDRSB  X15, [X7, #0]!
    ADD  X7, X7, X13, ASR #0
    STP  X26, X20, [X7, #0]
    LDRSB  W8, [X7, #0]
    ADD  X7, X7, X13, LSR #0
    STP  X16, X25, [X7, #0]
    LDRSB  X25, [X7, #0]
    ADD  X7, X7, X13
    STP  X16, X15, [X7, #0]
    LDRSB W4, [X7, X9, LSL #0]
    ADD  X7, X7, X13
    STP  X25, X17, [X7, #0]
    LDRSB W20, [X7, W9, SXTW #0]
    ADD  X7, X7, X13
    STP  X20, X4, [X7, #0]
    LDRSB W26, [X7, X9, SXTX #0]
    ADD  X7, X7, X13, LSR #0
    STP  X23, X9, [X7, #0]
    LDRSB W4, [X7, W5, UXTW #0]
    ADD  X7, X7, X13, LSR #0
    STP  X4, X29, [X7, #0]
    LDRSB X5, [X7, X9, LSL #0]
    ADD  X7, X7, X13, ASR #0
    STP  X2, X17, [X7, #0]
    LDRSB X15, [X7, W9, SXTW #0]
    ADD  X7, X7, X13
    STP  X26, X9, [X7, #0]
    LDRSB X2, [X7, X9, SXTX #0]
    ADD  X7, X7, X13, ASR #0
    STP  X10, X2, [X7, #0]
    LDRSB X10, [X7, W9, UXTW #0]
    ADD  X7, X7, X13, LSR #0
    STP  X11, X6, [X7, #0]
    LDRSH  W2, [X7], #0
    ADD  X7, X7, X13
    STP  X9, X16, [X7, #0]
    LDRSH  X16, [X7], #0
    ADD  X7, X7, X13, LSR #0
    STP  X9, X11, [X7, #0]
    LDRSH  W17, [X7, #0]!
    ADD  X7, X7, X13, LSR #0
    STP  X2, X4, [X7, #0]
    LDRSH  X11, [X7, #0]!
    ADD  X7, X7, X13, LSR #0
    STP  X10, X10, [X7, #0]
    LDRSH  W6, [X7, #0]
    ADD  X7, X7, X13, ASR #0
    STP  X9, X20, [X7, #0]
    LDRSH  X4, [X7, #0]
    ADD  X7, X7, X13
    STP  X4, X20, [X7, #0]
    LDRSH W4, [X7, X4, LSL #1]
    ADD  X7, X7, X13, LSR #0
    STP  X9, X9, [X7, #0]
    LDRSH W10, [X7, W9, SXTW #1]
    ADD  X7, X7, X13, LSR #0
    STP  X10, X10, [X7, #0]
    LDRSH W10, [X7, X17, SXTX #0]
    ADD  X7, X7, X13, LSR #0
    STP  X29, X9, [X7, #0]
    LDRSH W2, [X7, W16, UXTW #0]
    ADD  X7, X7, X13
    STP  X22, X25, [X7, #0]
    LDRSH X29, [X7, X17, LSL #0]
    ADD  X7, X7, X13, ASR #0
    STP  X18, X5, [X7, #0]
    LDRSH X5, [X7, W16, SXTW #1]
    ADD  X7, X7, X13, LSR #0
    STP  X5, X4, [X7, #0]
    LDRSH X27, [X7, X17, SXTX #1]
    ADD  X7, X7, X13, ASR #0
    STP  X20, X4, [X7, #0]
    LDRSH X2, [X7, W9, UXTW #0]
    ADD  X7, X7, X13, ASR #0
    STP  X26, X6, [X7, #0]
    LDRSW  X17, [X7], #0
    ADD  X7, X7, X13, ASR #0
    STP  X29, X4, [X7, #0]
    LDRSW  X20, [X7, #0]!
    ADD  X7, X7, X13, LSR #0
    STP  X11, X15, [X7, #0]
    LDRSW  X26, [X7, #0]
    ADD  X7, X7, X13, LSR #0
    STP  X29, X11, [X7, #0]
    LDRSW X15, [X7, X4, LSL #0]
    ADD  X7, X7, X13
    STP  X10, X16, [X7, #0]
    LDRSW X6, [X7, W4, SXTW #2]
    ADD  X7, X7, X13, ASR #0
    STP  X23, X29, [X7, #0]
    LDRSW X11, [X7, X9, SXTX #0]
    ADD  X7, X7, X13
    STP  X15, X17, [X7, #0]
    LDRSW X29, [X7, W16, UXTW #2]
    ADD  X7, X7, X13
    STP  X6, X27, [X7, #0]
    LDTRSB  W6, [X7, #0]
    ADD  X7, X7, X13
    STP  X11, X6, [X7, #0]
    LDTRSB  X6, [X7, #0]
    ADD  X7, X7, X13, LSR #0
    STP  X6, X29, [X7, #0]
    LDTRSH  W16, [X7, #0]
    ADD  X7, X7, X13, LSR #0
    STP  X16, X16, [X7, #0]
    LDTRSH  X10, [X7, #0]
    ADD  X7, X7, X13, ASR #0
    STP  X5, X10, [X7, #0]
    LDTRSW  X29, [X7, #0]
    ADD  X7, X7, X13, ASR #0
    STP  X29, X26, [X7, #0]
    LDURSB  W4, [X7, #0]
    ADD  X7, X7, X13, LSR #0
    STP  X6, X20, [X7, #0]
    LDURSB  X26, [X7, #0]
    ADD  X7, X7, X13
    STP  X23, X11, [X7, #0]
    LDURSH  W20, [X7, #0]
    ADD  X7, X7, X13, ASR #0
    STP  X5, X16, [X7, #0]
    LDURSH  X2, [X7, #0]
    ADD  X7, X7, X13
    STP  X16, X29, [X7, #0]
    LDURSW  X6, [X7, #0]
    ADD  X7, X7, X13
    STP  X16, X26, [X7, #0]
    LDXP  W10, W5, [X7,#0]
    ADD  X7, X7, X13, LSR #0
    STP  X22, X23, [X7, #0]
    LDXP  X23, X26, [X7,#0]
    ADD  X7, X7, X13
    STP  X5, X2, [X7, #0]
    LDXR  W29, [X7,#0]
    ADD  X7, X7, X13, LSR #0
    STP  X10, X29, [X7, #0]
    LDXR  X11, [X7,#0]
    ADD  X7, X7, X13
    STP  X6, X6, [X7, #0]
    LDXRB  W6, [X7,#0]
    ADD  X7, X7, X13, LSR #0
    STP  X26, X6, [X7, #0]
    LDXRH  W15, [X7,#0]
    ADD  X7, X7, X13
    STRB  W23, [X7, #0]
    LDRB  W10, [X7, #0]
    ADD  X7, X7, X13
    STRB W10, [X7, X29, LSL #0]
    LDRB W2, [X7, X5, LSL #0]
    ADD  X7, X7, X13, ASR #0
    STRB W5, [X7, W29, SXTW #0]
    LDRB W6, [X7, W29, SXTW #0]
    ADD  X7, X7, X13, LSR #0
    STRB W15, [X7, X6, SXTX #0]
    LDRB W10, [X7, X5, SXTX #0]
    ADD  X7, X7, X13, LSR #0
    STRB W11, [X7, W29, UXTW #0]
    LDRB W6, [X7, W5, UXTW #0]
    ADD  X7, X7, X13, LSR #0
    STRH  W2, [X7, #0]
    LDRH  W26, [X7, #0]
    ADD  X7, X7, X13, ASR #0
    STRH W10, [X7, X5, LSL #0]
    LDRH W15, [X7, X9, LSL #1]
    ADD  X7, X7, X13
    STRH W26, [X7, W5, SXTW #0]
    LDRH W5, [X7, W29, SXTW #0]
    ADD  X7, X7, X13, ASR #0
    STRH W6, [X7, X9, SXTX #1]
    LDRH W2, [X7, X29, SXTX #0]
    ADD  X7, X7, X13
    STRH W15, [X7, W29, UXTW #1]
    LDRH W11, [X7, W29, UXTW #1]
    ADD  X7, X7, X13, ASR #0
    STR  W27, [X7, #0]
    LDR  W27, [X7, #0]
    ADD  X7, X7, X13, ASR #0
    STR  X5, [X7, #0]
    LDR  X6, [X7, #0]
    ADD  X7, X7, X13, ASR #0
    STR W2, [X7, X9, LSL #2]
    LDR W23, [X7, X9, LSL #0]
    ADD  X7, X7, X13
    STR W23, [X7, W9, SXTW #0]
    LDR W26, [X7, W29, SXTW #2]
    ADD  X7, X7, X13, ASR #0
    STR W18, [X7, X29, SXTX #2]
    LDR W5, [X7, X29, SXTX #0]
    ADD  X7, X7, X13, LSR #0
    STR W5, [X7, W9, UXTW #2]
    LDR W2, [X7, W9, UXTW #2]
    ADD  X7, X7, X13
    STR X6, [X7, X9, LSL #3]
    LDR X5, [X7, X29, LSL #3]
    ADD  X7, X7, X13, LSR #0
    STR X27, [X7, W9, SXTW #0]
    LDR X27, [X7, W29, SXTW #0]
    ADD  X7, X7, X13
    STR X26, [X7, X29, SXTX #3]
    LDR X18, [X7, X29, SXTX #0]
    ADD  X7, X7, X13, LSR #0
    STR X2, [X7, W29, UXTW #0]
    LDR X6, [X7, W29, UXTW #3]
    ADD  X7, X7, X13, LSR #0
    STP  W27, W27, [X7, #0]
    LDP  W26, W2, [X7, #0]
    ADD  X7, X7, X13
    STP  X9, X6, [X7, #0]
    LDP  X6, X27, [X7, #0]
    ADD  X7, X7, X13, LSR #0
    STTR  W18, [X7, #0]
    LDTR  W18, [X7, #0]
    ADD  X7, X7, X13, ASR #0
    STTR  X2, [X7, #0]
    LDTR  X2, [X7, #0]
    ADD  X7, X7, X13, LSR #0
    STTRB  W26, [X7, #0]
    LDTRB  W29, [X7, #0]
    ADD  X7, X7, X13
    STTRH  W6, [X7, #0]
    LDTRH  W26, [X7, #0]
    ADD  X7, X7, X13, LSR #0
    STUR  W29, [X7, #0]
    LDUR  W8, [X7, #0]
    ADD  X7, X7, X13, LSR #0
    STUR  X2, [X7, #0]
    LDUR  X2, [X7, #0]
    ADD  X7, X7, X13
    STURB  W26, [X7, #0]
    LDURB  W18, [X7, #0]
    ADD  X7, X7, X13
    STURH  W18, [X7, #0]
    LDURH  W16, [X7, #0]
    ADD  X7, X7, X13, LSR #0
    STLR  W2, [X7,#0]
    LDAR  W26, [X7,#0]
    ADD  X7, X7, X13, LSR #0
    STLR  X8, [X7,#0]
    LDAR  X18, [X7,#0]
    ADD  X7, X7, X13, ASR #0
    STLRB  W26, [X7,#0]
    LDARB  W2, [X7,#0]
    ADD  X7, X7, X13
    STLRH  W6, [X7,#0]
    LDARH  W8, [X7,#0]
    ADD  X7, X7, X13, ASR #0
    STNP  W11, W15, [X7, #0]
    LDNP  W26, W29, [X7, #0]
    ADD  X7, X7, X13, ASR #0
    STNP  X29, X29, [X7, #0]
    LDNP  X29, X6, [X7, #0]
    ADD  X7, X7, X13, LSR #0
    STP  W16, W6, [X7], #0
    LDP  W6, W16, [X7], #0
    ADD  X7, X7, X13, LSR #0
    STP  X18, X16, [X7], #0
    LDP  X18, X16, [X7], #0
    ADD  X7, X7, X13, ASR #0
    STP  W6, W6, [X7, #0]!
    LDP  W6, W16, [X7, #0]!
    ADD  X7, X7, X13, LSR #0
    STP  X8, X29, [X7, #0]!
    LDP  X23, X29, [X7, #0]!
    ADD  X7, X7, X13, ASR #0
    STR  W23, [X7], #0
    LDR  W8, [X7], #0
    ADD  X7, X7, X13, ASR #0
    STR  X18, [X7], #0
    LDR  X23, [X7], #0
    ADD  X7, X7, X13
    STR  W16, [X7, #0]!
    LDR  W18, [X7, #0]!
    ADD  X7, X7, X13, LSR #0
    STR  X8, [X7, #0]!
    LDR  X8, [X7, #0]!
    ADD  X7, X7, X13, LSR #0
    STRB  W29, [X7], #0
    LDRB  W29, [X7], #0
    ADD  X7, X7, X13, LSR #0
    STRB  W23, [X7, #0]!
    LDRB  W18, [X7, #0]!
    ADD  X7, X7, X13
    STRH  W18, [X7], #0
    LDRH  W4, [X7], #0
    ADD  X7, X7, X13, ASR #0
    STRH  W6, [X7, #0]!
    LDRH  W4, [X7, #0]!
    ADD  X7, X7, X13, LSR #0
    STP  X29, X4, [X7, #0]
    LDAXP  W29, W25, [X7,#0]
    ADD  X7, X7, X13, LSR #0
    STP  X9, X10, [X7, #0]
    LDAXP  X26, X2, [X7,#0]
    ADD  X7, X7, X13
    STP  X17, X4, [X7, #0]
    LDPSW  X16, X23, [X7], #0
    ADD  X7, X7, X13, ASR #0
    STP  X22, X2, [X7, #0]
    LDPSW  X29, X11, [X7, #0]!
    ADD  X7, X7, X13
    STP  X29, X18, [X7, #0]
    LDAXR  W10, [X7,#0]
    ADD  X7, X7, X13
    STP  X26, X18, [X7, #0]
    LDAXR  X25, [X7,#0]
    ADD  X7, X7, X13, LSR #0
    STP  X16, X27, [X7, #0]
    LDAXRB  W4, [X7,#0]
    ADD  X7, X7, X13, LSR #0
    STP  X11, X15, [X7, #0]
    LDAXRH  W4, [X7,#0]
    ADD  X7, X7, X13
    MOVZ  X24, #0xa5, LSL #0
    SUB  X28, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0xffff, LSL #0
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0xa5, LSL #0
    SUB  X28, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    SUB  X28, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0xa5, LSL #0
    SUB  X28, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0xffa5, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0xffa5, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0xa5, LSL #0
    SUB  X28, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X28, X24, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X23
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    SUB  X28, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
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
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
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
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X7, #0x10, LSL #0
    MOVZ  X28, #0x2800, LSL #0
    ADD  X8, X30, X28, ASR #0
    STP  X29, X13, [X8, #0]
    LDPSW  X5, X26, [X8, #0]
    ADD  X8, X8, X7, ASR #0
    STP  X5, X27, [X8, #0]
    LDRSB  W26, [X8], #0
    ADD  X8, X8, X7
    STP  X26, X20, [X8, #0]
    LDRSB  X11, [X8], #0
    ADD  X8, X8, X7, LSR #0
    STP  X11, X11, [X8, #0]
    LDRSB  W23, [X8, #0]!
    ADD  X8, X8, X7
    STP  X11, X22, [X8, #0]
    LDRSB  X11, [X8, #0]!
    ADD  X8, X8, X7, ASR #0
    STP  X23, X29, [X8, #0]
    LDRSB  W5, [X8, #0]
    ADD  X8, X8, X7
    STP  X13, X27, [X8, #0]
    LDRSB  X26, [X8, #0]
    ADD  X8, X8, X7
    STP  X24, X6, [X8, #0]
    LDRSB W13, [X8, X20, LSL #0]
    ADD  X8, X8, X7, ASR #0
    STP  X17, X23, [X8, #0]
    LDRSB W11, [X8, W20, SXTW #0]
    ADD  X8, X8, X7, ASR #0
    STP  X5, X20, [X8, #0]
    LDRSB W9, [X8, X20, SXTX #0]
    ADD  X8, X8, X7
    STP  X17, X18, [X8, #0]
    LDRSB W2, [X8, W20, UXTW #0]
    ADD  X8, X8, X7, LSR #0
    STP  X13, X5, [X8, #0]
    LDRSB X24, [X8, X20, LSL #0]
    ADD  X8, X8, X7
    STP  X18, X9, [X8, #0]
    LDRSB X24, [X8, W20, SXTW #0]
    ADD  X8, X8, X7, LSR #0
    STP  X23, X5, [X8, #0]
    LDRSB X11, [X8, X20, SXTX #0]
    ADD  X8, X8, X7, ASR #0
    STP  X26, X27, [X8, #0]
    LDRSB X29, [X8, W20, UXTW #0]
    ADD  X8, X8, X7, LSR #0
    STP  X17, X20, [X8, #0]
    LDRSH  W26, [X8], #0
    ADD  X8, X8, X7, ASR #0
    STP  X15, X23, [X8, #0]
    LDRSH  X9, [X8], #0
    ADD  X8, X8, X7, LSR #0
    STP  X23, X18, [X8, #0]
    LDRSH  W26, [X8, #0]!
    ADD  X8, X8, X7, LSR #0
    STP  X18, X2, [X8, #0]
    LDRSH  X25, [X8, #0]!
    ADD  X8, X8, X7, LSR #0
    STP  X25, X24, [X8, #0]
    LDRSH  W27, [X8, #0]
    ADD  X8, X8, X7
    STP  X13, X9, [X8, #0]
    LDRSH  X10, [X8, #0]
    ADD  X8, X8, X7, ASR #0
    STP  X24, X6, [X8, #0]
    LDRSH W22, [X8, X20, LSL #0]
    ADD  X8, X8, X7, LSR #0
    STP  X13, X6, [X8, #0]
    LDRSH W13, [X8, W20, SXTW #0]
    ADD  X8, X8, X7
    STP  X22, X23, [X8, #0]
    LDRSH W24, [X8, X20, SXTX #1]
    ADD  X8, X8, X7, ASR #0
    STP  X6, X5, [X8, #0]
    LDRSH W6, [X8, W20, UXTW #1]
    ADD  X8, X8, X7, LSR #0
    STP  X22, X6, [X8, #0]
    LDRSH X18, [X8, X20, LSL #1]
    ADD  X8, X8, X7, ASR #0
    STP  X15, X22, [X8, #0]
    LDRSH X15, [X8, W20, SXTW #1]
    ADD  X8, X8, X7
    STP  X25, X2, [X8, #0]
    LDRSH X6, [X8, X20, SXTX #0]
    ADD  X8, X8, X7, LSR #0
    STP  X24, X18, [X8, #0]
    LDRSH X23, [X8, W20, UXTW #0]
    ADD  X8, X8, X7, LSR #0
    STP  X6, X13, [X8, #0]
    LDRSW  X24, [X8], #0
    ADD  X8, X8, X7
    STP  X23, X15, [X8, #0]
    LDRSW  X27, [X8, #0]!
    ADD  X8, X8, X7, LSR #0
    STP  X27, X27, [X8, #0]
    LDRSW  X25, [X8, #0]
    ADD  X8, X8, X7, LSR #0
    STP  X18, X16, [X8, #0]
    LDRSW X10, [X8, X20, LSL #0]
    ADD  X8, X8, X7
    STP  X9, X15, [X8, #0]
    LDRSW X22, [X8, W20, SXTW #0]
    ADD  X8, X8, X7
    STP  X6, X18, [X8, #0]
    LDRSW X16, [X8, X20, SXTX #0]
    ADD  X8, X8, X7, LSR #0
    STP  X24, X18, [X8, #0]
    LDRSW X9, [X8, W20, UXTW #2]
    ADD  X8, X8, X7, ASR #0
    STP  X16, X29, [X8, #0]
    LDTRSB  W9, [X8, #0]
    ADD  X8, X8, X7
    STP  X23, X20, [X8, #0]
    LDTRSB  X25, [X8, #0]
    ADD  X8, X8, X7, ASR #0
    STP  X13, X11, [X8, #0]
    LDTRSH  W2, [X8, #0]
    ADD  X8, X8, X7, LSR #0
    STP  X17, X29, [X8, #0]
    LDTRSH  X26, [X8, #0]
    ADD  X8, X8, X7, ASR #0
    STP  X13, X17, [X8, #0]
    LDTRSW  X10, [X8, #0]
    ADD  X8, X8, X7, LSR #0
    STP  X2, X16, [X8, #0]
    LDURSB  W18, [X8, #0]
    ADD  X8, X8, X7
    STP  X13, X13, [X8, #0]
    LDURSB  X11, [X8, #0]
    ADD  X8, X8, X7
    STP  X29, X16, [X8, #0]
    LDURSH  W17, [X8, #0]
    ADD  X8, X8, X7, LSR #0
    STP  X25, X10, [X8, #0]
    LDURSH  X29, [X8, #0]
    ADD  X8, X8, X7
    STP  X9, X10, [X8, #0]
    LDURSW  X10, [X8, #0]
    ADD  X8, X8, X7, LSR #0
    STP  X18, X17, [X8, #0]
    LDXP  W18, W23, [X8,#0]
    ADD  X8, X8, X7, ASR #0
    STP  X16, X29, [X8, #0]
    LDXP  X17, X25, [X8,#0]
    ADD  X8, X8, X7
    STP  X11, X23, [X8, #0]
    LDXR  W9, [X8,#0]
    ADD  X8, X8, X7, ASR #0
    STP  X10, X10, [X8, #0]
    LDXR  X11, [X8,#0]
    ADD  X8, X8, X7, ASR #0
    STP  X9, X11, [X8, #0]
    LDXRB  W23, [X8,#0]
    ADD  X8, X8, X7, LSR #0
    STP  X25, X18, [X8, #0]
    LDXRH  W10, [X8,#0]
    ADD  X8, X8, X7, LSR #0
    STRB  W11, [X8, #0]
    LDRB  W18, [X8, #0]
    ADD  X8, X8, X7, ASR #0
    STRB W18, [X8, X20, LSL #0]
    LDRB W23, [X8, X20, LSL #0]
    ADD  X8, X8, X7
    STRB W23, [X8, W20, SXTW #0]
    LDRB W11, [X8, W20, SXTW #0]
    ADD  X8, X8, X7
    STRB W10, [X8, X20, SXTX #0]
    LDRB W9, [X8, X20, SXTX #0]
    ADD  X8, X8, X7
    STRB W9, [X8, W20, UXTW #0]
    LDRB W23, [X8, W20, UXTW #0]
    ADD  X8, X8, X7
    STRH  W11, [X8, #0]
    LDRH  W9, [X8, #0]
    ADD  X8, X8, X7, LSR #0
    STRH W13, [X8, X20, LSL #1]
    LDRH W13, [X8, X20, LSL #1]
    ADD  X8, X8, X7, ASR #0
    STRH W23, [X8, W20, SXTW #0]
    LDRH W10, [X8, W20, SXTW #0]
    ADD  X8, X8, X7, LSR #0
    STRH W10, [X8, X20, SXTX #0]
    LDRH W10, [X8, X20, SXTX #1]
    ADD  X8, X8, X7, LSR #0
    STRH W2, [X8, W20, UXTW #1]
    LDRH W23, [X8, W20, UXTW #1]
    ADD  X8, X8, X7, ASR #0
    STR  W9, [X8, #0]
    LDR  W2, [X8, #0]
    ADD  X8, X8, X7, LSR #0
    STR  X10, [X8, #0]
    LDR  X25, [X8, #0]
    ADD  X8, X8, X7, ASR #0
    STR W23, [X8, X20, LSL #0]
    LDR W10, [X8, X20, LSL #0]
    ADD  X8, X8, X7
    STR W10, [X8, W20, SXTW #2]
    LDR W10, [X8, W20, SXTW #0]
    ADD  X8, X8, X7, ASR #0
    STR W25, [X8, X20, SXTX #0]
    LDR W23, [X8, X20, SXTX #2]
    ADD  X8, X8, X7
    STR W2, [X8, W20, UXTW #2]
    LDR W2, [X8, W20, UXTW #2]
    ADD  X8, X8, X7, ASR #0
    STR X13, [X8, X20, LSL #0]
    LDR X25, [X8, X20, LSL #0]
    ADD  X8, X8, X7
    STR X2, [X8, W20, SXTW #0]
    LDR X9, [X8, W20, SXTW #3]
    ADD  X8, X8, X7
    STR X23, [X8, X20, SXTX #0]
    LDR X23, [X8, X20, SXTX #0]
    ADD  X8, X8, X7
    STR X18, [X8, W20, UXTW #0]
    LDR X2, [X8, W20, UXTW #3]
    ADD  X8, X8, X7, LSR #0
    STP  W2, W10, [X8, #0]
    LDP  W10, W13, [X8, #0]
    ADD  X8, X8, X7, ASR #0
    STP  X25, X13, [X8, #0]
    LDP  X2, X11, [X8, #0]
    ADD  X8, X8, X7, ASR #0
    STTR  W11, [X8, #0]
    LDTR  W18, [X8, #0]
    ADD  X8, X8, X7, ASR #0
    STTR  X23, [X8, #0]
    LDTR  X23, [X8, #0]
    ADD  X8, X8, X7, LSR #0
    STTRB  W23, [X8, #0]
    LDTRB  W25, [X8, #0]
    ADD  X8, X8, X7
    STTRH  W25, [X8, #0]
    LDTRH  W25, [X8, #0]
    ADD  X8, X8, X7, ASR #0
    STUR  W2, [X8, #0]
    LDUR  W2, [X8, #0]
    ADD  X8, X8, X7, ASR #0
    STUR  X25, [X8, #0]
    LDUR  X11, [X8, #0]
    ADD  X8, X8, X7, LSR #0
    STURB  W10, [X8, #0]
    LDURB  W23, [X8, #0]
    ADD  X8, X8, X7, ASR #0
    STURH  W23, [X8, #0]
    LDURH  W25, [X8, #0]
    ADD  X8, X8, X7, ASR #0
    STLR  W11, [X8,#0]
    LDAR  W13, [X8,#0]
    ADD  X8, X8, X7, ASR #0
    STLR  X25, [X8,#0]
    LDAR  X23, [X8,#0]
    ADD  X8, X8, X7, LSR #0
    STLRB  W23, [X8,#0]
    LDARB  W10, [X8,#0]
    ADD  X8, X8, X7
    STLRH  W2, [X8,#0]
    LDARH  W11, [X8,#0]
    ADD  X8, X8, X7
    STNP  W11, W10, [X8, #0]
    LDNP  W27, W11, [X8, #0]
    ADD  X8, X8, X7
    STNP  X20, X27, [X8, #0]
    LDNP  X25, X23, [X8, #0]
    ADD  X8, X8, X7, ASR #0
    STP  W2, W9, [X8], #0
    LDP  W5, W10, [X8], #0
    ADD  X8, X8, X7, LSR #0
    STP  X13, X17, [X8], #0
    LDP  X13, X17, [X8], #0
    ADD  X8, X8, X7
    STP  W5, W2, [X8, #0]!
    LDP  W27, W2, [X8, #0]!
    ADD  X8, X8, X7, ASR #0
    STP  X11, X2, [X8, #0]!
    LDP  X2, X5, [X8, #0]!
    ADD  X8, X8, X7, ASR #0
    STR  W27, [X8], #0
    LDR  W27, [X8], #0
    ADD  X8, X8, X7
    STR  X23, [X8], #0
    LDR  X25, [X8], #0
    ADD  X8, X8, X7, ASR #0
    STR  W27, [X8, #0]!
    LDR  W11, [X8, #0]!
    ADD  X8, X8, X7, LSR #0
    STR  X17, [X8, #0]!
    LDR  X5, [X8, #0]!
    ADD  X8, X8, X7
    STRB  W2, [X8], #0
    LDRB  W23, [X8], #0
    ADD  X8, X8, X7, LSR #0
    STRB  W23, [X8, #0]!
    LDRB  W17, [X8, #0]!
    ADD  X8, X8, X7, ASR #0
    STRH  W17, [X8], #0
    LDRH  W27, [X8], #0
    ADD  X8, X8, X7, ASR #0
    STRH  W27, [X8, #0]!
    LDRH  W2, [X8, #0]!
    ADD  X8, X8, X7, ASR #0
    STP  X29, X5, [X8, #0]
    LDAXP  W18, W23, [X8,#0]
    ADD  X8, X8, X7, ASR #0
    STP  X18, X2, [X8, #0]
    LDAXP  X18, X5, [X8,#0]
    ADD  X8, X8, X7, ASR #0
    STP  X23, X5, [X8, #0]
    LDPSW  X17, X13, [X8], #0
    ADD  X8, X8, X7
    STP  X15, X6, [X8, #0]
    LDPSW  X27, X5, [X8, #0]!
    ADD  X8, X8, X7, ASR #0
    STP  X11, X5, [X8, #0]
    LDAXR  W5, [X8,#0]
    ADD  X8, X8, X7, ASR #0
    STP  X17, X18, [X8, #0]
    LDAXR  X23, [X8,#0]
    ADD  X8, X8, X7, LSR #0
    STP  X13, X27, [X8, #0]
    LDAXRB  W11, [X8,#0]
    ADD  X8, X8, X7, ASR #0
    STP  X22, X5, [X8, #0]
    LDAXRH  W2, [X8,#0]
    ADD  X8, X8, X7
    MOVZ  X21, #0x5a5a, LSL #0
    SUB  X4, X21, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X4, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    SUB  X4, X21, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X4, X21, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X4, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    SUB  X4, X21, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X4, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    SUB  X4, X21, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    SUB  X4, X21, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X4, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    SUB  X4, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X4, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, GeneralLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
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
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
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
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X18, #0x10, LSL #0
    MOVZ  X29, #0x2d00, LSL #0
    ADD  X4, X30, X29
    STP  X5, X23, [X4, #0]
    LDPSW  X28, X11, [X4, #0]
    ADD  X4, X4, X18
    STP  X28, X11, [X4, #0]
    LDRSB  W23, [X4], #0
    ADD  X4, X4, X18, LSR #0
    STP  X23, X27, [X4, #0]
    LDRSB  X9, [X4], #0
    ADD  X4, X4, X18, LSR #0
    STP  X25, X26, [X4, #0]
    LDRSB  W25, [X4, #0]!
    ADD  X4, X4, X18, LSR #0
    STP  X8, X23, [X4, #0]
    LDRSB  X22, [X4, #0]!
    ADD  X4, X4, X18
    STP  X13, X28, [X4, #0]
    LDRSB  W26, [X4, #0]
    ADD  X4, X4, X18, ASR #0
    STP  X24, X7, [X4, #0]
    LDRSB  X9, [X4, #0]
    ADD  X4, X4, X18
    STP  X5, X7, [X4, #0]
    LDRSB W7, [X4, X23, LSL #0]
    ADD  X4, X4, X18, LSR #0
    STP  X22, X27, [X4, #0]
    LDRSB W21, [X4, W23, SXTW #0]
    ADD  X4, X4, X18
    STP  X21, X6, [X4, #0]
    LDRSB W23, [X4, X28, SXTX #0]
    ADD  X4, X4, X18, ASR #0
    STP  X15, X21, [X4, #0]
    LDRSB W8, [X4, W28, UXTW #0]
    ADD  X4, X4, X18
    STP  X24, X9, [X4, #0]
    LDRSB X15, [X4, X11, LSL #0]
    ADD  X4, X4, X18
    STP  X5, X7, [X4, #0]
    LDRSB X6, [X4, W5, SXTW #0]
    ADD  X4, X4, X18
    STP  X20, X26, [X4, #0]
    LDRSB X13, [X4, X28, SXTX #0]
    ADD  X4, X4, X18
    STP  X20, X23, [X4, #0]
    LDRSB X7, [X4, W11, UXTW #0]
    ADD  X4, X4, X18
    STP  X25, X17, [X4, #0]
    LDRSH  W20, [X4], #0
    ADD  X4, X4, X18, LSR #0
    STP  X27, X26, [X4, #0]
    LDRSH  X22, [X4], #0
    ADD  X4, X4, X18, ASR #0
    STP  X26, X6, [X4, #0]
    LDRSH  W25, [X4, #0]!
    ADD  X4, X4, X18, ASR #0
    STP  X23, X25, [X4, #0]
    LDRSH  X25, [X4, #0]!
    ADD  X4, X4, X18
    STP  X13, X24, [X4, #0]
    LDRSH  W6, [X4, #0]
    ADD  X4, X4, X18, LSR #0
    STP  X9, X25, [X4, #0]
    LDRSH  X23, [X4, #0]
    ADD  X4, X4, X18, LSR #0
    STP  X23, X26, [X4, #0]
    LDRSH W23, [X4, X5, LSL #1]
    ADD  X4, X4, X18
    STP  X23, X13, [X4, #0]
    LDRSH W27, [X4, W5, SXTW #1]
    ADD  X4, X4, X18
    STP  X9, X21, [X4, #0]
    LDRSH W9, [X4, X5, SXTX #0]
    ADD  X4, X4, X18
    STP  X24, X8, [X4, #0]
    LDRSH W13, [X4, W28, UXTW #0]
    ADD  X4, X4, X18
    STP  X7, X21, [X4, #0]
    LDRSH X21, [X4, X28, LSL #0]
    ADD  X4, X4, X18, LSR #0
    STP  X20, X8, [X4, #0]
    LDRSH X25, [X4, W5, SXTW #0]
    ADD  X4, X4, X18, LSR #0
    STP  X17, X24, [X4, #0]
    LDRSH X28, [X4, X11, SXTX #1]
    ADD  X4, X4, X18
    STP  X26, X21, [X4, #0]
    LDRSH X26, [X4, W11, UXTW #1]
    ADD  X4, X4, X18, ASR #0
    STP  X13, X28, [X4, #0]
    LDRSW  X20, [X4], #0
    ADD  X4, X4, X18, ASR #0
    STP  X27, X13, [X4, #0]
    LDRSW  X28, [X4, #0]!
    ADD  X4, X4, X18, ASR #0
    STP  X28, X24, [X4, #0]
    LDRSW  X8, [X4, #0]
    ADD  X4, X4, X18, LSR #0
    STP  X25, X20, [X4, #0]
    LDRSW X21, [X4, X11, LSL #0]
    ADD  X4, X4, X18
    STP  X24, X25, [X4, #0]
    LDRSW X28, [X4, W5, SXTW #0]
    ADD  X4, X4, X18
    STP  X15, X20, [X4, #0]
    LDRSW X15, [X4, X5, SXTX #2]
    ADD  X4, X4, X18, ASR #0
    STP  X17, X6, [X4, #0]
    LDRSW X6, [X4, W11, UXTW #0]
    ADD  X4, X4, X18, LSR #0
    STP  X15, X17, [X4, #0]
    LDTRSB  W20, [X4, #0]
    ADD  X4, X4, X18, LSR #0
    STP  X7, X11, [X4, #0]
    LDTRSB  X17, [X4, #0]
    ADD  X4, X4, X18, ASR #0
    STP  X6, X26, [X4, #0]
    LDTRSH  W6, [X4, #0]
    ADD  X4, X4, X18
    STP  X22, X25, [X4, #0]
    LDTRSH  X11, [X4, #0]
    ADD  X4, X4, X18
    STP  X26, X11, [X4, #0]
    LDTRSW  X24, [X4, #0]
    ADD  X4, X4, X18
    STP  X13, X17, [X4, #0]
    LDURSB  W7, [X4, #0]
    ADD  X4, X4, X18, LSR #0
    STP  X20, X5, [X4, #0]
    LDURSB  X15, [X4, #0]
    ADD  X4, X4, X18, LSR #0
    STP  X24, X27, [X4, #0]
    LDURSH  W22, [X4, #0]
    ADD  X4, X4, X18
    STP  X15, X20, [X4, #0]
    LDURSH  X11, [X4, #0]
    ADD  X4, X4, X18, ASR #0
    STP  X27, X7, [X4, #0]
    LDURSW  X17, [X4, #0]
    ADD  X4, X4, X18, LSR #0
    STP  X21, X25, [X4, #0]
    LDXP  W27, W26, [X4,#0]
    ADD  X4, X4, X18, ASR #0
    STP  X9, X9, [X4, #0]
    LDXP  X23, X20, [X4,#0]
    ADD  X4, X4, X18, LSR #0
    STP  X17, X8, [X4, #0]
    LDXR  W8, [X4,#0]
    ADD  X4, X4, X18, LSR #0
    STP  X22, X26, [X4, #0]
    LDXR  X9, [X4,#0]
    ADD  X4, X4, X18, LSR #0
    STP  X23, X27, [X4, #0]
    LDXRB  W21, [X4,#0]
    ADD  X4, X4, X18
    STP  X21, X11, [X4, #0]
    LDXRH  W7, [X4,#0]
    ADD  X4, X4, X18, ASR #0
    STRB  W22, [X4, #0]
    LDRB  W26, [X4, #0]
    ADD  X4, X4, X18
    STRB W5, [X4, X5, LSL #0]
    LDRB W11, [X4, X5, LSL #0]
    ADD  X4, X4, X18
    STRB W7, [X4, W11, SXTW #0]
    LDRB W23, [X4, W11, SXTW #0]
    ADD  X4, X4, X18, ASR #0
    STRB W26, [X4, X11, SXTX #0]
    LDRB W17, [X4, X5, SXTX #0]
    ADD  X4, X4, X18, LSR #0
    STRB W23, [X4, W5, UXTW #0]
    LDRB W6, [X4, W11, UXTW #0]
    ADD  X4, X4, X18
    STRH  W26, [X4, #0]
    LDRH  W26, [X4, #0]
    ADD  X4, X4, X18, LSR #0
    STRH W17, [X4, X5, LSL #0]
    LDRH W11, [X4, X5, LSL #1]
    ADD  X4, X4, X18, LSR #0
    STRH W26, [X4, W5, SXTW #1]
    LDRH W23, [X4, W5, SXTW #1]
    ADD  X4, X4, X18, ASR #0
    STRH W15, [X4, X5, SXTX #1]
    LDRH W26, [X4, X5, SXTX #0]
    ADD  X4, X4, X18, ASR #0
    STRH W15, [X4, W5, UXTW #0]
    LDRH W17, [X4, W5, UXTW #1]
    ADD  X4, X4, X18
    STR  W23, [X4, #0]
    LDR  W23, [X4, #0]
    ADD  X4, X4, X18, ASR #0
    STR  X6, [X4, #0]
    LDR  X6, [X4, #0]
    ADD  X4, X4, X18, ASR #0
    STR W27, [X4, X5, LSL #0]
    LDR W27, [X4, X5, LSL #2]
    ADD  X4, X4, X18, LSR #0
    STR W17, [X4, W5, SXTW #0]
    LDR W27, [X4, W5, SXTW #0]
    ADD  X4, X4, X18, ASR #0
    STR W6, [X4, X5, SXTX #2]
    LDR W6, [X4, X5, SXTX #0]
    ADD  X4, X4, X18, ASR #0
    STR W11, [X4, W5, UXTW #2]
    LDR W17, [X4, W5, UXTW #0]
    ADD  X4, X4, X18, LSR #0
    STR X17, [X4, X5, LSL #0]
    LDR X11, [X4, X5, LSL #0]
    ADD  X4, X4, X18, ASR #0
    STR X23, [X4, W5, SXTW #0]
    LDR X17, [X4, W5, SXTW #0]
    ADD  X4, X4, X18, LSR #0
    STR X17, [X4, X5, SXTX #0]
    LDR X17, [X4, X5, SXTX #0]
    ADD  X4, X4, X18, ASR #0
    STR X11, [X4, W5, UXTW #0]
    LDR X7, [X4, W5, UXTW #3]
    ADD  X4, X4, X18
    STP  W27, W17, [X4, #0]
    LDP  W23, W17, [X4, #0]
    ADD  X4, X4, X18, LSR #0
    STP  X17, X7, [X4, #0]
    LDP  X26, X27, [X4, #0]
    ADD  X4, X4, X18, LSR #0
    STTR  W23, [X4, #0]
    LDTR  W23, [X4, #0]
    ADD  X4, X4, X18, ASR #0
    STTR  X26, [X4, #0]
    LDTR  X26, [X4, #0]
    ADD  X4, X4, X18
    STTRB  W27, [X4, #0]
    LDTRB  W11, [X4, #0]
    ADD  X4, X4, X18, ASR #0
    STTRH  W23, [X4, #0]
    LDTRH  W27, [X4, #0]
    ADD  X4, X4, X18
    STUR  W26, [X4, #0]
    LDUR  W17, [X4, #0]
    ADD  X4, X4, X18, ASR #0
    STUR  X11, [X4, #0]
    LDUR  X11, [X4, #0]
    ADD  X4, X4, X18, LSR #0
    STURB  W27, [X4, #0]
    LDURB  W27, [X4, #0]
    ADD  X4, X4, X18, ASR #0
    STURH  W27, [X4, #0]
    LDURH  W27, [X4, #0]
    ADD  X4, X4, X18
    STLR  W17, [X4,#0]
    LDAR  W17, [X4,#0]
    ADD  X4, X4, X18
    STLR  X17, [X4,#0]
    LDAR  X17, [X4,#0]
    ADD  X4, X4, X18
    STLRB  W17, [X4,#0]
    LDARB  W9, [X4,#0]
    ADD  X4, X4, X18, ASR #0
    STLRH  W9, [X4,#0]
    LDARH  W17, [X4,#0]
    ADD  X4, X4, X18, LSR #0
    STNP  W11, W5, [X4, #0]
    LDNP  W9, W20, [X4, #0]
    ADD  X4, X4, X18
    STNP  X27, X17, [X4, #0]
    LDNP  X17, X27, [X4, #0]
    ADD  X4, X4, X18
    STP  W9, W6, [X4], #0
    LDP  W9, W11, [X4], #0
    ADD  X4, X4, X18, ASR #0
    STP  X20, X20, [X4], #0
    LDP  X20, X6, [X4], #0
    ADD  X4, X4, X18, ASR #0
    STP  W17, W6, [X4, #0]!
    LDP  W6, W27, [X4, #0]!
    ADD  X4, X4, X18, LSR #0
    STP  X6, X20, [X4, #0]!
    LDP  X21, X24, [X4, #0]!
    ADD  X4, X4, X18, LSR #0
    STR  W27, [X4], #0
    LDR  W13, [X4], #0
    ADD  X4, X4, X18, ASR #0
    STR  X21, [X4], #0
    LDR  X20, [X4], #0
    ADD  X4, X4, X18, ASR #0
    STR  W9, [X4, #0]!
    LDR  W7, [X4, #0]!
    ADD  X4, X4, X18
    STR  X24, [X4, #0]!
    LDR  X7, [X4, #0]!
    ADD  X4, X4, X18
    STRB  W11, [X4], #0
    LDRB  W17, [X4], #0
    ADD  X4, X4, X18, ASR #0
    STRB  W7, [X4, #0]!
    LDRB  W8, [X4, #0]!
    ADD  X4, X4, X18, ASR #0
    STRH  W20, [X4], #0
    LDRH  W22, [X4], #0
    ADD  X4, X4, X18, ASR #0
    STRH  W8, [X4, #0]!
    LDRH  W22, [X4, #0]!
    ADD  X4, X4, X18
    STP  X22, X17, [X4, #0]
    LDAXP  W17, W21, [X4,#0]
    ADD  X4, X4, X18, ASR #0
    STP  X22, X11, [X4, #0]
    LDAXP  X6, X16, [X4,#0]
    ADD  X4, X4, X18
    STP  X9, X6, [X4, #0]
    LDPSW  X8, X6, [X4], #0
    ADD  X4, X4, X18, LSR #0
    STP  X16, X11, [X4, #0]
    LDPSW  X6, X24, [X4, #0]!
    ADD  X4, X4, X18, ASR #0
    STP  X15, X5, [X4, #0]
    LDAXR  W11, [X4,#0]
    ADD  X4, X4, X18
    STP  X5, X27, [X4, #0]
    LDAXR  X13, [X4,#0]
    ADD  X4, X4, X18, ASR #0
    STP  X8, X7, [X4, #0]
    LDAXRB  W24, [X4,#0]
    ADD  X4, X4, X18, ASR #0
    STP  X9, X6, [X4, #0]
    LDAXRH  W20, [X4,#0]
    ADD  X4, X4, X18, ASR #0
    MOVZ  X10, #0xa5, LSL #0
    SUB  X2, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, GeneralLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, GeneralLoadStoreP04_TestFail
    MOVZ  X10, #0xa5, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, GeneralLoadStoreP04_TestFail
    MOVZ  X10, #0xa5, LSL #0
    SUB  X2, X10, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, GeneralLoadStoreP04_TestFail
    MOVZ  X10, #0xffa5, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X2, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, GeneralLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, GeneralLoadStoreP04_TestFail
    MOVZ  X10, #0xffa5, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X2, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, GeneralLoadStoreP04_TestFail
    MOVZ  X10, #0xa5, LSL #0
    SUB  X2, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, GeneralLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, GeneralLoadStoreP04_TestFail
    MOVZ  X10, #0xa5, LSL #0
    SUB  X2, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, GeneralLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, GeneralLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, GeneralLoadStoreP04_TestFail
    MOVZ  X10, #0xffa5, LSL #0
    SUB  X2, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, GeneralLoadStoreP04_TestFail
    MOVZ  X10, #0xa5, LSL #0
    SUB  X2, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, GeneralLoadStoreP04_TestFail
    MOVZ  X10, #0xffa5, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X2, X10, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, GeneralLoadStoreP04_TestFail
    MOVZ  X10, #0xa5, LSL #0
    SUB  X2, X10, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, GeneralLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, GeneralLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X2, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, GeneralLoadStoreP04_TestFail

GeneralLoadStoreP04_TestEnd:
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
    LDP  X2, X3, [SP], #16
    MSR  NZCV, X2
    ISB  SY
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
GeneralLoadStoreP04_TestFail:
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
    LDP  X2, X3, [SP], #16
    MSR  NZCV, X2
    ISB  SY
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
