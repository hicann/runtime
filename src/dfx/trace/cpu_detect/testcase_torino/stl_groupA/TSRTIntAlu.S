.global TSRTIntAlu

.text
.p2align 4

TSRTIntAlu:

TSRTIntAlu_TestBegin:
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
    MOVZ  X2, #0x945d, LSL #0
    MOVK  X2, #0xabb8, LSL #16
    MOVK  X2, #0xb245, LSL #32
    MOVK  X2, #0xa8d4, LSL #48
    MOVZ  X3, #0x2240, LSL #0
    MOVK  X3, #0x95c0, LSL #16
    MOVK  X3, #0x60d4, LSL #32
    MOVK  X3, #0x22fc, LSL #48
    MOVZ  X4, #0xf142, LSL #0
    MOVK  X4, #0xf255, LSL #16
    MOVK  X4, #0xb7a7, LSL #32
    MOVK  X4, #0x33a2, LSL #48
    MOVZ  X5, #0x5df5, LSL #0
    MOVK  X5, #0x96e8, LSL #16
    MOVK  X5, #0xd567, LSL #32
    MOVK  X5, #0xf466, LSL #48
    MOVZ  X6, #0xfc4b, LSL #0
    MOVK  X6, #0x9a71, LSL #16
    MOVK  X6, #0x538a, LSL #32
    MOVK  X6, #0x75df, LSL #48
    MOVZ  X7, #0x8b5d, LSL #0
    MOVK  X7, #0xb746, LSL #16
    MOVK  X7, #0xeac0, LSL #32
    MOVK  X7, #0x4ba3, LSL #48
    MOVZ  X8, #0xc756, LSL #0
    MOVK  X8, #0xfa05, LSL #16
    MOVK  X8, #0xd27, LSL #32
    MOVK  X8, #0xea2c, LSL #48
    MOVZ  X9, #0x184d, LSL #0
    MOVK  X9, #0x9c51, LSL #16
    MOVK  X9, #0x3cce, LSL #32
    MOVK  X9, #0x3373, LSL #48
    MOVZ  X10, #0xdcd4, LSL #0
    MOVK  X10, #0x1075, LSL #16
    MOVK  X10, #0x746e, LSL #32
    MOVK  X10, #0x87a8, LSL #48
    MOVZ  X11, #0xd0c2, LSL #0
    MOVK  X11, #0x9fd9, LSL #16
    MOVK  X11, #0x255d, LSL #32
    MOVK  X11, #0xf999, LSL #48
    MOVZ  X12, #0xb3af, LSL #0
    MOVK  X12, #0x2fb8, LSL #16
    MOVK  X12, #0xf755, LSL #32
    MOVK  X12, #0x1762, LSL #48
    MOVZ  X13, #0x4779, LSL #0
    MOVK  X13, #0xf63a, LSL #16
    MOVK  X13, #0x7b21, LSL #32
    MOVK  X13, #0x3f65, LSL #48
    MOVZ  X14, #0xddc6, LSL #0
    MOVK  X14, #0xb0d1, LSL #16
    MOVK  X14, #0x5824, LSL #32
    MOVK  X14, #0x17c, LSL #48
    MOVZ  X15, #0x7c1, LSL #0
    MOVK  X15, #0xab69, LSL #16
    MOVK  X15, #0xb958, LSL #32
    MOVK  X15, #0xe1e3, LSL #48
    MOVZ  X16, #0x2cca, LSL #0
    MOVK  X16, #0xf547, LSL #16
    MOVK  X16, #0xe61f, LSL #32
    MOVK  X16, #0xa6c4, LSL #48
    MOVZ  X17, #0x64f6, LSL #0
    MOVK  X17, #0x792, LSL #16
    MOVK  X17, #0x6c4c, LSL #32
    MOVK  X17, #0xc337, LSL #48
    MOVZ  X18, #0x24c7, LSL #0
    MOVK  X18, #0xa193, LSL #16
    MOVK  X18, #0x578e, LSL #32
    MOVK  X18, #0x821a, LSL #48
    MOVZ  X19, #0x22be, LSL #0
    MOVK  X19, #0xf3f8, LSL #16
    MOVK  X19, #0xfbdb, LSL #32
    MOVK  X19, #0xe9f6, LSL #48
    MOVZ  X20, #0xc29c, LSL #0
    MOVK  X20, #0xc620, LSL #16
    MOVK  X20, #0x5a02, LSL #32
    MOVK  X20, #0x9e49, LSL #48
    MOVZ  X21, #0x559c, LSL #0
    MOVK  X21, #0x83af, LSL #16
    MOVK  X21, #0xed2a, LSL #32
    MOVK  X21, #0xc307, LSL #48
    MOVZ  X22, #0x9cfd, LSL #0
    MOVK  X22, #0xd0aa, LSL #16
    MOVK  X22, #0xf555, LSL #32
    MOVK  X22, #0x838e, LSL #48
    MOVZ  X23, #0xc3ff, LSL #0
    MOVK  X23, #0x46b3, LSL #16
    MOVK  X23, #0x27ef, LSL #32
    MOVK  X23, #0x5632, LSL #48
    MOVZ  X27, #0x8c67, LSL #0
    MOVK  X27, #0xbd05, LSL #16
    MOVK  X27, #0x5fce, LSL #32
    MOVK  X27, #0x9295, LSL #48
    SUBS  W18, W27, #0x8a2
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x9868, LSL #0
    MOVK  X2, #0x7195, LSL #16
    MOVK  X2, #0x8945, LSL #32
    MOVK  X2, #0x81d3, LSL #48
    MOVZ  X3, #0xa67b, LSL #0
    MOVK  X3, #0x534a, LSL #16
    MOVK  X3, #0x5e2d, LSL #32
    MOVK  X3, #0x8512, LSL #48
    MOVZ  X4, #0x9b2f, LSL #0
    MOVK  X4, #0xcdde, LSL #16
    MOVK  X4, #0x72c3, LSL #32
    MOVK  X4, #0xcdfa, LSL #48
    MOVZ  X5, #0xcf01, LSL #0
    MOVK  X5, #0x7fa1, LSL #16
    MOVK  X5, #0x73c9, LSL #32
    MOVK  X5, #0x4e86, LSL #48
    MOVZ  X6, #0x2b20, LSL #0
    MOVK  X6, #0x3477, LSL #16
    MOVK  X6, #0x413e, LSL #32
    MOVK  X6, #0x1ea, LSL #48
    MOVZ  X7, #0x4f9a, LSL #0
    MOVK  X7, #0xaa91, LSL #16
    MOVK  X7, #0x940d, LSL #32
    MOVK  X7, #0x697d, LSL #48
    MOVZ  X8, #0x425f, LSL #0
    MOVK  X8, #0xc32, LSL #16
    MOVK  X8, #0xcd78, LSL #32
    MOVK  X8, #0x91d8, LSL #48
    MOVZ  X9, #0x1507, LSL #0
    MOVK  X9, #0xe223, LSL #16
    MOVK  X9, #0xe12d, LSL #32
    MOVK  X9, #0x55b2, LSL #48
    MOVZ  X10, #0x7c13, LSL #0
    MOVK  X10, #0x8aa8, LSL #16
    MOVK  X10, #0x8fe4, LSL #32
    MOVK  X10, #0xb19d, LSL #48
    MOVZ  X11, #0x5f3a, LSL #0
    MOVK  X11, #0xea85, LSL #16
    MOVK  X11, #0x4014, LSL #32
    MOVK  X11, #0x12b9, LSL #48
    MOVZ  X12, #0x4d42, LSL #0
    MOVK  X12, #0x63d3, LSL #16
    MOVK  X12, #0x56e6, LSL #32
    MOVK  X12, #0xbb97, LSL #48
    MOVZ  X13, #0xfbec, LSL #0
    MOVK  X13, #0x6c65, LSL #16
    MOVK  X13, #0xe361, LSL #32
    MOVK  X13, #0xfc0, LSL #48
    MOVZ  X14, #0xea43, LSL #0
    MOVK  X14, #0x2244, LSL #16
    MOVK  X14, #0xc816, LSL #32
    MOVK  X14, #0x9940, LSL #48
    MOVZ  X15, #0xe64e, LSL #0
    MOVK  X15, #0xb555, LSL #16
    MOVK  X15, #0xb6e1, LSL #32
    MOVK  X15, #0x8b1a, LSL #48
    MOVZ  X16, #0x51f8, LSL #0
    MOVK  X16, #0x94ba, LSL #16
    MOVK  X16, #0x68e9, LSL #32
    MOVK  X16, #0xb0f2, LSL #48
    MOVZ  X17, #0xb3a5, LSL #0
    MOVK  X17, #0xd034, LSL #16
    MOVK  X17, #0x9e6b, LSL #32
    MOVK  X17, #0x57ce, LSL #48
    MOVZ  X18, #0x1fa4, LSL #0
    MOVK  X18, #0xa337, LSL #16
    MOVK  X18, #0x1cdd, LSL #32
    MOVK  X18, #0x720, LSL #48
    MOVZ  X19, #0x1b3d, LSL #0
    MOVK  X19, #0x168e, LSL #16
    MOVK  X19, #0x88d, LSL #32
    MOVK  X19, #0x9815, LSL #48
    MOVZ  X20, #0x7956, LSL #0
    MOVK  X20, #0x129a, LSL #16
    MOVK  X20, #0x89d9, LSL #32
    MOVK  X20, #0x7433, LSL #48
    MOVZ  X21, #0x9a, LSL #0
    MOVK  X21, #0x4b, LSL #16
    MOVK  X21, #0x3961, LSL #32
    MOVK  X21, #0x723b, LSL #48
    MOVZ  X22, #0x2fbf, LSL #0
    MOVK  X22, #0xdf5e, LSL #16
    MOVK  X22, #0xe0f2, LSL #32
    MOVK  X22, #0x6f77, LSL #48
    MOVZ  X23, #0xb670, LSL #0
    MOVK  X23, #0xe21d, LSL #16
    MOVK  X23, #0x1566, LSL #32
    MOVK  X23, #0x36b2, LSL #48
    MOVZ  X27, #0x75b5, LSL #0
    MOVK  X27, #0x39c1, LSL #16
    MOVK  X27, #0xa663, LSL #32
    MOVK  X27, #0xf5b6, LSL #48
    ADC  W8, W21, W22
    ADC  W11, W23, W16
    ADC  W16, W8, W11
    ADC  W6, W2, W16
    ADC  W19, W5, W13
    ADC  W18, W19, W8
    ADC  W6, W23, W10
    ADC  W4, W2, W6
    ADC  W21, W15, W8
    ADC  W4, W4, W14
    ADC  X9, X4, X9
    ADC  X22, X21, X6
    ADC  X6, X19, X18
    ADC  X16, X18, X4
    ADC  X19, X2, X17
    ADC  X23, X16, X22
    ADC  X9, X2, X11
    ADC  X16, X16, X4
    ADC  X2, X23, X6
    ADC  X8, X14, X2
    ADCS  W10, W14, W22
    ADCS  W6, W7, W12
    ADCS  W13, W3, W6
    ADCS  W22, W13, W16
    ADCS  W21, W10, W8
    ADCS  W2, W9, W9
    ADCS  W13, W4, W17
    ADCS  W15, W19, W12
    ADCS  W12, W3, W22
    ADCS  W17, W13, W16
    ADCS  X18, X12, X12
    ADCS  X3, X11, X21
    ADCS  X7, X18, X15
    ADCS  X18, X3, X17
    ADCS  X21, X13, X9
    ADCS  X23, X7, X3
    ADCS  X13, X21, X21
    ADCS  X12, X16, X18
    ADCS  X21, X12, X19
    ADCS  X18, X9, X2
    ADD  W4, W13, W8, UXTB #2
    ADD  W7, W23, W4, UXTH #2
    ADD  W22, W2, W21, SXTB #4
    ADD  W16, W22, W7, SXTX #2
    ADD  W3, W8, W5, UXTW #2
    ADD  W9, W13, W3, UXTW #0
    ADD  W23, W15, W22, SXTH #1
    ADD  W21, W10, W3, SXTB #3
    ADD  W22, W19, W16, SXTW #3
    ADD  W7, W3, W16, SXTW #0
    ADD  X5, X11, W22, UXTW #1
    ADD  X11, X2, W5, UXTB #1
    ADD  X12, X11, W14, SXTB #3
    ADD  X13, X5, X22, SXTX #1
    ADD  X16, X7, W12, UXTW #1
    ADD  X3, X22, W17, UXTW #4
    ADD  X2, X6, W9, UXTH #3
    ADD  X18, X2, W13, SXTW #2
    ADD  X5, X6, W13, SXTB #0
    ADD  X4, X23, W4, SXTW #2
    ADD  W13, W18, #0x6c1
    ADD  W11, W23, #0x72e, LSL #12
    ADD  W22, W23, #0xb2b
    ADD  W9, W10, #0xf69
    ADD  W8, W4, #0x1c7, LSL #12
    ADD  W10, W8, #0xef2, LSL #12
    ADD  W8, W11, #0x35f
    ADD  W7, W9, #0xbef
    ADD  W18, W8, #0x692, LSL #12
    ADD  W8, W8, #0xa13, LSL #12
    ADD  X14, X3, #0xa1e, LSL #12
    ADD  X12, X18, #0x7f
    ADD  X9, X16, #0x4b2, LSL #12
    ADD  X3, X13, #0x306, LSL #12
    ADD  X16, X14, #0x360
    ADD  X15, X22, #0xe5a
    ADD  X2, X6, #0x980
    ADD  X21, X8, #0xf41, LSL #12
    ADD  X14, X2, #0x682, LSL #12
    ADD  X6, X12, #0xe6a, LSL #12
    ADD  W22, W5, W6, LSR #20
    ADD  W11, W15, W10, ASR #0
    ADD  W6, W7, W7, ASR #22
    ADD  W18, W6, W22, ASR #22
    ADD  W23, W16, W14, LSR #17
    ADD  W12, W22, W23, LSL #12
    ADD  W18, W13, W9, ASR #6
    ADD  W2, W18, W14, ASR #15
    ADD  W7, W11, W11, ASR #30
    ADD  W5, W11, W4, ASR #21
    ADD  X17, X8, X23, ASR #49
    ADD  X7, X3, X12, LSR #63
    ADD  X3, X10, X7, LSR #60
    ADD  X22, X2, X21, ASR #32
    ADD  X2, X5, X15, ASR #16
    ADD  X13, X2, X3, LSR #34
    ADD  X5, X13, X9, ASR #25
    ADD  X16, X4, X17, LSL #50
    ADD  X2, X21, X16, LSR #62
    ADD  X23, X18, X3, ASR #6
    ADDS  W9, W22, W22, SXTH #3
    ADDS  W11, W2, W23, SXTH #2
    ADDS  W3, W5, W15, SXTX #0
    ADDS  W2, W2, W14, UXTH #2
    ADDS  W17, W11, W13, UXTB #4
    ADDS  W22, W5, W17, SXTW #2
    ADDS  W23, W16, W9, SXTH #4
    ADDS  W7, W14, W12, UXTX #2
    ADDS  W18, W7, W23, UXTX #4
    ADDS  W13, W23, W3, UXTB #3
    ADDS  X9, X18, W22, SXTB #0
    ADDS  X9, X21, X19, SXTX #4
    ADDS  X12, X6, X2, UXTX #0
    ADDS  X3, X4, W9, SXTB #3
    ADDS  X15, X3, W4, UXTW #4
    ADDS  X2, X12, W4, UXTH #1
    ADDS  X19, X23, X15, SXTX #2
    ADDS  X10, X13, W13, SXTB #1
    ADDS  X8, X10, X17, UXTX #3
    ADDS  X13, X19, W5, SXTW #4
    ADDS  W21, W8, #0x336
    ADDS  W16, W12, #0x82b
    ADDS  W4, W16, #0x863, LSL #12
    ADDS  W16, W2, #0x76f
    ADDS  W18, W10, #0xb70, LSL #12
    ADDS  W2, W10, #0x2e4
    ADDS  W6, W4, #0xf98
    ADDS  W19, W13, #0xf49, LSL #12
    ADDS  W3, W2, #0xc27, LSL #12
    ADDS  W4, W16, #0x45d
    ADDS  X12, X6, #0x15
    ADDS  X13, X9, #0xb90, LSL #12
    ADDS  X17, X3, #0x14a, LSL #12
    ADDS  X14, X12, #0x606, LSL #12
    ADDS  X8, X17, #0x11c
    ADDS  X15, X12, #0x829
    ADDS  X17, X19, #0x8
    ADDS  X2, X17, #0xba4
    ADDS  X22, X13, #0x245
    ADDS  X13, X15, #0x12f, LSL #12
    ADDS  W12, W7, W8, LSR #9
    ADDS  W7, W12, W13, LSL #22
    ADDS  W11, W2, W14, LSL #27
    ADDS  W17, W22, W21, ASR #10
    ADDS  W2, W16, W19, LSL #6
    ADDS  W12, W13, W18, LSR #24
    ADDS  W22, W7, W12, LSL #10
    ADDS  W5, W10, W4, LSR #24
    ADDS  W14, W11, W4, LSL #29
    ADDS  W7, W18, W7, ASR #28
    ADDS  X11, X17, X3, LSL #15
    ADDS  X2, X22, X13, LSL #33
    ADDS  X18, X2, X16, LSL #40
    ADDS  X3, X7, X18, ASR #2
    ADDS  X2, X14, X14, LSL #30
    ADDS  X6, X15, X21, LSL #39
    ADDS  X9, X18, X2, ASR #38
    ADDS  X13, X11, X3, LSR #21
    ADDS  X15, X9, X6, LSL #58
    ADDS  X18, X19, X18, LSL #4
    AND  W10, W18, #0xfffffe01
    AND  W4, W2, #0xffe1ffff
    AND  W9, W5, #0x3f8
    AND  W8, W15, #0x30003
    AND  W8, W4, #0xcccccccc
    AND  W11, W19, #0xe3ffe3ff
    AND  W14, W10, #0xc0ffc0ff
    AND  W7, W8, #0x3e003e
    AND  W9, W9, #0x1000000
    AND  W22, W11, #0x3ffe0
    AND  X15, X7, #0xfe00007ffe00007f
    AND  X17, X15, #0xfffffffe00000007
    AND  X3, X17, #0xffffffffff03ffff
    AND  X2, X14, #0x1fffc0000000
    AND  X17, X3, #0xfffffffffc00
    AND  X18, X17, #0xf00000000000000f
    AND  X3, X16, #0x1c0000001c00
    AND  X11, X13, #0x700070007000700
    AND  X7, X9, #0xfc01fc01fc01fc01
    AND  X15, X3, #0xfc0ffc0ffc0ffc0f
    AND  W19, W7, W18, LSR #9
    AND  W4, W11, W21, LSL #16
    AND  W13, W2, W22, ROR #29
    AND  W21, W15, W4, ASR #26
    AND  W22, W13, W4, LSL #28
    AND  W15, W4, W14, LSR #14
    AND  W4, W15, W19, LSL #25
    AND  W7, W18, W4, LSL #15
    AND  W7, W22, W9, ASR #3
    AND  W3, W12, W21, ASR #22
    AND  X4, X6, X14, LSL #55
    AND  X16, X22, X17, ASR #43
    AND  X18, X9, X16, ROR #56
    AND  X9, X15, X13, LSR #1
    AND  X12, X5, X7, LSL #50
    AND  X12, X7, X9, ROR #42
    AND  X5, X3, X15, LSL #51
    AND  X13, X12, X7, ROR #62
    AND  X12, X23, X17, LSR #53
    AND  X16, X13, X8, LSL #60
    ANDS  W16, W13, #0x30303030
    ANDS  W22, W16, #0xe1e1e1e1
    ANDS  W3, W16, #0x2000
    ANDS  W11, W17, #0x1ff00000
    ANDS  W19, W15, #0x1f001f00
    ANDS  W8, W19, #0xf80003ff
    ANDS  W7, W3, #0x78000000
    ANDS  W12, W10, #0xffff03ff
    ANDS  W14, W12, #0xf8000
    ANDS  W9, W22, #0xfe0
    ANDS  X10, X14, #0xf7fff7fff7fff7ff
    ANDS  X8, X4, #0xfffff800ffffffff
    ANDS  X12, X7, #0x7c7c7c7c7c7c7c7c
    ANDS  X22, X11, #0xfff00000fff000
    ANDS  X2, X5, #0x1f8000001f80000
    ANDS  X6, X14, #0x7ff000007ff
    ANDS  X15, X10, #0xffffe0
    ANDS  X11, X9, #0x7ffffff87ffffff8
    ANDS  X12, X15, #0xbbbbbbbbbbbbbbbb
    ANDS  X10, X2, #0xffffffe0000
    ANDS  W4, W22, W11, LSR #0
    ANDS  W7, W6, W10, ROR #27
    ANDS  W17, W8, W13, ASR #20
    ANDS  W17, W7, W8, LSL #21
    ANDS  W9, W17, W12, ROR #12
    ANDS  W10, W3, W15, LSL #31
    ANDS  W6, W9, W18, LSL #13
    ANDS  W12, W4, W5, LSL #21
    ANDS  W19, W3, W3, ASR #23
    ANDS  W9, W12, W21, ROR #19
    ANDS  X16, X11, X7, LSL #22
    ANDS  X8, X8, X4, ROR #1
    ANDS  X18, X15, X3, ASR #16
    ANDS  X3, X19, X7, LSL #25
    ANDS  X2, X14, X21, LSL #34
    ANDS  X19, X14, X7, ASR #26
    ANDS  X11, X8, X5, LSL #45
    ANDS  X13, X3, X8, LSL #22
    ANDS  X22, X13, X19, LSL #8
    ANDS  X23, X23, X11, LSL #11
    ASR  W3, W22, #0x1e
    ASR  W15, W16, #0x19
    ASR  W11, W15, #0x16
    ASR  W8, W6, #0x4
    ASR  W16, W17, #0xf
    ASR  W7, W9, #0x3
    ASR  W6, W23, #0x4
    ASR  W10, W2, #0x7
    ASR  W14, W16, #0x16
    ASR  W17, W16, #0x10
    ASR  X2, X4, #0xf
    ASR  X19, X14, #0x1f
    ASR  X22, X10, #0x23
    ASR  X17, X17, #0x22
    ASR  X4, X12, #0x30
    ASR  X21, X16, #0x20
    ASR  X18, X11, #0xa
    ASR  X10, X7, #0x25
    ASR  X4, X6, #0x2
    ASR  X17, X3, #0x15
    ASR  W12, W14, W18
    ASR  W13, W2, W23
    ASR  W23, W10, W12
    ASR  W7, W13, W17
    ASR  W3, W19, W7
    ASR  W6, W21, W22
    ASR  W22, W8, W4
    ASR  W10, W21, W6
    ASR  W6, W23, W21
    ASR  W4, W3, W6
    ASR  X2, X2, X23
    ASR  X11, X10, X10
    ASR  X19, X2, X22
    ASR  X7, X11, X14
    ASR  X13, X5, X19
    ASR  X11, X22, X13
    ASR  X10, X4, X4
    ASR  X2, X7, X11
    ASR  X21, X3, X12
    ASR  X7, X7, X9
    ASRV  W19, W23, W18
    ASRV  W11, W3, W9
    ASRV  W13, W9, W6
    ASRV  W21, W10, W19
    ASRV  W10, W13, W9
    ASRV  W12, W3, W23
    ASRV  W8, W15, W11
    ASRV  W4, W16, W5
    ASRV  W6, W8, W17
    ASRV  W23, W2, W13
    ASRV  X19, X6, X23
    ASRV  X13, X7, X21
    ASRV  X17, X23, X8
    ASRV  X8, X6, X2
    ASRV  X2, X14, X9
    ASRV  X6, X15, X13
    ASRV  X16, X15, X12
    ASRV  X3, X8, X8
    ASRV  X18, X2, X19
    ASRV  X14, X13, X16
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X2, #0xacf3, LSL #0
    MOVK  X2, #0x2cc6, LSL #16
    MOVK  X2, #0x5a16, LSL #32
    MOVK  X2, #0x19c2, LSL #48
    MOVZ  X3, #0xba36, LSL #0
    MOVK  X3, #0xfd26, LSL #16
    MOVK  X3, #0xe2d7, LSL #32
    MOVK  X3, #0x7381, LSL #48
    MOVZ  X4, #0x733f, LSL #0
    MOVK  X4, #0xb329, LSL #16
    MOVK  X4, #0x2f78, LSL #32
    MOVK  X4, #0xbfa, LSL #48
    MOVZ  X5, #0xdddb, LSL #0
    MOVK  X5, #0x3b7d, LSL #16
    MOVK  X5, #0x1add, LSL #32
    MOVK  X5, #0x1026, LSL #48
    MOVZ  X6, #0x5aa0, LSL #0
    MOVK  X6, #0x52be, LSL #16
    MOVK  X6, #0x5bb1, LSL #32
    MOVK  X6, #0xda48, LSL #48
    MOVZ  X7, #0xf48f, LSL #0
    MOVK  X7, #0x82f3, LSL #16
    MOVK  X7, #0xe6c2, LSL #32
    MOVK  X7, #0xe5c, LSL #48
    MOVZ  X8, #0x6e47, LSL #0
    MOVK  X8, #0xc702, LSL #16
    MOVK  X8, #0x3e56, LSL #32
    MOVK  X8, #0x9e33, LSL #48
    MOVZ  X9, #0x91ec, LSL #0
    MOVK  X9, #0x488f, LSL #16
    MOVK  X9, #0x5ad4, LSL #32
    MOVK  X9, #0x6548, LSL #48
    MOVZ  X10, #0x1ffc, LSL #0
    MOVK  X10, #0x76a6, LSL #16
    MOVK  X10, #0x8756, LSL #32
    MOVK  X10, #0x21fe, LSL #48
    MOVZ  X11, #0xcf9c, LSL #0
    MOVK  X11, #0x508e, LSL #16
    MOVK  X11, #0x5101, LSL #32
    MOVK  X11, #0x9bdb, LSL #48
    MOVZ  X12, #0x6972, LSL #0
    MOVK  X12, #0xa842, LSL #16
    MOVK  X12, #0x607a, LSL #32
    MOVK  X12, #0x393c, LSL #48
    MOVZ  X13, #0x425a, LSL #0
    MOVK  X13, #0xf1b, LSL #16
    MOVK  X13, #0xf1f0, LSL #32
    MOVK  X13, #0x10f4, LSL #48
    MOVZ  X14, #0xb3c, LSL #0
    MOVK  X14, #0x7bab, LSL #16
    MOVK  X14, #0x8efc, LSL #32
    MOVK  X14, #0xfe4d, LSL #48
    MOVZ  X15, #0x3b9a, LSL #0
    MOVK  X15, #0x3067, LSL #16
    MOVK  X15, #0xa16b, LSL #32
    MOVK  X15, #0x488b, LSL #48
    MOVZ  X16, #0x23bd, LSL #0
    MOVK  X16, #0x8d9c, LSL #16
    MOVK  X16, #0x2883, LSL #32
    MOVK  X16, #0x987b, LSL #48
    MOVZ  X17, #0x1b08, LSL #0
    MOVK  X17, #0xc1a7, LSL #16
    MOVK  X17, #0xc0c, LSL #32
    MOVK  X17, #0xc6e8, LSL #48
    MOVZ  X18, #0xf1db, LSL #0
    MOVK  X18, #0xc459, LSL #16
    MOVK  X18, #0xba9b, LSL #32
    MOVK  X18, #0x30d8, LSL #48
    MOVZ  X19, #0x16fb, LSL #0
    MOVK  X19, #0x8124, LSL #16
    MOVK  X19, #0xd0fc, LSL #32
    MOVK  X19, #0x536a, LSL #48
    MOVZ  X20, #0x440d, LSL #0
    MOVK  X20, #0xc7eb, LSL #16
    MOVK  X20, #0xa1df, LSL #32
    MOVK  X20, #0x3d13, LSL #48
    MOVZ  X21, #0x32e3, LSL #0
    MOVK  X21, #0x7807, LSL #16
    MOVK  X21, #0x99b5, LSL #32
    MOVK  X21, #0xc447, LSL #48
    MOVZ  X22, #0x8493, LSL #0
    MOVK  X22, #0xd5, LSL #16
    MOVK  X22, #0x68c4, LSL #32
    MOVK  X22, #0x3bd8, LSL #48
    MOVZ  X23, #0x5f4a, LSL #0
    MOVK  X23, #0x8c3f, LSL #16
    MOVK  X23, #0x84db, LSL #32
    MOVK  X23, #0xb750, LSL #48
    MOVZ  X27, #0x1aa, LSL #0
    MOVK  X27, #0x3d19, LSL #16
    MOVK  X27, #0x8326, LSL #32
    MOVK  X27, #0x4bb8, LSL #48
    BFI  W4, W22, #3, #29
    BFI  W27, W21, #10, #9
    BFI  W6, W20, #7, #12
    BFI  W22, W27, #16, #13
    BFI  W4, W27, #1, #31
    BFI  W13, W22, #1, #11
    BFI  W17, W9, #6, #5
    BFI  W9, W23, #31, #1
    BFI  W23, W21, #31, #1
    BFI  W21, W12, #16, #1
    BFI  X7, X23, #62, #1
    BFI  X4, X4, #8, #16
    BFI  X4, X21, #31, #20
    BFI  X11, X5, #30, #10
    BFI  X27, X4, #1, #13
    BFI  X19, X13, #12, #2
    BFI  X18, X9, #29, #10
    BFI  X4, X19, #19, #26
    BFI  X4, X27, #51, #7
    BFI  X11, X23, #55, #2
    BFM  W13, W6, #0xf, #0x11
    BFM  W22, W4, #0x1e, #0x17
    BFM  W9, W17, #0x1d, #0x16
    BFM  W21, W9, #0x10, #0x1b
    BFM  W23, W21, #0x19, #0x12
    BFM  W15, W14, #0xc, #0x17
    BFM  W10, W5, #0xe, #0x2
    BFM  W18, W7, #0x6, #0x9
    BFM  W22, W7, #0x1b, #0x15
    BFM  W6, W17, #0x1c, #0x10
    BFM  X27, X23, #0x5, #0x39
    BFM  X4, X3, #0x2d, #0x2b
    BFM  X27, X22, #0x1f, #0x3d
    BFM  X12, X18, #0x38, #0x28
    BFM  X18, X11, #0x2e, #0x5
    BFM  X10, X10, #0x7, #0x14
    BFM  X23, X27, #0x3c, #0x1f
    BFM  X20, X19, #0x3e, #0x7
    BFM  X7, X13, #0x35, #0x27
    BFM  X18, X22, #0x38, #0x2f
    BFXIL  W14, W3, #0x13, #1
    BFXIL  W6, W6, #0x4, #9
    BFXIL  W20, W14, #0x19, #7
    BFXIL  W2, W6, #0x16, #7
    BFXIL  W7, W10, #0x1b, #1
    BFXIL  W9, W20, #0xc, #11
    BFXIL  W2, W18, #0x19, #6
    BFXIL  W13, W9, #0x7, #18
    BFXIL  W17, W9, #0x4, #24
    BFXIL  W14, W12, #0x15, #6
    BFXIL  X5, X4, #0x26, #9
    BFXIL  X4, X14, #0x14, #29
    BFXIL  X5, X4, #0x3f, #1
    BFXIL  X11, X13, #0x29, #11
    BFXIL  X20, X14, #0x16, #14
    BFXIL  X13, X20, #0x28, #17
    BFXIL  X18, X17, #0x9, #47
    BFXIL  X14, X21, #0x3a, #5
    BFXIL  X6, X7, #0x34, #4
    BFXIL  X21, X19, #0x1e, #8
    BIC  W9, W2, W21, LSL #23
    BIC  W17, W11, W6, LSR #21
    BIC  W10, W9, W27, LSL #30
    BIC  W11, W17, W5, ROR #13
    BIC  W9, W23, W11, ROR #4
    BIC  W20, W14, W18, LSR #1
    BIC  W22, W9, W13, ROR #12
    BIC  W19, W10, W22, LSR #27
    BIC  W10, W15, W27, ROR #16
    BIC  W15, W22, W15, ROR #24
    BIC  X3, X7, X20, ASR #18
    BIC  X4, X13, X12, LSR #19
    BIC  X27, X22, X5, ROR #54
    BIC  X23, X3, X11, ROR #60
    BIC  X13, X18, X4, ASR #57
    BIC  X15, X2, X21, ROR #47
    BIC  X13, X11, X22, ASR #32
    BIC  X11, X22, X7, LSR #60
    BIC  X6, X19, X12, LSR #32
    BIC  X3, X2, X10, ASR #39
    BICS  W17, W5, W21, LSL #30
    BICS  W23, W7, W20, ASR #16
    BICS  W20, W27, W3, LSL #20
    BICS  W7, W3, W23, LSL #18
    BICS  W11, W10, W11, ASR #4
    BICS  W17, W15, W13, ASR #26
    BICS  W2, W3, W2, ROR #9
    BICS  W14, W2, W9, ASR #6
    BICS  W2, W20, W20, LSR #0
    BICS  W5, W7, W11, ASR #19
    BICS  X19, X2, X5, LSR #53
    BICS  X4, X14, X15, LSL #17
    BICS  X23, X5, X19, ROR #7
    BICS  X10, X4, X27, ASR #52
    BICS  X22, X23, X23, ROR #36
    BICS  X18, X21, X21, ASR #39
    BICS  X11, X22, X17, LSL #59
    BICS  X21, X6, X23, LSL #8
    BICS  X18, X11, X21, ROR #62
    BICS  X5, X18, X10, ROR #24
    CLS  W23, W3
    CLS  W21, W14
    CLS  W22, W7
    CLS  W4, W14
    CLS  W18, W18
    CLS  W14, W27
    CLS  W15, W13
    CLS  W11, W5
    CLS  W10, W12
    CLS  W19, W22
    CLS  X7, X15
    CLS  X6, X19
    CLS  X3, X7
    CLS  X19, X4
    CLS  X15, X6
    CLS  X5, X11
    CLS  X3, X5
    CLS  X18, X10
    CLS  X4, X2
    CLS  X7, X21
    CLZ  W6, W3
    CLZ  W11, W7
    CLZ  W17, W3
    CLZ  W10, W19
    CLZ  W2, W11
    CLZ  W12, W23
    CLZ  W22, W12
    CLZ  W13, W6
    CLZ  W17, W22
    CLZ  W21, W17
    CLZ  X11, X4
    CLZ  X17, X2
    CLZ  X27, X11
    CLZ  X22, X17
    CLZ  X7, X10
    CLZ  X17, X18
    CLZ  X6, X22
    CLZ  X3, X4
    CLZ  X19, X17
    CLZ  X6, X2
    CSEL  W11, W13, W6, LT
    CSEL  W17, W20, W11, VS
    CSEL  W4, W19, W21, MI
    CSEL  W11, W3, W22, MI
    CSEL  W18, W4, W27, EQ
    CSEL  W21, W11, W18, VC
    CSEL  W7, W3, W7, LT
    CSEL  W2, W22, W7, LT
    CSEL  W11, W2, W17, AL
    CSEL  W4, W23, W14, NE
    CSEL  X15, X23, X21, LS
    CSEL  X17, X18, X14, HI
    CSEL  X14, X6, X15, LT
    CSEL  X19, X3, X13, GE
    CSEL  X3, X15, X4, NE
    CSEL  X2, X10, X6, CC
    CSEL  X27, X4, X17, LS
    CSEL  X18, X21, X13, VS
    CSEL  X21, X11, X9, HI
    CSEL  X9, X17, X3, GE
    CSINC  W27, W19, W4, GT
    CSINC  W11, W27, W21, GE
    CSINC  W23, W7, W3, HI
    CSINC  W23, W7, W13, LS
    CSINC  W21, W21, W20, NV
    CSINC  W17, W5, W19, MI
    CSINC  W17, W14, W11, VS
    CSINC  W21, W12, W21, PL
    CSINC  W20, W12, W5, VC
    CSINC  W10, W18, W5, PL
    CSINC  X3, X3, X18, HI
    CSINC  X12, X6, X14, GE
    CSINC  X13, X10, X12, AL
    CSINC  X17, X21, X14, CS
    CSINC  X21, X11, X17, CS
    CSINC  X11, X9, X20, MI
    CSINC  X17, X23, X11, LT
    CSINC  X7, X17, X13, MI
    CSINC  X14, X14, X13, AL
    CSINC  X18, X3, X2, LT
    CSINV  W14, W20, W22, MI
    CSINV  W27, W7, W21, VS
    CSINV  W17, W3, W27, CC
    CSINV  W23, W18, W22, NE
    CSINV  W15, W6, W17, AL
    CSINV  W13, W3, W14, GT
    CSINV  W11, W13, W23, HI
    CSINV  W18, W19, W19, VS
    CSINV  W2, W11, W2, AL
    CSINV  W20, W17, W18, CC
    CSINV  X7, X23, X12, LE
    CSINV  X19, X13, X15, CC
    CSINV  X11, X27, X22, LE
    CSINV  X3, X21, X11, PL
    CSINV  X13, X15, X2, LT
    CSINV  X14, X3, X6, NV
    CSINV  X22, X2, X5, HI
    CSINV  X5, X18, X19, GT
    CSINV  X27, X17, X3, EQ
    CSINV  X17, X5, X20, GT
    CSNEG  W10, W23, W7, NE
    CSNEG  W12, W10, W19, GT
    CSNEG  W2, W17, W13, LE
    CSNEG  W6, W4, W5, AL
    CSNEG  W18, W12, W14, AL
    CSNEG  W23, W20, W7, LT
    CSNEG  W19, W17, W9, CC
    CSNEG  W19, W23, W5, EQ
    CSNEG  W5, W5, W7, VC
    CSNEG  W20, W5, W21, PL
    CSNEG  X17, X4, X7, GT
    CSNEG  X12, X6, X18, LS
    CSNEG  X15, X21, X18, AL
    CSNEG  X11, X18, X13, VC
    CSNEG  X5, X11, X2, GT
    CSNEG  X18, X5, X15, CC
    CSNEG  X2, X7, X20, GT
    CSNEG  X22, X15, X12, PL
    CSNEG  X5, X22, X2, PL
    CSNEG  X23, X18, X5, CC
    EON  W10, W23, W27, ROR #1
    EON  W4, W7, W19, ASR #28
    EON  W20, W10, W17, ROR #28
    EON  W27, W10, W19, ROR #28
    EON  W5, W11, W17, ASR #9
    EON  W3, W15, W27, ASR #21
    EON  W18, W27, W13, ROR #22
    EON  W22, W19, W15, LSL #24
    EON  W7, W7, W15, ASR #28
    EON  W10, W12, W12, ASR #19
    EON  X17, X7, X2, LSL #3
    EON  X13, X4, X4, LSR #28
    EON  X2, X9, X21, LSR #19
    EON  X22, X2, X23, ROR #7
    EON  X10, X13, X19, ASR #42
    EON  X23, X5, X10, ROR #60
    EON  X10, X3, X27, LSR #30
    EON  X13, X18, X15, LSL #54
    EON  X18, X10, X17, LSR #8
    EON  X12, X7, X18, ROR #10
    EOR  W6, W13, #0x30303030
    EOR  W3, W20, #0xfc0000
    EOR  W10, W12, #0x6000600
    EOR  W4, W23, #0xc0
    EOR  W27, W10, #0x1f001f
    EOR  W15, W2, #0xfe1fffff
    EOR  W17, W22, #0x7e007e0
    EOR  W2, W4, #0x83ffffff
    EOR  W18, W19, #0xf1fff1ff
    EOR  W23, W18, #0xe0000
    EOR  X18, X6, #0x1c001c001c001c
    EOR  X22, X15, #0xfc000000001fffff
    EOR  X13, X23, #0x404040404040404
    EOR  X19, X18, #0x801fffff801fffff
    EOR  X5, X3, #0x7fffffffffffc000
    EOR  X3, X19, #0xffc00000ffffffff
    EOR  X4, X27, #0xffffff1fffffff1f
    EOR  X14, X4, #0xfffffe00000003ff
    EOR  X20, X17, #0x18000000180
    EOR  X17, X3, #0xffffffffffffff03
    EOR  W12, W19, W13, ASR #23
    EOR  W6, W17, W22, LSL #20
    EOR  W2, W6, W10, LSR #29
    EOR  W4, W20, W12, LSR #26
    EOR  W27, W11, W2, ROR #24
    EOR  W6, W22, W14, LSR #16
    EOR  W23, W5, W6, ROR #22
    EOR  W23, W7, W27, ROR #10
    EOR  W17, W4, W23, LSR #20
    EOR  W2, W4, W9, ASR #2
    EOR  X18, X14, X7, ROR #35
    EOR  X22, X17, X3, ASR #47
    EOR  X19, X2, X23, ROR #46
    EOR  X7, X15, X21, LSL #2
    EOR  X22, X15, X9, LSR #23
    EOR  X13, X22, X7, ASR #16
    EOR  X6, X15, X20, LSL #32
    EOR  X20, X21, X11, ASR #47
    EOR  X21, X18, X12, LSL #55
    EOR  X11, X13, X23, LSR #41
    EXTR  W22, W3, W7, #0x4
    EXTR  W4, W2, W9, #0x9
    EXTR  W12, W13, W7, #0xf
    EXTR  W7, W13, W4, #0x17
    EXTR  W14, W6, W19, #0x5
    EXTR  W5, W3, W10, #0x14
    EXTR  W17, W21, W20, #0x1b
    EXTR  W6, W18, W4, #0x4
    EXTR  W19, W19, W21, #0x1a
    EXTR  W20, W12, W4, #0x17
    EXTR  X10, X21, X19, #0x19
    EXTR  X3, X11, X20, #0x2c
    EXTR  X18, X17, X12, #0x2c
    EXTR  X17, X3, X14, #0x15
    EXTR  X7, X21, X14, #0x2d
    EXTR  X4, X17, X22, #0x1a
    EXTR  X5, X18, X6, #0x9
    EXTR  X3, X21, X4, #0x22
    EXTR  X23, X14, X3, #0x1d
    EXTR  X22, X5, X27, #0x2
    MOVZ  X8, #0x671, LSL #0
    MOVK  X8, #0x7e0, LSL #16
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X8, #0x6d60, LSL #0
    MOVK  X8, #0x3eb1, LSL #32
    MOVK  X8, #0x1988, LSL #48
    SUB  X16, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X8, #0x24, LSL #0
    MOVK  X8, #0xb580, LSL #32
    MOVK  X8, #0x1, LSL #48
    SUB  X16, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X8, #0xc400, LSL #0
    MOVK  X8, #0x21, LSL #16
    SUB  X16, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x4388, LSL #16
    SUB  X16, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xd620, LSL #16
    MOVK  X8, #0x3107, LSL #32
    MOVK  X8, #0x8c3, LSL #48
    SUB  X16, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X8, #0x1b, LSL #0
    SUB  X16, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X8, #0xe, LSL #0
    MOVK  X8, #0x6200, LSL #32
    MOVK  X8, #0x107d, LSL #48
    SUB  X16, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X8, #0x1fb, LSL #0
    MOVK  X8, #0x1e0, LSL #16
    SUB  X16, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X8, #0x3c0, LSL #0
    MOVK  X8, #0x3f6, LSL #16
    SUB  X16, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X8, #0x1fb, LSL #0
    MOVK  X8, #0x1e0, LSL #16
    SUB  X16, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X8, #0x8033, LSL #0
    MOVK  X8, #0xdac3, LSL #16
    SUB  X16, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X8, #0x1b, LSL #0
    MOVK  X8, #0x1e0, LSL #16
    SUB  X16, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X8, #0x6d6, LSL #0
    MOVK  X8, #0x8000, LSL #48
    SUB  X16, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8800, LSL #16
    MOVK  X8, #0x41f5, LSL #32
    MOVK  X8, #0xc, LSL #48
    SUB  X16, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X8, #0x9c59, LSL #0
    MOVK  X8, #0x1c01, LSL #16
    SUB  X16, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X8, #0x8071, LSL #0
    MOVK  X8, #0xec07, LSL #16
    SUB  X16, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X8, #0xfac4, LSL #0
    MOVK  X8, #0x6620, LSL #16
    MOVK  X8, #0x118, LSL #32
    MOVK  X8, #0x3680, LSL #48
    SUB  X16, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X8, #0xdf4a, LSL #0
    MOVK  X8, #0x2317, LSL #16
    SUB  X16, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X8, #0xf588, LSL #0
    MOVK  X8, #0xcc41, LSL #16
    MOVK  X8, #0x198, LSL #32
    MOVK  X8, #0xd61c, LSL #48
    SUB  X16, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X8, #0x7d2a, LSL #0
    MOVK  X8, #0x8c5f, LSL #16
    SUB  X16, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X2, #0x1841, LSL #0
    MOVK  X2, #0xfb3, LSL #16
    MOVK  X2, #0x35bd, LSL #32
    MOVK  X2, #0x100f, LSL #48
    MOVZ  X3, #0xba7, LSL #0
    MOVK  X3, #0xf8c6, LSL #16
    MOVK  X3, #0x7a81, LSL #32
    MOVK  X3, #0xd95e, LSL #48
    MOVZ  X4, #0xf5bc, LSL #0
    MOVK  X4, #0x4546, LSL #16
    MOVK  X4, #0x65d1, LSL #32
    MOVK  X4, #0xc353, LSL #48
    MOVZ  X5, #0xacf4, LSL #0
    MOVK  X5, #0xe415, LSL #16
    MOVK  X5, #0x4c41, LSL #32
    MOVK  X5, #0x8220, LSL #48
    MOVZ  X6, #0xbe17, LSL #0
    MOVK  X6, #0x73a, LSL #16
    MOVK  X6, #0x63d5, LSL #32
    MOVK  X6, #0x28b4, LSL #48
    MOVZ  X7, #0xb8d6, LSL #0
    MOVK  X7, #0xe4a6, LSL #16
    MOVK  X7, #0x604, LSL #32
    MOVK  X7, #0x3667, LSL #48
    MOVZ  X8, #0x575a, LSL #0
    MOVK  X8, #0x83f1, LSL #16
    MOVK  X8, #0x2a8, LSL #32
    MOVK  X8, #0x887a, LSL #48
    MOVZ  X9, #0x4798, LSL #0
    MOVK  X9, #0x2279, LSL #16
    MOVK  X9, #0x49e7, LSL #32
    MOVK  X9, #0x41b8, LSL #48
    MOVZ  X10, #0xdb0a, LSL #0
    MOVK  X10, #0x2883, LSL #16
    MOVK  X10, #0xb3bf, LSL #32
    MOVK  X10, #0x18db, LSL #48
    MOVZ  X11, #0x6589, LSL #0
    MOVK  X11, #0xe40d, LSL #16
    MOVK  X11, #0x518f, LSL #32
    MOVK  X11, #0x4758, LSL #48
    MOVZ  X12, #0x1f58, LSL #0
    MOVK  X12, #0xb03c, LSL #16
    MOVK  X12, #0xd8d, LSL #32
    MOVK  X12, #0xd2b5, LSL #48
    MOVZ  X13, #0xddfd, LSL #0
    MOVK  X13, #0xa15, LSL #16
    MOVK  X13, #0xc7fa, LSL #32
    MOVK  X13, #0x5f2d, LSL #48
    MOVZ  X14, #0x8e68, LSL #0
    MOVK  X14, #0x3a35, LSL #16
    MOVK  X14, #0x2d43, LSL #32
    MOVK  X14, #0xc644, LSL #48
    MOVZ  X15, #0x41b9, LSL #0
    MOVK  X15, #0x45a0, LSL #16
    MOVK  X15, #0xa8f3, LSL #32
    MOVK  X15, #0x6cd1, LSL #48
    MOVZ  X16, #0xc37f, LSL #0
    MOVK  X16, #0xc75, LSL #16
    MOVK  X16, #0x9ff9, LSL #32
    MOVK  X16, #0xd024, LSL #48
    MOVZ  X17, #0xeb71, LSL #0
    MOVK  X17, #0x1770, LSL #16
    MOVK  X17, #0xbbf9, LSL #32
    MOVK  X17, #0x3272, LSL #48
    MOVZ  X18, #0x9d6a, LSL #0
    MOVK  X18, #0xf8ac, LSL #16
    MOVK  X18, #0x4699, LSL #32
    MOVK  X18, #0x6ba0, LSL #48
    MOVZ  X19, #0xcb93, LSL #0
    MOVK  X19, #0x62c, LSL #16
    MOVK  X19, #0xd91, LSL #32
    MOVK  X19, #0xd81d, LSL #48
    MOVZ  X20, #0x55, LSL #0
    MOVK  X20, #0x5534, LSL #16
    MOVK  X20, #0x7ad7, LSL #32
    MOVK  X20, #0x894f, LSL #48
    MOVZ  X21, #0xd82, LSL #0
    MOVK  X21, #0x615b, LSL #16
    MOVK  X21, #0x5201, LSL #32
    MOVK  X21, #0x8c30, LSL #48
    MOVZ  X22, #0xc311, LSL #0
    MOVK  X22, #0x67f2, LSL #16
    MOVK  X22, #0xcb13, LSL #32
    MOVK  X22, #0x166a, LSL #48
    MOVZ  X23, #0x710e, LSL #0
    MOVK  X23, #0xf08e, LSL #16
    MOVK  X23, #0x6d3, LSL #32
    MOVK  X23, #0x358e, LSL #48
    MOVZ  X27, #0x63df, LSL #0
    MOVK  X27, #0x43e3, LSL #16
    MOVK  X27, #0x6069, LSL #32
    MOVK  X27, #0xdf32, LSL #48
    MADD  W11, W12, W21, W10
    MADD  W19, W20, W18, W22
    MADD  W23, W8, W15, W19
    MADD  W7, W11, W11, W11
    MADD  W11, W7, W23, W23
    MADD  W10, W20, W22, W5
    MADD  W7, W12, W17, W20
    MADD  W16, W18, W17, W14
    MADD  W10, W21, W10, W15
    MADD  W22, W18, W11, W17
    MADD  X19, X19, X9, X8
    MADD  X16, X15, X19, X4
    MADD  X14, X20, X12, X2
    MADD  X5, X27, X27, X12
    MADD  X21, X7, X20, X17
    MADD  X20, X5, X13, X14
    MADD  X4, X14, X4, X16
    MADD  X7, X18, X2, X17
    MADD  X27, X4, X15, X8
    MADD  X10, X22, X8, X4
    MNEG  W9, W13, W11
    MNEG  W2, W13, W19
    MNEG  W4, W2, W11
    MNEG  W23, W9, W5
    MNEG  W15, W23, W20
    MNEG  W8, W18, W19
    MNEG  W5, W14, W4
    MNEG  W4, W13, W15
    MNEG  W14, W4, W27
    MNEG  W5, W10, W7
    MNEG  X11, X16, X10
    MNEG  X15, X11, X19
    MNEG  X9, X21, X4
    MNEG  X7, X11, X16
    MNEG  X13, X27, X13
    MNEG  X10, X18, X17
    MNEG  X12, X2, X5
    MNEG  X17, X9, X18
    MNEG  X16, X4, X19
    MNEG  X13, X17, X19
    MSUB  W22, W10, W27, W14
    MSUB  W19, W7, W16, W5
    MSUB  W11, W23, W7, W15
    MSUB  W20, W15, W14, W21
    MSUB  W16, W19, W12, W8
    MSUB  W12, W16, W22, W17
    MSUB  W8, W4, W16, W2
    MSUB  W17, W21, W19, W12
    MSUB  W19, W22, W13, W27
    MSUB  W27, W5, W19, W8
    MSUB  X21, X20, X16, X11
    MSUB  X8, X23, X17, X19
    MSUB  X13, X18, X21, X27
    MSUB  X23, X7, X11, X14
    MSUB  X9, X15, X23, X11
    MSUB  X23, X8, X2, X23
    MSUB  X19, X15, X18, X16
    MSUB  X22, X18, X15, X11
    MSUB  X9, X16, X15, X9
    MSUB  X17, X14, X11, X13
    MUL  W10, W23, W23
    MUL  W2, W8, W17
    MUL  W21, W16, W14
    MUL  W5, W16, W20
    MUL  W21, W9, W22
    MUL  W10, W20, W27
    MUL  W16, W2, W7
    MUL  W15, W17, W21
    MUL  W27, W9, W22
    MUL  W15, W21, W17
    MUL  X11, X23, X21
    MUL  X8, X4, X27
    MUL  X7, X7, X21
    MUL  X21, X13, X4
    MUL  X14, X2, X2
    MUL  X10, X5, X7
    MUL  X17, X4, X10
    MUL  X27, X21, X27
    MUL  X7, X14, X19
    MUL  X2, X7, X5
    MVN  W19, W17, ROR #14
    MVN  W14, W16, ROR #8
    MVN  W21, W14, ASR #28
    MVN  W9, W27, ROR #26
    MVN  W10, W21, ASR #31
    MVN  W16, W11, LSR #21
    MVN  W22, W18, LSR #8
    MVN  W4, W2, ROR #9
    MVN  W5, W4, LSL #15
    MVN  W27, W8, LSR #12
    MVN  X11, X5, LSR #7
    MVN  X17, X9, ROR #5
    MVN  X16, X19, LSR #14
    MVN  X8, X27, LSL #2
    MVN  X27, X17, LSR #37
    MVN  X23, X8, LSR #18
    MVN  X21, X27, LSR #47
    MVN  X18, X21, ROR #41
    MVN  X7, X5, LSR #48
    MVN  X13, X5, LSR #28
    NEG  W10, W18, LSR #21
    NEG  W9, W11, LSR #6
    NEG  W27, W22, LSR #28
    NEG  W22, W7, LSL #21
    NEG  W8, W10, ASR #4
    NEG  W2, W9, LSL #26
    NEG  W19, W23, LSR #6
    NEG  W10, W13, LSL #31
    NEG  W23, W27, ASR #21
    NEG  W17, W23, LSR #22
    NEG  X23, X16, LSL #50
    NEG  X11, X22, ASR #60
    NEG  X5, X23, ASR #21
    NEG  X9, X9, LSR #39
    NEG  X18, X23, LSL #41
    NEG  X16, X10, LSL #1
    NEG  X15, X18, LSL #15
    NEG  X4, X11, LSR #12
    NEG  X13, X16, ASR #13
    NEG  X2, X8, LSL #26
    NEGS  W8, W19, LSL #4
    NEGS  W12, W10
    NEGS  W19, W15, ASR #17
    NEGS  W27, W17, LSL #20
    NEGS  W14, W5, ASR #19
    NEGS  W15, W8, ASR #20
    NEGS  W8, W27, LSR #14
    NEGS  W22, W4, LSL #27
    NEGS  W17, W4, ASR #18
    NEGS  W18, W17, LSR #31
    NEGS  X10, X22, ASR #29
    NEGS  X16, X14, LSL #50
    NEGS  X22, X16, LSL #35
    NEGS  X11, X4, LSR #8
    NEGS  X5, X19, LSL #36
    NEGS  X19, X9, ASR #59
    NEGS  X4, X5, ASR #42
    NEGS  X9, X12, LSL #8
    NEGS  X9, X13, ASR #27
    NEGS  X12, X12, ASR #24
    NGC  W14, W22
    NGC  W17, W2
    NGC  W18, W14
    NGC  W27, W8
    NGC  W16, W17
    NGC  W5, W15
    NGC  W13, W16
    NGC  W2, W27
    NGC  W14, W19
    NGC  W8, W18
    NGC  X13, X13
    NGC  X16, X23
    NGC  X23, X2
    NGC  X2, X16
    NGC  X17, X22
    NGC  X12, X22
    NGC  X16, X23
    NGC  X7, X8
    NGC  X27, X2
    NGC  X16, X16
    NGCS  W23, W27
    NGCS  W19, W4
    NGCS  W20, W7
    NGCS  W21, W13
    NGCS  W17, W12
    NGCS  W22, W16
    NGCS  W2, W5
    NGCS  W5, W19
    NGCS  W8, W23
    NGCS  W7, W16
    NGCS  X15, X7
    NGCS  X19, X22
    NGCS  X7, X2
    NGCS  X7, X5
    NGCS  X21, X7
    NGCS  X22, X21
    NGCS  X27, X8
    NGCS  X7, X15
    NGCS  X8, X7
    NGCS  X16, X21
    ORN  W18, W17, W15, LSL #21
    ORN  W11, W22, W16
    ORN  W21, W27, W11, ASR #25
    ORN  W2, W18, W19, ASR #11
    ORN  W27, W8, W21, ASR #29
    ORN  W4, W7, W20, LSR #4
    ORN  W2, W5, W22, ASR #23
    ORN  W18, W4, W16, ROR #6
    ORN  W7, W27, W27, LSR #16
    ORN  W20, W17, W2, ROR #13
    ORN  X2, X14, X7, LSR #34
    ORN  X13, X20, X15, ASR #61
    ORN  X8, X2, X23, LSR #7
    ORN  X4, X23, X18, ASR #17
    ORN  X14, X12, X13, LSL #61
    ORN  X13, X18, X8, ROR #62
    ORN  X27, X13, X20, LSL #59
    ORN  X20, X20, X23, ASR #30
    ORN  X2, X8, X14, LSR #35
    ORN  X23, X27, X21, ROR #26
    ORR  W11, W27, #0x1f001f0
    ORR  W22, W11, #0xfe03ffff
    ORR  W12, W22, #0x8fff8fff
    ORR  W15, W20, #0x3f8000
    ORR  W27, W4, #0xffc7ffc7
    ORR  W14, W10, #0xc3c3c3c3
    ORR  W4, W12, #0xfffff7ff
    ORR  W10, W2, #0x1fff00
    ORR  W17, W10, #0x7e007e0
    ORR  W21, W15, #0x1fffe0
    ORR  X20, X9, #0xf0000007ffffffff
    ORR  X10, X7, #0xf00000ffffffffff
    ORR  X8, X5, #0xfffe00000007ffff
    ORR  X2, X4, #0xfe00fe00fe00fe00
    ORR  X5, X11, #0x3ff03ff03ff03ff0
    ORR  X11, X10, #0x1ffe000000000000
    ORR  X7, X14, #0x7ffffffe0000000
    ORR  X7, X14, #0xfffff801fffff801
    ORR  X10, X27, #0xf0000000f0000000
    ORR  X27, X21, #0x3fe000003fe0000
    ORR  W14, W5, W13, ROR #9
    ORR  W21, W2, W27, LSR #8
    ORR  W2, W14, W10, LSR #25
    ORR  W10, W8, W10, LSL #11
    ORR  W13, W20, W17, ROR #5
    ORR  W14, W9, W23, LSL #1
    ORR  W9, W27, W11, LSR #29
    ORR  W20, W2, W9, ASR #17
    ORR  W22, W14, W7, LSL #17
    ORR  W17, W22, W10, ASR #24
    ORR  X16, X22, X21, ROR #33
    ORR  X21, X21, X16, ROR #12
    ORR  X18, X15, X17, LSL #39
    ORR  X23, X13, X16, LSL #10
    ORR  X2, X18, X27, ROR #21
    ORR  X15, X19, X23, LSR #3
    ORR  X11, X9, X16, ASR #35
    ORR  X7, X11, X2, ROR #50
    ORR  X11, X21, X8, LSR #62
    ORR  X17, X11, X21, LSL #52
    RBIT  W14, W21
    RBIT  W11, W17
    RBIT  W17, W11
    RBIT  W10, W15
    RBIT  W9, W12
    RBIT  W20, W10
    RBIT  W16, W17
    RBIT  W14, W9
    RBIT  W7, W11
    RBIT  W12, W14
    RBIT  X9, X16
    RBIT  X16, X4
    RBIT  X15, X16
    RBIT  X16, X11
    RBIT  X27, X12
    RBIT  X2, X15
    RBIT  X12, X7
    RBIT  X17, X18
    RBIT  X11, X17
    RBIT  X17, X27
    REV  W16, W17
    REV  W14, W20
    REV  W4, W9
    REV  W21, W19
    REV  W7, W21
    REV  W8, W2
    REV  W12, W8
    REV  W18, W12
    REV  W12, W16
    REV  W27, W8
    REV  X8, X19
    REV  X2, X8
    REV  X8, X14
    REV  X17, X2
    REV  X9, X8
    REV  X18, X22
    REV  X2, X27
    REV  X12, X18
    REV  X21, X2
    REV  X8, X21
    REV16  W22, W9
    REV16  W27, W7
    REV16  W23, W15
    REV16  W18, W16
    REV16  W7, W23
    REV16  W16, W22
    REV16  W7, W27
    REV16  W15, W4
    REV16  W21, W15
    REV16  W2, W23
    REV16  X14, X19
    REV16  X16, X21
    REV16  X22, X23
    REV16  X2, X17
    REV16  X15, X16
    REV16  X9, X12
    REV16  X2, X8
    REV16  X17, X15
    REV16  X17, X18
    REV16  X27, X8
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntAlu_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntAlu_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0x3ff0, LSL #32
    MOVK  X6, #0x3ff0, LSL #48
    SUB  X3, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntAlu_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntAlu_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntAlu_TestFail
    MOVZ  X6, #0xfeff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X3, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntAlu_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X3, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntAlu_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xff80, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X3, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntAlu_TestFail
    MOVZ  X6, #0xfffe, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X3, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntAlu_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X3, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntAlu_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntAlu_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntAlu_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntAlu_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X3, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntAlu_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X3, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntAlu_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntAlu_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X3, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntAlu_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntAlu_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X3, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntAlu_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X3, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntAlu_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTIntAlu_TestFail
    MOVZ  X2, #0xd4f7, LSL #0
    MOVK  X2, #0xfb23, LSL #16
    MOVK  X2, #0x5c4, LSL #32
    MOVK  X2, #0x27c5, LSL #48
    MOVZ  X3, #0x57d8, LSL #0
    MOVK  X3, #0xff4a, LSL #16
    MOVK  X3, #0xdfce, LSL #32
    MOVK  X3, #0x90c3, LSL #48
    MOVZ  X4, #0xdd37, LSL #0
    MOVK  X4, #0xfc94, LSL #16
    MOVK  X4, #0xfaa8, LSL #32
    MOVK  X4, #0x6af, LSL #48
    MOVZ  X5, #0x6915, LSL #0
    MOVK  X5, #0x78a2, LSL #16
    MOVK  X5, #0x6817, LSL #32
    MOVK  X5, #0x9446, LSL #48
    MOVZ  X6, #0x666a, LSL #0
    MOVK  X6, #0x1ee2, LSL #16
    MOVK  X6, #0x942c, LSL #32
    MOVK  X6, #0x634f, LSL #48
    MOVZ  X7, #0xcf91, LSL #0
    MOVK  X7, #0xdb24, LSL #16
    MOVK  X7, #0x68cd, LSL #32
    MOVK  X7, #0x9c65, LSL #48
    MOVZ  X8, #0xc3c2, LSL #0
    MOVK  X8, #0xb04d, LSL #16
    MOVK  X8, #0x489c, LSL #32
    MOVK  X8, #0x809c, LSL #48
    MOVZ  X9, #0x41b, LSL #0
    MOVK  X9, #0xa0fa, LSL #16
    MOVK  X9, #0x15e6, LSL #32
    MOVK  X9, #0x35c3, LSL #48
    MOVZ  X10, #0x32f8, LSL #0
    MOVK  X10, #0x4fac, LSL #16
    MOVK  X10, #0xc2d8, LSL #32
    MOVK  X10, #0xf379, LSL #48
    MOVZ  X11, #0x317e, LSL #0
    MOVK  X11, #0x824d, LSL #16
    MOVK  X11, #0x1980, LSL #32
    MOVK  X11, #0x6082, LSL #48
    MOVZ  X12, #0xf55d, LSL #0
    MOVK  X12, #0xbe32, LSL #16
    MOVK  X12, #0x1f7, LSL #32
    MOVK  X12, #0x122e, LSL #48
    MOVZ  X13, #0x8a67, LSL #0
    MOVK  X13, #0x5687, LSL #16
    MOVK  X13, #0xee75, LSL #32
    MOVK  X13, #0xffff, LSL #48
    MOVZ  X14, #0xface, LSL #0
    MOVK  X14, #0xf0ae, LSL #16
    MOVK  X14, #0x1290, LSL #32
    MOVK  X14, #0x1e10, LSL #48
    MOVZ  X15, #0x5f54, LSL #0
    MOVK  X15, #0x3c59, LSL #16
    MOVK  X15, #0xd2bf, LSL #32
    MOVK  X15, #0x19e3, LSL #48
    MOVZ  X16, #0x5f65, LSL #0
    MOVK  X16, #0x194b, LSL #16
    MOVK  X16, #0xba95, LSL #32
    MOVK  X16, #0x581, LSL #48
    MOVZ  X17, #0xb4b7, LSL #0
    MOVK  X17, #0xa885, LSL #16
    MOVK  X17, #0x1830, LSL #32
    MOVK  X17, #0x4e9c, LSL #48
    MOVZ  X18, #0x1260, LSL #0
    MOVK  X18, #0x9323, LSL #16
    MOVK  X18, #0x263c, LSL #32
    MOVK  X18, #0x34c, LSL #48
    MOVZ  X19, #0xaf74, LSL #0
    MOVK  X19, #0x2d91, LSL #16
    MOVK  X19, #0xf5d9, LSL #32
    MOVK  X19, #0x627d, LSL #48
    MOVZ  X20, #0x69a0, LSL #0
    MOVK  X20, #0xdc3a, LSL #16
    MOVK  X20, #0x3dff, LSL #32
    MOVK  X20, #0x1702, LSL #48
    MOVZ  X21, #0x12a6, LSL #0
    MOVK  X21, #0x593f, LSL #16
    MOVK  X21, #0x69a, LSL #32
    MOVK  X21, #0x678e, LSL #48
    MOVZ  X22, #0xff92, LSL #0
    MOVK  X22, #0x6402, LSL #16
    MOVK  X22, #0xcb29, LSL #32
    MOVK  X22, #0xd9fa, LSL #48
    MOVZ  X23, #0x3f13, LSL #0
    MOVK  X23, #0x5f1a, LSL #16
    MOVK  X23, #0x94e, LSL #32
    MOVK  X23, #0xaa2d, LSL #48
    MOVZ  X27, #0x2e34, LSL #0
    MOVK  X27, #0x4746, LSL #16
    MOVK  X27, #0xdd7e, LSL #32
    MOVK  X27, #0xe839, LSL #48
    REV32  X13, X20
    REV32  X7, X13
    REV32  X12, X7
    REV32  X21, X16
    REV32  X6, X18
    REV32  X8, X3
    REV32  X12, X8
    REV32  X6, X22
    REV32  X3, X12
    REV32  X15, X27
    ROR  W21, W21, #0xb
    ROR  W20, W27, #0x9
    ROR  W4, W23, #0x1e
    ROR  W19, W6, #0x4
    ROR  W27, W15, #0xb
    ROR  W12, W18, #0xe
    ROR  W15, W10, #0x11
    ROR  W4, W15, #0x1e
    ROR  W21, W12, #0x19
    ROR  W13, W4, #0x1
    ROR  X8, X20, #0x1d
    ROR  X15, X27, #0x19
    ROR  X12, X2, #0x3d
    ROR  X12, X13, #0x0
    ROR  X20, X12, #0x1f
    ROR  X5, X15, #0x13
    ROR  X17, X3, #0x24
    ROR  X15, X10, #0x1e
    ROR  X23, X8, #0xf
    ROR  X22, X21, #0x35
    ROR  W27, W3, W20
    ROR  W13, W7, W8
    ROR  W6, W2, W5
    ROR  W6, W19, W15
    ROR  W5, W13, W27
    ROR  W17, W23, W6
    ROR  W13, W17, W20
    ROR  W4, W22, W10
    ROR  W7, W13, W6
    ROR  W13, W3, W4
    ROR  X22, X13, X5
    ROR  X6, X13, X27
    ROR  X5, X13, X2
    ROR  X15, X10, X13
    ROR  X27, X18, X5
    ROR  X13, X15, X21
    ROR  X8, X19, X16
    ROR  X12, X7, X2
    ROR  X15, X9, X15
    ROR  X7, X13, X16
    RORV  W13, W21, W18
    RORV  W16, W8, W19
    RORV  W20, W22, W17
    RORV  W3, W6, W19
    RORV  W2, W18, W18
    RORV  W9, W10, W15
    RORV  W6, W27, W12
    RORV  W4, W9, W6
    RORV  W19, W18, W19
    RORV  W5, W7, W20
    RORV  X9, X13, X19
    RORV  X18, X9, X8
    RORV  X21, X13, X16
    RORV  X16, X10, X13
    RORV  X9, X2, X10
    RORV  X19, X18, X2
    RORV  X8, X3, X3
    RORV  X10, X4, X9
    RORV  X2, X10, X16
    RORV  X20, X5, X27
    SBC  W18, W20, W17
    SBC  W4, W19, W6
    SBC  W9, W4, W5
    SBC  W22, W3, W8
    SBC  W2, W7, W22
    SBC  W13, W9, W13
    SBC  W10, W18, W10
    SBC  W9, W16, W12
    SBC  W6, W9, W2
    SBC  W18, W13, W6
    SBC  X27, X20, X21
    SBC  X8, X18, X22
    SBC  X19, X18, X10
    SBC  X12, X9, X19
    SBC  X15, X12, X8
    SBC  X17, X16, X23
    SBC  X6, X3, X13
    SBC  X23, X22, X10
    SBC  X4, X23, X17
    SBC  X9, X3, X13
    SBCS  W23, W3, W17
    SBCS  W21, W23, W20
    SBCS  W8, W2, W13
    SBCS  W23, W12, W27
    SBCS  W5, W18, W20
    SBCS  W21, W27, W21
    SBCS  W7, W3, W15
    SBCS  W10, W17, W13
    SBCS  W19, W4, W20
    SBCS  W27, W9, W20
    SBCS  X3, X9, X12
    SBCS  X10, X23, X5
    SBCS  X15, X6, X10
    SBCS  X12, X3, X22
    SBCS  X13, X12, X12
    SBCS  X6, X27, X15
    SBCS  X17, X6, X10
    SBCS  X6, X19, X13
    SBCS  X19, X17, X21
    SBCS  X15, X6, X7
    SBFIZ  W16, W19, #13, #16
    SBFIZ  W2, W15, #1, #12
    SBFIZ  W23, W16, #19, #6
    SBFIZ  W4, W12, #30, #1
    SBFIZ  W16, W4, #28, #4
    SBFIZ  W27, W2, #12, #17
    SBFIZ  W3, W3, #11, #4
    SBFIZ  W13, W27, #14, #17
    SBFIZ  W18, W3, #4, #25
    SBFIZ  W7, W13, #14, #16
    SBFIZ  X22, X5, #33, #28
    SBFIZ  X13, X23, #58, #6
    SBFIZ  X6, X22, #57, #2
    SBFIZ  X3, X6, #21, #18
    SBFIZ  X4, X18, #32, #8
    SBFIZ  X15, X4, #46, #14
    SBFIZ  X21, X22, #60, #3
    SBFIZ  X18, X7, #3, #51
    SBFIZ  X19, X13, #36, #1
    SBFIZ  X27, X15, #5, #11
    SBFM  W15, W18, #0x19, #0x19
    SBFM  W18, W21, #0x15, #0x13
    SBFM  W2, W16, #0x1f, #0x9
    SBFM  W20, W19, #0x1d, #0x8
    SBFM  W20, W12, #0x1, #0x1a
    SBFM  W4, W3, #0x17, #0xe
    SBFM  W17, W20, #0x1b, #0x14
    SBFM  W12, W17, #0x11, #0xa
    SBFM  W23, W12, #0x5, #0x19
    SBFM  W7, W19, #0x1, #0xd
    SBFM  X22, X18, #0x38, #0x3e
    SBFM  X3, X23, #0xc, #0x1
    SBFM  X17, X4, #0x16, #0x3
    SBFM  X16, X3, #0x21, #0x8
    SBFM  X4, X2, #0xf, #0x30
    SBFM  X3, X10, #0x28, #0x22
    SBFM  X19, X3, #0x28, #0xc
    SBFM  X10, X2, #0x19, #0x1
    SBFM  X12, X16, #0xf, #0x14
    SBFM  X18, X17, #0x32, #0x3
    SBFX  W20, W5, #0xc, #7
    SBFX  W15, W7, #0x0, #5
    SBFX  W2, W7, #0x13, #5
    SBFX  W16, W12, #0x13, #8
    SBFX  W7, W10, #0xc, #13
    SBFX  W3, W18, #0xc, #5
    SBFX  W13, W22, #0x16, #7
    SBFX  W17, W16, #0x14, #8
    SBFX  W8, W20, #0xb, #7
    SBFX  W20, W3, #0x8, #1
    SBFX  X3, X20, #0x1b, #26
    SBFX  X10, X7, #0x33, #3
    SBFX  X23, X27, #0x4, #35
    SBFX  X18, X19, #0x1e, #20
    SBFX  X17, X18, #0x33, #6
    SBFX  X7, X19, #0x3e, #1
    SBFX  X19, X22, #0x2, #39
    SBFX  X13, X7, #0x18, #23
    SBFX  X12, X23, #0xc, #10
    SBFX  X27, X3, #0x27, #4
    SDIV  W16, W7, W5
    SDIV  W23, W13, W5
    SDIV  W5, W18, W19
    SDIV  W7, W8, W10
    SDIV  W5, W3, W9
    SDIV  W22, W17, W5
    SDIV  W20, W22, W16
    SDIV  W3, W3, W7
    SDIV  W7, W20, W2
    SDIV  W10, W3, W7
    SDIV  X19, X12, X12
    SDIV  X22, X3, X9
    SDIV  X22, X19, X10
    SDIV  X16, X9, X17
    SDIV  X5, X22, X10
    SDIV  X8, X16, X16
    SDIV  X7, X13, X9
    SDIV  X18, X5, X8
    SDIV  X2, X7, X7
    SDIV  X16, X2, X2
    SMADDL  X20, W22, W23, X18
    SMADDL  X9, W20, W10, X16
    SMADDL  X20, W18, W13, X12
    SMADDL  X19, W8, W23, X7
    SMADDL  X2, W7, W12, X19
    SMADDL  X23, W6, W10, X3
    SMADDL  X22, W2, W18, X13
    SMADDL  X18, W23, W18, X5
    SMADDL  X17, W13, W5, X17
    SMADDL  X2, W7, W20, X12
    SMNEGL  X4, W21, W20
    SMNEGL  X3, W5, W3
    SMNEGL  X16, W15, W19
    SMNEGL  X15, W15, W4
    SMNEGL  X10, W23, W15
    SMNEGL  X6, W17, W12
    SMNEGL  X23, W5, W18
    SMNEGL  X13, W27, W5
    SMNEGL  X19, W22, W15
    SMNEGL  X20, W19, W23
    SMSUBL  X22, W10, W2, X16
    SMSUBL  X15, W7, W7, X7
    SMSUBL  X12, W9, W15, X3
    SMSUBL  X18, W13, W12, X20
    SMSUBL  X23, W22, W17, X16
    SMSUBL  X21, W4, W6, X27
    SMSUBL  X19, W21, W21, X21
    SMSUBL  X3, W19, W22, X18
    SMSUBL  X5, W22, W12, X21
    SMSUBL  X8, W8, W21, X13
    SMULH  X7, X17, X2
    SMULH  X10, X12, X5
    SMULH  X27, X18, X20
    SMULH  X5, X12, X27
    SMULH  X17, X16, X18
    SMULH  X9, X3, X16
    SMULH  X2, X6, X27
    SMULH  X27, X8, X19
    SMULH  X7, X19, X18
    SMULH  X8, X18, X7
    SMULL  X12, W10, W8
    SMULL  X19, W2, W12
    SMULL  X10, W15, W21
    SMULL  X18, W27, W17
    SMULL  X7, W6, W18
    SMULL  X13, W10, W10
    SMULL  X20, W18, W23
    SMULL  X8, W7, W10
    SMULL  X3, W9, W8
    SMULL  X19, W15, W18
    SUB  W18, W19, W10, SXTH #3
    SUB  W8, W27, W27, SXTW #3
    SUB  W16, W8, W5, UXTW #2
    SUB  W27, W13, W3, SXTH #1
    SUB  W21, W16, W27, UXTB #1
    SUB  W9, W4, W27, SXTX #2
    SUB  W3, W20, W18, UXTB #2
    SUB  W15, W3, W22, SXTH #1
    SUB  W13, W9, W15, UXTB #2
    SUB  W4, W7, W15, SXTB #3
    SUB  X17, X17, X6, SXTX #4
    SUB  X9, X12, W9, UXTH #3
    SUB  X23, X8, W8, UXTB #0
    SUB  X22, X10, W27, SXTB #0
    SUB  X6, X18, X20, SXTX #0
    SUB  X12, X16, W6, UXTB #0
    SUB  X5, X8, X6, SXTX #3
    SUB  X19, X12, W9, SXTH #1
    SUB  X10, X3, W22, SXTB #2
    SUB  X22, X5, W13, UXTH #1
    SUB  W22, W22, #0x8be
    SUB  W13, W21, #0x9ca
    SUB  W12, W10, #0xa07
    SUB  W8, W23, #0x895
    SUB  W6, W8, #0x69d
    SUB  W17, W12, #0x74a
    SUB  W8, W19, #0xc7, LSL #12
    SUB  W3, W12, #0xba, LSL #12
    SUB  W23, W6, #0x985
    SUB  W5, W13, #0xf88, LSL #12
    SUB  X10, X13, #0x348, LSL #12
    SUB  X19, X23, #0xd30, LSL #12
    SUB  X17, X7, #0xae7
    SUB  X5, X5, #0x40c, LSL #12
    SUB  X9, X4, #0x457, LSL #12
    SUB  X23, X17, #0x2ac, LSL #12
    SUB  X21, X10, #0xcab, LSL #12
    SUB  X17, X18, #0x857, LSL #12
    SUB  X6, X21, #0xe3e
    SUB  X6, X5, #0xaa7
    SUB  W5, W19, W8, LSL #7
    SUB  W4, W10, W4, LSR #8
    SUB  W3, W5, W22, LSL #12
    SUB  W19, W3, W7, LSR #5
    SUB  W5, W15, W19, ASR #23
    SUB  W18, W21, W23, LSR #6
    SUB  W17, W9, W7, LSL #24
    SUB  W8, W16, W4, LSR #26
    SUB  W19, W8, W18, LSR #8
    SUB  W12, W17, W20, ASR #27
    SUB  X3, X19, X7, LSR #61
    SUB  X9, X3, X6, ASR #28
    SUB  X2, X9, X20, LSR #48
    SUB  X19, X2, X2, LSL #17
    SUB  X2, X4, X19, ASR #59
    SUB  X9, X2, X20, LSR #56
    SUB  X10, X8, X9, LSR #2
    SUB  X7, X17, X10, LSR #59
    SUB  X13, X5, X7, LSR #3
    SUB  X17, X22, X3, LSR #36
    MOVZ  X11, #0x7637, LSL #0
    MOVK  X11, #0xffcb, LSL #16
    SUB  X14, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X11, #0xfe50, LSL #0
    MOVK  X11, #0xff04, LSL #16
    SUB  X14, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X11, #0x7636, LSL #0
    MOVK  X11, #0xffcb, LSL #16
    SUB  X14, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X11, #0xfff5, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X14, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X11, #0xab8f, LSL #0
    MOVK  X11, #0xfec6, LSL #16
    SUB  X14, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X11, #0x9000, LSL #0
    MOVK  X11, #0xffba, LSL #16
    SUB  X14, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X11, #0xffc1, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X14, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X11, #0x7637, LSL #0
    MOVK  X11, #0xffcb, LSL #16
    SUB  X14, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X11, #0x2234, LSL #0
    MOVK  X11, #0xc00d, LSL #16
    SUB  X14, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X11, #0x9000, LSL #0
    MOVK  X11, #0xffba, LSL #16
    SUB  X14, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X11, #0xadf5, LSL #0
    MOVK  X11, #0xe008, LSL #16
    SUB  X14, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X14, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X11, #0xf742, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X14, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X11, #0x7162, LSL #0
    MOVK  X11, #0xfb01, LSL #16
    SUB  X14, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X11, #0xfe41, LSL #0
    MOVK  X11, #0x282, LSL #16
    MOVK  X11, #0x1f7, LSL #32
    MOVK  X11, #0xfffe, LSL #48
    SUB  X14, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X14, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X11, #0xc636, LSL #0
    MOVK  X11, #0xff00, LSL #16
    SUB  X14, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X11, #0xf742, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X14, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X11, #0x3519, LSL #0
    MOVK  X11, #0xffd5, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X14, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X14, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTIntAlu_TestFail
    MOVZ  X2, #0xd454, LSL #0
    MOVK  X2, #0x83be, LSL #16
    MOVK  X2, #0x4ae2, LSL #32
    MOVK  X2, #0x9925, LSL #48
    MOVZ  X3, #0x482d, LSL #0
    MOVK  X3, #0x4a1f, LSL #16
    MOVK  X3, #0x9b, LSL #32
    MOVK  X3, #0xdc52, LSL #48
    MOVZ  X4, #0xd5c2, LSL #0
    MOVK  X4, #0x6281, LSL #16
    MOVK  X4, #0xe721, LSL #32
    MOVK  X4, #0x39ec, LSL #48
    MOVZ  X5, #0x424d, LSL #0
    MOVK  X5, #0x7c7b, LSL #16
    MOVK  X5, #0x5491, LSL #32
    MOVK  X5, #0x673e, LSL #48
    MOVZ  X6, #0xa2c0, LSL #0
    MOVK  X6, #0xd59a, LSL #16
    MOVK  X6, #0x560f, LSL #32
    MOVK  X6, #0x95f5, LSL #48
    MOVZ  X7, #0x2b67, LSL #0
    MOVK  X7, #0x76d3, LSL #16
    MOVK  X7, #0xa793, LSL #32
    MOVK  X7, #0x791e, LSL #48
    MOVZ  X8, #0x9b00, LSL #0
    MOVK  X8, #0x3383, LSL #16
    MOVK  X8, #0x77ad, LSL #32
    MOVK  X8, #0x3ff0, LSL #48
    MOVZ  X9, #0x3690, LSL #0
    MOVK  X9, #0xb482, LSL #16
    MOVK  X9, #0x4438, LSL #32
    MOVK  X9, #0x21f0, LSL #48
    MOVZ  X10, #0xc353, LSL #0
    MOVK  X10, #0x6809, LSL #16
    MOVK  X10, #0x749c, LSL #32
    MOVK  X10, #0xb0be, LSL #48
    MOVZ  X11, #0xffe1, LSL #0
    MOVK  X11, #0xcf0, LSL #16
    MOVK  X11, #0x49e8, LSL #32
    MOVK  X11, #0xec8d, LSL #48
    MOVZ  X12, #0xe3d9, LSL #0
    MOVK  X12, #0x290c, LSL #16
    MOVK  X12, #0xe39f, LSL #32
    MOVK  X12, #0x3bf3, LSL #48
    MOVZ  X13, #0x5856, LSL #0
    MOVK  X13, #0x41e5, LSL #16
    MOVK  X13, #0x4b06, LSL #32
    MOVK  X13, #0x56b8, LSL #48
    MOVZ  X14, #0xbff7, LSL #0
    MOVK  X14, #0x69d2, LSL #16
    MOVK  X14, #0x807e, LSL #32
    MOVK  X14, #0xd54c, LSL #48
    MOVZ  X15, #0x8a61, LSL #0
    MOVK  X15, #0x8539, LSL #16
    MOVK  X15, #0x3df3, LSL #32
    MOVK  X15, #0xed4b, LSL #48
    MOVZ  X16, #0x9a42, LSL #0
    MOVK  X16, #0xe545, LSL #16
    MOVK  X16, #0x791d, LSL #32
    MOVK  X16, #0x25b8, LSL #48
    MOVZ  X17, #0x78e7, LSL #0
    MOVK  X17, #0x192f, LSL #16
    MOVK  X17, #0xe66f, LSL #32
    MOVK  X17, #0xa942, LSL #48
    MOVZ  X18, #0xa280, LSL #0
    MOVK  X18, #0x2560, LSL #16
    MOVK  X18, #0xee52, LSL #32
    MOVK  X18, #0xb8e6, LSL #48
    MOVZ  X19, #0x3d06, LSL #0
    MOVK  X19, #0x756f, LSL #16
    MOVK  X19, #0xb163, LSL #32
    MOVK  X19, #0x6642, LSL #48
    MOVZ  X20, #0x723b, LSL #0
    MOVK  X20, #0x373e, LSL #16
    MOVK  X20, #0x9b8b, LSL #32
    MOVK  X20, #0xfc0b, LSL #48
    MOVZ  X21, #0x8d96, LSL #0
    MOVK  X21, #0xb29, LSL #16
    MOVK  X21, #0x440, LSL #32
    MOVK  X21, #0xd52f, LSL #48
    MOVZ  X22, #0x2d42, LSL #0
    MOVK  X22, #0x4cef, LSL #16
    MOVK  X22, #0x86f7, LSL #32
    MOVK  X22, #0xa7fc, LSL #48
    MOVZ  X23, #0x67db, LSL #0
    MOVK  X23, #0x4aa9, LSL #16
    MOVK  X23, #0xf740, LSL #32
    MOVK  X23, #0x205b, LSL #48
    MOVZ  X27, #0xb962, LSL #0
    MOVK  X27, #0x80a2, LSL #16
    MOVK  X27, #0xc360, LSL #32
    MOVK  X27, #0xb429, LSL #48
    SUBS  W4, W14, W19, SXTX #4
    SUBS  W3, W21, W14, SXTB #3
    SUBS  W21, W20, W23, SXTW #4
    SUBS  W20, W13, W13, SXTH #1
    SUBS  W14, W20, W11, UXTH #0
    SUBS  W23, W4, W3, UXTB #2
    SUBS  W14, W3, W18, SXTW #1
    SUBS  W10, W21, W8, SXTB #4
    SUBS  W9, W23, W10, SXTW #4
    SUBS  W19, W19, W14, SXTW #0
    SUBS  X22, X18, X19, UXTX #0
    SUBS  X5, X9, X5, SXTX #0
    SUBS  X13, X16, W22, SXTH #3
    SUBS  X23, X16, W5, SXTH #3
    SUBS  X18, X23, W13, UXTH #0
    SUBS  X21, X22, W7, UXTH #3
    SUBS  X19, X5, X19, UXTX #2
    SUBS  X10, X7, W5, UXTB #4
    SUBS  X23, X2, W4, SXTH #0
    SUBS  X7, X8, X14, UXTX #4
    SUBS  W3, W6, #0x973, LSL #12
    SUBS  W13, W8, #0x1d
    SUBS  W16, W3, #0x38c
    SUBS  W11, W7, #0xb4e, LSL #12
    SUBS  W3, W18, #0xef3
    SUBS  W7, W9, #0x27a, LSL #12
    SUBS  W2, W19, #0x1b1, LSL #12
    SUBS  W5, W16, #0x1df
    SUBS  W20, W23, #0xa99, LSL #12
    SUBS  W23, W8, #0x3a8
    SUBS  X19, X23, #0x54f
    SUBS  X8, X11, #0x510
    SUBS  X22, X20, #0xd6c
    SUBS  X18, X4, #0xd93
    SUBS  X13, X13, #0x4a4
    SUBS  X4, X10, #0x2f7
    SUBS  X10, X13, #0x2e2
    SUBS  X13, X2, #0x163
    SUBS  X16, X12, #0xe62, LSL #12
    SUBS  X23, X4, #0x9a0, LSL #12
    SUBS  W12, W7, W13, LSR #26
    SUBS  W17, W23, W3, LSR #23
    SUBS  W7, W22, W7, ASR #12
    SUBS  W20, W19, W19, ASR #30
    SUBS  W19, W5, W10, LSR #1
    SUBS  W9, W19, W23, LSL #26
    SUBS  W22, W10, W8, LSR #22
    SUBS  W3, W7, W16, ASR #25
    SUBS  W8, W18, W20, LSR #8
    SUBS  W4, W17, W17, ASR #9
    SUBS  X7, X4, X3, LSL #14
    SUBS  X23, X12, X12, LSL #41
    SUBS  X12, X23, X8, LSR #8
    SUBS  X3, X22, X22, LSL #20
    SUBS  X4, X17, X12, LSL #21
    SUBS  X17, X4, X7, LSR #22
    SUBS  X9, X9, X3, ASR #26
    SUBS  X6, X7, X3, LSL #1
    SUBS  X8, X23, X9, ASR #45
    SUBS  X18, X16, X10, LSL #13
    SXTB  W11, W4
    SXTB  W20, W17
    SXTB  W12, W4
    SXTB  W10, W22
    SXTB  W16, W14
    SXTB  W13, W14
    SXTB  W17, W6
    SXTB  W2, W21
    SXTB  W16, W8
    SXTB  W17, W16
    SXTB  X7, W20
    SXTB  X23, W17
    SXTB  X22, W7
    SXTB  X20, W18
    SXTB  X7, W11
    SXTB  X11, W22
    SXTB  X18, W8
    SXTB  X16, W13
    SXTB  X9, W19
    SXTB  X8, W11
    SXTH  W4, W20
    SXTH  W13, W12
    SXTH  W6, W13
    SXTH  W21, W2
    SXTH  W19, W21
    SXTH  W17, W4
    SXTH  W21, W23
    SXTH  W3, W10
    SXTH  W2, W7
    SXTH  W20, W21
    SXTH  X21, W16
    SXTH  X11, W8
    SXTH  X12, W11
    SXTH  X11, W17
    SXTH  X23, W23
    SXTH  X11, W14
    SXTH  X4, W21
    SXTH  X16, W19
    SXTH  X17, W16
    SXTH  X8, W11
    SXTW  X7, W3
    SXTW  X13, W6
    SXTW  X16, W2
    SXTW  X23, W19
    SXTW  X4, W23
    SXTW  X2, W12
    SXTW  X9, W13
    SXTW  X11, W8
    SXTW  X23, W4
    SXTW  X6, W12
    TST  W17, #0xdddddddd
    TST  W23, #0xc3ffc3ff
    TST  W11, #0x3c
    TST  W16, #0xc00003ff
    TST  W5, #0xfff0fff
    TST  W7, #0xffffff80
    TST  W9, #0x1ff00000
    TST  W6, #0x99999999
    TST  W14, #0x7f
    TST  W12, #0xff8000ff
    TST  X2, #0xfc07fc07fc07fc07
    TST  X22, #0x7000000070
    TST  X11, #0xffffffffe000007f
    TST  X22, #0x3fff00003fff0
    TST  X23, #0xffe00007ffe00007
    TST  X20, #0x4040404040404040
    TST  X10, #0x8000800080008
    TST  X10, #0xffffc00000
    TST  X22, #0x7fffffc0000000
    TST  X5, #0x1ffc00001ffc
    TST  W2, W8, ROR #6
    TST  W3, W23, LSL #24
    TST  W3, W5, LSL #12
    TST  W12, W7, LSR #21
    TST  W16, W22, ROR #1
    TST  W17, W3, ASR #12
    TST  W10, W20, ROR #4
    TST  W12, W8, ASR #5
    TST  W22, W12, LSR #13
    TST  W12, W3, LSR #4
    TST  X14, X10, ASR #22
    TST  X23, X6, LSR #7
    TST  X14, X19, ASR #16
    TST  X8, X5, LSR #53
    TST  X21, X10, LSL #15
    TST  X19, X3, ASR #28
    TST  X16, X3, LSL #30
    TST  X17, X13, LSR #5
    TST  X19, X10, LSL #44
    TST  X9, X7, LSL #43
    UBFIZ  W9, W16, #11, #5
    UBFIZ  W8, W20, #28, #3
    UBFIZ  W5, W9, #6, #13
    UBFIZ  W16, W13, #25, #6
    UBFIZ  W9, W19, #22, #6
    UBFIZ  W10, W2, #30, #1
    UBFIZ  W16, W18, #6, #26
    UBFIZ  W3, W22, #4, #26
    UBFIZ  W4, W19, #31, #1
    UBFIZ  W21, W19, #15, #12
    UBFIZ  X14, X21, #26, #15
    UBFIZ  X13, X9, #45, #2
    UBFIZ  X20, X21, #45, #1
    UBFIZ  X7, X8, #42, #19
    UBFIZ  X17, X7, #48, #1
    UBFIZ  X23, X20, #45, #10
    UBFIZ  X18, X14, #9, #5
    UBFIZ  X22, X8, #7, #13
    UBFIZ  X22, X3, #18, #1
    UBFIZ  X9, X17, #27, #11
    UBFM  W3, W13, #0x1a, #0x16
    UBFM  W7, W11, #0x9, #0xf
    UBFM  W18, W23, #0x12, #0x1b
    UBFM  W21, W16, #0xf, #0xc
    UBFM  W19, W18, #0x1d, #0x3
    UBFM  W14, W9, #0x1a, #0x5
    UBFM  W8, W4, #0x19, #0x1b
    UBFM  W10, W7, #0xa, #0xc
    UBFM  W17, W10, #0x1b, #0x0
    UBFM  W2, W14, #0x2, #0x9
    UBFM  X4, X17, #0x2d, #0x1f
    UBFM  X13, X8, #0x7, #0x18
    UBFM  X22, X21, #0x1c, #0x8
    UBFM  X9, X9, #0x35, #0x26
    UBFM  X16, X22, #0x2c, #0x1d
    UBFM  X20, X18, #0x22, #0x1b
    UBFM  X21, X2, #0x1f, #0x12
    UBFM  X11, X3, #0x34, #0x29
    UBFM  X14, X19, #0x32, #0x36
    UBFM  X23, X2, #0x21, #0x1f
    UBFX  W3, W23, #0x8, #17
    UBFX  W13, W14, #0x7, #20
    UBFX  W4, W16, #0x1c, #3
    UBFX  W14, W13, #0x12, #7
    UBFX  W16, W11, #0xa, #17
    UBFX  W22, W5, #0x1b, #4
    UBFX  W19, W20, #0x1, #26
    UBFX  W20, W4, #0x19, #3
    UBFX  W10, W20, #0xd, #10
    UBFX  W20, W19, #0x1b, #2
    UBFX  X17, X16, #0x6, #42
    UBFX  X18, X21, #0x1b, #10
    UBFX  X5, X22, #0x13, #19
    UBFX  X11, X12, #0xb, #44
    UBFX  X13, X11, #0x22, #12
    UBFX  X4, X17, #0x1, #60
    UBFX  X19, X10, #0x3c, #2
    UBFX  X10, X23, #0x4, #38
    UBFX  X13, X23, #0x23, #7
    UBFX  X17, X18, #0x1f, #8
    UDIV  W16, W5, W4
    UDIV  W23, W11, W10
    UDIV  W21, W14, W12
    UDIV  W5, W18, W23
    UDIV  W12, W13, W17
    UDIV  W12, W4, W10
    UDIV  W2, W12, W17
    UDIV  W18, W20, W6
    UDIV  W17, W19, W5
    UDIV  W22, W13, W7
    UDIV  X10, X23, X6
    UDIV  X19, X18, X22
    UDIV  X12, X16, X6
    UDIV  X11, X17, X21
    UDIV  X13, X19, X13
    UDIV  X12, X10, X10
    UDIV  X12, X12, X14
    UDIV  X4, X2, X17
    UDIV  X16, X4, X13
    UDIV  X23, X22, X5
    UMADDL  X14, W11, W14, X7
    UMADDL  X11, W4, W20, X14
    UMADDL  X18, W12, W16, X23
    UMADDL  X19, W3, W7, X17
    UMADDL  X14, W2, W13, X20
    UMADDL  X13, W19, W18, X8
    UMADDL  X12, W11, W23, X23
    UMADDL  X6, W22, W3, X12
    UMADDL  X18, W11, W12, X17
    UMADDL  X10, W21, W9, X5
    UMNEGL  X4, W22, W3
    UMNEGL  X21, W4, W9
    UMNEGL  X4, W23, W16
    UMNEGL  X19, W22, W6
    UMNEGL  X9, W20, W11
    UMNEGL  X2, W20, W22
    UMNEGL  X16, W10, W8
    UMNEGL  X17, W7, W9
    UMNEGL  X14, W2, W10
    UMNEGL  X18, W14, W13
    UMSUBL  X9, W17, W16, X22
    UMSUBL  X5, W11, W9, X4
    UMSUBL  X11, W5, W8, X5
    UMSUBL  X3, W11, W10, X21
    UMSUBL  X20, W18, W12, X16
    UMSUBL  X9, W23, W3, X19
    UMSUBL  X8, W7, W6, X16
    UMSUBL  X7, W13, W16, X11
    UMSUBL  X21, W16, W13, X10
    UMSUBL  X16, W11, W3, X23
    UMULH  X23, X17, X2
    UMULH  X5, X19, X2
    UMULH  X10, X13, X4
    UMULH  X2, X16, X20
    UMULH  X17, X9, X2
    UMULH  X20, X8, X21
    UMULH  X9, X14, X23
    UMULH  X19, X20, X10
    UMULH  X8, X7, X19
    UMULH  X12, X17, X9
    UMULL  X17, W8, W10
    UMULL  X14, W4, W12
    UMULL  X2, W22, W17
    UMULL  X6, W16, W6
    UMULL  X8, W2, W17
    UMULL  X10, W23, W4
    UMULL  X4, W13, W10
    UMULL  X9, W8, W6
    UMULL  X16, W5, W5
    UMULL  X22, W4, W4
    UXTB  W14, W20
    UXTB  W4, W14
    UXTB  W10, W2
    UXTB  W3, W8
    UXTB  W7, W2
    UXTB  W23, W3
    UXTB  W13, W7
    UXTB  W7, W2
    UXTB  W3, W20
    UXTB  W18, W22
    UXTH  W14, W12
    UXTH  W14, W14
    UXTH  W5, W18
    UXTH  W21, W9
    UXTH  W2, W22
    UXTH  W23, W21
    UXTH  W21, W2
    UXTH  W2, W8
    UXTH  W9, W22
    UXTH  W8, W4
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X2, #0x6764, LSL #0
    MOVK  X2, #0x890f, LSL #16
    MOVK  X2, #0xec06, LSL #32
    MOVK  X2, #0xfdfe, LSL #48
    MOVZ  X3, #0x9156, LSL #0
    MOVK  X3, #0xb52e, LSL #16
    MOVK  X3, #0x916d, LSL #32
    MOVK  X3, #0xa485, LSL #48
    MOVZ  X4, #0x2178, LSL #0
    MOVK  X4, #0x9c81, LSL #16
    MOVK  X4, #0x3f82, LSL #32
    MOVK  X4, #0x4583, LSL #48
    MOVZ  X5, #0x7e9e, LSL #0
    MOVK  X5, #0x1dba, LSL #16
    MOVK  X5, #0x62c1, LSL #32
    MOVK  X5, #0xaec7, LSL #48
    MOVZ  X6, #0x3fc1, LSL #0
    MOVK  X6, #0xcc7f, LSL #16
    MOVK  X6, #0x2a3f, LSL #32
    MOVK  X6, #0x365e, LSL #48
    MOVZ  X7, #0xe80a, LSL #0
    MOVK  X7, #0x5f0a, LSL #16
    MOVK  X7, #0xaa50, LSL #32
    MOVK  X7, #0xd93a, LSL #48
    MOVZ  X8, #0x26e7, LSL #0
    MOVK  X8, #0x68de, LSL #16
    MOVK  X8, #0xf6ee, LSL #32
    MOVK  X8, #0xd3ca, LSL #48
    MOVZ  X9, #0x5626, LSL #0
    MOVK  X9, #0xe5a0, LSL #16
    MOVK  X9, #0xdd7a, LSL #32
    MOVK  X9, #0xbdb6, LSL #48
    MOVZ  X10, #0x4a98, LSL #0
    MOVK  X10, #0xa68d, LSL #16
    MOVK  X10, #0xc54b, LSL #32
    MOVK  X10, #0x411, LSL #48
    MOVZ  X11, #0x4ece, LSL #0
    MOVK  X11, #0x3ad2, LSL #16
    MOVK  X11, #0x7f2, LSL #32
    MOVK  X11, #0x69b2, LSL #48
    MOVZ  X12, #0xa662, LSL #0
    MOVK  X12, #0xb317, LSL #16
    MOVK  X12, #0xbfa8, LSL #32
    MOVK  X12, #0x3138, LSL #48
    MOVZ  X13, #0x2ff, LSL #0
    MOVK  X13, #0x45a8, LSL #16
    MOVK  X13, #0xaec5, LSL #32
    MOVK  X13, #0xd106, LSL #48
    MOVZ  X14, #0x3bad, LSL #0
    MOVK  X14, #0x3522, LSL #16
    MOVK  X14, #0x1778, LSL #32
    MOVK  X14, #0x1d1, LSL #48
    MOVZ  X15, #0xf709, LSL #0
    MOVK  X15, #0x3d9b, LSL #16
    MOVK  X15, #0x55a0, LSL #32
    MOVK  X15, #0xcaff, LSL #48
    MOVZ  X16, #0x21c8, LSL #0
    MOVK  X16, #0x8a9e, LSL #16
    MOVK  X16, #0x8142, LSL #32
    MOVK  X16, #0xae83, LSL #48
    MOVZ  X17, #0x6e3a, LSL #0
    MOVK  X17, #0xc153, LSL #16
    MOVK  X17, #0x8313, LSL #32
    MOVK  X17, #0xb1bc, LSL #48
    MOVZ  X18, #0xcb5f, LSL #0
    MOVK  X18, #0x7ef9, LSL #16
    MOVK  X18, #0x7aed, LSL #32
    MOVK  X18, #0x96a3, LSL #48
    MOVZ  X19, #0x4169, LSL #0
    MOVK  X19, #0xe3ec, LSL #16
    MOVK  X19, #0xe49f, LSL #32
    MOVK  X19, #0x6905, LSL #48
    MOVZ  X20, #0x212c, LSL #0
    MOVK  X20, #0x7745, LSL #16
    MOVK  X20, #0xb16a, LSL #32
    MOVK  X20, #0xb29, LSL #48
    MOVZ  X21, #0x4a1c, LSL #0
    MOVK  X21, #0xa1bd, LSL #16
    MOVK  X21, #0xcfb6, LSL #32
    MOVK  X21, #0xa40f, LSL #48
    MOVZ  X22, #0x55a0, LSL #0
    MOVK  X22, #0x8b67, LSL #16
    MOVK  X22, #0x47d4, LSL #32
    MOVK  X22, #0x3eaa, LSL #48
    MOVZ  X23, #0xeb26, LSL #0
    MOVK  X23, #0x2084, LSL #16
    MOVK  X23, #0x6f0c, LSL #32
    MOVK  X23, #0xfb06, LSL #48
    MOVZ  X27, #0x316b, LSL #0
    MOVK  X27, #0xbdb6, LSL #16
    MOVK  X27, #0x25c0, LSL #32
    MOVK  X27, #0xe4ae, LSL #48
    MOVZ  X9, #0xa, LSL #0
TSRTIntAlu_label_0:
    SMSUBL  X20, W6, W10, X9
    ASR  W11, W27, #0xa
    BIC  W15, W20, W22, LSL #23
    ADCS  X22, X19, X15
    RBIT  X22, X23
    CSINV  X27, X3, X11, AL
    UDIV  W22, W18, W22
    EOR  W17, W27, #0x7fff0
    ADDS  W19, W17, W21, UXTH #0
    CLZ  X2, X4
    REV  W2, W23
    ADDS  W16, W16, W12, ASR #3
    AND  X27, X13, X19, ROR #35
    MNEG  X21, X16, X3
    BICS  X4, X15, X21, ROR #10
    NEGS  X11, X20, ASR #9
    UDIV  W17, W17, W27
    EXTR  W23, W10, W4, #0xe
    EON  X27, X14, X7, LSR #10
    UDIV  X27, X27, X3
    EXTR  W12, W23, W13, #0x4
    ORR  W4, W9, W19, ROR #4
    CSINV  W21, W2, W16, LT
    SUBS  W14, W12, W15, LSR #14
    ASR  W12, W2, #0xc
    SXTB  X2, W3
    SUBS  X19, X14, #0xf15, LSL #12
    TST  X16, #0xfcfcfcfcfcfcfcfc
    AND  X3, X9, #0x3fffff8000000000
    MADD  X13, X19, X21, X2
    UDIV  X11, X17, X12
    EON  W15, W4, W4, ROR #3
    UXTB  W12, W4
    SXTW  X17, W12
    ASRV  X4, X11, X6
    EON  X23, X4, X10, LSR #23
    BICS  X7, X11, X27, ASR #53
    ADDS  X27, X3, X3, UXTX #3
    BFM  W19, W17, #0xd, #0x1f
    NEG  X6, X3, LSR #58
    NGCS  W21, W7
    BICS  X10, X4, X9, ASR #26
    SMULH  X20, X27, X23
    ADD  W3, W13, #0xb97
    ROR  X12, X2, X19
    ADD  X12, X12, X6, LSR #8
    UBFM  X16, X21, #0xd, #0x7
    SXTB  X14, W20
    SUB  X17, X12, X12, ASR #16
    REV  X19, X15
    UMULL  X21, W3, W4
    ADDS  X4, X14, W17, SXTW #1
    SXTW  X11, W7
    NEG  X6, X10
    AND  X17, X20, #0x7ffff00000
    ADCS  X3, X3, X10
    UXTB  W12, W15
    ASR  X20, X12, #0x12
    TST  W19, #0x1ff81ff8
    SUB  X13, X16, W16, UXTW #0
    CSEL  X19, X17, X6, CC
    NGCS  W15, W14
    ASR  W6, W9, #0x1f
    AND  W10, W16, #0x1800180
    SUB  X3, X15, #0x8d3
    ADD  X15, X13, #0xcab
    BFM  W13, W4, #0x1b, #0x0
    SMNEGL  X14, W23, W11
    UMULH  X11, X7, X14
    SUB  X2, X19, X16, ASR #16
    SXTB  X23, W15
    SBFIZ  X15, X10, #56, #6
    TST  W20, W15, ASR #4
    SXTH  W10, W3
    ORR  W19, W4, #0xe000e
    UDIV  X14, X3, X10
    SXTB  X20, W19
    ORR  W16, W2, #0xfc000fff
    MADD  W17, W6, W21, W11
    RORV  W3, W14, W13
    EXTR  X21, X3, X12, #0x36
    NGC  W21, W20
    ASRV  W13, W16, W2
    ROR  W19, W13, #0x15
    SUBS  X16, X18, X11, SXTX #1
    ADD  W19, W7, #0xb9c
    SBFIZ  W10, W21, #28, #2
    MSUB  X13, X23, X17, X19
    CLZ  X22, X10
    CSNEG  X14, X2, X16, AL
    NGC  X6, X17
    ADCS  W23, W19, W7
    REV32  X23, X2
    REV16  X15, X14
    RORV  W16, W21, W23
    BIC  W18, W21, W18, LSR #31
    AND  W11, W15, W10, ROR #2
    NEG  X15, X22, LSL #51
    SBFM  W7, W6, #0x19, #0x19
    AND  X4, X16, #0x18001800180018
    UMULL  X20, W27, W18
    SDIV  W15, W13, W4
    MSUB  W10, W7, W12, W4
    MUL  W3, W7, W6
    BFM  X7, X17, #0x0, #0x0
    EON  W16, W27, W20, LSR #6
    EON  W7, W15, W10, LSR #14
    NGC  X23, X23
    SBFX  W3, W3, #0x14, #9
    SDIV  W27, W6, W16
    UBFIZ  X7, X11, #3, #19
    BFM  X16, X3, #0x26, #0x1b
    ORR  X17, X16, #0xfffffffc000001ff
    UBFIZ  X18, X7, #35, #8
    SMADDL  X21, W15, W20, X9
    SUB  X13, X11, #0x1b6, LSL #12
    ADCS  X10, X27, X21
    NGC  W27, W23
    SBFIZ  W3, W13, #18, #7
    MNEG  X3, X17, X13
    NGC  W12, W27
    SBFX  X15, X23, #0x18, #35
    SBFX  W11, W18, #0x10, #13
    UBFIZ  X6, X10, #63, #1
    UXTB  W22, W23
    ASRV  X7, X4, X12
    BIC  W18, W15, W18, LSL #2
    SMADDL  X18, W16, W21, X22
    RBIT  W27, W6
    RBIT  W4, W16
    ORN  X10, X7, X7, ROR #56
    REV  X17, X11
    SBFIZ  W19, W17, #15, #2
    SUB  X6, X15, #0x4c
    SXTW  X22, W14
    RORV  X12, X18, X10
    ADDS  X21, X27, X22, LSL #47
    ADD  X22, X21, X3, LSR #36
    UXTB  W16, W12
    ROR  X4, X6, X16
    UBFM  W18, W2, #0x17, #0x10
    RORV  X13, X4, X21
    AND  W27, W13, #0x3fffe00
    SMSUBL  X20, W22, W19, X4
    CLZ  W17, W18
    BICS  W4, W17, W20, LSR #7
    ADD  X2, X6, W19, UXTB #0
    ORN  X20, X19, X16, ASR #38
    SBC  W17, W12, W9
    BICS  W6, W16, W21, ASR #2
    ROR  X16, X20, X21
    SUBS  W19, W20, #0xc65
    SUBS  W18, W16, #0x1ad
    NEG  W7, W13, ASR #5
    SUB  X10, X21, X18, LSL #16
    SUB  W13, W14, W6, SXTX #1
    ADDS  W16, W9, #0xc08, LSL #12
    SBFIZ  W12, W16, #11, #21
    EON  X20, X12, X2, LSR #36
    ADDS  X14, X2, #0xbbe, LSL #12
    AND  X16, X27, #0x7ffffffff8000
    NEGS  X22, X27, LSL #36
    EON  W27, W7, W13, LSL #9
    ASRV  W17, W22, W17
    SUBS  X22, X16, W27, UXTW #0
    UMSUBL  X6, W3, W13, X22
    SDIV  W7, W22, W19
    AND  W18, W7, W14, ASR #5
    EON  X13, X14, X18, ROR #45
    BFI  W12, W10, #20, #9
    ANDS  W21, W14, #0x7c
    BFXIL  W16, W13, #0xe, #7
    EOR  W23, W7, #0xffffc
    ASR  X18, X21, X16
    ASR  W27, W22, #0x9
    ADD  X21, X27, W11, SXTB #1
    ADD  X10, X11, X20, LSL #62
    SBCS  X20, X17, X10
    ASR  X2, X3, X21
    ADDS  W22, W23, #0xcf0, LSL #12
    CSNEG  X17, X20, X20, CS
    UXTB  W14, W2
    UMADDL  X7, W13, W14, X14
    NGC  X10, X6
    MSUB  W14, W17, W12, W12
    SUB  W16, W4, W7, LSR #5
    SMULL  X4, W18, W14
    NEG  W21, W4, LSR #27
    ASR  W11, W19, W22
    SXTB  X18, W4
    CSNEG  W4, W2, W15, EQ
    ADC  W23, W4, W11
    ADD  X6, X10, X22, LSL #3
    BIC  X3, X18, X17, LSR #23
    ORN  X12, X7, X14, LSL #21
    SXTW  X19, W12
    SUB  W14, W12, W6, ASR #31
    UMULL  X19, W21, W19
    SXTB  W19, W27
    BFM  W21, W3, #0x1b, #0x9
    SUBS  X9, X9, #0x1
    B.NE  TSRTIntAlu_label_0
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X5, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X8, #0xff01, LSL #0
    MOVK  X8, #0xf8ff, LSL #16
    SUB  X5, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X8, #0x5510, LSL #0
    MOVK  X8, #0x385b, LSL #16
    MOVK  X8, #0x9e09, LSL #32
    MOVK  X8, #0xffe4, LSL #48
    SUB  X5, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X8, #0x2db3, LSL #0
    MOVK  X8, #0xbd3, LSL #16
    MOVK  X8, #0x40, LSL #32
    SUB  X5, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X8, #0x1058, LSL #0
    MOVK  X8, #0x3261, LSL #16
    MOVK  X8, #0x9e09, LSL #32
    MOVK  X8, #0xffe4, LSL #48
    SUB  X5, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X5, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xfffd, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X5, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X8, #0x1f4c, LSL #0
    MOVK  X8, #0x404c, LSL #16
    MOVK  X8, #0x1ec, LSL #32
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X5, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X8, #0xff, LSL #0
    MOVK  X8, #0x700, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X5, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X8, #0x66b3, LSL #0
    MOVK  X8, #0xffa1, LSL #16
    SUB  X5, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X5, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X8, #0xfff7, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X5, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X5, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X8, #0x4897, LSL #0
    MOVK  X8, #0xbf, LSL #16
    SUB  X5, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X8, #0xff01, LSL #0
    MOVK  X8, #0xf8ff, LSL #16
    SUB  X5, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X8, #0xc1f7, LSL #0
    MOVK  X8, #0x1, LSL #16
    SUB  X5, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
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
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X18, #0xa, LSL #0
TSRTIntAlu_label_1:
    ADD  W12, W19, W13, SXTH #1
    ADD  X8, X16, #0xe68, LSL #12
    RORV  X7, X2, X6
    CSNEG  W6, W5, W2, CC
    ADDS  X16, X6, X23, LSR #45
    ROR  W17, W8, #0x1a
    SBC  X27, X16, X9
    REV32  X7, X14
    ROR  W19, W12, W7
    SXTH  X2, W13
    ANDS  X8, X20, X19, LSL #58
    SBC  W23, W6, W10
    EOR  X13, X2, X17, ASR #19
    SUB  W5, W22, W15, UXTB #3
    CSEL  X14, X22, X22, NV
    ORR  X7, X17, #0xe000000000007fff
    ASRV  X9, X9, X8
    UDIV  X7, X15, X9
    ASRV  X10, X7, X8
    EOR  X17, X3, X14, ASR #33
    SBFX  X19, X5, #0x24, #10
    ADDS  X27, X3, X23, ASR #54
    SUB  X9, X13, X15, LSR #22
    UXTB  W7, W13
    UMNEGL  X22, W10, W9
    SBCS  W9, W17, W19
    AND  X17, X27, #0x3f0000003f000
    ORR  W16, W17, W9, ASR #28
    UXTH  W14, W22
    NGCS  W5, W7
    UMSUBL  X16, W16, W9, X10
    ADD  X3, X16, #0x68
    NGC  X15, X3
    NGC  W6, W14
    ROR  W14, W3, #0xe
    ADD  W12, W19, #0xb72
    SXTW  X23, W5
    ASR  W10, W12, W6
    ADD  X20, X9, X20, LSR #44
    REV32  X27, X14
    ROR  W19, W15, W27
    EON  W6, W23, W10, ROR #21
    NEG  W5, W6, LSL #18
    UBFIZ  X14, X19, #53, #1
    SBCS  X23, X20, X5
    CLS  X20, X18
    UMULH  X20, X9, X7
    UMSUBL  X22, W23, W10, X7
    REV32  X5, X6
    NGCS  W7, W27
    SUBS  X23, X5, W6, SXTH #2
    AND  W6, W7, W18
    ORR  W12, W18, W17, LSR #9
    CLZ  W19, W17
    ORR  W5, W17, W7, LSL #3
    SUBS  X14, X15, W13, UXTH #4
    UBFIZ  X10, X19, #45, #2
    ORR  W6, W5, W23, LSL #27
    SUBS  X13, X20, X22, UXTX #2
    ADDS  X7, X10, X6, ASR #22
    CSINC  X15, X15, X13, LT
    ASR  X9, X22, X20
    CSINV  X19, X14, X12, LT
    ORN  X9, X19, X7, LSL #20
    REV  W5, W15
    UMSUBL  X8, W11, W27, X8
    ADDS  X19, X5, W5, SXTH #4
    ADD  X14, X12, W3, SXTH #3
    ASR  X5, X9, #0x34
    UXTB  W23, W14
    ADD  X19, X22, X14, ASR #23
    BIC  W12, W27, W23, LSR #11
    ADC  W23, W3, W15
    EON  X19, X3, X5, LSR #28
    CSNEG  X14, X22, X15, MI
    ADD  X27, X9, X15, LSL #18
    MVN  W6, W9, ASR #1
    SUBS  X5, X20, X7, LSR #5
    TST  W8, W13, ASR #26
    SXTW  X9, W27
    REV16  W8, W10
    MNEG  W2, W14, W5
    BIC  X9, X17, X20, LSR #14
    BICS  W10, W5, W23, LSR #16
    EOR  X15, X17, X8, LSL #15
    EON  X5, X8, X5, LSL #54
    ADC  W13, W15, W27
    CLZ  X15, X22
    NEG  W20, W9, LSR #7
    SBC  W22, W13, W19
    UBFM  X9, X10, #0x2b, #0xe
    REV32  X23, X2
    ADD  W13, W12, #0x2b4
    REV16  X22, X15
    BICS  X19, X15, X10, LSR #63
    CSINV  W7, W23, W9, LT
    SXTB  X7, W13
    ADD  W10, W5, W14, LSL #17
    EOR  W10, W9, #0xfbfbfbfb
    SBFM  W5, W20, #0xa, #0x7
    UMSUBL  X13, W6, W6, X7
    SBCS  X2, X5, X19
    UBFM  X23, X22, #0x2b, #0x23
    ADD  W9, W2, W10, UXTX #3
    SXTB  X17, W9
    MADD  W19, W17, W13, W19
    REV16  X12, X7
    CSNEG  W20, W17, W11, GE
    UBFM  W14, W6, #0x12, #0x13
    UBFX  W17, W27, #0x1e, #1
    MSUB  W23, W9, W22, W14
    MUL  X15, X3, X15
    RBIT  W13, W15
    BFM  W27, W9, #0xe, #0xd
    ADC  X3, X15, X7
    ADD  X11, X5, #0xbcf
    TST  W17, W23, LSL #25
    BICS  X15, X2, X13, ASR #7
    BFXIL  X7, X3, #0x15, #7
    ORR  W13, W5, W12, ASR #6
    MVN  W10, W22, LSR #15
    MADD  W2, W13, W20, W2
    NGCS  W5, W2
    ADD  W23, W19, #0xbac
    SDIV  X19, X15, X3
    NGCS  X11, X9
    UMSUBL  X22, W19, W19, X2
    EON  W3, W22, W8, ASR #2
    EON  W12, W3, W27, LSL #29
    NGCS  W23, W23
    EOR  X2, X20, X14, LSR #41
    ADC  X15, X7, X5
    SXTB  X3, W10
    SBCS  W14, W16, W3
    MNEG  W5, W10, W5
    UXTH  W15, W11
    CSNEG  W8, W12, W23, LE
    CSEL  W11, W15, W17, CS
    ANDS  W13, W11, W14, ROR #5
    MADD  X20, X2, X5, X22
    SMULH  X10, X13, X19
    ADCS  X16, X10, X8
    BFI  X10, X3, #44, #1
    SUBS  X8, X19, W16, UXTB #0
    RBIT  W23, W18
    TST  W9, W9, LSL #26
    RBIT  X11, X17
    ADDS  X17, X16, X23, LSR #17
    AND  W5, W11, W13, LSR #20
    EON  X16, X12, X14, LSR #55
    UMADDL  X11, W10, W11, X15
    TST  W2, W9, ROR #28
    ADDS  W10, W5, W20, ASR #6
    CLS  W27, W11
    ADDS  W12, W11, W7, LSR #4
    SBFM  X19, X19, #0x1a, #0x26
    ANDS  W22, W5, W13, LSL #11
    SUB  X23, X13, #0x45
    UBFM  X13, X8, #0x1c, #0x29
    UBFM  X23, X14, #0x30, #0x3
    TST  W13, #0x1ffffff8
    EXTR  X14, X19, X8, #0xe
    ASR  W19, W12, #0x18
    UMADDL  X11, W27, W19, X22
    RBIT  X22, X23
    MNEG  W16, W11, W13
    SXTH  W23, W22
    REV  X27, X13
    CSINC  W9, W17, W10, VS
    SBC  X22, X27, X23
    BFM  W15, W5, #0x6, #0x4
    SBFX  W12, W22, #0xe, #6
    ADCS  X3, X3, X8
    SUB  W27, W15, #0x114
    EON  X10, X27, X12, LSL #50
    ASR  X23, X9, #0x35
    SXTB  W27, W10
    SDIV  W5, W10, W23
    UXTH  W11, W27
    CLS  W15, W16
    AND  W19, W11, W11, ASR #15
    ADDS  W27, W9, W3, SXTW #1
    ORR  X17, X9, X19, LSR #58
    NEGS  X5, X15, LSR #51
    SUB  X15, X5, X27, LSL #37
    ADDS  X11, X15, W17, SXTW #0
    EXTR  X19, X3, X5, #0x2d
    UMADDL  X13, W18, W2, X11
    SUB  W5, W18, #0x7c6, LSL #12
    SMULH  X10, X8, X11
    SBFM  W7, W22, #0x14, #0x1d
    SBFX  W22, W15, #0x5, #5
    BICS  X16, X8, X27, ASR #63
    SUBS  X17, X20, #0x12
    SMADDL  X11, W16, W12, X22
    SUBS  W2, W6, #0x4f6
    ADDS  W9, W12, W12, ASR #31
    UBFIZ  X3, X8, #24, #28
    ASR  W15, W5, W27
    AND  X27, X15, X9, ROR #0
    SUBS  X18, X18, #0x1
    B.NE  TSRTIntAlu_label_1
    MOVZ  X21, #0xfb0a, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X4, X21, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x500, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xf, LSL #48
    SUB  X4, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X21, #0xa001, LSL #0
    MOVK  X21, #0xff83, LSL #16
    SUB  X4, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X4, X21, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X21, #0xff05, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X4, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X21, #0xfffe, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X4, X21, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X21, #0xfb, LSL #0
    SUB  X4, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X4, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X21, #0xbb5f, LSL #0
    MOVK  X21, #0x1, LSL #16
    MOVK  X21, #0xbfa1, LSL #32
    MOVK  X21, #0xffc8, LSL #48
    SUB  X4, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0x3, LSL #48
    SUB  X4, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X21, #0x7400, LSL #0
    MOVK  X21, #0xfff0, LSL #16
    SUB  X4, X21, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X21, #0xff05, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X21, #0xfe79, LSL #0
    MOVK  X21, #0x6e, LSL #16
    MOVK  X21, #0x4a68, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X4, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xf820, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X4, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X21, #0xfe8b, LSL #0
    MOVK  X21, #0x6e, LSL #16
    MOVK  X21, #0x4a68, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X4, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X21, #0x7400, LSL #0
    MOVK  X21, #0xfff0, LSL #16
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
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
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    MOVZ  X12, #0xa, LSL #0
TSRTIntAlu_label_2:
    UDIV  W11, W27, W12
    MSUB  X15, X11, X27, X20
    REV  X22, X17
    ADDS  W8, W18, W11, LSR #24
    RORV  X15, X12, X27
    SXTH  X27, W22
    SXTB  W23, W15
    SUBS  X6, X4, W27, UXTB #1
    CSNEG  X19, X27, X2, VS
    ORR  W18, W21, #0xf8f8f8f8
    ADC  W19, W15, W5
    ANDS  W4, W23, #0x1ffff
    TST  X6, X9, ASR #62
    UXTB  W17, W10
    EOR  W11, W20, #0xfe0007ff
    CSNEG  X8, X20, X11, EQ
    SUB  W21, W4, W27, LSR #4
    EON  X2, X19, X11, ASR #28
    SMSUBL  X20, W8, W11, X21
    MVN  X22, X20, ROR #44
    SUB  X5, X22, X17, LSR #53
    UBFX  W11, W5, #0x7, #14
    SUBS  W10, W12, W10, SXTW #4
    ANDS  W19, W10, #0x7fe07fe
    SXTB  W10, W10
    EOR  X5, X14, #0xfff801ffffffffff
    NEG  W16, W6, ASR #5
    REV16  W14, W10
    ROR  W6, W27, #0x7
    TST  W18, #0xe0ffffff
    SBFIZ  W17, W5, #25, #3
    ADDS  X27, X20, X19, ASR #45
    UBFIZ  X23, X17, #18, #30
    SMULH  X4, X27, X27
    MVN  W20, W5, ROR #0
    SDIV  X22, X9, X20
    NGC  W19, W16
    BICS  W5, W4, W19, ROR #22
    SBFX  W15, W6, #0x8, #19
    SUB  X18, X11, X27, ASR #5
    BICS  W10, W14, W15, ROR #27
    EOR  W16, W21, W18, ASR #6
    AND  X13, X5, X16, ASR #42
    ADD  X6, X22, X13, ASR #29
    ADD  X20, X6, #0xe03, LSL #12
    SBFIZ  X16, X10, #15, #9
    RBIT  W5, W19
    SBC  W13, W20, W17
    ORR  X9, X23, X5, LSL #43
    AND  X5, X13, X23, LSL #61
    ORR  X15, X5, #0xc03fc03fc03fc03f
    ORR  W18, W9, #0x8000800
    ADD  W11, W22, W6, SXTH #3
    ADDS  W9, W16, W18, LSR #7
    ORR  X16, X20, #0x1ffe1ffe1ffe1ffe
    CSINV  W4, W16, W20, VC
    MSUB  W20, W15, W11, W15
    ANDS  X13, X18, #0xfffc0ffffffc0fff
    CSEL  W19, W4, W13, EQ
    ORR  W11, W4, #0x3fe000
    BICS  X23, X15, X19, LSL #32
    MVN  W16, W23, ASR #2
    ADDS  X21, X10, X13, ASR #25
    ORR  W18, W21, W9, ASR #17
    ORR  X13, X16, X17, LSL #8
    UXTH  W5, W27
    SBFX  W6, W13, #0xf, #6
    UXTH  W15, W18
    ORN  X22, X20, X20, LSL #53
    NEG  W23, W15, LSL #17
    MVN  X9, X27, ASR #5
    ASRV  X19, X8, X5
    ANDS  W18, W23, W22, ASR #1
    ANDS  X20, X19, #0xfe00001ffe00001f
    EOR  X9, X2, X11, LSL #58
    ROR  X4, X15, #0x3
    ADD  W14, W18, #0xd5d
    SUB  W13, W13, W15, ASR #5
    BIC  X5, X14, X9, LSR #39
    MSUB  X18, X4, X5, X5
    ANDS  W21, W18, W18, ROR #26
    MNEG  W19, W17, W21
    SDIV  W9, W19, W4
    REV  W17, W15
    UMULL  X19, W17, W17
    ORN  W4, W6, W13, ASR #30
    CLZ  X16, X16
    SMNEGL  X21, W9, W9
    ANDS  W2, W20, W20, LSL #4
    BICS  W22, W13, W21, LSR #5
    NGCS  W5, W2
    BICS  W21, W19, W21, ROR #10
    SBC  W15, W4, W16
    ORR  X17, X15, X15, LSR #19
    CLZ  W2, W27
    RORV  X13, X2, X12
    RBIT  X6, X22
    CSEL  X23, X14, X21, EQ
    ADDS  X22, X14, X17, SXTX #3
    REV  W10, W5
    UBFIZ  W9, W6, #19, #2
    SDIV  W19, W10, W9
    SXTH  W2, W19
    SXTH  W21, W23
    UBFX  W21, W21, #0x10, #2
    SUBS  W23, W22, #0x748
    TST  X13, #0x3ffc00003ffc0000
    SBFIZ  X13, X2, #8, #54
    CLS  X14, X27
    ADCS  X19, X23, X23
    ASR  X23, X14, X21
    NEG  X5, X19, LSL #31
    ROR  X22, X5, X13
    ROR  W2, W20, #0x5
    ADC  W5, W19, W12
    AND  X13, X11, #0x7fff00007fff00
    ORR  W21, W19, #0x9f9f9f9f
    CLS  W11, W14
    TST  W16, W17, LSL #19
    SMULH  X9, X2, X21
    EOR  X19, X13, X17, ROR #32
    SBCS  W2, W12, W13
    UXTH  W13, W11
    ADDS  W22, W23, W6
    SUBS  W6, W19, W23, UXTX #4
    BIC  X21, X8, X15, LSR #27
    UDIV  W16, W2, W10
    ORN  X17, X15, X19, ASR #50
    UBFIZ  X22, X12, #3, #60
    CSINC  X23, X17, X5, VS
    CLZ  X17, X5
    BICS  X27, X22, X16, LSR #26
    SBC  X16, X17, X6
    MSUB  X15, X15, X21, X22
    CLZ  W14, W23
    SMADDL  X9, W27, W13, X19
    CLS  X8, X27
    SUB  X21, X16, X14, LSL #60
    RORV  X18, X21, X9
    UBFX  X20, X17, #0xc, #47
    UXTB  W10, W18
    SUB  W11, W15, #0xf0e, LSL #12
    CLZ  W2, W8
    UBFM  X5, X2, #0x19, #0x2
    ORR  W22, W10, #0x55555555
    NGC  W8, W19
    ASR  W23, W17, #0x9
    SMULH  X13, X8, X22
    CSEL  X27, X9, X13, NE
    SBFM  W14, W19, #0x1b, #0xb
    ROR  W13, W14, W20
    SMNEGL  X17, W2, W9
    BFXIL  X19, X17, #0x1c, #5
    REV  X8, X8
    TST  W13, #0xbfbfbfbf
    REV  X16, X4
    ADCS  X21, X8, X5
    SBCS  W8, W11, W5
    REV  W23, W4
    BIC  W6, W27, W13, LSL #14
    RORV  X6, X18, X21
    ADCS  W17, W16, W16
    RORV  W10, W23, W11
    UDIV  W11, W20, W8
    SUB  W23, W14, W4, SXTH #1
    SMSUBL  X16, W12, W11, X6
    MSUB  W5, W23, W11, W16
    ADD  X22, X10, #0x528, LSL #12
    SDIV  W18, W17, W5
    SUBS  X20, X14, #0xd92
    SUB  X11, X17, X10, LSL #34
    SBC  W23, W20, W20
    NGCS  W4, W16
    CSINV  W14, W27, W11, GT
    ROR  W6, W14, #0x4
    ADDS  X23, X21, X17, ASR #35
    SUBS  X20, X23, #0x3f7, LSL #12
    UBFIZ  X15, X22, #51, #4
    ORR  X20, X20, X6, ASR #9
    SBFM  X22, X20, #0x34, #0x32
    BIC  W17, W10, W15, ROR #5
    ORR  W13, W9, W16, LSL #3
    SBFM  W15, W17, #0x12, #0x2
    NGC  W6, W18
    MSUB  W16, W13, W20, W6
    CLZ  X10, X16
    EXTR  W8, W22, W22, #0x19
    CSEL  W21, W10, W22, NE
    SUBS  X15, X4, X21, LSL #13
    EON  W10, W8, W15, ASR #11
    ANDS  W22, W16, #0xfffff9ff
    TST  X11, #0xffc00003ffffffff
    SBCS  W8, W2, W18
    MVN  X4, X23, ROR #10
    ADD  W22, W2, W4, LSL #23
    UBFIZ  W14, W6, #5, #27
    ROR  X13, X4, X21
    SUBS  X9, X21, #0xa2a, LSL #12
    UMNEGL  X21, W22, W23
    REV16  X6, X4
    SUBS  X12, X12, #0x1
    B.NE  TSRTIntAlu_label_2
    MOVZ  X3, #0x1a, LSL #0
    SUB  X7, X3, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0x803f, LSL #16
    MOVK  X3, #0x3fdf, LSL #32
    MOVK  X3, #0xffc0, LSL #48
    SUB  X7, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    SUB  X7, X3, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0x3f80, LSL #16
    MOVK  X3, #0xdf3f, LSL #32
    MOVK  X3, #0xc0ff, LSL #48
    SUB  X7, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X3, #0x1a, LSL #0
    SUB  X7, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X3, #0x6020, LSL #0
    MOVK  X3, #0xff5d, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X7, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X3, #0x7b, LSL #0
    MOVK  X3, #0x9ff8, LSL #16
    SUB  X7, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X3, #0x1, LSL #0
    MOVK  X3, #0x4, LSL #32
    SUB  X7, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X7, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X3, #0x3fdf, LSL #0
    MOVK  X3, #0xffc0, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0x803f, LSL #48
    SUB  X7, X3, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X3, #0x20, LSL #0
    SUB  X7, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X3, #0x1, LSL #0
    MOVK  X3, #0xfffc, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X7, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X3, #0x9ff9, LSL #0
    MOVK  X3, #0xfe04, LSL #16
    SUB  X7, X3, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    SUB  X7, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    SUB  X7, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X3, #0xff1f, LSL #0
    MOVK  X3, #0x7f, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X3, #0x93ff, LSL #0
    MOVK  X3, #0xffc0, LSL #16
    MOVK  X3, #0x81fe, LSL #32
    MOVK  X3, #0xff00, LSL #48
    SUB  X7, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X7, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X3, #0x1a, LSL #0
    MOVK  X3, #0xff80, LSL #16
    SUB  X7, X3, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x81ff, LSL #32
    MOVK  X3, #0xff00, LSL #48
    SUB  X7, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X3, #0xffd8, LSL #0
    MOVK  X3, #0x7f, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X7, X3, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
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
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    MOVZ  X7, #0xa, LSL #0
TSRTIntAlu_label_3:
    ORN  W3, W15, W7, ASR #31
    EOR  X16, X3, X21, ROR #8
    AND  W22, W17, W19, ROR #8
    UDIV  W2, W16, W22
    SUBS  X20, X13, #0xb7e, LSL #12
    MUL  X13, X22, X7
    CSEL  X12, X20, X23, EQ
    SUBS  W21, W2, W17, ASR #0
    CLS  X9, X13
    ADDS  W11, W7, #0x915
    UDIV  X11, X12, X21
    UDIV  X13, X9, X9
    SUB  W5, W3, W11, SXTH #0
    BFM  W20, W6, #0x6, #0x14
    SBCS  W6, W16, W20
    MUL  W22, W7, W16
    UMSUBL  X20, W22, W5, X6
    BFM  X9, X20, #0x7, #0x14
    EON  X17, X23, X17, LSL #58
    EOR  X19, X22, X3, ASR #39
    SUB  W11, W19, W17, UXTH #1
    SUB  W15, W10, W13, SXTW #1
    SXTB  X20, W11
    SUBS  W6, W20, #0x559, LSL #12
    SUB  W13, W15, W15, SXTW #1
    UMULL  X5, W9, W16
    SUB  X15, X18, X13, ASR #18
    ADD  W10, W5, W15, UXTB #3
    REV16  X23, X2
    BFM  W12, W13, #0x1d, #0x11
    SBCS  W21, W6, W17
    ADDS  X18, X23, X12, ASR #3
    NGCS  W9, W21
    EON  W11, W21, W15, LSR #26
    BFM  W13, W18, #0x13, #0xf
    EXTR  X12, X10, X10, #0x2
    UMADDL  X17, W10, W12, X18
    SXTB  X5, W17
    UBFIZ  W20, W5, #17, #15
    UBFM  X2, X13, #0x3f, #0x2
    NGC  X3, X10
    EOR  X21, X3, X18, ASR #9
    CLZ  X13, X19
    MVN  W23, W17, LSR #26
    SUBS  X22, X19, X9, SXTX #4
    MSUB  W22, W20, W23, W23
    BFXIL  X3, X22, #0x19, #19
    NGC  X20, X15
    ORR  W9, W13, #0xfffe00
    CLS  W16, W20
    ADC  W18, W12, W11
    SXTW  X11, W16
    UXTB  W23, W2
    SBFIZ  W16, W16, #31, #1
    CLS  X23, X3
    SBFX  X12, X3, #0x2e, #9
    UMSUBL  X13, W20, W21, X16
    REV  X15, X22
    UBFX  X11, X11, #0x10, #45
    SBC  X9, X11, X23
    ADCS  X21, X18, X13
    ORN  X5, X7, X12, ROR #38
    TST  X5, #0x3fc000000
    ADD  X23, X21, W21, UXTH #1
    SUBS  W10, W17, #0xdd0, LSL #12
    SXTB  X12, W9
    UMULH  X13, X12, X3
    MNEG  X12, X7, X3
    CLZ  W2, W13
    AND  X19, X10, X23, ASR #33
    ORN  X10, X19, X2, LSR #1
    MNEG  W17, W9, W15
    REV16  X23, X17
    UBFIZ  X9, X23, #46, #15
    SUB  X15, X10, W9, SXTW #0
    REV32  X2, X19
    NGCS  X9, X13
    MSUB  X10, X14, X11, X5
    ADDS  W14, W15, W6, ASR #28
    UDIV  W13, W21, W11
    SXTW  X5, W7
    CLZ  W11, W17
    UBFX  X18, X11, #0x29, #15
    NEGS  W15, W2, LSR #3
    SUB  W16, W13, W21, SXTB #4
    ADD  X5, X23, #0x79f
    ANDS  X13, X15, X9, LSL #11
    BIC  W23, W2, W14, ASR #28
    ADCS  X5, X13, X21
    NEG  X18, X17, ASR #2
    SUBS  X3, X16, #0xf33
    ADD  W16, W5, W15, SXTX #0
    ADDS  W15, W23, W18, UXTH #2
    TST  W15, #0x3fc0000
    ORN  W22, W3, W3, LSL #18
    EON  X22, X14, X15, ASR #46
    UMULH  X5, X22, X19
    CLZ  W11, W5
    SUBS  W21, W16, #0x5de
    REV  W5, W11
    SUBS  W17, W14, W10, ASR #2
    UDIV  X11, X17, X9
    RBIT  X6, X21
    UBFX  W3, W6, #0x9, #7
    CLZ  X6, X5
    MVN  W19, W22, ASR #18
    ADDS  X12, X11, X7, LSR #20
    NGCS  X14, X6
    UMULH  X5, X5, X23
    BFXIL  W21, W14, #0x1c, #2
    RBIT  X16, X12
    EOR  W8, W12, W16, ASR #30
    ASRV  X11, X8, X21
    ORR  W19, W20, W3, LSR #2
    TST  W11, W19, LSR #4
    SBFM  X12, X14, #0x29, #0xc
    SDIV  W10, W13, W13
    NEG  X19, X23, LSL #34
    ROR  X9, X3, X8
    ASR  W12, W19, #0x6
    EON  W21, W3, W16, ASR #6
    ASRV  X22, X12, X22
    ADDS  W17, W20, W18, SXTB #0
    EON  W9, W12, W20, ASR #20
    SBFX  X8, X2, #0x2c, #11
    ADD  X14, X9, X12, ASR #47
    MSUB  W9, W17, W22, W22
    TST  W6, #0x3c003c0
    CSEL  X11, X8, X10, PL
    SUBS  X18, X9, X13, ASR #10
    AND  W5, W17, #0xffffe0
    MNEG  X16, X22, X2
    BFM  W23, W21, #0xa, #0xa
    ASRV  X17, X13, X11
    ASRV  W3, W21, W19
    MUL  X13, X18, X10
    EOR  W11, W6, #0xc000c000
    EXTR  W12, W10, W18, #0x1a
    UMULH  X9, X17, X22
    BFI  W12, W6, #15, #17
    SXTW  X11, W14
    SUBS  W2, W6, W12, LSR #16
    CSNEG  W14, W11, W3, LE
    BICS  W6, W23, W19, LSL #5
    ADDS  W6, W13, W14, LSR #11
    EOR  W18, W2, W6, LSL #30
    AND  X2, X9, #0xffffffffffe0000f
    UDIV  W16, W5, W20
    EOR  X22, X15, #0x30003000300030
    ROR  W15, W3, #0x17
    CSNEG  W11, W18, W18, NE
    ADDS  W10, W15, #0xb50, LSL #12
    UXTH  W18, W16
    BICS  X19, X17, X2, LSR #1
    SBFX  W14, W18, #0x1a, #3
    SXTB  W11, W19
    SBFM  X2, X5, #0x34, #0xb
    SBFIZ  W9, W10, #30, #2
    CSNEG  W6, W3, W5, CC
    ADC  X11, X2, X11
    SUB  W13, W11, W6, LSL #17
    UBFM  X5, X13, #0xc, #0x32
    UXTB  W17, W22
    BFI  X16, X21, #30, #7
    SUB  X11, X5, X23
    ROR  X20, X20, #0x34
    SMNEGL  X17, W21, W9
    EXTR  X5, X3, X16, #0x35
    UBFIZ  W2, W17, #7, #9
    SXTB  W18, W11
    UXTH  W6, W5
    ADDS  W11, W20, #0x781
    SUB  X16, X11, X13, LSL #7
    ORR  X16, X21, #0xfff1fff1fff1fff1
    SDIV  W3, W18, W18
    EOR  X19, X15, #0xffffffffffffc
    ANDS  X15, X11, X19, ROR #4
    CLZ  W23, W14
    NGC  W10, W23
    EXTR  W5, W15, W2, #0x8
    ANDS  X10, X5, X5, LSL #44
    ADC  X9, X10, X3
    TST  W6, #0xc00007ff
    BICS  W11, W16, W16, ASR #13
    SXTH  X23, W10
    SBFIZ  X2, X23, #13, #39
    SBC  X22, X14, X23
    RBIT  W18, W23
    SUBS  X21, X9, W17, SXTW #2
    RBIT  X18, X21
    ADD  W21, W12, W5, SXTW #0
    SBFX  X3, X13, #0x8, #54
    ROR  X6, X20, X11
    REV32  X5, X19
    ADD  W17, W14, W16, SXTX #1
    MSUB  X14, X14, X11, X5
    RORV  X15, X20, X14
    ADC  X2, X5, X17
    MVN  W14, W2, LSL #25
    AND  W2, W11, W17, LSR #6
    SUBS  X7, X7, #0x1
    B.NE  TSRTIntAlu_label_3
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X27, #0x200, LSL #0
    SUB  X4, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x300, LSL #16
    MOVK  X27, #0xf00, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X4, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X27, #0x7ff, LSL #0
    MOVK  X27, #0xf800, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X4, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X27, #0x1, LSL #0
    SUB  X4, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X27, #0x7f, LSL #0
    MOVK  X27, #0x20, LSL #16
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x2, LSL #16
    SUB  X4, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0x3ff, LSL #16
    SUB  X4, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X27, #0x7ff, LSL #0
    MOVK  X27, #0xf800, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X4, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xfff1, LSL #32
    MOVK  X27, #0xfff1, LSL #48
    SUB  X4, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X27, #0xfffe, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X4, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x8000, LSL #16
    MOVK  X27, #0x8000, LSL #48
    SUB  X4, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X27, #0x3, LSL #0
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xf, LSL #48
    SUB  X4, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X27, #0x7ff, LSL #0
    MOVK  X27, #0xf800, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X4, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X27, #0x7f, LSL #0
    MOVK  X27, #0x20, LSL #16
    SUB  X4, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X4, X27, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTIntAlu_TestFail
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
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    MOVZ  X10, #0xa, LSL #0
TSRTIntAlu_label_4:
    NEG  X6, X22, LSL #3
    SXTB  X9, W27
    ADCS  X19, X4, X19
    MSUB  W11, W10, W23, W17
    SBFX  X13, X8, #0x28, #3
    SUB  X21, X4, X13, SXTX #0
    REV16  W8, W11
    BIC  W21, W8, W20, ROR #12
    SBFIZ  W27, W21, #9, #12
    ASR  X16, X19, X21
    SBFIZ  W5, W16, #27, #1
    NEG  X13, X11, ASR #2
    ADD  W23, W27, W10, LSR #2
    UBFM  W4, W12, #0xa, #0x1c
    MADD  W8, W10, W27, W23
    UDIV  X12, X13, X14
    MVN  X23, X22, LSR #15
    MSUB  W27, W23, W9, W23
    SMSUBL  X8, W12, W20, X5
    ADD  W15, W4, W4, LSL #28
    SUB  W19, W4, W13, UXTW #4
    MVN  X11, X19, LSR #61
    NEGS  X17, X21, ASR #16
    ADD  X21, X8, #0xd99
    SBCS  X20, X27, X20
    SUBS  W22, W11, W12
    CLZ  W8, W23
    SBCS  X27, X27, X21
    MVN  X5, X27, LSL #29
    SBFM  X16, X17, #0x2a, #0x18
    ADDS  W17, W16, #0x899, LSL #12
    TST  W17, #0x40004
    REV  X23, X8
    SUB  W8, W20, W20, SXTH #3
    SBC  X14, X21, X4
    BFM  W27, W5, #0x5, #0x3
    SUBS  X23, X15, #0x4f6, LSL #12
    SUB  X9, X23, W27, UXTH #0
    RORV  W13, W22, W5
    CSINC  W15, W22, W12, HI
    NGCS  X19, X9
    SBFX  X27, X15, #0x3e, #1
    MADD  X6, X8, X22, X22
    UMULH  X20, X13, X15
    CSINV  X4, X6, X23, MI
    SUBS  W9, W13, W20, UXTB #2
    SMNEGL  X15, W11, W22
    UBFX  X13, X14, #0x0, #54
    CSEL  W5, W19, W27, CC
    REV  W11, W13
    ASR  W21, W9, #0x13
    UBFM  W16, W6, #0x8, #0x18
    UXTB  W19, W15
    SUBS  W13, W5, W20, LSR #0
    ROR  X17, X16, #0x32
    TST  X21, #0xffff8000000
    CSNEG  W8, W23, W11, CC
    ASR  W12, W13, #0x7
    UMSUBL  X5, W17, W8, X27
    ANDS  X15, X16, X12, ROR #40
    CSINC  W20, W4, W5, HI
    ADD  W27, W19, #0x9d0, LSL #12
    SBFM  W11, W10, #0x1e, #0xe
    ASRV  W20, W11, W20
    BFM  X5, X11, #0x2e, #0x23
    UBFIZ  W6, W17, #15, #8
    NEGS  X23, X6, ASR #60
    BICS  W8, W20, W27, ROR #27
    EON  X19, X5, X15, ROR #2
    EON  X9, X9, X23, LSL #12
    AND  W27, W8, #0x7000
    NGCS  W17, W6
    ANDS  W16, W19, #0xfffcfffc
    BFI  W6, W13, #24, #4
    EOR  X13, X27, X17, ASR #10
    SBFIZ  X12, X9, #3, #40
    AND  W20, W16, W21, ASR #20
    REV16  X8, X6
    BICS  X21, X16, X8, ROR #15
    RORV  W23, W9, W12
    UDIV  W16, W12, W16
    NEG  X21, X20, LSL #18
    SMULH  X9, X21, X19
    SMULL  X22, W13, W6
    NGCS  W20, W12
    EXTR  X11, X20, X11, #0x12
    BFXIL  W15, W22, #0xe, #2
    BICS  W6, W10, W9, LSR #24
    ASR  W4, W16, #0x3
    CSNEG  W8, W4, W23, HI
    SBFM  W9, W15, #0x19, #0x9
    SUBS  X22, X27, #0x106
    SUB  W13, W23, W11, SXTW #1
    TST  X15, X3, LSR #51
    CLS  W4, W9
    BICS  W15, W6, W9, LSL #31
    NEGS  X27, X8, ASR #30
    ADDS  W16, W27, #0xf2e, LSL #12
    AND  W8, W22, W22, ASR #8
    CSINV  W6, W13, W13, LS
    BFI  X20, X8, #11, #15
    BFXIL  X13, X6, #0x32, #7
    UMULH  X6, X14, X13
    SBC  X19, X5, X4
    MNEG  X23, X19, X15
    UMSUBL  X3, W16, W21, X23
    ORR  W16, W6, #0xffffe3ff
    MNEG  W19, W11, W3
    MNEG  X15, X20, X20
    REV  X9, X2
    MADD  X20, X2, X16, X3
    UBFIZ  X22, X19, #54, #9
    REV  X8, X12
    ORN  X3, X14, X22, LSR #8
    EOR  W22, W9, #0x7070707
    ADDS  W27, W15, W3, LSR #29
    SUB  X23, X8, #0xab6
    UMSUBL  X16, W22, W22, X22
    UBFIZ  W4, W23, #17, #10
    ROR  X23, X3, X20
    TST  W4, #0xffff9fff
    ADCS  W22, W22, W14
    SXTB  X2, W2
    ANDS  X14, X2, X23, ROR #22
    UBFIZ  X6, X14, #55, #2
    ADD  W14, W16, #0x415
    ADDS  X12, X12, #0xd, LSL #12
    ADD  W11, W12, W9, SXTB #1
    ORR  W16, W3, W20, ROR #5
    BFI  X3, X22, #50, #12
    SUBS  X21, X12, X14, UXTX #2
    UBFM  W15, W21, #0xb, #0x8
    SBFM  X21, X5, #0x5, #0x1e
    AND  X12, X16, X16, ASR #7
    SMULL  X23, W11, W9
    SBFM  W22, W2, #0x0, #0xe
    UMULH  X5, X27, X10
    UBFIZ  W20, W23, #11, #8
    AND  W11, W20, W22, LSR #2
    TST  X12, X11, ASR #44
    SXTH  W8, W2
    SDIV  X5, X21, X15
    SBFX  W22, W19, #0x0, #19
    MSUB  W20, W8, W5, W15
    ADDS  W23, W6, #0x4d5, LSL #12
    ASR  W9, W13, W6
    ADDS  X2, X21, W23, UXTH #2
    CSINC  X15, X20, X2, EQ
    BFXIL  W2, W3, #0x17, #1
    SUB  W20, W12, W20, LSL #30
    ADCS  X21, X20, X13
    ADDS  W5, W21, W9, SXTX #2
    EOR  X6, X12, X2, ROR #59
    ORR  X17, X14, #0xfffff001ffffffff
    SUB  W2, W10, W17, UXTW #4
    MADD  X8, X23, X15, X27
    REV32  X6, X8
    UBFIZ  W20, W2, #26, #6
    ANDS  W21, W6, W14, LSR #14
    ADD  X14, X20, W13, SXTH #3
    ASRV  X3, X21, X5
    SMNEGL  X6, W22, W17
    BFXIL  X13, X21, #0x2b, #1
    MNEG  X9, X14, X6
    EOR  W11, W13, #0x1f801f80
    MSUB  X21, X11, X12, X5
    ADC  W4, W3, W9
    SBFX  X19, X4, #0x1b, #31
    UBFX  W6, W8, #0x1a, #3
    MUL  X3, X8, X16
    ASR  X22, X13, X19
    SXTB  X27, W8
    CLZ  X9, X4
    UXTB  W22, W27
    ROR  X23, X20, X9
    SBC  W4, W6, W4
    SUB  W16, W15, #0x569
    CLZ  X2, X19
    BIC  X14, X11, X23, ASR #12
    CSEL  W6, W15, W20, NV
    ASRV  X9, X15, X21
    ASR  X3, X20, #0x1f
    SXTW  X20, W15
    SBFX  X17, X22, #0x5, #51
    AND  X3, X17, X14, LSR #56
    NGC  W15, W14
    SUB  X20, X21, W19, UXTW #1
    UBFM  X19, X6, #0x3f, #0x36
    MADD  W21, W10, W20, W2
    BFXIL  W8, W4, #0xa, #8
    CLS  W8, W4
    ANDS  X23, X21, #0x7fff80007fff800
    SUBS  W21, W19, W15, LSL #3
    MSUB  X4, X8, X9, X22
    ORR  W2, W20, #0xf0f0f0f
    REV32  X20, X21
    REV16  W11, W19
    REV32  X8, X20
    NEGS  W6, W8, ASR #6
    NEG  W9, W19, LSL #1
    SUBS  X10, X10, #0x1
    B.NE  TSRTIntAlu_label_4
    MOVZ  X18, #0x6f7f, LSL #0
    MOVK  X18, #0xff9f, LSL #16
    SUB  X7, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X18, #0x46, LSL #0
    SUB  X7, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X18, #0xe27f, LSL #0
    MOVK  X18, #0x3f43, LSL #16
    SUB  X7, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X18, #0xa9c0, LSL #0
    MOVK  X18, #0xb4, LSL #16
    SUB  X7, X18, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X18, #0x900a, LSL #0
    MOVK  X18, #0xd2d5, LSL #16
    SUB  X7, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X18, #0xcffc, LSL #0
    MOVK  X18, #0xfff8, LSL #16
    SUB  X7, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X18, #0x298, LSL #0
    MOVK  X18, #0x300, LSL #16
    SUB  X7, X18, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0x1ff, LSL #16
    SUB  X7, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X18, #0x6080, LSL #0
    MOVK  X18, #0xa5da, LSL #16
    SUB  X7, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X18, #0x3f00, LSL #0
    MOVK  X18, #0xba5a, LSL #16
    SUB  X7, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X18, #0xc0ff, LSL #0
    MOVK  X18, #0x45a5, LSL #16
    SUB  X7, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X18, #0xc698, LSL #0
    MOVK  X18, #0x1, LSL #16
    SUB  X7, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X18, #0x2, LSL #0
    SUB  X7, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X18, #0x9802, LSL #0
    MOVK  X18, #0x3, LSL #16
    SUB  X7, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X18, #0xd5d2, LSL #0
    MOVK  X18, #0xa90, LSL #16
    SUB  X7, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X18, #0x900a, LSL #0
    MOVK  X18, #0xd2d5, LSL #16
    SUB  X7, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X18, #0x46, LSL #0
    SUB  X7, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X18, #0x6000, LSL #0
    MOVK  X18, #0x19e, LSL #16
    SUB  X7, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X18, #0x46, LSL #0
    SUB  X7, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X2, #0xc23f, LSL #0
    MOVK  X2, #0xbd56, LSL #16
    MOVK  X2, #0xcf4f, LSL #32
    MOVK  X2, #0xd89, LSL #48
    MOVZ  X3, #0xd3f9, LSL #0
    MOVK  X3, #0x2a78, LSL #16
    MOVK  X3, #0x48a8, LSL #32
    MOVK  X3, #0x9375, LSL #48
    MOVZ  X4, #0xa97e, LSL #0
    MOVK  X4, #0x5b55, LSL #16
    MOVK  X4, #0xd1, LSL #32
    MOVK  X4, #0x255d, LSL #48
    MOVZ  X5, #0xca1c, LSL #0
    MOVK  X5, #0x26b6, LSL #16
    MOVK  X5, #0x1df5, LSL #32
    MOVK  X5, #0x92c7, LSL #48
    MOVZ  X6, #0x7fb9, LSL #0
    MOVK  X6, #0x9381, LSL #16
    MOVK  X6, #0x892b, LSL #32
    MOVK  X6, #0x8849, LSL #48
    MOVZ  X7, #0x93b1, LSL #0
    MOVK  X7, #0x7745, LSL #16
    MOVK  X7, #0xe668, LSL #32
    MOVK  X7, #0xb4cf, LSL #48
    MOVZ  X8, #0x2658, LSL #0
    MOVK  X8, #0x793e, LSL #16
    MOVK  X8, #0xc248, LSL #32
    MOVK  X8, #0xdba4, LSL #48
    MOVZ  X9, #0xbdb9, LSL #0
    MOVK  X9, #0xc0a0, LSL #16
    MOVK  X9, #0xbe25, LSL #32
    MOVK  X9, #0xa673, LSL #48
    MOVZ  X10, #0x156a, LSL #0
    MOVK  X10, #0x3189, LSL #16
    MOVK  X10, #0xff41, LSL #32
    MOVK  X10, #0x7456, LSL #48
    MOVZ  X11, #0x498f, LSL #0
    MOVK  X11, #0xecab, LSL #16
    MOVK  X11, #0xf3f3, LSL #32
    MOVK  X11, #0xcf19, LSL #48
    MOVZ  X12, #0x946b, LSL #0
    MOVK  X12, #0x5c20, LSL #16
    MOVK  X12, #0xf72d, LSL #32
    MOVK  X12, #0x849f, LSL #48
    MOVZ  X13, #0xc6d, LSL #0
    MOVK  X13, #0x4149, LSL #16
    MOVK  X13, #0xa905, LSL #32
    MOVK  X13, #0x2e08, LSL #48
    MOVZ  X14, #0x1d7d, LSL #0
    MOVK  X14, #0xf797, LSL #16
    MOVK  X14, #0x67f0, LSL #32
    MOVK  X14, #0x2575, LSL #48
    MOVZ  X15, #0xaf8a, LSL #0
    MOVK  X15, #0xe542, LSL #16
    MOVK  X15, #0x7c6a, LSL #32
    MOVK  X15, #0x4fe, LSL #48
    MOVZ  X16, #0xaa44, LSL #0
    MOVK  X16, #0x5cab, LSL #16
    MOVK  X16, #0x952a, LSL #32
    MOVK  X16, #0xdfb3, LSL #48
    MOVZ  X17, #0xbe20, LSL #0
    MOVK  X17, #0x94d3, LSL #16
    MOVK  X17, #0xa2e1, LSL #32
    MOVK  X17, #0x9fa1, LSL #48
    MOVZ  X18, #0x527e, LSL #0
    MOVK  X18, #0xcdf2, LSL #16
    MOVK  X18, #0xfeed, LSL #32
    MOVK  X18, #0xd4f9, LSL #48
    MOVZ  X19, #0xfed, LSL #0
    MOVK  X19, #0xca13, LSL #16
    MOVK  X19, #0x248d, LSL #32
    MOVK  X19, #0xa69c, LSL #48
    MOVZ  X20, #0xa08a, LSL #0
    MOVK  X20, #0xa0c8, LSL #16
    MOVK  X20, #0x6390, LSL #32
    MOVK  X20, #0x7362, LSL #48
    MOVZ  X21, #0x53e, LSL #0
    MOVK  X21, #0x57ec, LSL #16
    MOVK  X21, #0x39c3, LSL #32
    MOVK  X21, #0xdfd9, LSL #48
    MOVZ  X22, #0x2230, LSL #0
    MOVK  X22, #0xd61d, LSL #16
    MOVK  X22, #0xdd9d, LSL #32
    MOVK  X22, #0xbcbb, LSL #48
    MOVZ  X23, #0xe455, LSL #0
    MOVK  X23, #0xb808, LSL #16
    MOVK  X23, #0xa562, LSL #32
    MOVK  X23, #0xa214, LSL #48
    MOVZ  X27, #0x692c, LSL #0
    MOVK  X27, #0xd55a, LSL #16
    MOVK  X27, #0x567c, LSL #32
    MOVK  X27, #0x8da4, LSL #48
    MOVZ  X3, #0xa, LSL #0
TSRTIntAlu_label_5:
    SMSUBL  X17, W16, W27, X23
    ADDS  X8, X22, X23, ASR #57
    CLS  W11, W16
    SMSUBL  X10, W19, W3, X15
    CSEL  X2, X17, X12, MI
    CSEL  W10, W10, W8, HI
    SUBS  W11, W23, W10, LSL #21
    SXTW  X27, W4
    SUBS  W10, W27, #0xb99
    MUL  X14, X3, X11
    UMADDL  X27, W2, W14, X20
    SMADDL  X19, W19, W9, X27
    SUB  X11, X10, W19, UXTB #4
    CSINC  W18, W17, W17, VC
    NEG  W16, W2, LSL #5
    EON  X20, X3, X16
    CLZ  X4, X18
    NEG  X20, X3, LSR #61
    UMULH  X9, X4, X22
    SUBS  X22, X5, W20, UXTH #3
    RBIT  W19, W23
    BIC  W8, W3, W17, LSR #27
    MNEG  W5, W13, W5
    SBFIZ  X12, X8, #6, #2
    NGCS  W14, W14
    MVN  W16, W4, ASR #22
    BFI  W5, W15, #17, #10
    UDIV  X23, X11, X22
    SXTB  X16, W5
    MVN  X14, X5, LSR #27
    EXTR  X2, X3, X12, #0x1d
    TST  W27, #0xc000c000
    ADCS  X4, X18, X12
    SXTB  X20, W16
    SUBS  X12, X20, W8, SXTB #0
    MUL  X11, X4, X27
    CLS  X16, X16
    EOR  W22, W15, #0x7fc00
    ADDS  W12, W11, W9, LSL #1
    SBFM  W18, W22, #0x19, #0x1f
    NGC  W8, W2
    BICS  W13, W9, W8, ASR #26
    BICS  W17, W18, W12, ASR #3
    BICS  W11, W14, W16, ASR #8
    MUL  W5, W13, W23
    CLZ  W8, W11
    ADDS  X11, X5, #0x3dd, LSL #12
    UMSUBL  X13, W19, W8, X8
    AND  X12, X17, X14, LSL #26
    ORR  W9, W22, W12, ASR #26
    BFXIL  W5, W11, #0x11, #14
    ADD  W20, W5, W18, UXTX #4
    NEG  X11, X9, LSR #7
    NGCS  X12, X13
    SXTW  X5, W11
    EXTR  W23, W13, W2, #0x10
    UBFM  X2, X7, #0x2a, #0x3f
    NEGS  X11, X19, LSR #49
    AND  W8, W2, W23, ROR #15
    BFXIL  W17, W8, #0x1a, #5
    UBFM  W12, W5, #0x4, #0x1f
    ADD  X14, X13, X11, LSL #15
    SUB  W4, W12, #0x39b
    ROR  W18, W9, #0x16
    SBFM  W9, W13, #0xc, #0x13
    ORN  X8, X20, X4, ROR #13
    TST  X17, X18, ROR #43
    ORR  W23, W8, #0xaaaaaaaa
    SMSUBL  X17, W14, W23, X4
    ASR  X23, X5, #0xf
    AND  X14, X10, #0x5555555555555555
    EON  W12, W20, W14, LSL #25
    SMADDL  X16, W9, W15, X17
    BFXIL  X15, X8, #0x16, #21
    ADC  X19, X9, X3
    TST  X5, #0x8000800080008000
    SXTB  W7, W22
    CSNEG  W12, W20, W20, LT
    MADD  W22, W12, W16, W11
    EOR  X12, X3, X19, ROR #20
    EON  W15, W20, W16, ASR #24
    ROR  W17, W7, W27
    MADD  X13, X20, X9, X2
    CSINV  W12, W3, W12, NE
    ADCS  X18, X3, X10
    CLS  W15, W14
    CSNEG  W15, W22, W16, NV
    SUBS  X14, X23, #0x37b
    UBFM  W5, W11, #0xa, #0x6
    UBFX  X2, X2, #0x38, #2
    ANDS  W27, W8, #0xfff801ff
    SUBS  X18, X18, #0x598, LSL #12
    MUL  X10, X22, X17
    AND  X16, X13, X18, LSL #47
    SMULH  X23, X8, X5
    ROR  W9, W2, #0x1c
    SMULL  X11, W27, W9
    SUBS  W4, W10, W13, UXTX #3
    EXTR  X2, X14, X15, #0x2a
    ADDS  W7, W11, #0xd32
    ADCS  W14, W4, W2
    UMNEGL  X2, W14, W23
    SMADDL  X8, W3, W22, X7
    SBC  W17, W23, W13
    ADD  W4, W2, W8, SXTX #1
    BFI  W5, W12, #26, #6
    BFI  X2, X4, #21, #24
    SUBS  W14, W13, #0x2, LSL #12
    SXTH  W9, W2
    ROR  W2, W17, W17
    ADDS  W13, W10, W5, LSR #12
    RBIT  X27, X5
    REV  W18, W10
    CLS  X4, X14
    SMADDL  X19, W15, W27, X19
    SUB  X11, X2, X12, LSR #3
    MVN  W11, W11, ROR #21
    AND  W23, W13, #0x4040404
    TST  X8, X20, LSL #36
    CSNEG  W17, W16, W16, CC
    MADD  X13, X16, X20, X9
    UMNEGL  X27, W17, W17
    ASRV  W2, W23, W4
    UMADDL  X8, W17, W18, X11
    ORN  X18, X8, X2, LSL #56
    ADC  X23, X13, X11
    UBFM  X10, X23, #0x5, #0x3
    UBFM  W17, W19, #0x12, #0x1
    SBCS  W13, W27, W4
    SXTW  X17, W10
    NGC  W16, W17
    ADC  W12, W18, W18
    ORR  X14, X12, #0x7ff
    BFM  W10, W14, #0x1a, #0x9
    ADD  W5, W13, #0xc5, LSL #12
    MSUB  X12, X10, X20, X16
    SBFM  W8, W5, #0x19, #0x3
    CSEL  W17, W11, W23, LS
    SMADDL  X14, W11, W22, X8
    REV  X8, X18
    SBFIZ  W5, W5, #27, #3
    UXTH  W14, W22
    SBFIZ  W13, W16, #15, #13
    MNEG  W9, W19, W16
    SUB  W20, W10, W13, UXTB #3
    SUB  X16, X16, #0x5e6, LSL #12
    TST  W9, W14, ASR #19
    NEGS  X4, X4, ASR #42
    ANDS  W14, W9, W8, ASR #22
    SBFM  X11, X27, #0x25, #0x1a
    SBCS  X2, X9, X8
    CSNEG  W10, W17, W4, CS
    SMULH  X18, X23, X16
    BICS  X19, X5, X18, ASR #55
    SBCS  X13, X2, X20
    ASR  X8, X13, #0x0
    MUL  X13, X11, X18
    REV16  W17, W10
    SUBS  X9, X17, X12, ASR #5
    SXTW  X23, W4
    MUL  X4, X4, X16
    SMADDL  X2, W2, W20, X13
    CSNEG  W20, W7, W15, GE
    ORR  X10, X27, X8, ROR #41
    SBC  X16, X3, X3
    BFM  X16, X4, #0x16, #0x3c
    SUBS  W22, W15, W20, SXTX #1
    BFI  X5, X9, #46, #6
    ADD  X10, X23, #0x81f, LSL #12
    EOR  W11, W2, W5, ASR #31
    SBFM  X15, X10, #0x1c, #0x33
    CSEL  X5, X16, X15, PL
    SMULH  X10, X5, X5
    NGC  W17, W19
    MNEG  X9, X17, X22
    ASR  W2, W9, W4
    ASR  W27, W10, W13
    SUBS  W4, W27, #0x68e, LSL #12
    SDIV  X20, X16, X11
    ORR  X15, X20, #0xffff8000000000
    UMSUBL  X17, W4, W3, X7
    EXTR  W7, W15, W17, #0xb
    MNEG  X12, X10, X4
    UBFX  W9, W27, #0x1e, #1
    CSNEG  W23, W18, W10, HI
    UMULL  X10, W11, W7
    ASR  W15, W4, #0x1a
    EXTR  W20, W5, W14, #0x0
    ADDS  W17, W23, W27, SXTW #2
    MNEG  X18, X27, X9
    UBFX  W4, W10, #0x18, #3
    CSNEG  W12, W3, W10, MI
    SXTB  X19, W5
    SUBS  W16, W8, #0x70a, LSL #12
    BICS  X17, X12, X20, ASR #44
    SXTW  X5, W18
    RORV  W23, W19, W17
    CLS  W18, W22
    UBFM  X9, X16, #0xf, #0x6
    ADD  X27, X16, #0x16d, LSL #12
    SUBS  X3, X3, #0x1
    B.NE  TSRTIntAlu_label_5
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X6, #0x5, LSL #0
    SUB  X21, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X6, #0xd1d, LSL #0
    MOVK  X6, #0xff00, LSL #16
    SUB  X21, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X6, #0x40, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X21, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x80, LSL #48
    SUB  X21, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X6, #0xb8c0, LSL #0
    MOVK  X6, #0x4d19, LSL #16
    MOVK  X6, #0xfec0, LSL #32
    SUB  X21, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X6, #0xffc0, LSL #0
    SUB  X21, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X6, #0x4740, LSL #0
    MOVK  X6, #0xb2e6, LSL #16
    SUB  X21, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X6, #0x1, LSL #0
    SUB  X21, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X21, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X6, #0x6040, LSL #0
    MOVK  X6, #0xff8e, LSL #16
    SUB  X21, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X6, #0x4740, LSL #0
    MOVK  X6, #0xb2e6, LSL #16
    SUB  X21, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X6, #0x1, LSL #0
    SUB  X21, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X6, #0x6892, LSL #0
    MOVK  X6, #0x9abf, LSL #16
    SUB  X21, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
    MOVZ  X6, #0x3040, LSL #0
    MOVK  X6, #0xffa5, LSL #16
    SUB  X21, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTIntAlu_TestFail
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
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X19, #0xa, LSL #0
TSRTIntAlu_label_6:
    UMSUBL  X8, W6, W17, X2
    EOR  W4, W3, #0x1fc01fc
    SBFM  X15, X13, #0x32, #0x5
    SBFM  W17, W10, #0x9, #0x12
    ASR  W13, W22, #0xc
    MSUB  W5, W27, W4, W3
    NGC  X4, X21
    SUB  X17, X20, W17, SXTB #2
    CSINC  W4, W4, W23, AL
    ADDS  W27, W5, W8, SXTB #0
    SBFM  X20, X15, #0x1e, #0x3d
    REV32  X2, X9
    ADD  X17, X2, #0x70a, LSL #12
    SUBS  W17, W27, #0xe78
    SDIV  W6, W17, W5
    MUL  W16, W4, W4
    RORV  W5, W16, W6
    UMULL  X3, W13, W18
    MUL  W8, W6, W13
    TST  X5, #0x3fc000003fc00000
    CLZ  X2, X4
    NEG  W17, W11, LSR #6
    EXTR  W18, W23, W2, #0xf
    SMSUBL  X22, W3, W9, X17
    RBIT  X20, X8
    ORR  X5, X27, X3, LSR #55
    TST  X18, X20, ROR #54
    SUB  X20, X5, W9, SXTB #3
    ASRV  W16, W20, W20
    SMSUBL  X5, W22, W10, X22
    ORR  X20, X27, X16, ROR #60
    SBC  W9, W18, W5
    EON  X23, X4, X11, LSR #37
    ADC  X8, X27, X16
    ADDS  X22, X12, X3, LSL #20
    ADD  X22, X19, W15, UXTH #3
    UBFX  X5, X17, #0x25, #20
    ORN  W2, W8, W13, LSR #24
    RORV  W15, W11, W6
    EON  X17, X23, X20, ASR #30
    AND  W18, W4, #0xff1fff1f
    RORV  X10, X10, X9
    EOR  X3, X8, X23, ROR #47
    CLS  W5, W2
    ASR  W12, W11, W4
    ADDS  X16, X11, X15, LSL #3
    UMULL  X8, W21, W18
    SUB  X18, X21, #0xf3
    ADD  X11, X17, W17, SXTB #3
    RBIT  X15, X10
    SBC  X11, X15, X17
    ROR  X17, X3, #0x5
    CSEL  W8, W15, W3, VS
    MNEG  X6, X21, X11
    CLZ  W10, W22
    TST  X5, X20, LSR #46
    SUB  X9, X16, X21, LSL #61
    SUB  W23, W27, #0x886, LSL #12
    UBFIZ  X16, X8, #39, #13
    ADD  W11, W10, W19, UXTW #0
    UMULL  X6, W21, W16
    EOR  W3, W27, #0xf8ffffff
    SXTH  W23, W17
    SBC  W8, W8, W20
    UMULH  X5, X3, X18
    TST  X5, X22, ASR #63
    UMADDL  X21, W13, W8, X9
    CLS  W15, W6
    TST  W12, W21, ROR #6
    SXTB  X9, W15
    UXTH  W15, W23
    MSUB  W3, W18, W15, W4
    MADD  X18, X19, X11, X3
    SUB  X27, X27, W23, UXTW #0
    NEG  W13, W8, LSL #3
    UXTH  W21, W15
    BIC  W2, W5, W23, ROR #13
    ADD  X27, X23, #0x774, LSL #12
    TST  X18, #0x7fffffe0000
    SMULH  X10, X23, X21
    BFXIL  X2, X13, #0x9, #48
    ORR  W5, W3, W17, LSR #12
    SMSUBL  X6, W9, W5, X15
    CSINC  W13, W21, W11, MI
    SUB  X17, X19, #0xe26
    ADCS  W22, W9, W2
    CSEL  X3, X23, X13, NE
    ADC  X18, X6, X11
    BFXIL  W16, W5, #0x7, #11
    UXTB  W18, W22
    SBC  X5, X27, X6
    TST  X27, #0xff07ff07ff07ff07
    ADD  W27, W16, #0x36e, LSL #12
    TST  X18, X17, ROR #26
    UMNEGL  X22, W13, W10
    EOR  W11, W16, #0x1c00
    NGCS  W16, W2
    SBFX  W6, W18, #0x4, #2
    MADD  W23, W15, W6, W23
    NEGS  W21, W2, ASR #0
    UBFIZ  X9, X20, #26, #13
    BICS  X15, X12, X23, ROR #20
    UBFIZ  W6, W8, #26, #2
    SMSUBL  X20, W6, W6, X21
    CSEL  X6, X9, X16, AL
    ORN  W21, W6, W15, LSL #1
    UMADDL  X10, W27, W22, X18
    ROR  X18, X11, X8
    MSUB  W6, W20, W21, W21
    ORR  W2, W10, #0xf81ff81f
    CLS  W5, W2
    UDIV  X5, X17, X3
    BIC  X9, X21, X12, ASR #33
    UDIV  X17, X5, X6
    TST  X17, #0xff01ff01ff01ff01
    ADC  X6, X9, X9
    AND  X9, X22, #0x3ffffffffffe000
    SBCS  W8, W16, W8
    EOR  W15, W4, W10, ROR #5
    SUB  X10, X21, #0x86b, LSL #12
    ASR  X4, X23, X3
    NGCS  W4, W5
    ORR  W12, W13, #0xe00fe00f
    REV16  W20, W10
    SXTB  W5, W13
    NEGS  W17, W12, ASR #26
    EXTR  X11, X3, X4, #0x1c
    UXTH  W27, W6
    CLZ  X22, X27
    NEGS  X21, X13, LSR #44
    ROR  W16, W18, W17
    EXTR  W17, W10, W21, #0xd
    NGCS  X27, X15
    RORV  X9, X17, X8
    EOR  X13, X27, X9, LSR #34
    CLS  X4, X21
    SBFIZ  W12, W20, #10, #9
    SXTB  X8, W11
    ROR  W23, W12, #0x11
    TST  X18, X22, LSL #28
    MNEG  W17, W4, W9
    ORR  W20, W17, W21, ROR #30
    ASR  W3, W5, W16
    NEGS  W11, W9, ASR #17
    BFM  W9, W20, #0x1e, #0x16
    UBFX  W17, W23, #0x1a, #2
    ADDS  W21, W6, W9, UXTH #0
    ASR  W11, W9, #0xe
    CLZ  W23, W10
    CSINC  X20, X17, X3, LS
    ROR  X3, X23, #0x3f
    SUB  X9, X8, #0xa55
    SXTW  X22, W9
    SMULL  X10, W21, W3
    ANDS  W18, W4, #0x1fff
    SXTB  X6, W11
    MNEG  X15, X6, X19
    SBFM  X8, X13, #0x20, #0xa
    SUB  X23, X8, #0xf86, LSL #12
    SUB  X3, X22, W20, SXTB #4
    ADCS  W9, W9, W10
    EOR  X12, X4, X17, ROR #21
    ANDS  W22, W5, W10, LSL #16
    SMNEGL  X13, W18, W12
    REV  W27, W3
    RORV  W11, W27, W15
    REV16  W27, W15
    UBFX  W6, W9, #0x1a, #4
    MSUB  X9, X11, X27, X22
    UDIV  W21, W11, W23
    ADDS  W12, W10, W21, LSL #3
    UBFM  X5, X6, #0x38, #0xb
    ORR  X16, X9, #0x3fffffffffe
    MSUB  W4, W12, W13, W5
    ORN  X23, X18, X11, LSR #25
    REV  X15, X2
    EOR  W13, W9, #0x3ffff8
    NEG  X8, X10, LSR #19
    NEGS  W17, W9, LSL #18
    SBFX  X6, X6, #0x13, #39
    BFI  W11, W4, #9, #9
    CSINV  X5, X11, X13, AL
    SBFX  W2, W6, #0x9, #20
    ADD  X18, X17, #0x40f
    REV  X6, X9
    EXTR  W9, W23, W12, #0xc
    SMNEGL  X4, W18, W27
    NEGS  W3, W16, ASR #12
    MSUB  W20, W11, W10, W15
    CLZ  X10, X3
    ASRV  W16, W6, W17
    ORR  W6, W10, W9, ROR #3
    SMADDL  X9, W20, W4, X17
    SMULL  X12, W22, W17
    TST  X13, #0x7ff000000
    SUB  W18, W19, #0x2f2
    ADDS  W5, W27, #0x618, LSL #12
    SUB  X23, X16, #0x38, LSL #12
    CSINC  X21, X2, X18, LS
    CLS  X16, X8
    SUBS  X19, X19, #0x1
    B.NE  TSRTIntAlu_label_6
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X14, #0x1, LSL #0
    SUB  X7, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X14, #0x8000, LSL #0
    MOVK  X14, #0x61, LSL #16
    SUB  X7, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X14, #0xa03f, LSL #0
    MOVK  X14, #0xff7e, LSL #16
    SUB  X7, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X14, #0x15ff, LSL #0
    MOVK  X14, #0xe000, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X7, X14, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X14, #0x3f, LSL #0
    SUB  X7, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X14, #0xf9ff, LSL #0
    MOVK  X14, #0x8af7, LSL #16
    SUB  X7, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X14, #0xfff8, LSL #0
    MOVK  X14, #0x3f, LSL #16
    SUB  X7, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x1ff8, LSL #32
    MOVK  X14, #0x3ff8, LSL #48
    SUB  X7, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X14, #0x12, LSL #0
    SUB  X7, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X14, #0xfd0f, LSL #0
    MOVK  X14, #0xffff, LSL #16
    SUB  X7, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X14, #0xe7fc, LSL #0
    MOVK  X14, #0xdbef, LSL #16
    SUB  X7, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X14, #0x8000, LSL #0
    MOVK  X14, #0xfffc, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X7, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
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
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    MOVZ  X22, #0xa, LSL #0
TSRTIntAlu_label_7:
    BFI  W11, W11, #23, #9
    TST  W22, #0x1f80
    CSEL  W17, W23, W19, CC
    BFI  W6, W21, #5, #14
    TST  X4, X11, ASR #45
    MSUB  X14, X16, X27, X17
    SBC  X7, X14, X14
    REV  X27, X23
    ROR  X13, X17, #0x3a
    SXTB  X18, W7
    MSUB  X16, X12, X18, X16
    UMSUBL  X9, W13, W16, X16
    AND  X3, X6, X3, LSL #35
    SBFM  W19, W11, #0xf, #0xb
    MUL  X17, X2, X3
    BFXIL  W7, W10, #0x7, #9
    UXTH  W10, W7
    EOR  X4, X19, X19, LSL #15
    ADCS  W16, W14, W4
    SMULH  X27, X9, X17
    BIC  W21, W16, W21, ROR #16
    MADD  X18, X17, X2, X21
    CSNEG  X16, X18, X21, PL
    UMSUBL  X9, W27, W18, X23
    MUL  W23, W16, W27
    TST  X10, X23, ASR #58
    ADDS  X10, X9, #0x4dd
    SUBS  X7, X9, #0xfe6
    TST  X23, X11, ASR #6
    NGC  W12, W12
    ORN  X3, X6, X10, ROR #19
    REV  W13, W18
    CSINV  W18, W14, W4, LS
    NGC  X10, X13
    SBC  W6, W11, W2
    CLS  X4, X16
    EOR  W2, W23, #0x3c00000
    MNEG  X16, X12, X8
    ANDS  W17, W11, #0xf8fff8ff
    SMULL  X8, W6, W14
    UMULL  X13, W17, W18
    UXTH  W11, W4
    BICS  W4, W7, W10, ASR #29
    TST  X16, #0x7fffffffffe
    SBC  W7, W2, W2
    EOR  X14, X9, #0xfe000000
    TST  X13, X3, ASR #3
    UBFX  W13, W8, #0x10, #6
    SBFX  W9, W4, #0x0, #23
    MADD  W17, W13, W7, W20
    ASRV  W14, W14, W6
    SXTB  X10, W14
    REV  X8, X10
    MUL  W20, W18, W8
    TST  W11, #0xe1ffe1ff
    ORR  X7, X9, #0x8000000380000003
    SUBS  W9, W20, W17, UXTW #1
    ROR  X14, X17, X16
    SUBS  W4, W13, W2, SXTH #0
    ADD  W16, W19, W13, UXTH #1
    RORV  X23, X9, X12
    ORR  W3, W8, W10, LSR #29
    BIC  W2, W16, W10, ASR #1
    SBFM  X10, X20, #0x2a, #0x29
    SBCS  X8, X6, X4
    SUB  X9, X9, W13, SXTH #0
    CSEL  X18, X27, X13, LE
    EXTR  X2, X23, X18, #0x13
    SUB  W27, W10, #0x21a, LSL #12
    REV16  W17, W20
    EXTR  X4, X17, X3, #0x5
    NGCS  X21, X20
    BFI  X12, X12, #59, #2
    SXTW  X3, W22
    CLS  X19, X3
    ADD  W27, W21, W7, ASR #23
    SBC  X23, X23, X12
    ADC  W21, W9, W9
    CSNEG  X16, X18, X23, VC
    SUBS  X11, X12, X27, ASR #49
    EXTR  X13, X19, X11, #0x32
    SUB  X10, X16, #0x38e, LSL #12
    UBFIZ  W17, W6, #25, #5
    SXTH  W3, W13
    RORV  W7, W8, W18
    ADDS  X18, X21, W4, UXTH #4
    UBFX  W23, W18, #0x3, #5
    ANDS  X19, X4, #0xffffffc000003fff
    TST  W3, W18, ROR #28
    CLS  W21, W7
    ADDS  W18, W20, W21, SXTH #2
    RBIT  W13, W23
    ANDS  W8, W4, W10, LSR #0
    NGCS  W7, W18
    CLZ  W7, W8
    TST  X13, X21, LSL #15
    UMULL  X4, W7, W21
    ORN  X10, X17, X2, ASR #37
    REV  W6, W4
    BICS  X9, X3, X6, ROR #34
    UMNEGL  X18, W10, W21
    REV  X27, X18
    BFXIL  X23, X9, #0x30, #12
    ORR  W6, W19, W19, ROR #30
    ORN  X14, X23, X23, ASR #15
    CSINC  X4, X6, X14, LE
    UMULH  X10, X23, X7
    UDIV  X7, X9, X2
    AND  X23, X18, #0xffffc000000003ff
    BFXIL  W2, W11, #0x5, #8
    ASR  W18, W7, #0x1f
    REV32  X7, X6
    BICS  W8, W19, W17, LSR #11
    CLZ  X13, X18
    ADDS  W6, W22, W2, LSL #31
    MSUB  X18, X12, X3, X7
    SUBS  W2, W17, #0x4d6, LSL #12
    TST  W27, W16, ASR #14
    REV16  X27, X13
    SMADDL  X4, W2, W3, X10
    SBC  W11, W2, W7
    MADD  X10, X8, X19, X6
    ADDS  X2, X7, #0xe05, LSL #12
    UBFX  W13, W10, #0x1a, #1
    ASR  X17, X13, #0x36
    ASRV  W6, W11, W4
    SBFM  W4, W27, #0xb, #0x1b
    SMADDL  X13, W17, W17, X6
    MADD  X14, X13, X18, X23
    SUB  X27, X27, X7, ASR #41
    BIC  X18, X2, X22, LSL #54
    SUBS  W17, W14, #0x784, LSL #12
    ROR  W7, W27, W19
    ROR  X6, X8, #0x38
    SMULH  X2, X6, X10
    UMULL  X11, W9, W2
    SMULH  X2, X18, X21
    SXTB  X4, W2
    UBFM  W23, W7, #0xf, #0x1
    REV16  X7, X11
    BFI  W27, W22, #13, #2
    EOR  X2, X7, X16, LSL #55
    ROR  W8, W23, W4
    MADD  X21, X21, X4, X9
    ORR  W13, W11, #0x1fffff0
    SBC  W21, W8, W9
    SXTB  W9, W12
    ANDS  W4, W27, #0x1000100
    SUB  W10, W4, #0x484, LSL #12
    EOR  X12, X21, X17, LSL #42
    TST  W12, #0xfff3fff3
    AND  W8, W2, #0x400040
    EXTR  X23, X9, X14, #0x8
    BFI  X16, X14, #22, #8
    SUB  X21, X13, #0x4c7, LSL #12
    MUL  X2, X16, X10
    SMULH  X19, X23, X4
    CSNEG  X4, X9, X14, CC
    CSINC  W27, W17, W9, HI
    SXTB  W17, W19
    SMULL  X11, W23, W17
    MSUB  W17, W8, W11, W4
    NEGS  X17, X7, LSR #2
    SDIV  W8, W17, W27
    EXTR  W17, W14, W17, #0x1b
    MUL  X11, X6, X9
    UBFIZ  X14, X11, #7, #50
    CSINC  X27, X14, X4, NE
    SMNEGL  X4, W21, W8
    BIC  W23, W2, W18, LSL #7
    RBIT  W13, W27
    ADD  X16, X12, #0x37c
    RORV  X12, X13, X12
    ASRV  W8, W13, W4
    MADD  X4, X12, X12, X22
    MSUB  X21, X8, X21, X14
    SDIV  W18, W17, W16
    SMSUBL  X9, W10, W4, X6
    SUBS  W11, W20, W21, LSL #7
    AND  W7, W9, W22, ROR #0
    SXTH  W2, W7
    ADD  X7, X7, X11, UXTX #0
    CSEL  W23, W21, W23, HI
    ROR  W16, W7, W21
    MADD  W12, W6, W2, W4
    ORN  W10, W23, W16, LSR #8
    NGC  X6, X6
    UXTB  W21, W18
    MSUB  X4, X4, X19, X12
    SUBS  X13, X10, X6, SXTX #3
    ADDS  X19, X22, #0x251, LSL #12
    MADD  X23, X6, X21, X9
    REV32  X7, X14
    ROR  W9, W10, #0x0
    MNEG  X9, X13, X7
    SMSUBL  X10, W4, W19, X23
    SXTB  X20, W9
    ADC  X2, X18, X10
    MVN  W11, W14, LSR #23
    EON  X19, X8, X7, ROR #38
    SUBS  X22, X22, #0x1
    B.NE  TSRTIntAlu_label_7
    MOVZ  X15, #0x4ffe, LSL #0
    MOVK  X15, #0x46, LSL #16
    MOVK  X15, #0x1, LSL #32
    SUB  X5, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X15, #0x8200, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X5, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X15, #0x2, LSL #0
    SUB  X5, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X5, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0x7fff, LSL #16
    SUB  X5, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X15, #0x5f71, LSL #0
    MOVK  X15, #0x46, LSL #16
    SUB  X5, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X5, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X15, #0x2, LSL #0
    SUB  X5, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X15, #0xffe1, LSL #0
    MOVK  X15, #0xfff7, LSL #16
    SUB  X5, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X15, #0x2638, LSL #0
    MOVK  X15, #0x800, LSL #16
    SUB  X5, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X15, #0x4080, LSL #0
    MOVK  X15, #0xf82f, LSL #16
    SUB  X5, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X15, #0xf08d, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X5, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X5, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X15, #0x8d, LSL #0
    SUB  X5, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X15, #0x7f73, LSL #0
    MOVK  X15, #0x90, LSL #16
    SUB  X5, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
    MOVZ  X15, #0xfffe, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X5, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTIntAlu_TestFail
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
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    MOVZ  X4, #0xa, LSL #0
TSRTIntAlu_label_8:
    ADDS  X27, X4, #0x9ca, LSL #12
    MADD  W27, W18, W19, W20
    CLZ  W13, W21
    SUB  X5, X27, X22, LSL #28
    TST  X13, X10, ASR #62
    ASRV  X17, X5, X14
    CLS  W13, W18
    ADCS  W2, W4, W16
    ADC  X21, X16, X5
    REV  W22, W9
    MADD  X5, X4, X6, X11
    RBIT  X9, X13
    BFM  W11, W16, #0x1a, #0x5
    BFI  W9, W8, #5, #4
    EOR  X18, X22, X9, LSL #60
    RBIT  X9, X4
    MUL  X11, X15, X13
    ADCS  W10, W10, W4
    EOR  W13, W17, W10, LSR #2
    MNEG  W27, W9, W23
    SDIV  X20, X2, X11
    SUBS  X17, X5, #0x51d
    SMULH  X15, X21, X15
    ANDS  W11, W13, W2, ASR #9
    AND  X16, X20, X17, LSR #50
    SUB  W6, W2, W23, UXTH #1
    SMNEGL  X14, W8, W11
    UDIV  X17, X18, X6
    MVN  X18, X17, ASR #3
    EXTR  X13, X14, X18, #0x2
    SUB  X17, X13, X27, ASR #61
    UBFIZ  X10, X10, #32, #31
    SBC  W13, W16, W10
    MUL  W27, W9, W13
    SUB  X8, X9, X17, UXTX #0
    BFI  X21, X8, #42, #1
    MVN  W11, W21, LSL #30
    ASRV  W8, W15, W15
    ANDS  X9, X11, X8, LSR #57
    UXTB  W19, W6
    NGC  W17, W17
    SXTH  X5, W2
    NEG  W6, W5, LSL #18
    UBFM  X21, X5, #0x3d, #0x1f
    UXTH  W10, W16
    ANDS  X20, X8, X27, LSL #44
    SUB  X14, X21, X9, UXTX #0
    ASR  X18, X16, X5
    SUBS  X13, X22, #0x3fd, LSL #12
    SBFIZ  X22, X9, #42, #15
    UXTH  W11, W17
    CLZ  W23, W22
    CSEL  W15, W23, W16, GT
    REV  X23, X21
    SXTB  W8, W10
    UMULL  X21, W13, W4
    BFI  W16, W15, #26, #1
    BFI  W6, W20, #13, #1
    ANDS  X17, X23, X21, LSL #43
    ORN  X10, X9, X16, LSL #61
    UBFX  W23, W19, #0x16, #7
    REV32  X13, X23
    SUBS  W15, W10, W2, ASR #23
    ADD  W3, W18, W13, SXTH #4
    BFXIL  X9, X13, #0x15, #12
    ADDS  X18, X2, #0xc72
    MNEG  W19, W6, W5
    ADC  X20, X3, X20
    SUBS  W2, W15, #0x718
    UMULH  X10, X2, X9
    SBFM  W13, W19, #0xe, #0x1f
    ADD  X19, X11, W10, UXTW #4
    SUB  X16, X27, X19, ASR #38
    ROR  W11, W16, #0x16
    SUBS  X17, X14, X17, ASR #23
    ASRV  W19, W3, W20
    MSUB  X23, X11, X11, X13
    SUB  W20, W23, W20, UXTB #2
    NEGS  W21, W18, LSL #5
    REV  X10, X20
    EOR  W23, W19, W10, ASR #21
    RORV  W5, W23, W23
    AND  W11, W5, W17, ROR #0
    MSUB  W14, W21, W21, W21
    UDIV  W5, W14, W11
    SUB  W15, W2, #0xbb2
    ORR  X17, X20, #0x7fffff807fffff80
    CLZ  W9, W2
    ADCS  W20, W4, W19
    ASR  X13, X2, #0x32
    MNEG  W10, W27, W23
    SUB  W14, W5, W23, ASR #30
    NEGS  W21, W27, LSL #14
    MUL  X2, X19, X13
    ADD  X20, X15, X5, LSR #55
    MUL  X15, X14, X14
    NEG  X14, X6, LSR #35
    CSINC  W18, W20, W5, GE
    REV32  X19, X17
    CLS  W15, W21
    UBFIZ  W20, W21, #20, #7
    BFXIL  X6, X15, #0x31, #5
    BFI  X3, X2, #20, #27
    SBFM  W21, W22, #0xb, #0x1e
    ROR  X15, X20, #0x37
    ORN  X17, X19, X9, LSR #46
    CSINC  W27, W3, W17, CS
    ADC  X22, X21, X5
    UMULH  X13, X14, X27
    NEGS  X20, X21, LSR #0
    SUBS  W11, W10, W8, LSL #27
    NGC  X3, X13
    UMULH  X5, X20, X15
    CSEL  W14, W22, W6, VS
    SBFIZ  X17, X20, #23, #22
    UDIV  X19, X14, X14
    NGC  X2, X3
    RBIT  W20, W2
    ASR  W16, W20, W17
    ADDS  W3, W19, #0xea5
    MADD  X27, X21, X15, X20
    SBCS  W22, W13, W16
    ROR  W17, W11, #0x0
    NGC  X6, X5
    UMSUBL  X20, W3, W27, X3
    SUB  W19, W6, W6, ASR #6
    SDIV  W5, W19, W11
    EOR  X19, X27, X18, LSL #47
    SDIV  X10, X17, X5
    SUBS  X18, X19, W23, UXTH #3
    SUBS  X9, X10, X20, UXTX #3
    SUBS  X16, X18, W22, SXTW #4
    ADD  W8, W16, W17, LSL #3
    ADDS  X17, X8, #0x800, LSL #12
    ORN  W22, W27, W21, LSL #2
    ASR  X6, X5, #0x2c
    ADC  W27, W27, W10
    MNEG  X5, X15, X6
    AND  W23, W5, #0xe0000fff
    EOR  X27, X11, #0x3ffff0003ffff0
    SDIV  X18, X5, X23
    UBFM  W15, W21, #0x1d, #0x9
    SUBS  X13, X10, W11, SXTW #0
    BFXIL  W8, W22, #0xf, #6
    UBFIZ  X16, X10, #45, #8
    RBIT  X22, X17
    UMULL  X10, W14, W15
    SDIV  W21, W22, W10
    RBIT  X15, X19
    MSUB  X11, X13, X20, X27
    UBFM  X5, X20, #0x3a, #0x2
    EON  X22, X4, X9, ROR #52
    UBFIZ  X3, X13, #53, #9
    UBFIZ  W14, W18, #20, #9
    SUB  W3, W3, W21, LSL #5
    SMULL  X14, W8, W17
    NEGS  W20, W9, LSL #31
    CLZ  X13, X15
    SUBS  W21, W19, W11, UXTH #4
    UDIV  X22, X2, X4
    TST  W3, #0xffc07fff
    ORN  W6, W13, W5, LSL #31
    SUB  W5, W22, W10, ASR #18
    TST  X17, #0x1ffffc001ffffc
    MSUB  X2, X21, X5, X2
    UMULH  X22, X6, X2
    EOR  W17, W14, #0x800f800f
    BFXIL  X9, X20, #0x35, #7
    MSUB  W6, W21, W19, W9
    SUB  W15, W14, W23, ASR #22
    SDIV  X20, X16, X22
    EON  X23, X15, X17, LSR #57
    SXTB  W2, W6
    CSEL  X16, X5, X20, VC
    SMNEGL  X5, W2, W23
    EXTR  W22, W6, W16, #0x0
    SBCS  X2, X3, X11
    AND  X16, X3, X17, LSL #27
    SXTB  W10, W5
    SUB  W20, W11, W14, LSR #28
    BFI  W14, W11, #29, #3
    MUL  X6, X11, X3
    BICS  X19, X20, X15, ROR #18
    CLZ  W22, W13
    UBFX  W17, W3, #0xd, #17
    ORR  X9, X23, X13, LSL #55
    ADCS  X23, X16, X13
    BFI  W21, W9, #20, #2
    ANDS  X3, X2, #0x1fffff000000
    BFXIL  X15, X21, #0x36, #5
    UMNEGL  X11, W15, W6
    AND  X6, X27, X27, LSL #42
    SBFM  X5, X22, #0x25, #0x3c
    SUB  W22, W6, W23, ASR #23
    ADC  W21, W19, W3
    ADD  W23, W14, W14, SXTW #4
    AND  W16, W17, #0x7e7e7e7e
    ANDS  W3, W10, #0x7ffe
    MUL  W18, W16, W21
    SUB  X15, X10, #0x97e, LSL #12
    SUBS  X4, X4, #0x1
    B.NE  TSRTIntAlu_label_8
    MOVZ  X12, #0xf, LSL #0
    MOVK  X12, #0xffc0, LSL #16
    MOVK  X12, #0xf, LSL #32
    MOVK  X12, #0xffc0, LSL #48
    SUB  X7, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X12, #0x7f80, LSL #0
    SUB  X7, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc000, LSL #32
    MOVK  X12, #0x3f, LSL #48
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X12, #0x3f, LSL #0
    SUB  X7, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X12, #0xfc0f, LSL #0
    MOVK  X12, #0xe07f, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X7, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X12, #0xff80, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X7, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X12, #0x2f, LSL #0
    SUB  X7, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X12, #0x3f0, LSL #0
    MOVK  X12, #0x1f80, LSL #16
    SUB  X7, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X12, #0x1f80, LSL #0
    MOVK  X12, #0xff68, LSL #16
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X12, #0xf80f, LSL #0
    MOVK  X12, #0x3f, LSL #16
    SUB  X7, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X12, #0xffef, LSL #0
    MOVK  X12, #0x3f, LSL #16
    SUB  X7, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X12, #0xf80f, LSL #0
    MOVK  X12, #0xff3f, LSL #16
    SUB  X7, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X12, #0x42f0, LSL #0
    MOVK  X12, #0x1780, LSL #16
    SUB  X7, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
    MOVZ  X12, #0xfff0, LSL #0
    MOVK  X12, #0x3f, LSL #16
    MOVK  X12, #0xfff0, LSL #32
    MOVK  X12, #0x3f, LSL #48
    SUB  X7, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTIntAlu_TestFail
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
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    MOVZ  X27, #0xa, LSL #0
TSRTIntAlu_label_9:
    REV16  X8, X23
    SUBS  X14, X27, X22, ASR #46
    SBC  X19, X14, X27
    SMULL  X11, W21, W15
    NGCS  W9, W19
    UMULH  X9, X5, X17
    SBFIZ  W23, W7, #25, #1
    MNEG  X15, X9, X23
    SUBS  X23, X15, #0x90, LSL #12
    CSINV  W8, W8, W4, GT
    AND  W3, W23, #0xfc0000ff
    CLZ  W16, W2
    ASRV  X12, X22, X8
    CSINV  W9, W22, W18, GT
    SUB  W4, W11, #0x65f, LSL #12
    SUBS  W14, W12, W9, LSL #17
    REV16  W8, W4
    SUB  W19, W7, W22, ASR #31
    NEG  X21, X8, LSL #14
    ORN  X2, X19, X11, LSL #59
    UBFM  X11, X11, #0x25, #0x16
    MUL  X3, X14, X16
    AND  X14, X3, X19, LSR #58
    SUB  W22, W7, W21, UXTX #1
    TST  X22, #0x1ffe00001ffe
    MSUB  X5, X16, X2, X9
    UBFIZ  W17, W19, #4, #17
    SBFM  X14, X14, #0x25, #0x2f
    REV  X15, X11
    UMSUBL  X7, W5, W20, X17
    CLZ  X5, X12
    BFM  X15, X6, #0x7, #0x7
    UXTB  W17, W5
    ADD  X23, X7, W15, UXTH #0
    ASR  W22, W23, #0x1c
    SUB  X7, X17, #0x2f0
    ANDS  X18, X22, X7, ROR #17
    SMULH  X15, X18, X22
    CLS  X6, X7
    ROR  X7, X23, #0x7
    NGCS  X17, X4
    SUBS  W4, W21, #0x19, LSL #12
    SBC  W3, W3, W14
    CSINC  W21, W27, W27, LS
    BFM  W19, W15, #0x6, #0x1
    CLS  X2, X6
    AND  X23, X21, X5, ROR #21
    SXTB  X19, W23
    BICS  X20, X22, X9, ROR #3
    BIC  W14, W11, W9, ASR #29
    UBFIZ  W9, W19, #16, #10
    ORN  X19, X15, X7, ASR #52
    ANDS  W15, W6, #0x3ffc000
    SUB  X3, X4, W19, SXTH #3
    REV16  X14, X9
    NGCS  X16, X15
    ROR  X5, X16, X16
    UBFX  W14, W2, #0x12, #1
    CSINC  X9, X3, X15, LE
    NEG  W12, W20, LSL #30
    EXTR  X21, X9, X17, #0x16
    ASR  W7, W21, #0xf
    ANDS  W4, W9, #0xdddddddd
    MADD  W21, W23, W27, W3
    ANDS  W2, W9, #0xfe0000
    ORR  W11, W5, #0x3fe03fe0
    UDIV  W15, W14, W12
    MADD  W15, W5, W15, W6
    EXTR  W20, W7, W12, #0x3
    RORV  X6, X20, X20
    MUL  W16, W2, W4
    ROR  W7, W11, #0x12
    ANDS  X4, X19, X3, LSR #4
    SBC  X6, X17, X4
    CSEL  W9, W16, W6, VC
    UBFIZ  W12, W9, #27, #2
    ORR  W16, W15, #0xffc00007
    EOR  X4, X21, X3, ASR #19
    EOR  W18, W12, #0xfff7ffff
    SUB  W16, W16, #0x6af, LSL #12
    CSNEG  X12, X7, X16, HI
    TST  W12, W12, ASR #12
    AND  W12, W2, W11, ASR #13
    BIC  X17, X18, X12, ROR #41
    UMNEGL  X18, W2, W23
    SUB  W19, W4, W19, SXTH #0
    ADD  W21, W17, W11, LSR #1
    ADDS  W5, W19, #0xec8
    ANDS  W23, W9, #0xfcfcfcfc
    MUL  W12, W9, W3
    ORN  W3, W23, W6, LSL #19
    ANDS  X15, X15, #0xff0000007fffffff
    NEG  W22, W17, ASR #28
    TST  W14, #0x801f801f
    REV  W2, W8
    REV  W17, W12
    SMULH  X6, X20, X14
    ADD  W11, W7, W15, ASR #0
    UMSUBL  X22, W22, W9, X11
    UBFIZ  X7, X21, #33, #16
    REV16  W16, W5
    CLS  X20, X7
    BIC  X4, X16, X3, LSR #50
    REV  W12, W4
    BFXIL  W15, W6, #0xc, #19
    ASRV  W5, W19, W15
    ADDS  X8, X5, X12, LSR #34
    NEGS  W7, W20, ASR #12
    ASRV  W6, W2, W2
    TST  X16, #0xffffffffdfffffff
    NEG  W12, W7, LSR #23
    SUB  X21, X8, #0xda2, LSL #12
    MSUB  W14, W3, W19, W16
    SUB  X9, X9, #0xa95, LSL #12
    AND  W5, W18, #0xffff00
    SUBS  W7, W3, #0xfb6
    ADDS  W3, W6, #0x689, LSL #12
    SXTB  X11, W14
    SBFIZ  X15, X17, #4, #42
    ADD  X4, X5, W12, SXTW #4
    MUL  W8, W17, W27
    ASR  W18, W11, #0x1b
    UBFM  W6, W9, #0x12, #0x13
    ANDS  X18, X6, X4, LSR #8
    MADD  X4, X6, X7, X3
    MVN  X12, X15, LSL #27
    REV16  W20, W22
    CSINC  X19, X27, X8, NV
    ORN  W16, W8, W18, LSL #28
    ADC  X6, X7, X11
    CSNEG  X14, X15, X16, AL
    RORV  X3, X19, X6
    EOR  X17, X20, #0xc00fffffffffffff
    ROR  W12, W21, #0xe
    CSEL  X15, X4, X14, AL
    SXTB  W11, W15
    SBFM  X7, X3, #0x14, #0x1f
    UDIV  W18, W2, W11
    ANDS  W4, W8, #0xfc3ffc3f
    MUL  W3, W12, W4
    MUL  W14, W8, W3
    UBFM  W21, W16, #0x1f, #0x7
    BICS  X16, X21, X11, ROR #36
    UDIV  W20, W14, W27
    MNEG  W9, W17, W15
    ASR  W6, W8, W12
    MADD  W21, W11, W4, W21
    AND  W23, W6, W21, ASR #9
    SXTB  X3, W20
    SUB  W2, W7, #0x53a, LSL #12
    ORN  X6, X18, X2, LSL #30
    UMNEGL  X15, W14, W9
    SBCS  X12, X22, X22
    CSINC  W22, W16, W15, VS
    NGCS  X11, X12
    ORN  X9, X23, X11, ASR #40
    CSNEG  X19, X6, X22, CC
    CSEL  X17, X9, X9, VS
    NEG  W5, W22, LSR #21
    ANDS  W22, W3, W17, LSR #11
    ORR  X8, X19, #0xfc000003fc000003
    RBIT  X17, X17
    MNEG  X4, X12, X21
    SBC  W19, W4, W19
    CSINV  W22, W18, W5, VC
    UBFIZ  W12, W19, #9, #1
    MUL  W14, W17, W8
    ADCS  X17, X14, X21
    UMNEGL  X23, W17, W8
    ADD  X6, X23, X21, ASR #41
    SMULL  X20, W6, W6
    ADC  X4, X23, X12
    CSINC  X23, X22, X3, HI
    UBFIZ  W2, W18, #21, #3
    RBIT  W17, W4
    BFM  W6, W20, #0x16, #0x3
    ADDS  X14, X16, #0x600
    ORR  W19, W23, #0xe1ffffff
    UXTH  W22, W20
    CSNEG  X21, X14, X14, GT
    CSNEG  X23, X22, X17, MI
    MNEG  X5, X19, X21
    ROR  X4, X6, X3
    UMSUBL  X2, W4, W5, X4
    UDIV  X22, X23, X12
    SBFM  W8, W7, #0x7, #0x12
    ORR  W9, W4, W21, LSL #7
    UXTB  W9, W5
    SXTH  X11, W16
    SMULH  X6, X11, X19
    NEG  W9, W12, LSL #29
    SBFIZ  X16, X9, #8, #41
    ADD  X19, X23, W15, UXTW #3
    ADDS  W11, W19, W3, ASR #0
    ANDS  W17, W4, W7, LSR #11
    ADD  W3, W6, #0x827
    ADCS  W7, W9, W3
    BFXIL  X3, X5, #0x28, #17
    ANDS  X9, X16, #0x1ffffffffffff
    EOR  X12, X17, #0x60006000600060
    SUBS  X27, X27, #0x1
    B.NE  TSRTIntAlu_label_9
    MOVZ  X13, #0x19fd, LSL #0
    MOVK  X13, #0xc3d0, LSL #16
    MOVK  X13, #0xfb68, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X10, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTIntAlu_TestFail
    MOVZ  X13, #0xfff8, LSL #0
    MOVK  X13, #0x1, LSL #16
    SUB  X10, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTIntAlu_TestFail
    MOVZ  X13, #0x5ff, LSL #0
    SUB  X10, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTIntAlu_TestFail
    MOVZ  X13, #0x7fe, LSL #0
    MOVK  X13, #0xc400, LSL #16
    MOVK  X13, #0xf8f1, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X10, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTIntAlu_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X10, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTIntAlu_TestFail
    MOVZ  X13, #0x827, LSL #0
    SUB  X10, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTIntAlu_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X10, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTIntAlu_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X10, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTIntAlu_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x80, LSL #16
    SUB  X10, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTIntAlu_TestFail
    MOVZ  X13, #0x60, LSL #0
    MOVK  X13, #0x60, LSL #16
    MOVK  X13, #0x60, LSL #32
    MOVK  X13, #0x60, LSL #48
    SUB  X10, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTIntAlu_TestFail
    MOVZ  X13, #0x7fe, LSL #0
    SUB  X10, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTIntAlu_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X10, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTIntAlu_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X10, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTIntAlu_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X10, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTIntAlu_TestFail
    MOVZ  X13, #0x3530, LSL #0
    MOVK  X13, #0x35, LSL #16
    SUB  X10, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTIntAlu_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x80, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X10, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTIntAlu_TestFail
    MOVZ  X13, #0xfc01, LSL #0
    MOVK  X13, #0x3, LSL #16
    SUB  X10, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTIntAlu_TestFail
    MOVZ  X13, #0x7fe, LSL #0
    SUB  X10, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTIntAlu_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTIntAlu_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x80, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X10, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTIntAlu_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X10, X13, X27
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTIntAlu_TestFail
    MOVZ  X2, #0xfdb6, LSL #0
    MOVK  X2, #0xb991, LSL #16
    MOVK  X2, #0x9f70, LSL #32
    MOVK  X2, #0x2b52, LSL #48
    MOVZ  X3, #0x1f92, LSL #0
    MOVK  X3, #0xd36a, LSL #16
    MOVK  X3, #0x70b7, LSL #32
    MOVK  X3, #0x6f55, LSL #48
    MOVZ  X4, #0xa717, LSL #0
    MOVK  X4, #0xb5c6, LSL #16
    MOVK  X4, #0x8a85, LSL #32
    MOVK  X4, #0xf48b, LSL #48
    MOVZ  X5, #0xe01d, LSL #0
    MOVK  X5, #0x152d, LSL #16
    MOVK  X5, #0x2075, LSL #32
    MOVK  X5, #0x6ba7, LSL #48
    MOVZ  X6, #0x7dad, LSL #0
    MOVK  X6, #0xa847, LSL #16
    MOVK  X6, #0xb0e5, LSL #32
    MOVK  X6, #0xf942, LSL #48
    MOVZ  X7, #0x61f3, LSL #0
    MOVK  X7, #0x9d9d, LSL #16
    MOVK  X7, #0xeca8, LSL #32
    MOVK  X7, #0x90a0, LSL #48
    MOVZ  X8, #0xc4cd, LSL #0
    MOVK  X8, #0x48c1, LSL #16
    MOVK  X8, #0xce9f, LSL #32
    MOVK  X8, #0x9c7, LSL #48
    MOVZ  X9, #0x7972, LSL #0
    MOVK  X9, #0xc484, LSL #16
    MOVK  X9, #0x813a, LSL #32
    MOVK  X9, #0x7674, LSL #48
    MOVZ  X10, #0x372d, LSL #0
    MOVK  X10, #0x1a71, LSL #16
    MOVK  X10, #0x9089, LSL #32
    MOVK  X10, #0x324a, LSL #48
    MOVZ  X11, #0x7102, LSL #0
    MOVK  X11, #0xbbcc, LSL #16
    MOVK  X11, #0x72fa, LSL #32
    MOVK  X11, #0xd8be, LSL #48
    MOVZ  X12, #0xfd9f, LSL #0
    MOVK  X12, #0xcfba, LSL #16
    MOVK  X12, #0x95dd, LSL #32
    MOVK  X12, #0xe1cc, LSL #48
    MOVZ  X13, #0xbeb1, LSL #0
    MOVK  X13, #0xc20c, LSL #16
    MOVK  X13, #0xc94c, LSL #32
    MOVK  X13, #0x9dd1, LSL #48
    MOVZ  X14, #0x1daa, LSL #0
    MOVK  X14, #0xb280, LSL #16
    MOVK  X14, #0x7049, LSL #32
    MOVK  X14, #0x2c41, LSL #48
    MOVZ  X15, #0xd28c, LSL #0
    MOVK  X15, #0xf6a, LSL #16
    MOVK  X15, #0x9982, LSL #32
    MOVK  X15, #0x70b2, LSL #48
    MOVZ  X16, #0x376a, LSL #0
    MOVK  X16, #0x5576, LSL #16
    MOVK  X16, #0xdbc6, LSL #32
    MOVK  X16, #0x135d, LSL #48
    MOVZ  X17, #0xb66a, LSL #0
    MOVK  X17, #0x9791, LSL #16
    MOVK  X17, #0x65f3, LSL #32
    MOVK  X17, #0xfbd5, LSL #48
    MOVZ  X18, #0xfd70, LSL #0
    MOVK  X18, #0x6ffb, LSL #16
    MOVK  X18, #0x56ac, LSL #32
    MOVK  X18, #0x8367, LSL #48
    MOVZ  X19, #0xab91, LSL #0
    MOVK  X19, #0x2814, LSL #16
    MOVK  X19, #0x55ff, LSL #32
    MOVK  X19, #0x13d8, LSL #48
    MOVZ  X20, #0xaf76, LSL #0
    MOVK  X20, #0xbad6, LSL #16
    MOVK  X20, #0xbb53, LSL #32
    MOVK  X20, #0xefec, LSL #48
    MOVZ  X21, #0x46bd, LSL #0
    MOVK  X21, #0xf4e6, LSL #16
    MOVK  X21, #0x19a0, LSL #32
    MOVK  X21, #0x239d, LSL #48
    MOVZ  X22, #0xa3d9, LSL #0
    MOVK  X22, #0x9a14, LSL #16
    MOVK  X22, #0x24a1, LSL #32
    MOVK  X22, #0x8e11, LSL #48
    MOVZ  X23, #0x248b, LSL #0
    MOVK  X23, #0x2744, LSL #16
    MOVK  X23, #0xca8b, LSL #32
    MOVK  X23, #0x915, LSL #48
    MOVZ  X27, #0x9f33, LSL #0
    MOVK  X27, #0xe70b, LSL #16
    MOVK  X27, #0xd332, LSL #32
    MOVK  X27, #0xeb29, LSL #48
    MOVZ  X2, #0xa, LSL #0
TSRTIntAlu_label_10:
    CSINC  W5, W4, W27, LS
    ANDS  W10, W2, W16, LSR #10
    TST  W23, #0xfffe0001
    MUL  X11, X5, X5
    EXTR  X11, X10, X18, #0x19
    UDIV  W11, W11, W4
    AND  W18, W7, W2, ROR #21
    ADD  W16, W21, W18, ASR #28
    NGCS  X6, X11
    UMSUBL  X11, W16, W16, X16
    SXTH  X11, W11
    ROR  W16, W17, #0xc
    SBC  X7, X12, X23
    MADD  X17, X7, X7, X6
    ROR  W12, W17, W17
    BFI  W17, W21, #29, #1
    ORN  X18, X27, X12, LSR #31
    CSEL  X18, X11, X17, AL
    SBFX  X21, X16, #0x3, #26
    RBIT  W22, W9
    MADD  X10, X6, X17, X21
    BFM  W17, W16, #0x16, #0x1
    MUL  W13, W9, W21
    ADDS  W6, W13, #0x414, LSL #12
    SUB  X16, X19, X7, LSL #37
    BFXIL  X23, X5, #0x20, #12
    EON  W13, W6, W19, LSR #22
    ASRV  W6, W10, W8
    SDIV  X12, X10, X27
    ADDS  X9, X6, X13, SXTX #4
    EOR  X10, X23, #0x3ffffffffffffff0
    MSUB  X5, X22, X17, X10
    BIC  W19, W9, W12, LSR #27
    EXTR  X7, X16, X5, #0x14
    SUB  X13, X10, X19, LSR #41
    ANDS  W23, W7, W13, ASR #30
    AND  W19, W4, #0x8080808
    ADDS  W22, W5, #0x1c
    CSEL  X10, X15, X15, LT
    TST  W18, #0x1e1e1e1e
    AND  W12, W13, #0xff800007
    REV  X9, X9
    BFI  W8, W13, #10, #20
    SMULL  X4, W7, W17
    AND  X13, X15, X6, LSR #33
    ADD  W17, W10, #0x48a
    BICS  X5, X9, X7, LSL #25
    EON  W17, W22, W22, LSL #12
    NEG  X21, X5, LSR #63
    SMADDL  X15, W21, W23, X12
    UMULL  X16, W8, W14
    ADC  X5, X18, X13
    SBFX  W27, W27, #0xb, #17
    CSNEG  W22, W4, W27, LT
    BFXIL  X12, X21, #0x3d, #3
    NGCS  W6, W17
    SBFX  W19, W22, #0xc, #1
    NEGS  W18, W19, LSR #8
    NEG  W19, W7, LSL #4
    MNEG  W19, W10, W16
    ADC  X4, X15, X11
    ORN  X22, X19, X18, LSR #57
    NGC  W15, W7
    ADDS  X10, X5, X5, SXTX #3
    SBFIZ  W19, W6, #25, #1
    SBFX  W14, W4, #0x7, #16
    ADDS  W13, W22, W12, UXTX #4
    UMSUBL  X6, W14, W13, X10
    CLS  X21, X8
    ASR  W22, W2, W2
    SXTB  W5, W18
    SXTW  X7, W6
    UBFIZ  W9, W14, #2, #9
    MNEG  X9, X6, X7
    UBFIZ  X13, X21, #15, #1
    ORR  X16, X22, #0x3fc000003fc0
    SUBS  W7, W15, W5, SXTB #0
    RORV  X21, X16, X2
    ADC  X12, X14, X21
    ASRV  W11, W9, W7
    BFI  X22, X8, #9, #52
    REV16  W4, W22
    NEGS  W27, W11, LSR #10
    ROR  W17, W4, #0x5
    ORR  W5, W13, W19, ASR #14
    UDIV  W22, W17, W12
    MUL  W6, W8, W22
    NEG  X18, X2, ASR #31
    ADD  X16, X4, X15, ASR #58
    BIC  W15, W5, W10, ROR #2
    ANDS  W22, W18, W27, LSR #20
    CSINV  W27, W4, W6, VS
    SMSUBL  X23, W22, W19, X23
    BFI  W19, W27, #1, #24
    EOR  X6, X19, X27, LSL #53
    UMNEGL  X27, W2, W19
    CSINV  X19, X16, X27, MI
    CSINC  W14, W21, W15, LE
    ANDS  W12, W6, W19, ASR #13
    BIC  W5, W23, W21, LSR #26
    BICS  X10, X12, X12, ASR #21
    SUBS  X18, X17, X15, UXTX #0
    ORN  X15, X14, X12, ROR #38
    ORN  X8, X5, X15, ASR #53
    EON  X8, X18, X18, LSL #48
    ORR  X14, X7, #0x3ff800000000
    SBFM  X17, X18, #0x20, #0x3c
    MUL  X12, X10, X4
    CSNEG  W15, W15, W13, NE
    MSUB  W11, W14, W16, W18
    ASRV  W13, W11, W19
    SUB  W16, W13, W5, LSL #1
    AND  X7, X8, X8, LSL #10
    ORR  X27, X15, X2, LSR #10
    AND  X15, X12, #0x10000000
    SXTW  X6, W16
    ANDS  W14, W19, #0x3000300
    SBFM  W11, W16, #0x1d, #0x1b
    ADC  X19, X23, X7
    MUL  W8, W19, W15
    SXTB  W17, W9
    EXTR  X4, X27, X16, #0x12
    SUB  W9, W14, W6, UXTB #1
    BFI  W18, W4, #24, #8
    EXTR  W15, W11, W18, #0x7
    EXTR  W12, W15, W5, #0x19
    ROR  X14, X13, #0x5
    SBFM  W19, W18, #0x12, #0xf
    UDIV  W5, W10, W4
    UMADDL  X16, W19, W17, X5
    SBFX  W6, W22, #0x14, #8
    ANDS  X17, X16, #0xf000f000f000f000
    SMSUBL  X11, W8, W15, X14
    AND  W19, W9, W17, LSR #13
    CLS  X8, X7
    NGCS  W10, W11
    BFI  X9, X12, #23, #30
    UBFM  W5, W9, #0x15, #0x9
    MVN  W9, W21, ROR #7
    REV16  W12, W18
    EXTR  W27, W13, W19, #0x0
    SBFM  W11, W6, #0x11, #0x15
    SBFX  X4, X8, #0x23, #12
    CLS  W9, W10
    SBC  W23, W12, W4
    MSUB  X10, X2, X18, X9
    ADDS  W7, W11, #0x11c
    ADDS  X9, X27, #0xbe8
    CSINV  X17, X18, X5, LT
    RORV  X16, X27, X13
    SDIV  W4, W5, W2
    SUB  W19, W16, #0xf3, LSL #12
    NEGS  W21, W19, ASR #10
    CLS  W12, W15
    BICS  X6, X10, X23, ASR #61
    REV16  X10, X27
    UXTH  W8, W13
    ADD  W9, W7, W10, UXTH #3
    SMADDL  X22, W8, W6, X2
    ASR  W11, W21, W18
    ADCS  W7, W9, W22
    UMNEGL  X19, W7, W14
    NGCS  W23, W11
    SBFM  W11, W4, #0x1c, #0xa
    ADC  W16, W13, W11
    BFXIL  X14, X23, #0x3, #39
    SBFX  W18, W9, #0x17, #4
    RBIT  W6, W19
    UBFIZ  X18, X15, #24, #3
    SUBS  X7, X16, X10, ASR #13
    SUBS  W12, W6, #0x778
    ADD  W8, W15, #0xf
    RBIT  X10, X23
    MVN  X19, X19, LSL #37
    EOR  W5, W17, W19, ROR #0
    ADDS  W4, W8, #0x477
    SBFX  X18, X5, #0x35, #5
    ADD  W22, W11, #0x12b, LSL #12
    SMULH  X5, X16, X22
    SUB  W23, W21, W27, ASR #26
    REV  X19, X5
    SUB  W14, W23, W14, ASR #14
    AND  W13, W19, #0x600060
    SBCS  W27, W14, W7
    BFI  X23, X27, #48, #1
    NEGS  W10, W4, ASR #12
    SUB  W14, W12, #0x1be
    ADD  W11, W18, W23, LSL #14
    UMSUBL  X17, W13, W17, X14
    SBFIZ  X22, X10, #14, #2
    ASR  X12, X14, #0x20
    EXTR  X8, X13, X11, #0x6
    ADCS  X21, X12, X22
    SUB  X27, X4, W17, SXTH #1
    SUB  X5, X10, X6, LSR #17
    ADD  W19, W7, W27, ASR #26
    SMNEGL  X10, W19, W8
    CSEL  X16, X21, X10, CC
    ORN  W15, W22, W5, ASR #7
    MUL  W10, W23, W9
    SUBS  X2, X2, #0x1
    B.NE  TSRTIntAlu_label_10
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X3, #0x1376, LSL #0
    MOVK  X3, #0x12c, LSL #16
    SUB  X20, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X3, #0x98f8, LSL #0
    MOVK  X3, #0xffff, LSL #16
    SUB  X20, X3, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X3, #0x4830, LSL #0
    MOVK  X3, #0xa88f, LSL #16
    SUB  X20, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X3, #0xfffe, LSL #0
    MOVK  X3, #0xffff, LSL #16
    SUB  X20, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X3, #0xcc00, LSL #0
    MOVK  X3, #0x3, LSL #16
    SUB  X20, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X3, #0x11c, LSL #0
    SUB  X20, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X3, #0x3650, LSL #0
    MOVK  X3, #0x4, LSL #16
    SUB  X20, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0xf3, LSL #16
    SUB  X20, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X3, #0x3efa, LSL #0
    MOVK  X3, #0xa88f, LSL #16
    SUB  X20, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X3, #0xc0ce, LSL #0
    MOVK  X3, #0xffff, LSL #16
    SUB  X20, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X3, #0xc000, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X20, X3, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X3, #0x3efa, LSL #0
    MOVK  X3, #0xa88f, LSL #16
    SUB  X20, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X3, #0xfffe, LSL #0
    MOVK  X3, #0xffff, LSL #16
    SUB  X20, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X3, #0xc000, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X20, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X3, #0xc000, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X20, X3, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X3, #0x3cc, LSL #0
    SUB  X20, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
    MOVZ  X3, #0x9582, LSL #0
    MOVK  X3, #0x12b, LSL #16
    SUB  X20, X3, X27
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTIntAlu_TestFail
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
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X18, #0xa, LSL #0
TSRTIntAlu_label_11:
    RBIT  W13, W19
    UBFX  X9, X7, #0x37, #3
    MVN  W10, W10, LSL #19
    EON  W15, W14, W19, LSR #5
    ADD  X23, X15, W18, SXTH #0
    TST  X6, #0x7ffffff80000000
    SMULH  X11, X21, X5
    EON  X8, X13, X4, LSR #3
    AND  W9, W15, W2, ASR #11
    EON  X22, X9, X9, ROR #56
    SDIV  X19, X22, X11
    UBFM  W14, W8, #0xf, #0x0
    MVN  X6, X20, LSL #44
    MNEG  W10, W13, W4
    MADD  X2, X19, X17, X11
    MNEG  X20, X6, X2
    ADD  W3, W20, W12, UXTB #4
    ASR  W9, W19, W8
    SMADDL  X7, W14, W23, X23
    ANDS  W20, W18, #0xfc01ffff
    TST  W7, #0x3800380
    UMULL  X12, W10, W15
    EON  X20, X22, X20, ROR #29
    BICS  W22, W7, W9, LSL #8
    MNEG  W2, W18, W22
    MUL  X3, X12, X2
    REV16  W11, W17
    MNEG  X17, X21, X3
    SBCS  X22, X20, X17
    SBCS  X14, X18, X11
    SUBS  W6, W22, #0x972, LSL #12
    AND  W7, W10, W2, ROR #21
    ADC  X23, X8, X11
    SMULH  X13, X13, X14
    UDIV  W19, W20, W18
    EOR  X3, X17, X5, ROR #42
    UMSUBL  X20, W21, W13, X4
    UBFX  X2, X2, #0x3d, #2
    ADDS  X13, X12, #0x5fc, LSL #12
    ADD  X8, X12, X3, UXTX #2
    MADD  X10, X21, X18, X15
    EOR  W6, W3, #0xc
    ADDS  X21, X2, #0x169, LSL #12
    UMULH  X12, X21, X10
    UBFM  W6, W8, #0xd, #0x17
    ROR  X14, X19, #0x36
    REV  W5, W20
    CSINC  X8, X5, X4, LS
    BFI  W17, W7, #22, #9
    SMNEGL  X22, W13, W22
    NEG  W21, W12, LSL #14
    MSUB  W5, W8, W10, W14
    SDIV  W4, W10, W17
    AND  X6, X3, X5, ROR #30
    ADDS  W20, W20, W22, LSR #27
    AND  X17, X10, X2, ASR #53
    REV32  X8, X20
    ASR  W10, W6, #0xa
    SMULH  X6, X4, X21
    SDIV  X3, X20, X10
    ANDS  X11, X17, X17, ASR #1
    MSUB  W4, W19, W3, W17
    EXTR  X11, X11, X8, #0x36
    SBC  X17, X11, X7
    ORN  X11, X6, X4, ASR #19
    SBFX  X22, X18, #0x20, #13
    EON  W5, W21, W13, LSL #18
    ASRV  X6, X21, X3
    ADC  X12, X23, X2
    CSNEG  W13, W12, W9, NE
    MADD  W21, W10, W17, W7
    BIC  W20, W23, W20, LSL #26
    SUB  W14, W10, W20, LSL #23
    UBFX  W19, W5, #0x1d, #2
    SDIV  X4, X12, X7
    ADD  X20, X21, X10, ASR #14
    SBC  X9, X11, X8
    SXTB  X7, W10
    SMNEGL  X8, W11, W20
    MVN  X11, X9, LSL #6
    UDIV  W17, W17, W14
    MSUB  X14, X17, X11, X22
    NEG  X13, X7, ASR #59
    SBCS  W5, W21, W15
    UMULH  X3, X4, X11
    MNEG  W10, W3, W13
    ASR  X12, X14, X11
    NEGS  X15, X8, LSL #42
    REV32  X8, X17
    ASRV  W20, W9, W6
    MADD  W15, W15, W8, W19
    ANDS  W15, W5, W15, LSR #15
    SDIV  X21, X15, X12
    SBCS  X12, X20, X3
    CSINC  W5, W12, W10, NV
    CSNEG  X8, X18, X17, VS
    UMULH  X7, X7, X18
    ADC  X15, X7, X21
    SMSUBL  X7, W7, W5, X21
    UXTB  W20, W23
    SBFM  X11, X21, #0x37, #0xe
    SDIV  W13, W10, W19
    ADC  X12, X23, X13
    UBFM  W5, W13, #0x6, #0x1c
    ANDS  X21, X19, #0x7fff80
    TST  W23, W6, LSR #29
    RORV  W3, W19, W19
    UBFX  X23, X20, #0x5, #16
    EOR  W3, W3, #0x9fff9fff
    EON  X15, X4, X5, LSR #54
    BFXIL  W4, W21, #0x5, #13
    SXTH  W10, W11
    SBC  X21, X14, X23
    UBFX  W10, W23, #0x7, #4
    BFM  W23, W12, #0x13, #0x18
    ADD  W19, W8, W7, SXTX #3
    ADDS  X13, X4, W23, SXTH #2
    ANDS  X5, X19, #0x7000700070007
    SUB  X3, X7, #0x390
    ASR  W6, W14, #0x12
    UBFX  W20, W15, #0x13, #4
    NGCS  W15, W22
    ADD  W4, W13, W15, LSR #9
    CSEL  X4, X5, X6, VS
    NGC  W22, W10
    ROR  X7, X14, X13
    EOR  X17, X3, #0xffffe0000007ffff
    NGCS  X11, X22
    SBFM  X3, X13, #0xb, #0x36
    SXTH  W15, W17
    AND  X15, X15, #0xfffffffff8000003
    NGC  X5, X11
    SMSUBL  X12, W6, W5, X14
    SBFX  W17, W17, #0x10, #10
    BIC  X19, X20, X10, ASR #53
    UBFM  W11, W20, #0xe, #0xf
    SUBS  W5, W3, W19, LSL #31
    NEG  W6, W8, ASR #14
    EOR  X8, X6, X13, ROR #0
    CSINC  W9, W8, W21, CC
    ADD  X14, X4, X3, LSL #1
    SDIV  W13, W4, W14
    AND  W6, W15, W9, LSL #24
    ROR  X20, X13, #0x31
    TST  W17, W15, LSR #3
    TST  W7, #0xfffff1ff
    ADD  X22, X11, X11, LSR #52
    UBFX  W19, W5, #0xa, #21
    TST  W6, W14, ROR #26
    UBFM  X5, X19, #0x23, #0x4
    EXTR  W21, W20, W22, #0x1c
    UBFM  X3, X17, #0x17, #0x15
    MVN  W14, W10, ROR #15
    EON  X10, X4, X23, ROR #2
    CLZ  X22, X14
    UBFIZ  X17, X19, #30, #23
    SBCS  W4, W5, W12
    EXTR  W9, W3, W21, #0x0
    UMSUBL  X6, W22, W17, X8
    SMULH  X15, X4, X2
    ADDS  W11, W6, W9, ASR #19
    ASR  W7, W2, #0xe
    SBC  W13, W5, W11
    TST  W13, #0x3e
    NGC  X19, X18
    SUBS  W12, W5, W13, UXTH #4
    MUL  W13, W15, W12
    ANDS  W11, W21, #0x77777777
    TST  W3, W7, LSR #28
    ORR  W5, W19, #0xfffc0003
    NEG  X12, X5, ASR #25
    ORR  W4, W11, W10, LSL #10
    MVN  W4, W4, LSR #10
    ADD  W5, W12, W13, SXTX #2
    SBFIZ  W9, W23, #19, #10
    CSNEG  X15, X5, X17, LS
    BFI  X22, X8, #26, #37
    CSINC  W13, W7, W15, NV
    SBFX  X17, X12, #0x18, #39
    MADD  X10, X5, X13, X8
    SXTW  X21, W21
    ROR  X8, X10, X3
    BFM  X3, X22, #0x31, #0x29
    EOR  W5, W17, #0xc007c007
    RORV  X19, X13, X3
    UXTB  W22, W4
    SUBS  X14, X4, X11, LSR #58
    ROR  W13, W17, W9
    ADDS  W12, W18, #0xaf6
    MVN  X6, X5, LSR #28
    SMADDL  X15, W14, W20, X17
    CLZ  W4, W14
    AND  X14, X4, #0xfffffff00000001f
    SBFX  W10, W5, #0x1a, #3
    UBFIZ  W17, W15, #5, #22
    NEGS  W5, W8, LSL #27
    NEGS  W4, W12, LSL #2
    NEGS  W11, W8, LSL #14
    ASRV  W9, W6, W5
    SBFM  W3, W22, #0x1a, #0xa
    SUBS  X18, X18, #0x1
    B.NE  TSRTIntAlu_label_11
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X27, #0x29c0, LSL #0
    SUB  X16, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X27, #0xd424, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X16, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xf800, LSL #16
    SUB  X16, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X27, #0xfffc, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X16, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X27, #0x81, LSL #0
    SUB  X16, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X27, #0xfffc, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X16, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X16, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X27, #0xc000, LSL #0
    MOVK  X27, #0xffdf, LSL #16
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X27, #0xaf7, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X16, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X27, #0x7fff, LSL #0
    MOVK  X27, #0xf953, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X16, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X27, #0xffe0, LSL #0
    MOVK  X27, #0x26f, LSL #16
    SUB  X16, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X27, #0x8000, LSL #0
    SUB  X16, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x8, LSL #16
    SUB  X16, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X27, #0xa7, LSL #0
    SUB  X16, X27, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
    MOVZ  X27, #0x20, LSL #0
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTIntAlu_TestFail
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
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    MOVZ  X8, #0xa, LSL #0
TSRTIntAlu_label_12:
    SBFIZ  X5, X23, #32, #2
    SUBS  W19, W19, W23, UXTW #4
    SUB  W13, W3, W8, ASR #29
    UBFX  W4, W5, #0x12, #11
    REV32  X10, X22
    EOR  X22, X19, X10, LSL #49
    SXTH  X13, W4
    UXTH  W18, W13
    CSINV  W19, W22, W16, LT
    EON  X2, X17, X19, ROR #4
    SDIV  W12, W15, W19
    NGC  X23, X6
    UBFX  W4, W2, #0xf, #1
    ASR  W14, W11, #0x19
    NEGS  W5, W14, ASR #14
    MADD  X11, X5, X23, X12
    SXTH  X23, W18
    SMSUBL  X22, W23, W9, X9
    UMADDL  X6, W23, W4, X18
    ASRV  X3, X16, X11
    CLZ  X11, X22
    NGCS  X15, X3
    ROR  W14, W8, W11
    NEG  X3, X6, LSR #39
    UDIV  X2, X4, X14
    UBFIZ  W11, W7, #6, #22
    EXTR  W9, W2, W11, #0x1d
    ASR  X22, X15, #0x4
    SUBS  W23, W4, W5, ASR #28
    CSEL  W4, W9, W9, VS
    CSINV  W7, W2, W15, HI
    REV16  W12, W14
    CLZ  X2, X23
    CSINV  X9, X12, X22, NE
    NEG  X18, X15, LSR #3
    MSUB  X16, X20, X20, X18
    ADDS  X14, X16, X16, LSR #15
    ORN  W23, W2, W4, LSR #11
    ADDS  X4, X10, X12, LSR #19
    SUBS  X20, X16, X23, ASR #27
    MVN  W16, W7, LSL #5
    ORN  X6, X3, X14, ROR #46
    REV16  W14, W9
    UXTB  W23, W11
    UMADDL  X16, W14, W4, X14
    ADD  X15, X14, #0xec9
    SDIV  W22, W8, W13
    SUBS  W18, W15, W16, UXTH #4
    ADDS  W9, W20, W23, LSL #16
    ASR  X13, X12, X22
    REV32  X14, X18
    BICS  X16, X11, X6, ASR #11
    UBFX  W12, W13, #0x19, #3
    MADD  X13, X13, X5, X14
    CLS  W14, W16
    ADDS  W15, W12, #0x14f
    CSNEG  X10, X15, X9, LE
    SBC  W19, W14, W23
    ADDS  X18, X13, X8, ASR #19
    ROR  W5, W6, #0x1b
    NGCS  W22, W19
    UDIV  X19, X22, X5
    ADCS  W15, W10, W7
    SBFM  X6, X18, #0x27, #0x20
    REV32  X10, X15
    EOR  W15, W10, #0xc00003ff
    NEG  X22, X17, LSR #20
    BFXIL  X3, X15, #0xa, #36
    CSINC  W17, W3, W3, CS
    ORR  X9, X11, #0x7ffe00007ffe0000
    SMULH  X10, X19, X9
    EON  W23, W22, W16, ROR #7
    ADD  W14, W6, W6, SXTH #4
    ASR  X18, X12, #0x3
    MUL  X16, X18, X10
    CSEL  X3, X10, X14, MI
    SBFX  W9, W16, #0x3, #17
    MNEG  X14, X9, X11
    NGC  X16, X23
    ORR  W22, W16, #0x78007800
    SUB  W7, W2, W3, SXTH #1
    UBFX  X10, X14, #0x5, #31
    MADD  W15, W7, W22, W17
    MNEG  W11, W9, W10
    MSUB  X2, X11, X10, X7
    SXTW  X11, W23
    SXTH  W7, W13
    CLZ  W9, W14
    SUBS  W17, W7, W17, ASR #28
    SMADDL  X19, W6, W7, X11
    RBIT  W17, W18
    CSINC  W5, W12, W18, CC
    ORR  X12, X12, #0xffff8000007fffff
    REV32  X6, X23
    AND  X10, X7, X12, ASR #31
    BIC  X15, X10, X8, ASR #31
    EOR  X12, X9, X9, LSL #42
    MNEG  X16, X8, X9
    ROR  W14, W20, W4
    SMSUBL  X11, W19, W15, X23
    ROR  X16, X9, #0x0
    TST  W11, W14, LSR #31
    NGC  X13, X12
    ORR  X4, X2, X10, ASR #8
    NEG  W20, W6, ASR #1
    RBIT  X7, X18
    UBFIZ  X2, X17, #40, #11
    ASRV  X12, X4, X15
    NGC  W17, W13
    ADDS  W22, W17, W5, LSL #6
    SBCS  W6, W11, W11
    SUB  X14, X12, #0xdaa
    ORR  X3, X7, #0xffe01fffffe01fff
    SBFIZ  W14, W14, #5, #25
    NGCS  W2, W20
    ADD  W3, W6, #0xa7a
    AND  X7, X2, #0x20
    MNEG  X17, X11, X14
    REV16  X22, X3
    RORV  X20, X7, X16
    SXTB  X14, W14
    ADD  W3, W22, W17, ASR #28
    UBFX  W2, W20, #0x1b, #1
    SBFIZ  W10, W14, #18, #2
    EOR  W7, W2, #0xefffefff
    CSINV  X13, X8, X7, HI
    SUB  W2, W18, W17, ASR #10
    SXTB  W22, W13
    SUBS  X9, X3, #0x295, LSL #12
    CSINV  W3, W10, W2, NV
    TST  X19, #0xbfbfbfbfbfbfbfbf
    SBCS  X9, X9, X9
    ADD  W14, W9, #0xf1e, LSL #12
    SUB  W19, W22, #0xe06, LSL #12
    UBFX  X9, X5, #0x18, #13
    NEG  X9, X19, LSR #43
    AND  W3, W17, #0x3fffffc
    ADC  W11, W18, W9
    ADC  X18, X5, X15
    ADD  W15, W9, W11, LSL #24
    UXTB  W13, W14
    ANDS  X23, X6, #0xe000e000e000e0
    ADC  W4, W18, W22
    NEGS  W17, W23, ASR #20
    AND  W10, W13, W6, LSL #25
    ADDS  X18, X12, X3, ASR #21
    CSINC  X2, X20, X10, NV
    CLZ  X23, X18
    BIC  X6, X2, X12, LSL #15
    SUBS  W9, W5, W23, SXTX #3
    ADDS  W11, W4, #0x6b2, LSL #12
    AND  W18, W15, #0xfffdffff
    UBFIZ  W7, W6, #31, #1
    MADD  W17, W7, W17, W9
    BFXIL  W13, W18, #0x15, #6
    EOR  X3, X17, #0xc003ffffc003ffff
    ADD  W22, W3, W13, SXTX #2
    EOR  X23, X9, X8, LSL #58
    ORN  X5, X13, X18, ASR #11
    ASR  X17, X4, #0x18
    ORN  X2, X2, X15, ASR #57
    SBFIZ  W23, W20, #24, #6
    MADD  W12, W20, W23, W12
    UDIV  X4, X17, X11
    BIC  X10, X23, X19, ASR #37
    CLS  X23, X6
    RORV  W22, W15, W16
    UBFX  W19, W3, #0x5, #12
    UBFM  X18, X17, #0x2, #0x30
    SBFIZ  W14, W23, #18, #6
    ADCS  W7, W12, W23
    ORR  W16, W5, W12, ASR #7
    ANDS  W9, W10, W22, ROR #4
    CSNEG  W3, W14, W4, MI
    UBFIZ  X4, X9, #43, #1
    RORV  W12, W19, W7
    ANDS  X6, X8, X5, ROR #2
    ROR  X22, X2, #0x29
    SBCS  W2, W3, W18
    SUBS  X17, X6, W2, SXTB #0
    REV  X6, X6
    RORV  X15, X20, X20
    ADDS  X22, X6, #0x62b, LSL #12
    CSNEG  X19, X4, X14, NE
    SXTB  X12, W19
    NEG  X4, X15, LSL #55
    TST  X17, #0xfe01fe01fe01fe01
    ROR  W23, W11, #0x3
    EON  X20, X14, X12, ASR #40
    ANDS  W18, W16, #0x81ff81ff
    NEGS  X11, X22, LSL #10
    ASRV  X7, X12, X8
    CSINV  W5, W4, W11, GE
    ADD  X16, X12, W5, SXTH #3
    BFI  X9, X16, #33, #16
    CSNEG  X10, X9, X12, MI
    ROR  X16, X20, X20
    EON  W22, W18, W15, LSR #31
    BFI  W9, W7, #15, #8
    UXTB  W5, W23
    SUBS  X8, X8, #0x1
    B.NE  TSRTIntAlu_label_12
    MOVZ  X21, #0xffc0, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X27, X21, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X4
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x100, LSL #48
    SUB  X27, X21, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xfff0, LSL #32
    MOVK  X21, #0x1, LSL #48
    SUB  X27, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7540, LSL #16
    MOVK  X21, #0xfffe, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X27, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X21, #0xc0, LSL #0
    SUB  X27, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xfffc, LSL #16
    SUB  X27, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x20, LSL #32
    SUB  X27, X21, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0x7, LSL #16
    MOVK  X21, #0xfffe, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X27, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X21, #0x41, LSL #0
    SUB  X27, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X21, #0x81ff, LSL #0
    MOVK  X21, #0x81ff, LSL #16
    SUB  X27, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0x3, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X27, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X21, #0x7e00, LSL #0
    MOVK  X21, #0x7e00, LSL #16
    SUB  X27, X21, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
    MOVZ  X21, #0x4400, LSL #0
    MOVK  X21, #0x200d, LSL #16
    SUB  X27, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTIntAlu_TestFail
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
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    MOVZ  X15, #0xa, LSL #0
TSRTIntAlu_label_13:
    ANDS  X2, X21, #0xfffff803fffff803
    TST  X2, #0x7ff07ff07ff07ff0
    RBIT  W8, W11
    NEGS  W4, W23, LSL #22
    SUBS  X13, X11, X27, LSL #28
    MSUB  X27, X20, X15, X4
    ORR  X2, X27, X13, LSL #15
    EOR  W14, W14, W8, ASR #9
    MVN  W23, W22, LSL #8
    ASR  W11, W2, W22
    ANDS  X2, X12, #0x1c0000001c000000
    ADDS  W10, W9, W23, LSL #11
    EOR  X4, X10, #0xfc000003ffffffff
    MADD  W20, W11, W2, W4
    CSNEG  W4, W18, W15, EQ
    BFXIL  X10, X7, #0x33, #4
    BFM  X12, X14, #0x13, #0x1a
    SUBS  X14, X5, #0xda6, LSL #12
    TST  W17, #0x6
    CLZ  W10, W9
    ORN  X2, X13, X5, LSR #47
    MADD  W22, W18, W15, W21
    UDIV  X17, X12, X20
    ADD  W20, W21, #0xcef
    CSNEG  W8, W7, W5, EQ
    ROR  X12, X8, X3
    SMADDL  X10, W16, W16, X21
    ADC  W23, W11, W4
    SDIV  W3, W12, W14
    ROR  W27, W10, W20
    RBIT  X12, X5
    ORR  X21, X11, #0x1ffc0
    TST  X17, X8, LSR #57
    MVN  W5, W12, ASR #11
    ADDS  X11, X21, #0x7f4, LSL #12
    SXTB  W8, W11
    SBFIZ  W11, W7, #27, #2
    AND  X12, X22, #0xfffe001ffffe001f
    ORR  X18, X23, #0xf00000000
    RBIT  X10, X12
    BICS  W12, W3, W9, ASR #22
    BFI  W5, W11, #27, #5
    MNEG  X7, X22, X3
    SBFM  W11, W18, #0x17, #0x12
    SBFX  W21, W27, #0x10, #7
    ORN  X7, X7, X21, LSL #37
    REV32  X23, X10
    MSUB  W27, W18, W23, W20
    ADD  W9, W5, #0x445
    UBFX  X13, X11, #0x14, #43
    ADD  W18, W15, #0x928
    BICS  X11, X7, X17, ASR #30
    TST  X27, X16, LSR #11
    SBC  W3, W22, W9
    SBC  W17, W3, W18
    UBFIZ  X7, X18, #7, #31
    ORR  W12, W7, W5, ASR #23
    BICS  W10, W13, W16, LSL #3
    REV  X9, X11
    SMADDL  X5, W15, W9, X17
    CSINV  X23, X10, X8, MI
    SMNEGL  X11, W12, W12
    ORR  X21, X11, #0x7f7f7f7f7f7f7f7f
    MADD  W20, W20, W23, W21
    ANDS  X9, X3, #0xfffff8000000001f
    ROR  X11, X3, X12
    ROR  X13, X7, X9
    ADDS  W7, W21, W20, SXTX #1
    SXTH  X23, W9
    TST  X18, X5, LSL #36
    AND  X27, X23, X17, ROR #0
    UXTB  W18, W9
    ANDS  X4, X3, X16, ASR #37
    AND  X20, X20, X12, LSL #13
    REV  X14, X9
    NEGS  W9, W15, LSR #27
    EON  X17, X21, X11, LSR #39
    ADD  W10, W20, W27, UXTX #4
    ORR  X16, X4, #0xfffffffff1ffffff
    UBFIZ  W9, W16, #7, #16
    MADD  X11, X7, X14, X2
    MUL  X16, X22, X11
    ADDS  W14, W11, #0x42c, LSL #12
    AND  W4, W17, #0xffbfffbf
    ADD  X8, X17, X16, ASR #62
    EOR  X11, X8, #0x6060606060606060
    REV16  W16, W14
    ASR  W14, W9, W16
    CSINC  X18, X4, X14, LE
    CSINV  W22, W14, W18, GT
    TST  X11, #0x1ffffffffc000000
    REV  W2, W22
    MVN  W7, W3, ASR #11
    CLS  W16, W7
    ORN  X3, X20, X10, ROR #51
    SXTB  W11, W17
    ORR  W20, W13, #0x3ffe3ffe
    BFM  X17, X5, #0x21, #0xf
    REV  X14, X2
    NEGS  X5, X14, LSL #10
    SXTH  W3, W3
    UBFIZ  X4, X8, #62, #1
    SUB  X13, X4, X16, LSR #24
    UXTH  W21, W3
    CSINC  W14, W20, W5, HI
    CSNEG  W11, W22, W5, NE
    SUBS  X2, X11, W4, SXTH #0
    REV32  X8, X8
    NGC  W20, W8
    ASR  W4, W18, #0x19
    NEGS  W18, W4, ASR #25
    ROR  W8, W2, #0x1d
    ASRV  W11, W9, W16
    UBFX  W10, W13, #0x9, #15
    ORN  X18, X9, X21, LSR #56
    ADD  W18, W17, W18, SXTH #3
    ROR  W2, W12, #0x15
    NEG  W3, W18, LSR #10
    UDIV  X16, X20, X11
    ADCS  X7, X27, X14
    SBFX  X18, X16, #0x3d, #1
    BFM  X4, X18, #0x6, #0xe
    ORN  X17, X2, X7, LSR #49
    BFM  W20, W10, #0x5, #0xb
    ADCS  W16, W18, W8
    ADDS  W11, W4, W8, SXTW #3
    NGC  X10, X3
    SBC  W14, W21, W7
    SBCS  W8, W2, W2
    SMNEGL  X10, W7, W23
    MUL  X7, X8, X10
    REV16  X4, X14
    EXTR  X13, X21, X17, #0x2
    SUB  W9, W4, W11, UXTB #3
    UMULH  X2, X16, X7
    BIC  X27, X20, X9, ROR #4
    SBC  X12, X23, X9
    SMULH  X11, X12, X12
    ORR  W3, W2, W10, ASR #5
    RBIT  X22, X27
    EOR  X7, X3, #0xfffffffffc00007f
    SBFM  X11, X18, #0xa, #0x6
    ADD  W27, W11, #0xc47
    CSNEG  W23, W4, W7, AL
    UBFM  X12, X4, #0x9, #0x32
    ADC  X14, X10, X14
    ADDS  X18, X13, X5, LSR #5
    ASRV  W9, W7, W18
    CSEL  X5, X8, X27, GE
    NEG  W3, W10, LSR #5
    AND  X18, X23, X3, ROR #51
    ORN  W22, W9, W14, LSL #13
    BFXIL  X27, X14, #0x24, #23
    ADD  W9, W9, W18, SXTW #3
    BIC  W17, W9, W14, ROR #21
    RORV  W10, W12, W17
    TST  X22, X21, LSL #56
    ASRV  X8, X8, X8
    ASRV  X2, X7, X5
    NEG  X23, X27, LSL #50
    SBFM  W18, W8, #0x7, #0xe
    SMNEGL  X16, W21, W2
    SUB  W21, W17, W18, SXTB #3
    SBCS  W9, W10, W22
    ANDS  X2, X23, X21, ROR #42
    ASRV  W20, W2, W2
    BICS  X13, X21, X18, ROR #5
    CSNEG  W12, W13, W4, MI
    REV  W23, W2
    ADDS  X18, X9, X12, ASR #38
    SUBS  X7, X20, W16, SXTW #2
    MSUB  W2, W2, W10, W18
    ADDS  X10, X23, W27, UXTW #2
    ASR  W27, W2, #0xf
    BICS  X7, X2, X21, ROR #31
    NEG  X21, X13, LSL #25
    SDIV  X4, X7, X27
    UDIV  W17, W4, W10
    ADD  W7, W22, W2, SXTH #0
    REV16  X20, X11
    SUB  W14, W20, W23, UXTW #3
    REV  W12, W21
    AND  W27, W20, W27, ROR #1
    SUB  W11, W13, W20, ASR #0
    BFI  X21, X7, #22, #23
    ADCS  X13, X23, X23
    SUBS  W2, W18, W21, LSR #2
    TST  X23, X16, LSL #8
    ANDS  X9, X7, #0x3fff00000000000
    ORR  X13, X5, X22, LSL #2
    ADDS  W20, W14, W14, UXTW #2
    SMADDL  X7, W12, W11, X27
    BFM  W21, W2, #0x1f, #0x7
    ORR  X18, X7, X20, ASR #36
    TST  X17, #0x7ffc00000
    MUL  W5, W13, W9
    ADD  W27, W15, #0xfb3
    REV16  X10, X21
    RORV  W20, W27, W14
    MUL  W9, W10, W3
    SUBS  X15, X15, #0x1
    B.NE  TSRTIntAlu_label_13
    MOVZ  X19, #0xc07b, LSL #0
    MOVK  X19, #0x184a, LSL #16
    SUB  X6, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X19, #0x6, LSL #0
    MOVK  X19, #0xf800, LSL #16
    SUB  X6, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X19, #0x8001, LSL #0
    SUB  X6, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X19, #0xc400, LSL #0
    MOVK  X19, #0xb9, LSL #16
    SUB  X6, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X19, #0xf600, LSL #0
    MOVK  X19, #0x801e, LSL #16
    SUB  X6, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x4, LSL #16
    SUB  X6, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0x8054, LSL #16
    MOVK  X19, #0x3, LSL #32
    SUB  X6, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xfe08, LSL #16
    MOVK  X19, #0x1f7, LSL #32
    SUB  X6, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X19, #0xfb4, LSL #0
    SUB  X6, X19, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X19, #0xf6, LSL #0
    MOVK  X19, #0x1e80, LSL #16
    SUB  X6, X19, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X19, #0x3fff, LSL #0
    MOVK  X19, #0xe015, LSL #16
    SUB  X6, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
    MOVZ  X19, #0xfb4, LSL #0
    SUB  X6, X19, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTIntAlu_TestFail
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
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    MOVZ  X11, #0xa, LSL #0
TSRTIntAlu_label_14:
    ADDS  X7, X13, #0x909
    MUL  X15, X17, X7
    CLS  W7, W14
    SMULH  X5, X13, X7
    ADCS  W8, W23, W22
    BFXIL  W6, W13, #0x6, #26
    SUBS  W9, W17, #0xcf8, LSL #12
    EXTR  X23, X15, X3, #0x2f
    UMADDL  X4, W27, W5, X19
    ADD  X13, X27, X9, LSL #23
    NGC  X12, X11
    CSINC  X4, X6, X16, GE
    ORR  W12, W5, W20, ROR #12
    ADDS  X9, X8, #0x388
    ANDS  W27, W13, #0xff00ff0
    CSEL  W17, W27, W23, LS
    ADDS  X18, X6, X12, LSR #34
    CSEL  W23, W4, W4, LT
    BICS  X13, X13, X18, ASR #12
    ROR  X16, X22, #0x1b
    SBFX  W10, W9, #0x1, #26
    ORR  W7, W10, W17, LSR #22
    SUB  X3, X13, X13, ASR #35
    ADDS  W3, W18, #0xdd3, LSL #12
    CSEL  X4, X23, X14, LS
    REV16  X20, X5
    BICS  W12, W16, W20, ROR #24
    CSINC  X20, X12, X6, GT
    BFI  X15, X4, #63, #1
    SUB  W6, W3, #0x6a0
    BFM  X17, X15, #0x24, #0x1c
    BIC  X27, X17, X11, LSR #15
    ASR  X13, X14, #0x1f
    ORR  X5, X6, X13, ASR #49
    CLZ  X19, X5
    UXTB  W6, W7
    ORN  X13, X6, X3, ROR #11
    SBC  X15, X14, X27
    EOR  X8, X20, #0x3ff000003ff0000
    UXTH  W22, W8
    SXTW  X4, W15
    CSINV  W15, W13, W19, LE
    TST  W14, #0xfffe003f
    TST  W15, #0x3ff8000
    UBFX  X12, X4, #0x20, #3
    ASR  X3, X8, X15
    UBFM  W23, W15, #0xd, #0x15
    ADDS  W27, W9, W7, SXTH #0
    ADDS  W20, W8, #0xe59
    SBFX  W15, W12, #0x1c, #3
    NGCS  X14, X3
    EON  W9, W10, W8, ASR #12
    SXTB  W10, W18
    ANDS  X12, X4, #0x3838383838383838
    SXTB  W5, W14
    CLZ  W18, W5
    EOR  W17, W20, #0x1fffffc0
    EON  W20, W17, W27, LSR #11
    BFM  X13, X20, #0x25, #0xe
    ADCS  W19, W3, W23
    UXTB  W10, W22
    REV32  X5, X18
    CSINV  W13, W20, W13, GE
    ROR  X7, X23, X12
    EON  W6, W7, W10, ASR #11
    SXTW  X12, W19
    RORV  W9, W18, W12
    ADDS  X12, X15, X23, LSR #3
    TST  X12, #0x7ffffffffffffffc
    TST  X10, #0x3ffffffc3ffffffc
    ROR  X19, X8, X9
    ADD  W8, W5, W20, LSL #1
    SBFX  X3, X14, #0x3c, #1
    ASRV  X10, X8, X4
    NGC  X8, X7
    MNEG  W7, W8, W14
    EOR  X17, X10, #0xffffffff8000000
    UBFX  X10, X23, #0xa, #37
    UBFIZ  X15, X6, #3, #50
    SBCS  W3, W3, W7
    SDIV  X4, X19, X14
    ADD  X3, X4, X7, UXTX #3
    EON  W7, W17, W15, LSL #25
    ANDS  W15, W7, #0xffff0
    UXTB  W6, W13
    ASR  X13, X15, X7
    SXTH  W20, W15
    SBFM  W9, W6, #0x1e, #0x17
    SBFM  W5, W19, #0xe, #0x17
    CSINV  X23, X14, X13, EQ
    ADD  X7, X19, W10, SXTW #2
    BIC  X20, X11, X12, ASR #14
    ORR  X17, X15, #0x1fffff801fffff80
    SMNEGL  X4, W20, W9
    ADDS  X8, X20, X27, ASR #10
    EOR  W6, W23, W19, ROR #2
    SMULL  X10, W13, W27
    ASRV  X12, X6, X19
    SUBS  W19, W23, #0x2a2, LSL #12
    BIC  X8, X4, X12, ASR #27
    EOR  W15, W22, W8, ROR #21
    EOR  X15, X10, X20, ASR #12
    SUBS  X3, X15, #0x207, LSL #12
    REV16  W6, W3
    ROR  W15, W6, W9
    CSEL  W8, W12, W16, GE
    ADDS  W16, W15, W22, LSR #24
    ORN  W23, W12, W12, ROR #2
    SBFIZ  X15, X9, #25, #23
    ADDS  X9, X7, W13, SXTB #3
    REV16  W20, W8
    ADC  W14, W4, W23
    MSUB  X3, X19, X23, X19
    SDIV  X7, X15, X16
    AND  X27, X14, X3, ASR #50
    EON  W10, W20, W14, ROR #15
    AND  W27, W27, W9, ROR #26
    SBC  W20, W19, W22
    SBC  X13, X14, X12
    ADDS  X9, X17, X13, LSL #1
    EOR  X16, X20, X16, LSL #44
    SXTB  X15, W20
    EON  W8, W27, W9, LSL #20
    MADD  X23, X3, X15, X22
    CSEL  W14, W7, W23, MI
    MADD  X6, X20, X3, X14
    SBFX  W20, W8, #0x13, #9
    ADC  W3, W9, W16
    BICS  X15, X18, X20, LSL #62
    ROR  X23, X17, #0xe
    SUBS  W17, W23, W18, UXTX #2
    REV  X22, X3
    SUB  X17, X15, #0x44f, LSL #12
    SBFM  X27, X22, #0x19, #0x24
    SUB  X16, X10, X7, LSL #12
    AND  X4, X27, #0x7ff
    SUB  W7, W11, #0x94
    ANDS  W19, W13, W4, LSR #21
    ANDS  W9, W18, W17, LSR #14
    BFXIL  W22, W16, #0x14, #9
    UBFM  X14, X6, #0x32, #0x2a
    CSINC  X16, X19, X23, NE
    CSINV  X27, X16, X16, EQ
    ASR  X20, X27, X23
    EOR  X23, X22, #0x801f801f801f801f
    RORV  W16, W14, W17
    UXTB  W15, W10
    CSINC  X22, X3, X20, LT
    CSNEG  W7, W22, W20, AL
    CLZ  X13, X11
    REV16  W10, W20
    UMADDL  X27, W16, W7, X7
    UMULL  X19, W9, W9
    SBFM  W22, W27, #0x1d, #0x1d
    ADDS  X18, X15, #0xe01
    MUL  W22, W18, W13
    ROR  W7, W23, #0xa
    SMSUBL  X9, W6, W19, X10
    ROR  X18, X9, X4
    RORV  X6, X7, X18
    SUB  X19, X19, X15, ASR #19
    SBFX  X18, X15, #0x33, #12
    SXTB  W4, W7
    SBFM  X20, X17, #0xa, #0x38
    SUBS  W15, W15, #0xb17, LSL #12
    RORV  X7, X22, X9
    SUBS  W27, W7, W22, ASR #5
    UMSUBL  X10, W8, W10, X8
    ORN  W17, W3, W5, LSR #11
    ROR  W3, W9, #0x7
    ADD  X22, X15, #0x776
    SMULH  X9, X4, X17
    SBC  X16, X5, X9
    BFI  W27, W6, #5, #8
    CLS  X8, X27
    AND  X3, X16, X20, LSR #25
    MSUB  W27, W7, W19, W18
    SBCS  W7, W22, W22
    SXTB  X16, W7
    RBIT  W6, W8
    EOR  X10, X19, X4, LSR #8
    SUB  W13, W20, #0x2eb, LSL #12
    ASR  W19, W27, #0x7
    MNEG  W17, W3, W4
    SUB  W23, W13, W8, LSL #7
    ADC  X19, X5, X6
    MADD  W7, W10, W19, W16
    NEG  W6, W18, ASR #5
    ADDS  X13, X15, #0xe70, LSL #12
    ADD  X8, X7, X7, LSL #25
    SXTB  X10, W13
    ASR  W27, W8, #0x16
    NGCS  X22, X10
    AND  W20, W27, W6, ROR #2
    EON  X16, X23, X23, LSR #50
    UMULL  X27, W22, W13
    BFXIL  W9, W27, #0x4, #14
    TST  W17, #0xc1ffc1ff
    ANDS  X27, X20, X20, LSL #34
    SXTW  X19, W16
    SUBS  X11, X11, #0x1
    B.NE  TSRTIntAlu_label_14
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X2, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntAlu_TestFail
    MOVZ  X21, #0xffe0, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X2, X21, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntAlu_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X2, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xcc00, LSL #16
    SUB  X2, X21, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xcc00, LSL #16
    MOVK  X21, #0x198, LSL #48
    SUB  X2, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntAlu_TestFail
    MOVZ  X21, #0x3f04, LSL #0
    SUB  X2, X21, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntAlu_TestFail
    MOVZ  X21, #0x3f, LSL #0
    SUB  X2, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntAlu_TestFail
    MOVZ  X21, #0x537, LSL #0
    MOVK  X21, #0x5f80, LSL #16
    SUB  X2, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntAlu_TestFail
    MOVZ  X21, #0x903f, LSL #0
    MOVK  X21, #0x35, LSL #16
    MOVK  X21, #0x1, LSL #32
    SUB  X2, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntAlu_TestFail
    MOVZ  X21, #0x4000, LSL #0
    MOVK  X21, #0xe63f, LSL #16
    MOVK  X21, #0xb676, LSL #32
    MOVK  X21, #0xb6, LSL #48
    SUB  X2, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntAlu_TestFail
    MOVZ  X21, #0x903f, LSL #0
    MOVK  X21, #0xff4e, LSL #16
    SUB  X2, X21, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntAlu_TestFail
    MOVZ  X21, #0xd73b, LSL #0
    MOVK  X21, #0x2e, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X2, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntAlu_TestFail
    MOVZ  X21, #0xffe0, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X2, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntAlu_TestFail
    MOVZ  X21, #0xd73b, LSL #0
    MOVK  X21, #0x2e, LSL #16
    SUB  X2, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntAlu_TestFail
    MOVZ  X21, #0xffc0, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X2, X21, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntAlu_TestFail
    MOVZ  X21, #0x28c4, LSL #0
    MOVK  X21, #0xffd1, LSL #16
    SUB  X2, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntAlu_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTIntAlu_TestFail

TSRTIntAlu_TestEnd:
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
TSRTIntAlu_TestFail:
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
