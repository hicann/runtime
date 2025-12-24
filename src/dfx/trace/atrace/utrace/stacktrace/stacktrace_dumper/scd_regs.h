/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SCD_REGS_H
#define SCD_REGS_H

#include <ucontext.h>
#include "atrace_types.h"
#include "stacktrace_unwind_reg.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#define SCD_REGS_NUM 34U
typedef struct ScdRegs {
    uintptr_t r[SCD_REGS_NUM];
} ScdRegs;

void ScdRegsLoadFromUcontext(ScdRegs *regs, ucontext_t *uc);
uintptr_t ScdRegsGetPc(ScdRegs *regs);
void ScdRegsSetPc(ScdRegs *regs, uintptr_t pc);
uintptr_t ScdRegsGetSp(ScdRegs *regs);
void ScdRegsSetSp(ScdRegs *regs, uintptr_t sp);
uintptr_t ScdRegsGetFp(ScdRegs *regs);
void ScdRegsSetFp(ScdRegs *regs, uintptr_t fp);
TraStatus ScdRegsGetString(const ScdRegs *regs, char *buf, size_t bufSize);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif