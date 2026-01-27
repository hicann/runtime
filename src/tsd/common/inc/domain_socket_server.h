/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TDT_DEVICE_INNER_INC_DOMAIN_SOCKET_SERVER_H
#define TDT_DEVICE_INNER_INC_DOMAIN_SOCKET_SERVER_H

#include <iostream>
#include <thread>
#include <memory>
#include "proto/tsd_message.pb.h"
#include "mmpa/mmpa_api.h"
#include "inc/domain_socket_common.h"

namespace tsd {
    class DomainSocketServer : public DomainSocketCommon {
    public:
        static std::shared_ptr<DomainSocketServer> GetInstance(const uint32_t devId);

        TSD_StatusT Init();

        TSD_StatusT Destroy();

        void ClearSingleSession(const uint32_t sessionId);

        ~DomainSocketServer() override;

    private:
        DomainSocketServer(const uint32_t devId);

        TSD_StatusT AcceptDomainSocketSession(uint32_t& sessionId);

        TSD_StatusT Accept();

        void SetAcceptSwitch(const bool acceptMode);

        void SetRunSwitch(const bool runStatus);

        TSD_StatusT GetDomainSocketSession(const uint32_t sessionId, int32_t& socketFd) override;

        void RecvData(const uint32_t sessionId);

        void JoinAcceptThread();

        void ClearPidBySessionId(const uint32_t sessionId);

        void ClearServerPtr();

        void ClearAllSession();

        void DestroyServer();

        void ExitRecvThread(const uint32_t sessionId);

        DomainSocketServer(const DomainSocketServer&) = delete;

        DomainSocketServer(DomainSocketServer&&) = delete;

        DomainSocketServer& operator=(const DomainSocketServer&) = delete;

        DomainSocketServer& operator=(DomainSocketServer&&) = delete;

        TSD_StatusT SocketBindToAddress(int32_t serverSocket) const;

        void SetHdcMsgBasicInfo(HDCMessage &msg, const TSD_StatusT recvRt, const uint32_t sessionId);

        bool IsEndRecvDataThread(const HDCMessage &msg, const uint32_t sessionId);
        // HDC 父连接
        int32_t  domainScoketServer_;
        // sessionId和socket的Map
        std::map<uint32_t, int32_t> domainSocketServerSessionMap_;
        // sessionId和hdcSession的Map的锁
        std::mutex mutextForDomainSocketServerSessionMap_;
        // 维护可用sessionId number
        std::vector<uint32_t> sessionIdNumVec_;
        // 可用sessionId number的锁
        std::mutex mutextForsessionIdNumVec_;
        // deviceTd、type和Server指针对象的Map
        static std::map<uint32_t, std::shared_ptr<DomainSocketServer>> domainSocketServerMap_;
        // deviceTd、type和Server指针对象的Map的锁
        static std::mutex mutextForDomainSocketServerMap_;
        // 设备 ID
        uint32_t deviceId_;
        // 接收线程开关
        volatile bool recvRunSwitch_;
        // accept 线程开关
        volatile bool acceptSwitch_;
        // 存储接收线程
        std::thread acceptThread_;
        // sessionID 和 recvThread map的锁
        std::mutex mutextForThreadSessionIDmap_;
        // Server连接状态
        bool isServerClose_;
    };
}
#endif  // TDT_DEVICE_INNER_INC_HDC_SERVER_H
