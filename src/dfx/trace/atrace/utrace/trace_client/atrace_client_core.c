/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "atrace_client_core.h"
#include "atrace_client_communication.h"
#include "atrace_client_thread.h"
#include "adiag_print.h"
#include "trace_attr.h"
#include "trace_msg.h"
#include "trace_recorder.h"
#include "trace_types.h"
#include "trace_system_api.h"

#define HOST_AI_DEVID       64
#define MAX_RETRY_TIME      3
#define TEN_MILLISECOND     (10 * 1000) // 10 milliseconds
#define RECV_BUFF_SIZE      (512U * 1024U + (uint32_t)sizeof(TraceEventMsg)) // 512K + head

STATIC void AtraceClientWriteEventLog(char *data, uint32_t len)
{
    TraceMsgInfo info = { 0 };
    (void)AtraceClientParseEventMsg(data, len, &info);
    // write to file
    TraceDirInfo dirInfo = { TRACER_SCHEDULE_NAME, TraceGetPid(), info.eventTime };
    TraceFileInfo fileInfo = { 0 };
    fileInfo.tracerName = TRACER_SCHEDULE_NAME;
    fileInfo.objName = info.eventName;
    if (info.saveType == FILE_SAVE_MODE_BIN) {
        fileInfo.suffix = TRACE_FILE_BIN_SUFFIX;
    } else {
        fileInfo.suffix = TRACE_FILE_TXT_SUFFIX;
    }
    int32_t fd = -1;
    if (TraceRecorderGetFd(&dirInfo, &fileInfo, &fd) != TRACE_SUCCESS) {
        ADIAG_ERR("get event fd failed, event name=%s.", info.eventName);
        return;
    }
    TraStatus ret = TraceRecorderWrite(fd, info.buf, info.bufLen);
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("write to file failed, ret = %d, strerr = %s.", ret, strerror(AdiagGetErrorCode()));
    }
    TraceClose(&fd);
}

STATIC void AtraceClientRecvAndWrite(int32_t devId, int32_t timeout, void **handle)
{
    char *data = (char *)AdiagMalloc(RECV_BUFF_SIZE);
    if (data == NULL) {
        ADIAG_ERR("malloc buffer failed, devId=%d.", devId);
        return;
    }
    uint32_t bufLen = 0;
    int32_t retryTime = 0;
    TraStatus ret = TRACE_FAILURE;
    int32_t recvTimeout = timeout / MAX_RETRY_TIME;
    while (retryTime < MAX_RETRY_TIME) {
        if (!AtraceClientIsHandleValid(*handle)) { // handle is invalid
            AtraceClientReleaseHandle(handle);
            if (AtraceThreadGetStatus(devId) == THREAD_STATUS_WAIT_EXIT) {
                break;
            }
            ret = AtraceClientCreateLongLink(devId, timeout, handle);
            if (ret == TRACE_SUCCESS) {
                continue;
            }
            (void)usleep(TEN_MILLISECOND); // sleep 10ms
            continue;
        }
        bufLen = RECV_BUFF_SIZE;
        ret = AtraceClientRecv(*handle, (char **)&data, &bufLen, recvTimeout);
        if (AtraceThreadGetStatus(devId) == THREAD_STATUS_WAIT_EXIT) {
            retryTime++;
        }
        if ((ret != TRACE_SUCCESS) || (bufLen == 0U)) {
            (void)usleep(TEN_MILLISECOND); // sleep 10ms
            continue;
        }

        if (AtraceClientIsEventMsg(data, bufLen)) {
            ADIAG_DBG("atrace client receive event msg, buffer len = %u bytes.", bufLen);
            retryTime = 0;
            // write to file
            AtraceClientWriteEventLog(data, bufLen);
        } else if (AtraceClientIsEndMsg(data, bufLen)) {
            ADIAG_RUN_INF("receive end msg, devId=%d.", devId);
            break;
        } else {
            ADIAG_ERR("message is invalid, devId=%d.", devId);
        }
    }
    ADIAG_SAFE_FREE(data);
}

/**
 * @brief       : atrace client thread run function
 * @param [in]  : pArgs          pointer of thread args
 * @return      : NA
 */
STATIC void* AtraceClientRecvThread(void *pArgs)
{
    if (pArgs == NULL) {
        ADIAG_ERR("args is null.");
        return NULL;
    }
    if (TraceSetThreadName("TraceClientRecv") != TRACE_SUCCESS) {
        ADIAG_WAR("can not set thread name(TraceClientRecv) but continue.");
    }
    const int32_t devId = ((TraceThreadArgs *)pArgs)->devId;

    int32_t timeout = TraceGetTimeout();
    void *handle = NULL;
    TraStatus ret = AtraceClientCreateLongLink(devId, timeout, &handle);
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("create long link failed, devId=%d.", devId);
        return NULL;
    }
    const int32_t timeReserve = 1000; // 1s for receive thread waiting device timeout exit
    AtraceClientRecvAndWrite(devId, timeout + timeReserve, &handle);
    AtraceClientReleaseHandle(&handle);
    ADIAG_RUN_INF("atrace receive thread exited, devId=%d.", devId);
    return NULL;
}

TraStatus AtraceClientStart(int32_t devId)
{
    if ((devId >= HOST_MAX_DEV_NUM) || (devId < 0)) {
        ADIAG_ERR("atrace client start failed, device id [%d] is invalid.", devId);
        return TRACE_INVALID_PARAM;
    }
    if (devId == HOST_AI_DEVID) {
        ADIAG_INF("devId[%d] no need to create a thread.", devId);
        return TRACE_SUCCESS;
    }

    if (AtraceThreadSingleTask(devId)) {
        ADIAG_RUN_INF("thread has been started, devId=%d.", devId);
        return TRACE_SUCCESS;
    }

    TraStatus ret = AtraceClientSendHello(devId);
    if (ret != TRACE_SUCCESS) {
        ADIAG_WAR("can not send hello, devId=%d.", devId);
        return TRACE_UNSUPPORTED;
    }
    // create thread to receive device trace log
    TraceThreadArgs args = { devId };
    ret = AtraceThreadCreate(devId, &args, AtraceClientRecvThread);
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("create thread failed, devId=%d, ret=%d.", devId, ret);
        return TRACE_FAILURE;
    }

    ADIAG_RUN_INF("start to receive device[%d] trace log.", devId);
    return TRACE_SUCCESS;
}

void AtraceClientStop(int32_t devId)
{
    if ((devId >= HOST_MAX_DEV_NUM) || (devId < 0)) {
        ADIAG_ERR("stop report failed, device id is invalid, devId=%d.", devId);
        return;
    }
    if (devId == HOST_AI_DEVID) {
        ADIAG_INF("devId[%d] no need to stop a thread.", devId);
        return;
    }

    AtraceThreadRelease(devId, AtraceClientSendEnd, false);
    ADIAG_RUN_INF("stop to receive device[%d] trace log.", devId);
}

TraStatus AtraceClientInit(void)
{
    // init thread pool
    TraStatus ret = AtraceThreadPoolInit();
    ADIAG_CHK_EXPR_ACTION(ret != TRACE_SUCCESS, return ret, "init thread pool failed.");

    ADIAG_INF("init atrace client successfully.");
    return TRACE_SUCCESS;
}

void AtraceClientExit(void)
{
    // release all receive thread
    AtraceThreadPoolExit(AtraceClientSendEnd);
}