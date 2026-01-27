.global TaishanSimdUnaryArithmeticP01

.text
.p2align 4

TaishanSimdUnaryArithmeticP01:

TaishanSimdUnaryArithmeticP01_TestBegin:
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
    STP  Q0, Q1, [SP, #-32]!
    STP  Q2, Q3, [SP, #-32]!
    STP  Q4, Q5, [SP, #-32]!
    STP  Q6, Q7, [SP, #-32]!
    STP  Q8, Q9, [SP, #-32]!
    STP  Q10, Q11, [SP, #-32]!
    STP  Q12, Q13, [SP, #-32]!
    STP  Q14, Q15, [SP, #-32]!
    STP  Q16, Q17, [SP, #-32]!
    STP  Q18, Q19, [SP, #-32]!
    STP  Q20, Q21, [SP, #-32]!
    STP  Q22, Q23, [SP, #-32]!
    STP  Q24, Q25, [SP, #-32]!
    STP  Q26, Q27, [SP, #-32]!
    STP  Q28, Q29, [SP, #-32]!
    STP  Q30, Q31, [SP, #-32]!
    MRS  X2, FPCR
    MRS  X3, FPSR
    STP  X2, X3, [SP, #-16]!
    MRS  X1, NZCV
    STP  X1, X2, [SP, #-16]!
    MOVZ  X1, #0x0, LSL #0
    MOVK  X2, #0x7c73, LSL #48
    MOVK  X2, #0xb958, LSL #32
    MOVK  X2, #0xa167, LSL #16
    MOVK  X2, #0x5fd6, LSL #0
    MOVK  X3, #0x32e8, LSL #48
    MOVK  X3, #0x7b36, LSL #32
    MOVK  X3, #0x8864, LSL #16
    MOVK  X3, #0x6b59, LSL #0
    MOVK  X4, #0x200f, LSL #48
    MOVK  X4, #0x33ad, LSL #32
    MOVK  X4, #0x7354, LSL #16
    MOVK  X4, #0xa633, LSL #0
    MOVK  X5, #0x7cae, LSL #48
    MOVK  X5, #0xadd1, LSL #32
    MOVK  X5, #0x5c6d, LSL #16
    MOVK  X5, #0xa2f4, LSL #0
    MOVK  X6, #0x2653, LSL #48
    MOVK  X6, #0x3f23, LSL #32
    MOVK  X6, #0x2a81, LSL #16
    MOVK  X6, #0x59dd, LSL #0
    MOVK  X7, #0x49dc, LSL #48
    MOVK  X7, #0x8dde, LSL #32
    MOVK  X7, #0x9f13, LSL #16
    MOVK  X7, #0x26fb, LSL #0
    MOVK  X8, #0x4b74, LSL #48
    MOVK  X8, #0xfbcb, LSL #32
    MOVK  X8, #0x69d1, LSL #16
    MOVK  X8, #0xa9de, LSL #0
    MOVK  X9, #0xeb03, LSL #48
    MOVK  X9, #0x91e9, LSL #32
    MOVK  X9, #0x713, LSL #16
    MOVK  X9, #0xd786, LSL #0
    MOVK  X10, #0x6bcb, LSL #48
    MOVK  X10, #0xfb35, LSL #32
    MOVK  X10, #0x72b6, LSL #16
    MOVK  X10, #0x14a5, LSL #0
    MOVK  X11, #0x4521, LSL #48
    MOVK  X11, #0xcabf, LSL #32
    MOVK  X11, #0xb1dc, LSL #16
    MOVK  X11, #0x8e41, LSL #0
    MOVK  X12, #0xd8e6, LSL #48
    MOVK  X12, #0xe4ad, LSL #32
    MOVK  X12, #0x4d91, LSL #16
    MOVK  X12, #0xec13, LSL #0
    MOVK  X13, #0x659e, LSL #48
    MOVK  X13, #0xd104, LSL #32
    MOVK  X13, #0x7266, LSL #16
    MOVK  X13, #0x978f, LSL #0
    MOVK  X14, #0x971d, LSL #48
    MOVK  X14, #0xf3b1, LSL #32
    MOVK  X14, #0x9ed5, LSL #16
    MOVK  X14, #0x1749, LSL #0
    MOVK  X15, #0x1cb7, LSL #48
    MOVK  X15, #0xb662, LSL #32
    MOVK  X15, #0xfc51, LSL #16
    MOVK  X15, #0x82cf, LSL #0
    MOVK  X16, #0xca85, LSL #48
    MOVK  X16, #0x43a2, LSL #32
    MOVK  X16, #0xb9f0, LSL #16
    MOVK  X16, #0x47ad, LSL #0
    MOVK  X17, #0x4be3, LSL #48
    MOVK  X17, #0xf5bf, LSL #32
    MOVK  X17, #0xb557, LSL #16
    MOVK  X17, #0xec06, LSL #0
    MOVK  X18, #0xc087, LSL #48
    MOVK  X18, #0xd54, LSL #32
    MOVK  X18, #0xeab8, LSL #16
    MOVK  X18, #0xcf58, LSL #0
    MOVK  X19, #0x739a, LSL #48
    MOVK  X19, #0x941d, LSL #32
    MOVK  X19, #0x47c2, LSL #16
    MOVK  X19, #0xcc4b, LSL #0
    MOVK  X20, #0xf75a, LSL #48
    MOVK  X20, #0x72dc, LSL #32
    MOVK  X20, #0x976e, LSL #16
    MOVK  X20, #0xec91, LSL #0
    MOVK  X21, #0x733b, LSL #48
    MOVK  X21, #0x5a80, LSL #32
    MOVK  X21, #0x2415, LSL #16
    MOVK  X21, #0xd08d, LSL #0
    MOVK  X23, #0x2280, LSL #48
    MOVK  X23, #0xc0e8, LSL #32
    MOVK  X23, #0x391a, LSL #16
    MOVK  X23, #0xbc80, LSL #0
    MOVK  X24, #0xb93, LSL #48
    MOVK  X24, #0x6377, LSL #32
    MOVK  X24, #0x997d, LSL #16
    MOVK  X24, #0x6f8e, LSL #0
    MOVK  X25, #0x6ec2, LSL #48
    MOVK  X25, #0x120b, LSL #32
    MOVK  X25, #0x7bce, LSL #16
    MOVK  X25, #0xa07c, LSL #0
    MOVK  X26, #0x60ae, LSL #48
    MOVK  X26, #0x5798, LSL #32
    MOVK  X26, #0x1412, LSL #16
    MOVK  X26, #0xcb5e, LSL #0
    MOVK  X27, #0xf0f4, LSL #48
    MOVK  X27, #0xfda4, LSL #32
    MOVK  X27, #0x5892, LSL #16
    MOVK  X27, #0xf967, LSL #0
    MOVK  X28, #0x2459, LSL #48
    MOVK  X28, #0xeceb, LSL #32
    MOVK  X28, #0x7f29, LSL #16
    MOVK  X28, #0xfaa2, LSL #0
    MOVK  X29, #0xd6c5, LSL #48
    MOVK  X29, #0x3ac6, LSL #32
    MOVK  X29, #0xa974, LSL #16
    MOVK  X29, #0xe9a1, LSL #0
    ADDS  X2, X6, X27, ASR #5
    MOVZ  X7, #0xb1a6, LSL #0
    MOVK  X7, #0x9881, LSL #16
    MSR  FPCR, X7
    MRS  X9, FPSR
    MOVZ  X15, #0xff60, LSL #0
    MOVK  X15, #0x7ff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    AND  X9, X9, X15
    MOVZ  X15, #0x0, LSL #0
    ORR  X9, X9, X15
    MSR  FPSR, X9
    ISB  SY
    MOVZ  X2, #0x1969, LSL #0
    MOVK  X2, #0x4cfe, LSL #16
    MOVK  X2, #0xa006, LSL #32
    MOVK  X2, #0x3bae, LSL #48
    MOVZ  X3, #0xcd5a, LSL #0
    MOVK  X3, #0xbfb2, LSL #16
    MOVK  X3, #0xb2da, LSL #32
    MOVK  X3, #0x3363, LSL #48
    MOVZ  X4, #0xa82d, LSL #0
    MOVK  X4, #0x2b34, LSL #16
    MOVK  X4, #0xe4ce, LSL #32
    MOVK  X4, #0x4530, LSL #48
    MOVZ  X5, #0x476f, LSL #0
    MOVK  X5, #0xc3ce, LSL #16
    MOVK  X5, #0x15c, LSL #32
    MOVK  X5, #0x5b4e, LSL #48
    MOVZ  X6, #0xd99f, LSL #0
    MOVK  X6, #0xa962, LSL #16
    MOVK  X6, #0x7b02, LSL #32
    MOVK  X6, #0x8661, LSL #48
    MOVZ  X7, #0xf5a3, LSL #0
    MOVK  X7, #0xb61a, LSL #16
    MOVK  X7, #0xcf9, LSL #32
    MOVK  X7, #0x65ab, LSL #48
    MOVZ  X8, #0x7965, LSL #0
    MOVK  X8, #0xd529, LSL #16
    MOVK  X8, #0xf503, LSL #32
    MOVK  X8, #0xb5be, LSL #48
    MOVZ  X9, #0x10c1, LSL #0
    MOVK  X9, #0x8410, LSL #16
    MOVK  X9, #0xf22d, LSL #32
    MOVK  X9, #0x9021, LSL #48
    MOVZ  X10, #0x3940, LSL #0
    MOVK  X10, #0xb7c0, LSL #16
    MOVK  X10, #0x389e, LSL #32
    MOVK  X10, #0x3351, LSL #48
    MOVZ  X11, #0x2e71, LSL #0
    MOVK  X11, #0xaf48, LSL #16
    MOVK  X11, #0xcfc4, LSL #32
    MOVK  X11, #0x754b, LSL #48
    MOVZ  X12, #0x90c0, LSL #0
    MOVK  X12, #0x1e34, LSL #16
    MOVK  X12, #0x9634, LSL #32
    MOVK  X12, #0xe444, LSL #48
    MOVZ  X13, #0x381, LSL #0
    MOVK  X13, #0xd102, LSL #16
    MOVK  X13, #0xcb71, LSL #32
    MOVK  X13, #0xa6c7, LSL #48
    MOVZ  X14, #0xd8e8, LSL #0
    MOVK  X14, #0x10ca, LSL #16
    MOVK  X14, #0xde1c, LSL #32
    MOVK  X14, #0xe370, LSL #48
    MOVZ  X15, #0x4cbc, LSL #0
    MOVK  X15, #0xff2e, LSL #16
    MOVK  X15, #0x20b, LSL #32
    MOVK  X15, #0x5061, LSL #48
    MOVZ  X16, #0xbebb, LSL #0
    MOVK  X16, #0xfbbf, LSL #16
    MOVK  X16, #0x87fb, LSL #32
    MOVK  X16, #0x7550, LSL #48
    MOVZ  X17, #0xdf58, LSL #0
    MOVK  X17, #0x5c22, LSL #16
    MOVK  X17, #0xde2c, LSL #32
    MOVK  X17, #0x6b98, LSL #48
    MOVZ  X18, #0x6461, LSL #0
    MOVK  X18, #0x326a, LSL #16
    MOVK  X18, #0xa01a, LSL #32
    MOVK  X18, #0x5771, LSL #48
    MOVZ  X19, #0x1758, LSL #0
    MOVK  X19, #0xc947, LSL #16
    MOVK  X19, #0x754d, LSL #32
    MOVK  X19, #0xa782, LSL #48
    MOVZ  X20, #0x16da, LSL #0
    MOVK  X20, #0xd70c, LSL #16
    MOVK  X20, #0x4372, LSL #32
    MOVK  X20, #0x1d16, LSL #48
    MOVZ  X21, #0x2f, LSL #0
    MOVK  X21, #0x963c, LSL #16
    MOVK  X21, #0x3e6, LSL #32
    MOVK  X21, #0x292b, LSL #48
    MOVZ  X23, #0x2aae, LSL #0
    MOVK  X23, #0xbebc, LSL #16
    MOVK  X23, #0xede2, LSL #32
    MOVK  X23, #0x88c0, LSL #48
    MOVZ  X24, #0x57e0, LSL #0
    MOVK  X24, #0x7481, LSL #16
    MOVK  X24, #0xe85c, LSL #32
    MOVK  X24, #0x2313, LSL #48
    MOVZ  X25, #0xe9a, LSL #0
    MOVK  X25, #0xd6f0, LSL #16
    MOVK  X25, #0x50aa, LSL #32
    MOVK  X25, #0x1389, LSL #48
    MOVZ  X26, #0xf330, LSL #0
    MOVK  X26, #0x41fe, LSL #16
    MOVK  X26, #0xf1fa, LSL #32
    MOVK  X26, #0xf657, LSL #48
    MOVZ  X27, #0x2fd3, LSL #0
    MOVK  X27, #0x7aed, LSL #16
    MOVK  X27, #0x8b66, LSL #32
    MOVK  X27, #0x1fcd, LSL #48
    MOVZ  X28, #0x6fa, LSL #0
    MOVK  X28, #0xc134, LSL #16
    MOVK  X28, #0xde70, LSL #32
    MOVK  X28, #0xf464, LSL #48
    MOVZ  X29, #0x42cb, LSL #0
    MOVK  X29, #0x8046, LSL #16
    MOVK  X29, #0x15f4, LSL #32
    MOVK  X29, #0x1dd0, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X28
    FMOV  D1, X9
    FMOV  V1.D[1], X20
    FMOV  D2, X12
    FMOV  V2.D[1], X29
    FMOV  D3, X24
    FMOV  V3.D[1], X19
    FMOV  D4, X27
    FMOV  V4.D[1], X13
    FMOV  D5, X20
    FMOV  V5.D[1], X26
    FMOV  D6, X12
    FMOV  V6.D[1], X21
    FMOV  D7, X28
    FMOV  V7.D[1], X11
    FMOV  D8, X11
    FMOV  V8.D[1], X20
    FMOV  D9, X14
    FMOV  V9.D[1], X20
    FMOV  D10, X20
    FMOV  V10.D[1], X19
    FMOV  D11, X25
    FMOV  V11.D[1], X2
    FMOV  D12, X9
    FMOV  V12.D[1], X27
    FMOV  D13, X24
    FMOV  V13.D[1], X26
    FMOV  D14, X7
    FMOV  V14.D[1], X20
    FMOV  D15, X28
    FMOV  V15.D[1], X7
    FMOV  D16, X2
    FMOV  V16.D[1], X13
    FMOV  D17, X10
    FMOV  V17.D[1], X21
    FMOV  D18, X7
    FMOV  V18.D[1], X3
    FMOV  D19, X15
    FMOV  V19.D[1], X28
    FMOV  D20, X23
    FMOV  V20.D[1], X11
    FMOV  D21, X29
    FMOV  V21.D[1], X15
    FMOV  D22, X13
    FMOV  V22.D[1], X5
    FMOV  D23, X3
    FMOV  V23.D[1], X18
    FMOV  D24, X2
    FMOV  V24.D[1], X11
    FMOV  D25, X3
    FMOV  V25.D[1], X3
    FMOV  D26, X17
    FMOV  V26.D[1], X6
    FMOV  D27, X27
    FMOV  V27.D[1], X26
    FMOV  D28, X19
    FMOV  V28.D[1], X24
    FMOV  D29, X25
    FMOV  V29.D[1], X26
    FMOV  D30, X3
    FMOV  V30.D[1], X29
    FMOV  D31, X7
    FMOV  V31.D[1], X18
    MOVZ  X13, #0xa, LSL #0
TaishanSimdUnaryArithmeticP01_label_0:
    AESE  V30.16B, V27.16B
    SHA256SU1  V12.4S, V4.4S, V13.4S
    AESMC  V14.16B, V24.16B
    SHA1H  S24, S28
    AESD  V19.16B, V29.16B
    SHA1M  Q31, S11, V28.4S
    SHA256SU1  V23.4S, V24.4S, V9.4S
    SHA256SU1  V17.4S, V24.4S, V22.4S
    AESE  V10.16B, V12.16B
    AESE  V4.16B, V15.16B
    AESIMC  V1.16B, V26.16B
    SHA1H  S27, S22
    SHA1M  Q31, S24, V22.4S
    SHA1M  Q21, S21, V12.4S
    SHA1SU0  V18.4S, V25.4S, V26.4S
    AESMC  V14.16B, V31.16B
    SHA1SU1  V14.4S, V16.4S
    SHA1M  Q27, S5, V18.4S
    SHA1H  S13, S19
    SHA256H  Q14, Q11, V4.4S
    SHA1H  S17, S10
    SHA256SU1  V11.4S, V16.4S, V3.4S
    AESD  V29.16B, V5.16B
    AESIMC  V7.16B, V30.16B
    AESE  V15.16B, V14.16B
    SHA1H  S23, S16
    SHA1P  Q31, S19, V27.4S
    SHA1SU1  V5.4S, V21.4S
    SHA1SU0  V9.4S, V9.4S, V6.4S
    AESD  V22.16B, V17.16B
    AESD  V18.16B, V21.16B
    AESE  V28.16B, V15.16B
    SHA1SU0  V10.4S, V31.4S, V17.4S
    AESE  V23.16B, V15.16B
    AESD  V20.16B, V22.16B
    SHA256H2  Q4, Q31, V19.4S
    SHA1SU0  V8.4S, V18.4S, V25.4S
    SHA1H  S8, S5
    SHA1M  Q2, S6, V23.4S
    SHA256H2  Q9, Q19, V2.4S
    AESD  V30.16B, V30.16B
    AESE  V8.16B, V26.16B
    SHA1H  S10, S10
    SHA256H2  Q15, Q5, V26.4S
    SHA256SU0  V29.4S, V14.4S
    AESD  V3.16B, V0.16B
    SHA1P  Q4, S16, V22.4S
    SHA1P  Q0, S10, V30.4S
    AESD  V3.16B, V15.16B
    SHA1SU0  V10.4S, V28.4S, V26.4S
    AESIMC  V22.16B, V7.16B
    SHA1SU1  V27.4S, V8.4S
    SHA1M  Q0, S10, V3.4S
    AESMC  V7.16B, V5.16B
    AESD  V25.16B, V8.16B
    AESIMC  V20.16B, V8.16B
    AESIMC  V3.16B, V14.16B
    SHA1M  Q4, S6, V13.4S
    SHA1SU1  V22.4S, V16.4S
    AESD  V9.16B, V25.16B
    AESIMC  V10.16B, V27.16B
    AESIMC  V1.16B, V7.16B
    SHA1H  S22, S15
    SHA256SU0  V0.4S, V16.4S
    SHA1C  Q2, S28, V7.4S
    SHA256SU1  V13.4S, V26.4S, V9.4S
    SHA256H2  Q20, Q4, V30.4S
    SHA256SU0  V21.4S, V27.4S
    AESMC  V25.16B, V30.16B
    SHA1C  Q13, S10, V1.4S
    SHA256H  Q10, Q7, V8.4S
    SHA1SU0  V26.4S, V18.4S, V11.4S
    AESE  V6.16B, V16.16B
    SHA1C  Q0, S15, V11.4S
    SHA1M  Q18, S9, V0.4S
    AESD  V31.16B, V4.16B
    SHA1P  Q31, S13, V4.4S
    SHA256H2  Q28, Q4, V31.4S
    SHA256SU0  V4.4S, V4.4S
    AESMC  V16.16B, V27.16B
    SHA1SU1  V2.4S, V4.4S
    AESMC  V15.16B, V3.16B
    AESD  V2.16B, V28.16B
    SHA1SU0  V4.4S, V24.4S, V28.4S
    SHA1H  S30, S31
    SHA1M  Q13, S4, V4.4S
    AESD  V23.16B, V2.16B
    SHA1P  Q31, S23, V0.4S
    AESIMC  V13.16B, V18.16B
    SHA256H2  Q9, Q10, V8.4S
    SHA1M  Q29, S14, V8.4S
    SHA1M  Q26, S21, V21.4S
    SHA1P  Q1, S28, V25.4S
    SHA1C  Q1, S11, V29.4S
    SHA1M  Q16, S13, V17.4S
    SHA1M  Q16, S26, V23.4S
    SHA1C  Q21, S3, V3.4S
    SHA256H  Q15, Q7, V29.4S
    SHA256H2  Q14, Q17, V8.4S
    SHA256H  Q23, Q25, V5.4S
    AESMC  V19.16B, V21.16B
    SHA1P  Q10, S15, V6.4S
    SHA1SU1  V23.4S, V8.4S
    SHA1SU0  V29.4S, V31.4S, V1.4S
    SHA1SU1  V9.4S, V18.4S
    SHA1C  Q30, S27, V17.4S
    SHA256H2  Q30, Q0, V0.4S
    AESD  V3.16B, V0.16B
    AESE  V3.16B, V1.16B
    SHA1M  Q13, S29, V7.4S
    SHA256H  Q19, Q2, V23.4S
    SHA1P  Q16, S4, V28.4S
    SHA1SU0  V27.4S, V24.4S, V13.4S
    SHA256H  Q1, Q26, V3.4S
    SHA1P  Q31, S19, V16.4S
    SHA1SU0  V26.4S, V23.4S, V6.4S
    AESMC  V5.16B, V3.16B
    SHA1SU0  V10.4S, V10.4S, V21.4S
    SHA1SU0  V7.4S, V27.4S, V0.4S
    SHA1SU1  V0.4S, V9.4S
    SHA1P  Q0, S17, V9.4S
    SHA256H  Q18, Q1, V24.4S
    SHA256SU1  V12.4S, V6.4S, V31.4S
    SHA1SU1  V16.4S, V15.4S
    SHA1C  Q13, S9, V16.4S
    SHA1H  S17, S18
    AESMC  V20.16B, V12.16B
    SHA1C  Q16, S2, V8.4S
    SHA1SU0  V25.4S, V24.4S, V3.4S
    SHA256SU1  V10.4S, V1.4S, V27.4S
    SHA1P  Q14, S19, V19.4S
    AESE  V17.16B, V4.16B
    SHA256SU0  V14.4S, V29.4S
    SHA1SU1  V30.4S, V17.4S
    AESMC  V26.16B, V30.16B
    SHA256H2  Q21, Q13, V3.4S
    SHA1SU1  V6.4S, V4.4S
    SHA1M  Q27, S28, V16.4S
    SHA1P  Q12, S3, V10.4S
    SHA1SU1  V7.4S, V27.4S
    AESIMC  V8.16B, V7.16B
    SHA1M  Q6, S25, V15.4S
    SHA256H  Q18, Q12, V5.4S
    SHA256H2  Q31, Q6, V5.4S
    SHA256SU1  V5.4S, V5.4S, V30.4S
    AESD  V19.16B, V27.16B
    SHA1SU1  V14.4S, V13.4S
    SHA256SU1  V5.4S, V14.4S, V18.4S
    SHA256H2  Q13, Q15, V24.4S
    AESD  V13.16B, V11.16B
    SHA1M  Q23, S25, V29.4S
    SHA256SU0  V17.4S, V27.4S
    SHA1C  Q7, S18, V10.4S
    AESD  V2.16B, V5.16B
    SHA1H  S6, S10
    SHA256H  Q19, Q2, V11.4S
    AESMC  V7.16B, V5.16B
    SHA1H  S31, S7
    SHA256SU1  V10.4S, V24.4S, V13.4S
    SHA1M  Q25, S22, V15.4S
    SHA1M  Q10, S11, V28.4S
    SHA256H  Q8, Q28, V28.4S
    SHA1H  S18, S27
    SHA1SU1  V29.4S, V27.4S
    AESE  V18.16B, V27.16B
    SHA1SU1  V17.4S, V25.4S
    AESD  V15.16B, V0.16B
    SHA1C  Q27, S22, V13.4S
    AESIMC  V14.16B, V31.16B
    SHA256SU0  V11.4S, V27.4S
    SHA1C  Q14, S23, V28.4S
    SHA1SU1  V8.4S, V6.4S
    AESE  V26.16B, V28.16B
    SHA256SU0  V26.4S, V26.4S
    AESD  V28.16B, V1.16B
    SHA256H  Q24, Q23, V26.4S
    SHA1SU1  V18.4S, V5.4S
    AESMC  V20.16B, V27.16B
    AESMC  V29.16B, V2.16B
    AESMC  V19.16B, V23.16B
    AESMC  V31.16B, V18.16B
    AESMC  V13.16B, V28.16B
    SHA256SU1  V31.4S, V4.4S, V11.4S
    SHA256SU0  V14.4S, V24.4S
    AESD  V10.16B, V26.16B
    SHA256H2  Q23, Q21, V6.4S
    SHA1C  Q0, S4, V12.4S
    SHA1M  Q22, S10, V12.4S
    AESMC  V2.16B, V6.16B
    SHA256H2  Q12, Q8, V13.4S
    SHA1C  Q15, S18, V4.4S
    SHA256SU0  V4.4S, V1.4S
    AESD  V26.16B, V19.16B
    SHA1M  Q10, S14, V14.4S
    SHA1H  S21, S14
    AESIMC  V6.16B, V29.16B
    SHA256SU1  V15.4S, V29.4S, V27.4S
    SHA256H2  Q25, Q21, V1.4S
    AESIMC  V8.16B, V1.16B
    SHA1SU0  V12.4S, V29.4S, V10.4S
    SUBS  X13, X13, #0x1
    B.NE  TaishanSimdUnaryArithmeticP01_label_0
    MOVZ  X16, #0x1969, LSL #0
    MOVK  X16, #0x4cfe, LSL #16
    MOVK  X16, #0xa006, LSL #32
    MOVK  X16, #0x3bae, LSL #48
    SUB  X10, X16, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X14, #0xcd5a, LSL #0
    MOVK  X14, #0xbfb2, LSL #16
    MOVK  X14, #0xb2da, LSL #32
    MOVK  X14, #0x3363, LSL #48
    SUB  X8, X14, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X15, #0xa82d, LSL #0
    MOVK  X15, #0x2b34, LSL #16
    MOVK  X15, #0xe4ce, LSL #32
    MOVK  X15, #0x4530, LSL #48
    SUB  X9, X15, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X13, #0x476f, LSL #0
    MOVK  X13, #0xc3ce, LSL #16
    MOVK  X13, #0x15c, LSL #32
    MOVK  X13, #0x5b4e, LSL #48
    SUB  X15, X13, X5
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X24, #0xd99f, LSL #0
    MOVK  X24, #0xa962, LSL #16
    MOVK  X24, #0x7b02, LSL #32
    MOVK  X24, #0x8661, LSL #48
    SUB  X7, X24, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X10
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X26, #0x2e71, LSL #0
    MOVK  X26, #0xaf48, LSL #16
    MOVK  X26, #0xcfc4, LSL #32
    MOVK  X26, #0x754b, LSL #48
    SUB  X18, X26, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X28, #0x476f, LSL #0
    MOVK  X28, #0xc3ce, LSL #16
    MOVK  X28, #0x15c, LSL #32
    MOVK  X28, #0x5b4e, LSL #48
    SUB  X11, X28, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X14, #0xcd5a, LSL #0
    MOVK  X14, #0xbfb2, LSL #16
    MOVK  X14, #0xb2da, LSL #32
    MOVK  X14, #0x3363, LSL #48
    SUB  X5, X14, X14
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X15
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X4, #0x1969, LSL #0
    MOVK  X4, #0x4cfe, LSL #16
    MOVK  X4, #0xa006, LSL #32
    MOVK  X4, #0x3bae, LSL #48
    SUB  X18, X4, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X28, #0xdf58, LSL #0
    MOVK  X28, #0x5c22, LSL #16
    MOVK  X28, #0xde2c, LSL #32
    MOVK  X28, #0x6b98, LSL #48
    SUB  X6, X28, X17
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X18
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X12, #0x1758, LSL #0
    MOVK  X12, #0xc947, LSL #16
    MOVK  X12, #0x754d, LSL #32
    MOVK  X12, #0xa782, LSL #48
    SUB  X8, X12, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X29, #0x16da, LSL #0
    MOVK  X29, #0xd70c, LSL #16
    MOVK  X29, #0x4372, LSL #32
    MOVK  X29, #0x1d16, LSL #48
    SUB  X6, X29, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X19, #0x2aae, LSL #0
    MOVK  X19, #0xbebc, LSL #16
    MOVK  X19, #0xede2, LSL #32
    MOVK  X19, #0x88c0, LSL #48
    SUB  X4, X19, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X19, #0xd99f, LSL #0
    MOVK  X19, #0xa962, LSL #16
    MOVK  X19, #0x7b02, LSL #32
    MOVK  X19, #0x8661, LSL #48
    SUB  X9, X19, X24
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X19, #0xe9a, LSL #0
    MOVK  X19, #0xd6f0, LSL #16
    MOVK  X19, #0x50aa, LSL #32
    MOVK  X19, #0x1389, LSL #48
    SUB  X16, X19, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X23, #0x2e71, LSL #0
    MOVK  X23, #0xaf48, LSL #16
    MOVK  X23, #0xcfc4, LSL #32
    MOVK  X23, #0x754b, LSL #48
    SUB  X18, X23, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X27
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X13, #0xdf58, LSL #0
    MOVK  X13, #0x5c22, LSL #16
    MOVK  X13, #0xde2c, LSL #32
    MOVK  X13, #0x6b98, LSL #48
    SUB  X7, X13, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X9, X21, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, D2
    MOVZ  X27, #0x80ec, LSL #0
    MOVK  X27, #0xa760, LSL #16
    SUB  X18, X27, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X27, #0xc33a, LSL #0
    MOVK  X27, #0x47d4, LSL #16
    MOVK  X27, #0xcc77, LSL #32
    MOVK  X27, #0xa76e, LSL #48
    SUB  X17, X27, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, D3
    MOVZ  X27, #0xf3d1, LSL #0
    MOVK  X27, #0xc0ba, LSL #16
    MOVK  X27, #0x442e, LSL #32
    MOVK  X27, #0x181d, LSL #48
    SUB  X17, X27, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X20, #0x83d4, LSL #0
    MOVK  X20, #0x9e1a, LSL #16
    MOVK  X20, #0x2690, LSL #32
    MOVK  X20, #0x10c3, LSL #48
    SUB  X18, X20, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, D4
    MOVZ  X20, #0x6133, LSL #0
    MOVK  X20, #0x36b3, LSL #16
    MOVK  X20, #0x6f93, LSL #32
    MOVK  X20, #0x4a33, LSL #48
    SUB  X18, X20, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X3, #0x5645, LSL #0
    MOVK  X3, #0x33a6, LSL #16
    MOVK  X3, #0x27f3, LSL #32
    MOVK  X3, #0xa402, LSL #48
    SUB  X20, X3, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, D5
    MOVZ  X3, #0x5a6a, LSL #0
    MOVK  X3, #0x5d0a, LSL #16
    MOVK  X3, #0x9a97, LSL #32
    MOVK  X3, #0xa54f, LSL #48
    SUB  X20, X3, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, V6.D[1]
    MOVZ  X8, #0x11a3, LSL #0
    MOVK  X8, #0x8dc2, LSL #16
    MOVK  X8, #0x7c55, LSL #32
    MOVK  X8, #0xc86d, LSL #48
    SUB  X20, X8, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, D6
    MOVZ  X8, #0xdd24, LSL #0
    MOVK  X8, #0x83a0, LSL #16
    MOVK  X8, #0x4880, LSL #32
    MOVK  X8, #0x4e67, LSL #48
    SUB  X20, X8, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X11, #0x2be5, LSL #0
    MOVK  X11, #0x5911, LSL #16
    MOVK  X11, #0x1f32, LSL #32
    MOVK  X11, #0x7827, LSL #48
    SUB  X2, X11, X14
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D7
    MOVZ  X11, #0x9d6d, LSL #0
    MOVK  X11, #0x54c3, LSL #16
    MOVK  X11, #0xcc6a, LSL #32
    MOVK  X11, #0x2667, LSL #48
    SUB  X2, X11, X14
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, V8.D[1]
    MOVZ  X16, #0x59f6, LSL #0
    MOVK  X16, #0xe70e, LSL #16
    MOVK  X16, #0xc778, LSL #32
    MOVK  X16, #0x4aab, LSL #48
    SUB  X12, X16, X13
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, D8
    MOVZ  X16, #0x2d98, LSL #0
    MOVK  X16, #0x8cdb, LSL #16
    MOVK  X16, #0x328f, LSL #32
    MOVK  X16, #0xd3ab, LSL #48
    SUB  X12, X16, X13
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, V9.D[1]
    MOVZ  X29, #0x670e, LSL #0
    MOVK  X29, #0x192f, LSL #16
    MOVK  X29, #0xdd22, LSL #32
    MOVK  X29, #0x3cad, LSL #48
    SUB  X12, X29, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, D9
    MOVZ  X29, #0x21bd, LSL #0
    MOVK  X29, #0x9250, LSL #16
    MOVK  X29, #0x8f4, LSL #32
    MOVK  X29, #0x1a36, LSL #48
    SUB  X12, X29, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X12, #0x885e, LSL #0
    MOVK  X12, #0x8fe4, LSL #16
    MOVK  X12, #0x65de, LSL #32
    MOVK  X12, #0xf11f, LSL #48
    SUB  X29, X12, X16
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X16, D10
    MOVZ  X12, #0x1e78, LSL #0
    MOVK  X12, #0xc03b, LSL #16
    MOVK  X12, #0xb302, LSL #32
    MOVK  X12, #0x438e, LSL #48
    SUB  X29, X12, X16
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X9, #0xfda1, LSL #0
    MOVK  X9, #0xc08a, LSL #16
    MOVK  X9, #0x22de, LSL #32
    MOVK  X9, #0xf77b, LSL #48
    SUB  X8, X9, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, D11
    MOVZ  X9, #0x255f, LSL #0
    MOVK  X9, #0x20ac, LSL #16
    MOVK  X9, #0x18e0, LSL #32
    MOVK  X9, #0x43d4, LSL #48
    SUB  X8, X9, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X19, #0xe622, LSL #0
    MOVK  X19, #0x47, LSL #16
    MOVK  X19, #0x82b6, LSL #32
    MOVK  X19, #0x4398, LSL #48
    SUB  X16, X19, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, D12
    MOVZ  X19, #0x9afc, LSL #0
    MOVK  X19, #0xfd2b, LSL #16
    MOVK  X19, #0x45f5, LSL #32
    MOVK  X19, #0x20a3, LSL #48
    SUB  X16, X19, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, V13.D[1]
    MOVZ  X8, #0x8972, LSL #0
    MOVK  X8, #0xab69, LSL #16
    MOVK  X8, #0xee62, LSL #32
    MOVK  X8, #0xb7d9, LSL #48
    SUB  X6, X8, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, D13
    MOVZ  X8, #0x4874, LSL #0
    MOVK  X8, #0xdb1a, LSL #16
    MOVK  X8, #0xbcbe, LSL #32
    MOVK  X8, #0x6fb6, LSL #48
    SUB  X6, X8, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X2, #0xc02d, LSL #0
    MOVK  X2, #0x1745, LSL #16
    MOVK  X2, #0xb5ee, LSL #32
    MOVK  X2, #0x5066, LSL #48
    SUB  X17, X2, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, D14
    MOVZ  X2, #0x9c6c, LSL #0
    MOVK  X2, #0x3dcf, LSL #16
    MOVK  X2, #0x5266, LSL #32
    MOVK  X2, #0x2813, LSL #48
    SUB  X17, X2, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, V15.D[1]
    MOVZ  X4, #0x41b, LSL #0
    MOVK  X4, #0x6834, LSL #16
    MOVK  X4, #0x60bd, LSL #32
    MOVK  X4, #0xdbd2, LSL #48
    SUB  X12, X4, X28
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, D15
    MOVZ  X4, #0x2878, LSL #0
    MOVK  X4, #0xc777, LSL #16
    MOVK  X4, #0x14b8, LSL #32
    MOVK  X4, #0x6548, LSL #48
    SUB  X12, X4, X28
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X13, #0x8b24, LSL #0
    MOVK  X13, #0xb425, LSL #16
    MOVK  X13, #0x8dfb, LSL #32
    MOVK  X13, #0x9c87, LSL #48
    SUB  X20, X13, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X10, D16
    MOVZ  X13, #0x3ed0, LSL #0
    MOVK  X13, #0x7999, LSL #16
    MOVK  X13, #0x929a, LSL #32
    MOVK  X13, #0x6453, LSL #48
    SUB  X20, X13, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, V17.D[1]
    MOVZ  X25, #0x461f, LSL #0
    MOVK  X25, #0x6f86, LSL #16
    MOVK  X25, #0x21c1, LSL #32
    MOVK  X25, #0x3900, LSL #48
    SUB  X9, X25, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, D17
    MOVZ  X25, #0x9ac0, LSL #0
    MOVK  X25, #0xd138, LSL #16
    MOVK  X25, #0x5564, LSL #32
    MOVK  X25, #0xd949, LSL #48
    SUB  X9, X25, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X8, #0x850, LSL #0
    MOVK  X8, #0x3c0b, LSL #16
    MOVK  X8, #0xb8aa, LSL #32
    MOVK  X8, #0xea44, LSL #48
    SUB  X15, X8, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, D18
    MOVZ  X8, #0x357a, LSL #0
    MOVK  X8, #0x45e1, LSL #16
    MOVK  X8, #0xdd34, LSL #32
    MOVK  X8, #0x67d9, LSL #48
    SUB  X15, X8, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X16, #0x657b, LSL #0
    MOVK  X16, #0x5a90, LSL #16
    MOVK  X16, #0x42d4, LSL #32
    MOVK  X16, #0xe76f, LSL #48
    SUB  X27, X16, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, D19
    MOVZ  X16, #0x9630, LSL #0
    MOVK  X16, #0x781a, LSL #16
    MOVK  X16, #0x6d53, LSL #32
    MOVK  X16, #0xa84c, LSL #48
    SUB  X27, X16, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X13, #0xc8eb, LSL #0
    MOVK  X13, #0x9cbb, LSL #16
    MOVK  X13, #0x83ef, LSL #32
    MOVK  X13, #0xbb0a, LSL #48
    SUB  X3, X13, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, D20
    MOVZ  X13, #0x360d, LSL #0
    MOVK  X13, #0x1a0, LSL #16
    MOVK  X13, #0x8184, LSL #32
    MOVK  X13, #0x368, LSL #48
    SUB  X3, X13, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, V21.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X9, X12, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, D21
    MOVZ  X12, #0xe71b, LSL #0
    MOVK  X12, #0xf73, LSL #16
    SUB  X9, X12, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X5, #0xb44b, LSL #0
    MOVK  X5, #0x9dd8, LSL #16
    MOVK  X5, #0xa203, LSL #32
    MOVK  X5, #0xcdfc, LSL #48
    SUB  X13, X5, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D23
    MOVZ  X5, #0xf5e4, LSL #0
    MOVK  X5, #0xfc95, LSL #16
    MOVK  X5, #0x3ad2, LSL #32
    MOVK  X5, #0xdac9, LSL #48
    SUB  X13, X5, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, V24.D[1]
    MOVZ  X14, #0xd19f, LSL #0
    MOVK  X14, #0xac2a, LSL #16
    MOVK  X14, #0x2268, LSL #32
    MOVK  X14, #0x6149, LSL #48
    SUB  X8, X14, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, D24
    MOVZ  X14, #0xc00b, LSL #0
    MOVK  X14, #0xaea0, LSL #16
    MOVK  X14, #0x977f, LSL #32
    MOVK  X14, #0x697a, LSL #48
    SUB  X8, X14, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, V25.D[1]
    MOVZ  X7, #0x254d, LSL #0
    MOVK  X7, #0x8bb0, LSL #16
    MOVK  X7, #0x4bee, LSL #32
    MOVK  X7, #0x2ec, LSL #48
    SUB  X27, X7, X29
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, D25
    MOVZ  X7, #0x24c, LSL #0
    MOVK  X7, #0xae46, LSL #16
    MOVK  X7, #0x1d3f, LSL #32
    MOVK  X7, #0xce1a, LSL #48
    SUB  X27, X7, X29
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X3, #0xd8cb, LSL #0
    MOVK  X3, #0xd7dd, LSL #16
    MOVK  X3, #0x4bdb, LSL #32
    MOVK  X3, #0xe734, LSL #48
    SUB  X25, X3, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, D26
    MOVZ  X3, #0x9b5d, LSL #0
    MOVK  X3, #0x46ff, LSL #16
    MOVK  X3, #0x2d07, LSL #32
    MOVK  X3, #0x266f, LSL #48
    SUB  X25, X3, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X29, #0x41d2, LSL #0
    MOVK  X29, #0x1d8a, LSL #16
    MOVK  X29, #0x5e1, LSL #32
    MOVK  X29, #0x9ca5, LSL #48
    SUB  X17, X29, X24
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, D27
    MOVZ  X29, #0xfbdf, LSL #0
    MOVK  X29, #0xe35d, LSL #16
    MOVK  X29, #0x4520, LSL #32
    MOVK  X29, #0x1b10, LSL #48
    SUB  X17, X29, X24
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, V28.D[1]
    MOVZ  X7, #0x3019, LSL #0
    MOVK  X7, #0x6070, LSL #16
    MOVK  X7, #0x4c08, LSL #32
    MOVK  X7, #0xca6c, LSL #48
    SUB  X8, X7, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, D28
    MOVZ  X7, #0xc2fb, LSL #0
    MOVK  X7, #0xb074, LSL #16
    MOVK  X7, #0x90c3, LSL #32
    MOVK  X7, #0xee66, LSL #48
    SUB  X8, X7, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X2, #0x5121, LSL #0
    MOVK  X2, #0x2ca1, LSL #16
    MOVK  X2, #0xd28b, LSL #32
    MOVK  X2, #0x65b0, LSL #48
    SUB  X3, X2, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D29
    MOVZ  X2, #0xfd17, LSL #0
    MOVK  X2, #0xc3c, LSL #16
    MOVK  X2, #0xf7ea, LSL #32
    MOVK  X2, #0x28d4, LSL #48
    SUB  X3, X2, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
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
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X27
    FMOV  V0.D[1], X29
    FMOV  D1, X21
    FMOV  V1.D[1], X5
    FMOV  D2, X3
    FMOV  V2.D[1], X7
    FMOV  D3, X20
    FMOV  V3.D[1], X17
    FMOV  D4, X25
    FMOV  V4.D[1], X26
    FMOV  D5, X11
    FMOV  V5.D[1], X2
    FMOV  D6, X9
    FMOV  V6.D[1], X27
    FMOV  D7, X5
    FMOV  V7.D[1], X25
    FMOV  D8, X28
    FMOV  V8.D[1], X2
    FMOV  D9, X8
    FMOV  V9.D[1], X27
    FMOV  D10, X2
    FMOV  V10.D[1], X2
TaishanSimdUnaryArithmeticP01_label_25:
    FMOV  D11, X23
    FMOV  V11.D[1], X27
    FMOV  D12, X16
    FMOV  V12.D[1], X4
    FMOV  D13, X8
    FMOV  V13.D[1], X24
    FMOV  D14, X16
    FMOV  V14.D[1], X24
    FMOV  D15, X24
    FMOV  V15.D[1], X28
    FMOV  D16, X24
    FMOV  V16.D[1], X16
    FMOV  D17, X23
    FMOV  V17.D[1], X20
    FMOV  D18, X10
    FMOV  V18.D[1], X27
    FMOV  D19, X8
    FMOV  V19.D[1], X14
    FMOV  D20, X8
    FMOV  V20.D[1], X17
    FMOV  D21, X18
    FMOV  V21.D[1], X14
    FMOV  D22, X2
    FMOV  V22.D[1], X9
    FMOV  D23, X8
    FMOV  V23.D[1], X23
    FMOV  D24, X20
    FMOV  V24.D[1], X4
    FMOV  D25, X26
    FMOV  V25.D[1], X19
    FMOV  D26, X26
    FMOV  V26.D[1], X28
    FMOV  D27, X17
    FMOV  V27.D[1], X14
    FMOV  D28, X6
    FMOV  V28.D[1], X3
    FMOV  D29, X12
    FMOV  V29.D[1], X21
    FMOV  D30, X28
    FMOV  V30.D[1], X11
    FMOV  D31, X6
    FMOV  V31.D[1], X12
    MOVZ  X11, #0xa, LSL #0
TaishanSimdUnaryArithmeticP01_label_83:
    SHA1C  Q22, S4, V20.4S
    SHA1H  S18, S21
    SHA1M  Q13, S8, V25.4S
    AESMC  V15.16B, V28.16B
    SHA256H2  Q31, Q30, V12.4S
    AESMC  V8.16B, V15.16B
    SHA1C  Q15, S10, V15.4S
    SHA1SU1  V12.4S, V16.4S
    SHA1H  S27, S13
    AESD  V21.16B, V28.16B
    SHA1H  S11, S1
    SHA256H2  Q12, Q12, V30.4S
    SHA1H  S28, S1
    SHA256SU0  V19.4S, V28.4S
    AESD  V14.16B, V4.16B
    AESD  V29.16B, V5.16B
    AESIMC  V29.16B, V28.16B
    SHA1SU1  V29.4S, V2.4S
    SHA1M  Q14, S20, V30.4S
    AESIMC  V3.16B, V28.16B
    SHA1C  Q31, S12, V5.4S
    SHA256H  Q3, Q7, V12.4S
    AESIMC  V12.16B, V8.16B
    SHA1P  Q26, S31, V1.4S
    AESE  V15.16B, V0.16B
    SHA1M  Q19, S9, V27.4S
    SHA256SU0  V4.4S, V8.4S
    AESD  V29.16B, V31.16B
    SHA1M  Q9, S24, V10.4S
    AESD  V2.16B, V7.16B
    AESMC  V30.16B, V16.16B
    AESE  V2.16B, V2.16B
    SHA256SU1  V20.4S, V20.4S, V30.4S
    SHA1M  Q0, S13, V15.4S
    SHA1SU0  V15.4S, V12.4S, V19.4S
    SHA1SU1  V24.4S, V5.4S
    AESMC  V3.16B, V25.16B
    AESIMC  V27.16B, V28.16B
    SHA1C  Q16, S24, V12.4S
    SHA1P  Q28, S17, V16.4S
    SHA1M  Q19, S4, V27.4S
    SHA256H  Q9, Q14, V30.4S
    AESD  V20.16B, V15.16B
    SHA1SU0  V6.4S, V3.4S, V17.4S
    AESD  V27.16B, V28.16B
    SHA1C  Q20, S27, V20.4S
    SHA256H  Q25, Q24, V27.4S
    SHA256SU0  V6.4S, V28.4S
    SHA1P  Q22, S23, V21.4S
    SHA256H  Q16, Q23, V13.4S
    SHA256SU0  V25.4S, V18.4S
    SHA256SU1  V16.4S, V20.4S, V21.4S
    AESIMC  V9.16B, V6.16B
    SHA256H  Q6, Q1, V23.4S
    SHA1SU0  V4.4S, V14.4S, V9.4S
    SHA1M  Q4, S15, V6.4S
    AESIMC  V22.16B, V6.16B
    SHA1SU0  V29.4S, V13.4S, V18.4S
    SHA256H  Q15, Q18, V22.4S
    SHA1C  Q13, S10, V4.4S
    AESD  V3.16B, V25.16B
    SHA256H2  Q28, Q6, V20.4S
    SHA1M  Q20, S11, V21.4S
    SHA1SU1  V0.4S, V6.4S
    SHA1SU1  V16.4S, V15.4S
    SHA1H  S19, S25
    SHA1H  S3, S6
    SHA1SU1  V31.4S, V2.4S
    SHA256SU0  V21.4S, V28.4S
    AESD  V11.16B, V30.16B
    SHA1SU0  V25.4S, V29.4S, V29.4S
    SHA1C  Q28, S30, V22.4S
    SHA1P  Q29, S9, V0.4S
    AESD  V22.16B, V25.16B
    AESE  V4.16B, V0.16B
    AESMC  V19.16B, V28.16B
    SHA1P  Q1, S27, V2.4S
    SHA1SU1  V14.4S, V30.4S
    SHA1P  Q13, S17, V18.4S
    SHA1P  Q8, S2, V17.4S
    AESD  V21.16B, V9.16B
    SHA1H  S22, S5
    SHA256H2  Q26, Q11, V16.4S
    SHA1H  S4, S25
    SHA1H  S27, S15
    SHA256SU1  V19.4S, V3.4S, V1.4S
    SHA1SU0  V4.4S, V23.4S, V8.4S
    SHA1H  S2, S3
    SHA1SU0  V5.4S, V13.4S, V30.4S
    SHA1C  Q2, S11, V0.4S
    AESD  V0.16B, V15.16B
    SHA1P  Q21, S11, V20.4S
    SHA256H  Q22, Q9, V6.4S
    SHA1P  Q26, S14, V31.4S
    SHA1SU0  V31.4S, V28.4S, V25.4S
    AESE  V27.16B, V17.16B
    SHA1P  Q20, S12, V3.4S
    SHA1SU1  V27.4S, V8.4S
    SHA256H  Q19, Q2, V25.4S
    AESIMC  V25.16B, V27.16B
    SHA1H  S9, S2
    AESD  V9.16B, V3.16B
    SHA256SU1  V5.4S, V17.4S, V23.4S
    SHA256SU1  V18.4S, V23.4S, V11.4S
    SHA256H  Q31, Q13, V9.4S
    SHA1P  Q20, S18, V4.4S
    SHA1M  Q15, S1, V29.4S
    SHA1M  Q1, S0, V21.4S
    SHA256H2  Q14, Q2, V1.4S
    SHA1C  Q29, S20, V19.4S
    SHA1C  Q11, S28, V5.4S
    SHA256H  Q9, Q25, V8.4S
    SHA256SU1  V12.4S, V0.4S, V15.4S
    SHA256SU1  V21.4S, V8.4S, V1.4S
    SHA1SU1  V10.4S, V24.4S
    SHA1P  Q11, S23, V27.4S
    SHA1H  S11, S6
    AESD  V8.16B, V30.16B
    AESE  V21.16B, V19.16B
    SHA1SU0  V13.4S, V28.4S, V31.4S
    SHA1P  Q25, S16, V31.4S
    SHA1SU0  V3.4S, V24.4S, V12.4S
    SHA256H2  Q16, Q6, V29.4S
    SHA256SU1  V28.4S, V6.4S, V27.4S
    AESD  V19.16B, V19.16B
    SHA1M  Q25, S29, V28.4S
    SHA1C  Q18, S14, V14.4S
    SHA1H  S19, S25
    SHA1SU0  V22.4S, V15.4S, V31.4S
    SHA256SU0  V24.4S, V14.4S
    SHA1SU1  V4.4S, V7.4S
    SHA1SU1  V25.4S, V28.4S
    AESD  V28.16B, V30.16B
    SHA1C  Q22, S7, V7.4S
    SHA1M  Q5, S24, V12.4S
    SHA256H  Q22, Q19, V10.4S
    SHA1M  Q19, S0, V2.4S
    AESE  V31.16B, V29.16B
    SHA256SU1  V30.4S, V0.4S, V14.4S
    AESD  V15.16B, V19.16B
    AESD  V3.16B, V6.16B
    SHA1H  S10, S25
    SHA256H2  Q5, Q7, V8.4S
    AESE  V25.16B, V10.16B
    SHA256H2  Q1, Q7, V23.4S
    SHA256SU1  V24.4S, V8.4S, V1.4S
    SHA256H2  Q11, Q17, V10.4S
    SHA1SU0  V4.4S, V12.4S, V27.4S
    SHA1SU0  V25.4S, V17.4S, V11.4S
    AESE  V16.16B, V11.16B
    SHA1C  Q24, S9, V30.4S
    SHA1C  Q18, S1, V2.4S
    SHA1M  Q2, S28, V24.4S
    SHA1C  Q17, S6, V9.4S
    SHA256H  Q31, Q2, V2.4S
    SHA1SU1  V11.4S, V26.4S
    SHA1P  Q15, S6, V0.4S
    SHA1SU0  V3.4S, V11.4S, V27.4S
    SHA1M  Q27, S19, V19.4S
    SHA1M  Q12, S18, V29.4S
    SHA1P  Q25, S12, V26.4S
    SHA1SU1  V3.4S, V11.4S
    AESD  V3.16B, V11.16B
    SHA1H  S12, S23
    SHA1M  Q23, S23, V4.4S
    SHA1P  Q7, S7, V3.4S
    SHA256SU1  V6.4S, V9.4S, V0.4S
    SHA1H  S31, S12
    SHA1H  S17, S8
    SHA256SU1  V18.4S, V25.4S, V22.4S
    AESE  V28.16B, V20.16B
    SHA1M  Q31, S27, V12.4S
    AESIMC  V25.16B, V13.16B
    SHA1C  Q28, S25, V28.4S
    AESE  V31.16B, V16.16B
    SHA1H  S16, S22
    AESIMC  V18.16B, V28.16B
    SHA1H  S17, S1
    AESIMC  V8.16B, V15.16B
    SHA256SU0  V13.4S, V4.4S
    SHA1M  Q4, S15, V7.4S
    AESIMC  V31.16B, V25.16B
    SHA1SU1  V18.4S, V5.4S
    AESIMC  V9.16B, V23.16B
    AESMC  V13.16B, V25.16B
    AESMC  V13.16B, V11.16B
    SHA256H2  Q5, Q0, V16.4S
    SHA256SU1  V13.4S, V2.4S, V15.4S
    SHA1SU0  V16.4S, V17.4S, V20.4S
    SHA1SU1  V6.4S, V18.4S
    SHA1P  Q0, S11, V25.4S
    SHA256H  Q31, Q27, V25.4S
    SHA256H2  Q6, Q9, V2.4S
    SHA256H2  Q13, Q15, V1.4S
    AESD  V27.16B, V16.16B
    AESMC  V25.16B, V23.16B
    AESIMC  V1.16B, V17.16B
    SHA1SU0  V27.4S, V13.4S, V29.4S
    SHA1SU1  V3.4S, V12.4S
    SHA256SU0  V12.4S, V16.4S
    SUBS  X11, X11, #0x1
    B.NE  TaishanSimdUnaryArithmeticP01_label_83
    MOVZ  X8, #0x0, LSL #0
    SUB  X24, X8, X2
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X24, X20, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X21, X12, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X15
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X16
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X8, X21, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X9, X17, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, V2.D[1]
    MOVZ  X26, #0x4d4f, LSL #0
    MOVK  X26, #0x527e, LSL #16
    MOVK  X26, #0x414d, LSL #32
    MOVK  X26, #0x6579, LSL #48
    SUB  X10, X26, X5
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, D2
    MOVZ  X26, #0x3f72, LSL #0
    MOVK  X26, #0xf845, LSL #16
    MOVK  X26, #0x7499, LSL #32
    MOVK  X26, #0xa9cb, LSL #48
    SUB  X10, X26, X5
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X9, #0xa01c, LSL #0
    MOVK  X9, #0x194f, LSL #16
    MOVK  X9, #0xe73a, LSL #32
    MOVK  X9, #0x4899, LSL #48
    SUB  X12, X9, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D3
    MOVZ  X9, #0x6c8a, LSL #0
    MOVK  X9, #0x3ffc, LSL #16
    MOVK  X9, #0x5894, LSL #32
    MOVK  X9, #0xe1, LSL #48
    SUB  X12, X9, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X28, #0xd10d, LSL #0
    MOVK  X28, #0x4747, LSL #16
    MOVK  X28, #0xd99c, LSL #32
    MOVK  X28, #0xff48, LSL #48
    SUB  X9, X28, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, D4
    MOVZ  X28, #0xac3a, LSL #0
    MOVK  X28, #0x890c, LSL #16
    MOVK  X28, #0x2b48, LSL #32
    MOVK  X28, #0xfbb3, LSL #48
    SUB  X9, X28, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X24, #0xd150, LSL #0
    MOVK  X24, #0x83de, LSL #16
    MOVK  X24, #0x4daf, LSL #32
    MOVK  X24, #0x8631, LSL #48
    SUB  X2, X24, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, D5
    MOVZ  X24, #0x9621, LSL #0
    MOVK  X24, #0xe6c5, LSL #16
    MOVK  X24, #0xa35e, LSL #32
    MOVK  X24, #0x9335, LSL #48
    SUB  X2, X24, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X29, #0xcd05, LSL #0
    MOVK  X29, #0xe7af, LSL #16
    MOVK  X29, #0x3b49, LSL #32
    MOVK  X29, #0x950f, LSL #48
    SUB  X26, X29, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, D6
    MOVZ  X29, #0xa399, LSL #0
    MOVK  X29, #0xa75b, LSL #16
    MOVK  X29, #0x904a, LSL #32
    MOVK  X29, #0x9864, LSL #48
    SUB  X26, X29, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X20, #0x706c, LSL #0
    MOVK  X20, #0xac3, LSL #16
    MOVK  X20, #0x9e95, LSL #32
    MOVK  X20, #0xe04, LSL #48
    SUB  X25, X20, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, D7
    MOVZ  X20, #0xef6b, LSL #0
    MOVK  X20, #0x98d5, LSL #16
    MOVK  X20, #0xb783, LSL #32
    MOVK  X20, #0xa8aa, LSL #48
    SUB  X25, X20, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, V8.D[1]
    MOVZ  X3, #0xe9, LSL #0
    MOVK  X3, #0x7c9b, LSL #16
    MOVK  X3, #0xa55a, LSL #32
    MOVK  X3, #0x19b2, LSL #48
    SUB  X23, X3, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, D8
    MOVZ  X3, #0x3817, LSL #0
    MOVK  X3, #0x179d, LSL #16
    MOVK  X3, #0xc1be, LSL #32
    MOVK  X3, #0x54a, LSL #48
    SUB  X23, X3, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, V9.D[1]
    MOVZ  X26, #0x9914, LSL #0
    MOVK  X26, #0x7b46, LSL #16
    MOVK  X26, #0x146b, LSL #32
    MOVK  X26, #0x8ab0, LSL #48
    SUB  X19, X26, X25
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, D9
    MOVZ  X26, #0xb75f, LSL #0
    MOVK  X26, #0x3193, LSL #16
    MOVK  X26, #0x4131, LSL #32
    MOVK  X26, #0x420e, LSL #48
    SUB  X19, X26, X25
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, D10
    MOVZ  X4, #0x10f8, LSL #0
    MOVK  X4, #0xa5c7, LSL #16
    SUB  X13, X4, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, V11.D[1]
    MOVZ  X15, #0xde5a, LSL #0
    MOVK  X15, #0x6cfa, LSL #16
    MOVK  X15, #0xe4b3, LSL #32
    MOVK  X15, #0x401f, LSL #48
    SUB  X28, X15, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, D11
    MOVZ  X15, #0x5a18, LSL #0
    MOVK  X15, #0x5e79, LSL #16
    MOVK  X15, #0x4d0f, LSL #32
    MOVK  X15, #0xaf86, LSL #48
    SUB  X28, X15, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, V12.D[1]
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xff5e, LSL #32
    MOVK  X11, #0x94d7, LSL #48
    SUB  X3, X11, X27
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, D12
    MOVZ  X11, #0xc8f6, LSL #0
    MOVK  X11, #0x9400, LSL #16
    SUB  X3, X11, X27
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, V13.D[1]
    MOVZ  X15, #0xfd56, LSL #0
    MOVK  X15, #0x8ea1, LSL #16
    MOVK  X15, #0xc182, LSL #32
    MOVK  X15, #0xf5a4, LSL #48
    SUB  X14, X15, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, D13
    MOVZ  X15, #0xf0ca, LSL #0
    MOVK  X15, #0xc036, LSL #16
    MOVK  X15, #0x2a75, LSL #32
    MOVK  X15, #0x2eb8, LSL #48
    SUB  X14, X15, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X11, #0x92a4, LSL #0
    MOVK  X11, #0xafb7, LSL #16
    MOVK  X11, #0x2de3, LSL #32
    MOVK  X11, #0x3120, LSL #48
    SUB  X12, X11, X28
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, D14
    MOVZ  X11, #0xda8e, LSL #0
    MOVK  X11, #0x1945, LSL #16
    MOVK  X11, #0xf135, LSL #32
    MOVK  X11, #0x5494, LSL #48
    SUB  X12, X11, X28
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, V15.D[1]
    MOVZ  X9, #0x232e, LSL #0
    MOVK  X9, #0x4340, LSL #16
    MOVK  X9, #0xdfeb, LSL #32
    MOVK  X9, #0xcbab, LSL #48
    SUB  X26, X9, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, D15
    MOVZ  X9, #0xccec, LSL #0
    MOVK  X9, #0xb237, LSL #16
    MOVK  X9, #0xfc70, LSL #32
    MOVK  X9, #0x58e4, LSL #48
    SUB  X26, X9, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X7, #0x27dd, LSL #0
    MOVK  X7, #0x6974, LSL #16
    MOVK  X7, #0x4eaf, LSL #32
    MOVK  X7, #0xeb29, LSL #48
    SUB  X19, X7, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, D16
    MOVZ  X7, #0x7aed, LSL #0
    MOVK  X7, #0x8bd9, LSL #16
    MOVK  X7, #0x7f6c, LSL #32
    MOVK  X7, #0x711e, LSL #48
    SUB  X19, X7, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, V17.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X21, X26, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, D17
    MOVZ  X26, #0xf043, LSL #0
    MOVK  X26, #0x4d79, LSL #16
    SUB  X21, X26, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, V18.D[1]
    MOVZ  X24, #0xffaf, LSL #0
    MOVK  X24, #0x75cf, LSL #16
    MOVK  X24, #0x208f, LSL #32
    MOVK  X24, #0x1009, LSL #48
    SUB  X3, X24, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, D18
    MOVZ  X24, #0x8c27, LSL #0
    MOVK  X24, #0xdf91, LSL #16
    MOVK  X24, #0x60ae, LSL #32
    MOVK  X24, #0xe674, LSL #48
    SUB  X3, X24, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X9, #0x1c11, LSL #0
    MOVK  X9, #0x62e4, LSL #16
    MOVK  X9, #0x2776, LSL #32
    MOVK  X9, #0xf0f7, LSL #48
    SUB  X15, X9, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, D19
    MOVZ  X9, #0xd524, LSL #0
    MOVK  X9, #0xdda9, LSL #16
    MOVK  X9, #0x5560, LSL #32
    MOVK  X9, #0xb031, LSL #48
    SUB  X15, X9, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X23, #0xd79e, LSL #0
    MOVK  X23, #0x240d, LSL #16
    MOVK  X23, #0x4eaf, LSL #32
    MOVK  X23, #0xeb29, LSL #48
    SUB  X29, X23, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, D20
    MOVZ  X23, #0x15e3, LSL #0
    MOVK  X23, #0xcec4, LSL #16
    MOVK  X23, #0x7f6c, LSL #32
    MOVK  X23, #0x711e, LSL #48
    SUB  X29, X23, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, V21.D[1]
    MOVZ  X17, #0x4da9, LSL #0
    MOVK  X17, #0x8836, LSL #16
    MOVK  X17, #0x4961, LSL #32
    MOVK  X17, #0x3f46, LSL #48
    SUB  X8, X17, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, D21
    MOVZ  X17, #0x178a, LSL #0
    MOVK  X17, #0x6816, LSL #16
    MOVK  X17, #0x3faa, LSL #32
    MOVK  X17, #0xc6f7, LSL #48
    SUB  X8, X17, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, V23.D[1]
    MOVZ  X17, #0x8ca5, LSL #0
    MOVK  X17, #0x158c, LSL #16
    MOVK  X17, #0x2d0, LSL #32
    MOVK  X17, #0x1681, LSL #48
    SUB  X13, X17, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, D23
    MOVZ  X17, #0xb5de, LSL #0
    MOVK  X17, #0xa786, LSL #16
    MOVK  X17, #0xe3ed, LSL #32
    MOVK  X17, #0x98aa, LSL #48
    SUB  X13, X17, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X8, #0x7819, LSL #0
    MOVK  X8, #0x1bc8, LSL #16
    MOVK  X8, #0x398d, LSL #32
    MOVK  X8, #0x38de, LSL #48
    SUB  X26, X8, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, D24
    MOVZ  X8, #0xdf0b, LSL #0
    MOVK  X8, #0x7bf, LSL #16
    MOVK  X8, #0x9b1e, LSL #32
    MOVK  X8, #0x5b1, LSL #48
    SUB  X26, X8, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X12, #0x3c47, LSL #0
    MOVK  X12, #0xde15, LSL #16
    MOVK  X12, #0x5a2a, LSL #32
    MOVK  X12, #0xc4f1, LSL #48
    SUB  X29, X12, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, D25
    MOVZ  X12, #0x9942, LSL #0
    MOVK  X12, #0x1f8e, LSL #16
    MOVK  X12, #0x4dcd, LSL #32
    MOVK  X12, #0x4ef2, LSL #48
    SUB  X29, X12, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X3, #0xf587, LSL #0
    MOVK  X3, #0xeba, LSL #16
    MOVK  X3, #0x5be6, LSL #32
    MOVK  X3, #0xaaa9, LSL #48
    SUB  X11, X3, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, D26
    MOVZ  X3, #0x5edc, LSL #0
    MOVK  X3, #0xf4ad, LSL #16
    MOVK  X3, #0xf318, LSL #32
    MOVK  X3, #0x2d17, LSL #48
    SUB  X11, X3, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, V27.D[1]
    MOVZ  X6, #0x80e4, LSL #0
    MOVK  X6, #0x60b0, LSL #16
    MOVK  X6, #0x387, LSL #32
    MOVK  X6, #0x461c, LSL #48
    SUB  X9, X6, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, D27
    MOVZ  X6, #0xe73a, LSL #0
    MOVK  X6, #0x3b6a, LSL #16
    MOVK  X6, #0xc37, LSL #32
    MOVK  X6, #0x74f6, LSL #48
    SUB  X9, X6, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X15, #0x1bbb, LSL #0
    MOVK  X15, #0xcf47, LSL #16
    MOVK  X15, #0xab26, LSL #32
    MOVK  X15, #0x87b4, LSL #48
    SUB  X24, X15, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, D28
    MOVZ  X15, #0x9633, LSL #0
    MOVK  X15, #0xbc9b, LSL #16
    MOVK  X15, #0xd83e, LSL #32
    MOVK  X15, #0x7e80, LSL #48
    SUB  X24, X15, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, V29.D[1]
    MOVZ  X24, #0x9bba, LSL #0
    MOVK  X24, #0xba91, LSL #16
    MOVK  X24, #0xf0ec, LSL #32
    MOVK  X24, #0xf6f3, LSL #48
    SUB  X25, X24, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, D29
    MOVZ  X24, #0x4d3a, LSL #0
    MOVK  X24, #0xb8b0, LSL #16
    MOVK  X24, #0xbc79, LSL #32
    MOVK  X24, #0xec96, LSL #48
    SUB  X25, X24, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
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
    FMOV  D0, X17
    FMOV  V0.D[1], X17
    FMOV  D1, X20
    FMOV  V1.D[1], X8
    FMOV  D2, X17
    FMOV  V2.D[1], X29
    FMOV  D3, X3
    FMOV  V3.D[1], X28
    FMOV  D4, X26
    FMOV  V4.D[1], X17
    FMOV  D5, X25
    FMOV  V5.D[1], X14
    FMOV  D6, X24
    FMOV  V6.D[1], X8
    FMOV  D7, X2
    FMOV  V7.D[1], X21
    FMOV  D8, X27
    FMOV  V8.D[1], X15
    FMOV  D9, X14
    FMOV  V9.D[1], X25
    FMOV  D10, X27
    FMOV  V10.D[1], X28
    FMOV  D11, X12
    FMOV  V11.D[1], X6
    FMOV  D12, X2
    FMOV  V12.D[1], X8
    FMOV  D13, X12
    FMOV  V13.D[1], X2
    FMOV  D14, X6
    FMOV  V14.D[1], X14
    FMOV  D15, X4
    FMOV  V15.D[1], X20
    FMOV  D16, X27
    FMOV  V16.D[1], X20
    FMOV  D17, X12
    FMOV  V17.D[1], X28
    FMOV  D18, X10
    FMOV  V18.D[1], X4
    FMOV  D19, X28
    FMOV  V19.D[1], X17
    FMOV  D20, X14
    FMOV  V20.D[1], X23
    FMOV  D21, X6
    FMOV  V21.D[1], X28
    FMOV  D22, X15
    FMOV  V22.D[1], X17
    FMOV  D23, X12
    FMOV  V23.D[1], X12
    FMOV  D24, X9
    FMOV  V24.D[1], X10
    FMOV  D25, X28
    FMOV  V25.D[1], X28
    FMOV  D26, X13
    FMOV  V26.D[1], X23
    FMOV  D27, X21
    FMOV  V27.D[1], X10
    FMOV  D28, X12
    FMOV  V28.D[1], X18
    FMOV  D29, X24
    FMOV  V29.D[1], X12
    FMOV  D30, X20
    FMOV  V30.D[1], X26
    FMOV  D31, X27
    FMOV  V31.D[1], X21
    MOVZ  X3, #0xf, LSL #0
TaishanSimdUnaryArithmeticP01_label_166:
    SHA1M  Q31, S25, V28.4S
    AESMC  V5.16B, V27.16B
    SHA1P  Q5, S29, V26.4S
    SHA256H2  Q31, Q4, V30.4S
    SHA1H  S5, S23
    SHA256SU0  V5.4S, V13.4S
    AESD  V4.16B, V18.16B
    AESE  V29.16B, V7.16B
    SHA1SU0  V19.4S, V25.4S, V29.4S
    SHA1SU1  V29.4S, V10.4S
    AESMC  V30.16B, V4.16B
    SHA1M  Q25, S11, V28.4S
    AESIMC  V30.16B, V4.16B
    SHA256H2  Q16, Q27, V25.4S
    SHA1H  S18, S6
    AESD  V7.16B, V0.16B
    SHA256H2  Q8, Q30, V0.4S
    AESMC  V12.16B, V1.16B
    SHA1P  Q30, S2, V4.4S
    SHA1SU0  V24.4S, V22.4S, V14.4S
    SHA256SU1  V5.4S, V12.4S, V6.4S
    SHA1SU0  V12.4S, V30.4S, V8.4S
    SHA256SU1  V0.4S, V8.4S, V16.4S
    SHA1H  S3, S2
    SHA256SU1  V20.4S, V18.4S, V19.4S
    SHA1SU1  V23.4S, V28.4S
    SHA1P  Q7, S0, V13.4S
    SHA1M  Q4, S3, V17.4S
    SHA1SU1  V11.4S, V25.4S
    AESIMC  V11.16B, V25.16B
    AESIMC  V26.16B, V4.16B
    SHA1H  S7, S12
    SHA1SU1  V26.4S, V9.4S
    SHA256H  Q29, Q21, V14.4S
    AESD  V23.16B, V16.16B
    SHA1H  S24, S12
    SHA256SU1  V8.4S, V24.4S, V16.4S
    SHA256SU1  V27.4S, V7.4S, V19.4S
    SHA1P  Q24, S26, V6.4S
    SHA1C  Q17, S25, V4.4S
    SHA1M  Q13, S22, V24.4S
    AESE  V30.16B, V13.16B
    SHA1H  S1, S24
    AESMC  V18.16B, V29.16B
    AESMC  V5.16B, V7.16B
    AESD  V20.16B, V18.16B
    SHA1SU1  V24.4S, V1.4S
    SHA1M  Q30, S30, V12.4S
    SHA256SU0  V28.4S, V11.4S
    SHA1SU0  V7.4S, V23.4S, V17.4S
    SHA1C  Q27, S19, V20.4S
    AESE  V5.16B, V30.16B
    SHA1SU0  V14.4S, V17.4S, V30.4S
    SHA256SU1  V30.4S, V29.4S, V14.4S
    SHA1M  Q28, S24, V7.4S
    SHA256SU0  V23.4S, V11.4S
    AESMC  V9.16B, V13.16B
    SHA1M  Q12, S13, V1.4S
    SHA256SU1  V27.4S, V27.4S, V21.4S
    SHA256H2  Q16, Q13, V27.4S
    SHA256H2  Q23, Q16, V5.4S
    SHA256SU1  V11.4S, V5.4S, V8.4S
    AESMC  V10.16B, V22.16B
    AESMC  V31.16B, V23.16B
    SHA256SU1  V2.4S, V20.4S, V4.4S
    AESIMC  V10.16B, V8.16B
    SHA256SU0  V19.4S, V25.4S
    AESD  V28.16B, V7.16B
    SHA1SU0  V26.4S, V1.4S, V11.4S
    AESMC  V1.16B, V21.16B
    SHA256SU0  V3.4S, V1.4S
    AESE  V12.16B, V31.16B
    AESIMC  V24.16B, V2.16B
    SHA256H  Q26, Q0, V28.4S
    AESE  V10.16B, V4.16B
    SHA256H  Q28, Q25, V23.4S
    SHA256H2  Q15, Q28, V8.4S
    SHA256SU0  V31.4S, V27.4S
    SHA1H  S6, S11
    AESE  V27.16B, V20.16B
    SHA256H  Q12, Q16, V10.4S
    SHA256H  Q21, Q30, V16.4S
    SHA1SU0  V16.4S, V20.4S, V9.4S
    SHA1SU1  V10.4S, V12.4S
    SHA1P  Q3, S22, V6.4S
    SHA1P  Q25, S7, V2.4S
    AESD  V18.16B, V17.16B
    SHA1H  S21, S2
    SHA256H2  Q21, Q9, V30.4S
    SHA1SU1  V26.4S, V7.4S
    SHA256H  Q25, Q14, V0.4S
    SHA256H2  Q1, Q26, V1.4S
    SHA1SU1  V10.4S, V28.4S
    SHA1M  Q30, S30, V11.4S
    AESIMC  V13.16B, V16.16B
    SHA1H  S25, S12
    SHA256H2  Q3, Q0, V31.4S
    SHA1H  S30, S25
    SHA256SU0  V26.4S, V8.4S
    SHA1SU1  V4.4S, V21.4S
    SHA256SU0  V26.4S, V27.4S
    SHA1C  Q10, S11, V15.4S
    SHA256H  Q2, Q13, V12.4S
    SHA256H  Q5, Q30, V19.4S
    SHA256H  Q16, Q10, V19.4S
    SHA1P  Q17, S0, V7.4S
    SHA1SU0  V10.4S, V23.4S, V30.4S
    SHA256SU0  V12.4S, V17.4S
    AESMC  V7.16B, V23.16B
    SHA1P  Q19, S17, V30.4S
    SHA256H  Q17, Q29, V18.4S
    SHA1SU1  V31.4S, V18.4S
    SHA1M  Q19, S17, V23.4S
    SHA256H2  Q10, Q17, V17.4S
    SHA1SU0  V23.4S, V11.4S, V6.4S
    SHA256H2  Q13, Q29, V11.4S
    SHA256H2  Q18, Q4, V18.4S
    SHA1C  Q0, S21, V16.4S
    AESMC  V5.16B, V5.16B
    SHA256H2  Q5, Q15, V16.4S
    SHA256H  Q0, Q7, V27.4S
    SHA256H2  Q16, Q4, V18.4S
    SHA1C  Q25, S2, V17.4S
    SHA256SU1  V17.4S, V6.4S, V6.4S
    SHA1P  Q19, S2, V13.4S
    AESIMC  V22.16B, V30.16B
    SHA256H2  Q7, Q8, V24.4S
    AESD  V31.16B, V4.16B
    SHA256SU0  V26.4S, V6.4S
    SHA256SU0  V6.4S, V16.4S
    AESMC  V8.16B, V11.16B
    SHA1M  Q21, S23, V2.4S
    SHA1H  S23, S23
    SHA1SU0  V24.4S, V2.4S, V6.4S
    SHA1H  S29, S8
    AESMC  V1.16B, V12.16B
    SHA256H2  Q13, Q12, V11.4S
    SHA1C  Q8, S27, V5.4S
    SHA1M  Q30, S20, V11.4S
    AESE  V24.16B, V13.16B
    SHA1P  Q13, S25, V23.4S
    SHA1SU1  V10.4S, V4.4S
    AESE  V23.16B, V23.16B
    SHA1P  Q20, S13, V8.4S
    AESMC  V20.16B, V19.16B
    SHA256H  Q11, Q0, V6.4S
    SHA1M  Q24, S11, V3.4S
    SHA1C  Q26, S25, V21.4S
    SHA1SU1  V7.4S, V26.4S
    SHA1SU1  V5.4S, V18.4S
    SHA256SU0  V21.4S, V29.4S
    AESE  V5.16B, V2.16B
    SHA1SU0  V7.4S, V25.4S, V6.4S
    SHA1SU1  V13.4S, V18.4S
    SHA1H  S23, S26
    SHA1P  Q19, S29, V24.4S
    SHA1H  S17, S27
    SHA1H  S25, S14
    AESIMC  V9.16B, V16.16B
    SHA1H  S7, S28
    SHA256H  Q20, Q18, V8.4S
    SHA1H  S29, S23
    AESMC  V20.16B, V15.16B
    SHA1C  Q26, S28, V0.4S
    AESIMC  V31.16B, V31.16B
    AESMC  V7.16B, V4.16B
    AESIMC  V21.16B, V20.16B
    SHA1SU0  V5.4S, V21.4S, V16.4S
    SHA1H  S5, S20
    AESMC  V5.16B, V0.16B
    AESMC  V0.16B, V1.16B
    SHA256H  Q27, Q20, V28.4S
    SHA1SU1  V18.4S, V19.4S
    SHA256SU0  V29.4S, V3.4S
    AESE  V19.16B, V10.16B
    AESD  V19.16B, V22.16B
    AESE  V10.16B, V29.16B
    AESE  V9.16B, V16.16B
    SHA1SU1  V14.4S, V31.4S
    SHA1P  Q10, S21, V17.4S
    AESD  V23.16B, V9.16B
    SHA256H  Q31, Q22, V4.4S
    SHA256SU0  V24.4S, V3.4S
    AESIMC  V15.16B, V0.16B
    AESE  V27.16B, V17.16B
    SHA1SU1  V5.4S, V4.4S
    SHA256H2  Q24, Q11, V16.4S
    SHA256H2  Q24, Q26, V13.4S
    SHA256SU0  V8.4S, V7.4S
    SHA1SU0  V8.4S, V19.4S, V26.4S
    SHA256SU0  V0.4S, V30.4S
    SHA1SU0  V10.4S, V0.4S, V5.4S
    AESE  V27.16B, V7.16B
    AESD  V0.16B, V3.16B
    SHA1SU0  V4.4S, V1.4S, V2.4S
    SHA256H  Q14, Q26, V7.4S
    AESIMC  V28.16B, V8.16B
    SHA1C  Q5, S17, V8.4S
    SHA256H  Q8, Q6, V14.4S
    AESE  V8.16B, V2.16B
    SUBS  X3, X3, #0x1
    B.NE  TaishanSimdUnaryArithmeticP01_label_166
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X16, X13, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X23, X29, X4
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X24, X23, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X26, X8, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X27, X29, X7
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X16, X5, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X29, X25, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X28, X8, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X26, X4, X11
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X8, X10, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X28, X8, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X15, X11, X15
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X2, X19, X17
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X10, X24, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X21, X7, X19
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X12, X3, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X21
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X26, X29, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X19, X8, X24
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X27, X15, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X23, X10, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X6, X29, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X24, #0x4db6, LSL #0
    MOVK  X24, #0xa3c8, LSL #16
    MOVK  X24, #0x860a, LSL #32
    MOVK  X24, #0x83c9, LSL #48
    SUB  X4, X24, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, D2
    MOVZ  X24, #0x8dc6, LSL #0
    MOVK  X24, #0xa5c1, LSL #16
    MOVK  X24, #0x112f, LSL #32
    MOVK  X24, #0xc9fd, LSL #48
    SUB  X4, X24, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X19, #0x5c90, LSL #0
    MOVK  X19, #0x6913, LSL #16
    MOVK  X19, #0xd453, LSL #32
    MOVK  X19, #0x18a0, LSL #48
    SUB  X18, X19, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, D3
    MOVZ  X19, #0xca70, LSL #0
    MOVK  X19, #0xbb09, LSL #16
    MOVK  X19, #0x7b51, LSL #32
    MOVK  X19, #0xbb33, LSL #48
    SUB  X18, X19, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X26, #0x63c6, LSL #0
    MOVK  X26, #0x3644, LSL #16
    MOVK  X26, #0x430, LSL #32
    MOVK  X26, #0xbc74, LSL #48
    SUB  X5, X26, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, D4
    MOVZ  X26, #0x9be, LSL #0
    MOVK  X26, #0xa8e7, LSL #16
    MOVK  X26, #0xac70, LSL #32
    MOVK  X26, #0xfec1, LSL #48
    SUB  X5, X26, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X8, #0xd77c, LSL #0
    MOVK  X8, #0xf2d4, LSL #16
    MOVK  X8, #0x9f67, LSL #32
    MOVK  X8, #0x9867, LSL #48
    SUB  X3, X8, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, D5
    MOVZ  X8, #0x3daa, LSL #0
    MOVK  X8, #0x2803, LSL #16
    MOVK  X8, #0x8dfb, LSL #32
    MOVK  X8, #0x9932, LSL #48
    SUB  X3, X8, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xe69a, LSL #32
    MOVK  X21, #0x3d96, LSL #48
    SUB  X27, X21, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D6
    MOVZ  X21, #0xa4eb, LSL #0
    MOVK  X21, #0xacfb, LSL #16
    SUB  X27, X21, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, V7.D[1]
    MOVZ  X5, #0x1b46, LSL #0
    MOVK  X5, #0x7bc3, LSL #16
    MOVK  X5, #0x24b3, LSL #32
    MOVK  X5, #0xb4ee, LSL #48
    SUB  X3, X5, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, D7
    MOVZ  X5, #0x170a, LSL #0
    MOVK  X5, #0x4b64, LSL #16
    MOVK  X5, #0x69da, LSL #32
    MOVK  X5, #0xba2d, LSL #48
    SUB  X3, X5, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X10, V8.D[1]
    MOVZ  X3, #0x883d, LSL #0
    MOVK  X3, #0x4570, LSL #16
    MOVK  X3, #0x1c40, LSL #32
    MOVK  X3, #0x3e3b, LSL #48
    SUB  X24, X3, X10
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X10, D8
    MOVZ  X3, #0x4579, LSL #0
    MOVK  X3, #0x7226, LSL #16
    MOVK  X3, #0xf965, LSL #32
    MOVK  X3, #0xe67, LSL #48
    SUB  X24, X3, X10
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X8, #0x11fa, LSL #0
    MOVK  X8, #0xc410, LSL #16
    MOVK  X8, #0x61a4, LSL #32
    MOVK  X8, #0x5fa9, LSL #48
    SUB  X16, X8, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, D9
    MOVZ  X8, #0x9a89, LSL #0
    MOVK  X8, #0xd8b, LSL #16
    MOVK  X8, #0x5830, LSL #32
    MOVK  X8, #0xb1d7, LSL #48
    SUB  X16, X8, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X27, #0x251b, LSL #0
    MOVK  X27, #0xde2f, LSL #16
    MOVK  X27, #0x2f7d, LSL #32
    MOVK  X27, #0x1c23, LSL #48
    SUB  X9, X27, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, D10
    MOVZ  X27, #0x444b, LSL #0
    MOVK  X27, #0xc9c4, LSL #16
    MOVK  X27, #0x205e, LSL #32
    MOVK  X27, #0x3274, LSL #48
    SUB  X9, X27, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X25, #0x57d5, LSL #0
    MOVK  X25, #0x66d2, LSL #16
    MOVK  X25, #0x2495, LSL #32
    MOVK  X25, #0xd0ae, LSL #48
    SUB  X18, X25, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, D11
    MOVZ  X25, #0x8c17, LSL #0
    MOVK  X25, #0x5165, LSL #16
    MOVK  X25, #0x4772, LSL #32
    MOVK  X25, #0xa45, LSL #48
    SUB  X18, X25, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, V12.D[1]
    MOVZ  X10, #0xdd78, LSL #0
    MOVK  X10, #0xf41, LSL #16
    MOVK  X10, #0xede8, LSL #32
    MOVK  X10, #0x298, LSL #48
    SUB  X29, X10, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, D12
    MOVZ  X10, #0x623c, LSL #0
    MOVK  X10, #0x37cb, LSL #16
    MOVK  X10, #0x9d56, LSL #32
    MOVK  X10, #0xc4f8, LSL #48
    SUB  X29, X10, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, V13.D[1]
    MOVZ  X20, #0x8e27, LSL #0
    MOVK  X20, #0x7e5c, LSL #16
    MOVK  X20, #0x24ca, LSL #32
    MOVK  X20, #0x3e92, LSL #48
    SUB  X27, X20, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, D13
    MOVZ  X20, #0x93ff, LSL #0
    MOVK  X20, #0x62ab, LSL #16
    MOVK  X20, #0xeee8, LSL #32
    MOVK  X20, #0xc083, LSL #48
    SUB  X27, X20, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X19, #0x4498, LSL #0
    MOVK  X19, #0xa580, LSL #16
    MOVK  X19, #0x1028, LSL #32
    MOVK  X19, #0x7a82, LSL #48
    SUB  X18, X19, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, D14
    MOVZ  X19, #0x8670, LSL #0
    MOVK  X19, #0xfa33, LSL #16
    MOVK  X19, #0x28e5, LSL #32
    MOVK  X19, #0x8566, LSL #48
    SUB  X18, X19, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X26, #0x15c2, LSL #0
    MOVK  X26, #0xa36, LSL #16
    MOVK  X26, #0x987d, LSL #32
    MOVK  X26, #0x5228, LSL #48
    SUB  X14, X26, X4
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, D15
    MOVZ  X26, #0x8922, LSL #0
    MOVK  X26, #0x838a, LSL #16
    MOVK  X26, #0xa02c, LSL #32
    MOVK  X26, #0xc77, LSL #48
    SUB  X14, X26, X4
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, V16.D[1]
    MOVZ  X11, #0x34cf, LSL #0
    MOVK  X11, #0xa630, LSL #16
    MOVK  X11, #0xadd4, LSL #32
    MOVK  X11, #0xcabb, LSL #48
    SUB  X27, X11, X19
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, D16
    MOVZ  X11, #0xfe03, LSL #0
    MOVK  X11, #0x2298, LSL #16
    MOVK  X11, #0xffad, LSL #32
    MOVK  X11, #0x80, LSL #48
    SUB  X27, X11, X19
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, V17.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, D17
    MOVZ  X12, #0x8579, LSL #0
    MOVK  X12, #0xd7be, LSL #16
    SUB  X20, X12, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, V18.D[1]
    MOVZ  X28, #0xf817, LSL #0
    MOVK  X28, #0x4d78, LSL #16
    MOVK  X28, #0x3f72, LSL #32
    MOVK  X28, #0xfe13, LSL #48
    SUB  X29, X28, X25
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, D18
    MOVZ  X28, #0xe335, LSL #0
    MOVK  X28, #0x6ef6, LSL #16
    MOVK  X28, #0xa67d, LSL #32
    MOVK  X28, #0x6342, LSL #48
    SUB  X29, X28, X25
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X15, #0xe1dd, LSL #0
    MOVK  X15, #0x33f1, LSL #16
    MOVK  X15, #0x57af, LSL #32
    MOVK  X15, #0xf30a, LSL #48
    SUB  X27, X15, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, D19
    MOVZ  X15, #0x21ef, LSL #0
    MOVK  X15, #0x28c6, LSL #16
    MOVK  X15, #0xe1d5, LSL #32
    MOVK  X15, #0xeae0, LSL #48
    SUB  X27, X15, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, V20.D[1]
    MOVZ  X29, #0x355b, LSL #0
    MOVK  X29, #0x3084, LSL #16
    MOVK  X29, #0xf26b, LSL #32
    MOVK  X29, #0xee9a, LSL #48
    SUB  X11, X29, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, D20
    MOVZ  X29, #0x58f4, LSL #0
    MOVK  X29, #0xf156, LSL #16
    MOVK  X29, #0x8476, LSL #32
    MOVK  X29, #0xca7a, LSL #48
    SUB  X11, X29, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, V21.D[1]
    MOVZ  X9, #0x886, LSL #0
    MOVK  X9, #0xa2f6, LSL #16
    MOVK  X9, #0x966f, LSL #32
    MOVK  X9, #0x4b5f, LSL #48
    SUB  X23, X9, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, D21
    MOVZ  X9, #0x855a, LSL #0
    MOVK  X9, #0x3aee, LSL #16
    MOVK  X9, #0x24dd, LSL #32
    MOVK  X9, #0xee55, LSL #48
    SUB  X23, X9, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, V23.D[1]
    MOVZ  X27, #0x5e14, LSL #0
    MOVK  X27, #0x84e6, LSL #16
    MOVK  X27, #0xe31d, LSL #32
    MOVK  X27, #0xfe0d, LSL #48
    SUB  X18, X27, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, D23
    MOVZ  X27, #0xd8e4, LSL #0
    MOVK  X27, #0x567c, LSL #16
    MOVK  X27, #0x9608, LSL #32
    MOVK  X27, #0x88b7, LSL #48
    SUB  X18, X27, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, V24.D[1]
    MOVZ  X6, #0xf01b, LSL #0
    MOVK  X6, #0x4373, LSL #16
    MOVK  X6, #0xaba1, LSL #32
    MOVK  X6, #0xcc9d, LSL #48
    SUB  X20, X6, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, D24
    MOVZ  X6, #0xbe17, LSL #0
    MOVK  X6, #0x58cb, LSL #16
    MOVK  X6, #0xaa47, LSL #32
    MOVK  X6, #0x1368, LSL #48
    SUB  X20, X6, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, V25.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, D25
    MOVZ  X26, #0x1c9d, LSL #0
    MOVK  X26, #0x73c1, LSL #16
    SUB  X18, X26, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X6, #0x988a, LSL #0
    MOVK  X6, #0xf04c, LSL #16
    MOVK  X6, #0xfb00, LSL #32
    MOVK  X6, #0x4603, LSL #48
    SUB  X18, X6, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, D26
    MOVZ  X6, #0xd7c, LSL #0
    MOVK  X6, #0xdb26, LSL #16
    MOVK  X6, #0x3129, LSL #32
    MOVK  X6, #0x366b, LSL #48
    SUB  X18, X6, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, V27.D[1]
    MOVZ  X2, #0xf97f, LSL #0
    MOVK  X2, #0x11c1, LSL #16
    MOVK  X2, #0xbd16, LSL #32
    MOVK  X2, #0xa72d, LSL #48
    SUB  X4, X2, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, D27
    MOVZ  X2, #0xabfa, LSL #0
    MOVK  X2, #0x495d, LSL #16
    MOVK  X2, #0x555, LSL #32
    MOVK  X2, #0xed26, LSL #48
    SUB  X4, X2, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, V28.D[1]
    MOVZ  X15, #0x1bd5, LSL #0
    MOVK  X15, #0x1b3d, LSL #16
    MOVK  X15, #0xa06e, LSL #32
    MOVK  X15, #0x16c9, LSL #48
    SUB  X14, X15, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, D28
    MOVZ  X15, #0x6ca0, LSL #0
    MOVK  X15, #0x2c86, LSL #16
    MOVK  X15, #0x8d5c, LSL #32
    MOVK  X15, #0x1717, LSL #48
    SUB  X14, X15, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x418, LSL #32
    MOVK  X5, #0x848b, LSL #48
    SUB  X16, X5, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, D29
    MOVZ  X5, #0x42b8, LSL #0
    MOVK  X5, #0x2d81, LSL #16
    SUB  X16, X5, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X2, #0x1ebc, LSL #0
    MOVK  X2, #0x8510, LSL #16
    MOVK  X2, #0xd33f, LSL #32
    MOVK  X2, #0x299e, LSL #48
    MOVZ  X3, #0x34a3, LSL #0
    MOVK  X3, #0x92c1, LSL #16
    MOVK  X3, #0xd492, LSL #32
    MOVK  X3, #0xaa89, LSL #48
    MOVZ  X4, #0x175d, LSL #0
    MOVK  X4, #0xe867, LSL #16
    MOVK  X4, #0x8f9, LSL #32
    MOVK  X4, #0xd988, LSL #48
    MOVZ  X5, #0xba5c, LSL #0
    MOVK  X5, #0xf2fc, LSL #16
    MOVK  X5, #0x232a, LSL #32
    MOVK  X5, #0x5a0b, LSL #48
    MOVZ  X6, #0x1a93, LSL #0
    MOVK  X6, #0x9581, LSL #16
    MOVK  X6, #0x93ca, LSL #32
    MOVK  X6, #0xc336, LSL #48
    MOVZ  X7, #0x6681, LSL #0
    MOVK  X7, #0x15e2, LSL #16
    MOVK  X7, #0x311c, LSL #32
    MOVK  X7, #0x4eab, LSL #48
    MOVZ  X8, #0x5702, LSL #0
    MOVK  X8, #0xaad7, LSL #16
    MOVK  X8, #0xeb99, LSL #32
    MOVK  X8, #0xeeaf, LSL #48
    MOVZ  X9, #0x23a, LSL #0
    MOVK  X9, #0xba19, LSL #16
    MOVK  X9, #0x8556, LSL #32
    MOVK  X9, #0x1e2f, LSL #48
    MOVZ  X10, #0x7e6, LSL #0
    MOVK  X10, #0x136a, LSL #16
    MOVK  X10, #0xa485, LSL #32
    MOVK  X10, #0x3b2f, LSL #48
    MOVZ  X11, #0xbe6d, LSL #0
    MOVK  X11, #0x2b4e, LSL #16
    MOVK  X11, #0xa4ac, LSL #32
    MOVK  X11, #0xe1b6, LSL #48
    MOVZ  X12, #0x58ec, LSL #0
    MOVK  X12, #0x516a, LSL #16
    MOVK  X12, #0xb136, LSL #32
    MOVK  X12, #0x580a, LSL #48
    MOVZ  X13, #0x153f, LSL #0
    MOVK  X13, #0x265e, LSL #16
    MOVK  X13, #0xab66, LSL #32
    MOVK  X13, #0xcfbe, LSL #48
    MOVZ  X14, #0xf4a3, LSL #0
    MOVK  X14, #0xd99e, LSL #16
    MOVK  X14, #0x489, LSL #32
    MOVK  X14, #0xc122, LSL #48
    MOVZ  X15, #0xe628, LSL #0
    MOVK  X15, #0x41fe, LSL #16
    MOVK  X15, #0x54f3, LSL #32
    MOVK  X15, #0xac0a, LSL #48
    MOVZ  X16, #0x64b5, LSL #0
    MOVK  X16, #0xd428, LSL #16
    MOVK  X16, #0xa7fc, LSL #32
    MOVK  X16, #0x7c61, LSL #48
    MOVZ  X17, #0xa0fd, LSL #0
    MOVK  X17, #0xc6ec, LSL #16
    MOVK  X17, #0xb247, LSL #32
    MOVK  X17, #0x2697, LSL #48
    MOVZ  X18, #0x67c4, LSL #0
    MOVK  X18, #0xba56, LSL #16
    MOVK  X18, #0xc256, LSL #32
    MOVK  X18, #0x23a3, LSL #48
    MOVZ  X19, #0x5fa, LSL #0
    MOVK  X19, #0xa10d, LSL #16
    MOVK  X19, #0xa8e8, LSL #32
    MOVK  X19, #0x8475, LSL #48
    MOVZ  X20, #0xac2f, LSL #0
    MOVK  X20, #0x8e96, LSL #16
    MOVK  X20, #0x1566, LSL #32
    MOVK  X20, #0x8381, LSL #48
    MOVZ  X21, #0x1d62, LSL #0
    MOVK  X21, #0x77a3, LSL #16
    MOVK  X21, #0xe2c1, LSL #32
    MOVK  X21, #0x3ee5, LSL #48
    MOVZ  X23, #0xdee5, LSL #0
    MOVK  X23, #0xd541, LSL #16
    MOVK  X23, #0x68e8, LSL #32
    MOVK  X23, #0x3890, LSL #48
    MOVZ  X24, #0x8a8, LSL #0
    MOVK  X24, #0xf67a, LSL #16
    MOVK  X24, #0x4f21, LSL #32
    MOVK  X24, #0xfb, LSL #48
    MOVZ  X25, #0x46c1, LSL #0
    MOVK  X25, #0xdde5, LSL #16
    MOVK  X25, #0xa9dc, LSL #32
    MOVK  X25, #0xbbc3, LSL #48
    MOVZ  X26, #0xcbdd, LSL #0
    MOVK  X26, #0xeea, LSL #16
    MOVK  X26, #0x4e4, LSL #32
    MOVK  X26, #0xe5be, LSL #48
    MOVZ  X27, #0x5b25, LSL #0
    MOVK  X27, #0x4112, LSL #16
    MOVK  X27, #0x9fb6, LSL #32
    MOVK  X27, #0xd2d, LSL #48
    MOVZ  X28, #0x42e1, LSL #0
    MOVK  X28, #0xdfa2, LSL #16
    MOVK  X28, #0x98d2, LSL #32
    MOVK  X28, #0x3aa4, LSL #48
    MOVZ  X29, #0x6123, LSL #0
    MOVK  X29, #0xf59f, LSL #16
    MOVK  X29, #0xac42, LSL #32
    MOVK  X29, #0xca08, LSL #48
    FMOV  D0, X18
    FMOV  V0.D[1], X4
    FMOV  D1, X6
    FMOV  V1.D[1], X7
    FMOV  D2, X15
    FMOV  V2.D[1], X28
    FMOV  D3, X25
    FMOV  V3.D[1], X29
    FMOV  D4, X7
    FMOV  V4.D[1], X27
    FMOV  D5, X14
    FMOV  V5.D[1], X26
    FMOV  D6, X14
    FMOV  V6.D[1], X21
    FMOV  D7, X19
    FMOV  V7.D[1], X21
    FMOV  D8, X3
    FMOV  V8.D[1], X21
    FMOV  D9, X7
    FMOV  V9.D[1], X5
    FMOV  D10, X21
    FMOV  V10.D[1], X11
    FMOV  D11, X25
    FMOV  V11.D[1], X26
    FMOV  D12, X24
    FMOV  V12.D[1], X11
    FMOV  D13, X26
    FMOV  V13.D[1], X23
    FMOV  D14, X14
    FMOV  V14.D[1], X21
    FMOV  D15, X7
    FMOV  V15.D[1], X18
    FMOV  D16, X6
    FMOV  V16.D[1], X20
    FMOV  D17, X29
    FMOV  V17.D[1], X26
    FMOV  D18, X27
    FMOV  V18.D[1], X6
    FMOV  D19, X3
    FMOV  V19.D[1], X4
    FMOV  D20, X18
    FMOV  V20.D[1], X2
    FMOV  D21, X27
    FMOV  V21.D[1], X6
    FMOV  D22, X23
    FMOV  V22.D[1], X21
    FMOV  D23, X6
    FMOV  V23.D[1], X17
    FMOV  D24, X15
    FMOV  V24.D[1], X7
    FMOV  D25, X13
    FMOV  V25.D[1], X19
    FMOV  D26, X13
    FMOV  V26.D[1], X24
    FMOV  D27, X11
    FMOV  V27.D[1], X15
    FMOV  D28, X28
    FMOV  V28.D[1], X13
    FMOV  D29, X19
    FMOV  V29.D[1], X21
    FMOV  D30, X13
    FMOV  V30.D[1], X20
    FMOV  D31, X19
    FMOV  V31.D[1], X2
    MOVZ  X6, #0xa, LSL #0
TaishanSimdUnaryArithmeticP01_label_249:
    SHA1SU1  V14.4S, V25.4S
    SHA256SU1  V13.4S, V25.4S, V14.4S
    SHA1SU1  V12.4S, V30.4S
    AESMC  V28.16B, V27.16B
    SHA1M  Q18, S21, V9.4S
    SHA256H2  Q25, Q11, V10.4S
    SHA256H  Q10, Q14, V29.4S
    SHA1SU0  V0.4S, V14.4S, V10.4S
    SHA256SU0  V28.4S, V0.4S
    SHA256SU1  V30.4S, V7.4S, V13.4S
    SHA1C  Q25, S25, V12.4S
    AESIMC  V18.16B, V17.16B
    AESE  V25.16B, V18.16B
    SHA256SU1  V28.4S, V5.4S, V19.4S
    SHA1C  Q22, S18, V4.4S
    AESE  V15.16B, V28.16B
    AESE  V5.16B, V24.16B
    AESD  V2.16B, V5.16B
    SHA1P  Q7, S24, V11.4S
    AESE  V11.16B, V20.16B
    SHA1H  S5, S14
    SHA256SU0  V28.4S, V9.4S
    SHA1H  S2, S18
    AESIMC  V29.16B, V2.16B
    AESIMC  V16.16B, V25.16B
    SHA1C  Q31, S16, V6.4S
    SHA256H  Q22, Q23, V29.4S
    SHA1SU1  V22.4S, V7.4S
    AESMC  V13.16B, V12.16B
    SHA1M  Q23, S9, V30.4S
    SHA256H  Q15, Q0, V1.4S
    AESE  V10.16B, V31.16B
    SHA256H  Q22, Q0, V14.4S
    SHA256H2  Q9, Q24, V13.4S
    SHA1SU1  V17.4S, V19.4S
    SHA256SU0  V4.4S, V31.4S
    SHA256H2  Q1, Q8, V17.4S
    SHA1M  Q15, S15, V15.4S
    AESIMC  V17.16B, V21.16B
    SHA1SU0  V31.4S, V4.4S, V0.4S
    SHA1M  Q16, S4, V24.4S
    SHA1SU1  V23.4S, V28.4S
    SHA1P  Q6, S5, V2.4S
    AESIMC  V25.16B, V1.16B
    SHA1SU0  V16.4S, V4.4S, V19.4S
    SHA256SU0  V31.4S, V9.4S
    AESIMC  V0.16B, V0.16B
    SHA1P  Q2, S22, V18.4S
    SHA1H  S1, S14
    SHA1SU0  V18.4S, V1.4S, V9.4S
    SHA256H2  Q21, Q15, V8.4S
    SHA1SU0  V18.4S, V26.4S, V26.4S
    SHA1SU0  V23.4S, V11.4S, V18.4S
    AESIMC  V15.16B, V27.16B
    SHA256SU1  V30.4S, V24.4S, V23.4S
    SHA256SU1  V2.4S, V0.4S, V23.4S
    SHA1SU1  V18.4S, V23.4S
    SHA256H2  Q15, Q27, V22.4S
    SHA1C  Q17, S2, V8.4S
    SHA256H2  Q4, Q3, V5.4S
    SHA256H  Q21, Q0, V25.4S
    SHA256SU0  V14.4S, V7.4S
    SHA1SU0  V23.4S, V20.4S, V22.4S
    SHA1H  S27, S4
    SHA256H  Q22, Q8, V22.4S
    SHA1C  Q15, S10, V1.4S
    SHA1C  Q16, S9, V11.4S
    SHA1C  Q21, S15, V9.4S
    AESD  V24.16B, V16.16B
    SHA1C  Q15, S6, V24.4S
    AESMC  V15.16B, V6.16B
    SHA1SU1  V20.4S, V10.4S
    AESMC  V19.16B, V19.16B
    AESE  V26.16B, V15.16B
    SHA1SU0  V2.4S, V25.4S, V10.4S
    SHA256H2  Q29, Q26, V14.4S
    SHA1C  Q5, S18, V3.4S
    SHA1M  Q7, S19, V31.4S
    AESIMC  V12.16B, V0.16B
    SHA256SU1  V2.4S, V17.4S, V31.4S
    SHA256H2  Q28, Q30, V11.4S
    SHA1M  Q7, S16, V28.4S
    SHA256H  Q18, Q2, V29.4S
    SHA256H  Q28, Q18, V13.4S
    SHA256SU1  V16.4S, V28.4S, V4.4S
    SHA1M  Q19, S19, V28.4S
    SHA1SU1  V0.4S, V7.4S
    SHA1H  S6, S30
    SHA1C  Q9, S21, V16.4S
    SHA1H  S19, S25
    SHA1SU1  V23.4S, V4.4S
    AESE  V27.16B, V3.16B
    SHA256H2  Q17, Q26, V13.4S
    AESIMC  V12.16B, V14.16B
    AESE  V22.16B, V11.16B
    SHA1SU1  V2.4S, V27.4S
    SHA256H  Q20, Q3, V21.4S
    AESMC  V13.16B, V0.16B
    AESMC  V14.16B, V29.16B
    SHA256SU1  V24.4S, V6.4S, V6.4S
    AESIMC  V6.16B, V19.16B
    AESIMC  V4.16B, V9.16B
    SHA1SU0  V7.4S, V5.4S, V13.4S
    AESE  V9.16B, V23.16B
    SHA1P  Q30, S14, V1.4S
    SHA256H2  Q21, Q27, V12.4S
    SHA1SU1  V18.4S, V17.4S
    SHA1SU0  V21.4S, V27.4S, V25.4S
    SHA1SU1  V5.4S, V3.4S
    SHA256SU1  V24.4S, V31.4S, V26.4S
    SHA256SU0  V5.4S, V22.4S
    SHA1P  Q6, S6, V15.4S
    SHA256H2  Q17, Q18, V29.4S
    SHA1SU1  V23.4S, V31.4S
    SHA256SU1  V22.4S, V24.4S, V12.4S
    AESD  V23.16B, V29.16B
    SHA1M  Q28, S18, V2.4S
    SHA1M  Q9, S21, V15.4S
    SHA1SU0  V20.4S, V7.4S, V19.4S
    SHA1C  Q30, S11, V26.4S
    SHA1H  S17, S19
    AESMC  V9.16B, V27.16B
    SHA1M  Q21, S26, V7.4S
    AESIMC  V9.16B, V26.16B
    SHA256H  Q3, Q5, V27.4S
    SHA1M  Q23, S28, V5.4S
    SHA1P  Q7, S26, V30.4S
    SHA1C  Q8, S15, V18.4S
    SHA1M  Q19, S14, V19.4S
    SHA256SU0  V20.4S, V20.4S
    SHA1C  Q13, S25, V24.4S
    AESD  V25.16B, V0.16B
    AESE  V13.16B, V0.16B
    SHA1SU0  V22.4S, V23.4S, V10.4S
    SHA1P  Q13, S7, V10.4S
    AESIMC  V27.16B, V17.16B
    SHA1SU1  V14.4S, V23.4S
    SHA256SU1  V29.4S, V9.4S, V25.4S
    AESMC  V29.16B, V10.16B
    AESMC  V2.16B, V5.16B
    AESE  V28.16B, V11.16B
    SHA256H  Q21, Q25, V23.4S
    AESIMC  V14.16B, V28.16B
    AESD  V19.16B, V13.16B
    SHA1M  Q24, S9, V23.4S
    AESD  V30.16B, V21.16B
    SHA1M  Q13, S31, V2.4S
    SHA1SU1  V8.4S, V15.4S
    SHA256H  Q20, Q29, V29.4S
    SHA1M  Q6, S7, V19.4S
    AESIMC  V28.16B, V5.16B
    SHA256SU1  V8.4S, V12.4S, V10.4S
    SHA1H  S2, S17
    AESE  V9.16B, V30.16B
    SHA1P  Q22, S8, V13.4S
    SHA1H  S24, S10
    SHA256H2  Q14, Q19, V12.4S
    SHA256H2  Q27, Q22, V20.4S
    SHA256SU0  V13.4S, V16.4S
    SHA1M  Q9, S1, V4.4S
    SHA256H  Q9, Q16, V28.4S
    SHA1M  Q17, S0, V2.4S
    SHA1SU0  V30.4S, V4.4S, V17.4S
    AESD  V25.16B, V5.16B
    AESE  V20.16B, V6.16B
    SHA1M  Q9, S27, V31.4S
    SHA1H  S16, S4
    SHA256H  Q15, Q0, V24.4S
    SHA1SU0  V23.4S, V4.4S, V30.4S
    SHA1M  Q25, S28, V3.4S
    SHA256SU1  V1.4S, V19.4S, V20.4S
    SHA1SU1  V15.4S, V31.4S
    SHA256SU1  V23.4S, V3.4S, V23.4S
    AESD  V16.16B, V27.16B
    SHA256SU0  V24.4S, V9.4S
    SHA1H  S20, S15
    SHA1SU1  V1.4S, V28.4S
    AESD  V6.16B, V13.16B
    AESD  V21.16B, V0.16B
    SHA1M  Q30, S15, V0.4S
    AESD  V20.16B, V30.16B
    AESMC  V20.16B, V21.16B
    AESE  V17.16B, V21.16B
    SHA256SU0  V28.4S, V15.4S
    SHA1SU1  V14.4S, V27.4S
    SHA1C  Q10, S11, V9.4S
    AESMC  V12.16B, V5.16B
    SHA1C  Q21, S11, V25.4S
    SHA256H2  Q22, Q2, V25.4S
    SHA256H  Q31, Q15, V28.4S
    AESE  V20.16B, V22.16B
    AESE  V22.16B, V23.16B
    AESIMC  V20.16B, V16.16B
    SHA1C  Q21, S6, V11.4S
    SHA1C  Q9, S26, V17.4S
    SHA256SU1  V22.4S, V23.4S, V24.4S
    AESIMC  V10.16B, V2.16B
    SHA1P  Q24, S9, V5.4S
    SHA256SU0  V15.4S, V21.4S
    SHA256H  Q17, Q30, V19.4S
    SUBS  X6, X6, #0x1
    B.NE  TaishanSimdUnaryArithmeticP01_label_249
    MOVZ  X14, #0x1ebc, LSL #0
    MOVK  X14, #0x8510, LSL #16
    MOVK  X14, #0xd33f, LSL #32
    MOVK  X14, #0x299e, LSL #48
    SUB  X15, X14, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X8, #0x34a3, LSL #0
    MOVK  X8, #0x92c1, LSL #16
    MOVK  X8, #0xd492, LSL #32
    MOVK  X8, #0xaa89, LSL #48
    SUB  X27, X8, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X13, #0x175d, LSL #0
    MOVK  X13, #0xe867, LSL #16
    MOVK  X13, #0x8f9, LSL #32
    MOVK  X13, #0xd988, LSL #48
    SUB  X21, X13, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X28, #0xba5c, LSL #0
    MOVK  X28, #0xf2fc, LSL #16
TaishanSimdUnaryArithmeticP01_label_14:
    MOVK  X28, #0x232a, LSL #32
    MOVK  X28, #0x5a0b, LSL #48
    SUB  X26, X28, X5
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X29, X4, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X11, #0x6681, LSL #0
    MOVK  X11, #0x15e2, LSL #16
    MOVK  X11, #0x311c, LSL #32
    MOVK  X11, #0x4eab, LSL #48
    SUB  X21, X11, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X13, #0x34a3, LSL #0
    MOVK  X13, #0x92c1, LSL #16
    MOVK  X13, #0xd492, LSL #32
    MOVK  X13, #0xaa89, LSL #48
    SUB  X4, X13, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X16, #0x23a, LSL #0
    MOVK  X16, #0xba19, LSL #16
    MOVK  X16, #0x8556, LSL #32
    MOVK  X16, #0x1e2f, LSL #48
    SUB  X29, X16, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X15, #0x7e6, LSL #0
    MOVK  X15, #0x136a, LSL #16
    MOVK  X15, #0xa485, LSL #32
    MOVK  X15, #0x3b2f, LSL #48
    SUB  X3, X15, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X23, #0x6681, LSL #0
    MOVK  X23, #0x15e2, LSL #16
    MOVK  X23, #0x311c, LSL #32
    MOVK  X23, #0x4eab, LSL #48
    SUB  X20, X23, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X18, #0x58ec, LSL #0
    MOVK  X18, #0x516a, LSL #16
    MOVK  X18, #0xb136, LSL #32
    MOVK  X18, #0x580a, LSL #48
    SUB  X20, X18, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X5, #0x34a3, LSL #0
    MOVK  X5, #0x92c1, LSL #16
    MOVK  X5, #0xd492, LSL #32
    MOVK  X5, #0xaa89, LSL #48
    SUB  X25, X5, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X16, #0x1ebc, LSL #0
    MOVK  X16, #0x8510, LSL #16
    MOVK  X16, #0xd33f, LSL #32
    MOVK  X16, #0x299e, LSL #48
    SUB  X14, X16, X14
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X13, #0x7e6, LSL #0
    MOVK  X13, #0x136a, LSL #16
    MOVK  X13, #0xa485, LSL #32
    MOVK  X13, #0x3b2f, LSL #48
    SUB  X7, X13, X15
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X9, #0x1ebc, LSL #0
    MOVK  X9, #0x8510, LSL #16
    MOVK  X9, #0xd33f, LSL #32
    MOVK  X9, #0x299e, LSL #48
    SUB  X7, X9, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X14, #0xa0fd, LSL #0
    MOVK  X14, #0xc6ec, LSL #16
    MOVK  X14, #0xb247, LSL #32
    MOVK  X14, #0x2697, LSL #48
    SUB  X18, X14, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X10, #0x5fa, LSL #0
    MOVK  X10, #0xa10d, LSL #16
    MOVK  X10, #0xa8e8, LSL #32
    MOVK  X10, #0x8475, LSL #48
    SUB  X8, X10, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X20
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X8, #0x6681, LSL #0
    MOVK  X8, #0x15e2, LSL #16
    MOVK  X8, #0x311c, LSL #32
    MOVK  X8, #0x4eab, LSL #48
    SUB  X17, X8, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X23, #0x8a8, LSL #0
    MOVK  X23, #0xf67a, LSL #16
    MOVK  X23, #0x4f21, LSL #32
    MOVK  X23, #0xfb, LSL #48
    SUB  X27, X23, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X9, X20, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X11, X3, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, D2
    MOVZ  X3, #0x26f1, LSL #0
    MOVK  X3, #0x1225, LSL #16
    SUB  X11, X3, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, V3.D[1]
    MOVZ  X8, #0xe07e, LSL #0
    MOVK  X8, #0x6186, LSL #16
    MOVK  X8, #0x4468, LSL #32
    MOVK  X8, #0x810d, LSL #48
    SUB  X11, X8, X25
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, D3
    MOVZ  X8, #0xcda5, LSL #0
    MOVK  X8, #0x8491, LSL #16
    MOVK  X8, #0x4998, LSL #32
    MOVK  X8, #0xff9c, LSL #48
    SUB  X11, X8, X25
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X19, #0x21e9, LSL #0
    MOVK  X19, #0x6fa8, LSL #16
    MOVK  X19, #0x6247, LSL #32
    MOVK  X19, #0x20a6, LSL #48
    SUB  X16, X19, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, D4
    MOVZ  X19, #0xfa06, LSL #0
    MOVK  X19, #0xa5b8, LSL #16
    MOVK  X19, #0xc0ef, LSL #32
    MOVK  X19, #0xfc34, LSL #48
    SUB  X16, X19, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X9, #0x6253, LSL #0
    MOVK  X9, #0x91cd, LSL #16
    MOVK  X9, #0xa318, LSL #32
    MOVK  X9, #0xf6aa, LSL #48
    SUB  X19, X9, X28
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, D5
    MOVZ  X9, #0xd771, LSL #0
    MOVK  X9, #0x19d1, LSL #16
    MOVK  X9, #0xe886, LSL #32
    MOVK  X9, #0xa401, LSL #48
    SUB  X19, X9, X28
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, V6.D[1]
    MOVZ  X4, #0xde08, LSL #0
    MOVK  X4, #0xc070, LSL #16
    MOVK  X4, #0xf6ac, LSL #32
    MOVK  X4, #0xb043, LSL #48
    SUB  X29, X4, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, D6
    MOVZ  X4, #0xf38f, LSL #0
    MOVK  X4, #0x6963, LSL #16
    MOVK  X4, #0x7229, LSL #32
    MOVK  X4, #0x8980, LSL #48
    SUB  X29, X4, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X21, #0xdeed, LSL #0
    MOVK  X21, #0x9517, LSL #16
    MOVK  X21, #0xecd9, LSL #32
    MOVK  X21, #0x4e23, LSL #48
    SUB  X29, X21, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D7
    MOVZ  X21, #0x321e, LSL #0
    MOVK  X21, #0x37f8, LSL #16
    MOVK  X21, #0x4d2b, LSL #32
    MOVK  X21, #0x3d72, LSL #48
    SUB  X29, X21, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, V8.D[1]
    MOVZ  X14, #0xb1dc, LSL #0
    MOVK  X14, #0x31c2, LSL #16
    MOVK  X14, #0x623a, LSL #32
    MOVK  X14, #0x50e7, LSL #48
    SUB  X7, X14, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, D8
    MOVZ  X14, #0x46f8, LSL #0
    MOVK  X14, #0x8f4f, LSL #16
    MOVK  X14, #0xa087, LSL #32
    MOVK  X14, #0xd37e, LSL #48
    SUB  X7, X14, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X6, #0xeca, LSL #0
    MOVK  X6, #0x887f, LSL #16
    MOVK  X6, #0xd019, LSL #32
    MOVK  X6, #0xc83, LSL #48
    SUB  X24, X6, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D9
    MOVZ  X6, #0xb70, LSL #0
    MOVK  X6, #0xd5de, LSL #16
    MOVK  X6, #0x2728, LSL #32
    MOVK  X6, #0xf552, LSL #48
    SUB  X24, X6, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, V10.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, D10
    MOVZ  X26, #0x5198, LSL #0
    MOVK  X26, #0xbe97, LSL #16
    SUB  X28, X26, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X20, #0x4066, LSL #0
    MOVK  X20, #0x732b, LSL #16
    MOVK  X20, #0x41e4, LSL #32
    MOVK  X20, #0x8446, LSL #48
    SUB  X26, X20, X13
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, D11
    MOVZ  X20, #0xe1b8, LSL #0
    MOVK  X20, #0x4f9f, LSL #16
    MOVK  X20, #0xdc49, LSL #32
    MOVK  X20, #0xcb0d, LSL #48
    SUB  X26, X20, X13
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X5, #0x4a5c, LSL #0
    MOVK  X5, #0x6318, LSL #16
    MOVK  X5, #0x5692, LSL #32
    MOVK  X5, #0xd6f5, LSL #48
    SUB  X11, X5, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, D12
    MOVZ  X5, #0xb548, LSL #0
    MOVK  X5, #0xa734, LSL #16
    MOVK  X5, #0xea91, LSL #32
    MOVK  X5, #0x2b9b, LSL #48
    SUB  X11, X5, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, V13.D[1]
    MOVZ  X26, #0x6662, LSL #0
    MOVK  X26, #0xc0c4, LSL #16
    MOVK  X26, #0xc419, LSL #32
    MOVK  X26, #0x5f5, LSL #48
    SUB  X27, X26, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, D13
    MOVZ  X26, #0x70c4, LSL #0
    MOVK  X26, #0x663f, LSL #16
    MOVK  X26, #0x72db, LSL #32
    MOVK  X26, #0xdd93, LSL #48
    SUB  X27, X26, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, V14.D[1]
    MOVZ  X25, #0xa02a, LSL #0
    MOVK  X25, #0x447d, LSL #16
    MOVK  X25, #0x4b85, LSL #32
    MOVK  X25, #0x8dfb, LSL #48
    SUB  X29, X25, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, D14
    MOVZ  X25, #0x4a10, LSL #0
    MOVK  X25, #0x516, LSL #16
    MOVK  X25, #0x60ba, LSL #32
    MOVK  X25, #0x7950, LSL #48
    SUB  X29, X25, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X13, #0x4593, LSL #0
    MOVK  X13, #0x7669, LSL #16
    MOVK  X13, #0xf185, LSL #32
    MOVK  X13, #0x3b2f, LSL #48
    SUB  X20, X13, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, D15
    MOVZ  X13, #0xb930, LSL #0
    MOVK  X13, #0xc2f2, LSL #16
    MOVK  X13, #0xe9c6, LSL #32
    MOVK  X13, #0xba06, LSL #48
    SUB  X20, X13, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X14, #0xe4a, LSL #0
    MOVK  X14, #0xc54d, LSL #16
    MOVK  X14, #0x6a90, LSL #32
    MOVK  X14, #0xb62c, LSL #48
    SUB  X2, X14, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, D16
    MOVZ  X14, #0x2d6f, LSL #0
    MOVK  X14, #0x620, LSL #16
    MOVK  X14, #0x8ef1, LSL #32
    MOVK  X14, #0xa32a, LSL #48
    SUB  X2, X14, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, V17.D[1]
    MOVZ  X24, #0x4d04, LSL #0
    MOVK  X24, #0x5265, LSL #16
    MOVK  X24, #0x7c96, LSL #32
    MOVK  X24, #0x5172, LSL #48
    SUB  X23, X24, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, D17
    MOVZ  X24, #0xd1c7, LSL #0
    MOVK  X24, #0x1dae, LSL #16
    MOVK  X24, #0x2aa7, LSL #32
    MOVK  X24, #0x2531, LSL #48
    SUB  X23, X24, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X9, #0x7a0f, LSL #0
    MOVK  X9, #0x9f58, LSL #16
    MOVK  X9, #0xd581, LSL #32
    MOVK  X9, #0x3821, LSL #48
    SUB  X14, X9, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, D18
    MOVZ  X9, #0xb95f, LSL #0
    MOVK  X9, #0xef76, LSL #16
    MOVK  X9, #0x8e0f, LSL #32
    MOVK  X9, #0xc7db, LSL #48
    SUB  X14, X9, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, V19.D[1]
    MOVZ  X13, #0xbe74, LSL #0
    MOVK  X13, #0x3929, LSL #16
    MOVK  X13, #0x7326, LSL #32
    MOVK  X13, #0xde5c, LSL #48
    SUB  X23, X13, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, D19
    MOVZ  X13, #0x1730, LSL #0
    MOVK  X13, #0xf5ea, LSL #16
    MOVK  X13, #0xf154, LSL #32
    MOVK  X13, #0xce58, LSL #48
    SUB  X23, X13, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X6, #0x7f28, LSL #0
    MOVK  X6, #0x37ac, LSL #16
    MOVK  X6, #0xf6f4, LSL #32
    MOVK  X6, #0xea88, LSL #48
    SUB  X9, X6, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, D20
    MOVZ  X6, #0xf2a5, LSL #0
    MOVK  X6, #0x1122, LSL #16
    MOVK  X6, #0x6e49, LSL #32
    MOVK  X6, #0xb465, LSL #48
    SUB  X9, X6, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X4, #0x821e, LSL #0
    MOVK  X4, #0x2acf, LSL #16
    MOVK  X4, #0xd912, LSL #32
    MOVK  X4, #0x1253, LSL #48
    SUB  X18, X4, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, D21
    MOVZ  X4, #0xdbae, LSL #0
    MOVK  X4, #0xa838, LSL #16
    MOVK  X4, #0x7cd9, LSL #32
    MOVK  X4, #0x8b28, LSL #48
    SUB  X18, X4, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X13, #0x9064, LSL #0
    MOVK  X13, #0xd98d, LSL #16
    MOVK  X13, #0x3202, LSL #32
    MOVK  X13, #0x854e, LSL #48
    SUB  X19, X13, X16
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X16, D23
    MOVZ  X13, #0x18b5, LSL #0
    MOVK  X13, #0xc9e4, LSL #16
    MOVK  X13, #0x88e5, LSL #32
    MOVK  X13, #0x1b27, LSL #48
    SUB  X19, X13, X16
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, V24.D[1]
    MOVZ  X28, #0xf811, LSL #0
    MOVK  X28, #0xd64, LSL #16
    MOVK  X28, #0x3911, LSL #32
    MOVK  X28, #0xe413, LSL #48
    SUB  X6, X28, X3
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, D24
    MOVZ  X28, #0x91c2, LSL #0
    MOVK  X28, #0xd98c, LSL #16
    MOVK  X28, #0x75b6, LSL #32
    MOVK  X28, #0xd868, LSL #48
    SUB  X6, X28, X3
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X10, #0x525c, LSL #0
    MOVK  X10, #0xef57, LSL #16
    MOVK  X10, #0x4076, LSL #32
    MOVK  X10, #0x4632, LSL #48
    SUB  X4, X10, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D25
    MOVZ  X10, #0x453, LSL #0
    MOVK  X10, #0xbd28, LSL #16
    MOVK  X10, #0xf0d, LSL #32
    MOVK  X10, #0xa009, LSL #48
    SUB  X4, X10, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X29, #0x3ce7, LSL #0
    MOVK  X29, #0xf936, LSL #16
    MOVK  X29, #0x7ad0, LSL #32
    MOVK  X29, #0xb8fe, LSL #48
    SUB  X3, X29, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, D26
    MOVZ  X29, #0x635f, LSL #0
    MOVK  X29, #0x7d9c, LSL #16
    MOVK  X29, #0x592f, LSL #32
    MOVK  X29, #0x7bf2, LSL #48
    SUB  X3, X29, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X15, #0x2d6, LSL #0
    MOVK  X15, #0xab7, LSL #16
    MOVK  X15, #0xd860, LSL #32
    MOVK  X15, #0xa6e5, LSL #48
    SUB  X8, X15, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, D27
    MOVZ  X15, #0x2729, LSL #0
    MOVK  X15, #0xe78d, LSL #16
    MOVK  X15, #0xaba1, LSL #32
    MOVK  X15, #0x6f71, LSL #48
    SUB  X8, X15, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X10, #0xbf35, LSL #0
    MOVK  X10, #0x76df, LSL #16
    MOVK  X10, #0x2472, LSL #32
    MOVK  X10, #0xd5fc, LSL #48
    SUB  X13, X10, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, D28
    MOVZ  X10, #0x5cff, LSL #0
    MOVK  X10, #0x729d, LSL #16
    MOVK  X10, #0x6f8b, LSL #32
    MOVK  X10, #0x4fad, LSL #48
    SUB  X13, X10, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, V29.D[1]
    MOVZ  X3, #0xc59a, LSL #0
    MOVK  X3, #0x5eae, LSL #16
    MOVK  X3, #0xfeef, LSL #32
    MOVK  X3, #0xbd62, LSL #48
    SUB  X25, X3, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, D29
    MOVZ  X3, #0x6e00, LSL #0
    MOVK  X3, #0xa6fa, LSL #16
    MOVK  X3, #0x4b52, LSL #32
    MOVK  X3, #0xe2f3, LSL #48
    SUB  X25, X3, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
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
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X4
    FMOV  V0.D[1], X14
    FMOV  D1, X4
    FMOV  V1.D[1], X17
    FMOV  D2, X24
    FMOV  V2.D[1], X25
    FMOV  D3, X6
    FMOV  V3.D[1], X26
    FMOV  D4, X25
    FMOV  V4.D[1], X12
    FMOV  D5, X6
    FMOV  V5.D[1], X11
    FMOV  D6, X23
    FMOV  V6.D[1], X21
    FMOV  D7, X12
    FMOV  V7.D[1], X9
    FMOV  D8, X2
    FMOV  V8.D[1], X16
    FMOV  D9, X26
    FMOV  V9.D[1], X2
    FMOV  D10, X24
    FMOV  V10.D[1], X3
    FMOV  D11, X4
    FMOV  V11.D[1], X3
    FMOV  D12, X28
    FMOV  V12.D[1], X17
    FMOV  D13, X28
    FMOV  V13.D[1], X23
    FMOV  D14, X28
    FMOV  V14.D[1], X14
    FMOV  D15, X4
    FMOV  V15.D[1], X8
    FMOV  D16, X17
    FMOV  V16.D[1], X27
    FMOV  D17, X15
    FMOV  V17.D[1], X17
    FMOV  D18, X27
    FMOV  V18.D[1], X29
    FMOV  D19, X2
    FMOV  V19.D[1], X5
    FMOV  D20, X28
    FMOV  V20.D[1], X6
    FMOV  D21, X8
    FMOV  V21.D[1], X2
    FMOV  D22, X25
    FMOV  V22.D[1], X26
    FMOV  D23, X29
    FMOV  V23.D[1], X4
    FMOV  D24, X13
    FMOV  V24.D[1], X12
    FMOV  D25, X5
    FMOV  V25.D[1], X17
    FMOV  D26, X15
    FMOV  V26.D[1], X2
    FMOV  D27, X25
    FMOV  V27.D[1], X9
    FMOV  D28, X19
    FMOV  V28.D[1], X17
    FMOV  D29, X12
    FMOV  V29.D[1], X2
    FMOV  D30, X2
    FMOV  V30.D[1], X9
    FMOV  D31, X12
    FMOV  V31.D[1], X17
    MOVZ  X19, #0xa, LSL #0
TaishanSimdUnaryArithmeticP01_label_332:
    SHA1SU0  V17.4S, V23.4S, V3.4S
    SHA1SU0  V11.4S, V24.4S, V24.4S
    AESIMC  V5.16B, V31.16B
    SHA1H  S30, S11
    AESMC  V22.16B, V25.16B
    AESD  V29.16B, V17.16B
    AESE  V28.16B, V22.16B
    SHA256H  Q21, Q24, V5.4S
    SHA1H  S28, S0
    SHA1SU1  V23.4S, V27.4S
    AESD  V12.16B, V25.16B
    SHA1C  Q15, S14, V4.4S
    SHA1SU1  V21.4S, V1.4S
    AESD  V6.16B, V25.16B
    AESIMC  V1.16B, V21.16B
    SHA256SU0  V27.4S, V13.4S
    SHA1P  Q26, S28, V22.4S
    SHA256SU1  V15.4S, V20.4S, V24.4S
    AESIMC  V12.16B, V11.16B
    SHA1H  S28, S12
    AESMC  V6.16B, V31.16B
    AESIMC  V31.16B, V18.16B
    SHA256SU1  V27.4S, V0.4S, V0.4S
    SHA1SU1  V30.4S, V24.4S
    AESIMC  V3.16B, V27.16B
    AESIMC  V23.16B, V28.16B
    SHA256H2  Q21, Q29, V21.4S
    SHA1P  Q1, S4, V6.4S
    SHA1C  Q13, S20, V31.4S
    SHA1M  Q27, S0, V11.4S
    AESE  V17.16B, V4.16B
    SHA256H2  Q22, Q11, V24.4S
    AESIMC  V27.16B, V18.16B
    SHA1SU0  V18.4S, V12.4S, V20.4S
    AESMC  V30.16B, V31.16B
    SHA1C  Q15, S15, V3.4S
    SHA256SU1  V31.4S, V18.4S, V9.4S
    AESE  V2.16B, V1.16B
    AESMC  V2.16B, V3.16B
    SHA1H  S14, S14
    SHA1H  S30, S21
    SHA1M  Q31, S15, V23.4S
    SHA1M  Q1, S27, V6.4S
    AESE  V31.16B, V0.16B
    AESD  V9.16B, V20.16B
    SHA256SU1  V28.4S, V25.4S, V29.4S
    SHA256H2  Q21, Q3, V21.4S
    SHA1H  S22, S14
    SHA1SU0  V23.4S, V10.4S, V30.4S
    AESD  V4.16B, V2.16B
    SHA1SU1  V20.4S, V15.4S
    SHA256SU0  V27.4S, V24.4S
    SHA256H  Q23, Q13, V13.4S
    SHA1M  Q3, S27, V17.4S
    SHA256SU0  V3.4S, V18.4S
    SHA1SU0  V0.4S, V23.4S, V24.4S
    SHA256H  Q17, Q3, V5.4S
    SHA1SU1  V23.4S, V22.4S
    AESMC  V31.16B, V23.16B
    AESMC  V3.16B, V7.16B
    AESIMC  V7.16B, V6.16B
    AESIMC  V1.16B, V31.16B
    AESD  V21.16B, V1.16B
    AESD  V4.16B, V7.16B
    SHA256SU0  V20.4S, V9.4S
    SHA1H  S28, S17
    AESE  V14.16B, V12.16B
    SHA1P  Q3, S16, V22.4S
    SHA256H  Q6, Q4, V29.4S
    SHA1P  Q20, S15, V6.4S
    SHA1M  Q10, S21, V14.4S
    AESE  V0.16B, V25.16B
    AESIMC  V8.16B, V31.16B
    AESMC  V20.16B, V9.16B
    AESIMC  V9.16B, V3.16B
    SHA1H  S18, S20
    SHA1SU1  V31.4S, V6.4S
    SHA256SU0  V10.4S, V29.4S
    SHA1M  Q30, S28, V10.4S
    SHA1SU0  V25.4S, V26.4S, V7.4S
    SHA1C  Q19, S29, V0.4S
    SHA256H2  Q30, Q4, V15.4S
    SHA1SU1  V18.4S, V8.4S
    AESIMC  V26.16B, V25.16B
    SHA1SU1  V21.4S, V0.4S
    AESE  V18.16B, V23.16B
    SHA1C  Q28, S23, V13.4S
    SHA256SU0  V28.4S, V26.4S
    SHA256SU0  V19.4S, V31.4S
    SHA1SU0  V6.4S, V21.4S, V13.4S
    AESE  V7.16B, V19.16B
    SHA1H  S10, S27
    SHA256H  Q12, Q18, V26.4S
    SHA1SU0  V20.4S, V24.4S, V6.4S
    SHA256SU0  V30.4S, V21.4S
    AESE  V7.16B, V19.16B
    SHA1C  Q27, S31, V7.4S
    SHA1SU1  V21.4S, V30.4S
    AESE  V22.16B, V10.16B
    SHA1P  Q25, S18, V9.4S
    AESE  V9.16B, V21.16B
    SHA256SU1  V12.4S, V21.4S, V3.4S
    SHA256SU1  V17.4S, V10.4S, V15.4S
    SHA256H  Q24, Q31, V16.4S
    SHA256SU1  V30.4S, V18.4S, V5.4S
    SHA256H  Q15, Q25, V26.4S
    SHA1P  Q20, S28, V31.4S
    SHA1C  Q5, S0, V6.4S
    AESD  V5.16B, V15.16B
    SHA1SU1  V13.4S, V18.4S
    SHA1SU0  V2.4S, V20.4S, V6.4S
    SHA1SU0  V31.4S, V22.4S, V27.4S
    SHA1P  Q31, S6, V22.4S
    SHA1C  Q17, S4, V10.4S
    SHA1C  Q8, S5, V21.4S
    AESIMC  V3.16B, V26.16B
    SHA1SU0  V15.4S, V13.4S, V13.4S
    SHA256SU1  V12.4S, V10.4S, V26.4S
    SHA256H  Q29, Q31, V30.4S
    AESMC  V28.16B, V0.16B
    SHA1H  S10, S9
    SHA256SU0  V28.4S, V3.4S
    AESE  V18.16B, V1.16B
    SHA256H  Q31, Q12, V5.4S
    SHA256H  Q12, Q4, V4.4S
    AESMC  V5.16B, V11.16B
    AESE  V5.16B, V17.16B
    SHA256H  Q27, Q13, V16.4S
    AESE  V31.16B, V24.16B
    SHA1M  Q19, S4, V29.4S
    SHA256SU0  V10.4S, V9.4S
    SHA1SU0  V27.4S, V9.4S, V29.4S
    SHA1H  S16, S30
    SHA1SU0  V9.4S, V10.4S, V15.4S
    SHA1M  Q3, S21, V30.4S
    SHA1C  Q6, S31, V4.4S
    AESIMC  V31.16B, V10.16B
    SHA256H  Q9, Q20, V21.4S
    AESMC  V1.16B, V29.16B
    SHA1SU0  V21.4S, V27.4S, V29.4S
    SHA1SU1  V28.4S, V27.4S
    SHA256H  Q16, Q2, V12.4S
    AESMC  V21.16B, V17.16B
    SHA256SU1  V14.4S, V21.4S, V13.4S
    SHA1P  Q5, S19, V7.4S
    SHA256H2  Q29, Q26, V10.4S
    SHA1SU1  V13.4S, V30.4S
    SHA256H  Q28, Q19, V7.4S
    SHA1P  Q2, S3, V10.4S
    SHA1M  Q4, S5, V31.4S
    SHA1C  Q3, S10, V6.4S
    AESE  V6.16B, V22.16B
    SHA256H2  Q26, Q11, V30.4S
    SHA1SU1  V12.4S, V10.4S
    SHA1P  Q2, S21, V5.4S
    AESMC  V17.16B, V26.16B
    AESE  V24.16B, V31.16B
    SHA1P  Q30, S5, V31.4S
    SHA1SU0  V24.4S, V29.4S, V4.4S
    SHA256H2  Q23, Q3, V4.4S
    SHA256H2  Q23, Q2, V10.4S
    SHA256H2  Q10, Q14, V5.4S
    AESD  V20.16B, V19.16B
    SHA256SU1  V12.4S, V21.4S, V14.4S
    SHA256H  Q2, Q6, V4.4S
    SHA1C  Q28, S21, V5.4S
    AESE  V29.16B, V13.16B
    AESE  V17.16B, V15.16B
    SHA256SU0  V12.4S, V3.4S
    AESD  V16.16B, V29.16B
    SHA1H  S28, S14
    AESIMC  V28.16B, V21.16B
    AESE  V4.16B, V5.16B
    SHA256H2  Q7, Q21, V31.4S
    SHA1SU0  V19.4S, V4.4S, V29.4S
    AESE  V16.16B, V30.16B
    SHA1P  Q5, S14, V5.4S
    SHA1M  Q18, S23, V11.4S
    AESD  V31.16B, V8.16B
    SHA256SU0  V23.4S, V11.4S
    SHA256H  Q29, Q5, V11.4S
    AESD  V13.16B, V24.16B
    SHA1P  Q7, S10, V8.4S
    SHA1SU1  V17.4S, V14.4S
    AESIMC  V12.16B, V23.16B
    AESMC  V23.16B, V0.16B
    AESD  V12.16B, V18.16B
    SHA256H  Q3, Q17, V18.4S
    SHA256H2  Q2, Q13, V19.4S
    SHA1SU1  V4.4S, V28.4S
    SHA256H  Q19, Q29, V13.4S
    SHA1C  Q7, S13, V30.4S
    SHA1M  Q28, S16, V26.4S
    SHA1SU0  V0.4S, V6.4S, V16.4S
    SHA256H  Q15, Q20, V12.4S
    SHA1M  Q24, S7, V4.4S
    AESMC  V23.16B, V12.16B
    AESIMC  V7.16B, V28.16B
    AESIMC  V19.16B, V8.16B
    SHA1H  S3, S5
    SUBS  X19, X19, #0x1
    B.NE  TaishanSimdUnaryArithmeticP01_label_332
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X12, X28, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X25, X29, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X9
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X24, X14, X10
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X11
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X14
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X12, X11, X17
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X23
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X27, X19, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X17, X11, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X29
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X28, #0x4d5c, LSL #0
    MOVK  X28, #0xd865, LSL #16
    MOVK  X28, #0x43b3, LSL #32
    MOVK  X28, #0x53aa, LSL #48
    SUB  X29, X28, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, D2
    MOVZ  X28, #0x2216, LSL #0
    MOVK  X28, #0xfbbb, LSL #16
    MOVK  X28, #0x6bd6, LSL #32
    MOVK  X28, #0xb6ad, LSL #48
    SUB  X29, X28, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X23, X15, X7
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, D3
    MOVZ  X15, #0x377d, LSL #0
    MOVK  X15, #0x431e, LSL #16
    SUB  X23, X15, X7
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, V4.D[1]
    MOVZ  X28, #0x4a1e, LSL #0
    MOVK  X28, #0xc9dc, LSL #16
    MOVK  X28, #0x5fce, LSL #32
    MOVK  X28, #0x1e32, LSL #48
    SUB  X10, X28, X3
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, D4
    MOVZ  X28, #0x9ec7, LSL #0
    MOVK  X28, #0x8da0, LSL #16
    MOVK  X28, #0xda87, LSL #32
    MOVK  X28, #0xd4b2, LSL #48
    SUB  X10, X28, X3
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X15, #0xfa7e, LSL #0
    MOVK  X15, #0xf4c0, LSL #16
    MOVK  X15, #0x4bb7, LSL #32
    MOVK  X15, #0xed5d, LSL #48
    SUB  X23, X15, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, D5
    MOVZ  X15, #0xddf5, LSL #0
    MOVK  X15, #0xc78, LSL #16
    MOVK  X15, #0xfae6, LSL #32
    MOVK  X15, #0x8777, LSL #48
    SUB  X23, X15, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, V6.D[1]
    MOVZ  X25, #0x75b1, LSL #0
    MOVK  X25, #0x5056, LSL #16
    MOVK  X25, #0xd08, LSL #32
    MOVK  X25, #0xf44e, LSL #48
    SUB  X19, X25, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, D6
    MOVZ  X25, #0x7a61, LSL #0
    MOVK  X25, #0xb647, LSL #16
    MOVK  X25, #0x366a, LSL #32
    MOVK  X25, #0x2821, LSL #48
    SUB  X19, X25, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X9, #0x14f, LSL #0
    MOVK  X9, #0x9cf2, LSL #16
    MOVK  X9, #0x8aeb, LSL #32
    MOVK  X9, #0x6189, LSL #48
    SUB  X14, X9, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, D7
    MOVZ  X9, #0x9d24, LSL #0
    MOVK  X9, #0x1b0d, LSL #16
    MOVK  X9, #0x301b, LSL #32
    MOVK  X9, #0x64a4, LSL #48
    SUB  X14, X9, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X28, #0xc65c, LSL #0
    MOVK  X28, #0xaf87, LSL #16
    MOVK  X28, #0x97f3, LSL #32
    MOVK  X28, #0xbbe0, LSL #48
    SUB  X10, X28, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, D8
    MOVZ  X28, #0x848e, LSL #0
    MOVK  X28, #0x7294, LSL #16
    MOVK  X28, #0x4352, LSL #32
    MOVK  X28, #0xb0f7, LSL #48
    SUB  X10, X28, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, V9.D[1]
    MOVZ  X6, #0x525d, LSL #0
    MOVK  X6, #0xbd30, LSL #16
    MOVK  X6, #0xf558, LSL #32
    MOVK  X6, #0x9b2e, LSL #48
    SUB  X3, X6, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, D9
    MOVZ  X6, #0x89c8, LSL #0
    MOVK  X6, #0x4d3a, LSL #16
    MOVK  X6, #0xe1be, LSL #32
    MOVK  X6, #0x97b4, LSL #48
    SUB  X3, X6, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X12, #0xd52c, LSL #0
    MOVK  X12, #0x522f, LSL #16
    MOVK  X12, #0x966, LSL #32
    MOVK  X12, #0x5c4b, LSL #48
    SUB  X4, X12, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D10
    MOVZ  X12, #0x75ec, LSL #0
    MOVK  X12, #0xbeef, LSL #16
    MOVK  X12, #0x5004, LSL #32
    MOVK  X12, #0x24c9, LSL #48
    SUB  X4, X12, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, V11.D[1]
    MOVZ  X8, #0xa771, LSL #0
    MOVK  X8, #0x15e5, LSL #16
    MOVK  X8, #0x5cc7, LSL #32
    MOVK  X8, #0xdf2e, LSL #48
    SUB  X3, X8, X26
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, D11
    MOVZ  X8, #0xc814, LSL #0
    MOVK  X8, #0xbc2, LSL #16
    MOVK  X8, #0xefe6, LSL #32
    MOVK  X8, #0x71d4, LSL #48
    SUB  X3, X8, X26
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, V12.D[1]
    MOVZ  X9, #0x112c, LSL #0
    MOVK  X9, #0xbc67, LSL #16
    MOVK  X9, #0xc18b, LSL #32
    MOVK  X9, #0xc48, LSL #48
    SUB  X7, X9, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, D12
    MOVZ  X9, #0x797, LSL #0
    MOVK  X9, #0x9a24, LSL #16
    MOVK  X9, #0x1c48, LSL #32
    MOVK  X9, #0x47fd, LSL #48
    SUB  X7, X9, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, V13.D[1]
    MOVZ  X16, #0xb7ea, LSL #0
    MOVK  X16, #0x9665, LSL #16
    MOVK  X16, #0x1f68, LSL #32
    MOVK  X16, #0x2901, LSL #48
    SUB  X24, X16, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, D13
    MOVZ  X16, #0xaf50, LSL #0
    MOVK  X16, #0xb034, LSL #16
    MOVK  X16, #0x6ca7, LSL #32
    MOVK  X16, #0x7c81, LSL #48
    SUB  X24, X16, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X9, #0x66e3, LSL #0
    MOVK  X9, #0xbf59, LSL #16
    MOVK  X9, #0x3df5, LSL #32
    MOVK  X9, #0xf309, LSL #48
    SUB  X23, X9, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, D14
    MOVZ  X9, #0x74a, LSL #0
    MOVK  X9, #0xdd4d, LSL #16
    MOVK  X9, #0x43f2, LSL #32
    MOVK  X9, #0xb5d, LSL #48
    SUB  X23, X9, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, V15.D[1]
    MOVZ  X13, #0xdf83, LSL #0
    MOVK  X13, #0xd841, LSL #16
    MOVK  X13, #0xd0be, LSL #32
    MOVK  X13, #0x417, LSL #48
    SUB  X7, X13, X27
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, D15
    MOVZ  X13, #0xdc30, LSL #0
    MOVK  X13, #0xcae6, LSL #16
    MOVK  X13, #0xa134, LSL #32
    MOVK  X13, #0x9f66, LSL #48
    SUB  X7, X13, X27
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, V16.D[1]
    MOVZ  X15, #0x218c, LSL #0
    MOVK  X15, #0xcab1, LSL #16
    MOVK  X15, #0x3ed2, LSL #32
    MOVK  X15, #0x2da9, LSL #48
    SUB  X10, X15, X5
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, D16
    MOVZ  X15, #0x2054, LSL #0
    MOVK  X15, #0xcba8, LSL #16
    MOVK  X15, #0xd308, LSL #32
    MOVK  X15, #0xa76e, LSL #48
    SUB  X10, X15, X5
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X4, #0x4c90, LSL #0
    MOVK  X4, #0x1451, LSL #16
    MOVK  X4, #0x2e60, LSL #32
    MOVK  X4, #0x7816, LSL #48
    SUB  X23, X4, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, D17
    MOVZ  X4, #0x4f3b, LSL #0
    MOVK  X4, #0x11fd, LSL #16
    MOVK  X4, #0xd558, LSL #32
    MOVK  X4, #0x4350, LSL #48
    SUB  X23, X4, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X2, #0x8642, LSL #0
    MOVK  X2, #0x5030, LSL #16
    MOVK  X2, #0xe0d2, LSL #32
    MOVK  X2, #0x2875, LSL #48
    SUB  X10, X2, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, D18
    MOVZ  X2, #0x143e, LSL #0
    MOVK  X2, #0x16f5, LSL #16
    MOVK  X2, #0x19b0, LSL #32
    MOVK  X2, #0xd068, LSL #48
    SUB  X10, X2, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, V19.D[1]
    MOVZ  X26, #0xae67, LSL #0
    MOVK  X26, #0xb8c3, LSL #16
    MOVK  X26, #0x15ab, LSL #32
    MOVK  X26, #0x47c6, LSL #48
    SUB  X21, X26, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, D19
    MOVZ  X26, #0x9c3f, LSL #0
    MOVK  X26, #0xa9e6, LSL #16
    MOVK  X26, #0x102, LSL #32
    MOVK  X26, #0x5e0b, LSL #48
    SUB  X21, X26, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X16, #0xb705, LSL #0
    MOVK  X16, #0x993f, LSL #16
    MOVK  X16, #0x795f, LSL #32
    MOVK  X16, #0x84e3, LSL #48
    SUB  X25, X16, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, D20
    MOVZ  X16, #0x7419, LSL #0
    MOVK  X16, #0x53bc, LSL #16
    MOVK  X16, #0x36a, LSL #32
    MOVK  X16, #0x1ff2, LSL #48
    SUB  X25, X16, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, V21.D[1]
    MOVZ  X4, #0xcd, LSL #0
    MOVK  X4, #0xb981, LSL #16
    MOVK  X4, #0xd600, LSL #32
    MOVK  X4, #0xd2f3, LSL #48
    SUB  X15, X4, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, D21
    MOVZ  X4, #0xb435, LSL #0
    MOVK  X4, #0x1e99, LSL #16
    MOVK  X4, #0x11c2, LSL #32
    MOVK  X4, #0xcbbb, LSL #48
    SUB  X15, X4, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X9, #0x1bb0, LSL #0
    MOVK  X9, #0x612c, LSL #16
    MOVK  X9, #0xc611, LSL #32
    MOVK  X9, #0x17ce, LSL #48
    SUB  X24, X9, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, D23
    MOVZ  X9, #0x6f82, LSL #0
    MOVK  X9, #0xae6d, LSL #16
    MOVK  X9, #0x2b0e, LSL #32
    MOVK  X9, #0xb77c, LSL #48
    SUB  X24, X9, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, V24.D[1]
    MOVZ  X20, #0x598e, LSL #0
    MOVK  X20, #0x595b, LSL #16
    MOVK  X20, #0xbb99, LSL #32
    MOVK  X20, #0xe6e3, LSL #48
    SUB  X19, X20, X25
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, D24
    MOVZ  X20, #0x40f4, LSL #0
    MOVK  X20, #0x4b6b, LSL #16
    MOVK  X20, #0x848a, LSL #32
    MOVK  X20, #0x9b6b, LSL #48
    SUB  X19, X20, X25
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, V25.D[1]
    MOVZ  X11, #0x3725, LSL #0
    MOVK  X11, #0xb93a, LSL #16
    MOVK  X11, #0xeed5, LSL #32
    MOVK  X11, #0xb872, LSL #48
    SUB  X20, X11, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, D25
    MOVZ  X11, #0xe47, LSL #0
    MOVK  X11, #0x185f, LSL #16
    MOVK  X11, #0x2f0f, LSL #32
    MOVK  X11, #0xab11, LSL #48
    SUB  X20, X11, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X5, #0x8228, LSL #0
    MOVK  X5, #0x2e91, LSL #16
    MOVK  X5, #0xad9d, LSL #32
    MOVK  X5, #0x57cb, LSL #48
    SUB  X23, X5, X12
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, D26
    MOVZ  X5, #0x4b3b, LSL #0
    MOVK  X5, #0x78ac, LSL #16
    MOVK  X5, #0xc926, LSL #32
    MOVK  X5, #0x173b, LSL #48
    SUB  X23, X5, X12
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X20, #0x538d, LSL #0
    MOVK  X20, #0xd92c, LSL #16
    MOVK  X20, #0xe59a, LSL #32
    MOVK  X20, #0x8290, LSL #48
    SUB  X28, X20, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X16, D27
    MOVZ  X20, #0x856, LSL #0
    MOVK  X20, #0x737a, LSL #16
    MOVK  X20, #0xca45, LSL #32
    MOVK  X20, #0xf04a, LSL #48
    SUB  X28, X20, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X10, V28.D[1]
    MOVZ  X20, #0xdcf3, LSL #0
    MOVK  X20, #0x10e, LSL #16
    MOVK  X20, #0x5a0, LSL #32
    MOVK  X20, #0xe7cb, LSL #48
    SUB  X21, X20, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X10, D28
    MOVZ  X20, #0x9e2, LSL #0
    MOVK  X20, #0xca8e, LSL #16
    MOVK  X20, #0xe8a6, LSL #32
    MOVK  X20, #0x71d4, LSL #48
    SUB  X21, X20, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, V29.D[1]
    MOVZ  X2, #0x8f46, LSL #0
    MOVK  X2, #0x1dc, LSL #16
    MOVK  X2, #0x50a1, LSL #32
    MOVK  X2, #0x781c, LSL #48
    SUB  X19, X2, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, D29
    MOVZ  X2, #0x14c7, LSL #0
    MOVK  X2, #0x2da2, LSL #16
    MOVK  X2, #0x838c, LSL #32
    MOVK  X2, #0x5eed, LSL #48
    SUB  X19, X2, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
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
    FMOV  D0, X9
    FMOV  V0.D[1], X6
    FMOV  D1, X9
    FMOV  V1.D[1], X25
    FMOV  D2, X23
    FMOV  V2.D[1], X9
    FMOV  D3, X23
    FMOV  V3.D[1], X5
    FMOV  D4, X10
    FMOV  V4.D[1], X10
    FMOV  D5, X15
    FMOV  V5.D[1], X26
    FMOV  D6, X25
    FMOV  V6.D[1], X20
    FMOV  D7, X29
    FMOV  V7.D[1], X5
    FMOV  D8, X6
    FMOV  V8.D[1], X21
    FMOV  D9, X23
    FMOV  V9.D[1], X2
    FMOV  D10, X3
    FMOV  V10.D[1], X11
    FMOV  D11, X25
    FMOV  V11.D[1], X9
    FMOV  D12, X24
    FMOV  V12.D[1], X13
    FMOV  D13, X4
    FMOV  V13.D[1], X5
    FMOV  D14, X29
    FMOV  V14.D[1], X12
    FMOV  D15, X26
    FMOV  V15.D[1], X7
    FMOV  D16, X29
    FMOV  V16.D[1], X14
    FMOV  D17, X7
    FMOV  V17.D[1], X19
    FMOV  D18, X4
    FMOV  V18.D[1], X9
    FMOV  D19, X28
    FMOV  V19.D[1], X27
    FMOV  D20, X17
    FMOV  V20.D[1], X6
    FMOV  D21, X17
    FMOV  V21.D[1], X5
    FMOV  D22, X9
    FMOV  V22.D[1], X29
    FMOV  D23, X4
    FMOV  V23.D[1], X14
    FMOV  D24, X28
    FMOV  V24.D[1], X19
    FMOV  D25, X27
    FMOV  V25.D[1], X6
    FMOV  D26, X27
    FMOV  V26.D[1], X15
    FMOV  D27, X29
    FMOV  V27.D[1], X20
    FMOV  D28, X29
    FMOV  V28.D[1], X25
    FMOV  D29, X14
    FMOV  V29.D[1], X25
    FMOV  D30, X29
    FMOV  V30.D[1], X26
    FMOV  D31, X26
    FMOV  V31.D[1], X2
    MOVZ  X23, #0xf, LSL #0
TaishanSimdUnaryArithmeticP01_label_412:
    AESMC  V10.16B, V6.16B
    SHA1H  S8, S25
    SHA256SU0  V7.4S, V13.4S
    SHA256SU1  V24.4S, V28.4S, V30.4S
    AESIMC  V24.16B, V5.16B
    AESE  V27.16B, V23.16B
    SHA1P  Q31, S10, V29.4S
    SHA1SU1  V5.4S, V0.4S
    SHA1H  S31, S11
    SHA1C  Q10, S28, V7.4S
    SHA1P  Q2, S30, V4.4S
    SHA1C  Q18, S6, V11.4S
    SHA256SU1  V27.4S, V5.4S, V28.4S
    SHA256H  Q12, Q23, V12.4S
    SHA256H  Q18, Q27, V16.4S
    AESMC  V23.16B, V13.16B
    SHA1SU0  V5.4S, V8.4S, V19.4S
    SHA256SU0  V11.4S, V2.4S
    SHA1SU1  V12.4S, V10.4S
    SHA1P  Q30, S18, V24.4S
    SHA256H2  Q16, Q5, V23.4S
    SHA1SU1  V22.4S, V18.4S
    SHA1H  S6, S21
    AESD  V6.16B, V7.16B
    AESMC  V23.16B, V0.16B
    SHA1SU0  V30.4S, V11.4S, V12.4S
    AESMC  V27.16B, V31.16B
    AESIMC  V1.16B, V14.16B
    SHA1C  Q13, S19, V28.4S
    AESMC  V14.16B, V18.16B
    SHA256SU0  V22.4S, V16.4S
    AESMC  V3.16B, V10.16B
    SHA256H  Q24, Q17, V8.4S
    AESIMC  V19.16B, V18.16B
    AESMC  V0.16B, V0.16B
    SHA1C  Q31, S3, V12.4S
    SHA1SU1  V18.4S, V10.4S
    SHA1M  Q10, S9, V9.4S
    AESIMC  V19.16B, V4.16B
    SHA1P  Q18, S14, V15.4S
    SHA256SU1  V27.4S, V20.4S, V31.4S
    SHA256H2  Q13, Q8, V25.4S
    AESE  V23.16B, V12.16B
    SHA1SU1  V17.4S, V4.4S
    SHA256SU0  V25.4S, V3.4S
    SHA256H2  Q16, Q7, V13.4S
    AESIMC  V19.16B, V13.16B
    SHA1C  Q22, S4, V16.4S
    AESD  V29.16B, V9.16B
    SHA256H  Q15, Q26, V10.4S
    AESMC  V15.16B, V19.16B
    AESD  V14.16B, V9.16B
    AESE  V9.16B, V25.16B
    SHA1SU1  V29.4S, V30.4S
    AESMC  V11.16B, V5.16B
    SHA1P  Q12, S9, V22.4S
    SHA1M  Q9, S14, V20.4S
    SHA256H2  Q9, Q26, V8.4S
    SHA1SU0  V4.4S, V12.4S, V12.4S
    SHA256SU0  V12.4S, V1.4S
    SHA1C  Q23, S28, V8.4S
    SHA256H2  Q2, Q16, V16.4S
    SHA256H  Q8, Q23, V12.4S
    SHA1H  S13, S20
    AESE  V7.16B, V28.16B
    SHA1P  Q8, S18, V27.4S
    SHA256SU0  V12.4S, V15.4S
    SHA256SU1  V15.4S, V28.4S, V17.4S
    SHA256H  Q23, Q13, V15.4S
    SHA1H  S12, S23
    SHA1SU1  V4.4S, V30.4S
    SHA1SU0  V30.4S, V17.4S, V10.4S
    AESMC  V30.16B, V14.16B
    SHA1C  Q0, S13, V3.4S
    SHA1P  Q2, S23, V1.4S
    AESE  V25.16B, V12.16B
    SHA256H2  Q24, Q0, V16.4S
    SHA1P  Q28, S8, V29.4S
    AESIMC  V13.16B, V28.16B
    SHA1SU0  V27.4S, V4.4S, V23.4S
    SHA256SU0  V30.4S, V31.4S
    SHA256H2  Q10, Q9, V25.4S
    AESIMC  V23.16B, V18.16B
    SHA256H2  Q2, Q26, V31.4S
    SHA1M  Q25, S5, V23.4S
    SHA1M  Q31, S17, V24.4S
    AESIMC  V12.16B, V11.16B
    SHA256SU1  V23.4S, V2.4S, V0.4S
    SHA256SU1  V2.4S, V14.4S, V3.4S
    SHA1M  Q3, S11, V10.4S
    SHA1SU0  V7.4S, V2.4S, V3.4S
    SHA256H2  Q14, Q10, V6.4S
    SHA1M  Q30, S1, V20.4S
    SHA256H2  Q31, Q0, V11.4S
    AESIMC  V23.16B, V12.16B
    AESIMC  V2.16B, V7.16B
    SHA256SU0  V14.4S, V27.4S
    SHA1C  Q27, S15, V29.4S
    SHA1P  Q18, S8, V14.4S
    SHA1SU1  V24.4S, V6.4S
    SHA1SU1  V15.4S, V30.4S
    AESIMC  V24.16B, V26.16B
    SHA1SU0  V26.4S, V22.4S, V3.4S
    AESIMC  V16.16B, V16.16B
    AESE  V25.16B, V19.16B
    AESIMC  V10.16B, V1.16B
    SHA1M  Q19, S12, V1.4S
    AESE  V18.16B, V13.16B
    AESIMC  V30.16B, V18.16B
    SHA256H2  Q17, Q21, V7.4S
    SHA1H  S26, S18
    SHA1SU0  V15.4S, V21.4S, V19.4S
    SHA1H  S17, S21
    AESMC  V7.16B, V17.16B
    SHA256H  Q27, Q24, V7.4S
    SHA256H  Q9, Q12, V3.4S
    SHA1H  S15, S17
    SHA1SU1  V24.4S, V11.4S
    SHA256H  Q18, Q14, V27.4S
    SHA1M  Q30, S22, V25.4S
    AESIMC  V10.16B, V25.16B
    SHA256H  Q7, Q27, V9.4S
    AESMC  V16.16B, V16.16B
    SHA1C  Q21, S7, V23.4S
    SHA256SU0  V27.4S, V8.4S
    SHA1C  Q26, S17, V10.4S
    SHA256H  Q3, Q15, V17.4S
    AESD  V14.16B, V11.16B
    SHA256SU1  V13.4S, V24.4S, V12.4S
    AESD  V21.16B, V21.16B
    AESD  V17.16B, V21.16B
    SHA1SU1  V31.4S, V22.4S
    AESD  V23.16B, V17.16B
    AESD  V23.16B, V18.16B
    SHA1P  Q23, S24, V20.4S
    SHA256H2  Q23, Q15, V9.4S
    AESE  V14.16B, V18.16B
    SHA256SU1  V4.4S, V5.4S, V16.4S
    AESMC  V30.16B, V31.16B
    AESMC  V1.16B, V11.16B
    AESIMC  V16.16B, V15.16B
    SHA1SU1  V9.4S, V29.4S
    SHA256H  Q0, Q13, V16.4S
    SHA256SU0  V5.4S, V3.4S
    SHA1C  Q1, S5, V10.4S
    SHA256H  Q27, Q15, V11.4S
    SHA1C  Q28, S23, V20.4S
    SHA1SU0  V17.4S, V6.4S, V16.4S
    AESMC  V6.16B, V18.16B
    SHA1H  S18, S10
    SHA256SU0  V0.4S, V14.4S
    SHA1SU1  V0.4S, V22.4S
    SHA256SU0  V21.4S, V1.4S
    SHA256SU1  V17.4S, V14.4S, V13.4S
    SHA1H  S14, S10
    AESIMC  V23.16B, V9.16B
    AESIMC  V0.16B, V19.16B
    AESE  V16.16B, V0.16B
    SHA256H2  Q26, Q4, V23.4S
    AESD  V16.16B, V18.16B
    SHA1P  Q3, S17, V5.4S
    SHA1P  Q23, S11, V8.4S
    SHA256SU0  V10.4S, V15.4S
    SHA256H  Q1, Q20, V23.4S
    SHA256H  Q18, Q30, V27.4S
    AESE  V28.16B, V23.16B
    SHA1C  Q6, S23, V16.4S
    AESD  V30.16B, V31.16B
    SHA1SU0  V3.4S, V28.4S, V20.4S
    SHA1C  Q6, S6, V15.4S
    SHA256H2  Q23, Q4, V15.4S
    SHA256H2  Q27, Q13, V0.4S
    SHA1SU1  V26.4S, V26.4S
    SHA1C  Q24, S27, V7.4S
    SHA1P  Q13, S29, V16.4S
    SHA1C  Q16, S4, V8.4S
    AESE  V0.16B, V9.16B
    AESIMC  V31.16B, V1.16B
    SHA1P  Q7, S13, V31.4S
    SHA1SU1  V22.4S, V3.4S
    SHA256SU0  V22.4S, V0.4S
    SHA256H2  Q29, Q29, V9.4S
    SHA1H  S10, S18
    AESIMC  V5.16B, V28.16B
    AESMC  V13.16B, V16.16B
    SHA256H  Q6, Q7, V1.4S
    AESD  V6.16B, V23.16B
    SHA1H  S23, S5
    SHA1H  S14, S29
    SHA1H  S21, S11
    SHA1SU1  V11.4S, V27.4S
    SHA256H  Q6, Q6, V10.4S
    SHA256SU0  V11.4S, V4.4S
    SHA256H  Q25, Q30, V16.4S
    SHA1C  Q6, S30, V29.4S
    SHA1H  S25, S22
    SHA1M  Q25, S27, V7.4S
    SHA1M  Q0, S17, V1.4S
    AESIMC  V13.16B, V16.16B
    SHA256SU0  V3.4S, V24.4S
    SUBS  X23, X23, #0x1
    B.NE  TaishanSimdUnaryArithmeticP01_label_412
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X23, X14, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X12, X11, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X25, X17, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X25, X2, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X26, X29, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X25, X21, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
TaishanSimdUnaryArithmeticP01_label_38:
    MOVK  X16, #0xffff, LSL #48
    SUB  X17, X16, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X3, X25, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X14, X11, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X17, X19, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X25, X17, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X11, X29, X17
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X3, X7, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X4, X18, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X3, X2, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X15, X16, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X14, X19, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X8, X23, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X4, X19, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X13, X6, X29
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, V2.D[1]
    MOVZ  X12, #0xf5d0, LSL #0
    MOVK  X12, #0x5b57, LSL #16
    MOVK  X12, #0x578d, LSL #32
    MOVK  X12, #0xc73f, LSL #48
    SUB  X4, X12, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, D2
    MOVZ  X12, #0xb272, LSL #0
    MOVK  X12, #0xabf0, LSL #16
    MOVK  X12, #0xb81f, LSL #32
    MOVK  X12, #0xce16, LSL #48
    SUB  X4, X12, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X11, #0x5282, LSL #0
    MOVK  X11, #0x57ec, LSL #16
    MOVK  X11, #0x6c5b, LSL #32
    MOVK  X11, #0xc953, LSL #48
    SUB  X7, X11, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, D3
    MOVZ  X11, #0xb075, LSL #0
    MOVK  X11, #0x44b7, LSL #16
    MOVK  X11, #0xb9fe, LSL #32
    MOVK  X11, #0x9c5e, LSL #48
    SUB  X7, X11, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, V4.D[1]
    MOVZ  X28, #0xe7a, LSL #0
    MOVK  X28, #0x5e80, LSL #16
    MOVK  X28, #0xf520, LSL #32
    MOVK  X28, #0xb9a2, LSL #48
    SUB  X9, X28, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, D4
    MOVZ  X28, #0x95a3, LSL #0
    MOVK  X28, #0x9517, LSL #16
    MOVK  X28, #0xf6f3, LSL #32
    MOVK  X28, #0xd8aa, LSL #48
    SUB  X9, X28, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, V5.D[1]
    MOVZ  X13, #0x77d0, LSL #0
    MOVK  X13, #0x154b, LSL #16
    MOVK  X13, #0x1d3c, LSL #32
    MOVK  X13, #0xeef3, LSL #48
    SUB  X8, X13, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, D5
    MOVZ  X13, #0xa254, LSL #0
    MOVK  X13, #0x89bc, LSL #16
    MOVK  X13, #0x1b31, LSL #32
    MOVK  X13, #0x5ad5, LSL #48
    SUB  X8, X13, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X29, #0x3851, LSL #0
    MOVK  X29, #0x9377, LSL #16
    MOVK  X29, #0xdbc1, LSL #32
    MOVK  X29, #0x3b02, LSL #48
    SUB  X25, X29, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, D6
    MOVZ  X29, #0x9ec8, LSL #0
    MOVK  X29, #0xe082, LSL #16
    MOVK  X29, #0x2585, LSL #32
    MOVK  X29, #0xbd92, LSL #48
    SUB  X25, X29, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X9, #0x83b4, LSL #0
    MOVK  X9, #0xf70e, LSL #16
    MOVK  X9, #0xdeaa, LSL #32
    MOVK  X9, #0x34e9, LSL #48
    SUB  X29, X9, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, D7
    MOVZ  X9, #0x5a3d, LSL #0
    MOVK  X9, #0xbd92, LSL #16
    MOVK  X9, #0x7e7e, LSL #32
    MOVK  X9, #0x34e5, LSL #48
    SUB  X29, X9, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, V8.D[1]
    MOVZ  X9, #0xc5c9, LSL #0
    MOVK  X9, #0xf7af, LSL #16
    MOVK  X9, #0xe7b2, LSL #32
    MOVK  X9, #0xd8e5, LSL #48
    SUB  X17, X9, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, D8
    MOVZ  X9, #0xd7a1, LSL #0
    MOVK  X9, #0x734a, LSL #16
    MOVK  X9, #0x453c, LSL #32
    MOVK  X9, #0xd528, LSL #48
    SUB  X17, X9, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, V9.D[1]
    MOVZ  X11, #0x1bfd, LSL #0
    MOVK  X11, #0x5099, LSL #16
    MOVK  X11, #0x864e, LSL #32
    MOVK  X11, #0x2c19, LSL #48
    SUB  X28, X11, X6
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, D9
    MOVZ  X11, #0x35a8, LSL #0
    MOVK  X11, #0xc091, LSL #16
    MOVK  X11, #0xac52, LSL #32
    MOVK  X11, #0x6ac3, LSL #48
    SUB  X28, X11, X6
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, D10
    MOVZ  X27, #0xd29f, LSL #0
    MOVK  X27, #0xa3ee, LSL #16
    SUB  X3, X27, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, V11.D[1]
    MOVZ  X29, #0xdb65, LSL #0
    MOVK  X29, #0xe447, LSL #16
    MOVK  X29, #0x6470, LSL #32
    MOVK  X29, #0xa604, LSL #48
    SUB  X26, X29, X19
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, D11
    MOVZ  X29, #0xf984, LSL #0
    MOVK  X29, #0x77c2, LSL #16
    MOVK  X29, #0xfdb8, LSL #32
    MOVK  X29, #0x679c, LSL #48
    SUB  X26, X29, X19
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X23, #0x691f, LSL #0
    MOVK  X23, #0x13ea, LSL #16
    MOVK  X23, #0xc446, LSL #32
    MOVK  X23, #0xf9c6, LSL #48
    SUB  X29, X23, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, D12
    MOVZ  X23, #0xa402, LSL #0
    MOVK  X23, #0x6ecc, LSL #16
    MOVK  X23, #0x6715, LSL #32
    MOVK  X23, #0x304b, LSL #48
    SUB  X29, X23, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X17, #0x9165, LSL #0
    MOVK  X17, #0xf96f, LSL #16
    MOVK  X17, #0x1540, LSL #32
    MOVK  X17, #0xfc86, LSL #48
    SUB  X4, X17, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, D13
    MOVZ  X17, #0xb3d9, LSL #0
    MOVK  X17, #0xcc0, LSL #16
    MOVK  X17, #0x651b, LSL #32
    MOVK  X17, #0x480, LSL #48
    SUB  X4, X17, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, D14
    MOVZ  X29, #0x53d9, LSL #0
    MOVK  X29, #0xcb4e, LSL #16
    SUB  X3, X29, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, V15.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, D15
    MOVZ  X9, #0x1a5e, LSL #0
    MOVK  X9, #0xe37d, LSL #16
    SUB  X11, X9, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X21, #0x14f4, LSL #0
    MOVK  X21, #0xb83a, LSL #16
    MOVK  X21, #0x7c5, LSL #32
    MOVK  X21, #0xb05d, LSL #48
    SUB  X25, X21, X11
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, D16
    MOVZ  X21, #0xf3ab, LSL #0
    MOVK  X21, #0x1be5, LSL #16
    MOVK  X21, #0x4e1d, LSL #32
    MOVK  X21, #0xc069, LSL #48
    SUB  X25, X21, X11
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X18, #0x5d43, LSL #0
    MOVK  X18, #0xb944, LSL #16
    MOVK  X18, #0xc46, LSL #32
    MOVK  X18, #0xa59b, LSL #48
    SUB  X7, X18, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, D17
    MOVZ  X18, #0x1206, LSL #0
    MOVK  X18, #0xc409, LSL #16
    MOVK  X18, #0x35bd, LSL #32
    MOVK  X18, #0x3e61, LSL #48
    SUB  X7, X18, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, V18.D[1]
    MOVZ  X19, #0xa87a, LSL #0
    MOVK  X19, #0xb355, LSL #16
    MOVK  X19, #0xfe08, LSL #32
    MOVK  X19, #0x479b, LSL #48
    SUB  X16, X19, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, D18
    MOVZ  X19, #0x4a7e, LSL #0
    MOVK  X19, #0x8fbb, LSL #16
    MOVK  X19, #0xaa21, LSL #32
    MOVK  X19, #0xb5d2, LSL #48
    SUB  X16, X19, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X14, #0x129c, LSL #0
    MOVK  X14, #0x9f80, LSL #16
    MOVK  X14, #0x656, LSL #32
    MOVK  X14, #0x960b, LSL #48
    SUB  X28, X14, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, D19
    MOVZ  X14, #0x9793, LSL #0
    MOVK  X14, #0xa1c0, LSL #16
    MOVK  X14, #0x37bf, LSL #32
    MOVK  X14, #0x1d47, LSL #48
    SUB  X28, X14, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X13, X24, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, D20
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X13, X24, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, V21.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, D21
    MOVZ  X18, #0xdc14, LSL #0
    MOVK  X18, #0x6ca5, LSL #16
    SUB  X28, X18, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X25, X5, X4
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, D23
    MOVZ  X5, #0x2895, LSL #0
    MOVK  X5, #0x226f, LSL #16
    SUB  X25, X5, X4
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, V24.D[1]
    MOVZ  X23, #0x172c, LSL #0
    MOVK  X23, #0x25eb, LSL #16
    MOVK  X23, #0x271e, LSL #32
    MOVK  X23, #0xf126, LSL #48
    SUB  X14, X23, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, D24
    MOVZ  X23, #0x1cc3, LSL #0
    MOVK  X23, #0x8038, LSL #16
    MOVK  X23, #0xccaa, LSL #32
    MOVK  X23, #0xb24c, LSL #48
    SUB  X14, X23, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X13, #0x26fb, LSL #0
    MOVK  X13, #0xd2ce, LSL #16
    MOVK  X13, #0xa63a, LSL #32
    MOVK  X13, #0xe22c, LSL #48
    SUB  X9, X13, X12
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, D25
    MOVZ  X13, #0xce35, LSL #0
    MOVK  X13, #0xd578, LSL #16
    MOVK  X13, #0x91e8, LSL #32
    MOVK  X13, #0xe6b2, LSL #48
    SUB  X9, X13, X12
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, V26.D[1]
    MOVZ  X19, #0xf3a5, LSL #0
    MOVK  X19, #0x5d5b, LSL #16
    MOVK  X19, #0x5a7b, LSL #32
    MOVK  X19, #0x1058, LSL #48
    SUB  X18, X19, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, D26
    MOVZ  X19, #0xb20e, LSL #0
    MOVK  X19, #0x5192, LSL #16
    MOVK  X19, #0xa3d2, LSL #32
    MOVK  X19, #0x4cb8, LSL #48
    SUB  X18, X19, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X24, #0x39bd, LSL #0
    MOVK  X24, #0xc6c6, LSL #16
    MOVK  X24, #0xce00, LSL #32
    MOVK  X24, #0x51c2, LSL #48
    SUB  X10, X24, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X16, D27
    MOVZ  X24, #0x16ca, LSL #0
    MOVK  X24, #0x60c8, LSL #16
    MOVK  X24, #0xc446, LSL #32
    MOVK  X24, #0x1f5c, LSL #48
    SUB  X10, X24, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X14, #0xf67c, LSL #0
    MOVK  X14, #0x7d0e, LSL #16
    MOVK  X14, #0xe642, LSL #32
    MOVK  X14, #0x6df5, LSL #48
    SUB  X15, X14, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, D28
    MOVZ  X14, #0x5d60, LSL #0
    MOVK  X14, #0xeb15, LSL #16
    MOVK  X14, #0x39c0, LSL #32
    MOVK  X14, #0x2975, LSL #48
    SUB  X15, X14, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X2, #0x1b6b, LSL #0
    MOVK  X2, #0x780b, LSL #16
    MOVK  X2, #0x89fb, LSL #32
    MOVK  X2, #0xdb13, LSL #48
    SUB  X12, X2, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D29
    MOVZ  X2, #0x4f67, LSL #0
    MOVK  X2, #0x2d39, LSL #16
    MOVK  X2, #0xa19a, LSL #32
    MOVK  X2, #0xf8dc, LSL #48
    SUB  X12, X2, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X2, #0x9d91, LSL #0
    MOVK  X2, #0xe4bd, LSL #16
    MOVK  X2, #0xe35f, LSL #32
    MOVK  X2, #0xc7ab, LSL #48
    MOVZ  X3, #0xf1f, LSL #0
    MOVK  X3, #0x9066, LSL #16
    MOVK  X3, #0x1b14, LSL #32
    MOVK  X3, #0xc35d, LSL #48
    MOVZ  X4, #0xc7cc, LSL #0
    MOVK  X4, #0xdf2d, LSL #16
    MOVK  X4, #0x1b5f, LSL #32
    MOVK  X4, #0x6928, LSL #48
    MOVZ  X5, #0x90b3, LSL #0
    MOVK  X5, #0x5b2c, LSL #16
    MOVK  X5, #0xbc5c, LSL #32
    MOVK  X5, #0xa08f, LSL #48
    MOVZ  X6, #0xefd7, LSL #0
    MOVK  X6, #0x2b05, LSL #16
    MOVK  X6, #0x2701, LSL #32
    MOVK  X6, #0x50c8, LSL #48
    MOVZ  X7, #0x9f36, LSL #0
    MOVK  X7, #0xebfc, LSL #16
    MOVK  X7, #0x6db1, LSL #32
    MOVK  X7, #0xe6cd, LSL #48
    MOVZ  X8, #0xa68b, LSL #0
    MOVK  X8, #0x8a53, LSL #16
    MOVK  X8, #0xce36, LSL #32
    MOVK  X8, #0x6f9e, LSL #48
    MOVZ  X9, #0x1650, LSL #0
    MOVK  X9, #0xdd70, LSL #16
    MOVK  X9, #0xb890, LSL #32
    MOVK  X9, #0x329d, LSL #48
    MOVZ  X10, #0xb466, LSL #0
    MOVK  X10, #0x6fd8, LSL #16
    MOVK  X10, #0xadfa, LSL #32
    MOVK  X10, #0xf09e, LSL #48
    MOVZ  X11, #0x715c, LSL #0
    MOVK  X11, #0x5ed8, LSL #16
    MOVK  X11, #0xbecb, LSL #32
    MOVK  X11, #0x6d58, LSL #48
    MOVZ  X12, #0xe5d5, LSL #0
    MOVK  X12, #0x6477, LSL #16
    MOVK  X12, #0xe6c8, LSL #32
    MOVK  X12, #0x5831, LSL #48
    MOVZ  X13, #0x1892, LSL #0
    MOVK  X13, #0x10fb, LSL #16
    MOVK  X13, #0xa43f, LSL #32
    MOVK  X13, #0xcc76, LSL #48
    MOVZ  X14, #0x95e0, LSL #0
    MOVK  X14, #0xc78e, LSL #16
    MOVK  X14, #0x20fa, LSL #32
    MOVK  X14, #0x7c72, LSL #48
    MOVZ  X15, #0xa601, LSL #0
    MOVK  X15, #0xf057, LSL #16
    MOVK  X15, #0x2eee, LSL #32
    MOVK  X15, #0xd4f9, LSL #48
    MOVZ  X16, #0x3fd3, LSL #0
    MOVK  X16, #0x5de2, LSL #16
    MOVK  X16, #0xd3b, LSL #32
    MOVK  X16, #0xb6bb, LSL #48
    MOVZ  X17, #0x1c57, LSL #0
    MOVK  X17, #0x6519, LSL #16
    MOVK  X17, #0x7109, LSL #32
    MOVK  X17, #0x7fd7, LSL #48
    MOVZ  X18, #0x63b7, LSL #0
    MOVK  X18, #0xf061, LSL #16
    MOVK  X18, #0x86c2, LSL #32
    MOVK  X18, #0xb689, LSL #48
    MOVZ  X19, #0x5142, LSL #0
    MOVK  X19, #0xb138, LSL #16
    MOVK  X19, #0xde03, LSL #32
    MOVK  X19, #0x42d, LSL #48
    MOVZ  X20, #0xaedf, LSL #0
    MOVK  X20, #0xb19d, LSL #16
    MOVK  X20, #0x313c, LSL #32
    MOVK  X20, #0x9760, LSL #48
    MOVZ  X21, #0xcd72, LSL #0
    MOVK  X21, #0x9a5b, LSL #16
    MOVK  X21, #0xe9e2, LSL #32
    MOVK  X21, #0x57d2, LSL #48
    MOVZ  X23, #0x517, LSL #0
    MOVK  X23, #0x1f71, LSL #16
    MOVK  X23, #0x8a27, LSL #32
    MOVK  X23, #0x9266, LSL #48
    MOVZ  X24, #0xd3fc, LSL #0
    MOVK  X24, #0xb391, LSL #16
    MOVK  X24, #0xa018, LSL #32
    MOVK  X24, #0x9380, LSL #48
    MOVZ  X25, #0x39a, LSL #0
    MOVK  X25, #0xaf41, LSL #16
    MOVK  X25, #0xa4b3, LSL #32
    MOVK  X25, #0x36ae, LSL #48
    MOVZ  X26, #0xd70d, LSL #0
    MOVK  X26, #0xc698, LSL #16
    MOVK  X26, #0x6949, LSL #32
    MOVK  X26, #0x70fb, LSL #48
    MOVZ  X27, #0xe14, LSL #0
    MOVK  X27, #0x6593, LSL #16
    MOVK  X27, #0x65b0, LSL #32
    MOVK  X27, #0xb23a, LSL #48
    MOVZ  X28, #0x266e, LSL #0
    MOVK  X28, #0xa86c, LSL #16
    MOVK  X28, #0x2cbc, LSL #32
    MOVK  X28, #0x88a0, LSL #48
    MOVZ  X29, #0xc244, LSL #0
    MOVK  X29, #0x2655, LSL #16
    MOVK  X29, #0x8bf2, LSL #32
    MOVK  X29, #0xd52c, LSL #48
    FMOV  D0, X12
    FMOV  V0.D[1], X28
    FMOV  D1, X2
    FMOV  V1.D[1], X6
    FMOV  D2, X4
    FMOV  V2.D[1], X7
    FMOV  D3, X28
    FMOV  V3.D[1], X26
    FMOV  D4, X15
    FMOV  V4.D[1], X5
    FMOV  D5, X9
    FMOV  V5.D[1], X21
    FMOV  D6, X28
    FMOV  V6.D[1], X9
    FMOV  D7, X24
    FMOV  V7.D[1], X4
    FMOV  D8, X15
    FMOV  V8.D[1], X6
    FMOV  D9, X8
    FMOV  V9.D[1], X9
    FMOV  D10, X23
    FMOV  V10.D[1], X26
    FMOV  D11, X9
    FMOV  V11.D[1], X21
    FMOV  D12, X5
    FMOV  V12.D[1], X14
    FMOV  D13, X26
    FMOV  V13.D[1], X21
    FMOV  D14, X18
    FMOV  V14.D[1], X29
    FMOV  D15, X28
    FMOV  V15.D[1], X13
    FMOV  D16, X28
    FMOV  V16.D[1], X6
    FMOV  D17, X8
    FMOV  V17.D[1], X8
    FMOV  D18, X16
    FMOV  V18.D[1], X14
    FMOV  D19, X19
    FMOV  V19.D[1], X2
    FMOV  D20, X18
    FMOV  V20.D[1], X6
    FMOV  D21, X12
    FMOV  V21.D[1], X26
    FMOV  D22, X14
    FMOV  V22.D[1], X20
    FMOV  D23, X26
    FMOV  V23.D[1], X7
    FMOV  D24, X21
    FMOV  V24.D[1], X26
    FMOV  D25, X20
    FMOV  V25.D[1], X14
    FMOV  D26, X2
    FMOV  V26.D[1], X19
    FMOV  D27, X12
    FMOV  V27.D[1], X13
    FMOV  D28, X9
    FMOV  V28.D[1], X2
    FMOV  D29, X29
    FMOV  V29.D[1], X28
    FMOV  D30, X19
    FMOV  V30.D[1], X25
    FMOV  D31, X19
    FMOV  V31.D[1], X7
    MOVZ  X3, #0xa, LSL #0
TaishanSimdUnaryArithmeticP01_label_495:
    AESIMC  V29.16B, V23.16B
    SHA1SU1  V3.4S, V11.4S
    SHA1SU1  V12.4S, V29.4S
    SHA1P  Q25, S12, V6.4S
    SHA1H  S27, S15
    SHA1SU0  V26.4S, V19.4S, V3.4S
    SHA1P  Q3, S19, V29.4S
    AESIMC  V11.16B, V27.16B
    SHA1SU1  V2.4S, V3.4S
    SHA1P  Q20, S30, V29.4S
    SHA256SU1  V28.4S, V18.4S, V14.4S
    AESMC  V7.16B, V26.16B
    AESMC  V31.16B, V18.16B
    AESMC  V0.16B, V31.16B
    AESE  V14.16B, V3.16B
    SHA1P  Q25, S10, V28.4S
    SHA1C  Q25, S22, V19.4S
    SHA1H  S0, S11
    SHA256SU1  V8.4S, V0.4S, V27.4S
    AESE  V13.16B, V21.16B
    SHA1SU1  V23.4S, V6.4S
    SHA1H  S10, S6
    AESE  V12.16B, V4.16B
    SHA1C  Q1, S7, V21.4S
    SHA1C  Q26, S0, V6.4S
    SHA1SU1  V0.4S, V2.4S
    SHA1P  Q18, S7, V10.4S
    SHA256SU1  V24.4S, V29.4S, V9.4S
    SHA1P  Q29, S10, V22.4S
    SHA256H  Q6, Q4, V29.4S
    SHA256SU1  V18.4S, V10.4S, V4.4S
    SHA256SU0  V27.4S, V28.4S
    AESD  V26.16B, V14.16B
    SHA256SU0  V18.4S, V4.4S
    SHA1M  Q8, S15, V21.4S
    AESMC  V25.16B, V9.16B
    SHA1P  Q26, S2, V27.4S
    AESMC  V29.16B, V17.16B
    AESD  V22.16B, V13.16B
    AESMC  V10.16B, V8.16B
    AESMC  V29.16B, V5.16B
    SHA256SU1  V3.4S, V18.4S, V25.4S
    SHA256SU0  V19.4S, V31.4S
    AESIMC  V26.16B, V24.16B
    SHA1P  Q22, S18, V9.4S
    AESIMC  V27.16B, V7.16B
    SHA256SU0  V26.4S, V19.4S
    SHA256SU0  V15.4S, V18.4S
    SHA1P  Q26, S21, V9.4S
    AESE  V2.16B, V18.16B
    SHA1SU1  V14.4S, V13.4S
    SHA1C  Q10, S1, V10.4S
    SHA1M  Q27, S28, V7.4S
    AESD  V5.16B, V29.16B
    SHA256SU0  V15.4S, V15.4S
    SHA256SU1  V2.4S, V11.4S, V26.4S
    SHA1H  S4, S24
    SHA256SU0  V4.4S, V22.4S
    AESIMC  V4.16B, V14.16B
    SHA256SU0  V4.4S, V3.4S
    SHA1P  Q28, S19, V15.4S
    SHA1SU1  V31.4S, V12.4S
    SHA256SU0  V12.4S, V16.4S
    SHA1M  Q28, S17, V31.4S
    SHA1P  Q15, S18, V29.4S
    SHA1P  Q4, S19, V5.4S
    SHA1H  S13, S21
    SHA256SU0  V30.4S, V15.4S
    SHA1SU1  V11.4S, V7.4S
    SHA1SU0  V16.4S, V28.4S, V31.4S
    AESD  V28.16B, V28.16B
    SHA1SU1  V21.4S, V17.4S
    SHA256SU0  V29.4S, V24.4S
    SHA1H  S16, S7
    SHA1C  Q8, S12, V12.4S
    SHA1SU0  V24.4S, V5.4S, V6.4S
    SHA256SU1  V11.4S, V20.4S, V31.4S
    AESMC  V2.16B, V27.16B
    SHA1SU0  V24.4S, V15.4S, V20.4S
    SHA1H  S11, S21
    SHA1SU1  V21.4S, V1.4S
    SHA1SU1  V25.4S, V11.4S
    AESIMC  V26.16B, V19.16B
    SHA1P  Q13, S10, V15.4S
    SHA1H  S31, S17
    SHA1P  Q16, S1, V0.4S
    AESMC  V8.16B, V27.16B
    SHA1C  Q21, S31, V1.4S
    SHA256H2  Q11, Q28, V5.4S
    SHA256SU1  V6.4S, V12.4S, V19.4S
    SHA256H  Q8, Q17, V8.4S
    SHA1SU0  V1.4S, V10.4S, V26.4S
    SHA256H  Q5, Q16, V21.4S
    SHA1SU1  V25.4S, V2.4S
    SHA1M  Q15, S15, V3.4S
    SHA1C  Q14, S27, V23.4S
    SHA256H2  Q0, Q11, V12.4S
    SHA256H  Q31, Q1, V9.4S
    SHA1H  S14, S2
    SHA1P  Q13, S19, V13.4S
    SHA256H2  Q25, Q1, V16.4S
    SHA256H2  Q8, Q12, V19.4S
    SHA1C  Q29, S4, V16.4S
    SHA1C  Q26, S16, V26.4S
    SHA256H  Q28, Q7, V20.4S
    AESD  V2.16B, V22.16B
    SHA1C  Q21, S8, V18.4S
    SHA1H  S20, S2
    SHA1P  Q25, S7, V2.4S
    SHA256H  Q22, Q14, V13.4S
    SHA256H2  Q14, Q23, V11.4S
    AESD  V19.16B, V3.16B
    SHA256SU0  V29.4S, V1.4S
    AESD  V11.16B, V4.16B
    SHA256SU1  V3.4S, V4.4S, V28.4S
    SHA1C  Q29, S1, V16.4S
    SHA256SU0  V15.4S, V2.4S
    SHA1C  Q9, S10, V8.4S
    AESMC  V14.16B, V16.16B
    SHA1P  Q31, S3, V19.4S
    AESIMC  V8.16B, V19.16B
    SHA256SU0  V24.4S, V29.4S
    SHA1SU1  V15.4S, V15.4S
    SHA1H  S25, S0
    AESMC  V5.16B, V28.16B
    SHA1P  Q25, S4, V15.4S
    AESMC  V20.16B, V8.16B
    AESMC  V9.16B, V17.16B
    AESMC  V23.16B, V14.16B
    SHA256H  Q23, Q23, V16.4S
    AESIMC  V27.16B, V0.16B
    SHA1C  Q0, S19, V25.4S
    SHA256SU0  V21.4S, V28.4S
    SHA1SU1  V11.4S, V10.4S
    AESIMC  V22.16B, V25.16B
    SHA1C  Q16, S31, V11.4S
    SHA1SU1  V26.4S, V24.4S
    SHA1M  Q11, S22, V10.4S
    SHA1C  Q12, S23, V16.4S
    SHA1SU1  V29.4S, V18.4S
    SHA1M  Q14, S19, V21.4S
    SHA256SU1  V3.4S, V15.4S, V25.4S
    SHA1H  S1, S24
    AESE  V22.16B, V8.16B
    AESD  V16.16B, V0.16B
    SHA1P  Q27, S5, V5.4S
    SHA1SU0  V30.4S, V18.4S, V12.4S
    SHA256SU0  V3.4S, V30.4S
    AESMC  V28.16B, V28.16B
    AESIMC  V22.16B, V10.16B
    SHA256SU0  V22.4S, V16.4S
    AESE  V24.16B, V25.16B
    SHA1SU1  V29.4S, V24.4S
    SHA256H  Q30, Q2, V1.4S
    SHA1P  Q3, S8, V0.4S
    AESMC  V18.16B, V7.16B
    AESIMC  V22.16B, V28.16B
    AESMC  V8.16B, V10.16B
    SHA1P  Q26, S28, V7.4S
    SHA256H2  Q21, Q27, V8.4S
    SHA1H  S22, S18
    SHA1M  Q30, S5, V15.4S
    SHA256SU1  V20.4S, V12.4S, V11.4S
    SHA1H  S16, S2
    SHA1SU0  V6.4S, V27.4S, V28.4S
    AESMC  V30.16B, V16.16B
    SHA256H  Q26, Q30, V28.4S
    SHA1H  S22, S21
    AESMC  V22.16B, V6.16B
    SHA256SU1  V3.4S, V3.4S, V0.4S
    SHA256SU0  V5.4S, V3.4S
    SHA1SU1  V30.4S, V4.4S
    SHA1H  S30, S17
    SHA256H  Q15, Q19, V22.4S
    SHA1M  Q20, S0, V31.4S
    SHA1M  Q10, S30, V10.4S
    SHA1C  Q5, S24, V22.4S
    SHA256H2  Q9, Q25, V31.4S
    AESD  V4.16B, V25.16B
    AESE  V19.16B, V20.16B
    SHA1P  Q2, S29, V17.4S
    AESMC  V30.16B, V31.16B
    SHA256SU1  V14.4S, V13.4S, V9.4S
    AESE  V24.16B, V4.16B
    SHA1SU0  V0.4S, V12.4S, V8.4S
    SHA1H  S0, S13
    SHA1P  Q19, S15, V9.4S
    AESD  V19.16B, V27.16B
    AESIMC  V21.16B, V26.16B
    AESMC  V24.16B, V20.16B
    SHA1H  S6, S22
    SHA1M  Q30, S20, V25.4S
    SHA256H2  Q6, Q20, V9.4S
    AESD  V28.16B, V7.16B
    SHA256SU1  V9.4S, V12.4S, V25.4S
    SHA256SU0  V12.4S, V31.4S
    AESMC  V24.16B, V11.16B
    SHA1M  Q17, S13, V25.4S
    AESE  V12.16B, V30.16B
    SHA1P  Q15, S10, V21.4S
    SUBS  X3, X3, #0x1
    B.NE  TaishanSimdUnaryArithmeticP01_label_495
    MOVZ  X2, #0x9d91, LSL #0
    MOVK  X2, #0xe4bd, LSL #16
    MOVK  X2, #0xe35f, LSL #32
    MOVK  X2, #0xc7ab, LSL #48
    SUB  X15, X2, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X29, #0xc7cc, LSL #0
    MOVK  X29, #0xdf2d, LSL #16
    MOVK  X29, #0x1b5f, LSL #32
    MOVK  X29, #0x6928, LSL #48
    SUB  X14, X29, X4
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X25, #0xefd7, LSL #0
    MOVK  X25, #0x2b05, LSL #16
    MOVK  X25, #0x2701, LSL #32
    MOVK  X25, #0x50c8, LSL #48
    SUB  X6, X25, X6
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X24, #0x9f36, LSL #0
    MOVK  X24, #0xebfc, LSL #16
    MOVK  X24, #0x6db1, LSL #32
    MOVK  X24, #0xe6cd, LSL #48
    SUB  X28, X24, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X26, #0xa68b, LSL #0
    MOVK  X26, #0x8a53, LSL #16
    MOVK  X26, #0xce36, LSL #32
    MOVK  X26, #0x6f9e, LSL #48
    SUB  X8, X26, X8
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X21, #0x1650, LSL #0
    MOVK  X21, #0xdd70, LSL #16
    MOVK  X21, #0xb890, LSL #32
    MOVK  X21, #0x329d, LSL #48
    SUB  X16, X21, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X21, #0xb466, LSL #0
    MOVK  X21, #0x6fd8, LSL #16
    MOVK  X21, #0xadfa, LSL #32
    MOVK  X21, #0xf09e, LSL #48
    SUB  X3, X21, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X2, #0x715c, LSL #0
    MOVK  X2, #0x5ed8, LSL #16
    MOVK  X2, #0xbecb, LSL #32
    MOVK  X2, #0x6d58, LSL #48
    SUB  X26, X2, X11
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X12
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X13
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X2, X15, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X18, #0x1c57, LSL #0
    MOVK  X18, #0x6519, LSL #16
    MOVK  X18, #0x7109, LSL #32
    MOVK  X18, #0x7fd7, LSL #48
    SUB  X19, X18, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X18, #0x1c57, LSL #0
    MOVK  X18, #0x6519, LSL #16
    MOVK  X18, #0x7109, LSL #32
    MOVK  X18, #0x7fd7, LSL #48
    SUB  X2, X18, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X24, #0xaedf, LSL #0
    MOVK  X24, #0xb19d, LSL #16
    MOVK  X24, #0x313c, LSL #32
    MOVK  X24, #0x9760, LSL #48
    SUB  X16, X24, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X2, #0xb466, LSL #0
    MOVK  X2, #0x6fd8, LSL #16
    MOVK  X2, #0xadfa, LSL #32
    MOVK  X2, #0xf09e, LSL #48
    SUB  X8, X2, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X10, #0xaedf, LSL #0
    MOVK  X10, #0xb19d, LSL #16
    MOVK  X10, #0x313c, LSL #32
    MOVK  X10, #0x9760, LSL #48
    SUB  X28, X10, X24
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X5, #0xc7cc, LSL #0
    MOVK  X5, #0xdf2d, LSL #16
    MOVK  X5, #0x1b5f, LSL #32
    MOVK  X5, #0x6928, LSL #48
    SUB  X19, X5, X29
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X13, #0x67d8, LSL #0
    MOVK  X13, #0xe451, LSL #16
    MOVK  X13, #0x53e4, LSL #32
    MOVK  X13, #0x9f69, LSL #48
    SUB  X9, X13, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, D2
    MOVZ  X13, #0x1615, LSL #0
    MOVK  X13, #0x81fc, LSL #16
    MOVK  X13, #0xf2b9, LSL #32
    MOVK  X13, #0x50e2, LSL #48
    SUB  X9, X13, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, V3.D[1]
    MOVZ  X24, #0x9cb8, LSL #0
    MOVK  X24, #0x12c7, LSL #16
    MOVK  X24, #0xec3b, LSL #32
    MOVK  X24, #0x3ead, LSL #48
    SUB  X26, X24, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, D3
    MOVZ  X24, #0x610e, LSL #0
    MOVK  X24, #0x1256, LSL #16
    MOVK  X24, #0xb5b4, LSL #32
    MOVK  X24, #0x4a3e, LSL #48
    SUB  X26, X24, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X27, #0x3d05, LSL #0
    MOVK  X27, #0x17fb, LSL #16
    MOVK  X27, #0xf8c, LSL #32
    MOVK  X27, #0x344b, LSL #48
    SUB  X26, X27, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D4
    MOVZ  X27, #0xe5a, LSL #0
    MOVK  X27, #0xb8b3, LSL #16
    MOVK  X27, #0xf9a9, LSL #32
    MOVK  X27, #0x56db, LSL #48
    SUB  X26, X27, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, V5.D[1]
    MOVZ  X23, #0xe535, LSL #0
    MOVK  X23, #0xd82f, LSL #16
    MOVK  X23, #0x3fb5, LSL #32
    MOVK  X23, #0x1b94, LSL #48
    SUB  X9, X23, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, D5
    MOVZ  X23, #0x4510, LSL #0
    MOVK  X23, #0xe8b1, LSL #16
    MOVK  X23, #0xeb0e, LSL #32
    MOVK  X23, #0x784, LSL #48
    SUB  X9, X23, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, V6.D[1]
    MOVZ  X12, #0x7554, LSL #0
    MOVK  X12, #0xd245, LSL #16
    MOVK  X12, #0xe3a3, LSL #32
    MOVK  X12, #0x5ffa, LSL #48
    SUB  X23, X12, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, D6
    MOVZ  X12, #0x3f40, LSL #0
    MOVK  X12, #0x1342, LSL #16
    MOVK  X12, #0x47ea, LSL #32
    MOVK  X12, #0x5cfa, LSL #48
    SUB  X23, X12, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X23, #0x9b13, LSL #0
    MOVK  X23, #0xbc37, LSL #16
    MOVK  X23, #0xd29, LSL #32
    MOVK  X23, #0xea58, LSL #48
    SUB  X21, X23, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, D7
    MOVZ  X23, #0xec73, LSL #0
    MOVK  X23, #0xc87f, LSL #16
    MOVK  X23, #0xd5c9, LSL #32
    MOVK  X23, #0xebe2, LSL #48
    SUB  X21, X23, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X3, #0xd3b4, LSL #0
    MOVK  X3, #0x3648, LSL #16
    MOVK  X3, #0x8592, LSL #32
    MOVK  X3, #0x5959, LSL #48
    SUB  X28, X3, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, D8
    MOVZ  X3, #0x610d, LSL #0
    MOVK  X3, #0x1820, LSL #16
    MOVK  X3, #0xdfbd, LSL #32
    MOVK  X3, #0x976c, LSL #48
    SUB  X28, X3, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, V9.D[1]
    MOVZ  X16, #0x5b90, LSL #0
    MOVK  X16, #0xb13, LSL #16
    MOVK  X16, #0x3c36, LSL #32
    MOVK  X16, #0xf1e0, LSL #48
    SUB  X21, X16, X19
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, D9
    MOVZ  X16, #0x4cd4, LSL #0
    MOVK  X16, #0x889e, LSL #16
    MOVK  X16, #0x9be1, LSL #32
    MOVK  X16, #0x511c, LSL #48
    SUB  X21, X16, X19
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, V10.D[1]
    MOVZ  X12, #0x5ec1, LSL #0
    MOVK  X12, #0x83e7, LSL #16
    MOVK  X12, #0x3649, LSL #32
    MOVK  X12, #0x49c3, LSL #48
    SUB  X13, X12, X29
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, D10
    MOVZ  X12, #0x4f00, LSL #0
    MOVK  X12, #0x3207, LSL #16
    MOVK  X12, #0x86d6, LSL #32
    MOVK  X12, #0xda6e, LSL #48
    SUB  X13, X12, X29
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X3, #0x8dc1, LSL #0
TaishanSimdUnaryArithmeticP01_label_137:
    MOVK  X3, #0x73ad, LSL #16
    MOVK  X3, #0x5b25, LSL #32
    MOVK  X3, #0xf5df, LSL #48
    SUB  X13, X3, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, D11
    MOVZ  X3, #0xe7be, LSL #0
    MOVK  X3, #0xf43, LSL #16
    MOVK  X3, #0xe7d0, LSL #32
    MOVK  X3, #0x2a06, LSL #48
    SUB  X13, X3, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X27, #0x6487, LSL #0
    MOVK  X27, #0x64c2, LSL #16
    MOVK  X27, #0xdd8c, LSL #32
    MOVK  X27, #0x91ad, LSL #48
    SUB  X14, X27, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X10, D12
    MOVZ  X27, #0x69dd, LSL #0
    MOVK  X27, #0x4135, LSL #16
    MOVK  X27, #0x4045, LSL #32
    MOVK  X27, #0x60ed, LSL #48
    SUB  X14, X27, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, V13.D[1]
    MOVZ  X3, #0x9713, LSL #0
    MOVK  X3, #0xc224, LSL #16
    MOVK  X3, #0x5a29, LSL #32
    MOVK  X3, #0xfc71, LSL #48
    SUB  X14, X3, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, D13
    MOVZ  X3, #0xe047, LSL #0
    MOVK  X3, #0xbbf7, LSL #16
    MOVK  X3, #0x9f3a, LSL #32
    MOVK  X3, #0xb92c, LSL #48
    SUB  X14, X3, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X19, #0x4491, LSL #0
    MOVK  X19, #0xb607, LSL #16
    MOVK  X19, #0x5305, LSL #32
    MOVK  X19, #0xf35b, LSL #48
    SUB  X10, X19, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, D14
    MOVZ  X19, #0x35c9, LSL #0
    MOVK  X19, #0xd6fc, LSL #16
    MOVK  X19, #0x27, LSL #32
    MOVK  X19, #0xf094, LSL #48
    SUB  X10, X19, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X16, #0x253b, LSL #0
    MOVK  X16, #0x4541, LSL #16
    MOVK  X16, #0x312a, LSL #32
    MOVK  X16, #0xa174, LSL #48
    SUB  X10, X16, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, D15
    MOVZ  X16, #0xa98, LSL #0
    MOVK  X16, #0xc194, LSL #16
    MOVK  X16, #0x412d, LSL #32
    MOVK  X16, #0x6989, LSL #48
    SUB  X10, X16, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X12, X28, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, D16
    MOVZ  X28, #0x525d, LSL #0
    MOVK  X28, #0xb546, LSL #16
    SUB  X12, X28, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, V17.D[1]
    MOVZ  X7, #0x4158, LSL #0
    MOVK  X7, #0xf0e1, LSL #16
    MOVK  X7, #0x7271, LSL #32
    MOVK  X7, #0x73e8, LSL #48
    SUB  X24, X7, X15
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, D17
    MOVZ  X7, #0xb510, LSL #0
    MOVK  X7, #0xae0d, LSL #16
    MOVK  X7, #0x988e, LSL #32
    MOVK  X7, #0xec09, LSL #48
    SUB  X24, X7, X15
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X5, #0xdb1b, LSL #0
    MOVK  X5, #0xfa39, LSL #16
    MOVK  X5, #0x31f7, LSL #32
    MOVK  X5, #0xe1b1, LSL #48
    SUB  X21, X5, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X16, D18
    MOVZ  X5, #0xf97e, LSL #0
    MOVK  X5, #0x8d22, LSL #16
    MOVK  X5, #0xaee4, LSL #32
    MOVK  X5, #0xbae5, LSL #48
    SUB  X21, X5, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X27, #0xb6ef, LSL #0
    MOVK  X27, #0x38b2, LSL #16
    MOVK  X27, #0x8ff5, LSL #32
    MOVK  X27, #0x2ac5, LSL #48
    SUB  X7, X27, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, D19
    MOVZ  X27, #0xc8c1, LSL #0
    MOVK  X27, #0x4774, LSL #16
    MOVK  X27, #0xdee1, LSL #32
    MOVK  X27, #0xe853, LSL #48
    SUB  X7, X27, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, V20.D[1]
    MOVZ  X27, #0x672f, LSL #0
    MOVK  X27, #0x48bd, LSL #16
    MOVK  X27, #0x9064, LSL #32
    MOVK  X27, #0x7e03, LSL #48
    SUB  X25, X27, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, D20
    MOVZ  X27, #0x7149, LSL #0
    MOVK  X27, #0xde96, LSL #16
    MOVK  X27, #0xa8c9, LSL #32
    MOVK  X27, #0x8215, LSL #48
    SUB  X25, X27, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X10, #0x8f68, LSL #0
    MOVK  X10, #0x4da2, LSL #16
    MOVK  X10, #0xb2b2, LSL #32
    MOVK  X10, #0x2772, LSL #48
    SUB  X19, X10, X7
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, D21
    MOVZ  X10, #0x77a, LSL #0
    MOVK  X10, #0x2fa1, LSL #16
    MOVK  X10, #0x82b4, LSL #32
    MOVK  X10, #0x3cfb, LSL #48
    SUB  X19, X10, X7
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X5, #0x337e, LSL #0
    MOVK  X5, #0x4e70, LSL #16
    MOVK  X5, #0x3dfe, LSL #32
    MOVK  X5, #0x61c6, LSL #48
    SUB  X12, X5, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, D23
    MOVZ  X5, #0x346d, LSL #0
    MOVK  X5, #0xf63, LSL #16
    MOVK  X5, #0x993c, LSL #32
    MOVK  X5, #0x41e0, LSL #48
    SUB  X12, X5, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, V24.D[1]
    MOVZ  X13, #0x5fcb, LSL #0
    MOVK  X13, #0x9e98, LSL #16
    MOVK  X13, #0x1c8d, LSL #32
    MOVK  X13, #0x1adf, LSL #48
    SUB  X8, X13, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, D24
    MOVZ  X13, #0xa119, LSL #0
    MOVK  X13, #0x63ce, LSL #16
    MOVK  X13, #0x25a5, LSL #32
    MOVK  X13, #0xde45, LSL #48
    SUB  X8, X13, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, V25.D[1]
    MOVZ  X9, #0x7d0b, LSL #0
    MOVK  X9, #0x8b22, LSL #16
    MOVK  X9, #0x280, LSL #32
    MOVK  X9, #0xb13c, LSL #48
    SUB  X23, X9, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, D25
    MOVZ  X9, #0x363e, LSL #0
    MOVK  X9, #0x683d, LSL #16
    MOVK  X9, #0x6887, LSL #32
    MOVK  X9, #0xedb5, LSL #48
    SUB  X23, X9, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X16, #0xddb5, LSL #0
    MOVK  X16, #0xf6f, LSL #16
    MOVK  X16, #0x7ce7, LSL #32
    MOVK  X16, #0x438d, LSL #48
    SUB  X6, X16, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, D26
    MOVZ  X16, #0xa373, LSL #0
    MOVK  X16, #0x7655, LSL #16
    MOVK  X16, #0x8129, LSL #32
    MOVK  X16, #0xc69f, LSL #48
    SUB  X6, X16, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, V27.D[1]
    MOVZ  X17, #0x13d4, LSL #0
    MOVK  X17, #0xd7c5, LSL #16
    MOVK  X17, #0x267a, LSL #32
    MOVK  X17, #0x6912, LSL #48
    SUB  X19, X17, X25
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, D27
    MOVZ  X17, #0xde7a, LSL #0
    MOVK  X17, #0x28e3, LSL #16
    MOVK  X17, #0x2a6d, LSL #32
    MOVK  X17, #0x6d7c, LSL #48
    SUB  X19, X17, X25
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, V28.D[1]
    MOVZ  X19, #0xf947, LSL #0
    MOVK  X19, #0xca28, LSL #16
    MOVK  X19, #0xf61a, LSL #32
    MOVK  X19, #0xad8c, LSL #48
    SUB  X29, X19, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, D28
    MOVZ  X19, #0x2355, LSL #0
    MOVK  X19, #0x7cfd, LSL #16
    MOVK  X19, #0x6fb, LSL #32
    MOVK  X19, #0x7035, LSL #48
    SUB  X29, X19, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, V29.D[1]
    MOVZ  X9, #0x6bfd, LSL #0
    MOVK  X9, #0x78bd, LSL #16
    MOVK  X9, #0x996e, LSL #32
    MOVK  X9, #0xc567, LSL #48
    SUB  X18, X9, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, D29
    MOVZ  X9, #0x2f9c, LSL #0
    MOVK  X9, #0xf124, LSL #16
    MOVK  X9, #0xe09b, LSL #32
    MOVK  X9, #0x381c, LSL #48
    SUB  X18, X9, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
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
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X25
    FMOV  V0.D[1], X2
    FMOV  D1, X29
    FMOV  V1.D[1], X5
    FMOV  D2, X23
    FMOV  V2.D[1], X13
    FMOV  D3, X24
    FMOV  V3.D[1], X8
    FMOV  D4, X10
    FMOV  V4.D[1], X12
    FMOV  D5, X3
    FMOV  V5.D[1], X12
    FMOV  D6, X28
    FMOV  V6.D[1], X19
    FMOV  D7, X8
    FMOV  V7.D[1], X4
    FMOV  D8, X27
    FMOV  V8.D[1], X18
    FMOV  D9, X12
    FMOV  V9.D[1], X19
    FMOV  D10, X11
    FMOV  V10.D[1], X4
    FMOV  D11, X24
    FMOV  V11.D[1], X7
    FMOV  D12, X8
    FMOV  V12.D[1], X13
    FMOV  D13, X12
    FMOV  V13.D[1], X21
TaishanSimdUnaryArithmeticP01_label_343:
    FMOV  D14, X5
    FMOV  V14.D[1], X8
    FMOV  D15, X25
    FMOV  V15.D[1], X5
    FMOV  D16, X18
    FMOV  V16.D[1], X3
    FMOV  D17, X26
    FMOV  V17.D[1], X26
    FMOV  D18, X24
    FMOV  V18.D[1], X19
    FMOV  D19, X6
    FMOV  V19.D[1], X15
    FMOV  D20, X17
    FMOV  V20.D[1], X19
    FMOV  D21, X15
    FMOV  V21.D[1], X14
    FMOV  D22, X13
    FMOV  V22.D[1], X8
    FMOV  D23, X14
    FMOV  V23.D[1], X28
    FMOV  D24, X23
    FMOV  V24.D[1], X7
    FMOV  D25, X12
    FMOV  V25.D[1], X11
    FMOV  D26, X25
    FMOV  V26.D[1], X11
    FMOV  D27, X17
    FMOV  V27.D[1], X6
    FMOV  D28, X13
    FMOV  V28.D[1], X19
    FMOV  D29, X20
    FMOV  V29.D[1], X18
    FMOV  D30, X20
    FMOV  V30.D[1], X19
    FMOV  D31, X6
    FMOV  V31.D[1], X18
    MOVZ  X14, #0xa, LSL #0
TaishanSimdUnaryArithmeticP01_label_578:
    SHA1P  Q29, S20, V10.4S
    SHA256SU0  V4.4S, V27.4S
TaishanSimdUnaryArithmeticP01_label_171:
    SHA1SU1  V21.4S, V21.4S
    SHA1H  S0, S12
    SHA256SU0  V25.4S, V27.4S
    AESE  V0.16B, V24.16B
    AESD  V5.16B, V10.16B
    SHA1H  S29, S0
    SHA1H  S26, S5
    SHA1H  S26, S11
    SHA256SU1  V31.4S, V20.4S, V28.4S
    AESMC  V19.16B, V5.16B
    SHA256SU1  V25.4S, V29.4S, V5.4S
    AESD  V9.16B, V20.16B
    AESE  V14.16B, V27.16B
    SHA1C  Q9, S27, V12.4S
    SHA256SU1  V27.4S, V25.4S, V30.4S
    SHA256SU1  V3.4S, V14.4S, V0.4S
    SHA256H2  Q26, Q13, V22.4S
    AESD  V18.16B, V19.16B
    SHA1H  S28, S31
    SHA1C  Q25, S25, V24.4S
    SHA1SU0  V11.4S, V28.4S, V1.4S
    SHA1SU1  V1.4S, V23.4S
    SHA1SU1  V8.4S, V28.4S
    AESMC  V12.16B, V25.16B
    AESMC  V31.16B, V4.16B
    SHA1H  S18, S0
    AESE  V21.16B, V15.16B
    SHA256H  Q0, Q12, V4.4S
    SHA256H  Q21, Q6, V0.4S
    AESIMC  V26.16B, V8.16B
    SHA256SU0  V19.4S, V19.4S
    SHA256SU1  V25.4S, V9.4S, V13.4S
    SHA1SU0  V18.4S, V15.4S, V20.4S
    SHA1H  S10, S31
    SHA256SU1  V19.4S, V14.4S, V5.4S
    SHA256H2  Q25, Q16, V7.4S
    SHA1C  Q16, S30, V24.4S
    AESD  V26.16B, V30.16B
    SHA1SU1  V10.4S, V29.4S
    SHA1M  Q14, S12, V11.4S
    AESIMC  V30.16B, V7.16B
    SHA1SU0  V14.4S, V20.4S, V8.4S
    SHA256SU0  V8.4S, V0.4S
    SHA1H  S20, S9
    SHA1P  Q18, S5, V9.4S
    SHA1SU1  V15.4S, V1.4S
    AESIMC  V11.16B, V16.16B
    SHA1H  S19, S25
    SHA1M  Q31, S14, V21.4S
    SHA256H2  Q15, Q24, V18.4S
    AESMC  V16.16B, V13.16B
    SHA1H  S28, S4
    AESD  V7.16B, V7.16B
    AESIMC  V1.16B, V14.16B
    SHA1SU0  V16.4S, V9.4S, V6.4S
    SHA1C  Q14, S2, V7.4S
    SHA1SU0  V15.4S, V6.4S, V16.4S
    SHA1M  Q30, S9, V18.4S
    SHA1C  Q8, S31, V7.4S
    SHA1C  Q0, S12, V31.4S
    SHA256H  Q6, Q27, V13.4S
    SHA1SU0  V7.4S, V18.4S, V30.4S
    SHA1SU0  V19.4S, V2.4S, V4.4S
    SHA256H  Q31, Q29, V15.4S
    SHA1H  S29, S10
    SHA1P  Q27, S30, V5.4S
    SHA1P  Q4, S17, V21.4S
    AESD  V31.16B, V16.16B
    SHA256SU1  V30.4S, V0.4S, V28.4S
    SHA256H2  Q26, Q0, V25.4S
    SHA1P  Q31, S13, V3.4S
    AESIMC  V9.16B, V8.16B
    SHA1P  Q21, S5, V8.4S
    SHA256H  Q18, Q2, V28.4S
    SHA1SU1  V17.4S, V21.4S
    SHA1C  Q2, S17, V6.4S
    SHA1M  Q6, S25, V10.4S
    SHA256SU0  V29.4S, V23.4S
    SHA1P  Q0, S26, V1.4S
    SHA256SU0  V7.4S, V13.4S
    SHA256H  Q30, Q3, V5.4S
    AESE  V30.16B, V17.16B
    SHA256SU1  V20.4S, V27.4S, V28.4S
    SHA1SU1  V5.4S, V27.4S
    SHA256H2  Q0, Q30, V28.4S
    AESIMC  V12.16B, V4.16B
    SHA1SU0  V19.4S, V9.4S, V25.4S
    SHA1M  Q31, S15, V16.4S
    SHA1H  S26, S21
    AESMC  V10.16B, V29.16B
    AESIMC  V26.16B, V0.16B
    SHA256H2  Q4, Q5, V4.4S
    SHA256H2  Q23, Q6, V27.4S
    SHA256H2  Q20, Q30, V21.4S
    AESD  V12.16B, V31.16B
    SHA256H2  Q19, Q29, V8.4S
    AESMC  V11.16B, V19.16B
    SHA256SU0  V13.4S, V21.4S
    AESIMC  V28.16B, V8.16B
    SHA1C  Q6, S31, V21.4S
    SHA1SU1  V3.4S, V9.4S
    AESD  V30.16B, V13.16B
    SHA1P  Q8, S3, V1.4S
    SHA1M  Q20, S0, V14.4S
    SHA1C  Q15, S5, V8.4S
    SHA256SU1  V8.4S, V7.4S, V30.4S
    SHA256H  Q30, Q8, V25.4S
    SHA256SU0  V25.4S, V11.4S
    AESMC  V14.16B, V27.16B
    AESMC  V29.16B, V28.16B
    SHA1H  S25, S20
    AESE  V11.16B, V3.16B
    SHA1H  S27, S23
    SHA256H2  Q20, Q6, V2.4S
    SHA1C  Q29, S8, V27.4S
    AESE  V6.16B, V19.16B
    SHA256SU0  V28.4S, V19.4S
    AESMC  V5.16B, V9.16B
    AESD  V13.16B, V13.16B
    SHA256H2  Q2, Q0, V1.4S
    SHA256SU1  V11.4S, V6.4S, V16.4S
    SHA1SU1  V14.4S, V19.4S
    SHA1M  Q2, S1, V27.4S
    SHA256H  Q18, Q29, V2.4S
    SHA1H  S23, S7
    SHA256SU0  V8.4S, V7.4S
    SHA256H  Q9, Q26, V21.4S
    AESIMC  V23.16B, V2.16B
    SHA1C  Q16, S3, V20.4S
    SHA1C  Q3, S3, V6.4S
    SHA1M  Q30, S3, V20.4S
    SHA1SU0  V14.4S, V19.4S, V19.4S
    SHA256H2  Q23, Q30, V14.4S
    AESIMC  V28.16B, V17.16B
    SHA1P  Q7, S31, V16.4S
    SHA1SU1  V24.4S, V19.4S
    SHA1M  Q23, S21, V1.4S
    SHA256SU1  V27.4S, V1.4S, V5.4S
    SHA1SU0  V15.4S, V0.4S, V8.4S
    SHA256H  Q24, Q23, V14.4S
    SHA256H  Q24, Q9, V20.4S
    SHA1SU1  V28.4S, V27.4S
    AESIMC  V7.16B, V6.16B
    SHA1P  Q29, S30, V18.4S
    SHA1SU0  V24.4S, V9.4S, V11.4S
    AESMC  V30.16B, V3.16B
    SHA1M  Q27, S21, V18.4S
    SHA1P  Q2, S0, V2.4S
    SHA1SU0  V23.4S, V12.4S, V29.4S
    SHA256H  Q15, Q27, V16.4S
    AESD  V15.16B, V30.16B
    SHA1P  Q20, S19, V2.4S
    SHA1M  Q2, S15, V19.4S
    AESE  V31.16B, V15.16B
    SHA256H  Q14, Q3, V14.4S
    SHA256SU0  V9.4S, V17.4S
    SHA1C  Q21, S11, V15.4S
    SHA256H  Q6, Q3, V12.4S
    SHA256H2  Q22, Q4, V10.4S
    AESIMC  V12.16B, V6.16B
    SHA1H  S24, S17
    SHA256SU0  V1.4S, V11.4S
    SHA1M  Q1, S15, V21.4S
    SHA256SU0  V2.4S, V31.4S
    SHA1H  S30, S21
    SHA1M  Q22, S13, V0.4S
    SHA1H  S14, S17
    AESD  V2.16B, V16.16B
    SHA256H  Q6, Q9, V14.4S
    SHA1C  Q14, S22, V18.4S
    AESD  V30.16B, V10.16B
    SHA1P  Q0, S11, V13.4S
    SHA256H  Q12, Q8, V29.4S
    SHA1C  Q0, S23, V3.4S
    SHA1C  Q23, S14, V4.4S
    SHA1M  Q25, S10, V29.4S
    SHA256SU0  V3.4S, V17.4S
    SHA256H2  Q14, Q30, V4.4S
    AESIMC  V11.16B, V10.16B
    AESIMC  V8.16B, V25.16B
    SHA256H  Q15, Q0, V24.4S
    SHA256SU1  V0.4S, V28.4S, V7.4S
    AESE  V23.16B, V0.16B
    SHA1H  S13, S29
    AESMC  V22.16B, V25.16B
    SHA1H  S6, S18
    SHA256H2  Q27, Q22, V3.4S
    AESMC  V25.16B, V14.16B
    SHA1H  S24, S26
    AESMC  V1.16B, V9.16B
    AESIMC  V27.16B, V30.16B
    AESMC  V29.16B, V4.16B
    SHA1M  Q24, S30, V0.4S
    AESE  V13.16B, V27.16B
    AESD  V5.16B, V26.16B
    SHA256SU1  V25.4S, V16.4S, V9.4S
    AESMC  V24.16B, V25.16B
    AESIMC  V27.16B, V4.16B
    SUBS  X14, X14, #0x1
    B.NE  TaishanSimdUnaryArithmeticP01_label_578
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X3, X20, X4
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X27, X19, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X20, X28, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X11
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X14
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X14, X15, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X19, X15, X16
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X17
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X18
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X26, X13, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X20, X4, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X8, X28, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X29, X19, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, V2.D[1]
    MOVZ  X14, #0x9cc0, LSL #0
    MOVK  X14, #0x1e22, LSL #16
    MOVK  X14, #0x262e, LSL #32
    MOVK  X14, #0x54a9, LSL #48
    SUB  X6, X14, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, D2
    MOVZ  X14, #0x8473, LSL #0
    MOVK  X14, #0x177d, LSL #16
    MOVK  X14, #0x28a4, LSL #32
    MOVK  X14, #0xf3e3, LSL #48
    SUB  X6, X14, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X25, #0xf0c8, LSL #0
    MOVK  X25, #0xb4a3, LSL #16
    MOVK  X25, #0xec28, LSL #32
    MOVK  X25, #0xd74, LSL #48
    SUB  X19, X25, X11
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, D3
    MOVZ  X25, #0x164f, LSL #0
    MOVK  X25, #0x33f5, LSL #16
    MOVK  X25, #0x887e, LSL #32
    MOVK  X25, #0x1b4a, LSL #48
    SUB  X19, X25, X11
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X29, #0xf1bb, LSL #0
    MOVK  X29, #0xa1a7, LSL #16
    MOVK  X29, #0x99a8, LSL #32
    MOVK  X29, #0x8756, LSL #48
    SUB  X21, X29, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, D4
    MOVZ  X29, #0xa5c0, LSL #0
    MOVK  X29, #0x16d5, LSL #16
    MOVK  X29, #0x52bc, LSL #32
    MOVK  X29, #0x9ce2, LSL #48
    SUB  X21, X29, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X26, #0xa724, LSL #0
    MOVK  X26, #0xe3db, LSL #16
    MOVK  X26, #0x3ee6, LSL #32
    MOVK  X26, #0x2b9d, LSL #48
    SUB  X4, X26, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, D5
    MOVZ  X26, #0x8d53, LSL #0
    MOVK  X26, #0xd9e8, LSL #16
    MOVK  X26, #0x90c2, LSL #32
    MOVK  X26, #0x1697, LSL #48
    SUB  X4, X26, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, V6.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X4, X18, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, D6
    MOVZ  X18, #0x7ef7, LSL #0
    MOVK  X18, #0xb836, LSL #16
    SUB  X4, X18, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X18, #0x50f2, LSL #0
    MOVK  X18, #0xfaca, LSL #16
    MOVK  X18, #0x3096, LSL #32
    MOVK  X18, #0x806f, LSL #48
    SUB  X20, X18, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, D7
    MOVZ  X18, #0x3d30, LSL #0
    MOVK  X18, #0x13c3, LSL #16
    MOVK  X18, #0x50bf, LSL #32
    MOVK  X18, #0x5ffd, LSL #48
    SUB  X20, X18, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, V8.D[1]
    MOVZ  X20, #0xf006, LSL #0
    MOVK  X20, #0x1225, LSL #16
    MOVK  X20, #0x2211, LSL #32
    MOVK  X20, #0xe381, LSL #48
    SUB  X23, X20, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, D8
    MOVZ  X20, #0x1ec6, LSL #0
    MOVK  X20, #0x8864, LSL #16
    MOVK  X20, #0xdff0, LSL #32
    MOVK  X20, #0xf792, LSL #48
    SUB  X23, X20, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, V9.D[1]
    MOVZ  X3, #0xbbb1, LSL #0
    MOVK  X3, #0xc073, LSL #16
    MOVK  X3, #0x2692, LSL #32
    MOVK  X3, #0x4125, LSL #48
    SUB  X14, X3, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, D9
    MOVZ  X3, #0x28bc, LSL #0
    MOVK  X3, #0xe6e5, LSL #16
    MOVK  X3, #0xe696, LSL #32
    MOVK  X3, #0x7143, LSL #48
    SUB  X14, X3, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, V10.D[1]
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x57bc, LSL #32
    MOVK  X21, #0x1b73, LSL #48
    SUB  X23, X21, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, D10
    MOVZ  X21, #0x2f24, LSL #0
    MOVK  X21, #0x5ef6, LSL #16
    SUB  X23, X21, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xc397, LSL #32
    MOVK  X18, #0x9245, LSL #48
    SUB  X8, X18, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D11
    MOVZ  X18, #0x959b, LSL #0
    MOVK  X18, #0xb914, LSL #16
    SUB  X8, X18, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X15, #0x3fb, LSL #0
    MOVK  X15, #0x59ee, LSL #16
    MOVK  X15, #0x321c, LSL #32
    MOVK  X15, #0xa0b1, LSL #48
    SUB  X7, X15, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, D12
    MOVZ  X15, #0xe3ae, LSL #0
    MOVK  X15, #0x617, LSL #16
    MOVK  X15, #0xb0aa, LSL #32
    MOVK  X15, #0x8228, LSL #48
    SUB  X7, X15, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, V13.D[1]
    MOVZ  X3, #0x6378, LSL #0
    MOVK  X3, #0x9dbb, LSL #16
    MOVK  X3, #0x668d, LSL #32
    MOVK  X3, #0xa264, LSL #48
    SUB  X19, X3, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, D13
    MOVZ  X3, #0x5d25, LSL #0
    MOVK  X3, #0x8c35, LSL #16
    MOVK  X3, #0xa10b, LSL #32
    MOVK  X3, #0x1f0f, LSL #48
    SUB  X19, X3, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X27, #0x73cf, LSL #0
    MOVK  X27, #0xd6a5, LSL #16
    MOVK  X27, #0x48eb, LSL #32
    MOVK  X27, #0xb2a2, LSL #48
    SUB  X24, X27, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, D14
    MOVZ  X27, #0x5c22, LSL #0
    MOVK  X27, #0x848b, LSL #16
    MOVK  X27, #0x4238, LSL #32
    MOVK  X27, #0xb2ff, LSL #48
    SUB  X24, X27, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X10, #0xe487, LSL #0
    MOVK  X10, #0x4d4, LSL #16
    MOVK  X10, #0x9581, LSL #32
    MOVK  X10, #0x340f, LSL #48
    SUB  X29, X10, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, D15
    MOVZ  X10, #0x459b, LSL #0
    MOVK  X10, #0x7a4e, LSL #16
    MOVK  X10, #0xf27d, LSL #32
    MOVK  X10, #0x714, LSL #48
    SUB  X29, X10, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X8, #0x737a, LSL #0
    MOVK  X8, #0xae7d, LSL #16
    MOVK  X8, #0x1a9, LSL #32
    MOVK  X8, #0x17d6, LSL #48
    SUB  X29, X8, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, D16
    MOVZ  X8, #0x9461, LSL #0
    MOVK  X8, #0x26fe, LSL #16
    MOVK  X8, #0xdd0b, LSL #32
    MOVK  X8, #0xff6f, LSL #48
    SUB  X29, X8, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, V17.D[1]
    MOVZ  X25, #0x303b, LSL #0
    MOVK  X25, #0xeca0, LSL #16
    MOVK  X25, #0x5755, LSL #32
    MOVK  X25, #0x2cf, LSL #48
    SUB  X11, X25, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, D17
    MOVZ  X25, #0x1fe9, LSL #0
    MOVK  X25, #0x35c9, LSL #16
    MOVK  X25, #0xd819, LSL #32
    MOVK  X25, #0xe279, LSL #48
    SUB  X11, X25, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X16, #0xea2c, LSL #0
    MOVK  X16, #0x1c1f, LSL #16
    MOVK  X16, #0x580b, LSL #32
    MOVK  X16, #0xc768, LSL #48
    SUB  X15, X16, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X10, D18
    MOVZ  X16, #0xfbde, LSL #0
    MOVK  X16, #0xe0d9, LSL #16
    MOVK  X16, #0xfdf, LSL #32
    MOVK  X16, #0x61b7, LSL #48
    SUB  X15, X16, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, V19.D[1]
    MOVZ  X6, #0x9d0, LSL #0
    MOVK  X6, #0x4474, LSL #16
    MOVK  X6, #0x7a0, LSL #32
    MOVK  X6, #0x333, LSL #48
    SUB  X25, X6, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, D19
    MOVZ  X6, #0xcf3f, LSL #0
    MOVK  X6, #0x6a7e, LSL #16
    MOVK  X6, #0x2121, LSL #32
    MOVK  X6, #0xdb62, LSL #48
    SUB  X25, X6, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, V20.D[1]
    MOVZ  X12, #0x5d92, LSL #0
    MOVK  X12, #0x8658, LSL #16
    MOVK  X12, #0xf4a, LSL #32
    MOVK  X12, #0x6fe0, LSL #48
    SUB  X18, X12, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, D20
    MOVZ  X12, #0x352b, LSL #0
    MOVK  X12, #0xbd46, LSL #16
    MOVK  X12, #0x7049, LSL #32
    MOVK  X12, #0xe2d0, LSL #48
    SUB  X18, X12, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X27, #0xbb48, LSL #0
    MOVK  X27, #0x6a09, LSL #16
    MOVK  X27, #0x2c25, LSL #32
    MOVK  X27, #0xfee1, LSL #48
    SUB  X5, X27, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, D21
    MOVZ  X27, #0x8ab6, LSL #0
    MOVK  X27, #0x617d, LSL #16
    MOVK  X27, #0x178e, LSL #32
    MOVK  X27, #0x6617, LSL #48
    SUB  X5, X27, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X26, #0x9ea1, LSL #0
    MOVK  X26, #0xbdb3, LSL #16
    MOVK  X26, #0x5f5e, LSL #32
    MOVK  X26, #0xdc47, LSL #48
    SUB  X11, X26, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, D23
    MOVZ  X26, #0x7193, LSL #0
    MOVK  X26, #0x564a, LSL #16
    MOVK  X26, #0x88a9, LSL #32
    MOVK  X26, #0x4ba1, LSL #48
    SUB  X11, X26, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X3, #0xb53c, LSL #0
    MOVK  X3, #0x4ea4, LSL #16
    MOVK  X3, #0xb462, LSL #32
    MOVK  X3, #0x7bf9, LSL #48
    SUB  X28, X3, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, D24
    MOVZ  X3, #0xa5cc, LSL #0
    MOVK  X3, #0xff80, LSL #16
    MOVK  X3, #0xa527, LSL #32
    MOVK  X3, #0x8cfa, LSL #48
    SUB  X28, X3, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X18, #0x35, LSL #0
    MOVK  X18, #0x3d6b, LSL #16
    MOVK  X18, #0xfd4d, LSL #32
    MOVK  X18, #0x9a7e, LSL #48
    SUB  X21, X18, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, D25
    MOVZ  X18, #0x3a93, LSL #0
    MOVK  X18, #0x4cf3, LSL #16
    MOVK  X18, #0xaa74, LSL #32
    MOVK  X18, #0x705a, LSL #48
    SUB  X21, X18, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X16, #0xadb4, LSL #0
    MOVK  X16, #0xdc6, LSL #16
    MOVK  X16, #0xc18a, LSL #32
    MOVK  X16, #0xae51, LSL #48
    SUB  X7, X16, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, D26
    MOVZ  X16, #0xcee6, LSL #0
    MOVK  X16, #0xddf8, LSL #16
    MOVK  X16, #0x4b67, LSL #32
    MOVK  X16, #0x7767, LSL #48
    SUB  X7, X16, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, V27.D[1]
    MOVZ  X18, #0x1c45, LSL #0
    MOVK  X18, #0xd4c1, LSL #16
    MOVK  X18, #0xc5be, LSL #32
    MOVK  X18, #0x9b, LSL #48
    SUB  X21, X18, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, D27
    MOVZ  X18, #0x5ebf, LSL #0
    MOVK  X18, #0xbafd, LSL #16
    MOVK  X18, #0x4064, LSL #32
    MOVK  X18, #0xb501, LSL #48
    SUB  X21, X18, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X10, V28.D[1]
    MOVZ  X8, #0x2c9a, LSL #0
    MOVK  X8, #0xb9d8, LSL #16
    MOVK  X8, #0xf3f1, LSL #32
    MOVK  X8, #0xd6, LSL #48
    SUB  X18, X8, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X10, D28
    MOVZ  X8, #0xa71a, LSL #0
    MOVK  X8, #0x8e96, LSL #16
    MOVK  X8, #0xc6d9, LSL #32
    MOVK  X8, #0x563, LSL #48
    SUB  X18, X8, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, V29.D[1]
    MOVZ  X6, #0x1163, LSL #0
    MOVK  X6, #0xd9e7, LSL #16
    MOVK  X6, #0xfc2a, LSL #32
    MOVK  X6, #0x390f, LSL #48
    SUB  X16, X6, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, D29
    MOVZ  X6, #0xe3ac, LSL #0
    MOVK  X6, #0x7ee, LSL #16
    MOVK  X6, #0xb9eb, LSL #32
    MOVK  X6, #0x4c8e, LSL #48
    SUB  X16, X6, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
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
    FMOV  D0, X28
    FMOV  V0.D[1], X18
    FMOV  D1, X19
    FMOV  V1.D[1], X23
    FMOV  D2, X14
    FMOV  V2.D[1], X26
    FMOV  D3, X12
    FMOV  V3.D[1], X9
    FMOV  D4, X26
    FMOV  V4.D[1], X15
    FMOV  D5, X10
    FMOV  V5.D[1], X27
    FMOV  D6, X23
    FMOV  V6.D[1], X17
    FMOV  D7, X7
    FMOV  V7.D[1], X19
    FMOV  D8, X27
    FMOV  V8.D[1], X20
    FMOV  D9, X3
    FMOV  V9.D[1], X16
    FMOV  D10, X20
    FMOV  V10.D[1], X27
    FMOV  D11, X6
    FMOV  V11.D[1], X9
    FMOV  D12, X27
    FMOV  V12.D[1], X20
    FMOV  D13, X28
    FMOV  V13.D[1], X23
    FMOV  D14, X18
    FMOV  V14.D[1], X3
    FMOV  D15, X8
    FMOV  V15.D[1], X3
    FMOV  D16, X6
    FMOV  V16.D[1], X17
    FMOV  D17, X24
    FMOV  V17.D[1], X6
    FMOV  D18, X9
    FMOV  V18.D[1], X24
    FMOV  D19, X13
    FMOV  V19.D[1], X16
    FMOV  D20, X6
    FMOV  V20.D[1], X18
    FMOV  D21, X16
    FMOV  V21.D[1], X5
    FMOV  D22, X15
    FMOV  V22.D[1], X2
    FMOV  D23, X10
    FMOV  V23.D[1], X25
    FMOV  D24, X5
    FMOV  V24.D[1], X29
    FMOV  D25, X15
    FMOV  V25.D[1], X24
    FMOV  D26, X24
    FMOV  V26.D[1], X23
    FMOV  D27, X5
    FMOV  V27.D[1], X21
    FMOV  D28, X10
    FMOV  V28.D[1], X13
    FMOV  D29, X15
    FMOV  V29.D[1], X8
    FMOV  D30, X17
    FMOV  V30.D[1], X17
    FMOV  D31, X28
    FMOV  V31.D[1], X27
    MOVZ  X13, #0xf, LSL #0
TaishanSimdUnaryArithmeticP01_label_661:
    SHA1H  S6, S18
    AESD  V20.16B, V4.16B
    AESE  V26.16B, V11.16B
    SHA256H2  Q25, Q21, V30.4S
    SHA256H  Q6, Q28, V27.4S
    SHA1C  Q10, S17, V29.4S
    SHA1H  S26, S11
    SHA256H2  Q11, Q20, V7.4S
    SHA1C  Q16, S10, V28.4S
    SHA256SU0  V16.4S, V13.4S
    SHA1C  Q26, S31, V14.4S
    SHA1C  Q27, S4, V18.4S
    SHA1C  Q25, S19, V9.4S
    AESIMC  V15.16B, V19.16B
    SHA1P  Q9, S6, V23.4S
    SHA256H  Q24, Q23, V13.4S
    SHA256SU0  V25.4S, V6.4S
    SHA256H2  Q11, Q21, V11.4S
    SHA1C  Q4, S12, V30.4S
    SHA256SU0  V4.4S, V27.4S
    SHA1C  Q22, S31, V15.4S
    AESIMC  V6.16B, V31.16B
    SHA1SU1  V26.4S, V2.4S
    SHA1P  Q26, S5, V27.4S
    AESMC  V6.16B, V14.16B
    SHA1H  S6, S28
    AESE  V4.16B, V22.16B
    SHA256H2  Q23, Q26, V8.4S
    SHA1C  Q29, S21, V5.4S
    SHA1SU1  V2.4S, V19.4S
    SHA1H  S9, S23
    SHA256H2  Q24, Q16, V22.4S
    SHA1M  Q22, S11, V6.4S
    SHA1SU0  V0.4S, V25.4S, V25.4S
    AESMC  V25.16B, V25.16B
    AESD  V0.16B, V7.16B
    SHA1SU0  V22.4S, V28.4S, V9.4S
    SHA1P  Q21, S24, V6.4S
    SHA1H  S1, S1
    SHA1C  Q22, S6, V6.4S
    SHA256H  Q0, Q17, V31.4S
    AESE  V25.16B, V5.16B
    SHA256SU1  V26.4S, V26.4S, V11.4S
    AESD  V5.16B, V14.16B
    SHA1M  Q30, S13, V4.4S
    SHA1SU0  V30.4S, V14.4S, V22.4S
    AESD  V3.16B, V13.16B
    SHA1M  Q0, S0, V7.4S
    SHA1M  Q31, S24, V17.4S
    AESMC  V26.16B, V1.16B
    SHA1M  Q22, S27, V13.4S
    SHA1SU1  V1.4S, V14.4S
    AESIMC  V27.16B, V29.16B
    SHA256SU1  V15.4S, V4.4S, V24.4S
    SHA256SU1  V9.4S, V23.4S, V0.4S
    SHA1C  Q7, S2, V11.4S
    SHA1SU1  V17.4S, V29.4S
    SHA256SU0  V7.4S, V13.4S
    SHA256H  Q14, Q14, V14.4S
    SHA1SU0  V13.4S, V0.4S, V7.4S
    SHA1M  Q18, S15, V0.4S
    SHA1P  Q5, S18, V19.4S
    SHA1SU0  V4.4S, V3.4S, V31.4S
    SHA256SU0  V15.4S, V11.4S
    SHA1M  Q23, S10, V15.4S
    SHA1SU0  V27.4S, V9.4S, V20.4S
    SHA256SU0  V7.4S, V1.4S
    AESD  V27.16B, V11.16B
    AESD  V8.16B, V17.16B
    AESE  V24.16B, V22.16B
    SHA1C  Q28, S18, V23.4S
    SHA1P  Q1, S2, V12.4S
    AESD  V28.16B, V1.16B
    AESMC  V11.16B, V30.16B
    SHA1SU0  V3.4S, V31.4S, V24.4S
    AESMC  V23.16B, V31.16B
    AESMC  V3.16B, V27.16B
    SHA256SU0  V31.4S, V21.4S
    AESIMC  V20.16B, V19.16B
    AESE  V23.16B, V23.16B
    SHA1P  Q10, S25, V6.4S
    AESD  V20.16B, V1.16B
    SHA1SU0  V14.4S, V4.4S, V21.4S
    SHA1C  Q10, S15, V20.4S
    SHA1H  S22, S9
    AESMC  V30.16B, V7.16B
    SHA1H  S31, S5
    SHA1P  Q22, S10, V18.4S
    SHA256H2  Q22, Q20, V2.4S
    SHA1M  Q18, S27, V19.4S
    SHA1SU1  V28.4S, V27.4S
    SHA1P  Q5, S13, V29.4S
    SHA1SU0  V4.4S, V19.4S, V7.4S
    SHA1H  S19, S19
    SHA1H  S10, S1
    AESIMC  V8.16B, V14.16B
    AESIMC  V21.16B, V30.16B
    SHA256H2  Q7, Q26, V18.4S
    SHA256SU1  V8.4S, V30.4S, V29.4S
    SHA1C  Q9, S8, V27.4S
    AESE  V13.16B, V22.16B
    SHA1P  Q23, S20, V24.4S
    SHA1SU1  V20.4S, V11.4S
    SHA1SU0  V27.4S, V10.4S, V21.4S
    SHA256H2  Q7, Q17, V27.4S
    SHA256H2  Q22, Q31, V13.4S
    SHA1SU0  V6.4S, V9.4S, V18.4S
    SHA256SU1  V23.4S, V14.4S, V9.4S
    AESIMC  V1.16B, V19.16B
    SHA1SU1  V4.4S, V17.4S
    SHA1H  S20, S13
    AESMC  V16.16B, V27.16B
    AESD  V18.16B, V18.16B
    SHA1C  Q24, S16, V21.4S
    SHA256H2  Q24, Q19, V1.4S
    AESE  V24.16B, V20.16B
    SHA1SU1  V20.4S, V15.4S
    SHA256H2  Q20, Q29, V8.4S
    SHA256H2  Q21, Q24, V18.4S
    SHA1C  Q9, S6, V29.4S
    SHA256SU0  V1.4S, V30.4S
    SHA1M  Q4, S9, V7.4S
    SHA1M  Q6, S10, V8.4S
    SHA256SU0  V31.4S, V1.4S
    SHA256H  Q21, Q15, V31.4S
    AESIMC  V29.16B, V28.16B
    AESD  V11.16B, V13.16B
    AESD  V13.16B, V27.16B
    SHA1P  Q15, S22, V26.4S
    AESD  V0.16B, V21.16B
    SHA1C  Q21, S14, V19.4S
    SHA1M  Q4, S31, V24.4S
    SHA256H2  Q14, Q29, V1.4S
    SHA1M  Q19, S0, V7.4S
    SHA256H2  Q20, Q10, V3.4S
    SHA1P  Q20, S11, V9.4S
    SHA256SU0  V20.4S, V20.4S
    SHA1SU1  V11.4S, V13.4S
    AESMC  V22.16B, V18.16B
    SHA1P  Q6, S13, V14.4S
    SHA1SU1  V9.4S, V14.4S
    AESIMC  V18.16B, V2.16B
    SHA1SU0  V26.4S, V28.4S, V18.4S
    AESD  V12.16B, V15.16B
    SHA256SU1  V25.4S, V20.4S, V29.4S
    SHA1SU0  V0.4S, V4.4S, V31.4S
    AESMC  V28.16B, V22.16B
    SHA1H  S7, S24
    SHA256SU1  V13.4S, V3.4S, V10.4S
    SHA1SU1  V24.4S, V0.4S
    AESIMC  V4.16B, V17.16B
    SHA256SU0  V29.4S, V24.4S
    SHA1H  S5, S11
    AESIMC  V20.16B, V24.16B
    AESE  V18.16B, V30.16B
    SHA1M  Q31, S16, V13.4S
    SHA256SU0  V18.4S, V16.4S
    SHA1C  Q10, S0, V30.4S
    SHA1M  Q5, S19, V27.4S
    SHA1SU0  V23.4S, V16.4S, V5.4S
    SHA256H2  Q5, Q14, V3.4S
    SHA1M  Q10, S29, V24.4S
    SHA256SU1  V20.4S, V14.4S, V8.4S
    SHA1SU0  V27.4S, V28.4S, V23.4S
    AESD  V22.16B, V8.16B
    SHA1H  S11, S3
    SHA256SU1  V24.4S, V6.4S, V26.4S
    AESIMC  V13.16B, V29.16B
    SHA1C  Q30, S22, V10.4S
    AESD  V0.16B, V0.16B
    AESIMC  V6.16B, V10.16B
    SHA256SU0  V3.4S, V0.4S
    SHA256SU1  V0.4S, V23.4S, V26.4S
    SHA256H2  Q14, Q8, V8.4S
    AESMC  V17.16B, V17.16B
    SHA1P  Q28, S13, V25.4S
    SHA1SU1  V4.4S, V20.4S
    AESIMC  V4.16B, V20.16B
    SHA256SU1  V20.4S, V25.4S, V6.4S
    AESD  V23.16B, V22.16B
    SHA1M  Q14, S23, V22.4S
    SHA256SU0  V7.4S, V17.4S
    SHA256H  Q28, Q20, V7.4S
    SHA1P  Q10, S23, V1.4S
    SHA256H  Q5, Q6, V8.4S
    SHA256SU1  V6.4S, V19.4S, V29.4S
    AESD  V3.16B, V0.16B
    SHA256H  Q23, Q0, V13.4S
    SHA256SU1  V26.4S, V14.4S, V30.4S
    SHA1M  Q6, S13, V29.4S
    SHA256H  Q4, Q1, V23.4S
    AESIMC  V28.16B, V18.16B
    SHA256SU1  V25.4S, V1.4S, V3.4S
    AESIMC  V1.16B, V29.16B
    SHA256SU0  V26.4S, V29.4S
    SHA1M  Q20, S3, V8.4S
    SHA1M  Q7, S19, V8.4S
    SHA256H  Q19, Q9, V19.4S
    SHA256SU1  V27.4S, V25.4S, V24.4S
    SHA256SU0  V4.4S, V20.4S
    SUBS  X13, X13, #0x1
    B.NE  TaishanSimdUnaryArithmeticP01_label_661
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X12, X19, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X29, X10, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X28, X3, X4
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X5, X15, X5
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X2, X8, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X29, X10, X8
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X13, X11, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X14, X15, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X9, X24, X12
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X13, X12, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X15
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X10, X20, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X17
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X19, X18, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X24, X28, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X17, X18, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X17, X4, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X21, X6, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X17, X26, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X26, X12, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X27, X5, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X21, #0x7bf5, LSL #0
    MOVK  X21, #0xe70b, LSL #16
    MOVK  X21, #0x4d90, LSL #32
    MOVK  X21, #0xfc6c, LSL #48
    SUB  X13, X21, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D2
    MOVZ  X21, #0x49bd, LSL #0
    MOVK  X21, #0x8e32, LSL #16
    MOVK  X21, #0xee8f, LSL #32
    MOVK  X21, #0xd05f, LSL #48
    SUB  X13, X21, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, V3.D[1]
    MOVZ  X19, #0xc16f, LSL #0
    MOVK  X19, #0xc5ac, LSL #16
    MOVK  X19, #0xce78, LSL #32
    MOVK  X19, #0x7369, LSL #48
    SUB  X15, X19, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, D3
    MOVZ  X19, #0x4091, LSL #0
    MOVK  X19, #0xc097, LSL #16
    MOVK  X19, #0x2c5, LSL #32
    MOVK  X19, #0x1547, LSL #48
    SUB  X15, X19, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X26, #0x27ea, LSL #0
    MOVK  X26, #0x4c58, LSL #16
    MOVK  X26, #0xd901, LSL #32
    MOVK  X26, #0x411a, LSL #48
    SUB  X17, X26, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, D4
    MOVZ  X26, #0x2fa4, LSL #0
    MOVK  X26, #0xa46b, LSL #16
    MOVK  X26, #0x9ce3, LSL #32
    MOVK  X26, #0xca64, LSL #48
    SUB  X17, X26, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, V5.D[1]
    MOVZ  X16, #0xcfd7, LSL #0
    MOVK  X16, #0xcc51, LSL #16
    MOVK  X16, #0x5c5a, LSL #32
    MOVK  X16, #0x3d32, LSL #48
    SUB  X4, X16, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, D5
    MOVZ  X16, #0xa348, LSL #0
    MOVK  X16, #0x725, LSL #16
    MOVK  X16, #0x26b3, LSL #32
    MOVK  X16, #0xee90, LSL #48
    SUB  X4, X16, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X23, #0x10b9, LSL #0
    MOVK  X23, #0xedfe, LSL #16
    MOVK  X23, #0x8442, LSL #32
    MOVK  X23, #0x45ee, LSL #48
    SUB  X4, X23, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X16, D6
    MOVZ  X23, #0x1778, LSL #0
    MOVK  X23, #0x8676, LSL #16
    MOVK  X23, #0x4c49, LSL #32
    MOVK  X23, #0xa1a8, LSL #48
    SUB  X4, X23, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, V7.D[1]
    MOVZ  X19, #0x3610, LSL #0
    MOVK  X19, #0xe4fe, LSL #16
    MOVK  X19, #0x65f8, LSL #32
    MOVK  X19, #0x323b, LSL #48
    SUB  X4, X19, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, D7
    MOVZ  X19, #0x7b25, LSL #0
    MOVK  X19, #0xa5d5, LSL #16
    MOVK  X19, #0x7d35, LSL #32
    MOVK  X19, #0xbde0, LSL #48
    SUB  X4, X19, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, V8.D[1]
    MOVZ  X15, #0x6183, LSL #0
    MOVK  X15, #0x363d, LSL #16
    MOVK  X15, #0x632b, LSL #32
    MOVK  X15, #0xd70d, LSL #48
    SUB  X3, X15, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, D8
    MOVZ  X15, #0xc88e, LSL #0
    MOVK  X15, #0xe72b, LSL #16
    MOVK  X15, #0xbdb2, LSL #32
    MOVK  X15, #0x2206, LSL #48
    SUB  X3, X15, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X10, #0x84f5, LSL #0
    MOVK  X10, #0x4cb8, LSL #16
    MOVK  X10, #0xaf15, LSL #32
    MOVK  X10, #0x5d9e, LSL #48
    SUB  X3, X10, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, D9
    MOVZ  X10, #0x8d4d, LSL #0
    MOVK  X10, #0x5bd3, LSL #16
    MOVK  X10, #0x60c3, LSL #32
    MOVK  X10, #0x9a27, LSL #48
    SUB  X3, X10, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X9, #0x75bf, LSL #0
    MOVK  X9, #0x2c20, LSL #16
    MOVK  X9, #0xadb, LSL #32
    MOVK  X9, #0xbce8, LSL #48
    SUB  X28, X9, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, D10
    MOVZ  X9, #0x1749, LSL #0
    MOVK  X9, #0x722a, LSL #16
    MOVK  X9, #0x8236, LSL #32
    MOVK  X9, #0x1dfe, LSL #48
    SUB  X28, X9, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, D11
    MOVZ  X13, #0x73d5, LSL #0
    MOVK  X13, #0xc77e, LSL #16
    SUB  X8, X13, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X3, #0x5bf, LSL #0
    MOVK  X3, #0x24a2, LSL #16
    MOVK  X3, #0xed97, LSL #32
    MOVK  X3, #0x1b4, LSL #48
    SUB  X11, X3, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, D12
    MOVZ  X3, #0x9ee8, LSL #0
    MOVK  X3, #0x40e7, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0x7af0, LSL #48
    SUB  X11, X3, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X15, #0x9b16, LSL #0
    MOVK  X15, #0xfe4d, LSL #16
    MOVK  X15, #0xc137, LSL #32
    MOVK  X15, #0xcd3a, LSL #48
    SUB  X19, X15, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D13
    MOVZ  X15, #0x9f30, LSL #0
    MOVK  X15, #0x5fa, LSL #16
    MOVK  X15, #0x7be6, LSL #32
    MOVK  X15, #0x282, LSL #48
    SUB  X19, X15, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X26, #0x25d1, LSL #0
    MOVK  X26, #0x1e4f, LSL #16
    MOVK  X26, #0x63b7, LSL #32
    MOVK  X26, #0x5292, LSL #48
    SUB  X11, X26, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, D14
    MOVZ  X26, #0x99a6, LSL #0
    MOVK  X26, #0x3957, LSL #16
    MOVK  X26, #0xf6e7, LSL #32
    MOVK  X26, #0x3168, LSL #48
    SUB  X11, X26, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, V15.D[1]
    MOVZ  X2, #0xcef3, LSL #0
    MOVK  X2, #0x65e2, LSL #16
    MOVK  X2, #0x2b07, LSL #32
    MOVK  X2, #0x8364, LSL #48
    SUB  X8, X2, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, D15
    MOVZ  X2, #0x8618, LSL #0
    MOVK  X2, #0xaeac, LSL #16
    MOVK  X2, #0x78cd, LSL #32
    MOVK  X2, #0x1653, LSL #48
    SUB  X8, X2, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, V16.D[1]
    MOVZ  X23, #0xa9ab, LSL #0
    MOVK  X23, #0x228b, LSL #16
    MOVK  X23, #0x502f, LSL #32
    MOVK  X23, #0x5deb, LSL #48
    SUB  X14, X23, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, D16
    MOVZ  X23, #0x6104, LSL #0
    MOVK  X23, #0xb7a7, LSL #16
    MOVK  X23, #0xe3a4, LSL #32
    MOVK  X23, #0x6f81, LSL #48
    SUB  X14, X23, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, V17.D[1]
    MOVZ  X20, #0xb976, LSL #0
    MOVK  X20, #0x549c, LSL #16
    MOVK  X20, #0x392d, LSL #32
    MOVK  X20, #0xd90e, LSL #48
    SUB  X8, X20, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, D17
    MOVZ  X20, #0xa3dd, LSL #0
    MOVK  X20, #0x3513, LSL #16
    MOVK  X20, #0xc755, LSL #32
    MOVK  X20, #0x9025, LSL #48
    SUB  X8, X20, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, V18.D[1]
    MOVZ  X5, #0x7677, LSL #0
    MOVK  X5, #0x34c4, LSL #16
    MOVK  X5, #0x41da, LSL #32
    MOVK  X5, #0x5cb4, LSL #48
    SUB  X21, X5, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, D18
    MOVZ  X5, #0xbc75, LSL #0
    MOVK  X5, #0x5a5b, LSL #16
    MOVK  X5, #0x5464, LSL #32
    MOVK  X5, #0x4015, LSL #48
    SUB  X21, X5, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X2, #0x3cb8, LSL #0
    MOVK  X2, #0x8b32, LSL #16
    MOVK  X2, #0x7e0e, LSL #32
    MOVK  X2, #0x8d50, LSL #48
    SUB  X29, X2, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, D19
    MOVZ  X2, #0xd44b, LSL #0
    MOVK  X2, #0xb9a3, LSL #16
    MOVK  X2, #0x611b, LSL #32
    MOVK  X2, #0x2c5, LSL #48
    SUB  X29, X2, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X3, #0x1637, LSL #0
    MOVK  X3, #0x8c5d, LSL #16
    MOVK  X3, #0x49e0, LSL #32
    MOVK  X3, #0x2adb, LSL #48
    SUB  X5, X3, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, D20
    MOVZ  X3, #0xedc3, LSL #0
    MOVK  X3, #0xe4cb, LSL #16
    MOVK  X3, #0xcbfb, LSL #32
    MOVK  X3, #0x7dc8, LSL #48
    SUB  X5, X3, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, V21.D[1]
    MOVZ  X15, #0x5590, LSL #0
    MOVK  X15, #0x4f1, LSL #16
    MOVK  X15, #0x78ea, LSL #32
    MOVK  X15, #0x640, LSL #48
    SUB  X7, X15, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, D21
    MOVZ  X15, #0x3f70, LSL #0
    MOVK  X15, #0xa85f, LSL #16
    MOVK  X15, #0xbd49, LSL #32
    MOVK  X15, #0x5a60, LSL #48
    SUB  X7, X15, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, V23.D[1]
    MOVZ  X11, #0x2125, LSL #0
    MOVK  X11, #0xa8b9, LSL #16
    MOVK  X11, #0xe8ce, LSL #32
    MOVK  X11, #0x68e, LSL #48
    SUB  X18, X11, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, D23
    MOVZ  X11, #0x4fb, LSL #0
    MOVK  X11, #0x58dc, LSL #16
    MOVK  X11, #0x2fe1, LSL #32
    MOVK  X11, #0xe391, LSL #48
    SUB  X18, X11, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X9, #0xec07, LSL #0
    MOVK  X9, #0x62cb, LSL #16
    MOVK  X9, #0x7caf, LSL #32
    MOVK  X9, #0x1453, LSL #48
    SUB  X12, X9, X10
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X10, D24
    MOVZ  X9, #0xc838, LSL #0
    MOVK  X9, #0xc2a1, LSL #16
    MOVK  X9, #0x6f49, LSL #32
    MOVK  X9, #0x2dfc, LSL #48
    SUB  X12, X9, X10
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X9, #0xae69, LSL #0
    MOVK  X9, #0x5fe5, LSL #16
    MOVK  X9, #0xb5e7, LSL #32
    MOVK  X9, #0xa2ea, LSL #48
    SUB  X7, X9, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, D25
    MOVZ  X9, #0x97f8, LSL #0
    MOVK  X9, #0x90ed, LSL #16
    MOVK  X9, #0xcce2, LSL #32
    MOVK  X9, #0x5bfe, LSL #48
    SUB  X7, X9, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X4, #0xe5fe, LSL #0
    MOVK  X4, #0xd8aa, LSL #16
    MOVK  X4, #0x96c1, LSL #32
    MOVK  X4, #0x2c16, LSL #48
    SUB  X12, X4, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, D26
    MOVZ  X4, #0xa1b0, LSL #0
    MOVK  X4, #0x3be5, LSL #16
    MOVK  X4, #0x198e, LSL #32
    MOVK  X4, #0x505c, LSL #48
    SUB  X12, X4, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X12, #0xe66c, LSL #0
    MOVK  X12, #0x7e5b, LSL #16
    MOVK  X12, #0x1b7a, LSL #32
    MOVK  X12, #0xa707, LSL #48
    SUB  X15, X12, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, D27
    MOVZ  X12, #0x58ca, LSL #0
    MOVK  X12, #0x88a3, LSL #16
    MOVK  X12, #0x7b88, LSL #32
    MOVK  X12, #0x35da, LSL #48
    SUB  X15, X12, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X9, #0x22b7, LSL #0
    MOVK  X9, #0x99fd, LSL #16
    MOVK  X9, #0x292, LSL #32
    MOVK  X9, #0xf91a, LSL #48
    SUB  X6, X9, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, D28
    MOVZ  X9, #0xe96, LSL #0
    MOVK  X9, #0x6333, LSL #16
    MOVK  X9, #0xe6bb, LSL #32
    MOVK  X9, #0x3800, LSL #48
    SUB  X6, X9, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X10, V29.D[1]
    MOVZ  X12, #0x1229, LSL #0
    MOVK  X12, #0xb0e, LSL #16
    MOVK  X12, #0x2dc1, LSL #32
    MOVK  X12, #0x23ce, LSL #48
    SUB  X13, X12, X10
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X10, D29
    MOVZ  X12, #0x525, LSL #0
    MOVK  X12, #0x3f4f, LSL #16
    MOVK  X12, #0x8fda, LSL #32
    MOVK  X12, #0xcc84, LSL #48
    SUB  X13, X12, X10
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X2, #0x4533, LSL #0
    MOVK  X2, #0x68fa, LSL #16
    MOVK  X2, #0xdcd8, LSL #32
    MOVK  X2, #0xa100, LSL #48
    MOVZ  X3, #0x1895, LSL #0
    MOVK  X3, #0xb, LSL #16
    MOVK  X3, #0xae5c, LSL #32
    MOVK  X3, #0xf2f1, LSL #48
    MOVZ  X4, #0x457c, LSL #0
    MOVK  X4, #0xb874, LSL #16
    MOVK  X4, #0xe1de, LSL #32
    MOVK  X4, #0x1fbb, LSL #48
    MOVZ  X5, #0x320a, LSL #0
    MOVK  X5, #0xdd21, LSL #16
    MOVK  X5, #0x824f, LSL #32
    MOVK  X5, #0x89ff, LSL #48
    MOVZ  X6, #0x8ff1, LSL #0
    MOVK  X6, #0xcad9, LSL #16
    MOVK  X6, #0xf0c3, LSL #32
    MOVK  X6, #0x30c1, LSL #48
    MOVZ  X7, #0x2551, LSL #0
    MOVK  X7, #0xc824, LSL #16
    MOVK  X7, #0xa898, LSL #32
    MOVK  X7, #0xa9a0, LSL #48
    MOVZ  X8, #0xc397, LSL #0
    MOVK  X8, #0x8fe5, LSL #16
    MOVK  X8, #0xb84b, LSL #32
    MOVK  X8, #0xbd2a, LSL #48
    MOVZ  X9, #0xd0bd, LSL #0
    MOVK  X9, #0x6076, LSL #16
    MOVK  X9, #0x3586, LSL #32
    MOVK  X9, #0xa375, LSL #48
    MOVZ  X10, #0x5ec, LSL #0
    MOVK  X10, #0x10c8, LSL #16
    MOVK  X10, #0x2ef2, LSL #32
    MOVK  X10, #0x1ed6, LSL #48
    MOVZ  X11, #0x552, LSL #0
    MOVK  X11, #0x12b2, LSL #16
    MOVK  X11, #0x5084, LSL #32
    MOVK  X11, #0xe0f6, LSL #48
    MOVZ  X12, #0xf160, LSL #0
    MOVK  X12, #0x2cee, LSL #16
    MOVK  X12, #0x9d92, LSL #32
    MOVK  X12, #0x1b58, LSL #48
    MOVZ  X13, #0x4bef, LSL #0
    MOVK  X13, #0x6fe3, LSL #16
    MOVK  X13, #0x6645, LSL #32
    MOVK  X13, #0x4721, LSL #48
    MOVZ  X14, #0x757, LSL #0
    MOVK  X14, #0xa9fe, LSL #16
    MOVK  X14, #0x8f93, LSL #32
    MOVK  X14, #0x9117, LSL #48
    MOVZ  X15, #0x9be0, LSL #0
    MOVK  X15, #0xf2dd, LSL #16
    MOVK  X15, #0x446b, LSL #32
    MOVK  X15, #0x643a, LSL #48
    MOVZ  X16, #0x73bc, LSL #0
    MOVK  X16, #0xef72, LSL #16
    MOVK  X16, #0x3a0e, LSL #32
    MOVK  X16, #0x48b, LSL #48
    MOVZ  X17, #0x260f, LSL #0
    MOVK  X17, #0x2950, LSL #16
    MOVK  X17, #0x3c1d, LSL #32
    MOVK  X17, #0x8912, LSL #48
    MOVZ  X18, #0x8b7f, LSL #0
    MOVK  X18, #0xdf48, LSL #16
    MOVK  X18, #0xec80, LSL #32
    MOVK  X18, #0x68a3, LSL #48
    MOVZ  X19, #0xf263, LSL #0
    MOVK  X19, #0x6f5, LSL #16
    MOVK  X19, #0x4562, LSL #32
    MOVK  X19, #0x139a, LSL #48
    MOVZ  X20, #0xc671, LSL #0
    MOVK  X20, #0x72e0, LSL #16
    MOVK  X20, #0x23b4, LSL #32
    MOVK  X20, #0xc88b, LSL #48
    MOVZ  X21, #0x3acc, LSL #0
    MOVK  X21, #0x366f, LSL #16
    MOVK  X21, #0xa4f8, LSL #32
    MOVK  X21, #0xd96f, LSL #48
    MOVZ  X23, #0x3b0a, LSL #0
    MOVK  X23, #0x33bd, LSL #16
    MOVK  X23, #0x1c85, LSL #32
    MOVK  X23, #0xad20, LSL #48
    MOVZ  X24, #0x494e, LSL #0
    MOVK  X24, #0x4871, LSL #16
    MOVK  X24, #0x233c, LSL #32
    MOVK  X24, #0x1e81, LSL #48
    MOVZ  X25, #0x559a, LSL #0
    MOVK  X25, #0x5965, LSL #16
    MOVK  X25, #0xcf43, LSL #32
    MOVK  X25, #0x528f, LSL #48
    MOVZ  X26, #0x44e9, LSL #0
    MOVK  X26, #0xb64c, LSL #16
    MOVK  X26, #0xb0d, LSL #32
    MOVK  X26, #0x63d0, LSL #48
    MOVZ  X27, #0x4d28, LSL #0
    MOVK  X27, #0x671b, LSL #16
    MOVK  X27, #0x31f8, LSL #32
    MOVK  X27, #0x42d, LSL #48
    MOVZ  X28, #0x50e6, LSL #0
    MOVK  X28, #0xe07a, LSL #16
    MOVK  X28, #0xba7e, LSL #32
    MOVK  X28, #0x642a, LSL #48
    MOVZ  X29, #0x91ff, LSL #0
    MOVK  X29, #0x24a0, LSL #16
    MOVK  X29, #0x78b7, LSL #32
    MOVK  X29, #0x352e, LSL #48
    FMOV  D0, X2
    FMOV  V0.D[1], X2
    FMOV  D1, X23
    FMOV  V1.D[1], X11
    FMOV  D2, X21
    FMOV  V2.D[1], X18
    FMOV  D3, X19
    FMOV  V3.D[1], X29
    FMOV  D4, X14
    FMOV  V4.D[1], X16
    FMOV  D5, X26
    FMOV  V5.D[1], X2
    FMOV  D6, X24
    FMOV  V6.D[1], X29
    FMOV  D7, X5
    FMOV  V7.D[1], X9
    FMOV  D8, X10
    FMOV  V8.D[1], X24
    FMOV  D9, X13
    FMOV  V9.D[1], X15
    FMOV  D10, X8
    FMOV  V10.D[1], X3
    FMOV  D11, X5
    FMOV  V11.D[1], X3
    FMOV  D12, X18
    FMOV  V12.D[1], X26
    FMOV  D13, X2
    FMOV  V13.D[1], X16
    FMOV  D14, X4
    FMOV  V14.D[1], X24
    FMOV  D15, X21
    FMOV  V15.D[1], X5
    FMOV  D16, X18
    FMOV  V16.D[1], X13
    FMOV  D17, X12
    FMOV  V17.D[1], X24
    FMOV  D18, X8
    FMOV  V18.D[1], X18
    FMOV  D19, X15
    FMOV  V19.D[1], X18
    FMOV  D20, X3
    FMOV  V20.D[1], X5
    FMOV  D21, X29
    FMOV  V21.D[1], X21
    FMOV  D22, X16
    FMOV  V22.D[1], X11
    FMOV  D23, X20
    FMOV  V23.D[1], X4
    FMOV  D24, X21
    FMOV  V24.D[1], X26
    FMOV  D25, X27
    FMOV  V25.D[1], X7
    FMOV  D26, X15
    FMOV  V26.D[1], X20
    FMOV  D27, X27
    FMOV  V27.D[1], X10
    FMOV  D28, X14
    FMOV  V28.D[1], X20
    FMOV  D29, X3
    FMOV  V29.D[1], X3
    FMOV  D30, X13
    FMOV  V30.D[1], X3
    FMOV  D31, X7
    FMOV  V31.D[1], X18
    MOVZ  X23, #0xa, LSL #0
TaishanSimdUnaryArithmeticP01_label_741:
    AESIMC  V10.16B, V4.16B
    SHA1SU0  V12.4S, V21.4S, V10.4S
    AESD  V23.16B, V30.16B
    SHA1M  Q24, S25, V30.4S
    SHA1SU0  V31.4S, V17.4S, V7.4S
    AESE  V21.16B, V20.16B
    SHA1M  Q31, S15, V11.4S
    SHA1SU0  V9.4S, V24.4S, V10.4S
    SHA1M  Q27, S28, V22.4S
    AESE  V28.16B, V26.16B
    SHA256SU0  V2.4S, V22.4S
    SHA256H  Q22, Q16, V12.4S
    SHA256SU0  V3.4S, V1.4S
    SHA1C  Q18, S9, V16.4S
    AESE  V7.16B, V23.16B
    SHA256H  Q9, Q29, V19.4S
    SHA1SU0  V19.4S, V25.4S, V16.4S
    SHA1C  Q19, S12, V12.4S
    SHA1SU1  V22.4S, V3.4S
    SHA1M  Q1, S7, V13.4S
    SHA1SU0  V8.4S, V27.4S, V21.4S
    AESIMC  V1.16B, V9.16B
    SHA256H  Q15, Q21, V20.4S
    SHA1C  Q13, S27, V22.4S
    AESIMC  V27.16B, V7.16B
    AESIMC  V7.16B, V19.16B
    SHA1C  Q12, S2, V9.4S
    SHA1SU0  V14.4S, V20.4S, V9.4S
    SHA1P  Q15, S31, V27.4S
    AESD  V31.16B, V7.16B
    AESIMC  V19.16B, V0.16B
    AESE  V18.16B, V7.16B
    SHA256H  Q13, Q18, V4.4S
    SHA1SU1  V16.4S, V18.4S
    SHA1SU1  V12.4S, V16.4S
    AESMC  V31.16B, V10.16B
TaishanSimdUnaryArithmeticP01_label_51:
    AESD  V27.16B, V27.16B
    AESD  V26.16B, V27.16B
    AESE  V20.16B, V31.16B
    SHA256SU0  V30.4S, V21.4S
    AESIMC  V3.16B, V17.16B
    SHA1H  S8, S0
    SHA1M  Q12, S0, V2.4S
    AESE  V7.16B, V13.16B
    AESD  V28.16B, V0.16B
    AESD  V2.16B, V13.16B
    AESMC  V19.16B, V9.16B
    AESD  V17.16B, V27.16B
    SHA1P  Q3, S27, V7.4S
    AESIMC  V27.16B, V6.16B
    SHA1H  S7, S4
    SHA1M  Q14, S11, V25.4S
    SHA256H2  Q0, Q31, V20.4S
    SHA1H  S0, S21
    SHA1SU0  V26.4S, V14.4S, V10.4S
    SHA1H  S4, S24
    SHA256SU0  V4.4S, V4.4S
    AESD  V6.16B, V4.16B
    SHA1M  Q25, S18, V31.4S
    AESD  V1.16B, V8.16B
    SHA1H  S14, S25
    SHA1SU1  V13.4S, V12.4S
    AESD  V11.16B, V6.16B
    SHA1SU1  V19.4S, V29.4S
    AESIMC  V2.16B, V12.16B
    AESIMC  V18.16B, V20.16B
    AESE  V0.16B, V10.16B
    SHA1SU0  V26.4S, V27.4S, V25.4S
    SHA1SU0  V7.4S, V11.4S, V25.4S
    SHA1P  Q31, S25, V24.4S
    SHA1SU1  V13.4S, V27.4S
    SHA256SU1  V7.4S, V8.4S, V5.4S
    AESMC  V28.16B, V12.16B
    AESD  V10.16B, V7.16B
    SHA256H  Q16, Q7, V26.4S
    SHA1H  S17, S16
    SHA256H2  Q14, Q14, V4.4S
    SHA256SU0  V5.4S, V0.4S
    AESIMC  V9.16B, V16.16B
    AESD  V0.16B, V10.16B
    AESIMC  V11.16B, V28.16B
    SHA256H2  Q15, Q21, V6.4S
    SHA1C  Q11, S2, V19.4S
    SHA256H  Q31, Q15, V5.4S
    SHA1SU1  V18.4S, V28.4S
    AESMC  V13.16B, V7.16B
    AESMC  V11.16B, V19.16B
    SHA1H  S25, S8
    SHA1C  Q19, S7, V27.4S
    SHA1C  Q14, S27, V13.4S
    AESE  V17.16B, V27.16B
    SHA256H  Q14, Q13, V19.4S
    AESE  V26.16B, V11.16B
    SHA1H  S3, S11
    SHA256H2  Q25, Q14, V24.4S
    SHA1H  S4, S17
    SHA1M  Q26, S8, V18.4S
    SHA256H  Q25, Q24, V16.4S
    SHA256H2  Q11, Q21, V6.4S
    AESMC  V31.16B, V1.16B
    SHA1C  Q19, S26, V7.4S
    SHA256H2  Q2, Q3, V23.4S
    SHA1SU0  V3.4S, V22.4S, V2.4S
    SHA256H  Q3, Q25, V18.4S
    AESMC  V0.16B, V8.16B
    SHA1M  Q19, S20, V5.4S
    SHA1P  Q31, S12, V3.4S
    SHA256H  Q31, Q28, V16.4S
    SHA1SU1  V10.4S, V18.4S
    AESE  V13.16B, V23.16B
    SHA1H  S23, S9
    SHA1SU0  V25.4S, V27.4S, V30.4S
    SHA256SU0  V14.4S, V0.4S
    SHA256SU0  V12.4S, V5.4S
    AESMC  V22.16B, V23.16B
    SHA1SU1  V26.4S, V27.4S
    SHA1C  Q19, S20, V9.4S
    SHA256SU0  V6.4S, V18.4S
    AESD  V23.16B, V19.16B
    AESMC  V31.16B, V1.16B
    AESIMC  V25.16B, V12.16B
    AESE  V19.16B, V6.16B
    AESIMC  V6.16B, V29.16B
    AESIMC  V28.16B, V4.16B
    AESE  V23.16B, V24.16B
    AESD  V24.16B, V22.16B
    SHA1P  Q11, S11, V17.4S
    SHA1P  Q6, S27, V17.4S
    SHA256H2  Q19, Q19, V2.4S
    SHA256H  Q16, Q25, V14.4S
    SHA256SU1  V14.4S, V6.4S, V5.4S
    AESMC  V4.16B, V14.16B
    SHA1SU0  V4.4S, V0.4S, V26.4S
    SHA256H  Q11, Q1, V11.4S
    SHA1SU1  V22.4S, V12.4S
    SHA256H  Q15, Q9, V17.4S
    SHA1P  Q2, S16, V20.4S
    SHA1SU1  V12.4S, V15.4S
    AESMC  V2.16B, V23.16B
    SHA1P  Q29, S20, V18.4S
    SHA1M  Q2, S28, V9.4S
    SHA1H  S27, S11
    SHA256SU1  V30.4S, V24.4S, V7.4S
    SHA256SU1  V2.4S, V2.4S, V19.4S
    SHA1SU1  V23.4S, V17.4S
    SHA1C  Q28, S23, V1.4S
    SHA1SU1  V19.4S, V31.4S
    AESIMC  V12.16B, V14.16B
    AESD  V16.16B, V15.16B
    SHA1M  Q11, S6, V9.4S
    SHA1M  Q13, S13, V2.4S
    SHA1P  Q10, S18, V17.4S
    SHA1SU0  V7.4S, V23.4S, V18.4S
    SHA1C  Q28, S7, V20.4S
    AESIMC  V22.16B, V7.16B
    SHA256SU0  V13.4S, V2.4S
    SHA1SU0  V15.4S, V24.4S, V0.4S
    AESD  V1.16B, V28.16B
    AESD  V27.16B, V5.16B
    AESMC  V0.16B, V23.16B
    AESE  V10.16B, V6.16B
    SHA256SU1  V29.4S, V27.4S, V11.4S
    SHA1SU0  V14.4S, V16.4S, V26.4S
    SHA1H  S31, S0
    SHA256H  Q6, Q22, V30.4S
    SHA1C  Q18, S12, V22.4S
    AESE  V6.16B, V31.16B
    AESD  V15.16B, V22.16B
    SHA256SU0  V13.4S, V1.4S
    AESIMC  V13.16B, V27.16B
    SHA256H2  Q21, Q5, V18.4S
    AESD  V16.16B, V18.16B
    SHA256SU1  V22.4S, V9.4S, V18.4S
    AESMC  V18.16B, V7.16B
    SHA256SU0  V23.4S, V28.4S
    SHA256H2  Q15, Q21, V14.4S
    SHA256SU1  V21.4S, V15.4S, V15.4S
    SHA256SU0  V14.4S, V0.4S
    SHA256SU0  V21.4S, V24.4S
    AESD  V9.16B, V22.16B
    AESMC  V4.16B, V25.16B
    SHA256H  Q19, Q2, V19.4S
    SHA1C  Q26, S12, V31.4S
    SHA256SU0  V30.4S, V3.4S
    SHA1SU0  V23.4S, V30.4S, V20.4S
    SHA1H  S25, S25
    SHA256H  Q15, Q27, V24.4S
    SHA1C  Q18, S9, V31.4S
    SHA1C  Q15, S0, V30.4S
    SHA256H  Q9, Q13, V12.4S
    SHA1H  S25, S0
    AESE  V5.16B, V17.16B
    SHA1H  S1, S5
    AESMC  V0.16B, V18.16B
    SHA1SU0  V16.4S, V0.4S, V23.4S
    AESIMC  V7.16B, V4.16B
    SHA256H  Q26, Q17, V7.4S
    SHA1M  Q30, S6, V1.4S
    SHA1SU0  V18.4S, V29.4S, V17.4S
    SHA1C  Q3, S31, V9.4S
    SUBS  X23, X23, #0x1
    B.NE  TaishanSimdUnaryArithmeticP01_label_741
    MOVZ  X13, #0x4533, LSL #0
    MOVK  X13, #0x68fa, LSL #16
    MOVK  X13, #0xdcd8, LSL #32
    MOVK  X13, #0xa100, LSL #48
    SUB  X20, X13, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X25, #0x1895, LSL #0
    MOVK  X25, #0xb, LSL #16
    MOVK  X25, #0xae5c, LSL #32
    MOVK  X25, #0xf2f1, LSL #48
    SUB  X5, X25, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X29, #0x457c, LSL #0
    MOVK  X29, #0xb874, LSL #16
    MOVK  X29, #0xe1de, LSL #32
    MOVK  X29, #0x1fbb, LSL #48
    SUB  X3, X29, X4
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X14, X12, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X18, #0x8ff1, LSL #0
    MOVK  X18, #0xcad9, LSL #16
    MOVK  X18, #0xf0c3, LSL #32
    MOVK  X18, #0x30c1, LSL #48
    SUB  X17, X18, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X28, #0x2551, LSL #0
    MOVK  X28, #0xc824, LSL #16
    MOVK  X28, #0xa898, LSL #32
    MOVK  X28, #0xa9a0, LSL #48
    SUB  X27, X28, X7
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X19, #0xc397, LSL #0
    MOVK  X19, #0x8fe5, LSL #16
    MOVK  X19, #0xb84b, LSL #32
    MOVK  X19, #0xbd2a, LSL #48
    SUB  X28, X19, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X9, #0xd0bd, LSL #0
    MOVK  X9, #0x6076, LSL #16
    MOVK  X9, #0x3586, LSL #32
    MOVK  X9, #0xa375, LSL #48
    SUB  X21, X9, X9
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X29, #0x5ec, LSL #0
    MOVK  X29, #0x10c8, LSL #16
    MOVK  X29, #0x2ef2, LSL #32
    MOVK  X29, #0x1ed6, LSL #48
    SUB  X7, X29, X10
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X25, #0x552, LSL #0
    MOVK  X25, #0x12b2, LSL #16
    MOVK  X25, #0x5084, LSL #32
    MOVK  X25, #0xe0f6, LSL #48
    SUB  X6, X25, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X6, #0x9be0, LSL #0
    MOVK  X6, #0xf2dd, LSL #16
    MOVK  X6, #0x446b, LSL #32
    MOVK  X6, #0x643a, LSL #48
    SUB  X21, X6, X15
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X25, #0x8ff1, LSL #0
    MOVK  X25, #0xcad9, LSL #16
    MOVK  X25, #0xf0c3, LSL #32
    MOVK  X25, #0x30c1, LSL #48
    SUB  X21, X25, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X2, X18, X23
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X8, X28, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X7, #0x8ff1, LSL #0
    MOVK  X7, #0xcad9, LSL #16
    MOVK  X7, #0xf0c3, LSL #32
    MOVK  X7, #0x30c1, LSL #48
    SUB  X15, X7, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X27
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X8, X24, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X8, #0x5db4, LSL #0
    MOVK  X8, #0xf90e, LSL #16
    MOVK  X8, #0x5676, LSL #32
    MOVK  X8, #0xca5f, LSL #48
    SUB  X11, X8, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D2
    MOVZ  X8, #0x52c, LSL #0
    MOVK  X8, #0xb236, LSL #16
    MOVK  X8, #0xc0fd, LSL #32
    MOVK  X8, #0xcefb, LSL #48
    SUB  X11, X8, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, V3.D[1]
    MOVZ  X27, #0x69c7, LSL #0
    MOVK  X27, #0xe6a5, LSL #16
    MOVK  X27, #0x369d, LSL #32
    MOVK  X27, #0x8f6d, LSL #48
    SUB  X13, X27, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, D3
    MOVZ  X27, #0xb77f, LSL #0
    MOVK  X27, #0x1042, LSL #16
    MOVK  X27, #0x2492, LSL #32
    MOVK  X27, #0xab9d, LSL #48
    SUB  X13, X27, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X18, #0x4aac, LSL #0
    MOVK  X18, #0x5329, LSL #16
    MOVK  X18, #0x58dd, LSL #32
    MOVK  X18, #0x855a, LSL #48
    SUB  X19, X18, X9
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, D4
    MOVZ  X18, #0x658b, LSL #0
    MOVK  X18, #0x45b9, LSL #16
    MOVK  X18, #0x373b, LSL #32
    MOVK  X18, #0xa5f0, LSL #48
    SUB  X19, X18, X9
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X27, #0x7e65, LSL #0
    MOVK  X27, #0x9238, LSL #16
    MOVK  X27, #0xfefe, LSL #32
    MOVK  X27, #0x64d5, LSL #48
    SUB  X8, X27, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, D5
    MOVZ  X27, #0x9b64, LSL #0
    MOVK  X27, #0x7c6d, LSL #16
    MOVK  X27, #0xe47d, LSL #32
    MOVK  X27, #0x270a, LSL #48
    SUB  X8, X27, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X8, #0xad66, LSL #0
    MOVK  X8, #0x475d, LSL #16
    MOVK  X8, #0xacae, LSL #32
    MOVK  X8, #0xe872, LSL #48
    SUB  X5, X8, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, D6
    MOVZ  X8, #0x5fb5, LSL #0
    MOVK  X8, #0xc2aa, LSL #16
    MOVK  X8, #0xca50, LSL #32
    MOVK  X8, #0x4ed6, LSL #48
    SUB  X5, X8, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X28, #0xf849, LSL #0
    MOVK  X28, #0xc2ef, LSL #16
    MOVK  X28, #0xb95a, LSL #32
    MOVK  X28, #0xd069, LSL #48
    SUB  X9, X28, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, D7
    MOVZ  X28, #0xc406, LSL #0
    MOVK  X28, #0xc010, LSL #16
    MOVK  X28, #0x7b85, LSL #32
    MOVK  X28, #0x5bfc, LSL #48
    SUB  X9, X28, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, D8
    MOVZ  X10, #0x6382, LSL #0
    MOVK  X10, #0x8d4f, LSL #16
    SUB  X20, X10, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X29, #0x1c1e, LSL #0
    MOVK  X29, #0xbab5, LSL #16
    MOVK  X29, #0xb9e5, LSL #32
    MOVK  X29, #0xe956, LSL #48
    SUB  X3, X29, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, D9
    MOVZ  X29, #0x4927, LSL #0
    MOVK  X29, #0x3e30, LSL #16
    MOVK  X29, #0x7787, LSL #32
    MOVK  X29, #0xf267, LSL #48
    SUB  X3, X29, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X26, #0x3615, LSL #0
    MOVK  X26, #0x931f, LSL #16
    MOVK  X26, #0x3714, LSL #32
    MOVK  X26, #0x9038, LSL #48
    SUB  X2, X26, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, D10
    MOVZ  X26, #0xfa8, LSL #0
    MOVK  X26, #0xddcd, LSL #16
    MOVK  X26, #0x2561, LSL #32
    MOVK  X26, #0xc634, LSL #48
    SUB  X2, X26, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X24, #0xe21c, LSL #0
    MOVK  X24, #0x9fcc, LSL #16
    MOVK  X24, #0x56ed, LSL #32
    MOVK  X24, #0x5f1d, LSL #48
    SUB  X20, X24, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, D11
    MOVZ  X24, #0xff30, LSL #0
    MOVK  X24, #0x15c6, LSL #16
    MOVK  X24, #0x4026, LSL #32
    MOVK  X24, #0x7bab, LSL #48
    SUB  X20, X24, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, V12.D[1]
    MOVZ  X21, #0xc2e6, LSL #0
    MOVK  X21, #0xee9c, LSL #16
    MOVK  X21, #0x3bd3, LSL #32
    MOVK  X21, #0x45c0, LSL #48
    SUB  X7, X21, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, D12
    MOVZ  X21, #0x51d3, LSL #0
    MOVK  X21, #0x5e92, LSL #16
    MOVK  X21, #0xcd85, LSL #32
    MOVK  X21, #0xfb4a, LSL #48
    SUB  X7, X21, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, V13.D[1]
    MOVZ  X27, #0xf522, LSL #0
    MOVK  X27, #0x48bc, LSL #16
    MOVK  X27, #0x88cf, LSL #32
    MOVK  X27, #0xfd6f, LSL #48
    SUB  X21, X27, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, D13
    MOVZ  X27, #0xb147, LSL #0
    MOVK  X27, #0x6356, LSL #16
    MOVK  X27, #0x7a71, LSL #32
    MOVK  X27, #0x5e23, LSL #48
    SUB  X21, X27, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, V14.D[1]
    MOVZ  X5, #0x2cbc, LSL #0
    MOVK  X5, #0xb447, LSL #16
    MOVK  X5, #0xbbb2, LSL #32
    MOVK  X5, #0xac5b, LSL #48
    SUB  X16, X5, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, D14
    MOVZ  X5, #0xc021, LSL #0
    MOVK  X5, #0x7d1c, LSL #16
    MOVK  X5, #0xde86, LSL #32
    MOVK  X5, #0x50d1, LSL #48
    SUB  X16, X5, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, V15.D[1]
    MOVZ  X9, #0xae4d, LSL #0
    MOVK  X9, #0x6a85, LSL #16
    MOVK  X9, #0x342a, LSL #32
    MOVK  X9, #0x24ec, LSL #48
    SUB  X21, X9, X19
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, D15
    MOVZ  X9, #0x937a, LSL #0
    MOVK  X9, #0x9bb0, LSL #16
    MOVK  X9, #0x9bda, LSL #32
    MOVK  X9, #0xf361, LSL #48
    SUB  X21, X9, X19
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X2, #0x808e, LSL #0
    MOVK  X2, #0x7fb7, LSL #16
    MOVK  X2, #0x90ed, LSL #32
    MOVK  X2, #0x984c, LSL #48
    SUB  X6, X2, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, D16
    MOVZ  X2, #0x9152, LSL #0
    MOVK  X2, #0xb817, LSL #16
    MOVK  X2, #0x66e0, LSL #32
    MOVK  X2, #0x3167, LSL #48
    SUB  X6, X2, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, V17.D[1]
    MOVZ  X23, #0x6a31, LSL #0
    MOVK  X23, #0xb4a5, LSL #16
    MOVK  X23, #0xd62e, LSL #32
    MOVK  X23, #0x9da, LSL #48
    SUB  X4, X23, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, D17
    MOVZ  X23, #0x8010, LSL #0
    MOVK  X23, #0x6862, LSL #16
    MOVK  X23, #0xf391, LSL #32
    MOVK  X23, #0xef22, LSL #48
    SUB  X4, X23, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X27, #0x1e75, LSL #0
    MOVK  X27, #0xb973, LSL #16
    MOVK  X27, #0x7473, LSL #32
    MOVK  X27, #0xa24f, LSL #48
    SUB  X17, X27, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, D18
    MOVZ  X27, #0x6a33, LSL #0
    MOVK  X27, #0x57c0, LSL #16
    MOVK  X27, #0xfb5c, LSL #32
    MOVK  X27, #0x8bc2, LSL #48
    SUB  X17, X27, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X26, #0xa46c, LSL #0
    MOVK  X26, #0x6050, LSL #16
    MOVK  X26, #0xc866, LSL #32
    MOVK  X26, #0x80c4, LSL #48
    SUB  X5, X26, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, D19
    MOVZ  X26, #0x6d01, LSL #0
    MOVK  X26, #0xef75, LSL #16
    MOVK  X26, #0x9d49, LSL #32
    MOVK  X26, #0x1347, LSL #48
    SUB  X5, X26, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, V20.D[1]
    MOVZ  X3, #0xce71, LSL #0
    MOVK  X3, #0xa3ab, LSL #16
    MOVK  X3, #0x3372, LSL #32
    MOVK  X3, #0xe508, LSL #48
    SUB  X23, X3, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, D20
    MOVZ  X3, #0x3bc3, LSL #0
    MOVK  X3, #0x3c0c, LSL #16
    MOVK  X3, #0xdce3, LSL #32
    MOVK  X3, #0x71bb, LSL #48
    SUB  X23, X3, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, V21.D[1]
    MOVZ  X14, #0x24ff, LSL #0
    MOVK  X14, #0x9ae1, LSL #16
    MOVK  X14, #0x3f43, LSL #32
    MOVK  X14, #0xad90, LSL #48
    SUB  X8, X14, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, D21
    MOVZ  X14, #0x4683, LSL #0
    MOVK  X14, #0xe5d, LSL #16
    MOVK  X14, #0x3ca, LSL #32
    MOVK  X14, #0x62d8, LSL #48
    SUB  X8, X14, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X7, #0xc901, LSL #0
    MOVK  X7, #0xfc0, LSL #16
    MOVK  X7, #0x2d05, LSL #32
    MOVK  X7, #0xb972, LSL #48
    SUB  X5, X7, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, D23
    MOVZ  X7, #0x2ee7, LSL #0
    MOVK  X7, #0x3acf, LSL #16
    MOVK  X7, #0x25cf, LSL #32
    MOVK  X7, #0x7d4c, LSL #48
    SUB  X5, X7, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, V24.D[1]
    MOVZ  X28, #0x8664, LSL #0
    MOVK  X28, #0xd273, LSL #16
    MOVK  X28, #0x9d63, LSL #32
    MOVK  X28, #0xc773, LSL #48
    SUB  X19, X28, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, D24
    MOVZ  X28, #0xbcbf, LSL #0
    MOVK  X28, #0x87ca, LSL #16
    MOVK  X28, #0x409a, LSL #32
    MOVK  X28, #0xb0be, LSL #48
    SUB  X19, X28, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X19, X15, X16
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X16, D25
    MOVZ  X15, #0xa69c, LSL #0
    MOVK  X15, #0xa85d, LSL #16
    SUB  X19, X15, X16
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, V26.D[1]
    MOVZ  X15, #0xc6aa, LSL #0
    MOVK  X15, #0xd043, LSL #16
    MOVK  X15, #0xba01, LSL #32
    MOVK  X15, #0x7daa, LSL #48
    SUB  X23, X15, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, D26
    MOVZ  X15, #0xe16d, LSL #0
    MOVK  X15, #0x51a9, LSL #16
    MOVK  X15, #0x661a, LSL #32
    MOVK  X15, #0xf2fb, LSL #48
    SUB  X23, X15, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X5, #0x44b4, LSL #0
    MOVK  X5, #0xbf6c, LSL #16
    MOVK  X5, #0x8894, LSL #32
    MOVK  X5, #0x4c85, LSL #48
    SUB  X10, X5, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, D27
    MOVZ  X5, #0xa773, LSL #0
    MOVK  X5, #0xe8ff, LSL #16
    MOVK  X5, #0xbe11, LSL #32
    MOVK  X5, #0x76af, LSL #48
    SUB  X10, X5, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X7, #0x3a10, LSL #0
    MOVK  X7, #0xda33, LSL #16
    MOVK  X7, #0x9367, LSL #32
    MOVK  X7, #0x834e, LSL #48
    SUB  X25, X7, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D28
    MOVZ  X7, #0x2373, LSL #0
    MOVK  X7, #0x21d6, LSL #16
    MOVK  X7, #0xdaf4, LSL #32
    MOVK  X7, #0xbb16, LSL #48
    SUB  X25, X7, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X3, #0x151c, LSL #0
    MOVK  X3, #0xc0fd, LSL #16
    MOVK  X3, #0x541, LSL #32
    MOVK  X3, #0x78e7, LSL #48
    SUB  X10, X3, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, D29
    MOVZ  X3, #0xae4a, LSL #0
    MOVK  X3, #0x8bff, LSL #16
    MOVK  X3, #0xc364, LSL #32
    MOVK  X3, #0xd67e, LSL #48
    SUB  X10, X3, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
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
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X25
    FMOV  V0.D[1], X29
    FMOV  D1, X14
    FMOV  V1.D[1], X13
    FMOV  D2, X14
    FMOV  V2.D[1], X21
    FMOV  D3, X15
    FMOV  V3.D[1], X16
    FMOV  D4, X26
    FMOV  V4.D[1], X18
    FMOV  D5, X17
    FMOV  V5.D[1], X11
    FMOV  D6, X2
    FMOV  V6.D[1], X13
    FMOV  D7, X6
    FMOV  V7.D[1], X10
    FMOV  D8, X14
    FMOV  V8.D[1], X12
    FMOV  D9, X8
    FMOV  V9.D[1], X17
    FMOV  D10, X13
    FMOV  V10.D[1], X24
    FMOV  D11, X8
    FMOV  V11.D[1], X23
    FMOV  D12, X16
    FMOV  V12.D[1], X18
    FMOV  D13, X19
    FMOV  V13.D[1], X21
    FMOV  D14, X2
    FMOV  V14.D[1], X20
    FMOV  D15, X9
    FMOV  V15.D[1], X2
    FMOV  D16, X25
    FMOV  V16.D[1], X14
    FMOV  D17, X6
    FMOV  V17.D[1], X23
    FMOV  D18, X27
    FMOV  V18.D[1], X7
    FMOV  D19, X20
    FMOV  V19.D[1], X7
    FMOV  D20, X21
    FMOV  V20.D[1], X13
    FMOV  D21, X8
    FMOV  V21.D[1], X26
    FMOV  D22, X24
    FMOV  V22.D[1], X25
    FMOV  D23, X25
    FMOV  V23.D[1], X2
    FMOV  D24, X17
    FMOV  V24.D[1], X7
    FMOV  D25, X2
    FMOV  V25.D[1], X10
    FMOV  D26, X26
    FMOV  V26.D[1], X26
    FMOV  D27, X11
    FMOV  V27.D[1], X20
    FMOV  D28, X13
    FMOV  V28.D[1], X26
    FMOV  D29, X19
    FMOV  V29.D[1], X12
    FMOV  D30, X16
    FMOV  V30.D[1], X24
    FMOV  D31, X25
    FMOV  V31.D[1], X2
    MOVZ  X5, #0xa, LSL #0
TaishanSimdUnaryArithmeticP01_label_823:
    SHA1M  Q10, S14, V2.4S
    SHA256SU0  V8.4S, V6.4S
    AESMC  V8.16B, V16.16B
    SHA256H2  Q28, Q7, V8.4S
    SHA1SU0  V25.4S, V8.4S, V10.4S
    SHA256H  Q21, Q5, V1.4S
    SHA1SU0  V31.4S, V11.4S, V13.4S
    AESMC  V10.16B, V7.16B
    AESD  V28.16B, V28.16B
    SHA256SU0  V15.4S, V11.4S
    SHA1M  Q15, S11, V15.4S
    AESMC  V21.16B, V15.16B
    SHA1P  Q24, S8, V16.4S
    AESE  V10.16B, V15.16B
    SHA1C  Q7, S6, V20.4S
    SHA1M  Q21, S5, V9.4S
    SHA256SU1  V11.4S, V24.4S, V31.4S
    SHA256H  Q20, Q10, V27.4S
    AESE  V20.16B, V5.16B
    AESD  V30.16B, V23.16B
    AESE  V11.16B, V31.16B
    SHA256H2  Q12, Q25, V0.4S
    SHA256H  Q4, Q25, V12.4S
    SHA256SU0  V13.4S, V25.4S
    SHA1M  Q10, S25, V30.4S
    SHA1H  S28, S3
    SHA256H2  Q25, Q17, V11.4S
    SHA1H  S22, S24
    AESE  V11.16B, V16.16B
    AESD  V18.16B, V4.16B
    SHA1H  S13, S30
    SHA1SU0  V24.4S, V22.4S, V30.4S
    SHA1H  S25, S18
    SHA1C  Q12, S5, V7.4S
    SHA1SU1  V31.4S, V19.4S
    AESMC  V23.16B, V30.16B
    SHA256SU1  V22.4S, V12.4S, V1.4S
    SHA1M  Q8, S4, V31.4S
    SHA256SU0  V20.4S, V26.4S
    SHA1SU0  V11.4S, V24.4S, V3.4S
    SHA1H  S8, S26
    SHA1M  Q5, S26, V19.4S
    SHA1H  S24, S20
    AESMC  V23.16B, V18.16B
    SHA256H  Q16, Q11, V25.4S
    SHA256SU1  V3.4S, V28.4S, V12.4S
    SHA1M  Q5, S26, V5.4S
    AESIMC  V7.16B, V9.16B
    SHA1P  Q8, S4, V7.4S
    AESMC  V21.16B, V8.16B
    SHA256H2  Q6, Q17, V12.4S
    SHA1SU0  V6.4S, V22.4S, V25.4S
    AESD  V5.16B, V11.16B
    SHA1H  S18, S19
    SHA1M  Q26, S20, V24.4S
    AESIMC  V24.16B, V13.16B
    AESD  V15.16B, V21.16B
    AESE  V17.16B, V6.16B
    SHA256H2  Q27, Q13, V6.4S
    SHA1SU0  V10.4S, V24.4S, V20.4S
    SHA1SU1  V22.4S, V23.4S
    SHA1H  S26, S10
    SHA1H  S13, S10
    SHA256H  Q9, Q1, V21.4S
    SHA1SU0  V30.4S, V31.4S, V28.4S
    AESD  V26.16B, V23.16B
    AESD  V9.16B, V30.16B
    SHA1H  S12, S23
    SHA1SU1  V27.4S, V2.4S
    AESMC  V24.16B, V7.16B
    AESD  V23.16B, V4.16B
    SHA256H2  Q17, Q19, V26.4S
    SHA256H2  Q19, Q6, V21.4S
    SHA1P  Q15, S20, V21.4S
    AESD  V9.16B, V30.16B
    SHA1P  Q13, S20, V4.4S
    SHA256H2  Q27, Q5, V15.4S
    SHA1M  Q9, S24, V26.4S
    AESIMC  V15.16B, V10.16B
    SHA256H2  Q8, Q12, V22.4S
    SHA256SU1  V1.4S, V6.4S, V5.4S
    SHA256H2  Q6, Q17, V13.4S
    SHA256SU0  V29.4S, V22.4S
    SHA1SU1  V19.4S, V8.4S
    SHA1H  S16, S18
    SHA1SU1  V3.4S, V1.4S
    AESE  V19.16B, V18.16B
    SHA1M  Q31, S14, V2.4S
    SHA1SU1  V14.4S, V20.4S
    AESMC  V15.16B, V27.16B
    SHA1SU0  V24.4S, V15.4S, V26.4S
    SHA256H2  Q31, Q12, V22.4S
    SHA1SU0  V6.4S, V20.4S, V18.4S
    AESD  V2.16B, V25.16B
    SHA1P  Q28, S19, V9.4S
    SHA1P  Q5, S2, V11.4S
    SHA1M  Q2, S29, V11.4S
    SHA256H2  Q11, Q13, V6.4S
    SHA1H  S10, S22
    SHA1C  Q14, S29, V29.4S
    AESE  V9.16B, V2.16B
    SHA256SU1  V21.4S, V4.4S, V12.4S
    AESMC  V0.16B, V13.16B
    SHA1P  Q11, S15, V14.4S
    AESD  V27.16B, V5.16B
    SHA1SU0  V19.4S, V9.4S, V16.4S
    SHA256H2  Q29, Q27, V16.4S
    SHA1H  S25, S13
    SHA1SU1  V14.4S, V10.4S
    SHA256H  Q18, Q11, V11.4S
    SHA1C  Q10, S6, V9.4S
    SHA1H  S20, S10
    AESE  V19.16B, V8.16B
    SHA1SU1  V30.4S, V14.4S
    SHA256SU1  V27.4S, V18.4S, V21.4S
    SHA1H  S3, S4
    SHA1SU0  V13.4S, V1.4S, V10.4S
    SHA1M  Q28, S24, V29.4S
    AESMC  V0.16B, V11.16B
    SHA1SU1  V19.4S, V26.4S
    SHA1P  Q24, S4, V4.4S
    SHA256H2  Q21, Q21, V24.4S
    SHA1SU1  V0.4S, V21.4S
    AESE  V2.16B, V14.16B
    SHA256SU0  V26.4S, V31.4S
    AESE  V30.16B, V31.16B
    SHA1M  Q20, S20, V10.4S
    SHA1C  Q3, S24, V16.4S
    AESIMC  V11.16B, V25.16B
    SHA1SU1  V25.4S, V26.4S
    SHA1SU0  V19.4S, V14.4S, V23.4S
    SHA1H  S22, S15
    SHA1M  Q0, S31, V3.4S
    AESD  V1.16B, V12.16B
    SHA1H  S2, S8
    AESE  V30.16B, V3.16B
    SHA1P  Q22, S8, V29.4S
    SHA256SU1  V30.4S, V19.4S, V18.4S
    SHA256SU1  V18.4S, V8.4S, V17.4S
    AESIMC  V27.16B, V3.16B
TaishanSimdUnaryArithmeticP01_label_378:
    SHA256SU0  V21.4S, V23.4S
    SHA1P  Q27, S22, V5.4S
    SHA1C  Q23, S2, V3.4S
    SHA256SU1  V29.4S, V23.4S, V5.4S
    AESIMC  V13.16B, V3.16B
    SHA1C  Q17, S16, V8.4S
    SHA256SU0  V14.4S, V9.4S
    SHA256SU1  V6.4S, V24.4S, V30.4S
    AESD  V1.16B, V22.16B
    AESD  V31.16B, V18.16B
    AESIMC  V17.16B, V24.16B
    AESIMC  V23.16B, V21.16B
    SHA256SU0  V30.4S, V16.4S
    SHA256SU1  V23.4S, V1.4S, V13.4S
    AESE  V17.16B, V29.16B
    AESE  V8.16B, V28.16B
    SHA256SU1  V0.4S, V24.4S, V17.4S
    SHA256H  Q24, Q21, V6.4S
    AESD  V27.16B, V14.16B
    SHA1P  Q12, S10, V22.4S
    AESE  V15.16B, V19.16B
    AESE  V28.16B, V15.16B
    SHA1C  Q8, S2, V28.4S
    SHA1SU0  V8.4S, V15.4S, V0.4S
    SHA1SU0  V14.4S, V19.4S, V15.4S
    SHA256H2  Q14, Q19, V0.4S
    SHA256H2  Q23, Q11, V4.4S
    AESIMC  V16.16B, V8.16B
    SHA1M  Q30, S24, V15.4S
    SHA1M  Q2, S9, V22.4S
    SHA1H  S24, S5
    SHA1H  S20, S2
    AESE  V5.16B, V12.16B
    SHA256SU0  V3.4S, V23.4S
    SHA256H2  Q10, Q27, V21.4S
    SHA256SU1  V7.4S, V22.4S, V3.4S
    SHA256H2  Q12, Q8, V30.4S
    SHA256H  Q26, Q14, V25.4S
    SHA1H  S31, S25
    SHA1P  Q22, S29, V9.4S
    SHA256SU1  V10.4S, V28.4S, V13.4S
    SHA1C  Q31, S12, V14.4S
    SHA256H  Q17, Q15, V11.4S
    AESIMC  V16.16B, V25.16B
    SHA1P  Q26, S16, V19.4S
    SHA1SU0  V17.4S, V17.4S, V2.4S
    AESIMC  V11.16B, V22.16B
    SHA256SU0  V14.4S, V10.4S
    SHA1M  Q10, S22, V8.4S
    SHA1SU1  V7.4S, V23.4S
    AESIMC  V15.16B, V14.16B
    SHA256SU1  V29.4S, V13.4S, V8.4S
    SHA1C  Q5, S12, V2.4S
    SHA256H  Q8, Q22, V27.4S
    SHA1SU0  V30.4S, V3.4S, V16.4S
    SHA256H2  Q6, Q16, V16.4S
    SHA1P  Q26, S26, V6.4S
    SHA1SU0  V2.4S, V17.4S, V2.4S
    AESE  V19.16B, V2.16B
    SHA256H  Q29, Q9, V27.4S
    SUBS  X5, X5, #0x1
    B.NE  TaishanSimdUnaryArithmeticP01_label_823
    MOVZ  X2, #0x0, LSL #0
    SUB  X10, X2, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X23, X10, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X4, X5, X4
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
TaishanSimdUnaryArithmeticP01_label_213:
    MOVZ  X18, #0x0, LSL #0
    SUB  X4, X18, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X6
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X7
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X21, X23, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X13
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X10, X28, X15
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X17
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X5, X6, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X25
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X26
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, V2.D[1]
    MOVZ  X18, #0xb668, LSL #0
    MOVK  X18, #0x8d4a, LSL #16
    MOVK  X18, #0x6437, LSL #32
    MOVK  X18, #0xf0ae, LSL #48
    SUB  X16, X18, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, D2
    MOVZ  X18, #0xff, LSL #0
    MOVK  X18, #0x6ed, LSL #16
    MOVK  X18, #0xb857, LSL #32
    MOVK  X18, #0xfc77, LSL #48
    SUB  X16, X18, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X17, #0xe4a2, LSL #0
    MOVK  X17, #0x19c4, LSL #16
    MOVK  X17, #0xc177, LSL #32
    MOVK  X17, #0xb2b6, LSL #48
    SUB  X29, X17, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, D3
    MOVZ  X17, #0xe27c, LSL #0
    MOVK  X17, #0x1e9, LSL #16
    MOVK  X17, #0x8d8b, LSL #32
    MOVK  X17, #0xa75c, LSL #48
    SUB  X29, X17, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, V4.D[1]
    MOVZ  X20, #0x36ad, LSL #0
    MOVK  X20, #0xef47, LSL #16
    MOVK  X20, #0x9631, LSL #32
    MOVK  X20, #0xa408, LSL #48
    SUB  X14, X20, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, D4
    MOVZ  X20, #0x7346, LSL #0
    MOVK  X20, #0x50d, LSL #16
    MOVK  X20, #0xc325, LSL #32
    MOVK  X20, #0x1172, LSL #48
    SUB  X14, X20, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X17, #0x167e, LSL #0
    MOVK  X17, #0x578, LSL #16
    MOVK  X17, #0x7553, LSL #32
    MOVK  X17, #0x54ad, LSL #48
    SUB  X2, X17, X10
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X10, D5
    MOVZ  X17, #0xdc11, LSL #0
    MOVK  X17, #0xb628, LSL #16
    MOVK  X17, #0x5af0, LSL #32
    MOVK  X17, #0x7d80, LSL #48
    SUB  X2, X17, X10
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, V6.D[1]
    MOVZ  X3, #0xe577, LSL #0
    MOVK  X3, #0x4c56, LSL #16
    MOVK  X3, #0x62c2, LSL #32
    MOVK  X3, #0x1685, LSL #48
    SUB  X12, X3, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, D6
    MOVZ  X3, #0x51a0, LSL #0
    MOVK  X3, #0x2aa3, LSL #16
    MOVK  X3, #0x3f57, LSL #32
    MOVK  X3, #0x5bbb, LSL #48
    SUB  X12, X3, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X19, #0xe9c2, LSL #0
    MOVK  X19, #0xb589, LSL #16
    MOVK  X19, #0x9a20, LSL #32
    MOVK  X19, #0xd217, LSL #48
    SUB  X5, X19, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, D7
    MOVZ  X19, #0x158a, LSL #0
    MOVK  X19, #0x13da, LSL #16
    MOVK  X19, #0x7d88, LSL #32
    MOVK  X19, #0x423a, LSL #48
    SUB  X5, X19, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, V8.D[1]
    MOVZ  X14, #0x92d2, LSL #0
    MOVK  X14, #0xc55b, LSL #16
    MOVK  X14, #0x7e57, LSL #32
    MOVK  X14, #0xaf4c, LSL #48
    SUB  X24, X14, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, D8
    MOVZ  X14, #0x8e24, LSL #0
    MOVK  X14, #0x16b, LSL #16
    MOVK  X14, #0xfa19, LSL #32
    MOVK  X14, #0xa00e, LSL #48
    SUB  X24, X14, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, V9.D[1]
    MOVZ  X5, #0xaf85, LSL #0
    MOVK  X5, #0x2916, LSL #16
    MOVK  X5, #0xe429, LSL #32
    MOVK  X5, #0x2602, LSL #48
    SUB  X8, X5, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, D9
    MOVZ  X5, #0x5261, LSL #0
    MOVK  X5, #0x1de2, LSL #16
    MOVK  X5, #0xb2b7, LSL #32
    MOVK  X5, #0xd055, LSL #48
    SUB  X8, X5, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X2, #0xcdfa, LSL #0
    MOVK  X2, #0xa648, LSL #16
    MOVK  X2, #0xbdc1, LSL #32
    MOVK  X2, #0x656b, LSL #48
    SUB  X18, X2, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, D10
    MOVZ  X2, #0x70c2, LSL #0
    MOVK  X2, #0x2840, LSL #16
    MOVK  X2, #0xe455, LSL #32
    MOVK  X2, #0xfb5d, LSL #48
    SUB  X18, X2, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X26, #0xfb6d, LSL #0
    MOVK  X26, #0x80a8, LSL #16
    MOVK  X26, #0x980e, LSL #32
    MOVK  X26, #0x7fd2, LSL #48
    SUB  X3, X26, X4
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, D11
    MOVZ  X26, #0x52d0, LSL #0
    MOVK  X26, #0x1ac8, LSL #16
    MOVK  X26, #0x49bf, LSL #32
    MOVK  X26, #0x3f89, LSL #48
    SUB  X3, X26, X4
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X20, #0x6b35, LSL #0
    MOVK  X20, #0x9e35, LSL #16
    MOVK  X20, #0x4be7, LSL #32
    MOVK  X20, #0x6150, LSL #48
    SUB  X29, X20, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D12
    MOVZ  X20, #0xe2d9, LSL #0
    MOVK  X20, #0xdbbd, LSL #16
    MOVK  X20, #0x50bc, LSL #32
    MOVK  X20, #0x6a21, LSL #48
    SUB  X29, X20, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X29, #0x41d3, LSL #0
    MOVK  X29, #0xb247, LSL #16
    MOVK  X29, #0x7688, LSL #32
    MOVK  X29, #0xd114, LSL #48
    SUB  X4, X29, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, D13
    MOVZ  X29, #0xe3b4, LSL #0
    MOVK  X29, #0x89b9, LSL #16
    MOVK  X29, #0xb670, LSL #32
    MOVK  X29, #0x4cf6, LSL #48
    SUB  X4, X29, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X5, #0x1e87, LSL #0
    MOVK  X5, #0x1d9a, LSL #16
    MOVK  X5, #0xc7f8, LSL #32
    MOVK  X5, #0xae4e, LSL #48
    SUB  X4, X5, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, D14
    MOVZ  X5, #0xbdd3, LSL #0
    MOVK  X5, #0xbe2b, LSL #16
    MOVK  X5, #0x38dc, LSL #32
    MOVK  X5, #0x6ee0, LSL #48
    SUB  X4, X5, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X9, #0xef34, LSL #0
    MOVK  X9, #0xd015, LSL #16
    MOVK  X9, #0xc15, LSL #32
    MOVK  X9, #0xc006, LSL #48
    SUB  X26, X9, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X16, D15
    MOVZ  X9, #0xe4a0, LSL #0
    MOVK  X9, #0xab5, LSL #16
    MOVK  X9, #0xc7e8, LSL #32
    MOVK  X9, #0x4500, LSL #48
    SUB  X26, X9, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, V16.D[1]
    MOVZ  X12, #0x63c3, LSL #0
    MOVK  X12, #0xc7e4, LSL #16
    MOVK  X12, #0x1842, LSL #32
    MOVK  X12, #0x619a, LSL #48
    SUB  X24, X12, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, D16
    MOVZ  X12, #0x5fca, LSL #0
    MOVK  X12, #0x7431, LSL #16
    MOVK  X12, #0xf5e1, LSL #32
    MOVK  X12, #0xae30, LSL #48
    SUB  X24, X12, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X21, #0xaacc, LSL #0
    MOVK  X21, #0x909f, LSL #16
    MOVK  X21, #0x91de, LSL #32
    MOVK  X21, #0xf925, LSL #48
    SUB  X6, X21, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, D17
    MOVZ  X21, #0xb668, LSL #0
    MOVK  X21, #0x8d4a, LSL #16
    MOVK  X21, #0x6437, LSL #32
    MOVK  X21, #0xf0ae, LSL #48
    SUB  X6, X21, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X24, #0xab38, LSL #0
    MOVK  X24, #0xaf5a, LSL #16
    MOVK  X24, #0x3d95, LSL #32
    MOVK  X24, #0x6607, LSL #48
    SUB  X21, X24, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, D18
    MOVZ  X24, #0x7bf4, LSL #0
    MOVK  X24, #0xeab, LSL #16
    MOVK  X24, #0x47e3, LSL #32
    MOVK  X24, #0xa1d6, LSL #48
    SUB  X21, X24, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X8, #0xbccb, LSL #0
    MOVK  X8, #0x3c2f, LSL #16
    MOVK  X8, #0x7321, LSL #32
    MOVK  X8, #0xe0c2, LSL #48
    SUB  X17, X8, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, D19
    MOVZ  X8, #0xf79e, LSL #0
    MOVK  X8, #0x46f7, LSL #16
    MOVK  X8, #0x9e58, LSL #32
    MOVK  X8, #0xaf8e, LSL #48
    SUB  X17, X8, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, D20
    MOVZ  X24, #0x716, LSL #0
    MOVK  X24, #0xc6ce, LSL #16
    SUB  X5, X24, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X27, #0x7864, LSL #0
    MOVK  X27, #0x1e93, LSL #16
    MOVK  X27, #0x4e56, LSL #32
    MOVK  X27, #0xd40c, LSL #48
    SUB  X23, X27, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, D21
    MOVZ  X27, #0x1c9f, LSL #0
    MOVK  X27, #0x9437, LSL #16
    MOVK  X27, #0x1f5d, LSL #32
    MOVK  X27, #0x2154, LSL #48
    SUB  X23, X27, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X26, #0x1cc2, LSL #0
    MOVK  X26, #0x7383, LSL #16
    MOVK  X26, #0xb59f, LSL #32
    MOVK  X26, #0x455e, LSL #48
    SUB  X17, X26, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D23
    MOVZ  X26, #0xe71d, LSL #0
    MOVK  X26, #0xdc39, LSL #16
    MOVK  X26, #0xb34, LSL #32
    MOVK  X26, #0xaf7b, LSL #48
    SUB  X17, X26, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, D24
    MOVZ  X15, #0x602, LSL #0
    MOVK  X15, #0x6a36, LSL #16
    SUB  X17, X15, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X18, #0xf51b, LSL #0
    MOVK  X18, #0x4c21, LSL #16
    MOVK  X18, #0xa657, LSL #32
    MOVK  X18, #0x86d6, LSL #48
    SUB  X19, X18, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, D25
    MOVZ  X18, #0x532b, LSL #0
    MOVK  X18, #0xc36b, LSL #16
    MOVK  X18, #0xee43, LSL #32
    MOVK  X18, #0xba9d, LSL #48
    SUB  X19, X18, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X6, #0x34aa, LSL #0
    MOVK  X6, #0xe9b2, LSL #16
    MOVK  X6, #0xc66, LSL #32
    MOVK  X6, #0x586, LSL #48
    SUB  X21, X6, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, D26
    MOVZ  X6, #0x9dc9, LSL #0
    MOVK  X6, #0xbd9, LSL #16
    MOVK  X6, #0x9392, LSL #32
    MOVK  X6, #0xb8ae, LSL #48
    SUB  X21, X6, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, V27.D[1]
    MOVZ  X7, #0x21bd, LSL #0
    MOVK  X7, #0x662a, LSL #16
    MOVK  X7, #0xc9f7, LSL #32
    MOVK  X7, #0x6eef, LSL #48
    SUB  X10, X7, X3
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, D27
    MOVZ  X7, #0xa1ec, LSL #0
    MOVK  X7, #0xe772, LSL #16
    MOVK  X7, #0x87c3, LSL #32
    MOVK  X7, #0xc5eb, LSL #48
    SUB  X10, X7, X3
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, V28.D[1]
    MOVZ  X23, #0xb3fc, LSL #0
    MOVK  X23, #0xadbf, LSL #16
    MOVK  X23, #0x9b9d, LSL #32
    MOVK  X23, #0xa3ba, LSL #48
    SUB  X5, X23, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, D28
    MOVZ  X23, #0x9f8, LSL #0
    MOVK  X23, #0x7051, LSL #16
    MOVK  X23, #0xe800, LSL #32
    MOVK  X23, #0x1666, LSL #48
    SUB  X5, X23, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, V29.D[1]
    MOVZ  X25, #0x3fe4, LSL #0
    MOVK  X25, #0xa866, LSL #16
    MOVK  X25, #0x5283, LSL #32
    MOVK  X25, #0x4c05, LSL #48
    SUB  X19, X25, X27
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, D29
    MOVZ  X25, #0x4be5, LSL #0
    MOVK  X25, #0xe544, LSL #16
    MOVK  X25, #0xd56a, LSL #32
    MOVK  X25, #0xfeb7, LSL #48
    SUB  X19, X25, X27
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
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
    FMOV  D0, X13
    FMOV  V0.D[1], X3
    FMOV  D1, X29
    FMOV  V1.D[1], X4
    FMOV  D2, X7
    FMOV  V2.D[1], X10
    FMOV  D3, X15
    FMOV  V3.D[1], X26
    FMOV  D4, X14
    FMOV  V4.D[1], X29
    FMOV  D5, X13
    FMOV  V5.D[1], X16
    FMOV  D6, X17
    FMOV  V6.D[1], X3
    FMOV  D7, X3
    FMOV  V7.D[1], X23
    FMOV  D8, X27
    FMOV  V8.D[1], X13
    FMOV  D9, X3
    FMOV  V9.D[1], X5
    FMOV  D10, X29
    FMOV  V10.D[1], X13
    FMOV  D11, X21
    FMOV  V11.D[1], X29
    FMOV  D12, X29
    FMOV  V12.D[1], X7
    FMOV  D13, X11
    FMOV  V13.D[1], X25
    FMOV  D14, X19
    FMOV  V14.D[1], X3
    FMOV  D15, X19
    FMOV  V15.D[1], X27
    FMOV  D16, X5
    FMOV  V16.D[1], X7
    FMOV  D17, X19
    FMOV  V17.D[1], X29
    FMOV  D18, X5
    FMOV  V18.D[1], X8
    FMOV  D19, X6
    FMOV  V19.D[1], X4
    FMOV  D20, X5
    FMOV  V20.D[1], X11
    FMOV  D21, X27
    FMOV  V21.D[1], X25
    FMOV  D22, X26
    FMOV  V22.D[1], X25
    FMOV  D23, X8
    FMOV  V23.D[1], X23
    FMOV  D24, X18
    FMOV  V24.D[1], X21
    FMOV  D25, X2
    FMOV  V25.D[1], X5
    FMOV  D26, X18
    FMOV  V26.D[1], X12
    FMOV  D27, X19
    FMOV  V27.D[1], X29
    FMOV  D28, X9
    FMOV  V28.D[1], X11
    FMOV  D29, X25
    FMOV  V29.D[1], X17
    FMOV  D30, X8
    FMOV  V30.D[1], X24
    FMOV  D31, X25
    FMOV  V31.D[1], X2
    MOVZ  X29, #0xf, LSL #0
TaishanSimdUnaryArithmeticP01_label_905:
    AESD  V17.16B, V22.16B
    SHA1C  Q22, S11, V21.4S
    AESD  V3.16B, V8.16B
    AESD  V15.16B, V20.16B
    SHA1P  Q6, S12, V7.4S
    AESIMC  V9.16B, V17.16B
    SHA256SU1  V29.4S, V31.4S, V25.4S
    SHA1P  Q22, S1, V28.4S
    SHA256SU1  V14.4S, V12.4S, V5.4S
    SHA256SU1  V5.4S, V25.4S, V30.4S
    SHA256SU1  V31.4S, V13.4S, V7.4S
    SHA1P  Q0, S15, V26.4S
    AESD  V3.16B, V5.16B
    SHA1SU0  V0.4S, V9.4S, V18.4S
    AESIMC  V9.16B, V5.16B
    SHA1P  Q3, S30, V25.4S
    AESD  V31.16B, V7.16B
    AESIMC  V12.16B, V16.16B
    AESD  V28.16B, V24.16B
    SHA1SU1  V3.4S, V7.4S
    AESMC  V8.16B, V7.16B
    SHA1SU1  V13.4S, V9.4S
    SHA1M  Q21, S29, V28.4S
    SHA256SU0  V31.4S, V30.4S
    AESE  V6.16B, V21.16B
    AESD  V18.16B, V29.16B
    AESE  V16.16B, V8.16B
    AESD  V24.16B, V26.16B
    SHA256SU1  V16.4S, V14.4S, V15.4S
    SHA256H  Q4, Q22, V18.4S
    SHA256H  Q21, Q2, V13.4S
    SHA1SU1  V28.4S, V17.4S
    SHA1M  Q19, S17, V17.4S
TaishanSimdUnaryArithmeticP01_label_748:
    SHA1M  Q13, S7, V30.4S
    SHA1SU0  V27.4S, V0.4S, V0.4S
    AESD  V20.16B, V13.16B
    SHA256SU1  V23.4S, V17.4S, V25.4S
    SHA256SU1  V3.4S, V20.4S, V3.4S
    AESE  V13.16B, V18.16B
    SHA256SU0  V17.4S, V14.4S
    AESE  V14.16B, V6.16B
    AESD  V14.16B, V7.16B
    SHA1P  Q0, S27, V7.4S
    AESE  V24.16B, V6.16B
    SHA1P  Q8, S19, V2.4S
    AESMC  V18.16B, V2.16B
    AESD  V22.16B, V23.16B
    SHA256SU0  V17.4S, V6.4S
    SHA256SU0  V2.4S, V19.4S
    AESE  V19.16B, V0.16B
    AESIMC  V10.16B, V7.16B
    SHA1C  Q25, S16, V16.4S
    SHA1P  Q2, S29, V25.4S
    AESMC  V17.16B, V18.16B
    SHA1H  S5, S23
    SHA256SU0  V10.4S, V24.4S
    SHA1H  S2, S28
    SHA1P  Q0, S17, V6.4S
    AESD  V25.16B, V0.16B
    SHA256H2  Q9, Q25, V14.4S
    SHA1M  Q29, S22, V17.4S
    SHA1M  Q27, S1, V26.4S
    AESMC  V14.16B, V28.16B
    SHA1SU0  V7.4S, V2.4S, V16.4S
    AESMC  V22.16B, V25.16B
    SHA1P  Q24, S2, V10.4S
    SHA1H  S13, S11
    SHA1SU1  V27.4S, V9.4S
    SHA1M  Q18, S11, V14.4S
    SHA256SU1  V29.4S, V20.4S, V21.4S
    AESMC  V23.16B, V15.16B
    SHA1SU0  V31.4S, V27.4S, V12.4S
    AESMC  V16.16B, V4.16B
    SHA1P  Q5, S13, V15.4S
    SHA256H2  Q28, Q29, V22.4S
    SHA1SU1  V22.4S, V19.4S
    SHA1SU0  V7.4S, V29.4S, V15.4S
    AESIMC  V31.16B, V18.16B
    SHA1H  S19, S23
    AESE  V28.16B, V1.16B
    AESMC  V22.16B, V26.16B
    SHA256SU1  V1.4S, V30.4S, V25.4S
    SHA1SU0  V20.4S, V10.4S, V18.4S
    SHA256H  Q3, Q14, V2.4S
    SHA256H  Q14, Q0, V1.4S
    SHA1SU1  V28.4S, V21.4S
    SHA1SU1  V4.4S, V17.4S
    SHA256H2  Q1, Q19, V29.4S
    SHA1SU0  V16.4S, V20.4S, V6.4S
    SHA1M  Q19, S30, V31.4S
    SHA256H2  Q13, Q15, V4.4S
    SHA1SU1  V2.4S, V15.4S
    SHA256H  Q10, Q22, V20.4S
    SHA1C  Q9, S6, V21.4S
    AESD  V17.16B, V18.16B
    AESE  V11.16B, V19.16B
    SHA1C  Q1, S7, V20.4S
    SHA1SU0  V24.4S, V27.4S, V8.4S
    SHA1M  Q11, S31, V31.4S
    SHA256H2  Q20, Q11, V20.4S
    SHA256SU0  V10.4S, V7.4S
    SHA1P  Q15, S18, V17.4S
    SHA1M  Q1, S9, V29.4S
    AESE  V11.16B, V15.16B
    SHA1M  Q9, S14, V29.4S
    SHA1P  Q26, S27, V8.4S
    SHA256SU0  V11.4S, V9.4S
    AESD  V27.16B, V28.16B
    SHA1SU0  V11.4S, V22.4S, V23.4S
    SHA1SU0  V18.4S, V28.4S, V4.4S
    AESD  V0.16B, V28.16B
    SHA1M  Q4, S1, V19.4S
    SHA1C  Q4, S6, V29.4S
    AESIMC  V28.16B, V5.16B
    SHA256SU0  V10.4S, V16.4S
    SHA1H  S17, S3
    SHA1C  Q19, S29, V1.4S
    SHA256SU0  V20.4S, V10.4S
    SHA1H  S18, S10
    SHA1H  S12, S31
    SHA1H  S15, S23
    SHA256SU1  V1.4S, V24.4S, V6.4S
    SHA256H2  Q5, Q15, V26.4S
    SHA256SU1  V26.4S, V0.4S, V23.4S
    AESE  V22.16B, V10.16B
    SHA256H  Q3, Q23, V25.4S
    AESIMC  V29.16B, V7.16B
    SHA256SU0  V14.4S, V23.4S
    AESIMC  V0.16B, V15.16B
    SHA256SU0  V29.4S, V11.4S
    SHA1C  Q25, S1, V8.4S
    AESIMC  V9.16B, V27.16B
    SHA1M  Q6, S20, V15.4S
    AESE  V24.16B, V2.16B
    SHA256SU0  V24.4S, V15.4S
    AESIMC  V14.16B, V1.16B
    AESD  V11.16B, V4.16B
    SHA256H2  Q17, Q10, V16.4S
    SHA1SU1  V20.4S, V4.4S
    SHA256H  Q4, Q23, V15.4S
    SHA256H2  Q2, Q7, V15.4S
    AESIMC  V7.16B, V21.16B
    AESIMC  V23.16B, V8.16B
    SHA256H  Q16, Q21, V6.4S
    AESMC  V23.16B, V30.16B
    SHA1H  S10, S17
    SHA256H2  Q7, Q31, V5.4S
    AESMC  V26.16B, V21.16B
    SHA1SU1  V31.4S, V27.4S
    AESD  V28.16B, V18.16B
    SHA1P  Q30, S3, V16.4S
    SHA1SU1  V8.4S, V1.4S
    AESMC  V4.16B, V6.16B
    SHA256SU1  V7.4S, V23.4S, V28.4S
    AESIMC  V31.16B, V8.16B
    AESD  V10.16B, V15.16B
    AESIMC  V20.16B, V30.16B
    AESE  V15.16B, V21.16B
    SHA1P  Q21, S30, V18.4S
    SHA1C  Q27, S14, V26.4S
    SHA1M  Q16, S4, V27.4S
    SHA256SU1  V29.4S, V26.4S, V12.4S
    AESMC  V29.16B, V16.16B
    SHA1H  S10, S25
    SHA1H  S16, S25
    SHA1SU1  V18.4S, V5.4S
    SHA1P  Q17, S1, V19.4S
    SHA1SU1  V10.4S, V30.4S
    SHA256H  Q4, Q30, V10.4S
    AESE  V13.16B, V4.16B
    AESD  V31.16B, V24.16B
    AESMC  V30.16B, V8.16B
    SHA256SU0  V29.4S, V31.4S
    SHA256H  Q6, Q7, V14.4S
    SHA256SU0  V4.4S, V16.4S
    AESMC  V17.16B, V10.16B
    SHA256SU1  V15.4S, V12.4S, V18.4S
    SHA1SU1  V28.4S, V13.4S
    SHA256SU1  V10.4S, V5.4S, V30.4S
    SHA1SU1  V21.4S, V31.4S
    SHA256SU1  V16.4S, V1.4S, V13.4S
    SHA1SU1  V11.4S, V16.4S
    AESE  V4.16B, V9.16B
    AESD  V19.16B, V20.16B
    AESD  V25.16B, V25.16B
    SHA1SU0  V4.4S, V21.4S, V24.4S
    SHA1P  Q24, S10, V4.4S
    SHA1H  S11, S14
    AESMC  V25.16B, V17.16B
    SHA256H  Q8, Q6, V11.4S
    AESE  V1.16B, V11.16B
    SHA256H2  Q16, Q30, V15.4S
    SHA256H2  Q2, Q16, V30.4S
    SHA1C  Q29, S6, V8.4S
    SHA1SU1  V24.4S, V6.4S
    SHA1SU0  V18.4S, V4.4S, V7.4S
    AESMC  V22.16B, V8.16B
    SHA1C  Q12, S29, V25.4S
    SHA1SU0  V1.4S, V23.4S, V7.4S
    SHA256H  Q23, Q8, V22.4S
    SUBS  X29, X29, #0x1
    B.NE  TaishanSimdUnaryArithmeticP01_label_905
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X12, X29, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X3, X25, X4
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X20, X13, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X14, X6, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
TaishanSimdUnaryArithmeticP01_label_308:
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X18, X15, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X15, X16, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X4, X15, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X28, X15, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X24, X23, X13
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X17, X6, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X24, X10, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X9, X10, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X24, X26, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X24
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X2, X23, X25
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X12, X20, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X13, X25, X27
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X3, X17, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X16, X2, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, V2.D[1]
    MOVZ  X6, #0xabaf, LSL #0
    MOVK  X6, #0x1094, LSL #16
    MOVK  X6, #0x508d, LSL #32
    MOVK  X6, #0x9529, LSL #48
    SUB  X27, X6, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, D2
    MOVZ  X6, #0xeeae, LSL #0
    MOVK  X6, #0x7fc4, LSL #16
    MOVK  X6, #0xdde3, LSL #32
    MOVK  X6, #0x5b70, LSL #48
    SUB  X27, X6, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X23, #0x264d, LSL #0
    MOVK  X23, #0xb048, LSL #16
    MOVK  X23, #0x4d0d, LSL #32
    MOVK  X23, #0x287d, LSL #48
    SUB  X9, X23, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, D3
    MOVZ  X23, #0x9d72, LSL #0
    MOVK  X23, #0x4368, LSL #16
    MOVK  X23, #0x9750, LSL #32
    MOVK  X23, #0xb34a, LSL #48
    SUB  X9, X23, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X21, #0x8676, LSL #0
    MOVK  X21, #0x14fe, LSL #16
    MOVK  X21, #0xce2c, LSL #32
    MOVK  X21, #0x9bec, LSL #48
    SUB  X28, X21, X18
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, D4
    MOVZ  X21, #0x98e2, LSL #0
    MOVK  X21, #0x4bef, LSL #16
    MOVK  X21, #0xc569, LSL #32
    MOVK  X21, #0xb429, LSL #48
    SUB  X28, X21, X18
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X18, #0xb54a, LSL #0
    MOVK  X18, #0xd584, LSL #16
    MOVK  X18, #0xc22c, LSL #32
    MOVK  X18, #0x777e, LSL #48
    SUB  X4, X18, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, D5
    MOVZ  X18, #0xd7ca, LSL #0
    MOVK  X18, #0x857b, LSL #16
    MOVK  X18, #0x5b0e, LSL #32
    MOVK  X18, #0xa9ec, LSL #48
    SUB  X4, X18, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X23, #0x5e5c, LSL #0
    MOVK  X23, #0xc353, LSL #16
    MOVK  X23, #0xce6a, LSL #32
    MOVK  X23, #0x2690, LSL #48
    SUB  X14, X23, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, D6
    MOVZ  X23, #0x811e, LSL #0
    MOVK  X23, #0x8f9f, LSL #16
    MOVK  X23, #0x96b0, LSL #32
    MOVK  X23, #0xa0a, LSL #48
    SUB  X14, X23, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, V7.D[1]
    MOVZ  X24, #0xb274, LSL #0
    MOVK  X24, #0x686b, LSL #16
    MOVK  X24, #0x3bc8, LSL #32
    MOVK  X24, #0x9db9, LSL #48
    SUB  X29, X24, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, D7
    MOVZ  X24, #0x1ca2, LSL #0
    MOVK  X24, #0x1a19, LSL #16
    MOVK  X24, #0x4c0e, LSL #32
    MOVK  X24, #0xba67, LSL #48
    SUB  X29, X24, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, V8.D[1]
TaishanSimdUnaryArithmeticP01_label_153:
    MOVZ  X20, #0x4ec3, LSL #0
    MOVK  X20, #0xee87, LSL #16
    MOVK  X20, #0x17e1, LSL #32
    MOVK  X20, #0x5583, LSL #48
    SUB  X15, X20, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, D8
    MOVZ  X20, #0x3d78, LSL #0
    MOVK  X20, #0xaf7a, LSL #16
    MOVK  X20, #0xf3de, LSL #32
    MOVK  X20, #0xd218, LSL #48
    SUB  X15, X20, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X8, #0x4548, LSL #0
    MOVK  X8, #0x3ed6, LSL #16
    MOVK  X8, #0xde84, LSL #32
    MOVK  X8, #0x83d, LSL #48
    SUB  X21, X8, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, D9
    MOVZ  X8, #0x6f2c, LSL #0
    MOVK  X8, #0xf09, LSL #16
    MOVK  X8, #0x71ad, LSL #32
    MOVK  X8, #0x2dee, LSL #48
    SUB  X21, X8, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, V10.D[1]
    MOVZ  X26, #0x9161, LSL #0
    MOVK  X26, #0xd69e, LSL #16
    MOVK  X26, #0x73f4, LSL #32
    MOVK  X26, #0x38be, LSL #48
    SUB  X11, X26, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, D10
    MOVZ  X26, #0x5ea6, LSL #0
    MOVK  X26, #0x6f4b, LSL #16
    MOVK  X26, #0xa97e, LSL #32
    MOVK  X26, #0xb834, LSL #48
    SUB  X11, X26, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X21, X29, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D11
    MOVZ  X29, #0x8f64, LSL #0
    MOVK  X29, #0x621, LSL #16
    SUB  X21, X29, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, V12.D[1]
    MOVZ  X20, #0xa05c, LSL #0
    MOVK  X20, #0x6fd, LSL #16
    MOVK  X20, #0x386c, LSL #32
    MOVK  X20, #0x26, LSL #48
    SUB  X28, X20, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, D12
    MOVZ  X20, #0x57fe, LSL #0
    MOVK  X20, #0x2f64, LSL #16
    MOVK  X20, #0x2611, LSL #32
    MOVK  X20, #0xe9d0, LSL #48
    SUB  X28, X20, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X29, #0xb090, LSL #0
    MOVK  X29, #0x2b55, LSL #16
    MOVK  X29, #0xcd6b, LSL #32
    MOVK  X29, #0x1014, LSL #48
    SUB  X12, X29, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, D13
    MOVZ  X29, #0xb242, LSL #0
    MOVK  X29, #0xf759, LSL #16
    MOVK  X29, #0xa955, LSL #32
    MOVK  X29, #0x19cf, LSL #48
    SUB  X12, X29, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X13, #0x1e5a, LSL #0
    MOVK  X13, #0x6f08, LSL #16
    MOVK  X13, #0xa46b, LSL #32
    MOVK  X13, #0xaff9, LSL #48
    SUB  X21, X13, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, D14
    MOVZ  X13, #0x3d90, LSL #0
    MOVK  X13, #0x1886, LSL #16
    MOVK  X13, #0xbca, LSL #32
    MOVK  X13, #0x4b82, LSL #48
    SUB  X21, X13, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X27, #0xb793, LSL #0
    MOVK  X27, #0xd4e, LSL #16
    MOVK  X27, #0x9efa, LSL #32
    MOVK  X27, #0xa711, LSL #48
    SUB  X18, X27, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X16, D15
    MOVZ  X27, #0x62bb, LSL #0
    MOVK  X27, #0x2928, LSL #16
    MOVK  X27, #0x28b7, LSL #32
    MOVK  X27, #0x8397, LSL #48
    SUB  X18, X27, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X20, #0x16cf, LSL #0
    MOVK  X20, #0xd72a, LSL #16
    MOVK  X20, #0x1f60, LSL #32
    MOVK  X20, #0xa149, LSL #48
    SUB  X19, X20, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, D16
    MOVZ  X20, #0xb393, LSL #0
    MOVK  X20, #0xb331, LSL #16
    MOVK  X20, #0x50ab, LSL #32
    MOVK  X20, #0x423b, LSL #48
    SUB  X19, X20, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X7, #0xc9c7, LSL #0
    MOVK  X7, #0xbf94, LSL #16
    MOVK  X7, #0x6c1e, LSL #32
    MOVK  X7, #0xf326, LSL #48
    SUB  X23, X7, X6
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, D17
    MOVZ  X7, #0xa119, LSL #0
    MOVK  X7, #0xf992, LSL #16
    MOVK  X7, #0x8578, LSL #32
    MOVK  X7, #0xf1b, LSL #48
    SUB  X23, X7, X6
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X17, #0xaece, LSL #0
    MOVK  X17, #0xcd79, LSL #16
    MOVK  X17, #0xa69, LSL #32
    MOVK  X17, #0x7dce, LSL #48
    SUB  X29, X17, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X10, D18
    MOVZ  X17, #0xe29e, LSL #0
    MOVK  X17, #0xdecb, LSL #16
    MOVK  X17, #0xd253, LSL #32
    MOVK  X17, #0x4530, LSL #48
    SUB  X29, X17, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, V19.D[1]
    MOVZ  X6, #0x8f0d, LSL #0
    MOVK  X6, #0xb30, LSL #16
    MOVK  X6, #0x3aeb, LSL #32
    MOVK  X6, #0xa89e, LSL #48
    SUB  X26, X6, X5
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, D19
    MOVZ  X6, #0x294f, LSL #0
    MOVK  X6, #0x5d76, LSL #16
    MOVK  X6, #0x64e1, LSL #32
    MOVK  X6, #0xc525, LSL #48
    SUB  X26, X6, X5
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X8, #0xbca9, LSL #0
    MOVK  X8, #0x6e8f, LSL #16
    MOVK  X8, #0xcc34, LSL #32
    MOVK  X8, #0x6d07, LSL #48
    SUB  X6, X8, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, D20
    MOVZ  X8, #0x6330, LSL #0
    MOVK  X8, #0x2d25, LSL #16
    MOVK  X8, #0xae24, LSL #32
    MOVK  X8, #0x4b24, LSL #48
    SUB  X6, X8, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X19, #0x80bb, LSL #0
    MOVK  X19, #0x49ae, LSL #16
    MOVK  X19, #0x80b7, LSL #32
    MOVK  X19, #0x440f, LSL #48
    SUB  X20, X19, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X16, D21
    MOVZ  X19, #0xefdb, LSL #0
    MOVK  X19, #0xf13a, LSL #16
    MOVK  X19, #0x1221, LSL #32
    MOVK  X19, #0xb69b, LSL #48
    SUB  X20, X19, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X15, #0xd2b6, LSL #0
    MOVK  X15, #0x4d49, LSL #16
    MOVK  X15, #0xdf5d, LSL #32
    MOVK  X15, #0xaee6, LSL #48
    SUB  X28, X15, X6
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, D23
    MOVZ  X15, #0xa26d, LSL #0
    MOVK  X15, #0x77a6, LSL #16
    MOVK  X15, #0x2842, LSL #32
    MOVK  X15, #0xf18d, LSL #48
    SUB  X28, X15, X6
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, V24.D[1]
    MOVZ  X26, #0x427b, LSL #0
    MOVK  X26, #0xe68e, LSL #16
    MOVK  X26, #0x2a98, LSL #32
    MOVK  X26, #0x8a0e, LSL #48
    SUB  X12, X26, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, D24
    MOVZ  X26, #0x4bbc, LSL #0
    MOVK  X26, #0xc46f, LSL #16
    MOVK  X26, #0x7e24, LSL #32
    MOVK  X26, #0x5fd1, LSL #48
    SUB  X12, X26, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X19, #0x56fe, LSL #0
    MOVK  X19, #0x6ae7, LSL #16
    MOVK  X19, #0x5f5d, LSL #32
    MOVK  X19, #0x9530, LSL #48
    SUB  X10, X19, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, D25
    MOVZ  X19, #0x14a1, LSL #0
    MOVK  X19, #0xf197, LSL #16
    MOVK  X19, #0x4b70, LSL #32
    MOVK  X19, #0x8da, LSL #48
    SUB  X10, X19, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X18, #0x3a40, LSL #0
    MOVK  X18, #0x14ae, LSL #16
    MOVK  X18, #0x5406, LSL #32
    MOVK  X18, #0x79bd, LSL #48
    SUB  X20, X18, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, D26
    MOVZ  X18, #0xcfec, LSL #0
    MOVK  X18, #0x70b6, LSL #16
    MOVK  X18, #0x104, LSL #32
    MOVK  X18, #0x8000, LSL #48
    SUB  X20, X18, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X25, #0xe831, LSL #0
    MOVK  X25, #0x7e9c, LSL #16
    MOVK  X25, #0x862f, LSL #32
    MOVK  X25, #0x1db4, LSL #48
    SUB  X11, X25, X23
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, D27
    MOVZ  X25, #0x75e5, LSL #0
    MOVK  X25, #0x83ca, LSL #16
    MOVK  X25, #0xbae, LSL #32
    MOVK  X25, #0xe534, LSL #48
TaishanSimdUnaryArithmeticP01_label_405:
    SUB  X11, X25, X23
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, V28.D[1]
    MOVZ  X12, #0x7763, LSL #0
    MOVK  X12, #0xa803, LSL #16
    MOVK  X12, #0x7d1d, LSL #32
    MOVK  X12, #0xb1de, LSL #48
    SUB  X2, X12, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, D28
    MOVZ  X12, #0x1f4b, LSL #0
    MOVK  X12, #0xd93b, LSL #16
    MOVK  X12, #0xeb79, LSL #32
    MOVK  X12, #0xea3a, LSL #48
    SUB  X2, X12, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X11, #0x1fd, LSL #0
    MOVK  X11, #0x145c, LSL #16
    MOVK  X11, #0x2b11, LSL #32
    MOVK  X11, #0xed5b, LSL #48
    SUB  X21, X11, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X16, D29
    MOVZ  X11, #0x42d6, LSL #0
    MOVK  X11, #0xe026, LSL #16
    MOVK  X11, #0x3fbc, LSL #32
    MOVK  X11, #0xa6a, LSL #48
    SUB  X21, X11, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X2, #0x85d1, LSL #0
    MOVK  X2, #0xac7a, LSL #16
    MOVK  X2, #0x659, LSL #32
    MOVK  X2, #0x5017, LSL #48
    MOVZ  X3, #0x565b, LSL #0
    MOVK  X3, #0x4d88, LSL #16
    MOVK  X3, #0xe94e, LSL #32
    MOVK  X3, #0xb194, LSL #48
    MOVZ  X4, #0x5fa5, LSL #0
    MOVK  X4, #0x5aa4, LSL #16
    MOVK  X4, #0xb860, LSL #32
    MOVK  X4, #0x2441, LSL #48
    MOVZ  X5, #0x6d78, LSL #0
    MOVK  X5, #0xf6f, LSL #16
    MOVK  X5, #0xe148, LSL #32
    MOVK  X5, #0x179d, LSL #48
    MOVZ  X6, #0xd999, LSL #0
    MOVK  X6, #0x830e, LSL #16
    MOVK  X6, #0x95aa, LSL #32
    MOVK  X6, #0x511c, LSL #48
    MOVZ  X7, #0x2ef6, LSL #0
    MOVK  X7, #0xe05c, LSL #16
    MOVK  X7, #0x85b4, LSL #32
    MOVK  X7, #0x9838, LSL #48
    MOVZ  X8, #0x6a28, LSL #0
    MOVK  X8, #0x8cbc, LSL #16
    MOVK  X8, #0xdb8c, LSL #32
    MOVK  X8, #0xb486, LSL #48
    MOVZ  X9, #0xd7e8, LSL #0
    MOVK  X9, #0xe20, LSL #16
    MOVK  X9, #0xd79e, LSL #32
    MOVK  X9, #0x23cf, LSL #48
    MOVZ  X10, #0xf53e, LSL #0
    MOVK  X10, #0x6eca, LSL #16
    MOVK  X10, #0x3815, LSL #32
    MOVK  X10, #0x8487, LSL #48
    MOVZ  X11, #0x90a0, LSL #0
    MOVK  X11, #0x1ade, LSL #16
    MOVK  X11, #0xe0d, LSL #32
    MOVK  X11, #0xa0a9, LSL #48
    MOVZ  X12, #0xb7c1, LSL #0
    MOVK  X12, #0xbeb2, LSL #16
    MOVK  X12, #0x3085, LSL #32
    MOVK  X12, #0x90a2, LSL #48
    MOVZ  X13, #0x881b, LSL #0
    MOVK  X13, #0xaa98, LSL #16
    MOVK  X13, #0xdf53, LSL #32
    MOVK  X13, #0xc4f0, LSL #48
    MOVZ  X14, #0x7e, LSL #0
    MOVK  X14, #0x2acd, LSL #16
    MOVK  X14, #0x8ea, LSL #32
    MOVK  X14, #0x54, LSL #48
    MOVZ  X15, #0x7c4c, LSL #0
    MOVK  X15, #0x5a43, LSL #16
    MOVK  X15, #0xfe95, LSL #32
    MOVK  X15, #0xaab5, LSL #48
    MOVZ  X16, #0x2289, LSL #0
    MOVK  X16, #0x7cea, LSL #16
    MOVK  X16, #0xea0b, LSL #32
    MOVK  X16, #0xb516, LSL #48
    MOVZ  X17, #0x3a03, LSL #0
    MOVK  X17, #0xed46, LSL #16
    MOVK  X17, #0x6e0c, LSL #32
    MOVK  X17, #0x3bdf, LSL #48
    MOVZ  X18, #0xf418, LSL #0
    MOVK  X18, #0x8ca8, LSL #16
    MOVK  X18, #0x3bdb, LSL #32
    MOVK  X18, #0x52ca, LSL #48
    MOVZ  X19, #0xcf2d, LSL #0
    MOVK  X19, #0xbc7b, LSL #16
    MOVK  X19, #0xc650, LSL #32
    MOVK  X19, #0xbf80, LSL #48
    MOVZ  X20, #0x68d7, LSL #0
    MOVK  X20, #0x38ee, LSL #16
    MOVK  X20, #0xf8e3, LSL #32
    MOVK  X20, #0x4565, LSL #48
    MOVZ  X21, #0xb527, LSL #0
    MOVK  X21, #0x5b72, LSL #16
    MOVK  X21, #0x9f1a, LSL #32
    MOVK  X21, #0x9d15, LSL #48
    MOVZ  X23, #0xfd86, LSL #0
    MOVK  X23, #0x2dd, LSL #16
    MOVK  X23, #0x6849, LSL #32
    MOVK  X23, #0x31ac, LSL #48
    MOVZ  X24, #0x63c0, LSL #0
    MOVK  X24, #0x5302, LSL #16
    MOVK  X24, #0xe273, LSL #32
    MOVK  X24, #0xbf02, LSL #48
    MOVZ  X25, #0x3664, LSL #0
    MOVK  X25, #0x1113, LSL #16
    MOVK  X25, #0xb43c, LSL #32
    MOVK  X25, #0xfb1d, LSL #48
    MOVZ  X26, #0xd723, LSL #0
    MOVK  X26, #0xd7bf, LSL #16
    MOVK  X26, #0xff9c, LSL #32
    MOVK  X26, #0xa45a, LSL #48
    MOVZ  X27, #0xb0ac, LSL #0
    MOVK  X27, #0x6961, LSL #16
    MOVK  X27, #0xb23c, LSL #32
    MOVK  X27, #0xc793, LSL #48
    MOVZ  X28, #0xfa20, LSL #0
    MOVK  X28, #0xb5fa, LSL #16
    MOVK  X28, #0xfa06, LSL #32
    MOVK  X28, #0xee59, LSL #48
    MOVZ  X29, #0xb346, LSL #0
    MOVK  X29, #0xcb4a, LSL #16
    MOVK  X29, #0xeff2, LSL #32
    MOVK  X29, #0xbbc4, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X16
    FMOV  D1, X2
    FMOV  V1.D[1], X4
    FMOV  D2, X19
    FMOV  V2.D[1], X27
    FMOV  D3, X16
    FMOV  V3.D[1], X12
    FMOV  D4, X8
    FMOV  V4.D[1], X12
    FMOV  D5, X12
    FMOV  V5.D[1], X15
    FMOV  D6, X27
    FMOV  V6.D[1], X28
    FMOV  D7, X29
    FMOV  V7.D[1], X10
    FMOV  D8, X14
    FMOV  V8.D[1], X6
    FMOV  D9, X6
    FMOV  V9.D[1], X19
    FMOV  D10, X3
    FMOV  V10.D[1], X9
TaishanSimdUnaryArithmeticP01_label_629:
    FMOV  D11, X2
    FMOV  V11.D[1], X10
    FMOV  D12, X5
    FMOV  V12.D[1], X28
    FMOV  D13, X6
    FMOV  V13.D[1], X5
    FMOV  D14, X21
    FMOV  V14.D[1], X7
    FMOV  D15, X11
    FMOV  V15.D[1], X18
    FMOV  D16, X28
    FMOV  V16.D[1], X20
    FMOV  D17, X6
    FMOV  V17.D[1], X13
    FMOV  D18, X29
    FMOV  V18.D[1], X6
    FMOV  D19, X5
    FMOV  V19.D[1], X13
    FMOV  D20, X21
    FMOV  V20.D[1], X28
    FMOV  D21, X3
    FMOV  V21.D[1], X27
    FMOV  D22, X29
    FMOV  V22.D[1], X10
    FMOV  D23, X12
    FMOV  V23.D[1], X10
    FMOV  D24, X20
    FMOV  V24.D[1], X14
    FMOV  D25, X13
    FMOV  V25.D[1], X23
    FMOV  D26, X10
    FMOV  V26.D[1], X10
    FMOV  D27, X2
    FMOV  V27.D[1], X24
    FMOV  D28, X14
    FMOV  V28.D[1], X28
    FMOV  D29, X28
    FMOV  V29.D[1], X15
    FMOV  D30, X10
    FMOV  V30.D[1], X23
    FMOV  D31, X16
    FMOV  V31.D[1], X16
    MOVZ  X25, #0xa, LSL #0
TaishanSimdUnaryArithmeticP01_label_985:
    SHA256H2  Q19, Q10, V10.4S
    AESD  V3.16B, V26.16B
    SHA256SU0  V29.4S, V23.4S
    SHA1P  Q19, S2, V19.4S
    AESD  V24.16B, V19.16B
    SHA1SU1  V13.4S, V13.4S
    SHA256H2  Q30, Q17, V31.4S
    SHA1C  Q30, S9, V25.4S
    SHA256H  Q22, Q3, V9.4S
    AESMC  V15.16B, V24.16B
    AESIMC  V6.16B, V13.16B
    SHA256SU0  V9.4S, V30.4S
    SHA1P  Q1, S26, V17.4S
    AESMC  V31.16B, V18.16B
    SHA1SU1  V22.4S, V17.4S
    SHA1P  Q15, S6, V28.4S
    AESE  V25.16B, V31.16B
    SHA1M  Q24, S1, V28.4S
    SHA1M  Q11, S13, V24.4S
    SHA256H  Q14, Q13, V18.4S
    SHA1SU1  V28.4S, V28.4S
    SHA1H  S22, S26
    SHA256SU0  V2.4S, V0.4S
    AESE  V25.16B, V26.16B
    AESE  V13.16B, V29.16B
    SHA256H  Q0, Q6, V16.4S
    SHA1C  Q11, S0, V21.4S
    SHA256SU0  V0.4S, V5.4S
    SHA1M  Q29, S28, V22.4S
    AESIMC  V26.16B, V1.16B
    AESD  V1.16B, V30.16B
    SHA256H  Q30, Q11, V1.4S
    SHA256SU0  V19.4S, V20.4S
    SHA1P  Q25, S9, V17.4S
    AESD  V11.16B, V26.16B
    AESIMC  V20.16B, V28.16B
    SHA256H  Q1, Q7, V8.4S
    AESE  V0.16B, V9.16B
    SHA256SU0  V13.4S, V20.4S
    SHA1SU1  V30.4S, V27.4S
    SHA1SU0  V11.4S, V2.4S, V25.4S
    SHA1P  Q3, S12, V14.4S
    SHA1C  Q9, S13, V6.4S
    SHA1H  S29, S13
    AESD  V21.16B, V11.16B
    SHA1C  Q3, S9, V4.4S
    SHA1SU0  V12.4S, V26.4S, V11.4S
    AESD  V28.16B, V9.16B
    SHA1C  Q8, S16, V17.4S
    AESMC  V6.16B, V4.16B
    AESD  V14.16B, V20.16B
    SHA1C  Q20, S19, V23.4S
    SHA1C  Q15, S20, V26.4S
    SHA256SU1  V12.4S, V16.4S, V27.4S
    SHA256SU1  V22.4S, V28.4S, V15.4S
    AESE  V14.16B, V1.16B
    AESD  V18.16B, V15.16B
    SHA1SU0  V11.4S, V28.4S, V3.4S
    AESD  V0.16B, V28.16B
    SHA256H  Q25, Q3, V26.4S
    SHA256H2  Q15, Q13, V11.4S
    SHA1H  S2, S6
    AESIMC  V8.16B, V19.16B
    AESMC  V21.16B, V14.16B
    SHA256SU1  V3.4S, V3.4S, V13.4S
    SHA1SU0  V23.4S, V11.4S, V20.4S
    SHA1SU1  V23.4S, V2.4S
    AESD  V15.16B, V8.16B
    SHA256H2  Q19, Q30, V17.4S
    SHA1SU0  V3.4S, V23.4S, V12.4S
    SHA1C  Q10, S9, V28.4S
    SHA256H2  Q2, Q30, V24.4S
    SHA256SU1  V23.4S, V4.4S, V2.4S
    SHA1M  Q23, S18, V6.4S
    AESD  V31.16B, V27.16B
    SHA1M  Q25, S13, V17.4S
    AESE  V15.16B, V4.16B
    AESE  V23.16B, V31.16B
    SHA1H  S10, S15
    AESIMC  V14.16B, V23.16B
    SHA1M  Q0, S8, V28.4S
    SHA256H  Q5, Q16, V30.4S
    SHA1P  Q0, S10, V3.4S
    SHA256H2  Q6, Q30, V6.4S
    AESIMC  V5.16B, V25.16B
    AESIMC  V19.16B, V3.16B
    SHA256H  Q0, Q20, V5.4S
    AESMC  V6.16B, V25.16B
    SHA1M  Q16, S12, V21.4S
    SHA1P  Q23, S21, V15.4S
    AESD  V11.16B, V25.16B
    SHA1C  Q31, S2, V7.4S
    AESD  V12.16B, V24.16B
    SHA256SU0  V12.4S, V22.4S
    AESMC  V14.16B, V9.16B
    SHA256H2  Q28, Q14, V3.4S
    SHA1P  Q12, S16, V14.4S
    SHA1M  Q20, S25, V14.4S
    AESIMC  V2.16B, V19.16B
    AESD  V31.16B, V12.16B
    SHA1SU0  V24.4S, V18.4S, V7.4S
    SHA1SU1  V8.4S, V9.4S
    AESMC  V5.16B, V0.16B
    SHA256SU0  V1.4S, V22.4S
    AESMC  V23.16B, V1.16B
    SHA1SU0  V9.4S, V9.4S, V0.4S
    SHA1P  Q10, S5, V18.4S
    SHA1M  Q3, S22, V11.4S
    SHA256H2  Q28, Q21, V3.4S
    AESIMC  V2.16B, V30.16B
    SHA1M  Q23, S6, V24.4S
    AESIMC  V18.16B, V28.16B
    SHA1C  Q1, S12, V15.4S
    AESE  V16.16B, V10.16B
    SHA256H  Q21, Q22, V24.4S
    SHA1SU1  V8.4S, V12.4S
    SHA1SU0  V20.4S, V16.4S, V20.4S
    SHA1C  Q10, S2, V14.4S
    SHA256SU0  V9.4S, V10.4S
    AESD  V7.16B, V18.16B
    SHA1C  Q0, S28, V3.4S
    AESE  V12.16B, V21.16B
    SHA256H  Q15, Q22, V1.4S
    AESD  V25.16B, V0.16B
    SHA1P  Q16, S23, V14.4S
    SHA1C  Q1, S20, V25.4S
    AESE  V22.16B, V28.16B
    SHA1P  Q23, S22, V20.4S
    AESIMC  V19.16B, V28.16B
    SHA256SU1  V2.4S, V7.4S, V11.4S
    SHA1SU0  V25.4S, V2.4S, V12.4S
    AESD  V10.16B, V17.16B
    AESE  V30.16B, V6.16B
    AESD  V9.16B, V22.16B
    SHA1C  Q30, S22, V10.4S
    SHA1SU0  V15.4S, V10.4S, V28.4S
    SHA1P  Q16, S15, V0.4S
    SHA1C  Q23, S13, V27.4S
    AESD  V16.16B, V1.16B
    SHA256H2  Q18, Q14, V23.4S
    SHA256H2  Q12, Q23, V4.4S
    SHA256H  Q3, Q23, V0.4S
    SHA256H  Q20, Q26, V23.4S
    AESIMC  V7.16B, V11.16B
    SHA256H2  Q5, Q28, V16.4S
    AESE  V25.16B, V10.16B
    AESD  V27.16B, V1.16B
    SHA256SU0  V30.4S, V29.4S
    SHA1C  Q6, S26, V7.4S
    SHA1C  Q3, S30, V0.4S
    SHA1P  Q23, S12, V25.4S
    SHA1H  S13, S28
    SHA1P  Q15, S1, V2.4S
    SHA1P  Q20, S9, V11.4S
    AESIMC  V24.16B, V10.16B
    SHA1SU1  V1.4S, V24.4S
    AESMC  V17.16B, V31.16B
    AESE  V19.16B, V15.16B
    SHA1P  Q0, S31, V26.4S
    SHA1P  Q29, S24, V15.4S
    SHA1H  S26, S31
    AESD  V20.16B, V25.16B
    SHA256H  Q28, Q16, V21.4S
    SHA1C  Q16, S5, V22.4S
    SHA1H  S7, S2
    AESMC  V15.16B, V18.16B
    AESMC  V5.16B, V10.16B
    SHA1P  Q7, S29, V22.4S
    SHA1SU1  V17.4S, V14.4S
    AESIMC  V23.16B, V27.16B
    SHA256H2  Q5, Q26, V0.4S
    SHA1P  Q16, S28, V31.4S
    SHA1P  Q30, S30, V23.4S
    SHA1H  S14, S28
    AESMC  V31.16B, V3.16B
    AESIMC  V1.16B, V27.16B
    SHA1H  S2, S15
    SHA1P  Q31, S29, V14.4S
    SHA1SU1  V15.4S, V4.4S
    SHA256H  Q28, Q30, V5.4S
    SHA256SU0  V25.4S, V20.4S
    SHA1H  S28, S20
    SHA256H2  Q9, Q25, V28.4S
    AESIMC  V5.16B, V4.16B
    SHA256H  Q2, Q0, V29.4S
    AESIMC  V9.16B, V31.16B
    SHA1SU1  V1.4S, V26.4S
    SHA1H  S23, S11
    SHA1C  Q15, S8, V11.4S
    SHA256SU0  V21.4S, V24.4S
    AESD  V20.16B, V3.16B
    SHA256H2  Q4, Q5, V23.4S
    SHA1SU0  V28.4S, V4.4S, V29.4S
    SHA1H  S22, S6
    SHA256SU1  V21.4S, V5.4S, V24.4S
    SHA256SU1  V15.4S, V0.4S, V31.4S
    AESIMC  V6.16B, V13.16B
    SHA1H  S29, S18
    SHA1M  Q10, S17, V4.4S
    SHA1SU1  V18.4S, V20.4S
    SUBS  X25, X25, #0x1
    B.NE  TaishanSimdUnaryArithmeticP01_label_985
    MOVZ  X12, #0x85d1, LSL #0
    MOVK  X12, #0xac7a, LSL #16
    MOVK  X12, #0x659, LSL #32
    MOVK  X12, #0x5017, LSL #48
    SUB  X7, X12, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X25, #0x565b, LSL #0
    MOVK  X25, #0x4d88, LSL #16
    MOVK  X25, #0xe94e, LSL #32
    MOVK  X25, #0xb194, LSL #48
    SUB  X10, X25, X3
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X14, #0x5fa5, LSL #0
    MOVK  X14, #0x5aa4, LSL #16
    MOVK  X14, #0xb860, LSL #32
    MOVK  X14, #0x2441, LSL #48
    SUB  X3, X14, X4
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X8, #0x6d78, LSL #0
    MOVK  X8, #0xf6f, LSL #16
    MOVK  X8, #0xe148, LSL #32
    MOVK  X8, #0x179d, LSL #48
    SUB  X7, X8, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X29, #0xd999, LSL #0
    MOVK  X29, #0x830e, LSL #16
    MOVK  X29, #0x95aa, LSL #32
    MOVK  X29, #0x511c, LSL #48
    SUB  X27, X29, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X24, #0x6d78, LSL #0
    MOVK  X24, #0xf6f, LSL #16
    MOVK  X24, #0xe148, LSL #32
    MOVK  X24, #0x179d, LSL #48
    SUB  X5, X24, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X25, #0xd7e8, LSL #0
    MOVK  X25, #0xe20, LSL #16
    MOVK  X25, #0xd79e, LSL #32
    MOVK  X25, #0x23cf, LSL #48
    SUB  X8, X25, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X3, #0x90a0, LSL #0
    MOVK  X3, #0x1ade, LSL #16
    MOVK  X3, #0xe0d, LSL #32
    MOVK  X3, #0xa0a9, LSL #48
    SUB  X28, X3, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X6, #0x85d1, LSL #0
    MOVK  X6, #0xac7a, LSL #16
    MOVK  X6, #0x659, LSL #32
    MOVK  X6, #0x5017, LSL #48
    SUB  X20, X6, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X13, #0x881b, LSL #0
    MOVK  X13, #0xaa98, LSL #16
    MOVK  X13, #0xdf53, LSL #32
    MOVK  X13, #0xc4f0, LSL #48
    SUB  X6, X13, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X27, #0x5fa5, LSL #0
    MOVK  X27, #0x5aa4, LSL #16
    MOVK  X27, #0xb860, LSL #32
    MOVK  X27, #0x2441, LSL #48
    SUB  X15, X27, X14
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X15, #0x2289, LSL #0
    MOVK  X15, #0x7cea, LSL #16
    MOVK  X15, #0xea0b, LSL #32
    MOVK  X15, #0xb516, LSL #48
    SUB  X23, X15, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X4, #0x3a03, LSL #0
    MOVK  X4, #0xed46, LSL #16
    MOVK  X4, #0x6e0c, LSL #32
    MOVK  X4, #0x3bdf, LSL #48
    SUB  X2, X4, X17
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X25, #0xf418, LSL #0
    MOVK  X25, #0x8ca8, LSL #16
    MOVK  X25, #0x3bdb, LSL #32
    MOVK  X25, #0x52ca, LSL #48
    SUB  X5, X25, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X21, #0xcf2d, LSL #0
    MOVK  X21, #0xbc7b, LSL #16
    MOVK  X21, #0xc650, LSL #32
    MOVK  X21, #0xbf80, LSL #48
    SUB  X13, X21, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X19, #0xf418, LSL #0
    MOVK  X19, #0x8ca8, LSL #16
    MOVK  X19, #0x3bdb, LSL #32
    MOVK  X19, #0x52ca, LSL #48
    SUB  X27, X19, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X26, X28, X26
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X12, #0xd999, LSL #0
    MOVK  X12, #0x830e, LSL #16
    MOVK  X12, #0x95aa, LSL #32
    MOVK  X12, #0x511c, LSL #48
    SUB  X7, X12, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X7, #0xc6f8, LSL #0
    MOVK  X7, #0xb518, LSL #16
    MOVK  X7, #0xdf52, LSL #32
    MOVK  X7, #0xecb1, LSL #48
    SUB  X25, X7, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, D2
    MOVZ  X7, #0x3ca9, LSL #0
    MOVK  X7, #0x9ab4, LSL #16
    MOVK  X7, #0x8fa8, LSL #32
    MOVK  X7, #0xbd8b, LSL #48
    SUB  X25, X7, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X29, #0xad7f, LSL #0
    MOVK  X29, #0x1749, LSL #16
    MOVK  X29, #0x6a50, LSL #32
    MOVK  X29, #0x7882, LSL #48
    SUB  X15, X29, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, D3
    MOVZ  X29, #0x3057, LSL #0
    MOVK  X29, #0x3a75, LSL #16
    MOVK  X29, #0x36c9, LSL #32
    MOVK  X29, #0xb6a6, LSL #48
    SUB  X15, X29, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, V4.D[1]
    MOVZ  X23, #0x1cb, LSL #0
    MOVK  X23, #0x9714, LSL #16
    MOVK  X23, #0xa893, LSL #32
    MOVK  X23, #0xb0b4, LSL #48
    SUB  X26, X23, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, D4
    MOVZ  X23, #0x60d7, LSL #0
    MOVK  X23, #0xa5bc, LSL #16
    MOVK  X23, #0xbac1, LSL #32
    MOVK  X23, #0x4120, LSL #48
    SUB  X26, X23, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X7, #0x9649, LSL #0
    MOVK  X7, #0xd244, LSL #16
    MOVK  X7, #0x3c3b, LSL #32
    MOVK  X7, #0xc1bc, LSL #48
    SUB  X16, X7, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, D5
    MOVZ  X7, #0x6c06, LSL #0
    MOVK  X7, #0xe3f9, LSL #16
    MOVK  X7, #0x61e6, LSL #32
    MOVK  X7, #0xac34, LSL #48
    SUB  X16, X7, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, V6.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X21
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, D6
    MOVZ  X11, #0x4e6c, LSL #0
    MOVK  X11, #0xdcd9, LSL #16
    SUB  X23, X11, X21
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X29, #0x8bd6, LSL #0
    MOVK  X29, #0x444f, LSL #16
    MOVK  X29, #0xd41f, LSL #32
    MOVK  X29, #0xce56, LSL #48
    SUB  X4, X29, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, D7
    MOVZ  X29, #0xb9f5, LSL #0
    MOVK  X29, #0xb077, LSL #16
    MOVK  X29, #0x53c7, LSL #32
    MOVK  X29, #0x8695, LSL #48
    SUB  X4, X29, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X13, #0x20ac, LSL #0
    MOVK  X13, #0x84e5, LSL #16
    MOVK  X13, #0xb189, LSL #32
    MOVK  X13, #0xc110, LSL #48
    SUB  X17, X13, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, D8
    MOVZ  X13, #0xca88, LSL #0
    MOVK  X13, #0x115b, LSL #16
    MOVK  X13, #0xdd4f, LSL #32
    MOVK  X13, #0xc101, LSL #48
    SUB  X17, X13, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, V9.D[1]
    MOVZ  X28, #0xd691, LSL #0
    MOVK  X28, #0x8db, LSL #16
    MOVK  X28, #0xa1bd, LSL #32
    MOVK  X28, #0xb9ef, LSL #48
    SUB  X24, X28, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, D9
    MOVZ  X28, #0xa6ee, LSL #0
    MOVK  X28, #0x3634, LSL #16
    MOVK  X28, #0x34bf, LSL #32
    MOVK  X28, #0x1e6e, LSL #48
    SUB  X24, X28, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X7, #0xc4b6, LSL #0
    MOVK  X7, #0x288c, LSL #16
    MOVK  X7, #0x502, LSL #32
    MOVK  X7, #0x33b6, LSL #48
    SUB  X14, X7, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, D10
    MOVZ  X7, #0x9e97, LSL #0
    MOVK  X7, #0x6d5e, LSL #16
    MOVK  X7, #0x5a44, LSL #32
    MOVK  X7, #0x1f98, LSL #48
    SUB  X14, X7, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, V11.D[1]
    MOVZ  X29, #0xacb0, LSL #0
    MOVK  X29, #0x6fa1, LSL #16
    MOVK  X29, #0xfb37, LSL #32
    MOVK  X29, #0x8cab, LSL #48
    SUB  X21, X29, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, D11
    MOVZ  X29, #0x60ca, LSL #0
    MOVK  X29, #0x395, LSL #16
    MOVK  X29, #0x389e, LSL #32
    MOVK  X29, #0x79, LSL #48
    SUB  X21, X29, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X16, #0x97ec, LSL #0
    MOVK  X16, #0xbab, LSL #16
    MOVK  X16, #0xc03e, LSL #32
    MOVK  X16, #0x8c02, LSL #48
    SUB  X21, X16, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, D12
    MOVZ  X16, #0x532f, LSL #0
    MOVK  X16, #0xe7cb, LSL #16
    MOVK  X16, #0xca53, LSL #32
    MOVK  X16, #0xbc3b, LSL #48
    SUB  X21, X16, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, V13.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, D13
    MOVZ  X8, #0x5c0f, LSL #0
    MOVK  X8, #0x80f4, LSL #16
    SUB  X2, X8, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, V14.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X20, X28, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, D14
    MOVZ  X28, #0x848e, LSL #0
    MOVK  X28, #0xa8ea, LSL #16
    SUB  X20, X28, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X5, #0xd4ae, LSL #0
    MOVK  X5, #0x115b, LSL #16
    MOVK  X5, #0x17c3, LSL #32
    MOVK  X5, #0xee5e, LSL #48
    SUB  X29, X5, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, D15
    MOVZ  X5, #0x3fb1, LSL #0
    MOVK  X5, #0xddba, LSL #16
    MOVK  X5, #0x3765, LSL #32
    MOVK  X5, #0x2e12, LSL #48
    SUB  X29, X5, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X12, #0xa2cc, LSL #0
    MOVK  X12, #0x6b87, LSL #16
    MOVK  X12, #0x3756, LSL #32
    MOVK  X12, #0xd5a1, LSL #48
    SUB  X25, X12, X26
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, D16
    MOVZ  X12, #0x830d, LSL #0
    MOVK  X12, #0x89d5, LSL #16
    MOVK  X12, #0x3d2a, LSL #32
    MOVK  X12, #0x77b3, LSL #48
    SUB  X25, X12, X26
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, V17.D[1]
    MOVZ  X12, #0x5b14, LSL #0
    MOVK  X12, #0xc51d, LSL #16
    MOVK  X12, #0xd090, LSL #32
    MOVK  X12, #0x8ab7, LSL #48
    SUB  X11, X12, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, D17
    MOVZ  X12, #0x4676, LSL #0
    MOVK  X12, #0x917f, LSL #16
    MOVK  X12, #0x84fb, LSL #32
    MOVK  X12, #0x5c85, LSL #48
    SUB  X11, X12, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, V18.D[1]
    MOVZ  X21, #0x25dc, LSL #0
    MOVK  X21, #0xfb62, LSL #16
    MOVK  X21, #0xfa74, LSL #32
    MOVK  X21, #0x11ec, LSL #48
    SUB  X5, X21, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, D18
    MOVZ  X21, #0xf37, LSL #0
    MOVK  X21, #0x900, LSL #16
    MOVK  X21, #0xe66a, LSL #32
    MOVK  X21, #0xb179, LSL #48
    SUB  X5, X21, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X26, #0x58b6, LSL #0
    MOVK  X26, #0x540a, LSL #16
    MOVK  X26, #0xd4f8, LSL #32
    MOVK  X26, #0x8d2e, LSL #48
    SUB  X28, X26, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, D19
    MOVZ  X26, #0xc09d, LSL #0
    MOVK  X26, #0x2f10, LSL #16
    MOVK  X26, #0xcc02, LSL #32
    MOVK  X26, #0xe77e, LSL #48
    SUB  X28, X26, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, V20.D[1]
    MOVZ  X16, #0x66b1, LSL #0
    MOVK  X16, #0xe86d, LSL #16
    MOVK  X16, #0xac64, LSL #32
    MOVK  X16, #0xba29, LSL #48
    SUB  X4, X16, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, D20
    MOVZ  X16, #0x9c88, LSL #0
    MOVK  X16, #0x780f, LSL #16
    MOVK  X16, #0xafe7, LSL #32
    MOVK  X16, #0x92e4, LSL #48
    SUB  X4, X16, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X26, #0xbe83, LSL #0
    MOVK  X26, #0x1107, LSL #16
    MOVK  X26, #0x2c9d, LSL #32
    MOVK  X26, #0xb428, LSL #48
    SUB  X14, X26, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, D21
    MOVZ  X26, #0x5445, LSL #0
    MOVK  X26, #0xdcf9, LSL #16
    MOVK  X26, #0x20bb, LSL #32
    MOVK  X26, #0x1457, LSL #48
    SUB  X14, X26, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, V23.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, D23
    MOVZ  X27, #0x5832, LSL #0
    MOVK  X27, #0x80e5, LSL #16
    SUB  X11, X27, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X17, #0x50b1, LSL #0
    MOVK  X17, #0xadf, LSL #16
    MOVK  X17, #0xabc5, LSL #32
    MOVK  X17, #0x36c0, LSL #48
    SUB  X2, X17, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, D24
    MOVZ  X17, #0x595d, LSL #0
    MOVK  X17, #0xd7b1, LSL #16
    MOVK  X17, #0x95c6, LSL #32
    MOVK  X17, #0x78af, LSL #48
    SUB  X2, X17, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, V25.D[1]
    MOVZ  X29, #0xd36b, LSL #0
    MOVK  X29, #0x8836, LSL #16
    MOVK  X29, #0xb087, LSL #32
    MOVK  X29, #0x2434, LSL #48
    SUB  X7, X29, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, D25
    MOVZ  X29, #0x7c7c, LSL #0
    MOVK  X29, #0x6446, LSL #16
    MOVK  X29, #0xf0c, LSL #32
    MOVK  X29, #0xbf15, LSL #48
    SUB  X7, X29, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, D26
    MOVZ  X18, #0x9d10, LSL #0
    MOVK  X18, #0x4672, LSL #16
    SUB  X7, X18, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X17, #0x7eeb, LSL #0
    MOVK  X17, #0x235d, LSL #16
    MOVK  X17, #0xb55d, LSL #32
    MOVK  X17, #0x1f6f, LSL #48
    SUB  X28, X17, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, D27
    MOVZ  X17, #0xe9ec, LSL #0
    MOVK  X17, #0x1f5b, LSL #16
    MOVK  X17, #0x769e, LSL #32
    MOVK  X17, #0x588d, LSL #48
    SUB  X28, X17, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X16, #0x8d24, LSL #0
    MOVK  X16, #0xb3b4, LSL #16
    MOVK  X16, #0x68e7, LSL #32
    MOVK  X16, #0x71a0, LSL #48
    SUB  X12, X16, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D28
    MOVZ  X16, #0xc169, LSL #0
    MOVK  X16, #0xd599, LSL #16
    MOVK  X16, #0x4305, LSL #32
    MOVK  X16, #0x3cec, LSL #48
    SUB  X12, X16, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, D29
    MOVZ  X4, #0x2a1f, LSL #0
    MOVK  X4, #0x599, LSL #16
    SUB  X11, X4, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
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
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X24
    FMOV  V0.D[1], X24
    FMOV  D1, X3
    FMOV  V1.D[1], X20
    FMOV  D2, X8
    FMOV  V2.D[1], X14
    FMOV  D3, X21
    FMOV  V3.D[1], X21
    FMOV  D4, X24
    FMOV  V4.D[1], X14
    FMOV  D5, X8
    FMOV  V5.D[1], X14
    FMOV  D6, X29
    FMOV  V6.D[1], X21
    FMOV  D7, X29
    FMOV  V7.D[1], X11
    FMOV  D8, X2
    FMOV  V8.D[1], X23
    FMOV  D9, X24
    FMOV  V9.D[1], X4
    FMOV  D10, X13
    FMOV  V10.D[1], X15
    FMOV  D11, X26
    FMOV  V11.D[1], X10
    FMOV  D12, X28
    FMOV  V12.D[1], X25
    FMOV  D13, X26
    FMOV  V13.D[1], X6
    FMOV  D14, X11
    FMOV  V14.D[1], X5
    FMOV  D15, X4
    FMOV  V15.D[1], X2
    FMOV  D16, X3
    FMOV  V16.D[1], X10
    FMOV  D17, X29
    FMOV  V17.D[1], X4
    FMOV  D18, X2
    FMOV  V18.D[1], X6
    FMOV  D19, X11
    FMOV  V19.D[1], X19
    FMOV  D20, X28
    FMOV  V20.D[1], X6
    FMOV  D21, X10
    FMOV  V21.D[1], X15
    FMOV  D22, X25
    FMOV  V22.D[1], X8
    FMOV  D23, X6
    FMOV  V23.D[1], X4
    FMOV  D24, X4
    FMOV  V24.D[1], X12
    FMOV  D25, X27
    FMOV  V25.D[1], X14
    FMOV  D26, X28
    FMOV  V26.D[1], X27
    FMOV  D27, X17
    FMOV  V27.D[1], X12
    FMOV  D28, X26
    FMOV  V28.D[1], X7
    FMOV  D29, X8
    FMOV  V29.D[1], X23
    FMOV  D30, X25
    FMOV  V30.D[1], X26
    FMOV  D31, X6
    FMOV  V31.D[1], X12
    MOVZ  X18, #0xa, LSL #0
TaishanSimdUnaryArithmeticP01_label_1066:
    SHA1SU1  V24.4S, V7.4S
    SHA256H2  Q31, Q29, V1.4S
    SHA1C  Q23, S30, V7.4S
    AESMC  V21.16B, V7.16B
    SHA256H  Q1, Q23, V28.4S
    AESMC  V27.16B, V29.16B
    AESIMC  V10.16B, V27.16B
    SHA256H  Q1, Q22, V13.4S
    SHA1H  S16, S27
    SHA1SU0  V24.4S, V30.4S, V10.4S
    SHA256SU1  V24.4S, V7.4S, V23.4S
    AESIMC  V25.16B, V8.16B
    SHA256SU0  V31.4S, V16.4S
    SHA1H  S9, S1
    SHA1SU0  V3.4S, V20.4S, V21.4S
    SHA1SU0  V11.4S, V21.4S, V25.4S
    AESD  V19.16B, V2.16B
    SHA1H  S9, S28
    SHA256SU1  V22.4S, V9.4S, V24.4S
    SHA1M  Q11, S11, V2.4S
    SHA256H2  Q17, Q31, V19.4S
    SHA256SU0  V6.4S, V22.4S
    SHA256SU1  V3.4S, V3.4S, V11.4S
    AESE  V4.16B, V6.16B
    SHA256H2  Q13, Q5, V8.4S
    SHA256H2  Q15, Q16, V4.4S
    SHA256H2  Q29, Q15, V10.4S
    AESMC  V2.16B, V10.16B
    SHA256H  Q28, Q17, V19.4S
    AESE  V6.16B, V26.16B
    AESD  V29.16B, V31.16B
    SHA1H  S9, S2
    SHA1H  S2, S6
    SHA1M  Q29, S5, V14.4S
    SHA256H2  Q10, Q31, V20.4S
    AESIMC  V6.16B, V13.16B
    AESD  V0.16B, V30.16B
    SHA1H  S6, S21
    SHA256SU0  V20.4S, V19.4S
    SHA1M  Q15, S9, V28.4S
TaishanSimdUnaryArithmeticP01_label_182:
    SHA1SU1  V13.4S, V19.4S
    AESE  V22.16B, V9.16B
    SHA1SU1  V15.4S, V19.4S
    SHA1C  Q30, S16, V28.4S
    AESIMC  V9.16B, V30.16B
    SHA1H  S11, S30
    SHA1SU0  V4.4S, V20.4S, V25.4S
    SHA256H2  Q18, Q2, V29.4S
    SHA1P  Q6, S27, V3.4S
    AESMC  V5.16B, V13.16B
    AESMC  V27.16B, V20.16B
    SHA1C  Q16, S28, V6.4S
    SHA1H  S0, S25
    SHA256H  Q9, Q30, V28.4S
    SHA256SU1  V29.4S, V0.4S, V24.4S
    SHA1P  Q13, S21, V19.4S
    SHA1C  Q10, S13, V25.4S
    AESD  V10.16B, V24.16B
    SHA1SU0  V2.4S, V27.4S, V14.4S
    SHA1SU0  V15.4S, V3.4S, V4.4S
    AESIMC  V24.16B, V25.16B
    SHA1H  S27, S19
    SHA256H  Q10, Q11, V30.4S
    SHA1M  Q25, S5, V24.4S
    SHA256H2  Q17, Q31, V20.4S
    SHA1H  S1, S25
    SHA256SU0  V9.4S, V8.4S
    SHA1SU1  V10.4S, V28.4S
    SHA1SU1  V5.4S, V28.4S
    AESIMC  V10.16B, V21.16B
    AESE  V11.16B, V2.16B
    AESD  V0.16B, V18.16B
    SHA1M  Q3, S19, V18.4S
    AESE  V24.16B, V23.16B
    SHA1SU0  V19.4S, V8.4S, V2.4S
    SHA1P  Q8, S3, V8.4S
    SHA1C  Q28, S30, V11.4S
    SHA256H2  Q1, Q8, V13.4S
    SHA1SU0  V30.4S, V24.4S, V22.4S
    AESIMC  V15.16B, V13.16B
    SHA256SU1  V27.4S, V13.4S, V28.4S
    SHA256H2  Q6, Q4, V27.4S
    SHA1H  S11, S31
    SHA256SU1  V8.4S, V7.4S, V17.4S
    SHA1P  Q22, S4, V27.4S
    SHA1SU1  V7.4S, V14.4S
    SHA256H2  Q28, Q30, V18.4S
    SHA1M  Q2, S8, V24.4S
    AESD  V9.16B, V3.16B
    AESD  V0.16B, V24.16B
    SHA1C  Q26, S19, V1.4S
    SHA1M  Q2, S27, V30.4S
    SHA1P  Q4, S13, V22.4S
    SHA256SU0  V19.4S, V16.4S
    SHA1H  S11, S14
    AESD  V5.16B, V19.16B
    SHA1SU1  V14.4S, V20.4S
    SHA1C  Q30, S28, V18.4S
    AESIMC  V20.16B, V30.16B
    AESD  V25.16B, V22.16B
    AESE  V0.16B, V1.16B
    SHA256H2  Q26, Q9, V1.4S
    SHA1SU1  V20.4S, V22.4S
    SHA1SU1  V0.4S, V18.4S
    SHA1C  Q1, S20, V15.4S
    SHA256SU1  V27.4S, V3.4S, V19.4S
    SHA1SU1  V11.4S, V30.4S
    SHA256H2  Q19, Q21, V19.4S
    SHA256SU1  V17.4S, V0.4S, V24.4S
    AESIMC  V8.16B, V8.16B
    SHA256H  Q14, Q3, V21.4S
    AESMC  V27.16B, V18.16B
    SHA1C  Q1, S19, V20.4S
    SHA1SU0  V19.4S, V17.4S, V0.4S
    SHA1SU1  V11.4S, V8.4S
    SHA1C  Q1, S26, V11.4S
    SHA1P  Q26, S28, V11.4S
    SHA256H2  Q3, Q1, V23.4S
    AESD  V25.16B, V8.16B
    SHA256SU0  V7.4S, V14.4S
    SHA256SU0  V7.4S, V27.4S
    AESIMC  V4.16B, V19.16B
    SHA1SU1  V20.4S, V11.4S
    SHA1H  S30, S26
    SHA256SU1  V9.4S, V2.4S, V23.4S
    SHA1M  Q23, S27, V7.4S
    AESE  V18.16B, V11.16B
    SHA1C  Q26, S31, V26.4S
    SHA1SU0  V30.4S, V28.4S, V8.4S
    SHA256H  Q4, Q20, V25.4S
    AESIMC  V10.16B, V23.16B
    SHA1P  Q28, S5, V19.4S
    SHA256H  Q17, Q28, V26.4S
    SHA1SU0  V0.4S, V1.4S, V16.4S
    SHA256H  Q3, Q1, V15.4S
    SHA256SU1  V14.4S, V3.4S, V8.4S
    SHA1SU1  V21.4S, V4.4S
    SHA1SU1  V31.4S, V30.4S
    SHA1H  S13, S29
    SHA1H  S30, S11
    SHA256H2  Q27, Q10, V2.4S
    SHA1SU0  V9.4S, V30.4S, V25.4S
    AESIMC  V23.16B, V30.16B
    AESMC  V3.16B, V23.16B
    SHA1C  Q21, S24, V18.4S
    SHA1SU0  V3.4S, V22.4S, V21.4S
    SHA1SU1  V25.4S, V26.4S
    AESIMC  V22.16B, V8.16B
    SHA256SU0  V3.4S, V10.4S
    SHA256SU1  V31.4S, V3.4S, V2.4S
    AESIMC  V18.16B, V22.16B
    AESMC  V6.16B, V10.16B
    AESMC  V19.16B, V31.16B
    AESE  V4.16B, V28.16B
    SHA1C  Q10, S26, V20.4S
    SHA1C  Q16, S20, V10.4S
    SHA1SU1  V12.4S, V31.4S
    SHA256SU0  V30.4S, V25.4S
    AESD  V20.16B, V0.16B
    SHA1C  Q7, S5, V23.4S
    AESMC  V13.16B, V7.16B
    SHA1H  S23, S28
    AESE  V25.16B, V0.16B
    SHA1SU0  V0.4S, V25.4S, V8.4S
    SHA1SU0  V2.4S, V23.4S, V28.4S
    SHA1P  Q0, S20, V27.4S
    AESMC  V0.16B, V8.16B
    SHA1P  Q11, S6, V21.4S
    AESIMC  V23.16B, V0.16B
    SHA1M  Q30, S16, V9.4S
    SHA256H  Q0, Q14, V31.4S
    SHA1M  Q0, S20, V22.4S
    SHA256SU1  V3.4S, V7.4S, V5.4S
    SHA1P  Q24, S22, V14.4S
    SHA256H2  Q18, Q25, V26.4S
    SHA1M  Q15, S3, V2.4S
    SHA1P  Q10, S14, V20.4S
    AESE  V28.16B, V6.16B
    SHA256SU1  V22.4S, V26.4S, V10.4S
    AESE  V24.16B, V2.16B
    SHA256H  Q9, Q13, V0.4S
    AESIMC  V14.16B, V31.16B
    SHA1M  Q14, S10, V4.4S
    AESE  V2.16B, V16.16B
    SHA1C  Q20, S23, V25.4S
    AESIMC  V15.16B, V18.16B
    SHA256H  Q15, Q22, V5.4S
    SHA1C  Q29, S3, V28.4S
    SHA256SU1  V9.4S, V18.4S, V29.4S
    AESMC  V6.16B, V9.16B
    SHA1SU0  V21.4S, V26.4S, V14.4S
    SHA1SU1  V14.4S, V11.4S
    SHA1SU1  V15.4S, V18.4S
    SHA1M  Q8, S26, V3.4S
    SHA256SU0  V9.4S, V20.4S
    SHA1H  S23, S4
    SHA1SU0  V1.4S, V23.4S, V31.4S
    AESD  V0.16B, V3.16B
    AESIMC  V11.16B, V12.16B
    AESIMC  V28.16B, V14.16B
    SUBS  X18, X18, #0x1
    B.NE  TaishanSimdUnaryArithmeticP01_label_1066
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X3
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X2, X18, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X5
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X15, X2, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X17, X11, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X11
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X17, X28, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X14
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X17
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X23, X27, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X12, X24, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X19, X5, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X24, #0x2b78, LSL #0
    MOVK  X24, #0x7bc1, LSL #16
    MOVK  X24, #0x69d6, LSL #32
    MOVK  X24, #0x2475, LSL #48
    SUB  X5, X24, X14
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D2
    MOVZ  X24, #0xa307, LSL #0
    MOVK  X24, #0x540e, LSL #16
    MOVK  X24, #0x2efa, LSL #32
    MOVK  X24, #0x9804, LSL #48
    SUB  X5, X24, X14
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, V3.D[1]
    MOVZ  X19, #0x4fab, LSL #0
    MOVK  X19, #0x6865, LSL #16
    MOVK  X19, #0xeb9d, LSL #32
    MOVK  X19, #0xacbe, LSL #48
    SUB  X25, X19, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, D3
    MOVZ  X19, #0xa9e8, LSL #0
    MOVK  X19, #0x3bcb, LSL #16
    MOVK  X19, #0xecd3, LSL #32
    MOVK  X19, #0x569c, LSL #48
    SUB  X25, X19, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X8, #0x9d29, LSL #0
    MOVK  X8, #0xc887, LSL #16
    MOVK  X8, #0x461f, LSL #32
    MOVK  X8, #0x8565, LSL #48
    SUB  X28, X8, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, D4
    MOVZ  X8, #0x120d, LSL #0
    MOVK  X8, #0x75d4, LSL #16
    MOVK  X8, #0xd0a7, LSL #32
    MOVK  X8, #0xe4a9, LSL #48
    SUB  X28, X8, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X3, #0x401d, LSL #0
    MOVK  X3, #0x277e, LSL #16
    MOVK  X3, #0xc0c0, LSL #32
    MOVK  X3, #0xce69, LSL #48
    SUB  X16, X3, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, D5
    MOVZ  X3, #0x42b3, LSL #0
    MOVK  X3, #0xa97c, LSL #16
    MOVK  X3, #0xfcec, LSL #32
    MOVK  X3, #0x9f6d, LSL #48
    SUB  X16, X3, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X7, #0xb318, LSL #0
    MOVK  X7, #0x5d0b, LSL #16
    MOVK  X7, #0x8bfb, LSL #32
    MOVK  X7, #0xaaf4, LSL #48
    SUB  X16, X7, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, D6
    MOVZ  X7, #0x783e, LSL #0
    MOVK  X7, #0x446f, LSL #16
    MOVK  X7, #0x5ce4, LSL #32
    MOVK  X7, #0x4625, LSL #48
    SUB  X16, X7, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, V7.D[1]
    MOVZ  X3, #0xf398, LSL #0
    MOVK  X3, #0x69a8, LSL #16
    MOVK  X3, #0xab0c, LSL #32
    MOVK  X3, #0x4862, LSL #48
    SUB  X6, X3, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, D7
    MOVZ  X3, #0x442a, LSL #0
    MOVK  X3, #0x384d, LSL #16
    MOVK  X3, #0xaf73, LSL #32
    MOVK  X3, #0x7bf6, LSL #48
    SUB  X6, X3, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X15, #0x1dd3, LSL #0
    MOVK  X15, #0x250c, LSL #16
    MOVK  X15, #0x774b, LSL #32
    MOVK  X15, #0xad55, LSL #48
    SUB  X11, X15, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, D8
    MOVZ  X15, #0x79c1, LSL #0
    MOVK  X15, #0x657a, LSL #16
    MOVK  X15, #0xb873, LSL #32
    MOVK  X15, #0x5bbb, LSL #48
    SUB  X11, X15, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X12, #0xf5, LSL #0
    MOVK  X12, #0xc86c, LSL #16
    MOVK  X12, #0x9a98, LSL #32
    MOVK  X12, #0x6b36, LSL #48
    SUB  X28, X12, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, D9
    MOVZ  X12, #0x2da9, LSL #0
    MOVK  X12, #0x850b, LSL #16
    MOVK  X12, #0x78b3, LSL #32
    MOVK  X12, #0x873d, LSL #48
    SUB  X28, X12, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X18, #0x5c1a, LSL #0
    MOVK  X18, #0x2108, LSL #16
    MOVK  X18, #0xd54a, LSL #32
    MOVK  X18, #0x4633, LSL #48
    SUB  X24, X18, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, D10
    MOVZ  X18, #0x5fb3, LSL #0
    MOVK  X18, #0x5bc8, LSL #16
    MOVK  X18, #0x8782, LSL #32
    MOVK  X18, #0xdcc, LSL #48
    SUB  X24, X18, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, V11.D[1]
    MOVZ  X3, #0xe39c, LSL #0
    MOVK  X3, #0x25af, LSL #16
    MOVK  X3, #0x36de, LSL #32
    MOVK  X3, #0xdeac, LSL #48
    SUB  X23, X3, X21
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, D11
    MOVZ  X3, #0xd685, LSL #0
    MOVK  X3, #0x7043, LSL #16
    MOVK  X3, #0x67ab, LSL #32
    MOVK  X3, #0x5b6d, LSL #48
    SUB  X23, X3, X21
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X24, #0x8e97, LSL #0
    MOVK  X24, #0xb955, LSL #16
    MOVK  X24, #0x838f, LSL #32
    MOVK  X24, #0x44d2, LSL #48
    SUB  X7, X24, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, D12
    MOVZ  X24, #0x8743, LSL #0
    MOVK  X24, #0xe145, LSL #16
    MOVK  X24, #0x89d2, LSL #32
    MOVK  X24, #0x5afb, LSL #48
    SUB  X7, X24, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X3, #0xefe4, LSL #0
    MOVK  X3, #0x3a9b, LSL #16
    MOVK  X3, #0xafd4, LSL #32
    MOVK  X3, #0x4dbb, LSL #48
    SUB  X8, X3, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, D13
    MOVZ  X3, #0x4ded, LSL #0
    MOVK  X3, #0x7bc, LSL #16
    MOVK  X3, #0x4c81, LSL #32
    MOVK  X3, #0x3aa6, LSL #48
    SUB  X8, X3, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X19, #0xaa76, LSL #0
    MOVK  X19, #0xc05, LSL #16
    MOVK  X19, #0x512e, LSL #32
    MOVK  X19, #0x33fb, LSL #48
    SUB  X21, X19, X2
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, D14
    MOVZ  X19, #0xb477, LSL #0
    MOVK  X19, #0x11fe, LSL #16
    MOVK  X19, #0x855c, LSL #32
    MOVK  X19, #0x4dbc, LSL #48
    SUB  X21, X19, X2
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X28, #0x89f, LSL #0
    MOVK  X28, #0x853e, LSL #16
    MOVK  X28, #0xc868, LSL #32
    MOVK  X28, #0x2c61, LSL #48
    SUB  X3, X28, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, D15
    MOVZ  X28, #0x2181, LSL #0
    MOVK  X28, #0x7aa9, LSL #16
    MOVK  X28, #0x8f07, LSL #32
    MOVK  X28, #0x3d3f, LSL #48
    SUB  X3, X28, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X2, #0xe2af, LSL #0
    MOVK  X2, #0x57a3, LSL #16
    MOVK  X2, #0xb32a, LSL #32
    MOVK  X2, #0x3651, LSL #48
    SUB  X3, X2, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D16
    MOVZ  X2, #0x88e3, LSL #0
    MOVK  X2, #0xbe5e, LSL #16
    MOVK  X2, #0xd940, LSL #32
    MOVK  X2, #0xae13, LSL #48
    SUB  X3, X2, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X15, #0xde27, LSL #0
    MOVK  X15, #0x3372, LSL #16
    MOVK  X15, #0xc141, LSL #32
    MOVK  X15, #0x4409, LSL #48
    SUB  X24, X15, X13
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, D17
    MOVZ  X15, #0xf281, LSL #0
    MOVK  X15, #0xa54, LSL #16
    MOVK  X15, #0x4cd9, LSL #32
    MOVK  X15, #0xf813, LSL #48
    SUB  X24, X15, X13
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X28, #0xf824, LSL #0
    MOVK  X28, #0xdc5d, LSL #16
    MOVK  X28, #0x3eb0, LSL #32
    MOVK  X28, #0x642c, LSL #48
    SUB  X17, X28, X16
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X16, D18
    MOVZ  X28, #0x80c2, LSL #0
    MOVK  X28, #0x824a, LSL #16
    MOVK  X28, #0x290c, LSL #32
    MOVK  X28, #0x9478, LSL #48
    SUB  X17, X28, X16
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X25, #0xc4c4, LSL #0
    MOVK  X25, #0xc251, LSL #16
    MOVK  X25, #0x7a4a, LSL #32
    MOVK  X25, #0x695b, LSL #48
    SUB  X11, X25, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, D19
    MOVZ  X25, #0x71f1, LSL #0
    MOVK  X25, #0x45d6, LSL #16
    MOVK  X25, #0x5b52, LSL #32
    MOVK  X25, #0x3a40, LSL #48
    SUB  X11, X25, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X8, #0x5b7, LSL #0
    MOVK  X8, #0x1a65, LSL #16
    MOVK  X8, #0x86ff, LSL #32
    MOVK  X8, #0x6b80, LSL #48
    SUB  X11, X8, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, D20
    MOVZ  X8, #0xdba6, LSL #0
    MOVK  X8, #0xcbd7, LSL #16
    MOVK  X8, #0x328a, LSL #32
    MOVK  X8, #0x7796, LSL #48
    SUB  X11, X8, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X23, #0x8a21, LSL #0
    MOVK  X23, #0xb1c4, LSL #16
    MOVK  X23, #0xd0d6, LSL #32
    MOVK  X23, #0x8e72, LSL #48
    SUB  X18, X23, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, D21
    MOVZ  X23, #0x8a29, LSL #0
    MOVK  X23, #0xe5b4, LSL #16
    MOVK  X23, #0x8054, LSL #32
    MOVK  X23, #0x7aea, LSL #48
    SUB  X18, X23, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, V23.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, D23
    MOVZ  X16, #0x483, LSL #0
    MOVK  X16, #0x5d75, LSL #16
    SUB  X9, X16, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X28, #0x1323, LSL #0
    MOVK  X28, #0x9537, LSL #16
    MOVK  X28, #0xb482, LSL #32
    MOVK  X28, #0x570f, LSL #48
    SUB  X25, X28, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, D24
    MOVZ  X28, #0x2604, LSL #0
    MOVK  X28, #0x3dff, LSL #16
    MOVK  X28, #0xb1e8, LSL #32
    MOVK  X28, #0x15a9, LSL #48
    SUB  X25, X28, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X21, #0x80d3, LSL #0
    MOVK  X21, #0xb778, LSL #16
    MOVK  X21, #0x127e, LSL #32
    MOVK  X21, #0x3311, LSL #48
    SUB  X29, X21, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, D25
    MOVZ  X21, #0x89a1, LSL #0
    MOVK  X21, #0xece0, LSL #16
    MOVK  X21, #0x4ec7, LSL #32
    MOVK  X21, #0xfc2, LSL #48
    SUB  X29, X21, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, V26.D[1]
    MOVZ  X16, #0xd0fd, LSL #0
    MOVK  X16, #0xf68d, LSL #16
    MOVK  X16, #0xfb59, LSL #32
    MOVK  X16, #0x7dcf, LSL #48
    SUB  X9, X16, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, D26
    MOVZ  X16, #0x3022, LSL #0
    MOVK  X16, #0x5d5b, LSL #16
    MOVK  X16, #0xa520, LSL #32
    MOVK  X16, #0xedab, LSL #48
    SUB  X9, X16, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, V27.D[1]
    MOVZ  X5, #0x1b6d, LSL #0
    MOVK  X5, #0xd3a6, LSL #16
    MOVK  X5, #0x26ab, LSL #32
    MOVK  X5, #0x173e, LSL #48
    SUB  X24, X5, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, D27
    MOVZ  X5, #0x6ac5, LSL #0
    MOVK  X5, #0x76cc, LSL #16
    MOVK  X5, #0x6f97, LSL #32
    MOVK  X5, #0x37b3, LSL #48
    SUB  X24, X5, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, V28.D[1]
    MOVZ  X25, #0x6625, LSL #0
    MOVK  X25, #0x71e7, LSL #16
    MOVK  X25, #0xf5d1, LSL #32
    MOVK  X25, #0xe271, LSL #48
    SUB  X2, X25, X13
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, D28
    MOVZ  X25, #0xd5af, LSL #0
    MOVK  X25, #0x287e, LSL #16
    MOVK  X25, #0x892b, LSL #32
    MOVK  X25, #0x119b, LSL #48
    SUB  X2, X25, X13
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, V29.D[1]
    MOVZ  X18, #0x2a18, LSL #0
    MOVK  X18, #0x9368, LSL #16
    MOVK  X18, #0xfd6d, LSL #32
    MOVK  X18, #0x8c0b, LSL #48
    SUB  X20, X18, X21
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, D29
    MOVZ  X18, #0xdf36, LSL #0
    MOVK  X18, #0x7bdd, LSL #16
    MOVK  X18, #0xe72c, LSL #32
    MOVK  X18, #0x48b4, LSL #48
    SUB  X20, X18, X21
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
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
    FMOV  D0, X12
    FMOV  V0.D[1], X29
    FMOV  D1, X4
    FMOV  V1.D[1], X24
    FMOV  D2, X6
    FMOV  V2.D[1], X5
    FMOV  D3, X4
    FMOV  V3.D[1], X15
    FMOV  D4, X15
    FMOV  V4.D[1], X15
    FMOV  D5, X28
    FMOV  V5.D[1], X27
    FMOV  D6, X2
    FMOV  V6.D[1], X3
    FMOV  D7, X17
    FMOV  V7.D[1], X12
    FMOV  D8, X7
    FMOV  V8.D[1], X29
    FMOV  D9, X29
    FMOV  V9.D[1], X26
    FMOV  D10, X20
    FMOV  V10.D[1], X16
    FMOV  D11, X11
    FMOV  V11.D[1], X28
    FMOV  D12, X3
    FMOV  V12.D[1], X14
    FMOV  D13, X24
    FMOV  V13.D[1], X6
    FMOV  D14, X23
    FMOV  V14.D[1], X18
    FMOV  D15, X4
    FMOV  V15.D[1], X21
    FMOV  D16, X18
    FMOV  V16.D[1], X15
    FMOV  D17, X19
    FMOV  V17.D[1], X19
    FMOV  D18, X9
    FMOV  V18.D[1], X18
    FMOV  D19, X6
    FMOV  V19.D[1], X23
    FMOV  D20, X25
    FMOV  V20.D[1], X16
    FMOV  D21, X3
    FMOV  V21.D[1], X3
    FMOV  D22, X12
    FMOV  V22.D[1], X24
    FMOV  D23, X8
    FMOV  V23.D[1], X15
    FMOV  D24, X13
    FMOV  V24.D[1], X24
    FMOV  D25, X6
    FMOV  V25.D[1], X24
    FMOV  D26, X25
    FMOV  V26.D[1], X24
    FMOV  D27, X14
    FMOV  V27.D[1], X15
    FMOV  D28, X29
    FMOV  V28.D[1], X8
    FMOV  D29, X11
    FMOV  V29.D[1], X12
    FMOV  D30, X18
    FMOV  V30.D[1], X25
    FMOV  D31, X3
    FMOV  V31.D[1], X17
    MOVZ  X21, #0xf, LSL #0
TaishanSimdUnaryArithmeticP01_label_1147:
    SHA1P  Q20, S27, V29.4S
    SHA256H2  Q21, Q9, V31.4S
    AESD  V25.16B, V9.16B
    SHA1H  S4, S30
    SHA256H2  Q21, Q4, V6.4S
    SHA1C  Q15, S26, V11.4S
    AESMC  V15.16B, V3.16B
    AESIMC  V21.16B, V31.16B
    SHA1P  Q22, S29, V18.4S
    SHA1H  S8, S6
    SHA1SU1  V30.4S, V27.4S
    SHA256SU0  V7.4S, V25.4S
    AESIMC  V23.16B, V2.16B
    SHA1SU1  V19.4S, V7.4S
    SHA256SU0  V19.4S, V0.4S
    SHA256H  Q16, Q26, V8.4S
    SHA1SU1  V3.4S, V30.4S
    SHA1P  Q16, S6, V9.4S
    SHA1SU0  V21.4S, V27.4S, V17.4S
    AESD  V10.16B, V6.16B
    SHA1SU1  V15.4S, V21.4S
    SHA1M  Q6, S0, V25.4S
    AESD  V19.16B, V0.16B
    AESMC  V11.16B, V4.16B
    SHA1H  S0, S11
    AESIMC  V14.16B, V4.16B
    AESMC  V10.16B, V14.16B
    AESIMC  V7.16B, V28.16B
    SHA1SU0  V10.4S, V15.4S, V16.4S
    SHA256SU0  V20.4S, V15.4S
    SHA1H  S23, S29
    SHA1SU0  V6.4S, V26.4S, V10.4S
    SHA256SU0  V23.4S, V17.4S
    SHA1SU1  V31.4S, V28.4S
    SHA1M  Q20, S20, V9.4S
    SHA1P  Q21, S14, V0.4S
    SHA256SU0  V19.4S, V18.4S
    SHA256H  Q27, Q22, V21.4S
    SHA256H  Q18, Q27, V8.4S
    SHA256SU1  V13.4S, V22.4S, V7.4S
    SHA1SU1  V23.4S, V5.4S
    SHA256H  Q27, Q3, V15.4S
    AESD  V26.16B, V4.16B
    SHA1SU1  V11.4S, V6.4S
    SHA1SU1  V31.4S, V16.4S
    SHA256H2  Q23, Q17, V17.4S
    AESD  V9.16B, V6.16B
    SHA1M  Q6, S18, V21.4S
    SHA1SU0  V2.4S, V5.4S, V24.4S
    SHA1SU1  V23.4S, V30.4S
    SHA1H  S21, S7
    SHA1SU1  V26.4S, V18.4S
    SHA256SU1  V26.4S, V19.4S, V16.4S
    AESE  V31.16B, V26.16B
    SHA1SU1  V13.4S, V4.4S
    AESE  V17.16B, V8.16B
    SHA256SU0  V5.4S, V19.4S
    SHA1P  Q17, S5, V20.4S
    SHA1SU1  V25.4S, V10.4S
    SHA256SU0  V3.4S, V3.4S
    SHA1H  S31, S24
    SHA1H  S23, S27
    AESE  V16.16B, V18.16B
    SHA1H  S10, S30
    SHA256SU1  V13.4S, V12.4S, V15.4S
    SHA256H2  Q14, Q7, V13.4S
    AESE  V29.16B, V16.16B
    AESMC  V16.16B, V25.16B
    SHA1SU0  V18.4S, V7.4S, V2.4S
    SHA1H  S2, S29
    SHA1M  Q13, S16, V3.4S
    SHA256SU1  V15.4S, V9.4S, V4.4S
    SHA1H  S25, S17
    SHA256SU1  V9.4S, V23.4S, V4.4S
    AESIMC  V30.16B, V20.16B
    SHA256H2  Q30, Q18, V25.4S
    SHA1H  S30, S28
    SHA1P  Q9, S18, V29.4S
    SHA1SU0  V18.4S, V12.4S, V18.4S
    SHA256SU0  V4.4S, V12.4S
    AESE  V21.16B, V16.16B
    SHA1P  Q14, S13, V16.4S
    SHA256H  Q30, Q25, V30.4S
    AESD  V2.16B, V2.16B
    AESIMC  V3.16B, V23.16B
    SHA1SU0  V24.4S, V5.4S, V21.4S
    SHA1M  Q2, S2, V19.4S
    SHA256SU1  V2.4S, V14.4S, V18.4S
    SHA1M  Q14, S8, V13.4S
    SHA256SU0  V18.4S, V11.4S
    AESD  V5.16B, V2.16B
    SHA256H  Q9, Q7, V27.4S
    SHA256SU0  V4.4S, V9.4S
    SHA256H  Q20, Q21, V4.4S
    SHA1M  Q7, S20, V28.4S
    SHA256H2  Q15, Q20, V18.4S
    SHA1M  Q26, S3, V2.4S
    SHA1C  Q9, S12, V2.4S
    SHA1SU1  V8.4S, V29.4S
    SHA1H  S27, S28
    SHA1SU1  V17.4S, V21.4S
    AESD  V4.16B, V24.16B
    SHA256SU0  V4.4S, V10.4S
    AESE  V27.16B, V24.16B
    AESIMC  V5.16B, V18.16B
    SHA256H2  Q17, Q22, V16.4S
    AESMC  V28.16B, V16.16B
    SHA1M  Q10, S9, V19.4S
    SHA1H  S15, S5
    SHA1SU1  V18.4S, V30.4S
    SHA1P  Q10, S0, V15.4S
    AESD  V16.16B, V30.16B
    SHA1C  Q30, S29, V27.4S
    SHA1C  Q25, S8, V12.4S
    SHA1C  Q21, S29, V8.4S
    SHA256SU1  V8.4S, V24.4S, V8.4S
    SHA1P  Q19, S2, V7.4S
    AESD  V22.16B, V20.16B
    SHA1SU0  V27.4S, V5.4S, V11.4S
    SHA1SU0  V26.4S, V15.4S, V24.4S
    AESD  V22.16B, V12.16B
    SHA256SU0  V5.4S, V15.4S
    SHA256SU0  V21.4S, V12.4S
    AESMC  V22.16B, V21.16B
    AESIMC  V10.16B, V11.16B
    AESE  V5.16B, V7.16B
    AESD  V28.16B, V15.16B
    SHA1SU0  V4.4S, V0.4S, V18.4S
    SHA1P  Q3, S1, V0.4S
    SHA1H  S24, S29
    AESD  V17.16B, V16.16B
    SHA256H2  Q4, Q19, V12.4S
    SHA1H  S15, S21
    AESIMC  V29.16B, V0.16B
    SHA1SU0  V3.4S, V20.4S, V27.4S
    AESMC  V28.16B, V5.16B
    AESMC  V19.16B, V25.16B
    SHA1H  S9, S2
    SHA1SU0  V11.4S, V17.4S, V22.4S
    AESIMC  V26.16B, V17.16B
    SHA1M  Q16, S17, V29.4S
    SHA1P  Q5, S12, V31.4S
    SHA1C  Q6, S27, V12.4S
    AESD  V22.16B, V9.16B
    AESMC  V6.16B, V12.16B
    SHA256SU1  V23.4S, V21.4S, V30.4S
    AESE  V7.16B, V0.16B
    AESMC  V29.16B, V12.16B
    SHA1P  Q4, S22, V21.4S
    SHA256SU1  V22.4S, V10.4S, V20.4S
    SHA1SU0  V10.4S, V0.4S, V2.4S
    AESMC  V20.16B, V26.16B
    SHA256H2  Q19, Q4, V4.4S
    SHA1C  Q18, S16, V19.4S
    AESD  V27.16B, V22.16B
    SHA1M  Q22, S16, V10.4S
    AESIMC  V16.16B, V23.16B
    SHA1H  S1, S23
    SHA256H  Q9, Q31, V27.4S
    SHA256H2  Q13, Q17, V22.4S
    SHA256SU1  V23.4S, V29.4S, V25.4S
    SHA256H  Q16, Q1, V3.4S
    AESMC  V7.16B, V5.16B
    SHA1C  Q23, S23, V4.4S
    SHA1H  S2, S9
    SHA1SU1  V29.4S, V15.4S
    SHA1C  Q9, S15, V6.4S
    SHA1C  Q13, S8, V13.4S
    SHA256SU1  V17.4S, V4.4S, V11.4S
    SHA1SU0  V20.4S, V26.4S, V30.4S
    AESIMC  V8.16B, V13.16B
    AESE  V28.16B, V21.16B
    SHA256SU0  V2.4S, V28.4S
    SHA1C  Q22, S0, V1.4S
    SHA1SU0  V9.4S, V0.4S, V17.4S
    SHA256SU1  V11.4S, V13.4S, V27.4S
    AESMC  V24.16B, V30.16B
    SHA256SU0  V8.4S, V12.4S
    SHA256SU1  V18.4S, V15.4S, V3.4S
    SHA1C  Q18, S20, V21.4S
    AESMC  V4.16B, V0.16B
    SHA256SU0  V28.4S, V18.4S
    SHA256H2  Q0, Q27, V21.4S
    SHA1M  Q25, S30, V8.4S
    SHA1M  Q16, S17, V10.4S
    SHA1H  S29, S9
    AESE  V26.16B, V0.16B
    AESIMC  V26.16B, V6.16B
    SHA1H  S23, S20
    SHA1C  Q25, S29, V18.4S
    SHA1P  Q17, S13, V9.4S
    SHA1M  Q5, S28, V23.4S
    SHA256SU0  V11.4S, V9.4S
    AESMC  V30.16B, V19.16B
    SHA1SU1  V12.4S, V4.4S
    SHA256H2  Q4, Q20, V27.4S
    SHA256SU0  V6.4S, V1.4S
    SHA256H  Q20, Q31, V7.4S
    AESMC  V16.16B, V25.16B
    SHA256H  Q3, Q3, V4.4S
    SUBS  X21, X21, #0x1
    B.NE  TaishanSimdUnaryArithmeticP01_label_1147
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X9, X13, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X13, X5, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X4, X29, X4
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X15, X13, X5
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X21, X19, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X28, X26, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X27, X18, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X9
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X26, X15, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X11, X2, X11
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X25, X17, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X11, X27, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X7, X29, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X29, X28, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X2, X26, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X29, X13, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X14, X5, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X20, X21, X20
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X15, X23, X21
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
TaishanSimdUnaryArithmeticP01_label_995:
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X28, X19, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X12, X29, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X7, X29, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X15, X20, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X8, X11, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X23, X20, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xf37a, LSL #32
    MOVK  X8, #0x4769, LSL #48
    SUB  X9, X8, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, D2
    MOVZ  X8, #0xbb0a, LSL #0
    MOVK  X8, #0x6679, LSL #16
    SUB  X9, X8, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X11, #0x1128, LSL #0
    MOVK  X11, #0xe220, LSL #16
    MOVK  X11, #0x4b6b, LSL #32
    MOVK  X11, #0xfa7f, LSL #48
    SUB  X14, X11, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, D3
    MOVZ  X11, #0xb4f1, LSL #0
    MOVK  X11, #0x8758, LSL #16
    MOVK  X11, #0xa01c, LSL #32
    MOVK  X11, #0x4008, LSL #48
    SUB  X14, X11, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X3, #0x146d, LSL #0
    MOVK  X3, #0x2906, LSL #16
    MOVK  X3, #0xbfb6, LSL #32
    MOVK  X3, #0x24ca, LSL #48
    SUB  X15, X3, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, D4
    MOVZ  X3, #0xa004, LSL #0
    MOVK  X3, #0x43f8, LSL #16
    MOVK  X3, #0xb99c, LSL #32
    MOVK  X3, #0xbd03, LSL #48
    SUB  X15, X3, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X15, #0x3ddf, LSL #0
    MOVK  X15, #0x7e74, LSL #16
    MOVK  X15, #0x76a7, LSL #32
    MOVK  X15, #0xcea9, LSL #48
    SUB  X28, X15, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, D5
    MOVZ  X15, #0x5fff, LSL #0
    MOVK  X15, #0x5464, LSL #16
    MOVK  X15, #0x6eb6, LSL #32
    MOVK  X15, #0x3472, LSL #48
    SUB  X28, X15, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, V6.D[1]
    MOVZ  X13, #0xfffe, LSL #0
    MOVK  X13, #0x1fff, LSL #16
    MOVK  X13, #0x56a, LSL #32
    MOVK  X13, #0x69cf, LSL #48
    SUB  X4, X13, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, D6
    MOVZ  X13, #0xfffe, LSL #0
    MOVK  X13, #0x1fff, LSL #16
    MOVK  X13, #0xfffe, LSL #32
    MOVK  X13, #0x1fff, LSL #48
    SUB  X4, X13, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X24, #0x7cfb, LSL #0
    MOVK  X24, #0xd87, LSL #16
    MOVK  X24, #0xaaa5, LSL #32
    MOVK  X24, #0x6d5b, LSL #48
    SUB  X17, X24, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, D7
    MOVZ  X24, #0x84e, LSL #0
    MOVK  X24, #0xdbcd, LSL #16
    MOVK  X24, #0x32c1, LSL #32
    MOVK  X24, #0xe685, LSL #48
    SUB  X17, X24, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X10, #0xe54, LSL #0
    MOVK  X10, #0xfb85, LSL #16
    MOVK  X10, #0xeb89, LSL #32
    MOVK  X10, #0x669d, LSL #48
    SUB  X26, X10, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, D8
    MOVZ  X10, #0x91ce, LSL #0
    MOVK  X10, #0x7e88, LSL #16
    MOVK  X10, #0x4f0f, LSL #32
    MOVK  X10, #0x8f9, LSL #48
    SUB  X26, X10, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, V9.D[1]
    MOVZ  X23, #0x8168, LSL #0
    MOVK  X23, #0x6282, LSL #16
    MOVK  X23, #0xb117, LSL #32
    MOVK  X23, #0x2332, LSL #48
    SUB  X27, X23, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, D9
    MOVZ  X23, #0x5172, LSL #0
    MOVK  X23, #0x30bb, LSL #16
    MOVK  X23, #0xce55, LSL #32
    MOVK  X23, #0x7578, LSL #48
    SUB  X27, X23, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X25, #0x7f62, LSL #0
    MOVK  X25, #0x8ce8, LSL #16
    MOVK  X25, #0x1f4c, LSL #32
    MOVK  X25, #0x961c, LSL #48
    SUB  X21, X25, X9
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, D10
    MOVZ  X25, #0xf5df, LSL #0
    MOVK  X25, #0xe97c, LSL #16
    MOVK  X25, #0xb451, LSL #32
    MOVK  X25, #0x697a, LSL #48
    SUB  X21, X25, X9
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, V11.D[1]
    MOVZ  X29, #0x41dd, LSL #0
    MOVK  X29, #0x71bb, LSL #16
    MOVK  X29, #0xb38a, LSL #32
    MOVK  X29, #0xade7, LSL #48
    SUB  X10, X29, X3
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, D11
    MOVZ  X29, #0xd7ad, LSL #0
    MOVK  X29, #0x67e, LSL #16
    MOVK  X29, #0x2836, LSL #32
    MOVK  X29, #0x9a68, LSL #48
    SUB  X10, X29, X3
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, V12.D[1]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    SUB  X27, X2, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, D12
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X27, X2, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, V13.D[1]
    MOVZ  X10, #0x71f8, LSL #0
    MOVK  X10, #0xf988, LSL #16
    MOVK  X10, #0xbdf2, LSL #32
TaishanSimdUnaryArithmeticP01_label_9:
    MOVK  X10, #0x7f8a, LSL #48
    SUB  X5, X10, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, D13
    MOVZ  X10, #0x76f7, LSL #0
    MOVK  X10, #0xf418, LSL #16
    MOVK  X10, #0x2d8a, LSL #32
    MOVK  X10, #0x1b95, LSL #48
    SUB  X5, X10, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, V14.D[1]
    MOVZ  X3, #0xc0bc, LSL #0
    MOVK  X3, #0xf590, LSL #16
    MOVK  X3, #0x5b5f, LSL #32
    MOVK  X3, #0x2a8e, LSL #48
    SUB  X2, X3, X21
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, D14
    MOVZ  X3, #0x1517, LSL #0
    MOVK  X3, #0x1303, LSL #16
    MOVK  X3, #0xf7a6, LSL #32
    MOVK  X3, #0x7039, LSL #48
    SUB  X2, X3, X21
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D15
    MOVZ  X25, #0x4fee, LSL #0
    MOVK  X25, #0xf3d, LSL #16
    SUB  X28, X25, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X13, #0x6af8, LSL #0
    MOVK  X13, #0xb6ad, LSL #16
    MOVK  X13, #0xa942, LSL #32
    MOVK  X13, #0x5f5f, LSL #48
    SUB  X18, X13, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, D16
    MOVZ  X13, #0xfd33, LSL #0
    MOVK  X13, #0x163e, LSL #16
    MOVK  X13, #0xb788, LSL #32
    MOVK  X13, #0x140a, LSL #48
    SUB  X18, X13, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X24, #0x6360, LSL #0
    MOVK  X24, #0x5a48, LSL #16
    MOVK  X24, #0xd807, LSL #32
    MOVK  X24, #0x2dbb, LSL #48
    SUB  X28, X24, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, D17
    MOVZ  X24, #0xb47c, LSL #0
    MOVK  X24, #0xb5aa, LSL #16
    MOVK  X24, #0x1af6, LSL #32
    MOVK  X24, #0x8add, LSL #48
    SUB  X28, X24, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X6, #0x4d38, LSL #0
    MOVK  X6, #0x4771, LSL #16
    MOVK  X6, #0xd4c5, LSL #32
    MOVK  X6, #0xa7d4, LSL #48
    SUB  X14, X6, X4
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, D18
    MOVZ  X6, #0x211f, LSL #0
    MOVK  X6, #0x3d09, LSL #16
    MOVK  X6, #0x2d33, LSL #32
    MOVK  X6, #0xde48, LSL #48
    SUB  X14, X6, X4
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X28, #0xe59b, LSL #0
    MOVK  X28, #0xa6fa, LSL #16
    MOVK  X28, #0x42e6, LSL #32
    MOVK  X28, #0x982f, LSL #48
    SUB  X27, X28, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, D19
    MOVZ  X28, #0xc6bc, LSL #0
    MOVK  X28, #0xe993, LSL #16
    MOVK  X28, #0x725c, LSL #32
    MOVK  X28, #0x991c, LSL #48
    SUB  X27, X28, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, V20.D[1]
    MOVZ  X9, #0xe832, LSL #0
    MOVK  X9, #0x8039, LSL #16
    MOVK  X9, #0xfa43, LSL #32
    MOVK  X9, #0xe1e1, LSL #48
    SUB  X29, X9, X19
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, D20
    MOVZ  X9, #0xa730, LSL #0
    MOVK  X9, #0xdcc2, LSL #16
    MOVK  X9, #0x61c, LSL #32
    MOVK  X9, #0x91f5, LSL #48
    SUB  X29, X9, X19
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X17, #0x771f, LSL #0
    MOVK  X17, #0x6fd0, LSL #16
    MOVK  X17, #0xf9ab, LSL #32
    MOVK  X17, #0x59c9, LSL #48
    SUB  X8, X17, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, D21
    MOVZ  X17, #0x3fb8, LSL #0
    MOVK  X17, #0x3cf5, LSL #16
    MOVK  X17, #0xabc0, LSL #32
    MOVK  X17, #0xee30, LSL #48
    SUB  X8, X17, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X9, X19, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, D23
    MOVZ  X19, #0x4002, LSL #0
    MOVK  X19, #0xd0c6, LSL #16
TaishanSimdUnaryArithmeticP01_label_701:
    SUB  X9, X19, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X21, #0x3ee9, LSL #0
    MOVK  X21, #0xd9e7, LSL #16
    MOVK  X21, #0x1a32, LSL #32
    MOVK  X21, #0x3c4e, LSL #48
    SUB  X4, X21, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D24
    MOVZ  X21, #0x9179, LSL #0
    MOVK  X21, #0xe4d5, LSL #16
    MOVK  X21, #0xcfdd, LSL #32
    MOVK  X21, #0xd457, LSL #48
    SUB  X4, X21, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X5, #0xf25, LSL #0
    MOVK  X5, #0xda79, LSL #16
TaishanSimdUnaryArithmeticP01_label_295:
    MOVK  X5, #0x5909, LSL #32
    MOVK  X5, #0x62d9, LSL #48
    SUB  X24, X5, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, D25
    MOVZ  X5, #0x7617, LSL #0
    MOVK  X5, #0x4acd, LSL #16
    MOVK  X5, #0x5efa, LSL #32
    MOVK  X5, #0xbf3a, LSL #48
    SUB  X24, X5, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X7, X2, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, D26
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X7, X2, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X7, #0xe684, LSL #0
    MOVK  X7, #0xed19, LSL #16
    MOVK  X7, #0xfcdf, LSL #32
    MOVK  X7, #0xa49f, LSL #48
    SUB  X6, X7, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, D27
    MOVZ  X7, #0xc42f, LSL #0
    MOVK  X7, #0xa06a, LSL #16
    MOVK  X7, #0x3e2, LSL #32
    MOVK  X7, #0x167a, LSL #48
    SUB  X6, X7, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, V28.D[1]
    MOVZ  X19, #0x1721, LSL #0
    MOVK  X19, #0x25d2, LSL #16
    MOVK  X19, #0x4eb, LSL #32
    MOVK  X19, #0xa92, LSL #48
    SUB  X17, X19, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, D28
    MOVZ  X19, #0xcc90, LSL #0
    MOVK  X19, #0x9937, LSL #16
    MOVK  X19, #0x4a4c, LSL #32
    MOVK  X19, #0x7d64, LSL #48
    SUB  X17, X19, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, V29.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, D29
    MOVZ  X13, #0xd45c, LSL #0
    MOVK  X13, #0x8c2e, LSL #16
    SUB  X2, X13, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X2, #0xba7c, LSL #0
    MOVK  X2, #0x3065, LSL #16
    MOVK  X2, #0x359b, LSL #32
    MOVK  X2, #0xcc80, LSL #48
    MOVZ  X3, #0x3d5c, LSL #0
    MOVK  X3, #0x1ae6, LSL #16
    MOVK  X3, #0x7e53, LSL #32
    MOVK  X3, #0xe6e2, LSL #48
    MOVZ  X4, #0x94d8, LSL #0
    MOVK  X4, #0xff41, LSL #16
    MOVK  X4, #0xdb76, LSL #32
    MOVK  X4, #0xead9, LSL #48
    MOVZ  X5, #0x3c1c, LSL #0
    MOVK  X5, #0x23d5, LSL #16
    MOVK  X5, #0x1245, LSL #32
    MOVK  X5, #0xae8, LSL #48
    MOVZ  X6, #0xae2b, LSL #0
    MOVK  X6, #0x2b0f, LSL #16
    MOVK  X6, #0x72bb, LSL #32
    MOVK  X6, #0x22cc, LSL #48
    MOVZ  X7, #0x4abc, LSL #0
    MOVK  X7, #0x76fa, LSL #16
    MOVK  X7, #0x6be6, LSL #32
    MOVK  X7, #0x3dd8, LSL #48
    MOVZ  X8, #0xcd37, LSL #0
    MOVK  X8, #0xc6f1, LSL #16
    MOVK  X8, #0x3a26, LSL #32
    MOVK  X8, #0x702d, LSL #48
    MOVZ  X9, #0x94a5, LSL #0
    MOVK  X9, #0x7c9d, LSL #16
    MOVK  X9, #0xcd3, LSL #32
    MOVK  X9, #0xfeab, LSL #48
    MOVZ  X10, #0x5b9, LSL #0
    MOVK  X10, #0x8b99, LSL #16
    MOVK  X10, #0x964a, LSL #32
    MOVK  X10, #0x7450, LSL #48
    MOVZ  X11, #0x38f7, LSL #0
    MOVK  X11, #0x8fb2, LSL #16
    MOVK  X11, #0xb168, LSL #32
    MOVK  X11, #0x29f8, LSL #48
    MOVZ  X12, #0x367b, LSL #0
    MOVK  X12, #0xd594, LSL #16
    MOVK  X12, #0xf744, LSL #32
    MOVK  X12, #0x3032, LSL #48
    MOVZ  X13, #0xc881, LSL #0
    MOVK  X13, #0xc1e5, LSL #16
    MOVK  X13, #0xe069, LSL #32
    MOVK  X13, #0xede1, LSL #48
    MOVZ  X14, #0x5a47, LSL #0
    MOVK  X14, #0xcd56, LSL #16
    MOVK  X14, #0x7926, LSL #32
    MOVK  X14, #0x8848, LSL #48
    MOVZ  X15, #0xaab8, LSL #0
    MOVK  X15, #0xd731, LSL #16
    MOVK  X15, #0x6a09, LSL #32
    MOVK  X15, #0x1207, LSL #48
    MOVZ  X16, #0xdc07, LSL #0
    MOVK  X16, #0x301d, LSL #16
    MOVK  X16, #0xcc0d, LSL #32
    MOVK  X16, #0x9b6d, LSL #48
    MOVZ  X17, #0xadc, LSL #0
    MOVK  X17, #0x6502, LSL #16
    MOVK  X17, #0xf202, LSL #32
    MOVK  X17, #0xccf1, LSL #48
    MOVZ  X18, #0x8fcf, LSL #0
    MOVK  X18, #0x7315, LSL #16
    MOVK  X18, #0x5283, LSL #32
    MOVK  X18, #0x6ac8, LSL #48
    MOVZ  X19, #0xda82, LSL #0
    MOVK  X19, #0xce49, LSL #16
    MOVK  X19, #0xf835, LSL #32
    MOVK  X19, #0xe46c, LSL #48
    MOVZ  X20, #0x1c6d, LSL #0
    MOVK  X20, #0x962b, LSL #16
    MOVK  X20, #0xfda6, LSL #32
    MOVK  X20, #0x7a8a, LSL #48
    MOVZ  X21, #0x920, LSL #0
    MOVK  X21, #0xcde6, LSL #16
    MOVK  X21, #0x10ad, LSL #32
    MOVK  X21, #0x1d67, LSL #48
    MOVZ  X23, #0x6a11, LSL #0
    MOVK  X23, #0x420b, LSL #16
    MOVK  X23, #0x923e, LSL #32
    MOVK  X23, #0x997, LSL #48
    MOVZ  X24, #0xc959, LSL #0
    MOVK  X24, #0x7b30, LSL #16
    MOVK  X24, #0x228d, LSL #32
    MOVK  X24, #0x1b9e, LSL #48
    MOVZ  X25, #0xde82, LSL #0
    MOVK  X25, #0xefd4, LSL #16
    MOVK  X25, #0xb6e, LSL #32
    MOVK  X25, #0x219, LSL #48
    MOVZ  X26, #0x47f0, LSL #0
    MOVK  X26, #0xda70, LSL #16
    MOVK  X26, #0x8db6, LSL #32
    MOVK  X26, #0xdc20, LSL #48
    MOVZ  X27, #0xe299, LSL #0
    MOVK  X27, #0x33af, LSL #16
    MOVK  X27, #0x9f26, LSL #32
    MOVK  X27, #0xf47e, LSL #48
    MOVZ  X28, #0xac37, LSL #0
    MOVK  X28, #0xb907, LSL #16
    MOVK  X28, #0xe7f5, LSL #32
    MOVK  X28, #0x7114, LSL #48
    MOVZ  X29, #0xd418, LSL #0
    MOVK  X29, #0x6518, LSL #16
    MOVK  X29, #0x5eb8, LSL #32
    MOVK  X29, #0x423e, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X23
    FMOV  D1, X11
    FMOV  V1.D[1], X11
    FMOV  D2, X6
    FMOV  V2.D[1], X25
    FMOV  D3, X10
    FMOV  V3.D[1], X5
    FMOV  D4, X20
    FMOV  V4.D[1], X27
    FMOV  D5, X8
    FMOV  V5.D[1], X28
    FMOV  D6, X9
    FMOV  V6.D[1], X11
    FMOV  D7, X28
    FMOV  V7.D[1], X27
    FMOV  D8, X17
    FMOV  V8.D[1], X3
    FMOV  D9, X27
    FMOV  V9.D[1], X13
    FMOV  D10, X11
    FMOV  V10.D[1], X19
    FMOV  D11, X8
    FMOV  V11.D[1], X12
    FMOV  D12, X26
    FMOV  V12.D[1], X11
    FMOV  D13, X14
    FMOV  V13.D[1], X2
    FMOV  D14, X7
    FMOV  V14.D[1], X11
    FMOV  D15, X23
    FMOV  V15.D[1], X27
    FMOV  D16, X11
    FMOV  V16.D[1], X7
    FMOV  D17, X29
    FMOV  V17.D[1], X2
    FMOV  D18, X4
    FMOV  V18.D[1], X24
    FMOV  D19, X8
    FMOV  V19.D[1], X24
    FMOV  D20, X24
    FMOV  V20.D[1], X11
    FMOV  D21, X20
    FMOV  V21.D[1], X5
    FMOV  D22, X4
    FMOV  V22.D[1], X16
    FMOV  D23, X9
    FMOV  V23.D[1], X29
    FMOV  D24, X15
    FMOV  V24.D[1], X17
    FMOV  D25, X17
    FMOV  V25.D[1], X8
    FMOV  D26, X20
    FMOV  V26.D[1], X11
    FMOV  D27, X17
    FMOV  V27.D[1], X19
    FMOV  D28, X28
    FMOV  V28.D[1], X29
    FMOV  D29, X15
    FMOV  V29.D[1], X28
    FMOV  D30, X2
    FMOV  V30.D[1], X24
    FMOV  D31, X5
    FMOV  V31.D[1], X16
    MOVZ  X27, #0xa, LSL #0
TaishanSimdUnaryArithmeticP01_label_1229:
    AESIMC  V8.16B, V1.16B
    AESMC  V10.16B, V23.16B
    SHA256SU1  V28.4S, V26.4S, V5.4S
    SHA256SU1  V7.4S, V21.4S, V1.4S
    SHA1P  Q24, S6, V30.4S
    SHA1P  Q28, S14, V8.4S
    SHA1H  S2, S31
    SHA1M  Q23, S17, V12.4S
    SHA1C  Q14, S21, V23.4S
    SHA256SU1  V24.4S, V17.4S, V14.4S
    SHA1P  Q18, S20, V25.4S
    SHA1SU0  V14.4S, V24.4S, V14.4S
    AESD  V5.16B, V16.16B
    SHA256SU1  V19.4S, V19.4S, V5.4S
    SHA1SU0  V23.4S, V29.4S, V10.4S
    SHA1C  Q24, S3, V18.4S
    SHA1P  Q23, S31, V29.4S
    AESIMC  V25.16B, V4.16B
    SHA1SU1  V17.4S, V20.4S
    SHA256H2  Q18, Q8, V12.4S
    AESMC  V23.16B, V23.16B
    SHA256SU1  V23.4S, V6.4S, V29.4S
    SHA1SU0  V3.4S, V28.4S, V18.4S
    SHA1C  Q18, S7, V10.4S
    SHA256SU1  V18.4S, V6.4S, V18.4S
    AESMC  V8.16B, V23.16B
    SHA1C  Q21, S9, V2.4S
    SHA256SU1  V26.4S, V29.4S, V24.4S
    AESD  V25.16B, V5.16B
    SHA1H  S3, S25
    AESE  V28.16B, V3.16B
    SHA1M  Q30, S17, V27.4S
    SHA1C  Q15, S28, V6.4S
    SHA256SU0  V15.4S, V23.4S
    AESMC  V27.16B, V15.16B
    AESIMC  V5.16B, V28.16B
    SHA1M  Q12, S26, V14.4S
    AESE  V4.16B, V6.16B
    AESE  V11.16B, V3.16B
    AESMC  V19.16B, V14.16B
    SHA1SU0  V25.4S, V12.4S, V0.4S
    SHA256H  Q14, Q20, V11.4S
    SHA1H  S30, S3
    AESE  V27.16B, V20.16B
    SHA1SU0  V29.4S, V29.4S, V5.4S
    SHA1H  S21, S25
    SHA256SU1  V14.4S, V1.4S, V2.4S
    SHA256SU1  V12.4S, V7.4S, V9.4S
    AESE  V3.16B, V27.16B
    AESE  V28.16B, V14.16B
    SHA1P  Q7, S1, V10.4S
    AESIMC  V13.16B, V5.16B
    SHA256H  Q2, Q21, V13.4S
    SHA256SU1  V30.4S, V18.4S, V18.4S
    SHA1SU1  V22.4S, V15.4S
    SHA1SU1  V8.4S, V25.4S
    SHA1SU1  V7.4S, V18.4S
    SHA1M  Q12, S11, V0.4S
    SHA1SU1  V16.4S, V11.4S
    SHA1C  Q4, S6, V16.4S
    AESMC  V6.16B, V1.16B
    AESMC  V6.16B, V31.16B
    SHA1SU0  V27.4S, V5.4S, V27.4S
    SHA256H2  Q24, Q20, V0.4S
    SHA256H2  Q25, Q4, V11.4S
    SHA256H2  Q5, Q14, V13.4S
    AESE  V22.16B, V24.16B
    AESIMC  V25.16B, V9.16B
    SHA1SU0  V0.4S, V3.4S, V25.4S
    SHA256SU1  V22.4S, V3.4S, V19.4S
    SHA1SU0  V25.4S, V8.4S, V28.4S
    AESIMC  V18.16B, V30.16B
    SHA1SU0  V18.4S, V5.4S, V14.4S
    SHA256H  Q0, Q22, V27.4S
    SHA1C  Q30, S21, V0.4S
    SHA1SU0  V16.4S, V2.4S, V29.4S
    SHA256SU1  V25.4S, V30.4S, V5.4S
    AESMC  V2.16B, V18.16B
    AESIMC  V3.16B, V26.16B
    AESD  V24.16B, V18.16B
    SHA1H  S20, S10
    SHA256SU0  V7.4S, V31.4S
    SHA1P  Q10, S16, V31.4S
    SHA1M  Q21, S20, V27.4S
    SHA256SU0  V31.4S, V21.4S
    AESMC  V14.16B, V4.16B
    SHA1SU0  V3.4S, V30.4S, V25.4S
    SHA1H  S7, S20
    SHA256H  Q30, Q19, V1.4S
    SHA1C  Q25, S12, V31.4S
    SHA1SU0  V6.4S, V14.4S, V3.4S
    AESE  V31.16B, V6.16B
    SHA1SU1  V20.4S, V15.4S
    AESMC  V12.16B, V25.16B
    SHA1P  Q22, S2, V21.4S
    SHA1C  Q19, S9, V16.4S
    SHA1H  S25, S3
    SHA256SU1  V19.4S, V17.4S, V5.4S
    SHA1SU0  V17.4S, V30.4S, V20.4S
    SHA1M  Q25, S21, V24.4S
    AESMC  V27.16B, V14.16B
    SHA256H  Q20, Q30, V6.4S
    AESMC  V7.16B, V31.16B
    SHA256H2  Q2, Q1, V16.4S
    AESMC  V13.16B, V31.16B
    SHA1SU0  V27.4S, V12.4S, V20.4S
    SHA1SU1  V25.4S, V15.4S
    SHA1SU0  V29.4S, V14.4S, V20.4S
    AESMC  V17.16B, V14.16B
    SHA256SU0  V18.4S, V16.4S
    AESE  V3.16B, V13.16B
    SHA1P  Q7, S0, V13.4S
    AESMC  V29.16B, V8.16B
    SHA1SU1  V24.4S, V27.4S
    SHA1SU0  V30.4S, V3.4S, V6.4S
    SHA1C  Q23, S20, V2.4S
    SHA256SU1  V6.4S, V25.4S, V20.4S
    AESIMC  V27.16B, V16.16B
    AESIMC  V18.16B, V21.16B
    SHA1M  Q8, S20, V12.4S
    SHA256SU0  V4.4S, V3.4S
    AESMC  V3.16B, V9.16B
    AESIMC  V29.16B, V26.16B
    SHA256SU0  V30.4S, V29.4S
    SHA1P  Q7, S12, V23.4S
    SHA1C  Q16, S1, V5.4S
    AESIMC  V6.16B, V10.16B
    SHA1M  Q9, S10, V0.4S
    SHA256H  Q27, Q15, V11.4S
    AESE  V5.16B, V6.16B
    SHA1SU1  V24.4S, V20.4S
    SHA1P  Q10, S27, V21.4S
    AESMC  V18.16B, V23.16B
    SHA1SU1  V14.4S, V6.4S
    SHA256H  Q11, Q20, V5.4S
    SHA1SU1  V15.4S, V15.4S
    SHA1M  Q1, S7, V14.4S
    AESMC  V15.16B, V3.16B
    SHA1SU1  V27.4S, V17.4S
    AESD  V31.16B, V11.16B
    SHA1M  Q17, S20, V14.4S
    AESMC  V26.16B, V24.16B
    SHA256SU0  V3.4S, V31.4S
    SHA1M  Q16, S7, V10.4S
    SHA256H2  Q16, Q8, V23.4S
    SHA1C  Q7, S23, V6.4S
    SHA1H  S12, S31
    SHA256SU0  V27.4S, V24.4S
    SHA1SU1  V1.4S, V3.4S
    SHA256SU1  V4.4S, V27.4S, V11.4S
    AESD  V15.16B, V10.16B
    SHA1M  Q1, S30, V22.4S
    SHA1SU1  V7.4S, V9.4S
    SHA1SU1  V31.4S, V1.4S
    AESE  V26.16B, V1.16B
    SHA256SU1  V4.4S, V30.4S, V12.4S
    AESE  V1.16B, V21.16B
    SHA256SU1  V10.4S, V11.4S, V18.4S
    SHA1SU1  V10.4S, V5.4S
    AESE  V26.16B, V16.16B
    SHA1M  Q21, S10, V17.4S
    SHA1H  S14, S11
    AESD  V15.16B, V23.16B
    SHA1H  S30, S30
    SHA1P  Q30, S8, V3.4S
    SHA256H  Q22, Q28, V12.4S
    AESE  V27.16B, V10.16B
    SHA1C  Q26, S18, V8.4S
    SHA1H  S27, S7
    SHA256SU1  V29.4S, V13.4S, V20.4S
    AESE  V6.16B, V6.16B
    AESD  V11.16B, V10.16B
    SHA256H  Q9, Q29, V13.4S
    SHA1C  Q12, S8, V17.4S
    AESMC  V23.16B, V0.16B
    SHA1P  Q0, S19, V9.4S
    SHA256SU1  V7.4S, V5.4S, V6.4S
    SHA256H2  Q18, Q3, V22.4S
    SHA1SU0  V19.4S, V25.4S, V0.4S
    AESMC  V7.16B, V3.16B
    AESMC  V20.16B, V28.16B
    SHA1C  Q28, S28, V8.4S
    SHA1P  Q7, S6, V17.4S
    AESE  V27.16B, V10.16B
    SHA256H2  Q17, Q20, V4.4S
    AESE  V4.16B, V14.16B
    SHA256H  Q10, Q17, V16.4S
    SHA256H2  Q23, Q24, V6.4S
    AESE  V9.16B, V24.16B
    SHA256H2  Q29, Q8, V14.4S
    SHA1SU0  V1.4S, V25.4S, V5.4S
    SHA256SU0  V3.4S, V13.4S
    SHA1M  Q18, S9, V17.4S
    SHA1H  S17, S6
    SHA1SU1  V12.4S, V15.4S
    SHA1P  Q24, S31, V31.4S
    SHA256H2  Q27, Q23, V18.4S
    SHA256SU1  V24.4S, V21.4S, V4.4S
    SHA256SU1  V8.4S, V10.4S, V24.4S
    AESIMC  V3.16B, V8.16B
    SUBS  X27, X27, #0x1
    B.NE  TaishanSimdUnaryArithmeticP01_label_1229
    MOVZ  X24, #0xba7c, LSL #0
    MOVK  X24, #0x3065, LSL #16
    MOVK  X24, #0x359b, LSL #32
    MOVK  X24, #0xcc80, LSL #48
    SUB  X28, X24, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X13, #0x3d5c, LSL #0
    MOVK  X13, #0x1ae6, LSL #16
    MOVK  X13, #0x7e53, LSL #32
    MOVK  X13, #0xe6e2, LSL #48
    SUB  X19, X13, X3
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X6, #0x94d8, LSL #0
    MOVK  X6, #0xff41, LSL #16
    MOVK  X6, #0xdb76, LSL #32
    MOVK  X6, #0xead9, LSL #48
    SUB  X12, X6, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X19, #0x3c1c, LSL #0
    MOVK  X19, #0x23d5, LSL #16
    MOVK  X19, #0x1245, LSL #32
    MOVK  X19, #0xae8, LSL #48
    SUB  X10, X19, X5
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X28, #0x94d8, LSL #0
    MOVK  X28, #0xff41, LSL #16
    MOVK  X28, #0xdb76, LSL #32
    MOVK  X28, #0xead9, LSL #48
    SUB  X27, X28, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X17, #0x4abc, LSL #0
    MOVK  X17, #0x76fa, LSL #16
    MOVK  X17, #0x6be6, LSL #32
    MOVK  X17, #0x3dd8, LSL #48
    SUB  X26, X17, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X2, #0xcd37, LSL #0
    MOVK  X2, #0xc6f1, LSL #16
    MOVK  X2, #0x3a26, LSL #32
    MOVK  X2, #0x702d, LSL #48
    SUB  X8, X2, X8
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X7, #0x94a5, LSL #0
    MOVK  X7, #0x7c9d, LSL #16
    MOVK  X7, #0xcd3, LSL #32
    MOVK  X7, #0xfeab, LSL #48
    SUB  X15, X7, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X15, #0x38f7, LSL #0
    MOVK  X15, #0x8fb2, LSL #16
    MOVK  X15, #0xb168, LSL #32
    MOVK  X15, #0x29f8, LSL #48
    SUB  X5, X15, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X4, #0x3d5c, LSL #0
    MOVK  X4, #0x1ae6, LSL #16
    MOVK  X4, #0x7e53, LSL #32
    MOVK  X4, #0xe6e2, LSL #48
    SUB  X16, X4, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X21, #0x5a47, LSL #0
    MOVK  X21, #0xcd56, LSL #16
    MOVK  X21, #0x7926, LSL #32
    MOVK  X21, #0x8848, LSL #48
    SUB  X19, X21, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X21, #0x4abc, LSL #0
    MOVK  X21, #0x76fa, LSL #16
    MOVK  X21, #0x6be6, LSL #32
    MOVK  X21, #0x3dd8, LSL #48
    SUB  X15, X21, X17
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X29, #0x8fcf, LSL #0
    MOVK  X29, #0x7315, LSL #16
    MOVK  X29, #0x5283, LSL #32
    MOVK  X29, #0x6ac8, LSL #48
    SUB  X23, X29, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X19
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X26, #0x1c6d, LSL #0
    MOVK  X26, #0x962b, LSL #16
    MOVK  X26, #0xfda6, LSL #32
    MOVK  X26, #0x7a8a, LSL #48
    SUB  X25, X26, X20
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X5, #0x4abc, LSL #0
    MOVK  X5, #0x76fa, LSL #16
    MOVK  X5, #0x6be6, LSL #32
    MOVK  X5, #0x3dd8, LSL #48
    SUB  X9, X5, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X21, #0x1c6d, LSL #0
    MOVK  X21, #0x962b, LSL #16
    MOVK  X21, #0xfda6, LSL #32
    MOVK  X21, #0x7a8a, LSL #48
    SUB  X7, X21, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X27
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X29
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X4, #0xcdc8, LSL #0
    MOVK  X4, #0xa2e5, LSL #16
    MOVK  X4, #0x559b, LSL #32
    MOVK  X4, #0xba73, LSL #48
    SUB  X14, X4, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, D2
    MOVZ  X4, #0x904e, LSL #0
    MOVK  X4, #0xa966, LSL #16
    MOVK  X4, #0xbc4, LSL #32
    MOVK  X4, #0x261b, LSL #48
    SUB  X14, X4, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X28, #0xdbac, LSL #0
    MOVK  X28, #0x4b59, LSL #16
    MOVK  X28, #0x9e35, LSL #32
    MOVK  X28, #0xca18, LSL #48
    SUB  X21, X28, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, D3
    MOVZ  X28, #0x8f, LSL #0
    MOVK  X28, #0xc66d, LSL #16
    MOVK  X28, #0xee3d, LSL #32
    MOVK  X28, #0xaa8d, LSL #48
    SUB  X21, X28, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X3, #0x33ba, LSL #0
    MOVK  X3, #0x40f3, LSL #16
    MOVK  X3, #0x1c14, LSL #32
    MOVK  X3, #0x8fee, LSL #48
    SUB  X10, X3, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, D4
    MOVZ  X3, #0xcc77, LSL #0
    MOVK  X3, #0x81, LSL #16
    MOVK  X3, #0x52f7, LSL #32
    MOVK  X3, #0x7094, LSL #48
    SUB  X10, X3, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X14, #0x5ab4, LSL #0
    MOVK  X14, #0x27fe, LSL #16
    MOVK  X14, #0x8185, LSL #32
    MOVK  X14, #0x4e08, LSL #48
    SUB  X29, X14, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, D5
    MOVZ  X14, #0x7da, LSL #0
    MOVK  X14, #0x1d69, LSL #16
    MOVK  X14, #0x6297, LSL #32
    MOVK  X14, #0x772c, LSL #48
    SUB  X29, X14, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, V6.D[1]
    MOVZ  X12, #0x6363, LSL #0
    MOVK  X12, #0x6363, LSL #16
    MOVK  X12, #0x6363, LSL #32
    MOVK  X12, #0x6363, LSL #48
    SUB  X15, X12, X21
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, D6
    MOVZ  X12, #0x6363, LSL #0
    MOVK  X12, #0x6363, LSL #16
    MOVK  X12, #0x6363, LSL #32
    MOVK  X12, #0x6363, LSL #48
    SUB  X15, X12, X21
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X10, V7.D[1]
    MOVZ  X12, #0x5be4, LSL #0
    MOVK  X12, #0x3f73, LSL #16
    MOVK  X12, #0x4eae, LSL #32
    MOVK  X12, #0x853d, LSL #48
    SUB  X23, X12, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X10, D7
    MOVZ  X12, #0x5749, LSL #0
    MOVK  X12, #0xa7ce, LSL #16
    MOVK  X12, #0x4a1c, LSL #32
    MOVK  X12, #0xf082, LSL #48
    SUB  X23, X12, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X21, #0xa127, LSL #0
    MOVK  X21, #0xfb18, LSL #16
    MOVK  X21, #0xf001, LSL #32
    MOVK  X21, #0x56de, LSL #48
    SUB  X7, X21, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, D8
    MOVZ  X21, #0xfeae, LSL #0
    MOVK  X21, #0x7004, LSL #16
    MOVK  X21, #0xdc74, LSL #32
    MOVK  X21, #0x6b37, LSL #48
    SUB  X7, X21, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X6, #0x5734, LSL #0
    MOVK  X6, #0x2d89, LSL #16
    MOVK  X6, #0xa383, LSL #32
    MOVK  X6, #0xcc6, LSL #48
    SUB  X28, X6, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, D9
    MOVZ  X6, #0x35b3, LSL #0
    MOVK  X6, #0xa81c, LSL #16
    MOVK  X6, #0x9c8d, LSL #32
    MOVK  X6, #0x4612, LSL #48
    SUB  X28, X6, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X19, #0xe4cc, LSL #0
    MOVK  X19, #0xb337, LSL #16
    MOVK  X19, #0xdccf, LSL #32
    MOVK  X19, #0x6819, LSL #48
    SUB  X16, X19, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, D10
    MOVZ  X19, #0x2711, LSL #0
    MOVK  X19, #0x5797, LSL #16
    MOVK  X19, #0x4881, LSL #32
    MOVK  X19, #0x1d1, LSL #48
    SUB  X16, X19, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X26, #0x6584, LSL #0
    MOVK  X26, #0xc57b, LSL #16
    MOVK  X26, #0x16f3, LSL #32
    MOVK  X26, #0xd16c, LSL #48
    SUB  X20, X26, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, D11
    MOVZ  X26, #0xfcaf, LSL #0
    MOVK  X26, #0xe221, LSL #16
    MOVK  X26, #0x51d3, LSL #32
    MOVK  X26, #0xd558, LSL #48
    SUB  X20, X26, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X25, #0xfdc4, LSL #0
    MOVK  X25, #0x7446, LSL #16
    MOVK  X25, #0x1e6b, LSL #32
    MOVK  X25, #0x5d45, LSL #48
    SUB  X20, X25, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, D12
    MOVZ  X25, #0x4a5e, LSL #0
    MOVK  X25, #0x4d2c, LSL #16
    MOVK  X25, #0x7826, LSL #32
    MOVK  X25, #0xe822, LSL #48
    SUB  X20, X25, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, V13.D[1]
    MOVZ  X5, #0xef10, LSL #0
    MOVK  X5, #0x3b54, LSL #16
    MOVK  X5, #0x3f30, LSL #32
    MOVK  X5, #0x9db4, LSL #48
    SUB  X27, X5, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, D13
    MOVZ  X5, #0x5624, LSL #0
    MOVK  X5, #0xb38f, LSL #16
    MOVK  X5, #0xbd1e, LSL #32
    MOVK  X5, #0xdcab, LSL #48
    SUB  X27, X5, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, D14
    MOVZ  X10, #0xbf58, LSL #0
    MOVK  X10, #0xfc8c, LSL #16
    SUB  X18, X10, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X9, #0x1847, LSL #0
    MOVK  X9, #0xc57, LSL #16
    MOVK  X9, #0x644b, LSL #32
    MOVK  X9, #0x33b5, LSL #48
    SUB  X29, X9, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, D15
    MOVZ  X9, #0xd814, LSL #0
    MOVK  X9, #0x7124, LSL #16
    MOVK  X9, #0x2100, LSL #32
    MOVK  X9, #0x92fd, LSL #48
    SUB  X29, X9, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, V16.D[1]
    MOVZ  X11, #0x42fb, LSL #0
    MOVK  X11, #0x77b7, LSL #16
    MOVK  X11, #0x98fb, LSL #32
    MOVK  X11, #0xe020, LSL #48
    SUB  X9, X11, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, D16
    MOVZ  X11, #0xdd33, LSL #0
    MOVK  X11, #0x65ab, LSL #16
    MOVK  X11, #0x3c50, LSL #32
    MOVK  X11, #0x3a70, LSL #48
    SUB  X9, X11, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X16, D17
    MOVZ  X14, #0xd8d8, LSL #0
    MOVK  X14, #0xd8d8, LSL #16
    SUB  X13, X14, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X21, #0x3763, LSL #0
    MOVK  X21, #0xae50, LSL #16
    MOVK  X21, #0xeeb, LSL #32
    MOVK  X21, #0xa837, LSL #48
    SUB  X3, X21, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, D18
    MOVZ  X21, #0x1f6a, LSL #0
    MOVK  X21, #0x3e26, LSL #16
    MOVK  X21, #0xa331, LSL #32
    MOVK  X21, #0x6320, LSL #48
    SUB  X3, X21, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, V19.D[1]
    MOVZ  X16, #0x6ccf, LSL #0
    MOVK  X16, #0xd456, LSL #16
    MOVK  X16, #0x87e5, LSL #32
    MOVK  X16, #0xc516, LSL #48
    SUB  X6, X16, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, D19
    MOVZ  X16, #0x9c1a, LSL #0
    MOVK  X16, #0x1159, LSL #16
    MOVK  X16, #0xfb4c, LSL #32
    MOVK  X16, #0x8364, LSL #48
    SUB  X6, X16, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X14, #0x9f11, LSL #0
    MOVK  X14, #0xcbef, LSL #16
    MOVK  X14, #0x430d, LSL #32
    MOVK  X14, #0x88db, LSL #48
    SUB  X16, X14, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, D20
    MOVZ  X14, #0x5a98, LSL #0
    MOVK  X14, #0x9e3f, LSL #16
    MOVK  X14, #0xc1e3, LSL #32
    MOVK  X14, #0x2f9e, LSL #48
    SUB  X16, X14, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, V21.D[1]
    MOVZ  X12, #0xa112, LSL #0
    MOVK  X12, #0xa069, LSL #16
    MOVK  X12, #0x3552, LSL #32
    MOVK  X12, #0x9700, LSL #48
    SUB  X15, X12, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, D21
    MOVZ  X12, #0x6616, LSL #0
    MOVK  X12, #0x8a81, LSL #16
    MOVK  X12, #0x86b8, LSL #32
    MOVK  X12, #0x9d0e, LSL #48
    SUB  X15, X12, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X21, #0xfc31, LSL #0
    MOVK  X21, #0xac3c, LSL #16
    MOVK  X21, #0x5413, LSL #32
    MOVK  X21, #0xa9e5, LSL #48
    SUB  X24, X21, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, D23
    MOVZ  X21, #0xb76d, LSL #0
    MOVK  X21, #0xa48b, LSL #16
    MOVK  X21, #0xf4f2, LSL #32
    MOVK  X21, #0x8cbd, LSL #48
    SUB  X24, X21, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, V24.D[1]
    MOVZ  X6, #0x7c2a, LSL #0
    MOVK  X6, #0xabfa, LSL #16
    MOVK  X6, #0x844f, LSL #32
    MOVK  X6, #0x7cd1, LSL #48
    SUB  X7, X6, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, D24
    MOVZ  X6, #0xe01, LSL #0
    MOVK  X6, #0x3467, LSL #16
    MOVK  X6, #0x20a8, LSL #32
    MOVK  X6, #0xc6e2, LSL #48
    SUB  X7, X6, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X29, #0x26bf, LSL #0
    MOVK  X29, #0xa765, LSL #16
    MOVK  X29, #0xa45d, LSL #32
    MOVK  X29, #0x9662, LSL #48
    SUB  X28, X29, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, D25
    MOVZ  X29, #0xd204, LSL #0
    MOVK  X29, #0x6c32, LSL #16
    MOVK  X29, #0xac3b, LSL #32
    MOVK  X29, #0x8003, LSL #48
    SUB  X28, X29, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, V26.D[1]
    MOVZ  X11, #0xd4fc, LSL #0
    MOVK  X11, #0x88fd, LSL #16
    MOVK  X11, #0x136c, LSL #32
    MOVK  X11, #0x29a2, LSL #48
    SUB  X23, X11, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, D26
    MOVZ  X11, #0xacff, LSL #0
    MOVK  X11, #0xda8, LSL #16
    MOVK  X11, #0x209d, LSL #32
    MOVK  X11, #0xbcc, LSL #48
    SUB  X23, X11, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X8, #0xef36, LSL #0
    MOVK  X8, #0xadeb, LSL #16
    MOVK  X8, #0x8908, LSL #32
    MOVK  X8, #0x797e, LSL #48
    SUB  X10, X8, X20
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, D27
    MOVZ  X8, #0x6503, LSL #0
    MOVK  X8, #0xa46a, LSL #16
    MOVK  X8, #0xc8a2, LSL #32
    MOVK  X8, #0xd4ad, LSL #48
    SUB  X10, X8, X20
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X13, #0x699f, LSL #0
    MOVK  X13, #0xad69, LSL #16
    MOVK  X13, #0xb32a, LSL #32
    MOVK  X13, #0x135c, LSL #48
    SUB  X3, X13, X18
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, D28
    MOVZ  X13, #0xd048, LSL #0
    MOVK  X13, #0x5fac, LSL #16
    MOVK  X13, #0x62a, LSL #32
    MOVK  X13, #0xe900, LSL #48
    SUB  X3, X13, X18
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, V29.D[1]
    MOVZ  X8, #0xb03d, LSL #0
    MOVK  X8, #0x178e, LSL #16
    MOVK  X8, #0x64ea, LSL #32
    MOVK  X8, #0x4db8, LSL #48
    SUB  X19, X8, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, D29
    MOVZ  X8, #0xfd8e, LSL #0
    MOVK  X8, #0x27d3, LSL #16
    MOVK  X8, #0x6cc7, LSL #32
    MOVK  X8, #0x7c0e, LSL #48
    SUB  X19, X8, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
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
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X25
    FMOV  V0.D[1], X19
    FMOV  D1, X29
    FMOV  V1.D[1], X9
    FMOV  D2, X21
    FMOV  V2.D[1], X28
    FMOV  D3, X27
    FMOV  V3.D[1], X8
    FMOV  D4, X17
    FMOV  V4.D[1], X18
    FMOV  D5, X9
    FMOV  V5.D[1], X18
    FMOV  D6, X24
    FMOV  V6.D[1], X23
    FMOV  D7, X18
    FMOV  V7.D[1], X7
    FMOV  D8, X24
    FMOV  V8.D[1], X6
    FMOV  D9, X6
    FMOV  V9.D[1], X9
    FMOV  D10, X9
    FMOV  V10.D[1], X12
    FMOV  D11, X26
    FMOV  V11.D[1], X19
    FMOV  D12, X26
    FMOV  V12.D[1], X2
    FMOV  D13, X25
    FMOV  V13.D[1], X4
    FMOV  D14, X26
    FMOV  V14.D[1], X28
    FMOV  D15, X4
    FMOV  V15.D[1], X10
    FMOV  D16, X2
    FMOV  V16.D[1], X12
    FMOV  D17, X21
    FMOV  V17.D[1], X24
    FMOV  D18, X5
    FMOV  V18.D[1], X17
    FMOV  D19, X16
    FMOV  V19.D[1], X17
TaishanSimdUnaryArithmeticP01_label_671:
    FMOV  D20, X5
    FMOV  V20.D[1], X8
    FMOV  D21, X14
    FMOV  V21.D[1], X25
    FMOV  D22, X23
    FMOV  V22.D[1], X28
    FMOV  D23, X24
    FMOV  V23.D[1], X17
    FMOV  D24, X26
    FMOV  V24.D[1], X12
    FMOV  D25, X3
    FMOV  V25.D[1], X12
    FMOV  D26, X19
    FMOV  V26.D[1], X28
    FMOV  D27, X12
    FMOV  V27.D[1], X8
    FMOV  D28, X8
    FMOV  V28.D[1], X19
    FMOV  D29, X6
    FMOV  V29.D[1], X12
    FMOV  D30, X3
    FMOV  V30.D[1], X18
    FMOV  D31, X20
    FMOV  V31.D[1], X6
    MOVZ  X24, #0xa, LSL #0
TaishanSimdUnaryArithmeticP01_label_1312:
    SHA256SU0  V16.4S, V10.4S
    AESD  V2.16B, V11.16B
    SHA1H  S24, S4
    SHA256SU0  V0.4S, V24.4S
    SHA256SU0  V6.4S, V25.4S
    SHA1SU1  V11.4S, V6.4S
    AESIMC  V1.16B, V6.16B
    SHA1M  Q2, S22, V23.4S
    AESMC  V29.16B, V4.16B
    AESIMC  V9.16B, V2.16B
    SHA1P  Q21, S21, V2.4S
    AESE  V25.16B, V26.16B
    SHA256H2  Q23, Q31, V3.4S
    SHA1SU0  V3.4S, V3.4S, V8.4S
    SHA1SU1  V12.4S, V20.4S
    SHA256H  Q12, Q18, V25.4S
    AESMC  V21.16B, V30.16B
    SHA1SU1  V5.4S, V28.4S
    SHA1M  Q11, S15, V1.4S
    AESE  V24.16B, V21.16B
    SHA1H  S17, S23
    SHA256H  Q31, Q17, V29.4S
    AESMC  V20.16B, V15.16B
    SHA256H  Q19, Q18, V8.4S
    SHA256H  Q26, Q28, V31.4S
    SHA1SU0  V9.4S, V25.4S, V17.4S
    SHA256H  Q24, Q23, V18.4S
    SHA256SU0  V11.4S, V4.4S
    SHA1SU0  V0.4S, V29.4S, V16.4S
    AESE  V22.16B, V22.16B
    AESE  V28.16B, V3.16B
    AESIMC  V10.16B, V17.16B
    AESE  V20.16B, V25.16B
    SHA256H2  Q19, Q22, V31.4S
    SHA256H2  Q27, Q23, V3.4S
    SHA1C  Q15, S21, V29.4S
    AESD  V25.16B, V8.16B
    SHA256SU0  V27.4S, V15.4S
    AESE  V24.16B, V19.16B
    AESMC  V13.16B, V15.16B
    SHA1H  S3, S9
    SHA1SU0  V22.4S, V5.4S, V5.4S
    AESMC  V17.16B, V2.16B
    AESMC  V14.16B, V14.16B
    SHA1H  S8, S18
    AESD  V3.16B, V19.16B
    SHA1P  Q31, S12, V19.4S
    SHA1P  Q7, S26, V27.4S
    SHA1C  Q10, S19, V4.4S
    AESMC  V29.16B, V13.16B
    SHA256SU0  V22.4S, V7.4S
    SHA1SU1  V10.4S, V14.4S
    AESD  V21.16B, V19.16B
    AESE  V31.16B, V3.16B
    AESE  V17.16B, V5.16B
    SHA1SU0  V2.4S, V17.4S, V29.4S
    AESE  V9.16B, V11.16B
    SHA1SU1  V3.4S, V17.4S
    SHA256SU0  V12.4S, V28.4S
    AESIMC  V27.16B, V11.16B
    AESE  V13.16B, V24.16B
    SHA1SU1  V11.4S, V25.4S
    AESIMC  V4.16B, V28.16B
    SHA1SU0  V9.4S, V5.4S, V19.4S
    SHA1C  Q4, S5, V1.4S
    SHA256SU0  V24.4S, V10.4S
    AESMC  V23.16B, V6.16B
    SHA1P  Q10, S31, V24.4S
    SHA1SU1  V4.4S, V9.4S
    SHA1P  Q23, S0, V2.4S
    SHA256H2  Q22, Q10, V8.4S
    SHA256SU0  V21.4S, V18.4S
    SHA256H  Q26, Q24, V20.4S
    SHA1P  Q26, S22, V19.4S
    SHA1SU1  V12.4S, V30.4S
    SHA256SU0  V4.4S, V8.4S
    SHA1C  Q8, S1, V10.4S
    AESD  V20.16B, V18.16B
    AESMC  V19.16B, V5.16B
    AESD  V24.16B, V18.16B
    SHA256SU0  V0.4S, V13.4S
    SHA1C  Q0, S25, V29.4S
    AESD  V1.16B, V27.16B
    SHA1C  Q22, S24, V18.4S
    AESD  V28.16B, V21.16B
    SHA256H2  Q25, Q17, V1.4S
    AESMC  V5.16B, V28.16B
    SHA1SU0  V6.4S, V14.4S, V25.4S
    SHA1SU1  V17.4S, V31.4S
    SHA256SU0  V30.4S, V24.4S
    SHA1SU0  V14.4S, V3.4S, V4.4S
    SHA1M  Q15, S0, V3.4S
    SHA1C  Q30, S4, V19.4S
    SHA1H  S5, S8
    AESIMC  V2.16B, V3.16B
    SHA256H  Q20, Q15, V20.4S
    SHA1M  Q6, S12, V6.4S
    AESMC  V9.16B, V14.16B
    AESMC  V25.16B, V7.16B
    SHA1C  Q1, S3, V13.4S
    AESE  V28.16B, V7.16B
    AESMC  V17.16B, V19.16B
    SHA256SU1  V23.4S, V21.4S, V23.4S
    SHA256H2  Q17, Q24, V31.4S
    SHA1M  Q25, S11, V8.4S
    SHA256H  Q19, Q11, V18.4S
    SHA256SU0  V29.4S, V6.4S
    SHA1C  Q26, S13, V25.4S
    SHA256SU0  V26.4S, V2.4S
    SHA1P  Q26, S13, V11.4S
    SHA1SU0  V21.4S, V9.4S, V21.4S
    SHA1H  S27, S20
    SHA1C  Q1, S31, V14.4S
    SHA1H  S7, S9
    SHA1P  Q20, S29, V14.4S
    SHA256SU1  V12.4S, V2.4S, V15.4S
    SHA1SU0  V7.4S, V31.4S, V28.4S
    SHA1P  Q23, S31, V8.4S
    SHA256H2  Q25, Q14, V3.4S
    SHA1SU0  V16.4S, V3.4S, V5.4S
    SHA1SU0  V5.4S, V30.4S, V9.4S
    SHA256SU0  V7.4S, V8.4S
    SHA256H2  Q29, Q17, V15.4S
    SHA1C  Q9, S26, V10.4S
    SHA1M  Q20, S1, V16.4S
    SHA1P  Q30, S31, V9.4S
    AESD  V19.16B, V18.16B
    SHA256H  Q25, Q28, V23.4S
    AESIMC  V10.16B, V25.16B
    AESMC  V20.16B, V26.16B
    SHA256SU1  V26.4S, V7.4S, V11.4S
    SHA256H  Q16, Q14, V3.4S
    SHA1M  Q31, S16, V2.4S
    AESIMC  V2.16B, V5.16B
    AESD  V27.16B, V22.16B
    SHA256SU0  V19.4S, V19.4S
    AESIMC  V23.16B, V29.16B
    SHA256H  Q3, Q31, V19.4S
    AESE  V27.16B, V25.16B
    AESE  V6.16B, V31.16B
    SHA1SU0  V23.4S, V1.4S, V0.4S
    AESIMC  V5.16B, V5.16B
    SHA1SU0  V27.4S, V30.4S, V18.4S
    SHA1M  Q20, S7, V3.4S
    SHA256H  Q11, Q6, V30.4S
    SHA1SU1  V12.4S, V0.4S
    AESMC  V2.16B, V0.16B
    SHA1P  Q22, S8, V26.4S
    SHA1H  S9, S10
    SHA1M  Q19, S22, V8.4S
    SHA256SU1  V4.4S, V23.4S, V16.4S
    AESE  V15.16B, V17.16B
    AESE  V16.16B, V24.16B
    SHA256H  Q17, Q31, V29.4S
    SHA256H2  Q17, Q14, V2.4S
    AESMC  V10.16B, V10.16B
    SHA1SU1  V4.4S, V4.4S
    AESMC  V18.16B, V16.16B
    AESMC  V15.16B, V22.16B
    SHA1SU0  V25.4S, V11.4S, V8.4S
    SHA256SU1  V13.4S, V27.4S, V25.4S
    SHA1SU1  V19.4S, V29.4S
    AESD  V1.16B, V0.16B
    AESD  V31.16B, V26.16B
    SHA1H  S15, S29
    SHA1P  Q17, S4, V11.4S
    SHA1C  Q2, S10, V18.4S
    SHA256SU1  V24.4S, V23.4S, V27.4S
    SHA256H2  Q25, Q9, V1.4S
    SHA1P  Q3, S31, V10.4S
    SHA1SU1  V3.4S, V15.4S
    SHA1P  Q13, S17, V23.4S
    SHA256SU0  V5.4S, V17.4S
    SHA256H2  Q3, Q29, V22.4S
    AESD  V23.16B, V11.16B
    AESMC  V8.16B, V15.16B
    AESIMC  V15.16B, V26.16B
    AESD  V30.16B, V11.16B
    SHA1SU1  V30.4S, V26.4S
    SHA1C  Q31, S18, V18.4S
    SHA256H  Q1, Q3, V10.4S
    SHA256SU1  V8.4S, V25.4S, V12.4S
    AESD  V19.16B, V1.16B
    AESMC  V2.16B, V0.16B
    SHA1P  Q3, S16, V20.4S
TaishanSimdUnaryArithmeticP01_label_121:
    AESD  V14.16B, V3.16B
    AESIMC  V22.16B, V19.16B
    SHA256SU0  V18.4S, V24.4S
    SHA1C  Q31, S31, V3.4S
    SHA1SU0  V24.4S, V10.4S, V4.4S
    SHA256H  Q22, Q1, V22.4S
    SHA1H  S21, S11
    SHA1H  S25, S8
    AESMC  V21.16B, V3.16B
    SHA256H  Q23, Q3, V26.4S
    SHA1M  Q21, S25, V13.4S
    SHA256H2  Q24, Q4, V20.4S
    SHA256H2  Q0, Q10, V4.4S
    SHA1M  Q30, S31, V11.4S
    SHA256SU0  V18.4S, V21.4S
    SUBS  X24, X24, #0x1
    B.NE  TaishanSimdUnaryArithmeticP01_label_1312
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X24, X7, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X15, X4, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X8
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X18, X7, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X28, X3, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X29, X12, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X21, X23, X20
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X13, X27, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X24
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X25
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X26
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X27
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X27, #0x21d8, LSL #0
    MOVK  X27, #0x2352, LSL #16
    MOVK  X27, #0xa6d6, LSL #32
    MOVK  X27, #0x15a9, LSL #48
    SUB  X20, X27, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, D2
    MOVZ  X27, #0xdd97, LSL #0
    MOVK  X27, #0x5ed8, LSL #16
    MOVK  X27, #0x6ad8, LSL #32
    MOVK  X27, #0x34ed, LSL #48
    SUB  X20, X27, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, V3.D[1]
    MOVZ  X7, #0xd475, LSL #0
    MOVK  X7, #0xf273, LSL #16
    MOVK  X7, #0x62ab, LSL #32
    MOVK  X7, #0x711b, LSL #48
    SUB  X12, X7, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, D3
    MOVZ  X7, #0x8197, LSL #0
    MOVK  X7, #0x5927, LSL #16
    MOVK  X7, #0xdb22, LSL #32
    MOVK  X7, #0xa27a, LSL #48
    SUB  X12, X7, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X20, #0x6487, LSL #0
    MOVK  X20, #0xbb5c, LSL #16
    MOVK  X20, #0x2ba0, LSL #32
    MOVK  X20, #0x88a3, LSL #48
    SUB  X3, X20, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, D4
    MOVZ  X20, #0x7cad, LSL #0
    MOVK  X20, #0xffbf, LSL #16
    MOVK  X20, #0xa810, LSL #32
    MOVK  X20, #0x8616, LSL #48
    SUB  X3, X20, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X6, #0x5901, LSL #0
    MOVK  X6, #0xf557, LSL #16
    MOVK  X6, #0x7980, LSL #32
    MOVK  X6, #0xe13d, LSL #48
    SUB  X16, X6, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, D5
    MOVZ  X6, #0xd1a1, LSL #0
    MOVK  X6, #0x2bea, LSL #16
    MOVK  X6, #0x8adf, LSL #32
    MOVK  X6, #0x98b7, LSL #48
    SUB  X16, X6, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X8, #0xdf11, LSL #0
    MOVK  X8, #0xa1aa, LSL #16
    MOVK  X8, #0x1950, LSL #32
    MOVK  X8, #0x5883, LSL #48
    SUB  X15, X8, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, D6
    MOVZ  X8, #0xbb7a, LSL #0
    MOVK  X8, #0x4859, LSL #16
    MOVK  X8, #0xfb77, LSL #32
    MOVK  X8, #0xb733, LSL #48
    SUB  X15, X8, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, V7.D[1]
    MOVZ  X23, #0x6f79, LSL #0
    MOVK  X23, #0x84bd, LSL #16
    MOVK  X23, #0x5b3c, LSL #32
    MOVK  X23, #0x7bba, LSL #48
    SUB  X10, X23, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, D7
    MOVZ  X23, #0x5b73, LSL #0
    MOVK  X23, #0xda7c, LSL #16
    MOVK  X23, #0xbc3d, LSL #32
    MOVK  X23, #0x1525, LSL #48
    SUB  X10, X23, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, V8.D[1]
    MOVZ  X17, #0xbfed, LSL #0
    MOVK  X17, #0xb207, LSL #16
    MOVK  X17, #0xda59, LSL #32
    MOVK  X17, #0xab9b, LSL #48
    SUB  X12, X17, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, D8
    MOVZ  X17, #0x143b, LSL #0
    MOVK  X17, #0xe446, LSL #16
    MOVK  X17, #0xbc55, LSL #32
    MOVK  X17, #0xac9, LSL #48
    SUB  X12, X17, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X4, X6, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, D9
    MOVZ  X6, #0xcef5, LSL #0
    MOVK  X6, #0x50d, LSL #16
    SUB  X4, X6, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X2, #0x7ade, LSL #0
    MOVK  X2, #0x4a4, LSL #16
    MOVK  X2, #0x7b6a, LSL #32
    MOVK  X2, #0xc566, LSL #48
    SUB  X15, X2, X14
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D10
    MOVZ  X2, #0xefdd, LSL #0
    MOVK  X2, #0x43bd, LSL #16
    MOVK  X2, #0x517b, LSL #32
    MOVK  X2, #0xa97a, LSL #48
    SUB  X15, X2, X14
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, V11.D[1]
    MOVZ  X5, #0xc703, LSL #0
    MOVK  X5, #0xd0ed, LSL #16
    MOVK  X5, #0x2f9b, LSL #32
    MOVK  X5, #0x47ea, LSL #48
    SUB  X25, X5, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, D11
    MOVZ  X5, #0x3682, LSL #0
    MOVK  X5, #0xf96f, LSL #16
    MOVK  X5, #0x1fb8, LSL #32
    MOVK  X5, #0x1fa8, LSL #48
    SUB  X25, X5, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, V12.D[1]
    MOVZ  X3, #0x4971, LSL #0
    MOVK  X3, #0xc9cc, LSL #16
    MOVK  X3, #0x5d6b, LSL #32
    MOVK  X3, #0x218c, LSL #48
    SUB  X16, X3, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, D12
    MOVZ  X3, #0x4407, LSL #0
    MOVK  X3, #0xc1f9, LSL #16
    MOVK  X3, #0xf9d1, LSL #32
    MOVK  X3, #0xe5f0, LSL #48
    SUB  X16, X3, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X20, #0x9d27, LSL #0
    MOVK  X20, #0x4d7, LSL #16
    MOVK  X20, #0x32cc, LSL #32
    MOVK  X20, #0xf19b, LSL #48
    SUB  X28, X20, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, D13
    MOVZ  X20, #0x9d1a, LSL #0
    MOVK  X20, #0xf1ac, LSL #16
    MOVK  X20, #0xd759, LSL #32
    MOVK  X20, #0x6691, LSL #48
    SUB  X28, X20, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X24, #0xb3af, LSL #0
    MOVK  X24, #0xb4b5, LSL #16
    MOVK  X24, #0xc1d6, LSL #32
    MOVK  X24, #0x1fdf, LSL #48
    SUB  X7, X24, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, D14
    MOVZ  X24, #0xc93e, LSL #0
    MOVK  X24, #0x585e, LSL #16
    MOVK  X24, #0x60a1, LSL #32
    MOVK  X24, #0x4791, LSL #48
    SUB  X7, X24, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, V15.D[1]
    MOVZ  X18, #0x9cc5, LSL #0
    MOVK  X18, #0x20ff, LSL #16
    MOVK  X18, #0x6224, LSL #32
    MOVK  X18, #0x66a8, LSL #48
    SUB  X23, X18, X21
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, D15
    MOVZ  X18, #0x3ab2, LSL #0
    MOVK  X18, #0x2ed3, LSL #16
    MOVK  X18, #0x46a4, LSL #32
    MOVK  X18, #0x848a, LSL #48
    SUB  X23, X18, X21
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X8, #0xccae, LSL #0
    MOVK  X8, #0x3d54, LSL #16
    MOVK  X8, #0x1a85, LSL #32
    MOVK  X8, #0xdbcb, LSL #48
    SUB  X2, X8, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, D16
    MOVZ  X8, #0x9880, LSL #0
    MOVK  X8, #0xf8e3, LSL #16
    MOVK  X8, #0x284, LSL #32
    MOVK  X8, #0x9bad, LSL #48
    SUB  X2, X8, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X21, #0x941d, LSL #0
    MOVK  X21, #0xa6e1, LSL #16
    MOVK  X21, #0xe34f, LSL #32
    MOVK  X21, #0xa565, LSL #48
    SUB  X14, X21, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, D17
    MOVZ  X21, #0xa385, LSL #0
    MOVK  X21, #0x1f4a, LSL #16
    MOVK  X21, #0xcf6b, LSL #32
    MOVK  X21, #0x63c1, LSL #48
    SUB  X14, X21, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X9, #0xf7d4, LSL #0
    MOVK  X9, #0xe2fd, LSL #16
    MOVK  X9, #0x96bd, LSL #32
    MOVK  X9, #0x7dd6, LSL #48
    SUB  X13, X9, X8
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, D18
    MOVZ  X9, #0xcfb9, LSL #0
    MOVK  X9, #0xdff5, LSL #16
    MOVK  X9, #0x66f, LSL #32
    MOVK  X9, #0xf700, LSL #48
    SUB  X13, X9, X8
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, V19.D[1]
    MOVZ  X25, #0x923e, LSL #0
    MOVK  X25, #0xf516, LSL #16
    MOVK  X25, #0x46e6, LSL #32
    MOVK  X25, #0xb41, LSL #48
    SUB  X17, X25, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, D19
    MOVZ  X25, #0x7d89, LSL #0
    MOVK  X25, #0xf5e8, LSL #16
    MOVK  X25, #0x6e19, LSL #32
    MOVK  X25, #0x48b4, LSL #48
    SUB  X17, X25, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X2, #0xbde5, LSL #0
    MOVK  X2, #0xd3c6, LSL #16
    MOVK  X2, #0x4827, LSL #32
    MOVK  X2, #0x3d44, LSL #48
    SUB  X21, X2, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, D20
    MOVZ  X2, #0xabad, LSL #0
    MOVK  X2, #0xc971, LSL #16
    MOVK  X2, #0x76e7, LSL #32
    MOVK  X2, #0x1a2e, LSL #48
    SUB  X21, X2, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X19, #0x2e21, LSL #0
    MOVK  X19, #0xd783, LSL #16
    MOVK  X19, #0xa809, LSL #32
    MOVK  X19, #0xa7a7, LSL #48
    SUB  X26, X19, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, D21
    MOVZ  X19, #0xfed2, LSL #0
    MOVK  X19, #0x1642, LSL #16
    MOVK  X19, #0xf7d4, LSL #32
    MOVK  X19, #0x3c75, LSL #48
    SUB  X26, X19, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X7, #0xefd8, LSL #0
    MOVK  X7, #0xaa44, LSL #16
    MOVK  X7, #0x6746, LSL #32
    MOVK  X7, #0x92f6, LSL #48
    SUB  X9, X7, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, D23
    MOVZ  X7, #0x31b0, LSL #0
    MOVK  X7, #0xa06f, LSL #16
    MOVK  X7, #0x2efd, LSL #32
    MOVK  X7, #0xc862, LSL #48
    SUB  X9, X7, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X29, #0x6371, LSL #0
    MOVK  X29, #0x33c4, LSL #16
    MOVK  X29, #0x8186, LSL #32
    MOVK  X29, #0xfc96, LSL #48
    SUB  X3, X29, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, D24
    MOVZ  X29, #0xf840, LSL #0
    MOVK  X29, #0x9dc8, LSL #16
    MOVK  X29, #0x6853, LSL #32
    MOVK  X29, #0xf780, LSL #48
    SUB  X3, X29, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, D25
    MOVZ  X29, #0x850e, LSL #0
    MOVK  X29, #0xf911, LSL #16
    SUB  X5, X29, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, V26.D[1]
    MOVZ  X7, #0xdcf1, LSL #0
    MOVK  X7, #0x77dc, LSL #16
    MOVK  X7, #0x6520, LSL #32
    MOVK  X7, #0x6aa7, LSL #48
    SUB  X18, X7, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X25, D26
    MOVZ  X7, #0x86cc, LSL #0
    MOVK  X7, #0x7847, LSL #16
    MOVK  X7, #0x2997, LSL #32
    MOVK  X7, #0x287a, LSL #48
    SUB  X18, X7, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X26, #0xa49f, LSL #0
    MOVK  X26, #0xd7c0, LSL #16
    MOVK  X26, #0xdaaa, LSL #32
    MOVK  X26, #0x1649, LSL #48
    SUB  X7, X26, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, D27
    MOVZ  X26, #0xea77, LSL #0
    MOVK  X26, #0xe814, LSL #16
    MOVK  X26, #0x582e, LSL #32
    MOVK  X26, #0x3b60, LSL #48
    SUB  X7, X26, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X14, #0x3b9f, LSL #0
    MOVK  X14, #0xd08, LSL #16
    MOVK  X14, #0xe267, LSL #32
    MOVK  X14, #0xd45f, LSL #48
    SUB  X10, X14, X3
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, D28
    MOVZ  X14, #0xfc95, LSL #0
    MOVK  X14, #0xd48d, LSL #16
    MOVK  X14, #0xbb0e, LSL #32
    MOVK  X14, #0xfc15, LSL #48
    SUB  X10, X14, X3
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X26, #0xaa1e, LSL #0
    MOVK  X26, #0x84b9, LSL #16
    MOVK  X26, #0x88af, LSL #32
    MOVK  X26, #0xdd44, LSL #48
    SUB  X11, X26, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, D29
    MOVZ  X26, #0x58c8, LSL #0
    MOVK  X26, #0xf475, LSL #16
    MOVK  X26, #0x8755, LSL #32
    MOVK  X26, #0xb1bb, LSL #48
    SUB  X11, X26, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
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
    FMOV  D0, X21
    FMOV  V0.D[1], X9
    FMOV  D1, X29
    FMOV  V1.D[1], X6
    FMOV  D2, X28
    FMOV  V2.D[1], X2
    FMOV  D3, X20
    FMOV  V3.D[1], X26
    FMOV  D4, X14
    FMOV  V4.D[1], X15
    FMOV  D5, X14
    FMOV  V5.D[1], X9
    FMOV  D6, X12
    FMOV  V6.D[1], X25
    FMOV  D7, X4
    FMOV  V7.D[1], X4
    FMOV  D8, X8
    FMOV  V8.D[1], X17
    FMOV  D9, X3
    FMOV  V9.D[1], X3
    FMOV  D10, X16
    FMOV  V10.D[1], X13
    FMOV  D11, X26
    FMOV  V11.D[1], X13
    FMOV  D12, X15
    FMOV  V12.D[1], X7
    FMOV  D13, X23
    FMOV  V13.D[1], X9
    FMOV  D14, X20
    FMOV  V14.D[1], X18
    FMOV  D15, X20
    FMOV  V15.D[1], X9
    FMOV  D16, X27
    FMOV  V16.D[1], X26
    FMOV  D17, X2
    FMOV  V17.D[1], X3
    FMOV  D18, X5
    FMOV  V18.D[1], X21
    FMOV  D19, X23
    FMOV  V19.D[1], X17
    FMOV  D20, X2
    FMOV  V20.D[1], X17
    FMOV  D21, X3
    FMOV  V21.D[1], X3
    FMOV  D22, X26
    FMOV  V22.D[1], X5
    FMOV  D23, X11
    FMOV  V23.D[1], X15
    FMOV  D24, X5
    FMOV  V24.D[1], X20
    FMOV  D25, X19
    FMOV  V25.D[1], X2
    FMOV  D26, X27
    FMOV  V26.D[1], X20
    FMOV  D27, X25
    FMOV  V27.D[1], X2
    FMOV  D28, X14
    FMOV  V28.D[1], X24
    FMOV  D29, X18
    FMOV  V29.D[1], X8
    FMOV  D30, X7
    FMOV  V30.D[1], X10
    FMOV  D31, X14
    FMOV  V31.D[1], X17
    MOVZ  X15, #0xf, LSL #0
TaishanSimdUnaryArithmeticP01_label_1394:
    SHA1SU1  V27.4S, V13.4S
    SHA1SU1  V17.4S, V2.4S
    SHA256SU0  V20.4S, V22.4S
    SHA1M  Q10, S28, V30.4S
    SHA1P  Q3, S27, V6.4S
    SHA256SU0  V23.4S, V13.4S
    SHA1P  Q18, S21, V19.4S
    SHA1C  Q15, S12, V29.4S
    SHA1SU0  V11.4S, V17.4S, V30.4S
    SHA1P  Q31, S31, V15.4S
    SHA1C  Q15, S27, V26.4S
    AESD  V24.16B, V2.16B
    SHA1SU0  V0.4S, V8.4S, V21.4S
    SHA256SU0  V26.4S, V30.4S
    AESD  V11.16B, V15.16B
    SHA1C  Q27, S26, V0.4S
    SHA1M  Q4, S15, V24.4S
    SHA1C  Q15, S0, V29.4S
    AESMC  V26.16B, V22.16B
    AESE  V11.16B, V19.16B
    SHA256H2  Q19, Q12, V12.4S
    AESIMC  V26.16B, V12.16B
    SHA1SU0  V27.4S, V6.4S, V29.4S
    SHA1H  S3, S4
    SHA256H  Q2, Q31, V0.4S
    SHA256SU1  V19.4S, V22.4S, V6.4S
    SHA256H2  Q27, Q25, V11.4S
    SHA1M  Q18, S13, V20.4S
    SHA256SU0  V7.4S, V18.4S
    AESMC  V31.16B, V18.16B
    SHA256SU0  V28.4S, V7.4S
    SHA1M  Q6, S0, V12.4S
    SHA1H  S19, S9
    SHA1H  S4, S15
    SHA1H  S15, S25
    SHA1SU1  V24.4S, V8.4S
    AESD  V6.16B, V31.16B
    SHA1M  Q8, S20, V27.4S
    SHA1SU0  V29.4S, V31.4S, V18.4S
    AESIMC  V28.16B, V9.16B
    SHA256SU0  V24.4S, V28.4S
    SHA1H  S25, S16
    SHA256H2  Q5, Q11, V2.4S
    SHA256H2  Q7, Q12, V20.4S
    SHA256H2  Q26, Q23, V21.4S
    AESD  V5.16B, V18.16B
    SHA256SU0  V20.4S, V25.4S
    SHA256SU1  V8.4S, V29.4S, V5.4S
    SHA1M  Q14, S2, V10.4S
    AESIMC  V4.16B, V14.16B
    SHA1P  Q18, S2, V1.4S
    SHA256SU0  V6.4S, V23.4S
    SHA1H  S28, S23
    SHA1C  Q7, S28, V6.4S
    AESD  V21.16B, V8.16B
    SHA256SU1  V27.4S, V24.4S, V5.4S
    SHA256SU0  V20.4S, V20.4S
    SHA1SU0  V26.4S, V2.4S, V30.4S
    SHA256SU1  V5.4S, V18.4S, V31.4S
    SHA1H  S18, S31
    SHA1SU1  V31.4S, V10.4S
    SHA1SU0  V5.4S, V27.4S, V4.4S
    SHA1SU1  V5.4S, V18.4S
    AESE  V11.16B, V3.16B
    SHA1H  S7, S16
    SHA1M  Q7, S1, V8.4S
    SHA256H  Q15, Q27, V5.4S
    AESD  V11.16B, V24.16B
    SHA1M  Q18, S15, V3.4S
    AESIMC  V23.16B, V26.16B
    SHA1SU1  V20.4S, V26.4S
    SHA256SU1  V7.4S, V3.4S, V9.4S
    SHA256H  Q7, Q17, V30.4S
    AESD  V30.16B, V12.16B
    AESMC  V1.16B, V6.16B
    SHA1M  Q31, S1, V27.4S
    AESMC  V23.16B, V4.16B
    AESE  V8.16B, V28.16B
    SHA256H2  Q26, Q5, V15.4S
    AESIMC  V31.16B, V24.16B
    SHA1P  Q9, S14, V2.4S
    AESMC  V25.16B, V16.16B
    SHA256H  Q7, Q15, V5.4S
    SHA1SU0  V13.4S, V12.4S, V28.4S
    SHA1C  Q13, S4, V27.4S
    SHA256SU0  V18.4S, V1.4S
    AESD  V26.16B, V6.16B
    AESD  V6.16B, V19.16B
    SHA256SU0  V31.4S, V29.4S
    AESMC  V17.16B, V23.16B
    SHA256H2  Q21, Q27, V29.4S
    SHA1C  Q26, S20, V6.4S
    SHA1SU1  V14.4S, V31.4S
    SHA1SU1  V8.4S, V19.4S
    SHA1SU0  V6.4S, V2.4S, V9.4S
    SHA256SU0  V3.4S, V18.4S
    AESD  V5.16B, V20.16B
    SHA256SU1  V17.4S, V8.4S, V31.4S
    SHA1SU1  V11.4S, V9.4S
    SHA1M  Q28, S19, V3.4S
    AESIMC  V0.16B, V8.16B
    SHA1C  Q7, S9, V24.4S
    SHA1H  S4, S13
    AESMC  V1.16B, V10.16B
    SHA256H  Q19, Q23, V29.4S
    AESIMC  V24.16B, V14.16B
    SHA256SU1  V6.4S, V2.4S, V14.4S
    AESE  V5.16B, V13.16B
    SHA1SU1  V11.4S, V1.4S
    SHA256H2  Q17, Q28, V31.4S
    SHA1SU1  V25.4S, V28.4S
    SHA1SU0  V2.4S, V21.4S, V18.4S
    SHA1SU0  V13.4S, V23.4S, V25.4S
    AESD  V0.16B, V0.16B
    SHA1H  S19, S0
    SHA256H  Q24, Q20, V3.4S
    SHA256H  Q28, Q9, V13.4S
    SHA1M  Q25, S2, V24.4S
    SHA256H  Q10, Q22, V26.4S
    SHA256H2  Q3, Q5, V6.4S
    AESD  V16.16B, V26.16B
    SHA1SU1  V10.4S, V13.4S
    SHA1M  Q24, S20, V12.4S
    SHA1M  Q10, S14, V2.4S
    SHA256H  Q13, Q15, V29.4S
    SHA256SU1  V13.4S, V22.4S, V3.4S
    SHA1M  Q7, S8, V11.4S
    SHA256SU1  V7.4S, V9.4S, V0.4S
    SHA256SU0  V9.4S, V24.4S
    AESE  V18.16B, V0.16B
    AESMC  V15.16B, V31.16B
    SHA256H  Q28, Q24, V1.4S
    AESIMC  V19.16B, V22.16B
    SHA256H  Q25, Q23, V17.4S
    AESE  V12.16B, V7.16B
    SHA256SU1  V31.4S, V10.4S, V15.4S
    AESD  V24.16B, V18.16B
    SHA1H  S28, S14
    AESE  V21.16B, V29.16B
    AESE  V15.16B, V31.16B
    SHA256H2  Q2, Q5, V4.4S
    AESMC  V31.16B, V16.16B
    AESE  V10.16B, V7.16B
    SHA1SU0  V28.4S, V18.4S, V11.4S
    SHA1SU0  V24.4S, V12.4S, V16.4S
    SHA1SU1  V1.4S, V30.4S
    AESIMC  V18.16B, V9.16B
    AESIMC  V22.16B, V1.16B
    AESE  V28.16B, V10.16B
    AESD  V19.16B, V8.16B
    AESD  V13.16B, V29.16B
    AESMC  V7.16B, V8.16B
    SHA1M  Q10, S17, V23.4S
    SHA1SU0  V25.4S, V28.4S, V11.4S
    SHA1SU0  V31.4S, V30.4S, V0.4S
    SHA1C  Q12, S24, V9.4S
    AESE  V16.16B, V15.16B
    SHA256H2  Q26, Q18, V13.4S
    AESE  V25.16B, V15.16B
    SHA256H  Q13, Q1, V31.4S
    SHA1C  Q12, S0, V18.4S
    AESD  V14.16B, V18.16B
    SHA256SU0  V21.4S, V11.4S
    SHA1H  S7, S14
    SHA1C  Q21, S2, V4.4S
    AESIMC  V11.16B, V26.16B
    SHA1P  Q18, S21, V9.4S
    SHA1C  Q11, S8, V13.4S
    SHA1P  Q28, S0, V4.4S
    AESD  V12.16B, V25.16B
    AESE  V13.16B, V29.16B
    AESMC  V15.16B, V22.16B
    SHA256H2  Q27, Q13, V25.4S
    SHA256SU0  V27.4S, V30.4S
    AESE  V22.16B, V31.16B
    SHA1C  Q14, S18, V3.4S
    SHA1SU0  V25.4S, V30.4S, V12.4S
    SHA256H  Q11, Q28, V3.4S
    AESIMC  V19.16B, V11.16B
    SHA1SU0  V10.4S, V28.4S, V27.4S
    SHA1C  Q20, S22, V2.4S
    SHA256SU0  V7.4S, V19.4S
    AESE  V15.16B, V30.16B
    SHA1SU1  V5.4S, V12.4S
    SHA256SU0  V14.4S, V20.4S
    SHA256H  Q15, Q6, V11.4S
    SHA256SU1  V20.4S, V22.4S, V5.4S
    AESIMC  V3.16B, V26.16B
    SHA1C  Q12, S28, V10.4S
    AESMC  V5.16B, V6.16B
    AESE  V21.16B, V27.16B
    SHA256H2  Q4, Q11, V2.4S
    AESMC  V8.16B, V12.16B
    SHA256H2  Q17, Q2, V3.4S
    SHA1H  S13, S5
    SHA256H2  Q25, Q19, V11.4S
    SHA1C  Q31, S12, V1.4S
    SHA1C  Q12, S29, V3.4S
    SHA1P  Q4, S27, V0.4S
    AESE  V17.16B, V18.16B
    SUBS  X15, X15, #0x1
    B.NE  TaishanSimdUnaryArithmeticP01_label_1394
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X18, X2, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X24, X4, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X24, X25, X4
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X7, X6, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X11, X18, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X7
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X11, X29, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X27, X4, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X6, X9, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X11
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X2, X3, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X17, X24, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X7, X4, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X4, X25, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X17
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X24, X11, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X29, X20, X19
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X4, X10, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X11, X8, X23
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X28, X13, X26
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X9, X21, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X24, #0x9206, LSL #0
    MOVK  X24, #0x9a33, LSL #16
    MOVK  X24, #0x49be, LSL #32
    MOVK  X24, #0x1315, LSL #48
    SUB  X4, X24, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, D2
    MOVZ  X24, #0x1ec2, LSL #0
    MOVK  X24, #0x8473, LSL #16
    MOVK  X24, #0x8c95, LSL #32
    MOVK  X24, #0x1354, LSL #48
    SUB  X4, X24, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X24, #0xff4, LSL #0
    MOVK  X24, #0x22bb, LSL #16
    MOVK  X24, #0x502d, LSL #32
    MOVK  X24, #0x114b, LSL #48
    SUB  X7, X24, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, D3
    MOVZ  X24, #0x1148, LSL #0
    MOVK  X24, #0x4787, LSL #16
    MOVK  X24, #0x6149, LSL #32
    MOVK  X24, #0x926d, LSL #48
    SUB  X7, X24, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X2, #0x1758, LSL #0
    MOVK  X2, #0x8993, LSL #16
    MOVK  X2, #0x9215, LSL #32
    MOVK  X2, #0x7ca4, LSL #48
    SUB  X21, X2, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, D4
    MOVZ  X2, #0xf14d, LSL #0
    MOVK  X2, #0x3ecf, LSL #16
    MOVK  X2, #0xe732, LSL #32
TaishanSimdUnaryArithmeticP01_label_791:
    MOVK  X2, #0x9d2a, LSL #48
    SUB  X21, X2, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X14, #0x1107, LSL #0
    MOVK  X14, #0x5522, LSL #16
    MOVK  X14, #0xab6d, LSL #32
    MOVK  X14, #0xf6e7, LSL #48
    SUB  X19, X14, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, D5
    MOVZ  X14, #0xce47, LSL #0
    MOVK  X14, #0xe00f, LSL #16
    MOVK  X14, #0x59e0, LSL #32
    MOVK  X14, #0x747e, LSL #48
    SUB  X19, X14, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X9, #0x38fb, LSL #0
    MOVK  X9, #0xbe1c, LSL #16
    MOVK  X9, #0x69d1, LSL #32
    MOVK  X9, #0x81ee, LSL #48
    SUB  X18, X9, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, D6
    MOVZ  X9, #0x940e, LSL #0
    MOVK  X9, #0x768a, LSL #16
    MOVK  X9, #0xff9b, LSL #32
    MOVK  X9, #0xaf78, LSL #48
    SUB  X18, X9, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x8dc4, LSL #32
    MOVK  X18, #0xedb4, LSL #48
    SUB  X5, X18, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, D7
    MOVZ  X18, #0xfcc5, LSL #0
    MOVK  X18, #0x295c, LSL #16
    SUB  X5, X18, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, V8.D[1]
    MOVZ  X29, #0xece0, LSL #0
    MOVK  X29, #0x43c6, LSL #16
    MOVK  X29, #0xe6f4, LSL #32
    MOVK  X29, #0xc968, LSL #48
    SUB  X9, X29, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, D8
    MOVZ  X29, #0x708, LSL #0
    MOVK  X29, #0x3941, LSL #16
    MOVK  X29, #0xb829, LSL #32
    MOVK  X29, #0x3497, LSL #48
    SUB  X9, X29, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, V9.D[1]
    MOVZ  X24, #0xc640, LSL #0
    MOVK  X24, #0x345a, LSL #16
    MOVK  X24, #0x3e3e, LSL #32
    MOVK  X24, #0x5b6a, LSL #48
    SUB  X2, X24, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, D9
    MOVZ  X24, #0xde44, LSL #0
    MOVK  X24, #0xa245, LSL #16
    MOVK  X24, #0xd2bc, LSL #32
    MOVK  X24, #0x9744, LSL #48
    SUB  X2, X24, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X7, #0x62f9, LSL #0
    MOVK  X7, #0x110d, LSL #16
    MOVK  X7, #0x3f5b, LSL #32
    MOVK  X7, #0x6cc0, LSL #48
    SUB  X27, X7, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, D10
    MOVZ  X7, #0x46e, LSL #0
    MOVK  X7, #0x6ca2, LSL #16
    MOVK  X7, #0x575b, LSL #32
    MOVK  X7, #0xee9c, LSL #48
    SUB  X27, X7, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X17, #0xf7ea, LSL #0
    MOVK  X17, #0x6cdc, LSL #16
    MOVK  X17, #0xa635, LSL #32
    MOVK  X17, #0x6d9a, LSL #48
    SUB  X23, X17, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, D11
    MOVZ  X17, #0xce5c, LSL #0
    MOVK  X17, #0xa806, LSL #16
    MOVK  X17, #0xf7ff, LSL #32
    MOVK  X17, #0xa518, LSL #48
    SUB  X23, X17, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X24, #0xec4d, LSL #0
    MOVK  X24, #0xda9b, LSL #16
    MOVK  X24, #0xd25f, LSL #32
    MOVK  X24, #0xae17, LSL #48
    SUB  X2, X24, X13
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, D12
    MOVZ  X24, #0xdf0c, LSL #0
    MOVK  X24, #0x99af, LSL #16
    MOVK  X24, #0xed21, LSL #32
    MOVK  X24, #0x7f0e, LSL #48
    SUB  X2, X24, X13
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, V13.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, D13
    MOVZ  X16, #0xf391, LSL #0
    MOVK  X16, #0xf803, LSL #16
    SUB  X9, X16, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, V14.D[1]
    MOVZ  X20, #0x31da, LSL #0
    MOVK  X20, #0x4ff4, LSL #16
    MOVK  X20, #0xf434, LSL #32
    MOVK  X20, #0x908e, LSL #48
    SUB  X25, X20, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, D14
    MOVZ  X20, #0xf3db, LSL #0
    MOVK  X20, #0x5782, LSL #16
    MOVK  X20, #0x57a9, LSL #32
    MOVK  X20, #0x26ed, LSL #48
    SUB  X25, X20, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, V15.D[1]
    MOVZ  X24, #0xff18, LSL #0
    MOVK  X24, #0x8441, LSL #16
    MOVK  X24, #0x1746, LSL #32
    MOVK  X24, #0x1e32, LSL #48
    SUB  X2, X24, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, D15
    MOVZ  X24, #0x2351, LSL #0
    MOVK  X24, #0xa722, LSL #16
    MOVK  X24, #0x9a24, LSL #32
    MOVK  X24, #0xc893, LSL #48
    SUB  X2, X24, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X24, #0x6427, LSL #0
    MOVK  X24, #0x8858, LSL #16
    MOVK  X24, #0x9213, LSL #32
    MOVK  X24, #0x1911, LSL #48
    SUB  X12, X24, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, D16
    MOVZ  X24, #0xf6c1, LSL #0
    MOVK  X24, #0xf95b, LSL #16
    MOVK  X24, #0x172f, LSL #32
    MOVK  X24, #0xc005, LSL #48
    SUB  X12, X24, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X28, #0xcec6, LSL #0
    MOVK  X28, #0x803d, LSL #16
    MOVK  X28, #0xda29, LSL #32
    MOVK  X28, #0x1b97, LSL #48
    SUB  X29, X28, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, D17
    MOVZ  X28, #0x4796, LSL #0
    MOVK  X28, #0x59cf, LSL #16
    MOVK  X28, #0x6b96, LSL #32
    MOVK  X28, #0xdc9e, LSL #48
    SUB  X29, X28, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, V18.D[1]
    MOVZ  X28, #0x5b65, LSL #0
    MOVK  X28, #0xb084, LSL #16
    MOVK  X28, #0x77c7, LSL #32
    MOVK  X28, #0xc2c1, LSL #48
    SUB  X25, X28, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, D18
    MOVZ  X28, #0x21b5, LSL #0
    MOVK  X28, #0x2340, LSL #16
    MOVK  X28, #0xa7f7, LSL #32
    MOVK  X28, #0x801b, LSL #48
    SUB  X25, X28, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X15, #0x49ba, LSL #0
    MOVK  X15, #0x93cd, LSL #16
    MOVK  X15, #0xb6eb, LSL #32
    MOVK  X15, #0xb58c, LSL #48
    SUB  X11, X15, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, D19
TaishanSimdUnaryArithmeticP01_label_99:
    MOVZ  X15, #0x1d7, LSL #0
    MOVK  X15, #0x1ff5, LSL #16
    MOVK  X15, #0xb34, LSL #32
    MOVK  X15, #0x28a2, LSL #48
    SUB  X11, X15, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X13, #0x2a81, LSL #0
    MOVK  X13, #0xea68, LSL #16
    MOVK  X13, #0x5a5, LSL #32
    MOVK  X13, #0x47e9, LSL #48
    SUB  X11, X13, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, D20
    MOVZ  X13, #0x65e6, LSL #0
    MOVK  X13, #0x898b, LSL #16
    MOVK  X13, #0x4ae0, LSL #32
    MOVK  X13, #0x84ea, LSL #48
    SUB  X11, X13, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X28, #0xa376, LSL #0
    MOVK  X28, #0xc7cf, LSL #16
    MOVK  X28, #0x89ab, LSL #32
    MOVK  X28, #0x724e, LSL #48
    SUB  X18, X28, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, D21
    MOVZ  X28, #0x2f40, LSL #0
    MOVK  X28, #0xa51, LSL #16
    MOVK  X28, #0x15e5, LSL #32
    MOVK  X28, #0x5a4f, LSL #48
    SUB  X18, X28, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X25, #0xbb60, LSL #0
    MOVK  X25, #0xf30b, LSL #16
    MOVK  X25, #0x5a66, LSL #32
    MOVK  X25, #0xd455, LSL #48
    SUB  X10, X25, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, D23
    MOVZ  X25, #0x2aba, LSL #0
    MOVK  X25, #0xbe8d, LSL #16
    MOVK  X25, #0x4c62, LSL #32
    MOVK  X25, #0x3f51, LSL #48
    SUB  X10, X25, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X8, #0xd11e, LSL #0
    MOVK  X8, #0x9eb4, LSL #16
    MOVK  X8, #0x769, LSL #32
    MOVK  X8, #0x939d, LSL #48
    SUB  X4, X8, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, D24
    MOVZ  X8, #0xe0fe, LSL #0
    MOVK  X8, #0x8a73, LSL #16
    MOVK  X8, #0xf6ee, LSL #32
    MOVK  X8, #0x3f22, LSL #48
    SUB  X4, X8, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X2, #0xee30, LSL #0
    MOVK  X2, #0xafbd, LSL #16
    MOVK  X2, #0xf4dc, LSL #32
    MOVK  X2, #0x34f0, LSL #48
    SUB  X21, X2, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D25
    MOVZ  X2, #0xea79, LSL #0
    MOVK  X2, #0x48ac, LSL #16
    MOVK  X2, #0xc03f, LSL #32
    MOVK  X2, #0xe8e5, LSL #48
    SUB  X21, X2, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X4, #0x1e7b, LSL #0
    MOVK  X4, #0xf7f0, LSL #16
    MOVK  X4, #0x41f0, LSL #32
    MOVK  X4, #0x4ed8, LSL #48
    SUB  X19, X4, X10
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X10, D26
    MOVZ  X4, #0xbf63, LSL #0
    MOVK  X4, #0xc085, LSL #16
    MOVK  X4, #0xaece, LSL #32
    MOVK  X4, #0xe85f, LSL #48
    SUB  X19, X4, X10
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X26, #0x7dbe, LSL #0
    MOVK  X26, #0x58bb, LSL #16
    MOVK  X26, #0xf70f, LSL #32
    MOVK  X26, #0x62d0, LSL #48
    SUB  X13, X26, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D27
    MOVZ  X26, #0xb91b, LSL #0
    MOVK  X26, #0x6464, LSL #16
    MOVK  X26, #0x651e, LSL #32
    MOVK  X26, #0x318e, LSL #48
    SUB  X13, X26, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X5, #0x8d1a, LSL #0
    MOVK  X5, #0x58ad, LSL #16
    MOVK  X5, #0x594f, LSL #32
    MOVK  X5, #0x6a75, LSL #48
    SUB  X4, X5, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, D28
    MOVZ  X5, #0xddb1, LSL #0
    MOVK  X5, #0x672a, LSL #16
    MOVK  X5, #0x321f, LSL #32
    MOVK  X5, #0x8de2, LSL #48
    SUB  X4, X5, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, V29.D[1]
    MOVZ  X2, #0x8d7d, LSL #0
    MOVK  X2, #0xa55a, LSL #16
    MOVK  X2, #0xd1b7, LSL #32
    MOVK  X2, #0xff82, LSL #48
    SUB  X20, X2, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, D29
    MOVZ  X2, #0xe501, LSL #0
    MOVK  X2, #0xcfa3, LSL #16
    MOVK  X2, #0x1c73, LSL #32
    MOVK  X2, #0xe04d, LSL #48
    SUB  X20, X2, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X2, #0xf3b0, LSL #0
    MOVK  X2, #0x5a1a, LSL #16
    MOVK  X2, #0xad98, LSL #32
    MOVK  X2, #0xfb0f, LSL #48
    MOVZ  X3, #0x9b60, LSL #0
    MOVK  X3, #0x9e5e, LSL #16
    MOVK  X3, #0x96ab, LSL #32
    MOVK  X3, #0x7b4b, LSL #48
    MOVZ  X4, #0x3a2a, LSL #0
    MOVK  X4, #0x6de, LSL #16
    MOVK  X4, #0x8039, LSL #32
    MOVK  X4, #0x1a24, LSL #48
    MOVZ  X5, #0xfcdb, LSL #0
    MOVK  X5, #0x15bf, LSL #16
    MOVK  X5, #0x6e51, LSL #32
    MOVK  X5, #0xac06, LSL #48
    MOVZ  X6, #0x131, LSL #0
    MOVK  X6, #0xb3c3, LSL #16
    MOVK  X6, #0xc0a7, LSL #32
    MOVK  X6, #0x6f19, LSL #48
    MOVZ  X7, #0xdd83, LSL #0
    MOVK  X7, #0x8e62, LSL #16
    MOVK  X7, #0x95d6, LSL #32
    MOVK  X7, #0x5186, LSL #48
    MOVZ  X8, #0xec9d, LSL #0
    MOVK  X8, #0x4d30, LSL #16
    MOVK  X8, #0x1a62, LSL #32
    MOVK  X8, #0xdff5, LSL #48
    MOVZ  X9, #0x649c, LSL #0
    MOVK  X9, #0x90b3, LSL #16
    MOVK  X9, #0x8faa, LSL #32
    MOVK  X9, #0x2661, LSL #48
    MOVZ  X10, #0x6a0, LSL #0
    MOVK  X10, #0x688d, LSL #16
    MOVK  X10, #0x7815, LSL #32
    MOVK  X10, #0x6018, LSL #48
    MOVZ  X11, #0xd870, LSL #0
    MOVK  X11, #0xb869, LSL #16
    MOVK  X11, #0xd604, LSL #32
    MOVK  X11, #0xbe05, LSL #48
    MOVZ  X12, #0x61ac, LSL #0
    MOVK  X12, #0x3b50, LSL #16
    MOVK  X12, #0xcf16, LSL #32
    MOVK  X12, #0x532, LSL #48
    MOVZ  X13, #0x9bd4, LSL #0
    MOVK  X13, #0x4e6a, LSL #16
    MOVK  X13, #0xeac2, LSL #32
    MOVK  X13, #0xd78e, LSL #48
    MOVZ  X14, #0x464, LSL #0
    MOVK  X14, #0x8306, LSL #16
    MOVK  X14, #0x97ed, LSL #32
    MOVK  X14, #0x937d, LSL #48
    MOVZ  X15, #0x3b8f, LSL #0
    MOVK  X15, #0xa0ff, LSL #16
    MOVK  X15, #0x59f0, LSL #32
    MOVK  X15, #0xcb84, LSL #48
    MOVZ  X16, #0xed71, LSL #0
    MOVK  X16, #0x1c5a, LSL #16
    MOVK  X16, #0x68c3, LSL #32
    MOVK  X16, #0xe42b, LSL #48
    MOVZ  X17, #0xb346, LSL #0
    MOVK  X17, #0xddc3, LSL #16
    MOVK  X17, #0x6f3f, LSL #32
    MOVK  X17, #0xaf4d, LSL #48
    MOVZ  X18, #0xee8b, LSL #0
    MOVK  X18, #0x37a2, LSL #16
    MOVK  X18, #0x3d52, LSL #32
    MOVK  X18, #0xcb6e, LSL #48
    MOVZ  X19, #0xb5fd, LSL #0
    MOVK  X19, #0x1b37, LSL #16
    MOVK  X19, #0x512f, LSL #32
    MOVK  X19, #0x1368, LSL #48
    MOVZ  X20, #0xba71, LSL #0
    MOVK  X20, #0x2b74, LSL #16
    MOVK  X20, #0xc5b8, LSL #32
    MOVK  X20, #0xfa97, LSL #48
    MOVZ  X21, #0x78e5, LSL #0
    MOVK  X21, #0x3061, LSL #16
    MOVK  X21, #0xe434, LSL #32
    MOVK  X21, #0x47d4, LSL #48
    MOVZ  X23, #0xaf90, LSL #0
    MOVK  X23, #0xbe80, LSL #16
    MOVK  X23, #0x3ff9, LSL #32
    MOVK  X23, #0x2ada, LSL #48
    MOVZ  X24, #0xd58b, LSL #0
    MOVK  X24, #0x8cc8, LSL #16
    MOVK  X24, #0x1ce8, LSL #32
    MOVK  X24, #0x8310, LSL #48
    MOVZ  X25, #0x8fef, LSL #0
    MOVK  X25, #0xedda, LSL #16
    MOVK  X25, #0x6a78, LSL #32
    MOVK  X25, #0x6a6d, LSL #48
    MOVZ  X26, #0x7921, LSL #0
    MOVK  X26, #0x93fc, LSL #16
    MOVK  X26, #0x1047, LSL #32
TaishanSimdUnaryArithmeticP01_label_676:
    MOVK  X26, #0xbd0e, LSL #48
    MOVZ  X27, #0x8cad, LSL #0
    MOVK  X27, #0x25ea, LSL #16
    MOVK  X27, #0x8fa6, LSL #32
    MOVK  X27, #0xf85f, LSL #48
    MOVZ  X28, #0x3ae4, LSL #0
    MOVK  X28, #0xcfff, LSL #16
    MOVK  X28, #0x4dfb, LSL #32
    MOVK  X28, #0xf92d, LSL #48
    MOVZ  X29, #0xafed, LSL #0
    MOVK  X29, #0xcb44, LSL #16
    MOVK  X29, #0xaf02, LSL #32
    MOVK  X29, #0xd8e6, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X9
    FMOV  D1, X15
    FMOV  V1.D[1], X29
    FMOV  D2, X26
    FMOV  V2.D[1], X26
    FMOV  D3, X6
    FMOV  V3.D[1], X2
    FMOV  D4, X3
    FMOV  V4.D[1], X9
    FMOV  D5, X16
    FMOV  V5.D[1], X26
    FMOV  D6, X8
    FMOV  V6.D[1], X20
    FMOV  D7, X28
    FMOV  V7.D[1], X6
    FMOV  D8, X20
    FMOV  V8.D[1], X21
    FMOV  D9, X25
    FMOV  V9.D[1], X9
    FMOV  D10, X25
    FMOV  V10.D[1], X7
    FMOV  D11, X17
    FMOV  V11.D[1], X28
    FMOV  D12, X9
    FMOV  V12.D[1], X3
    FMOV  D13, X20
    FMOV  V13.D[1], X10
    FMOV  D14, X10
    FMOV  V14.D[1], X17
    FMOV  D15, X29
    FMOV  V15.D[1], X14
    FMOV  D16, X10
    FMOV  V16.D[1], X29
    FMOV  D17, X23
    FMOV  V17.D[1], X19
    FMOV  D18, X12
    FMOV  V18.D[1], X26
    FMOV  D19, X17
    FMOV  V19.D[1], X16
    FMOV  D20, X3
    FMOV  V20.D[1], X26
    FMOV  D21, X14
    FMOV  V21.D[1], X29
    FMOV  D22, X21
    FMOV  V22.D[1], X9
    FMOV  D23, X7
    FMOV  V23.D[1], X18
    FMOV  D24, X20
    FMOV  V24.D[1], X10
    FMOV  D25, X2
    FMOV  V25.D[1], X4
    FMOV  D26, X3
    FMOV  V26.D[1], X6
    FMOV  D27, X3
    FMOV  V27.D[1], X29
    FMOV  D28, X28
    FMOV  V28.D[1], X8
    FMOV  D29, X28
    FMOV  V29.D[1], X20
    FMOV  D30, X21
    FMOV  V30.D[1], X9
    FMOV  D31, X5
    FMOV  V31.D[1], X13
    MOVZ  X29, #0xa, LSL #0
TaishanSimdUnaryArithmeticP01_label_1476:
    SHA256H2  Q25, Q5, V30.4S
    AESE  V25.16B, V22.16B
    SHA1M  Q28, S24, V7.4S
    SHA256SU0  V15.4S, V30.4S
    SHA256H2  Q8, Q7, V21.4S
    SHA256SU1  V28.4S, V10.4S, V7.4S
    SHA256SU0  V31.4S, V16.4S
    AESE  V29.16B, V22.16B
    SHA256SU1  V19.4S, V27.4S, V6.4S
    SHA1P  Q31, S31, V23.4S
    SHA256SU0  V21.4S, V25.4S
    SHA256SU1  V18.4S, V26.4S, V1.4S
    SHA1SU0  V11.4S, V25.4S, V21.4S
    SHA1C  Q12, S3, V18.4S
    AESD  V8.16B, V23.16B
    AESD  V21.16B, V24.16B
    SHA1SU0  V30.4S, V21.4S, V8.4S
    AESD  V24.16B, V11.16B
    SHA1H  S0, S10
    SHA1P  Q10, S30, V1.4S
    SHA256SU1  V11.4S, V31.4S, V1.4S
    SHA1SU1  V28.4S, V14.4S
    AESE  V4.16B, V15.16B
    SHA256H2  Q5, Q31, V15.4S
    SHA1P  Q25, S19, V19.4S
    SHA1C  Q31, S24, V25.4S
    AESD  V9.16B, V10.16B
    SHA1C  Q18, S14, V30.4S
    SHA1C  Q21, S7, V6.4S
    SHA1SU1  V26.4S, V15.4S
    SHA256SU1  V11.4S, V11.4S, V27.4S
    SHA256SU1  V22.4S, V9.4S, V13.4S
    SHA256SU0  V23.4S, V7.4S
    SHA256SU0  V7.4S, V22.4S
    SHA256SU1  V23.4S, V18.4S, V5.4S
    SHA1C  Q14, S11, V11.4S
    SHA256SU1  V4.4S, V20.4S, V10.4S
    SHA1SU0  V27.4S, V20.4S, V26.4S
    AESE  V18.16B, V19.16B
    SHA256H  Q24, Q17, V7.4S
    SHA256H2  Q20, Q10, V13.4S
    AESIMC  V10.16B, V23.16B
    AESMC  V27.16B, V3.16B
    SHA1M  Q25, S2, V29.4S
    SHA256SU1  V12.4S, V23.4S, V22.4S
    AESE  V13.16B, V13.16B
    AESD  V14.16B, V22.16B
    SHA1SU1  V1.4S, V25.4S
    SHA256H2  Q30, Q20, V7.4S
    SHA1H  S6, S14
    SHA256SU0  V1.4S, V4.4S
    SHA1SU1  V5.4S, V17.4S
    SHA1P  Q18, S21, V11.4S
    SHA1SU0  V28.4S, V25.4S, V1.4S
    AESMC  V15.16B, V5.16B
    AESD  V22.16B, V5.16B
    SHA1C  Q3, S0, V6.4S
    AESE  V14.16B, V7.16B
    SHA1SU1  V12.4S, V5.4S
    SHA256H  Q11, Q25, V11.4S
    AESIMC  V30.16B, V13.16B
    SHA256H  Q5, Q13, V18.4S
    AESE  V24.16B, V29.16B
    AESD  V27.16B, V26.16B
    AESE  V26.16B, V26.16B
    SHA256SU1  V5.4S, V30.4S, V28.4S
    SHA1P  Q5, S23, V24.4S
    AESE  V25.16B, V0.16B
    SHA256SU1  V5.4S, V15.4S, V20.4S
    AESE  V5.16B, V13.16B
    SHA256H  Q17, Q13, V7.4S
    SHA256SU0  V22.4S, V2.4S
    SHA256H  Q18, Q25, V17.4S
    SHA1M  Q28, S0, V11.4S
    SHA1SU0  V25.4S, V24.4S, V3.4S
    AESE  V10.16B, V0.16B
    SHA1SU0  V26.4S, V22.4S, V1.4S
    AESMC  V11.16B, V3.16B
    SHA1C  Q26, S9, V7.4S
    SHA1C  Q22, S31, V20.4S
    SHA256SU1  V0.4S, V27.4S, V24.4S
    SHA1M  Q13, S9, V26.4S
    SHA1SU0  V5.4S, V2.4S, V16.4S
    AESE  V11.16B, V28.16B
    SHA1C  Q14, S16, V10.4S
    SHA1SU0  V6.4S, V23.4S, V23.4S
    SHA1M  Q13, S24, V1.4S
    SHA1C  Q28, S14, V29.4S
    SHA256SU1  V2.4S, V13.4S, V29.4S
    AESMC  V21.16B, V16.16B
    SHA256SU1  V25.4S, V17.4S, V6.4S
    SHA1SU1  V13.4S, V21.4S
    SHA256SU0  V3.4S, V21.4S
    SHA1P  Q17, S27, V17.4S
    AESE  V12.16B, V12.16B
    SHA256H  Q7, Q7, V23.4S
    AESE  V12.16B, V24.16B
    SHA256SU0  V21.4S, V25.4S
    AESD  V5.16B, V14.16B
    AESMC  V3.16B, V22.16B
    SHA1SU1  V10.4S, V12.4S
    SHA1SU1  V1.4S, V1.4S
    SHA256SU1  V30.4S, V5.4S, V11.4S
    AESIMC  V6.16B, V25.16B
    SHA1H  S9, S26
    SHA1M  Q17, S2, V27.4S
    SHA256H  Q26, Q9, V12.4S
    AESE  V13.16B, V26.16B
    SHA1SU1  V10.4S, V7.4S
    AESE  V22.16B, V7.16B
    AESD  V26.16B, V30.16B
    SHA256SU1  V3.4S, V31.4S, V9.4S
    AESIMC  V18.16B, V26.16B
    AESIMC  V7.16B, V14.16B
    SHA256SU1  V13.4S, V30.4S, V30.4S
    AESIMC  V14.16B, V19.16B
    SHA1SU1  V3.4S, V19.4S
    SHA256SU1  V7.4S, V23.4S, V5.4S
    SHA256H2  Q3, Q27, V17.4S
    AESIMC  V14.16B, V15.16B
    SHA1P  Q30, S0, V31.4S
    AESIMC  V19.16B, V18.16B
    SHA1SU0  V12.4S, V15.4S, V11.4S
    SHA1P  Q23, S13, V24.4S
    SHA1SU1  V16.4S, V8.4S
    AESD  V22.16B, V29.16B
    SHA1C  Q5, S10, V10.4S
    SHA1C  Q23, S23, V27.4S
    SHA256H  Q19, Q5, V20.4S
    AESD  V13.16B, V10.16B
    SHA256H  Q16, Q3, V30.4S
    SHA1C  Q22, S22, V6.4S
    SHA1SU0  V17.4S, V28.4S, V8.4S
    SHA1M  Q5, S4, V2.4S
    AESE  V31.16B, V19.16B
    AESIMC  V23.16B, V26.16B
    SHA1C  Q12, S12, V30.4S
    SHA1H  S31, S31
    SHA256SU0  V9.4S, V17.4S
    SHA256SU1  V17.4S, V23.4S, V3.4S
    SHA256SU0  V27.4S, V12.4S
    SHA256H2  Q23, Q16, V15.4S
    AESD  V11.16B, V31.16B
    AESD  V29.16B, V19.16B
    SHA256SU1  V31.4S, V26.4S, V26.4S
    SHA256SU0  V5.4S, V5.4S
    SHA1C  Q28, S10, V23.4S
    SHA1C  Q9, S5, V5.4S
    AESD  V27.16B, V27.16B
    SHA1M  Q6, S19, V31.4S
    SHA1P  Q28, S5, V16.4S
    SHA1SU1  V0.4S, V30.4S
    SHA1H  S2, S3
    SHA256H  Q19, Q23, V9.4S
    SHA1SU1  V12.4S, V31.4S
    SHA256H2  Q10, Q0, V8.4S
    SHA1SU0  V29.4S, V12.4S, V19.4S
    AESD  V29.16B, V28.16B
    AESD  V27.16B, V10.16B
    SHA1P  Q0, S29, V18.4S
    SHA1P  Q4, S11, V22.4S
    SHA1SU0  V20.4S, V6.4S, V16.4S
    SHA1H  S24, S2
    AESMC  V24.16B, V11.16B
    SHA256H2  Q16, Q26, V1.4S
    AESE  V23.16B, V0.16B
    SHA256H  Q16, Q13, V15.4S
    SHA1P  Q17, S2, V23.4S
    SHA256H  Q12, Q24, V7.4S
    SHA1P  Q12, S11, V25.4S
    SHA1SU0  V8.4S, V13.4S, V12.4S
    SHA256H  Q24, Q26, V8.4S
    SHA1H  S18, S0
    SHA1SU1  V6.4S, V29.4S
    AESIMC  V15.16B, V13.16B
    SHA1C  Q5, S17, V24.4S
    SHA256SU1  V9.4S, V17.4S, V3.4S
    SHA1SU1  V15.4S, V13.4S
    AESD  V15.16B, V12.16B
    SHA1SU0  V26.4S, V16.4S, V2.4S
    SHA256SU1  V2.4S, V15.4S, V15.4S
    SHA256SU0  V25.4S, V10.4S
    AESE  V12.16B, V10.16B
    SHA1P  Q14, S13, V31.4S
    AESD  V23.16B, V16.16B
    SHA1C  Q26, S16, V0.4S
    AESE  V10.16B, V23.16B
    SHA1M  Q15, S14, V24.4S
    SHA1SU0  V28.4S, V12.4S, V13.4S
    SHA1SU0  V5.4S, V20.4S, V30.4S
    AESMC  V1.16B, V30.16B
    SHA1C  Q29, S13, V2.4S
    AESE  V26.16B, V9.16B
    AESMC  V0.16B, V20.16B
    SHA1C  Q12, S19, V9.4S
    SHA256H  Q0, Q8, V26.4S
    SHA256SU1  V31.4S, V4.4S, V0.4S
    SHA256H2  Q27, Q4, V21.4S
    AESIMC  V27.16B, V6.16B
    AESMC  V18.16B, V24.16B
    SUBS  X29, X29, #0x1
    B.NE  TaishanSimdUnaryArithmeticP01_label_1476
    MOVZ  X23, #0xf3b0, LSL #0
    MOVK  X23, #0x5a1a, LSL #16
    MOVK  X23, #0xad98, LSL #32
    MOVK  X23, #0xfb0f, LSL #48
    SUB  X4, X23, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X27, #0x9b60, LSL #0
    MOVK  X27, #0x9e5e, LSL #16
    MOVK  X27, #0x96ab, LSL #32
    MOVK  X27, #0x7b4b, LSL #48
    SUB  X8, X27, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X17, #0xfcdb, LSL #0
    MOVK  X17, #0x15bf, LSL #16
    MOVK  X17, #0x6e51, LSL #32
    MOVK  X17, #0xac06, LSL #48
    SUB  X8, X17, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X2, #0x131, LSL #0
    MOVK  X2, #0xb3c3, LSL #16
    MOVK  X2, #0xc0a7, LSL #32
    MOVK  X2, #0x6f19, LSL #48
    SUB  X13, X2, X6
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X10, #0xdd83, LSL #0
    MOVK  X10, #0x8e62, LSL #16
    MOVK  X10, #0x95d6, LSL #32
    MOVK  X10, #0x5186, LSL #48
    SUB  X23, X10, X7
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X21, X10, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X19, #0x649c, LSL #0
    MOVK  X19, #0x90b3, LSL #16
    MOVK  X19, #0x8faa, LSL #32
    MOVK  X19, #0x2661, LSL #48
    SUB  X25, X19, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X29, X4, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X20, #0xd870, LSL #0
    MOVK  X20, #0xb869, LSL #16
    MOVK  X20, #0xd604, LSL #32
    MOVK  X20, #0xbe05, LSL #48
    SUB  X6, X20, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X11, #0x61ac, LSL #0
    MOVK  X11, #0x3b50, LSL #16
    MOVK  X11, #0xcf16, LSL #32
    MOVK  X11, #0x532, LSL #48
    SUB  X15, X11, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X11, #0x464, LSL #0
    MOVK  X11, #0x8306, LSL #16
    MOVK  X11, #0x97ed, LSL #32
    MOVK  X11, #0x937d, LSL #48
    SUB  X13, X11, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X15
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X29, #0xed71, LSL #0
    MOVK  X29, #0x1c5a, LSL #16
    MOVK  X29, #0x68c3, LSL #32
    MOVK  X29, #0xe42b, LSL #48
    SUB  X20, X29, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X3, #0xee8b, LSL #0
    MOVK  X3, #0x37a2, LSL #16
    MOVK  X3, #0x3d52, LSL #32
    MOVK  X3, #0xcb6e, LSL #48
    SUB  X11, X3, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X26, #0x649c, LSL #0
    MOVK  X26, #0x90b3, LSL #16
    MOVK  X26, #0x8faa, LSL #32
    MOVK  X26, #0x2661, LSL #48
    SUB  X24, X26, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X20
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X18, #0x649c, LSL #0
    MOVK  X18, #0x90b3, LSL #16
    MOVK  X18, #0x8faa, LSL #32
    MOVK  X18, #0x2661, LSL #48
    SUB  X2, X18, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X24, #0x9b60, LSL #0
    MOVK  X24, #0x9e5e, LSL #16
    MOVK  X24, #0x96ab, LSL #32
    MOVK  X24, #0x7b4b, LSL #48
    SUB  X5, X24, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X28, #0x3ae4, LSL #0
    MOVK  X28, #0xcfff, LSL #16
    MOVK  X28, #0x4dfb, LSL #32
    MOVK  X28, #0xf92d, LSL #48
    SUB  X4, X28, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X26, X4, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X26, #0xbdff, LSL #0
    MOVK  X26, #0xfc30, LSL #16
    MOVK  X26, #0x6e50, LSL #32
    MOVK  X26, #0xe466, LSL #48
    SUB  X21, X26, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, D2
    MOVZ  X26, #0x425d, LSL #0
    MOVK  X26, #0x7603, LSL #16
    MOVK  X26, #0x19f9, LSL #32
    MOVK  X26, #0xd610, LSL #48
    SUB  X21, X26, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, V3.D[1]
    MOVZ  X2, #0xda6, LSL #0
    MOVK  X2, #0x7578, LSL #16
    MOVK  X2, #0x1827, LSL #32
    MOVK  X2, #0x6005, LSL #48
    SUB  X15, X2, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, D3
    MOVZ  X2, #0x6369, LSL #0
    MOVK  X2, #0xb96b, LSL #16
    MOVK  X2, #0xbf94, LSL #32
    MOVK  X2, #0xece1, LSL #48
    SUB  X15, X2, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X23, #0xe1f3, LSL #0
    MOVK  X23, #0xfb61, LSL #16
    MOVK  X23, #0xa8be, LSL #32
    MOVK  X23, #0x26b5, LSL #48
    SUB  X27, X23, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, D4
    MOVZ  X23, #0xf78d, LSL #0
    MOVK  X23, #0xe276, LSL #16
    MOVK  X23, #0xd096, LSL #32
    MOVK  X23, #0xe7a3, LSL #48
    SUB  X27, X23, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X7, #0xb4d5, LSL #0
    MOVK  X7, #0x78ab, LSL #16
    MOVK  X7, #0x1a40, LSL #32
    MOVK  X7, #0x9444, LSL #48
    SUB  X15, X7, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, D5
    MOVZ  X7, #0x2d2c, LSL #0
    MOVK  X7, #0xeb8a, LSL #16
    MOVK  X7, #0x53fd, LSL #32
    MOVK  X7, #0x8688, LSL #48
    SUB  X15, X7, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, V6.D[1]
    MOVZ  X24, #0x2b, LSL #0
    MOVK  X24, #0xe19a, LSL #16
    MOVK  X24, #0x3933, LSL #32
    MOVK  X24, #0x6128, LSL #48
    SUB  X15, X24, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, D6
    MOVZ  X24, #0x83d7, LSL #0
    MOVK  X24, #0x4476, LSL #16
    MOVK  X24, #0xf23c, LSL #32
    MOVK  X24, #0xf44a, LSL #48
    SUB  X15, X24, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
TaishanSimdUnaryArithmeticP01_label_389:
    FMOV  X17, V7.D[1]
    MOVZ  X10, #0x7ab, LSL #0
    MOVK  X10, #0x6de2, LSL #16
    MOVK  X10, #0x5fae, LSL #32
    MOVK  X10, #0x660d, LSL #48
    SUB  X19, X10, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, D7
    MOVZ  X10, #0xde47, LSL #0
    MOVK  X10, #0x76cf, LSL #16
    MOVK  X10, #0xbf14, LSL #32
    MOVK  X10, #0x146f, LSL #48
    SUB  X19, X10, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, V8.D[1]
    MOVZ  X6, #0x7c6c, LSL #0
    MOVK  X6, #0xfae3, LSL #16
    MOVK  X6, #0xeb80, LSL #32
    MOVK  X6, #0xe9c3, LSL #48
    SUB  X14, X6, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, D8
    MOVZ  X6, #0xb991, LSL #0
    MOVK  X6, #0x108b, LSL #16
    MOVK  X6, #0xe31b, LSL #32
    MOVK  X6, #0xd2f4, LSL #48
    SUB  X14, X6, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, V9.D[1]
    MOVZ  X23, #0x538c, LSL #0
    MOVK  X23, #0x4cb5, LSL #16
    MOVK  X23, #0xbde2, LSL #32
    MOVK  X23, #0x8b6b, LSL #48
    SUB  X14, X23, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, D9
    MOVZ  X23, #0x2581, LSL #0
    MOVK  X23, #0x4353, LSL #16
    MOVK  X23, #0x665d, LSL #32
    MOVK  X23, #0x280, LSL #48
    SUB  X14, X23, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, V10.D[1]
    MOVZ  X7, #0xbddf, LSL #0
    MOVK  X7, #0x92ef, LSL #16
    MOVK  X7, #0xba90, LSL #32
    MOVK  X7, #0xc1ca, LSL #48
    SUB  X20, X7, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, D10
    MOVZ  X7, #0x39de, LSL #0
    MOVK  X7, #0x13dc, LSL #16
    MOVK  X7, #0x4421, LSL #32
    MOVK  X7, #0x7ccd, LSL #48
    SUB  X20, X7, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X19, #0x2157, LSL #0
    MOVK  X19, #0xf2ef, LSL #16
    MOVK  X19, #0x3214, LSL #32
    MOVK  X19, #0x135f, LSL #48
    SUB  X21, X19, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X10, D11
    MOVZ  X19, #0x6b37, LSL #0
    MOVK  X19, #0xd128, LSL #16
    MOVK  X19, #0x6ede, LSL #32
    MOVK  X19, #0xe8d7, LSL #48
    SUB  X21, X19, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X6, #0x7717, LSL #0
    MOVK  X6, #0xc4ca, LSL #16
    MOVK  X6, #0x928c, LSL #32
    MOVK  X6, #0x218c, LSL #48
    SUB  X24, X6, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, D12
    MOVZ  X6, #0xfbd1, LSL #0
    MOVK  X6, #0x94af, LSL #16
    MOVK  X6, #0xf317, LSL #32
    MOVK  X6, #0x6645, LSL #48
    SUB  X24, X6, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, V13.D[1]
    MOVZ  X26, #0x4fd9, LSL #0
    MOVK  X26, #0xce70, LSL #16
    MOVK  X26, #0x2e86, LSL #32
    MOVK  X26, #0x9096, LSL #48
    SUB  X2, X26, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, D13
    MOVZ  X26, #0xa01, LSL #0
    MOVK  X26, #0x3bca, LSL #16
    MOVK  X26, #0x164d, LSL #32
    MOVK  X26, #0x7543, LSL #48
    SUB  X2, X26, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, V14.D[1]
    MOVZ  X6, #0x17a7, LSL #0
    MOVK  X6, #0x5ba, LSL #16
    MOVK  X6, #0xc81c, LSL #32
    MOVK  X6, #0x5aa7, LSL #48
    SUB  X25, X6, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, D14
    MOVZ  X6, #0xfcec, LSL #0
    MOVK  X6, #0x8b99, LSL #16
    MOVK  X6, #0x50b8, LSL #32
    MOVK  X6, #0x5491, LSL #48
TaishanSimdUnaryArithmeticP01_label_622:
    SUB  X25, X6, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X7, #0x1faf, LSL #0
    MOVK  X7, #0xbc4e, LSL #16
    MOVK  X7, #0x7906, LSL #32
    MOVK  X7, #0x7c40, LSL #48
    SUB  X24, X7, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D15
    MOVZ  X7, #0xaf58, LSL #0
    MOVK  X7, #0xbab8, LSL #16
    MOVK  X7, #0xf27c, LSL #32
    MOVK  X7, #0x22d7, LSL #48
    SUB  X24, X7, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, V16.D[1]
    MOVZ  X20, #0x25e7, LSL #0
    MOVK  X20, #0xa283, LSL #16
    MOVK  X20, #0x1e29, LSL #32
    MOVK  X20, #0x6e64, LSL #48
    SUB  X4, X20, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, D16
    MOVZ  X20, #0x3bca, LSL #0
    MOVK  X20, #0x691d, LSL #16
    MOVK  X20, #0xddee, LSL #32
    MOVK  X20, #0x9c4d, LSL #48
    SUB  X4, X20, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X21, #0x4823, LSL #0
    MOVK  X21, #0xd463, LSL #16
    MOVK  X21, #0xbe83, LSL #32
    MOVK  X21, #0x2e62, LSL #48
    SUB  X2, X21, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, D17
    MOVZ  X21, #0x2b12, LSL #0
    MOVK  X21, #0x7776, LSL #16
    MOVK  X21, #0xc27b, LSL #32
    MOVK  X21, #0x579c, LSL #48
    SUB  X2, X21, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X25, #0xa6c2, LSL #0
    MOVK  X25, #0x7084, LSL #16
    MOVK  X25, #0x3bf0, LSL #32
    MOVK  X25, #0x603, LSL #48
    SUB  X16, X25, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D18
    MOVZ  X25, #0x85dd, LSL #0
    MOVK  X25, #0xccbe, LSL #16
    MOVK  X25, #0x3837, LSL #32
    MOVK  X25, #0xbd8, LSL #48
    SUB  X16, X25, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X15, #0x20a3, LSL #0
    MOVK  X15, #0x8310, LSL #16
    MOVK  X15, #0x6a24, LSL #32
    MOVK  X15, #0x688e, LSL #48
    SUB  X2, X15, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, D19
    MOVZ  X15, #0xa4e7, LSL #0
    MOVK  X15, #0xe05b, LSL #16
    MOVK  X15, #0xa3b2, LSL #32
    MOVK  X15, #0x644a, LSL #48
    SUB  X2, X15, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X15, #0xe489, LSL #0
    MOVK  X15, #0x3b7c, LSL #16
    MOVK  X15, #0x7999, LSL #32
    MOVK  X15, #0x9b62, LSL #48
    SUB  X23, X15, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, D20
    MOVZ  X15, #0xf124, LSL #0
    MOVK  X15, #0x55c3, LSL #16
    MOVK  X15, #0x8188, LSL #32
    MOVK  X15, #0x7162, LSL #48
    SUB  X23, X15, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X5, #0x4209, LSL #0
    MOVK  X5, #0x704, LSL #16
    MOVK  X5, #0x8e8a, LSL #32
    MOVK  X5, #0xddcc, LSL #48
    SUB  X15, X5, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, D21
    MOVZ  X5, #0x795e, LSL #0
    MOVK  X5, #0x6037, LSL #16
    MOVK  X5, #0x1b93, LSL #32
    MOVK  X5, #0x66dc, LSL #48
    SUB  X15, X5, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, V23.D[1]
    MOVZ  X13, #0x4c3, LSL #0
    MOVK  X13, #0x7422, LSL #16
    MOVK  X13, #0xfb71, LSL #32
    MOVK  X13, #0x3795, LSL #48
    SUB  X11, X13, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X7, D23
    MOVZ  X13, #0xb0b4, LSL #0
    MOVK  X13, #0x5488, LSL #16
    MOVK  X13, #0x8b7, LSL #32
    MOVK  X13, #0x3b27, LSL #48
    SUB  X11, X13, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X23, #0xeb75, LSL #0
    MOVK  X23, #0x608, LSL #16
    MOVK  X23, #0x5b78, LSL #32
    MOVK  X23, #0xe10c, LSL #48
    SUB  X12, X23, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, D24
    MOVZ  X23, #0xad9b, LSL #0
    MOVK  X23, #0xb0ac, LSL #16
    MOVK  X23, #0x49de, LSL #32
    MOVK  X23, #0xd992, LSL #48
    SUB  X12, X23, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X10, #0x1d1d, LSL #0
    MOVK  X10, #0x1279, LSL #16
    MOVK  X10, #0x6edf, LSL #32
    MOVK  X10, #0xe203, LSL #48
    SUB  X11, X10, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, D25
    MOVZ  X10, #0xf268, LSL #0
    MOVK  X10, #0x1d9, LSL #16
    MOVK  X10, #0x9d39, LSL #32
    MOVK  X10, #0xf801, LSL #48
    SUB  X11, X10, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X9, #0xcbe6, LSL #0
    MOVK  X9, #0x5a0d, LSL #16
    MOVK  X9, #0x10e1, LSL #32
    MOVK  X9, #0xe82e, LSL #48
    SUB  X21, X9, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D26
    MOVZ  X9, #0x18c2, LSL #0
    MOVK  X9, #0xe07e, LSL #16
    MOVK  X9, #0x56db, LSL #32
    MOVK  X9, #0x15f, LSL #48
    SUB  X21, X9, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, V27.D[1]
    MOVZ  X29, #0x6069, LSL #0
    MOVK  X29, #0x2178, LSL #16
    MOVK  X29, #0xd26, LSL #32
    MOVK  X29, #0xd3bb, LSL #48
    SUB  X25, X29, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, D27
    MOVZ  X29, #0x38b6, LSL #0
    MOVK  X29, #0x33db, LSL #16
    MOVK  X29, #0x5ca5, LSL #32
    MOVK  X29, #0xba33, LSL #48
    SUB  X25, X29, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X13, #0x8e44, LSL #0
    MOVK  X13, #0x178b, LSL #16
    MOVK  X13, #0xd1b2, LSL #32
    MOVK  X13, #0xd672, LSL #48
    SUB  X18, X13, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, D28
    MOVZ  X13, #0x6690, LSL #0
    MOVK  X13, #0xa6b8, LSL #16
    MOVK  X13, #0x4eae, LSL #32
    MOVK  X13, #0xcc5b, LSL #48
    SUB  X18, X13, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, V29.D[1]
    MOVZ  X8, #0x2a27, LSL #0
    MOVK  X8, #0x1ad8, LSL #16
    MOVK  X8, #0x74a1, LSL #32
    MOVK  X8, #0x70d0, LSL #48
    SUB  X16, X8, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X15, D29
    MOVZ  X8, #0xeb02, LSL #0
    MOVK  X8, #0x2b9f, LSL #16
    MOVK  X8, #0xd333, LSL #32
    MOVK  X8, #0xa6f2, LSL #48
    SUB  X16, X8, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
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
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X17
    FMOV  V0.D[1], X14
    FMOV  D1, X18
    FMOV  V1.D[1], X16
    FMOV  D2, X23
    FMOV  V2.D[1], X18
    FMOV  D3, X9
    FMOV  V3.D[1], X5
    FMOV  D4, X16
    FMOV  V4.D[1], X8
    FMOV  D5, X27
    FMOV  V5.D[1], X10
    FMOV  D6, X12
    FMOV  V6.D[1], X28
    FMOV  D7, X2
    FMOV  V7.D[1], X13
    FMOV  D8, X10
    FMOV  V8.D[1], X15
    FMOV  D9, X29
    FMOV  V9.D[1], X23
    FMOV  D10, X20
    FMOV  V10.D[1], X6
    FMOV  D11, X11
    FMOV  V11.D[1], X2
    FMOV  D12, X20
    FMOV  V12.D[1], X13
    FMOV  D13, X12
    FMOV  V13.D[1], X17
    FMOV  D14, X20
    FMOV  V14.D[1], X9
    FMOV  D15, X17
    FMOV  V15.D[1], X9
    FMOV  D16, X27
    FMOV  V16.D[1], X13
    FMOV  D17, X7
    FMOV  V17.D[1], X9
    FMOV  D18, X11
    FMOV  V18.D[1], X9
    FMOV  D19, X26
    FMOV  V19.D[1], X7
    FMOV  D20, X28
    FMOV  V20.D[1], X19
    FMOV  D21, X15
    FMOV  V21.D[1], X7
    FMOV  D22, X17
    FMOV  V22.D[1], X28
    FMOV  D23, X29
    FMOV  V23.D[1], X12
    FMOV  D24, X24
    FMOV  V24.D[1], X14
    FMOV  D25, X6
    FMOV  V25.D[1], X26
    FMOV  D26, X5
    FMOV  V26.D[1], X13
    FMOV  D27, X20
    FMOV  V27.D[1], X16
    FMOV  D28, X8
    FMOV  V28.D[1], X4
    FMOV  D29, X17
    FMOV  V29.D[1], X29
    FMOV  D30, X27
    FMOV  V30.D[1], X13
    FMOV  D31, X17
    FMOV  V31.D[1], X24
    MOVZ  X19, #0xa, LSL #0
TaishanSimdUnaryArithmeticP01_label_1556:
    SHA1C  Q4, S25, V0.4S
    AESE  V21.16B, V28.16B
    SHA1H  S22, S25
    SHA1H  S19, S10
    SHA256SU0  V31.4S, V10.4S
    AESIMC  V13.16B, V6.16B
    SHA256H2  Q6, Q7, V18.4S
    SHA256SU1  V5.4S, V28.4S, V2.4S
    SHA1SU1  V7.4S, V27.4S
    AESE  V21.16B, V8.16B
    SHA256SU1  V26.4S, V8.4S, V10.4S
    SHA256SU1  V30.4S, V1.4S, V5.4S
    AESD  V11.16B, V19.16B
    AESIMC  V10.16B, V0.16B
    AESE  V12.16B, V22.16B
    AESD  V25.16B, V13.16B
    SHA1SU1  V1.4S, V18.4S
    SHA1SU0  V15.4S, V26.4S, V12.4S
    SHA1SU0  V4.4S, V10.4S, V21.4S
    SHA1C  Q1, S12, V8.4S
    SHA1C  Q4, S9, V7.4S
    SHA1H  S25, S18
    SHA256SU0  V9.4S, V10.4S
    SHA1SU0  V25.4S, V11.4S, V18.4S
    AESMC  V9.16B, V14.16B
    AESMC  V26.16B, V16.16B
    SHA256SU1  V3.4S, V27.4S, V26.4S
    SHA1H  S1, S5
    SHA1SU0  V15.4S, V5.4S, V29.4S
    SHA256H  Q22, Q10, V14.4S
    AESD  V29.16B, V2.16B
    SHA1P  Q30, S24, V30.4S
    SHA1SU1  V9.4S, V10.4S
    AESIMC  V22.16B, V10.16B
    SHA256H2  Q2, Q8, V25.4S
    SHA1H  S20, S4
    SHA256SU0  V2.4S, V19.4S
    AESD  V24.16B, V3.16B
    SHA1C  Q15, S19, V21.4S
    SHA256H2  Q18, Q15, V26.4S
    AESIMC  V5.16B, V11.16B
    AESIMC  V16.16B, V31.16B
    SHA256SU1  V2.4S, V4.4S, V9.4S
    SHA256SU1  V19.4S, V3.4S, V11.4S
    SHA1P  Q24, S23, V17.4S
    SHA256SU0  V8.4S, V5.4S
    SHA256H2  Q5, Q2, V29.4S
    SHA1C  Q8, S0, V14.4S
    SHA1P  Q14, S1, V14.4S
    SHA1SU1  V15.4S, V19.4S
    SHA256H2  Q28, Q15, V21.4S
    AESE  V0.16B, V22.16B
    SHA256H  Q12, Q3, V19.4S
    SHA256SU1  V28.4S, V30.4S, V21.4S
    AESMC  V30.16B, V1.16B
    SHA1SU1  V17.4S, V17.4S
    AESE  V15.16B, V19.16B
    AESD  V26.16B, V18.16B
    SHA256SU1  V11.4S, V2.4S, V17.4S
    AESMC  V19.16B, V29.16B
    SHA1H  S18, S19
    SHA1P  Q10, S4, V1.4S
    SHA1SU1  V15.4S, V10.4S
    AESIMC  V9.16B, V18.16B
    SHA1M  Q9, S14, V18.4S
    SHA256H  Q3, Q5, V5.4S
    AESIMC  V23.16B, V28.16B
    SHA256SU0  V13.4S, V3.4S
    SHA1C  Q14, S12, V21.4S
    SHA1M  Q26, S22, V26.4S
    SHA256H2  Q15, Q28, V23.4S
    SHA256SU1  V4.4S, V8.4S, V31.4S
    AESIMC  V20.16B, V25.16B
    AESE  V10.16B, V5.16B
    SHA256H  Q14, Q31, V10.4S
    AESE  V15.16B, V15.16B
    SHA1P  Q25, S19, V18.4S
    SHA1SU0  V15.4S, V5.4S, V12.4S
    SHA1P  Q27, S27, V5.4S
    AESD  V30.16B, V31.16B
    AESMC  V25.16B, V31.16B
    SHA256H2  Q28, Q8, V30.4S
    SHA1SU0  V22.4S, V5.4S, V29.4S
    SHA256H  Q22, Q27, V20.4S
    SHA1P  Q4, S30, V20.4S
    SHA1SU1  V22.4S, V11.4S
    AESIMC  V29.16B, V10.16B
    SHA1P  Q13, S4, V10.4S
    AESMC  V8.16B, V8.16B
    AESE  V31.16B, V7.16B
    SHA1H  S3, S13
    SHA1SU0  V15.4S, V9.4S, V21.4S
    SHA256H2  Q16, Q12, V3.4S
    SHA1M  Q14, S23, V3.4S
    SHA256H  Q16, Q5, V24.4S
    SHA256SU1  V5.4S, V14.4S, V25.4S
    AESMC  V25.16B, V1.16B
    SHA256H2  Q8, Q16, V15.4S
    SHA256H2  Q9, Q28, V31.4S
    AESIMC  V21.16B, V16.16B
    SHA1M  Q2, S10, V21.4S
    SHA256SU1  V25.4S, V17.4S, V19.4S
    AESMC  V13.16B, V12.16B
    SHA256SU1  V20.4S, V8.4S, V12.4S
    SHA256SU0  V16.4S, V14.4S
    SHA256H  Q25, Q12, V3.4S
    SHA1SU0  V9.4S, V1.4S, V4.4S
    SHA1M  Q1, S6, V5.4S
    SHA256H  Q1, Q19, V2.4S
    SHA1C  Q27, S12, V18.4S
    SHA256H2  Q20, Q25, V16.4S
    SHA1SU0  V2.4S, V2.4S, V7.4S
    SHA256H2  Q7, Q21, V31.4S
    SHA1SU1  V12.4S, V4.4S
    SHA256H2  Q7, Q27, V0.4S
    AESD  V21.16B, V15.16B
    AESE  V18.16B, V18.16B
    SHA256SU0  V17.4S, V24.4S
    AESD  V21.16B, V1.16B
    SHA1M  Q13, S4, V7.4S
    SHA1M  Q27, S23, V14.4S
    SHA1C  Q24, S8, V1.4S
    SHA1SU1  V9.4S, V6.4S
    AESIMC  V3.16B, V14.16B
    SHA256SU1  V27.4S, V14.4S, V25.4S
    SHA1P  Q14, S7, V6.4S
    SHA256H2  Q12, Q23, V1.4S
    AESE  V23.16B, V16.16B
    SHA256SU1  V13.4S, V16.4S, V8.4S
    SHA256H  Q15, Q8, V26.4S
    AESIMC  V17.16B, V13.16B
    SHA256SU0  V18.4S, V26.4S
    SHA256H  Q11, Q13, V17.4S
    SHA256H  Q2, Q23, V21.4S
    SHA256SU0  V6.4S, V4.4S
    SHA1C  Q24, S9, V23.4S
    SHA1C  Q3, S6, V27.4S
    AESMC  V26.16B, V13.16B
    AESD  V15.16B, V24.16B
    SHA1SU1  V10.4S, V23.4S
    SHA256SU0  V7.4S, V4.4S
    SHA1M  Q24, S13, V9.4S
    AESIMC  V24.16B, V1.16B
    SHA1P  Q30, S21, V20.4S
    SHA1M  Q11, S13, V30.4S
TaishanSimdUnaryArithmeticP01_label_72:
    SHA256H2  Q1, Q22, V14.4S
    SHA1SU0  V14.4S, V19.4S, V9.4S
    SHA1P  Q17, S14, V3.4S
    AESE  V2.16B, V28.16B
    SHA256SU0  V0.4S, V30.4S
    SHA1H  S10, S19
    SHA256H2  Q27, Q28, V16.4S
    SHA256SU1  V28.4S, V15.4S, V11.4S
    SHA1C  Q28, S12, V5.4S
    SHA1SU0  V24.4S, V27.4S, V25.4S
    SHA1H  S17, S4
    SHA1H  S2, S23
    SHA256SU0  V6.4S, V23.4S
    SHA1M  Q30, S10, V9.4S
    SHA1SU0  V8.4S, V21.4S, V28.4S
    SHA256H  Q11, Q26, V31.4S
    SHA1M  Q21, S4, V10.4S
    SHA1SU0  V30.4S, V21.4S, V2.4S
    AESE  V0.16B, V10.16B
    SHA1C  Q23, S20, V9.4S
    SHA1M  Q24, S24, V9.4S
    SHA1M  Q22, S3, V23.4S
    AESIMC  V8.16B, V2.16B
    SHA1H  S12, S28
    SHA256H2  Q24, Q26, V6.4S
    SHA256H2  Q10, Q15, V9.4S
    SHA1M  Q25, S28, V16.4S
    SHA256SU1  V20.4S, V31.4S, V1.4S
    SHA256H  Q3, Q9, V17.4S
    SHA1M  Q10, S15, V8.4S
    SHA1H  S23, S7
    AESE  V5.16B, V1.16B
    SHA1H  S21, S6
    SHA1C  Q9, S7, V21.4S
    AESMC  V16.16B, V21.16B
    SHA1C  Q7, S31, V22.4S
    SHA1P  Q9, S2, V11.4S
    AESE  V5.16B, V5.16B
    AESE  V30.16B, V2.16B
    SHA256H2  Q10, Q10, V22.4S
    SHA256SU1  V15.4S, V8.4S, V29.4S
    SHA256SU0  V6.4S, V27.4S
    SHA256SU0  V9.4S, V3.4S
    SHA1M  Q31, S19, V4.4S
    SHA1H  S9, S7
    AESMC  V4.16B, V7.16B
    SHA256SU1  V4.4S, V27.4S, V31.4S
    SHA1SU0  V24.4S, V3.4S, V12.4S
    SHA256SU1  V16.4S, V31.4S, V21.4S
    SHA256H  Q1, Q22, V10.4S
    SHA256H2  Q29, Q1, V5.4S
    SHA256H2  Q29, Q9, V17.4S
    AESIMC  V3.16B, V7.16B
    SHA1SU0  V7.4S, V9.4S, V19.4S
    AESE  V7.16B, V9.16B
    SUBS  X19, X19, #0x1
    B.NE  TaishanSimdUnaryArithmeticP01_label_1556
    MOVZ  X11, #0x0, LSL #0
    SUB  X8, X11, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X10, X19, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X10
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
TaishanSimdUnaryArithmeticP01_label_961:
    SUB  X25, X28, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X18, X23, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X15
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X8, X23, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X14, X12, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X17, X14, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, D2
    MOVZ  X14, #0x6e4d, LSL #0
    MOVK  X14, #0x2a16, LSL #16
    SUB  X17, X14, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X20, #0x69c0, LSL #0
    MOVK  X20, #0x2b38, LSL #16
    MOVK  X20, #0xbc9b, LSL #32
    MOVK  X20, #0xd983, LSL #48
    SUB  X2, X20, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, D3
    MOVZ  X20, #0x2137, LSL #0
    MOVK  X20, #0x7ee, LSL #16
    MOVK  X20, #0xc335, LSL #32
    MOVK  X20, #0x4579, LSL #48
    SUB  X2, X20, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X18, #0x3807, LSL #0
    MOVK  X18, #0xbd1, LSL #16
    MOVK  X18, #0x2f5e, LSL #32
    MOVK  X18, #0xd623, LSL #48
    SUB  X28, X18, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X10, D4
    MOVZ  X18, #0x4ad9, LSL #0
    MOVK  X18, #0x30e2, LSL #16
    MOVK  X18, #0x643f, LSL #32
    MOVK  X18, #0x22f8, LSL #48
    SUB  X28, X18, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X7, #0x6363, LSL #0
    MOVK  X7, #0x6363, LSL #16
    MOVK  X7, #0x6363, LSL #32
    MOVK  X7, #0x6363, LSL #48
    SUB  X18, X7, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, D5
    MOVZ  X7, #0x6363, LSL #0
    MOVK  X7, #0x6363, LSL #16
    MOVK  X7, #0x6363, LSL #32
    MOVK  X7, #0x6363, LSL #48
    SUB  X18, X7, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X27, #0x726c, LSL #0
    MOVK  X27, #0xeb47, LSL #16
    MOVK  X27, #0x9b98, LSL #32
    MOVK  X27, #0x6971, LSL #48
    SUB  X10, X27, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, D6
    MOVZ  X27, #0xa0ea, LSL #0
    MOVK  X27, #0x839f, LSL #16
    MOVK  X27, #0x8096, LSL #32
    MOVK  X27, #0x115e, LSL #48
    SUB  X10, X27, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, V7.D[1]
    MOVZ  X11, #0x66e4, LSL #0
    MOVK  X11, #0xad5a, LSL #16
    MOVK  X11, #0xca4c, LSL #32
    MOVK  X11, #0xb14b, LSL #48
    SUB  X27, X11, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X9, D7
    MOVZ  X11, #0x89b5, LSL #0
    MOVK  X11, #0x29dd, LSL #16
    MOVK  X11, #0xd1a, LSL #32
    MOVK  X11, #0x15ac, LSL #48
    SUB  X27, X11, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, V8.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, D8
    MOVZ  X13, #0x729b, LSL #0
    MOVK  X13, #0x8fe, LSL #16
    SUB  X24, X13, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X10, X28, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D9
    MOVZ  X28, #0x16f9, LSL #0
    MOVK  X28, #0x2636, LSL #16
    SUB  X10, X28, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X13, #0x8ac3, LSL #0
    MOVK  X13, #0xcbf4, LSL #16
    MOVK  X13, #0x4981, LSL #32
    MOVK  X13, #0xf6a1, LSL #48
    SUB  X4, X13, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X16, D10
    MOVZ  X13, #0x135d, LSL #0
    MOVK  X13, #0x461f, LSL #16
    MOVK  X13, #0xdf17, LSL #32
    MOVK  X13, #0xe08d, LSL #48
    SUB  X4, X13, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X6, #0x4318, LSL #0
    MOVK  X6, #0xc9c1, LSL #16
    MOVK  X6, #0x2bad, LSL #32
    MOVK  X6, #0x1609, LSL #48
    SUB  X10, X6, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X14, D11
    MOVZ  X6, #0x3c23, LSL #0
    MOVK  X6, #0x3301, LSL #16
    MOVK  X6, #0x6dab, LSL #32
    MOVK  X6, #0x626a, LSL #48
    SUB  X10, X6, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, D12
    MOVZ  X6, #0x8583, LSL #0
    MOVK  X6, #0x91fe, LSL #16
    SUB  X11, X6, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X11, #0x39a5, LSL #0
    MOVK  X11, #0xe770, LSL #16
    MOVK  X11, #0x7929, LSL #32
    MOVK  X11, #0x365b, LSL #48
    SUB  X2, X11, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X6, D13
    MOVZ  X11, #0x6cef, LSL #0
    MOVK  X11, #0xe003, LSL #16
    MOVK  X11, #0xbc02, LSL #32
    MOVK  X11, #0xaaf0, LSL #48
    SUB  X2, X11, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X7, #0xaae1, LSL #0
    MOVK  X7, #0x8c77, LSL #16
    MOVK  X7, #0xa222, LSL #32
    MOVK  X7, #0x6b05, LSL #48
    SUB  X5, X7, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, D14
    MOVZ  X7, #0x8b71, LSL #0
    MOVK  X7, #0xfb7d, LSL #16
    MOVK  X7, #0x6aaf, LSL #32
    MOVK  X7, #0x2784, LSL #48
    SUB  X5, X7, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X28, #0x21c7, LSL #0
    MOVK  X28, #0x9d, LSL #16
    MOVK  X28, #0xf0ad, LSL #32
    MOVK  X28, #0x51cb, LSL #48
    SUB  X2, X28, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, D15
    MOVZ  X28, #0xc977, LSL #0
    MOVK  X28, #0x9da6, LSL #16
    MOVK  X28, #0x6a1, LSL #32
    MOVK  X28, #0xcb0c, LSL #48
    SUB  X2, X28, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X11, #0x45d6, LSL #0
    MOVK  X11, #0xe183, LSL #16
    MOVK  X11, #0xb992, LSL #32
    MOVK  X11, #0xdb04, LSL #48
    SUB  X21, X11, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, D16
    MOVZ  X11, #0x68a3, LSL #0
    MOVK  X11, #0x1f9a, LSL #16
    MOVK  X11, #0xa06a, LSL #32
    MOVK  X11, #0xcb73, LSL #48
    SUB  X21, X11, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, D17
    MOVZ  X21, #0x91f5, LSL #0
    MOVK  X21, #0xe9d, LSL #16
    SUB  X7, X21, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X5, #0xd5d5, LSL #0
    MOVK  X5, #0x75d5, LSL #16
    MOVK  X5, #0x187, LSL #32
    MOVK  X5, #0x74a9, LSL #48
    SUB  X10, X5, X20
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, D18
    MOVZ  X5, #0xd5d5, LSL #0
    MOVK  X5, #0x75d5, LSL #16
    MOVK  X5, #0xd5d5, LSL #32
    MOVK  X5, #0x75d5, LSL #48
TaishanSimdUnaryArithmeticP01_label_1128:
    SUB  X10, X5, X20
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X10, #0x9464, LSL #0
    MOVK  X10, #0x2c5b, LSL #16
    MOVK  X10, #0x6cf5, LSL #32
    MOVK  X10, #0x6ce0, LSL #48
    SUB  X25, X10, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, D19
    MOVZ  X10, #0x2cfc, LSL #0
    MOVK  X10, #0xcd0c, LSL #16
    MOVK  X10, #0x2be3, LSL #32
    MOVK  X10, #0x574d, LSL #48
    SUB  X25, X10, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X25, #0x9a77, LSL #0
    MOVK  X25, #0x89a6, LSL #16
    MOVK  X25, #0xa672, LSL #32
    MOVK  X25, #0xeaa9, LSL #48
    SUB  X10, X25, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X23, D20
    MOVZ  X25, #0x3415, LSL #0
    MOVK  X25, #0xf8a9, LSL #16
    MOVK  X25, #0x3ac3, LSL #32
    MOVK  X25, #0xfdc7, LSL #48
    SUB  X10, X25, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, D21
    MOVZ  X2, #0xd953, LSL #0
    MOVK  X2, #0x36f9, LSL #16
    SUB  X5, X2, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, D23
    MOVZ  X25, #0xf1d0, LSL #0
    MOVK  X25, #0x71ce, LSL #16
    SUB  X13, X25, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X3, #0x1c61, LSL #0
    MOVK  X3, #0x688e, LSL #16
    MOVK  X3, #0x57b, LSL #32
    MOVK  X3, #0x5b7c, LSL #48
    SUB  X2, X3, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, D24
    MOVZ  X3, #0xb6a2, LSL #0
    MOVK  X3, #0xef32, LSL #16
    MOVK  X3, #0x5c01, LSL #32
    MOVK  X3, #0x76fc, LSL #48
    SUB  X2, X3, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X11, #0x678d, LSL #0
    MOVK  X11, #0xe95, LSL #16
    MOVK  X11, #0x3a5, LSL #32
    MOVK  X11, #0x45da, LSL #48
    SUB  X20, X11, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, D25
    MOVZ  X11, #0xa31a, LSL #0
    MOVK  X11, #0x9240, LSL #16
    MOVK  X11, #0xbc06, LSL #32
    MOVK  X11, #0x5e7a, LSL #48
    SUB  X20, X11, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, V26.D[1]
    MOVZ  X23, #0xa08d, LSL #0
    MOVK  X23, #0x684e, LSL #16
    MOVK  X23, #0xb4, LSL #32
    MOVK  X23, #0x35bc, LSL #48
    SUB  X29, X23, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X27, D26
    MOVZ  X23, #0xd292, LSL #0
    MOVK  X23, #0x9ebe, LSL #16
    MOVK  X23, #0xc081, LSL #32
    MOVK  X23, #0x5a0, LSL #48
    SUB  X29, X23, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X12, #0xdbb, LSL #0
    MOVK  X12, #0xfcc0, LSL #16
    MOVK  X12, #0x36fb, LSL #32
    MOVK  X12, #0x66a0, LSL #48
    SUB  X25, X12, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, D27
    MOVZ  X12, #0xeb68, LSL #0
    MOVK  X12, #0xadf2, LSL #16
    MOVK  X12, #0xb11c, LSL #32
    MOVK  X12, #0xed2f, LSL #48
    SUB  X25, X12, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, V28.D[1]
    MOVZ  X27, #0x9eee, LSL #0
    MOVK  X27, #0x31b6, LSL #16
    MOVK  X27, #0xe998, LSL #32
    MOVK  X27, #0xcef0, LSL #48
    SUB  X29, X27, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, D28
    MOVZ  X27, #0x160e, LSL #0
    MOVK  X27, #0x47fa, LSL #16
    MOVK  X27, #0x996e, LSL #32
    MOVK  X27, #0xd4e, LSL #48
    SUB  X29, X27, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X13, #0x800e, LSL #0
    MOVK  X13, #0xb8cc, LSL #16
    MOVK  X13, #0x9e7a, LSL #32
    MOVK  X13, #0x5ce0, LSL #48
    SUB  X7, X13, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, D29
    MOVZ  X13, #0xb27e, LSL #0
    MOVK  X13, #0xbdf9, LSL #16
    MOVK  X13, #0x6d20, LSL #32
    MOVK  X13, #0x3653, LSL #48
    SUB  X7, X13, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
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
    FMOV  D0, X4
    FMOV  V0.D[1], X9
    FMOV  D1, X18
    FMOV  V1.D[1], X27
    FMOV  D2, X5
    FMOV  V2.D[1], X10
    FMOV  D3, X7
    FMOV  V3.D[1], X6
    FMOV  D4, X19
    FMOV  V4.D[1], X12
    FMOV  D5, X14
    FMOV  V5.D[1], X27
    FMOV  D6, X28
    FMOV  V6.D[1], X19
    FMOV  D7, X29
    FMOV  V7.D[1], X18
    FMOV  D8, X12
    FMOV  V8.D[1], X11
    FMOV  D9, X23
    FMOV  V9.D[1], X8
    FMOV  D10, X24
    FMOV  V10.D[1], X24
    FMOV  D11, X13
    FMOV  V11.D[1], X6
    FMOV  D12, X18
    FMOV  V12.D[1], X9
    FMOV  D13, X15
    FMOV  V13.D[1], X16
    FMOV  D14, X12
    FMOV  V14.D[1], X15
    FMOV  D15, X8
    FMOV  V15.D[1], X10
    FMOV  D16, X6
    FMOV  V16.D[1], X5
    FMOV  D17, X13
    FMOV  V17.D[1], X25
    FMOV  D18, X8
    FMOV  V18.D[1], X18
    FMOV  D19, X2
    FMOV  V19.D[1], X9
    FMOV  D20, X5
    FMOV  V20.D[1], X2
    FMOV  D21, X24
    FMOV  V21.D[1], X3
    FMOV  D22, X20
    FMOV  V22.D[1], X13
    FMOV  D23, X27
    FMOV  V23.D[1], X29
    FMOV  D24, X19
    FMOV  V24.D[1], X6
    FMOV  D25, X11
    FMOV  V25.D[1], X3
    FMOV  D26, X15
    FMOV  V26.D[1], X16
    FMOV  D27, X3
    FMOV  V27.D[1], X6
    FMOV  D28, X14
    FMOV  V28.D[1], X3
    FMOV  D29, X3
    FMOV  V29.D[1], X26
    FMOV  D30, X13
    FMOV  V30.D[1], X18
    FMOV  D31, X24
    FMOV  V31.D[1], X16
    MOVZ  X7, #0xf, LSL #0
TaishanSimdUnaryArithmeticP01_label_1637:
    SHA1SU1  V2.4S, V31.4S
    SHA1C  Q12, S1, V22.4S
    SHA1C  Q11, S10, V13.4S
    SHA1M  Q10, S20, V8.4S
    SHA256H2  Q30, Q20, V6.4S
    SHA1M  Q26, S1, V14.4S
    AESMC  V0.16B, V12.16B
    SHA1P  Q28, S27, V21.4S
    SHA256SU0  V31.4S, V0.4S
    SHA256SU0  V17.4S, V30.4S
    SHA1M  Q5, S8, V3.4S
    AESIMC  V26.16B, V21.16B
    SHA1SU0  V21.4S, V16.4S, V5.4S
    SHA256SU1  V0.4S, V2.4S, V25.4S
    SHA1SU1  V27.4S, V29.4S
    SHA1M  Q26, S28, V7.4S
    SHA256SU1  V21.4S, V30.4S, V31.4S
    SHA1H  S10, S11
    SHA256H  Q0, Q7, V31.4S
    SHA1H  S27, S30
    SHA256SU1  V10.4S, V29.4S, V2.4S
    SHA1SU1  V21.4S, V26.4S
    SHA1H  S24, S25
    AESMC  V20.16B, V18.16B
    SHA256SU1  V22.4S, V24.4S, V6.4S
    SHA256H  Q6, Q17, V12.4S
    SHA256H2  Q7, Q22, V21.4S
    SHA256H2  Q27, Q5, V28.4S
    AESIMC  V22.16B, V16.16B
    SHA1M  Q31, S5, V8.4S
    AESD  V30.16B, V13.16B
    SHA256H  Q28, Q19, V27.4S
    SHA1P  Q8, S28, V0.4S
    AESMC  V16.16B, V7.16B
    SHA256SU1  V29.4S, V7.4S, V15.4S
    AESD  V26.16B, V29.16B
    SHA1M  Q6, S30, V22.4S
    SHA1C  Q31, S24, V28.4S
    SHA256SU1  V16.4S, V6.4S, V24.4S
    AESD  V20.16B, V31.16B
    SHA256SU0  V30.4S, V19.4S
    SHA1SU1  V3.4S, V19.4S
    SHA256H  Q3, Q21, V15.4S
    SHA1SU1  V9.4S, V15.4S
    AESE  V9.16B, V9.16B
    SHA256H  Q4, Q8, V20.4S
    SHA1H  S17, S0
    SHA256SU0  V0.4S, V9.4S
    SHA1M  Q8, S4, V4.4S
    AESMC  V29.16B, V4.16B
    SHA256H  Q30, Q10, V31.4S
    AESMC  V28.16B, V7.16B
    AESMC  V1.16B, V17.16B
    AESIMC  V1.16B, V21.16B
    SHA1H  S19, S17
    SHA1SU0  V19.4S, V3.4S, V22.4S
    AESMC  V7.16B, V1.16B
    AESE  V15.16B, V0.16B
    SHA1SU0  V19.4S, V15.4S, V22.4S
    AESD  V8.16B, V7.16B
    SHA1SU0  V19.4S, V31.4S, V9.4S
    SHA1P  Q29, S12, V17.4S
    SHA1C  Q20, S10, V10.4S
    SHA1M  Q28, S4, V12.4S
    AESD  V13.16B, V8.16B
    AESE  V15.16B, V17.16B
    SHA256H2  Q9, Q8, V10.4S
    SHA1C  Q22, S15, V28.4S
    SHA256H2  Q2, Q31, V7.4S
    SHA1P  Q20, S29, V7.4S
    SHA256H2  Q18, Q17, V22.4S
    AESIMC  V11.16B, V8.16B
    AESD  V28.16B, V7.16B
    AESD  V28.16B, V31.16B
    SHA1M  Q22, S12, V11.4S
    SHA256SU0  V19.4S, V0.4S
    AESIMC  V27.16B, V18.16B
    SHA1SU0  V22.4S, V1.4S, V23.4S
    AESIMC  V13.16B, V7.16B
    SHA1H  S31, S17
    SHA1SU0  V0.4S, V4.4S, V0.4S
    SHA1SU1  V11.4S, V3.4S
    SHA1C  Q9, S2, V14.4S
    SHA256H2  Q19, Q14, V2.4S
    SHA256H  Q20, Q9, V31.4S
    SHA1C  Q31, S3, V20.4S
    SHA1M  Q0, S20, V20.4S
    AESIMC  V21.16B, V6.16B
    SHA256SU1  V9.4S, V19.4S, V1.4S
    SHA256SU0  V22.4S, V18.4S
    SHA256SU1  V23.4S, V11.4S, V28.4S
    SHA256SU0  V26.4S, V18.4S
    SHA1C  Q16, S22, V23.4S
    SHA1C  Q1, S8, V11.4S
    SHA1M  Q2, S22, V1.4S
    SHA1C  Q16, S9, V9.4S
    SHA1C  Q13, S7, V20.4S
    SHA1M  Q23, S3, V17.4S
    SHA256SU1  V11.4S, V6.4S, V0.4S
    SHA1SU0  V6.4S, V2.4S, V13.4S
    SHA1P  Q18, S28, V16.4S
    AESE  V12.16B, V22.16B
    SHA1SU0  V27.4S, V1.4S, V8.4S
    SHA256SU1  V20.4S, V25.4S, V7.4S
    SHA256H  Q25, Q1, V14.4S
    AESD  V19.16B, V1.16B
    AESE  V23.16B, V11.16B
    SHA1M  Q1, S9, V18.4S
    SHA256H2  Q6, Q4, V1.4S
    SHA1SU1  V4.4S, V17.4S
    SHA1P  Q15, S13, V30.4S
    SHA1H  S9, S21
    SHA256SU0  V4.4S, V3.4S
    SHA1SU1  V26.4S, V10.4S
    SHA1H  S28, S10
    SHA256SU1  V8.4S, V3.4S, V28.4S
    SHA1H  S15, S21
    SHA256H  Q18, Q11, V21.4S
    SHA256SU1  V18.4S, V12.4S, V26.4S
    SHA1SU1  V1.4S, V3.4S
    AESIMC  V9.16B, V6.16B
    SHA256H2  Q20, Q11, V15.4S
    SHA1C  Q17, S9, V9.4S
    SHA1SU1  V22.4S, V7.4S
    SHA256H2  Q3, Q30, V28.4S
    SHA256H  Q19, Q23, V3.4S
    AESMC  V30.16B, V0.16B
    SHA1SU1  V9.4S, V26.4S
    AESE  V18.16B, V12.16B
    SHA1M  Q8, S0, V5.4S
    SHA1M  Q19, S11, V9.4S
    AESD  V26.16B, V30.16B
    SHA1SU0  V22.4S, V27.4S, V11.4S
    AESIMC  V13.16B, V24.16B
    AESMC  V23.16B, V21.16B
    SHA256H  Q31, Q28, V31.4S
    SHA1M  Q24, S13, V28.4S
    SHA256H  Q29, Q20, V5.4S
    SHA1SU0  V20.4S, V16.4S, V23.4S
    SHA1SU1  V31.4S, V23.4S
    SHA1M  Q28, S1, V10.4S
    AESIMC  V5.16B, V9.16B
    SHA256H  Q5, Q17, V19.4S
    AESIMC  V18.16B, V15.16B
    SHA256SU1  V31.4S, V25.4S, V20.4S
    SHA1P  Q20, S0, V5.4S
    SHA1SU0  V23.4S, V3.4S, V9.4S
    SHA1C  Q18, S29, V6.4S
    SHA1SU1  V4.4S, V30.4S
    AESIMC  V27.16B, V28.16B
    SHA256H2  Q12, Q16, V6.4S
    SHA1M  Q24, S9, V4.4S
    SHA256SU0  V17.4S, V25.4S
    SHA1H  S7, S19
    SHA1SU0  V3.4S, V25.4S, V29.4S
    SHA256SU0  V14.4S, V31.4S
    AESMC  V16.16B, V30.16B
    SHA1M  Q31, S20, V7.4S
    SHA1SU1  V13.4S, V13.4S
    AESMC  V30.16B, V31.16B
    SHA1H  S0, S23
    SHA1SU1  V12.4S, V4.4S
    AESD  V24.16B, V10.16B
    SHA1P  Q17, S2, V4.4S
    SHA256SU0  V0.4S, V26.4S
    AESE  V7.16B, V17.16B
    SHA1C  Q7, S10, V15.4S
    AESMC  V9.16B, V2.16B
    SHA256H2  Q15, Q10, V4.4S
    SHA1C  Q25, S3, V14.4S
    SHA256SU1  V20.4S, V9.4S, V7.4S
    AESIMC  V2.16B, V29.16B
    AESE  V19.16B, V29.16B
    AESD  V24.16B, V17.16B
    SHA1C  Q26, S12, V21.4S
    SHA1P  Q10, S19, V24.4S
    SHA256SU1  V27.4S, V8.4S, V8.4S
    AESD  V26.16B, V26.16B
    AESMC  V18.16B, V30.16B
    SHA1M  Q17, S7, V1.4S
    SHA1C  Q30, S28, V26.4S
    SHA256H  Q11, Q16, V25.4S
    SHA1SU0  V0.4S, V20.4S, V10.4S
    SHA1H  S11, S27
    SHA1P  Q30, S15, V4.4S
    SHA256SU0  V12.4S, V11.4S
    SHA256H  Q7, Q15, V19.4S
    AESMC  V20.16B, V5.16B
    AESIMC  V10.16B, V6.16B
    SHA256SU1  V24.4S, V2.4S, V25.4S
    SHA1SU0  V14.4S, V27.4S, V27.4S
    AESMC  V21.16B, V5.16B
    SHA1P  Q30, S0, V17.4S
    SHA1SU0  V12.4S, V0.4S, V16.4S
    AESE  V16.16B, V3.16B
    SHA1C  Q8, S22, V2.4S
    SHA256SU0  V10.4S, V15.4S
    SHA1P  Q28, S7, V8.4S
    SHA1C  Q3, S8, V17.4S
    SHA256SU1  V9.4S, V16.4S, V4.4S
    SUBS  X7, X7, #0x1
    B.NE  TaishanSimdUnaryArithmeticP01_label_1637
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X29, X12, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X13, X5, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X7, X8, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X12, X5, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X17, X24, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X29, X20, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X3, X20, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X19, X6, X9
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X12, X7, X10
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X2, X21, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X5, X10, X14
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X14, X13, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X9, X10, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X17
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X24, X7, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X4, X21, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X4, X19, X27
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X23, X15, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, V2.D[1]
    MOVZ  X23, #0xf9fe, LSL #0
    MOVK  X23, #0x846b, LSL #16
    MOVK  X23, #0x542d, LSL #32
    MOVK  X23, #0x1f7f, LSL #48
    SUB  X8, X23, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, D2
    MOVZ  X23, #0x21f5, LSL #0
    MOVK  X23, #0x5005, LSL #16
    MOVK  X23, #0x229c, LSL #32
    MOVK  X23, #0x1ae0, LSL #48
    SUB  X8, X23, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, V3.D[1]
    MOVZ  X11, #0x96a, LSL #0
    MOVK  X11, #0xe8c0, LSL #16
    MOVK  X11, #0x9aab, LSL #32
    MOVK  X11, #0x60c3, LSL #48
    SUB  X13, X11, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, D3
    MOVZ  X11, #0x4314, LSL #0
    MOVK  X11, #0x6c0c, LSL #16
    MOVK  X11, #0x803e, LSL #32
    MOVK  X11, #0x44e7, LSL #48
    SUB  X13, X11, X21
TaishanSimdUnaryArithmeticP01_label_1374:
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X9, #0x71c4, LSL #0
    MOVK  X9, #0x3368, LSL #16
    MOVK  X9, #0xc2a2, LSL #32
    MOVK  X9, #0xc856, LSL #48
    SUB  X24, X9, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, D4
    MOVZ  X9, #0x11b5, LSL #0
    MOVK  X9, #0x3698, LSL #16
    MOVK  X9, #0x57c9, LSL #32
    MOVK  X9, #0x9dc3, LSL #48
    SUB  X24, X9, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, V5.D[1]
    MOVZ  X21, #0x49c8, LSL #0
    MOVK  X21, #0x150d, LSL #16
    MOVK  X21, #0x9121, LSL #32
    MOVK  X21, #0xdf60, LSL #48
    SUB  X29, X21, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, D5
    MOVZ  X21, #0xc95, LSL #0
    MOVK  X21, #0xe649, LSL #16
    MOVK  X21, #0xa511, LSL #32
    MOVK  X21, #0x1869, LSL #48
    SUB  X29, X21, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, V6.D[1]
    MOVZ  X2, #0xe33c, LSL #0
    MOVK  X2, #0x936d, LSL #16
    MOVK  X2, #0xc086, LSL #32
    MOVK  X2, #0x2518, LSL #48
    SUB  X9, X2, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, D6
    MOVZ  X2, #0xcdb0, LSL #0
    MOVK  X2, #0x24f1, LSL #16
    MOVK  X2, #0x5b95, LSL #32
    MOVK  X2, #0x366b, LSL #48
    SUB  X9, X2, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X27, #0x65fc, LSL #0
    MOVK  X27, #0xcd7c, LSL #16
    MOVK  X27, #0xceb0, LSL #32
    MOVK  X27, #0x79f4, LSL #48
    SUB  X16, X27, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X11, D7
    MOVZ  X27, #0xa54b, LSL #0
    MOVK  X27, #0x13fe, LSL #16
    MOVK  X27, #0x78cb, LSL #32
    MOVK  X27, #0x10a9, LSL #48
    SUB  X16, X27, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X23, #0xd228, LSL #0
    MOVK  X23, #0xbd38, LSL #16
    MOVK  X23, #0x3e29, LSL #32
    MOVK  X23, #0x67ba, LSL #48
    SUB  X4, X23, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, D8
    MOVZ  X23, #0xf66, LSL #0
    MOVK  X23, #0xdd4f, LSL #16
    MOVK  X23, #0x7fe8, LSL #32
    MOVK  X23, #0x1170, LSL #48
    SUB  X4, X23, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, V9.D[1]
    MOVZ  X11, #0x729d, LSL #0
    MOVK  X11, #0x9b8d, LSL #16
    MOVK  X11, #0x99fd, LSL #32
    MOVK  X11, #0x8d95, LSL #48
    SUB  X15, X11, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, D9
    MOVZ  X11, #0x170c, LSL #0
    MOVK  X11, #0xe63c, LSL #16
    MOVK  X11, #0xf2c1, LSL #32
    MOVK  X11, #0xb437, LSL #48
    SUB  X15, X11, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X14, #0xaabc, LSL #0
    MOVK  X14, #0x4a40, LSL #16
    MOVK  X14, #0x9ca5, LSL #32
    MOVK  X14, #0x4df6, LSL #48
    SUB  X11, X14, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X4, D10
    MOVZ  X14, #0x3515, LSL #0
    MOVK  X14, #0xab83, LSL #16
    MOVK  X14, #0x13fc, LSL #32
    MOVK  X14, #0xd062, LSL #48
    SUB  X11, X14, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, V11.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X21, D11
    MOVZ  X20, #0x90f8, LSL #0
    MOVK  X20, #0x9a9c, LSL #16
    SUB  X28, X20, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, V12.D[1]
    MOVZ  X6, #0x88a, LSL #0
    MOVK  X6, #0xc782, LSL #16
    MOVK  X6, #0xacdb, LSL #32
    MOVK  X6, #0x766f, LSL #48
    SUB  X11, X6, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X24, D12
    MOVZ  X6, #0x61ef, LSL #0
    MOVK  X6, #0xaf39, LSL #16
    MOVK  X6, #0xdd91, LSL #32
    MOVK  X6, #0x8764, LSL #48
    SUB  X11, X6, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xc554, LSL #32
    MOVK  X24, #0x961d, LSL #48
    SUB  X3, X24, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X29, D13
    MOVZ  X24, #0xe2aa, LSL #0
    MOVK  X24, #0x4b0e, LSL #16
    SUB  X3, X24, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, V14.D[1]
    MOVZ  X26, #0x562c, LSL #0
    MOVK  X26, #0xa444, LSL #16
    MOVK  X26, #0xaeeb, LSL #32
    MOVK  X26, #0x4e8d, LSL #48
    SUB  X19, X26, X3
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, D14
    MOVZ  X26, #0xa1d7, LSL #0
    MOVK  X26, #0x7e6e, LSL #16
    MOVK  X26, #0xd3fc, LSL #32
    MOVK  X26, #0x5e86, LSL #48
    SUB  X19, X26, X3
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X12, #0xdb0d, LSL #0
    MOVK  X12, #0x21bc, LSL #16
    MOVK  X12, #0xf5a5, LSL #32
    MOVK  X12, #0xb95a, LSL #48
    SUB  X11, X12, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, D15
    MOVZ  X12, #0xa6c5, LSL #0
    MOVK  X12, #0xe139, LSL #16
    MOVK  X12, #0x2bde, LSL #32
    MOVK  X12, #0xb26c, LSL #48
    SUB  X11, X12, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, V16.D[1]
    MOVZ  X20, #0x7010, LSL #0
    MOVK  X20, #0x2d12, LSL #16
    MOVK  X20, #0xe280, LSL #32
    MOVK  X20, #0x428a, LSL #48
    SUB  X28, X20, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X19, D16
    MOVZ  X20, #0x6620, LSL #0
    MOVK  X20, #0x4b9, LSL #16
TaishanSimdUnaryArithmeticP01_label_26:
    MOVK  X20, #0x3ec, LSL #32
    MOVK  X20, #0xbe5d, LSL #48
    SUB  X28, X20, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, V17.D[1]
    MOVZ  X13, #0xc09d, LSL #0
    MOVK  X13, #0x7040, LSL #16
    MOVK  X13, #0xde5b, LSL #32
    MOVK  X13, #0x6207, LSL #48
    SUB  X16, X13, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X5, D17
    MOVZ  X13, #0x14c1, LSL #0
    MOVK  X13, #0x724a, LSL #16
    MOVK  X13, #0x1fb4, LSL #32
    MOVK  X13, #0x5575, LSL #48
    SUB  X16, X13, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X10, #0x7c3c, LSL #0
    MOVK  X10, #0xdd07, LSL #16
    MOVK  X10, #0x73f2, LSL #32
    MOVK  X10, #0x27e8, LSL #48
    SUB  X15, X10, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X2, D18
    MOVZ  X10, #0xc4c7, LSL #0
    MOVK  X10, #0x7817, LSL #16
    MOVK  X10, #0xea7b, LSL #32
    MOVK  X10, #0x6cc1, LSL #48
    SUB  X15, X10, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X29, #0x94ce, LSL #0
    MOVK  X29, #0xc5d5, LSL #16
    MOVK  X29, #0x429c, LSL #32
    MOVK  X29, #0xdd62, LSL #48
    SUB  X10, X29, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X12, D19
    MOVZ  X29, #0xc763, LSL #0
    MOVK  X29, #0x397f, LSL #16
    MOVK  X29, #0x36a9, LSL #32
    MOVK  X29, #0xce8b, LSL #48
    SUB  X10, X29, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X3, #0x5848, LSL #0
    MOVK  X3, #0x2da4, LSL #16
    MOVK  X3, #0x6755, LSL #32
    MOVK  X3, #0x370a, LSL #48
    SUB  X6, X3, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X8, D20
    MOVZ  X3, #0xb08a, LSL #0
    MOVK  X3, #0x363a, LSL #16
    MOVK  X3, #0xe3a7, LSL #32
    MOVK  X3, #0xcf4e, LSL #48
    SUB  X6, X3, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X29, #0x5848, LSL #0
    MOVK  X29, #0x2da4, LSL #16
    MOVK  X29, #0x6755, LSL #32
    MOVK  X29, #0x370a, LSL #48
    SUB  X10, X29, X26
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X26, D21
    MOVZ  X29, #0xb08a, LSL #0
    MOVK  X29, #0x363a, LSL #16
    MOVK  X29, #0xe3a7, LSL #32
    MOVK  X29, #0xcf4e, LSL #48
    SUB  X10, X29, X26
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X7, #0xe26, LSL #0
    MOVK  X7, #0xd8f3, LSL #16
    MOVK  X7, #0x9ae, LSL #32
    MOVK  X7, #0xb14f, LSL #48
    SUB  X26, X7, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X17, D23
    MOVZ  X7, #0x3ce7, LSL #0
    MOVK  X7, #0xbc1c, LSL #16
    MOVK  X7, #0x944a, LSL #32
    MOVK  X7, #0x32a7, LSL #48
    SUB  X26, X7, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, V24.D[1]
    MOVZ  X14, #0x72d3, LSL #0
    MOVK  X14, #0xacbb, LSL #16
    MOVK  X14, #0x5b18, LSL #32
    MOVK  X14, #0x8849, LSL #48
    SUB  X17, X14, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X18, D24
    MOVZ  X14, #0xe81c, LSL #0
    MOVK  X14, #0xaef3, LSL #16
    MOVK  X14, #0x6e93, LSL #32
    MOVK  X14, #0xc748, LSL #48
    SUB  X17, X14, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X19, #0x2457, LSL #0
    MOVK  X19, #0xd40e, LSL #16
    MOVK  X19, #0xde9, LSL #32
    MOVK  X19, #0x7267, LSL #48
    SUB  X14, X19, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X3, D25
    MOVZ  X19, #0xcb38, LSL #0
    MOVK  X19, #0x5f54, LSL #16
    MOVK  X19, #0x9bab, LSL #32
    MOVK  X19, #0x76b1, LSL #48
    SUB  X14, X19, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, V26.D[1]
    MOVZ  X17, #0x5252, LSL #0
    MOVK  X17, #0x5252, LSL #16
    MOVK  X17, #0x5252, LSL #32
    MOVK  X17, #0x5252, LSL #48
    SUB  X19, X17, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X13, D26
    MOVZ  X17, #0x5252, LSL #0
    MOVK  X17, #0x5252, LSL #16
    MOVK  X17, #0x5252, LSL #32
    MOVK  X17, #0x5252, LSL #48
    SUB  X19, X17, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, V27.D[1]
    MOVZ  X18, #0xcdb4, LSL #0
    MOVK  X18, #0x84d7, LSL #16
    MOVK  X18, #0x5b41, LSL #32
    MOVK  X18, #0x6fb8, LSL #48
    SUB  X14, X18, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, D27
    MOVZ  X18, #0x43e2, LSL #0
    MOVK  X18, #0x6a72, LSL #16
    MOVK  X18, #0xd9ca, LSL #32
    MOVK  X18, #0x931a, LSL #48
    SUB  X14, X18, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X8, #0x5e8d, LSL #0
    MOVK  X8, #0xe346, LSL #16
    MOVK  X8, #0xd9af, LSL #32
    MOVK  X8, #0xe7b1, LSL #48
    SUB  X16, X8, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X20, D28
    MOVZ  X8, #0x4bd2, LSL #0
    MOVK  X8, #0xa107, LSL #16
    MOVK  X8, #0x9493, LSL #32
    MOVK  X8, #0xa68, LSL #48
    SUB  X16, X8, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, V29.D[1]
    MOVZ  X6, #0x2e18, LSL #0
    MOVK  X6, #0x9846, LSL #16
    MOVK  X6, #0x1bc6, LSL #32
    MOVK  X6, #0x62a6, LSL #48
    SUB  X13, X6, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail
    FMOV  X28, D29
    MOVZ  X6, #0xe8c7, LSL #0
    MOVK  X6, #0x802e, LSL #16
    MOVK  X6, #0xf9bf, LSL #32
    MOVK  X6, #0x494b, LSL #48
    SUB  X13, X6, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdUnaryArithmeticP01_TestFail

TaishanSimdUnaryArithmeticP01_TestEnd:
    MOVZ  X1, #0x0, LSL #0
    STP  X1, X2,   [X0], #0x10
    STP  X3, X4,   [X0], #0x10
    STP  X5, X6,   [X0], #0x10
    STP  X7, X8,   [X0], #0x10
    STP  X9, X10,  [X0], #0x10
    STP  X11, X12, [X0], #0x10
    STP  X13, X14, [X0], #0x10
    STP  X15, X16, [X0], #0x10
    STP  X17, X18, [X0], #0x10
    STP  X19, X20, [X0], #0x10
    STP  X21, X22, [X0], #0x10
    STP  X23, X24, [X0], #0x10
    STP  X25, X26, [X0], #0x10
    STP  X27, X28, [X0], #0x10
    STP  X29, X30, [X0], #0x10
    LDP  X1, X2, [SP], #16
    MSR  NZCV, X1
    LDP  X2, X3, [SP], #16
    MSR  FPCR, X2
    MSR  FPSR, X3
    ISB  SY

    LDP  Q30, Q31, [SP], #32
    LDP  Q28, Q29, [SP], #32
    LDP  Q26, Q27, [SP], #32
    LDP  Q24, Q25, [SP], #32
    LDP  Q22, Q23, [SP], #32
    LDP  Q20, Q21, [SP], #32
    LDP  Q18, Q19, [SP], #32
    LDP  Q16, Q17, [SP], #32
    LDP  Q14, Q15, [SP], #32
    LDP  Q12, Q13, [SP], #32
    LDP  Q10, Q11, [SP], #32
    LDP  Q8, Q9, [SP], #32
    LDP  Q6, Q7, [SP], #32
    LDP  Q4, Q5, [SP], #32
    LDP  Q2, Q3, [SP], #32
    LDP  Q0, Q1, [SP], #32
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
TaishanSimdUnaryArithmeticP01_TestFail:
    STP  X1, X2,   [X0], #0x10
    STP  X3, X4,   [X0], #0x10
    STP  X5, X6,   [X0], #0x10
    STP  X7, X8,   [X0], #0x10
    STP  X9, X10,  [X0], #0x10
    STP  X11, X12, [X0], #0x10
    STP  X13, X14, [X0], #0x10
    STP  X15, X16, [X0], #0x10
    STP  X17, X18, [X0], #0x10
    STP  X19, X20, [X0], #0x10
    STP  X21, X22, [X0], #0x10
    STP  X23, X24, [X0], #0x10
    STP  X25, X26, [X0], #0x10
    STP  X27, X28, [X0], #0x10
    STP  X29, X30, [X0], #0x10
    LDP  X1, X2, [SP], #16
    MSR  NZCV, X1
    LDP  X2, X3, [SP], #16
    MSR  FPCR, X2
    MSR  FPSR, X3
    ISB  SY

    LDP  Q30, Q31, [SP], #32
    LDP  Q28, Q29, [SP], #32
    LDP  Q26, Q27, [SP], #32
    LDP  Q24, Q25, [SP], #32
    LDP  Q22, Q23, [SP], #32
    LDP  Q20, Q21, [SP], #32
    LDP  Q18, Q19, [SP], #32
    LDP  Q16, Q17, [SP], #32
    LDP  Q14, Q15, [SP], #32
    LDP  Q12, Q13, [SP], #32
    LDP  Q10, Q11, [SP], #32
    LDP  Q8, Q9, [SP], #32
    LDP  Q6, Q7, [SP], #32
    LDP  Q4, Q5, [SP], #32
    LDP  Q2, Q3, [SP], #32
    LDP  Q0, Q1, [SP], #32
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
