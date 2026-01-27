.global SveLoadStoreP04

.text
.p2align 4

SveLoadStoreP04:

SveLoadStoreP04_TestBegin:
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
    MOVZ  X2, #0x8a5c, LSL #0
    MOVK  X2, #0xaa81, LSL #16
    MOVK  X2, #0x1bef, LSL #32
    MOVK  X2, #0xd897, LSL #48
    MOVZ  X3, #0xe5d5, LSL #0
    MOVK  X3, #0x9c91, LSL #16
    MOVK  X3, #0x6210, LSL #32
    MOVK  X3, #0xb050, LSL #48
    MOVZ  X4, #0x42a0, LSL #0
    MOVK  X4, #0x887d, LSL #16
    MOVK  X4, #0x1312, LSL #32
    MOVK  X4, #0xf65f, LSL #48
    MOVZ  X5, #0xeb9, LSL #0
    MOVK  X5, #0x9f13, LSL #16
    MOVK  X5, #0xdf66, LSL #32
    MOVK  X5, #0x2fb1, LSL #48
    MOVZ  X6, #0xf13, LSL #0
    MOVK  X6, #0x5a2d, LSL #16
    MOVK  X6, #0x823f, LSL #32
    MOVK  X6, #0x4c2d, LSL #48
    MOVZ  X7, #0xed64, LSL #0
    MOVK  X7, #0x6949, LSL #16
    MOVK  X7, #0xc191, LSL #32
    MOVK  X7, #0x904b, LSL #48
    MOVZ  X8, #0x8610, LSL #0
    MOVK  X8, #0x2055, LSL #16
    MOVK  X8, #0x37f7, LSL #32
    MOVK  X8, #0x1531, LSL #48
    MOVZ  X9, #0xe5d8, LSL #0
    MOVK  X9, #0xc397, LSL #16
    MOVK  X9, #0xa557, LSL #32
    MOVK  X9, #0x57cc, LSL #48
    MOVZ  X10, #0x4f6a, LSL #0
    MOVK  X10, #0x77c, LSL #16
    MOVK  X10, #0x952, LSL #32
    MOVK  X10, #0x8493, LSL #48
    MOVZ  X11, #0x626b, LSL #0
    MOVK  X11, #0x993a, LSL #16
    MOVK  X11, #0xa524, LSL #32
    MOVK  X11, #0xe21, LSL #48
    MOVZ  X12, #0x9756, LSL #0
    MOVK  X12, #0x2af5, LSL #16
    MOVK  X12, #0x845, LSL #32
    MOVK  X12, #0xbffd, LSL #48
    MOVZ  X13, #0x5cf9, LSL #0
    MOVK  X13, #0x373a, LSL #16
    MOVK  X13, #0x3b9a, LSL #32
    MOVK  X13, #0x3af8, LSL #48
    MOVZ  X14, #0x8f7a, LSL #0
    MOVK  X14, #0x7756, LSL #16
    MOVK  X14, #0xe16c, LSL #32
    MOVK  X14, #0x48a, LSL #48
    MOVZ  X15, #0x99ba, LSL #0
    MOVK  X15, #0x5cf1, LSL #16
    MOVK  X15, #0xf0fc, LSL #32
    MOVK  X15, #0x6e03, LSL #48
    MOVZ  X16, #0x60df, LSL #0
    MOVK  X16, #0xf56, LSL #16
    MOVK  X16, #0xc9e9, LSL #32
    MOVK  X16, #0xddd9, LSL #48
    MOVZ  X17, #0x191a, LSL #0
    MOVK  X17, #0x9c26, LSL #16
    MOVK  X17, #0xadf2, LSL #32
    MOVK  X17, #0xf325, LSL #48
    MOVZ  X23, #0x8e23, LSL #0
    MOVK  X23, #0x1a9a, LSL #16
    MOVK  X23, #0x3eb2, LSL #32
    MOVK  X23, #0x416e, LSL #48
    MOVZ  X24, #0x8c93, LSL #0
    MOVK  X24, #0x4e39, LSL #16
    MOVK  X24, #0x4612, LSL #32
    MOVK  X24, #0x1e66, LSL #48
    MOVZ  X25, #0xd5f4, LSL #0
    MOVK  X25, #0x3cb3, LSL #16
    MOVK  X25, #0x4768, LSL #32
    MOVK  X25, #0xc60, LSL #48
    MOVZ  X26, #0xc14d, LSL #0
    MOVK  X26, #0xa11, LSL #16
    MOVK  X26, #0x4364, LSL #32
    MOVK  X26, #0xa7f0, LSL #48
    MOVZ  X27, #0x9823, LSL #0
    MOVK  X27, #0xb679, LSL #16
    MOVK  X27, #0x2f07, LSL #32
    MOVK  X27, #0x8701, LSL #48
    MOVZ  X28, #0xc3f1, LSL #0
    MOVK  X28, #0xf851, LSL #16
    MOVK  X28, #0x457, LSL #32
    MOVK  X28, #0x70f9, LSL #48
    MOVZ  X29, #0x181, LSL #0
    MOVK  X29, #0x410c, LSL #16
    MOVK  X29, #0xf3df, LSL #32
    MOVK  X29, #0xc71a, LSL #48
    MOVZ  X16, #0x30d8, LSL #0
    MOVK  X16, #0x43cd, LSL #16
    MOVK  X16, #0x6bdd, LSL #32
    MOVK  X16, #0xfece, LSL #48
    MSR  FPCR, X16
    MRS  X23, FPCR
    MOVZ  X2, #0x60ff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    AND  X23, X23, X2
    MOVZ  X2, #0x0, LSL #0
    ORR  X23, X23, X2
    MSR  FPCR, X23
    ISB  SY
    MOVZ  X16, #0xc795, LSL #0
    MOVK  X16, #0x63e6, LSL #16
    MOVK  X16, #0xaaa8, LSL #32
    MOVK  X16, #0x15ad, LSL #48
    MSR  FPSR, X16
    MRS  X8, FPSR
    MOVZ  X17, #0xff60, LSL #0
    MOVK  X17, #0x7ff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    AND  X8, X8, X17
    MOVZ  X17, #0x0, LSL #0
    ORR  X8, X8, X17
    MSR  FPSR, X8
    ISB  SY
    ADDS  X17, X23, W11, UXTW #4
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
    DUP     Z0.D, X25
    DUP     Z1.D, X3
    DUP     Z2.D, X28
    DUP     Z3.D, X26
    DUP     Z4.D, X27
    DUP     Z5.D, X24
    DUP     Z6.D, X29
    DUP     Z7.D, X13
    DUP     Z8.D, X16
    DUP     Z9.D, X4
    DUP     Z10.D, X17
    DUP     Z11.D, X16
    DUP     Z12.D, X14
    DUP     Z13.D, X13
    DUP     Z14.D, X26
    DUP     Z15.D, X27
    DUP     Z16.D, X2
    DUP     Z17.D, X9
    DUP     Z18.D, X13
    DUP     Z19.D, X17
    DUP     Z20.D, X5
    DUP     Z21.D, X3
    DUP     Z22.D, X28
    DUP     Z23.D, X4
    DUP     Z24.D, X6
    DUP     Z25.D, X3
    DUP     Z26.D, X12
    DUP     Z27.D, X24
    DUP     Z28.D, X25
    DUP     Z29.D, X29
    DUP     Z30.D, X13
    DUP     Z31.D, X15
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X29, #0x0, LSL #0
    ADD  X26, X30, X29, LSR #0
    MOVZ  X8, #0x80, LSL #0
    ST4D    { Z25.D, Z26.D, Z27.D, Z28.D }, P5, [X26, #0, MUL VL]
    DUP     Z15.D, X26
    ST1B     Z14.D, P4, [Z15.D, #0]
    LD1B     Z27.D, P5/Z, [Z15.D, #0]
    ADD  X26, X26, X8
    ST4D    { Z22.D, Z23.D, Z24.D, Z25.D }, P6, [X26, #0, MUL VL]
    DUP     Z15.D, X26
    ST1H     Z18.D, P3, [Z15.D, #0]
    LD1H     Z26.D, P3/Z, [Z15.D, #0]
    ADD  X26, X26, X8
    ST4D    { Z25.D, Z26.D, Z27.D, Z28.D }, P7, [X26, #0, MUL VL]
    DUP     Z15.D, X26
    ST1W     Z9.D, P6, [Z15.D, #0]
    LD1W     Z12.D, P2/Z, [Z15.D, #0]
    ADD  X26, X26, X8, LSR #0
    ST4D    { Z30.D, Z31.D, Z0.D, Z1.D }, P2, [X26, #0, MUL VL]
    DUP     Z15.D, X26
    ST1D     Z8.D, P6, [Z15.D, #0]
    LD1D     Z1.D, P7/Z, [Z15.D, #0]
    ADD  X26, X26, X8
    ST4D    { Z25.D, Z26.D, Z27.D, Z28.D }, P0, [X26, #0, MUL VL]
    DUP     Z15.D, X26
    ST1B     Z10.D, P0, [Z15.D, #0]
    LD1SB    Z9.D, P1/Z, [Z15.D, #0]
    ADD  X26, X26, X8
    ST4D    { Z5.D, Z6.D, Z7.D, Z8.D }, P5, [X26, #0, MUL VL]
    DUP     Z15.D, X26
    ST1H     Z12.D, P0, [Z15.D, #0]
    LD1SH    Z16.D, P0/Z, [Z15.D, #0]
    ADD  X26, X26, X8, LSR #0
    ST4D    { Z7.D, Z8.D, Z9.D, Z10.D }, P2, [X26, #0, MUL VL]
    DUP     Z15.D, X26
    ST1W     Z18.D, P4, [Z15.D, #0]
    LD1SW    Z0.D, P3/Z, [Z15.D, #0]
    ADD  X26, X26, X8, ASR #0
    ST4D    { Z21.D, Z22.D, Z23.D, Z24.D }, P2, [X26, #0, MUL VL]
    DUP     Z15.D, X26
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X6, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X6, X28, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X6, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X6, X28, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X6, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X6, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X6, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X6, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X6, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X6, X28, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X6, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X6, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X6, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X6, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X6, X28, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X6, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MRS  X28, FPSR
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V0.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D0
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V1.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D1
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D2
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V3.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D3
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V4.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D4
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D5
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D6
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V7.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D7
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D8
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V9.D[1]
    MOVZ  X6, #0x5a, LSL #0
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D9
    MOVZ  X6, #0x5a, LSL #0
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D10
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D11
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V12.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D12
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V13.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D13
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D14
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D16
    MOVZ  X6, #0x5a5a, LSL #0
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D17
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D18
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V19.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D19
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D20
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V21.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D21
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D22
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V23.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D23
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D24
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D25
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D26
    MOVZ  X6, #0x5a5a, LSL #0
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V27.D[1]
    MOVZ  X6, #0x5a, LSL #0
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D27
    MOVZ  X6, #0x5a, LSL #0
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V28.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D28
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V29.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D29
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V30.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D30
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, V31.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X28, D31
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x0, LSL #0
    STR  X28, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X28, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x0, LSL #0
    STR  X28, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X28, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x0, LSL #0
    STR  X28, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X28, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x0, LSL #0
    STR  X28, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X28, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x0, LSL #0
    STR  X28, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X28, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x0, LSL #0
    STR  X28, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X28, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x0, LSL #0
    STR  X28, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X28, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x0, LSL #0
    STR  X28, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X28, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x0, LSL #0
    STR  X28, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X28, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x0, LSL #0
    STR  X28, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X28, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x0, LSL #0
    STR  X28, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X28, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x0, LSL #0
    STR  X28, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X28, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x0, LSL #0
    STR  X28, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X28, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x0, LSL #0
    STR  X28, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X28, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x0, LSL #0
    STR  X28, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X28, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X28, #0x0, LSL #0
    STR  X28, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X28, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P5, Z0.D
    FMOV  X28, D0
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D1, P6, Z1.D
    FMOV  X28, D1
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D2, P1, Z2.D
    FMOV  X28, D2
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D3, P1, Z3.D
    FMOV  X28, D3
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D4, P0, Z4.D
    FMOV  X28, D4
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D5, P0, Z5.D
    FMOV  X28, D5
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D6, P6, Z6.D
    FMOV  X28, D6
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D7, P1, Z7.D
    FMOV  X28, D7
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D8, P4, Z8.D
    FMOV  X28, D8
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D9, P2, Z9.D
    FMOV  X28, D9
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D10, P0, Z10.D
    FMOV  X28, D10
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D11, P5, Z11.D
    FMOV  X28, D11
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D12, P7, Z12.D
    FMOV  X28, D12
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D13, P1, Z13.D
    FMOV  X28, D13
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D14, P3, Z14.D
    FMOV  X28, D14
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D16, P5, Z16.D
    FMOV  X28, D16
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D17, P3, Z17.D
    FMOV  X28, D17
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D18, P4, Z18.D
    FMOV  X28, D18
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D19, P2, Z19.D
    FMOV  X28, D19
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D20, P7, Z20.D
    FMOV  X28, D20
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D21, P6, Z21.D
    FMOV  X28, D21
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D22, P4, Z22.D
    FMOV  X28, D22
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D23, P3, Z23.D
    FMOV  X28, D23
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D24, P3, Z24.D
    FMOV  X28, D24
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D25, P6, Z25.D
    FMOV  X28, D25
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D26, P0, Z26.D
    FMOV  X28, D26
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D27, P3, Z27.D
    FMOV  X28, D27
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D28, P6, Z28.D
    FMOV  X28, D28
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D29, P7, Z29.D
    FMOV  X28, D29
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D30, P1, Z30.D
    FMOV  X28, D30
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D31, P1, Z31.D
    FMOV  X28, D31
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X13, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
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
    DUP     Z0.D, X25
    DUP     Z1.D, X28
    DUP     Z2.D, X26
    DUP     Z3.D, X3
    DUP     Z4.D, X13
    DUP     Z5.D, X29
    DUP     Z6.D, X27
    DUP     Z7.D, X23
    DUP     Z8.D, X7
    DUP     Z9.D, X5
    DUP     Z10.D, X16
    DUP     Z11.D, X3
    DUP     Z12.D, X17
    DUP     Z13.D, X8
    DUP     Z14.D, X25
    DUP     Z15.D, X29
    DUP     Z16.D, X12
    DUP     Z17.D, X13
    DUP     Z18.D, X15
    DUP     Z19.D, X23
    DUP     Z20.D, X12
    DUP     Z21.D, X26
    DUP     Z22.D, X26
    DUP     Z23.D, X2
    DUP     Z24.D, X3
    DUP     Z25.D, X17
    DUP     Z26.D, X14
    DUP     Z27.D, X3
    DUP     Z28.D, X11
    DUP     Z29.D, X12
    DUP     Z30.D, X7
    DUP     Z31.D, X23
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X27, #0x200, LSL #0
    ADD  X11, X30, X27
    MOVZ  X17, #0x80, LSL #0
    ST4D    { Z8.D, Z9.D, Z10.D, Z11.D }, P1, [X11, #0, MUL VL]
    DUP     Z9.D, X11
    ST1B     Z13.D, P0, [Z9.D, #0]
    LD1B     Z28.D, P1/Z, [Z9.D, #0]
    ADD  X11, X11, X17, LSR #0
    ST4D    { Z20.D, Z21.D, Z22.D, Z23.D }, P7, [X11, #0, MUL VL]
    DUP     Z9.D, X11
    ST1H     Z28.D, P4, [Z9.D, #0]
    LD1H     Z12.D, P4/Z, [Z9.D, #0]
    ADD  X11, X11, X17
    ST4D    { Z16.D, Z17.D, Z18.D, Z19.D }, P4, [X11, #0, MUL VL]
    DUP     Z9.D, X11
    ST1W     Z12.D, P4, [Z9.D, #0]
    LD1W     Z24.D, P4/Z, [Z9.D, #0]
    ADD  X11, X11, X17
    ST4D    { Z30.D, Z31.D, Z0.D, Z1.D }, P1, [X11, #0, MUL VL]
    DUP     Z9.D, X11
    ST1D     Z11.D, P3, [Z9.D, #0]
    LD1D     Z15.D, P1/Z, [Z9.D, #0]
    ADD  X11, X11, X17
    ST4D    { Z24.D, Z25.D, Z26.D, Z27.D }, P1, [X11, #0, MUL VL]
    DUP     Z9.D, X11
    ST1B     Z28.D, P3, [Z9.D, #0]
    LD1SB    Z18.D, P0/Z, [Z9.D, #0]
    ADD  X11, X11, X17, LSR #0
    ST4D    { Z29.D, Z30.D, Z31.D, Z0.D }, P0, [X11, #0, MUL VL]
    DUP     Z9.D, X11
    ST1H     Z14.D, P1, [Z9.D, #0]
    LD1SH    Z26.D, P4/Z, [Z9.D, #0]
    ADD  X11, X11, X17, LSR #0
    ST4D    { Z4.D, Z5.D, Z6.D, Z7.D }, P5, [X11, #0, MUL VL]
    DUP     Z9.D, X11
    ST1W     Z26.D, P5, [Z9.D, #0]
    LD1SW    Z17.D, P5/Z, [Z9.D, #0]
    ADD  X11, X11, X17, LSR #0
    ST4D    { Z2.D, Z3.D, Z4.D, Z5.D }, P2, [X11, #0, MUL VL]
    DUP     Z9.D, X11
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X25, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X25, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X25, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X25, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X25, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X25, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X25, X10, X9
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X25, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X25, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X25, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X25, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X25, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X25, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X25, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X25, X10, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X25, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X25, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MRS  X10, FPSR
    MOVZ  X25, #0x80, LSL #0
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V0.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D0
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V1.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D1
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V2.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D2
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V3.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D3
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D4
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D5
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V6.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D6
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V7.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D7
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V8.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D8
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V10.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D10
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D11
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X25, #0xa5, LSL #0
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D12
    MOVZ  X25, #0xa5, LSL #0
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V13.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D13
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D14
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D15
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D16
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V17.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D17
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X25, #0xffa5, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D18
    MOVZ  X25, #0xffa5, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V19.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D19
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D20
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D21
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D22
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V23.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D23
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X25, #0xa5, LSL #0
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D24
    MOVZ  X25, #0xa5, LSL #0
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V25.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D25
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D26
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D27
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V28.D[1]
    MOVZ  X25, #0xa5, LSL #0
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D28
    MOVZ  X25, #0xa5, LSL #0
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V29.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D29
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V30.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D30
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, V31.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FMOV  X10, D31
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P3, Z0.D
    FMOV  X10, D0
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5c5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FADDV   D1, P7, Z1.D
    FMOV  X10, D1
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5c5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FADDV   D2, P2, Z2.D
    FMOV  X10, D2
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5c5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FADDV   D3, P7, Z3.D
    FMOV  X10, D3
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5c5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FADDV   D4, P7, Z4.D
    FMOV  X10, D4
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5c5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FADDV   D5, P4, Z5.D
    FMOV  X10, D5
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5c5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FADDV   D6, P4, Z6.D
    FMOV  X10, D6
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5c5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FADDV   D7, P1, Z7.D
    FMOV  X10, D7
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5c5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FADDV   D8, P7, Z8.D
    FMOV  X10, D8
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5c5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FADDV   D10, P2, Z10.D
    FMOV  X10, D10
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5c5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FADDV   D11, P1, Z11.D
    FMOV  X10, D11
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5c5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FADDV   D12, P4, Z12.D
    FMOV  X10, D12
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FADDV   D13, P7, Z13.D
    FMOV  X10, D13
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5c5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FADDV   D14, P1, Z14.D
    FMOV  X10, D14
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5c5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FADDV   D15, P2, Z15.D
    FMOV  X10, D15
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5c5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FADDV   D16, P3, Z16.D
    FMOV  X10, D16
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5c5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FADDV   D17, P3, Z17.D
    FMOV  X10, D17
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7ff8, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FADDV   D18, P2, Z18.D
    FMOV  X10, D18
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7ff8, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FADDV   D19, P1, Z19.D
    FMOV  X10, D19
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5c5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FADDV   D20, P4, Z20.D
    FMOV  X10, D20
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5c5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FADDV   D21, P5, Z21.D
    FMOV  X10, D21
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5c5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FADDV   D22, P0, Z22.D
    FMOV  X10, D22
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5c5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FADDV   D23, P2, Z23.D
    FMOV  X10, D23
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5c5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FADDV   D24, P0, Z24.D
    FMOV  X10, D24
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FADDV   D25, P3, Z25.D
    FMOV  X10, D25
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5c5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FADDV   D26, P2, Z26.D
    FMOV  X10, D26
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7ff8, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FADDV   D27, P4, Z27.D
    FMOV  X10, D27
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5c5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FADDV   D28, P4, Z28.D
    FMOV  X10, D28
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FADDV   D29, P7, Z29.D
    FMOV  X10, D29
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5c5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FADDV   D30, P4, Z30.D
    FMOV  X10, D30
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5c5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    FADDV   D31, P5, Z31.D
    FMOV  X10, D31
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5c5, LSL #48
    SUB  X7, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
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
    DUP     Z0.D, X29
    DUP     Z1.D, X28
    DUP     Z2.D, X24
    DUP     Z3.D, X26
    DUP     Z4.D, X25
    DUP     Z5.D, X23
    DUP     Z6.D, X15
    DUP     Z7.D, X11
    DUP     Z8.D, X7
    DUP     Z9.D, X2
    DUP     Z10.D, X25
    DUP     Z11.D, X15
    DUP     Z12.D, X24
    DUP     Z13.D, X26
    DUP     Z14.D, X2
    DUP     Z15.D, X24
    DUP     Z16.D, X14
    DUP     Z17.D, X6
    DUP     Z18.D, X12
    DUP     Z19.D, X4
    DUP     Z20.D, X9
    DUP     Z21.D, X24
    DUP     Z22.D, X7
    DUP     Z23.D, X26
    DUP     Z24.D, X10
    DUP     Z25.D, X27
    DUP     Z26.D, X23
    DUP     Z27.D, X13
    DUP     Z28.D, X13
    DUP     Z29.D, X9
    DUP     Z30.D, X13
    DUP     Z31.D, X14
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X7, #0x400, LSL #0
    ADD  X27, X30, X7
    MOVZ  X8, #0x80, LSL #0
    ST4D    { Z11.D, Z12.D, Z13.D, Z14.D }, P3, [X27, #0, MUL VL]
    DUP     Z11.D, X27
    ST1B     Z17.D, P6, [Z11.D, #0]
    LD1B     Z31.D, P5/Z, [Z11.D, #0]
    ADD  X27, X27, X8
    ST4D    { Z27.D, Z28.D, Z29.D, Z30.D }, P3, [X27, #0, MUL VL]
    DUP     Z11.D, X27
    ST1H     Z31.D, P4, [Z11.D, #0]
    LD1H     Z15.D, P7/Z, [Z11.D, #0]
    ADD  X27, X27, X8, ASR #0
    ST4D    { Z7.D, Z8.D, Z9.D, Z10.D }, P4, [X27, #0, MUL VL]
    DUP     Z11.D, X27
    ST1W     Z17.D, P6, [Z11.D, #0]
    LD1W     Z4.D, P0/Z, [Z11.D, #0]
    ADD  X27, X27, X8
    ST4D    { Z30.D, Z31.D, Z0.D, Z1.D }, P6, [X27, #0, MUL VL]
    DUP     Z11.D, X27
    ST1D     Z14.D, P1, [Z11.D, #0]
    LD1D     Z7.D, P7/Z, [Z11.D, #0]
    ADD  X27, X27, X8, ASR #0
    ST4D    { Z26.D, Z27.D, Z28.D, Z29.D }, P6, [X27, #0, MUL VL]
    DUP     Z11.D, X27
    ST1B     Z17.D, P1, [Z11.D, #0]
    LD1SB    Z17.D, P6/Z, [Z11.D, #0]
    ADD  X27, X27, X8
    ST4D    { Z0.D, Z1.D, Z2.D, Z3.D }, P2, [X27, #0, MUL VL]
    DUP     Z11.D, X27
    ST1H     Z27.D, P7, [Z11.D, #0]
    LD1SH    Z26.D, P3/Z, [Z11.D, #0]
    ADD  X27, X27, X8
    ST4D    { Z6.D, Z7.D, Z8.D, Z9.D }, P3, [X27, #0, MUL VL]
    DUP     Z11.D, X27
    ST1W     Z22.D, P1, [Z11.D, #0]
    LD1SW    Z10.D, P4/Z, [Z11.D, #0]
    ADD  X27, X27, X8
    ST4D    { Z14.D, Z15.D, Z16.D, Z17.D }, P5, [X27, #0, MUL VL]
    DUP     Z11.D, X27
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X10, X3, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X10, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X10, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X10, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X10, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X10, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X10, X3, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X10, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X10, X3, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X10, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X10, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X10, X3, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X10, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X10, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X10, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X10, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MRS  X3, FPSR
    MOVZ  X10, #0x80, LSL #0
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V0.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D0
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V1.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D1
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V2.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D2
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V3.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D3
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V4.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D4
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D5
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V6.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D6
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D7
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D8
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V9.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D9
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D10
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V12.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D12
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V13.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D13
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V14.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D14
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V15.D[1]
    MOVZ  X10, #0x5a, LSL #0
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D15
    MOVZ  X10, #0x5a, LSL #0
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V16.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D16
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V17.D[1]
    MOVZ  X10, #0x5a, LSL #0
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D17
    MOVZ  X10, #0x5a, LSL #0
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V18.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D18
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D19
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V20.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D20
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V21.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D21
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V22.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D22
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V23.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D23
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V24.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D24
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D25
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V26.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D26
    MOVZ  X10, #0x5a5a, LSL #0
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V27.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D27
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D28
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V29.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D29
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V30.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D30
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, V31.D[1]
    MOVZ  X10, #0x5a, LSL #0
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X3, D31
    MOVZ  X10, #0x5a, LSL #0
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    STR  X3, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X3, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P5, Z0.D
    FMOV  X3, D0
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D1, P3, Z1.D
    FMOV  X3, D1
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D2, P3, Z2.D
    FMOV  X3, D2
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D3, P0, Z3.D
    FMOV  X3, D3
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D4, P5, Z4.D
    FMOV  X3, D4
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D5, P5, Z5.D
    FMOV  X3, D5
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D6, P7, Z6.D
    FMOV  X3, D6
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D7, P3, Z7.D
    FMOV  X3, D7
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D8, P5, Z8.D
    FMOV  X3, D8
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D9, P2, Z9.D
    FMOV  X3, D9
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D10, P1, Z10.D
    FMOV  X3, D10
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D12, P4, Z12.D
    FMOV  X3, D12
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D13, P5, Z13.D
    FMOV  X3, D13
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D14, P3, Z14.D
    FMOV  X3, D14
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D15, P6, Z15.D
    FMOV  X3, D15
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D16, P5, Z16.D
    FMOV  X3, D16
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D17, P4, Z17.D
    FMOV  X3, D17
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D18, P4, Z18.D
    FMOV  X3, D18
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D19, P7, Z19.D
    FMOV  X3, D19
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D20, P7, Z20.D
    FMOV  X3, D20
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D21, P3, Z21.D
    FMOV  X3, D21
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D22, P5, Z22.D
    FMOV  X3, D22
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D23, P7, Z23.D
    FMOV  X3, D23
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D24, P0, Z24.D
    FMOV  X3, D24
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D25, P7, Z25.D
    FMOV  X3, D25
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D26, P1, Z26.D
    FMOV  X3, D26
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D27, P2, Z27.D
    FMOV  X3, D27
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D28, P6, Z28.D
    FMOV  X3, D28
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D29, P6, Z29.D
    FMOV  X3, D29
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D30, P7, Z30.D
    FMOV  X3, D30
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D31, P1, Z31.D
    FMOV  X3, D31
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
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
    DUP     Z0.D, X5
    DUP     Z1.D, X29
    DUP     Z2.D, X28
    DUP     Z3.D, X27
    DUP     Z4.D, X6
    DUP     Z5.D, X26
    DUP     Z6.D, X11
    DUP     Z7.D, X3
    DUP     Z8.D, X24
    DUP     Z9.D, X8
    DUP     Z10.D, X5
    DUP     Z11.D, X15
    DUP     Z12.D, X7
    DUP     Z13.D, X24
    DUP     Z14.D, X10
    DUP     Z15.D, X13
    DUP     Z16.D, X8
    DUP     Z17.D, X15
    DUP     Z18.D, X14
    DUP     Z19.D, X2
    DUP     Z20.D, X28
    DUP     Z21.D, X5
    DUP     Z22.D, X28
    DUP     Z23.D, X23
    DUP     Z24.D, X29
    DUP     Z25.D, X24
    DUP     Z26.D, X12
    DUP     Z27.D, X24
    DUP     Z28.D, X5
    DUP     Z29.D, X2
    DUP     Z30.D, X29
    DUP     Z31.D, X7
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X28, #0x600, LSL #0
    ADD  X16, X30, X28, LSR #0
    MOVZ  X6, #0x80, LSL #0
    ST4D    { Z27.D, Z28.D, Z29.D, Z30.D }, P5, [X16, #0, MUL VL]
    DUP     Z9.D, X16
    ST1B     Z7.D, P6, [Z9.D, #0]
    LD1B     Z30.D, P2/Z, [Z9.D, #0]
    ADD  X16, X16, X6, ASR #0
    ST4D    { Z19.D, Z20.D, Z21.D, Z22.D }, P1, [X16, #0, MUL VL]
    DUP     Z9.D, X16
    ST1H     Z8.D, P3, [Z9.D, #0]
    LD1H     Z12.D, P2/Z, [Z9.D, #0]
    ADD  X16, X16, X6, LSR #0
    ST4D    { Z20.D, Z21.D, Z22.D, Z23.D }, P4, [X16, #0, MUL VL]
    DUP     Z9.D, X16
    ST1W     Z12.D, P2, [Z9.D, #0]
    LD1W     Z19.D, P7/Z, [Z9.D, #0]
    ADD  X16, X16, X6, ASR #0
    ST4D    { Z18.D, Z19.D, Z20.D, Z21.D }, P1, [X16, #0, MUL VL]
    DUP     Z9.D, X16
    ST1D     Z24.D, P3, [Z9.D, #0]
    LD1D     Z28.D, P0/Z, [Z9.D, #0]
    ADD  X16, X16, X6, ASR #0
    ST4D    { Z3.D, Z4.D, Z5.D, Z6.D }, P6, [X16, #0, MUL VL]
    DUP     Z9.D, X16
    ST1B     Z4.D, P0, [Z9.D, #0]
    LD1SB    Z12.D, P3/Z, [Z9.D, #0]
    ADD  X16, X16, X6, LSR #0
    ST4D    { Z20.D, Z21.D, Z22.D, Z23.D }, P4, [X16, #0, MUL VL]
    DUP     Z9.D, X16
    ST1H     Z8.D, P0, [Z9.D, #0]
    LD1SH    Z18.D, P1/Z, [Z9.D, #0]
    ADD  X16, X16, X6, LSR #0
    ST4D    { Z31.D, Z0.D, Z1.D, Z2.D }, P5, [X16, #0, MUL VL]
    DUP     Z9.D, X16
    ST1W     Z1.D, P2, [Z9.D, #0]
    LD1SW    Z24.D, P4/Z, [Z9.D, #0]
    ADD  X16, X16, X6, ASR #0
    ST4D    { Z4.D, Z5.D, Z6.D, Z7.D }, P1, [X16, #0, MUL VL]
    DUP     Z9.D, X16
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X23, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X23, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X23, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X23, X5, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X23, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X23, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X23, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X23, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X23, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X23, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X23, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X23, X5, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X23, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X23, X5, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X23, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MRS  X5, FPSR
    MOVZ  X23, #0x80, LSL #0
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V0.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D0
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V1.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D1
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V2.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D2
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V3.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D3
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D4
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V5.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D5
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V6.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D6
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V7.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D7
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V8.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D8
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V10.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D10
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V11.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D11
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V12.D[1]
    MOVZ  X23, #0xffa5, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D12
    MOVZ  X23, #0xffa5, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V13.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D13
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V14.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D14
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V15.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D15
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V16.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D16
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V17.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D17
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V18.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D18
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V19.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D19
    MOVZ  X23, #0xa5a5, LSL #0
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V20.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D20
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V21.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D21
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V22.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D22
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V23.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D23
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V24.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D24
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V25.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D25
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V26.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D26
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V27.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D27
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V28.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D28
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V29.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D29
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V30.D[1]
    MOVZ  X23, #0xa5, LSL #0
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D30
    MOVZ  X23, #0xa5, LSL #0
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, V31.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FMOV  X5, D31
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    MOVZ  X5, #0x0, LSL #0
    STR  X5, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X5, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P4, Z0.D
    FMOV  X5, D0
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D1, P6, Z1.D
    FMOV  X5, D1
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D2, P0, Z2.D
    FMOV  X5, D2
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D3, P1, Z3.D
    FMOV  X5, D3
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D4, P7, Z4.D
    FMOV  X5, D4
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D5, P0, Z5.D
    FMOV  X5, D5
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D6, P0, Z6.D
    FMOV  X5, D6
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D7, P3, Z7.D
    FMOV  X5, D7
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D8, P6, Z8.D
    FMOV  X5, D8
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D10, P0, Z10.D
    FMOV  X5, D10
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D11, P0, Z11.D
    FMOV  X5, D11
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D12, P5, Z12.D
    FMOV  X5, D12
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7ff8, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D13, P3, Z13.D
    FMOV  X5, D13
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D14, P2, Z14.D
    FMOV  X5, D14
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D15, P3, Z15.D
    FMOV  X5, D15
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D16, P6, Z16.D
    FMOV  X5, D16
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D17, P6, Z17.D
    FMOV  X5, D17
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D18, P2, Z18.D
    FMOV  X5, D18
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7ff8, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D19, P7, Z19.D
    FMOV  X5, D19
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D20, P4, Z20.D
    FMOV  X5, D20
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D21, P3, Z21.D
    FMOV  X5, D21
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D22, P7, Z22.D
    FMOV  X5, D22
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D23, P6, Z23.D
    FMOV  X5, D23
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D24, P2, Z24.D
    FMOV  X5, D24
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7ff8, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D25, P0, Z25.D
    FMOV  X5, D25
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D26, P4, Z26.D
    FMOV  X5, D26
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D27, P7, Z27.D
    FMOV  X5, D27
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D28, P2, Z28.D
    FMOV  X5, D28
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D29, P3, Z29.D
    FMOV  X5, D29
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D30, P7, Z30.D
    FMOV  X5, D30
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
    FADDV   D31, P5, Z31.D
    FMOV  X5, D31
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, SveLoadStoreP04_TestFail
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
    DUP     Z0.D, X26
    DUP     Z1.D, X28
    DUP     Z2.D, X24
    DUP     Z3.D, X16
    DUP     Z4.D, X29
    DUP     Z5.D, X25
    DUP     Z6.D, X27
    DUP     Z7.D, X23
    DUP     Z8.D, X16
    DUP     Z9.D, X4
    DUP     Z10.D, X27
    DUP     Z11.D, X3
    DUP     Z12.D, X11
    DUP     Z13.D, X10
    DUP     Z14.D, X26
    DUP     Z15.D, X17
    DUP     Z16.D, X7
    DUP     Z17.D, X25
    DUP     Z18.D, X28
    DUP     Z19.D, X12
    DUP     Z20.D, X27
    DUP     Z21.D, X4
    DUP     Z22.D, X9
    DUP     Z23.D, X25
    DUP     Z24.D, X23
    DUP     Z25.D, X8
    DUP     Z26.D, X14
    DUP     Z27.D, X9
    DUP     Z28.D, X29
    DUP     Z29.D, X6
    DUP     Z30.D, X3
    DUP     Z31.D, X27
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X14, #0x800, LSL #0
    ADD  X26, X30, X14, LSR #0
    MOVZ  X8, #0x80, LSL #0
    ST4D    { Z3.D, Z4.D, Z5.D, Z6.D }, P1, [X26, #0, MUL VL]
    DUP     Z2.D, X26
    ST1B     Z11.D, P0, [Z2.D, #0]
    LD1B     Z26.D, P0/Z, [Z2.D, #0]
    ADD  X26, X26, X8, ASR #0
    ST4D    { Z22.D, Z23.D, Z24.D, Z25.D }, P4, [X26, #0, MUL VL]
    DUP     Z2.D, X26
    ST1H     Z24.D, P1, [Z2.D, #0]
    LD1H     Z13.D, P4/Z, [Z2.D, #0]
    ADD  X26, X26, X8, ASR #0
    ST4D    { Z10.D, Z11.D, Z12.D, Z13.D }, P7, [X26, #0, MUL VL]
    DUP     Z2.D, X26
    ST1W     Z26.D, P7, [Z2.D, #0]
    LD1W     Z30.D, P7/Z, [Z2.D, #0]
    ADD  X26, X26, X8, LSR #0
    ST4D    { Z15.D, Z16.D, Z17.D, Z18.D }, P5, [X26, #0, MUL VL]
    DUP     Z2.D, X26
    ST1D     Z4.D, P3, [Z2.D, #0]
    LD1D     Z10.D, P2/Z, [Z2.D, #0]
    ADD  X26, X26, X8, ASR #0
    ST4D    { Z11.D, Z12.D, Z13.D, Z14.D }, P3, [X26, #0, MUL VL]
    DUP     Z2.D, X26
    ST1B     Z30.D, P4, [Z2.D, #0]
    LD1SB    Z24.D, P7/Z, [Z2.D, #0]
    ADD  X26, X26, X8
    ST4D    { Z5.D, Z6.D, Z7.D, Z8.D }, P5, [X26, #0, MUL VL]
    DUP     Z2.D, X26
    ST1H     Z7.D, P6, [Z2.D, #0]
    LD1SH    Z14.D, P4/Z, [Z2.D, #0]
    ADD  X26, X26, X8
    ST4D    { Z17.D, Z18.D, Z19.D, Z20.D }, P4, [X26, #0, MUL VL]
    DUP     Z2.D, X26
    ST1W     Z14.D, P5, [Z2.D, #0]
    LD1SW    Z16.D, P5/Z, [Z2.D, #0]
    ADD  X26, X26, X8, ASR #0
    ST4D    { Z25.D, Z26.D, Z27.D, Z28.D }, P7, [X26, #0, MUL VL]
    DUP     Z2.D, X26
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X6, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X6, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X6, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X6, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X6, X24, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X6, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X6, X24, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X6, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X6, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X6, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X6, X24, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X6, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X6, X24, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X6, X24, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X6, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X6, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X6, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, SveLoadStoreP04_TestFail
    MRS  X24, FPSR
    MOVZ  X6, #0x80, LSL #0
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V0.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D0
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V1.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D1
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V3.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D3
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D4
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D5
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D6
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D7
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V8.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D8
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D9
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V10.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D10
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V11.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D11
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V12.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D12
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V13.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D13
    MOVZ  X6, #0x5a5a, LSL #0
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D14
    MOVZ  X6, #0x5a5a, LSL #0
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D15
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V16.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D16
    MOVZ  X6, #0x5a5a, LSL #0
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D17
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V18.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D18
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D19
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D20
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V21.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D21
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V22.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D22
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V23.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D23
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V24.D[1]
    MOVZ  X6, #0x5a, LSL #0
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D24
    MOVZ  X6, #0x5a, LSL #0
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V25.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D25
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V26.D[1]
    MOVZ  X6, #0x5a, LSL #0
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D26
    MOVZ  X6, #0x5a, LSL #0
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D27
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V28.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D28
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V29.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D29
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V30.D[1]
    MOVZ  X6, #0x5a, LSL #0
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D30
    MOVZ  X6, #0x5a, LSL #0
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, V31.D[1]
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X24, D31
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X24, #0x0, LSL #0
    STR  X24, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X24, [X0, #0]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P7, Z0.D
    FMOV  X24, D0
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D1, P5, Z1.D
    FMOV  X24, D1
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D3, P6, Z3.D
    FMOV  X24, D3
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D4, P4, Z4.D
    FMOV  X24, D4
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D5, P2, Z5.D
    FMOV  X24, D5
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D6, P7, Z6.D
    FMOV  X24, D6
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D7, P0, Z7.D
    FMOV  X24, D7
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D8, P2, Z8.D
    FMOV  X24, D8
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D9, P0, Z9.D
    FMOV  X24, D9
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D10, P5, Z10.D
    FMOV  X24, D10
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D11, P4, Z11.D
    FMOV  X24, D11
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D12, P2, Z12.D
    FMOV  X24, D12
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D13, P6, Z13.D
    FMOV  X24, D13
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D14, P7, Z14.D
    FMOV  X24, D14
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D15, P7, Z15.D
    FMOV  X24, D15
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D16, P2, Z16.D
    FMOV  X24, D16
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D17, P7, Z17.D
    FMOV  X24, D17
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D18, P3, Z18.D
    FMOV  X24, D18
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D19, P2, Z19.D
    FMOV  X24, D19
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D20, P0, Z20.D
    FMOV  X24, D20
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D21, P3, Z21.D
    FMOV  X24, D21
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D22, P0, Z22.D
    FMOV  X24, D22
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D23, P2, Z23.D
    FMOV  X24, D23
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D24, P3, Z24.D
    FMOV  X24, D24
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D25, P1, Z25.D
    FMOV  X24, D25
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D26, P0, Z26.D
    FMOV  X24, D26
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D27, P6, Z27.D
    FMOV  X24, D27
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D28, P0, Z28.D
    FMOV  X24, D28
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D29, P0, Z29.D
    FMOV  X24, D29
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D30, P4, Z30.D
    FMOV  X24, D30
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D31, P0, Z31.D
    FMOV  X24, D31
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a7a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
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
    DUP     Z0.D, X25
    DUP     Z1.D, X29
    DUP     Z2.D, X26
    DUP     Z3.D, X27
    DUP     Z4.D, X28
    DUP     Z5.D, X6
    DUP     Z6.D, X29
    DUP     Z7.D, X9
    DUP     Z8.D, X27
    DUP     Z9.D, X24
    DUP     Z10.D, X4
    DUP     Z11.D, X5
    DUP     Z12.D, X14
    DUP     Z13.D, X12
    DUP     Z14.D, X16
    DUP     Z15.D, X27
    DUP     Z16.D, X9
    DUP     Z17.D, X8
    DUP     Z18.D, X17
    DUP     Z19.D, X5
    DUP     Z20.D, X28
    DUP     Z21.D, X15
    DUP     Z22.D, X7
    DUP     Z23.D, X25
    DUP     Z24.D, X16
    DUP     Z25.D, X14
    DUP     Z26.D, X28
    DUP     Z27.D, X24
    DUP     Z28.D, X15
    DUP     Z29.D, X23
    DUP     Z30.D, X29
    DUP     Z31.D, X29
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X6, #0xa00, LSL #0
    ADD  X7, X30, X6
    MOVZ  X8, #0x80, LSL #0
    ST4D    { Z24.D, Z25.D, Z26.D, Z27.D }, P7, [X7, #0, MUL VL]
    DUP     Z3.D, X7
    ST1B     Z22.D, P0, [Z3.D, #0]
    LD1B     Z1.D, P4/Z, [Z3.D, #0]
    ADD  X7, X7, X8, LSR #0
    ST4D    { Z16.D, Z17.D, Z18.D, Z19.D }, P5, [X7, #0, MUL VL]
    DUP     Z3.D, X7
    ST1H     Z13.D, P0, [Z3.D, #0]
    LD1H     Z19.D, P2/Z, [Z3.D, #0]
    ADD  X7, X7, X8, ASR #0
    ST4D    { Z14.D, Z15.D, Z16.D, Z17.D }, P6, [X7, #0, MUL VL]
    DUP     Z3.D, X7
    ST1W     Z8.D, P0, [Z3.D, #0]
    LD1W     Z31.D, P4/Z, [Z3.D, #0]
    ADD  X7, X7, X8, ASR #0
    ST4D    { Z17.D, Z18.D, Z19.D, Z20.D }, P7, [X7, #0, MUL VL]
    DUP     Z3.D, X7
    ST1D     Z1.D, P3, [Z3.D, #0]
    LD1D     Z18.D, P4/Z, [Z3.D, #0]
    ADD  X7, X7, X8, ASR #0
    ST4D    { Z13.D, Z14.D, Z15.D, Z16.D }, P2, [X7, #0, MUL VL]
    DUP     Z3.D, X7
    ST1B     Z9.D, P7, [Z3.D, #0]
    LD1SB    Z11.D, P7/Z, [Z3.D, #0]
    ADD  X7, X7, X8
    ST4D    { Z29.D, Z30.D, Z31.D, Z0.D }, P4, [X7, #0, MUL VL]
    DUP     Z3.D, X7
    ST1H     Z22.D, P1, [Z3.D, #0]
    LD1SH    Z19.D, P6/Z, [Z3.D, #0]
    ADD  X7, X7, X8, LSR #0
    ST4D    { Z29.D, Z30.D, Z31.D, Z0.D }, P5, [X7, #0, MUL VL]
    DUP     Z3.D, X7
    ST1W     Z10.D, P4, [Z3.D, #0]
    LD1SW    Z10.D, P6/Z, [Z3.D, #0]
    ADD  X7, X7, X8
    ST4D    { Z19.D, Z20.D, Z21.D, Z22.D }, P7, [X7, #0, MUL VL]
    DUP     Z3.D, X7
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X9, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MRS  X10, FPSR
    MOVZ  X9, #0x80, LSL #0
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V0.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D0
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V1.D[1]
    MOVZ  X9, #0xa5, LSL #0
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D1
    MOVZ  X9, #0xa5, LSL #0
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V2.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D2
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D4
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D5
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V6.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D6
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V7.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D7
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V8.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D8
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D9
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V10.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D10
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X9, #0xffa5, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D11
    MOVZ  X9, #0xffa5, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D12
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V13.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D13
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D14
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D15
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D16
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V17.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D17
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X9, #0xa5, LSL #0
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D18
    MOVZ  X9, #0xa5, LSL #0
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V19.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D19
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D20
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D21
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D22
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V23.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D23
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D24
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V25.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D25
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D26
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D27
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V28.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D28
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V29.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D29
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V30.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D30
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, V31.D[1]
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FMOV  X10, D31
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    MOVZ  X10, #0x0, LSL #0
    STR  X10, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X10, [X0, #0]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P4, Z0.D
    FMOV  X10, D0
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5c5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FADDV   D1, P6, Z1.D
    FMOV  X10, D1
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FADDV   D2, P4, Z2.D
    FMOV  X10, D2
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5c5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FADDV   D4, P6, Z4.D
    FMOV  X10, D4
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5c5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FADDV   D5, P3, Z5.D
    FMOV  X10, D5
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5c5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FADDV   D6, P1, Z6.D
    FMOV  X10, D6
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5c5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FADDV   D7, P3, Z7.D
    FMOV  X10, D7
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5c5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FADDV   D8, P5, Z8.D
    FMOV  X10, D8
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5c5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FADDV   D9, P7, Z9.D
    FMOV  X10, D9
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5c5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FADDV   D10, P1, Z10.D
    FMOV  X10, D10
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x7ff8, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FADDV   D11, P1, Z11.D
    FMOV  X10, D11
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x7ff8, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FADDV   D12, P4, Z12.D
    FMOV  X10, D12
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5c5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FADDV   D13, P1, Z13.D
    FMOV  X10, D13
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5c5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FADDV   D14, P2, Z14.D
    FMOV  X10, D14
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5c5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FADDV   D15, P6, Z15.D
    FMOV  X10, D15
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5c5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FADDV   D16, P4, Z16.D
    FMOV  X10, D16
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5c5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FADDV   D17, P5, Z17.D
    FMOV  X10, D17
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5c5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FADDV   D18, P1, Z18.D
    FMOV  X10, D18
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FADDV   D19, P5, Z19.D
    FMOV  X10, D19
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x7ff8, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FADDV   D20, P2, Z20.D
    FMOV  X10, D20
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5c5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FADDV   D21, P5, Z21.D
    FMOV  X10, D21
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5c5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FADDV   D22, P0, Z22.D
    FMOV  X10, D22
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5c5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FADDV   D23, P2, Z23.D
    FMOV  X10, D23
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5c5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FADDV   D24, P7, Z24.D
    FMOV  X10, D24
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5c5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FADDV   D25, P1, Z25.D
    FMOV  X10, D25
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5c5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FADDV   D26, P6, Z26.D
    FMOV  X10, D26
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5c5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FADDV   D27, P6, Z27.D
    FMOV  X10, D27
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5c5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FADDV   D28, P1, Z28.D
    FMOV  X10, D28
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5c5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FADDV   D29, P5, Z29.D
    FMOV  X10, D29
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5c5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FADDV   D30, P4, Z30.D
    FMOV  X10, D30
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5c5, LSL #48
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
    FADDV   D31, P0, Z31.D
    FMOV  X10, D31
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, SveLoadStoreP04_TestFail
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
    DUP     Z0.D, X11
    DUP     Z1.D, X27
    DUP     Z2.D, X5
    DUP     Z3.D, X14
    DUP     Z4.D, X28
    DUP     Z5.D, X10
    DUP     Z6.D, X26
    DUP     Z7.D, X3
    DUP     Z8.D, X8
    DUP     Z9.D, X29
    DUP     Z10.D, X2
    DUP     Z11.D, X23
    DUP     Z12.D, X12
    DUP     Z13.D, X9
    DUP     Z14.D, X2
    DUP     Z15.D, X12
    DUP     Z16.D, X6
    DUP     Z17.D, X24
    DUP     Z18.D, X26
    DUP     Z19.D, X9
    DUP     Z20.D, X14
    DUP     Z21.D, X28
    DUP     Z22.D, X3
    DUP     Z23.D, X16
    DUP     Z24.D, X5
    DUP     Z25.D, X7
    DUP     Z26.D, X16
    DUP     Z27.D, X11
    DUP     Z28.D, X27
    DUP     Z29.D, X3
    DUP     Z30.D, X27
    DUP     Z31.D, X24
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X7, #0xc00, LSL #0
    ADD  X24, X30, X7, ASR #0
    MOVZ  X26, #0x80, LSL #0
    ST4D    { Z6.D, Z7.D, Z8.D, Z9.D }, P6, [X24, #0, MUL VL]
    DUP     Z13.D, X24
    ST1B     Z25.D, P2, [Z13.D, #0]
    LD1B     Z28.D, P2/Z, [Z13.D, #0]
    ADD  X24, X24, X26, LSR #0
    ST4D    { Z9.D, Z10.D, Z11.D, Z12.D }, P7, [X24, #0, MUL VL]
    DUP     Z13.D, X24
    ST1H     Z28.D, P5, [Z13.D, #0]
    LD1H     Z2.D, P1/Z, [Z13.D, #0]
    ADD  X24, X24, X26
    ST4D    { Z24.D, Z25.D, Z26.D, Z27.D }, P0, [X24, #0, MUL VL]
    DUP     Z13.D, X24
    ST1W     Z27.D, P3, [Z13.D, #0]
    LD1W     Z19.D, P2/Z, [Z13.D, #0]
    ADD  X24, X24, X26, LSR #0
    ST4D    { Z16.D, Z17.D, Z18.D, Z19.D }, P4, [X24, #0, MUL VL]
    DUP     Z13.D, X24
    ST1D     Z29.D, P6, [Z13.D, #0]
    LD1D     Z15.D, P2/Z, [Z13.D, #0]
    ADD  X24, X24, X26
    ST4D    { Z23.D, Z24.D, Z25.D, Z26.D }, P4, [X24, #0, MUL VL]
    DUP     Z13.D, X24
    ST1B     Z17.D, P5, [Z13.D, #0]
    LD1SB    Z29.D, P1/Z, [Z13.D, #0]
    ADD  X24, X24, X26, ASR #0
    ST4D    { Z18.D, Z19.D, Z20.D, Z21.D }, P7, [X24, #0, MUL VL]
    DUP     Z13.D, X24
    ST1H     Z27.D, P1, [Z13.D, #0]
    LD1SH    Z24.D, P1/Z, [Z13.D, #0]
    ADD  X24, X24, X26, LSR #0
    ST4D    { Z22.D, Z23.D, Z24.D, Z25.D }, P7, [X24, #0, MUL VL]
    DUP     Z13.D, X24
    ST1W     Z1.D, P1, [Z13.D, #0]
    LD1SW    Z27.D, P4/Z, [Z13.D, #0]
    ADD  X24, X24, X26
    ST4D    { Z21.D, Z22.D, Z23.D, Z24.D }, P4, [X24, #0, MUL VL]
    DUP     Z13.D, X24
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X23, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X23, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X23, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X23, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X23, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X23, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X23, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X23, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X23, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X23, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X23, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X23, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X23, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X23, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MRS  X16, FPSR
    MOVZ  X23, #0x80, LSL #0
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D0
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D1
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X23, #0x5a, LSL #0
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D2
    MOVZ  X23, #0x5a, LSL #0
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D3
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D4
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D5
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D6
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D7
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D8
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D9
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D10
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D11
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D12
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D14
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D15
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D16
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D17
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D18
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D19
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D20
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D21
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D22
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D23
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D24
    MOVZ  X23, #0x5a5a, LSL #0
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D25
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D26
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D27
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X23, #0x5a, LSL #0
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D28
    MOVZ  X23, #0x5a, LSL #0
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X23, #0x5a, LSL #0
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D29
    MOVZ  X23, #0x5a, LSL #0
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D30
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X16, D31
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    STR  X16, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X16, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P5, Z0.D
    FMOV  X16, D0
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a7a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D1, P7, Z1.D
    FMOV  X16, D1
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a7a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D2, P4, Z2.D
    FMOV  X16, D2
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D3, P7, Z3.D
    FMOV  X16, D3
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a7a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D4, P6, Z4.D
    FMOV  X16, D4
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a7a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D5, P0, Z5.D
    FMOV  X16, D5
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a7a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D6, P7, Z6.D
    FMOV  X16, D6
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a7a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D7, P3, Z7.D
    FMOV  X16, D7
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a7a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D8, P0, Z8.D
    FMOV  X16, D8
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a7a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D9, P5, Z9.D
    FMOV  X16, D9
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a7a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D10, P5, Z10.D
    FMOV  X16, D10
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a7a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D11, P2, Z11.D
    FMOV  X16, D11
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a7a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D12, P6, Z12.D
    FMOV  X16, D12
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a7a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D14, P0, Z14.D
    FMOV  X16, D14
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a7a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D15, P3, Z15.D
    FMOV  X16, D15
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a7a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D16, P5, Z16.D
    FMOV  X16, D16
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a7a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D17, P1, Z17.D
    FMOV  X16, D17
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a7a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D18, P1, Z18.D
    FMOV  X16, D18
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a7a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D19, P0, Z19.D
    FMOV  X16, D19
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D20, P2, Z20.D
    FMOV  X16, D20
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a7a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D21, P3, Z21.D
    FMOV  X16, D21
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a7a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D22, P0, Z22.D
    FMOV  X16, D22
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a7a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D23, P2, Z23.D
    FMOV  X16, D23
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a7a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D24, P3, Z24.D
    FMOV  X16, D24
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D25, P7, Z25.D
    FMOV  X16, D25
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a7a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D26, P5, Z26.D
    FMOV  X16, D26
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a7a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D27, P6, Z27.D
    FMOV  X16, D27
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D28, P2, Z28.D
    FMOV  X16, D28
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D29, P0, Z29.D
    FMOV  X16, D29
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D30, P6, Z30.D
    FMOV  X16, D30
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a7a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D31, P5, Z31.D
    FMOV  X16, D31
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a7a, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
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
    DUP     Z0.D, X28
    DUP     Z1.D, X25
    DUP     Z2.D, X29
    DUP     Z3.D, X27
    DUP     Z4.D, X26
    DUP     Z5.D, X16
    DUP     Z6.D, X14
    DUP     Z7.D, X25
    DUP     Z8.D, X3
    DUP     Z9.D, X29
    DUP     Z10.D, X27
    DUP     Z11.D, X5
    DUP     Z12.D, X12
    DUP     Z13.D, X9
    DUP     Z14.D, X27
    DUP     Z15.D, X24
    DUP     Z16.D, X4
    DUP     Z17.D, X5
    DUP     Z18.D, X25
    DUP     Z19.D, X25
    DUP     Z20.D, X28
    DUP     Z21.D, X10
    DUP     Z22.D, X29
    DUP     Z23.D, X17
    DUP     Z24.D, X16
    DUP     Z25.D, X26
    DUP     Z26.D, X12
    DUP     Z27.D, X26
    DUP     Z28.D, X16
    DUP     Z29.D, X16
    DUP     Z30.D, X15
    DUP     Z31.D, X26
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X24, #0xe00, LSL #0
    ADD  X6, X30, X24, ASR #0
    MOVZ  X2, #0x80, LSL #0
    ST4D    { Z14.D, Z15.D, Z16.D, Z17.D }, P6, [X6, #0, MUL VL]
    DUP     Z18.D, X6
    ST1B     Z2.D, P4, [Z18.D, #0]
    LD1B     Z27.D, P4/Z, [Z18.D, #0]
    ADD  X6, X6, X2
    ST4D    { Z29.D, Z30.D, Z31.D, Z0.D }, P5, [X6, #0, MUL VL]
    DUP     Z18.D, X6
    ST1H     Z21.D, P5, [Z18.D, #0]
    LD1H     Z16.D, P7/Z, [Z18.D, #0]
    ADD  X6, X6, X2
    ST4D    { Z11.D, Z12.D, Z13.D, Z14.D }, P2, [X6, #0, MUL VL]
    DUP     Z18.D, X6
    ST1W     Z24.D, P4, [Z18.D, #0]
    LD1W     Z2.D, P0/Z, [Z18.D, #0]
    ADD  X6, X6, X2, ASR #0
    ST4D    { Z7.D, Z8.D, Z9.D, Z10.D }, P6, [X6, #0, MUL VL]
    DUP     Z18.D, X6
    ST1D     Z2.D, P4, [Z18.D, #0]
    LD1D     Z11.D, P4/Z, [Z18.D, #0]
    ADD  X6, X6, X2, LSR #0
    ST4D    { Z8.D, Z9.D, Z10.D, Z11.D }, P1, [X6, #0, MUL VL]
    DUP     Z18.D, X6
    ST1B     Z27.D, P1, [Z18.D, #0]
    LD1SB    Z29.D, P2/Z, [Z18.D, #0]
    ADD  X6, X6, X2, LSR #0
    ST4D    { Z5.D, Z6.D, Z7.D, Z8.D }, P0, [X6, #0, MUL VL]
    DUP     Z18.D, X6
    ST1H     Z17.D, P2, [Z18.D, #0]
    LD1SH    Z30.D, P3/Z, [Z18.D, #0]
    ADD  X6, X6, X2
    ST4D    { Z10.D, Z11.D, Z12.D, Z13.D }, P1, [X6, #0, MUL VL]
    DUP     Z18.D, X6
    ST1W     Z5.D, P4, [Z18.D, #0]
    LD1SW    Z17.D, P1/Z, [Z18.D, #0]
    ADD  X6, X6, X2
    ST4D    { Z10.D, Z11.D, Z12.D, Z13.D }, P5, [X6, #0, MUL VL]
    DUP     Z18.D, X6
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X10, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X10, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X10, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X10, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X10, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X10, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X10, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X10, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X10, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X10, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X10, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X10, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X10, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X10, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X10, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X10, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MRS  X27, FPSR
    MOVZ  X10, #0x80, LSL #0
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V0.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D0
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V1.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D1
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V2.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D2
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V3.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D3
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V4.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D4
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V5.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D5
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V6.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D6
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V7.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D7
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D8
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V9.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D9
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V10.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D10
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V11.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D11
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V12.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D12
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V13.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D13
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V14.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D14
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V15.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D15
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V16.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D16
    MOVZ  X10, #0xa5a5, LSL #0
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V17.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D17
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V19.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D19
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V20.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D20
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V21.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D21
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V22.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D22
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D23
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V24.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D24
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V25.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D25
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V26.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D26
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V27.D[1]
    MOVZ  X10, #0xa5, LSL #0
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D27
    MOVZ  X10, #0xa5, LSL #0
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D28
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V29.D[1]
    MOVZ  X10, #0xffa5, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D29
    MOVZ  X10, #0xffa5, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V30.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D30
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, V31.D[1]
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FMOV  X27, D31
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    STR  X27, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X27, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P0, Z0.D
    FMOV  X27, D0
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5c5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FADDV   D1, P1, Z1.D
    FMOV  X27, D1
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5c5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FADDV   D2, P0, Z2.D
    FMOV  X27, D2
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FADDV   D3, P2, Z3.D
    FMOV  X27, D3
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5c5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FADDV   D4, P1, Z4.D
    FMOV  X27, D4
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5c5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FADDV   D5, P3, Z5.D
    FMOV  X27, D5
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5c5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FADDV   D6, P5, Z6.D
    FMOV  X27, D6
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5c5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FADDV   D7, P3, Z7.D
    FMOV  X27, D7
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5c5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FADDV   D8, P4, Z8.D
    FMOV  X27, D8
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5c5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FADDV   D9, P5, Z9.D
    FMOV  X27, D9
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5c5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FADDV   D10, P5, Z10.D
    FMOV  X27, D10
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5c5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FADDV   D11, P6, Z11.D
    FMOV  X27, D11
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FADDV   D12, P0, Z12.D
    FMOV  X27, D12
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5c5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FADDV   D13, P7, Z13.D
    FMOV  X27, D13
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5c5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FADDV   D14, P4, Z14.D
    FMOV  X27, D14
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5c5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FADDV   D15, P1, Z15.D
    FMOV  X27, D15
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5c5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FADDV   D16, P2, Z16.D
    FMOV  X27, D16
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FADDV   D17, P7, Z17.D
    FMOV  X27, D17
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7ff8, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FADDV   D19, P3, Z19.D
    FMOV  X27, D19
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5c5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FADDV   D20, P4, Z20.D
    FMOV  X27, D20
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5c5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FADDV   D21, P6, Z21.D
    FMOV  X27, D21
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5c5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FADDV   D22, P0, Z22.D
    FMOV  X27, D22
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5c5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FADDV   D23, P1, Z23.D
    FMOV  X27, D23
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5c5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FADDV   D24, P2, Z24.D
    FMOV  X27, D24
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5c5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FADDV   D25, P6, Z25.D
    FMOV  X27, D25
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5c5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FADDV   D26, P1, Z26.D
    FMOV  X27, D26
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5c5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FADDV   D27, P0, Z27.D
    FMOV  X27, D27
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FADDV   D28, P4, Z28.D
    FMOV  X27, D28
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5c5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FADDV   D29, P7, Z29.D
    FMOV  X27, D29
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7ff8, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FADDV   D30, P2, Z30.D
    FMOV  X27, D30
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7ff8, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    FADDV   D31, P0, Z31.D
    FMOV  X27, D31
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5c5, LSL #48
    SUB  X3, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
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
    DUP     Z0.D, X28
    DUP     Z1.D, X29
    DUP     Z2.D, X23
    DUP     Z3.D, X27
    DUP     Z4.D, X23
    DUP     Z5.D, X26
    DUP     Z6.D, X11
    DUP     Z7.D, X9
    DUP     Z8.D, X7
    DUP     Z9.D, X29
    DUP     Z10.D, X16
    DUP     Z11.D, X16
    DUP     Z12.D, X12
    DUP     Z13.D, X23
    DUP     Z14.D, X6
    DUP     Z15.D, X2
    DUP     Z16.D, X5
    DUP     Z17.D, X23
    DUP     Z18.D, X25
    DUP     Z19.D, X13
    DUP     Z20.D, X12
    DUP     Z21.D, X14
    DUP     Z22.D, X5
    DUP     Z23.D, X10
    DUP     Z24.D, X4
    DUP     Z25.D, X15
    DUP     Z26.D, X28
    DUP     Z27.D, X8
    DUP     Z28.D, X17
    DUP     Z29.D, X6
    DUP     Z30.D, X23
    DUP     Z31.D, X29
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X17, #0x1000, LSL #0
    ADD  X4, X30, X17, ASR #0
    MOVZ  X9, #0x80, LSL #0
    ST4D    { Z27.D, Z28.D, Z29.D, Z30.D }, P3, [X4, #0, MUL VL]
    DUP     Z7.D, X4
    ST1B     Z0.D, P5, [Z7.D, #0]
    LD1B     Z9.D, P4/Z, [Z7.D, #0]
    ADD  X4, X4, X9
    ST4D    { Z1.D, Z2.D, Z3.D, Z4.D }, P3, [X4, #0, MUL VL]
    DUP     Z7.D, X4
    ST1H     Z9.D, P5, [Z7.D, #0]
    LD1H     Z13.D, P2/Z, [Z7.D, #0]
    ADD  X4, X4, X9
    ST4D    { Z2.D, Z3.D, Z4.D, Z5.D }, P7, [X4, #0, MUL VL]
    DUP     Z7.D, X4
    ST1W     Z10.D, P0, [Z7.D, #0]
    LD1W     Z20.D, P6/Z, [Z7.D, #0]
    ADD  X4, X4, X9
    ST4D    { Z1.D, Z2.D, Z3.D, Z4.D }, P2, [X4, #0, MUL VL]
    DUP     Z7.D, X4
    ST1D     Z2.D, P3, [Z7.D, #0]
    LD1D     Z31.D, P0/Z, [Z7.D, #0]
    ADD  X4, X4, X9, ASR #0
    ST4D    { Z11.D, Z12.D, Z13.D, Z14.D }, P2, [X4, #0, MUL VL]
    DUP     Z7.D, X4
    ST1B     Z17.D, P1, [Z7.D, #0]
    LD1SB    Z12.D, P3/Z, [Z7.D, #0]
    ADD  X4, X4, X9
    ST4D    { Z21.D, Z22.D, Z23.D, Z24.D }, P6, [X4, #0, MUL VL]
    DUP     Z7.D, X4
    ST1H     Z1.D, P5, [Z7.D, #0]
    LD1SH    Z21.D, P6/Z, [Z7.D, #0]
    ADD  X4, X4, X9, LSR #0
    ST4D    { Z0.D, Z1.D, Z2.D, Z3.D }, P3, [X4, #0, MUL VL]
    DUP     Z7.D, X4
    ST1W     Z10.D, P3, [Z7.D, #0]
    LD1SW    Z17.D, P7/Z, [Z7.D, #0]
    ADD  X4, X4, X9, ASR #0
    ST4D    { Z14.D, Z15.D, Z16.D, Z17.D }, P0, [X4, #0, MUL VL]
    DUP     Z7.D, X4
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MRS  X14, FPSR
    MOVZ  X12, #0x80, LSL #0
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V0.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D0
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V1.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D1
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D2
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D3
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D4
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D5
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D6
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D8
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X12, #0x5a, LSL #0
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D9
    MOVZ  X12, #0x5a, LSL #0
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D10
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D11
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X12, #0x5a, LSL #0
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D12
    MOVZ  X12, #0x5a, LSL #0
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X12, #0x5a, LSL #0
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D13
    MOVZ  X12, #0x5a, LSL #0
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V14.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D14
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D15
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D16
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D17
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D18
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D19
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D20
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D21
    MOVZ  X12, #0x5a5a, LSL #0
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D22
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D23
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D24
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D25
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D26
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D27
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D28
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D29
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V30.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D30
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, V31.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FMOV  X14, D31
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P6, Z0.D
    FMOV  X14, D0
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FADDV   D1, P5, Z1.D
    FMOV  X14, D1
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FADDV   D2, P6, Z2.D
    FMOV  X14, D2
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FADDV   D3, P7, Z3.D
    FMOV  X14, D3
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FADDV   D4, P4, Z4.D
    FMOV  X14, D4
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FADDV   D5, P7, Z5.D
    FMOV  X14, D5
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FADDV   D6, P3, Z6.D
    FMOV  X14, D6
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FADDV   D8, P5, Z8.D
    FMOV  X14, D8
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FADDV   D9, P6, Z9.D
    FMOV  X14, D9
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FADDV   D10, P7, Z10.D
    FMOV  X14, D10
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FADDV   D11, P3, Z11.D
    FMOV  X14, D11
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FADDV   D12, P4, Z12.D
    FMOV  X14, D12
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FADDV   D13, P5, Z13.D
    FMOV  X14, D13
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FADDV   D14, P4, Z14.D
    FMOV  X14, D14
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FADDV   D15, P5, Z15.D
    FMOV  X14, D15
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FADDV   D16, P1, Z16.D
    FMOV  X14, D16
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FADDV   D17, P4, Z17.D
    FMOV  X14, D17
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FADDV   D18, P5, Z18.D
    FMOV  X14, D18
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FADDV   D19, P7, Z19.D
    FMOV  X14, D19
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FADDV   D20, P2, Z20.D
    FMOV  X14, D20
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FADDV   D21, P4, Z21.D
    FMOV  X14, D21
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FADDV   D22, P6, Z22.D
    FMOV  X14, D22
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FADDV   D23, P0, Z23.D
    FMOV  X14, D23
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FADDV   D24, P7, Z24.D
    FMOV  X14, D24
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FADDV   D25, P7, Z25.D
    FMOV  X14, D25
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FADDV   D26, P0, Z26.D
    FMOV  X14, D26
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FADDV   D27, P2, Z27.D
    FMOV  X14, D27
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FADDV   D28, P1, Z28.D
    FMOV  X14, D28
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FADDV   D29, P1, Z29.D
    FMOV  X14, D29
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FADDV   D30, P2, Z30.D
    FMOV  X14, D30
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
    FADDV   D31, P0, Z31.D
    FMOV  X14, D31
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X8, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, SveLoadStoreP04_TestFail
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
    DUP     Z0.D, X26
    DUP     Z1.D, X7
    DUP     Z2.D, X28
    DUP     Z3.D, X29
    DUP     Z4.D, X27
    DUP     Z5.D, X14
    DUP     Z6.D, X9
    DUP     Z7.D, X12
    DUP     Z8.D, X16
    DUP     Z9.D, X3
    DUP     Z10.D, X5
    DUP     Z11.D, X5
    DUP     Z12.D, X17
    DUP     Z13.D, X13
    DUP     Z14.D, X2
    DUP     Z15.D, X4
    DUP     Z16.D, X29
    DUP     Z17.D, X3
    DUP     Z18.D, X11
    DUP     Z19.D, X5
    DUP     Z20.D, X2
    DUP     Z21.D, X10
    DUP     Z22.D, X5
    DUP     Z23.D, X23
    DUP     Z24.D, X27
    DUP     Z25.D, X14
    DUP     Z26.D, X11
    DUP     Z27.D, X5
    DUP     Z28.D, X6
    DUP     Z29.D, X27
    DUP     Z30.D, X9
    DUP     Z31.D, X9
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X9, #0x1200, LSL #0
    ADD  X14, X30, X9, LSR #0
    MOVZ  X12, #0x80, LSL #0
    ST4D    { Z8.D, Z9.D, Z10.D, Z11.D }, P2, [X14, #0, MUL VL]
    DUP     Z23.D, X14
    ST1B     Z19.D, P0, [Z23.D, #0]
    LD1B     Z2.D, P7/Z, [Z23.D, #0]
    ADD  X14, X14, X12, LSR #0
    ST4D    { Z14.D, Z15.D, Z16.D, Z17.D }, P5, [X14, #0, MUL VL]
    DUP     Z23.D, X14
    ST1H     Z2.D, P3, [Z23.D, #0]
    LD1H     Z19.D, P0/Z, [Z23.D, #0]
    ADD  X14, X14, X12, ASR #0
    ST4D    { Z3.D, Z4.D, Z5.D, Z6.D }, P5, [X14, #0, MUL VL]
    DUP     Z23.D, X14
    ST1W     Z19.D, P2, [Z23.D, #0]
    LD1W     Z11.D, P0/Z, [Z23.D, #0]
    ADD  X14, X14, X12
    ST4D    { Z11.D, Z12.D, Z13.D, Z14.D }, P1, [X14, #0, MUL VL]
    DUP     Z23.D, X14
    ST1D     Z0.D, P5, [Z23.D, #0]
    LD1D     Z16.D, P1/Z, [Z23.D, #0]
    ADD  X14, X14, X12, ASR #0
    ST4D    { Z16.D, Z17.D, Z18.D, Z19.D }, P5, [X14, #0, MUL VL]
    DUP     Z23.D, X14
    ST1B     Z29.D, P5, [Z23.D, #0]
    LD1SB    Z31.D, P1/Z, [Z23.D, #0]
    ADD  X14, X14, X12
    ST4D    { Z28.D, Z29.D, Z30.D, Z31.D }, P1, [X14, #0, MUL VL]
    DUP     Z23.D, X14
    ST1H     Z16.D, P2, [Z23.D, #0]
    LD1SH    Z20.D, P0/Z, [Z23.D, #0]
    ADD  X14, X14, X12, LSR #0
    ST4D    { Z16.D, Z17.D, Z18.D, Z19.D }, P2, [X14, #0, MUL VL]
    DUP     Z23.D, X14
    ST1W     Z15.D, P4, [Z23.D, #0]
    LD1SW    Z29.D, P7/Z, [Z23.D, #0]
    ADD  X14, X14, X12, LSR #0
    ST4D    { Z28.D, Z29.D, Z30.D, Z31.D }, P0, [X14, #0, MUL VL]
    DUP     Z23.D, X14
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X24, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X24, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X24, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X24, X26, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X24, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X24, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X24, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X24, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X24, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X24, X26, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X24, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X24, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X24, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X24, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X24, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X24, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X24, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MRS  X26, FPSR
    MOVZ  X24, #0x80, LSL #0
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V0.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D0
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V1.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D1
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X24, #0xa5, LSL #0
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D2
    MOVZ  X24, #0xa5, LSL #0
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D3
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D4
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D5
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D6
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D7
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D8
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D9
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D10
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V11.D[1]
    MOVZ  X24, #0xa5, LSL #0
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D11
    MOVZ  X24, #0xa5, LSL #0
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D12
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D13
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D14
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D15
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D16
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D17
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D18
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X24, #0xa5, LSL #0
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D19
    MOVZ  X24, #0xa5, LSL #0
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D20
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D21
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D22
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D24
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D25
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V26.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D26
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D27
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D28
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D29
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V30.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D30
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, V31.D[1]
    MOVZ  X24, #0xffa5, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FMOV  X26, D31
    MOVZ  X24, #0xffa5, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    STR  X26, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X26, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    STR  X26, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X26, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    STR  X26, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X26, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    STR  X26, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X26, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    STR  X26, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X26, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    STR  X26, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X26, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    STR  X26, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X26, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    STR  X26, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X26, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    STR  X26, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X26, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    STR  X26, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X26, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    STR  X26, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X26, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    STR  X26, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X26, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    STR  X26, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X26, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    STR  X26, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X26, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    STR  X26, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X26, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    STR  X26, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X26, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P6, Z0.D
    FMOV  X26, D0
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5c5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FADDV   D1, P7, Z1.D
    FMOV  X26, D1
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5c5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FADDV   D2, P7, Z2.D
    FMOV  X26, D2
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FADDV   D3, P0, Z3.D
    FMOV  X26, D3
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5c5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FADDV   D4, P5, Z4.D
    FMOV  X26, D4
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5c5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FADDV   D5, P5, Z5.D
    FMOV  X26, D5
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5c5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FADDV   D6, P0, Z6.D
    FMOV  X26, D6
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5c5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FADDV   D7, P7, Z7.D
    FMOV  X26, D7
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5c5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FADDV   D8, P6, Z8.D
    FMOV  X26, D8
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5c5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FADDV   D9, P3, Z9.D
    FMOV  X26, D9
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5c5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FADDV   D10, P6, Z10.D
    FMOV  X26, D10
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5c5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FADDV   D11, P0, Z11.D
    FMOV  X26, D11
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FADDV   D12, P4, Z12.D
    FMOV  X26, D12
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5c5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FADDV   D13, P6, Z13.D
    FMOV  X26, D13
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5c5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FADDV   D14, P5, Z14.D
    FMOV  X26, D14
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5c5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FADDV   D15, P3, Z15.D
    FMOV  X26, D15
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5c5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FADDV   D16, P6, Z16.D
    FMOV  X26, D16
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5c5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FADDV   D17, P2, Z17.D
    FMOV  X26, D17
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5c5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FADDV   D18, P1, Z18.D
    FMOV  X26, D18
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5c5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FADDV   D19, P4, Z19.D
    FMOV  X26, D19
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FADDV   D20, P6, Z20.D
    FMOV  X26, D20
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x7ff8, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FADDV   D21, P3, Z21.D
    FMOV  X26, D21
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5c5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FADDV   D22, P5, Z22.D
    FMOV  X26, D22
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5c5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FADDV   D24, P1, Z24.D
    FMOV  X26, D24
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5c5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FADDV   D25, P5, Z25.D
    FMOV  X26, D25
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5c5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FADDV   D26, P4, Z26.D
    FMOV  X26, D26
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5c5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FADDV   D27, P5, Z27.D
    FMOV  X26, D27
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5c5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FADDV   D28, P3, Z28.D
    FMOV  X26, D28
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5c5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FADDV   D29, P4, Z29.D
    FMOV  X26, D29
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x7ff8, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FADDV   D30, P5, Z30.D
    FMOV  X26, D30
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5c5, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
    FADDV   D31, P1, Z31.D
    FMOV  X26, D31
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x7ff8, LSL #48
    SUB  X28, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, SveLoadStoreP04_TestFail
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
    DUP     Z0.D, X28
    DUP     Z1.D, X26
    DUP     Z2.D, X29
    DUP     Z3.D, X24
    DUP     Z4.D, X15
    DUP     Z5.D, X27
    DUP     Z6.D, X2
    DUP     Z7.D, X4
    DUP     Z8.D, X3
    DUP     Z9.D, X14
    DUP     Z10.D, X11
    DUP     Z11.D, X28
    DUP     Z12.D, X3
    DUP     Z13.D, X27
    DUP     Z14.D, X15
    DUP     Z15.D, X28
    DUP     Z16.D, X16
    DUP     Z17.D, X2
    DUP     Z18.D, X23
    DUP     Z19.D, X7
    DUP     Z20.D, X8
    DUP     Z21.D, X15
    DUP     Z22.D, X16
    DUP     Z23.D, X10
    DUP     Z24.D, X23
    DUP     Z25.D, X5
    DUP     Z26.D, X23
    DUP     Z27.D, X12
    DUP     Z28.D, X5
    DUP     Z29.D, X9
    DUP     Z30.D, X11
    DUP     Z31.D, X29
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X28, #0x0, LSL #0
    ADD  X3, X30, X28, LSR #0
    MOVZ  X4, #0x80, LSL #0
    ST4D    { Z31.D, Z0.D, Z1.D, Z2.D }, P2, [X3, #0, MUL VL]
    DUP     Z22.D, X3
    ST1B     Z7.D, P5, [Z22.D, #0]
    LD1B     Z18.D, P3/Z, [Z22.D, #0]
    ADD  X3, X3, X4
    ST4D    { Z16.D, Z17.D, Z18.D, Z19.D }, P6, [X3, #0, MUL VL]
    DUP     Z22.D, X3
    ST1H     Z19.D, P3, [Z22.D, #0]
    LD1H     Z6.D, P6/Z, [Z22.D, #0]
    ADD  X3, X3, X4, ASR #0
    ST4D    { Z23.D, Z24.D, Z25.D, Z26.D }, P7, [X3, #0, MUL VL]
    DUP     Z22.D, X3
    ST1W     Z26.D, P3, [Z22.D, #0]
    LD1W     Z16.D, P6/Z, [Z22.D, #0]
    ADD  X3, X3, X4, ASR #0
    ST4D    { Z28.D, Z29.D, Z30.D, Z31.D }, P4, [X3, #0, MUL VL]
    DUP     Z22.D, X3
    ST1D     Z9.D, P7, [Z22.D, #0]
    LD1D     Z14.D, P6/Z, [Z22.D, #0]
    ADD  X3, X3, X4, LSR #0
    ST4D    { Z29.D, Z30.D, Z31.D, Z0.D }, P1, [X3, #0, MUL VL]
    DUP     Z22.D, X3
    ST1B     Z18.D, P4, [Z22.D, #0]
    LD1SB    Z18.D, P3/Z, [Z22.D, #0]
    ADD  X3, X3, X4
    ST4D    { Z11.D, Z12.D, Z13.D, Z14.D }, P7, [X3, #0, MUL VL]
    DUP     Z22.D, X3
    ST1H     Z28.D, P7, [Z22.D, #0]
    LD1SH    Z5.D, P3/Z, [Z22.D, #0]
    ADD  X3, X3, X4
    ST4D    { Z10.D, Z11.D, Z12.D, Z13.D }, P3, [X3, #0, MUL VL]
    DUP     Z22.D, X3
    ST1W     Z8.D, P4, [Z22.D, #0]
    LD1SW    Z29.D, P5/Z, [Z22.D, #0]
    ADD  X3, X3, X4, ASR #0
    ST4D    { Z23.D, Z24.D, Z25.D, Z26.D }, P5, [X3, #0, MUL VL]
    DUP     Z22.D, X3
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X7, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X7, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X7, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X7, X14, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X7, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X7, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X7, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X7, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X7, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X7, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X7, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X7, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X7, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X7, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X7, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X7, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, SveLoadStoreP04_TestFail
    MRS  X14, FPSR
    MOVZ  X7, #0x80, LSL #0
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V0.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D0
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V1.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D1
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D2
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D3
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D4
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D5
    MOVZ  X7, #0x5a5a, LSL #0
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D6
    MOVZ  X7, #0x5a5a, LSL #0
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D7
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D8
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D9
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D10
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D11
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D12
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D13
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V14.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D14
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D15
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D16
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D17
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X7, #0x5a, LSL #0
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D18
    MOVZ  X7, #0x5a, LSL #0
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D19
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D20
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D21
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D23
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D24
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D25
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D26
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D27
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D28
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D29
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V30.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D30
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, V31.D[1]
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X14, D31
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P7, Z0.D
    FMOV  X14, D0
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a7a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D1, P5, Z1.D
    FMOV  X14, D1
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a7a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D2, P6, Z2.D
    FMOV  X14, D2
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a7a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D3, P2, Z3.D
    FMOV  X14, D3
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a7a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D4, P5, Z4.D
    FMOV  X14, D4
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a7a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D5, P5, Z5.D
    FMOV  X14, D5
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D6, P6, Z6.D
    FMOV  X14, D6
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D7, P0, Z7.D
    FMOV  X14, D7
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a7a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D8, P6, Z8.D
    FMOV  X14, D8
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a7a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D9, P4, Z9.D
    FMOV  X14, D9
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a7a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D10, P6, Z10.D
    FMOV  X14, D10
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a7a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D11, P4, Z11.D
    FMOV  X14, D11
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a7a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D12, P0, Z12.D
    FMOV  X14, D12
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a7a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D13, P4, Z13.D
    FMOV  X14, D13
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a7a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D14, P6, Z14.D
    FMOV  X14, D14
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a7a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D15, P5, Z15.D
    FMOV  X14, D15
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a7a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D16, P2, Z16.D
    FMOV  X14, D16
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D17, P3, Z17.D
    FMOV  X14, D17
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a7a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D18, P4, Z18.D
    FMOV  X14, D18
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D19, P6, Z19.D
    FMOV  X14, D19
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a7a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D20, P0, Z20.D
    FMOV  X14, D20
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a7a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D21, P6, Z21.D
    FMOV  X14, D21
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a7a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D23, P0, Z23.D
    FMOV  X14, D23
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a7a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D24, P6, Z24.D
    FMOV  X14, D24
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a7a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D25, P2, Z25.D
    FMOV  X14, D25
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a7a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D26, P3, Z26.D
    FMOV  X14, D26
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a7a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D27, P2, Z27.D
    FMOV  X14, D27
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a7a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D28, P0, Z28.D
    FMOV  X14, D28
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a7a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D29, P6, Z29.D
    FMOV  X14, D29
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D30, P1, Z30.D
    FMOV  X14, D30
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a7a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D31, P4, Z31.D
    FMOV  X14, D31
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a7a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
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
    DUP     Z0.D, X8
    DUP     Z1.D, X25
    DUP     Z2.D, X29
    DUP     Z3.D, X27
    DUP     Z4.D, X14
    DUP     Z5.D, X26
    DUP     Z6.D, X28
    DUP     Z7.D, X5
    DUP     Z8.D, X17
    DUP     Z9.D, X11
    DUP     Z10.D, X2
    DUP     Z11.D, X4
    DUP     Z12.D, X25
    DUP     Z13.D, X24
    DUP     Z14.D, X3
    DUP     Z15.D, X14
    DUP     Z16.D, X27
    DUP     Z17.D, X23
    DUP     Z18.D, X2
    DUP     Z19.D, X26
    DUP     Z20.D, X26
    DUP     Z21.D, X24
    DUP     Z22.D, X28
    DUP     Z23.D, X2
    DUP     Z24.D, X26
    DUP     Z25.D, X3
    DUP     Z26.D, X24
    DUP     Z27.D, X11
    DUP     Z28.D, X29
    DUP     Z29.D, X16
    DUP     Z30.D, X29
    DUP     Z31.D, X23
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X6, #0x200, LSL #0
    ADD  X15, X30, X6
    MOVZ  X9, #0x80, LSL #0
    ST4D    { Z27.D, Z28.D, Z29.D, Z30.D }, P6, [X15, #0, MUL VL]
    DUP     Z21.D, X15
    ST1B     Z22.D, P3, [Z21.D, #0]
    LD1B     Z28.D, P5/Z, [Z21.D, #0]
    ADD  X15, X15, X9
    ST4D    { Z25.D, Z26.D, Z27.D, Z28.D }, P2, [X15, #0, MUL VL]
    DUP     Z21.D, X15
    ST1H     Z12.D, P1, [Z21.D, #0]
    LD1H     Z9.D, P3/Z, [Z21.D, #0]
    ADD  X15, X15, X9, LSR #0
    ST4D    { Z8.D, Z9.D, Z10.D, Z11.D }, P1, [X15, #0, MUL VL]
    DUP     Z21.D, X15
    ST1W     Z28.D, P6, [Z21.D, #0]
    LD1W     Z10.D, P5/Z, [Z21.D, #0]
    ADD  X15, X15, X9
    ST4D    { Z5.D, Z6.D, Z7.D, Z8.D }, P4, [X15, #0, MUL VL]
    DUP     Z21.D, X15
    ST1D     Z19.D, P2, [Z21.D, #0]
    LD1D     Z30.D, P2/Z, [Z21.D, #0]
    ADD  X15, X15, X9
    ST4D    { Z10.D, Z11.D, Z12.D, Z13.D }, P7, [X15, #0, MUL VL]
    DUP     Z21.D, X15
    ST1B     Z29.D, P6, [Z21.D, #0]
    LD1SB    Z28.D, P6/Z, [Z21.D, #0]
    ADD  X15, X15, X9, ASR #0
    ST4D    { Z5.D, Z6.D, Z7.D, Z8.D }, P0, [X15, #0, MUL VL]
    DUP     Z21.D, X15
    ST1H     Z6.D, P0, [Z21.D, #0]
    LD1SH    Z8.D, P5/Z, [Z21.D, #0]
    ADD  X15, X15, X9, LSR #0
    ST4D    { Z31.D, Z0.D, Z1.D, Z2.D }, P6, [X15, #0, MUL VL]
    DUP     Z21.D, X15
    ST1W     Z2.D, P1, [Z21.D, #0]
    LD1SW    Z2.D, P5/Z, [Z21.D, #0]
    ADD  X15, X15, X9
    ST4D    { Z5.D, Z6.D, Z7.D, Z8.D }, P2, [X15, #0, MUL VL]
    DUP     Z21.D, X15
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X16, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, SveLoadStoreP04_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X16, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, SveLoadStoreP04_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X16, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, SveLoadStoreP04_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X16, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, SveLoadStoreP04_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X16, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, SveLoadStoreP04_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X16, X7, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, SveLoadStoreP04_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X16, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, SveLoadStoreP04_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X16, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, SveLoadStoreP04_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X16, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, SveLoadStoreP04_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X16, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, SveLoadStoreP04_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X16, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, SveLoadStoreP04_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X16, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, SveLoadStoreP04_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, SveLoadStoreP04_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X16, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, SveLoadStoreP04_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X16, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, SveLoadStoreP04_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X16, X7, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, SveLoadStoreP04_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X16, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, SveLoadStoreP04_TestFail
    MRS  X7, FPSR
    MOVZ  X16, #0x80, LSL #0
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V0.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D0
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V1.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D1
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V2.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D2
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D3
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D4
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D5
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D6
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V7.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D7
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D8
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V9.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D9
    MOVZ  X16, #0xa5a5, LSL #0
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X16, #0xa5, LSL #0
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D10
    MOVZ  X16, #0xa5, LSL #0
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D11
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D12
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D13
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D14
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D15
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V16.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D16
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V17.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D17
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V18.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D18
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D19
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D20
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V22.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D22
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V23.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D23
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V24.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D24
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D25
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V26.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D26
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D27
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X16, #0xffa5, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D28
    MOVZ  X16, #0xffa5, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D29
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V30.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D30
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, V31.D[1]
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FMOV  X7, D31
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    STR  X7, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X7, [X0, #0]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P0, Z0.D
    FMOV  X7, D0
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5c5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FADDV   D1, P5, Z1.D
    FMOV  X7, D1
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5c5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FADDV   D2, P4, Z2.D
    FMOV  X7, D2
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7ff8, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FADDV   D3, P2, Z3.D
    FMOV  X7, D3
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5c5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FADDV   D4, P3, Z4.D
    FMOV  X7, D4
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5c5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FADDV   D5, P0, Z5.D
    FMOV  X7, D5
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5c5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FADDV   D6, P4, Z6.D
    FMOV  X7, D6
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5c5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FADDV   D7, P6, Z7.D
    FMOV  X7, D7
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5c5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FADDV   D8, P7, Z8.D
    FMOV  X7, D8
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7ff8, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FADDV   D9, P7, Z9.D
    FMOV  X7, D9
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FADDV   D10, P2, Z10.D
    FMOV  X7, D10
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FADDV   D11, P2, Z11.D
    FMOV  X7, D11
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5c5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FADDV   D12, P6, Z12.D
    FMOV  X7, D12
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5c5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FADDV   D13, P5, Z13.D
    FMOV  X7, D13
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5c5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FADDV   D14, P3, Z14.D
    FMOV  X7, D14
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5c5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FADDV   D15, P1, Z15.D
    FMOV  X7, D15
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5c5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FADDV   D16, P2, Z16.D
    FMOV  X7, D16
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5c5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FADDV   D17, P7, Z17.D
    FMOV  X7, D17
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5c5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FADDV   D18, P6, Z18.D
    FMOV  X7, D18
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5c5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FADDV   D19, P6, Z19.D
    FMOV  X7, D19
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5c5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FADDV   D20, P6, Z20.D
    FMOV  X7, D20
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5c5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FADDV   D22, P3, Z22.D
    FMOV  X7, D22
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5c5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FADDV   D23, P3, Z23.D
    FMOV  X7, D23
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5c5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FADDV   D24, P6, Z24.D
    FMOV  X7, D24
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5c5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FADDV   D25, P3, Z25.D
    FMOV  X7, D25
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5c5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FADDV   D26, P5, Z26.D
    FMOV  X7, D26
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5c5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FADDV   D27, P0, Z27.D
    FMOV  X7, D27
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5c5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FADDV   D28, P5, Z28.D
    FMOV  X7, D28
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7ff8, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FADDV   D29, P7, Z29.D
    FMOV  X7, D29
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5c5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FADDV   D30, P7, Z30.D
    FMOV  X7, D30
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5c5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
    FADDV   D31, P4, Z31.D
    FMOV  X7, D31
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5c5, LSL #48
    SUB  X2, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, SveLoadStoreP04_TestFail
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
    DUP     Z0.D, X25
    DUP     Z1.D, X26
    DUP     Z2.D, X27
    DUP     Z3.D, X6
    DUP     Z4.D, X29
    DUP     Z5.D, X29
    DUP     Z6.D, X28
    DUP     Z7.D, X5
    DUP     Z8.D, X2
    DUP     Z9.D, X15
    DUP     Z10.D, X29
    DUP     Z11.D, X8
    DUP     Z12.D, X24
    DUP     Z13.D, X29
    DUP     Z14.D, X17
    DUP     Z15.D, X14
    DUP     Z16.D, X9
    DUP     Z17.D, X26
    DUP     Z18.D, X29
    DUP     Z19.D, X24
    DUP     Z20.D, X9
    DUP     Z21.D, X10
    DUP     Z22.D, X28
    DUP     Z23.D, X23
    DUP     Z24.D, X23
    DUP     Z25.D, X10
    DUP     Z26.D, X29
    DUP     Z27.D, X28
    DUP     Z28.D, X5
    DUP     Z29.D, X10
    DUP     Z30.D, X29
    DUP     Z31.D, X29
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X2, #0x400, LSL #0
    ADD  X5, X30, X2
    MOVZ  X13, #0x80, LSL #0
    ST4D    { Z28.D, Z29.D, Z30.D, Z31.D }, P2, [X5, #0, MUL VL]
    DUP     Z30.D, X5
    ST1B     Z20.D, P6, [Z30.D, #0]
    LD1B     Z8.D, P0/Z, [Z30.D, #0]
    ADD  X5, X5, X13, LSR #0
    ST4D    { Z4.D, Z5.D, Z6.D, Z7.D }, P4, [X5, #0, MUL VL]
    DUP     Z30.D, X5
    ST1H     Z13.D, P0, [Z30.D, #0]
    LD1H     Z0.D, P4/Z, [Z30.D, #0]
    ADD  X5, X5, X13, LSR #0
    ST4D    { Z11.D, Z12.D, Z13.D, Z14.D }, P6, [X5, #0, MUL VL]
    DUP     Z30.D, X5
    ST1W     Z16.D, P1, [Z30.D, #0]
    LD1W     Z7.D, P0/Z, [Z30.D, #0]
    ADD  X5, X5, X13, ASR #0
    ST4D    { Z6.D, Z7.D, Z8.D, Z9.D }, P5, [X5, #0, MUL VL]
    DUP     Z30.D, X5
    ST1D     Z29.D, P3, [Z30.D, #0]
    LD1D     Z27.D, P2/Z, [Z30.D, #0]
    ADD  X5, X5, X13, ASR #0
    ST4D    { Z17.D, Z18.D, Z19.D, Z20.D }, P5, [X5, #0, MUL VL]
    DUP     Z30.D, X5
    ST1B     Z21.D, P7, [Z30.D, #0]
    LD1SB    Z31.D, P6/Z, [Z30.D, #0]
    ADD  X5, X5, X13, ASR #0
    ST4D    { Z12.D, Z13.D, Z14.D, Z15.D }, P1, [X5, #0, MUL VL]
    DUP     Z30.D, X5
    ST1H     Z7.D, P4, [Z30.D, #0]
    LD1SH    Z16.D, P3/Z, [Z30.D, #0]
    ADD  X5, X5, X13, LSR #0
    ST4D    { Z17.D, Z18.D, Z19.D, Z20.D }, P5, [X5, #0, MUL VL]
    DUP     Z30.D, X5
    ST1W     Z25.D, P2, [Z30.D, #0]
    LD1SW    Z15.D, P1/Z, [Z30.D, #0]
    ADD  X5, X5, X13
    ST4D    { Z9.D, Z10.D, Z11.D, Z12.D }, P2, [X5, #0, MUL VL]
    DUP     Z30.D, X5
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X12, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MRS  X14, FPSR
    MOVZ  X12, #0x80, LSL #0
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V0.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D0
    MOVZ  X12, #0x5a5a, LSL #0
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V1.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D1
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D2
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D3
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D4
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D5
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D6
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D7
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X12, #0x5a, LSL #0
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D8
    MOVZ  X12, #0x5a, LSL #0
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D9
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D10
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D11
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D12
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D13
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V14.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D14
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D15
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D16
    MOVZ  X12, #0x5a5a, LSL #0
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D17
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D18
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D19
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D20
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D21
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D22
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D23
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D24
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D25
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D26
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D27
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D28
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D29
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, V31.D[1]
    MOVZ  X12, #0x5a, LSL #0
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FMOV  X14, D31
    MOVZ  X12, #0x5a, LSL #0
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P0, Z0.D
    FMOV  X14, D0
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FADDV   D1, P6, Z1.D
    FMOV  X14, D1
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FADDV   D2, P7, Z2.D
    FMOV  X14, D2
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FADDV   D3, P5, Z3.D
    FMOV  X14, D3
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FADDV   D4, P7, Z4.D
    FMOV  X14, D4
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FADDV   D5, P5, Z5.D
    FMOV  X14, D5
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FADDV   D6, P7, Z6.D
    FMOV  X14, D6
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FADDV   D7, P5, Z7.D
    FMOV  X14, D7
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FADDV   D8, P6, Z8.D
    FMOV  X14, D8
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FADDV   D9, P0, Z9.D
    FMOV  X14, D9
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FADDV   D10, P4, Z10.D
    FMOV  X14, D10
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FADDV   D11, P0, Z11.D
    FMOV  X14, D11
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FADDV   D12, P4, Z12.D
    FMOV  X14, D12
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FADDV   D13, P5, Z13.D
    FMOV  X14, D13
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FADDV   D14, P3, Z14.D
    FMOV  X14, D14
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FADDV   D15, P6, Z15.D
    FMOV  X14, D15
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FADDV   D16, P2, Z16.D
    FMOV  X14, D16
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FADDV   D17, P2, Z17.D
    FMOV  X14, D17
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FADDV   D18, P4, Z18.D
    FMOV  X14, D18
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FADDV   D19, P6, Z19.D
    FMOV  X14, D19
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FADDV   D20, P6, Z20.D
    FMOV  X14, D20
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FADDV   D21, P3, Z21.D
    FMOV  X14, D21
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FADDV   D22, P3, Z22.D
    FMOV  X14, D22
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FADDV   D23, P7, Z23.D
    FMOV  X14, D23
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FADDV   D24, P2, Z24.D
    FMOV  X14, D24
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FADDV   D25, P6, Z25.D
    FMOV  X14, D25
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FADDV   D26, P2, Z26.D
    FMOV  X14, D26
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FADDV   D27, P0, Z27.D
    FMOV  X14, D27
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FADDV   D28, P7, Z28.D
    FMOV  X14, D28
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FADDV   D29, P2, Z29.D
    FMOV  X14, D29
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a7a, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    FADDV   D31, P7, Z31.D
    FMOV  X14, D31
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
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
    DUP     Z0.D, X24
    DUP     Z1.D, X3
    DUP     Z2.D, X29
    DUP     Z3.D, X26
    DUP     Z4.D, X27
    DUP     Z5.D, X28
    DUP     Z6.D, X28
    DUP     Z7.D, X28
    DUP     Z8.D, X9
    DUP     Z9.D, X13
    DUP     Z10.D, X17
    DUP     Z11.D, X14
    DUP     Z12.D, X28
    DUP     Z13.D, X26
    DUP     Z14.D, X5
    DUP     Z15.D, X8
    DUP     Z16.D, X11
    DUP     Z17.D, X6
    DUP     Z18.D, X28
    DUP     Z19.D, X15
    DUP     Z20.D, X2
    DUP     Z21.D, X26
    DUP     Z22.D, X8
    DUP     Z23.D, X3
    DUP     Z24.D, X16
    DUP     Z25.D, X9
    DUP     Z26.D, X16
    DUP     Z27.D, X7
    DUP     Z28.D, X13
    DUP     Z29.D, X24
    DUP     Z30.D, X6
    DUP     Z31.D, X4
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X25, #0x600, LSL #0
    ADD  X12, X30, X25, LSR #0
    MOVZ  X3, #0x80, LSL #0
    ST4D    { Z17.D, Z18.D, Z19.D, Z20.D }, P6, [X12, #0, MUL VL]
    DUP     Z3.D, X12
    ST1B     Z17.D, P4, [Z3.D, #0]
    LD1B     Z15.D, P2/Z, [Z3.D, #0]
    ADD  X12, X12, X3
    ST4D    { Z18.D, Z19.D, Z20.D, Z21.D }, P5, [X12, #0, MUL VL]
    DUP     Z3.D, X12
    ST1H     Z15.D, P1, [Z3.D, #0]
    LD1H     Z22.D, P6/Z, [Z3.D, #0]
    ADD  X12, X12, X3, ASR #0
    ST4D    { Z29.D, Z30.D, Z31.D, Z0.D }, P3, [X12, #0, MUL VL]
    DUP     Z3.D, X12
    ST1W     Z9.D, P5, [Z3.D, #0]
    LD1W     Z20.D, P2/Z, [Z3.D, #0]
    ADD  X12, X12, X3, ASR #0
    ST4D    { Z6.D, Z7.D, Z8.D, Z9.D }, P6, [X12, #0, MUL VL]
    DUP     Z3.D, X12
    ST1D     Z16.D, P3, [Z3.D, #0]
    LD1D     Z12.D, P1/Z, [Z3.D, #0]
    ADD  X12, X12, X3, LSR #0
    ST4D    { Z13.D, Z14.D, Z15.D, Z16.D }, P1, [X12, #0, MUL VL]
    DUP     Z3.D, X12
    ST1B     Z31.D, P3, [Z3.D, #0]
    LD1SB    Z31.D, P0/Z, [Z3.D, #0]
    ADD  X12, X12, X3
    ST4D    { Z14.D, Z15.D, Z16.D, Z17.D }, P6, [X12, #0, MUL VL]
    DUP     Z3.D, X12
    ST1H     Z20.D, P7, [Z3.D, #0]
    LD1SH    Z8.D, P7/Z, [Z3.D, #0]
    ADD  X12, X12, X3, LSR #0
    ST4D    { Z20.D, Z21.D, Z22.D, Z23.D }, P2, [X12, #0, MUL VL]
    DUP     Z3.D, X12
    ST1W     Z1.D, P1, [Z3.D, #0]
    LD1SW    Z20.D, P2/Z, [Z3.D, #0]
    ADD  X12, X12, X3
    ST4D    { Z28.D, Z29.D, Z30.D, Z31.D }, P1, [X12, #0, MUL VL]
    DUP     Z3.D, X12
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MRS  X2, FPSR
    MOVZ  X23, #0x80, LSL #0
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V0.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D0
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V1.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D1
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V2.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D2
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D4
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D5
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V6.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D6
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D7
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D8
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D9
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D10
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D11
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V12.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D12
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D13
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D14
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V15.D[1]
    MOVZ  X23, #0xa5, LSL #0
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D15
    MOVZ  X23, #0xa5, LSL #0
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D16
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D17
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D18
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D19
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D20
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D21
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X23, #0xa5, LSL #0
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D22
    MOVZ  X23, #0xa5, LSL #0
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D23
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D24
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D25
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D26
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D27
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D28
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D29
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V30.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D30
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, V31.D[1]
    MOVZ  X23, #0xffa5, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FMOV  X2, D31
    MOVZ  X23, #0xffa5, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P3, Z0.D
    FMOV  X2, D0
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D1, P2, Z1.D
    FMOV  X2, D1
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D2, P3, Z2.D
    FMOV  X2, D2
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D4, P3, Z4.D
    FMOV  X2, D4
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D5, P7, Z5.D
    FMOV  X2, D5
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D6, P1, Z6.D
    FMOV  X2, D6
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D7, P7, Z7.D
    FMOV  X2, D7
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D8, P5, Z8.D
    FMOV  X2, D8
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7ff8, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D9, P1, Z9.D
    FMOV  X2, D9
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D10, P0, Z10.D
    FMOV  X2, D10
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D11, P4, Z11.D
    FMOV  X2, D11
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D12, P6, Z12.D
    FMOV  X2, D12
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D13, P5, Z13.D
    FMOV  X2, D13
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D14, P0, Z14.D
    FMOV  X2, D14
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D15, P6, Z15.D
    FMOV  X2, D15
    MOVZ  X23, #0x0, LSL #0
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D16, P1, Z16.D
    FMOV  X2, D16
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D17, P3, Z17.D
    FMOV  X2, D17
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D18, P1, Z18.D
    FMOV  X2, D18
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D19, P6, Z19.D
    FMOV  X2, D19
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D20, P6, Z20.D
    FMOV  X2, D20
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7ff8, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D21, P5, Z21.D
    FMOV  X2, D21
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D22, P5, Z22.D
    FMOV  X2, D22
    MOVZ  X23, #0x0, LSL #0
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D23, P3, Z23.D
    FMOV  X2, D23
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D24, P4, Z24.D
    FMOV  X2, D24
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D25, P0, Z25.D
    FMOV  X2, D25
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D26, P1, Z26.D
    FMOV  X2, D26
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D27, P3, Z27.D
    FMOV  X2, D27
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D28, P2, Z28.D
    FMOV  X2, D28
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D29, P4, Z29.D
    FMOV  X2, D29
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D30, P6, Z30.D
    FMOV  X2, D30
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    FADDV   D31, P5, Z31.D
    FMOV  X2, D31
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7ff8, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
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
    DUP     Z0.D, X27
    DUP     Z1.D, X26
    DUP     Z2.D, X29
    DUP     Z3.D, X25
    DUP     Z4.D, X28
    DUP     Z5.D, X14
    DUP     Z6.D, X8
    DUP     Z7.D, X4
    DUP     Z8.D, X28
    DUP     Z9.D, X15
    DUP     Z10.D, X23
    DUP     Z11.D, X12
    DUP     Z12.D, X24
    DUP     Z13.D, X7
    DUP     Z14.D, X5
    DUP     Z15.D, X16
    DUP     Z16.D, X6
    DUP     Z17.D, X29
    DUP     Z18.D, X11
    DUP     Z19.D, X29
    DUP     Z20.D, X24
    DUP     Z21.D, X4
    DUP     Z22.D, X2
    DUP     Z23.D, X4
    DUP     Z24.D, X27
    DUP     Z25.D, X24
    DUP     Z26.D, X13
    DUP     Z27.D, X7
    DUP     Z28.D, X8
    DUP     Z29.D, X4
    DUP     Z30.D, X29
    DUP     Z31.D, X3
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X14, #0x800, LSL #0
    ADD  X9, X30, X14
    MOVZ  X29, #0x80, LSL #0
    ST4D    { Z17.D, Z18.D, Z19.D, Z20.D }, P2, [X9, #0, MUL VL]
    DUP     Z28.D, X9
    ST1B     Z0.D, P3, [Z28.D, #0]
    LD1B     Z26.D, P6/Z, [Z28.D, #0]
    ADD  X9, X9, X29, ASR #0
    ST4D    { Z6.D, Z7.D, Z8.D, Z9.D }, P2, [X9, #0, MUL VL]
    DUP     Z28.D, X9
    ST1H     Z16.D, P7, [Z28.D, #0]
    LD1H     Z16.D, P0/Z, [Z28.D, #0]
    ADD  X9, X9, X29, LSR #0
    ST4D    { Z20.D, Z21.D, Z22.D, Z23.D }, P0, [X9, #0, MUL VL]
    DUP     Z28.D, X9
    ST1W     Z6.D, P6, [Z28.D, #0]
    LD1W     Z9.D, P7/Z, [Z28.D, #0]
    ADD  X9, X9, X29, ASR #0
    ST4D    { Z17.D, Z18.D, Z19.D, Z20.D }, P7, [X9, #0, MUL VL]
    DUP     Z28.D, X9
    ST1D     Z15.D, P6, [Z28.D, #0]
    LD1D     Z1.D, P2/Z, [Z28.D, #0]
    ADD  X9, X9, X29, LSR #0
    ST4D    { Z11.D, Z12.D, Z13.D, Z14.D }, P4, [X9, #0, MUL VL]
    DUP     Z28.D, X9
    ST1B     Z21.D, P3, [Z28.D, #0]
    LD1SB    Z6.D, P0/Z, [Z28.D, #0]
    ADD  X9, X9, X29, ASR #0
    ST4D    { Z29.D, Z30.D, Z31.D, Z0.D }, P6, [X9, #0, MUL VL]
    DUP     Z28.D, X9
    ST1H     Z26.D, P3, [Z28.D, #0]
    LD1SH    Z3.D, P2/Z, [Z28.D, #0]
    ADD  X9, X9, X29, LSR #0
    ST4D    { Z0.D, Z1.D, Z2.D, Z3.D }, P7, [X9, #0, MUL VL]
    DUP     Z28.D, X9
    ST1W     Z2.D, P1, [Z28.D, #0]
    LD1SW    Z11.D, P0/Z, [Z28.D, #0]
    ADD  X9, X9, X29, ASR #0
    ST4D    { Z4.D, Z5.D, Z6.D, Z7.D }, P3, [X9, #0, MUL VL]
    DUP     Z28.D, X9
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X24, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X24, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X24, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X24, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X24, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X24, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X24, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X24, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X24, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X24, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X24, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X24, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X24, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X24, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X24, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X24, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X24, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, SveLoadStoreP04_TestFail
    MRS  X2, FPSR
    MOVZ  X24, #0x80, LSL #0
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V0.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D0
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V1.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D1
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V2.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D2
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X24, #0x5a, LSL #0
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D3
    MOVZ  X24, #0x5a, LSL #0
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D4
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D5
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V6.D[1]
    MOVZ  X24, #0x5a, LSL #0
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D6
    MOVZ  X24, #0x5a, LSL #0
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D7
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D8
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D9
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D10
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D11
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V12.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D12
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D13
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D14
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V15.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D15
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D16
    MOVZ  X24, #0x5a5a, LSL #0
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D17
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D18
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D19
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D20
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D21
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D22
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D23
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D24
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D25
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X24, #0x5a, LSL #0
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D26
    MOVZ  X24, #0x5a, LSL #0
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D27
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D29
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V30.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D30
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, V31.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FMOV  X2, D31
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P0, Z0.D
    FMOV  X2, D0
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a7a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D1, P4, Z1.D
    FMOV  X2, D1
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a7a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D2, P1, Z2.D
    FMOV  X2, D2
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a7a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D3, P6, Z3.D
    FMOV  X2, D3
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D4, P1, Z4.D
    FMOV  X2, D4
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a7a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D5, P4, Z5.D
    FMOV  X2, D5
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a7a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D6, P0, Z6.D
    FMOV  X2, D6
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D7, P5, Z7.D
    FMOV  X2, D7
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a7a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D8, P1, Z8.D
    FMOV  X2, D8
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a7a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D9, P4, Z9.D
    FMOV  X2, D9
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D10, P1, Z10.D
    FMOV  X2, D10
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a7a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D11, P3, Z11.D
    FMOV  X2, D11
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D12, P0, Z12.D
    FMOV  X2, D12
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a7a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D13, P6, Z13.D
    FMOV  X2, D13
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a7a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D14, P2, Z14.D
    FMOV  X2, D14
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a7a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D15, P4, Z15.D
    FMOV  X2, D15
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a7a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D16, P7, Z16.D
    FMOV  X2, D16
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D17, P3, Z17.D
    FMOV  X2, D17
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a7a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D18, P0, Z18.D
    FMOV  X2, D18
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a7a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D19, P1, Z19.D
    FMOV  X2, D19
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a7a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D20, P3, Z20.D
    FMOV  X2, D20
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a7a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D21, P0, Z21.D
    FMOV  X2, D21
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a7a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D22, P1, Z22.D
    FMOV  X2, D22
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a7a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D23, P4, Z23.D
    FMOV  X2, D23
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a7a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D24, P3, Z24.D
    FMOV  X2, D24
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a7a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D25, P6, Z25.D
    FMOV  X2, D25
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a7a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D26, P1, Z26.D
    FMOV  X2, D26
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D27, P6, Z27.D
    FMOV  X2, D27
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a7a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D29, P6, Z29.D
    FMOV  X2, D29
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a7a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D30, P4, Z30.D
    FMOV  X2, D30
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a7a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
    FADDV   D31, P2, Z31.D
    FMOV  X2, D31
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a7a, LSL #48
    SUB  X15, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, SveLoadStoreP04_TestFail
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
    DUP     Z0.D, X26
    DUP     Z1.D, X29
    DUP     Z2.D, X15
    DUP     Z3.D, X28
    DUP     Z4.D, X27
    DUP     Z5.D, X4
    DUP     Z6.D, X26
    DUP     Z7.D, X6
    DUP     Z8.D, X28
    DUP     Z9.D, X25
    DUP     Z10.D, X24
    DUP     Z11.D, X27
    DUP     Z12.D, X29
    DUP     Z13.D, X3
    DUP     Z14.D, X6
    DUP     Z15.D, X27
    DUP     Z16.D, X27
    DUP     Z17.D, X3
    DUP     Z18.D, X4
    DUP     Z19.D, X8
    DUP     Z20.D, X3
    DUP     Z21.D, X16
    DUP     Z22.D, X25
    DUP     Z23.D, X26
    DUP     Z24.D, X5
    DUP     Z25.D, X13
    DUP     Z26.D, X29
    DUP     Z27.D, X9
    DUP     Z28.D, X15
    DUP     Z29.D, X28
    DUP     Z30.D, X7
    DUP     Z31.D, X15
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X27, #0xa00, LSL #0
    ADD  X5, X30, X27, ASR #0
    MOVZ  X26, #0x80, LSL #0
    ST4D    { Z19.D, Z20.D, Z21.D, Z22.D }, P5, [X5, #0, MUL VL]
    DUP     Z22.D, X5
    ST1B     Z19.D, P7, [Z22.D, #0]
    LD1B     Z6.D, P1/Z, [Z22.D, #0]
    ADD  X5, X5, X26, LSR #0
    ST4D    { Z10.D, Z11.D, Z12.D, Z13.D }, P4, [X5, #0, MUL VL]
    DUP     Z22.D, X5
    ST1H     Z15.D, P7, [Z22.D, #0]
    LD1H     Z23.D, P6/Z, [Z22.D, #0]
    ADD  X5, X5, X26, ASR #0
    ST4D    { Z15.D, Z16.D, Z17.D, Z18.D }, P0, [X5, #0, MUL VL]
    DUP     Z22.D, X5
    ST1W     Z12.D, P4, [Z22.D, #0]
    LD1W     Z14.D, P0/Z, [Z22.D, #0]
    ADD  X5, X5, X26, ASR #0
    ST4D    { Z11.D, Z12.D, Z13.D, Z14.D }, P5, [X5, #0, MUL VL]
    DUP     Z22.D, X5
    ST1D     Z30.D, P1, [Z22.D, #0]
    LD1D     Z11.D, P3/Z, [Z22.D, #0]
    ADD  X5, X5, X26, ASR #0
    ST4D    { Z18.D, Z19.D, Z20.D, Z21.D }, P7, [X5, #0, MUL VL]
    DUP     Z22.D, X5
    ST1B     Z11.D, P2, [Z22.D, #0]
    LD1SB    Z26.D, P5/Z, [Z22.D, #0]
    ADD  X5, X5, X26, ASR #0
    ST4D    { Z5.D, Z6.D, Z7.D, Z8.D }, P2, [X5, #0, MUL VL]
    DUP     Z22.D, X5
    ST1H     Z9.D, P2, [Z22.D, #0]
    LD1SH    Z5.D, P1/Z, [Z22.D, #0]
    ADD  X5, X5, X26, LSR #0
    ST4D    { Z6.D, Z7.D, Z8.D, Z9.D }, P2, [X5, #0, MUL VL]
    DUP     Z22.D, X5
    ST1W     Z5.D, P1, [Z22.D, #0]
    LD1SW    Z0.D, P1/Z, [Z22.D, #0]
    ADD  X5, X5, X26, ASR #0
    ST4D    { Z25.D, Z26.D, Z27.D, Z28.D }, P6, [X5, #0, MUL VL]
    DUP     Z22.D, X5
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, SveLoadStoreP04_TestFail
    MRS  X9, FPSR
    MOVZ  X12, #0x80, LSL #0
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V0.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D0
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V1.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D1
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D2
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D3
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D4
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V5.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D5
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X12, #0xa5, LSL #0
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D6
    MOVZ  X12, #0xa5, LSL #0
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V7.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D7
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D8
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V9.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D9
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D10
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V11.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D11
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V12.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D12
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V13.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D13
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D14
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D15
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D16
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V17.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D17
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V18.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D18
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V19.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D19
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V20.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D20
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D21
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D23
    MOVZ  X12, #0xa5a5, LSL #0
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V24.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D24
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D25
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X12, #0xffa5, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D26
    MOVZ  X12, #0xffa5, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V27.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D27
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V28.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D28
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D29
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V30.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D30
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, V31.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X9, D31
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    STR  X9, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X9, [X0, #0]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P1, Z0.D
    FMOV  X9, D0
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x7ff8, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D1, P6, Z1.D
    FMOV  X9, D1
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5c5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D2, P3, Z2.D
    FMOV  X9, D2
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5c5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D3, P5, Z3.D
    FMOV  X9, D3
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5c5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D4, P1, Z4.D
    FMOV  X9, D4
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5c5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D5, P4, Z5.D
    FMOV  X9, D5
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x7ff8, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D6, P0, Z6.D
    FMOV  X9, D6
    MOVZ  X12, #0x0, LSL #0
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D7, P0, Z7.D
    FMOV  X9, D7
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5c5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D8, P1, Z8.D
    FMOV  X9, D8
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5c5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D9, P7, Z9.D
    FMOV  X9, D9
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5c5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D10, P1, Z10.D
    FMOV  X9, D10
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5c5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D11, P6, Z11.D
    FMOV  X9, D11
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5c5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D12, P7, Z12.D
    FMOV  X9, D12
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5c5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D13, P5, Z13.D
    FMOV  X9, D13
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5c5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D14, P3, Z14.D
    FMOV  X9, D14
    MOVZ  X12, #0x0, LSL #0
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D15, P1, Z15.D
    FMOV  X9, D15
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5c5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D16, P2, Z16.D
    FMOV  X9, D16
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5c5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D17, P5, Z17.D
    FMOV  X9, D17
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5c5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D18, P2, Z18.D
    FMOV  X9, D18
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5c5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D19, P0, Z19.D
    FMOV  X9, D19
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5c5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D20, P0, Z20.D
    FMOV  X9, D20
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5c5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D21, P4, Z21.D
    FMOV  X9, D21
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5c5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D23, P7, Z23.D
    FMOV  X9, D23
    MOVZ  X12, #0x0, LSL #0
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D24, P5, Z24.D
    FMOV  X9, D24
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5c5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D25, P2, Z25.D
    FMOV  X9, D25
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5c5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D26, P3, Z26.D
    FMOV  X9, D26
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x7ff8, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D27, P2, Z27.D
    FMOV  X9, D27
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5c5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D28, P4, Z28.D
    FMOV  X9, D28
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5c5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D29, P3, Z29.D
    FMOV  X9, D29
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5c5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D30, P1, Z30.D
    FMOV  X9, D30
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5c5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D31, P1, Z31.D
    FMOV  X9, D31
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5c5, LSL #48
    SUB  X14, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
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
    DUP     Z0.D, X7
    DUP     Z1.D, X13
    DUP     Z2.D, X26
    DUP     Z3.D, X15
    DUP     Z4.D, X27
    DUP     Z5.D, X28
    DUP     Z6.D, X29
    DUP     Z7.D, X16
    DUP     Z8.D, X5
    DUP     Z9.D, X3
    DUP     Z10.D, X6
    DUP     Z11.D, X4
    DUP     Z12.D, X3
    DUP     Z13.D, X12
    DUP     Z14.D, X26
    DUP     Z15.D, X24
    DUP     Z16.D, X16
    DUP     Z17.D, X10
    DUP     Z18.D, X7
    DUP     Z19.D, X13
    DUP     Z20.D, X25
    DUP     Z21.D, X3
    DUP     Z22.D, X7
    DUP     Z23.D, X23
    DUP     Z24.D, X14
    DUP     Z25.D, X11
    DUP     Z26.D, X29
    DUP     Z27.D, X5
    DUP     Z28.D, X14
    DUP     Z29.D, X5
    DUP     Z30.D, X23
    DUP     Z31.D, X12
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X28, #0xc00, LSL #0
    ADD  X5, X30, X28
    MOVZ  X17, #0x80, LSL #0
    ST4D    { Z6.D, Z7.D, Z8.D, Z9.D }, P1, [X5, #0, MUL VL]
    DUP     Z11.D, X5
    ST1B     Z0.D, P4, [Z11.D, #0]
    LD1B     Z24.D, P6/Z, [Z11.D, #0]
    ADD  X5, X5, X17, LSR #0
    ST4D    { Z26.D, Z27.D, Z28.D, Z29.D }, P2, [X5, #0, MUL VL]
    DUP     Z11.D, X5
    ST1H     Z9.D, P3, [Z11.D, #0]
    LD1H     Z17.D, P2/Z, [Z11.D, #0]
    ADD  X5, X5, X17, ASR #0
    ST4D    { Z25.D, Z26.D, Z27.D, Z28.D }, P4, [X5, #0, MUL VL]
    DUP     Z11.D, X5
    ST1W     Z0.D, P0, [Z11.D, #0]
    LD1W     Z31.D, P0/Z, [Z11.D, #0]
    ADD  X5, X5, X17, LSR #0
    ST4D    { Z3.D, Z4.D, Z5.D, Z6.D }, P5, [X5, #0, MUL VL]
    DUP     Z11.D, X5
    ST1D     Z24.D, P4, [Z11.D, #0]
    LD1D     Z9.D, P1/Z, [Z11.D, #0]
    ADD  X5, X5, X17, ASR #0
    ST4D    { Z27.D, Z28.D, Z29.D, Z30.D }, P5, [X5, #0, MUL VL]
    DUP     Z11.D, X5
    ST1B     Z13.D, P1, [Z11.D, #0]
    LD1SB    Z30.D, P2/Z, [Z11.D, #0]
    ADD  X5, X5, X17
    ST4D    { Z28.D, Z29.D, Z30.D, Z31.D }, P6, [X5, #0, MUL VL]
    DUP     Z11.D, X5
    ST1H     Z17.D, P0, [Z11.D, #0]
    LD1SH    Z21.D, P1/Z, [Z11.D, #0]
    ADD  X5, X5, X17, ASR #0
    ST4D    { Z16.D, Z17.D, Z18.D, Z19.D }, P2, [X5, #0, MUL VL]
    DUP     Z11.D, X5
    ST1W     Z9.D, P0, [Z11.D, #0]
    LD1SW    Z3.D, P1/Z, [Z11.D, #0]
    ADD  X5, X5, X17, LSR #0
    ST4D    { Z5.D, Z6.D, Z7.D, Z8.D }, P0, [X5, #0, MUL VL]
    DUP     Z11.D, X5
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X10, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X10, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X10, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X10, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X10, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X10, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X10, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X10, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X10, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X10, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X10, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X10, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X10, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X10, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X10, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X10, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X10, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X10, SveLoadStoreP04_TestFail
    MRS  X23, FPSR
    MOVZ  X10, #0x80, LSL #0
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V0.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D0
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V1.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D1
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D2
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X10, #0x5a, LSL #0
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D3
    MOVZ  X10, #0x5a, LSL #0
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D4
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D5
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D6
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D7
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D8
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X10, #0x5a, LSL #0
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D9
    MOVZ  X10, #0x5a, LSL #0
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D10
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D12
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D13
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D14
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D15
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D16
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D17
    MOVZ  X10, #0x5a5a, LSL #0
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D18
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D19
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D20
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D21
    MOVZ  X10, #0x5a5a, LSL #0
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D22
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V23.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D23
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X10, #0x5a, LSL #0
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D24
    MOVZ  X10, #0x5a, LSL #0
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D25
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D26
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D27
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D28
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D29
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V30.D[1]
    MOVZ  X10, #0x5a, LSL #0
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D30
    MOVZ  X10, #0x5a, LSL #0
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, V31.D[1]
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FMOV  X23, D31
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    STR  X23, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X23, [X0, #0]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P1, Z0.D
    FMOV  X23, D0
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D1, P5, Z1.D
    FMOV  X23, D1
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D2, P1, Z2.D
    FMOV  X23, D2
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D3, P2, Z3.D
    FMOV  X23, D3
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D4, P0, Z4.D
    FMOV  X23, D4
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D5, P1, Z5.D
    FMOV  X23, D5
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D6, P2, Z6.D
    FMOV  X23, D6
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D7, P3, Z7.D
    FMOV  X23, D7
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D8, P3, Z8.D
    FMOV  X23, D8
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D9, P6, Z9.D
    FMOV  X23, D9
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D10, P5, Z10.D
    FMOV  X23, D10
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D12, P0, Z12.D
    FMOV  X23, D12
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D13, P4, Z13.D
    FMOV  X23, D13
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D14, P2, Z14.D
    FMOV  X23, D14
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D15, P0, Z15.D
    FMOV  X23, D15
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D16, P2, Z16.D
    FMOV  X23, D16
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D17, P4, Z17.D
    FMOV  X23, D17
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D18, P2, Z18.D
    FMOV  X23, D18
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D19, P6, Z19.D
    FMOV  X23, D19
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D20, P6, Z20.D
    FMOV  X23, D20
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D21, P1, Z21.D
    FMOV  X23, D21
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D22, P3, Z22.D
    FMOV  X23, D22
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D23, P4, Z23.D
    FMOV  X23, D23
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D24, P1, Z24.D
    FMOV  X23, D24
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D25, P5, Z25.D
    FMOV  X23, D25
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D26, P1, Z26.D
    FMOV  X23, D26
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D27, P1, Z27.D
    FMOV  X23, D27
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D28, P0, Z28.D
    FMOV  X23, D28
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D29, P2, Z29.D
    FMOV  X23, D29
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a7a, LSL #48
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D30, P5, Z30.D
    FMOV  X23, D30
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
    FADDV   D31, P0, Z31.D
    FMOV  X23, D31
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, SveLoadStoreP04_TestFail
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
    DUP     Z0.D, X29
    DUP     Z1.D, X13
    DUP     Z2.D, X28
    DUP     Z3.D, X12
    DUP     Z4.D, X27
    DUP     Z5.D, X26
    DUP     Z6.D, X6
    DUP     Z7.D, X4
    DUP     Z8.D, X13
    DUP     Z9.D, X17
    DUP     Z10.D, X24
    DUP     Z11.D, X12
    DUP     Z12.D, X8
    DUP     Z13.D, X13
    DUP     Z14.D, X28
    DUP     Z15.D, X25
    DUP     Z16.D, X10
    DUP     Z17.D, X28
    DUP     Z18.D, X9
    DUP     Z19.D, X28
    DUP     Z20.D, X28
    DUP     Z21.D, X23
    DUP     Z22.D, X13
    DUP     Z23.D, X23
    DUP     Z24.D, X27
    DUP     Z25.D, X29
    DUP     Z26.D, X16
    DUP     Z27.D, X10
    DUP     Z28.D, X9
    DUP     Z29.D, X15
    DUP     Z30.D, X14
    DUP     Z31.D, X5
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X23, #0xe00, LSL #0
    ADD  X10, X30, X23
    MOVZ  X26, #0x80, LSL #0
    ST4D    { Z8.D, Z9.D, Z10.D, Z11.D }, P6, [X10, #0, MUL VL]
    DUP     Z4.D, X10
    ST1B     Z22.D, P3, [Z4.D, #0]
    LD1B     Z14.D, P1/Z, [Z4.D, #0]
    ADD  X10, X10, X26, ASR #0
    ST4D    { Z31.D, Z0.D, Z1.D, Z2.D }, P5, [X10, #0, MUL VL]
    DUP     Z4.D, X10
    ST1H     Z1.D, P2, [Z4.D, #0]
    LD1H     Z23.D, P7/Z, [Z4.D, #0]
    ADD  X10, X10, X26, LSR #0
    ST4D    { Z21.D, Z22.D, Z23.D, Z24.D }, P5, [X10, #0, MUL VL]
    DUP     Z4.D, X10
    ST1W     Z25.D, P5, [Z4.D, #0]
    LD1W     Z28.D, P1/Z, [Z4.D, #0]
    ADD  X10, X10, X26
    ST4D    { Z31.D, Z0.D, Z1.D, Z2.D }, P7, [X10, #0, MUL VL]
    DUP     Z4.D, X10
    ST1D     Z0.D, P2, [Z4.D, #0]
    LD1D     Z28.D, P2/Z, [Z4.D, #0]
    ADD  X10, X10, X26, ASR #0
    ST4D    { Z27.D, Z28.D, Z29.D, Z30.D }, P6, [X10, #0, MUL VL]
    DUP     Z4.D, X10
    ST1B     Z25.D, P4, [Z4.D, #0]
    LD1SB    Z11.D, P5/Z, [Z4.D, #0]
    ADD  X10, X10, X26, LSR #0
    ST4D    { Z8.D, Z9.D, Z10.D, Z11.D }, P2, [X10, #0, MUL VL]
    DUP     Z4.D, X10
    ST1H     Z27.D, P5, [Z4.D, #0]
    LD1SH    Z1.D, P6/Z, [Z4.D, #0]
    ADD  X10, X10, X26, LSR #0
    ST4D    { Z17.D, Z18.D, Z19.D, Z20.D }, P1, [X10, #0, MUL VL]
    DUP     Z4.D, X10
    ST1W     Z5.D, P6, [Z4.D, #0]
    LD1SW    Z0.D, P7/Z, [Z4.D, #0]
    ADD  X10, X10, X26, LSR #0
    ST4D    { Z12.D, Z13.D, Z14.D, Z15.D }, P7, [X10, #0, MUL VL]
    DUP     Z4.D, X10
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X3, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X3, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X3, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X3, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X3, X14, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X3, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X3, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X3, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X3, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X3, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X3, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X3, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X3, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X3, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X3, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X3, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X3, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, SveLoadStoreP04_TestFail
    MRS  X14, FPSR
    MOVZ  X3, #0x80, LSL #0
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V0.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D0
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V1.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D1
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D2
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D3
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D5
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D6
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D7
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D8
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D9
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D10
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X3, #0xffa5, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D11
    MOVZ  X3, #0xffa5, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D12
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D13
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V14.D[1]
    MOVZ  X3, #0xa5, LSL #0
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D14
    MOVZ  X3, #0xa5, LSL #0
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D15
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D16
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D17
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D18
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D19
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D20
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D21
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D22
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D23
    MOVZ  X3, #0xa5a5, LSL #0
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D24
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D25
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D26
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D27
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D28
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D29
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V30.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D30
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, V31.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FMOV  X14, D31
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    STR  X14, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X14, [X0, #0]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P5, Z0.D
    FMOV  X14, D0
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x7ff8, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D1, P7, Z1.D
    FMOV  X14, D1
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x7ff8, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D2, P4, Z2.D
    FMOV  X14, D2
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5c5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D3, P2, Z3.D
    FMOV  X14, D3
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5c5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D5, P3, Z5.D
    FMOV  X14, D5
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5c5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D6, P7, Z6.D
    FMOV  X14, D6
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5c5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D7, P6, Z7.D
    FMOV  X14, D7
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5c5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D8, P6, Z8.D
    FMOV  X14, D8
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5c5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D9, P4, Z9.D
    FMOV  X14, D9
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5c5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D10, P3, Z10.D
    FMOV  X14, D10
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5c5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D11, P2, Z11.D
    FMOV  X14, D11
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x7ff8, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D12, P7, Z12.D
    FMOV  X14, D12
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5c5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D13, P2, Z13.D
    FMOV  X14, D13
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5c5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D14, P5, Z14.D
    FMOV  X14, D14
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D15, P7, Z15.D
    FMOV  X14, D15
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5c5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D16, P2, Z16.D
    FMOV  X14, D16
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5c5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D17, P2, Z17.D
    FMOV  X14, D17
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5c5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D18, P4, Z18.D
    FMOV  X14, D18
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5c5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D19, P6, Z19.D
    FMOV  X14, D19
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5c5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D20, P5, Z20.D
    FMOV  X14, D20
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5c5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D21, P0, Z21.D
    FMOV  X14, D21
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5c5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D22, P1, Z22.D
    FMOV  X14, D22
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5c5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D23, P7, Z23.D
    FMOV  X14, D23
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D24, P1, Z24.D
    FMOV  X14, D24
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5c5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D25, P6, Z25.D
    FMOV  X14, D25
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5c5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D26, P6, Z26.D
    FMOV  X14, D26
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5c5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D27, P6, Z27.D
    FMOV  X14, D27
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5c5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D28, P4, Z28.D
    FMOV  X14, D28
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5c5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D29, P4, Z29.D
    FMOV  X14, D29
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5c5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D30, P3, Z30.D
    FMOV  X14, D30
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5c5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
    FADDV   D31, P0, Z31.D
    FMOV  X14, D31
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5c5, LSL #48
    SUB  X5, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, SveLoadStoreP04_TestFail
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
    DUP     Z0.D, X26
    DUP     Z1.D, X28
    DUP     Z2.D, X26
    DUP     Z3.D, X17
    DUP     Z4.D, X23
    DUP     Z5.D, X29
    DUP     Z6.D, X27
    DUP     Z7.D, X24
    DUP     Z8.D, X28
    DUP     Z9.D, X17
    DUP     Z10.D, X2
    DUP     Z11.D, X27
    DUP     Z12.D, X10
    DUP     Z13.D, X8
    DUP     Z14.D, X10
    DUP     Z15.D, X2
    DUP     Z16.D, X7
    DUP     Z17.D, X6
    DUP     Z18.D, X5
    DUP     Z19.D, X6
    DUP     Z20.D, X26
    DUP     Z21.D, X2
    DUP     Z22.D, X10
    DUP     Z23.D, X3
    DUP     Z24.D, X2
    DUP     Z25.D, X9
    DUP     Z26.D, X7
    DUP     Z27.D, X4
    DUP     Z28.D, X16
    DUP     Z29.D, X12
    DUP     Z30.D, X26
    DUP     Z31.D, X15
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X23, #0x1000, LSL #0
    ADD  X12, X30, X23, ASR #0
    MOVZ  X7, #0x80, LSL #0
    ST4D    { Z12.D, Z13.D, Z14.D, Z15.D }, P0, [X12, #0, MUL VL]
    DUP     Z26.D, X12
    ST1B     Z28.D, P7, [Z26.D, #0]
    LD1B     Z5.D, P1/Z, [Z26.D, #0]
    ADD  X12, X12, X7
    ST4D    { Z1.D, Z2.D, Z3.D, Z4.D }, P6, [X12, #0, MUL VL]
    DUP     Z26.D, X12
    ST1H     Z5.D, P6, [Z26.D, #0]
    LD1H     Z23.D, P7/Z, [Z26.D, #0]
    ADD  X12, X12, X7, ASR #0
    ST4D    { Z6.D, Z7.D, Z8.D, Z9.D }, P3, [X12, #0, MUL VL]
    DUP     Z26.D, X12
    ST1W     Z12.D, P4, [Z26.D, #0]
    LD1W     Z10.D, P2/Z, [Z26.D, #0]
    ADD  X12, X12, X7
    ST4D    { Z13.D, Z14.D, Z15.D, Z16.D }, P7, [X12, #0, MUL VL]
    DUP     Z26.D, X12
    ST1D     Z31.D, P5, [Z26.D, #0]
    LD1D     Z7.D, P4/Z, [Z26.D, #0]
    ADD  X12, X12, X7
    ST4D    { Z4.D, Z5.D, Z6.D, Z7.D }, P1, [X12, #0, MUL VL]
    DUP     Z26.D, X12
    ST1B     Z24.D, P7, [Z26.D, #0]
    LD1SB    Z31.D, P7/Z, [Z26.D, #0]
    ADD  X12, X12, X7
    ST4D    { Z9.D, Z10.D, Z11.D, Z12.D }, P5, [X12, #0, MUL VL]
    DUP     Z26.D, X12
    ST1H     Z31.D, P6, [Z26.D, #0]
    LD1SH    Z10.D, P4/Z, [Z26.D, #0]
    ADD  X12, X12, X7, ASR #0
    ST4D    { Z17.D, Z18.D, Z19.D, Z20.D }, P1, [X12, #0, MUL VL]
    DUP     Z26.D, X12
    ST1W     Z31.D, P1, [Z26.D, #0]
    LD1SW    Z11.D, P6/Z, [Z26.D, #0]
    ADD  X12, X12, X7, ASR #0
    ST4D    { Z13.D, Z14.D, Z15.D, Z16.D }, P2, [X12, #0, MUL VL]
    DUP     Z26.D, X12
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X26, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X26, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X26, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X26, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X26, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X26, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X26, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X26, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X26, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X26, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X26, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X26, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X26, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X26, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X26, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X26, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X26, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X26, SveLoadStoreP04_TestFail
    MRS  X15, FPSR
    MOVZ  X26, #0x80, LSL #0
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V0.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D0
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V1.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D1
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V2.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D2
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V3.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D3
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V4.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D4
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V5.D[1]
    MOVZ  X26, #0x5a, LSL #0
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D5
    MOVZ  X26, #0x5a, LSL #0
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V6.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D6
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V7.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D7
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V8.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D8
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V9.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D9
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V10.D[1]
    MOVZ  X26, #0x5a, LSL #0
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D10
    MOVZ  X26, #0x5a, LSL #0
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V11.D[1]
    MOVZ  X26, #0x5a, LSL #0
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D11
    MOVZ  X26, #0x5a, LSL #0
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V12.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D12
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V13.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D13
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V14.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D14
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V15.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D15
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D16
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V17.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D17
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V18.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D18
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V19.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D19
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V20.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D20
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V21.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D21
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V22.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D22
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V23.D[1]
    MOVZ  X26, #0x5a, LSL #0
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D23
    MOVZ  X26, #0x5a, LSL #0
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V24.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D24
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V25.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D25
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V27.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D27
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V28.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D28
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V29.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D29
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V30.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D30
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, V31.D[1]
    MOVZ  X26, #0x5a, LSL #0
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FMOV  X15, D31
    MOVZ  X26, #0x5a, LSL #0
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    STR  X15, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X15, [X0, #0]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P5, Z0.D
    FMOV  X15, D0
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a7a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D1, P4, Z1.D
    FMOV  X15, D1
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a7a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D2, P6, Z2.D
    FMOV  X15, D2
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a7a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D3, P2, Z3.D
    FMOV  X15, D3
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a7a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D4, P2, Z4.D
    FMOV  X15, D4
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a7a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D5, P3, Z5.D
    FMOV  X15, D5
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D6, P6, Z6.D
    FMOV  X15, D6
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a7a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D7, P2, Z7.D
    FMOV  X15, D7
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a7a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D8, P2, Z8.D
    FMOV  X15, D8
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a7a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D9, P4, Z9.D
    FMOV  X15, D9
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a7a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D10, P3, Z10.D
    FMOV  X15, D10
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D11, P6, Z11.D
    FMOV  X15, D11
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D12, P5, Z12.D
    FMOV  X15, D12
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a7a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D13, P6, Z13.D
    FMOV  X15, D13
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a7a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D14, P1, Z14.D
    FMOV  X15, D14
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a7a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D15, P0, Z15.D
    FMOV  X15, D15
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a7a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D16, P3, Z16.D
    FMOV  X15, D16
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a7a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D17, P5, Z17.D
    FMOV  X15, D17
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a7a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D18, P7, Z18.D
    FMOV  X15, D18
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a7a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D19, P3, Z19.D
    FMOV  X15, D19
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a7a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D20, P0, Z20.D
    FMOV  X15, D20
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a7a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D21, P3, Z21.D
    FMOV  X15, D21
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a7a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D22, P0, Z22.D
    FMOV  X15, D22
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a7a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D23, P7, Z23.D
    FMOV  X15, D23
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D24, P3, Z24.D
    FMOV  X15, D24
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a7a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D25, P5, Z25.D
    FMOV  X15, D25
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a7a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D27, P0, Z27.D
    FMOV  X15, D27
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a7a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D28, P6, Z28.D
    FMOV  X15, D28
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a7a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D29, P1, Z29.D
    FMOV  X15, D29
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a7a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D30, P5, Z30.D
    FMOV  X15, D30
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a7a, LSL #48
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
    FADDV   D31, P1, Z31.D
    FMOV  X15, D31
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, SveLoadStoreP04_TestFail
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
    DUP     Z0.D, X27
    DUP     Z1.D, X11
    DUP     Z2.D, X29
    DUP     Z3.D, X3
    DUP     Z4.D, X28
    DUP     Z5.D, X26
    DUP     Z6.D, X16
    DUP     Z7.D, X15
    DUP     Z8.D, X15
    DUP     Z9.D, X29
    DUP     Z10.D, X28
    DUP     Z11.D, X13
    DUP     Z12.D, X10
    DUP     Z13.D, X14
    DUP     Z14.D, X25
    DUP     Z15.D, X2
    DUP     Z16.D, X9
    DUP     Z17.D, X28
    DUP     Z18.D, X3
    DUP     Z19.D, X29
    DUP     Z20.D, X8
    DUP     Z21.D, X7
    DUP     Z22.D, X14
    DUP     Z23.D, X5
    DUP     Z24.D, X2
    DUP     Z25.D, X5
    DUP     Z26.D, X28
    DUP     Z27.D, X28
    DUP     Z28.D, X28
    DUP     Z29.D, X29
    DUP     Z30.D, X9
    DUP     Z31.D, X26
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    MOVZ  X10, #0x1200, LSL #0
    ADD  X13, X30, X10, ASR #0
    MOVZ  X11, #0x80, LSL #0
    ST4D    { Z16.D, Z17.D, Z18.D, Z19.D }, P7, [X13, #0, MUL VL]
    DUP     Z9.D, X13
    ST1B     Z0.D, P4, [Z9.D, #0]
    LD1B     Z22.D, P4/Z, [Z9.D, #0]
    ADD  X13, X13, X11
    ST4D    { Z14.D, Z15.D, Z16.D, Z17.D }, P5, [X13, #0, MUL VL]
    DUP     Z9.D, X13
    ST1H     Z6.D, P1, [Z9.D, #0]
    LD1H     Z15.D, P3/Z, [Z9.D, #0]
    ADD  X13, X13, X11
    ST4D    { Z31.D, Z0.D, Z1.D, Z2.D }, P7, [X13, #0, MUL VL]
    DUP     Z9.D, X13
    ST1W     Z18.D, P3, [Z9.D, #0]
    LD1W     Z27.D, P3/Z, [Z9.D, #0]
    ADD  X13, X13, X11, LSR #0
    ST4D    { Z4.D, Z5.D, Z6.D, Z7.D }, P2, [X13, #0, MUL VL]
    DUP     Z9.D, X13
    ST1D     Z15.D, P5, [Z9.D, #0]
    LD1D     Z4.D, P1/Z, [Z9.D, #0]
    ADD  X13, X13, X11, LSR #0
    ST4D    { Z25.D, Z26.D, Z27.D, Z28.D }, P6, [X13, #0, MUL VL]
    DUP     Z9.D, X13
    ST1B     Z12.D, P4, [Z9.D, #0]
    LD1SB    Z27.D, P4/Z, [Z9.D, #0]
    ADD  X13, X13, X11
    ST4D    { Z29.D, Z30.D, Z31.D, Z0.D }, P4, [X13, #0, MUL VL]
    DUP     Z9.D, X13
    ST1H     Z7.D, P7, [Z9.D, #0]
    LD1SH    Z31.D, P1/Z, [Z9.D, #0]
    ADD  X13, X13, X11, LSR #0
    ST4D    { Z20.D, Z21.D, Z22.D, Z23.D }, P7, [X13, #0, MUL VL]
    DUP     Z9.D, X13
    ST1W     Z10.D, P1, [Z9.D, #0]
    LD1SW    Z5.D, P0/Z, [Z9.D, #0]
    ADD  X13, X13, X11, ASR #0
    ST4D    { Z27.D, Z28.D, Z29.D, Z30.D }, P5, [X13, #0, MUL VL]
    DUP     Z9.D, X13
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X23, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, SveLoadStoreP04_TestFail
    MRS  X2, FPSR
    MOVZ  X23, #0x80, LSL #0
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V0.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D0
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V1.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D1
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V2.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D2
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D3
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D4
    MOVZ  X23, #0xa5a5, LSL #0
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D5
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V6.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D6
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D7
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D8
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D10
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D11
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V12.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D12
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D13
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D14
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V15.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D15
    MOVZ  X23, #0xa5a5, LSL #0
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D16
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D17
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D18
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D19
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D20
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D21
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X23, #0xa5, LSL #0
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D22
    MOVZ  X23, #0xa5, LSL #0
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D23
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D24
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D25
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D26
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X23, #0xffa5, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D27
    MOVZ  X23, #0xffa5, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D28
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D29
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V30.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D30
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, V31.D[1]
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FMOV  X2, D31
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P0, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P1, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P2, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P3, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P4, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P5, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P6, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P7, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P8, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P9, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P10, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P11, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P12, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P13, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P14, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    STR  X2, [X0, #0]
    STR     P15, [X0, #0, MUL VL]
    LDR  X2, [X0, #0]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    PTRUE   P0.B, ALL
    PTRUE   P1.B, ALL
    PTRUE   P2.B, ALL
    PTRUE   P3.B, ALL
    PTRUE   P4.B, ALL
    PTRUE   P5.B, ALL
    PTRUE   P6.B, ALL
    PTRUE   P7.B, ALL
    PTRUE   P8.B, ALL
    PTRUE   P9.B, ALL
    PTRUE   P10.B, ALL
    PTRUE   P11.B, ALL
    PTRUE   P12.B, ALL
    PTRUE   P13.B, ALL
    PTRUE   P14.B, ALL
    PTRUE   P15.B, ALL
    FADDV   D0, P1, Z0.D
    FMOV  X2, D0
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FADDV   D1, P7, Z1.D
    FMOV  X2, D1
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FADDV   D2, P5, Z2.D
    FMOV  X2, D2
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FADDV   D3, P1, Z3.D
    FMOV  X2, D3
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FADDV   D4, P6, Z4.D
    FMOV  X2, D4
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FADDV   D5, P7, Z5.D
    FMOV  X2, D5
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7ff8, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FADDV   D6, P4, Z6.D
    FMOV  X2, D6
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FADDV   D7, P6, Z7.D
    FMOV  X2, D7
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FADDV   D8, P6, Z8.D
    FMOV  X2, D8
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FADDV   D10, P6, Z10.D
    FMOV  X2, D10
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FADDV   D11, P4, Z11.D
    FMOV  X2, D11
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FADDV   D12, P5, Z12.D
    FMOV  X2, D12
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FADDV   D13, P1, Z13.D
    FMOV  X2, D13
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FADDV   D14, P1, Z14.D
    FMOV  X2, D14
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FADDV   D15, P0, Z15.D
    FMOV  X2, D15
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FADDV   D16, P5, Z16.D
    FMOV  X2, D16
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FADDV   D17, P3, Z17.D
    FMOV  X2, D17
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FADDV   D18, P0, Z18.D
    FMOV  X2, D18
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FADDV   D19, P3, Z19.D
    FMOV  X2, D19
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FADDV   D20, P1, Z20.D
    FMOV  X2, D20
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FADDV   D21, P6, Z21.D
    FMOV  X2, D21
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FADDV   D22, P4, Z22.D
    FMOV  X2, D22
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FADDV   D23, P0, Z23.D
    FMOV  X2, D23
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FADDV   D24, P3, Z24.D
    FMOV  X2, D24
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FADDV   D25, P4, Z25.D
    FMOV  X2, D25
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FADDV   D26, P3, Z26.D
    FMOV  X2, D26
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FADDV   D27, P4, Z27.D
    FMOV  X2, D27
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7ff8, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FADDV   D28, P7, Z28.D
    FMOV  X2, D28
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FADDV   D29, P4, Z29.D
    FMOV  X2, D29
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FADDV   D30, P5, Z30.D
    FMOV  X2, D30
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5c5, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail
    FADDV   D31, P1, Z31.D
    FMOV  X2, D31
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7ff8, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, SveLoadStoreP04_TestFail

SveLoadStoreP04_TestEnd:
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
SveLoadStoreP04_TestFail:
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
