/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <pthread.h>
#include "subscribe_manager.h"
#include "log_inner.h"
#include "error_manage.h"

#if defined(__cplusplus)
extern "C" {
#endif

typedef struct TagSubScribePair {
    uint64_t keyThreadID;
    uint64_t valueUUID;
} SubScribePair;

typedef struct TagSubScribeInfo {
    SortVector suscribeMap;
    uint64_t subScribeCount;
    uint64_t curPid;
    pthread_mutex_t suscribeInfoLock;
} SubScribeInfo;

static SubScribeInfo g_subScribeInfo;
static pthread_key_t g_subscribeInfoThreadKey;
static __thread uint64_t g_subscribeUUID = UINT64_MAX;
static __thread uint64_t g_threadId = UINT64_MAX;

static int SubScribePairCmp(void *a, void *b, void *appInfo)
{
    (void)appInfo;
    return (int)(((SubScribePair*)a)->keyThreadID - ((SubScribePair*)b)->keyThreadID);
}

static void SubscribeInfoDestructor(void* threadId)
{
    if (threadId != NULL) {
        SubScribePair pair = {*((uint64_t*)threadId), 0};
        pthread_mutex_lock(&(g_subScribeInfo.suscribeInfoLock));
        RemoveSortVector(&(g_subScribeInfo.suscribeMap), FindSortVector(&(g_subScribeInfo.suscribeMap), &pair));
        pthread_mutex_unlock(&(g_subScribeInfo.suscribeInfoLock));
    }
    return;
}

static void InitSubscribeThreadKey(void)
{
    pthread_key_create(&g_subscribeInfoThreadKey, SubscribeInfoDestructor);
    return;
}

static void InitSubscribeInfo(void)
{
    InitSortVector(&(g_subScribeInfo.suscribeMap), sizeof(SubScribePair), SubScribePairCmp, (void*)NULL);
    pthread_mutex_init(&(g_subScribeInfo.suscribeInfoLock), NULL);
    g_subScribeInfo.subScribeCount = 0;
    g_subScribeInfo.curPid = (uint64_t)syscall(SYS_getpid);
    return;
}

static void InitSubscribeInfoThread(void)
{
    InitSubscribeInfo();
    InitSubscribeThreadKey();
    return;
}

static uint64_t GetSubscribeId(uint64_t threadId)
{
    static pthread_once_t once = PTHREAD_ONCE_INIT;
    pthread_once(&once, InitSubscribeInfoThread);

    uint64_t subscribeUUID = UINT64_MAX;
    SubScribePair pair = {threadId, 0};
    pthread_mutex_lock(&(g_subScribeInfo.suscribeInfoLock));
    size_t index = FindSortVector(&(g_subScribeInfo.suscribeMap), &pair);
    if (index == SortVectorSize(&(g_subScribeInfo.suscribeMap))) {
        g_subScribeInfo.subScribeCount++;
        subscribeUUID = (g_subScribeInfo.curPid << PID_INVALID_LEN) | (g_subScribeInfo.subScribeCount);
        pair.valueUUID = subscribeUUID;
        if (EmplaceSortVector(&(g_subScribeInfo.suscribeMap), &pair) == NULL) {
            RT_LOG_ERROR("EmplaceSortVector failed.");
            subscribeUUID = UINT64_MAX;
        }
    } else {
        subscribeUUID = ((SubScribePair*)SortVectorAt(&(g_subScribeInfo.suscribeMap), index))->valueUUID;
    }
    pthread_mutex_unlock(&(g_subScribeInfo.suscribeInfoLock));

    RT_LOG_INFO("currentPid[0x%llx], tid[0x%llx], subScribeCount[0x%llx], subscribeUUID[0x%llx].",
        (uint64_t)g_subScribeInfo.curPid, (uint64_t)threadId, (uint64_t)g_subScribeInfo.subScribeCount,
        (uint64_t)subscribeUUID);
    return subscribeUUID;
}

uint64_t GetCurSubscribeId(void)
{
    if (g_subscribeUUID == UINT64_MAX) {
        g_threadId = (uint64_t)((uintptr_t)pthread_self());
        g_subscribeUUID = GetSubscribeId(g_threadId);
        if (g_subscribeUUID != UINT64_MAX) {
            pthread_setspecific(g_subscribeInfoThreadKey, &g_threadId);
        }
    }
    return g_subscribeUUID;
}

rtError_t SubscribeReport(uint64_t threadId, rtStream_t stm, SUBSCRIBE_TYPE type)
{
    rtStream_t stream = stm;
    if (stream == NULL) {
        RT_LOG_ERROR("stream is NULL.");
        return ACL_ERROR_RT_PARAM_INVALID;
    }

    uint64_t subscribeUUID = GetSubscribeId(threadId);
    if (subscribeUUID == UINT64_MAX) {
        return ACL_ERROR_RT_INTERNAL_ERROR;
    }
    if (SetStreamThreadID(stream, type, threadId)) {
        drvError_t drvRet = halSqSubscribeTid(
            (uint8_t)GetStreamDeviceId(stream), (uint8_t)GetStreamSqID(stream), (uint8_t)type, (int64_t)subscribeUUID);
        if (drvRet != DRV_ERROR_NONE) {
            RT_LOG_ERROR("subscribe failed, ret=%d.", drvRet);
            ResetStreamThreadID(stream, type);
            return ErrorConvert(drvRet);
        }
        RT_LOG_INFO("subscribe success.");
    } else {
        RT_LOG_ERROR("stream has been subscribed.");
        return ACL_ERROR_RT_STREAM_SUBSCRIBE;
    }

    return ACL_RT_SUCCESS;
}

rtError_t UnSubscribeReport(uint64_t threadId, rtStream_t stm, SUBSCRIBE_TYPE type)
{
    rtStream_t stream = stm;
    if (stream == NULL) {
        RT_LOG_ERROR("stream is NULL.");
        return ACL_ERROR_RT_PARAM_INVALID;
    }

    uint64_t streamThreadId = GetStreamThreadID(stream, type);
    if ((streamThreadId != UINT64_MAX) && (streamThreadId == threadId)) {
        ResetStreamThreadID(stream, type);
        drvError_t drvRet = halSqUnSubscribeTid(
            (uint8_t)GetStreamDeviceId(stream), (uint8_t)GetStreamSqID(stream), (uint8_t)type);
        if (drvRet != DRV_ERROR_NONE) {
            RT_LOG_ERROR("unSubscribe failed, ret=%d.", drvRet);
            return ErrorConvert(drvRet);
        }
        RT_LOG_INFO("unSubscribe success.");
    } else {
        RT_LOG_ERROR("stream has not been subscribed to tid[0x%llx].", (uint64_t)threadId);
        return ACL_ERROR_RT_STREAM_SUBSCRIBE;
    }

    return ACL_RT_SUCCESS;
}

#if defined(__cplusplus)
}
#endif
