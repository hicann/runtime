/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "atrace_client_thread.h"
#include "adiag_print.h"
#include "trace_system_api.h"
#include "adiag_lock.h"
#include "adiag_utils.h"

typedef struct {
    TraceThread tid;
    int32_t pid;
    int8_t threadStatus;
    TraceThreadArgs args;
    TraceUserBlock block;
} ThreadInfo;

STATIC ThreadInfo **g_traceThread = NULL;
STATIC pthread_mutex_t g_traceThreadMutex = TRACE_MUTEX_INITIALIZER;

/**
 * @brief       : init thread mutex
 * @return      : NA
 */
STATIC INLINE void AtraceThreadMutexInit(void)
{
    (void)AdiagLockInit(&g_traceThreadMutex);
}

/**
 * @brief       : Destroy thread mutex
 * @return      : NA
 */
STATIC INLINE void AtraceThreadMutexDestroy(void)
{
    (void)AdiagLockDestroy(&g_traceThreadMutex);
}

/**
 * @brief       : lock thread mutex
 * @return      : NA
 */
STATIC INLINE void AtraceThreadLock(void)
{
    (void)AdiagLockGet(&g_traceThreadMutex);
}

/**
 * @brief       : unlock thread mutex
 * @return      : NA
 */
STATIC INLINE void AtraceThreadUnLock(void)
{
    (void)AdiagLockRelease(&g_traceThreadMutex);
}

STATIC void AtraceThreadSetStatus(int32_t devId, int8_t value)
{
    AtraceThreadLock();
    if ((g_traceThread != NULL) && (g_traceThread[devId] != NULL)) {
        g_traceThread[devId]->threadStatus = value;
    }
    AtraceThreadUnLock();
}

int8_t AtraceThreadGetStatus(int32_t devId)
{
    int8_t status = THREAD_STATUS_INIT;
    AtraceThreadLock();
    if ((g_traceThread != NULL) && (g_traceThread[devId] != NULL)) {
        status = g_traceThread[devId]->threadStatus;
    }
    AtraceThreadUnLock();
    return status;
}

/**
 * @brief       : get tid of thread, make sure thread exist before callback
 * @param [in]  : devId         device id
 * @return      : tid
 */
STATIC TraceThread AtraceThreadGetTid(int32_t devId)
{
    ADIAG_CHK_EXPR_ACTION((devId < 0) || (devId >= HOST_MAX_DEV_NUM), return (TraceThread)0,
        "can not get tid, invalid devId=%d.", devId);
    TraceThread tid = 0;
    AtraceThreadLock();
    if ((g_traceThread != NULL) && (g_traceThread[devId] != NULL)) {
        tid = g_traceThread[devId]->tid;
    }
    AtraceThreadUnLock();
    return tid;
}


/**
 * @brief       : check thread existence or non-existence
 * @param [in]  : devId         device id
 * @return      : true existence; false non-existence
 */
STATIC bool AtraceThreadCheckExist(int32_t devId)
{
    ADIAG_CHK_EXPR_ACTION((devId < 0) || (devId >= HOST_MAX_DEV_NUM), return false,
        "can not check thread, invalid devId=%d.", devId);
    AtraceThreadLock();
    if ((g_traceThread != NULL) && (g_traceThread[devId] != NULL) && (g_traceThread[devId]->tid != 0)) {
        AtraceThreadUnLock();
        return true;
    }
    AtraceThreadUnLock();
    return false;
}

/**
 * @brief       : free threadInfo pointer, which malloc when create thread
 * @param [in]  : devId         device id
 * @return      : NA
 */
void AtraceThreadFree(int32_t devId)
{
    ADIAG_CHK_EXPR_ACTION((devId < 0) || (devId >= HOST_MAX_DEV_NUM), return,
        "can not free atrace receive thread, invalid devId=%d.", devId);
    AtraceThreadLock();
    if ((g_traceThread != NULL) && (g_traceThread[devId] != NULL)) {
        AdiagFree(g_traceThread[devId]);
        g_traceThread[devId] = NULL;
    }
    AtraceThreadUnLock();
}

/**
 * @brief       : check current pid is same to previous pid(when create thread)
 * @param [in]  : devId         device id
 * @return      : true  same; false  different
 */
STATIC bool AtraceThreadCheckPid(int32_t devId)
{
    ADIAG_CHK_EXPR_ACTION((devId < 0) || (devId >= HOST_MAX_DEV_NUM), return false,
        "can not get tid, invalid devId=%d.", devId);
    bool ret = true;
    AtraceThreadLock();
    if ((g_traceThread != NULL) && (g_traceThread[devId] != NULL)) {
        ret = (g_traceThread[devId]->pid == TraceGetPid()) ? true : false;
    }
    AtraceThreadUnLock();
    return ret;
}
/**
 * @brief       : join thread to release thread resource, then free ThreadInfo
 * @param [in]  : devId         device id
 */
STATIC void AtraceThreadJoinTask(int32_t devId)
{
    TraceThread tid = AtraceThreadGetTid(devId);
    if ((tid > (TraceThread)0) && (AtraceThreadCheckPid(devId))) {
        int32_t ret = TraceJoinTask(&tid);
        if (ret != 0) {
            ADIAG_WAR("can not join atrace receive thread, devId=%d, strerr=%s.", devId, strerror(AdiagGetErrorCode()));
        }
    }
    AtraceThreadFree(devId);
}

/**
 * @brief       : make sure single thread for one device
 * @param [in]  : devId         device id
 * @return      : true   single thread; false   no thread
 */
bool AtraceThreadSingleTask(int32_t devId)
{
    if (AtraceThreadCheckExist(devId) == false) {
        return false;
    }
    if (AtraceThreadGetStatus(devId) == THREAD_STATUS_WAIT_EXIT) {
        AtraceThreadJoinTask(devId);
        return false;
    }
    return true;
}

/**
 * @brief       : create thread for receive device log
 * @param [in]  : devId         device id
 * @param [in]  : pArgs         pointer of thread args
 * @param [in]  : func          thread run function
 * @return      : !=0 failure; ==0 success
 */
TraStatus AtraceThreadCreate(int32_t devId, TraceThreadArgs *pArgs, ThreadRunFunc func)
{
    ADIAG_CHK_EXPR_ACTION(g_traceThread == NULL, return TRACE_FAILURE,
        "create thread failed, thread pool is not initialized.");
    ADIAG_CHK_EXPR_ACTION((devId < 0) || (devId >= HOST_MAX_DEV_NUM), return TRACE_FAILURE,
        "create thread failed, invalid devId=%d.", devId);
    ADIAG_CHK_EXPR_ACTION(pArgs == NULL, return TRACE_FAILURE,
        "create thread failed, thread args is null.");
    ADIAG_CHK_EXPR_ACTION(AtraceThreadCheckExist(devId), return TRACE_FAILURE,
        "log receive thread has bean started, devId=%d.", devId);

    ThreadInfo *pThread = (ThreadInfo *)AdiagMalloc(sizeof(ThreadInfo));
    ADIAG_CHK_EXPR_ACTION(pThread == NULL, return TRACE_FAILURE, "malloc failed, can not create atrace receive thread");

    AtraceThreadLock();
    g_traceThread[devId] = pThread;
    int32_t ret = memcpy_s(&g_traceThread[devId]->args, sizeof(TraceThreadArgs), pArgs, sizeof(TraceThreadArgs));
    if (ret != EOK) {
        ADIAG_ERR("copy data failed, strerr=%s.", strerror(AdiagGetErrorCode()));
    }

    g_traceThread[devId]->pid = TraceGetPid();
    g_traceThread[devId]->block.procFunc = func;
    g_traceThread[devId]->block.pulArg = (void *)(&g_traceThread[devId]->args);
    TraceThreadAttr threadAttr = { 0, 0, 0, 0, 0, 0, 128 * 1024 }; // joinable
    ret = TraceCreateTaskWithThreadAttr(&g_traceThread[devId]->tid, &g_traceThread[devId]->block, &threadAttr);
    AtraceThreadUnLock();
    if (ret != TRACE_SUCCESS) {
        AtraceThreadFree(devId);
        return TRACE_FAILURE;
    }
    AtraceThreadSetStatus(devId, THREAD_STATUS_RUN);
    return TRACE_SUCCESS;
}

/**
 * @brief       : release single thread
 * @param [in]  : devId         device id
 * @param [in]  : func          thread stop function
 * @param [in]  : sync          whether to wait thread exit
 * @return      : NA
 */
void AtraceThreadRelease(int32_t devId, ThreadStopFunc func, bool sync)
{
    if (AtraceThreadCheckExist(devId) == true) {
        if ((func != NULL) && (AtraceThreadGetStatus(devId) != THREAD_STATUS_WAIT_EXIT)) {
            func(devId);
            AtraceThreadSetStatus(devId, THREAD_STATUS_WAIT_EXIT);
        }
        if (sync == true) {
            AtraceThreadJoinTask(devId);
        }
    }
}

/**
 * @brief       : init thread pool
 * @return      : NA
 */
TraStatus AtraceThreadPoolInit(void)
{
    g_traceThread = (ThreadInfo **)AdiagMalloc((size_t)HOST_MAX_DEV_NUM * sizeof(ThreadInfo *));
    ADIAG_CHK_EXPR_ACTION(g_traceThread == NULL, return TRACE_FAILURE, "malloc thread pool failed.");
    AtraceThreadMutexInit();
    return TRACE_SUCCESS;
}

/**
 * @brief       : exit thread pool
 * @param [in]  : func          thread stop function
 * @return      : NA
 */
void AtraceThreadPoolExit(ThreadStopFunc func)
{
    int32_t i;
    for (i = 0; i < HOST_MAX_DEV_NUM; i++) {
        AtraceThreadRelease(i, func, false);
    }
    // wait all thread exit after stop them, to improve running efficiency
    for (i = 0; i < HOST_MAX_DEV_NUM; i++) {
        if (AtraceThreadCheckExist(i) == true) {
            AtraceThreadJoinTask(i);
        }
    }
    AdiagFree(g_traceThread);
    g_traceThread = NULL;
    AtraceThreadMutexDestroy();
}
