/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "trace_server_socket.h"
#include "grp.h"
#include "adiag_utils.h"
#include "adiag_print.h"
#include "trace_system_api.h"
#include "trace_session_mgr.h"
#include "trace_node.h"
#include "trace_msg.h"

#define SIZE_SIXTEEN_MB         (16 * 1024 * 1024) // 16MB
#define SOCKET_TIME_INTERVAL    10000 // 10ms
#define SOCKET_MAX_DATA_SIZE    524288U
#ifndef TRACE_SERVER_USER_NAME
#define TRACE_SERVER_USER_NAME  "HwHiAiUser"
#endif

STATIC int32_t g_sockFd = -1;
STATIC char g_socketPath[SOCKET_PATH_MAX_LENGTH] = { 0 };
STATIC TraceThread g_traceSocketThread = 0;
STATIC bool g_traceSocketThreadState = false;

STATIC int32_t TraceGetSocketPath(int32_t devId, char *socketPath, uint32_t len)
{
    if (devId == -1) {
        int32_t ret = sprintf_s(socketPath, len, "%s%s", SOCKET_FILE_DIR, SOCKET_FILE);
        if (ret == -1) {
            ADIAG_ERR("snprintf_s socket path failed, strerr=%s, pid=%d.", strerror(AdiagGetErrorCode()), getpid());
            return TRACE_FAILURE;
        }
    } else {
        int32_t ret = sprintf_s(socketPath, len, "%s%s_%d", SOCKET_FILE_DIR, SOCKET_FILE, devId);
        if (ret == -1) {
            ADIAG_ERR("snprintf_s socket path failed, strerr=%s, pid=%d, vfid=%u.",
                strerror(AdiagGetErrorCode()), getpid(), devId);
            return TRACE_FAILURE;
        }
    }
    return TRACE_SUCCESS;
}

STATIC int32_t TraceCreateSocketByFile(char *socketPath, const char *groupName, uint32_t permission)
{
    struct sockaddr_un addr;
    int32_t nSendBuf = SIZE_SIXTEEN_MB;
    (void)memset_s(&addr, sizeof(addr), 0, sizeof(addr));
    addr.sun_family = AF_UNIX;

    errno_t err = strcpy_s(addr.sun_path, sizeof(addr.sun_path), socketPath);
    ADIAG_CHK_EXPR_ACTION(err != EOK, return -1,
        "strcpy_s failed, result=%d, strerr=%s.", (int32_t)err, strerror(AdiagGetErrorCode()));

    // Unlink the previous socket file first.
    int32_t ret = unlink(addr.sun_path);
    if (ret != 0) {
        ADIAG_WAR("can not unlink file=%s, strerr=%s.", addr.sun_path, strerror(AdiagGetErrorCode()));
    }

    // Create socket.
    int32_t sockFd = TraceSocket(AF_UNIX, SOCK_DGRAM, 0);
    ADIAG_CHK_EXPR_ACTION(sockFd < 0, return -1,
        "create socket failed, strerr=%s.", strerror(AdiagGetErrorCode()));

    do {
        // Set socket description.
        ret = setsockopt(sockFd, SOL_SOCKET, SO_RCVBUF, (const char *)&nSendBuf, sizeof(int32_t));
        if (ret < 0) {
            ADIAG_ERR("set socket option failed, strerr=%s.", strerror(AdiagGetErrorCode()));
            break;
        }

        // bind socket with a certain address.
        ret = TraceBind(sockFd, (TraceSockAddr *)&addr, sizeof(addr));
        if (ret != TRACE_SUCCESS) {
            ADIAG_ERR("bind socket failed, bind path is: %s, strerr=%s.", addr.sun_path, strerror(AdiagGetErrorCode()));
            break;
        }

        // Get the GID by using group name string
        struct group *grpInfo = getgrnam(groupName);
        if (grpInfo == NULL) {
            ADIAG_ERR("%s does not exist", groupName);
            break;
        }

        // Change the socket files owner and group.
        ret = lchown(addr.sun_path, getuid(), grpInfo->gr_gid);
        if (ret != TRACE_SUCCESS) {
            ADIAG_ERR("change the socket file: %s group failed, strerr=%s.",
                addr.sun_path, strerror(AdiagGetErrorCode()));
            break;
        }

        // Set the socket files permission.
        ret = TraceChmod(addr.sun_path, permission);
        if (ret != TRACE_SUCCESS) {
            ADIAG_ERR("chmod %s failed , strerr=%s.", addr.sun_path, strerror(AdiagGetErrorCode()));
            break;
        }

        ADIAG_INF("create socket succeed, socket path: %s, fd %d.", addr.sun_path, sockFd);
        return sockFd;
    } while (true);

    TraceCloseSocket(sockFd);
    return -1;
}

STATIC TraStatus TraceServerMsgParse(UtraceMsg *traceMsg, TraceEventMsg *eventMsg)
{
    eventMsg->msgType = TRACE_EVENT_MSG;
    eventMsg->devId = traceMsg->deviceId;
    eventMsg->pid = (int32_t)traceMsg->hostPid;
    eventMsg->seqFlag = TRACE_MSG_SEQFLAG_SINGLE;
    eventMsg->bufLen = traceMsg->dataLength;
    eventMsg->saveType = traceMsg->saveType;
    errno_t err = memcpy_s(eventMsg->buf, traceMsg->dataLength, traceMsg + 1U, traceMsg->dataLength);
    if (err != EOK) {
        ADIAG_ERR("memcpy failed, length = %u bytes, err = %d, strerr = %s.",
            traceMsg->dataLength, (int32_t)err, strerror(AdiagGetErrorCode()));
        return TRACE_FAILURE;
    }
    err = strcpy_s(eventMsg->eventName, EVENT_NAME_MAX_LENGTH, traceMsg->objName);
    if (err != EOK) {
        ADIAG_ERR("strcpy_s failed, err = %d, strerr = %s.", (int32_t)err, strerror(AdiagGetErrorCode()));
        return TRACE_FAILURE;
    }
    err = strcpy_s(eventMsg->eventTime, TIMESTAMP_MAX_LENGTH, traceMsg->eventTime);
    if (err != EOK) {
        ADIAG_ERR("strcpy_s failed, err = %d, strerr = %s.", (int32_t)err, strerror(AdiagGetErrorCode()));
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

STATIC void TraceServerDataProcess(char *recvBuf, uint32_t len)
{
    if (len < sizeof(UtraceMsg)) {
        ADIAG_ERR("parse data received from utrace failed, data length(%u bytes) less then min length(%zu bytes).",
            len, sizeof(UtraceMsg));
        return;
    }
    UtraceMsg *traceMsg = (UtraceMsg *)recvBuf;
    ADIAG_CHK_EXPR_ACTION(traceMsg->magic != UTRACE_HEAD_MAGIC, return,
        "check magic of data from utrace failed, expect magic = %hu, current magic = %hu.",
        UTRACE_HEAD_MAGIC, traceMsg->magic);
    ADIAG_CHK_EXPR_ACTION(traceMsg->version < UTRACE_HEAD_VERSION, return,
        "check version of data from utrace failed, expect version = %hu, current version = %hu.",
        UTRACE_HEAD_VERSION, traceMsg->version);
    ADIAG_CHK_EXPR_ACTION((traceMsg->dataLength == 0) || (traceMsg->dataLength > len), return,
        "data length[%u] is out of range[0-%u].", traceMsg->dataLength, len);

    TraceEventMsg *eventMsg = (TraceEventMsg *)AdiagMalloc(sizeof(TraceEventMsg) + traceMsg->dataLength);
    if (eventMsg == NULL) {
        ADIAG_ERR("malloc for event msg failed, strerr = %s.", strerror(AdiagGetErrorCode()));
        return;
    }
    if (TraceServerMsgParse(traceMsg, eventMsg) != TRACE_SUCCESS) {
        ADIAG_ERR("parse msg from socket failed, pid = %u.", traceMsg->hostPid);
        ADIAG_SAFE_FREE(eventMsg);
        return;
    }
    TraceServerSessionLock();
    SessionNode *sessionNode = TraceServerGetSessionNode((int32_t)traceMsg->hostPid, (int32_t)traceMsg->deviceId);
    if (sessionNode == NULL) {
        ADIAG_WAR("no session node is valid, pid = %u.", traceMsg->hostPid);
        TraceServerSessionUnlock();
        ADIAG_SAFE_FREE(eventMsg);
        return;
    }
    TraStatus ret = TraceTsPushNode(sessionNode, eventMsg->seqFlag,
        (void *)eventMsg, eventMsg->bufLen + sizeof(TraceEventMsg));
    TraceServerSessionUnlock();
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("push node failed, ret = %d, pid = %u.", ret, eventMsg->pid);
        ADIAG_SAFE_FREE(eventMsg);
        return;
    }
    ADIAG_DBG("log read by socket successfully, eventMsg: msgType=%u, eventType=%u, seqFlag=%u,"
        "devId=%u, pid=%d, eventName=%s, eventTime=%s, saveType=%u, bufLen=%u bytes.",
        (uint32_t)eventMsg->msgType, (uint32_t)eventMsg->eventType, (uint32_t)eventMsg->seqFlag, eventMsg->devId,
        eventMsg->pid, eventMsg->eventName, eventMsg->eventTime, (uint32_t)eventMsg->saveType, eventMsg->bufLen);
}

STATIC void *TraceServerSocketRecv(void *arg)
{
    (void)arg;
    ADIAG_RUN_INF("trace server socket thread start, socket path = %s.", g_socketPath);
    if (TraceSetThreadName("TraceServerSocketRecv") != TRACE_SUCCESS) {
        ADIAG_WAR("can not set thread name(TraceServerSocketRecv) but continue.");
    }

    size_t recvBufLen = SOCKET_MAX_DATA_SIZE; // max receive size
    char *recvBuf = (char *)AdiagMalloc(recvBufLen);
    if (recvBuf == NULL) {
        ADIAG_ERR("create receive buffer failed.");
        return NULL;
    }
    while (g_traceSocketThreadState) {
        (void)memset_s(recvBuf, recvBufLen, 0, recvBufLen);
        ssize_t len = read(g_sockFd, recvBuf, recvBufLen);
        if (len <= 0) {
            usleep(SOCKET_TIME_INTERVAL);
            continue;
        }
        TraceServerDataProcess(recvBuf, (uint32_t)len);
    }
    ADIAG_SAFE_FREE(recvBuf);
    TraceCloseSocket(g_sockFd);
    g_sockFd = -1;
    (void)unlink(g_socketPath);
    ADIAG_RUN_INF("thread TraceServerSocketRecv exit.");
    return NULL;
}

STATIC TraStatus TraceServerCreateSocketRecvThread(void)
{
    TraceUserBlock thread;
    thread.procFunc = TraceServerSocketRecv;
    thread.pulArg = NULL;
    TraceThreadAttr attr = { 1, 0, 0, 0, 0, 0, TRACE_THREAD_STACK_SIZE };
    TraceThread tid = 0;
    g_traceSocketThreadState = true;
    if (TraceCreateTaskWithThreadAttr(&tid, &thread, &attr) != TRACE_SUCCESS) {
        ADIAG_ERR("create trace server socket receive thread failed, strerr=%s.", strerror(AdiagGetErrorCode()));
        return TRACE_FAILURE;
    }
    g_traceSocketThread = tid;
    ADIAG_RUN_INF("create trace server socket receive thread successfully, tid = %d.", (int32_t)g_traceSocketThread);
    return TRACE_SUCCESS;
}

TraStatus TraceServerCreateSocketRecv(int32_t devId)
{
    TraStatus ret = TraceGetSocketPath(devId, g_socketPath, SOCKET_PATH_MAX_LENGTH);
    ADIAG_CHK_EXPR_ACTION(ret != TRACE_SUCCESS, return TRACE_FAILURE, "get trace socket path failed, result=%d.", ret);

    ADIAG_INF("socket path is: %s.", g_socketPath);
    g_sockFd = TraceCreateSocketByFile(g_socketPath, TRACE_SERVER_USER_NAME, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP);
    ADIAG_CHK_EXPR_ACTION(g_sockFd == TRACE_FAILURE, return TRACE_FAILURE,
        "create socket failed, strerr=%s.", strerror(AdiagGetErrorCode()));
    // start thread
    ret = TraceServerCreateSocketRecvThread();
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("create socket receive thread failed.");
        TraceCloseSocket(g_sockFd);
        g_sockFd = -1;
        (void)unlink(g_socketPath);
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

void TraceServerDestroySocketRecv(void)
{
    g_traceSocketThreadState = false;
}