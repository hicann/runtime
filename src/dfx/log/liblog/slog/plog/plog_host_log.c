/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "plog_host_log.h"
#include "plog_file_mgr.h"
#include "plog_buffer_mgr.h"
#include "log_common.h"
#include "log_platform.h"
#include "log_system_api.h"
#include "log_print.h"
#include "dlog_time.h"
#include "dlog_common.h"
#include "log_time.h"
#include "dlog_level_mgr.h"
#include "mmpa_api.h"

#ifdef __cplusplus
extern "C" {
#endif
#define THREAD_SLEEP_INTERVAL 20U
#define THREAD_SLEEP_TIMES    10U

#define PLOG_ASYNC_SAVE 0
#define PLOG_SYNC_SAVE  1

STATIC ToolThread g_alogFlushTid = 0;
STATIC bool g_threadExit = false;
STATIC bool g_threadSleepFlag = true; // true, sleep; false, skip sleep
STATIC ToolMutex g_plogMutex = TOOL_MUTEX_INITIALIZER;
STATIC ToolMutex g_forkMutex = TOOL_MUTEX_INITIALIZER; // lock it before fork to protect critical resource

STATIC int32_t g_plogSyncMode = PLOG_ASYNC_SAVE;

static const LogType SORT_LOG_TYPE[LOG_TYPE_NUM] = { DEBUG_LOG, SECURITY_LOG, RUN_LOG };

STATIC void PlogNotifyFlushThread(void)
{
    (void)__sync_lock_test_and_set(&g_threadSleepFlag, false);
}

STATIC LogStatus PlogMutexInit(void)
{
    return ToolMutexInit(&g_plogMutex);
}

STATIC void PlogMutexDestory(void)
{
    (void)ToolMutexDestroy(&g_plogMutex);
}

STATIC void PlogLock(void)
{
    LOCK_WARN_LOG(&g_plogMutex);
}

STATIC void PlogUnlock(void)
{
    UNLOCK_WARN_LOG(&g_plogMutex);
}

STATIC void PlogChildUnlock(void)
{
    g_alogFlushTid = 0;
    PlogUnlock();
}

STATIC void PlogAtForkCallback(int32_t type)
{
    switch (type) {
        case ATFORK_PREPARE:
            PlogLock();
            (void)ToolMutexLock(&g_forkMutex);
            break;
        case ATFORK_PARENT:
            (void)ToolMutexUnLock(&g_forkMutex);
            PlogUnlock();
            break;
        case ATFORK_CHILD:
            (void)ToolMutexUnLock(&g_forkMutex);
            PlogChildUnlock();
            break;
        default:
            break;
    }
}

/**
 * @brief       : set flag to exit thread
 * @param [in]  : threadExitFlag    exit flag
 */
STATIC INLINE void PlogSetThreadExit(bool threadExitFlag)
{
    g_threadExit = threadExitFlag;
}

/**
 * @brief       : get flag for thread exit
 * @return      : true exit; false not-exit
 */
STATIC INLINE bool PlogIsThreadExit(void)
{
    return g_threadExit;
}

/**
* @brief : flush host log to disk
*/
STATIC void PlogFlushHostLog(int32_t bufferType)
{
    (void)ToolMutexLock(&g_forkMutex); // avoid thread running right here when fork
    uint32_t len = 0;
    char *msg = NULL;
    for (int32_t type = (int32_t)DEBUG_LOG; type < (int32_t)LOG_TYPE_NUM; type++) {
        do {
            LogStatus ret = PlogBuffRead(bufferType, SORT_LOG_TYPE[type], &msg, &len);
            if ((ret != LOG_SUCCESS) || (len == 0)) {
                break;
            }
            ret = PlogWriteHostLog(type, msg, len);
            if (ret == LOG_SUCCESS) {
                continue;
            } else {
                SELF_LOG_WARN("flush host log wrong, loss log, ret=%d, offset=%u.", ret, len);
                break;
            }
        } while (true);
        PlogBuffReset(bufferType, SORT_LOG_TYPE[type]);
    }
    (void)ToolMutexUnLock(&g_forkMutex);
    return;
}

STATIC ArgPtr PlogFlushAppLog(ArgPtr args)
{
    (void)args;
    NO_ACT_WARN_LOG(ToolSetThreadName("PlogFlush") != SYS_OK,
        "can not set thread_name(PlogFlush), pid=%d.", ToolGetPid());

    while (!PlogIsThreadExit()) {
        if (!PlogBuffCheckEmpty(BUFFER_TYPE_WRITE)) {
            PlogLock();
            PlogBuffExchange(); // buffer 区互换
            PlogUnlock();
        }

        if (!PlogBuffCheckEmpty(BUFFER_TYPE_SEND)) {
            PlogFlushHostLog(BUFFER_TYPE_SEND);
        }

        for (uint32_t i = 0; i < THREAD_SLEEP_TIMES; i++) {
            if (__sync_bool_compare_and_swap(&g_threadSleepFlag, false, true)) {
                break;
            } else {
                (void)ToolSleep(THREAD_SLEEP_INTERVAL);
            }
        }
    }

    PlogLock();
    if (!PlogBuffCheckEmpty(BUFFER_TYPE_WRITE)) {
        PlogFlushHostLog(BUFFER_TYPE_WRITE);
    }
    for (int32_t type = (int32_t)DEBUG_LOG; type < (int32_t)LOG_TYPE_NUM; type++) {
        PlogBuffLogLoss(SORT_LOG_TYPE[type]);
    }
    PlogUnlock();
    SELF_LOG_INFO("Thread(alogFlush) quit, pid=%d.", ToolGetPid());
    return NULL;
}

/**
 * @brief       : start thread to flush log
 * @return      : NA
 */
STATIC void PlogStartFlushThread(void)
{
    // start thread
    PlogSetThreadExit(false);
    ToolUserBlock thread;
    thread.procFunc = PlogFlushAppLog;
    thread.pulArg = NULL;
    ToolThreadAttr threadAttr = { 0, 0, 0, 0, 0, 0, 128 * 1024 }; // joinable

    int32_t ret = ToolCreateTaskWithThreadAttr(&g_alogFlushTid, &thread, &threadAttr);
    ONE_ACT_ERR_LOG(ret != SYS_OK, return, "create task FlushAppLog failed, strerr=%s, pid=%d.",
                    strerror(ToolGetErrorCode()), ToolGetPid());
}

/**
 * @brief       : stop thread to flush log
 * @return      : NA
 */
STATIC void PlogStopFlushThread(void)
{
    PlogSetThreadExit(true);
    PlogNotifyFlushThread();
    if (g_alogFlushTid != 0) {
        int32_t ret = ToolJoinTask(&g_alogFlushTid);
        NO_ACT_ERR_LOG(ret != 0, "pthread(alogFlush) join failed, strerr=%s.", strerror(ToolGetErrorCode()));
        g_alogFlushTid = 0;
    }
}

/**
* @brief : write process log from libalog.so
* @param [in]buf: log msg
* @param [in]bufLen: log msg length
* @return: 0: success; -1: failed
*/
STATIC int32_t PlogWriteCallback(const char *data, uint32_t dataLen, LogType type)
{
    ONE_ACT_NO_LOG((data == NULL) || (dataLen == 0), return -1);
    ONE_ACT_NO_LOG(type >= LOG_TYPE_NUM, return -1);
    if (g_alogFlushTid == 0) {
        PlogStartFlushThread();
    }
    PlogLock();

    if (PlogBuffCheckFull(type, dataLen) && (g_plogSyncMode == PLOG_SYNC_SAVE)) {
        PlogFlushHostLog(BUFFER_TYPE_WRITE);
    }

    if (!PlogBuffCheckEnough(type)) {
        PlogNotifyFlushThread();
    }

    int32_t ret = PlogBuffWrite(type, data, dataLen);
    PlogUnlock();
    return ret;
}

/**
 * @brief       clean up buffer before start thread in child_process
 */
STATIC void PlogCleanUpBuff(int32_t bufferType)
{
    for (int32_t type = (int32_t)DEBUG_LOG; type < (int32_t)LOG_TYPE_NUM; type++) {
        PlogBuffReset(bufferType, SORT_LOG_TYPE[type]);
    }
}

/**
* @brief : call by alog.so when fork process printf log
*/
STATIC void PlogForkCallback(void)
{
    PlogLock();
    PlogCleanUpBuff(BUFFER_TYPE_WRITE);
    PlogUnlock();
    PlogCleanUpBuff(BUFFER_TYPE_SEND);
    g_alogFlushTid = 0;
}

static LogStatus PlogGetSyncEnv(int32_t *syncStatus)
{
    const char *env = NULL;
    MM_SYS_GET_ENV(MM_ENV_ASCEND_LOG_SYNC_SAVE, (env));
    if (env != NULL) {
        int64_t tmpL = -1;
        if ((LogStrToInt(env, &tmpL) == LOG_SUCCESS) && ((tmpL == PLOG_ASYNC_SAVE) || (tmpL == PLOG_SYNC_SAVE))) {
            SELF_LOG_INFO("get env ASCEND_LOG_SYNC_SAVE(%" PRId64 ").", tmpL);
            *syncStatus = (int32_t)tmpL;
            return LOG_SUCCESS;
        }
    }
    return LOG_FAILURE;
}

STATIC void PlogSyncInit(void)
{
    LogStatus ret = PlogGetSyncEnv(&g_plogSyncMode);
    ONE_ACT_NO_LOG(ret == LOG_SUCCESS, return);
    if (DlogGetLevelStatus()) {
        g_plogSyncMode = PLOG_SYNC_SAVE;
        SELF_LOG_INFO("the current mode is debug mode, synchronous flushing is triggered when the buffer is full.");
        return;
    }

    SELF_LOG_INFO("can not get sync mode from env, use default: %d", g_plogSyncMode);
    return;
}

STATIC void PlogFlushCallback(void)
{
    PlogLock();
    if (!PlogBuffCheckEmpty(BUFFER_TYPE_WRITE)) {
        PlogFlushHostLog(BUFFER_TYPE_WRITE);
    }
    PlogUnlock();
}

LogStatus PlogHostMgrInit(void)
{
    int32_t ret = PlogMutexInit();
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "init mutex failed, ret=%d.", ret);
    ret = PlogBuffInit();
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "init plog buffer failed, ret=%d.", ret);
    PlogSyncInit();

    // register callback to libalog.so
    ret = RegisterCallback(PlogWriteCallback, LOG_WRITE);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "register report callback failed, ret=%d.", ret);
    ret = RegisterCallback(PlogFlushCallback, LOG_FLUSH);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "register flush callback failed, ret=%d.", ret);
    ret = RegisterCallback(PlogForkCallback, LOG_FORK);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "register fork callback failed, ret=%d.", ret);
    ret = RegisterCallback(PlogAtForkCallback, LOG_ATFORK);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "register atFork callback failed, ret=%d.", ret);

    (void)ToolMutexInit(&g_forkMutex);
    return LOG_SUCCESS;
}

void PlogHostMgrExit(void)
{
    // flush all log and set callback null
    (void)RegisterCallback(NULL, LOG_WRITE);
    (void)RegisterCallback(NULL, LOG_FLUSH);
    (void)RegisterCallback(NULL, LOG_FORK);
    (void)RegisterCallback(NULL, LOG_ATFORK);

    PlogStopFlushThread();

    PlogBuffExit();
    PlogMutexDestory();
    (void)ToolMutexDestroy(&g_forkMutex);
}

#ifdef __cplusplus
}
#endif

