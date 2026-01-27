/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "inc/domain_socket_client.h"
#include <thread>
#include "mmpa/mmpa_api.h"
#include "inc/internal_api.h"
#include "inc/message_parse_client.h"
#include "inc/log.h"

namespace {
    constexpr uint32_t HOST_DOMAIN_SOCKET_CLIENT_WAIT_TIMEOUT_S = 30U; // 30s
}

namespace tsd {
    std::map<uint32_t, std::shared_ptr<DomainSocketClient>> DomainSocketClient::domainSocketClientMap_;
    // DomainSocketClientMap_ 对应的锁
    std::mutex DomainSocketClient::mutexForDomainSocketClientMap_;
    DomainSocketClient::DomainSocketClient(const uint32_t devId)
        :DomainSocketCommon(),
         clientSocket_(-1),
         deviceId_(devId),
         isClientClose_(true),
         hostPid_(0U)
    {
    }

    std::shared_ptr<DomainSocketClient> DomainSocketClient::GetInstance(const uint32_t devId)
    {
        // 校验Client端，device ID范围[0-128]
        if (devId >= MAX_DEVNUM_PER_HOST) {
            TSD_ERROR("deviceId[%u] is not supported, not in [0-128]", devId);
            return nullptr;
        }

        std::shared_ptr<DomainSocketClient> domainSocketClientPtr = nullptr;
        {
            const std::lock_guard<std::mutex> lk(mutexForDomainSocketClientMap_);
            const auto iter = domainSocketClientMap_.find(devId);
            if (iter != domainSocketClientMap_.end()) {
                domainSocketClientPtr = iter->second;
            } else {
                domainSocketClientPtr.reset(new(std::nothrow)DomainSocketClient(devId));
                TSD_CHECK((domainSocketClientPtr != nullptr), nullptr, "Fail to create domainSocketClientPtr");
                (void)domainSocketClientMap_.insert(std::make_pair(devId, domainSocketClientPtr));
            }
        }
        return domainSocketClientPtr;
    }

    DomainSocketClient::~DomainSocketClient()
    {
        try {
            if (clientSocket_ != -1) {
                TSD_INFO("close clientSocketFd[%d]", clientSocket_);
                (void)close(clientSocket_);
                clientSocket_ = -1;
            }
        } catch (std::exception &e) {
            TSD_ERROR("~DomainSocketClient failed:[%s]", e.what());
        }
    }

    TSD_StatusT DomainSocketClient::GetDomainSocketSession(const uint32_t sessionId,  int32_t& socketFd)
    {
        (void)(sessionId);
        if (clientSocket_ != -1) {
            socketFd = clientSocket_;
            return TSD_OK;
        }
        return TSD_CLT_OPEN_FAILED;
    }

    void DomainSocketClient::Destroy()
    {
        TSD_INFO("enter HdcClient::Destroy() function");
        if (!isClientClose_) {
            (void)close(clientSocket_);
            clientSocket_ = -1;
            ClearClientPtr();
            isClientClose_ = true;
            TSD_INFO("end HdcClient::Destroy() function");
        }
    }

    void DomainSocketClient::ClearClientPtr()
    {
        TSD_INFO("begin DomainSocketClient::ClearClientPtr");
        const std::lock_guard<std::mutex> lk(mutexForDomainSocketClientMap_);
        const auto iter = domainSocketClientMap_.find(deviceId_);
        if (iter == domainSocketClientMap_.end()) {
            TSD_ERROR("delete the devid[%u] DomainSocketClientPtr from DomainSocketClientMap_ failed", deviceId_);
            return;
        }
        (void)domainSocketClientMap_.erase(iter);
        TSD_INFO("end DomainSocketClient::ClearClientPtr");
    }

    TSD_StatusT DomainSocketClient::Init(const uint32_t clientPid)
    {
        if (isClientClose_) {
            const int32_t clientSocket = socket(AF_UNIX, SOCK_STREAM, 0);
            if (clientSocket < 0) {
                TSD_ERROR("host socket client create error[%s],errorno[%d]", SafeStrerror().c_str(), errno);
                return TSD_CLT_OPEN_FAILED;
            }
            sockaddr_un addr = {};
            addr.sun_family = AF_UNIX;
            std::string curSocketPath;
            GetDomainSocketFilePath(curSocketPath);
            const int32_t len = sprintf_s(addr.sun_path, sizeof(addr.sun_path), "%s_%d", curSocketPath.c_str(),
                                          deviceId_);
            if (len < 0) {
                TSD_ERROR("set socket path error[%s],errorno[%d]", strerror(errno), errno);
                return TSD_HDC_SRV_CREATE_ERROR;
            }

            if (connect(clientSocket, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
                TSD_ERROR("host socket client connect error[%s],errorno[%d]", SafeStrerror().c_str(), errno);
                return TSD_CLT_OPEN_FAILED;
            }
            timeval timeo;
            timeo.tv_sec = HOST_DOMAIN_SOCKET_CLIENT_WAIT_TIMEOUT_S;
            timeo.tv_usec = 0;
            if (setsockopt(clientSocket, SOL_SOCKET, SO_RCVTIMEO, (void *)&timeo, sizeof(timeo)) < 0) {
                TSD_ERROR("Set socket timeout error[%s],errorno[%d]", SafeStrerror().c_str(), errno);
                return DRV_ERROR_SOCKET_SET;
            }
            isClientClose_ = false;
            clientSocket_ = clientSocket;
            hostPid_ = clientPid;
            TSD_RUN_INFO("init domainclient success clientSocket_[%d]", clientSocket_);
        }
        return TSD_OK;
    }

    TSD_StatusT DomainSocketClient::TsdRecvData(const uint32_t sessionId)
    {
        HDCMessage hdcMsg;
        const TSD_StatusT recvResult = RecvMsg(sessionId, hdcMsg);
        if (recvResult != TSD_OK) {
            TSD_ERROR("recv msg failed ret[%u]", recvResult);
            return recvResult;
        }
        TSD_INFO("client recv message deviceId:[%u]", deviceId_);
        hdcMsg.set_device_id(deviceId_); // 回传时填写的DEVICEID用创建时的补充
        MessageParseClient::GetInstance()->ProcessMessage(sessionId, hdcMsg);
        return TSD_OK;
    }
} // namespace tsd
