/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_recv_interface.h"
#include "log_common.h"
#include "log_recv.h"
#include "log_print.h"
#include "ascend_hal.h"

#define LOG_RECV_TIMEOUT 1000
#ifndef FIRMWARE_LOG_PATH
#define FIRMWARE_LOG_PATH                 "/proc/slog/debug"
#endif

#ifdef OS_SLOG
#include <poll.h>
STATIC struct pollfd g_recvPollFd = {0};

LogRt LogRecvSafeRead(int32_t deviceId, LogMsgHead **recvBuf, uint32_t maxLen)
{
    (void)deviceId;
    uint32_t bufLen = maxLen;
    int32_t ret = -1;

    if (g_recvPollFd.fd <= 0) {
        g_recvPollFd.fd = open(FIRMWARE_LOG_PATH, O_RDONLY | O_NONBLOCK, 0);
        TWO_ACT_ERR_LOG(g_recvPollFd.fd == INVALID, (void)ToolSleep(LOG_RECV_TIMEOUT), return LOG_RECV_NULL,
        "open file failed, file=%s, strerr=%s.", FIRMWARE_LOG_PATH, strerror(ToolGetErrorCode()))
        g_recvPollFd.events = POLLIN;
    } else {
        ret = poll(&g_recvPollFd, 1, LOG_RECV_TIMEOUT);
        if (ret < 0) {
            ONE_ACT_NO_LOG(ToolGetErrorCode() == EINTR, return LOG_RECV_NULL);
            SELF_LOG_ERROR("poll failed, result=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
            (void)ToolSleep(LOG_RECV_TIMEOUT);
            return LOG_RECV_NULL;
        }
        if (ret == 0) {
            return LOG_RECV_NULL; // poll timeout
        }
        if (((uint32_t)g_recvPollFd.revents & (uint32_t)POLLIN) == 0) {
            return LOG_RECV_NULL; // no data to read
        }
    }

    LogMsgHead *tmpNode = (LogMsgHead *)LogMalloc(bufLen);
    if (tmpNode == NULL) {
        SELF_LOG_ERROR("malloc failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return MALLOC_FAILED;
    }

    ret = (int32_t)read(g_recvPollFd.fd, tmpNode->data, bufLen - sizeof(LogMsgHead));
    if ((ret == -1) && (ToolGetErrorCode() != EAGAIN)) {
        SELF_LOG_ERROR("read file(%s) failed, result=%d, strerr=%s.", FIRMWARE_LOG_PATH, ret, strerror(ToolGetErrorCode()));
        XFREE(tmpNode);
        return LOG_RECV_FAILED;
    }
    if (ret <= 0) {
        XFREE(tmpNode);
        return LOG_RECV_NULL; // no data to read
    }
    tmpNode->data[ret] = '\0';
    tmpNode->dataLen = (uint32_t)ret;
    *recvBuf = tmpNode;
    return SUCCESS;
}

#else

LogRt LogRecvSafeRead(int32_t deviceId, LogMsgHead **recvBuf, uint32_t maxLen)
{
    ONE_ACT_WARN_LOG(recvBuf == NULL, return ARGV_NULL, "[input] input recvBuf is null.");

    uint32_t bufLen = maxLen;
    LogMsgHead *tmpNode = (LogMsgHead *)LogMalloc(bufLen);
    if (tmpNode == NULL) {
        SELF_LOG_ERROR("malloc failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return MALLOC_FAILED;
    }

    int32_t ret = log_read(deviceId, (char *)tmpNode, &bufLen, LOG_RECV_TIMEOUT);
    TWO_ACT_NO_LOG(ret == (int32_t)LOG_NOT_READY, XFREE(tmpNode), return LOG_RECV_NULL);
    if (ret != SYS_OK) {
        SELF_LOG_ERROR("receive log failed, device_id=%d, result=%d, strerr=%s.",
                       deviceId, ret, strerror(ToolGetErrorCode()));
        XFREE(tmpNode);
        return LOG_RECV_FAILED;
    }

    *recvBuf = tmpNode;
    return SUCCESS;
}

#endif