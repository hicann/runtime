.global LCRTGeneralLoadStoreP04

.text
.p2align 4

LCRTGeneralLoadStoreP04:

LCRTGeneralLoadStoreP04_TestBegin:
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
    MOVZ  X2, #0xa515, LSL #0
    MOVK  X2, #0xbaf8, LSL #16
    MOVK  X2, #0xb372, LSL #32
    MOVK  X2, #0xc286, LSL #48
    MOVZ  X3, #0x4cce, LSL #0
    MOVK  X3, #0x6a46, LSL #16
    MOVK  X3, #0x51f7, LSL #32
    MOVK  X3, #0x9d98, LSL #48
    MOVZ  X4, #0x9c47, LSL #0
    MOVK  X4, #0xe16e, LSL #16
    MOVK  X4, #0xcf0e, LSL #32
    MOVK  X4, #0x1390, LSL #48
    MOVZ  X5, #0xe116, LSL #0
    MOVK  X5, #0x5961, LSL #16
    MOVK  X5, #0xd3f0, LSL #32
    MOVK  X5, #0x8a8f, LSL #48
    MOVZ  X6, #0xdd93, LSL #0
    MOVK  X6, #0xf40e, LSL #16
    MOVK  X6, #0xea89, LSL #32
    MOVK  X6, #0x635e, LSL #48
    MOVZ  X7, #0xb2c0, LSL #0
    MOVK  X7, #0xd88a, LSL #16
    MOVK  X7, #0xe294, LSL #32
    MOVK  X7, #0x7f0d, LSL #48
    MOVZ  X8, #0x26cd, LSL #0
    MOVK  X8, #0xc9ae, LSL #16
    MOVK  X8, #0x8379, LSL #32
    MOVK  X8, #0x8c7d, LSL #48
    MOVZ  X9, #0x2396, LSL #0
    MOVK  X9, #0xd508, LSL #16
    MOVK  X9, #0x9a3d, LSL #32
    MOVK  X9, #0x2798, LSL #48
    MOVZ  X10, #0x2b40, LSL #0
    MOVK  X10, #0xcbf, LSL #16
    MOVK  X10, #0x51c2, LSL #32
    MOVK  X10, #0xfad6, LSL #48
    MOVZ  X11, #0xcf3d, LSL #0
    MOVK  X11, #0x842c, LSL #16
    MOVK  X11, #0x2114, LSL #32
    MOVK  X11, #0xfd21, LSL #48
    MOVZ  X12, #0xbc92, LSL #0
    MOVK  X12, #0x13ba, LSL #16
    MOVK  X12, #0xd5d3, LSL #32
    MOVK  X12, #0xa271, LSL #48
    MOVZ  X13, #0x3662, LSL #0
    MOVK  X13, #0x2005, LSL #16
    MOVK  X13, #0xbb88, LSL #32
    MOVK  X13, #0x61be, LSL #48
    MOVZ  X14, #0xb318, LSL #0
    MOVK  X14, #0x8ec2, LSL #16
    MOVK  X14, #0x3a13, LSL #32
    MOVK  X14, #0xb922, LSL #48
    MOVZ  X15, #0xe48d, LSL #0
    MOVK  X15, #0xe66f, LSL #16
    MOVK  X15, #0x2793, LSL #32
    MOVK  X15, #0xbc89, LSL #48
    MOVZ  X16, #0xc11, LSL #0
    MOVK  X16, #0x6de4, LSL #16
    MOVK  X16, #0xb275, LSL #32
    MOVK  X16, #0xab33, LSL #48
    MOVZ  X17, #0xc21c, LSL #0
    MOVK  X17, #0xd452, LSL #16
    MOVK  X17, #0x1fc5, LSL #32
    MOVK  X17, #0x4b5c, LSL #48
    MOVZ  X18, #0x978d, LSL #0
    MOVK  X18, #0xf346, LSL #16
    MOVK  X18, #0x77fe, LSL #32
    MOVK  X18, #0x2689, LSL #48
    MOVZ  X19, #0x5dcb, LSL #0
    MOVK  X19, #0x8718, LSL #16
    MOVK  X19, #0xf60d, LSL #32
    MOVK  X19, #0xc380, LSL #48
    MOVZ  X20, #0x6921, LSL #0
    MOVK  X20, #0x4d6c, LSL #16
    MOVK  X20, #0x25a3, LSL #32
    MOVK  X20, #0xe510, LSL #48
    MOVZ  X21, #0xb352, LSL #0
    MOVK  X21, #0xa8d8, LSL #16
    MOVK  X21, #0x20ec, LSL #32
    MOVK  X21, #0x7a9c, LSL #48
    MOVZ  X22, #0x777f, LSL #0
    MOVK  X22, #0xb650, LSL #16
    MOVK  X22, #0x2f19, LSL #32
    MOVK  X22, #0xbd16, LSL #48
    MOVZ  X23, #0x7486, LSL #0
    MOVK  X23, #0x77fb, LSL #16
    MOVK  X23, #0x3817, LSL #32
    MOVK  X23, #0x4907, LSL #48
    MOVZ  X28, #0xd48e, LSL #0
    MOVK  X28, #0x9c22, LSL #16
    MOVK  X28, #0x970d, LSL #32
    MOVK  X28, #0xb06c, LSL #48
    SUBS  X13, X19, #0x76e, LSL #12
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X28, #0x10, LSL #0
    MOVZ  X9, #0x0, LSL #0
    ADD  X16, X30, X9
    STP  X21, X8, [X16, #0]
    STUMAXB W22,[X16]
    ADD  X16, X16, X28, LSR #0
    STP  X17, X4, [X16, #0]
    STUMAXLB W6,[X16]
    ADD  X16, X16, X28
    STP  X8, X18, [X16, #0]
    LDUMAXB W15,W20,[X16]
    ADD  X16, X16, X28
    STP  X20, X19, [X16, #0]
    LDUMAXAB W2,W20,[X16]
    ADD  X16, X16, X28, ASR #0
    STP  X22, X13, [X16, #0]
    LDUMAXALB W11,W4,[X16]
    ADD  X16, X16, X28, ASR #0
    STP  X6, X4, [X16, #0]
    LDUMAXLB W18,W6,[X16]
    ADD  X16, X16, X28
    STP  X20, X10, [X16, #0]
    STUMAXH W13,[X16]
    ADD  X16, X16, X28, LSR #0
    STP  X22, X14, [X16, #0]
    STUMAXLH W21,[X16]
    ADD  X16, X16, X28, LSR #0
    STP  X19, X14, [X16, #0]
    LDUMAXH W22,W13,[X16]
    ADD  X16, X16, X28
    STP  X8, X4, [X16, #0]
    LDUMAXAH W17,W17,[X16]
    ADD  X16, X16, X28
    STP  X10, X22, [X16, #0]
    LDUMAXALH W13,W5,[X16]
    ADD  X16, X16, X28, LSR #0
    STP  X5, X13, [X16, #0]
    LDUMAXLH W10,W6,[X16]
    ADD  X16, X16, X28
    STP  X14, X18, [X16, #0]
    STUMAX W17,[X16]
    ADD  X16, X16, X28, ASR #0
    STP  X21, X11, [X16, #0]
    STUMAX X11,[X16]
    ADD  X16, X16, X28
    STP  X8, X8, [X16, #0]
    STUMAXL W3,[X16]
    ADD  X16, X16, X28
    STP  X6, X22, [X16, #0]
    STUMAXL X5,[X16]
    ADD  X16, X16, X28, LSR #0
    STP  X18, X8, [X16, #0]
    LDUMAX W12,W14,[X16]
    ADD  X16, X16, X28
    STP  X20, X10, [X16, #0]
    LDUMAX X2,X11,[X16]
    ADD  X16, X16, X28, LSR #0
    STP  X12, X3, [X16, #0]
    LDUMAXA W18,W5,[X16]
    ADD  X16, X16, X28, LSR #0
    STP  X6, X18, [X16, #0]
    LDUMAXA X19,X12,[X16]
    ADD  X16, X16, X28, LSR #0
    STP  X5, X6, [X16, #0]
    LDUMAXAL W12,W3,[X16]
    ADD  X16, X16, X28
    STP  X12, X11, [X16, #0]
    LDUMAXAL X20,X10,[X16]
    ADD  X16, X16, X28
    STP  X11, X15, [X16, #0]
    LDUMAXL W15,W20,[X16]
    ADD  X16, X16, X28, ASR #0
    STP  X17, X20, [X16, #0]
    LDUMAXL X22,X22,[X16]
    ADD  X16, X16, X28
    STP  X10, X12, [X16, #0]
    STUMINB W22,[X16]
    ADD  X16, X16, X28, ASR #0
    STP  X15, X11, [X16, #0]
    STUMINLB W3,[X16]
    ADD  X16, X16, X28, ASR #0
    STP  X21, X22, [X16, #0]
    LDUMINB W2,W17,[X16]
    ADD  X16, X16, X28, LSR #0
    STP  X3, X2, [X16, #0]
    LDUMINAB W17,W18,[X16]
    ADD  X16, X16, X28
    STP  X4, X17, [X16, #0]
    LDUMINALB W15,W15,[X16]
    ADD  X16, X16, X28
    STP  X12, X15, [X16, #0]
    LDUMINLB W22,W17,[X16]
    ADD  X16, X16, X28, ASR #0
    STP  X11, X15, [X16, #0]
    STUMINH W17,[X16]
    ADD  X16, X16, X28, LSR #0
    STP  X2, X2, [X16, #0]
    STUMINLH W14,[X16]
    ADD  X16, X16, X28, ASR #0
    STP  X10, X8, [X16, #0]
    LDUMINH W2,W14,[X16]
    ADD  X16, X16, X28, LSR #0
    STP  X3, X11, [X16, #0]
    LDUMINAH W11,W10,[X16]
    ADD  X16, X16, X28, ASR #0
    STP  X14, X8, [X16, #0]
    LDUMINALH W3,W17,[X16]
    ADD  X16, X16, X28
    STP  X3, X6, [X16, #0]
    LDUMINLH W17,W11,[X16]
    ADD  X16, X16, X28
    STP  X6, X10, [X16, #0]
    STUMIN W17,[X16]
    ADD  X16, X16, X28
    STP  X21, X17, [X16, #0]
    STUMIN X21,[X16]
    ADD  X16, X16, X28
    STP  X13, X6, [X16, #0]
    STUMINL W3,[X16]
    ADD  X16, X16, X28, LSR #0
    STP  X17, X18, [X16, #0]
    STUMINL X4,[X16]
    ADD  X16, X16, X28, LSR #0
    STP  X8, X6, [X16, #0]
    LDUMIN W6,W4,[X16]
    ADD  X16, X16, X28, ASR #0
    STP  X11, X15, [X16, #0]
    LDUMIN X13,X18,[X16]
    ADD  X16, X16, X28, LSR #0
    STP  X20, X12, [X16, #0]
    LDUMINA W8,W11,[X16]
    ADD  X16, X16, X28, LSR #0
    STP  X3, X17, [X16, #0]
    LDUMINA X20,X12,[X16]
    ADD  X16, X16, X28, ASR #0
    STP  X20, X2, [X16, #0]
    LDUMINAL W15,W15,[X16]
    ADD  X16, X16, X28, LSR #0
    STP  X22, X8, [X16, #0]
    LDUMINAL X22,X2,[X16]
    ADD  X16, X16, X28, LSR #0
    STP  X18, X2, [X16, #0]
    LDUMINL W19,W3,[X16]
    ADD  X16, X16, X28, ASR #0
    STP  X19, X6, [X16, #0]
    LDUMINL X10,X19,[X16]
    ADD  X16, X16, X28, LSR #0
    STP  X18, X19, [X16, #0]
    SWPB W19,W6,[X16]
    ADD  X16, X16, X28
    STP  X15, X15, [X16, #0]
    SWPAB W10,W15,[X16]
    ADD  X16, X16, X28, ASR #0
    STP  X14, X11, [X16, #0]
    SWPALB W2,W10,[X16]
    ADD  X16, X16, X28, ASR #0
    STP  X19, X13, [X16, #0]
    SWPLB W20,W18,[X16]
    ADD  X16, X16, X28, ASR #0
    STP  X13, X17, [X16, #0]
    SWPH W10,W14,[X16]
    ADD  X16, X16, X28, ASR #0
    STP  X17, X4, [X16, #0]
    SWPAH W8,W13,[X16]
    ADD  X16, X16, X28
    STP  X8, X20, [X16, #0]
    SWPALH W21,W5,[X16]
    ADD  X16, X16, X28, ASR #0
    STP  X13, X2, [X16, #0]
    SWPLH W13,W17,[X16]
    ADD  X16, X16, X28, LSR #0
    STP  X6, X20, [X16, #0]
    SWP W6,W21,[X16]
    ADD  X16, X16, X28, LSR #0
    STP  X13, X12, [X16, #0]
    SWP X5,X12,[X16]
    ADD  X16, X16, X28, LSR #0
    STP  X11, X2, [X16, #0]
    SWPA W18,W2,[X16]
    ADD  X16, X16, X28
    STP  X6, X18, [X16, #0]
    SWPA X3,X5,[X16]
    ADD  X16, X16, X28, ASR #0
    STP  X19, X6, [X16, #0]
    SWPAL W22,W10,[X16]
    ADD  X16, X16, X28, LSR #0
    STP  X4, X14, [X16, #0]
    SWPAL X3,X6,[X16]
    ADD  X16, X16, X28, LSR #0
    STP  X15, X2, [X16, #0]
    SWPL W17,W10,[X16]
    ADD  X16, X16, X28, ASR #0
    STP  X13, X5, [X16, #0]
    SWPL X14,X22,[X16]
    ADD  X16, X16, X28, ASR #0
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    SUB  X7, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0x5a, LSL #0
    SUB  X7, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    SUB  X7, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    SUB  X7, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    SUB  X7, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0x5a, LSL #0
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X7, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0x5a, LSL #0
    SUB  X7, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    SUB  X7, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTGeneralLoadStoreP04_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X21, #0x10, LSL #0
    MOVZ  X8, #0x280, LSL #0
    ADD  X5, X30, X8, LSR #0
    STP  X28, X28, [X5, #0]
    STUMAXB W23,[X5]
    ADD  X5, X5, X21, ASR #0
    STP  X12, X22, [X5, #0]
    STUMAXLB W14,[X5]
    ADD  X5, X5, X21
    STP  X17, X22, [X5, #0]
    LDUMAXB W3,W19,[X5]
    ADD  X5, X5, X21, ASR #0
    STP  X14, X12, [X5, #0]
    LDUMAXAB W19,W17,[X5]
    ADD  X5, X5, X21, ASR #0
    STP  X28, X20, [X5, #0]
    LDUMAXALB W11,W18,[X5]
    ADD  X5, X5, X21, ASR #0
    STP  X22, X23, [X5, #0]
    LDUMAXLB W19,W12,[X5]
    ADD  X5, X5, X21, LSR #0
    STP  X28, X2, [X5, #0]
    STUMAXH W7,[X5]
    ADD  X5, X5, X21
    STP  X10, X16, [X5, #0]
    STUMAXLH W14,[X5]
    ADD  X5, X5, X21, ASR #0
    STP  X6, X19, [X5, #0]
    LDUMAXH W23,W7,[X5]
    ADD  X5, X5, X21, ASR #0
    STP  X19, X11, [X5, #0]
    LDUMAXAH W17,W23,[X5]
    ADD  X5, X5, X21, ASR #0
    STP  X10, X22, [X5, #0]
    LDUMAXALH W10,W19,[X5]
    ADD  X5, X5, X21, LSR #0
    STP  X14, X23, [X5, #0]
    LDUMAXLH W23,W2,[X5]
    ADD  X5, X5, X21, LSR #0
    STP  X22, X2, [X5, #0]
    STUMAX W20,[X5]
    ADD  X5, X5, X21, LSR #0
    STP  X18, X18, [X5, #0]
    STUMAX X18,[X5]
    ADD  X5, X5, X21, ASR #0
    STP  X23, X19, [X5, #0]
    STUMAXL W17,[X5]
    ADD  X5, X5, X21, ASR #0
    STP  X10, X9, [X5, #0]
    STUMAXL X10,[X5]
    ADD  X5, X5, X21, LSR #0
    STP  X20, X28, [X5, #0]
    LDUMAX W28,W2,[X5]
    ADD  X5, X5, X21
    STP  X14, X22, [X5, #0]
    LDUMAX X3,X20,[X5]
    ADD  X5, X5, X21
    STP  X16, X15, [X5, #0]
    LDUMAXA W11,W23,[X5]
    ADD  X5, X5, X21
    STP  X20, X16, [X5, #0]
    LDUMAXA X28,X28,[X5]
    ADD  X5, X5, X21, ASR #0
    STP  X15, X10, [X5, #0]
    LDUMAXAL W23,W17,[X5]
    ADD  X5, X5, X21, ASR #0
    STP  X2, X6, [X5, #0]
    LDUMAXAL X3,X6,[X5]
    ADD  X5, X5, X21
    STP  X17, X15, [X5, #0]
    LDUMAXL W9,W15,[X5]
    ADD  X5, X5, X21
    STP  X12, X3, [X5, #0]
    LDUMAXL X11,X10,[X5]
    ADD  X5, X5, X21
    STP  X19, X15, [X5, #0]
    STUMINB W16,[X5]
    ADD  X5, X5, X21
    STP  X17, X17, [X5, #0]
    STUMINLB W15,[X5]
    ADD  X5, X5, X21
    STP  X22, X7, [X5, #0]
    LDUMINB W7,W23,[X5]
    ADD  X5, X5, X21, ASR #0
    STP  X14, X18, [X5, #0]
    LDUMINAB W14,W18,[X5]
    ADD  X5, X5, X21, ASR #0
    STP  X20, X3, [X5, #0]
    LDUMINALB W2,W2,[X5]
    ADD  X5, X5, X21, ASR #0
    STP  X11, X17, [X5, #0]
    LDUMINLB W15,W19,[X5]
    ADD  X5, X5, X21, ASR #0
    STP  X10, X10, [X5, #0]
    STUMINH W12,[X5]
    ADD  X5, X5, X21, LSR #0
    STP  X28, X2, [X5, #0]
    STUMINLH W20,[X5]
    ADD  X5, X5, X21, LSR #0
    STP  X23, X10, [X5, #0]
    LDUMINH W14,W22,[X5]
    ADD  X5, X5, X21, ASR #0
    STP  X16, X9, [X5, #0]
    LDUMINAH W16,W20,[X5]
    ADD  X5, X5, X21, ASR #0
    STP  X18, X28, [X5, #0]
    LDUMINALH W22,W17,[X5]
    ADD  X5, X5, X21, ASR #0
    STP  X2, X22, [X5, #0]
    LDUMINLH W28,W2,[X5]
    ADD  X5, X5, X21
    STP  X10, X22, [X5, #0]
    STUMIN W22,[X5]
    ADD  X5, X5, X21, ASR #0
    STP  X10, X28, [X5, #0]
    STUMIN X2,[X5]
    ADD  X5, X5, X21, ASR #0
    STP  X20, X10, [X5, #0]
    STUMINL W22,[X5]
    ADD  X5, X5, X21, ASR #0
    STP  X22, X28, [X5, #0]
    STUMINL X12,[X5]
    ADD  X5, X5, X21, LSR #0
    STP  X22, X20, [X5, #0]
    LDUMIN W3,W10,[X5]
    ADD  X5, X5, X21
    STP  X17, X22, [X5, #0]
    LDUMIN X11,X17,[X5]
    ADD  X5, X5, X21, LSR #0
    STP  X17, X17, [X5, #0]
    LDUMINA W3,W17,[X5]
    ADD  X5, X5, X21
    STP  X28, X7, [X5, #0]
    LDUMINA X28,X20,[X5]
    ADD  X5, X5, X21, ASR #0
    STP  X23, X23, [X5, #0]
    LDUMINAL W15,W22,[X5]
    ADD  X5, X5, X21, LSR #0
    STP  X15, X3, [X5, #0]
    LDUMINAL X10,X28,[X5]
    ADD  X5, X5, X21, ASR #0
    STP  X18, X3, [X5, #0]
    LDUMINL W2,W17,[X5]
    ADD  X5, X5, X21, ASR #0
    STP  X19, X18, [X5, #0]
    LDUMINL X14,X17,[X5]
    ADD  X5, X5, X21
    STP  X22, X19, [X5, #0]
    SWPB W22,W2,[X5]
    ADD  X5, X5, X21
    STP  X18, X14, [X5, #0]
    SWPAB W9,W20,[X5]
    ADD  X5, X5, X21, ASR #0
    STP  X6, X23, [X5, #0]
    SWPALB W9,W11,[X5]
    ADD  X5, X5, X21
    STP  X3, X14, [X5, #0]
    SWPLB W6,W19,[X5]
    ADD  X5, X5, X21, LSR #0
    STP  X12, X2, [X5, #0]
    SWPH W12,W10,[X5]
    ADD  X5, X5, X21, LSR #0
    STP  X22, X15, [X5, #0]
    SWPAH W11,W18,[X5]
    ADD  X5, X5, X21, LSR #0
    STP  X22, X9, [X5, #0]
    SWPALH W6,W17,[X5]
    ADD  X5, X5, X21
    STP  X14, X19, [X5, #0]
    SWPLH W6,W23,[X5]
    ADD  X5, X5, X21, ASR #0
    STP  X11, X18, [X5, #0]
    SWP W17,W12,[X5]
    ADD  X5, X5, X21, ASR #0
    STP  X2, X2, [X5, #0]
    SWP X7,X19,[X5]
    ADD  X5, X5, X21, ASR #0
    STP  X19, X2, [X5, #0]
    SWPA W15,W22,[X5]
    ADD  X5, X5, X21, LSR #0
    STP  X14, X28, [X5, #0]
    SWPA X9,X2,[X5]
    ADD  X5, X5, X21, ASR #0
    STP  X23, X10, [X5, #0]
    SWPAL W11,W11,[X5]
    ADD  X5, X5, X21
    STP  X14, X18, [X5, #0]
    SWPAL X2,X9,[X5]
    ADD  X5, X5, X21
    STP  X22, X23, [X5, #0]
    SWPL W19,W7,[X5]
    ADD  X5, X5, X21, ASR #0
    STP  X15, X2, [X5, #0]
    SWPL X10,X22,[X5]
    ADD  X5, X5, X21, ASR #0
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X4, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    SUB  X4, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0xa5, LSL #0
    SUB  X4, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0xa5, LSL #0
    SUB  X4, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0xa5, LSL #0
    SUB  X4, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    SUB  X4, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X4, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0xa5, LSL #0
    SUB  X4, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0xa5, LSL #0
    SUB  X4, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0xa5, LSL #0
    SUB  X4, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    SUB  X4, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    SUB  X4, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTGeneralLoadStoreP04_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X11, #0x10, LSL #0
    MOVZ  X20, #0x500, LSL #0
    ADD  X7, X30, X20
    STP  X8, X12, [X7, #0]
    STUMAXB W28,[X7]
    ADD  X7, X7, X11, ASR #0
    STP  X21, X21, [X7, #0]
    STUMAXLB W12,[X7]
    ADD  X7, X7, X11, LSR #0
    STP  X15, X14, [X7, #0]
    LDUMAXB W22,W14,[X7]
    ADD  X7, X7, X11, ASR #0
    STP  X12, X16, [X7, #0]
    LDUMAXAB W12,W23,[X7]
    ADD  X7, X7, X11, LSR #0
    STP  X15, X3, [X7, #0]
    LDUMAXALB W28,W2,[X7]
    ADD  X7, X7, X11, LSR #0
    STP  X17, X17, [X7, #0]
    LDUMAXLB W19,W16,[X7]
    ADD  X7, X7, X11, LSR #0
    STP  X2, X10, [X7, #0]
    STUMAXH W2,[X7]
    ADD  X7, X7, X11, LSR #0
    STP  X8, X6, [X7, #0]
    STUMAXLH W3,[X7]
    ADD  X7, X7, X11, ASR #0
    STP  X17, X21, [X7, #0]
    LDUMAXH W17,W28,[X7]
    ADD  X7, X7, X11, LSR #0
    STP  X22, X12, [X7, #0]
    LDUMAXAH W2,W10,[X7]
    ADD  X7, X7, X11, LSR #0
    STP  X4, X2, [X7, #0]
    LDUMAXALH W4,W12,[X7]
    ADD  X7, X7, X11, LSR #0
    STP  X10, X19, [X7, #0]
    LDUMAXLH W4,W22,[X7]
    ADD  X7, X7, X11
    STP  X10, X4, [X7, #0]
    STUMAX W12,[X7]
    ADD  X7, X7, X11, ASR #0
    STP  X16, X23, [X7, #0]
    STUMAX X18,[X7]
    ADD  X7, X7, X11, LSR #0
    STP  X3, X2, [X7, #0]
    STUMAXL W22,[X7]
    ADD  X7, X7, X11
    STP  X19, X15, [X7, #0]
    STUMAXL X16,[X7]
    ADD  X7, X7, X11, LSR #0
    STP  X12, X21, [X7, #0]
    LDUMAX W5,W18,[X7]
    ADD  X7, X7, X11
    STP  X15, X17, [X7, #0]
    LDUMAX X23,X2,[X7]
    ADD  X7, X7, X11, LSR #0
    STP  X28, X17, [X7, #0]
    LDUMAXA W10,W12,[X7]
    ADD  X7, X7, X11
    STP  X23, X6, [X7, #0]
    LDUMAXA X17,X28,[X7]
    ADD  X7, X7, X11, ASR #0
    STP  X2, X21, [X7, #0]
    LDUMAXAL W3,W16,[X7]
    ADD  X7, X7, X11
    STP  X16, X5, [X7, #0]
    LDUMAXAL X2,X5,[X7]
    ADD  X7, X7, X11, LSR #0
    STP  X28, X15, [X7, #0]
    LDUMAXL W14,W2,[X7]
    ADD  X7, X7, X11, ASR #0
    STP  X18, X6, [X7, #0]
    LDUMAXL X6,X17,[X7]
    ADD  X7, X7, X11, LSR #0
    STP  X14, X8, [X7, #0]
    STUMINB W6,[X7]
    ADD  X7, X7, X11
    STP  X16, X10, [X7, #0]
    STUMINLB W6,[X7]
    ADD  X7, X7, X11
    STP  X10, X6, [X7, #0]
    LDUMINB W17,W15,[X7]
    ADD  X7, X7, X11, LSR #0
    STP  X10, X14, [X7, #0]
    LDUMINAB W19,W18,[X7]
    ADD  X7, X7, X11, LSR #0
    STP  X5, X21, [X7, #0]
    LDUMINALB W15,W12,[X7]
    ADD  X7, X7, X11, ASR #0
    STP  X19, X23, [X7, #0]
    LDUMINLB W19,W23,[X7]
    ADD  X7, X7, X11
    STP  X16, X22, [X7, #0]
    STUMINH W10,[X7]
    ADD  X7, X7, X11, LSR #0
    STP  X4, X5, [X7, #0]
    STUMINLH W17,[X7]
    ADD  X7, X7, X11, LSR #0
    STP  X21, X22, [X7, #0]
    LDUMINH W28,W28,[X7]
    ADD  X7, X7, X11, ASR #0
    STP  X15, X6, [X7, #0]
    LDUMINAH W19,W21,[X7]
    ADD  X7, X7, X11
    STP  X12, X14, [X7, #0]
    LDUMINALH W6,W22,[X7]
    ADD  X7, X7, X11, LSR #0
    STP  X17, X14, [X7, #0]
    LDUMINLH W2,W15,[X7]
    ADD  X7, X7, X11, LSR #0
    STP  X22, X5, [X7, #0]
    STUMIN W17,[X7]
    ADD  X7, X7, X11
    STP  X2, X15, [X7, #0]
    STUMIN X12,[X7]
    ADD  X7, X7, X11, ASR #0
    STP  X16, X10, [X7, #0]
    STUMINL W15,[X7]
    ADD  X7, X7, X11
    STP  X22, X22, [X7, #0]
    STUMINL X23,[X7]
    ADD  X7, X7, X11, LSR #0
    STP  X17, X22, [X7, #0]
    LDUMIN W3,W3,[X7]
    ADD  X7, X7, X11
    STP  X10, X17, [X7, #0]
    LDUMIN X14,X15,[X7]
    ADD  X7, X7, X11, ASR #0
    STP  X4, X8, [X7, #0]
    LDUMINA W17,W5,[X7]
    ADD  X7, X7, X11, LSR #0
    STP  X17, X17, [X7, #0]
    LDUMINA X2,X22,[X7]
    ADD  X7, X7, X11
    STP  X8, X22, [X7, #0]
    LDUMINAL W3,W10,[X7]
    ADD  X7, X7, X11, LSR #0
    STP  X18, X5, [X7, #0]
    LDUMINAL X12,X23,[X7]
    ADD  X7, X7, X11
    STP  X12, X19, [X7, #0]
    LDUMINL W18,W2,[X7]
    ADD  X7, X7, X11
    STP  X17, X12, [X7, #0]
    LDUMINL X3,X17,[X7]
    ADD  X7, X7, X11, LSR #0
    STP  X23, X22, [X7, #0]
    SWPB W3,W23,[X7]
    ADD  X7, X7, X11, LSR #0
    STP  X15, X3, [X7, #0]
    SWPAB W4,W19,[X7]
    ADD  X7, X7, X11, ASR #0
    STP  X18, X15, [X7, #0]
    SWPALB W22,W12,[X7]
    ADD  X7, X7, X11
    STP  X3, X23, [X7, #0]
    SWPLB W15,W23,[X7]
    ADD  X7, X7, X11, LSR #0
    STP  X22, X16, [X7, #0]
    SWPH W6,W16,[X7]
    ADD  X7, X7, X11, ASR #0
    STP  X6, X21, [X7, #0]
    SWPAH W2,W22,[X7]
    ADD  X7, X7, X11
    STP  X8, X2, [X7, #0]
    SWPALH W14,W6,[X7]
    ADD  X7, X7, X11, ASR #0
    STP  X28, X22, [X7, #0]
    SWPLH W6,W18,[X7]
    ADD  X7, X7, X11, LSR #0
    STP  X19, X18, [X7, #0]
    SWP W3,W28,[X7]
    ADD  X7, X7, X11, ASR #0
    STP  X22, X12, [X7, #0]
    SWP X16,X21,[X7]
    ADD  X7, X7, X11, ASR #0
    STP  X18, X21, [X7, #0]
    SWPA W19,W14,[X7]
    ADD  X7, X7, X11, LSR #0
    STP  X28, X28, [X7, #0]
    SWPA X14,X3,[X7]
    ADD  X7, X7, X11, LSR #0
    STP  X14, X14, [X7, #0]
    SWPAL W14,W6,[X7]
    ADD  X7, X7, X11
    STP  X16, X10, [X7, #0]
    SWPAL X28,X22,[X7]
    ADD  X7, X7, X11, ASR #0
    STP  X8, X22, [X7, #0]
    SWPL W19,W10,[X7]
    ADD  X7, X7, X11
    STP  X22, X19, [X7, #0]
    SWPL X14,X14,[X7]
    ADD  X7, X7, X11, LSR #0
    MOVZ  X13, #0x5a, LSL #0
    SUB  X9, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0x5a, LSL #0
    SUB  X9, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X9, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    SUB  X9, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    SUB  X9, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0x5a, LSL #0
    SUB  X9, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    SUB  X9, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    SUB  X9, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    SUB  X9, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    SUB  X9, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    SUB  X9, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0x5a, LSL #0
    SUB  X9, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    SUB  X9, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0x5a, LSL #0
    SUB  X9, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X13, #0x5a, LSL #0
    SUB  X9, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTGeneralLoadStoreP04_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X22, #0x10, LSL #0
    MOVZ  X10, #0x780, LSL #0
    ADD  X7, X30, X10
    STP  X2, X15, [X7, #0]
    STUMAXB W23,[X7]
    ADD  X7, X7, X22, LSR #0
    STP  X28, X4, [X7, #0]
    STUMAXLB W23,[X7]
    ADD  X7, X7, X22, LSR #0
    STP  X12, X3, [X7, #0]
    LDUMAXB W2,W23,[X7]
    ADD  X7, X7, X22, ASR #0
    STP  X21, X23, [X7, #0]
    LDUMAXAB W16,W9,[X7]
    ADD  X7, X7, X22, LSR #0
    STP  X4, X16, [X7, #0]
    LDUMAXALB W13,W9,[X7]
    ADD  X7, X7, X22, LSR #0
    STP  X9, X23, [X7, #0]
    LDUMAXLB W11,W21,[X7]
    ADD  X7, X7, X22, ASR #0
    STP  X15, X5, [X7, #0]
    STUMAXH W13,[X7]
    ADD  X7, X7, X22, ASR #0
    STP  X19, X28, [X7, #0]
    STUMAXLH W19,[X7]
    ADD  X7, X7, X22, ASR #0
    STP  X28, X18, [X7, #0]
    LDUMAXH W16,W2,[X7]
    ADD  X7, X7, X22
    STP  X11, X5, [X7, #0]
    LDUMAXAH W9,W5,[X7]
    ADD  X7, X7, X22, ASR #0
    STP  X23, X13, [X7, #0]
    LDUMAXALH W11,W23,[X7]
    ADD  X7, X7, X22, LSR #0
    STP  X15, X6, [X7, #0]
    LDUMAXLH W11,W13,[X7]
    ADD  X7, X7, X22, LSR #0
    STP  X5, X16, [X7, #0]
    STUMAX W5,[X7]
    ADD  X7, X7, X22
    STP  X16, X2, [X7, #0]
    STUMAX X13,[X7]
    ADD  X7, X7, X22, ASR #0
    STP  X12, X13, [X7, #0]
    STUMAXL W16,[X7]
    ADD  X7, X7, X22
    STP  X11, X28, [X7, #0]
    STUMAXL X3,[X7]
    ADD  X7, X7, X22, ASR #0
    STP  X12, X28, [X7, #0]
    LDUMAX W23,W18,[X7]
    ADD  X7, X7, X22, LSR #0
    STP  X5, X21, [X7, #0]
    LDUMAX X23,X19,[X7]
    ADD  X7, X7, X22, ASR #0
    STP  X16, X13, [X7, #0]
    LDUMAXA W13,W11,[X7]
    ADD  X7, X7, X22
    STP  X15, X3, [X7, #0]
    LDUMAXA X2,X2,[X7]
    ADD  X7, X7, X22
    STP  X14, X28, [X7, #0]
    LDUMAXAL W15,W6,[X7]
    ADD  X7, X7, X22, ASR #0
    STP  X19, X5, [X7, #0]
    LDUMAXAL X11,X4,[X7]
    ADD  X7, X7, X22, ASR #0
    STP  X12, X6, [X7, #0]
    LDUMAXL W15,W14,[X7]
    ADD  X7, X7, X22, ASR #0
    STP  X9, X18, [X7, #0]
    LDUMAXL X3,X9,[X7]
    ADD  X7, X7, X22
    STP  X5, X21, [X7, #0]
    STUMINB W19,[X7]
    ADD  X7, X7, X22, LSR #0
    STP  X15, X16, [X7, #0]
    STUMINLB W6,[X7]
    ADD  X7, X7, X22
    STP  X2, X6, [X7, #0]
    LDUMINB W6,W2,[X7]
    ADD  X7, X7, X22, ASR #0
    STP  X19, X2, [X7, #0]
    LDUMINAB W18,W12,[X7]
    ADD  X7, X7, X22, LSR #0
    STP  X11, X6, [X7, #0]
    LDUMINALB W21,W2,[X7]
    ADD  X7, X7, X22, ASR #0
    STP  X13, X11, [X7, #0]
    LDUMINLB W14,W21,[X7]
    ADD  X7, X7, X22
    STP  X5, X12, [X7, #0]
    STUMINH W14,[X7]
    ADD  X7, X7, X22, ASR #0
    STP  X5, X4, [X7, #0]
    STUMINLH W16,[X7]
    ADD  X7, X7, X22, ASR #0
    STP  X28, X5, [X7, #0]
    LDUMINH W6,W16,[X7]
    ADD  X7, X7, X22, ASR #0
    STP  X3, X21, [X7, #0]
    LDUMINAH W4,W19,[X7]
    ADD  X7, X7, X22, ASR #0
    STP  X18, X14, [X7, #0]
    LDUMINALH W18,W2,[X7]
    ADD  X7, X7, X22, ASR #0
    STP  X19, X17, [X7, #0]
    LDUMINLH W6,W18,[X7]
    ADD  X7, X7, X22, LSR #0
    STP  X3, X14, [X7, #0]
    STUMIN W15,[X7]
    ADD  X7, X7, X22
    STP  X18, X12, [X7, #0]
    STUMIN X9,[X7]
    ADD  X7, X7, X22, ASR #0
    STP  X17, X3, [X7, #0]
    STUMINL W18,[X7]
    ADD  X7, X7, X22, LSR #0
    STP  X23, X18, [X7, #0]
    STUMINL X28,[X7]
    ADD  X7, X7, X22, LSR #0
    STP  X23, X13, [X7, #0]
    LDUMIN W11,W6,[X7]
    ADD  X7, X7, X22, ASR #0
    STP  X5, X14, [X7, #0]
    LDUMIN X2,X23,[X7]
    ADD  X7, X7, X22, LSR #0
    STP  X6, X2, [X7, #0]
    LDUMINA W18,W28,[X7]
    ADD  X7, X7, X22, ASR #0
    STP  X19, X2, [X7, #0]
    LDUMINA X13,X17,[X7]
    ADD  X7, X7, X22, ASR #0
    STP  X28, X17, [X7, #0]
    LDUMINAL W28,W6,[X7]
    ADD  X7, X7, X22
    STP  X3, X23, [X7, #0]
    LDUMINAL X13,X11,[X7]
    ADD  X7, X7, X22
    STP  X6, X23, [X7, #0]
    LDUMINL W28,W21,[X7]
    ADD  X7, X7, X22
    STP  X15, X19, [X7, #0]
    LDUMINL X14,X3,[X7]
    ADD  X7, X7, X22, LSR #0
    STP  X11, X19, [X7, #0]
    SWPB W2,W6,[X7]
    ADD  X7, X7, X22
    STP  X12, X2, [X7, #0]
    SWPAB W17,W17,[X7]
    ADD  X7, X7, X22, ASR #0
    STP  X12, X17, [X7, #0]
    SWPALB W18,W9,[X7]
    ADD  X7, X7, X22, ASR #0
    STP  X9, X11, [X7, #0]
    SWPLB W23,W2,[X7]
    ADD  X7, X7, X22, LSR #0
    STP  X18, X5, [X7, #0]
    SWPH W17,W5,[X7]
    ADD  X7, X7, X22
    STP  X15, X28, [X7, #0]
    SWPAH W16,W14,[X7]
    ADD  X7, X7, X22, ASR #0
    STP  X19, X3, [X7, #0]
    SWPALH W21,W17,[X7]
    ADD  X7, X7, X22, LSR #0
    STP  X28, X4, [X7, #0]
    SWPLH W9,W19,[X7]
    ADD  X7, X7, X22
    STP  X21, X14, [X7, #0]
    SWP W3,W21,[X7]
    ADD  X7, X7, X22
    STP  X28, X9, [X7, #0]
    SWP X28,X4,[X7]
    ADD  X7, X7, X22, ASR #0
    STP  X12, X3, [X7, #0]
    SWPA W11,W28,[X7]
    ADD  X7, X7, X22
    STP  X17, X17, [X7, #0]
    SWPA X19,X3,[X7]
    ADD  X7, X7, X22
    STP  X4, X5, [X7, #0]
    SWPAL W28,W14,[X7]
    ADD  X7, X7, X22
    STP  X3, X21, [X7, #0]
    SWPAL X18,X3,[X7]
    ADD  X7, X7, X22
    STP  X3, X4, [X7, #0]
    SWPL W28,W18,[X7]
    ADD  X7, X7, X22, LSR #0
    STP  X17, X14, [X7, #0]
    SWPL X2,X4,[X7]
    ADD  X7, X7, X22, ASR #0
    MOVZ  X8, #0xa5, LSL #0
    SUB  X20, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    SUB  X20, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    SUB  X20, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    SUB  X20, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X8, #0xa5, LSL #0
    SUB  X20, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X8, #0xa5, LSL #0
    SUB  X20, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X20, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X8, #0xa5, LSL #0
    SUB  X20, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X8, #0xa5, LSL #0
    SUB  X20, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    SUB  X20, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    SUB  X20, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    SUB  X20, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X8, #0xa5, LSL #0
    SUB  X20, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X8, #0xa5, LSL #0
    SUB  X20, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    SUB  X20, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X8, #0xa5, LSL #0
    SUB  X20, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTGeneralLoadStoreP04_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X16, #0x10, LSL #0
    MOVZ  X20, #0xa00, LSL #0
    ADD  X15, X30, X20, ASR #0
    STP  X7, X21, [X15, #0]
    STUMAXB W23,[X15]
    ADD  X15, X15, X16
    STP  X12, X28, [X15, #0]
    STUMAXLB W22,[X15]
    ADD  X15, X15, X16, ASR #0
    STP  X10, X22, [X15, #0]
    LDUMAXB W4,W6,[X15]
    ADD  X15, X15, X16, LSR #0
    STP  X5, X10, [X15, #0]
    LDUMAXAB W2,W3,[X15]
    ADD  X15, X15, X16
    STP  X3, X13, [X15, #0]
    LDUMAXALB W3,W3,[X15]
    ADD  X15, X15, X16, LSR #0
    STP  X19, X18, [X15, #0]
    LDUMAXLB W23,W13,[X15]
    ADD  X15, X15, X16, LSR #0
    STP  X5, X12, [X15, #0]
    STUMAXH W22,[X15]
    ADD  X15, X15, X16
    STP  X28, X14, [X15, #0]
    STUMAXLH W12,[X15]
    ADD  X15, X15, X16
    STP  X17, X3, [X15, #0]
    LDUMAXH W8,W10,[X15]
    ADD  X15, X15, X16, LSR #0
    STP  X6, X21, [X15, #0]
    LDUMAXAH W23,W22,[X15]
    ADD  X15, X15, X16, ASR #0
    STP  X19, X12, [X15, #0]
    LDUMAXALH W7,W2,[X15]
    ADD  X15, X15, X16
    STP  X18, X6, [X15, #0]
    LDUMAXLH W28,W19,[X15]
    ADD  X15, X15, X16, LSR #0
    STP  X10, X7, [X15, #0]
    STUMAX W6,[X15]
    ADD  X15, X15, X16, ASR #0
    STP  X6, X17, [X15, #0]
    STUMAX X14,[X15]
    ADD  X15, X15, X16, ASR #0
    STP  X28, X17, [X15, #0]
    STUMAXL W3,[X15]
    ADD  X15, X15, X16, ASR #0
    STP  X28, X13, [X15, #0]
    STUMAXL X12,[X15]
    ADD  X15, X15, X16, ASR #0
    STP  X10, X3, [X15, #0]
    LDUMAX W18,W3,[X15]
    ADD  X15, X15, X16, ASR #0
    STP  X12, X5, [X15, #0]
    LDUMAX X5,X8,[X15]
    ADD  X15, X15, X16, ASR #0
    STP  X5, X13, [X15, #0]
    LDUMAXA W2,W18,[X15]
    ADD  X15, X15, X16, LSR #0
    STP  X28, X23, [X15, #0]
    LDUMAXA X7,X6,[X15]
    ADD  X15, X15, X16, LSR #0
    STP  X10, X4, [X15, #0]
    LDUMAXAL W5,W4,[X15]
    ADD  X15, X15, X16
    STP  X13, X13, [X15, #0]
    LDUMAXAL X5,X22,[X15]
    ADD  X15, X15, X16
    STP  X22, X14, [X15, #0]
    LDUMAXL W5,W18,[X15]
    ADD  X15, X15, X16, LSR #0
    STP  X5, X13, [X15, #0]
    LDUMAXL X8,X14,[X15]
    ADD  X15, X15, X16, LSR #0
    STP  X21, X22, [X15, #0]
    STUMINB W7,[X15]
    ADD  X15, X15, X16, LSR #0
    STP  X6, X13, [X15, #0]
    STUMINLB W14,[X15]
    ADD  X15, X15, X16, ASR #0
    STP  X21, X7, [X15, #0]
    LDUMINB W6,W13,[X15]
    ADD  X15, X15, X16, LSR #0
    STP  X28, X8, [X15, #0]
    LDUMINAB W2,W21,[X15]
    ADD  X15, X15, X16, ASR #0
    STP  X6, X7, [X15, #0]
    LDUMINALB W12,W14,[X15]
    ADD  X15, X15, X16, LSR #0
    STP  X18, X17, [X15, #0]
    LDUMINLB W10,W6,[X15]
    ADD  X15, X15, X16, ASR #0
    STP  X10, X14, [X15, #0]
    STUMINH W13,[X15]
    ADD  X15, X15, X16, LSR #0
    STP  X12, X2, [X15, #0]
    STUMINLH W18,[X15]
    ADD  X15, X15, X16
    STP  X28, X21, [X15, #0]
    LDUMINH W23,W12,[X15]
    ADD  X15, X15, X16
    STP  X19, X23, [X15, #0]
    LDUMINAH W2,W7,[X15]
    ADD  X15, X15, X16
    STP  X12, X22, [X15, #0]
    LDUMINALH W10,W8,[X15]
    ADD  X15, X15, X16
    STP  X5, X8, [X15, #0]
    LDUMINLH W21,W2,[X15]
    ADD  X15, X15, X16, LSR #0
    STP  X6, X6, [X15, #0]
    STUMIN W13,[X15]
    ADD  X15, X15, X16, ASR #0
    STP  X13, X14, [X15, #0]
    STUMIN X6,[X15]
    ADD  X15, X15, X16
    STP  X17, X3, [X15, #0]
    STUMINL W28,[X15]
    ADD  X15, X15, X16, ASR #0
    STP  X3, X28, [X15, #0]
    STUMINL X2,[X15]
    ADD  X15, X15, X16, ASR #0
    STP  X23, X6, [X15, #0]
    LDUMIN W2,W28,[X15]
    ADD  X15, X15, X16, ASR #0
    STP  X14, X23, [X15, #0]
    LDUMIN X21,X21,[X15]
    ADD  X15, X15, X16, LSR #0
    STP  X19, X23, [X15, #0]
    LDUMINA W17,W17,[X15]
    ADD  X15, X15, X16
    STP  X14, X10, [X15, #0]
    LDUMINA X2,X19,[X15]
    ADD  X15, X15, X16, ASR #0
    STP  X6, X28, [X15, #0]
    LDUMINAL W21,W18,[X15]
    ADD  X15, X15, X16
    STP  X28, X3, [X15, #0]
    LDUMINAL X19,X14,[X15]
    ADD  X15, X15, X16, ASR #0
    STP  X2, X7, [X15, #0]
    LDUMINL W2,W7,[X15]
    ADD  X15, X15, X16, LSR #0
    STP  X6, X7, [X15, #0]
    LDUMINL X23,X10,[X15]
    ADD  X15, X15, X16, LSR #0
    STP  X10, X7, [X15, #0]
    SWPB W28,W28,[X15]
    ADD  X15, X15, X16
    STP  X3, X23, [X15, #0]
    SWPAB W18,W21,[X15]
    ADD  X15, X15, X16, ASR #0
    STP  X17, X18, [X15, #0]
    SWPALB W22,W3,[X15]
    ADD  X15, X15, X16, ASR #0
    STP  X14, X21, [X15, #0]
    SWPLB W8,W8,[X15]
    ADD  X15, X15, X16, ASR #0
    STP  X3, X22, [X15, #0]
    SWPH W13,W21,[X15]
    ADD  X15, X15, X16
    STP  X28, X8, [X15, #0]
    SWPAH W8,W2,[X15]
    ADD  X15, X15, X16, ASR #0
    STP  X4, X3, [X15, #0]
    SWPALH W3,W18,[X15]
    ADD  X15, X15, X16, LSR #0
    STP  X14, X17, [X15, #0]
    SWPLH W28,W4,[X15]
    ADD  X15, X15, X16, LSR #0
    STP  X22, X7, [X15, #0]
    SWP W4,W19,[X15]
    ADD  X15, X15, X16
    STP  X18, X18, [X15, #0]
    SWP X10,X22,[X15]
    ADD  X15, X15, X16, LSR #0
    STP  X14, X21, [X15, #0]
    SWPA W22,W2,[X15]
    ADD  X15, X15, X16, ASR #0
    STP  X19, X17, [X15, #0]
    SWPA X6,X3,[X15]
    ADD  X15, X15, X16
    STP  X2, X22, [X15, #0]
    SWPAL W17,W17,[X15]
    ADD  X15, X15, X16, ASR #0
    STP  X12, X17, [X15, #0]
    SWPAL X21,X21,[X15]
    ADD  X15, X15, X16, ASR #0
    STP  X13, X23, [X15, #0]
    SWPL W22,W10,[X15]
    ADD  X15, X15, X16, ASR #0
    STP  X7, X12, [X15, #0]
    SWPL X23,X2,[X15]
    ADD  X15, X15, X16, LSR #0
    MOVZ  X9, #0x5a5a, LSL #0
    SUB  X11, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x5a, LSL #0
    SUB  X11, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X11, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x5a, LSL #0
    SUB  X11, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    SUB  X11, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x5a, LSL #0
    SUB  X11, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    SUB  X11, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x5a, LSL #0
    SUB  X11, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    SUB  X11, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x5a, LSL #0
    SUB  X11, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    SUB  X11, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    SUB  X11, X9, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X9, #0x5a, LSL #0
    SUB  X11, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTGeneralLoadStoreP04_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X10, #0x10, LSL #0
    MOVZ  X5, #0xc80, LSL #0
    ADD  X21, X30, X5, LSR #0
    STP  X18, X22, [X21, #0]
    STUMAXB W2,[X21]
    ADD  X21, X21, X10
    STP  X15, X7, [X21, #0]
    STUMAXLB W4,[X21]
    ADD  X21, X21, X10
    STP  X22, X20, [X21, #0]
    LDUMAXB W6,W8,[X21]
    ADD  X21, X21, X10
    STP  X17, X14, [X21, #0]
    LDUMAXAB W8,W18,[X21]
    ADD  X21, X21, X10, ASR #0
    STP  X28, X13, [X21, #0]
    LDUMAXALB W18,W28,[X21]
    ADD  X21, X21, X10, LSR #0
    STP  X14, X9, [X21, #0]
    LDUMAXLB W22,W14,[X21]
    ADD  X21, X21, X10
    STP  X20, X28, [X21, #0]
    STUMAXH W19,[X21]
    ADD  X21, X21, X10, LSR #0
    STP  X8, X15, [X21, #0]
    STUMAXLH W19,[X21]
    ADD  X21, X21, X10, LSR #0
    STP  X3, X19, [X21, #0]
    LDUMAXH W11,W22,[X21]
    ADD  X21, X21, X10, LSR #0
    STP  X2, X2, [X21, #0]
    LDUMAXAH W3,W6,[X21]
    ADD  X21, X21, X10, ASR #0
    STP  X16, X28, [X21, #0]
    LDUMAXALH W28,W15,[X21]
    ADD  X21, X21, X10, ASR #0
    STP  X28, X8, [X21, #0]
    LDUMAXLH W11,W28,[X21]
    ADD  X21, X21, X10
    STP  X22, X18, [X21, #0]
    STUMAX W4,[X21]
    ADD  X21, X21, X10
    STP  X9, X14, [X21, #0]
    STUMAX X3,[X21]
    ADD  X21, X21, X10, ASR #0
    STP  X15, X6, [X21, #0]
    STUMAXL W20,[X21]
    ADD  X21, X21, X10
    STP  X11, X20, [X21, #0]
    STUMAXL X11,[X21]
    ADD  X21, X21, X10
    STP  X7, X19, [X21, #0]
    LDUMAX W18,W16,[X21]
    ADD  X21, X21, X10
    STP  X3, X20, [X21, #0]
    LDUMAX X22,X4,[X21]
    ADD  X21, X21, X10, LSR #0
    STP  X9, X17, [X21, #0]
    LDUMAXA W9,W15,[X21]
    ADD  X21, X21, X10
    STP  X20, X18, [X21, #0]
    LDUMAXA X11,X3,[X21]
    ADD  X21, X21, X10, ASR #0
    STP  X28, X28, [X21, #0]
    LDUMAXAL W16,W18,[X21]
    ADD  X21, X21, X10, LSR #0
    STP  X17, X9, [X21, #0]
    LDUMAXAL X7,X4,[X21]
    ADD  X21, X21, X10, ASR #0
    STP  X14, X14, [X21, #0]
    LDUMAXL W22,W11,[X21]
    ADD  X21, X21, X10
    STP  X15, X8, [X21, #0]
    LDUMAXL X7,X18,[X21]
    ADD  X21, X21, X10, ASR #0
    STP  X2, X11, [X21, #0]
    STUMINB W4,[X21]
    ADD  X21, X21, X10, ASR #0
    STP  X9, X13, [X21, #0]
    STUMINLB W28,[X21]
    ADD  X21, X21, X10, LSR #0
    STP  X6, X28, [X21, #0]
    LDUMINB W20,W20,[X21]
    ADD  X21, X21, X10
    STP  X18, X7, [X21, #0]
    LDUMINAB W22,W9,[X21]
    ADD  X21, X21, X10, LSR #0
    STP  X28, X3, [X21, #0]
    LDUMINALB W4,W22,[X21]
    ADD  X21, X21, X10, ASR #0
    STP  X17, X16, [X21, #0]
    LDUMINLB W28,W3,[X21]
    ADD  X21, X21, X10
    STP  X7, X9, [X21, #0]
    STUMINH W8,[X21]
    ADD  X21, X21, X10, LSR #0
    STP  X3, X4, [X21, #0]
    STUMINLH W15,[X21]
    ADD  X21, X21, X10, LSR #0
    STP  X18, X28, [X21, #0]
    LDUMINH W13,W19,[X21]
    ADD  X21, X21, X10, ASR #0
    STP  X2, X17, [X21, #0]
    LDUMINAH W16,W28,[X21]
    ADD  X21, X21, X10, LSR #0
    STP  X4, X19, [X21, #0]
    LDUMINALH W15,W9,[X21]
    ADD  X21, X21, X10, ASR #0
    STP  X18, X8, [X21, #0]
    LDUMINLH W28,W16,[X21]
    ADD  X21, X21, X10, LSR #0
    STP  X9, X20, [X21, #0]
    STUMIN W8,[X21]
    ADD  X21, X21, X10
    STP  X16, X14, [X21, #0]
    STUMIN X9,[X21]
    ADD  X21, X21, X10, ASR #0
    STP  X11, X20, [X21, #0]
    STUMINL W8,[X21]
    ADD  X21, X21, X10, ASR #0
    STP  X11, X4, [X21, #0]
    STUMINL X16,[X21]
    ADD  X21, X21, X10, LSR #0
    STP  X16, X19, [X21, #0]
    LDUMIN W7,W4,[X21]
    ADD  X21, X21, X10
    STP  X17, X17, [X21, #0]
    LDUMIN X8,X11,[X21]
    ADD  X21, X21, X10
    STP  X3, X2, [X21, #0]
    LDUMINA W2,W16,[X21]
    ADD  X21, X21, X10, LSR #0
    STP  X9, X2, [X21, #0]
    LDUMINA X28,X9,[X21]
    ADD  X21, X21, X10, ASR #0
    STP  X9, X13, [X21, #0]
    LDUMINAL W8,W7,[X21]
    ADD  X21, X21, X10
    STP  X15, X2, [X21, #0]
    LDUMINAL X19,X19,[X21]
    ADD  X21, X21, X10, ASR #0
    STP  X18, X14, [X21, #0]
    LDUMINL W20,W20,[X21]
    ADD  X21, X21, X10
    STP  X22, X7, [X21, #0]
    LDUMINL X6,X13,[X21]
    ADD  X21, X21, X10
    STP  X18, X13, [X21, #0]
    SWPB W28,W18,[X21]
    ADD  X21, X21, X10
    STP  X9, X8, [X21, #0]
    SWPAB W9,W28,[X21]
    ADD  X21, X21, X10, ASR #0
    STP  X8, X3, [X21, #0]
    SWPALB W13,W18,[X21]
    ADD  X21, X21, X10
    STP  X6, X18, [X21, #0]
    SWPLB W16,W6,[X21]
    ADD  X21, X21, X10, LSR #0
    STP  X28, X3, [X21, #0]
    SWPH W20,W22,[X21]
    ADD  X21, X21, X10
    STP  X16, X22, [X21, #0]
    SWPAH W17,W18,[X21]
    ADD  X21, X21, X10, LSR #0
    STP  X17, X6, [X21, #0]
    SWPALH W17,W11,[X21]
    ADD  X21, X21, X10, ASR #0
    STP  X15, X3, [X21, #0]
    SWPLH W9,W7,[X21]
    ADD  X21, X21, X10
    STP  X19, X20, [X21, #0]
    SWP W28,W16,[X21]
    ADD  X21, X21, X10, LSR #0
    STP  X8, X28, [X21, #0]
    SWP X19,X9,[X21]
    ADD  X21, X21, X10, ASR #0
    STP  X19, X14, [X21, #0]
    SWPA W7,W28,[X21]
    ADD  X21, X21, X10, LSR #0
    STP  X4, X14, [X21, #0]
    SWPA X14,X4,[X21]
    ADD  X21, X21, X10
    STP  X15, X3, [X21, #0]
    SWPAL W16,W7,[X21]
    ADD  X21, X21, X10
    STP  X16, X3, [X21, #0]
    SWPAL X20,X11,[X21]
    ADD  X21, X21, X10
    STP  X16, X4, [X21, #0]
    SWPL W9,W9,[X21]
    ADD  X21, X21, X10, ASR #0
    STP  X20, X8, [X21, #0]
    SWPL X17,X15,[X21]
    ADD  X21, X21, X10, LSR #0
    MOVZ  X23, #0xa5, LSL #0
    SUB  X12, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    SUB  X12, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X12, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    SUB  X12, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0xa5, LSL #0
    SUB  X12, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    SUB  X12, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    SUB  X12, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0xa5, LSL #0
    SUB  X12, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0xa5, LSL #0
    SUB  X12, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    SUB  X12, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    SUB  X12, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X12, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0xa5, LSL #0
    SUB  X12, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    SUB  X12, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    SUB  X12, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0xa5, LSL #0
    SUB  X12, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    SUB  X12, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTGeneralLoadStoreP04_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X16, #0x10, LSL #0
    MOVZ  X8, #0xf00, LSL #0
    ADD  X9, X30, X8, LSR #0
    STP  X23, X23, [X9, #0]
    STUMAXB W22,[X9]
    ADD  X9, X9, X16, LSR #0
    STP  X28, X28, [X9, #0]
    STUMAXLB W21,[X9]
    ADD  X9, X9, X16, ASR #0
    STP  X14, X21, [X9, #0]
    LDUMAXB W19,W28,[X9]
    ADD  X9, X9, X16
    STP  X18, X22, [X9, #0]
    LDUMAXAB W28,W18,[X9]
    ADD  X9, X9, X16, LSR #0
    STP  X19, X10, [X9, #0]
    LDUMAXALB W12,W20,[X9]
    ADD  X9, X9, X16
    STP  X5, X21, [X9, #0]
    LDUMAXLB W13,W14,[X9]
    ADD  X9, X9, X16, ASR #0
    STP  X28, X22, [X9, #0]
    STUMAXH W18,[X9]
    ADD  X9, X9, X16
    STP  X6, X21, [X9, #0]
    STUMAXLH W23,[X9]
    ADD  X9, X9, X16
    STP  X23, X5, [X9, #0]
    LDUMAXH W21,W10,[X9]
    ADD  X9, X9, X16
    STP  X10, X20, [X9, #0]
    LDUMAXAH W4,W13,[X9]
    ADD  X9, X9, X16, LSR #0
    STP  X3, X15, [X9, #0]
    LDUMAXALH W4,W20,[X9]
    ADD  X9, X9, X16, ASR #0
    STP  X20, X23, [X9, #0]
    LDUMAXLH W5,W5,[X9]
    ADD  X9, X9, X16, ASR #0
    STP  X22, X22, [X9, #0]
    STUMAX W20,[X9]
    ADD  X9, X9, X16
    STP  X28, X3, [X9, #0]
    STUMAX X15,[X9]
    ADD  X9, X9, X16, LSR #0
    STP  X20, X12, [X9, #0]
    STUMAXL W28,[X9]
    ADD  X9, X9, X16
    STP  X23, X22, [X9, #0]
    STUMAXL X5,[X9]
    ADD  X9, X9, X16
    STP  X7, X23, [X9, #0]
    LDUMAX W15,W5,[X9]
    ADD  X9, X9, X16, LSR #0
    STP  X18, X18, [X9, #0]
    LDUMAX X18,X28,[X9]
    ADD  X9, X9, X16, ASR #0
    STP  X3, X6, [X9, #0]
    LDUMAXA W3,W23,[X9]
    ADD  X9, X9, X16
    STP  X15, X18, [X9, #0]
    LDUMAXA X3,X14,[X9]
    ADD  X9, X9, X16
    STP  X15, X14, [X9, #0]
    LDUMAXAL W17,W3,[X9]
    ADD  X9, X9, X16, ASR #0
    STP  X4, X22, [X9, #0]
    LDUMAXAL X28,X6,[X9]
    ADD  X9, X9, X16, ASR #0
    STP  X12, X19, [X9, #0]
    LDUMAXL W19,W20,[X9]
    ADD  X9, X9, X16, ASR #0
    STP  X13, X18, [X9, #0]
    LDUMAXL X4,X3,[X9]
    ADD  X9, X9, X16
    STP  X3, X13, [X9, #0]
    STUMINB W17,[X9]
    ADD  X9, X9, X16, ASR #0
    STP  X17, X3, [X9, #0]
    STUMINLB W3,[X9]
    ADD  X9, X9, X16
    STP  X13, X21, [X9, #0]
    LDUMINB W12,W13,[X9]
    ADD  X9, X9, X16, LSR #0
    STP  X12, X13, [X9, #0]
    LDUMINAB W15,W22,[X9]
    ADD  X9, X9, X16, LSR #0
    STP  X3, X6, [X9, #0]
    LDUMINALB W21,W13,[X9]
    ADD  X9, X9, X16, ASR #0
    STP  X14, X13, [X9, #0]
    LDUMINLB W23,W4,[X9]
    ADD  X9, X9, X16
    STP  X28, X19, [X9, #0]
    STUMINH W28,[X9]
    ADD  X9, X9, X16, LSR #0
    STP  X20, X7, [X9, #0]
    STUMINLH W5,[X9]
    ADD  X9, X9, X16, LSR #0
    STP  X12, X10, [X9, #0]
    LDUMINH W21,W13,[X9]
    ADD  X9, X9, X16
    STP  X6, X20, [X9, #0]
    LDUMINAH W20,W17,[X9]
    ADD  X9, X9, X16, ASR #0
    STP  X20, X12, [X9, #0]
    LDUMINALH W12,W14,[X9]
    ADD  X9, X9, X16, LSR #0
    STP  X13, X15, [X9, #0]
    LDUMINLH W12,W28,[X9]
    ADD  X9, X9, X16, LSR #0
    STP  X18, X20, [X9, #0]
    STUMIN W3,[X9]
    ADD  X9, X9, X16, LSR #0
    STP  X23, X19, [X9, #0]
    STUMIN X18,[X9]
    ADD  X9, X9, X16, ASR #0
    STP  X10, X3, [X9, #0]
    STUMINL W17,[X9]
    ADD  X9, X9, X16, LSR #0
    STP  X10, X14, [X9, #0]
    STUMINL X19,[X9]
    ADD  X9, X9, X16, LSR #0
    STP  X17, X13, [X9, #0]
    LDUMIN W7,W15,[X9]
    ADD  X9, X9, X16
    STP  X23, X6, [X9, #0]
    LDUMIN X22,X18,[X9]
    ADD  X9, X9, X16, LSR #0
    STP  X3, X10, [X9, #0]
    LDUMINA W17,W7,[X9]
    ADD  X9, X9, X16
    STP  X13, X28, [X9, #0]
    LDUMINA X19,X4,[X9]
    ADD  X9, X9, X16
    STP  X4, X10, [X9, #0]
    LDUMINAL W10,W10,[X9]
    ADD  X9, X9, X16, ASR #0
    STP  X12, X7, [X9, #0]
    LDUMINAL X28,X19,[X9]
    ADD  X9, X9, X16, LSR #0
    STP  X18, X12, [X9, #0]
    LDUMINL W20,W5,[X9]
    ADD  X9, X9, X16
    STP  X4, X28, [X9, #0]
    LDUMINL X22,X20,[X9]
    ADD  X9, X9, X16
    STP  X6, X6, [X9, #0]
    SWPB W15,W23,[X9]
    ADD  X9, X9, X16
    STP  X15, X28, [X9, #0]
    SWPAB W15,W18,[X9]
    ADD  X9, X9, X16, LSR #0
    STP  X19, X7, [X9, #0]
    SWPALB W5,W18,[X9]
    ADD  X9, X9, X16
    STP  X17, X19, [X9, #0]
    SWPLB W3,W5,[X9]
    ADD  X9, X9, X16, LSR #0
    STP  X21, X12, [X9, #0]
    SWPH W15,W15,[X9]
    ADD  X9, X9, X16
    STP  X23, X5, [X9, #0]
    SWPAH W19,W12,[X9]
    ADD  X9, X9, X16
    STP  X15, X12, [X9, #0]
    SWPALH W28,W28,[X9]
    ADD  X9, X9, X16, LSR #0
    STP  X18, X28, [X9, #0]
    SWPLH W18,W7,[X9]
    ADD  X9, X9, X16, ASR #0
    STP  X20, X13, [X9, #0]
    SWP W22,W19,[X9]
    ADD  X9, X9, X16, ASR #0
    STP  X19, X21, [X9, #0]
    SWP X23,X17,[X9]
    ADD  X9, X9, X16, LSR #0
    STP  X18, X28, [X9, #0]
    SWPA W5,W12,[X9]
    ADD  X9, X9, X16, ASR #0
    STP  X23, X12, [X9, #0]
    SWPA X13,X10,[X9]
    ADD  X9, X9, X16
    STP  X4, X3, [X9, #0]
    SWPAL W6,W12,[X9]
    ADD  X9, X9, X16, ASR #0
    STP  X10, X13, [X9, #0]
    SWPAL X5,X13,[X9]
    ADD  X9, X9, X16, LSR #0
    STP  X6, X23, [X9, #0]
    SWPL W13,W12,[X9]
    ADD  X9, X9, X16, LSR #0
    STP  X15, X17, [X9, #0]
    SWPL X4,X19,[X9]
    ADD  X9, X9, X16
    MOVZ  X11, #0x5a5a, LSL #0
    SUB  X2, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    SUB  X2, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X11, #0x5a, LSL #0
    SUB  X2, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X2, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X11, #0x5a, LSL #0
    SUB  X2, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X11, #0x5a, LSL #0
    SUB  X2, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X11, #0x5a, LSL #0
    SUB  X2, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    SUB  X2, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    SUB  X2, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X11, #0x5a, LSL #0
    SUB  X2, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    SUB  X2, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X11, #0x5a, LSL #0
    SUB  X2, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X11, #0x5a, LSL #0
    SUB  X2, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X19, #0x10, LSL #0
    MOVZ  X23, #0x1180, LSL #0
    ADD  X20, X30, X23
    STP  X22, X22, [X20, #0]
    STUMAXB W28,[X20]
    ADD  X20, X20, X19
    STP  X13, X21, [X20, #0]
    STUMAXLB W18,[X20]
    ADD  X20, X20, X19
    STP  X21, X15, [X20, #0]
    LDUMAXB W9,W9,[X20]
    ADD  X20, X20, X19, ASR #0
    STP  X21, X2, [X20, #0]
    LDUMAXAB W14,W14,[X20]
    ADD  X20, X20, X19, LSR #0
    STP  X6, X28, [X20, #0]
    LDUMAXALB W8,W28,[X20]
    ADD  X20, X20, X19, LSR #0
    STP  X10, X7, [X20, #0]
    LDUMAXLB W18,W12,[X20]
    ADD  X20, X20, X19, ASR #0
    STP  X22, X22, [X20, #0]
    STUMAXH W15,[X20]
    ADD  X20, X20, X19, LSR #0
    STP  X3, X4, [X20, #0]
    STUMAXLH W17,[X20]
    ADD  X20, X20, X19
    STP  X6, X14, [X20, #0]
    LDUMAXH W17,W9,[X20]
    ADD  X20, X20, X19, ASR #0
    STP  X17, X8, [X20, #0]
    LDUMAXAH W2,W3,[X20]
    ADD  X20, X20, X19
    STP  X14, X3, [X20, #0]
    LDUMAXALH W7,W6,[X20]
    ADD  X20, X20, X19
    STP  X15, X15, [X20, #0]
    LDUMAXLH W7,W4,[X20]
    ADD  X20, X20, X19
    STP  X28, X7, [X20, #0]
    STUMAX W6,[X20]
    ADD  X20, X20, X19, ASR #0
    STP  X2, X6, [X20, #0]
    STUMAX X13,[X20]
    ADD  X20, X20, X19, LSR #0
    STP  X15, X9, [X20, #0]
    STUMAXL W10,[X20]
    ADD  X20, X20, X19, ASR #0
    STP  X11, X4, [X20, #0]
    STUMAXL X15,[X20]
    ADD  X20, X20, X19
    STP  X13, X21, [X20, #0]
    LDUMAX W22,W21,[X20]
    ADD  X20, X20, X19, LSR #0
    STP  X21, X9, [X20, #0]
    LDUMAX X2,X8,[X20]
    ADD  X20, X20, X19, LSR #0
    STP  X3, X18, [X20, #0]
    LDUMAXA W11,W7,[X20]
    ADD  X20, X20, X19, ASR #0
    STP  X6, X28, [X20, #0]
    LDUMAXA X13,X21,[X20]
    ADD  X20, X20, X19
    STP  X8, X12, [X20, #0]
    LDUMAXAL W14,W12,[X20]
    ADD  X20, X20, X19, ASR #0
    STP  X4, X28, [X20, #0]
    LDUMAXAL X13,X11,[X20]
    ADD  X20, X20, X19
    STP  X17, X9, [X20, #0]
    LDUMAXL W4,W6,[X20]
    ADD  X20, X20, X19, ASR #0
    STP  X22, X14, [X20, #0]
    LDUMAXL X6,X2,[X20]
    ADD  X20, X20, X19
    STP  X8, X18, [X20, #0]
    STUMINB W8,[X20]
    ADD  X20, X20, X19, LSR #0
    STP  X9, X14, [X20, #0]
    STUMINLB W17,[X20]
    ADD  X20, X20, X19, LSR #0
    STP  X17, X15, [X20, #0]
    LDUMINB W7,W7,[X20]
    ADD  X20, X20, X19, LSR #0
    STP  X17, X14, [X20, #0]
    LDUMINAB W10,W28,[X20]
    ADD  X20, X20, X19, ASR #0
    STP  X15, X10, [X20, #0]
    LDUMINALB W15,W21,[X20]
    ADD  X20, X20, X19, LSR #0
    STP  X8, X15, [X20, #0]
    LDUMINLB W7,W10,[X20]
    ADD  X20, X20, X19, LSR #0
    STP  X2, X4, [X20, #0]
    STUMINH W17,[X20]
    ADD  X20, X20, X19, LSR #0
    STP  X11, X8, [X20, #0]
    STUMINLH W22,[X20]
    ADD  X20, X20, X19, ASR #0
    STP  X18, X12, [X20, #0]
    LDUMINH W22,W14,[X20]
    ADD  X20, X20, X19, ASR #0
    STP  X7, X2, [X20, #0]
    LDUMINAH W3,W15,[X20]
    ADD  X20, X20, X19, LSR #0
    STP  X4, X12, [X20, #0]
    LDUMINALH W11,W4,[X20]
    ADD  X20, X20, X19, ASR #0
    STP  X2, X8, [X20, #0]
    LDUMINLH W9,W3,[X20]
    ADD  X20, X20, X19
    STP  X15, X21, [X20, #0]
    STUMIN W15,[X20]
    ADD  X20, X20, X19
    STP  X8, X18, [X20, #0]
    STUMIN X21,[X20]
    ADD  X20, X20, X19, ASR #0
    STP  X11, X28, [X20, #0]
    STUMINL W21,[X20]
    ADD  X20, X20, X19
    STP  X7, X6, [X20, #0]
    STUMINL X12,[X20]
    ADD  X20, X20, X19, LSR #0
    STP  X8, X8, [X20, #0]
    LDUMIN W15,W8,[X20]
    ADD  X20, X20, X19, LSR #0
    STP  X13, X22, [X20, #0]
    LDUMIN X14,X7,[X20]
    ADD  X20, X20, X19, ASR #0
    STP  X17, X4, [X20, #0]
    LDUMINA W12,W3,[X20]
    ADD  X20, X20, X19, LSR #0
    STP  X4, X9, [X20, #0]
    LDUMINA X14,X18,[X20]
    ADD  X20, X20, X19, LSR #0
    STP  X22, X14, [X20, #0]
    LDUMINAL W17,W2,[X20]
    ADD  X20, X20, X19, LSR #0
    STP  X2, X21, [X20, #0]
    LDUMINAL X13,X6,[X20]
    ADD  X20, X20, X19, ASR #0
    STP  X9, X6, [X20, #0]
    LDUMINL W13,W12,[X20]
    ADD  X20, X20, X19
    STP  X18, X22, [X20, #0]
    LDUMINL X13,X15,[X20]
    ADD  X20, X20, X19, LSR #0
    STP  X17, X9, [X20, #0]
    SWPB W4,W2,[X20]
    ADD  X20, X20, X19, ASR #0
    STP  X8, X9, [X20, #0]
    SWPAB W22,W21,[X20]
    ADD  X20, X20, X19
    STP  X2, X7, [X20, #0]
    SWPALB W8,W6,[X20]
    ADD  X20, X20, X19
    STP  X28, X17, [X20, #0]
    SWPLB W14,W4,[X20]
    ADD  X20, X20, X19
    STP  X10, X6, [X20, #0]
    SWPH W11,W6,[X20]
    ADD  X20, X20, X19, LSR #0
    STP  X8, X6, [X20, #0]
    SWPAH W3,W18,[X20]
    ADD  X20, X20, X19, ASR #0
    STP  X15, X9, [X20, #0]
    SWPALH W18,W17,[X20]
    ADD  X20, X20, X19
    STP  X8, X13, [X20, #0]
    SWPLH W28,W11,[X20]
    ADD  X20, X20, X19, ASR #0
    STP  X7, X14, [X20, #0]
    SWP W8,W2,[X20]
    ADD  X20, X20, X19
    STP  X21, X18, [X20, #0]
    SWP X9,X14,[X20]
    ADD  X20, X20, X19, ASR #0
    STP  X2, X4, [X20, #0]
    SWPA W28,W28,[X20]
    ADD  X20, X20, X19, LSR #0
    STP  X15, X10, [X20, #0]
    SWPA X7,X6,[X20]
    ADD  X20, X20, X19, ASR #0
    STP  X17, X22, [X20, #0]
    SWPAL W10,W8,[X20]
    ADD  X20, X20, X19, ASR #0
    STP  X17, X12, [X20, #0]
    SWPAL X22,X9,[X20]
    ADD  X20, X20, X19, LSR #0
    STP  X15, X18, [X20, #0]
    SWPL W9,W22,[X20]
    ADD  X20, X20, X19, LSR #0
    STP  X28, X8, [X20, #0]
    SWPL X9,X8,[X20]
    ADD  X20, X20, X19
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    SUB  X16, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5, LSL #0
    SUB  X16, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    SUB  X16, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    SUB  X16, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    SUB  X16, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    SUB  X16, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    SUB  X16, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    SUB  X16, X5, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X10, #0x10, LSL #0
    MOVZ  X23, #0x1400, LSL #0
    ADD  X11, X30, X23, LSR #0
    STP  X18, X14, [X11, #0]
    STUMAXB W28,[X11]
    ADD  X11, X11, X10, ASR #0
    STP  X22, X22, [X11, #0]
    STUMAXLB W18,[X11]
    ADD  X11, X11, X10, ASR #0
    STP  X22, X17, [X11, #0]
    LDUMAXB W14,W19,[X11]
    ADD  X11, X11, X10
    STP  X19, X7, [X11, #0]
    LDUMAXAB W6,W7,[X11]
    ADD  X11, X11, X10
    STP  X18, X7, [X11, #0]
    LDUMAXALB W5,W19,[X11]
    ADD  X11, X11, X10
    STP  X18, X5, [X11, #0]
    LDUMAXLB W8,W12,[X11]
    ADD  X11, X11, X10, LSR #0
    STP  X5, X17, [X11, #0]
    STUMAXH W4,[X11]
    ADD  X11, X11, X10, LSR #0
    STP  X20, X15, [X11, #0]
    STUMAXLH W20,[X11]
    ADD  X11, X11, X10, ASR #0
    STP  X18, X5, [X11, #0]
    LDUMAXH W14,W6,[X11]
    ADD  X11, X11, X10, LSR #0
    STP  X4, X18, [X11, #0]
    LDUMAXAH W5,W17,[X11]
    ADD  X11, X11, X10, LSR #0
    STP  X4, X8, [X11, #0]
    LDUMAXALH W18,W5,[X11]
    ADD  X11, X11, X10
    STP  X16, X19, [X11, #0]
    LDUMAXLH W3,W15,[X11]
    ADD  X11, X11, X10
    STP  X9, X8, [X11, #0]
    STUMAX W4,[X11]
    ADD  X11, X11, X10, ASR #0
    STP  X3, X17, [X11, #0]
    STUMAX X22,[X11]
    ADD  X11, X11, X10
    STP  X9, X13, [X11, #0]
    STUMAXL W7,[X11]
    ADD  X11, X11, X10, LSR #0
    STP  X28, X18, [X11, #0]
    STUMAXL X19,[X11]
    ADD  X11, X11, X10
    STP  X5, X5, [X11, #0]
    LDUMAX W5,W17,[X11]
    ADD  X11, X11, X10, LSR #0
    STP  X3, X9, [X11, #0]
    LDUMAX X12,X16,[X11]
    ADD  X11, X11, X10
    STP  X15, X19, [X11, #0]
    LDUMAXA W19,W6,[X11]
    ADD  X11, X11, X10, LSR #0
    STP  X19, X12, [X11, #0]
    LDUMAXA X16,X12,[X11]
    ADD  X11, X11, X10, LSR #0
    STP  X4, X28, [X11, #0]
    LDUMAXAL W16,W13,[X11]
    ADD  X11, X11, X10, ASR #0
    STP  X13, X4, [X11, #0]
    LDUMAXAL X12,X8,[X11]
    ADD  X11, X11, X10, LSR #0
    STP  X19, X18, [X11, #0]
    LDUMAXL W16,W3,[X11]
    ADD  X11, X11, X10, ASR #0
    STP  X15, X4, [X11, #0]
    LDUMAXL X18,X18,[X11]
    ADD  X11, X11, X10
    STP  X8, X7, [X11, #0]
    STUMINB W6,[X11]
    ADD  X11, X11, X10, LSR #0
    STP  X28, X5, [X11, #0]
    STUMINLB W14,[X11]
    ADD  X11, X11, X10, LSR #0
    STP  X4, X14, [X11, #0]
    LDUMINB W7,W5,[X11]
    ADD  X11, X11, X10, ASR #0
    STP  X16, X16, [X11, #0]
    LDUMINAB W19,W3,[X11]
    ADD  X11, X11, X10, LSR #0
    STP  X4, X8, [X11, #0]
    LDUMINALB W8,W16,[X11]
    ADD  X11, X11, X10, LSR #0
    STP  X20, X13, [X11, #0]
    LDUMINLB W4,W8,[X11]
    ADD  X11, X11, X10, LSR #0
    STP  X18, X8, [X11, #0]
    STUMINH W4,[X11]
    ADD  X11, X11, X10, LSR #0
    STP  X6, X16, [X11, #0]
    STUMINLH W9,[X11]
    ADD  X11, X11, X10
    STP  X13, X3, [X11, #0]
    LDUMINH W12,W19,[X11]
    ADD  X11, X11, X10
    STP  X12, X15, [X11, #0]
    LDUMINAH W6,W18,[X11]
    ADD  X11, X11, X10, LSR #0
    STP  X9, X18, [X11, #0]
    LDUMINALH W22,W5,[X11]
    ADD  X11, X11, X10
    STP  X7, X8, [X11, #0]
    LDUMINLH W7,W20,[X11]
    ADD  X11, X11, X10
    STP  X17, X6, [X11, #0]
    STUMIN W5,[X11]
    ADD  X11, X11, X10, LSR #0
    STP  X12, X22, [X11, #0]
    STUMIN X19,[X11]
    ADD  X11, X11, X10, LSR #0
    STP  X18, X28, [X11, #0]
    STUMINL W28,[X11]
    ADD  X11, X11, X10, LSR #0
    STP  X8, X19, [X11, #0]
    STUMINL X8,[X11]
    ADD  X11, X11, X10, LSR #0
    STP  X6, X20, [X11, #0]
    LDUMIN W18,W6,[X11]
    ADD  X11, X11, X10, LSR #0
    STP  X3, X22, [X11, #0]
    LDUMIN X15,X18,[X11]
    ADD  X11, X11, X10
    STP  X14, X9, [X11, #0]
    LDUMINA W4,W3,[X11]
    ADD  X11, X11, X10, LSR #0
    STP  X12, X20, [X11, #0]
    LDUMINA X18,X19,[X11]
    ADD  X11, X11, X10
    STP  X15, X6, [X11, #0]
    LDUMINAL W18,W4,[X11]
    ADD  X11, X11, X10, ASR #0
    STP  X7, X12, [X11, #0]
    LDUMINAL X7,X9,[X11]
    ADD  X11, X11, X10, LSR #0
    STP  X19, X28, [X11, #0]
    LDUMINL W18,W7,[X11]
    ADD  X11, X11, X10
    STP  X8, X20, [X11, #0]
    LDUMINL X14,X8,[X11]
    ADD  X11, X11, X10
    STP  X15, X16, [X11, #0]
    SWPB W22,W15,[X11]
    ADD  X11, X11, X10
    STP  X19, X14, [X11, #0]
    SWPAB W12,W28,[X11]
    ADD  X11, X11, X10, LSR #0
    STP  X19, X28, [X11, #0]
    SWPALB W13,W8,[X11]
    ADD  X11, X11, X10, LSR #0
    STP  X28, X7, [X11, #0]
    SWPLB W5,W20,[X11]
    ADD  X11, X11, X10, ASR #0
    STP  X28, X16, [X11, #0]
    SWPH W12,W14,[X11]
    ADD  X11, X11, X10, ASR #0
    STP  X7, X4, [X11, #0]
    SWPAH W6,W19,[X11]
    ADD  X11, X11, X10, ASR #0
    STP  X7, X8, [X11, #0]
    SWPALH W13,W16,[X11]
    ADD  X11, X11, X10, ASR #0
    STP  X7, X13, [X11, #0]
    SWPLH W5,W8,[X11]
    ADD  X11, X11, X10
    STP  X5, X12, [X11, #0]
    SWP W3,W5,[X11]
    ADD  X11, X11, X10
    STP  X17, X5, [X11, #0]
    SWP X15,X17,[X11]
    ADD  X11, X11, X10, ASR #0
    STP  X20, X3, [X11, #0]
    SWPA W3,W12,[X11]
    ADD  X11, X11, X10, ASR #0
    STP  X16, X12, [X11, #0]
    SWPA X3,X16,[X11]
    ADD  X11, X11, X10, LSR #0
    STP  X7, X12, [X11, #0]
    SWPAL W22,W12,[X11]
    ADD  X11, X11, X10, ASR #0
    STP  X20, X16, [X11, #0]
    SWPAL X12,X13,[X11]
    ADD  X11, X11, X10, ASR #0
    STP  X15, X9, [X11, #0]
    SWPL W6,W9,[X11]
    ADD  X11, X11, X10, LSR #0
    STP  X9, X28, [X11, #0]
    SWPL X5,X13,[X11]
    ADD  X11, X11, X10, ASR #0
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    SUB  X2, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    SUB  X2, X21, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    SUB  X2, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    SUB  X2, X21, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X2, X21, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X2, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X2, X21, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X2, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X2, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X2, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X2, X21, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X2, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    SUB  X2, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X2, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X2, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X21, #0x5a, LSL #0
    SUB  X2, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTGeneralLoadStoreP04_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X9, #0x10, LSL #0
    MOVZ  X5, #0x1680, LSL #0
    ADD  X23, X30, X5, LSR #0
    STP  X2, X12, [X23, #0]
    STUMAXB W21,[X23]
    ADD  X23, X23, X9, LSR #0
    STP  X22, X22, [X23, #0]
    STUMAXLB W17,[X23]
    ADD  X23, X23, X9, LSR #0
    STP  X19, X6, [X23, #0]
    LDUMAXB W21,W18,[X23]
    ADD  X23, X23, X9
    STP  X10, X14, [X23, #0]
    LDUMAXAB W18,W22,[X23]
    ADD  X23, X23, X9
    STP  X22, X22, [X23, #0]
    LDUMAXALB W10,W7,[X23]
    ADD  X23, X23, X9, ASR #0
    STP  X17, X6, [X23, #0]
    LDUMAXLB W2,W18,[X23]
    ADD  X23, X23, X9
    STP  X4, X10, [X23, #0]
    STUMAXH W17,[X23]
    ADD  X23, X23, X9, LSR #0
    STP  X12, X16, [X23, #0]
    STUMAXLH W15,[X23]
    ADD  X23, X23, X9
    STP  X7, X21, [X23, #0]
    LDUMAXH W12,W18,[X23]
    ADD  X23, X23, X9, ASR #0
    STP  X7, X8, [X23, #0]
    LDUMAXAH W16,W17,[X23]
    ADD  X23, X23, X9
    STP  X17, X6, [X23, #0]
    LDUMAXALH W11,W10,[X23]
    ADD  X23, X23, X9, ASR #0
    STP  X16, X3, [X23, #0]
    LDUMAXLH W4,W16,[X23]
    ADD  X23, X23, X9
    STP  X15, X2, [X23, #0]
    STUMAX W22,[X23]
    ADD  X23, X23, X9, ASR #0
    STP  X18, X15, [X23, #0]
    STUMAX X13,[X23]
    ADD  X23, X23, X9, LSR #0
    STP  X16, X12, [X23, #0]
    STUMAXL W8,[X23]
    ADD  X23, X23, X9, LSR #0
    STP  X13, X11, [X23, #0]
    STUMAXL X6,[X23]
    ADD  X23, X23, X9, ASR #0
    STP  X10, X13, [X23, #0]
    LDUMAX W22,W3,[X23]
    ADD  X23, X23, X9, LSR #0
    STP  X4, X11, [X23, #0]
    LDUMAX X10,X2,[X23]
    ADD  X23, X23, X9, ASR #0
    STP  X4, X21, [X23, #0]
    LDUMAXA W10,W4,[X23]
    ADD  X23, X23, X9, ASR #0
    STP  X7, X12, [X23, #0]
    LDUMAXA X16,X6,[X23]
    ADD  X23, X23, X9, LSR #0
    STP  X13, X16, [X23, #0]
    LDUMAXAL W15,W16,[X23]
    ADD  X23, X23, X9
    STP  X16, X22, [X23, #0]
    LDUMAXAL X7,X10,[X23]
    ADD  X23, X23, X9, LSR #0
    STP  X11, X3, [X23, #0]
    LDUMAXL W3,W21,[X23]
    ADD  X23, X23, X9, LSR #0
    STP  X4, X11, [X23, #0]
    LDUMAXL X2,X16,[X23]
    ADD  X23, X23, X9, LSR #0
    STP  X13, X6, [X23, #0]
    STUMINB W2,[X23]
    ADD  X23, X23, X9, LSR #0
    STP  X10, X4, [X23, #0]
    STUMINLB W19,[X23]
    ADD  X23, X23, X9
    STP  X17, X14, [X23, #0]
    LDUMINB W11,W10,[X23]
    ADD  X23, X23, X9, LSR #0
    STP  X14, X7, [X23, #0]
    LDUMINAB W16,W10,[X23]
    ADD  X23, X23, X9
    STP  X12, X11, [X23, #0]
    LDUMINALB W6,W11,[X23]
    ADD  X23, X23, X9, LSR #0
    STP  X12, X17, [X23, #0]
    LDUMINLB W3,W12,[X23]
    ADD  X23, X23, X9, LSR #0
    STP  X10, X12, [X23, #0]
    STUMINH W16,[X23]
    ADD  X23, X23, X9, LSR #0
    STP  X22, X12, [X23, #0]
    STUMINLH W3,[X23]
    ADD  X23, X23, X9
    STP  X11, X21, [X23, #0]
    LDUMINH W13,W17,[X23]
    ADD  X23, X23, X9
    STP  X16, X7, [X23, #0]
    LDUMINAH W22,W11,[X23]
    ADD  X23, X23, X9
    STP  X17, X21, [X23, #0]
    LDUMINALH W4,W17,[X23]
    ADD  X23, X23, X9, LSR #0
    STP  X15, X17, [X23, #0]
    LDUMINLH W15,W21,[X23]
    ADD  X23, X23, X9
    STP  X21, X12, [X23, #0]
    STUMIN W10,[X23]
    ADD  X23, X23, X9, LSR #0
    STP  X22, X7, [X23, #0]
    STUMIN X14,[X23]
    ADD  X23, X23, X9
    STP  X8, X19, [X23, #0]
    STUMINL W11,[X23]
    ADD  X23, X23, X9
    STP  X22, X13, [X23, #0]
    STUMINL X16,[X23]
    ADD  X23, X23, X9, ASR #0
    STP  X2, X19, [X23, #0]
    LDUMIN W2,W10,[X23]
    ADD  X23, X23, X9
    STP  X14, X7, [X23, #0]
    LDUMIN X4,X13,[X23]
    ADD  X23, X23, X9, ASR #0
    STP  X2, X2, [X23, #0]
    LDUMINA W14,W8,[X23]
    ADD  X23, X23, X9
    STP  X19, X11, [X23, #0]
    LDUMINA X22,X22,[X23]
    ADD  X23, X23, X9, ASR #0
    STP  X3, X12, [X23, #0]
    LDUMINAL W11,W17,[X23]
    ADD  X23, X23, X9, ASR #0
    STP  X13, X21, [X23, #0]
    LDUMINAL X18,X16,[X23]
    ADD  X23, X23, X9, ASR #0
    STP  X13, X6, [X23, #0]
    LDUMINL W14,W13,[X23]
    ADD  X23, X23, X9, LSR #0
    STP  X7, X6, [X23, #0]
    LDUMINL X22,X7,[X23]
    ADD  X23, X23, X9, ASR #0
    STP  X16, X2, [X23, #0]
    SWPB W18,W4,[X23]
    ADD  X23, X23, X9, LSR #0
    STP  X19, X8, [X23, #0]
    SWPAB W2,W6,[X23]
    ADD  X23, X23, X9, ASR #0
    STP  X4, X7, [X23, #0]
    SWPALB W12,W16,[X23]
    ADD  X23, X23, X9
    STP  X13, X2, [X23, #0]
    SWPLB W6,W21,[X23]
    ADD  X23, X23, X9
    STP  X8, X16, [X23, #0]
    SWPH W15,W19,[X23]
    ADD  X23, X23, X9, ASR #0
    STP  X17, X17, [X23, #0]
    SWPAH W12,W11,[X23]
    ADD  X23, X23, X9, ASR #0
    STP  X7, X22, [X23, #0]
    SWPALH W19,W7,[X23]
    ADD  X23, X23, X9, ASR #0
    STP  X2, X22, [X23, #0]
    SWPLH W2,W21,[X23]
    ADD  X23, X23, X9, ASR #0
    STP  X12, X13, [X23, #0]
    SWP W17,W16,[X23]
    ADD  X23, X23, X9, ASR #0
    STP  X22, X6, [X23, #0]
    SWP X11,X2,[X23]
    ADD  X23, X23, X9, LSR #0
    STP  X12, X6, [X23, #0]
    SWPA W10,W19,[X23]
    ADD  X23, X23, X9
    STP  X8, X8, [X23, #0]
    SWPA X22,X22,[X23]
    ADD  X23, X23, X9, LSR #0
    STP  X13, X18, [X23, #0]
    SWPAL W16,W16,[X23]
    ADD  X23, X23, X9, ASR #0
    STP  X16, X10, [X23, #0]
    SWPAL X13,X2,[X23]
    ADD  X23, X23, X9, LSR #0
    STP  X6, X11, [X23, #0]
    SWPL W10,W18,[X23]
    ADD  X23, X23, X9
    STP  X19, X17, [X23, #0]
    SWPL X11,X8,[X23]
    ADD  X23, X23, X9
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0xa5, LSL #0
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0xa5, LSL #0
    SUB  X28, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0xa5, LSL #0
    SUB  X28, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0xa5, LSL #0
    SUB  X28, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    SUB  X28, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0xa5, LSL #0
    SUB  X28, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0xa5, LSL #0
    SUB  X28, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X28, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0xa5, LSL #0
    SUB  X28, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0xa5, LSL #0
    SUB  X28, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0xa5, LSL #0
    SUB  X28, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    SUB  X28, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    SUB  X28, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X28, LCRTGeneralLoadStoreP04_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X5, #0x10, LSL #0
    MOVZ  X11, #0x0, LSL #0
    ADD  X14, X30, X11, ASR #0
    STP  X22, X10, [X14, #0]
    STUMAXB W16,[X14]
    ADD  X14, X14, X5, LSR #0
    STP  X7, X23, [X14, #0]
    STUMAXLB W28,[X14]
    ADD  X14, X14, X5, ASR #0
    STP  X8, X8, [X14, #0]
    LDUMAXB W8,W13,[X14]
    ADD  X14, X14, X5, ASR #0
    STP  X13, X16, [X14, #0]
    LDUMAXAB W21,W12,[X14]
    ADD  X14, X14, X5, LSR #0
    STP  X20, X16, [X14, #0]
    LDUMAXALB W9,W13,[X14]
    ADD  X14, X14, X5, ASR #0
    STP  X6, X6, [X14, #0]
    LDUMAXLB W4,W21,[X14]
    ADD  X14, X14, X5, LSR #0
    STP  X8, X4, [X14, #0]
    STUMAXH W7,[X14]
    ADD  X14, X14, X5, LSR #0
    STP  X8, X22, [X14, #0]
    STUMAXLH W22,[X14]
    ADD  X14, X14, X5, ASR #0
    STP  X8, X10, [X14, #0]
    LDUMAXH W8,W16,[X14]
    ADD  X14, X14, X5, LSR #0
    STP  X7, X2, [X14, #0]
    LDUMAXAH W16,W22,[X14]
    ADD  X14, X14, X5, LSR #0
    STP  X16, X12, [X14, #0]
    LDUMAXALH W6,W28,[X14]
    ADD  X14, X14, X5, ASR #0
    STP  X18, X9, [X14, #0]
    LDUMAXLH W17,W16,[X14]
    ADD  X14, X14, X5, LSR #0
    STP  X20, X10, [X14, #0]
    STUMAX W10,[X14]
    ADD  X14, X14, X5, ASR #0
    STP  X9, X8, [X14, #0]
    STUMAX X7,[X14]
    ADD  X14, X14, X5, ASR #0
    STP  X8, X8, [X14, #0]
    STUMAXL W17,[X14]
    ADD  X14, X14, X5
    STP  X28, X13, [X14, #0]
    STUMAXL X20,[X14]
    ADD  X14, X14, X5
    STP  X7, X13, [X14, #0]
    LDUMAX W6,W20,[X14]
    ADD  X14, X14, X5, LSR #0
    STP  X12, X20, [X14, #0]
    LDUMAX X3,X17,[X14]
    ADD  X14, X14, X5
    STP  X10, X28, [X14, #0]
    LDUMAXA W17,W13,[X14]
    ADD  X14, X14, X5
    STP  X13, X23, [X14, #0]
    LDUMAXA X9,X23,[X14]
    ADD  X14, X14, X5
    STP  X18, X3, [X14, #0]
    LDUMAXAL W28,W20,[X14]
    ADD  X14, X14, X5
    STP  X13, X22, [X14, #0]
    LDUMAXAL X4,X10,[X14]
    ADD  X14, X14, X5, ASR #0
    STP  X18, X9, [X14, #0]
    LDUMAXL W18,W6,[X14]
    ADD  X14, X14, X5, ASR #0
    STP  X7, X16, [X14, #0]
    LDUMAXL X6,X16,[X14]
    ADD  X14, X14, X5
    STP  X13, X2, [X14, #0]
    STUMINB W23,[X14]
    ADD  X14, X14, X5, LSR #0
    STP  X2, X12, [X14, #0]
    STUMINLB W22,[X14]
    ADD  X14, X14, X5
    STP  X23, X16, [X14, #0]
    LDUMINB W17,W6,[X14]
    ADD  X14, X14, X5, LSR #0
    STP  X17, X6, [X14, #0]
    LDUMINAB W7,W13,[X14]
    ADD  X14, X14, X5
    STP  X10, X28, [X14, #0]
    LDUMINALB W6,W18,[X14]
    ADD  X14, X14, X5
    STP  X4, X21, [X14, #0]
    LDUMINLB W16,W2,[X14]
    ADD  X14, X14, X5
    STP  X8, X16, [X14, #0]
    STUMINH W9,[X14]
    ADD  X14, X14, X5, LSR #0
    STP  X23, X10, [X14, #0]
    STUMINLH W9,[X14]
    ADD  X14, X14, X5, LSR #0
    STP  X3, X28, [X14, #0]
    LDUMINH W6,W9,[X14]
    ADD  X14, X14, X5
    STP  X4, X2, [X14, #0]
    LDUMINAH W21,W17,[X14]
    ADD  X14, X14, X5, ASR #0
    STP  X22, X4, [X14, #0]
    LDUMINALH W7,W21,[X14]
    ADD  X14, X14, X5, LSR #0
    STP  X12, X10, [X14, #0]
    LDUMINLH W13,W7,[X14]
    ADD  X14, X14, X5, LSR #0
    STP  X23, X3, [X14, #0]
    STUMIN W9,[X14]
    ADD  X14, X14, X5
    STP  X20, X10, [X14, #0]
    STUMIN X7,[X14]
    ADD  X14, X14, X5, LSR #0
    STP  X21, X4, [X14, #0]
    STUMINL W10,[X14]
    ADD  X14, X14, X5
    STP  X17, X7, [X14, #0]
    STUMINL X23,[X14]
    ADD  X14, X14, X5
    STP  X17, X28, [X14, #0]
    LDUMIN W21,W12,[X14]
    ADD  X14, X14, X5
    STP  X6, X28, [X14, #0]
    LDUMIN X23,X6,[X14]
    ADD  X14, X14, X5, ASR #0
    STP  X6, X28, [X14, #0]
    LDUMINA W28,W9,[X14]
    ADD  X14, X14, X5
    STP  X17, X4, [X14, #0]
    LDUMINA X13,X12,[X14]
    ADD  X14, X14, X5, ASR #0
    STP  X9, X17, [X14, #0]
    LDUMINAL W9,W9,[X14]
    ADD  X14, X14, X5, ASR #0
    STP  X7, X8, [X14, #0]
    LDUMINAL X18,X28,[X14]
    ADD  X14, X14, X5, LSR #0
    STP  X28, X20, [X14, #0]
    LDUMINL W17,W23,[X14]
    ADD  X14, X14, X5, LSR #0
    STP  X20, X4, [X14, #0]
    LDUMINL X28,X20,[X14]
    ADD  X14, X14, X5, ASR #0
    STP  X17, X3, [X14, #0]
    SWPB W8,W13,[X14]
    ADD  X14, X14, X5, LSR #0
    STP  X2, X18, [X14, #0]
    SWPAB W10,W28,[X14]
    ADD  X14, X14, X5, ASR #0
    STP  X22, X13, [X14, #0]
    SWPALB W10,W2,[X14]
    ADD  X14, X14, X5
    STP  X8, X18, [X14, #0]
    SWPLB W21,W18,[X14]
    ADD  X14, X14, X5, LSR #0
    STP  X22, X12, [X14, #0]
    SWPH W7,W16,[X14]
    ADD  X14, X14, X5
    STP  X28, X2, [X14, #0]
    SWPAH W17,W21,[X14]
    ADD  X14, X14, X5, LSR #0
    STP  X13, X12, [X14, #0]
    SWPALH W20,W4,[X14]
    ADD  X14, X14, X5
    STP  X18, X21, [X14, #0]
    SWPLH W6,W10,[X14]
    ADD  X14, X14, X5, ASR #0
    STP  X4, X7, [X14, #0]
    SWP W8,W4,[X14]
    ADD  X14, X14, X5
    STP  X20, X8, [X14, #0]
    SWP X20,X13,[X14]
    ADD  X14, X14, X5
    STP  X6, X20, [X14, #0]
    SWPA W2,W28,[X14]
    ADD  X14, X14, X5, LSR #0
    STP  X8, X21, [X14, #0]
    SWPA X12,X17,[X14]
    ADD  X14, X14, X5
    STP  X2, X20, [X14, #0]
    SWPAL W3,W2,[X14]
    ADD  X14, X14, X5, ASR #0
    STP  X28, X21, [X14, #0]
    SWPAL X22,X3,[X14]
    ADD  X14, X14, X5, LSR #0
    STP  X13, X4, [X14, #0]
    SWPL W22,W17,[X14]
    ADD  X14, X14, X5
    STP  X10, X13, [X14, #0]
    SWPL X16,X13,[X14]
    ADD  X14, X14, X5
    MOVZ  X19, #0x5a, LSL #0
    SUB  X15, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X19, #0x5a, LSL #0
    SUB  X15, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X19, #0x5a, LSL #0
    SUB  X15, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X19, #0x5a, LSL #0
    SUB  X15, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X19, #0x5a, LSL #0
    SUB  X15, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    SUB  X15, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    SUB  X15, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    SUB  X15, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    SUB  X15, X19, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X19, #0x5a, LSL #0
    SUB  X15, X19, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    SUB  X15, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X19, #0x5a, LSL #0
    SUB  X15, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X21, #0x10, LSL #0
    MOVZ  X19, #0x280, LSL #0
    ADD  X11, X30, X19, ASR #0
    STP  X18, X22, [X11, #0]
    STUMAXB W28,[X11]
    ADD  X11, X11, X21, LSR #0
    STP  X20, X22, [X11, #0]
    STUMAXLB W23,[X11]
    ADD  X11, X11, X21
    STP  X17, X7, [X11, #0]
    LDUMAXB W6,W8,[X11]
    ADD  X11, X11, X21, ASR #0
    STP  X23, X8, [X11, #0]
    LDUMAXAB W8,W15,[X11]
    ADD  X11, X11, X21, LSR #0
    STP  X18, X17, [X11, #0]
    LDUMAXALB W14,W18,[X11]
    ADD  X11, X11, X21, ASR #0
    STP  X22, X9, [X11, #0]
    LDUMAXLB W15,W28,[X11]
    ADD  X11, X11, X21, LSR #0
    STP  X15, X7, [X11, #0]
    STUMAXH W9,[X11]
    ADD  X11, X11, X21, LSR #0
    STP  X10, X6, [X11, #0]
    STUMAXLH W17,[X11]
    ADD  X11, X11, X21, ASR #0
    STP  X10, X17, [X11, #0]
    LDUMAXH W17,W23,[X11]
    ADD  X11, X11, X21
    STP  X4, X13, [X11, #0]
    LDUMAXAH W28,W17,[X11]
    ADD  X11, X11, X21, LSR #0
    STP  X5, X13, [X11, #0]
    LDUMAXALH W20,W6,[X11]
    ADD  X11, X11, X21
    STP  X6, X22, [X11, #0]
    LDUMAXLH W22,W22,[X11]
    ADD  X11, X11, X21, ASR #0
    STP  X20, X23, [X11, #0]
    STUMAX W17,[X11]
    ADD  X11, X11, X21, LSR #0
    STP  X17, X9, [X11, #0]
    STUMAX X17,[X11]
    ADD  X11, X11, X21, ASR #0
    STP  X20, X23, [X11, #0]
    STUMAXL W18,[X11]
    ADD  X11, X11, X21, LSR #0
    STP  X8, X5, [X11, #0]
    STUMAXL X20,[X11]
    ADD  X11, X11, X21, LSR #0
    STP  X14, X6, [X11, #0]
    LDUMAX W12,W18,[X11]
    ADD  X11, X11, X21, LSR #0
    STP  X8, X13, [X11, #0]
    LDUMAX X9,X6,[X11]
    ADD  X11, X11, X21
    STP  X22, X18, [X11, #0]
    LDUMAXA W10,W28,[X11]
    ADD  X11, X11, X21, ASR #0
    STP  X2, X4, [X11, #0]
    LDUMAXA X17,X20,[X11]
    ADD  X11, X11, X21, ASR #0
    STP  X13, X20, [X11, #0]
    LDUMAXAL W9,W17,[X11]
    ADD  X11, X11, X21, ASR #0
    STP  X8, X8, [X11, #0]
    LDUMAXAL X9,X15,[X11]
    ADD  X11, X11, X21, LSR #0
    STP  X17, X2, [X11, #0]
    LDUMAXL W4,W10,[X11]
    ADD  X11, X11, X21
    STP  X23, X7, [X11, #0]
    LDUMAXL X23,X28,[X11]
    ADD  X11, X11, X21, ASR #0
    STP  X9, X17, [X11, #0]
    STUMINB W17,[X11]
    ADD  X11, X11, X21, ASR #0
    STP  X28, X4, [X11, #0]
    STUMINLB W23,[X11]
    ADD  X11, X11, X21, ASR #0
    STP  X8, X23, [X11, #0]
    LDUMINB W15,W9,[X11]
    ADD  X11, X11, X21, ASR #0
    STP  X23, X7, [X11, #0]
    LDUMINAB W23,W17,[X11]
    ADD  X11, X11, X21, LSR #0
    STP  X8, X2, [X11, #0]
    LDUMINALB W12,W23,[X11]
    ADD  X11, X11, X21, ASR #0
    STP  X6, X8, [X11, #0]
    LDUMINLB W20,W28,[X11]
    ADD  X11, X11, X21, LSR #0
    STP  X20, X5, [X11, #0]
    STUMINH W23,[X11]
    ADD  X11, X11, X21, LSR #0
    STP  X22, X22, [X11, #0]
    STUMINLH W28,[X11]
    ADD  X11, X11, X21
    STP  X4, X22, [X11, #0]
    LDUMINH W18,W20,[X11]
    ADD  X11, X11, X21, LSR #0
    STP  X22, X10, [X11, #0]
    LDUMINAH W5,W8,[X11]
    ADD  X11, X11, X21
    STP  X17, X10, [X11, #0]
    LDUMINALH W17,W6,[X11]
    ADD  X11, X11, X21, ASR #0
    STP  X10, X18, [X11, #0]
    LDUMINLH W10,W15,[X11]
    ADD  X11, X11, X21, ASR #0
    STP  X4, X6, [X11, #0]
    STUMIN W20,[X11]
    ADD  X11, X11, X21
    STP  X28, X4, [X11, #0]
    STUMIN X7,[X11]
    ADD  X11, X11, X21
    STP  X7, X20, [X11, #0]
    STUMINL W10,[X11]
    ADD  X11, X11, X21
    STP  X17, X15, [X11, #0]
    STUMINL X4,[X11]
    ADD  X11, X11, X21, LSR #0
    STP  X2, X4, [X11, #0]
    LDUMIN W15,W22,[X11]
    ADD  X11, X11, X21, LSR #0
    STP  X14, X18, [X11, #0]
    LDUMIN X6,X13,[X11]
    ADD  X11, X11, X21, ASR #0
    STP  X6, X15, [X11, #0]
    LDUMINA W12,W12,[X11]
    ADD  X11, X11, X21, ASR #0
    STP  X22, X17, [X11, #0]
    LDUMINA X22,X7,[X11]
    ADD  X11, X11, X21
    STP  X8, X17, [X11, #0]
    LDUMINAL W17,W15,[X11]
    ADD  X11, X11, X21, LSR #0
    STP  X10, X15, [X11, #0]
    LDUMINAL X18,X6,[X11]
    ADD  X11, X11, X21, LSR #0
    STP  X8, X9, [X11, #0]
    LDUMINL W12,W10,[X11]
    ADD  X11, X11, X21, ASR #0
    STP  X2, X12, [X11, #0]
    LDUMINL X9,X17,[X11]
    ADD  X11, X11, X21, LSR #0
    STP  X17, X28, [X11, #0]
    SWPB W17,W28,[X11]
    ADD  X11, X11, X21
    STP  X12, X28, [X11, #0]
    SWPAB W20,W2,[X11]
    ADD  X11, X11, X21, ASR #0
    STP  X23, X7, [X11, #0]
    SWPALB W22,W9,[X11]
    ADD  X11, X11, X21, ASR #0
    STP  X22, X13, [X11, #0]
    SWPLB W13,W12,[X11]
    ADD  X11, X11, X21, LSR #0
    STP  X20, X8, [X11, #0]
    SWPH W10,W23,[X11]
    ADD  X11, X11, X21
    STP  X7, X9, [X11, #0]
    SWPAH W18,W22,[X11]
    ADD  X11, X11, X21, LSR #0
    STP  X5, X17, [X11, #0]
    SWPALH W4,W18,[X11]
    ADD  X11, X11, X21
    STP  X28, X4, [X11, #0]
    SWPLH W18,W7,[X11]
    ADD  X11, X11, X21, LSR #0
    STP  X20, X9, [X11, #0]
    SWP W22,W28,[X11]
    ADD  X11, X11, X21, LSR #0
    STP  X2, X6, [X11, #0]
    SWP X12,X9,[X11]
    ADD  X11, X11, X21
    STP  X23, X23, [X11, #0]
    SWPA W4,W17,[X11]
    ADD  X11, X11, X21, LSR #0
    STP  X4, X4, [X11, #0]
    SWPA X9,X23,[X11]
    ADD  X11, X11, X21, LSR #0
    STP  X7, X9, [X11, #0]
    SWPAL W6,W18,[X11]
    ADD  X11, X11, X21
    STP  X13, X12, [X11, #0]
    SWPAL X2,X12,[X11]
    ADD  X11, X11, X21
    STP  X7, X9, [X11, #0]
    SWPL W4,W7,[X11]
    ADD  X11, X11, X21, ASR #0
    STP  X9, X6, [X11, #0]
    SWPL X5,X6,[X11]
    ADD  X11, X11, X21, ASR #0
    MOVZ  X3, #0xa5, LSL #0
    SUB  X16, X3, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X3, #0xa5, LSL #0
    SUB  X16, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X3, #0xa5, LSL #0
    SUB  X16, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X3, #0xa5, LSL #0
    SUB  X16, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    SUB  X16, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X3, #0xa5, LSL #0
    SUB  X16, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    SUB  X16, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    SUB  X16, X3, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    SUB  X16, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTGeneralLoadStoreP04_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X19, #0x10, LSL #0
    MOVZ  X8, #0x500, LSL #0
    ADD  X21, X30, X8, ASR #0
    STP  X22, X16, [X21, #0]
    STUMAXB W23,[X21]
    ADD  X21, X21, X19, LSR #0
    STP  X16, X28, [X21, #0]
    STUMAXLB W5,[X21]
    ADD  X21, X21, X19
    STP  X3, X18, [X21, #0]
    LDUMAXB W7,W17,[X21]
    ADD  X21, X21, X19
    STP  X7, X9, [X21, #0]
    LDUMAXAB W17,W3,[X21]
    ADD  X21, X21, X19, LSR #0
    STP  X18, X18, [X21, #0]
    LDUMAXALB W23,W9,[X21]
    ADD  X21, X21, X19, LSR #0
    STP  X4, X28, [X21, #0]
    LDUMAXLB W22,W6,[X21]
    ADD  X21, X21, X19, ASR #0
    STP  X23, X4, [X21, #0]
    STUMAXH W18,[X21]
    ADD  X21, X21, X19, LSR #0
    STP  X12, X6, [X21, #0]
    STUMAXLH W23,[X21]
    ADD  X21, X21, X19
    STP  X7, X16, [X21, #0]
    LDUMAXH W18,W2,[X21]
    ADD  X21, X21, X19, ASR #0
    STP  X2, X3, [X21, #0]
    LDUMAXAH W2,W23,[X21]
    ADD  X21, X21, X19, ASR #0
    STP  X11, X18, [X21, #0]
    LDUMAXALH W18,W9,[X21]
    ADD  X21, X21, X19
    STP  X17, X3, [X21, #0]
    LDUMAXLH W2,W12,[X21]
    ADD  X21, X21, X19, ASR #0
    STP  X23, X11, [X21, #0]
    STUMAX W7,[X21]
    ADD  X21, X21, X19
    STP  X17, X6, [X21, #0]
    STUMAX X17,[X21]
    ADD  X21, X21, X19
    STP  X23, X2, [X21, #0]
    STUMAXL W28,[X21]
    ADD  X21, X21, X19, LSR #0
    STP  X5, X18, [X21, #0]
    STUMAXL X22,[X21]
    ADD  X21, X21, X19
    STP  X18, X17, [X21, #0]
    LDUMAX W23,W2,[X21]
    ADD  X21, X21, X19
    STP  X15, X3, [X21, #0]
    LDUMAX X4,X6,[X21]
    ADD  X21, X21, X19
    STP  X13, X20, [X21, #0]
    LDUMAXA W28,W13,[X21]
    ADD  X21, X21, X19, LSR #0
    STP  X23, X22, [X21, #0]
    LDUMAXA X16,X18,[X21]
    ADD  X21, X21, X19
    STP  X3, X4, [X21, #0]
    LDUMAXAL W18,W23,[X21]
    ADD  X21, X21, X19
    STP  X18, X9, [X21, #0]
    LDUMAXAL X20,X15,[X21]
    ADD  X21, X21, X19, LSR #0
    STP  X15, X7, [X21, #0]
    LDUMAXL W16,W3,[X21]
    ADD  X21, X21, X19, ASR #0
    STP  X9, X3, [X21, #0]
    LDUMAXL X7,X16,[X21]
    ADD  X21, X21, X19
    STP  X5, X5, [X21, #0]
    STUMINB W28,[X21]
    ADD  X21, X21, X19
    STP  X2, X23, [X21, #0]
    STUMINLB W3,[X21]
    ADD  X21, X21, X19, LSR #0
    STP  X17, X23, [X21, #0]
    LDUMINB W22,W13,[X21]
    ADD  X21, X21, X19, LSR #0
    STP  X17, X23, [X21, #0]
    LDUMINAB W2,W7,[X21]
    ADD  X21, X21, X19
    STP  X17, X3, [X21, #0]
    LDUMINALB W6,W4,[X21]
    ADD  X21, X21, X19
    STP  X17, X15, [X21, #0]
    LDUMINLB W12,W3,[X21]
    ADD  X21, X21, X19, ASR #0
    STP  X3, X23, [X21, #0]
    STUMINH W23,[X21]
    ADD  X21, X21, X19, ASR #0
    STP  X16, X20, [X21, #0]
    STUMINLH W15,[X21]
    ADD  X21, X21, X19, LSR #0
    STP  X28, X16, [X21, #0]
    LDUMINH W15,W17,[X21]
    ADD  X21, X21, X19
    STP  X15, X28, [X21, #0]
    LDUMINAH W22,W12,[X21]
    ADD  X21, X21, X19
    STP  X13, X28, [X21, #0]
    LDUMINALH W6,W16,[X21]
    ADD  X21, X21, X19, LSR #0
    STP  X22, X12, [X21, #0]
    LDUMINLH W22,W20,[X21]
    ADD  X21, X21, X19, LSR #0
    STP  X6, X6, [X21, #0]
    STUMIN W13,[X21]
    ADD  X21, X21, X19, ASR #0
    STP  X23, X5, [X21, #0]
    STUMIN X13,[X21]
    ADD  X21, X21, X19, LSR #0
    STP  X9, X28, [X21, #0]
    STUMINL W18,[X21]
    ADD  X21, X21, X19, LSR #0
    STP  X5, X22, [X21, #0]
    STUMINL X11,[X21]
    ADD  X21, X21, X19, ASR #0
    STP  X20, X15, [X21, #0]
    LDUMIN W5,W23,[X21]
    ADD  X21, X21, X19, ASR #0
    STP  X2, X11, [X21, #0]
    LDUMIN X28,X12,[X21]
    ADD  X21, X21, X19, LSR #0
    STP  X6, X5, [X21, #0]
    LDUMINA W20,W18,[X21]
    ADD  X21, X21, X19, LSR #0
    STP  X17, X7, [X21, #0]
    LDUMINA X3,X22,[X21]
    ADD  X21, X21, X19, LSR #0
    STP  X28, X11, [X21, #0]
    LDUMINAL W28,W17,[X21]
    ADD  X21, X21, X19, ASR #0
    STP  X2, X28, [X21, #0]
    LDUMINAL X23,X28,[X21]
    ADD  X21, X21, X19, LSR #0
    STP  X9, X7, [X21, #0]
    LDUMINL W2,W15,[X21]
    ADD  X21, X21, X19
    STP  X20, X9, [X21, #0]
    LDUMINL X2,X11,[X21]
    ADD  X21, X21, X19, ASR #0
    STP  X15, X17, [X21, #0]
    SWPB W18,W7,[X21]
    ADD  X21, X21, X19, ASR #0
    STP  X12, X22, [X21, #0]
    SWPAB W12,W17,[X21]
    ADD  X21, X21, X19, LSR #0
    STP  X20, X23, [X21, #0]
    SWPALB W11,W28,[X21]
    ADD  X21, X21, X19
    STP  X16, X28, [X21, #0]
    SWPLB W22,W16,[X21]
    ADD  X21, X21, X19, ASR #0
    STP  X23, X12, [X21, #0]
    SWPH W6,W11,[X21]
    ADD  X21, X21, X19, LSR #0
    STP  X16, X6, [X21, #0]
    SWPAH W18,W22,[X21]
    ADD  X21, X21, X19, LSR #0
    STP  X15, X28, [X21, #0]
    SWPALH W28,W3,[X21]
    ADD  X21, X21, X19, ASR #0
    STP  X13, X16, [X21, #0]
    SWPLH W12,W6,[X21]
    ADD  X21, X21, X19, ASR #0
    STP  X4, X12, [X21, #0]
    SWP W9,W20,[X21]
    ADD  X21, X21, X19
    STP  X28, X3, [X21, #0]
    SWP X11,X3,[X21]
    ADD  X21, X21, X19, LSR #0
    STP  X20, X23, [X21, #0]
    SWPA W18,W9,[X21]
    ADD  X21, X21, X19, LSR #0
    STP  X18, X15, [X21, #0]
    SWPA X22,X15,[X21]
    ADD  X21, X21, X19
    STP  X5, X28, [X21, #0]
    SWPAL W17,W28,[X21]
    ADD  X21, X21, X19
    STP  X17, X23, [X21, #0]
    SWPAL X17,X15,[X21]
    ADD  X21, X21, X19, ASR #0
    STP  X22, X28, [X21, #0]
    SWPL W13,W22,[X21]
    ADD  X21, X21, X19, ASR #0
    STP  X23, X7, [X21, #0]
    SWPL X3,X28,[X21]
    ADD  X21, X21, X19, ASR #0
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    SUB  X10, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X14, #0x5a, LSL #0
    SUB  X10, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X14, #0x5a, LSL #0
    SUB  X10, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X14, #0x5a, LSL #0
    SUB  X10, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X14, #0x5a, LSL #0
    SUB  X10, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X14, #0x5a, LSL #0
    SUB  X10, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    SUB  X10, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    SUB  X10, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X14, #0x5a, LSL #0
    SUB  X10, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X14, #0x5a, LSL #0
    SUB  X10, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X14, #0x5a, LSL #0
    SUB  X10, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X14, #0x5a, LSL #0
    SUB  X10, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    SUB  X10, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X14, #0x5a, LSL #0
    SUB  X10, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X14, #0x5a, LSL #0
    SUB  X10, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    SUB  X10, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    SUB  X10, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTGeneralLoadStoreP04_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X4, #0x10, LSL #0
    MOVZ  X10, #0x780, LSL #0
    ADD  X22, X30, X10, ASR #0
    STP  X15, X28, [X22, #0]
    STUMAXB W2,[X22]
    ADD  X22, X22, X4
    STP  X23, X18, [X22, #0]
    STUMAXLB W14,[X22]
    ADD  X22, X22, X4, ASR #0
    STP  X13, X28, [X22, #0]
    LDUMAXB W2,W9,[X22]
    ADD  X22, X22, X4, ASR #0
    STP  X9, X20, [X22, #0]
    LDUMAXAB W11,W28,[X22]
    ADD  X22, X22, X4, ASR #0
    STP  X15, X2, [X22, #0]
    LDUMAXALB W28,W11,[X22]
    ADD  X22, X22, X4
    STP  X13, X14, [X22, #0]
    LDUMAXLB W18,W23,[X22]
    ADD  X22, X22, X4, LSR #0
    STP  X15, X13, [X22, #0]
    STUMAXH W3,[X22]
    ADD  X22, X22, X4, LSR #0
    STP  X3, X21, [X22, #0]
    STUMAXLH W13,[X22]
    ADD  X22, X22, X4, ASR #0
    STP  X15, X17, [X22, #0]
    LDUMAXH W8,W17,[X22]
    ADD  X22, X22, X4, LSR #0
    STP  X13, X11, [X22, #0]
    LDUMAXAH W13,W3,[X22]
    ADD  X22, X22, X4, ASR #0
    STP  X17, X23, [X22, #0]
    LDUMAXALH W13,W14,[X22]
    ADD  X22, X22, X4, ASR #0
    STP  X17, X8, [X22, #0]
    LDUMAXLH W28,W13,[X22]
    ADD  X22, X22, X4, ASR #0
    STP  X11, X28, [X22, #0]
    STUMAX W6,[X22]
    ADD  X22, X22, X4, LSR #0
    STP  X28, X3, [X22, #0]
    STUMAX X7,[X22]
    ADD  X22, X22, X4
    STP  X20, X11, [X22, #0]
    STUMAXL W12,[X22]
    ADD  X22, X22, X4, ASR #0
    STP  X18, X11, [X22, #0]
    STUMAXL X8,[X22]
    ADD  X22, X22, X4
    STP  X14, X3, [X22, #0]
    LDUMAX W16,W14,[X22]
    ADD  X22, X22, X4, ASR #0
    STP  X11, X6, [X22, #0]
    LDUMAX X8,X17,[X22]
    ADD  X22, X22, X4, ASR #0
    STP  X8, X15, [X22, #0]
    LDUMAXA W18,W6,[X22]
    ADD  X22, X22, X4
    STP  X15, X18, [X22, #0]
    LDUMAXA X15,X18,[X22]
    ADD  X22, X22, X4
    STP  X12, X15, [X22, #0]
    LDUMAXAL W13,W11,[X22]
    ADD  X22, X22, X4, LSR #0
    STP  X8, X8, [X22, #0]
    LDUMAXAL X28,X13,[X22]
    ADD  X22, X22, X4, ASR #0
    STP  X15, X9, [X22, #0]
    LDUMAXL W21,W16,[X22]
    ADD  X22, X22, X4
    STP  X12, X28, [X22, #0]
    LDUMAXL X8,X16,[X22]
    ADD  X22, X22, X4, LSR #0
    STP  X7, X15, [X22, #0]
    STUMINB W13,[X22]
    ADD  X22, X22, X4
    STP  X11, X6, [X22, #0]
    STUMINLB W18,[X22]
    ADD  X22, X22, X4
    STP  X16, X6, [X22, #0]
    LDUMINB W18,W7,[X22]
    ADD  X22, X22, X4, ASR #0
    STP  X13, X23, [X22, #0]
    LDUMINAB W9,W13,[X22]
    ADD  X22, X22, X4
    STP  X13, X8, [X22, #0]
    LDUMINALB W21,W28,[X22]
    ADD  X22, X22, X4, ASR #0
    STP  X3, X13, [X22, #0]
    LDUMINLB W6,W12,[X22]
    ADD  X22, X22, X4, ASR #0
    STP  X23, X16, [X22, #0]
    STUMINH W14,[X22]
    ADD  X22, X22, X4
    STP  X6, X15, [X22, #0]
    STUMINLH W6,[X22]
    ADD  X22, X22, X4
    STP  X20, X17, [X22, #0]
    LDUMINH W15,W16,[X22]
    ADD  X22, X22, X4
    STP  X21, X20, [X22, #0]
    LDUMINAH W17,W14,[X22]
    ADD  X22, X22, X4, ASR #0
    STP  X21, X20, [X22, #0]
    LDUMINALH W16,W12,[X22]
    ADD  X22, X22, X4, LSR #0
    STP  X28, X6, [X22, #0]
    LDUMINLH W7,W9,[X22]
    ADD  X22, X22, X4
    STP  X17, X3, [X22, #0]
    STUMIN W14,[X22]
    ADD  X22, X22, X4, ASR #0
    STP  X11, X16, [X22, #0]
    STUMIN X14,[X22]
    ADD  X22, X22, X4, ASR #0
    STP  X28, X15, [X22, #0]
    STUMINL W18,[X22]
    ADD  X22, X22, X4
    STP  X17, X14, [X22, #0]
    STUMINL X13,[X22]
    ADD  X22, X22, X4, LSR #0
    STP  X14, X23, [X22, #0]
    LDUMIN W16,W9,[X22]
    ADD  X22, X22, X4
    STP  X12, X20, [X22, #0]
    LDUMIN X18,X13,[X22]
    ADD  X22, X22, X4
    STP  X3, X17, [X22, #0]
    LDUMINA W7,W17,[X22]
    ADD  X22, X22, X4
    STP  X23, X7, [X22, #0]
    LDUMINA X18,X14,[X22]
    ADD  X22, X22, X4, LSR #0
    STP  X28, X20, [X22, #0]
    LDUMINAL W16,W12,[X22]
    ADD  X22, X22, X4, ASR #0
    STP  X7, X9, [X22, #0]
    LDUMINAL X14,X16,[X22]
    ADD  X22, X22, X4, ASR #0
    STP  X18, X11, [X22, #0]
    LDUMINL W3,W20,[X22]
    ADD  X22, X22, X4, LSR #0
    STP  X23, X9, [X22, #0]
    LDUMINL X3,X28,[X22]
    ADD  X22, X22, X4, LSR #0
    STP  X3, X28, [X22, #0]
    SWPB W12,W23,[X22]
    ADD  X22, X22, X4
    STP  X23, X14, [X22, #0]
    SWPAB W15,W14,[X22]
    ADD  X22, X22, X4
    STP  X28, X17, [X22, #0]
    SWPALB W14,W11,[X22]
    ADD  X22, X22, X4, LSR #0
    STP  X15, X6, [X22, #0]
    SWPLB W6,W11,[X22]
    ADD  X22, X22, X4
    STP  X2, X11, [X22, #0]
    SWPH W15,W14,[X22]
    ADD  X22, X22, X4, ASR #0
    STP  X8, X16, [X22, #0]
    SWPAH W28,W6,[X22]
    ADD  X22, X22, X4, LSR #0
    STP  X15, X11, [X22, #0]
    SWPALH W8,W11,[X22]
    ADD  X22, X22, X4, LSR #0
    STP  X28, X9, [X22, #0]
    SWPLH W13,W8,[X22]
    ADD  X22, X22, X4, LSR #0
    STP  X2, X23, [X22, #0]
    SWP W17,W2,[X22]
    ADD  X22, X22, X4, ASR #0
    STP  X7, X7, [X22, #0]
    SWP X6,X9,[X22]
    ADD  X22, X22, X4
    STP  X18, X3, [X22, #0]
    SWPA W18,W18,[X22]
    ADD  X22, X22, X4, ASR #0
    STP  X20, X21, [X22, #0]
    SWPA X2,X3,[X22]
    ADD  X22, X22, X4
    STP  X3, X20, [X22, #0]
    SWPAL W12,W17,[X22]
    ADD  X22, X22, X4, LSR #0
    STP  X16, X11, [X22, #0]
    SWPAL X15,X23,[X22]
    ADD  X22, X22, X4
    STP  X13, X2, [X22, #0]
    SWPL W21,W6,[X22]
    ADD  X22, X22, X4
    STP  X7, X17, [X22, #0]
    SWPL X21,X11,[X22]
    ADD  X22, X22, X4, LSR #0
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    SUB  X19, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X19, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    SUB  X19, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5, LSL #0
    SUB  X19, X5, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5, LSL #0
    SUB  X19, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5, LSL #0
    SUB  X19, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5, LSL #0
    SUB  X19, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5, LSL #0
    SUB  X19, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    SUB  X19, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    SUB  X19, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5, LSL #0
    SUB  X19, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X19, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X19, X5, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X19, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X19, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5, LSL #0
    SUB  X19, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5, LSL #0
    SUB  X19, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x10, LSL #0
    MOVZ  X5, #0xa00, LSL #0
    ADD  X6, X30, X5, ASR #0
    STP  X22, X28, [X6, #0]
    STUMAXB W19,[X6]
    ADD  X6, X6, X11, LSR #0
    STP  X4, X10, [X6, #0]
    STUMAXLB W28,[X6]
    ADD  X6, X6, X11
    STP  X7, X23, [X6, #0]
    LDUMAXB W12,W18,[X6]
    ADD  X6, X6, X11, ASR #0
    STP  X18, X14, [X6, #0]
    LDUMAXAB W17,W7,[X6]
    ADD  X6, X6, X11, ASR #0
    STP  X22, X14, [X6, #0]
    LDUMAXALB W7,W22,[X6]
    ADD  X6, X6, X11, LSR #0
    STP  X17, X4, [X6, #0]
    LDUMAXLB W28,W19,[X6]
    ADD  X6, X6, X11, LSR #0
    STP  X2, X22, [X6, #0]
    STUMAXH W13,[X6]
    ADD  X6, X6, X11
    STP  X9, X2, [X6, #0]
    STUMAXLH W23,[X6]
    ADD  X6, X6, X11
    STP  X4, X12, [X6, #0]
    LDUMAXH W12,W17,[X6]
    ADD  X6, X6, X11, LSR #0
    STP  X8, X4, [X6, #0]
    LDUMAXAH W17,W28,[X6]
    ADD  X6, X6, X11, ASR #0
    STP  X2, X19, [X6, #0]
    LDUMAXALH W8,W12,[X6]
    ADD  X6, X6, X11
    STP  X19, X22, [X6, #0]
    LDUMAXLH W10,W4,[X6]
    ADD  X6, X6, X11, ASR #0
    STP  X14, X16, [X6, #0]
    STUMAX W22,[X6]
    ADD  X6, X6, X11, ASR #0
    STP  X8, X14, [X6, #0]
    STUMAX X3,[X6]
    ADD  X6, X6, X11, ASR #0
    STP  X14, X14, [X6, #0]
    STUMAXL W19,[X6]
    ADD  X6, X6, X11, LSR #0
    STP  X8, X15, [X6, #0]
    STUMAXL X17,[X6]
    ADD  X6, X6, X11, ASR #0
    STP  X9, X9, [X6, #0]
    LDUMAX W8,W2,[X6]
    ADD  X6, X6, X11, LSR #0
    STP  X3, X18, [X6, #0]
    LDUMAX X8,X19,[X6]
    ADD  X6, X6, X11
    STP  X2, X23, [X6, #0]
    LDUMAXA W28,W9,[X6]
    ADD  X6, X6, X11
    STP  X2, X16, [X6, #0]
    LDUMAXA X23,X28,[X6]
    ADD  X6, X6, X11, LSR #0
    STP  X7, X13, [X6, #0]
    LDUMAXAL W12,W23,[X6]
    ADD  X6, X6, X11, ASR #0
    STP  X15, X9, [X6, #0]
    LDUMAXAL X18,X12,[X6]
    ADD  X6, X6, X11, ASR #0
    STP  X7, X22, [X6, #0]
    LDUMAXL W10,W15,[X6]
    ADD  X6, X6, X11
    STP  X7, X13, [X6, #0]
    LDUMAXL X17,X9,[X6]
    ADD  X6, X6, X11, LSR #0
    STP  X3, X28, [X6, #0]
    STUMINB W22,[X6]
    ADD  X6, X6, X11
    STP  X12, X28, [X6, #0]
    STUMINLB W9,[X6]
    ADD  X6, X6, X11, LSR #0
    STP  X8, X2, [X6, #0]
    LDUMINB W19,W8,[X6]
    ADD  X6, X6, X11, LSR #0
    STP  X2, X22, [X6, #0]
    LDUMINAB W2,W4,[X6]
    ADD  X6, X6, X11, LSR #0
    STP  X22, X14, [X6, #0]
    LDUMINALB W28,W13,[X6]
    ADD  X6, X6, X11, LSR #0
    STP  X9, X28, [X6, #0]
    LDUMINLB W18,W18,[X6]
    ADD  X6, X6, X11
    STP  X9, X28, [X6, #0]
    STUMINH W2,[X6]
    ADD  X6, X6, X11, LSR #0
    STP  X28, X8, [X6, #0]
    STUMINLH W18,[X6]
    ADD  X6, X6, X11, LSR #0
    STP  X14, X17, [X6, #0]
    LDUMINH W16,W22,[X6]
    ADD  X6, X6, X11, LSR #0
    STP  X8, X13, [X6, #0]
    LDUMINAH W22,W28,[X6]
    ADD  X6, X6, X11, ASR #0
    STP  X7, X8, [X6, #0]
    LDUMINALH W4,W12,[X6]
    ADD  X6, X6, X11, ASR #0
    STP  X18, X7, [X6, #0]
    LDUMINLH W15,W4,[X6]
    ADD  X6, X6, X11, ASR #0
    STP  X28, X15, [X6, #0]
    STUMIN W9,[X6]
    ADD  X6, X6, X11
    STP  X16, X19, [X6, #0]
    STUMIN X14,[X6]
    ADD  X6, X6, X11, LSR #0
    STP  X2, X18, [X6, #0]
    STUMINL W28,[X6]
    ADD  X6, X6, X11, LSR #0
    STP  X16, X14, [X6, #0]
    STUMINL X7,[X6]
    ADD  X6, X6, X11, LSR #0
    STP  X2, X3, [X6, #0]
    LDUMIN W15,W15,[X6]
    ADD  X6, X6, X11
    STP  X22, X28, [X6, #0]
    LDUMIN X28,X15,[X6]
    ADD  X6, X6, X11, LSR #0
    STP  X19, X10, [X6, #0]
    LDUMINA W2,W2,[X6]
    ADD  X6, X6, X11
    STP  X16, X12, [X6, #0]
    LDUMINA X15,X22,[X6]
    ADD  X6, X6, X11, LSR #0
    STP  X23, X16, [X6, #0]
    LDUMINAL W4,W14,[X6]
    ADD  X6, X6, X11, ASR #0
    STP  X18, X9, [X6, #0]
    LDUMINAL X16,X28,[X6]
    ADD  X6, X6, X11, LSR #0
    STP  X8, X3, [X6, #0]
    LDUMINL W3,W16,[X6]
    ADD  X6, X6, X11, ASR #0
    STP  X18, X7, [X6, #0]
    LDUMINL X10,X7,[X6]
    ADD  X6, X6, X11
    STP  X15, X18, [X6, #0]
    SWPB W23,W28,[X6]
    ADD  X6, X6, X11, LSR #0
    STP  X13, X4, [X6, #0]
    SWPAB W3,W12,[X6]
    ADD  X6, X6, X11, LSR #0
    STP  X23, X17, [X6, #0]
    SWPALB W14,W3,[X6]
    ADD  X6, X6, X11, ASR #0
    STP  X4, X28, [X6, #0]
    SWPLB W15,W8,[X6]
    ADD  X6, X6, X11
    STP  X14, X13, [X6, #0]
    SWPH W13,W9,[X6]
    ADD  X6, X6, X11, LSR #0
    STP  X12, X9, [X6, #0]
    SWPAH W16,W15,[X6]
    ADD  X6, X6, X11
    STP  X8, X15, [X6, #0]
    SWPALH W22,W4,[X6]
    ADD  X6, X6, X11, LSR #0
    STP  X3, X4, [X6, #0]
    SWPLH W17,W3,[X6]
    ADD  X6, X6, X11, ASR #0
    STP  X23, X10, [X6, #0]
    SWP W18,W9,[X6]
    ADD  X6, X6, X11
    STP  X19, X15, [X6, #0]
    SWP X7,X7,[X6]
    ADD  X6, X6, X11, LSR #0
    STP  X18, X23, [X6, #0]
    SWPA W22,W23,[X6]
    ADD  X6, X6, X11, ASR #0
    STP  X10, X16, [X6, #0]
    SWPA X23,X4,[X6]
    ADD  X6, X6, X11
    STP  X17, X28, [X6, #0]
    SWPAL W16,W8,[X6]
    ADD  X6, X6, X11, ASR #0
    STP  X23, X12, [X6, #0]
    SWPAL X9,X23,[X6]
    ADD  X6, X6, X11
    STP  X7, X4, [X6, #0]
    SWPL W12,W28,[X6]
    ADD  X6, X6, X11
    STP  X8, X16, [X6, #0]
    SWPL X15,X4,[X6]
    ADD  X6, X6, X11, ASR #0
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    SUB  X21, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X21, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    SUB  X21, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    SUB  X21, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X21, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X21, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X21, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X21, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X21, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X21, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    SUB  X21, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X21, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a, LSL #0
    SUB  X21, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    SUB  X21, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X28, #0x10, LSL #0
    MOVZ  X10, #0xc80, LSL #0
    ADD  X2, X30, X10, ASR #0
    STP  X3, X21, [X2, #0]
    STUMAXB W4,[X2]
    ADD  X2, X2, X28, ASR #0
    STP  X21, X5, [X2, #0]
    STUMAXLB W3,[X2]
    ADD  X2, X2, X28, ASR #0
    STP  X22, X23, [X2, #0]
    LDUMAXB W12,W9,[X2]
    ADD  X2, X2, X28, LSR #0
    STP  X16, X3, [X2, #0]
    LDUMAXAB W14,W6,[X2]
    ADD  X2, X2, X28
    STP  X8, X4, [X2, #0]
    LDUMAXALB W18,W13,[X2]
    ADD  X2, X2, X28, ASR #0
    STP  X20, X3, [X2, #0]
    LDUMAXLB W13,W18,[X2]
    ADD  X2, X2, X28, LSR #0
    STP  X5, X9, [X2, #0]
    STUMAXH W23,[X2]
    ADD  X2, X2, X28
    STP  X8, X4, [X2, #0]
    STUMAXLH W3,[X2]
    ADD  X2, X2, X28, LSR #0
    STP  X12, X6, [X2, #0]
    LDUMAXH W17,W8,[X2]
    ADD  X2, X2, X28, LSR #0
    STP  X13, X7, [X2, #0]
    LDUMAXAH W21,W4,[X2]
    ADD  X2, X2, X28, ASR #0
    STP  X20, X11, [X2, #0]
    LDUMAXALH W20,W16,[X2]
    ADD  X2, X2, X28, ASR #0
    STP  X5, X16, [X2, #0]
    LDUMAXLH W13,W3,[X2]
    ADD  X2, X2, X28, LSR #0
    STP  X13, X3, [X2, #0]
    STUMAX W9,[X2]
    ADD  X2, X2, X28, ASR #0
    STP  X11, X4, [X2, #0]
    STUMAX X3,[X2]
    ADD  X2, X2, X28, LSR #0
    STP  X12, X11, [X2, #0]
    STUMAXL W17,[X2]
    ADD  X2, X2, X28, LSR #0
    STP  X21, X16, [X2, #0]
    STUMAXL X6,[X2]
    ADD  X2, X2, X28, ASR #0
    STP  X17, X17, [X2, #0]
    LDUMAX W12,W20,[X2]
    ADD  X2, X2, X28
    STP  X3, X6, [X2, #0]
    LDUMAX X5,X14,[X2]
    ADD  X2, X2, X28
    STP  X7, X21, [X2, #0]
    LDUMAXA W5,W17,[X2]
    ADD  X2, X2, X28
    STP  X14, X13, [X2, #0]
    LDUMAXA X23,X13,[X2]
    ADD  X2, X2, X28
    STP  X5, X6, [X2, #0]
    LDUMAXAL W8,W23,[X2]
    ADD  X2, X2, X28, ASR #0
    STP  X3, X14, [X2, #0]
    LDUMAXAL X16,X14,[X2]
    ADD  X2, X2, X28
    STP  X9, X16, [X2, #0]
    LDUMAXL W13,W9,[X2]
    ADD  X2, X2, X28
    STP  X18, X13, [X2, #0]
    LDUMAXL X6,X16,[X2]
    ADD  X2, X2, X28, ASR #0
    STP  X21, X21, [X2, #0]
    STUMINB W18,[X2]
    ADD  X2, X2, X28
    STP  X17, X6, [X2, #0]
    STUMINLB W14,[X2]
    ADD  X2, X2, X28
    STP  X18, X16, [X2, #0]
    LDUMINB W8,W22,[X2]
    ADD  X2, X2, X28, LSR #0
    STP  X3, X23, [X2, #0]
    LDUMINAB W23,W7,[X2]
    ADD  X2, X2, X28, ASR #0
    STP  X22, X6, [X2, #0]
    LDUMINALB W18,W8,[X2]
    ADD  X2, X2, X28
    STP  X23, X22, [X2, #0]
    LDUMINLB W23,W13,[X2]
    ADD  X2, X2, X28
    STP  X22, X14, [X2, #0]
    STUMINH W16,[X2]
    ADD  X2, X2, X28, LSR #0
    STP  X22, X23, [X2, #0]
    STUMINLH W21,[X2]
    ADD  X2, X2, X28
    STP  X21, X4, [X2, #0]
    LDUMINH W21,W23,[X2]
    ADD  X2, X2, X28
    STP  X7, X11, [X2, #0]
    LDUMINAH W16,W14,[X2]
    ADD  X2, X2, X28
    STP  X11, X14, [X2, #0]
    LDUMINALH W3,W21,[X2]
    ADD  X2, X2, X28, LSR #0
    STP  X12, X23, [X2, #0]
    LDUMINLH W22,W6,[X2]
    ADD  X2, X2, X28, ASR #0
    STP  X6, X23, [X2, #0]
    STUMIN W21,[X2]
    ADD  X2, X2, X28
    STP  X23, X9, [X2, #0]
    STUMIN X6,[X2]
    ADD  X2, X2, X28, LSR #0
    STP  X5, X14, [X2, #0]
    STUMINL W7,[X2]
    ADD  X2, X2, X28
    STP  X20, X13, [X2, #0]
    STUMINL X18,[X2]
    ADD  X2, X2, X28, LSR #0
    STP  X5, X18, [X2, #0]
    LDUMIN W14,W18,[X2]
    ADD  X2, X2, X28, LSR #0
    STP  X4, X9, [X2, #0]
    LDUMIN X23,X4,[X2]
    ADD  X2, X2, X28
    STP  X22, X8, [X2, #0]
    LDUMINA W8,W6,[X2]
    ADD  X2, X2, X28, ASR #0
    STP  X23, X11, [X2, #0]
    LDUMINA X17,X11,[X2]
    ADD  X2, X2, X28
    STP  X11, X7, [X2, #0]
    LDUMINAL W9,W11,[X2]
    ADD  X2, X2, X28, LSR #0
    STP  X5, X16, [X2, #0]
    LDUMINAL X8,X13,[X2]
    ADD  X2, X2, X28, LSR #0
    STP  X21, X16, [X2, #0]
    LDUMINL W18,W14,[X2]
    ADD  X2, X2, X28, ASR #0
    STP  X20, X23, [X2, #0]
    LDUMINL X5,X22,[X2]
    ADD  X2, X2, X28
    STP  X5, X23, [X2, #0]
    SWPB W22,W21,[X2]
    ADD  X2, X2, X28
    STP  X21, X6, [X2, #0]
    SWPAB W16,W6,[X2]
    ADD  X2, X2, X28
    STP  X6, X20, [X2, #0]
    SWPALB W8,W7,[X2]
    ADD  X2, X2, X28, ASR #0
    STP  X4, X4, [X2, #0]
    SWPLB W5,W18,[X2]
    ADD  X2, X2, X28
    STP  X9, X16, [X2, #0]
    SWPH W5,W23,[X2]
    ADD  X2, X2, X28
    STP  X18, X18, [X2, #0]
    SWPAH W13,W3,[X2]
    ADD  X2, X2, X28, ASR #0
    STP  X21, X23, [X2, #0]
    SWPALH W3,W6,[X2]
    ADD  X2, X2, X28, ASR #0
    STP  X18, X8, [X2, #0]
    SWPLH W20,W21,[X2]
    ADD  X2, X2, X28
    STP  X23, X22, [X2, #0]
    SWP W5,W17,[X2]
    ADD  X2, X2, X28
    STP  X7, X4, [X2, #0]
    SWP X9,X16,[X2]
    ADD  X2, X2, X28, ASR #0
    STP  X3, X11, [X2, #0]
    SWPA W9,W21,[X2]
    ADD  X2, X2, X28, ASR #0
    STP  X3, X18, [X2, #0]
    SWPA X11,X3,[X2]
    ADD  X2, X2, X28, LSR #0
    STP  X21, X4, [X2, #0]
    SWPAL W4,W22,[X2]
    ADD  X2, X2, X28, LSR #0
    STP  X3, X20, [X2, #0]
    SWPAL X5,X16,[X2]
    ADD  X2, X2, X28, LSR #0
    STP  X3, X22, [X2, #0]
    SWPL W5,W13,[X2]
    ADD  X2, X2, X28, LSR #0
    STP  X13, X17, [X2, #0]
    SWPL X16,X21,[X2]
    ADD  X2, X2, X28, LSR #0
    MOVZ  X15, #0xa5, LSL #0
    SUB  X19, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0xa5, LSL #0
    SUB  X19, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X19, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0xa5, LSL #0
    SUB  X19, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0xa5, LSL #0
    SUB  X19, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0xa5, LSL #0
    SUB  X19, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0xa5, LSL #0
    SUB  X19, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    SUB  X19, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0xa5, LSL #0
    SUB  X19, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0xa5, LSL #0
    SUB  X19, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0xa5, LSL #0
    SUB  X19, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0xa5, LSL #0
    SUB  X19, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    SUB  X19, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0xa5, LSL #0
    SUB  X19, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0xa5, LSL #0
    SUB  X19, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0xa5, LSL #0
    SUB  X19, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTGeneralLoadStoreP04_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X9, #0x10, LSL #0
    MOVZ  X12, #0xf00, LSL #0
    ADD  X2, X30, X12, LSR #0
    STP  X7, X14, [X2, #0]
    STUMAXB W28,[X2]
    ADD  X2, X2, X9, ASR #0
    STP  X23, X23, [X2, #0]
    STUMAXLB W22,[X2]
    ADD  X2, X2, X9, LSR #0
    STP  X5, X7, [X2, #0]
    LDUMAXB W11,W13,[X2]
    ADD  X2, X2, X9, ASR #0
    STP  X13, X17, [X2, #0]
    LDUMAXAB W22,W5,[X2]
    ADD  X2, X2, X9, ASR #0
    STP  X13, X5, [X2, #0]
    LDUMAXALB W3,W4,[X2]
    ADD  X2, X2, X9, ASR #0
    STP  X11, X13, [X2, #0]
    LDUMAXLB W5,W19,[X2]
    ADD  X2, X2, X9, LSR #0
    STP  X28, X22, [X2, #0]
    STUMAXH W18,[X2]
    ADD  X2, X2, X9, ASR #0
    STP  X19, X8, [X2, #0]
    STUMAXLH W13,[X2]
    ADD  X2, X2, X9, LSR #0
    STP  X13, X19, [X2, #0]
    LDUMAXH W6,W22,[X2]
    ADD  X2, X2, X9
    STP  X22, X18, [X2, #0]
    LDUMAXAH W8,W28,[X2]
    ADD  X2, X2, X9, LSR #0
    STP  X28, X16, [X2, #0]
    LDUMAXALH W11,W19,[X2]
    ADD  X2, X2, X9, ASR #0
    STP  X6, X22, [X2, #0]
    LDUMAXLH W18,W13,[X2]
    ADD  X2, X2, X9, ASR #0
    STP  X7, X22, [X2, #0]
    STUMAX W10,[X2]
    ADD  X2, X2, X9
    STP  X5, X10, [X2, #0]
    STUMAX X8,[X2]
    ADD  X2, X2, X9
    STP  X4, X20, [X2, #0]
    STUMAXL W23,[X2]
    ADD  X2, X2, X9, ASR #0
    STP  X17, X14, [X2, #0]
    STUMAXL X5,[X2]
    ADD  X2, X2, X9, LSR #0
    STP  X19, X28, [X2, #0]
    LDUMAX W19,W19,[X2]
    ADD  X2, X2, X9, ASR #0
    STP  X17, X20, [X2, #0]
    LDUMAX X22,X28,[X2]
    ADD  X2, X2, X9
    STP  X17, X8, [X2, #0]
    LDUMAXA W16,W22,[X2]
    ADD  X2, X2, X9, LSR #0
    STP  X6, X22, [X2, #0]
    LDUMAXA X17,X5,[X2]
    ADD  X2, X2, X9, LSR #0
    STP  X18, X17, [X2, #0]
    LDUMAXAL W13,W17,[X2]
    ADD  X2, X2, X9
    STP  X14, X23, [X2, #0]
    LDUMAXAL X23,X20,[X2]
    ADD  X2, X2, X9, ASR #0
    STP  X23, X5, [X2, #0]
    LDUMAXL W4,W16,[X2]
    ADD  X2, X2, X9, LSR #0
    STP  X16, X4, [X2, #0]
    LDUMAXL X10,X13,[X2]
    ADD  X2, X2, X9
    STP  X13, X28, [X2, #0]
    STUMINB W18,[X2]
    ADD  X2, X2, X9
    STP  X6, X10, [X2, #0]
    STUMINLB W19,[X2]
    ADD  X2, X2, X9, ASR #0
    STP  X16, X5, [X2, #0]
    LDUMINB W13,W8,[X2]
    ADD  X2, X2, X9, LSR #0
    STP  X22, X11, [X2, #0]
    LDUMINAB W7,W23,[X2]
    ADD  X2, X2, X9, ASR #0
    STP  X28, X11, [X2, #0]
    LDUMINALB W13,W22,[X2]
    ADD  X2, X2, X9
    STP  X11, X22, [X2, #0]
    LDUMINLB W19,W13,[X2]
    ADD  X2, X2, X9, LSR #0
    STP  X13, X18, [X2, #0]
    STUMINH W19,[X2]
    ADD  X2, X2, X9
    STP  X23, X13, [X2, #0]
    STUMINLH W7,[X2]
    ADD  X2, X2, X9, ASR #0
    STP  X8, X11, [X2, #0]
    LDUMINH W19,W18,[X2]
    ADD  X2, X2, X9, ASR #0
    STP  X17, X11, [X2, #0]
    LDUMINAH W6,W10,[X2]
    ADD  X2, X2, X9
    STP  X8, X13, [X2, #0]
    LDUMINALH W10,W22,[X2]
    ADD  X2, X2, X9, LSR #0
    STP  X3, X23, [X2, #0]
    LDUMINLH W14,W20,[X2]
    ADD  X2, X2, X9, ASR #0
    STP  X10, X4, [X2, #0]
    STUMIN W6,[X2]
    ADD  X2, X2, X9
    STP  X7, X17, [X2, #0]
    STUMIN X22,[X2]
    ADD  X2, X2, X9
    STP  X22, X18, [X2, #0]
    STUMINL W18,[X2]
    ADD  X2, X2, X9, ASR #0
    STP  X22, X8, [X2, #0]
    STUMINL X14,[X2]
    ADD  X2, X2, X9, ASR #0
    STP  X8, X10, [X2, #0]
    LDUMIN W19,W22,[X2]
    ADD  X2, X2, X9, LSR #0
    STP  X5, X16, [X2, #0]
    LDUMIN X8,X18,[X2]
    ADD  X2, X2, X9
    STP  X3, X11, [X2, #0]
    LDUMINA W13,W7,[X2]
    ADD  X2, X2, X9, ASR #0
    STP  X10, X23, [X2, #0]
    LDUMINA X8,X6,[X2]
    ADD  X2, X2, X9, LSR #0
    STP  X19, X14, [X2, #0]
    LDUMINAL W19,W19,[X2]
    ADD  X2, X2, X9, ASR #0
    STP  X28, X16, [X2, #0]
    LDUMINAL X5,X13,[X2]
    ADD  X2, X2, X9
    STP  X18, X17, [X2, #0]
    LDUMINL W14,W18,[X2]
    ADD  X2, X2, X9, ASR #0
    STP  X6, X22, [X2, #0]
    LDUMINL X4,X6,[X2]
    ADD  X2, X2, X9, LSR #0
    STP  X23, X10, [X2, #0]
    SWPB W22,W4,[X2]
    ADD  X2, X2, X9
    STP  X5, X8, [X2, #0]
    SWPAB W14,W3,[X2]
    ADD  X2, X2, X9, LSR #0
    STP  X11, X10, [X2, #0]
    SWPALB W10,W19,[X2]
    ADD  X2, X2, X9
    STP  X17, X14, [X2, #0]
    SWPLB W8,W20,[X2]
    ADD  X2, X2, X9, ASR #0
    STP  X4, X13, [X2, #0]
    SWPH W6,W4,[X2]
    ADD  X2, X2, X9
    STP  X5, X3, [X2, #0]
    SWPAH W19,W23,[X2]
    ADD  X2, X2, X9, LSR #0
    STP  X22, X28, [X2, #0]
    SWPALH W18,W19,[X2]
    ADD  X2, X2, X9, LSR #0
    STP  X23, X20, [X2, #0]
    SWPLH W4,W17,[X2]
    ADD  X2, X2, X9
    STP  X3, X10, [X2, #0]
    SWP W5,W23,[X2]
    ADD  X2, X2, X9, ASR #0
    STP  X4, X3, [X2, #0]
    SWP X5,X22,[X2]
    ADD  X2, X2, X9
    STP  X22, X14, [X2, #0]
    SWPA W14,W20,[X2]
    ADD  X2, X2, X9, LSR #0
    STP  X18, X18, [X2, #0]
    SWPA X3,X18,[X2]
    ADD  X2, X2, X9
    STP  X20, X8, [X2, #0]
    SWPAL W8,W8,[X2]
    ADD  X2, X2, X9, ASR #0
    STP  X20, X6, [X2, #0]
    SWPAL X14,X22,[X2]
    ADD  X2, X2, X9
    STP  X19, X17, [X2, #0]
    SWPL W5,W10,[X2]
    ADD  X2, X2, X9, LSR #0
    STP  X18, X5, [X2, #0]
    SWPL X3,X4,[X2]
    ADD  X2, X2, X9
    MOVZ  X15, #0x5a, LSL #0
    SUB  X21, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    SUB  X21, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X21, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    SUB  X21, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    SUB  X21, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0x5a, LSL #0
    SUB  X21, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0x5a, LSL #0
    SUB  X21, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X21, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X21, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    SUB  X21, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    SUB  X21, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0x5a, LSL #0
    SUB  X21, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0x5a, LSL #0
    SUB  X21, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0x5a, LSL #0
    SUB  X21, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0x5a, LSL #0
    SUB  X21, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X21, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTGeneralLoadStoreP04_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X22, #0x10, LSL #0
    MOVZ  X3, #0x1180, LSL #0
    ADD  X8, X30, X3, ASR #0
    STP  X23, X13, [X8, #0]
    STUMAXB W28,[X8]
    ADD  X8, X8, X22, ASR #0
    STP  X21, X14, [X8, #0]
    STUMAXLB W11,[X8]
    ADD  X8, X8, X22, ASR #0
    STP  X17, X21, [X8, #0]
    LDUMAXB W28,W9,[X8]
    ADD  X8, X8, X22, ASR #0
    STP  X15, X6, [X8, #0]
    LDUMAXAB W7,W15,[X8]
    ADD  X8, X8, X22, ASR #0
    STP  X6, X15, [X8, #0]
    LDUMAXALB W20,W21,[X8]
    ADD  X8, X8, X22
    STP  X23, X9, [X8, #0]
    LDUMAXLB W11,W10,[X8]
    ADD  X8, X8, X22, ASR #0
    STP  X4, X14, [X8, #0]
    STUMAXH W12,[X8]
    ADD  X8, X8, X22, LSR #0
    STP  X9, X9, [X8, #0]
    STUMAXLH W17,[X8]
    ADD  X8, X8, X22, ASR #0
    STP  X4, X13, [X8, #0]
    LDUMAXH W6,W28,[X8]
    ADD  X8, X8, X22
    STP  X13, X15, [X8, #0]
    LDUMAXAH W14,W12,[X8]
    ADD  X8, X8, X22, ASR #0
    STP  X4, X6, [X8, #0]
    LDUMAXALH W12,W12,[X8]
    ADD  X8, X8, X22, ASR #0
    STP  X16, X7, [X8, #0]
    LDUMAXLH W23,W14,[X8]
    ADD  X8, X8, X22, ASR #0
    STP  X14, X4, [X8, #0]
    STUMAX W16,[X8]
    ADD  X8, X8, X22, ASR #0
    STP  X20, X19, [X8, #0]
    STUMAX X2,[X8]
    ADD  X8, X8, X22, ASR #0
    STP  X12, X13, [X8, #0]
    STUMAXL W9,[X8]
    ADD  X8, X8, X22, LSR #0
    STP  X11, X11, [X8, #0]
    STUMAXL X10,[X8]
    ADD  X8, X8, X22, ASR #0
    STP  X28, X12, [X8, #0]
    LDUMAX W6,W15,[X8]
    ADD  X8, X8, X22, ASR #0
    STP  X9, X9, [X8, #0]
    LDUMAX X28,X2,[X8]
    ADD  X8, X8, X22, LSR #0
    STP  X23, X13, [X8, #0]
    LDUMAXA W13,W13,[X8]
    ADD  X8, X8, X22
    STP  X20, X16, [X8, #0]
    LDUMAXA X13,X9,[X8]
    ADD  X8, X8, X22, LSR #0
    STP  X4, X2, [X8, #0]
    LDUMAXAL W12,W20,[X8]
    ADD  X8, X8, X22, ASR #0
    STP  X23, X23, [X8, #0]
    LDUMAXAL X12,X4,[X8]
    ADD  X8, X8, X22, LSR #0
    STP  X11, X7, [X8, #0]
    LDUMAXL W9,W28,[X8]
    ADD  X8, X8, X22, LSR #0
    STP  X11, X28, [X8, #0]
    LDUMAXL X13,X13,[X8]
    ADD  X8, X8, X22
    STP  X9, X14, [X8, #0]
    STUMINB W19,[X8]
    ADD  X8, X8, X22, ASR #0
    STP  X14, X15, [X8, #0]
    STUMINLB W12,[X8]
    ADD  X8, X8, X22, LSR #0
    STP  X28, X6, [X8, #0]
    LDUMINB W28,W19,[X8]
    ADD  X8, X8, X22
    STP  X23, X11, [X8, #0]
    LDUMINAB W17,W15,[X8]
    ADD  X8, X8, X22, ASR #0
    STP  X19, X11, [X8, #0]
    LDUMINALB W13,W19,[X8]
    ADD  X8, X8, X22, ASR #0
    STP  X23, X20, [X8, #0]
    LDUMINLB W14,W14,[X8]
    ADD  X8, X8, X22, LSR #0
    STP  X23, X28, [X8, #0]
    STUMINH W6,[X8]
    ADD  X8, X8, X22
    STP  X15, X11, [X8, #0]
    STUMINLH W20,[X8]
    ADD  X8, X8, X22, LSR #0
    STP  X9, X7, [X8, #0]
    LDUMINH W2,W28,[X8]
    ADD  X8, X8, X22
    STP  X6, X6, [X8, #0]
    LDUMINAH W2,W17,[X8]
    ADD  X8, X8, X22
    STP  X10, X16, [X8, #0]
    LDUMINALH W16,W7,[X8]
    ADD  X8, X8, X22, LSR #0
    STP  X6, X6, [X8, #0]
    LDUMINLH W16,W2,[X8]
    ADD  X8, X8, X22
    STP  X11, X28, [X8, #0]
    STUMIN W15,[X8]
    ADD  X8, X8, X22
    STP  X20, X20, [X8, #0]
    STUMIN X15,[X8]
    ADD  X8, X8, X22
    STP  X15, X15, [X8, #0]
    STUMINL W20,[X8]
    ADD  X8, X8, X22, LSR #0
    STP  X7, X12, [X8, #0]
    STUMINL X16,[X8]
    ADD  X8, X8, X22, LSR #0
    STP  X12, X11, [X8, #0]
    LDUMIN W4,W28,[X8]
    ADD  X8, X8, X22, ASR #0
    STP  X17, X4, [X8, #0]
    LDUMIN X28,X6,[X8]
    ADD  X8, X8, X22
    STP  X13, X13, [X8, #0]
    LDUMINA W13,W7,[X8]
    ADD  X8, X8, X22
    STP  X23, X13, [X8, #0]
    LDUMINA X2,X28,[X8]
    ADD  X8, X8, X22
    STP  X28, X17, [X8, #0]
    LDUMINAL W10,W15,[X8]
    ADD  X8, X8, X22, ASR #0
    STP  X14, X13, [X8, #0]
    LDUMINAL X28,X16,[X8]
    ADD  X8, X8, X22
    STP  X19, X13, [X8, #0]
    LDUMINL W11,W20,[X8]
    ADD  X8, X8, X22, ASR #0
    STP  X14, X2, [X8, #0]
    LDUMINL X19,X10,[X8]
    ADD  X8, X8, X22, ASR #0
    STP  X17, X12, [X8, #0]
    SWPB W15,W17,[X8]
    ADD  X8, X8, X22, LSR #0
    STP  X12, X2, [X8, #0]
    SWPAB W6,W15,[X8]
    ADD  X8, X8, X22
    STP  X6, X6, [X8, #0]
    SWPALB W12,W28,[X8]
    ADD  X8, X8, X22, LSR #0
    STP  X15, X9, [X8, #0]
    SWPLB W7,W6,[X8]
    ADD  X8, X8, X22
    STP  X20, X2, [X8, #0]
    SWPH W2,W19,[X8]
    ADD  X8, X8, X22
    STP  X14, X28, [X8, #0]
    SWPAH W12,W20,[X8]
    ADD  X8, X8, X22, LSR #0
    STP  X12, X21, [X8, #0]
    SWPALH W15,W12,[X8]
    ADD  X8, X8, X22, LSR #0
    STP  X12, X17, [X8, #0]
    SWPLH W16,W28,[X8]
    ADD  X8, X8, X22, LSR #0
    STP  X9, X11, [X8, #0]
    SWP W19,W16,[X8]
    ADD  X8, X8, X22, ASR #0
    STP  X6, X20, [X8, #0]
    SWP X28,X12,[X8]
    ADD  X8, X8, X22, LSR #0
    STP  X28, X28, [X8, #0]
    SWPA W11,W15,[X8]
    ADD  X8, X8, X22
    STP  X2, X14, [X8, #0]
    SWPA X7,X28,[X8]
    ADD  X8, X8, X22, LSR #0
    STP  X2, X12, [X8, #0]
    SWPAL W6,W13,[X8]
    ADD  X8, X8, X22
    STP  X23, X23, [X8, #0]
    SWPAL X11,X6,[X8]
    ADD  X8, X8, X22, LSR #0
    STP  X2, X19, [X8, #0]
    SWPL W12,W20,[X8]
    ADD  X8, X8, X22, ASR #0
    STP  X16, X12, [X8, #0]
    SWPL X20,X9,[X8]
    ADD  X8, X8, X22, LSR #0
    MOVZ  X5, #0xa5a5, LSL #0
    SUB  X18, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X18, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X18, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    SUB  X18, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5, LSL #0
    SUB  X18, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5, LSL #0
    SUB  X18, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    SUB  X18, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5, LSL #0
    SUB  X18, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    SUB  X18, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    SUB  X18, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5, LSL #0
    SUB  X18, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X19
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    SUB  X18, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5, LSL #0
    SUB  X18, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X18, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    SUB  X18, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTGeneralLoadStoreP04_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X12, #0x10, LSL #0
    MOVZ  X16, #0x1400, LSL #0
    ADD  X13, X30, X16
    STP  X6, X23, [X13, #0]
    STUMAXB W28,[X13]
    ADD  X13, X13, X12
    STP  X21, X21, [X13, #0]
    STUMAXLB W9,[X13]
    ADD  X13, X13, X12
    STP  X5, X9, [X13, #0]
    LDUMAXB W22,W23,[X13]
    ADD  X13, X13, X12
    STP  X7, X23, [X13, #0]
    LDUMAXAB W2,W19,[X13]
    ADD  X13, X13, X12
    STP  X17, X17, [X13, #0]
    LDUMAXALB W9,W9,[X13]
    ADD  X13, X13, X12, LSR #0
    STP  X11, X9, [X13, #0]
    LDUMAXLB W20,W5,[X13]
    ADD  X13, X13, X12
    STP  X3, X5, [X13, #0]
    STUMAXH W7,[X13]
    ADD  X13, X13, X12, LSR #0
    STP  X3, X28, [X13, #0]
    STUMAXLH W14,[X13]
    ADD  X13, X13, X12, LSR #0
    STP  X4, X17, [X13, #0]
    LDUMAXH W20,W14,[X13]
    ADD  X13, X13, X12, ASR #0
    STP  X14, X9, [X13, #0]
    LDUMAXAH W28,W9,[X13]
    ADD  X13, X13, X12
    STP  X10, X10, [X13, #0]
    LDUMAXALH W11,W10,[X13]
    ADD  X13, X13, X12
    STP  X23, X21, [X13, #0]
    LDUMAXLH W4,W19,[X13]
    ADD  X13, X13, X12, LSR #0
    STP  X9, X8, [X13, #0]
    STUMAX W11,[X13]
    ADD  X13, X13, X12
    STP  X22, X2, [X13, #0]
    STUMAX X8,[X13]
    ADD  X13, X13, X12
    STP  X8, X7, [X13, #0]
    STUMAXL W22,[X13]
    ADD  X13, X13, X12, LSR #0
    STP  X14, X22, [X13, #0]
    STUMAXL X5,[X13]
    ADD  X13, X13, X12, LSR #0
    STP  X19, X2, [X13, #0]
    LDUMAX W10,W2,[X13]
    ADD  X13, X13, X12, ASR #0
    STP  X5, X23, [X13, #0]
    LDUMAX X22,X11,[X13]
    ADD  X13, X13, X12
    STP  X2, X20, [X13, #0]
    LDUMAXA W11,W5,[X13]
    ADD  X13, X13, X12, LSR #0
    STP  X17, X14, [X13, #0]
    LDUMAXA X6,X19,[X13]
    ADD  X13, X13, X12, ASR #0
    STP  X4, X22, [X13, #0]
    LDUMAXAL W7,W6,[X13]
    ADD  X13, X13, X12, LSR #0
    STP  X6, X8, [X13, #0]
    LDUMAXAL X19,X5,[X13]
    ADD  X13, X13, X12, ASR #0
    STP  X17, X7, [X13, #0]
    LDUMAXL W10,W22,[X13]
    ADD  X13, X13, X12
    STP  X7, X19, [X13, #0]
    LDUMAXL X21,X11,[X13]
    ADD  X13, X13, X12, LSR #0
    STP  X3, X2, [X13, #0]
    STUMINB W17,[X13]
    ADD  X13, X13, X12, ASR #0
    STP  X2, X17, [X13, #0]
    STUMINLB W11,[X13]
    ADD  X13, X13, X12, LSR #0
    STP  X9, X2, [X13, #0]
    LDUMINB W6,W17,[X13]
    ADD  X13, X13, X12, ASR #0
    STP  X5, X11, [X13, #0]
    LDUMINAB W3,W21,[X13]
    ADD  X13, X13, X12, LSR #0
    STP  X10, X5, [X13, #0]
    LDUMINALB W22,W11,[X13]
    ADD  X13, X13, X12, LSR #0
    STP  X5, X8, [X13, #0]
    LDUMINLB W10,W8,[X13]
    ADD  X13, X13, X12, LSR #0
    STP  X9, X5, [X13, #0]
    STUMINH W14,[X13]
    ADD  X13, X13, X12, ASR #0
    STP  X14, X28, [X13, #0]
    STUMINLH W8,[X13]
    ADD  X13, X13, X12, ASR #0
    STP  X28, X4, [X13, #0]
    LDUMINH W17,W9,[X13]
    ADD  X13, X13, X12, ASR #0
    STP  X28, X17, [X13, #0]
    LDUMINAH W11,W22,[X13]
    ADD  X13, X13, X12, ASR #0
    STP  X17, X20, [X13, #0]
    LDUMINALH W7,W11,[X13]
    ADD  X13, X13, X12
    STP  X2, X21, [X13, #0]
    LDUMINLH W17,W20,[X13]
    ADD  X13, X13, X12, ASR #0
    STP  X2, X14, [X13, #0]
    STUMIN W28,[X13]
    ADD  X13, X13, X12
    STP  X8, X20, [X13, #0]
    STUMIN X2,[X13]
    ADD  X13, X13, X12
    STP  X28, X7, [X13, #0]
    STUMINL W2,[X13]
    ADD  X13, X13, X12, ASR #0
    STP  X6, X4, [X13, #0]
    STUMINL X14,[X13]
    ADD  X13, X13, X12, ASR #0
    STP  X8, X6, [X13, #0]
    LDUMIN W7,W14,[X13]
    ADD  X13, X13, X12, LSR #0
    STP  X6, X23, [X13, #0]
    LDUMIN X19,X19,[X13]
    ADD  X13, X13, X12, ASR #0
    STP  X21, X7, [X13, #0]
    LDUMINA W28,W20,[X13]
    ADD  X13, X13, X12, ASR #0
    STP  X7, X5, [X13, #0]
    LDUMINA X10,X23,[X13]
    ADD  X13, X13, X12
    STP  X6, X22, [X13, #0]
    LDUMINAL W20,W22,[X13]
    ADD  X13, X13, X12, ASR #0
    STP  X22, X23, [X13, #0]
    LDUMINAL X28,X17,[X13]
    ADD  X13, X13, X12, LSR #0
    STP  X2, X28, [X13, #0]
    LDUMINL W19,W2,[X13]
    ADD  X13, X13, X12, ASR #0
    STP  X10, X2, [X13, #0]
    LDUMINL X9,X8,[X13]
    ADD  X13, X13, X12, ASR #0
    STP  X7, X3, [X13, #0]
    SWPB W8,W4,[X13]
    ADD  X13, X13, X12, LSR #0
    STP  X22, X8, [X13, #0]
    SWPAB W5,W23,[X13]
    ADD  X13, X13, X12, LSR #0
    STP  X10, X8, [X13, #0]
    SWPALB W19,W19,[X13]
    ADD  X13, X13, X12, LSR #0
    STP  X14, X2, [X13, #0]
    SWPLB W3,W5,[X13]
    ADD  X13, X13, X12
    STP  X22, X17, [X13, #0]
    SWPH W5,W17,[X13]
    ADD  X13, X13, X12
    STP  X10, X19, [X13, #0]
    SWPAH W19,W9,[X13]
    ADD  X13, X13, X12, ASR #0
    STP  X7, X4, [X13, #0]
    SWPALH W11,W14,[X13]
    ADD  X13, X13, X12, LSR #0
    STP  X21, X17, [X13, #0]
    SWPLH W8,W19,[X13]
    ADD  X13, X13, X12, ASR #0
    STP  X23, X23, [X13, #0]
    SWP W3,W17,[X13]
    ADD  X13, X13, X12, LSR #0
    STP  X17, X22, [X13, #0]
    SWP X23,X21,[X13]
    ADD  X13, X13, X12
    STP  X11, X22, [X13, #0]
    SWPA W3,W8,[X13]
    ADD  X13, X13, X12, ASR #0
    STP  X8, X28, [X13, #0]
    SWPA X14,X23,[X13]
    ADD  X13, X13, X12, ASR #0
    STP  X4, X6, [X13, #0]
    SWPAL W10,W3,[X13]
    ADD  X13, X13, X12, LSR #0
    STP  X21, X17, [X13, #0]
    SWPAL X7,X6,[X13]
    ADD  X13, X13, X12
    STP  X19, X20, [X13, #0]
    SWPL W6,W28,[X13]
    ADD  X13, X13, X12, LSR #0
    STP  X23, X5, [X13, #0]
    SWPL X28,X14,[X13]
    ADD  X13, X13, X12
    MOVZ  X18, #0x5a, LSL #0
    SUB  X15, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X18, #0x5a, LSL #0
    SUB  X15, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X18, #0x5a, LSL #0
    SUB  X15, X18, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X18, #0x5a, LSL #0
    SUB  X15, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    SUB  X15, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    SUB  X15, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X18, #0x5a, LSL #0
    SUB  X15, X18, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X18, #0x5a, LSL #0
    SUB  X15, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X18, #0x5a, LSL #0
    SUB  X15, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X18, #0x5a, LSL #0
    SUB  X15, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X18, #0x5a, LSL #0
    SUB  X15, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X18, #0x5a, LSL #0
    SUB  X15, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    SUB  X15, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X18, #0x5a, LSL #0
    SUB  X15, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X18, #0x5a, LSL #0
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTGeneralLoadStoreP04_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X22, #0x10, LSL #0
    MOVZ  X20, #0x1680, LSL #0
    ADD  X19, X30, X20, ASR #0
    STP  X21, X14, [X19, #0]
    STUMAXB W8,[X19]
    ADD  X19, X19, X22, ASR #0
    STP  X28, X23, [X19, #0]
    STUMAXLB W21,[X19]
    ADD  X19, X19, X22, LSR #0
    STP  X6, X10, [X19, #0]
    LDUMAXB W2,W3,[X19]
    ADD  X19, X19, X22, ASR #0
    STP  X9, X2, [X19, #0]
    LDUMAXAB W16,W14,[X19]
    ADD  X19, X19, X22
    STP  X6, X10, [X19, #0]
    LDUMAXALB W3,W2,[X19]
    ADD  X19, X19, X22
    STP  X23, X8, [X19, #0]
    LDUMAXLB W16,W10,[X19]
    ADD  X19, X19, X22, LSR #0
    STP  X21, X28, [X19, #0]
    STUMAXH W11,[X19]
    ADD  X19, X19, X22, LSR #0
    STP  X14, X8, [X19, #0]
    STUMAXLH W15,[X19]
    ADD  X19, X19, X22
    STP  X10, X28, [X19, #0]
    LDUMAXH W8,W8,[X19]
    ADD  X19, X19, X22
    STP  X15, X12, [X19, #0]
    LDUMAXAH W10,W14,[X19]
    ADD  X19, X19, X22
    STP  X9, X5, [X19, #0]
    LDUMAXALH W2,W6,[X19]
    ADD  X19, X19, X22, LSR #0
    STP  X23, X15, [X19, #0]
    LDUMAXLH W28,W11,[X19]
    ADD  X19, X19, X22
    STP  X9, X16, [X19, #0]
    STUMAX W14,[X19]
    ADD  X19, X19, X22
    STP  X5, X15, [X19, #0]
    STUMAX X16,[X19]
    ADD  X19, X19, X22, LSR #0
    STP  X21, X2, [X19, #0]
    STUMAXL W12,[X19]
    ADD  X19, X19, X22, ASR #0
    STP  X9, X3, [X19, #0]
    STUMAXL X11,[X19]
    ADD  X19, X19, X22, ASR #0
    STP  X21, X2, [X19, #0]
    LDUMAX W14,W2,[X19]
    ADD  X19, X19, X22, LSR #0
    STP  X21, X21, [X19, #0]
    LDUMAX X21,X2,[X19]
    ADD  X19, X19, X22, ASR #0
    STP  X9, X10, [X19, #0]
    LDUMAXA W3,W21,[X19]
    ADD  X19, X19, X22
    STP  X15, X21, [X19, #0]
    LDUMAXA X14,X10,[X19]
    ADD  X19, X19, X22
    STP  X2, X10, [X19, #0]
    LDUMAXAL W9,W21,[X19]
    ADD  X19, X19, X22, LSR #0
    STP  X11, X21, [X19, #0]
    LDUMAXAL X23,X11,[X19]
    ADD  X19, X19, X22, LSR #0
    STP  X23, X21, [X19, #0]
    LDUMAXL W21,W21,[X19]
    ADD  X19, X19, X22, LSR #0
    STP  X9, X14, [X19, #0]
    LDUMAXL X18,X3,[X19]
    ADD  X19, X19, X22, LSR #0
    STP  X11, X28, [X19, #0]
    STUMINB W11,[X19]
    ADD  X19, X19, X22, ASR #0
    STP  X9, X15, [X19, #0]
    STUMINLB W12,[X19]
    ADD  X19, X19, X22, ASR #0
    STP  X14, X6, [X19, #0]
    LDUMINB W3,W10,[X19]
    ADD  X19, X19, X22, LSR #0
    STP  X2, X8, [X19, #0]
    LDUMINAB W21,W9,[X19]
    ADD  X19, X19, X22
    STP  X10, X5, [X19, #0]
    LDUMINALB W15,W5,[X19]
    ADD  X19, X19, X22
    STP  X16, X28, [X19, #0]
    LDUMINLB W13,W3,[X19]
    ADD  X19, X19, X22
    STP  X7, X14, [X19, #0]
    STUMINH W5,[X19]
    ADD  X19, X19, X22
    STP  X14, X6, [X19, #0]
    STUMINLH W15,[X19]
    ADD  X19, X19, X22, LSR #0
    STP  X18, X18, [X19, #0]
    LDUMINH W6,W10,[X19]
    ADD  X19, X19, X22
    STP  X2, X13, [X19, #0]
    LDUMINAH W2,W6,[X19]
    ADD  X19, X19, X22
    STP  X9, X13, [X19, #0]
    LDUMINALH W18,W7,[X19]
    ADD  X19, X19, X22, ASR #0
    STP  X23, X8, [X19, #0]
    LDUMINLH W3,W13,[X19]
    ADD  X19, X19, X22
    STP  X16, X28, [X19, #0]
    STUMIN W7,[X19]
    ADD  X19, X19, X22
    STP  X2, X16, [X19, #0]
    STUMIN X5,[X19]
    ADD  X19, X19, X22, ASR #0
    STP  X21, X18, [X19, #0]
    STUMINL W28,[X19]
    ADD  X19, X19, X22
    STP  X13, X7, [X19, #0]
    STUMINL X16,[X19]
    ADD  X19, X19, X22, ASR #0
    STP  X6, X12, [X19, #0]
    LDUMIN W21,W15,[X19]
    ADD  X19, X19, X22, ASR #0
    STP  X16, X8, [X19, #0]
    LDUMIN X18,X6,[X19]
    ADD  X19, X19, X22, ASR #0
    STP  X6, X10, [X19, #0]
    LDUMINA W9,W18,[X19]
    ADD  X19, X19, X22
    STP  X11, X16, [X19, #0]
    LDUMINA X14,X28,[X19]
    ADD  X19, X19, X22, LSR #0
    STP  X9, X2, [X19, #0]
    LDUMINAL W3,W7,[X19]
    ADD  X19, X19, X22
    STP  X23, X12, [X19, #0]
    LDUMINAL X3,X3,[X19]
    ADD  X19, X19, X22, ASR #0
    STP  X9, X5, [X19, #0]
    LDUMINL W3,W3,[X19]
    ADD  X19, X19, X22, LSR #0
    STP  X8, X12, [X19, #0]
    LDUMINL X11,X12,[X19]
    ADD  X19, X19, X22, ASR #0
    STP  X28, X14, [X19, #0]
    SWPB W16,W6,[X19]
    ADD  X19, X19, X22, LSR #0
    STP  X7, X6, [X19, #0]
    SWPAB W28,W10,[X19]
    ADD  X19, X19, X22, LSR #0
    STP  X15, X12, [X19, #0]
    SWPALB W16,W6,[X19]
    ADD  X19, X19, X22, ASR #0
    STP  X11, X18, [X19, #0]
    SWPLB W7,W21,[X19]
    ADD  X19, X19, X22, LSR #0
    STP  X6, X10, [X19, #0]
    SWPH W11,W15,[X19]
    ADD  X19, X19, X22, LSR #0
    STP  X11, X21, [X19, #0]
    SWPAH W7,W28,[X19]
    ADD  X19, X19, X22, ASR #0
    STP  X18, X3, [X19, #0]
    SWPALH W5,W7,[X19]
    ADD  X19, X19, X22
    STP  X15, X18, [X19, #0]
    SWPLH W10,W11,[X19]
    ADD  X19, X19, X22
    STP  X21, X5, [X19, #0]
    SWP W12,W28,[X19]
    ADD  X19, X19, X22
    STP  X14, X15, [X19, #0]
    SWP X3,X3,[X19]
    ADD  X19, X19, X22, LSR #0
    STP  X9, X5, [X19, #0]
    SWPA W5,W21,[X19]
    ADD  X19, X19, X22, ASR #0
    STP  X11, X18, [X19, #0]
    SWPA X6,X5,[X19]
    ADD  X19, X19, X22, LSR #0
    STP  X23, X18, [X19, #0]
    SWPAL W7,W6,[X19]
    ADD  X19, X19, X22, LSR #0
    STP  X12, X6, [X19, #0]
    SWPAL X9,X3,[X19]
    ADD  X19, X19, X22, ASR #0
    STP  X28, X18, [X19, #0]
    SWPL W3,W15,[X19]
    ADD  X19, X19, X22
    STP  X2, X6, [X19, #0]
    SWPL X12,X14,[X19]
    ADD  X19, X19, X22, ASR #0
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X17, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X4, #0xa5, LSL #0
    SUB  X17, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    SUB  X17, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X4, #0xa5, LSL #0
    SUB  X17, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X4, #0xa5, LSL #0
    SUB  X17, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X4, #0xa5, LSL #0
    SUB  X17, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X17, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X17, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    SUB  X17, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X4, #0xa5, LSL #0
    SUB  X17, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTGeneralLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTGeneralLoadStoreP04_TestFail

LCRTGeneralLoadStoreP04_TestEnd:
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
LCRTGeneralLoadStoreP04_TestFail:
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
