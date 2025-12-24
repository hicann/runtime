/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DUMPER_THREAD_H
#define DUMPER_THREAD_H

#include "atrace_types.h"
#include "stacktrace_unwind_reg.h"
#include "stacktrace_logger.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

typedef struct ScdThreadMgr
{
    pid_t crashPid; // crash process pid
    pid_t crashTid; // crash thread tid
    uint32_t threadNum; // the number of thread in crash process
    pid_t threadTid[MAX_THREAD_NUM]; // array of thread tid
} ScdThreadMgr;

TraStatus DumperThreadSuspend(pid_t tid);
void DumperThreadResume(pid_t tid);
void DumperThreadGetName(pid_t pid, pid_t tid, char *threadName, uint32_t nameLen);
TraStatus DumperThreadGetRegs(pid_t tid, uintptr_t *regArray, uint32_t regNum);
TraStatus DumperThreadWaitTidStopped(pid_t tid);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif

