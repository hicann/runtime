.global EnhanceLoadStoreP01

.text
.p2align 4

EnhanceLoadStoreP01:

EnhanceLoadStoreP01_TestBegin:
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
    MOVZ  X2, #0xe5a8, LSL #0
    MOVK  X2, #0xe42b, LSL #16
    MOVK  X2, #0xd8d2, LSL #32
    MOVK  X2, #0xe86f, LSL #48
    MOVZ  X3, #0x8a98, LSL #0
    MOVK  X3, #0xae0, LSL #16
    MOVK  X3, #0xaa08, LSL #32
    MOVK  X3, #0x9395, LSL #48
    MOVZ  X4, #0xb216, LSL #0
    MOVK  X4, #0x182c, LSL #16
    MOVK  X4, #0x591a, LSL #32
    MOVK  X4, #0xf088, LSL #48
    MOVZ  X5, #0xa672, LSL #0
    MOVK  X5, #0xe8b1, LSL #16
    MOVK  X5, #0x54bf, LSL #32
    MOVK  X5, #0xfca9, LSL #48
    MOVZ  X6, #0x86f4, LSL #0
    MOVK  X6, #0x893f, LSL #16
    MOVK  X6, #0x701f, LSL #32
    MOVK  X6, #0x2ec0, LSL #48
    MOVZ  X7, #0xf44a, LSL #0
    MOVK  X7, #0x3b85, LSL #16
    MOVK  X7, #0xf894, LSL #32
    MOVK  X7, #0xd372, LSL #48
    MOVZ  X8, #0xec28, LSL #0
    MOVK  X8, #0xb3fc, LSL #16
    MOVK  X8, #0xd052, LSL #32
    MOVK  X8, #0xd319, LSL #48
    MOVZ  X10, #0x5305, LSL #0
    MOVK  X10, #0x513c, LSL #16
    MOVK  X10, #0x3da0, LSL #32
    MOVK  X10, #0xaab4, LSL #48
    MOVZ  X11, #0xdc88, LSL #0
    MOVK  X11, #0x5c76, LSL #16
    MOVK  X11, #0x1c50, LSL #32
    MOVK  X11, #0x95dd, LSL #48
    MOVZ  X12, #0x69b4, LSL #0
    MOVK  X12, #0x516, LSL #16
    MOVK  X12, #0x2012, LSL #32
    MOVK  X12, #0x50b1, LSL #48
    MOVZ  X13, #0x94a5, LSL #0
    MOVK  X13, #0xef0d, LSL #16
    MOVK  X13, #0xdfbe, LSL #32
    MOVK  X13, #0x4404, LSL #48
    MOVZ  X14, #0xdbfc, LSL #0
    MOVK  X14, #0xdb7b, LSL #16
    MOVK  X14, #0xf43f, LSL #32
    MOVK  X14, #0x36af, LSL #48
    MOVZ  X16, #0x22c6, LSL #0
    MOVK  X16, #0x606a, LSL #16
    MOVK  X16, #0x9b4f, LSL #32
    MOVK  X16, #0x180f, LSL #48
    MOVZ  X17, #0x64ce, LSL #0
    MOVK  X17, #0xf596, LSL #16
    MOVK  X17, #0xa9ea, LSL #32
    MOVK  X17, #0x12fa, LSL #48
    MOVZ  X18, #0x25eb, LSL #0
    MOVK  X18, #0x4d46, LSL #16
    MOVK  X18, #0xd065, LSL #32
    MOVK  X18, #0x12c4, LSL #48
    MOVZ  X19, #0x632f, LSL #0
    MOVK  X19, #0xf764, LSL #16
    MOVK  X19, #0x2ed0, LSL #32
    MOVK  X19, #0xf37b, LSL #48
    MOVZ  X20, #0xfd42, LSL #0
    MOVK  X20, #0x330e, LSL #16
    MOVK  X20, #0x5201, LSL #32
    MOVK  X20, #0xb57c, LSL #48
    MOVZ  X21, #0xeef0, LSL #0
    MOVK  X21, #0xc91, LSL #16
    MOVK  X21, #0xfd16, LSL #32
    MOVK  X21, #0x138c, LSL #48
    MOVZ  X22, #0xd8fe, LSL #0
    MOVK  X22, #0xe51e, LSL #16
    MOVK  X22, #0xf6cc, LSL #32
    MOVK  X22, #0xd7f1, LSL #48
    MOVZ  X23, #0xf109, LSL #0
    MOVK  X23, #0x6283, LSL #16
    MOVK  X23, #0x66c1, LSL #32
    MOVK  X23, #0xba6a, LSL #48
    MOVZ  X25, #0x5795, LSL #0
    MOVK  X25, #0x1689, LSL #16
    MOVK  X25, #0x5b45, LSL #32
    MOVK  X25, #0x3953, LSL #48
    MOVZ  X26, #0x7668, LSL #0
    MOVK  X26, #0x2aef, LSL #16
    MOVK  X26, #0x3c03, LSL #32
    MOVK  X26, #0x77f0, LSL #48
    MOVZ  X27, #0xecda, LSL #0
    MOVK  X27, #0x1c5f, LSL #16
    MOVK  X27, #0xf1e1, LSL #32
    MOVK  X27, #0x4a35, LSL #48
    MOVZ  X28, #0x4ab8, LSL #0
    MOVK  X28, #0xf027, LSL #16
    MOVK  X28, #0x42c2, LSL #32
    MOVK  X28, #0x3c99, LSL #48
    ADDS  W26, W25, #0x99b
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
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X5, #0x8, LSL #0
    MOVZ  X17, #0x0, LSL #0
    ADD  X25, X30, X17, ASR #0
    STR  X10, [X25], #8
    STR  X26, [X25], #8
    STR  X28, [X25], #8
    STR  X27, [X25], #8
    STR  X7, [X25], #8
    STR  X19, [X25], #8
    STR  X21, [X25], #8
    STR  X11, [X25], #8
    STR  X4, [X25], #8
    STR  X7, [X25], #8
    STR  X4, [X25], #8
    STR  X7, [X25], #8
    STR  X7, [X25], #8
    STR  X20, [X25], #8
    STR  X20, [X25], #8
    STR  X10, [X25], #8
    STR  X10, [X25], #8
    STR  X14, [X25], #8
    STR  X22, [X25], #8
    STR  X7, [X25], #8
    STR  X14, [X25], #8
    STR  X6, [X25], #8
    STR  X23, [X25], #8
    STR  X7, [X25], #8
    STR  X16, [X25], #8
    STR  X19, [X25], #8
    STR  X21, [X25], #8
    STR  X20, [X25], #8
    STR  X18, [X25], #8
    STR  X21, [X25], #8
    STR  X18, [X25], #8
    STR  X22, [X25], #8
    STR  X3, [X25], #8
    STR  X23, [X25], #8
    STR  X23, [X25], #8
    STR  X4, [X25], #8
    STR  X16, [X25], #8
    STR  X23, [X25], #8
    STR  X13, [X25], #8
    STR  X7, [X25], #8
    DMB  #12
    DSB  #0
    ADD  X25, X30, X17
    PRFM  #0x0, [X25, #0]
    ADD  X25, X25, X5
    PRFM  #0x1, [X25, #0]
    ADD  X25, X25, X5, LSR #0
    PRFM  #0x2, [X25, #0]
    ADD  X25, X25, X5, ASR #0
    PRFM  #0x3, [X25, #0]
    ADD  X25, X25, X5
    PRFM #0x0, [X25, X26, LSL #0]
    ADD  X25, X25, X5
    PRFM #0x1, [X25, X26, LSL #0]
    ADD  X25, X25, X5, LSR #0
    PRFM #0x2, [X25, X26, LSL #0]
    ADD  X25, X25, X5, ASR #0
    PRFM #0x3, [X25, X26, LSL #0]
    ADD  X25, X25, X5, ASR #0
    PRFM #0x0, [X25, W26, SXTW #0]
    ADD  X25, X25, X5, LSR #0
    PRFM #0x1, [X25, W26, SXTW #0]
    ADD  X25, X25, X5, LSR #0
    PRFM #0x2, [X25, W26, SXTW #0]
    ADD  X25, X25, X5, LSR #0
    PRFM #0x3, [X25, W26, SXTW #0]
    ADD  X25, X25, X5, ASR #0
    PRFM #0x0, [X25, X26, SXTX #0]
    ADD  X25, X25, X5, LSR #0
    PRFM #0x1, [X25, X26, SXTX #0]
    ADD  X25, X25, X5, ASR #0
    PRFM #0x2, [X25, X26, SXTX #0]
    ADD  X25, X25, X5, ASR #0
    PRFM #0x3, [X25, X26, SXTX #0]
    ADD  X25, X25, X5, LSR #0
    PRFM #0x0, [X25, W26, UXTW #0]
    ADD  X25, X25, X5, LSR #0
    PRFM #0x1, [X25, W26, UXTW #0]
    ADD  X25, X25, X5, LSR #0
    PRFM #0x2, [X25, W26, UXTW #0]
    ADD  X25, X25, X5
    PRFM #0x3, [X25, W26, UXTW #0]
    ADD  X25, X25, X5
    PRFUM #0x0, [X25, #0]
    ADD  X25, X25, X5
    PRFUM #0x1, [X25, #0]
    ADD  X25, X25, X5, ASR #0
    PRFUM #0x2, [X25, #0]
    ADD  X25, X25, X5
    PRFUM #0x3, [X25, #0]
    ADD  X25, X25, X5
    ADD  X25, X30, X17, ASR #0
    LDR  X18, [X25], #8
    LDR  X7, [X25], #8
    LDR  X16, [X25], #8
    LDR  X8, [X25], #8
    LDR  X19, [X25], #8
    LDR  X16, [X25], #8
    LDR  X6, [X25], #8
    LDR  X11, [X25], #8
    LDR  X3, [X25], #8
    LDR  X28, [X25], #8
    LDR  X8, [X25], #8
    LDR  X19, [X25], #8
    LDR  X28, [X25], #8
    LDR  X27, [X25], #8
    LDR  X8, [X25], #8
    LDR  X18, [X25], #8
    LDR  X20, [X25], #8
    LDR  X20, [X25], #8
    LDR  X23, [X25], #8
    LDR  X7, [X25], #8
    LDR  X21, [X25], #8
    LDR  X13, [X25], #8
    LDR  X28, [X25], #8
    LDR  X10, [X25], #8
    LDR  X6, [X25], #8
    LDR  X18, [X25], #8
    LDR  X3, [X25], #8
    LDR  X11, [X25], #8
    LDR  X3, [X25], #8
    LDR  X21, [X25], #8
    LDR  X22, [X25], #8
    LDR  X8, [X25], #8
    LDR  X3, [X25], #8
    LDR  X3, [X25], #8
    LDR  X19, [X25], #8
    LDR  X16, [X25], #8
    LDR  X18, [X25], #8
    LDR  X23, [X25], #8
    LDR  X21, [X25], #8
    LDR  X18, [X25], #8
    DMB  OSH
    DSB  OSHLD
    ADD  X25, X30, X17, ASR #0
    PRFM  #0x10, [X25, #0]
    ADD  X25, X25, X5
    PRFM  #0x11, [X25, #0]
    ADD  X25, X25, X5, LSR #0
    PRFM  #0x12, [X25, #0]
    ADD  X25, X25, X5, ASR #0
    PRFM  #0x13, [X25, #0]
    ADD  X25, X25, X5, LSR #0
    PRFM #0x10, [X25, X26, LSL #0]
    ADD  X25, X25, X5, ASR #0
    PRFM #0x11, [X25, X26, LSL #0]
    ADD  X25, X25, X5, ASR #0
    PRFM #0x12, [X25, X26, LSL #0]
    ADD  X25, X25, X5
    PRFM #0x13, [X25, X26, LSL #0]
    ADD  X25, X25, X5, ASR #0
    PRFM #0x10, [X25, W26, SXTW #0]
    ADD  X25, X25, X5, ASR #0
    PRFM #0x11, [X25, W26, SXTW #0]
    ADD  X25, X25, X5, ASR #0
    PRFM #0x12, [X25, W26, SXTW #0]
    ADD  X25, X25, X5, ASR #0
    PRFM #0x13, [X25, W26, SXTW #0]
    ADD  X25, X25, X5
    PRFM #0x10, [X25, X26, SXTX #0]
    ADD  X25, X25, X5, ASR #0
    PRFM #0x11, [X25, X26, SXTX #0]
    ADD  X25, X25, X5
    PRFM #0x12, [X25, X26, SXTX #0]
    ADD  X25, X25, X5, ASR #0
    PRFM #0x13, [X25, X26, SXTX #0]
    ADD  X25, X25, X5, LSR #0
    PRFM #0x10, [X25, W26, UXTW #0]
    ADD  X25, X25, X5
    PRFM #0x11, [X25, W26, UXTW #0]
    ADD  X25, X25, X5, ASR #0
    PRFM #0x12, [X25, W26, UXTW #0]
    ADD  X25, X25, X5, LSR #0
    PRFM #0x13, [X25, W26, UXTW #0]
    ADD  X25, X25, X5
    PRFUM #0x10, [X25, #0]
    ADD  X25, X25, X5, ASR #0
    PRFUM #0x11, [X25, #0]
    ADD  X25, X25, X5, ASR #0
    PRFUM #0x12, [X25, #0]
    ADD  X25, X25, X5, ASR #0
    PRFUM #0x13, [X25, #0]
    ADD  X25, X25, X5
    ADD  X25, X30, X17, LSR #0
    STR  X26, [X25], #8
    STR  X7, [X25], #8
    STR  X20, [X25], #8
    STR  X22, [X25], #8
    STR  X11, [X25], #8
    STR  X23, [X25], #8
    STR  X4, [X25], #8
    STR  X27, [X25], #8
    STR  X19, [X25], #8
    STR  X10, [X25], #8
    STR  X13, [X25], #8
    STR  X22, [X25], #8
    STR  X6, [X25], #8
    STR  X8, [X25], #8
    STR  X26, [X25], #8
    STR  X21, [X25], #8
    STR  X16, [X25], #8
    STR  X6, [X25], #8
    STR  X4, [X25], #8
    STR  X13, [X25], #8
    STR  X18, [X25], #8
    STR  X6, [X25], #8
    STR  X20, [X25], #8
    STR  X3, [X25], #8
    STR  X8, [X25], #8
    STR  X4, [X25], #8
    STR  X11, [X25], #8
    STR  X14, [X25], #8
    STR  X27, [X25], #8
    STR  X16, [X25], #8
    STR  X14, [X25], #8
    STR  X11, [X25], #8
    STR  X27, [X25], #8
    STR  X19, [X25], #8
    STR  X26, [X25], #8
    STR  X10, [X25], #8
    STR  X21, [X25], #8
    STR  X18, [X25], #8
    STR  X11, [X25], #8
    STR  X14, [X25], #8
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X2, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
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
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X22, #0x8, LSL #0
    MOVZ  X19, #0xa0, LSL #0
    ADD  X5, X30, X19
    STR  X25, [X5], #8
    STR  X20, [X5], #8
    STR  X26, [X5], #8
    STR  X23, [X5], #8
    STR  X28, [X5], #8
    STR  X27, [X5], #8
    STR  X8, [X5], #8
    STR  X13, [X5], #8
    STR  X20, [X5], #8
    STR  X23, [X5], #8
    STR  X28, [X5], #8
    STR  X18, [X5], #8
    STR  X10, [X5], #8
    STR  X23, [X5], #8
    STR  X7, [X5], #8
    STR  X18, [X5], #8
    STR  X27, [X5], #8
    STR  X20, [X5], #8
    STR  X25, [X5], #8
    STR  X3, [X5], #8
    STR  X11, [X5], #8
    STR  X4, [X5], #8
    STR  X4, [X5], #8
    STR  X11, [X5], #8
    STR  X14, [X5], #8
    STR  X25, [X5], #8
    STR  X7, [X5], #8
    STR  X11, [X5], #8
    STR  X18, [X5], #8
    STR  X17, [X5], #8
    STR  X12, [X5], #8
    STR  X27, [X5], #8
    STR  X3, [X5], #8
    STR  X14, [X5], #8
    STR  X25, [X5], #8
    STR  X4, [X5], #8
    STR  X13, [X5], #8
    STR  X12, [X5], #8
    STR  X8, [X5], #8
    STR  X17, [X5], #8
    DMB  NSH
    DSB  #4
    ADD  X5, X30, X19
    PRFM  #0x0, [X5, #0]
    ADD  X5, X5, X22, LSR #0
    PRFM  #0x1, [X5, #0]
    ADD  X5, X5, X22, ASR #0
    PRFM  #0x2, [X5, #0]
    ADD  X5, X5, X22
    PRFM  #0x3, [X5, #0]
    ADD  X5, X5, X22, ASR #0
    PRFM #0x0, [X5, X13, LSL #0]
    ADD  X5, X5, X22, ASR #0
    PRFM #0x1, [X5, X13, LSL #0]
    ADD  X5, X5, X22, ASR #0
    PRFM #0x2, [X5, X13, LSL #0]
    ADD  X5, X5, X22, LSR #0
    PRFM #0x3, [X5, X13, LSL #0]
    ADD  X5, X5, X22, ASR #0
    PRFM #0x0, [X5, W13, SXTW #0]
    ADD  X5, X5, X22, LSR #0
    PRFM #0x1, [X5, W13, SXTW #0]
    ADD  X5, X5, X22
    PRFM #0x2, [X5, W13, SXTW #0]
    ADD  X5, X5, X22, LSR #0
    PRFM #0x3, [X5, W13, SXTW #0]
    ADD  X5, X5, X22
    PRFM #0x0, [X5, X13, SXTX #0]
    ADD  X5, X5, X22, ASR #0
    PRFM #0x1, [X5, X13, SXTX #0]
    ADD  X5, X5, X22, LSR #0
    PRFM #0x2, [X5, X13, SXTX #0]
    ADD  X5, X5, X22, ASR #0
    PRFM #0x3, [X5, X13, SXTX #0]
    ADD  X5, X5, X22, LSR #0
    PRFM #0x0, [X5, W13, UXTW #0]
    ADD  X5, X5, X22, ASR #0
    PRFM #0x1, [X5, W13, UXTW #0]
    ADD  X5, X5, X22, ASR #0
    PRFM #0x2, [X5, W13, UXTW #0]
    ADD  X5, X5, X22, ASR #0
    PRFM #0x3, [X5, W13, UXTW #0]
    ADD  X5, X5, X22, LSR #0
    PRFUM #0x0, [X5, #0]
    ADD  X5, X5, X22, ASR #0
    PRFUM #0x1, [X5, #0]
    ADD  X5, X5, X22, ASR #0
    PRFUM #0x2, [X5, #0]
    ADD  X5, X5, X22, LSR #0
    PRFUM #0x3, [X5, #0]
    ADD  X5, X5, X22, LSR #0
    ADD  X5, X30, X19, ASR #0
    LDR  X16, [X5], #8
    LDR  X17, [X5], #8
    LDR  X11, [X5], #8
    LDR  X20, [X5], #8
    LDR  X26, [X5], #8
    LDR  X18, [X5], #8
    LDR  X10, [X5], #8
    LDR  X20, [X5], #8
    LDR  X27, [X5], #8
    LDR  X10, [X5], #8
    LDR  X16, [X5], #8
    LDR  X7, [X5], #8
    LDR  X3, [X5], #8
    LDR  X28, [X5], #8
    LDR  X23, [X5], #8
    LDR  X23, [X5], #8
    LDR  X11, [X5], #8
    LDR  X7, [X5], #8
    LDR  X14, [X5], #8
    LDR  X27, [X5], #8
    LDR  X11, [X5], #8
    LDR  X7, [X5], #8
    LDR  X16, [X5], #8
    LDR  X27, [X5], #8
    LDR  X17, [X5], #8
    LDR  X7, [X5], #8
    LDR  X4, [X5], #8
    LDR  X28, [X5], #8
    LDR  X26, [X5], #8
    LDR  X12, [X5], #8
    LDR  X23, [X5], #8
    LDR  X26, [X5], #8
    LDR  X16, [X5], #8
    LDR  X4, [X5], #8
    LDR  X10, [X5], #8
    LDR  X16, [X5], #8
    LDR  X16, [X5], #8
    LDR  X17, [X5], #8
    LDR  X7, [X5], #8
    LDR  X25, [X5], #8
    DMB  OSHST
    DSB  ISH
    ADD  X5, X30, X19, ASR #0
    PRFM  #0x10, [X5, #0]
    ADD  X5, X5, X22, ASR #0
    PRFM  #0x11, [X5, #0]
    ADD  X5, X5, X22, ASR #0
    PRFM  #0x12, [X5, #0]
    ADD  X5, X5, X22, ASR #0
    PRFM  #0x13, [X5, #0]
    ADD  X5, X5, X22, LSR #0
    PRFM #0x10, [X5, X16, LSL #0]
    ADD  X5, X5, X22
    PRFM #0x11, [X5, X13, LSL #0]
    ADD  X5, X5, X22
    PRFM #0x12, [X5, X20, LSL #0]
    ADD  X5, X5, X22, LSR #0
    PRFM #0x13, [X5, X13, LSL #0]
    ADD  X5, X5, X22, ASR #0
    PRFM #0x10, [X5, W13, SXTW #0]
    ADD  X5, X5, X22, LSR #0
    PRFM #0x11, [X5, W16, SXTW #0]
    ADD  X5, X5, X22
    PRFM #0x12, [X5, W16, SXTW #0]
    ADD  X5, X5, X22, ASR #0
    PRFM #0x13, [X5, W20, SXTW #0]
    ADD  X5, X5, X22, LSR #0
    PRFM #0x10, [X5, X13, SXTX #0]
    ADD  X5, X5, X22, LSR #0
    PRFM #0x11, [X5, X13, SXTX #0]
    ADD  X5, X5, X22
    PRFM #0x12, [X5, X16, SXTX #0]
    ADD  X5, X5, X22
    PRFM #0x13, [X5, X20, SXTX #0]
    ADD  X5, X5, X22, LSR #0
    PRFM #0x10, [X5, W16, UXTW #0]
    ADD  X5, X5, X22
    PRFM #0x11, [X5, W16, UXTW #0]
    ADD  X5, X5, X22
    PRFM #0x12, [X5, W20, UXTW #0]
    ADD  X5, X5, X22, ASR #0
    PRFM #0x13, [X5, W16, UXTW #0]
    ADD  X5, X5, X22, LSR #0
    PRFUM #0x10, [X5, #0]
    ADD  X5, X5, X22, ASR #0
    PRFUM #0x11, [X5, #0]
    ADD  X5, X5, X22, LSR #0
    PRFUM #0x12, [X5, #0]
    ADD  X5, X5, X22, ASR #0
    PRFUM #0x13, [X5, #0]
    ADD  X5, X5, X22
    ADD  X5, X30, X19
    STR  X13, [X5], #8
    STR  X3, [X5], #8
    STR  X13, [X5], #8
    STR  X14, [X5], #8
    STR  X26, [X5], #8
    STR  X21, [X5], #8
    STR  X14, [X5], #8
    STR  X20, [X5], #8
    STR  X17, [X5], #8
    STR  X3, [X5], #8
    STR  X18, [X5], #8
    STR  X26, [X5], #8
    STR  X18, [X5], #8
    STR  X27, [X5], #8
    STR  X27, [X5], #8
    STR  X14, [X5], #8
    STR  X23, [X5], #8
    STR  X28, [X5], #8
    STR  X26, [X5], #8
    STR  X23, [X5], #8
    STR  X12, [X5], #8
    STR  X21, [X5], #8
    STR  X12, [X5], #8
    STR  X18, [X5], #8
    STR  X3, [X5], #8
    STR  X16, [X5], #8
    STR  X28, [X5], #8
    STR  X12, [X5], #8
    STR  X28, [X5], #8
    STR  X17, [X5], #8
    STR  X18, [X5], #8
    STR  X12, [X5], #8
    STR  X28, [X5], #8
    STR  X16, [X5], #8
    STR  X11, [X5], #8
    STR  X12, [X5], #8
    STR  X23, [X5], #8
    STR  X17, [X5], #8
    STR  X17, [X5], #8
    STR  X20, [X5], #8
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X2, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X2, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X2, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X2, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X2, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X2, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X2, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X2, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X2, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X2, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X2, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X2, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X2, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X2, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X2, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X2, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, EnhanceLoadStoreP01_TestFail
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
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X4, #0x8, LSL #0
    MOVZ  X8, #0x140, LSL #0
    ADD  X18, X30, X8, ASR #0
    STR  X25, [X18], #8
    STR  X27, [X18], #8
    STR  X28, [X18], #8
    STR  X5, [X18], #8
    STR  X26, [X18], #8
    STR  X6, [X18], #8
    STR  X17, [X18], #8
    STR  X26, [X18], #8
    STR  X16, [X18], #8
    STR  X3, [X18], #8
    STR  X10, [X18], #8
    STR  X5, [X18], #8
    STR  X20, [X18], #8
    STR  X6, [X18], #8
    STR  X11, [X18], #8
    STR  X7, [X18], #8
    STR  X28, [X18], #8
    STR  X12, [X18], #8
    STR  X19, [X18], #8
    STR  X17, [X18], #8
    STR  X17, [X18], #8
    STR  X6, [X18], #8
    STR  X11, [X18], #8
    STR  X26, [X18], #8
    STR  X16, [X18], #8
    STR  X11, [X18], #8
    STR  X25, [X18], #8
    STR  X3, [X18], #8
    STR  X11, [X18], #8
    STR  X19, [X18], #8
    STR  X28, [X18], #8
    STR  X11, [X18], #8
    STR  X14, [X18], #8
    STR  X27, [X18], #8
    STR  X19, [X18], #8
    STR  X19, [X18], #8
    STR  X2, [X18], #8
    STR  X12, [X18], #8
    STR  X25, [X18], #8
    STR  X26, [X18], #8
    DMB  #0
    DSB  ISHLD
    ADD  X18, X30, X8, ASR #0
    PRFM  #0x0, [X18, #0]
    ADD  X18, X18, X4
    PRFM  #0x1, [X18, #0]
    ADD  X18, X18, X4
    PRFM  #0x2, [X18, #0]
    ADD  X18, X18, X4, LSR #0
    PRFM  #0x3, [X18, #0]
    ADD  X18, X18, X4, ASR #0
    PRFM #0x0, [X18, X5, LSL #0]
    ADD  X18, X18, X4, LSR #0
    PRFM #0x1, [X18, X5, LSL #0]
    ADD  X18, X18, X4, ASR #0
    PRFM #0x2, [X18, X5, LSL #0]
    ADD  X18, X18, X4
    PRFM #0x3, [X18, X5, LSL #0]
    ADD  X18, X18, X4, LSR #0
    PRFM #0x0, [X18, W5, SXTW #0]
    ADD  X18, X18, X4, LSR #0
    PRFM #0x1, [X18, W5, SXTW #0]
    ADD  X18, X18, X4
    PRFM #0x2, [X18, W5, SXTW #0]
    ADD  X18, X18, X4
    PRFM #0x3, [X18, W5, SXTW #0]
    ADD  X18, X18, X4
    PRFM #0x0, [X18, X5, SXTX #0]
    ADD  X18, X18, X4, LSR #0
    PRFM #0x1, [X18, X5, SXTX #0]
    ADD  X18, X18, X4
    PRFM #0x2, [X18, X5, SXTX #0]
    ADD  X18, X18, X4, LSR #0
    PRFM #0x3, [X18, X5, SXTX #0]
    ADD  X18, X18, X4
    PRFM #0x0, [X18, W5, UXTW #0]
    ADD  X18, X18, X4, LSR #0
    PRFM #0x1, [X18, W5, UXTW #0]
    ADD  X18, X18, X4, LSR #0
    PRFM #0x2, [X18, W5, UXTW #0]
    ADD  X18, X18, X4
    PRFM #0x3, [X18, W5, UXTW #0]
    ADD  X18, X18, X4
    PRFUM #0x0, [X18, #0]
    ADD  X18, X18, X4, LSR #0
    PRFUM #0x1, [X18, #0]
    ADD  X18, X18, X4, ASR #0
    PRFUM #0x2, [X18, #0]
    ADD  X18, X18, X4
    PRFUM #0x3, [X18, #0]
    ADD  X18, X18, X4, LSR #0
    ADD  X18, X30, X8, LSR #0
    LDR  X26, [X18], #8
    LDR  X16, [X18], #8
    LDR  X17, [X18], #8
    LDR  X14, [X18], #8
    LDR  X12, [X18], #8
    LDR  X12, [X18], #8
    LDR  X12, [X18], #8
    LDR  X28, [X18], #8
    LDR  X7, [X18], #8
    LDR  X17, [X18], #8
    LDR  X22, [X18], #8
    LDR  X22, [X18], #8
    LDR  X27, [X18], #8
    LDR  X14, [X18], #8
    LDR  X2, [X18], #8
    LDR  X6, [X18], #8
    LDR  X13, [X18], #8
    LDR  X19, [X18], #8
    LDR  X2, [X18], #8
    LDR  X26, [X18], #8
    LDR  X7, [X18], #8
    LDR  X11, [X18], #8
    LDR  X14, [X18], #8
    LDR  X17, [X18], #8
    LDR  X14, [X18], #8
    LDR  X22, [X18], #8
    LDR  X25, [X18], #8
    LDR  X14, [X18], #8
    LDR  X19, [X18], #8
    LDR  X26, [X18], #8
    LDR  X14, [X18], #8
    LDR  X27, [X18], #8
    LDR  X16, [X18], #8
    LDR  X11, [X18], #8
    LDR  X19, [X18], #8
    LDR  X2, [X18], #8
    LDR  X25, [X18], #8
    LDR  X14, [X18], #8
    LDR  X16, [X18], #8
    LDR  X19, [X18], #8
    DMB  OSH
    DSB  NSHLD
    ADD  X18, X30, X8
    PRFM  #0x10, [X18, #0]
    ADD  X18, X18, X4, LSR #0
    PRFM  #0x11, [X18, #0]
    ADD  X18, X18, X4
    PRFM  #0x12, [X18, #0]
    ADD  X18, X18, X4, ASR #0
    PRFM  #0x13, [X18, #0]
    ADD  X18, X18, X4, ASR #0
    PRFM #0x10, [X18, X5, LSL #0]
    ADD  X18, X18, X4, ASR #0
    PRFM #0x11, [X18, X5, LSL #0]
    ADD  X18, X18, X4, LSR #0
    PRFM #0x12, [X18, X5, LSL #0]
    ADD  X18, X18, X4, ASR #0
    PRFM #0x13, [X18, X5, LSL #0]
    ADD  X18, X18, X4, LSR #0
    PRFM #0x10, [X18, W5, SXTW #0]
    ADD  X18, X18, X4
    PRFM #0x11, [X18, W5, SXTW #0]
    ADD  X18, X18, X4, ASR #0
    PRFM #0x12, [X18, W5, SXTW #0]
    ADD  X18, X18, X4
    PRFM #0x13, [X18, W5, SXTW #0]
    ADD  X18, X18, X4
    PRFM #0x10, [X18, X5, SXTX #0]
    ADD  X18, X18, X4, LSR #0
    PRFM #0x11, [X18, X5, SXTX #0]
    ADD  X18, X18, X4, LSR #0
    PRFM #0x12, [X18, X5, SXTX #0]
    ADD  X18, X18, X4, LSR #0
    PRFM #0x13, [X18, X5, SXTX #0]
    ADD  X18, X18, X4, ASR #0
    PRFM #0x10, [X18, W5, UXTW #0]
    ADD  X18, X18, X4
    PRFM #0x11, [X18, W5, UXTW #0]
    ADD  X18, X18, X4, LSR #0
    PRFM #0x12, [X18, W5, UXTW #0]
    ADD  X18, X18, X4, LSR #0
    PRFM #0x13, [X18, W5, UXTW #0]
    ADD  X18, X18, X4, ASR #0
    PRFUM #0x10, [X18, #0]
    ADD  X18, X18, X4, ASR #0
    PRFUM #0x11, [X18, #0]
    ADD  X18, X18, X4
    PRFUM #0x12, [X18, #0]
    ADD  X18, X18, X4
    PRFUM #0x13, [X18, #0]
    ADD  X18, X18, X4
    ADD  X18, X30, X8, ASR #0
    STR  X13, [X18], #8
    STR  X27, [X18], #8
    STR  X7, [X18], #8
    STR  X27, [X18], #8
    STR  X14, [X18], #8
    STR  X19, [X18], #8
    STR  X22, [X18], #8
    STR  X22, [X18], #8
    STR  X7, [X18], #8
    STR  X20, [X18], #8
    STR  X11, [X18], #8
    STR  X27, [X18], #8
    STR  X13, [X18], #8
    STR  X10, [X18], #8
    STR  X5, [X18], #8
    STR  X12, [X18], #8
    STR  X10, [X18], #8
    STR  X27, [X18], #8
    STR  X6, [X18], #8
    STR  X2, [X18], #8
    STR  X19, [X18], #8
    STR  X12, [X18], #8
    STR  X7, [X18], #8
    STR  X19, [X18], #8
    STR  X27, [X18], #8
    STR  X16, [X18], #8
    STR  X17, [X18], #8
    STR  X5, [X18], #8
    STR  X10, [X18], #8
    STR  X22, [X18], #8
    STR  X10, [X18], #8
    STR  X20, [X18], #8
    STR  X25, [X18], #8
    STR  X20, [X18], #8
    STR  X14, [X18], #8
    STR  X11, [X18], #8
    STR  X26, [X18], #8
    STR  X25, [X18], #8
    STR  X11, [X18], #8
    STR  X11, [X18], #8
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X21, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceLoadStoreP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X21, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceLoadStoreP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X21, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceLoadStoreP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X21, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceLoadStoreP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X21, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceLoadStoreP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X21, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceLoadStoreP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X21, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceLoadStoreP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X21, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceLoadStoreP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X21, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceLoadStoreP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X21, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceLoadStoreP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X21, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceLoadStoreP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X21, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceLoadStoreP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X21, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceLoadStoreP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X21, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceLoadStoreP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X21, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceLoadStoreP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X21, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceLoadStoreP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X21, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceLoadStoreP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X21, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, EnhanceLoadStoreP01_TestFail
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
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X4, #0x8, LSL #0
    MOVZ  X13, #0x1e0, LSL #0
    ADD  X28, X30, X13, ASR #0
    STR  X22, [X28], #8
    STR  X26, [X28], #8
    STR  X21, [X28], #8
    STR  X27, [X28], #8
    STR  X18, [X28], #8
    STR  X18, [X28], #8
    STR  X10, [X28], #8
    STR  X16, [X28], #8
    STR  X17, [X28], #8
    STR  X3, [X28], #8
    STR  X20, [X28], #8
    STR  X22, [X28], #8
    STR  X11, [X28], #8
    STR  X8, [X28], #8
    STR  X10, [X28], #8
    STR  X17, [X28], #8
    STR  X25, [X28], #8
    STR  X12, [X28], #8
    STR  X12, [X28], #8
    STR  X20, [X28], #8
    STR  X12, [X28], #8
    STR  X27, [X28], #8
    STR  X3, [X28], #8
    STR  X18, [X28], #8
    STR  X3, [X28], #8
    STR  X8, [X28], #8
    STR  X18, [X28], #8
    STR  X23, [X28], #8
    STR  X6, [X28], #8
    STR  X20, [X28], #8
    STR  X5, [X28], #8
    STR  X25, [X28], #8
    STR  X7, [X28], #8
    STR  X18, [X28], #8
    STR  X5, [X28], #8
    STR  X22, [X28], #8
    STR  X12, [X28], #8
    STR  X6, [X28], #8
    STR  X27, [X28], #8
    STR  X5, [X28], #8
    DMB  #12
    DSB  OSHLD
    ADD  X28, X30, X13
    PRFM  #0x0, [X28, #0]
    ADD  X28, X28, X4, ASR #0
    PRFM  #0x1, [X28, #0]
    ADD  X28, X28, X4, ASR #0
    PRFM  #0x2, [X28, #0]
    ADD  X28, X28, X4
    PRFM  #0x3, [X28, #0]
    ADD  X28, X28, X4
    PRFM #0x0, [X28, X21, LSL #0]
    ADD  X28, X28, X4, ASR #0
    PRFM #0x1, [X28, X21, LSL #0]
    ADD  X28, X28, X4
    PRFM #0x2, [X28, X21, LSL #0]
    ADD  X28, X28, X4, ASR #0
    PRFM #0x3, [X28, X21, LSL #0]
    ADD  X28, X28, X4, ASR #0
    PRFM #0x0, [X28, W21, SXTW #0]
    ADD  X28, X28, X4, ASR #0
    PRFM #0x1, [X28, W21, SXTW #0]
    ADD  X28, X28, X4
    PRFM #0x2, [X28, W21, SXTW #0]
    ADD  X28, X28, X4, ASR #0
    PRFM #0x3, [X28, W21, SXTW #0]
    ADD  X28, X28, X4, LSR #0
    PRFM #0x0, [X28, X21, SXTX #0]
    ADD  X28, X28, X4, ASR #0
    PRFM #0x1, [X28, X21, SXTX #0]
    ADD  X28, X28, X4, ASR #0
    PRFM #0x2, [X28, X21, SXTX #0]
    ADD  X28, X28, X4, ASR #0
    PRFM #0x3, [X28, X21, SXTX #0]
    ADD  X28, X28, X4, ASR #0
    PRFM #0x0, [X28, W21, UXTW #0]
    ADD  X28, X28, X4, ASR #0
    PRFM #0x1, [X28, W21, UXTW #0]
    ADD  X28, X28, X4
    PRFM #0x2, [X28, W21, UXTW #0]
    ADD  X28, X28, X4, LSR #0
    PRFM #0x3, [X28, W21, UXTW #0]
    ADD  X28, X28, X4, ASR #0
    PRFUM #0x0, [X28, #0]
    ADD  X28, X28, X4
    PRFUM #0x1, [X28, #0]
    ADD  X28, X28, X4, LSR #0
    PRFUM #0x2, [X28, #0]
    ADD  X28, X28, X4, LSR #0
    PRFUM #0x3, [X28, #0]
    ADD  X28, X28, X4, LSR #0
    ADD  X28, X30, X13
    LDR  X18, [X28], #8
    LDR  X8, [X28], #8
    LDR  X11, [X28], #8
    LDR  X5, [X28], #8
    LDR  X3, [X28], #8
    LDR  X22, [X28], #8
    LDR  X17, [X28], #8
    LDR  X11, [X28], #8
    LDR  X25, [X28], #8
    LDR  X10, [X28], #8
    LDR  X23, [X28], #8
    LDR  X25, [X28], #8
    LDR  X11, [X28], #8
    LDR  X25, [X28], #8
    LDR  X8, [X28], #8
    LDR  X5, [X28], #8
    LDR  X20, [X28], #8
    LDR  X26, [X28], #8
    LDR  X7, [X28], #8
    LDR  X23, [X28], #8
    LDR  X22, [X28], #8
    LDR  X10, [X28], #8
    LDR  X7, [X28], #8
    LDR  X25, [X28], #8
    LDR  X16, [X28], #8
    LDR  X7, [X28], #8
    LDR  X18, [X28], #8
    LDR  X23, [X28], #8
    LDR  X27, [X28], #8
    LDR  X10, [X28], #8
    LDR  X7, [X28], #8
    LDR  X7, [X28], #8
    LDR  X11, [X28], #8
    LDR  X10, [X28], #8
    LDR  X6, [X28], #8
    LDR  X5, [X28], #8
    LDR  X26, [X28], #8
    LDR  X3, [X28], #8
    LDR  X25, [X28], #8
    LDR  X10, [X28], #8
    DMB  OSHST
    DSB  LD
    ADD  X28, X30, X13, LSR #0
    PRFM  #0x10, [X28, #0]
    ADD  X28, X28, X4, ASR #0
    PRFM  #0x11, [X28, #0]
    ADD  X28, X28, X4, LSR #0
    PRFM  #0x12, [X28, #0]
    ADD  X28, X28, X4
    PRFM  #0x13, [X28, #0]
    ADD  X28, X28, X4, ASR #0
    PRFM #0x10, [X28, X21, LSL #0]
    ADD  X28, X28, X4, ASR #0
    PRFM #0x11, [X28, X21, LSL #0]
    ADD  X28, X28, X4, ASR #0
    PRFM #0x12, [X28, X21, LSL #0]
    ADD  X28, X28, X4
    PRFM #0x13, [X28, X21, LSL #0]
    ADD  X28, X28, X4, LSR #0
    PRFM #0x10, [X28, W21, SXTW #0]
    ADD  X28, X28, X4, ASR #0
    PRFM #0x11, [X28, W21, SXTW #0]
    ADD  X28, X28, X4
    PRFM #0x12, [X28, W21, SXTW #0]
    ADD  X28, X28, X4, ASR #0
    PRFM #0x13, [X28, W21, SXTW #0]
    ADD  X28, X28, X4
    PRFM #0x10, [X28, X21, SXTX #0]
    ADD  X28, X28, X4, LSR #0
    PRFM #0x11, [X28, X21, SXTX #0]
    ADD  X28, X28, X4
    PRFM #0x12, [X28, X21, SXTX #0]
    ADD  X28, X28, X4
    PRFM #0x13, [X28, X21, SXTX #0]
    ADD  X28, X28, X4
    PRFM #0x10, [X28, W21, UXTW #0]
    ADD  X28, X28, X4, ASR #0
    PRFM #0x11, [X28, W21, UXTW #0]
    ADD  X28, X28, X4, LSR #0
    PRFM #0x12, [X28, W21, UXTW #0]
    ADD  X28, X28, X4
    PRFM #0x13, [X28, W21, UXTW #0]
    ADD  X28, X28, X4
    PRFUM #0x10, [X28, #0]
    ADD  X28, X28, X4
    PRFUM #0x11, [X28, #0]
    ADD  X28, X28, X4, ASR #0
    PRFUM #0x12, [X28, #0]
    ADD  X28, X28, X4, ASR #0
    PRFUM #0x13, [X28, #0]
    ADD  X28, X28, X4, ASR #0
    ADD  X28, X30, X13, LSR #0
    STR  X19, [X28], #8
    STR  X16, [X28], #8
    STR  X26, [X28], #8
    STR  X19, [X28], #8
    STR  X27, [X28], #8
    STR  X22, [X28], #8
    STR  X26, [X28], #8
    STR  X18, [X28], #8
    STR  X7, [X28], #8
    STR  X23, [X28], #8
    STR  X20, [X28], #8
    STR  X7, [X28], #8
    STR  X27, [X28], #8
    STR  X23, [X28], #8
    STR  X17, [X28], #8
    STR  X22, [X28], #8
    STR  X8, [X28], #8
    STR  X26, [X28], #8
    STR  X16, [X28], #8
    STR  X11, [X28], #8
    STR  X20, [X28], #8
    STR  X3, [X28], #8
    STR  X17, [X28], #8
    STR  X25, [X28], #8
    STR  X21, [X28], #8
    STR  X10, [X28], #8
    STR  X6, [X28], #8
    STR  X18, [X28], #8
    STR  X12, [X28], #8
    STR  X12, [X28], #8
    STR  X20, [X28], #8
    STR  X16, [X28], #8
    STR  X21, [X28], #8
    STR  X8, [X28], #8
    STR  X3, [X28], #8
    STR  X19, [X28], #8
    STR  X7, [X28], #8
    STR  X21, [X28], #8
    STR  X26, [X28], #8
    STR  X5, [X28], #8
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceLoadStoreP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceLoadStoreP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceLoadStoreP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceLoadStoreP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceLoadStoreP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceLoadStoreP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceLoadStoreP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceLoadStoreP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceLoadStoreP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceLoadStoreP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceLoadStoreP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceLoadStoreP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceLoadStoreP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceLoadStoreP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceLoadStoreP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceLoadStoreP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceLoadStoreP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, EnhanceLoadStoreP01_TestFail

EnhanceLoadStoreP01_TestEnd:
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
EnhanceLoadStoreP01_TestFail:
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
