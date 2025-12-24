/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ATRACE_CLIENT_THREAD_H
#define ATRACE_CLIENT_THREAD_H

#include "atrace_types.h"

#ifdef __cplusplus
extern "C" {
#endif

#define HOST_MAX_DEV_NUM    1024

#define THREAD_STATUS_INIT          0
#define THREAD_STATUS_RUN           1
#define THREAD_STATUS_WAIT_EXIT     2

typedef struct {
    int32_t devId;
} TraceThreadArgs;

// thread run function, callback when create thread
typedef void* (*ThreadRunFunc)(void* args);
// thread stop function, callback when release thread
typedef int32_t (*ThreadStopFunc)(int32_t devId);


TraStatus AtraceThreadPoolInit(void);
void AtraceThreadPoolExit(ThreadStopFunc func);
TraStatus AtraceThreadCreate(int32_t devId, TraceThreadArgs *pArgs, ThreadRunFunc func);
void AtraceThreadRelease(int32_t devId, ThreadStopFunc func, bool sync);

void AtraceThreadFree(int32_t devId);
int8_t AtraceThreadGetStatus(int32_t devId);
bool AtraceThreadSingleTask(int32_t devId);

#ifdef __cplusplus
}
#endif

#endif