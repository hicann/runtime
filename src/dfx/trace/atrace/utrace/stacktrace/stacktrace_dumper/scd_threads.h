/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SCD_THREADS_H
#define SCD_THREADS_H

#include "atrace_types.h"
#include "scd_maps.h"
#include "scd_regs.h"
#include "scd_util.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

typedef struct ScdThreads {
    int32_t          pid;
    int32_t          crashTid;
    ScdRegs          ucRegs;
    struct AdiagList thdList;
} ScdThreads;

void ScdThreadsSuspend(ScdThreads *thds);
void ScdThreadsResume(ScdThreads *thds);

TraStatus ScdThreadsRecord(int32_t fd, const ScdThreads *thds);
TraStatus ScdThreadsLoadFrames(ScdThreads *thds, ScdMaps *maps);
TraStatus ScdThreadsLoadInfo(ScdThreads *thds);
TraStatus ScdThreadsLoad(ScdThreads *thds);

TraStatus ScdThreadsInit(ScdThreads *thds, int32_t pid, int32_t crashTid, ucontext_t *uc);
void ScdThreadsUninit(ScdThreads *thds);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif
