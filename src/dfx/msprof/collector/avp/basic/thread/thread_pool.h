/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef BASIC_THREAD_THREAD_POOL_H
#define BASIC_THREAD_THREAD_POOL_H

#include "osal/osal.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
    OsalVoidPtr (*function)(OsalVoidPtr); // task function
    OsalVoidPtr taskArgs;              // task arguments
} ThreadTask;

typedef struct {
    ThreadTask *taskQueue;
    uint32_t capacity;
    uint32_t size;            // current task size
    uint32_t front;           // front of task list
    uint32_t rear;            // rear of task list
    uint32_t threadNum;       // consumer thread number
    uint32_t maxThreadNum;    // max consumer thread number
    uint32_t destruct;        // if need to destruct thread pool
    uint32_t liveNum;         // live thread number
    OsalThread *threadId;     // id list of consumer thread
    OsalMutex poolMtx;        // mutex param of thread pool
    OsalMutex liveMtx;        // mutex param of thread pool
    OsalCond notFull;         // if task list is not full
    OsalCond notEmpty;        // if task list is not empty
    OsalCond liveCond;        // wait for live thread exit
} ThreadPool;

int32_t ProfThreadPoolInit(uint32_t queueSize, uint32_t consumerNum, uint32_t maxConsumerNum);
VOID ProfThreadPoolFinalize(void);
int32_t ProfThreadPoolDispatch(ThreadTask* task, uint32_t priority);
OsalVoidPtr ProfThreadPoolConsumer(OsalVoidPtr arg);
VOID ProfThreadPoolStop(void);
int32_t ProfThreadPoolExpand(uint32_t expandNum);

#ifdef __cplusplus
}
#endif
#endif