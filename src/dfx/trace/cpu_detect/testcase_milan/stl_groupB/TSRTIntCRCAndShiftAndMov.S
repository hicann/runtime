.global TSRTIntCRCAndShiftAndMov

.text
.p2align 4

TSRTIntCRCAndShiftAndMov:

TSRTIntCRCAndShiftAndMov_TestBegin:
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
    MOVZ  X2, #0x2285, LSL #0
    MOVK  X2, #0xa917, LSL #16
    MOVK  X2, #0x1989, LSL #32
    MOVK  X2, #0x61b1, LSL #48
    MOVZ  X3, #0xe0cc, LSL #0
    MOVK  X3, #0x9e94, LSL #16
    MOVK  X3, #0xc3c9, LSL #32
    MOVK  X3, #0xd8be, LSL #48
    MOVZ  X4, #0x4f2b, LSL #0
    MOVK  X4, #0xc223, LSL #16
    MOVK  X4, #0xba76, LSL #32
    MOVK  X4, #0x22f9, LSL #48
    MOVZ  X5, #0xb5fa, LSL #0
    MOVK  X5, #0x3b0c, LSL #16
    MOVK  X5, #0xe91e, LSL #32
    MOVK  X5, #0x1dba, LSL #48
    MOVZ  X7, #0xe402, LSL #0
    MOVK  X7, #0x6871, LSL #16
    MOVK  X7, #0x19fb, LSL #32
    MOVK  X7, #0x2eed, LSL #48
    MOVZ  X8, #0xdd17, LSL #0
    MOVK  X8, #0xeaf3, LSL #16
    MOVK  X8, #0xcd5e, LSL #32
    MOVK  X8, #0xda31, LSL #48
    MOVZ  X9, #0xf89a, LSL #0
    MOVK  X9, #0xbc10, LSL #16
    MOVK  X9, #0x8d99, LSL #32
    MOVK  X9, #0x1a66, LSL #48
    MOVZ  X10, #0x24f5, LSL #0
    MOVK  X10, #0x92cf, LSL #16
    MOVK  X10, #0x8701, LSL #32
    MOVK  X10, #0x5e5f, LSL #48
    MOVZ  X12, #0xc43a, LSL #0
    MOVK  X12, #0xbd02, LSL #16
    MOVK  X12, #0x5395, LSL #32
    MOVK  X12, #0xd9d5, LSL #48
    MOVZ  X13, #0x1922, LSL #0
    MOVK  X13, #0xd597, LSL #16
    MOVK  X13, #0x53c4, LSL #32
    MOVK  X13, #0x6e07, LSL #48
    MOVZ  X15, #0x1f47, LSL #0
    MOVK  X15, #0xd6fd, LSL #16
    MOVK  X15, #0x498e, LSL #32
    MOVK  X15, #0x11be, LSL #48
    MOVZ  X16, #0x3e26, LSL #0
    MOVK  X16, #0x581a, LSL #16
    MOVK  X16, #0xa1fd, LSL #32
    MOVK  X16, #0x6d03, LSL #48
    MOVZ  X17, #0xf716, LSL #0
    MOVK  X17, #0x5bad, LSL #16
    MOVK  X17, #0xc68d, LSL #32
    MOVK  X17, #0x9dba, LSL #48
    MOVZ  X18, #0x3a66, LSL #0
    MOVK  X18, #0x1930, LSL #16
    MOVK  X18, #0x20b3, LSL #32
    MOVK  X18, #0x1e43, LSL #48
    MOVZ  X19, #0xad86, LSL #0
    MOVK  X19, #0xa05b, LSL #16
    MOVK  X19, #0x6a28, LSL #32
    MOVK  X19, #0x5e9f, LSL #48
    MOVZ  X20, #0x3960, LSL #0
    MOVK  X20, #0x58b2, LSL #16
    MOVK  X20, #0xc7a5, LSL #32
    MOVK  X20, #0xdac9, LSL #48
    MOVZ  X21, #0x93d4, LSL #0
    MOVK  X21, #0x1667, LSL #16
    MOVK  X21, #0xa7e6, LSL #32
    MOVK  X21, #0x5e96, LSL #48
    MOVZ  X23, #0x1973, LSL #0
    MOVK  X23, #0x190e, LSL #16
    MOVK  X23, #0x52e, LSL #32
    MOVK  X23, #0xcfd3, LSL #48
    MOVZ  X24, #0xdd83, LSL #0
    MOVK  X24, #0xa4a0, LSL #16
    MOVK  X24, #0xe0c9, LSL #32
    MOVK  X24, #0x4c2f, LSL #48
    MOVZ  X25, #0xd3f9, LSL #0
    MOVK  X25, #0x2efa, LSL #16
    MOVK  X25, #0x7129, LSL #32
    MOVK  X25, #0x4e19, LSL #48
    MOVZ  X26, #0xbf41, LSL #0
    MOVK  X26, #0x682, LSL #16
    MOVK  X26, #0x32ad, LSL #32
    MOVK  X26, #0x3f83, LSL #48
    MOVZ  X27, #0xd286, LSL #0
    MOVK  X27, #0x4d21, LSL #16
    MOVK  X27, #0x7042, LSL #32
    MOVK  X27, #0x937c, LSL #48
    MOVZ  X28, #0xdca7, LSL #0
    MOVK  X28, #0xacf2, LSL #16
    MOVK  X28, #0x1563, LSL #32
    MOVK  X28, #0x95b2, LSL #48
    MOVZ  X29, #0x8f7e, LSL #0
    MOVK  X29, #0x8860, LSL #16
    MOVK  X29, #0xbca8, LSL #32
    MOVK  X29, #0x84f3, LSL #48
    SUBS  W10, W25, W26, LSR #1
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x1963, LSL #0
    MOVK  X2, #0x1691, LSL #16
    MOVK  X2, #0x23f6, LSL #32
    MOVK  X2, #0xa97c, LSL #48
    MOVZ  X3, #0x8990, LSL #0
    MOVK  X3, #0xe5c4, LSL #16
    MOVK  X3, #0xa150, LSL #32
    MOVK  X3, #0x6878, LSL #48
    MOVZ  X4, #0x71d5, LSL #0
    MOVK  X4, #0x933b, LSL #16
    MOVK  X4, #0xd2fb, LSL #32
    MOVK  X4, #0x8624, LSL #48
    MOVZ  X5, #0x3923, LSL #0
    MOVK  X5, #0xaee9, LSL #16
    MOVK  X5, #0xeb6e, LSL #32
    MOVK  X5, #0x509c, LSL #48
    MOVZ  X7, #0xf6c4, LSL #0
    MOVK  X7, #0x8ecc, LSL #16
    MOVK  X7, #0x879c, LSL #32
    MOVK  X7, #0xde7d, LSL #48
    MOVZ  X8, #0xebe9, LSL #0
    MOVK  X8, #0xe8c4, LSL #16
    MOVK  X8, #0xd82a, LSL #32
    MOVK  X8, #0x8059, LSL #48
    MOVZ  X9, #0x821b, LSL #0
    MOVK  X9, #0xde5c, LSL #16
    MOVK  X9, #0x6785, LSL #32
    MOVK  X9, #0xed3c, LSL #48
    MOVZ  X10, #0x2c0f, LSL #0
    MOVK  X10, #0x30ca, LSL #16
    MOVK  X10, #0xaea6, LSL #32
    MOVK  X10, #0x6f2e, LSL #48
    MOVZ  X12, #0xf419, LSL #0
    MOVK  X12, #0xf914, LSL #16
    MOVK  X12, #0xedca, LSL #32
    MOVK  X12, #0x56d5, LSL #48
    MOVZ  X13, #0x56a8, LSL #0
    MOVK  X13, #0xb16a, LSL #16
    MOVK  X13, #0xf1c0, LSL #32
    MOVK  X13, #0xef62, LSL #48
    MOVZ  X15, #0x5581, LSL #0
    MOVK  X15, #0x6054, LSL #16
    MOVK  X15, #0x2b11, LSL #32
    MOVK  X15, #0x5df9, LSL #48
    MOVZ  X16, #0x1d4e, LSL #0
    MOVK  X16, #0x17b7, LSL #16
    MOVK  X16, #0xeda1, LSL #32
    MOVK  X16, #0xbe95, LSL #48
    MOVZ  X17, #0x5339, LSL #0
    MOVK  X17, #0x4e5f, LSL #16
    MOVK  X17, #0xff78, LSL #32
    MOVK  X17, #0xdd51, LSL #48
    MOVZ  X18, #0x1260, LSL #0
    MOVK  X18, #0x267d, LSL #16
    MOVK  X18, #0xe43b, LSL #32
    MOVK  X18, #0x75d7, LSL #48
    MOVZ  X19, #0xe880, LSL #0
    MOVK  X19, #0xda6b, LSL #16
    MOVK  X19, #0x1576, LSL #32
    MOVK  X19, #0xca21, LSL #48
    MOVZ  X20, #0xe894, LSL #0
    MOVK  X20, #0xedc3, LSL #16
    MOVK  X20, #0x8d24, LSL #32
    MOVK  X20, #0x1f82, LSL #48
    MOVZ  X21, #0xd134, LSL #0
    MOVK  X21, #0x27f8, LSL #16
    MOVK  X21, #0xcfbc, LSL #32
    MOVK  X21, #0x554b, LSL #48
    MOVZ  X23, #0x57a5, LSL #0
    MOVK  X23, #0x5ea1, LSL #16
    MOVK  X23, #0x7afc, LSL #32
    MOVK  X23, #0xce83, LSL #48
    MOVZ  X24, #0xdb1b, LSL #0
    MOVK  X24, #0x1315, LSL #16
    MOVK  X24, #0x8a5d, LSL #32
    MOVK  X24, #0x6dc2, LSL #48
    MOVZ  X25, #0x6b63, LSL #0
    MOVK  X25, #0x8ef3, LSL #16
    MOVK  X25, #0x7d28, LSL #32
    MOVK  X25, #0x4065, LSL #48
    MOVZ  X26, #0x97aa, LSL #0
    MOVK  X26, #0xf975, LSL #16
    MOVK  X26, #0x638a, LSL #32
    MOVK  X26, #0x1b17, LSL #48
    MOVZ  X27, #0xdbb7, LSL #0
    MOVK  X27, #0x830b, LSL #16
    MOVK  X27, #0xc3fc, LSL #32
    MOVK  X27, #0x9a40, LSL #48
    MOVZ  X28, #0x412e, LSL #0
    MOVK  X28, #0x6d7e, LSL #16
    MOVK  X28, #0x6412, LSL #32
    MOVK  X28, #0x9238, LSL #48
    MOVZ  X29, #0x9a4, LSL #0
    MOVK  X29, #0x33a1, LSL #16
    MOVK  X29, #0x8f45, LSL #32
    MOVK  X29, #0x5395, LSL #48
    MOVZ  X19, #0xf, LSL #0
TSRTIntCRCAndShiftAndMov_label_0:
    LSL  W9, W19, #28
    LSR  W25, W28, #0x1f
    LSLV  X29, X26, X29
    LSL  X20, X25, #6
    LSL  W5, W23, W20
    MOVZ  X5, #0x391c, LSL #16
    MOVZ  W13, #0x4f46, LSL #0
    LSR  W15, W29, #0xc
    MOV  X25, X9
    MOV  X28, X5
    MOV  W3, W25
    MOVN  W10, #0x1fc6, LSL #16
    CRC32W  W28, W3, W3
    LSL  X12, X28, #19
    LSRV  X27, X12, X13
    CRC32CB  W26, W21, W10
    MOVZ  W4, #0x5210, LSL #0
    MOV  X12, X15
    LSL  X20, X5, X4
    LSR  X21, X27, #0x7
    MOV  W5, W21
    MOV  X25, X5
    CRC32CX  W5, W20, X3
    LSL  X12, X25, #55
    CRC32CW  W3, W26, W12
    LSRV  W23, W5, W5
    CRC32CB  W28, W3, W23
    MOVZ  W20, #0x613, LSL #0
    CRC32CH  W29, W19, W13
    MOVZ  X27, #0xc79a, LSL #48
    LSR  X13, X18, #0x3c
    MOV  W12, W5
    MOVK  W21, #0xfb52, LSL #0
    MOVK  W23, #0xe2d5, LSL #0
    LSL  W3, W7, #1
    LSRV  W5, W3, W23
    CRC32CW  W4, W27, W12
    LSL  W15, W21, #15
    LSL  X23, X13, #39
    MOVZ  X26, #0x47b1, LSL #48
    CRC32X  W27, W26, X15
    CRC32X  W25, W29, X20
    LSRV  W7, W23, W28
    MOV  X10, X5
    CRC32CB  W20, W3, W4
    MOV  X3, X7
    LSL  W7, W25, W25
    LSL  W23, W27, #6
    CRC32CW  W13, W23, W23
    CRC32CX  W12, W13, X13
    CRC32B  W25, W12, W10
    MOVK  W21, #0xf2e6, LSL #0
    LSR  X13, X20, X20
    LSL  W29, W3, #24
    MOVK  W10, #0x8e95, LSL #0
    MOVN  W26, #0x9d21, LSL #0
    LSRV  X5, X10, X10
    MOV  X4, X29
    CRC32CB  W27, W26, W5
    CRC32CX  W28, W7, X25
    CRC32CW  W23, W10, W4
    MOV  W29, W13
    LSR  W10, W21, W10
    CRC32CX  W7, W28, X10
    LSR  W3, W29, #0xc
    CRC32W  W12, W3, W3
    LSLV  W15, W12, W7
    LSL  X7, X15, #1
    CRC32H  W10, W23, W23
    LSR  X12, X27, #0x8
    MOVZ  X15, #0x868b, LSL #32
    CRC32B  W29, W7, W10
    LSRV  X5, X12, X29
    LSRV  W10, W5, W27
    MOV  X20, X15
    LSRV  W25, W10, W23
    MOV  W13, W20
    MOVK  X20, #0xb6ca, LSL #32
    MOVZ  X26, #0xf1ec, LSL #32
    CRC32B  W5, W25, W20
    CRC32CX  W21, W5, X13
    MOVZ  W12, #0x28e1, LSL #0
    MOV  W4, W21
    MOVK  X25, #0x5f64, LSL #48
    CRC32H  W27, W26, W26
    MOV  X13, X4
    MOV  W23, W12
    CRC32H  W4, W25, W27
    MOVN  W27, #0x384c, LSL #16
    MOVN  X12, #0xdbe3, LSL #0
    LSL  W21, W12, #11
    MOV  X15, X21
    MOV  X26, X23
    CRC32W  W21, W13, W27
    LSL  X7, X15, #7
    CRC32H  W25, W4, W7
    LSL  W4, W27, #24
    CRC32CX  W5, W4, X26
    CRC32X  W20, W5, X21
    LSL  X13, X25, #31
    MOVN  W7, #0xeb3d, LSL #16
    LSLV  W12, W20, W20
    MOV  X26, X12
    MOV  X25, X7
    MOV  X23, X13
    LSLV  W27, W23, W26
    CRC32CX  W15, W25, X28
    MOV  X21, X15
    LSL  X26, X21, #38
    MOVZ  X20, #0xc8f7, LSL #0
    LSL  X15, X27, X27
    MOVK  W5, #0xab3c, LSL #0
    MOVN  W4, #0x61ec, LSL #16
    MOVK  X25, #0xdcb8, LSL #0
    LSLV  X12, X26, X5
    LSR  X26, X15, X20
    LSR  W13, W12, W4
    MOVN  X7, #0x633d, LSL #32
    LSL  X4, X2, #57
    MOV  W21, W13
    LSL  W13, W7, #23
    LSL  W28, W25, #12
    LSLV  W5, W26, W21
    MOVN  W27, #0x96c2, LSL #0
    MOVK  W2, #0x7876, LSL #0
    LSLV  W21, W2, W19
    LSR  W2, W21, W13
    CRC32CB  W20, W4, W2
    LSR  X21, X5, X5
    MOVN  X26, #0xe5a3, LSL #32
    MOVK  W5, #0xa2ac, LSL #0
    CRC32CX  W23, W21, X27
    MOVN  W4, #0x74a9, LSL #16
    CRC32CW  W27, W28, W23
    MOVK  W13, #0xa6e6, LSL #16
    LSLV  W15, W5, W4
    LSL  W12, W25, #3
    CRC32CW  W25, W20, W13
    MOV  X2, X26
    CRC32W  W7, W27, W10
    LSL  W10, W7, #22
    LSR  W12, W20, W15
    CRC32CB  W12, W25, W12
    LSR  W20, W2, W10
    CRC32X  W27, W12, X12
    CRC32X  W26, W27, X27
    LSL  W21, W4, #1
    LSRV  X13, X18, X20
    MOVZ  W4, #0x1059, LSL #16
    LSR  X7, X26, #0x3c
    LSL  X23, X4, X4
    LSRV  W4, W21, W8
    MOV  X2, X4
    LSL  W16, W13, W23
    CRC32CH  W23, W16, W16
    CRC32CH  W12, W7, W23
    LSL  X5, X2, X2
    LSL  X27, X12, X12
    CRC32CB  W20, W5, W27
    LSR  W21, W18, #0x10
    CRC32CB  W7, W5, W16
    MOVZ  X25, #0xb1aa, LSL #0
    MOVN  W23, #0x0, LSL #16
    CRC32H  W13, W19, W18
    CRC32X  W8, W5, X29
    LSL  W16, W29, W10
    LSLV  X26, X15, X16
    LSR  W27, W15, W7
    CRC32B  W21, W3, W26
    CRC32CH  W29, W7, W8
    LSR  W3, W23, #0x12
    LSL  W18, W13, W25
    MOVK  W2, #0x2e04, LSL #16
    MOVZ  X13, #0xad6, LSL #32
    CRC32W  W15, W8, W23
    MOVK  W4, #0xb7a5, LSL #0
    CRC32CW  W25, W13, W21
    MOV  X10, X27
    CRC32X  W16, W20, X29
    MOVK  X21, #0xe30, LSL #48
    CRC32CW  W29, W25, W3
    LSL  X12, X7, X4
    MOVN  W25, #0xe852, LSL #0
    MOVK  X13, #0x90ae, LSL #32
    LSR  W26, W18, #0x0
    MOV  X23, X2
    LSR  X7, X23, #0x2f
    LSL  W23, W15, W13
    LSR  X15, X16, #0x19
    CRC32CB  W8, W15, W23
    LSL  W27, W7, #27
    MOVK  X2, #0x3b45, LSL #16
    CRC32X  W13, W8, X10
    LSR  W15, W13, #0x9
    LSR  X16, X12, #0x33
    LSLV  W18, W16, W15
    MOV  X3, X21
    MOVN  X4, #0x6856, LSL #0
    LSR  W10, W2, W25
    LSLV  X25, X26, X10
    SUBS  X19, X19, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_0
    MOVZ  X17, #0xb56f, LSL #0
    MOVK  X17, #0x3b45, LSL #16
    SUB  X24, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x20f2, LSL #0
    MOVK  X17, #0x6ab0, LSL #16
    MOVK  X17, #0xe30, LSL #48
    SUB  X24, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x97a9, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X24, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x8000, LSL #32
    MOVK  X17, #0x5ab7, LSL #48
    SUB  X24, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x540d, LSL #0
    MOVK  X17, #0x7198, LSL #16
    SUB  X24, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x1000, LSL #16
    SUB  X24, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0xda2d, LSL #0
    MOVK  X17, #0x1, LSL #16
    SUB  X24, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x8524, LSL #0
    MOVK  X17, #0x7918, LSL #16
    SUB  X24, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x8c42, LSL #0
    MOVK  X17, #0x3c, LSL #16
    SUB  X24, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x20f2, LSL #0
    MOVK  X17, #0x6ab0, LSL #16
    MOVK  X17, #0xe30, LSL #48
    SUB  X24, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x902b, LSL #0
    MOVK  X17, #0x10f1, LSL #16
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xa080, LSL #48
    SUB  X24, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x400, LSL #0
    MOVK  X17, #0x6cc5, LSL #16
    SUB  X24, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x8000, LSL #0
    MOVK  X17, #0x2dcb, LSL #16
    SUB  X24, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0xe6ad, LSL #0
    MOVK  X17, #0x3d5c, LSL #16
    SUB  X24, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X13, #0xf, LSL #0
TSRTIntCRCAndShiftAndMov_label_1:
    LSR  W21, W12, W18
    CRC32W  W26, W16, W17
    MOVN  X26, #0xdac, LSL #16
    LSLV  W17, W15, W28
    MOVK  X17, #0x5728, LSL #0
    MOV  X5, X25
    LSR  X23, X24, X27
    MOV  X19, X20
    MOVK  X5, #0x8a55, LSL #32
    LSR  W16, W5, #0x17
    CRC32CX  W18, W13, X17
    LSL  W15, W21, #4
    LSL  X4, X26, #32
    MOV  X28, X18
    LSLV  X4, X4, X29
    LSL  X17, X4, #16
    LSR  X2, X25, X17
    CRC32CX  W19, W2, X2
    LSR  X7, X28, X16
    LSLV  W29, W7, W15
    CRC32CX  W16, W29, X29
    LSLV  W5, W16, W16
    LSR  W17, W19, #0x1a
    CRC32CB  W20, W5, W17
    LSL  X12, X20, X20
    LSL  X27, X23, #55
    CRC32W  W23, W12, W12
    LSRV  W7, W23, W27
    LSLV  X12, X21, X2
    MOV  W29, W17
    LSL  W20, W28, W19
    LSL  W23, W10, #17
    LSRV  W10, W26, W17
    LSRV  X24, X13, X19
    MOV  X2, X15
    LSR  W21, W7, #0x4
    LSL  W17, W13, W19
    MOVK  X19, #0x50f3, LSL #0
    LSL  X15, X12, X23
    CRC32CB  W5, W15, W15
    LSRV  X4, X21, X10
    LSRV  W26, W20, W24
    LSL  W21, W29, #26
    MOVK  W15, #0xb1fc, LSL #16
    LSR  X23, X19, #0x9
    MOVZ  W27, #0xcb47, LSL #0
    CRC32H  W7, W2, W2
    MOVN  X25, #0x6025, LSL #0
    CRC32CB  W28, W25, W23
    LSRV  X10, X5, X28
    CRC32CX  W7, W4, X26
    CRC32B  W19, W19, W17
    LSRV  X24, X7, X19
    LSL  W20, W24, W27
    LSRV  X17, X15, X21
    LSRV  X12, X17, X17
    MOV  W5, W20
    CRC32H  W29, W15, W12
    LSL  W28, W10, #1
    LSL  W27, W7, #10
    MOVN  W12, #0xa0c4, LSL #16
    MOVN  W21, #0xde75, LSL #0
    LSR  W2, W28, W28
    LSL  W28, W12, W5
    MOV  W12, W29
    MOV  X24, X2
    CRC32W  W5, W16, W21
    LSL  X26, X23, X27
    LSR  W27, W24, W28
    CRC32CW  W4, W27, W27
    CRC32X  W19, W4, X26
    CRC32CH  W20, W12, W19
    CRC32CH  W25, W5, W20
    LSRV  X20, X16, X5
    LSLV  X29, X20, X26
    CRC32CW  W20, W26, W9
    CRC32B  W26, W17, W17
    MOVK  X4, #0xc574, LSL #16
    CRC32CX  W23, W28, X16
    MOV  X21, X15
    LSL  W9, W24, W29
    MOV  W5, W26
    LSR  W7, W19, W29
    LSR  W2, W27, W5
    MOV  W15, W18
    LSR  W18, W20, W20
    MOVZ  X12, #0x85e3, LSL #0
    MOV  W26, W18
    LSRV  X27, X15, X23
    LSRV  W29, W21, W2
    LSLV  X21, X29, X12
    MOVZ  W19, #0xbf6f, LSL #16
    LSL  X29, X25, #61
    CRC32CW  W16, W9, W17
    MOV  W5, W26
    CRC32B  W28, W7, W27
    CRC32H  W9, W21, W21
    MOV  W27, W9
    LSR  W19, W16, #0xe
    CRC32CB  W7, W29, W5
    CRC32CX  W26, W28, X7
    MOV  X12, X27
    LSL  W20, W12, #21
    LSL  X25, X26, #48
    LSL  X29, X19, #22
    LSL  W28, W20, W29
    MOV  W17, W28
    LSLV  W16, W17, W17
    MOVZ  W15, #0x5e62, LSL #0
    MOV  W21, W16
    LSRV  X9, X21, X21
    CRC32H  W12, W25, W9
    LSL  W5, W12, W15
    LSR  W21, W10, W15
    LSL  W26, W9, W29
    MOVN  W7, #0x7c48, LSL #16
    LSL  W27, W23, #5
    LSRV  W17, W28, W2
    LSR  X2, X15, #0x19
    MOV  W25, W26
    MOV  X29, X17
    CRC32W  W10, W15, W5
    MOVN  W16, #0x3736, LSL #16
    LSR  W12, W26, W20
    CRC32CH  W5, W25, W10
    MOV  X9, X21
    MOVN  W19, #0x155, LSL #0
    MOV  W21, W5
    CRC32X  W25, W19, X27
    LSR  W26, W16, W16
    CRC32B  W23, W29, W12
    MOVK  W5, #0xb3b4, LSL #0
    MOVK  X10, #0x5130, LSL #32
    LSL  X15, X7, X21
    LSRV  W17, W9, W5
    CRC32X  W29, W25, X17
    MOV  X28, X2
    MOVK  W25, #0x7136, LSL #16
    CRC32X  W12, W15, X29
    MOV  W29, W26
    CRC32X  W7, W29, X23
    CRC32CB  W15, W9, W12
    CRC32W  W16, W10, W15
    CRC32H  W15, W25, W16
    MOVZ  X2, #0xf795, LSL #0
    MOV  W21, W2
    LSR  X26, X28, #0x0
    LSL  X27, X21, X26
    CRC32CB  W29, W15, W27
    CRC32X  W23, W29, X19
    MOV  X5, X7
    MOV  X17, X23
    MOVK  X10, #0xaff, LSL #32
    LSL  W27, W10, #11
    MOV  W15, W27
    LSRV  W16, W15, W17
    CRC32CB  W26, W16, W16
    MOVN  X19, #0x7424, LSL #48
    LSRV  X25, X5, X5
    CRC32CX  W7, W25, X23
    LSR  X29, X19, #0x29
    CRC32H  W21, W29, W26
    LSR  X12, X21, X21
    MOVZ  X9, #0xb6ea, LSL #0
    LSRV  X2, X9, X7
    MOV  X17, X2
    LSRV  W25, W17, W12
    CRC32CB  W19, W23, W16
    LSRV  X7, X29, X12
    CRC32X  W17, W5, X24
    LSL  X15, X27, X21
    LSR  W10, W4, #0x5
    LSL  X28, X18, #11
    LSR  W23, W27, #0xc
    MOVK  X2, #0x8675, LSL #48
    CRC32W  W21, W25, W15
    MOV  W16, W10
    MOVN  W29, #0x9745, LSL #16
    MOVK  X2, #0x68f6, LSL #0
    LSLV  X26, X29, X2
    CRC32CH  W9, W16, W21
    LSR  X21, X28, #0x29
    CRC32X  W5, W9, X26
    LSLV  X9, X19, X7
    LSRV  W16, W21, W17
    LSL  W15, W16, W5
    LSL  X21, X23, X9
    LSRV  X16, X15, X15
    LSLV  W26, W21, W21
    MOVK  X4, #0xe24b, LSL #48
    MOVZ  X28, #0xbbf2, LSL #0
    MOV  X17, X16
    LSLV  X25, X26, X4
    LSL  X2, X28, #43
    MOV  W5, W17
    LSL  W9, W25, W5
    CRC32CX  W25, W2, X2
    LSL  X16, X9, X9
    MOVZ  W9, #0x92e9, LSL #16
    MOVK  W5, #0x7177, LSL #0
    SUBS  X13, X13, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_1
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x9000, LSL #32
    MOVK  X3, #0x5df, LSL #48
    SUB  X8, X3, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0xc574, LSL #16
    MOVK  X3, #0xe24b, LSL #48
    SUB  X8, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0x7177, LSL #0
    SUB  X8, X3, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0xedff, LSL #0
    MOVK  X3, #0x45, LSL #16
    SUB  X8, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x92e9, LSL #16
    SUB  X8, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0xa000, LSL #0
    MOVK  X3, #0x62b, LSL #16
    SUB  X8, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x3200, LSL #16
    SUB  X8, X3, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0x5, LSL #0
    SUB  X8, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0xb813, LSL #0
    MOVK  X3, #0x4b2d, LSL #16
    SUB  X8, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0x9e19, LSL #0
    MOVK  X3, #0x6, LSL #16
    SUB  X8, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0x9e19, LSL #0
    MOVK  X3, #0x6, LSL #16
    SUB  X8, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0xd954, LSL #0
    MOVK  X3, #0x121c, LSL #16
    SUB  X8, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x3200, LSL #16
    SUB  X8, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0x9000, LSL #0
    MOVK  X3, #0x69e1, LSL #16
    SUB  X8, X3, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0xbbf2, LSL #0
    SUB  X8, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0x68ba, LSL #16
    SUB  X8, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
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
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
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
    MOVZ  X12, #0xf, LSL #0
TSRTIntCRCAndShiftAndMov_label_2:
    LSL  X3, X27, #47
    CRC32CH  W10, W3, W29
    MOVN  W26, #0x8313, LSL #0
    LSRV  X29, X23, X28
    LSRV  W16, W10, W24
    MOVZ  X18, #0xfda0, LSL #16
    CRC32X  W18, W12, X18
    MOV  X10, X26
    CRC32W  W17, W16, W10
    LSR  W2, W17, W18
    LSR  X4, X2, X29
    LSRV  W23, W8, W4
    MOVZ  X26, #0xa5e3, LSL #32
    MOVK  X21, #0xf44c, LSL #48
    LSR  X3, X23, X24
    LSR  X28, X21, #0x2f
    MOV  W21, W3
    LSR  W18, W26, #0x17
    CRC32W  W19, W18, W20
    MOV  W16, W19
    LSRV  X4, X16, X16
    LSLV  W16, W28, W28
    MOVK  X26, #0xa0a7, LSL #16
    MOVK  X8, #0x876b, LSL #16
    MOV  W3, W4
    MOV  X20, X21
    LSLV  X19, X15, X16
    LSR  X21, X3, X3
    LSL  W23, W21, #13
    CRC32CW  W24, W23, W26
    LSR  W3, W19, W19
    MOV  X18, X24
    LSR  W28, W18, W18
    CRC32CB  W15, W28, W28
    CRC32CH  W23, W20, W8
    LSRV  X28, X3, X19
    CRC32CX  W4, W23, X15
    MOVZ  X18, #0xf85, LSL #16
    CRC32W  W24, W18, W4
    CRC32W  W4, W24, W28
    CRC32CH  W16, W19, W17
    LSL  X8, X28, X19
    CRC32B  W19, W24, W16
    LSLV  W16, W19, W19
    LSR  X26, X3, X26
    MOV  X17, X4
    LSR  X15, X5, X27
    MOV  W23, W17
    MOV  W20, W5
    CRC32B  W18, W20, W7
    MOVZ  X3, #0xcfa0, LSL #0
    MOV  X7, X29
    MOV  X29, X16
    MOV  X24, X17
    MOV  X17, X7
    CRC32X  W19, W15, X3
    CRC32B  W21, W23, W19
    LSL  X3, X8, X8
    LSR  X28, X24, X24
    LSR  X7, X26, X29
    CRC32H  W15, W7, W7
    LSR  X20, X21, #0x2
    LSR  W10, W17, #0x1e
    MOVN  X17, #0x271c, LSL #48
    LSR  X8, X28, #0x1
    LSR  X16, X3, X18
    LSL  W19, W15, W16
    LSR  X21, X19, X19
    MOVK  W19, #0xff30, LSL #0
    LSL  X7, X8, X20
    CRC32CB  W16, W21, W21
    LSR  X21, X7, #0x28
    LSL  W23, W17, W17
    LSR  X4, X16, X10
    CRC32W  W20, W4, W27
    LSRV  W24, W21, W21
    LSLV  W21, W20, W20
    MOVN  X8, #0x2b3c, LSL #16
    CRC32CX  W28, W8, X8
    LSR  W7, W24, W24
    CRC32CX  W29, W21, X28
    CRC32X  W27, W19, X29
    CRC32H  W18, W23, W27
    LSLV  W3, W18, W12
    LSR  X19, X7, X7
    CRC32CW  W29, W3, W3
    LSR  W23, W29, W19
    MOVK  X27, #0x76af, LSL #0
    CRC32CX  W29, W8, X20
    CRC32CH  W20, W21, W27
    MOV  X24, X26
    LSR  X21, X18, X10
    MOVN  X27, #0x7a63, LSL #0
    MOVK  W3, #0xd29d, LSL #0
    LSL  W4, W19, W17
    CRC32H  W8, W21, W2
    CRC32B  W16, W2, W3
    LSRV  W19, W24, W20
    CRC32CH  W28, W23, W16
    CRC32H  W17, W16, W15
    MOVN  W23, #0xa4d4, LSL #0
    MOV  W26, W20
    LSR  W20, W17, #0x15
    LSR  W7, W29, W19
    MOVK  X18, #0xcc60, LSL #0
    MOVZ  W18, #0xdd0f, LSL #0
    LSLV  W16, W27, W24
    LSR  X19, X8, #0x25
    LSL  X29, X19, #55
    MOVK  W10, #0x5529, LSL #16
    LSLV  W21, W4, W18
    MOVK  W2, #0xbcc2, LSL #16
    LSR  X15, X2, X20
    CRC32B  W24, W29, W23
    CRC32CW  W19, W21, W26
    LSR  X29, X19, #0x20
    LSRV  X21, X10, X7
    LSLV  W26, W16, W28
    LSL  X17, X15, #49
    CRC32X  W4, W26, X29
    LSLV  W28, W17, W4
    LSRV  W23, W21, W28
    LSLV  X8, X24, X23
    LSR  X17, X4, #0x1d
    CRC32CX  W20, W27, X8
    LSR  X15, X3, X8
    MOVK  W2, #0xc620, LSL #16
    LSL  X18, X4, X29
    LSR  X29, X21, X28
    LSRV  W4, W18, W27
    MOVZ  W21, #0x84e2, LSL #16
    CRC32CX  W10, W4, X28
    MOV  W7, W2
    LSL  W19, W26, #1
    MOVN  X27, #0x1feb, LSL #48
    LSL  W28, W21, #5
    LSRV  X26, X28, X29
    LSR  W16, W28, #0x7
    MOVN  W24, #0xbc98, LSL #16
    CRC32CW  W4, W24, W19
    MOVZ  W18, #0x7cfa, LSL #16
    MOVZ  W21, #0xd39f, LSL #16
    CRC32CW  W28, W26, W4
    LSL  X8, X17, X28
    LSRV  W2, W21, W21
    CRC32W  W17, W8, W20
    LSL  X20, X15, #2
    CRC32CB  W4, W10, W7
    LSR  X15, X4, X29
    MOVK  X29, #0x5a17, LSL #32
    CRC32B  W8, W13, W18
    LSL  X24, X20, #16
    MOVZ  W13, #0x73b, LSL #0
    CRC32CB  W21, W16, W15
    LSR  X7, X27, #0x2b
    MOVK  W4, #0xd9dc, LSL #0
    MOVK  W19, #0x2060, LSL #16
    MOVK  X20, #0x1a, LSL #16
    MOV  X18, X2
    MOVZ  X16, #0x51ad, LSL #16
    CRC32CB  W26, W16, W7
    MOVN  X28, #0x7050, LSL #48
    CRC32CH  W10, W17, W28
    CRC32CW  W15, W19, W4
    CRC32CB  W4, W13, W20
    LSRV  X16, X21, X18
    MOVK  X13, #0x9168, LSL #16
    MOVK  W21, #0xfafd, LSL #0
    LSR  X27, X13, #0x7
    CRC32X  W2, W10, X24
    MOV  X13, X27
    LSL  W19, W16, #27
    LSL  X18, X26, #59
    MOVN  X8, #0xddbb, LSL #0
    LSR  X26, X19, X29
    MOVK  X7, #0xda52, LSL #0
    CRC32CB  W27, W18, W21
    CRC32X  W20, W13, X27
    LSRV  X28, X2, X16
    CRC32CX  W24, W8, X4
    CRC32CB  W17, W26, W15
    LSL  W10, W17, W28
    LSL  X29, X7, #59
    LSL  W26, W20, W29
    MOVK  X15, #0x434c, LSL #0
    LSR  W19, W10, #0x19
    CRC32CW  W2, W24, W15
    LSLV  W13, W26, W23
    MOV  X29, X13
    CRC32B  W27, W29, W29
    LSRV  W16, W27, W27
    MOVN  X18, #0x8e54, LSL #16
    LSR  W29, W18, #0x8
    MOV  W26, W2
    LSR  X10, X26, X16
    CRC32CW  W27, W10, W29
    CRC32CX  W29, W27, X27
    CRC32CX  W18, W29, X29
    CRC32CH  W26, W19, W19
    MOVK  X19, #0x890c, LSL #0
    SUBS  X12, X12, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_2
    MOVZ  X25, #0x8697, LSL #0
    MOVK  X25, #0x8541, LSL #16
    SUB  X9, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0xd29d, LSL #0
    MOVK  X25, #0xb1a0, LSL #16
    SUB  X9, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0x219f, LSL #0
    MOVK  X25, #0x1f68, LSL #16
    SUB  X9, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X9, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0xda52, LSL #0
    MOVK  X25, #0x1c, LSL #16
    SUB  X9, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0x2244, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X9, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0xdc9, LSL #0
    MOVK  X25, #0x1f38, LSL #16
    SUB  X9, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0x434c, LSL #0
    MOVK  X25, #0x12b0, LSL #16
    SUB  X9, X25, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0xf9, LSL #0
    SUB  X9, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0xf975, LSL #0
    MOVK  X25, #0x1d33, LSL #16
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0x890c, LSL #0
    SUB  X9, X25, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0xdc9, LSL #0
    MOVK  X25, #0x1f38, LSL #16
    SUB  X9, X25, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0xfafd, LSL #0
    MOVK  X25, #0x4766, LSL #16
    SUB  X9, X25, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0x8000, LSL #0
    MOVK  X25, #0x2a94, LSL #16
    SUB  X9, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0xd3e9, LSL #0
    MOVK  X25, #0x931b, LSL #16
    SUB  X9, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0xd653, LSL #0
    MOVK  X25, #0x3ce4, LSL #16
    SUB  X9, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0xb65e, LSL #0
    MOVK  X25, #0x5, LSL #16
    SUB  X9, X25, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X2, #0xeaf0, LSL #0
    MOVK  X2, #0x1e3a, LSL #16
    MOVK  X2, #0xd4f4, LSL #32
    MOVK  X2, #0xc770, LSL #48
    MOVZ  X3, #0x78e8, LSL #0
    MOVK  X3, #0x1723, LSL #16
    MOVK  X3, #0x1279, LSL #32
    MOVK  X3, #0xe8af, LSL #48
    MOVZ  X4, #0xa1d3, LSL #0
    MOVK  X4, #0x413e, LSL #16
    MOVK  X4, #0x2abb, LSL #32
    MOVK  X4, #0x13e1, LSL #48
    MOVZ  X5, #0xc2c7, LSL #0
    MOVK  X5, #0xec41, LSL #16
    MOVK  X5, #0xde15, LSL #32
    MOVK  X5, #0xca0f, LSL #48
    MOVZ  X7, #0x4e4a, LSL #0
    MOVK  X7, #0xe3f6, LSL #16
    MOVK  X7, #0x62d5, LSL #32
    MOVK  X7, #0xa01d, LSL #48
    MOVZ  X8, #0x7e69, LSL #0
    MOVK  X8, #0x606e, LSL #16
    MOVK  X8, #0xea77, LSL #32
    MOVK  X8, #0xd811, LSL #48
    MOVZ  X9, #0x90da, LSL #0
    MOVK  X9, #0x9f90, LSL #16
    MOVK  X9, #0x5667, LSL #32
    MOVK  X9, #0xeeef, LSL #48
    MOVZ  X10, #0xb762, LSL #0
    MOVK  X10, #0xdebe, LSL #16
    MOVK  X10, #0x4f9, LSL #32
    MOVK  X10, #0x7ed9, LSL #48
    MOVZ  X12, #0x137c, LSL #0
    MOVK  X12, #0x4135, LSL #16
    MOVK  X12, #0x2c7e, LSL #32
    MOVK  X12, #0xa932, LSL #48
    MOVZ  X13, #0x8aff, LSL #0
    MOVK  X13, #0x9901, LSL #16
    MOVK  X13, #0x1ab2, LSL #32
    MOVK  X13, #0x8103, LSL #48
    MOVZ  X15, #0x4629, LSL #0
    MOVK  X15, #0x9fce, LSL #16
    MOVK  X15, #0x1208, LSL #32
    MOVK  X15, #0x6194, LSL #48
    MOVZ  X16, #0x691e, LSL #0
    MOVK  X16, #0x47e1, LSL #16
    MOVK  X16, #0x7835, LSL #32
    MOVK  X16, #0xa080, LSL #48
    MOVZ  X17, #0xa67c, LSL #0
    MOVK  X17, #0x9cd8, LSL #16
    MOVK  X17, #0x2805, LSL #32
    MOVK  X17, #0xdec6, LSL #48
    MOVZ  X18, #0x3176, LSL #0
    MOVK  X18, #0x893b, LSL #16
    MOVK  X18, #0x44bf, LSL #32
    MOVK  X18, #0x296, LSL #48
    MOVZ  X19, #0x62ee, LSL #0
    MOVK  X19, #0x82a2, LSL #16
    MOVK  X19, #0xdf28, LSL #32
    MOVK  X19, #0x58b8, LSL #48
    MOVZ  X20, #0xae59, LSL #0
    MOVK  X20, #0x3360, LSL #16
    MOVK  X20, #0xcefc, LSL #32
    MOVK  X20, #0x48c9, LSL #48
    MOVZ  X21, #0x9c0d, LSL #0
    MOVK  X21, #0x4244, LSL #16
    MOVK  X21, #0xd106, LSL #32
    MOVK  X21, #0x180f, LSL #48
    MOVZ  X23, #0xd8f, LSL #0
    MOVK  X23, #0x1a8, LSL #16
    MOVK  X23, #0xf619, LSL #32
    MOVK  X23, #0x4c98, LSL #48
    MOVZ  X24, #0x9f66, LSL #0
    MOVK  X24, #0x2030, LSL #16
    MOVK  X24, #0xb8be, LSL #32
    MOVK  X24, #0xe1a6, LSL #48
    MOVZ  X25, #0x2f7, LSL #0
    MOVK  X25, #0x91a0, LSL #16
    MOVK  X25, #0xec68, LSL #32
    MOVK  X25, #0xbc69, LSL #48
    MOVZ  X26, #0xe3f7, LSL #0
    MOVK  X26, #0x6e84, LSL #16
    MOVK  X26, #0xe7bc, LSL #32
    MOVK  X26, #0x91b5, LSL #48
    MOVZ  X27, #0x5395, LSL #0
    MOVK  X27, #0x8bbf, LSL #16
    MOVK  X27, #0xc68b, LSL #32
    MOVK  X27, #0x8a95, LSL #48
    MOVZ  X28, #0x7d14, LSL #0
    MOVK  X28, #0x5737, LSL #16
    MOVK  X28, #0x7639, LSL #32
    MOVK  X28, #0x52f9, LSL #48
    MOVZ  X29, #0x1e43, LSL #0
    MOVK  X29, #0x75c9, LSL #16
    MOVK  X29, #0x775c, LSL #32
    MOVK  X29, #0x66f5, LSL #48
    MOVZ  X10, #0xf, LSL #0
TSRTIntCRCAndShiftAndMov_label_3:
    CRC32W  W13, W26, W28
    MOVN  X23, #0x4904, LSL #32
    CRC32CB  W9, W13, W25
    LSLV  X25, X10, X9
    LSL  W7, W25, #23
    CRC32W  W18, W27, W27
    LSR  X4, X17, X18
    MOVK  W25, #0x2d4b, LSL #0
    MOVK  X3, #0x5139, LSL #0
    MOVZ  X2, #0xa10c, LSL #48
    LSL  W7, W23, #25
    LSL  X4, X2, X7
    LSR  X17, X25, #0x13
    MOV  W4, W17
    CRC32W  W13, W3, W4
    LSR  W19, W13, W13
    CRC32X  W18, W19, X19
    CRC32W  W17, W18, W18
    CRC32B  W27, W2, W17
    CRC32H  W23, W27, W27
    LSL  X3, X23, #2
    LSR  W28, W3, W7
    MOVZ  X2, #0x50b1, LSL #32
    MOVN  W8, #0xb677, LSL #0
    MOVK  X18, #0xbed9, LSL #16
    CRC32CB  W9, W18, W28
    LSR  W19, W2, W8
    MOV  X18, X19
    CRC32CX  W16, W18, X9
    LSRV  X18, X16, X16
    MOV  X27, X18
    CRC32CW  W13, W27, W19
    LSRV  W25, W15, W28
    LSL  X8, X12, #51
    LSL  W17, W23, #16
    MOVZ  X3, #0xbd6b, LSL #48
    CRC32X  W7, W26, X15
    CRC32CH  W16, W24, W18
    MOVN  W26, #0x91f4, LSL #16
    MOV  W2, W5
    MOVK  X19, #0x8d4c, LSL #48
    CRC32CH  W28, W24, W25
    MOV  W5, W13
    LSR  X27, X28, X16
    LSL  X4, X19, X17
    CRC32W  W13, W8, W4
    LSR  X18, X26, X3
    LSLV  W23, W7, W7
    LSR  W15, W2, W18
    CRC32CW  W12, W2, W15
    MOV  W3, W9
    LSR  X9, X23, #0x12
    MOV  W23, W3
    MOV  X16, X13
    MOVK  X7, #0xbd06, LSL #48
    LSL  X15, X5, X5
    LSR  W19, W12, #0x13
    CRC32CX  W25, W9, X9
    CRC32CW  W26, W25, W3
    LSR  X4, X19, X27
    CRC32H  W12, W15, W7
    CRC32CH  W18, W16, W4
    MOVN  W28, #0xf832, LSL #0
    LSLV  X17, X17, X28
    MOVZ  W13, #0x560e, LSL #0
    LSR  X19, X26, X18
    MOVK  X26, #0xe4e3, LSL #0
    MOVZ  X5, #0x6024, LSL #16
    CRC32W  W7, W12, W17
    CRC32CW  W25, W13, W5
    CRC32B  W9, W23, W7
    MOVN  W23, #0xe5d7, LSL #16
    MOVK  W12, #0x3792, LSL #0
    MOV  W13, W19
    LSL  W18, W17, #1
    LSR  W19, W13, W26
    LSL  X17, X19, #52
    CRC32CH  W26, W23, W9
    LSRV  W2, W18, W25
    MOVN  W28, #0xf189, LSL #0
    MOVZ  W7, #0x1ed6, LSL #0
    MOV  W5, W17
    CRC32B  W23, W12, W7
    LSL  X13, X26, X26
    MOVK  X26, #0xe71b, LSL #32
    CRC32CH  W16, W5, W5
    CRC32CW  W17, W13, W23
    LSL  W12, W17, W28
    CRC32X  W7, W24, X26
    MOV  W19, W16
    CRC32CW  W25, W12, W7
    LSL  X5, X16, X25
    LSLV  X13, X17, X19
    LSL  W23, W2, W13
    MOVK  X12, #0xf3a6, LSL #16
    LSL  X18, X23, #42
    MOV  X9, X18
    CRC32H  W23, W12, W23
    LSL  X18, X23, #15
    LSRV  X28, X18, X9
    LSR  W18, W5, #0x15
    LSL  X26, X18, #57
    MOV  X18, X28
    LSRV  W18, W26, W26
    LSL  X24, X23, X5
    MOVZ  X12, #0xeae4, LSL #16
    MOVK  W16, #0xb7f4, LSL #0
    MOV  X28, X8
    CRC32B  W8, W25, W23
    MOV  W2, W5
    LSR  W5, W9, #0x17
    LSR  X17, X28, #0x2c
    CRC32CW  W23, W2, W19
    MOV  X26, X28
    CRC32X  W25, W26, X26
    LSL  X19, X24, #38
    LSL  X9, X17, #40
    MOV  X24, X16
    CRC32CB  W28, W12, W8
    LSR  X16, X18, X9
    LSL  X9, X16, #50
    CRC32H  W2, W23, W23
    MOVZ  X26, #0x47d8, LSL #16
    CRC32CB  W23, W2, W26
    CRC32CH  W17, W5, W25
    MOVN  X25, #0x4869, LSL #32
    LSL  W8, W23, W23
    LSR  X15, X8, X19
    LSLV  W12, W13, W24
    CRC32CX  W18, W28, X9
    LSLV  X28, X17, X15
    CRC32B  W23, W25, W25
    MOVZ  W16, #0xe709, LSL #16
    CRC32W  W5, W28, W12
    LSL  X8, X5, X18
    LSR  W19, W8, #0x18
    LSR  W17, W19, W16
    LSR  X17, X24, #0x9
    MOVK  W16, #0xdc98, LSL #16
    MOVN  X25, #0xcc05, LSL #0
    MOVK  W28, #0x92f5, LSL #16
    MOV  X2, X23
    LSL  W26, W24, #10
    LSL  X19, X28, #24
    LSL  X18, X17, #15
    LSR  X24, X26, #0x27
    MOVN  W15, #0x8377, LSL #16
    LSRV  W8, W16, W16
    LSL  X3, X15, X25
    MOVZ  W5, #0x93dd, LSL #0
    LSRV  X25, X5, X2
    MOVN  W17, #0xd9f, LSL #16
    CRC32X  W23, W3, X17
    MOV  W9, W25
    MOV  W5, W24
    CRC32B  W16, W23, W25
    LSLV  X24, X7, X8
    LSLV  X23, X19, X19
    MOV  W12, W9
    MOV  W25, W17
    CRC32CX  W9, W5, X25
    LSR  X25, X17, #0x3c
    LSRV  X5, X23, X18
    MOVN  W26, #0xcfa8, LSL #16
    CRC32CB  W3, W9, W9
    MOV  X28, X12
    LSR  W7, W28, W16
    CRC32CB  W19, W24, W5
    CRC32CX  W8, W25, X26
    CRC32W  W17, W3, W17
    MOV  X12, X8
    MOVZ  W8, #0xcad, LSL #16
    LSR  X23, X7, #0x3f
    LSR  W24, W23, #0x9
    MOVN  W3, #0xc70d, LSL #0
    MOVK  W9, #0x9e01, LSL #0
    CRC32CH  W16, W3, W8
    CRC32W  W18, W12, W28
    LSL  X5, X17, #50
    CRC32CX  W25, W5, X5
    MOV  W26, W19
    LSRV  W23, W24, W4
    MOVK  X4, #0x286b, LSL #48
    MOVZ  W7, #0xa960, LSL #0
    LSL  W28, W9, W26
    LSRV  W19, W25, W24
    LSL  W23, W28, #26
    CRC32W  W5, W16, W4
    LSL  W3, W19, #21
    LSLV  W8, W5, W4
    CRC32H  W25, W18, W18
    LSRV  W12, W3, W7
    MOVZ  W7, #0x6ccf, LSL #16
    MOV  W9, W12
    LSR  X26, X2, #0x3e
    MOVN  X24, #0xcf49, LSL #48
    MOVN  X19, #0x3e5c, LSL #48
    LSR  W17, W23, #0x17
    LSL  W3, W7, W17
    MOV  X18, X25
    SUBS  X10, X10, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_3
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xff, LSL #16
    SUB  X29, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x6ccf, LSL #16
    SUB  X29, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X20, #0x711, LSL #0
    MOVK  X20, #0x286b, LSL #48
    SUB  X29, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X20, #0x88c, LSL #0
    MOVK  X20, #0x6c8d, LSL #16
    SUB  X29, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x6ccf, LSL #16
    SUB  X29, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x1118, LSL #16
    SUB  X29, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x80c0, LSL #16
    SUB  X29, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X29, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x80c0, LSL #16
    SUB  X29, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X20, #0xe6f8, LSL #0
    MOVK  X20, #0x6821, LSL #16
    SUB  X29, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0x7c88, LSL #16
    SUB  X29, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X20, #0xf011, LSL #0
    MOVK  X20, #0xd9e5, LSL #16
    SUB  X29, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X29, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X20, #0x6fcd, LSL #0
    SUB  X29, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xc1a3, LSL #48
    SUB  X29, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X20, #0x9c0d, LSL #0
    MOVK  X20, #0x4244, LSL #16
    MOVK  X20, #0xd106, LSL #32
    MOVK  X20, #0x180f, LSL #48
    SUB  X29, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X29, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0x30b6, LSL #48
    SUB  X29, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X20, #0x6fcd, LSL #0
    SUB  X29, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X29, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X29, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x100, LSL #16
    SUB  X29, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X4, #0xf, LSL #0
TSRTIntCRCAndShiftAndMov_label_4:
    MOVZ  W8, #0x42d1, LSL #16
    LSL  X17, X4, #35
    LSL  W5, W13, #6
    LSL  W27, W27, #7
    LSL  X26, X23, X29
    CRC32CB  W29, W7, W3
    CRC32B  W7, W9, W27
    LSR  X7, X25, #0x3c
    MOVN  X5, #0x8e27, LSL #0
    MOVN  X17, #0xef67, LSL #16
    LSR  X8, X8, X24
    CRC32B  W15, W7, W29
    CRC32CH  W17, W17, W8
    CRC32B  W29, W17, W5
    LSR  W17, W15, W29
    CRC32CW  W17, W17, W26
    MOV  W20, W28
    MOV  W26, W20
    LSL  W8, W26, #23
    MOV  W15, W8
    LSLV  W9, W17, W17
    LSL  X7, X9, X9
    MOVK  X25, #0x13f7, LSL #32
    LSL  X26, X15, X15
    CRC32CB  W24, W25, W7
    CRC32W  W23, W26, W24
    LSLV  X27, X16, X5
    CRC32B  W15, W23, W19
    LSR  W9, W2, #0x6
    LSL  W29, W23, #22
    MOVZ  W19, #0xc3db, LSL #0
    LSL  W7, W4, W4
    MOVN  X25, #0x5e4f, LSL #48
    MOVN  X8, #0xfb96, LSL #16
    MOVK  W26, #0xbf9b, LSL #16
    LSLV  W28, W27, W26
    LSL  W17, W29, W28
    MOVK  W26, #0x87b5, LSL #16
    CRC32W  W28, W26, W26
    MOV  X5, X15
    MOV  W15, W8
    MOVN  X23, #0xd26f, LSL #48
    CRC32W  W27, W23, W17
    MOVZ  X26, #0xa95e, LSL #16
    CRC32CX  W28, W26, X15
    LSR  X17, X19, #0xf
    CRC32CX  W23, W25, X27
    LSR  X24, X28, #0x21
    MOVN  X27, #0xe450, LSL #0
    LSL  W28, W27, W23
    MOVZ  W15, #0x9b1a, LSL #16
    MOVK  X16, #0x8002, LSL #32
    MOVZ  X26, #0xf935, LSL #0
    LSR  X25, X15, X15
    LSR  W2, W17, #0x1c
    CRC32CH  W26, W9, W25
    MOVK  X9, #0x2221, LSL #16
    MOV  X8, X16
    CRC32B  W17, W2, W7
    MOVZ  X29, #0x2160, LSL #16
    LSRV  X15, X26, X5
    LSR  W2, W9, #0x10
    LSL  W25, W16, W28
    LSRV  X23, X24, X17
    MOVK  W19, #0x6c2e, LSL #0
    MOVN  X16, #0x5c47, LSL #48
    LSRV  X7, X15, X29
    LSR  X5, X7, #0x3e
    LSR  X26, X5, #0x28
    MOV  X9, X8
    LSL  X27, X16, #26
    CRC32CH  W15, W2, W20
    CRC32CW  W28, W19, W27
    MOVK  X2, #0x55a, LSL #32
    MOVK  W7, #0xe587, LSL #16
    MOVZ  X24, #0xe3d2, LSL #0
    MOV  X5, X15
    MOV  W20, W28
    CRC32CX  W27, W25, X9
    LSL  W17, W27, #15
    MOV  X19, X17
    LSRV  W8, W19, W5
    MOVZ  X20, #0xefe8, LSL #0
    MOV  X27, X23
    LSLV  X9, X24, X5
    LSR  X25, X25, X26
    LSRV  X17, X25, X7
    MOV  X26, X2
    CRC32CH  W24, W17, W25
    MOV  W15, W26
    MOVZ  X2, #0xab30, LSL #0
    MOV  W7, W9
    LSL  X28, X8, X13
    MOVZ  X8, #0x2dd2, LSL #48
    MOVZ  X19, #0x3fbd, LSL #48
    LSR  W26, W20, #0xa
    MOV  X17, X8
    MOV  W8, W26
    MOVZ  X23, #0x1776, LSL #48
    LSL  W16, W23, #3
    LSR  W20, W24, W15
    CRC32CH  W26, W2, W28
    MOV  W15, W27
    CRC32CX  W2, W20, X19
    MOVN  W20, #0xf31e, LSL #16
    LSL  X19, X8, X2
    MOV  X5, X19
    MOV  W9, W16
    LSL  X28, X23, X20
    LSL  X8, X26, X17
    LSR  X23, X7, #0x3b
    LSL  X27, X2, X15
    CRC32X  W24, W27, X9
    MOVZ  X26, #0xd6b, LSL #0
    LSRV  W27, W5, W5
    MOVZ  W7, #0x1fff, LSL #0
    MOVN  W5, #0xfda, LSL #16
    LSL  X2, X12, X23
    CRC32B  W20, W24, W24
    LSRV  W24, W8, W26
    CRC32CX  W9, W24, X28
    MOVK  W12, #0x5fdd, LSL #0
    MOVN  X13, #0xedd7, LSL #16
    MOVN  W23, #0x6a47, LSL #16
    MOVN  X17, #0xa67f, LSL #48
    MOVN  X19, #0x6695, LSL #0
    LSR  W16, W7, W27
    MOV  W8, W12
    CRC32CW  W15, W5, W13
    LSL  X26, X9, X20
    CRC32H  W28, W2, W8
    LSL  X8, X28, #61
    LSLV  X12, X23, X8
    LSRV  X8, X26, X26
    MOV  X26, X19
    MOV  X23, X15
    MOVN  X15, #0xc893, LSL #32
    MOVZ  W24, #0xc640, LSL #0
    CRC32CH  W27, W17, W8
    MOV  X7, X2
    MOVK  W19, #0x2250, LSL #0
    MOVZ  W17, #0x8bff, LSL #0
    LSR  X8, X17, X19
    LSL  W13, W7, W12
    MOV  X12, X23
    LSL  X28, X16, X13
    MOVZ  X5, #0x881b, LSL #48
    LSL  X2, X28, X27
    LSL  W19, W24, W24
    LSLV  X3, X26, X12
    LSL  X24, X8, X15
    MOV  X17, X24
    CRC32CW  W27, W19, W5
    LSRV  W7, W27, W27
    CRC32CH  W12, W3, W7
    CRC32B  W13, W12, W17
    LSL  W27, W2, #11
    LSRV  X3, X13, X13
    LSR  W2, W3, W27
    LSR  X3, X4, X7
    MOVK  W15, #0xf7f5, LSL #0
    CRC32H  W3, W16, W13
    CRC32CH  W23, W4, W2
    MOVN  X17, #0x2e9c, LSL #0
    LSRV  W28, W29, W9
    LSL  W24, W16, W3
    CRC32CH  W16, W23, W10
    LSRV  W12, W5, W13
    MOVZ  X17, #0xef90, LSL #16
    MOVZ  X26, #0x6404, LSL #16
    LSRV  W24, W25, W26
    CRC32W  W5, W5, W10
    MOVZ  W19, #0x4c81, LSL #0
    MOV  X26, X3
    LSR  X27, X16, #0x3
    LSL  W25, W24, W3
    CRC32H  W10, W12, W28
    CRC32CH  W2, W17, W5
    MOV  W16, W26
    CRC32CB  W29, W7, W2
    LSRV  X2, X29, X25
    LSR  W23, W19, #0x2
    CRC32X  W13, W2, X10
    LSRV  X24, X15, X23
    LSR  X3, X16, #0xf
    LSLV  W12, W24, W24
    MOVK  X24, #0xdf5c, LSL #48
    MOV  W19, W24
    MOVZ  X26, #0x826f, LSL #0
    CRC32H  W2, W13, W26
    LSR  X26, X3, #0x28
    LSL  X15, X19, X27
    MOV  X27, X2
    LSR  X10, X15, #0x24
    LSRV  X28, X27, X12
    MOVN  W16, #0x458, LSL #0
    CRC32W  W7, W16, W26
    CRC32CX  W28, W7, X7
    MOVN  W3, #0x34d3, LSL #0
    CRC32CH  W24, W28, W10
    SUBS  X4, X4, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_4
    MOVZ  X18, #0xbc61, LSL #0
    MOVK  X18, #0x7b99, LSL #16
    SUB  X21, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0xcb2c, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X21, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0xaf72, LSL #0
    MOVK  X18, #0xd70b, LSL #16
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x5d58, LSL #0
    MOVK  X18, #0x28c6, LSL #16
    SUB  X21, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0xd657, LSL #0
    MOVK  X18, #0x9577, LSL #16
    SUB  X21, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0xfba7, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xef90, LSL #16
    SUB  X21, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x5cc3, LSL #0
    MOVK  X18, #0xd4, LSL #16
    SUB  X21, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x1320, LSL #0
    SUB  X21, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x9c00, LSL #0
    MOVK  X18, #0xffee, LSL #16
    SUB  X21, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0xbc61, LSL #0
    MOVK  X18, #0x7b99, LSL #16
    SUB  X21, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x4fba, LSL #0
    MOVK  X18, #0x1747, LSL #16
    SUB  X21, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
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
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
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
    MOVZ  X27, #0xf, LSL #0
TSRTIntCRCAndShiftAndMov_label_5:
    MOV  X15, X28
    CRC32X  W19, W25, X25
    MOVZ  W19, #0xdcaf, LSL #0
    LSLV  W21, W26, W29
    LSRV  W20, W21, W19
    MOVN  W3, #0x791a, LSL #0
    CRC32CX  W29, W3, X27
    LSR  W12, W24, #0x6
    MOVN  W29, #0x6fc8, LSL #0
    CRC32B  W26, W15, W29
    MOV  W9, W20
    CRC32H  W18, W26, W9
    LSL  W24, W12, #8
    CRC32B  W13, W25, W18
    LSL  W15, W24, #22
    LSRV  W26, W15, W15
    MOVK  X8, #0x470f, LSL #16
    LSR  X28, X8, #0x2c
    CRC32X  W25, W13, X13
    LSR  X9, X25, X25
    LSL  X19, X28, X26
    MOV  X21, X19
    LSLV  W21, W21, W9
    LSRV  X12, X21, X21
    LSLV  X8, X3, X18
    MOVK  X24, #0xea9f, LSL #0
    CRC32CH  W25, W9, W3
    CRC32CX  W28, W18, X12
    LSR  X8, X26, #0x3e
    CRC32CW  W20, W3, W18
    MOVK  W21, #0x5b4e, LSL #16
    LSLV  X9, X10, X24
    CRC32CW  W24, W5, W15
    LSL  X29, X8, X2
    MOVN  X19, #0x48af, LSL #16
    MOV  W3, W2
    MOV  X26, X25
    MOVZ  W12, #0xb116, LSL #0
    MOVN  X13, #0xb705, LSL #0
    LSRV  X8, X12, X12
    MOV  W25, W8
    MOVN  X10, #0xae82, LSL #32
    CRC32H  W12, W3, W20
    LSR  X8, X10, #0x31
    LSLV  X10, X13, X13
    LSR  W5, W12, #0x10
    MOVK  X13, #0xb0e1, LSL #16
    CRC32CB  W2, W8, W29
    MOVN  X15, #0x41b8, LSL #32
    MOVZ  X18, #0xd4ec, LSL #16
    LSR  W29, W10, #0x18
    CRC32CW  W10, W9, W24
    CRC32CH  W2, W19, W10
    MOV  W3, W13
    MOV  X8, X26
    MOVZ  W20, #0xd8a7, LSL #16
    CRC32X  W10, W2, X2
    LSL  W26, W3, W10
    CRC32W  W13, W20, W29
    MOVK  X19, #0x7d0c, LSL #48
    MOV  W24, W19
    LSL  X19, X25, #23
    LSR  X10, X18, X5
    LSRV  W18, W13, W26
    MOVN  W20, #0x84e, LSL #0
    MOVZ  W25, #0x455a, LSL #16
    CRC32H  W2, W25, W10
    CRC32X  W3, W18, X18
    MOV  W25, W19
    LSR  W12, W8, W8
    LSRV  W5, W3, W25
    MOV  X10, X2
    CRC32CW  W29, W10, W15
    CRC32CB  W13, W20, W29
    CRC32X  W18, W24, X5
    MOVK  X8, #0xa405, LSL #16
    CRC32CB  W25, W13, W10
    MOVK  W26, #0x971a, LSL #16
    LSR  W20, W26, #0x2
    CRC32CB  W5, W12, W20
    CRC32B  W13, W18, W25
    MOVN  W15, #0xe1e3, LSL #0
    CRC32CX  W18, W8, X12
    LSR  X18, X5, X15
    CRC32CH  W4, W18, W13
    LSLV  X15, X20, X3
    MOVK  X24, #0x8c86, LSL #48
    CRC32CW  W3, W12, W13
    LSR  W2, W18, #0x4
    LSL  X25, X8, #16
    MOVZ  X5, #0x25f3, LSL #0
    CRC32X  W13, W16, X15
    MOV  X16, X26
    LSR  X8, X24, X29
    LSL  X10, X8, X18
    MOV  X19, X8
    CRC32W  W12, W3, W2
    LSR  W15, W4, W4
    CRC32X  W18, W15, X5
    CRC32CW  W5, W19, W25
    LSL  X3, X13, #29
    LSL  X26, X18, #26
    CRC32B  W2, W16, W16
    CRC32W  W16, W18, W10
    LSL  W20, W10, #24
    CRC32CH  W15, W2, W3
    CRC32X  W3, W15, X16
    LSR  W13, W3, W26
    MOVK  W18, #0xab79, LSL #0
    CRC32CW  W16, W12, W18
    MOVZ  W26, #0x4f6a, LSL #0
    CRC32W  W8, W17, W26
    LSR  W10, W5, W16
    LSR  X2, X13, #0x3b
    LSRV  X16, X20, X2
    MOV  X3, X10
    MOVK  W12, #0xfd6b, LSL #16
    MOVK  W13, #0x89c2, LSL #16
    LSR  W17, W8, W8
    LSLV  W20, W13, W17
    LSL  W8, W20, #15
    CRC32X  W15, W18, X16
    CRC32CB  W20, W3, W15
    CRC32B  W15, W12, W15
    LSR  W13, W20, #0x8
    LSLV  X16, X13, X8
    LSLV  X10, X15, X15
    MOV  W25, W10
    LSL  W19, W16, #30
    CRC32CH  W2, W25, W19
    LSR  W13, W5, W15
    LSRV  W10, W8, W25
    MOV  W8, W18
    CRC32CH  W20, W19, W18
    LSR  W5, W24, W13
    LSLV  X12, X25, X9
    MOVK  W17, #0xdcd3, LSL #0
    MOVN  X16, #0xd195, LSL #16
    LSL  W18, W16, #12
    LSL  W26, W24, W2
    CRC32B  W9, W18, W8
    LSL  X3, X17, #53
    CRC32H  W17, W9, W13
    MOV  X19, X24
    MOV  W15, W10
    MOVZ  W25, #0x3da7, LSL #16
    CRC32B  W15, W26, W5
    CRC32B  W16, W3, W20
    LSR  X3, X12, X12
    CRC32CB  W24, W3, W17
    LSL  W12, W24, W19
    MOVK  X10, #0xe67c, LSL #32
    LSL  X19, X10, X12
    LSLV  X12, X15, X16
    MOVN  W13, #0x9d8e, LSL #16
    LSLV  W26, W12, W13
    CRC32H  W2, W26, W25
    LSR  X12, X2, X19
    LSR  W9, W27, #0x3
    CRC32H  W2, W25, W4
    MOV  W8, W19
    MOVK  W15, #0xcf4f, LSL #0
    CRC32CB  W5, W8, W26
    CRC32H  W24, W19, W13
    MOVK  X18, #0x4ecd, LSL #48
    MOV  W16, W3
    LSL  W3, W15, W10
    CRC32CX  W8, W9, X8
    LSR  W9, W16, #0x19
    MOVZ  W15, #0xdee8, LSL #0
    LSLV  W19, W3, W13
    LSLV  X26, X8, X19
    CRC32CW  W16, W9, W18
    LSR  W10, W2, W16
    LSRV  W4, W8, W26
    CRC32H  W2, W10, W4
    LSLV  X8, X26, X15
    LSL  W10, W8, W2
    CRC32H  W25, W5, W12
    LSL  X12, X25, X4
    LSRV  X26, X10, X24
    CRC32CH  W15, W26, W12
    MOVK  X5, #0x16c3, LSL #32
    MOVZ  X3, #0x7774, LSL #32
    CRC32H  W3, W27, W28
    MOVK  W28, #0x5211, LSL #0
    MOVZ  X18, #0x33ec, LSL #0
    MOV  X15, X19
    MOVK  W13, #0x92c5, LSL #0
    MOV  W19, W20
    CRC32CW  W16, W3, W25
    LSR  X9, X10, X15
    LSR  W3, W5, W25
    LSR  W25, W26, #0x17
    MOV  X26, X4
    LSL  X24, X28, #1
    CRC32CW  W12, W3, W24
    LSL  W8, W5, W9
    LSL  W20, W9, W18
    LSL  X18, X26, #20
    SUBS  X27, X27, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_5
    MOVZ  X23, #0x5f4b, LSL #0
    MOVK  X23, #0x7a6f, LSL #16
    SUB  X7, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x78, LSL #0
    SUB  X7, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x3d, LSL #0
    SUB  X7, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xf1, LSL #16
    MOVK  X23, #0x16c3, LSL #32
    SUB  X7, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xf1, LSL #16
    SUB  X7, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0xc139, LSL #0
    MOVK  X23, #0xaa8b, LSL #16
    SUB  X7, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x92c5, LSL #0
    MOVK  X23, #0x6271, LSL #16
    SUB  X7, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x8000, LSL #16
    SUB  X7, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x646c, LSL #0
    MOVK  X23, #0x82b2, LSL #16
    SUB  X7, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0xccfd, LSL #0
    MOVK  X23, #0xf1ac, LSL #16
    SUB  X7, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x3d0, LSL #16
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0xd1d5, LSL #0
    MOVK  X23, #0xa2d, LSL #16
    SUB  X7, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x5b4e, LSL #16
    SUB  X7, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0xa422, LSL #0
    MOVK  X23, #0xb8c6, LSL #16
    MOVK  X23, #0x1, LSL #32
    SUB  X7, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x3d, LSL #0
    SUB  X7, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x5211, LSL #0
    MOVK  X23, #0xdc63, LSL #16
    SUB  X7, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0xac38, LSL #0
    MOVK  X23, #0x4083, LSL #16
    SUB  X7, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X2, #0x2b50, LSL #0
    MOVK  X2, #0x7e2d, LSL #16
    MOVK  X2, #0xbe9c, LSL #32
    MOVK  X2, #0x4a03, LSL #48
    MOVZ  X3, #0xbdd8, LSL #0
    MOVK  X3, #0x3e94, LSL #16
    MOVK  X3, #0xaf43, LSL #32
    MOVK  X3, #0x67f, LSL #48
    MOVZ  X4, #0x158a, LSL #0
    MOVK  X4, #0x845, LSL #16
    MOVK  X4, #0x6d20, LSL #32
    MOVK  X4, #0xb89a, LSL #48
    MOVZ  X5, #0x2258, LSL #0
    MOVK  X5, #0x7311, LSL #16
    MOVK  X5, #0x1305, LSL #32
    MOVK  X5, #0xdbe2, LSL #48
    MOVZ  X7, #0x168a, LSL #0
    MOVK  X7, #0x187d, LSL #16
    MOVK  X7, #0x1160, LSL #32
    MOVK  X7, #0xdc44, LSL #48
    MOVZ  X8, #0x814e, LSL #0
    MOVK  X8, #0x7821, LSL #16
    MOVK  X8, #0x2f03, LSL #32
    MOVK  X8, #0x3ac3, LSL #48
    MOVZ  X9, #0xf0e1, LSL #0
    MOVK  X9, #0x6e94, LSL #16
    MOVK  X9, #0x6333, LSL #32
    MOVK  X9, #0x4c2a, LSL #48
    MOVZ  X10, #0x2459, LSL #0
    MOVK  X10, #0x6183, LSL #16
    MOVK  X10, #0x6a88, LSL #32
    MOVK  X10, #0xe9f3, LSL #48
    MOVZ  X12, #0x5215, LSL #0
    MOVK  X12, #0xd9c7, LSL #16
    MOVK  X12, #0x4ac6, LSL #32
    MOVK  X12, #0x4bb7, LSL #48
    MOVZ  X13, #0x13eb, LSL #0
    MOVK  X13, #0xb7cf, LSL #16
    MOVK  X13, #0x230f, LSL #32
    MOVK  X13, #0xee67, LSL #48
    MOVZ  X15, #0xa1b6, LSL #0
    MOVK  X15, #0xf095, LSL #16
    MOVK  X15, #0x7f52, LSL #32
    MOVK  X15, #0xde37, LSL #48
    MOVZ  X16, #0x47f1, LSL #0
    MOVK  X16, #0x4fe4, LSL #16
    MOVK  X16, #0x29e3, LSL #32
    MOVK  X16, #0x1156, LSL #48
    MOVZ  X17, #0x7809, LSL #0
    MOVK  X17, #0x65e7, LSL #16
    MOVK  X17, #0xe672, LSL #32
    MOVK  X17, #0xbcde, LSL #48
    MOVZ  X18, #0xe03c, LSL #0
    MOVK  X18, #0x5b61, LSL #16
    MOVK  X18, #0xafd9, LSL #32
    MOVK  X18, #0x66ca, LSL #48
    MOVZ  X19, #0xbd38, LSL #0
    MOVK  X19, #0x633c, LSL #16
    MOVK  X19, #0x16c4, LSL #32
    MOVK  X19, #0x74f6, LSL #48
    MOVZ  X20, #0x7431, LSL #0
    MOVK  X20, #0x8e91, LSL #16
    MOVK  X20, #0xac98, LSL #32
    MOVK  X20, #0x6223, LSL #48
    MOVZ  X21, #0x7f6d, LSL #0
    MOVK  X21, #0x2f99, LSL #16
    MOVK  X21, #0x23a9, LSL #32
    MOVK  X21, #0x662e, LSL #48
    MOVZ  X23, #0x79f7, LSL #0
    MOVK  X23, #0x26bc, LSL #16
    MOVK  X23, #0x1b70, LSL #32
    MOVK  X23, #0x3ffb, LSL #48
    MOVZ  X24, #0xf5dc, LSL #0
    MOVK  X24, #0x1397, LSL #16
    MOVK  X24, #0xc06e, LSL #32
    MOVK  X24, #0x952, LSL #48
    MOVZ  X25, #0x32d2, LSL #0
    MOVK  X25, #0xb5c, LSL #16
    MOVK  X25, #0xcbc3, LSL #32
    MOVK  X25, #0x9d19, LSL #48
    MOVZ  X26, #0xffea, LSL #0
    MOVK  X26, #0x8a9a, LSL #16
    MOVK  X26, #0x2d59, LSL #32
    MOVK  X26, #0x2fc4, LSL #48
    MOVZ  X27, #0x5b0, LSL #0
    MOVK  X27, #0x681, LSL #16
    MOVK  X27, #0xb28, LSL #32
    MOVK  X27, #0xfb63, LSL #48
    MOVZ  X28, #0xc8a4, LSL #0
    MOVK  X28, #0x1e1b, LSL #16
    MOVK  X28, #0x7d6c, LSL #32
    MOVK  X28, #0x37, LSL #48
    MOVZ  X29, #0xbd9e, LSL #0
    MOVK  X29, #0x5621, LSL #16
    MOVK  X29, #0x6d75, LSL #32
    MOVK  X29, #0x8388, LSL #48
    MOVZ  X17, #0xf, LSL #0
TSRTIntCRCAndShiftAndMov_label_6:
    MOVK  X15, #0x5cc1, LSL #48
    LSRV  X18, X21, X28
    CRC32CB  W25, W5, W25
    CRC32CX  W21, W15, X29
    LSL  W8, W18, W24
    LSL  X16, X17, X8
    CRC32B  W26, W10, W28
    MOVZ  X26, #0x12be, LSL #48
    LSL  W10, W25, W26
    MOVZ  W3, #0x7d09, LSL #0
    MOV  W28, W21
    LSLV  X4, X28, X16
    MOV  W24, W4
    LSLV  X12, X24, X24
    LSR  W4, W10, #0x14
    LSL  W16, W4, W4
    MOVN  W28, #0x8c68, LSL #0
    LSL  X29, X3, X12
    LSL  X13, X19, X29
    LSR  W8, W16, W13
    MOVN  W15, #0x42ee, LSL #0
    CRC32X  W12, W8, X28
    MOV  X5, X12
    MOV  X29, X15
    LSL  X8, X29, X29
    MOVK  W16, #0xe619, LSL #0
    MOV  X15, X16
    MOV  W3, W18
    CRC32CX  W16, W15, X3
    LSRV  W24, W8, W16
    MOVK  X10, #0xd9f4, LSL #0
    MOV  W29, W10
    LSR  X13, X29, #0x28
    LSRV  W4, W5, W13
    LSLV  W18, W24, W24
    LSR  W8, W18, W18
    LSRV  W15, W8, W4
    CRC32H  W13, W29, W3
    LSR  W28, W25, W19
    LSRV  X4, X7, X13
    CRC32X  W16, W23, X25
    CRC32CB  W23, W13, W3
    LSR  X10, X24, X5
    CRC32CH  W8, W25, W15
    MOVZ  W18, #0xb4c3, LSL #0
    CRC32CH  W5, W18, W24
    MOVK  W7, #0x2a5d, LSL #0
    LSR  X18, X10, #0x38
    MOVK  X19, #0x7dfc, LSL #32
    LSRV  X29, X28, X19
    MOVK  W28, #0x1012, LSL #0
    CRC32CW  W19, W28, W28
    LSR  X12, X19, X5
    CRC32X  W15, W23, X23
    MOV  X10, X7
    LSLV  X28, X8, X10
    LSR  X24, X18, #0x36
    CRC32H  W10, W24, W16
    MOVZ  X19, #0xdf29, LSL #48
    CRC32CX  W24, W29, X29
    CRC32B  W13, W24, W28
    LSR  X23, X12, #0xf
    LSL  W25, W13, #18
    MOVZ  W3, #0xf43c, LSL #0
    LSR  W5, W15, #0x19
    LSL  X28, X23, X10
    CRC32X  W10, W28, X28
    LSL  W13, W25, #10
    CRC32CH  W25, W19, W19
    LSLV  W7, W3, W4
    LSLV  W8, W10, W10
    MOVK  W4, #0xb539, LSL #0
    CRC32CW  W24, W5, W5
    CRC32X  W29, W13, X13
    MOV  X10, X24
    CRC32W  W13, W25, W29
    CRC32CH  W12, W8, W7
    MOV  W16, W13
    MOV  W7, W16
    MOV  X3, X26
    CRC32CB  W5, W3, W4
    MOVK  X3, #0xde0f, LSL #48
    LSL  W24, W12, W7
    LSL  X19, X5, X5
    LSLV  X7, X24, X24
    LSLV  W23, W10, W19
    LSR  X16, X7, X13
    MOVZ  X24, #0xf7a4, LSL #32
    CRC32B  W26, W23, W3
    MOVZ  X3, #0xca5a, LSL #0
    LSR  W28, W3, #0x5
    MOV  X15, X26
    CRC32CX  W25, W24, X16
    MOV  W5, W15
    MOV  X16, X28
    LSL  W19, W8, W16
    LSRV  X4, X25, X25
    CRC32CB  W24, W5, W4
    LSR  W7, W19, W19
    LSR  W15, W7, W28
    LSL  W7, W24, #16
    MOVK  W19, #0x6a47, LSL #0
    MOVZ  W24, #0xb16d, LSL #16
    LSR  W25, W24, W24
    LSL  W13, W7, #9
    MOVK  W8, #0xdba9, LSL #0
    MOVK  X24, #0x4b50, LSL #0
    LSR  W3, W15, #0x9
    CRC32CX  W12, W24, X13
    CRC32CW  W16, W3, W3
    LSRV  W28, W25, W25
    CRC32H  W24, W19, W3
    CRC32B  W19, W24, W12
    CRC32X  W4, W19, X16
    LSRV  W12, W8, W8
    CRC32H  W24, W28, W12
    CRC32CB  W7, W24, W4
    CRC32CB  W26, W7, W18
    LSLV  X4, X16, X8
    MOVN  W15, #0x14cf, LSL #16
    CRC32CB  W13, W4, W29
    LSR  W16, W4, #0x1
    MOVK  W8, #0xe528, LSL #16
    LSLV  X28, X17, X18
    LSR  X29, X4, #0x5
    MOVZ  W4, #0xad04, LSL #16
    CRC32X  W25, W8, X4
    CRC32CH  W18, W12, W18
    CRC32CW  W7, W23, W2
    LSL  X8, X29, #7
    LSR  X19, X8, #0x17
    MOVZ  W12, #0xa19a, LSL #0
    CRC32CH  W4, W15, W28
    LSR  X2, X13, #0x4
    LSL  W13, W19, #8
    MOV  W28, W4
    CRC32H  W29, W7, W26
    MOVN  X16, #0xa9bb, LSL #0
    CRC32B  W7, W16, W25
    LSR  W16, W13, W18
    MOVZ  X4, #0x4c5c, LSL #48
    LSR  X8, X29, #0x25
    LSLV  X19, X16, X7
    CRC32CB  W15, W8, W28
    CRC32H  W8, W29, W12
    CRC32B  W23, W29, W15
    CRC32X  W12, W8, X23
    MOV  X16, X4
    MOV  W7, W2
    MOVN  W13, #0xfc6f, LSL #0
    MOV  W15, W16
    CRC32CH  W26, W19, W12
    MOVK  X23, #0xba19, LSL #48
    CRC32B  W29, W7, W23
    MOV  X23, X26
    MOV  W26, W13
    MOVK  W20, #0xec1, LSL #0
    CRC32CH  W25, W26, W15
    LSR  W7, W23, W25
    LSL  W26, W29, #8
    LSL  W25, W7, #8
    CRC32W  W19, W20, W20
    MOVZ  X29, #0x2b2a, LSL #0
    CRC32H  W8, W29, W26
    LSL  W26, W19, #24
    MOVK  W13, #0x1ce1, LSL #0
    CRC32X  W12, W13, X8
    CRC32CW  W29, W26, W12
    CRC32W  W19, W29, W29
    CRC32CW  W20, W19, W25
    LSR  X15, X2, X21
    CRC32B  W7, W21, W13
    MOVN  X8, #0x16d2, LSL #0
    LSR  X23, X2, X29
    LSRV  X26, X7, X25
    CRC32CB  W21, W5, W20
    CRC32CB  W5, W5, W24
    LSR  W7, W29, W5
    MOV  W29, W28
    MOVN  X19, #0xedc, LSL #16
    LSLV  X13, X18, X21
    CRC32CB  W21, W19, W17
    MOVZ  W5, #0x9842, LSL #0
    LSRV  X18, X15, X29
    LSL  W2, W13, #5
    LSLV  X13, X2, X21
    LSRV  W25, W7, W13
    MOV  W13, W5
    CRC32X  W20, W13, X18
    LSRV  X13, X25, X29
    CRC32CW  W18, W13, W13
    LSLV  X12, X26, X18
    MOVN  W15, #0x5414, LSL #16
    MOV  W25, W20
    LSR  X24, X25, #0xf
    CRC32W  W5, W12, W24
    LSL  X25, X23, X15
    LSR  X29, X5, X5
    LSRV  X20, X25, X29
    LSL  W19, W20, #6
    SUBS  X17, X17, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_6
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x4c5c, LSL #48
    SUB  X9, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X27, #0x8771, LSL #0
    MOVK  X27, #0x48c4, LSL #16
    SUB  X9, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X27, #0x2bf, LSL #0
    SUB  X9, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X27, #0xe92d, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X9, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X27, #0x1d9a, LSL #0
    MOVK  X27, #0x6ffd, LSL #16
    SUB  X9, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xabeb, LSL #16
    SUB  X9, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x4c5c, LSL #48
    SUB  X9, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X27, #0xf3ad, LSL #0
    MOVK  X27, #0x5fe7, LSL #16
    SUB  X9, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X27, #0x6f3f, LSL #0
    MOVK  X27, #0x1, LSL #16
    SUB  X9, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X27, #0x1d9a, LSL #0
    MOVK  X27, #0x6ffd, LSL #16
    SUB  X9, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X27, #0x495, LSL #0
    MOVK  X27, #0x1d3c, LSL #16
    SUB  X9, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X24, #0xf, LSL #0
TSRTIntCRCAndShiftAndMov_label_7:
    LSRV  W26, W8, W27
    LSL  X3, X18, X25
    MOVK  X25, #0xe49a, LSL #0
    MOVN  X29, #0x201b, LSL #48
    CRC32CB  W18, W20, W17
    CRC32CX  W20, W19, X29
    LSRV  X15, X25, X24
    MOVK  W26, #0x5c81, LSL #16
    LSL  X21, X20, #27
    MOVN  W27, #0xd2c9, LSL #16
    CRC32B  W26, W23, W16
    CRC32W  W20, W10, W3
    LSL  W8, W13, #22
    LSL  X21, X15, X27
    CRC32CW  W21, W28, W8
    CRC32CB  W13, W21, W20
    LSL  X20, X18, #62
    LSRV  W10, W20, W26
    MOVN  W25, #0x4e0, LSL #16
    MOVZ  X3, #0xfdc, LSL #32
    LSR  W15, W3, W9
    LSLV  X9, X13, X15
    CRC32B  W17, W25, W9
    CRC32CW  W19, W17, W10
    MOV  W8, W9
    MOVZ  X13, #0xc316, LSL #0
    MOV  W29, W24
    LSR  X3, X3, #0xc
    LSR  W21, W2, W17
    MOV  W20, W20
    LSR  W2, W26, W21
    MOV  W10, W2
    MOVZ  W28, #0xfa02, LSL #16
    LSL  W25, W28, #15
    CRC32H  W15, W20, W12
    CRC32CX  W18, W3, X12
    LSR  W12, W8, W3
    LSLV  X26, X20, X25
    LSL  X3, X26, #44
    LSRV  W21, W27, W13
    LSL  W28, W29, W25
    LSR  X29, X7, X16
    MOV  X18, X3
    LSR  W20, W10, #0x1c
    CRC32CB  W2, W29, W21
    MOV  X25, X18
    MOVZ  W18, #0x8c3c, LSL #0
    LSLV  W27, W15, W28
    LSR  W26, W25, #0x11
    CRC32H  W10, W12, W19
    MOVN  W15, #0x64bd, LSL #0
    MOVZ  X19, #0x9762, LSL #48
    LSR  X28, X20, X10
    MOV  X12, X17
    LSLV  W29, W12, W26
    CRC32H  W8, W15, W19
    LSR  W13, W27, W8
    MOVZ  W16, #0x3e1, LSL #16
    CRC32CX  W21, W18, X2
    LSR  X26, X7, X28
    CRC32H  W20, W26, W16
    MOV  W26, W29
    CRC32H  W7, W21, W24
    LSL  X29, X26, #30
    CRC32CX  W10, W25, X7
    LSL  W16, W20, W13
    MOVN  X18, #0xbf19, LSL #0
    LSR  X25, X29, #0x31
    LSL  X3, X25, X10
    LSLV  X2, X3, X3
    MOVK  W21, #0x4c09, LSL #16
    LSR  W3, W16, #0x11
    MOV  W7, W3
    CRC32CX  W25, W18, X18
    MOVK  X2, #0x6e07, LSL #32
    MOV  W27, W2
    LSRV  W20, W27, W25
    MOV  W17, W13
    CRC32CH  W18, W7, W21
    CRC32B  W2, W20, W20
    CRC32CB  W7, W18, W17
    LSL  X10, X7, #20
    CRC32CW  W20, W10, W13
    LSL  W19, W2, W27
    CRC32B  W28, W20, W19
    CRC32CH  W15, W23, W21
    LSR  X20, X12, X16
    LSLV  X26, X17, X16
    CRC32CX  W27, W8, X21
    CRC32X  W8, W18, X9
    LSR  X9, X17, #0x29
    LSR  X7, X20, #0x4
    MOV  X13, X24
    CRC32B  W18, W19, W10
    LSR  W10, W9, #0x17
    MOVN  X2, #0xcc07, LSL #0
    CRC32X  W21, W27, X13
    MOV  W16, W8
    CRC32H  W9, W28, W9
    LSLV  X8, X2, X9
    LSR  X12, X26, X21
    LSL  X19, X16, X15
    CRC32CH  W25, W19, W7
    MOVN  W15, #0x2b70, LSL #0
    MOVN  X19, #0x14ab, LSL #48
    MOV  X17, X12
    LSLV  X2, X8, X19
    LSR  W8, W2, W25
    LSL  X7, X17, X8
    LSL  W9, W18, W7
    MOVK  X28, #0x8d6f, LSL #48
    CRC32CH  W23, W7, W10
    MOVZ  X17, #0x9422, LSL #16
    MOVN  X21, #0xc37, LSL #32
    CRC32X  W7, W15, X15
    MOV  W26, W7
    MOVZ  W15, #0xf9ef, LSL #16
    MOV  W12, W23
    LSL  X19, X17, #36
    MOV  W10, W21
    LSR  X16, X26, X9
    MOVK  W7, #0xdfca, LSL #16
    CRC32CX  W21, W28, X28
    MOVN  W9, #0xbb9e, LSL #0
    LSRV  W25, W19, W16
    MOVZ  W13, #0xaa84, LSL #0
    MOV  W2, W15
    LSLV  X15, X13, X2
    LSLV  X8, X12, X12
    CRC32W  W19, W15, W25
    MOVK  W18, #0xabb4, LSL #16
    CRC32B  W13, W20, W9
    CRC32CW  W16, W21, W8
    LSR  W28, W19, W18
    LSR  W26, W13, W13
    LSR  X21, X28, #0x11
    LSR  W17, W10, W28
    CRC32CB  W2, W7, W16
    LSRV  X12, X2, X21
    LSLV  W10, W17, W18
    LSL  W23, W10, #13
    LSL  X28, X23, X12
    LSL  W25, W28, #28
    MOVN  W19, #0x9339, LSL #16
    MOV  X23, X25
    LSL  X7, X26, X19
    MOVZ  X25, #0x9754, LSL #0
    CRC32B  W15, W25, W9
    MOV  W25, W15
    LSL  X17, X7, X23
    LSL  X28, X17, #25
    MOVZ  W10, #0x676c, LSL #0
    CRC32H  W21, W25, W25
    LSL  X25, X28, #31
    MOVN  X23, #0x2493, LSL #16
    MOVK  W8, #0x9d66, LSL #0
    CRC32CH  W16, W8, W10
    CRC32CB  W9, W16, W25
    MOVZ  X19, #0x43f9, LSL #32
    LSL  W25, W17, W19
    MOV  X17, X23
    LSR  X28, X21, X21
    CRC32CB  W8, W9, W17
    LSL  X26, X25, X8
    MOV  W25, W26
    MOV  W19, W25
    MOV  X7, X28
    MOVN  X8, #0xd7b4, LSL #16
    CRC32CH  W9, W25, W8
    LSR  W10, W19, #0xc
    MOVK  X19, #0x6a5d, LSL #16
    CRC32CB  W25, W7, W19
    LSL  X28, X25, #53
    LSL  X25, X28, X26
    LSL  W17, W10, W9
    MOV  W21, W25
    CRC32CB  W23, W17, W17
    MOVK  W16, #0x1e35, LSL #16
    LSL  W15, W16, W16
    MOVK  W17, #0xf0f, LSL #16
    LSL  W16, W21, W16
    MOVZ  W7, #0x1890, LSL #0
    CRC32W  W26, W17, W23
    MOVK  W21, #0xeba8, LSL #16
    LSRV  X25, X15, X7
    CRC32CX  W8, W21, X21
    MOV  X17, X2
    CRC32CH  W3, W16, W16
    LSL  X19, X26, #43
    LSL  W12, W25, #4
    MOVZ  X23, #0x5bdb, LSL #48
    MOVZ  W16, #0x9454, LSL #16
    MOVN  W7, #0xee5b, LSL #0
    LSR  W10, W3, #0xb
    LSR  W3, W10, #0x1
    LSL  X15, X8, #21
    LSLV  W10, W27, W23
    MOV  X27, X10
    CRC32CX  W2, W17, X16
    LSR  W8, W27, #0x1b
    SUBS  X24, X24, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_7
    MOVZ  X4, #0xd71a, LSL #0
    MOVK  X4, #0x7274, LSL #16
    SUB  X5, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X4, #0x11a4, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X5, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X4, #0x11, LSL #0
    SUB  X5, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X4, #0x77d2, LSL #0
    MOVK  X4, #0xe9e, LSL #16
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X4, #0xe6f5, LSL #0
    MOVK  X4, #0x8ea4, LSL #16
    SUB  X5, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X4, #0x8000, LSL #0
    MOVK  X4, #0xd, LSL #16
    SUB  X5, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X4, #0xc678, LSL #0
    MOVK  X4, #0xd469, LSL #16
    SUB  X5, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x9454, LSL #16
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X4, #0xde1c, LSL #0
    MOVK  X4, #0x352e, LSL #16
    SUB  X5, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xabb4, LSL #16
    SUB  X5, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xf000, LSL #32
    MOVK  X4, #0x380a, LSL #48
    SUB  X5, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X4, #0x9a02, LSL #0
    MOVK  X4, #0xd2f6, LSL #16
    SUB  X5, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xeba8, LSL #16
    SUB  X5, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x5bdb, LSL #48
    SUB  X5, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X4, #0xd800, LSL #0
    SUB  X5, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X4, #0x15e, LSL #0
    MOVK  X4, #0x1727, LSL #16
    SUB  X5, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X4, #0xe6f5, LSL #0
    MOVK  X4, #0x8ea4, LSL #16
    SUB  X5, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8000, LSL #16
    MOVK  X4, #0xa680, LSL #32
    MOVK  X4, #0x34bd, LSL #48
    SUB  X5, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
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
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
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
    MOVZ  X29, #0xf, LSL #0
TSRTIntCRCAndShiftAndMov_label_8:
    MOVN  W7, #0x53ae, LSL #0
    MOVN  W17, #0xb955, LSL #16
    CRC32B  W10, W7, W26
    MOV  W10, W17
    LSRV  W15, W10, W27
    MOV  X20, X28
    CRC32CB  W9, W20, W29
    MOVK  W17, #0x70ac, LSL #16
    LSR  X10, X9, X17
    LSRV  W3, W25, W10
    CRC32H  W10, W15, W15
    LSR  X15, X3, #0x15
    CRC32CX  W17, W10, X15
    MOV  W4, W28
    CRC32CH  W7, W3, W25
    CRC32X  W23, W26, X2
    CRC32CB  W2, W19, W28
    CRC32CH  W26, W25, W21
    LSL  X13, X25, X24
    MOVK  X10, #0x6bb6, LSL #16
    MOVK  X23, #0xe43c, LSL #16
    MOVZ  W20, #0xf6d3, LSL #16
    CRC32B  W2, W2, W7
    LSL  W20, W17, W4
    MOV  W7, W20
    MOVN  W10, #0x2515, LSL #0
    MOVK  W26, #0xfe43, LSL #0
    LSR  X7, X26, #0x12
    MOV  X19, X2
    MOVK  W16, #0xc214, LSL #16
    LSL  W19, W10, W13
    LSL  W2, W2, W23
    LSL  X24, X2, #57
    LSR  X10, X19, #0x2c
    CRC32CW  W28, W7, W10
    MOV  W9, W28
    MOV  X25, X9
    MOVZ  X3, #0x2e07, LSL #32
    MOVZ  X19, #0x4077, LSL #32
    LSR  X17, X24, #0x1b
    CRC32CB  W4, W16, W25
    LSRV  W9, W4, W3
    MOV  X20, X23
    MOV  W28, W20
    LSR  W23, W19, #0x11
    CRC32CX  W3, W23, X23
    LSR  W4, W9, #0xa
    CRC32CB  W2, W17, W17
    CRC32W  W7, W9, W2
    CRC32B  W2, W7, W28
    MOVN  W26, #0x2237, LSL #16
    MOVK  W24, #0xc9ba, LSL #16
    CRC32CH  W20, W2, W4
    LSL  W4, W3, W20
    MOVN  W17, #0xf18a, LSL #16
    CRC32B  W7, W26, W26
    MOVZ  W13, #0x51cc, LSL #0
    LSLV  W26, W7, W24
    MOV  X3, X13
    MOVZ  W28, #0xc991, LSL #16
    LSR  W9, W4, W4
    CRC32CH  W2, W17, W17
    LSRV  W23, W26, W3
    MOVK  X16, #0xc10e, LSL #32
    MOV  X17, X16
    LSR  W20, W28, W2
    MOVN  W7, #0x5cd1, LSL #16
    LSLV  X24, X24, X5
    LSRV  W13, W7, W23
    MOVN  X23, #0xaf78, LSL #48
    LSR  X5, X13, #0x21
    MOVK  W26, #0x7c93, LSL #16
    LSL  W16, W20, W20
    LSLV  W4, W23, W9
    CRC32CB  W23, W26, W26
    LSR  W7, W24, W23
    CRC32CH  W13, W4, W26
    MOV  W2, W5
    MOV  W20, W17
    LSL  W28, W20, #10
    MOV  X3, X16
    MOV  W4, W3
    CRC32CH  W3, W28, W7
    LSR  W28, W3, #0x6
    CRC32W  W3, W10, W13
    LSL  X9, X19, X28
    LSR  X10, X2, X4
    CRC32CW  W7, W9, W3
    LSL  W23, W10, #15
    MOV  W17, W23
    MOVK  X10, #0x12b5, LSL #16
    LSR  X2, X20, X10
    CRC32CB  W23, W7, W7
    LSR  X10, X23, X19
    LSR  X13, X17, X17
    CRC32W  W20, W10, W13
    MOVN  X7, #0xc856, LSL #32
    LSL  X28, X7, X7
    LSLV  X17, X28, X20
    CRC32CH  W20, W17, W2
    LSR  W28, W28, #0x1d
    LSL  W9, W7, #14
    LSR  X3, X16, X26
    LSL  X13, X7, #17
    CRC32CB  W4, W15, W25
    MOVK  X17, #0xd3ba, LSL #16
    LSL  X5, X9, #17
    LSLV  W7, W27, W20
    LSR  W23, W27, W29
    MOVK  W9, #0x9362, LSL #0
    MOV  W16, W5
    LSL  W2, W13, #3
    LSL  X13, X28, X3
    CRC32CH  W15, W16, W26
    CRC32B  W25, W23, W13
    CRC32W  W27, W9, W20
    MOVN  X9, #0x74cc, LSL #48
    LSR  W13, W15, #0xb
    CRC32H  W15, W13, W17
    LSR  W28, W20, W4
    LSRV  W28, W25, W25
    LSLV  W3, W7, W7
    MOVZ  W19, #0x2613, LSL #0
    CRC32CH  W5, W28, W27
    LSR  W10, W2, W19
    MOV  W4, W10
    LSL  W20, W3, W9
    CRC32CH  W17, W4, W5
    LSRV  W28, W17, W17
    CRC32B  W25, W20, W20
    LSLV  W7, W25, W25
    MOV  X28, X15
    CRC32B  W25, W28, W28
    LSRV  X20, X25, X25
    LSR  X16, X7, X7
    LSR  W7, W20, #0xa
    LSR  W27, W7, W7
    LSR  X17, X16, X16
    MOV  X13, X27
    MOVK  X16, #0x2366, LSL #16
    MOV  X27, X13
    MOV  W15, W17
    MOV  W5, W15
    LSR  W4, W5, #0x1f
    CRC32CX  W17, W16, X16
    CRC32W  W10, W17, W17
    CRC32H  W7, W10, W4
    MOVZ  X20, #0x438a, LSL #32
    MOVK  X4, #0x34c2, LSL #16
    CRC32W  W5, W27, W4
    LSR  X25, X7, #0x2c
    MOVN  X10, #0x3701, LSL #0
    LSLV  X19, X10, X5
    LSLV  W3, W20, W20
    CRC32CH  W16, W3, W19
    LSL  X19, X16, #14
    CRC32W  W15, W19, W19
    CRC32B  W19, W15, W15
    LSR  X4, X19, #0x17
    LSRV  W7, W25, W4
    CRC32B  W28, W26, W27
    MOV  X15, X25
    LSL  X5, X20, X2
    MOVK  W16, #0x581c, LSL #0
    CRC32X  W3, W21, X13
    CRC32B  W15, W25, W26
    CRC32X  W10, W4, X19
    MOV  W26, W16
    CRC32CH  W4, W25, W27
    LSRV  W20, W4, W8
    MOVK  W17, #0xb04, LSL #0
    LSRV  W8, W28, W17
    MOV  X27, X5
    CRC32CH  W2, W26, W15
    CRC32CX  W17, W27, X3
    MOVK  W21, #0xb81f, LSL #16
    LSR  X8, X2, X2
    MOVK  W2, #0xb866, LSL #16
    LSL  W3, W25, #30
    LSL  X19, X7, #16
    CRC32CX  W25, W2, X17
    CRC32W  W13, W8, W8
    CRC32W  W16, W25, W20
    LSL  W8, W19, W21
    LSR  W26, W3, W10
    LSLV  W3, W8, W16
    LSL  W28, W26, W3
    MOV  W4, W13
    MOVK  X7, #0xd2b8, LSL #16
    LSRV  X17, X28, X7
    LSR  W2, W4, W4
    LSLV  X13, X17, X17
    LSR  W27, W13, #0x1
    CRC32CX  W15, W27, X16
    CRC32X  W5, W15, X2
    MOV  W15, W13
    LSL  X27, X20, #2
    LSLV  W3, W19, W16
    MOVK  X7, #0xced9, LSL #48
    CRC32B  W28, W27, W25
    SUBS  X29, X29, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_8
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X12, #0x8228, LSL #0
    MOVK  X12, #0x9da3, LSL #16
    SUB  X18, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xd2b8, LSL #16
    MOVK  X12, #0xced9, LSL #48
    SUB  X18, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0x8b33, LSL #48
    SUB  X18, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X12, #0x3f19, LSL #0
    MOVK  X12, #0x23bd, LSL #16
    SUB  X18, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xb81f, LSL #16
    SUB  X18, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xba00, LSL #48
    SUB  X18, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X12, #0x538a, LSL #0
    MOVK  X12, #0x4796, LSL #16
    SUB  X18, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X12, #0x6a3e, LSL #0
    MOVK  X12, #0xd6d, LSL #16
    SUB  X18, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X2, #0xf6e1, LSL #0
    MOVK  X2, #0x5f1f, LSL #16
    MOVK  X2, #0x5992, LSL #32
    MOVK  X2, #0x180a, LSL #48
    MOVZ  X3, #0xf8d5, LSL #0
    MOVK  X3, #0xd71, LSL #16
    MOVK  X3, #0x84ea, LSL #32
    MOVK  X3, #0xd157, LSL #48
    MOVZ  X4, #0x9303, LSL #0
    MOVK  X4, #0xa76, LSL #16
    MOVK  X4, #0xadc1, LSL #32
    MOVK  X4, #0xdf1e, LSL #48
    MOVZ  X5, #0x2203, LSL #0
    MOVK  X5, #0x4a6f, LSL #16
    MOVK  X5, #0xd6ff, LSL #32
    MOVK  X5, #0x3b, LSL #48
    MOVZ  X7, #0xd17b, LSL #0
    MOVK  X7, #0x8bc2, LSL #16
    MOVK  X7, #0x1f0d, LSL #32
    MOVK  X7, #0xecb5, LSL #48
    MOVZ  X8, #0xb75f, LSL #0
    MOVK  X8, #0x5ade, LSL #16
    MOVK  X8, #0xc868, LSL #32
    MOVK  X8, #0x28b6, LSL #48
    MOVZ  X9, #0x15de, LSL #0
    MOVK  X9, #0x8867, LSL #16
    MOVK  X9, #0x3e84, LSL #32
    MOVK  X9, #0x7ac9, LSL #48
    MOVZ  X10, #0x7685, LSL #0
    MOVK  X10, #0x1bb3, LSL #16
    MOVK  X10, #0x3311, LSL #32
    MOVK  X10, #0xe39f, LSL #48
    MOVZ  X12, #0x24df, LSL #0
    MOVK  X12, #0x40e0, LSL #16
    MOVK  X12, #0xfa24, LSL #32
    MOVK  X12, #0xc2d9, LSL #48
    MOVZ  X13, #0xab47, LSL #0
    MOVK  X13, #0x227a, LSL #16
    MOVK  X13, #0x2a70, LSL #32
    MOVK  X13, #0xf9fa, LSL #48
    MOVZ  X15, #0xce05, LSL #0
    MOVK  X15, #0x48d8, LSL #16
    MOVK  X15, #0x67e6, LSL #32
    MOVK  X15, #0x7bbc, LSL #48
    MOVZ  X16, #0x3a34, LSL #0
    MOVK  X16, #0x9a42, LSL #16
    MOVK  X16, #0x2a8e, LSL #32
    MOVK  X16, #0x5335, LSL #48
    MOVZ  X17, #0x2f63, LSL #0
    MOVK  X17, #0x1030, LSL #16
    MOVK  X17, #0x3171, LSL #32
    MOVK  X17, #0x2620, LSL #48
    MOVZ  X18, #0xb7f9, LSL #0
    MOVK  X18, #0x9a80, LSL #16
    MOVK  X18, #0x22fd, LSL #32
    MOVK  X18, #0x9331, LSL #48
    MOVZ  X19, #0xa9fa, LSL #0
    MOVK  X19, #0x96b5, LSL #16
    MOVK  X19, #0x18ea, LSL #32
    MOVK  X19, #0xf6cd, LSL #48
    MOVZ  X20, #0x1743, LSL #0
    MOVK  X20, #0x1a3e, LSL #16
    MOVK  X20, #0xe6b1, LSL #32
    MOVK  X20, #0x36c6, LSL #48
    MOVZ  X21, #0x70de, LSL #0
    MOVK  X21, #0x1050, LSL #16
    MOVK  X21, #0x7138, LSL #32
    MOVK  X21, #0xc6a9, LSL #48
    MOVZ  X23, #0x5037, LSL #0
    MOVK  X23, #0xe349, LSL #16
    MOVK  X23, #0x5d57, LSL #32
    MOVK  X23, #0x8614, LSL #48
    MOVZ  X24, #0x10a1, LSL #0
    MOVK  X24, #0xc9f, LSL #16
    MOVK  X24, #0x852f, LSL #32
    MOVK  X24, #0x3d76, LSL #48
    MOVZ  X25, #0x2afd, LSL #0
    MOVK  X25, #0x5513, LSL #16
    MOVK  X25, #0x8c2e, LSL #32
    MOVK  X25, #0xf79a, LSL #48
    MOVZ  X26, #0x526b, LSL #0
    MOVK  X26, #0xe8da, LSL #16
    MOVK  X26, #0x28fc, LSL #32
    MOVK  X26, #0x3196, LSL #48
    MOVZ  X27, #0x916a, LSL #0
    MOVK  X27, #0xc69f, LSL #16
    MOVK  X27, #0xdae6, LSL #32
    MOVK  X27, #0x4a56, LSL #48
    MOVZ  X28, #0x3236, LSL #0
    MOVK  X28, #0xa162, LSL #16
    MOVK  X28, #0xd7d5, LSL #32
    MOVK  X28, #0x362c, LSL #48
    MOVZ  X29, #0xe36f, LSL #0
    MOVK  X29, #0x7fa8, LSL #16
    MOVK  X29, #0xa4d, LSL #32
    MOVK  X29, #0x373d, LSL #48
    MOVZ  X9, #0xf, LSL #0
TSRTIntCRCAndShiftAndMov_label_9:
    LSRV  X15, X26, X26
    LSRV  W25, W15, W9
    MOV  W8, W28
    LSL  X23, X8, #43
    LSR  X23, X25, #0x30
    MOV  X19, X23
    LSLV  X18, X29, X29
    MOVK  W2, #0xa8f3, LSL #16
    CRC32CH  W3, W24, W19
    CRC32H  W12, W3, W10
    MOV  W8, W9
    MOVK  X20, #0xe49f, LSL #0
    LSL  W17, W8, #4
    MOVN  X29, #0x25d5, LSL #48
    CRC32X  W25, W2, X29
    MOVZ  X12, #0xece0, LSL #0
    MOV  X28, X17
    CRC32X  W15, W25, X12
    LSR  X17, X20, X15
    LSL  W28, W28, W27
    MOVZ  X25, #0x6b43, LSL #32
    CRC32CH  W23, W17, W18
    MOV  W27, W28
    LSRV  X26, X25, X25
    CRC32CW  W8, W26, W23
    LSLV  W3, W27, W8
    LSL  X26, X25, X17
    CRC32W  W18, W21, W12
    MOVZ  W29, #0xc29d, LSL #16
    LSRV  W28, W3, W21
    CRC32X  W25, W8, X27
    LSR  W2, W24, #0x1f
    LSR  W8, W9, #0x1c
    MOVZ  W5, #0x2aad, LSL #0
    CRC32CB  W21, W20, W24
    MOV  W10, W21
    LSL  W17, W10, #19
    LSL  W21, W8, W25
    MOV  X15, X17
    LSR  W27, W21, #0x1c
    CRC32X  W3, W29, X26
    MOVK  X23, #0x1a90, LSL #16
    MOV  X12, X23
    CRC32W  W20, W15, W18
    LSR  W8, W3, #0x11
    LSR  X24, X2, X2
    CRC32X  W28, W5, X8
    LSL  W25, W27, W27
    LSL  W27, W28, #7
    LSLV  W8, W27, W12
    MOVK  W5, #0x6429, LSL #16
    LSR  X21, X5, #0x3c
    LSR  W29, W21, W27
    LSL  W27, W20, W8
    CRC32X  W15, W25, X25
    MOVZ  W28, #0x13a5, LSL #16
    MOV  X12, X24
    LSR  W18, W29, W12
    MOVK  X25, #0x8d30, LSL #48
    MOVN  X29, #0x1d15, LSL #48
    LSLV  W25, W28, W28
    MOVN  W12, #0x2034, LSL #0
    LSR  W24, W12, W18
    LSRV  W18, W25, W15
    MOV  W21, W27
    LSL  X26, X29, #28
    CRC32B  W2, W24, W24
    CRC32X  W12, W2, X18
    CRC32X  W23, W26, X12
    CRC32B  W5, W21, W23
    LSR  W23, W24, W19
    MOVN  W8, #0x8084, LSL #0
    LSL  X29, X8, X5
    MOVK  W3, #0x2190, LSL #0
    LSR  W19, W26, W4
    CRC32CX  W25, W17, X19
    LSRV  X28, X7, X21
    MOV  W21, W24
    MOV  W12, W4
    LSRV  X8, X10, X20
    MOVN  X24, #0x5756, LSL #16
    CRC32H  W17, W3, W26
    CRC32B  W20, W23, W24
    CRC32CX  W7, W17, X21
    CRC32X  W5, W20, X7
    CRC32H  W7, W5, W5
    LSR  X26, X28, X7
    LSR  W23, W15, #0x13
    LSR  W15, W26, W8
    CRC32CX  W21, W23, X21
    MOVN  W23, #0x571f, LSL #0
    LSR  X5, X23, #0x3d
    CRC32CB  W27, W25, W29
    MOVK  X10, #0xe56f, LSL #48
    MOVK  X7, #0xd647, LSL #16
    LSL  X28, X21, #50
    MOV  X29, X15
    CRC32CX  W4, W26, X29
    CRC32CH  W20, W27, W5
    CRC32CX  W23, W4, X4
    CRC32W  W21, W23, W28
    LSR  X25, X20, X21
    LSR  X27, X25, X10
    LSR  W23, W7, #0x9
    MOVN  X7, #0x46f7, LSL #0
    LSL  W21, W12, #10
    LSR  X26, X21, X7
    CRC32B  W10, W27, W26
    MOVZ  W7, #0xe6e9, LSL #16
    MOVK  X25, #0x4457, LSL #0
    LSL  X5, X7, X10
    MOVK  X7, #0xfb5d, LSL #0
    LSR  X10, X7, #0x3b
    MOV  X27, X25
    MOV  W25, W10
    MOVN  W12, #0xcde8, LSL #16
    LSL  W21, W12, #31
    LSL  W28, W5, W21
    LSL  X7, X23, #4
    MOVN  X21, #0x3e2b, LSL #48
    MOVN  W23, #0x44b6, LSL #0
    LSR  X20, X27, #0x3a
    CRC32W  W29, W20, W25
    MOVK  X12, #0xfdf8, LSL #0
    CRC32CW  W5, W9, W23
    LSL  W10, W5, #11
    LSL  W25, W7, #21
    LSR  X20, X12, #0x2a
    MOVZ  X12, #0x1d14, LSL #0
    MOV  X27, X21
    LSR  W7, W12, W27
    MOV  X21, X20
    CRC32W  W20, W25, W29
    MOVK  X29, #0x9116, LSL #16
    MOV  W12, W10
    MOV  W10, W7
    MOV  W27, W28
    LSRV  W5, W20, W12
    LSR  X7, X21, X27
    CRC32B  W23, W29, W7
    CRC32X  W28, W23, X23
    CRC32CW  W20, W10, W28
    MOV  W28, W5
    LSRV  X5, X28, X20
    MOVZ  W2, #0xc40e, LSL #0
    LSR  X12, X8, #0x1c
    CRC32B  W26, W17, W18
    MOVN  W23, #0xe5fd, LSL #0
    CRC32W  W10, W17, W4
    LSR  W21, W10, #0x16
    LSR  X23, X8, #0x36
    CRC32CX  W25, W15, X17
    MOV  X8, X3
    MOV  W3, W25
    LSRV  W29, W12, W7
    LSR  W7, W5, #0x1a
    CRC32H  W4, W2, W17
    MOVN  W29, #0x8108, LSL #0
    LSL  W10, W10, #12
    CRC32X  W25, W10, X4
    MOVN  W2, #0x5631, LSL #0
    CRC32H  W5, W23, W26
    LSL  X28, X21, X5
    CRC32H  W18, W29, W28
    CRC32B  W10, W25, W18
    LSRV  W28, W10, W2
    MOVZ  X23, #0xae6c, LSL #0
    LSRV  W17, W28, W2
    CRC32H  W15, W17, W17
    CRC32CW  W20, W3, W8
    MOVK  X28, #0xb660, LSL #48
    CRC32CB  W4, W15, W7
    LSRV  W12, W4, W20
    LSL  W25, W12, #23
    LSL  X29, X23, #26
    LSR  W17, W25, W28
    MOVN  W26, #0x820e, LSL #0
    MOVZ  W2, #0xd455, LSL #0
    MOV  X10, X29
    LSLV  W29, W21, W17
    CRC32X  W15, W26, X29
    LSL  X18, X15, #21
    CRC32H  W3, W10, W2
    CRC32W  W15, W3, W3
    CRC32W  W29, W18, W18
    LSL  W10, W15, W15
    CRC32CW  W20, W29, W10
    LSLV  W25, W18, W25
    MOVZ  W18, #0x2851, LSL #16
    LSR  X4, X7, X5
    MOVN  W12, #0x2275, LSL #16
    CRC32W  W28, W12, W25
    MOVZ  X8, #0x6b39, LSL #16
    LSLV  W10, W21, W29
    CRC32CH  W25, W4, W10
    CRC32B  W23, W17, W17
    MOV  X10, X3
    MOVK  W26, #0x8497, LSL #0
    MOVZ  W15, #0xd302, LSL #0
    CRC32CB  W17, W20, W28
    SUBS  X9, X9, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_9
    MOVZ  X13, #0xd455, LSL #0
    SUB  X16, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0xfdc, LSL #0
    MOVK  X13, #0x4672, LSL #16
    SUB  X16, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0xa907, LSL #0
    MOVK  X13, #0x5032, LSL #16
    SUB  X16, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0xb, LSL #0
    SUB  X16, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x6b39, LSL #16
    SUB  X16, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0xfdc, LSL #0
    MOVK  X13, #0x4672, LSL #16
    SUB  X16, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xdd8a, LSL #16
    SUB  X16, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0xd302, LSL #0
    SUB  X16, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0xdfb1, LSL #0
    MOVK  X13, #0xdeee, LSL #16
    SUB  X16, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x2851, LSL #16
    SUB  X16, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xf000, LSL #16
    SUB  X16, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x2fe, LSL #0
    SUB  X16, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0xb, LSL #0
    SUB  X16, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xa8a9, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X16, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0xcc03, LSL #0
    MOVK  X13, #0x517a, LSL #16
    SUB  X16, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x8497, LSL #0
    MOVK  X13, #0xffff, LSL #16
    SUB  X16, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xe6e9, LSL #16
    SUB  X16, X13, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x576d, LSL #0
    MOVK  X13, #0x30d, LSL #16
    SUB  X16, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X18, #0xf, LSL #0
TSRTIntCRCAndShiftAndMov_label_10:
    LSL  X27, X16, X4
    LSL  W3, W2, W20
    LSR  X2, X12, #0x28
    LSL  X12, X26, X17
    LSLV  X23, X19, X19
    MOVK  X23, #0x32f6, LSL #16
    MOVN  X2, #0xfefe, LSL #16
    CRC32CH  W24, W28, W18
    MOV  W27, W25
    MOVK  X27, #0xada4, LSL #48
    CRC32CX  W21, W24, X21
    CRC32CH  W21, W21, W3
    MOV  X26, X2
    MOVZ  W3, #0x51ea, LSL #16
    CRC32CX  W26, W13, X29
    MOV  X8, X15
    MOVK  W19, #0xb1da, LSL #0
    LSL  X28, X3, #12
    LSRV  X12, X27, X21
    LSR  X17, X23, X26
    MOVN  W2, #0xc60c, LSL #0
    LSLV  W3, W8, W8
    LSRV  W29, W2, W19
    CRC32H  W13, W28, W29
    LSLV  W24, W12, W3
    LSRV  W19, W13, W13
    CRC32X  W2, W19, X19
    LSR  W21, W24, #0xc
    MOVK  X23, #0x65c2, LSL #0
    LSL  W28, W2, #12
    CRC32W  W27, W17, W23
    MOVN  W26, #0xa808, LSL #16
    CRC32W  W13, W29, W26
    MOVN  W15, #0x4d8c, LSL #16
    MOV  X8, X27
    CRC32H  W2, W21, W21
    CRC32X  W17, W28, X28
    MOVK  X24, #0xa8b5, LSL #16
    LSLV  X23, X24, X24
    LSR  X21, X13, X23
    MOVK  W26, #0xdf73, LSL #16
    MOV  W27, W13
    MOVZ  W3, #0xb969, LSL #16
    MOVK  W2, #0x692f, LSL #0
    CRC32CX  W12, W2, X2
    LSL  W2, W15, W21
    LSR  X15, X27, X3
    LSR  X24, X2, #0x2a
    LSLV  W28, W17, W26
    CRC32CW  W26, W15, W28
    MOV  W3, W8
    MOV  X28, X3
    LSLV  X23, X12, X12
    CRC32W  W15, W26, W23
    MOVK  X19, #0x3367, LSL #48
    CRC32X  W3, W24, X15
    LSL  X12, X19, #18
    LSL  W19, W28, #4
    LSRV  W21, W3, W19
    MOV  W29, W12
    LSRV  X23, X29, X29
    MOVN  X12, #0x249e, LSL #32
    LSR  W24, W12, W12
    MOV  W12, W21
    MOVN  X26, #0xea27, LSL #32
    LSLV  W28, W24, W12
    CRC32X  W8, W23, X26
    MOV  W17, W26
    LSR  W19, W17, #0x1e
    MOV  X21, X8
    LSR  X29, X19, #0x2a
    CRC32H  W8, W21, W28
    CRC32H  W28, W8, W29
    LSR  X24, X8, X17
    CRC32X  W12, W28, X4
    MOV  X23, X4
    MOV  W29, W8
    LSL  W2, W3, W8
    MOVK  W28, #0xc4b8, LSL #16
    LSRV  X15, X18, X4
    LSL  W19, W20, W4
    LSR  W26, W28, W18
    LSR  W4, W16, W3
    LSR  X17, X15, X19
    CRC32CX  W3, W26, X17
    LSL  W17, W24, #18
    LSR  X8, X2, X29
    CRC32W  W16, W3, W29
    MOV  X3, X16
    CRC32CX  W29, W8, X3
    LSL  W3, W4, #17
    LSL  W21, W17, W29
    CRC32CH  W16, W21, W3
    LSLV  W26, W16, W16
    CRC32H  W25, W26, W26
    LSL  W4, W25, W23
    CRC32CW  W17, W4, W4
    MOVK  X23, #0xb913, LSL #48
    MOVK  X19, #0x2419, LSL #16
    MOVK  X28, #0x5ec, LSL #48
    CRC32W  W26, W17, W17
    MOVN  X25, #0x405c, LSL #16
    LSL  W8, W28, W12
    LSR  X4, X23, X19
    LSR  X29, X4, #0x2d
    LSL  X24, X29, X29
    LSL  X19, X8, #30
    MOVZ  W28, #0x3d59, LSL #0
    LSLV  X12, X25, X26
    LSL  X26, X24, X24
    LSR  X16, X23, #0xe
    LSL  X25, X19, #10
    LSL  W21, W16, #28
    LSLV  W15, W25, W25
    MOV  W17, W15
    LSR  X15, X28, #0x22
    CRC32CX  W2, W12, X19
    LSRV  X29, X2, X4
    LSRV  W28, W26, W15
    CRC32CW  W15, W15, W17
    LSL  W24, W15, #28
    MOV  W26, W24
    LSR  W17, W29, #0x1
    LSRV  W8, W21, W21
    MOVN  W21, #0x489, LSL #0
    LSR  W25, W8, #0x19
    MOVN  X24, #0x881, LSL #32
    LSL  X15, X24, X24
    LSL  X10, X28, X28
    MOV  X12, X17
    MOVN  X19, #0x7cac, LSL #48
    CRC32CW  W16, W26, W21
    LSRV  W8, W16, W8
    LSR  X2, X12, X15
    MOVN  X15, #0xf613, LSL #16
    CRC32B  W4, W25, W19
    LSLV  W21, W4, W10
    CRC32CX  W4, W8, X8
    MOV  X29, X15
    LSR  W17, W2, #0x11
    LSR  W15, W21, W17
    CRC32CW  W28, W29, W15
    CRC32CH  W19, W28, W4
    MOV  W28, W24
    LSRV  W26, W4, W19
    LSLV  W16, W24, W19
    MOV  W10, W21
    LSRV  W17, W3, W18
    CRC32X  W15, W20, X18
    CRC32W  W19, W19, W29
    CRC32CX  W25, W29, X12
    CRC32CX  W29, W17, X18
    MOVK  W4, #0xff4e, LSL #16
    CRC32X  W3, W4, X15
    CRC32B  W12, W29, W3
    LSRV  X21, X10, X9
    LSRV  W15, W12, W25
    LSR  X29, X16, #0x23
    CRC32CW  W3, W28, W28
    LSLV  X2, X19, X26
    MOV  X4, X2
    LSL  W12, W21, #24
    MOV  X24, X12
    LSLV  W17, W15, W15
    LSL  W28, W29, #5
    LSR  X16, X24, X21
    LSR  X19, X16, #0x31
    CRC32H  W8, W19, W19
    LSRV  X15, X28, X8
    LSR  X12, X17, #0x1c
    CRC32CX  W10, W27, X3
    LSL  W28, W12, W4
    CRC32CX  W19, W28, X28
    LSL  W3, W15, W15
    MOVZ  X27, #0x3aa2, LSL #32
    MOVN  X24, #0x68e8, LSL #32
    LSLV  W15, W19, W10
    CRC32CB  W16, W27, W24
    MOVZ  X8, #0x14ce, LSL #16
    LSR  W9, W15, #0xc
    MOVK  X21, #0xc55a, LSL #32
    LSRV  X29, X9, X3
    CRC32CB  W3, W29, W16
    LSL  X17, X3, X25
    CRC32H  W25, W8, W8
    LSRV  X10, X25, X21
    LSL  X25, X17, #27
    MOVZ  X29, #0x24e3, LSL #0
    LSR  W17, W10, #0x1d
    CRC32CB  W28, W17, W25
    MOVK  X2, #0x62c, LSL #0
    LSLV  W16, W29, W15
    MOVK  W8, #0x9df5, LSL #0
    CRC32CW  W27, W25, W8
    MOVN  W12, #0x4400, LSL #16
    LSL  W4, W28, W28
    LSLV  X25, X4, X27
    CRC32H  W8, W25, W25
    MOVN  W27, #0xa000, LSL #0
    CRC32H  W15, W16, W16
    SUBS  X18, X18, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_10
    MOVZ  X7, #0x62c, LSL #0
    MOVK  X7, #0x10fc, LSL #16
    SUB  X5, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x59d0, LSL #0
    MOVK  X7, #0xa34e, LSL #16
    SUB  X5, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xbbff, LSL #16
    SUB  X5, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x69c6, LSL #0
    MOVK  X7, #0x6627, LSL #16
    SUB  X5, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x24e3, LSL #0
    SUB  X5, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0xef8d, LSL #0
    MOVK  X7, #0x2d02, LSL #16
    MOVK  X7, #0xc55a, LSL #32
    SUB  X5, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xb913, LSL #48
    SUB  X5, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0x9717, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X5, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x5fff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X5, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X28
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x24e3, LSL #0
    SUB  X5, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
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
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
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
    MOVZ  X17, #0xf, LSL #0
TSRTIntCRCAndShiftAndMov_label_11:
    LSL  W20, W23, #19
    MOV  X7, X24
    CRC32CB  W7, W26, W25
    MOVN  X7, #0xe1cd, LSL #48
    CRC32B  W8, W28, W2
    CRC32B  W12, W7, W8
    MOV  W3, W29
    MOVZ  X3, #0xe8c2, LSL #0
    LSL  X28, X20, #19
    LSR  X10, X12, X27
    MOV  W4, W10
    LSR  X3, X17, X28
    LSR  W7, W3, #0xf
    MOV  X2, X29
    MOV  X26, X4
    LSRV  X18, X7, X7
    CRC32X  W19, W26, X26
    MOVK  X29, #0xde84, LSL #16
    MOVK  X12, #0x23d, LSL #0
    CRC32H  W3, W12, W12
    LSL  X7, X18, X3
    MOVZ  X28, #0x9a3, LSL #16
    MOV  X12, X28
    LSRV  X10, X2, X12
    CRC32CB  W4, W19, W7
    MOV  X18, X4
    CRC32W  W26, W29, W29
    CRC32CX  W20, W26, X26
    CRC32H  W27, W10, W20
    LSL  W23, W18, W27
    LSL  X3, X7, X18
    LSR  W24, W24, #0x11
    LSL  X25, X17, X16
    MOVZ  X7, #0xa943, LSL #16
    MOV  W4, W7
    LSL  W27, W20, #24
    LSR  W18, W18, #0x9
    MOV  W20, W7
    LSLV  W28, W25, W20
    LSRV  X2, X17, X15
    MOVN  X15, #0x3d89, LSL #16
    MOVK  X26, #0x370, LSL #16
    LSL  X25, X3, #37
    LSRV  W3, W26, W26
    LSRV  W20, W18, W23
    LSL  X16, X24, #57
    LSL  X18, X25, #62
    CRC32CX  W23, W19, X16
    CRC32CH  W7, W20, W18
    LSLV  X24, X23, X28
    LSL  X26, X15, X3
    MOVZ  W15, #0x5891, LSL #0
    CRC32H  W18, W2, W2
    MOV  X12, X5
    LSR  W25, W24, W4
    LSL  X10, X7, X27
    MOV  X7, X10
    LSL  W20, W15, #13
    LSR  W23, W12, #0xf
    MOVN  X28, #0x3e3e, LSL #32
    CRC32H  W12, W18, W26
    LSRV  W18, W25, W25
    MOV  W19, W18
    CRC32W  W18, W28, W23
    LSLV  X3, X7, X19
    CRC32CX  W7, W20, X20
    MOV  X23, X3
    CRC32W  W2, W12, W7
    MOVN  W12, #0x8b4e, LSL #16
    CRC32W  W25, W12, W12
    LSL  X16, X23, X2
    MOV  X4, X5
    MOVZ  X7, #0xe41c, LSL #0
    LSL  W10, W18, W18
    LSR  X5, X16, #0x35
    MOV  X26, X5
    CRC32CX  W15, W29, X7
    MOV  X3, X26
    LSLV  W18, W10, W25
    LSRV  W5, W15, W15
    CRC32B  W19, W24, W4
    LSRV  W15, W18, W19
    LSR  W28, W5, #0x14
    MOVN  W29, #0xf506, LSL #0
    LSLV  W19, W29, W29
    LSLV  W25, W18, W3
    LSR  X12, X15, X25
    CRC32X  W24, W12, X12
    LSL  X4, X28, X28
    CRC32CB  W28, W4, W24
    CRC32H  W26, W28, W28
    MOVN  W4, #0x9c01, LSL #16
    LSL  W29, W4, W26
    CRC32W  W7, W19, W29
    MOVZ  W23, #0x5929, LSL #16
    MOVN  W26, #0xb195, LSL #0
    LSR  W24, W23, #0xc
    MOVZ  W18, #0xbd13, LSL #0
    CRC32CX  W10, W28, X23
    LSRV  X28, X2, X23
    CRC32CB  W4, W26, W18
    MOVK  W23, #0x96ea, LSL #0
    MOV  W19, W10
    MOVK  X29, #0xcce, LSL #48
    MOV  X18, X16
    MOVN  W2, #0xcdf, LSL #16
    LSL  X16, X24, #9
    LSR  W10, W2, #0x4
    CRC32X  W2, W7, X10
    CRC32W  W26, W18, W4
    CRC32W  W18, W26, W29
    LSL  W26, W18, #5
    LSR  W24, W23, #0x2
    MOV  W23, W24
    CRC32CB  W24, W28, W9
    LSL  W4, W19, #16
    MOVZ  W19, #0x52cf, LSL #0
    MOV  W9, W4
    MOVZ  W28, #0xde64, LSL #0
    MOVK  X19, #0x4097, LSL #0
    MOV  X4, X19
    MOV  X7, X16
    MOVN  W18, #0x64d5, LSL #16
    LSR  W7, W7, W18
    MOV  X4, X9
    LSLV  X29, X23, X2
    LSLV  X10, X26, X29
    MOV  W19, W10
    MOV  W10, W4
    CRC32W  W16, W28, W7
    LSL  X2, X24, #7
    LSR  W15, W19, #0x1
    LSR  W4, W16, W10
    LSL  X10, X2, #31
    LSRV  W18, W15, W15
    LSL  X7, X4, X18
    CRC32CB  W23, W7, W10
    LSL  W15, W7, W4
    LSR  W16, W28, W9
    MOVK  W26, #0x3fb, LSL #16
    CRC32CW  W10, W4, W4
    MOVZ  W19, #0x730c, LSL #16
    MOV  X7, X25
    LSL  W9, W28, W15
    CRC32B  W25, W8, W12
    CRC32CW  W28, W16, W28
    LSL  X4, X27, #32
    CRC32B  W8, W19, W23
    MOV  X16, X4
    MOV  X15, X26
    MOV  W2, W28
    CRC32W  W12, W10, W9
    LSL  X9, X12, X7
    LSL  W12, W9, W16
    MOV  W19, W25
    CRC32B  W10, W19, W2
    CRC32X  W29, W10, X24
    MOVK  X23, #0x3bb4, LSL #16
    CRC32CX  W25, W24, X12
    LSR  X4, X29, X25
    CRC32X  W9, W15, X15
    LSRV  X24, X8, X23
    MOVK  W16, #0xd3ea, LSL #16
    LSL  W29, W16, W4
    MOV  W12, W24
    CRC32CW  W4, W29, W12
    MOVZ  X27, #0xee7a, LSL #48
    MOVN  W25, #0x8d88, LSL #0
    LSL  W10, W8, W9
    CRC32CX  W24, W4, X10
    CRC32CH  W26, W25, W24
    MOV  X28, X26
    LSL  X19, X27, #40
    MOVZ  X2, #0xcf9, LSL #48
    MOV  W26, W28
    LSL  X16, X26, X19
    LSRV  X27, X2, X2
    CRC32B  W7, W16, W27
    LSL  W23, W3, W18
    MOV  W29, W17
    CRC32X  W12, W29, X12
    MOVN  X15, #0xbdf3, LSL #48
    MOVZ  W29, #0xc14a, LSL #16
    LSL  W28, W5, #4
    MOV  X24, X27
    MOV  W27, W19
    CRC32CB  W9, W8, W10
    CRC32B  W19, W27, W9
    LSR  W18, W29, W23
    LSR  W3, W19, W19
    MOV  W16, W3
    CRC32B  W5, W18, W12
    LSR  X27, X19, #0x12
    MOVN  W18, #0x60b, LSL #0
    LSLV  X4, X16, X15
    MOV  W16, W28
    LSR  W12, W5, #0x16
    CRC32CX  W3, W24, X24
    CRC32X  W23, W16, X7
    CRC32B  W24, W3, W12
    SUBS  X17, X17, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_11
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xcf9, LSL #48
    SUB  X13, X21, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X21, #0xba61, LSL #0
    MOVK  X21, #0x876f, LSL #16
    SUB  X13, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x8000, LSL #48
    SUB  X13, X21, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X21, #0x3daf, LSL #0
    MOVK  X21, #0x9d13, LSL #16
    SUB  X13, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X21, #0x3447, LSL #0
    MOVK  X21, #0x54f9, LSL #16
    SUB  X13, X21, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X21, #0xc00, LSL #0
    MOVK  X21, #0x73, LSL #16
    SUB  X13, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X21, #0x730c, LSL #0
    SUB  X13, X21, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X21, #0xc00, LSL #0
    MOVK  X21, #0x73, LSL #16
    SUB  X13, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X21, #0x274, LSL #0
    SUB  X13, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0x420c, LSL #48
    SUB  X13, X21, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X21, #0xdd0, LSL #0
    SUB  X13, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X21, #0xf9f4, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X13, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X21, #0x4c2b, LSL #0
    MOVK  X21, #0x9b6, LSL #16
    SUB  X13, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X21, #0x2000, LSL #0
    MOVK  X21, #0xb12, LSL #16
    SUB  X13, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X21, #0x7cb3, LSL #0
    MOVK  X21, #0xe7b0, LSL #16
    SUB  X13, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X21, #0x8b51, LSL #0
    MOVK  X21, #0x6d5a, LSL #16
    SUB  X13, X21, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X21, #0x7277, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X13, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X21, #0x6ef6, LSL #0
    MOVK  X21, #0x2763, LSL #16
    SUB  X13, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X21, #0x26d, LSL #0
    SUB  X13, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X21, #0xdd0, LSL #0
    SUB  X13, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xc14a, LSL #16
    SUB  X13, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X2, #0x9b, LSL #0
    MOVK  X2, #0x3f06, LSL #16
    MOVK  X2, #0x9aac, LSL #32
    MOVK  X2, #0x6476, LSL #48
    MOVZ  X3, #0x6d1d, LSL #0
    MOVK  X3, #0x36c, LSL #16
    MOVK  X3, #0xf437, LSL #32
    MOVK  X3, #0xd59b, LSL #48
    MOVZ  X4, #0x7c00, LSL #0
    MOVK  X4, #0x9d99, LSL #16
    MOVK  X4, #0x97bc, LSL #32
    MOVK  X4, #0x1b44, LSL #48
    MOVZ  X5, #0x7d6a, LSL #0
    MOVK  X5, #0xdbbb, LSL #16
    MOVK  X5, #0xa5e7, LSL #32
    MOVK  X5, #0xd824, LSL #48
    MOVZ  X7, #0x6d68, LSL #0
    MOVK  X7, #0xfe95, LSL #16
    MOVK  X7, #0xd17e, LSL #32
    MOVK  X7, #0x471f, LSL #48
    MOVZ  X8, #0xecab, LSL #0
    MOVK  X8, #0xe024, LSL #16
    MOVK  X8, #0xc100, LSL #32
    MOVK  X8, #0x9186, LSL #48
    MOVZ  X9, #0x2957, LSL #0
    MOVK  X9, #0x16f, LSL #16
    MOVK  X9, #0x5aa, LSL #32
    MOVK  X9, #0xefb2, LSL #48
    MOVZ  X10, #0xebf7, LSL #0
    MOVK  X10, #0x186b, LSL #16
    MOVK  X10, #0x5326, LSL #32
    MOVK  X10, #0x20d3, LSL #48
    MOVZ  X12, #0x9004, LSL #0
    MOVK  X12, #0xe1d7, LSL #16
    MOVK  X12, #0x1332, LSL #32
    MOVK  X12, #0xfadb, LSL #48
    MOVZ  X13, #0x287f, LSL #0
    MOVK  X13, #0xd4c1, LSL #16
    MOVK  X13, #0xbdbc, LSL #32
    MOVK  X13, #0xb895, LSL #48
    MOVZ  X15, #0x8394, LSL #0
    MOVK  X15, #0x3119, LSL #16
    MOVK  X15, #0x26fa, LSL #32
    MOVK  X15, #0x5f52, LSL #48
    MOVZ  X16, #0xc777, LSL #0
    MOVK  X16, #0x6776, LSL #16
    MOVK  X16, #0xe382, LSL #32
    MOVK  X16, #0x1caa, LSL #48
    MOVZ  X17, #0xc29b, LSL #0
    MOVK  X17, #0x29f2, LSL #16
    MOVK  X17, #0x976c, LSL #32
    MOVK  X17, #0x9c2f, LSL #48
    MOVZ  X18, #0x6d20, LSL #0
    MOVK  X18, #0x582e, LSL #16
    MOVK  X18, #0x91e3, LSL #32
    MOVK  X18, #0xbe8e, LSL #48
    MOVZ  X19, #0xf910, LSL #0
    MOVK  X19, #0x94be, LSL #16
    MOVK  X19, #0xd311, LSL #32
    MOVK  X19, #0xaf5b, LSL #48
    MOVZ  X20, #0x2b4d, LSL #0
    MOVK  X20, #0x8e0c, LSL #16
    MOVK  X20, #0xe38e, LSL #32
    MOVK  X20, #0x5106, LSL #48
    MOVZ  X21, #0xe328, LSL #0
    MOVK  X21, #0xe0b4, LSL #16
    MOVK  X21, #0x8b81, LSL #32
    MOVK  X21, #0xb5e0, LSL #48
    MOVZ  X23, #0xa2a, LSL #0
    MOVK  X23, #0x2cc, LSL #16
    MOVK  X23, #0x43f4, LSL #32
    MOVK  X23, #0x1ef9, LSL #48
    MOVZ  X24, #0x210f, LSL #0
    MOVK  X24, #0xa19f, LSL #16
    MOVK  X24, #0x94e8, LSL #32
    MOVK  X24, #0x92f3, LSL #48
    MOVZ  X25, #0xb51c, LSL #0
    MOVK  X25, #0x8174, LSL #16
    MOVK  X25, #0x805e, LSL #32
    MOVK  X25, #0x84a4, LSL #48
    MOVZ  X26, #0x34e9, LSL #0
    MOVK  X26, #0x1a79, LSL #16
    MOVK  X26, #0xbcb3, LSL #32
    MOVK  X26, #0x2cdf, LSL #48
    MOVZ  X27, #0x489a, LSL #0
    MOVK  X27, #0xa2c7, LSL #16
    MOVK  X27, #0x5219, LSL #32
    MOVK  X27, #0x6884, LSL #48
    MOVZ  X28, #0x168d, LSL #0
    MOVK  X28, #0x105b, LSL #16
    MOVK  X28, #0xf069, LSL #32
    MOVK  X28, #0xcb95, LSL #48
    MOVZ  X29, #0x5a2e, LSL #0
    MOVK  X29, #0x6c08, LSL #16
    MOVK  X29, #0xd76f, LSL #32
    MOVK  X29, #0x7880, LSL #48
    MOVZ  X9, #0xf, LSL #0
TSRTIntCRCAndShiftAndMov_label_12:
    MOV  W5, W26
    LSRV  W27, W27, W27
    LSL  X23, X27, #62
    LSLV  W18, W29, W9
    MOVN  X2, #0x7d8f, LSL #0
    MOV  X21, X18
    CRC32CW  W24, W2, W23
    LSL  W29, W24, W5
    LSR  W20, W29, #0x6
    CRC32CX  W17, W21, X21
    LSR  W8, W17, W17
    MOV  W20, W8
    LSR  X19, X20, X20
    MOV  X5, X28
    LSLV  X12, X19, X19
    LSR  X15, X5, #0x25
    MOVZ  X26, #0x2ac8, LSL #16
    CRC32B  W29, W12, W26
    MOV  X28, X29
    LSL  X21, X15, X28
    CRC32W  W15, W10, W7
    CRC32W  W10, W15, W20
    MOVN  W29, #0xed1c, LSL #0
    CRC32CB  W17, W12, W19
    MOVZ  X18, #0x35e9, LSL #32
    MOV  W28, W17
    MOVZ  X7, #0xc7d4, LSL #48
    LSL  W15, W21, #18
    LSLV  W20, W8, W9
    MOVN  W17, #0xb2d4, LSL #0
    LSR  X26, X15, #0x2d
    LSRV  X21, X5, X20
    LSR  X8, X19, #0xb
    MOVK  X7, #0x8bda, LSL #16
    LSRV  X20, X17, X17
    CRC32H  W15, W28, W7
    LSLV  X28, X10, X10
    CRC32CH  W12, W15, W20
    CRC32CW  W24, W18, W18
    MOVZ  W15, #0x8423, LSL #0
    MOV  W10, W15
    LSL  X15, X29, #34
    MOVZ  W7, #0xabe6, LSL #16
    LSLV  W12, W10, W26
    CRC32CH  W5, W28, W15
    LSLV  X28, X27, X2
    CRC32B  W29, W24, W28
    MOV  X18, X29
    LSL  X27, X5, X12
    CRC32X  W2, W18, X7
    MOV  X29, X21
    LSRV  W26, W27, W23
    LSRV  W5, W2, W26
    LSL  X27, X5, #40
    MOVN  X20, #0xac2, LSL #48
    LSLV  W21, W27, W20
    MOV  X5, X29
    LSR  X19, X21, #0x34
    MOVN  W17, #0xcee8, LSL #16
    CRC32CW  W12, W17, W5
    LSLV  W28, W19, W12
    LSRV  W10, W28, W8
    LSL  W12, W29, #17
    MOVZ  X24, #0xf99a, LSL #16
    MOVN  W29, #0xd6a3, LSL #16
    LSLV  W27, W15, W26
    LSL  W17, W27, W9
    LSL  W15, W21, W17
    MOVZ  X26, #0x670d, LSL #32
    LSL  X23, X7, #25
    LSLV  X8, X25, X29
    CRC32W  W28, W28, W17
    MOVK  X2, #0x13f5, LSL #48
    MOVZ  W18, #0xf065, LSL #0
    CRC32CB  W19, W12, W18
    LSRV  X27, X2, X19
    MOV  X19, X27
    CRC32B  W7, W24, W24
    CRC32CW  W12, W10, W23
    MOVZ  X10, #0xa747, LSL #48
    MOVK  W23, #0xf92, LSL #0
    MOV  X27, X10
    LSL  X18, X12, #23
    LSLV  W25, W27, W8
    CRC32W  W24, W19, W28
    LSR  W27, W25, #0x7
    LSL  X17, X7, X26
    CRC32CX  W28, W27, X27
    LSLV  W2, W23, W18
    MOVK  X29, #0x872c, LSL #16
    LSL  W8, W29, W17
    MOVN  W17, #0x77b5, LSL #0
    MOVK  W12, #0x1a80, LSL #0
    MOV  W18, W12
    MOVN  W12, #0x1d00, LSL #0
    CRC32CX  W5, W18, X2
    MOVZ  W18, #0x22f3, LSL #0
    LSLV  X10, X17, X17
    LSLV  X19, X18, X12
    LSL  W25, W8, #1
    MOV  W27, W23
    MOVZ  X7, #0x23c0, LSL #0
    MOV  W29, W7
    CRC32H  W26, W12, W5
    LSR  W12, W26, #0x8
    CRC32H  W2, W25, W12
    MOV  W7, W24
    LSRV  X12, X28, X10
    LSL  X18, X24, X27
    CRC32W  W25, W18, W18
    LSL  X28, X25, X2
    LSL  X24, X29, X28
    MOV  W23, W19
    MOVZ  W19, #0xf337, LSL #0
    MOVZ  W17, #0xb5b2, LSL #16
    LSR  X5, X19, X7
    MOV  W27, W23
    CRC32X  W23, W27, X12
    LSR  W21, W24, #0x1f
    MOVZ  W8, #0xa686, LSL #16
    MOVN  W19, #0xd96a, LSL #0
    LSLV  X7, X5, X17
    MOVK  W28, #0xa91e, LSL #0
    CRC32W  W17, W21, W19
    LSR  X19, X7, X23
    LSR  W24, W19, W8
    CRC32CH  W26, W24, W17
    CRC32CW  W24, W9, W28
    LSLV  X7, X26, X26
    CRC32B  W25, W7, W24
    LSL  W27, W23, #16
    MOVN  W12, #0xa68f, LSL #0
    CRC32H  W19, W10, W18
    MOVN  W28, #0x1a5d, LSL #0
    LSL  X21, X8, #5
    CRC32H  W10, W10, W24
    CRC32H  W17, W23, W3
    CRC32W  W26, W2, W10
    MOVZ  W8, #0xaf29, LSL #16
    LSL  W29, W8, W25
    LSRV  W19, W17, W27
    CRC32B  W10, W2, W19
    CRC32X  W24, W28, X28
    MOVN  X5, #0x6f3f, LSL #0
    MOV  X3, X29
    MOV  W25, W21
    LSLV  X23, X3, X26
    LSL  X8, X5, X23
    LSLV  W21, W12, W25
    MOV  W18, W24
    LSL  W17, W8, #3
    LSL  W27, W29, W21
    MOVK  X7, #0xe3b0, LSL #0
    LSR  X2, X10, X27
    CRC32CH  W27, W18, W18
    LSL  X12, X17, X2
    MOVN  X10, #0x5c40, LSL #32
    CRC32X  W25, W10, X27
    MOV  W10, W7
    LSR  X29, X10, X10
    LSR  W23, W29, W29
    MOVN  W21, #0x517b, LSL #16
    CRC32H  W27, W12, W12
    MOVK  X17, #0xc6d1, LSL #0
    CRC32B  W24, W23, W17
    MOV  X2, X21
    LSL  X7, X27, #3
    MOVK  W10, #0x43bb, LSL #16
    LSR  W21, W25, W2
    LSR  W18, W7, W7
    MOVN  W5, #0xb024, LSL #16
    MOVN  W7, #0xfb8f, LSL #0
    MOV  X17, X10
    LSR  X2, X17, X18
    CRC32CX  W3, W21, X7
    LSR  X21, X5, #0x3d
    LSR  X10, X3, #0xf
    CRC32B  W3, W8, W10
    LSRV  W5, W2, W27
    MOVZ  X8, #0xe702, LSL #16
    MOVK  X25, #0xb971, LSL #32
    CRC32CX  W10, W3, X3
    MOVN  X23, #0x38b0, LSL #0
    LSR  X18, X21, X21
    LSR  W21, W24, #0xc
    LSL  W17, W7, #28
    LSRV  W24, W25, W25
    MOVK  X29, #0x447c, LSL #0
    LSL  W7, W24, W5
    LSR  W2, W29, W20
    MOVN  X20, #0xe206, LSL #0
    CRC32CW  W3, W7, W2
    LSR  X2, X8, X10
    LSL  W29, W18, #4
    CRC32CB  W18, W18, W21
    LSR  X21, X20, #0x6
    LSLV  X27, X23, X21
    LSRV  W5, W17, W2
    MOVN  W7, #0xfe4, LSL #16
    CRC32W  W24, W29, W7
    SUBS  X9, X9, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_12
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xe702, LSL #16
    SUB  X16, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x3ed0, LSL #0
    MOVK  X13, #0xc854, LSL #16
    SUB  X16, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x7c00, LSL #0
    MOVK  X13, #0x9d99, LSL #16
    MOVK  X13, #0x97bc, LSL #32
    MOVK  X13, #0x1b44, LSL #48
    SUB  X16, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xf01b, LSL #16
    SUB  X16, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xe702, LSL #16
    SUB  X16, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x90c0, LSL #16
    MOVK  X13, #0x1fff, LSL #32
    SUB  X16, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0xa29b, LSL #0
    MOVK  X13, #0xed03, LSL #16
    SUB  X16, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0xd8b4, LSL #0
    MOVK  X13, #0x4059, LSL #16
    SUB  X16, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x1df9, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X16, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0xfc77, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0x3ff, LSL #48
    SUB  X16, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0xc74f, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X16, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0xb9a, LSL #0
    MOVK  X13, #0x7416, LSL #16
    SUB  X16, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x2096, LSL #0
    MOVK  X13, #0x9add, LSL #16
    MOVK  X13, #0xb971, LSL #32
    SUB  X16, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x7d2a, LSL #0
    MOVK  X13, #0x7e61, LSL #16
    SUB  X16, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xa780, LSL #48
    SUB  X16, X13, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0xe5a2, LSL #0
    MOVK  X13, #0xffff, LSL #16
    SUB  X16, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X3, #0xf, LSL #0
TSRTIntCRCAndShiftAndMov_label_13:
    LSR  W7, W27, W15
    LSR  W12, W18, #0xc
    LSL  W15, W10, W26
    MOVN  W4, #0xf651, LSL #0
    CRC32B  W17, W29, W7
    MOV  W4, W16
    CRC32B  W8, W19, W4
    CRC32CH  W15, W17, W17
    MOVK  W19, #0x6cda, LSL #0
    CRC32CW  W18, W3, W13
    LSR  W2, W19, W8
    CRC32CB  W20, W21, W23
    LSR  X27, X20, #0x19
    MOV  X13, X25
    MOV  X15, X24
    LSR  X29, X2, X3
    CRC32CH  W19, W18, W27
    MOV  W26, W12
    CRC32CW  W7, W26, W13
    MOVK  X10, #0xce0, LSL #0
    LSR  W25, W10, W10
    CRC32CX  W26, W21, X15
    LSR  W24, W29, W29
    MOVZ  W10, #0x4968, LSL #0
    MOV  W15, W19
    LSL  X19, X15, #58
    CRC32H  W21, W19, W24
    MOV  X19, X7
    MOVN  W8, #0xad94, LSL #16
    MOV  W16, W25
    MOVN  X13, #0x9b4a, LSL #48
    LSL  X23, X21, #55
    MOVN  W21, #0x8222, LSL #0
    MOVN  W27, #0x33e1, LSL #0
    LSLV  X29, X27, X13
    LSL  W25, W29, W23
    LSR  W15, W10, #0x10
    CRC32W  W12, W21, W10
    MOVN  W23, #0xbc38, LSL #16
    LSR  X2, X15, X19
    CRC32CH  W15, W26, W25
    MOV  W19, W15
    MOVK  X29, #0xcc59, LSL #0
    CRC32CX  W25, W4, X23
    CRC32X  W13, W12, X16
    LSR  X27, X13, #0xd
    LSRV  W10, W19, W8
    CRC32CX  W21, W10, X2
    LSL  X12, X25, X29
    LSL  X23, X13, #8
    LSL  W2, W27, #11
    LSL  W27, W21, #29
    LSR  W4, W27, #0xb
    LSL  W7, W2, W12
    MOVZ  X25, #0xa8f, LSL #0
    CRC32CW  W21, W4, W5
    LSR  W26, W23, #0xc
    MOVN  W23, #0x584d, LSL #0
    MOV  X12, X8
    MOVZ  X4, #0x338e, LSL #48
    LSL  W25, W21, #23
    LSL  W29, W25, #10
    CRC32CH  W5, W29, W29
    LSL  X8, X5, #14
    MOVK  X29, #0x2a46, LSL #16
    LSLV  W27, W26, W7
    CRC32H  W2, W4, W29
    LSL  W16, W27, #4
    CRC32CB  W13, W2, W8
    CRC32CH  W21, W12, W23
    CRC32W  W27, W16, W16
    CRC32H  W29, W21, W27
    LSL  X7, X29, X29
    LSRV  X8, X7, X7
    MOVZ  W29, #0x220b, LSL #0
    CRC32CB  W19, W13, W29
    MOVZ  W26, #0xa0fa, LSL #0
    LSL  X4, X8, #56
    LSL  W25, W7, W19
    CRC32CX  W8, W25, X26
    LSLV  W5, W7, W21
    LSL  W7, W4, W5
    CRC32W  W13, W8, W2
    MOVN  X16, #0x7f18, LSL #0
    LSR  W19, W7, #0xd
    MOVZ  W8, #0xc986, LSL #16
    MOVN  X7, #0x10a3, LSL #48
    MOVZ  X2, #0x11aa, LSL #48
    MOVK  W4, #0x8d80, LSL #16
    MOVN  W5, #0xc5c5, LSL #16
    CRC32X  W27, W2, X13
    CRC32H  W21, W27, W19
    LSL  X27, X4, X5
    MOV  X26, X16
    CRC32W  W4, W26, W26
    CRC32CX  W13, W8, X7
    LSR  X25, X4, #0xe
    LSLV  X16, X25, X25
    LSR  W2, W16, W21
    LSLV  W19, W27, W2
    LSR  W5, W7, #0x1b
    LSL  X8, X13, #39
    CRC32X  W25, W19, X5
    CRC32CH  W26, W25, W8
    CRC32CH  W7, W10, W8
    CRC32CX  W8, W12, X13
    CRC32B  W21, W21, W25
    LSR  W15, W16, #0x2
    LSRV  W16, W15, W4
    MOVN  X25, #0x7cf7, LSL #32
    CRC32X  W12, W18, X17
    LSR  W4, W5, W16
    CRC32H  W5, W20, W17
    MOV  W15, W16
    CRC32CW  W2, W4, W8
    LSLV  W10, W5, W2
    CRC32CW  W20, W26, W10
    CRC32X  W18, W12, X20
    LSL  W13, W25, #30
    LSL  X17, X21, X15
    MOVZ  W25, #0x280b, LSL #16
    LSLV  X4, X25, X17
    MOVZ  W27, #0xdc44, LSL #0
    LSRV  X16, X4, X13
    LSR  W4, W7, #0x9
    CRC32X  W7, W18, X3
    MOVN  X18, #0xfd66, LSL #32
    LSRV  W25, W7, W16
    LSL  X12, X25, #2
    CRC32X  W25, W4, X4
    LSRV  W26, W25, W2
    LSL  W21, W26, W8
    MOV  X19, X21
    CRC32CB  W2, W19, W18
    CRC32CX  W19, W2, X2
    MOVZ  X21, #0x9e5a, LSL #48
    LSL  X25, X21, X27
    CRC32CW  W15, W19, W26
    MOVZ  W7, #0xd39f, LSL #0
    LSR  X27, X7, X7
    CRC32CX  W13, W25, X15
    LSLV  W4, W12, W27
    CRC32CX  W2, W4, X13
    MOVK  X20, #0xbdae, LSL #32
    LSL  W16, W17, W21
    MOV  W8, W16
    CRC32X  W10, W2, X29
    LSRV  W4, W21, W3
    MOVN  X29, #0x1f73, LSL #48
    LSRV  W19, W17, W25
    CRC32CH  W18, W27, W8
    MOV  X21, X19
    MOV  W12, W15
    CRC32W  W27, W25, W8
    MOVN  X8, #0x8c47, LSL #48
    CRC32H  W7, W8, W8
    LSLV  X15, X20, X21
    LSLV  X16, X29, X10
    LSR  X10, X27, X15
    CRC32CX  W26, W18, X7
    CRC32X  W20, W26, X4
    LSLV  W2, W10, W16
    CRC32CX  W8, W12, X20
    LSL  W7, W2, #5
    LSR  W19, W8, #0x5
    MOV  X29, X19
    CRC32CB  W4, W7, W7
    LSRV  X26, X13, X29
    LSR  W2, W29, W4
    MOV  X29, X26
    MOV  X8, X29
    CRC32B  W15, W2, W23
    MOVN  W19, #0xdafc, LSL #0
    LSLV  X18, X19, X8
    LSRV  X26, X18, X15
    CRC32CX  W7, W8, X20
    MOVN  X13, #0x6a, LSL #0
    MOV  W27, W15
    MOV  W29, W21
    LSL  W4, W10, #4
    MOVN  X15, #0x8abe, LSL #16
    LSRV  W12, W20, W17
    LSRV  X18, X24, X27
    LSL  X17, X26, X12
    CRC32CX  W21, W20, X13
    LSL  X8, X2, X3
    MOV  X26, X25
    LSL  W25, W8, W8
    CRC32B  W19, W15, W7
    MOVK  X13, #0x149c, LSL #0
    MOV  X15, X29
    LSRV  X7, X19, X26
    LSL  W10, W13, #27
    CRC32H  W13, W4, W15
    MOVK  X2, #0x5afc, LSL #0
    CRC32CW  W12, W18, W21
    MOVZ  W20, #0xfada, LSL #16
    MOV  X24, X17
    CRC32H  W17, W23, W24
    CRC32CX  W23, W20, X20
    SUBS  X3, X3, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_13
    MOVZ  X28, #0x5afc, LSL #0
    SUB  X9, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X28, #0x6580, LSL #0
    MOVK  X28, #0x97fd, LSL #16
    SUB  X9, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X28, #0xc08d, LSL #0
    MOVK  X28, #0x209, LSL #16
    SUB  X9, X28, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X28, #0x85dc, LSL #0
    MOVK  X28, #0x56c6, LSL #16
    SUB  X9, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X28, #0xc1b2, LSL #0
    MOVK  X28, #0x1, LSL #16
    SUB  X9, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xe000, LSL #16
    SUB  X9, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X28, #0x2c72, LSL #0
    MOVK  X28, #0x8cb1, LSL #16
    SUB  X9, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X28, #0x22f0, LSL #0
    MOVK  X28, #0xbf2e, LSL #16
    SUB  X9, X28, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X28, #0x2018, LSL #0
    MOVK  X28, #0xec5f, LSL #16
    SUB  X9, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xfffe, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X9, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X28, #0x58e, LSL #0
    MOVK  X28, #0x9e41, LSL #16
    SUB  X9, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X28, #0x85dc, LSL #0
    MOVK  X28, #0x56c6, LSL #16
    SUB  X9, X28, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xfada, LSL #16
    SUB  X9, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X28, #0xa3b8, LSL #0
    MOVK  X28, #0xe3d5, LSL #16
    SUB  X9, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x6c8, LSL #16
    SUB  X9, X28, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xe5a0, LSL #48
    SUB  X9, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X28, #0xb830, LSL #0
    MOVK  X28, #0xda60, LSL #16
    SUB  X9, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X28, #0x2018, LSL #0
    MOVK  X28, #0xec5f, LSL #16
    SUB  X9, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
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
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
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
    MOVZ  X20, #0xf, LSL #0
TSRTIntCRCAndShiftAndMov_label_14:
    LSR  X27, X27, #0x24
    MOV  W23, W29
    CRC32X  W9, W27, X27
    MOV  X13, X28
    CRC32CB  W13, W26, W20
    MOVK  W18, #0xaa0, LSL #16
    MOV  X13, X23
    LSR  X23, X9, #0x1d
    MOVZ  W26, #0xb044, LSL #0
    MOVZ  W4, #0x7ef0, LSL #16
    LSR  X2, X4, X26
    LSR  X4, X18, X18
    CRC32B  W18, W25, W25
    CRC32H  W9, W18, W18
    MOVK  W25, #0xe8bd, LSL #0
    LSL  W26, W4, #24
    CRC32CX  W7, W9, X26
    LSL  X27, X13, X2
    MOV  X16, X7
    CRC32X  W25, W13, X25
    CRC32CH  W15, W23, W25
    MOVN  W25, #0x5b4, LSL #16
    LSRV  W3, W25, W27
    MOVK  X21, #0xfb92, LSL #32
    CRC32CB  W27, W21, W21
    MOV  X3, X15
    LSR  X3, X16, X27
    LSL  W26, W12, W5
    MOV  X23, X2
    LSR  W28, W27, #0x1b
    LSLV  X25, X25, X19
    MOV  X9, X20
    MOVZ  X12, #0x7fcb, LSL #0
    CRC32B  W16, W20, W8
    CRC32CX  W4, W18, X25
    CRC32W  W7, W4, W23
    LSLV  W18, W15, W28
    MOVZ  W13, #0x30a5, LSL #0
    LSL  X19, X15, X3
    MOVK  W26, #0x3b3c, LSL #0
    LSL  W8, W26, #15
    MOV  W23, W10
    LSRV  X3, X12, X13
    CRC32H  W21, W18, W3
    LSRV  X10, X9, X16
    LSRV  X28, X10, X19
    CRC32W  W16, W23, W28
    MOVN  W10, #0x6d68, LSL #0
    MOV  X18, X29
    MOV  W9, W16
    MOV  W5, W8
    CRC32W  W19, W21, W7
    MOVN  X15, #0x6c52, LSL #32
    CRC32W  W28, W15, W5
    MOV  X5, X19
    LSRV  W7, W5, W10
    LSR  W29, W7, W18
    MOVZ  W12, #0xd3df, LSL #16
    LSRV  W4, W9, W9
    MOVK  X9, #0x3992, LSL #0
    LSR  X23, X4, X9
    CRC32CH  W16, W12, W23
    CRC32CH  W25, W29, W29
    CRC32H  W29, W28, W16
    LSR  W9, W25, #0x10
    MOV  X28, X18
    CRC32CH  W7, W10, W29
    CRC32H  W8, W9, W9
    LSRV  W4, W27, W7
    LSLV  W10, W28, W8
    MOVK  X23, #0xd250, LSL #0
    MOVN  W5, #0xc6e, LSL #16
    MOVZ  X8, #0xf3bb, LSL #0
    LSL  X25, X29, X4
    LSL  X12, X25, X8
    MOVN  X4, #0xd448, LSL #32
    MOV  W18, W4
    LSRV  W7, W18, W10
    MOV  W16, W7
    CRC32H  W7, W4, W23
    CRC32H  W21, W16, W5
    LSR  W25, W21, #0xd
    MOV  X4, X12
    CRC32CB  W12, W4, W7
    LSLV  W8, W25, W12
    MOVZ  W18, #0xae68, LSL #16
    LSR  W7, W9, #0xf
    LSRV  X21, X18, X13
    MOV  W23, W7
    MOVN  W4, #0x471f, LSL #16
    LSR  X29, X10, X4
    MOV  W13, W21
    MOV  X7, X15
    LSR  X12, X25, #0x1c
    LSRV  X21, X29, X12
    LSL  X9, X10, X23
    CRC32CW  W10, W25, W2
    CRC32X  W2, W23, X5
    CRC32CX  W23, W16, X19
    LSLV  W28, W4, W16
    LSR  X5, X23, #0x2c
    MOVN  W12, #0x3d1, LSL #0
    MOV  X18, X8
    LSLV  X29, X5, X13
    LSL  W25, W18, #1
    CRC32CX  W15, W7, X29
    LSLV  W4, W28, W21
    CRC32H  W18, W9, W12
    LSL  W12, W2, W18
    MOV  W19, W25
    LSR  X18, X10, X15
    CRC32B  W16, W12, W18
    LSR  X23, X16, #0x19
    LSRV  W29, W4, W29
    CRC32CH  W8, W23, W19
    LSR  W13, W29, W8
    MOV  W18, W12
    LSL  W21, W18, W3
    CRC32CW  W18, W21, W7
    LSL  X28, X27, X25
    LSR  W3, W29, #0x8
    LSL  W19, W23, #1
    MOVN  W16, #0x3dc4, LSL #16
    MOV  X12, X15
    LSL  W2, W8, #4
    MOV  X27, X10
    MOVN  X8, #0xdd4d, LSL #48
    MOV  X5, X27
    CRC32X  W27, W23, X19
    MOVN  W10, #0x5d76, LSL #0
    MOVZ  W23, #0x2329, LSL #16
    LSRV  X9, X25, X8
    LSLV  W7, W23, W13
    CRC32B  W29, W5, W18
    LSL  X21, X28, #21
    LSLV  W4, W27, W10
    MOV  W19, W2
    MOVN  X28, #0x3b3e, LSL #32
    CRC32H  W5, W15, W3
    MOV  W5, W5
    LSRV  X8, X29, X9
    MOVN  W25, #0xc4ce, LSL #16
    CRC32CB  W15, W5, W7
    CRC32B  W27, W16, W25
    CRC32B  W23, W21, W12
    CRC32X  W13, W19, X4
    LSL  W29, W13, W15
    LSRV  W9, W28, W27
    MOVN  X27, #0xec27, LSL #48
    LSR  X3, X9, X8
    LSRV  W21, W27, W3
    CRC32CB  W7, W21, W21
    CRC32CH  W15, W7, W23
    LSR  W19, W15, #0x14
    LSRV  X7, X29, X29
    MOVZ  W2, #0x95ee, LSL #16
    MOVZ  X8, #0xe9cc, LSL #32
    MOVK  W13, #0x4bb4, LSL #0
    MOV  W21, W9
    LSR  W23, W19, W8
    MOV  W5, W2
    LSRV  W29, W7, W5
    CRC32CB  W3, W13, W13
    LSL  W7, W21, #16
    CRC32CH  W13, W7, W7
    CRC32W  W5, W23, W23
    MOV  X23, X3
    CRC32CH  W19, W13, W29
    MOVN  W13, #0x5e6b, LSL #0
    CRC32H  W9, W13, W19
    MOV  X25, X9
    CRC32B  W21, W5, W25
    LSL  X16, X23, #40
    MOVZ  W2, #0x9bc5, LSL #16
    CRC32W  W7, W2, W2
    LSL  X19, X21, X7
    MOVZ  W13, #0x9c17, LSL #0
    CRC32CW  W3, W13, W16
    CRC32B  W16, W27, W23
    CRC32CX  W23, W16, X19
    MOV  X19, X3
    LSL  X16, X23, #24
    LSRV  W5, W16, W19
    MOVZ  X23, #0xa706, LSL #0
    LSL  X16, X20, X13
    MOV  W2, W10
    CRC32W  W21, W23, W12
    LSL  W9, W2, W10
    MOV  X27, X2
    CRC32H  W13, W21, W10
    LSL  X25, X20, #25
    LSLV  X21, X4, X21
    LSR  X3, X19, #0x36
    MOVZ  X29, #0xa1c7, LSL #0
    LSRV  X23, X5, X27
    MOVK  X10, #0x6788, LSL #48
    MOVN  W4, #0x2752, LSL #0
    CRC32CH  W12, W16, W16
    CRC32CX  W27, W9, X12
    CRC32CX  W5, W13, X4
    SUBS  X20, X20, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_14
    MOVZ  X17, #0xa289, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X24, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0xd8ad, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X24, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x2a27, LSL #0
    MOVK  X17, #0x9b91, LSL #16
    SUB  X24, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xe9cc, LSL #32
    SUB  X24, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x1200, LSL #0
    MOVK  X17, #0xff45, LSL #16
    SUB  X24, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0xa289, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0x6788, LSL #48
    SUB  X24, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x80, LSL #0
    SUB  X24, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x16fe, LSL #0
    MOVK  X17, #0xd07f, LSL #16
    SUB  X24, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x18aa, LSL #0
    MOVK  X17, #0x36f3, LSL #16
    SUB  X24, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x80, LSL #16
    SUB  X24, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x2603, LSL #0
    MOVK  X17, #0x39c4, LSL #16
    SUB  X24, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x99e1, LSL #0
    MOVK  X17, #0xad6e, LSL #16
    SUB  X24, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x8000, LSL #0
    MOVK  X17, #0xf, LSL #16
    SUB  X24, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x200, LSL #16
    SUB  X24, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x3b3c, LSL #0
    SUB  X24, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x5c74, LSL #0
    MOVK  X17, #0x8bf5, LSL #16
    SUB  X24, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xc4c1, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X24, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0xa1c7, LSL #0
    SUB  X24, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X2, #0x443e, LSL #0
    MOVK  X2, #0xe4f1, LSL #16
    MOVK  X2, #0xb87c, LSL #32
    MOVK  X2, #0xc475, LSL #48
    MOVZ  X3, #0x9a2f, LSL #0
    MOVK  X3, #0x62d2, LSL #16
    MOVK  X3, #0x593a, LSL #32
    MOVK  X3, #0x5705, LSL #48
    MOVZ  X4, #0x41e1, LSL #0
    MOVK  X4, #0xf09, LSL #16
    MOVK  X4, #0xb51f, LSL #32
    MOVK  X4, #0xc96, LSL #48
    MOVZ  X5, #0x3dee, LSL #0
    MOVK  X5, #0x1081, LSL #16
    MOVK  X5, #0x50c8, LSL #32
    MOVK  X5, #0xfbe7, LSL #48
    MOVZ  X7, #0xfc75, LSL #0
    MOVK  X7, #0xafb5, LSL #16
    MOVK  X7, #0xc27e, LSL #32
    MOVK  X7, #0x3387, LSL #48
    MOVZ  X8, #0xa272, LSL #0
    MOVK  X8, #0xa5ef, LSL #16
    MOVK  X8, #0x5076, LSL #32
    MOVK  X8, #0x851a, LSL #48
    MOVZ  X9, #0x3471, LSL #0
    MOVK  X9, #0xc39d, LSL #16
    MOVK  X9, #0xc4e7, LSL #32
    MOVK  X9, #0x49c9, LSL #48
    MOVZ  X10, #0x8184, LSL #0
    MOVK  X10, #0x6ebf, LSL #16
    MOVK  X10, #0xb80a, LSL #32
    MOVK  X10, #0x5a52, LSL #48
    MOVZ  X12, #0x3424, LSL #0
    MOVK  X12, #0x3b7c, LSL #16
    MOVK  X12, #0xb73f, LSL #32
    MOVK  X12, #0x5d1, LSL #48
    MOVZ  X13, #0x1582, LSL #0
    MOVK  X13, #0xdc3, LSL #16
    MOVK  X13, #0x8ba, LSL #32
    MOVK  X13, #0xd1be, LSL #48
    MOVZ  X15, #0xd0a3, LSL #0
    MOVK  X15, #0x4eb1, LSL #16
    MOVK  X15, #0x6bd6, LSL #32
    MOVK  X15, #0x7ec2, LSL #48
    MOVZ  X16, #0x2e17, LSL #0
    MOVK  X16, #0x275, LSL #16
    MOVK  X16, #0x75d7, LSL #32
    MOVK  X16, #0x19bc, LSL #48
    MOVZ  X17, #0xb50d, LSL #0
    MOVK  X17, #0x7a29, LSL #16
    MOVK  X17, #0x6f42, LSL #32
    MOVK  X17, #0x76a0, LSL #48
    MOVZ  X18, #0x324e, LSL #0
    MOVK  X18, #0x789b, LSL #16
    MOVK  X18, #0xe7eb, LSL #32
    MOVK  X18, #0xdd39, LSL #48
    MOVZ  X19, #0x9663, LSL #0
    MOVK  X19, #0xc273, LSL #16
    MOVK  X19, #0xa365, LSL #32
    MOVK  X19, #0xfab1, LSL #48
    MOVZ  X20, #0xb654, LSL #0
    MOVK  X20, #0x6e45, LSL #16
    MOVK  X20, #0x41a, LSL #32
    MOVK  X20, #0xaa3b, LSL #48
    MOVZ  X21, #0x8547, LSL #0
    MOVK  X21, #0x1820, LSL #16
    MOVK  X21, #0xcf0f, LSL #32
    MOVK  X21, #0xbd62, LSL #48
    MOVZ  X23, #0xbbb0, LSL #0
    MOVK  X23, #0xf103, LSL #16
    MOVK  X23, #0x21d1, LSL #32
    MOVK  X23, #0x6500, LSL #48
    MOVZ  X24, #0xe128, LSL #0
    MOVK  X24, #0x9ea1, LSL #16
    MOVK  X24, #0x1d09, LSL #32
    MOVK  X24, #0x3691, LSL #48
    MOVZ  X25, #0x9871, LSL #0
    MOVK  X25, #0xe5a, LSL #16
    MOVK  X25, #0x3dc4, LSL #32
    MOVK  X25, #0xfcbd, LSL #48
    MOVZ  X26, #0xae11, LSL #0
    MOVK  X26, #0xba33, LSL #16
    MOVK  X26, #0xd012, LSL #32
    MOVK  X26, #0xd808, LSL #48
    MOVZ  X27, #0xab60, LSL #0
    MOVK  X27, #0x39bb, LSL #16
    MOVK  X27, #0xa5c4, LSL #32
    MOVK  X27, #0x5bd7, LSL #48
    MOVZ  X28, #0xb78b, LSL #0
    MOVK  X28, #0x4b9d, LSL #16
    MOVK  X28, #0xbd36, LSL #32
    MOVK  X28, #0x1b9c, LSL #48
    MOVZ  X29, #0xac6b, LSL #0
    MOVK  X29, #0x74cc, LSL #16
    MOVK  X29, #0xeea8, LSL #32
    MOVK  X29, #0x83d0, LSL #48
    MOVZ  X5, #0xf, LSL #0
TSRTIntCRCAndShiftAndMov_label_15:
    CRC32CB  W21, W28, W28
    MOVK  X8, #0xe5d9, LSL #16
    MOVZ  W17, #0x26d0, LSL #0
    LSR  X18, X26, #0x1a
    LSL  X17, X8, X18
    LSLV  W21, W17, W21
    CRC32H  W16, W27, W5
    LSL  W13, W29, W21
    LSL  W25, W25, #22
    CRC32CW  W4, W25, W25
    CRC32CB  W21, W16, W13
    LSRV  X7, X4, X4
    MOVN  W21, #0x5bf8, LSL #16
    CRC32X  W20, W21, X7
    LSLV  W17, W28, W16
    LSL  X18, X17, X2
    MOVZ  W2, #0x6ff2, LSL #16
    LSLV  W21, W13, W25
    CRC32X  W24, W28, X15
    MOV  W16, W12
    CRC32B  W10, W15, W27
    LSL  W2, W4, #6
    MOVZ  X2, #0x8009, LSL #32
    MOVZ  W29, #0x8285, LSL #0
    MOVK  W8, #0x6f13, LSL #0
    LSL  X20, X21, #40
    LSR  X21, X18, #0x23
    LSLV  X26, X10, X2
    MOVK  W28, #0x255d, LSL #0
    CRC32CX  W16, W16, X8
    LSLV  X27, X29, X24
    CRC32H  W3, W20, W26
    LSL  X7, X21, X21
    CRC32W  W12, W28, W28
    LSR  W25, W12, #0x7
    MOVK  X4, #0xe7d0, LSL #16
    LSL  W18, W4, W4
    MOV  X8, X16
    CRC32X  W26, W27, X25
    MOV  W25, W18
    LSR  W24, W25, W8
    LSR  X10, X7, #0xd
    CRC32B  W29, W3, W10
    MOVK  W18, #0x22f0, LSL #16
    MOVK  W20, #0xb7ae, LSL #16
    LSR  X12, X26, #0x3
    MOVZ  W8, #0x5ddb, LSL #16
    LSR  X28, X24, #0x2d
    CRC32B  W16, W20, W29
    LSRV  X3, X18, X18
    MOVZ  X27, #0xef57, LSL #16
    LSL  W18, W27, W8
    LSR  W26, W12, #0x13
    LSRV  X25, X28, X16
    MOV  X24, X26
    LSRV  W20, W3, W16
    MOVZ  W8, #0xdd8b, LSL #16
    LSLV  W4, W18, W20
    LSRV  X16, X25, X8
    MOV  X12, X16
    MOV  W20, W24
    LSLV  W10, W20, W4
    CRC32CH  W29, W10, W10
    LSLV  W26, W29, W12
    MOV  X27, X26
    CRC32CW  W26, W20, W13
    CRC32X  W3, W13, X27
    LSRV  X4, X10, X25
    MOVN  X24, #0xc4e9, LSL #0
    LSR  W18, W4, W18
    MOVK  W28, #0x128d, LSL #16
    CRC32W  W7, W16, W19
    MOVN  W27, #0x2dc2, LSL #0
    LSL  W19, W19, W13
    LSR  X8, X15, X13
    MOV  X18, X28
    MOVN  X12, #0x2e4a, LSL #48
    MOV  W25, W27
    LSL  X13, X24, #50
    LSL  X15, X26, #3
    MOVZ  X29, #0x23a, LSL #16
    MOV  X20, X18
    CRC32CW  W26, W13, W8
    LSR  W24, W26, #0x15
    MOV  W26, W24
    LSR  X18, X20, X20
    MOV  X24, X21
    LSL  W16, W18, #14
    CRC32CX  W18, W19, X24
    CRC32W  W19, W7, W12
    LSLV  X20, X25, X25
    MOV  W27, W16
    CRC32B  W4, W20, W19
    CRC32CX  W20, W27, X29
    MOVK  X21, #0x9d93, LSL #48
    LSR  W12, W4, W26
    LSLV  X29, X15, X15
    LSR  W27, W29, W29
    MOV  W29, W20
    LSRV  X20, X2, X27
    MOVZ  X26, #0x1d1c, LSL #16
    LSL  X24, X26, #16
    CRC32H  W7, W20, W20
    LSL  W19, W21, W21
    MOVK  W15, #0xf82d, LSL #0
    LSL  X4, X13, #16
    CRC32CH  W26, W24, W24
    LSL  W16, W12, #30
    CRC32H  W25, W18, W26
    CRC32CB  W21, W7, W4
    MOV  X2, X15
    CRC32W  W15, W29, W19
    LSLV  W8, W2, W15
    LSLV  X20, X25, X21
    LSRV  X13, X16, X27
    CRC32CX  W24, W8, X20
    LSL  X4, X13, X24
    MOV  X17, X21
    LSR  X12, X4, X3
    MOV  X7, X17
    MOVK  X2, #0x55fd, LSL #48
    MOVN  X19, #0x6666, LSL #0
    MOV  X27, X13
    MOVK  X13, #0xe05a, LSL #0
    LSR  X26, X17, #0x14
    CRC32W  W21, W19, W21
    CRC32CB  W7, W10, W4
    LSR  X24, X15, X25
    LSR  X17, X20, #0x20
    LSR  X10, X12, #0x10
    LSR  W20, W2, W13
    MOVN  W4, #0xb964, LSL #16
    CRC32CX  W18, W17, X24
    LSL  X8, X18, #35
    CRC32W  W24, W7, W8
    CRC32H  W7, W21, W10
    CRC32X  W15, W20, X20
    MOVK  X3, #0xcb13, LSL #0
    CRC32H  W17, W15, W20
    CRC32B  W20, W27, W4
    LSR  X10, X3, X24
    MOV  X27, X10
    LSRV  X16, X20, X20
    CRC32CH  W10, W7, W27
    LSL  W7, W10, W16
    CRC32B  W13, W17, W17
    MOV  X19, X7
    MOVZ  W20, #0x8c2c, LSL #0
    MOVN  X21, #0x4f7c, LSL #32
    LSLV  W15, W21, W19
    CRC32X  W27, W13, X26
    CRC32X  W3, W20, X20
    LSLV  X10, X15, X27
    MOV  W7, W10
    CRC32CX  W17, W7, X3
    MOVN  W21, #0xd86b, LSL #16
    LSR  X19, X26, X29
    MOVN  W3, #0xa793, LSL #16
    CRC32CH  W7, W28, W3
    LSLV  X24, X29, X28
    LSLV  X26, X2, X28
    MOVK  X13, #0x5673, LSL #16
    MOV  W2, W13
    CRC32CB  W16, W12, W2
    CRC32CH  W13, W18, W16
    LSLV  W28, W26, W24
    MOVN  X10, #0x8d8b, LSL #0
    CRC32CW  W15, W7, W3
    MOV  W29, W26
    MOVK  X24, #0xaf89, LSL #32
    MOVK  W18, #0xbf9a, LSL #0
    LSR  W20, W19, #0x12
    CRC32CX  W27, W20, X17
    LSR  W16, W18, #0x2
    LSLV  X19, X21, X21
    LSRV  X3, X19, X15
    MOVN  W26, #0x818, LSL #16
    CRC32H  W2, W26, W13
    MOVK  W7, #0xdf07, LSL #0
    LSR  X12, X16, X10
    CRC32CX  W10, W3, X12
    CRC32B  W13, W7, W2
    MOVN  W16, #0x252, LSL #16
    MOV  X26, X28
    LSR  W17, W10, W24
    CRC32CX  W24, W13, X17
    MOVN  W20, #0xe1fd, LSL #0
    CRC32H  W17, W26, W16
    LSL  W16, W29, #7
    MOVZ  W10, #0xa932, LSL #0
    LSR  X19, X16, X24
    LSR  W29, W29, W10
    LSL  W21, W19, #7
    MOV  X19, X17
    LSLV  W18, W27, W19
    MOV  W17, W20
    LSLV  W20, W29, W7
    MOVZ  X28, #0xd934, LSL #16
    LSRV  W15, W18, W28
    CRC32H  W3, W15, W15
    SUBS  X5, X5, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_15
    MOVZ  X23, #0x82b3, LSL #0
    MOVK  X23, #0x1d32, LSL #16
    SUB  X9, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0x469b, LSL #16
    SUB  X9, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0xdf07, LSL #0
    MOVK  X23, #0xe9e, LSL #16
    SUB  X9, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xb688, LSL #32
    MOVK  X23, #0xd95, LSL #48
    SUB  X9, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0xa932, LSL #0
    SUB  X9, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0xe94a, LSL #0
    MOVK  X23, #0xcc02, LSL #16
    SUB  X9, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x1680, LSL #0
    MOVK  X23, #0x3f7c, LSL #16
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x1e02, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X9, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x48ff, LSL #0
    MOVK  X23, #0xbe26, LSL #16
    SUB  X9, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0xcf80, LSL #0
    MOVK  X23, #0xb, LSL #16
    SUB  X9, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0xc41e, LSL #0
    MOVK  X23, #0xf9b2, LSL #16
    SUB  X9, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0xe5c0, LSL #0
    MOVK  X23, #0x3406, LSL #16
    SUB  X9, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x5a00, LSL #16
    SUB  X9, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xd934, LSL #16
    SUB  X9, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x179f, LSL #0
    SUB  X9, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X16, #0xf, LSL #0
TSRTIntCRCAndShiftAndMov_label_16:
    CRC32CW  W2, W27, W18
    MOVK  W4, #0x6a26, LSL #0
    LSL  W25, W9, W15
    CRC32CH  W26, W9, W28
    MOV  X25, X29
    LSR  X28, X7, X19
    MOVK  X28, #0xe2fa, LSL #32
    LSL  W17, W20, #31
    MOV  W20, W4
    LSL  W23, W20, #3
    CRC32CB  W4, W28, W17
    CRC32X  W12, W24, X2
    MOV  X4, X16
    CRC32X  W13, W26, X12
    CRC32CB  W26, W25, W13
    CRC32B  W27, W23, W23
    MOVN  W24, #0x88d5, LSL #16
    MOV  W29, W24
    CRC32CH  W20, W4, W4
    CRC32W  W24, W26, W20
    LSLV  X19, X29, X29
    LSR  X7, X27, X27
    LSL  X15, X19, #60
    MOVK  W9, #0x7d67, LSL #0
    LSR  W23, W9, #0x6
    MOVK  W9, #0xa300, LSL #16
    MOV  W29, W24
    CRC32B  W13, W15, W7
    CRC32CX  W4, W13, X29
    CRC32CB  W20, W4, W23
    MOV  X26, X9
    MOV  X19, X26
    MOVZ  W7, #0x33fd, LSL #0
    MOV  W15, W19
    LSRV  X27, X20, X15
    LSLV  W15, W7, W7
    MOV  W4, W15
    MOVK  X24, #0x48c3, LSL #48
    LSRV  X15, X24, X27
    LSR  X7, X4, #0x1c
    LSL  W28, W7, W7
    LSR  W19, W9, W5
    MOVN  W24, #0x1f13, LSL #16
    CRC32X  W12, W24, X5
    LSRV  X9, X12, X15
    MOV  X27, X9
    LSL  W23, W27, #5
    LSR  W15, W23, W19
    MOVZ  X13, #0xa038, LSL #16
    LSR  W7, W15, W15
    MOV  X19, X7
    MOVK  X7, #0x74ed, LSL #16
    MOVZ  W20, #0x952d, LSL #0
    CRC32CH  W4, W7, W13
    LSLV  W7, W28, W19
    CRC32X  W13, W20, X20
    LSL  W15, W4, #19
    CRC32W  W4, W7, W13
    LSLV  W23, W15, W15
    LSL  W26, W23, W4
    CRC32H  W28, W13, W18
    MOV  X7, X28
    MOVK  X24, #0x6143, LSL #48
    LSR  X23, X28, #0x13
    MOVK  X19, #0x5665, LSL #0
    LSL  W18, W23, #4
    MOV  W13, W29
    MOV  W15, W9
    LSL  X23, X18, X20
    MOVK  W18, #0x78a0, LSL #16
    MOVZ  W28, #0x67cc, LSL #16
    LSR  W20, W13, W26
    LSL  X4, X20, #14
    MOV  W13, W19
    LSLV  W29, W15, W23
    MOVZ  W19, #0xe2a4, LSL #0
    LSL  W23, W7, W29
    CRC32X  W7, W13, X13
    CRC32CB  W9, W28, W28
    CRC32H  W29, W9, W19
    CRC32W  W28, W29, W18
    LSL  X18, X24, #16
    LSRV  W15, W18, W18
    LSR  W9, W28, #0x10
    LSRV  X19, X15, X7
    CRC32B  W15, W21, W20
    LSR  W13, W9, #0x1e
    MOVN  W29, #0xd714, LSL #16
    CRC32CW  W20, W23, W19
    MOVK  W19, #0xdeba, LSL #0
    LSRV  W7, W21, W20
    LSLV  W7, W15, W13
    LSL  X28, X29, #55
    MOVN  X15, #0x3c87, LSL #48
    LSL  W29, W28, #10
    LSL  X24, X15, X7
    MOV  X15, X29
    LSR  W7, W24, #0x11
    CRC32H  W24, W19, W19
    CRC32CX  W28, W15, X24
    MOV  X19, X7
    CRC32CH  W20, W28, W28
    LSRV  W7, W19, W20
    CRC32CB  W23, W7, W7
    LSR  X28, X23, X23
    LSL  W7, W3, W16
    MOV  W13, W4
    MOVK  W9, #0xf7c7, LSL #16
    CRC32CH  W15, W16, W25
    LSL  X21, X7, #57
    MOV  X19, X16
    MOV  X29, X16
    LSR  X7, X15, X29
    LSLV  X15, X16, X4
    CRC32CW  W25, W27, W15
    CRC32CB  W3, W5, W25
    LSR  W24, W17, W17
    CRC32B  W5, W3, W17
    LSR  X20, X4, X24
    CRC32CH  W3, W4, W19
    MOVN  W15, #0x73ab, LSL #0
    MOVZ  X2, #0x8f9d, LSL #0
    MOVK  X27, #0xa743, LSL #32
    CRC32H  W29, W3, W20
    MOVZ  X3, #0xd13e, LSL #32
    CRC32CB  W20, W21, W28
    LSL  W25, W5, W29
    LSL  X19, X3, X20
    LSL  X21, X19, X2
    LSLV  X4, X25, X25
    MOV  X29, X27
    MOV  W28, W9
    CRC32CB  W25, W15, W15
    LSR  X2, X28, X25
    CRC32X  W5, W4, X2
    LSR  W3, W21, W29
    MOVZ  W17, #0xf170, LSL #16
    CRC32X  W28, W17, X7
    MOVN  X29, #0xcd3f, LSL #48
    LSL  W21, W29, #2
    MOVK  X15, #0x8457, LSL #0
    LSR  X29, X28, X15
    LSR  X26, X27, #0x3a
    LSRV  X7, X5, X5
    CRC32CX  W9, W7, X29
    LSR  X19, X26, #0x19
    LSLV  W28, W19, W25
    CRC32CX  W20, W3, X21
    LSL  X26, X28, #5
    LSL  W17, W9, W9
    LSR  X2, X26, #0xf
    CRC32H  W7, W20, W17
    CRC32X  W5, W2, X7
    CRC32CW  W4, W27, W2
    MOVK  W15, #0xdccc, LSL #0
    MOV  X29, X26
    MOV  W25, W19
    LSL  W21, W27, W2
    CRC32CB  W3, W9, W18
    LSL  X9, X26, #1
    MOV  W7, W4
    CRC32W  W5, W27, W4
    CRC32CX  W26, W17, X18
    CRC32CH  W17, W26, W15
    CRC32W  W19, W25, W29
    MOV  X29, X3
    MOVN  X20, #0x7c7, LSL #32
    MOVN  W4, #0x4fbd, LSL #0
    LSR  W3, W21, W4
    CRC32CW  W18, W29, W3
    CRC32B  W2, W18, W9
    MOV  W9, W25
    MOV  X18, X9
    MOVN  W27, #0xee58, LSL #16
    CRC32CX  W15, W2, X17
    MOV  X29, X20
    LSR  W28, W21, W19
    LSLV  X25, X29, X28
    MOVN  X23, #0x9eff, LSL #0
    MOV  W29, W15
    MOVN  X3, #0x9038, LSL #16
    MOV  W17, W23
    MOV  W2, W3
    MOVZ  X9, #0x63ce, LSL #48
    MOV  W26, W29
    LSLV  W29, W18, W26
    LSR  X3, X27, X17
    MOV  W4, W7
    CRC32CW  W17, W2, W9
    MOVN  X2, #0xfe54, LSL #0
    CRC32W  W15, W2, W3
    MOVK  X20, #0x2e22, LSL #16
    MOV  X21, X17
    CRC32X  W17, W15, X4
    CRC32CW  W23, W25, W25
    MOVK  X19, #0x251f, LSL #48
    LSRV  W15, W19, W19
    LSL  W7, W29, W15
    MOVZ  W26, #0xfca3, LSL #0
    MOVN  W15, #0x28f4, LSL #16
    SUBS  X16, X16, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_16
    MOVZ  X10, #0x1ab, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X8, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0x11a7, LSL #16
    SUB  X8, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x63ce, LSL #48
    SUB  X8, X10, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0x50f0, LSL #0
    MOVK  X10, #0xfd2f, LSL #16
    SUB  X8, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0x8000, LSL #0
    MOVK  X10, #0x2f0d, LSL #16
    SUB  X8, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xd70b, LSL #16
    SUB  X8, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0xb1dc, LSL #0
    MOVK  X10, #0xbcff, LSL #16
    SUB  X8, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x251f, LSL #48
    SUB  X8, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0x2e22, LSL #16
    MOVK  X10, #0xf838, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X8, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0x9914, LSL #0
    MOVK  X10, #0xf86a, LSL #16
    SUB  X8, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x8000, LSL #16
    SUB  X8, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xf838, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X8, X10, X25
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0xfca3, LSL #0
    SUB  X8, X10, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0x11a7, LSL #16
    SUB  X8, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
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
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
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
    MOVZ  X27, #0xf, LSL #0
TSRTIntCRCAndShiftAndMov_label_17:
    CRC32CH  W9, W25, W25
    MOV  X3, X29
    MOVK  W8, #0x4c74, LSL #0
    CRC32CW  W23, W9, W3
    CRC32H  W13, W8, W23
    CRC32X  W4, W13, X13
    LSLV  W10, W28, W28
    CRC32W  W17, W27, W27
    CRC32B  W8, W17, W10
    MOV  X9, X8
    MOVZ  W8, #0xb4da, LSL #16
    MOVN  X29, #0x7a8, LSL #0
    MOVK  X21, #0xd083, LSL #16
    LSRV  X25, X29, X8
    MOVN  X13, #0xa6c3, LSL #16
    MOV  X24, X9
    LSL  W21, W28, #20
    CRC32CH  W17, W21, W21
    LSRV  W29, W4, W4
    MOVZ  X20, #0x9b47, LSL #48
    CRC32B  W29, W24, W25
    CRC32B  W17, W17, W17
    CRC32CH  W17, W17, W13
    CRC32CW  W17, W20, W29
    CRC32CH  W20, W27, W7
    CRC32CH  W9, W8, W10
    LSR  W20, W20, W24
    MOVN  X19, #0xfdd7, LSL #32
    MOV  W13, W12
    MOVZ  X21, #0xe1ec, LSL #16
    LSR  X24, X20, X8
    MOVK  X9, #0x17aa, LSL #48
    LSRV  W8, W12, W20
    LSR  X5, X29, #0x9
    MOVZ  X13, #0x2ddd, LSL #48
    LSLV  W7, W28, W20
    CRC32CX  W28, W17, X9
    CRC32CH  W2, W2, W20
    LSL  X16, X28, X2
    LSL  X4, X8, X5
    LSR  X20, X13, X19
    LSL  W10, W24, #9
    MOVK  W28, #0xb1f3, LSL #0
    MOVN  W29, #0x5c3f, LSL #0
    LSLV  W4, W16, W21
    LSR  W12, W10, W7
    CRC32CB  W8, W12, W20
    MOV  X24, X28
    MOVN  X10, #0x54d6, LSL #16
    MOVN  W28, #0x7602, LSL #0
    LSL  W7, W28, W29
    MOVN  W9, #0x3890, LSL #16
    LSRV  X17, X16, X4
    LSL  X2, X8, #18
    MOVN  W16, #0x9a14, LSL #16
    CRC32X  W21, W24, X16
    MOVK  X20, #0xc643, LSL #0
    MOVZ  X2, #0x7694, LSL #48
    LSLV  X19, X2, X2
    CRC32X  W12, W17, X21
    CRC32B  W16, W7, W12
    LSR  W24, W20, W9
    MOVZ  X28, #0xf9b7, LSL #32
    MOVN  W2, #0xe5c1, LSL #16
    CRC32CH  W4, W4, W2
    MOV  W17, W10
    MOVN  W20, #0x6e5d, LSL #0
    MOVN  W13, #0xe7fc, LSL #0
    MOV  X5, X13
    CRC32CH  W7, W20, W19
    CRC32B  W10, W8, W5
    MOV  X20, X19
    MOVZ  W13, #0x9d38, LSL #16
    LSR  W5, W28, W24
    MOVZ  X21, #0xdd38, LSL #48
    MOV  W29, W10
    LSL  W2, W13, #6
    MOV  X13, X4
    LSR  W8, W17, W20
    LSR  X19, X7, #0x3
    LSLV  X24, X29, X5
    LSLV  W4, W2, W8
    LSL  X20, X4, X21
    LSL  X4, X16, #49
    CRC32CH  W12, W20, W4
    MOVZ  X8, #0x3939, LSL #0
    CRC32CH  W7, W24, W12
    LSLV  X5, X19, X13
    LSL  W24, W7, W7
    LSR  W20, W8, W5
    CRC32CH  W17, W24, W20
    CRC32CX  W21, W27, X24
    CRC32CW  W19, W13, W20
    LSL  X4, X27, X7
    CRC32B  W10, W9, W7
    CRC32CW  W13, W2, W2
    CRC32X  W16, W24, X25
    LSL  W20, W7, W10
    MOV  X28, X25
    MOVK  W8, #0x4df0, LSL #16
    CRC32W  W7, W20, W20
    MOV  X24, X13
    MOV  W10, W4
    CRC32CB  W29, W21, W24
    MOVZ  W29, #0xbcdd, LSL #16
    CRC32CH  W5, W15, W19
    MOV  W24, W16
    MOV  X17, X5
    LSL  X21, X27, #49
    LSL  W12, W7, W29
    LSLV  W20, W24, W21
    MOVZ  W7, #0xe23f, LSL #16
    LSL  W9, W7, #26
    LSR  W25, W28, W28
    LSL  W7, W8, #2
    LSRV  X21, X17, X20
    CRC32B  W2, W21, W9
    CRC32B  W4, W2, W10
    LSR  X5, X25, X7
    CRC32CX  W23, W5, X4
    CRC32W  W13, W23, W23
    MOV  W5, W13
    LSRV  W20, W5, W12
    CRC32CB  W15, W10, W7
    LSR  W28, W15, W29
    CRC32W  W19, W10, W16
    MOVZ  X23, #0x491c, LSL #32
    CRC32X  W25, W13, X2
    LSL  X16, X2, X20
    MOV  X5, X17
    MOVK  X13, #0x30a7, LSL #48
    LSRV  W21, W12, W23
    LSL  W7, W21, W16
    MOVK  X17, #0x4510, LSL #16
    CRC32CX  W21, W13, X24
    LSRV  W4, W16, W21
    LSL  X20, X10, X21
    MOV  X29, X8
    MOV  W8, W29
    LSR  W16, W17, #0x1c
    MOVZ  W13, #0x454f, LSL #16
    MOV  X17, X7
    LSL  W10, W28, W20
    MOVN  X24, #0xb7b, LSL #16
    MOVZ  X29, #0x3c86, LSL #48
    LSLV  W2, W4, W16
    CRC32H  W21, W19, W17
    LSL  X20, X2, #32
    CRC32CX  W2, W20, X29
    LSL  X7, X24, X2
    MOV  X20, X8
    CRC32CB  W15, W5, W13
    CRC32CH  W4, W25, W10
    MOV  X29, X21
    LSRV  X17, X7, X7
    LSL  X25, X4, #55
    LSR  X13, X25, X25
    LSL  X28, X20, #24
    LSL  W16, W28, W15
    MOVN  W28, #0xea98, LSL #0
    LSRV  X5, X28, X28
    MOVK  W8, #0x439f, LSL #0
    MOVN  X24, #0x7266, LSL #16
    LSLV  X28, X24, X24
    MOVK  W15, #0x7ac3, LSL #0
    CRC32X  W19, W8, X16
    CRC32X  W3, W5, X19
    LSR  X25, X29, X28
    MOV  W4, W17
    LSR  X21, X25, X13
    CRC32X  W17, W15, X21
    MOVZ  W16, #0xee04, LSL #0
    CRC32B  W8, W3, W16
    CRC32CB  W10, W8, W4
    MOV  X2, X17
    CRC32CH  W4, W10, W10
    MOVZ  W29, #0x4694, LSL #0
    CRC32B  W19, W2, W2
    CRC32B  W5, W29, W19
    LSLV  X7, X5, X24
    LSL  W24, W4, W4
    LSRV  X19, X24, X24
    LSL  X2, X25, X19
    MOV  X3, X12
    LSLV  X10, X7, X2
    MOVZ  W20, #0x75f4, LSL #16
    CRC32CB  W29, W3, W3
    MOV  W5, W10
    CRC32CX  W16, W5, X29
    LSR  X15, X9, X20
    LSRV  X4, X16, X15
    LSR  W9, W23, #0x10
    CRC32CW  W24, W24, W12
    MOVK  W3, #0x62e3, LSL #16
    LSLV  W17, W27, W28
    LSL  W21, W2, W29
    CRC32H  W16, W5, W16
    LSLV  W8, W8, W17
    LSR  X20, X23, #0x2
    LSR  W2, W24, W21
    SUBS  X27, X27, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_17
    MOVZ  X18, #0x1c, LSL #0
    SUB  X26, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x62e3, LSL #16
    SUB  X26, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x95d8, LSL #0
    MOVK  X18, #0xaa38, LSL #16
    SUB  X26, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x780, LSL #48
    SUB  X26, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x1, LSL #0
    SUB  X26, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0xa980, LSL #0
    MOVK  X18, #0x2b, LSL #16
    SUB  X26, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x1247, LSL #32
    SUB  X26, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0xab7a, LSL #0
    MOVK  X18, #0x45ed, LSL #16
    SUB  X26, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x491c, LSL #32
    SUB  X26, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x61f0, LSL #0
    MOVK  X18, #0x73ab, LSL #16
    SUB  X26, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0xab7a, LSL #0
    MOVK  X18, #0x45ed, LSL #16
    SUB  X26, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x8000, LSL #48
    SUB  X26, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X2, #0xef98, LSL #0
    MOVK  X2, #0x3815, LSL #16
    MOVK  X2, #0x5b2f, LSL #32
    MOVK  X2, #0x49f3, LSL #48
    MOVZ  X3, #0x17f3, LSL #0
    MOVK  X3, #0xae52, LSL #16
    MOVK  X3, #0x19d, LSL #32
    MOVK  X3, #0x20ba, LSL #48
    MOVZ  X4, #0xc4d0, LSL #0
    MOVK  X4, #0xf08a, LSL #16
    MOVK  X4, #0x458c, LSL #32
    MOVK  X4, #0xf5ea, LSL #48
    MOVZ  X5, #0xe1ca, LSL #0
    MOVK  X5, #0x421f, LSL #16
    MOVK  X5, #0x519e, LSL #32
    MOVK  X5, #0xb743, LSL #48
    MOVZ  X7, #0x8782, LSL #0
    MOVK  X7, #0x5ce2, LSL #16
    MOVK  X7, #0x3164, LSL #32
    MOVK  X7, #0x2502, LSL #48
    MOVZ  X8, #0x891e, LSL #0
    MOVK  X8, #0x1443, LSL #16
    MOVK  X8, #0xa247, LSL #32
    MOVK  X8, #0xdf82, LSL #48
    MOVZ  X9, #0x938e, LSL #0
    MOVK  X9, #0x4594, LSL #16
    MOVK  X9, #0x26e8, LSL #32
    MOVK  X9, #0x9317, LSL #48
    MOVZ  X10, #0x47ab, LSL #0
    MOVK  X10, #0xa5bc, LSL #16
    MOVK  X10, #0x424c, LSL #32
    MOVK  X10, #0xa355, LSL #48
    MOVZ  X12, #0xa023, LSL #0
    MOVK  X12, #0x392a, LSL #16
    MOVK  X12, #0x4279, LSL #32
    MOVK  X12, #0xea, LSL #48
    MOVZ  X13, #0x50a7, LSL #0
    MOVK  X13, #0xf7b3, LSL #16
    MOVK  X13, #0xe389, LSL #32
    MOVK  X13, #0x16ea, LSL #48
    MOVZ  X15, #0x1c6, LSL #0
    MOVK  X15, #0x8310, LSL #16
    MOVK  X15, #0x43e4, LSL #32
    MOVK  X15, #0x664e, LSL #48
    MOVZ  X16, #0x4867, LSL #0
    MOVK  X16, #0x2b8d, LSL #16
    MOVK  X16, #0x477e, LSL #32
    MOVK  X16, #0xa6d8, LSL #48
    MOVZ  X17, #0xb555, LSL #0
    MOVK  X17, #0xacaf, LSL #16
    MOVK  X17, #0xcee9, LSL #32
    MOVK  X17, #0x77f, LSL #48
    MOVZ  X18, #0x60d7, LSL #0
    MOVK  X18, #0xe2f7, LSL #16
    MOVK  X18, #0x785e, LSL #32
    MOVK  X18, #0x2f2b, LSL #48
    MOVZ  X19, #0x8cc6, LSL #0
    MOVK  X19, #0x55b1, LSL #16
    MOVK  X19, #0x16dc, LSL #32
    MOVK  X19, #0x8e28, LSL #48
    MOVZ  X20, #0x875d, LSL #0
    MOVK  X20, #0x7578, LSL #16
    MOVK  X20, #0x575c, LSL #32
    MOVK  X20, #0xb703, LSL #48
    MOVZ  X21, #0x3d88, LSL #0
    MOVK  X21, #0x6a18, LSL #16
    MOVK  X21, #0x4748, LSL #32
    MOVK  X21, #0x5287, LSL #48
    MOVZ  X23, #0xf273, LSL #0
    MOVK  X23, #0x5991, LSL #16
    MOVK  X23, #0x18a4, LSL #32
    MOVK  X23, #0x2f28, LSL #48
    MOVZ  X24, #0xf7f4, LSL #0
    MOVK  X24, #0xf42c, LSL #16
    MOVK  X24, #0x6e21, LSL #32
    MOVK  X24, #0x7936, LSL #48
    MOVZ  X25, #0x7c3c, LSL #0
    MOVK  X25, #0xd85e, LSL #16
    MOVK  X25, #0x67b2, LSL #32
    MOVK  X25, #0xae70, LSL #48
    MOVZ  X26, #0xf2bd, LSL #0
    MOVK  X26, #0x432f, LSL #16
    MOVK  X26, #0x7a02, LSL #32
    MOVK  X26, #0x2e2d, LSL #48
    MOVZ  X27, #0xbd60, LSL #0
    MOVK  X27, #0xab32, LSL #16
    MOVK  X27, #0xcd17, LSL #32
    MOVK  X27, #0xe548, LSL #48
    MOVZ  X28, #0x67e1, LSL #0
    MOVK  X28, #0x2190, LSL #16
    MOVK  X28, #0x5306, LSL #32
    MOVK  X28, #0xda0c, LSL #48
    MOVZ  X29, #0xa993, LSL #0
    MOVK  X29, #0xf933, LSL #16
    MOVK  X29, #0x174f, LSL #32
    MOVK  X29, #0x5704, LSL #48
    MOVZ  X10, #0xf, LSL #0
TSRTIntCRCAndShiftAndMov_label_18:
    CRC32CX  W17, W29, X10
    CRC32X  W21, W28, X17
    MOVN  X29, #0xe0d4, LSL #32
    MOVZ  W17, #0x1c52, LSL #16
    CRC32CX  W2, W27, X27
    LSLV  X12, X21, X21
    LSL  W8, W26, W26
    MOV  W23, W17
    CRC32H  W17, W23, W8
    MOV  W16, W2
    CRC32CW  W7, W17, W12
    LSR  X20, X29, #0x10
    LSL  X23, X20, X7
    MOVK  X18, #0x76bb, LSL #32
    CRC32H  W21, W18, W23
    MOVN  X24, #0xa9b4, LSL #16
    CRC32X  W19, W16, X16
    CRC32CW  W16, W24, W21
    CRC32CW  W29, W19, W19
    MOVZ  W23, #0x6b48, LSL #0
    LSR  X17, X16, X23
    LSL  X20, X24, X29
    LSR  W26, W17, W20
    CRC32W  W24, W8, W21
    LSRV  X12, X26, X27
    CRC32CH  W8, W8, W28
    MOV  X2, X8
    CRC32CW  W16, W19, W27
    LSLV  X19, X17, X23
    LSR  W29, W20, #0x1
    LSR  W7, W10, W21
    MOV  X20, X29
    MOVN  X8, #0x223e, LSL #0
    CRC32B  W2, W10, W8
    LSR  X28, X12, #0x37
    LSRV  W17, W13, W2
    CRC32W  W8, W20, W13
    LSR  X23, X15, #0x0
    LSRV  W2, W5, W29
    CRC32CX  W29, W28, X24
    LSR  X26, X2, #0x1
    MOV  W2, W7
    LSL  W24, W17, #27
    CRC32X  W28, W29, X16
    MOVK  W7, #0xa80, LSL #16
    LSR  X7, X7, X23
    MOVZ  W27, #0xb96d, LSL #16
    MOV  W13, W19
    MOV  X12, X8
    LSL  X17, X12, X12
    MOV  X15, X7
    LSLV  W12, W15, W13
    LSR  X23, X26, #0x2f
    MOVZ  X7, #0xa5e1, LSL #32
    MOV  W5, W2
    CRC32W  W20, W28, W28
    LSL  W28, W12, W27
    CRC32CH  W2, W17, W28
    CRC32B  W28, W24, W5
    LSR  X26, X7, #0x3e
    CRC32H  W5, W26, W28
    LSL  W28, W8, #25
    CRC32X  W15, W2, X23
    LSR  W2, W20, #0x1a
    MOV  X26, X2
    MOV  W20, W26
    LSRV  X13, X20, X20
    LSLV  W20, W21, W13
    CRC32W  W7, W28, W5
    MOV  W24, W20
    MOVZ  X20, #0xf4ae, LSL #0
    MOV  W2, W20
    LSR  X5, X2, #0x3
    MOVN  X19, #0x53e, LSL #0
    CRC32B  W20, W5, W15
    CRC32CB  W27, W7, W24
    LSR  W8, W27, W20
    CRC32X  W23, W19, X19
    LSRV  X27, X8, X8
    LSR  W13, W23, W23
    CRC32CX  W2, W27, X2
    LSR  W8, W2, #0x8
    LSRV  W23, W8, W13
    MOV  W20, W15
    LSL  X13, X17, #21
    LSL  X19, X16, #35
    MOV  W12, W12
    MOVZ  X27, #0x8398, LSL #0
    LSRV  X16, X15, X7
    LSR  W5, W28, #0x6
    MOV  W8, W2
    LSR  X7, X8, #0x3a
    LSR  X26, X12, X23
    LSR  X24, X12, X26
    MOV  X17, X24
    LSR  W23, W17, W20
    LSR  W20, W23, W13
    LSR  X13, X4, X7
    LSLV  W24, W20, W27
    CRC32CB  W8, W19, W19
    LSL  X28, X13, #33
    CRC32CB  W7, W5, W5
    MOVN  X19, #0x8f14, LSL #0
    CRC32B  W13, W28, W16
    MOV  W13, W16
    MOVK  X27, #0xf139, LSL #16
    CRC32CH  W17, W24, W24
    LSR  W12, W8, #0x7
    LSR  X2, X17, #0x1
    MOVZ  X8, #0x4b50, LSL #48
    MOV  X5, X19
    LSR  X4, X8, #0x1c
    LSLV  X26, X4, X13
    MOVN  W16, #0x64d1, LSL #0
    MOVZ  X8, #0xa08a, LSL #48
    LSL  W24, W26, W5
    MOV  W20, W8
    CRC32CB  W19, W7, W7
    LSL  X13, X27, #39
    MOVZ  W4, #0xd74a, LSL #0
    MOVK  X17, #0x5486, LSL #48
    LSR  X28, X20, #0x27
    LSL  X23, X12, X12
    MOVN  W5, #0xa83c, LSL #16
    CRC32B  W27, W17, W10
    CRC32CW  W12, W4, W19
    MOV  W7, W27
    LSRV  W19, W23, W12
    LSL  W8, W2, #6
    LSRV  W12, W19, W18
    LSR  W19, W4, #0x1f
    MOVK  W27, #0xf6e1, LSL #0
    CRC32CB  W26, W28, W4
    LSR  X2, X27, #0xa
    MOV  X20, X26
    CRC32H  W18, W2, W24
    CRC32CX  W24, W5, X7
    LSLV  X26, X20, X24
    CRC32X  W17, W13, X13
    MOVK  W27, #0x6f90, LSL #16
    MOVK  X20, #0xd237, LSL #48
    CRC32CX  W19, W20, X17
    CRC32CW  W4, W18, W8
    MOV  W7, W26
    LSL  X2, X12, X12
    LSRV  X28, X7, X27
    LSL  X4, X13, #25
    MOVN  X27, #0x6df4, LSL #48
    MOVN  X5, #0xdc93, LSL #48
    MOV  X24, X2
    LSRV  W23, W8, W4
    MOV  X7, X5
    CRC32X  W20, W27, X28
    CRC32CH  W26, W20, W19
    MOV  X20, X24
    LSR  X28, X20, #0x37
    MOV  W28, W26
    CRC32B  W12, W7, W7
    LSR  W13, W23, W12
    LSLV  X12, X13, X28
    LSL  X13, X3, X5
    MOVN  X18, #0x2aac, LSL #0
    LSR  X17, X23, #0x2d
    CRC32CX  W20, W10, X2
    CRC32CW  W19, W8, W23
    MOVZ  X2, #0x3bf3, LSL #16
    LSR  W27, W18, W12
    CRC32CH  W18, W3, W3
    CRC32H  W26, W29, W17
    CRC32X  W24, W18, X21
    MOVZ  X3, #0xfc4d, LSL #32
    LSR  X4, X27, X12
    MOV  X28, X23
    MOVN  W17, #0xdb79, LSL #0
    LSR  W8, W19, #0x1c
    CRC32B  W5, W8, W3
    LSR  W29, W28, W5
    MOVK  W19, #0x3d2d, LSL #0
    LSR  W27, W2, #0xd
    LSL  X28, X13, X29
    CRC32CX  W21, W26, X28
    LSRV  X12, X19, X17
    LSLV  X23, X21, X24
    MOVZ  W23, #0x9f90, LSL #16
    LSLV  X24, X27, X12
    CRC32W  W18, W24, W4
    LSL  W29, W23, W18
    CRC32CW  W8, W29, W29
    CRC32CW  W23, W8, W8
    LSLV  X4, X23, X23
    CRC32W  W2, W4, W4
    LSR  W26, W2, #0x18
    MOVK  W3, #0x9be9, LSL #0
    LSR  W2, W3, #0x1b
    LSL  W4, W8, W2
    LSR  X8, X26, X26
    CRC32CB  W2, W4, W8
    MOVN  X23, #0x2382, LSL #16
    LSLV  W19, W21, W18
    LSR  W18, W2, W8
    SUBS  X10, X10, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_18
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0x9be9, LSL #0
    SUB  X9, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0x236c, LSL #48
    SUB  X9, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0xf4, LSL #0
    SUB  X9, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x8000, LSL #48
    SUB  X9, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0x9b2e, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X9, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0x2486, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X9, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0x6200, LSL #0
    MOVK  X25, #0x5f0b, LSL #16
    SUB  X9, X25, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0x7d27, LSL #0
    MOVK  X25, #0x493c, LSL #16
    SUB  X9, X25, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0xb62, LSL #0
    MOVK  X25, #0xfc5f, LSL #16
    SUB  X9, X25, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xdc7d, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X9, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xf980, LSL #48
    SUB  X9, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0xdf98, LSL #0
    MOVK  X25, #0x1, LSL #16
    SUB  X9, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x8000, LSL #48
    SUB  X9, X25, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x9000, LSL #16
    SUB  X9, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X26, #0xf, LSL #0
TSRTIntCRCAndShiftAndMov_label_19:
    MOVN  W24, #0xfa9a, LSL #16
    CRC32CB  W21, W27, W16
    LSR  W4, W25, W26
    MOV  X19, X28
    LSRV  W5, W29, W19
    CRC32X  W23, W23, X20
    MOVZ  W21, #0x3595, LSL #16
    LSR  W3, W23, W7
    MOVN  W24, #0xcb7b, LSL #0
    LSR  X2, X24, X24
    LSL  W4, W3, W3
    CRC32CH  W19, W4, W5
    LSR  W29, W19, W2
    MOV  X25, X12
    LSLV  X20, X29, X21
    MOVK  X21, #0x5eca, LSL #0
    LSLV  W24, W20, W25
    LSL  W16, W21, W24
    LSR  X27, X16, #0x1d
    CRC32X  W7, W27, X27
    CRC32CH  W20, W7, W7
    LSRV  X19, X12, X8
    LSRV  W21, W20, W29
    LSL  W24, W2, #6
    MOVN  X3, #0x63b5, LSL #16
    LSR  X5, X7, X3
    MOV  W23, W23
    MOV  X7, X15
    CRC32CH  W15, W25, W5
    LSL  W25, W24, W2
    LSR  W24, W3, #0x1e
    MOVZ  W4, #0x8370, LSL #0
    MOV  X27, X16
    LSR  X5, X27, #0x2b
    LSR  X2, X25, X5
    CRC32CB  W23, W19, W19
    MOVK  W12, #0xdd92, LSL #16
    CRC32X  W28, W4, X23
    MOVK  X23, #0xfa8a, LSL #48
    MOVN  W3, #0x47d9, LSL #16
    CRC32CX  W25, W21, X24
    MOV  W21, W7
    CRC32CX  W8, W21, X25
    CRC32H  W27, W15, W3
    CRC32X  W19, W25, X28
    LSR  W5, W8, #0x15
    MOVK  X25, #0x78fb, LSL #48
    CRC32CX  W29, W25, X2
    CRC32X  W7, W29, X19
    LSL  W3, W27, W7
    LSR  X16, X10, X12
    LSLV  W20, W5, W23
    CRC32H  W15, W20, W20
    CRC32X  W23, W15, X15
    CRC32CB  W5, W23, W3
    LSR  X8, X16, X5
    LSR  W28, W8, #0x11
    LSRV  W20, W19, W20
    MOV  W21, W28
    CRC32B  W25, W19, W8
    LSLV  W8, W20, W7
    MOVK  W16, #0x8f4b, LSL #16
    MOV  W7, W23
    LSLV  X20, X24, X23
    CRC32CX  W19, W2, X21
    MOVZ  W24, #0x5e8c, LSL #0
    MOVZ  W12, #0x1dff, LSL #16
    MOV  X23, X10
    LSL  W29, W24, W23
    LSR  W21, W20, #0xc
    LSRV  X5, X25, X16
    MOV  W3, W29
    CRC32B  W2, W19, W3
    LSL  W15, W2, W8
    MOV  X24, X21
    MOVN  W23, #0xc595, LSL #0
    MOVN  X20, #0x4700, LSL #32
    LSR  X3, X15, #0x2d
    LSL  X28, X5, X23
    MOVZ  X21, #0xe95a, LSL #0
    MOV  X23, X20
    MOVN  X15, #0x84a6, LSL #16
    MOVN  X19, #0x3111, LSL #48
    MOV  W20, W24
    MOVK  W16, #0x2b60, LSL #16
    MOVK  X5, #0x788, LSL #48
    MOV  W2, W5
    LSR  X5, X19, X20
    LSL  X25, X12, #42
    LSLV  X12, X16, X28
    LSL  X28, X23, #27
    LSRV  X20, X3, X7
    MOV  X24, X21
    LSR  X16, X2, X24
    MOVN  W10, #0x81d4, LSL #16
    MOV  W21, W15
    CRC32CB  W15, W15, W12
    MOV  X2, X2
    CRC32B  W7, W5, W10
    LSR  X10, X2, #0x2e
    LSR  X8, X25, X25
    CRC32CH  W19, W16, W20
    MOVN  W2, #0x575e, LSL #16
    CRC32H  W24, W10, W15
    MOVZ  X23, #0x96a7, LSL #16
    CRC32CH  W15, W24, W23
    LSR  W28, W21, W15
    LSR  X21, X28, X2
    CRC32CX  W10, W7, X21
    MOVK  X24, #0xfe6c, LSL #16
    MOVZ  W7, #0xff85, LSL #16
    MOV  X16, X29
    CRC32CH  W20, W8, W8
    MOV  W5, W19
    CRC32CW  W29, W5, W20
    MOVN  W20, #0x28b7, LSL #16
    MOVN  W5, #0xbd6, LSL #16
    LSRV  X8, X24, X16
    LSL  X2, X20, X8
    LSL  X3, X29, X10
    LSL  X19, X3, #44
    LSR  W3, W7, #0x18
    CRC32H  W7, W2, W3
    CRC32CX  W24, W5, X7
    LSR  X16, X19, X21
    LSR  X12, X24, #0x30
    CRC32CH  W21, W12, W12
    LSLV  W2, W21, W16
    LSR  X29, X13, X27
    CRC32CB  W24, W8, W15
    LSR  X15, X12, #0x26
    CRC32CW  W8, W25, W10
    MOV  W13, W12
    MOVK  W7, #0x47fd, LSL #0
    MOV  X12, X29
    CRC32W  W10, W26, W24
    LSL  W29, W20, #24
    LSLV  W19, W20, W4
    MOVZ  X20, #0xa4d5, LSL #48
    CRC32W  W4, W29, W2
    MOVK  W24, #0xeb01, LSL #0
    MOVZ  W27, #0x3318, LSL #0
    LSR  X21, X27, #0x2b
    LSL  W2, W10, W15
    CRC32CX  W16, W19, X2
    MOVK  W25, #0x3f57, LSL #16
    CRC32CB  W19, W16, W8
    LSR  W2, W19, W19
    MOV  W19, W13
    LSL  X27, X25, #63
    LSLV  X25, X7, X7
    MOV  W7, W25
    LSL  X25, X7, X12
    CRC32X  W16, W25, X16
    CRC32CX  W7, W16, X8
    CRC32CW  W15, W2, W7
    LSL  X29, X21, #46
    CRC32CX  W21, W2, X27
    LSL  X2, X24, #28
    MOVZ  W7, #0x45e7, LSL #16
    MOVN  X10, #0x83c9, LSL #32
    MOV  W13, W15
    LSR  X12, X21, X7
    MOVN  X7, #0xa1c3, LSL #48
    LSLV  X25, X19, X19
    MOV  W16, W12
    CRC32X  W28, W16, X29
    MOVN  W15, #0xcee6, LSL #16
    LSR  W8, W25, #0xc
    LSL  X27, X7, #53
    LSL  X7, X2, #4
    CRC32X  W16, W28, X28
    CRC32X  W29, W7, X13
    LSR  X19, X27, X15
    MOVN  W12, #0xefb3, LSL #16
    CRC32H  W25, W12, W16
    CRC32W  W24, W19, W19
    CRC32CX  W21, W8, X25
    CRC32CX  W20, W24, X29
    CRC32H  W15, W8, W10
    CRC32CH  W12, W20, W15
    MOV  W20, W21
    CRC32B  W21, W20, W12
    MOVN  W15, #0xc25, LSL #0
    MOVN  W2, #0xad7a, LSL #0
    MOVN  W24, #0x99f6, LSL #16
    LSRV  W12, W13, W8
    LSRV  W15, W8, W24
    LSRV  W27, W8, W10
    CRC32H  W25, W16, W27
    MOVN  W10, #0x966a, LSL #16
    CRC32B  W8, W19, W25
    MOVZ  W20, #0x7df0, LSL #16
    CRC32B  W29, W20, W16
    CRC32CH  W20, W4, W19
    CRC32W  W4, W3, W29
    MOV  X25, X2
    MOVK  X2, #0xdfda, LSL #32
    MOV  W3, W25
    CRC32CB  W27, W12, W9
    SUBS  X26, X26, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_19
    MOVZ  X17, #0x5285, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xdfda, LSL #32
    SUB  X18, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x5285, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x729a, LSL #0
    MOVK  X17, #0xf150, LSL #16
    SUB  X18, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xf429, LSL #16
    SUB  X18, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xeb01, LSL #32
    MOVK  X17, #0x4fb6, LSL #48
    SUB  X18, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x3096, LSL #0
    MOVK  X17, #0x7707, LSL #16
    SUB  X18, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0x6995, LSL #16
    SUB  X18, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x3349, LSL #0
    MOVK  X17, #0xeac4, LSL #16
    SUB  X18, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x3349, LSL #0
    MOVK  X17, #0xeac4, LSL #16
    SUB  X18, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x1, LSL #0
    SUB  X18, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0xe1a1, LSL #0
    MOVK  X17, #0x957e, LSL #16
    SUB  X18, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0xe75b, LSL #0
    MOVK  X17, #0xccf9, LSL #16
    SUB  X18, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x96a7, LSL #16
    SUB  X18, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0x6609, LSL #16
    SUB  X18, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x5285, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X18, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x243, LSL #0
    MOVK  X17, #0x3923, LSL #16
    SUB  X18, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x7d86, LSL #0
    MOVK  X17, #0xc954, LSL #16
    SUB  X18, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0xf000, LSL #0
    MOVK  X17, #0x7d, LSL #16
    SUB  X18, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
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
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
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
    MOVZ  X25, #0xf, LSL #0
TSRTIntCRCAndShiftAndMov_label_20:
    MOVN  W4, #0x83ef, LSL #0
    MOV  W8, W24
    MOVN  X27, #0x41fa, LSL #32
    LSL  X19, X28, X29
    LSL  W13, W27, W26
    CRC32H  W8, W12, W19
    CRC32B  W28, W13, W8
    LSRV  X2, X15, X28
    CRC32H  W27, W25, W2
    LSR  X13, X9, X27
    CRC32CH  W26, W13, W13
    LSR  X17, X4, X4
    LSR  W10, W17, #0x1
    LSLV  W2, W26, W10
    CRC32H  W19, W26, W23
    LSR  W10, W23, W29
    MOVZ  X15, #0xfb55, LSL #16
    LSR  X27, X4, #0x6
    MOV  W13, W13
    LSRV  W21, W10, W20
    MOVZ  X26, #0x8c40, LSL #16
    CRC32X  W23, W19, X8
    CRC32CW  W20, W4, W17
    MOVK  X10, #0x7360, LSL #16
    CRC32CB  W29, W10, W21
    MOV  W19, W20
    MOV  W4, W19
    CRC32X  W20, W29, X4
    MOVK  X12, #0xfba1, LSL #48
    LSR  W9, W12, W23
    LSL  X19, X27, #61
    CRC32CH  W12, W15, W2
    MOV  X27, X20
    MOV  W20, W26
    LSL  W21, W9, #14
    MOVZ  W10, #0xdf65, LSL #0
    CRC32W  W15, W10, W13
    LSR  W13, W20, #0x2
    LSR  W26, W27, #0x15
    LSR  X4, X16, #0x3b
    MOVN  W23, #0x314f, LSL #16
    LSRV  W17, W13, W12
    CRC32H  W2, W17, W17
    LSL  W27, W21, W15
    MOV  X13, X10
    CRC32CW  W21, W27, W2
    CRC32CW  W8, W21, W13
    CRC32CX  W20, W8, X26
    CRC32B  W9, W23, W28
    MOVN  X27, #0x89b3, LSL #0
    LSL  W23, W27, #21
    MOVZ  X13, #0x8ad5, LSL #48
    LSLV  W16, W20, W4
    MOV  X10, X16
    LSR  X16, X23, #0x6
    CRC32CB  W23, W13, W13
    CRC32W  W21, W10, W23
    MOVK  X29, #0x55f6, LSL #48
    CRC32H  W23, W29, W16
    LSRV  W28, W23, W23
    LSRV  W20, W9, W21
    MOVZ  W23, #0x3b65, LSL #16
    CRC32CW  W16, W20, W20
    LSL  W13, W21, W28
    MOVK  X10, #0xfd5a, LSL #48
    LSR  W20, W23, #0x12
    CRC32B  W9, W16, W20
    CRC32CB  W28, W10, W13
    MOVZ  X29, #0x95d4, LSL #0
    CRC32B  W27, W28, W9
    LSRV  W21, W27, W27
    MOVN  X15, #0x91cf, LSL #32
    LSLV  X4, X29, X29
    MOV  W10, W4
    MOVK  X23, #0x5b6c, LSL #0
    MOVK  X28, #0x5679, LSL #48
    MOVK  W4, #0x2bcb, LSL #16
    LSR  W29, W23, #0x15
    CRC32CX  W23, W21, X4
    MOVN  X13, #0xc6a9, LSL #32
    MOVZ  X27, #0x9188, LSL #32
    LSR  X4, X23, #0x11
    MOVK  W9, #0x9b29, LSL #16
    LSR  X21, X9, X29
    LSR  W16, W28, W13
    MOVZ  X20, #0xca33, LSL #0
    CRC32CW  W29, W16, W16
    MOV  X23, X4
    LSL  W9, W20, W29
    MOV  W29, W27
    CRC32W  W13, W15, W29
    MOVN  W28, #0x63a0, LSL #16
    LSL  X15, X21, #30
    MOVN  X21, #0x884c, LSL #48
    CRC32CX  W27, W23, X21
    MOVN  W23, #0x1caa, LSL #16
    MOVZ  W21, #0x26ec, LSL #0
    LSR  X16, X9, X27
    CRC32CB  W27, W13, W16
    LSR  X9, X28, X27
    MOVN  X27, #0x577b, LSL #32
    LSL  W16, W27, #5
    LSRV  X20, X10, X9
    MOVZ  W4, #0x672e, LSL #0
    CRC32CB  W27, W4, W23
    LSRV  W29, W15, W15
    LSL  W15, W29, #31
    MOVZ  X28, #0x354a, LSL #0
    MOV  W13, W20
    LSR  X10, X15, #0x3c
    CRC32CX  W23, W28, X16
    CRC32CH  W9, W13, W27
    LSR  X4, X10, X9
    LSR  X24, X23, X21
    LSL  W29, W4, #13
    LSR  X10, X24, X24
    MOVN  X8, #0x79e2, LSL #16
    LSRV  X20, X8, X8
    LSLV  X8, X29, X29
    MOVN  X28, #0xf275, LSL #16
    CRC32CB  W16, W10, W28
    MOV  W10, W16
    CRC32CW  W27, W20, W10
    LSR  X12, X24, #0xb
    LSL  X23, X8, #29
    LSLV  X15, X23, X27
    MOVK  W27, #0xe635, LSL #0
    MOVZ  X13, #0x24a2, LSL #16
    CRC32W  W9, W15, W12
    MOV  W15, W25
    CRC32X  W28, W15, X15
    LSRV  X16, X9, X24
    MOVZ  X10, #0x21bf, LSL #32
    CRC32CH  W7, W16, W28
    LSLV  W12, W27, W7
    LSLV  W8, W13, W12
    MOVN  W20, #0x66c8, LSL #0
    MOV  X24, X20
    LSL  X20, X21, #7
    LSR  X12, X8, X10
    LSL  W28, W24, #10
    LSL  W8, W16, #9
    CRC32H  W4, W8, W20
    MOV  W23, W4
    MOVN  X21, #0xf977, LSL #16
    LSLV  X4, X21, X19
    LSL  W10, W4, #27
    MOVZ  W27, #0xbbb7, LSL #16
    MOVK  W7, #0xc6e0, LSL #16
    CRC32CH  W21, W4, W16
    CRC32H  W15, W12, W21
    CRC32CW  W24, W10, W28
    MOVN  X8, #0x1a3c, LSL #16
    LSR  W19, W27, #0xb
    LSRV  X9, X23, X7
    LSL  W28, W15, W24
    LSRV  W10, W28, W9
    LSR  X20, X8, #0x27
    MOVN  X15, #0x1e66, LSL #32
    LSR  X28, X19, X10
    LSRV  X12, X28, X20
    LSL  X20, X12, #36
    MOVK  W9, #0x71e0, LSL #16
    MOVN  X16, #0xc3e, LSL #0
    CRC32CH  W21, W16, W15
    LSRV  W4, W20, W20
    CRC32CX  W15, W4, X21
    CRC32X  W27, W26, X9
    LSL  X28, X15, X27
    CRC32CX  W4, W10, X17
    CRC32H  W8, W19, W21
    LSL  X24, X8, X20
    LSL  X20, X17, X29
    MOV  X17, X26
    CRC32CB  W23, W26, W20
    CRC32W  W27, W28, W3
    CRC32CB  W15, W9, W12
    LSR  X8, X12, X8
    CRC32H  W29, W4, W2
    LSL  X16, X15, #40
    CRC32X  W15, W4, X7
    MOVN  W26, #0x284c, LSL #0
    LSL  W10, W8, W24
    MOV  X20, X15
    MOVK  W8, #0x2456, LSL #16
    MOV  W21, W16
    LSL  X8, X20, X26
    MOV  X15, X8
    CRC32H  W19, W10, W27
    CRC32CH  W2, W17, W29
    MOVK  W24, #0xc4fd, LSL #0
    CRC32W  W7, W2, W19
    MOVK  W4, #0xc3bc, LSL #16
    MOVZ  W26, #0xa86e, LSL #0
    LSLV  W27, W26, W23
    LSLV  X10, X4, X15
    MOV  X29, X10
    MOV  X26, X29
    LSR  W2, W21, #0x2
    MOVZ  X4, #0xd394, LSL #48
    SUBS  X25, X25, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_20
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X18, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xd394, LSL #48
    SUB  X18, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0xc189, LSL #0
    MOVK  X5, #0xf1b9, LSL #16
    SUB  X18, X5, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x41e0, LSL #48
    SUB  X18, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0xd409, LSL #0
    MOVK  X5, #0x71e0, LSL #16
    SUB  X18, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0x7a4d, LSL #0
    MOVK  X5, #0xc3bc, LSL #16
    SUB  X18, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x24a2, LSL #16
    SUB  X18, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x41e0, LSL #48
    SUB  X18, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x1800, LSL #32
    MOVK  X5, #0xc33b, LSL #48
    SUB  X18, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0x4bd, LSL #0
    SUB  X18, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0x80e7, LSL #0
    MOVK  X5, #0x4e3d, LSL #16
    SUB  X18, X5, X19
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0xe83c, LSL #0
    MOVK  X5, #0x5475, LSL #16
    SUB  X18, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0xa1be, LSL #0
    MOVK  X5, #0x97ba, LSL #16
    SUB  X18, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0xc4fd, LSL #0
    MOVK  X5, #0xefa7, LSL #16
    SUB  X18, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0x7a4d, LSL #0
    MOVK  X5, #0xc3bc, LSL #16
    SUB  X18, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x8000, LSL #16
    SUB  X18, X5, X27
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xd520, LSL #32
    MOVK  X5, #0x2fa5, LSL #48
    SUB  X18, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0x7a4d, LSL #0
    MOVK  X5, #0xc3bc, LSL #16
    SUB  X18, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTIntCRCAndShiftAndMov_TestFail

TSRTIntCRCAndShiftAndMov_TestEnd:
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
TSRTIntCRCAndShiftAndMov_TestFail:
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
