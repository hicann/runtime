/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef STACKTRACE_UNWIND_REG_H
#define STACKTRACE_UNWIND_REG_H

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#define TRACE_CORE_REG_NUM 0x20U

#ifdef __x86_64__

#define VOS_R_IP 0x10
#define VOS_R_BP 0x06
#define VOS_R_SP 0x07

struct X86Regs {
    unsigned long r15;
    unsigned long r14;
    unsigned long r13;
    unsigned long r12;
    unsigned long rbp;
    unsigned long rbx;
    unsigned long r11;
    unsigned long r10;
    unsigned long r9;
    unsigned long r8;
    unsigned long rax;
    unsigned long rcx;
    unsigned long rdx;
    unsigned long rsi;
    unsigned long rdi;
    unsigned long origRax;
    unsigned long rip;
    unsigned long cs;
    unsigned long eflags;
    unsigned long rsp;
    unsigned long ss;
};

#define GET_FPREG(regs)  (regs)[6]
#define GET_SPREG(regs)  (regs)[7]
#define GET_PCREG(regs)  (regs)[16]
#define MAX_USE_REG_NUM  17
#define GET_FPREG_FROM_CONTEXT(mcontext) (uintptr_t)(mcontext)->gregs[10]
#define GET_SPREG_FROM_CONTEXT(mcontext) (uintptr_t)(mcontext)->gregs[15]
#define GET_PCREG_FROM_CONTEXT(mcontext) (uintptr_t)(mcontext)->gregs[16]

#define GET_REGISTER_FROM_PTRACE(regs, regBuf) \
    do { \
        struct X86Regs *pRegs = (struct X86Regs *)(regBuf); \
        (regs)[0]  = (uintptr_t)(pRegs)->rax; \
        (regs)[1]  = (uintptr_t)(pRegs)->rbx; \
        (regs)[2]  = (uintptr_t)(pRegs)->rcx; \
        (regs)[3]  = (uintptr_t)(pRegs)->rdx; \
        (regs)[4]  = (uintptr_t)(pRegs)->rsi; \
        (regs)[5]  = (uintptr_t)(pRegs)->rdi; \
        (regs)[6]  = (uintptr_t)(pRegs)->rbp; \
        (regs)[7]  = (uintptr_t)(pRegs)->rsp; \
        (regs)[8]  = (uintptr_t)(pRegs)->r8; \
        (regs)[9]  = (uintptr_t)(pRegs)->r9; \
        (regs)[10] = (uintptr_t)(pRegs)->r10; \
        (regs)[11] = (uintptr_t)(pRegs)->r11; \
        (regs)[12] = (uintptr_t)(pRegs)->r12; \
        (regs)[13] = (uintptr_t)(pRegs)->r13; \
        (regs)[14] = (uintptr_t)(pRegs)->r14; \
        (regs)[15] = (uintptr_t)(pRegs)->r15; \
        (regs)[16] = (uintptr_t)(pRegs)->rip; \
    } while (0)

#define GET_REGISTER_FROM_CONTEXT(regs, mcontext) \
    do { \
        (regs)[0]  = (uintptr_t)(mcontext)->gregs[13]; \
        (regs)[1]  = (uintptr_t)(mcontext)->gregs[11]; \
        (regs)[2]  = (uintptr_t)(mcontext)->gregs[14]; \
        (regs)[3]  = (uintptr_t)(mcontext)->gregs[12]; \
        (regs)[4]  = (uintptr_t)(mcontext)->gregs[9]; \
        (regs)[5]  = (uintptr_t)(mcontext)->gregs[8]; \
        (regs)[6]  = (uintptr_t)(mcontext)->gregs[10]; \
        (regs)[7]  = (uintptr_t)(mcontext)->gregs[15]; \
        (regs)[8]  = (uintptr_t)(mcontext)->gregs[0]; \
        (regs)[9]  = (uintptr_t)(mcontext)->gregs[1]; \
        (regs)[10] = (uintptr_t)(mcontext)->gregs[2]; \
        (regs)[11] = (uintptr_t)(mcontext)->gregs[3]; \
        (regs)[12] = (uintptr_t)(mcontext)->gregs[4]; \
        (regs)[13] = (uintptr_t)(mcontext)->gregs[5]; \
        (regs)[14] = (uintptr_t)(mcontext)->gregs[6]; \
        (regs)[15] = (uintptr_t)(mcontext)->gregs[7]; \
        (regs)[16] = (uintptr_t)(mcontext)->gregs[16]; \
    } while (0)

#define SCD_REGS_RAX 0
#define SCD_REGS_RBX 1
#define SCD_REGS_RCX 3
#define SCD_REGS_RDX 4
#define SCD_REGS_R8  8
#define SCD_REGS_R9 9
#define SCD_REGS_R10 10
#define SCD_REGS_R11 11
#define SCD_REGS_R12 12
#define SCD_REGS_R13 13
#define SCD_REGS_R14 14
#define SCD_REGS_R15 15
#define SCD_REGS_RDI 5
#define SCD_REGS_RSI 4
#define SCD_REGS_RBP 6
#define SCD_REGS_RSP 7
#define SCD_REGS_RIP 16

#elif defined __aarch64__

#define VOS_R_IP 0x10
#define VOS_R_BP 0x1d
#define VOS_R_SP 0x1f

#define GET_FPREG(regs)  (regs)[29]
#define GET_SPREG(regs)  (regs)[31]
#define GET_PCREG(regs)  (regs)[16]
#define MAX_USE_REG_NUM  32
#define GET_FPREG_FROM_CONTEXT(mcontext) (uintptr_t)(mcontext)->regs[29]
#define GET_SPREG_FROM_CONTEXT(mcontext) (uintptr_t)(mcontext)->sp
#define GET_PCREG_FROM_CONTEXT(mcontext) (uintptr_t)(mcontext)->pc

#define GET_REGISTER_FROM_CONTEXT(pRegs, mcontext) \
    do { \
        (pRegs)[0]  = (uintptr_t)(mcontext)->regs[0]; \
        (pRegs)[1]  = (uintptr_t)(mcontext)->regs[1]; \
        (pRegs)[2]  = (uintptr_t)(mcontext)->regs[2]; \
        (pRegs)[3]  = (uintptr_t)(mcontext)->regs[3]; \
        (pRegs)[4]  = (uintptr_t)(mcontext)->regs[4]; \
        (pRegs)[5]  = (uintptr_t)(mcontext)->regs[5]; \
        (pRegs)[6]  = (uintptr_t)(mcontext)->regs[6]; \
        (pRegs)[7]  = (uintptr_t)(mcontext)->regs[7]; \
        (pRegs)[8]  = (uintptr_t)(mcontext)->regs[8]; \
        (pRegs)[9]  = (uintptr_t)(mcontext)->regs[9]; \
        (pRegs)[10] = (uintptr_t)(mcontext)->regs[10]; \
        (pRegs)[11] = (uintptr_t)(mcontext)->regs[11]; \
        (pRegs)[12] = (uintptr_t)(mcontext)->regs[12]; \
        (pRegs)[13] = (uintptr_t)(mcontext)->regs[13]; \
        (pRegs)[14] = (uintptr_t)(mcontext)->regs[14]; \
        (pRegs)[15] = (uintptr_t)(mcontext)->regs[15]; \
        (pRegs)[16] = (uintptr_t)(mcontext)->pc; \
        (pRegs)[17] = (uintptr_t)(mcontext)->regs[17]; \
        (pRegs)[18] = (uintptr_t)(mcontext)->regs[18]; \
        (pRegs)[19] = (uintptr_t)(mcontext)->regs[19]; \
        (pRegs)[20] = (uintptr_t)(mcontext)->regs[20]; \
        (pRegs)[21] = (uintptr_t)(mcontext)->regs[21]; \
        (pRegs)[22] = (uintptr_t)(mcontext)->regs[22]; \
        (pRegs)[23] = (uintptr_t)(mcontext)->regs[23]; \
        (pRegs)[24] = (uintptr_t)(mcontext)->regs[24]; \
        (pRegs)[25] = (uintptr_t)(mcontext)->regs[25]; \
        (pRegs)[26] = (uintptr_t)(mcontext)->regs[26]; \
        (pRegs)[27] = (uintptr_t)(mcontext)->regs[27]; \
        (pRegs)[28] = (uintptr_t)(mcontext)->regs[28]; \
        (pRegs)[29] = (uintptr_t)(mcontext)->regs[29]; \
        (pRegs)[30] = (uintptr_t)(mcontext)->regs[30]; \
        (pRegs)[31] = (uintptr_t)(mcontext)->sp; \
    } while (0)

#define GET_REGISTER_FROM_PTRACE(regs, regBuf) \
    do { \
        (regs)[0]  = regBuf[0]; \
        (regs)[1]  = regBuf[1]; \
        (regs)[2]  = regBuf[2]; \
        (regs)[3]  = regBuf[3]; \
        (regs)[4]  = regBuf[4]; \
        (regs)[5]  = regBuf[5]; \
        (regs)[6]  = regBuf[6]; \
        (regs)[7]  = regBuf[7]; \
        (regs)[8]  = regBuf[8]; \
        (regs)[9]  = regBuf[9]; \
        (regs)[10] = regBuf[10]; \
        (regs)[11] = regBuf[11]; \
        (regs)[12] = regBuf[12]; \
        (regs)[13] = regBuf[13]; \
        (regs)[14] = regBuf[14]; \
        (regs)[15] = regBuf[15]; \
        (regs)[16] = regBuf[32]; \
        (regs)[17] = regBuf[17]; \
        (regs)[18] = regBuf[18]; \
        (regs)[19] = regBuf[19]; \
        (regs)[20] = regBuf[20]; \
        (regs)[21] = regBuf[21]; \
        (regs)[22] = regBuf[22]; \
        (regs)[23] = regBuf[23]; \
        (regs)[24] = regBuf[24]; \
        (regs)[25] = regBuf[25]; \
        (regs)[26] = regBuf[26]; \
        (regs)[27] = regBuf[27]; \
        (regs)[28] = regBuf[28]; \
        (regs)[29] = regBuf[29]; \
        (regs)[30] = regBuf[30]; \
        (regs)[31] = regBuf[31]; \
    } while (0)

#define SCD_REGS_X0  0
#define SCD_REGS_X1  1
#define SCD_REGS_X2  2
#define SCD_REGS_X3  3
#define SCD_REGS_X4  4
#define SCD_REGS_X5  5
#define SCD_REGS_X6  6
#define SCD_REGS_X7  7
#define SCD_REGS_X8  8
#define SCD_REGS_X9  9
#define SCD_REGS_X10 10
#define SCD_REGS_X11 11
#define SCD_REGS_X12 12
#define SCD_REGS_X13 13
#define SCD_REGS_X14 14
#define SCD_REGS_X15 15
#define SCD_REGS_X16 16
#define SCD_REGS_X17 17
#define SCD_REGS_X18 18
#define SCD_REGS_X19 19
#define SCD_REGS_X20 20
#define SCD_REGS_X21 21
#define SCD_REGS_X22 22
#define SCD_REGS_X23 23
#define SCD_REGS_X24 24
#define SCD_REGS_X25 25
#define SCD_REGS_X26 26
#define SCD_REGS_X27 27
#define SCD_REGS_X28 28
#define SCD_REGS_X29 29
#define SCD_REGS_SP  31
#define SCD_REGS_LR  30
#define SCD_REGS_PC  16

#else
/* x86_32 arm_32环境暂不支持unwind推栈，为编译兼容，定义以下无效宏 */
#define VOS_R_BP 0x06
#define VOS_R_SP 0x07
#define VOS_R_IP 0x10

#define GET_FPREG(regs)  0
#define GET_SPREG(regs)  0
#define GET_PCREG(regs)  0
#define MAX_USE_REG_NUM  32
#define GET_FPREG_FROM_CONTEXT(mcontext) 0
#define GET_SPREG_FROM_CONTEXT(mcontext) 0
#define GET_PCREG_FROM_CONTEXT(mcontext) 0

#define GET_REGISTER_FROM_CONTEXT(regs, mcontext) \
    do {                                        \
        (void)regs;                             \
        (void)mcontext;                         \
    } while (0)

#define GET_REGISTER_FROM_PTRACE(regs, regBuf) \
    do {                                       \
        (void)regs;                            \
        (void)regBuf;                          \
    } while (0)

#endif

#ifdef __cplusplus
}
#endif // __cplusplus
#endif // STACKTRACE_UNWIND_REG_H
