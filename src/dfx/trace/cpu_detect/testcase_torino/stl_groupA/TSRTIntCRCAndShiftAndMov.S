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
    MOVZ  X2, #0xefdc, LSL #0
    MOVK  X2, #0x80b1, LSL #16
    MOVK  X2, #0x87a2, LSL #32
    MOVK  X2, #0x7a73, LSL #48
    MOVZ  X3, #0x7658, LSL #0
    MOVK  X3, #0xf0d8, LSL #16
    MOVK  X3, #0x83ff, LSL #32
    MOVK  X3, #0x3e82, LSL #48
    MOVZ  X4, #0x27f, LSL #0
    MOVK  X4, #0x4cca, LSL #16
    MOVK  X4, #0x372f, LSL #32
    MOVK  X4, #0xd354, LSL #48
    MOVZ  X5, #0xeb15, LSL #0
    MOVK  X5, #0x5024, LSL #16
    MOVK  X5, #0xf535, LSL #32
    MOVK  X5, #0xc536, LSL #48
    MOVZ  X6, #0xdd05, LSL #0
    MOVK  X6, #0x84ce, LSL #16
    MOVK  X6, #0xe741, LSL #32
    MOVK  X6, #0x3017, LSL #48
    MOVZ  X7, #0xc2b8, LSL #0
    MOVK  X7, #0xecab, LSL #16
    MOVK  X7, #0xb740, LSL #32
    MOVK  X7, #0xb45e, LSL #48
    MOVZ  X8, #0xb94a, LSL #0
    MOVK  X8, #0xcc77, LSL #16
    MOVK  X8, #0x2cf3, LSL #32
    MOVK  X8, #0x5577, LSL #48
    MOVZ  X9, #0x298c, LSL #0
    MOVK  X9, #0xe404, LSL #16
    MOVK  X9, #0xec54, LSL #32
    MOVK  X9, #0xf929, LSL #48
    MOVZ  X10, #0x74c8, LSL #0
    MOVK  X10, #0x1393, LSL #16
    MOVK  X10, #0x9d8c, LSL #32
    MOVK  X10, #0x39e, LSL #48
    MOVZ  X11, #0x7385, LSL #0
    MOVK  X11, #0x8324, LSL #16
    MOVK  X11, #0xb939, LSL #32
    MOVK  X11, #0x818b, LSL #48
    MOVZ  X12, #0x14b9, LSL #0
    MOVK  X12, #0x55d5, LSL #16
    MOVK  X12, #0x3b16, LSL #32
    MOVK  X12, #0x5b85, LSL #48
    MOVZ  X13, #0x9242, LSL #0
    MOVK  X13, #0xbb3f, LSL #16
    MOVK  X13, #0x988a, LSL #32
    MOVK  X13, #0xed32, LSL #48
    MOVZ  X14, #0x95d9, LSL #0
    MOVK  X14, #0xf471, LSL #16
    MOVK  X14, #0xa065, LSL #32
    MOVK  X14, #0xb109, LSL #48
    MOVZ  X15, #0x5156, LSL #0
    MOVK  X15, #0x7d0a, LSL #16
    MOVK  X15, #0xa774, LSL #32
    MOVK  X15, #0xde12, LSL #48
    MOVZ  X16, #0x213f, LSL #0
    MOVK  X16, #0x6340, LSL #16
    MOVK  X16, #0x234c, LSL #32
    MOVK  X16, #0xd33c, LSL #48
    MOVZ  X17, #0x1f37, LSL #0
    MOVK  X17, #0x357d, LSL #16
    MOVK  X17, #0x6581, LSL #32
    MOVK  X17, #0x3e83, LSL #48
    MOVZ  X18, #0x4c24, LSL #0
    MOVK  X18, #0x4e45, LSL #16
    MOVK  X18, #0x7c3e, LSL #32
    MOVK  X18, #0x7ffd, LSL #48
    MOVZ  X19, #0xb862, LSL #0
    MOVK  X19, #0xb954, LSL #16
    MOVK  X19, #0xd2c8, LSL #32
    MOVK  X19, #0x1562, LSL #48
    MOVZ  X20, #0x38ad, LSL #0
    MOVK  X20, #0xb469, LSL #16
    MOVK  X20, #0x5c38, LSL #32
    MOVK  X20, #0xb676, LSL #48
    MOVZ  X21, #0x2ffb, LSL #0
    MOVK  X21, #0x16bb, LSL #16
    MOVK  X21, #0xb22a, LSL #32
    MOVK  X21, #0x76e8, LSL #48
    MOVZ  X22, #0xab48, LSL #0
    MOVK  X22, #0x5f41, LSL #16
    MOVK  X22, #0x3dda, LSL #32
    MOVK  X22, #0xa362, LSL #48
    MOVZ  X23, #0x9ed4, LSL #0
    MOVK  X23, #0xce46, LSL #16
    MOVK  X23, #0x6696, LSL #32
    MOVK  X23, #0x14b3, LSL #48
    MOVZ  X25, #0x2756, LSL #0
    MOVK  X25, #0x57f7, LSL #16
    MOVK  X25, #0x7937, LSL #32
    MOVK  X25, #0x9ed7, LSL #48
    ADDS  X22, X22, X20, ASR #35
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x6a09, LSL #0
    MOVK  X2, #0xbcbc, LSL #16
    MOVK  X2, #0xb81c, LSL #32
    MOVK  X2, #0x1a0f, LSL #48
    MOVZ  X3, #0xad71, LSL #0
    MOVK  X3, #0xe567, LSL #16
    MOVK  X3, #0x9b8, LSL #32
    MOVK  X3, #0x18a4, LSL #48
    MOVZ  X4, #0x781d, LSL #0
    MOVK  X4, #0xf8ef, LSL #16
    MOVK  X4, #0xb9e, LSL #32
    MOVK  X4, #0xd499, LSL #48
    MOVZ  X5, #0xb62a, LSL #0
    MOVK  X5, #0xdeb6, LSL #16
    MOVK  X5, #0x7f0e, LSL #32
    MOVK  X5, #0xffe0, LSL #48
    MOVZ  X6, #0xd1b5, LSL #0
    MOVK  X6, #0x117d, LSL #16
    MOVK  X6, #0xd813, LSL #32
    MOVK  X6, #0xe3e1, LSL #48
    MOVZ  X7, #0x88ea, LSL #0
    MOVK  X7, #0xc9bf, LSL #16
    MOVK  X7, #0x15f5, LSL #32
    MOVK  X7, #0xb478, LSL #48
    MOVZ  X8, #0x1fb, LSL #0
    MOVK  X8, #0x286, LSL #16
    MOVK  X8, #0xfad4, LSL #32
    MOVK  X8, #0x32fa, LSL #48
    MOVZ  X9, #0x27b9, LSL #0
    MOVK  X9, #0x1455, LSL #16
    MOVK  X9, #0x949c, LSL #32
    MOVK  X9, #0xb23a, LSL #48
    MOVZ  X10, #0x541f, LSL #0
    MOVK  X10, #0xe89, LSL #16
    MOVK  X10, #0x3517, LSL #32
    MOVK  X10, #0x6193, LSL #48
    MOVZ  X11, #0x517, LSL #0
    MOVK  X11, #0x5d85, LSL #16
    MOVK  X11, #0xaf1d, LSL #32
    MOVK  X11, #0x3e74, LSL #48
    MOVZ  X12, #0x11ff, LSL #0
    MOVK  X12, #0xedf2, LSL #16
    MOVK  X12, #0x2514, LSL #32
    MOVK  X12, #0x1216, LSL #48
    MOVZ  X13, #0x672f, LSL #0
    MOVK  X13, #0xd477, LSL #16
    MOVK  X13, #0x670e, LSL #32
    MOVK  X13, #0x938e, LSL #48
    MOVZ  X14, #0x3fea, LSL #0
    MOVK  X14, #0xd748, LSL #16
    MOVK  X14, #0x4ced, LSL #32
    MOVK  X14, #0xc946, LSL #48
    MOVZ  X15, #0x2d0e, LSL #0
    MOVK  X15, #0x9760, LSL #16
    MOVK  X15, #0x84c7, LSL #32
    MOVK  X15, #0x6bac, LSL #48
    MOVZ  X16, #0x44ae, LSL #0
    MOVK  X16, #0xfff0, LSL #16
    MOVK  X16, #0x8f8c, LSL #32
    MOVK  X16, #0xbad5, LSL #48
    MOVZ  X17, #0xdaf, LSL #0
    MOVK  X17, #0x995, LSL #16
    MOVK  X17, #0x7dec, LSL #32
    MOVK  X17, #0xc82c, LSL #48
    MOVZ  X18, #0x8e9f, LSL #0
    MOVK  X18, #0x8f49, LSL #16
    MOVK  X18, #0xda9b, LSL #32
    MOVK  X18, #0x2065, LSL #48
    MOVZ  X19, #0xfa52, LSL #0
    MOVK  X19, #0x5571, LSL #16
    MOVK  X19, #0xc2aa, LSL #32
    MOVK  X19, #0x672d, LSL #48
    MOVZ  X20, #0x6bff, LSL #0
    MOVK  X20, #0x5bca, LSL #16
    MOVK  X20, #0x32da, LSL #32
    MOVK  X20, #0xc2e3, LSL #48
    MOVZ  X21, #0x11f8, LSL #0
    MOVK  X21, #0x5c4f, LSL #16
    MOVK  X21, #0x9875, LSL #32
    MOVK  X21, #0xb462, LSL #48
    MOVZ  X22, #0xccd0, LSL #0
    MOVK  X22, #0x4045, LSL #16
    MOVK  X22, #0x6b70, LSL #32
    MOVK  X22, #0x3f76, LSL #48
    MOVZ  X23, #0x48a1, LSL #0
    MOVK  X23, #0x6b6, LSL #16
    MOVK  X23, #0x883a, LSL #32
    MOVK  X23, #0x6ebc, LSL #48
    MOVZ  X25, #0xde44, LSL #0
    MOVK  X25, #0x39a3, LSL #16
    MOVK  X25, #0x7b48, LSL #32
    MOVK  X25, #0x6887, LSL #48
    CRC32B  W7, W18, W21
    CRC32B  W25, W7, W25
    CRC32B  W7, W8, W10
    CRC32B  W23, W19, W14
    CRC32B  W16, W25, W20
    CRC32B  W16, W6, W23
    CRC32B  W4, W7, W7
    CRC32B  W7, W16, W16
    CRC32B  W6, W8, W7
    CRC32B  W5, W14, W17
    CRC32CB  W2, W14, W14
    CRC32CB  W21, W2, W4
    CRC32CB  W3, W6, W5
    CRC32CB  W12, W2, W11
    CRC32CB  W15, W18, W12
    CRC32CB  W14, W17, W15
    CRC32CB  W20, W3, W12
    CRC32CB  W5, W21, W4
    CRC32CB  W15, W6, W14
    CRC32CB  W6, W6, W15
    CRC32CH  W18, W6, W6
    CRC32CH  W14, W8, W18
    CRC32CH  W7, W20, W5
    CRC32CH  W4, W7, W21
    CRC32CH  W21, W12, W14
    CRC32CH  W11, W6, W10
    CRC32CH  W6, W5, W23
    CRC32CH  W10, W6, W15
    CRC32CH  W6, W10, W19
    CRC32CH  W19, W17, W8
    CRC32CW  W5, W14, W20
    CRC32CW  W20, W21, W5
    CRC32CW  W17, W8, W20
    CRC32CW  W5, W15, W9
    CRC32CW  W3, W5, W9
    CRC32CW  W2, W4, W21
    CRC32CW  W10, W25, W10
    CRC32CW  W4, W25, W23
    CRC32CW  W14, W4, W7
    CRC32CW  W21, W20, W3
    CRC32CX  W4, W7, X10
    CRC32CX  W8, W2, X23
    CRC32CX  W2, W8, X15
    CRC32CX  W9, W5, X10
    CRC32CX  W12, W6, X6
    CRC32CX  W25, W4, X17
    CRC32CX  W21, W21, X25
    CRC32CX  W14, W9, X2
    CRC32CX  W5, W3, X14
    CRC32CX  W23, W19, X16
    CRC32H  W25, W21, W21
    CRC32H  W18, W20, W3
    CRC32H  W21, W5, W12
    CRC32H  W12, W23, W9
    CRC32H  W16, W21, W5
    CRC32H  W19, W25, W16
    CRC32H  W9, W9, W14
    CRC32H  W15, W18, W12
    CRC32H  W8, W25, W4
    CRC32H  W14, W9, W19
    CRC32W  W25, W4, W7
    CRC32W  W4, W14, W16
    CRC32W  W7, W4, W8
    CRC32W  W17, W25, W25
    CRC32W  W25, W5, W14
    CRC32W  W23, W25, W7
    CRC32W  W21, W17, W7
    CRC32W  W16, W18, W21
    CRC32W  W18, W15, W7
    CRC32W  W25, W17, W2
    CRC32X  W14, W12, X4
    CRC32X  W12, W18, X16
    CRC32X  W9, W25, X20
    CRC32X  W2, W9, X17
    CRC32X  W8, W2, X14
    CRC32X  W6, W25, X8
    CRC32X  W5, W11, X12
    CRC32X  W12, W5, X5
    CRC32X  W11, W7, X14
    CRC32X  W2, W20, X4
    LSL  W7, W6, #18
    LSL  W14, W7, #22
    LSL  W21, W12, #18
    LSL  W20, W2, #17
    LSL  W2, W17, #10
    LSL  W17, W14, #11
    LSL  W12, W17, #9
    LSL  W25, W23, #28
    LSL  W23, W2, #27
    LSL  W14, W12, #29
    LSL  X4, X8, #9
    LSL  X16, X18, #11
    LSL  X21, X20, #51
    LSL  X18, X12, #24
    LSL  X12, X23, #34
    LSL  X6, X12, #7
    LSL  X17, X21, #41
    LSL  X15, X17, #42
    LSL  X20, X18, #44
    LSL  X21, X20, #47
    LSL  W18, W17, W21
    LSL  W25, W19, W18
    LSL  W2, W6, W11
    LSL  W23, W19, W6
    LSL  W3, W15, W14
    LSL  W18, W23, W18
    LSL  W20, W25, W16
    LSL  W6, W20, W3
    LSL  W11, W23, W4
    LSL  W12, W11, W16
    LSL  X19, X18, X6
    LSL  X3, X19, X3
    LSL  X14, X3, X19
    LSL  X25, X2, X9
    LSL  X3, X14, X25
    LSL  X14, X10, X6
    LSL  X19, X7, X12
    LSL  X25, X20, X25
    LSL  X18, X23, X21
    LSL  X16, X25, X14
    LSLV  W14, W10, W8
    LSLV  W16, W9, W15
    LSLV  W4, W16, W23
    LSLV  W8, W25, W3
    LSLV  W17, W6, W9
    LSLV  W16, W17, W17
    LSLV  W17, W10, W21
    LSLV  W6, W8, W15
    LSLV  W23, W3, W21
    LSLV  W5, W6, W8
    LSLV  X25, X4, X4
    LSLV  X8, X2, X4
    LSLV  X23, X14, X20
    LSLV  X17, X18, X5
    LSLV  X15, X19, X10
    LSLV  X18, X25, X8
    LSLV  X6, X16, X25
    LSLV  X8, X23, X18
    LSLV  X5, X17, X8
    LSLV  X14, X7, X15
    LSR  W7, W5, #0xc
    LSR  W16, W15, #0xb
    LSR  W2, W10, #0x2
    LSR  W16, W17, #0x0
    LSR  W9, W16, #0xd
    LSR  W10, W16, #0x3
    LSR  W12, W20, #0x18
    LSR  W15, W9, #0x1
    LSR  W4, W18, #0x16
    LSR  W9, W15, #0x5
    LSR  X20, X10, #0x38
    LSR  X15, X2, #0x18
    LSR  X16, X9, #0x2b
    LSR  X2, X6, #0x2e
    LSR  X5, X16, #0x2d
    LSR  X23, X23, #0x25
    LSR  X9, X6, #0x8
    LSR  X16, X7, #0x6
    LSR  X8, X8, #0x12
    LSR  X10, X20, #0x3c
    LSR  W12, W10, W2
    LSR  W25, W9, W12
    LSR  W20, W11, W6
    LSR  W6, W20, W4
    LSR  W20, W6, W25
    LSR  W2, W14, W2
    LSR  W11, W15, W11
    LSR  W15, W6, W6
    LSR  W14, W23, W23
    LSR  W21, W16, W11
    LSR  X10, X21, X21
    LSR  X23, X2, X8
    LSR  X21, X20, X20
    LSR  X11, X23, X15
    LSR  X15, X14, X10
    LSR  X18, X21, X11
    LSR  X4, X18, X3
    LSR  X3, X4, X15
    LSR  X14, X5, X7
    LSR  X10, X8, X2
    LSRV  W8, W23, W6
    LSRV  W10, W17, W4
    LSRV  W4, W12, W12
    LSRV  W5, W21, W20
    LSRV  W23, W16, W14
    LSRV  W12, W8, W5
    LSRV  W11, W25, W11
    LSRV  W2, W18, W12
    LSRV  W25, W12, W9
    LSRV  W20, W7, W11
    LSRV  X9, X11, X7
    LSRV  X10, X10, X7
    LSRV  X18, X18, X25
    LSRV  X2, X16, X5
    LSRV  X15, X4, X10
    LSRV  X7, X18, X10
    LSRV  X17, X7, X25
    LSRV  X21, X3, X23
    LSRV  X16, X17, X21
    LSRV  X21, X16, X12
    MOV  W12, W9
    MOV  W9, W2
    MOV  W4, W9
    MOV  W5, W16
    MOV  W25, W4
    MOV  W9, W5
    MOV  W8, W20
    MOV  W20, W21
    MOV  W21, W12
    MOV  W2, W15
    MOV  X18, X8
    MOV  X8, X25
    MOV  X17, X18
    MOV  X10, X2
    MOV  X23, X17
    MOV  X15, X14
    MOV  X14, X9
    MOV  X2, X14
    MOV  X12, X2
    MOV  X17, X12
    MOV  W6, W17
    MOV  W12, W15
    MOV  W16, W21
    MOV  W9, W16
    MOV  W2, W6
    MOV  W8, W23
    MOV  W3, W23
    MOV  W16, W9
    MOV  W14, W12
    MOV  W9, W8
    MOV  X20, X5
    MOV  X7, X9
    MOV  X18, X14
    MOV  X21, X20
    MOV  X14, X16
    MOV  X25, X7
    MOV  X7, X18
    MOV  X21, X21
    MOV  X15, X9
    MOV  X17, X14
    MOVN  W9, #0x291d, LSL #0
    MOVN  W4, #0xb8bf, LSL #0
    MOVN  W12, #0xb2b6, LSL #16
    MOVN  W10, #0xcbe2, LSL #16
    MOVN  W21, #0xb4c0, LSL #16
    MOVN  W5, #0x81d5, LSL #16
    MOVN  W14, #0x79c4, LSL #16
    MOVN  W18, #0x83b6, LSL #0
    MOVN  W16, #0x5654, LSL #0
    MOVN  W16, #0x7a06, LSL #0
    MOVN  X20, #0x10e, LSL #0
    MOVN  X17, #0x194e, LSL #48
    MOVN  X8, #0x12c3, LSL #32
    MOVN  X23, #0xd9f5, LSL #32
    MOVN  X18, #0xcf2e, LSL #48
    MOVN  X20, #0xd2cc, LSL #48
    MOVN  X10, #0xd1a1, LSL #16
    MOVN  X21, #0x34bf, LSL #48
    MOVN  X4, #0x6e54, LSL #48
    MOVN  X8, #0x5dac, LSL #32
    MOVZ  W17, #0xb8c2, LSL #16
    MOVZ  W23, #0xe3cd, LSL #16
    MOVZ  W6, #0xd0c9, LSL #16
    MOVZ  W15, #0x4438, LSL #0
    MOVZ  W2, #0x74d7, LSL #16
    MOVZ  W18, #0x308, LSL #0
    MOVZ  W10, #0xf78a, LSL #0
    MOVZ  W21, #0x2a84, LSL #16
    MOVZ  W8, #0xf0f9, LSL #16
    MOVZ  W18, #0x7134, LSL #0
    MOVZ  X3, #0xd6a2, LSL #0
    MOVZ  X9, #0xd7fb, LSL #16
    MOVZ  X16, #0x8f4f, LSL #0
    MOVZ  X19, #0xd68d, LSL #48
    MOVZ  X23, #0x9181, LSL #48
    MOVZ  X2, #0x8252, LSL #16
    MOVZ  X17, #0x56f3, LSL #0
    MOVZ  X8, #0x916, LSL #16
    MOVZ  X10, #0xe381, LSL #16
    MOVZ  X18, #0xc448, LSL #48
    MOVK  W9, #0x80a5, LSL #16
    MOVK  W8, #0xadb8, LSL #16
    MOVK  W12, #0x3dbe, LSL #16
    MOVK  W20, #0xd4cf, LSL #0
    MOVK  W17, #0xc0f2, LSL #16
    MOVK  W3, #0x8ae1, LSL #16
    MOVK  W6, #0xcbf9, LSL #0
    MOVK  W5, #0x7145, LSL #16
    MOVK  W18, #0x9b54, LSL #0
    MOVK  W16, #0x28fb, LSL #0
    MOVK  X4, #0x211f, LSL #48
    MOVK  X20, #0xa43d, LSL #16
    MOVK  X6, #0xcb1, LSL #16
    MOVK  X17, #0x41c4, LSL #16
    MOVK  X16, #0x445b, LSL #0
    MOVK  X19, #0xd8ed, LSL #48
    MOVK  X11, #0x6ea8, LSL #16
    MOVK  X16, #0x8873, LSL #16
    MOVK  X5, #0xfca, LSL #16
    MOVK  X2, #0xe4dc, LSL #16
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0xe4dc, LSL #16
    SUB  X13, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0xd6a2, LSL #0
    MOVK  X22, #0x8ae1, LSL #16
    SUB  X13, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0x211f, LSL #48
    SUB  X13, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xfca, LSL #16
    SUB  X13, X22, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0xcbf9, LSL #0
    MOVK  X22, #0xcb1, LSL #16
    SUB  X13, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X13, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0xadb8, LSL #16
    SUB  X13, X22, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x80a5, LSL #16
    SUB  X13, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0xe381, LSL #16
    SUB  X13, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0x4000, LSL #0
    MOVK  X22, #0x6ea8, LSL #16
    SUB  X13, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0x3dbe, LSL #16
    SUB  X13, X22, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0x863b, LSL #16
    SUB  X13, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0x4438, LSL #0
    SUB  X13, X22, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0x445b, LSL #0
    MOVK  X22, #0x8873, LSL #16
    SUB  X13, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0x56f3, LSL #0
    MOVK  X22, #0x41c4, LSL #16
    SUB  X13, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0x9b54, LSL #0
    SUB  X13, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0xd8ed, LSL #48
    SUB  X13, X22, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0xd4cf, LSL #0
    MOVK  X22, #0xa43d, LSL #16
    SUB  X13, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x2a84, LSL #16
    SUB  X13, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x9181, LSL #48
    SUB  X13, X22, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X13, X22, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X2, #0xcdc2, LSL #0
    MOVK  X2, #0xd32f, LSL #16
    MOVK  X2, #0x6ae1, LSL #32
    MOVK  X2, #0x412f, LSL #48
    MOVZ  X3, #0x5487, LSL #0
    MOVK  X3, #0xa08d, LSL #16
    MOVK  X3, #0xffcc, LSL #32
    MOVK  X3, #0xeab0, LSL #48
    MOVZ  X4, #0x8ef0, LSL #0
    MOVK  X4, #0x92e4, LSL #16
    MOVK  X4, #0x2cb0, LSL #32
    MOVK  X4, #0xd9fb, LSL #48
    MOVZ  X5, #0x3a3d, LSL #0
    MOVK  X5, #0x9709, LSL #16
    MOVK  X5, #0x7535, LSL #32
    MOVK  X5, #0xe8cc, LSL #48
    MOVZ  X6, #0x6b59, LSL #0
    MOVK  X6, #0x513c, LSL #16
    MOVK  X6, #0x9fd2, LSL #32
    MOVK  X6, #0x50c0, LSL #48
    MOVZ  X7, #0x6c8b, LSL #0
    MOVK  X7, #0xaa45, LSL #16
    MOVK  X7, #0xff39, LSL #32
    MOVK  X7, #0xa338, LSL #48
    MOVZ  X8, #0x1cd5, LSL #0
    MOVK  X8, #0x96b0, LSL #16
    MOVK  X8, #0x499, LSL #32
    MOVK  X8, #0xa84b, LSL #48
    MOVZ  X9, #0xc515, LSL #0
    MOVK  X9, #0xb79d, LSL #16
    MOVK  X9, #0x4d58, LSL #32
    MOVK  X9, #0x57ce, LSL #48
    MOVZ  X10, #0xf961, LSL #0
    MOVK  X10, #0x1639, LSL #16
    MOVK  X10, #0x23c5, LSL #32
    MOVK  X10, #0x907, LSL #48
    MOVZ  X11, #0xc53, LSL #0
    MOVK  X11, #0x613b, LSL #16
    MOVK  X11, #0xe03e, LSL #32
    MOVK  X11, #0x2953, LSL #48
    MOVZ  X12, #0x59c6, LSL #0
    MOVK  X12, #0xa3f1, LSL #16
    MOVK  X12, #0xa0d, LSL #32
    MOVK  X12, #0xba8b, LSL #48
    MOVZ  X13, #0x7c67, LSL #0
    MOVK  X13, #0x4611, LSL #16
    MOVK  X13, #0xebad, LSL #32
    MOVK  X13, #0x763, LSL #48
    MOVZ  X14, #0x4ea8, LSL #0
    MOVK  X14, #0xca33, LSL #16
    MOVK  X14, #0xdae3, LSL #32
    MOVK  X14, #0xf368, LSL #48
    MOVZ  X15, #0x60db, LSL #0
    MOVK  X15, #0x305f, LSL #16
    MOVK  X15, #0xd262, LSL #32
    MOVK  X15, #0xf68f, LSL #48
    MOVZ  X16, #0xe267, LSL #0
    MOVK  X16, #0x1c63, LSL #16
    MOVK  X16, #0x26e5, LSL #32
    MOVK  X16, #0x9a8, LSL #48
    MOVZ  X17, #0x7154, LSL #0
    MOVK  X17, #0xaee5, LSL #16
    MOVK  X17, #0xf8d, LSL #32
    MOVK  X17, #0x5ba5, LSL #48
    MOVZ  X18, #0xd9a3, LSL #0
    MOVK  X18, #0x1e68, LSL #16
    MOVK  X18, #0xd81f, LSL #32
    MOVK  X18, #0x7cc8, LSL #48
    MOVZ  X19, #0x6630, LSL #0
    MOVK  X19, #0xaf3c, LSL #16
    MOVK  X19, #0xc1de, LSL #32
    MOVK  X19, #0xa606, LSL #48
    MOVZ  X20, #0x9933, LSL #0
    MOVK  X20, #0x9ede, LSL #16
    MOVK  X20, #0x63ab, LSL #32
    MOVK  X20, #0x2fe1, LSL #48
    MOVZ  X21, #0xa8dc, LSL #0
    MOVK  X21, #0xab9e, LSL #16
    MOVK  X21, #0xe4db, LSL #32
    MOVK  X21, #0xe08f, LSL #48
    MOVZ  X22, #0xa132, LSL #0
    MOVK  X22, #0xc64a, LSL #16
    MOVK  X22, #0xa0cf, LSL #32
    MOVK  X22, #0x4afa, LSL #48
    MOVZ  X23, #0xfa0b, LSL #0
    MOVK  X23, #0x1219, LSL #16
    MOVK  X23, #0xdca0, LSL #32
    MOVK  X23, #0x952b, LSL #48
    MOVZ  X25, #0x4457, LSL #0
    MOVK  X25, #0x1dd1, LSL #16
    MOVK  X25, #0x8e52, LSL #32
    MOVK  X25, #0xe377, LSL #48
    MOVZ  X19, #0xa, LSL #0
TSRTIntCRCAndShiftAndMov_label_0:
    MOVK  X23, #0x7175, LSL #16
    MOV  X11, X21
    MOVK  X11, #0xf66d, LSL #16
    CRC32B  W20, W19, W25
    CRC32W  W2, W22, W17
    MOVK  W9, #0x7fef, LSL #16
    CRC32CB  W5, W15, W2
    LSL  W9, W5, #29
    LSL  W5, W22, W23
    CRC32B  W10, W20, W20
    LSLV  W12, W5, W9
    CRC32H  W8, W9, W12
    LSLV  X15, X21, X25
    CRC32W  W23, W10, W10
    LSLV  X13, X12, X15
    MOV  X14, X8
    LSR  W15, W12, W14
    MOV  X2, X13
    MOVZ  X8, #0x1509, LSL #0
    MOVN  W21, #0x5f11, LSL #0
    LSL  X20, X11, #28
    CRC32W  W17, W20, W8
    LSRV  X2, X7, X23
    MOV  X17, X2
    LSLV  X20, X10, X21
    CRC32CW  W25, W15, W18
    LSRV  X21, X5, X20
    LSL  W5, W8, W21
    MOV  X20, X25
    MOVZ  X22, #0x76ca, LSL #48
    LSL  W10, W15, #11
    MOVK  X15, #0xbd07, LSL #32
    LSR  W2, W8, W17
    LSL  W18, W8, W5
    LSRV  W21, W22, W2
    CRC32H  W9, W13, W17
    CRC32CX  W11, W4, X10
    LSR  X4, X18, #0xc
    LSLV  W22, W15, W9
    LSR  W25, W4, W21
    LSRV  W2, W11, W25
    MOV  X15, X12
    MOV  X7, X4
    LSL  X22, X2, X18
    MOVK  X17, #0xf565, LSL #16
    CRC32CH  W12, W22, W17
    CRC32CH  W4, W20, W20
    LSL  W13, W23, W4
    MOVK  W5, #0x671c, LSL #0
    LSR  W10, W9, #0x1e
    MOV  W9, W13
    MOVZ  W22, #0xe349, LSL #16
    MOVK  X7, #0x35a1, LSL #48
    MOV  X20, X22
    MOV  X22, X10
    MOV  X11, X22
    LSLV  X17, X12, X15
    CRC32B  W25, W9, W17
    CRC32CB  W17, W16, W12
    LSL  X9, X20, #28
    LSR  W13, W17, #0x5
    MOV  X22, X21
    LSRV  W4, W7, W10
    MOVZ  W12, #0xb313, LSL #0
    CRC32W  W17, W4, W4
    LSR  X5, X13, X25
    CRC32CH  W13, W5, W20
    LSR  W21, W22, W12
    LSR  W5, W9, #0x9
    CRC32CH  W18, W5, W11
    LSL  W9, W21, W9
    CRC32X  W5, W18, X4
    CRC32CB  W16, W15, W17
    LSL  X4, X4, #9
    LSR  X17, X4, #0xd
    MOVZ  X10, #0x4b39, LSL #32
    LSRV  X7, X9, X17
    LSL  X11, X7, #12
    CRC32X  W4, W22, X13
    LSLV  X14, X11, X5
    LSR  X13, X10, #0x1a
    CRC32B  W17, W4, W15
    MOVK  W25, #0x56c1, LSL #16
    LSL  W16, W17, #31
    CRC32W  W7, W21, W16
    LSR  W7, W7, W15
    CRC32CH  W18, W14, W7
    MOV  X16, X8
    CRC32B  W22, W23, W18
    LSRV  W11, W16, W8
    CRC32B  W15, W2, W8
    MOV  X5, X11
    LSL  W9, W15, #28
    LSLV  W8, W25, W5
    LSR  W4, W15, W18
    LSR  W21, W13, W9
    CRC32B  W25, W4, W10
    LSLV  X7, X18, X8
    MOV  W8, W7
    LSL  W13, W13, W19
    LSRV  W2, W21, W8
    LSL  W11, W17, W18
    CRC32CB  W7, W11, W7
    CRC32W  W20, W13, W22
    MOVN  X14, #0xfb54, LSL #48
    LSL  W16, W20, W22
    CRC32CB  W22, W7, W16
    LSLV  X20, X10, X22
    MOVN  X17, #0xb68d, LSL #16
    CRC32H  W13, W17, W25
    MOV  W7, W16
    CRC32X  W4, W20, X7
    LSRV  X8, X8, X17
    LSLV  X18, X8, X11
    LSRV  X5, X7, X13
    CRC32B  W7, W14, W18
    CRC32CH  W16, W2, W18
    LSLV  W14, W10, W7
    CRC32CW  W8, W4, W13
    MOVN  W17, #0xeb60, LSL #16
    LSRV  W4, W14, W14
    LSR  W7, W22, #0x7
    MOVK  X25, #0x2fe9, LSL #48
    LSL  X21, X16, X23
    CRC32CH  W21, W7, W2
    MOVZ  X18, #0x9b9e, LSL #0
    CRC32CX  W22, W8, X18
    LSRV  W22, W17, W21
    CRC32CH  W18, W5, W22
    MOV  W13, W4
    LSR  W16, W25, #0xd
    LSLV  W25, W7, W20
    LSR  X17, X16, #0x36
    CRC32W  W16, W11, W25
    LSR  W14, W18, W18
    MOV  W21, W16
    CRC32CW  W2, W13, W14
    LSL  W8, W21, #22
    LSR  X4, X23, #0x1d
    MOV  W25, W12
    LSR  W14, W17, #0x2
    LSR  W11, W23, W25
    MOVK  W5, #0xc5ea, LSL #0
    CRC32B  W17, W9, W13
    CRC32X  W13, W11, X14
    MOVN  X10, #0x4402, LSL #48
    LSR  X16, X17, #0x2c
    MOVK  X17, #0x2b16, LSL #16
    CRC32H  W13, W10, W5
    CRC32W  W9, W17, W17
    LSR  X7, X2, #0xb
    LSLV  W22, W13, W2
    CRC32X  W12, W2, X16
    LSLV  W5, W12, W12
    LSLV  W25, W7, W5
    CRC32CW  W21, W14, W25
    LSL  X2, X4, #50
    MOVN  W25, #0xc36b, LSL #0
    MOVK  W11, #0xe6dd, LSL #16
    CRC32CX  W2, W21, X9
    LSLV  W18, W25, W12
    MOVK  W7, #0xa572, LSL #0
    CRC32W  W13, W7, W11
    MOVN  X5, #0xefe1, LSL #16
    MOV  W11, W13
    MOV  W7, W2
    CRC32W  W25, W5, W23
    MOVN  W4, #0xb5f9, LSL #16
    LSR  W14, W25, #0x11
    LSLV  X10, X11, X18
    LSLV  X11, X7, X13
    CRC32X  W5, W19, X10
    CRC32B  W25, W18, W20
    MOVN  W12, #0xd5b8, LSL #0
    MOVN  X21, #0xb7c, LSL #48
    MOVK  W9, #0x427c, LSL #16
    CRC32CH  W2, W4, W12
    CRC32CB  W23, W8, W12
    CRC32H  W14, W21, W21
    LSRV  X4, X5, X14
    LSR  X12, X5, X4
    LSLV  X14, X11, X11
    LSL  W25, W4, W25
    LSLV  W12, W12, W4
    CRC32CX  W7, W14, X21
    LSR  W4, W7, #0x12
    MOV  W13, W4
    LSRV  X5, X2, X12
    LSL  X14, X19, #53
    MOV  W4, W23
    MOV  W2, W9
    CRC32X  W12, W7, X14
    CRC32W  W8, W20, W2
    MOV  X20, X25
    LSRV  X2, X12, X20
    MOVZ  W11, #0xed1d, LSL #16
    LSL  X17, X4, #2
    MOVN  W21, #0x4fe8, LSL #0
    MOV  W23, W8
    MOV  X14, X16
    SUBS  X19, X19, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_0
    MOVZ  X6, #0x7f85, LSL #0
    MOVK  X6, #0x1e07, LSL #16
    SUB  X3, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X6, #0x7957, LSL #0
    MOVK  X6, #0x9573, LSL #16
    SUB  X3, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X6, #0x60, LSL #0
    SUB  X3, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X6, #0x9b8b, LSL #0
    MOVK  X6, #0x15e6, LSL #16
    SUB  X3, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X6, #0x1646, LSL #0
    MOVK  X6, #0x1b58, LSL #16
    SUB  X3, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x427c, LSL #16
    SUB  X3, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X6, #0x3ac2, LSL #0
    MOVK  X6, #0x7a61, LSL #16
    SUB  X3, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0xed1d, LSL #16
    SUB  X3, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X6, #0x7f85, LSL #0
    MOVK  X6, #0x1e07, LSL #16
    SUB  X3, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X6, #0x579, LSL #0
    SUB  X3, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X6, #0xff98, LSL #0
    MOVK  X6, #0xda28, LSL #16
    SUB  X3, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X6, #0xe55c, LSL #0
    MOVK  X6, #0x55cd, LSL #16
    MOVK  X6, #0x2, LSL #32
    SUB  X3, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x9e4a, LSL #16
    SUB  X3, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X6, #0xb017, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X3, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X6, #0xb20, LSL #0
    MOVK  X6, #0x3738, LSL #16
    SUB  X3, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X6, #0x1646, LSL #0
    MOVK  X6, #0x1b58, LSL #16
    SUB  X3, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntCRCAndShiftAndMov_TestFail
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
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X2, #0xa, LSL #0
TSRTIntCRCAndShiftAndMov_label_1:
    LSR  W20, W7, W21
    MOV  X10, X20
    CRC32B  W3, W17, W18
    CRC32CX  W10, W15, X17
    LSR  X22, X25, #0x2b
    LSRV  X10, X23, X14
    MOV  X3, X10
    MOV  W18, W21
    MOVN  X3, #0x9330, LSL #16
    MOVK  W20, #0x3506, LSL #16
    CRC32CX  W25, W19, X22
    MOVN  X13, #0xb430, LSL #0
    MOVK  W9, #0x9252, LSL #0
    CRC32CX  W4, W16, X20
    MOV  X22, X8
    LSR  X17, X6, #0x1e
    MOVN  W4, #0x7287, LSL #0
    CRC32B  W20, W4, W13
    CRC32H  W21, W3, W25
    LSRV  X17, X22, X25
    LSL  X13, X20, #17
    LSL  X8, X9, #12
    LSRV  W4, W18, W13
    CRC32CX  W20, W21, X21
    LSRV  X16, X4, X20
    LSLV  W23, W8, W8
    LSRV  W25, W16, W22
    LSR  X18, X25, X23
    MOVZ  X19, #0x495a, LSL #16
    LSL  W8, W19, #18
    MOV  W6, W13
    MOVN  W3, #0x168d, LSL #16
    CRC32CB  W19, W17, W22
    MOV  W21, W3
    CRC32X  W6, W13, X19
    LSR  W20, W8, W20
    CRC32W  W23, W6, W20
    CRC32X  W3, W23, X18
    LSL  X25, X12, X4
    LSLV  X18, X17, X21
    MOV  X20, X4
    LSL  W22, W16, W20
    LSLV  X17, X15, X2
    MOVN  X19, #0x72b3, LSL #48
    LSR  W18, W15, #0x4
    LSRV  W6, W25, W22
    CRC32B  W23, W17, W25
    MOV  X16, X4
    LSRV  X15, X8, X3
    CRC32W  W9, W3, W14
    MOV  W17, W13
    CRC32CB  W25, W25, W13
    MOV  W4, W14
    LSRV  W25, W25, W17
    CRC32W  W17, W18, W15
    LSRV  X19, X3, X19
    LSR  W8, W6, W25
    CRC32CB  W6, W6, W8
    MOV  W8, W4
    LSR  X13, X9, X8
    MOVN  W18, #0x9f59, LSL #0
    LSL  X14, X17, X18
    LSLV  X6, X6, X23
    LSL  X3, X15, X21
    CRC32CW  W23, W16, W3
    CRC32W  W25, W16, W17
    LSL  X9, X19, #10
    MOVN  W19, #0xda5, LSL #16
    LSRV  X3, X14, X14
    CRC32CX  W22, W25, X25
    MOVZ  X8, #0x8c0a, LSL #32
    LSRV  X15, X9, X23
    CRC32CB  W20, W8, W6
    CRC32CH  W18, W20, W15
    LSRV  X14, X14, X8
    LSL  X9, X21, X4
    LSRV  X6, X3, X9
    LSLV  W4, W18, W13
    CRC32CX  W25, W14, X20
    MOVZ  X13, #0x7186, LSL #32
    CRC32CB  W20, W8, W13
    LSLV  X10, X2, X25
    LSR  W18, W19, W6
    LSL  X25, X9, X10
    LSL  W16, W18, W4
    LSR  X3, X25, X20
    MOV  X10, X17
    LSRV  X6, X13, X10
    LSL  X8, X16, X22
    LSL  X14, X14, #46
    MOVZ  W16, #0x15fe, LSL #0
    LSR  X17, X16, X6
    CRC32CW  W9, W14, W8
    MOV  X6, X4
    CRC32X  W16, W9, X6
    MOVN  X6, #0x776b, LSL #0
    MOVK  X9, #0xa79d, LSL #32
    MOVK  X22, #0xdf47, LSL #32
    MOV  X25, X14
    LSLV  X14, X7, X22
    LSL  X19, X7, #43
    LSLV  W15, W25, W3
    MOV  W18, W21
    LSRV  X7, X16, X8
    MOVK  X4, #0xaab4, LSL #16
    MOV  X21, X17
    MOVZ  W16, #0x52e8, LSL #16
    MOVZ  W22, #0x95bf, LSL #16
    MOVK  W13, #0x6d68, LSL #16
    LSRV  X12, X16, X16
    CRC32CB  W17, W17, W6
    CRC32CW  W6, W22, W14
    CRC32B  W22, W17, W3
    MOVK  W17, #0x5645, LSL #0
    CRC32CB  W12, W4, W8
    LSLV  W3, W12, W15
    LSLV  W7, W21, W3
    LSLV  X14, X13, X22
    MOV  X22, X23
    CRC32CX  W9, W19, X18
    LSLV  X10, X19, X23
    LSR  X20, X9, #0x22
    LSL  W8, W22, W7
    CRC32CB  W22, W14, W8
    LSLV  W18, W17, W6
    LSLV  W4, W20, W18
    LSR  X9, X22, X10
    LSL  W10, W2, W16
    CRC32X  W25, W15, X19
    MOVK  X18, #0xbbfe, LSL #48
    CRC32CW  W3, W15, W8
    LSL  X12, X3, X13
    MOV  X18, X13
    LSL  W7, W12, #15
    LSR  X15, X2, X15
    LSLV  X8, X9, X3
    MOVZ  X22, #0xb7d1, LSL #0
    LSLV  X13, X16, X20
    CRC32CH  W23, W22, W22
    LSL  W15, W15, W25
    CRC32X  W21, W8, X15
    LSR  X15, X6, X18
    LSR  X15, X21, X15
    LSRV  X18, X3, X7
    MOVK  X3, #0xdb99, LSL #48
    LSL  X21, X10, #52
    MOV  W12, W21
    MOV  W25, W3
    LSL  X19, X16, X12
    MOVZ  W8, #0xbcba, LSL #16
    MOVN  W21, #0x2984, LSL #16
    CRC32B  W20, W23, W23
    LSR  X23, X21, #0x1a
    LSL  X14, X15, X25
    LSR  W21, W9, W23
    CRC32W  W16, W19, W19
    CRC32CH  W19, W14, W8
    CRC32B  W25, W13, W19
    CRC32H  W20, W16, W21
    LSRV  X16, X14, X3
    MOVN  W23, #0xd1cf, LSL #0
    CRC32CW  W12, W20, W7
    MOVN  W3, #0x7393, LSL #16
    MOV  W15, W6
    CRC32CW  W14, W23, W16
    LSR  W10, W18, W13
    CRC32CW  W7, W12, W25
    LSL  X6, X17, #27
    MOVK  W19, #0x4765, LSL #0
    CRC32H  W14, W18, W15
    LSL  X12, X19, #6
    LSR  X18, X17, #0xb
    LSRV  X15, X14, X7
    LSLV  W22, W12, W15
    MOVZ  W8, #0xde43, LSL #0
    MOV  W19, W19
    CRC32X  W7, W10, X6
    MOVK  W14, #0x9bfd, LSL #16
    LSL  W13, W7, W18
    MOVN  X18, #0xa440, LSL #0
    LSR  X7, X4, #0x30
    CRC32CB  W9, W13, W14
    LSLV  W22, W8, W7
    MOVZ  X14, #0x24c9, LSL #48
    CRC32X  W16, W18, X18
    LSL  X13, X9, #39
    LSL  W17, W15, #25
    MOVZ  X19, #0xb472, LSL #0
    LSLV  X7, X4, X14
    LSR  W14, W19, W16
    MOVZ  X8, #0xf7e5, LSL #48
    MOV  W14, W10
    LSRV  X19, X6, X4
    CRC32CH  W12, W13, W4
    CRC32B  W16, W14, W4
    LSR  X4, X16, X17
    LSRV  W14, W20, W22
    CRC32X  W6, W19, X20
    LSR  W16, W12, W14
    CRC32B  W13, W19, W3
    SUBS  X2, X2, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_1
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0x8c6c, LSL #16
    SUB  X5, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0x3e59, LSL #0
    MOVK  X11, #0x4b21, LSL #16
    SUB  X5, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0x86d9, LSL #0
    MOVK  X11, #0x577f, LSL #16
    SUB  X5, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xf7e5, LSL #48
    SUB  X5, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0x10a2, LSL #0
    MOVK  X11, #0xe481, LSL #16
    SUB  X5, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0x1e25, LSL #0
    MOVK  X11, #0x25ea, LSL #16
    SUB  X5, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0xef8d, LSL #0
    MOVK  X11, #0x2d2a, LSL #16
    SUB  X5, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0x95cf, LSL #0
    MOVK  X11, #0x16a2, LSL #16
    SUB  X5, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0x7fd8, LSL #0
    MOVK  X11, #0x194, LSL #16
    SUB  X5, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xb000, LSL #16
    SUB  X5, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0x5bbf, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X5, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x2800, LSL #16
    MOVK  X11, #0x22b2, LSL #32
    MOVK  X11, #0x51, LSL #48
    SUB  X5, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0xae7b, LSL #0
    MOVK  X11, #0xb514, LSL #16
    SUB  X5, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0x5f9, LSL #0
    SUB  X5, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0xde43, LSL #0
    SUB  X5, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0x2e30, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X5, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0xe800, LSL #0
    MOVK  X11, #0x52, LSL #16
    SUB  X5, X11, X25
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
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    MOVZ  X21, #0xa, LSL #0
TSRTIntCRCAndShiftAndMov_label_2:
    MOV  W2, W17
    CRC32CW  W3, W9, W20
    CRC32X  W3, W2, X18
    LSR  W22, W3, W23
    MOV  X10, X17
    CRC32H  W15, W6, W22
    LSL  X14, X25, #11
    MOV  X18, X5
    LSRV  X3, X14, X10
    MOVK  W8, #0x4230, LSL #0
    CRC32CW  W23, W15, W13
    MOVZ  W6, #0x2aaa, LSL #0
    LSR  W12, W3, #0x4
    LSL  W23, W21, W18
    MOV  X25, X21
    CRC32CW  W5, W10, W23
    LSLV  X15, X8, X10
    MOV  W20, W19
    LSR  W18, W10, W15
    MOV  X7, X18
    MOV  X19, X5
    LSL  W14, W19, W7
    CRC32CH  W23, W6, W9
    CRC32H  W22, W12, W2
    MOV  W18, W25
    CRC32X  W13, W18, X21
    LSL  X16, X23, X23
    CRC32CW  W16, W3, W8
    MOVK  X8, #0xe370, LSL #32
    LSLV  X17, X14, X16
    LSLV  X23, X13, X8
    MOV  W13, W22
    LSL  W3, W13, #23
    CRC32CH  W10, W20, W13
    MOVN  W15, #0x6598, LSL #16
    MOVK  W2, #0x7836, LSL #16
    LSL  X3, X20, #41
    LSRV  W25, W16, W3
    MOV  W17, W25
    CRC32CB  W14, W2, W23
    MOVK  X5, #0x3a0, LSL #16
    CRC32X  W7, W17, X15
    LSRV  X23, X12, X14
    LSL  W16, W22, W7
    MOVN  X18, #0x6770, LSL #0
    LSR  X2, X18, #0x8
    CRC32CX  W10, W10, X23
    MOVZ  W10, #0x11fc, LSL #16
    MOVK  X18, #0xefd5, LSL #0
    LSRV  W13, W6, W10
    LSL  W25, W3, #8
    MOVK  W14, #0x7ea1, LSL #16
    LSL  X3, X2, #44
    MOV  X17, X13
    LSR  X13, X20, X10
    MOV  W18, W13
    LSR  W12, W5, #0x11
    CRC32B  W6, W18, W21
    MOVK  X25, #0x8f6c, LSL #16
    LSL  W5, W16, #29
    MOV  X7, X19
    CRC32CX  W2, W12, X7
    CRC32X  W18, W23, X9
    LSR  X15, X3, X17
    CRC32CX  W22, W15, X13
    LSRV  W2, W25, W18
    CRC32CX  W16, W2, X14
    LSLV  W7, W5, W22
    MOV  W13, W16
    CRC32CB  W12, W6, W6
    CRC32X  W18, W23, X7
    LSRV  X16, X18, X12
    MOVN  X12, #0x62b2, LSL #32
    MOVN  X3, #0x5fe5, LSL #0
    CRC32CB  W10, W18, W3
    MOVZ  X3, #0xb75b, LSL #16
    MOVK  W15, #0x3aec, LSL #16
    CRC32B  W5, W22, W6
    CRC32X  W2, W23, X3
    LSL  W6, W17, W6
    LSLV  X8, X25, X17
    LSL  W23, W15, W22
    MOVK  X18, #0xa830, LSL #16
    LSLV  X17, X8, X23
    MOVK  W23, #0xcbed, LSL #0
    LSL  W25, W18, #23
    MOVK  W7, #0xfc36, LSL #16
    CRC32CX  W22, W23, X13
    MOVN  X15, #0xc5e7, LSL #0
    LSL  W23, W25, W25
    CRC32CB  W25, W6, W16
    LSL  X8, X18, X23
    LSR  W14, W17, W3
    MOVN  W6, #0xbd46, LSL #16
    LSR  W23, W10, W6
    LSLV  W13, W12, W8
    MOVZ  W10, #0xcec3, LSL #16
    CRC32H  W17, W5, W14
    MOV  W15, W13
    LSL  W5, W6, W18
    CRC32X  W7, W17, X25
    MOVZ  X6, #0x3573, LSL #0
    MOVZ  X10, #0x2e85, LSL #48
    CRC32H  W3, W2, W25
    MOVZ  W14, #0x1328, LSL #16
    LSL  W18, W5, #6
    LSLV  X5, X16, X10
    LSL  X5, X14, #54
    MOV  W12, W7
    LSL  W10, W3, W8
    CRC32CH  W10, W15, W18
    CRC32B  W5, W5, W5
    MOV  W8, W22
    MOV  X16, X10
    LSR  X19, X7, #0x2a
    MOVN  X18, #0xfd4, LSL #0
    LSR  W10, W5, W7
    LSL  X13, X19, #62
    LSL  X19, X13, X18
    MOV  W5, W18
    CRC32CX  W23, W19, X13
    CRC32CX  W18, W7, X8
    MOVK  X2, #0x5660, LSL #16
    MOVN  W8, #0x3c8d, LSL #0
    MOV  W7, W23
    CRC32CW  W3, W2, W12
    MOVZ  X23, #0xcde1, LSL #0
    LSR  X12, X3, X7
    MOV  X10, X22
    MOVN  W2, #0x8c7f, LSL #16
    CRC32B  W22, W16, W23
    LSR  W7, W14, W22
    LSLV  W22, W18, W15
    CRC32CH  W18, W16, W5
    CRC32CX  W14, W22, X12
    MOV  X12, X8
    MOVK  W18, #0xdef1, LSL #0
    LSR  X22, X18, X12
    CRC32CW  W15, W22, W18
    CRC32CX  W13, W8, X2
    LSR  X12, X21, X15
    LSR  X16, X13, #0x14
    MOV  W23, W12
    LSR  X3, X23, X23
    LSL  X19, X16, X12
    LSRV  W18, W10, W14
    LSL  W15, W18, W6
    CRC32CH  W16, W2, W17
    LSL  W23, W15, W3
    LSL  W6, W19, #25
    LSR  W22, W14, W21
    MOV  X10, X23
    LSLV  W5, W7, W10
    CRC32CB  W12, W6, W16
    MOV  X19, X22
    CRC32CW  W17, W5, W20
    MOV  W15, W18
    MOV  X5, X3
    MOVN  W10, #0xdb64, LSL #16
    CRC32W  W18, W19, W15
    MOV  X17, X5
    LSR  X13, X20, #0x1f
    CRC32CB  W22, W17, W20
    CRC32CW  W16, W20, W9
    MOV  W25, W13
    MOVN  X23, #0x5ae7, LSL #32
    LSR  X7, X16, X17
    CRC32CW  W12, W3, W12
    MOV  W7, W22
    MOVZ  X19, #0x89c8, LSL #16
    MOVK  W14, #0xfd4d, LSL #16
    LSLV  X15, X25, X7
    CRC32CW  W20, W15, W14
    MOVZ  W23, #0xd334, LSL #0
    LSL  W16, W14, W18
    CRC32CW  W2, W2, W10
    MOV  W22, W20
    MOV  W14, W9
    MOV  X20, X19
    CRC32W  W9, W10, W22
    CRC32W  W3, W19, W12
    LSL  X15, X23, #47
    MOVZ  W19, #0x3a21, LSL #0
    LSRV  X8, X20, X15
    LSL  X7, X19, #13
    CRC32W  W8, W17, W3
    LSRV  X18, X25, X8
    LSL  W15, W7, W2
    MOVK  X3, #0x40a7, LSL #16
    CRC32CB  W13, W3, W15
    MOVN  X2, #0xf437, LSL #32
    CRC32CX  W5, W9, X17
    MOVZ  X20, #0x87e9, LSL #48
    LSLV  X23, X16, X16
    CRC32H  W10, W2, W20
    MOVN  X20, #0xccb0, LSL #0
    MOVK  X12, #0xa6c8, LSL #16
    LSR  W16, W12, W21
    CRC32W  W15, W20, W16
    CRC32H  W12, W12, W23
    SUBS  X21, X21, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_2
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xbc8, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X4, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0xf31e, LSL #0
    MOVK  X11, #0x40a7, LSL #16
    SUB  X4, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0x6cf4, LSL #0
    MOVK  X11, #0x7b3b, LSL #16
    SUB  X4, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x5c00, LSL #16
    SUB  X4, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0x2000, LSL #0
    MOVK  X11, #0x744, LSL #16
    SUB  X4, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0x5b69, LSL #0
    MOVK  X11, #0xf3a3, LSL #16
    SUB  X4, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0x4c37, LSL #0
    MOVK  X11, #0x3fd4, LSL #16
    SUB  X4, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0xed00, LSL #0
    MOVK  X11, #0xbe26, LSL #16
    SUB  X4, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0xa5d3, LSL #0
    MOVK  X11, #0x3966, LSL #16
    SUB  X4, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0xdfbb, LSL #0
    MOVK  X11, #0xbc66, LSL #16
    SUB  X4, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0x79a3, LSL #0
    MOVK  X11, #0x191e, LSL #16
    SUB  X4, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0x7e13, LSL #0
    MOVK  X11, #0xb090, LSL #16
    SUB  X4, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0x12ac, LSL #0
    MOVK  X11, #0x5364, LSL #16
    SUB  X4, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0x3a21, LSL #0
    SUB  X4, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0x334f, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X4, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0xb55e, LSL #0
    MOVK  X11, #0x7463, LSL #16
    SUB  X4, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntCRCAndShiftAndMov_TestFail
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
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    MOVZ  X2, #0xa, LSL #0
TSRTIntCRCAndShiftAndMov_label_3:
    MOV  W12, W2
    MOVZ  X6, #0xc330, LSL #32
    CRC32X  W6, W20, X22
    LSL  W20, W21, #7
    LSL  W4, W12, #17
    MOVN  W11, #0x2757, LSL #0
    LSL  X3, X3, #13
    LSL  X14, X23, #14
    MOVN  X15, #0xb0c6, LSL #32
    CRC32CB  W20, W14, W25
    MOV  X12, X23
    MOVZ  X17, #0x3874, LSL #32
    MOVK  X21, #0x7037, LSL #32
    MOVZ  X22, #0x90e, LSL #48
    LSR  W11, W11, #0x1
    CRC32H  W18, W13, W10
    MOV  X15, X19
    MOVZ  X8, #0xba25, LSL #32
    CRC32CX  W3, W22, X22
    MOVK  X17, #0x842c, LSL #0
    LSR  W12, W3, W21
    LSL  X14, X8, #25
    CRC32W  W16, W15, W3
    LSL  X3, X16, #4
    MOV  W15, W8
    MOVK  W13, #0xbcd7, LSL #0
    LSR  W21, W6, #0x16
    LSR  W11, W11, #0x2
    MOVN  X4, #0x3626, LSL #48
    LSL  W7, W22, #25
    CRC32CH  W6, W18, W4
    LSL  W8, W15, W12
    CRC32W  W4, W13, W20
    MOVN  W20, #0x5e4a, LSL #0
    MOVN  W10, #0x6125, LSL #16
    MOVZ  W8, #0xd319, LSL #0
    LSL  X22, X10, #38
    MOVZ  W14, #0x243b, LSL #16
    MOVK  X15, #0xe592, LSL #0
    MOVZ  X10, #0x700c, LSL #0
    MOVZ  W19, #0x4624, LSL #16
    LSL  W16, W22, W4
    LSR  X8, X19, X17
    MOVN  X7, #0x436c, LSL #16
    CRC32CX  W10, W11, X10
    LSLV  X22, X22, X20
    LSLV  X20, X6, X22
    LSR  X11, X12, #0x1d
    MOVK  X4, #0x183f, LSL #16
    CRC32H  W7, W10, W14
    MOV  W8, W8
    LSR  W23, W12, W17
    MOV  X21, X3
    LSL  W12, W20, W11
    LSLV  W11, W10, W12
    CRC32B  W11, W11, W4
    CRC32CH  W16, W7, W7
    MOV  W14, W12
    LSR  W12, W18, W8
    LSL  X13, X23, X21
    MOVK  X18, #0x38cf, LSL #0
    MOVK  X16, #0x81d5, LSL #0
    CRC32H  W16, W11, W13
    LSR  W15, W12, #0x0
    LSLV  W22, W15, W18
    LSLV  W23, W22, W16
    LSLV  W6, W8, W12
    MOVK  X20, #0xf03b, LSL #0
    MOVK  X22, #0x7a40, LSL #0
    CRC32X  W4, W4, X21
    LSR  W17, W22, W4
    LSRV  W13, W22, W13
    LSR  W8, W23, W19
    CRC32CB  W4, W4, W21
    MOV  X22, X19
    CRC32H  W12, W17, W21
    LSL  X19, X22, #39
    LSLV  W22, W13, W20
    LSL  W16, W21, W3
    CRC32CW  W18, W22, W13
    LSL  X20, X18, X3
    MOVK  W22, #0x3e87, LSL #16
    LSL  W3, W22, #20
    CRC32CB  W22, W3, W14
    MOV  X11, X25
    MOVZ  W3, #0xf8ec, LSL #0
    CRC32X  W25, W20, X10
    CRC32CW  W23, W4, W16
    LSR  X10, X19, #0x33
    CRC32CB  W17, W6, W3
    CRC32CW  W11, W20, W8
    LSLV  X3, X11, X4
    CRC32CW  W20, W4, W3
    MOVN  X6, #0xc4c3, LSL #16
    MOV  W13, W20
    LSLV  X3, X17, X23
    MOVN  W8, #0x9d3e, LSL #16
    MOVK  W22, #0x260c, LSL #0
    LSR  X16, X22, #0x2f
    LSRV  X8, X16, X10
    MOVK  X21, #0xfb1e, LSL #48
    CRC32CX  W11, W14, X3
    CRC32X  W14, W3, X21
    LSLV  W22, W11, W8
    MOVK  W11, #0x5027, LSL #0
    LSL  X18, X25, X6
    MOV  X10, X13
    MOVZ  X3, #0xa56f, LSL #0
    MOVN  X21, #0x4d87, LSL #16
    LSL  X4, X10, X14
    CRC32CX  W14, W6, X11
    LSR  X16, X13, X21
    MOV  X3, X3
    LSLV  W11, W17, W14
    CRC32CH  W6, W3, W4
    MOVK  W14, #0x3eda, LSL #0
    CRC32CH  W13, W2, W14
    MOV  X14, X25
    MOVZ  W20, #0x4f31, LSL #0
    CRC32B  W8, W16, W4
    LSR  X19, X6, #0xd
    LSLV  W23, W14, W14
    LSRV  X21, X20, X11
    CRC32CH  W20, W13, W19
    LSL  X18, X18, #7
    MOV  W10, W23
    LSR  X13, X18, #0x35
    MOVZ  W16, #0xdb34, LSL #16
    MOVK  W13, #0xd5b6, LSL #16
    CRC32CH  W18, W11, W20
    MOVK  X25, #0xc262, LSL #48
    MOVK  X6, #0x63db, LSL #32
    MOVN  X11, #0xb384, LSL #32
    MOVK  X20, #0xcc1a, LSL #32
    MOV  X3, X25
    MOV  W16, W3
    LSR  X14, X4, #0x3c
    CRC32H  W6, W6, W19
    CRC32W  W6, W21, W20
    MOVN  X20, #0x7c0e, LSL #48
    CRC32B  W19, W10, W6
    CRC32CH  W23, W14, W18
    MOVN  X25, #0x380e, LSL #16
    LSL  X14, X23, X22
    LSL  X18, X13, #37
    MOVK  X4, #0xbc17, LSL #32
    CRC32B  W3, W25, W11
    CRC32H  W21, W14, W19
    LSL  X11, X4, X21
    MOVK  W6, #0x8820, LSL #0
    CRC32CB  W13, W20, W3
    CRC32CX  W10, W3, X23
    MOVK  W10, #0xac11, LSL #16
    MOVK  X14, #0x5eac, LSL #32
    MOV  W25, W14
    MOV  W19, W25
    LSLV  W22, W18, W18
    CRC32CH  W3, W3, W13
    MOVN  X14, #0xcee2, LSL #32
    LSR  X18, X3, #0x10
    LSR  X23, X17, X10
    LSR  X25, X14, #0xd
    LSLV  X14, X16, X23
    MOV  X10, X2
    CRC32CW  W13, W14, W25
    CRC32CB  W14, W10, W12
    LSR  W7, W19, W18
    LSR  X12, X7, X14
    CRC32H  W7, W11, W14
    CRC32W  W18, W14, W16
    LSL  X19, X25, #57
    MOV  X10, X23
    CRC32CW  W10, W12, W25
    LSR  X23, X18, #0x21
    LSLV  W16, W22, W10
    LSL  W22, W16, W6
    LSRV  X7, X19, X23
    MOV  W20, W15
    CRC32H  W11, W10, W23
    CRC32CB  W6, W20, W6
    MOVK  X18, #0x5cf6, LSL #48
    MOV  W6, W4
    MOV  W15, W21
    MOVN  W20, #0x4386, LSL #0
    CRC32W  W16, W7, W14
    MOV  W6, W16
    CRC32CB  W20, W15, W18
    CRC32H  W6, W23, W6
    MOVK  X16, #0xcf9c, LSL #0
    CRC32CH  W7, W6, W6
    LSRV  X4, X11, X4
    CRC32W  W10, W7, W4
    CRC32W  W4, W10, W22
    MOVK  X15, #0xca9c, LSL #48
    MOVZ  W21, #0x2308, LSL #16
    MOV  W22, W4
    CRC32CH  W12, W20, W4
    MOVZ  X13, #0xaf7e, LSL #16
    CRC32CX  W7, W22, X22
    MOVZ  W18, #0x4839, LSL #0
    SUBS  X2, X2, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_3
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0xbfe0, LSL #0
    MOVK  X5, #0xac78, LSL #16
    SUB  X9, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0x6149, LSL #0
    MOVK  X5, #0x8e17, LSL #16
    SUB  X9, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0x4d5d, LSL #0
    MOVK  X5, #0xf6d7, LSL #16
    SUB  X9, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0x9e3a, LSL #0
    MOVK  X5, #0xaed6, LSL #16
    SUB  X9, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0xe927, LSL #0
    MOVK  X5, #0x1d4c, LSL #16
    SUB  X9, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0x56a5, LSL #0
    MOVK  X5, #0xc07d, LSL #16
    SUB  X9, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xaf7e, LSL #16
    SUB  X9, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0xbf27, LSL #0
    MOVK  X5, #0xac78, LSL #16
    SUB  X9, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0x2b29, LSL #0
    MOVK  X5, #0xec9f, LSL #16
    MOVK  X5, #0xca9c, LSL #48
    SUB  X9, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0xcf9c, LSL #0
    MOVK  X5, #0xcb61, LSL #16
    SUB  X9, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0x67ca, LSL #0
    MOVK  X5, #0xae73, LSL #16
    SUB  X9, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0x4839, LSL #0
    SUB  X9, X5, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xfe00, LSL #48
    SUB  X9, X5, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0xdd04, LSL #0
    MOVK  X5, #0x17ab, LSL #16
    SUB  X9, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x2308, LSL #16
    SUB  X9, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0x6149, LSL #0
    MOVK  X5, #0x8e17, LSL #16
    SUB  X9, X5, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0x88ef, LSL #16
    MOVK  X5, #0xfff9, LSL #32
    MOVK  X5, #0x7, LSL #48
    SUB  X9, X5, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTIntCRCAndShiftAndMov_TestFail
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
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    MOVZ  X15, #0xa, LSL #0
TSRTIntCRCAndShiftAndMov_label_4:
    CRC32B  W25, W25, W20
    MOVZ  W21, #0x47d0, LSL #16
    MOV  X8, X7
    CRC32W  W11, W19, W21
    LSRV  X23, X11, X8
    MOVK  X14, #0xe001, LSL #16
    MOVZ  W20, #0x1564, LSL #16
    MOV  X17, X20
    MOV  W2, W17
    CRC32X  W2, W22, X25
    CRC32CX  W21, W14, X15
    MOV  W4, W21
    MOV  W12, W14
    LSR  W14, W18, #0x1c
    MOVN  W9, #0x53e3, LSL #16
    CRC32CH  W12, W2, W4
    MOV  X2, X13
    CRC32CW  W12, W9, W17
    LSLV  X11, X17, X21
    MOV  W19, W23
    LSR  X25, X2, X2
    CRC32X  W22, W18, X11
    LSLV  X25, X6, X25
    LSR  W11, W14, #0x2
    MOVK  W20, #0x784a, LSL #16
    CRC32W  W3, W20, W25
    MOVK  W2, #0x955, LSL #0
    LSLV  W21, W3, W22
    LSR  X14, X11, X12
    MOV  W18, W2
    LSLV  X25, X15, X23
    CRC32X  W6, W14, X18
    LSL  W12, W21, #26
    MOV  X9, X16
    MOV  X12, X16
    MOVK  X11, #0xf0f0, LSL #32
    MOV  W2, W19
    CRC32CB  W19, W9, W25
    LSL  X23, X13, X12
    MOVK  X22, #0x1a3a, LSL #32
    CRC32CB  W16, W2, W12
    LSL  W12, W14, W9
    CRC32H  W2, W20, W6
    LSRV  W16, W16, W19
    CRC32CW  W13, W19, W14
    MOVN  X3, #0xcc2d, LSL #48
    MOVK  W16, #0xfd73, LSL #0
    LSL  W20, W25, #15
    CRC32B  W25, W4, W23
    LSR  W18, W12, W2
    MOVN  X12, #0xaecc, LSL #16
    LSR  W9, W18, #0x12
    MOVZ  X20, #0xe653, LSL #32
    CRC32W  W18, W13, W22
    MOV  W22, W7
    CRC32X  W4, W18, X16
    MOV  X21, X4
    LSL  X19, X19, X20
    LSR  W21, W25, W22
    CRC32CW  W7, W16, W21
    CRC32CH  W13, W11, W11
    LSLV  W8, W4, W3
    LSLV  W22, W18, W6
    MOVN  X18, #0x9cd5, LSL #16
    CRC32CW  W18, W8, W3
    LSRV  X14, X7, X22
    CRC32CH  W4, W13, W18
    MOV  W13, W14
    CRC32CB  W22, W19, W17
    CRC32CW  W7, W12, W12
    MOV  W18, W9
    LSR  W14, W7, #0xe
    CRC32X  W3, W25, X13
    LSL  X7, X22, X6
    MOVN  X23, #0x6812, LSL #16
    LSRV  X2, X8, X14
    LSR  W9, W22, #0x1e
    CRC32CX  W16, W4, X3
    LSL  W14, W2, #27
    LSR  W13, W18, #0xc
    CRC32CX  W19, W9, X16
    CRC32CX  W2, W7, X6
    MOVZ  W20, #0x1644, LSL #16
    CRC32W  W2, W2, W13
    CRC32X  W18, W14, X19
    LSLV  X19, X12, X2
    LSR  X8, X8, X19
    MOV  W12, W23
    MOVZ  W3, #0x19c1, LSL #0
    CRC32CW  W9, W11, W17
    MOV  X6, X3
    MOVN  X16, #0xe785, LSL #16
    MOV  W2, W12
    CRC32W  W17, W6, W6
    LSL  W14, W16, #1
    MOVN  X25, #0x1656, LSL #32
    LSR  X2, X25, X18
    CRC32H  W19, W8, W17
    CRC32H  W2, W15, W19
    MOVN  X4, #0x4f05, LSL #0
    MOVN  X19, #0x7c1d, LSL #0
    LSR  X16, X20, #0x17
    LSLV  X11, X19, X9
    MOV  X14, X21
    MOV  W22, W16
    LSLV  X19, X15, X2
    CRC32CB  W6, W3, W11
    MOV  W4, W18
    CRC32H  W4, W22, W19
    MOVZ  X25, #0xdd7e, LSL #32
    LSL  W6, W14, W25
    LSR  X12, X6, #0x1a
    CRC32CB  W23, W16, W19
    LSR  W18, W9, W2
    CRC32CH  W20, W12, W18
    CRC32H  W16, W25, W9
    CRC32CW  W17, W8, W20
    LSL  X6, X4, #30
    LSRV  X18, X13, X18
    CRC32H  W4, W2, W19
    MOV  W20, W21
    LSRV  X23, X14, X6
    LSR  W6, W19, W3
    CRC32CW  W9, W2, W17
    CRC32CH  W22, W8, W3
    CRC32CB  W3, W13, W19
    LSR  X2, X22, X4
    CRC32H  W21, W23, W20
    CRC32W  W13, W9, W2
    CRC32CH  W23, W3, W16
    MOV  W12, W17
    LSR  X8, X18, #0xf
    LSL  X17, X8, #25
    LSRV  W16, W17, W13
    MOVK  X19, #0x29ea, LSL #16
    LSR  X22, X8, #0x18
    LSL  X7, X21, X6
    CRC32X  W17, W12, X14
    LSL  X4, X17, X7
    MOVZ  W3, #0x1131, LSL #0
    MOVZ  X14, #0xa0f6, LSL #48
    LSR  X9, X4, X8
    MOVN  X21, #0x70ef, LSL #32
    LSRV  X8, X19, X19
    LSRV  X4, X14, X20
    CRC32W  W6, W7, W4
    CRC32CW  W18, W6, W16
    MOVN  X21, #0x7f52, LSL #0
    CRC32CW  W25, W3, W22
    CRC32X  W7, W9, X8
    LSLV  X19, X18, X18
    CRC32CB  W2, W21, W7
    LSL  W3, W2, #15
    MOV  X13, X19
    LSRV  X7, X13, X21
    MOV  W17, W25
    MOV  X2, X13
    CRC32H  W19, W7, W17
    MOV  X13, X19
    LSL  X25, X2, #40
    MOVK  X22, #0xb7f4, LSL #32
    LSLV  W4, W6, W22
    MOVK  X21, #0xbb92, LSL #32
    MOVN  W22, #0x1d4d, LSL #16
    LSR  W3, W18, #0x9
    CRC32B  W18, W3, W15
    CRC32CH  W6, W9, W25
    MOV  X2, X22
    CRC32X  W19, W6, X18
    MOVZ  W3, #0x14ad, LSL #16
    LSLV  W22, W13, W19
    LSR  W6, W22, #0x12
    CRC32X  W25, W6, X18
    LSR  W9, W14, W4
    LSL  W18, W2, W2
    LSL  W2, W25, W3
    CRC32X  W6, W18, X13
    LSL  X13, X3, #4
    CRC32CW  W7, W19, W2
    LSLV  W17, W21, W7
    LSR  X25, X9, X6
    MOVN  X23, #0xeaa7, LSL #48
    LSR  W21, W17, W17
    CRC32W  W6, W21, W21
    LSL  X2, X8, X13
    CRC32X  W9, W18, X9
    CRC32CB  W22, W25, W7
    LSL  X7, X12, #45
    MOV  W13, W23
    MOV  W16, W16
    MOVN  X21, #0x60, LSL #48
    MOV  X17, X16
    LSR  W14, W7, #0xf
    MOVN  W14, #0x4c6, LSL #16
    CRC32CH  W20, W14, W13
    CRC32X  W18, W20, X4
    CRC32CH  W7, W13, W7
    LSL  W3, W7, #19
    MOVK  W14, #0x9fe8, LSL #16
    LSRV  X8, X21, X9
    SUBS  X15, X15, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_4
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x29ea, LSL #16
    MOVK  X10, #0x2, LSL #32
    SUB  X5, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x4168, LSL #16
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0x556f, LSL #0
    MOVK  X10, #0x226a, LSL #16
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0x882d, LSL #0
    MOVK  X10, #0xe9e, LSL #16
    SUB  X5, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0x3fe7, LSL #32
    SUB  X5, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0xb092, LSL #0
    MOVK  X10, #0xb1e6, LSL #16
    SUB  X5, X10, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7c4, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0x9f1b, LSL #0
    MOVK  X10, #0x24da, LSL #16
    SUB  X5, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X5, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0x9fe8, LSL #16
    SUB  X5, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0x22a, LSL #0
    MOVK  X10, #0x96b3, LSL #16
    SUB  X5, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0x39cc, LSL #0
    MOVK  X10, #0xa032, LSL #16
    SUB  X5, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0xfb39, LSL #0
    SUB  X5, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xff9f, LSL #48
    SUB  X5, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0x1340, LSL #0
    MOVK  X10, #0xe914, LSL #16
    SUB  X5, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0x1558, LSL #48
    SUB  X5, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X2, #0x699d, LSL #0
    MOVK  X2, #0x56be, LSL #16
    MOVK  X2, #0xc4b3, LSL #32
    MOVK  X2, #0x7d0c, LSL #48
    MOVZ  X3, #0xa0, LSL #0
    MOVK  X3, #0xe54c, LSL #16
    MOVK  X3, #0xefc2, LSL #32
    MOVK  X3, #0xafd7, LSL #48
    MOVZ  X4, #0xda11, LSL #0
    MOVK  X4, #0x9b15, LSL #16
    MOVK  X4, #0x5ad9, LSL #32
    MOVK  X4, #0x2ec2, LSL #48
    MOVZ  X5, #0x80b3, LSL #0
    MOVK  X5, #0xea2a, LSL #16
    MOVK  X5, #0x3fbb, LSL #32
    MOVK  X5, #0xe779, LSL #48
    MOVZ  X6, #0xa5ab, LSL #0
    MOVK  X6, #0xf753, LSL #16
    MOVK  X6, #0xaac2, LSL #32
    MOVK  X6, #0xee58, LSL #48
    MOVZ  X7, #0x35e3, LSL #0
    MOVK  X7, #0x44dd, LSL #16
    MOVK  X7, #0xe796, LSL #32
    MOVK  X7, #0xd57c, LSL #48
    MOVZ  X8, #0x31f7, LSL #0
    MOVK  X8, #0xe0c7, LSL #16
    MOVK  X8, #0x95e8, LSL #32
    MOVK  X8, #0x7604, LSL #48
    MOVZ  X9, #0xf873, LSL #0
    MOVK  X9, #0x8be6, LSL #16
    MOVK  X9, #0xb606, LSL #32
    MOVK  X9, #0x96cb, LSL #48
    MOVZ  X10, #0x94f8, LSL #0
    MOVK  X10, #0x6b1, LSL #16
    MOVK  X10, #0xe14d, LSL #32
    MOVK  X10, #0xaba3, LSL #48
    MOVZ  X11, #0x588e, LSL #0
    MOVK  X11, #0x5aba, LSL #16
    MOVK  X11, #0x95bd, LSL #32
    MOVK  X11, #0xcd4, LSL #48
    MOVZ  X12, #0x4ddd, LSL #0
    MOVK  X12, #0x55e1, LSL #16
    MOVK  X12, #0x3c54, LSL #32
    MOVK  X12, #0x2be1, LSL #48
    MOVZ  X13, #0x3b26, LSL #0
    MOVK  X13, #0x4e6, LSL #16
    MOVK  X13, #0xe204, LSL #32
    MOVK  X13, #0x82a3, LSL #48
    MOVZ  X14, #0x7f1a, LSL #0
    MOVK  X14, #0x46ab, LSL #16
    MOVK  X14, #0xee1d, LSL #32
    MOVK  X14, #0xe371, LSL #48
    MOVZ  X15, #0xd4dd, LSL #0
    MOVK  X15, #0x5d04, LSL #16
    MOVK  X15, #0x848a, LSL #32
    MOVK  X15, #0xcd5d, LSL #48
    MOVZ  X16, #0x6328, LSL #0
    MOVK  X16, #0xafb9, LSL #16
    MOVK  X16, #0xe70d, LSL #32
    MOVK  X16, #0xeddd, LSL #48
    MOVZ  X17, #0xa7df, LSL #0
    MOVK  X17, #0x1fd4, LSL #16
    MOVK  X17, #0x5232, LSL #32
    MOVK  X17, #0xd381, LSL #48
    MOVZ  X18, #0xa631, LSL #0
    MOVK  X18, #0x442b, LSL #16
    MOVK  X18, #0x793, LSL #32
    MOVK  X18, #0xeaf0, LSL #48
    MOVZ  X19, #0xc663, LSL #0
    MOVK  X19, #0xdc3c, LSL #16
    MOVK  X19, #0x41a7, LSL #32
    MOVK  X19, #0x51a8, LSL #48
    MOVZ  X20, #0x7e13, LSL #0
    MOVK  X20, #0x5289, LSL #16
    MOVK  X20, #0x986a, LSL #32
    MOVK  X20, #0x6829, LSL #48
    MOVZ  X21, #0x5ab6, LSL #0
    MOVK  X21, #0xe235, LSL #16
    MOVK  X21, #0x23d3, LSL #32
    MOVK  X21, #0x1790, LSL #48
    MOVZ  X22, #0xddec, LSL #0
    MOVK  X22, #0xbd17, LSL #16
    MOVK  X22, #0xc750, LSL #32
    MOVK  X22, #0xad3a, LSL #48
    MOVZ  X23, #0x13dd, LSL #0
    MOVK  X23, #0xdc25, LSL #16
    MOVK  X23, #0x361c, LSL #32
    MOVK  X23, #0xe159, LSL #48
    MOVZ  X25, #0x4426, LSL #0
    MOVK  X25, #0x8d27, LSL #16
    MOVK  X25, #0x59fa, LSL #32
    MOVK  X25, #0xe64a, LSL #48
    MOVZ  X23, #0xa, LSL #0
TSRTIntCRCAndShiftAndMov_label_5:
    LSRV  W21, W21, W13
    MOV  W4, W22
    MOVK  X7, #0xdcf2, LSL #0
    LSL  X21, X8, #10
    MOVK  X2, #0x2257, LSL #48
    LSRV  X20, X20, X7
    MOVN  X8, #0xf519, LSL #16
    CRC32CB  W11, W8, W2
    CRC32B  W16, W9, W11
    LSR  W16, W20, W11
    MOV  X7, X23
    MOVZ  W16, #0x5d09, LSL #16
    MOVK  X8, #0x50fc, LSL #32
    LSL  X25, X8, X21
    LSR  W16, W20, W4
    CRC32CW  W6, W7, W25
    LSR  X22, X6, X8
    MOVN  W25, #0xd761, LSL #0
    LSR  X11, X10, #0x18
    LSRV  X19, X3, X5
    LSL  W21, W19, W21
    MOVN  X13, #0x8b1a, LSL #0
    LSR  W10, W19, W7
    LSL  W8, W3, #13
    LSL  X25, X20, #26
    CRC32CB  W6, W16, W5
    MOVN  W6, #0x7b56, LSL #16
    LSL  X17, X8, X22
    LSLV  X20, X6, X13
    LSR  X19, X22, X11
    LSR  X17, X22, #0x39
    CRC32CH  W6, W20, W20
    LSL  X22, X6, X21
    LSRV  X13, X13, X4
    LSR  W11, W19, W22
    MOVZ  W13, #0x85d2, LSL #0
    MOVZ  X12, #0x9163, LSL #16
    CRC32B  W21, W10, W13
    MOV  W22, W10
    LSRV  W10, W12, W14
    MOVN  X6, #0x6d9f, LSL #16
    MOV  W5, W22
    MOV  X20, X25
    LSR  W17, W25, #0x12
    MOVZ  W9, #0xa76f, LSL #16
    LSR  X3, X9, #0x6
    MOV  X22, X3
    MOVN  W10, #0x6e6b, LSL #16
    MOVK  X3, #0x95c7, LSL #32
    MOVN  W4, #0x2962, LSL #16
    LSL  X12, X22, #25
    CRC32X  W19, W11, X16
    MOV  X9, X19
    LSR  X16, X21, X20
    MOVZ  X20, #0xac79, LSL #32
    LSR  X6, X23, #0x3a
    LSL  W14, W5, W16
    CRC32CB  W22, W10, W25
    LSR  W13, W6, W9
    LSL  W19, W19, W13
    CRC32CX  W6, W19, X12
    CRC32B  W19, W2, W8
    MOVZ  W13, #0x922e, LSL #0
    LSL  X21, X20, X3
    LSL  W9, W4, #31
    MOVZ  X4, #0x1a7f, LSL #0
    MOV  W5, W17
    CRC32H  W10, W4, W5
    LSL  X3, X9, #44
    LSLV  W12, W13, W10
    LSR  W12, W19, #0x3
    CRC32W  W5, W6, W14
    CRC32X  W16, W5, X3
    LSLV  X8, X7, X12
    LSL  W10, W8, W13
    CRC32B  W4, W16, W22
    CRC32B  W6, W11, W21
    LSLV  W8, W4, W14
    CRC32W  W13, W17, W6
    CRC32CB  W5, W5, W13
    MOVN  W13, #0x84aa, LSL #0
    LSR  W22, W2, #0x5
    CRC32W  W4, W2, W12
    MOV  W12, W2
    MOVN  X16, #0x9011, LSL #48
    LSR  X7, X16, #0x2a
    LSR  X13, X22, X11
    MOVN  X3, #0xb2e0, LSL #16
    MOV  X4, X20
    LSL  W2, W20, #27
    MOVN  W22, #0x2567, LSL #0
    MOV  W14, W14
    MOVN  W17, #0xaf74, LSL #0
    CRC32CW  W21, W10, W13
    LSL  X25, X4, #55
    MOVN  X6, #0xbdab, LSL #16
    MOVK  W9, #0x2b25, LSL #16
    MOV  W11, W21
    CRC32X  W13, W9, X5
    CRC32X  W13, W13, X2
    LSR  W20, W12, W12
    LSL  W8, W8, W13
    CRC32CX  W9, W25, X22
    MOVN  X13, #0xf1a9, LSL #48
    CRC32H  W9, W14, W3
    CRC32CX  W16, W6, X8
    LSL  X2, X20, #54
    MOVZ  X14, #0xcefa, LSL #0
    MOVK  W12, #0x2690, LSL #0
    LSLV  W5, W11, W16
    MOVK  W9, #0xdf26, LSL #16
    MOVN  W19, #0xeba3, LSL #0
    MOVN  X11, #0xc130, LSL #16
    MOVK  W3, #0x33cd, LSL #0
    MOVK  W16, #0xe58d, LSL #16
    LSL  X6, X7, X19
    CRC32CH  W22, W16, W12
    MOV  X8, X17
    MOVZ  X7, #0x6c59, LSL #0
    LSRV  X19, X13, X22
    LSRV  X13, X17, X8
    LSL  W17, W19, W7
    MOV  W19, W13
    LSR  X20, X11, #0x13
    LSR  W22, W23, #0xa
    LSRV  X8, X5, X9
    MOVZ  X12, #0xd7e4, LSL #0
    LSRV  W6, W20, W12
    CRC32W  W16, W6, W14
    CRC32CH  W11, W16, W16
    CRC32X  W11, W11, X17
    LSR  X5, X2, X3
    LSLV  X17, X22, X17
    LSL  W20, W12, #10
    MOVZ  X9, #0x21c3, LSL #48
    LSR  W6, W19, W9
    MOVZ  W12, #0x9830, LSL #0
    LSR  X14, X6, X6
    LSR  W13, W5, #0xe
    MOV  W4, W13
    CRC32CW  W5, W6, W17
    MOV  W20, W14
    MOVK  W6, #0x14a4, LSL #0
    MOVZ  X16, #0x2dcd, LSL #16
    CRC32B  W9, W4, W4
    LSL  X14, X16, #9
    MOVZ  X5, #0x5c3a, LSL #0
    LSRV  X7, X16, X22
    CRC32CB  W16, W12, W11
    LSL  X19, X14, X19
    LSLV  X11, X14, X5
    CRC32B  W5, W17, W16
    LSRV  W22, W19, W11
    CRC32CX  W11, W22, X22
    MOVK  W22, #0x7767, LSL #0
    MOVN  X22, #0xed84, LSL #0
    MOV  W17, W5
    LSLV  W12, W7, W8
    LSL  W13, W2, #28
    CRC32CW  W5, W22, W11
    MOV  X14, X5
    LSL  X21, X12, X13
    MOVN  W10, #0x3ea4, LSL #16
    MOVZ  X22, #0x98d5, LSL #32
    CRC32H  W19, W14, W25
    MOVN  X14, #0x62ce, LSL #16
    LSRV  X2, X4, X9
    LSR  W13, W10, #0x10
    MOVN  W8, #0x8a84, LSL #16
    LSL  X5, X20, #38
    LSR  W16, W17, W21
    LSR  W10, W22, #0xd
    CRC32W  W17, W10, W6
    MOVK  W10, #0xf2db, LSL #0
    LSR  W4, W14, #0x1
    LSR  X12, X14, X2
    LSL  X22, X10, #8
    LSLV  W20, W5, W12
    LSRV  W7, W23, W19
    LSRV  W21, W16, W8
    MOVN  X12, #0x3085, LSL #32
    MOV  X9, X22
    MOV  W2, W7
    CRC32W  W7, W2, W13
    CRC32CX  W5, W4, X4
    MOVZ  X8, #0xcd0b, LSL #48
    MOVN  X25, #0xd797, LSL #32
    CRC32CB  W4, W20, W19
    LSRV  X5, X14, X7
    LSL  X7, X22, X17
    MOV  W16, W8
    MOVK  W21, #0x7920, LSL #0
    CRC32H  W2, W12, W9
    CRC32X  W19, W17, X10
    CRC32CH  W6, W21, W5
    LSRV  X5, X6, X25
    CRC32B  W8, W5, W16
    MOV  W6, W14
    CRC32B  W10, W2, W6
    LSL  X17, X10, #29
    SUBS  X23, X23, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_5
    MOVZ  X18, #0xe65c, LSL #0
    MOVK  X18, #0xaf27, LSL #16
    SUB  X15, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x33cd, LSL #0
    MOVK  X18, #0x4d1f, LSL #16
    SUB  X15, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x22b9, LSL #0
    MOVK  X18, #0x65d1, LSL #16
    SUB  X15, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0x9d31, LSL #16
    SUB  X15, X18, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xdb00, LSL #32
    MOVK  X18, #0xf2, LSL #48
    SUB  X15, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0xdb00, LSL #0
    MOVK  X18, #0xf2, LSL #16
    SUB  X15, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0xd5b4, LSL #0
    MOVK  X18, #0x4f70, LSL #16
    SUB  X15, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xcf7a, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X15, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0xc15b, LSL #0
    SUB  X15, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0x9d31, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X15, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x8000, LSL #16
    MOVK  X18, #0x1ab6, LSL #32
    MOVK  X18, #0x9ee, LSL #48
    SUB  X15, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0xa3f1, LSL #0
    MOVK  X18, #0x1bec, LSL #16
    SUB  X15, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x7920, LSL #0
    SUB  X15, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0xdb00, LSL #0
    MOVK  X18, #0xf2, LSL #16
    SUB  X15, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0x2868, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X15, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTIntCRCAndShiftAndMov_TestFail
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
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X4, #0xa, LSL #0
TSRTIntCRCAndShiftAndMov_label_6:
    LSL  X11, X6, X20
    MOVK  X5, #0x5391, LSL #32
    CRC32W  W16, W2, W10
    MOVN  X15, #0xeaa0, LSL #16
    LSRV  W19, W3, W19
    CRC32CW  W16, W19, W12
    LSLV  X18, X16, X4
    LSRV  X15, X23, X12
    MOV  W19, W7
    LSLV  X18, X9, X9
    LSRV  W19, W22, W21
    MOV  W7, W15
    MOV  W21, W18
    MOV  X21, X10
    LSL  X15, X21, #16
    LSLV  X22, X25, X14
    LSL  W2, W18, W15
    LSR  W12, W2, W3
    LSL  W10, W12, W12
    CRC32H  W15, W12, W11
    LSR  W3, W21, W10
    CRC32CX  W11, W22, X4
    LSRV  X10, X2, X11
    LSR  X12, X10, #0x3b
    CRC32CW  W11, W12, W5
    MOV  W25, W10
    MOV  W16, W3
    CRC32CX  W21, W25, X15
    LSL  X18, X7, #4
    LSR  X6, X18, X21
    LSLV  X18, X16, X6
    LSR  W22, W13, W11
    CRC32CB  W25, W7, W13
    CRC32H  W5, W13, W25
    LSR  W21, W14, W22
    LSLV  X7, X5, X18
    MOV  W16, W2
    CRC32H  W6, W7, W21
    CRC32CB  W12, W16, W22
    LSL  W2, W19, W12
    LSRV  W11, W5, W13
    CRC32W  W7, W21, W19
    CRC32X  W3, W13, X11
    LSL  X19, X4, #28
    CRC32H  W6, W13, W4
    LSL  X13, X21, #60
    LSL  X10, X7, #9
    LSL  W7, W20, #25
    CRC32CW  W15, W9, W18
    LSL  W9, W18, #19
    MOV  W20, W7
    LSL  W5, W2, W3
    MOV  W11, W5
    LSRV  W21, W11, W15
    CRC32X  W5, W21, X25
    LSL  X18, X9, X5
    CRC32CX  W3, W20, X6
    LSL  W7, W3, W6
    LSRV  X11, X19, X18
    LSRV  X12, X10, X3
    MOV  X12, X25
    LSR  W6, W7, W3
    MOVZ  W10, #0x261e, LSL #0
    MOV  W16, W18
    MOVN  X19, #0x4fa9, LSL #32
    LSL  X3, X5, X6
    CRC32X  W7, W11, X14
    MOVK  X20, #0x7581, LSL #16
    CRC32W  W20, W10, W16
    LSL  W14, W12, #7
    LSR  W10, W18, W4
    CRC32CX  W9, W3, X3
    CRC32CW  W10, W10, W9
    LSL  X21, X4, X22
    MOV  X18, X10
    LSRV  X12, X19, X10
    LSR  X16, X12, #0xf
    CRC32CB  W9, W16, W3
    LSR  W18, W22, W11
    LSLV  W6, W11, W25
    MOVN  X19, #0x39b6, LSL #16
    LSL  W21, W14, W18
    CRC32CB  W18, W19, W9
    MOVN  X5, #0x5d17, LSL #16
    MOVK  W25, #0xdc67, LSL #16
    MOVZ  X10, #0x5157, LSL #0
    LSRV  X2, X19, X20
    CRC32H  W16, W6, W21
    LSRV  X9, X4, X2
    CRC32B  W19, W9, W5
    MOV  X11, X7
    LSL  W2, W13, W11
    LSL  W5, W7, #9
    MOV  X9, X10
    CRC32B  W11, W12, W21
    LSR  W18, W19, #0x17
    LSLV  X13, X14, X2
    MOV  X5, X13
    LSLV  X20, X13, X12
    LSR  W6, W10, W9
    CRC32CX  W19, W20, X16
    CRC32CH  W16, W5, W25
    MOVK  X25, #0xeb8f, LSL #48
    LSLV  X13, X19, X16
    CRC32CB  W9, W12, W9
    LSL  W19, W22, #26
    MOV  W14, W6
    MOVZ  W16, #0x37ac, LSL #0
    MOV  W20, W13
    CRC32CB  W12, W25, W20
    MOV  W10, W14
    LSR  W14, W9, W20
    MOVK  W20, #0x243f, LSL #16
    LSL  X6, X4, X6
    MOV  X7, X14
    MOVZ  X9, #0x7b1b, LSL #32
    CRC32B  W6, W18, W18
    CRC32CX  W22, W16, X7
    CRC32W  W14, W12, W19
    MOVZ  X12, #0x41a4, LSL #48
    LSR  X19, X20, X18
    CRC32H  W18, W19, W9
    CRC32CX  W16, W11, X14
    CRC32CX  W25, W16, X22
    MOVK  W20, #0x3a3, LSL #0
    MOV  X19, X15
    LSL  W22, W6, #5
    CRC32CB  W21, W20, W25
    MOVZ  W25, #0x89fd, LSL #0
    MOVK  X2, #0xdf43, LSL #16
    MOV  W18, W13
    MOVZ  X6, #0xafb7, LSL #0
    MOVK  X14, #0x595b, LSL #32
    MOV  X11, X6
    MOVZ  W2, #0x4871, LSL #0
    CRC32CH  W7, W12, W18
    CRC32B  W20, W25, W2
    MOVZ  W13, #0x387e, LSL #16
    MOV  W25, W23
    LSR  X18, X14, #0x3d
    MOV  W2, W7
    LSRV  X12, X14, X2
    LSL  X6, X10, X20
    CRC32W  W7, W25, W11
    MOV  W23, W22
    MOVN  X20, #0xf47c, LSL #16
    CRC32CX  W25, W13, X19
    LSRV  X14, X25, X23
    LSR  X2, X7, X5
    MOVK  X22, #0xa1f8, LSL #0
    LSR  W5, W7, W12
    CRC32CX  W10, W13, X16
    MOV  X5, X20
    MOV  W7, W2
    MOVN  W23, #0x297c, LSL #0
    CRC32X  W19, W14, X23
    LSR  W2, W22, W22
    LSL  X12, X14, X19
    MOVK  X22, #0x2745, LSL #16
    LSL  W14, W7, #7
    LSLV  W20, W4, W13
    LSLV  X16, X5, X10
    CRC32H  W23, W3, W22
    LSR  W13, W16, #0x1c
    MOV  W22, W14
    LSL  X16, X18, X12
    MOVN  W19, #0x819a, LSL #16
    CRC32H  W14, W3, W23
    LSR  X5, X2, #0x14
    CRC32H  W10, W22, W5
    LSRV  X23, X10, X20
    LSRV  X21, X13, X13
    CRC32H  W23, W14, W23
    MOVK  W13, #0xcd05, LSL #0
    LSRV  W20, W19, W21
    LSRV  X21, X11, X23
    MOV  X10, X13
    CRC32CW  W21, W19, W21
    CRC32W  W16, W15, W18
    CRC32CW  W22, W10, W21
    LSLV  X10, X20, X20
    CRC32B  W19, W10, W7
    LSL  X5, X22, #36
    LSR  X23, X16, X12
    MOV  W21, W22
    MOV  W16, W21
    LSL  W14, W16, W13
    LSL  X22, X21, #4
    MOVZ  W16, #0xb718, LSL #16
    CRC32W  W5, W22, W23
    MOVZ  X15, #0x6f9f, LSL #0
    CRC32CH  W11, W15, W19
    LSL  W21, W14, #30
    LSR  X22, X21, #0x1f
    CRC32B  W7, W10, W22
    CRC32CX  W15, W11, X23
    MOVN  W2, #0x731d, LSL #16
    LSR  W23, W12, #0x8
    MOV  X13, X2
    CRC32H  W18, W6, W5
    SUBS  X4, X4, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_6
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0x8ce2, LSL #16
    SUB  X8, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x454a, LSL #0
    MOVK  X17, #0xb4ba, LSL #16
    SUB  X8, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x71ec, LSL #0
    MOVK  X17, #0xb3e0, LSL #16
    SUB  X8, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x7b1b, LSL #32
    SUB  X8, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x8000, LSL #48
    SUB  X8, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x522c, LSL #0
    MOVK  X17, #0xaa13, LSL #16
    SUB  X8, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0xde60, LSL #0
    MOVK  X17, #0x36e2, LSL #16
    MOVK  X17, #0x1, LSL #32
    SUB  X8, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0x8ce2, LSL #16
    SUB  X8, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x9820, LSL #0
    MOVK  X17, #0x6035, LSL #16
    SUB  X8, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x844, LSL #0
    MOVK  X17, #0x6c33, LSL #16
    SUB  X8, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xb718, LSL #16
    SUB  X8, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0xfd4a, LSL #0
    MOVK  X17, #0xd5c9, LSL #16
    SUB  X8, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x7cc9, LSL #0
    MOVK  X17, #0xdd0d, LSL #16
    SUB  X8, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0x7e65, LSL #16
    SUB  X8, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0xe2de, LSL #0
    MOVK  X17, #0x36, LSL #16
    SUB  X8, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X17, #0x2de6, LSL #0
    MOVK  X17, #0x136e, LSL #16
    SUB  X8, X17, X25
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
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    MOVZ  X7, #0xa, LSL #0
TSRTIntCRCAndShiftAndMov_label_7:
    LSLV  W10, W25, W25
    MOVK  W14, #0x423b, LSL #16
    MOVN  W25, #0x9fd3, LSL #0
    CRC32X  W6, W14, X19
    MOVK  W17, #0x5a20, LSL #0
    CRC32B  W13, W16, W15
    MOV  X19, X7
    MOV  X20, X2
    LSL  X4, X17, #28
    CRC32X  W19, W16, X13
    LSR  X12, X19, X21
    MOVN  W4, #0x2ea4, LSL #16
    LSLV  W19, W10, W6
    MOV  W5, W14
    MOVN  X21, #0xe1d1, LSL #0
    MOVZ  X5, #0xf797, LSL #16
    CRC32CH  W12, W13, W2
    MOVN  W10, #0x86ca, LSL #16
    CRC32CX  W4, W20, X2
    MOVK  W15, #0xfa1b, LSL #16
    CRC32CW  W5, W18, W5
    MOV  W25, W4
    MOVZ  W14, #0xe651, LSL #0
    LSRV  W25, W17, W14
    CRC32W  W8, W19, W15
    LSLV  W10, W14, W20
    LSL  X3, X2, X25
    LSL  W11, W21, #19
    LSL  X3, X13, X11
    MOVK  X25, #0x749a, LSL #16
    CRC32CH  W21, W5, W14
    LSL  X16, X6, X12
    LSLV  W18, W3, W16
    LSLV  X15, X15, X25
    MOVK  W25, #0x19, LSL #16
    CRC32B  W14, W25, W4
    LSR  W20, W25, W8
    CRC32CX  W14, W11, X12
    CRC32CX  W2, W12, X6
    LSLV  X4, X21, X21
    CRC32CH  W8, W16, W14
    CRC32CH  W14, W10, W4
    CRC32CH  W5, W15, W18
    LSL  X13, X6, X2
    CRC32W  W3, W8, W20
    LSL  X2, X14, X21
    MOVN  X11, #0xc1c7, LSL #32
    MOVN  X3, #0xe94e, LSL #48
    MOV  W21, W21
    LSRV  X14, X2, X2
    LSR  X17, X18, #0x2e
    LSRV  W10, W8, W11
    LSLV  W12, W8, W13
    LSL  W16, W3, W3
    CRC32B  W3, W10, W14
    LSL  W2, W21, W9
    MOV  W8, W21
    MOV  X11, X2
    MOVZ  W18, #0xf8cd, LSL #0
    LSR  W9, W19, #0x13
    MOV  W16, W12
    MOV  W14, W14
    CRC32CB  W21, W18, W9
    LSR  X19, X21, #0xd
    LSL  W15, W8, #1
    MOV  W11, W15
    CRC32B  W15, W5, W14
    CRC32W  W12, W3, W25
    LSL  X21, X11, #33
    MOV  X18, X10
    LSL  W9, W8, W5
    CRC32X  W8, W9, X12
    MOV  X25, X16
    LSL  X3, X17, X19
    LSLV  X9, X15, X21
    MOVK  X16, #0xd3e1, LSL #16
    MOV  X17, X5
    MOV  W12, W16
    LSR  X14, X9, #0x28
    CRC32CB  W2, W17, W14
    MOVZ  W19, #0x2e0, LSL #16
    LSLV  X8, X19, X18
    LSRV  W3, W2, W25
    MOV  X9, X3
    LSL  X18, X19, #10
    LSL  W2, W20, #20
    CRC32CH  W20, W2, W6
    CRC32H  W3, W8, W11
    MOVZ  W25, #0x5b18, LSL #0
    MOVK  W14, #0xc09e, LSL #16
    LSL  X10, X25, X12
    LSL  W13, W20, W12
    MOVN  X19, #0x6f4b, LSL #0
    CRC32H  W8, W9, W9
    CRC32X  W11, W10, X13
    CRC32CH  W25, W18, W11
    LSL  X2, X19, X19
    MOV  W4, W2
    LSL  X11, X21, #23
    CRC32CB  W13, W18, W8
    CRC32B  W18, W25, W4
    LSR  W4, W3, W14
    MOV  X21, X9
    CRC32CB  W17, W19, W21
    LSRV  X25, X13, X21
    LSRV  X9, X4, X11
    MOV  X16, X16
    LSRV  X4, X17, X21
    MOVK  X19, #0x7667, LSL #0
    MOVN  W18, #0xe1b2, LSL #16
    MOVZ  X12, #0xe5aa, LSL #16
    MOV  W6, W7
    LSLV  W13, W12, W16
    MOVK  W20, #0xba5c, LSL #0
    LSLV  W9, W4, W6
    LSL  W8, W9, #17
    LSL  X10, X13, X13
    CRC32CX  W21, W10, X8
    CRC32CH  W25, W20, W16
    MOV  X8, X18
    MOVN  W12, #0xa5f8, LSL #0
    LSL  X18, X8, X19
    LSR  W9, W8, W4
    MOV  X17, X6
    CRC32CH  W4, W11, W21
    MOVZ  X19, #0xc85, LSL #32
    CRC32CH  W2, W9, W4
    MOV  X6, X2
    LSR  X4, X6, X6
    LSLV  W8, W11, W21
    LSR  W6, W19, W17
    CRC32W  W9, W4, W8
    MOV  W21, W8
    LSLV  X6, X6, X14
    MOVK  X2, #0x88da, LSL #48
    MOV  X25, X25
    MOVK  W10, #0xa314, LSL #0
    CRC32CH  W14, W5, W25
    CRC32W  W5, W9, W10
    LSR  X10, X21, X14
    LSLV  W17, W6, W12
    LSLV  X4, X17, X18
    MOVZ  X11, #0xd794, LSL #16
    CRC32H  W4, W4, W6
    MOVZ  W15, #0x3702, LSL #16
    MOV  X19, X20
    CRC32H  W3, W2, W11
    CRC32H  W25, W19, W4
    LSL  W20, W17, W14
    MOVZ  W4, #0xc1a7, LSL #0
    MOV  X19, X5
    LSL  W17, W15, W19
    MOVK  W9, #0x2f57, LSL #16
    LSRV  W8, W12, W2
    LSLV  X21, X25, X25
    MOV  X14, X9
    LSR  W5, W8, #0x1d
    MOV  X3, X21
    LSR  X14, X14, X17
    MOVK  X25, #0x393b, LSL #48
    LSL  X8, X4, X8
    LSLV  W20, W8, W16
    LSLV  X18, X5, X13
    MOV  W6, W10
    CRC32X  W12, W20, X25
    CRC32CW  W11, W12, W3
    MOVZ  X3, #0xa19d, LSL #16
    MOVK  X20, #0x90ad, LSL #32
    MOV  X21, X20
    MOV  W19, W21
    CRC32X  W12, W11, X20
    CRC32CB  W25, W19, W12
    MOVN  X17, #0x8569, LSL #16
    CRC32CB  W21, W7, W14
    CRC32H  W2, W21, W4
    CRC32CW  W20, W21, W18
    MOV  X13, X2
    MOVN  W8, #0x87a9, LSL #0
    CRC32CB  W5, W19, W15
    LSLV  W15, W7, W10
    MOVZ  X21, #0xde5, LSL #48
    LSL  X2, X8, #23
    MOVN  X11, #0x871b, LSL #32
    MOVN  X10, #0xd9f8, LSL #0
    LSR  W20, W3, #0x3
    LSL  W16, W21, W6
    MOV  W3, W2
    MOVN  X8, #0xef59, LSL #16
    LSRV  W19, W8, W10
    CRC32W  W2, W13, W15
    MOV  X15, X14
    CRC32W  W18, W25, W2
    MOVK  W5, #0x418c, LSL #16
    CRC32H  W21, W13, W3
    CRC32CX  W12, W20, X16
    LSLV  W13, W12, W21
    LSR  X21, X4, X15
    MOVZ  X11, #0xfe64, LSL #16
    CRC32CX  W18, W19, X5
    LSL  W4, W11, #2
    SUBS  X7, X7, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_7
    MOVZ  X22, #0x7cc6, LSL #0
    MOVK  X22, #0x19cf, LSL #16
    SUB  X23, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x2b00, LSL #16
    SUB  X23, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0xf990, LSL #16
    SUB  X23, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x418c, LSL #16
    SUB  X23, X22, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X23, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X23, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0x10a6, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X23, X22, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0x965e, LSL #0
    MOVK  X22, #0x2f57, LSL #16
    SUB  X23, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0x2607, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X23, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0xfe64, LSL #16
    SUB  X23, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0xbf43, LSL #0
    MOVK  X22, #0xd616, LSL #16
    SUB  X23, X22, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0xfa18, LSL #0
    MOVK  X22, #0xb0b5, LSL #16
    SUB  X23, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0x965e, LSL #0
    MOVK  X22, #0x2f57, LSL #16
    SUB  X23, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0x965e, LSL #0
    MOVK  X22, #0x2f57, LSL #16
    SUB  X23, X22, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X23, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0x7a96, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0xc3bd, LSL #0
    MOVK  X22, #0x4d13, LSL #16
    SUB  X23, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0x4dff, LSL #0
    MOVK  X22, #0x21, LSL #16
    SUB  X23, X22, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0xa000, LSL #0
    MOVK  X22, #0x1433, LSL #16
    SUB  X23, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X23, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X22, #0x71e8, LSL #0
    MOVK  X22, #0xc8ac, LSL #16
    SUB  X23, X22, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTIntCRCAndShiftAndMov_TestFail
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
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    MOVZ  X22, #0xa, LSL #0
TSRTIntCRCAndShiftAndMov_label_8:
    MOVZ  W6, #0x1fde, LSL #0
    LSR  X21, X10, #0x3e
    MOV  W10, W21
    CRC32CW  W18, W23, W23
    LSR  X12, X10, X12
    CRC32CW  W2, W25, W18
    LSLV  X11, X22, X6
    CRC32W  W9, W2, W2
    MOV  W8, W11
    LSR  W18, W12, W16
    CRC32X  W8, W8, X9
    MOV  X12, X18
    LSRV  W4, W12, W2
    LSRV  W13, W21, W4
    LSR  W7, W13, #0x1c
    CRC32CH  W20, W18, W8
    LSR  X11, X2, #0x1
    MOVN  W19, #0x122d, LSL #0
    LSL  X2, X19, #1
    LSRV  W4, W6, W14
    CRC32H  W3, W19, W3
    CRC32H  W12, W21, W14
    MOVN  X16, #0x8aa1, LSL #0
    LSLV  W13, W4, W2
    LSRV  X9, X9, X25
    CRC32CX  W8, W20, X10
    LSRV  X6, X13, X18
    MOVK  W2, #0xa96d, LSL #16
    LSL  X25, X9, X11
    MOV  W20, W12
    CRC32W  W4, W8, W6
    LSLV  X6, X16, X4
    LSL  X4, X23, #23
    MOV  X23, X7
    CRC32CH  W16, W20, W3
    LSLV  X12, X7, X3
    MOVN  W14, #0x5de5, LSL #0
    CRC32H  W20, W6, W4
    MOVN  W2, #0xcfa6, LSL #0
    LSL  W11, W10, W14
    MOV  W14, W9
    LSL  W13, W25, #7
    MOVN  X3, #0x7f67, LSL #32
    MOV  W9, W3
    LSR  W7, W22, W11
    CRC32X  W10, W9, X9
    CRC32H  W19, W7, W7
    LSL  X18, X14, X2
    MOV  W7, W13
    LSRV  X20, X7, X20
    CRC32X  W13, W18, X12
    LSLV  W8, W10, W20
    LSL  W25, W9, #12
    MOVZ  W6, #0xef9e, LSL #16
    MOVN  X9, #0x2308, LSL #48
    LSL  W11, W13, W8
    MOV  X10, X6
    CRC32X  W2, W19, X8
    MOVK  X19, #0xa50e, LSL #16
    MOVN  X20, #0x9fd7, LSL #16
    LSLV  W8, W22, W25
    MOVZ  W3, #0x5af2, LSL #16
    CRC32CX  W6, W19, X11
    MOVN  X17, #0xf94f, LSL #0
    LSLV  X4, X16, X8
    MOV  X19, X4
    CRC32CX  W13, W12, X2
    MOVK  X7, #0x2b2d, LSL #48
    LSLV  W18, W10, W3
    CRC32CW  W14, W17, W13
    CRC32CX  W16, W9, X14
    CRC32H  W9, W8, W13
    MOV  X12, X17
    MOVN  W13, #0xfcc4, LSL #16
    MOVK  W11, #0x65bf, LSL #0
    CRC32X  W17, W20, X23
    MOV  X25, X7
    LSL  W20, W11, W17
    MOV  W7, W25
    CRC32X  W10, W3, X16
    LSL  W23, W8, #17
    LSRV  X3, X23, X25
    LSLV  X2, X7, X19
    MOV  X14, X12
    CRC32CX  W20, W14, X13
    CRC32CH  W13, W10, W18
    MOV  X19, X2
    MOVN  W11, #0x24c1, LSL #0
    MOV  W18, W14
    CRC32CB  W2, W20, W19
    LSLV  X23, X11, X2
    LSR  X20, X23, #0x9
    LSR  W19, W18, #0x16
    CRC32X  W25, W20, X3
    CRC32CW  W17, W14, W19
    LSR  X3, X9, #0xf
    MOV  W20, W25
    LSL  X16, X6, #4
    LSL  X8, X20, #11
    MOV  X20, X19
    LSL  X19, X8, X13
    LSLV  X19, X9, X19
    MOV  W14, W20
    LSR  X9, X10, X19
    MOVN  X11, #0xd875, LSL #48
    MOVZ  W2, #0xb12e, LSL #0
    LSR  W10, W3, #0xb
    LSL  W3, W14, W10
    MOVZ  W8, #0xef38, LSL #0
    CRC32X  W23, W4, X9
    LSLV  W9, W17, W2
    LSL  X10, X11, #7
    MOVZ  X18, #0xdf70, LSL #16
    MOVK  X3, #0xd39c, LSL #16
    LSRV  X2, X13, X8
    LSR  X19, X18, #0x1b
    MOV  X11, X19
    CRC32H  W17, W9, W18
    CRC32H  W25, W11, W2
    LSR  X6, X25, X19
    LSR  W25, W19, W3
    MOVZ  W18, #0x5941, LSL #16
    MOVN  W23, #0x3035, LSL #16
    MOV  X3, X23
    LSL  X19, X22, X16
    LSR  W13, W10, #0x6
    MOVZ  X4, #0x17b1, LSL #48
    CRC32X  W9, W13, X17
    LSL  W17, W18, W18
    CRC32H  W10, W4, W6
    LSR  W2, W11, W13
    MOVZ  W4, #0x7bad, LSL #16
    LSL  W23, W9, W4
    CRC32CH  W17, W2, W10
    CRC32CH  W6, W8, W3
    CRC32X  W4, W16, X25
    LSR  W14, W18, W18
    LSL  X3, X9, #5
    MOV  X11, X17
    LSR  W25, W4, W6
    MOVN  X4, #0xeadc, LSL #32
    LSL  X9, X4, #46
    CRC32CX  W17, W23, X19
    LSR  X10, X11, X13
    CRC32B  W2, W3, W4
    CRC32H  W13, W10, W16
    LSR  X19, X2, X23
    MOV  X11, X13
    CRC32B  W3, W11, W20
    MOVK  X2, #0x229a, LSL #16
    MOV  W13, W17
    CRC32CB  W16, W19, W25
    MOV  X10, X16
    MOVZ  X23, #0x6d2f, LSL #0
    LSR  W17, W2, W7
    MOVN  X4, #0x9302, LSL #48
    CRC32X  W10, W13, X23
    LSLV  X18, X21, X11
    MOVZ  W13, #0xd82b, LSL #0
    MOV  X8, X13
    LSRV  X6, X4, X2
    LSL  W11, W8, #13
    LSL  X2, X10, X10
    LSLV  X10, X18, X17
    LSL  X17, X11, #53
    CRC32B  W23, W17, W16
    CRC32CX  W25, W10, X2
    LSR  X14, X13, X20
    CRC32CB  W20, W14, W13
    LSRV  X16, X20, X20
    CRC32CX  W17, W3, X25
    LSR  X20, X3, X6
    MOVN  W10, #0x27f, LSL #16
    MOV  W2, W17
    CRC32CW  W2, W2, W2
    LSLV  X18, X12, X20
    MOVZ  W18, #0x8acd, LSL #0
    MOV  W14, W10
    LSLV  W12, W2, W14
    LSR  X17, X18, X11
    LSR  X11, X8, X2
    MOVK  W21, #0x467a, LSL #0
    CRC32X  W2, W16, X12
    LSR  X12, X23, #0x28
    CRC32CH  W25, W17, W10
    CRC32CX  W20, W21, X11
    LSL  W17, W13, #14
    LSL  X20, X11, X17
    CRC32CH  W4, W16, W22
    CRC32H  W19, W3, W19
    CRC32CW  W20, W12, W2
    CRC32CH  W13, W20, W16
    CRC32X  W23, W16, X13
    CRC32W  W20, W23, W18
    CRC32B  W11, W19, W19
    MOV  X17, X25
    LSR  X3, X20, X4
    LSR  W6, W17, #0xb
    MOVK  X25, #0x405d, LSL #0
    LSL  X3, X2, X20
    SUBS  X22, X22, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_8
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X15, #0x9877, LSL #0
    MOVK  X15, #0x13a2, LSL #16
    SUB  X5, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X15, #0x6c4c, LSL #0
    MOVK  X15, #0x4, LSL #16
    SUB  X5, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X15, #0xd82b, LSL #0
    SUB  X5, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc000, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X5, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xfd80, LSL #16
    SUB  X5, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X15, #0xeb28, LSL #0
    MOVK  X15, #0xea, LSL #16
    SUB  X5, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xfd80, LSL #16
    SUB  X5, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X15, #0x627c, LSL #0
    MOVK  X15, #0x2362, LSL #16
    SUB  X5, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X15, #0x8acd, LSL #0
    SUB  X5, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X15, #0x2869, LSL #0
    MOVK  X15, #0xeaeb, LSL #16
    SUB  X5, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X15, #0xa88d, LSL #0
    MOVK  X15, #0x6885, LSL #16
    SUB  X5, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X15, #0x467a, LSL #0
    SUB  X5, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X15, #0x405d, LSL #0
    MOVK  X15, #0x2362, LSL #16
    SUB  X5, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntCRCAndShiftAndMov_TestFail
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
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    MOVZ  X23, #0xa, LSL #0
TSRTIntCRCAndShiftAndMov_label_9:
    LSR  W4, W20, #0xf
    LSLV  X5, X13, X23
    LSL  X18, X25, #51
    MOVK  X17, #0xb78e, LSL #0
    LSL  X9, X13, X4
    LSRV  W4, W2, W25
    MOVK  X14, #0xdf0c, LSL #16
    LSL  W14, W9, W17
    CRC32CX  W12, W4, X4
    CRC32H  W17, W7, W21
    LSL  X22, X22, #21
    CRC32W  W9, W23, W22
    MOV  X14, X5
    LSL  W14, W15, #25
    LSR  X15, X4, X17
    CRC32CH  W22, W9, W18
    MOV  W9, W14
    CRC32W  W10, W12, W9
    MOVK  X16, #0x72cc, LSL #32
    MOVN  X18, #0x49a0, LSL #0
    MOVK  X15, #0x724e, LSL #0
    MOVK  W2, #0x9b3f, LSL #16
    LSR  X17, X6, X10
    MOV  X14, X2
    LSR  X25, X18, X9
    CRC32W  W2, W10, W22
    LSRV  W12, W2, W25
    LSR  W7, W12, #0x3
    MOVK  X21, #0x4b14, LSL #0
    CRC32W  W9, W2, W19
    CRC32H  W22, W14, W9
    LSR  X25, X7, #0x12
    CRC32CB  W19, W17, W23
    LSR  X9, X19, #0x3d
    MOV  X12, X22
    CRC32CX  W22, W12, X18
    LSL  W18, W9, W23
    LSRV  W2, W15, W15
    CRC32CB  W7, W16, W21
    LSRV  W17, W22, W12
    LSR  X18, X18, #0x1
    LSR  X17, X13, X2
    LSR  W14, W23, #0x16
    LSLV  X4, X19, X15
    MOVK  X6, #0x34d0, LSL #48
    CRC32X  W12, W18, X25
    LSL  X22, X7, X7
    MOVK  W12, #0xc111, LSL #16
    LSL  X9, X6, #44
    CRC32H  W15, W19, W16
    MOVK  W6, #0x9aae, LSL #0
    LSR  X2, X22, #0x10
    CRC32CX  W25, W22, X14
    CRC32CH  W16, W12, W6
    CRC32W  W12, W17, W25
    MOVZ  W8, #0xf20b, LSL #0
    LSL  W12, W9, W2
    LSL  W21, W12, #10
    CRC32B  W18, W21, W23
    MOV  W15, W16
    CRC32CH  W25, W4, W18
    LSL  X7, X15, #37
    CRC32W  W15, W8, W8
    CRC32CW  W12, W25, W17
    LSR  X25, X17, #0x1d
    CRC32CX  W18, W7, X15
    MOV  W17, W9
    LSL  W15, W10, #8
    MOVZ  X22, #0x8fff, LSL #48
    MOVN  W7, #0xfa0c, LSL #16
    MOVK  W13, #0xc124, LSL #0
    MOVN  W6, #0x7c22, LSL #0
    MOV  W19, W13
    MOVZ  X13, #0x330a, LSL #48
    MOVZ  W4, #0x818d, LSL #0
    MOVK  X21, #0x31f5, LSL #16
    LSL  X2, X19, #50
    MOVN  W10, #0xa5f8, LSL #0
    CRC32CB  W8, W7, W17
    LSLV  X14, X7, X13
    LSR  X13, X16, #0x36
    CRC32W  W16, W15, W8
    MOVN  X15, #0xca2c, LSL #48
    MOVK  W12, #0xb4a8, LSL #0
    CRC32CW  W7, W16, W2
    LSR  W5, W10, W10
    CRC32W  W21, W5, W14
    MOVZ  W19, #0x7fdf, LSL #0
    MOV  W5, W4
    CRC32CW  W22, W12, W18
    MOVZ  X25, #0xd2b6, LSL #16
    CRC32CH  W4, W25, W7
    LSRV  X16, X13, X14
    LSR  W16, W19, W16
    LSL  W10, W15, #14
    MOV  W18, W16
    MOVZ  X4, #0xbf14, LSL #0
    CRC32CX  W22, W18, X13
    LSL  W19, W22, #7
    MOV  W7, W21
    MOV  W12, W5
    CRC32H  W13, W18, W8
    MOV  X15, X7
    LSLV  X22, X9, X15
    LSR  W16, W13, #0x1d
    CRC32W  W5, W19, W4
    CRC32CB  W9, W22, W10
    LSRV  X20, X12, X5
    LSRV  X15, X20, X16
    LSL  X25, X14, X10
    CRC32CH  W7, W18, W16
    CRC32CB  W5, W17, W2
    MOV  W16, W18
    MOVK  W19, #0xda77, LSL #0
    CRC32X  W20, W21, X13
    MOV  X4, X20
    LSL  X10, X17, X4
    MOVN  X2, #0xd137, LSL #48
    LSL  W21, W10, W16
    LSR  W16, W25, W5
    MOV  X12, X20
    LSL  W13, W7, W15
    LSR  X5, X13, #0x23
    LSR  W10, W6, W8
    LSR  X17, X10, X5
    LSRV  X6, X19, X17
    MOVZ  W19, #0x2b3a, LSL #16
    MOV  W10, W2
    LSLV  X9, X6, X19
    LSL  X8, X16, X5
    LSL  X19, X5, X15
    MOVK  W17, #0xd186, LSL #0
    LSL  X7, X10, X21
    MOV  X20, X9
    LSL  X6, X7, X4
    LSRV  X14, X16, X12
    CRC32CX  W13, W14, X15
    LSL  W5, W4, W17
    MOV  X16, X7
    CRC32CH  W15, W5, W5
    LSRV  W12, W8, W4
    LSL  W17, W14, #18
    CRC32CW  W5, W6, W2
    MOV  W5, W13
    LSL  X14, X15, X20
    LSL  W25, W16, #27
    MOVK  X16, #0x14d6, LSL #0
    MOV  X22, X5
    CRC32CX  W4, W22, X25
    MOV  W2, W19
    LSL  X6, X17, #63
    CRC32B  W18, W4, W21
    LSLV  X12, X12, X18
    LSLV  X10, X5, X6
    LSL  W20, W2, #4
    LSR  X7, X18, #0x19
    CRC32H  W9, W20, W14
    MOVK  X5, #0x71aa, LSL #0
    CRC32CH  W18, W10, W12
    LSR  X2, X5, X18
    LSR  W5, W9, #0x1d
    LSR  X10, X2, #0x1e
    CRC32X  W6, W16, X13
    LSL  W25, W10, #21
    CRC32H  W22, W25, W25
    MOVK  X12, #0x5f08, LSL #0
    LSL  W18, W23, #15
    LSL  W17, W7, #29
    LSR  X19, X5, X8
    LSL  X17, X17, X19
    MOVN  X15, #0x29cf, LSL #48
    MOVK  X2, #0xa4ea, LSL #32
    CRC32CX  W10, W13, X7
    CRC32B  W14, W2, W12
    MOV  W16, W6
    CRC32B  W6, W16, W14
    MOV  W10, W15
    LSL  X9, X14, X6
    MOVZ  X19, #0x2cac, LSL #0
    CRC32CB  W16, W12, W10
    LSLV  X6, X13, X9
    LSL  W25, W17, #25
    MOVN  X13, #0xeb5e, LSL #16
    MOV  X17, X4
    MOVK  W15, #0xd14c, LSL #16
    CRC32CB  W4, W6, W15
    LSL  W2, W4, W13
    LSLV  W9, W23, W17
    CRC32H  W14, W18, W19
    LSRV  W6, W8, W2
    MOVZ  X15, #0x96a9, LSL #16
    CRC32CH  W14, W22, W9
    CRC32H  W5, W6, W25
    LSLV  W22, W16, W14
    LSL  X10, X19, X15
    MOVZ  W7, #0xa7d2, LSL #16
    LSRV  X12, X6, X10
    LSL  X20, X21, #54
    MOVN  W18, #0x5cb0, LSL #16
    CRC32CH  W10, W18, W5
    SUBS  X23, X23, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_9
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x8000, LSL #16
    SUB  X11, X3, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0x5351, LSL #0
    MOVK  X3, #0xad7d, LSL #16
    SUB  X11, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0x170c, LSL #0
    MOVK  X3, #0xbe26, LSL #16
    SUB  X11, X3, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0x5f3, LSL #16
    SUB  X11, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0xa7d2, LSL #16
    SUB  X11, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0x5f3, LSL #16
    SUB  X11, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0x80, LSL #0
    SUB  X11, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0xd57d, LSL #0
    MOVK  X3, #0x1994, LSL #16
    SUB  X11, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X11, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0x14a1, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X11, X3, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0xfaf9, LSL #0
    MOVK  X3, #0xfbc3, LSL #16
    SUB  X11, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x96a9, LSL #16
    SUB  X11, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0xbc1, LSL #0
    MOVK  X3, #0x27a4, LSL #16
    SUB  X11, X3, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0x60e7, LSL #0
    MOVK  X3, #0x81e, LSL #16
    SUB  X11, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xa34f, LSL #16
    SUB  X11, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0x2cac, LSL #0
    SUB  X11, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X11, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X11, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x8200, LSL #16
    SUB  X11, X3, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X11, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X11, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X2, #0xc1d4, LSL #0
    MOVK  X2, #0x6a2a, LSL #16
    MOVK  X2, #0x7450, LSL #32
    MOVK  X2, #0x5552, LSL #48
    MOVZ  X3, #0xd97f, LSL #0
    MOVK  X3, #0x1c04, LSL #16
    MOVK  X3, #0x799b, LSL #32
    MOVK  X3, #0xe17d, LSL #48
    MOVZ  X4, #0xbb44, LSL #0
    MOVK  X4, #0xda10, LSL #16
    MOVK  X4, #0x4adb, LSL #32
    MOVK  X4, #0xb3bb, LSL #48
    MOVZ  X5, #0x6c7b, LSL #0
    MOVK  X5, #0x6a05, LSL #16
    MOVK  X5, #0x53ea, LSL #32
    MOVK  X5, #0xf02b, LSL #48
    MOVZ  X6, #0x8ce, LSL #0
    MOVK  X6, #0xf674, LSL #16
    MOVK  X6, #0x162b, LSL #32
    MOVK  X6, #0x7b94, LSL #48
    MOVZ  X7, #0xcca7, LSL #0
    MOVK  X7, #0x95a, LSL #16
    MOVK  X7, #0xe373, LSL #32
    MOVK  X7, #0x5a6b, LSL #48
    MOVZ  X8, #0x2dc, LSL #0
    MOVK  X8, #0x1340, LSL #16
    MOVK  X8, #0x49a, LSL #32
    MOVK  X8, #0x27e3, LSL #48
    MOVZ  X9, #0x6de5, LSL #0
    MOVK  X9, #0x4c34, LSL #16
    MOVK  X9, #0xf03f, LSL #32
    MOVK  X9, #0x8dbd, LSL #48
    MOVZ  X10, #0xf00, LSL #0
    MOVK  X10, #0xf5e6, LSL #16
    MOVK  X10, #0xbe26, LSL #32
    MOVK  X10, #0x9fcc, LSL #48
    MOVZ  X11, #0xe11f, LSL #0
    MOVK  X11, #0xd1a1, LSL #16
    MOVK  X11, #0xc520, LSL #32
    MOVK  X11, #0xa1ff, LSL #48
    MOVZ  X12, #0x223c, LSL #0
    MOVK  X12, #0x861a, LSL #16
    MOVK  X12, #0x94bb, LSL #32
    MOVK  X12, #0x179, LSL #48
    MOVZ  X13, #0xa7c1, LSL #0
    MOVK  X13, #0xc4f7, LSL #16
    MOVK  X13, #0x18ae, LSL #32
    MOVK  X13, #0xf2b2, LSL #48
    MOVZ  X14, #0xa3a, LSL #0
    MOVK  X14, #0xcabd, LSL #16
    MOVK  X14, #0x83d4, LSL #32
    MOVK  X14, #0x779f, LSL #48
    MOVZ  X15, #0x8d77, LSL #0
    MOVK  X15, #0x6222, LSL #16
    MOVK  X15, #0xe801, LSL #32
    MOVK  X15, #0xa292, LSL #48
    MOVZ  X16, #0xda86, LSL #0
    MOVK  X16, #0x6370, LSL #16
    MOVK  X16, #0x1728, LSL #32
    MOVK  X16, #0x949e, LSL #48
    MOVZ  X17, #0xeb6, LSL #0
    MOVK  X17, #0x37e6, LSL #16
    MOVK  X17, #0x7680, LSL #32
    MOVK  X17, #0xaea, LSL #48
    MOVZ  X18, #0x331b, LSL #0
    MOVK  X18, #0x1b0a, LSL #16
    MOVK  X18, #0xc7fe, LSL #32
    MOVK  X18, #0x512e, LSL #48
    MOVZ  X19, #0xf8c6, LSL #0
    MOVK  X19, #0xaa8c, LSL #16
    MOVK  X19, #0x3126, LSL #32
    MOVK  X19, #0xd277, LSL #48
    MOVZ  X20, #0xf6bf, LSL #0
    MOVK  X20, #0xe24f, LSL #16
    MOVK  X20, #0xd9fb, LSL #32
    MOVK  X20, #0x5bb9, LSL #48
    MOVZ  X21, #0x4131, LSL #0
    MOVK  X21, #0x8170, LSL #16
    MOVK  X21, #0x6a70, LSL #32
    MOVK  X21, #0xd3ac, LSL #48
    MOVZ  X22, #0xa678, LSL #0
    MOVK  X22, #0xf2a7, LSL #16
    MOVK  X22, #0xab6e, LSL #32
    MOVK  X22, #0x40b9, LSL #48
    MOVZ  X23, #0x8edc, LSL #0
    MOVK  X23, #0x8e86, LSL #16
    MOVK  X23, #0x4515, LSL #32
    MOVK  X23, #0x8780, LSL #48
    MOVZ  X25, #0xae8f, LSL #0
    MOVK  X25, #0x5f46, LSL #16
    MOVK  X25, #0x2613, LSL #32
    MOVK  X25, #0xbd04, LSL #48
    MOVZ  X23, #0xa, LSL #0
TSRTIntCRCAndShiftAndMov_label_10:
    MOV  W15, W20
    LSR  W22, W4, W15
    MOV  W7, W25
    LSR  X9, X7, X4
    CRC32B  W6, W9, W9
    MOV  X20, X23
    MOV  W14, W22
    MOVN  X5, #0xa672, LSL #48
    CRC32CH  W25, W20, W14
    MOVK  W7, #0x4bf6, LSL #16
    LSLV  X2, X18, X6
    MOVK  W8, #0x94dc, LSL #16
    LSR  W22, W2, W2
    LSRV  X25, X12, X7
    MOV  X8, X25
    MOVK  X14, #0x84d7, LSL #32
    LSR  X3, X14, X9
    MOVK  X17, #0xbd83, LSL #16
    LSRV  X12, X3, X3
    MOVN  W17, #0x6535, LSL #0
    MOVZ  X2, #0x67a2, LSL #48
    MOV  W5, W22
    MOVN  X12, #0x89d9, LSL #0
    LSR  W20, W5, #0x1a
    CRC32W  W6, W17, W17
    MOV  X15, X20
    MOVZ  X20, #0x4eea, LSL #32
    CRC32H  W15, W15, W18
    LSR  X18, X12, #0xf
    LSRV  X2, X7, X14
    LSL  W4, W20, W20
    MOV  X4, X2
    LSR  W3, W20, #0xb
    MOVN  X10, #0x26b6, LSL #0
    CRC32X  W20, W22, X15
    CRC32W  W16, W20, W4
    CRC32CH  W22, W8, W15
    LSL  X6, X18, X3
    MOV  W11, W20
    LSL  W25, W10, #1
    MOV  W4, W6
    MOVN  W7, #0x188c, LSL #16
    CRC32H  W22, W9, W11
    MOVZ  X2, #0xc1e8, LSL #16
    LSRV  W17, W22, W22
    MOV  W12, W2
    MOVN  W2, #0xc139, LSL #0
    MOVZ  X18, #0x1bb7, LSL #0
    MOVZ  W25, #0x97bf, LSL #0
    CRC32CW  W3, W12, W16
    CRC32X  W12, W18, X17
    MOVK  W10, #0xae65, LSL #0
    LSLV  X17, X17, X13
    CRC32CW  W6, W7, W7
    CRC32CH  W10, W12, W25
    CRC32X  W14, W10, X2
    MOVK  W15, #0xb772, LSL #0
    MOVZ  X16, #0xc15b, LSL #0
    MOVN  W12, #0x99e9, LSL #0
    MOV  W25, W10
    MOV  X4, X15
    CRC32CB  W22, W14, W7
    MOV  X15, X7
    LSLV  W13, W4, W3
    MOV  X14, X6
    LSL  W25, W4, #1
    MOVN  W2, #0x6560, LSL #16
    CRC32H  W7, W13, W15
    MOVZ  W25, #0xc586, LSL #0
    MOVZ  W4, #0xe5c3, LSL #0
    MOVZ  W11, #0x34b4, LSL #0
    MOVN  X6, #0xaf0, LSL #0
    CRC32W  W10, W4, W4
    CRC32W  W3, W12, W4
    MOVK  W8, #0x1c89, LSL #16
    CRC32CX  W3, W25, X2
    LSL  W12, W25, W22
    CRC32W  W2, W12, W17
    CRC32CX  W13, W12, X2
    CRC32X  W5, W8, X25
    LSRV  X3, X10, X7
    CRC32CX  W14, W3, X6
    CRC32B  W4, W12, W14
    LSLV  X17, X14, X11
    LSL  W9, W5, W5
    LSRV  W22, W11, W16
    CRC32H  W16, W17, W25
    LSLV  W14, W5, W9
    CRC32CW  W2, W17, W4
    MOVZ  X15, #0x2b98, LSL #0
    LSRV  X8, X18, X20
    CRC32CX  W12, W13, X4
    MOVN  X13, #0xde71, LSL #48
    MOV  X5, X15
    LSRV  W4, W5, W2
    CRC32CW  W2, W8, W16
    CRC32B  W9, W13, W22
    MOVZ  X17, #0x475d, LSL #48
    MOV  W11, W10
    CRC32H  W18, W17, W4
    MOVZ  X5, #0x586b, LSL #48
    CRC32CB  W17, W14, W16
    CRC32CX  W25, W13, X5
    CRC32CW  W2, W12, W11
    MOVZ  W15, #0x9d, LSL #0
    LSR  X12, X25, X17
    LSLV  W25, W18, W4
    LSRV  W5, W6, W12
    CRC32CH  W22, W2, W2
    MOVN  X16, #0xfbaf, LSL #16
    LSL  X10, X16, #23
    LSLV  W8, W22, W17
    CRC32CW  W14, W23, W8
    MOV  X2, X14
    MOVZ  W9, #0x96f9, LSL #16
    CRC32CW  W12, W4, W5
    CRC32B  W18, W6, W9
    CRC32CB  W20, W10, W2
    MOV  W10, W2
    LSRV  X15, X10, X12
    MOVK  X22, #0x44b6, LSL #0
    MOVN  W2, #0x32a2, LSL #16
    CRC32CB  W9, W25, W25
    MOVZ  X15, #0x3ea4, LSL #32
    MOV  X4, X2
    CRC32CX  W16, W3, X18
    MOV  X25, X4
    LSR  W3, W20, #0xa
    CRC32H  W4, W22, W22
    LSL  W11, W11, #25
    CRC32W  W14, W11, W4
    CRC32W  W6, W2, W25
    LSL  W17, W9, #29
    CRC32X  W9, W5, X6
    CRC32W  W8, W17, W18
    LSLV  W2, W8, W6
    LSL  X22, X12, X7
    LSR  W17, W9, W15
    LSRV  X15, X3, X9
    MOV  X25, X22
    MOVZ  W10, #0xa2a5, LSL #16
    MOV  X8, X3
    MOVK  W11, #0xd06d, LSL #0
    LSR  X13, X11, X2
    CRC32CB  W3, W14, W10
    LSR  W5, W9, W25
    LSRV  X10, X15, X15
    CRC32W  W17, W3, W6
    CRC32X  W20, W17, X2
    MOV  X18, X13
    CRC32CX  W25, W16, X16
    LSL  W14, W2, #29
    CRC32CH  W7, W25, W5
    LSLV  W22, W4, W5
    MOVN  X17, #0xc21e, LSL #16
    LSRV  X9, X20, X10
    LSL  X13, X17, X22
    MOV  W17, W15
    LSLV  X12, X17, X17
    CRC32W  W15, W9, W7
    MOV  X11, X5
    MOV  X3, X10
    MOVZ  X4, #0x426c, LSL #16
    LSL  W10, W15, W9
    CRC32CH  W3, W14, W13
    LSRV  X10, X3, X4
    LSRV  W3, W18, W6
    LSR  W4, W22, W3
    MOVZ  X20, #0xf8fb, LSL #48
    MOVZ  X5, #0x61c7, LSL #0
    MOVZ  X13, #0x5697, LSL #48
    MOVZ  W6, #0x960b, LSL #16
    LSLV  W22, W4, W13
    MOV  W17, W22
    LSLV  W20, W25, W10
    CRC32CB  W18, W11, W4
    CRC32H  W7, W20, W6
    LSR  W11, W7, #0x9
    LSR  W20, W18, W5
    LSR  W18, W6, W17
    LSL  W22, W22, #29
    MOV  W13, W23
    CRC32CW  W18, W2, W20
    LSL  W20, W18, #18
    CRC32CB  W3, W23, W13
    CRC32CB  W17, W12, W4
    CRC32W  W4, W17, W20
    CRC32H  W18, W11, W18
    MOVZ  W4, #0x35a8, LSL #16
    LSLV  X17, X13, X3
    CRC32W  W9, W2, W22
    LSL  X12, X18, X9
    LSRV  W7, W12, W12
    MOVZ  X12, #0x521e, LSL #0
    LSR  X4, X17, X4
    LSLV  W17, W11, W4
    LSL  X9, X7, X13
    LSR  X20, X6, #0x5
    CRC32CX  W5, W9, X9
    CRC32CW  W11, W12, W20
    SUBS  X23, X23, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_10
    MOVZ  X19, #0xb8db, LSL #0
    MOVK  X19, #0x1e54, LSL #16
    SUB  X21, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X19, #0x1, LSL #0
    SUB  X21, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x960b, LSL #16
    SUB  X21, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X19, #0xd1, LSL #0
    SUB  X21, X19, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X19, #0x8dc9, LSL #0
    MOVK  X19, #0x18, LSL #16
    SUB  X21, X19, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X19, #0x1a2, LSL #0
    SUB  X21, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X19, #0x17d2, LSL #0
    MOVK  X19, #0xe9e, LSL #16
    SUB  X21, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X19, #0xd304, LSL #0
    MOVK  X19, #0xd04c, LSL #16
    SUB  X21, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X19, #0x521e, LSL #0
    SUB  X21, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X19, #0x1, LSL #0
    SUB  X21, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x6000, LSL #16
    SUB  X21, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X19, #0x771c, LSL #0
    MOVK  X19, #0x1623, LSL #16
    SUB  X21, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X19, #0x1001, LSL #0
    MOVK  X19, #0xbb1d, LSL #16
    SUB  X21, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X19, #0xd0cb, LSL #0
    MOVK  X19, #0xda3d, LSL #16
    SUB  X21, X19, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X19, #0x5800, LSL #0
    MOVK  X19, #0x4b0, LSL #16
    SUB  X21, X19, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
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
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X14, #0xa, LSL #0
TSRTIntCRCAndShiftAndMov_label_11:
    LSR  X10, X15, X12
    LSLV  X22, X13, X11
    CRC32CH  W18, W22, W14
    MOVZ  X12, #0xc9f4, LSL #48
    LSR  X23, X8, X6
    MOVN  W23, #0x3be8, LSL #0
    LSRV  X13, X18, X10
    LSR  W22, W13, W20
    LSR  X20, X21, #0x3d
    MOV  W23, W22
    LSL  W3, W18, W17
    MOVK  W3, #0x57d0, LSL #0
    LSR  X8, X23, X7
    MOV  X3, X13
    LSR  X23, X18, X12
    LSL  X6, X9, X14
    LSR  W18, W6, #0x15
    LSR  X3, X23, #0x39
    MOVZ  X17, #0x8a9f, LSL #0
    LSR  X4, X17, X11
    MOVZ  X13, #0x45cc, LSL #0
    CRC32X  W12, W13, X3
    CRC32B  W20, W12, W20
    MOV  W5, W4
    LSR  X12, X5, X20
    LSRV  W13, W12, W8
    MOVZ  W9, #0x6c68, LSL #16
    MOV  W4, W18
    CRC32B  W23, W12, W25
    MOVN  X22, #0x16f7, LSL #48
    LSRV  W5, W23, W22
    MOVZ  X25, #0x76a1, LSL #0
    MOV  X18, X9
    CRC32CW  W6, W13, W22
    MOV  W3, W25
    MOVK  W12, #0x2fdc, LSL #16
    LSL  W25, W18, #18
    MOVK  W9, #0x7280, LSL #0
    CRC32CX  W18, W5, X6
    CRC32CH  W6, W12, W25
    MOVN  W12, #0xc9a5, LSL #16
    MOV  X22, X3
    MOVZ  W13, #0x925d, LSL #16
    LSR  W8, W18, #0x8
    MOV  X5, X12
    LSRV  W3, W6, W20
    LSRV  X10, X22, X22
    LSR  X12, X12, X4
    LSL  W17, W8, #16
    CRC32CH  W11, W6, W13
    MOV  X13, X3
    LSRV  W8, W12, W10
    CRC32CH  W6, W23, W5
    MOVZ  X10, #0xad21, LSL #32
    LSRV  W13, W13, W17
    CRC32CB  W3, W6, W10
    MOVN  W17, #0x7492, LSL #0
    MOVN  W10, #0x6a01, LSL #0
    LSL  W13, W17, W11
    MOVK  W25, #0xe5a8, LSL #0
    MOVZ  W6, #0x7713, LSL #16
    CRC32W  W18, W10, W23
    LSLV  W4, W18, W23
    MOV  W20, W6
    LSL  X23, X4, #21
    MOVK  X18, #0x1d8b, LSL #48
    MOVZ  X6, #0x8061, LSL #48
    CRC32X  W23, W20, X20
    LSR  X6, X7, X6
    MOVK  W7, #0x7532, LSL #0
    LSL  W10, W23, W15
    LSLV  X25, X17, X13
    MOVK  W15, #0x1a, LSL #16
    LSL  W20, W10, #8
    LSR  W6, W13, W7
    MOV  W9, W8
    CRC32CX  W17, W6, X20
    CRC32W  W11, W17, W9
    MOVN  X6, #0x97ee, LSL #32
    LSR  X9, X18, X6
    MOV  W8, W9
    LSR  W9, W15, W13
    LSR  X13, X3, #0x33
    MOV  W4, W11
    LSR  X7, X9, X8
    CRC32B  W3, W13, W9
    LSR  W15, W25, W22
    LSL  X11, X15, X20
    MOV  W8, W22
    LSRV  W18, W11, W3
    CRC32CW  W3, W7, W7
    MOVK  X6, #0xc242, LSL #48
    CRC32CH  W11, W3, W22
    LSL  X25, X8, #6
    LSR  W22, W12, W11
    MOVN  W8, #0xb406, LSL #16
    MOV  W20, W18
    CRC32CB  W20, W20, W6
    MOVK  W12, #0x7ac1, LSL #0
    LSLV  W11, W15, W5
    CRC32CW  W22, W25, W25
    CRC32H  W15, W23, W8
    LSLV  X17, X8, X4
    LSR  W9, W15, W20
    LSLV  X8, X6, X12
    LSLV  X5, X15, X15
    CRC32CX  W15, W21, X5
    LSR  X12, X15, #0x2
    CRC32CX  W7, W9, X22
    MOVK  W2, #0x3773, LSL #0
    MOVN  X6, #0xb0ea, LSL #48
    CRC32W  W13, W6, W2
    CRC32CW  W6, W13, W8
    CRC32CW  W10, W6, W6
    CRC32H  W5, W10, W12
    MOV  X18, X14
    CRC32X  W8, W10, X7
    MOVN  W2, #0x5e11, LSL #0
    LSRV  X13, X4, X18
    MOVN  W23, #0x78b6, LSL #16
    MOVN  W23, #0x8647, LSL #16
    MOVZ  X6, #0x402a, LSL #0
    LSL  W18, W5, #18
    MOVN  X9, #0x2ff, LSL #16
    LSR  X18, X6, #0x39
    LSRV  X21, X9, X8
    LSL  W7, W4, #26
    CRC32H  W10, W23, W4
    MOVK  X4, #0x97df, LSL #16
    MOV  X4, X2
    MOVN  X23, #0x884, LSL #0
    MOV  X2, X4
    CRC32CX  W4, W2, X21
    LSRV  X5, X17, X6
    MOV  W21, W12
    MOVK  W2, #0x9578, LSL #0
    LSLV  W17, W7, W12
    LSL  W23, W3, W21
    MOVZ  W11, #0x739c, LSL #16
    CRC32CX  W9, W23, X23
    MOVN  X12, #0x6c78, LSL #48
    CRC32X  W22, W2, X17
    CRC32W  W17, W21, W5
    MOVN  W3, #0x39c6, LSL #16
    LSR  W10, W13, #0x1a
    MOV  W21, W5
    CRC32CB  W13, W21, W10
    MOV  W5, W11
    LSR  W20, W12, #0x1
    CRC32W  W12, W4, W9
    LSL  W22, W3, W13
    MOVZ  X17, #0x359f, LSL #48
    MOVZ  W9, #0x110c, LSL #16
    LSR  W10, W20, #0xe
    MOV  X4, X2
    LSLV  W8, W22, W12
    MOV  W13, W17
    MOVK  W13, #0x2fd9, LSL #0
    MOVZ  X7, #0x9d6b, LSL #16
    LSL  W2, W14, #19
    MOVZ  W22, #0xde83, LSL #16
    LSRV  W6, W4, W9
    CRC32H  W9, W7, W10
    LSR  W17, W8, W4
    CRC32X  W6, W5, X22
    CRC32W  W12, W9, W2
    MOVN  X9, #0xc63d, LSL #0
    LSR  X20, X12, #0x31
    CRC32CB  W23, W6, W6
    MOVN  X6, #0xae59, LSL #0
    CRC32CH  W2, W9, W23
    LSL  X3, X6, X2
    CRC32CB  W6, W6, W13
    CRC32CB  W17, W20, W6
    CRC32CH  W5, W11, W3
    MOVK  X21, #0xd7fe, LSL #32
    LSRV  X22, X2, X21
    CRC32X  W6, W17, X4
    MOVK  X7, #0xb89d, LSL #0
    LSR  X2, X14, X10
    MOV  W9, W14
    LSLV  W8, W18, W18
    LSR  X12, X4, X20
    MOV  X23, X25
    LSL  W21, W12, #31
    CRC32H  W3, W25, W5
    LSL  X17, X21, #54
    CRC32H  W3, W22, W3
    MOV  X5, X8
    LSLV  W10, W17, W3
    MOVK  W21, #0xa7d9, LSL #0
    MOVK  X10, #0xc81e, LSL #48
    MOVZ  W15, #0xa125, LSL #0
    LSRV  W8, W10, W2
    MOV  X4, X20
    LSR  X12, X25, X6
    CRC32CX  W10, W15, X4
    MOV  X3, X15
    LSLV  W20, W23, W8
    CRC32CH  W22, W7, W5
    SUBS  X14, X14, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_11
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X16, #0xa125, LSL #0
    SUB  X19, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X16, #0x2d45, LSL #0
    MOVK  X16, #0xe826, LSL #16
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X16, #0xb89d, LSL #0
    MOVK  X16, #0x9d6b, LSL #16
    SUB  X19, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X16, #0x1, LSL #0
    SUB  X19, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X16, #0x3b52, LSL #0
    MOVK  X16, #0xc517, LSL #16
    SUB  X19, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x739c, LSL #16
    SUB  X19, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X16, #0xed42, LSL #0
    SUB  X19, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X16, #0x2fd9, LSL #0
    SUB  X19, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X16, #0xa125, LSL #0
    SUB  X19, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X16, #0xa840, LSL #0
    MOVK  X16, #0x1d, LSL #16
    SUB  X19, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X16, #0xa7d9, LSL #0
    SUB  X19, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X16, #0x8606, LSL #0
    MOVK  X16, #0x3cf6, LSL #16
    SUB  X19, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X16, #0xa840, LSL #0
    MOVK  X16, #0x1d, LSL #16
    SUB  X19, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X16, #0xa840, LSL #0
    MOVK  X16, #0x1d, LSL #16
    SUB  X19, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTIntCRCAndShiftAndMov_TestFail
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
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    MOVZ  X17, #0xa, LSL #0
TSRTIntCRCAndShiftAndMov_label_12:
    LSRV  X8, X17, X11
    MOVK  W2, #0xe0de, LSL #16
    LSR  X9, X25, #0x19
    CRC32CH  W23, W19, W9
    CRC32X  W4, W22, X2
    CRC32H  W19, W4, W8
    MOVK  X14, #0x8dfa, LSL #32
    MOVZ  X13, #0xfead, LSL #48
    CRC32B  W14, W14, W13
    MOV  W19, W19
    CRC32X  W8, W14, X23
    MOVN  X22, #0x4241, LSL #48
    MOV  X4, X22
    LSLV  W8, W25, W4
    LSLV  W18, W20, W19
    MOVN  X2, #0xe8b4, LSL #32
    LSR  X12, X3, X14
    MOV  W4, W6
    LSL  W2, W4, W8
    LSLV  X12, X2, X11
    CRC32B  W10, W12, W4
    LSLV  W9, W20, W8
    LSL  W12, W15, W2
    LSL  X20, X2, X8
    MOVK  W23, #0x4db1, LSL #16
    LSRV  X13, X4, X8
    LSL  W19, W12, W5
    MOVK  W11, #0xf556, LSL #16
    LSR  W3, W18, W9
    LSR  W5, W12, #0x19
    MOV  W25, W2
    LSL  W9, W25, W9
    MOVN  X12, #0xbe32, LSL #0
    MOV  X15, X11
    LSL  W9, W20, W19
    LSLV  W4, W23, W15
    MOVZ  W20, #0xde20, LSL #16
    MOVK  X23, #0x2ad5, LSL #0
    CRC32W  W11, W17, W15
    MOV  W25, W20
    LSR  X25, X22, X10
    LSR  X16, X18, #0x29
    LSR  X15, X11, X5
    CRC32CW  W10, W20, W2
    MOVN  X8, #0xe163, LSL #48
    MOV  W2, W3
    CRC32CW  W18, W10, W3
    MOVN  X3, #0x2afe, LSL #32
    MOVN  X6, #0x41b3, LSL #0
    MOVK  W4, #0x6d82, LSL #16
    LSL  X4, X16, X8
    MOVZ  X16, #0xa2a, LSL #16
    MOVZ  X19, #0x5ea4, LSL #48
    LSR  W18, W19, W18
    CRC32CX  W8, W2, X2
    LSL  W8, W12, #25
    MOVK  X2, #0x3f3f, LSL #48
    MOVZ  W10, #0x635, LSL #16
    MOV  W22, W20
    LSLV  X5, X15, X4
    LSL  X8, X18, #28
    MOV  X20, X2
    CRC32CB  W11, W16, W5
    MOV  X19, X20
    CRC32X  W20, W20, X17
    CRC32CB  W15, W8, W8
    CRC32X  W18, W10, X25
    LSL  X5, X15, X23
    LSRV  X5, X5, X11
    LSRV  W23, W22, W20
    MOV  X6, X19
    LSL  W2, W6, #5
    CRC32CB  W20, W23, W23
    LSLV  W12, W13, W2
    LSR  X19, X3, #0x2c
    LSL  W10, W8, W5
    CRC32W  W16, W12, W10
    CRC32H  W11, W11, W12
    LSR  W12, W12, #0x3
    LSLV  W16, W11, W19
    CRC32CH  W4, W4, W23
    LSLV  W23, W9, W2
    CRC32H  W15, W12, W16
    CRC32H  W6, W20, W18
    LSL  W4, W6, #29
    MOV  W6, W15
    CRC32CX  W25, W3, X9
    MOV  W9, W6
    MOVK  W11, #0xfb5, LSL #0
    MOVZ  W14, #0x93ec, LSL #16
    LSR  W16, W14, W6
    MOVN  W22, #0x9fd9, LSL #0
    MOV  W15, W22
    CRC32B  W5, W25, W11
    LSR  W19, W6, #0x17
    MOVN  X6, #0xb7e0, LSL #32
    LSR  W20, W19, #0x9
    CRC32X  W22, W5, X15
    MOV  W14, W12
    LSL  W12, W23, W22
    MOVN  X3, #0x5ad5, LSL #0
    LSL  W2, W2, W14
    LSL  X25, X16, #49
    MOV  X19, X3
    MOV  W5, W2
    LSR  W20, W16, W19
    CRC32CB  W10, W6, W20
    LSRV  X3, X10, X25
    LSL  W20, W12, W10
    MOV  W16, W3
    MOV  X6, X16
    MOVK  W11, #0x4d0c, LSL #16
    LSRV  W12, W2, W5
    MOV  W16, W12
    LSR  W5, W11, #0x5
    CRC32H  W12, W11, W16
    MOVN  W23, #0x3b60, LSL #0
    LSL  X14, X15, X12
    LSL  W3, W25, W11
    MOV  W22, W20
    CRC32X  W4, W14, X5
    MOV  X19, X4
    CRC32CX  W12, W3, X22
    LSR  X4, X18, X13
    LSR  X25, X16, #0x2f
    LSR  X11, X23, X19
    LSR  W13, W12, W17
    LSR  W15, W6, W6
    LSLV  X2, X25, X13
    MOV  X25, X19
    LSRV  X8, X25, X2
    LSR  X20, X2, X15
    CRC32H  W13, W20, W10
    LSLV  W12, W6, W17
    CRC32B  W14, W13, W13
    LSR  W14, W19, #0xc
    CRC32H  W19, W14, W3
    LSL  W3, W8, W12
    CRC32CH  W9, W12, W16
    MOV  W23, W3
    LSR  W2, W4, W22
    MOV  X19, X23
    LSL  W18, W11, #18
    LSR  W12, W19, #0x13
    LSR  W25, W16, #0x10
    MOVN  W5, #0x592e, LSL #0
    LSL  X15, X18, #25
    CRC32CH  W19, W15, W15
    MOVK  W4, #0xa4e0, LSL #16
    CRC32CH  W20, W5, W22
    LSL  W22, W4, W3
    LSL  W4, W22, #28
    CRC32H  W12, W19, W20
    MOVZ  X8, #0x7f11, LSL #16
    LSLV  W22, W9, W2
    LSL  W15, W25, W17
    MOVN  W5, #0xc2a8, LSL #16
    CRC32B  W23, W4, W5
    CRC32CH  W3, W20, W23
    LSLV  W9, W3, W15
    LSL  W4, W22, W20
    LSLV  X16, X8, X17
    LSLV  W5, W14, W8
    MOVK  W20, #0x3e8a, LSL #0
    LSLV  X25, X4, X9
    LSLV  X14, X22, X12
    MOV  W2, W16
    MOVN  X15, #0xb446, LSL #48
    LSL  X19, X15, #28
    CRC32CB  W15, W23, W25
    CRC32CH  W2, W14, W6
    MOV  X8, X5
    CRC32B  W23, W20, W20
    MOVN  W4, #0xb0a0, LSL #16
    LSL  W12, W4, W9
    MOVN  X25, #0x39b, LSL #16
    CRC32CB  W4, W2, W2
    CRC32X  W16, W6, X25
    MOV  W23, W8
    MOV  X22, X19
    LSLV  W5, W15, W16
    MOVZ  X20, #0x5486, LSL #16
    MOVN  W22, #0xcae1, LSL #16
    MOV  X15, X11
    LSR  X2, X22, X25
    LSL  X16, X19, #13
    LSL  W19, W23, W12
    LSRV  X5, X5, X4
    MOV  W4, W5
    MOV  X11, X20
    MOVK  W6, #0x2cda, LSL #0
    LSR  X23, X19, X11
    LSR  X10, X3, X16
    CRC32W  W15, W23, W6
    MOVN  X25, #0x892b, LSL #0
    MOV  X18, X25
    MOVN  W12, #0x3214, LSL #16
    LSLV  X5, X11, X12
    CRC32B  W6, W12, W12
    LSRV  W22, W2, W6
    SUBS  X17, X17, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_12
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0xd41b, LSL #0
    MOVK  X7, #0xfeb7, LSL #16
    SUB  X21, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0xebff, LSL #0
    MOVK  X7, #0xcd, LSL #16
    SUB  X21, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x2841, LSL #0
    MOVK  X7, #0x2, LSL #16
    SUB  X21, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0xd41b, LSL #0
    MOVK  X7, #0xfeb7, LSL #16
    SUB  X21, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0xd41b, LSL #0
    MOVK  X7, #0xfeb7, LSL #16
    SUB  X21, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x5486, LSL #16
    SUB  X21, X7, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xcdeb, LSL #16
    SUB  X21, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x5899, LSL #0
    MOVK  X7, #0x379, LSL #16
    SUB  X21, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x5000, LSL #16
    MOVK  X7, #0x90f, LSL #32
    MOVK  X7, #0x454, LSL #48
    SUB  X21, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0xd40f, LSL #0
    MOVK  X7, #0x2c9c, LSL #16
    SUB  X21, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xfe00, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X21, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x76d4, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X21, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x2841, LSL #0
    MOVK  X7, #0x2, LSL #16
    SUB  X21, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x5486, LSL #16
    SUB  X21, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x2841, LSL #0
    MOVK  X7, #0x2, LSL #16
    SUB  X21, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X7, #0x76d4, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X21, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntCRCAndShiftAndMov_TestFail
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
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    MOVZ  X4, #0xa, LSL #0
TSRTIntCRCAndShiftAndMov_label_13:
    CRC32X  W3, W8, X6
    LSR  W2, W25, W3
    MOVZ  X15, #0xcc6, LSL #0
    LSL  X20, X15, #42
    LSL  X2, X22, X18
    LSR  X7, X9, X20
    LSR  W20, W4, W21
    CRC32X  W14, W22, X2
    LSR  X8, X20, X7
    LSR  W8, W10, #0x1
    LSR  W10, W6, W14
    CRC32H  W6, W8, W8
    CRC32B  W21, W6, W6
    MOVZ  W3, #0x75f9, LSL #0
    CRC32CH  W20, W16, W21
    LSR  W22, W3, #0x1a
    CRC32W  W5, W3, W10
    MOVK  W14, #0xd41e, LSL #16
    CRC32CX  W21, W22, X14
    CRC32W  W16, W3, W21
    LSR  W14, W14, W20
    MOV  W3, W5
    CRC32CB  W7, W3, W2
    CRC32B  W2, W7, W21
    LSRV  W6, W16, W13
    MOV  W12, W14
    LSR  W22, W2, W2
    LSL  X17, X22, #38
    CRC32W  W14, W17, W18
    MOV  W22, W6
    LSL  X8, X8, X14
    CRC32CW  W20, W13, W12
    CRC32CB  W5, W20, W8
    LSL  X8, X5, #35
    MOV  W3, W25
    LSL  W9, W3, W5
    CRC32CX  W16, W22, X2
    MOV  W9, W20
    MOVN  X21, #0xa308, LSL #0
    MOVK  W3, #0xdb92, LSL #0
    CRC32H  W14, W17, W16
    CRC32B  W22, W14, W17
    MOVZ  W5, #0x7b47, LSL #0
    LSLV  X12, X2, X14
    LSR  X7, X5, #0x11
    LSRV  W25, W7, W13
    CRC32CW  W10, W17, W21
    MOVZ  W13, #0xf09b, LSL #0
    CRC32CW  W2, W10, W8
    LSR  X10, X2, X25
    LSL  W10, W19, W19
    CRC32B  W5, W3, W3
    MOVN  X2, #0x97fa, LSL #0
    MOVN  X20, #0x480f, LSL #0
    LSR  W6, W22, #0x0
    CRC32B  W25, W21, W2
    CRC32X  W17, W4, X12
    LSLV  W16, W2, W17
    LSR  X17, X19, X2
    LSR  X21, X6, #0x20
    MOV  W16, W5
    MOV  W22, W21
    LSLV  W3, W17, W13
    MOVN  X7, #0x3c47, LSL #48
    MOV  W8, W25
    LSLV  W17, W16, W5
    LSL  W15, W7, W6
    MOVZ  W12, #0xab65, LSL #0
    CRC32CB  W16, W8, W10
    CRC32CB  W5, W15, W3
    MOVK  X14, #0x4736, LSL #48
    CRC32CB  W19, W5, W10
    CRC32W  W19, W19, W16
    MOVN  W2, #0x1459, LSL #16
    LSLV  X21, X7, X12
    CRC32H  W3, W22, W17
    LSLV  W5, W3, W21
    LSLV  W15, W22, W10
    LSLV  X12, X5, X5
    MOV  W17, W19
    LSRV  W22, W4, W15
    LSLV  X6, X22, X17
    CRC32B  W25, W6, W14
    MOVN  W16, #0x33be, LSL #16
    MOV  X5, X16
    CRC32CH  W19, W21, W3
    LSR  X16, X12, #0x4
    LSRV  X15, X18, X2
    MOVN  X12, #0xbaa9, LSL #32
    LSRV  X17, X4, X22
    LSR  W25, W17, W12
    LSLV  X3, X16, X15
    MOVZ  W12, #0xf308, LSL #16
    LSL  X9, X5, X19
    CRC32CB  W9, W25, W3
    LSRV  X3, X4, X12
    CRC32CB  W14, W17, W10
    CRC32CH  W7, W14, W14
    MOV  X25, X5
    CRC32CH  W21, W20, W6
    LSL  W10, W17, #11
    MOVZ  X12, #0x4dad, LSL #0
    MOVZ  X21, #0xa00b, LSL #48
    CRC32CB  W15, W20, W9
    LSL  W19, W20, W19
    CRC32H  W8, W8, W13
    MOV  W20, W8
    CRC32X  W8, W15, X15
    MOV  W5, W6
    CRC32W  W16, W5, W17
    LSL  X16, X20, #4
    MOV  X14, X8
    CRC32H  W8, W19, W7
    CRC32CH  W13, W12, W3
    CRC32B  W2, W13, W17
    MOVK  X12, #0xad61, LSL #48
    MOV  W20, W10
    LSL  X3, X18, #28
    MOV  X18, X2
    CRC32B  W20, W25, W8
    MOV  X10, X20
    CRC32CX  W21, W7, X18
    MOVK  X13, #0x1a44, LSL #16
    CRC32X  W19, W16, X12
    MOVK  X14, #0x9d0e, LSL #0
    CRC32CB  W16, W14, W25
    MOVN  X2, #0xc7ae, LSL #32
    CRC32CH  W12, W10, W3
    LSR  X10, X16, X2
    MOVK  W16, #0x71fb, LSL #0
    MOV  W13, W16
    LSRV  X16, X21, X19
    MOV  W7, W4
    MOVK  X2, #0x75e9, LSL #32
    LSLV  X16, X9, X12
    MOVN  W12, #0x1c9b, LSL #0
    MOV  X18, X10
    CRC32W  W14, W4, W12
    LSL  W3, W8, W2
    CRC32CB  W8, W13, W3
    CRC32X  W17, W7, X22
    LSLV  X2, X8, X17
    MOV  W9, W14
    MOV  X8, X9
    LSRV  W20, W16, W16
    MOV  W2, W9
    CRC32X  W12, W2, X2
    LSL  X25, X13, X2
    LSL  X16, X21, X20
    LSLV  W10, W4, W19
    CRC32W  W3, W7, W18
    MOVZ  W12, #0x1293, LSL #0
    MOVK  X17, #0xba65, LSL #32
    LSL  W20, W10, #22
    MOVN  W13, #0xd933, LSL #0
    MOV  W22, W12
    MOVN  W7, #0x7758, LSL #0
    LSL  X2, X17, #21
    LSLV  X9, X22, X8
    LSR  X19, X7, #0x1f
    MOVK  W18, #0x9616, LSL #16
    MOV  W15, W2
    CRC32W  W12, W13, W3
    CRC32H  W8, W9, W18
    CRC32W  W19, W16, W18
    CRC32W  W3, W21, W5
    LSL  W5, W3, W12
    MOVN  W17, #0x5564, LSL #0
    LSL  W18, W15, #22
    CRC32B  W7, W8, W18
    MOVN  W22, #0x4e2e, LSL #16
    LSRV  X19, X20, X19
    MOVN  X20, #0x92c5, LSL #32
    CRC32CW  W12, W22, W17
    LSRV  W21, W10, W15
    CRC32X  W17, W20, X5
    LSL  W5, W17, #23
    CRC32CH  W8, W2, W7
    LSL  W9, W18, #12
    LSL  X20, X21, X8
    MOV  X22, X5
    MOV  X6, X12
    MOVZ  X5, #0x5203, LSL #32
    MOV  W15, W5
    CRC32CB  W5, W7, W3
    CRC32CH  W7, W10, W20
    CRC32CX  W20, W6, X25
    CRC32CB  W21, W18, W7
    LSL  W17, W20, W13
    MOVN  X18, #0x3e5f, LSL #48
    CRC32CX  W13, W20, X25
    CRC32H  W6, W21, W21
    LSR  X3, X13, X6
    CRC32CW  W13, W20, W17
    MOVK  W14, #0x7441, LSL #0
    LSRV  X12, X18, X9
    CRC32H  W5, W14, W13
    CRC32B  W13, W12, W22
    LSLV  X25, X21, X8
    LSR  X10, X5, X12
    SUBS  X4, X4, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_13
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x4ca0, LSL #48
    SUB  X11, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x863e, LSL #0
    MOVK  X23, #0x6800, LSL #16
    SUB  X11, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X11, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x1506, LSL #0
    MOVK  X23, #0x4b33, LSL #16
    SUB  X11, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X11, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x1000, LSL #0
    SUB  X11, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X11, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X11, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X11, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xc1a0, LSL #48
    SUB  X11, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x1072, LSL #0
    MOVK  X23, #0x2dfd, LSL #16
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x7441, LSL #0
    MOVK  X23, #0x197a, LSL #16
    SUB  X11, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X11, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x5bac, LSL #0
    MOVK  X23, #0x47a2, LSL #16
    SUB  X11, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0xd000, LSL #0
    MOVK  X23, #0x9b45, LSL #16
    SUB  X11, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xc1a0, LSL #48
    SUB  X11, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X11, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0xb45d, LSL #0
    MOVK  X23, #0x7979, LSL #16
    SUB  X11, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X11, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x9580, LSL #16
    SUB  X11, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X11, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTIntCRCAndShiftAndMov_TestFail
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
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    MOVZ  X10, #0xa, LSL #0
TSRTIntCRCAndShiftAndMov_label_14:
    LSLV  W3, W20, W17
    CRC32X  W17, W22, X23
    MOV  W4, W25
    LSL  X11, X17, X4
    MOVZ  W7, #0xb2d5, LSL #16
    MOVZ  W21, #0xc9b5, LSL #16
    CRC32CH  W3, W11, W25
    LSL  W18, W21, #5
    MOV  X14, X17
    LSL  X6, X15, #27
    LSR  X4, X10, #0x11
    MOV  X19, X3
    MOVK  X23, #0xbadd, LSL #0
    LSR  X9, X3, #0x39
    MOV  W6, W8
    CRC32CB  W16, W19, W9
    CRC32CB  W18, W15, W23
    LSL  X17, X4, #28
    CRC32B  W19, W20, W7
    MOVK  X15, #0x860a, LSL #32
    LSR  W6, W16, #0x14
    MOV  W21, W19
    MOVZ  X19, #0x37f, LSL #16
    LSLV  X4, X9, X6
    MOVZ  W6, #0xd64d, LSL #0
    MOV  X8, X6
    MOVN  X5, #0x8f98, LSL #16
    MOV  W23, W19
    CRC32CX  W7, W14, X18
    CRC32W  W19, W15, W23
    MOVK  X5, #0x6d88, LSL #48
    MOVN  W15, #0xa324, LSL #16
    CRC32X  W23, W4, X5
    LSL  X9, X25, X15
    MOV  X15, X21
    MOV  X16, X15
    CRC32CW  W4, W16, W19
    CRC32CH  W5, W7, W17
    CRC32CW  W20, W3, W16
    MOVK  X14, #0x4e42, LSL #0
    LSL  X18, X4, #30
    LSL  W6, W17, W20
    LSR  X23, X5, X14
    CRC32CB  W25, W23, W15
    MOV  X19, X3
    MOV  X3, X9
    LSR  W14, W25, W21
    MOVN  W6, #0x889b, LSL #16
    LSLV  W3, W2, W23
    LSR  X21, X11, #0xe
    LSL  W20, W3, W18
    CRC32W  W18, W14, W19
    MOVZ  W14, #0x88, LSL #16
    LSRV  W19, W22, W8
    LSL  X3, X15, #55
    CRC32W  W8, W18, W6
    MOV  X5, X21
    CRC32CB  W25, W5, W16
    LSL  X21, X19, #35
    CRC32X  W5, W17, X21
    CRC32CX  W2, W20, X14
    LSL  W19, W15, W25
    MOVZ  W19, #0x2c0b, LSL #16
    CRC32W  W14, W2, W9
    CRC32H  W9, W8, W6
    MOVK  X5, #0xa728, LSL #48
    LSL  X18, X9, X20
    CRC32CB  W19, W21, W5
    CRC32W  W23, W3, W14
    CRC32CW  W23, W23, W18
    LSL  W15, W22, W16
    MOVZ  W14, #0x628d, LSL #0
    LSL  X2, X3, #9
    MOVN  W11, #0xdb30, LSL #0
    LSR  X19, X16, #0x9
    LSRV  W17, W9, W8
    CRC32B  W3, W25, W18
    LSL  W5, W16, W22
    LSRV  W21, W9, W7
    LSR  W15, W16, #0x16
    MOVN  X9, #0xaedb, LSL #16
    LSR  W11, W8, W14
    MOV  W2, W23
    CRC32X  W23, W11, X9
    LSL  X7, X3, #8
    LSL  X8, X19, X7
    LSR  X25, X21, #0x1f
    CRC32H  W21, W4, W25
    CRC32X  W19, W7, X14
    LSL  X18, X15, #23
    LSL  W5, W25, W5
    MOVK  W7, #0xb43, LSL #0
    MOVN  X2, #0x58eb, LSL #32
    MOV  W25, W8
    MOVN  W3, #0x9e57, LSL #0
    CRC32X  W4, W7, X21
    MOV  W7, W5
    LSR  W19, W21, W18
    LSL  X16, X4, X9
    CRC32CW  W25, W9, W17
    MOV  W19, W2
    MOV  W4, W23
    MOVK  X22, #0x8cfd, LSL #32
    MOV  W18, W25
    MOV  W15, W3
    LSRV  X19, X16, X15
    MOV  X3, X19
    CRC32B  W8, W22, W18
    CRC32H  W9, W5, W11
    MOVZ  W16, #0xc579, LSL #0
    MOVN  X25, #0x947f, LSL #32
    MOV  W5, W9
    MOVK  X23, #0xd4d5, LSL #32
    CRC32X  W14, W8, X25
    LSR  W18, W3, #0x10
    CRC32H  W11, W14, W4
    CRC32B  W15, W11, W18
    LSL  W6, W2, W15
    LSR  X15, X6, X5
    LSRV  W3, W3, W15
    CRC32CB  W14, W3, W16
    CRC32X  W18, W14, X23
    CRC32CX  W9, W19, X25
    LSL  W25, W20, W18
    LSLV  W5, W8, W5
    LSR  W17, W15, #0x1a
    LSLV  X14, X4, X17
    LSL  X15, X7, X23
    MOVK  X16, #0xa1d6, LSL #0
    MOV  X4, X9
    LSR  W2, W11, W21
    LSR  W7, W7, #0x8
    MOVN  W23, #0x5d5a, LSL #0
    CRC32CH  W6, W14, W6
    MOV  X16, X5
    MOVN  X5, #0x3a2d, LSL #32
    CRC32CX  W21, W23, X25
    CRC32CH  W20, W2, W5
    LSL  W19, W21, #28
    MOVK  W25, #0x1c06, LSL #0
    CRC32X  W9, W4, X6
    LSR  W8, W19, W23
    LSL  W17, W2, W15
    MOV  W22, W2
    LSRV  W21, W22, W25
    LSRV  W6, W9, W18
    LSLV  W5, W7, W17
    LSL  W25, W21, #7
    CRC32W  W7, W20, W4
    LSL  W11, W20, #10
    LSLV  W19, W10, W8
    LSLV  X8, X11, X7
    MOVZ  X15, #0x6d3f, LSL #32
    CRC32CX  W11, W17, X6
    LSR  X23, X11, X19
    MOV  W17, W25
    MOVN  W11, #0x7c64, LSL #0
    LSL  W6, W17, #17
    MOVK  W18, #0x5df, LSL #0
    CRC32B  W7, W18, W16
    MOV  X25, X6
    MOVN  X16, #0xc2e0, LSL #16
    CRC32X  W21, W18, X8
    CRC32CH  W4, W18, W10
    LSRV  X6, X7, X16
    LSL  W7, W9, #15
    CRC32CW  W9, W15, W4
    CRC32CB  W22, W23, W14
    CRC32B  W6, W6, W11
    MOVN  W11, #0x8509, LSL #16
    LSLV  W2, W14, W4
    MOVN  W19, #0x9fc8, LSL #16
    LSRV  W17, W6, W5
    MOVZ  X4, #0x9813, LSL #0
    MOV  X6, X3
    MOV  W15, W11
    LSL  W18, W2, #11
    LSL  X14, X25, #17
    LSL  X3, X15, X25
    MOVK  W9, #0x8c10, LSL #0
    MOV  W23, W3
    LSR  X8, X9, #0x3c
    LSR  X17, X7, X5
    LSLV  W20, W21, W8
    MOV  X25, X19
    CRC32CX  W3, W25, X6
    CRC32W  W9, W14, W14
    CRC32CW  W8, W17, W9
    MOV  W7, W7
    MOV  X9, X4
    LSR  W11, W8, W5
    MOV  X22, X7
    CRC32B  W16, W22, W3
    LSRV  W17, W11, W21
    LSL  W6, W23, #17
    MOV  W2, W20
    CRC32B  W25, W5, W23
    CRC32CX  W7, W9, X6
    LSR  W23, W19, #0xa
    LSR  W15, W23, #0xb
    SUBS  X10, X10, #0x1
    B.NE  TSRTIntCRCAndShiftAndMov_label_14
    MOVZ  X13, #0x3a55, LSL #0
    MOVK  X13, #0xf627, LSL #16
    SUB  X12, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x80d, LSL #0
    MOVK  X13, #0x8d4c, LSL #16
    SUB  X12, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x9813, LSL #0
    SUB  X12, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xfffe, LSL #16
    SUB  X12, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0xac5a, LSL #0
    MOVK  X13, #0x86c9, LSL #16
    SUB  X12, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0xbd3a, LSL #0
    MOVK  X13, #0x4106, LSL #16
    SUB  X12, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x9813, LSL #0
    SUB  X12, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0xbd3a, LSL #0
    MOVK  X13, #0x4106, LSL #16
    SUB  X12, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xb400, LSL #32
    SUB  X12, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x301, LSL #0
    SUB  X12, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x40bd, LSL #0
    MOVK  X13, #0x7e90, LSL #16
    SUB  X12, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x208, LSL #0
    SUB  X12, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x8dfc, LSL #16
    SUB  X12, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0x6037, LSL #16
    SUB  X12, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x3a55, LSL #0
    MOVK  X13, #0xf627, LSL #16
    SUB  X12, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x3a55, LSL #0
    MOVK  X13, #0xf627, LSL #16
    SUB  X12, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x213c, LSL #16
    SUB  X12, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0xdff, LSL #0
    MOVK  X13, #0x18, LSL #16
    SUB  X12, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCRCAndShiftAndMov_TestFail
    MOVZ  X13, #0xef8d, LSL #0
    MOVK  X13, #0x2d02, LSL #16
    SUB  X12, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTIntCRCAndShiftAndMov_TestFail

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
