/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "scd_regs.h"
#include "securec.h"

#if defined __aarch64__ || defined __arm__ || defined _ADIAG_LLT_ARM_

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
#define SCD_REGS_LR  30
#define SCD_REGS_SP  31
#define SCD_REGS_PC  16

void ScdRegsLoadFromUcontext(ScdRegs *regs, ucontext_t *uc)
{
    GET_REGISTER_FROM_CONTEXT(regs->r, &uc->uc_mcontext);
}

uintptr_t ScdRegsGetPc(ScdRegs *regs)
{
    return regs->r[SCD_REGS_PC];
}

void ScdRegsSetPc(ScdRegs *regs, uintptr_t pc)
{
    regs->r[SCD_REGS_PC] = pc;
}

uintptr_t ScdRegsGetSp(ScdRegs *regs)
{
    return regs->r[SCD_REGS_SP];
}

void ScdRegsSetSp(ScdRegs *regs, uintptr_t sp)
{
    regs->r[SCD_REGS_SP] = sp;
}

uintptr_t ScdRegsGetFp(ScdRegs *regs)
{
    return regs->r[SCD_REGS_X29];
}

void ScdRegsSetFp(ScdRegs *regs, uintptr_t fp)
{
    regs->r[SCD_REGS_X29] = fp;
}

TraStatus ScdRegsGetString(const ScdRegs *regs, char *buf, size_t bufSize)
{
    if (regs == NULL || buf == NULL || bufSize == 0) {
        return TRACE_INVALID_PARAM;
    }
    int32_t ret = snprintf_s(buf, bufSize, bufSize - 1U,
        "crash registers:\n"
        "    x0  0x%016lx  x1  0x%016lx  x2  0x%016lx  x3  0x%016lx\n"
        "    x4  0x%016lx  x5  0x%016lx  x6  0x%016lx  x7  0x%016lx\n"
        "    x8  0x%016lx  x9  0x%016lx  x10 0x%016lx  x11 0x%016lx\n"
        "    x12 0x%016lx  x13 0x%016lx  x14 0x%016lx  x15 0x%016lx\n"
        "    x16 0x%016lx  x17 0x%016lx  x18 0x%016lx  x19 0x%016lx\n"
        "    x20 0x%016lx  x21 0x%016lx  x22 0x%016lx  x23 0x%016lx\n"
        "    x24 0x%016lx  x25 0x%016lx  x26 0x%016lx  x27 0x%016lx\n"
        "    x28 0x%016lx  x29 0x%016lx\n"
        "    sp  0x%016lx  lr  0x%016lx  pc  0x%016lx\n\n",
        regs->r[SCD_REGS_X0],  regs->r[SCD_REGS_X1],  regs->r[SCD_REGS_X2],  regs->r[SCD_REGS_X3],
        regs->r[SCD_REGS_X4],  regs->r[SCD_REGS_X5],  regs->r[SCD_REGS_X6],  regs->r[SCD_REGS_X7],
        regs->r[SCD_REGS_X8],  regs->r[SCD_REGS_X9],  regs->r[SCD_REGS_X10], regs->r[SCD_REGS_X11],
        regs->r[SCD_REGS_X12], regs->r[SCD_REGS_X13], regs->r[SCD_REGS_X14], regs->r[SCD_REGS_X15],
        regs->r[SCD_REGS_X16], regs->r[SCD_REGS_X17], regs->r[SCD_REGS_X18], regs->r[SCD_REGS_X19],
        regs->r[SCD_REGS_X20], regs->r[SCD_REGS_X21], regs->r[SCD_REGS_X22], regs->r[SCD_REGS_X23],
        regs->r[SCD_REGS_X24], regs->r[SCD_REGS_X25], regs->r[SCD_REGS_X26], regs->r[SCD_REGS_X27],
        regs->r[SCD_REGS_X28], regs->r[SCD_REGS_X29],
        regs->r[SCD_REGS_SP],  regs->r[SCD_REGS_LR],  regs->r[SCD_REGS_PC]);
    if (ret == -1) {
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

#endif
