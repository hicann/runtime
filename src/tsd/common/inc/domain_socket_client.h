/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TDT_HOST_INNER_INC_DOMAIN_SOCKET_CLIENT_H
#define TDT_HOST_INNER_INC_DOMAIN_SOCKET_CLIENT_H

#include <map>
#include <string>
#include <memory>

#include "proto/tsd_message.pb.h"
#include "inc/domain_socket_common.h"
#include "inc/message_parse_client.h"

namespace tsd {
    class DomainSocketClient : public DomainSocketCommon {
    public:
        static std::shared_ptr<DomainSocketClient> GetInstance(const uint32_t devId);

        TSD_StatusT Init(const uint32_t clientPid);

        void Destroy();

        ~DomainSocketClient() override;

        TSD_StatusT TsdRecvData(const uint32_t sessionId);

        void ClearClientPtr();

    private:
        explicit DomainSocketClient(const uint32_t devId);

        TSD_StatusT GetDomainSocketSession(const uint32_t sessionId,  int32_t& socketFd) override;

        DomainSocketClient(const DomainSocketClient&) = delete;

        DomainSocketClient(DomainSocketClient&&) = delete;

        DomainSocketClient& operator=(const DomainSocketClient&) = delete;

        DomainSocketClient& operator=(DomainSocketClient&&) = delete;

        // socket句柄
        int32_t clientSocket_;
        // 设备 ID
        uint32_t deviceId_;
        // Client连接状态
        bool isClientClose_;
        // 记录hostpid用于做匹配
        uint32_t hostPid_;
        // static map表用于存储全局deviceid 与 socketFd之间的关系
        static std::map<uint32_t, std::shared_ptr<DomainSocketClient>> domainSocketClientMap_;
        // DomainSocketClientMap_ 对应的锁
        static std::mutex mutexForDomainSocketClientMap_;
    };
}
#endif  // TDT_HOST_INNER_INC_DOMAIN_SOCKET_CLIENT_H
