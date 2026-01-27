/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef COMM_CHANNEL_MANAGER_H
#define COMM_CHANNEL_MANAGER_H

#include <string>
#include <unordered_map>
#include "hccl/hccl_types_in.h"
#include "queue_schedule/dgw_client.h"
#include "fsm/state_define.h"

namespace dgw {
class CommChannel {
public:
    CommChannel() = delete;
    ~CommChannel() = default;

    explicit CommChannel(const HcclComm handle = nullptr, const uint32_t localTagId = 0U,
        const uint32_t peerTagId = 0U, const uint32_t localRankId = 0U, const uint32_t peerRankId = 0U,
        const uint32_t localTagDepth = 0U, const uint32_t peerTagDepth = 0U)
        : handle_(handle), localTagId_(localTagId), peerTagId_(peerTagId), localRankId_(localRankId),
          peerRankId_(peerRankId), localTagDepth_(localTagDepth), peerTagDepth_(peerTagDepth)
    {
        (void)channelDesc_.append("handle:").append(std::to_string(PtrToValue(handle_)))
            .append(", rank:").append(std::to_string(localRankId_)).append("->").append(std::to_string(peerRankId_))
            .append(", tag:").append(std::to_string(localTagId_)).append("->").append(std::to_string(peerTagId_));
    }

    bool operator==(const CommChannel &commChannel) const
    {
        if (handle_ != commChannel.handle_) {
            return false;
        }
        if (localTagId_ != commChannel.localTagId_) {
            return false;
        }
        if (peerTagId_ != commChannel.peerTagId_) {
            return false;
        }
        if (localRankId_ != commChannel.localRankId_) {
            return false;
        }
        if (peerRankId_ != commChannel.peerRankId_) {
            return false;
        }
        return true;
    }

    inline const HcclComm GetHandle() const
    {
        return handle_;
    }
    inline uint32_t GetLocalTagId() const
    {
        return localTagId_;
    }
    inline uint32_t GetPeerTagId() const
    {
        return peerTagId_;
    }
    inline uint32_t GetLocalRankId() const
    {
        return localRankId_;
    }
    inline uint32_t GetPeerRankId() const
    {
        return peerRankId_;
    }
    inline uint32_t GetLocalTagDepth() const
    {
        return localTagDepth_;
    }
    inline uint32_t GetPeerTagDepth() const
    {
        return peerTagDepth_;
    }
    inline const std::string &ToString() const
    {
        return channelDesc_;
    }

private:
    HcclComm handle_;
    uint32_t localTagId_;
    uint32_t peerTagId_;
    uint32_t localRankId_;
    uint32_t peerRankId_;
    uint32_t localTagDepth_;
    uint32_t peerTagDepth_;
    // comm channel desc
    std::string channelDesc_;
};

class CommChannelHash {
public:
    size_t operator()(const CommChannel &channel) const
    {
        return std::hash<uint64_t>()(PtrToValue(channel.GetHandle())) ^
               std::hash<uint32_t>()(channel.GetLocalRankId()) ^ std::hash<uint32_t>()(channel.GetPeerRankId()) ^
               std::hash<uint32_t>()(channel.GetLocalTagId()) ^ std::hash<uint32_t>()(channel.GetPeerTagId());
    }
};

class CommChannelManager {
public:
    /**
     * @brief Get the Instance object
     * @return object of CommChannelManager
     */
    static CommChannelManager &GetInstance();

    /**
     * @brief Destroy the Comm Channel Manager object
     */
    ~CommChannelManager() = default;

    /**
     * @brief Get comm channel id
     * @param channel comm channel
     * @param channelPtr comm channel ptr in commChannelMap_
     * @return comm channel id.
     */
    uint32_t GetCommChannelId(const CommChannel &channel, const CommChannel *&channelPtr);

    /**
     * @brief Delete comm channel
     * @param channel comm channel
     * @return FSM_SUCCESS: success, other: failed
     */
    FsmStatus DeleteCommChannel(const CommChannel &channel);

private:
    /**
     * @brief Construct a new Comm Channel Manager object
     */
    CommChannelManager() = default;

    // comm channel map
    std::unordered_map<const CommChannel, uint32_t, CommChannelHash> commChannelMap_;
    // comm channel map mutex
    std::mutex commChannelMapMutex_;
};
}
#endif
