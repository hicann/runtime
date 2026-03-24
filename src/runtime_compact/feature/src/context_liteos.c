/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "securec.h"
#include "common.h"
#include "device.h"
#include "stream.h"
#include "sort_vector.h"
#include "mem_pool.h"
#include "context.h"

#if defined(__cplusplus)
extern "C" {
#endif
typedef struct {
    uint32_t key;
    Context *ctx;
    uint32_t seq;
} ContextKeyObj;

int ContextKeyCmp(void *a, void *b, void *appInfo)
{
    (void)appInfo;
    uint32_t keyA = ((ContextKeyObj *)a)->key;
    uint32_t keyB = ((ContextKeyObj *)b)->key;
    return keyA - keyB;
}

static SortVector g_contextRecord;
static mmMutex_t g_ctxRecordMutex;

void InitCtxRecord(void)
{
    InitSortVector(&g_contextRecord, sizeof(ContextKeyObj), ContextKeyCmp, NULL);
    mmMutexInit(&g_ctxRecordMutex);
}

void DeinitCtxRecord(void)
{
    mmMutexDestroy(&g_ctxRecordMutex);
    DeInitSortVector(&g_contextRecord);
}

rtError_t SetupContext(Context *context)
{
    Context *curCtx = context;
    uint32_t curCtxSeq = GetMemPoolMemSeq(context);
    uint32_t taskId = mmGetTaskId();
    ContextKeyObj ctxObj = {taskId, curCtx, curCtxSeq};
    mmMutexLock(&g_ctxRecordMutex);
    if (EmplaceSortVector(&g_contextRecord, &ctxObj) == NULL) {
        mmMutexUnLock(&g_ctxRecordMutex);
        return ACL_ERROR_RT_INTERNAL_ERROR;
    }
    RT_LOG_INFO("new g_contextRecord size: %d", SortVectorSize(&g_contextRecord));
    mmMutexUnLock(&g_ctxRecordMutex);

    return RT_ERROR_NONE;
}

rtError_t TearDownContext(Context *context)
{
    ContextKeyObj ctxObj;
    ctxObj.key = mmGetTaskId();
    mmMutexLock(&g_ctxRecordMutex);
    ContextKeyObj *findObj = (ContextKeyObj *)SortVectorAtKey(&g_contextRecord, &ctxObj);
    if (findObj != NULL && findObj->ctx == context) {
        size_t index = FindSortVector(&g_contextRecord, &ctxObj);
        if (index < SortVectorSize(&g_contextRecord)) {
            RemoveSortVector(&g_contextRecord, index);
        }
    }
    RT_LOG_INFO("delete g_contextRecord size: %d", SortVectorSize(&g_contextRecord));
    mmMutexUnLock(&g_ctxRecordMutex);

    mmMutexLock(&context->streamLock);
    DeInitVector(&context->streamVec);
    mmMutexUnLock(&context->streamLock);
    return RT_ERROR_NONE;
}

rtError_t rtCtxGetCurrent(rtContext_t *currentCtx)
{
    if (currentCtx == NULL) {
        RT_LOG_ERROR("context is NULL!");
        return ACL_ERROR_RT_CONTEXT_NULL;
    }

    ContextKeyObj ctxObj;
    ctxObj.key = mmGetTaskId();
    mmMutexLock(&g_ctxRecordMutex);
    ContextKeyObj *findObj = (ContextKeyObj *)SortVectorAtKey(&g_contextRecord, &ctxObj);
    // 1.未set过 2. set过但置为null了; 3.不匹配
    if (findObj == NULL || (findObj->ctx == NULL || !MemPoolMemMatchSeq(findObj->ctx,
        findObj->seq))) {
        RT_LOG_WARNING("current context is NULL!");
        mmMutexUnLock(&g_ctxRecordMutex);
        return ACL_ERROR_RT_CONTEXT_NULL;
    }
    *currentCtx = findObj->ctx;
    mmMutexUnLock(&g_ctxRecordMutex);

    return RT_ERROR_NONE;
}

rtError_t rtCtxSetCurrent(rtContext_t currentCtx)
{
    if ((currentCtx != NULL) && !MemPoolMemUsed(currentCtx)) {
        RT_LOG_ERROR("context is invalid!");
        return ACL_ERROR_RT_CONTEXT_NULL;
    }

    Context *curCtx = currentCtx;
    uint32_t curCtxSeq = currentCtx == NULL ? 0 : GetMemPoolMemSeq(currentCtx);
    uint32_t taskId = mmGetTaskId();
    ContextKeyObj ctxObj = {taskId, curCtx, curCtxSeq};
    mmMutexLock(&g_ctxRecordMutex);
    EmplaceSortVector(&g_contextRecord, &ctxObj);
    mmMutexUnLock(&g_ctxRecordMutex);
    return RT_ERROR_NONE;
}

#if defined(__cplusplus)
}
#endif
