/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "scd_ptrace.h"
#include <elf.h>
#include <sys/uio.h>
#include <sys/ptrace.h>
#include "scd_log.h"

#define MAX_PTRACE_REG_NUM  64U

TraStatus ScdPtraceAttach(int32_t tid)
{
    if (ptrace(PTRACE_ATTACH, tid, NULL, NULL) != 0) {
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

void ScdPtraceDetach(int32_t tid)
{
    (void)ptrace(PTRACE_DETACH, tid, NULL, NULL);
}

void ScdPtraceContinue(int32_t tid)
{
    (void)ptrace(PTRACE_CONT, tid, NULL, NULL);
}

TraStatus ScdPtraceGetRegs(int32_t tid, uintptr_t *regArray, size_t regNum)
{
    uintptr_t regs[MAX_PTRACE_REG_NUM]; //big enough for all architectures
    size_t regLen = 0;
    
#ifdef PTRACE_GETREGS
    if(ptrace(PTRACE_GETREGS, tid, NULL, &regs) != 0) {
        return TRACE_FAILURE;
    }
    regLen = regNum;
#else
    struct iovec iovec;
    iovec.iov_base = &regs;
    iovec.iov_len = sizeof(regs);
    if(ptrace(PTRACE_GETREGSET, tid, NT_PRSTATUS, &iovec) != 0) {
        return TRACE_FAILURE;
    }
    regLen = iovec.iov_len / sizeof(uintptr_t);
    regLen = (regLen > regNum) ? regNum : regLen;
#endif
    (void)memcpy_s(regArray, sizeof(uintptr_t) * regNum, regs, sizeof(uintptr_t) * regLen);
    return TRACE_SUCCESS;
}
