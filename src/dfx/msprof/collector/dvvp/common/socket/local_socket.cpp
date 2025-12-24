/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "local_socket.h"
#include "errno/error_code.h"
#include "msprof_dlog.h"
#include "utils/utils.h"

namespace analysis {
namespace dvvp {
namespace common {
namespace socket {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;

sockaddr_un LocalSocket::GetUnixSockAddr(const std::string &key)
{
    sockaddr_un sockAddr;
    (void)memset_s(&sockAddr, sizeof(sockAddr), 0, sizeof(sockAddr));
    auto ret = strcpy_s(sockAddr.sun_path + 1, sizeof(sockAddr.sun_path) - 1, key.c_str());
    if (ret != EOK) {
        MSPROF_LOGE("local socket path copy failed");
    }
    sockAddr.sun_family = PF_LOCAL;
    return sockAddr;
}

int32_t LocalSocket::Create(const std::string &key, int32_t backlog)
{
    if (key.empty()) {
        MSPROF_LOGE("key is empty");
        return PROFILING_FAILED;
    }
    auto fd = OsalSocket(PF_LOCAL, SOCK_STREAM, 0);
    if (fd == OSAL_EN_ERROR) {
        MSPROF_LOGE("create socket failed: %s", Utils::GetErrno());
        return PROFILING_FAILED;
    }

    auto sockAddr = GetUnixSockAddr(key);
    auto ret = OsalBind(fd, reinterpret_cast<OsalSockAddr *>(&sockAddr),
        offsetof(sockaddr_un, sun_path) + 1 + key.size());
    if (ret != OSAL_EN_OK) {
        if (OsalGetErrorCode() == EADDRINUSE) { // Address already in use
            Close(fd);
            return SOCKET_ERR_EADDRINUSE;
        }
        MSPROF_LOGE("bind exception info: %s", Utils::GetErrno());
        Close(fd);
        return PROFILING_FAILED;
    }

    ret = OsalListen(fd, backlog);
    if (ret != OSAL_EN_OK) {
        MSPROF_LOGE("listen exception info: %s", Utils::GetErrno());
        Close(fd);
        return PROFILING_FAILED;
    }

    MSPROF_LOGI("local server init: %d", fd);
    return fd;
}

int32_t LocalSocket::Open()
{
    auto fd = OsalSocket(PF_LOCAL, SOCK_STREAM, 0);
    if (fd == OSAL_EN_ERROR) {
        MSPROF_LOGE("open socket failed: %s", Utils::GetErrno());
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("open sock fd: %d", fd);
    return fd;
}

int32_t LocalSocket::Accept(int32_t fd)
{
    if (fd < 0) {
        MSPROF_LOGE("invalid socket: %d", fd);
        return PROFILING_FAILED;
    }

    auto clientFd = OsalAccept(fd, nullptr, nullptr);
    if (clientFd < 0) {
        if (OsalGetErrorCode() == EAGAIN) { // timeout
            return SOCKET_ERR_EAGAIN;
        }
        MSPROF_LOGE("accept exception info: %s", Utils::GetErrno());
        return PROFILING_FAILED;
    }
    return clientFd;
}

int32_t LocalSocket::Connect(int32_t fd, const std::string &key)
{
    if (fd < 0 || key.empty()) {
        MSPROF_LOGE("fd:%d or key:%s invalid", fd, key.c_str());
        return PROFILING_FAILED;
    }
    auto sockAddr = GetUnixSockAddr(key);
    if (OsalConnect(fd, reinterpret_cast<OsalSockAddr *>(&sockAddr),
        offsetof(sockaddr_un, sun_path) + 1 + key.size()) != OSAL_EN_OK) {
        MSPROF_LOGW("Unable to connect local socket %d to %s with return code %s", fd, key.c_str(), Utils::GetErrno());
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t LocalSocket::SetRecvTimeOut(int32_t fd, long sec, long usec)
{
    OsalTimeval timeout = { sec, usec };
    if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeout, sizeof(timeout)) == -1) {
        MSPROF_LOGE("set %d recv timeout failed: %s", fd, Utils::GetErrno());
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t LocalSocket::SetSendTimeOut(int32_t fd, long sec, long usec)
{
    OsalTimeval timeout = { sec, usec };
    if (setsockopt(fd, SOL_SOCKET, SO_SNDTIMEO, &timeout, sizeof(timeout)) == -1) {
        MSPROF_LOGE("set %d send timeout failed: %s", fd, Utils::GetErrno());
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t LocalSocket::Recv(int32_t fd, void *buff, int32_t len, int32_t flag)
{
    if (fd < 0 || buff == nullptr || len <= 0) {
        return PROFILING_FAILED;
    }

    const int32_t receivedlen = OsalSocketRecv(fd, buff, len, flag);
    if (receivedlen < 0) {
        if (OsalGetErrorCode() == EAGAIN) {
            return SOCKET_ERR_EAGAIN;
        }
        MSPROF_LOGE("sock recv error: %s", Utils::GetErrno());
        return PROFILING_FAILED;
    }

    return receivedlen;
}

int32_t LocalSocket::Send(int32_t fd, const void *buff, int32_t len, int32_t flag)
{
    if (fd < 0 || buff == nullptr || len <= 0) {
        return PROFILING_FAILED;
    }
    const int ret = OsalSocketSend(fd, const_cast<void *>(buff), len, flag);
    if (ret < 0) {
        if (OsalGetErrorCode() == EAGAIN) {
            return SOCKET_ERR_EAGAIN;
        }
        MSPROF_LOGE("sock send error: %s", Utils::GetErrno());
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}

void LocalSocket::Close(int32_t &fd)
{
    if (fd >= 0) {
        (void)OsalClose(fd);
        fd = -1;
    }
}
} // namespace socket
} // namespace common
} // namespace dvvp
} // namespace analysis
