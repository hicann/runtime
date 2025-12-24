/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef COLLECTOR_DVVP_COMMON_SOCKET_LOCAL_SOCKET_H
#define COLLECTOR_DVVP_COMMON_SOCKET_LOCAL_SOCKET_H

#include <cerrno>
#include <string>
#include <sys/un.h>

namespace analysis {
namespace dvvp {
namespace common {
namespace socket {
constexpr int32_t SOCKET_ERR_EAGAIN = -EAGAIN;
constexpr int32_t SOCKET_ERR_EADDRINUSE = -EADDRINUSE;
constexpr int32_t MAX_CONN_BACKLOG = 100;

class LocalSocket {
public:
    /**
     * @brief create sock server, socket + bind + listen
     * @param [in] key: server key
     * @param [in] backlog: max backlog
     *
     * @return
     *      sock fd
     *      SOCKET_ERR_EADDRINUSE: addr already in use
     *      -1: failed
     */
    static int32_t Create(const std::string &key, int32_t backlog = MAX_CONN_BACKLOG);

    /**
     * @brief open socket
     *
     * @return
     *      sock fd
     *      -1: failed
     */
    static int32_t Open();

    /**
     * @brief call sock accept
     * @param [in] fd: sock Fd
     *
     * @return
     *      client fd
     *      -1: failed
     */
    static int32_t Accept(int32_t fd);

    /**
     * @brief sock connect
     * @param [in] fd: client sock Fd
     * @param [in] key: server key
     *
     * @return
     *      0: success
     *      SOCKET_ERR_EAGAIN: time out
     *      -1: failed
     */
    static int32_t Connect(int32_t fd, const std::string &key);

    /**
     * @brief set sock recv/send timeout
     * @param [in] fd: client sock Fd
     * @param [in] sec: timeout sec
     * @param [in] usec: timeout usec
     *
     * @return
     *      0: success
     *      -1: failed
     */
    static int32_t SetRecvTimeOut(int32_t fd, long sec, long usec);

    /**
     * @brief set sock recv/send timeout
     * @param [in] fd: client sock Fd
     * @param [in] sec: timeout sec
     * @param [in] usec: timeout usec
     *
     * @return
     *      0: success
     *      -1: failed
     */
    static int32_t SetSendTimeOut(int32_t fd, long sec, long usec);

    /**
     * @brief sock recv
     * @param [in] fd: file descriptor
     * @param [out] buff: read buffer
     * @param [in] len: receive length
     * @param [in] flag: read flag
     *
     * @return
     *      total receive length
     *      SOCKET_ERR_EAGAIN: time out
     *      -1: failed
     */
    static int32_t Recv(int32_t fd, void *buff, int32_t len, int32_t flag);

    /**
     * @brief sock send
     * @param [in] fd: file descriptor
     * @param [in] buff: write buffer
     * @param [in] len: buffer length
     * @param [in] flag: write flag
     *
     * @return
     *      0: success
     *      SOCKET_ERR_EAGAIN: time out
     *      -1: failed
     */
    static int32_t Send(int32_t fd, const void *buff, int32_t len, int32_t flag);

    /**
     * @brief sock close
     * @param [in] fd: sock file descriptor
     */
    static void Close(int32_t &fd);

private:
    static sockaddr_un GetUnixSockAddr(const std::string &key);
};
} // namespace socket
} // namespace common
} // namespace dvvp
} // namespace analysis

#endif