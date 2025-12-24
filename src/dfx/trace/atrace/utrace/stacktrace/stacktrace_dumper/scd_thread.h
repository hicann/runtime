/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SCD_THREAD_H
#define SCD_THREAD_H

#include "atrace_types.h"
#include "scd_maps.h"
#include "scd_regs.h"
#include "scd_frames.h"
#include "scd_util.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#define SCD_THREAD_NAME_LEN     16U

typedef enum {
    SCD_THREAD_STATUS_INIT = 0,
    SCD_THREAD_STATUS_UNKNOWN,
    SCD_THREAD_STATUS_REGS,
    SCD_THREAD_STATUS_ATTACH,
    SCD_THREAD_STATUS_ATTACH_WAIT
} ScdThreadStatus;

typedef struct ScdThread {
    ScdThreadStatus  status;
    int32_t          pid;
    int32_t          tid;
    char             tname[SCD_THREAD_NAME_LEN];
    ScdRegs          regs;
    ScdFrames        frames;
} ScdThread;

TraStatus ScdThreadSuspend(ScdThread *thd);
void ScdThreadResume(ScdThread *thd);
TraStatus ScdThreadLoadFrames(ScdThread *thd, ScdMaps *maps);
TraStatus ScdThreadLoadInfo(ScdThread *thd);
TraStatus ScdThreadLoadInfoForCrash(ScdThread *thd, ScdRegs *regs);

ScdThread *ScdThreadCreate(int32_t pid, int32_t tid);
void ScdThreadDestroy(ScdThread **thd);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif