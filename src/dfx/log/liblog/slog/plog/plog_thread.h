/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef PLOG_THREAD_H
#define PLOG_THREAD_H

#include <stdbool.h>
#include "log_error_code.h"

#ifdef __cplusplus
extern "C" {
#endif

#define THREAD_STATUS_INIT          0
#define THREAD_STATUS_RUN           1
#define THREAD_STATUS_WAIT_EXIT     2

typedef struct {
    int32_t devId;
    uintptr_t session;
} ThreadArgs;

// thread run function, callback when create plog thread
typedef void* (*ThreadRunFunc)(void* args);
// thread stop function, callback when release plog thread
typedef void (*ThreadStopFunc)(int32_t devId);


void PlogThreadFree(int32_t devId);
int8_t PlogThreadGetStatus(int32_t devId);
LogStatus PlogThreadCreate(int32_t devId, ThreadArgs *pArgs, ThreadRunFunc func);
void PlogThreadRelease(int32_t devId, ThreadStopFunc func, bool sync);
LogStatus PlogThreadPoolInit(void);
void PlogThreadPoolExit(ThreadStopFunc func);
bool PlogThreadSingleTask(int32_t devId);

#ifdef __cplusplus
}
#endif

#endif