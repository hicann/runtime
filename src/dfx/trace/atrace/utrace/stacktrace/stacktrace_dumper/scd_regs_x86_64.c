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

#ifdef __x86_64__

#define SCD_REGS_SP  SCD_REGS_RSP
#define SCD_REGS_PC  SCD_REGS_RIP

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
    return regs->r[SCD_REGS_RBP];
}

void ScdRegsSetFp(ScdRegs *regs, uintptr_t fp)
{
    regs->r[SCD_REGS_RBP] = fp;
}

TraStatus ScdRegsGetString(const ScdRegs *regs, char *buf, size_t bufSize)
{
    if (regs == NULL || buf == NULL || bufSize == 0) {
        return TRACE_INVALID_PARAM;
    }
    int32_t ret = snprintf_s(buf, bufSize, bufSize - 1U,
        "crash registers:\n"
        "    rax 0x%016lx  rbx 0x%016lx  rcx 0x%016lx  rdx 0x%016lx\n"
        "    r8  0x%016lx  r9  0x%016lx  r10 0x%016lx  r11 0x%016lx\n"
        "    r12 0x%016lx  r13 0x%016lx  r14 0x%016lx  r15 0x%016lx\n"
        "    rdi 0x%016lx  rsi 0x%016lx\n"
        "    rbp 0x%016lx  rsp 0x%016lx  rip 0x%016lx\n\n",
        regs->r[SCD_REGS_RAX], regs->r[SCD_REGS_RBX], regs->r[SCD_REGS_RCX], regs->r[SCD_REGS_RDX],
        regs->r[SCD_REGS_R8],  regs->r[SCD_REGS_R9],  regs->r[SCD_REGS_R10], regs->r[SCD_REGS_R11],
        regs->r[SCD_REGS_R12], regs->r[SCD_REGS_R13], regs->r[SCD_REGS_R14], regs->r[SCD_REGS_R15],
        regs->r[SCD_REGS_RDI], regs->r[SCD_REGS_RSI],
        regs->r[SCD_REGS_RBP], regs->r[SCD_REGS_RSP], regs->r[SCD_REGS_RIP]);
    if (ret == -1) {
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

#endif
