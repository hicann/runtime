.global LCRTGeneralLoadStoreP01

.text
.p2align 4

LCRTGeneralLoadStoreP01:

LCRTGeneralLoadStoreP01_TestBegin:
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
    MOVZ  X2, #0x5fea, LSL #0
    MOVK  X2, #0xa23b, LSL #16
    MOVK  X2, #0x38b5, LSL #32
    MOVK  X2, #0x1b7f, LSL #48
    MOVZ  X3, #0x944f, LSL #0
    MOVK  X3, #0xa553, LSL #16
    MOVK  X3, #0x29ad, LSL #32
    MOVK  X3, #0x3594, LSL #48
    MOVZ  X4, #0xd39e, LSL #0
    MOVK  X4, #0x2db0, LSL #16
    MOVK  X4, #0x846, LSL #32
    MOVK  X4, #0x4b93, LSL #48
    MOVZ  X5, #0xc541, LSL #0
    MOVK  X5, #0x1d64, LSL #16
    MOVK  X5, #0xaf3f, LSL #32
    MOVK  X5, #0xa8a1, LSL #48
    MOVZ  X6, #0x25f4, LSL #0
    MOVK  X6, #0x4121, LSL #16
    MOVK  X6, #0x13f0, LSL #32
    MOVK  X6, #0x7302, LSL #48
    MOVZ  X7, #0x34f5, LSL #0
    MOVK  X7, #0x31e6, LSL #16
    MOVK  X7, #0x9a95, LSL #32
    MOVK  X7, #0x6462, LSL #48
    MOVZ  X8, #0x4f87, LSL #0
    MOVK  X8, #0x64f5, LSL #16
    MOVK  X8, #0x522a, LSL #32
    MOVK  X8, #0xd0ae, LSL #48
    MOVZ  X12, #0xf868, LSL #0
    MOVK  X12, #0xfa9e, LSL #16
    MOVK  X12, #0xd7e3, LSL #32
    MOVK  X12, #0xe2a1, LSL #48
    MOVZ  X13, #0x280e, LSL #0
    MOVK  X13, #0xb4c8, LSL #16
    MOVK  X13, #0xdc0f, LSL #32
    MOVK  X13, #0x451e, LSL #48
    MOVZ  X16, #0x63a4, LSL #0
    MOVK  X16, #0x434a, LSL #16
    MOVK  X16, #0x39bc, LSL #32
    MOVK  X16, #0xa5bf, LSL #48
    MOVZ  X17, #0x6736, LSL #0
    MOVK  X17, #0xe977, LSL #16
    MOVK  X17, #0xd9e1, LSL #32
    MOVK  X17, #0x8200, LSL #48
    MOVZ  X18, #0xa1d, LSL #0
    MOVK  X18, #0xbb7f, LSL #16
    MOVK  X18, #0x26ea, LSL #32
    MOVK  X18, #0xe26f, LSL #48
    MOVZ  X19, #0xc65, LSL #0
    MOVK  X19, #0x2b5c, LSL #16
    MOVK  X19, #0x9bc2, LSL #32
    MOVK  X19, #0xce98, LSL #48
    MOVZ  X20, #0xb07, LSL #0
    MOVK  X20, #0x9c19, LSL #16
    MOVK  X20, #0x1b59, LSL #32
    MOVK  X20, #0xb0cf, LSL #48
    MOVZ  X21, #0xf903, LSL #0
    MOVK  X21, #0xf75e, LSL #16
    MOVK  X21, #0xe14d, LSL #32
    MOVK  X21, #0xb6c7, LSL #48
    MOVZ  X22, #0x751e, LSL #0
    MOVK  X22, #0x28ab, LSL #16
    MOVK  X22, #0xd7f4, LSL #32
    MOVK  X22, #0xc63c, LSL #48
    MOVZ  X23, #0xa7cd, LSL #0
    MOVK  X23, #0xe32d, LSL #16
    MOVK  X23, #0x6605, LSL #32
    MOVK  X23, #0xf71c, LSL #48
    MOVZ  X24, #0x4bdb, LSL #0
    MOVK  X24, #0x6ee6, LSL #16
    MOVK  X24, #0x7924, LSL #32
    MOVK  X24, #0x5a2, LSL #48
    MOVZ  X25, #0x76f0, LSL #0
    MOVK  X25, #0xcc2e, LSL #16
    MOVK  X25, #0x751d, LSL #32
    MOVK  X25, #0x2621, LSL #48
    MOVZ  X26, #0x4c48, LSL #0
    MOVK  X26, #0xad18, LSL #16
    MOVK  X26, #0x68b1, LSL #32
    MOVK  X26, #0x5b21, LSL #48
    MOVZ  X27, #0x235a, LSL #0
    MOVK  X27, #0x21e3, LSL #16
    MOVK  X27, #0xd7a6, LSL #32
    MOVK  X27, #0x37a7, LSL #48
    MOVZ  X28, #0xeacf, LSL #0
    MOVK  X28, #0x49a, LSL #16
    MOVK  X28, #0x9440, LSL #32
    MOVK  X28, #0x9364, LSL #48
    MOVZ  X29, #0x33fb, LSL #0
    MOVK  X29, #0x881, LSL #16
    MOVK  X29, #0x6d54, LSL #32
    MOVK  X29, #0x9ffe, LSL #48
    ADDS  W12, W19, #0xc77
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X13, #0x10, LSL #0
    MOVZ  X26, #0x0, LSL #0
    ADD  X16, X30, X26, ASR #0
    STLLRB W29,[X16]
    LDLARB W12,[X16]
    ADD  X16, X16, X13
    STLLRH W12,[X16]
    LDLARH W18,[X16]
    ADD  X16, X16, X13, ASR #0
    STLLR W20,[X16]
    LDLAR W17,[X16]
    ADD  X16, X16, X13
    STLLR X18,[X16]
    LDLAR X4,[X16]
    ADD  X16, X16, X13, LSR #0
    STP  X27, X4, [X16, #0]
    CASB W17, W25, [X16]
    ADD  X16, X16, X13, ASR #0
    STP  X21, X3, [X16, #0]
    CASAB W19, W6, [X16]
    ADD  X16, X16, X13
    STP  X4, X17, [X16, #0]
    CASALB W5, W23, [X16]
    ADD  X16, X16, X13, ASR #0
    STP  X4, X22, [X16, #0]
    CASLB W20, W29, [X16]
    ADD  X16, X16, X13
    STP  X29, X20, [X16, #0]
    CASH W3, W27, [X16]
    ADD  X16, X16, X13
    STP  X19, X3, [X16, #0]
    CASAH W6, W7, [X16]
    ADD  X16, X16, X13
    STP  X4, X22, [X16, #0]
    CASALH W22, W22, [X16]
    ADD  X16, X16, X13
    STP  X24, X29, [X16, #0]
    CASLH W21, W23, [X16]
    ADD  X16, X16, X13, ASR #0
    STP  X29, X29, [X16, #0]
    CAS W18, W23, [X16]
    ADD  X16, X16, X13
    STP  X4, X5, [X16, #0]
    CAS X18, X19, [X16]
    ADD  X16, X16, X13, ASR #0
    STP  X19, X25, [X16, #0]
    CASA W17, W25, [X16]
    ADD  X16, X16, X13
    STP  X24, X21, [X16, #0]
    CASA X12, X24, [X16]
    ADD  X16, X16, X13, ASR #0
    STP  X3, X29, [X16, #0]
    CASAL W8, W4, [X16]
    ADD  X16, X16, X13
    STP  X6, X18, [X16, #0]
    CASAL X19, X21, [X16]
    ADD  X16, X16, X13, ASR #0
    STP  X18, X27, [X16, #0]
    CASL W6, W23, [X16]
    ADD  X16, X16, X13, LSR #0
    STP  X22, X23, [X16, #0]
    CASL X29, X8, [X16]
    ADD  X16, X16, X13
    STP  X21, X3, [X16, #0]
    CASP W22, W23, W24, W25, [X16]
    ADD  X16, X16, X13, LSR #0
    STP  X22, X8, [X16, #0]
    CASP X6, X7, X20, X21, [X16]
    ADD  X16, X16, X13, LSR #0
    STP  X20, X8, [X16, #0]
    CASPA W4, W5, W22, W23, [X16]
    ADD  X16, X16, X13, LSR #0
    STP  X12, X25, [X16, #0]
    CASPA X4, X5, X6, X7, [X16]
    ADD  X16, X16, X13
    STP  X19, X20, [X16, #0]
    CASPAL W4, W5, W4, W5, [X16]
    ADD  X16, X16, X13
    STP  X4, X4, [X16, #0]
    CASPAL X18, X19, X18, X19, [X16]
    ADD  X16, X16, X13, ASR #0
    STP  X5, X29, [X16, #0]
    CASPL W18, W19, W22, W23, [X16]
    ADD  X16, X16, X13
    STP  X21, X19, [X16, #0]
    CASPL X18, X19, X18, X19, [X16]
    ADD  X16, X16, X13, ASR #0
    STLUR X19,[X16,#0]
    LDAPRB W8, [X16]
    ADD  X16, X16, X13, LSR #0
    STLUR X7,[X16,#0]
    LDAPRH W23, [X16]
    ADD  X16, X16, X13, LSR #0
    STLUR X20,[X16,#0]
    LDAPR W20, [X16]
    ADD  X16, X16, X13, LSR #0
    STLUR X22,[X16,#0]
    LDAPR X7, [X16]
    ADD  X16, X16, X13
    STLUR W24,[X16,#0]
    LDAPUR W29,[X16,#0]
    ADD  X16, X16, X13, ASR #0
    STLUR X25,[X16,#0]
    LDAPUR X24,[X16,#0]
    ADD  X16, X16, X13, LSR #0
    STLURB W27,[X16,#0]
    LDAPURB W17,[X16,#0]
    ADD  X16, X16, X13
    STLURH W17,[X16,#0]
    LDAPURH W7,[X16,#0]
    ADD  X16, X16, X13, LSR #0
    STLUR X23,[X16,#0]
    LDAPURSB W18,[X16,#0]
    ADD  X16, X16, X13, LSR #0
    STLUR X18,[X16,#0]
    LDAPURSB X22,[X16,#0]
    ADD  X16, X16, X13, ASR #0
    STLUR X29,[X16,#0]
    LDAPURSH W18,[X16,#0]
    ADD  X16, X16, X13, ASR #0
    STLUR X22,[X16,#0]
    LDAPURSH X29,[X16,#0]
    ADD  X16, X16, X13
    STLUR X24,[X16,#0]
    LDAPURSW X4,[X16,#0]
    ADD  X16, X16, X13
    MOVZ  X2, #0x5a5a, LSL #0
    SUB  X28, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    SUB  X28, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X28, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X28, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X28, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    SUB  X28, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X28, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    SUB  X28, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X28, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    SUB  X28, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X28, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X2, #0x5a, LSL #0
    SUB  X28, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP01_TestFail
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
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X4, #0x10, LSL #0
    MOVZ  X19, #0x280, LSL #0
    ADD  X22, X30, X19
    STLLRB W17,[X22]
    LDLARB W21,[X22]
    ADD  X22, X22, X4, ASR #0
    STLLRH W17,[X22]
    LDLARH W7,[X22]
    ADD  X22, X22, X4
    STLLR W27,[X22]
    LDLAR W17,[X22]
    ADD  X22, X22, X4, LSR #0
    STLLR X17,[X22]
    LDLAR X16,[X22]
    ADD  X22, X22, X4, LSR #0
    STP  X17, X3, [X22, #0]
    CASB W16, W21, [X22]
    ADD  X22, X22, X4, ASR #0
    STP  X6, X29, [X22, #0]
    CASAB W27, W16, [X22]
    ADD  X22, X22, X4, LSR #0
    STP  X7, X27, [X22, #0]
    CASALB W28, W23, [X22]
    ADD  X22, X22, X4, ASR #0
    STP  X23, X7, [X22, #0]
    CASLB W20, W3, [X22]
    ADD  X22, X22, X4, LSR #0
    STP  X6, X28, [X22, #0]
    CASH W7, W17, [X22]
    ADD  X22, X22, X4
    STP  X6, X24, [X22, #0]
    CASAH W5, W25, [X22]
    ADD  X22, X22, X4, ASR #0
    STP  X16, X13, [X22, #0]
    CASALH W26, W18, [X22]
    ADD  X22, X22, X4, ASR #0
    STP  X28, X28, [X22, #0]
    CASLH W27, W18, [X22]
    ADD  X22, X22, X4, ASR #0
    STP  X28, X3, [X22, #0]
    CAS W29, W24, [X22]
    ADD  X22, X22, X4, LSR #0
    STP  X21, X2, [X22, #0]
    CAS X3, X2, [X22]
    ADD  X22, X22, X4
    STP  X18, X20, [X22, #0]
    CASA W7, W20, [X22]
    ADD  X22, X22, X4, LSR #0
    STP  X20, X7, [X22, #0]
    CASA X20, X3, [X22]
    ADD  X22, X22, X4
    STP  X13, X23, [X22, #0]
    CASAL W5, W6, [X22]
    ADD  X22, X22, X4, ASR #0
    STP  X20, X23, [X22, #0]
    CASAL X2, X20, [X22]
    ADD  X22, X22, X4, LSR #0
    STP  X17, X28, [X22, #0]
    CASL W7, W23, [X22]
    ADD  X22, X22, X4
    STP  X3, X21, [X22, #0]
    CASL X24, X21, [X22]
    ADD  X22, X22, X4, LSR #0
    STP  X26, X23, [X22, #0]
    CASP W24, W25, W24, W25, [X22]
    ADD  X22, X22, X4, LSR #0
    STP  X5, X3, [X22, #0]
    CASP X16, X17, X16, X17, [X22]
    ADD  X22, X22, X4
    STP  X16, X24, [X22, #0]
    CASPA W26, W27, W26, W27, [X22]
    ADD  X22, X22, X4
    STP  X26, X5, [X22, #0]
    CASPA X20, X21, X20, X21, [X22]
    ADD  X22, X22, X4, LSR #0
    STP  X25, X25, [X22, #0]
    CASPAL W20, W21, W20, W21, [X22]
    ADD  X22, X22, X4, LSR #0
    STP  X20, X7, [X22, #0]
    CASPAL X26, X27, X6, X7, [X22]
    ADD  X22, X22, X4, LSR #0
    STP  X21, X26, [X22, #0]
    CASPL W2, W3, W2, W3, [X22]
    ADD  X22, X22, X4, ASR #0
    STP  X17, X27, [X22, #0]
    CASPL X2, X3, X24, X25, [X22]
    ADD  X22, X22, X4, LSR #0
    STLUR X18,[X22,#0]
    LDAPRB W17, [X22]
    ADD  X22, X22, X4
    STLUR X29,[X22,#0]
    LDAPRH W23, [X22]
    ADD  X22, X22, X4
    STLUR X5,[X22,#0]
    LDAPR W3, [X22]
    ADD  X22, X22, X4, ASR #0
    STLUR X25,[X22,#0]
    LDAPR X21, [X22]
    ADD  X22, X22, X4
    STLUR W16,[X22,#0]
    LDAPUR W17,[X22,#0]
    ADD  X22, X22, X4, ASR #0
    STLUR X18,[X22,#0]
    LDAPUR X29,[X22,#0]
    ADD  X22, X22, X4, LSR #0
    STLURB W5,[X22,#0]
    LDAPURB W25,[X22,#0]
    ADD  X22, X22, X4, ASR #0
    STLURH W18,[X22,#0]
    LDAPURH W26,[X22,#0]
    ADD  X22, X22, X4
    STLUR X26,[X22,#0]
    LDAPURSB W27,[X22,#0]
    ADD  X22, X22, X4, LSR #0
    STLUR X3,[X22,#0]
    LDAPURSB X5,[X22,#0]
    ADD  X22, X22, X4, ASR #0
    STLUR X5,[X22,#0]
    LDAPURSH W18,[X22,#0]
    ADD  X22, X22, X4, LSR #0
    STLUR X21,[X22,#0]
    LDAPURSH X29,[X22,#0]
    ADD  X22, X22, X4, ASR #0
    STLUR X25,[X22,#0]
    LDAPURSW X21,[X22,#0]
    ADD  X22, X22, X4
    MOVZ  X12, #0xa5, LSL #0
    SUB  X8, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    SUB  X8, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X12, #0xffa5, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X8, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    SUB  X8, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X8, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    SUB  X8, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    SUB  X8, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X12, #0xffa5, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X8, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X12, #0xa5, LSL #0
    SUB  X8, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X12, #0xa5, LSL #0
    SUB  X8, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X12, #0xa5, LSL #0
    SUB  X8, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X12, #0xa5, LSL #0
    SUB  X8, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    SUB  X8, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X12, #0xffa5, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X8, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X12, #0xa5, LSL #0
    SUB  X8, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
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
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X22, #0x10, LSL #0
    MOVZ  X2, #0x500, LSL #0
    ADD  X26, X30, X2, LSR #0
    STLLRB W5,[X26]
    LDLARB W4,[X26]
    ADD  X26, X26, X22
    STLLRH W29,[X26]
    LDLARH W17,[X26]
    ADD  X26, X26, X22
    STLLR W6,[X26]
    LDLAR W16,[X26]
    ADD  X26, X26, X22, LSR #0
    STLLR X20,[X26]
    LDLAR X29,[X26]
    ADD  X26, X26, X22
    STP  X13, X4, [X26, #0]
    CASB W16, W29, [X26]
    ADD  X26, X26, X22
    STP  X17, X16, [X26, #0]
    CASAB W29, W18, [X26]
    ADD  X26, X26, X22
    STP  X29, X24, [X26, #0]
    CASALB W18, W6, [X26]
    ADD  X26, X26, X22
    STP  X18, X12, [X26, #0]
    CASLB W24, W20, [X26]
    ADD  X26, X26, X22
    STP  X25, X29, [X26, #0]
    CASH W24, W16, [X26]
    ADD  X26, X26, X22, LSR #0
    STP  X18, X3, [X26, #0]
    CASAH W4, W4, [X26]
    ADD  X26, X26, X22
    STP  X20, X4, [X26, #0]
    CASALH W28, W27, [X26]
    ADD  X26, X26, X22, LSR #0
    STP  X21, X29, [X26, #0]
    CASLH W25, W16, [X26]
    ADD  X26, X26, X22, ASR #0
    STP  X27, X21, [X26, #0]
    CAS W16, W19, [X26]
    ADD  X26, X26, X22
    STP  X21, X19, [X26, #0]
    CAS X29, X13, [X26]
    ADD  X26, X26, X22, LSR #0
    STP  X13, X18, [X26, #0]
    CASA W3, W25, [X26]
    ADD  X26, X26, X22, ASR #0
    STP  X5, X17, [X26, #0]
    CASA X29, X17, [X26]
    ADD  X26, X26, X22, ASR #0
    STP  X12, X25, [X26, #0]
    CASAL W12, W16, [X26]
    ADD  X26, X26, X22, LSR #0
    STP  X27, X4, [X26, #0]
    CASAL X24, X21, [X26]
    ADD  X26, X26, X22, ASR #0
    STP  X3, X21, [X26, #0]
    CASL W25, W18, [X26]
    ADD  X26, X26, X22
    STP  X28, X20, [X26, #0]
    CASL X4, X19, [X26]
    ADD  X26, X26, X22, ASR #0
    STP  X21, X29, [X26, #0]
    CASP W12, W13, W28, W29, [X26]
    ADD  X26, X26, X22, LSR #0
    STP  X24, X28, [X26, #0]
    CASP X24, X25, X12, X13, [X26]
    ADD  X26, X26, X22, LSR #0
    STP  X5, X18, [X26, #0]
    CASPA W16, W17, W12, W13, [X26]
    ADD  X26, X26, X22
    STP  X17, X24, [X26, #0]
    CASPA X24, X25, X4, X5, [X26]
    ADD  X26, X26, X22
    STP  X12, X29, [X26, #0]
    CASPAL W24, W25, W24, W25, [X26]
    ADD  X26, X26, X22
    STP  X3, X28, [X26, #0]
    CASPAL X16, X17, X28, X29, [X26]
    ADD  X26, X26, X22
    STP  X3, X20, [X26, #0]
    CASPL W16, W17, W20, W21, [X26]
    ADD  X26, X26, X22, LSR #0
    STP  X12, X12, [X26, #0]
    CASPL X20, X21, X4, X5, [X26]
    ADD  X26, X26, X22
    STLUR X19,[X26,#0]
    LDAPRB W23, [X26]
    ADD  X26, X26, X22, LSR #0
    STLUR X6,[X26,#0]
    LDAPRH W29, [X26]
    ADD  X26, X26, X22, ASR #0
    STLUR X20,[X26,#0]
    LDAPR W12, [X26]
    ADD  X26, X26, X22, ASR #0
    STLUR X12,[X26,#0]
    LDAPR X20, [X26]
    ADD  X26, X26, X22, ASR #0
    STLUR W12,[X26,#0]
    LDAPUR W12,[X26,#0]
    ADD  X26, X26, X22, ASR #0
    STLUR X5,[X26,#0]
    LDAPUR X6,[X26,#0]
    ADD  X26, X26, X22, ASR #0
    STLURB W6,[X26,#0]
    LDAPURB W28,[X26,#0]
    ADD  X26, X26, X22, ASR #0
    STLURH W23,[X26,#0]
    LDAPURH W23,[X26,#0]
    ADD  X26, X26, X22
    STLUR X5,[X26,#0]
    LDAPURSB W5,[X26,#0]
    ADD  X26, X26, X22, LSR #0
    STLUR X5,[X26,#0]
    LDAPURSB X20,[X26,#0]
    ADD  X26, X26, X22, LSR #0
    STLUR X5,[X26,#0]
    LDAPURSH W6,[X26,#0]
    ADD  X26, X26, X22, ASR #0
    STLUR X6,[X26,#0]
    LDAPURSH X24,[X26,#0]
    ADD  X26, X26, X22
    STLUR X12,[X26,#0]
    LDAPURSW X21,[X26,#0]
    ADD  X26, X26, X22
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    SUB  X8, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    SUB  X8, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x5a, LSL #0
    SUB  X8, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x5a, LSL #0
    SUB  X8, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    SUB  X8, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    SUB  X8, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    SUB  X8, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x5a, LSL #0
    SUB  X8, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x5a, LSL #0
    SUB  X8, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    SUB  X8, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x5a, LSL #0
    SUB  X8, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X8, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x5a, LSL #0
    SUB  X8, X7, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    SUB  X8, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
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
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X12, #0x10, LSL #0
    MOVZ  X25, #0x780, LSL #0
    ADD  X8, X30, X25, LSR #0
    STLLRB W27,[X8]
    LDLARB W28,[X8]
    ADD  X8, X8, X12
    STLLRH W26,[X8]
    LDLARH W16,[X8]
    ADD  X8, X8, X12, ASR #0
    STLLR W2,[X8]
    LDLAR W6,[X8]
    ADD  X8, X8, X12, ASR #0
    STLLR X16,[X8]
    LDLAR X21,[X8]
    ADD  X8, X8, X12, LSR #0
    STP  X28, X16, [X8, #0]
    CASB W6, W19, [X8]
    ADD  X8, X8, X12, LSR #0
    STP  X19, X29, [X8, #0]
    CASAB W6, W6, [X8]
    ADD  X8, X8, X12, ASR #0
    STP  X21, X21, [X8, #0]
    CASALB W18, W24, [X8]
    ADD  X8, X8, X12, ASR #0
    STP  X6, X18, [X8, #0]
    CASLB W5, W6, [X8]
    ADD  X8, X8, X12
    STP  X19, X27, [X8, #0]
    CASH W13, W23, [X8]
    ADD  X8, X8, X12
    STP  X26, X16, [X8, #0]
    CASAH W13, W29, [X8]
    ADD  X8, X8, X12
    STP  X2, X20, [X8, #0]
    CASALH W28, W27, [X8]
    ADD  X8, X8, X12, ASR #0
    STP  X29, X7, [X8, #0]
    CASLH W7, W18, [X8]
    ADD  X8, X8, X12, ASR #0
    STP  X5, X17, [X8, #0]
    CAS W21, W17, [X8]
    ADD  X8, X8, X12, ASR #0
    STP  X21, X26, [X8, #0]
    CAS X21, X23, [X8]
    ADD  X8, X8, X12, ASR #0
    STP  X2, X24, [X8, #0]
    CASA W6, W20, [X8]
    ADD  X8, X8, X12, ASR #0
    STP  X29, X29, [X8, #0]
    CASA X7, X17, [X8]
    ADD  X8, X8, X12, ASR #0
    STP  X20, X24, [X8, #0]
    CASAL W2, W24, [X8]
    ADD  X8, X8, X12, LSR #0
    STP  X21, X13, [X8, #0]
    CASAL X6, X13, [X8]
    ADD  X8, X8, X12, LSR #0
    STP  X16, X16, [X8, #0]
    CASL W29, W29, [X8]
    ADD  X8, X8, X12
    STP  X24, X3, [X8, #0]
    CASL X23, X21, [X8]
    ADD  X8, X8, X12
    STP  X13, X16, [X8, #0]
    CASP W26, W27, W28, W29, [X8]
    ADD  X8, X8, X12, LSR #0
    STP  X17, X19, [X8, #0]
    CASP X18, X19, X20, X21, [X8]
    ADD  X8, X8, X12
    STP  X20, X7, [X8, #0]
    CASPA W26, W27, W18, W19, [X8]
    ADD  X8, X8, X12, LSR #0
    STP  X16, X6, [X8, #0]
    CASPA X6, X7, X2, X3, [X8]
    ADD  X8, X8, X12, ASR #0
    STP  X24, X6, [X8, #0]
    CASPAL W26, W27, W6, W7, [X8]
    ADD  X8, X8, X12, LSR #0
    STP  X13, X13, [X8, #0]
    CASPAL X16, X17, X20, X21, [X8]
    ADD  X8, X8, X12, LSR #0
    STP  X23, X24, [X8, #0]
    CASPL W6, W7, W20, W21, [X8]
    ADD  X8, X8, X12, ASR #0
    STP  X3, X19, [X8, #0]
    CASPL X16, X17, X20, X21, [X8]
    ADD  X8, X8, X12, LSR #0
    STLUR X29,[X8,#0]
    LDAPRB W24, [X8]
    ADD  X8, X8, X12, LSR #0
    STLUR X27,[X8,#0]
    LDAPRH W29, [X8]
    ADD  X8, X8, X12
    STLUR X27,[X8,#0]
    LDAPR W28, [X8]
    ADD  X8, X8, X12
    STLUR X17,[X8,#0]
    LDAPR X21, [X8]
    ADD  X8, X8, X12
    STLUR W29,[X8,#0]
    LDAPUR W3,[X8,#0]
    ADD  X8, X8, X12, LSR #0
    STLUR X23,[X8,#0]
    LDAPUR X28,[X8,#0]
    ADD  X8, X8, X12, ASR #0
    STLURB W24,[X8,#0]
    LDAPURB W29,[X8,#0]
    ADD  X8, X8, X12
    STLURH W27,[X8,#0]
    LDAPURH W24,[X8,#0]
    ADD  X8, X8, X12, LSR #0
    STLUR X28,[X8,#0]
    LDAPURSB W24,[X8,#0]
    ADD  X8, X8, X12, ASR #0
    STLUR X21,[X8,#0]
    LDAPURSB X28,[X8,#0]
    ADD  X8, X8, X12, ASR #0
    STLUR X24,[X8,#0]
    LDAPURSH W16,[X8,#0]
    ADD  X8, X8, X12, ASR #0
    STLUR X3,[X8,#0]
    LDAPURSH X23,[X8,#0]
    ADD  X8, X8, X12, LSR #0
    STLUR X29,[X8,#0]
    LDAPURSW X29,[X8,#0]
    ADD  X8, X8, X12, LSR #0
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    SUB  X4, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0xa5, LSL #0
    SUB  X4, X22, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    SUB  X4, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    SUB  X4, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    SUB  X4, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0xffa5, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X4, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X4, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X4, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X4, X22, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X4, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X4, X22, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0xffa5, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X4, X22, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    SUB  X4, X22, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    SUB  X4, X22, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0xffa5, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X4, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0xa5, LSL #0
    SUB  X4, X22, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP01_TestFail
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
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X5, #0x10, LSL #0
    MOVZ  X24, #0xa00, LSL #0
    ADD  X3, X30, X24, ASR #0
    STLLRB W26,[X3]
    LDLARB W16,[X3]
    ADD  X3, X3, X5, ASR #0
    STLLRH W16,[X3]
    LDLARH W28,[X3]
    ADD  X3, X3, X5, ASR #0
    STLLR W8,[X3]
    LDLAR W19,[X3]
    ADD  X3, X3, X5
    STLLR X28,[X3]
    LDLAR X8,[X3]
    ADD  X3, X3, X5, ASR #0
    STP  X8, X27, [X3, #0]
    CASB W27, W19, [X3]
    ADD  X3, X3, X5, ASR #0
    STP  X27, X27, [X3, #0]
    CASAB W2, W17, [X3]
    ADD  X3, X3, X5, ASR #0
    STP  X28, X7, [X3, #0]
    CASALB W19, W16, [X3]
    ADD  X3, X3, X5
    STP  X6, X28, [X3, #0]
    CASLB W20, W16, [X3]
    ADD  X3, X3, X5
    STP  X12, X23, [X3, #0]
    CASH W4, W18, [X3]
    ADD  X3, X3, X5
    STP  X6, X4, [X3, #0]
    CASAH W27, W6, [X3]
    ADD  X3, X3, X5, ASR #0
    STP  X7, X25, [X3, #0]
    CASALH W18, W19, [X3]
    ADD  X3, X3, X5, ASR #0
    STP  X26, X7, [X3, #0]
    CASLH W8, W25, [X3]
    ADD  X3, X3, X5, ASR #0
    STP  X28, X7, [X3, #0]
    CAS W2, W21, [X3]
    ADD  X3, X3, X5, LSR #0
    STP  X27, X4, [X3, #0]
    CAS X18, X4, [X3]
    ADD  X3, X3, X5, LSR #0
    STP  X26, X7, [X3, #0]
    CASA W6, W16, [X3]
    ADD  X3, X3, X5, LSR #0
    STP  X25, X26, [X3, #0]
    CASA X20, X28, [X3]
    ADD  X3, X3, X5
    STP  X19, X28, [X3, #0]
    CASAL W8, W16, [X3]
    ADD  X3, X3, X5
    STP  X7, X18, [X3, #0]
    CASAL X28, X2, [X3]
    ADD  X3, X3, X5, ASR #0
    STP  X26, X17, [X3, #0]
    CASL W27, W27, [X3]
    ADD  X3, X3, X5, LSR #0
    STP  X16, X13, [X3, #0]
    CASL X20, X8, [X3]
    ADD  X3, X3, X5, ASR #0
    STP  X27, X20, [X3, #0]
    CASP W12, W13, W20, W21, [X3]
    ADD  X3, X3, X5, LSR #0
    STP  X18, X25, [X3, #0]
    CASP X20, X21, X6, X7, [X3]
    ADD  X3, X3, X5, ASR #0
    STP  X8, X4, [X3, #0]
    CASPA W12, W13, W20, W21, [X3]
    ADD  X3, X3, X5, ASR #0
    STP  X13, X27, [X3, #0]
    CASPA X12, X13, X18, X19, [X3]
    ADD  X3, X3, X5, ASR #0
    STP  X6, X13, [X3, #0]
    CASPAL W18, W19, W18, W19, [X3]
    ADD  X3, X3, X5, ASR #0
    STP  X13, X25, [X3, #0]
    CASPAL X20, X21, X16, X17, [X3]
    ADD  X3, X3, X5
    STP  X21, X7, [X3, #0]
    CASPL W26, W27, W20, W21, [X3]
    ADD  X3, X3, X5, ASR #0
    STP  X7, X17, [X3, #0]
    CASPL X18, X19, X18, X19, [X3]
    ADD  X3, X3, X5, LSR #0
    STLUR X19,[X3,#0]
    LDAPRB W6, [X3]
    ADD  X3, X3, X5
    STLUR X28,[X3,#0]
    LDAPRH W12, [X3]
    ADD  X3, X3, X5, ASR #0
    STLUR X21,[X3,#0]
    LDAPR W25, [X3]
    ADD  X3, X3, X5
    STLUR X17,[X3,#0]
    LDAPR X21, [X3]
    ADD  X3, X3, X5, LSR #0
    STLUR W13,[X3,#0]
    LDAPUR W7,[X3,#0]
    ADD  X3, X3, X5, ASR #0
    STLUR X26,[X3,#0]
    LDAPUR X19,[X3,#0]
    ADD  X3, X3, X5, LSR #0
    STLURB W27,[X3,#0]
    LDAPURB W13,[X3,#0]
    ADD  X3, X3, X5
    STLURH W7,[X3,#0]
    LDAPURH W26,[X3,#0]
    ADD  X3, X3, X5, LSR #0
    STLUR X26,[X3,#0]
    LDAPURSB W7,[X3,#0]
    ADD  X3, X3, X5, LSR #0
    STLUR X6,[X3,#0]
    LDAPURSB X6,[X3,#0]
    ADD  X3, X3, X5
    STLUR X20,[X3,#0]
    LDAPURSH W20,[X3,#0]
    ADD  X3, X3, X5, ASR #0
    STLUR X12,[X3,#0]
    LDAPURSH X26,[X3,#0]
    ADD  X3, X3, X5
    STLUR X26,[X3,#0]
    LDAPURSW X26,[X3,#0]
    ADD  X3, X3, X5, ASR #0
    MOVZ  X22, #0x5a, LSL #0
    SUB  X29, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    SUB  X29, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0x5a, LSL #0
    SUB  X29, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0x5a, LSL #0
    SUB  X29, X22, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    SUB  X29, X22, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0x5a, LSL #0
    SUB  X29, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0x5a, LSL #0
    SUB  X29, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X29, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    SUB  X29, X22, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    SUB  X29, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X29, X22, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    SUB  X29, X22, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    SUB  X29, X22, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    SUB  X29, X22, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X29, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
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
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X3, #0x10, LSL #0
    MOVZ  X27, #0xc80, LSL #0
    ADD  X19, X30, X27, ASR #0
    STLLRB W28,[X19]
    LDLARB W23,[X19]
    ADD  X19, X19, X3, ASR #0
    STLLRH W26,[X19]
    LDLARH W26,[X19]
    ADD  X19, X19, X3, ASR #0
    STLLR W26,[X19]
    LDLAR W21,[X19]
    ADD  X19, X19, X3
    STLLR X29,[X19]
    LDLAR X20,[X19]
    ADD  X19, X19, X3, ASR #0
    STP  X21, X8, [X19, #0]
    CASB W25, W13, [X19]
    ADD  X19, X19, X3
    STP  X20, X23, [X19, #0]
    CASAB W29, W22, [X19]
    ADD  X19, X19, X3, LSR #0
    STP  X26, X16, [X19, #0]
    CASALB W2, W12, [X19]
    ADD  X19, X19, X3, ASR #0
    STP  X28, X5, [X19, #0]
    CASLB W12, W6, [X19]
    ADD  X19, X19, X3, LSR #0
    STP  X25, X2, [X19, #0]
    CASH W16, W2, [X19]
    ADD  X19, X19, X3, ASR #0
    STP  X6, X24, [X19, #0]
    CASAH W28, W26, [X19]
    ADD  X19, X19, X3, LSR #0
    STP  X23, X28, [X19, #0]
    CASALH W8, W21, [X19]
    ADD  X19, X19, X3, LSR #0
    STP  X16, X13, [X19, #0]
    CASLH W21, W17, [X19]
    ADD  X19, X19, X3, ASR #0
    STP  X6, X23, [X19, #0]
    CAS W28, W25, [X19]
    ADD  X19, X19, X3, LSR #0
    STP  X12, X26, [X19, #0]
    CAS X8, X23, [X19]
    ADD  X19, X19, X3
    STP  X25, X8, [X19, #0]
    CASA W18, W23, [X19]
    ADD  X19, X19, X3, ASR #0
    STP  X29, X22, [X19, #0]
    CASA X25, X20, [X19]
    ADD  X19, X19, X3
    STP  X12, X2, [X19, #0]
    CASAL W29, W6, [X19]
    ADD  X19, X19, X3, LSR #0
    STP  X23, X28, [X19, #0]
    CASAL X12, X25, [X19]
    ADD  X19, X19, X3, LSR #0
    STP  X6, X6, [X19, #0]
    CASL W23, W22, [X19]
    ADD  X19, X19, X3, ASR #0
    STP  X23, X26, [X19, #0]
    CASL X8, X16, [X19]
    ADD  X19, X19, X3, LSR #0
    STP  X22, X22, [X19, #0]
    CASP W16, W17, W16, W17, [X19]
    ADD  X19, X19, X3
    STP  X22, X25, [X19, #0]
    CASP X20, X21, X24, X25, [X19]
    ADD  X19, X19, X3
    STP  X18, X22, [X19, #0]
    CASPA W22, W23, W16, W17, [X19]
    ADD  X19, X19, X3
    STP  X24, X2, [X19, #0]
    CASPA X16, X17, X16, X17, [X19]
    ADD  X19, X19, X3, ASR #0
    STP  X20, X22, [X19, #0]
    CASPAL W20, W21, W16, W17, [X19]
    ADD  X19, X19, X3, LSR #0
    STP  X25, X2, [X19, #0]
    CASPAL X22, X23, X16, X17, [X19]
    ADD  X19, X19, X3, LSR #0
    STP  X18, X24, [X19, #0]
    CASPL W22, W23, W20, W21, [X19]
    ADD  X19, X19, X3
    STP  X2, X22, [X19, #0]
    CASPL X24, X25, X24, X25, [X19]
    ADD  X19, X19, X3
    STLUR X24,[X19,#0]
    LDAPRB W22, [X19]
    ADD  X19, X19, X3, ASR #0
    STLUR X22,[X19,#0]
    LDAPRH W16, [X19]
    ADD  X19, X19, X3, ASR #0
    STLUR X23,[X19,#0]
    LDAPR W23, [X19]
    ADD  X19, X19, X3
    STLUR X20,[X19,#0]
    LDAPR X17, [X19]
    ADD  X19, X19, X3, ASR #0
    STLUR W26,[X19,#0]
    LDAPUR W2,[X19,#0]
    ADD  X19, X19, X3
    STLUR X25,[X19,#0]
    LDAPUR X20,[X19,#0]
    ADD  X19, X19, X3, LSR #0
    STLURB W16,[X19,#0]
    LDAPURB W22,[X19,#0]
    ADD  X19, X19, X3
    STLURH W22,[X19,#0]
    LDAPURH W28,[X19,#0]
    ADD  X19, X19, X3, ASR #0
    STLUR X2,[X19,#0]
    LDAPURSB W22,[X19,#0]
    ADD  X19, X19, X3, LSR #0
    STLUR X28,[X19,#0]
    LDAPURSB X2,[X19,#0]
    ADD  X19, X19, X3, ASR #0
    STLUR X22,[X19,#0]
    LDAPURSH W28,[X19,#0]
    ADD  X19, X19, X3, LSR #0
    STLUR X26,[X19,#0]
    LDAPURSH X5,[X19,#0]
    ADD  X19, X19, X3, LSR #0
    STLUR X17,[X19,#0]
    LDAPURSW X22,[X19,#0]
    ADD  X19, X19, X3, ASR #0
    MOVZ  X4, #0xffa5, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X7, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X7, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X7, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    SUB  X7, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0xa5, LSL #0
    SUB  X7, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0xa5, LSL #0
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    SUB  X7, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0xa5, LSL #0
    SUB  X7, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0xa5, LSL #0
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X7, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0xa5, LSL #0
    SUB  X7, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0xa5, LSL #0
    SUB  X7, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    SUB  X7, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0xffa5, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X7, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0xa5, LSL #0
    SUB  X7, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP01_TestFail
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X2, #0x10, LSL #0
    MOVZ  X28, #0xf00, LSL #0
    ADD  X22, X30, X28, LSR #0
    STLLRB W26,[X22]
    LDLARB W21,[X22]
    ADD  X22, X22, X2
    STLLRH W21,[X22]
    LDLARH W5,[X22]
    ADD  X22, X22, X2, LSR #0
    STLLR W19,[X22]
    LDLAR W4,[X22]
    ADD  X22, X22, X2
    STLLR X25,[X22]
    LDLAR X19,[X22]
    ADD  X22, X22, X2, LSR #0
    STP  X19, X19, [X22, #0]
    CASB W27, W4, [X22]
    ADD  X22, X22, X2, ASR #0
    STP  X5, X4, [X22, #0]
    CASAB W27, W18, [X22]
    ADD  X22, X22, X2, LSR #0
    STP  X12, X20, [X22, #0]
    CASALB W8, W8, [X22]
    ADD  X22, X22, X2, LSR #0
    STP  X20, X24, [X22, #0]
    CASLB W16, W5, [X22]
    ADD  X22, X22, X2, LSR #0
    STP  X16, X6, [X22, #0]
    CASH W20, W21, [X22]
    ADD  X22, X22, X2, ASR #0
    STP  X23, X19, [X22, #0]
    CASAH W8, W4, [X22]
    ADD  X22, X22, X2
    STP  X18, X27, [X22, #0]
    CASALH W12, W12, [X22]
    ADD  X22, X22, X2
    STP  X8, X27, [X22, #0]
    CASLH W7, W6, [X22]
    ADD  X22, X22, X2
    STP  X16, X6, [X22, #0]
    CAS W26, W16, [X22]
    ADD  X22, X22, X2, LSR #0
    STP  X7, X18, [X22, #0]
    CAS X3, X18, [X22]
    ADD  X22, X22, X2
    STP  X20, X12, [X22, #0]
    CASA W5, W25, [X22]
    ADD  X22, X22, X2, LSR #0
    STP  X16, X27, [X22, #0]
    CASA X21, X24, [X22]
    ADD  X22, X22, X2, ASR #0
    STP  X25, X23, [X22, #0]
    CASAL W27, W6, [X22]
    ADD  X22, X22, X2, LSR #0
    STP  X24, X19, [X22, #0]
    CASAL X17, X16, [X22]
    ADD  X22, X22, X2, LSR #0
    STP  X27, X8, [X22, #0]
    CASL W24, W3, [X22]
    ADD  X22, X22, X2, ASR #0
    STP  X26, X16, [X22, #0]
    CASL X7, X5, [X22]
    ADD  X22, X22, X2, LSR #0
    STP  X6, X17, [X22, #0]
    CASP W6, W7, W16, W17, [X22]
    ADD  X22, X22, X2, LSR #0
    STP  X5, X12, [X22, #0]
    CASP X4, X5, X26, X27, [X22]
    ADD  X22, X22, X2, LSR #0
    STP  X7, X25, [X22, #0]
    CASPA W6, W7, W26, W27, [X22]
    ADD  X22, X22, X2, ASR #0
    STP  X16, X17, [X22, #0]
    CASPA X26, X27, X16, X17, [X22]
    ADD  X22, X22, X2
    STP  X4, X20, [X22, #0]
    CASPAL W6, W7, W26, W27, [X22]
    ADD  X22, X22, X2, ASR #0
    STP  X24, X3, [X22, #0]
    CASPAL X6, X7, X6, X7, [X22]
    ADD  X22, X22, X2
    STP  X6, X6, [X22, #0]
    CASPL W18, W19, W6, W7, [X22]
    ADD  X22, X22, X2
    STP  X24, X6, [X22, #0]
    CASPL X4, X5, X16, X17, [X22]
    ADD  X22, X22, X2, ASR #0
    STLUR X16,[X22,#0]
    LDAPRB W20, [X22]
    ADD  X22, X22, X2
    STLUR X17,[X22,#0]
    LDAPRH W16, [X22]
    ADD  X22, X22, X2, ASR #0
    STLUR X21,[X22,#0]
    LDAPR W26, [X22]
    ADD  X22, X22, X2, ASR #0
    STLUR X6,[X22,#0]
    LDAPR X24, [X22]
    ADD  X22, X22, X2, LSR #0
    STLUR W20,[X22,#0]
    LDAPUR W27,[X22,#0]
    ADD  X22, X22, X2
    STLUR X19,[X22,#0]
    LDAPUR X3,[X22,#0]
    ADD  X22, X22, X2, LSR #0
    STLURB W16,[X22,#0]
    LDAPURB W21,[X22,#0]
    ADD  X22, X22, X2, LSR #0
    STLURH W24,[X22,#0]
    LDAPURH W16,[X22,#0]
    ADD  X22, X22, X2, LSR #0
    STLUR X5,[X22,#0]
    LDAPURSB W20,[X22,#0]
    ADD  X22, X22, X2, ASR #0
    STLUR X18,[X22,#0]
    LDAPURSB X5,[X22,#0]
    ADD  X22, X22, X2
    STLUR X27,[X22,#0]
    LDAPURSH W27,[X22,#0]
    ADD  X22, X22, X2, ASR #0
    STLUR X16,[X22,#0]
    LDAPURSH X4,[X22,#0]
    ADD  X22, X22, X2, LSR #0
    STLUR X4,[X22,#0]
    LDAPURSW X26,[X22,#0]
    ADD  X22, X22, X2
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    SUB  X13, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    SUB  X13, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    SUB  X13, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X13, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X29, #0x5a, LSL #0
    SUB  X13, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X13, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X29, #0x5a, LSL #0
    SUB  X13, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTGeneralLoadStoreP01_TestFail
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
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X29, #0x10, LSL #0
    MOVZ  X19, #0x1180, LSL #0
    ADD  X20, X30, X19, LSR #0
    STLLRB W26,[X20]
    LDLARB W16,[X20]
    ADD  X20, X20, X29
    STLLRH W5,[X20]
    LDLARH W26,[X20]
    ADD  X20, X20, X29
    STLLR W28,[X20]
    LDLAR W18,[X20]
    ADD  X20, X20, X29, ASR #0
    STLLR X4,[X20]
    LDLAR X17,[X20]
    ADD  X20, X20, X29, ASR #0
    STP  X24, X2, [X20, #0]
    CASB W18, W16, [X20]
    ADD  X20, X20, X29, ASR #0
    STP  X17, X3, [X20, #0]
    CASAB W18, W26, [X20]
    ADD  X20, X20, X29
    STP  X25, X6, [X20, #0]
    CASALB W22, W23, [X20]
    ADD  X20, X20, X29, LSR #0
    STP  X6, X13, [X20, #0]
    CASLB W24, W13, [X20]
    ADD  X20, X20, X29
    STP  X2, X5, [X20, #0]
    CASH W17, W6, [X20]
    ADD  X20, X20, X29, LSR #0
    STP  X18, X28, [X20, #0]
    CASAH W21, W6, [X20]
    ADD  X20, X20, X29, LSR #0
    STP  X5, X22, [X20, #0]
    CASALH W23, W23, [X20]
    ADD  X20, X20, X29, LSR #0
    STP  X3, X18, [X20, #0]
    CASLH W7, W2, [X20]
    ADD  X20, X20, X29
    STP  X23, X28, [X20, #0]
    CAS W13, W22, [X20]
    ADD  X20, X20, X29, ASR #0
    STP  X7, X28, [X20, #0]
    CAS X26, X7, [X20]
    ADD  X20, X20, X29
    STP  X26, X27, [X20, #0]
    CASA W16, W3, [X20]
    ADD  X20, X20, X29
    STP  X4, X27, [X20, #0]
    CASA X24, X28, [X20]
    ADD  X20, X20, X29, LSR #0
    STP  X22, X23, [X20, #0]
    CASAL W3, W26, [X20]
    ADD  X20, X20, X29, ASR #0
    STP  X18, X18, [X20, #0]
    CASAL X21, X26, [X20]
    ADD  X20, X20, X29
    STP  X13, X28, [X20, #0]
    CASL W22, W16, [X20]
    ADD  X20, X20, X29
    STP  X18, X26, [X20, #0]
    CASL X7, X21, [X20]
    ADD  X20, X20, X29
    STP  X22, X5, [X20, #0]
    CASP W24, W25, W26, W27, [X20]
    ADD  X20, X20, X29, ASR #0
    STP  X18, X18, [X20, #0]
    CASP X6, X7, X4, X5, [X20]
    ADD  X20, X20, X29, LSR #0
    STP  X16, X16, [X20, #0]
    CASPA W24, W25, W26, W27, [X20]
    ADD  X20, X20, X29, ASR #0
    STP  X3, X23, [X20, #0]
    CASPA X16, X17, X22, X23, [X20]
    ADD  X20, X20, X29
    STP  X26, X23, [X20, #0]
    CASPAL W22, W23, W26, W27, [X20]
    ADD  X20, X20, X29, ASR #0
    STP  X17, X25, [X20, #0]
    CASPAL X6, X7, X6, X7, [X20]
    ADD  X20, X20, X29, ASR #0
    STP  X22, X24, [X20, #0]
    CASPL W22, W23, W2, W3, [X20]
    ADD  X20, X20, X29
    STP  X7, X26, [X20, #0]
    CASPL X24, X25, X4, X5, [X20]
    ADD  X20, X20, X29, ASR #0
    STLUR X22,[X20,#0]
    LDAPRB W18, [X20]
    ADD  X20, X20, X29, LSR #0
    STLUR X16,[X20,#0]
    LDAPRH W3, [X20]
    ADD  X20, X20, X29
    STLUR X23,[X20,#0]
    LDAPR W4, [X20]
    ADD  X20, X20, X29, LSR #0
    STLUR X2,[X20,#0]
    LDAPR X5, [X20]
    ADD  X20, X20, X29, LSR #0
    STLUR W5,[X20,#0]
    LDAPUR W22,[X20,#0]
    ADD  X20, X20, X29, ASR #0
    STLUR X4,[X20,#0]
    LDAPUR X13,[X20,#0]
    ADD  X20, X20, X29
    STLURB W25,[X20,#0]
    LDAPURB W16,[X20,#0]
    ADD  X20, X20, X29, ASR #0
    STLURH W21,[X20,#0]
    LDAPURH W23,[X20,#0]
    ADD  X20, X20, X29, LSR #0
    STLUR X18,[X20,#0]
    LDAPURSB W21,[X20,#0]
    ADD  X20, X20, X29, ASR #0
    STLUR X2,[X20,#0]
    LDAPURSB X18,[X20,#0]
    ADD  X20, X20, X29
    STLUR X25,[X20,#0]
    LDAPURSH W4,[X20,#0]
    ADD  X20, X20, X29
    STLUR X21,[X20,#0]
    LDAPURSH X21,[X20,#0]
    ADD  X20, X20, X29, LSR #0
    STLUR X22,[X20,#0]
    LDAPURSW X25,[X20,#0]
    ADD  X20, X20, X29, LSR #0
    MOVZ  X8, #0xa5, LSL #0
    SUB  X12, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X12, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    SUB  X12, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X8, #0xa5, LSL #0
    SUB  X12, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    SUB  X12, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X8, #0xffa5, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X12, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X8, #0xa5, LSL #0
    SUB  X12, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    SUB  X12, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP01_TestFail
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
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X29, #0x10, LSL #0
    MOVZ  X20, #0x1400, LSL #0
    ADD  X8, X30, X20, LSR #0
    STLLRB W27,[X8]
    LDLARB W22,[X8]
    ADD  X8, X8, X29, LSR #0
    STLLRH W16,[X8]
    LDLARH W28,[X8]
    ADD  X8, X8, X29
    STLLR W4,[X8]
    LDLAR W23,[X8]
    ADD  X8, X8, X29, ASR #0
    STLLR X3,[X8]
    LDLAR X16,[X8]
    ADD  X8, X8, X29, LSR #0
    STP  X23, X25, [X8, #0]
    CASB W3, W4, [X8]
    ADD  X8, X8, X29, LSR #0
    STP  X28, X7, [X8, #0]
    CASAB W22, W16, [X8]
    ADD  X8, X8, X29, ASR #0
    STP  X28, X7, [X8, #0]
    CASALB W13, W3, [X8]
    ADD  X8, X8, X29
    STP  X21, X17, [X8, #0]
    CASLB W12, W18, [X8]
    ADD  X8, X8, X29, LSR #0
    STP  X12, X27, [X8, #0]
    CASH W23, W25, [X8]
    ADD  X8, X8, X29, ASR #0
    STP  X23, X24, [X8, #0]
    CASAH W27, W16, [X8]
    ADD  X8, X8, X29
    STP  X12, X7, [X8, #0]
    CASALH W12, W27, [X8]
    ADD  X8, X8, X29
    STP  X27, X13, [X8, #0]
    CASLH W17, W3, [X8]
    ADD  X8, X8, X29
    STP  X22, X17, [X8, #0]
    CAS W19, W22, [X8]
    ADD  X8, X8, X29, LSR #0
    STP  X16, X17, [X8, #0]
    CAS X19, X4, [X8]
    ADD  X8, X8, X29, ASR #0
    STP  X16, X13, [X8, #0]
    CASA W28, W19, [X8]
    ADD  X8, X8, X29, ASR #0
    STP  X18, X12, [X8, #0]
    CASA X25, X16, [X8]
    ADD  X8, X8, X29
    STP  X24, X7, [X8, #0]
    CASAL W27, W19, [X8]
    ADD  X8, X8, X29, LSR #0
    STP  X28, X18, [X8, #0]
    CASAL X23, X17, [X8]
    ADD  X8, X8, X29
    STP  X5, X4, [X8, #0]
    CASL W12, W12, [X8]
    ADD  X8, X8, X29, LSR #0
    STP  X5, X5, [X8, #0]
    CASL X25, X21, [X8]
    ADD  X8, X8, X29
    STP  X25, X5, [X8, #0]
    CASP W24, W25, W4, W5, [X8]
    ADD  X8, X8, X29, ASR #0
    STP  X13, X3, [X8, #0]
    CASP X2, X3, X16, X17, [X8]
    ADD  X8, X8, X29, LSR #0
    STP  X25, X19, [X8, #0]
    CASPA W18, W19, W12, W13, [X8]
    ADD  X8, X8, X29
    STP  X13, X17, [X8, #0]
    CASPA X22, X23, X12, X13, [X8]
    ADD  X8, X8, X29
    STP  X2, X2, [X8, #0]
    CASPAL W2, W3, W2, W3, [X8]
    ADD  X8, X8, X29
    STP  X19, X27, [X8, #0]
    CASPAL X18, X19, X4, X5, [X8]
    ADD  X8, X8, X29, LSR #0
    STP  X18, X2, [X8, #0]
    CASPL W16, W17, W18, W19, [X8]
    ADD  X8, X8, X29
    STP  X7, X25, [X8, #0]
    CASPL X16, X17, X16, X17, [X8]
    ADD  X8, X8, X29, LSR #0
    STLUR X16,[X8,#0]
    LDAPRB W18, [X8]
    ADD  X8, X8, X29
    STLUR X22,[X8,#0]
    LDAPRH W19, [X8]
    ADD  X8, X8, X29, ASR #0
    STLUR X23,[X8,#0]
    LDAPR W27, [X8]
    ADD  X8, X8, X29, ASR #0
    STLUR X18,[X8,#0]
    LDAPR X16, [X8]
    ADD  X8, X8, X29, LSR #0
    STLUR W27,[X8,#0]
    LDAPUR W13,[X8,#0]
    ADD  X8, X8, X29
    STLUR X13,[X8,#0]
    LDAPUR X5,[X8,#0]
    ADD  X8, X8, X29
    STLURB W21,[X8,#0]
    LDAPURB W18,[X8,#0]
    ADD  X8, X8, X29
    STLURH W18,[X8,#0]
    LDAPURH W23,[X8,#0]
    ADD  X8, X8, X29
    STLUR X16,[X8,#0]
    LDAPURSB W16,[X8,#0]
    ADD  X8, X8, X29
    STLUR X19,[X8,#0]
    LDAPURSB X27,[X8,#0]
    ADD  X8, X8, X29, LSR #0
    STLUR X21,[X8,#0]
    LDAPURSH W13,[X8,#0]
    ADD  X8, X8, X29
    STLUR X27,[X8,#0]
    LDAPURSH X21,[X8,#0]
    ADD  X8, X8, X29, LSR #0
    STLUR X12,[X8,#0]
    LDAPURSW X19,[X8,#0]
    ADD  X8, X8, X29, ASR #0
    MOVZ  X6, #0x5a, LSL #0
    SUB  X26, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X26, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0x5a, LSL #0
    SUB  X26, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X26, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X26, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    SUB  X26, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0x5a, LSL #0
    SUB  X26, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X26, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0x5a, LSL #0
    SUB  X26, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X26, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0x5a, LSL #0
    SUB  X26, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0x5a, LSL #0
    SUB  X26, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0x5a, LSL #0
    SUB  X26, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X26, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X26, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0x5a, LSL #0
    SUB  X26, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X26, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, LCRTGeneralLoadStoreP01_TestFail
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
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X24, #0x10, LSL #0
    MOVZ  X7, #0x1680, LSL #0
    ADD  X28, X30, X7
    STLLRB W26,[X28]
    LDLARB W13,[X28]
    ADD  X28, X28, X24, LSR #0
    STLLRH W29,[X28]
    LDLARH W3,[X28]
    ADD  X28, X28, X24, LSR #0
    STLLR W25,[X28]
    LDLAR W3,[X28]
    ADD  X28, X28, X24, LSR #0
    STLLR X22,[X28]
    LDLAR X25,[X28]
    ADD  X28, X28, X24
    STP  X3, X22, [X28, #0]
    CASB W25, W13, [X28]
    ADD  X28, X28, X24, LSR #0
    STP  X29, X23, [X28, #0]
    CASAB W18, W25, [X28]
    ADD  X28, X28, X24
    STP  X16, X16, [X28, #0]
    CASALB W23, W3, [X28]
    ADD  X28, X28, X24
    STP  X3, X21, [X28, #0]
    CASLB W21, W17, [X28]
    ADD  X28, X28, X24
    STP  X8, X19, [X28, #0]
    CASH W2, W2, [X28]
    ADD  X28, X28, X24, LSR #0
    STP  X23, X18, [X28, #0]
    CASAH W22, W12, [X28]
    ADD  X28, X28, X24, LSR #0
    STP  X18, X22, [X28, #0]
    CASALH W4, W4, [X28]
    ADD  X28, X28, X24, ASR #0
    STP  X16, X26, [X28, #0]
    CASLH W17, W18, [X28]
    ADD  X28, X28, X24
    STP  X8, X26, [X28, #0]
    CAS W25, W25, [X28]
    ADD  X28, X28, X24, ASR #0
    STP  X17, X19, [X28, #0]
    CAS X25, X23, [X28]
    ADD  X28, X28, X24, ASR #0
    STP  X20, X8, [X28, #0]
    CASA W2, W4, [X28]
    ADD  X28, X28, X24, LSR #0
    STP  X17, X27, [X28, #0]
    CASA X17, X3, [X28]
    ADD  X28, X28, X24, LSR #0
    STP  X25, X22, [X28, #0]
    CASAL W25, W23, [X28]
    ADD  X28, X28, X24, LSR #0
    STP  X16, X8, [X28, #0]
    CASAL X19, X2, [X28]
    ADD  X28, X28, X24, ASR #0
    STP  X29, X29, [X28, #0]
    CASL W22, W20, [X28]
    ADD  X28, X28, X24
    STP  X29, X8, [X28, #0]
    CASL X22, X21, [X28]
    ADD  X28, X28, X24
    STP  X22, X25, [X28, #0]
    CASP W2, W3, W16, W17, [X28]
    ADD  X28, X28, X24
    STP  X16, X18, [X28, #0]
    CASP X22, X23, X2, X3, [X28]
    ADD  X28, X28, X24
    STP  X17, X2, [X28, #0]
    CASPA W2, W3, W26, W27, [X28]
    ADD  X28, X28, X24, LSR #0
    STP  X12, X18, [X28, #0]
    CASPA X22, X23, X18, X19, [X28]
    ADD  X28, X28, X24, ASR #0
    STP  X20, X25, [X28, #0]
    CASPAL W2, W3, W26, W27, [X28]
    ADD  X28, X28, X24, ASR #0
    STP  X8, X8, [X28, #0]
    CASPAL X12, X13, X2, X3, [X28]
    ADD  X28, X28, X24, LSR #0
    STP  X23, X16, [X28, #0]
    CASPL W22, W23, W22, W23, [X28]
    ADD  X28, X28, X24
    STP  X2, X22, [X28, #0]
    CASPL X16, X17, X16, X17, [X28]
    ADD  X28, X28, X24, LSR #0
    STLUR X17,[X28,#0]
    LDAPRB W25, [X28]
    ADD  X28, X28, X24, LSR #0
    STLUR X23,[X28,#0]
    LDAPRH W25, [X28]
    ADD  X28, X28, X24
    STLUR X26,[X28,#0]
    LDAPR W20, [X28]
    ADD  X28, X28, X24
    STLUR X8,[X28,#0]
    LDAPR X3, [X28]
    ADD  X28, X28, X24, LSR #0
    STLUR W12,[X28,#0]
    LDAPUR W19,[X28,#0]
    ADD  X28, X28, X24, ASR #0
    STLUR X16,[X28,#0]
    LDAPUR X8,[X28,#0]
    ADD  X28, X28, X24, LSR #0
    STLURB W16,[X28,#0]
    LDAPURB W17,[X28,#0]
    ADD  X28, X28, X24, LSR #0
    STLURH W8,[X28,#0]
    LDAPURH W12,[X28,#0]
    ADD  X28, X28, X24, ASR #0
    STLUR X20,[X28,#0]
    LDAPURSB W16,[X28,#0]
    ADD  X28, X28, X24
    STLUR X20,[X28,#0]
    LDAPURSB X23,[X28,#0]
    ADD  X28, X28, X24
    STLUR X23,[X28,#0]
    LDAPURSH W20,[X28,#0]
    ADD  X28, X28, X24, LSR #0
    STLUR X12,[X28,#0]
    LDAPURSH X13,[X28,#0]
    ADD  X28, X28, X24
    STLUR X18,[X28,#0]
    LDAPURSW X18,[X28,#0]
    ADD  X28, X28, X24
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    SUB  X5, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    SUB  X5, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    SUB  X5, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    SUB  X5, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X5, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X5, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    SUB  X5, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    SUB  X5, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    SUB  X5, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X5, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    SUB  X5, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    SUB  X5, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X5, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X5, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
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
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X26, #0x10, LSL #0
    MOVZ  X27, #0x0, LSL #0
    ADD  X2, X30, X27, ASR #0
    STLLRB W25,[X2]
    LDLARB W17,[X2]
    ADD  X2, X2, X26, LSR #0
    STLLRH W21,[X2]
    LDLARH W5,[X2]
    ADD  X2, X2, X26, ASR #0
    STLLR W21,[X2]
    LDLAR W19,[X2]
    ADD  X2, X2, X26, ASR #0
    STLLR X29,[X2]
    LDLAR X8,[X2]
    ADD  X2, X2, X26
    STP  X12, X17, [X2, #0]
    CASB W28, W7, [X2]
    ADD  X2, X2, X26, LSR #0
    STP  X5, X29, [X2, #0]
    CASAB W29, W28, [X2]
    ADD  X2, X2, X26, LSR #0
    STP  X19, X19, [X2, #0]
    CASALB W20, W12, [X2]
    ADD  X2, X2, X26
    STP  X13, X8, [X2, #0]
    CASLB W7, W29, [X2]
    ADD  X2, X2, X26, LSR #0
    STP  X20, X25, [X2, #0]
    CASH W3, W6, [X2]
    ADD  X2, X2, X26, LSR #0
    STP  X29, X25, [X2, #0]
    CASAH W23, W16, [X2]
    ADD  X2, X2, X26, ASR #0
    STP  X6, X8, [X2, #0]
    CASALH W7, W21, [X2]
    ADD  X2, X2, X26
    STP  X7, X16, [X2, #0]
    CASLH W20, W23, [X2]
    ADD  X2, X2, X26
    STP  X17, X12, [X2, #0]
    CAS W28, W21, [X2]
    ADD  X2, X2, X26, ASR #0
    STP  X8, X3, [X2, #0]
    CAS X7, X21, [X2]
    ADD  X2, X2, X26
    STP  X3, X3, [X2, #0]
    CASA W6, W22, [X2]
    ADD  X2, X2, X26
    STP  X25, X13, [X2, #0]
    CASA X28, X6, [X2]
    ADD  X2, X2, X26
    STP  X19, X28, [X2, #0]
    CASAL W29, W23, [X2]
    ADD  X2, X2, X26
    STP  X28, X3, [X2, #0]
    CASAL X25, X19, [X2]
    ADD  X2, X2, X26, ASR #0
    STP  X13, X20, [X2, #0]
    CASL W6, W21, [X2]
    ADD  X2, X2, X26, ASR #0
    STP  X17, X6, [X2, #0]
    CASL X13, X24, [X2]
    ADD  X2, X2, X26, LSR #0
    STP  X6, X24, [X2, #0]
    CASP W22, W23, W28, W29, [X2]
    ADD  X2, X2, X26
    STP  X8, X23, [X2, #0]
    CASP X12, X13, X12, X13, [X2]
    ADD  X2, X2, X26, LSR #0
    STP  X6, X7, [X2, #0]
    CASPA W6, W7, W22, W23, [X2]
    ADD  X2, X2, X26, ASR #0
    STP  X28, X24, [X2, #0]
    CASPA X24, X25, X16, X17, [X2]
    ADD  X2, X2, X26
    STP  X21, X19, [X2, #0]
    CASPAL W6, W7, W6, W7, [X2]
    ADD  X2, X2, X26, ASR #0
    STP  X25, X8, [X2, #0]
    CASPAL X12, X13, X22, X23, [X2]
    ADD  X2, X2, X26, ASR #0
    STP  X7, X5, [X2, #0]
    CASPL W28, W29, W16, W17, [X2]
    ADD  X2, X2, X26
    STP  X7, X28, [X2, #0]
    CASPL X22, X23, X12, X13, [X2]
    ADD  X2, X2, X26, LSR #0
    STLUR X23,[X2,#0]
    LDAPRB W8, [X2]
    ADD  X2, X2, X26
    STLUR X22,[X2,#0]
    LDAPRH W28, [X2]
    ADD  X2, X2, X26
    STLUR X22,[X2,#0]
    LDAPR W20, [X2]
    ADD  X2, X2, X26
    STLUR X16,[X2,#0]
    LDAPR X12, [X2]
    ADD  X2, X2, X26
    STLUR W7,[X2,#0]
    LDAPUR W13,[X2,#0]
    ADD  X2, X2, X26, LSR #0
    STLUR X28,[X2,#0]
    LDAPUR X23,[X2,#0]
    ADD  X2, X2, X26, ASR #0
    STLURB W20,[X2,#0]
    LDAPURB W7,[X2,#0]
    ADD  X2, X2, X26, ASR #0
    STLURH W13,[X2,#0]
    LDAPURH W13,[X2,#0]
    ADD  X2, X2, X26
    STLUR X7,[X2,#0]
    LDAPURSB W28,[X2,#0]
    ADD  X2, X2, X26, LSR #0
    STLUR X17,[X2,#0]
    LDAPURSB X16,[X2,#0]
    ADD  X2, X2, X26, LSR #0
    STLUR X8,[X2,#0]
    LDAPURSH W6,[X2,#0]
    ADD  X2, X2, X26, ASR #0
    STLUR X12,[X2,#0]
    LDAPURSH X8,[X2,#0]
    ADD  X2, X2, X26, LSR #0
    STLUR X28,[X2,#0]
    LDAPURSW X20,[X2,#0]
    ADD  X2, X2, X26, ASR #0
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    SUB  X18, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X18, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0x5a, LSL #0
    SUB  X18, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0x5a, LSL #0
    SUB  X18, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X18, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X18, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP01_TestFail
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
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X5, #0x10, LSL #0
    MOVZ  X21, #0x280, LSL #0
    ADD  X26, X30, X21, ASR #0
    STLLRB W16,[X26]
    LDLARB W2,[X26]
    ADD  X26, X26, X5, LSR #0
    STLLRH W28,[X26]
    LDLARH W16,[X26]
    ADD  X26, X26, X5, LSR #0
    STLLR W2,[X26]
    LDLAR W18,[X26]
    ADD  X26, X26, X5
    STLLR X16,[X26]
    LDLAR X28,[X26]
    ADD  X26, X26, X5, LSR #0
    STP  X13, X2, [X26, #0]
    CASB W18, W23, [X26]
    ADD  X26, X26, X5, LSR #0
    STP  X24, X18, [X26, #0]
    CASAB W27, W28, [X26]
    ADD  X26, X26, X5, LSR #0
    STP  X6, X3, [X26, #0]
    CASALB W19, W6, [X26]
    ADD  X26, X26, X5, LSR #0
    STP  X3, X7, [X26, #0]
    CASLB W3, W24, [X26]
    ADD  X26, X26, X5, LSR #0
    STP  X16, X7, [X26, #0]
    CASH W2, W12, [X26]
    ADD  X26, X26, X5, ASR #0
    STP  X7, X13, [X26, #0]
    CASAH W7, W24, [X26]
    ADD  X26, X26, X5, ASR #0
    STP  X22, X7, [X26, #0]
    CASALH W16, W16, [X26]
    ADD  X26, X26, X5, ASR #0
    STP  X27, X6, [X26, #0]
    CASLH W8, W7, [X26]
    ADD  X26, X26, X5, LSR #0
    STP  X17, X4, [X26, #0]
    CAS W28, W20, [X26]
    ADD  X26, X26, X5
    STP  X4, X8, [X26, #0]
    CAS X28, X16, [X26]
    ADD  X26, X26, X5, ASR #0
    STP  X28, X3, [X26, #0]
    CASA W17, W23, [X26]
    ADD  X26, X26, X5, ASR #0
    STP  X28, X20, [X26, #0]
    CASA X3, X23, [X26]
    ADD  X26, X26, X5
    STP  X19, X28, [X26, #0]
    CASAL W7, W20, [X26]
    ADD  X26, X26, X5, ASR #0
    STP  X22, X8, [X26, #0]
    CASAL X4, X23, [X26]
    ADD  X26, X26, X5, LSR #0
    STP  X24, X7, [X26, #0]
    CASL W2, W22, [X26]
    ADD  X26, X26, X5
    STP  X4, X3, [X26, #0]
    CASL X16, X4, [X26]
    ADD  X26, X26, X5, LSR #0
    STP  X20, X2, [X26, #0]
    CASP W6, W7, W22, W23, [X26]
    ADD  X26, X26, X5, LSR #0
    STP  X20, X20, [X26, #0]
    CASP X16, X17, X6, X7, [X26]
    ADD  X26, X26, X5
    STP  X12, X28, [X26, #0]
    CASPA W22, W23, W18, W19, [X26]
    ADD  X26, X26, X5
    STP  X17, X13, [X26, #0]
    CASPA X6, X7, X22, X23, [X26]
    ADD  X26, X26, X5
    STP  X17, X20, [X26, #0]
    CASPAL W18, W19, W16, W17, [X26]
    ADD  X26, X26, X5
    STP  X19, X19, [X26, #0]
    CASPAL X22, X23, X12, X13, [X26]
    ADD  X26, X26, X5, LSR #0
    STP  X13, X12, [X26, #0]
    CASPL W22, W23, W22, W23, [X26]
    ADD  X26, X26, X5, LSR #0
    STP  X6, X19, [X26, #0]
    CASPL X2, X3, X12, X13, [X26]
    ADD  X26, X26, X5, LSR #0
    STLUR X7,[X26,#0]
    LDAPRB W16, [X26]
    ADD  X26, X26, X5, ASR #0
    STLUR X7,[X26,#0]
    LDAPRH W28, [X26]
    ADD  X26, X26, X5, ASR #0
    STLUR X2,[X26,#0]
    LDAPR W23, [X26]
    ADD  X26, X26, X5
    STLUR X8,[X26,#0]
    LDAPR X12, [X26]
    ADD  X26, X26, X5, LSR #0
    STLUR W19,[X26,#0]
    LDAPUR W2,[X26,#0]
    ADD  X26, X26, X5, ASR #0
    STLUR X4,[X26,#0]
    LDAPUR X8,[X26,#0]
    ADD  X26, X26, X5, ASR #0
    STLURB W20,[X26,#0]
    LDAPURB W7,[X26,#0]
    ADD  X26, X26, X5
    STLURH W2,[X26,#0]
    LDAPURH W17,[X26,#0]
    ADD  X26, X26, X5, ASR #0
    STLUR X8,[X26,#0]
    LDAPURSB W27,[X26,#0]
    ADD  X26, X26, X5, LSR #0
    STLUR X23,[X26,#0]
    LDAPURSB X28,[X26,#0]
    ADD  X26, X26, X5
    STLUR X27,[X26,#0]
    LDAPURSH W4,[X26,#0]
    ADD  X26, X26, X5
    STLUR X17,[X26,#0]
    LDAPURSH X20,[X26,#0]
    ADD  X26, X26, X5, LSR #0
    STLUR X4,[X26,#0]
    LDAPURSW X17,[X26,#0]
    ADD  X26, X26, X5, LSR #0
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    SUB  X29, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    SUB  X29, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X25, #0xffa5, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X29, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X25, #0xa5, LSL #0
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X25, #0xa5, LSL #0
    SUB  X29, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X25, #0xffa5, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X29, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    SUB  X29, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    SUB  X29, X25, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X29, X25, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X25, #0xffa5, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X29, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X25, #0xffa5, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X29, X25, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
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
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X22, #0x10, LSL #0
    MOVZ  X25, #0x500, LSL #0
    ADD  X5, X30, X25, LSR #0
    STLLRB W19,[X5]
    LDLARB W18,[X5]
    ADD  X5, X5, X22
    STLLRH W20,[X5]
    LDLARH W4,[X5]
    ADD  X5, X5, X22, ASR #0
    STLLR W23,[X5]
    LDLAR W4,[X5]
    ADD  X5, X5, X22
    STLLR X29,[X5]
    LDLAR X8,[X5]
    ADD  X5, X5, X22
    STP  X8, X12, [X5, #0]
    CASB W18, W13, [X5]
    ADD  X5, X5, X22
    STP  X20, X4, [X5, #0]
    CASAB W12, W18, [X5]
    ADD  X5, X5, X22
    STP  X23, X16, [X5, #0]
    CASALB W28, W12, [X5]
    ADD  X5, X5, X22, LSR #0
    STP  X19, X7, [X5, #0]
    CASLB W3, W18, [X5]
    ADD  X5, X5, X22, ASR #0
    STP  X2, X2, [X5, #0]
    CASH W7, W20, [X5]
    ADD  X5, X5, X22, ASR #0
    STP  X29, X17, [X5, #0]
    CASAH W6, W7, [X5]
    ADD  X5, X5, X22
    STP  X4, X26, [X5, #0]
    CASALH W17, W3, [X5]
    ADD  X5, X5, X22, LSR #0
    STP  X21, X6, [X5, #0]
    CASLH W4, W8, [X5]
    ADD  X5, X5, X22, LSR #0
    STP  X20, X13, [X5, #0]
    CAS W26, W2, [X5]
    ADD  X5, X5, X22, ASR #0
    STP  X29, X29, [X5, #0]
    CAS X23, X12, [X5]
    ADD  X5, X5, X22, ASR #0
    STP  X16, X6, [X5, #0]
    CASA W18, W26, [X5]
    ADD  X5, X5, X22
    STP  X7, X20, [X5, #0]
    CASA X16, X19, [X5]
    ADD  X5, X5, X22, ASR #0
    STP  X16, X16, [X5, #0]
    CASAL W23, W2, [X5]
    ADD  X5, X5, X22
    STP  X13, X16, [X5, #0]
    CASAL X23, X3, [X5]
    ADD  X5, X5, X22, LSR #0
    STP  X4, X23, [X5, #0]
    CASL W12, W3, [X5]
    ADD  X5, X5, X22, LSR #0
    STP  X13, X7, [X5, #0]
    CASL X17, X23, [X5]
    ADD  X5, X5, X22, LSR #0
    STP  X17, X29, [X5, #0]
    CASP W2, W3, W20, W21, [X5]
    ADD  X5, X5, X22
    STP  X2, X6, [X5, #0]
    CASP X16, X17, X12, X13, [X5]
    ADD  X5, X5, X22, ASR #0
    STP  X26, X6, [X5, #0]
    CASPA W12, W13, W28, W29, [X5]
    ADD  X5, X5, X22
    STP  X13, X6, [X5, #0]
    CASPA X2, X3, X2, X3, [X5]
    ADD  X5, X5, X22
    STP  X23, X28, [X5, #0]
    CASPAL W28, W29, W16, W17, [X5]
    ADD  X5, X5, X22, ASR #0
    STP  X26, X3, [X5, #0]
    CASPAL X12, X13, X16, X17, [X5]
    ADD  X5, X5, X22
    STP  X17, X2, [X5, #0]
    CASPL W2, W3, W28, W29, [X5]
    ADD  X5, X5, X22
    STP  X29, X6, [X5, #0]
    CASPL X2, X3, X2, X3, [X5]
    ADD  X5, X5, X22, ASR #0
    STLUR X3,[X5,#0]
    LDAPRB W23, [X5]
    ADD  X5, X5, X22, LSR #0
    STLUR X20,[X5,#0]
    LDAPRH W17, [X5]
    ADD  X5, X5, X22
    STLUR X18,[X5,#0]
    LDAPR W16, [X5]
    ADD  X5, X5, X22, LSR #0
    STLUR X18,[X5,#0]
    LDAPR X6, [X5]
    ADD  X5, X5, X22, ASR #0
    STLUR W28,[X5,#0]
    LDAPUR W26,[X5,#0]
    ADD  X5, X5, X22, LSR #0
    STLUR X16,[X5,#0]
    LDAPUR X2,[X5,#0]
    ADD  X5, X5, X22
    STLURB W12,[X5,#0]
    LDAPURB W23,[X5,#0]
    ADD  X5, X5, X22
    STLURH W6,[X5,#0]
    LDAPURH W12,[X5,#0]
    ADD  X5, X5, X22, ASR #0
    STLUR X21,[X5,#0]
    LDAPURSB W17,[X5,#0]
    ADD  X5, X5, X22, LSR #0
    STLUR X12,[X5,#0]
    LDAPURSB X12,[X5,#0]
    ADD  X5, X5, X22, ASR #0
    STLUR X2,[X5,#0]
    LDAPURSH W16,[X5,#0]
    ADD  X5, X5, X22
    STLUR X16,[X5,#0]
    LDAPURSH X26,[X5,#0]
    ADD  X5, X5, X22
    STLUR X26,[X5,#0]
    LDAPURSW X18,[X5,#0]
    ADD  X5, X5, X22, ASR #0
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    SUB  X24, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    SUB  X24, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    SUB  X24, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    SUB  X24, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    SUB  X24, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X24, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X27, #0x5a, LSL #0
    SUB  X24, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    SUB  X24, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    SUB  X24, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X27, #0x5a, LSL #0
    SUB  X24, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    SUB  X24, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X24, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X24, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    SUB  X24, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    SUB  X24, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    SUB  X24, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, LCRTGeneralLoadStoreP01_TestFail
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
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X27, #0x10, LSL #0
    MOVZ  X6, #0x780, LSL #0
    ADD  X12, X30, X6, LSR #0
    STLLRB W29,[X12]
    LDLARB W29,[X12]
    ADD  X12, X12, X27, ASR #0
    STLLRH W25,[X12]
    LDLARH W13,[X12]
    ADD  X12, X12, X27, ASR #0
    STLLR W29,[X12]
    LDLAR W16,[X12]
    ADD  X12, X12, X27, ASR #0
    STLLR X28,[X12]
    LDLAR X8,[X12]
    ADD  X12, X12, X27, LSR #0
    STP  X4, X8, [X12, #0]
    CASB W18, W2, [X12]
    ADD  X12, X12, X27, ASR #0
    STP  X19, X16, [X12, #0]
    CASAB W26, W13, [X12]
    ADD  X12, X12, X27, LSR #0
    STP  X2, X8, [X12, #0]
    CASALB W22, W21, [X12]
    ADD  X12, X12, X27, ASR #0
    STP  X3, X22, [X12, #0]
    CASLB W3, W4, [X12]
    ADD  X12, X12, X27, ASR #0
    STP  X16, X16, [X12, #0]
    CASH W23, W2, [X12]
    ADD  X12, X12, X27, LSR #0
    STP  X13, X4, [X12, #0]
    CASAH W17, W25, [X12]
    ADD  X12, X12, X27
    STP  X23, X25, [X12, #0]
    CASALH W29, W2, [X12]
    ADD  X12, X12, X27, ASR #0
    STP  X24, X26, [X12, #0]
    CASLH W8, W22, [X12]
    ADD  X12, X12, X27
    STP  X22, X3, [X12, #0]
    CAS W17, W18, [X12]
    ADD  X12, X12, X27, ASR #0
    STP  X16, X24, [X12, #0]
    CAS X25, X18, [X12]
    ADD  X12, X12, X27
    STP  X17, X24, [X12, #0]
    CASA W3, W23, [X12]
    ADD  X12, X12, X27
    STP  X16, X25, [X12, #0]
    CASA X4, X4, [X12]
    ADD  X12, X12, X27, LSR #0
    STP  X19, X28, [X12, #0]
    CASAL W4, W25, [X12]
    ADD  X12, X12, X27, ASR #0
    STP  X28, X4, [X12, #0]
    CASAL X17, X13, [X12]
    ADD  X12, X12, X27, ASR #0
    STP  X21, X21, [X12, #0]
    CASL W25, W2, [X12]
    ADD  X12, X12, X27
    STP  X3, X19, [X12, #0]
    CASL X17, X19, [X12]
    ADD  X12, X12, X27, LSR #0
    STP  X26, X16, [X12, #0]
    CASP W2, W3, W22, W23, [X12]
    ADD  X12, X12, X27
    STP  X3, X21, [X12, #0]
    CASP X2, X3, X2, X3, [X12]
    ADD  X12, X12, X27, LSR #0
    STP  X2, X16, [X12, #0]
    CASPA W2, W3, W24, W25, [X12]
    ADD  X12, X12, X27, LSR #0
    STP  X25, X4, [X12, #0]
    CASPA X2, X3, X16, X17, [X12]
    ADD  X12, X12, X27, ASR #0
    STP  X23, X13, [X12, #0]
    CASPAL W28, W29, W22, W23, [X12]
    ADD  X12, X12, X27, LSR #0
    STP  X17, X8, [X12, #0]
    CASPAL X28, X29, X18, X19, [X12]
    ADD  X12, X12, X27, LSR #0
    STP  X28, X22, [X12, #0]
    CASPL W2, W3, W22, W23, [X12]
    ADD  X12, X12, X27, ASR #0
    STP  X24, X18, [X12, #0]
    CASPL X24, X25, X22, X23, [X12]
    ADD  X12, X12, X27
    STLUR X7,[X12,#0]
    LDAPRB W13, [X12]
    ADD  X12, X12, X27
    STLUR X24,[X12,#0]
    LDAPRH W16, [X12]
    ADD  X12, X12, X27
    STLUR X19,[X12,#0]
    LDAPR W21, [X12]
    ADD  X12, X12, X27, LSR #0
    STLUR X19,[X12,#0]
    LDAPR X25, [X12]
    ADD  X12, X12, X27
    STLUR W18,[X12,#0]
    LDAPUR W18,[X12,#0]
    ADD  X12, X12, X27, ASR #0
    STLUR X25,[X12,#0]
    LDAPUR X4,[X12,#0]
    ADD  X12, X12, X27, LSR #0
    STLURB W18,[X12,#0]
    LDAPURB W25,[X12,#0]
    ADD  X12, X12, X27, LSR #0
    STLURH W13,[X12,#0]
    LDAPURH W8,[X12,#0]
    ADD  X12, X12, X27, ASR #0
    STLUR X16,[X12,#0]
    LDAPURSB W3,[X12,#0]
    ADD  X12, X12, X27, LSR #0
    STLUR X23,[X12,#0]
    LDAPURSB X3,[X12,#0]
    ADD  X12, X12, X27
    STLUR X3,[X12,#0]
    LDAPURSH W25,[X12,#0]
    ADD  X12, X12, X27
    STLUR X8,[X12,#0]
    LDAPURSH X3,[X12,#0]
    ADD  X12, X12, X27
    STLUR X16,[X12,#0]
    LDAPURSW X17,[X12,#0]
    ADD  X12, X12, X27, LSR #0
    MOVZ  X20, #0xa5, LSL #0
    SUB  X5, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X20, #0xa5, LSL #0
    SUB  X5, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X5, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X5, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X20, #0xa5, LSL #0
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X20, #0xa5, LSL #0
    SUB  X5, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    SUB  X5, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X20, #0xa5, LSL #0
    SUB  X5, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X5, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X20, #0xa5, LSL #0
    SUB  X5, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X20, #0xa5, LSL #0
    SUB  X5, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X5, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X20, #0xffa5, LSL #0
    MOVK  X20, #0xffff, LSL #16
    SUB  X5, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X5, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X20, #0xa5, LSL #0
    SUB  X5, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    SUB  X5, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
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
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X12, #0x10, LSL #0
    MOVZ  X2, #0xa00, LSL #0
    ADD  X22, X30, X2, ASR #0
    STLLRB W27,[X22]
    LDLARB W17,[X22]
    ADD  X22, X22, X12
    STLLRH W26,[X22]
    LDLARH W18,[X22]
    ADD  X22, X22, X12, LSR #0
    STLLR W3,[X22]
    LDLAR W13,[X22]
    ADD  X22, X22, X12, LSR #0
    STLLR X17,[X22]
    LDLAR X17,[X22]
    ADD  X22, X22, X12
    STP  X13, X17, [X22, #0]
    CASB W28, W29, [X22]
    ADD  X22, X22, X12, LSR #0
    STP  X5, X24, [X22, #0]
    CASAB W29, W17, [X22]
    ADD  X22, X22, X12, LSR #0
    STP  X25, X26, [X22, #0]
    CASALB W21, W13, [X22]
    ADD  X22, X22, X12, ASR #0
    STP  X18, X19, [X22, #0]
    CASLB W26, W21, [X22]
    ADD  X22, X22, X12, LSR #0
    STP  X3, X16, [X22, #0]
    CASH W28, W29, [X22]
    ADD  X22, X22, X12, ASR #0
    STP  X21, X3, [X22, #0]
    CASAH W17, W27, [X22]
    ADD  X22, X22, X12, ASR #0
    STP  X21, X18, [X22, #0]
    CASALH W16, W20, [X22]
    ADD  X22, X22, X12
    STP  X4, X16, [X22, #0]
    CASLH W7, W27, [X22]
    ADD  X22, X22, X12
    STP  X25, X24, [X22, #0]
    CAS W18, W26, [X22]
    ADD  X22, X22, X12, LSR #0
    STP  X17, X18, [X22, #0]
    CAS X25, X17, [X22]
    ADD  X22, X22, X12, ASR #0
    STP  X18, X26, [X22, #0]
    CASA W24, W7, [X22]
    ADD  X22, X22, X12, ASR #0
    STP  X4, X19, [X22, #0]
    CASA X13, X6, [X22]
    ADD  X22, X22, X12
    STP  X28, X26, [X22, #0]
    CASAL W6, W6, [X22]
    ADD  X22, X22, X12, LSR #0
    STP  X18, X25, [X22, #0]
    CASAL X19, X24, [X22]
    ADD  X22, X22, X12, ASR #0
    STP  X17, X3, [X22, #0]
    CASL W7, W20, [X22]
    ADD  X22, X22, X12, LSR #0
    STP  X6, X27, [X22, #0]
    CASL X20, X16, [X22]
    ADD  X22, X22, X12, ASR #0
    STP  X29, X7, [X22, #0]
    CASP W20, W21, W16, W17, [X22]
    ADD  X22, X22, X12, ASR #0
    STP  X17, X6, [X22, #0]
    CASP X28, X29, X6, X7, [X22]
    ADD  X22, X22, X12
    STP  X17, X26, [X22, #0]
    CASPA W6, W7, W20, W21, [X22]
    ADD  X22, X22, X12, ASR #0
    STP  X24, X28, [X22, #0]
    CASPA X20, X21, X18, X19, [X22]
    ADD  X22, X22, X12, LSR #0
    STP  X5, X6, [X22, #0]
    CASPAL W16, W17, W6, W7, [X22]
    ADD  X22, X22, X12, ASR #0
    STP  X28, X26, [X22, #0]
    CASPAL X26, X27, X4, X5, [X22]
    ADD  X22, X22, X12, LSR #0
    STP  X27, X20, [X22, #0]
    CASPL W6, W7, W16, W17, [X22]
    ADD  X22, X22, X12
    STP  X6, X28, [X22, #0]
    CASPL X6, X7, X6, X7, [X22]
    ADD  X22, X22, X12
    STLUR X29,[X22,#0]
    LDAPRB W28, [X22]
    ADD  X22, X22, X12, ASR #0
    STLUR X6,[X22,#0]
    LDAPRH W4, [X22]
    ADD  X22, X22, X12, LSR #0
    STLUR X28,[X22,#0]
    LDAPR W27, [X22]
    ADD  X22, X22, X12
    STLUR X7,[X22,#0]
    LDAPR X19, [X22]
    ADD  X22, X22, X12, ASR #0
    STLUR W4,[X22,#0]
    LDAPUR W5,[X22,#0]
    ADD  X22, X22, X12, LSR #0
    STLUR X19,[X22,#0]
    LDAPUR X28,[X22,#0]
    ADD  X22, X22, X12
    STLURB W27,[X22,#0]
    LDAPURB W20,[X22,#0]
    ADD  X22, X22, X12
    STLURH W5,[X22,#0]
    LDAPURH W27,[X22,#0]
    ADD  X22, X22, X12
    STLUR X24,[X22,#0]
    LDAPURSB W7,[X22,#0]
    ADD  X22, X22, X12
    STLUR X27,[X22,#0]
    LDAPURSB X24,[X22,#0]
    ADD  X22, X22, X12, ASR #0
    STLUR X20,[X22,#0]
    LDAPURSH W6,[X22,#0]
    ADD  X22, X22, X12, ASR #0
    STLUR X6,[X22,#0]
    LDAPURSH X6,[X22,#0]
    ADD  X22, X22, X12
    STLUR X19,[X22,#0]
    LDAPURSW X20,[X22,#0]
    ADD  X22, X22, X12, LSR #0
    MOVZ  X23, #0x5a, LSL #0
    SUB  X8, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0x5a, LSL #0
    SUB  X8, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X8, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0x5a, LSL #0
    SUB  X8, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    SUB  X8, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    SUB  X8, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    SUB  X8, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0x5a, LSL #0
    SUB  X8, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0x5a, LSL #0
    SUB  X8, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0x5a, LSL #0
    SUB  X8, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0x5a, LSL #0
    SUB  X8, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0x5a, LSL #0
    SUB  X8, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0x5a, LSL #0
    SUB  X8, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0x5a, LSL #0
    SUB  X8, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0x5a, LSL #0
    SUB  X8, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X8, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTGeneralLoadStoreP01_TestFail
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
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X27, #0x10, LSL #0
    MOVZ  X19, #0xc80, LSL #0
    ADD  X26, X30, X19, ASR #0
    STLLRB W22,[X26]
    LDLARB W20,[X26]
    ADD  X26, X26, X27, ASR #0
    STLLRH W12,[X26]
    LDLARH W24,[X26]
    ADD  X26, X26, X27, LSR #0
    STLLR W3,[X26]
    LDLAR W3,[X26]
    ADD  X26, X26, X27
    STLLR X28,[X26]
    LDLAR X5,[X26]
    ADD  X26, X26, X27, LSR #0
    STP  X17, X24, [X26, #0]
    CASB W3, W3, [X26]
    ADD  X26, X26, X27
    STP  X20, X7, [X26, #0]
    CASAB W5, W3, [X26]
    ADD  X26, X26, X27
    STP  X18, X3, [X26, #0]
    CASALB W8, W7, [X26]
    ADD  X26, X26, X27, ASR #0
    STP  X22, X12, [X26, #0]
    CASLB W16, W17, [X26]
    ADD  X26, X26, X27
    STP  X24, X5, [X26, #0]
    CASH W20, W18, [X26]
    ADD  X26, X26, X27, LSR #0
    STP  X25, X5, [X26, #0]
    CASAH W13, W7, [X26]
    ADD  X26, X26, X27
    STP  X13, X6, [X26, #0]
    CASALH W3, W7, [X26]
    ADD  X26, X26, X27
    STP  X16, X4, [X26, #0]
    CASLH W25, W21, [X26]
    ADD  X26, X26, X27, LSR #0
    STP  X22, X4, [X26, #0]
    CAS W3, W28, [X26]
    ADD  X26, X26, X27, ASR #0
    STP  X6, X28, [X26, #0]
    CAS X3, X13, [X26]
    ADD  X26, X26, X27
    STP  X6, X22, [X26, #0]
    CASA W4, W12, [X26]
    ADD  X26, X26, X27, ASR #0
    STP  X8, X25, [X26, #0]
    CASA X25, X21, [X26]
    ADD  X26, X26, X27
    STP  X8, X18, [X26, #0]
    CASAL W25, W13, [X26]
    ADD  X26, X26, X27, LSR #0
    STP  X12, X12, [X26, #0]
    CASAL X24, X20, [X26]
    ADD  X26, X26, X27, LSR #0
    STP  X13, X13, [X26, #0]
    CASL W3, W4, [X26]
    ADD  X26, X26, X27, LSR #0
    STP  X24, X20, [X26, #0]
    CASL X22, X24, [X26]
    ADD  X26, X26, X27, ASR #0
    STP  X18, X21, [X26, #0]
    CASP W12, W13, W20, W21, [X26]
    ADD  X26, X26, X27
    STP  X21, X2, [X26, #0]
    CASP X24, X25, X24, X25, [X26]
    ADD  X26, X26, X27, LSR #0
    STP  X21, X25, [X26, #0]
    CASPA W4, W5, W4, W5, [X26]
    ADD  X26, X26, X27, ASR #0
    STP  X2, X17, [X26, #0]
    CASPA X20, X21, X2, X3, [X26]
    ADD  X26, X26, X27, LSR #0
    STP  X25, X12, [X26, #0]
    CASPAL W6, W7, W24, W25, [X26]
    ADD  X26, X26, X27
    STP  X3, X13, [X26, #0]
    CASPAL X4, X5, X6, X7, [X26]
    ADD  X26, X26, X27
    STP  X13, X22, [X26, #0]
    CASPL W20, W21, W12, W13, [X26]
    ADD  X26, X26, X27
    STP  X20, X4, [X26, #0]
    CASPL X20, X21, X16, X17, [X26]
    ADD  X26, X26, X27, ASR #0
    STLUR X13,[X26,#0]
    LDAPRB W28, [X26]
    ADD  X26, X26, X27, LSR #0
    STLUR X5,[X26,#0]
    LDAPRH W13, [X26]
    ADD  X26, X26, X27, LSR #0
    STLUR X17,[X26,#0]
    LDAPR W24, [X26]
    ADD  X26, X26, X27, ASR #0
    STLUR X12,[X26,#0]
    LDAPR X22, [X26]
    ADD  X26, X26, X27
    STLUR W24,[X26,#0]
    LDAPUR W4,[X26,#0]
    ADD  X26, X26, X27
    STLUR X28,[X26,#0]
    LDAPUR X12,[X26,#0]
    ADD  X26, X26, X27, ASR #0
    STLURB W12,[X26,#0]
    LDAPURB W16,[X26,#0]
    ADD  X26, X26, X27, ASR #0
    STLURH W5,[X26,#0]
    LDAPURH W7,[X26,#0]
    ADD  X26, X26, X27, ASR #0
    STLUR X12,[X26,#0]
    LDAPURSB W25,[X26,#0]
    ADD  X26, X26, X27, LSR #0
    STLUR X20,[X26,#0]
    LDAPURSB X12,[X26,#0]
    ADD  X26, X26, X27, LSR #0
    STLUR X6,[X26,#0]
    LDAPURSH W6,[X26,#0]
    ADD  X26, X26, X27
    STLUR X13,[X26,#0]
    LDAPURSH X5,[X26,#0]
    ADD  X26, X26, X27, LSR #0
    STLUR X16,[X26,#0]
    LDAPURSW X13,[X26,#0]
    ADD  X26, X26, X27, ASR #0
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X29, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    SUB  X29, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X29, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X29, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    SUB  X29, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0xa5, LSL #0
    SUB  X29, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0xffa5, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X29, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0xa5, LSL #0
    SUB  X29, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0xa5, LSL #0
    SUB  X29, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X29, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    SUB  X29, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    SUB  X29, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    SUB  X29, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0xffa5, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X29, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X23, #0xa5, LSL #0
    SUB  X29, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, LCRTGeneralLoadStoreP01_TestFail
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
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X19, #0x10, LSL #0
    MOVZ  X26, #0xf00, LSL #0
    ADD  X25, X30, X26, LSR #0
    STLLRB W28,[X25]
    LDLARB W18,[X25]
    ADD  X25, X25, X19, LSR #0
    STLLRH W20,[X25]
    LDLARH W28,[X25]
    ADD  X25, X25, X19, LSR #0
    STLLR W22,[X25]
    LDLAR W13,[X25]
    ADD  X25, X25, X19, LSR #0
    STLLR X23,[X25]
    LDLAR X12,[X25]
    ADD  X25, X25, X19
    STP  X28, X18, [X25, #0]
    CASB W27, W13, [X25]
    ADD  X25, X25, X19, ASR #0
    STP  X29, X29, [X25, #0]
    CASAB W5, W12, [X25]
    ADD  X25, X25, X19, LSR #0
    STP  X16, X22, [X25, #0]
    CASALB W2, W17, [X25]
    ADD  X25, X25, X19
    STP  X29, X12, [X25, #0]
    CASLB W21, W27, [X25]
    ADD  X25, X25, X19
    STP  X4, X27, [X25, #0]
    CASH W16, W6, [X25]
    ADD  X25, X25, X19, ASR #0
    STP  X28, X2, [X25, #0]
    CASAH W6, W8, [X25]
    ADD  X25, X25, X19, LSR #0
    STP  X24, X4, [X25, #0]
    CASALH W17, W8, [X25]
    ADD  X25, X25, X19
    STP  X23, X8, [X25, #0]
    CASLH W27, W28, [X25]
    ADD  X25, X25, X19, LSR #0
    STP  X28, X13, [X25, #0]
    CAS W22, W28, [X25]
    ADD  X25, X25, X19
    STP  X13, X18, [X25, #0]
    CAS X24, X18, [X25]
    ADD  X25, X25, X19
    STP  X17, X23, [X25, #0]
    CASA W24, W27, [X25]
    ADD  X25, X25, X19, LSR #0
    STP  X24, X6, [X25, #0]
    CASA X22, X22, [X25]
    ADD  X25, X25, X19, ASR #0
    STP  X22, X22, [X25, #0]
    CASAL W16, W13, [X25]
    ADD  X25, X25, X19
    STP  X29, X16, [X25, #0]
    CASAL X5, X22, [X25]
    ADD  X25, X25, X19, LSR #0
    STP  X16, X2, [X25, #0]
    CASL W18, W29, [X25]
    ADD  X25, X25, X19, ASR #0
    STP  X16, X16, [X25, #0]
    CASL X27, X22, [X25]
    ADD  X25, X25, X19, ASR #0
    STP  X12, X5, [X25, #0]
    CASP W12, W13, W16, W17, [X25]
    ADD  X25, X25, X19
    STP  X5, X21, [X25, #0]
    CASP X4, X5, X22, X23, [X25]
    ADD  X25, X25, X19, ASR #0
    STP  X4, X22, [X25, #0]
    CASPA W16, W17, W28, W29, [X25]
    ADD  X25, X25, X19, LSR #0
    STP  X20, X20, [X25, #0]
    CASPA X4, X5, X28, X29, [X25]
    ADD  X25, X25, X19
    STP  X22, X8, [X25, #0]
    CASPAL W12, W13, W20, W21, [X25]
    ADD  X25, X25, X19, ASR #0
    STP  X13, X22, [X25, #0]
    CASPAL X16, X17, X16, X17, [X25]
    ADD  X25, X25, X19, LSR #0
    STP  X16, X18, [X25, #0]
    CASPL W4, W5, W4, W5, [X25]
    ADD  X25, X25, X19, LSR #0
    STP  X21, X5, [X25, #0]
    CASPL X4, X5, X22, X23, [X25]
    ADD  X25, X25, X19, LSR #0
    STLUR X23,[X25,#0]
    LDAPRB W28, [X25]
    ADD  X25, X25, X19, ASR #0
    STLUR X24,[X25,#0]
    LDAPRH W5, [X25]
    ADD  X25, X25, X19, LSR #0
    STLUR X12,[X25,#0]
    LDAPR W29, [X25]
    ADD  X25, X25, X19, LSR #0
    STLUR X13,[X25,#0]
    LDAPR X21, [X25]
    ADD  X25, X25, X19, ASR #0
    STLUR W17,[X25,#0]
    LDAPUR W22,[X25,#0]
    ADD  X25, X25, X19, LSR #0
    STLUR X28,[X25,#0]
    LDAPUR X13,[X25,#0]
    ADD  X25, X25, X19, LSR #0
    STLURB W28,[X25,#0]
    LDAPURB W20,[X25,#0]
    ADD  X25, X25, X19
    STLURH W13,[X25,#0]
    LDAPURH W17,[X25,#0]
    ADD  X25, X25, X19
    STLUR X5,[X25,#0]
    LDAPURSB W12,[X25,#0]
    ADD  X25, X25, X19
    STLUR X2,[X25,#0]
    LDAPURSB X2,[X25,#0]
    ADD  X25, X25, X19, ASR #0
    STLUR X20,[X25,#0]
    LDAPURSH W29,[X25,#0]
    ADD  X25, X25, X19
    STLUR X20,[X25,#0]
    LDAPURSH X20,[X25,#0]
    ADD  X25, X25, X19
    STLUR X20,[X25,#0]
    LDAPURSW X13,[X25,#0]
    ADD  X25, X25, X19
    MOVZ  X7, #0x5a, LSL #0
    SUB  X3, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x5a, LSL #0
    SUB  X3, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    SUB  X3, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    SUB  X3, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X3, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x5a, LSL #0
    SUB  X3, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    SUB  X3, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    SUB  X3, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    SUB  X3, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    SUB  X3, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTGeneralLoadStoreP01_TestFail
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
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X28, #0x10, LSL #0
    MOVZ  X23, #0x1180, LSL #0
    ADD  X27, X30, X23, ASR #0
    STLLRB W25,[X27]
    LDLARB W20,[X27]
    ADD  X27, X27, X28, ASR #0
    STLLRH W20,[X27]
    LDLARH W25,[X27]
    ADD  X27, X27, X28
    STLLR W29,[X27]
    LDLAR W12,[X27]
    ADD  X27, X27, X28
    STLLR X25,[X27]
    LDLAR X13,[X27]
    ADD  X27, X27, X28, ASR #0
    STP  X20, X21, [X27, #0]
    CASB W20, W7, [X27]
    ADD  X27, X27, X28, LSR #0
    STP  X12, X13, [X27, #0]
    CASAB W6, W4, [X27]
    ADD  X27, X27, X28, LSR #0
    STP  X25, X6, [X27, #0]
    CASALB W26, W29, [X27]
    ADD  X27, X27, X28, ASR #0
    STP  X29, X6, [X27, #0]
    CASLB W25, W13, [X27]
    ADD  X27, X27, X28
    STP  X13, X18, [X27, #0]
    CASH W6, W13, [X27]
    ADD  X27, X27, X28, ASR #0
    STP  X16, X2, [X27, #0]
    CASAH W13, W18, [X27]
    ADD  X27, X27, X28
    STP  X18, X13, [X27, #0]
    CASALH W16, W7, [X27]
    ADD  X27, X27, X28
    STP  X26, X8, [X27, #0]
    CASLH W16, W6, [X27]
    ADD  X27, X27, X28, LSR #0
    STP  X19, X19, [X27, #0]
    CAS W18, W25, [X27]
    ADD  X27, X27, X28, ASR #0
    STP  X16, X29, [X27, #0]
    CAS X19, X7, [X27]
    ADD  X27, X27, X28, ASR #0
    STP  X21, X12, [X27, #0]
    CASA W21, W7, [X27]
    ADD  X27, X27, X28, LSR #0
    STP  X4, X7, [X27, #0]
    CASA X3, X25, [X27]
    ADD  X27, X27, X28, LSR #0
    STP  X8, X26, [X27, #0]
    CASAL W12, W8, [X27]
    ADD  X27, X27, X28, ASR #0
    STP  X7, X8, [X27, #0]
    CASAL X20, X21, [X27]
    ADD  X27, X27, X28
    STP  X2, X6, [X27, #0]
    CASL W26, W13, [X27]
    ADD  X27, X27, X28
    STP  X20, X20, [X27, #0]
    CASL X7, X21, [X27]
    ADD  X27, X27, X28, ASR #0
    STP  X13, X6, [X27, #0]
    CASP W2, W3, W16, W17, [X27]
    ADD  X27, X27, X28, LSR #0
    STP  X19, X25, [X27, #0]
    CASP X6, X7, X20, X21, [X27]
    ADD  X27, X27, X28, LSR #0
    STP  X13, X8, [X27, #0]
    CASPA W12, W13, W16, W17, [X27]
    ADD  X27, X27, X28
    STP  X26, X17, [X27, #0]
    CASPA X6, X7, X16, X17, [X27]
    ADD  X27, X27, X28
    STP  X13, X12, [X27, #0]
    CASPAL W16, W17, W6, W7, [X27]
    ADD  X27, X27, X28
    STP  X2, X3, [X27, #0]
    CASPAL X24, X25, X6, X7, [X27]
    ADD  X27, X27, X28
    STP  X17, X25, [X27, #0]
    CASPL W24, W25, W24, W25, [X27]
    ADD  X27, X27, X28
    STP  X19, X2, [X27, #0]
    CASPL X16, X17, X18, X19, [X27]
    ADD  X27, X27, X28, LSR #0
    STLUR X18,[X27,#0]
    LDAPRB W21, [X27]
    ADD  X27, X27, X28, ASR #0
    STLUR X7,[X27,#0]
    LDAPRH W2, [X27]
    ADD  X27, X27, X28, ASR #0
    STLUR X21,[X27,#0]
    LDAPR W18, [X27]
    ADD  X27, X27, X28, LSR #0
    STLUR X8,[X27,#0]
    LDAPR X18, [X27]
    ADD  X27, X27, X28, ASR #0
    STLUR W17,[X27,#0]
    LDAPUR W8,[X27,#0]
    ADD  X27, X27, X28, LSR #0
    STLUR X18,[X27,#0]
    LDAPUR X19,[X27,#0]
    ADD  X27, X27, X28
    STLURB W25,[X27,#0]
    LDAPURB W21,[X27,#0]
    ADD  X27, X27, X28, ASR #0
    STLURH W3,[X27,#0]
    LDAPURH W3,[X27,#0]
    ADD  X27, X27, X28
    STLUR X8,[X27,#0]
    LDAPURSB W26,[X27,#0]
    ADD  X27, X27, X28, LSR #0
    STLUR X20,[X27,#0]
    LDAPURSB X8,[X27,#0]
    ADD  X27, X27, X28
    STLUR X19,[X27,#0]
    LDAPURSH W19,[X27,#0]
    ADD  X27, X27, X28, ASR #0
    STLUR X4,[X27,#0]
    LDAPURSH X26,[X27,#0]
    ADD  X27, X27, X28, ASR #0
    STLUR X4,[X27,#0]
    LDAPURSW X21,[X27,#0]
    ADD  X27, X27, X28
    MOVZ  X22, #0xa5a5, LSL #0
    SUB  X5, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    SUB  X5, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X5, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0xffa5, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X5, X22, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    SUB  X5, X22, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0xa5, LSL #0
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    SUB  X5, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X5, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xffff, LSL #16
    SUB  X5, X22, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X5, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X5, X22, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTGeneralLoadStoreP01_TestFail
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
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X22, #0x10, LSL #0
    MOVZ  X20, #0x1400, LSL #0
    ADD  X28, X30, X20, LSR #0
    STLLRB W24,[X28]
    LDLARB W12,[X28]
    ADD  X28, X28, X22
    STLLRH W24,[X28]
    LDLARH W8,[X28]
    ADD  X28, X28, X22
    STLLR W29,[X28]
    LDLAR W5,[X28]
    ADD  X28, X28, X22, LSR #0
    STLLR X4,[X28]
    LDLAR X7,[X28]
    ADD  X28, X28, X22, LSR #0
    STP  X16, X6, [X28, #0]
    CASB W17, W7, [X28]
    ADD  X28, X28, X22, ASR #0
    STP  X27, X8, [X28, #0]
    CASAB W23, W17, [X28]
    ADD  X28, X28, X22, ASR #0
    STP  X23, X5, [X28, #0]
    CASALB W8, W12, [X28]
    ADD  X28, X28, X22
    STP  X13, X7, [X28, #0]
    CASLB W27, W29, [X28]
    ADD  X28, X28, X22, LSR #0
    STP  X18, X18, [X28, #0]
    CASH W2, W5, [X28]
    ADD  X28, X28, X22, ASR #0
    STP  X16, X13, [X28, #0]
    CASAH W23, W8, [X28]
    ADD  X28, X28, X22, LSR #0
    STP  X23, X29, [X28, #0]
    CASALH W25, W12, [X28]
    ADD  X28, X28, X22, ASR #0
    STP  X27, X2, [X28, #0]
    CASLH W2, W17, [X28]
    ADD  X28, X28, X22, LSR #0
    STP  X16, X25, [X28, #0]
    CAS W21, W23, [X28]
    ADD  X28, X28, X22, LSR #0
    STP  X8, X13, [X28, #0]
    CAS X24, X23, [X28]
    ADD  X28, X28, X22
    STP  X25, X26, [X28, #0]
    CASA W17, W8, [X28]
    ADD  X28, X28, X22, ASR #0
    STP  X17, X24, [X28, #0]
    CASA X26, X27, [X28]
    ADD  X28, X28, X22
    STP  X7, X18, [X28, #0]
    CASAL W12, W7, [X28]
    ADD  X28, X28, X22
    STP  X13, X8, [X28, #0]
    CASAL X23, X12, [X28]
    ADD  X28, X28, X22, ASR #0
    STP  X23, X13, [X28, #0]
    CASL W12, W21, [X28]
    ADD  X28, X28, X22, ASR #0
    STP  X23, X21, [X28, #0]
    CASL X29, X12, [X28]
    ADD  X28, X28, X22
    STP  X26, X17, [X28, #0]
    CASP W12, W13, W16, W17, [X28]
    ADD  X28, X28, X22
    STP  X13, X8, [X28, #0]
    CASP X24, X25, X16, X17, [X28]
    ADD  X28, X28, X22, LSR #0
    STP  X24, X2, [X28, #0]
    CASPA W4, W5, W26, W27, [X28]
    ADD  X28, X28, X22, LSR #0
    STP  X5, X26, [X28, #0]
    CASPA X24, X25, X26, X27, [X28]
    ADD  X28, X28, X22
    STP  X21, X24, [X28, #0]
    CASPAL W24, W25, W24, W25, [X28]
    ADD  X28, X28, X22, LSR #0
    STP  X18, X27, [X28, #0]
    CASPAL X4, X5, X6, X7, [X28]
    ADD  X28, X28, X22
    STP  X25, X25, [X28, #0]
    CASPL W4, W5, W16, W17, [X28]
    ADD  X28, X28, X22
    STP  X2, X17, [X28, #0]
    CASPL X6, X7, X12, X13, [X28]
    ADD  X28, X28, X22, LSR #0
    STLUR X24,[X28,#0]
    LDAPRB W24, [X28]
    ADD  X28, X28, X22, LSR #0
    STLUR X12,[X28,#0]
    LDAPRH W2, [X28]
    ADD  X28, X28, X22, ASR #0
    STLUR X5,[X28,#0]
    LDAPR W5, [X28]
    ADD  X28, X28, X22, ASR #0
    STLUR X12,[X28,#0]
    LDAPR X17, [X28]
    ADD  X28, X28, X22, ASR #0
    STLUR W17,[X28,#0]
    LDAPUR W7,[X28,#0]
    ADD  X28, X28, X22, ASR #0
    STLUR X23,[X28,#0]
    LDAPUR X23,[X28,#0]
    ADD  X28, X28, X22, LSR #0
    STLURB W18,[X28,#0]
    LDAPURB W12,[X28,#0]
    ADD  X28, X28, X22, LSR #0
    STLURH W18,[X28,#0]
    LDAPURH W25,[X28,#0]
    ADD  X28, X28, X22
    STLUR X23,[X28,#0]
    LDAPURSB W8,[X28,#0]
    ADD  X28, X28, X22, ASR #0
    STLUR X18,[X28,#0]
    LDAPURSB X7,[X28,#0]
    ADD  X28, X28, X22
    STLUR X8,[X28,#0]
    LDAPURSH W18,[X28,#0]
    ADD  X28, X28, X22, LSR #0
    STLUR X27,[X28,#0]
    LDAPURSH X27,[X28,#0]
    ADD  X28, X28, X22, ASR #0
    STLUR X7,[X28,#0]
    LDAPURSW X8,[X28,#0]
    ADD  X28, X28, X22
    MOVZ  X3, #0x0, LSL #0
    SUB  X19, X3, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X19, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X19, X3, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X3, #0x5a, LSL #0
    SUB  X19, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X3, #0x5a, LSL #0
    SUB  X19, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X3, #0x5a, LSL #0
    SUB  X19, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X3, #0x5a, LSL #0
    SUB  X19, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X19, X3, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X19, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X3, #0x5a, LSL #0
    SUB  X19, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X19, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X19, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X19, X3, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    SUB  X19, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X19, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X3, #0x5a, LSL #0
    SUB  X19, X3, X27
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X19, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP01_TestFail
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
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X16, #0x10, LSL #0
    MOVZ  X2, #0x1680, LSL #0
    ADD  X23, X30, X2, LSR #0
    STLLRB W28,[X23]
    LDLARB W28,[X23]
    ADD  X23, X23, X16, LSR #0
    STLLRH W25,[X23]
    LDLARH W4,[X23]
    ADD  X23, X23, X16, ASR #0
    STLLR W4,[X23]
    LDLAR W20,[X23]
    ADD  X23, X23, X16, LSR #0
    STLLR X20,[X23]
    LDLAR X3,[X23]
    ADD  X23, X23, X16
    STP  X3, X3, [X23, #0]
    CASB W5, W24, [X23]
    ADD  X23, X23, X16, LSR #0
    STP  X27, X22, [X23, #0]
    CASAB W18, W29, [X23]
    ADD  X23, X23, X16, ASR #0
    STP  X5, X5, [X23, #0]
    CASALB W8, W18, [X23]
    ADD  X23, X23, X16, ASR #0
    STP  X12, X7, [X23, #0]
    CASLB W3, W25, [X23]
    ADD  X23, X23, X16, LSR #0
    STP  X13, X3, [X23, #0]
    CASH W17, W4, [X23]
    ADD  X23, X23, X16, ASR #0
    STP  X7, X4, [X23, #0]
    CASAH W18, W18, [X23]
    ADD  X23, X23, X16, ASR #0
    STP  X8, X29, [X23, #0]
    CASALH W13, W3, [X23]
    ADD  X23, X23, X16
    STP  X3, X4, [X23, #0]
    CASLH W22, W24, [X23]
    ADD  X23, X23, X16, ASR #0
    STP  X25, X17, [X23, #0]
    CAS W13, W5, [X23]
    ADD  X23, X23, X16
    STP  X12, X7, [X23, #0]
    CAS X13, X3, [X23]
    ADD  X23, X23, X16, ASR #0
    STP  X7, X13, [X23, #0]
    CASA W12, W24, [X23]
    ADD  X23, X23, X16
    STP  X4, X5, [X23, #0]
    CASA X19, X21, [X23]
    ADD  X23, X23, X16
    STP  X21, X19, [X23, #0]
    CASAL W28, W3, [X23]
    ADD  X23, X23, X16, LSR #0
    STP  X20, X3, [X23, #0]
    CASAL X4, X25, [X23]
    ADD  X23, X23, X16
    STP  X24, X19, [X23, #0]
    CASL W22, W3, [X23]
    ADD  X23, X23, X16
    STP  X5, X8, [X23, #0]
    CASL X27, X3, [X23]
    ADD  X23, X23, X16, ASR #0
    STP  X20, X29, [X23, #0]
    CASP W4, W5, W28, W29, [X23]
    ADD  X23, X23, X16
    STP  X21, X24, [X23, #0]
    CASP X20, X21, X4, X5, [X23]
    ADD  X23, X23, X16
    STP  X12, X19, [X23, #0]
    CASPA W12, W13, W18, W19, [X23]
    ADD  X23, X23, X16, ASR #0
    STP  X29, X4, [X23, #0]
    CASPA X4, X5, X24, X25, [X23]
    ADD  X23, X23, X16
    STP  X25, X4, [X23, #0]
    CASPAL W12, W13, W12, W13, [X23]
    ADD  X23, X23, X16, ASR #0
    STP  X22, X5, [X23, #0]
    CASPAL X28, X29, X20, X21, [X23]
    ADD  X23, X23, X16, LSR #0
    STP  X29, X28, [X23, #0]
    CASPL W28, W29, W12, W13, [X23]
    ADD  X23, X23, X16, LSR #0
    STP  X3, X12, [X23, #0]
    CASPL X4, X5, X18, X19, [X23]
    ADD  X23, X23, X16, LSR #0
    STLUR X18,[X23,#0]
    LDAPRB W19, [X23]
    ADD  X23, X23, X16
    STLUR X8,[X23,#0]
    LDAPRH W22, [X23]
    ADD  X23, X23, X16
    STLUR X19,[X23,#0]
    LDAPR W19, [X23]
    ADD  X23, X23, X16
    STLUR X27,[X23,#0]
    LDAPR X29, [X23]
    ADD  X23, X23, X16
    STLUR W28,[X23,#0]
    LDAPUR W28,[X23,#0]
    ADD  X23, X23, X16
    STLUR X21,[X23,#0]
    LDAPUR X29,[X23,#0]
    ADD  X23, X23, X16, ASR #0
    STLURB W20,[X23,#0]
    LDAPURB W27,[X23,#0]
    ADD  X23, X23, X16, ASR #0
    STLURH W13,[X23,#0]
    LDAPURH W13,[X23,#0]
    ADD  X23, X23, X16
    STLUR X28,[X23,#0]
    LDAPURSB W28,[X23,#0]
    ADD  X23, X23, X16, LSR #0
    STLUR X28,[X23,#0]
    LDAPURSB X27,[X23,#0]
    ADD  X23, X23, X16
    STLUR X13,[X23,#0]
    LDAPURSH W8,[X23,#0]
    ADD  X23, X23, X16, LSR #0
    STLUR X19,[X23,#0]
    LDAPURSH X20,[X23,#0]
    ADD  X23, X23, X16
    STLUR X20,[X23,#0]
    LDAPURSW X22,[X23,#0]
    ADD  X23, X23, X16, ASR #0
    MOVZ  X26, #0xa5, LSL #0
    SUB  X6, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X26, #0xa5, LSL #0
    SUB  X6, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    SUB  X6, X26, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X6, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X6, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    SUB  X6, X26, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    SUB  X6, X26, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    SUB  X6, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    SUB  X6, X26, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X26, #0xa5, LSL #0
    SUB  X6, X26, X19
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X26, #0xa5, LSL #0
    SUB  X6, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X6, X26, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X26, #0xa5, LSL #0
    SUB  X6, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X6, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X26, #0xffa5, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X6, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X26, #0xffa5, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X6, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTGeneralLoadStoreP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X6, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTGeneralLoadStoreP01_TestFail

LCRTGeneralLoadStoreP01_TestEnd:
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
LCRTGeneralLoadStoreP01_TestFail:
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
