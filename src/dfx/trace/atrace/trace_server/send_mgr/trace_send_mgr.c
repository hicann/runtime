/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "trace_send_mgr.h"
#include "trace_server_mgr.h"
#include "trace_system_api.h"
#include "adx_component_api_c.h"
#include "trace_queue.h"
#include "adiag_print.h"
#include "trace_session_mgr.h"
#include "trace_node.h"
#include "trace_adx_api.h"

STATIC TraceThread g_traceSendThread = 0;
STATIC bool g_traceSendThreadState = false;

TraStatus TraceServiceInit(int32_t devId)
{
    TraStatus ret = AdxRegisterService((int32_t)HDC_SERVICE_TYPE_BBOX,
        COMPONENT_TRACE, TraceDeviceInit, TraceDeviceProcess, TraceDeviceExit);
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("register component function error, ret = %d.", ret);
        return TRACE_FAILURE;
    }
    int32_t mode = (devId == -1) ? 0 : 1;   // 0 denotes pf , 1 denotes vf
    ServerInitInfo serverInfo = {(int32_t)HDC_SERVICE_TYPE_BBOX, mode, devId};
    ret = AdxServiceStartup(serverInfo);
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("startup component server error, ret = %d.", ret);
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

STATIC TraStatus TraceServerSendEndMsg(const void *handle)
{
    TraceEndMsg msg = { 0 };
    msg.msgType = TRACE_END_MSG;
    TraStatus ret = TraceAdxSendMsg(handle, (const char *)&msg, sizeof(TraceEndMsg));
    TraStatus retEnd = TraceAdxSendMsg(handle, HDC_END_MSG, strlen(HDC_END_MSG));
    if ((ret != TRACE_SUCCESS) || (retEnd != TRACE_SUCCESS)) {
        ADIAG_ERR("send end msg failed, ret = %d, retEnd = %d.", ret, retEnd);
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

STATIC void TraceServerSendNodeToClient(SessionNode *sessionNode, int8_t listFlag)
{
    TraStatus ret;
    TraceNode *node = TraceTsPopNode(sessionNode);
    while (node != NULL) {
        ret = TraceAdxSendMsg(sessionNode->handle, node->data, node->dataLen);
        if (ret != TRACE_SUCCESS) {
            ADIAG_ERR("send msg failed, pid = %d, data length = %u bytes.", sessionNode->pid, node->dataLen);
        }
        if ((listFlag == DELETED_SESSION_LIST) && (node->flag == ADIAG_INFO_FLAG_END)) {
            ret = TraceServerSendEndMsg(sessionNode->handle);
            if (ret != TRACE_SUCCESS) {
                ADIAG_ERR("send end msg failed, pid = %d.", sessionNode->pid);
            }
            sessionNode->timeout = 0;
        }
        ADIAG_DBG("send msg successfully, pid = %d, dataLen = %u bytes.", sessionNode->pid, node->dataLen);
        XFreeTraceNode(&node);
        node = TraceTsPopNode(sessionNode);
    }
}

/**
 * @brief           thread to send node info to client.
 * @param [in]      arg:         NULL
 * @return          NULL
 */
STATIC void *TraceServerSendThread(void *arg)
{
    (void)arg;
    ADIAG_RUN_INF("trace server send thread start.");
    if (TraceSetThreadName("TraceServerSend") != TRACE_SUCCESS) {
        ADIAG_WAR("can not set thread name(TraceServerSend) but continue.");
    }
    while (g_traceSendThreadState) {
        if (!TraceIsDeletedSessionNodeListNull()) {
            TraceServerHandleDeletedSessionNode(TraceServerSendNodeToClient);
        }
        if (!TraceIsSessionNodeListNull()) {
            TraceServerHandleSessionNode(TraceServerSendNodeToClient);
        }
        usleep(SESSION_TIME_INTERVAL * TIME_ONE_THOUSAND_MS);
    }
    return NULL;
}

TraStatus TraceServerCreateSendThread(void)
{
    TraceUserBlock thread;
    thread.procFunc = TraceServerSendThread;
    thread.pulArg = NULL;
    TraceThreadAttr attr = { 0, 0, 0, 0, 0, 0, TRACE_THREAD_STACK_SIZE };
    TraceThread tid = 0;
    g_traceSendThreadState = true;
    if (TraceCreateTaskWithThreadAttr(&tid, &thread, &attr) != TRACE_SUCCESS) {
        ADIAG_ERR("create trace server send thread failed, strerr=%s.", strerror(AdiagGetErrorCode()));
        return TRACE_FAILURE;
    }
    g_traceSendThread = tid;
    ADIAG_RUN_INF("create trace server send thread successfully.");
    return TRACE_SUCCESS;
}

void TraceServerDestroySendThread(void)
{
    if (!g_traceSendThreadState) {
        return;
    }
    g_traceSendThreadState = false;
    if (g_traceSendThread != 0) {
        (void)TraceJoinTask(&g_traceSendThread);
    }
    ADIAG_RUN_INF("destroy trace server send thread successfully.");
}