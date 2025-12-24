/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "utrace_socket.h"
#include "adiag_utils.h"
#include "adiag_print.h"
#include "trace_system_api.h"

STATIC int32_t g_clientSockFd = -1;

void UtraceSetSocketFd(int32_t fd)
{
    g_clientSockFd = fd;
}

int32_t UtraceGetSocketFd(void)
{
    return g_clientSockFd;
}

bool UtraceIsSocketFdValid(void)
{
    if (g_clientSockFd < 0) {
        return false;
    } else {
        return true;
    }
}

STATIC TraStatus TraceGetSocketPathByVfid(uint32_t vfid, char *socketPath, uint32_t pathLen)
{
    int32_t ret = snprintf_s(socketPath, pathLen, pathLen - 1, "%s%s_%u", SOCKET_FILE_DIR, SOCKET_FILE, vfid);
    if (ret == -1) {
        ADIAG_ERR("snprintf_s failed, strerr=%s, pid=%d, vfid=%u.", strerror(AdiagGetErrorCode()), getpid(), vfid);
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

STATIC TraStatus TraceGetSocketPathByPfid(char *socketPath, uint32_t pathLen)
{
    int32_t ret = snprintf_s(socketPath, pathLen, pathLen - 1, "%s%s", SOCKET_FILE_DIR, SOCKET_FILE);
    if (ret == -1) {
        ADIAG_ERR("snprintf_s failed, strerr=%s, pid=%d.", strerror(AdiagGetErrorCode()), getpid());
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

/**
 * @brief           : get socket path when trace server create socket
 * @param [in]      : devId             device id
 * @param [out]     : socketPath        socket path
 * @param [in]      : pathLen           path length
 * @return          : !=0 failure; ==0 success
 */
STATIC TraStatus UtraceGetTraceSocketPath(uint32_t devId, char *socketPath, uint32_t pathLen)
{
    if ((devId >= MIN_VFID_NUM) && (devId <= MAX_VFID_NUM)) {
        // devId(32~63) is vfid, strcat socket path with "socket_trace_vfid"
        return TraceGetSocketPathByVfid(devId, socketPath, pathLen);
    } else if (devId < MIN_VFID_NUM) {
        // devId(0~31) is pfid, strcat socket path with "socket_trace"
        return TraceGetSocketPathByPfid(socketPath, pathLen);
    } else {
        return TRACE_FAILURE;
    }
}

int32_t UtraceCreateSocket(uint32_t devId)
{
    struct sockaddr_un addr;
    int32_t pid = (int32_t)getpid();
    int32_t sockFd = TraceSocket(AF_UNIX, (uint32_t)SOCK_DGRAM | (uint32_t)SOCK_NONBLOCK, 0);
    ADIAG_CHK_EXPR_ACTION(sockFd == TRACE_FAILURE, return TRACE_FAILURE, "create socket failed, strerr=%s, pid=%d",
        strerror(AdiagGetErrorCode()), pid);

    const int32_t nSendBuf = 2097152; // 2MB
    int32_t ret;
    do {
        ret = setsockopt(sockFd, SOL_SOCKET, SO_SNDBUF, (const char *)&nSendBuf, sizeof(int));
        if (ret < 0) {
            ADIAG_ERR("set socket option failed, strerr=%s, pid=%d.", strerror(AdiagGetErrorCode()), pid);
            break;
        }

        (void)memset_s(&addr, sizeof(addr), 0, sizeof(addr));

        addr.sun_family = AF_UNIX;
        char socketPath[SOCKET_PATH_MAX_LENGTH + 1U] = { 0 };
        ret = UtraceGetTraceSocketPath(devId, socketPath, SOCKET_PATH_MAX_LENGTH);
        if (ret != TRACE_SUCCESS) {
            ADIAG_ERR("get socket path failed, ret=%d, pid=%d, devId=%u.", ret, pid, devId);
            break;
        }

        ret = strcpy_s(addr.sun_path, sizeof(addr.sun_path), socketPath);
        if (ret != EOK) {
            ADIAG_ERR("strcpy failed, ret=%d, pid=%d, devId=%u.", ret, pid, devId);
            break;
        }

        ret = TraceConnect(sockFd, (struct sockaddr *)&addr, sizeof(addr));
        if (ret != TRACE_SUCCESS) {
            ADIAG_ERR("connect to trace server failed, path %s, ret=%d, pid=%d.", addr.sun_path, ret, pid);
            break;
        }
        ADIAG_INF("create socket succeed, socket path: %s, fd %d.", addr.sun_path, sockFd);
        return sockFd;
    } while (0);

    ret = TraceCloseSocket(sockFd);
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("close socket failed, strerr=%s, pid=%d.", strerror(AdiagGetErrorCode()), pid);
    }
    return TRACE_FAILURE;
}

void UtraceCloseSocket(void)
{
    if (UtraceIsSocketFdValid()) {
        TraceCloseSocket(g_clientSockFd);
        UtraceSetSocketFd(-1);
    }
}