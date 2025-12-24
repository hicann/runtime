/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SCD_DWARF_H
#define SCD_DWARF_H

#include "atrace_types.h"
#include "scd_regs.h"
#include "scd_memory.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

typedef struct ScdDwarf {
    int32_t                   pid;
    uintptr_t                 loadBias;
    uintptr_t                 hdrLoadBias;
    ScdMemory                 *memory;
    size_t                    memoryReadOffset;
    uintptr_t                 ehFrameHdrOffset;
    size_t                    fdeCount;
} ScdDwarf;

typedef struct ScdDwarfStepArgs {
    uintptr_t stackMinAddr;
    uintptr_t stackMaxAddr;
    bool isFirstStack;
} ScdDwarfStepArgs;

TraStatus ScdDwarfStep(ScdDwarf *dwarf, ScdRegs *regs, const ScdDwarfStepArgs *args, 
    uintptr_t pc, uintptr_t *nextPc);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif