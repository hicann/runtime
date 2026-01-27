/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "inc/domain_socket_common.h"
#include <string>
#include <securec.h>
#include <sys/socket.h>
#include "inc/internal_api.h"
namespace tsd {
    namespace {
        // msg大小与hdc msg的默认大小保持一致
        constexpr uint32_t DEFAULT_HDC_MSG_LEN = (20U * 1024U);
        // domain socket 文件默认存储位置，如果获取不到home路径就放到这里
        const std::string DOMAIN_SOCKET_PATH_DEFAULT = "/home/HwHiAiUser/tsd_socket_server";
        const std::string DOMAIN_SOCKET_PATH = "tsd_socket_server";
    }

    DomainSocketCommon::DomainSocketCommon() = default;

    TSD_StatusT DomainSocketCommon::SendMsg(const uint32_t sessionId, const HDCMessage& msg)
    {
        int32_t curSocketFd = -1;
        const TSD_StatusT result = GetDomainSocketSession(sessionId, curSocketFd);
        if (result != TSD_OK) {
            TSD_RUN_WARN("GetDomainSocketSession fail.");
            return TSD_HDC_SEND_MSG_ERROR;
        }
        const uint32_t msgSize = static_cast<uint32_t>(msg.ByteSizeLong());
        const std::unique_ptr<uint8_t []> msgBufPtr(new (std::nothrow) uint8_t[msgSize]);
        if (msgBufPtr == nullptr) {
            TSD_ERROR("[DomainSocketCommon] Malloc msg buf ptr failed.");
            return TSD_INTERNAL_ERROR;
        }
        uint8_t *msgBuf = msgBufPtr.get();
        (void)msg.SerializePartialToArray(msgBuf, static_cast<int32_t>(msgSize));
        if (send(curSocketFd, msgBuf, msgSize, 0) < 0) {
            TSD_ERROR("host socket client send msg error[%s],errorno[%d].", SafeStrerror().c_str(), errno);
            return TSD_CLT_OPEN_FAILED;
        }
        return TSD_OK;
    }

    TSD_StatusT DomainSocketCommon::RecvMsg(const uint32_t sessionId, HDCMessage& msg)
    {
        int32_t curSocketFd = -1;
        const TSD_StatusT result = GetDomainSocketSession(sessionId, curSocketFd);
        if (result != TSD_OK) {
            TSD_RUN_WARN("GetDomainSocketSession fail.");
            return TSD_HDC_RECV_MSG_ERROR;
        }

        const std::unique_ptr<uint8_t []> msgBufPtr(new (std::nothrow) uint8_t[DEFAULT_HDC_MSG_LEN]);
        if (msgBufPtr == nullptr) {
            TSD_ERROR("[DomainSocketCommon] Malloc msg buf ptr failed.");
            return TSD_INTERNAL_ERROR;
        }
        uint8_t *buffer = msgBufPtr.get();
        const int32_t numberOfReaded = recv(curSocketFd, buffer, DEFAULT_HDC_MSG_LEN, 0);
        if (numberOfReaded < 0) {
            TSD_RUN_WARN("socket receive error sessionid[%u],socketHandle[%d],error[%s],errorno[%d].",
                         sessionId, curSocketFd, SafeStrerror().c_str(), errno);
            return TSD_HDC_RECV_MSG_ERROR;
        } else if (numberOfReaded == 0) {
            TSD_RUN_WARN("peer socket closed sessionId[%u],socketHandle[%d],error[%s],errorno[%d].",
                         sessionId, curSocketFd, SafeStrerror().c_str(), errno);
            return TSD_HDC_SERVER_CLIENT_SOCKET_CLOSED;
        } else {
            (void)msg.ParseFromArray(buffer, numberOfReaded);
            return TSD_OK;
        }
    }

    void DomainSocketCommon::GetDomainSocketFilePath(std::string &socketPath) const
    {
        std::string pathEnv;
        GetScheduleEnv("HOME", pathEnv);
        if (pathEnv.empty()) {
            socketPath = DOMAIN_SOCKET_PATH_DEFAULT;
            TSD_ERROR("Env HOME is invalid");
            return;
        }
        if (!CheckValidatePath(pathEnv)) {
            socketPath = DOMAIN_SOCKET_PATH_DEFAULT;
            TSD_ERROR("Env HOME[%s] is not correct", pathEnv.c_str());
            return;
        }
        if (!CheckRealPath(pathEnv)) {
            socketPath = DOMAIN_SOCKET_PATH_DEFAULT;
            TSD_ERROR("Env HOME[%s] is not realpath", pathEnv.c_str());
            return;
        }

        socketPath = pathEnv + DOMAIN_SOCKET_PATH;
        TSD_INFO("socketPath:[%s].", socketPath.c_str());
    }
}  // namespace tsd
