/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef COMMON_COMMON_INC_VERSION_VERIFY_H
#define COMMON_COMMON_INC_VERSION_VERIFY_H

#include <set>
#include <atomic>
#include "proto/tsd_message.pb.h"
namespace tsd {
class VersionVerify {
public:

    VersionVerify() : peerVersion_(0U) {};

    ~VersionVerify() = default;

    /**
    * @ingroup VersionVerify
    * @param [in] peerVersionInfo : client version info
    * @brief check whether client and server can establish communication
    */
    bool PeerVersionCheck(const HDCMessage::VersionInfo& peerVersionInfo);

    /**
    * @ingroup VersionVerify
    * @param [in] msgType : communication type
    * @brief check whether this type of communication can be understood by server
    */
    bool SpecialFeatureCheck(const HDCMessage::MsgType& msgType);

    /**
    * @ingroup VersionVerify
    * @param [in] peerVersionInfo : client version info
    * @brief parse and save version info send from client
    */
    void ParseVersionInfo(const HDCMessage::VersionInfo& peerVersionInfo);

    /**
    * @ingroup VersionVerify
    * @param [in] msg : message send by client
    * @brief add version info to message which client will send to server
    */
    void SetVersionInfo(HDCMessage& msg) const;

private:
    uint32_t peerVersion_;  // used for hdc communication;
    std::map<HDCMessage::MsgType, std::set<std::string>> peerFeatureList_;
    std::map<HDCMessage::MsgType, bool> alreadyCheckedList_;
};
} // namespace tsd
#endif // COMMON_COMMON_INC_VERSION_VERIFY_H
