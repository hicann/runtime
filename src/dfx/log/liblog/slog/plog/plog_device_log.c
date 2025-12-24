/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "plog_device_log.h"
#include "log_error_code.h"
#include "log_platform.h"
#include "log_print.h"
#include "dlog_common.h"
#include "plog_drv.h"
#include "ide_tlv.h"
#include "plog_thread.h"
#include "plog_file_mgr.h"
#include "plog.h"
#include "mmpa_api.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
    int timeout;
    char data[0];
} LogNotifyMsg;

#define MAX_TIMEOUT 3000 // timeout 3s
#define MAX_DEVICE_LOG_FLUSH_TIMEOUT (3 * 60 * 1000) // max timeout 180s
#define DEFALUT_DEVICE_LOG_FLUSH_TIMEOUT 2000 // default timeout 2s
#define MAX_RETRY_TIME 3
#define TEN_MILLISECOND 10 // 10 milliseconds

STATIC ToolMutex g_plogHdcMutex = TOOL_MUTEX_INITIALIZER;
STATIC void *g_plogClient = NULL;
STATIC bool g_isInited = false;
STATIC bool g_isExit = false;

/**
 * @brief       : init hdc mutex
 * @return      : NA
 */
STATIC INLINE void DlogReportMutexInit(void)
{
    (void)ToolMutexInit(&g_plogHdcMutex);
}

/**
 * @brief       : Destroy hdc mutex
 * @return      : NA
 */
STATIC INLINE void DlogReportMutexDestroy(void)
{
    (void)ToolMutexDestroy(&g_plogHdcMutex);
}

/**
 * @brief       : lock hdc client mutex
 * @return      : NA
 */
STATIC INLINE void DlogReportLock(void)
{
    (void)ToolMutexLock(&g_plogHdcMutex);
}

/**
 * @brief       : unlock hdc client mutex
 * @return      : NA
 */
STATIC INLINE void DlogReportUnLock(void)
{
    (void)ToolMutexUnLock(&g_plogHdcMutex);
}

STATIC int32_t DlogReportSendReqMsg(uintptr_t session, const char *data, size_t dataLen)
{
    LogNotifyMsg *msg = NULL;
    LogDataMsg *packet = NULL;
    size_t msgLen = sizeof(LogNotifyMsg) + dataLen;

    msg = (LogNotifyMsg *)LogMalloc(msgLen + 1U);
    ONE_ACT_ERR_LOG(msg == NULL, return -1, "calloc failed, strerr=%s.", strerror(ToolGetErrorCode()));

    msg->timeout = 0;
    int32_t ret = memcpy_s(msg->data, dataLen + 1U, data, dataLen);
    ONE_ACT_ERR_LOG(ret != EOK, goto FUNC_END, "copy data failed, strerr=%s.", strerror(ToolGetErrorCode()));

    ret = -1;
    packet = (LogDataMsg *)LogMalloc(sizeof(LogDataMsg) + msgLen + 1U);
    ONE_ACT_ERR_LOG(packet == NULL, goto FUNC_END, "calloc failed, strerr=%s.", strerror(ToolGetErrorCode()));

    packet->totalLen = (uint32_t)msgLen;
    packet->sliceLen = (uint32_t)msgLen;
    packet->offset = 0;
    packet->msgType = LOG_MSG_DATA;
    packet->reqType = IDE_LOG_BACKHAUL_REQ;
    ret = memcpy_s(packet->data, msgLen + 1U, msg, msgLen);
    ONE_ACT_ERR_LOG(ret != 0, goto FUNC_END, "copy failed, ret=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));

    ret = DrvBufWrite((HDC_SESSION)session, (const char *)packet, sizeof(LogDataMsg) + msgLen);
    ONE_ACT_ERR_LOG(ret != 0, goto FUNC_END, "write data to hdc failed, ret=%d.", ret);

FUNC_END:
    XFREE(msg);
    XFREE(packet);
    return ret;
}

/**
 * @brief       : send END message by session
 * @param [in]  : devId         device id
 * @return      : NA
 */
STATIC void DlogReportSendEndMsg(int32_t devId)
{
    uintptr_t session = 0;
    DlogReportLock();
    int32_t ret = DrvSessionInit((HDC_CLIENT)g_plogClient, (HDC_SESSION *)&session, devId);
    DlogReportUnLock();
    ONE_ACT_ERR_LOG(ret != 0, return, "create session failed, ret=%d, devId=%d.", ret, devId);

    ret = DlogReportSendReqMsg(session, HDC_END_BUF, sizeof(HDC_END_BUF));
    NO_ACT_ERR_LOG(ret != 0, "send request info failed, ret=%d, devId=%d.", ret, devId);

    ret = DrvSessionRelease((HDC_SESSION)session);
    ONE_ACT_ERR_LOG(ret != 0, return, "release session failed, ret=%d, devId=%d.", ret, devId);
}

STATIC LogStatus DlogReportSendStartMsg(int32_t devId, uintptr_t *session)
{
    DlogReportLock();
    int32_t ret = DrvSessionInit((HDC_CLIENT)g_plogClient, (HDC_SESSION *)session, devId);
    DlogReportUnLock();
    ONE_ACT_ERR_LOG(ret != 0, return LOG_FAILURE, "create session failed, ret=%d, devId=%d.", ret, devId);

    ret = DlogReportSendReqMsg(*session, HDC_START_BUF, sizeof(HDC_START_BUF));
    if (ret != 0) {
        SELF_LOG_ERROR("send request info failed, devId=%d.", devId);
        (void)DrvSessionRelease((HDC_SESSION)*session);
        *session = 0;
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

/**
 * @brief       : check args in thread run function
 * @param [in]  : pArgs          pointer of thread args
 * @return      : true: check success, false: check fail
 */
STATIC bool DlogReportCheckArges(ThreadArgs *pArgs)
{
    ONE_ACT_ERR_LOG(pArgs == NULL, return false, "args is null.");

    if ((pArgs->devId < 0) || (pArgs->devId >= HOST_MAX_DEV_NUM)) {
        SELF_LOG_ERROR("devId is invalid, release session, devId=%d.", pArgs->devId);
        (void)DrvSessionRelease((HDC_SESSION)pArgs->session);
        return false;
    }

    if (pArgs->session == (uintptr_t)0) {
        SELF_LOG_ERROR("session is null, free plog thread, devId=%d.", pArgs->devId);
        PlogThreadFree(pArgs->devId);
        return false;
    }

    return true;
}

STATIC int32_t DlogReportGetFlushTimeout(void)
{
    int32_t flushTimeout = DEFALUT_DEVICE_LOG_FLUSH_TIMEOUT;
    const char *env = NULL;
    MM_SYS_GET_ENV(MM_ENV_ASCEND_LOG_DEVICE_FLUSH_TIMEOUT, (env));
    if (env != NULL) {
        int64_t tmpL = -1;
        if ((LogStrToInt(env, &tmpL) == LOG_SUCCESS) && (tmpL <= MAX_DEVICE_LOG_FLUSH_TIMEOUT) && (tmpL >= 0)) {
            flushTimeout = (int32_t)tmpL;
            SELF_LOG_INFO("get env ASCEND_LOG_DEVICE_FLUSH_TIMEOUT(%" PRId64 ").", tmpL);
            return flushTimeout;
        } else {
            SELF_LOG_WARN("env ASCEND_LOG_DEVICE_FLUSH_TIMEOUT(%" PRId64 ") invalid.", tmpL);
        }
    }

    SELF_LOG_INFO("set default device log flush timeout(%d).", flushTimeout);
    return flushTimeout;
}

STATIC LogStatus DlogWriteReportLog(char *buf, uint32_t bufLen, int32_t devId)
{
    if ((buf == NULL) || (bufLen == 0)) {
        SELF_LOG_WARN("recv log buf empty, buf=%s, len=%u.", buf, bufLen);
        return LOG_SESSION_RECV_NULL;
    } else if (strncmp(buf, HDC_END_BUF, sizeof(HDC_END_BUF)) == 0) {
        SELF_LOG_WARN("recv end buf by hdc.");
        return LOG_SESSION_RECV_END;
    } else {
        PlogDeviceLogInfo info = { 0, (uint32_t)devId, DEBUG_LOG, 0, 0, 0 };
        int32_t logType = 0;
        char *realBuf = NULL;
        if (buf[0] == '[') {
            logType = (int32_t)DEBUG_LOG;
            realBuf = buf;
            info.len = bufLen;
        } else {
            logType = buf[0] - '0';
            realBuf = buf + 1;
            info.len = bufLen - 1U;
        }
        if ((logType >= (int32_t)DEBUG_LOG) && (logType < (int32_t)LOG_TYPE_NUM)) {
            static const LogType sortLogType[LOG_TYPE_NUM] = { DEBUG_LOG, SECURITY_LOG, RUN_LOG };
            info.logType = sortLogType[logType];
        }
        NO_ACT_WARN_LOG(PlogWriteDeviceLog(realBuf, &info) != LOG_SUCCESS, "can not write device log.");
        return LOG_SUCCESS;
    }
}

/**
 * @brief       : plog thread run function
 * @param [in]  : pArgs          pointer of thread args
 * @return      : NA
 */
STATIC void* DlogReportRecvThread(void *pArgs)
{
    NO_ACT_WARN_LOG(ToolSetThreadName("PlogReportRecv") != SYS_OK, "can not set thread name(PlogReportRecv).");
    ONE_ACT_ERR_LOG(pArgs == NULL, return NULL, "args is null.");
    ONE_ACT_WARN_LOG(DlogReportCheckArges((ThreadArgs *)pArgs) == false, return NULL,
                     "invalid thread args, log recv thread exited.");
    const int32_t devId = ((ThreadArgs *)pArgs)->devId;
    uintptr_t session = ((ThreadArgs *)pArgs)->session;

    char *buf = NULL;
    uint32_t bufLen = 0;
    int32_t retryTime = 0;
    int32_t flushTimeout = DlogReportGetFlushTimeout();
    while (retryTime < MAX_RETRY_TIME) {
        // compute timeout for every retry time, max retry time is <MAX_RETRY_TIME>
        int32_t recvTimeout = g_isExit ? (flushTimeout / MAX_RETRY_TIME) : MAX_TIMEOUT;
        // if session is invalid, restart it
        if ((session == 0) && (DlogReportSendStartMsg(devId, &session) != LOG_SUCCESS)) {
            ONE_ACT_NO_LOG(PlogThreadGetStatus(devId) == THREAD_STATUS_WAIT_EXIT, retryTime = MAX_RETRY_TIME);
            (void)ToolSleep(TEN_MILLISECOND); // sleep 10ms
            continue;
        }
        LogStatus ret = DrvBufRead((HDC_SESSION)session, devId, (char **)&buf, &bufLen, (uint32_t)recvTimeout);
        if (ret != LOG_SUCCESS) {
            ONE_ACT_NO_LOG(PlogThreadGetStatus(devId) == THREAD_STATUS_WAIT_EXIT, retryTime++);
            TWO_ACT_NO_LOG(ret == LOG_SESSION_CLOSE, (void)DrvSessionRelease((HDC_SESSION)session), session = 0);
            (void)ToolSleep(TEN_MILLISECOND); // sleep 10ms
            continue;
        }
        ret = DlogWriteReportLog(buf, bufLen, devId);
        if (ret == LOG_SUCCESS) {
            retryTime = 0;
        } else if (ret == LOG_SESSION_RECV_END) {
            retryTime = MAX_RETRY_TIME; // then exit loop
        } else {
            ;
        }
        XFREE(buf);
        bufLen = 0;
    }

    (void)DrvSessionRelease((HDC_SESSION)session);
    SELF_LOG_INFO("Log recv thread exited, devId=%d.", devId);

    return NULL;
}

int32_t DlogReportStartInner(int32_t devId, int32_t mode)
{
    if ((devId >= HOST_MAX_DEV_NUM) || (devId < 0)) {
        SELF_LOG_ERROR("start report failed, device id is invalid, devId=%d.", devId);
        return SYS_ERROR;
    }
    if (devId == HOST_AI_DEVID) { // 64 used for host aicpu
        SELF_LOG_WARN("it's for host aicpu, devId=%d.", devId);
        return SYS_OK;
    }

    if (PlogThreadSingleTask(devId)) {
        SELF_LOG_WARN("thread has been started, devId=%d.", devId);
        return SYS_OK;
    }
    // send START message by session
    uintptr_t session;
    ONE_ACT_NO_LOG(DlogReportSendStartMsg(devId, &session) != LOG_SUCCESS, return SYS_ERROR);

    // create thread to recv device plog
    ThreadArgs args = {devId, session};
    LogStatus ret = PlogThreadCreate(devId, &args, DlogReportRecvThread);
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("create task(DlogReportRecvThread) failed, devId=%d.", devId);
        (void)DrvSessionRelease((HDC_SESSION)session);
        return SYS_ERROR;
    }

    SELF_LOG_INFO("start to recv device log, devId=%d, mode=%d.", devId, mode);
    return SYS_OK;
}

void DlogReportStopInner(int32_t devId)
{
    if ((devId >= HOST_MAX_DEV_NUM) || (devId < 0)) {
        SELF_LOG_ERROR("stop report failed, device id is invalid, devId=%d.", devId);
        return;
    }
    if (devId == HOST_AI_DEVID) { // 64 used for host aicpu
        SELF_LOG_WARN("it's for host aicpu, devId=%d.", devId);
        return;
    }

    PlogThreadRelease(devId, DlogReportSendEndMsg, false);
    SELF_LOG_INFO("stop to recv device log, devId=%d.", devId);
}

int32_t DlogReportInitializeInner(void)
{
    ONE_ACT_NO_LOG(g_isInited == true, return 0);
    g_isInited = true;

    uint32_t platform = 0;
    if (DrvGetPlatformInfo(&platform) != 0) {
        SELF_LOG_ERROR("get platform info failed.");
        g_isInited = false;
        return -1;
    }
    ONE_ACT_NO_LOG(platform != HOST_SIDE, return 0); // only support host or docker

    // create hdc client
    DlogReportLock();
    int32_t ret = DrvClientCreate((HDC_CLIENT)&g_plogClient, (int32_t)HDC_SERVICE_TYPE_LOG);
    DlogReportUnLock();
    ONE_ACT_ERR_LOG(ret != 0, goto INIT_ERROR, "create hdc client failed.");

    // init plog thread to recv device plog
    ret = PlogThreadPoolInit();
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, goto INIT_ERROR, "init thread pool failed.");

    g_isExit = false;
    SELF_LOG_INFO("Dlog initialize finished for process.");
    return 0;

INIT_ERROR:
    DlogReportLock();
    (void)DrvClientRelease((HDC_CLIENT)g_plogClient);
    g_plogClient = NULL;
    DlogReportUnLock();
    g_isInited = false;
    SELF_LOG_ERROR("Dlog initialize failed for process.");
    return -1;
}

int32_t DlogReportFinalizeInner(void)
{
    ONE_ACT_NO_LOG(g_isExit, return 0);
    g_isExit = true;

    uint32_t platform = 0; // 0: device side, 1: host side
    ONE_ACT_ERR_LOG(DrvGetPlatformInfo(&platform) != 0, return -1, "get platform info failed.");
    ONE_ACT_NO_LOG(platform != HOST_SIDE, return 0); // only support host or docker

    // release all recv thread
    PlogThreadPoolExit(DlogReportSendEndMsg);

    // release hdc client
    DlogReportLock();
    int32_t ret = DrvClientRelease((HDC_CLIENT)g_plogClient);
    g_plogClient = NULL;
    DlogReportUnLock();
    NO_ACT_ERR_LOG(ret != 0, "free hdc client failed.");

    g_isInited = false;
    SELF_LOG_INFO("Dlog finalize finished.");
    return 0;
}

/**
 * @brief       : init resource for device log(device-x)
 * @return      : LOG_SUCCESS  success; other  failed
 */
LogStatus PlogDeviceMgrInit(void)
{
    // init mutex to lock hdc client
    DlogReportMutexInit();
    int32_t ret = DlogReportInitializeInner();
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "dlog report ininialize failed, ret=%d.", ret);

    return LOG_SUCCESS;
}

/**
 * @brief       : free resource for device log
 * @return      : LOG_SUCCESS  success; other  failed
 */
void PlogDeviceMgrExit(void)
{
    (void)DlogReportFinalizeInner();
    // destroy hdc mutex
    DlogReportMutexDestroy();
}

#ifdef __cplusplus
}
#endif

