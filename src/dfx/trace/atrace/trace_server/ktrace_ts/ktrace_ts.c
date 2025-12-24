/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ktrace_ts.h"
#include "adiag_lock.h"
#include "adiag_print.h"
#include "adiag_utils.h"
#include "ascend_hal.h"
#include "trace_msg.h"
#include "trace_node.h"
#include "trace_server_mgr.h"
#include "trace_system_api.h"

#define MAX_DEV_NUM                 64
#define DRV_RECV_MAX_LEN            524288
#define TRACE_RECV_TIMEOUT          500
#define GET_DEV_ID_RETRY_INTERVAL   1000 * 1000
#define GET_DEV_ID_RETRY_TIMES      10

typedef struct {
    TraceThread tid;
    uint32_t devId;
    int32_t status;
} ThreadInfo;

typedef struct {
    uint32_t pid;
    uint32_t logSize;
    uint8_t endFlag; // 0 start; 1 mid; 2 end
    uint8_t reserve[23];
} TraceInfoHead;

STATIC ThreadInfo **g_ktraceTsThread = NULL;
STATIC AdiagLock g_ktraceTsLock = TRACE_MUTEX_INITIALIZER;
STATIC int32_t g_ktraceTsStatus = 0;
STATIC uint32_t g_devNum = 0;

/**
 * @brief           get event time when each event start.
 * @param [in]      sessionNode:         sessionNode
 * @param [in]      endFlag:             event flag
 * @param [out]     time:                event time
 * @param [in]      len:                 time length
 * @return          TraStatus
 */
STATIC TraStatus KtraceGetEventTime(SessionNode *sessionNode, uint8_t endFlag, char *time, uint32_t len)
{
    if ((strlen(sessionNode->eventTime) == 0) || (endFlag == ADIAG_INFO_FLAG_START)) {
        (void)memset_s(sessionNode->eventTime, TIMESTAMP_MAX_LENGTH, 0, TIMESTAMP_MAX_LENGTH);
        TraStatus ret = TimestampToFileStr(GetRealTime(), sessionNode->eventTime, TIMESTAMP_MAX_LENGTH);
        if (ret != TRACE_SUCCESS) {
            ADIAG_ERR("get timestamp failed, ret = %d.", ret);
            return TRACE_FAILURE;
        }
    }
    errno_t err = strncpy_s(time, len, sessionNode->eventTime, TIMESTAMP_MAX_LENGTH);
    if (err != EOK) {
        ADIAG_ERR("strncpy timestamp failed, err = %d, strerr = %s", (int32_t)err, strerror(AdiagGetErrorCode()));
        return TRACE_FAILURE;
    }
    if (endFlag == ADIAG_INFO_FLAG_END) {
        (void)memset_s(sessionNode->eventTime, TIMESTAMP_MAX_LENGTH, 0, TIMESTAMP_MAX_LENGTH);
    }
    return TRACE_SUCCESS;
}

STATIC TraStatus KtracePushDataToNode(TraceInfoHead *head, TraceEventMsg *eventMsg)
{
    SessionNode *sessionNode = TraceServerGetSessionNode((int32_t)head->pid, (int32_t)eventMsg->devId);
    if (sessionNode == NULL) {
        ADIAG_WAR("no session node is valid, pid = %u.", head->pid);
        return TRACE_FAILURE;
    }
    TraStatus ret = KtraceGetEventTime(sessionNode, head->endFlag, eventMsg->eventTime, TIMESTAMP_MAX_LENGTH);
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("get event time failed, ret = %d, pid = %u.", ret, head->pid);
        return TRACE_FAILURE;
    }

    ret = TraceTsPushNode(sessionNode, head->endFlag, (void *)eventMsg, eventMsg->bufLen + sizeof(TraceEventMsg));
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("push node failed, ret = %d, pid = %u.", ret, head->pid);
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

/**
 * @brief           parse data from ts and construct to event msg.
 * @param [in]      traceInfo:         data from ts
 * @param [in]      len:               length of data from ts
 * @param [in]      devId:             device id
 * @return          NA
 */
STATIC void KtraceDataProcess(char *traceInfo, uint32_t len, uint32_t localDevId, uint32_t devId)
{
    ADIAG_CHK_EXPR_ACTION((len > DRV_RECV_MAX_LEN) || (len < sizeof(TraceInfoHead)),
        return, "invalid length[%u] from driver", len);
    TraceInfoHead *head = (TraceInfoHead *)traceInfo;
    ADIAG_CHK_EXPR_ACTION(head->logSize >= len, return,
        "data len[%u] is over max len[%u] from ts.", head->logSize, len);

    TraceEventMsg *eventMsg = (TraceEventMsg *)AdiagMalloc(sizeof(TraceEventMsg) + head->logSize + 1U);
    if (eventMsg == NULL) {
        ADIAG_ERR("malloc for event msg failed.");
        return;
    }
    eventMsg->msgType = TRACE_EVENT_MSG;
    eventMsg->devId = localDevId;
    eventMsg->pid = (int32_t)head->pid;
    eventMsg->seqFlag = head->endFlag;
    eventMsg->bufLen = head->logSize;
    errno_t err = memcpy_s(eventMsg->buf, head->logSize + 1U, traceInfo + sizeof(TraceInfoHead), head->logSize);
    if (err != EOK) {
        ADIAG_ERR("memcpy failed, err = %d, strerr = %s.", (int32_t)err, strerror(AdiagGetErrorCode()));
        ADIAG_SAFE_FREE(eventMsg);
        return;
    }
    int32_t ret = snprintf_s(eventMsg->eventName, EVENT_NAME_MAX_LENGTH, EVENT_NAME_MAX_LENGTH - 1U, "ts_%u", devId);
    if (ret == -1) {
        ADIAG_ERR("snprintf failed, ret = %d, strerr = %s.", ret, strerror(AdiagGetErrorCode()));
        ADIAG_SAFE_FREE(eventMsg);
        return;
    }
    TraceServerSessionLock();
    ret = KtracePushDataToNode(head, eventMsg);
    TraceServerSessionUnlock();
    if (ret != TRACE_SUCCESS) {
        ADIAG_SAFE_FREE(eventMsg);
        return;
    }
    ADIAG_INF("log read by type successfully, pid = %d, data len = %u bytes, end flag = %hhu.",
        eventMsg->pid, eventMsg->bufLen, eventMsg->seqFlag);
    return;
}

/**
 * @brief           convert device-side devId to host-side devId
 * @param [in]      localDeviceId:         chip ID
 * @return          host side devId (physical id)
 */
STATIC uint32_t KtraceGetPhysicalDeviceID(uint32_t localDeviceId)
{
    uint32_t phyDeviceId = 0;
    drvError_t ret = DRV_ERROR_NONE;
    uint32_t retryTime = 0;
    do {
        ret = drvGetDevIDByLocalDevID(localDeviceId, &phyDeviceId);
        if (ret == DRV_ERROR_NONE) {
            break;
        }
        usleep(GET_DEV_ID_RETRY_INTERVAL);
        retryTime++;
    } while (retryTime < GET_DEV_ID_RETRY_TIMES);
    if (ret != DRV_ERROR_NONE) {
        ADIAG_WAR("get physical device-id by local device-id=%u, result=%d", localDeviceId, ret);
        return localDeviceId;
    }
    return phyDeviceId;
}

/**
 * @brief           thread to get data from ts.
 * @param [in]      arg:         thread info
 * @return          NULL
 */
STATIC void *KtraceTsThread(void *arg)
{
    ADIAG_CHK_NULL_PTR(arg, return NULL);
    ThreadInfo *info = (ThreadInfo *)arg;
    uint32_t phyDeviceId = KtraceGetPhysicalDeviceID(info->devId);
    ADIAG_RUN_INF("ktrace ts thread start, local device id = %u, physical device id = %u.", info->devId, phyDeviceId);
    if (TraceSetThreadName("TraceServerRecv") != TRACE_SUCCESS) {
        ADIAG_WAR("can not set thread name(TraceServerRecv) but continue.");
    }
    char *traceInfo = (char *)AdiagMalloc(DRV_RECV_MAX_LEN);
    if (traceInfo == NULL) {
        ADIAG_ERR("trace info malloc failed, strerr=%s.", strerror(AdiagGetErrorCode()));
        return NULL;
    }
    while (info->status != 0) {
        (void)memset_s(traceInfo, DRV_RECV_MAX_LEN, 0, DRV_RECV_MAX_LEN);
        uint32_t len = DRV_RECV_MAX_LEN;
        int32_t ret = log_read_by_type((int32_t)info->devId, traceInfo, &len,
            TRACE_RECV_TIMEOUT, LOG_CHANNEL_TYPE_TS_PROC);
        if (ret == (int32_t)LOG_NOT_SUPPORT) {
            ADIAG_RUN_INF("ts channel is not supported.");
            break;
        }
        if (ret == (int32_t)LOG_NOT_READY) {
            continue;
        }
        if (ret != TRACE_SUCCESS) {
            ADIAG_WAR("can not read trace data from driver, ret = %d, strerr=%s.", ret, strerror(AdiagGetErrorCode()));
            usleep(TRACE_RECV_TIMEOUT * TIME_ONE_THOUSAND_MS);
            continue;
        }
        KtraceDataProcess(traceInfo, len, info->devId, phyDeviceId);
    }
    ADIAG_SAFE_FREE(traceInfo);
    return NULL;
}

STATIC TraStatus KtraceTsRecvThread(uint32_t devIndex, uint32_t devId)
{
    g_ktraceTsThread[devIndex] = (ThreadInfo *)AdiagMalloc(sizeof(ThreadInfo));
    if (g_ktraceTsThread[devIndex] == NULL) {
        ADIAG_ERR("malloc ktrace ts thread failed, device id = %u.", devId);
        return TRACE_FAILURE;
    }
    g_ktraceTsThread[devIndex]->status = 1;
    g_ktraceTsThread[devIndex]->devId = devId;
 
    TraceUserBlock thread;
    thread.procFunc = KtraceTsThread;
    thread.pulArg = (void *)g_ktraceTsThread[devIndex];
    TraceThreadAttr attr = { 0, 0, 0, 0, 0, 0, TRACE_THREAD_STACK_SIZE };
    TraceThread tid = 0;
    if (TraceCreateTaskWithThreadAttr(&tid, &thread, &attr) != TRACE_SUCCESS) {
        ADIAG_ERR("create task failed, strerr=%s.", strerror(AdiagGetErrorCode()));
        return TRACE_FAILURE;
    }
    g_ktraceTsThread[devIndex]->tid = tid;
    return TRACE_SUCCESS;
}

/**
 * @brief           create thread to data from ts for each device.
 * @param [in]      devNum:         device number
 * @param [in]      devIdArray:     device id array
 * @return          TraStatus
 */
TraStatus KtraceTsCreateThread(uint32_t devNum, uint32_t *devIdArray)
{
    if ((devNum > MAX_DEV_NUM) || (devIdArray == NULL)) {
        ADIAG_ERR("ktrace ts receive thread init failed.");
        return TRACE_FAILURE;
    }

    if (g_ktraceTsStatus != 0) {
        ADIAG_ERR("ktrace ts receive thread has already existed.");
        return TRACE_FAILURE;
    }

    (void)AdiagLockInit(&g_ktraceTsLock);
    (void)AdiagLockGet(&g_ktraceTsLock);
    g_ktraceTsStatus = 1;
    g_devNum = devNum;
    g_ktraceTsThread = (ThreadInfo **)AdiagMalloc(sizeof(ThreadInfo *) * (size_t)devNum);
    if (g_ktraceTsThread == NULL) {
        ADIAG_ERR("malloc ktrace ts thread failed.");
        (void)AdiagLockRelease(&g_ktraceTsLock);
        KtraceTsDestroyThread();
        return TRACE_FAILURE;
    }

    TraStatus ret = TRACE_SUCCESS;
    for (uint32_t i = 0; i < devNum; i++) {
        ret = KtraceTsRecvThread(i, devIdArray[i]);
        if (ret != TRACE_SUCCESS) {
            ADIAG_ERR("ktrace create ts receive thread failed, device id = %u.", i);
            (void)AdiagLockRelease(&g_ktraceTsLock);
            KtraceTsDestroyThread();
            return TRACE_FAILURE;
        }
    }

    (void)AdiagLockRelease(&g_ktraceTsLock);
    ADIAG_RUN_INF("create ts ktrace thread successfully.");
    return TRACE_SUCCESS;
}

void KtraceTsDestroyThread(void)
{
    if (g_ktraceTsStatus == 0) {
        return;
    }
    (void)AdiagLockGet(&g_ktraceTsLock);
    g_ktraceTsStatus = 0;
    if (g_ktraceTsThread == NULL) {
        (void)AdiagLockRelease(&g_ktraceTsLock);
        (void)AdiagLockDestroy(&g_ktraceTsLock);
        return;
    }
    for (uint32_t i = 0; i < g_devNum; i++) {
        if (g_ktraceTsThread[i] != NULL) {
            g_ktraceTsThread[i]->status = 0;
        }
    }
    for (uint32_t i = 0; i < g_devNum; i++) {
        if ((g_ktraceTsThread[i] != NULL) && (g_ktraceTsThread[i]->tid != 0)) {
            (void)TraceJoinTask(&g_ktraceTsThread[i]->tid);
        }
        ADIAG_SAFE_FREE(g_ktraceTsThread[i]);
    }
    ADIAG_SAFE_FREE(g_ktraceTsThread);
    (void)AdiagLockRelease(&g_ktraceTsLock);
    (void)AdiagLockDestroy(&g_ktraceTsLock);
    ADIAG_RUN_INF("destroy ts ktrace thread successfully.");
}