/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TDT_DEVICE_INNER_INC_DOMAIN_SOCKET_COMMON_H
#define TDT_DEVICE_INNER_INC_DOMAIN_SOCKET_COMMON_H

#include <mutex>
#include <future>
#include "proto/tsd_message.pb.h"
#include "tsd/status.h"
#include "inc/log.h"

namespace tsd {
    class DomainSocketCommon {
    public:
        TSD_StatusT SendMsg(const uint32_t sessionId, const HDCMessage& msg);

        TSD_StatusT RecvMsg(const uint32_t sessionId, HDCMessage& msg);

        void GetDomainSocketFilePath(std::string &socketPath) const;

        virtual TSD_StatusT GetDomainSocketSession(const uint32_t sessionId, int32_t& socketFd) = 0;

        virtual ~DomainSocketCommon() = default;

    protected:
        DomainSocketCommon();
        DomainSocketCommon(const DomainSocketCommon&) = delete;
        DomainSocketCommon(DomainSocketCommon&&) = delete;
        DomainSocketCommon& operator=(const DomainSocketCommon&) = delete;
        DomainSocketCommon& operator=(DomainSocketCommon&&) = delete;
    };
}
#endif  // COMMON_COMMON_INC_DOMAIN_SOCKET_H
