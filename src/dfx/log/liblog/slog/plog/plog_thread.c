/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "plog_thread.h"
#include "log_common.h"
#include "log_print.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
    ToolUserBlock block;
    ToolThread tid;
    int32_t pid;
    ThreadArgs args;
    int8_t threadStatus;
} ThreadInfo;

STATIC ThreadInfo **g_plogThread = NULL;
STATIC ToolMutex g_plogThreadMutex = TOOL_MUTEX_INITIALIZER;

/**
 * @brief       : init hdc mutex
 * @return      : NA
 */
STATIC INLINE void PlogThreadMutexInit(void)
{
    (void)ToolMutexInit(&g_plogThreadMutex);
}

/**
 * @brief       : Destroy hdc mutex
 * @return      : NA
 */
STATIC INLINE void PlogThreadMutexDestroy(void)
{
    (void)ToolMutexDestroy(&g_plogThreadMutex);
}

/**
 * @brief       : lock thread mutex
 * @return      : NA
 */
STATIC INLINE void PlogThreadLock(void)
{
    (void)ToolMutexLock(&g_plogThreadMutex);
}

/**
 * @brief       : unlock thread mutex
 * @return      : NA
 */
STATIC INLINE void PlogThreadUnLock(void)
{
    (void)ToolMutexUnLock(&g_plogThreadMutex);
}

STATIC void PlogThreadSetStatus(int32_t devId, int8_t value)
{
    PlogThreadLock();
    if ((g_plogThread != NULL) && (g_plogThread[devId] != NULL)) {
        g_plogThread[devId]->threadStatus = value;
    }
    PlogThreadUnLock();
}

int8_t PlogThreadGetStatus(int32_t devId)
{
    int8_t status = THREAD_STATUS_INIT;
    PlogThreadLock();
    if ((g_plogThread != NULL) && (g_plogThread[devId] != NULL)) {
        status = g_plogThread[devId]->threadStatus;
    }
    PlogThreadUnLock();
    return status;
}

/**
 * @brief       : get tid of thread, make sure thread exist before callback
 * @param [in]  : devId         device id
 * @return      : tid
 */
STATIC ToolThread PlogThreadGetTid(int32_t devId)
{
    ONE_ACT_ERR_LOG((devId < 0) || (devId >= HOST_MAX_DEV_NUM), return (ToolThread)0,
                    "can not get tid, invalid devId=%d.", devId);
    ToolThread tid = 0;
    PlogThreadLock();
    if ((g_plogThread != NULL) && (g_plogThread[devId] != NULL)) {
        tid = g_plogThread[devId]->tid;
    }
    PlogThreadUnLock();
    return tid;
}


/**
 * @brief       : check thread existence or non-existence
 * @param [in]  : devId         device id
 * @return      : true existence; flase non-existence
 */
STATIC bool PlogThreadCheckExist(int32_t devId)
{
    ONE_ACT_ERR_LOG((devId < 0) || (devId >= HOST_MAX_DEV_NUM), return false,
                    "can not check thread exist, invalid devId=%d.", devId);
    PlogThreadLock();
    if ((g_plogThread != NULL) && (g_plogThread[devId] != NULL) && (g_plogThread[devId]->tid != 0)) {
        PlogThreadUnLock();
        return true;
    }
    PlogThreadUnLock();
    return false;
}

/**
 * @brief       : free threadInfo pointer, which malloc when create thread
 * @param [in]  : devId         device id
 * @return      : NA
 */
void PlogThreadFree(int32_t devId)
{
    ONE_ACT_ERR_LOG((devId < 0) || (devId >= HOST_MAX_DEV_NUM), return,
                    "can not free plog thread, invalid devId=%d.", devId);
    PlogThreadLock();
    if ((g_plogThread != NULL) && (g_plogThread[devId] != NULL)) {
        LogFree(g_plogThread[devId]);
        g_plogThread[devId] = NULL;
    }
    PlogThreadUnLock();
}

/**
 * @brief       : check current pid is same to previous pid(when create thread)
 * @param [in]  : devId         device id
 * @return      : true  same; false  different
 */
STATIC bool PlogThreadCheckPid(int32_t devId)
{
    ONE_ACT_ERR_LOG((devId < 0) || (devId >= HOST_MAX_DEV_NUM), return false,
                    "can not get tid, invalid devId=%d.", devId);
    bool ret = true;
    PlogThreadLock();
    if ((g_plogThread != NULL) && (g_plogThread[devId] != NULL)) {
        ret = (g_plogThread[devId]->pid == ToolGetPid()) ? true : false;
    }
    PlogThreadUnLock();
    return ret;
}
/**
 * @brief       : join thread to release thread resource, then free ThreadInfo
 * @param [in]  : devId         device id
 */
STATIC void PlogThreadJoinTask(int32_t devId)
{
    ToolThread tid = PlogThreadGetTid(devId);
    if ((tid > 0) && (PlogThreadCheckPid(devId))) {
        int32_t ret = ToolJoinTask(&tid);
        NO_ACT_WARN_LOG(ret != 0, "can not join plog thread, devId=%d, strerr=%s.",
                        devId, strerror(ToolGetErrorCode()));
    }
    PlogThreadFree(devId);
}

/**
 * @brief       : make sure single thread for one device
 * @param [in]  : devId         device id
 * @return      : true   single thread; flase   no thread
 */
bool PlogThreadSingleTask(int32_t devId)
{
    if (PlogThreadCheckExist(devId) == false) {
        return false;
    }
    if (PlogThreadGetStatus(devId) == THREAD_STATUS_WAIT_EXIT) {
        PlogThreadJoinTask(devId);
        return false;
    }
    return true;
}

/**
 * @brief       : create thread for recv device log
 * @param [in]  : devId         device id
 * @param [in]  : pArgs         pointer of thread args
 * @param [in]  : func          thread run function
 * @return      : !=0 failure; ==0 success
 */
LogStatus PlogThreadCreate(int32_t devId, ThreadArgs *pArgs, ThreadRunFunc func)
{
    ONE_ACT_ERR_LOG((devId < 0) || (devId >= HOST_MAX_DEV_NUM), return LOG_FAILURE,
                    "create thread failed, invaild devId=%d.", devId);
    ONE_ACT_ERR_LOG(pArgs == NULL, return LOG_FAILURE,
                    "create thread failed, thread args is null.");
    ONE_ACT_ERR_LOG(PlogThreadCheckExist(devId), return LOG_FAILURE,
                    "log recv thread has bean started, devId=%d.", devId);

    ThreadInfo *pThread = (ThreadInfo *)LogMalloc(sizeof(ThreadInfo));
    ONE_ACT_ERR_LOG(pThread == NULL, return LOG_FAILURE, "malloc failed, can not create plog thread");

    PlogThreadLock();
    g_plogThread[devId] = pThread;
    int32_t ret = memcpy_s(&g_plogThread[devId]->args, sizeof(ThreadArgs), pArgs, sizeof(ThreadArgs));
    NO_ACT_ERR_LOG(ret != EOK, "copy data failed, strerr=%s.", strerror(ToolGetErrorCode()));

    g_plogThread[devId]->pid = ToolGetPid();
    g_plogThread[devId]->block.procFunc = func;
    g_plogThread[devId]->block.pulArg = (void *)(&g_plogThread[devId]->args);
    ToolThreadAttr threadAttr = { 0, 0, 0, 0, 0, 0, 128 * 1024 }; // joinable
    ret = ToolCreateTaskWithThreadAttr(&g_plogThread[devId]->tid, &g_plogThread[devId]->block, &threadAttr);
    PlogThreadUnLock();
    if (ret != SYS_OK) {
        PlogThreadFree(devId);
        return LOG_FAILURE;
    }
    PlogThreadSetStatus(devId, THREAD_STATUS_RUN);
    return LOG_SUCCESS;
}

/**
 * @brief       : release single thread
 * @param [in]  : devId         device id
 * @param [in]  : func          thread stop function
 * @param [in]  : sync          whether to wait thread exit
 * @return      : NA
 */
void PlogThreadRelease(int32_t devId, ThreadStopFunc func, bool sync)
{
    if (PlogThreadCheckExist(devId) == true) {
        if ((func != NULL) && (PlogThreadGetStatus(devId) != THREAD_STATUS_WAIT_EXIT)) {
            func(devId);
            PlogThreadSetStatus(devId, THREAD_STATUS_WAIT_EXIT);
        }
        if (sync == true) {
            PlogThreadJoinTask(devId);
        }
    }
}

/**
 * @brief       : init thread pool
 * @return      : NA
 */
LogStatus PlogThreadPoolInit(void)
{
    g_plogThread = (ThreadInfo **)LogMalloc((size_t)HOST_MAX_DEV_NUM * sizeof(ThreadInfo *));
    ONE_ACT_ERR_LOG(g_plogThread == NULL, return LOG_FAILURE, "malloc thread pool failed.");
    PlogThreadMutexInit();
    return LOG_SUCCESS;
}

/**
 * @brief       : exit thread pool
 * @param [in]  : func          thread stop function
 * @return      : NA
 */
void PlogThreadPoolExit(ThreadStopFunc func)
{
    int32_t i;
    for (i = 0; i < HOST_MAX_DEV_NUM; i++) {
        PlogThreadRelease(i, func, false);
    }
    // wait all thread exit after stop them, to improve running efficiency
    for (i = 0; i < HOST_MAX_DEV_NUM; i++) {
        if (PlogThreadCheckExist(i) == true) {
            PlogThreadJoinTask(i);
        }
    }
    LogFree(g_plogThread);
    g_plogThread = NULL;
    PlogThreadMutexDestroy();
}

#ifdef __cplusplus
}
#endif
